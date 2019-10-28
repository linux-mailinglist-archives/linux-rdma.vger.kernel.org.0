Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11C5CE6ECF
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 10:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387874AbfJ1JQA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 05:16:00 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:37889 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727664AbfJ1JP7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 05:15:59 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 28 Oct 2019 11:15:53 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x9S9FqC7032542;
        Mon, 28 Oct 2019 11:15:52 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id x9S9Fqio031563;
        Mon, 28 Oct 2019 11:15:52 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id x9S9FqJE031562;
        Mon, 28 Oct 2019 11:15:52 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     yishaih@mellanox.com, haggaie@mellanox.com, jgg@mellanox.com,
        maorg@mellanox.com
Subject: [PATCH rdma-core 4/6] mlx5: Add custom allocation support for QP and RWQ buffers
Date:   Mon, 28 Oct 2019 11:14:57 +0200
Message-Id: <1572254099-30864-5-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1572254099-30864-1-git-send-email-yishaih@mellanox.com>
References: <1572254099-30864-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add custom allocation support for QP and RWQ buffers by extending the
internal allocation flows to consider this option.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 providers/mlx5/buf.c    | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
 providers/mlx5/cq.c     |  2 +-
 providers/mlx5/mlx5.h   |  6 +++++
 providers/mlx5/mlx5dv.h |  4 ++++
 providers/mlx5/verbs.c  | 34 +++++++++++++++++++++++-----
 5 files changed, 98 insertions(+), 7 deletions(-)

diff --git a/providers/mlx5/buf.c b/providers/mlx5/buf.c
index aa2fe02..b5cf391 100644
--- a/providers/mlx5/buf.c
+++ b/providers/mlx5/buf.c
@@ -356,6 +356,40 @@ int mlx5_alloc_buf_extern(struct mlx5_context *ctx, struct mlx5_buf *buf,
 	return -1;
 }
 
