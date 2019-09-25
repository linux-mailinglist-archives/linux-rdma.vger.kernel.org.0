Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE51CBDD44
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 13:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389120AbfIYLj0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Sep 2019 07:39:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59720 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390764AbfIYLj0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Sep 2019 07:39:26 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5749993B4F52F9199E3E;
        Wed, 25 Sep 2019 19:39:21 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Wed, 25 Sep 2019 19:39:13 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v3 rdma-core 2/4] libhns: Bugfix for wqe idx calc of post verbs
Date:   Wed, 25 Sep 2019 19:35:49 +0800
Message-ID: <1569411351-57148-3-git-send-email-liweihang@hisilicon.com>
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

Current wqe idx is calculated before checking wq overflow, this patch
fixes it and simplifies the usage of it.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 providers/hns/hns_roce_u_hw_v1.c | 27 ++++++++-----------
 providers/hns/hns_roce_u_hw_v2.c | 56 +++++++++++++++++++---------------------
 2 files changed, 37 insertions(+), 46 deletions(-)

diff --git a/providers/hns/hns_roce_u_hw_v1.c b/providers/hns/hns_roce_u_hw_v1.c
index fceb57a..6d3aba5 100644
--- a/providers/hns/hns_roce_u_hw_v1.c
+++ b/providers/hns/hns_roce_u_hw_v1.c
@@ -462,7 +462,6 @@ static int hns_roce_u_v1_arm_cq(struct ibv_cq *ibvcq, int solicited)
 static int hns_roce_u_v1_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 				   struct ibv_send_wr **bad_wr)
 {
-	unsigned int ind;
 	void *wqe;
 	int nreq;
 	int ps_opcode, i;
@@ -471,12 +470,10 @@ static int hns_roce_u_v1_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 	struct hns_roce_wqe_data_seg *dseg = NULL;
 	struct hns_roce_qp *qp = to_hr_qp(ibvqp);
 	struct hns_roce_context *ctx = to_hr_ctx(ibvqp->context);
+	unsigned int wqe_idx;
 
 	pthread_spin_lock(&qp->sq.lock);
 
-	/* check that state is OK to post send */
-	ind = qp->sq.head;
-
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
 		if (hns_roce_wq_overflow(&qp->sq, nreq,
 					 to_hr_cq(qp->ibv_qp.send_cq))) {
@@ -484,6 +481,9 @@ static int hns_roce_u_v1_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 			*bad_wr = wr;
 			goto out;
 		}
+
+		wqe_idx = (qp->sq.head + nreq) & (qp->sq.wqe_cnt - 1);
+
 		if (wr->num_sge > qp->sq.max_gs) {
 			ret = -1;
 			*bad_wr = wr;
@@ -492,10 +492,10 @@ static int hns_roce_u_v1_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 			goto out;
 		}
 
-		ctrl = wqe = get_send_wqe(qp, ind & (qp->sq.wqe_cnt - 1));
+		ctrl = wqe = get_send_wqe(qp, wqe_idx);
 		memset(ctrl, 0, sizeof(struct hns_roce_wqe_ctrl_seg));
 
-		qp->sq.wrid[ind & (qp->sq.wqe_cnt - 1)] = wr->wr_id;
+		qp->sq.wrid[wqe_idx] = wr->wr_id;
 		for (i = 0; i < wr->num_sge; i++)
 			ctrl->msg_length = htole32(le32toh(ctrl->msg_length) +
 						   wr->sg_list[i].length);
@@ -578,8 +578,6 @@ static int hns_roce_u_v1_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 			ctrl->flag |=
 			       htole32(wr->num_sge << HNS_ROCE_WQE_SGE_NUM_BIT);
 		}
-
-		ind++;
 	}
 
 out:
