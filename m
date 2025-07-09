Return-Path: <linux-rdma+bounces-11994-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B232AFE04F
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 08:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D285848EA
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 06:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F4527A12D;
	Wed,  9 Jul 2025 06:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZs4aREc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9798B279DD5
	for <linux-rdma@vger.kernel.org>; Wed,  9 Jul 2025 06:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043351; cv=none; b=EEep4VDc3tdkc8PV/pJ3ILotu23mvfmBDN0g+N7koGC0ss0Rh2Ikwdqw5uWQvUasbLq5kDJxeSsqJx+Tt0wn/5uwUOvM+OwG85/zqeGcpUF0V2JNPK65bpbE5ceEFMx7V4CATSRCfYvcPGEPSQ7yyzxwAPqHUBf7aWHp4MQGtCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043351; c=relaxed/simple;
	bh=cz35e5E3xreMIB2EXM40Cop+irGbwtTiXzSd05LZknQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUvPxDqV7NJSHxqKNBAUkOvbXRU+aKFPXlAGunx040vZBuP2EeAS9Ec5QkigPENF5WxhaG1irq6Zcw0RkQImI4z+3W49HPtRP0drby592+O5H2egvlNDxHDOllB66JU6YlwFQvdGUy2oDbHKKdqDrVML11BvqAYM/tWwU71F6cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZs4aREc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0651C4CEF1;
	Wed,  9 Jul 2025 06:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752043351;
	bh=cz35e5E3xreMIB2EXM40Cop+irGbwtTiXzSd05LZknQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EZs4aREcywcLL8l6IDnZ8QR8eOAV0EbSwWAKT2HMpHqRGYFZvpYqGPxD2PBd91k+/
	 Ri4kruBtXJYKZWs1xdM717L7aSw8C85UOK/BXfbWFDdv0th0c95rRqulJWxM7WZdz9
	 a5a7Cl/WuVUCeg2atgBAsDsX7CiENyHR65NG9biTn6Q25HuqTi9cQvnZeWM+N+hm3u
	 0i4NF5iTB1A42fDiqC+r2Yx1QLK9HtpoAo23iqc3IqLrdu6tfRB72/6TvgB7BjfgCm
	 fOG3O/MvFbNHVPXAR9T9+gtJIWkkw4SUnwYicnF7sdiu6apu8YgwMLa6XNINBhFc+0
	 aNa5u8Y+fk6RA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Guralnik <michaelgur@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 3/4] RDMA/mlx5: Align mkc page size capability check to PRM
Date: Wed,  9 Jul 2025 09:42:10 +0300
Message-ID: <eab4eeb4785105a4bb5eb362dc0b3662cd840412.1751979184.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751979184.git.leon@kernel.org>
References: <cover.1751979184.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michael Guralnik <michaelgur@nvidia.com>

Align the capabilities checked when using the log_page_size 6th bit in the
mkey context to the PRM definition. The upper and lower bounds are set by
max/min caps, and modification of the 6th bit by UMR is allowed only when
a specific UMR cap is set.
Current implementation falsely assumes all page sizes up-to 2^63 are
supported when the UMR cap is set. In case the upper bound cap is lower
than 63, this might result a FW syndrome on mkey creation, e.g:
mlx5_core 0000:c1:00.0: mlx5_cmd_out_err:832:(pid 0): CREATE_MKEY(0×200) op_mod(0×0) failed, status bad parameter(0×3), syndrome (0×38a711), err(-22)

Previous cap enforcement is still correct for all current HW, FW and
driver combinations. However, this patch aligns the code to be PRM
compliant in the general case.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 51 +++++++++++++++++++++++++---
 drivers/infiniband/hw/mlx5/mr.c      | 10 +++---
 2 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index bca549f70200..37e557d259fc 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1757,18 +1757,59 @@ static inline u32 smi_to_native_portnum(struct mlx5_ib_dev *dev, u32 port)
 	return (port - 1) / dev->num_ports + 1;
 }
 
