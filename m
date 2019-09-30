Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8B9C246C
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Sep 2019 17:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbfI3Phc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 30 Sep 2019 11:37:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731802AbfI3Phc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 30 Sep 2019 11:37:32 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8UFYL75046997
        for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2019 11:37:30 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.109])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vbkkctt54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2019 11:37:30 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 30 Sep 2019 15:37:29 -0000
Received: from us1b3-smtp03.a3dr.sjc01.isc4sb.com (10.122.7.173)
        by smtp.notes.na.collabserv.com (10.122.47.48) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 30 Sep 2019 15:37:24 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp03.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019093015372356-629143 ;
          Mon, 30 Sep 2019 15:37:23 +0000 
In-Reply-To: <20190927221545.5944-1-krishna2@chelsio.com>
Subject: Re: [PATCH for-next] RDMA/siw: fix SQ/RQ drain logic to support ib_drain_qp
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Krishnamraju Eraparaju" <krishna2@chelsio.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Date:   Mon, 30 Sep 2019 15:37:23 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190927221545.5944-1-krishna2@chelsio.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-KeepSent: FA5BB431:AD96EB3F-00258485:0054053B;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 46207
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19093015-1429-0000-0000-00000062886D
X-IBM-SpamModules-Scores: BY=0.065165; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.060561
X-IBM-SpamModules-Versions: BY=3.00011865; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01268753; UDB=6.00671447; IPR=6.01050777;
 MB=3.00028885; MTD=3.00000008; XFM=3.00000015; UTC=2019-09-30 15:37:28
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-09-30 11:13:07 - 6.00010470
x-cbparentid: 19093015-1430-0000-0000-00002470996F
Message-Id: <OFFA5BB431.AD96EB3F-ON00258485.0054053B-00258485.0055D206@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-30_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----

>To: jgg@ziepe.ca, bmt@zurich.ibm.com
>From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>Date: 09/28/2019 12:16AM
>Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com,
>nirranjan@chelsio.com, "Krishnamraju Eraparaju"
><krishna2@chelsio.com>
>Subject: [EXTERNAL] [PATCH for-next] RDMA/siw: fix SQ/RQ drain logic
>to support ib_drain_qp
>
>The storage ULPs(iSER & NVMeOF) uses ib_drain_qp() to drain
>QP/CQ properly. But SIW is currently using it's own routines to
>drain SQ & RQ, which can't help ULPs to determine the last CQE.
>Failing to wait until last CQE causes touch after free issues:

Hi Krishna,

Before reviewing, please let me fully understand what is
going on here/why we need that patch.

Is this issue caused since the ulp expects the ib_drain_xx
driver method to be blocking until all completions are reaped,
and siw does not block?

Is the ULP expected to call ib_drain_xx only if no other
work is pending (SQ/RQ/CQ)? If not, shall all previous
work be completed with FLUSH error?

Many thanks!
Bernard.





