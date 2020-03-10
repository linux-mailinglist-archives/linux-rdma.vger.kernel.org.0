Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A10B517F37D
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 10:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCJJ0W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 05:26:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgCJJ0V (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 05:26:21 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 846BB2051A;
        Tue, 10 Mar 2020 09:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583832381;
        bh=tGkqDX1o2kXoK1V85AcvmmV8OML86PyI1AH1YWdRK/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dN3h/8fKA3NZ8Vw/Mm9yIVyqjt3M/HXACSOQAXL3dNPkvJXGJxRIlA6Pu6Fj+iIrG
         0sLG61qvBS3RukOQRe/ML6Gf6e6/ZmAhs1AX2euj9e3fybv4sRbNYQfgLuznK51kUR
         E22kT8v2s+SsdEAfIjdeWad19obf9ti99I9dEHHc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 11/15] RDMA/cm: Allow ib_send_cm_dreq() to be done under lock
Date:   Tue, 10 Mar 2020 11:25:41 +0200
Message-Id: <20200310092545.251365-12-leon@kernel.org>
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

The first thing ib_send_cm_dreq() does is obtain the lock, so use the
usual unlocked wrapper, locked actor pattern here.

This avoids a sketchy lock/unlock sequence (which could allow state to
change) during cm_destroy_id().

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 54 +++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 84679f16a923..dd99387d0839 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -82,8 +82,11 @@ const char *__attribute_const__ ibcm_reject_msg(int reason)
 }
 EXPORT_SYMBOL(ibcm_reject_msg);
 
+struct cm_id_private;
 static void cm_add_one(struct ib_device *device);
 static void cm_remove_one(struct ib_device *device, void *client_data);
+static int cm_send_dreq_locked(struct cm_id_private *cm_id_priv,
+			       const void *private_data, u8 private_data_len);
 
 static struct ib_client cm_client = {
 	.name   = "cm",
@@ -1088,10 +1091,12 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 			       NULL, 0, NULL, 0);
 		break;
 	case IB_CM_ESTABLISHED:
-		spin_unlock_irq(&cm_id_priv->lock);
-		if (cm_id_priv->qp_type == IB_QPT_XRC_TGT)
+		if (cm_id_priv->qp_type == IB_QPT_XRC_TGT) {
+			spin_unlock_irq(&cm_id_priv->lock);
 			break;
-		ib_send_cm_dreq(cm_id, NULL, 0);
+		}
+		cm_send_dreq_locked(cm_id_priv, NULL, 0);
+		spin_unlock_irq(&cm_id_priv->lock);
 		goto retest;
 	case IB_CM_DREQ_SENT:
 		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
@@ -2631,35 +2636,32 @@ static void cm_format_dreq(struct cm_dreq_msg *dreq_msg,
 			    private_data_len);
 }
 
-int ib_send_cm_dreq(struct ib_cm_id *cm_id,
-		    const void *private_data,
-		    u8 private_data_len)
+static int cm_send_dreq_locked(struct cm_id_private *cm_id_priv,
+			       const void *private_data, u8 private_data_len)
 {
-	struct cm_id_private *cm_id_priv;
 	struct ib_mad_send_buf *msg;
-	unsigned long flags;
 	int ret;
 
+	lockdep_assert_held(&cm_id_priv->lock);
+
 	if (private_data && private_data_len > IB_CM_DREQ_PRIVATE_DATA_SIZE)
 		return -EINVAL;
 
-	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
-	spin_lock_irqsave(&cm_id_priv->lock, flags);
-	if (cm_id->state != IB_CM_ESTABLISHED) {
+	if (cm_id_priv->id.state != IB_CM_ESTABLISHED) {
 		pr_debug("%s: local_id %d, cm_id->state: %d\n", __func__,
-			 be32_to_cpu(cm_id->local_id), cm_id->state);
-		ret = -EINVAL;
-		goto out;
+			 be32_to_cpu(cm_id_priv->id.local_id),
+			 cm_id_priv->id.state);
+		return -EINVAL;
 	}
 
-	if (cm_id->lap_state == IB_CM_LAP_SENT ||
-	    cm_id->lap_state == IB_CM_MRA_LAP_RCVD)
+	if (cm_id_priv->id.lap_state == IB_CM_LAP_SENT ||
+	    cm_id_priv->id.lap_state == IB_CM_MRA_LAP_RCVD)
 		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
 
 	ret = cm_alloc_msg(cm_id_priv, &msg);
 	if (ret) {
 		cm_enter_timewait(cm_id_priv);
-		goto out;
+		return ret;
 	}
 
 	cm_format_dreq((struct cm_dreq_msg *) msg->mad, cm_id_priv,
@@ -2670,14 +2672,26 @@ int ib_send_cm_dreq(struct ib_cm_id *cm_id,
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret) {
 		cm_enter_timewait(cm_id_priv);
-		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 		cm_free_msg(msg);
 		return ret;
 	}
 
-	cm_id->state = IB_CM_DREQ_SENT;
+	cm_id_priv->id.state = IB_CM_DREQ_SENT;
 	cm_id_priv->msg = msg;
-out:	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+	return 0;
+}
+
+int ib_send_cm_dreq(struct ib_cm_id *cm_id, const void *private_data,
+		    u8 private_data_len)
+{
+	struct cm_id_private *cm_id_priv =
+		container_of(cm_id, struct cm_id_private, id);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&cm_id_priv->lock, flags);
+	ret = cm_send_dreq_locked(cm_id_priv, private_data, private_data_len);
+	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(ib_send_cm_dreq);
-- 
2.24.1

