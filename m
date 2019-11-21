Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C15AD105951
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 19:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfKUSP5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 13:15:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:54472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727187AbfKUSP5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 13:15:57 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96C5B206CC;
        Thu, 21 Nov 2019 18:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574360156;
        bh=DJ8/kJXIvWG+Zf8Z/2F02cp8ZNsgRgljaw3PwouWbGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPQTDwC4G7IFN6YBteZY1tR38mJ9i3o/Jsqj1rhi86YssNPh0lt3GxN/fwh8MMn/m
         tWgqONRl0iYH6ztgTN8SkUMfgoP4TLPDZk7eukU8d1+DftCS9oGLTY53oGdCirfLrB
         rIEIKwnCjpoHWkim662xIYFDjrxallMclh9wLlWg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v1 39/48] RDMA/cm: Convert REP flow control field
Date:   Thu, 21 Nov 2019 20:13:04 +0200
Message-Id: <20191121181313.129430-40-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121181313.129430-1-leon@kernel.org>
References: <20191121181313.129430-1-leon@kernel.org>
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
index 23e2c54d51dd..4c27465df6a1 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2075,7 +2075,8 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 
 	if (cm_id_priv->qp_type != IB_QPT_XRC_TGT) {
 		rep_msg->initiator_depth = param->initiator_depth;
-		cm_rep_set_flow_ctrl(rep_msg, param->flow_control);
+		IBA_SET(CM_REP_END_TO_END_FLOW_CONTROL, rep_msg,
+		       param->flow_control);
 		cm_rep_set_srq(rep_msg, param->srq);
 		IBA_SET(CM_REP_LOCAL_QPN, rep_msg, param->qp_num);
 	} else {
@@ -2227,7 +2228,7 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
 	param->initiator_depth = rep_msg->resp_resources;
 	param->target_ack_delay = IBA_GET(CM_REP_TARGET_ACK_DELAY, rep_msg);
 	param->failover_accepted = IBA_GET(CM_REP_FAILOVER_ACCEPTED, rep_msg);
-	param->flow_control = cm_rep_get_flow_ctrl(rep_msg);
+	param->flow_control = IBA_GET(CM_REP_END_TO_END_FLOW_CONTROL, rep_msg);
 	param->rnr_retry_count = cm_rep_get_rnr_retry_count(rep_msg);
 	param->srq = cm_rep_get_srq(rep_msg);
 	work->cm_event.private_data = &rep_msg->private_data;
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 566bc868e120..953f6a9f868b 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -132,18 +132,6 @@ struct cm_rep_msg {
 
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

