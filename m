Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EE62A9BCC
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Nov 2020 19:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgKFSUK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Nov 2020 13:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgKFSUJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Nov 2020 13:20:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBD7C0613CF;
        Fri,  6 Nov 2020 10:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=opD+7yvl9wR6zoOBhy2iFdwJK1/Aiw1n4fvgSFwgxlM=; b=shOCniXrYBujUE+rm7U8l7fEqg
        aVSzGtrG4ebY9YxX2ypfZdb5EOe7W1JDOpsWz5FwRgV0r8SmavehbaX5HEW1T2KHTwpMLwcblEXr1
        JLz1rfrhmII1sVsRGnWGxyFQq+8jJ+dfFpJTuFURy+KP65N+8Bq+DaWn3CQk+478dgreZRZXWj2IK
        U9rxmhw+jO8OqrAdZphc198iSvGH75JCF5o9PW2JPd3dtplUBqTkYiCpPvclE+efqLZWgJ94H5ofR
        cwHerwUSPvR0JbBqeCG38opDaiNRoDiZNY6cnPPc3T+iso2RrQEwJTT3f6NQu9ltp/M1SVae/ILY6
        v67sBABw==;
Received: from [2001:4bb8:184:9a8d:9e34:f7f4:e59e:ad6f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb6Ky-0005dg-4e; Fri, 06 Nov 2020 18:19:48 +0000
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
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 02/10] RDMA/umem: use ib_dma_max_seg_size instead of dma_get_max_seg_size
Date:   Fri,  6 Nov 2020 19:19:33 +0100
Message-Id: <20201106181941.1878556-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106181941.1878556-1-hch@lst.de>
References: <20201106181941.1878556-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

RDMA ULPs must not call DMA mapping APIs directly but instead use the
ib_dma_* wrappers.

Fixes: 0c16d9635e3a ("RDMA/umem: Move to allocate SG table from pages")
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/infiniband/core/umem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index e9fecbdf391bcc..0d4da44f30cd68 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -220,10 +220,10 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 
 		cur_base += ret * PAGE_SIZE;
 		npages -= ret;
-		sg = __sg_alloc_table_from_pages(
-			&umem->sg_head, page_list, ret, 0, ret << PAGE_SHIFT,
-			dma_get_max_seg_size(device->dma_device), sg, npages,
-			GFP_KERNEL);
+		sg = __sg_alloc_table_from_pages(&umem->sg_head, page_list, ret,
+				0, ret << PAGE_SHIFT,
+				ib_dma_max_seg_size(device), sg, npages,
+				GFP_KERNEL);
 		umem->sg_nents = umem->sg_head.nents;
 		if (IS_ERR(sg)) {
 			unpin_user_pages_dirty_lock(page_list, ret, 0);
-- 
2.28.0

