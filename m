Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADD77200DA
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jun 2023 13:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbjFBLuk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Jun 2023 07:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbjFBLu1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Jun 2023 07:50:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A46AE5E;
        Fri,  2 Jun 2023 04:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685706597; x=1717242597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dtcnuM+2TdnbsCijUckC327W0mtKyRtASd4omSZHYjg=;
  b=dhOY6WwD9tFuCuNpuke6q6ieXvkiWB1ka421N2iGJyH3t11c/dO3Ave3
   uyUjL8e54Ujg+zQDU3jo1J4Q+IfkMn0axTp/MwrpP4+M8IZL24fARlFCm
   xNY0pBSFachRkmOSfzExXpZdwCroT+BmNhYuymJziAOrtOLLVj+72wJG5
   HWVL5IALGh1McnNLAPzt7W27CmP2lyTl2xSdTc/en9YIAFh08RJdKEi6z
   /JCRZV7LK92B/atT0xoeTI6QCjcWb4pFsRl6xub+Tkfwel/h8lOq7vW6H
   ye6Es4NDwLnKTFqBxSP1Bo3V0sYYtYNWL2sWcwP0m6I2QiNMj40e/jRI5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="358279796"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="358279796"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 04:49:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="707819552"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="707819552"
Received: from rspatil-mobl3.gar.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.208.112])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 04:49:11 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [RFC PATCH v1 12/13] IB/hfi1: Use pci_disable/enable_link_state()
Date:   Fri,  2 Jun 2023 14:47:49 +0300
Message-Id: <20230602114751.19671-13-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602114751.19671-1-ilpo.jarvinen@linux.intel.com>
References: <20230602114751.19671-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

IB/hfi1 driver adjusts ASPM state itself which leaves ASPM service
driver in PCI core unaware of the link state changes the driver
implemented.

Call pci_disable_link_state() and pci_enable_link_state() instead of
adjusting ASPMC field in LNKCTL directly in the driver and let PCI core
handle the ASPM state management. Remove the functions that handled the
ASPM changes that are now unnecessary.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/infiniband/hw/hfi1/aspm.c | 38 +++----------------------------
 drivers/infiniband/hw/hfi1/pcie.c |  2 +-
 2 files changed, 4 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/aspm.c b/drivers/infiniband/hw/hfi1/aspm.c
index a3c53be4072c..8e3fc1d4c9c6 100644
--- a/drivers/infiniband/hw/hfi1/aspm.c
+++ b/drivers/infiniband/hw/hfi1/aspm.c
@@ -54,45 +54,13 @@ static void aspm_hw_set_l1_ent_latency(struct hfi1_devdata *dd)
 	pci_write_config_dword(dd->pcidev, PCIE_CFG_REG_PL3, reg32);
 }
 
-static void aspm_hw_enable_l1(struct hfi1_devdata *dd)
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
-void aspm_hw_disable_l1(struct hfi1_devdata *dd)
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
 static  void aspm_enable(struct hfi1_devdata *dd)
 {
 	if (dd->aspm_enabled || aspm_mode == ASPM_MODE_DISABLED ||
 	    !dd->aspm_supported)
 		return;
 
-	aspm_hw_enable_l1(dd);
+	pci_enable_link_state(dd->pcidev, PCI_EXP_LNKCTL_ASPM_L1);
 	dd->aspm_enabled = true;
 }
 
@@ -101,7 +69,7 @@ static  void aspm_disable(struct hfi1_devdata *dd)
 	if (!dd->aspm_enabled || aspm_mode == ASPM_MODE_ENABLED)
 		return;
 
-	aspm_hw_disable_l1(dd);
+	pci_disable_link_state(dd->pcidev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
 	dd->aspm_enabled = false;
 }
 
@@ -254,7 +222,7 @@ void aspm_init(struct hfi1_devdata *dd)
 	/* Start with ASPM disabled */
 	aspm_hw_set_l1_ent_latency(dd);
 	dd->aspm_enabled = false;
-	aspm_hw_disable_l1(dd);
+	pci_disable_link_state(dd->pcidev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
 
 	/* Now turn on ASPM if configured */
 	aspm_enable_all(dd);
diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 08732e1ac966..767f6cb770b6 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -1182,7 +1182,7 @@ int do_pcie_gen3_transition(struct hfi1_devdata *dd)
 	 * will be enabled if required later
 	 */
 	dd_dev_info(dd, "%s: clearing ASPM\n", __func__);
-	aspm_hw_disable_l1(dd);
+	pci_disable_link_state(dd->pcidev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
 
 	/*
 	 * step 5f: clear DirectSpeedChange
-- 
2.30.2

