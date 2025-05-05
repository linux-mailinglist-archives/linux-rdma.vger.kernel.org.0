Return-Path: <linux-rdma+bounces-10036-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105A8AAB0ED
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 05:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB3416603A
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 03:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35DD32CE1A;
	Tue,  6 May 2025 00:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG3rqBx+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D9437644B;
	Mon,  5 May 2025 22:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485331; cv=none; b=fCa+HgTnW6Ha4aMjIaM6Fkte7vLwE2bPyabkQpdGIKmW0Wzw8sIw/QlKRVgO7WGpZ4O2QPcbnz8DAJCnEvMvHgG4FE4kYUhfpezzwWc+13WjX08+8FBnIonK0rWqflrb1sxZAwmh6yzplZRGTtcmEifQ4AjUtB/uxATJgjiQyYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485331; c=relaxed/simple;
	bh=D4lkrT/yWaJAnrMzcJmx2VpchVQU9nradxuRL/fyQ9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GXKUWdmhCuR9vhZ9svj1CVFZ92wStjyEjf9nQg3Fu2fJ1jkcucaRmJHG9U7hqYOydjwXVCF3AYjDnq0KOpqTtzjZ9dXgGnypqDc5MpxbtdMSO1DeD2ZeqypdrZ+YzUy9OQTiHrZe+RncglYKMlszOK6IHE40FjmNTHZRQ/Q/5PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG3rqBx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603DFC4CEE4;
	Mon,  5 May 2025 22:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485330;
	bh=D4lkrT/yWaJAnrMzcJmx2VpchVQU9nradxuRL/fyQ9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jG3rqBx+W48hJjwrlT/PY2pRe2i/w6m5SSd/SNB2JhjuyFnSNaKkHacHAsyf2+zhi
	 mQSSAHm3OQhNpdq6e62dktPi+QOpgqN3a31OGDnJkBSGIW7TPZBOCYLvEA5Ob0tSOh
	 S4fWalFTUfQvvsAtqgVuxAViQHn0Bwj24qEg5AWVmyd+EdVOxeLj9LeEYLAebWBBfg
	 /7nGud/JjyYieq7fzdoLMQSBaLQXvXdhJMAdwMUIfC9/B0n01zh+F+i73gGa5KhteR
	 D/VHTMGdrjbMRI/jIj5gIWaxq5pBBGHme7QpBgmwTyoEtX8EEvM6wCKh19aI8ptQsD
	 kPPt2iCbN2Ccw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	saeedm@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	cratiu@nvidia.com,
	bpoirier@nvidia.com,
	michal.swiatkowski@linux.intel.com,
	vulab@iscas.ac.cn,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 270/486] net/mlx5: Change POOL_NEXT_SIZE define value and make it global
Date: Mon,  5 May 2025 18:35:46 -0400
Message-Id: <20250505223922.2682012-270-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

[ Upstream commit 80df31f384b4146a62a01b3d4beb376cc7b9a89e ]

Change POOL_NEXT_SIZE define value from 0 to BIT(30), since this define
is used to request the available maximum sized flow table, and zero doesn't
make sense for it, whereas some places in the driver use zero explicitly
expecting the smallest table size possible but instead due to this
define they end up allocating the biggest table size unawarely.

In addition move the definition to "include/linux/mlx5/fs.h" to expose the
define to IB driver as well, while appropriately renaming it.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20250219085808.349923-3-tariqt@nvidia.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c    | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_ft_pool.c    | 6 ++++--
 drivers/net/ethernet/mellanox/mlx5/core/fs_ft_pool.h    | 2 --
 drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c | 3 ++-
 include/linux/mlx5/fs.h                                 | 2 ++
 5 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c
index 8587cd572da53..bdb825aa87268 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c
@@ -96,7 +96,7 @@ static int esw_create_legacy_fdb_table(struct mlx5_eswitch *esw)
 	if (!flow_group_in)
 		return -ENOMEM;
 
-	ft_attr.max_fte = POOL_NEXT_SIZE;
+	ft_attr.max_fte = MLX5_FS_MAX_POOL_SIZE;
 	ft_attr.prio = LEGACY_FDB_PRIO;
 	fdb = mlx5_create_flow_table(root_ns, &ft_attr);
 	if (IS_ERR(fdb)) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_ft_pool.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_ft_pool.c
index c14590acc7726..f6abfd00d7e68 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_ft_pool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_ft_pool.c
@@ -50,10 +50,12 @@ mlx5_ft_pool_get_avail_sz(struct mlx5_core_dev *dev, enum fs_flow_table_type tab
 	int i, found_i = -1;
 
 	for (i = ARRAY_SIZE(FT_POOLS) - 1; i >= 0; i--) {
-		if (dev->priv.ft_pool->ft_left[i] && FT_POOLS[i] >= desired_size &&
+		if (dev->priv.ft_pool->ft_left[i] &&
+		    (FT_POOLS[i] >= desired_size ||
+		     desired_size == MLX5_FS_MAX_POOL_SIZE) &&
 		    FT_POOLS[i] <= max_ft_size) {
 			found_i = i;
-			if (desired_size != POOL_NEXT_SIZE)
+			if (desired_size != MLX5_FS_MAX_POOL_SIZE)
 				break;
 		}
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_ft_pool.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_ft_pool.h
index 25f4274b372b5..173e312db7204 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_ft_pool.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_ft_pool.h
@@ -7,8 +7,6 @@
 #include <linux/mlx5/driver.h>
 #include "fs_core.h"
 
-#define POOL_NEXT_SIZE 0
-
 int mlx5_ft_pool_init(struct mlx5_core_dev *dev);
 void mlx5_ft_pool_destroy(struct mlx5_core_dev *dev);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
index 711d14dea2485..d313cb7f0ed88 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
@@ -161,7 +161,8 @@ mlx5_chains_create_table(struct mlx5_fs_chains *chains,
 		ft_attr.flags |= (MLX5_FLOW_TABLE_TUNNEL_EN_REFORMAT |
 				  MLX5_FLOW_TABLE_TUNNEL_EN_DECAP);
 
-	sz = (chain == mlx5_chains_get_nf_ft_chain(chains)) ? FT_TBL_SZ : POOL_NEXT_SIZE;
+	sz = (chain == mlx5_chains_get_nf_ft_chain(chains)) ?
+		FT_TBL_SZ : MLX5_FS_MAX_POOL_SIZE;
 	ft_attr.max_fte = sz;
 
 	/* We use chains_default_ft(chains) as the table's next_ft till
diff --git a/include/linux/mlx5/fs.h b/include/linux/mlx5/fs.h
index b744e554f014d..db5c9ddef1702 100644
--- a/include/linux/mlx5/fs.h
+++ b/include/linux/mlx5/fs.h
@@ -40,6 +40,8 @@
 
 #define MLX5_SET_CFG(p, f, v) MLX5_SET(create_flow_group_in, p, f, v)
 
+#define MLX5_FS_MAX_POOL_SIZE BIT(30)
+
 enum mlx5_flow_destination_type {
 	MLX5_FLOW_DESTINATION_TYPE_NONE,
 	MLX5_FLOW_DESTINATION_TYPE_VPORT,
-- 
2.39.5


