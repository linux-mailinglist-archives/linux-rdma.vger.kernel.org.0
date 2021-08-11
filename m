Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B3F3E899F
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Aug 2021 07:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbhHKFR1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Aug 2021 01:17:27 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:5276 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229730AbhHKFR1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Aug 2021 01:17:27 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17B5AqWB018541;
        Tue, 10 Aug 2021 22:16:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=M28B4M0FbL64AVazwNHCNPGzwiRU7nj14SAYoElESis=;
 b=Vj/Yt8b7bVrwpIXGQ+pgHotHjOH5gAc7PYAHChzlan13/00AielAR0f8VgKu6+N6M4d+
 2QyWepjDheTC8Dw/6iMbreTijNOh8EQg1f1WnnssAzDkpY7hblZ6i9nE7D8m6J3nOzZI
 u9dCEoArv08QzTZyiiF2SX24RVPQUNan48sDOIFktMZx25IfJCi+4GRdJvv8yrjvKCjY
 UdnWWMvZVsznc2zrvo/JCvrDJDClOC5ehL/U48BMhZ4yMCv0wbvxG+WJ2miI73pcAeT1
 fDMjFL/ZPhLXw9xnDN/DolD5Vujqbw0rfyGYeJVziunhCGXHgeFUf8odThgsGaYQQHAa 9Q== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 3abrft3k7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 10 Aug 2021 22:16:58 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 10 Aug
 2021 22:16:55 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Tue, 10 Aug 2021 22:16:53 -0700
From:   Prabhakar Kushwaha <pkushwaha@marvell.com>
To:     <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <jgg@nvidia.com>, <mkalderon@marvell.com>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <smalin@marvell.com>,
        <aelior@marvell.com>, <pkushwaha@marvell.com>,
        <prabhakar.pkin@gmail.com>, <malin1024@gmail.com>
Subject: [PATCH for-next] qedr: Move variables reset to qedr_set_common_qp_params()
Date:   Wed, 11 Aug 2021 08:16:50 +0300
Message-ID: <20210811051650.14914-1-pkushwaha@marvell.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7ZnHYiVqZw-_OpHy1NkS-zLBrNdDzeaJ
X-Proofpoint-GUID: 7ZnHYiVqZw-_OpHy1NkS-zLBrNdDzeaJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-11_01:2021-08-10,2021-08-11 signatures=0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Qedr code is tightly coupled with existing both INIT transitions.
Here, during first INIT transition all variables are reset and
the RESET state is checked in post_recv() before any posting.

Commit dc70f7c3ed34 ("RDMA/cma: Remove unnecessary INIT->INIT
transition") exposed this bug.

So moving variables reset to qedr_set_common_qp_params() and also
avoid RESET state check for post_recv().

Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
---
 drivers/infiniband/hw/qedr/verbs.c | 32 +++++++++++++-----------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index fdc47ef7d861..6b3c7bfbd3bd 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1339,6 +1339,15 @@ static int qedr_copy_qp_uresp(struct qedr_dev *dev,
 	return rc;
 }
 
+static void qedr_reset_qp_hwq_info(struct qedr_qp_hwq_info *qph)
+{
+	qed_chain_reset(&qph->pbl);
+	qph->prod = 0;
+	qph->cons = 0;
+	qph->wqe_cons = 0;
+	qph->db_data.data.value = cpu_to_le16(0);
+}
+
 static void qedr_set_common_qp_params(struct qedr_dev *dev,
 				      struct qedr_qp *qp,
 				      struct qedr_pd *pd,
@@ -1354,9 +1363,13 @@ static void qedr_set_common_qp_params(struct qedr_dev *dev,
 	qp->qp_type = attrs->qp_type;
 	qp->max_inline_data = attrs->cap.max_inline_data;
 	qp->state = QED_ROCE_QP_STATE_RESET;
+
+	qp->prev_wqe_size = 0;
+
 	qp->signaled = (attrs->sq_sig_type == IB_SIGNAL_ALL_WR) ? true : false;
 	qp->dev = dev;
 	if (qedr_qp_has_sq(qp)) {
+		qedr_reset_qp_hwq_info(&qp->sq);
 		qp->sq.max_sges = attrs->cap.max_send_sge;
 		qp->sq_cq = get_qedr_cq(attrs->send_cq);
 		DP_DEBUG(dev, QEDR_MSG_QP,
@@ -1368,6 +1381,7 @@ static void qedr_set_common_qp_params(struct qedr_dev *dev,
 		qp->srq = get_qedr_srq(attrs->srq);
 
 	if (qedr_qp_has_rq(qp)) {
+		qedr_reset_qp_hwq_info(&qp->rq);
 		qp->rq_cq = get_qedr_cq(attrs->recv_cq);
 		qp->rq.max_sges = attrs->cap.max_recv_sge;
 		DP_DEBUG(dev, QEDR_MSG_QP,
@@ -2359,15 +2373,6 @@ static enum qed_roce_qp_state qedr_get_state_from_ibqp(
 	}
 }
 
-static void qedr_reset_qp_hwq_info(struct qedr_qp_hwq_info *qph)
-{
-	qed_chain_reset(&qph->pbl);
-	qph->prod = 0;
-	qph->cons = 0;
-	qph->wqe_cons = 0;
-	qph->db_data.data.value = cpu_to_le16(0);
-}
-
 static int qedr_update_qp_state(struct qedr_dev *dev,
 				struct qedr_qp *qp,
 				enum qed_roce_qp_state cur_state,
@@ -2382,9 +2387,6 @@ static int qedr_update_qp_state(struct qedr_dev *dev,
 	case QED_ROCE_QP_STATE_RESET:
 		switch (new_state) {
 		case QED_ROCE_QP_STATE_INIT:
-			qp->prev_wqe_size = 0;
-			qedr_reset_qp_hwq_info(&qp->sq);
-			qedr_reset_qp_hwq_info(&qp->rq);
 			break;
 		default:
 			status = -EINVAL;
@@ -3915,12 +3917,6 @@ int qedr_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 
 	spin_lock_irqsave(&qp->q_lock, flags);
 
-	if (qp->state == QED_ROCE_QP_STATE_RESET) {
-		spin_unlock_irqrestore(&qp->q_lock, flags);
-		*bad_wr = wr;
-		return -EINVAL;
-	}
-
 	while (wr) {
 		int i;
 
-- 
2.24.1

