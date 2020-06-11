Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8771F68ED
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2020 15:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgFKNRZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 11 Jun 2020 09:17:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:49921 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgFKNRZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Jun 2020 09:17:25 -0400
IronPort-SDR: 9R2trFvioucbU8xyZT5QAoRTxHZGzRSkamKM35CzKFb6cOGg3kCplC27cJqejCK+nmSvRNoGzq
 Bgy/QYjE+I2A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 06:17:24 -0700
IronPort-SDR: 0RMRR5n95P1uk3MlcdKOxaQeBrPwufjj7jl7v3NUh8LU0cqZZtPToZs4jvC6LstL2Yf/qvG2VR
 RN6MiYiRAYqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,499,1583222400"; 
   d="scan'208";a="289537525"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga002.jf.intel.com with ESMTP; 11 Jun 2020 06:17:24 -0700
Received: from fmsmsx124.amr.corp.intel.com (10.18.125.39) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 11 Jun 2020 06:17:24 -0700
Received: from fmsmsx107.amr.corp.intel.com ([169.254.6.74]) by
 fmsmsx124.amr.corp.intel.com ([169.254.8.63]) with mapi id 14.03.0439.000;
 Thu, 11 Jun 2020 06:17:24 -0700
From:   "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To:     "Stankiewicz, Piotr" <piotr.stankiewicz@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "Stankiewicz, Piotr" <piotr.stankiewicz@intel.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 08/15] IB/qib: Use PCI_IRQ_MSI_TYPES where appropriate
Thread-Topic: [PATCH v3 08/15] IB/qib: Use PCI_IRQ_MSI_TYPES where
 appropriate
Thread-Index: AQHWPj8EsjfpQ0WavE+AvROCK2Jb1qjTZ31w
Date:   Thu, 11 Jun 2020 13:17:22 +0000
Message-ID: <14063C7AD467DE4B82DEDB5C278E8663010F35E258@fmsmsx107.amr.corp.intel.com>
References: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
 <20200609091823.1346-1-piotr.stankiewicz@intel.com>
In-Reply-To: <20200609091823.1346-1-piotr.stankiewicz@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>-----Original Message-----
>From: linux-rdma-owner@vger.kernel.org <linux-rdma-
>owner@vger.kernel.org> On Behalf Of Piotr Stankiewicz
>Sent: Tuesday, June 9, 2020 5:18 AM
>To: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org
>Cc: Stankiewicz, Piotr <piotr.stankiewicz@intel.com>; Dalessandro, Dennis
><dennis.dalessandro@intel.com>; Marciniszyn, Mike
><mike.marciniszyn@intel.com>; Doug Ledford <dledford@redhat.com>;
>Jason Gunthorpe <jgg@ziepe.ca>; Arnd Bergmann <arnd@arndb.de>;
>Shevchenko, Andriy <andriy.shevchenko@intel.com>; linux-
>rdma@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: [PATCH v3 08/15] IB/qib: Use PCI_IRQ_MSI_TYPES where appropriate
>
>Seeing as there is shorthand available to use when asking for any type
>of interrupt, or any type of message signalled interrupt, leverage it.
>
>Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
>Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>---
> drivers/infiniband/hw/qib/qib_pcie.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/infiniband/hw/qib/qib_pcie.c
>b/drivers/infiniband/hw/qib/qib_pcie.c
>index 3dc6ce033319..caff44d2c12c 100644
>--- a/drivers/infiniband/hw/qib/qib_pcie.c
>+++ b/drivers/infiniband/hw/qib/qib_pcie.c
>@@ -213,7 +213,7 @@ int qib_pcie_params(struct qib_devdata *dd, u32
>minw, u32 *nent)
> 	u16 linkstat, speed;
> 	int nvec;
> 	int maxvec;
>-	unsigned int flags = PCI_IRQ_MSIX | PCI_IRQ_MSI;
>+	unsigned int flags;
>
> 	if (!pci_is_pcie(dd->pcidev)) {
> 		qib_dev_err(dd, "Can't find PCI Express capability!\n");
>@@ -225,7 +225,9 @@ int qib_pcie_params(struct qib_devdata *dd, u32
>minw, u32 *nent)
> 	}
>
> 	if (dd->flags & QIB_HAS_INTX)
>-		flags |= PCI_IRQ_LEGACY;
>+		flags = PCI_IRQ_ALL_TYPES;
>+	else
>+		flags = PCI_IRQ_MSI_TYPES;

Thinking about lines of code, this patch could probably just be:

-	unsigned int flags = PCI_IRQ_MSIX | PCI_IRQ_MSI;
+	unsigned int flags = PCI_IRQ_MSI_TYPES;

Or maybe even:

-	unsigned int flags = PCI_IRQ_MSIX | PCI_IRQ_MSI;
+	unsigned int flags = PCI_IRQ_ALL_TYPES;

- 	if (dd->flags & QIB_HAS_INTX)
-		flags |= PCI_IRQ_LEGACY;

?

M

> 	maxvec = (nent && *nent) ? *nent : 1;
> 	nvec = pci_alloc_irq_vectors(dd->pcidev, 1, maxvec, flags);
> 	if (nvec < 0)
>--
>2.17.2

