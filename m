Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FCD298DC7
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 14:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769261AbgJZN0q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 09:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1768881AbgJZN0p (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Oct 2020 09:26:45 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B49BF207DE;
        Mon, 26 Oct 2020 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603718804;
        bh=bPiyibOz5M06YKOOy9m7gt3TOrufb6nfq7IaKve7XFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QQ3hFTekegPBp+LNHhtD67SEunCgpfgmo83fR9+2ZcSgfeE3nCprjGV8aYeQ5Y4bz
         1ZWK43GguPOqmiGFHhpCCGTh9Wv/dlrX9EzaOnwa3xGwnbbzNsrDm7exAmxJQ6aAZj
         VtaJeKs0BtObvifst84fvK7woKidyo1WfTX0qCzI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 1/6] RDMA/mlx5: Use ib_umem_find_best_pgsz() for devx
Date:   Mon, 26 Oct 2020 15:26:30 +0200
Message-Id: <20201026132635.1337663-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026132635.1337663-1-leon@kernel.org>
References: <20201026132635.1337663-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Since devx uses the new rdma_for_each_block() to fill the PAS it can also
use ib_umem_find_best_pgsz(). However devx does not compute a PAS list
with an IOVA, it is computing a PAS with a page_offset to the DMA address
that requires a slightly different calculation.

Introduce ib_umem_find_best_pgoff() to do this math and a wrapper to make
it easier to understand how the math relates directly to the mailbox
format.

