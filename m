Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137113402AE
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Mar 2021 11:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhCRKDs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Mar 2021 06:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230012AbhCRKD0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Mar 2021 06:03:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAF2C64F30;
        Thu, 18 Mar 2021 10:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616061806;
        bh=unGI9ThGYiphQeJzneWH6neUUF/VHYr3MdzUAuYHEao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TOzgf8AENWg6eq8AmuYiHEqLaOFhsyU7Wp9icUC2lsiyOLV+ke2tWii3zeNgGhlg+
         yxa8YWGCSPpBcwYlQHpQEw57ZLoWDbHuGZJK4ovOO1sVBh+6Hxh1giZNII/I3VNSi7
         Ag/RmJvZIAzBvfiNltUw3VLNQvk7aWrzNHLvxJbfVKlECcwO+VHtmiiW+VhkCheSi3
         QbfYOQNJrMNpQuIwRDxiMcI6ZWhqAZKXzZo0wWJ8je+UYg+4duhF/5n2zHukrHjL1D
         qI3DV8smPvNZ4UP4DErmPposrXy+TH4e0qoAqov0VEBnGpDqJZsdkNnMhvpiuVK116
         0aCwYj0/FgUZw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 4/6] IB/cm: Clear all associated AV's ports when remove a cm device
Date:   Thu, 18 Mar 2021 12:03:07 +0200
Message-Id: <20210318100309.670344-5-leon@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318100309.670344-1-leon@kernel.org>
References: <20210318100309.670344-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

When removed a cm device all ports are removed as well, so all AV's ports
needs to be cleared.
This patch adds a cm_id_priv list for each cm_devices; For a cm_id when
it's primary AV is initialized it is added to this list, so when removing
the device all cm_id's on this list will be removed from this list and
have its av->port and alt_av->port pointer cleared.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c | 75 ++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index d481ebd281e1..964b7a98ad5e 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -209,6 +209,7 @@ struct cm_device {
 	struct ib_device *ib_device;
 	u8 ack_delay;
 	int going_down;
+	struct list_head cm_id_priv_list;
 	struct cm_port *port[];
 };
 
@@ -284,6 +285,8 @@ struct cm_id_private {
 	atomic_t work_count;
 
 	struct rdma_ucm_ece ece;
+
+	struct list_head cm_dev_list;
 };
 
 static void cm_work_handler(struct work_struct *work);
@@ -405,9 +408,28 @@ static void cm_set_private_data(struct cm_id_private *cm_id_priv,
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
 
@@ -427,14 +449,20 @@ static int cm_init_av_for_lap(struct cm_port *port, struct ib_wc *wc,
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
@@ -484,11 +512,13 @@ get_cm_port_from_path(struct sa_path_rec *path, const struct ib_gid_attr *attr)
 
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
@@ -496,6 +526,11 @@ static int cm_init_av_by_path(struct sa_path_rec *path,
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
@@ -519,6 +554,9 @@ static int cm_init_av_by_path(struct sa_path_rec *path,
 
 	av->timeout = path->packet_life_time + 1;
 	rdma_move_ah_attr(&av->ah_attr, &new_ah_attr);
+	if (is_priv_av)
+		add_cm_id_to_cm_dev_list(cm_id_priv, cm_dev);
+
 	return 0;
 }
 
@@ -797,6 +835,7 @@ static struct cm_id_private *cm_alloc_id_priv(struct ib_device *device,
 	spin_lock_init(&cm_id_priv->lock);
 	init_completion(&cm_id_priv->comp);
 	INIT_LIST_HEAD(&cm_id_priv->work_list);
+	INIT_LIST_HEAD(&cm_id_priv->cm_dev_list);
 	atomic_set(&cm_id_priv->work_count, -1);
 	refcount_set(&cm_id_priv->refcount, 1);
 
@@ -1098,6 +1137,8 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 		cm_id_priv->timewait_info = NULL;
 	}
 
+	if (!list_empty(&cm_id_priv->cm_dev_list))
+		list_del(&cm_id_priv->cm_dev_list);
 	WARN_ON(cm_id_priv->listen_sharecount);
 	WARN_ON(!RB_EMPTY_NODE(&cm_id_priv->service_node));
 	if (!RB_EMPTY_NODE(&cm_id_priv->sidr_id_node))
@@ -1464,12 +1505,12 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
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
@@ -2044,7 +2085,7 @@ static int cm_req_handler(struct cm_work *work)
 
 	ret = cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
 				      work->mad_recv_wc->recv_buf.grh,
-				      &cm_id_priv->av);
+				      cm_id_priv);
 	if (ret)
 		goto destroy;
 	cm_id_priv->timewait_info = cm_create_timewait_info(cm_id_priv->
@@ -2101,7 +2142,7 @@ static int cm_req_handler(struct cm_work *work)
 		sa_path_set_dmac(&work->path[0],
 				 cm_id_priv->av.ah_attr.roce.dmac);
 	work->path[0].hop_limit = grh->hop_limit;
-	ret = cm_init_av_by_path(&work->path[0], gid_attr, &cm_id_priv->av);
+	ret = cm_init_av_by_path(&work->path[0], gid_attr, cm_id_priv, true);
 	if (ret) {
 		int err;
 
@@ -2120,7 +2161,7 @@ static int cm_req_handler(struct cm_work *work)
 	}
 	if (cm_req_has_alt_path(req_msg)) {
 		ret = cm_init_av_by_path(&work->path[1], NULL,
-					 &cm_id_priv->alt_av);
+					 cm_id_priv, false);
 		if (ret) {
 			ib_send_cm_rej(&cm_id_priv->id,
 				       IB_CM_REJ_INVALID_ALT_GID,
@@ -3288,12 +3329,12 @@ static int cm_lap_handler(struct cm_work *work)
 
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
 
@@ -3413,7 +3454,7 @@ int ib_send_cm_sidr_req(struct ib_cm_id *cm_id,
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
 	ret = cm_init_av_by_path(param->path, param->sgid_attr,
-				 &cm_id_priv->av);
+				 cm_id_priv, true);
 	if (ret)
 		goto out;
 
@@ -3500,7 +3541,7 @@ static int cm_sidr_req_handler(struct cm_work *work)
 	cm_id_priv->av.dgid.global.interface_id = 0;
 	ret = cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
 				      work->mad_recv_wc->recv_buf.grh,
-				      &cm_id_priv->av);
+				      cm_id_priv);
 	if (ret)
 		goto out;
 
@@ -4280,6 +4321,7 @@ static int cm_add_one(struct ib_device *ib_device)
 	cm_dev->ib_device = ib_device;
 	cm_dev->ack_delay = ib_device->attrs.local_ca_ack_delay;
 	cm_dev->going_down = 0;
+	INIT_LIST_HEAD(&cm_dev->cm_id_priv_list);
 
 	set_bit(IB_MGMT_METHOD_SEND, reg_req.method_mask);
 	rdma_for_each_port (ib_device, i) {
@@ -4358,6 +4400,7 @@ static int cm_add_one(struct ib_device *ib_device)
 static void cm_remove_one(struct ib_device *ib_device, void *client_data)
 {
 	struct cm_device *cm_dev = client_data;
+	struct cm_id_private *cm_id_priv, *tmp;
 	struct cm_port *port;
 	struct ib_port_modify port_modify = {
 		.clr_port_cap_mask = IB_PORT_CM_SUP
@@ -4373,6 +4416,14 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
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

