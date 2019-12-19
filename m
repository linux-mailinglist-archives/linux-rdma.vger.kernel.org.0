Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBA27126FA1
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2019 22:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfLSVTi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Dec 2019 16:19:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:12851 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbfLSVTh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Dec 2019 16:19:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 13:19:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,333,1571727600"; 
   d="scan'208";a="241296918"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga004.fm.intel.com with ESMTP; 19 Dec 2019 13:19:24 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id xBJLJNJS002708;
        Thu, 19 Dec 2019 14:19:24 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id xBJLJMn4058620;
        Thu, 19 Dec 2019 16:19:22 -0500
Subject: [PATCH for-rc 1/4] IB/hfi1: Add accessor API routines to access
 context members
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Thu, 19 Dec 2019 16:19:22 -0500
Message-ID: <20191219211922.58387.26548.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20191219211609.58387.86077.stgit@awfm-01.aw.intel.com>
References: <20191219211609.58387.86077.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

This patch adds a set of accessor routines to access context members.

Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/chip.c        |   27 ++----
 drivers/infiniband/hw/hfi1/common.h      |    3 +
 drivers/infiniband/hw/hfi1/driver.c      |   74 +++++++----------
 drivers/infiniband/hw/hfi1/file_ops.c    |   12 +--
 drivers/infiniband/hw/hfi1/hfi.h         |  129 ++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi1/init.c        |    6 +
 drivers/infiniband/hw/hfi1/trace_ctxts.h |    2 
 drivers/infiniband/hw/hfi1/trace_rx.h    |   13 +--
 drivers/infiniband/hw/hfi1/vnic_main.c   |    2 
 9 files changed, 183 insertions(+), 85 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 9b1fb84..b4fe37a 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -6862,7 +6862,7 @@ static void rxe_kernel_unfreeze(struct hfi1_devdata *dd)
 		}
 		rcvmask = HFI1_RCVCTRL_CTXT_ENB;
 		/* HFI1_RCVCTRL_TAILUPD_[ENB|DIS] needs to be set explicitly */
-		rcvmask |= rcd->rcvhdrtail_kvaddr ?
+		rcvmask |= hfi1_rcvhdrtail_kvaddr(rcd) ?
 			HFI1_RCVCTRL_TAILUPD_ENB : HFI1_RCVCTRL_TAILUPD_DIS;
 		hfi1_rcvctrl(dd, rcvmask, rcd);
 		hfi1_rcd_put(rcd);
@@ -8394,20 +8394,13 @@ void force_recv_intr(struct hfi1_ctxtdata *rcd)
 static inline int check_packet_present(struct hfi1_ctxtdata *rcd)
 {
 	u32 tail;
-	int present;
-
-	if (!rcd->rcvhdrtail_kvaddr)
-		present = (rcd->seq_cnt ==
-				rhf_rcv_seq(rhf_to_cpu(get_rhf_addr(rcd))));
-	else /* is RDMA rtail */
-		present = (rcd->head != get_rcvhdrtail(rcd));
 
-	if (present)
+	if (hfi1_packet_present(rcd))
 		return 1;
 
 	/* fall back to a CSR read, correct indpendent of DMA_RTAIL */
 	tail = (u32)read_uctxt_csr(rcd->dd, rcd->ctxt, RCV_HDR_TAIL);
-	return rcd->head != tail;
+	return hfi1_rcd_head(rcd) != tail;
 }
 
 /*
@@ -10049,7 +10042,7 @@ u32 lrh_max_header_bytes(struct hfi1_devdata *dd)
 	 * the first kernel context would have been allocated by now so
 	 * we are guaranteed a valid value.
 	 */
