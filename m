Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017703A45F9
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jun 2021 18:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhFKQDL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Jun 2021 12:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231164AbhFKQC6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 11 Jun 2021 12:02:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79FE4613EE;
        Fri, 11 Jun 2021 16:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623427260;
        bh=/di9EtO1qUTxZxjUHov6WOvYGqgKTY+3igWpQOk8nUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xka6ZqHC/6MPSTtWr9BSFEBRN+9bZZylVGyx9ib26NfYx1NHkZXo+Wukq4lGsomd6
         h05CFUSzzU0dtdlvZItvN4r8G2o3Z1B81DCC56tc3u0+9zU8Ul7XHzCOb4fYeM2t3T
         OX/kNbOqe5kAD+jeZUFuVppde+cCjvRljcjYAuRoAYI/gUgFIE5BLknF2kgThvCiQz
         Z4JlOtU3AiWl3dpn9QrFhuYsvC718EcHCIloMHm7DrR6T/uVrR9lFjZ0x59jHceCkQ
         zA7LgAEWkBioO3PoibGtyIVa4V9cerFS5NJ1WzwIpwcSMrZd282uVMxBZHTZYRsqXM
         vrnmZUdgYCFzQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        clang-built-linux@googlegroups.com,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next v2 07/15] RDMA/core: Create the device hw_counters through the normal groups mechanism
Date:   Fri, 11 Jun 2021 19:00:26 +0300
Message-Id: <666250d937b64f6fdf45da9e2dc0b6e5e4f7abd8.1623427137.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623427137.git.leonro@nvidia.com>
References: <cover.1623427137.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Instead of calling device_add_groups() add the group to the existing
groups array which is managed through device_add().

This requires setting up the hw_counters before device_add(), so it gets
split up from the already split port sysfs flow.

Move all the memory freeing to the release function.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/core_priv.h |  4 +-
 drivers/infiniband/core/device.c    | 11 ++++-
 drivers/infiniband/core/sysfs.c     | 66 +++++++----------------------
 include/rdma/ib_verbs.h             |  9 ++--
 4 files changed, 32 insertions(+), 58 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index ec5c2c3db423..6066c4b39876 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -78,8 +78,6 @@ static inline struct rdma_dev_net *rdma_net_to_dev_net(struct net *net)
 	return net_generic(net, rdma_dev_net_id);
 }
 
-int ib_device_register_sysfs(struct ib_device *device);
-void ib_device_unregister_sysfs(struct ib_device *device);
 int ib_device_rename(struct ib_device *ibdev, const char *name);
 int ib_device_set_dim(struct ib_device *ibdev, u8 use_dim);
 
@@ -379,6 +377,8 @@ struct net_device *rdma_read_gid_attr_ndev_rcu(const struct ib_gid_attr *attr);
 void ib_free_port_attrs(struct ib_core_device *coredev);
 int ib_setup_port_attrs(struct ib_core_device *coredev);
 struct rdma_hw_stats *ib_get_hw_stats_port(struct ib_device *ibdev, u32 port_num);
+void ib_device_release_hw_stats(struct hw_stats_device_data *data);
+int ib_setup_device_attrs(struct ib_device *ibdev);
 
 int rdma_compatdev_set(u8 enable);
 
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 86a16cd7d7fd..030a4041b2e0 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -491,6 +491,8 @@ static void ib_device_release(struct device *device)
 
 	free_netdevs(dev);
 	WARN_ON(refcount_read(&dev->refcount));
