Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD241A95EE
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2020 10:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635698AbgDOIOu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Apr 2020 04:14:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47906 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2635695AbgDOIOt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Apr 2020 04:14:49 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 462873CA2C891AF5AE0F;
        Wed, 15 Apr 2020 16:14:46 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Wed, 15 Apr 2020 16:14:35 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 4/6] RDMA/hns: Simplify the cqe code of poll cq
Date:   Wed, 15 Apr 2020 16:14:33 +0800
Message-ID: <1586938475-37049-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1586938475-37049-1-git-send-email-liweihang@huawei.com>
References: <1586938475-37049-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Encapsulate codes to get status of cqe into a function and use map table
instead of switch-case to reduce cyclomatic complexity of
hns_roce_v2_poll_one().

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 130 +++++++++++++----------------
 1 file changed, 57 insertions(+), 73 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d95af32..dcbb0364 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2954,6 +2954,61 @@ static int hns_roce_v2_sw_poll_cq(struct hns_roce_cq *hr_cq, int num_entries,
 	return npolled;
 }
 
+static void get_cqe_status(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
+			   struct hns_roce_v2_cqe *cqe, struct ib_wc *wc)
+{
+	static const struct {
+		u32 cqe_status;
+		enum ib_wc_status wc_status;
+	} map[] = {
+		{ HNS_ROCE_CQE_V2_SUCCESS, IB_WC_SUCCESS },
+		{ HNS_ROCE_CQE_V2_LOCAL_LENGTH_ERR, IB_WC_LOC_LEN_ERR },
+		{ HNS_ROCE_CQE_V2_LOCAL_QP_OP_ERR, IB_WC_LOC_QP_OP_ERR },
+		{ HNS_ROCE_CQE_V2_LOCAL_PROT_ERR, IB_WC_LOC_PROT_ERR },
+		{ HNS_ROCE_CQE_V2_WR_FLUSH_ERR, IB_WC_WR_FLUSH_ERR },
+		{ HNS_ROCE_CQE_V2_MW_BIND_ERR, IB_WC_MW_BIND_ERR },
+		{ HNS_ROCE_CQE_V2_BAD_RESP_ERR, IB_WC_BAD_RESP_ERR },
+		{ HNS_ROCE_CQE_V2_LOCAL_ACCESS_ERR, IB_WC_LOC_ACCESS_ERR },
+		{ HNS_ROCE_CQE_V2_REMOTE_INVAL_REQ_ERR, IB_WC_REM_INV_REQ_ERR },
+		{ HNS_ROCE_CQE_V2_REMOTE_ACCESS_ERR, IB_WC_REM_ACCESS_ERR },
+		{ HNS_ROCE_CQE_V2_REMOTE_OP_ERR, IB_WC_REM_OP_ERR },
+		{ HNS_ROCE_CQE_V2_TRANSPORT_RETRY_EXC_ERR,
+		  IB_WC_RETRY_EXC_ERR },
+		{ HNS_ROCE_CQE_V2_RNR_RETRY_EXC_ERR, IB_WC_RNR_RETRY_EXC_ERR },
+		{ HNS_ROCE_CQE_V2_REMOTE_ABORT_ERR, IB_WC_REM_ABORT_ERR },
+	};
+
+	u32 cqe_status = roce_get_field(cqe->byte_4, V2_CQE_BYTE_4_STATUS_M,
+					V2_CQE_BYTE_4_STATUS_S);
+	int i;
+
+	wc->status = IB_WC_GENERAL_ERR;
+	for (i = 0; i < ARRAY_SIZE(map); i++)
+		if (cqe_status == map[i].cqe_status) {
+			wc->status = map[i].wc_status;
+			break;
+		}
+
+	if (wc->status == IB_WC_SUCCESS || wc->status == IB_WC_WR_FLUSH_ERR)
+		return;
+
+	ibdev_err(&hr_dev->ib_dev, "error cqe status 0x%x:\n", cqe_status);
+	print_hex_dump(KERN_ERR, "", DUMP_PREFIX_NONE, 16, 4, cqe,
+		       sizeof(*cqe), false);
+
+	/*
+	 * Hip08 hardware cannot flush the WQEs in SQ/RQ if the QP state gets
+	 * into errored mode. Hence, as a workaround to this hardware
+	 * limitation, driver needs to assist in flushing. But the flushing
+	 * operation uses mailbox to convey the QP state to the hardware and
+	 * which can sleep due to the mutex protection around the mailbox calls.
+	 * Hence, use the deferred flush for now. Once wc error detected, the
+	 * flushing operation is needed.
+	 */
+	if (!test_and_set_bit(HNS_ROCE_FLUSH_FLAG, &qp->flush_flag))
+		init_flush_work(hr_dev, qp);
+}
+
 static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 				struct hns_roce_qp **cur_qp, struct ib_wc *wc)
 {
@@ -2965,7 +3020,6 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 	int is_send;
 	u16 wqe_ctr;
 	u32 opcode;
-	u32 status;
 	int qpn;
 	int ret;
 
@@ -2995,7 +3049,6 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 		*cur_qp = hr_qp;
 	}
 
