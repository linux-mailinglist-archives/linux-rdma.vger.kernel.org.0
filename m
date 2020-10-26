Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D397298DCC
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 14:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770006AbgJZN1C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 09:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1769503AbgJZN1C (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Oct 2020 09:27:02 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBA0C207DE;
        Mon, 26 Oct 2020 13:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603718821;
        bh=/TJXj1GtnOYhjz+TmHN8I+SmgYv1goE27UbeiKP55Oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dqAmD95gTc9XN9gw/K4ejZ99Vs63YVXnXDOFmhuCSSRrPcsiGiM2J4jJtmCC/Pz//
         owUiTS4SaE/T/vjZ/M3Nk0WOvqtGD+phkgSqfC6x3CrSva+Y1JYbYzTznlGT9z/s46
         EqZVVDElrZrQb8AXySbEKrtQYYp/YJCYRbExkUhs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org,
        "majd@mellanox.com" <majd@mellanox.com>,
        Matan Barak <matanb@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next 3/6] RDMA/mlx5: Use mlx5_umem_find_best_quantized_pgoff() for WQ
Date:   Mon, 26 Oct 2020 15:26:32 +0200
Message-Id: <20201026132635.1337663-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026132635.1337663-1-leon@kernel.org>
References: <20201026132635.1337663-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

This fixes a subtle bug, the WQ mailbox has only 5 bits to describe the
page_offset, while mlx5_ib_get_buf_offset() is hard wired to only work
with 6 bit page_offsets.

Thus it did not properly reject badly aligned buffers.

YISHAI: WTF? Why does this PRM command only have 5 bits? We must force 4k
alignment for WQ umems in the userspace?

Fixes: 79b20a6c3014 ("IB/mlx5: Add receive Work Queue verbs")
Fixes: 0fb2ed66a14c ("IB/mlx5: Add create and destroy functionality for Raw Packet QP")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 53 +++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 042177f33252..143fd5eae304 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -833,7 +833,7 @@ static int create_user_rq(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 {
 	struct mlx5_ib_ucontext *ucontext = rdma_udata_to_drv_context(
 		udata, struct mlx5_ib_ucontext, ibucontext);
-	int page_shift = 0;
+	unsigned long page_size = 0;
 	u32 offset = 0;
 	int err;
 
@@ -847,24 +847,25 @@ static int create_user_rq(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		return err;
 	}
 
-	mlx5_ib_cont_pages(rwq->umem, ucmd->buf_addr, 0, &page_shift);
-	err = mlx5_ib_get_buf_offset(ucmd->buf_addr, page_shift,
-				     &rwq->rq_page_offset);
-	if (err) {
+	page_size = mlx5_umem_find_best_quantized_pgoff(
+		rwq->umem, wq, log_wq_pg_sz, MLX5_ADAPTER_PAGE_SHIFT,
+		page_offset, 64, &rwq->rq_page_offset);
+	if (!page_size) {
 		mlx5_ib_warn(dev, "bad offset\n");
+		err = -EINVAL;
 		goto err_umem;
 	}
 
-	rwq->rq_num_pas = ib_umem_num_dma_blocks(rwq->umem, 1UL << page_shift);
-	rwq->page_shift = page_shift;
-	rwq->log_page_size =  page_shift - MLX5_ADAPTER_PAGE_SHIFT;
+	rwq->rq_num_pas = ib_umem_num_dma_blocks(rwq->umem, page_size);
+	rwq->page_shift = order_base_2(page_size);
+	rwq->log_page_size =  rwq->page_shift - MLX5_ADAPTER_PAGE_SHIFT;
 	rwq->wq_sig = !!(ucmd->flags & MLX5_WQ_FLAG_SIGNATURE);
 
 	mlx5_ib_dbg(
 		dev,
-		"addr 0x%llx, size %zd, npages %zu, page_shift %d, ncont %d, offset %d\n",
+		"addr 0x%llx, size %zd, npages %zu, page_size %ld, ncont %d, offset %d\n",
 		(unsigned long long)ucmd->buf_addr, rwq->buf_size,
-		ib_umem_num_pages(rwq->umem), page_shift, rwq->rq_num_pas,
+		ib_umem_num_pages(rwq->umem), page_size, rwq->rq_num_pas,
 		offset);
 
 	err = mlx5_ib_db_map_user(ucontext, udata, ucmd->db_addr, &rwq->db);
@@ -1209,17 +1210,24 @@ static int create_raw_packet_qp_sq(struct mlx5_ib_dev *dev,
 	void *wq;
 	int inlen;
 	int err;
-	int page_shift = 0;
-	u32 offset = 0;
-
-	err = mlx5_ib_umem_get(dev, udata, ubuffer->buf_addr, ubuffer->buf_size,
-			       &sq->ubuffer.umem, &page_shift, &offset);
-	if (err)
-		return err;
+	unsigned int page_offset_quantized;
+	unsigned long page_size;
+
+	sq->ubuffer.umem = ib_umem_get(&dev->ib_dev, ubuffer->buf_addr,
+				       ubuffer->buf_size, 0);
+	if (IS_ERR(sq->ubuffer.umem))
+		return PTR_ERR(sq->ubuffer.umem);
+	page_size = mlx5_umem_find_best_quantized_pgoff(
+		ubuffer->umem, wq, log_wq_pg_sz, MLX5_ADAPTER_PAGE_SHIFT,
+		page_offset, 64, &page_offset_quantized);
+	if (!page_size) {
+		err = -EINVAL;
+		goto err_umem;
+	}
 
 	inlen = MLX5_ST_SZ_BYTES(create_sq_in) +
-		sizeof(u64) * ib_umem_num_dma_blocks(sq->ubuffer.umem,
-						     1UL << page_shift);
+		sizeof(u64) *
+			ib_umem_num_dma_blocks(sq->ubuffer.umem, page_size);
 	in = kvzalloc(inlen, GFP_KERNEL);
 	if (!in) {
 		err = -ENOMEM;
@@ -1247,11 +1255,12 @@ static int create_raw_packet_qp_sq(struct mlx5_ib_dev *dev,
 	MLX5_SET64(wq, wq, dbr_addr, MLX5_GET64(qpc, qpc, dbr_addr));
 	MLX5_SET(wq, wq, log_wq_stride, ilog2(MLX5_SEND_WQE_BB));
 	MLX5_SET(wq, wq, log_wq_sz, MLX5_GET(qpc, qpc, log_sq_size));
-	MLX5_SET(wq, wq, log_wq_pg_sz,  page_shift - MLX5_ADAPTER_PAGE_SHIFT);
-	MLX5_SET(wq, wq, page_offset, offset);
+	MLX5_SET(wq, wq, log_wq_pg_sz,
+		 order_base_2(page_size) - MLX5_ADAPTER_PAGE_SHIFT);
+	MLX5_SET(wq, wq, page_offset, page_offset_quantized);
 
 	pas = (__be64 *)MLX5_ADDR_OF(wq, wq, pas);
-	mlx5_ib_populate_pas(sq->ubuffer.umem, 1UL << page_shift, pas, 0);
+	mlx5_ib_populate_pas(sq->ubuffer.umem, page_size, pas, 0);
 
 	err = mlx5_core_create_sq_tracked(dev, in, inlen, &sq->base.mqp);
 
-- 
2.26.2

