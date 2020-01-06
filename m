Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C362A131328
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2020 14:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgAFNmZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jan 2020 08:42:25 -0500
Received: from mga18.intel.com ([134.134.136.126]:11439 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgAFNmZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jan 2020 08:42:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 05:42:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,402,1571727600"; 
   d="scan'208";a="222837283"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga003.jf.intel.com with ESMTP; 06 Jan 2020 05:42:24 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 006DgNdj037349;
        Mon, 6 Jan 2020 06:42:23 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 006DgMC2119715;
        Mon, 6 Jan 2020 08:42:22 -0500
Subject: [PATCH for-next 7/9] IB/hfi1: Return void in packet receiving
 functions
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Mon, 06 Jan 2020 08:42:22 -0500
Message-ID: <20200106134222.119356.84098.stgit@awfm-01.aw.intel.com>
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

Packet receiving functions returns int value, and yet the return values
are not used at all.

This patch converts the functions to return void.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/driver.c |   41 +++++++++++++++--------------------
 drivers/infiniband/hw/hfi1/hfi.h    |    2 +-
 2 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/driver.c b/drivers/infiniband/hw/hfi1/driver.c
index 46c1be0..0b9fbfa 100644
--- a/drivers/infiniband/hw/hfi1/driver.c
+++ b/drivers/infiniband/hw/hfi1/driver.c
@@ -1553,23 +1553,22 @@ void handle_eflags(struct hfi1_packet *packet)
  * The following functions are called by the interrupt handler. They are type
  * specific handlers for each packet type.
  */
-static int process_receive_ib(struct hfi1_packet *packet)
+static void process_receive_ib(struct hfi1_packet *packet)
 {
 	if (hfi1_setup_9B_packet(packet))
-		return RHF_RCV_CONTINUE;
+		return;
 
 	if (unlikely(hfi1_dbg_should_fault_rx(packet)))
-		return RHF_RCV_CONTINUE;
+		return;
 
 	trace_hfi1_rcvhdr(packet);
 
 	if (unlikely(rhf_err_flags(packet->rhf))) {
 		handle_eflags(packet);
-		return RHF_RCV_CONTINUE;
+		return;
 	}
 
 	hfi1_ib_rcv(packet);
-	return RHF_RCV_CONTINUE;
 }
 
 static inline bool hfi1_is_vnic_packet(struct hfi1_packet *packet)
@@ -1585,23 +1584,23 @@ static inline bool hfi1_is_vnic_packet(struct hfi1_packet *packet)
 	return false;
 }
 
-static int process_receive_bypass(struct hfi1_packet *packet)
+static void process_receive_bypass(struct hfi1_packet *packet)
 {
 	struct hfi1_devdata *dd = packet->rcd->dd;
 
 	if (hfi1_is_vnic_packet(packet)) {
 		hfi1_vnic_bypass_rcv(packet);
-		return RHF_RCV_CONTINUE;
+		return;
 	}
 
 	if (hfi1_setup_bypass_packet(packet))
-		return RHF_RCV_CONTINUE;
+		return;
 
 	trace_hfi1_rcvhdr(packet);
 
 	if (unlikely(rhf_err_flags(packet->rhf))) {
 		handle_eflags(packet);
-		return RHF_RCV_CONTINUE;
+		return;
 	}
 
 	if (hfi1_16B_get_l2(packet->hdr) == 0x2) {
@@ -1624,17 +1623,16 @@ static int process_receive_bypass(struct hfi1_packet *packet)
 				(OPA_EI_STATUS_SMASK | BAD_L2_ERR);
 		}
 	}
-	return RHF_RCV_CONTINUE;
 }
 
-static int process_receive_error(struct hfi1_packet *packet)
+static void process_receive_error(struct hfi1_packet *packet)
 {
 	/* KHdrHCRCErr -- KDETH packet with a bad HCRC */
 	if (unlikely(
 		 hfi1_dbg_fault_suppress_err(&packet->rcd->dd->verbs_dev) &&
 		 (rhf_rcv_type_err(packet->rhf) == RHF_RCV_TYPE_ERROR ||
 		  packet->rhf & RHF_DC_ERR)))
-		return RHF_RCV_CONTINUE;
+		return;
 
 	hfi1_setup_ib_header(packet);
 	handle_eflags(packet);
@@ -1642,32 +1640,29 @@ static int process_receive_error(struct hfi1_packet *packet)
 	if (unlikely(rhf_err_flags(packet->rhf)))
 		dd_dev_err(packet->rcd->dd,
 			   "Unhandled error packet received. Dropping.\n");
-
-	return RHF_RCV_CONTINUE;
 }
 
-static int kdeth_process_expected(struct hfi1_packet *packet)
+static void kdeth_process_expected(struct hfi1_packet *packet)
 {
 	hfi1_setup_9B_packet(packet);
 	if (unlikely(hfi1_dbg_should_fault_rx(packet)))
-		return RHF_RCV_CONTINUE;
+		return;
 
 	if (unlikely(rhf_err_flags(packet->rhf))) {
 		struct hfi1_ctxtdata *rcd = packet->rcd;
 
 		if (hfi1_handle_kdeth_eflags(rcd, rcd->ppd, packet))
-			return RHF_RCV_CONTINUE;
+			return;
 	}
 
 	hfi1_kdeth_expected_rcv(packet);
-	return RHF_RCV_CONTINUE;
 }
 
-static int kdeth_process_eager(struct hfi1_packet *packet)
+static void kdeth_process_eager(struct hfi1_packet *packet)
 {
 	hfi1_setup_9B_packet(packet);
 	if (unlikely(hfi1_dbg_should_fault_rx(packet)))
-		return RHF_RCV_CONTINUE;
+		return;
 
 	trace_hfi1_rcvhdr(packet);
 	if (unlikely(rhf_err_flags(packet->rhf))) {
@@ -1675,18 +1670,16 @@ static int kdeth_process_eager(struct hfi1_packet *packet)
 
 		show_eflags_errs(packet);
 		if (hfi1_handle_kdeth_eflags(rcd, rcd->ppd, packet))
-			return RHF_RCV_CONTINUE;
+			return;
 	}
 
 	hfi1_kdeth_eager_rcv(packet);
-	return RHF_RCV_CONTINUE;
 }
 
-static int process_receive_invalid(struct hfi1_packet *packet)
+static void process_receive_invalid(struct hfi1_packet *packet)
 {
 	dd_dev_err(packet->rcd->dd, "Invalid packet type %d. Dropping\n",
 		   rhf_rcv_type(packet->rhf));
-	return RHF_RCV_CONTINUE;
 }
 
 #define HFI1_RCVHDR_DUMP_MAX	5
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index 9212543..752dc08 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -199,7 +199,7 @@ struct exp_tid_set {
 
 struct hfi1_ctxtdata;
 typedef int (*intr_handler)(struct hfi1_ctxtdata *rcd, int data);
-typedef int (*rhf_rcv_function_ptr)(struct hfi1_packet *packet);
+typedef void (*rhf_rcv_function_ptr)(struct hfi1_packet *packet);
 
 struct tid_queue {
 	struct list_head queue_head;

