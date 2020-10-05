Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60FB283474
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Oct 2020 13:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgJELA6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Oct 2020 07:00:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgJELA6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 5 Oct 2020 07:00:58 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB27A20774;
        Mon,  5 Oct 2020 11:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601895655;
        bh=QqB/U1VpbYGhlgZobE/eTwIO4rMacnmqNCWucFIs9xE=;
        h=From:To:Cc:Subject:Date:From;
        b=v3dR20YyIwvs9bghyF4rG95f4TN11Pgt0Dyj1RekF4KZlDPlHrOsVUN1kCoByr+Ox
         SKYguYInhUMOPab8AbQr6tM3d0R8eSiYW0wTh7eeryIN8jwYT+hOYz6VXpqU9gfrCk
         UZDX9yk1lvlDtxs3R7mkE5Od2HVO67gi0TuDq820=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Adit Ranadive <aditr@vmware.com>, Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Lijun Ou <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parav Pandit <parav@nvidia.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: [PATCH rdma-next v1] RDMA: Explicitly pass in the dma_device to ib_register_device
Date:   Mon,  5 Oct 2020 14:00:50 +0300
Message-Id: <20201005110050.1703618-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

The code in setup_dma_device has become rather convoluted, move all of
this to the drivers. Drives now pass in a DMA capable struct device which
will be used to setup DMA, or drivers must fully configure the ibdev for
DMA and pass in NULL.

Other than setting the masks in rvt all drivers were doing this already
anyhow.

mthca, mlx4 and mlx5 were already setting up maximum DMA segment size for
DMA based on their hardweare limits in:
__mthca_init_one()
  dma_set_max_seg_size (1G)

__mlx4_init_one()
  dma_set_max_seg_size (1G)

mlx5_pci_init()
  set_dma_caps()
    dma_set_max_seg_size (2G)

Other non software drivers (except usnic) were extended to UINT_MAX [1, 2]
instead of 2G as was before.

[1] https://lore.kernel.org/linux-rdma/20200924114940.GE9475@nvidia.com/
[2] https://lore.kernel.org/linux-rdma/20200924114940.GE9475@nvidia.com/
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
v0:
 * Moved dma_set_max_seg_size() to be part of the drivers and increased
   the limit to UINT_MAX.
---
 drivers/infiniband/core/device.c              | 67 +++++--------------
 drivers/infiniband/hw/bnxt_re/main.c          |  3 +-
 drivers/infiniband/hw/cxgb4/provider.c        |  4 +-
 drivers/infiniband/hw/efa/efa_main.c          |  4 +-
 drivers/infiniband/hw/hns/hns_roce_main.c     |  3 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c     |  3 +-
 drivers/infiniband/hw/mlx4/main.c             |  3 +-
 drivers/infiniband/hw/mlx5/main.c             |  2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c  |  2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_main.c    |  4 +-
 drivers/infiniband/hw/qedr/main.c             |  3 +-
 drivers/infiniband/hw/usnic/usnic_ib_main.c   |  3 +-
 .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  4 +-
 drivers/infiniband/sw/rdmavt/vt.c             |  8 ++-
 drivers/infiniband/sw/rxe/rxe_verbs.c         |  2 +-
 drivers/infiniband/sw/siw/siw_main.c          |  4 +-
 include/rdma/ib_verbs.h                       |  3 +-
 17 files changed, 54 insertions(+), 68 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index ec3becf85cac..c82e99b2fc0d 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1177,58 +1177,26 @@ static int assign_name(struct ib_device *device, const char *name)
 	return ret;
 }

