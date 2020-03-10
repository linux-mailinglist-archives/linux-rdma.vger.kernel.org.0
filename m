Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB02117F380
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 10:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgCJJ02 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 05:26:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgCJJ02 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 05:26:28 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A66BE2051A;
        Tue, 10 Mar 2020 09:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583832387;
        bh=+MS/w29HY+28/tqDRl2e0tvEkxMlrdogBx0+QfAWnxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yJvsjfCB6Bg/HpeF1ycFFGp2OcQWld9UD0Ef+1zVo85ZZmTfUa+zeTNKe+z9t21w1
         P80nFMoCvT6dBvtcdByul9dGc9b6AyHMwOTF6CbeyKjjKPlBSaz4nfGQwgRA+NZorC
         iF2akL40zgyjQkoiPx2Fgpz4elCxh7yXPuVVWbKY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 13/15] RDMA/cm: Allow ib_send_cm_rej() to be done under lock
Date:   Tue, 10 Mar 2020 11:25:43 +0200
Message-Id: <20200310092545.251365-14-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310092545.251365-1-leon@kernel.org>
References: <20200310092545.251365-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

The first thing ib_send_cm_rej() does is obtain the lock, so use the usual
unlocked wrapper, locked actor pattern here.

This avoids a sketchy lock/unlock sequence (which could allow state to
change) during cm_destroy_id().

While here simplify some of the logic in the implementation.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 92 ++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 40 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 2d3b661153a4..cf7f1f7958c8 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -89,6 +89,10 @@ static int cm_send_dreq_locked(struct cm_id_private *cm_id_priv,
 			       const void *private_data, u8 private_data_len);
 static int cm_send_drep_locked(struct cm_id_private *cm_id_priv,
 			       void *private_data, u8 private_data_len);
