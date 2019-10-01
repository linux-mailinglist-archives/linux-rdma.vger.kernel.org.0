Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37239C30A7
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 11:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbfJAJwf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 05:52:35 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:30540 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJAJwe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 05:52:34 -0400
Received: from localhost (budha.blr.asicdesigners.com [10.193.185.4])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x919qSW0010576;
        Tue, 1 Oct 2019 02:52:29 -0700
Date:   Tue, 1 Oct 2019 15:22:27 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>
Subject: Re: [PATCH for-next] RDMA/siw: fix SQ/RQ drain logic to support
 ib_drain_qp
Message-ID: <20191001095224.GA5448@chelsio.com>
References: <20190927221545.5944-1-krishna2@chelsio.com>
 <OFFA5BB431.AD96EB3F-ON00258485.0054053B-00258485.0055D206@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFFA5BB431.AD96EB3F-ON00258485.0054053B-00258485.0055D206@notes.na.collabserv.com>
User-Agent: Mutt/1.9.3 (20180206.02d571c2)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Monday, September 09/30/19, 2019 at 21:07:23 +0530, Bernard Metzler wrote:
> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----
> 
> >To: jgg@ziepe.ca, bmt@zurich.ibm.com
> >From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
> >Date: 09/28/2019 12:16AM
> >Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com,
> >nirranjan@chelsio.com, "Krishnamraju Eraparaju"
> ><krishna2@chelsio.com>
> >Subject: [EXTERNAL] [PATCH for-next] RDMA/siw: fix SQ/RQ drain logic
> >to support ib_drain_qp
> >
> >The storage ULPs(iSER & NVMeOF) uses ib_drain_qp() to drain
> >QP/CQ properly. But SIW is currently using it's own routines to
> >drain SQ & RQ, which can't help ULPs to determine the last CQE.
> >Failing to wait until last CQE causes touch after free issues:
> 
> Hi Krishna,
> 
> Before reviewing, please let me fully understand what is
> going on here/why we need that patch.
> 
> Is this issue caused since the ulp expects the ib_drain_xx
> driver method to be blocking until all completions are reaped,
> and siw does not block?
Yes, SIW is currently using provider-specific drain_qp logic,
IE: siw_verbs_rq/sq_flush(), with this logic though all the SQ & RQ
entries are flushed to CQ but ULPs cannot ensure when exactly the
processing of all CQEs for those WRs, posted prior to ib_drain_xx(),
got completed.
Due to this uncertainity, sometimes iSER/NVMeOF driver(assuming all
the CQEs are processed) proceed to release resouces/destroy_qp,
causing touch after free issues.
> 
> Is the ULP expected to call ib_drain_xx only if no other
> work is pending (SQ/RQ/CQ)? If not, shall all previous
> work be completed with FLUSH error?
In error cases(eg: link-down), I see iSER/NVMEOF drivers performing
disconnect/drain_qp though there is some pending work to be processed.
This may be valid due to the ERROR.
And all that pending work gets completed with FLUSH error. 
> 
> Many thanks!
> Bernard.
> 
> 
> 
> 
> 
> >
> >[  +0.001831] general protection fault: 0000 [#1] SMP PTI
> >[  +0.000002] Call Trace:
> >[  +0.000026]  ? __ib_process_cq+0x7a/0xc0 [ib_core]
> >[  +0.000008]  ? ib_poll_handler+0x2c/0x80 [ib_core]
> >[  +0.000005]  ? irq_poll_softirq+0xae/0x110
> >[  +0.000005]  ? __do_softirq+0xda/0x2a8
> >[  +0.000004]  ? run_ksoftirqd+0x26/0x40
> >[  +0.000005]  ? smpboot_thread_fn+0x10e/0x160
> >[  +0.000004]  ? kthread+0xf8/0x130
> >[  +0.000003]  ? sort_range+0x20/0x20
> >[  +0.000003]  ? kthread_bind+0x10/0x10
> >[  +0.000003]  ? ret_from_fork+0x35/0x40
> >
> >Hence, changing the SQ & RQ drain logic to support current IB/core
> >drain semantics, though this drain method does not naturally aligns
> >to iWARP spec(where post_send/recv calls are not allowed in
> >QP ERROR state). More on this was described in below commit:
> >commit 4fe7c2962e11 ("iw_cxgb4: refactor sq/rq drain logic")
> >
> >Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> >---
> > drivers/infiniband/sw/siw/siw.h       |  3 +-
> > drivers/infiniband/sw/siw/siw_cm.c    |  4 +-
> > drivers/infiniband/sw/siw/siw_main.c  | 20 ---------
> > drivers/infiniband/sw/siw/siw_verbs.c | 60
> >+++++++++++++++++++++++++++
> > 4 files changed, 64 insertions(+), 23 deletions(-)
> >
> >diff --git a/drivers/infiniband/sw/siw/siw.h
> >b/drivers/infiniband/sw/siw/siw.h
> >index dba4535494ab..ad4f078e4587 100644
> >--- a/drivers/infiniband/sw/siw/siw.h
> >+++ b/drivers/infiniband/sw/siw/siw.h
> >@@ -240,7 +240,8 @@ enum siw_qp_flags {
> > 	SIW_RDMA_READ_ENABLED = (1 << 2),
> > 	SIW_SIGNAL_ALL_WR = (1 << 3),
> > 	SIW_MPA_CRC = (1 << 4),
> >-	SIW_QP_IN_DESTROY = (1 << 5)
> >+	SIW_QP_IN_DESTROY = (1 << 5),
> >+	SIW_QP_DRAINED_FINAL = (1 << 6)
> > };
> > 
> > enum siw_qp_attr_mask {
> >diff --git a/drivers/infiniband/sw/siw/siw_cm.c
> >b/drivers/infiniband/sw/siw/siw_cm.c
> >index 8c1931a57f4a..fb830622d32e 100644
> >--- a/drivers/infiniband/sw/siw/siw_cm.c
> >+++ b/drivers/infiniband/sw/siw/siw_cm.c
> >@@ -857,7 +857,7 @@ static int siw_proc_mpareply(struct siw_cep *cep)
> > 	memset(&qp_attrs, 0, sizeof(qp_attrs));
> > 
> > 	if (rep->params.bits & MPA_RR_FLAG_CRC)
> >-		qp_attrs.flags = SIW_MPA_CRC;
> >+		qp_attrs.flags |= SIW_MPA_CRC;
> > 
> > 	qp_attrs.irq_size = cep->ird;
> > 	qp_attrs.orq_size = cep->ord;
> >@@ -1675,7 +1675,7 @@ int siw_accept(struct iw_cm_id *id, struct
> >iw_cm_conn_param *params)
> > 	qp_attrs.irq_size = cep->ird;
> > 	qp_attrs.sk = cep->sock;
> > 	if (cep->mpa.hdr.params.bits & MPA_RR_FLAG_CRC)
> >-		qp_attrs.flags = SIW_MPA_CRC;
> >+		qp_attrs.flags |= SIW_MPA_CRC;
> > 	qp_attrs.state = SIW_QP_STATE_RTS;
> > 
> > 	siw_dbg_cep(cep, "[QP%u]: moving to rts\n", qp_id(qp));
> >diff --git a/drivers/infiniband/sw/siw/siw_main.c
> >b/drivers/infiniband/sw/siw/siw_main.c
> >index 05a92f997f60..fb01407a310f 100644
> >--- a/drivers/infiniband/sw/siw/siw_main.c
> >+++ b/drivers/infiniband/sw/siw/siw_main.c
> >@@ -248,24 +248,6 @@ static struct ib_qp *siw_get_base_qp(struct
> >ib_device *base_dev, int id)
> > 	return NULL;
> > }
> > 
> >-static void siw_verbs_sq_flush(struct ib_qp *base_qp)
> >-{
> >-	struct siw_qp *qp = to_siw_qp(base_qp);
> >-
> >-	down_write(&qp->state_lock);
> >-	siw_sq_flush(qp);
> >-	up_write(&qp->state_lock);
> >-}
> >-
> >-static void siw_verbs_rq_flush(struct ib_qp *base_qp)
> >-{
> >-	struct siw_qp *qp = to_siw_qp(base_qp);
> >-
> >-	down_write(&qp->state_lock);
> >-	siw_rq_flush(qp);
> >-	up_write(&qp->state_lock);
> >-}
> >-
> > static const struct ib_device_ops siw_device_ops = {
> > 	.owner = THIS_MODULE,
> > 	.uverbs_abi_ver = SIW_ABI_VERSION,
> >@@ -284,8 +266,6 @@ static const struct ib_device_ops siw_device_ops
> >= {
> > 	.destroy_cq = siw_destroy_cq,
> > 	.destroy_qp = siw_destroy_qp,
> > 	.destroy_srq = siw_destroy_srq,
> >-	.drain_rq = siw_verbs_rq_flush,
> >-	.drain_sq = siw_verbs_sq_flush,
> > 	.get_dma_mr = siw_get_dma_mr,
> > 	.get_port_immutable = siw_get_port_immutable,
> > 	.iw_accept = siw_accept,
> >diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
> >b/drivers/infiniband/sw/siw/siw_verbs.c
> >index 869e02b69a01..5dd62946a649 100644
> >--- a/drivers/infiniband/sw/siw/siw_verbs.c
> >+++ b/drivers/infiniband/sw/siw/siw_verbs.c
> >@@ -596,6 +596,13 @@ int siw_verbs_modify_qp(struct ib_qp *base_qp,
> >struct ib_qp_attr *attr,
> > 
> > 	rv = siw_qp_modify(qp, &new_attrs, siw_attr_mask);
> > 
> >+	/* QP state ERROR here ensures that all the SQ & RQ entries got
> >drained
> >+	 * completely. And henceforth, no more entries will be added to the
> >CQ,
> >+	 * exception is special drain CQEs via ib_drain_qp().
> >+	 */
> >+	if (qp->attrs.state == SIW_QP_STATE_ERROR)
> >+		qp->attrs.flags |= SIW_QP_DRAINED_FINAL;
> >+
> > 	up_write(&qp->state_lock);
> > out:
> > 	return rv;
> >@@ -687,6 +694,44 @@ static int siw_copy_inline_sgl(const struct
> >ib_send_wr *core_wr,
> > 	return bytes;
> > }
> > 
> >+/* SQ final completion routine to support ib_drain_sp(). */
> >+int siw_sq_final_comp(struct siw_qp *qp, const struct ib_send_wr
> >*wr,
> >+		      const struct ib_send_wr **bad_wr)
> >+{
> >+	struct siw_sqe sqe = {};
> >+	int rv = 0;
> >+
> >+	while (wr) {
> >+		sqe.id = wr->wr_id;
> >+		sqe.opcode = wr->opcode;
> >+		rv = siw_sqe_complete(qp, &sqe, 0, SIW_WC_WR_FLUSH_ERR);
> >+		if (rv) {
> >+			*bad_wr = wr;
> >+			break;
> >+		}
> >+		wr = wr->next;
> >+	}
> >+	return rv;
> >+}
> >+
> >+/* RQ final completion routine to support ib_drain_rp(). */
> >+int siw_rq_final_comp(struct siw_qp *qp, const struct ib_recv_wr
> >*wr,
> >+		      const struct ib_recv_wr **bad_wr)
> >+{
> >+	struct siw_rqe rqe = {};
> >+	int rv = 0;
> >+
> >+	while (wr) {
> >+		rqe.id = wr->wr_id;
> >+		rv = siw_rqe_complete(qp, &rqe, 0, 0, SIW_WC_WR_FLUSH_ERR);
> >+		if (rv) {
> >+			*bad_wr = wr;
> >+			break;
> >+		}
> >+		wr = wr->next;
> >+	}
> >+	return rv;
> >+}
> > /*
> >  * siw_post_send()
> >  *
> >@@ -705,6 +750,15 @@ int siw_post_send(struct ib_qp *base_qp, const
> >struct ib_send_wr *wr,
> > 	unsigned long flags;
> > 	int rv = 0;
> > 
> >+	/* Currently there is no way to distinguish between special drain
> >+	 * WRs and normal WRs(?), so we do FLUSH_ERR for all the WRs
> >that've
> >+	 * arrived in the ERROR/SIW_QP_DRAINED_FINAL state, assuming we get
> >+	 * only special drain WRs in this state via ib_drain_sq().
> >+	 */
> >+	if (qp->attrs.flags & SIW_QP_DRAINED_FINAL) {
> >+		rv = siw_sq_final_comp(qp, wr, bad_wr);
> >+		return rv;
> >+	}
> > 	/*
> > 	 * Try to acquire QP state lock. Must be non-blocking
> > 	 * to accommodate kernel clients needs.
> >@@ -919,6 +973,12 @@ int siw_post_receive(struct ib_qp *base_qp,
> >const struct ib_recv_wr *wr,
> > 		*bad_wr = wr;
> > 		return -EOPNOTSUPP; /* what else from errno.h? */
> > 	}
> >+
> >+	if (qp->attrs.flags & SIW_QP_DRAINED_FINAL) {
> >+		rv = siw_rq_final_comp(qp, wr, bad_wr);
> >+		return rv;
> >+	}
> >+
> > 	/*
> > 	 * Try to acquire QP state lock. Must be non-blocking
> > 	 * to accommodate kernel clients needs.
> >-- 
> >2.23.0.rc0
> >
> >
> 