-static void setup_dma_device(struct ib_device *device)
+static void setup_dma_device(struct ib_device *device,
+			     struct device *dma_device)
 {
-	struct device *parent = device->dev.parent;
-
-	WARN_ON_ONCE(device->dma_device);
-
-#ifdef CONFIG_DMA_OPS
-	if (device->dev.dma_ops) {
-		/*
-		 * The caller provided custom DMA operations. Copy the
-		 * DMA-related fields that are used by e.g. dma_alloc_coherent()
-		 * into device->dev.
-		 */
-		device->dma_device = &device->dev;
-		if (!device->dev.dma_mask) {
-			if (parent)
-				device->dev.dma_mask = parent->dma_mask;
-			else
-				WARN_ON_ONCE(true);
-		}
-		if (!device->dev.coherent_dma_mask) {
-			if (parent)
-				device->dev.coherent_dma_mask =
-					parent->coherent_dma_mask;
-			else
-				WARN_ON_ONCE(true);
-		}
-	} else
-#endif /* CONFIG_DMA_OPS */
-	{
+	if (!dma_device) {
 		/*
-		 * The caller did not provide custom DMA operations. Use the
-		 * DMA mapping operations of the parent device.
+		 * If the caller does not provide a DMA capable device then the
+		 * IB device will be used. In this case the caller should fully
+		 * setup the ibdev for DMA. This usually means using
+		 * dma_virt_ops.
 		 */
-		WARN_ON_ONCE(!parent);
-		device->dma_device = parent;
-	}
+#ifdef CONFIG_DMA_OPS
+		if (WARN_ON(!device->dev.dma_ops))
+			return;
+#endif
+		if (WARN_ON(!device->dev.dma_parms))
+			return;

-	if (!device->dev.dma_parms) {
-		if (parent) {
-			/*
-			 * The caller did not provide DMA parameters, so
-			 * 'parent' probably represents a PCI device. The PCI
-			 * core sets the maximum segment size to 64
-			 * KB. Increase this parameter to 2 GB.
-			 */
-			device->dev.dma_parms = parent->dma_parms;
-			dma_set_max_seg_size(device->dma_device, SZ_2G);
-		} else {
-			WARN_ON_ONCE(true);
-		}
+		dma_device = &device->dev;
 	}
+	device->dma_device = dma_device;
 }

 /*
@@ -1241,7 +1209,6 @@ static int setup_device(struct ib_device *device)
 	struct ib_udata uhw = {.outlen = 0, .inlen = 0};
 	int ret;

-	setup_dma_device(device);
 	ib_device_check_mandatory(device);

 	ret = setup_port_data(device);
@@ -1361,7 +1328,8 @@ static void prevent_dealloc_device(struct ib_device *ib_dev)
  * asynchronously then the device pointer may become freed as soon as this
  * function returns.
  */
-int ib_register_device(struct ib_device *device, const char *name)
+int ib_register_device(struct ib_device *device, const char *name,
+		       struct device *dma_device)
 {
 	int ret;

@@ -1369,6 +1337,7 @@ int ib_register_device(struct ib_device *device, const char *name)
 	if (ret)
 		return ret;

+	setup_dma_device(device, dma_device);
 	ret = setup_device(device);
 	if (ret)
 		return ret;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 53aee5a42ab8..04621ba8fa76 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -736,7 +736,8 @@ static int bnxt_re_register_ib(struct bnxt_re_dev *rdev)
 	if (ret)
 		return ret;

-	return ib_register_device(ibdev, "bnxt_re%d");
+	dma_set_max_seg_size(&rdev->en_dev->pdev->dev, UINT_MAX);
+	return ib_register_device(ibdev, "bnxt_re%d", &rdev->en_dev->pdev->dev);
 }

 static void bnxt_re_dev_remove(struct bnxt_re_dev *rdev)
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 4b76f2f3f4e4..8138c57a1e43 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -570,7 +570,9 @@ void c4iw_register_device(struct work_struct *work)
 	ret = set_netdevs(&dev->ibdev, &dev->rdev);
 	if (ret)
 		goto err_dealloc_ctx;
-	ret = ib_register_device(&dev->ibdev, "cxgb4_%d");
+	dma_set_max_seg_size(&dev->rdev.lldi.pdev->dev, UINT_MAX);
+	ret = ib_register_device(&dev->ibdev, "cxgb4_%d",
+				 &dev->rdev.lldi.pdev->dev);
 	if (ret)
 		goto err_dealloc_ctx;
 	return;
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 92d701146320..6faed3a81e08 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -331,7 +331,7 @@ static int efa_ib_device_add(struct efa_dev *dev)

 	ib_set_device_ops(&dev->ibdev, &efa_dev_ops);

-	err = ib_register_device(&dev->ibdev, "efa_%d");
+	err = ib_register_device(&dev->ibdev, "efa_%d", &pdev->dev);
 	if (err)
 		goto err_release_doorbell_bar;

@@ -418,7 +418,7 @@ static int efa_device_init(struct efa_com_dev *edev, struct pci_dev *pdev)
 			err);
 		return err;
 	}
