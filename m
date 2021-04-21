Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90AE366A06
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Apr 2021 13:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbhDULlk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Apr 2021 07:41:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237751AbhDULlj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Apr 2021 07:41:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0943961447;
        Wed, 21 Apr 2021 11:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619005266;
        bh=0f34IxEQ8lDbd0jTWYoMXJp10dEIEgZ2695c4S1pNU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ej8qWHloLiJ5sfa6VvtAb1w7UUo+jTzyrPcX4brW/+TUBHzGxoanauIZ3Ci0aKyTx
         ilW395FEaa7TIIYv2pD28/SEz1iJ7qjI6OljOYVJgXhO0QHKiiTqUpDn4OJU7YUAbT
         72o5jDZTFymUatFanyUZBS9UNDMgCMh6+xX3I/uzA2WDEiS5YPW92meomFq4gL4qqr
         SkoCb3smfxT5tDtPWIAXpLcQwyELkBnQbR0J6p2u9NZ/urLsQienbWf43mY0d1E9jM
         igoVaco1I/dN3NDiqwXPJY/YnjvUzZOUhZLaTd1QHpAkeaL1MqNrcG8DtkOxW5deYp
         M6fEtwZ9/sU3g==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 7/9] IB/cm: Clear all associated AV's ports when remove a cm device
Date:   Wed, 21 Apr 2021 14:40:37 +0300
Message-Id: <00c97755c41b06af84f621a1b3e0e8adfe0771cc.1619004798.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619004798.git.leonro@nvidia.com>
References: <cover.1619004798.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

When remove a cm device all ports are removed as well, so all AV's ports
need to be cleared.
This patch adds a cm_id_priv list for each cm_device; For a cm_id when
initializing it's primary AV it is added to this list, so when
removing the device all cm_id's on this list will be removed from this
list and have its av->port and alt_av->port pointer cleared.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c | 75 ++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 2d62c90f9790..f1a24492924f 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -209,6 +209,7 @@ struct cm_device {
 	struct ib_device *ib_device;
 	u8 ack_delay;
 	int going_down;
+	struct list_head cm_id_priv_list;
 	struct cm_port *port[];
 };
 
@@ -285,6 +286,8 @@ struct cm_id_private {
 	atomic_t work_count;
 
 	struct rdma_ucm_ece ece;
+
+	struct list_head cm_dev_list;
 };
 
 static void cm_work_handler(struct work_struct *work);
@@ -440,9 +443,28 @@ static void cm_set_private_data(struct cm_id_private *cm_id_priv,
 	cm_id_priv->private_data_len = private_data_len;
 }
 
