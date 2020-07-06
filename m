Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FA9215735
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 14:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgGFM11 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 08:27:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729107AbgGFM11 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jul 2020 08:27:27 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDDEA206E6;
        Mon,  6 Jul 2020 12:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594038446;
        bh=+NP2KYRLJjcdk6QwKPJBDJ5a0z0LlyP0x8qUEk4k/Nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NDZ6mgiJYPnBiuj700byoyju2QI1q7ZCG6c9E4BSLfR1psvOKdu1wojsVCu3lLm9f
         e3HyN7u90keqarGiVrW8WuKQhyiKPM2m03YNbJ/x8hxNlWWV0OmsKnoeKGTl666Hlt
         Oc5iFj1tGZSTeOGVJygeHmIla0LoDFkYD1fI7RLY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 1/3] RDMA/mlx5: Get XRCD number directly for the internal use
Date:   Mon,  6 Jul 2020 15:27:14 +0300
Message-Id: <20200706122716.647338-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200706122716.647338-1-leon@kernel.org>
References: <20200706122716.647338-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The mlx5_ib creates XRC domain and uses for creating internal SRQ.
However all that is needed is XRCD number and not full blown
ib_xrcd objects.

Update the code to get and store the number only.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c    | 39 ++++++++++------------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  4 +--
 drivers/infiniband/hw/mlx5/qp.c      | 10 +++----
 drivers/infiniband/hw/mlx5/srq.c     |  4 +--
 4 files changed, 23 insertions(+), 34 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 47a0c091eea5..324a98c77ad5 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -5016,6 +5016,9 @@ static int create_dev_resources(struct mlx5_ib_resources *devr)
 	dev = container_of(devr, struct mlx5_ib_dev, devr);
 	ibdev = &dev->ib_dev;
 
+	if (!MLX5_CAP_GEN(dev->mdev, xrc))
+		return -EOPNOTSUPP;
+
 	mutex_init(&devr->mutex);
 
 	devr->p0 = rdma_zalloc_drv_obj(ibdev, ib_pd);
@@ -5043,34 +5046,19 @@ static int create_dev_resources(struct mlx5_ib_resources *devr)
 	if (ret)
 		goto err_create_cq;
 
-	devr->x0 = mlx5_ib_alloc_xrcd(&dev->ib_dev, NULL);
-	if (IS_ERR(devr->x0)) {
-		ret = PTR_ERR(devr->x0);
+	ret = mlx5_cmd_xrcd_alloc(dev->mdev, &devr->xrcdn0, 0);
+	if (ret)
 		goto error2;
-	}
-	devr->x0->device = &dev->ib_dev;
-	devr->x0->inode = NULL;
-	atomic_set(&devr->x0->usecnt, 0);
-	mutex_init(&devr->x0->tgt_qp_mutex);
-	INIT_LIST_HEAD(&devr->x0->tgt_qp_list);
 
-	devr->x1 = mlx5_ib_alloc_xrcd(&dev->ib_dev, NULL);
-	if (IS_ERR(devr->x1)) {
-		ret = PTR_ERR(devr->x1);
+	ret = mlx5_cmd_xrcd_alloc(dev->mdev, &devr->xrcdn1, 0);
+	if (ret)
 		goto error3;
-	}
-	devr->x1->device = &dev->ib_dev;
-	devr->x1->inode = NULL;
-	atomic_set(&devr->x1->usecnt, 0);
-	mutex_init(&devr->x1->tgt_qp_mutex);
-	INIT_LIST_HEAD(&devr->x1->tgt_qp_list);
 
 	memset(&attr, 0, sizeof(attr));
 	attr.attr.max_sge = 1;
 	attr.attr.max_wr = 1;
 	attr.srq_type = IB_SRQT_XRC;
 	attr.ext.cq = devr->c0;
