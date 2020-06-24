Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332B520718F
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2020 12:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388770AbgFXKyf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jun 2020 06:54:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbgFXKyf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Jun 2020 06:54:35 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B3772088E;
        Wed, 24 Jun 2020 10:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592996074;
        bh=Y4HcdjWHPK/OFEXdcioLMzjrSrGEyukBlNOf2+zew8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tDMwB3sjA7oBXWgCQxt25DQlaQlhZlDOtobEO77Fm8WE5ilxCdyos7vF0tIO7yyDw
         oishM05oCOEbCVRVG+iQpEpwoedhojNCM4xkP6jt7r6Teu1GVJsklh+1vJzg6tSRAU
         w1xX01y9H/dcdiWYvsY3Qv1mxKaJJgnGKRja2lss=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next 3/5] RDMA: Move XRCD to be under ib_core responsibility
Date:   Wed, 24 Jun 2020 13:54:20 +0300
Message-Id: <20200624105422.1452290-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624105422.1452290-1-leon@kernel.org>
References: <20200624105422.1452290-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Update the code to allocate and free ib_xrcd structure in the
ib_core instead of inside drivers.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/device.c     |  1 +
 drivers/infiniband/core/verbs.c      | 30 ++++++++++++++--------
 drivers/infiniband/hw/mlx4/main.c    | 37 +++++++++++-----------------
 drivers/infiniband/hw/mlx5/main.c    |  2 ++
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  5 ++--
 drivers/infiniband/hw/mlx5/qp.c      | 34 +++++++------------------
 include/rdma/ib_verbs.h              |  6 ++---
 7 files changed, 52 insertions(+), 63 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 257e8a667977..b15fa3fa09ac 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2688,6 +2688,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_OBJ_SIZE(dev_ops, ib_pd);
 	SET_OBJ_SIZE(dev_ops, ib_srq);
 	SET_OBJ_SIZE(dev_ops, ib_ucontext);
