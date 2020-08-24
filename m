Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BC124FBC7
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 12:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgHXKou (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 06:44:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgHXKoo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Aug 2020 06:44:44 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BCB1207D3;
        Mon, 24 Aug 2020 10:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598265882;
        bh=95DPIgqHlmxKazWnShcUshHueehwyGG5l4EBbpcE1e4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EX0ILsKgr883KXyJ82K+8M3H/OyquuHLPLuUBl8r/3SQJ6lKt/tYhCzY2NUQ5ovnD
         GnBS7MYVdk5otE4IFEp72ZFSGKX9U0nVO7jyaXQ7gAESp3CsEdQhKPLEKB6AChKSiZ
         ar7/Ag/eBSj2F9IK9qUSAgQlZp3HL3Lqy54b4vGQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 07/14] RDMA/cma: Be strict with attaching to CMA device
Date:   Mon, 24 Aug 2020 13:44:08 +0300
Message-Id: <20200824104415.1090901-8-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824104415.1090901-1-leon@kernel.org>
References: <20200824104415.1090901-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The RDMA-CM code wasn't consistent in flows that attached to cma_dev,
this caused to situations where failure during attach to listen on such
device leave RDMA-CM in non-consistent state.

Update the listen/attach flow to correctly deal with failures.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c | 197 ++++++++++++++++++++--------------
 1 file changed, 114 insertions(+), 83 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 7e3451fe8309..613c204ad749 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -458,8 +458,8 @@ static int cma_igmp_send(struct net_device *ndev, union ib_gid *mgid, bool join)
 	return (in_dev) ? 0 : -ENODEV;
 }
 
-static void _cma_attach_to_dev(struct rdma_id_private *id_priv,
-			       struct cma_device *cma_dev)
+static int _cma_attach_to_dev(struct rdma_id_private *id_priv,
+			      struct cma_device *cma_dev)
 {
 	cma_dev_get(cma_dev);
 	id_priv->cma_dev = cma_dev;
@@ -475,15 +475,22 @@ static void _cma_attach_to_dev(struct rdma_id_private *id_priv,
 	rdma_restrack_add(&id_priv->res);
 
 	trace_cm_id_attach(id_priv, cma_dev->device);
+	return 0;
 }
 
-static void cma_attach_to_dev(struct rdma_id_private *id_priv,
-			      struct cma_device *cma_dev)
+static int cma_attach_to_dev(struct rdma_id_private *id_priv,
+			     struct cma_device *cma_dev)
 {
-	_cma_attach_to_dev(id_priv, cma_dev);
+	int ret;
+
+	ret = _cma_attach_to_dev(id_priv, cma_dev);
+	if (ret)
+		return ret;
+
 	id_priv->gid_type =
 		cma_dev->default_gid_type[id_priv->id.port_num -
 					  rdma_start_port(cma_dev->device)];
+	return 0;
 }
 
 static inline void release_mc(struct kref *kref)
@@ -656,8 +663,7 @@ static int cma_acquire_dev_by_src_ip(struct rdma_id_private *id_priv)
 			if (!IS_ERR(sgid_attr)) {
 				id_priv->id.port_num = port;
 				cma_bind_sgid_attr(id_priv, sgid_attr);
-				cma_attach_to_dev(id_priv, cma_dev);
-				ret = 0;
+				ret = cma_attach_to_dev(id_priv, cma_dev);
 				goto out;
 			}
 		}
