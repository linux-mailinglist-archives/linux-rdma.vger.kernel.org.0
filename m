Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445247A4D4E
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 17:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjIRPse (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 11:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjIRPsc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 11:48:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93351CFC;
        Mon, 18 Sep 2023 08:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695051983; x=1726587983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s0vQPYCvTArOJ8UKcbPeJ71cltUHLof64ZzmndGbOp4=;
  b=g2uLs8OADS77SXqB3EuVJrEreMnzHFPTafxvzmdEL/C30iUp3zH7jq1d
   ABZ3Kgh5gdJWDrpY5cUPNAW0MC6MwehHgL8SJnJWsyivkRwisemiLfzRD
   JkRNPbicHlrpKkMhHoxPsPyTChaGYZWWo9+635t/DgCn0pxxUem/ScJGT
   4SLlJpWs3qxKi0/KMeTdVUlZ787kIuyPnPSg8tREZhknRBZJx+ocIwy8D
   LwpMktM8zntgHLuDzWer72KmurJ5RX9+isF15HXWJoMsVjFIyeFEABBjp
   SRMTXuInJSNLU6fsVFUgEno8xmvLj+zQAa0qNs2pEZq25iAy6AzZxGniE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="446113610"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="446113610"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:13:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="811343017"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="811343017"
Received: from nprotaso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.49.156])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:13:39 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        intel-wired-lan@lists.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 11/13] wifi: ath12k: Use pci_disable/enable_link_state()
Date:   Mon, 18 Sep 2023 16:11:01 +0300
Message-Id: <20230918131103.24119-12-ilpo.jarvinen@linux.intel.com>
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

ath12k driver adjusts ASPM state itself which leaves ASPM service
driver in PCI core unaware of the link state changes the driver
implemented.

Call pci_disable_link_state() and pci_enable_link_state() instead of
adjusting ASPMC field in LNKCTL directly in the driver and let PCI core
handle the ASPM state management.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/wireless/ath/ath12k/pci.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index fae5dfd6e9d7..9401f62476be 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -794,19 +794,15 @@ static void ath12k_pci_aspm_disable(struct ath12k_pci *ab_pci)
 		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
 
 	/* disable L0s and L1 */
-	pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-				   PCI_EXP_LNKCTL_ASPMC);
-
+	pci_disable_link_state(ab_pci->pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
 	set_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags);
 }
 
 static void ath12k_pci_aspm_restore(struct ath12k_pci *ab_pci)
 {
 	if (test_and_clear_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags))
-		pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-						   PCI_EXP_LNKCTL_ASPMC,
-						   ab_pci->link_ctl &
-						   PCI_EXP_LNKCTL_ASPMC);
+		pci_enable_link_state(ab_pci->pdev, ab_pci->link_ctl &
+				      (PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1));
 }
 
 static void ath12k_pci_kill_tasklets(struct ath12k_base *ab)
-- 
2.30.2

