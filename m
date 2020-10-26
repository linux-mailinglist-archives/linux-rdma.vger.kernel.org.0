Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F647298DBC
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 14:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421505AbgJZNXZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 09:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1421387AbgJZNXY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Oct 2020 09:23:24 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3AE0207DE;
        Mon, 26 Oct 2020 13:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603718602;
        bh=UN7SNEd+lAQtC5ScQGLw4Ras5T4v24YwLMpmXwI6BhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IL/H81SmHdy148D8DVOlewc0pty2aJax97W22JKBMXfluZ8MFtVhLPGB7ciYtofdK
         xyfX/BLd6cKuFSEaY7EWYNs2Ak9aOO5J17cJjw1fv9vlp/8756hF4fHJYp6VHc9xh2
         fwMDutoXeyxZMmZ4M3HMAg4vWfbWaIYgpfP3exwQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 1/5] RDMA/mlx5: Change mlx5_ib_populate_pas() to use rdma_for_each_block()
Date:   Mon, 26 Oct 2020 15:23:10 +0200
Message-Id: <20201026132314.1336717-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026132314.1336717-1-leon@kernel.org>
References: <20201026132314.1336717-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

This routine converts the umem SGL into a list of fixed pages for DMA,
which is exactly what rdma_umem_for_each_dma_block() is for, use the
common code directly.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/cq.c      |  6 +++---
 drivers/infiniband/hw/mlx5/devx.c    |  4 ++--
 drivers/infiniband/hw/mlx5/mem.c     | 19 ++++++++++++++-----
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  4 ++--
 drivers/infiniband/hw/mlx5/mr.c      |  7 +++++--
 drivers/infiniband/hw/mlx5/qp.c      |  6 +++---
 drivers/infiniband/hw/mlx5/srq.c     |  2 +-
 7 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 2088e4a3c32d..9ab93d730769 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -762,7 +762,7 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	}
 
 	pas = (__be64 *)MLX5_ADDR_OF(create_cq_in, *cqb, pas);
-	mlx5_ib_populate_pas(dev, cq->buf.umem, page_shift, pas, 0);
+	mlx5_ib_populate_pas(cq->buf.umem, 1UL << page_shift, pas, 0);
 
 	cqc = MLX5_ADDR_OF(create_cq_in, *cqb, cq_context);
 	MLX5_SET(cqc, cqc, log_page_size,
@@ -1305,8 +1305,8 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
 
 	pas = (__be64 *)MLX5_ADDR_OF(modify_cq_in, in, pas);
 	if (udata)
-		mlx5_ib_populate_pas(dev, cq->resize_umem, page_shift,
-				     pas, 0);
+		mlx5_ib_populate_pas(cq->resize_umem, 1UL << page_shift, pas,
+				     0);
 	else
 		mlx5_fill_page_frag_array(&cq->resize_buf->frag_buf, pas);
 
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index ae889266acf1..611ce21157de 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2115,9 +2115,9 @@ static void devx_umem_reg_cmd_build(struct mlx5_ib_dev *dev,
 	MLX5_SET(umem, umem, log_page_size, obj->page_shift -
 					    MLX5_ADAPTER_PAGE_SHIFT);
 	MLX5_SET(umem, umem, page_offset, obj->page_offset);
-	mlx5_ib_populate_pas(dev, obj->umem, obj->page_shift, mtt,
+	mlx5_ib_populate_pas(obj->umem, 1UL << obj->page_shift, mtt,
 			     (obj->umem->writable ? MLX5_IB_MTT_WRITE : 0) |
-			     MLX5_IB_MTT_READ);
+				     MLX5_IB_MTT_READ);
 }
 
 static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_UMEM_REG)(
diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index 7ae96b37bd6e..779c4a040d8b 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -155,13 +155,22 @@ void __mlx5_ib_populate_pas(struct mlx5_ib_dev *dev, struct ib_umem *umem,
 	}
 }
 
-void mlx5_ib_populate_pas(struct mlx5_ib_dev *dev, struct ib_umem *umem,
-			  int page_shift, __be64 *pas, int access_flags)
+/*
+ * Fill in a physical address list. ib_umem_num_dma_blocks() entries will be
+ * filled in the pas array.
+ */
+void mlx5_ib_populate_pas(struct ib_umem *umem, size_t page_size, __be64 *pas,
+			  u64 access_flags)
 {
-	return __mlx5_ib_populate_pas(dev, umem, page_shift, 0,
-				      ib_umem_num_dma_blocks(umem, PAGE_SIZE),
-				      pas, access_flags);
+	struct ib_block_iter biter;
+
+	rdma_umem_for_each_dma_block (umem, &biter, page_size) {
+		*pas = cpu_to_be64(rdma_block_iter_dma_address(&biter) |
+				   access_flags);
+		pas++;
+	}
 }
