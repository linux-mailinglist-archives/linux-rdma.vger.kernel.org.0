Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125C4314A8E
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Feb 2021 09:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhBIImE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Feb 2021 03:42:04 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12603 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhBIIlz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Feb 2021 03:41:55 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DZbtD54bdz165Sb;
        Tue,  9 Feb 2021 16:39:48 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Tue, 9 Feb 2021 16:41:07 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v2 for-next] RDMA/hns: Adjust definition of FRMR fields
Date:   Tue, 9 Feb 2021 16:38:43 +0800
Message-ID: <1612859923-44041-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

FRMR is not well-supported on HIP08, it is re-designed for HIP09 and the
position of related fields is changed. Then the ULPs should be forbidden to
use FRMR on older hardwares.

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
This patch is one of series "RDMA/hns: Updates for 5.12", the others have
been applied.

Changes since v1:
* Add check for HW version and rewrite the description.
* Link: https://patchwork.kernel.org/project/linux-rdma/patch/1612517974-31867-6-git-send-email-liweihang@huawei.com/

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 45 +++++++++++++++++-------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 12 ++++----
 2 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d9f94b4..1789273 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -99,16 +99,16 @@ static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 	u64 pbl_ba;
 
 	/* use ib_access_flags */
-	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_FRMR_WQE_BYTE_4_BIND_EN_S,
-		     wr->access & IB_ACCESS_MW_BIND ? 1 : 0);
-	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_FRMR_WQE_BYTE_4_ATOMIC_S,
-		     wr->access & IB_ACCESS_REMOTE_ATOMIC ? 1 : 0);
-	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_FRMR_WQE_BYTE_4_RR_S,
-		     wr->access & IB_ACCESS_REMOTE_READ ? 1 : 0);
-	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_FRMR_WQE_BYTE_4_RW_S,
-		     wr->access & IB_ACCESS_REMOTE_WRITE ? 1 : 0);
-	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_FRMR_WQE_BYTE_4_LW_S,
-		     wr->access & IB_ACCESS_LOCAL_WRITE ? 1 : 0);
+	roce_set_bit(fseg->byte_40, V2_RC_FRMR_WQE_BYTE_40_BIND_EN_S,
+		     !!(wr->access & IB_ACCESS_MW_BIND));
+	roce_set_bit(fseg->byte_40, V2_RC_FRMR_WQE_BYTE_40_ATOMIC_S,
+		     !!(wr->access & IB_ACCESS_REMOTE_ATOMIC));
+	roce_set_bit(fseg->byte_40, V2_RC_FRMR_WQE_BYTE_40_RR_S,
+		     !!(wr->access & IB_ACCESS_REMOTE_READ));
+	roce_set_bit(fseg->byte_40, V2_RC_FRMR_WQE_BYTE_40_RW_S,
+		     !!(wr->access & IB_ACCESS_REMOTE_WRITE));
+	roce_set_bit(fseg->byte_40, V2_RC_FRMR_WQE_BYTE_40_LW_S,
+		     !!(wr->access & IB_ACCESS_LOCAL_WRITE));
 
 	/* Data structure reuse may lead to confusion */
 	pbl_ba = mr->pbl_mtr.hem_cfg.root_ba;
@@ -121,12 +121,10 @@ static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 	rc_sq_wqe->va = cpu_to_le64(wr->mr->iova);
 
 	fseg->pbl_size = cpu_to_le32(mr->npages);
-	roce_set_field(fseg->mode_buf_pg_sz,
-		       V2_RC_FRMR_WQE_BYTE_40_PBL_BUF_PG_SZ_M,
+	roce_set_field(fseg->byte_40, V2_RC_FRMR_WQE_BYTE_40_PBL_BUF_PG_SZ_M,
 		       V2_RC_FRMR_WQE_BYTE_40_PBL_BUF_PG_SZ_S,
 		       to_hr_hw_page_shift(mr->pbl_mtr.hem_cfg.buf_pg_shift));
-	roce_set_bit(fseg->mode_buf_pg_sz,
-		     V2_RC_FRMR_WQE_BYTE_40_BLK_MODE_S, 0);
+	roce_set_bit(fseg->byte_40, V2_RC_FRMR_WQE_BYTE_40_BLK_MODE_S, 0);
 }
 
 static void set_atomic_seg(const struct ib_send_wr *wr,
@@ -522,10 +520,12 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
 	return 0;
 }
 
