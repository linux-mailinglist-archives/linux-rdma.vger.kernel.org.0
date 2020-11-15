Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432DA2B34B6
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Nov 2020 12:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgKOLnX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Nov 2020 06:43:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:52486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgKOLnW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 15 Nov 2020 06:43:22 -0500
Received: from localhost (thunderhill.nvidia.com [216.228.112.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49C20222B8;
        Sun, 15 Nov 2020 11:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605440601;
        bh=mil2Qv6JueKGymLGSTjpcWJ2e1NPdEt3XOGNvxyBbIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FCiL4DLjnL135xspL2rfkbXUdYS4oABR2xAbUXD8jZTzc3Z/L8cwjpjyQMNx2xNff
         H5kQR+5hkjlVs5Dht0U7tEDXA8Jo8O7V/SSLHbyX/cFrVQcKaCfkSFMkVV8Wf4ieug
         Wi8kz08ZOs+QKWxeDz7+qbmvvnxsjg7Rx/Im9YGQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 1/7] RDMA/mlx5: Use ib_umem_find_best_pgoff() for SRQ
Date:   Sun, 15 Nov 2020 13:43:05 +0200
Message-Id: <20201115114311.136250-2-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201115114311.136250-1-leon@kernel.org>
References: <20201115114311.136250-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

SRQ uses a quantized and scaled page_offset, which is another variation of
ib_umem_find_best_pgsz(). Add mlx5_umem_find_best_quantized_pgoff() to
perform this calculation for each mailbox. A macro shows how the
calculation is directly connected to the mailbox format.

This new routine replaces the limited mlx5_ib_cont_pages() and
mlx5_ib_get_buf_offset() pairing which would reject valid configurations
rather than adjust the page_size to make it work.

In turn this is much more aggressive about choosing large page sizes for
these objects and when THP is enabled it will now often find a single page
solution.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mem.c     | 45 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 31 +++++++++++++++++++
 drivers/infiniband/hw/mlx5/srq.c     | 20 ++++++-------
 include/rdma/ib_umem.h               | 42 ++++++++++++++++++++++++++
 4 files changed, 128 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index 92e7621ec858..fd9778113d26 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -107,6 +107,51 @@ void mlx5_ib_populate_pas(struct ib_umem *umem, size_t page_size, __be64 *pas,
 	}
 }
 
+/*
+ * Compute the page shift and page_offset for mailboxes that use a quantized
+ * page_offset. The granulatity of the page offset scales according to page
+ * size.
+ */
+unsigned long __mlx5_umem_find_best_quantized_pgoff(
+	struct ib_umem *umem, unsigned long pgsz_bitmap,
+	unsigned int page_offset_bits, u64 pgoff_bitmask, unsigned int scale,
+	unsigned int *page_offset_quantized)
+{
+	const u64 page_offset_mask = (1 << page_offset_bits) - 1;
+	unsigned long page_size;
+	u64 page_offset;
+
+	page_size = ib_umem_find_best_pgoff(umem, pgsz_bitmap, pgoff_bitmask);
+	if (!page_size)
+		return 0;
+
+	/*
+	 * page size is the largest possible page size.
+	 *
+	 * Reduce the page_size, and thus the page_offset and quanta, until the
+	 * page_offset fits into the mailbox field. Once page_size < scale this
+	 * loop is guaranteed to terminate.
+	 */
+	page_offset = ib_umem_dma_offset(umem, page_size);
+	while (page_offset & ~(u64)(page_offset_mask * (page_size / scale))) {
+		page_size /= 2;
+		page_offset = ib_umem_dma_offset(umem, page_size);
+	}
+
+	/*
+	 * The address is not aligned, or otherwise cannot be represented by the
+	 * page_offset.
+	 */
+	if (!(pgsz_bitmap & page_size))
+		return 0;
+
+	*page_offset_quantized =
+		(unsigned long)page_offset / (page_size / scale);
+	if (WARN_ON(*page_offset_quantized > page_offset_mask))
+		return 0;
+	return page_size;
+}
+
 int mlx5_ib_get_buf_offset(u64 addr, int page_shift, u32 *offset)
 {
 	u64 page_size;
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index bb44080170be..2f08a5b4a438 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -69,6 +69,37 @@ __mlx5_log_page_size_to_bitmap(unsigned int log_pgsz_bits,
 				       pgsz_shift),                            \
 			       iova)
 
+static __always_inline unsigned long
+__mlx5_page_offset_to_bitmask(unsigned int page_offset_bits,
+			      unsigned int offset_shift)
+{
+	unsigned int largest_offset_shift =
+		min_t(unsigned long, page_offset_bits - 1 + offset_shift,
+		      BITS_PER_LONG - 1);
+
+	return GENMASK(largest_offset_shift, offset_shift);
+}
+
+/*
+ * QP/CQ/WQ/etc type commands take a page offset that satisifies:
+ *   page_offset_quantized * (page_size/scale) = page_offset
+ * Which restricts allowed page sizes to ones that satisify the above.
+ */
+unsigned long __mlx5_umem_find_best_quantized_pgoff(
+	struct ib_umem *umem, unsigned long pgsz_bitmap,
+	unsigned int page_offset_bits, u64 pgoff_bitmask, unsigned int scale,
+	unsigned int *page_offset_quantized);
+#define mlx5_umem_find_best_quantized_pgoff(umem, typ, log_pgsz_fld,           \
+					    pgsz_shift, page_offset_fld,       \
+					    scale, page_offset_quantized)      \
+	__mlx5_umem_find_best_quantized_pgoff(                                 \
+		umem,                                                          \
+		__mlx5_log_page_size_to_bitmap(                                \
+			__mlx5_bit_sz(typ, log_pgsz_fld), pgsz_shift),         \
+		__mlx5_bit_sz(typ, page_offset_fld),                           \
+		GENMASK(31, order_base_2(scale)), scale,                       \
+		page_offset_quantized)
+
 enum {
 	MLX5_IB_MMAP_OFFSET_START = 9,
 	MLX5_IB_MMAP_OFFSET_END = 255,
diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index cb5ad045da9a..7dfdc9e54866 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -51,8 +51,8 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 		udata, struct mlx5_ib_ucontext, ibucontext);
 	size_t ucmdlen;
 	int err;
