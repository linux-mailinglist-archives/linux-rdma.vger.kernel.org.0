Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5034B39D722
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 10:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhFGIUy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 04:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhFGIUr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 04:20:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E42C861029;
        Mon,  7 Jun 2021 08:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623053936;
        bh=yuGrchRppYyMb9x3dKgOdh+N9rVrG8C+z7TXWcH0ji4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h57MLnhZxTqFdiaiok6LBZjBNBPCeWxS+/yisJVUD0X8nal5y1AaN24wVO2owPA80
         hwxniQxB4FouJV0sSlpsp9WDakDu8j1wgCQ3SPfzUzwK1vVxLCCGDebwwf3GLHMdfX
         1+dVcr+5eH53MYahfqCcgQsq7oijDZgBDjWx25RLKashafzOb0lMx8z5KcI+wN3QYe
         JwjZ5EpfoiQWvYoaxpuTEJ8E83qq3quJ/31/bFLxygLtSfW0CpSxdmQKB8v7iv69yy
         OKiBAxjggq/sD1SyGjk3UQY2hy9dtXRnops1O499GjC/nPVGtk11R/ggDWh6pdoSGP
         iL4IVVUwK/vxg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
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
Subject: [PATCH rdma-next v1 15/15] RDMA: Remove rdma_set_device_sysfs_group()
Date:   Mon,  7 Jun 2021 11:17:40 +0300
Message-Id: <a006d786662a538c3805c8952962c78061926788.1623053078.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623053078.git.leonro@nvidia.com>
References: <cover.1623053078.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

The driver's device group can be specified as part of the ops structure
like the device's port group. No need for the complicated API.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c              |  4 ++-
 drivers/infiniband/hw/bnxt_re/main.c          |  2 +-
 drivers/infiniband/hw/cxgb4/provider.c        |  2 +-
 drivers/infiniband/hw/hfi1/verbs.c            |  4 +--
 drivers/infiniband/hw/mlx4/main.c             |  2 +-
 drivers/infiniband/hw/mlx5/main.c             |  2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c  |  2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_main.c    |  2 +-
 drivers/infiniband/hw/qedr/main.c             |  2 +-
 drivers/infiniband/hw/qib/qib_verbs.c         |  2 +-
 drivers/infiniband/hw/usnic/usnic_ib_main.c   |  3 +-
 .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c         |  2 +-
 include/rdma/ib_verbs.h                       | 30 +++++--------------
 14 files changed, 22 insertions(+), 39 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 92f224a97481..53a7ec66e0d1 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -586,7 +586,6 @@ struct ib_device *_ib_alloc_device(size_t size)
 		return NULL;
 	}
 
-	device->groups[0] = &ib_dev_attr_group;
 	rdma_init_coredev(&device->coredev, device, &init_net);
 
 	INIT_LIST_HEAD(&device->event_handler_list);
@@ -1396,6 +1395,8 @@ int ib_register_device(struct ib_device *device, const char *name,
 		return ret;
 	}
 
+	device->groups[0] = &ib_dev_attr_group;
+	device->groups[1] = device->ops.device_group;
 	ret = ib_setup_device_attrs(device);
 	if (ret)
 		goto cache_cleanup;
@@ -2643,6 +2644,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, destroy_rwq_ind_table);
 	SET_DEVICE_OP(dev_ops, destroy_srq);
 	SET_DEVICE_OP(dev_ops, destroy_wq);
+	SET_DEVICE_OP(dev_ops, device_group);
 	SET_DEVICE_OP(dev_ops, detach_mcast);
 	SET_DEVICE_OP(dev_ops, disassociate_ucontext);
 	SET_DEVICE_OP(dev_ops, drain_rq);
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 58bd905048ae..2798a03a6c31 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -647,6 +647,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.destroy_cq = bnxt_re_destroy_cq,
 	.destroy_qp = bnxt_re_destroy_qp,
 	.destroy_srq = bnxt_re_destroy_srq,
+	.device_group = &bnxt_re_dev_attr_group,
 	.get_dev_fw_str = bnxt_re_query_fw_str,
 	.get_dma_mr = bnxt_re_get_dma_mr,
 	.get_hw_stats = bnxt_re_ib_get_hw_stats,
@@ -693,7 +694,6 @@ static int bnxt_re_register_ib(struct bnxt_re_dev *rdev)
 	ibdev->dev.parent = &rdev->en_dev->pdev->dev;
 	ibdev->local_dma_lkey = BNXT_QPLIB_RSVD_LKEY;
 
