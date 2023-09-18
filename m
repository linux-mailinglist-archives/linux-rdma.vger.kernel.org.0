Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407097A4D2E
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 17:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjIRPrN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 11:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjIRPrL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 11:47:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E5E121;
        Mon, 18 Sep 2023 08:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695051873; x=1726587873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4RLnw7kq3hIGZLooWQrGpuOQSJqB/nglTVJsokARwac=;
  b=BiWQTkL2r5gcaOLpyGOle3AHlJbaiX8n15uOmFR6rgG6EuNjG1iSBNNf
   BYwweDF8M1m9tDk0I9htAdK//6v82UhVRHHj1o+g7kl37wJmCOP6yJyWG
   2XgPzKx2620pR8vWx7XEbIVTHzBc6ftDn/FipSxZE//lFS4HH8lB0wxdg
   D7Z5d8Syxj7Mrl6ZjS19QGO1cEUhbVrfmM2BsbaaacdI05KrRrMCEEnsK
   8ry5FL0UcrnM0DCvtk4uKBawt5t5iIMI5Hh89F1ICblxt0xau6qBCNahe
   8Zqkfw8sBjA3fQWZyyyg6AOC6ImMuCC77b5unx05UrVSm5XHQdHsAZoBU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="446112692"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="446112692"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:11:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="811341426"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="811341426"
Received: from nprotaso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.49.156])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:11:30 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-kernel@vger.kernel.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, intel-wired-lan@lists.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 01/13] PCI/ASPM: Rename pci_enable_link_state() to pci_set_default_link_state()
Date:   Mon, 18 Sep 2023 16:10:51 +0300
Message-Id: <20230918131103.24119-2-ilpo.jarvinen@linux.intel.com>
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

pci_enable_link_state() and pci_disable_link_state() are not paired
symmetrically despite their names suggesting otherwise.
pci_enable_link_state() tweaks link state when the "default" policy is
in use rather than exactly "enabling" some link states. Obviously, when
the default policy is in use and the default link state is changed,
some link states may get enabled but that is a secondary effect.

Thus, rename pci_enable_link_state() to pci_set_default_link_state() to
better match what it does. The rename also frees
pci_enable_link_state() name so that a function that pairs
symmetrically with pci_disable_link_state() can be added later.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 2 +-
 drivers/pci/pcie/aspm.c      | 8 ++++----
 include/linux/pci.h          | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index ad56df98b8e6..e424ce897d23 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -752,7 +752,7 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
 		return 0;
 
-	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
+	pci_set_default_link_state(pdev, PCIE_LINK_STATE_ALL);
 
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
 	if (!pos)
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 1bf630059264..fc909e20365f 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1102,8 +1102,8 @@ int pci_disable_link_state(struct pci_dev *pdev, int state)
 EXPORT_SYMBOL(pci_disable_link_state);
 
 /**
- * pci_enable_link_state - Clear and set the default device link state so that
- * the link may be allowed to enter the specified states. Note that if the
+ * pci_set_default_link_state - Clear and set the default device link state so
+ * that the link may be allowed to enter the specified states. Note that if the
  * BIOS didn't grant ASPM control to the OS, this does nothing because we can't
  * touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
@@ -1111,7 +1111,7 @@ EXPORT_SYMBOL(pci_disable_link_state);
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
  */
-int pci_enable_link_state(struct pci_dev *pdev, int state)
+int pci_set_default_link_state(struct pci_dev *pdev, int state)
 {
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 
@@ -1153,7 +1153,7 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
 
 	return 0;
 }
-EXPORT_SYMBOL(pci_enable_link_state);
+EXPORT_SYMBOL(pci_set_default_link_state);
 
 static int pcie_aspm_set_policy(const char *val,
 				const struct kernel_param *kp)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8c7c2c3c6c65..7df56988ff48 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1776,7 +1776,7 @@ extern bool pcie_ports_native;
 #ifdef CONFIG_PCIEASPM
 int pci_disable_link_state(struct pci_dev *pdev, int state);
 int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
-int pci_enable_link_state(struct pci_dev *pdev, int state);
+int pci_set_default_link_state(struct pci_dev *pdev, int state);
 void pcie_no_aspm(void);
 bool pcie_aspm_support_enabled(void);
 bool pcie_aspm_enabled(struct pci_dev *pdev);
@@ -1785,7 +1785,7 @@ static inline int pci_disable_link_state(struct pci_dev *pdev, int state)
 { return 0; }
 static inline int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
 { return 0; }
-static inline int pci_enable_link_state(struct pci_dev *pdev, int state)
+static inline int pci_set_default_link_state(struct pci_dev *pdev, int state)
 { return 0; }
 static inline void pcie_no_aspm(void) { }
 static inline bool pcie_aspm_support_enabled(void) { return false; }
-- 
2.30.2

