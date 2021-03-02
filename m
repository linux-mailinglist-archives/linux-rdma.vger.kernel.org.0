Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7820C32A822
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Mar 2021 18:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579825AbhCBRKg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Mar 2021 12:10:36 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12669 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345729AbhCBMyG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Mar 2021 07:54:06 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DqcRt3scQzlRxn;
        Tue,  2 Mar 2021 20:50:34 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Mar 2021 20:52:38 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH rdma-core 2/5] libhns: Support ibv_create_qp_ex
Date:   Tue, 2 Mar 2021 20:50:21 +0800
Message-ID: <1614689424-27154-3-git-send-email-liweihang@huawei.com>
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

From: Lang Cheng <chenglang@huawei.com>

Implement the ibv_create_qp_ex verbs to support more feature in the future.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 providers/hns/hns_roce_u.c       |   1 +
 providers/hns/hns_roce_u.h       |   9 ++-
 providers/hns/hns_roce_u_abi.h   |   8 ++-
 providers/hns/hns_roce_u_hw_v1.c |  18 ++---
 providers/hns/hns_roce_u_hw_v2.c |  28 ++++----
 providers/hns/hns_roce_u_verbs.c | 147 ++++++++++++++++++++++++++-------------
 6 files changed, 133 insertions(+), 78 deletions(-)

diff --git a/providers/hns/hns_roce_u.c b/providers/hns/hns_roce_u.c
index b5e9120..6def926 100644
--- a/providers/hns/hns_roce_u.c
+++ b/providers/hns/hns_roce_u.c
@@ -69,6 +69,7 @@ static const struct verbs_context_ops hns_common_ops = {
 	.cq_event = hns_roce_u_cq_event,
 	.create_cq = hns_roce_u_create_cq,
 	.create_qp = hns_roce_u_create_qp,
+	.create_qp_ex = hns_roce_u_create_qp_ex,
 	.dealloc_mw = hns_roce_u_dealloc_mw,
 	.dealloc_pd = hns_roce_u_free_pd,
 	.dereg_mr = hns_roce_u_dereg_mr,
diff --git a/providers/hns/hns_roce_u.h b/providers/hns/hns_roce_u.h
index 959f40f..97e5d54 100644
--- a/providers/hns/hns_roce_u.h
+++ b/providers/hns/hns_roce_u.h
@@ -257,7 +257,7 @@ struct hns_roce_rinl_buf {
 };
 
 struct hns_roce_qp {
-	struct ibv_qp			ibv_qp;
+	struct verbs_qp			verbs_qp;
 	struct hns_roce_buf		buf;
 	int				max_inline_data;
 	int				buf_size;
@@ -336,9 +336,9 @@ static inline struct hns_roce_srq *to_hr_srq(struct ibv_srq *ibv_srq)
 			    struct hns_roce_srq, verbs_srq);
 }
 
-static inline struct  hns_roce_qp *to_hr_qp(struct ibv_qp *ibv_qp)
+static inline struct hns_roce_qp *to_hr_qp(struct ibv_qp *ibv_qp)
 {
-	return container_of(ibv_qp, struct hns_roce_qp, ibv_qp);
+	return container_of(ibv_qp, struct hns_roce_qp, verbs_qp.qp);
 }
 
 static inline struct hns_roce_ah *to_hr_ah(struct ibv_ah *ibv_ah)
@@ -382,6 +382,9 @@ int hns_roce_u_query_srq(struct ibv_srq *srq, struct ibv_srq_attr *srq_attr);
 int hns_roce_u_destroy_srq(struct ibv_srq *srq);
 struct ibv_qp *hns_roce_u_create_qp(struct ibv_pd *pd,
 				    struct ibv_qp_init_attr *attr);
+struct ibv_qp *
+hns_roce_u_create_qp_ex(struct ibv_context *context,
+			struct ibv_qp_init_attr_ex *qp_init_attr_ex);
 
 int hns_roce_u_query_qp(struct ibv_qp *ibqp, struct ibv_qp_attr *attr,
 			int attr_mask, struct ibv_qp_init_attr *init_attr);