-	return (dd->rcd[0]->rcvhdrqentsize - 2/*PBC/RHF*/ + 1/*ICRC*/) << 2;
+	return (get_hdrqentsize(dd->rcd[0]) - 2/*PBC/RHF*/ + 1/*ICRC*/) << 2;
 }
 
 /*
@@ -10094,7 +10087,7 @@ static void set_send_length(struct hfi1_pportdata *ppd)
 		thres = min(sc_percent_to_threshold(dd->vld[i].sc, 50),
 			    sc_mtu_to_threshold(dd->vld[i].sc,
 						dd->vld[i].mtu,
-						dd->rcd[0]->rcvhdrqentsize));
+						get_hdrqentsize(dd->rcd[0])));
 		for (j = 0; j < INIT_SC_PER_VL; j++)
 			sc_set_cr_threshold(
 					pio_select_send_context_vl(dd, j, i),
@@ -11821,7 +11814,7 @@ u32 hdrqempty(struct hfi1_ctxtdata *rcd)
 	head = (read_uctxt_csr(rcd->dd, rcd->ctxt, RCV_HDR_HEAD)
 		& RCV_HDR_HEAD_HEAD_SMASK) >> RCV_HDR_HEAD_HEAD_SHIFT;
 
-	if (rcd->rcvhdrtail_kvaddr)
+	if (hfi1_rcvhdrtail_kvaddr(rcd))
 		tail = get_rcvhdrtail(rcd);
 	else
 		tail = read_uctxt_csr(rcd->dd, rcd->ctxt, RCV_HDR_TAIL);
@@ -11886,13 +11879,13 @@ void hfi1_rcvctrl(struct hfi1_devdata *dd, unsigned int op,
 		/* reset the tail and hdr addresses, and sequence count */
 		write_kctxt_csr(dd, ctxt, RCV_HDR_ADDR,
 				rcd->rcvhdrq_dma);
-		if (rcd->rcvhdrtail_kvaddr)
+		if (hfi1_rcvhdrtail_kvaddr(rcd))
 			write_kctxt_csr(dd, ctxt, RCV_HDR_TAIL_ADDR,
 					rcd->rcvhdrqtailaddr_dma);
-		rcd->seq_cnt = 1;
+		hfi1_set_seq_cnt(rcd, 1);
 
 		/* reset the cached receive header queue head value */
-		rcd->head = 0;
+		hfi1_set_rcd_head(rcd, 0);
 
 		/*
 		 * Zero the receive header queue so we don't get false
@@ -11972,7 +11965,7 @@ void hfi1_rcvctrl(struct hfi1_devdata *dd, unsigned int op,
 			      IS_RCVAVAIL_START + rcd->ctxt, false);
 		rcvctrl &= ~RCV_CTXT_CTRL_INTR_AVAIL_SMASK;
 	}
-	if ((op & HFI1_RCVCTRL_TAILUPD_ENB) && rcd->rcvhdrtail_kvaddr)
+	if ((op & HFI1_RCVCTRL_TAILUPD_ENB) && hfi1_rcvhdrtail_kvaddr(rcd))
 		rcvctrl |= RCV_CTXT_CTRL_TAIL_UPD_SMASK;
 	if (op & HFI1_RCVCTRL_TAILUPD_DIS) {
 		/* See comment on RcvCtxtCtrl.TailUpd above */
