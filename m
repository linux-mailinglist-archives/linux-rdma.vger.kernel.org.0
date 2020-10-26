Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF50A298DC0
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 14:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421598AbgJZNXe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 09:23:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1421592AbgJZNXd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Oct 2020 09:23:33 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EEB2207DE;
        Mon, 26 Oct 2020 13:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603718612;
        bh=7WiHUL6CuTl84aan+xjl0aMDE8SoXhOrqLpHwFvBj4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NPt35Rw5TaHP9dLK+DXNqwLrqhBF0tReCWLSZuhpJEJYP6nbIcY74Aa+xVBPzfosQ
         DInxWuSL4XGzQP926u09PfmodqvnM7aMyZf1ePBdDMq4Gk86Syk/h1ucjg9SnNM5kZ
         3+pwM1EW8+dVCpn/q8x4QSzMFu7GRfolb3nxbSzc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 5/5] RDMA/mlx5: Use ib_umem_find_best_pgsz() for mkc's
Date:   Mon, 26 Oct 2020 15:23:14 +0200
Message-Id: <20201026132314.1336717-6-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026132314.1336717-1-leon@kernel.org>
References: <20201026132314.1336717-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Now that all the PAS arrays or UMR XLT's for mkcs are filled using
rdma_for_each_block() we can use the common ib_umem_find_best_pgsz()
algorithm.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/umem.c       |  9 +++++++
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 27 ++++++++++++++++++++
 drivers/infiniband/hw/mlx5/mr.c      | 37 +++++++++++++++-------------
 3 files changed, 56 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index e9fecbdf391b..f1fc7e39c782 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -84,6 +84,15 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 	dma_addr_t mask;
 	int i;
 
