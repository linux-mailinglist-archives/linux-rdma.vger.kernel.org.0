Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515582B34B1
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Nov 2020 12:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgKOLnc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Nov 2020 06:43:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:52554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgKOLnc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 15 Nov 2020 06:43:32 -0500
Received: from localhost (thunderhill.nvidia.com [216.228.112.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E98D22225B;
        Sun, 15 Nov 2020 11:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605440611;
        bh=/QlisB8UYI6fSBwj0gdr64/tLm7MKBvm4aG4sIV71dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eSrX/JpIqag4QjSQLuxUfyI/QmCtOSG9Inx303XXlvh8rOpSbQrmCcGkjsl0ntCDH
         k1u9mtDw21wgclZdLv6KtTyn81kt0GawyGcA46ijPteXDfumxreZffnGreCvTHxiw2
         KX8tWhCN1xoYI5yA8SepjDMf5yD44Kj9Q3xuxFf0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Eli Cohen <eli@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        linux-rdma@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>,
        Roland Dreier <roland@purestorage.com>
Subject: [PATCH rdma-next v1 5/7] RDMA/mlx5: mlx5_umem_find_best_quantized_pgoff() for CQ
Date:   Sun, 15 Nov 2020 13:43:09 +0200
Message-Id: <20201115114311.136250-6-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201115114311.136250-1-leon@kernel.org>
References: <20201115114311.136250-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

This fixes a bug where the page_offset was not being considered when
building a CQ. The HW specification says it 'must be zero', so use
a variant of mlx5_umem_find_best_quantized_pgoff() with a 0 pgoff_bitmask
to force this result.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/cq.c      | 48 ++++++++++++++++++++--------
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 10 ++++++
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 9ab93d730769..eb92cefffd77 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -707,8 +707,9 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 			  int *cqe_size, int *index, int *inlen)
 {
 	struct mlx5_ib_create_cq ucmd = {};
+	unsigned long page_size;
+	unsigned int page_offset_quantized;
 	size_t ucmdlen;
-	int page_shift;
 	__be64 *pas;
 	int ncont;
 	void *cqc;
@@ -741,17 +742,24 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 		return err;
 	}
 
+	page_size = mlx5_umem_find_best_cq_quantized_pgoff(
+		cq->buf.umem, cqc, log_page_size, MLX5_ADAPTER_PAGE_SHIFT,
+		page_offset, 64, &page_offset_quantized);
+	if (!page_size) {
+		err = -EINVAL;
+		goto err_umem;
+	}
+
 	err = mlx5_ib_db_map_user(context, udata, ucmd.db_addr, &cq->db);
 	if (err)
 		goto err_umem;
 
-	mlx5_ib_cont_pages(cq->buf.umem, ucmd.buf_addr, 0, &page_shift);
-	ncont = ib_umem_num_dma_blocks(cq->buf.umem, 1UL << page_shift);
+	ncont = ib_umem_num_dma_blocks(cq->buf.umem, page_size);
 	mlx5_ib_dbg(
 		dev,
-		"addr 0x%llx, size %u, npages %zu, page_shift %d, ncont %d\n",
+		"addr 0x%llx, size %u, npages %zu, page_size %lu, ncont %d\n",
 		ucmd.buf_addr, entries * ucmd.cqe_size,
-		ib_umem_num_pages(cq->buf.umem), page_shift, ncont);
+		ib_umem_num_pages(cq->buf.umem), page_size, ncont);
 
 	*inlen = MLX5_ST_SZ_BYTES(create_cq_in) +
 		 MLX5_FLD_SZ_BYTES(create_cq_in, pas[0]) * ncont;
@@ -762,11 +770,12 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	}
 
 	pas = (__be64 *)MLX5_ADDR_OF(create_cq_in, *cqb, pas);
