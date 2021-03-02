Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46ED32A827
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Mar 2021 18:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579831AbhCBRKq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Mar 2021 12:10:46 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12666 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344556AbhCBMyG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Mar 2021 07:54:06 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DqcRt2Vw6zlRtL;
        Tue,  2 Mar 2021 20:50:34 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Mar 2021 20:52:39 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH rdma-core 5/5] libhns: Add support for XRC for HIP09
Date:   Tue, 2 Mar 2021 20:50:24 +0800
Message-ID: <1614689424-27154-6-git-send-email-liweihang@huawei.com>
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

The HIP09 supports XRC transport service, it greatly saves the number of
QPs required to connect all processes in a large cluster.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 providers/hns/hns_roce_u.c       |   4 ++
 providers/hns/hns_roce_u.h       |  10 ++++
 providers/hns/hns_roce_u_hw_v2.c |  99 ++++++++++++++++++++++++----------
 providers/hns/hns_roce_u_hw_v2.h |   1 +
 providers/hns/hns_roce_u_verbs.c | 114 +++++++++++++++++++++++++++++++++++----
 5 files changed, 190 insertions(+), 38 deletions(-)

diff --git a/providers/hns/hns_roce_u.c b/providers/hns/hns_roce_u.c
index d103808b..ef8b14a 100644
--- a/providers/hns/hns_roce_u.c
+++ b/providers/hns/hns_roce_u.c
@@ -88,6 +88,10 @@ static const struct verbs_context_ops hns_common_ops = {
 	.free_context = hns_roce_free_context,
 	.create_ah = hns_roce_u_create_ah,
 	.destroy_ah = hns_roce_u_destroy_ah,
+	.open_xrcd = hns_roce_u_open_xrcd,
+	.close_xrcd = hns_roce_u_close_xrcd,
+	.open_qp = hns_roce_u_open_qp,
+	.get_srq_num = hns_roce_u_get_srq_num,
 };
 
 static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
