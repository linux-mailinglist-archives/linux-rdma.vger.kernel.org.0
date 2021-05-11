Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A0837A214
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 10:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhEKIcj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 04:32:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230473AbhEKIci (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 04:32:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41C706193D;
        Tue, 11 May 2021 08:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721395;
        bh=KRSlpw7GAj/rToMbf95w4v5XrJqIGcof7/1rcJHrlf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VuVwa5QjzwQnG6atHOCTyaqkjV50X8rEfq2lHabDiyanJS+MSSjDbYOpeqeD2ljW+
         KgRTPo7xc0LrqTG6MpqU5pjFeGcQZZPxzI76ETa4ZyTezoa/7zzoCuOaZuFQUt07D3
         Nl8qj/OhhpOgLMB/L9QsOVegvN/+wz4IS8cgp9zTP2OyoaoNZGqJGC505/SgklCfPX
         v4bdVhL5BTj8PWevAosqcOEbmq+MrZeufjd4Wv6JB5jOheCVil2cnRFAKZ67/SXHai
         rYwd/+HdJYjc19H43nOahuN6jSgUewXG/YzK/woQWviXXBaEWxV766FNM+s9TrYmFe
         VGUNnW9KDFjqQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v3 8/8] IB/cm: Protect cm_dev, cm_ports and mad_agent with kref and lock
Date:   Tue, 11 May 2021 11:22:12 +0300
Message-Id: <7ca9e316890a3755abadefdd7fe3fc1dc4a1e79f.1620720467.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620720467.git.leonro@nvidia.com>
References: <cover.1620720467.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

During cm_dev deregistration in cm_remove_one(), the cm_device and
cm_ports will be freed, after that they should not be accessed. The
mad_agent needs to be protected as well.

