Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 005874640E
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 18:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfFNQ2c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 12:28:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:4123 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfFNQ2c (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jun 2019 12:28:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 09:28:31 -0700
X-ExtLoop1: 1
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jun 2019 09:28:31 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x5EGSU5J060702;
        Fri, 14 Jun 2019 09:28:30 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x5EGSSuF044864;
        Fri, 14 Jun 2019 12:28:29 -0400
Subject: [PATCH for-next 5/9] IB/hfi1: Reduce excessive aspm inlines
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Date:   Fri, 14 Jun 2019 12:28:28 -0400
Message-ID: <20190614162828.44714.72310.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190614162724.44714.22604.stgit@awfm-01.aw.intel.com>
References: <20190614162724.44714.22604.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Michael J. Ruhl <michael.j.ruhl@intel.com>

Uninline the aspm API since it increases code space for no
reason.

Move the aspm module param to the new aspm C file.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/Makefile |    1 
 drivers/infiniband/hw/hfi1/aspm.c   |  270 +++++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi1/aspm.h   |  262 +---------------------------------
 drivers/infiniband/hw/hfi1/pcie.c   |    6 -
 4 files changed, 280 insertions(+), 259 deletions(-)
 create mode 100644 drivers/infiniband/hw/hfi1/aspm.c

diff --git a/drivers/infiniband/hw/hfi1/Makefile b/drivers/infiniband/hw/hfi1/Makefile
index 4044a8c..0405d26 100644
--- a/drivers/infiniband/hw/hfi1/Makefile
+++ b/drivers/infiniband/hw/hfi1/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_INFINIBAND_HFI1) += hfi1.o
 
 hfi1-y := \
 	affinity.o \
+	aspm.o \
 	chip.o \
 	device.o \
 	driver.o \