+static void add_cm_id_to_cm_dev_list(struct cm_id_private *cm_id_priv,
+				     struct cm_device *cm_dev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&cm.lock, flags);
+	if (cm_dev->going_down)
+		goto out;
+
+	if (!list_empty(&cm_id_priv->cm_dev_list))
+		list_del(&cm_id_priv->cm_dev_list);
+	list_add_tail(&cm_id_priv->cm_dev_list, &cm_dev->cm_id_priv_list);
+
+out:
+	spin_unlock_irqrestore(&cm.lock, flags);
+}
+
 static int cm_init_av_for_lap(struct cm_port *port, struct ib_wc *wc,
-			      struct ib_grh *grh, struct cm_av *av)
+			      struct ib_grh *grh,
+			      struct cm_id_private *cm_id_priv)
 {
+	struct cm_av *av = &cm_id_priv->av;
 	struct rdma_ah_attr new_ah_attr;
 	int ret;
 
@@ -462,14 +484,20 @@ static int cm_init_av_for_lap(struct cm_port *port, struct ib_wc *wc,
 	if (ret)
 		return ret;
 
+	add_cm_id_to_cm_dev_list(cm_id_priv, port->cm_dev);
+
 	rdma_move_ah_attr(&av->ah_attr, &new_ah_attr);
 	return 0;
 }
 
 static int cm_init_av_for_response(struct cm_port *port, struct ib_wc *wc,
-				   struct ib_grh *grh, struct cm_av *av)
+				   struct ib_grh *grh,
+				   struct cm_id_private *cm_id_priv)
 {
+	struct cm_av *av = &cm_id_priv->av;
+
 	av->port = port;
+	add_cm_id_to_cm_dev_list(cm_id_priv, port->cm_dev);
 	av->pkey_index = wc->pkey_index;
 	return ib_init_ah_attr_from_wc(port->cm_dev->ib_device,
 				       port->port_num, wc,
@@ -519,11 +547,13 @@ get_cm_port_from_path(struct sa_path_rec *path, const struct ib_gid_attr *attr)
 
 static int cm_init_av_by_path(struct sa_path_rec *path,
 			      const struct ib_gid_attr *sgid_attr,
-			      struct cm_av *av)
+			      struct cm_id_private *cm_id_priv,
+			      bool is_priv_av)
 {
 	struct rdma_ah_attr new_ah_attr;
 	struct cm_device *cm_dev;
 	struct cm_port *port;
+	struct cm_av *av;
 	int ret;
 
 	port = get_cm_port_from_path(path, sgid_attr);
@@ -531,6 +561,11 @@ static int cm_init_av_by_path(struct sa_path_rec *path,
 		return -EINVAL;
 	cm_dev = port->cm_dev;
 
+	if (!is_priv_av && cm_dev != cm_id_priv->av.port->cm_dev)
+		return -EINVAL;
+
+	av = is_priv_av ? &cm_id_priv->av : &cm_id_priv->alt_av;
+
 	ret = ib_find_cached_pkey(cm_dev->ib_device, port->port_num,
 				  be16_to_cpu(path->pkey), &av->pkey_index);
 	if (ret)
@@ -554,6 +589,9 @@ static int cm_init_av_by_path(struct sa_path_rec *path,
 
 	av->timeout = path->packet_life_time + 1;
 	rdma_move_ah_attr(&av->ah_attr, &new_ah_attr);
+	if (is_priv_av)
+		add_cm_id_to_cm_dev_list(cm_id_priv, cm_dev);
+
 	return 0;
 }
 
@@ -832,6 +870,7 @@ static struct cm_id_private *cm_alloc_id_priv(struct ib_device *device,
 	spin_lock_init(&cm_id_priv->lock);
 	init_completion(&cm_id_priv->comp);
 	INIT_LIST_HEAD(&cm_id_priv->work_list);
+	INIT_LIST_HEAD(&cm_id_priv->cm_dev_list);
 	atomic_set(&cm_id_priv->work_count, -1);
 	refcount_set(&cm_id_priv->refcount, 1);
 
@@ -1133,6 +1172,8 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 		cm_id_priv->timewait_info = NULL;
 	}
 
+	if (!list_empty(&cm_id_priv->cm_dev_list))
+		list_del(&cm_id_priv->cm_dev_list);
 	WARN_ON(cm_id_priv->listen_sharecount);
 	WARN_ON(!RB_EMPTY_NODE(&cm_id_priv->service_node));
 	if (!RB_EMPTY_NODE(&cm_id_priv->sidr_id_node))
@@ -1500,12 +1541,12 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
 	}
 
 	ret = cm_init_av_by_path(param->primary_path,
-				 param->ppath_sgid_attr, &cm_id_priv->av);
+				 param->ppath_sgid_attr, cm_id_priv, true);
 	if (ret)
 		goto out;
 	if (param->alternate_path) {
 		ret = cm_init_av_by_path(param->alternate_path, NULL,
-					 &cm_id_priv->alt_av);
+					 cm_id_priv, false);
 		if (ret)
 			goto out;
 	}
@@ -2083,7 +2124,7 @@ static int cm_req_handler(struct cm_work *work)
 
 	ret = cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
 				      work->mad_recv_wc->recv_buf.grh,
