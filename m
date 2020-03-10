Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDF917F37E
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 10:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgCJJ0Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 05:26:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgCJJ0Y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 05:26:24 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9391E2467F;
        Tue, 10 Mar 2020 09:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583832384;
        bh=T0O7+01SQikJ7yiwaQQyO5CBxm6vlMqtyGvyzyulOhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OeG2C4VQqt6pE66eeTfrAsIFjNbJwmiD6yzQx/IEm6WzcndZel349cJMhnzbCYZ12
         RX6qCKvOyj/5PPSMDwiOotVE1ACSKiVcJ9bKhj5/m3yk1y/q4V9MjY1AJSa7vdDsPm
         oGjTS9SpbOnsWLKdp4jocI+RWJ932lmMhYmuGbsM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 12/15] RDMA/cm: Allow ib_send_cm_drep() to be done under lock
Date:   Tue, 10 Mar 2020 11:25:42 +0200
Message-Id: <20200310092545.251365-13-leon@kernel.org>
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

The first thing ib_send_cm_drep() does is obtain the lock, so use the
usual unlocked wrapper, locked actor pattern here.

This avoids a sketchy lock/unlock sequence (which could allow state to
change) during cm_destroy_id().

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 55 +++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index dd99387d0839..2d3b661153a4 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -87,6 +87,8 @@ static void cm_add_one(struct ib_device *device);
 static void cm_remove_one(struct ib_device *device, void *client_data);
 static int cm_send_dreq_locked(struct cm_id_private *cm_id_priv,
 			       const void *private_data, u8 private_data_len);
+static int cm_send_drep_locked(struct cm_id_private *cm_id_priv,
+			       void *private_data, u8 private_data_len);
 
 static struct ib_client cm_client = {
 	.name   = "cm",
@@ -1104,8 +1106,8 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 		spin_unlock_irq(&cm_id_priv->lock);
 		break;
 	case IB_CM_DREQ_RCVD:
+		cm_send_drep_locked(cm_id_priv, NULL, 0);
 		spin_unlock_irq(&cm_id_priv->lock);
-		ib_send_cm_drep(cm_id, NULL, 0);
 		break;
 	default:
 		spin_unlock_irq(&cm_id_priv->lock);
@@ -2712,51 +2714,60 @@ static void cm_format_drep(struct cm_drep_msg *drep_msg,
 			    private_data_len);
 }
 
-int ib_send_cm_drep(struct ib_cm_id *cm_id,
-		    const void *private_data,
-		    u8 private_data_len)
+static int cm_send_drep_locked(struct cm_id_private *cm_id_priv,
+			       void *private_data, u8 private_data_len)
 {
-	struct cm_id_private *cm_id_priv;
 	struct ib_mad_send_buf *msg;
-	unsigned long flags;
-	void *data;
 	int ret;
 
+	lockdep_assert_held(&cm_id_priv->lock);
+
 	if (private_data && private_data_len > IB_CM_DREP_PRIVATE_DATA_SIZE)
 		return -EINVAL;
 
-	data = cm_copy_private_data(private_data, private_data_len);
-	if (IS_ERR(data))
-		return PTR_ERR(data);
-
-	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
-	spin_lock_irqsave(&cm_id_priv->lock, flags);
-	if (cm_id->state != IB_CM_DREQ_RCVD) {
-		pr_debug("%s: local_id %d, cm_idcm_id->state(%d) != IB_CM_DREQ_RCVD\n",
-			 __func__, be32_to_cpu(cm_id->local_id), cm_id->state);
-		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
-		kfree(data);
+	if (cm_id_priv->id.state != IB_CM_DREQ_RCVD) {
+		pr_debug(
+			"%s: local_id %d, cm_idcm_id->state(%d) != IB_CM_DREQ_RCVD\n",
+			__func__, be32_to_cpu(cm_id_priv->id.local_id),
+			cm_id_priv->id.state);
+		kfree(private_data);
 		return -EINVAL;
 	}
 
-	cm_set_private_data(cm_id_priv, data, private_data_len);
+	cm_set_private_data(cm_id_priv, private_data, private_data_len);
 	cm_enter_timewait(cm_id_priv);
 
 	ret = cm_alloc_msg(cm_id_priv, &msg);
 	if (ret)
-		goto out;
+		return ret;
 
 	cm_format_drep((struct cm_drep_msg *) msg->mad, cm_id_priv,
 		       private_data, private_data_len);
 
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret) {
-		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 		cm_free_msg(msg);
 		return ret;
 	}
+	return 0;
+}
 
-out:	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+int ib_send_cm_drep(struct ib_cm_id *cm_id, const void *private_data,
+		    u8 private_data_len)
+{
+	struct cm_id_private *cm_id_priv =
+		container_of(cm_id, struct cm_id_private, id);
+	unsigned long flags;
+	void *data;
+	int ret;
+
+	data = cm_copy_private_data(private_data, private_data_len);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	spin_lock_irqsave(&cm_id_priv->lock, flags);
+	ret = cm_send_drep_locked(cm_id_priv, data, private_data_len);
+	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(ib_send_cm_drep);
-- 
2.24.1