diff --git a/providers/hns/hns_roce_u_abi.h b/providers/hns/hns_roce_u_abi.h
index 79fd7dd..4341207 100644
--- a/providers/hns/hns_roce_u_abi.h
+++ b/providers/hns/hns_roce_u_abi.h
@@ -41,11 +41,15 @@ DECLARE_DRV_CMD(hns_roce_alloc_pd, IB_USER_VERBS_CMD_ALLOC_PD,
 		empty, hns_roce_ib_alloc_pd_resp);
 DECLARE_DRV_CMD(hns_roce_create_cq, IB_USER_VERBS_CMD_CREATE_CQ,
 		hns_roce_ib_create_cq, hns_roce_ib_create_cq_resp);
-DECLARE_DRV_CMD(hns_roce_create_qp, IB_USER_VERBS_CMD_CREATE_QP,
-		hns_roce_ib_create_qp, hns_roce_ib_create_qp_resp);
 DECLARE_DRV_CMD(hns_roce_alloc_ucontext, IB_USER_VERBS_CMD_GET_CONTEXT,
 		empty, hns_roce_ib_alloc_ucontext_resp);
 
+DECLARE_DRV_CMD(hns_roce_create_qp, IB_USER_VERBS_CMD_CREATE_QP,
+		hns_roce_ib_create_qp, hns_roce_ib_create_qp_resp);
+
+DECLARE_DRV_CMD(hns_roce_create_qp_ex, IB_USER_VERBS_EX_CMD_CREATE_QP,
+		hns_roce_ib_create_qp, hns_roce_ib_create_qp_resp);
+
 DECLARE_DRV_CMD(hns_roce_create_srq, IB_USER_VERBS_CMD_CREATE_SRQ,
 		hns_roce_ib_create_srq, hns_roce_ib_create_srq_resp);
 
