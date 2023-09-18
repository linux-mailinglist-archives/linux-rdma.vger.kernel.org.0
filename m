Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F607A4D42
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 17:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjIRPrn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 11:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjIRPrl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 11:47:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8581419A7;
        Mon, 18 Sep 2023 08:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695051886; x=1726587886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ymkN+p4ogpYhyDF99HjDp+8yFzsuK5k5J5zb7K9eDd0=;
  b=WyHkEmtrm5ATwt3VZF3xouUzV+1P0o1Dqg2HoOZ+BKYydtWtnXwtcaOP
   Xvpc94Gi/UaJdDQWqq+wUVoqq9d2JlN5k69AcrbEOJlT9rILhbVY3eaH9
   /OhdDztnpucygMldh3EdBIYDX6kDyeoUDhF5Lr6URItuwzzMVqHPnkN6Q
   iBpXnvYJ55wdFfTniVQ/jwz1JvgOmhJVG5dDe2q/tEnAGDRHimNpGYaeC
   ruj5nZ55AfqTXfyetcpA3HD1yNJ5kDYm4Jt4blwHa2gt1S02jFE10+pPZ
   O9dRIWtX3p15gHgqKBk7IicaMXHM1uhTucg88Ix/woQVRpigZaoDz+6lN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="446113130"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="446113130"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:12:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="811341856"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="811341856"
Received: from nprotaso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.49.156])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:12:02 -0700
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
Subject: [PATCH v2 04/13] PCI/ASPM: Move L0S/L1/sub states mask calculation into a helper
Date:   Mon, 18 Sep 2023 16:10:54 +0300
Message-Id: <20230918131103.24119-5-ilpo.jarvinen@linux.intel.com>
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

ASPM service driver does the same L0S / L1S / sub states allowed
calculation in __pci_disable_link_state() and
pci_set_default_link_state().

Create a helper to calculate the mask for the allowed states.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/aspm.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index ec6d7a092ac1..91dc95aca90f 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1034,6 +1034,26 @@ static struct pcie_link_state *pcie_aspm_get_link(struct pci_dev *pdev)
 	return bridge->link_state;
 }
 
+static u8 pci_link_state_mask(int state)
+{
+	u8 result = 0;
+
+	if (state & PCIE_LINK_STATE_L0S)
+		result |= ASPM_STATE_L0S;
+	if (state & PCIE_LINK_STATE_L1)
+		result |= ASPM_STATE_L1;
+	if (state & PCIE_LINK_STATE_L1_1)
+		result |= ASPM_STATE_L1_1;
+	if (state & PCIE_LINK_STATE_L1_2)
+		result |= ASPM_STATE_L1_2;
+	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
+		result |= ASPM_STATE_L1_1_PCIPM;
+	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
+		result |= ASPM_STATE_L1_2_PCIPM;
+
+	return result;
+}
+
 static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 {
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
@@ -1063,18 +1083,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 	if (sem)
 		down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
-	if (state & PCIE_LINK_STATE_L0S)
-		link->aspm_disable |= ASPM_STATE_L0S;
-	if (state & PCIE_LINK_STATE_L1)
-		link->aspm_disable |= ASPM_STATE_L1;
-	if (state & PCIE_LINK_STATE_L1_1)
-		link->aspm_disable |= ASPM_STATE_L1_1;
-	if (state & PCIE_LINK_STATE_L1_2)
-		link->aspm_disable |= ASPM_STATE_L1_2;
-	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
-		link->aspm_disable |= ASPM_STATE_L1_1_PCIPM;
-	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
-		link->aspm_disable |= ASPM_STATE_L1_2_PCIPM;
+	link->aspm_disable |= pci_link_state_mask(state);
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
 	if (state & PCIE_LINK_STATE_CLKPM)
-- 
2.30.2

