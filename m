Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84ABB2782B3
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Sep 2020 10:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgIYIY7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Sep 2020 04:24:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49754 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727044AbgIYIY7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Sep 2020 04:24:59 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4A03239C73612E1F5D16;
        Fri, 25 Sep 2020 16:24:57 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 25 Sep 2020 16:24:47 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Support owner mode doorbell
Date:   Fri, 25 Sep 2020 16:23:34 +0800
Message-ID: <1601022214-56412-1-git-send-email-liweihang@huawei.com>
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
 drivers/infiniband/hw/hns/hns_roce_device.h |  5 ++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 28 ++++++++++++++++++++++------
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  3 +++
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index a8183ef..517c127 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -137,9 +137,10 @@ enum {
 	SERV_TYPE_UD,
 };
 
-enum {
+enum hns_roce_qp_caps {
 	HNS_ROCE_QP_CAP_RQ_RECORD_DB = BIT(0),
 	HNS_ROCE_QP_CAP_SQ_RECORD_DB = BIT(1),
+	HNS_ROCE_QP_CAP_OWNER_DB = BIT(2),
 };
 
 enum hns_roce_cq_flags {
@@ -229,6 +230,8 @@ enum {
 	HNS_ROCE_CAP_FLAG_FRMR                  = BIT(8),
 	HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL		= BIT(9),
 	HNS_ROCE_CAP_FLAG_ATOMIC		= BIT(10),
+	HNS_ROCE_CAP_FLAG_SDI_MODE		= BIT(14),
+	HNS_ROCE_CAP_FLAG_MAX			= BIT(28)
 };
 
 #define HNS_ROCE_DB_TYPE_COUNT			2
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 6d30850..cc89bdb 100644
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
+		wmb();
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
+		wmb();
+
 	*sge_idx = curr_idx;
+	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_OWNER_S,
+		     owner_bit);
 
 	return ret;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 7c3b548..5ae3c5a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -727,6 +727,9 @@ static int alloc_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
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