This patch adds a cm_device kref to protect cm_dev and cm_ports, and
a mad_agent_lock spinlock to protect mad_agent.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c | 112 +++++++++++++++++++++++++++++------
 1 file changed, 93 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 2e4658795e8e..292f1639e8b0 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -205,7 +205,9 @@ struct cm_port {
 };
 
 struct cm_device {
+	struct kref kref;
 	struct list_head list;
+	spinlock_t mad_agent_lock;
 	struct ib_device *ib_device;
 	u8 ack_delay;
 	int going_down;
@@ -287,6 +289,22 @@ struct cm_id_private {
 	struct rdma_ucm_ece ece;
 };
 
+static void cm_dev_release(struct kref *kref)
+{
+	struct cm_device *cm_dev = container_of(kref, struct cm_device, kref);
+	u32 i;
+
+	rdma_for_each_port(cm_dev->ib_device, i)
+		kfree(cm_dev->port[i - 1]);
+
+	kfree(cm_dev);
+}
+
+static void cm_device_put(struct cm_device *cm_dev)
+{
+	kref_put(&cm_dev->kref, cm_dev_release);
+}
+
 static void cm_work_handler(struct work_struct *work);
 
 static inline void cm_deref_id(struct cm_id_private *cm_id_priv)
@@ -301,10 +319,23 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
 	struct ib_mad_send_buf *m;
 	struct ib_ah *ah;
 
+	lockdep_assert_held(&cm_id_priv->lock);
+
+	if (!cm_id_priv->av.port)
+		return ERR_PTR(-EINVAL);
+
+	spin_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
 	mad_agent = cm_id_priv->av.port->mad_agent;
+	if (!mad_agent) {
+		m = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
 	ah = rdma_create_ah(mad_agent->qp->pd, &cm_id_priv->av.ah_attr, 0);
-	if (IS_ERR(ah))
-		return (void *)ah;
+	if (IS_ERR(ah)) {
+		m = ERR_CAST(ah);
+		goto out;
+	}
 
 	m = ib_create_send_mad(mad_agent, cm_id_priv->id.remote_cm_qpn,
 			       cm_id_priv->av.pkey_index,
@@ -313,7 +344,7 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
 			       IB_MGMT_BASE_VERSION);
 	if (IS_ERR(m)) {
 		rdma_destroy_ah(ah, 0);
-		return m;
+		goto out;
 	}
 
 	/* Timeout set by caller if response is expected. */
@@ -322,6 +353,9 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
 
 	refcount_inc(&cm_id_priv->refcount);
 	m->context[0] = cm_id_priv;
+
+out:
+	spin_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
 	return m;
 }
 
@@ -440,10 +474,24 @@ static void cm_set_private_data(struct cm_id_private *cm_id_priv,
 	cm_id_priv->private_data_len = private_data_len;
 }
 
+static void cm_set_av_port(struct cm_av *av, struct cm_port *port)
+{
+	struct cm_port *old_port = av->port;
+
+	if (old_port == port)
+		return;
+
+	av->port = port;
+	if (old_port)
+		cm_device_put(old_port->cm_dev);
+	if (port)
+		kref_get(&port->cm_dev->kref);
+}
+
 static void cm_init_av_for_lap(struct cm_port *port, struct ib_wc *wc,
 			       struct rdma_ah_attr *ah_attr, struct cm_av *av)
 {
-	av->port = port;
+	cm_set_av_port(av, port);
 	av->pkey_index = wc->pkey_index;
 	rdma_move_ah_attr(&av->ah_attr, ah_attr);
 }
@@ -451,7 +499,7 @@ static void cm_init_av_for_lap(struct cm_port *port, struct ib_wc *wc,
 static int cm_init_av_for_response(struct cm_port *port, struct ib_wc *wc,
 				   struct ib_grh *grh, struct cm_av *av)
 {
-	av->port = port;
+	cm_set_av_port(av, port);
 	av->pkey_index = wc->pkey_index;
 	return ib_init_ah_attr_from_wc(port->cm_dev->ib_device,
 				       port->port_num, wc,
@@ -518,7 +566,7 @@ static int cm_init_av_by_path(struct sa_path_rec *path,
 	if (ret)
 		return ret;
 
-	av->port = port;
+	cm_set_av_port(av, port);
 
 	/*
 	 * av->ah_attr might be initialized based on wc or during
@@ -542,7 +590,8 @@ static int cm_init_av_by_path(struct sa_path_rec *path,
 /* Move av created by cm_init_av_by_path(), so av.dgid is not moved */
 static void cm_move_av_from_path(struct cm_av *dest, struct cm_av *src)
 {
-	dest->port = src->port;
+	cm_set_av_port(dest, src->port);
+	cm_set_av_port(src, NULL);
 	dest->pkey_index = src->pkey_index;
 	rdma_move_ah_attr(&dest->ah_attr, &src->ah_attr);
 	dest->timeout = src->timeout;
@@ -551,6 +600,7 @@ static void cm_move_av_from_path(struct cm_av *dest, struct cm_av *src)
 static void cm_destroy_av(struct cm_av *av)
 {
 	rdma_destroy_ah_attr(&av->ah_attr);
+	cm_set_av_port(av, NULL);
 }
 
 static u32 cm_local_id(__be32 local_id)
@@ -1275,10 +1325,18 @@ EXPORT_SYMBOL(ib_cm_insert_listen);
 
 static __be64 cm_form_tid(struct cm_id_private *cm_id_priv)
 {
-	u64 hi_tid, low_tid;
+	u64 hi_tid = 0, low_tid;
+
+	lockdep_assert_held(&cm_id_priv->lock);
+
+	low_tid = (u64)cm_id_priv->id.local_id;
+	if (!cm_id_priv->av.port)
+		return cpu_to_be64(low_tid);
 
-	hi_tid   = ((u64) cm_id_priv->av.port->mad_agent->hi_tid) << 32;
-	low_tid  = (u64)cm_id_priv->id.local_id;
+	spin_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
+	if (cm_id_priv->av.port->mad_agent)
+		hi_tid = ((u64)cm_id_priv->av.port->mad_agent->hi_tid) << 32;
+	spin_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
 	return cpu_to_be64(hi_tid | low_tid);
 }
 
@@ -2139,6 +2197,8 @@ static int cm_req_handler(struct cm_work *work)
 		sa_path_set_dmac(&work->path[0],
 				 cm_id_priv->av.ah_attr.roce.dmac);
 	work->path[0].hop_limit = grh->hop_limit;
+
+	cm_destroy_av(&cm_id_priv->av);
 	ret = cm_init_av_by_path(&work->path[0], gid_attr, &cm_id_priv->av);
 	if (ret) {
 		int err;
@@ -4090,7 +4150,8 @@ static int cm_init_qp_init_attr(struct cm_id_private *cm_id_priv,
 			qp_attr->qp_access_flags |= IB_ACCESS_REMOTE_READ |
 						    IB_ACCESS_REMOTE_ATOMIC;
 		qp_attr->pkey_index = cm_id_priv->av.pkey_index;
-		qp_attr->port_num = cm_id_priv->av.port->port_num;
+		if (cm_id_priv->av.port)
+			qp_attr->port_num = cm_id_priv->av.port->port_num;
 		ret = 0;
 		break;
 	default:
@@ -4132,7 +4193,8 @@ static int cm_init_qp_rtr_attr(struct cm_id_private *cm_id_priv,
 					cm_id_priv->responder_resources;
 			qp_attr->min_rnr_timer = 0;
 		}
-		if (rdma_ah_get_dlid(&cm_id_priv->alt_av.ah_attr)) {
+		if (rdma_ah_get_dlid(&cm_id_priv->alt_av.ah_attr) &&
+		    cm_id_priv->alt_av.port) {
 			*qp_attr_mask |= IB_QP_ALT_PATH;
 			qp_attr->alt_port_num = cm_id_priv->alt_av.port->port_num;
 			qp_attr->alt_pkey_index = cm_id_priv->alt_av.pkey_index;
@@ -4193,7 +4255,9 @@ static int cm_init_qp_rts_attr(struct cm_id_private *cm_id_priv,
 			}
 		} else {
 			*qp_attr_mask = IB_QP_ALT_PATH | IB_QP_PATH_MIG_STATE;
-			qp_attr->alt_port_num = cm_id_priv->alt_av.port->port_num;
+			if (cm_id_priv->alt_av.port)
+				qp_attr->alt_port_num =
+					cm_id_priv->alt_av.port->port_num;
 			qp_attr->alt_pkey_index = cm_id_priv->alt_av.pkey_index;
 			qp_attr->alt_timeout = cm_id_priv->alt_av.timeout;
 			qp_attr->alt_ah_attr = cm_id_priv->alt_av.ah_attr;
@@ -4311,6 +4375,8 @@ static int cm_add_one(struct ib_device *ib_device)
 	if (!cm_dev)
 		return -ENOMEM;
 
+	kref_init(&cm_dev->kref);
+	spin_lock_init(&cm_dev->mad_agent_lock);
 	cm_dev->ib_device = ib_device;
 	cm_dev->ack_delay = ib_device->attrs.local_ca_ack_delay;
 	cm_dev->going_down = 0;
@@ -4373,7 +4439,6 @@ static int cm_add_one(struct ib_device *ib_device)
 error1:
 	port_modify.set_port_cap_mask = 0;
 	port_modify.clr_port_cap_mask = IB_PORT_CM_SUP;
-	kfree(port);
 	while (--i) {
 		if (!rdma_cap_ib_cm(ib_device, i))
 			continue;
@@ -4382,10 +4447,9 @@ static int cm_add_one(struct ib_device *ib_device)
 		ib_modify_port(ib_device, port->port_num, 0, &port_modify);
 		ib_unregister_mad_agent(port->mad_agent);
 		cm_remove_port_fs(port);
-		kfree(port);
 	}
 free:
-	kfree(cm_dev);
+	cm_device_put(cm_dev);
 	return ret;
 }
 
@@ -4408,10 +4472,13 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
 	spin_unlock_irq(&cm.lock);
 
 	rdma_for_each_port (ib_device, i) {
+		struct ib_mad_agent *mad_agent;
+
 		if (!rdma_cap_ib_cm(ib_device, i))
 			continue;
 
 		port = cm_dev->port[i-1];
+		mad_agent = port->mad_agent;
 		ib_modify_port(ib_device, port->port_num, 0, &port_modify);
 		/*
 		 * We flush the queue here after the going_down set, this
@@ -4419,12 +4486,19 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
 		 * after that we can call the unregister_mad_agent
 		 */
 		flush_workqueue(cm.wq);
-		ib_unregister_mad_agent(port->mad_agent);
+		/*
+		 * The above ensures no call paths from the work are running,
+		 * the remaining paths all take the unregistration lock
+		 */
+		spin_lock(&cm_dev->mad_agent_lock);
+		port->mad_agent = NULL;
+		spin_unlock(&cm_dev->mad_agent_lock);
+		ib_unregister_mad_agent(mad_agent);
 		cm_remove_port_fs(port);
-		kfree(port);
 	}
 
-	kfree(cm_dev);
+	/* All touches can only be on call path from the work */
+	cm_device_put(cm_dev);
 }
 
 static int __init ib_cm_init(void)
-- 
2.31.1

