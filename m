Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74A66131322
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2020 14:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgAFNmB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jan 2020 08:42:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:49781 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgAFNmA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jan 2020 08:42:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 05:42:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,402,1571727600"; 
   d="scan'208";a="232828234"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga002.jf.intel.com with ESMTP; 06 Jan 2020 05:41:59 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 006DfxYw037333;
        Mon, 6 Jan 2020 06:41:59 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 006DfvBO119653;
        Mon, 6 Jan 2020 08:41:58 -0500
Subject: [PATCH for-next 3/9] IB/hfi1: Move common receive IRQ code to
 function
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Mon, 06 Jan 2020 08:41:57 -0500
Message-ID: <20200106134157.119356.32656.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20200106133845.119356.20115.stgit@awfm-01.aw.intel.com>
References: <20200106133845.119356.20115.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>

Tracing interrupts, incrementing interrupt counter and ASPM
are part that will be reused by HFI1 receive IRQ handlers.

Create common function to have shared code in one place.

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/chip.c |   82 +++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 30 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 860615d..9e2bf99 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -8403,6 +8403,55 @@ static inline int check_packet_present(struct hfi1_ctxtdata *rcd)
 	return hfi1_rcd_head(rcd) != tail;
 }
 
+/**
+ * Common code for receive contexts interrupt handlers.
+ * Update traces, increment kernel IRQ counter and
+ * setup ASPM when needed.
+ */
+static void receive_interrupt_common(struct hfi1_ctxtdata *rcd)
+{
+	struct hfi1_devdata *dd = rcd->dd;
+
+	trace_hfi1_receive_interrupt(dd, rcd);
+	this_cpu_inc(*dd->int_counter);
+	aspm_ctx_disable(rcd);
+}
+
+/**
+ * __hfi1_rcd_eoi_intr() - Make HW issue receive interrupt
+ * when there are packets present in the queue. When calling
+ * with interrupts enabled please use hfi1_rcd_eoi_intr.
+ *
+ * @rcd: valid receive context
+ */
+static void __hfi1_rcd_eoi_intr(struct hfi1_ctxtdata *rcd)
+{
+	clear_recv_intr(rcd);
+	if (check_packet_present(rcd))
+		force_recv_intr(rcd);
+}
+
+/**
+ * hfi1_rcd_eoi_intr() - End of Interrupt processing action
+ *
+ * @rcd: Ptr to hfi1_ctxtdata of receive context
+ *
+ *  Hold IRQs so we can safely clear the interrupt and
+ *  recheck for a packet that may have arrived after the previous
+ *  check and the interrupt clear.  If a packet arrived, force another
+ *  interrupt. This routine can be called at the end of receive packet
+ *  processing in interrupt service routines, interrupt service thread
+ *  and softirqs
+ */
+static void hfi1_rcd_eoi_intr(struct hfi1_ctxtdata *rcd)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__hfi1_rcd_eoi_intr(rcd);
+	local_irq_restore(flags);
+}
+
 /*
  * Receive packet IRQ handler.  This routine expects to be on its own IRQ.
  * This routine will try to handle packets immediately (latency), but if
@@ -8414,13 +8463,9 @@ static inline int check_packet_present(struct hfi1_ctxtdata *rcd)
 irqreturn_t receive_context_interrupt(int irq, void *data)
 {
 	struct hfi1_ctxtdata *rcd = data;
-	struct hfi1_devdata *dd = rcd->dd;
 	int disposition;
-	int present;
 
-	trace_hfi1_receive_interrupt(dd, rcd);
-	this_cpu_inc(*dd->int_counter);
-	aspm_ctx_disable(rcd);
+	receive_interrupt_common(rcd);
 
 	/* receive interrupt remains blocked while processing packets */
 	disposition = rcd->do_interrupt(rcd, 0);
@@ -8433,17 +8478,7 @@ irqreturn_t receive_context_interrupt(int irq, void *data)
 	if (disposition == RCV_PKT_LIMIT)
 		return IRQ_WAKE_THREAD;
 
-	/*
-	 * The packet processor detected no more packets.  Clear the receive
-	 * interrupt and recheck for a packet packet that may have arrived
-	 * after the previous check and interrupt clear.  If a packet arrived,
-	 * force another interrupt.
-	 */
-	clear_recv_intr(rcd);
-	present = check_packet_present(rcd);
-	if (present)
-		force_recv_intr(rcd);
-
+	__hfi1_rcd_eoi_intr(rcd);
 	return IRQ_HANDLED;
 }
 
@@ -8454,24 +8489,11 @@ irqreturn_t receive_context_interrupt(int irq, void *data)
 irqreturn_t receive_context_thread(int irq, void *data)
 {
 	struct hfi1_ctxtdata *rcd = data;
-	int present;
 
 	/* receive interrupt is still blocked from the IRQ handler */
 	(void)rcd->do_interrupt(rcd, 1);
 
-	/*
-	 * The packet processor will only return if it detected no more
-	 * packets.  Hold IRQs here so we can safely clear the interrupt and
-	 * recheck for a packet that may have arrived after the previous
-	 * check and the interrupt clear.  If a packet arrived, force another
-	 * interrupt.
-	 */
-	local_irq_disable();
-	clear_recv_intr(rcd);
-	present = check_packet_present(rcd);
-	if (present)
-		force_recv_intr(rcd);
-	local_irq_enable();
+	hfi1_rcd_eoi_intr(rcd);
 
 	return IRQ_HANDLED;
 }

