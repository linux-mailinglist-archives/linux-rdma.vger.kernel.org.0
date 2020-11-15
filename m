Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3762B34AF
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Nov 2020 12:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgKOLnZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Nov 2020 06:43:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:52508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgKOLnZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 15 Nov 2020 06:43:25 -0500
Received: from localhost (thunderhill.nvidia.com [216.228.112.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7D1D222B8;
        Sun, 15 Nov 2020 11:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605440604;
        bh=m7pEbcn0u1MHqlZZJO8T0iyHyBWBQ7yc4bE1SCrX3rk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q2ANopVeJsKjUeUj7Wx5bhmp7KFQ2H+mAnkNHv2PRaOB7E0o2cSAW9Q2NcqQXgcTu
         +MVqtgovJtk1Vxm+3V91+ej+l+k3LTYr7M7Ck+5l08MvQjYVN5LJUya5bxOevrYRZm
         Be1y4t3JaxoJDQtD2KpAEDwT0LvtE/Uk+g8rmNqw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 3/7] RDMA/mlx5: Directly compute the PAS list for raw QP RQ's
Date:   Sun, 15 Nov 2020 13:43:07 +0200
Message-Id: <20201115114311.136250-4-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201115114311.136250-1-leon@kernel.org>
References: <20201115114311.136250-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

The RQ WQ created when making a raw ethernet QP copies the PAS list from
a dummy QPC command created earlier in the flow. The WQC and QPC PAS lists
are not fully compatible as the page_offset is a different size.

Create the RQ WQ's PAS list directly and do not try to copy it from
another command structure.

Like the prior patch, this also means that badly aligned buffers were not
correctly rejected.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 41 +++++++++++++--------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index ec598eef815f..25904778e371 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1286,40 +1286,31 @@ static void destroy_raw_packet_qp_sq(struct mlx5_ib_dev *dev,
 	ib_umem_release(sq->ubuffer.umem);
 }
 
-static size_t get_rq_pas_size(void *qpc)
-{
-	u32 log_page_size = MLX5_GET(qpc, qpc, log_page_size) + 12;
-	u32 log_rq_stride = MLX5_GET(qpc, qpc, log_rq_stride);
-	u32 log_rq_size   = MLX5_GET(qpc, qpc, log_rq_size);
-	u32 page_offset   = MLX5_GET(qpc, qpc, page_offset);
-	u32 po_quanta	  = 1 << (log_page_size - 6);
-	u32 rq_sz	  = 1 << (log_rq_size + 4 + log_rq_stride);
-	u32 page_size	  = 1 << log_page_size;
-	u32 rq_sz_po      = rq_sz + (page_offset * po_quanta);
-	u32 rq_num_pas	  = (rq_sz_po + page_size - 1) / page_size;
-
-	return rq_num_pas * sizeof(u64);
-}
-
 static int create_raw_packet_qp_rq(struct mlx5_ib_dev *dev,
 				   struct mlx5_ib_rq *rq, void *qpin,
-				   size_t qpinlen, struct ib_pd *pd)
+				   struct ib_pd *pd)
 {
 	struct mlx5_ib_qp *mqp = rq->base.container_mibqp;
 	__be64 *pas;
-	__be64 *qp_pas;
 	void *in;
 	void *rqc;
 	void *wq;
 	void *qpc = MLX5_ADDR_OF(create_qp_in, qpin, qpc);
-	size_t rq_pas_size = get_rq_pas_size(qpc);
+	struct ib_umem *umem = rq->base.ubuffer.umem;
+	unsigned int page_offset_quantized;
+	unsigned long page_size = 0;
 	size_t inlen;
 	int err;
 
-	if (qpinlen < rq_pas_size + MLX5_BYTE_OFF(create_qp_in, pas))
+	page_size = mlx5_umem_find_best_quantized_pgoff(umem, wq, log_wq_pg_sz,
+							MLX5_ADAPTER_PAGE_SHIFT,
+							page_offset, 64,
+							&page_offset_quantized);
+	if (!page_size)
 		return -EINVAL;
 
-	inlen = MLX5_ST_SZ_BYTES(create_rq_in) + rq_pas_size;
+	inlen = MLX5_ST_SZ_BYTES(create_rq_in) +
+		sizeof(u64) * ib_umem_num_dma_blocks(umem, page_size);
 	in = kvzalloc(inlen, GFP_KERNEL);
 	if (!in)
 		return -ENOMEM;
@@ -1341,16 +1332,16 @@ static int create_raw_packet_qp_rq(struct mlx5_ib_dev *dev,
 	MLX5_SET(wq, wq, wq_type, MLX5_WQ_TYPE_CYCLIC);
 	if (rq->flags & MLX5_IB_RQ_PCI_WRITE_END_PADDING)
 		MLX5_SET(wq, wq, end_padding_mode, MLX5_WQ_END_PAD_MODE_ALIGN);
-	MLX5_SET(wq, wq, page_offset, MLX5_GET(qpc, qpc, page_offset));
+	MLX5_SET(wq, wq, page_offset, page_offset_quantized);
 	MLX5_SET(wq, wq, pd, MLX5_GET(qpc, qpc, pd));
 	MLX5_SET64(wq, wq, dbr_addr, MLX5_GET64(qpc, qpc, dbr_addr));
 	MLX5_SET(wq, wq, log_wq_stride, MLX5_GET(qpc, qpc, log_rq_stride) + 4);
-	MLX5_SET(wq, wq, log_wq_pg_sz, MLX5_GET(qpc, qpc, log_page_size));
+	MLX5_SET(wq, wq, log_wq_pg_sz,
+		 order_base_2(page_size) - MLX5_ADAPTER_PAGE_SHIFT);
 	MLX5_SET(wq, wq, log_wq_sz, MLX5_GET(qpc, qpc, log_rq_size));
 
 	pas = (__be64 *)MLX5_ADDR_OF(wq, wq, pas);
-	qp_pas = (__be64 *)MLX5_ADDR_OF(create_qp_in, qpin, pas);
-	memcpy(pas, qp_pas, rq_pas_size);
+	mlx5_ib_populate_pas(umem, page_size, pas, 0);
 
 	err = mlx5_core_create_rq_tracked(dev, in, inlen, &rq->base.mqp);
 
@@ -1471,7 +1462,7 @@ static int create_raw_packet_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 			rq->flags |= MLX5_IB_RQ_CVLAN_STRIPPING;
 		if (qp->flags & IB_QP_CREATE_PCI_WRITE_END_PADDING)
 			rq->flags |= MLX5_IB_RQ_PCI_WRITE_END_PADDING;
-		err = create_raw_packet_qp_rq(dev, rq, in, inlen, pd);
+		err = create_raw_packet_qp_rq(dev, rq, in, pd);
 		if (err)
 			goto err_destroy_sq;
 
-- 
2.28.0

