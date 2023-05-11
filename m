Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FA56FF260
	for <lists+linux-rdma@lfdr.de>; Thu, 11 May 2023 15:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbjEKNQ0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 May 2023 09:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238068AbjEKNPu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 May 2023 09:15:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B70DD88;
        Thu, 11 May 2023 06:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683810916; x=1715346916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jtsJhk981/YB6xXduLi5eO9mCj6c1o6wGiSwZ35uutw=;
  b=CXASp47IaIqvG2kLnB9KTA6ERZskvH4QvPyUbkQ95xqY7h65UFtFkW4D
   zuMz5OCAmoq+r0NJq5NgdyKE9F7lCph1CO5+aFxBoSNPwbF9RNqCJ2dha
   iCvUcm7K7LEWnk6a+hYNbR5FMmW9qluq3H7fNhXmo0+/7RVtOUvgBXFr/
   2d+4FvsK8fXQ29Qi6fOfBtmI4yQaACkGdA29qofBJxwfoUMxiL3fWYZ9w
   xCAbjY79bLdSxoS0MjnPGGLZs4trNdptUgZ/wjbd2qVoiDog2NNKYHp0E
   qftfe6GlzlDxCcCNyWoIht9mRwiaukW+LPK7LrtBFASSQl0UOKY/efAg/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="378619428"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="378619428"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 06:15:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="650169666"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="650169666"
Received: from jsanche3-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.39.112])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 06:15:11 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 06/17] IB/hfi1: Use pcie_lnkctl{,2}_clear_and_set() for changing LNKCTL{,2}
Date:   Thu, 11 May 2023 16:14:30 +0300
Message-Id: <20230511131441.45704-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230511131441.45704-1-ilpo.jarvinen@linux.intel.com>
References: <20230511131441.45704-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Don't assume that only the driver would be accessing LNKCTL/LNKCTL2.
ASPM policy changes can trigger write to LNKCTL outside of driver's
control. And in the case of upstream (parent), the driver does not even
own the device it's changing the registers for.

Use pcie_lnkctl_clear_and_set() and pcie_lnkctl2_clear_and_set() which
do proper locking to avoid losing concurrent updates to the register
value.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/infiniband/hw/hfi1/aspm.c | 16 ++++++----------
 drivers/infiniband/hw/hfi1/pcie.c | 28 ++++++----------------------
 2 files changed, 12 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/aspm.c b/drivers/infiniband/hw/hfi1/aspm.c
index a3c53be4072c..d3f3b7e9b833 100644
--- a/drivers/infiniband/hw/hfi1/aspm.c
+++ b/drivers/infiniband/hw/hfi1/aspm.c
@@ -66,12 +66,10 @@ static void aspm_hw_enable_l1(struct hfi1_devdata *dd)
 		return;
 
 	/* Enable ASPM L1 first in upstream component and then downstream */
-	pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC,
-					   PCI_EXP_LNKCTL_ASPM_L1);
-	pcie_capability_clear_and_set_word(dd->pcidev, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC,
-					   PCI_EXP_LNKCTL_ASPM_L1);
+	pcie_lnkctl_clear_and_set(parent, PCI_EXP_LNKCTL_ASPMC,
+				  PCI_EXP_LNKCTL_ASPM_L1);
+	pcie_lnkctl_clear_and_set(dd->pcidev, PCI_EXP_LNKCTL_ASPMC,
+				  PCI_EXP_LNKCTL_ASPM_L1);
 }
 
 void aspm_hw_disable_l1(struct hfi1_devdata *dd)
@@ -79,11 +77,9 @@ void aspm_hw_disable_l1(struct hfi1_devdata *dd)
 	struct pci_dev *parent = dd->pcidev->bus->self;
 
 	/* Disable ASPM L1 first in downstream component and then upstream */
-	pcie_capability_clear_and_set_word(dd->pcidev, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC, 0x0);
+	pcie_lnkctl_clear_and_set(dd->pcidev, PCI_EXP_LNKCTL_ASPMC, 0);
 	if (parent)
-		pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
-						   PCI_EXP_LNKCTL_ASPMC, 0x0);
+		pcie_lnkctl_clear_and_set(parent, PCI_EXP_LNKCTL_ASPMC, 0);
 }
 
 static  void aspm_enable(struct hfi1_devdata *dd)
diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 08732e1ac966..fe7324d38d64 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -1212,14 +1212,10 @@ int do_pcie_gen3_transition(struct hfi1_devdata *dd)
 		    (u32)lnkctl2);
 	/* only write to parent if target is not as high as ours */
 	if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) < target_vector) {
-		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
-		lnkctl2 |= target_vector;
-		dd_dev_info(dd, "%s: ..new link control2: 0x%x\n", __func__,
-			    (u32)lnkctl2);
-		ret = pcie_capability_write_word(parent,
-						 PCI_EXP_LNKCTL2, lnkctl2);
+		pcie_lnkctl2_clear_and_set(parent, PCI_EXP_LNKCTL2_TLS,
+					   target_vector);
 		if (ret) {
-			dd_dev_err(dd, "Unable to write to PCI config\n");
+			dd_dev_err(dd, "Unable to change PCI target speed\n");
 			return_error = 1;
 			goto done;
 		}
@@ -1228,22 +1224,10 @@ int do_pcie_gen3_transition(struct hfi1_devdata *dd)
 	}
 
 	dd_dev_info(dd, "%s: setting target link speed\n", __func__);
-	ret = pcie_capability_read_word(dd->pcidev, PCI_EXP_LNKCTL2, &lnkctl2);
+	ret = pcie_lnkctl2_clear_and_set(dd->pcidev, PCI_EXP_LNKCTL2_TLS,
+					 target_vector);
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
+		dd_dev_err(dd, "Unable to change PCI link control2\n");
 		return_error = 1;
 		goto done;
 	}
-- 
2.30.2