-
+	dma_set_max_seg_size(&pdev->dev, UINT_MAX);
 	return 0;
 }

diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 467c82900019..afeffafc59f9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -549,7 +549,8 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 		if (ret)
 			return ret;
 	}
-	ret = ib_register_device(ib_dev, "hns_%d");
+	dma_set_max_seg_size(dev, UINT_MAX);
+	ret = ib_register_device(ib_dev, "hns_%d", dev);
 	if (ret) {
 		dev_err(dev, "ib_register_device failed!\n");
 		return ret;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 747b4de6faca..581ecbadf586 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -2761,7 +2761,8 @@ int i40iw_register_rdma_device(struct i40iw_device *iwdev)
 	if (ret)
 		goto error;

-	ret = ib_register_device(&iwibdev->ibdev, "i40iw%d");
+	dma_set_max_seg_size(&iwdev->hw.pcidev->dev, UINT_MAX);
+	ret = ib_register_device(&iwibdev->ibdev, "i40iw%d", &iwdev->hw.pcidev->dev);
 	if (ret)
 		goto error;

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 753c70402498..cd0fba6b0964 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2841,7 +2841,8 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 		goto err_steer_free_bitmap;

 	rdma_set_device_sysfs_group(&ibdev->ib_dev, &mlx4_attr_group);
-	if (ib_register_device(&ibdev->ib_dev, "mlx4_%d"))
+	if (ib_register_device(&ibdev->ib_dev, "mlx4_%d",
+			       &dev->persist->pdev->dev))
 		goto err_diag_counters;

 	if (mlx4_ib_mad_init(ibdev))
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 3ae681a6ae3b..bca57c7661eb 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4404,7 +4404,7 @@ static int mlx5_ib_stage_ib_reg_init(struct mlx5_ib_dev *dev)
 		name = "mlx5_%d";
 	else
 		name = "mlx5_bond_%d";
-	return ib_register_device(&dev->ib_dev, name);
+	return ib_register_device(&dev->ib_dev, name, &dev->mdev->pdev->dev);
 }

 static void mlx5_ib_stage_pre_ib_reg_umr_cleanup(struct mlx5_ib_dev *dev)
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 31b558ff8218..c4d9cdc4ee97 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -1206,7 +1206,7 @@ int mthca_register_device(struct mthca_dev *dev)
 	mutex_init(&dev->cap_mask_mutex);

 	rdma_set_device_sysfs_group(&dev->ib_dev, &mthca_attr_group);
-	ret = ib_register_device(&dev->ib_dev, "mthca%d");
+	ret = ib_register_device(&dev->ib_dev, "mthca%d", &dev->pdev->dev);
 	if (ret)
 		return ret;

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
index d8c47d24d6d6..9b96661a7143 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
@@ -255,7 +255,9 @@ static int ocrdma_register_device(struct ocrdma_dev *dev)
 	if (ret)
 		return ret;

-	return ib_register_device(&dev->ibdev, "ocrdma%d");
+	dma_set_max_seg_size(&dev->nic_info.pdev->dev, UINT_MAX);
+	return ib_register_device(&dev->ibdev, "ocrdma%d",
+				  &dev->nic_info.pdev->dev);
 }

 static int ocrdma_alloc_resources(struct ocrdma_dev *dev)
diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index 7c0aac3e635b..967641662b24 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -293,7 +293,8 @@ static int qedr_register_device(struct qedr_dev *dev)
 	if (rc)
 		return rc;

-	return ib_register_device(&dev->ibdev, "qedr%d");
+	dma_set_max_seg_size(&dev->pdev->dev, UINT_MAX);
+	return ib_register_device(&dev->ibdev, "qedr%d", &dev->pdev->dev);
 }

 /* This function allocates fast-path status block memory */
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniband/hw/usnic/usnic_ib_main.c
index 462ed71abf53..aa2e65fc5cd6 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
@@ -425,7 +425,8 @@ static void *usnic_ib_device_add(struct pci_dev *dev)
 	if (ret)
 		goto err_fwd_dealloc;