This will allow umems to use large pages in a wider range of cases.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/devx.c    | 56 +++++++++++++---------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 26 ++++++++++++-
 include/rdma/ib_umem.h               | 42 +++++++++++++++++++++
 3 files changed, 91 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 611ce21157de..274f04b39dce 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -93,8 +93,6 @@ struct devx_async_event_file {
 struct devx_umem {
 	struct mlx5_core_dev		*mdev;
 	struct ib_umem			*umem;
-	u32				page_offset;
-	int				page_shift;
 	u32				dinlen;
 	u32				dinbox[MLX5_ST_SZ_DW(general_obj_in_cmd_hdr)];
 };
@@ -2057,7 +2055,6 @@ static int devx_umem_get(struct mlx5_ib_dev *dev, struct ib_ucontext *ucontext,
 	size_t size;
 	u32 access;
 	int err;
-	u32 page_mask;
 
 	if (uverbs_copy_from(&addr, attrs, MLX5_IB_ATTR_DEVX_UMEM_REG_ADDR) ||
 	    uverbs_copy_from(&size, attrs, MLX5_IB_ATTR_DEVX_UMEM_REG_LEN))
@@ -2078,46 +2075,45 @@ static int devx_umem_get(struct mlx5_ib_dev *dev, struct ib_ucontext *ucontext,
 	obj->umem = ib_umem_get(&dev->ib_dev, addr, size, access);
 	if (IS_ERR(obj->umem))
 		return PTR_ERR(obj->umem);
-
-	mlx5_ib_cont_pages(obj->umem, obj->umem->address,
-			   MLX5_MKEY_PAGE_SHIFT_MASK, &obj->page_shift);
-	page_mask = (1 << obj->page_shift) - 1;
-	obj->page_offset = obj->umem->address & page_mask;
-
 	return 0;
 }
 
-static int devx_umem_reg_cmd_alloc(struct uverbs_attr_bundle *attrs,
+static int devx_umem_reg_cmd_alloc(struct mlx5_ib_dev *dev,
+				   struct uverbs_attr_bundle *attrs,
 				   struct devx_umem *obj,
 				   struct devx_umem_reg_cmd *cmd)
 {
-	cmd->inlen =
-		MLX5_ST_SZ_BYTES(create_umem_in) +
-		(MLX5_ST_SZ_BYTES(mtt) *
-		 ib_umem_num_dma_blocks(obj->umem, 1UL << obj->page_shift));
-	cmd->in = uverbs_zalloc(attrs, cmd->inlen);
-	return PTR_ERR_OR_ZERO(cmd->in);
-}
-
-static void devx_umem_reg_cmd_build(struct mlx5_ib_dev *dev,
-				    struct devx_umem *obj,
-				    struct devx_umem_reg_cmd *cmd)
-{
-	void *umem;
+	unsigned int page_size;
 	__be64 *mtt;
+	void *umem;
+
+	page_size =
+		mlx5_umem_find_best_pgoff(obj->umem, umem, log_page_size,
+					  MLX5_ADAPTER_PAGE_SHIFT, page_offset);
+	if (!page_size)
+		return -EINVAL;
+	cmd->inlen = MLX5_ST_SZ_BYTES(create_umem_in) +
+		     (MLX5_ST_SZ_BYTES(mtt) *
+		      ib_umem_num_dma_blocks(obj->umem, page_size));
+	cmd->in = uverbs_zalloc(attrs, cmd->inlen);
+	if (!cmd->in)
+		return PTR_ERR(cmd->in);
 
 	umem = MLX5_ADDR_OF(create_umem_in, cmd->in, umem);
 	mtt = (__be64 *)MLX5_ADDR_OF(umem, umem, mtt);
 
 	MLX5_SET(create_umem_in, cmd->in, opcode, MLX5_CMD_OP_CREATE_UMEM);
 	MLX5_SET64(umem, umem, num_of_mtt,
-		   ib_umem_num_dma_blocks(obj->umem, 1UL << obj->page_shift));
-	MLX5_SET(umem, umem, log_page_size, obj->page_shift -
-					    MLX5_ADAPTER_PAGE_SHIFT);
-	MLX5_SET(umem, umem, page_offset, obj->page_offset);
-	mlx5_ib_populate_pas(obj->umem, 1UL << obj->page_shift, mtt,
+		   ib_umem_num_dma_blocks(obj->umem, page_size));
+	MLX5_SET(umem, umem, log_page_size,
+		 order_base_2(page_size) - MLX5_ADAPTER_PAGE_SHIFT);
+	MLX5_SET(umem, umem, page_offset,
+		 ib_umem_dma_offset(obj->umem, page_size));
+
+	mlx5_ib_populate_pas(obj->umem, page_size, mtt,
 			     (obj->umem->writable ? MLX5_IB_MTT_WRITE : 0) |
 				     MLX5_IB_MTT_READ);
+	return 0;
 }
 
 static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_UMEM_REG)(
@@ -2144,12 +2140,10 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_UMEM_REG)(
 	if (err)
 		goto err_obj_free;
 
-	err = devx_umem_reg_cmd_alloc(attrs, obj, &cmd);
+	err = devx_umem_reg_cmd_alloc(dev, attrs, obj, &cmd);
 	if (err)
 		goto err_umem_release;
 
-	devx_umem_reg_cmd_build(dev, obj, &cmd);
-
 	MLX5_SET(create_umem_in, cmd.in, uid, c->devx_uid);
 	err = mlx5_cmd_exec(dev->mdev, cmd.in, cmd.inlen, cmd.out,
 			    sizeof(cmd.out));
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index bb44080170be..a31daf7253be 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -40,8 +40,6 @@
 #define MLX5_IB_DEFAULT_UIDX 0xffffff
 #define MLX5_USER_ASSIGNED_UIDX_MASK __mlx5_mask(qpc, user_index)
 
-#define MLX5_MKEY_PAGE_SHIFT_MASK __mlx5_mask(mkc, log_page_size)
-
 static __always_inline unsigned long
 __mlx5_log_page_size_to_bitmap(unsigned int log_pgsz_bits,
 			       unsigned int pgsz_shift)
@@ -69,6 +67,30 @@ __mlx5_log_page_size_to_bitmap(unsigned int log_pgsz_bits,
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
+ * This computes a the page_size and non-quantized page_offset to fit within a
+ * prm structure.
+ */
+#define mlx5_umem_find_best_pgoff(umem, typ, log_pgsz_fld, pgsz_shift,         \
+				  page_offset_fld)                             \
+	ib_umem_find_best_pgoff(                                               \
+		umem,                                                          \
+		__mlx5_log_page_size_to_bitmap(                                \
+			__mlx5_bit_sz(typ, log_pgsz_fld), pgsz_shift),         \
+		__mlx5_page_offset_to_bitmask(                                 \
+			__mlx5_bit_sz(typ, page_offset_fld), 0))
+
 enum {
 	MLX5_IB_MMAP_OFFSET_START = 9,
 	MLX5_IB_MMAP_OFFSET_END = 255,
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
2.26.2

