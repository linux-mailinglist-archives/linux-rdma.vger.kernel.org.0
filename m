Return-Path: <linux-rdma+bounces-121-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E68A87FBA25
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Nov 2023 13:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1E5282DB8
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Nov 2023 12:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA005788B;
	Tue, 28 Nov 2023 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E17mDLWf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6557056B75;
	Tue, 28 Nov 2023 12:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE3AC433C8;
	Tue, 28 Nov 2023 12:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701174628;
	bh=FqRs+n2vyKD4g05NJ+vvDrUy0df4FL7mrdN+0I3HKWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E17mDLWfQc/fBBLMN2Y6k32hv0lCxOz9WBatAXPiwEszWlPIyrFZCTyLCo8i6Zazo
	 FqyDvgsIVtyuwRSfe6fZUjbHMDI5zR+5+ow3CzVxwbMzrNw6ZO3q9RargZKhxDX9z6
	 lLYgwGSi7/FoMcTj4HMQpAWkJn5jXolRat2pQ31UIBymid0RKnhwM0iuwiwIEvFRTh
	 OyQMrsWT/Kx4IwfB1rWnKS6+FeGmW5UgBoVbBMpcto0d1VYfUBdyifs/B481Ro1/F0
	 36SPIxhqIPnsOZx2PPL7wecd/eulbtztS8ee6pqbT7ngzW2CXc4XLnr/ECNnLw2VZM
	 iaOnKWQGg1jpA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shun Hao <shunh@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next 2/5] net/mlx5: Manage ICM type of SW encap
Date: Tue, 28 Nov 2023 14:29:46 +0200
Message-ID: <37dc4fd78dfa3374ff53aa602f038a2ec76eb069.1701172481.git.leon@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701172481.git.leon@kernel.org>
References: <cover.1701172481.git.leon@kernel.org>
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


