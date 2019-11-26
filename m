Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 615DE10A002
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2019 15:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfKZONY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Nov 2019 09:13:24 -0500
Received: from mga05.intel.com ([192.55.52.43]:41954 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfKZONY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 Nov 2019 09:13:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 06:12:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,246,1571727600"; 
   d="scan'208";a="383160082"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga005.jf.intel.com with ESMTP; 26 Nov 2019 06:12:35 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id xAQECYTd042039;
        Tue, 26 Nov 2019 07:12:34 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id xAQECWIC059073;
        Tue, 26 Nov 2019 09:12:33 -0500
Subject: [PATCH for-next v2 04/11] IB/hfi1: Add fast and slow handlers for
 receive context
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        linux-rdma@vger.kernel.org, Kaike Wan <kaike.wan@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Sadanand Warrier <sadanand.warrier@intel.com>
Date:   Tue, 26 Nov 2019 09:12:32 -0500
Message-ID: <20191126141232.58836.58520.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20191126141055.58836.79452.stgit@awfm-01.aw.intel.com>
References: <20191126141055.58836.79452.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

This patch eliminate special cases by adding a fast_handler member to
the receive context and changes to the fast handler as specified in the
new variable. Initialize the variable as soon as the setting for dma
tail is known when the context is created.

Setting fast path is called every time when any context has entered
slow path. Add function to check if contexts is using fast path and do
not set fast path when it is already done to improve RCD fastpath
setting.

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>
Signed-off-by: Sadanand Warrier <sadanand.warrier@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/driver.c   |   66 ++++++---------------------------
 drivers/infiniband/hw/hfi1/hfi.h      |   41 ++++++++++++++++++++-
 drivers/infiniband/hw/hfi1/init.c     |    5 +++
 drivers/infiniband/hw/hfi1/trace_rx.h |    6 +--
 4 files changed, 58 insertions(+), 60 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/driver.c b/drivers/infiniband/hw/hfi1/driver.c
index 8374922..3671191 100644
--- a/drivers/infiniband/hw/hfi1/driver.c
+++ b/drivers/infiniband/hw/hfi1/driver.c
@@ -883,9 +883,8 @@ int handle_receive_interrupt_dma_rtail(struct hfi1_ctxtdata *rcd, int thread)
 	return last;
 }
 
-static inline void set_nodma_rtail(struct hfi1_devdata *dd, u16 ctxt)
+static void set_all_fastpath(struct hfi1_devdata *dd, struct hfi1_ctxtdata *rcd)
 {
-	struct hfi1_ctxtdata *rcd;
 	u16 i;
 
 	/*
@@ -893,50 +892,17 @@ static inline void set_nodma_rtail(struct hfi1_devdata *dd, u16 ctxt)
 	 * interrupt handler only for that context. Otherwise, switch
 	 * interrupt handler for all statically allocated kernel contexts.
 	 */
-	if (ctxt >= dd->first_dyn_alloc_ctxt) {
-		rcd = hfi1_rcd_get_by_index_safe(dd, ctxt);
-		if (rcd) {
-			rcd->do_interrupt =
-				&handle_receive_interrupt_nodma_rtail;
-			hfi1_rcd_put(rcd);
-		}
-		return;
-	}
-
-	for (i = HFI1_CTRL_CTXT + 1; i < dd->first_dyn_alloc_ctxt; i++) {
-		rcd = hfi1_rcd_get_by_index(dd, i);
-		if (rcd)
-			rcd->do_interrupt =
-				&handle_receive_interrupt_nodma_rtail;
+	if (rcd->ctxt >= dd->first_dyn_alloc_ctxt && !rcd->is_vnic) {
+		hfi1_rcd_get(rcd);
+		hfi1_set_fast(rcd);
 		hfi1_rcd_put(rcd);
-	}
-}
-
-static inline void set_dma_rtail(struct hfi1_devdata *dd, u16 ctxt)
-{
-	struct hfi1_ctxtdata *rcd;
-	u16 i;
-
-	/*
-	 * For dynamically allocated kernel contexts (like vnic) switch
-	 * interrupt handler only for that context. Otherwise, switch
-	 * interrupt handler for all statically allocated kernel contexts.
-	 */
-	if (ctxt >= dd->first_dyn_alloc_ctxt) {
-		rcd = hfi1_rcd_get_by_index_safe(dd, ctxt);
-		if (rcd) {
-			rcd->do_interrupt =
-				&handle_receive_interrupt_dma_rtail;
-			hfi1_rcd_put(rcd);
-		}
 		return;
 	}
 
-	for (i = HFI1_CTRL_CTXT + 1; i < dd->first_dyn_alloc_ctxt; i++) {
+	for (i = HFI1_CTRL_CTXT + 1; i < dd->num_rcv_contexts; i++) {
 		rcd = hfi1_rcd_get_by_index(dd, i);
-		if (rcd)
-			rcd->do_interrupt =
-				&handle_receive_interrupt_dma_rtail;
+		if (rcd && (i < dd->first_dyn_alloc_ctxt || rcd->is_vnic))
+			hfi1_set_fast(rcd);
 		hfi1_rcd_put(rcd);
 	}
 }
@@ -952,7 +918,7 @@ void set_all_slowpath(struct hfi1_devdata *dd)
 		if (!rcd)
 			continue;
 		if (i < dd->first_dyn_alloc_ctxt || rcd->is_vnic)
-			rcd->do_interrupt = &handle_receive_interrupt;
+			rcd->do_interrupt = rcd->slow_handler;
 
 		hfi1_rcd_put(rcd);
 	}
@@ -1065,11 +1031,6 @@ int handle_receive_interrupt(struct hfi1_ctxtdata *rcd, int thread)
 		if (!get_dma_rtail_setting(rcd)) {
 			if (hfi1_seq_incr(rcd, rhf_rcv_seq(packet.rhf)))
 				last = RCV_PKT_DONE;
-			if (needset) {
-				dd_dev_info(dd, "Switching to NO_DMA_RTAIL\n");
-				set_nodma_rtail(dd, rcd->ctxt);
-				needset = 0;
-			}
 		} else {
 			if (packet.rhqoff == hdrqtail)
 				last = RCV_PKT_DONE;
@@ -1085,15 +1046,12 @@ int handle_receive_interrupt(struct hfi1_ctxtdata *rcd, int thread)
 				if (!last && lseq)
 					skip_pkt = 1;
 			}
-
-			if (needset) {
-				dd_dev_info(dd,
-					    "Switching to DMA_RTAIL\n");
-				set_dma_rtail(dd, rcd->ctxt);
-				needset = 0;
-			}
 		}
 
