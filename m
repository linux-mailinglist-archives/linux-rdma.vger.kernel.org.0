Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5427732A823
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Mar 2021 18:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579761AbhCBRKj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Mar 2021 12:10:39 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12667 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343986AbhCBMyG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Mar 2021 07:54:06 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DqcRt35ZKzlRyX;
        Tue,  2 Mar 2021 20:50:34 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Mar 2021 20:52:39 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH rdma-core 3/5] libhns: Support ibv_create_srq_ex
Date:   Tue, 2 Mar 2021 20:50:22 +0800
Message-ID: <1614689424-27154-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1614689424-27154-1-git-send-email-liweihang@huawei.com>
References: <1614689424-27154-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

Implement the ibv_create_srq_ex verbs to support for XRC and more
features in the future.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 providers/hns/hns_roce_u.c       |  23 +++--
 providers/hns/hns_roce_u.h       |  21 +++-
 providers/hns/hns_roce_u_abi.h   |   3 +
 providers/hns/hns_roce_u_verbs.c | 212 +++++++++++++++++++++++++++++++--------
 4 files changed, 208 insertions(+), 51 deletions(-)

diff --git a/providers/hns/hns_roce_u.c b/providers/hns/hns_roce_u.c
index 6def926..d103808b 100644
--- a/providers/hns/hns_roce_u.c
+++ b/providers/hns/hns_roce_u.c
@@ -81,6 +81,7 @@ static const struct verbs_context_ops hns_common_ops = {
 	.reg_mr = hns_roce_u_reg_mr,
 	.rereg_mr = hns_roce_u_rereg_mr,
 	.create_srq = hns_roce_u_create_srq,
+	.create_srq_ex = hns_roce_u_create_srq_ex,
 	.modify_srq = hns_roce_u_modify_srq,
 	.query_srq = hns_roce_u_query_srq,
 	.destroy_srq = hns_roce_u_destroy_srq,
@@ -110,21 +111,29 @@ static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
 				&resp.ibv_resp, sizeof(resp)))
 		goto err_free;
 
+	if (!resp.cqe_size)
+		context->cqe_size = HNS_ROCE_CQE_SIZE;
+	else if (resp.cqe_size <= HNS_ROCE_V3_CQE_SIZE)
+		context->cqe_size = resp.cqe_size;
+	else
+		context->cqe_size = HNS_ROCE_V3_CQE_SIZE;
+
 	context->num_qps = resp.qp_tab_size;
+	context->num_srqs = resp.srq_tab_size;
+
 	context->qp_table_shift = ffs(context->num_qps) - 1 -
 				  HNS_ROCE_QP_TABLE_BITS;
 	context->qp_table_mask = (1 << context->qp_table_shift) - 1;
-
 	pthread_mutex_init(&context->qp_table_mutex, NULL);
 	for (i = 0; i < HNS_ROCE_QP_TABLE_SIZE; ++i)
 		context->qp_table[i].refcnt = 0;
 
