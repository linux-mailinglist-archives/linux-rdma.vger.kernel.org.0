Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D82298DB2
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 14:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421139AbgJZNWs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 09:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1776924AbgJZNT5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Oct 2020 09:19:57 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7A2822265;
        Mon, 26 Oct 2020 13:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603718396;
        bh=hCl0cYfW0qjG+44yrsNpHBlx9coWPBy1ET86dyRLBms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cRr1tidSfLtGrXhm5/vftkfYyl3bPkvM+gRNJPUPhdl0WMgTw0zKuidyd8scYFx7N
         myqJ4jnBye1WxUVOHJFtEE+W+h8dxDuyFOiEzRx0hF9V8w7jE/pOuV1H8eFUZG5uBq
         xYhrGp0xENmcdvYJoCUXZ+JxSQkXKi1Ad0G7qMX4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 5/7] RDMA/mlx5: Remove order from mlx5_ib_cont_pages()
Date:   Mon, 26 Oct 2020 15:19:34 +0200
Message-Id: <20201026131936.1335664-6-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026131936.1335664-1-leon@kernel.org>
References: <20201026131936.1335664-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Only alloc_mr_from_cache() needs order and can trivially compute it, so
lift it to the one call site and remove the NULL arguments.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/cq.c      |  5 ++---
 drivers/infiniband/hw/mlx5/devx.c    |  2 +-
 drivers/infiniband/hw/mlx5/mem.c     | 13 +------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 +-
 drivers/infiniband/hw/mlx5/mr.c      |  8 ++++----
 drivers/infiniband/hw/mlx5/qp.c      |  4 ++--
 drivers/infiniband/hw/mlx5/srq.c     |  2 +-
 7 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index fb62f1d04afa..f993b8f55231 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -747,7 +747,7 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 		goto err_umem;
 
 	mlx5_ib_cont_pages(cq->buf.umem, ucmd.buf_addr, 0, &npages, &page_shift,
-			   &ncont, NULL);
+			   &ncont);
 	mlx5_ib_dbg(dev, "addr 0x%llx, size %u, npages %d, page_shift %d, ncont %d\n",
 		    ucmd.buf_addr, entries * ucmd.cqe_size, npages, page_shift, ncont);
 
@@ -1155,8 +1155,7 @@ static int resize_user(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq,
 		return err;
 	}
 
-	mlx5_ib_cont_pages(umem, ucmd.buf_addr, 0, &npages, page_shift,
-			   npas, NULL);
+	mlx5_ib_cont_pages(umem, ucmd.buf_addr, 0, &npages, page_shift, npas);
 
 	cq->resize_umem = umem;
 	*cqe_size = ucmd.cqe_size;
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 9e3d8b826498..ebd6e6c4127e 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2083,7 +2083,7 @@ static int devx_umem_get(struct mlx5_ib_dev *dev, struct ib_ucontext *ucontext,
 
 	mlx5_ib_cont_pages(obj->umem, obj->umem->address,
 			   MLX5_MKEY_PAGE_SHIFT_MASK, &npages,
-			   &obj->page_shift, &obj->ncont, NULL);
+			   &obj->page_shift, &obj->ncont);
 
 	if (!npages) {
 		ib_umem_release(obj->umem);
diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index e63af1b05c0b..2faee44cca99 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -42,12 +42,11 @@
  * @count: number of PAGE_SIZE pages covered by umem
  * @shift: page shift for the compound pages found in the region
  * @ncont: number of compund pages
- * @order: log2 of the number of compound pages
  */
 void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
 			unsigned long max_page_shift,
 			int *count, int *shift,
-			int *ncont, int *order)
+			int *ncont)
 {
 	unsigned long tmp;
 	unsigned long m;
@@ -63,8 +62,6 @@ void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
 		*shift = odp->page_shift;
 		*ncont = ib_umem_odp_num_pages(odp);
 		*count = *ncont << (*shift - PAGE_SHIFT);
-		if (order)
-			*order = ilog2(roundup_pow_of_two(*count));
 		return;
 	}
 
@@ -95,17 +92,9 @@ void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
 
 	if (i) {
 		m = min_t(unsigned long, ilog2(roundup_pow_of_two(i)), m);
-
-		if (order)
-			*order = ilog2(roundup_pow_of_two(i) >> m);
-
 		*ncont = DIV_ROUND_UP(i, (1 << m));
 	} else {
 		m  = 0;
-
-		if (order)
-			*order = 0;
-
 		*ncont = 0;
 	}
 	*shift = PAGE_SHIFT + m;
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 9c1d206cb900..15f95900e83c 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1232,7 +1232,7 @@ int mlx5_ib_query_port(struct ib_device *ibdev, u8 port,
 void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
 			unsigned long max_page_shift,
 			int *count, int *shift,
-			int *ncont, int *order);
+			int *ncont);
 void __mlx5_ib_populate_pas(struct mlx5_ib_dev *dev, struct ib_umem *umem,
 			    int page_shift, size_t offset, size_t num_pages,
 			    __be64 *pas, int access_flags);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index f1e4b4c001fe..67f5834254c9 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -960,11 +960,11 @@ static struct mlx5_ib_mr *alloc_mr_from_cache(struct ib_pd *pd,
 	int npages;
 	int page_shift;
 	int ncont;
-	int order;
 
 	mlx5_ib_cont_pages(umem, iova, MLX5_MKEY_PAGE_SHIFT_MASK, &npages,
-			   &page_shift, &ncont, &order);
-	ent = mr_cache_ent_from_order(dev, order);
+			   &page_shift, &ncont);
+	ent = mr_cache_ent_from_order(dev, order_base_2(ib_umem_num_dma_blocks(
+						   umem, 1UL << page_shift)));
 	if (!ent)
 		return ERR_PTR(-E2BIG);
 
@@ -1165,7 +1165,7 @@ static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
 		return ERR_PTR(-ENOMEM);
 
 	mlx5_ib_cont_pages(umem, iova, MLX5_MKEY_PAGE_SHIFT_MASK, &npages,
-			   &page_shift, &ncont, NULL);
+			   &page_shift, &ncont);
 
 	mr->page_shift = page_shift;
 	mr->ibmr.pd = pd;
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index ab2a9c71c543..77ba3adfd148 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -791,7 +791,7 @@ static int mlx5_ib_umem_get(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 		return PTR_ERR(*umem);
 	}
 
-	mlx5_ib_cont_pages(*umem, addr, 0, npages, page_shift, ncont, NULL);
+	mlx5_ib_cont_pages(*umem, addr, 0, npages, page_shift, ncont);
 
 	err = mlx5_ib_get_buf_offset(addr, *page_shift, offset);
 	if (err) {
@@ -850,7 +850,7 @@ static int create_user_rq(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	}
 
 	mlx5_ib_cont_pages(rwq->umem, ucmd->buf_addr, 0, &npages, &page_shift,
-			   &ncont, NULL);
+			   &ncont);
 	err = mlx5_ib_get_buf_offset(ucmd->buf_addr, page_shift,
 				     &rwq->rq_page_offset);
 	if (err) {
diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index e2f720eec1e1..9b655192797d 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -88,7 +88,7 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 	}
 
 	mlx5_ib_cont_pages(srq->umem, ucmd.buf_addr, 0, &npages,
-			   &page_shift, &ncont, NULL);
+			   &page_shift, &ncont);
 	err = mlx5_ib_get_buf_offset(ucmd.buf_addr, page_shift,
 				     &offset);
 	if (err) {
-- 
2.26.2

