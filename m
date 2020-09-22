Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E860273F58
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 12:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgIVKOf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 06:14:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIVKOf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Sep 2020 06:14:35 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C7EE238D6;
        Tue, 22 Sep 2020 10:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600769674;
        bh=4+upjP1r+u0arIBw2JywABUcqID4YdX9/F+jeTxBJU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VCuwOuXa1vVcNAZFUfTXWYo1nxd6abermVhQAc7ayFpiSMf+/w22ApMVrCDN6sOOb
         +S2d34gNdpKx7/11TwLpNnHIZK6UMgXEV5nkRUOl28Xi+bZDWMEEz4tB7K0+8fFU2U
         FO+rIKyEFhubSWtiSOZsPWf5trs6rFI4RwLVsaWk=
Date:   Tue, 22 Sep 2020 13:14:29 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
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
Subject: Re: [PATCH rdma-next] RDMA: Explicitly pass in the dma_device to
 ib_register_device
Message-ID: <20200922101429.GF1223944@unreal>
References: <20200922082745.2149973-1-leon@kernel.org>
 <OFA7334E75.E0306A27-ON002585EB.003059A0-002585EB.0031440E@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFA7334E75.E0306A27-ON002585EB.003059A0-002585EB.0031440E@notes.na.collabserv.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 22, 2020 at 08:58:06AM +0000, Bernard Metzler wrote:
