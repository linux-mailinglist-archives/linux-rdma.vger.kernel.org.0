Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD551901BC
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2020 00:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgCWXPf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Mar 2020 19:15:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:55519 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbgCWXPe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Mar 2020 19:15:34 -0400
IronPort-SDR: Loe17WjKL/bdUXVc/MY8+Jo+RYxoNJK6T7QtJKj3mw3Jt/QjpSzUwhjPDdx4mtDt5Ce/+Bcb0X
 3OZpORqs7wFg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 16:15:33 -0700
IronPort-SDR: 5IInoxAn5TotijLQBbD4lv7PX2A3nS2LCZyzpmAm5QrciPvwSeDX5wVeMdRYHsXz6dxwJPYzN0
 ri1hR4mVgG1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="235369825"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga007.jf.intel.com with ESMTP; 23 Mar 2020 16:15:32 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 02NNFWNg014085;
        Mon, 23 Mar 2020 16:15:32 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 02NNFUYd064482;
        Mon, 23 Mar 2020 19:15:31 -0400
Subject: [PATCH v2 for-next 10/16] IB/hfi1: Add interrupt handler functions
 for accelerated ipoib
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Sadanand Warrier <sadanand.warrier@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Mon, 23 Mar 2020 19:15:30 -0400
Message-ID: <20200323231530.64035.22941.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20200323231152.64035.19274.stgit@awfm-01.aw.intel.com>
References: <20200323231152.64035.19274.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>

This patch adds the interrupt handler function, the NAPI poll
function, and its associated helper functions for receiving
accelerated ipoib packets. While we are here, fix the formats
of two error printouts.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Sadanand Warrier <sadanand.warrier@intel.com>
Signed-off-by: Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/affinity.c |   12 +++
 drivers/infiniband/hw/hfi1/affinity.h |    3 +
 drivers/infiniband/hw/hfi1/chip.c     |   44 ++++++++++++
 drivers/infiniband/hw/hfi1/chip.h     |    1 
 drivers/infiniband/hw/hfi1/driver.c   |  120 +++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi1/hfi.h      |    4 +
 drivers/infiniband/hw/hfi1/init.c     |    1 
 drivers/infiniband/hw/hfi1/msix.c     |   20 +++++-
 drivers/infiniband/hw/hfi1/msix.h     |    5 +
 drivers/infiniband/hw/hfi1/netdev.h   |    3 +
 10 files changed, 206 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
