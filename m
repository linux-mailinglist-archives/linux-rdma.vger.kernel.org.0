Return-Path: <linux-rdma+bounces-2774-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F128D7FF2
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 12:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB8031C229DB
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 10:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF2F82D7A;
	Mon,  3 Jun 2024 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fF+RW8G9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDB56BB4B;
	Mon,  3 Jun 2024 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717410423; cv=none; b=cZKIAwsBpg2WKtEQZSUG9fur3qsv0uE/vJOZ+tKtNnKPVqaL9pM6IvI2jRIj7bj5QRlB49ZgAAV2E++JHh6as6vHi85+sQjCubU1/2LOk0RnMKd2vlRM8/JzYNyG04+bQwM6g7gSvBi51FKcW3b8VmOFcNsN7ugvEwdLbLMZ27Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717410423; c=relaxed/simple;
	bh=0EeD26Nx4xp4Nuic9jGlZHNS5ASGkC3/i+nWrOtDsE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8LUGs2g4D2zK7EiXDqa8mZVS3wdgHeZk/Nrw4Ds3W8UuFlOxziY1IP2kwTKJAjml8J06v+WadEq+XgG5Hk1bq4Z1QqI+rNYLumSz2J/SUB+GpS1vWCvfbMoEyDTB+bwpWzi1aCsI1EKIH84TuY0Xs0zIfwsDNn2H6zymy6/FXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fF+RW8G9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489ECC2BD10;
	Mon,  3 Jun 2024 10:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717410422;
	bh=0EeD26Nx4xp4Nuic9jGlZHNS5ASGkC3/i+nWrOtDsE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fF+RW8G9PHWL9vaSz7lRDAW7gnf4GiXyBFj5CBn5j//8L3+OEF+/afpATvEEh1Bre
	 YJn6J083TYw5M7yWea+Jf2JDCgexoHPz16RAUSbpYh+etP64rZlCNWEAe3Gm/6Cext
	 f+NQJfFm2cwDjDcd2ew4kuCPKBXLLj5a7YhhaY2QToXnIGmePgAqH05cRprJJg87WP
	 ZBSGULnUMmTbeZ1AlJpiLCh2YfoXaSWhmFqABTn0owHLkfIzm6Ryj4DHr7eSuqbdWX
	 FI54BYFUnqEimbT8hLDe7g+wwQNzyxS3LRAK0unb1r1TapKGsZkjzQmDu3b0INvOyq
	 SvG/KfoMySJ8A==
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
Subject: [PATCH rdma-next 2/3] IB/mlx5: Create UMR QP just before first reg_mr occurs
Date: Mon,  3 Jun 2024 13:26:38 +0300
Message-ID: <55d3c4f8a542fd974d8a4c5816eccfb318a59b38.1717409369.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1717409369.git.leon@kernel.org>
References: <cover.1717409369.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

UMR QP is not used in some cases, so move QP and its CQ creations from
driver load flow to the time first reg_mr occurs, that is when MR
interfaces are first called.

The initialization of dev->umrc.pd and dev->umrc.lock is still done in
driver load because pd is needed for mlx5_mkey_cache_init and the lock
is reused to protect against the concurrent creation.

When testing 4G bytes memory registration latency with rtool [1] and 8
threads in parallel, there is minor performance degradation (<5% for
the max latency) is seen for the first reg_mr with this change.

Link: https://github.com/paravmellanox/rtool [1]

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c    |  3 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 +
 drivers/infiniband/hw/mlx5/mr.c      |  9 +++++
 drivers/infiniband/hw/mlx5/umr.c     | 55 +++++++++++++++++++++-------
 drivers/infiniband/hw/mlx5/umr.h     |  3 ++
 5 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index ec4031e851e6..d7a21998d4ca 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4117,6 +4117,7 @@ static void mlx5_ib_stage_pre_ib_reg_umr_cleanup(struct mlx5_ib_dev *dev)
 {
 	mlx5_mkey_cache_cleanup(dev);
 	mlx5r_umr_resource_cleanup(dev);
+	mlx5r_umr_cleanup(dev);
 }
 
 static void mlx5_ib_stage_ib_reg_cleanup(struct mlx5_ib_dev *dev)
@@ -4128,7 +4129,7 @@ static int mlx5_ib_stage_post_ib_reg_umr_init(struct mlx5_ib_dev *dev)
 {
 	int ret;
 
-	ret = mlx5r_umr_resource_init(dev);
+	ret = mlx5r_umr_init(dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index a74e6f5798f6..34e34808958e 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -751,6 +751,8 @@ struct umr_common {
 	 */
 	struct mutex lock;
 	unsigned int state;
+	/* Protects from repeat UMR QP creation */
+	struct mutex init_lock;
 };
 
 #define NUM_MKEYS_PER_PAGE \
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index ccb741dc1b37..ba8754e7d362 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1480,6 +1480,7 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct ib_umem *umem;
+	int err;
 
 	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_MEM))
 		return ERR_PTR(-EOPNOTSUPP);
@@ -1487,6 +1488,10 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	mlx5_ib_dbg(dev, "start 0x%llx, iova 0x%llx, length 0x%llx, access_flags 0x%x\n",
 		    start, iova, length, access_flags);
 
+	err = mlx5r_umr_resource_init(dev);
+	if (err)
+		return ERR_PTR(err);
+
 	if (access_flags & IB_ACCESS_ON_DEMAND)
 		return create_user_odp_mr(pd, start, length, iova, access_flags,
 					  udata);