-	attr.ext.xrc.xrcd = devr->x0;
 
 	devr->s0 = rdma_zalloc_drv_obj(ibdev, ib_srq);
 	if (!devr->s0) {
@@ -5081,13 +5069,11 @@ static int create_dev_resources(struct mlx5_ib_resources *devr)
 	devr->s0->device	= &dev->ib_dev;
 	devr->s0->pd		= devr->p0;
 	devr->s0->srq_type      = IB_SRQT_XRC;
-	devr->s0->ext.xrc.xrcd	= devr->x0;
 	devr->s0->ext.cq	= devr->c0;
 	ret = mlx5_ib_create_srq(devr->s0, &attr, NULL);
 	if (ret)
 		goto err_create;
 
-	atomic_inc(&devr->s0->ext.xrc.xrcd->usecnt);
 	atomic_inc(&devr->s0->ext.cq->usecnt);
 	atomic_inc(&devr->p0->usecnt);
 	atomic_set(&devr->s0->usecnt, 0);
@@ -5129,9 +5115,9 @@ static int create_dev_resources(struct mlx5_ib_resources *devr)
 err_create:
 	kfree(devr->s0);
 error4:
-	mlx5_ib_dealloc_xrcd(devr->x1, NULL);
+	mlx5_cmd_xrcd_dealloc(dev->mdev, devr->xrcdn1, 0);
 error3:
-	mlx5_ib_dealloc_xrcd(devr->x0, NULL);
+	mlx5_cmd_xrcd_dealloc(dev->mdev, devr->xrcdn0, 0);
 error2:
 	mlx5_ib_destroy_cq(devr->c0, NULL);
 err_create_cq:
@@ -5145,14 +5131,17 @@ static int create_dev_resources(struct mlx5_ib_resources *devr)
 
 static void destroy_dev_resources(struct mlx5_ib_resources *devr)
 {
+	struct mlx5_ib_dev *dev;
 	int port;
 
+	dev = container_of(devr, struct mlx5_ib_dev, devr);
+
 	mlx5_ib_destroy_srq(devr->s1, NULL);
 	kfree(devr->s1);
 	mlx5_ib_destroy_srq(devr->s0, NULL);
 	kfree(devr->s0);
-	mlx5_ib_dealloc_xrcd(devr->x0, NULL);
-	mlx5_ib_dealloc_xrcd(devr->x1, NULL);
+	mlx5_cmd_xrcd_dealloc(dev->mdev, devr->xrcdn1, 0);
+	mlx5_cmd_xrcd_dealloc(dev->mdev, devr->xrcdn0, 0);
 	mlx5_ib_destroy_cq(devr->c0, NULL);
 	kfree(devr->c0);
 	mlx5_ib_dealloc_pd(devr->p0, NULL);
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 26545e88709d..7ec8c506af9f 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -730,8 +730,8 @@ struct mlx5_ib_port_resources {
 
 struct mlx5_ib_resources {
 	struct ib_cq	*c0;
-	struct ib_xrcd	*x0;
-	struct ib_xrcd	*x1;
+	u32 xrcdn0;
+	u32 xrcdn1;
 	struct ib_pd	*p0;
 	struct ib_srq	*s0;
 	struct ib_srq	*s1;
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index f939c9b769f0..f97e99ee9242 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2035,15 +2035,15 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	switch (init_attr->qp_type) {
 	case IB_QPT_XRC_INI:
 		MLX5_SET(qpc, qpc, cqn_rcv, to_mcq(devr->c0)->mcq.cqn);
-		MLX5_SET(qpc, qpc, xrcd, to_mxrcd(devr->x1)->xrcdn);
+		MLX5_SET(qpc, qpc, xrcd, devr->xrcdn1);
 		MLX5_SET(qpc, qpc, srqn_rmpn_xrqn, to_msrq(devr->s0)->msrq.srqn);
 		break;
 	default:
 		if (init_attr->srq) {
-			MLX5_SET(qpc, qpc, xrcd, to_mxrcd(devr->x0)->xrcdn);
+			MLX5_SET(qpc, qpc, xrcd, devr->xrcdn0);
 			MLX5_SET(qpc, qpc, srqn_rmpn_xrqn, to_msrq(init_attr->srq)->msrq.srqn);
 		} else {
-			MLX5_SET(qpc, qpc, xrcd, to_mxrcd(devr->x1)->xrcdn);
+			MLX5_SET(qpc, qpc, xrcd, devr->xrcdn1);
 			MLX5_SET(qpc, qpc, srqn_rmpn_xrqn, to_msrq(devr->s1)->msrq.srqn);
 		}
 	}
@@ -2183,11 +2183,11 @@ static int create_kernel_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		MLX5_SET(qpc, qpc, no_sq, 1);
 
 	if (attr->srq) {
-		MLX5_SET(qpc, qpc, xrcd, to_mxrcd(devr->x0)->xrcdn);
+		MLX5_SET(qpc, qpc, xrcd, devr->xrcdn0);
 		MLX5_SET(qpc, qpc, srqn_rmpn_xrqn,
 			 to_msrq(attr->srq)->msrq.srqn);
 	} else {
-		MLX5_SET(qpc, qpc, xrcd, to_mxrcd(devr->x1)->xrcdn);
+		MLX5_SET(qpc, qpc, xrcd, devr->xrcdn1);
 		MLX5_SET(qpc, qpc, srqn_rmpn_xrqn,
 			 to_msrq(devr->s1)->msrq.srqn);
 	}
diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index 6d1ff13d2283..7e10cbcb6d5c 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -274,10 +274,10 @@ int mlx5_ib_create_srq(struct ib_srq *ib_srq,
 	if (srq->wq_sig)
 		in.flags |= MLX5_SRQ_FLAG_WQ_SIG;
 
-	if (init_attr->srq_type == IB_SRQT_XRC)
+	if (init_attr->srq_type == IB_SRQT_XRC && init_attr->ext.xrc.xrcd)
 		in.xrcd = to_mxrcd(init_attr->ext.xrc.xrcd)->xrcdn;
 	else
-		in.xrcd = to_mxrcd(dev->devr.x0)->xrcdn;
+		in.xrcd = dev->devr.xrcdn0;
 
 	if (init_attr->srq_type == IB_SRQT_TM) {
 		in.tm_log_list_size =
-- 
2.26.2

