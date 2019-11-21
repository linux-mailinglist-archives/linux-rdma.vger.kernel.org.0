Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A04A105947
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 19:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfKUSPg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 13:15:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbfKUSPf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 13:15:35 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88BC02068E;
        Thu, 21 Nov 2019 18:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574360135;
        bh=JXQIJ2oCpQsbwB0JVKwGvo3FKo2KbuW+hghl+Yumujw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pKgJzFcLu0P0H/dAwtTP4tj5mDPuhqfisC14Mzb8bm53UndUxgNlqbf7/IPaVlAv9
         Xj7/AQsB+hFPo4AStExOUH3NocAW+nBpCaDcM7fLaLjrT0dkNT/28Bbe3BaqybXOPa
         ck2kA3fUoNJmT1gTQ6x980lTAmH27Zz5Mx9e0/pk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v1 40/48] RDMA/cm: Convert REP RNR retry count field
Date:   Thu, 21 Nov 2019 20:13:05 +0200
Message-Id: <20191121181313.129430-41-leon@kernel.org>
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

Convert REP RNR retry count field.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  6 +++---
 drivers/infiniband/core/cm_msgs.h | 12 ------------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 4c27465df6a1..77199078d276 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2070,7 +2070,7 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 	IBA_SET(CM_REP_TARGET_ACK_DELAY, rep_msg,
 	       cm_id_priv->av.port->cm_dev->ack_delay);
 	IBA_SET(CM_REP_FAILOVER_ACCEPTED, rep_msg, param->failover_accepted);
-	cm_rep_set_rnr_retry_count(rep_msg, param->rnr_retry_count);
+	IBA_SET(CM_REP_RNR_RETRY_COUNT, rep_msg, param->rnr_retry_count);
 	rep_msg->local_ca_guid = cm_id_priv->id.device->node_guid;
 
 	if (cm_id_priv->qp_type != IB_QPT_XRC_TGT) {
@@ -2229,7 +2229,7 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
 	param->target_ack_delay = IBA_GET(CM_REP_TARGET_ACK_DELAY, rep_msg);
 	param->failover_accepted = IBA_GET(CM_REP_FAILOVER_ACCEPTED, rep_msg);
 	param->flow_control = IBA_GET(CM_REP_END_TO_END_FLOW_CONTROL, rep_msg);
-	param->rnr_retry_count = cm_rep_get_rnr_retry_count(rep_msg);
+	param->rnr_retry_count = IBA_GET(CM_REP_RNR_RETRY_COUNT, rep_msg);
 	param->srq = cm_rep_get_srq(rep_msg);
 	work->cm_event.private_data = &rep_msg->private_data;
 	work->cm_event.private_data_len = CM_REP_PRIVATE_DATA_SIZE;
@@ -2371,7 +2371,7 @@ static int cm_rep_handler(struct cm_work *work)
 	cm_id_priv->initiator_depth = rep_msg->resp_resources;
 	cm_id_priv->responder_resources = rep_msg->initiator_depth;
 	cm_id_priv->sq_psn = IBA_GET(CM_REP_STARTING_PSN, rep_msg);
-	cm_id_priv->rnr_retry_count = cm_rep_get_rnr_retry_count(rep_msg);
+	cm_id_priv->rnr_retry_count = IBA_GET(CM_REP_RNR_RETRY_COUNT, rep_msg);
 	cm_id_priv->target_ack_delay = IBA_GET(CM_REP_TARGET_ACK_DELAY, rep_msg);
 	cm_id_priv->av.timeout =
 			cm_ack_timeout(cm_id_priv->target_ack_delay,
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 953f6a9f868b..209e19197693 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -132,18 +132,6 @@ struct cm_rep_msg {
 
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

