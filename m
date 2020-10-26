Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B19298DC9
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 14:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769848AbgJZN0w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 09:26:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1769503AbgJZN0v (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Oct 2020 09:26:51 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A5C1207DE;
        Mon, 26 Oct 2020 13:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603718811;
        bh=w6UUOF1OaZXRYUKQQqrNH3xz32bhRWvUT9HvT80RtV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=imNRBHqtE8OO7HxfwJ9InCKY8caG6wYDhHhOrZQnAjhHqogLFmvHNcWuYKVbgjV/N
         vBk/nST4b0EyX6j6sYzVkGJoo//qWtYGjY/kjkYRgPKOsuIdudw15+RVfqS1Ob5fh0
         bzcsUs8cI1gZVxo12Yb7Pc7RLKERF+mLiQZ+cX1I=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 4/6] RDMA/mlx5: Use mlx5_umem_find_best_quantized_pgoff() for QP
Date:   Mon, 26 Oct 2020 15:26:33 +0200
Message-Id: <20201026132635.1337663-5-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026132635.1337663-1-leon@kernel.org>
References: <20201026132635.1337663-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Last user of mlx5_ib_get_buf_offset() so it can also be removed.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mem.c     | 21 --------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 -
 drivers/infiniband/hw/mlx5/qp.c      | 71 +++++++++-------------------
 3 files changed, 23 insertions(+), 70 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index 9f8f9e55bceb..e38f9f2bf181 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -152,27 +152,6 @@ unsigned long __mlx5_umem_find_best_quantized_pgoff(
 	return page_size;
 }
 
-int mlx5_ib_get_buf_offset(u64 addr, int page_shift, u32 *offset)
-{
-	u64 page_size;
-	u64 page_mask;
-	u64 off_size;
-	u64 off_mask;
-	u64 buf_off;
-
-	page_size = (u64)1 << page_shift;
-	page_mask = page_size - 1;
-	buf_off = addr & page_mask;
-	off_size = page_size >> 6;
-	off_mask = off_size - 1;
-
-	if (buf_off & off_mask)
-		return -EINVAL;
-
-	*offset = buf_off >> ilog2(off_size);
-	return 0;
-}
-
 #define WR_ID_BF 0xBF
 #define WR_ID_END 0xBAD
 #define TEST_WC_NUM_WQES 255
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 769a0b0738cd..9777103af575 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1273,7 +1273,6 @@ int mlx5_ib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
 			size_t *out_mad_size, u16 *out_mad_pkey_index);
 int mlx5_ib_alloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata);
 int mlx5_ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata);
-int mlx5_ib_get_buf_offset(u64 addr, int page_shift, u32 *offset);
 int mlx5_query_ext_port_caps(struct mlx5_ib_dev *dev, u8 port);
 int mlx5_query_mad_ifc_smp_attr_node_info(struct ib_device *ibdev,
 					  struct ib_smp *out_mad);
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 143fd5eae304..bedba14c1bfb 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -778,39 +778,6 @@ int bfregn_to_uar_index(struct mlx5_ib_dev *dev,
 	return bfregi->sys_pages[index_of_sys_page] + offset;
 }
 
-static int mlx5_ib_umem_get(struct mlx5_ib_dev *dev, struct ib_udata *udata,
-			    unsigned long addr, size_t size,
-			    struct ib_umem **umem, int *page_shift,
-			    u32 *offset)
-{
-	int err;
-
-	*umem = ib_umem_get(&dev->ib_dev, addr, size, 0);
-	if (IS_ERR(*umem)) {
-		mlx5_ib_dbg(dev, "umem_get failed\n");
-		return PTR_ERR(*umem);
-	}
-
-	mlx5_ib_cont_pages(*umem, addr, 0, page_shift);
-
-	err = mlx5_ib_get_buf_offset(addr, *page_shift, offset);
-	if (err) {
-		mlx5_ib_warn(dev, "bad offset\n");
-		goto err_umem;
-	}
-
-	mlx5_ib_dbg(dev, "addr 0x%lx, size %zu, npages %zu, page_shift %d, offset %d\n",
-		    addr, size, ib_umem_num_pages(*umem), *page_shift, *offset);
-
-	return 0;
-
-err_umem:
-	ib_umem_release(*umem);
-	*umem = NULL;
-
-	return err;
-}
-
 static void destroy_user_rq(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			    struct mlx5_ib_rwq *rwq, struct ib_udata *udata)
 {
@@ -897,9 +864,9 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 {
 	struct mlx5_ib_ucontext *context;
 	struct mlx5_ib_ubuffer *ubuffer = &base->ubuffer;
-	int page_shift = 0;
+	unsigned int page_offset_quantized = 0;
+	unsigned long page_size = 0;
 	int uar_index = 0;
-	u32 offset = 0;
 	int bfregn;
 	int ncont = 0;
 	__be64 *pas;
@@ -950,12 +917,21 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 
 	if (ucmd->buf_addr && ubuffer->buf_size) {
 		ubuffer->buf_addr = ucmd->buf_addr;
-		err = mlx5_ib_umem_get(dev, udata, ubuffer->buf_addr,
-				       ubuffer->buf_size, &ubuffer->umem,
-				       &page_shift, &offset);
-		if (err)
+		ubuffer->umem = ib_umem_get(&dev->ib_dev, ubuffer->buf_addr,
+					    ubuffer->buf_size, 0);
+		if (IS_ERR(ubuffer->umem)) {
+			err = PTR_ERR(ubuffer->umem);
 			goto err_bfreg;
-		ncont = ib_umem_num_dma_blocks(ubuffer->umem, 1UL << page_shift);
+		}
+		page_size = mlx5_umem_find_best_quantized_pgoff(
+			ubuffer->umem, qpc, log_page_size,
+			MLX5_ADAPTER_PAGE_SHIFT, page_offset, 64,
+			&page_offset_quantized);
+		if (!page_size) {
+			err = -EINVAL;
+			goto err_umem;
+		}
+		ncont = ib_umem_num_dma_blocks(ubuffer->umem, page_size);
 	} else {
 		ubuffer->umem = NULL;
 	}
@@ -970,15 +946,14 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 
 	uid = (attr->qp_type != IB_QPT_XRC_INI) ? to_mpd(pd)->uid : 0;
 	MLX5_SET(create_qp_in, *in, uid, uid);
-	pas = (__be64 *)MLX5_ADDR_OF(create_qp_in, *in, pas);
-	if (ubuffer->umem)
-		mlx5_ib_populate_pas(ubuffer->umem, 1UL << page_shift, pas, 0);
-
 	qpc = MLX5_ADDR_OF(create_qp_in, *in, qpc);
-
-	MLX5_SET(qpc, qpc, log_page_size, page_shift - MLX5_ADAPTER_PAGE_SHIFT);
-	MLX5_SET(qpc, qpc, page_offset, offset);
-
+	pas = (__be64 *)MLX5_ADDR_OF(create_qp_in, *in, pas);
+	if (ubuffer->umem) {
+		mlx5_ib_populate_pas(ubuffer->umem, page_size, pas, 0);
+		MLX5_SET(qpc, qpc, log_page_size,
+			 order_base_2(page_size) - MLX5_ADAPTER_PAGE_SHIFT);
+		MLX5_SET(qpc, qpc, page_offset, page_offset_quantized);
+	}
 	MLX5_SET(qpc, qpc, uar_page, uar_index);
 	if (bfregn != MLX5_IB_INVALID_BFREG)
 		resp->bfreg_index = adjust_bfregn(dev, &context->bfregi, bfregn);
-- 
2.26.2