index 1aeea5d..2a91b8d 100644
--- a/drivers/infiniband/hw/hfi1/affinity.c
+++ b/drivers/infiniband/hw/hfi1/affinity.c
@@ -1,5 +1,5 @@
 /*
- * Copyright(c) 2015 - 2018 Intel Corporation.
+ * Copyright(c) 2015 - 2020 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -64,6 +64,7 @@ struct hfi1_affinity_node_list node_affinity = {
 static const char * const irq_type_names[] = {
 	"SDMA",
 	"RCVCTXT",
+	"NETDEVCTXT",
 	"GENERAL",
 	"OTHER",
 };
@@ -915,6 +916,11 @@ static int get_irq_affinity(struct hfi1_devdata *dd,
 			set = &entry->rcv_intr;
 		scnprintf(extra, 64, "ctxt %u", rcd->ctxt);
 		break;
+	case IRQ_NETDEVCTXT:
+		rcd = (struct hfi1_ctxtdata *)msix->arg;
+		set = &entry->def_intr;
+		scnprintf(extra, 64, "ctxt %u", rcd->ctxt);
+		break;
 	default:
 		dd_dev_err(dd, "Invalid IRQ type %d\n", msix->type);
 		return -EINVAL;
@@ -987,6 +993,10 @@ void hfi1_put_irq_affinity(struct hfi1_devdata *dd,
 		if (rcd->ctxt != HFI1_CTRL_CTXT)
 			set = &entry->rcv_intr;
 		break;
+	case IRQ_NETDEVCTXT:
+		rcd = (struct hfi1_ctxtdata *)msix->arg;
+		set = &entry->def_intr;
+		break;
 	default:
 		mutex_unlock(&node_affinity.lock);
 		return;
diff --git a/drivers/infiniband/hw/hfi1/affinity.h b/drivers/infiniband/hw/hfi1/affinity.h
index 6a7e6ea..f94ed5d 100644
--- a/drivers/infiniband/hw/hfi1/affinity.h
+++ b/drivers/infiniband/hw/hfi1/affinity.h
@@ -1,5 +1,5 @@
 /*
- * Copyright(c) 2015 - 2018 Intel Corporation.
+ * Copyright(c) 2015 - 2020 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -52,6 +52,7 @@
 enum irq_type {
 	IRQ_SDMA,
 	IRQ_RCVCTXT,
+	IRQ_NETDEVCTXT,
 	IRQ_GENERAL,
 	IRQ_OTHER
 };
diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 07eec35..2117612 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -66,6 +66,7 @@
 #include "affinity.h"
 #include "debugfs.h"
 #include "fault.h"
+#include "netdev.h"
 
 uint num_vls = HFI1_MAX_VLS_SUPPORTED;
 module_param(num_vls, uint, S_IRUGO);
@@ -8480,6 +8481,49 @@ static void hfi1_rcd_eoi_intr(struct hfi1_ctxtdata *rcd)
 	local_irq_restore(flags);
 }
 
+/**
+ * hfi1_netdev_rx_napi - napi poll function to move eoi inline
+ * @napi - pointer to napi object
+ * @budget - netdev budget
+ */
+int hfi1_netdev_rx_napi(struct napi_struct *napi, int budget)
+{
+	struct hfi1_netdev_rxq *rxq = container_of(napi,
+			struct hfi1_netdev_rxq, napi);
+	struct hfi1_ctxtdata *rcd = rxq->rcd;
+	int work_done = 0;
+
+	work_done = rcd->do_interrupt(rcd, budget);
+
+	if (work_done < budget) {
+		napi_complete_done(napi, work_done);
+		hfi1_rcd_eoi_intr(rcd);
+	}
+
+	return work_done;
+}
+
+/* Receive packet napi handler for netdevs VNIC and AIP  */
+irqreturn_t receive_context_interrupt_napi(int irq, void *data)
+{
+	struct hfi1_ctxtdata *rcd = data;
+
+	receive_interrupt_common(rcd);
+
+	if (likely(rcd->napi)) {
+		if (likely(napi_schedule_prep(rcd->napi)))
+			__napi_schedule_irqoff(rcd->napi);
+		else
+			__hfi1_rcd_eoi_intr(rcd);
+	} else {
+		WARN_ONCE(1, "Napi IRQ handler without napi set up ctxt=%d\n",
+			  rcd->ctxt);
+		__hfi1_rcd_eoi_intr(rcd);
+	}
+
+	return IRQ_HANDLED;
+}
+
 /*
  * Receive packet IRQ handler.  This routine expects to be on its own IRQ.
  * This routine will try to handle packets immediately (latency), but if
diff --git a/drivers/infiniband/hw/hfi1/chip.h b/drivers/infiniband/hw/hfi1/chip.h
index b10e0bf..2c6f2de 100644
--- a/drivers/infiniband/hw/hfi1/chip.h
+++ b/drivers/infiniband/hw/hfi1/chip.h
@@ -1447,6 +1447,7 @@ int hfi1_set_ctxt_pkey(struct hfi1_devdata *dd, struct hfi1_ctxtdata *ctxt,
 irqreturn_t sdma_interrupt(int irq, void *data);
 irqreturn_t receive_context_interrupt(int irq, void *data);
 irqreturn_t receive_context_thread(int irq, void *data);
+irqreturn_t receive_context_interrupt_napi(int irq, void *data);
 
 int set_intr_bits(struct hfi1_devdata *dd, u16 first, u16 last, bool set);
 void init_qsfp_int(struct hfi1_devdata *dd);
diff --git a/drivers/infiniband/hw/hfi1/driver.c b/drivers/infiniband/hw/hfi1/driver.c
index c5ed6ed..d89fc8f 100644
--- a/drivers/infiniband/hw/hfi1/driver.c
+++ b/drivers/infiniband/hw/hfi1/driver.c
@@ -752,6 +752,39 @@ static noinline int skip_rcv_packet(struct hfi1_packet *packet, int thread)
 	return ret;
 }
 
+static void process_rcv_packet_napi(struct hfi1_packet *packet)
+{
+	packet->etype = rhf_rcv_type(packet->rhf);
+
+	/* total length */
+	packet->tlen = rhf_pkt_len(packet->rhf); /* in bytes */
+	/* retrieve eager buffer details */
+	packet->etail = rhf_egr_index(packet->rhf);
+	packet->ebuf = get_egrbuf(packet->rcd, packet->rhf,
+				  &packet->updegr);
+	/*
+	 * Prefetch the contents of the eager buffer.  It is
+	 * OK to send a negative length to prefetch_range().
+	 * The +2 is the size of the RHF.
+	 */
+	prefetch_range(packet->ebuf,
+		       packet->tlen - ((packet->rcd->rcvhdrqentsize -
+				       (rhf_hdrq_offset(packet->rhf)
+					+ 2)) * 4));
+
+	packet->rcd->rhf_rcv_function_map[packet->etype](packet);
+	packet->numpkt++;
+
+	/* Set up for the next packet */
+	packet->rhqoff += packet->rsize;
+	if (packet->rhqoff >= packet->maxcnt)
+		packet->rhqoff = 0;
+
+	packet->rhf_addr = (__le32 *)packet->rcd->rcvhdrq + packet->rhqoff +
+				      packet->rcd->rhf_offset;
+	packet->rhf = rhf_to_cpu(packet->rhf_addr);
+}
+
 static inline int process_rcv_packet(struct hfi1_packet *packet, int thread)
 {
 	int ret;
@@ -831,6 +864,36 @@ static inline void finish_packet(struct hfi1_packet *packet)
 }
 
 /*
+ * handle_receive_interrupt_napi_fp - receive a packet
+ * @rcd: the context
+ * @budget: polling budget
+ *
+ * Called from interrupt handler for receive interrupt.
+ * This is the fast path interrupt handler
+ * when executing napi soft irq environment.
+ */
+int handle_receive_interrupt_napi_fp(struct hfi1_ctxtdata *rcd, int budget)
+{
+	struct hfi1_packet packet;
+
+	init_packet(rcd, &packet);
+	if (last_rcv_seq(rcd, rhf_rcv_seq(packet.rhf)))
+		goto bail;
+
+	while (packet.numpkt < budget) {
+		process_rcv_packet_napi(&packet);
+		if (hfi1_seq_incr(rcd, rhf_rcv_seq(packet.rhf)))
+			break;
+
+		process_rcv_update(0, &packet);
+	}
+	hfi1_set_rcd_head(rcd, packet.rhqoff);
+bail:
+	finish_packet(&packet);
+	return packet.numpkt;
+}
+
+/*
  * Handle receive interrupts when using the no dma rtail option.
  */
 int handle_receive_interrupt_nodma_rtail(struct hfi1_ctxtdata *rcd, int thread)