-	rdma_set_device_sysfs_group(ibdev, &bnxt_re_dev_attr_group);
 	ib_set_device_ops(ibdev, &bnxt_re_dev_ops);
 	ret = ib_device_set_netdev(&rdev->ibdev, rdev->netdev, 1);
 	if (ret)
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 4e453d1dde11..881d515eb15a 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -465,6 +465,7 @@ static const struct ib_device_ops c4iw_dev_ops = {
 	.destroy_cq = c4iw_destroy_cq,
 	.destroy_qp = c4iw_destroy_qp,
 	.destroy_srq = c4iw_destroy_srq,
+	.device_group = &c4iw_attr_group,
 	.fill_res_cq_entry = c4iw_fill_res_cq_entry,
 	.fill_res_cm_id_entry = c4iw_fill_res_cm_id_entry,
 	.fill_res_mr_entry = c4iw_fill_res_mr_entry,
@@ -539,7 +540,6 @@ void c4iw_register_device(struct work_struct *work)
 	memcpy(dev->ibdev.iw_ifname, dev->rdev.lldi.ports[0]->name,
 	       sizeof(dev->ibdev.iw_ifname));
 
-	rdma_set_device_sysfs_group(&dev->ibdev, &c4iw_attr_group);
 	ib_set_device_ops(&dev->ibdev, &c4iw_dev_ops);
 	ret = set_netdevs(&dev->ibdev, &dev->rdev);
 	if (ret)
diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 49c6ed267a47..9b198c35e1a1 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1789,6 +1789,7 @@ static const struct ib_device_ops hfi1_dev_ops = {
 	.alloc_hw_device_stats = hfi1_alloc_hw_device_stats,
 	.alloc_hw_port_stats = hfi_alloc_hw_port_stats,
 	.alloc_rdma_netdev = hfi1_vnic_alloc_rn,
+	.device_group = &ib_hfi1_attr_group,
 	.get_dev_fw_str = hfi1_get_dev_fw_str,
 	.get_hw_stats = get_hw_stats,
 	.modify_device = modify_device,
@@ -1927,9 +1928,6 @@ int hfi1_register_ib_device(struct hfi1_devdata *dd)
 			      i,
 			      ppd->pkeys);
 
-	rdma_set_device_sysfs_group(&dd->verbs_dev.rdi.ibdev,
-				    &ib_hfi1_attr_group);
-
 	ret = rvt_register_device(&dd->verbs_dev.rdi);
 	if (ret)
 		goto err_verbs_txreq;
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 341162aa2175..6cdcbbc53843 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2547,6 +2547,7 @@ static const struct ib_device_ops mlx4_ib_dev_ops = {
 	.destroy_qp = mlx4_ib_destroy_qp,
 	.destroy_srq = mlx4_ib_destroy_srq,
 	.detach_mcast = mlx4_ib_mcg_detach,
+	.device_group = &mlx4_attr_group,
 	.disassociate_ucontext = mlx4_ib_disassociate_ucontext,
 	.drain_rq = mlx4_ib_drain_rq,
 	.drain_sq = mlx4_ib_drain_sq,
@@ -2806,7 +2807,6 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 	if (mlx4_ib_alloc_diag_counters(ibdev))
 		goto err_steer_free_bitmap;
 
-	rdma_set_device_sysfs_group(&ibdev->ib_dev, &mlx4_attr_group);
 	if (ib_register_device(&ibdev->ib_dev, "mlx4_%d",
 			       &dev->persist->pdev->dev))
 		goto err_diag_counters;
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index e541a9f5f163..c12517b63a8d 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3752,6 +3752,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.disassociate_ucontext = mlx5_ib_disassociate_ucontext,
 	.drain_rq = mlx5_ib_drain_rq,
 	.drain_sq = mlx5_ib_drain_sq,
+	.device_group = &mlx5_attr_group,
 	.enable_driver = mlx5_ib_enable_driver,
 	.get_dev_fw_str = get_dev_fw_str,
 	.get_dma_mr = mlx5_ib_get_dma_mr,
@@ -4039,7 +4040,6 @@ static int mlx5_ib_stage_ib_reg_init(struct mlx5_ib_dev *dev)
 {
 	const char *name;
 
-	rdma_set_device_sysfs_group(&dev->ib_dev, &mlx5_attr_group);
 	if (!mlx5_lag_is_roce(dev->mdev))
 		name = "mlx5_%d";
 	else
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 522bb606120e..adf4fcf0fee4 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -1099,6 +1099,7 @@ static const struct ib_device_ops mthca_dev_ops = {
 	.destroy_cq = mthca_destroy_cq,
 	.destroy_qp = mthca_destroy_qp,
 	.detach_mcast = mthca_multicast_detach,
+	.device_group = &mthca_attr_group,
 	.get_dev_fw_str = get_dev_fw_str,
 	.get_dma_mr = mthca_get_dma_mr,
 	.get_port_immutable = mthca_port_immutable,
@@ -1186,7 +1187,6 @@ int mthca_register_device(struct mthca_dev *dev)
 
 	mutex_init(&dev->cap_mask_mutex);
 
-	rdma_set_device_sysfs_group(&dev->ib_dev, &mthca_attr_group);
 	ret = ib_register_device(&dev->ib_dev, "mthca%d", &dev->pdev->dev);
 	if (ret)
 		return ret;
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
index 4882b3156edb..f329db0c591f 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
@@ -161,6 +161,7 @@ static const struct ib_device_ops ocrdma_dev_ops = {
 	.destroy_ah = ocrdma_destroy_ah,
 	.destroy_cq = ocrdma_destroy_cq,
 	.destroy_qp = ocrdma_destroy_qp,
+	.device_group = &ocrdma_attr_group,
 	.get_dev_fw_str = get_dev_fw_str,
 	.get_dma_mr = ocrdma_get_dma_mr,
 	.get_link_layer = ocrdma_link_layer,
@@ -218,7 +219,6 @@ static int ocrdma_register_device(struct ocrdma_dev *dev)
 	if (ocrdma_get_asic_type(dev) == OCRDMA_ASIC_GEN_SKH_R)
 		ib_set_device_ops(&dev->ibdev, &ocrdma_dev_srq_ops);
 
-	rdma_set_device_sysfs_group(&dev->ibdev, &ocrdma_attr_group);
 	ret = ib_device_set_netdev(&dev->ibdev, dev->nic_info.netdev, 1);
 	if (ret)
 		return ret;
diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index 8334a9850220..de98e0604f91 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -208,6 +208,7 @@ static const struct ib_device_ops qedr_dev_ops = {
 	.destroy_cq = qedr_destroy_cq,
 	.destroy_qp = qedr_destroy_qp,
 	.destroy_srq = qedr_destroy_srq,
+	.device_group = &qedr_attr_group,
 	.get_dev_fw_str = qedr_get_dev_fw_str,
 	.get_dma_mr = qedr_get_dma_mr,
 	.get_link_layer = qedr_link_layer,
@@ -256,7 +257,6 @@ static int qedr_register_device(struct qedr_dev *dev)
 	dev->ibdev.num_comp_vectors = dev->num_cnq;
 	dev->ibdev.dev.parent = &dev->pdev->dev;
 
-	rdma_set_device_sysfs_group(&dev->ibdev, &qedr_attr_group);
 	ib_set_device_ops(&dev->ibdev, &qedr_dev_ops);
 
 	rc = ib_device_set_netdev(&dev->ibdev, dev->ndev, 1);
diff --git a/drivers/infiniband/hw/qib/qib_verbs.c b/drivers/infiniband/hw/qib/qib_verbs.c
index 8640a75d61d9..ef91bff5c23c 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.c
+++ b/drivers/infiniband/hw/qib/qib_verbs.c
@@ -1484,6 +1484,7 @@ static const struct ib_device_ops qib_dev_ops = {
 	.driver_id = RDMA_DRIVER_QIB,
 
 	.port_groups = qib_attr_port_groups,
+	.device_group = &qib_attr_group,
 	.modify_device = qib_modify_device,
 	.process_mad = qib_process_mad,
 };
@@ -1612,7 +1613,6 @@ int qib_register_ib_device(struct qib_devdata *dd)
 			      i,
 			      dd->rcd[ctxt]->pkeys);
 	}
-	rdma_set_device_sysfs_group(&dd->verbs_dev.rdi.ibdev, &qib_attr_group);
 
 	ib_set_device_ops(ibdev, &qib_dev_ops);
 	ret = rvt_register_device(&dd->verbs_dev.rdi);
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniband/hw/usnic/usnic_ib_main.c
index ff6a40e259d5..c49f9e19d926 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
@@ -347,6 +347,7 @@ static const struct ib_device_ops usnic_dev_ops = {
 	.dereg_mr = usnic_ib_dereg_mr,
 	.destroy_cq = usnic_ib_destroy_cq,
 	.destroy_qp = usnic_ib_destroy_qp,
+	.device_group = &usnic_attr_group,
 	.get_dev_fw_str = usnic_get_dev_fw_str,
 	.get_link_layer = usnic_ib_port_link_layer,
 	.get_port_immutable = usnic_port_immutable,
@@ -400,8 +401,6 @@ static void *usnic_ib_device_add(struct pci_dev *dev)
 
 	ib_set_device_ops(&us_ibdev->ib_dev, &usnic_dev_ops);
 
-	rdma_set_device_sysfs_group(&us_ibdev->ib_dev, &usnic_attr_group);
-
 	ret = ib_device_set_netdev(&us_ibdev->ib_dev, us_ibdev->netdev, 1);
 	if (ret)
 		goto err_fwd_dealloc;
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index 6bf2d2e47d07..8ed8bc24c69f 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -162,6 +162,7 @@ static const struct ib_device_ops pvrdma_dev_ops = {
 	.destroy_ah = pvrdma_destroy_ah,
 	.destroy_cq = pvrdma_destroy_cq,
 	.destroy_qp = pvrdma_destroy_qp,
+	.device_group = &pvrdma_attr_group,
 	.get_dev_fw_str = pvrdma_get_fw_ver_str,
 	.get_dma_mr = pvrdma_get_dma_mr,
 	.get_link_layer = pvrdma_port_link_layer,
@@ -240,7 +241,6 @@ static int pvrdma_register_device(struct pvrdma_dev *dev)
 	if (ret)
 		goto err_srq_free;
 	spin_lock_init(&dev->srq_tbl_lock);
-	rdma_set_device_sysfs_group(&dev->ib_dev, &pvrdma_attr_group);
 
 	ret = ib_register_device(&dev->ib_dev, "vmw_pvrdma%d", &dev->pdev->dev);
 	if (ret)
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index d3df59d897a7..90dd513cf993 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1123,6 +1123,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.destroy_qp = rxe_destroy_qp,
 	.destroy_srq = rxe_destroy_srq,
 	.detach_mcast = rxe_detach_mcast,
+	.device_group = &rxe_attr_group,
 	.enable_driver = rxe_enable_driver,
 	.get_dma_mr = rxe_get_dma_mr,
 	.get_hw_stats = rxe_ib_get_hw_stats,
@@ -1189,7 +1190,6 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	}
 	rxe->tfm = tfm;
 
-	rdma_set_device_sysfs_group(dev, &rxe_attr_group);
 	err = ib_register_device(dev, ibdev_name, NULL);
 	if (err)
 		pr_warn("%s failed with error %d\n", __func__, err);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 303471585dde..9423e70a881c 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2300,6 +2300,12 @@ struct ib_device_ops {
 	u32 uverbs_abi_ver;
 	unsigned int uverbs_no_driver_id_binding:1;
 
+	/*
+	 * NOTE: New drivers should not make use of device_group; instead new
+	 * device parameter should be exposed via netlink command. This
+	 * mechanism exists only for existing drivers.
+	 */
+	const struct attribute_group *device_group;
 	const struct attribute_group **port_groups;
 
 	int (*post_send)(struct ib_qp *qp, const struct ib_send_wr *send_wr,
@@ -4567,28 +4573,6 @@ int rdma_init_netdev(struct ib_device *device, u32 port_num,
 		     void (*setup)(struct net_device *),
 		     struct net_device *netdev);
 
-/**
- * rdma_set_device_sysfs_group - Set device attributes group to have
- *				 driver specific sysfs entries at
- *				 for infiniband class.
- *
- * @device:	device pointer for which attributes to be created
- * @group:	Pointer to group which should be added when device
- *		is registered with sysfs.
- * rdma_set_device_sysfs_group() allows existing drivers to expose one
- * group per device to have sysfs attributes.
- *
- * NOTE: New drivers should not make use of this API; instead new device
- * parameter should be exposed via netlink command. This API and mechanism
- * exist only for existing drivers.
- */
-static inline void
-rdma_set_device_sysfs_group(struct ib_device *dev,
-			    const struct attribute_group *group)
-{
-	dev->groups[1] = group;
-}
-
 /**
  * rdma_device_to_ibdev - Get ib_device pointer from device pointer
  *
@@ -4624,7 +4608,7 @@ static inline int ibdev_to_node(struct ib_device *ibdev)
  *
  * NOTE: New drivers should not make use of this API; This API is only for
  * existing drivers who have exposed sysfs entries using
- * rdma_set_device_sysfs_group().
+ * ops->device_group.
  */
 #define rdma_device_to_drv_device(dev, drv_dev_struct, ibdev_member)           \
 	container_of(rdma_device_to_ibdev(dev), drv_dev_struct, ibdev_member)
-- 
2.31.1

