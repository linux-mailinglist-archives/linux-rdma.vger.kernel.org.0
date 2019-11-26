Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40103109FCD
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2019 15:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfKZOEE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Nov 2019 09:04:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:13390 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727719AbfKZOEE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 Nov 2019 09:04:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 06:04:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; 
   d="scan'208";a="217168268"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2019 06:04:01 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id xAQE41NO038544;
        Tue, 26 Nov 2019 07:04:01 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id xAQE403G057885;
        Tue, 26 Nov 2019 09:04:00 -0500
Subject: [PATCH for-next 08/11] IB/hfi1: Decouple IRQ name from type
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        Dennis Dalessandro <dennis.alessandro@intel.com>,
        linux-rdma@vger.kernel.org, Kaike Wan <kaike.wan@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>
Date:   Tue, 26 Nov 2019 09:04:00 -0500
Message-ID: <20191126140400.57492.53275.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20191126140020.57492.67772.stgit@awfm-01.aw.intel.com>
References: <20191126140020.57492.67772.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>

IRQ name was connected to IRQ type, this is not sufficient and it would
be better to use name as argument to msix_request_irq instead of
assigning it to variables when function is called.

Index argument was required to generate name and now it can be removed.

To generate name correctly helpers function were added and updated.

Reviewed-by: Dennis Dalessandro <dennis.alessandro@intel.com>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/msix.c |  106 ++++++++++++++++++++-----------------
 drivers/infiniband/hw/hfi1/msix.h |    1 
 2 files changed, 59 insertions(+), 48 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/msix.c b/drivers/infiniband/hw/hfi1/msix.c
