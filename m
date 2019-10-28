Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A51ADE6ECE
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 10:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387875AbfJ1JQA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 05:16:00 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:37887 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387877AbfJ1JP7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 05:15:59 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 28 Oct 2019 11:15:53 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x9S9FqCZ032570;
        Mon, 28 Oct 2019 11:15:53 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id x9S9Fqd5031567;
        Mon, 28 Oct 2019 11:15:52 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id x9S9FqXU031566;
        Mon, 28 Oct 2019 11:15:52 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     yishaih@mellanox.com, haggaie@mellanox.com, jgg@mellanox.com,
        maorg@mellanox.com
Subject: [PATCH rdma-core 5/6] mlx5: Add custom allocation support for DBR
Date:   Mon, 28 Oct 2019 11:14:58 +0200
Message-Id: <1572254099-30864-6-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1572254099-30864-1-git-send-email-yishaih@mellanox.com>
References: <1572254099-30864-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add custom allocation support for DBR by extending the internal
allocation/free flows to consider this option.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 providers/mlx5/dbrec.c  | 34 ++++++++++++++++++++++++++++++++--
 providers/mlx5/mlx5.h   |  9 +++++++--
 providers/mlx5/mlx5dv.h |  1 +
 providers/mlx5/verbs.c  | 47 +++++++++++++++++++++++++++--------------------
 4 files changed, 67 insertions(+), 24 deletions(-)

diff --git a/providers/mlx5/dbrec.c b/providers/mlx5/dbrec.c
index d6a69a5..5ef3d16 100644
--- a/providers/mlx5/dbrec.c
+++ b/providers/mlx5/dbrec.c
@@ -85,12 +85,31 @@ static struct mlx5_db_page *__add_page(struct mlx5_context *context)
 	return page;
 }
 
-__be32 *mlx5_alloc_dbrec(struct mlx5_context *context)
+__be32 *mlx5_alloc_dbrec(struct mlx5_context *context, struct ibv_pd *pd,
+			 bool *custom_alloc)
 {
 	struct mlx5_db_page *page;
 	__be32 *db = NULL;
 	int i, j;
 
+	if (mlx5_is_custom_alloc(pd)) {
+		struct mlx5_parent_domain *mparent_domain = to_mparent_domain(pd);
+
+		db = mparent_domain->alloc(&mparent_domain->mpd.ibv_pd,
+				   mparent_domain->pd_context, 8, 8,
+				   MLX5DV_RES_TYPE_DBR);
+
+		if (db == IBV_ALLOCATOR_USE_DEFAULT)
+			goto default_alloc;
+
+		if (!db)
+			return NULL;
+
+		*custom_alloc = true;
+		return db;
+	}
+
+default_alloc:
 	pthread_mutex_lock(&context->db_list_mutex);
 
 	for (page = context->db_list; page; page = page->next)
@@ -118,12 +137,23 @@ out:
 	return db;
 }
 
