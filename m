Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AD81ECEEE
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2020 13:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgFCLsZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jun 2020 07:48:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:60814 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgFCLsY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 3 Jun 2020 07:48:24 -0400
IronPort-SDR: MPFyheC/1UhhEtAUid5w3x2OQUY4lZiupPVAL0JUo9EEBKYon6DRzzFNtrdyE/3B2O6ABTNHgh
 cvsbalSIkSBg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 04:48:24 -0700
IronPort-SDR: zUZHYsd0TDlM9cjrE/FJRPZRRO6pKkaLB9JY2BX8SQQR/Cs5KfnFghUZP+qXjqZUGRtKTtvHYf
 zHqlyGvDBLeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="269051814"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by orsmga003.jf.intel.com with ESMTP; 03 Jun 2020 04:48:21 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/15] IB/qib: Use PCI_IRQ_MSI_TYPES where appropriate
Date:   Wed,  3 Jun 2020 13:48:17 +0200
Message-Id: <20200603114819.13377-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200603114212.12525-1-piotr.stankiewicz@intel.com>
References: <20200603114212.12525-1-piotr.stankiewicz@intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Seeing as there is shorthand available to use when asking for any type
of interrupt, or any type of message signalled interrupt, leverage it.

Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/infiniband/hw/qib/qib_pcie.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_pcie.c b/drivers/infiniband/hw/qib/qib_pcie.c
index 3dc6ce033319..caff44d2c12c 100644
--- a/drivers/infiniband/hw/qib/qib_pcie.c
+++ b/drivers/infiniband/hw/qib/qib_pcie.c
@@ -213,7 +213,7 @@ int qib_pcie_params(struct qib_devdata *dd, u32 minw, u32 *nent)
 	u16 linkstat, speed;
 	int nvec;
 	int maxvec;
-	unsigned int flags = PCI_IRQ_MSIX | PCI_IRQ_MSI;
+	unsigned int flags;
 
 	if (!pci_is_pcie(dd->pcidev)) {
 		qib_dev_err(dd, "Can't find PCI Express capability!\n");
@@ -225,7 +225,9 @@ int qib_pcie_params(struct qib_devdata *dd, u32 minw, u32 *nent)
 	}
 
 	if (dd->flags & QIB_HAS_INTX)
-		flags |= PCI_IRQ_LEGACY;
+		flags = PCI_IRQ_ALL_TYPES;
+	else
+		flags = PCI_IRQ_MSI_TYPES;
 	maxvec = (nent && *nent) ? *nent : 1;
 	nvec = pci_alloc_irq_vectors(dd->pcidev, 1, maxvec, flags);
 	if (nvec < 0)
-- 
2.17.2