-	mlx5_ib_populate_pas(cq->buf.umem, 1UL << page_shift, pas, 0);
+	mlx5_ib_populate_pas(cq->buf.umem, page_size, pas, 0);
 
 	cqc = MLX5_ADDR_OF(create_cq_in, *cqb, cq_context);
 	MLX5_SET(cqc, cqc, log_page_size,
-		 page_shift - MLX5_ADAPTER_PAGE_SHIFT);
+		 order_base_2(page_size) - MLX5_ADAPTER_PAGE_SHIFT);
+	MLX5_SET(cqc, cqc, page_offset, page_offset_quantized);
 
 	if (ucmd.flags & MLX5_IB_CREATE_CQ_FLAGS_UAR_PAGE_INDEX) {
 		*index = ucmd.uar_page_index;
@@ -1131,7 +1140,7 @@ int mlx5_ib_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period)
 
 static int resize_user(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq,
 		       int entries, struct ib_udata *udata,
-		       int *page_shift, int *cqe_size)
+		       int *cqe_size)
 {
 	struct mlx5_ib_resize_cq ucmd;
 	struct ib_umem *umem;
@@ -1156,8 +1165,6 @@ static int resize_user(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq,
 		return err;
 	}
 
-	mlx5_ib_cont_pages(umem, ucmd.buf_addr, 0, page_shift);
-
 	cq->resize_umem = umem;
 	*cqe_size = ucmd.cqe_size;
 
@@ -1250,7 +1257,8 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
 	int err;
 	int npas;
 	__be64 *pas;
-	int page_shift;
+	unsigned int page_offset_quantized = 0;
+	unsigned int page_shift;
 	int inlen;
 	int cqe_size;
 	unsigned long flags;
@@ -1277,11 +1285,22 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
 
 	mutex_lock(&cq->resize_mutex);
 	if (udata) {
-		err = resize_user(dev, cq, entries, udata, &page_shift,
-				  &cqe_size);
+		unsigned long page_size;
+
+		err = resize_user(dev, cq, entries, udata, &cqe_size);
 		if (err)
 			goto ex;
-		npas = ib_umem_num_dma_blocks(cq->resize_umem, 1UL << page_shift);
+
+		page_size = mlx5_umem_find_best_cq_quantized_pgoff(
+			cq->resize_umem, cqc, log_page_size,
+			MLX5_ADAPTER_PAGE_SHIFT, page_offset, 64,
+			&page_offset_quantized);
+		if (!page_size) {
+			err = -EINVAL;
+			goto ex_resize;
+		}
+		npas = ib_umem_num_dma_blocks(cq->resize_umem, page_size);
+		page_shift = order_base_2(page_size);
 	} else {
 		struct mlx5_frag_buf *frag_buf;
 
@@ -1320,6 +1339,7 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
 
 	MLX5_SET(cqc, cqc, log_page_size,
 		 page_shift - MLX5_ADAPTER_PAGE_SHIFT);
+	MLX5_SET(cqc, cqc, page_offset, page_offset_quantized);
 	MLX5_SET(cqc, cqc, cqe_sz,
 		 cqe_sz_to_mlx_sz(cqe_size,
 				  cq->private_flags &
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 555bc94d4786..3098a7e0d186 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -100,6 +100,16 @@ unsigned long __mlx5_umem_find_best_quantized_pgoff(
 		GENMASK(31, order_base_2(scale)), scale,                       \
 		page_offset_quantized)
 
+#define mlx5_umem_find_best_cq_quantized_pgoff(umem, typ, log_pgsz_fld,        \
+					       pgsz_shift, page_offset_fld,    \
+					       scale, page_offset_quantized)   \
+	__mlx5_umem_find_best_quantized_pgoff(                                 \
+		umem,                                                          \
+		__mlx5_log_page_size_to_bitmap(                                \
+			__mlx5_bit_sz(typ, log_pgsz_fld), pgsz_shift),         \
+		__mlx5_bit_sz(typ, page_offset_fld), 0, scale,                 \
+		page_offset_quantized)
+
 enum {
 	MLX5_IB_MMAP_OFFSET_START = 9,
 	MLX5_IB_MMAP_OFFSET_END = 255,
-- 
2.28.0

