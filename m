Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38699DC5E9
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 15:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408348AbfJRNWX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 18 Oct 2019 09:22:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408343AbfJRNWW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Oct 2019 09:22:22 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9IDJBsh004261
        for <linux-rdma@vger.kernel.org>; Fri, 18 Oct 2019 09:22:21 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.73])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vqduj90rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 18 Oct 2019 09:22:21 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 18 Oct 2019 13:22:20 -0000
Received: from us1a3-smtp02.a3.dal06.isc4sb.com (10.106.154.159)
        by smtp.notes.na.collabserv.com (10.106.227.90) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 18 Oct 2019 13:22:12 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp02.a3.dal06.isc4sb.com
          with ESMTP id 2019101813221101-499392 ;
          Fri, 18 Oct 2019 13:22:11 +0000 
In-Reply-To: <20191004125356.20673-1-bmt@zurich.ibm.com>
Subject: Re: [[PATCH v3 for-next]] RDMA/siw: Fix SQ/RQ drain logic
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     bharat@chelsio.com, jgg@ziepe.ca, nirranjan@chelsio.com,
        krishna2@chelsio.com, bvanassche@acm.org, leon@kernel.org,
        "Bernard Metzler" <BMT@zurich.ibm.com>
Date:   Fri, 18 Oct 2019 13:22:11 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20191004125356.20673-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP59 September 23, 2019 at 18:08
X-LLNOutbound: False
X-Disclaimed: 25643
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19101813-8877-0000-0000-000001815E9F
X-IBM-SpamModules-Scores: BY=0.066208; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.031315
X-IBM-SpamModules-Versions: BY=3.00011959; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01277210; UDB=6.00676559; IPR=6.01059329;
 MB=3.00029142; MTD=3.00000008; XFM=3.00000015; UTC=2019-10-18 13:22:18
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-10-18 08:31:00 - 6.00010540
x-cbparentid: 19101813-8878-0000-0000-0000563F6616
Message-Id: <OF30CE2323.3FB3125D-ON00258497.00497128-00258497.00497133@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-18_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Bernard Metzler" <bmt@zurich.ibm.com> wrote: -----

>To: linux-rdma@vger.kernel.org
>From: "Bernard Metzler" <bmt@zurich.ibm.com>
>Date: 10/04/2019 02:54PM
>Cc: bharat@chelsio.com, jgg@ziepe.ca, nirranjan@chelsio.com,
>krishna2@chelsio.com, bvanassche@acm.org, leon@kernel.org, "Bernard
>Metzler" <bmt@zurich.ibm.com>
>Subject: [[PATCH v3 for-next]] RDMA/siw: Fix SQ/RQ drain logic
>
>Storage ULPs (e.g. iSER & NVMeOF) use ib_drain_qp() to
>drain QP/CQ. Current SIW's own drain routines do not properly
>wait until all SQ/RQ elements are completed and reaped
>from the CQ. This may cause touch after free issues.
>New logic relies on generic __ib_drain_sq()/__ib_drain_rq()
>posting a final work request, which SIW immediately flushes
>to CQ.
>
>Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
>Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
>Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>---
>v2 -> v3:
>- Handle ib_drain_sq()/ib_drain_rq() calls when QP's
>  state is currently locked.
>
>v1 -> v2:
>- Accept SQ and RQ work requests, if QP is in ERROR
>  state. In that case, immediately flush WR's to CQ.
>  This already provides needed functionality to
>  support ib_drain_sq()/ib_drain_rq() without extra
>  state checking in the fast path.
>
> drivers/infiniband/sw/siw/siw_main.c  |  20 ----
> drivers/infiniband/sw/siw/siw_verbs.c | 144
>++++++++++++++++++++++----
> 2 files changed, 122 insertions(+), 42 deletions(-)
>

Is there any more comment on that one? I think it has been
sufficiently discussed and it is well understood, and it fixes
the issue at hand.

Thanks very much,
Bernard.