+static void mlx5_free_buf_custom(struct mlx5_context *ctx,
+			  struct mlx5_buf *buf)
+{
+	struct mlx5_parent_domain *mparent_domain = buf->mparent_domain;
+
+	mparent_domain->free(&mparent_domain->mpd.ibv_pd,
+			     mparent_domain->pd_context,
+			     buf->buf,
+			     buf->resource_type);
+}
+
+static int mlx5_alloc_buf_custom(struct mlx5_context *ctx,
+			  struct mlx5_buf *buf, size_t size)
+{
+	struct mlx5_parent_domain *mparent_domain = buf->mparent_domain;
+	void *addr;
+
+	addr = mparent_domain->alloc(&mparent_domain->mpd.ibv_pd,
+				   mparent_domain->pd_context, size,
+				   buf->req_alignment,
+				   buf->resource_type);
+	if (addr == IBV_ALLOCATOR_USE_DEFAULT)
+		return 1;
+
+	if (addr || size == 0) {
+		buf->buf = addr;
+		buf->length = size;
+		buf->type = MLX5_ALLOC_TYPE_CUSTOM;
+		return 0;
+	}
+
+	return -1;
+}
+
 int mlx5_alloc_prefered_buf(struct mlx5_context *mctx,
 			    struct mlx5_buf *buf,
 			    size_t size, int page_size,
@@ -364,6 +398,14 @@ int mlx5_alloc_prefered_buf(struct mlx5_context *mctx,
 {
 	int ret;
 
+	if (type == MLX5_ALLOC_TYPE_CUSTOM) {
+		ret = mlx5_alloc_buf_custom(mctx, buf, size);
+		if (ret <= 0)
+			return ret;
+
+		/* Fallback - default allocation is required */
+	}
+
 	/*
 	 * Fallback mechanism priority:
 	 *	huge pages
@@ -426,6 +468,10 @@ int mlx5_free_actual_buf(struct mlx5_context *ctx, struct mlx5_buf *buf)
 		mlx5_free_buf_extern(ctx, buf);
 		break;
 
+	case MLX5_ALLOC_TYPE_CUSTOM:
+		mlx5_free_buf_custom(ctx, buf);
+		break;
+
 	default:
 		fprintf(stderr, "Bad allocation type\n");
 	}
@@ -458,12 +504,20 @@ static uint32_t mlx5_get_block_order(uint32_t v)
 	return r;
 }
 
+bool mlx5_is_custom_alloc(struct ibv_pd *pd)
+{
+	struct mlx5_parent_domain *mparent_domain = to_mparent_domain(pd);
+
+	return (mparent_domain && mparent_domain->alloc && mparent_domain->free);
+}
+
 bool mlx5_is_extern_alloc(struct mlx5_context *context)
 {
 	return context->extern_alloc.alloc && context->extern_alloc.free;
 }
 
 void mlx5_get_alloc_type(struct mlx5_context *context,
+			 struct ibv_pd *pd,
 			 const char *component,
 			 enum mlx5_alloc_type *alloc_type,
 			 enum mlx5_alloc_type default_type)
@@ -472,6 +526,11 @@ void mlx5_get_alloc_type(struct mlx5_context *context,
 	char *env_value;
 	char name[128];
 
+	if (mlx5_is_custom_alloc(pd)) {
+		*alloc_type = MLX5_ALLOC_TYPE_CUSTOM;
+		return;
+	}
+
 	if (mlx5_is_extern_alloc(context)) {
 		*alloc_type = MLX5_ALLOC_TYPE_EXTERNAL;
 		return;
diff --git a/providers/mlx5/cq.c b/providers/mlx5/cq.c
index b9b47df..26edd86 100644
--- a/providers/mlx5/cq.c
+++ b/providers/mlx5/cq.c
@@ -1861,7 +1861,7 @@ int mlx5_alloc_cq_buf(struct mlx5_context *mctx, struct mlx5_cq *cq,
 	if (mlx5_use_huge("HUGE_CQ"))
 		default_type = MLX5_ALLOC_TYPE_HUGE;
 
-	mlx5_get_alloc_type(mctx, MLX5_CQ_PREFIX, &type, default_type);
+	mlx5_get_alloc_type(mctx, NULL, MLX5_CQ_PREFIX, &type, default_type);
 
 	ret = mlx5_alloc_prefered_buf(mctx, buf,
 				      align(nent * cqe_sz, dev->page_size),
diff --git a/providers/mlx5/mlx5.h b/providers/mlx5/mlx5.h
index e960e6f..1c13390 100644
--- a/providers/mlx5/mlx5.h
+++ b/providers/mlx5/mlx5.h
@@ -173,6 +173,7 @@ enum mlx5_alloc_type {
 	MLX5_ALLOC_TYPE_PREFER_HUGE,
 	MLX5_ALLOC_TYPE_PREFER_CONTIG,
 	MLX5_ALLOC_TYPE_EXTERNAL,
+	MLX5_ALLOC_TYPE_CUSTOM,
 	MLX5_ALLOC_TYPE_ALL
 };
 
@@ -334,6 +335,9 @@ struct mlx5_buf {
 	int                             base;
 	struct mlx5_hugetlb_mem	       *hmem;
 	enum mlx5_alloc_type		type;
+	uint64_t			resource_type;
+	size_t				req_alignment;
+	struct mlx5_parent_domain	*mparent_domain;
 };
 
 struct mlx5_td {
@@ -780,10 +784,12 @@ int mlx5_alloc_prefered_buf(struct mlx5_context *mctx,
 			    const char *component);
 int mlx5_free_actual_buf(struct mlx5_context *ctx, struct mlx5_buf *buf);
 void mlx5_get_alloc_type(struct mlx5_context *context,
+			 struct ibv_pd *pd,
 			 const char *component,
 			 enum mlx5_alloc_type *alloc_type,
 			 enum mlx5_alloc_type default_alloc_type);
 int mlx5_use_huge(const char *key);
+bool mlx5_is_custom_alloc(struct ibv_pd *pd);
 bool mlx5_is_extern_alloc(struct mlx5_context *context);
 int mlx5_alloc_buf_extern(struct mlx5_context *ctx, struct mlx5_buf *buf,
 			  size_t size);
diff --git a/providers/mlx5/mlx5dv.h b/providers/mlx5/mlx5dv.h
index d5e8e0c..0ad9768 100644
--- a/providers/mlx5/mlx5dv.h
+++ b/providers/mlx5/mlx5dv.h
@@ -59,6 +59,10 @@ extern "C" {
 #define MLX5DV_ALWAYS_INLINE inline
 #endif
 
+
+#define MLX5DV_RES_TYPE_QP ((uint64_t)RDMA_DRIVER_MLX5 << 32 | 1)
+#define MLX5DV_RES_TYPE_RWQ ((uint64_t)RDMA_DRIVER_MLX5 << 32 | 2)
+
 enum {
 	MLX5_RCV_DBR	= 0,
 	MLX5_SND_DBR	= 1,
diff --git a/providers/mlx5/verbs.c b/providers/mlx5/verbs.c
index 166ea4f..513af5e 100644
--- a/providers/mlx5/verbs.c
+++ b/providers/mlx5/verbs.c
@@ -1554,8 +1554,14 @@ static int mlx5_alloc_qp_buf(struct ibv_context *context,
 	if (mlx5_use_huge(qp_huge_key))
 		default_alloc_type = MLX5_ALLOC_TYPE_HUGE;
 
-	mlx5_get_alloc_type(to_mctx(context), MLX5_QP_PREFIX, &alloc_type,
-			    default_alloc_type);
+	mlx5_get_alloc_type(to_mctx(context), attr->pd, MLX5_QP_PREFIX,
+			    &alloc_type, default_alloc_type);
+
+	if (alloc_type == MLX5_ALLOC_TYPE_CUSTOM) {
+		qp->buf.mparent_domain = to_mparent_domain(attr->pd);
+		qp->buf.req_alignment = to_mdev(context->device)->page_size;
+		qp->buf.resource_type = MLX5DV_RES_TYPE_QP;
+	}
 
 	err = mlx5_alloc_prefered_buf(to_mctx(context), &qp->buf,
 				      align(qp->buf_size, to_mdev
@@ -1569,12 +1575,20 @@ static int mlx5_alloc_qp_buf(struct ibv_context *context,
 		goto ex_wrid;
 	}
 
-	memset(qp->buf.buf, 0, qp->buf_size);
+	if (qp->buf.type != MLX5_ALLOC_TYPE_CUSTOM)
+		memset(qp->buf.buf, 0, qp->buf_size);
 
 	if (attr->qp_type == IBV_QPT_RAW_PACKET ||
 	    qp->flags & MLX5_QP_FLAGS_USE_UNDERLAY) {
 		size_t aligned_sq_buf_size = align(qp->sq_buf_size,
 						   to_mdev(context->device)->page_size);
+
+		if (alloc_type == MLX5_ALLOC_TYPE_CUSTOM) {
+			qp->sq_buf.mparent_domain = to_mparent_domain(attr->pd);
+			qp->sq_buf.req_alignment = to_mdev(context->device)->page_size;
+			qp->sq_buf.resource_type = MLX5DV_RES_TYPE_QP;
+		}
+
 		/* For Raw Packet QP, allocate a separate buffer for the SQ */
 		err = mlx5_alloc_prefered_buf(to_mctx(context), &qp->sq_buf,
 					      aligned_sq_buf_size,
@@ -1586,7 +1600,8 @@ static int mlx5_alloc_qp_buf(struct ibv_context *context,
 			goto rq_buf;
 		}
 
-		memset(qp->sq_buf.buf, 0, aligned_sq_buf_size);
+		if (qp->sq_buf.type != MLX5_ALLOC_TYPE_CUSTOM)
+			memset(qp->sq_buf.buf, 0, aligned_sq_buf_size);
 	}
 
 	return 0;
@@ -3121,13 +3136,14 @@ static void mlx5_free_rwq_buf(struct mlx5_rwq *rwq, struct ibv_context *context)
 }
 
 static int mlx5_alloc_rwq_buf(struct ibv_context *context,
+			      struct ibv_pd *pd,
 			      struct mlx5_rwq *rwq,
 			      int size)
 {
 	int err;
 	enum mlx5_alloc_type alloc_type;
 
-	mlx5_get_alloc_type(to_mctx(context), MLX5_RWQ_PREFIX,
+	mlx5_get_alloc_type(to_mctx(context), pd, MLX5_RWQ_PREFIX,
 			    &alloc_type, MLX5_ALLOC_TYPE_ANON);
 
 	rwq->rq.wrid = malloc(rwq->rq.wqe_cnt * sizeof(uint64_t));
@@ -3136,6 +3152,12 @@ static int mlx5_alloc_rwq_buf(struct ibv_context *context,
 		return -1;
 	}
 
+	if (alloc_type == MLX5_ALLOC_TYPE_CUSTOM) {
+		rwq->buf.mparent_domain = to_mparent_domain(pd);
+		rwq->buf.req_alignment = to_mdev(context->device)->page_size;
+		rwq->buf.resource_type = MLX5DV_RES_TYPE_RWQ;
+	}
+
 	err = mlx5_alloc_prefered_buf(to_mctx(context), &rwq->buf,
 				      align(rwq->buf_size, to_mdev
 				      (context->device)->page_size),
@@ -3186,7 +3208,7 @@ static struct ibv_wq *create_wq(struct ibv_context *context,
 	}
 
 	rwq->buf_size = ret;
-	if (mlx5_alloc_rwq_buf(context, rwq, ret))
+	if (mlx5_alloc_rwq_buf(context, attr->pd, rwq, ret))
 		goto err;
 
 	mlx5_init_rwq_indices(rwq);
-- 
1.8.3.1