+	if (umem->is_odp) {
+		unsigned int page_size = BIT(to_ib_umem_odp(umem)->page_shift);
+
+		/* ODP must always be self consistent. */
+		if (!(pgsz_bitmap & page_size))
+			return 0;
+		return page_size;
+	}
+
 	/* rdma_for_each_block() has a bug if the page size is smaller than the
 	 * page size used to build the umem. For now prevent smaller page sizes
 	 * from being returned.
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index aadd43425a58..bb44080170be 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -42,6 +42,33 @@
 
 #define MLX5_MKEY_PAGE_SHIFT_MASK __mlx5_mask(mkc, log_page_size)
 
+static __always_inline unsigned long
+__mlx5_log_page_size_to_bitmap(unsigned int log_pgsz_bits,
+			       unsigned int pgsz_shift)
+{
+	unsigned int largest_pg_shift =
+		min_t(unsigned long, (1ULL << log_pgsz_bits) - 1 + pgsz_shift,
+		      BITS_PER_LONG - 1);
+
+	/*
+	 * Despite a command allowing it, the device does not support lower than
+	 * 4k page size.
+	 */
+	pgsz_shift = max_t(unsigned int, MLX5_ADAPTER_PAGE_SHIFT, pgsz_shift);
+	return GENMASK(largest_pg_shift, pgsz_shift);
+}
+
+/*
+ * For mkc users, instead of a page_offset the command has a start_iova which
+ * specifies both the page_offset and the on-the-wire IOVA
+ */
+#define mlx5_umem_find_best_pgsz(umem, typ, log_pgsz_fld, pgsz_shift, iova)    \
+	ib_umem_find_best_pgsz(umem,                                           \
+			       __mlx5_log_page_size_to_bitmap(                 \
+				       __mlx5_bit_sz(typ, log_pgsz_fld),       \
+				       pgsz_shift),                            \
+			       iova)
+
 enum {
 	MLX5_IB_MMAP_OFFSET_START = 9,
 	MLX5_IB_MMAP_OFFSET_END = 255,
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 10f13acc88c9..660b721df64d 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -964,11 +964,13 @@ static struct mlx5_ib_mr *alloc_mr_from_cache(struct ib_pd *pd,
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct mlx5_cache_ent *ent;
 	struct mlx5_ib_mr *mr;
-	int page_shift;
+	unsigned int page_size;
 
-	mlx5_ib_cont_pages(umem, iova, MLX5_MKEY_PAGE_SHIFT_MASK, &page_shift);
-	ent = mr_cache_ent_from_order(dev, order_base_2(ib_umem_num_dma_blocks(
-						   umem, 1UL << page_shift)));
+	page_size = mlx5_umem_find_best_pgsz(umem, mkc, log_page_size, 0, iova);
+	if (WARN_ON(!page_size))
+		return ERR_PTR(-EINVAL);
+	ent = mr_cache_ent_from_order(
+		dev, order_base_2(ib_umem_num_dma_blocks(umem, page_size)));
 	if (!ent)
 		return ERR_PTR(-E2BIG);
 
@@ -990,7 +992,7 @@ static struct mlx5_ib_mr *alloc_mr_from_cache(struct ib_pd *pd,
 	mr->mmkey.iova = iova;
 	mr->mmkey.size = umem->length;
 	mr->mmkey.pd = to_mpd(pd)->pdn;
-	mr->page_shift = page_shift;
+	mr->page_shift = order_base_2(page_size);
 
 	return mr;
 }
@@ -1280,8 +1282,8 @@ static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
 				     int access_flags, bool populate)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
+	unsigned int page_size;
 	struct mlx5_ib_mr *mr;
-	int page_shift;
 	__be64 *pas;
 	void *mkc;
 	int inlen;
@@ -1289,22 +1291,23 @@ static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
 	int err;
 	bool pg_cap = !!(MLX5_CAP_GEN(dev->mdev, pg));
 
+	page_size =
+		mlx5_umem_find_best_pgsz(umem, mkc, log_page_size, 0, iova);
+	if (WARN_ON(!page_size))
+		return ERR_PTR(-EINVAL);
+
 	mr = ibmr ? to_mmr(ibmr) : kzalloc(sizeof(*mr), GFP_KERNEL);
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	mlx5_ib_cont_pages(umem, iova, MLX5_MKEY_PAGE_SHIFT_MASK, &page_shift);
-
-	mr->page_shift = page_shift;
 	mr->ibmr.pd = pd;
 	mr->access_flags = access_flags;
+	mr->page_shift = order_base_2(page_size);
 
 	inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
 	if (populate)
-		inlen +=
-			sizeof(*pas) *
-			roundup(ib_umem_num_dma_blocks(umem, 1UL << page_shift),
-				2);
+		inlen += sizeof(*pas) *
+			 roundup(ib_umem_num_dma_blocks(umem, page_size), 2);
 	in = kvzalloc(inlen, GFP_KERNEL);
 	if (!in) {
 		err = -ENOMEM;
@@ -1316,7 +1319,7 @@ static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
 			err = -EINVAL;
 			goto err_2;
 		}
-		mlx5_ib_populate_pas(umem, 1ULL << page_shift, pas,
+		mlx5_ib_populate_pas(umem, 1UL << mr->page_shift, pas,
 				     pg_cap ? MLX5_IB_MTT_PRESENT : 0);
 	}
 
@@ -1334,11 +1337,11 @@ static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
 	MLX5_SET64(mkc, mkc, len, umem->length);
 	MLX5_SET(mkc, mkc, bsf_octword_size, 0);
 	MLX5_SET(mkc, mkc, translations_octword_size,
-		 get_octo_len(iova, umem->length, page_shift));
-	MLX5_SET(mkc, mkc, log_page_size, page_shift);
+		 get_octo_len(iova, umem->length, mr->page_shift));
+	MLX5_SET(mkc, mkc, log_page_size, mr->page_shift);
 	if (populate) {
 		MLX5_SET(create_mkey_in, in, translations_octword_actual_size,
-			 get_octo_len(iova, umem->length, page_shift));
+			 get_octo_len(iova, umem->length, mr->page_shift));
 	}
 
 	err = mlx5_ib_create_mkey(dev, &mr->mmkey, in, inlen);
-- 
2.26.2