-	int page_shift;
-	u32 offset;
+	unsigned int page_offset_quantized;
+	unsigned int page_size;
 	u32 uidx = MLX5_IB_DEFAULT_UIDX;
 
 	ucmdlen = min(udata->inlen, sizeof(ucmd));
@@ -85,22 +85,22 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 		return err;
 	}
 
-	mlx5_ib_cont_pages(srq->umem, ucmd.buf_addr, 0, &page_shift);
-	err = mlx5_ib_get_buf_offset(ucmd.buf_addr, page_shift,
-				     &offset);
-	if (err) {
+	page_size = mlx5_umem_find_best_quantized_pgoff(
+		srq->umem, srqc, log_page_size, MLX5_ADAPTER_PAGE_SHIFT,
+		page_offset, 64, &page_offset_quantized);
+	if (!page_size) {
 		mlx5_ib_warn(dev, "bad offset\n");
 		goto err_umem;
 	}
 
-	in->pas = kvcalloc(ib_umem_num_dma_blocks(srq->umem, 1UL << page_shift),
+	in->pas = kvcalloc(ib_umem_num_dma_blocks(srq->umem, page_size),
 			   sizeof(*in->pas), GFP_KERNEL);
 	if (!in->pas) {
 		err = -ENOMEM;
 		goto err_umem;
 	}
 
-	mlx5_ib_populate_pas(srq->umem, 1UL << page_shift, in->pas, 0);
+	mlx5_ib_populate_pas(srq->umem, page_size, in->pas, 0);
 
 	err = mlx5_ib_db_map_user(ucontext, udata, ucmd.db_addr, &srq->db);
 	if (err) {
@@ -108,8 +108,8 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 		goto err_in;
 	}
 
-	in->log_page_size = page_shift - MLX5_ADAPTER_PAGE_SHIFT;
-	in->page_offset = offset;
+	in->log_page_size = order_base_2(page_size) - MLX5_ADAPTER_PAGE_SHIFT;
+	in->page_offset = page_offset_quantized;
 	in->uid = (in->type != IB_SRQT_XRC) ?  to_mpd(pd)->uid : 0;
 	if (MLX5_CAP_GEN(dev->mdev, cqe_version) == MLX5_CQE_VERSION_V1 &&
 	    in->type != IB_SRQT_BASIC)
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 70597508c765..7752211c9638 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -34,6 +34,13 @@ static inline int ib_umem_offset(struct ib_umem *umem)
 	return umem->address & ~PAGE_MASK;
 }
 
+static inline unsigned long ib_umem_dma_offset(struct ib_umem *umem,
+					       unsigned long pgsz)
+{
+	return (sg_dma_address(umem->sg_head.sgl) + ib_umem_offset(umem)) &
+	       (pgsz - 1);
+}
+
 static inline size_t ib_umem_num_dma_blocks(struct ib_umem *umem,
 					    unsigned long pgsz)
 {
@@ -79,6 +86,35 @@ int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 				     unsigned long pgsz_bitmap,
 				     unsigned long virt);
+/**
+ * ib_umem_find_best_pgoff - Find best HW page size
+ *
+ * @umem: umem struct
+ * @pgsz_bitmap bitmap of HW supported page sizes
+ * @pgoff_bitmask: Mask of bits that can be represented with an offset
+ *
+ * This is very similar to ib_umem_find_best_pgsz() except instead of accepting
+ * an IOVA it accepts a bitmask specifying what address bits can be represented
+ * with a page offset.
+ *
+ * For instance if the HW has multiple page sizes, requires 64 byte alignemnt,
+ * and can support aligned offsets up to 4032 then pgoff_bitmask would be
+ * "111111000000".
+ *
+ * If the pgoff_bitmask requires either alignment in the low bit or an
+ * unavailable page size for the high bits, this function returns 0.
+ */
+static inline unsigned long ib_umem_find_best_pgoff(struct ib_umem *umem,
+						    unsigned long pgsz_bitmap,
+						    u64 pgoff_bitmask)
+{
+	struct scatterlist *sg = umem->sg_head.sgl;
+	dma_addr_t dma_addr;
+
+	dma_addr = sg_dma_address(sg) + (umem->address & ~PAGE_MASK);
+	return ib_umem_find_best_pgsz(umem, pgsz_bitmap,
+				      dma_addr & pgoff_bitmask);
+}
 
 #else /* CONFIG_INFINIBAND_USER_MEM */
 
@@ -101,6 +137,12 @@ static inline unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 {
 	return 0;
 }
+static inline unsigned long ib_umem_find_best_pgoff(struct ib_umem *umem,
+						    unsigned long pgsz_bitmap,
+						    u64 pgoff_bitmask)
+{
+	return 0;
+}
 
 #endif /* CONFIG_INFINIBAND_USER_MEM */
 
-- 
2.28.0

