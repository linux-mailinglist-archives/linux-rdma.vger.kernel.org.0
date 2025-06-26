Return-Path: <linux-rdma+bounces-11694-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3EFAEA5FD
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 20:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B425D1894AF1
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 18:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF352EF2B7;
	Thu, 26 Jun 2025 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APX0fpk1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83122EE5F4
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750964338; cv=none; b=dpOA2QTAt9Pu1pjmB1rBwTh6bsYOqHHelY1iLxZz0BWlrcDtots7brESQBcE4/Fq/FsCHIPMSPpwgiX8x2m5Gg+CoA6mRHf58yonVv+4r/Z4SBXyKkYJ3JNcW80xSUHbesJu0SXyWqduCbMYtLfi3Qs/7qWfJLMB+IjwfhAFM0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750964338; c=relaxed/simple;
	bh=me7g0p/8P+V5E1z549TWNMiMGIkP8pff96CKNZ+AM6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awml3Mi0037JirIryd+wivGWJJs5/O78fm4KPgLNAx2goF7opjcDqW9ugapqLBM0wCL2PbOMYnP0cz7y560n6D5LW7wg5aLzDmD3u6Kes+mw2zKewgJNKOR1e4y8lM0mvS37n9CP0AmZo27P77H0cnIB7lqgxY3sm/brwimyfPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APX0fpk1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76FFC4CEEB;
	Thu, 26 Jun 2025 18:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750964338;
	bh=me7g0p/8P+V5E1z549TWNMiMGIkP8pff96CKNZ+AM6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=APX0fpk1aB18EOd7re1JzqfiGtDpEv5s4sbXueckh8xTDVKLP9Idk8GB8OmvnyJlT
	 KQvZApxVLsHG5COnUbsX1xREwpExJwJEO5ZUhe/TOJL0m4ptkOstT7QYNdjRTVzNrJ
	 kgF2nNJb2+pGy9RPi5wdoQXlg8fZ8A/A9YFnF8LiVJJmFvj7UIwTN8trpbdXnb1nJt
	 b+hap5Nd4DVfVN5jk/l+fkWWjPAfKaKxgGzgFN7ii9sfXta1IhvyPOJJyYWww+WTjY
	 7GGFOtuNdLspQLdY+qBp4R1o0BIH1M+Co+SiVB6hwR+q6fxe//UwjDi86VmBaRqoQT
	 NICobM4zEa3RA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next v2 7/9] RDMA/mlx5: Check CAP_NET_RAW in user namespace for devx create
Date: Thu, 26 Jun 2025 21:58:10 +0300
Message-ID: <36ee87e92defd81410c6a2b33f9d6c0d6dcfd64c.1750963874.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750963874.git.leon@kernel.org>
References: <cover.1750963874.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Parav Pandit <parav@nvidia.com>

Currently, the capability check is done in the default
init_user_ns user namespace. When a process runs in a
non default user namespace, such check fails. Due to this
when a process is running using Podman, it fails to create
the devx object.

Since the RDMA device is a resource within a network namespace,
use the network namespace associated with the RDMA device to
determine its owning user namespace.

Fixes: a8b92ca1b0e5 ("IB/mlx5: Introduce DEVX")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index e5551736ee14..44b4521619c4 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -159,7 +159,7 @@ int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user, u64 req_ucaps)
 	uctx = MLX5_ADDR_OF(create_uctx_in, in, uctx);
 	if (is_user &&
 	    (MLX5_CAP_GEN(dev->mdev, uctx_cap) & MLX5_UCTX_CAP_RAW_TX) &&
-	    capable(CAP_NET_RAW))
+	    rdma_dev_has_raw_cap(&dev->ib_dev))
 		cap |= MLX5_UCTX_CAP_RAW_TX;
 	if (is_user &&
 	    (MLX5_CAP_GEN(dev->mdev, uctx_cap) &
-- 
2.49.0


