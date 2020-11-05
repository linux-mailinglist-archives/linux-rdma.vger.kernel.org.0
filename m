Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8FB2A785B
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 08:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgKEHzZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 02:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKEHzZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Nov 2020 02:55:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830F5C0613CF;
        Wed,  4 Nov 2020 23:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IlFC5uLN53//nOw1snJqxiUukwasxjVCret8k23G090=; b=thrGW61kfNEXca0VM6wmSsxPVw
        4sflPwy0fsG8GsGaViZzQkNIt2AEuuSg9EZDEzmBk1FkDoOtceTiQaUw9qZ9W3KsNQCAFYEjSXXMg
        6ckGzoZEx1we1BkEd0jrpZ5j1aT5tutJcR9gdzvx0KhxWm+x1SnEBPYYDoKCdu9SC2uTNMbuiNxxH
        R36Kb75zMAZswBrT98Xh+N5p0AbOq0VbLT6PlS2stnEu2E2PTqZtBaVW/yvi8SNix9QnOwuhs2ych
        sxEV6M5ID1F6Ahdoaw/O2tLEXFbXEzWj0sPBGX2hWfdtHMByQtO78PlW+slo2xO4eV3zNVwsNk/4b
        KqImcfmw==;
Received: from 089144208145.atnat0017.highway.a1.net ([89.144.208.145] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaa74-0005En-NN; Thu, 05 Nov 2020 07:55:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [PATCH 5/6] PCI/P2PDMA: Cleanup __pci_p2pdma_map_sg a bit
Date:   Thu,  5 Nov 2020 08:42:04 +0100
Message-Id: <20201105074205.1690638-6-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201105074205.1690638-1-hch@lst.de>
References: <20201105074205.1690638-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove the pointless paddr variable that was only used once.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/p2pdma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index b07018af53876c..afd792cc272832 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -825,13 +825,10 @@ static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
 		struct device *dev, struct scatterlist *sg, int nents)
 {
 	struct scatterlist *s;
-	phys_addr_t paddr;
 	int i;
 
 	for_each_sg(sg, s, nents, i) {
-		paddr = sg_phys(s);
-
-		s->dma_address = paddr - p2p_pgmap->bus_offset;
+		s->dma_address = sg_phys(s) - p2p_pgmap->bus_offset;
 		sg_dma_len(s) = s->length;
 	}
 
-- 
2.28.0

