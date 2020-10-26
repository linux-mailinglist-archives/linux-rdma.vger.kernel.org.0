Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E5C298DB4
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 14:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421201AbgJZNWt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 09:22:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1777127AbgJZNUI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Oct 2020 09:20:08 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3A7722263;
        Mon, 26 Oct 2020 13:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603718406;
        bh=VesagQABzStOzqsPxGlG8HJn8/BitUOD77cAtUoaYuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JtPrZeb1zYmytj1GyRmBppQFIj9pGWvLfv7YiXHeYbhS3jvoW7xSj8bbFUYgZCsgK
         VYK4lXQhWzFbDIp+dM+refoQuEl+IZxS539olLHTOGvAFHqneLRY54+qPaHKaLbxJG
         6iTTqe8VaJjJ55qViCfdwOpVoscY33C9o9Bl0+cA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 6/7] RDMA/mlx5: Remove ncont from mlx5_ib_cont_pages()
Date:   Mon, 26 Oct 2020 15:19:35 +0200
Message-Id: <20201026131936.1335664-7-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026131936.1335664-1-leon@kernel.org>
References: <20201026131936.1335664-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

This is the same as ib_umem_num_dma_blocks(umem, 1UL << page_shift), have
the callers compute it directly.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/cq.c      | 30 +++++++++++++++-------------
 drivers/infiniband/hw/mlx5/devx.c    | 12 ++++++-----
 drivers/infiniband/hw/mlx5/mem.c     | 15 ++++----------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  3 +--
 drivers/infiniband/hw/mlx5/mr.c      |  6 ++----
 drivers/infiniband/hw/mlx5/qp.c      | 26 ++++++++++++------------
 drivers/infiniband/hw/mlx5/srq.c     |  6 +++---
 7 files changed, 46 insertions(+), 52 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index f993b8f55231..e2d28081bd2a 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -746,8 +746,9 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	if (err)
 		goto err_umem;
 
-	mlx5_ib_cont_pages(cq->buf.umem, ucmd.buf_addr, 0, &npages, &page_shift,
-			   &ncont);
+	mlx5_ib_cont_pages(cq->buf.umem, ucmd.buf_addr, 0, &npages,
+			   &page_shift);
+	ncont = ib_umem_num_dma_blocks(cq->buf.umem, 1UL << page_shift);
 	mlx5_ib_dbg(dev, "addr 0x%llx, size %u, npages %d, page_shift %d, ncont %d\n",
 		    ucmd.buf_addr, entries * ucmd.cqe_size, npages, page_shift, ncont);
 
