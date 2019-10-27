Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1C50E6158
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfJ0HIg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:08:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HIg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:08:36 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE54F20578;
        Sun, 27 Oct 2019 07:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160115;
        bh=VeKEmEUSEOgtKXUwBtqvkALxl5EeV8Jj2Jk0h1A4A8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bOnpf/dL93H5NIQ1Y+ZUJJf3m0snBycju+FbmCylGugvpJOFQmVViBv9zok7QbH32
         MQ9AslizmN9ls4BcnjQ+CPlpIFUMezrZGS41mi7SPSIg8YuQ8nYA7vwSAcQiDIKy1V
         bBsHv5n/TmnE/k+/+lBrkDz4r21OrG39FKe21lOc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 37/43] RDMA/cm: Convert REP RNR retry count field
Date:   Sun, 27 Oct 2019 09:06:15 +0200
Message-Id: <20191027070621.11711-38-leon@kernel.org>
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

Convert REP RNR retry count field.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  6 +++---
 drivers/infiniband/core/cm_msgs.h | 12 ------------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 2c99bd99eac3..78d595c1d39b 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2070,7 +2070,7 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 	CM_SET(REP_TARGET_ACK_DELAY, rep_msg,
 	       cm_id_priv->av.port->cm_dev->ack_delay);
 	CM_SET(REP_FAILOVER_ACCEPTED, rep_msg, param->failover_accepted);
-	cm_rep_set_rnr_retry_count(rep_msg, param->rnr_retry_count);
+	CM_SET(REP_RNR_RETRY_COUNT, rep_msg, param->rnr_retry_count);
 	rep_msg->local_ca_guid = cm_id_priv->id.device->node_guid;
 
 	if (cm_id_priv->qp_type != IB_QPT_XRC_TGT) {
@@ -2226,7 +2226,7 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
 	param->target_ack_delay = CM_GET(REP_TARGET_ACK_DELAY, rep_msg);
 	param->failover_accepted = CM_GET(REP_FAILOVER_ACCEPTED, rep_msg);
 	param->flow_control = CM_GET(REP_END_TO_END_FLOW_CONTROL, rep_msg);
-	param->rnr_retry_count = cm_rep_get_rnr_retry_count(rep_msg);
+	param->rnr_retry_count = CM_GET(REP_RNR_RETRY_COUNT, rep_msg);
 	param->srq = cm_rep_get_srq(rep_msg);
 	work->cm_event.private_data = &rep_msg->private_data;
 	work->cm_event.private_data_len = CM_REP_PRIVATE_DATA_SIZE;
@@ -2368,7 +2368,7 @@ static int cm_rep_handler(struct cm_work *work)
 	cm_id_priv->initiator_depth = rep_msg->resp_resources;
 	cm_id_priv->responder_resources = rep_msg->initiator_depth;
 	cm_id_priv->sq_psn = CM_GET(REP_STARTING_PSN, rep_msg);
-	cm_id_priv->rnr_retry_count = cm_rep_get_rnr_retry_count(rep_msg);
+	cm_id_priv->rnr_retry_count = CM_GET(REP_RNR_RETRY_COUNT, rep_msg);
 	cm_id_priv->target_ack_delay = CM_GET(REP_TARGET_ACK_DELAY, rep_msg);
 	cm_id_priv->av.timeout =
 			cm_ack_timeout(cm_id_priv->target_ack_delay,
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index d9b831810dc2..c02bba29a27d 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -462,18 +462,6 @@ struct cm_rep_msg {
 
 } __packed;
 
-static inline u8 cm_rep_get_rnr_retry_count(struct cm_rep_msg *rep_msg)
-{
-	return (u8) (rep_msg->offset27 >> 5);
-}
-
-static inline void cm_rep_set_rnr_retry_count(struct cm_rep_msg *rep_msg,
-					      u8 rnr_retry_count)
-{
-	rep_msg->offset27 = (u8) ((rep_msg->offset27 & 0x1F) |
-				  (rnr_retry_count << 5));
-}
-
 static inline u8 cm_rep_get_srq(struct cm_rep_msg *rep_msg)
 {
 	return (u8) ((rep_msg->offset27 >> 4) & 0x1);
-- 
2.20.1

