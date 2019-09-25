Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 621A9BDD43
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 13:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391128AbfIYLjZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Sep 2019 07:39:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59726 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391060AbfIYLjZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Sep 2019 07:39:25 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6F24998C384A383FE85;
        Wed, 25 Sep 2019 19:39:21 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Wed, 25 Sep 2019 19:39:14 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v3 rdma-core 3/4] libhns: Refactor for post send
Date:   Wed, 25 Sep 2019 19:35:50 +0800
Message-ID: <1569411351-57148-4-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1569411351-57148-1-git-send-email-liweihang@hisilicon.com>
References: <1569411351-57148-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixian Liu <liuyixian@huawei.com>

This patch refactors the interface of hns_roce_u_v2_post_send, which
is now very complicated. We reduce the complexity with following points:
1. Separate RC server into a function.
2. Simplify and separate the process of sge.
3. Keep the logic and consistence of all operations.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 providers/hns/hns_roce_u.h       |  10 +
 providers/hns/hns_roce_u_hw_v2.c | 433 +++++++++++++++++----------------------
 2 files changed, 195 insertions(+), 248 deletions(-)

diff --git a/providers/hns/hns_roce_u.h b/providers/hns/hns_roce_u.h
index 45472fe..27e6704 100644
--- a/providers/hns/hns_roce_u.h
+++ b/providers/hns/hns_roce_u.h
@@ -70,6 +70,9 @@
 
 #define	ETH_ALEN			6
 
+#define HNS_ROCE_ADDRESS_MASK		0xFFFFFFFF
+#define HNS_ROCE_ADDRESS_SHIFT		32
+
 #define roce_get_field(origin, mask, shift) \
 	(((le32toh(origin)) & (mask)) >> (shift))
 
@@ -206,6 +209,13 @@ struct hns_roce_wq {
 	int				offset;
 };
 
+/* record the result of sge process */
+struct hns_roce_sge_info {
+	unsigned int		valid_num; /* sge length is not 0 */
+	unsigned int		start_idx; /* start position of extend sge */
+	unsigned int		total_len; /* total length of valid sges */
+};
+
 struct hns_roce_sge_ex {
 	int				offset;
 	unsigned int			sge_cnt;
diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
index 439e547..50057e3 100644
--- a/providers/hns/hns_roce_u_hw_v2.c
+++ b/providers/hns/hns_roce_u_hw_v2.c
@@ -609,28 +609,194 @@ static int hns_roce_u_v2_arm_cq(struct ibv_cq *ibvcq, int solicited)
 	return 0;
 }
 
