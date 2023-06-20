Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E1F73685D
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jun 2023 11:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjFTJwW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 05:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjFTJvs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 05:51:48 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C16B198C;
        Tue, 20 Jun 2023 02:49:41 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 1C5FB92009E; Tue, 20 Jun 2023 11:49:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 166A192009B;
        Tue, 20 Jun 2023 10:49:20 +0100 (BST)
Date:   Tue, 20 Jun 2023 10:49:20 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
cc:     linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] IB/hfi1: Remove pci_parent_bus_reset() duplication
In-Reply-To: <alpine.DEB.2.21.2306200153110.14084@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2306200235510.14084@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2306200153110.14084@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Call pci_parent_bus_reset() rather than duplicating it in trigger_sbr().
There are extra preparatory checks made by the former function, but they 
are supposed to be neutral to the HFI1 device.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/infiniband/hw/hfi1/pcie.c |   30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

linux-ib-hfi1-pcie-sbr-parent-bus-reset.diff
Index: linux-macro/drivers/infiniband/hw/hfi1/pcie.c
===================================================================
--- linux-macro.orig/drivers/infiniband/hw/hfi1/pcie.c
+++ linux-macro/drivers/infiniband/hw/hfi1/pcie.c
@@ -796,35 +796,13 @@ static void pcie_post_steps(struct hfi1_
 /*
  * Trigger a secondary bus reset (SBR) on ourselves using our parent.
  *
- * Based on pci_parent_bus_reset() which is not exported by the
- * kernel core.
+ * This is an end around to do an SBR during probe time.  A new API
+ * needs to be implemented to have cleaner interface but this fixes
+ * the current brokenness.
  */
 static int trigger_sbr(struct hfi1_devdata *dd)
 {
-	struct pci_dev *dev = dd->pcidev;
-	struct pci_dev *pdev;
-
-	/* need a parent */
-	if (!dev->bus->self) {
-		dd_dev_err(dd, "%s: no parent device\n", __func__);
-		return -ENOTTY;
-	}
-
-	/* should not be anyone else on the bus */
-	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
-		if (pdev != dev) {
-			dd_dev_err(dd,
-				   "%s: another device is on the same bus\n",
-				   __func__);
-			return -ENOTTY;
-		}
-
-	/*
-	 * This is an end around to do an SBR during probe time. A new API needs
-	 * to be implemented to have cleaner interface but this fixes the
-	 * current brokenness
-	 */
-	return pci_bridge_secondary_bus_reset(dev->bus->self);
+	return pci_parent_bus_reset(dd->pcidev, PCI_RESET_DO_RESET);
 }
 
 /*
