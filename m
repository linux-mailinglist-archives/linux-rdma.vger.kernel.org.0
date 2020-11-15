Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3B72B34B4
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Nov 2020 12:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgKOLnn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Nov 2020 06:43:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:52656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgKOLnn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 15 Nov 2020 06:43:43 -0500
Received: from localhost (thunderhill.nvidia.com [216.228.112.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 858B52225B;
        Sun, 15 Nov 2020 11:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605440622;
        bh=ldAkxEjawhyTxHg82f/v9HQNzbQWTXN2lYWBYx+PwgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xF7kTjDyuvZUTw14HL9pXPYeeFcEY8uCa3P0EZb5QbWSH54PP+bxQFdDicjRpOYVA
         RYqzNiPGcQhDe7Cz3CBcrf8em7T6nxgtLHyW6U0EiUOBqRi8yCkzttRTvatT+n4cCM
         jE0XzRNqq2fHA0L1nxyFvdCV+L28bcckUIPUW9kc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next v1 6/7] RDMA/mlx5: Use ib_umem_find_best_pgsz() for devx
Date:   Sun, 15 Nov 2020 13:43:10 +0200
Message-Id: <20201115114311.136250-7-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201115114311.136250-1-leon@kernel.org>
References: <20201115114311.136250-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Since devx uses the new rdma_for_each_block() to fill the PAS it can also
use ib_umem_find_best_pgsz().

However, the umem constructionin devx is complicated, the umem must still
respect all the HW limits such as page_offset_quantized and the IOVA
alignment.

Since we don't know what the user intends to use the umem for we have to
compute and combine all the HW limits together. In practice this means
umems are unlikely to use larger page sizes.

There are users trying to mix umem's with mkeys so this makes them work
reliably, at least for an identity IOVA, by ensuring the IOVA matches the
selected page size.

Last user of mlx5_ib_get_buf_offset() so it can also be removed.

Fixes: aeae94579caf ("IB/mlx5: Add DEVX support for memory registration")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/devx.c    | 66 +++++++++++++++-------------
 drivers/infiniband/hw/mlx5/mem.c     | 55 -----------------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  5 ---
 3 files changed, 35 insertions(+), 91 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index f6839472b6fb..7c3eefba6197 100644
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
@@ -2078,46 +2075,55 @@ static int devx_umem_get(struct mlx5_ib_dev *dev, struct ib_ucontext *ucontext,
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
+	/*
+	 * We don't know what the user intends to use this umem for, but the HW
+	 * restrictions must be met. MR, doorbell records, QP, WQ and CQ all
+	 * have different requirements. Since we have no idea how to sort this
+	 * out, only support PAGE_SIZE with the expectation that userspace will
+	 * provide the necessary alignments inside the known PAGE_SIZE and that
+	 * FW will check everything.
+	 */
+	page_size = ib_umem_find_best_pgoff(
+		obj->umem, PAGE_SIZE,
+		__mlx5_page_offset_to_bitmask(__mlx5_bit_sz(umem, page_offset),
+					      0));
+	if (!page_size)
+		return -EINVAL;
+
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
@@ -2144,12 +2150,10 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_UMEM_REG)(
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
diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index ad9830eeb4b6..f8ec5156d8e9 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -36,61 +36,6 @@
 #include "mlx5_ib.h"
 #include <linux/jiffies.h>
 
-/* @umem: umem object to scan
- * @addr: ib virtual address requested by the user
- * @max_page_shift: high limit for page_shift - 0 means no limit
- * @shift: page shift for the compound pages found in the region
- */
-void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
-			unsigned long max_page_shift, int *shift)
-{
-	unsigned long tmp;
-	unsigned long m;
-	u64 base = ~0, p = 0;
-	u64 len, pfn;
-	int i = 0;
-	struct scatterlist *sg;
-	int entry;
-
-	if (umem->is_odp) {
-		struct ib_umem_odp *odp = to_ib_umem_odp(umem);
-
-		*shift = odp->page_shift;
-		return;
-	}
-
-	addr = addr >> PAGE_SHIFT;
-	tmp = (unsigned long)addr;
-	m = find_first_bit(&tmp, BITS_PER_LONG);
-	if (max_page_shift)
-		m = min_t(unsigned long, max_page_shift - PAGE_SHIFT, m);
-
-	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, entry) {
-		len = sg_dma_len(sg) >> PAGE_SHIFT;
-		pfn = sg_dma_address(sg) >> PAGE_SHIFT;
-		if (base + p != pfn) {
-			/* If either the offset or the new
-			 * base are unaligned update m
-			 */
-			tmp = (unsigned long)(pfn | p);
-			if (!IS_ALIGNED(tmp, 1 << m))
-				m = find_first_bit(&tmp, BITS_PER_LONG);
-
-			base = pfn;
-			p = 0;
-		}
-
-		p += len;
-		i += len;
-	}
-
-	if (i)
-		m = min_t(unsigned long, ilog2(roundup_pow_of_two(i)), m);
-	else
-		m  = 0;
-	*shift = PAGE_SHIFT + m;
-}
-
 /*
  * Fill in a physical address list. ib_umem_num_dma_blocks() entries will be
  * filled in the pas array.
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 3098a7e0d186..718e59fce006 100644
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
@@ -1296,9 +1294,6 @@ int mlx5_query_mad_ifc_port(struct ib_device *ibdev, u8 port,
 			    struct ib_port_attr *props);
 int mlx5_ib_query_port(struct ib_device *ibdev, u8 port,
 		       struct ib_port_attr *props);
-void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
-			unsigned long max_page_shift,
-			int *shift);
 void mlx5_ib_populate_pas(struct ib_umem *umem, size_t page_size, __be64 *pas,
 			  u64 access_flags);
 void mlx5_ib_copy_pas(u64 *old, u64 *new, int step, int num);
-- 
2.28.0