diff --git a/drivers/infiniband/hw/hfi1/common.h b/drivers/infiniband/hw/hfi1/common.h
index d47da7b..40a1ff0 100644
--- a/drivers/infiniband/hw/hfi1/common.h
+++ b/drivers/infiniband/hw/hfi1/common.h
@@ -323,6 +323,9 @@ struct diag_pkt {
 /* RHF receive type error - bypass packet errors */
 #define RHF_RTE_BYPASS_NO_ERR		0x0
 
+/* MAX RcvSEQ */
+#define RHF_MAX_SEQ 13
+
 /* IB - LRH header constants */
 #define HFI1_LRH_GRH 0x0003      /* 1. word of IB LRH - next header: GRH */
 #define HFI1_LRH_BTH 0x0002      /* 1. word of IB LRH - next header: BTH */
diff --git a/drivers/infiniband/hw/hfi1/driver.c b/drivers/infiniband/hw/hfi1/driver.c
index 01aa1f1..cbc5219 100644
--- a/drivers/infiniband/hw/hfi1/driver.c
+++ b/drivers/infiniband/hw/hfi1/driver.c
@@ -411,14 +411,14 @@ static void rcv_hdrerr(struct hfi1_ctxtdata *rcd, struct hfi1_pportdata *ppd,
 static inline void init_packet(struct hfi1_ctxtdata *rcd,
 			       struct hfi1_packet *packet)
 {
-	packet->rsize = rcd->rcvhdrqentsize; /* words */
-	packet->maxcnt = rcd->rcvhdrq_cnt * packet->rsize; /* words */
+	packet->rsize = get_hdrqentsize(rcd); /* words */
+	packet->maxcnt = get_hdrq_cnt(rcd) * packet->rsize; /* words */
 	packet->rcd = rcd;
 	packet->updegr = 0;
 	packet->etail = -1;
 	packet->rhf_addr = get_rhf_addr(rcd);
 	packet->rhf = rhf_to_cpu(packet->rhf_addr);
-	packet->rhqoff = rcd->head;
+	packet->rhqoff = hfi1_rcd_head(rcd);
 	packet->numpkt = 0;
 }
 
@@ -551,22 +551,22 @@ static inline void init_ps_mdata(struct ps_mdata *mdata,
 	mdata->maxcnt = packet->maxcnt;
 	mdata->ps_head = packet->rhqoff;
 
-	if (HFI1_CAP_KGET_MASK(rcd->flags, DMA_RTAIL)) {
+	if (get_dma_rtail_setting(rcd)) {
 		mdata->ps_tail = get_rcvhdrtail(rcd);
 		if (rcd->ctxt == HFI1_CTRL_CTXT)
-			mdata->ps_seq = rcd->seq_cnt;
+			mdata->ps_seq = hfi1_seq_cnt(rcd);
 		else
 			mdata->ps_seq = 0; /* not used with DMA_RTAIL */
 	} else {
 		mdata->ps_tail = 0; /* used only with DMA_RTAIL*/
-		mdata->ps_seq = rcd->seq_cnt;
+		mdata->ps_seq = hfi1_seq_cnt(rcd);
 	}
 }
 
 static inline int ps_done(struct ps_mdata *mdata, u64 rhf,
 			  struct hfi1_ctxtdata *rcd)
 {
-	if (HFI1_CAP_KGET_MASK(rcd->flags, DMA_RTAIL))
+	if (get_dma_rtail_setting(rcd))
 		return mdata->ps_head == mdata->ps_tail;
 	return mdata->ps_seq != rhf_rcv_seq(rhf);
 }
@@ -592,11 +592,9 @@ static inline void update_ps_mdata(struct ps_mdata *mdata,
 		mdata->ps_head = 0;
 
 	/* Control context must do seq counting */
-	if (!HFI1_CAP_KGET_MASK(rcd->flags, DMA_RTAIL) ||
-	    (rcd->ctxt == HFI1_CTRL_CTXT)) {
-		if (++mdata->ps_seq > 13)
-			mdata->ps_seq = 1;
-	}
+	if (!get_dma_rtail_setting(rcd) ||
+	    rcd->ctxt == HFI1_CTRL_CTXT)
+		mdata->ps_seq = hfi1_seq_incr_wrap(mdata->ps_seq);
 }
 
 /*
@@ -769,7 +767,7 @@ static inline int process_rcv_packet(struct hfi1_packet *packet, int thread)
 		 * The +2 is the size of the RHF.
 		 */
 		prefetch_range(packet->ebuf,
-			       packet->tlen - ((packet->rcd->rcvhdrqentsize -
+			       packet->tlen - ((get_hdrqentsize(packet->rcd) -
 					       (rhf_hdrq_offset(packet->rhf)
 						+ 2)) * 4));
 	}
@@ -823,7 +821,7 @@ static inline void finish_packet(struct hfi1_packet *packet)
 	 * The only thing we need to do is a final update and call for an
 	 * interrupt
 	 */
-	update_usrhead(packet->rcd, packet->rcd->head, packet->updegr,
+	update_usrhead(packet->rcd, hfi1_rcd_head(packet->rcd), packet->updegr,
 		       packet->etail, rcv_intr_dynamic, packet->numpkt);
 }
 
@@ -832,13 +830,11 @@ static inline void finish_packet(struct hfi1_packet *packet)
  */
 int handle_receive_interrupt_nodma_rtail(struct hfi1_ctxtdata *rcd, int thread)
 {
-	u32 seq;
 	int last = RCV_PKT_OK;
 	struct hfi1_packet packet;
 
 	init_packet(rcd, &packet);
-	seq = rhf_rcv_seq(packet.rhf);
-	if (seq != rcd->seq_cnt) {
+	if (last_rcv_seq(rcd, rhf_rcv_seq(packet.rhf))) {
 		last = RCV_PKT_DONE;
 		goto bail;
 	}
@@ -847,15 +843,12 @@ int handle_receive_interrupt_nodma_rtail(struct hfi1_ctxtdata *rcd, int thread)
 
 	while (last == RCV_PKT_OK) {
 		last = process_rcv_packet(&packet, thread);
-		seq = rhf_rcv_seq(packet.rhf);
-		if (++rcd->seq_cnt > 13)
-			rcd->seq_cnt = 1;
-		if (seq != rcd->seq_cnt)
+		if (hfi1_seq_incr(rcd, rhf_rcv_seq(packet.rhf)))
 			last = RCV_PKT_DONE;
 		process_rcv_update(last, &packet);
 	}
 	process_rcv_qp_work(&packet);
-	rcd->head = packet.rhqoff;
+	hfi1_set_rcd_head(rcd, packet.rhqoff);
 bail:
 	finish_packet(&packet);
 	return last;
@@ -884,7 +877,7 @@ int handle_receive_interrupt_dma_rtail(struct hfi1_ctxtdata *rcd, int thread)
 		process_rcv_update(last, &packet);
 	}
 	process_rcv_qp_work(&packet);
-	rcd->head = packet.rhqoff;
+	hfi1_set_rcd_head(rcd, packet.rhqoff);
 bail:
 	finish_packet(&packet);
 	return last;
@@ -1019,10 +1012,8 @@ int handle_receive_interrupt(struct hfi1_ctxtdata *rcd, int thread)
 
 	init_packet(rcd, &packet);
 
-	if (!HFI1_CAP_KGET_MASK(rcd->flags, DMA_RTAIL)) {
-		u32 seq = rhf_rcv_seq(packet.rhf);
-
-		if (seq != rcd->seq_cnt) {
+	if (!get_dma_rtail_setting(rcd)) {
+		if (last_rcv_seq(rcd, rhf_rcv_seq(packet.rhf))) {
 			last = RCV_PKT_DONE;
 			goto bail;
 		}
@@ -1039,12 +1030,9 @@ int handle_receive_interrupt(struct hfi1_ctxtdata *rcd, int thread)
 		 * Control context can potentially receive an invalid
 		 * rhf. Drop such packets.
 		 */
-		if (rcd->ctxt == HFI1_CTRL_CTXT) {
-			u32 seq = rhf_rcv_seq(packet.rhf);
-
-			if (seq != rcd->seq_cnt)
+		if (rcd->ctxt == HFI1_CTRL_CTXT)
+			if (last_rcv_seq(rcd, rhf_rcv_seq(packet.rhf)))
 				skip_pkt = 1;
-		}
 	}
 
 	prescan_rxq(rcd, &packet);
@@ -1074,12 +1062,8 @@ int handle_receive_interrupt(struct hfi1_ctxtdata *rcd, int thread)
 			last = process_rcv_packet(&packet, thread);
 		}
 
-		if (!HFI1_CAP_KGET_MASK(rcd->flags, DMA_RTAIL)) {
-			u32 seq = rhf_rcv_seq(packet.rhf);
-
-			if (++rcd->seq_cnt > 13)
-				rcd->seq_cnt = 1;
-			if (seq != rcd->seq_cnt)
+		if (!get_dma_rtail_setting(rcd)) {
+			if (hfi1_seq_incr(rcd, rhf_rcv_seq(packet.rhf)))
 				last = RCV_PKT_DONE;
 			if (needset) {
 				dd_dev_info(dd, "Switching to NO_DMA_RTAIL\n");
@@ -1094,11 +1078,11 @@ int handle_receive_interrupt(struct hfi1_ctxtdata *rcd, int thread)
 			 * rhf. Drop such packets.
 			 */
 			if (rcd->ctxt == HFI1_CTRL_CTXT) {
-				u32 seq = rhf_rcv_seq(packet.rhf);
+				bool lseq;
 
-				if (++rcd->seq_cnt > 13)
-					rcd->seq_cnt = 1;
-				if (!last && (seq != rcd->seq_cnt))
+				lseq = hfi1_seq_incr(rcd,
+						     rhf_rcv_seq(packet.rhf));
+				if (!last && lseq)
 					skip_pkt = 1;
 			}
 
@@ -1114,7 +1098,7 @@ int handle_receive_interrupt(struct hfi1_ctxtdata *rcd, int thread)
 	}
 
 	process_rcv_qp_work(&packet);
-	rcd->head = packet.rhqoff;
+	hfi1_set_rcd_head(rcd, packet.rhqoff);
 
 bail:
 	/*
@@ -1748,8 +1732,8 @@ void seqfile_dump_rcd(struct seq_file *s, struct hfi1_ctxtdata *rcd)
 	struct ps_mdata mdata;
 
 	seq_printf(s, "Rcd %u: RcvHdr cnt %u entsize %u %s head %llu tail %llu\n",
-		   rcd->ctxt, rcd->rcvhdrq_cnt, rcd->rcvhdrqentsize,
-		   HFI1_CAP_KGET_MASK(rcd->flags, DMA_RTAIL) ?
+		   rcd->ctxt, get_hdrq_cnt(rcd), get_hdrqentsize(rcd),
+		   get_dma_rtail_setting(rcd) ?
 		   "dma_rtail" : "nodma_rtail",
 		   read_uctxt_csr(rcd->dd, rcd->ctxt, RCV_HDR_HEAD) &
 		   RCV_HDR_HEAD_HEAD_MASK,
diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index 7c5e3fb..bef6946 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -505,12 +505,12 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 			ret = -EINVAL;
 			goto done;
 		}
-		if ((flags & VM_WRITE) || !uctxt->rcvhdrtail_kvaddr) {
+		if ((flags & VM_WRITE) || !hfi1_rcvhdrtail_kvaddr(uctxt)) {
 			ret = -EPERM;
 			goto done;
 		}
 		memlen = PAGE_SIZE;
-		memvirt = (void *)uctxt->rcvhdrtail_kvaddr;
+		memvirt = (void *)hfi1_rcvhdrtail_kvaddr(uctxt);
 		flags &= ~VM_MAYWRITE;
 		break;
 	case SUBCTXT_UREGS:
@@ -1090,7 +1090,7 @@ static void user_init(struct hfi1_ctxtdata *uctxt)
 	 * don't have to wait to be sure the DMA update has happened
 	 * (chip resets head/tail to 0 on transition to enable).
 	 */
-	if (uctxt->rcvhdrtail_kvaddr)
+	if (hfi1_rcvhdrtail_kvaddr(uctxt))
 		clear_rcvhdrtail(uctxt);
 
 	/* Setup J_KEY before enabling the context */
@@ -1154,8 +1154,8 @@ static int get_ctxt_info(struct hfi1_filedata *fd, unsigned long arg, u32 len)
 	cinfo.send_ctxt = uctxt->sc->hw_context;
 
 	cinfo.egrtids = uctxt->egrbufs.alloced;
-	cinfo.rcvhdrq_cnt = uctxt->rcvhdrq_cnt;
-	cinfo.rcvhdrq_entsize = uctxt->rcvhdrqentsize << 2;
+	cinfo.rcvhdrq_cnt = get_hdrq_cnt(uctxt);
+	cinfo.rcvhdrq_entsize = get_hdrqentsize(uctxt) << 2;
 	cinfo.sdma_ring_size = fd->cq->nentries;
 	cinfo.rcvegr_size = uctxt->egrbufs.rcvtid_size;
 
@@ -1543,7 +1543,7 @@ static int manage_rcvq(struct hfi1_ctxtdata *uctxt, u16 subctxt,
 		 * always resets it's tail register back to 0 on a
 		 * transition from disabled to enabled.
 		 */
-		if (uctxt->rcvhdrtail_kvaddr)
+		if (hfi1_rcvhdrtail_kvaddr(uctxt))
 			clear_rcvhdrtail(uctxt);
 		rcvctrl_op = HFI1_RCVCTRL_CTXT_ENB;
 	} else {
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index fc10d65..d662fcc 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -1507,12 +1507,115 @@ void hfi1_make_ud_req_16B(struct rvt_qp *qp,
 #define RCV_PKT_LIMIT   0x1 /* stop, hit limit, start thread */
 #define RCV_PKT_DONE    0x2 /* stop, no more packets detected */
 
+/**
+ * hfi1_rcd_head - add accessor for rcd head
+ * @rcd: the context
+ */
+static inline u32 hfi1_rcd_head(struct hfi1_ctxtdata *rcd)
+{
+	return rcd->head;
+}
+
+/**
+ * hfi1_set_rcd_head - add accessor for rcd head
+ * @rcd: the context
+ * @head: the new head
+ */
+static inline void hfi1_set_rcd_head(struct hfi1_ctxtdata *rcd, u32 head)
+{
+	rcd->head = head;
+}
+
 /* calculate the current RHF address */
 static inline __le32 *get_rhf_addr(struct hfi1_ctxtdata *rcd)
 {
 	return (__le32 *)rcd->rcvhdrq + rcd->head + rcd->rhf_offset;
 }
 
+/* return DMA_RTAIL configuration */
+static inline bool get_dma_rtail_setting(struct hfi1_ctxtdata *rcd)
+{
+	return !!HFI1_CAP_KGET_MASK(rcd->flags, DMA_RTAIL);
+}
+
+/**
+ * hfi1_seq_incr_wrap - wrapping increment for sequence
+ * @seq: the current sequence number
+ *
+ * Returns: the incremented seq
+ */
+static inline u8 hfi1_seq_incr_wrap(u8 seq)
+{
+	if (++seq > RHF_MAX_SEQ)
+		seq = 1;
+	return seq;
+}
+
+/**
+ * hfi1_seq_cnt - return seq_cnt member
+ * @rcd: the receive context
+ *
+ * Return seq_cnt member
+ */
+static inline u8 hfi1_seq_cnt(struct hfi1_ctxtdata *rcd)
+{
+	return rcd->seq_cnt;
+}
+
+/**
+ * hfi1_set_seq_cnt - return seq_cnt member
+ * @rcd: the receive context
+ *
+ * Return seq_cnt member
+ */
+static inline void hfi1_set_seq_cnt(struct hfi1_ctxtdata *rcd, u8 cnt)
+{
+	rcd->seq_cnt = cnt;
+}
+
+/**
+ * last_rcv_seq - is last
+ * @rcd: the receive context
+ * @seq: sequence
+ *
+ * return true if last packet
+ */
+static inline bool last_rcv_seq(struct hfi1_ctxtdata *rcd, u32 seq)
+{
+	return seq != rcd->seq_cnt;
+}
+
+/**
+ * rcd_seq_incr - increment context sequence number
+ * @rcd: the receive context
+ * @seq: the current sequence number
+ *
+ * Returns: true if the this was the last packet
+ */
+static inline bool hfi1_seq_incr(struct hfi1_ctxtdata *rcd, u32 seq)
+{
+	rcd->seq_cnt = hfi1_seq_incr_wrap(rcd->seq_cnt);
+	return last_rcv_seq(rcd, seq);
+}
+
+/**
+ * get_hdrqentsize - return hdrq entry size
+ * @rcd: the receive context
+ */
+static inline u8 get_hdrqentsize(struct hfi1_ctxtdata *rcd)
+{
+	return rcd->rcvhdrqentsize;
+}
+
+/**
+ * get_hdrq_cnt - return hdrq count
+ * @rcd: the receive context
+ */
+static inline u16 get_hdrq_cnt(struct hfi1_ctxtdata *rcd)
+{
+	return rcd->rcvhdrq_cnt;
+}
+
 int hfi1_reset_device(int);
 
 void receive_interrupt_work(struct work_struct *work);
@@ -2015,9 +2118,21 @@ int hfi1_acquire_user_pages(struct mm_struct *mm, unsigned long vaddr,
 void hfi1_release_user_pages(struct mm_struct *mm, struct page **p,
 			     size_t npages, bool dirty);
 
+/**
+ * hfi1_rcvhdrtail_kvaddr - return tail kvaddr
+ * @rcd - the receive context
+ */
+static inline __le64 *hfi1_rcvhdrtail_kvaddr(const struct hfi1_ctxtdata *rcd)
+{
+	return (__le64 *)rcd->rcvhdrtail_kvaddr;
+}
+
 static inline void clear_rcvhdrtail(const struct hfi1_ctxtdata *rcd)
 {
-	*((u64 *)rcd->rcvhdrtail_kvaddr) = 0ULL;
+	u64 *kv = (u64 *)hfi1_rcvhdrtail_kvaddr(rcd);
+
+	if (kv)
+		*kv = 0ULL;
 }
 
 static inline u32 get_rcvhdrtail(const struct hfi1_ctxtdata *rcd)
@@ -2026,7 +2141,17 @@ static inline u32 get_rcvhdrtail(const struct hfi1_ctxtdata *rcd)
 	 * volatile because it's a DMA target from the chip, routine is
 	 * inlined, and don't want register caching or reordering.
 	 */
-	return (u32)le64_to_cpu(*rcd->rcvhdrtail_kvaddr);
+	return (u32)le64_to_cpu(*hfi1_rcvhdrtail_kvaddr(rcd));
+}
+
+static inline bool hfi1_packet_present(struct hfi1_ctxtdata *rcd)
+{
+	if (likely(!rcd->rcvhdrtail_kvaddr)) {
+		u32 seq = rhf_rcv_seq(rhf_to_cpu(get_rhf_addr(rcd)));
+
+		return !last_rcv_seq(rcd, seq);
+	}
+	return hfi1_rcd_head(rcd) != get_rcvhdrtail(rcd);
 }
 
 /*
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index 26b792b..3e56ee3 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -154,7 +154,7 @@ static int hfi1_create_kctxt(struct hfi1_devdata *dd,
 	/* Control context must use DMA_RTAIL */
 	if (rcd->ctxt == HFI1_CTRL_CTXT)
 		rcd->flags |= HFI1_CAP_DMA_RTAIL;
-	rcd->seq_cnt = 1;
+	hfi1_set_seq_cnt(rcd, 1);
 
 	rcd->sc = sc_alloc(dd, SC_ACK, rcd->rcvhdrqentsize, dd->node);
 	if (!rcd->sc) {
@@ -1149,9 +1149,9 @@ void hfi1_free_ctxtdata(struct hfi1_devdata *dd, struct hfi1_ctxtdata *rcd)
 		dma_free_coherent(&dd->pcidev->dev, rcvhdrq_size(rcd),
 				  rcd->rcvhdrq, rcd->rcvhdrq_dma);
 		rcd->rcvhdrq = NULL;
-		if (rcd->rcvhdrtail_kvaddr) {
+		if (hfi1_rcvhdrtail_kvaddr(rcd)) {
 			dma_free_coherent(&dd->pcidev->dev, PAGE_SIZE,
-					  (void *)rcd->rcvhdrtail_kvaddr,
+					  (void *)hfi1_rcvhdrtail_kvaddr(rcd),
 					  rcd->rcvhdrqtailaddr_dma);
 			rcd->rcvhdrtail_kvaddr = NULL;
 		}
diff --git a/drivers/infiniband/hw/hfi1/trace_ctxts.h b/drivers/infiniband/hw/hfi1/trace_ctxts.h
index e00c8a7..b5fc5c6 100644
--- a/drivers/infiniband/hw/hfi1/trace_ctxts.h
+++ b/drivers/infiniband/hw/hfi1/trace_ctxts.h
@@ -80,7 +80,7 @@
 			   __entry->credits = uctxt->sc->credits;
 			   __entry->hw_free = le64_to_cpu(*uctxt->sc->hw_free);
 			   __entry->piobase = uctxt->sc->base_addr;
-			   __entry->rcvhdrq_cnt = uctxt->rcvhdrq_cnt;
+			   __entry->rcvhdrq_cnt = get_hdrq_cnt(uctxt);
 			   __entry->rcvhdrq_dma = uctxt->rcvhdrq_dma;
 			   __entry->eager_cnt = uctxt->egrbufs.alloced;
 			   __entry->rcvegr_dma = uctxt->egrbufs.rcvtids[0].dma;
diff --git a/drivers/infiniband/hw/hfi1/trace_rx.h b/drivers/infiniband/hw/hfi1/trace_rx.h
index 3cec960..ebce81c 100644
--- a/drivers/infiniband/hw/hfi1/trace_rx.h
+++ b/drivers/infiniband/hw/hfi1/trace_rx.h
@@ -107,18 +107,11 @@
 	    TP_fast_assign(DD_DEV_ASSIGN(dd);
 			__entry->ctxt = rcd->ctxt;
 			if (rcd->do_interrupt ==
-			    &handle_receive_interrupt) {
+			    &handle_receive_interrupt)
 				__entry->slow_path = 1;
-				__entry->dma_rtail = 0xFF;
-			} else if (rcd->do_interrupt ==
-					&handle_receive_interrupt_dma_rtail){
-				__entry->dma_rtail = 1;
+			else
 				__entry->slow_path = 0;
-			} else if (rcd->do_interrupt ==
-					&handle_receive_interrupt_nodma_rtail) {
-				__entry->dma_rtail = 0;
-				__entry->slow_path = 0;
-			}
+			__entry->dma_rtail = get_dma_rtail_setting(rcd);
 			),
 	    TP_printk("[%s] ctxt %d SlowPath: %d DmaRtail: %d",
 		      __get_str(dev),
diff --git a/drivers/infiniband/hw/hfi1/vnic_main.c b/drivers/infiniband/hw/hfi1/vnic_main.c
index b49e60e..6b14581 100644
--- a/drivers/infiniband/hw/hfi1/vnic_main.c
+++ b/drivers/infiniband/hw/hfi1/vnic_main.c
@@ -78,7 +78,7 @@ static int setup_vnic_ctxt(struct hfi1_devdata *dd, struct hfi1_ctxtdata *uctxt)
 	if (ret)
 		goto done;
 
-	if (uctxt->rcvhdrtail_kvaddr)
+	if (hfi1_rcvhdrtail_kvaddr(uctxt))
 		clear_rcvhdrtail(uctxt);
 
 	rcvctrl_ops = HFI1_RCVCTRL_CTXT_ENB;