+
 int mlx5_ib_get_buf_offset(u64 addr, int page_shift, u32 *offset)
 {
 	u64 page_size;
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 3e2c471d77bd..b043a178e95b 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1235,8 +1235,8 @@ void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
 void __mlx5_ib_populate_pas(struct mlx5_ib_dev *dev, struct ib_umem *umem,
 			    int page_shift, size_t offset, size_t num_pages,
 			    __be64 *pas, int access_flags);
-void mlx5_ib_populate_pas(struct mlx5_ib_dev *dev, struct ib_umem *umem,
-			  int page_shift, __be64 *pas, int access_flags);
+void mlx5_ib_populate_pas(struct ib_umem *umem, size_t page_size, __be64 *pas,
+			  u64 access_flags);
 void mlx5_ib_copy_pas(u64 *old, u64 *new, int step, int num);
 int mlx5_ib_get_cqe_size(struct ib_cq *ibcq);
 int mlx5_mr_cache_init(struct mlx5_ib_dev *dev);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 57d3dc111a2b..b7119722a54a 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1167,7 +1167,10 @@ static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
 
 	inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
 	if (populate)
-		inlen += sizeof(*pas) * roundup(ib_umem_num_pages(umem), 2);
+		inlen +=
+			sizeof(*pas) *
+			roundup(ib_umem_num_dma_blocks(umem, 1UL << page_shift),
+				2);
 	in = kvzalloc(inlen, GFP_KERNEL);
 	if (!in) {
 		err = -ENOMEM;
@@ -1179,7 +1182,7 @@ static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
 			err = -EINVAL;
 			goto err_2;
 		}
-		mlx5_ib_populate_pas(dev, umem, page_shift, pas,
+		mlx5_ib_populate_pas(umem, 1ULL << page_shift, pas,
 				     pg_cap ? MLX5_IB_MTT_PRESENT : 0);
 	}
 
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 6915639a776f..042177f33252 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -971,7 +971,7 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	MLX5_SET(create_qp_in, *in, uid, uid);
 	pas = (__be64 *)MLX5_ADDR_OF(create_qp_in, *in, pas);
 	if (ubuffer->umem)
-		mlx5_ib_populate_pas(dev, ubuffer->umem, page_shift, pas, 0);
+		mlx5_ib_populate_pas(ubuffer->umem, 1UL << page_shift, pas, 0);
 
 	qpc = MLX5_ADDR_OF(create_qp_in, *in, qpc);
 
@@ -1251,7 +1251,7 @@ static int create_raw_packet_qp_sq(struct mlx5_ib_dev *dev,
 	MLX5_SET(wq, wq, page_offset, offset);
 
 	pas = (__be64 *)MLX5_ADDR_OF(wq, wq, pas);
-	mlx5_ib_populate_pas(dev, sq->ubuffer.umem, page_shift, pas, 0);
+	mlx5_ib_populate_pas(sq->ubuffer.umem, 1UL << page_shift, pas, 0);
 
 	err = mlx5_core_create_sq_tracked(dev, in, inlen, &sq->base.mqp);
 
@@ -4881,7 +4881,7 @@ static int  create_rq(struct mlx5_ib_rwq *rwq, struct ib_pd *pd,
 		MLX5_SET(rqc, rqc, delay_drop_en, 1);
 	}
 	rq_pas0 = (__be64 *)MLX5_ADDR_OF(wq, wq, pas);
-	mlx5_ib_populate_pas(dev, rwq->umem, rwq->page_shift, rq_pas0, 0);
+	mlx5_ib_populate_pas(rwq->umem, 1UL << rwq->page_shift, rq_pas0, 0);
 	err = mlx5_core_create_rq_tracked(dev, in, inlen, &rwq->core_qp);
 	if (!err && init_attr->create_flags & IB_WQ_FLAGS_DELAY_DROP) {
 		err = set_delay_drop(dev);
diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index 239c7ec65e11..dd6e42d3d175 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -100,7 +100,7 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 		goto err_umem;
 	}
 
-	mlx5_ib_populate_pas(dev, srq->umem, page_shift, in->pas, 0);
+	mlx5_ib_populate_pas(srq->umem, 1UL << page_shift, in->pas, 0);
 
 	err = mlx5_ib_db_map_user(ucontext, udata, ucmd.db_addr, &srq->db);
 	if (err) {
-- 
2.26.2

