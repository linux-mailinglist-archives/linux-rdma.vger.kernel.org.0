Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB8D417F624
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 12:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgCJLV4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 07:21:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53478 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbgCJLV4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 07:21:56 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F126169B5842A520113F;
        Tue, 10 Mar 2020 19:21:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Tue, 10 Mar 2020 19:21:43 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v3 for-next 3/5] RDMA/hns: Optimize the wr opcode conversion from ib to hns
Date:   Tue, 10 Mar 2020 19:18:02 +0800
Message-ID: <1583839084-31579-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1583839084-31579-1-git-send-email-liweihang@huawei.com>
References: <1583839084-31579-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Simplify the wr opcode conversion from ib to hns by using a map table
instead of the switch-case statement.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 63 +++++++++++++++++-------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c8c345f..c813c74 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -56,6 +56,40 @@ static void set_data_seg_v2(struct hns_roce_v2_wqe_data_seg *dseg,
 	dseg->len  = cpu_to_le32(sg->length);
 }
 
+/*
+ * mapped-value = 1 + real-value
+ * The hns wr opcode real value is start from 0, In order to distinguish between
+ * initialized and uninitialized map values, we plus 1 to the actual value when
+ * defining the mapping, so that the validity can be identified by checking the
+ * mapped value is greater than 0.
+ */
+#define HR_OPC_MAP(ib_key, hr_key) \
+		[IB_WR_ ## ib_key] = 1 + HNS_ROCE_V2_WQE_OP_ ## hr_key
+
+static const u32 hns_roce_op_code[] = {
+	HR_OPC_MAP(RDMA_WRITE,			RDMA_WRITE),
+	HR_OPC_MAP(RDMA_WRITE_WITH_IMM,		RDMA_WRITE_WITH_IMM),
+	HR_OPC_MAP(SEND,			SEND),
+	HR_OPC_MAP(SEND_WITH_IMM,		SEND_WITH_IMM),
+	HR_OPC_MAP(RDMA_READ,			RDMA_READ),
+	HR_OPC_MAP(ATOMIC_CMP_AND_SWP,		ATOM_CMP_AND_SWAP),
+	HR_OPC_MAP(ATOMIC_FETCH_AND_ADD,	ATOM_FETCH_AND_ADD),
+	HR_OPC_MAP(SEND_WITH_INV,		SEND_WITH_INV),
+	HR_OPC_MAP(LOCAL_INV,			LOCAL_INV),
+	HR_OPC_MAP(MASKED_ATOMIC_CMP_AND_SWP,	ATOM_MSK_CMP_AND_SWAP),
+	HR_OPC_MAP(MASKED_ATOMIC_FETCH_AND_ADD,	ATOM_MSK_FETCH_AND_ADD),
+	HR_OPC_MAP(REG_MR,			FAST_REG_PMR),
+};
+
+static u32 to_hr_opcode(u32 ib_opcode)
+{
+	if (ib_opcode >= ARRAY_SIZE(hns_roce_op_code))
+		return HNS_ROCE_V2_WQE_OP_MASK;
+
+	return hns_roce_op_code[ib_opcode] ? hns_roce_op_code[ib_opcode] - 1 :
+					     HNS_ROCE_V2_WQE_OP_MASK;
+}
+
 static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 			 void *wqe, const struct ib_reg_wr *wr)
 {
@@ -303,7 +337,6 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 	void *wqe = NULL;
 	bool loopback;
 	u32 tmp_len;
-	u32 hr_op;
 	u8 *smac;
 	int nreq;
 	int ret;
@@ -517,76 +550,52 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 			wqe += sizeof(struct hns_roce_v2_rc_send_wqe);
 			switch (wr->opcode) {
 			case IB_WR_RDMA_READ:
-				hr_op = HNS_ROCE_V2_WQE_OP_RDMA_READ;
 				rc_sq_wqe->rkey =
 					cpu_to_le32(rdma_wr(wr)->rkey);
 				rc_sq_wqe->va =
 					cpu_to_le64(rdma_wr(wr)->remote_addr);
 				break;
 			case IB_WR_RDMA_WRITE:
-				hr_op = HNS_ROCE_V2_WQE_OP_RDMA_WRITE;
 				rc_sq_wqe->rkey =
 					cpu_to_le32(rdma_wr(wr)->rkey);
 				rc_sq_wqe->va =
 					cpu_to_le64(rdma_wr(wr)->remote_addr);
 				break;
 			case IB_WR_RDMA_WRITE_WITH_IMM:
-				hr_op = HNS_ROCE_V2_WQE_OP_RDMA_WRITE_WITH_IMM;
 				rc_sq_wqe->rkey =
 					cpu_to_le32(rdma_wr(wr)->rkey);
 				rc_sq_wqe->va =
 					cpu_to_le64(rdma_wr(wr)->remote_addr);
 				break;
-			case IB_WR_SEND:
-				hr_op = HNS_ROCE_V2_WQE_OP_SEND;
-				break;
-			case IB_WR_SEND_WITH_INV:
-				hr_op = HNS_ROCE_V2_WQE_OP_SEND_WITH_INV;
-				break;
-			case IB_WR_SEND_WITH_IMM:
-				hr_op = HNS_ROCE_V2_WQE_OP_SEND_WITH_IMM;
-				break;
 			case IB_WR_LOCAL_INV:
-				hr_op = HNS_ROCE_V2_WQE_OP_LOCAL_INV;
 				roce_set_bit(rc_sq_wqe->byte_4,
 					       V2_RC_SEND_WQE_BYTE_4_SO_S, 1);
 				rc_sq_wqe->inv_key =
 					    cpu_to_le32(wr->ex.invalidate_rkey);
 				break;
 			case IB_WR_REG_MR:
-				hr_op = HNS_ROCE_V2_WQE_OP_FAST_REG_PMR;
 				set_frmr_seg(rc_sq_wqe, wqe, reg_wr(wr));
 				break;
 			case IB_WR_ATOMIC_CMP_AND_SWP:
-				hr_op = HNS_ROCE_V2_WQE_OP_ATOM_CMP_AND_SWAP;
 				rc_sq_wqe->rkey =
 					cpu_to_le32(atomic_wr(wr)->rkey);
 				rc_sq_wqe->va =
 					cpu_to_le64(atomic_wr(wr)->remote_addr);
 				break;
 			case IB_WR_ATOMIC_FETCH_AND_ADD:
-				hr_op = HNS_ROCE_V2_WQE_OP_ATOM_FETCH_AND_ADD;
 				rc_sq_wqe->rkey =
 					cpu_to_le32(atomic_wr(wr)->rkey);
 				rc_sq_wqe->va =
 					cpu_to_le64(atomic_wr(wr)->remote_addr);
 				break;
-			case IB_WR_MASKED_ATOMIC_CMP_AND_SWP:
-				hr_op =
-				       HNS_ROCE_V2_WQE_OP_ATOM_MSK_CMP_AND_SWAP;
-				break;
-			case IB_WR_MASKED_ATOMIC_FETCH_AND_ADD:
-				hr_op =
-				      HNS_ROCE_V2_WQE_OP_ATOM_MSK_FETCH_AND_ADD;
-				break;
 			default:
-				hr_op = HNS_ROCE_V2_WQE_OP_MASK;
 				break;
 			}
 
 			roce_set_field(rc_sq_wqe->byte_4,
 				       V2_RC_SEND_WQE_BYTE_4_OPCODE_M,
-				       V2_RC_SEND_WQE_BYTE_4_OPCODE_S, hr_op);
+				       V2_RC_SEND_WQE_BYTE_4_OPCODE_S,
+				       to_hr_opcode(wr->opcode));
 
 			if (wr->opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
 			    wr->opcode == IB_WR_ATOMIC_FETCH_AND_ADD)
-- 
2.8.1

