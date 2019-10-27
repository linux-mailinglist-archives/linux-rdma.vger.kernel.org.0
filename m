Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15C5EE6154
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfJ0HIW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:08:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HIW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:08:22 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 835D520578;
        Sun, 27 Oct 2019 07:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160101;
        bh=h5Kc2pvtY+Hxet/oucskAyvMNMCUfiwzJDjfnYcph9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DEVelCG9b9d+nBOygT3l/6j3I2afdLIO7T8YlGdifP0jXc8j1pgl5H8KVRz57H+ql
         cQLMsHcvG+G2rpoiGTVbWIjE5KMjMOABQO9upi6b3itdNi540rMKdIxPISBRehZmyY
         9+HS2PsSxQYtpv5qLsC1XR+DYNsJpuGJZ6i6A6ok=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 33/43] RDMA/cm: Update REJ struct to use new scheme
Date:   Sun, 27 Oct 2019 09:06:11 +0200
Message-Id: <20191027070621.11711-34-leon@kernel.org>
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

Convert both message rejected and rejected info length fields.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      | 18 +++++++++---------
 drivers/infiniband/core/cm_msgs.h | 21 ---------------------
 2 files changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 903bacb92a22..af32d1e68b11 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1501,11 +1501,11 @@ static int cm_issue_rej(struct cm_port *port,
 	cm_format_mad_hdr(&rej_msg->hdr, CM_REJ_ATTR_ID, rcv_msg->hdr.tid);
 	rej_msg->remote_comm_id = rcv_msg->local_comm_id;
 	rej_msg->local_comm_id = rcv_msg->remote_comm_id;
-	cm_rej_set_msg_rejected(rej_msg, msg_rejected);
+	CM_SET(REJ_MESSAGE_REJECTED, rej_msg, msg_rejected);
 	rej_msg->reason = cpu_to_be16(reason);
 
 	if (ari && ari_length) {
-		cm_rej_set_reject_info_len(rej_msg, ari_length);
+		CM_SET(REJ_REJECTED_INFO_LENGTH, rej_msg, ari_length);
 		memcpy(rej_msg->ari, ari, ari_length);
 	}
 
@@ -1768,26 +1768,26 @@ static void cm_format_rej(struct cm_rej_msg *rej_msg,
 	switch(cm_id_priv->id.state) {
 	case IB_CM_REQ_RCVD:
 		rej_msg->local_comm_id = 0;
-		cm_rej_set_msg_rejected(rej_msg, CM_MSG_RESPONSE_REQ);
+		CM_SET(REJ_MESSAGE_REJECTED, rej_msg, CM_MSG_RESPONSE_REQ);
 		break;
 	case IB_CM_MRA_REQ_SENT:
 		rej_msg->local_comm_id = cm_id_priv->id.local_id;
-		cm_rej_set_msg_rejected(rej_msg, CM_MSG_RESPONSE_REQ);
+		CM_SET(REJ_MESSAGE_REJECTED, rej_msg, CM_MSG_RESPONSE_REQ);
 		break;
 	case IB_CM_REP_RCVD:
 	case IB_CM_MRA_REP_SENT:
 		rej_msg->local_comm_id = cm_id_priv->id.local_id;
-		cm_rej_set_msg_rejected(rej_msg, CM_MSG_RESPONSE_REP);
+		CM_SET(REJ_MESSAGE_REJECTED, rej_msg, CM_MSG_RESPONSE_REP);
 		break;
 	default:
 		rej_msg->local_comm_id = cm_id_priv->id.local_id;
-		cm_rej_set_msg_rejected(rej_msg, CM_MSG_RESPONSE_OTHER);
+		CM_SET(REJ_MESSAGE_REJECTED, rej_msg, CM_MSG_RESPONSE_OTHER);
 		break;
 	}
 
 	rej_msg->reason = cpu_to_be16(reason);
 	if (ari && ari_length) {
-		cm_rej_set_reject_info_len(rej_msg, ari_length);
+		CM_SET(REJ_REJECTED_INFO_LENGTH, rej_msg, ari_length);
 		memcpy(rej_msg->ari, ari, ari_length);
 	}
 
@@ -2815,7 +2815,7 @@ static void cm_format_rej_event(struct cm_work *work)
 	rej_msg = (struct cm_rej_msg *)work->mad_recv_wc->recv_buf.mad;
 	param = &work->cm_event.param.rej_rcvd;
 	param->ari = rej_msg->ari;
-	param->ari_length = cm_rej_get_reject_info_len(rej_msg);
+	param->ari_length = CM_GET(REJ_REJECTED_INFO_LENGTH, rej_msg);
 	param->reason = __be16_to_cpu(rej_msg->reason);
 	work->cm_event.private_data = &rej_msg->private_data;
 	work->cm_event.private_data_len = CM_REJ_PRIVATE_DATA_SIZE;
@@ -2846,7 +2846,7 @@ static struct cm_id_private * cm_acquire_rejected_id(struct cm_rej_msg *rej_msg)
 				cm_id_priv = NULL;
 		}
 		spin_unlock_irq(&cm.lock);
-	} else if (cm_rej_get_msg_rejected(rej_msg) == CM_MSG_RESPONSE_REQ)
+	} else if (CM_GET(REJ_MESSAGE_REJECTED, rej_msg) == CM_MSG_RESPONSE_REQ)
 		cm_id_priv = cm_acquire_id(rej_msg->remote_comm_id, 0);
 	else
 		cm_id_priv = cm_acquire_id(rej_msg->remote_comm_id, remote_id);
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 96a27876d2ae..6dc1a1086820 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -437,27 +437,6 @@ struct cm_rej_msg {
 
 } __packed;
 
-static inline u8 cm_rej_get_msg_rejected(struct cm_rej_msg *rej_msg)
-{
-	return (u8) (rej_msg->offset8 >> 6);
-}
-
-static inline void cm_rej_set_msg_rejected(struct cm_rej_msg *rej_msg, u8 msg)
-{
-	rej_msg->offset8 = (u8) ((rej_msg->offset8 & 0x3F) | (msg << 6));
-}
-
-static inline u8 cm_rej_get_reject_info_len(struct cm_rej_msg *rej_msg)
-{
-	return (u8) (rej_msg->offset9 >> 1);
-}
-
-static inline void cm_rej_set_reject_info_len(struct cm_rej_msg *rej_msg,
-					      u8 len)
-{
-	rej_msg->offset9 = (u8) ((rej_msg->offset9 & 0x1) | (len << 1));
-}
-
 struct cm_rep_msg {
 	struct ib_mad_hdr hdr;
 
-- 
2.20.1

