Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E4522E756
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jul 2020 10:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgG0ILt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jul 2020 04:11:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726278AbgG0ILt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Jul 2020 04:11:49 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 750A8725F996DED08574;
        Mon, 27 Jul 2020 16:11:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 27 Jul 2020 16:11:38 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 4/7] RDMA/hns: Remove redundant parameters in set_rc_wqe()
Date:   Mon, 27 Jul 2020 16:10:46 +0800
Message-ID: <1595837449-29193-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1595837449-29193-1-git-send-email-liweihang@huawei.com>
References: <1595837449-29193-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There are some functions called by set_rc_wqe() use two parameters:
"void *wqe" and "struct hns_roce_v2_rc_send_wqe *rc_sq_wqe", but the first
one can be got from the second one. So remove the redundant wqe from
related functions.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index f5f0862..3077237 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -91,10 +91,11 @@ static u32 to_hr_opcode(u32 ib_opcode)
 }
 
 static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
-			 void *wqe, const struct ib_reg_wr *wr)
+			 const struct ib_reg_wr *wr)
 {
+	struct hns_roce_wqe_frmr_seg *fseg =
+		(void *)rc_sq_wqe + sizeof(struct hns_roce_v2_rc_send_wqe);
 	struct hns_roce_mr *mr = to_hr_mr(wr->mr);
-	struct hns_roce_wqe_frmr_seg *fseg = wqe;
 	u64 pbl_ba;
 
 	/* use ib_access_flags */
@@ -128,14 +129,16 @@ static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 		     V2_RC_FRMR_WQE_BYTE_40_BLK_MODE_S, 0);
 }
 
-static void set_atomic_seg(const struct ib_send_wr *wr, void *wqe,
+static void set_atomic_seg(const struct ib_send_wr *wr,
 			   struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 			   unsigned int valid_num_sge)
 {
-	struct hns_roce_wqe_atomic_seg *aseg;
+	struct hns_roce_v2_wqe_data_seg *dseg =
+		(void *)rc_sq_wqe + sizeof(struct hns_roce_v2_rc_send_wqe);
+	struct hns_roce_wqe_atomic_seg *aseg =
+		(void *)dseg + sizeof(struct hns_roce_v2_wqe_data_seg);
 
-	set_data_seg_v2(wqe, wr->sg_list);
-	aseg = wqe + sizeof(struct hns_roce_v2_wqe_data_seg);
+	set_data_seg_v2(dseg, wr->sg_list);
 
 	if (wr->opcode == IB_WR_ATOMIC_CMP_AND_SWP) {
 		aseg->fetchadd_swap_data = cpu_to_le64(atomic_wr(wr)->swap);
@@ -143,7 +146,7 @@ static void set_atomic_seg(const struct ib_send_wr *wr, void *wqe,
 	} else {
 		aseg->fetchadd_swap_data =
 			cpu_to_le64(atomic_wr(wr)->compare_add);
-		aseg->cmp_data  = 0;
+		aseg->cmp_data = 0;
 	}
 
 	roce_set_field(rc_sq_wqe->byte_16, V2_RC_SEND_WQE_BYTE_16_SGE_NUM_M,
@@ -176,13 +179,15 @@ static void set_extend_sge(struct hns_roce_qp *qp, const struct ib_send_wr *wr,
 
 static int set_rwqe_data_seg(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 			     struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
-			     void *wqe, unsigned int *sge_ind,
+			     unsigned int *sge_ind,
 			     unsigned int valid_num_sge)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
-	struct hns_roce_v2_wqe_data_seg *dseg = wqe;
+	struct hns_roce_v2_wqe_data_seg *dseg =
+		(void *)rc_sq_wqe + sizeof(struct hns_roce_v2_rc_send_wqe);
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_qp *qp = to_hr_qp(ibqp);
+	void *wqe = dseg;
 	int j = 0;
 	int i;
 
@@ -438,7 +443,6 @@ static inline int set_rc_wqe(struct hns_roce_qp *qp,
 	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_OWNER_S,
 		     owner_bit);
 
-	wqe += sizeof(struct hns_roce_v2_rc_send_wqe);
 	switch (wr->opcode) {
 	case IB_WR_RDMA_READ:
 	case IB_WR_RDMA_WRITE:
@@ -451,7 +455,7 @@ static inline int set_rc_wqe(struct hns_roce_qp *qp,
 		rc_sq_wqe->inv_key = cpu_to_le32(wr->ex.invalidate_rkey);
 		break;
 	case IB_WR_REG_MR:
-		set_frmr_seg(rc_sq_wqe, wqe, reg_wr(wr));
+		set_frmr_seg(rc_sq_wqe, reg_wr(wr));
 		break;
 	case IB_WR_ATOMIC_CMP_AND_SWP:
 	case IB_WR_ATOMIC_FETCH_AND_ADD:
@@ -468,10 +472,10 @@ static inline int set_rc_wqe(struct hns_roce_qp *qp,
 
 	if (wr->opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
 	    wr->opcode == IB_WR_ATOMIC_FETCH_AND_ADD)
-		set_atomic_seg(wr, wqe, rc_sq_wqe, valid_num_sge);
+		set_atomic_seg(wr, rc_sq_wqe, valid_num_sge);
 	else if (wr->opcode != IB_WR_REG_MR)
 		ret = set_rwqe_data_seg(&qp->ibqp, wr, rc_sq_wqe,
-					wqe, &curr_idx, valid_num_sge);
+					&curr_idx, valid_num_sge);
 
 	*sge_idx = curr_idx;
 
-- 
2.8.1

