Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 931E4CBADD
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 14:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387473AbfJDMyH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 08:54:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60696 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726024AbfJDMyH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 08:54:07 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x94ClkYa008941
        for <linux-rdma@vger.kernel.org>; Fri, 4 Oct 2019 08:54:05 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vdwym8ps8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 04 Oct 2019 08:54:05 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <bmt@zurich.ibm.com>;
        Fri, 4 Oct 2019 13:54:03 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 4 Oct 2019 13:53:59 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x94CrT3L40567226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Oct 2019 12:53:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A736BA4060;
        Fri,  4 Oct 2019 12:53:58 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57211A405C;
        Fri,  4 Oct 2019 12:53:58 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.69.152])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Oct 2019 12:53:58 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     bharat@chelsio.com, jgg@ziepe.ca, nirranjan@chelsio.com,
        krishna2@chelsio.com, bvanassche@acm.org, leon@kernel.org,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: [[PATCH v3 for-next]] RDMA/siw: Fix SQ/RQ drain logic
Date:   Fri,  4 Oct 2019 14:53:56 +0200
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19100412-0028-0000-0000-000003A6021E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100412-0029-0000-0000-000024680CCA
Message-Id: <20191004125356.20673-1-bmt@zurich.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-04_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=632 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910040118
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
v2 -> v3:
- Handle ib_drain_sq()/ib_drain_rq() calls when QP's
  state is currently locked.

v1 -> v2:
- Accept SQ and RQ work requests, if QP is in ERROR
  state. In that case, immediately flush WR's to CQ.
  This already provides needed functionality to
  support ib_drain_sq()/ib_drain_rq() without extra
  state checking in the fast path.

 drivers/infiniband/sw/siw/siw_main.c  |  20 ----
 drivers/infiniband/sw/siw/siw_verbs.c | 144 ++++++++++++++++++++++----
 2 files changed, 122 insertions(+), 42 deletions(-)

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
index 869e02b69a01..c0574ddc98fa 100644
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
@@ -705,26 +746,54 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
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
 	 */
 	if (!down_read_trylock(&qp->state_lock)) {
-		*bad_wr = wr;
-		siw_dbg_qp(qp, "QP locked, state %d\n", qp->attrs.state);
-		return -ENOTCONN;
+		if (qp->attrs.state == SIW_QP_STATE_ERROR) {
+			/*
+			 * ERROR state is final, so we can be sure
+			 * this state will not change as long as the QP
+			 * exists.
+			 *
+			 * This handles an ib_drain_sq() call with
+			 * a concurrent request to set the QP state
+			 * to ERROR.
+			 */
+			rv = siw_sq_flush_wr(qp, wr, bad_wr);
+		} else {
+			siw_dbg_qp(qp, "QP locked, state %d\n",
+				   qp->attrs.state);
+			*bad_wr = wr;
+			rv = -ENOTCONN;
+		}
+		return rv;
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
+			siw_dbg_qp(qp, "QP out of state %d\n",
+				   qp->attrs.state);
+			*bad_wr = wr;
+			rv = -ENOTCONN;
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
 
@@ -919,24 +988,55 @@ int siw_post_receive(struct ib_qp *base_qp, const struct ib_recv_wr *wr,
 		*bad_wr = wr;
 		return -EOPNOTSUPP; /* what else from errno.h? */
 	}
-	/*
-	 * Try to acquire QP state lock. Must be non-blocking
-	 * to accommodate kernel clients needs.
-	 */
-	if (!down_read_trylock(&qp->state_lock)) {
-		*bad_wr = wr;
-		return -ENOTCONN;
-	}
 	if (!qp->kernel_verbs) {
 		siw_dbg_qp(qp, "no kernel post_recv for user mapped sq\n");
 		up_read(&qp->state_lock);
 		*bad_wr = wr;
 		return -EINVAL;
 	}
+
+	/*
+	 * Try to acquire QP state lock. Must be non-blocking
+	 * to accommodate kernel clients needs.
+	 */
+	if (!down_read_trylock(&qp->state_lock)) {
+		if (qp->attrs.state == SIW_QP_STATE_ERROR) {
+			/*
+			 * ERROR state is final, so we can be sure
+			 * this state will not change as long as the QP
+			 * exists.
+			 *
+			 * This handles an ib_drain_rq() call with
+			 * a concurrent request to set the QP state
+			 * to ERROR.
+			 */
+			rv = siw_rq_flush_wr(qp, wr, bad_wr);
+		} else {
+			siw_dbg_qp(qp, "QP locked, state %d\n",
+				   qp->attrs.state);
+			*bad_wr = wr;
+			rv = -ENOTCONN;
+		}
+		return rv;
+	}
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
+			siw_dbg_qp(qp, "QP out of state %d\n",
+				   qp->attrs.state);
+			*bad_wr = wr;
+			rv = -ENOTCONN;
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

