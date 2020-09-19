Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEB5270CCA
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 12:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgISKEv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Sep 2020 06:04:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13729 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726216AbgISKEv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 19 Sep 2020 06:04:51 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C2EF57AFA1E6039D9A84;
        Sat, 19 Sep 2020 18:04:40 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 18:04:32 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v3 for-next 1/8] RDMA/hns: Refactor process about opcode in post_send()
Date:   Sat, 19 Sep 2020 18:03:15 +0800
Message-ID: <1600509802-44382-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1600509802-44382-1-git-send-email-liweihang@huawei.com>
References: <1600509802-44382-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

According to the IB specifications, the verbs should return an immediate
error when the users set an unsupported opcode. Furthermore, refactor codes
about opcode in process of post_send to make the difference between opcodes
clearer.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 133 +++++++++++++++++------------
 1 file changed, 78 insertions(+), 55 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 3966262..6a217f9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -292,6 +292,33 @@ static unsigned int calc_wr_sge_num(const struct ib_send_wr *wr,
 	return valid_num;
 }
 
+static __le32 get_immtdata(const struct ib_send_wr *wr)
+{
+	switch (wr->opcode) {
+	case IB_WR_SEND_WITH_IMM:
+	case IB_WR_RDMA_WRITE_WITH_IMM:
+		return cpu_to_le32(be32_to_cpu(wr->ex.imm_data));
+	default:
+		return 0;
+	}
+}
+
+static int set_ud_opcode(struct hns_roce_v2_ud_send_wqe *ud_sq_wqe,
+			 const struct ib_send_wr *wr)
+{
+	u32 ib_op = wr->opcode;
+
+	if (ib_op != IB_WR_SEND && ib_op != IB_WR_SEND_WITH_IMM)
+		return -EINVAL;
+
+	ud_sq_wqe->immtdata = get_immtdata(wr);
+
+	roce_set_field(ud_sq_wqe->byte_4, V2_UD_SEND_WQE_BYTE_4_OPCODE_M,
+		       V2_UD_SEND_WQE_BYTE_4_OPCODE_S, to_hr_opcode(ib_op));
+
+	return 0;
+}
+
 static inline int set_ud_wqe(struct hns_roce_qp *qp,
 			     const struct ib_send_wr *wr,
 			     void *wqe, unsigned int *sge_idx,
@@ -300,15 +327,21 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
 	struct hns_roce_dev *hr_dev = to_hr_dev(qp->ibqp.device);
 	struct hns_roce_ah *ah = to_hr_ah(ud_wr(wr)->ah);
 	struct hns_roce_v2_ud_send_wqe *ud_sq_wqe = wqe;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	unsigned int curr_idx = *sge_idx;
 	int valid_num_sge;
 	u32 msg_len = 0;
 	bool loopback;
 	u8 *smac;
+	int ret;
 
 	valid_num_sge = calc_wr_sge_num(wr, &msg_len);
 	memset(ud_sq_wqe, 0, sizeof(*ud_sq_wqe));
 
+	ret = set_ud_opcode(ud_sq_wqe, wr);
+	if (WARN_ON(ret))
+		return ret;
+
 	roce_set_field(ud_sq_wqe->dmac, V2_UD_SEND_WQE_DMAC_0_M,
 		       V2_UD_SEND_WQE_DMAC_0_S, ah->av.mac[0]);
 	roce_set_field(ud_sq_wqe->dmac, V2_UD_SEND_WQE_DMAC_1_M,
@@ -329,23 +362,8 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
 	roce_set_bit(ud_sq_wqe->byte_40,
 		     V2_UD_SEND_WQE_BYTE_40_LBI_S, loopback);
 
-	roce_set_field(ud_sq_wqe->byte_4,
-		       V2_UD_SEND_WQE_BYTE_4_OPCODE_M,
-		       V2_UD_SEND_WQE_BYTE_4_OPCODE_S,
-		       HNS_ROCE_V2_WQE_OP_SEND);
-
 	ud_sq_wqe->msg_len = cpu_to_le32(msg_len);
 
-	switch (wr->opcode) {
-	case IB_WR_SEND_WITH_IMM:
-	case IB_WR_RDMA_WRITE_WITH_IMM:
-		ud_sq_wqe->immtdata = cpu_to_le32(be32_to_cpu(wr->ex.imm_data));
-		break;
-	default:
-		ud_sq_wqe->immtdata = 0;
-		break;
-	}
-
 	/* Set sig attr */
 	roce_set_bit(ud_sq_wqe->byte_4, V2_UD_SEND_WQE_BYTE_4_CQE_S,
 		     (wr->send_flags & IB_SEND_SIGNALED) ? 1 : 0);
@@ -402,34 +420,66 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
 	return 0;
 }
 
+static int set_rc_opcode(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
+			 const struct ib_send_wr *wr)
+{
+	u32 ib_op = wr->opcode;
+
+	rc_sq_wqe->immtdata = get_immtdata(wr);
+
+	switch (ib_op) {
+	case IB_WR_RDMA_READ:
+	case IB_WR_RDMA_WRITE:
+	case IB_WR_RDMA_WRITE_WITH_IMM:
+		rc_sq_wqe->rkey = cpu_to_le32(rdma_wr(wr)->rkey);
+		rc_sq_wqe->va = cpu_to_le64(rdma_wr(wr)->remote_addr);
+		break;
+	case IB_WR_SEND:
+	case IB_WR_SEND_WITH_IMM:
+		break;
+	case IB_WR_ATOMIC_CMP_AND_SWP:
+	case IB_WR_ATOMIC_FETCH_AND_ADD:
+		rc_sq_wqe->rkey = cpu_to_le32(atomic_wr(wr)->rkey);
+		rc_sq_wqe->va = cpu_to_le64(atomic_wr(wr)->remote_addr);
+		break;
+	case IB_WR_REG_MR:
+		set_frmr_seg(rc_sq_wqe, reg_wr(wr));
+		break;
+	case IB_WR_LOCAL_INV:
+		roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_SO_S, 1);
+		fallthrough;
+	case IB_WR_SEND_WITH_INV:
+		rc_sq_wqe->inv_key = cpu_to_le32(wr->ex.invalidate_rkey);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	roce_set_field(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_OPCODE_M,
+		       V2_RC_SEND_WQE_BYTE_4_OPCODE_S, to_hr_opcode(ib_op));
+
+	return 0;
+}
 static inline int set_rc_wqe(struct hns_roce_qp *qp,
 			     const struct ib_send_wr *wr,
 			     void *wqe, unsigned int *sge_idx,
 			     unsigned int owner_bit)
 {
+	struct ib_device *ibdev = &to_hr_dev(qp->ibqp.device)->ib_dev;
 	struct hns_roce_v2_rc_send_wqe *rc_sq_wqe = wqe;
 	unsigned int curr_idx = *sge_idx;
 	unsigned int valid_num_sge;
 	u32 msg_len = 0;
-	int ret = 0;
+	int ret;
 
 	valid_num_sge = calc_wr_sge_num(wr, &msg_len);
 	memset(rc_sq_wqe, 0, sizeof(*rc_sq_wqe));
 
 	rc_sq_wqe->msg_len = cpu_to_le32(msg_len);
 
-	switch (wr->opcode) {
-	case IB_WR_SEND_WITH_IMM:
-	case IB_WR_RDMA_WRITE_WITH_IMM:
-		rc_sq_wqe->immtdata = cpu_to_le32(be32_to_cpu(wr->ex.imm_data));
-		break;
-	case IB_WR_SEND_WITH_INV:
-		rc_sq_wqe->inv_key = cpu_to_le32(wr->ex.invalidate_rkey);
-		break;
-	default:
-		rc_sq_wqe->immtdata = 0;
-		break;
-	}
+	ret = set_rc_opcode(rc_sq_wqe, wr);
+	if (WARN_ON(ret))
+		return ret;
 
 	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_FENCE_S,
 		     (wr->send_flags & IB_SEND_FENCE) ? 1 : 0);
@@ -443,33 +493,6 @@ static inline int set_rc_wqe(struct hns_roce_qp *qp,
 	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_OWNER_S,
 		     owner_bit);
 
-	switch (wr->opcode) {
-	case IB_WR_RDMA_READ:
-	case IB_WR_RDMA_WRITE:
-	case IB_WR_RDMA_WRITE_WITH_IMM:
-		rc_sq_wqe->rkey = cpu_to_le32(rdma_wr(wr)->rkey);
-		rc_sq_wqe->va = cpu_to_le64(rdma_wr(wr)->remote_addr);
-		break;
-	case IB_WR_LOCAL_INV:
-		roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_SO_S, 1);
-		rc_sq_wqe->inv_key = cpu_to_le32(wr->ex.invalidate_rkey);
-		break;
-	case IB_WR_REG_MR:
-		set_frmr_seg(rc_sq_wqe, reg_wr(wr));
-		break;
-	case IB_WR_ATOMIC_CMP_AND_SWP:
-	case IB_WR_ATOMIC_FETCH_AND_ADD:
-		rc_sq_wqe->rkey = cpu_to_le32(atomic_wr(wr)->rkey);
-		rc_sq_wqe->va = cpu_to_le64(atomic_wr(wr)->remote_addr);
-		break;
-	default:
-		break;
-	}
-
-	roce_set_field(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_OPCODE_M,
-		       V2_RC_SEND_WQE_BYTE_4_OPCODE_S,
-		       to_hr_opcode(wr->opcode));
-
 	if (wr->opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
 	    wr->opcode == IB_WR_ATOMIC_FETCH_AND_ADD)
 		set_atomic_seg(wr, rc_sq_wqe, valid_num_sge);
-- 
2.8.1