@@ -1534,6 +1539,10 @@ struct ib_mr *mlx5_ib_reg_user_mr_dmabuf(struct ib_pd *pd, u64 offset,
 		    "offset 0x%llx, virt_addr 0x%llx, length 0x%llx, fd %d, access_flags 0x%x\n",
 		    offset, virt_addr, length, fd, access_flags);
 
+	err = mlx5r_umr_resource_init(dev);
+	if (err)
+		return ERR_PTR(err);
+
 	/* dmabuf requires xlt update via umr to work. */
 	if (!mlx5r_umr_can_load_pas(dev, length))
 		return ERR_PTR(-EINVAL);
diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index e76142f6fa88..ffc31b01f690 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -135,22 +135,28 @@ static int mlx5r_umr_qp_rst2rts(struct mlx5_ib_dev *dev, struct ib_qp *qp)
 int mlx5r_umr_resource_init(struct mlx5_ib_dev *dev)
 {
 	struct ib_qp_init_attr init_attr = {};
-	struct ib_pd *pd;
 	struct ib_cq *cq;
 	struct ib_qp *qp;
-	int ret;
+	int ret = 0;
 
-	pd = ib_alloc_pd(&dev->ib_dev, 0);
-	if (IS_ERR(pd)) {
-		mlx5_ib_dbg(dev, "Couldn't create PD for sync UMR QP\n");
-		return PTR_ERR(pd);
-	}
+
+	/*
+	 * UMR qp is set once, never changed until device unload.
+	 * Avoid taking the mutex if initialization is already done.
+	 */
+	if (dev->umrc.qp)
+		return 0;
+
+	mutex_lock(&dev->umrc.init_lock);
+	/* First user allocates the UMR resources. Skip if already allocated. */
+	if (dev->umrc.qp)
+		goto unlock;
 
 	cq = ib_alloc_cq(&dev->ib_dev, NULL, 128, 0, IB_POLL_SOFTIRQ);
 	if (IS_ERR(cq)) {
 		mlx5_ib_dbg(dev, "Couldn't create CQ for sync UMR QP\n");
 		ret = PTR_ERR(cq);
-		goto destroy_pd;
+		goto unlock;
 	}
 
 	init_attr.send_cq = cq;
@@ -160,7 +166,7 @@ int mlx5r_umr_resource_init(struct mlx5_ib_dev *dev)
 	init_attr.cap.max_send_sge = 1;
 	init_attr.qp_type = MLX5_IB_QPT_REG_UMR;
 	init_attr.port_num = 1;
-	qp = ib_create_qp(pd, &init_attr);
+	qp = ib_create_qp(dev->umrc.pd, &init_attr);
 	if (IS_ERR(qp)) {
 		mlx5_ib_dbg(dev, "Couldn't create sync UMR QP\n");
 		ret = PTR_ERR(qp);
@@ -171,22 +177,22 @@ int mlx5r_umr_resource_init(struct mlx5_ib_dev *dev)
 	if (ret)
 		goto destroy_qp;
 
-	dev->umrc.qp = qp;
 	dev->umrc.cq = cq;
-	dev->umrc.pd = pd;
 
 	sema_init(&dev->umrc.sem, MAX_UMR_WR);
 	mutex_init(&dev->umrc.lock);
 	dev->umrc.state = MLX5_UMR_STATE_ACTIVE;
+	dev->umrc.qp = qp;
 
+	mutex_unlock(&dev->umrc.init_lock);
 	return 0;
 
 destroy_qp:
 	ib_destroy_qp(qp);
 destroy_cq:
 	ib_free_cq(cq);
-destroy_pd:
-	ib_dealloc_pd(pd);
+unlock:
+	mutex_unlock(&dev->umrc.init_lock);
 	return ret;
 }
 
@@ -194,8 +200,31 @@ void mlx5r_umr_resource_cleanup(struct mlx5_ib_dev *dev)
 {
 	if (dev->umrc.state == MLX5_UMR_STATE_UNINIT)
 		return;
+	mutex_destroy(&dev->umrc.lock);
+	/* After device init, UMR cp/qp are not unset during the lifetime. */
 	ib_destroy_qp(dev->umrc.qp);
 	ib_free_cq(dev->umrc.cq);
+}
+
+int mlx5r_umr_init(struct mlx5_ib_dev *dev)
+{
+	struct ib_pd *pd;
+
+	pd = ib_alloc_pd(&dev->ib_dev, 0);
+	if (IS_ERR(pd)) {
+		mlx5_ib_dbg(dev, "Couldn't create PD for sync UMR QP\n");
+		return PTR_ERR(pd);
+	}
+	dev->umrc.pd = pd;
+
+	mutex_init(&dev->umrc.init_lock);
+
+	return 0;
+}
+
+void mlx5r_umr_cleanup(struct mlx5_ib_dev *dev)
+{
+	mutex_destroy(&dev->umrc.init_lock);
 	ib_dealloc_pd(dev->umrc.pd);
 }
 
diff --git a/drivers/infiniband/hw/mlx5/umr.h b/drivers/infiniband/hw/mlx5/umr.h
index 3799bb758e49..5f734dc72bef 100644
--- a/drivers/infiniband/hw/mlx5/umr.h
+++ b/drivers/infiniband/hw/mlx5/umr.h
@@ -16,6 +16,9 @@
 int mlx5r_umr_resource_init(struct mlx5_ib_dev *dev);
 void mlx5r_umr_resource_cleanup(struct mlx5_ib_dev *dev);
 
+int mlx5r_umr_init(struct mlx5_ib_dev *dev);
+void mlx5r_umr_cleanup(struct mlx5_ib_dev *dev);
+
 static inline bool mlx5r_umr_can_load_pas(struct mlx5_ib_dev *dev,
 					  size_t length)
 {
-- 
2.45.1