@@ -745,17 +743,14 @@ static int hns_roce_u_v1_post_recv(struct ibv_qp *ibvqp, struct ibv_recv_wr *wr,
 {
 	int ret = 0;
 	int nreq;
-	int ind;
 	struct ibv_sge *sg;
 	struct hns_roce_rc_rq_wqe *rq_wqe;
 	struct hns_roce_qp *qp = to_hr_qp(ibvqp);
 	struct hns_roce_context *ctx = to_hr_ctx(ibvqp->context);
+	unsigned int wqe_idx;
 
 	pthread_spin_lock(&qp->rq.lock);
 
-	/* check that state is OK to post receive */
-	ind = qp->rq.head & (qp->rq.wqe_cnt - 1);
-
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
 		if (hns_roce_wq_overflow(&qp->rq, nreq,
 					 to_hr_cq(qp->ibv_qp.recv_cq))) {
@@ -764,13 +759,15 @@ static int hns_roce_u_v1_post_recv(struct ibv_qp *ibvqp, struct ibv_recv_wr *wr,
 			goto out;
 		}
 
+		wqe_idx = (qp->rq.head + nreq) & (qp->rq.wqe_cnt - 1);
+
 		if (wr->num_sge > qp->rq.max_gs) {
 			ret = -1;
 			*bad_wr = wr;
 			goto out;
 		}
 
-		rq_wqe = get_recv_wqe(qp, ind);
+		rq_wqe = get_recv_wqe(qp, wqe_idx);
 		if (wr->num_sge > HNS_ROCE_RC_RQ_WQE_MAX_SGE_NUM) {
 			ret = -1;
 			*bad_wr = wr;
@@ -811,9 +808,7 @@ static int hns_roce_u_v1_post_recv(struct ibv_qp *ibvqp, struct ibv_recv_wr *wr,
 				       HNS_ROCE_RC_RQ_WQE_MAX_SGE_NUM - 2);
 		}
 
-		qp->rq.wrid[ind] = wr->wr_id;
-
-		ind = (ind + 1) & (qp->rq.wqe_cnt - 1);
+		qp->rq.wrid[wqe_idx] = wr->wr_id;
 	}
 
 out:
diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
index 931f59d..439e547 100644
--- a/providers/hns/hns_roce_u_hw_v2.c
+++ b/providers/hns/hns_roce_u_hw_v2.c
@@ -612,27 +612,26 @@ static int hns_roce_u_v2_arm_cq(struct ibv_cq *ibvcq, int solicited)
 int hns_roce_u_v2_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 			    struct ibv_send_wr **bad_wr)
 {
-	unsigned int ind_sge;
-	unsigned int ind;
-	int nreq;
-	void *wqe;
-	int ret = 0;
-	struct hns_roce_qp *qp = to_hr_qp(ibvqp);
 	struct hns_roce_context *ctx = to_hr_ctx(ibvqp->context);
-	struct hns_roce_rc_sq_wqe *rc_sq_wqe;
+	struct hns_roce_qp *qp = to_hr_qp(ibvqp);
 	struct hns_roce_v2_wqe_data_seg *dseg;
+	struct hns_roce_rc_sq_wqe *rc_sq_wqe;
 	struct ibv_qp_attr attr;
+	unsigned int wqe_idx;
+	unsigned int sge_idx;
 	int valid_num_sge;
 	int attr_mask;
+	int ret = 0;
+	void *wqe;
+	int nreq;
 	int j;
 	int i;
 
 	pthread_spin_lock(&qp->sq.lock);
 
-	/* check that state is OK to post send */
-	ind = qp->sq.head;
-	ind_sge = qp->next_sge;
+	sge_idx = qp->next_sge;
 
+	/* check that state is OK to post send */
 	if (ibvqp->state == IBV_QPS_RESET || ibvqp->state == IBV_QPS_INIT ||
 	    ibvqp->state == IBV_QPS_RTR) {
 		pthread_spin_unlock(&qp->sq.lock);
@@ -648,18 +647,19 @@ int hns_roce_u_v2_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 			goto out;
 		}
 
+		wqe_idx = (qp->sq.head + nreq) & (qp->sq.wqe_cnt - 1);
+
 		if (wr->num_sge > qp->sq.max_gs) {
 			ret = EINVAL;
 			*bad_wr = wr;
 			goto out;
 		}
 
-		wqe = get_send_wqe(qp, ind & (qp->sq.wqe_cnt - 1));
+		wqe = get_send_wqe(qp, wqe_idx);
 		rc_sq_wqe = wqe;
 
 		memset(rc_sq_wqe, 0, sizeof(struct hns_roce_rc_sq_wqe));
-
-		qp->sq.wrid[ind & (qp->sq.wqe_cnt - 1)] = wr->wr_id;
+		qp->sq.wrid[wqe_idx] = wr->wr_id;
 
 		valid_num_sge = wr->num_sge;
 		j = 0;
@@ -880,7 +880,7 @@ int hns_roce_u_v2_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 				roce_set_field(rc_sq_wqe->byte_20,
 					RC_SQ_WQE_BYTE_20_MSG_START_SGE_IDX_M,
 					RC_SQ_WQE_BYTE_20_MSG_START_SGE_IDX_S,
-					ind_sge & (qp->sge.sge_cnt - 1));
+					sge_idx & (qp->sge.sge_cnt - 1));
 
 				for (i = 0; i < wr->num_sge && j < 2; i++)
 					if (likely(wr->sg_list[i].length)) {
@@ -893,17 +893,15 @@ int hns_roce_u_v2_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 				for (; i < wr->num_sge; i++) {
 					if (likely(wr->sg_list[i].length)) {
 						dseg = get_send_sge_ex(qp,
-							ind_sge &
+							sge_idx &
 							(qp->sge.sge_cnt - 1));
 						set_data_seg_v2(dseg,
 							   wr->sg_list + i);
-						ind_sge++;
+						sge_idx++;
 					}
 				}
 			}
 		}
