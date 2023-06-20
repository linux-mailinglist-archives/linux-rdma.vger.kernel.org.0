Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB59D73685A
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jun 2023 11:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjFTJwN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 05:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjFTJvm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 05:51:42 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23446173C;
        Tue, 20 Jun 2023 02:49:36 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id B820492009D; Tue, 20 Jun 2023 11:49:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B145092009B;
        Tue, 20 Jun 2023 10:49:14 +0100 (BST)
Date:   Tue, 20 Jun 2023 10:49:14 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
cc:     linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI: Export pci_parent_bus_reset() for drivers to use
In-Reply-To: <alpine.DEB.2.21.2306200153110.14084@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2306200231020.14084@angie.orcam.me.uk>
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

Export pci_parent_bus_reset() so that drivers do not duplicate it.  
Document the interface.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/pci/pci.c   |   15 ++++++++++++++-
 include/linux/pci.h |    1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

linux-pci-parent-bus-reset-export.diff
Index: linux-macro/drivers/pci/pci.c
===================================================================
--- linux-macro.orig/drivers/pci/pci.c
+++ linux-macro/drivers/pci/pci.c
@@ -5149,7 +5149,19 @@ int pci_bridge_secondary_bus_reset(struc
 }
 EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
 
-static int pci_parent_bus_reset(struct pci_dev *dev, bool probe)
+/**
+ * pci_parent_bus_reset - Reset a device via its upstream PCI bridge
+ * @dev: Device to reset.
+ * @probe: Only check if reset is possible if TRUE, actually reset if FALSE.
+ *
+ * Perform a device reset by requesting a secondary bus reset via the
+ * device's immediate upstream PCI bridge.  Return 0 if successful or
+ * -ENOTTY if the reset failed or it could not have been issued in the
+ * first place because the device is not on a secondary bus of any PCI
+ * bridge or it wouldn't be the only device reset.  If probing, then
+ * only verify whether it would be possible to issue a reset.
+ */
+int pci_parent_bus_reset(struct pci_dev *dev, bool probe)
 {
 	struct pci_dev *pdev;
 
@@ -5166,6 +5178,7 @@ static int pci_parent_bus_reset(struct p
 
 	return pci_bridge_secondary_bus_reset(dev->bus->self);
 }
+EXPORT_SYMBOL_GPL(pci_parent_bus_reset);
 
 static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, bool probe)
 {
Index: linux-macro/include/linux/pci.h
===================================================================
--- linux-macro.orig/include/linux/pci.h
+++ linux-macro/include/linux/pci.h
@@ -1447,6 +1447,7 @@ int devm_request_pci_bus_resources(struc
 
 /* Temporary until new and working PCI SBR API in place */
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
+int pci_parent_bus_reset(struct pci_dev *dev, bool probe);
 
 #define __pci_bus_for_each_res0(bus, res, ...)				\
 	for (unsigned int __b = 0;					\
