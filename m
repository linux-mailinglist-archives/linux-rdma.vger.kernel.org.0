Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3941D1B8E37
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2020 11:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDZJcO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Apr 2020 05:32:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56574 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725806AbgDZJcN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Apr 2020 05:32:13 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 75D0ECC04F848DEAFFAC;
        Sun, 26 Apr 2020 17:32:09 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Sun, 26 Apr 2020 17:32:03 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, <selvin.xavier@broadcom.com>,
        <devesh.sharma@broadcom.com>, <somnath.kotur@broadcom.com>,
        <sriharsha.basavapatna@broadcom.com>, <bharat@chelsio.com>,
        <galpress@amazon.com>, <sleybo@amazon.com>,
        <faisal.latif@intel.com>, <shiraz.saleem@intel.com>,
        <yishaih@mellanox.com>, <mkalderon@marvell.com>,
        <aelior@marvell.com>, <benve@cisco.com>, <neescoba@cisco.com>,
        <pkaustub@cisco.com>, <aditr@vmware.com>, <pv-drivers@vmware.com>,
        <monis@mellanox.com>, <kamalheib1@gmail.com>, <parav@mellanox.com>,
        <markz@mellanox.com>, <rd.dunlab@gmail.com>,
        <dennis.dalessandro@intel.com>
Subject: [PATCH for-next] RDMA/core: Assign the name of device when allocating ib_device
Date:   Sun, 26 Apr 2020 17:31:57 +0800
Message-ID: <1587893517-11824-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If the name of a device is assigned during ib_register_device(), some
drivers have to use dev_*() for printing before register device. Bring
assign_name() into ib_alloc_device(), so that drivers can use ibdev_*()
anywhere.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/core/device.c               | 85 +++++++++++++-------------
 drivers/infiniband/hw/bnxt_re/main.c           |  4 +-
 drivers/infiniband/hw/cxgb4/device.c           |  2 +-
 drivers/infiniband/hw/cxgb4/provider.c         |  2 +-
 drivers/infiniband/hw/efa/efa_main.c           |  4 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c     |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c     |  2 +-
 drivers/infiniband/hw/hns/hns_roce_main.c      |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c      |  4 +-
 drivers/infiniband/hw/mlx4/main.c              |  4 +-
 drivers/infiniband/hw/mlx5/ib_rep.c            |  8 ++-
 drivers/infiniband/hw/mlx5/main.c              | 18 +++---
 drivers/infiniband/hw/mthca/mthca_main.c       |  2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c   |  2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_main.c     |  4 +-
 drivers/infiniband/hw/qedr/main.c              |  4 +-
 drivers/infiniband/hw/usnic/usnic_ib_main.c    |  4 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c |  4 +-
 drivers/infiniband/sw/rxe/rxe.c                |  4 +-
 drivers/infiniband/sw/rxe/rxe.h                |  2 +-
 drivers/infiniband/sw/rxe/rxe_net.c            |  4 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c          |  4 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h          |  2 +-
 include/rdma/ib_verbs.h                        |  8 +--
 24 files changed, 95 insertions(+), 86 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index d0b3d35..30d28da 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -557,9 +557,45 @@ static void rdma_init_coredev(struct ib_core_device *coredev,
 	write_pnet(&coredev->rdma_net, net);
 }
 
+/*
+ * Assign the unique string device name and the unique device index. This is
+ * undone by ib_dealloc_device.
+ */
+static int assign_name(struct ib_device *device, const char *name)
+{
+	static u32 last_id;
+	int ret;
+
+	down_write(&devices_rwsem);
+	/* Assign a unique name to the device */
+	if (strchr(name, '%'))
+		ret = alloc_name(device, name);
+	else
+		ret = dev_set_name(&device->dev, name);
+	if (ret)
+		goto out;
+
+	if (__ib_device_get_by_name(dev_name(&device->dev))) {
+		ret = -ENFILE;
+		goto out;
+	}
+	strlcpy(device->name, dev_name(&device->dev), IB_DEVICE_NAME_MAX);
+
+	ret = xa_alloc_cyclic(&devices, &device->index, device, xa_limit_31b,
+			      &last_id, GFP_KERNEL);
+	if (ret > 0)
+		ret = 0;
+
+out:
+	up_write(&devices_rwsem);
+	return ret;
+}
+
 /**
  * _ib_alloc_device - allocate an IB device struct
  * @size:size of structure to allocate
+ * @name: unique string device name. This may include a '%' which will
+ * cause a unique index to be added to the passed device name.
  *
  * Low-level drivers should use ib_alloc_device() to allocate &struct
  * ib_device.  @size is the size of the structure to be allocated,
@@ -567,7 +603,7 @@ static void rdma_init_coredev(struct ib_core_device *coredev,
  * ib_dealloc_device() must be used to free structures allocated with
  * ib_alloc_device().
  */