+		if (needset) {
+			needset = false;
+			set_all_fastpath(dd, rcd);
+		}
 		process_rcv_update(last, &packet);
 	}
 
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index a5d8b62..b819d7d 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -197,6 +197,8 @@ struct exp_tid_set {
 	u32 count;
 };
 
+struct hfi1_ctxtdata;
+typedef int (*intr_handler)(struct hfi1_ctxtdata *rcd, int data);
 typedef int (*rhf_rcv_function_ptr)(struct hfi1_packet *packet);
 
 struct tid_queue {
@@ -226,7 +228,11 @@ struct hfi1_ctxtdata {
 	 * be valid. Worst case is we process an extra interrupt and up to 64
 	 * packets with the wrong interrupt handler.
 	 */
-	int (*do_interrupt)(struct hfi1_ctxtdata *rcd, int threaded);
+	intr_handler do_interrupt;
+	/** fast handler after autoactive */
+	intr_handler fast_handler;
+	/** slow handler */
+	intr_handler slow_handler;
 	/* verbs rx_stats per rcd */
 	struct hfi1_opcode_stats_perctx *opstats;
 	/* clear interrupt mask */
@@ -1616,6 +1622,39 @@ static inline u16 get_hdrq_cnt(struct hfi1_ctxtdata *rcd)
 	return rcd->rcvhdrq_cnt;
 }
 
+/**
+ * hfi1_is_slowpath - check if this context is slow path
+ * @rcd: the receive context
+ */
+static inline bool hfi1_is_slowpath(struct hfi1_ctxtdata *rcd)
+{
+	return rcd->do_interrupt == rcd->slow_handler;
+}
+
+/**
+ * hfi1_is_fastpath - check if this context is fast path
+ * @rcd: the receive context
+ */
+static inline bool hfi1_is_fastpath(struct hfi1_ctxtdata *rcd)
+{
+	if (rcd->ctxt == HFI1_CTRL_CTXT)
+		return false;
+
+	return rcd->do_interrupt == rcd->fast_handler;
+}
+
+/**
+ * hfi1_set_fast - change to the fast handler
+ * @rcd: the receive context
+ */
+static inline void hfi1_set_fast(struct hfi1_ctxtdata *rcd)
+{
+	if (unlikely(!rcd))
+		return;
+	if (unlikely(!hfi1_is_fastpath(rcd)))
+		rcd->do_interrupt = rcd->fast_handler;
+}
+
 int hfi1_reset_device(int);
 
 void receive_interrupt_work(struct work_struct *work);
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index 821e6fe..55adc97 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -150,6 +150,11 @@ static int hfi1_create_kctxt(struct hfi1_devdata *dd,
 	/* Control context must use DMA_RTAIL */
 	if (rcd->ctxt == HFI1_CTRL_CTXT)
 		rcd->flags |= HFI1_CAP_DMA_RTAIL;
+	rcd->fast_handler = get_dma_rtail_setting(rcd) ?
+				handle_receive_interrupt_dma_rtail :
+				handle_receive_interrupt_nodma_rtail;
+	rcd->slow_handler = handle_receive_interrupt;
+
 	hfi1_set_seq_cnt(rcd, 1);
 
 	rcd->sc = sc_alloc(dd, SC_ACK, rcd->rcvhdrqentsize, dd->node);
diff --git a/drivers/infiniband/hw/hfi1/trace_rx.h b/drivers/infiniband/hw/hfi1/trace_rx.h
index ebce81c..168079e 100644
--- a/drivers/infiniband/hw/hfi1/trace_rx.h
+++ b/drivers/infiniband/hw/hfi1/trace_rx.h
@@ -106,11 +106,7 @@
 			     ),
 	    TP_fast_assign(DD_DEV_ASSIGN(dd);
 			__entry->ctxt = rcd->ctxt;
-			if (rcd->do_interrupt ==
-			    &handle_receive_interrupt)
-				__entry->slow_path = 1;
-			else
-				__entry->slow_path = 0;
+			__entry->slow_path = hfi1_is_slowpath(rcd);
 			__entry->dma_rtail = get_dma_rtail_setting(rcd);
 			),
 	    TP_printk("[%s] ctxt %d SlowPath: %d DmaRtail: %d",