index d920b16..4a620cf 100644
--- a/drivers/infiniband/hw/hfi1/msix.c
+++ b/drivers/infiniband/hw/hfi1/msix.c
@@ -115,13 +115,11 @@ int msix_initialize(struct hfi1_devdata *dd)
  */
 static int msix_request_irq(struct hfi1_devdata *dd, void *arg,
 			    irq_handler_t handler, irq_handler_t thread,
-			    u32 idx, enum irq_type type)
+			    enum irq_type type, const char *name)
 {
 	unsigned long nr;
 	int irq;
 	int ret;
-	const char *err_info;
-	char name[MAX_NAME_SIZE];
 	struct hfi1_msix_entry *me;
 
 	/* Allocate an MSIx vector */
@@ -135,43 +133,15 @@ static int msix_request_irq(struct hfi1_devdata *dd, void *arg,
 	if (nr == dd->msix_info.max_requested)
 		return -ENOSPC;
 
-	/* Specific verification and determine the name */
-	switch (type) {
-	case IRQ_GENERAL:
-		/* general interrupt must be MSIx vector 0 */
-		if (nr) {
-			spin_lock(&dd->msix_info.msix_lock);
-			__clear_bit(nr, dd->msix_info.in_use_msix);
-			spin_unlock(&dd->msix_info.msix_lock);
-			dd_dev_err(dd, "Invalid index %lu for GENERAL IRQ\n",
-				   nr);
-			return -EINVAL;
-		}
-		snprintf(name, sizeof(name), DRIVER_NAME "_%d", dd->unit);
-		err_info = "general";
-		break;
-	case IRQ_SDMA:
-		snprintf(name, sizeof(name), DRIVER_NAME "_%d sdma%d",
-			 dd->unit, idx);
-		err_info = "sdma";
-		break;
-	case IRQ_RCVCTXT:
-		snprintf(name, sizeof(name), DRIVER_NAME "_%d kctxt%d",
-			 dd->unit, idx);
-		err_info = "receive context";
-		break;
-	case IRQ_OTHER:
-	default:
+	if (type < IRQ_SDMA && type >= IRQ_OTHER)
 		return -EINVAL;
-	}
-	name[sizeof(name) - 1] = 0;
 
 	irq = pci_irq_vector(dd->pcidev, nr);
 	ret = pci_request_irq(dd->pcidev, nr, handler, thread, arg, name);
 	if (ret) {
 		dd_dev_err(dd,
-			   "%s: request for IRQ %d failed, MSIx %d, err %d\n",
-			   err_info, irq, idx, ret);
+			   "%s: request for IRQ %d failed, MSIx %lu, err %d\n",
+			   name, irq, nr, ret);
 		spin_lock(&dd->msix_info.msix_lock);
 		__clear_bit(nr, dd->msix_info.in_use_msix);
 		spin_unlock(&dd->msix_info.msix_lock);
@@ -195,17 +165,13 @@ static int msix_request_irq(struct hfi1_devdata *dd, void *arg,
 	return nr;
 }
 
-/**
- * msix_request_rcd_irq() - Helper function for RCVAVAIL IRQs
- * @rcd: valid rcd context
- *
- */
-int msix_request_rcd_irq(struct hfi1_ctxtdata *rcd)
+static int msix_request_rcd_irq_common(struct hfi1_ctxtdata *rcd,
+				       irq_handler_t handler,
+				       irq_handler_t thread,
+				       const char *name)
 {
-	int nr;
-
-	nr = msix_request_irq(rcd->dd, rcd, receive_context_interrupt,
-			      receive_context_thread, rcd->ctxt, IRQ_RCVCTXT);
+	int nr = msix_request_irq(rcd->dd, rcd, handler, thread,
+				  IRQ_RCVCTXT, name);
 	if (nr < 0)
 		return nr;
 
@@ -222,6 +188,22 @@ int msix_request_rcd_irq(struct hfi1_ctxtdata *rcd)
 }
 
 /**
+ * msix_request_rcd_irq() - Helper function for RCVAVAIL IRQs
+ * @rcd: valid rcd context
+ *
+ */
+int msix_request_rcd_irq(struct hfi1_ctxtdata *rcd)
+{
+	char name[MAX_NAME_SIZE];
+
+	snprintf(name, sizeof(name), DRIVER_NAME "_%d kctxt%d",
+		 rcd->dd->unit, rcd->ctxt);
+
+	return msix_request_rcd_irq_common(rcd, receive_context_interrupt,
+					   receive_context_thread, name);
+}
+
+/**
  * msix_request_smda_ira() - Helper for getting SDMA IRQ resources
  * @sde: valid sdma engine
  *
@@ -229,9 +211,12 @@ int msix_request_rcd_irq(struct hfi1_ctxtdata *rcd)
 int msix_request_sdma_irq(struct sdma_engine *sde)
 {
 	int nr;
+	char name[MAX_NAME_SIZE];
 
+	snprintf(name, sizeof(name), DRIVER_NAME "_%d sdma%d",
+		 sde->dd->unit, sde->this_idx);
 	nr = msix_request_irq(sde->dd, sde, sdma_interrupt, NULL,
-			      sde->this_idx, IRQ_SDMA);
+			      IRQ_SDMA, name);
 	if (nr < 0)
 		return nr;
 	sde->msix_intr = nr;
@@ -241,6 +226,32 @@ int msix_request_sdma_irq(struct sdma_engine *sde)
 }
 
 /**
+ * msix_request_general_irq(void) - Helper for getting general IRQ
+ * resources
+ * @dd: valid device data
+ */
+int msix_request_general_irq(struct hfi1_devdata *dd)
+{
+	int nr;
+	char name[MAX_NAME_SIZE];
+
+	snprintf(name, sizeof(name), DRIVER_NAME "_%d", dd->unit);
+	nr = msix_request_irq(dd, dd, general_interrupt, NULL, IRQ_GENERAL,
+			      name);
+	if (nr < 0)
+		return nr;
+
+	/* general interrupt must be MSIx vector 0 */
+	if (nr) {
+		msix_free_irq(dd, (u8)nr);
+		dd_dev_err(dd, "Invalid index %d for GENERAL IRQ\n", nr);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
  * enable_sdma_src() - Helper to enable SDMA IRQ srcs
  * @dd: valid devdata structure
  * @i: index of SDMA engine
@@ -265,10 +276,9 @@ static void enable_sdma_srcs(struct hfi1_devdata *dd, int i)
 int msix_request_irqs(struct hfi1_devdata *dd)
 {
 	int i;
-	int ret;
+	int ret = msix_request_general_irq(dd);
 
-	ret = msix_request_irq(dd, dd, general_interrupt, NULL, 0, IRQ_GENERAL);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	for (i = 0; i < dd->num_sdma; i++) {
diff --git a/drivers/infiniband/hw/hfi1/msix.h b/drivers/infiniband/hw/hfi1/msix.h
index a514881..1a02ab7 100644
--- a/drivers/infiniband/hw/hfi1/msix.h
+++ b/drivers/infiniband/hw/hfi1/msix.h
@@ -54,6 +54,7 @@
 int msix_initialize(struct hfi1_devdata *dd);
 int msix_request_irqs(struct hfi1_devdata *dd);
 void msix_clean_up_interrupts(struct hfi1_devdata *dd);
+int msix_request_general_irq(struct hfi1_devdata *dd);
 int msix_request_rcd_irq(struct hfi1_ctxtdata *rcd);
 int msix_request_sdma_irq(struct sdma_engine *sde);
 void msix_free_irq(struct hfi1_devdata *dd, u8 msix_intr);

