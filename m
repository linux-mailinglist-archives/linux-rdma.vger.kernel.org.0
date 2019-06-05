Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07243362DC
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 19:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfFERjc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 13:39:32 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43030 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfFERjb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 13:39:31 -0400
Received: by mail-qt1-f194.google.com with SMTP id z24so11810529qtj.10
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 10:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/rvf4gPfASuYg6P8OPT5Qh5P52eC6sVpg2O30l2RG3s=;
        b=lM9pC/XcbwjHTkc5I9HE8t66i+vaEnRdFxmeYXKWxIEbiKuJaR79FmMbMemxn+CwEq
         VzjxzQvCw6abAgNCN+ed+jtK6IE68wzdS7qSQaoYo+LsL5VBdxwtXHiwYBdobjxewoo/
         vXCbpIgcVjZmp4hFG54rjLGKgNTpSK1HXrK0cv5D/X4/epz/7+ynmFHg3TIGY8Cp/1Nn
         Agn8Rd6a0EIjvBuLN+ZwUmcxLoQJcvw8MbtAYZWjpjiAxrfOvTF5R6DgaZI6ZyXsJlQh
         I/a2/M4e79mTAoLP9uzHsTh/oyZSvvwwec9wTZzEMX2f9BD3XmGRStPSMLfHQTqpzmUD
         pnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/rvf4gPfASuYg6P8OPT5Qh5P52eC6sVpg2O30l2RG3s=;
        b=rgQjX5j3COLVwb5iyHI1zECOgZ/Zwcj04GOAnrEjt8LMs9NtFLQhUckbMNociXh1YW
         DQ2XMEu3qBM7xsx5rVam2aD4PCo8MwFtnWUtQEyWuTVZnJQTSt/gSJp8EVDGupH0OWN/
         BZxb5u+lq2y7UmAAvyqp/ImI6QjZnDlrpgJxVQOcTw6hu7Ni5yhLofg50TZU2Uz9IZXU
         VL9gxKVThNjLAVH94LkTyW33IdTwhfTsSBO65hIyvaY6z9o27NwNrAwoLf3VdI3dO+Rs
         BPyuW/U5VGhEOHy+kiuvRfdKHw+WpAmz7pxazzSWn4G1/eHM6giLjLHtNaBuui7ZL2q1
         6C5A==
X-Gm-Message-State: APjAAAXIT3y/J71JYFXUlUCbJAUZzDQ+gOUBI7NZ3E3Wx3LDV19nSPh5
        8HsjvDTTvE7Fo4jo8sT83fMT9FPTIP6DaA==
X-Google-Smtp-Source: APXvYqzrzCsStpIkGG83YRLfi10PVzPO9nO8ptAvWhGfunCimUEFLZc+2EOAqA50rlfF1pRoGvz8Pw==
X-Received: by 2002:a0c:ad85:: with SMTP id w5mr33768335qvc.242.1559756369720;
        Wed, 05 Jun 2019 10:39:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id a16sm7555249qtj.9.2019.06.05.10.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 10:39:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYZsl-0004gS-O2; Wed, 05 Jun 2019 14:39:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 2/3] RDMA: Move uverbs_abi_ver into struct ib_device_ops
Date:   Wed,  5 Jun 2019 14:39:25 -0300
Message-Id: <20190605173926.16995-3-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605173926.16995-1-jgg@ziepe.ca>
References: <20190605173926.16995-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

No reason for every driver to emit code to set this, just make it part of
the driver's existing static const ops structure.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/device.c               |  2 ++
 drivers/infiniband/core/uverbs_main.c          |  2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c       |  6 +++---
 drivers/infiniband/hw/bnxt_re/main.c           |  2 +-
 drivers/infiniband/hw/cxgb3/iwch_provider.c    |  2 +-
 drivers/infiniband/hw/cxgb4/provider.c         |  2 +-
 drivers/infiniband/hw/efa/efa_main.c           |  2 +-
 drivers/infiniband/hw/hns/hns_roce_main.c      |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c      |  2 ++
 drivers/infiniband/hw/mlx4/main.c              | 15 ++++++++-------
 drivers/infiniband/hw/mlx5/main.c              |  2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c   |  2 +-
 drivers/infiniband/hw/nes/nes_verbs.c          |  2 ++
 drivers/infiniband/hw/ocrdma/ocrdma_main.c     |  2 +-
 drivers/infiniband/hw/qedr/main.c              |  2 +-
 drivers/infiniband/hw/usnic/usnic_ib_main.c    |  2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c |  2 +-
 drivers/infiniband/sw/rdmavt/vt.c              |  3 ++-
 drivers/infiniband/sw/rxe/rxe_verbs.c          |  2 +-
 include/rdma/ib_verbs.h                        |  2 +-
 20 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 021eb68230270e..fa5100dbb277e1 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2349,6 +2349,8 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 			dev_ops->driver_id != ops->driver_id);
 		dev_ops->driver_id = ops->driver_id;
 	}