diff --git a/drivers/infiniband/hw/hfi1/aspm.c b/drivers/infiniband/hw/hfi1/aspm.c
new file mode 100644
index 0000000..a3c53be4
--- /dev/null
+++ b/drivers/infiniband/hw/hfi1/aspm.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright(c) 2019 Intel Corporation.
+ *
+ */
+
+#include "aspm.h"
+
+/* Time after which the timer interrupt will re-enable ASPM */
+#define ASPM_TIMER_MS 1000
+/* Time for which interrupts are ignored after a timer has been scheduled */
+#define ASPM_RESCHED_TIMER_MS (ASPM_TIMER_MS / 2)
+/* Two interrupts within this time trigger ASPM disable */
+#define ASPM_TRIGGER_MS 1
+#define ASPM_TRIGGER_NS (ASPM_TRIGGER_MS * 1000 * 1000ull)
+#define ASPM_L1_SUPPORTED(reg) \
+	((((reg) & PCI_EXP_LNKCAP_ASPMS) >> 10) & 0x2)
+
+uint aspm_mode = ASPM_MODE_DISABLED;
+module_param_named(aspm, aspm_mode, uint, 0444);
+MODULE_PARM_DESC(aspm, "PCIe ASPM: 0: disable, 1: enable, 2: dynamic");
+
+static bool aspm_hw_l1_supported(struct hfi1_devdata *dd)
+{
+	struct pci_dev *parent = dd->pcidev->bus->self;
+	u32 up, dn;
+
+	/*
+	 * If the driver does not have access to the upstream component,
+	 * it cannot support ASPM L1 at all.
+	 */
+	if (!parent)
+		return false;
+
+	pcie_capability_read_dword(dd->pcidev, PCI_EXP_LNKCAP, &dn);
+	dn = ASPM_L1_SUPPORTED(dn);
+
+	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &up);
+	up = ASPM_L1_SUPPORTED(up);
+
+	/* ASPM works on A-step but is reported as not supported */
+	return (!!dn || is_ax(dd)) && !!up;
+}
+
+/* Set L1 entrance latency for slower entry to L1 */
+static void aspm_hw_set_l1_ent_latency(struct hfi1_devdata *dd)
+{
+	u32 l1_ent_lat = 0x4u;
+	u32 reg32;
+
+	pci_read_config_dword(dd->pcidev, PCIE_CFG_REG_PL3, &reg32);
+	reg32 &= ~PCIE_CFG_REG_PL3_L1_ENT_LATENCY_SMASK;
+	reg32 |= l1_ent_lat << PCIE_CFG_REG_PL3_L1_ENT_LATENCY_SHIFT;
+	pci_write_config_dword(dd->pcidev, PCIE_CFG_REG_PL3, reg32);
+}
+
+static void aspm_hw_enable_l1(struct hfi1_devdata *dd)
+{
+	struct pci_dev *parent = dd->pcidev->bus->self;
+
+	/*
+	 * If the driver does not have access to the upstream component,
+	 * it cannot support ASPM L1 at all.
+	 */
+	if (!parent)
+		return;
+
+	/* Enable ASPM L1 first in upstream component and then downstream */
+	pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC,
+					   PCI_EXP_LNKCTL_ASPM_L1);
+	pcie_capability_clear_and_set_word(dd->pcidev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC,
+					   PCI_EXP_LNKCTL_ASPM_L1);
+}
+
+void aspm_hw_disable_l1(struct hfi1_devdata *dd)
+{
+	struct pci_dev *parent = dd->pcidev->bus->self;
+
+	/* Disable ASPM L1 first in downstream component and then upstream */
+	pcie_capability_clear_and_set_word(dd->pcidev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC, 0x0);
+	if (parent)
+		pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_ASPMC, 0x0);
+}
+
+static  void aspm_enable(struct hfi1_devdata *dd)
+{
+	if (dd->aspm_enabled || aspm_mode == ASPM_MODE_DISABLED ||
+	    !dd->aspm_supported)
+		return;
+
+	aspm_hw_enable_l1(dd);
+	dd->aspm_enabled = true;
+}
+
+static  void aspm_disable(struct hfi1_devdata *dd)
+{
+	if (!dd->aspm_enabled || aspm_mode == ASPM_MODE_ENABLED)
+		return;
+
+	aspm_hw_disable_l1(dd);
+	dd->aspm_enabled = false;
+}
+
+static  void aspm_disable_inc(struct hfi1_devdata *dd)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dd->aspm_lock, flags);
+	aspm_disable(dd);
+	atomic_inc(&dd->aspm_disabled_cnt);
+	spin_unlock_irqrestore(&dd->aspm_lock, flags);
+}
+
+static  void aspm_enable_dec(struct hfi1_devdata *dd)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dd->aspm_lock, flags);
+	if (atomic_dec_and_test(&dd->aspm_disabled_cnt))
+		aspm_enable(dd);
+	spin_unlock_irqrestore(&dd->aspm_lock, flags);
+}
+
+/* ASPM processing for each receive context interrupt */
+void __aspm_ctx_disable(struct hfi1_ctxtdata *rcd)
+{
+	bool restart_timer;
+	bool close_interrupts;
+	unsigned long flags;
+	ktime_t now, prev;
+
+	spin_lock_irqsave(&rcd->aspm_lock, flags);
+	/* PSM contexts are open */
+	if (!rcd->aspm_intr_enable)
+		goto unlock;
+
+	prev = rcd->aspm_ts_last_intr;
+	now = ktime_get();
+	rcd->aspm_ts_last_intr = now;
+
+	/* An interrupt pair close together in time */
+	close_interrupts = ktime_to_ns(ktime_sub(now, prev)) < ASPM_TRIGGER_NS;
+
+	/* Don't push out our timer till this much time has elapsed */
+	restart_timer = ktime_to_ns(ktime_sub(now, rcd->aspm_ts_timer_sched)) >
+				    ASPM_RESCHED_TIMER_MS * NSEC_PER_MSEC;
+	restart_timer = restart_timer && close_interrupts;
+
+	/* Disable ASPM and schedule timer */
+	if (rcd->aspm_enabled && close_interrupts) {
+		aspm_disable_inc(rcd->dd);
+		rcd->aspm_enabled = false;
+		restart_timer = true;
+	}
+
+	if (restart_timer) {
+		mod_timer(&rcd->aspm_timer,
+			  jiffies + msecs_to_jiffies(ASPM_TIMER_MS));
+		rcd->aspm_ts_timer_sched = now;
+	}
+unlock:
+	spin_unlock_irqrestore(&rcd->aspm_lock, flags);
+}
+
+/* Timer function for re-enabling ASPM in the absence of interrupt activity */
+static  void aspm_ctx_timer_function(struct timer_list *t)
+{
+	struct hfi1_ctxtdata *rcd = from_timer(rcd, t, aspm_timer);
+	unsigned long flags;
+
+	spin_lock_irqsave(&rcd->aspm_lock, flags);
+	aspm_enable_dec(rcd->dd);
+	rcd->aspm_enabled = true;
+	spin_unlock_irqrestore(&rcd->aspm_lock, flags);
+}
+
+/*
+ * Disable interrupt processing for verbs contexts when PSM or VNIC contexts
+ * are open.
+ */
+void aspm_disable_all(struct hfi1_devdata *dd)
+{
+	struct hfi1_ctxtdata *rcd;
+	unsigned long flags;
+	u16 i;
+
+	for (i = 0; i < dd->first_dyn_alloc_ctxt; i++) {
+		rcd = hfi1_rcd_get_by_index(dd, i);
+		if (rcd) {
+			del_timer_sync(&rcd->aspm_timer);
+			spin_lock_irqsave(&rcd->aspm_lock, flags);
+			rcd->aspm_intr_enable = false;
+			spin_unlock_irqrestore(&rcd->aspm_lock, flags);
+			hfi1_rcd_put(rcd);
+		}
+	}
+
+	aspm_disable(dd);
+	atomic_set(&dd->aspm_disabled_cnt, 0);
+}
+
+/* Re-enable interrupt processing for verbs contexts */
+void aspm_enable_all(struct hfi1_devdata *dd)
+{
+	struct hfi1_ctxtdata *rcd;
+	unsigned long flags;
+	u16 i;
+
+	aspm_enable(dd);
+
+	if (aspm_mode != ASPM_MODE_DYNAMIC)
+		return;
+
+	for (i = 0; i < dd->first_dyn_alloc_ctxt; i++) {
+		rcd = hfi1_rcd_get_by_index(dd, i);
+		if (rcd) {
+			spin_lock_irqsave(&rcd->aspm_lock, flags);
+			rcd->aspm_intr_enable = true;
+			rcd->aspm_enabled = true;
+			spin_unlock_irqrestore(&rcd->aspm_lock, flags);
+			hfi1_rcd_put(rcd);
+		}
+	}
+}
+
+static  void aspm_ctx_init(struct hfi1_ctxtdata *rcd)
+{
+	spin_lock_init(&rcd->aspm_lock);
+	timer_setup(&rcd->aspm_timer, aspm_ctx_timer_function, 0);
+	rcd->aspm_intr_supported = rcd->dd->aspm_supported &&
+		aspm_mode == ASPM_MODE_DYNAMIC &&
+		rcd->ctxt < rcd->dd->first_dyn_alloc_ctxt;
+}
+
+void aspm_init(struct hfi1_devdata *dd)
+{
+	struct hfi1_ctxtdata *rcd;
+	u16 i;
+
+	spin_lock_init(&dd->aspm_lock);
+	dd->aspm_supported = aspm_hw_l1_supported(dd);
+
+	for (i = 0; i < dd->first_dyn_alloc_ctxt; i++) {
+		rcd = hfi1_rcd_get_by_index(dd, i);
+		if (rcd)
+			aspm_ctx_init(rcd);
+		hfi1_rcd_put(rcd);
+	}
+
+	/* Start with ASPM disabled */
+	aspm_hw_set_l1_ent_latency(dd);
+	dd->aspm_enabled = false;
+	aspm_hw_disable_l1(dd);
+
+	/* Now turn on ASPM if configured */
+	aspm_enable_all(dd);
+}
+
+void aspm_exit(struct hfi1_devdata *dd)
+{
+	aspm_disable_all(dd);
+
+	/* Turn on ASPM on exit to conserve power */
+	aspm_enable(dd);
+}
+
diff --git a/drivers/infiniband/hw/hfi1/aspm.h b/drivers/infiniband/hw/hfi1/aspm.h
index e813387..75d5d18 100644
--- a/drivers/infiniband/hw/hfi1/aspm.h
+++ b/drivers/infiniband/hw/hfi1/aspm.h
@@ -57,266 +57,20 @@ enum aspm_mode {
 	ASPM_MODE_DYNAMIC = 2,	/* ASPM enabled/disabled dynamically */
 };
 
