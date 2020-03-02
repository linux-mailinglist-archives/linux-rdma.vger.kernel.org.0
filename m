Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7002175A2C
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 13:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgCBMPW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 07:15:22 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:48880 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727691AbgCBMPW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Mar 2020 07:15:22 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9D60ACA312D4E5BF3C9A;
        Mon,  2 Mar 2020 20:15:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Mon, 2 Mar 2020 20:15:08 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 2/5] RDMA/hns: Optimize wqe buffer filling process for post send
Date:   Mon, 2 Mar 2020 20:11:30 +0800
Message-ID: <1583151093-30402-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1583151093-30402-1-git-send-email-liweihang@huawei.com>
References: <1583151093-30402-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Encapsulates the wqe buffer process details for datagram seg, fast mr seg
and atomic seg.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 63 +++++++++++++++---------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 88d671a..c8c345f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -57,10 +57,10 @@ static void set_data_seg_v2(struct hns_roce_v2_wqe_data_seg *dseg,
 }
 
 static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
-			 struct hns_roce_wqe_frmr_seg *fseg,
-			 const struct ib_reg_wr *wr)
+			 void *wqe, const struct ib_reg_wr *wr)
 {
 	struct hns_roce_mr *mr = to_hr_mr(wr->mr);
+	struct hns_roce_wqe_frmr_seg *fseg = wqe;
 
 	/* use ib_access_flags */
 	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_FRMR_WQE_BYTE_4_BIND_EN_S,
@@ -92,16 +92,26 @@ static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 		     V2_RC_FRMR_WQE_BYTE_40_BLK_MODE_S, 0);
 }
 
-static void set_atomic_seg(struct hns_roce_wqe_atomic_seg *aseg,
-			   const struct ib_atomic_wr *wr)
+static void set_atomic_seg(const struct ib_send_wr *wr, void *wqe,
+			   struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
+			   int valid_num_sge)
 {
-	if (wr->wr.opcode == IB_WR_ATOMIC_CMP_AND_SWP) {
-		aseg->fetchadd_swap_data = cpu_to_le64(wr->swap);
-		aseg->cmp_data  = cpu_to_le64(wr->compare_add);
+	struct hns_roce_wqe_atomic_seg *aseg;
+
+	set_data_seg_v2(wqe, wr->sg_list);
+	aseg = wqe + sizeof(struct hns_roce_v2_wqe_data_seg);
+
+	if (wr->opcode == IB_WR_ATOMIC_CMP_AND_SWP) {
+		aseg->fetchadd_swap_data = cpu_to_le64(atomic_wr(wr)->swap);
+		aseg->cmp_data = cpu_to_le64(atomic_wr(wr)->compare_add);
 	} else {
-		aseg->fetchadd_swap_data = cpu_to_le64(wr->compare_add);
+		aseg->fetchadd_swap_data =
+			cpu_to_le64(atomic_wr(wr)->compare_add);
 		aseg->cmp_data  = 0;
 	}
+
+	roce_set_field(rc_sq_wqe->byte_16, V2_RC_SEND_WQE_BYTE_16_SGE_NUM_M,
+		       V2_RC_SEND_WQE_BYTE_16_SGE_NUM_S, valid_num_sge);
 }
 
 static void set_extend_sge(struct hns_roce_qp *qp, const struct ib_send_wr *wr,
@@ -154,11 +164,11 @@ static void set_extend_sge(struct hns_roce_qp *qp, const struct ib_send_wr *wr,
 static int set_rwqe_data_seg(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 			     struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 			     void *wqe, unsigned int *sge_ind,
-			     int valid_num_sge,
-			     const struct ib_send_wr **bad_wr)
+			     int valid_num_sge)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_v2_wqe_data_seg *dseg = wqe;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_qp *qp = to_hr_qp(ibqp);
 	int j = 0;
 	int i;
@@ -166,15 +176,14 @@ static int set_rwqe_data_seg(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 	if (wr->send_flags & IB_SEND_INLINE && valid_num_sge) {
 		if (le32_to_cpu(rc_sq_wqe->msg_len) >
 		    hr_dev->caps.max_sq_inline) {
-			*bad_wr = wr;
-			dev_err(hr_dev->dev, "inline len(1-%d)=%d, illegal",
-				rc_sq_wqe->msg_len, hr_dev->caps.max_sq_inline);
+			ibdev_err(ibdev, "inline len(1-%d)=%d, illegal",
+				  rc_sq_wqe->msg_len,
+				  hr_dev->caps.max_sq_inline);
 			return -EINVAL;
 		}
 
 		if (wr->opcode == IB_WR_RDMA_READ) {
-			*bad_wr =  wr;
-			dev_err(hr_dev->dev, "Not support inline data!\n");
+			ibdev_err(ibdev, "Not support inline data!\n");
 			return -EINVAL;
 		}
 
@@ -285,7 +294,6 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 	struct hns_roce_v2_ud_send_wqe *ud_sq_wqe;
 	struct hns_roce_v2_rc_send_wqe *rc_sq_wqe;
 	struct hns_roce_qp *qp = to_hr_qp(ibqp);
-	struct hns_roce_wqe_frmr_seg *fseg;
 	struct device *dev = hr_dev->dev;
 	unsigned int owner_bit;
 	unsigned int sge_idx;
@@ -547,8 +555,7 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 				break;
 			case IB_WR_REG_MR:
 				hr_op = HNS_ROCE_V2_WQE_OP_FAST_REG_PMR;
-				fseg = wqe;
-				set_frmr_seg(rc_sq_wqe, fseg, reg_wr(wr));
+				set_frmr_seg(rc_sq_wqe, wqe, reg_wr(wr));
 				break;
 			case IB_WR_ATOMIC_CMP_AND_SWP:
 				hr_op = HNS_ROCE_V2_WQE_OP_ATOM_CMP_AND_SWAP;
@@ -582,23 +589,17 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 				       V2_RC_SEND_WQE_BYTE_4_OPCODE_S, hr_op);
 
 			if (wr->opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
-			    wr->opcode == IB_WR_ATOMIC_FETCH_AND_ADD) {
-				struct hns_roce_v2_wqe_data_seg *dseg;
-
-				dseg = wqe;
-				set_data_seg_v2(dseg, wr->sg_list);
-				wqe += sizeof(struct hns_roce_v2_wqe_data_seg);
-				set_atomic_seg(wqe, atomic_wr(wr));
-				roce_set_field(rc_sq_wqe->byte_16,
-					       V2_RC_SEND_WQE_BYTE_16_SGE_NUM_M,
-					       V2_RC_SEND_WQE_BYTE_16_SGE_NUM_S,
+			    wr->opcode == IB_WR_ATOMIC_FETCH_AND_ADD)
+				set_atomic_seg(wr, wqe, rc_sq_wqe,
 					       valid_num_sge);
-			} else if (wr->opcode != IB_WR_REG_MR) {
+			else if (wr->opcode != IB_WR_REG_MR) {
 				ret = set_rwqe_data_seg(ibqp, wr, rc_sq_wqe,
 							wqe, &sge_idx,
-							valid_num_sge, bad_wr);
-				if (ret)
+							valid_num_sge);
+				if (ret) {
+					*bad_wr = wr;
 					goto out;
+				}
 			}
 		} else {
 			dev_err(dev, "Illegal qp_type(0x%x)\n", ibqp->qp_type);
-- 
2.8.1

