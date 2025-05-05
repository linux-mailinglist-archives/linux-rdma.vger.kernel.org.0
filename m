Return-Path: <linux-rdma+bounces-10046-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C198AAB6FD
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 08:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22103AD224
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 05:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39733221F26;
	Tue,  6 May 2025 00:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCYDUtjt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C98C38F87E;
	Mon,  5 May 2025 23:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486133; cv=none; b=GdkIZMwUSNTDw9YAWUnuxxBGMRJ11gPiFIk6FunutBFSkca4NEBw6ULM/4em9q6rpIK1y9aXFy63QQui5/9s8J/PgnDYqr0Rt9HiDp8Afh1AbsuHL48iTe5kPX4syUBvSMbwjGSnUIUPqVlN6b8Gb47RXEObZiEiEuJiQ8wNou4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486133; c=relaxed/simple;
	bh=n04rLEh71zJAsbPHQW6k7hl7SG90shhXibPrZ8bfqJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H0fXNzUWkuSDqaPQEgqu59IA8GVYF9BjG2DcPrFsBxvmufcjq1LSJxkvcNF1MAwugO3FclN42plk8yKwbMR7FU0maV/RG6kfmJgxdLbeQKpkF4F1ozKoWpl7Os62aO5B52CTs9cE7n8yryOYHlfToD6nxOjCbRKJJY6okfq+148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCYDUtjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A131C4CEE4;
	Mon,  5 May 2025 23:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486133;
	bh=n04rLEh71zJAsbPHQW6k7hl7SG90shhXibPrZ8bfqJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nCYDUtjt/V+1IqfmpbHeZc5KbrsymakTxaOAJDAWsX1cs6Q02XD/Y6vzk6ZlJ02Ov
	 WV9k2cpI3TtPjMT0/6KNqxKDj6muQ4M7AQqvA9lm94JEg7c4iJ3QAYVbAZSnbgMuWc
	 FE38XTeygMNdDjjshBkzQrFpz+1Q5w73D1CyYAr+QDOHhjrBJwd+xDSMYyb+i99+Tx
	 O5fII+Gi1aQeNR4xTa2DXb+2KFeM6RPFljUz7PIjfKKACVCZ+EvtAImRv1GpQ6YJnb
	 72rHlcr2kjvRcta9tnDaPE7d6Vf7GoZbV6/81JDtCQGS1/bAnPLzSdbSEwINkIC9Te
	 Sm140RisMU2+g==
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
	horms@kernel.org,
	vulab@iscas.ac.cn,
	michal.swiatkowski@linux.intel.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 168/294] net/mlx5: Change POOL_NEXT_SIZE define value and make it global
Date: Mon,  5 May 2025 18:54:28 -0400
Message-Id: <20250505225634.2688578-168-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 3fb428ce7d1c7..b6b9a4dfa4fb9 100644
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


