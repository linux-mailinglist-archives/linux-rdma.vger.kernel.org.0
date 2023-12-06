Return-Path: <linux-rdma+bounces-283-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6D580719D
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Dec 2023 15:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D971F21692
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Dec 2023 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454863DB87;
	Wed,  6 Dec 2023 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAV2pGGc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AC83C46C;
	Wed,  6 Dec 2023 14:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7605C433C9;
	Wed,  6 Dec 2023 14:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701871319;
	bh=FqRs+n2vyKD4g05NJ+vvDrUy0df4FL7mrdN+0I3HKWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AAV2pGGcpqDR9HBdxLO7RBO7UF0Yb1KFiV1cDuZZAVUbxb8z/+d6MbEimNWXxOpBT
	 z71QMc7xNQXi+H9B6lZuhS0TmVcyPjnyHSBa5CxCQZX7TX5ikoeQdO/KuAk1nCshL5
	 DLkvxb5/eR86whMEo0FOk50twJqvCOZtBxwfzlvF6zh/YtbUnJLT2wsv9mcPnwB5i4
	 zZVV8VjLwOSSsrxtW4ZrtBVINKd+iLNxCl7eAs5ZMNakNtnAsu/KZSDQBrq/nkzoqT
	 IyTfqPgWVXbU8HKnUOWZ48uU5I9zRK1hEg1uY5EQBi5190z11EfcDhNTGLagalX5ZA
	 tRW1fTR8kanNQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shun Hao <shunh@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next v1 3/5] net/mlx5: Manage ICM type of SW encap
Date: Wed,  6 Dec 2023 16:01:36 +0200
Message-ID: <bed5121255918eb132a1334141c76a0594df8143.1701871118.git.leon@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701871118.git.leon@kernel.org>
References: <cover.1701871118.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shun Hao <shunh@nvidia.com>

Support allocate/deallocate the new SW encap ICM type memory.
The new ICM type is used for encap context allocation managed by SW,
instead FW. It can increase encap context maximum number and allocation
speed

Signed-off-by: Shun Hao <shunh@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lib/dm.c  | 38 ++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c
index 9482e51ac82a..7c5516b0a844 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c
@@ -13,11 +13,13 @@ struct mlx5_dm {
 	unsigned long *steering_sw_icm_alloc_blocks;
 	unsigned long *header_modify_sw_icm_alloc_blocks;
 	unsigned long *header_modify_pattern_sw_icm_alloc_blocks;
+	unsigned long *header_encap_sw_icm_alloc_blocks;
 };
 
 struct mlx5_dm *mlx5_dm_create(struct mlx5_core_dev *dev)
 {
 	u64 header_modify_pattern_icm_blocks = 0;
+	u64 header_sw_encap_icm_blocks = 0;
 	u64 header_modify_icm_blocks = 0;
 	u64 steering_icm_blocks = 0;
 	struct mlx5_dm *dm;
@@ -54,6 +56,17 @@ struct mlx5_dm *mlx5_dm_create(struct mlx5_core_dev *dev)
 			goto err_modify_hdr;
 	}
 
+	if (MLX5_CAP_DEV_MEM(dev, log_indirect_encap_sw_icm_size)) {
+		header_sw_encap_icm_blocks =
+			BIT(MLX5_CAP_DEV_MEM(dev, log_indirect_encap_sw_icm_size) -
+			    MLX5_LOG_SW_ICM_BLOCK_SIZE(dev));
+
+		dm->header_encap_sw_icm_alloc_blocks =
+			bitmap_zalloc(header_sw_encap_icm_blocks, GFP_KERNEL);
+		if (!dm->header_encap_sw_icm_alloc_blocks)
+			goto err_pattern;
+	}
+
 	support_v2 = MLX5_CAP_FLOWTABLE_NIC_RX(dev, sw_owner_v2) &&
 		     MLX5_CAP_FLOWTABLE_NIC_TX(dev, sw_owner_v2) &&
 		     MLX5_CAP64_DEV_MEM(dev, header_modify_pattern_sw_icm_start_address);
@@ -66,11 +79,14 @@ struct mlx5_dm *mlx5_dm_create(struct mlx5_core_dev *dev)
 		dm->header_modify_pattern_sw_icm_alloc_blocks =
 			bitmap_zalloc(header_modify_pattern_icm_blocks, GFP_KERNEL);
 		if (!dm->header_modify_pattern_sw_icm_alloc_blocks)
-			goto err_pattern;
+			goto err_sw_encap;
 	}
 
 	return dm;
 
+err_sw_encap:
+	bitmap_free(dm->header_encap_sw_icm_alloc_blocks);
+
 err_pattern:
 	bitmap_free(dm->header_modify_sw_icm_alloc_blocks);
 
@@ -105,6 +121,14 @@ void mlx5_dm_cleanup(struct mlx5_core_dev *dev)
 		bitmap_free(dm->header_modify_sw_icm_alloc_blocks);
 	}
 
+	if (dm->header_encap_sw_icm_alloc_blocks) {
+		WARN_ON(!bitmap_empty(dm->header_encap_sw_icm_alloc_blocks,
+				      BIT(MLX5_CAP_DEV_MEM(dev,
+							   log_indirect_encap_sw_icm_size) -
+				      MLX5_LOG_SW_ICM_BLOCK_SIZE(dev))));
+		bitmap_free(dm->header_encap_sw_icm_alloc_blocks);
+	}
+
 	if (dm->header_modify_pattern_sw_icm_alloc_blocks) {
 		WARN_ON(!bitmap_empty(dm->header_modify_pattern_sw_icm_alloc_blocks,
 				      BIT(MLX5_CAP_DEV_MEM(dev,
@@ -164,6 +188,13 @@ int mlx5_dm_sw_icm_alloc(struct mlx5_core_dev *dev, enum mlx5_sw_icm_type type,
 						log_header_modify_pattern_sw_icm_size);
 		block_map = dm->header_modify_pattern_sw_icm_alloc_blocks;
 		break;
+	case MLX5_SW_ICM_TYPE_SW_ENCAP:
+		icm_start_addr = MLX5_CAP64_DEV_MEM(dev,
+						    indirect_encap_sw_icm_start_address);
+		log_icm_size = MLX5_CAP_DEV_MEM(dev,
+						log_indirect_encap_sw_icm_size);
+		block_map = dm->header_encap_sw_icm_alloc_blocks;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -242,6 +273,11 @@ int mlx5_dm_sw_icm_dealloc(struct mlx5_core_dev *dev, enum mlx5_sw_icm_type type
 						    header_modify_pattern_sw_icm_start_address);
 		block_map = dm->header_modify_pattern_sw_icm_alloc_blocks;
 		break;
+	case MLX5_SW_ICM_TYPE_SW_ENCAP:
+		icm_start_addr = MLX5_CAP64_DEV_MEM(dev,
+						    indirect_encap_sw_icm_start_address);
+		block_map = dm->header_encap_sw_icm_alloc_blocks;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.43.0


