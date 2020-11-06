Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34AC2A9BCF
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Nov 2020 19:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgKFSUM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Nov 2020 13:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgKFSUM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Nov 2020 13:20:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD0AC0613CF;
        Fri,  6 Nov 2020 10:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=L6cRLUhK//o9WewIZpiSJodvE7qCQTp6LO8uunrroR0=; b=IxUSXUM+yTi4uOdKjGZO9iKRa4
        nsWFNvEF5FwyWIxUbPlCLHAYqAJKe24e4ahZiJctdsBTCU2lGxR2+wsZ0UAtRdtiZD/8m56SyHSDn
        ll2FeM6HxZdmsKEwR9ZmitgRfn/NGBScM3XDQOQMCKCv9J4s8l5sr4zT6L+Ah06sMHykFOVrdhPzA
        wRihkMwFRRE1X4sWaAg//HWTCM2nyaomXLfNcq7xmPOnuFAS2LARlD3K66/THlDoZWjdKgbkcK01v
        kN/Vh6USoU5CXVaMtIs4gSEDMbex4tLR2BMPqmed2VnW47TCa1sOxXyDqOHISBDtha1PTooA3iLL2
        fV/OZSzw==;
Received: from [2001:4bb8:184:9a8d:9e34:f7f4:e59e:ad6f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb6L7-0005eZ-0E; Fri, 06 Nov 2020 18:19:57 +0000
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
Subject: [PATCH 06/10] RDMA/core: remove ib_dma_{alloc,free}_coherent
Date:   Fri,  6 Nov 2020 19:19:37 +0100
Message-Id: <20201106181941.1878556-7-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106181941.1878556-1-hch@lst.de>
References: <20201106181941.1878556-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These two functions are entirely unused.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/rdma/ib_verbs.h | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 3257cc046e460f..453793d1d2225f 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4098,35 +4098,6 @@ static inline void ib_dma_sync_single_for_device(struct ib_device *dev,
 	dma_sync_single_for_device(dev->dma_device, addr, size, dir);
 }
 
-/**
- * ib_dma_alloc_coherent - Allocate memory and map it for DMA
- * @dev: The device for which the DMA address is requested
- * @size: The size of the region to allocate in bytes
- * @dma_handle: A pointer for returning the DMA address of the region
- * @flag: memory allocator flags
- */
-static inline void *ib_dma_alloc_coherent(struct ib_device *dev,
-					   size_t size,
-					   dma_addr_t *dma_handle,
-					   gfp_t flag)
-{
-	return dma_alloc_coherent(dev->dma_device, size, dma_handle, flag);
-}
-
-/**
- * ib_dma_free_coherent - Free memory allocated by ib_dma_alloc_coherent()
- * @dev: The device for which the DMA addresses were allocated
- * @size: The size of the region
- * @cpu_addr: the address returned by ib_dma_alloc_coherent()
- * @dma_handle: the DMA address returned by ib_dma_alloc_coherent()
- */
-static inline void ib_dma_free_coherent(struct ib_device *dev,
-					size_t size, void *cpu_addr,
-					dma_addr_t dma_handle)
-{
-	dma_free_coherent(dev->dma_device, size, cpu_addr, dma_handle);
-}
-
 /* ib_reg_user_mr - register a memory region for virtual addresses from kernel
  * space. This function should be called when 'current' is the owning MM.
  */
-- 
2.28.0

