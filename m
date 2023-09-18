Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2B57A4EFD
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 18:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjIRQce (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 12:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjIRQcY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 12:32:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1236EF9;
        Mon, 18 Sep 2023 09:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695053862; x=1726589862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/jlflr+zDO/ybJEIj9ZeNbSBAg1LjrmA0JjnTT6qqL0=;
  b=NPsXbfSc9IPT94hOIIrNw/67t2VR+JhPjuDVykOsCKaDlVXy2p+FMbTA
   GTb86C7h+BuEfgDYFoHleY31PYmFwn/JH8Z1iIw50IMRKQR1XxT7Sglow
   iO58ySRv3gMvX59UGQVNeZ+Lrwfv1wAJgTIAyuMJHMlJ+kDDHAXYTmBBR
   NLJh7geSMk+NKR69+b8rXsbggqJvVRD9Q4Wt3JQ0PtG6rj1NjBzMomEcZ
   xc3dogm5JFgKGATaztjOSUtj9IudJWsZFo5qGdP2p6+6QXGWpWWgYtBvc
   eBeG7AIRRca48GUX44UpUlqM7o9nm231xa//lVetXTgoWmsg+n4N4/B/F
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="446113641"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="446113641"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:14:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="811343218"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="811343218"
Received: from nprotaso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.49.156])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:13:54 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, intel-wired-lan@lists.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 13/13] misc: rtsx: Use pci_disable/enable_link_state()
Date:   Mon, 18 Sep 2023 16:11:03 +0300
Message-Id: <20230918131103.24119-14-ilpo.jarvinen@linux.intel.com>
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

rtsx driver adjusts ASPM state itself which leaves ASPM service
driver in PCI core unaware of the link state changes the driver
implemented.

Call pci_disable_link_state() and pci_enable_link_state() instead of
adjusting ASPMC field in LNKCTL directly in the driver and let PCI core
handle the ASPM state management.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/misc/cardreader/rts5228.c  | 6 ++----
 drivers/misc/cardreader/rts5261.c  | 6 ++----
 drivers/misc/cardreader/rtsx_pcr.c | 8 +++++---
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/cardreader/rts5228.c b/drivers/misc/cardreader/rts5228.c
index f4ab09439da7..8d3216c64ad1 100644
--- a/drivers/misc/cardreader/rts5228.c
+++ b/drivers/misc/cardreader/rts5228.c
@@ -497,8 +497,7 @@ static void rts5228_enable_aspm(struct rtsx_pcr *pcr, bool enable)
 	val = FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1;
 	val |= (pcr->aspm_en & 0x02);
 	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
-	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC, pcr->aspm_en);
+	pci_enable_link_state(pcr->pci, pcr->aspm_en);
 	pcr->aspm_enabled = enable;
 }
 
@@ -509,8 +508,7 @@ static void rts5228_disable_aspm(struct rtsx_pcr *pcr, bool enable)
 	if (pcr->aspm_enabled == enable)
 		return;
 
-	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC, 0);
+	pci_disable_link_state(pcr->pci, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
 	mask = FORCE_ASPM_VAL_MASK | FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1;
 	val = FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1;
 	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 94af6bf8a25a..f1ef15683a2f 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -578,8 +578,7 @@ static void rts5261_enable_aspm(struct rtsx_pcr *pcr, bool enable)
 
 	val |= (pcr->aspm_en & 0x02);
 	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
-	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC, pcr->aspm_en);
+	pci_enable_link_state(pcr->pci, pcr->aspm_en);
 	pcr->aspm_enabled = enable;
 }
 
@@ -591,8 +590,7 @@ static void rts5261_disable_aspm(struct rtsx_pcr *pcr, bool enable)
 	if (pcr->aspm_enabled == enable)
 		return;
 
-	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC, 0);
+	pci_disable_link_state(pcr->pci, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
 	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
 	rtsx_pci_write_register(pcr, SD_CFG1, SD_ASYNC_FIFO_NOT_RST, 0);
 	udelay(10);
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index a3f4b52bb159..6efb792152f2 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -86,9 +86,11 @@ static void rtsx_comm_set_aspm(struct rtsx_pcr *pcr, bool enable)
 		return;
 
 	if (pcr->aspm_mode == ASPM_MODE_CFG) {
-		pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
-						PCI_EXP_LNKCTL_ASPMC,
-						enable ? pcr->aspm_en : 0);
+		if (enable)
+			pci_enable_link_state(pcr->pci, pcr->aspm_en);
+		else
+			pci_disable_link_state(pcr->pci, PCIE_LINK_STATE_L0S |
+							 PCIE_LINK_STATE_L1);
 	} else if (pcr->aspm_mode == ASPM_MODE_REG) {
 		if (pcr->aspm_en & 0x02)
 			rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, FORCE_ASPM_CTL0 |
-- 
2.30.2