@@ -1078,6 +1141,63 @@ int handle_receive_interrupt(struct hfi1_ctxtdata *rcd, int thread)
 }
 
 /*
+ * handle_receive_interrupt_napi_sp - receive a packet
+ * @rcd: the context
+ * @budget: polling budget
+ *
+ * Called from interrupt handler for errors or receive interrupt.
+ * This is the slow path interrupt handler
+ * when executing napi soft irq environment.
+ */
+int handle_receive_interrupt_napi_sp(struct hfi1_ctxtdata *rcd, int budget)
+{
+	struct hfi1_devdata *dd = rcd->dd;
+	int last = RCV_PKT_OK;
+	bool needset = true;
+	struct hfi1_packet packet;
+
+	init_packet(rcd, &packet);
+	if (last_rcv_seq(rcd, rhf_rcv_seq(packet.rhf)))
+		goto bail;
+
+	while (last != RCV_PKT_DONE && packet.numpkt < budget) {
+		if (hfi1_need_drop(dd)) {
+			/* On to the next packet */
+			packet.rhqoff += packet.rsize;
+			packet.rhf_addr = (__le32 *)rcd->rcvhdrq +
+					  packet.rhqoff +
+					  rcd->rhf_offset;
+			packet.rhf = rhf_to_cpu(packet.rhf_addr);
+
+		} else {
+			if (set_armed_to_active(&packet))
+				goto bail;
+			process_rcv_packet_napi(&packet);
+		}
+
+		if (hfi1_seq_incr(rcd, rhf_rcv_seq(packet.rhf)))
+			last = RCV_PKT_DONE;
+
+		if (needset) {
+			needset = false;
+			set_all_fastpath(dd, rcd);
+		}
+
+		process_rcv_update(last, &packet);
+	}
+
+	hfi1_set_rcd_head(rcd, packet.rhqoff);
+
+bail:
+	/*
+	 * Always write head at end, and setup rcv interrupt, even
+	 * if no packets were processed.
+	 */
+	finish_packet(&packet);
+	return packet.numpkt;
+}
+
+/*
  * We may discover in the interrupt that the hardware link state has
  * changed from ARMED to ACTIVE (due to the arrival of a non-SC15 packet),
  * and we need to update the driver's notion of the link state.  We cannot
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index c7d0aad..986d8c3 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -385,11 +385,11 @@ struct hfi1_packet {
 	u32 rhqoff;
 	u32 dlid;
 	u32 slid;
+	int numpkt;
 	u16 tlen;
 	s16 etail;
 	u16 pkey;
 	u8 hlen;
-	u8 numpkt;
 	u8 rsize;
 	u8 updegr;
 	u8 etype;
@@ -1501,6 +1501,8 @@ struct hfi1_ctxtdata *hfi1_rcd_get_by_index_safe(struct hfi1_devdata *dd,
 int handle_receive_interrupt(struct hfi1_ctxtdata *rcd, int thread);
 int handle_receive_interrupt_nodma_rtail(struct hfi1_ctxtdata *rcd, int thread);
 int handle_receive_interrupt_dma_rtail(struct hfi1_ctxtdata *rcd, int thread);
+int handle_receive_interrupt_napi_fp(struct hfi1_ctxtdata *rcd, int budget);
+int handle_receive_interrupt_napi_sp(struct hfi1_ctxtdata *rcd, int budget);
 void set_all_slowpath(struct hfi1_devdata *dd);
 
 extern const struct pci_device_id hfi1_pci_tbl[];
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index 8c6b96a..64279d0 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -374,6 +374,7 @@ int hfi1_create_ctxtdata(struct hfi1_pportdata *ppd, int numa,
 		rcd->numa_id = numa;
 		rcd->rcv_array_groups = dd->rcv_entries.ngroups;
 		rcd->rhf_rcv_function_map = normal_rhf_rcv_functions;
+		rcd->msix_intr = CCE_NUM_MSIX_VECTORS;
 
 		mutex_init(&rcd->exp_mutex);
 		spin_lock_init(&rcd->exp_lock);
diff --git a/drivers/infiniband/hw/hfi1/msix.c b/drivers/infiniband/hw/hfi1/msix.c
index 7574f2b..7559875e 100644
--- a/drivers/infiniband/hw/hfi1/msix.c
+++ b/drivers/infiniband/hw/hfi1/msix.c
@@ -49,6 +49,7 @@
 #include "hfi.h"
 #include "affinity.h"
 #include "sdma.h"
+#include "netdev.h"
 
 /**
  * msix_initialize() - Calculate, request and configure MSIx IRQs
@@ -140,7 +141,7 @@ static int msix_request_irq(struct hfi1_devdata *dd, void *arg,
 	ret = pci_request_irq(dd->pcidev, nr, handler, thread, arg, name);
 	if (ret) {
 		dd_dev_err(dd,
-			   "%s: request for IRQ %d failed, MSIx %lu, err %d\n",
+			   "%s: request for IRQ %d failed, MSIx %lx, err %d\n",
 			   name, irq, nr, ret);
 		spin_lock(&dd->msix_info.msix_lock);
 		__clear_bit(nr, dd->msix_info.in_use_msix);
@@ -160,7 +161,7 @@ static int msix_request_irq(struct hfi1_devdata *dd, void *arg,
 	/* This is a request, so a failure is not fatal */
 	ret = hfi1_get_irq_affinity(dd, me);
 	if (ret)