-static int set_rc_opcode(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
+static int set_rc_opcode(struct hns_roce_dev *hr_dev,
+			 struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 			 const struct ib_send_wr *wr)
 {
 	u32 ib_op = wr->opcode;
+	int ret = 0;
 
 	rc_sq_wqe->immtdata = get_immtdata(wr);
 
@@ -545,7 +545,10 @@ static int set_rc_opcode(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 		rc_sq_wqe->va = cpu_to_le64(atomic_wr(wr)->remote_addr);
 		break;
 	case IB_WR_REG_MR:
-		set_frmr_seg(rc_sq_wqe, reg_wr(wr));
+		if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
+			set_frmr_seg(rc_sq_wqe, reg_wr(wr));
+		else
+			ret = -EOPNOTSUPP;
 		break;
 	case IB_WR_LOCAL_INV:
 		roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_SO_S, 1);
@@ -554,19 +557,23 @@ static int set_rc_opcode(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 		rc_sq_wqe->inv_key = cpu_to_le32(wr->ex.invalidate_rkey);
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 
+	if (unlikely(ret))
+		return ret;
+
 	roce_set_field(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_OPCODE_M,
 		       V2_RC_SEND_WQE_BYTE_4_OPCODE_S, to_hr_opcode(ib_op));
 
-	return 0;
+	return ret;
 }
 static inline int set_rc_wqe(struct hns_roce_qp *qp,
 			     const struct ib_send_wr *wr,
 			     void *wqe, unsigned int *sge_idx,
 			     unsigned int owner_bit)
 {
+	struct hns_roce_dev *hr_dev = to_hr_dev(qp->ibqp.device);
 	struct hns_roce_v2_rc_send_wqe *rc_sq_wqe = wqe;
 	unsigned int curr_idx = *sge_idx;
 	unsigned int valid_num_sge;
@@ -577,7 +584,7 @@ static inline int set_rc_wqe(struct hns_roce_qp *qp,
 
 	rc_sq_wqe->msg_len = cpu_to_le32(msg_len);
 
-	ret = set_rc_opcode(rc_sq_wqe, wr);
+	ret = set_rc_opcode(hr_dev, rc_sq_wqe, wr);
 	if (WARN_ON(ret))
 		return ret;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index f29438c..1da980c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1255,15 +1255,15 @@ struct hns_roce_v2_rc_send_wqe {
 
 #define V2_RC_SEND_WQE_BYTE_4_INLINE_S 12
 
-#define V2_RC_FRMR_WQE_BYTE_4_BIND_EN_S 19
+#define V2_RC_FRMR_WQE_BYTE_40_BIND_EN_S 10
 
-#define V2_RC_FRMR_WQE_BYTE_4_ATOMIC_S 20
+#define V2_RC_FRMR_WQE_BYTE_40_ATOMIC_S 11
 
-#define V2_RC_FRMR_WQE_BYTE_4_RR_S 21
+#define V2_RC_FRMR_WQE_BYTE_40_RR_S 12
 
-#define V2_RC_FRMR_WQE_BYTE_4_RW_S 22
+#define V2_RC_FRMR_WQE_BYTE_40_RW_S 13
 
-#define V2_RC_FRMR_WQE_BYTE_4_LW_S 23
+#define V2_RC_FRMR_WQE_BYTE_40_LW_S 14
 
 #define V2_RC_SEND_WQE_BYTE_4_FLAG_S 31
 
@@ -1280,7 +1280,7 @@ struct hns_roce_v2_rc_send_wqe {
 
 struct hns_roce_wqe_frmr_seg {
 	__le32	pbl_size;
-	__le32	mode_buf_pg_sz;
+	__le32	byte_40;
 };
 
 #define V2_RC_FRMR_WQE_BYTE_40_PBL_BUF_PG_SZ_S	4
-- 
2.8.1