-/* Time after which the timer interrupt will re-enable ASPM */
-#define ASPM_TIMER_MS 1000
-/* Time for which interrupts are ignored after a timer has been scheduled */
-#define ASPM_RESCHED_TIMER_MS (ASPM_TIMER_MS / 2)
-/* Two interrupts within this time trigger ASPM disable */
-#define ASPM_TRIGGER_MS 1
-#define ASPM_TRIGGER_NS (ASPM_TRIGGER_MS * 1000 * 1000ull)
-#define ASPM_L1_SUPPORTED(reg) \
-	(((reg & PCI_EXP_LNKCAP_ASPMS) >> 10) & 0x2)
+void aspm_init(struct hfi1_devdata *dd);
+void aspm_exit(struct hfi1_devdata *dd);
+void aspm_hw_disable_l1(struct hfi1_devdata *dd);
+void __aspm_ctx_disable(struct hfi1_ctxtdata *rcd);
+void aspm_disable_all(struct hfi1_devdata *dd);
+void aspm_enable_all(struct hfi1_devdata *dd);
 
-static inline bool aspm_hw_l1_supported(struct hfi1_devdata *dd)
-{
-	struct pci_dev *parent = dd->pcidev->bus->self;
-	u32 up, dn;
-
-	/*
-	 * If the driver does not have access to the upstream component,
-	 * it cannot support ASPM L1 at all.
-	 */
-	if (!parent)
-		return false;
-
-	pcie_capability_read_dword(dd->pcidev, PCI_EXP_LNKCAP, &dn);
-	dn = ASPM_L1_SUPPORTED(dn);
-
-	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &up);
-	up = ASPM_L1_SUPPORTED(up);
-
-	/* ASPM works on A-step but is reported as not supported */
-	return (!!dn || is_ax(dd)) && !!up;
-}
-
-/* Set L1 entrance latency for slower entry to L1 */
-static inline void aspm_hw_set_l1_ent_latency(struct hfi1_devdata *dd)
-{
-	u32 l1_ent_lat = 0x4u;
-	u32 reg32;
-
-	pci_read_config_dword(dd->pcidev, PCIE_CFG_REG_PL3, &reg32);
-	reg32 &= ~PCIE_CFG_REG_PL3_L1_ENT_LATENCY_SMASK;
-	reg32 |= l1_ent_lat << PCIE_CFG_REG_PL3_L1_ENT_LATENCY_SHIFT;
-	pci_write_config_dword(dd->pcidev, PCIE_CFG_REG_PL3, reg32);
-}
-
-static inline void aspm_hw_enable_l1(struct hfi1_devdata *dd)
-{
-	struct pci_dev *parent = dd->pcidev->bus->self;
-
-	/*
-	 * If the driver does not have access to the upstream component,
-	 * it cannot support ASPM L1 at all.
-	 */
-	if (!parent)
-		return;
-
-	/* Enable ASPM L1 first in upstream component and then downstream */
-	pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC,
-					   PCI_EXP_LNKCTL_ASPM_L1);
-	pcie_capability_clear_and_set_word(dd->pcidev, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC,
-					   PCI_EXP_LNKCTL_ASPM_L1);
-}
-
-static inline void aspm_hw_disable_l1(struct hfi1_devdata *dd)
-{
-	struct pci_dev *parent = dd->pcidev->bus->self;
-
-	/* Disable ASPM L1 first in downstream component and then upstream */
-	pcie_capability_clear_and_set_word(dd->pcidev, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC, 0x0);
-	if (parent)
-		pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
-						   PCI_EXP_LNKCTL_ASPMC, 0x0);
-}
-
-static inline void aspm_enable(struct hfi1_devdata *dd)
-{
-	if (dd->aspm_enabled || aspm_mode == ASPM_MODE_DISABLED ||
-	    !dd->aspm_supported)
-		return;
-
-	aspm_hw_enable_l1(dd);
-	dd->aspm_enabled = true;
-}
-
-static inline void aspm_disable(struct hfi1_devdata *dd)
-{
-	if (!dd->aspm_enabled || aspm_mode == ASPM_MODE_ENABLED)
-		return;
-
-	aspm_hw_disable_l1(dd);
-	dd->aspm_enabled = false;
-}
-
-static inline void aspm_disable_inc(struct hfi1_devdata *dd)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&dd->aspm_lock, flags);
-	aspm_disable(dd);
-	atomic_inc(&dd->aspm_disabled_cnt);
-	spin_unlock_irqrestore(&dd->aspm_lock, flags);
-}
-
-static inline void aspm_enable_dec(struct hfi1_devdata *dd)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&dd->aspm_lock, flags);
-	if (atomic_dec_and_test(&dd->aspm_disabled_cnt))
-		aspm_enable(dd);
-	spin_unlock_irqrestore(&dd->aspm_lock, flags);
-}
-
-/* ASPM processing for each receive context interrupt */
 static inline void aspm_ctx_disable(struct hfi1_ctxtdata *rcd)
 {
-	bool restart_timer;
-	bool close_interrupts;
-	unsigned long flags;
-	ktime_t now, prev;
-
 	/* Quickest exit for minimum impact */
-	if (!rcd->aspm_intr_supported)
-		return;
-
-	spin_lock_irqsave(&rcd->aspm_lock, flags);
-	/* PSM contexts are open */
-	if (!rcd->aspm_intr_enable)
-		goto unlock;
-
-	prev = rcd->aspm_ts_last_intr;
-	now = ktime_get();
-	rcd->aspm_ts_last_intr = now;
-
-	/* An interrupt pair close together in time */
-	close_interrupts = ktime_to_ns(ktime_sub(now, prev)) < ASPM_TRIGGER_NS;
-
-	/* Don't push out our timer till this much time has elapsed */
-	restart_timer = ktime_to_ns(ktime_sub(now, rcd->aspm_ts_timer_sched)) >
-				    ASPM_RESCHED_TIMER_MS * NSEC_PER_MSEC;
-	restart_timer = restart_timer && close_interrupts;
-
-	/* Disable ASPM and schedule timer */
-	if (rcd->aspm_enabled && close_interrupts) {
-		aspm_disable_inc(rcd->dd);
-		rcd->aspm_enabled = false;
-		restart_timer = true;
-	}
-
-	if (restart_timer) {
-		mod_timer(&rcd->aspm_timer,
-			  jiffies + msecs_to_jiffies(ASPM_TIMER_MS));
-		rcd->aspm_ts_timer_sched = now;
-	}
-unlock:
-	spin_unlock_irqrestore(&rcd->aspm_lock, flags);
-}
-
-/* Timer function for re-enabling ASPM in the absence of interrupt activity */
-static inline void aspm_ctx_timer_function(struct timer_list *t)
-{
-	struct hfi1_ctxtdata *rcd = from_timer(rcd, t, aspm_timer);
-	unsigned long flags;
-
-	spin_lock_irqsave(&rcd->aspm_lock, flags);
-	aspm_enable_dec(rcd->dd);
-	rcd->aspm_enabled = true;
-	spin_unlock_irqrestore(&rcd->aspm_lock, flags);
-}
-
-/*
- * Disable interrupt processing for verbs contexts when PSM or VNIC contexts
- * are open.
- */
-static inline void aspm_disable_all(struct hfi1_devdata *dd)
-{
-	struct hfi1_ctxtdata *rcd;
-	unsigned long flags;
-	u16 i;
-
-	for (i = 0; i < dd->first_dyn_alloc_ctxt; i++) {
-		rcd = hfi1_rcd_get_by_index(dd, i);
-		if (rcd) {
-			del_timer_sync(&rcd->aspm_timer);
-			spin_lock_irqsave(&rcd->aspm_lock, flags);
-			rcd->aspm_intr_enable = false;
-			spin_unlock_irqrestore(&rcd->aspm_lock, flags);
-			hfi1_rcd_put(rcd);
-		}
-	}
-
-	aspm_disable(dd);
-	atomic_set(&dd->aspm_disabled_cnt, 0);
-}
-
-/* Re-enable interrupt processing for verbs contexts */
-static inline void aspm_enable_all(struct hfi1_devdata *dd)
-{
-	struct hfi1_ctxtdata *rcd;
-	unsigned long flags;
-	u16 i;
-
-	aspm_enable(dd);
-
-	if (aspm_mode != ASPM_MODE_DYNAMIC)
+	if (likely(!rcd->aspm_intr_supported))
 		return;
 
-	for (i = 0; i < dd->first_dyn_alloc_ctxt; i++) {
-		rcd = hfi1_rcd_get_by_index(dd, i);
-		if (rcd) {
-			spin_lock_irqsave(&rcd->aspm_lock, flags);
-			rcd->aspm_intr_enable = true;
-			rcd->aspm_enabled = true;
-			spin_unlock_irqrestore(&rcd->aspm_lock, flags);
-			hfi1_rcd_put(rcd);
-		}
-	}
-}
-
-static inline void aspm_ctx_init(struct hfi1_ctxtdata *rcd)
-{
-	spin_lock_init(&rcd->aspm_lock);
-	timer_setup(&rcd->aspm_timer, aspm_ctx_timer_function, 0);
-	rcd->aspm_intr_supported = rcd->dd->aspm_supported &&
-		aspm_mode == ASPM_MODE_DYNAMIC &&
-		rcd->ctxt < rcd->dd->first_dyn_alloc_ctxt;
-}
-
-static inline void aspm_init(struct hfi1_devdata *dd)
-{
-	struct hfi1_ctxtdata *rcd;
-	u16 i;
-
-	spin_lock_init(&dd->aspm_lock);
-	dd->aspm_supported = aspm_hw_l1_supported(dd);
-
-	for (i = 0; i < dd->first_dyn_alloc_ctxt; i++) {
-		rcd = hfi1_rcd_get_by_index(dd, i);
-		if (rcd)
-			aspm_ctx_init(rcd);
-		hfi1_rcd_put(rcd);
-	}
-
-	/* Start with ASPM disabled */
-	aspm_hw_set_l1_ent_latency(dd);
-	dd->aspm_enabled = false;
-	aspm_hw_disable_l1(dd);
-
-	/* Now turn on ASPM if configured */
-	aspm_enable_all(dd);
-}
-
-static inline void aspm_exit(struct hfi1_devdata *dd)
-{
-	aspm_disable_all(dd);
-
-	/* Turn on ASPM on exit to conserve power */
-	aspm_enable(dd);
+	__aspm_ctx_disable(rcd);
 }
 
 #endif /* _ASPM_H */
diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index c96d193..61aa550 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -1,5 +1,5 @@
 /*
- * Copyright(c) 2015 - 2018 Intel Corporation.
+ * Copyright(c) 2015 - 2019 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -450,10 +450,6 @@ int save_pci_variables(struct hfi1_devdata *dd)
 module_param_named(pcie_caps, hfi1_pcie_caps, int, 0444);
 MODULE_PARM_DESC(pcie_caps, "Max PCIe tuning: Payload (0..3), ReadReq (4..7)");
 
-uint aspm_mode = ASPM_MODE_DISABLED;
-module_param_named(aspm, aspm_mode, uint, 0444);
-MODULE_PARM_DESC(aspm, "PCIe ASPM: 0: disable, 1: enable, 2: dynamic");
-
 /**
  * tune_pcie_caps() - Code to adjust PCIe capabilities.
  * @dd: Valid device data structure