>
>[  +0.001831] general protection fault: 0000 [#1] SMP PTI
>[  +0.000002] Call Trace:
>[  +0.000026]  ? __ib_process_cq+0x7a/0xc0 [ib_core]
>[  +0.000008]  ? ib_poll_handler+0x2c/0x80 [ib_core]
>[  +0.000005]  ? irq_poll_softirq+0xae/0x110
>[  +0.000005]  ? __do_softirq+0xda/0x2a8
>[  +0.000004]  ? run_ksoftirqd+0x26/0x40
>[  +0.000005]  ? smpboot_thread_fn+0x10e/0x160
>[  +0.000004]  ? kthread+0xf8/0x130
>[  +0.000003]  ? sort_range+0x20/0x20
>[  +0.000003]  ? kthread_bind+0x10/0x10
>[  +0.000003]  ? ret_from_fork+0x35/0x40
>
>Hence, changing the SQ & RQ drain logic to support current IB/core
>drain semantics, though this drain method does not naturally aligns
>to iWARP spec(where post_send/recv calls are not allowed in
>QP ERROR state). More on this was described in below commit:
>commit 4fe7c2962e11 ("iw_cxgb4: refactor sq/rq drain logic")
>
>Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
>---
> drivers/infiniband/sw/siw/siw.h       |  3 +-
> drivers/infiniband/sw/siw/siw_cm.c    |  4 +-
> drivers/infiniband/sw/siw/siw_main.c  | 20 ---------
> drivers/infiniband/sw/siw/siw_verbs.c | 60
>+++++++++++++++++++++++++++
> 4 files changed, 64 insertions(+), 23 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw.h
>b/drivers/infiniband/sw/siw/siw.h
>index dba4535494ab..ad4f078e4587 100644
>--- a/drivers/infiniband/sw/siw/siw.h
>+++ b/drivers/infiniband/sw/siw/siw.h
>@@ -240,7 +240,8 @@ enum siw_qp_flags {
> 	SIW_RDMA_READ_ENABLED = (1 << 2),
> 	SIW_SIGNAL_ALL_WR = (1 << 3),
> 	SIW_MPA_CRC = (1 << 4),
>-	SIW_QP_IN_DESTROY = (1 << 5)
>+	SIW_QP_IN_DESTROY = (1 << 5),
>+	SIW_QP_DRAINED_FINAL = (1 << 6)
> };
> 
> enum siw_qp_attr_mask {
>diff --git a/drivers/infiniband/sw/siw/siw_cm.c
>b/drivers/infiniband/sw/siw/siw_cm.c
>index 8c1931a57f4a..fb830622d32e 100644
>--- a/drivers/infiniband/sw/siw/siw_cm.c
>+++ b/drivers/infiniband/sw/siw/siw_cm.c
>@@ -857,7 +857,7 @@ static int siw_proc_mpareply(struct siw_cep *cep)
> 	memset(&qp_attrs, 0, sizeof(qp_attrs));
> 
> 	if (rep->params.bits & MPA_RR_FLAG_CRC)
>-		qp_attrs.flags = SIW_MPA_CRC;
>+		qp_attrs.flags |= SIW_MPA_CRC;
> 
> 	qp_attrs.irq_size = cep->ird;
> 	qp_attrs.orq_size = cep->ord;
>@@ -1675,7 +1675,7 @@ int siw_accept(struct iw_cm_id *id, struct
>iw_cm_conn_param *params)
> 	qp_attrs.irq_size = cep->ird;
> 	qp_attrs.sk = cep->sock;
> 	if (cep->mpa.hdr.params.bits & MPA_RR_FLAG_CRC)
>-		qp_attrs.flags = SIW_MPA_CRC;
>+		qp_attrs.flags |= SIW_MPA_CRC;
> 	qp_attrs.state = SIW_QP_STATE_RTS;
> 
> 	siw_dbg_cep(cep, "[QP%u]: moving to rts\n", qp_id(qp));
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
>index 869e02b69a01..5dd62946a649 100644
>--- a/drivers/infiniband/sw/siw/siw_verbs.c
>+++ b/drivers/infiniband/sw/siw/siw_verbs.c
>@@ -596,6 +596,13 @@ int siw_verbs_modify_qp(struct ib_qp *base_qp,
>struct ib_qp_attr *attr,
> 
> 	rv = siw_qp_modify(qp, &new_attrs, siw_attr_mask);
> 
>+	/* QP state ERROR here ensures that all the SQ & RQ entries got
>drained
>+	 * completely. And henceforth, no more entries will be added to the
>CQ,
>+	 * exception is special drain CQEs via ib_drain_qp().
>+	 */
>+	if (qp->attrs.state == SIW_QP_STATE_ERROR)
>+		qp->attrs.flags |= SIW_QP_DRAINED_FINAL;
>+
> 	up_write(&qp->state_lock);
> out:
> 	return rv;
>@@ -687,6 +694,44 @@ static int siw_copy_inline_sgl(const struct
>ib_send_wr *core_wr,
> 	return bytes;
> }
> 
>+/* SQ final completion routine to support ib_drain_sp(). */
>+int siw_sq_final_comp(struct siw_qp *qp, const struct ib_send_wr
>*wr,
>+		      const struct ib_send_wr **bad_wr)
>+{
>+	struct siw_sqe sqe = {};
>+	int rv = 0;
>+
>+	while (wr) {
>+		sqe.id = wr->wr_id;
>+		sqe.opcode = wr->opcode;
>+		rv = siw_sqe_complete(qp, &sqe, 0, SIW_WC_WR_FLUSH_ERR);
>+		if (rv) {
>+			*bad_wr = wr;
>+			break;
>+		}
>+		wr = wr->next;
>+	}
>+	return rv;
>+}
>+
>+/* RQ final completion routine to support ib_drain_rp(). */
>+int siw_rq_final_comp(struct siw_qp *qp, const struct ib_recv_wr
>*wr,
>+		      const struct ib_recv_wr **bad_wr)
>+{
>+	struct siw_rqe rqe = {};
>+	int rv = 0;
>+
>+	while (wr) {
>+		rqe.id = wr->wr_id;
>+		rv = siw_rqe_complete(qp, &rqe, 0, 0, SIW_WC_WR_FLUSH_ERR);
>+		if (rv) {
>+			*bad_wr = wr;
>+			break;
>+		}
>+		wr = wr->next;
>+	}
>+	return rv;
>+}
> /*
>  * siw_post_send()
>  *
>@@ -705,6 +750,15 @@ int siw_post_send(struct ib_qp *base_qp, const
>struct ib_send_wr *wr,
> 	unsigned long flags;
> 	int rv = 0;
> 
>+	/* Currently there is no way to distinguish between special drain
>+	 * WRs and normal WRs(?), so we do FLUSH_ERR for all the WRs
>that've
>+	 * arrived in the ERROR/SIW_QP_DRAINED_FINAL state, assuming we get
>+	 * only special drain WRs in this state via ib_drain_sq().
>+	 */
>+	if (qp->attrs.flags & SIW_QP_DRAINED_FINAL) {
>+		rv = siw_sq_final_comp(qp, wr, bad_wr);
>+		return rv;
>+	}
> 	/*
> 	 * Try to acquire QP state lock. Must be non-blocking
> 	 * to accommodate kernel clients needs.
>@@ -919,6 +973,12 @@ int siw_post_receive(struct ib_qp *base_qp,
>const struct ib_recv_wr *wr,
> 		*bad_wr = wr;
> 		return -EOPNOTSUPP; /* what else from errno.h? */
> 	}
>+
>+	if (qp->attrs.flags & SIW_QP_DRAINED_FINAL) {
>+		rv = siw_rq_final_comp(qp, wr, bad_wr);
>+		return rv;
>+	}
>+
> 	/*
> 	 * Try to acquire QP state lock. Must be non-blocking
> 	 * to accommodate kernel clients needs.
>-- 
>2.23.0.rc0
>
>