+	SET_OBJ_SIZE(dev_ops, ib_xrcd);
 }
 EXPORT_SYMBOL(ib_set_device_ops);
 
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 61debe056912..6a2becd624c3 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2294,20 +2294,28 @@ struct ib_xrcd *ib_alloc_xrcd_user(struct ib_device *device,
 				   struct inode *inode, struct ib_udata *udata)
 {
 	struct ib_xrcd *xrcd;
+	int ret;
 
 	if (!device->ops.alloc_xrcd)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	xrcd = device->ops.alloc_xrcd(device, udata);
-	if (!IS_ERR(xrcd)) {
-		xrcd->device = device;
-		xrcd->inode = inode;
-		atomic_set(&xrcd->usecnt, 0);
-		init_rwsem(&xrcd->tgt_qps_rwsem);
-		xa_init(&xrcd->tgt_qps);
-	}
+	xrcd = rdma_zalloc_drv_obj(device, ib_xrcd);
+	if (!xrcd)
+		return ERR_PTR(-ENOMEM);
 
+	xrcd->device = device;
+	xrcd->inode = inode;
+	atomic_set(&xrcd->usecnt, 0);
+	init_rwsem(&xrcd->tgt_qps_rwsem);
+	xa_init(&xrcd->tgt_qps);
+
+	ret = device->ops.alloc_xrcd(xrcd, udata);
+	if (ret)
+		goto err;
 	return xrcd;
+err:
+	kfree(xrcd);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(ib_alloc_xrcd_user);
 
@@ -2317,8 +2325,10 @@ int ib_dealloc_xrcd_user(struct ib_xrcd *xrcd, struct ib_udata *udata)
 		return -EBUSY;
 
 	WARN_ON(!xa_empty(&xrcd->tgt_qps));
-	return xrcd->device->ops.dealloc_xrcd(xrcd, udata);
-}
+	xrcd->device->ops.dealloc_xrcd(xrcd, udata);
+	kfree(xrcd);
+	return 0;
+ }
 EXPORT_SYMBOL(ib_dealloc_xrcd_user);
 
 /**
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 6471f47bd365..0ad584a3b8d6 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1219,56 +1219,47 @@ static void mlx4_ib_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata)
 	mlx4_pd_free(to_mdev(pd->device)->dev, to_mpd(pd)->pdn);
 }
 
-static struct ib_xrcd *mlx4_ib_alloc_xrcd(struct ib_device *ibdev,
-					  struct ib_udata *udata)
+static int mlx4_ib_alloc_xrcd(struct ib_xrcd *ibxrcd, struct ib_udata *udata)
 {
-	struct mlx4_ib_xrcd *xrcd;
+	struct mlx4_ib_dev *dev = to_mdev(ibxrcd->device);
+	struct mlx4_ib_xrcd *xrcd = to_mxrcd(ibxrcd);
 	struct ib_cq_init_attr cq_attr = {};
 	int err;
 
-	if (!(to_mdev(ibdev)->dev->caps.flags & MLX4_DEV_CAP_FLAG_XRC))
-		return ERR_PTR(-ENOSYS);
-
-	xrcd = kmalloc(sizeof *xrcd, GFP_KERNEL);
-	if (!xrcd)
-		return ERR_PTR(-ENOMEM);
+	if (!(dev->dev->caps.flags & MLX4_DEV_CAP_FLAG_XRC))
+		return -EOPNOTSUPP;
 
-	err = mlx4_xrcd_alloc(to_mdev(ibdev)->dev, &xrcd->xrcdn);
+	err = mlx4_xrcd_alloc(dev->dev, &xrcd->xrcdn);
 	if (err)
-		goto err1;
+		return err;
 
-	xrcd->pd = ib_alloc_pd(ibdev, 0);
+	xrcd->pd = ib_alloc_pd(ibxrcd->device, 0);
 	if (IS_ERR(xrcd->pd)) {
 		err = PTR_ERR(xrcd->pd);
 		goto err2;
 	}
 
 	cq_attr.cqe = 1;
-	xrcd->cq = ib_create_cq(ibdev, NULL, NULL, xrcd, &cq_attr);
+	xrcd->cq = ib_create_cq(ibxrcd->device, NULL, NULL, xrcd, &cq_attr);
 	if (IS_ERR(xrcd->cq)) {
 		err = PTR_ERR(xrcd->cq);
 		goto err3;
 	}
 
-	return &xrcd->ibxrcd;
+	return 0;
 
 err3:
 	ib_dealloc_pd(xrcd->pd);
 err2:
-	mlx4_xrcd_free(to_mdev(ibdev)->dev, xrcd->xrcdn);
-err1:
-	kfree(xrcd);
-	return ERR_PTR(err);
+	mlx4_xrcd_free(dev->dev, xrcd->xrcdn);
+	return err;
 }
 
-static int mlx4_ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata)
+static void mlx4_ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata)
 {
 	ib_destroy_cq(to_mxrcd(xrcd)->cq);
 	ib_dealloc_pd(to_mxrcd(xrcd)->pd);
 	mlx4_xrcd_free(to_mdev(xrcd->device)->dev, to_mxrcd(xrcd)->xrcdn);
-	kfree(xrcd);
-
-	return 0;
 }
 
 static int add_gid_entry(struct ib_qp *ibqp, union ib_gid *gid)
@@ -2609,6 +2600,8 @@ static const struct ib_device_ops mlx4_ib_dev_mw_ops = {
 static const struct ib_device_ops mlx4_ib_dev_xrc_ops = {
 	.alloc_xrcd = mlx4_ib_alloc_xrcd,
 	.dealloc_xrcd = mlx4_ib_dealloc_xrcd,
+
+	INIT_RDMA_OBJ_SIZE(ib_xrcd, mlx4_ib_xrcd, ibxrcd),
 };
 
 static const struct ib_device_ops mlx4_ib_dev_fs_ops = {
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 8b0b1f95af2f..a6d5c35a2845 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6676,6 +6676,8 @@ static const struct ib_device_ops mlx5_ib_dev_mw_ops = {
 static const struct ib_device_ops mlx5_ib_dev_xrc_ops = {
 	.alloc_xrcd = mlx5_ib_alloc_xrcd,
 	.dealloc_xrcd = mlx5_ib_dealloc_xrcd,
+
+	INIT_RDMA_OBJ_SIZE(ib_xrcd, mlx5_ib_xrcd, ibxrcd),
 };
 
 static const struct ib_device_ops mlx5_ib_dev_dm_ops = {
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index d84f56517caa..726386fe4440 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1223,9 +1223,8 @@ int mlx5_ib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
 			const struct ib_wc *in_wc, const struct ib_grh *in_grh,
 			const struct ib_mad *in, struct ib_mad *out,
 			size_t *out_mad_size, u16 *out_mad_pkey_index);
-struct ib_xrcd *mlx5_ib_alloc_xrcd(struct ib_device *ibdev,
-				   struct ib_udata *udata);
-int mlx5_ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata);
+int mlx5_ib_alloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata);
+void mlx5_ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata);
 int mlx5_ib_get_buf_offset(u64 addr, int page_shift, u32 *offset);
 int mlx5_query_ext_port_caps(struct mlx5_ib_dev *dev, u8 port);
 int mlx5_query_mad_ifc_smp_attr_node_info(struct ib_device *ibdev,
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index f939c9b769f0..0ae73f4e28a3 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4700,41 +4700,25 @@ int mlx5_ib_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	return err;
 }
 
-struct ib_xrcd *mlx5_ib_alloc_xrcd(struct ib_device *ibdev,
-				   struct ib_udata *udata)
+int mlx5_ib_alloc_xrcd(struct ib_xrcd *ibxrcd, struct ib_udata *udata)
 {
-	struct mlx5_ib_dev *dev = to_mdev(ibdev);
-	struct mlx5_ib_xrcd *xrcd;
-	int err;
+	struct mlx5_ib_dev *dev = to_mdev(ibxrcd->device);
+	struct mlx5_ib_xrcd *xrcd = to_mxrcd(ibxrcd);
+	int ret;
 
 	if (!MLX5_CAP_GEN(dev->mdev, xrc))
-		return ERR_PTR(-ENOSYS);
-
-	xrcd = kmalloc(sizeof(*xrcd), GFP_KERNEL);
-	if (!xrcd)
-		return ERR_PTR(-ENOMEM);
-
-	err = mlx5_cmd_xrcd_alloc(dev->mdev, &xrcd->xrcdn, 0);
-	if (err) {
-		kfree(xrcd);
-		return ERR_PTR(-ENOMEM);
-	}
+		return -EOPNOTSUPP;
 
-	return &xrcd->ibxrcd;
+	ret = mlx5_cmd_xrcd_alloc(dev->mdev, &xrcd->xrcdn, 0);
+	return ret;
 }
 
-int mlx5_ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata)
+void mlx5_ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata)
 {
 	struct mlx5_ib_dev *dev = to_mdev(xrcd->device);
 	u32 xrcdn = to_mxrcd(xrcd)->xrcdn;
-	int err;
 
-	err = mlx5_cmd_xrcd_dealloc(dev->mdev, xrcdn, 0);
-	if (err)
-		mlx5_ib_warn(dev, "failed to dealloc xrcdn 0x%x\n", xrcdn);
-
-	kfree(xrcd);
-	return 0;
+	mlx5_cmd_xrcd_dealloc(dev->mdev, xrcdn, 0);
 }
 
 static void mlx5_ib_wq_event(struct mlx5_core_qp *core_qp, int type)
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 7160662899bb..f1a5c89466aa 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2494,9 +2494,8 @@ struct ib_device_ops {
 	void (*dealloc_mw)(struct ib_mw *mw);
 	int (*attach_mcast)(struct ib_qp *qp, union ib_gid *gid, u16 lid);
 	int (*detach_mcast)(struct ib_qp *qp, union ib_gid *gid, u16 lid);
-	struct ib_xrcd *(*alloc_xrcd)(struct ib_device *device,
-				      struct ib_udata *udata);
-	int (*dealloc_xrcd)(struct ib_xrcd *xrcd, struct ib_udata *udata);
+	int (*alloc_xrcd)(struct ib_xrcd *xrcd, struct ib_udata *udata);
+	void (*dealloc_xrcd)(struct ib_xrcd *xrcd, struct ib_udata *udata);
 	struct ib_flow *(*create_flow)(struct ib_qp *qp,
 				       struct ib_flow_attr *flow_attr,
 				       int domain, struct ib_udata *udata);
@@ -2656,6 +2655,7 @@ struct ib_device_ops {
 	DECLARE_RDMA_OBJ_SIZE(ib_pd);
 	DECLARE_RDMA_OBJ_SIZE(ib_srq);
 	DECLARE_RDMA_OBJ_SIZE(ib_ucontext);
+	DECLARE_RDMA_OBJ_SIZE(ib_xrcd);
 };
 
 struct ib_core_device {
-- 
2.26.2

