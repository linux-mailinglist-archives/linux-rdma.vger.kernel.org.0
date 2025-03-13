Return-Path: <linux-rdma+bounces-8667-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6560FA5F7B3
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 15:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777DF3BF1E2
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 14:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2875267B96;
	Thu, 13 Mar 2025 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSZG61E3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F7C267B86
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875562; cv=none; b=oAKkoyuGuAsJCMnEAd9edn8QXSjE0sDBCy5iDCI/8Rp/WRSViJ4r2APnAlSS2t9A9ZUIiaIn9i14QOx+D+Drkta8NbwpGE0Te7NqPk91N2NGEzICj0dSnR3zA3KKwPaEnqg6pbt8AdjH7N8lgvAFvq46AVENa/PrcGQlrYOdcdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875562; c=relaxed/simple;
	bh=5rX874PAJj0q/YZ4X8UkekYUkCpd5KipjFb5/csv5bA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWOGSaYKxVu0AUna4MtkLHK468AQM2YnUQUzs77VG7pnCEDTnzsXY0ieYJBr1uxyKcjx/OOmW2sjl7siWGq/FTuoaj+r+S+Hcnn1vJIpyvRKM4N9QpuYKSg75xZ8ZN2Q3SgifTF0H/6Af3gsKDmb3nWdKqXyPaHKzirz/0DU7iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSZG61E3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C2AC4CEE5;
	Thu, 13 Mar 2025 14:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741875561;
	bh=5rX874PAJj0q/YZ4X8UkekYUkCpd5KipjFb5/csv5bA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kSZG61E3A5ITaJustqdBjbNwmnkjNkKUXBtOBxdttw1OjwVFJk0fjCT34XE1/ED04
	 mPVp/8P6dYGOICNSdtAH8KM+xRC6blDSO05KzQr+DNIcSEGwjaYxNP6w0sAaXMkLbU
	 2rGksuDXRSmlAecf/vpB/t5K6ziQOOAAbLCxd0KDqUGkEkZZc6d42/UTH7fgHEZIHo
	 gmmqLObPsK7DlpAuIT1bkLgAQsaxQNF17WfnN1SYjRMbGbACCoGX5WjM8enU42u31c
	 CV/OiV7U6qzMeUjqo9f1rhSFTDTpi4sz4TAefTgLXA6pPjF0dzVD6pORWRQCbAv5rH
	 JTfIYG6hgKNgQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 5/6] RDMA/mlx5: Compile fs.c regardless of INFINIBAND_USER_ACCESS config
Date: Thu, 13 Mar 2025 16:18:45 +0200
Message-ID: <b8dd220456a91538b22c3aff150ab021d7b9e1bf.1741875070.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741875070.git.leon@kernel.org>
References: <cover.1741875070.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Change mlx5 Makefile, fs.c and fs.h to support fs compilation regardless
of INFINIBAND_USER_ACCESS config.

In addition allow optional counters support regardless of the config.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/Makefile   |  2 +-
 drivers/infiniband/hw/mlx5/counters.c |  8 +++-----
 drivers/infiniband/hw/mlx5/fs.c       |  4 +++-
 drivers/infiniband/hw/mlx5/fs.h       | 15 ---------------
 4 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/Makefile b/drivers/infiniband/hw/mlx5/Makefile
index b38961f5058e..11878ddf7cc7 100644
--- a/drivers/infiniband/hw/mlx5/Makefile
+++ b/drivers/infiniband/hw/mlx5/Makefile
@@ -9,6 +9,7 @@ mlx5_ib-y := ah.o \
 	     data_direct.o \
 	     dm.o \
 	     doorbell.o \
+	     fs.o \
 	     gsi.o \
 	     ib_virt.o \
 	     mad.o \
@@ -26,7 +27,6 @@ mlx5_ib-y := ah.o \
 mlx5_ib-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += odp.o
 mlx5_ib-$(CONFIG_MLX5_ESWITCH) += ib_rep.o
 mlx5_ib-$(CONFIG_INFINIBAND_USER_ACCESS) += devx.o \