@@ -1128,7 +1129,7 @@ int mlx5_ib_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period)
 }
 
 static int resize_user(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq,
-		       int entries, struct ib_udata *udata, int *npas,
+		       int entries, struct ib_udata *udata,
 		       int *page_shift, int *cqe_size)
 {
 	struct mlx5_ib_resize_cq ucmd;
@@ -1155,7 +1156,7 @@ static int resize_user(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq,
 		return err;
 	}
 
-	mlx5_ib_cont_pages(umem, ucmd.buf_addr, 0, &npages, page_shift, npas);
+	mlx5_ib_cont_pages(umem, ucmd.buf_addr, 0, &npages, page_shift);
 
 	cq->resize_umem = umem;
 	*cqe_size = ucmd.cqe_size;
@@ -1276,22 +1277,23 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
 
 	mutex_lock(&cq->resize_mutex);
 	if (udata) {
-		err = resize_user(dev, cq, entries, udata, &npas, &page_shift,
+		err = resize_user(dev, cq, entries, udata, &page_shift,
 				  &cqe_size);
+		if (err)
+			goto ex;
+		npas = ib_umem_num_dma_blocks(cq->resize_umem, 1UL << page_shift);
 	} else {
+		struct mlx5_frag_buf *frag_buf;
+
 		cqe_size = 64;
 		err = resize_kernel(dev, cq, entries, cqe_size);
-		if (!err) {
-			struct mlx5_frag_buf *frag_buf = &cq->resize_buf->frag_buf;
-
-			npas = frag_buf->npages;
-			page_shift = frag_buf->page_shift;
-		}
+		if (err)
+			goto ex;
+		frag_buf = &cq->resize_buf->frag_buf;
+		npas = frag_buf->npages;
+		page_shift = frag_buf->page_shift;
 	}
 
-	if (err)
-		goto ex;
-
 	inlen = MLX5_ST_SZ_BYTES(modify_cq_in) +
 		MLX5_FLD_SZ_BYTES(modify_cq_in, pas[0]) * npas;
 
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index ebd6e6c4127e..7d99b5b298da 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -95,7 +95,6 @@ struct devx_umem {
 	struct ib_umem			*umem;
 	u32				page_offset;
 	int				page_shift;
-	int				ncont;
 	u32				dinlen;
 	u32				dinbox[MLX5_ST_SZ_DW(general_obj_in_cmd_hdr)];
 };
@@ -2083,7 +2082,7 @@ static int devx_umem_get(struct mlx5_ib_dev *dev, struct ib_ucontext *ucontext,
 
 	mlx5_ib_cont_pages(obj->umem, obj->umem->address,
 			   MLX5_MKEY_PAGE_SHIFT_MASK, &npages,
-			   &obj->page_shift, &obj->ncont);
+			   &obj->page_shift);
 
 	if (!npages) {
 		ib_umem_release(obj->umem);
@@ -2100,8 +2099,10 @@ static int devx_umem_reg_cmd_alloc(struct uverbs_attr_bundle *attrs,
 				   struct devx_umem *obj,
 				   struct devx_umem_reg_cmd *cmd)
 {
-	cmd->inlen = MLX5_ST_SZ_BYTES(create_umem_in) +
-		    (MLX5_ST_SZ_BYTES(mtt) * obj->ncont);
+	cmd->inlen =
+		MLX5_ST_SZ_BYTES(create_umem_in) +
+		(MLX5_ST_SZ_BYTES(mtt) *
+		 ib_umem_num_dma_blocks(obj->umem, 1UL << obj->page_shift));
 	cmd->in = uverbs_zalloc(attrs, cmd->inlen);
 	return PTR_ERR_OR_ZERO(cmd->in);
 }
@@ -2117,7 +2118,8 @@ static void devx_umem_reg_cmd_build(struct mlx5_ib_dev *dev,
 	mtt = (__be64 *)MLX5_ADDR_OF(umem, umem, mtt);
 
 	MLX5_SET(create_umem_in, cmd->in, opcode, MLX5_CMD_OP_CREATE_UMEM);
-	MLX5_SET64(umem, umem, num_of_mtt, obj->ncont);
+	MLX5_SET64(umem, umem, num_of_mtt,
+		   ib_umem_num_dma_blocks(obj->umem, 1UL << obj->page_shift));
 	MLX5_SET(umem, umem, log_page_size, obj->page_shift -
 					    MLX5_ADAPTER_PAGE_SHIFT);
 	MLX5_SET(umem, umem, page_offset, obj->page_offset);
diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index 2faee44cca99..6d87f8c13ce0 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -41,12 +41,9 @@
  * @max_page_shift: high limit for page_shift - 0 means no limit
  * @count: number of PAGE_SIZE pages covered by umem
  * @shift: page shift for the compound pages found in the region
- * @ncont: number of compund pages
  */
 void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
-			unsigned long max_page_shift,
-			int *count, int *shift,
-			int *ncont)
+			unsigned long max_page_shift, int *count, int *shift)
 {
 	unsigned long tmp;
 	unsigned long m;
@@ -60,8 +57,7 @@ void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
 		struct ib_umem_odp *odp = to_ib_umem_odp(umem);
 
 		*shift = odp->page_shift;
-		*ncont = ib_umem_odp_num_pages(odp);
-		*count = *ncont << (*shift - PAGE_SHIFT);
+		*count = ib_umem_num_pages(umem);
 		return;
 	}
 
@@ -90,13 +86,10 @@ void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
 		i += len;
 	}
 
-	if (i) {
+	if (i)
 		m = min_t(unsigned long, ilog2(roundup_pow_of_two(i)), m);
-		*ncont = DIV_ROUND_UP(i, (1 << m));
-	} else {
+	else
 		m  = 0;
-		*ncont = 0;
-	}
 	*shift = PAGE_SHIFT + m;
 	*count = i;
 }
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 15f95900e83c..a36b0b8138a0 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1231,8 +1231,7 @@ int mlx5_ib_query_port(struct ib_device *ibdev, u8 port,
 		       struct ib_port_attr *props);
 void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
 			unsigned long max_page_shift,
