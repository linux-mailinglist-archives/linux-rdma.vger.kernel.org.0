Return-Path: <linux-rdma+bounces-2773-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCA38D7FF0
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 12:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D666B2456D
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 10:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED7A82C67;
	Mon,  3 Jun 2024 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MphIJwmv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F8B6BB4B;
	Mon,  3 Jun 2024 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717410418; cv=none; b=sQrTpJ4K3B+QmsNcOenN+wbKM/YBW9ROKjxl2UEw7x7T+W9FGppQ49k4qd4YJaGe0v2Y1WTjB9aaNBAF9QH2hz+zdhcTlfLS2rEhG9/jk4//VqOnf+BBqCBMw1w352wvrVHbatY3WAkcbSat1bhobDkCC2y0AkSB1rRjJCRr5IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717410418; c=relaxed/simple;
	bh=ODkqJLiXdrTzKoVzimmNYHWmtYzxbkhDeDoEiSlcTTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axL05/7pNW6NX6IIDtunP5LPaBGQsK5m2aFexhaMeg7Knb/C8/sjmiDNFIPUJQSZllD49I9lUZFfl6V+AzW7rgIuQH0BVOv9GwM7+UgM+N7cBnSuNgvo6CIP1lehTfqkDLxfmpnuWRDwOmPwhWWkmMg4vY4YMDV1DMc2sW46t+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MphIJwmv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BEDC2BD10;
	Mon,  3 Jun 2024 10:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717410418;
	bh=ODkqJLiXdrTzKoVzimmNYHWmtYzxbkhDeDoEiSlcTTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MphIJwmvmli3KyRELWWEnXDUQJJc5nqeJNa2PvjJhTu3bbDDYcw/kKlOiELuTSpmW
	 cRCxvP8ioKRgFRswB+SEOEvwtU76Hllb8LkDq68ldg4IhhGj63XoFMANbB9mjiWHpH
	 UvSGog2vh87dzsY6gWAk6T4GzLk6M0a8hyVxlWPt0Cy5SBcwBnIFqTiLrPV058OTvd
	 hnWP8i3zs+EwKxcy2Q4/wdA9OoOCkxyAPIVmg8sz8qUoTxPaaHHgqNIRFrCJJOTCoa
	 rUKkcEfnbPhML5mMn9jSixo3LeCNDQATwyQkMCvO+CEWdAgMH3Ui39Gk/OT07AKpmN
	 KBe48QSblCp+w==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH rdma-next 3/3] IB/mlx5: Allocate resources just before first QP/SRQ is created
Date: Mon,  3 Jun 2024 13:26:39 +0300
Message-ID: <98c3e53a8cc0bdfeb6dec6e5bb8b037d78ab00d8.1717409369.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1717409369.git.leon@kernel.org>
References: <cover.1717409369.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

Previously, all IB dev resources are initialized on driver load. As
they are not always used, move the initialization to the time when
they are needed.

To be more specific, move PD (p0) and CQ (c0) initialization to the
time when the first SRQ is created. and move SRQs（s0 and s1)
initialization to the time first QP is created. To avoid concurrent
creations, two new mutexes are also added.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c    | 149 +++++++++++++++++++--------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   4 +
 drivers/infiniband/hw/mlx5/qp.c      |   4 +
 drivers/infiniband/hw/mlx5/srq.c     |   4 +
 4 files changed, 118 insertions(+), 43 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index d7a21998d4ca..a7003316d438 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2854,37 +2854,72 @@ static u8 mlx5_get_umr_fence(u8 umr_fence_cap)
 	}
 }
 
