Return-Path: <linux-rdma+bounces-11797-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB11AEF7D8
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 14:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E77160E26
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 12:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A919C26E6FE;
	Tue,  1 Jul 2025 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3XQT8NV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676892AD02;
	Tue,  1 Jul 2025 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751371701; cv=none; b=n+f+hOCJLCx9PNDSS46PKy0iakutWEnY8F8xTbcfOdCqr3veeiN5w+qOMCOpG9HpXayzridZtaByLPGZnx874M4UG/syhkWgsBH2XnkZqV4Hu+VN5ruCImmlTxA7xLiu+o4sEreDMdVDXpC4xlufAVVh3AD355E/YNkAxQVTY8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751371701; c=relaxed/simple;
	bh=pvdIBN4frq0DQC/ySVQMbholmnlh0MgxWog6ebk4YT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d+gqQOq725MVA3uRisxa/6Vzjd5hEZoQRJo4ZaVxyNF14YFuVudXk18QWDuxnJSVJISBxqVnC3VsUPsjaRYrXuljVNjRyc/1etGUyMAmlO1jLPkdKjfdevBA9T71dlOcKydUTmMrA4EP/bOzMsnnlsmDhaE4eL02Iboo7S80j/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3XQT8NV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5010EC4CEEB;
	Tue,  1 Jul 2025 12:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751371701;
	bh=pvdIBN4frq0DQC/ySVQMbholmnlh0MgxWog6ebk4YT0=;
	h=From:To:Cc:Subject:Date:From;
	b=Q3XQT8NVNQsmKO/7F0jzKdtV1x+viSv5sFrdbezsqJB6hpxwldNrKxKoz5sbJomjA
	 6MU0AUI9qcPEr9j3YKgBy60aKiFOCbXgu9PEZVxhbE8b5alYb7h4nsvSXqh0ehK+uf
	 zAmpnTFS+2UMxdGJ/Wb8rwP1IBd+C+rpxj1D4lvS50J80JEbzVFwD2ZQCMJkabHzvL
	 g1OJjhkW8kLcxCas9V5S0i+NgVOeC7OccvBiow8ufl9M5Qn5YjFiWg7qi7bTL9lALW
	 W5ziAA1yi/QqeCWayXWyovlrsHp/brc4iQ13uZLk6D656mGLAzr/Y4eXdL+gwcMGUg
	 L8EtEbDYgh6ZQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Stav Aviram <saviram@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <markb@mellanox.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH mlx5-next v1] net/mlx5: Check device memory pointer before usage
Date: Tue,  1 Jul 2025 15:08:12 +0300
Message-ID: <c88711327f4d74d5cebc730dc629607e989ca187.1751370035.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stav Aviram <saviram@nvidia.com>

Add a NULL check before accessing device memory to prevent a crash if
dev->dm allocation in mlx5_init_once() fails.

Fixes: c9b9dcb430b3 ("net/mlx5: Move device memory management to mlx5_core")
Signed-off-by: Stav Aviram <saviram@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Changelog:
v1:
 * Removed extra IS_ERR(dm) check.
v0:
https://lore.kernel.org/all/e389fa6ef075af1049cd7026b912d736ebe3ad23.1751279408.git.leonro@nvidia.com
---
 drivers/infiniband/hw/mlx5/dm.c                  | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/main.c   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/dm.c b/drivers/infiniband/hw/mlx5/dm.c
index b4c97fb62abf..9ded2b7c1e31 100644
--- a/drivers/infiniband/hw/mlx5/dm.c
+++ b/drivers/infiniband/hw/mlx5/dm.c
@@ -282,7 +282,7 @@ static struct ib_dm *handle_alloc_dm_memic(struct ib_ucontext *ctx,
 	int err;
 	u64 address;
 
-	if (!MLX5_CAP_DEV_MEM(dm_db->dev, memic))
+	if (!dm_db || !MLX5_CAP_DEV_MEM(dm_db->dev, memic))
 		return ERR_PTR(-EOPNOTSUPP);
 
 	dm = kzalloc(sizeof(*dm), GFP_KERNEL);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c
index 7c5516b0a844..8115071c34a4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c
@@ -30,7 +30,7 @@ struct mlx5_dm *mlx5_dm_create(struct mlx5_core_dev *dev)
 
 	dm = kzalloc(sizeof(*dm), GFP_KERNEL);
 	if (!dm)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	spin_lock_init(&dm->lock);
 
@@ -96,7 +96,7 @@ struct mlx5_dm *mlx5_dm_create(struct mlx5_core_dev *dev)
 err_steering:
 	kfree(dm);
 
-	return ERR_PTR(-ENOMEM);
+	return NULL;
 }
 
 void mlx5_dm_cleanup(struct mlx5_core_dev *dev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 41e8660c819c..e9baf4221cde 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1102,7 +1102,7 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 	}
 
 	dev->dm = mlx5_dm_create(dev);
-	if (IS_ERR(dev->dm))
+	if (!dev->dm)
 		mlx5_core_warn(dev, "Failed to init device memory %ld\n", PTR_ERR(dev->dm));
 
 	dev->tracer = mlx5_fw_tracer_create(dev);
-- 
2.50.0


