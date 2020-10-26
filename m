Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366C8298DB7
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 14:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421178AbgJZNWt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 09:22:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1777055AbgJZNUE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Oct 2020 09:20:04 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71A0322263;
        Mon, 26 Oct 2020 13:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603718403;
        bh=zcgL4VXGAk1Yh/qOTfU3GFV92h+1C5bF/hQ0mPlqloY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V2C4pX3dbFMLut/h35+nWBhd1ByQcU5syFLL9Gx0Mi7NpLHwo0+C7I/Nv2IhG7TC/
         stHU1pFeJboZPyRPlHIrQabKzd9oYLfQ0KL7Dq2e9Df+5EyElBbzXEDVFEg4429h6a
         S8Lh7TJwC0YObx6SjDi1R2GlCEVwMq9NH3jCFVvk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 7/7] RDMA/mlx5: Remove npages from mlx5_ib_cont_pages()
Date:   Mon, 26 Oct 2020 15:19:36 +0200
Message-Id: <20201026131936.1335664-8-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026131936.1335664-1-leon@kernel.org>
References: <20201026131936.1335664-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Most callers don't need this, and the few that do can get it as
ib_umem_num_pages(umem).

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/cq.c      | 14 +++++++-------
 drivers/infiniband/hw/mlx5/devx.c    | 10 +---------
 drivers/infiniband/hw/mlx5/mem.c     |  5 +----
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 +-
 drivers/infiniband/hw/mlx5/mr.c      | 10 +++-------
 drivers/infiniband/hw/mlx5/qp.c      | 27 +++++++++++++--------------
 drivers/infiniband/hw/mlx5/srq.c     |  4 +---
 7 files changed, 27 insertions(+), 45 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index e2d28081bd2a..2088e4a3c32d 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -710,7 +710,6 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	size_t ucmdlen;
 	int page_shift;
 	__be64 *pas;
-	int npages;
 	int ncont;
 	void *cqc;
 	int err;
@@ -746,11 +745,13 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	if (err)
 		goto err_umem;
 
-	mlx5_ib_cont_pages(cq->buf.umem, ucmd.buf_addr, 0, &npages,
-			   &page_shift);
+	mlx5_ib_cont_pages(cq->buf.umem, ucmd.buf_addr, 0, &page_shift);
 	ncont = ib_umem_num_dma_blocks(cq->buf.umem, 1UL << page_shift);
-	mlx5_ib_dbg(dev, "addr 0x%llx, size %u, npages %d, page_shift %d, ncont %d\n",
-		    ucmd.buf_addr, entries * ucmd.cqe_size, npages, page_shift, ncont);
+	mlx5_ib_dbg(
+		dev,
+		"addr 0x%llx, size %u, npages %zu, page_shift %d, ncont %d\n",
+		ucmd.buf_addr, entries * ucmd.cqe_size,
+		ib_umem_num_pages(cq->buf.umem), page_shift, ncont);
 
 	*inlen = MLX5_ST_SZ_BYTES(create_cq_in) +
 		 MLX5_FLD_SZ_BYTES(create_cq_in, pas[0]) * ncont;
@@ -1135,7 +1136,6 @@ static int resize_user(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq,
 	struct mlx5_ib_resize_cq ucmd;
 	struct ib_umem *umem;
 	int err;
-	int npages;
 
 	err = ib_copy_from_udata(&ucmd, udata, sizeof(ucmd));
 	if (err)
@@ -1156,7 +1156,7 @@ static int resize_user(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq,
 		return err;
 	}
 
-	mlx5_ib_cont_pages(umem, ucmd.buf_addr, 0, &npages, page_shift);
+	mlx5_ib_cont_pages(umem, ucmd.buf_addr, 0, page_shift);
 
 	cq->resize_umem = umem;
 	*cqe_size = ucmd.cqe_size;
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 7d99b5b298da..ae889266acf1 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2056,7 +2056,6 @@ static int devx_umem_get(struct mlx5_ib_dev *dev, struct ib_ucontext *ucontext,
 	u64 addr;
 	size_t size;
 	u32 access;
-	int npages;
 	int err;
 	u32 page_mask;
 
@@ -2081,14 +2080,7 @@ static int devx_umem_get(struct mlx5_ib_dev *dev, struct ib_ucontext *ucontext,
 		return PTR_ERR(obj->umem);
 
 	mlx5_ib_cont_pages(obj->umem, obj->umem->address,
-			   MLX5_MKEY_PAGE_SHIFT_MASK, &npages,
-			   &obj->page_shift);
-
-	if (!npages) {
-		ib_umem_release(obj->umem);
-		return -EINVAL;
-	}
-
+			   MLX5_MKEY_PAGE_SHIFT_MASK, &obj->page_shift);
 	page_mask = (1 << obj->page_shift) - 1;
 	obj->page_offset = obj->umem->address & page_mask;
 
diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index 6d87f8c13ce0..7ae96b37bd6e 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -39,11 +39,10 @@
 /* @umem: umem object to scan
  * @addr: ib virtual address requested by the user
  * @max_page_shift: high limit for page_shift - 0 means no limit
- * @count: number of PAGE_SIZE pages covered by umem
  * @shift: page shift for the compound pages found in the region
  */
 void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
-			unsigned long max_page_shift, int *count, int *shift)
+			unsigned long max_page_shift, int *shift)
 {
 	unsigned long tmp;
 	unsigned long m;
@@ -57,7 +56,6 @@ void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
 		struct ib_umem_odp *odp = to_ib_umem_odp(umem);
 
 		*shift = odp->page_shift;
-		*count = ib_umem_num_pages(umem);
 		return;
 	}
 
