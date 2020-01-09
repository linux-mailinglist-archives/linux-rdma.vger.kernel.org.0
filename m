Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54F6D1358F8
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2020 13:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgAIMOp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jan 2020 07:14:45 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45604 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728974AbgAIMOp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 9 Jan 2020 07:14:45 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3DB9BF09C4A82AF0F2FB;
        Thu,  9 Jan 2020 20:14:42 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Thu, 9 Jan 2020 20:14:35 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Bugfix for posting a wqe with sge
Date:   Thu, 9 Jan 2020 20:10:52 +0800
Message-ID: <1578571852-13704-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

Driver should first check whether the sge is valid, then fill the valid
sge and the caculated total into hardware, otherwise invalid sges will
cause an error.

Fixes: 52e3b42a2f58 ("RDMA/hns: Filter for zero length of sge in hip08 kernel mode")
Fixes: 7bdee4158b37 ("RDMA/hns: Fill sq wqe context of ud type in hip08")
Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 41 ++++++++++++++++++------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 00fd40f..fb16908 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -105,7 +105,7 @@ static void set_atomic_seg(struct hns_roce_wqe_atomic_seg *aseg,
 }
 
 static void set_extend_sge(struct hns_roce_qp *qp, const struct ib_send_wr *wr,
-			   unsigned int *sge_ind)
+			   unsigned int *sge_ind, int valid_num_sge)
 {
 	struct hns_roce_v2_wqe_data_seg *dseg;
 	struct ib_sge *sg;
@@ -118,7 +118,7 @@ static void set_extend_sge(struct hns_roce_qp *qp, const struct ib_send_wr *wr,
 
 	if (qp->ibqp.qp_type == IB_QPT_RC || qp->ibqp.qp_type == IB_QPT_UC)
 		num_in_wqe = HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE;
-	extend_sge_num = wr->num_sge - num_in_wqe;
+	extend_sge_num = valid_num_sge - num_in_wqe;
 	sg = wr->sg_list + num_in_wqe;
 	shift = qp->hr_buf.page_shift;
 
@@ -154,14 +154,16 @@ static void set_extend_sge(struct hns_roce_qp *qp, const struct ib_send_wr *wr,
 static int set_rwqe_data_seg(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 			     struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 			     void *wqe, unsigned int *sge_ind,
+			     int valid_num_sge,
 			     const struct ib_send_wr **bad_wr)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_v2_wqe_data_seg *dseg = wqe;
 	struct hns_roce_qp *qp = to_hr_qp(ibqp);
+	int j = 0;
 	int i;
 
-	if (wr->send_flags & IB_SEND_INLINE && wr->num_sge) {
+	if (wr->send_flags & IB_SEND_INLINE && valid_num_sge) {
 		if (le32_to_cpu(rc_sq_wqe->msg_len) >
 		    hr_dev->caps.max_sq_inline) {
 			*bad_wr = wr;
@@ -185,7 +187,7 @@ static int set_rwqe_data_seg(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 		roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_INLINE_S,
 			     1);
 	} else {
-		if (wr->num_sge <= HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE) {
+		if (valid_num_sge <= HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE) {
 			for (i = 0; i < wr->num_sge; i++) {
 				if (likely(wr->sg_list[i].length)) {
 					set_data_seg_v2(dseg, wr->sg_list + i);
@@ -198,19 +200,21 @@ static int set_rwqe_data_seg(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 				     V2_RC_SEND_WQE_BYTE_20_MSG_START_SGE_IDX_S,
 				     (*sge_ind) & (qp->sge.sge_cnt - 1));
 
-			for (i = 0; i < HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE; i++) {
+			for (i = 0; i < wr->num_sge &&
+			     j < HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE; i++) {
 				if (likely(wr->sg_list[i].length)) {
 					set_data_seg_v2(dseg, wr->sg_list + i);
 					dseg++;
+					j++;
 				}
 			}
 
-			set_extend_sge(qp, wr, sge_ind);
+			set_extend_sge(qp, wr, sge_ind, valid_num_sge);
 		}
 
 		roce_set_field(rc_sq_wqe->byte_16,
 			       V2_RC_SEND_WQE_BYTE_16_SGE_NUM_M,
-			       V2_RC_SEND_WQE_BYTE_16_SGE_NUM_S, wr->num_sge);
+			       V2_RC_SEND_WQE_BYTE_16_SGE_NUM_S, valid_num_sge);
 	}
 
 	return 0;
@@ -238,6 +242,7 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 	unsigned int sge_idx;
 	unsigned int wqe_idx;
 	unsigned long flags;
+	int valid_num_sge;
 	void *wqe = NULL;
 	bool loopback;
 	int attr_mask;
@@ -287,8 +292,16 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 		qp->sq.wrid[wqe_idx] = wr->wr_id;
 		owner_bit =
 		       ~(((qp->sq.head + nreq) >> ilog2(qp->sq.wqe_cnt)) & 0x1);
+		valid_num_sge = 0;
 		tmp_len = 0;
 
+		for (i = 0; i < wr->num_sge; i++) {
+			if (likely(wr->sg_list[i].length)) {
+				tmp_len += wr->sg_list[i].length;
+				valid_num_sge++;
+			}
+		}
+
 		/* Corresponding to the QP type, wqe process separately */
 		if (ibqp->qp_type == IB_QPT_GSI) {
 			ud_sq_wqe = wqe;
@@ -324,9 +337,6 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 				       V2_UD_SEND_WQE_BYTE_4_OPCODE_S,
 				       HNS_ROCE_V2_WQE_OP_SEND);
 
-			for (i = 0; i < wr->num_sge; i++)
-				tmp_len += wr->sg_list[i].length;
-
 			ud_sq_wqe->msg_len =
 			 cpu_to_le32(le32_to_cpu(ud_sq_wqe->msg_len) + tmp_len);
 
@@ -362,7 +372,7 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 			roce_set_field(ud_sq_wqe->byte_16,
 				       V2_UD_SEND_WQE_BYTE_16_SGE_NUM_M,
 				       V2_UD_SEND_WQE_BYTE_16_SGE_NUM_S,
-				       wr->num_sge);
+				       valid_num_sge);
 
 			roce_set_field(ud_sq_wqe->byte_20,
 				     V2_UD_SEND_WQE_BYTE_20_MSG_START_SGE_IDX_M,
@@ -417,12 +427,10 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 			memcpy(&ud_sq_wqe->dgid[0], &ah->av.dgid[0],
 			       GID_LEN_V2);
 
-			set_extend_sge(qp, wr, &sge_idx);
+			set_extend_sge(qp, wr, &sge_idx, valid_num_sge);
 		} else if (ibqp->qp_type == IB_QPT_RC) {
 			rc_sq_wqe = wqe;
 			memset(rc_sq_wqe, 0, sizeof(*rc_sq_wqe));
-			for (i = 0; i < wr->num_sge; i++)
-				tmp_len += wr->sg_list[i].length;
 
 			rc_sq_wqe->msg_len =
 			 cpu_to_le32(le32_to_cpu(rc_sq_wqe->msg_len) + tmp_len);
@@ -543,10 +551,11 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 				roce_set_field(rc_sq_wqe->byte_16,
 					       V2_RC_SEND_WQE_BYTE_16_SGE_NUM_M,
 					       V2_RC_SEND_WQE_BYTE_16_SGE_NUM_S,
-					       wr->num_sge);
+					       valid_num_sge);
 			} else if (wr->opcode != IB_WR_REG_MR) {
 				ret = set_rwqe_data_seg(ibqp, wr, rc_sq_wqe,
-							wqe, &sge_idx, bad_wr);
+							wqe, &sge_idx,
+							valid_num_sge, bad_wr);
 				if (ret)
 					goto out;
 			}
-- 
2.8.1