diff --git a/providers/hns/hns_roce_u_hw_v1.c b/providers/hns/hns_roce_u_hw_v1.c
index 652301b..8f0a71a 100644
--- a/providers/hns/hns_roce_u_hw_v1.c
+++ b/providers/hns/hns_roce_u_hw_v1.c
@@ -268,7 +268,7 @@ static int hns_roce_v1_poll_one(struct hns_roce_cq *cq,
 
 	/* if qp is zero, it will not get the correct qpn */
 	if (!*cur_qp ||
-	    (local_qpn & HNS_ROCE_CQE_QPN_MASK) != (*cur_qp)->ibv_qp.qp_num) {
+	    (local_qpn & HNS_ROCE_CQE_QPN_MASK) != (*cur_qp)->verbs_qp.qp.qp_num) {
 
 		*cur_qp = hns_roce_find_qp(to_hr_ctx(cq->ibv_cq.context),
 					   qpn & 0xffffff);
@@ -463,7 +463,7 @@ static int hns_roce_u_v1_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
 		if (hns_roce_wq_overflow(&qp->sq, nreq,
-					 to_hr_cq(qp->ibv_qp.send_cq))) {
+					 to_hr_cq(qp->verbs_qp.qp.send_cq))) {
 			ret = -1;
 			*bad_wr = wr;
 			goto out;
@@ -572,9 +572,10 @@ out:
 	if (likely(nreq)) {
 		qp->sq.head += nreq;
 
-		hns_roce_update_sq_head(ctx, qp->ibv_qp.qp_num,
-				qp->port_num - 1, qp->sl,
-				qp->sq.head & ((qp->sq.wqe_cnt << 1) - 1));
+		hns_roce_update_sq_head(ctx, qp->verbs_qp.qp.qp_num,
+					qp->port_num - 1, qp->sl,
+					qp->sq.head & ((qp->sq.wqe_cnt << 1) -
+					1));
 	}
 
 	pthread_spin_unlock(&qp->sq.lock);
@@ -740,7 +741,7 @@ static int hns_roce_u_v1_post_recv(struct ibv_qp *ibvqp, struct ibv_recv_wr *wr,
 
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
 		if (hns_roce_wq_overflow(&qp->rq, nreq,
-					 to_hr_cq(qp->ibv_qp.recv_cq))) {
+					 to_hr_cq(qp->verbs_qp.qp.recv_cq))) {
 			ret = -1;
 			*bad_wr = wr;
 			goto out;
@@ -802,8 +803,9 @@ out:
 	if (nreq) {
 		qp->rq.head += nreq;
 
-		hns_roce_update_rq_head(ctx, qp->ibv_qp.qp_num,
-				    qp->rq.head & ((qp->rq.wqe_cnt << 1) - 1));
+		hns_roce_update_rq_head(ctx, qp->verbs_qp.qp.qp_num,
+					qp->rq.head & ((qp->rq.wqe_cnt << 1) -
+					1));
 	}
 
 	pthread_spin_unlock(&qp->rq.lock);
diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
index c5c2f12..0b2e31e 100644
--- a/providers/hns/hns_roce_u_hw_v2.c
+++ b/providers/hns/hns_roce_u_hw_v2.c
@@ -367,18 +367,15 @@ static int hns_roce_flush_cqe(struct hns_roce_qp **cur_qp, struct ibv_wc *wc)
 {
 	struct ibv_qp_attr attr;
 	int attr_mask;
-	int ret;
 
 	if ((wc->status != IBV_WC_SUCCESS) &&
 	    (wc->status != IBV_WC_WR_FLUSH_ERR)) {
 		attr_mask = IBV_QP_STATE;
 		attr.qp_state = IBV_QPS_ERR;
-		ret = hns_roce_u_v2_modify_qp(&(*cur_qp)->ibv_qp,
-						      &attr, attr_mask);
-		if (ret)
-			fprintf(stderr, PFX "failed to modify qp!\n");
+		hns_roce_u_v2_modify_qp(&(*cur_qp)->verbs_qp.qp, &attr,
+					attr_mask);
 
-		(*cur_qp)->ibv_qp.state = IBV_QPS_ERR;
+		(*cur_qp)->verbs_qp.qp.state = IBV_QPS_ERR;
 	}
 
 	return V2_CQ_OK;
@@ -468,8 +465,8 @@ static int hns_roce_handle_recv_inl_wqe(struct hns_roce_v2_cqe *cqe,
 					struct hns_roce_qp **cur_qp,
 					struct ibv_wc *wc, uint32_t opcode)
 {
-	if (((*cur_qp)->ibv_qp.qp_type == IBV_QPT_RC ||
-	    (*cur_qp)->ibv_qp.qp_type == IBV_QPT_UC) &&
+	if (((*cur_qp)->verbs_qp.qp.qp_type == IBV_QPT_RC ||
+	     (*cur_qp)->verbs_qp.qp.qp_type == IBV_QPT_UC) &&
 	    (opcode == HNS_ROCE_RECV_OP_SEND ||
 	     opcode == HNS_ROCE_RECV_OP_SEND_WITH_IMM ||
 	     opcode == HNS_ROCE_RECV_OP_SEND_WITH_INV) &&
@@ -539,17 +536,16 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *cq,
 		   HNS_ROCE_V2_CQE_IS_SQ);
 
 	/* if qp is zero, it will not get the correct qpn */
-	if (!*cur_qp || qpn != (*cur_qp)->ibv_qp.qp_num) {
+	if (!*cur_qp || qpn != (*cur_qp)->verbs_qp.qp.qp_num) {
 		*cur_qp = hns_roce_v2_find_qp(to_hr_ctx(cq->ibv_cq.context),
 					      qpn);
-		if (!*cur_qp) {
-			fprintf(stderr, PFX "can't find qp!\n");
+		if (!*cur_qp)
 			return V2_CQ_POLL_ERR;
-		}
 	}
 	wc->qp_num = qpn;
 
-	srq = (*cur_qp)->ibv_qp.srq ? to_hr_srq((*cur_qp)->ibv_qp.srq) : NULL;
+	srq = (*cur_qp)->verbs_qp.qp.srq ?
+				to_hr_srq((*cur_qp)->verbs_qp.qp.srq) : NULL;
 	if (is_send) {
 		wq = &(*cur_qp)->sq;
 		/*
@@ -710,7 +706,7 @@ static void set_sge(struct hns_roce_v2_wqe_data_seg *dseg,
 
 		/* No inner sge in UD wqe */
 		if (sge_info->valid_num <= HNS_ROCE_SGE_IN_WQE &&
-		    qp->ibv_qp.qp_type != IBV_QPT_UD) {
+		    qp->verbs_qp.qp.qp_type != IBV_QPT_UD) {
 			set_data_seg_v2(dseg, wr->sg_list + i);
 			dseg++;
 		} else {
@@ -1159,7 +1155,7 @@ int hns_roce_u_v2_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
 		if (hns_roce_v2_wq_overflow(&qp->sq, nreq,
-					    to_hr_cq(qp->ibv_qp.send_cq))) {
+					    to_hr_cq(qp->verbs_qp.qp.send_cq))) {
 			ret = ENOMEM;
 			*bad_wr = wr;
 			goto out;
@@ -1267,7 +1263,7 @@ static int hns_roce_u_v2_post_recv(struct ibv_qp *ibvqp, struct ibv_recv_wr *wr,
 	max_sge = qp->rq.max_gs - qp->rq.rsv_sge;
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
 		if (hns_roce_v2_wq_overflow(&qp->rq, nreq,
-					    to_hr_cq(qp->ibv_qp.recv_cq))) {
+					    to_hr_cq(qp->verbs_qp.qp.recv_cq))) {
 			ret = ENOMEM;
 			*bad_wr = wr;
 			goto out;
diff --git a/providers/hns/hns_roce_u_verbs.c b/providers/hns/hns_roce_u_verbs.c
index edf0f99..3329812 100644
--- a/providers/hns/hns_roce_u_verbs.c
+++ b/providers/hns/hns_roce_u_verbs.c
@@ -555,41 +555,66 @@ int hns_roce_u_destroy_srq(struct ibv_srq *srq)
 	return 0;
 }
 
-static int hns_roce_verify_qp(struct ibv_qp_init_attr *attr,
-			      struct hns_roce_context *context)
+enum {
+	CREATE_QP_SUP_COMP_MASK = IBV_QP_INIT_ATTR_PD,
+};
+
+static int check_qp_create_mask(struct ibv_qp_init_attr_ex *attr)
 {
-	struct hns_roce_device *hr_dev =
-		to_hr_dev(context->ibv_ctx.context.device);
-	uint32_t min_wqe_num = hr_dev->hw_version == HNS_ROCE_HW_VER1 ?
-			       HNS_ROCE_V1_MIN_WQE_NUM :
-			       HNS_ROCE_V2_MIN_WQE_NUM;
-
-	if (!attr->cap.max_send_wr ||
-	    attr->cap.max_send_wr > context->max_qp_wr ||
-	    attr->cap.max_recv_wr > context->max_qp_wr ||
-	    attr->cap.max_send_sge > context->max_sge  ||
-	    attr->cap.max_recv_sge > context->max_sge)
-		return EINVAL;
+	if (!check_comp_mask(attr->comp_mask, CREATE_QP_SUP_COMP_MASK))
+		return -EOPNOTSUPP;
 
-	if (attr->cap.max_send_wr < min_wqe_num)
-		attr->cap.max_send_wr = min_wqe_num;
+	return 0;
+}
 
-	if (attr->cap.max_recv_wr) {
-		if (attr->cap.max_recv_wr < min_wqe_num)
-			attr->cap.max_recv_wr = min_wqe_num;
+static int verify_qp_create_cap(struct hns_roce_context *ctx,
+				struct ibv_qp_init_attr_ex *attr)
+{
+	struct hns_roce_device *hr_dev = to_hr_dev(ctx->ibv_ctx.context.device);
+	struct ibv_qp_cap *cap = &attr->cap;
+	uint32_t min_wqe_num;
+
+	if (!cap->max_send_wr ||
+	    cap->max_send_wr > ctx->max_qp_wr ||
+	    cap->max_recv_wr > ctx->max_qp_wr ||
+	    cap->max_send_sge > ctx->max_sge  ||
+	    cap->max_recv_sge > ctx->max_sge)
+		return -EINVAL;
+
+	min_wqe_num = hr_dev->hw_version == HNS_ROCE_HW_VER1 ?
+		      HNS_ROCE_V1_MIN_WQE_NUM : HNS_ROCE_V2_MIN_WQE_NUM;
 
-		if (!attr->cap.max_recv_sge)
+	if (cap->max_send_wr < min_wqe_num)
+		cap->max_send_wr = min_wqe_num;
+
+	if (cap->max_recv_wr) {
+		if (cap->max_recv_wr < min_wqe_num)
+			cap->max_recv_wr = min_wqe_num;
+
+		if (!cap->max_recv_sge)
 			return -EINVAL;
 	}
 
 	if (!(attr->qp_type == IBV_QPT_RC ||
 	      (attr->qp_type == IBV_QPT_UD &&
 	       hr_dev->hw_version >= HNS_ROCE_HW_VER3)))
-		return EOPNOTSUPP;
+		return -EOPNOTSUPP;
 
 	return 0;
 }
 
+static int verify_qp_create_attr(struct hns_roce_context *ctx,
+				 struct ibv_qp_init_attr_ex *attr)
+{
+	int ret;
+
+	ret = check_qp_create_mask(attr);
+	if (ret)
+		return ret;
+
+	return verify_qp_create_cap(ctx, attr);
+}
+
 static int qp_alloc_recv_inl_buf(struct ibv_qp_cap *cap,
 				 struct hns_roce_qp *qp)
 {
@@ -724,7 +749,7 @@ err_alloc:
 }
 
 static void set_extend_sge_param(struct hns_roce_device *hr_dev,
-				 struct ibv_qp_init_attr *attr,
+				 struct ibv_qp_init_attr_ex *attr,
 				 struct hns_roce_qp *qp, unsigned int wr_cnt)
 {
 	int cnt = 0;
@@ -745,13 +770,14 @@ static void set_extend_sge_param(struct hns_roce_device *hr_dev,
 	qp->ex_sge.sge_cnt = cnt;
 }
 
-static void hns_roce_set_qp_params(struct ibv_qp_init_attr *attr,
+static void hns_roce_set_qp_params(struct ibv_qp_init_attr_ex *attr,
 				   struct hns_roce_qp *qp,
 				   struct hns_roce_context *ctx)
 {
 	struct hns_roce_device *hr_dev = to_hr_dev(ctx->ibv_ctx.context.device);
 	unsigned int cnt;
-	qp->ibv_qp.qp_type = attr->qp_type;
+
+	qp->verbs_qp.qp.qp_type = attr->qp_type;
 
 	if (attr->cap.max_recv_wr) {
 		if (hr_dev->hw_version == HNS_ROCE_HW_VER2)
@@ -810,7 +836,7 @@ static void qp_free_db(struct hns_roce_qp *qp, struct hns_roce_context *ctx)
 		hns_roce_free_db(ctx, qp->rdb, HNS_ROCE_QP_TYPE_DB);
 }
 
-static int qp_alloc_db(struct ibv_qp_init_attr *attr, struct hns_roce_qp *qp,
+static int qp_alloc_db(struct ibv_qp_init_attr_ex *attr, struct hns_roce_qp *qp,
 		       struct hns_roce_context *ctx)
 {
 	struct hns_roce_device *hr_dev = to_hr_dev(ctx->ibv_ctx.context.device);
@@ -864,30 +890,30 @@ static int hns_roce_store_qp(struct hns_roce_context *ctx, uint32_t qpn,
 	return 0;
 }
 
-static int qp_exec_create_cmd(struct ibv_pd *pd,
-			      struct ibv_qp_init_attr *attr,
+static int qp_exec_create_cmd(struct ibv_qp_init_attr_ex *attr,
 			      struct hns_roce_qp *qp,
 			      struct hns_roce_context *ctx)
 {
-	struct hns_roce_create_qp_resp resp = {};
-	struct hns_roce_create_qp cmd = {};
+	struct hns_roce_create_qp_ex_resp resp_ex = {};
+	struct hns_roce_create_qp_ex cmd_ex = {};
 	int ret;
 
-	cmd.sdb_addr = (uintptr_t)qp->sdb;
-	cmd.db_addr = (uintptr_t)qp->rdb;
-	cmd.buf_addr = (uintptr_t)qp->buf.buf;
-	cmd.log_sq_stride = qp->sq.wqe_shift;
-	cmd.log_sq_bb_count = hr_ilog32(qp->sq.wqe_cnt);
+	cmd_ex.sdb_addr = (uintptr_t)qp->sdb;
+	cmd_ex.db_addr = (uintptr_t)qp->rdb;
+	cmd_ex.buf_addr = (uintptr_t)qp->buf.buf;
+	cmd_ex.log_sq_stride = qp->sq.wqe_shift;
+	cmd_ex.log_sq_bb_count = hr_ilog32(qp->sq.wqe_cnt);
+
+	ret = ibv_cmd_create_qp_ex2(&ctx->ibv_ctx.context, &qp->verbs_qp, attr,
+				    &cmd_ex.ibv_cmd, sizeof(cmd_ex),
+				    &resp_ex.ibv_resp, sizeof(resp_ex));
 
-	ret = ibv_cmd_create_qp(pd, &qp->ibv_qp, attr, &cmd.ibv_cmd,
-				sizeof(cmd), &resp.ibv_resp, sizeof(resp));
-	if (!ret)
-		qp->flags = resp.cap_flags;
+	qp->flags = resp_ex.drv_payload.cap_flags;
 
 	return ret;
 }
 
-static void qp_setup_config(struct ibv_qp_init_attr *attr,
+static void qp_setup_config(struct ibv_qp_init_attr_ex *attr,
 			    struct hns_roce_qp *qp,
 			    struct hns_roce_context *ctx)
 {
@@ -913,7 +939,7 @@ void hns_roce_free_qp_buf(struct hns_roce_qp *qp, struct hns_roce_context *ctx)
 	qp_free_wqe(qp);
 }
 
-static int hns_roce_alloc_qp_buf(struct ibv_qp_init_attr *attr,
+static int hns_roce_alloc_qp_buf(struct ibv_qp_init_attr_ex *attr,
 				 struct hns_roce_qp *qp,
 				 struct hns_roce_context *ctx)
 {
@@ -934,20 +960,20 @@ static int hns_roce_alloc_qp_buf(struct ibv_qp_init_attr *attr,
 	return ret;
 }
 
-struct ibv_qp *hns_roce_u_create_qp(struct ibv_pd *pd,
-				    struct ibv_qp_init_attr *attr)
+static struct ibv_qp *create_qp(struct ibv_context *ibv_ctx,
+				struct ibv_qp_init_attr_ex *attr)
 {
-	struct hns_roce_context *context = to_hr_ctx(pd->context);
+	struct hns_roce_context *context = to_hr_ctx(ibv_ctx);
 	struct hns_roce_qp *qp;
 	int ret;
 
-	ret = hns_roce_verify_qp(attr, context);
+	ret = verify_qp_create_attr(context, attr);
 	if (ret)
 		goto err;
 
 	qp = calloc(1, sizeof(*qp));
 	if (!qp) {
-		ret = ENOMEM;
+		ret = -ENOMEM;
 		goto err;
 	}
 
@@ -957,20 +983,20 @@ struct ibv_qp *hns_roce_u_create_qp(struct ibv_pd *pd,
 	if (ret)
 		goto err_buf;
 
-	ret = qp_exec_create_cmd(pd, attr, qp, context);
+	ret = qp_exec_create_cmd(attr, qp, context);
 	if (ret)
 		goto err_cmd;
 
-	ret = hns_roce_store_qp(context, qp->ibv_qp.qp_num, qp);
+	ret = hns_roce_store_qp(context, qp->verbs_qp.qp.qp_num, qp);
 	if (ret)
 		goto err_store;
 
 	qp_setup_config(attr, qp, context);
 
-	return &qp->ibv_qp;
+	return &qp->verbs_qp.qp;
 
 err_store:
-	ibv_cmd_destroy_qp(&qp->ibv_qp);
+	ibv_cmd_destroy_qp(&qp->verbs_qp.qp);
 err_cmd:
 	hns_roce_free_qp_buf(qp, context);
 err_buf:
@@ -983,6 +1009,29 @@ err:
 	return NULL;
 }
 
+struct ibv_qp *hns_roce_u_create_qp(struct ibv_pd *pd,
+				    struct ibv_qp_init_attr *attr)
+{
+	struct ibv_qp_init_attr_ex attrx = {};
+	struct ibv_qp *qp;
+
+	memcpy(&attrx, attr, sizeof(*attr));
+	attrx.comp_mask = IBV_QP_INIT_ATTR_PD;
+	attrx.pd = pd;
+
+	qp = create_qp(pd->context, &attrx);
+	if (qp)
+		memcpy(attr, &attrx, sizeof(*attr));
+
+	return qp;
+}
+
+struct ibv_qp *hns_roce_u_create_qp_ex(struct ibv_context *context,
+				       struct ibv_qp_init_attr_ex *attr)
+{
+	return create_qp(context, attr);
+}
+
 int hns_roce_u_query_qp(struct ibv_qp *ibqp, struct ibv_qp_attr *attr,
 			int attr_mask, struct ibv_qp_init_attr *init_attr)
 {
-- 
2.8.1

