Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC7F2A9BD1
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Nov 2020 19:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgKFSUN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Nov 2020 13:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgKFSUM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Nov 2020 13:20:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8639CC0613CF;
        Fri,  6 Nov 2020 10:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8HNfwBlNSAg+LZJvcmYMWBom95EiBVW9juhSXpZeH6I=; b=vUzrjATA0760PXkfY/rEEuFcPj
        R1Dhmwia29RBnH9AimhaYVEMgXT968d8IQr3gNYrlnaaZqd6fj7BduqWhsLMygJdTGu5iUxecX1mz
        UYKNlcL3DDw0tvT/6CCZLdDGYHn5sl9rzJVYUPJjfespkNKUZDYB3xRW1m3Tk+BPMHhJ8QHtPEcn6
        VSz+1s/ViGV8v9pQgVvg8a0cCQyNy9aPQIwoC22mAPdKrv9FGjZgo4msnvNXBYOmYB28RUqh//UXb
        7BHL56mFAMDQKGxkFs7zg8iLVulrKcAtEI8JrW3w1lmfEtK1iLUi6r+veMTjEDP4UbOQRTnHp6IGz
        aL1z+PbA==;
Received: from [2001:4bb8:184:9a8d:9e34:f7f4:e59e:ad6f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb6LB-0005f7-PV; Fri, 06 Nov 2020 18:20:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH 08/10] PCI/P2PDMA: Remove the DMA_VIRT_OPS hacks
Date:   Fri,  6 Nov 2020 19:19:39 +0100
Message-Id: <20201106181941.1878556-9-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106181941.1878556-1-hch@lst.de>
References: <20201106181941.1878556-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Now that all users of dma_virt_ops are gone we can remove the workaround
for it in the PCI peer to peer code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/p2pdma.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index de1c331dbed43f..b07018af53876c 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -556,15 +556,6 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 		return -1;
 
 	for (i = 0; i < num_clients; i++) {
-#ifdef CONFIG_DMA_VIRT_OPS
-		if (clients[i]->dma_ops == &dma_virt_ops) {
-			if (verbose)
-				dev_warn(clients[i],
-					 "cannot be used for peer-to-peer DMA because the driver makes use of dma_virt_ops\n");
-			return -1;
-		}
-#endif
-
 		pci_client = find_parent_pci_dev(clients[i]);
 		if (!pci_client) {
 			if (verbose)
@@ -837,17 +828,6 @@ static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
 	phys_addr_t paddr;
 	int i;
 
-	/*
-	 * p2pdma mappings are not compatible with devices that use
-	 * dma_virt_ops. If the upper layers do the right thing
-	 * this should never happen because it will be prevented
-	 * by the check in pci_p2pdma_distance_many()
-	 */
-#ifdef CONFIG_DMA_VIRT_OPS
-	if (WARN_ON_ONCE(dev->dma_ops == &dma_virt_ops))
-		return 0;
-#endif
-
 	for_each_sg(sg, s, nents, i) {
 		paddr = sg_phys(s);
 
-- 
2.28.0