+	if (dev->hw_stats_data)
+		ib_device_release_hw_stats(dev->hw_stats_data);
 	if (dev->port_data) {
 		ib_cache_release_one(dev);
 		ib_security_release_port_pkey_list(dev);
@@ -1394,6 +1396,10 @@ int ib_register_device(struct ib_device *device, const char *name,
 		return ret;
 	}
 
+	ret = ib_setup_device_attrs(device);
+	if (ret)
+		goto cache_cleanup;
+
 	ib_device_register_rdmacg(device);
 
 	rdma_counter_init(device);
@@ -1407,7 +1413,7 @@ int ib_register_device(struct ib_device *device, const char *name,
 	if (ret)
 		goto cg_cleanup;
 
-	ret = ib_device_register_sysfs(device);
+	ret = ib_setup_port_attrs(&device->coredev);
 	if (ret) {
 		dev_warn(&device->dev,
 			 "Couldn't register device with driver model\n");
@@ -1449,6 +1455,7 @@ int ib_register_device(struct ib_device *device, const char *name,
 cg_cleanup:
 	dev_set_uevent_suppress(&device->dev, false);
 	ib_device_unregister_rdmacg(device);
+cache_cleanup:
 	ib_cache_cleanup_one(device);
 	return ret;
 }
@@ -1473,7 +1480,7 @@ static void __ib_unregister_device(struct ib_device *ib_dev)
 	/* Expedite removing unregistered pointers from the hash table */
 	free_netdevs(ib_dev);
 
-	ib_device_unregister_sysfs(ib_dev);
+	ib_free_port_attrs(&ib_dev->coredev);
 	device_del(&ib_dev->dev);
 	ib_device_unregister_rdmacg(ib_dev);
 	ib_cache_cleanup_one(ib_dev);
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 2631c179e004..07a00d3d3d44 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -107,7 +107,6 @@ struct hw_stats_port_attribute {
 
 struct hw_stats_device_data {
 	struct attribute_group group;
-	const struct attribute_group *groups[2];
 	struct rdma_hw_stats *stats;
 	struct hw_stats_device_attribute attrs[];
 };
@@ -915,7 +914,6 @@ alloc_hw_stats_device(struct ib_device *ibdev)
 	mutex_init(&stats->lock);
 	data->group.name = "hw_counters";
 	data->stats = stats;
-	data->groups[0] = &data->group;
 	return data;
 
 err_free_data:
@@ -925,29 +923,33 @@ alloc_hw_stats_device(struct ib_device *ibdev)
 	return ERR_PTR(-ENOMEM);
 }
 
-static void free_hw_stats_device(struct hw_stats_device_data *data)
+void ib_device_release_hw_stats(struct hw_stats_device_data *data)
 {
 	kfree(data->group.attrs);
 	kfree(data->stats);
 	kfree(data);
 }
 
-static int setup_hw_device_stats(struct ib_device *ibdev)
+int ib_setup_device_attrs(struct ib_device *ibdev)
 {
 	struct hw_stats_device_attribute *attr;
 	struct hw_stats_device_data *data;
 	int i, ret;
 
 	data = alloc_hw_stats_device(ibdev);
-	if (IS_ERR(data))
+	if (IS_ERR(data)) {
+		if (PTR_ERR(data) == -EOPNOTSUPP)
+			return 0;
 		return PTR_ERR(data);
+	}
+	ibdev->hw_stats_data = data;
 
 	ret = ibdev->ops.get_hw_stats(ibdev, data->stats, 0,
 				      data->stats->num_counters);
 	if (ret != data->stats->num_counters) {
 		if (WARN_ON(ret >= 0))
-			ret = -EINVAL;
-		goto err_free;
+			return -EINVAL;
+		return ret;
 	}
 
 	data->stats->timestamp = jiffies;
@@ -971,26 +973,13 @@ static int setup_hw_device_stats(struct ib_device *ibdev)
 	attr->attr.store = hw_stat_device_store;
 	attr->store = set_stats_lifespan;
 	data->group.attrs[i] = &attr->attr.attr;
-
-	ibdev->hw_stats_data = data;
-	ret = device_add_groups(&ibdev->dev, data->groups);
-	if (ret)
-		goto err_free;
-	return 0;
-
-err_free:
-	free_hw_stats_device(data);
-	ibdev->hw_stats_data = NULL;
-	return ret;
-}
-
-static void destroy_hw_device_stats(struct ib_device *ibdev)
-{
-	if (!ibdev->hw_stats_data)
-		return;
-	device_remove_groups(&ibdev->dev, ibdev->hw_stats_data->groups);
-	free_hw_stats_device(ibdev->hw_stats_data);
-	ibdev->hw_stats_data = NULL;
+	for (i = 0; i != ARRAY_SIZE(ibdev->groups); i++)
+		if (!ibdev->groups[i]) {
+			ibdev->groups[i] = &data->group;
+			return 0;
+		}
+	WARN(true, "struct ib_device->groups is too small");
+	return -EINVAL;
 }
 
 static struct hw_stats_port_data *
@@ -1443,29 +1432,6 @@ int ib_setup_port_attrs(struct ib_core_device *coredev)
 	return ret;
 }
 
-int ib_device_register_sysfs(struct ib_device *device)
-{
-	int ret;
-
-	ret = ib_setup_port_attrs(&device->coredev);
-	if (ret)
-		return ret;
-
-	ret = setup_hw_device_stats(device);
-	if (ret && ret != -EOPNOTSUPP) {
-		ib_free_port_attrs(&device->coredev);
-		return ret;
-	}
-
-	return 0;
-}
-
-void ib_device_unregister_sysfs(struct ib_device *device)
-{
-	destroy_hw_device_stats(device);
-	ib_free_port_attrs(&device->coredev);
-}
-
 /**
  * ib_port_register_module_stat - add module counters under relevant port
  *  of IB device.
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 0dc7ab1a8dcf..5ca1cb82a543 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2677,11 +2677,12 @@ struct ib_device {
 		struct ib_core_device	coredev;
 	};
 
-	/* First group for device attributes,
-	 * Second group for driver provided attributes (optional).
-	 * It is NULL terminated array.
+	/* First group is for device attributes,
+	 * Second group is for driver provided attributes (optional).
+	 * Third group is for the hw_stats
+	 * It is a NULL terminated array.
 	 */
-	const struct attribute_group	*groups[3];
+	const struct attribute_group	*groups[4];
 
 	u64			     uverbs_cmd_mask;
 
-- 
2.31.1

