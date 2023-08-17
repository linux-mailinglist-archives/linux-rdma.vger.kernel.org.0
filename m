Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C172C77F63E
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Aug 2023 14:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350738AbjHQMSF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Aug 2023 08:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350787AbjHQMRx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Aug 2023 08:17:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850EB273F;
        Thu, 17 Aug 2023 05:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692274670; x=1723810670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vDsDIHqtLtfNmUG3Y8t5VDuHkp8RJgeZagGcp/a8iuA=;
  b=C5OjBwm48bQBMV7R1vPx7qIPRamtgbUmb2GiZFQOPp4nZlC8lLqosQCC
   4sHp7An6EFL3je9F6TV2zLX6hq9ocv+e88UdaDWYnbza6xiS1MYG0xRLq
   YD2f0j3YqP4zPXFKbwGtrckLkMzouhHymSTJG9QH2IsIj1XpJsFc1p2xk
   D1EXUNm38UbGEui6Oj50JDCRqY7xhWwhl5iL/x+vqkAE0yjUWtdVkdxtR
   CJV/ZAO9CqKXpt6ZCYGvBA8Gczp6+1t+xzE7F2OaK/6s2BkessXG9BTVM
   HytCe61AuzoUlEchmXQO1heGCMN9+oEXBDCpAV4f7yiUfCrInxQg4sjHD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436696716"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="436696716"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 05:17:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848872961"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="848872961"
Received: from lababeix-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.251.212.52])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 05:17:36 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 04/10] drm/IB/hfi1: Use RMW accessors for changing LNKCTL2
Date:   Thu, 17 Aug 2023 15:17:02 +0300
Message-Id: <20230817121708.53213-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230817121708.53213-1-ilpo.jarvinen@linux.intel.com>
References: <20230817121708.53213-1-ilpo.jarvinen@linux.intel.com>
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

Don't assume that only the driver would be accessing LNKCTL2. In the
case of upstream (parent), the driver does not even own the device it's
changing the registers for.

Use RMW capability accessors which do proper locking to avoid losing
concurrent updates to the register value. This change is also useful as
a cleanup.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/infiniband/hw/hfi1/pcie.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 08732e1ac966..60a177f52eb5 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -1212,14 +1212,11 @@ int do_pcie_gen3_transition(struct hfi1_devdata *dd)
 		    (u32)lnkctl2);
 	/* only write to parent if target is not as high as ours */
 	if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) < target_vector) {
-		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
-		lnkctl2 |= target_vector;
-		dd_dev_info(dd, "%s: ..new link control2: 0x%x\n", __func__,
-			    (u32)lnkctl2);
-		ret = pcie_capability_write_word(parent,
-						 PCI_EXP_LNKCTL2, lnkctl2);
+		ret = pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL2,
+							 PCI_EXP_LNKCTL2_TLS,
+							 target_vector);
 		if (ret) {
-			dd_dev_err(dd, "Unable to write to PCI config\n");
+			dd_dev_err(dd, "Unable to change PCI target speed\n");
 			return_error = 1;
 			goto done;
 		}
@@ -1228,22 +1225,11 @@ int do_pcie_gen3_transition(struct hfi1_devdata *dd)
 	}
 
 	dd_dev_info(dd, "%s: setting target link speed\n", __func__);
-	ret = pcie_capability_read_word(dd->pcidev, PCI_EXP_LNKCTL2, &lnkctl2);
+	ret = pcie_capability_clear_and_set_word(dd->pcidev, PCI_EXP_LNKCTL2,
+						 PCI_EXP_LNKCTL2_TLS,
+						 target_vector);
 	if (ret) {
-		dd_dev_err(dd, "Unable to read from PCI config\n");
-		return_error = 1;
-		goto done;
-	}
-
-	dd_dev_info(dd, "%s: ..old link control2: 0x%x\n", __func__,
-		    (u32)lnkctl2);
-	lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
-	lnkctl2 |= target_vector;
-	dd_dev_info(dd, "%s: ..new link control2: 0x%x\n", __func__,
-		    (u32)lnkctl2);
-	ret = pcie_capability_write_word(dd->pcidev, PCI_EXP_LNKCTL2, lnkctl2);
-	if (ret) {
-		dd_dev_err(dd, "Unable to write to PCI config\n");
+		dd_dev_err(dd, "Unable to change PCI target speed\n");
 		return_error = 1;
 		goto done;
 	}
-- 
2.30.2