+static int cm_send_rej_locked(struct cm_id_private *cm_id_priv,
+			      enum ib_cm_rej_reason reason, void *ari,
+			      u8 ari_length, const void *private_data,
+			      u8 private_data_len);
 
 static struct ib_client cm_client = {
 	.name   = "cm",
@@ -1064,11 +1068,11 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 	case IB_CM_REQ_SENT:
 	case IB_CM_MRA_REQ_RCVD:
 		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+		cm_send_rej_locked(cm_id_priv, IB_CM_REJ_TIMEOUT,
+				   &cm_id_priv->id.device->node_guid,
+				   sizeof(cm_id_priv->id.device->node_guid),
+				   NULL, 0);
 		spin_unlock_irq(&cm_id_priv->lock);
-		ib_send_cm_rej(cm_id, IB_CM_REJ_TIMEOUT,
-			       &cm_id_priv->id.device->node_guid,
-			       sizeof cm_id_priv->id.device->node_guid,
-			       NULL, 0);
 		break;
 	case IB_CM_REQ_RCVD:
 		if (err == -ENOMEM) {
@@ -1076,9 +1080,10 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 			cm_reset_to_idle(cm_id_priv);
 			spin_unlock_irq(&cm_id_priv->lock);
 		} else {
+			cm_send_rej_locked(cm_id_priv,
+					   IB_CM_REJ_CONSUMER_DEFINED, NULL, 0,
+					   NULL, 0);
 			spin_unlock_irq(&cm_id_priv->lock);
-			ib_send_cm_rej(cm_id, IB_CM_REJ_CONSUMER_DEFINED,
-				       NULL, 0, NULL, 0);
 		}
 		break;
 	case IB_CM_REP_SENT:
@@ -1088,9 +1093,9 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 	case IB_CM_MRA_REQ_SENT:
 	case IB_CM_REP_RCVD:
 	case IB_CM_MRA_REP_SENT:
+		cm_send_rej_locked(cm_id_priv, IB_CM_REJ_CONSUMER_DEFINED, NULL,
+				   0, NULL, 0);
 		spin_unlock_irq(&cm_id_priv->lock);
-		ib_send_cm_rej(cm_id, IB_CM_REJ_CONSUMER_DEFINED,
-			       NULL, 0, NULL, 0);
 		break;
 	case IB_CM_ESTABLISHED:
 		if (cm_id_priv->qp_type == IB_QPT_XRC_TGT) {
@@ -2926,65 +2931,72 @@ static int cm_drep_handler(struct cm_work *work)
 	return -EINVAL;
 }
 
-int ib_send_cm_rej(struct ib_cm_id *cm_id,
-		   enum ib_cm_rej_reason reason,
-		   void *ari,
-		   u8 ari_length,
-		   const void *private_data,
-		   u8 private_data_len)
+static int cm_send_rej_locked(struct cm_id_private *cm_id_priv,
+			      enum ib_cm_rej_reason reason, void *ari,
+			      u8 ari_length, const void *private_data,
+			      u8 private_data_len)
 {
-	struct cm_id_private *cm_id_priv;
 	struct ib_mad_send_buf *msg;
-	unsigned long flags;
 	int ret;
 
+	lockdep_assert_held(&cm_id_priv->lock);
+
 	if ((private_data && private_data_len > IB_CM_REJ_PRIVATE_DATA_SIZE) ||
 	    (ari && ari_length > IB_CM_REJ_ARI_LENGTH))
 		return -EINVAL;
 
-	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
-
-	spin_lock_irqsave(&cm_id_priv->lock, flags);
-	switch (cm_id->state) {
+	switch (cm_id_priv->id.state) {
 	case IB_CM_REQ_SENT:
 	case IB_CM_MRA_REQ_RCVD:
 	case IB_CM_REQ_RCVD:
 	case IB_CM_MRA_REQ_SENT:
 	case IB_CM_REP_RCVD:
 	case IB_CM_MRA_REP_SENT:
-		ret = cm_alloc_msg(cm_id_priv, &msg);
-		if (!ret)
-			cm_format_rej((struct cm_rej_msg *) msg->mad,
-				      cm_id_priv, reason, ari, ari_length,
-				      private_data, private_data_len);
-
 		cm_reset_to_idle(cm_id_priv);
+		ret = cm_alloc_msg(cm_id_priv, &msg);
+		if (ret)
+			return ret;
+		cm_format_rej((struct cm_rej_msg *)msg->mad, cm_id_priv, reason,
+			      ari, ari_length, private_data, private_data_len);
 		break;
 	case IB_CM_REP_SENT:
 	case IB_CM_MRA_REP_RCVD:
-		ret = cm_alloc_msg(cm_id_priv, &msg);
-		if (!ret)
-			cm_format_rej((struct cm_rej_msg *) msg->mad,
-				      cm_id_priv, reason, ari, ari_length,
-				      private_data, private_data_len);
-
 		cm_enter_timewait(cm_id_priv);
+		ret = cm_alloc_msg(cm_id_priv, &msg);
+		if (ret)
+			return ret;
+		cm_format_rej((struct cm_rej_msg *)msg->mad, cm_id_priv, reason,
+			      ari, ari_length, private_data, private_data_len);
 		break;
 	default:
 		pr_debug("%s: local_id %d, cm_id->state: %d\n", __func__,
-			 be32_to_cpu(cm_id_priv->id.local_id), cm_id->state);
-		ret = -EINVAL;
-		goto out;
+			 be32_to_cpu(cm_id_priv->id.local_id),
+			 cm_id_priv->id.state);
+		return -EINVAL;
 	}
 
-	if (ret)
-		goto out;
-
 	ret = ib_post_send_mad(msg, NULL);
-	if (ret)
+	if (ret) {
 		cm_free_msg(msg);
+		return ret;
+	}
 
-out:	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+	return 0;
+}
+
+int ib_send_cm_rej(struct ib_cm_id *cm_id, enum ib_cm_rej_reason reason,
+		   void *ari, u8 ari_length, const void *private_data,
+		   u8 private_data_len)
+{
+	struct cm_id_private *cm_id_priv =
+		container_of(cm_id, struct cm_id_private, id);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&cm_id_priv->lock, flags);
+	ret = cm_send_rej_locked(cm_id_priv, reason, ari, ari_length,
+				 private_data, private_data_len);
+	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(ib_send_cm_rej);
-- 
2.24.1

