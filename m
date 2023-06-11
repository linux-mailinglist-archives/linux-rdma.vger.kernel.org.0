Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE7672B314
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jun 2023 19:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjFKRU3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Jun 2023 13:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjFKRU2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Jun 2023 13:20:28 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF8F810C4;
        Sun, 11 Jun 2023 10:20:04 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 53DBD9200C5; Sun, 11 Jun 2023 19:19:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 4D8169200C1;
        Sun, 11 Jun 2023 18:19:45 +0100 (BST)
Date:   Sun, 11 Jun 2023 18:19:45 +0100 (BST)
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
Subject: [PATCH v9 08/14] PCI: Use distinct local vars in
 `pcie_retrain_link'
In-Reply-To: <alpine.DEB.2.21.2305310024400.59226@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2306110252260.64925@angie.orcam.me.uk>
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

Use separate local variables to hold the respective values retrieved 
from the Link Control Register and the Link Status Register.  Not only 
it improves readability, but it makes it possible for the compiler to 
detect actual uninitialised use should this code change in the future.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
New change in v9.
---
 drivers/pci/pci.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

linux-pcie-retrain-link-lnkctl-lnksta.diff
Index: linux-macro/drivers/pci/pci.c
===================================================================
--- linux-macro.orig/drivers/pci/pci.c
+++ linux-macro/drivers/pci/pci.c
@@ -4922,30 +4922,31 @@ bool pcie_wait_for_link(struct pci_dev *
 bool pcie_retrain_link(struct pci_dev *pdev)
 {
 	unsigned long end_jiffies;
-	u16 reg16;
+	u16 lnkctl;
+	u16 lnksta;
 
-	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &reg16);
-	reg16 |= PCI_EXP_LNKCTL_RL;
-	pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, reg16);
+	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &lnkctl);
+	lnkctl |= PCI_EXP_LNKCTL_RL;
+	pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, lnkctl);
 	if (pdev->clear_retrain_link) {
 		/*
 		 * Due to an erratum in some devices the Retrain Link bit
 		 * needs to be cleared again manually to allow the link
 		 * training to succeed.
 		 */
-		reg16 &= ~PCI_EXP_LNKCTL_RL;
-		pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, reg16);
+		lnkctl &= ~PCI_EXP_LNKCTL_RL;
+		pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, lnkctl);
 	}
 
 	/* Wait for link training end. Break out after waiting for timeout. */
 	end_jiffies = jiffies + msecs_to_jiffies(PCIE_LINK_RETRAIN_TIMEOUT_MS);
 	do {
-		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &reg16);
-		if (!(reg16 & PCI_EXP_LNKSTA_LT))
+		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
+		if (!(lnksta & PCI_EXP_LNKSTA_LT))
 			break;
 		msleep(1);
 	} while (time_before(jiffies, end_jiffies));
-	return !(reg16 & PCI_EXP_LNKSTA_LT);
+	return !(lnksta & PCI_EXP_LNKSTA_LT);
 }
 
 /*