-static int mlx5_ib_dev_res_init(struct mlx5_ib_dev *dev)
+int mlx5_ib_dev_res_cq_init(struct mlx5_ib_dev *dev)
 {
 	struct mlx5_ib_resources *devr = &dev->devr;
-	struct ib_srq_init_attr attr;
-	struct ib_device *ibdev;
 	struct ib_cq_init_attr cq_attr = {.cqe = 1};
-	int port;
+	struct ib_device *ibdev;
+	struct ib_pd *pd;
+	struct ib_cq *cq;
 	int ret = 0;
 
-	ibdev = &dev->ib_dev;
 
-	if (!MLX5_CAP_GEN(dev->mdev, xrc))
-		return -EOPNOTSUPP;
+	/*
+	 * devr->c0 is set once, never changed until device unload.
+	 * Avoid taking the mutex if initialization is already done.
+	 */
+	if (devr->c0)
+		return 0;
 
-	devr->p0 = ib_alloc_pd(ibdev, 0);
-	if (IS_ERR(devr->p0))
-		return PTR_ERR(devr->p0);
+	mutex_lock(&devr->cq_lock);
+	if (devr->c0)
+		goto unlock;
 
-	devr->c0 = ib_create_cq(ibdev, NULL, NULL, NULL, &cq_attr);
-	if (IS_ERR(devr->c0)) {
-		ret = PTR_ERR(devr->c0);
-		goto error1;
+	ibdev = &dev->ib_dev;
+	pd = ib_alloc_pd(ibdev, 0);
+	if (IS_ERR(pd)) {
+		ret = PTR_ERR(pd);
+		mlx5_ib_err(dev, "Couldn't allocate PD for res init, err=%d\n", ret);
+		goto unlock;
 	}
 
-	ret = mlx5_cmd_xrcd_alloc(dev->mdev, &devr->xrcdn0, 0);
-	if (ret)
-		goto error2;
+	cq = ib_create_cq(ibdev, NULL, NULL, NULL, &cq_attr);
+	if (IS_ERR(cq)) {
+		ret = PTR_ERR(cq);
+		mlx5_ib_err(dev, "Couldn't create CQ for res init, err=%d\n", ret);
+		ib_dealloc_pd(pd);
+		goto unlock;
+	}
 
-	ret = mlx5_cmd_xrcd_alloc(dev->mdev, &devr->xrcdn1, 0);
+	devr->p0 = pd;
+	devr->c0 = cq;
+
+unlock:
+	mutex_unlock(&devr->cq_lock);
+	return ret;
+}
+
+int mlx5_ib_dev_res_srq_init(struct mlx5_ib_dev *dev)
+{
+	struct mlx5_ib_resources *devr = &dev->devr;
+	struct ib_srq_init_attr attr;
+	struct ib_srq *s0, *s1;
+	int ret = 0;
+
+	/*
+	 * devr->s1 is set once, never changed until device unload.
+	 * Avoid taking the mutex if initialization is already done.
+	 */
+	if (devr->s1)
+		return 0;
+
+	mutex_lock(&devr->srq_lock);
+	if (devr->s1)
+		goto unlock;
+
+	ret = mlx5_ib_dev_res_cq_init(dev);
 	if (ret)
-		goto error3;
+		goto unlock;
 
 	memset(&attr, 0, sizeof(attr));
 	attr.attr.max_sge = 1;
@@ -2892,10 +2927,11 @@ static int mlx5_ib_dev_res_init(struct mlx5_ib_dev *dev)
 	attr.srq_type = IB_SRQT_XRC;
 	attr.ext.cq = devr->c0;
 
-	devr->s0 = ib_create_srq(devr->p0, &attr);
-	if (IS_ERR(devr->s0)) {
-		ret = PTR_ERR(devr->s0);
-		goto err_create;
+	s0 = ib_create_srq(devr->p0, &attr);
+	if (IS_ERR(s0)) {
+		ret = PTR_ERR(s0);
+		mlx5_ib_err(dev, "Couldn't create SRQ 0 for res init, err=%d\n", ret);
+		goto unlock;
 	}
 
 	memset(&attr, 0, sizeof(attr));
@@ -2903,29 +2939,48 @@ static int mlx5_ib_dev_res_init(struct mlx5_ib_dev *dev)
 	attr.attr.max_wr = 1;
 	attr.srq_type = IB_SRQT_BASIC;
 
-	devr->s1 = ib_create_srq(devr->p0, &attr);
-	if (IS_ERR(devr->s1)) {
-		ret = PTR_ERR(devr->s1);
-		goto error6;
+	s1 = ib_create_srq(devr->p0, &attr);
+	if (IS_ERR(s1)) {
+		ret = PTR_ERR(s1);
+		mlx5_ib_err(dev, "Couldn't create SRQ 1 for res init, err=%d\n", ret);
+		ib_destroy_srq(s0);
+	}
+
+	devr->s0 = s0;
+	devr->s1 = s1;
+
+unlock:
+	mutex_unlock(&devr->srq_lock);
+	return ret;
+}
+
+static int mlx5_ib_dev_res_init(struct mlx5_ib_dev *dev)
+{
+	struct mlx5_ib_resources *devr = &dev->devr;
+	int port;
+	int ret;
+
+	if (!MLX5_CAP_GEN(dev->mdev, xrc))
+		return -EOPNOTSUPP;
+
+	ret = mlx5_cmd_xrcd_alloc(dev->mdev, &devr->xrcdn0, 0);
+	if (ret)
+		return ret;
+
+	ret = mlx5_cmd_xrcd_alloc(dev->mdev, &devr->xrcdn1, 0);
+	if (ret) {
+		mlx5_cmd_xrcd_dealloc(dev->mdev, devr->xrcdn0, 0);
+		return ret;
 	}
 
 	for (port = 0; port < ARRAY_SIZE(devr->ports); ++port)
 		INIT_WORK(&devr->ports[port].pkey_change_work,
 			  pkey_change_handler);
 
-	return 0;
+	mutex_init(&devr->cq_lock);
+	mutex_init(&devr->srq_lock);
 
-error6:
-	ib_destroy_srq(devr->s0);
-err_create:
-	mlx5_cmd_xrcd_dealloc(dev->mdev, devr->xrcdn1, 0);
-error3:
-	mlx5_cmd_xrcd_dealloc(dev->mdev, devr->xrcdn0, 0);
-error2:
-	ib_destroy_cq(devr->c0);
-error1:
-	ib_dealloc_pd(devr->p0);
-	return ret;
+	return 0;
 }
 
 static void mlx5_ib_dev_res_cleanup(struct mlx5_ib_dev *dev)
@@ -2942,12 +2997,20 @@ static void mlx5_ib_dev_res_cleanup(struct mlx5_ib_dev *dev)
 	for (port = 0; port < ARRAY_SIZE(devr->ports); ++port)
 		cancel_work_sync(&devr->ports[port].pkey_change_work);
 
-	ib_destroy_srq(devr->s1);
-	ib_destroy_srq(devr->s0);
+	/* After s0/s1 init, they are not unset during the device lifetime. */
+	if (devr->s1) {
+		ib_destroy_srq(devr->s1);
+		ib_destroy_srq(devr->s0);
+	}
 	mlx5_cmd_xrcd_dealloc(dev->mdev, devr->xrcdn1, 0);
 	mlx5_cmd_xrcd_dealloc(dev->mdev, devr->xrcdn0, 0);
-	ib_destroy_cq(devr->c0);
-	ib_dealloc_pd(devr->p0);
+	/* After p0/c0 init, they are not unset during the device lifetime. */
+	if (devr->c0) {
+		ib_destroy_cq(devr->c0);
+		ib_dealloc_pd(devr->p0);
+	}
+	mutex_destroy(&devr->cq_lock);
+	mutex_destroy(&devr->srq_lock);
 }
 
 static u32 get_core_cap_flags(struct ib_device *ibdev,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 34e34808958e..b63623336d83 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -824,11 +824,13 @@ struct mlx5_ib_port_resources {
 
 struct mlx5_ib_resources {
 	struct ib_cq	*c0;
+	struct mutex cq_lock;
 	u32 xrcdn0;
 	u32 xrcdn1;
 	struct ib_pd	*p0;
 	struct ib_srq	*s0;
 	struct ib_srq	*s1;
+	struct mutex srq_lock;
 	struct mlx5_ib_port_resources ports[2];
 };
 
@@ -1272,6 +1274,8 @@ to_mmmap(struct rdma_user_mmap_entry *rdma_entry)
 		struct mlx5_user_mmap_entry, rdma_entry);
 }
 
+int mlx5_ib_dev_res_cq_init(struct mlx5_ib_dev *dev);
+int mlx5_ib_dev_res_srq_init(struct mlx5_ib_dev *dev);
 int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context, unsigned long virt,
 			struct mlx5_db *db);
 void mlx5_ib_db_unmap_user(struct mlx5_ib_ucontext *context, struct mlx5_db *db);
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 1d09e515aec7..be288cc7a3c0 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3236,6 +3236,10 @@ int mlx5_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 	enum ib_qp_type type;
 	int err;
 
+	err = mlx5_ib_dev_res_srq_init(dev);
+	if (err)
+		return err;
+
 	err = check_qp_type(dev, attr, &type);
 	if (err)
 		return err;
diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index 32c6643d0f7a..ca62bd0ddea8 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -213,6 +213,10 @@ int mlx5_ib_create_srq(struct ib_srq *ib_srq,
 		return -EINVAL;
 	}
 
+	err = mlx5_ib_dev_res_cq_init(dev);
+	if (err)
+		return err;
+
 	mutex_init(&srq->mutex);
 	spin_lock_init(&srq->lock);
 	srq->msrq.max    = roundup_pow_of_two(init_attr->attr.max_wr + 1);
-- 
2.45.1


