Return-Path: <linux-rdma+bounces-10319-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C711EAB536A
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 13:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0070619E018D
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 11:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C717D28C855;
	Tue, 13 May 2025 11:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEB/mG+b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E0D28C5CF
	for <linux-rdma@vger.kernel.org>; Tue, 13 May 2025 11:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747134169; cv=none; b=fGxge/Cw5q0VI+13o0LDQDpAw1z9eG9nib8fIez7opnnYlpfZhFRwnvO36D09CJrDzNbwRcAHlvArsZPmrdATI0zftDCZgT6ZXu98ONhUnfQs0onDVogihaxIrhovo9wpA3HBHwM4xRFL3pbHkQDZ0OvO9zSJ6j/8OGp1bYOAbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747134169; c=relaxed/simple;
	bh=XwXHmehBIMIS4jtA4kup/vFQxJ1ZcNK8Z3iS7fECnco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=URLxUXsenyXAw/8Y8nYh8rI/PLRhpG1tp97t4CcnAothxNrK+kS4WmWP/Wzk9mYcgiu+H7m/hQV07vRvkrSC26F1hTKoi0mH4T2YhFi0DdoK4IJQrI3BK7M04JCB+D7+JsqAfel+CqPwWQRUrND50pLvslE6OB/QmsRDIu4ktxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEB/mG+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9ADC4AF09;
	Tue, 13 May 2025 11:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747134168;
	bh=XwXHmehBIMIS4jtA4kup/vFQxJ1ZcNK8Z3iS7fECnco=;
	h=From:To:Cc:Subject:Date:From;
	b=iEB/mG+bkm0AcpS6RaqhhM75zpr7pwICaUcAwdZZgIZbFFzbzId8DedEtX8KsES/S
	 I834dHIi36RyPQmjCaTA3+z5/XAdkNU+2Ozayys7KlN3A9km4nW1bm3ZypcBn61ufS
	 uFfba0rUaCLjEleQw1I6jXM6gkgYsYw5ZeK11q/uAu2PbrbNIg3gdRhZC6cTC6cWjM
	 njR24p5k4k2O5Uag+34q+UfVtX5mBmSPp74hQk5Zp7KlILJIJRB1uPzvBTZTvah6Tk
	 xLGNMrnl6kc8n2GUQSsJngIvBg7hGVJfinlvA9zQ8NS8w7wiMZjVuHV1ZhNHdrQRKu
	 29Tyc6B2FsCHA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Fan Li <fanl@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/mlx5: Remove the redundant MLX5_IB_STAGE_UAR stage
Date: Tue, 13 May 2025 14:02:40 +0300
Message-ID: <feaa84ec6f20468b4935c439923e9266122a93d0.1747134130.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yishai Hadas <yishaih@nvidia.com>

The MLX5_IB_STAGE_UAR stage in the RDMA driver is redundant and should
be removed.

Responsibility for initializing the device's UAR pointer
(mdev->priv.uar) lies with mlx5_core, which already sets it during the
mlx5_load() process.

At present, the RDMA UAR stage overwrites this pointer, which was
correctly initialized by mlx5_core, creating the risk of inconsistency.

Ownership and management of the UAR pointer should remain exclusively
within mlx5_core.

In the current upstream code, we luckily receive the same pointer, since
mlx5_get_uars_page() still finds available BF registers for that UAR,
allowing it to be shared.

However, future changes in mlx5_core may expose this flaw.
For instance, if mlx5_alloc_bfreg() is invoked twice before the RDMA UAR
stage runs, the RDMA driver may overwrite the UAR allocated by
mlx5_core.

This could lead to real bugs. For example, if mlx5_ib is unloaded
(rmmod), it might free the UAR, leaving mlx5_core with a dangling
reference to an invalid UAR.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Reviewed-by: Fan Li <fanl@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c    | 17 -----------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 -
 2 files changed, 18 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index d07cacaa0abd..32ad066c3c4a 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4422,17 +4422,6 @@ static void mlx5_ib_stage_cong_debugfs_cleanup(struct mlx5_ib_dev *dev)
 				     mlx5_core_native_port_num(dev->mdev) - 1);
 }
 
-static int mlx5_ib_stage_uar_init(struct mlx5_ib_dev *dev)
-{
-	dev->mdev->priv.uar = mlx5_get_uars_page(dev->mdev);
-	return PTR_ERR_OR_ZERO(dev->mdev->priv.uar);
-}
-
-static void mlx5_ib_stage_uar_cleanup(struct mlx5_ib_dev *dev)
-{
-	mlx5_put_uars_page(dev->mdev, dev->mdev->priv.uar);
-}
-
 static int mlx5_ib_stage_bfrag_init(struct mlx5_ib_dev *dev)
 {
 	int err;
@@ -4662,9 +4651,6 @@ static const struct mlx5_ib_profile pf_profile = {
 	STAGE_CREATE(MLX5_IB_STAGE_CONG_DEBUGFS,
 		     mlx5_ib_stage_cong_debugfs_init,
 		     mlx5_ib_stage_cong_debugfs_cleanup),
-	STAGE_CREATE(MLX5_IB_STAGE_UAR,
-		     mlx5_ib_stage_uar_init,
-		     mlx5_ib_stage_uar_cleanup),
 	STAGE_CREATE(MLX5_IB_STAGE_BFREG,
 		     mlx5_ib_stage_bfrag_init,
 		     mlx5_ib_stage_bfrag_cleanup),
@@ -4722,9 +4708,6 @@ const struct mlx5_ib_profile raw_eth_profile = {
 	STAGE_CREATE(MLX5_IB_STAGE_CONG_DEBUGFS,
 		     mlx5_ib_stage_cong_debugfs_init,
 		     mlx5_ib_stage_cong_debugfs_cleanup),
-	STAGE_CREATE(MLX5_IB_STAGE_UAR,
-		     mlx5_ib_stage_uar_init,
-		     mlx5_ib_stage_uar_cleanup),
 	STAGE_CREATE(MLX5_IB_STAGE_BFREG,
 		     mlx5_ib_stage_bfrag_init,
 		     mlx5_ib_stage_bfrag_cleanup),
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 84a1f07d46a7..9c6ec5a968b1 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1006,7 +1006,6 @@ enum mlx5_ib_stages {
 	MLX5_IB_STAGE_ODP,
 	MLX5_IB_STAGE_COUNTERS,
 	MLX5_IB_STAGE_CONG_DEBUGFS,
-	MLX5_IB_STAGE_UAR,
 	MLX5_IB_STAGE_BFREG,
 	MLX5_IB_STAGE_PRE_IB_REG_UMR,
 	MLX5_IB_STAGE_WHITELIST_UID,
-- 
2.49.0