-
-		ind++;
 	}
 
 out:
@@ -916,7 +914,7 @@ out:
 		if (qp->flags & HNS_ROCE_SUPPORT_SQ_RECORD_DB)
 			*(qp->sdb) = qp->sq.head & 0xffff;
 
-		qp->next_sge = ind_sge;
+		qp->next_sge = sge_idx;
 	}
 
 	pthread_spin_unlock(&qp->sq.lock);
@@ -936,23 +934,21 @@ out:
 static int hns_roce_u_v2_post_recv(struct ibv_qp *ibvqp, struct ibv_recv_wr *wr,
 				   struct ibv_recv_wr **bad_wr)
 {
-	int ret = 0;
-	int nreq;
-	int ind;
 	struct hns_roce_qp *qp = to_hr_qp(ibvqp);
 	struct hns_roce_context *ctx = to_hr_ctx(ibvqp->context);
 	struct hns_roce_v2_wqe_data_seg *dseg;
 	struct hns_roce_rinl_sge *sge_list;
 	struct ibv_qp_attr attr;
 	int attr_mask;
+	int ret = 0;
+	int wqe_idx;
 	void *wqe;
+	int nreq;
 	int i;
 
 	pthread_spin_lock(&qp->rq.lock);
 
 	/* check that state is OK to post receive */
-	ind = qp->rq.head & (qp->rq.wqe_cnt - 1);
-
 	if (ibvqp->state == IBV_QPS_RESET) {
 		pthread_spin_unlock(&qp->rq.lock);
 		*bad_wr = wr;
@@ -967,13 +963,15 @@ static int hns_roce_u_v2_post_recv(struct ibv_qp *ibvqp, struct ibv_recv_wr *wr,
 			goto out;
 		}
 
+		wqe_idx = (qp->rq.head + nreq) & (qp->rq.wqe_cnt - 1);
+
 		if (wr->num_sge > qp->rq.max_gs) {
 			ret = -EINVAL;
 			*bad_wr = wr;
 			goto out;
 		}
 
-		wqe = get_recv_wqe_v2(qp, ind);
+		wqe = get_recv_wqe_v2(qp, wqe_idx);
 		if (!wqe) {
 			ret = -EINVAL;
 			*bad_wr = wr;
@@ -995,8 +993,8 @@ static int hns_roce_u_v2_post_recv(struct ibv_qp *ibvqp, struct ibv_recv_wr *wr,
 		}
 
 		/* QP support receive inline wqe */
-		sge_list = qp->rq_rinl_buf.wqe_list[ind].sg_list;
-		qp->rq_rinl_buf.wqe_list[ind].sge_cnt =
+		sge_list = qp->rq_rinl_buf.wqe_list[wqe_idx].sg_list;
+		qp->rq_rinl_buf.wqe_list[wqe_idx].sge_cnt =
 						(unsigned int)wr->num_sge;
 
 		for (i = 0; i < wr->num_sge; i++) {
@@ -1005,9 +1003,7 @@ static int hns_roce_u_v2_post_recv(struct ibv_qp *ibvqp, struct ibv_recv_wr *wr,
 			sge_list[i].len = wr->sg_list[i].length;
 		}
 
-		qp->rq.wrid[ind] = wr->wr_id;
-
-		ind = (ind + 1) & (qp->rq.wqe_cnt - 1);
+		qp->rq.wrid[wqe_idx] = wr->wr_id;
 	}
 
 out:
-- 
2.8.1