-			int *count, int *shift,
-			int *ncont);
+			int *count, int *shift);
 void __mlx5_ib_populate_pas(struct mlx5_ib_dev *dev, struct ib_umem *umem,
 			    int page_shift, size_t offset, size_t num_pages,
 			    __be64 *pas, int access_flags);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 67f5834254c9..33483765e85c 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -959,10 +959,9 @@ static struct mlx5_ib_mr *alloc_mr_from_cache(struct ib_pd *pd,
 	struct mlx5_ib_mr *mr;
 	int npages;
 	int page_shift;
-	int ncont;
 
 	mlx5_ib_cont_pages(umem, iova, MLX5_MKEY_PAGE_SHIFT_MASK, &npages,
-			   &page_shift, &ncont);
+			   &page_shift);
 	ent = mr_cache_ent_from_order(dev, order_base_2(ib_umem_num_dma_blocks(
 						   umem, 1UL << page_shift)));
 	if (!ent)
@@ -1153,7 +1152,6 @@ static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
 	int page_shift;
 	__be64 *pas;
 	int npages;
-	int ncont;
 	void *mkc;
 	int inlen;
 	u32 *in;
@@ -1165,7 +1163,7 @@ static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
 		return ERR_PTR(-ENOMEM);
 
 	mlx5_ib_cont_pages(umem, iova, MLX5_MKEY_PAGE_SHIFT_MASK, &npages,
-			   &page_shift, &ncont);
+			   &page_shift);
 
 	mr->page_shift = page_shift;
 	mr->ibmr.pd = pd;
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 77ba3adfd148..259cef28a4d5 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -781,7 +781,7 @@ int bfregn_to_uar_index(struct mlx5_ib_dev *dev,
 static int mlx5_ib_umem_get(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 			    unsigned long addr, size_t size,
 			    struct ib_umem **umem, int *npages, int *page_shift,
-			    int *ncont, u32 *offset)
+			    u32 *offset)
 {
 	int err;
 
@@ -791,7 +791,7 @@ static int mlx5_ib_umem_get(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 		return PTR_ERR(*umem);
 	}
 
-	mlx5_ib_cont_pages(*umem, addr, 0, npages, page_shift, ncont);
+	mlx5_ib_cont_pages(*umem, addr, 0, npages, page_shift);
 
 	err = mlx5_ib_get_buf_offset(addr, *page_shift, offset);
 	if (err) {
@@ -799,8 +799,8 @@ static int mlx5_ib_umem_get(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 		goto err_umem;
 	}
 
-	mlx5_ib_dbg(dev, "addr 0x%lx, size %zu, npages %d, page_shift %d, ncont %d, offset %d\n",
-		    addr, size, *npages, *page_shift, *ncont, *offset);
+	mlx5_ib_dbg(dev, "addr 0x%lx, size %zu, npages %d, page_shift %d, offset %d\n",
+		    addr, size, *npages, *page_shift, *offset);
 
 	return 0;
 
@@ -836,7 +836,6 @@ static int create_user_rq(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	int page_shift = 0;
 	int npages;
 	u32 offset = 0;
-	int ncont = 0;
 	int err;
 
 	if (!ucmd->buf_addr)
@@ -849,8 +848,7 @@ static int create_user_rq(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		return err;
 	}
 
-	mlx5_ib_cont_pages(rwq->umem, ucmd->buf_addr, 0, &npages, &page_shift,
-			   &ncont);
+	mlx5_ib_cont_pages(rwq->umem, ucmd->buf_addr, 0, &npages, &page_shift);
 	err = mlx5_ib_get_buf_offset(ucmd->buf_addr, page_shift,
 				     &rwq->rq_page_offset);
 	if (err) {
@@ -858,14 +856,14 @@ static int create_user_rq(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		goto err_umem;
 	}
 
-	rwq->rq_num_pas = ncont;
+	rwq->rq_num_pas = ib_umem_num_dma_blocks(rwq->umem, 1UL << page_shift);
 	rwq->page_shift = page_shift;
 	rwq->log_page_size =  page_shift - MLX5_ADAPTER_PAGE_SHIFT;
 	rwq->wq_sig = !!(ucmd->flags & MLX5_WQ_FLAG_SIGNATURE);
 
 	mlx5_ib_dbg(dev, "addr 0x%llx, size %zd, npages %d, page_shift %d, ncont %d, offset %d\n",
 		    (unsigned long long)ucmd->buf_addr, rwq->buf_size,
-		    npages, page_shift, ncont, offset);
+		    npages, page_shift, rwq->rq_num_pas, offset);
 
 	err = mlx5_ib_db_map_user(ucontext, udata, ucmd->db_addr, &rwq->db);
 	if (err) {
@@ -952,9 +950,10 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		ubuffer->buf_addr = ucmd->buf_addr;
 		err = mlx5_ib_umem_get(dev, udata, ubuffer->buf_addr,
 				       ubuffer->buf_size, &ubuffer->umem,
-				       &npages, &page_shift, &ncont, &offset);
+				       &npages, &page_shift, &offset);
 		if (err)
 			goto err_bfreg;
+		ncont = ib_umem_num_dma_blocks(ubuffer->umem, 1UL << page_shift);
 	} else {
 		ubuffer->umem = NULL;
 	}
@@ -1211,16 +1210,17 @@ static int create_raw_packet_qp_sq(struct mlx5_ib_dev *dev,
 	int err;
 	int page_shift = 0;
 	int npages;
-	int ncont = 0;
 	u32 offset = 0;
 
 	err = mlx5_ib_umem_get(dev, udata, ubuffer->buf_addr, ubuffer->buf_size,
-			       &sq->ubuffer.umem, &npages, &page_shift, &ncont,
+			       &sq->ubuffer.umem, &npages, &page_shift,
 			       &offset);
 	if (err)
 		return err;
 
-	inlen = MLX5_ST_SZ_BYTES(create_sq_in) + sizeof(u64) * ncont;
+	inlen = MLX5_ST_SZ_BYTES(create_sq_in) +
+		sizeof(u64) * ib_umem_num_dma_blocks(sq->ubuffer.umem,
+						     1UL << page_shift);
 	in = kvzalloc(inlen, GFP_KERNEL);
 	if (!in) {
 		err = -ENOMEM;
diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index 9b655192797d..ea7ae96c1bbf 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -53,7 +53,6 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 	int err;
 	int npages;
 	int page_shift;
-	int ncont;
 	u32 offset;
 	u32 uidx = MLX5_IB_DEFAULT_UIDX;
 
@@ -88,7 +87,7 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 	}
 
 	mlx5_ib_cont_pages(srq->umem, ucmd.buf_addr, 0, &npages,
-			   &page_shift, &ncont);
+			   &page_shift);
 	err = mlx5_ib_get_buf_offset(ucmd.buf_addr, page_shift,
 				     &offset);
 	if (err) {
@@ -96,7 +95,8 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 		goto err_umem;
 	}
 
-	in->pas = kvcalloc(ncont, sizeof(*in->pas), GFP_KERNEL);
+	in->pas = kvcalloc(ib_umem_num_dma_blocks(srq->umem, 1UL << page_shift),
+			   sizeof(*in->pas), GFP_KERNEL);
 	if (!in->pas) {
 		err = -ENOMEM;
 		goto err_umem;
-- 
2.26.2