-					    fs.o \
 					    qos.o \
 					    std_types.o
 mlx5_ib-$(CONFIG_MLX5_MACSEC) += macsec.o
diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index d826f03b6ec5..542f591d73e0 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -849,9 +849,8 @@ static void mlx5_ib_dealloc_counters(struct mlx5_ib_dev *dev)
 				    dev->port[i].cnts.opfcs, j, &in_use_opfc))
 				goto skip;
 
-			if (IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS))
-				mlx5_ib_fs_remove_op_fc(dev,
-					&dev->port[i].cnts.opfcs[j], j);
+			mlx5_ib_fs_remove_op_fc(dev,
+						&dev->port[i].cnts.opfcs[j], j);
 			mlx5_fc_destroy(dev->mdev,
 					dev->port[i].cnts.opfcs[j].fc);
 skip:
@@ -1115,8 +1114,7 @@ static const struct ib_device_ops hw_stats_ops = {
 	.counter_dealloc = mlx5_ib_counter_dealloc,
 	.counter_alloc_stats = mlx5_ib_counter_alloc_stats,
 	.counter_update_stats = mlx5_ib_counter_update_stats,
-	.modify_hw_stat = IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS) ?
-			  mlx5_ib_modify_stat : NULL,
+	.modify_hw_stat = mlx5_ib_modify_stat,
 	.counter_init = mlx5_ib_counter_init,
 
 	INIT_RDMA_OBJ_SIZE(rdma_counter, mlx5_rdma_counter, rdma_counter),
diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 93b229e9aab3..71a47821a564 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -679,7 +679,7 @@ enum flow_table_type {
 #define MLX5_FS_MAX_TYPES	 6
 #define MLX5_FS_MAX_ENTRIES	 BIT(16)
 
-static bool mlx5_ib_shared_ft_allowed(struct ib_device *device)
+static bool __maybe_unused mlx5_ib_shared_ft_allowed(struct ib_device *device)
 {
 	struct mlx5_ib_dev *dev = to_mdev(device);
 
@@ -3030,6 +3030,7 @@ DECLARE_UVERBS_NAMED_OBJECT(
 	&UVERBS_METHOD(MLX5_IB_METHOD_STEERING_ANCHOR_DESTROY));
 
 const struct uapi_definition mlx5_ib_flow_defs[] = {
+#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(
 		MLX5_IB_OBJECT_FLOW_MATCHER),
 	UAPI_DEF_CHAIN_OBJ_TREE(
@@ -3040,6 +3041,7 @@ const struct uapi_definition mlx5_ib_flow_defs[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(
 		MLX5_IB_OBJECT_STEERING_ANCHOR,
 		UAPI_DEF_IS_OBJ_SUPPORTED(mlx5_ib_shared_ft_allowed)),
+#endif
 	{},
 };
 
diff --git a/drivers/infiniband/hw/mlx5/fs.h b/drivers/infiniband/hw/mlx5/fs.h
index 0516555eb1c1..2ebe86e5be10 100644
--- a/drivers/infiniband/hw/mlx5/fs.h
+++ b/drivers/infiniband/hw/mlx5/fs.h
@@ -8,23 +8,8 @@
 
 #include "mlx5_ib.h"
 
-#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 int mlx5_ib_fs_init(struct mlx5_ib_dev *dev);
 void mlx5_ib_fs_cleanup_anchor(struct mlx5_ib_dev *dev);
-#else
-static inline int mlx5_ib_fs_init(struct mlx5_ib_dev *dev)
-{
-	dev->flow_db = kzalloc(sizeof(*dev->flow_db), GFP_KERNEL);
-
-	if (!dev->flow_db)
-		return -ENOMEM;
-
-	mutex_init(&dev->flow_db->lock);
-	return 0;
-}
-
-inline void mlx5_ib_fs_cleanup_anchor(struct mlx5_ib_dev *dev) {}
-#endif
 
 static inline void mlx5_ib_fs_cleanup(struct mlx5_ib_dev *dev)
 {
-- 
2.48.1


