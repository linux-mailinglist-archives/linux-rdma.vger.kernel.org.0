Return-Path: <linux-rdma+bounces-12707-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5E7B2499E
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 14:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B729C1707E1
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 12:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625FF2C0F64;
	Wed, 13 Aug 2025 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qvkk/xfV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A7E212553
	for <linux-rdma@vger.kernel.org>; Wed, 13 Aug 2025 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755088803; cv=none; b=KDjP/EhCb6PMSdkG6EdAOH3yeNbxWPdEPtawjstX2Kh1YySx29RzjNtf5DSzxnNbxvlGjyGGO80GXaDyLv6PpyZIqalq/vDggPI8A7ekXtcduYVP8Jh4U+C9Xhwah6kMsSJqwOFJXgqMvF1sh826cPBs14kfC4yIC+J/XAjQKKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755088803; c=relaxed/simple;
	bh=Fl+aIS4ariplb+1rMtU6nMXeuGo8czPBfFMmO2t3o/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oisdc/zv8xi/H+4bItuIDHWshiKw0UR8nzM8mT/L4XbpH7r2OFd9W+UuYZ6TmxWQ+o7X5z8GET8a+UuulwEqQr71vCvT1ETgZr6JTQboPHw2IlkGCifwV6OojxJbs0QgASQfH2kDD26keaSSJ6iWNWJmHlz2MQGgdHLdwf70ZJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qvkk/xfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440A9C4CEEB;
	Wed, 13 Aug 2025 12:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755088802;
	bh=Fl+aIS4ariplb+1rMtU6nMXeuGo8czPBfFMmO2t3o/w=;
	h=From:To:Cc:Subject:Date:From;
	b=Qvkk/xfV0hMQoDur/tZPXiz62g8kpjDNgD0PyxsnQZflgazIItfdBsSsrgvxprV13
	 CMZ6erH0/S6sVwVJqYFhuNpQifg9VwH3v25NG2J0d3avtSFN8q4K2WO5DCkkLel+DN
	 O4koJblUj2SFDs4GDsnejp/Gt/kolKHdnDh9qlGL+J1YGIYJJ6yks3ce37jxwVxYr/
	 YrJT8+M4RKZaDDZ4Z8R2hhFpFK56aeOk+15hUVoYuHOTLisG2kVVbIVbNeXFxN7EDl
	 8FaKbS//jtOja+ygNKi4jY50SHbR4FlJbvvXum18BZxQYOGc3MZJdoAuLHq4l52UnB
	 FopVq40S/6RRA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Or Har-Toov <ohartoov@nvidia.com>,
	Chuck Lever <cel@kernel.org>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/mlx5: Better estimate max_qp_wr to reflect WQE count
Date: Wed, 13 Aug 2025 15:39:56 +0300
Message-ID: <7d992c9831c997ed5c33d30973406dc2dcaf5e89.1755088725.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Or Har-Toov <ohartoov@nvidia.com>

The mlx5 driver currently derives max_qp_wr directly from the
log_max_qp_sz HCA capability:

    props->max_qp_wr = 1 << MLX5_CAP_GEN(mdev, log_max_qp_sz);

However, this value represents the number of WQEs in units of
Basic Blocks (see MLX5_SEND_WQE_BB), not actual number of WQEs.
Since the size of a WQE can vary depending on transport type and
features (e.g., atomic operations, UMR, LSO), the actual number of
WQEs can be significantly smaller than the WQEBB count suggests.

This patch introduces a conservative estimation of the worst-case WQE
size — considering largest segments possible with 1 SGE and no inline
data or special features. It uses this to derive a more accurate
max_qp_wr value.

Fixes: 938fe83c8dcb ("net/mlx5_core: New device capabilities handling")
Reported-by: Chuck Lever <cel@kernel.org>
Closes: https://lore.kernel.org/all/20250506142202.GJ2260621@ziepe.ca/
Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 48 ++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 505349c68e79..de5339170876 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -13,6 +13,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/bitmap.h>
+#include <linux/log2.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
@@ -883,6 +884,51 @@ static void fill_esw_mgr_reg_c0(struct mlx5_core_dev *mdev,
 	resp->reg_c0.mask = mlx5_eswitch_get_vport_metadata_mask();
 }
 
+/*
+ * Calculate maximum SQ overhead across all QP types.
+ * Other QP types (REG_UMR, UC, RC, UD/SMI/GSI, XRC_TGT)
+ * have smaller overhead than the types calculated below,
+ * so they are implicitly included.
+ */
+static u32 mlx5_ib_calc_max_sq_overhead(void)
+{
+	u32 max_overhead_xrc, overhead_ud_lso, a, b;
+
+	/* XRC_INI */
+	max_overhead_xrc = sizeof(struct mlx5_wqe_xrc_seg);
+	max_overhead_xrc += sizeof(struct mlx5_wqe_ctrl_seg);
+	a = sizeof(struct mlx5_wqe_atomic_seg) +
+	    sizeof(struct mlx5_wqe_raddr_seg);
+	b = sizeof(struct mlx5_wqe_umr_ctrl_seg) +
+	    sizeof(struct mlx5_mkey_seg) +
+	    MLX5_IB_SQ_UMR_INLINE_THRESHOLD / MLX5_IB_UMR_OCTOWORD;
+	max_overhead_xrc += max(a, b);
+
+	/* UD with LSO */
+	overhead_ud_lso = sizeof(struct mlx5_wqe_ctrl_seg);
+	overhead_ud_lso += sizeof(struct mlx5_wqe_eth_pad);
+	overhead_ud_lso += sizeof(struct mlx5_wqe_eth_seg);
+	overhead_ud_lso += sizeof(struct mlx5_wqe_datagram_seg);
+
+	return max(max_overhead_xrc, overhead_ud_lso);
+}
+
+static u32 mlx5_ib_calc_max_qp_wr(struct mlx5_ib_dev *dev)
+{
+	struct mlx5_core_dev *mdev = dev->mdev;
+	u32 max_wqe_bb_units = 1 << MLX5_CAP_GEN(mdev, log_max_qp_sz);
+	u32 max_wqe_size;
+	/* max QP overhead + 1 SGE, no inline, no special features */
+	max_wqe_size = mlx5_ib_calc_max_sq_overhead() +
+		       sizeof(struct mlx5_wqe_data_seg);
+
+	max_wqe_size = roundup_pow_of_two(max_wqe_size);
+
+	max_wqe_size = ALIGN(max_wqe_size, MLX5_SEND_WQE_BB);
+
+	return (max_wqe_bb_units * MLX5_SEND_WQE_BB) / max_wqe_size;
+}
+
 static int mlx5_ib_query_device(struct ib_device *ibdev,
 				struct ib_device_attr *props,
 				struct ib_udata *uhw)
@@ -1041,7 +1087,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 	props->max_mr_size	   = ~0ull;
 	props->page_size_cap	   = ~(min_page_size - 1);
 	props->max_qp		   = 1 << MLX5_CAP_GEN(mdev, log_max_qp);
-	props->max_qp_wr	   = 1 << MLX5_CAP_GEN(mdev, log_max_qp_sz);
+	props->max_qp_wr = mlx5_ib_calc_max_qp_wr(dev);
 	max_rq_sg =  MLX5_CAP_GEN(mdev, max_wqe_sz_rq) /
 		     sizeof(struct mlx5_wqe_data_seg);
 	max_sq_desc = min_t(int, MLX5_CAP_GEN(mdev, max_wqe_sz_sq), 512);
-- 
2.50.1