> -----"Leon Romanovsky" <leon@kernel.org> wrote: -----
>
> >To: "Doug Ledford" <dledford@redhat.com>, "Jason Gunthorpe"
> ><jgg@nvidia.com>
> >From: "Leon Romanovsky" <leon@kernel.org>
> >Date: 09/22/2020 10:28AM
> >Cc: "Adit Ranadive" <aditr@vmware.com>, "Ariel Elior"
> ><aelior@marvell.com>, "Bernard Metzler" <bmt@zurich.ibm.com>,
> >"Christian Benvenuti" <benve@cisco.com>, "Dennis Dalessandro"
> ><dennis.dalessandro@intel.com>, "Devesh Sharma"
> ><devesh.sharma@broadcom.com>, "Faisal Latif"
> ><faisal.latif@intel.com>, "Gal Pressman" <galpress@amazon.com>,
> >"Lijun Ou" <oulijun@huawei.com>, linux-rdma@vger.kernel.org, "Michal
> >Kalderon" <mkalderon@marvell.com>, "Mike Marciniszyn"
> ><mike.marciniszyn@intel.com>, "Naresh Kumar PBS"
> ><nareshkumar.pbs@broadcom.com>, "Nelson Escobar"
> ><neescoba@cisco.com>, "Parav Pandit" <parav@nvidia.com>, "Parvi
> >Kaustubhi" <pkaustub@cisco.com>, "Potnuri Bharat Teja"
> ><bharat@chelsio.com>, "Selvin Xavier" <selvin.xavier@broadcom.com>,
> >"Shiraz Saleem" <shiraz.saleem@intel.com>, "Somnath Kotur"
> ><somnath.kotur@broadcom.com>, "Sriharsha Basavapatna"
> ><sriharsha.basavapatna@broadcom.com>, "VMware PV-Drivers"
> ><pv-drivers@vmware.com>, "Weihang Li" <liweihang@huawei.com>, "Wei
> >Hu(Xavier)" <huwei87@hisilicon.com>, "Yishai Hadas"
> ><yishaih@nvidia.com>, "Zhu Yanjun" <yanjunz@nvidia.com>
> >Subject: [EXTERNAL] [PATCH rdma-next] RDMA: Explicitly pass in the
> >dma_device to ib_register_device
> >
> >From: Jason Gunthorpe <jgg@nvidia.com>
> >
> >The current design is convoulted where the IB core makes assumptions
> >that a real DMA device will usually come from parent unless it looks
> >like the ib_device is partially setup for DMA, in which case the
> >ib_device itself is used for DMA, but somethings might still come
> >from the parent.
> >
> >Make this clearer by having the caller explicitly specify what the
> >DMA device should be. The caller is always responsible to fully
> >setup the DMA device it specifies. If NULL is used then the
> >ib_device will be used as the DMA device, but the caller must
> >still set it up completely.
> >
> >rvt is the only driver that did not fully setup the DMA device
> >before registering. Move the rvt specific code out of
> >setup_dma_device() into rvt and set the dma_mask's directly.
> >
> >Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> >Reviewed-by: Parav Pandit <parav@nvidia.com>
> >Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >---
> > drivers/infiniband/core/device.c              | 73
> >+++++++------------
> > drivers/infiniband/hw/bnxt_re/main.c          |  2 +-
> > drivers/infiniband/hw/cxgb4/provider.c        |  3 +-
> > drivers/infiniband/hw/efa/efa_main.c          |  2 +-
> > drivers/infiniband/hw/hns/hns_roce_main.c     |  2 +-
> > drivers/infiniband/hw/i40iw/i40iw_verbs.c     |  2 +-
> > drivers/infiniband/hw/mlx4/main.c             |  3 +-
> > drivers/infiniband/hw/mlx5/main.c             |  2 +-
> > drivers/infiniband/hw/mthca/mthca_provider.c  |  2 +-
> > drivers/infiniband/hw/ocrdma/ocrdma_main.c    |  3 +-
> > drivers/infiniband/hw/qedr/main.c             |  2 +-
> > drivers/infiniband/hw/usnic/usnic_ib_main.c   |  2 +-
> > .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  2 +-
> > drivers/infiniband/sw/rdmavt/vt.c             |  8 +-
> > drivers/infiniband/sw/rxe/rxe_verbs.c         |  2 +-
> > drivers/infiniband/sw/siw/siw_main.c          |  4 +-
> > include/rdma/ib_verbs.h                       |  3 +-
> > 17 files changed, 52 insertions(+), 65 deletions(-)
> >
> >diff --git a/drivers/infiniband/core/device.c
> >b/drivers/infiniband/core/device.c
> >index ec3becf85cac..417d93bbdaca 100644
> >--- a/drivers/infiniband/core/device.c
> >+++ b/drivers/infiniband/core/device.c
> >@@ -1177,58 +1177,34 @@ static int assign_name(struct ib_device
> >*device, const char *name)
> > 	return ret;
> > }
> >
> >-static void setup_dma_device(struct ib_device *device)
> >+static void setup_dma_device(struct ib_device *device,
> >+			     struct device *dma_device)
> > {
> >-	struct device *parent = device->dev.parent;
> >-
> >-	WARN_ON_ONCE(device->dma_device);
> >-
> >-#ifdef CONFIG_DMA_OPS
> >-	if (device->dev.dma_ops) {
> >+	if (!dma_device) {
> > 		/*
> >-		 * The caller provided custom DMA operations. Copy the
> >-		 * DMA-related fields that are used by e.g. dma_alloc_coherent()
> >-		 * into device->dev.
> >+		 * If the caller does not provide a DMA capable device then the
> >+		 * IB device will be used. In this case the caller should fully
> >+		 * setup the ibdev for DMA. This usually means using
> >+		 * dma_virt_ops.
> > 		 */
> >-		device->dma_device = &device->dev;
> >-		if (!device->dev.dma_mask) {
> >-			if (parent)
> >-				device->dev.dma_mask = parent->dma_mask;
> >-			else
> >-				WARN_ON_ONCE(true);
> >-		}
> >-		if (!device->dev.coherent_dma_mask) {
> >-			if (parent)
> >-				device->dev.coherent_dma_mask =
> >-					parent->coherent_dma_mask;
> >-			else
> >-				WARN_ON_ONCE(true);
> >-		}
> >-	} else
> >-#endif /* CONFIG_DMA_OPS */
> >-	{
> >+#ifdef CONFIG_DMA_OPS
> >+		if (WARN_ON(!device->dev.dma_ops))
> >+			return;
> >+#endif
> >+		if (WARN_ON(!device->dev.dma_parms))
> >+			return;
> >+
> >+		dma_device = &device->dev;
> >+	} else {
> >+		device->dev.dma_parms = dma_device->dma_parms;
> > 		/*
> >-		 * The caller did not provide custom DMA operations. Use the
> >-		 * DMA mapping operations of the parent device.
> >+		 * Auto setup the segment size if a DMA device was passed in.
> >+		 * The PCI core sets the maximum segment size to 64 KB. Increase
> >+		 * this parameter to 2 GB.
> > 		 */
> >-		WARN_ON_ONCE(!parent);
> >-		device->dma_device = parent;
> >-	}
> >-
> >-	if (!device->dev.dma_parms) {
> >-		if (parent) {
> >-			/*
> >-			 * The caller did not provide DMA parameters, so
> >-			 * 'parent' probably represents a PCI device. The PCI
> >-			 * core sets the maximum segment size to 64
> >-			 * KB. Increase this parameter to 2 GB.
> >-			 */
> >-			device->dev.dma_parms = parent->dma_parms;
> >-			dma_set_max_seg_size(device->dma_device, SZ_2G);
> >-		} else {
> >-			WARN_ON_ONCE(true);
> >-		}
> >+		dma_set_max_seg_size(dma_device, SZ_2G);
> > 	}
> >+	device->dma_device = dma_device;
> > }
> >
> > /*
> >@@ -1241,7 +1217,6 @@ static int setup_device(struct ib_device
> >*device)
> > 	struct ib_udata uhw = {.outlen = 0, .inlen = 0};
> > 	int ret;
> >
> >-	setup_dma_device(device);
> > 	ib_device_check_mandatory(device);
> >
> > 	ret = setup_port_data(device);
> >@@ -1361,7 +1336,8 @@ static void prevent_dealloc_device(struct
> >ib_device *ib_dev)
> >  * asynchronously then the device pointer may become freed as soon
> >as this
> >  * function returns.
> >  */
> >-int ib_register_device(struct ib_device *device, const char *name)
> >+int ib_register_device(struct ib_device *device, const char *name,
> >+		       struct device *dma_device)
> > {
> > 	int ret;
> >
> >@@ -1369,6 +1345,7 @@ int ib_register_device(struct ib_device
> >*device, const char *name)
> > 	if (ret)
> > 		return ret;
> >
> >+	setup_dma_device(device, dma_device);
> > 	ret = setup_device(device);
> > 	if (ret)
> > 		return ret;
> >diff --git a/drivers/infiniband/hw/bnxt_re/main.c
> >b/drivers/infiniband/hw/bnxt_re/main.c
> >index 53aee5a42ab8..b3bc62021039 100644
> >--- a/drivers/infiniband/hw/bnxt_re/main.c
> >+++ b/drivers/infiniband/hw/bnxt_re/main.c
> >@@ -736,7 +736,7 @@ static int bnxt_re_register_ib(struct bnxt_re_dev
> >*rdev)
> > 	if (ret)
> > 		return ret;
> >
> >-	return ib_register_device(ibdev, "bnxt_re%d");
> >+	return ib_register_device(ibdev, "bnxt_re%d",
> >&rdev->en_dev->pdev->dev);
> > }
> >
> > static void bnxt_re_dev_remove(struct bnxt_re_dev *rdev)
> >diff --git a/drivers/infiniband/hw/cxgb4/provider.c
> >b/drivers/infiniband/hw/cxgb4/provider.c
> >index 4b76f2f3f4e4..5f4f3abf41e4 100644
> >--- a/drivers/infiniband/hw/cxgb4/provider.c
> >+++ b/drivers/infiniband/hw/cxgb4/provider.c
> >@@ -570,7 +570,8 @@ void c4iw_register_device(struct work_struct
> >*work)
> > 	ret = set_netdevs(&dev->ibdev, &dev->rdev);
> > 	if (ret)
> > 		goto err_dealloc_ctx;
> >-	ret = ib_register_device(&dev->ibdev, "cxgb4_%d");
> >+	ret = ib_register_device(&dev->ibdev, "cxgb4_%d",
> >+				 &dev->rdev.lldi.pdev->dev);
> > 	if (ret)
> > 		goto err_dealloc_ctx;
> > 	return;
> >diff --git a/drivers/infiniband/hw/efa/efa_main.c
> >b/drivers/infiniband/hw/efa/efa_main.c
> >index 92d701146320..4de5be3e1dfe 100644
> >--- a/drivers/infiniband/hw/efa/efa_main.c
> >+++ b/drivers/infiniband/hw/efa/efa_main.c
> >@@ -331,7 +331,7 @@ static int efa_ib_device_add(struct efa_dev *dev)
> >
> > 	ib_set_device_ops(&dev->ibdev, &efa_dev_ops);
> >
> >-	err = ib_register_device(&dev->ibdev, "efa_%d");
> >+	err = ib_register_device(&dev->ibdev, "efa_%d", &pdev->dev);
> > 	if (err)
> > 		goto err_release_doorbell_bar;
> >
> >diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c
> >b/drivers/infiniband/hw/hns/hns_roce_main.c
> >index 2b4d75733e72..1b5f895d7daf 100644
> >--- a/drivers/infiniband/hw/hns/hns_roce_main.c
> >+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> >@@ -547,7 +547,7 @@ static int hns_roce_register_device(struct
> >hns_roce_dev *hr_dev)
> > 		if (ret)
> > 			return ret;
> > 	}
> >-	ret = ib_register_device(ib_dev, "hns_%d");
> >+	ret = ib_register_device(ib_dev, "hns_%d", dev);
> > 	if (ret) {
> > 		dev_err(dev, "ib_register_device failed!\n");
> > 		return ret;
> >diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> >b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> >index e53f6c0dc12e..945d30a86bbc 100644
> >--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> >+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> >@@ -2748,7 +2748,7 @@ int i40iw_register_rdma_device(struct
> >i40iw_device *iwdev)
> > 	if (ret)
> > 		goto error;
> >
> >-	ret = ib_register_device(&iwibdev->ibdev, "i40iw%d");
> >+	ret = ib_register_device(&iwibdev->ibdev, "i40iw%d",
> >&iwdev->hw.pcidev->dev);
> > 	if (ret)
> > 		goto error;
> >
> >diff --git a/drivers/infiniband/hw/mlx4/main.c
> >b/drivers/infiniband/hw/mlx4/main.c
> >index 753c70402498..cd0fba6b0964 100644
> >--- a/drivers/infiniband/hw/mlx4/main.c
> >+++ b/drivers/infiniband/hw/mlx4/main.c
> >@@ -2841,7 +2841,8 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
> > 		goto err_steer_free_bitmap;
> >
> > 	rdma_set_device_sysfs_group(&ibdev->ib_dev, &mlx4_attr_group);
> >-	if (ib_register_device(&ibdev->ib_dev, "mlx4_%d"))
> >+	if (ib_register_device(&ibdev->ib_dev, "mlx4_%d",
> >+			       &dev->persist->pdev->dev))
> > 		goto err_diag_counters;
> >
> > 	if (mlx4_ib_mad_init(ibdev))
> >diff --git a/drivers/infiniband/hw/mlx5/main.c
> >b/drivers/infiniband/hw/mlx5/main.c
> >index 3ae681a6ae3b..bca57c7661eb 100644
> >--- a/drivers/infiniband/hw/mlx5/main.c
> >+++ b/drivers/infiniband/hw/mlx5/main.c
> >@@ -4404,7 +4404,7 @@ static int mlx5_ib_stage_ib_reg_init(struct
> >mlx5_ib_dev *dev)
> > 		name = "mlx5_%d";
> > 	else
> > 		name = "mlx5_bond_%d";
> >-	return ib_register_device(&dev->ib_dev, name);
> >+	return ib_register_device(&dev->ib_dev, name,
> >&dev->mdev->pdev->dev);
> > }
> >
> > static void mlx5_ib_stage_pre_ib_reg_umr_cleanup(struct mlx5_ib_dev
> >*dev)
> >diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c
> >b/drivers/infiniband/hw/mthca/mthca_provider.c
> >index 31b558ff8218..c4d9cdc4ee97 100644
> >--- a/drivers/infiniband/hw/mthca/mthca_provider.c
> >+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
> >@@ -1206,7 +1206,7 @@ int mthca_register_device(struct mthca_dev
> >*dev)
> > 	mutex_init(&dev->cap_mask_mutex);
> >
> > 	rdma_set_device_sysfs_group(&dev->ib_dev, &mthca_attr_group);
> >-	ret = ib_register_device(&dev->ib_dev, "mthca%d");
> >+	ret = ib_register_device(&dev->ib_dev, "mthca%d", &dev->pdev->dev);
> > 	if (ret)
> > 		return ret;
> >
> >diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
> >b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
> >index d8c47d24d6d6..60416186f1d0 100644
> >--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
> >+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
> >@@ -255,7 +255,8 @@ static int ocrdma_register_device(struct
> >ocrdma_dev *dev)
> > 	if (ret)
> > 		return ret;
> >
> >-	return ib_register_device(&dev->ibdev, "ocrdma%d");
> >+	return ib_register_device(&dev->ibdev, "ocrdma%d",
> >+				  &dev->nic_info.pdev->dev);
> > }
> >
> > static int ocrdma_alloc_resources(struct ocrdma_dev *dev)
> >diff --git a/drivers/infiniband/hw/qedr/main.c
> >b/drivers/infiniband/hw/qedr/main.c
> >index 7c0aac3e635b..464becdd41f7 100644
> >--- a/drivers/infiniband/hw/qedr/main.c
> >+++ b/drivers/infiniband/hw/qedr/main.c
> >@@ -293,7 +293,7 @@ static int qedr_register_device(struct qedr_dev
> >*dev)
> > 	if (rc)
> > 		return rc;
> >
> >-	return ib_register_device(&dev->ibdev, "qedr%d");
> >+	return ib_register_device(&dev->ibdev, "qedr%d", &dev->pdev->dev);
> > }
> >
> > /* This function allocates fast-path status block memory */
> >diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c
> >b/drivers/infiniband/hw/usnic/usnic_ib_main.c
> >index 462ed71abf53..6c23a5472168 100644
> >--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
> >+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
> >@@ -425,7 +425,7 @@ static void *usnic_ib_device_add(struct pci_dev
> >*dev)
> > 	if (ret)
> > 		goto err_fwd_dealloc;
> >
> >-	if (ib_register_device(&us_ibdev->ib_dev, "usnic_%d"))
> >+	if (ib_register_device(&us_ibdev->ib_dev, "usnic_%d", &dev->dev))
> > 		goto err_fwd_dealloc;
> >
> > 	usnic_fwd_set_mtu(us_ibdev->ufdev, us_ibdev->netdev->mtu);
> >diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
> >b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
> >index 780fd2dfc07e..5b2c94441125 100644
> >--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
> >+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
> >@@ -270,7 +270,7 @@ static int pvrdma_register_device(struct
> >pvrdma_dev *dev)
> > 	spin_lock_init(&dev->srq_tbl_lock);
> > 	rdma_set_device_sysfs_group(&dev->ib_dev, &pvrdma_attr_group);
> >
> >-	ret = ib_register_device(&dev->ib_dev, "vmw_pvrdma%d");
> >+	ret = ib_register_device(&dev->ib_dev, "vmw_pvrdma%d",
> >&dev->pdev->dev);
> > 	if (ret)
> > 		goto err_srq_free;
> >
> >diff --git a/drivers/infiniband/sw/rdmavt/vt.c
> >b/drivers/infiniband/sw/rdmavt/vt.c
> >index f904bb34477a..2f117ac11c8b 100644
> >--- a/drivers/infiniband/sw/rdmavt/vt.c
> >+++ b/drivers/infiniband/sw/rdmavt/vt.c
> >@@ -581,7 +581,11 @@ int rvt_register_device(struct rvt_dev_info
> >*rdi)
> > 	spin_lock_init(&rdi->n_cqs_lock);
> >
> > 	/* DMA Operations */
> >-	rdi->ibdev.dev.dma_ops = rdi->ibdev.dev.dma_ops ? : &dma_virt_ops;
> >+	rdi->ibdev.dev.dma_ops = &dma_virt_ops;
> >+	rdi->ibdev.dev.dma_parms = rdi->ibdev.dev.parent->dma_parms;
> >+	rdi->ibdev.dev.dma_mask = rdi->ibdev.dev.parent->dma_mask;
> >+	rdi->ibdev.dev.coherent_dma_mask =
> >+		rdi->ibdev.dev.parent->coherent_dma_mask;
> >
> > 	/* Protection Domain */
> > 	spin_lock_init(&rdi->n_pds_lock);
> >@@ -629,7 +633,7 @@ int rvt_register_device(struct rvt_dev_info *rdi)
> > 		rdi->ibdev.num_comp_vectors = 1;
> >
> > 	/* We are now good to announce we exist */
> >-	ret = ib_register_device(&rdi->ibdev, dev_name(&rdi->ibdev.dev));
> >+	ret = ib_register_device(&rdi->ibdev, dev_name(&rdi->ibdev.dev),
> >NULL);
> > 	if (ret) {
> > 		rvt_pr_err(rdi, "Failed to register driver with ib core.\n");
> > 		goto bail_wss;
> >diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c
> >b/drivers/infiniband/sw/rxe/rxe_verbs.c
> >index f368dc16281a..37fee72755be 100644
> >--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> >+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> >@@ -1182,7 +1182,7 @@ int rxe_register_device(struct rxe_dev *rxe,
> >const char *ibdev_name)
> > 	rxe->tfm = tfm;
> >
> > 	rdma_set_device_sysfs_group(dev, &rxe_attr_group);
> >-	err = ib_register_device(dev, ibdev_name);
> >+	err = ib_register_device(dev, ibdev_name, NULL);
> > 	if (err)
> > 		pr_warn("%s failed with error %d\n", __func__, err);
> >
> >diff --git a/drivers/infiniband/sw/siw/siw_main.c
> >b/drivers/infiniband/sw/siw/siw_main.c
> >index d862bec84376..0362d57b4db8 100644
> >--- a/drivers/infiniband/sw/siw/siw_main.c
> >+++ b/drivers/infiniband/sw/siw/siw_main.c
> >@@ -69,7 +69,7 @@ static int siw_device_register(struct siw_device
> >*sdev, const char *name)
> >
> > 	sdev->vendor_part_id = dev_id++;
> >
> >-	rv = ib_register_device(base_dev, name);
> >+	rv = ib_register_device(base_dev, name, NULL);
> > 	if (rv) {
> > 		pr_warn("siw: device registration error %d\n", rv);
> > 		return rv;
> >@@ -386,6 +386,8 @@ static struct siw_device
> >*siw_device_create(struct net_device *netdev)
> > 	base_dev->dev.dma_parms = &sdev->dma_parms;
> > 	sdev->dma_parms = (struct device_dma_parameters)
> > 		{ .max_segment_size = SZ_2G };
> >+	dma_coerce_mask_and_coherent(&base_dev->dev,
> >+				     dma_get_required_mask(&base_dev->dev));
>
> Leon, can you please help me to understand this
> additional logic? Do we need to setup the DMA device
> for (software) RDMA devices which rely on dma_virt_ops
> in the end, or better leave it untouched?

The logic that driver is responsible to give right DMA device,
so yes, you are setting here mask from dma_virt_ops, as RXE did.

Thanks

>
> Thanks very much!
> Bernard.
>