+	if (ops->uverbs_abi_ver)
+		dev_ops->uverbs_abi_ver = ops->uverbs_abi_ver;
 
 	SET_DEVICE_OP(dev_ops, add_gid);
 	SET_DEVICE_OP(dev_ops, advise_mr);
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 84a5e9a6d483e8..0f8a286a92d3de 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -1186,7 +1186,7 @@ static ssize_t abi_version_show(struct device *device,
 	srcu_key = srcu_read_lock(&dev->disassociate_srcu);
 	ib_dev = srcu_dereference(dev->ib_dev, &dev->disassociate_srcu);
 	if (ib_dev)
-		ret = sprintf(buf, "%d\n", ib_dev->uverbs_abi_ver);
+		ret = sprintf(buf, "%u\n", ib_dev->ops.uverbs_abi_ver);
 	srcu_read_unlock(&dev->disassociate_srcu, srcu_key);
 
 	return ret;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 2c3685faa57a42..8af8e147210194 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3630,10 +3630,10 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 	u32 chip_met_rev_num = 0;
 	int rc;
 
-	dev_dbg(rdev_to_dev(rdev), "ABI version requested %d",
-		ibdev->uverbs_abi_ver);
+	dev_dbg(rdev_to_dev(rdev), "ABI version requested %u",
+		ibdev->ops.uverbs_abi_ver);
 
-	if (ibdev->uverbs_abi_ver != BNXT_RE_ABI_VERSION) {
+	if (ibdev->ops.uverbs_abi_ver != BNXT_RE_ABI_VERSION) {
 		dev_dbg(rdev_to_dev(rdev), " is different from the device %d ",
 			BNXT_RE_ABI_VERSION);
 		return -EPERM;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 1ef5f83ec914fe..a45cb9ee51abf9 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -597,6 +597,7 @@ static void bnxt_re_unregister_ib(struct bnxt_re_dev *rdev)
 
 static const struct ib_device_ops bnxt_re_dev_ops = {
 	.driver_id = RDMA_DRIVER_BNXT_RE,
+	.uverbs_abi_ver = BNXT_RE_ABI_VERSION,
 
 	.add_gid = bnxt_re_add_gid,
 	.alloc_hw_stats = bnxt_re_ib_alloc_hw_stats,
@@ -663,7 +664,6 @@ static int bnxt_re_register_ib(struct bnxt_re_dev *rdev)
 	ibdev->local_dma_lkey = BNXT_QPLIB_RSVD_LKEY;
 
 	/* User space */
-	ibdev->uverbs_abi_ver = BNXT_RE_ABI_VERSION;
 	ibdev->uverbs_cmd_mask =
 			(1ull << IB_USER_VERBS_CMD_GET_CONTEXT)		|
 			(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE)	|
diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.c b/drivers/infiniband/hw/cxgb3/iwch_provider.c
index 6cd103221c4a52..be3756c1f3f655 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_provider.c
+++ b/drivers/infiniband/hw/cxgb3/iwch_provider.c
@@ -1305,6 +1305,7 @@ static void get_dev_fw_ver_str(struct ib_device *ibdev, char *str)
 
 static const struct ib_device_ops iwch_dev_ops = {
 	.driver_id = RDMA_DRIVER_CXGB3,
+	.uverbs_abi_ver = IWCH_UVERBS_ABI_VERSION,
 
 	.alloc_hw_stats	= iwch_alloc_stats,
 	.alloc_mr = iwch_alloc_mr,
@@ -1385,7 +1386,6 @@ int iwch_register_device(struct iwch_dev *dev)
 	dev->ibdev.phys_port_cnt = dev->rdev.port_info.nports;
 	dev->ibdev.num_comp_vectors = 1;
 	dev->ibdev.dev.parent = &dev->rdev.rnic_info.pdev->dev;
-	dev->ibdev.uverbs_abi_ver = IWCH_UVERBS_ABI_VERSION;
 
 	memcpy(dev->ibdev.iw_ifname, dev->rdev.t3cdev_p->lldev->name,
 	       sizeof(dev->ibdev.iw_ifname));
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index edd1115ee0f9ae..2968d5c58f8774 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -491,6 +491,7 @@ static int fill_res_entry(struct sk_buff *msg, struct rdma_restrack_entry *res)
 
 static const struct ib_device_ops c4iw_dev_ops = {
 	.driver_id = RDMA_DRIVER_CXGB4,
+	.uverbs_abi_ver = C4IW_UVERBS_ABI_VERSION,
 
 	.alloc_hw_stats = c4iw_alloc_stats,
 	.alloc_mr = c4iw_alloc_mr,
@@ -596,7 +597,6 @@ void c4iw_register_device(struct work_struct *work)
 	dev->ibdev.phys_port_cnt = dev->rdev.lldi.nports;
 	dev->ibdev.num_comp_vectors =  dev->rdev.lldi.nciq;
 	dev->ibdev.dev.parent = &dev->rdev.lldi.pdev->dev;
-	dev->ibdev.uverbs_abi_ver = C4IW_UVERBS_ABI_VERSION;
 
 	memcpy(dev->ibdev.iw_ifname, dev->rdev.lldi.ports[0]->name,
 	       sizeof(dev->ibdev.iw_ifname));
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 3803dd4526b508..b05c5a0b9bc0be 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -198,6 +198,7 @@ static void efa_stats_init(struct efa_dev *dev)
 
 static const struct ib_device_ops efa_dev_ops = {
 	.driver_id = RDMA_DRIVER_EFA,
+	.uverbs_abi_ver = EFA_UVERBS_ABI_VERSION,
 
 	.alloc_pd = efa_alloc_pd,
 	.alloc_ucontext = efa_alloc_ucontext,
@@ -266,7 +267,6 @@ static int efa_ib_device_add(struct efa_dev *dev)
 	dev->ibdev.phys_port_cnt = 1;
 	dev->ibdev.num_comp_vectors = 1;
 	dev->ibdev.dev.parent = &pdev->dev;
-	dev->ibdev.uverbs_abi_ver = EFA_UVERBS_ABI_VERSION;
 
 	dev->ibdev.uverbs_cmd_mask =
 		(1ull << IB_USER_VERBS_CMD_GET_CONTEXT) |
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index bf7cdeb2de9788..70420193a53f93 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -424,6 +424,7 @@ static void hns_roce_unregister_device(struct hns_roce_dev *hr_dev)
 
 static const struct ib_device_ops hns_roce_dev_ops = {
 	.driver_id = RDMA_DRIVER_HNS,
+	.uverbs_abi_ver = 1,
 
 	.add_gid = hns_roce_add_gid,
 	.alloc_pd = hns_roce_alloc_pd,
@@ -498,7 +499,6 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 	ib_dev->phys_port_cnt		= hr_dev->caps.num_ports;
 	ib_dev->local_dma_lkey		= hr_dev->caps.reserved_lkey;
 	ib_dev->num_comp_vectors	= hr_dev->caps.num_comp_vectors;
-	ib_dev->uverbs_abi_ver		= 1;
 	ib_dev->uverbs_cmd_mask		=
 		(1ULL << IB_USER_VERBS_CMD_GET_CONTEXT) |
 		(1ULL << IB_USER_VERBS_CMD_QUERY_DEVICE) |
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 39610d91317b9e..bf1d232f94c83e 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -2656,6 +2656,8 @@ static int i40iw_query_pkey(struct ib_device *ibdev,
 
 static const struct ib_device_ops i40iw_dev_ops = {
 	.driver_id = RDMA_DRIVER_I40IW,
+	/* NOTE: Older kernels wrongly use 0 for the uverbs_abi_ver */
+	.uverbs_abi_ver = I40IW_ABI_VER,
 
 	.alloc_hw_stats = i40iw_alloc_hw_stats,
 	.alloc_mr = i40iw_alloc_mr,
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 03847e2f7835a3..1f87221acbb056 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1089,7 +1089,8 @@ static int mlx4_ib_alloc_ucontext(struct ib_ucontext *uctx,
 	if (!dev->ib_active)
 		return -EAGAIN;
 
-	if (ibdev->uverbs_abi_ver == MLX4_IB_UVERBS_NO_DEV_CAPS_ABI_VERSION) {
+	if (ibdev->ops.uverbs_abi_ver ==
+	    MLX4_IB_UVERBS_NO_DEV_CAPS_ABI_VERSION) {
 		resp_v3.qp_tab_size      = dev->dev->caps.num_qps;
 		resp_v3.bf_reg_size      = dev->dev->caps.bf_reg_size;
 		resp_v3.bf_regs_per_page = dev->dev->caps.bf_regs_per_page;
@@ -1111,7 +1112,7 @@ static int mlx4_ib_alloc_ucontext(struct ib_ucontext *uctx,
 	INIT_LIST_HEAD(&context->wqn_ranges_list);
 	mutex_init(&context->wqn_ranges_mutex);
 
-	if (ibdev->uverbs_abi_ver == MLX4_IB_UVERBS_NO_DEV_CAPS_ABI_VERSION)
+	if (ibdev->ops.uverbs_abi_ver == MLX4_IB_UVERBS_NO_DEV_CAPS_ABI_VERSION)
 		err = ib_copy_to_udata(udata, &resp_v3, sizeof(resp_v3));
 	else
 		err = ib_copy_to_udata(udata, &resp, sizeof(resp));
@@ -2510,6 +2511,7 @@ static void get_fw_ver_str(struct ib_device *device, char *str)
 
 static const struct ib_device_ops mlx4_ib_dev_ops = {
 	.driver_id = RDMA_DRIVER_MLX4,
+	.uverbs_abi_ver = MLX4_IB_UVERBS_ABI_VERSION,
 
 	.add_gid = mlx4_ib_add_gid,
 	.alloc_mr = mlx4_ib_alloc_mr,
@@ -2653,11 +2655,6 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 	ibdev->ib_dev.num_comp_vectors	= dev->caps.num_comp_vectors;
 	ibdev->ib_dev.dev.parent	= &dev->persist->pdev->dev;
 
-	if (dev->caps.userspace_caps)
-		ibdev->ib_dev.uverbs_abi_ver = MLX4_IB_UVERBS_ABI_VERSION;
-	else
-		ibdev->ib_dev.uverbs_abi_ver = MLX4_IB_UVERBS_NO_DEV_CAPS_ABI_VERSION;
-
 	ibdev->ib_dev.uverbs_cmd_mask	=
 		(1ull << IB_USER_VERBS_CMD_GET_CONTEXT)		|
 		(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE)	|
@@ -2731,6 +2728,10 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 		ib_set_device_ops(&ibdev->ib_dev, &mlx4_ib_dev_fs_ops);
 	}
 
+	if (!dev->caps.userspace_caps)
+		ibdev->ib_dev.ops.uverbs_abi_ver =
+			MLX4_IB_UVERBS_NO_DEV_CAPS_ABI_VERSION;
+
 	mlx4_ib_alloc_eqs(dev, ibdev);
 
 	spin_lock_init(&iboe->lock);
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index c6eecddb4285a3..8d12a55e95ec87 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6125,6 +6125,7 @@ static void mlx5_ib_stage_flow_db_cleanup(struct mlx5_ib_dev *dev)
 
 static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.driver_id = RDMA_DRIVER_MLX5,
+	.uverbs_abi_ver	= MLX5_IB_UVERBS_ABI_VERSION,
 
 	.add_gid = mlx5_ib_add_gid,
 	.alloc_mr = mlx5_ib_alloc_mr,
@@ -6223,7 +6224,6 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 	struct mlx5_core_dev *mdev = dev->mdev;
 	int err;
 
-	dev->ib_dev.uverbs_abi_ver	= MLX5_IB_UVERBS_ABI_VERSION;
 	dev->ib_dev.uverbs_cmd_mask	=
 		(1ull << IB_USER_VERBS_CMD_GET_CONTEXT)		|
 		(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE)	|
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index d6467da39aab55..690c65accea4a9 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -1154,6 +1154,7 @@ static void get_dev_fw_str(struct ib_device *device, char *str)
 
 static const struct ib_device_ops mthca_dev_ops = {
 	.driver_id = RDMA_DRIVER_MTHCA,
+	.uverbs_abi_ver = MTHCA_UVERBS_ABI_VERSION,
 
 	.alloc_pd = mthca_alloc_pd,
 	.alloc_ucontext = mthca_alloc_ucontext,
@@ -1247,7 +1248,6 @@ int mthca_register_device(struct mthca_dev *dev)
 
 	dev->ib_dev.owner                = THIS_MODULE;
 
-	dev->ib_dev.uverbs_abi_ver	 = MTHCA_UVERBS_ABI_VERSION;
 	dev->ib_dev.uverbs_cmd_mask	 =
 		(1ull << IB_USER_VERBS_CMD_GET_CONTEXT)		|
 		(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE)	|
diff --git a/drivers/infiniband/hw/nes/nes_verbs.c b/drivers/infiniband/hw/nes/nes_verbs.c
index fc28a0a24df075..1d9822695f8da6 100644
--- a/drivers/infiniband/hw/nes/nes_verbs.c
+++ b/drivers/infiniband/hw/nes/nes_verbs.c
@@ -3561,6 +3561,8 @@ static void get_dev_fw_str(struct ib_device *dev, char *str)
 
 static const struct ib_device_ops nes_dev_ops = {
 	.driver_id = RDMA_DRIVER_NES,
+	/* NOTE: Older kernels wrongly use 0 for the uverbs_abi_ver */
+	.uverbs_abi_ver = NES_ABI_USERSPACE_VER,
 
 	.alloc_mr = nes_alloc_mr,
 	.alloc_mw = nes_alloc_mw,
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
index a9da4b857566cc..ef823f1144b522 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
@@ -145,6 +145,7 @@ static const struct attribute_group ocrdma_attr_group = {
 
 static const struct ib_device_ops ocrdma_dev_ops = {
 	.driver_id = RDMA_DRIVER_OCRDMA,
+	.uverbs_abi_ver = OCRDMA_ABI_VERSION,
 
 	.alloc_mr = ocrdma_alloc_mr,
 	.alloc_pd = ocrdma_alloc_pd,
@@ -203,7 +204,6 @@ static int ocrdma_register_device(struct ocrdma_dev *dev)
 	memcpy(dev->ibdev.node_desc, OCRDMA_NODE_DESC,
 	       sizeof(OCRDMA_NODE_DESC));
 	dev->ibdev.owner = THIS_MODULE;
-	dev->ibdev.uverbs_abi_ver = OCRDMA_ABI_VERSION;
 	dev->ibdev.uverbs_cmd_mask =
 	    OCRDMA_UVERBS(GET_CONTEXT) |
 	    OCRDMA_UVERBS(QUERY_DEVICE) |
diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index 737745231f8ffe..793e25776a7e24 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -184,6 +184,7 @@ static void qedr_roce_register_device(struct qedr_dev *dev)
 
 static const struct ib_device_ops qedr_dev_ops = {
 	.driver_id = RDMA_DRIVER_QEDR,
+	.uverbs_abi_ver = QEDR_ABI_VERSION,
 
 	.alloc_mr = qedr_alloc_mr,
 	.alloc_pd = qedr_alloc_pd,
@@ -234,7 +235,6 @@ static int qedr_register_device(struct qedr_dev *dev)
 	dev->ibdev.node_guid = dev->attr.node_guid;
 	memcpy(dev->ibdev.node_desc, QEDR_NODE_DESC, sizeof(QEDR_NODE_DESC));
 	dev->ibdev.owner = THIS_MODULE;
-	dev->ibdev.uverbs_abi_ver = QEDR_ABI_VERSION;
 
 	dev->ibdev.uverbs_cmd_mask = QEDR_UVERBS(GET_CONTEXT) |
 				     QEDR_UVERBS(QUERY_DEVICE) |
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniband/hw/usnic/usnic_ib_main.c
index 47830334cb555d..f6169081609580 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
@@ -330,6 +330,7 @@ static void usnic_get_dev_fw_str(struct ib_device *device, char *str)
 
 static const struct ib_device_ops usnic_dev_ops = {
 	.driver_id = RDMA_DRIVER_USNIC,
+	.uverbs_abi_ver = USNIC_UVERBS_ABI_VERSION,
 
 	.alloc_pd = usnic_ib_alloc_pd,
 	.alloc_ucontext = usnic_ib_alloc_ucontext,
@@ -391,7 +392,6 @@ static void *usnic_ib_device_add(struct pci_dev *dev)
 	us_ibdev->ib_dev.phys_port_cnt = USNIC_IB_PORT_CNT;
 	us_ibdev->ib_dev.num_comp_vectors = USNIC_IB_NUM_COMP_VECTORS;
 	us_ibdev->ib_dev.dev.parent = &dev->dev;
-	us_ibdev->ib_dev.uverbs_abi_ver = USNIC_UVERBS_ABI_VERSION;
 
 	us_ibdev->ib_dev.uverbs_cmd_mask =
 		(1ull << IB_USER_VERBS_CMD_GET_CONTEXT) |
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index 54a0b63726295f..2a7eb2838453d4 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -145,6 +145,7 @@ static int pvrdma_port_immutable(struct ib_device *ibdev, u8 port_num,
 
 static const struct ib_device_ops pvrdma_dev_ops = {
 	.driver_id = RDMA_DRIVER_VMW_PVRDMA,
+	.uverbs_abi_ver = PVRDMA_UVERBS_ABI_VERSION,
 
 	.add_gid = pvrdma_add_gid,
 	.alloc_mr = pvrdma_alloc_mr,
@@ -203,7 +204,6 @@ static int pvrdma_register_device(struct pvrdma_dev *dev)
 	dev->ib_dev.owner = THIS_MODULE;
 	dev->ib_dev.num_comp_vectors = 1;
 	dev->ib_dev.dev.parent = &dev->pdev->dev;
-	dev->ib_dev.uverbs_abi_ver = PVRDMA_UVERBS_ABI_VERSION;
 	dev->ib_dev.uverbs_cmd_mask =
 		(1ull << IB_USER_VERBS_CMD_GET_CONTEXT)		|
 		(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE)	|
diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
index 60700e197e6c79..639ef8ac540070 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -382,6 +382,8 @@ enum {
 };
 
 static const struct ib_device_ops rvt_dev_ops = {
+	.uverbs_abi_ver = RVT_UVERBS_ABI_VERSION,
+
 	.alloc_fmr = rvt_alloc_fmr,
 	.alloc_mr = rvt_alloc_mr,
 	.alloc_pd = rvt_alloc_pd,
@@ -600,7 +602,6 @@ int rvt_register_device(struct rvt_dev_info *rdi)
 	 * exactly which functions rdmavt supports, nor do they know the ABI
 	 * version, so we do all of this sort of stuff here.
 	 */
-	rdi->ibdev.uverbs_abi_ver = RVT_UVERBS_ABI_VERSION;
 	rdi->ibdev.uverbs_cmd_mask =
 		(1ull << IB_USER_VERBS_CMD_GET_CONTEXT)         |
 		(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE)        |
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 3d3130dc6380bd..9e87cdb82becaa 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1112,6 +1112,7 @@ static int rxe_enable_driver(struct ib_device *ib_dev)
 
 static const struct ib_device_ops rxe_dev_ops = {
 	.driver_id = RDMA_DRIVER_RXE,
+	.uverbs_abi_ver = RXE_UVERBS_ABI_VERSION,
 
 	.alloc_hw_stats = rxe_ib_alloc_hw_stats,
 	.alloc_mr = rxe_alloc_mr,
@@ -1184,7 +1185,6 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	dma_coerce_mask_and_coherent(&dev->dev,
 				     dma_get_required_mask(&dev->dev));
 
-	dev->uverbs_abi_ver = RXE_UVERBS_ABI_VERSION;
 	dev->uverbs_cmd_mask = BIT_ULL(IB_USER_VERBS_CMD_GET_CONTEXT)
 	    | BIT_ULL(IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL)
 	    | BIT_ULL(IB_USER_VERBS_CMD_QUERY_DEVICE)
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 49fcb42647e33d..9e0d5ec35f4192 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2330,6 +2330,7 @@ struct iw_cm_conn_param;
  */
 struct ib_device_ops {
 	enum rdma_driver_id driver_id;
+	u32 uverbs_abi_ver;
 
 	int (*post_send)(struct ib_qp *qp, const struct ib_send_wr *send_wr,
 			 const struct ib_send_wr **bad_send_wr);
@@ -2650,7 +2651,6 @@ struct ib_device {
 	 */
 	const struct attribute_group	*groups[3];
 
-	int			     uverbs_abi_ver;
 	u64			     uverbs_cmd_mask;
 	u64			     uverbs_ex_cmd_mask;
 
-- 
2.21.0

