Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D539BE6152
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfJ0HIP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:08:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HIP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:08:15 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84CAC20578;
        Sun, 27 Oct 2019 07:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160094;
        bh=34jYWmEhvvKSPjTq5/etdx3pP8u6HOVzTCOJzRSxQaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r6+votCgbe6wQmoCydEmICOfZsmMJvhxomFldi3O9fIDtv+WjyhFdLAalJfoNjYXO
         wPUbzlvWIv2JGq5lHh5gK+0ztUA7hCgX0EIZ7NDdCjjEUMsZiX6uoTMQXkbi/u6FNy
         RmfXJA0J/MjcAiq+4425VW7HM632SZk5tp4ltOQY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 31/43] RDMA/cm: Convert MRA MRAed field
Date:   Sun, 27 Oct 2019 09:06:09 +0200
Message-Id: <20191027070621.11711-32-leon@kernel.org>
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

Convert MRA MRAed field.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      | 11 ++++++-----
 drivers/infiniband/core/cm_msgs.h | 10 ----------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index cb4b16a47e00..11502ab48d35 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1745,7 +1745,7 @@ static void cm_format_mra(struct cm_mra_msg *mra_msg,
 			  const void *private_data, u8 private_data_len)
 {
 	cm_format_mad_hdr(&mra_msg->hdr, CM_MRA_ATTR_ID, cm_id_priv->tid);
-	cm_mra_set_msg_mraed(mra_msg, msg_mraed);
+	CM_SET(MRA_MESSAGE_MRAED, mra_msg, msg_mraed);
 	mra_msg->local_comm_id = cm_id_priv->id.local_id;
 	mra_msg->remote_comm_id = cm_id_priv->id.remote_id;
 	cm_mra_set_service_timeout(mra_msg, service_timeout);
@@ -3007,7 +3007,7 @@ EXPORT_SYMBOL(ib_send_cm_mra);
 
 static struct cm_id_private * cm_acquire_mraed_id(struct cm_mra_msg *mra_msg)
 {
-	switch (cm_mra_get_msg_mraed(mra_msg)) {
+	switch (CM_GET(MRA_MESSAGE_MRAED, mra_msg)) {
 	case CM_MSG_RESPONSE_REQ:
 		return cm_acquire_id(mra_msg->remote_comm_id, 0);
 	case CM_MSG_RESPONSE_REP:
@@ -3040,21 +3040,22 @@ static int cm_mra_handler(struct cm_work *work)
 	spin_lock_irq(&cm_id_priv->lock);
 	switch (cm_id_priv->id.state) {
 	case IB_CM_REQ_SENT:
-		if (cm_mra_get_msg_mraed(mra_msg) != CM_MSG_RESPONSE_REQ ||
+		if (CM_GET(MRA_MESSAGE_MRAED, mra_msg) != CM_MSG_RESPONSE_REQ ||
 		    ib_modify_mad(cm_id_priv->av.port->mad_agent,
 				  cm_id_priv->msg, timeout))
 			goto out;
 		cm_id_priv->id.state = IB_CM_MRA_REQ_RCVD;
 		break;
 	case IB_CM_REP_SENT:
-		if (cm_mra_get_msg_mraed(mra_msg) != CM_MSG_RESPONSE_REP ||
+		if (CM_GET(MRA_MESSAGE_MRAED, mra_msg) != CM_MSG_RESPONSE_REP ||
 		    ib_modify_mad(cm_id_priv->av.port->mad_agent,
 				  cm_id_priv->msg, timeout))
 			goto out;
 		cm_id_priv->id.state = IB_CM_MRA_REP_RCVD;
 		break;
 	case IB_CM_ESTABLISHED:
-		if (cm_mra_get_msg_mraed(mra_msg) != CM_MSG_RESPONSE_OTHER ||
+		if (CM_GET(MRA_MESSAGE_MRAED, mra_msg) !=
+			    CM_MSG_RESPONSE_OTHER ||
 		    cm_id_priv->id.lap_state != IB_CM_LAP_SENT ||
 		    ib_modify_mad(cm_id_priv->av.port->mad_agent,
 				  cm_id_priv->msg, timeout)) {
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 8a7c0a910618..bf94c3dc391e 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -421,16 +421,6 @@ enum cm_msg_response {
 
 } __packed;
 
-static inline u8 cm_mra_get_msg_mraed(struct cm_mra_msg *mra_msg)
-{
-	return (u8) (mra_msg->offset8 >> 6);
-}
-
-static inline void cm_mra_set_msg_mraed(struct cm_mra_msg *mra_msg, u8 msg)
-{
-	mra_msg->offset8 = (u8) ((mra_msg->offset8 & 0x3F) | (msg << 6));
-}
-
 static inline u8 cm_mra_get_service_timeout(struct cm_mra_msg *mra_msg)
 {
 	return (u8) (mra_msg->offset9 >> 3);
-- 
2.20.1

