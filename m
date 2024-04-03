Return-Path: <linux-rdma+bounces-1757-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3158896CAC
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 12:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971EA1F2CB6F
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 10:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507B3138486;
	Wed,  3 Apr 2024 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cfdxy1+u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13483137C45
	for <linux-rdma@vger.kernel.org>; Wed,  3 Apr 2024 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140578; cv=none; b=GmS3GF3bkEIet20pxEsOGsIXL7TaOG9z24WsSULmWQ8y7mU+nILWrcbK3+cB+8opr3Sh2v02vgIFCGYU2LPS7ciTeUT2qlprXkMUNjrQMH3o2ZUUEewtJA0L/ELgdiulxDmGIf0WPq7ysTCqyx5vFybIODuOqCu688Rxs9ql2cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140578; c=relaxed/simple;
	bh=EB9jUR+T28hPiUhH8QaOjW9Lc8PgZoAWRc+UUme0Aa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ff27ehnORb6hOHUXCdW4gUpGBP5hi2Rtlr1E12TWFEgg4MJfpKds+zx4RLPq7YhG0YRBLApn1BEm0fQaAU2cS8U7rKB6Fd7mWf4QV5dbxEhR94eB6ROfxVpAxesmg9nL4F6tv2S703OHiavnm4YESYGwHONtZ6C6MEufYOC2wj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cfdxy1+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2325C433F1;
	Wed,  3 Apr 2024 10:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712140577;
	bh=EB9jUR+T28hPiUhH8QaOjW9Lc8PgZoAWRc+UUme0Aa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cfdxy1+ukAf639SrQO0D2CQDzSw4zQd055f+8TaXfGPrZQrWJaO5x4XgZkdfYM43C
	 LSoeoeKull9cuFVHLRa77wx2aKpPGEECAhFUegglXZvnE3kZTVC4FMiurzlZWnrevd
	 vW+C9BoL4nJJ0zGlpI+8VHAO3Tx9YFM/cLEprvCK/yoWqUtj4nGYI8F1jASLmU2jSy
	 MKakCfCih2Vvql9eotO04wFmxT3iqU+mh/DVJdNw0Rvxd2/63NvEz1tFC/YFnhGnvE
	 rk4hcO7NA9Q9OLLUHHQ0qy7sU22U4jBXvSkz5aqT/ZV1rcVsLj4HwDl7jv756P7Ais
	 mP7GqGW2mqyEQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Or Har-Toov <ohartoov@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next v2 2/3] RDMA/mlx5: Change check for cacheable mkeys
Date: Wed,  3 Apr 2024 13:36:00 +0300
Message-ID: <2690bc5c6896bcb937f89af16a1ff0343a7ab3d0.1712140377.git.leon@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712140377.git.leon@kernel.org>
References: <cover.1712140377.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Or Har-Toov <ohartoov@nvidia.com>

umem can be NULL for user application mkeys in some cases. Therefore
umem can't be used for checking if the mkey is cacheable and it is
changed for checking a flag that indicates it. Also make sure that
all mkeys which are not returned to the cache will be destroyed.

Fixes: dd1b913fb0d0 ("RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow")
Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
 drivers/infiniband/hw/mlx5/mr.c      | 32 +++++++++++++++++++---------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index e74f04865062..f255a12e26a0 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -646,6 +646,7 @@ struct mlx5_ib_mkey {
 	/* Cacheable user Mkey must hold either a rb_key or a cache_ent. */
 	struct mlx5r_cache_rb_key rb_key;
 	struct mlx5_cache_ent *cache_ent;
+	u8 cacheable : 1;
 };
 
 #define MLX5_IB_MTT_PRESENT (MLX5_IB_MTT_READ | MLX5_IB_MTT_WRITE)
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index a8ee2ca1f4a1..7f7b1f59b5f0 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1158,6 +1158,7 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 		if (IS_ERR(mr))
 			return mr;
 		mr->mmkey.rb_key = rb_key;
+		mr->mmkey.cacheable = true;
 		return mr;
 	}
 
@@ -1168,6 +1169,7 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 	mr->ibmr.pd = pd;
 	mr->umem = umem;
 	mr->page_shift = order_base_2(page_size);
+	mr->mmkey.cacheable = true;
 	set_mr_fields(dev, mr, umem->length, access_flags, iova);
 
 	return mr;
@@ -1835,6 +1837,23 @@ static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
 	return ret;
 }
 
+static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
+{
+	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
+	struct mlx5_cache_ent *ent = mr->mmkey.cache_ent;
+
+	if (mr->mmkey.cacheable && !mlx5r_umr_revoke_mr(mr) && !cache_ent_find_and_store(dev, mr))
+		return 0;
+
+	if (ent) {
+		spin_lock_irq(&ent->mkeys_queue.lock);
+		ent->in_use--;
+		mr->mmkey.cache_ent = NULL;
+		spin_unlock_irq(&ent->mkeys_queue.lock);
+	}
+	return destroy_mkey(dev, mr);
+}
+
 int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
 	struct mlx5_ib_mr *mr = to_mmr(ibmr);
@@ -1880,16 +1899,9 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	}
 
 	/* Stop DMA */
-	if (mr->umem && mlx5r_umr_can_load_pas(dev, mr->umem->length))
-		if (mlx5r_umr_revoke_mr(mr) ||
-		    cache_ent_find_and_store(dev, mr))
-			mr->mmkey.cache_ent = NULL;
-
-	if (!mr->mmkey.cache_ent) {
-		rc = destroy_mkey(to_mdev(mr->ibmr.device), mr);
-		if (rc)
-			return rc;
-	}
+	rc = mlx5_revoke_mr(mr);
+	if (rc)
+		return rc;
 
 	if (mr->umem) {
 		bool is_odp = is_odp_mr(mr);
-- 
2.44.0