+static inline unsigned int get_max_log_entity_size_cap(struct mlx5_ib_dev *dev,
+						       int access_mode)
+{
+	int max_log_size = 0;
+
+	if (access_mode == MLX5_MKC_ACCESS_MODE_MTT)
+		max_log_size =
+			MLX5_CAP_GEN_2(dev->mdev, max_mkey_log_entity_size_mtt);
+	else if (access_mode == MLX5_MKC_ACCESS_MODE_KSM)
+		max_log_size = MLX5_CAP_GEN_2(
+			dev->mdev, max_mkey_log_entity_size_fixed_buffer);
+
+	if (!max_log_size ||
+	    (max_log_size > 31 &&
+	     !MLX5_CAP_GEN_2(dev->mdev, umr_log_entity_size_5)))
+		max_log_size = 31;
+
+	return max_log_size;
+}
+
+static inline unsigned int get_min_log_entity_size_cap(struct mlx5_ib_dev *dev,
+						       int access_mode)
+{
+	int min_log_size = 0;
+
+	if (access_mode == MLX5_MKC_ACCESS_MODE_KSM &&
+	    MLX5_CAP_GEN_2(dev->mdev,
+			   min_mkey_log_entity_size_fixed_buffer_valid))
+		min_log_size = MLX5_CAP_GEN_2(
+			dev->mdev, min_mkey_log_entity_size_fixed_buffer);
+	else
+		min_log_size =
+			MLX5_CAP_GEN_2(dev->mdev, log_min_mkey_entity_size);
+
+	min_log_size = max(min_log_size, MLX5_ADAPTER_PAGE_SHIFT);
+	return min_log_size;
+}
+
 /*
  * For mkc users, instead of a page_offset the command has a start_iova which
  * specifies both the page_offset and the on-the-wire IOVA
  */
 static __always_inline unsigned long
 mlx5_umem_mkc_find_best_pgsz(struct mlx5_ib_dev *dev, struct ib_umem *umem,
-			     u64 iova)
+			     u64 iova, int access_mode)
 {
-	int page_size_bits =
-		MLX5_CAP_GEN_2(dev->mdev, umr_log_entity_size_5) ? 6 : 5;
-	unsigned long bitmap =
-		__mlx5_log_page_size_to_bitmap(page_size_bits, 0);
+	unsigned int max_log_entity_size_cap, min_log_entity_size_cap;
+	unsigned long bitmap;
+
+	max_log_entity_size_cap = get_max_log_entity_size_cap(dev, access_mode);
+	min_log_entity_size_cap = get_min_log_entity_size_cap(dev, access_mode);
+
+	bitmap = GENMASK_ULL(max_log_entity_size_cap, min_log_entity_size_cap);
 
 	return ib_umem_find_best_pgsz(umem, bitmap, iova);
 }
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 5f36cad69dd7..753ca99c367f 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1188,7 +1188,8 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 	if (umem->is_dmabuf)
 		page_size = mlx5_umem_dmabuf_default_pgsz(umem, iova);
 	else
-		page_size = mlx5_umem_mkc_find_best_pgsz(dev, umem, iova);
+		page_size = mlx5_umem_mkc_find_best_pgsz(dev, umem, iova,
+							 access_mode);
 	if (WARN_ON(!page_size))
 		return ERR_PTR(-EINVAL);
 
@@ -1526,8 +1527,8 @@ static struct ib_mr *create_real_mr(struct ib_pd *pd, struct ib_umem *umem,
 		mr = alloc_cacheable_mr(pd, umem, iova, access_flags,
 					MLX5_MKC_ACCESS_MODE_MTT, st_index, ph);
 	} else {
-		unsigned long page_size =
-			mlx5_umem_mkc_find_best_pgsz(dev, umem, iova);
+		unsigned long page_size = mlx5_umem_mkc_find_best_pgsz(
+			dev, umem, iova, MLX5_MKC_ACCESS_MODE_MTT);
 
 		mutex_lock(&dev->slow_path_mutex);
 		mr = reg_create(pd, umem, iova, access_flags, page_size,
@@ -1873,7 +1874,8 @@ static bool can_use_umr_rereg_pas(struct mlx5_ib_mr *mr,
 	if (!mlx5r_umr_can_load_pas(dev, new_umem->length))
 		return false;
 
-	*page_size = mlx5_umem_mkc_find_best_pgsz(dev, new_umem, iova);
+	*page_size = mlx5_umem_mkc_find_best_pgsz(
+		dev, new_umem, iova, mr->mmkey.cache_ent->rb_key.access_mode);
 	if (WARN_ON(!*page_size))
 		return false;
 	return (mr->mmkey.cache_ent->rb_key.ndescs) >=
-- 
2.50.0