-	if (!resp.cqe_size)
-		context->cqe_size = HNS_ROCE_CQE_SIZE;
-	else if (resp.cqe_size <= HNS_ROCE_V3_CQE_SIZE)
-		context->cqe_size = resp.cqe_size;
-	else
-		context->cqe_size = HNS_ROCE_V3_CQE_SIZE;
+	context->srq_table_shift = ffs(context->num_srqs) - 1 -
+				       HNS_ROCE_SRQ_TABLE_BITS;
+	context->srq_table_mask = (1 << context->srq_table_shift) - 1;
+	pthread_mutex_init(&context->srq_table_mutex, NULL);
+	for (i = 0; i < HNS_ROCE_SRQ_TABLE_SIZE; ++i)
+		context->srq_table[i].refcnt = 0;
 
 	if (hns_roce_u_query_device(&context->ibv_ctx.context, NULL,
 				    container_of(&dev_attrs,
diff --git a/providers/hns/hns_roce_u.h b/providers/hns/hns_roce_u.h
index 97e5d54..de6d0f3 100644
--- a/providers/hns/hns_roce_u.h
+++ b/providers/hns/hns_roce_u.h
@@ -105,6 +105,9 @@ enum {
 	HNS_ROCE_QP_TABLE_SIZE		= 1 << HNS_ROCE_QP_TABLE_BITS,
 };
 
+#define HNS_ROCE_SRQ_TABLE_BITS 8
+#define HNS_ROCE_SRQ_TABLE_SIZE BIT(HNS_ROCE_SRQ_TABLE_BITS)
+
 /* operation type list */
 enum {
 	/* rq&srq operation */
@@ -153,13 +156,20 @@ struct hns_roce_context {
 		struct hns_roce_qp	**table;
 		int			refcnt;
 	} qp_table[HNS_ROCE_QP_TABLE_SIZE];
-
 	pthread_mutex_t			qp_table_mutex;
-
 	int				num_qps;
 	int				qp_table_shift;
 	int				qp_table_mask;
 
+	struct {
+		struct hns_roce_srq	**table;
+		int			refcnt;
+	} srq_table[HNS_ROCE_SRQ_TABLE_SIZE];
+	pthread_mutex_t			srq_table_mutex;
+	int				num_srqs;
+	int				srq_table_shift;
+	int				srq_table_mask;
+
 	struct hns_roce_db_page		*db_list[HNS_ROCE_DB_TYPE_NUM];
 	pthread_mutex_t			db_list_mutex;
 
@@ -376,10 +386,15 @@ void hns_roce_u_cq_event(struct ibv_cq *cq);
 
 struct ibv_srq *hns_roce_u_create_srq(struct ibv_pd *pd,
 				      struct ibv_srq_init_attr *srq_init_attr);
+struct ibv_srq *hns_roce_u_create_srq_ex(struct ibv_context *context,
+					 struct ibv_srq_init_attr_ex *attr);
 int hns_roce_u_modify_srq(struct ibv_srq *srq, struct ibv_srq_attr *srq_attr,
 			  int srq_attr_mask);
 int hns_roce_u_query_srq(struct ibv_srq *srq, struct ibv_srq_attr *srq_attr);
-int hns_roce_u_destroy_srq(struct ibv_srq *srq);
+struct hns_roce_srq *hns_roce_find_srq(struct hns_roce_context *ctx,
+				       uint32_t srqn);
+int hns_roce_u_destroy_srq(struct ibv_srq *ibv_srq);
+
 struct ibv_qp *hns_roce_u_create_qp(struct ibv_pd *pd,
 				    struct ibv_qp_init_attr *attr);
 struct ibv_qp *
diff --git a/providers/hns/hns_roce_u_abi.h b/providers/hns/hns_roce_u_abi.h
index 4341207..e56f9d3 100644
--- a/providers/hns/hns_roce_u_abi.h
+++ b/providers/hns/hns_roce_u_abi.h
@@ -53,4 +53,7 @@ DECLARE_DRV_CMD(hns_roce_create_qp_ex, IB_USER_VERBS_EX_CMD_CREATE_QP,
 DECLARE_DRV_CMD(hns_roce_create_srq, IB_USER_VERBS_CMD_CREATE_SRQ,
 		hns_roce_ib_create_srq, hns_roce_ib_create_srq_resp);
 
+DECLARE_DRV_CMD(hns_roce_create_srq_ex, IB_USER_VERBS_CMD_CREATE_XSRQ,
+		hns_roce_ib_create_srq, hns_roce_ib_create_srq_resp);
+
 #endif /* _HNS_ROCE_U_ABI_H */
diff --git a/providers/hns/hns_roce_u_verbs.c b/providers/hns/hns_roce_u_verbs.c
index 3329812..e51b9d5 100644
--- a/providers/hns/hns_roce_u_verbs.c
+++ b/providers/hns/hns_roce_u_verbs.c
@@ -391,6 +391,46 @@ int hns_roce_u_destroy_cq(struct ibv_cq *cq)
 	return ret;
 }
 
+static int hns_roce_store_srq(struct hns_roce_context *ctx,
+			      struct hns_roce_srq *srq)
+{
+	int tind = (srq->srqn & (ctx->num_srqs - 1)) >> ctx->srq_table_shift;
+
+	if (!ctx->srq_table[tind].refcnt) {
+		ctx->srq_table[tind].table =
+					calloc(ctx->srq_table_mask + 1,
+					       sizeof(struct hns_roce_srq *));
+		if (!ctx->srq_table[tind].table)
+			return -ENOMEM;
+	}
+
+	++ctx->srq_table[tind].refcnt;
+	ctx->srq_table[tind].table[srq->srqn & ctx->srq_table_mask] = srq;
+
+	return 0;
+}
+
+struct hns_roce_srq *hns_roce_find_srq(struct hns_roce_context *ctx,
+				       uint32_t srqn)
+{
+	int tind = (srqn & (ctx->num_srqs - 1)) >> ctx->srq_table_shift;
+
+	if (ctx->srq_table[tind].refcnt)
+		return ctx->srq_table[tind].table[srqn & ctx->srq_table_mask];
+	else
+		return NULL;
+}
+
+static void hns_roce_clear_srq(struct hns_roce_context *ctx, uint32_t srqn)
+{
+	int tind = (srqn & (ctx->num_srqs - 1)) >> ctx->srq_table_shift;
+
+	if (!--ctx->srq_table[tind].refcnt)
+		free(ctx->srq_table[tind].table);
+	else
+		ctx->srq_table[tind].table[srqn & ctx->srq_table_mask] = NULL;
+}
+
 static int hns_roce_create_idx_que(struct hns_roce_srq *srq)
 {
 	struct hns_roce_idx_que	*idx_que = &srq->idx_que;
@@ -442,18 +482,71 @@ static int hns_roce_alloc_srq_buf(struct hns_roce_srq *srq)
 	return 0;
 }
 
-struct ibv_srq *hns_roce_u_create_srq(struct ibv_pd *pd,
-				      struct ibv_srq_init_attr *init_attr)
+static int hns_roce_verify_srq(struct hns_roce_context *context,
+			       struct ibv_srq_init_attr_ex *init_attr)
+{
+	if (init_attr->srq_type != IBV_SRQT_BASIC &&
+	    init_attr->srq_type != IBV_SRQT_XRC)
+		return -EINVAL;
+
+	if (!init_attr->attr.max_wr || !init_attr->attr.max_sge ||
+	    init_attr->attr.max_wr > context->max_srq_wr ||
+	    init_attr->attr.max_sge > context->max_srq_sge)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int exec_srq_create_cmd(struct ibv_context *context,
+			       struct hns_roce_srq *srq,
+			       struct ibv_srq_init_attr_ex *init_attr)
+{
+	struct hns_roce_create_srq_resp resp = {};
+	struct hns_roce_create_srq_ex cmd_ex = {};
+	struct hns_roce_ib_create_srq *cmd_drv;
+	struct hns_roce_create_srq cmd = {};
+	bool is_basic_srq;
+	int ret;
+
+	is_basic_srq = (init_attr->srq_type == IBV_SRQT_BASIC) ||
+		       (!(init_attr->comp_mask & IBV_SRQ_INIT_ATTR_TYPE));
+
+	if (is_basic_srq)
+		cmd_drv = &cmd.drv_payload;
+	else
+		cmd_drv = &cmd_ex.drv_payload;
+
+	cmd_drv->buf_addr = (uintptr_t)srq->buf.buf;
+	cmd_drv->que_addr = (uintptr_t)srq->idx_que.buf.buf;
+	cmd_drv->db_addr = (uintptr_t)srq->db;
+
+	if (is_basic_srq)
+		ret = ibv_cmd_create_srq(init_attr->pd, &srq->verbs_srq.srq,
+					 (struct ibv_srq_init_attr *)init_attr,
+					 &cmd.ibv_cmd, sizeof(cmd),
+					 &resp.ibv_resp, sizeof(resp));
+	else
+		ret = ibv_cmd_create_srq_ex(context, &srq->verbs_srq, init_attr,
+					    &cmd_ex.ibv_cmd, sizeof(cmd_ex),
+					    &resp.ibv_resp, sizeof(resp));
+
+	if (ret)
+		return ret;
+
+	srq->srqn = resp.srqn;
+
+	return 0;
+}
+
+static struct ibv_srq *create_srq(struct ibv_context *context,
+				  struct ibv_srq_init_attr_ex *init_attr)
 {
-	struct hns_roce_context *ctx = to_hr_ctx(pd->context);
-	struct hns_roce_create_srq_resp resp;
-	struct hns_roce_create_srq cmd;
+	struct hns_roce_context *ctx = to_hr_ctx(context);
+	struct ibv_srq_attr *attr = &init_attr->attr;
 	struct hns_roce_srq *srq;
 	int ret;
 
-	if (!init_attr->attr.max_wr || !init_attr->attr.max_sge ||
-	    init_attr->attr.max_wr > ctx->max_srq_wr ||
-	    init_attr->attr.max_sge > ctx->max_srq_sge)
+	if (hns_roce_verify_srq(ctx, init_attr))
 		return NULL;
 
 	srq = calloc(1, sizeof(*srq));
@@ -461,48 +554,52 @@ struct ibv_srq *hns_roce_u_create_srq(struct ibv_pd *pd,
 		return NULL;
 
 	if (pthread_spin_init(&srq->lock, PTHREAD_PROCESS_PRIVATE))
-		goto out;
+		goto err_free_srq;
 
-	if (to_hr_dev(pd->context->device)->hw_version == HNS_ROCE_HW_VER2)
+	if (to_hr_dev(context->device)->hw_version == HNS_ROCE_HW_VER2)
 		srq->rsv_sge = 1;
 
-	srq->wqe_cnt = roundup_pow_of_two(init_attr->attr.max_wr + 1);
-	srq->max_gs = roundup_pow_of_two(init_attr->attr.max_sge + srq->rsv_sge);
-	init_attr->attr.max_sge = srq->max_gs;
+	srq->wqe_cnt = roundup_pow_of_two(attr->max_wr + 1);
+	srq->max_gs = roundup_pow_of_two(attr->max_sge + srq->rsv_sge);
+	attr->max_sge = srq->max_gs;
 
 	ret = hns_roce_create_idx_que(srq);
 	if (ret)
-		goto out;
+		goto err_free_srq;
 
 	ret = hns_roce_alloc_srq_buf(srq);
 	if (ret)
 		goto err_idx_que;
 
-	srq->db = hns_roce_alloc_db(to_hr_ctx(pd->context),
-				    HNS_ROCE_QP_TYPE_DB);
+	srq->db = hns_roce_alloc_db(ctx, HNS_ROCE_QP_TYPE_DB);
 	if (!srq->db)
 		goto err_srq_buf;
 
 	*(srq->db) = 0;
-	cmd.buf_addr = (uintptr_t)srq->buf.buf;
-	cmd.que_addr = (uintptr_t)srq->idx_que.buf.buf;
-	cmd.db_addr = (uintptr_t)srq->db;
 
-	ret = ibv_cmd_create_srq(pd, &srq->verbs_srq.srq, init_attr,
-				&cmd.ibv_cmd, sizeof(cmd), &resp.ibv_resp,
-				sizeof(resp));
+	pthread_mutex_lock(&ctx->srq_table_mutex);
+
+	ret = exec_srq_create_cmd(context, srq, init_attr);
 	if (ret)
 		goto err_srq_db;
 
-	srq->srqn = resp.srqn;
-	srq->max_gs = init_attr->attr.max_sge;
-	init_attr->attr.max_sge =
-		min(init_attr->attr.max_sge - srq->rsv_sge, ctx->max_srq_sge);
+	ret = hns_roce_store_srq(ctx, srq);
+	if (ret)
+		goto err_destroy_srq;
+
+	pthread_mutex_unlock(&ctx->srq_table_mutex);
+
+	srq->max_gs = attr->max_sge;
+	attr->max_sge = min(attr->max_sge - srq->rsv_sge, ctx->max_srq_sge);
 
 	return &srq->verbs_srq.srq;
 
+err_destroy_srq:
+	ibv_cmd_destroy_srq(&srq->verbs_srq.srq);
+
 err_srq_db:
-	hns_roce_free_db(to_hr_ctx(pd->context), srq->db, HNS_ROCE_QP_TYPE_DB);
+	pthread_mutex_unlock(&ctx->srq_table_mutex);
+	hns_roce_free_db(ctx, srq->db, HNS_ROCE_QP_TYPE_DB);
 
 err_srq_buf:
 	free(srq->wrid);
@@ -511,11 +608,35 @@ err_srq_buf:
 err_idx_que:
 	free(srq->idx_que.bitmap);
 	hns_roce_free_buf(&srq->idx_que.buf);
-out:
+
+err_free_srq:
 	free(srq);
+
 	return NULL;
 }
 
+struct ibv_srq *hns_roce_u_create_srq(struct ibv_pd *pd,
+				      struct ibv_srq_init_attr *attr)
+{
+	struct ibv_srq_init_attr_ex attrx = {};
+	struct ibv_srq *srq;
+
+	memcpy(&attrx, attr, sizeof(*attr));
+	attrx.pd = pd;
+
+	srq = create_srq(pd->context, &attrx);
+	if (srq)
+		memcpy(attr, &attrx, sizeof(*attr));
+
+	return srq;
+}
+
+struct ibv_srq *hns_roce_u_create_srq_ex(struct ibv_context *context,
+					 struct ibv_srq_init_attr_ex *attr)
+{
+	return create_srq(context, attr);
+}
+
 int hns_roce_u_modify_srq(struct ibv_srq *srq, struct ibv_srq_attr *srq_attr,
 			  int srq_attr_mask)
 {
@@ -536,21 +657,30 @@ int hns_roce_u_query_srq(struct ibv_srq *srq, struct ibv_srq_attr *srq_attr)
 	return ret;
 }
 
-int hns_roce_u_destroy_srq(struct ibv_srq *srq)
+int hns_roce_u_destroy_srq(struct ibv_srq *ibv_srq)
 {
+	struct hns_roce_context *ctx = to_hr_ctx(ibv_srq->context);
+	struct hns_roce_srq *srq = to_hr_srq(ibv_srq);
 	int ret;
 
-	ret = ibv_cmd_destroy_srq(srq);
-	if (ret)
+	pthread_mutex_lock(&ctx->srq_table_mutex);
+
+	ret = ibv_cmd_destroy_srq(ibv_srq);
+	if (ret) {
+		pthread_mutex_unlock(&ctx->srq_table_mutex);
 		return ret;
+	}
+
+	hns_roce_clear_srq(ctx, srq->srqn);
 
-	hns_roce_free_db(to_hr_ctx(srq->context), to_hr_srq(srq)->db,
-			 HNS_ROCE_QP_TYPE_DB);
-	hns_roce_free_buf(&to_hr_srq(srq)->buf);
-	free(to_hr_srq(srq)->wrid);
-	hns_roce_free_buf(&to_hr_srq(srq)->idx_que.buf);
-	free(to_hr_srq(srq)->idx_que.bitmap);
-	free(to_hr_srq(srq));
+	pthread_mutex_unlock(&ctx->srq_table_mutex);
+
+	hns_roce_free_db(ctx, srq->db, HNS_ROCE_QP_TYPE_DB);
+	hns_roce_free_buf(&srq->buf);
+	free(srq->wrid);
+	hns_roce_free_buf(&srq->idx_que.buf);
+	free(srq->idx_que.bitmap);
+	free(srq);
 
 	return 0;
 }
@@ -868,9 +998,9 @@ static int qp_alloc_db(struct ibv_qp_init_attr_ex *attr, struct hns_roce_qp *qp,
 	return 0;
 }
 
-static int hns_roce_store_qp(struct hns_roce_context *ctx, uint32_t qpn,
-			     struct hns_roce_qp *qp)
+static int hns_roce_store_qp(struct hns_roce_context *ctx, struct hns_roce_qp *qp)
 {
+	uint32_t qpn = qp->verbs_qp.qp.qp_num;
 	uint32_t tind = (qpn & (ctx->num_qps - 1)) >> ctx->qp_table_shift;
 
 	pthread_mutex_lock(&ctx->qp_table_mutex);
@@ -987,7 +1117,7 @@ static struct ibv_qp *create_qp(struct ibv_context *ibv_ctx,
 	if (ret)
 		goto err_cmd;
 
-	ret = hns_roce_store_qp(context, qp->verbs_qp.qp.qp_num, qp);
+	ret = hns_roce_store_qp(context, qp);
 	if (ret)
 		goto err_store;
 
-- 
2.8.1

