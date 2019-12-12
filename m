Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBFF211C990
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfLLJkd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:40:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728436AbfLLJkc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:40:32 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36DA12173E;
        Thu, 12 Dec 2019 09:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143631;
        bh=FYbyjNmRJcPdpW6QCBFPkr05UzOgxiF9ti6C8xJ35zI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1at52LV4fRKzZyiAV0LTOy6uc3j5phnFqj8TEpWjc7r0JyLJRrSt1yPLK2WC3O5ZH
         F9aVAoccD2cgLnxD9VFugYJk+VaDWmpjhO7jlQ60o5ONeHzo37J0W2QwQb5oQZRpG9
         HUVa0WjsWveiq3RYHIAKSO6JyxJjPutwkzJzEeoo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 36/48] RDMA/cm: Update REJ struct to use new scheme
Date:   Thu, 12 Dec 2019 11:38:18 +0200
Message-Id: <20191212093830.316934-37-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212093830.316934-1-leon@kernel.org>
References: <20191212093830.316934-1-leon@kernel.org>
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
index a5fc328d6d23..b69611c088b8 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1501,11 +1501,11 @@ static int cm_issue_rej(struct cm_port *port,
 	cm_format_mad_hdr(&rej_msg->hdr, CM_REJ_ATTR_ID, rcv_msg->hdr.tid);
 	rej_msg->remote_comm_id = rcv_msg->local_comm_id;
 	rej_msg->local_comm_id = rcv_msg->remote_comm_id;
-	cm_rej_set_msg_rejected(rej_msg, msg_rejected);
+	IBA_SET(CM_REJ_MESSAGE_REJECTED, rej_msg, msg_rejected);
 	rej_msg->reason = cpu_to_be16(reason);
 
 	if (ari && ari_length) {
-		cm_rej_set_reject_info_len(rej_msg, ari_length);
+		IBA_SET(CM_REJ_REJECTED_INFO_LENGTH, rej_msg, ari_length);
 		memcpy(rej_msg->ari, ari, ari_length);
 	}
 
@@ -1768,26 +1768,26 @@ static void cm_format_rej(struct cm_rej_msg *rej_msg,
 	switch(cm_id_priv->id.state) {
 	case IB_CM_REQ_RCVD:
 		rej_msg->local_comm_id = 0;
-		cm_rej_set_msg_rejected(rej_msg, CM_MSG_RESPONSE_REQ);
+		IBA_SET(CM_REJ_MESSAGE_REJECTED, rej_msg, CM_MSG_RESPONSE_REQ);
 		break;
 	case IB_CM_MRA_REQ_SENT:
 		rej_msg->local_comm_id = cm_id_priv->id.local_id;
-		cm_rej_set_msg_rejected(rej_msg, CM_MSG_RESPONSE_REQ);
+		IBA_SET(CM_REJ_MESSAGE_REJECTED, rej_msg, CM_MSG_RESPONSE_REQ);
 		break;
 	case IB_CM_REP_RCVD:
 	case IB_CM_MRA_REP_SENT:
 		rej_msg->local_comm_id = cm_id_priv->id.local_id;
-		cm_rej_set_msg_rejected(rej_msg, CM_MSG_RESPONSE_REP);
+		IBA_SET(CM_REJ_MESSAGE_REJECTED, rej_msg, CM_MSG_RESPONSE_REP);
 		break;
 	default:
 		rej_msg->local_comm_id = cm_id_priv->id.local_id;
-		cm_rej_set_msg_rejected(rej_msg, CM_MSG_RESPONSE_OTHER);
+		IBA_SET(CM_REJ_MESSAGE_REJECTED, rej_msg, CM_MSG_RESPONSE_OTHER);
 		break;
 	}
 
 	rej_msg->reason = cpu_to_be16(reason);
 	if (ari && ari_length) {
-		cm_rej_set_reject_info_len(rej_msg, ari_length);
+		IBA_SET(CM_REJ_REJECTED_INFO_LENGTH, rej_msg, ari_length);
 		memcpy(rej_msg->ari, ari, ari_length);
 	}
 
@@ -2818,7 +2818,7 @@ static void cm_format_rej_event(struct cm_work *work)
 	rej_msg = (struct cm_rej_msg *)work->mad_recv_wc->recv_buf.mad;
 	param = &work->cm_event.param.rej_rcvd;
 	param->ari = rej_msg->ari;
-	param->ari_length = cm_rej_get_reject_info_len(rej_msg);
+	param->ari_length = IBA_GET(CM_REJ_REJECTED_INFO_LENGTH, rej_msg);
 	param->reason = __be16_to_cpu(rej_msg->reason);
 	work->cm_event.private_data = &rej_msg->private_data;
 	work->cm_event.private_data_len = CM_REJ_PRIVATE_DATA_SIZE;
@@ -2849,7 +2849,7 @@ static struct cm_id_private * cm_acquire_rejected_id(struct cm_rej_msg *rej_msg)
 				cm_id_priv = NULL;
 		}
 		spin_unlock_irq(&cm.lock);
-	} else if (cm_rej_get_msg_rejected(rej_msg) == CM_MSG_RESPONSE_REQ)
+	} else if (IBA_GET(CM_REJ_MESSAGE_REJECTED, rej_msg) == CM_MSG_RESPONSE_REQ)
 		cm_id_priv = cm_acquire_id(rej_msg->remote_comm_id, 0);
 	else
 		cm_id_priv = cm_acquire_id(rej_msg->remote_comm_id, remote_id);
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 601b0fd2c86c..5a76b63dde12 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -107,27 +107,6 @@ struct cm_rej_msg {
 
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