-	if (ib_register_device(&us_ibdev->ib_dev, "usnic_%d"))
+	dma_set_max_seg_size(&dev->dev, SZ_2G);
+	if (ib_register_device(&us_ibdev->ib_dev, "usnic_%d", &dev->dev))
 		goto err_fwd_dealloc;

 	usnic_fwd_set_mtu(us_ibdev->ufdev, us_ibdev->netdev->mtu);
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index 780fd2dfc07e..fa2a3fa0c3e4 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -270,7 +270,7 @@ static int pvrdma_register_device(struct pvrdma_dev *dev)
 	spin_lock_init(&dev->srq_tbl_lock);
 	rdma_set_device_sysfs_group(&dev->ib_dev, &pvrdma_attr_group);

-	ret = ib_register_device(&dev->ib_dev, "vmw_pvrdma%d");
+	ret = ib_register_device(&dev->ib_dev, "vmw_pvrdma%d", &dev->pdev->dev);
 	if (ret)
 		goto err_srq_free;

@@ -854,7 +854,7 @@ static int pvrdma_pci_probe(struct pci_dev *pdev,
 			goto err_free_resource;
 		}
 	}
-
+	dma_set_max_seg_size(&pdev->dev, UINT_MAX);
 	pci_set_master(pdev);

 	/* Map register space */
diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
index f904bb34477a..2f117ac11c8b 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -581,7 +581,11 @@ int rvt_register_device(struct rvt_dev_info *rdi)
 	spin_lock_init(&rdi->n_cqs_lock);

 	/* DMA Operations */
-	rdi->ibdev.dev.dma_ops = rdi->ibdev.dev.dma_ops ? : &dma_virt_ops;
+	rdi->ibdev.dev.dma_ops = &dma_virt_ops;
+	rdi->ibdev.dev.dma_parms = rdi->ibdev.dev.parent->dma_parms;
+	rdi->ibdev.dev.dma_mask = rdi->ibdev.dev.parent->dma_mask;
+	rdi->ibdev.dev.coherent_dma_mask =
+		rdi->ibdev.dev.parent->coherent_dma_mask;

 	/* Protection Domain */
 	spin_lock_init(&rdi->n_pds_lock);
@@ -629,7 +633,7 @@ int rvt_register_device(struct rvt_dev_info *rdi)
 		rdi->ibdev.num_comp_vectors = 1;

 	/* We are now good to announce we exist */
-	ret = ib_register_device(&rdi->ibdev, dev_name(&rdi->ibdev.dev));
+	ret = ib_register_device(&rdi->ibdev, dev_name(&rdi->ibdev.dev), NULL);
 	if (ret) {
 		rvt_pr_err(rdi, "Failed to register driver with ib core.\n");
 		goto bail_wss;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index f368dc16281a..37fee72755be 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1182,7 +1182,7 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	rxe->tfm = tfm;

 	rdma_set_device_sysfs_group(dev, &rxe_attr_group);
-	err = ib_register_device(dev, ibdev_name);
+	err = ib_register_device(dev, ibdev_name, NULL);
 	if (err)
 		pr_warn("%s failed with error %d\n", __func__, err);

diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index d862bec84376..0362d57b4db8 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -69,7 +69,7 @@ static int siw_device_register(struct siw_device *sdev, const char *name)

 	sdev->vendor_part_id = dev_id++;

-	rv = ib_register_device(base_dev, name);
+	rv = ib_register_device(base_dev, name, NULL);
 	if (rv) {
 		pr_warn("siw: device registration error %d\n", rv);
 		return rv;
@@ -386,6 +386,8 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
 	base_dev->dev.dma_parms = &sdev->dma_parms;
 	sdev->dma_parms = (struct device_dma_parameters)
 		{ .max_segment_size = SZ_2G };
+	dma_coerce_mask_and_coherent(&base_dev->dev,
+				     dma_get_required_mask(&base_dev->dev));
 	base_dev->num_comp_vectors = num_possible_cpus();

 	xa_init_flags(&sdev->qp_xa, XA_FLAGS_ALLOC1);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index c9f70063f4e4..c390513e7ba8 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2782,7 +2782,8 @@ void ib_dealloc_device(struct ib_device *device);

 void ib_get_device_fw_str(struct ib_device *device, char *str);

-int ib_register_device(struct ib_device *device, const char *name);
+int ib_register_device(struct ib_device *device, const char *name,
+		       struct device *dma_device);
 void ib_unregister_device(struct ib_device *device);
 void ib_unregister_driver(enum rdma_driver_id driver_id);
 void ib_unregister_device_and_put(struct ib_device *device);
--
2.26.2