-void mlx5_free_db(struct mlx5_context *context, __be32 *db)
+void mlx5_free_db(struct mlx5_context *context, __be32 *db, struct ibv_pd *pd,
+		  bool custom_alloc)
 {
 	struct mlx5_db_page *page;
 	uintptr_t ps = to_mdev(context->ibv_ctx.context.device)->page_size;
 	int i;
 
+	if (custom_alloc) {
+		struct mlx5_parent_domain *mparent_domain = to_mparent_domain(pd);
+
+		mparent_domain->free(&mparent_domain->mpd.ibv_pd,
+				     mparent_domain->pd_context,
+				     db,
+				     MLX5DV_RES_TYPE_DBR);
+		return;
+	}
+
 	pthread_mutex_lock(&context->db_list_mutex);
 
 	for (page = context->db_list; page; page = page->next)
diff --git a/providers/mlx5/mlx5.h b/providers/mlx5/mlx5.h
index 1c13390..9a5cd6b 100644
--- a/providers/mlx5/mlx5.h
+++ b/providers/mlx5/mlx5.h
@@ -438,6 +438,7 @@ struct mlx5_srq {
 	int				waitq_head;
 	int				waitq_tail;
 	__be32			       *db;
+	bool				custom_db;
 	uint16_t			counter;
 	int				wq_sig;
 	struct ibv_qp		       *cmd_qp;
@@ -553,6 +554,7 @@ struct mlx5_qp {
 	struct mlx5_wq                  sq;
 
 	__be32                         *db;
+	bool				custom_db;
 	struct mlx5_wq                  rq;
 	int                             wq_sig;
 	uint32_t			qp_cap_cache;
@@ -582,6 +584,7 @@ struct mlx5_rwq {
 	int buf_size;
 	struct mlx5_wq rq;
 	__be32  *db;
+	bool	custom_db;
 	void	*pbuff;
 	__be32	*recv_db;
 	int wq_sig;
@@ -795,8 +798,10 @@ int mlx5_alloc_buf_extern(struct mlx5_context *ctx, struct mlx5_buf *buf,
 			  size_t size);
 void mlx5_free_buf_extern(struct mlx5_context *ctx, struct mlx5_buf *buf);
 
-__be32 *mlx5_alloc_dbrec(struct mlx5_context *context);
-void mlx5_free_db(struct mlx5_context *context, __be32 *db);
+__be32 *mlx5_alloc_dbrec(struct mlx5_context *context, struct ibv_pd *pd,
+			 bool *custom_alloc);
+void mlx5_free_db(struct mlx5_context *context, __be32 *db, struct ibv_pd *pd,
+		  bool custom_alloc);
 
 int mlx5_query_device(struct ibv_context *context,
 		       struct ibv_device_attr *attr);
diff --git a/providers/mlx5/mlx5dv.h b/providers/mlx5/mlx5dv.h
index 0ad9768..ac291eb 100644
--- a/providers/mlx5/mlx5dv.h
+++ b/providers/mlx5/mlx5dv.h
@@ -62,6 +62,7 @@ extern "C" {
 
 #define MLX5DV_RES_TYPE_QP ((uint64_t)RDMA_DRIVER_MLX5 << 32 | 1)
 #define MLX5DV_RES_TYPE_RWQ ((uint64_t)RDMA_DRIVER_MLX5 << 32 | 2)
+#define MLX5DV_RES_TYPE_DBR ((uint64_t)RDMA_DRIVER_MLX5 << 32 | 3)
 
 enum {
 	MLX5_RCV_DBR	= 0,
diff --git a/providers/mlx5/verbs.c b/providers/mlx5/verbs.c
index 513af5e..1e026af 100644
--- a/providers/mlx5/verbs.c
+++ b/providers/mlx5/verbs.c
@@ -749,7 +749,7 @@ static struct ibv_cq_ex *create_cq(struct ibv_context *context,
 		goto err_spl;
 	}
 
-	cq->dbrec  = mlx5_alloc_dbrec(to_mctx(context));
+	cq->dbrec  = mlx5_alloc_dbrec(to_mctx(context), NULL, NULL);
 	if (!cq->dbrec) {
 		mlx5_dbg(fp, MLX5_DBG_CQ, "\n");
 		goto err_buf;
@@ -834,7 +834,7 @@ static struct ibv_cq_ex *create_cq(struct ibv_context *context,
 	return &cq->ibv_cq;
 
 err_db:
-	mlx5_free_db(to_mctx(context), cq->dbrec);
+	mlx5_free_db(to_mctx(context), cq->dbrec, NULL, 0);
 
 err_buf:
 	mlx5_free_cq_buf(to_mctx(context), &cq->buf_a);
@@ -968,7 +968,7 @@ int mlx5_destroy_cq(struct ibv_cq *cq)
 	if (ret)
 		return ret;
 
-	mlx5_free_db(to_mctx(cq->context), to_mcq(cq)->dbrec);
+	mlx5_free_db(to_mctx(cq->context), to_mcq(cq)->dbrec, NULL, 0);
 	mlx5_free_cq_buf(to_mctx(cq->context), to_mcq(cq)->active_buf);
 	free(to_mcq(cq));
 
@@ -1028,13 +1028,14 @@ struct ibv_srq *mlx5_create_srq(struct ibv_pd *pd,
 		goto err;
 	}
 
-	srq->db = mlx5_alloc_dbrec(to_mctx(pd->context));
+	srq->db = mlx5_alloc_dbrec(to_mctx(pd->context), pd, &srq->custom_db);
 	if (!srq->db) {
 		fprintf(stderr, "%s-%d:\n", __func__, __LINE__);
 		goto err_free;
 	}
 
-	*srq->db = 0;
+	if (!srq->custom_db)
+		*srq->db = 0;
 
 	cmd.buf_addr = (uintptr_t) srq->buf.buf;
 	cmd.db_addr  = (uintptr_t) srq->db;
@@ -1077,7 +1078,7 @@ err_destroy:
 
 err_db:
 	pthread_mutex_unlock(&ctx->srq_table_mutex);
-	mlx5_free_db(to_mctx(pd->context), srq->db);
+	mlx5_free_db(to_mctx(pd->context), srq->db, pd, srq->custom_db);
 
 err_free:
 	free(srq->wrid);
@@ -1128,7 +1129,7 @@ int mlx5_destroy_srq(struct ibv_srq *srq)
 	else
 		mlx5_clear_srq(ctx, msrq->srqn);
 
-	mlx5_free_db(ctx, msrq->db);
+	mlx5_free_db(ctx, msrq->db, srq->pd, msrq->custom_db);
 	mlx5_free_buf(&msrq->buf);
 	free(msrq->tm_list);
 	free(msrq->wrid);
@@ -2033,14 +2034,16 @@ static struct ibv_qp *create_qp(struct ibv_context *context,
 			mlx5_spinlock_init_pd(&qp->rq.lock, attr->pd))
 		goto err_free_qp_buf;
 
-	qp->db = mlx5_alloc_dbrec(ctx);
+	qp->db = mlx5_alloc_dbrec(ctx, attr->pd, &qp->custom_db);
 	if (!qp->db) {
 		mlx5_dbg(fp, MLX5_DBG_QP, "\n");
 		goto err_free_qp_buf;
 	}
 
-	qp->db[MLX5_RCV_DBR] = 0;
-	qp->db[MLX5_SND_DBR] = 0;
+	if (!qp->custom_db) {
+		qp->db[MLX5_RCV_DBR] = 0;
+		qp->db[MLX5_SND_DBR] = 0;
+	}
 
 	cmd.buf_addr = (uintptr_t) qp->buf.buf;
 	cmd.sq_buf_addr = (attr->qp_type == IBV_QPT_RAW_PACKET ||
@@ -2147,7 +2150,7 @@ err_free_uidx:
 		mlx5_clear_uidx(ctx, usr_idx);
 
 err_rq_db:
-	mlx5_free_db(to_mctx(context), qp->db);
+	mlx5_free_db(to_mctx(context), qp->db, attr->pd, qp->custom_db);
 
 err_free_qp_buf:
 	mlx5_free_qp_buf(ctx, qp);
@@ -2270,7 +2273,7 @@ int mlx5_destroy_qp(struct ibv_qp *ibqp)
 		mlx5_clear_uidx(ctx, qp->rsc.rsn);
 
 	if (qp->dc_type != MLX5DV_DCTYPE_DCT) {
-		mlx5_free_db(ctx, qp->db);
+		mlx5_free_db(ctx, qp->db, ibqp->pd, qp->custom_db);
 		mlx5_free_qp_buf(ctx, qp);
 	}
 free:
@@ -2892,13 +2895,14 @@ struct ibv_srq *mlx5_create_srq_ex(struct ibv_context *context,
 		goto err;
 	}
 
-	msrq->db = mlx5_alloc_dbrec(ctx);
+	msrq->db = mlx5_alloc_dbrec(ctx, attr->pd, &msrq->custom_db);
 	if (!msrq->db) {
 		fprintf(stderr, "%s-%d:\n", __func__, __LINE__);
 		goto err_free;
 	}
 
-	*msrq->db = 0;
+	if (!msrq->custom_db)
+		*msrq->db = 0;
 
 	cmd.buf_addr = (uintptr_t)msrq->buf.buf;
 	cmd.db_addr  = (uintptr_t)msrq->db;
@@ -2990,7 +2994,7 @@ err_free_uidx:
 		pthread_mutex_unlock(&ctx->srq_table_mutex);
 
 err_free_db:
-	mlx5_free_db(ctx, msrq->db);
+	mlx5_free_db(ctx, msrq->db, attr->pd, msrq->custom_db);
 
 err_free:
 	free(msrq->wrid);
@@ -3216,12 +3220,15 @@ static struct ibv_wq *create_wq(struct ibv_context *context,
 	if (mlx5_spinlock_init_pd(&rwq->rq.lock, attr->pd))
 		goto err_free_rwq_buf;
 
-	rwq->db = mlx5_alloc_dbrec(ctx);
+	rwq->db = mlx5_alloc_dbrec(ctx, attr->pd, &rwq->custom_db);
 	if (!rwq->db)
 		goto err_free_rwq_buf;
 
-	rwq->db[MLX5_RCV_DBR] = 0;
-	rwq->db[MLX5_SND_DBR] = 0;
+	if (!rwq->custom_db) {
+		rwq->db[MLX5_RCV_DBR] = 0;
+		rwq->db[MLX5_SND_DBR] = 0;
+	}
+
 	rwq->pbuff = rwq->buf.buf + rwq->rq.offset;
 	rwq->recv_db =  &rwq->db[MLX5_RCV_DBR];
 	cmd.buf_addr = (uintptr_t)rwq->buf.buf;
@@ -3278,7 +3285,7 @@ static struct ibv_wq *create_wq(struct ibv_context *context,
 err_create:
 	mlx5_clear_uidx(ctx, cmd.user_index);
 err_free_db_rec:
-	mlx5_free_db(to_mctx(context), rwq->db);
+	mlx5_free_db(to_mctx(context), rwq->db, attr->pd, rwq->custom_db);
 err_free_rwq_buf:
 	mlx5_free_rwq_buf(rwq, context);
 err:
@@ -3342,7 +3349,7 @@ int mlx5_destroy_wq(struct ibv_wq *wq)
 	__mlx5_cq_clean(to_mcq(wq->cq), rwq->rsc.rsn, NULL);
 	mlx5_spin_unlock(&to_mcq(wq->cq)->lock);
 	mlx5_clear_uidx(to_mctx(wq->context), rwq->rsc.rsn);
-	mlx5_free_db(to_mctx(wq->context), rwq->db);
+	mlx5_free_db(to_mctx(wq->context), rwq->db, wq->pd, rwq->custom_db);
 	mlx5_free_rwq_buf(rwq, wq->context);
 	free(rwq);
 
-- 
1.8.3.1