-				      &cm_id_priv->av);
+				      cm_id_priv);
 	if (ret)
 		goto destroy;
 	cm_id_priv->timewait_info = cm_create_timewait_info(cm_id_priv->
@@ -2137,7 +2178,7 @@ static int cm_req_handler(struct cm_work *work)
 		sa_path_set_dmac(&work->path[0],
 				 cm_id_priv->av.ah_attr.roce.dmac);
 	work->path[0].hop_limit = grh->hop_limit;
-	ret = cm_init_av_by_path(&work->path[0], gid_attr, &cm_id_priv->av);
+	ret = cm_init_av_by_path(&work->path[0], gid_attr, cm_id_priv, true);
 	if (ret) {
 		int err;
 
@@ -2156,7 +2197,7 @@ static int cm_req_handler(struct cm_work *work)
 	}
 	if (cm_req_has_alt_path(req_msg)) {
 		ret = cm_init_av_by_path(&work->path[1], NULL,
-					 &cm_id_priv->alt_av);
+					 cm_id_priv, false);
 		if (ret) {
 			ib_send_cm_rej(&cm_id_priv->id,
 				       IB_CM_REJ_INVALID_ALT_GID,
@@ -3328,12 +3369,12 @@ static int cm_lap_handler(struct cm_work *work)
 
 	ret = cm_init_av_for_lap(work->port, work->mad_recv_wc->wc,
 				 work->mad_recv_wc->recv_buf.grh,
-				 &cm_id_priv->av);
+				 cm_id_priv);
 	if (ret)
 		goto unlock;
 
 	ret = cm_init_av_by_path(param->alternate_path, NULL,
-				 &cm_id_priv->alt_av);
+				 cm_id_priv, false);
 	if (ret)
 		goto unlock;
 
@@ -3452,7 +3493,7 @@ int ib_send_cm_sidr_req(struct ib_cm_id *cm_id,
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
 	ret = cm_init_av_by_path(param->path, param->sgid_attr,
-				 &cm_id_priv->av);
+				 cm_id_priv, true);
 	if (ret)
 		return ret;
 
@@ -3542,7 +3583,7 @@ static int cm_sidr_req_handler(struct cm_work *work)
 	cm_id_priv->av.dgid.global.interface_id = 0;
 	ret = cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
 				      work->mad_recv_wc->recv_buf.grh,
-				      &cm_id_priv->av);
+				      cm_id_priv);
 	if (ret)
 		goto out;
 
@@ -4303,6 +4344,7 @@ static int cm_add_one(struct ib_device *ib_device)
 	cm_dev->ib_device = ib_device;
 	cm_dev->ack_delay = ib_device->attrs.local_ca_ack_delay;
 	cm_dev->going_down = 0;
+	INIT_LIST_HEAD(&cm_dev->cm_id_priv_list);
 
 	set_bit(IB_MGMT_METHOD_SEND, reg_req.method_mask);
 	rdma_for_each_port (ib_device, i) {
@@ -4381,6 +4423,7 @@ static int cm_add_one(struct ib_device *ib_device)
 static void cm_remove_one(struct ib_device *ib_device, void *client_data)
 {
 	struct cm_device *cm_dev = client_data;
+	struct cm_id_private *cm_id_priv, *tmp;
 	struct cm_port *port;
 	struct ib_port_modify port_modify = {
 		.clr_port_cap_mask = IB_PORT_CM_SUP
@@ -4396,6 +4439,14 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
 	cm_dev->going_down = 1;
 	spin_unlock_irq(&cm.lock);
 
+	list_for_each_entry_safe(cm_id_priv, tmp,
+				 &cm_dev->cm_id_priv_list, cm_dev_list) {
+		if (!list_empty(&cm_id_priv->cm_dev_list))
+			list_del(&cm_id_priv->cm_dev_list);
+		cm_id_priv->av.port = NULL;
+		cm_id_priv->alt_av.port = NULL;
+	}
+
 	rdma_for_each_port (ib_device, i) {
 		if (!rdma_cap_ib_cm(ib_device, i))
 			continue;
-- 
2.30.2

