Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4B8279848
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Sep 2020 12:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgIZKT4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Sep 2020 06:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIZKTz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 26 Sep 2020 06:19:55 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E21C238E5;
        Sat, 26 Sep 2020 10:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601115595;
        bh=c3QDG3bxZLTnybXBPF9wmfdcQEtLbUMBe4bGS0s2ToM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nh33u9grdPg3Phd0Fru0XCvDBd5h7n6fRJ8neWrD595VHAQrjXapSdSePo1H0qR3t
         QD20RNL9tC9W8CogveTkIpgmb5D88W1NjfPtJHPSyEX0oIgUZIH1w3k1Ge9Ulcm+c3
         erffMm2kB2/R3iKyLehOJ8y+x4lfM1qYGhkNrDXM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v3 4/9] RDMA/cma: Add missing error handling of listen_id
Date:   Sat, 26 Sep 2020 13:19:33 +0300
Message-Id: <20200926101938.2964394-5-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200926101938.2964394-1-leon@kernel.org>
References: <20200926101938.2964394-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Don't silently continue if rdma_listen() fails but destroy previously
created CM_ID and return an error to the caller.

Fixes: d02d1f5359e7 ("RDMA/cma: Fix deadlock destroying listen requests")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c | 175 ++++++++++++++++++++--------------
 1 file changed, 101 insertions(+), 74 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 6419b798cd2e..84c7f2f60a6a 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2491,8 +2491,8 @@ static int cma_listen_handler(struct rdma_cm_id *id,
 	return id_priv->id.event_handler(id, event);
 }

-static void cma_listen_on_dev(struct rdma_id_private *id_priv,
-			      struct cma_device *cma_dev)
+static int cma_listen_on_dev(struct rdma_id_private *id_priv,
+			     struct cma_device *cma_dev)
 {
 	struct rdma_id_private *dev_id_priv;
 	struct net *net = id_priv->id.route.addr.dev_addr.net;
@@ -2501,13 +2501,13 @@ static void cma_listen_on_dev(struct rdma_id_private *id_priv,
 	lockdep_assert_held(&lock);

 	if (cma_family(id_priv) == AF_IB && !rdma_cap_ib_cm(cma_dev->device, 1))
-		return;
+		return 0;

 	dev_id_priv =
 		__rdma_create_id(net, cma_listen_handler, id_priv,
 				 id_priv->id.ps, id_priv->id.qp_type, id_priv);
 	if (IS_ERR(dev_id_priv))
-		return;
+		return PTR_ERR(dev_id_priv);

 	dev_id_priv->state = RDMA_CM_ADDR_BOUND;
 	memcpy(cma_src_addr(dev_id_priv), cma_src_addr(id_priv),
@@ -2523,19 +2523,34 @@ static void cma_listen_on_dev(struct rdma_id_private *id_priv,

 	ret = rdma_listen(&dev_id_priv->id, id_priv->backlog);
 	if (ret)
-		dev_warn(&cma_dev->device->dev,
-			 "RDMA CMA: cma_listen_on_dev, error %d\n", ret);
+		goto err_listen;
+	return 0;
+err_listen:
+	list_del(&id_priv->listen_list);
+	dev_warn(&cma_dev->device->dev, "RDMA CMA: %s, error %d\n", __func__, ret);
+	rdma_destroy_id(&dev_id_priv->id);
+	return ret;
 }

-static void cma_listen_on_all(struct rdma_id_private *id_priv)
+static int cma_listen_on_all(struct rdma_id_private *id_priv)
 {
 	struct cma_device *cma_dev;
+	int ret;

 	mutex_lock(&lock);
 	list_add_tail(&id_priv->list, &listen_any_list);
-	list_for_each_entry(cma_dev, &dev_list, list)
-		cma_listen_on_dev(id_priv, cma_dev);
+	list_for_each_entry(cma_dev, &dev_list, list) {
+		ret = cma_listen_on_dev(id_priv, cma_dev);
+		if (ret)
+			goto err_listen;
+	}
+	mutex_unlock(&lock);
+	return 0;
+
+err_listen:
+	list_del(&id_priv->list);
 	mutex_unlock(&lock);
+	return ret;
 }

 void rdma_set_service_type(struct rdma_cm_id *id, int tos)
@@ -3685,8 +3700,11 @@ int rdma_listen(struct rdma_cm_id *id, int backlog)
 			ret = -ENOSYS;
 			goto err;
 		}
-	} else
-		cma_listen_on_all(id_priv);
+	} else {
+		ret = cma_listen_on_all(id_priv);
+		if (ret)
+			goto err;
+	}

 	return 0;
 err:
@@ -4738,69 +4756,6 @@ static struct notifier_block cma_nb = {
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
@@ -4863,6 +4818,78 @@ static void cma_process_remove(struct cma_device *cma_dev)
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
+		if (ret)
+			goto free_listen;
+	}
+	mutex_unlock(&lock);
+
+	trace_cm_add_one(device);
+	return 0;
+
+free_listen:
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