>diff --git a/drivers/infiniband/sw/siw/siw_main.c
>b/drivers/infiniband/sw/siw/siw_main.c
>index 05a92f997f60..fb01407a310f 100644
>--- a/drivers/infiniband/sw/siw/siw_main.c
>+++ b/drivers/infiniband/sw/siw/siw_main.c
>@@ -248,24 +248,6 @@ static struct ib_qp *siw_get_base_qp(struct
>ib_device *base_dev, int id)
> 	return NULL;
> }
> 
>-static void siw_verbs_sq_flush(struct ib_qp *base_qp)
>-{
>-	struct siw_qp *qp = to_siw_qp(base_qp);
>-
>-	down_write(&qp->state_lock);
>-	siw_sq_flush(qp);
>-	up_write(&qp->state_lock);
>-}
>-
>-static void siw_verbs_rq_flush(struct ib_qp *base_qp)
>-{
>-	struct siw_qp *qp = to_siw_qp(base_qp);
>-
>-	down_write(&qp->state_lock);
>-	siw_rq_flush(qp);
>-	up_write(&qp->state_lock);
>-}
>-
> static const struct ib_device_ops siw_device_ops = {
> 	.owner = THIS_MODULE,
> 	.uverbs_abi_ver = SIW_ABI_VERSION,
>@@ -284,8 +266,6 @@ static const struct ib_device_ops siw_device_ops
>= {
> 	.destroy_cq = siw_destroy_cq,
> 	.destroy_qp = siw_destroy_qp,
> 	.destroy_srq = siw_destroy_srq,
>-	.drain_rq = siw_verbs_rq_flush,
>-	.drain_sq = siw_verbs_sq_flush,
> 	.get_dma_mr = siw_get_dma_mr,
> 	.get_port_immutable = siw_get_port_immutable,
> 	.iw_accept = siw_accept,
>diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
>b/drivers/infiniband/sw/siw/siw_verbs.c
>index 869e02b69a01..c0574ddc98fa 100644
>--- a/drivers/infiniband/sw/siw/siw_verbs.c
>+++ b/drivers/infiniband/sw/siw/siw_verbs.c
>@@ -687,6 +687,47 @@ static int siw_copy_inline_sgl(const struct
>ib_send_wr *core_wr,
> 	return bytes;
> }
> 
>+/* Complete SQ WR's without processing */
>+static int siw_sq_flush_wr(struct siw_qp *qp, const struct
>ib_send_wr *wr,
>+			   const struct ib_send_wr **bad_wr)
>+{
>+	struct siw_sqe sqe = {};
>+	int rv = 0;
>+
>+	while (wr) {
>+		sqe.id = wr->wr_id;
>+		sqe.opcode = wr->opcode;
>+		rv = siw_sqe_complete(qp, &sqe, 0, SIW_WC_WR_FLUSH_ERR);
>+		if (rv) {
>+			if (bad_wr)
>+				*bad_wr = wr;
>+			break;
>+		}
>+		wr = wr->next;
>+	}
>+	return rv;
>+}
>+
>+/* Complete RQ WR's without processing */
>+static int siw_rq_flush_wr(struct siw_qp *qp, const struct
>ib_recv_wr *wr,
>+			   const struct ib_recv_wr **bad_wr)
>+{
>+	struct siw_rqe rqe = {};
>+	int rv = 0;
>+
>+	while (wr) {
>+		rqe.id = wr->wr_id;
>+		rv = siw_rqe_complete(qp, &rqe, 0, 0, SIW_WC_WR_FLUSH_ERR);
>+		if (rv) {
>+			if (bad_wr)
>+				*bad_wr = wr;
>+			break;
>+		}
>+		wr = wr->next;
>+	}
>+	return rv;
>+}
>+
> /*
>  * siw_post_send()
>  *
>@@ -705,26 +746,54 @@ int siw_post_send(struct ib_qp *base_qp, const
>struct ib_send_wr *wr,
> 	unsigned long flags;
> 	int rv = 0;
> 
>+	if (wr && !qp->kernel_verbs) {
>+		siw_dbg_qp(qp, "wr must be empty for user mapped sq\n");
>+		*bad_wr = wr;
>+		return -EINVAL;
>+	}
>+
> 	/*
> 	 * Try to acquire QP state lock. Must be non-blocking
> 	 * to accommodate kernel clients needs.
> 	 */
> 	if (!down_read_trylock(&qp->state_lock)) {
>-		*bad_wr = wr;
>-		siw_dbg_qp(qp, "QP locked, state %d\n", qp->attrs.state);
>-		return -ENOTCONN;
>+		if (qp->attrs.state == SIW_QP_STATE_ERROR) {
>+			/*
>+			 * ERROR state is final, so we can be sure
>+			 * this state will not change as long as the QP
>+			 * exists.
>+			 *
>+			 * This handles an ib_drain_sq() call with
>+			 * a concurrent request to set the QP state
>+			 * to ERROR.
>+			 */
>+			rv = siw_sq_flush_wr(qp, wr, bad_wr);
>+		} else {
>+			siw_dbg_qp(qp, "QP locked, state %d\n",
>+				   qp->attrs.state);
>+			*bad_wr = wr;
>+			rv = -ENOTCONN;
>+		}
>+		return rv;
> 	}
> 	if (unlikely(qp->attrs.state != SIW_QP_STATE_RTS)) {
>+		if (qp->attrs.state == SIW_QP_STATE_ERROR) {
>+			/*
>+			 * Immediately flush this WR to CQ, if QP
>+			 * is in ERROR state. SQ is guaranteed to
>+			 * be empty, so WR complets in-order.
>+			 *
>+			 * Typically triggered by ib_drain_sq().
>+			 */
>+			rv = siw_sq_flush_wr(qp, wr, bad_wr);
>+		} else {
>+			siw_dbg_qp(qp, "QP out of state %d\n",
>+				   qp->attrs.state);
>+			*bad_wr = wr;
>+			rv = -ENOTCONN;
>+		}
> 		up_read(&qp->state_lock);
>-		*bad_wr = wr;
>-		siw_dbg_qp(qp, "QP out of state %d\n", qp->attrs.state);
>-		return -ENOTCONN;
>-	}
>-	if (wr && !qp->kernel_verbs) {
>-		siw_dbg_qp(qp, "wr must be empty for user mapped sq\n");
>-		up_read(&qp->state_lock);
>-		*bad_wr = wr;
>-		return -EINVAL;
>+		return rv;
> 	}
> 	spin_lock_irqsave(&qp->sq_lock, flags);
> 
>@@ -919,24 +988,55 @@ int siw_post_receive(struct ib_qp *base_qp,
>const struct ib_recv_wr *wr,
> 		*bad_wr = wr;
> 		return -EOPNOTSUPP; /* what else from errno.h? */
> 	}
>-	/*
>-	 * Try to acquire QP state lock. Must be non-blocking
>-	 * to accommodate kernel clients needs.
>-	 */
>-	if (!down_read_trylock(&qp->state_lock)) {
>-		*bad_wr = wr;
>-		return -ENOTCONN;
>-	}
> 	if (!qp->kernel_verbs) {
> 		siw_dbg_qp(qp, "no kernel post_recv for user mapped sq\n");
> 		up_read(&qp->state_lock);
> 		*bad_wr = wr;
> 		return -EINVAL;
> 	}
>+
>+	/*
>+	 * Try to acquire QP state lock. Must be non-blocking
>+	 * to accommodate kernel clients needs.
>+	 */
>+	if (!down_read_trylock(&qp->state_lock)) {
>+		if (qp->attrs.state == SIW_QP_STATE_ERROR) {
>+			/*
>+			 * ERROR state is final, so we can be sure
>+			 * this state will not change as long as the QP
>+			 * exists.
>+			 *
>+			 * This handles an ib_drain_rq() call with
>+			 * a concurrent request to set the QP state
>+			 * to ERROR.
>+			 */
>+			rv = siw_rq_flush_wr(qp, wr, bad_wr);
>+		} else {
>+			siw_dbg_qp(qp, "QP locked, state %d\n",
>+				   qp->attrs.state);
>+			*bad_wr = wr;
>+			rv = -ENOTCONN;
>+		}
>+		return rv;
>+	}
> 	if (qp->attrs.state > SIW_QP_STATE_RTS) {
>+		if (qp->attrs.state == SIW_QP_STATE_ERROR) {
>+			/*
>+			 * Immediately flush this WR to CQ, if QP
>+			 * is in ERROR state. RQ is guaranteed to
>+			 * be empty, so WR complets in-order.
>+			 *
>+			 * Typically triggered by ib_drain_rq().
>+			 */
>+			rv = siw_rq_flush_wr(qp, wr, bad_wr);
>+		} else {
>+			siw_dbg_qp(qp, "QP out of state %d\n",
>+				   qp->attrs.state);
>+			*bad_wr = wr;
>+			rv = -ENOTCONN;
>+		}
> 		up_read(&qp->state_lock);
>-		*bad_wr = wr;
>-		return -EINVAL;
>+		return rv;
> 	}
> 	/*
> 	 * Serialize potentially multiple producers.
>-- 
>2.17.2
>
>

