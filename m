Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A171EB850
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2020 11:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgFBJUs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jun 2020 05:20:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:56320 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgFBJUs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 2 Jun 2020 05:20:48 -0400
IronPort-SDR: l+mDoJLykGO5IFfdhYRf2VzSrcwdmIsSKSHngM9Y/iQA0xmxC9Md5kBitp2e/VB3MXfUb/FyF0
 DaMTGBKuzp6g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 02:20:47 -0700
IronPort-SDR: 63RSPoS99T4GWpX11zLGAriEyeW5Se3E3NcFHN0Kaezz/+Oz59kNgNq8iyJ+Np1MQGLlKs0jdR
 wtdzT7yEPhqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,463,1583222400"; 
   d="scan'208";a="286590736"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by orsmga002.jf.intel.com with ESMTP; 02 Jun 2020 02:20:45 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Subject: [PATCH 08/15] IB/qib: Use PCI_IRQ_MSI_TYPES where appropriate
Date:   Tue,  2 Jun 2020 11:20:41 +0200
Message-Id: <20200602092041.32011-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Seeing as there is shorthand available to use when asking for any type
of interrupt, or any type of message signalled interrupt, leverage it.

Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/infiniband/hw/qib/qib_pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_pcie.c b/drivers/infiniband/hw/qib/qib_pcie.c
index 3dc6ce033319..3e22dd274fb3 100644
--- a/drivers/infiniband/hw/qib/qib_pcie.c
+++ b/drivers/infiniband/hw/qib/qib_pcie.c
@@ -213,7 +213,7 @@ int qib_pcie_params(struct qib_devdata *dd, u32 minw, u32 *nent)
 	u16 linkstat, speed;
 	int nvec;
 	int maxvec;
-	unsigned int flags = PCI_IRQ_MSIX | PCI_IRQ_MSI;
+	unsigned int flags = PCI_IRQ_MSI_TYPES;
 
 	if (!pci_is_pcie(dd->pcidev)) {
 		qib_dev_err(dd, "Can't find PCI Express capability!\n");
-- 
2.17.2

