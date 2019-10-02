Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E014DC8B69
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 16:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfJBOjr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 10:39:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21772 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726000AbfJBOjr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Oct 2019 10:39:47 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x92EM3oj020080
        for <linux-rdma@vger.kernel.org>; Wed, 2 Oct 2019 10:39:45 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vc71re9qs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 02 Oct 2019 10:39:45 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <bmt@zurich.ibm.com>;
        Wed, 2 Oct 2019 15:39:42 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 2 Oct 2019 15:39:39 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x92Edcra32047212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Oct 2019 14:39:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67DF911C066;
        Wed,  2 Oct 2019 14:39:38 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18E0F11C04A;
        Wed,  2 Oct 2019 14:39:38 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.69.152])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Oct 2019 14:39:38 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     bharat@chelsio.com, jgg@ziepe.ca, nirranjan@chelsio.com,
        krishna2@chelsio.com, bvanassche@acm.org, leon@kernel.org,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: [[PATCH v2 for-next]] RDMA/siw: Fix SQ/RQ drain logic
Date:   Wed,  2 Oct 2019 16:38:58 +0200
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19100214-0008-0000-0000-0000031D5D04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100214-0009-0000-0000-00004A3C60DA
Message-Id: <20191002143858.4550-1-bmt@zurich.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-02_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=621 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910020137
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Storage ULPs (e.g. iSER & NVMeOF) use ib_drain_qp() to
drain QP/CQ. Current SIW's own drain routines do not properly
wait until all SQ/RQ elements are completed and reaped
from the CQ. This may cause touch after free issues.
New logic relies on generic __ib_drain_sq()/__ib_drain_rq()
posting a final work request, which SIW immediately flushes
to CQ.

Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
v1 -> v2:
- Accept SQ and RQ work requests, if QP is in ERROR
  state. In that case, immediately flush WR's to CQ.
  This already provides needed functionality to
  support ib_drain_sq()/ib_drain_rq() without extra
  state checking in the fast path.

 drivers/infiniband/sw/siw/siw_main.c  |  20 -----
 drivers/infiniband/sw/siw/siw_verbs.c | 103 +++++++++++++++++++++-----
 2 files changed, 86 insertions(+), 37 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 05a92f997f60..fb01407a310f 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -248,24 +248,6 @@ static struct ib_qp *siw_get_base_qp(struct ib_device *base_dev, int id)
 	return NULL;
 }
 