-		dd_dev_err(dd, "unable to pin IRQ %d\n", ret);
+		dd_dev_err(dd, "%s: unable to pin IRQ %d\n", name, ret);
 
 	return nr;
 }
@@ -204,6 +205,21 @@ int msix_request_rcd_irq(struct hfi1_ctxtdata *rcd)
 }
 
 /**
+ * msix_request_rcd_irq() - Helper function for RCVAVAIL IRQs
+ * for netdev context
+ * @rcd: valid netdev contexti
+ */
+int msix_netdev_request_rcd_irq(struct hfi1_ctxtdata *rcd)
+{
+	char name[MAX_NAME_SIZE];
+
+	snprintf(name, sizeof(name), DRIVER_NAME "_%d nd kctxt%d",
+		 rcd->dd->unit, rcd->ctxt);
+	return msix_request_rcd_irq_common(rcd, receive_context_interrupt_napi,
+					   NULL, name);
+}
+
+/**
  * msix_request_smda_ira() - Helper for getting SDMA IRQ resources
  * @sde: valid sdma engine
  *
diff --git a/drivers/infiniband/hw/hfi1/msix.h b/drivers/infiniband/hw/hfi1/msix.h
index 1a02ab7..42fab94 100644
--- a/drivers/infiniband/hw/hfi1/msix.h
+++ b/drivers/infiniband/hw/hfi1/msix.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 /*
- * Copyright(c) 2018 Intel Corporation.
+ * Copyright(c) 2018 - 2020 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -59,7 +59,8 @@
 int msix_request_sdma_irq(struct sdma_engine *sde);
 void msix_free_irq(struct hfi1_devdata *dd, u8 msix_intr);
 
-/* VNIC interface */
+/* Netdev interface */
 void msix_vnic_synchronize_irq(struct hfi1_devdata *dd);
+int msix_netdev_request_rcd_irq(struct hfi1_ctxtdata *rcd);
 
 #endif
diff --git a/drivers/infiniband/hw/hfi1/netdev.h b/drivers/infiniband/hw/hfi1/netdev.h
index 8992dfe..6740ec3 100644
--- a/drivers/infiniband/hw/hfi1/netdev.h
+++ b/drivers/infiniband/hw/hfi1/netdev.h
@@ -87,4 +87,7 @@ struct hfi1_ctxtdata *hfi1_netdev_get_ctxt(struct hfi1_devdata *dd, int ctxt)
 void *hfi1_netdev_get_data(struct hfi1_devdata *dd, int id);
 void *hfi1_netdev_get_first_data(struct hfi1_devdata *dd, int *start_id);
 
+/* chip.c  */
+int hfi1_netdev_rx_napi(struct napi_struct *napi, int budget);
+
 #endif /* HFI1_NETDEV_H */