-struct ib_device *_ib_alloc_device(size_t size)
+struct ib_device *_ib_alloc_device(size_t size, const char *name)
 {
 	struct ib_device *device;
 
@@ -586,6 +622,11 @@ struct ib_device *_ib_alloc_device(size_t size)
 	device->groups[0] = &ib_dev_attr_group;
 	rdma_init_coredev(&device->coredev, device, &init_net);
 
+	if (assign_name(device, name)) {
+		kfree(device);
+		return NULL;
+	}
+
 	INIT_LIST_HEAD(&device->event_handler_list);
 	spin_lock_init(&device->qp_open_list_lock);
 	init_rwsem(&device->event_handler_rwsem);
@@ -1132,40 +1173,6 @@ static __net_init int rdma_dev_init_net(struct net *net)
 	return ret;
 }
 
-/*
- * Assign the unique string device name and the unique device index. This is
- * undone by ib_dealloc_device.
- */
-static int assign_name(struct ib_device *device, const char *name)
-{
-	static u32 last_id;
-	int ret;
-
-	down_write(&devices_rwsem);
-	/* Assign a unique name to the device */
-	if (strchr(name, '%'))
-		ret = alloc_name(device, name);
-	else
-		ret = dev_set_name(&device->dev, name);
-	if (ret)
-		goto out;
-
-	if (__ib_device_get_by_name(dev_name(&device->dev))) {
-		ret = -ENFILE;
-		goto out;
-	}
-	strlcpy(device->name, dev_name(&device->dev), IB_DEVICE_NAME_MAX);
-
-	ret = xa_alloc_cyclic(&devices, &device->index, device, xa_limit_31b,
-			&last_id, GFP_KERNEL);
-	if (ret > 0)
-		ret = 0;
-
-out:
-	up_write(&devices_rwsem);
-	return ret;
-}
-
 static void setup_dma_device(struct ib_device *device)
 {
 	struct device *parent = device->dev.parent;
@@ -1330,8 +1337,6 @@ static int enable_device_and_get(struct ib_device *device)
 /**
  * ib_register_device - Register an IB device with IB core
  * @device: Device to register
- * @name: unique string device name. This may include a '%' which will
- * cause a unique index to be added to the passed device name.
  *
  * Low-level drivers use ib_register_device() to register their
  * devices with the IB core.  All registered clients will receive a
@@ -1342,14 +1347,10 @@ static int enable_device_and_get(struct ib_device *device)
  * asynchronously then the device pointer may become freed as soon as this
  * function returns.
  */
-int ib_register_device(struct ib_device *device, const char *name)
+int ib_register_device(struct ib_device *device)
 {
 	int ret;
 
-	ret = assign_name(device, name);
-	if (ret)
-		return ret;
-
 	ret = setup_device(device);
 	if (ret)
 		return ret;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index b12fbc8..8ac5b2a 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -726,7 +726,7 @@ static int bnxt_re_register_ib(struct bnxt_re_dev *rdev)
 	if (ret)
 		return ret;
 
-	return ib_register_device(ibdev, "bnxt_re%d");
+	return ib_register_device(ibdev);
 }
 
 static void bnxt_re_dev_remove(struct bnxt_re_dev *rdev)
@@ -746,7 +746,7 @@ static struct bnxt_re_dev *bnxt_re_dev_add(struct net_device *netdev,
 	struct bnxt_re_dev *rdev;
 
 	/* Allocate bnxt_re_dev instance here */
-	rdev = ib_alloc_device(bnxt_re_dev, ibdev);
+	rdev = ib_alloc_device(bnxt_re_dev, ibdev, "bnxt_re%d");
 	if (!rdev) {
 		ibdev_err(NULL, "%s: bnxt_re_dev allocation failure!",
 			  ROCE_DRV_MODULE_NAME);
diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/cxgb4/device.c
index 599340c..7968060 100644
--- a/drivers/infiniband/hw/cxgb4/device.c
+++ b/drivers/infiniband/hw/cxgb4/device.c
@@ -978,7 +978,7 @@ static struct c4iw_dev *c4iw_alloc(const struct cxgb4_lld_info *infop)
 		pr_info("%s: On-Chip Queues not supported on this device\n",
 			pci_name(infop->pdev));
 
-	devp = ib_alloc_device(c4iw_dev, ibdev);
+	devp = ib_alloc_device(c4iw_dev, ibdev, "cxgb4_%d");
 	if (!devp) {
 		pr_err("Cannot allocate ib device\n");
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index ba83d94..4afd6a5 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -583,7 +583,7 @@ void c4iw_register_device(struct work_struct *work)
 	ret = set_netdevs(&dev->ibdev, &dev->rdev);
 	if (ret)
 		goto err_dealloc_ctx;
-	ret = ib_register_device(&dev->ibdev, "cxgb4_%d");
+	ret = ib_register_device(&dev->ibdev);
 	if (ret)
 		goto err_dealloc_ctx;
 	return;
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index faf3ff1..f004570 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -279,7 +279,7 @@ static int efa_ib_device_add(struct efa_dev *dev)
 
 	ib_set_device_ops(&dev->ibdev, &efa_dev_ops);
 
-	err = ib_register_device(&dev->ibdev, "efa_%d");
+	err = ib_register_device(&dev->ibdev);
 	if (err)
 		goto err_release_doorbell_bar;
 
@@ -385,7 +385,7 @@ static struct efa_dev *efa_probe_device(struct pci_dev *pdev)
 
 	pci_set_master(pdev);
 
-	dev = ib_alloc_device(efa_dev, ibdev);
+	dev = ib_alloc_device(efa_dev, ibdev, "efa_%d");
 	if (!dev) {
 		dev_err(&pdev->dev, "Device alloc failed\n");
 		err = -ENOMEM;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 49775cd..0ce4406 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -4629,7 +4629,7 @@ static int hns_roce_probe(struct platform_device *pdev)
 	struct hns_roce_dev *hr_dev;
 	struct device *dev = &pdev->dev;
 
-	hr_dev = ib_alloc_device(hns_roce_dev, ib_dev);
+	hr_dev = ib_alloc_device(hns_roce_dev, ib_dev, "hns_%d");
 	if (!hr_dev)
 		return -ENOMEM;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 2a8c389..5560d79 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6017,7 +6017,7 @@ static int __hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
 	struct hns_roce_dev *hr_dev;
 	int ret;
 
-	hr_dev = ib_alloc_device(hns_roce_dev, ib_dev);
+	hr_dev = ib_alloc_device(hns_roce_dev, ib_dev, "hns%d");
 	if (!hr_dev)
 		return -ENOMEM;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index d0031d5..c26a67e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -546,7 +546,7 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 		if (ret)
 			return ret;
 	}
-	ret = ib_register_device(ib_dev, "hns_%d");
+	ret = ib_register_device(ib_dev);
 	if (ret) {
 		dev_err(dev, "ib_register_device failed!\n");
 		return ret;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 1b6fb13..ccb0d70 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -2692,7 +2692,7 @@ static struct i40iw_ib_device *i40iw_init_rdma_device(struct i40iw_device *iwdev
 	struct net_device *netdev = iwdev->netdev;
 	struct pci_dev *pcidev = (struct pci_dev *)iwdev->hw.dev_context;
 
-	iwibdev = ib_alloc_device(i40iw_ib_device, ibdev);
+	iwibdev = ib_alloc_device(i40iw_ib_device, ibdev, "i40iw%d");
 	if (!iwibdev) {
 		i40iw_pr_err("iwdev == NULL\n");
 		return NULL;
@@ -2780,7 +2780,7 @@ int i40iw_register_rdma_device(struct i40iw_device *iwdev)
 	if (ret)
 		goto error;
 
-	ret = ib_register_device(&iwibdev->ibdev, "i40iw%d");
+	ret = ib_register_device(&iwibdev->ibdev);
 	if (ret)
 		goto error;
 
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index a66518a..94a93f0 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2644,7 +2644,7 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 	if (num_ports == 0)
 		return NULL;
 
-	ibdev = ib_alloc_device(mlx4_ib_dev, ib_dev);
+	ibdev = ib_alloc_device(mlx4_ib_dev, ib_dev, "mlx4_%d");
 	if (!ibdev) {
 		dev_err(&dev->persist->pdev->dev,
 			"Device struct alloc failed\n");
@@ -2863,7 +2863,7 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 		goto err_steer_free_bitmap;
 
 	rdma_set_device_sysfs_group(&ibdev->ib_dev, &mlx4_attr_group);
-	if (ib_register_device(&ibdev->ib_dev, "mlx4_%d"))
+	if (ib_register_device(&ibdev->ib_dev))
 		goto err_diag_counters;
 
 	if (mlx4_ib_mad_init(ibdev))
diff --git a/drivers/infiniband/hw/mlx5/ib_rep.c b/drivers/infiniband/hw/mlx5/ib_rep.c
index 5c3d052..9871250 100644
--- a/drivers/infiniband/hw/mlx5/ib_rep.c
+++ b/drivers/infiniband/hw/mlx5/ib_rep.c
@@ -32,6 +32,7 @@ mlx5_ib_vport_rep_load(struct mlx5_core_dev *dev, struct mlx5_eswitch_rep *rep)
 	int num_ports = mlx5_eswitch_get_total_vports(dev);
 	const struct mlx5_ib_profile *profile;
 	struct mlx5_ib_dev *ibdev;
+	const char *name;
 	int vport_index;
 
 	if (rep->vport == MLX5_VPORT_UPLINK)
@@ -39,7 +40,12 @@ mlx5_ib_vport_rep_load(struct mlx5_core_dev *dev, struct mlx5_eswitch_rep *rep)
 	else
 		return mlx5_ib_set_vport_rep(dev, rep);
 
-	ibdev = ib_alloc_device(mlx5_ib_dev, ib_dev);
+	if (!mlx5_lag_is_roce(dev))
+		name = "mlx5_%d";
+	else
+		name = "mlx5_bond_%d";
+
+	ibdev = ib_alloc_device(mlx5_ib_dev, ib_dev, name);
 	if (!ibdev)
 		return -ENOMEM;
 
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 6679756..c804a18 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -7036,14 +7036,9 @@ static void mlx5_ib_stage_bfrag_cleanup(struct mlx5_ib_dev *dev)
 
 static int mlx5_ib_stage_ib_reg_init(struct mlx5_ib_dev *dev)
 {
-	const char *name;
-
 	rdma_set_device_sysfs_group(&dev->ib_dev, &mlx5_attr_group);
-	if (!mlx5_lag_is_roce(dev->mdev))
-		name = "mlx5_%d";
-	else
-		name = "mlx5_bond_%d";
-	return ib_register_device(&dev->ib_dev, name);
+
+	return ib_register_device(&dev->ib_dev);
 }
 
 static void mlx5_ib_stage_pre_ib_reg_umr_cleanup(struct mlx5_ib_dev *dev)
@@ -7314,6 +7309,7 @@ static void *mlx5_ib_add(struct mlx5_core_dev *mdev)
 	enum rdma_link_layer ll;
 	struct mlx5_ib_dev *dev;
 	int port_type_cap;
+	const char *name;
 	int num_ports;
 
 	printk_once(KERN_INFO "%s", mlx5_version);
@@ -7333,7 +7329,13 @@ static void *mlx5_ib_add(struct mlx5_core_dev *mdev)
 
 	num_ports = max(MLX5_CAP_GEN(mdev, num_ports),
 			MLX5_CAP_GEN(mdev, num_vhca_ports));
-	dev = ib_alloc_device(mlx5_ib_dev, ib_dev);
+
+	if (!mlx5_lag_is_roce(mdev))
+		name = "mlx5_%d";
+	else
+		name = "mlx5_bond_%d";
+
+	dev = ib_alloc_device(mlx5_ib_dev, ib_dev, name);
 	if (!dev)
 		return NULL;
 	dev->port = kcalloc(num_ports, sizeof(*dev->port),
diff --git a/drivers/infiniband/hw/mthca/mthca_main.c b/drivers/infiniband/hw/mthca/mthca_main.c
index fe9654a..9c8c88c 100644
--- a/drivers/infiniband/hw/mthca/mthca_main.c
+++ b/drivers/infiniband/hw/mthca/mthca_main.c
@@ -961,7 +961,7 @@ static int __mthca_init_one(struct pci_dev *pdev, int hca_type)
 	/* We can handle large RDMA requests, so allow larger segments. */
 	dma_set_max_seg_size(&pdev->dev, 1024 * 1024 * 1024);
 
-	mdev = ib_alloc_device(mthca_dev, ib_dev);
+	mdev = ib_alloc_device(mthca_dev, ib_dev, "mthca%d");
 	if (!mdev) {
 		dev_err(&pdev->dev, "Device struct alloc failed, "
 			"aborting.\n");
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 69a3e4f..8384fe2 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -1294,7 +1294,7 @@ int mthca_register_device(struct mthca_dev *dev)
 	mutex_init(&dev->cap_mask_mutex);
 
 	rdma_set_device_sysfs_group(&dev->ib_dev, &mthca_attr_group);
-	ret = ib_register_device(&dev->ib_dev, "mthca%d");
+	ret = ib_register_device(&dev->ib_dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
index d8c47d2..c087a06 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
@@ -255,7 +255,7 @@ static int ocrdma_register_device(struct ocrdma_dev *dev)
 	if (ret)
 		return ret;
 
-	return ib_register_device(&dev->ibdev, "ocrdma%d");
+	return ib_register_device(&dev->ibdev);
 }
 
 static int ocrdma_alloc_resources(struct ocrdma_dev *dev)
@@ -307,7 +307,7 @@ static struct ocrdma_dev *ocrdma_add(struct be_dev_info *dev_info)
 	u8 lstate = 0;
 	struct ocrdma_dev *dev;
 
-	dev = ib_alloc_device(ocrdma_dev, ibdev);
+	dev = ib_alloc_device(ocrdma_dev, ibdev, "ocrdma%d");
 	if (!dev) {
 		pr_err("Unable to allocate ib device\n");
 		return NULL;
diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index dcdc85a..1421e33 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -287,7 +287,7 @@ static int qedr_register_device(struct qedr_dev *dev)
 	if (rc)
 		return rc;
 
-	return ib_register_device(&dev->ibdev, "qedr%d");
+	return ib_register_device(&dev->ibdev);
 }
 
 /* This function allocates fast-path status block memory */
@@ -854,7 +854,7 @@ static struct qedr_dev *qedr_add(struct qed_dev *cdev, struct pci_dev *pdev,
 	struct qedr_dev *dev;
 	int rc = 0;
 
-	dev = ib_alloc_device(qedr_dev, ibdev);
+	dev = ib_alloc_device(qedr_dev, ibdev, "qedr%d");
 	if (!dev) {
 		pr_err("Unable to allocate ib device\n");
 		return NULL;
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniband/hw/usnic/usnic_ib_main.c
index c9abe1c..caa3504 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
@@ -376,7 +376,7 @@ static void *usnic_ib_device_add(struct pci_dev *dev)
 	usnic_dbg("\n");
 	netdev = pci_get_drvdata(dev);
 
-	us_ibdev = ib_alloc_device(usnic_ib_dev, ib_dev);
+	us_ibdev = ib_alloc_device(usnic_ib_dev, ib_dev, "usnic_%d");
 	if (!us_ibdev) {
 		usnic_err("Device %s context alloc failed\n",
 				netdev_name(pci_get_drvdata(dev)));
@@ -427,7 +427,7 @@ static void *usnic_ib_device_add(struct pci_dev *dev)
 	if (ret)
 		goto err_fwd_dealloc;
 
-	if (ib_register_device(&us_ibdev->ib_dev, "usnic_%d"))
+	if (ib_register_device(&us_ibdev->ib_dev))
 		goto err_fwd_dealloc;
 
 	usnic_fwd_set_mtu(us_ibdev->ufdev, us_ibdev->netdev->mtu);
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index e580ae9..3a0e418 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -270,7 +270,7 @@ static int pvrdma_register_device(struct pvrdma_dev *dev)
 	spin_lock_init(&dev->srq_tbl_lock);
 	rdma_set_device_sysfs_group(&dev->ib_dev, &pvrdma_attr_group);
 
-	ret = ib_register_device(&dev->ib_dev, "vmw_pvrdma%d");
+	ret = ib_register_device(&dev->ib_dev);
 	if (ret)
 		goto err_srq_free;
 
@@ -789,7 +789,7 @@ static int pvrdma_pci_probe(struct pci_dev *pdev,
 	dev_dbg(&pdev->dev, "initializing driver %s\n", pci_name(pdev));
 
 	/* Allocate zero-out device */
-	dev = ib_alloc_device(pvrdma_dev, ib_dev);
+	dev = ib_alloc_device(pvrdma_dev, ib_dev, "vmw_pvrdma%d");
 	if (!dev) {
 		dev_err(&pdev->dev, "failed to allocate IB device\n");
 		return -ENOMEM;
diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 5642eef..71e211c 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -292,7 +292,7 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
 /* called by ifc layer to create new rxe device.
  * The caller should allocate memory for rxe by calling ib_alloc_device.
  */
-int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name)
+int rxe_add(struct rxe_dev *rxe, unsigned int mtu)
 {
 	int err;
 
@@ -302,7 +302,7 @@ int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name)
 
 	rxe_set_mtu(rxe, mtu);
 
-	return rxe_register_device(rxe, ibdev_name);
+	return rxe_register_device(rxe);
 }
 
 static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index fb07eed..8b7e9c9 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -90,7 +90,7 @@ static inline u32 rxe_crc32(struct rxe_dev *rxe,
 
 void rxe_set_mtu(struct rxe_dev *rxe, unsigned int dev_mtu);
 
-int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name);
+int rxe_add(struct rxe_dev *rxe, unsigned int mtu);
 
 void rxe_rcv(struct sk_buff *skb);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 312c2fc..cffa7b1 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -530,13 +530,13 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
 	int err;
 	struct rxe_dev *rxe = NULL;
 
-	rxe = ib_alloc_device(rxe_dev, ib_dev);
+	rxe = ib_alloc_device(rxe_dev, ib_dev, ibdev_name);
 	if (!rxe)
 		return -ENOMEM;
 
 	rxe->ndev = ndev;
 
-	err = rxe_add(rxe, ndev->mtu, ibdev_name);
+	err = rxe_add(rxe, ndev->mtu);
 	if (err) {
 		ib_dealloc_device(&rxe->ib_dev);
 		return err;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 9dd4bd7..0dc4ca3 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1159,7 +1159,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, rxe_ucontext, ibuc),
 };
 
-int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
+int rxe_register_device(struct rxe_dev *rxe)
 {
 	int err;
 	struct ib_device *dev = &rxe->ib_dev;
@@ -1228,7 +1228,7 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	rxe->tfm = tfm;
 
 	rdma_set_device_sysfs_group(dev, &rxe_attr_group);
-	err = ib_register_device(dev, ibdev_name);
+	err = ib_register_device(dev);
 	if (err)
 		pr_warn("%s failed with error %d\n", __func__, err);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 92de39c..e078af6 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -466,7 +466,7 @@ static inline struct rxe_mem *to_rmw(struct ib_mw *mw)
 	return mw ? container_of(mw, struct rxe_mem, ibmw) : NULL;
 }
 
-int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name);
+int rxe_register_device(struct rxe_dev *rxe);
 
 void rxe_mc_cleanup(struct rxe_pool_entry *arg);
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index bbc5cfb..37624e2 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2767,18 +2767,18 @@ struct ib_block_iter {
 	unsigned int __pg_bit;		/* alignment of current block */
 };
 
-struct ib_device *_ib_alloc_device(size_t size);
-#define ib_alloc_device(drv_struct, member)                                    \
+struct ib_device *_ib_alloc_device(size_t size, const char *name);
+#define ib_alloc_device(drv_struct, member, name)                              \
 	container_of(_ib_alloc_device(sizeof(struct drv_struct) +              \
 				      BUILD_BUG_ON_ZERO(offsetof(              \
-					      struct drv_struct, member))),    \
+					    struct drv_struct, member)), name),\
 		     struct drv_struct, member)
 
 void ib_dealloc_device(struct ib_device *device);
 
 void ib_get_device_fw_str(struct ib_device *device, char *str);
 
-int ib_register_device(struct ib_device *device, const char *name);
+int ib_register_device(struct ib_device *device);
 void ib_unregister_device(struct ib_device *device);
 void ib_unregister_driver(enum rdma_driver_id driver_id);
 void ib_unregister_device_and_put(struct ib_device *device);
-- 
2.8.1

