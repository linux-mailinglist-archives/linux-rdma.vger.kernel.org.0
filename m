Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58AEEE6EC9
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 10:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387876AbfJ1JP7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 05:15:59 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:37884 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387872AbfJ1JP6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 05:15:58 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 28 Oct 2019 11:15:53 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x9S9Frvv032588;
        Mon, 28 Oct 2019 11:15:53 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id x9S9Fqr1031571;
        Mon, 28 Oct 2019 11:15:52 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id x9S9FquJ031570;
        Mon, 28 Oct 2019 11:15:52 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     yishaih@mellanox.com, haggaie@mellanox.com, jgg@mellanox.com,
        maorg@mellanox.com
Subject: [PATCH rdma-core 6/6] mlx5: Add custom allocation support for SRQ buffer
Date:   Mon, 28 Oct 2019 11:14:59 +0200
Message-Id: <1572254099-30864-7-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1572254099-30864-1-git-send-email-yishaih@mellanox.com>
References: <1572254099-30864-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add custom allocation support for SRQ buffer by extending the internal
allocation flow to consider this option.

As part of this change other options that were missed as of "extern
allocator" became applicable as well.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 providers/mlx5/mlx5.h   |  3 ++-
 providers/mlx5/mlx5dv.h |  1 +
 providers/mlx5/srq.c    | 25 ++++++++++++++++++++-----
 providers/mlx5/verbs.c  | 10 +++++-----
 4 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/providers/mlx5/mlx5.h b/providers/mlx5/mlx5.h