@@ -91,7 +89,6 @@ void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
 	else
 		m  = 0;
 	*shift = PAGE_SHIFT + m;
-	*count = i;
 }
 
 /*
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index a36b0b8138a0..3e2c471d77bd 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1231,7 +1231,7 @@ int mlx5_ib_query_port(struct ib_device *ibdev, u8 port,
 		       struct ib_port_attr *props);
 void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
 			unsigned long max_page_shift,
-			int *count, int *shift);
+			int *shift);
 void __mlx5_ib_populate_pas(struct mlx5_ib_dev *dev, struct ib_umem *umem,
 			    int page_shift, size_t offset, size_t num_pages,
 			    __be64 *pas, int access_flags);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 33483765e85c..57d3dc111a2b 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -957,11 +957,9 @@ static struct mlx5_ib_mr *alloc_mr_from_cache(struct ib_pd *pd,
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct mlx5_cache_ent *ent;
 	struct mlx5_ib_mr *mr;
-	int npages;
 	int page_shift;
 
-	mlx5_ib_cont_pages(umem, iova, MLX5_MKEY_PAGE_SHIFT_MASK, &npages,
-			   &page_shift);
+	mlx5_ib_cont_pages(umem, iova, MLX5_MKEY_PAGE_SHIFT_MASK, &page_shift);
 	ent = mr_cache_ent_from_order(dev, order_base_2(ib_umem_num_dma_blocks(
 						   umem, 1UL << page_shift)));
 	if (!ent)
@@ -1151,7 +1149,6 @@ static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
 	struct mlx5_ib_mr *mr;
 	int page_shift;
 	__be64 *pas;
-	int npages;
 	void *mkc;
 	int inlen;
 	u32 *in;
@@ -1162,8 +1159,7 @@ static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	mlx5_ib_cont_pages(umem, iova, MLX5_MKEY_PAGE_SHIFT_MASK, &npages,
-			   &page_shift);
+	mlx5_ib_cont_pages(umem, iova, MLX5_MKEY_PAGE_SHIFT_MASK, &page_shift);
 
 	mr->page_shift = page_shift;
 	mr->ibmr.pd = pd;
@@ -1171,7 +1167,7 @@ static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
 
 	inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
 	if (populate)
-		inlen += sizeof(*pas) * roundup(npages, 2);
+		inlen += sizeof(*pas) * roundup(ib_umem_num_pages(umem), 2);
 	in = kvzalloc(inlen, GFP_KERNEL);
 	if (!in) {
 		err = -ENOMEM;
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 259cef28a4d5..6915639a776f 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -780,7 +780,7 @@ int bfregn_to_uar_index(struct mlx5_ib_dev *dev,
 
 static int mlx5_ib_umem_get(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 			    unsigned long addr, size_t size,
-			    struct ib_umem **umem, int *npages, int *page_shift,
+			    struct ib_umem **umem, int *page_shift,
 			    u32 *offset)
 {
 	int err;
@@ -791,7 +791,7 @@ static int mlx5_ib_umem_get(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 		return PTR_ERR(*umem);
 	}
 
-	mlx5_ib_cont_pages(*umem, addr, 0, npages, page_shift);
+	mlx5_ib_cont_pages(*umem, addr, 0, page_shift);
 
 	err = mlx5_ib_get_buf_offset(addr, *page_shift, offset);
 	if (err) {
@@ -799,8 +799,8 @@ static int mlx5_ib_umem_get(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 		goto err_umem;
 	}
 
-	mlx5_ib_dbg(dev, "addr 0x%lx, size %zu, npages %d, page_shift %d, offset %d\n",
-		    addr, size, *npages, *page_shift, *offset);
+	mlx5_ib_dbg(dev, "addr 0x%lx, size %zu, npages %zu, page_shift %d, offset %d\n",
+		    addr, size, ib_umem_num_pages(*umem), *page_shift, *offset);
 
 	return 0;
 
@@ -834,7 +834,6 @@ static int create_user_rq(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	struct mlx5_ib_ucontext *ucontext = rdma_udata_to_drv_context(
 		udata, struct mlx5_ib_ucontext, ibucontext);
 	int page_shift = 0;
-	int npages;
 	u32 offset = 0;
 	int err;
 
@@ -848,7 +847,7 @@ static int create_user_rq(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		return err;
 	}
 
-	mlx5_ib_cont_pages(rwq->umem, ucmd->buf_addr, 0, &npages, &page_shift);
+	mlx5_ib_cont_pages(rwq->umem, ucmd->buf_addr, 0, &page_shift);
 	err = mlx5_ib_get_buf_offset(ucmd->buf_addr, page_shift,
 				     &rwq->rq_page_offset);
 	if (err) {
@@ -861,9 +860,12 @@ static int create_user_rq(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	rwq->log_page_size =  page_shift - MLX5_ADAPTER_PAGE_SHIFT;
 	rwq->wq_sig = !!(ucmd->flags & MLX5_WQ_FLAG_SIGNATURE);
 
-	mlx5_ib_dbg(dev, "addr 0x%llx, size %zd, npages %d, page_shift %d, ncont %d, offset %d\n",
-		    (unsigned long long)ucmd->buf_addr, rwq->buf_size,
-		    npages, page_shift, rwq->rq_num_pas, offset);
+	mlx5_ib_dbg(
+		dev,
+		"addr 0x%llx, size %zd, npages %zu, page_shift %d, ncont %d, offset %d\n",
+		(unsigned long long)ucmd->buf_addr, rwq->buf_size,
+		ib_umem_num_pages(rwq->umem), page_shift, rwq->rq_num_pas,
+		offset);
 
 	err = mlx5_ib_db_map_user(ucontext, udata, ucmd->db_addr, &rwq->db);
 	if (err) {
@@ -896,7 +898,6 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	struct mlx5_ib_ubuffer *ubuffer = &base->ubuffer;
 	int page_shift = 0;
 	int uar_index = 0;
-	int npages;
 	u32 offset = 0;
 	int bfregn;
 	int ncont = 0;
@@ -950,7 +951,7 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		ubuffer->buf_addr = ucmd->buf_addr;
 		err = mlx5_ib_umem_get(dev, udata, ubuffer->buf_addr,
 				       ubuffer->buf_size, &ubuffer->umem,
-				       &npages, &page_shift, &offset);
+				       &page_shift, &offset);
 		if (err)
 			goto err_bfreg;
 		ncont = ib_umem_num_dma_blocks(ubuffer->umem, 1UL << page_shift);
@@ -1209,12 +1210,10 @@ static int create_raw_packet_qp_sq(struct mlx5_ib_dev *dev,
 	int inlen;
 	int err;
 	int page_shift = 0;
-	int npages;
 	u32 offset = 0;
 
 	err = mlx5_ib_umem_get(dev, udata, ubuffer->buf_addr, ubuffer->buf_size,
-			       &sq->ubuffer.umem, &npages, &page_shift,
-			       &offset);
+			       &sq->ubuffer.umem, &page_shift, &offset);
 	if (err)
 		return err;
 
diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index ea7ae96c1bbf..239c7ec65e11 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -51,7 +51,6 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 		udata, struct mlx5_ib_ucontext, ibucontext);
 	size_t ucmdlen;
 	int err;
-	int npages;
 	int page_shift;
 	u32 offset;
 	u32 uidx = MLX5_IB_DEFAULT_UIDX;
@@ -86,8 +85,7 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 		return err;
 	}
 
-	mlx5_ib_cont_pages(srq->umem, ucmd.buf_addr, 0, &npages,
-			   &page_shift);
+	mlx5_ib_cont_pages(srq->umem, ucmd.buf_addr, 0, &page_shift);
 	err = mlx5_ib_get_buf_offset(ucmd.buf_addr, page_shift,
 				     &offset);
 	if (err) {
-- 
2.26.2

