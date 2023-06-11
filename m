Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8449F72B323
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jun 2023 19:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjFKRU4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Jun 2023 13:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjFKRUz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Jun 2023 13:20:55 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21BFFE6F;
        Sun, 11 Jun 2023 10:20:30 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 529979200C9; Sun, 11 Jun 2023 19:20:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 4E1479200C0;
        Sun, 11 Jun 2023 18:20:02 +0100 (BST)
Date:   Sun, 11 Jun 2023 18:20:02 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
cc:     Alex Williamson <alex.williamson@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Stefan Roese <sr@denx.de>, Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 12/14] PCI: Provide stub failed link recovery for device
 probing and hot plug
In-Reply-To: <alpine.DEB.2.21.2305310024400.59226@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2306111619570.64925@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2305310024400.59226@angie.orcam.me.uk>
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

This now fails unconditionally and will be always optimised away, but 
provides for quirks to implement recovery for failed links detected in 
device probing and device hot plug events.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
New change in v9, factored out from 7/7:

- Rename `pcie_downstream_link_retrain' to `pcie_failed_link_retrain'.

- Add stub implementation in "pci.h".
---
 drivers/pci/pci.c   |    2 ++
 drivers/pci/pci.h   |    4 ++++
 drivers/pci/probe.c |    2 ++
 3 files changed, 8 insertions(+)

linux-pcie-failed-link-retrain.diff
Index: linux-macro/drivers/pci/pci.c
===================================================================
--- linux-macro.orig/drivers/pci/pci.c
+++ linux-macro/drivers/pci/pci.c
@@ -4912,6 +4912,8 @@ static bool pcie_wait_for_link_delay(str
 	if (active)
 		msleep(20);
 	ret = pcie_wait_for_link_status(pdev, false, active);
+	if (active && !ret)
+		ret = pcie_failed_link_retrain(pdev);
 	if (active && ret)
 		msleep(delay);
 
Index: linux-macro/drivers/pci/pci.h
===================================================================
--- linux-macro.orig/drivers/pci/pci.h
+++ linux-macro/drivers/pci/pci.h
@@ -554,6 +554,10 @@ static inline int pci_dev_specific_disab
 	return -ENOTTY;
 }
 #endif
+static inline bool pcie_failed_link_retrain(struct pci_dev *dev)
+{
+	return false;
+}
 
 /* PCI error reporting and recovery */
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
Index: linux-macro/drivers/pci/probe.c
===================================================================
--- linux-macro.orig/drivers/pci/probe.c
+++ linux-macro/drivers/pci/probe.c
@@ -2549,6 +2549,8 @@ void pci_device_add(struct pci_dev *dev,
 	dma_set_max_seg_size(&dev->dev, 65536);
 	dma_set_seg_boundary(&dev->dev, 0xffffffff);
 
+	pcie_failed_link_retrain(dev);
+
 	/* Fix up broken headers */
 	pci_fixup_device(pci_fixup_header, dev);
 