index 9a5cd6b..953abe2 100644
--- a/providers/mlx5/mlx5.h
+++ b/providers/mlx5/mlx5.h
@@ -71,6 +71,7 @@ enum {
 #define MLX5_QP_PREFIX "MLX_QP"
 #define MLX5_MR_PREFIX "MLX_MR"
 #define MLX5_RWQ_PREFIX "MLX_RWQ"
+#define MLX5_SRQ_PREFIX "MLX_SRQ"
 #define MLX5_MAX_LOG2_CONTIG_BLOCK_SIZE 23
 #define MLX5_MIN_LOG2_CONTIG_BLOCK_SIZE 12
 
@@ -863,7 +864,7 @@ int mlx5_query_srq(struct ibv_srq *srq,
 			   struct ibv_srq_attr *attr);
 int mlx5_destroy_srq(struct ibv_srq *srq);
 int mlx5_alloc_srq_buf(struct ibv_context *context, struct mlx5_srq *srq,
-		       uint32_t nwr);
+		       uint32_t nwr, struct ibv_pd *pd);
 void mlx5_complete_odp_fault(struct mlx5_srq *srq, int ind);
 void mlx5_free_srq_wqe(struct mlx5_srq *srq, int ind);
 int mlx5_post_srq_recv(struct ibv_srq *ibsrq,
diff --git a/providers/mlx5/mlx5dv.h b/providers/mlx5/mlx5dv.h
index ac291eb..1f49352 100644
--- a/providers/mlx5/mlx5dv.h
+++ b/providers/mlx5/mlx5dv.h
@@ -63,6 +63,7 @@ extern "C" {
 #define MLX5DV_RES_TYPE_QP ((uint64_t)RDMA_DRIVER_MLX5 << 32 | 1)
 #define MLX5DV_RES_TYPE_RWQ ((uint64_t)RDMA_DRIVER_MLX5 << 32 | 2)
 #define MLX5DV_RES_TYPE_DBR ((uint64_t)RDMA_DRIVER_MLX5 << 32 | 3)
+#define MLX5DV_RES_TYPE_SRQ ((uint64_t)RDMA_DRIVER_MLX5 << 32 | 4)
 
 enum {
 	MLX5_RCV_DBR	= 0,
diff --git a/providers/mlx5/srq.c b/providers/mlx5/srq.c
index 1c15656..e9568c6 100644
--- a/providers/mlx5/srq.c
+++ b/providers/mlx5/srq.c
@@ -250,13 +250,14 @@ static void set_srq_buf_ll(struct mlx5_srq *srq, int start, int end)
 }
 
 int mlx5_alloc_srq_buf(struct ibv_context *context, struct mlx5_srq *srq,
-		       uint32_t max_wr)
+		       uint32_t max_wr, struct ibv_pd *pd)
 {
 	int size;
 	int buf_size;
 	struct mlx5_context	   *ctx;
 	uint32_t orig_max_wr = max_wr;
 	bool have_wq = true;
+	enum mlx5_alloc_type alloc_type;
 
 	ctx = to_mctx(context);
 
@@ -296,11 +297,25 @@ int mlx5_alloc_srq_buf(struct ibv_context *context, struct mlx5_srq *srq,
 	srq->max = align_queue_size(max_wr);
 	buf_size = srq->max * size;
 
-	if (mlx5_alloc_buf(&srq->buf, buf_size,
-			   to_mdev(context->device)->page_size))
+	mlx5_get_alloc_type(ctx, pd, MLX5_SRQ_PREFIX, &alloc_type,
+			    MLX5_ALLOC_TYPE_ANON);
+
+	if (alloc_type == MLX5_ALLOC_TYPE_CUSTOM) {
+		srq->buf.mparent_domain = to_mparent_domain(pd);
+		srq->buf.req_alignment = to_mdev(context->device)->page_size;
+		srq->buf.resource_type = MLX5DV_RES_TYPE_SRQ;
+	}
+
+	if (mlx5_alloc_prefered_buf(ctx,
+				    &srq->buf, buf_size,
+				    to_mdev(context->device)->page_size,
+				    alloc_type,
+				    MLX5_SRQ_PREFIX))
 		return -1;
 
-	memset(srq->buf.buf, 0, buf_size);
+	if (srq->buf.type != MLX5_ALLOC_TYPE_CUSTOM)
+		memset(srq->buf.buf, 0, buf_size);
+
 	srq->head = 0;
 	srq->tail = align_queue_size(orig_max_wr + 1) - 1;
 	if (have_wq)  {
@@ -313,7 +328,7 @@ int mlx5_alloc_srq_buf(struct ibv_context *context, struct mlx5_srq *srq,
 
 	srq->wrid = malloc(srq->max * sizeof(*srq->wrid));
 	if (!srq->wrid) {
-		mlx5_free_buf(&srq->buf);
+		mlx5_free_actual_buf(ctx, &srq->buf);
 		return -1;
 	}
 
diff --git a/providers/mlx5/verbs.c b/providers/mlx5/verbs.c
index 1e026af..786a75e 100644
--- a/providers/mlx5/verbs.c
+++ b/providers/mlx5/verbs.c
@@ -1023,7 +1023,7 @@ struct ibv_srq *mlx5_create_srq(struct ibv_pd *pd,
 	srq->max_gs  = attr->attr.max_sge;
 	srq->counter = 0;
 
-	if (mlx5_alloc_srq_buf(pd->context, srq, attr->attr.max_wr)) {
+	if (mlx5_alloc_srq_buf(pd->context, srq, attr->attr.max_wr, pd)) {
 		fprintf(stderr, "%s-%d:\n", __func__, __LINE__);
 		goto err;
 	}
@@ -1082,7 +1082,7 @@ err_db:
 
 err_free:
 	free(srq->wrid);
-	mlx5_free_buf(&srq->buf);
+	mlx5_free_actual_buf(ctx, &srq->buf);
 
 err:
 	free(srq);
@@ -1130,7 +1130,7 @@ int mlx5_destroy_srq(struct ibv_srq *srq)
 		mlx5_clear_srq(ctx, msrq->srqn);
 
 	mlx5_free_db(ctx, msrq->db, srq->pd, msrq->custom_db);
-	mlx5_free_buf(&msrq->buf);
+	mlx5_free_actual_buf(ctx, &msrq->buf);
 	free(msrq->tm_list);
 	free(msrq->wrid);
 	free(msrq->op);
@@ -2890,7 +2890,7 @@ struct ibv_srq *mlx5_create_srq_ex(struct ibv_context *context,
 	msrq->max_gs  = attr->attr.max_sge;
 	msrq->counter = 0;
 
-	if (mlx5_alloc_srq_buf(context, msrq, attr->attr.max_wr)) {
+	if (mlx5_alloc_srq_buf(context, msrq, attr->attr.max_wr, attr->pd)) {
 		fprintf(stderr, "%s-%d:\n", __func__, __LINE__);
 		goto err;
 	}
@@ -2998,7 +2998,7 @@ err_free_db:
 
 err_free:
 	free(msrq->wrid);
-	mlx5_free_buf(&msrq->buf);
+	mlx5_free_actual_buf(ctx, &msrq->buf);
 
 err:
 	free(msrq);
-- 
1.8.3.1