diff --git a/providers/hns/hns_roce_u.h b/providers/hns/hns_roce_u.h
index de6d0f3..1e6e638 100644
--- a/providers/hns/hns_roce_u.h
+++ b/providers/hns/hns_roce_u.h
@@ -285,6 +285,7 @@ struct hns_roce_qp {
 
 	struct hns_roce_rinl_buf	rq_rinl_buf;
 	unsigned long			flags;
+	int				refcnt; /* specially used for XRC */
 };
 
 struct hns_roce_av {
@@ -388,6 +389,7 @@ struct ibv_srq *hns_roce_u_create_srq(struct ibv_pd *pd,
 				      struct ibv_srq_init_attr *srq_init_attr);
 struct ibv_srq *hns_roce_u_create_srq_ex(struct ibv_context *context,
 					 struct ibv_srq_init_attr_ex *attr);
+int hns_roce_u_get_srq_num(struct ibv_srq *ibv_srq, uint32_t *srq_num);
 int hns_roce_u_modify_srq(struct ibv_srq *srq, struct ibv_srq_attr *srq_attr,
 			  int srq_attr_mask);
 int hns_roce_u_query_srq(struct ibv_srq *srq, struct ibv_srq_attr *srq_attr);
@@ -401,6 +403,9 @@ struct ibv_qp *
 hns_roce_u_create_qp_ex(struct ibv_context *context,
 			struct ibv_qp_init_attr_ex *qp_init_attr_ex);
 
+struct ibv_qp *hns_roce_u_open_qp(struct ibv_context *context,
+				  struct ibv_qp_open_attr *attr);
+
 int hns_roce_u_query_qp(struct ibv_qp *ibqp, struct ibv_qp_attr *attr,
 			int attr_mask, struct ibv_qp_init_attr *init_attr);
 
@@ -408,6 +413,11 @@ struct ibv_ah *hns_roce_u_create_ah(struct ibv_pd *pd,
 				    struct ibv_ah_attr *attr);
 int hns_roce_u_destroy_ah(struct ibv_ah *ah);
 
+struct ibv_xrcd *
+hns_roce_u_open_xrcd(struct ibv_context *context,
+		     struct ibv_xrcd_init_attr *xrcd_init_attr);
+int hns_roce_u_close_xrcd(struct ibv_xrcd *ibv_xrcd);
+
 int hns_roce_alloc_buf(struct hns_roce_buf *buf, unsigned int size,
 		       int page_size);
 void hns_roce_free_buf(struct hns_roce_buf *buf);
diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
index 4d990dd..bbb5262 100644
--- a/providers/hns/hns_roce_u_hw_v2.c
+++ b/providers/hns/hns_roce_u_hw_v2.c
@@ -206,6 +206,9 @@ static void hns_roce_v2_handle_error_cqe(struct hns_roce_v2_cqe *cqe,
 	case HNS_ROCE_V2_CQE_REMOTE_ABORTED_ERR:
 		wc->status = IBV_WC_REM_ABORT_ERR;
 		break;
+	case HNS_ROCE_V2_CQE_XRC_VIOLATION_ERR:
+		wc->status = IBV_WC_REM_INV_RD_REQ_ERR;
+		break;
 	default:
 		wc->status = IBV_WC_GENERAL_ERR;
 		break;
@@ -346,15 +349,17 @@ static struct hns_roce_qp *hns_roce_v2_find_qp(struct hns_roce_context *ctx,
 		return NULL;
 }
 
-static void hns_roce_v2_clear_qp(struct hns_roce_context *ctx, uint32_t qpn)
+static void hns_roce_v2_clear_qp(struct hns_roce_context *ctx,
+				 struct hns_roce_qp *qp)
 {
-	int tind = (qpn & (ctx->num_qps - 1)) >> ctx->qp_table_shift;
+	uint32_t qpn = qp->verbs_qp.qp.qp_num;
+	uint32_t tind = (qpn & (ctx->num_qps - 1)) >> ctx->qp_table_shift;
 
 	pthread_mutex_lock(&ctx->qp_table_mutex);
 
 	if (!--ctx->qp_table[tind].refcnt)
 		free(ctx->qp_table[tind].table);
-	else
+	else if (!--qp->refcnt)
 		ctx->qp_table[tind].table[qpn & ctx->qp_table_mask] = NULL;
 
 	pthread_mutex_unlock(&ctx->qp_table_mutex);
@@ -510,13 +515,15 @@ static int hns_roce_handle_recv_inl_wqe(struct hns_roce_v2_cqe *cqe,
 static int hns_roce_v2_poll_one(struct hns_roce_cq *cq,
 				struct hns_roce_qp **cur_qp, struct ibv_wc *wc)
 {
-	uint32_t qpn;
-	int is_send;
-	uint16_t wqe_ctr;
+	struct hns_roce_context *ctx = to_hr_ctx(cq->ibv_cq.context);
+	struct hns_roce_srq *srq = NULL;
 	struct hns_roce_wq *wq = NULL;
 	struct hns_roce_v2_cqe *cqe;
-	struct hns_roce_srq *srq;
+	uint16_t wqe_ctr;
 	uint32_t opcode;
+	uint32_t srqn;
+	uint32_t qpn;
+	int is_send;
 	int ret;
 
 	/* According to CI, find the relative cqe */
@@ -537,15 +544,23 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *cq,
 
 	/* if qp is zero, it will not get the correct qpn */
 	if (!*cur_qp || qpn != (*cur_qp)->verbs_qp.qp.qp_num) {
-		*cur_qp = hns_roce_v2_find_qp(to_hr_ctx(cq->ibv_cq.context),
-					      qpn);
+		*cur_qp = hns_roce_v2_find_qp(ctx, qpn);
 		if (!*cur_qp)
 			return V2_CQ_POLL_ERR;
 	}
 	wc->qp_num = qpn;
 
-	srq = (*cur_qp)->verbs_qp.qp.srq ?
-				to_hr_srq((*cur_qp)->verbs_qp.qp.srq) : NULL;
+	if ((*cur_qp)->verbs_qp.qp.qp_type == IBV_QPT_XRC_RECV) {
+		srqn = roce_get_field(cqe->byte_12, CQE_BYTE_12_XRC_SRQN_M,
+				      CQE_BYTE_12_XRC_SRQN_S);
+
+		srq = hns_roce_find_srq(ctx, srqn);
+		if (!srq)
+			return V2_CQ_POLL_ERR;
+	} else if ((*cur_qp)->verbs_qp.qp.srq) {
+		srq = to_hr_srq((*cur_qp)->verbs_qp.qp.srq);
+	}
+
 	if (is_send) {
 		wq = &(*cur_qp)->sq;
 		/*
@@ -683,6 +698,21 @@ static int hns_roce_u_v2_arm_cq(struct ibv_cq *ibvcq, int solicited)
 	return 0;
 }
 
+static int check_qp_send(struct ibv_qp *qp, struct hns_roce_context *ctx)
+{
+	if (unlikely(qp->qp_type != IBV_QPT_RC &&
+		     qp->qp_type != IBV_QPT_UD) &&
+		     qp->qp_type != IBV_QPT_XRC_SEND)
+		return -EINVAL;
+
+	if (unlikely(qp->state == IBV_QPS_RESET ||
+		     qp->state == IBV_QPS_INIT ||
+		     qp->state == IBV_QPS_RTR))
+		return -EINVAL;
+
+	return 0;
+}
+
 static void set_sge(struct hns_roce_v2_wqe_data_seg *dseg,
 		    struct hns_roce_qp *qp, struct ibv_send_wr *wr,
 		    struct hns_roce_sge_info *sge_info)
@@ -913,8 +943,6 @@ static int set_ud_wqe(void *wqe, struct hns_roce_qp *qp,
 	struct hns_roce_ud_sq_wqe *ud_sq_wqe = wqe;
 	int ret = 0;
 
-	memset(ud_sq_wqe, 0, sizeof(*ud_sq_wqe));
-
 	roce_set_bit(ud_sq_wqe->rsv_opcode, UD_SQ_WQE_CQE_S,
 		     !!(wr->send_flags & IBV_SEND_SIGNALED));
 	roce_set_bit(ud_sq_wqe->rsv_opcode, UD_SQ_WQE_SE_S,
@@ -1071,8 +1099,6 @@ static int set_rc_wqe(void *wqe, struct hns_roce_qp *qp, struct ibv_send_wr *wr,
 	struct hns_roce_v2_wqe_data_seg *dseg;
 	int ret;
 
-	memset(rc_sq_wqe, 0, sizeof(struct hns_roce_rc_sq_wqe));
-
 	ret = check_rc_opcode(rc_sq_wqe, wr);
 	if (ret)
 		return ret;
@@ -1137,16 +1163,15 @@ int hns_roce_u_v2_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 	struct hns_roce_context *ctx = to_hr_ctx(ibvqp->context);
 	struct hns_roce_qp *qp = to_hr_qp(ibvqp);
 	struct hns_roce_sge_info sge_info = {};
+	struct hns_roce_rc_sq_wqe *wqe;
 	unsigned int wqe_idx, nreq;
 	struct ibv_qp_attr attr;
 	int ret = 0;
-	void *wqe;
 
-	/* check that state is OK to post send */
-	if (ibvqp->state == IBV_QPS_RESET || ibvqp->state == IBV_QPS_INIT ||
-	    ibvqp->state == IBV_QPS_RTR) {
+	ret = check_qp_send(ibvqp, ctx);
+	if (unlikely(ret)) {
 		*bad_wr = wr;
-		return EINVAL;
+		return ret;
 	}
 
 	pthread_spin_lock(&qp->sq.lock);
@@ -1172,6 +1197,12 @@ int hns_roce_u_v2_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 		qp->sq.wrid[wqe_idx] = wr->wr_id;
 
 		switch (ibvqp->qp_type) {
+		case IBV_QPT_XRC_SEND:
+			roce_set_field(wqe->byte_16,
+				       RC_SQ_WQE_BYTE_16_XRC_SRQN_M,
+				       RC_SQ_WQE_BYTE_16_XRC_SRQN_S,
+				       wr->qp_type.xrc.remote_srqn);
+			SWITCH_FALLTHROUGH;
 		case IBV_QPT_RC:
 			ret = set_rc_wqe(wqe, qp, wr, nreq, &sge_info);
 			break;
@@ -1212,6 +1243,18 @@ out:
 	return ret;
 }
 
+static int check_qp_recv(struct ibv_qp *qp, struct hns_roce_context *ctx)
+{
+	if (unlikely(qp->qp_type != IBV_QPT_RC &&
+		     qp->qp_type != IBV_QPT_UD))
+		return -EINVAL;
+
+	if (qp->state == IBV_QPS_RESET || qp->srq)
+		return -EINVAL;
+
+	return 0;
+}
+
 static void fill_rq_wqe(struct hns_roce_qp *qp, struct ibv_recv_wr *wr,
 			unsigned int wqe_idx)
 {
@@ -1252,10 +1295,10 @@ static int hns_roce_u_v2_post_recv(struct ibv_qp *ibvqp, struct ibv_recv_wr *wr,
 	unsigned int max_sge;
 	int ret = 0;
 
-	/* check that state is OK to post receive */
-	if (ibvqp->state == IBV_QPS_RESET) {
+	ret = check_qp_recv(ibvqp, ctx);
+	if (unlikely(ret)) {
 		*bad_wr = wr;
-		return EINVAL;
+		return ret;
 	}
 
 	pthread_spin_lock(&qp->rq.lock);
@@ -1406,9 +1449,11 @@ static int hns_roce_u_v2_modify_qp(struct ibv_qp *qp, struct ibv_qp_attr *attr,
 		qp->state = attr->qp_state;
 
 	if ((attr_mask & IBV_QP_STATE) && attr->qp_state == IBV_QPS_RESET) {
-		hns_roce_v2_cq_clean(to_hr_cq(qp->recv_cq), qp->qp_num,
-				     qp->srq ? to_hr_srq(qp->srq) : NULL);
-		if (qp->send_cq != qp->recv_cq)
+		if (qp->recv_cq)
+			hns_roce_v2_cq_clean(to_hr_cq(qp->recv_cq), qp->qp_num,
+					     qp->srq ? to_hr_srq(qp->srq) :
+					     NULL);
+		if (qp->send_cq && qp->send_cq != qp->recv_cq)
 			hns_roce_v2_cq_clean(to_hr_cq(qp->send_cq), qp->qp_num,
 					     NULL);
 
@@ -1474,7 +1519,7 @@ static int hns_roce_u_v2_destroy_qp(struct ibv_qp *ibqp)
 	if (ret)
 		return ret;
 
-	hns_roce_v2_clear_qp(ctx, ibqp->qp_num);
+	hns_roce_v2_clear_qp(ctx, qp);
 
 	hns_roce_lock_cqs(ibqp);
 
diff --git a/providers/hns/hns_roce_u_hw_v2.h b/providers/hns/hns_roce_u_hw_v2.h
index f5e6402..af67b31 100644
--- a/providers/hns/hns_roce_u_hw_v2.h
+++ b/providers/hns/hns_roce_u_hw_v2.h
@@ -112,6 +112,7 @@ enum {
 	HNS_ROCE_V2_CQE_TRANSPORT_RETRY_EXC_ERR		= 0x15,
 	HNS_ROCE_V2_CQE_RNR_RETRY_EXC_ERR		= 0x16,
 	HNS_ROCE_V2_CQE_REMOTE_ABORTED_ERR		= 0x22,
+	HNS_ROCE_V2_CQE_XRC_VIOLATION_ERR		= 0x24,
 };
 
 enum {
diff --git a/providers/hns/hns_roce_u_verbs.c b/providers/hns/hns_roce_u_verbs.c
index e51b9d5..fc3dd13 100644
--- a/providers/hns/hns_roce_u_verbs.c
+++ b/providers/hns/hns_roce_u_verbs.c
@@ -120,6 +120,41 @@ int hns_roce_u_free_pd(struct ibv_pd *pd)
 	return ret;
 }
 
+struct ibv_xrcd *hns_roce_u_open_xrcd(struct ibv_context *context,
+				      struct ibv_xrcd_init_attr *xrcd_init_attr)
+{
+	struct ib_uverbs_open_xrcd_resp resp = {};
+	struct ibv_open_xrcd cmd = {};
+	struct verbs_xrcd *xrcd;
+	int ret;
+
+	xrcd = calloc(1, sizeof(*xrcd));
+	if (!xrcd)
+		return NULL;
+
+	ret = ibv_cmd_open_xrcd(context, xrcd, sizeof(*xrcd), xrcd_init_attr,
+				&cmd, sizeof(cmd), &resp, sizeof(resp));
+	if (ret) {
+		free(xrcd);
+		return NULL;
+	}
+
+	return &xrcd->xrcd;
+}
+
+int hns_roce_u_close_xrcd(struct ibv_xrcd *ibv_xrcd)
+{
+	struct verbs_xrcd *xrcd =
+			container_of(ibv_xrcd, struct verbs_xrcd, xrcd);
+	int ret;
+
+	ret = ibv_cmd_close_xrcd(xrcd);
+	if (!ret)
+		free(xrcd);
+
+	return ret;
+}
+
 struct ibv_mr *hns_roce_u_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 				 uint64_t hca_va, int access)
 {
@@ -637,6 +672,13 @@ struct ibv_srq *hns_roce_u_create_srq_ex(struct ibv_context *context,
 	return create_srq(context, attr);
 }
 
+int hns_roce_u_get_srq_num(struct ibv_srq *ibv_srq, uint32_t *srq_num)
+{
+	*srq_num = to_hr_srq(ibv_srq)->srqn;
+
+	return 0;
+}
+
 int hns_roce_u_modify_srq(struct ibv_srq *srq, struct ibv_srq_attr *srq_attr,
 			  int srq_attr_mask)
 {
@@ -686,14 +728,35 @@ int hns_roce_u_destroy_srq(struct ibv_srq *ibv_srq)
 }
 
 enum {
-	CREATE_QP_SUP_COMP_MASK = IBV_QP_INIT_ATTR_PD,
+	CREATE_QP_SUP_COMP_MASK = IBV_QP_INIT_ATTR_PD | IBV_QP_INIT_ATTR_XRCD,
 };
 
-static int check_qp_create_mask(struct ibv_qp_init_attr_ex *attr)
+static int check_qp_create_mask(struct hns_roce_context *ctx,
+				struct ibv_qp_init_attr_ex *attr)
 {
+	struct hns_roce_device *hr_dev = to_hr_dev(ctx->ibv_ctx.context.device);
+
 	if (!check_comp_mask(attr->comp_mask, CREATE_QP_SUP_COMP_MASK))
 		return -EOPNOTSUPP;
 
+	switch (attr->qp_type) {
+	case IBV_QPT_UD:
+		if (hr_dev->hw_version < HNS_ROCE_HW_VER3)
+			return -EINVAL;
+		SWITCH_FALLTHROUGH;
+	case IBV_QPT_RC:
+	case IBV_QPT_XRC_SEND:
+		if (!(attr->comp_mask & IBV_QP_INIT_ATTR_PD))
+			return -EINVAL;
+		break;
+	case IBV_QPT_XRC_RECV:
+		if (!(attr->comp_mask & IBV_QP_INIT_ATTR_XRCD))
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -704,8 +767,10 @@ static int verify_qp_create_cap(struct hns_roce_context *ctx,
 	struct ibv_qp_cap *cap = &attr->cap;
 	uint32_t min_wqe_num;
 
-	if (!cap->max_send_wr ||
-	    cap->max_send_wr > ctx->max_qp_wr ||
+	if (!cap->max_send_wr && attr->qp_type != IBV_QPT_XRC_RECV)
+		return -EINVAL;
+
+	if (cap->max_send_wr > ctx->max_qp_wr ||
 	    cap->max_recv_wr > ctx->max_qp_wr ||
 	    cap->max_send_sge > ctx->max_sge  ||
 	    cap->max_recv_sge > ctx->max_sge)
@@ -725,11 +790,6 @@ static int verify_qp_create_cap(struct hns_roce_context *ctx,
 			return -EINVAL;
 	}
 
-	if (!(attr->qp_type == IBV_QPT_RC ||
-	      (attr->qp_type == IBV_QPT_UD &&
-	       hr_dev->hw_version >= HNS_ROCE_HW_VER3)))
-		return -EOPNOTSUPP;
-
 	return 0;
 }
 
@@ -738,7 +798,7 @@ static int verify_qp_create_attr(struct hns_roce_context *ctx,
 {
 	int ret;
 
-	ret = check_qp_create_mask(attr);
+	ret = check_qp_create_mask(ctx, attr);
 	if (ret)
 		return ret;
 
@@ -998,7 +1058,8 @@ static int qp_alloc_db(struct ibv_qp_init_attr_ex *attr, struct hns_roce_qp *qp,
 	return 0;
 }
 
-static int hns_roce_store_qp(struct hns_roce_context *ctx, struct hns_roce_qp *qp)
+static int hns_roce_store_qp(struct hns_roce_context *ctx,
+			     struct hns_roce_qp *qp)
 {
 	uint32_t qpn = qp->verbs_qp.qp.qp_num;
 	uint32_t tind = (qpn & (ctx->num_qps - 1)) >> ctx->qp_table_shift;
@@ -1013,6 +1074,7 @@ static int hns_roce_store_qp(struct hns_roce_context *ctx, struct hns_roce_qp *q
 		}
 	}
 
+	++qp->refcnt;
 	++ctx->qp_table[tind].refcnt;
 	ctx->qp_table[tind].table[qpn & ctx->qp_table_mask] = qp;
 	pthread_mutex_unlock(&ctx->qp_table_mutex);
@@ -1162,6 +1224,36 @@ struct ibv_qp *hns_roce_u_create_qp_ex(struct ibv_context *context,
 	return create_qp(context, attr);
 }
 
+struct ibv_qp *hns_roce_u_open_qp(struct ibv_context *context,
+				  struct ibv_qp_open_attr *attr)
+{
+	struct ib_uverbs_create_qp_resp resp;
+	struct ibv_open_qp cmd;
+	struct hns_roce_qp *qp;
+	int ret;
+
+	qp = calloc(1, sizeof(*qp));
+	if (!qp)
+		return NULL;
+
+	ret = ibv_cmd_open_qp(context, &qp->verbs_qp, sizeof(qp->verbs_qp),
+			      attr, &cmd, sizeof(cmd), &resp, sizeof(resp));
+	if (ret)
+		goto err_buf;
+
+	ret = hns_roce_store_qp(to_hr_ctx(context), qp);
+	if (ret)
+		goto err_cmd;
+
+	return &qp->verbs_qp.qp;
+
+err_cmd:
+	ibv_cmd_destroy_qp(&qp->verbs_qp.qp);
+err_buf:
+	free(qp);
+	return NULL;
+}
+
 int hns_roce_u_query_qp(struct ibv_qp *ibqp, struct ibv_qp_attr *attr,
 			int attr_mask, struct ibv_qp_init_attr *init_attr)
 {
-- 
2.8.1

