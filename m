Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF53B293AF2
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Oct 2020 14:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393999AbgJTMG3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Oct 2020 08:06:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15239 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393992AbgJTMG2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Oct 2020 08:06:28 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E1F7B816C6D238742E46;
        Tue, 20 Oct 2020 20:06:22 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 20 Oct 2020 20:06:12 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v3 for-next] RDMA/hns: Support owner mode doorbell
Date:   Tue, 20 Oct 2020 20:04:53 +0800
Message-ID: <1603195493-22741-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

The doorbell needs to store PI information into QPC, so the RoCEE should
wait for the results of storing, that is, it needs two bus operations to
complete a doorbell. When ROCEE is in SDI mode, multiple doorbells may be
interlocked because the RoCEE can only handle bus operations serially. So a
flag to mark if HIP09 is working in SDI mode is added. When the SDI flag is
set, the ROCEE will ignore the PI information of the doorbell, continue to
fetch wqe and verify its validity by it's owner_bit.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
Changes since v2:
- Replace wmb() with dma_wmb().
link: https://patchwork.kernel.org/project/linux-rdma/patch/1601199901-41677-1-git-send-email-liweihang@huawei.com/

Changes since v1:
- Fix comments from Leon about the unused enum.
link: https://patchwork.kernel.org/patch/11799327/

 drivers/infiniband/hw/hns/hns_roce_device.h |  4 +++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 28 ++++++++++++++++++++++------
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  3 +++
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 6d2acff..07c95d8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -129,9 +129,10 @@ enum {
 	SERV_TYPE_UD,
 };
 
-enum {
+enum hns_roce_qp_caps {
 	HNS_ROCE_QP_CAP_RQ_RECORD_DB = BIT(0),
 	HNS_ROCE_QP_CAP_SQ_RECORD_DB = BIT(1),
+	HNS_ROCE_QP_CAP_OWNER_DB = BIT(2),
 };
 
 enum hns_roce_cq_flags {
@@ -221,6 +222,7 @@ enum {
 	HNS_ROCE_CAP_FLAG_FRMR                  = BIT(8),
 	HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL		= BIT(9),
 	HNS_ROCE_CAP_FLAG_ATOMIC		= BIT(10),
+	HNS_ROCE_CAP_FLAG_SDI_MODE		= BIT(14),
 };
 
 #define HNS_ROCE_DB_TYPE_COUNT			2
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 6d30850..c284b13 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -474,9 +474,6 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
 	roce_set_bit(ud_sq_wqe->byte_4, V2_UD_SEND_WQE_BYTE_4_SE_S,
 		     (wr->send_flags & IB_SEND_SOLICITED) ? 1 : 0);
 
-	roce_set_bit(ud_sq_wqe->byte_4, V2_UD_SEND_WQE_BYTE_4_OWNER_S,
-		     owner_bit);
-
 	roce_set_field(ud_sq_wqe->byte_16, V2_UD_SEND_WQE_BYTE_16_PD_M,
 		       V2_UD_SEND_WQE_BYTE_16_PD_S, to_hr_pd(qp->ibqp.pd)->pdn);
 
@@ -517,7 +514,18 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
 
 	set_extend_sge(qp, wr, &curr_idx, valid_num_sge);
 
+	/*
+	 * The pipeline can sequentially post all valid WQEs into WQ buffer,
+	 * including new WQEs waiting for the doorbell to update the PI again.
+	 * Therefore, the owner bit of WQE MUST be updated after all fields
+	 * and extSGEs have been written into DDR instead of cache.
+	 */
+	if (qp->en_flags & HNS_ROCE_QP_CAP_OWNER_DB)
+		dma_wmb();
+
 	*sge_idx = curr_idx;
+	roce_set_bit(ud_sq_wqe->byte_4, V2_UD_SEND_WQE_BYTE_4_OWNER_S,
+		     owner_bit);
 
 	return 0;
 }
@@ -591,9 +599,6 @@ static inline int set_rc_wqe(struct hns_roce_qp *qp,
 	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_CQE_S,
 		     (wr->send_flags & IB_SEND_SIGNALED) ? 1 : 0);
 
-	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_OWNER_S,
-		     owner_bit);
-
 	if (wr->opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
 	    wr->opcode == IB_WR_ATOMIC_FETCH_AND_ADD)
 		set_atomic_seg(wr, rc_sq_wqe, valid_num_sge);
@@ -601,7 +606,18 @@ static inline int set_rc_wqe(struct hns_roce_qp *qp,
 		ret = set_rwqe_data_seg(&qp->ibqp, wr, rc_sq_wqe,
 					&curr_idx, valid_num_sge);
 
+	/*
+	 * The pipeline can sequentially post all valid WQEs into WQ buffer,
+	 * including new WQEs waiting for the doorbell to update the PI again.
+	 * Therefore, the owner bit of WQE MUST be updated after all fields
+	 * and extSGEs have been written into DDR instead of cache.
+	 */
+	if (qp->en_flags & HNS_ROCE_QP_CAP_OWNER_DB)
+		dma_wmb();
+
 	*sge_idx = curr_idx;
+	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_OWNER_S,
+		     owner_bit);
 
 	return ret;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 6c081dd..5370b6e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -725,6 +725,9 @@ static int alloc_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	int ret;
 
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SDI_MODE)
+		hr_qp->en_flags |= HNS_ROCE_QP_CAP_OWNER_DB;
+
 	if (udata) {
 		if (user_qp_has_sdb(hr_dev, init_attr, udata, resp, ucmd)) {
 			ret = hns_roce_db_map_user(uctx, udata, ucmd->sdb_addr,
-- 
2.8.1

