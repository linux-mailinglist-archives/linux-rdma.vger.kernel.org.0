Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916627A4D3D
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 17:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjIRPrf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 11:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjIRPre (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 11:47:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9264910F4;
        Mon, 18 Sep 2023 08:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695051884; x=1726587884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4NBLfl/BS/3VShevYHOCVVW7LFobwQI1zr9aS+V1OKk=;
  b=LC1Rve02aHbu+3hf+GBKvgh2ENjuWXK20L0MB2ePq1jAQJT2QELkdNTz
   19KtmZlDucq86OobQwsR8V7RsZapz8NFjLG1OHBWYfZ1izHeUS/GjRe8w
   MRY4WJ7Ye+EMsalUszYCAx48yQJZ+2Ljct4lM5mrRJFZS6XPwPBK4uuX3
   DOBWWaCQlfWkd3+DCCE6wWQLU57cWBEKZrtEELlfPqdoE9iZbKKApdv5I
   1mwqQk0PkTaAR4Zh8shfYbHZtc29q4nqOUMYwVjcpqr3eHY9w/PxXm+c4
   C3zVTHVr1Kz8ISW2kpBlFsbwVkrmDxp3rBu0Dfl1lOqs5YWPb77sJqfXZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="446112875"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="446112875"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:11:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="811341550"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="811341550"
Received: from nprotaso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.49.156])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:11:43 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, intel-wired-lan@lists.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 03/13] PCI/ASPM: Disable ASPM when driver requests it
Date:   Mon, 18 Sep 2023 16:10:53 +0300
Message-Id: <20230918131103.24119-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230918131103.24119-1-ilpo.jarvinen@linux.intel.com>
References: <20230918131103.24119-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PCI core/ASPM service driver allows controlling ASPM state through
pci_disable_link_state() and pci_enable_link_state() API. It was
decided earlier (see the Link below), to not allow ASPM changes when OS
does not have control over it but only log a warning about the problem
(commit 2add0ec14c25 ("PCI/ASPM: Warn when driver asks to disable ASPM,
but we can't do it")). Similarly, if ASPM is not enabled through
config, ASPM cannot be disabled.

A number of drivers have added workarounds to force ASPM off with own
writes into the Link Control Register (some even with comments
explaining why PCI core does not disable it under some circumstances).
According to the comments, some drivers require ASPM to be off for
reliable operation.

Having custom ASPM handling in drivers is problematic because the state
kept in the ASPM service driver is not updated by the changes made
outside the link state management API.

As the first step to address this issue, make pci_disable_link_state()
to unconditionally disable ASPM so the motivation for drivers to come
up with custom ASPM handling code is eliminated.

Place the minimal ASPM disable handling into own file as it is too
complicated to fit into a header as static inline and it has almost no
overlap with the existing, more complicated ASPM code in
drivers/pci/pce/aspm.c.

Make pci_disable_link_state() function comment to comply kerneldoc
formatting while changing the description.

Link: https://lore.kernel.org/all/CANUX_P3F5YhbZX3WGU-j1AGpbXb_T9Bis2ErhvKkFMtDvzatVQ@mail.gmail.com/
Link: https://lore.kernel.org/all/20230511131441.45704-1-ilpo.jarvinen@linux.intel.com/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/Makefile       |  1 +
 drivers/pci/pcie/aspm.c         | 33 ++++++++++-------
 drivers/pci/pcie/aspm_minimal.c | 66 +++++++++++++++++++++++++++++++++
 include/linux/pci.h             |  6 +--
 4 files changed, 88 insertions(+), 18 deletions(-)
 create mode 100644 drivers/pci/pcie/aspm_minimal.c

diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 8de4ed5f98f1..ec7f04037b01 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -6,6 +6,7 @@ pcieportdrv-y			:= portdrv.o rcec.o
 
 obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
 
+obj-y				+= aspm_minimal.o
 obj-$(CONFIG_PCIEASPM)		+= aspm.o
 obj-$(CONFIG_PCIEAER)		+= aer.o err.o
 obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 860bc94974ec..ec6d7a092ac1 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1042,16 +1042,23 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 		return -EINVAL;
 	/*
 	 * A driver requested that ASPM be disabled on this device, but
-	 * if we don't have permission to manage ASPM (e.g., on ACPI
+	 * if we might not have permission to manage ASPM (e.g., on ACPI
 	 * systems we have to observe the FADT ACPI_FADT_NO_ASPM bit and
-	 * the _OSC method), we can't honor that request.  Windows has
-	 * a similar mechanism using "PciASPMOptOut", which is also
-	 * ignored in this situation.
+	 * the _OSC method), previously we chose to not honor disable
+	 * request in that case. Windows has a similar mechanism using
+	 * "PciASPMOptOut", which is also ignored in this situation.
+	 *
+	 * Not honoring the requests to disable ASPM, however, led to
+	 * drivers forcing ASPM off on their own. As such changes of ASPM
+	 * state are not tracked by this service driver, the state kept here
+	 * became out of sync.
+	 *
+	 * Therefore, honor ASPM disable requests even when OS does not have
+	 * ASPM control. Plain disable for ASPM is assumed to be slightly
+	 * safer than fully managing it.
 	 */
-	if (aspm_disabled) {
-		pci_warn(pdev, "can't disable ASPM; OS doesn't have ASPM control\n");
-		return -EPERM;
-	}
+	if (aspm_disabled)
+		pci_warn(pdev, "OS doesn't have ASPM control, disabling ASPM anyway\n");
 
 	if (sem)
 		down_read(&pci_bus_sem);
@@ -1087,13 +1094,13 @@ int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
 EXPORT_SYMBOL(pci_disable_link_state_locked);
 
 /**
- * pci_disable_link_state - Disable device's link state, so the link will
- * never enter specific states.  Note that if the BIOS didn't grant ASPM
- * control to the OS, this does nothing because we can't touch the LNKCTL
- * register. Returns 0 or a negative errno.
- *
+ * pci_disable_link_state - Disable device's link state
  * @pdev: PCI device
  * @state: ASPM link state to disable
+ *
+ * Disable device's link state so the link will never enter specific states.
+ *
+ * Return: 0 or a negative errno
  */
 int pci_disable_link_state(struct pci_dev *pdev, int state)
 {
diff --git a/drivers/pci/pcie/aspm_minimal.c b/drivers/pci/pcie/aspm_minimal.c
new file mode 100644
index 000000000000..4e4f63e51b21
--- /dev/null
+++ b/drivers/pci/pcie/aspm_minimal.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Minimal PCIe ASPM handling when CONFIG_PCIEASPM is not set.
+ *
+ * Copyright (C) 2023 Intel Corporation.
+ */
+
+#include <linux/pci.h>
+
+#include "../pci.h"
+
+#ifndef CONFIG_PCIEASPM
+/*
+ * Always disable ASPM when requested, even when CONFIG_PCIEASPM is
+ * not build to avoid drivers adding code to do it on their own
+ * which caused issues when core does not know about the out-of-band
+ * ASPM state changes.
+ */
+int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
+{
+	struct pci_dev *parent = pdev->bus->self;
+	struct pci_bus *linkbus = pdev->bus;
+	struct pci_dev *child;
+	u16 aspm_enabled, linkctl;
+	int ret;
+
+	if (!parent)
+		return -ENODEV;
+
+	ret = pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &linkctl);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return pcibios_err_to_errno(ret);
+	aspm_enabled = linkctl & PCI_EXP_LNKCTL_ASPMC;
+
+	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &linkctl);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return pcibios_err_to_errno(ret);
+	aspm_enabled |= linkctl & PCI_EXP_LNKCTL_ASPMC;
+
+	/* If no states need to be disabled, don't touch LNKCTL */
+	if (state & aspm_enabled)
+		return 0;
+
+	ret = pcie_capability_clear_word(parent, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_ASPMC);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return pcibios_err_to_errno(ret);
+	list_for_each_entry(child, &linkbus->devices, bus_list)
+		pcie_capability_clear_word(child, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_ASPMC);
+
+	return 0;
+}
+EXPORT_SYMBOL(pci_disable_link_state_locked);
+
+int pci_disable_link_state(struct pci_dev *pdev, int state)
+{
+	int ret;
+
+	down_read(&pci_bus_sem);
+	ret = pci_disable_link_state_locked(pdev, state);
+	up_read(&pci_bus_sem);
+
+	return ret;
+}
+EXPORT_SYMBOL(pci_disable_link_state);
+
+#endif
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7df56988ff48..3c24ca164104 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1773,18 +1773,14 @@ extern bool pcie_ports_native;
 					 PCIE_LINK_STATE_L1_2 | PCIE_LINK_STATE_L1_1_PCIPM |\
 					 PCIE_LINK_STATE_L1_2_PCIPM)
 
-#ifdef CONFIG_PCIEASPM
 int pci_disable_link_state(struct pci_dev *pdev, int state);
 int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
+#ifdef CONFIG_PCIEASPM
 int pci_set_default_link_state(struct pci_dev *pdev, int state);
 void pcie_no_aspm(void);
 bool pcie_aspm_support_enabled(void);
 bool pcie_aspm_enabled(struct pci_dev *pdev);
 #else
-static inline int pci_disable_link_state(struct pci_dev *pdev, int state)
-{ return 0; }
-static inline int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
-{ return 0; }
 static inline int pci_set_default_link_state(struct pci_dev *pdev, int state)
 { return 0; }
 static inline void pcie_no_aspm(void) { }
-- 
2.30.2