-static void siw_verbs_sq_flush(struct ib_qp *base_qp)
-{
-	struct siw_qp *qp = to_siw_qp(base_qp);
-
-	down_write(&qp->state_lock);
-	siw_sq_flush(qp);
-	up_write(&qp->state_lock);
-}
-
-static void siw_verbs_rq_flush(struct ib_qp *base_qp)
-{
-	struct siw_qp *qp = to_siw_qp(base_qp);
-
-	down_write(&qp->state_lock);
-	siw_rq_flush(qp);
-	up_write(&qp->state_lock);
-}
-
 static const struct ib_device_ops siw_device_ops = {
 	.owner = THIS_MODULE,
 	.uverbs_abi_ver = SIW_ABI_VERSION,
@@ -284,8 +266,6 @@ static const struct ib_device_ops siw_device_ops = {
 	.destroy_cq = siw_destroy_cq,
 	.destroy_qp = siw_destroy_qp,
 	.destroy_srq = siw_destroy_srq,
-	.drain_rq = siw_verbs_rq_flush,
-	.drain_sq = siw_verbs_sq_flush,
 	.get_dma_mr = siw_get_dma_mr,
 	.get_port_immutable = siw_get_port_immutable,
 	.iw_accept = siw_accept,
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 869e02b69a01..40e68e7a4f39 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -687,6 +687,47 @@ static int siw_copy_inline_sgl(const struct ib_send_wr *core_wr,
 	return bytes;
 }
 
+/* Complete SQ WR's without processing */
+static int siw_sq_flush_wr(struct siw_qp *qp, const struct ib_send_wr *wr,
+			   const struct ib_send_wr **bad_wr)
+{
+	struct siw_sqe sqe = {};
+	int rv = 0;
+
+	while (wr) {
+		sqe.id = wr->wr_id;
+		sqe.opcode = wr->opcode;
+		rv = siw_sqe_complete(qp, &sqe, 0, SIW_WC_WR_FLUSH_ERR);
+		if (rv) {
+			if (bad_wr)
+				*bad_wr = wr;
+			break;
+		}
+		wr = wr->next;
+	}
+	return rv;
+}
+
+/* Complete RQ WR's without processing */
+static int siw_rq_flush_wr(struct siw_qp *qp, const struct ib_recv_wr *wr,
+			   const struct ib_recv_wr **bad_wr)
+{
+	struct siw_rqe rqe = {};
+	int rv = 0;
+
+	while (wr) {
+		rqe.id = wr->wr_id;
+		rv = siw_rqe_complete(qp, &rqe, 0, 0, SIW_WC_WR_FLUSH_ERR);
+		if (rv) {
+			if (bad_wr)
+				*bad_wr = wr;
+			break;
+		}
+		wr = wr->next;
+	}
+	return rv;
+}
+
 /*
  * siw_post_send()
  *
@@ -705,6 +746,12 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 	unsigned long flags;
 	int rv = 0;
 
+	if (wr && !qp->kernel_verbs) {
+		siw_dbg_qp(qp, "wr must be empty for user mapped sq\n");
+		*bad_wr = wr;
+		return -EINVAL;
+	}
+
 	/*
 	 * Try to acquire QP state lock. Must be non-blocking
 	 * to accommodate kernel clients needs.
@@ -715,16 +762,23 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 		return -ENOTCONN;
 	}
 	if (unlikely(qp->attrs.state != SIW_QP_STATE_RTS)) {
+		if (qp->attrs.state == SIW_QP_STATE_ERROR) {
+			/*
+			 * Immediately flush this WR to CQ, if QP
+			 * is in ERROR state. SQ is guaranteed to
+			 * be empty, so WR complets in-order.
+			 *
+			 * Typically triggered by ib_drain_sq().
+			 */
+			rv = siw_sq_flush_wr(qp, wr, bad_wr);
+		} else {
+			rv = -ENOTCONN;
+			*bad_wr = wr;
+			siw_dbg_qp(qp, "QP out of state %d\n",
+				   qp->attrs.state);
+		}
 		up_read(&qp->state_lock);
-		*bad_wr = wr;
-		siw_dbg_qp(qp, "QP out of state %d\n", qp->attrs.state);
-		return -ENOTCONN;
-	}
-	if (wr && !qp->kernel_verbs) {
-		siw_dbg_qp(qp, "wr must be empty for user mapped sq\n");
-		up_read(&qp->state_lock);
-		*bad_wr = wr;
-		return -EINVAL;
+		return rv;
 	}
 	spin_lock_irqsave(&qp->sq_lock, flags);
 
@@ -919,6 +973,13 @@ int siw_post_receive(struct ib_qp *base_qp, const struct ib_recv_wr *wr,
 		*bad_wr = wr;
 		return -EOPNOTSUPP; /* what else from errno.h? */
 	}
+	if (!qp->kernel_verbs) {
+		siw_dbg_qp(qp, "no kernel post_recv for user mapped sq\n");
+		up_read(&qp->state_lock);
+		*bad_wr = wr;
+		return -EINVAL;
+	}
+
 	/*
 	 * Try to acquire QP state lock. Must be non-blocking
 	 * to accommodate kernel clients needs.
@@ -927,16 +988,24 @@ int siw_post_receive(struct ib_qp *base_qp, const struct ib_recv_wr *wr,
 		*bad_wr = wr;
 		return -ENOTCONN;
 	}
-	if (!qp->kernel_verbs) {
-		siw_dbg_qp(qp, "no kernel post_recv for user mapped sq\n");
-		up_read(&qp->state_lock);
-		*bad_wr = wr;
-		return -EINVAL;
-	}
 	if (qp->attrs.state > SIW_QP_STATE_RTS) {
+		if (qp->attrs.state == SIW_QP_STATE_ERROR) {
+			/*
+			 * Immediately flush this WR to CQ, if QP
+			 * is in ERROR state. RQ is guaranteed to
+			 * be empty, so WR complets in-order.
+			 *
+			 * Typically triggered by ib_drain_rq().
+			 */
+			rv = siw_rq_flush_wr(qp, wr, bad_wr);
+		} else {
+			rv = -ENOTCONN;
+			*bad_wr = wr;
+			siw_dbg_qp(qp, "QP out of state %d\n",
+				   qp->attrs.state);
+		}
 		up_read(&qp->state_lock);
-		*bad_wr = wr;
-		return -EINVAL;
+		return rv;
 	}
 	/*
 	 * Serialize potentially multiple producers.
-- 
2.17.2

