Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA712A610E
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 11:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgKDKBz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 05:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgKDKBz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Nov 2020 05:01:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1C6C0613D3;
        Wed,  4 Nov 2020 02:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MWQ4wpYE4PesSUuuLcuPA53B6tTBBIP7EaIdrCoKVwY=; b=IojZGMZkDxGemm05TLzznPDSkH
        af7X9Ytwdo5g7izzmeEKXAKtpEVLBPhthWjGIvZUR2EivMCD+cierkvRvGB9WfD9sgqMP7aUz1QCU
        2uT9M77j9+OSRDS0j3QLIB5NPL2npieZDlhQH5lDh7zBT7D2q3F0tl2AX0H3ig20S2TaVZf4B+LMS
        JqkZeor/toY30CD3fuVaEE3s8Uh2LM74PnLhcFUjfmrflb30T+DiebhynU7GyBdgdyYYC/cxdMF9a
        s8Pm4Oj4zJEUH1pNmupEOUce3ns2vs4mu+4jSgmyHw24hCuSsPPlccJ3Nmr3pzUjtRY0pcLnyTJom
        N5JJF5yg==;
Received: from 089144208145.atnat0017.highway.a1.net ([89.144.208.145] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaFc0-00036e-02; Wed, 04 Nov 2020 10:01:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [PATCH 4/5] PCI/p2p: cleanup up __pci_p2pdma_map_sg a bit
Date:   Wed,  4 Nov 2020 10:50:51 +0100
Message-Id: <20201104095052.1222754-5-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104095052.1222754-1-hch@lst.de>
References: <20201104095052.1222754-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove the pointless paddr variable that was only used once.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