+static void set_sge(struct hns_roce_v2_wqe_data_seg *dseg,
+		    struct hns_roce_qp *qp, struct ibv_send_wr *wr,
+		    struct hns_roce_sge_info *sge_info)
+{
+	int i;
+
+	sge_info->valid_num = 0;
+	sge_info->total_len = 0;
+
+	for (i = 0; i < wr->num_sge; i++)
+		if (likely(wr->sg_list[i].length)) {
+			sge_info->total_len += wr->sg_list[i].length;
+			sge_info->valid_num++;
+
+			/* No inner sge in UD wqe */
+			if (sge_info->valid_num <= HNS_ROCE_SGE_IN_WQE &&
+			    qp->ibv_qp.qp_type != IBV_QPT_UD) {
+				set_data_seg_v2(dseg, wr->sg_list + i);
+				dseg++;
+			} else {
+				dseg = get_send_sge_ex(qp, sge_info->start_idx &
+						       (qp->sge.sge_cnt - 1));
+				set_data_seg_v2(dseg, wr->sg_list + i);
+				sge_info->start_idx++;
+			}
+		}
+}
+
+static int set_rc_wqe(void *wqe, struct hns_roce_qp *qp, struct ibv_send_wr *wr,
+		      int nreq, struct hns_roce_sge_info *sge_info)
+{
+	struct hns_roce_rc_sq_wqe *rc_sq_wqe = wqe;
+	struct hns_roce_v2_wqe_data_seg *dseg;
+	int hr_op;
+	int i;
+
+	memset(rc_sq_wqe, 0, sizeof(struct hns_roce_rc_sq_wqe));
+
+	switch (wr->opcode) {
+	case IBV_WR_RDMA_READ:
+		hr_op = HNS_ROCE_WQE_OP_RDMA_READ;
+		rc_sq_wqe->va = htole64(wr->wr.rdma.remote_addr);
+		rc_sq_wqe->rkey = htole32(wr->wr.rdma.rkey);
+		break;
+	case IBV_WR_RDMA_WRITE:
+		hr_op = HNS_ROCE_WQE_OP_RDMA_WRITE;
+		rc_sq_wqe->va =	htole64(wr->wr.rdma.remote_addr);
+		rc_sq_wqe->rkey = htole32(wr->wr.rdma.rkey);
+		break;
+	case IBV_WR_RDMA_WRITE_WITH_IMM:
+		hr_op = HNS_ROCE_WQE_OP_RDMA_WRITE_WITH_IMM;
+		rc_sq_wqe->va =	htole64(wr->wr.rdma.remote_addr);
+		rc_sq_wqe->rkey = htole32(wr->wr.rdma.rkey);
+		rc_sq_wqe->immtdata = htole32(be32toh(wr->imm_data));
+		break;
+	case IBV_WR_SEND:
+		hr_op = HNS_ROCE_WQE_OP_SEND;
+		break;
+	case IBV_WR_SEND_WITH_INV:
+		hr_op = HNS_ROCE_WQE_OP_SEND_WITH_INV;
+		rc_sq_wqe->inv_key = htole32(wr->invalidate_rkey);
+		break;
+	case IBV_WR_SEND_WITH_IMM:
+		hr_op = HNS_ROCE_WQE_OP_SEND_WITH_IMM;
+		rc_sq_wqe->immtdata = htole32(be32toh(wr->imm_data));
+		break;
+	case IBV_WR_LOCAL_INV:
+		hr_op = HNS_ROCE_WQE_OP_LOCAL_INV;
+		roce_set_bit(rc_sq_wqe->byte_4, RC_SQ_WQE_BYTE_4_SO_S, 1);
+		rc_sq_wqe->inv_key = htole32(wr->invalidate_rkey);
+		break;
+	case IBV_WR_BIND_MW:
+		hr_op = HNS_ROCE_WQE_OP_BIND_MW_TYPE;
+		roce_set_bit(rc_sq_wqe->byte_4, RC_SQ_WQE_BYTE_4_MW_TYPE_S,
+			     wr->bind_mw.mw->type - 1);
+		roce_set_bit(rc_sq_wqe->byte_4, RC_SQ_WQE_BYTE_4_ATOMIC_S,
+			     (wr->bind_mw.bind_info.mw_access_flags &
+			     IBV_ACCESS_REMOTE_ATOMIC) ? 1 : 0);
+		roce_set_bit(rc_sq_wqe->byte_4, RC_SQ_WQE_BYTE_4_RDMA_READ_S,
+			     (wr->bind_mw.bind_info.mw_access_flags &
+			     IBV_ACCESS_REMOTE_READ) ? 1 : 0);
+		roce_set_bit(rc_sq_wqe->byte_4, RC_SQ_WQE_BYTE_4_RDMA_WRITE_S,
+			     (wr->bind_mw.bind_info.mw_access_flags &
+			     IBV_ACCESS_REMOTE_WRITE) ? 1 : 0);
+		rc_sq_wqe->new_rkey = htole32(wr->bind_mw.rkey);
+		rc_sq_wqe->byte_16 = htole32(wr->bind_mw.bind_info.length &
+					     HNS_ROCE_ADDRESS_MASK);
+		rc_sq_wqe->byte_20 = htole32(wr->bind_mw.bind_info.length >>
+					     HNS_ROCE_ADDRESS_SHIFT);
+		rc_sq_wqe->rkey = htole32(wr->bind_mw.bind_info.mr->rkey);
+		rc_sq_wqe->va = htole64(wr->bind_mw.bind_info.addr);
+		break;
+	case IBV_WR_ATOMIC_CMP_AND_SWP:
+		hr_op = HNS_ROCE_WQE_OP_ATOMIC_COM_AND_SWAP;
+		rc_sq_wqe->rkey = htole32(wr->wr.atomic.rkey);
+		rc_sq_wqe->va = htole64(wr->wr.atomic.remote_addr);
+		break;
+	case IBV_WR_ATOMIC_FETCH_AND_ADD:
+		hr_op = HNS_ROCE_WQE_OP_ATOMIC_FETCH_AND_ADD;
+		rc_sq_wqe->rkey = htole32(wr->wr.atomic.rkey);
+		rc_sq_wqe->va =	htole64(wr->wr.atomic.remote_addr);
+		break;
+	default:
+		hr_op = HNS_ROCE_WQE_OP_MASK;
+		fprintf(stderr, "Not supported transport opcode %d\n",
+			wr->opcode);
+		return -EINVAL;
+	}
+
+	roce_set_field(rc_sq_wqe->byte_4, RC_SQ_WQE_BYTE_4_OPCODE_M,
+		       RC_SQ_WQE_BYTE_4_OPCODE_S, hr_op);
+
+	roce_set_bit(rc_sq_wqe->byte_4, RC_SQ_WQE_BYTE_4_CQE_S,
+		     (wr->send_flags & IBV_SEND_SIGNALED) ? 1 : 0);
+
+	roce_set_bit(rc_sq_wqe->byte_4, RC_SQ_WQE_BYTE_4_FENCE_S,
+		     (wr->send_flags & IBV_SEND_FENCE) ? 1 : 0);
+
+	roce_set_bit(rc_sq_wqe->byte_4, RC_SQ_WQE_BYTE_4_SE_S,
+		     (wr->send_flags & IBV_SEND_SOLICITED) ? 1 : 0);
+
+	roce_set_bit(rc_sq_wqe->byte_4, RC_SQ_WQE_BYTE_4_OWNER_S,
+		     ~(((qp->sq.head + nreq) >> qp->sq.shift) & 0x1));
+
+	roce_set_field(rc_sq_wqe->byte_20,
+		       RC_SQ_WQE_BYTE_20_MSG_START_SGE_IDX_M,
+		       RC_SQ_WQE_BYTE_20_MSG_START_SGE_IDX_S,
+		       sge_info->start_idx & (qp->sge.sge_cnt - 1));
+
+	if (wr->opcode == IBV_WR_BIND_MW)
+		return 0;
+
+	wqe += sizeof(struct hns_roce_rc_sq_wqe);
+	dseg = wqe;
+
+	set_sge(dseg, qp, wr, sge_info);
+
+	rc_sq_wqe->msg_len = htole32(sge_info->total_len);
+
+	roce_set_field(rc_sq_wqe->byte_16, RC_SQ_WQE_BYTE_16_SGE_NUM_M,
+		       RC_SQ_WQE_BYTE_16_SGE_NUM_S, sge_info->valid_num);
+
+	if (wr->opcode == IBV_WR_ATOMIC_FETCH_AND_ADD ||
+	    wr->opcode == IBV_WR_ATOMIC_CMP_AND_SWP) {
+		dseg++;
+		set_atomic_seg((struct hns_roce_wqe_atomic_seg *)dseg, wr);
+		return 0;
+	}
+
+	if (wr->send_flags & IBV_SEND_INLINE) {
+		if (wr->opcode == IBV_WR_RDMA_READ) {
+			fprintf(stderr, "Not supported inline data!\n");
+			return -EINVAL;
+		}
+
+		if (sge_info->total_len > qp->max_inline_data) {
+			fprintf(stderr,
+				"Failed to inline, data len=%d, max inline len=%d!\n",
+				sge_info->total_len, qp->max_inline_data);
+			return -EINVAL;
+		}
+
+		for (i = 0; i < wr->num_sge; i++) {
+			memcpy(dseg, (void *)(uintptr_t)(wr->sg_list[i].addr),
+			       wr->sg_list[i].length);
+			dseg += wr->sg_list[i].length;
+		}
+		roce_set_bit(rc_sq_wqe->byte_4, RC_SQ_WQE_BYTE_4_INLINE_S, 1);
+	}
+
+	return 0;
+}
+
 int hns_roce_u_v2_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 			    struct ibv_send_wr **bad_wr)
 {
 	struct hns_roce_context *ctx = to_hr_ctx(ibvqp->context);
 	struct hns_roce_qp *qp = to_hr_qp(ibvqp);
-	struct hns_roce_v2_wqe_data_seg *dseg;
-	struct hns_roce_rc_sq_wqe *rc_sq_wqe;
+	struct hns_roce_sge_info sge_info = {};
 	struct ibv_qp_attr attr;
 	unsigned int wqe_idx;
-	unsigned int sge_idx;
-	int valid_num_sge;
 	int attr_mask;
 	int ret = 0;
 	void *wqe;
 	int nreq;
-	int j;
-	int i;
 
 	pthread_spin_lock(&qp->sq.lock);
 
-	sge_idx = qp->next_sge;
-
 	/* check that state is OK to post send */
 	if (ibvqp->state == IBV_QPS_RESET || ibvqp->state == IBV_QPS_INIT ||
 	    ibvqp->state == IBV_QPS_RTR) {
@@ -639,6 +805,8 @@ int hns_roce_u_v2_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 		return EINVAL;
 	}
 
+	sge_info.start_idx = qp->next_sge; /* start index of extend sge */
+
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
 		if (hns_roce_v2_wq_overflow(&qp->sq, nreq,
 					    to_hr_cq(qp->ibv_qp.send_cq))) {
@@ -647,274 +815,43 @@ int hns_roce_u_v2_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 			goto out;
 		}
 
-		wqe_idx = (qp->sq.head + nreq) & (qp->sq.wqe_cnt - 1);
-
 		if (wr->num_sge > qp->sq.max_gs) {
 			ret = EINVAL;
 			*bad_wr = wr;
 			goto out;
 		}
 
+		wqe_idx = (qp->sq.head + nreq) & (qp->sq.wqe_cnt - 1);
 		wqe = get_send_wqe(qp, wqe_idx);
-		rc_sq_wqe = wqe;
-
-		memset(rc_sq_wqe, 0, sizeof(struct hns_roce_rc_sq_wqe));
 		qp->sq.wrid[wqe_idx] = wr->wr_id;
 
-		valid_num_sge = wr->num_sge;
-		j = 0;
-
-		for (i = 0; i < wr->num_sge; i++) {
-			if (unlikely(!wr->sg_list[i].length))
-				valid_num_sge--;
-
-			rc_sq_wqe->msg_len =
-					htole32(le32toh(rc_sq_wqe->msg_len) +
-							wr->sg_list[i].length);
-		}
-
-		if (wr->opcode == IBV_WR_SEND_WITH_IMM ||
-		    wr->opcode == IBV_WR_RDMA_WRITE_WITH_IMM)
-			rc_sq_wqe->immtdata = htole32(be32toh(wr->imm_data));
-
-		roce_set_field(rc_sq_wqe->byte_16, RC_SQ_WQE_BYTE_16_SGE_NUM_M,
-			       RC_SQ_WQE_BYTE_16_SGE_NUM_S, valid_num_sge);
-
-		roce_set_field(rc_sq_wqe->byte_20,
-			       RC_SQ_WQE_BYTE_20_MSG_START_SGE_IDX_S,
-			       RC_SQ_WQE_BYTE_20_MSG_START_SGE_IDX_S,
-			       0);
-
-		roce_set_bit(rc_sq_wqe->byte_4, RC_SQ_WQE_BYTE_4_CQE_S,
-			     (wr->send_flags & IBV_SEND_SIGNALED) ? 1 : 0);
-
-		/* Set fence attr */
-		roce_set_bit(rc_sq_wqe->byte_4, RC_SQ_WQE_BYTE_4_FENCE_S,
-			     (wr->send_flags & IBV_SEND_FENCE) ? 1 : 0);
-
-		/* Set solicited attr */
-		roce_set_bit(rc_sq_wqe->byte_4, RC_SQ_WQE_BYTE_4_SE_S,
-			     (wr->send_flags & IBV_SEND_SOLICITED) ? 1 : 0);
-
-		roce_set_bit(rc_sq_wqe->byte_4, RC_SQ_WQE_BYTE_4_OWNER_S,
-			     ~(((qp->sq.head + nreq) >> qp->sq.shift) & 0x1));
-
-		wqe += sizeof(struct hns_roce_rc_sq_wqe);
-		/* set remote addr segment */
 		switch (ibvqp->qp_type) {
 		case IBV_QPT_RC:
-			switch (wr->opcode) {
-			case IBV_WR_RDMA_READ:
-				roce_set_field(rc_sq_wqe->byte_4,
-					       RC_SQ_WQE_BYTE_4_OPCODE_M,
-					       RC_SQ_WQE_BYTE_4_OPCODE_S,
-					       HNS_ROCE_WQE_OP_RDMA_READ);
-				rc_sq_wqe->va =
-					htole64(wr->wr.rdma.remote_addr);
-				rc_sq_wqe->rkey = htole32(wr->wr.rdma.rkey);
-				break;
-
-			case IBV_WR_RDMA_WRITE:
-				roce_set_field(rc_sq_wqe->byte_4,
-					       RC_SQ_WQE_BYTE_4_OPCODE_M,
-					       RC_SQ_WQE_BYTE_4_OPCODE_S,
-					       HNS_ROCE_WQE_OP_RDMA_WRITE);
-				rc_sq_wqe->va =
-					htole64(wr->wr.rdma.remote_addr);
-				rc_sq_wqe->rkey = htole32(wr->wr.rdma.rkey);
-				break;
-
-			case IBV_WR_RDMA_WRITE_WITH_IMM:
-				roce_set_field(rc_sq_wqe->byte_4,
-				       RC_SQ_WQE_BYTE_4_OPCODE_M,
-				       RC_SQ_WQE_BYTE_4_OPCODE_S,
-				       HNS_ROCE_WQE_OP_RDMA_WRITE_WITH_IMM);
-				rc_sq_wqe->va =
-					htole64(wr->wr.rdma.remote_addr);
-				rc_sq_wqe->rkey = htole32(wr->wr.rdma.rkey);
-				break;
-
-			case IBV_WR_SEND:
-				roce_set_field(rc_sq_wqe->byte_4,
-					       RC_SQ_WQE_BYTE_4_OPCODE_M,
-					       RC_SQ_WQE_BYTE_4_OPCODE_S,
-					       HNS_ROCE_WQE_OP_SEND);
-				break;
-			case IBV_WR_SEND_WITH_INV:
-				roce_set_field(rc_sq_wqe->byte_4,
-					     RC_SQ_WQE_BYTE_4_OPCODE_M,
-					     RC_SQ_WQE_BYTE_4_OPCODE_S,
-					     HNS_ROCE_WQE_OP_SEND_WITH_INV);
-				rc_sq_wqe->inv_key =
-						htole32(wr->invalidate_rkey);
-				break;
-			case IBV_WR_SEND_WITH_IMM:
-				roce_set_field(rc_sq_wqe->byte_4,
-					RC_SQ_WQE_BYTE_4_OPCODE_M,
-					RC_SQ_WQE_BYTE_4_OPCODE_S,
-					HNS_ROCE_WQE_OP_SEND_WITH_IMM);
-				break;
-
-			case IBV_WR_LOCAL_INV:
-				roce_set_field(rc_sq_wqe->byte_4,
-					       RC_SQ_WQE_BYTE_4_OPCODE_M,
-					       RC_SQ_WQE_BYTE_4_OPCODE_S,
-					       HNS_ROCE_WQE_OP_LOCAL_INV);
-				roce_set_bit(rc_sq_wqe->byte_4,
-					     RC_SQ_WQE_BYTE_4_SO_S, 1);
-				rc_sq_wqe->inv_key =
-						htole32(wr->invalidate_rkey);
-				break;
-			case IBV_WR_ATOMIC_CMP_AND_SWP:
-				roce_set_field(rc_sq_wqe->byte_4,
-					RC_SQ_WQE_BYTE_4_OPCODE_M,
-					RC_SQ_WQE_BYTE_4_OPCODE_S,
-					HNS_ROCE_WQE_OP_ATOMIC_COM_AND_SWAP);
-				rc_sq_wqe->rkey = htole32(wr->wr.atomic.rkey);
-				rc_sq_wqe->va =
-					htole64(wr->wr.atomic.remote_addr);
-				break;
-
-			case IBV_WR_ATOMIC_FETCH_AND_ADD:
-				roce_set_field(rc_sq_wqe->byte_4,
-					RC_SQ_WQE_BYTE_4_OPCODE_M,
-					RC_SQ_WQE_BYTE_4_OPCODE_S,
-					HNS_ROCE_WQE_OP_ATOMIC_FETCH_AND_ADD);
-				rc_sq_wqe->rkey = htole32(wr->wr.atomic.rkey);
-				rc_sq_wqe->va =
-					htole64(wr->wr.atomic.remote_addr);
-				break;
-
-			case IBV_WR_BIND_MW:
-				roce_set_field(rc_sq_wqe->byte_4,
-					RC_SQ_WQE_BYTE_4_OPCODE_M,
-					RC_SQ_WQE_BYTE_4_OPCODE_S,
-					HNS_ROCE_WQE_OP_BIND_MW_TYPE);
-				roce_set_bit(rc_sq_wqe->byte_4,
-					RC_SQ_WQE_BYTE_4_MW_TYPE_S,
-					wr->bind_mw.mw->type - 1);
-				roce_set_bit(rc_sq_wqe->byte_4,
-					RC_SQ_WQE_BYTE_4_ATOMIC_S,
-					wr->bind_mw.bind_info.mw_access_flags &
-					IBV_ACCESS_REMOTE_ATOMIC ? 1 : 0);
-				roce_set_bit(rc_sq_wqe->byte_4,
-					RC_SQ_WQE_BYTE_4_RDMA_READ_S,
-					wr->bind_mw.bind_info.mw_access_flags &
-					IBV_ACCESS_REMOTE_READ ? 1 : 0);
-				roce_set_bit(rc_sq_wqe->byte_4,
-					RC_SQ_WQE_BYTE_4_RDMA_WRITE_S,
-					wr->bind_mw.bind_info.mw_access_flags &
-					IBV_ACCESS_REMOTE_WRITE ? 1 : 0);
-
-				rc_sq_wqe->new_rkey = htole32(wr->bind_mw.rkey);
-				rc_sq_wqe->byte_16 =
-					  htole32(wr->bind_mw.bind_info.length &
-						  0xffffffff);
-				rc_sq_wqe->byte_20 =
-					 htole32(wr->bind_mw.bind_info.length >>
-						 32);
-				rc_sq_wqe->rkey =
-					htole32(wr->bind_mw.bind_info.mr->rkey);
-				rc_sq_wqe->va =
-					    htole64(wr->bind_mw.bind_info.addr);
-				break;
-
-			default:
-				roce_set_field(rc_sq_wqe->byte_4,
-					       RC_SQ_WQE_BYTE_4_OPCODE_M,
-					       RC_SQ_WQE_BYTE_4_OPCODE_S,
-					       HNS_ROCE_WQE_OP_MASK);
-				printf("Not supported transport opcode %d\n",
-				       wr->opcode);
-				break;
+			ret = set_rc_wqe(wqe, qp, wr, nreq, &sge_info);
+			if (ret) {
+				*bad_wr = wr;
+				goto out;
 			}
-
 			break;
 		case IBV_QPT_UC:
 		case IBV_QPT_UD:
 		default:
-			break;
-		}
-
-		dseg = wqe;
-		if (wr->opcode == IBV_WR_ATOMIC_FETCH_AND_ADD ||
-		    wr->opcode == IBV_WR_ATOMIC_CMP_AND_SWP) {
-			set_data_seg_v2(dseg, wr->sg_list);
-			wqe += sizeof(struct hns_roce_v2_wqe_data_seg);
-			set_atomic_seg(wqe, wr);
-		} else if (wr->send_flags & IBV_SEND_INLINE && valid_num_sge) {
-			if (le32toh(rc_sq_wqe->msg_len) > qp->max_inline_data) {
-				ret = EINVAL;
-				*bad_wr = wr;
-				printf("data len=%d, send_flags = 0x%x!\r\n",
-					rc_sq_wqe->msg_len, wr->send_flags);
-				goto out;
-			}
-
-			if (wr->opcode == IBV_WR_RDMA_READ) {
-				ret = EINVAL;
-				*bad_wr = wr;
-				printf("Not supported inline data!\n");
-				goto out;
-			}
-
-			for (i = 0; i < wr->num_sge; i++) {
-				memcpy(wqe,
-				     ((void *) (uintptr_t) wr->sg_list[i].addr),
-				     wr->sg_list[i].length);
-				wqe = wqe + wr->sg_list[i].length;
-			}
-
-			roce_set_bit(rc_sq_wqe->byte_4,
-				     RC_SQ_WQE_BYTE_4_INLINE_S, 1);
-		} else {
-			/* set sge */
-			if (valid_num_sge <= HNS_ROCE_SGE_IN_WQE) {
-				for (i = 0; i < wr->num_sge; i++)
-					if (likely(wr->sg_list[i].length)) {
-						set_data_seg_v2(dseg,
-							       wr->sg_list + i);
-						dseg++;
-					}
-			} else {
-				roce_set_field(rc_sq_wqe->byte_20,
-					RC_SQ_WQE_BYTE_20_MSG_START_SGE_IDX_M,
-					RC_SQ_WQE_BYTE_20_MSG_START_SGE_IDX_S,
-					sge_idx & (qp->sge.sge_cnt - 1));
-
-				for (i = 0; i < wr->num_sge && j < 2; i++)
-					if (likely(wr->sg_list[i].length)) {
-						set_data_seg_v2(dseg,
-							       wr->sg_list + i);
-						dseg++;
-						j++;
-					}
-
-				for (; i < wr->num_sge; i++) {
-					if (likely(wr->sg_list[i].length)) {
-						dseg = get_send_sge_ex(qp,
-							sge_idx &
-							(qp->sge.sge_cnt - 1));
-						set_data_seg_v2(dseg,
-							   wr->sg_list + i);
-						sge_idx++;
-					}
-				}
-			}
+			ret = -EINVAL;
+			*bad_wr = wr;
+			goto out;
 		}
 	}
 
 out:
 	if (likely(nreq)) {
 		qp->sq.head += nreq;
+		qp->next_sge = sge_info.start_idx;
 
 		hns_roce_update_sq_db(ctx, qp->ibv_qp.qp_num, qp->sl,
 				     qp->sq.head & ((qp->sq.wqe_cnt << 1) - 1));
 
 		if (qp->flags & HNS_ROCE_SUPPORT_SQ_RECORD_DB)
 			*(qp->sdb) = qp->sq.head & 0xffff;
-
-		qp->next_sge = sge_idx;
 	}
 
 	pthread_spin_unlock(&qp->sq.lock);
-- 
2.8.1

