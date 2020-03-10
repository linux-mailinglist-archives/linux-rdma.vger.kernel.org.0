Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD56517F383
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 10:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgCJJ0h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 05:26:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgCJJ0h (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 05:26:37 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB7042467F;
        Tue, 10 Mar 2020 09:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583832396;
        bh=e258Xcp0Uzs52NNyIhMj4JvNoWOlCAgNZUO5ZT7LGCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EblusiOjVNIwbe/ofpsck7fLCM+WKH35hhuxq88Z4jz3ykb5Qg5m4up4wwDK+HY4X
         w/9xeDzD0b78PBWy2rlrvZaYlb8xlt5T/b4imkjD0Vs3q8EDhbYM6bxOT2uSEK6lmx
         wHPfkGMk80mvOWXInHI6fvxdA0DX4KkLTZMdKHfM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 14/15] RDMA/cm: Allow ib_send_cm_sidr_rep() to be done under lock
Date:   Tue, 10 Mar 2020 11:25:44 +0200
Message-Id: <20200310092545.251365-15-leon@kernel.org>
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

The first thing ib_send_cm_sidr_rep() does is obtain the lock, so use the
usual unlocked wrapper, locked actor pattern here.

Get rid of the cm_reject_sidr_req() wrapper so each call site can call the
locked or unlocked version as required.

This avoids a sketchy lock/unlock sequence (which could allow state to
change) during cm_destroy_id().

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 58 +++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index cf7f1f7958c8..f536e20e5394 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -85,6 +85,8 @@ EXPORT_SYMBOL(ibcm_reject_msg);
 struct cm_id_private;
 static void cm_add_one(struct ib_device *device);
 static void cm_remove_one(struct ib_device *device, void *client_data);
+static int cm_send_sidr_rep_locked(struct cm_id_private *cm_id_priv,
+				   struct ib_cm_sidr_rep_param *param);
 static int cm_send_dreq_locked(struct cm_id_private *cm_id_priv,
 			       const void *private_data, u8 private_data_len);
 static int cm_send_drep_locked(struct cm_id_private *cm_id_priv,
@@ -834,16 +836,6 @@ static struct cm_id_private * cm_insert_remote_sidr(struct cm_id_private
 	return NULL;
 }
 
-static void cm_reject_sidr_req(struct cm_id_private *cm_id_priv,
-			       enum ib_cm_sidr_status status)
-{
-	struct ib_cm_sidr_rep_param param;
-
-	memset(&param, 0, sizeof param);
-	param.status = status;
-	ib_send_cm_sidr_rep(&cm_id_priv->id, &param);
-}
-
 static struct cm_id_private *cm_alloc_id_priv(struct ib_device *device,
 					      ib_cm_handler cm_handler,
 					      void *context)
@@ -1062,8 +1054,10 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 		spin_unlock_irq(&cm_id_priv->lock);
 		break;
 	case IB_CM_SIDR_REQ_RCVD:
+		cm_send_sidr_rep_locked(cm_id_priv,
+					&(struct ib_cm_sidr_rep_param){
+						.status = IB_SIDR_REJECT });
 		spin_unlock_irq(&cm_id_priv->lock);
-		cm_reject_sidr_req(cm_id_priv, IB_SIDR_REJECT);
 		break;
 	case IB_CM_REQ_SENT:
 	case IB_CM_MRA_REQ_RCVD:
@@ -3667,7 +3661,9 @@ static int cm_sidr_req_handler(struct cm_work *work)
 					   cm_id_priv->id.service_id);
 	if (!listen_cm_id_priv) {
 		spin_unlock_irq(&cm.lock);
-		cm_reject_sidr_req(cm_id_priv, IB_SIDR_UNSUPPORTED);
+		ib_send_cm_sidr_rep(&cm_id_priv->id,
+				    &(struct ib_cm_sidr_rep_param){
+					    .status = IB_SIDR_UNSUPPORTED });
 		goto out; /* No match. */
 	}
 	refcount_inc(&listen_cm_id_priv->refcount);
@@ -3725,50 +3721,52 @@ static void cm_format_sidr_rep(struct cm_sidr_rep_msg *sidr_rep_msg,
 			    param->private_data, param->private_data_len);
 }
 
-int ib_send_cm_sidr_rep(struct ib_cm_id *cm_id,
-			struct ib_cm_sidr_rep_param *param)
+static int cm_send_sidr_rep_locked(struct cm_id_private *cm_id_priv,
+				   struct ib_cm_sidr_rep_param *param)
 {
-	struct cm_id_private *cm_id_priv;
 	struct ib_mad_send_buf *msg;
-	unsigned long flags;
 	int ret;
 
+	lockdep_assert_held(&cm_id_priv->lock);
+
 	if ((param->info && param->info_length > IB_CM_SIDR_REP_INFO_LENGTH) ||
 	    (param->private_data &&
 	     param->private_data_len > IB_CM_SIDR_REP_PRIVATE_DATA_SIZE))
 		return -EINVAL;
 
-	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
-	spin_lock_irqsave(&cm_id_priv->lock, flags);
-	if (cm_id->state != IB_CM_SIDR_REQ_RCVD) {
-		ret = -EINVAL;
-		goto error;
-	}
+	if (cm_id_priv->id.state != IB_CM_SIDR_REQ_RCVD)
+		return -EINVAL;
 
 	ret = cm_alloc_msg(cm_id_priv, &msg);
 	if (ret)
-		goto error;
+		return ret;
 
 	cm_format_sidr_rep((struct cm_sidr_rep_msg *) msg->mad, cm_id_priv,
 			   param);
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret) {
-		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 		cm_free_msg(msg);
 		return ret;
 	}
-	cm_id->state = IB_CM_IDLE;
-	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
-
-	spin_lock_irqsave(&cm.lock, flags);
+	cm_id_priv->id.state = IB_CM_IDLE;
 	if (!RB_EMPTY_NODE(&cm_id_priv->sidr_id_node)) {
 		rb_erase(&cm_id_priv->sidr_id_node, &cm.remote_sidr_table);
 		RB_CLEAR_NODE(&cm_id_priv->sidr_id_node);
 	}
-	spin_unlock_irqrestore(&cm.lock, flags);
 	return 0;
+}
 
-error:	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+int ib_send_cm_sidr_rep(struct ib_cm_id *cm_id,
+			struct ib_cm_sidr_rep_param *param)
+{
+	struct cm_id_private *cm_id_priv =
+		container_of(cm_id, struct cm_id_private, id);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&cm_id_priv->lock, flags);
+	ret = cm_send_sidr_rep_locked(cm_id_priv, param);
+	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(ib_send_cm_sidr_rep);
-- 
2.24.1