-	hr_qp = *cur_qp;
 	wc->qp = &(*cur_qp)->ibqp;
 	wc->vendor_err = 0;
 
@@ -3030,77 +3083,8 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 		++wq->tail;
 	}
 
-	status = roce_get_field(cqe->byte_4, V2_CQE_BYTE_4_STATUS_M,
-				V2_CQE_BYTE_4_STATUS_S);
-	switch (status & HNS_ROCE_V2_CQE_STATUS_MASK) {
-	case HNS_ROCE_CQE_V2_SUCCESS:
-		wc->status = IB_WC_SUCCESS;
-		break;
-	case HNS_ROCE_CQE_V2_LOCAL_LENGTH_ERR:
-		wc->status = IB_WC_LOC_LEN_ERR;
-		break;
-	case HNS_ROCE_CQE_V2_LOCAL_QP_OP_ERR:
-		wc->status = IB_WC_LOC_QP_OP_ERR;
-		break;
-	case HNS_ROCE_CQE_V2_LOCAL_PROT_ERR:
-		wc->status = IB_WC_LOC_PROT_ERR;
-		break;
-	case HNS_ROCE_CQE_V2_WR_FLUSH_ERR:
-		wc->status = IB_WC_WR_FLUSH_ERR;
-		break;
-	case HNS_ROCE_CQE_V2_MW_BIND_ERR:
-		wc->status = IB_WC_MW_BIND_ERR;
-		break;
-	case HNS_ROCE_CQE_V2_BAD_RESP_ERR:
-		wc->status = IB_WC_BAD_RESP_ERR;
-		break;
-	case HNS_ROCE_CQE_V2_LOCAL_ACCESS_ERR:
-		wc->status = IB_WC_LOC_ACCESS_ERR;
-		break;
-	case HNS_ROCE_CQE_V2_REMOTE_INVAL_REQ_ERR:
-		wc->status = IB_WC_REM_INV_REQ_ERR;
-		break;
-	case HNS_ROCE_CQE_V2_REMOTE_ACCESS_ERR:
-		wc->status = IB_WC_REM_ACCESS_ERR;
-		break;
-	case HNS_ROCE_CQE_V2_REMOTE_OP_ERR:
-		wc->status = IB_WC_REM_OP_ERR;
-		break;
-	case HNS_ROCE_CQE_V2_TRANSPORT_RETRY_EXC_ERR:
-		wc->status = IB_WC_RETRY_EXC_ERR;
-		break;
-	case HNS_ROCE_CQE_V2_RNR_RETRY_EXC_ERR:
-		wc->status = IB_WC_RNR_RETRY_EXC_ERR;
-		break;
-	case HNS_ROCE_CQE_V2_REMOTE_ABORT_ERR:
-		wc->status = IB_WC_REM_ABORT_ERR;
-		break;
-	default:
-		wc->status = IB_WC_GENERAL_ERR;
-		break;
-	}
-
-	/*
-	 * Hip08 hardware cannot flush the WQEs in SQ/RQ if the QP state gets
-	 * into errored mode. Hence, as a workaround to this hardware
-	 * limitation, driver needs to assist in flushing. But the flushing
-	 * operation uses mailbox to convey the QP state to the hardware and
-	 * which can sleep due to the mutex protection around the mailbox calls.
-	 * Hence, use the deferred flush for now. Once wc error detected, the
-	 * flushing operation is needed.
-	 */
-	if (wc->status != IB_WC_SUCCESS &&
-	    wc->status != IB_WC_WR_FLUSH_ERR) {
-		ibdev_err(&hr_dev->ib_dev, "error cqe status is: 0x%x\n",
-			  status & HNS_ROCE_V2_CQE_STATUS_MASK);
-
-		if (!test_and_set_bit(HNS_ROCE_FLUSH_FLAG, &hr_qp->flush_flag))
-			init_flush_work(hr_dev, hr_qp);
-
-		return 0;
-	}
-
-	if (wc->status == IB_WC_WR_FLUSH_ERR)
+	get_cqe_status(hr_dev, *cur_qp, cqe, wc);
+	if (wc->status != IB_WC_SUCCESS)
 		return 0;
 
 	if (is_send) {
-- 
2.8.1