@@ -686,6 +692,7 @@ static int cma_ib_acquire_dev(struct rdma_id_private *id_priv,
 	const struct ib_gid_attr *sgid_attr;
 	enum ib_gid_type gid_type;
 	union ib_gid gid;
+	int ret;
 
 	if (dev_addr->dev_type != ARPHRD_INFINIBAND &&
 	    id_priv->id.ps == RDMA_PS_IPOIB)
@@ -711,9 +718,9 @@ static int cma_ib_acquire_dev(struct rdma_id_private *id_priv,
 	 * cma_process_remove().
 	 */
 	mutex_lock(&lock);
-	cma_attach_to_dev(id_priv, listen_id_priv->cma_dev);
+	ret = cma_attach_to_dev(id_priv, listen_id_priv->cma_dev);
 	mutex_unlock(&lock);
-	return 0;
+	return ret;
 }
 
 static int cma_iw_acquire_dev(struct rdma_id_private *id_priv,
@@ -768,7 +775,7 @@ static int cma_iw_acquire_dev(struct rdma_id_private *id_priv,
 
 out:
 	if (!ret)
-		cma_attach_to_dev(id_priv, cma_dev);
+		ret = cma_attach_to_dev(id_priv, cma_dev);
 
 	mutex_unlock(&lock);
 	return ret;
@@ -785,7 +792,7 @@ static int cma_resolve_ib_dev(struct rdma_id_private *id_priv)
 	unsigned int p;
 	u16 pkey, index;
 	enum ib_port_state port_state;
-	int i;
+	int i, ret;
 
 	cma_dev = NULL;
 	addr = (struct sockaddr_ib *) cma_dst_addr(id_priv);
@@ -828,8 +835,10 @@ static int cma_resolve_ib_dev(struct rdma_id_private *id_priv)
 	return -ENODEV;
 
 found:
-	cma_attach_to_dev(id_priv, cma_dev);
+	ret = cma_attach_to_dev(id_priv, cma_dev);
 	mutex_unlock(&lock);
+	if (ret)
+		return ret;
 	addr = (struct sockaddr_ib *)cma_src_addr(id_priv);
 	memcpy(&addr->sib_addr, &sgid, sizeof(sgid));
 	cma_translate_ib(addr, &id_priv->id.route.addr.dev_addr);
@@ -2479,8 +2488,8 @@ static int cma_listen_handler(struct rdma_cm_id *id,
 	return id_priv->id.event_handler(id, event);
 }
 
-static void cma_listen_on_dev(struct rdma_id_private *id_priv,
-			      struct cma_device *cma_dev)
+static int cma_listen_on_dev(struct rdma_id_private *id_priv,
+			     struct cma_device *cma_dev)
 {
 	struct rdma_id_private *dev_id_priv;
 	struct rdma_cm_id *id;
@@ -2490,12 +2499,12 @@ static void cma_listen_on_dev(struct rdma_id_private *id_priv,
 	lockdep_assert_held(&lock);
 
 	if (cma_family(id_priv) == AF_IB && !rdma_cap_ib_cm(cma_dev->device, 1))
-		return;
+		return 0;
 
 	id = __rdma_create_id(net, cma_listen_handler, id_priv, id_priv->id.ps,
 			      id_priv->id.qp_type, id_priv->res.kern_name);
 	if (IS_ERR(id))
-		return;
+		return PTR_ERR(id);
 
 	dev_id_priv = container_of(id, struct rdma_id_private, id);
 
@@ -2503,7 +2512,9 @@ static void cma_listen_on_dev(struct rdma_id_private *id_priv,
 	memcpy(cma_src_addr(dev_id_priv), cma_src_addr(id_priv),
 	       rdma_addr_size(cma_src_addr(id_priv)));
 
-	_cma_attach_to_dev(dev_id_priv, cma_dev);
+	ret = _cma_attach_to_dev(dev_id_priv, cma_dev);
+	if (ret)
+		goto err_attach;
 	list_add_tail(&dev_id_priv->listen_list, &id_priv->listen_list);
 	cma_id_get(id_priv);
 	dev_id_priv->internal_id = 1;
@@ -2513,8 +2524,14 @@ static void cma_listen_on_dev(struct rdma_id_private *id_priv,
 
 	ret = rdma_listen(id, id_priv->backlog);
 	if (ret)
-		dev_warn(&cma_dev->device->dev,
-			 "RDMA CMA: cma_listen_on_dev, error %d\n", ret);
+		goto err_listen;
+	return 0;
+err_listen:
+	list_del(&id_priv->listen_list);
+err_attach:
+	dev_warn(&cma_dev->device->dev, "RDMA CMA: %s, error %d\n", __func__, ret);
+	rdma_destroy_id(id);
+	return ret;
 }
 
 static void cma_listen_on_all(struct rdma_id_private *id_priv)
@@ -3112,7 +3129,9 @@ static int cma_bind_loopback(struct rdma_id_private *id_priv)
 	rdma_addr_set_sgid(&id_priv->id.route.addr.dev_addr, &gid);
 	ib_addr_set_pkey(&id_priv->id.route.addr.dev_addr, pkey);
 	id_priv->id.port_num = p;
-	cma_attach_to_dev(id_priv, cma_dev);
+	ret = cma_attach_to_dev(id_priv, cma_dev);
+	if (ret)
+		goto out;
 	cma_set_loopback(cma_src_addr(id_priv));
 out:
 	mutex_unlock(&lock);
@@ -4729,69 +4748,6 @@ static struct notifier_block cma_nb = {
 	.notifier_call = cma_netdev_callback
 };
 
-static int cma_add_one(struct ib_device *device)
-{
-	struct cma_device *cma_dev;
-	struct rdma_id_private *id_priv;
-	unsigned int i;
-	unsigned long supported_gids = 0;
-	int ret;
-
-	cma_dev = kmalloc(sizeof *cma_dev, GFP_KERNEL);
-	if (!cma_dev)
-		return -ENOMEM;
-
-	cma_dev->device = device;
-	cma_dev->default_gid_type = kcalloc(device->phys_port_cnt,
-					    sizeof(*cma_dev->default_gid_type),
-					    GFP_KERNEL);
-	if (!cma_dev->default_gid_type) {
-		ret = -ENOMEM;
-		goto free_cma_dev;
-	}
-
-	cma_dev->default_roce_tos = kcalloc(device->phys_port_cnt,
-					    sizeof(*cma_dev->default_roce_tos),
-					    GFP_KERNEL);
-	if (!cma_dev->default_roce_tos) {
-		ret = -ENOMEM;
-		goto free_gid_type;
-	}
-
-	rdma_for_each_port (device, i) {
-		supported_gids = roce_gid_type_mask_support(device, i);
-		WARN_ON(!supported_gids);
-		if (supported_gids & (1 << CMA_PREFERRED_ROCE_GID_TYPE))
-			cma_dev->default_gid_type[i - rdma_start_port(device)] =
-				CMA_PREFERRED_ROCE_GID_TYPE;
-		else
-			cma_dev->default_gid_type[i - rdma_start_port(device)] =
-				find_first_bit(&supported_gids, BITS_PER_LONG);
-		cma_dev->default_roce_tos[i - rdma_start_port(device)] = 0;
-	}
-
-	init_completion(&cma_dev->comp);
-	refcount_set(&cma_dev->refcount, 1);
-	INIT_LIST_HEAD(&cma_dev->id_list);
-	ib_set_client_data(device, &cma_client, cma_dev);
-
-	mutex_lock(&lock);
-	list_add_tail(&cma_dev->list, &dev_list);
-	list_for_each_entry(id_priv, &listen_any_list, list)
-		cma_listen_on_dev(id_priv, cma_dev);
-	mutex_unlock(&lock);
-
-	trace_cm_add_one(device);
-	return 0;
-
-free_gid_type:
-	kfree(cma_dev->default_gid_type);
-
-free_cma_dev:
-	kfree(cma_dev);
-	return ret;
-}
-
 static void cma_send_device_removal_put(struct rdma_id_private *id_priv)
 {
 	struct rdma_cm_event event = { .event = RDMA_CM_EVENT_DEVICE_REMOVAL };
@@ -4854,6 +4810,81 @@ static void cma_process_remove(struct cma_device *cma_dev)
 	wait_for_completion(&cma_dev->comp);
 }
 
+static int cma_add_one(struct ib_device *device)
+{
+	struct cma_device *cma_dev;
+	struct rdma_id_private *id_priv;
+	unsigned int i;
+	unsigned long supported_gids = 0;
+	int ret;
+
+	cma_dev = kmalloc(sizeof(*cma_dev), GFP_KERNEL);
+	if (!cma_dev)
+		return -ENOMEM;
+
+	cma_dev->device = device;
+	cma_dev->default_gid_type = kcalloc(device->phys_port_cnt,
+					    sizeof(*cma_dev->default_gid_type),
+					    GFP_KERNEL);
+	if (!cma_dev->default_gid_type) {
+		ret = -ENOMEM;
+		goto free_cma_dev;
+	}
+
+	cma_dev->default_roce_tos = kcalloc(device->phys_port_cnt,
+					    sizeof(*cma_dev->default_roce_tos),
+					    GFP_KERNEL);
+	if (!cma_dev->default_roce_tos) {
+		ret = -ENOMEM;
+		goto free_gid_type;
+	}
+
+	rdma_for_each_port (device, i) {
+		supported_gids = roce_gid_type_mask_support(device, i);
+		WARN_ON(!supported_gids);
+		if (supported_gids & (1 << CMA_PREFERRED_ROCE_GID_TYPE))
+			cma_dev->default_gid_type[i - rdma_start_port(device)] =
+				CMA_PREFERRED_ROCE_GID_TYPE;
+		else
+			cma_dev->default_gid_type[i - rdma_start_port(device)] =
+				find_first_bit(&supported_gids, BITS_PER_LONG);
+		cma_dev->default_roce_tos[i - rdma_start_port(device)] = 0;
+	}
+
+	init_completion(&cma_dev->comp);
+	refcount_set(&cma_dev->refcount, 1);
+	INIT_LIST_HEAD(&cma_dev->id_list);
+	ib_set_client_data(device, &cma_client, cma_dev);
+
+	mutex_lock(&lock);
+	list_add_tail(&cma_dev->list, &dev_list);
+	list_for_each_entry(id_priv, &listen_any_list, list) {
+		ret = cma_listen_on_dev(id_priv, cma_dev);
+		if (ret) {
+			mutex_unlock(&lock);
+			goto free_listen;
+		}
+	}
+	mutex_unlock(&lock);
+
+	trace_cm_add_one(device);
+	return 0;
+
+free_listen:
+	mutex_lock(&lock);
+	list_del(&cma_dev->list);
+	mutex_unlock(&lock);
+
+	cma_process_remove(cma_dev);
+	kfree(cma_dev->default_roce_tos);
+free_gid_type:
+	kfree(cma_dev->default_gid_type);
+
+free_cma_dev:
+	kfree(cma_dev);
+	return ret;
+}
+
 static void cma_remove_one(struct ib_device *device, void *client_data)
 {
 	struct cma_device *cma_dev = client_data;
-- 
2.26.2

