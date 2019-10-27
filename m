Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05B39E6157
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfJ0HIc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:08:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HIc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:08:32 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31C9120578;
        Sun, 27 Oct 2019 07:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160111;
        bh=cHwPamzrQw+d3StvXR+8cgONXzv5W8kZHI45iRufR1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WXZXwVtRHa+lH4KD5j8shsSm8tRkcZMT7daIJso1kvYLEMqWVQ/hVbVLweKNYNUzh
         6QjzplEJ/bwRbXp7A7veTc+17vsOpUetqHg86O3KEV5lrgK126h/G0SHm/ogzn8u3t
         HlKf7SI/79FALVhM3i1Cv0evi4OM5VEzWxMGPgZI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 36/43] RDMA/cm: Convert REP flow control field
Date:   Sun, 27 Oct 2019 09:06:14 +0200
Message-Id: <20191027070621.11711-37-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191027070621.11711-1-leon@kernel.org>
References: <20191027070621.11711-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Convert REP flow control field.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  5 +++--
 drivers/infiniband/core/cm_msgs.h | 12 ------------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 4b1f90ba4ec9..2c99bd99eac3 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2075,7 +2075,8 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 
 	if (cm_id_priv->qp_type != IB_QPT_XRC_TGT) {
 		rep_msg->initiator_depth = param->initiator_depth;
-		cm_rep_set_flow_ctrl(rep_msg, param->flow_control);
+		CM_SET(REP_END_TO_END_FLOW_CONTROL, rep_msg,
+		       param->flow_control);
 		cm_rep_set_srq(rep_msg, param->srq);
 		CM_SET(REP_LOCAL_QPN, rep_msg, param->qp_num);
 	} else {
@@ -2224,7 +2225,7 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
 	param->initiator_depth = rep_msg->resp_resources;
 	param->target_ack_delay = CM_GET(REP_TARGET_ACK_DELAY, rep_msg);
 	param->failover_accepted = CM_GET(REP_FAILOVER_ACCEPTED, rep_msg);
-	param->flow_control = cm_rep_get_flow_ctrl(rep_msg);
+	param->flow_control = CM_GET(REP_END_TO_END_FLOW_CONTROL, rep_msg);
 	param->rnr_retry_count = cm_rep_get_rnr_retry_count(rep_msg);
 	param->srq = cm_rep_get_srq(rep_msg);
 	work->cm_event.private_data = &rep_msg->private_data;
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index fdc3cd9d2f88..d9b831810dc2 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -462,18 +462,6 @@ struct cm_rep_msg {
 
 } __packed;
 
-static inline u8 cm_rep_get_flow_ctrl(struct cm_rep_msg *rep_msg)
-{
-	return (u8) (rep_msg->offset26 & 0x01);
-}
-
-static inline void cm_rep_set_flow_ctrl(struct cm_rep_msg *rep_msg,
-					    u8 flow_ctrl)
-{
-	rep_msg->offset26 = (u8) ((rep_msg->offset26 & 0xFE) |
-				  (flow_ctrl & 0x1));
-}
-
 static inline u8 cm_rep_get_rnr_retry_count(struct cm_rep_msg *rep_msg)
 {
 	return (u8) (rep_msg->offset27 >> 5);
-- 
2.20.1

