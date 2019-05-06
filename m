Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B167B14B4C
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 15:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfEFNyF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 09:54:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:48135 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfEFNyF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 May 2019 09:54:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 06:54:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="344291848"
Received: from ssaleem-mobl4.amr.corp.intel.com ([10.255.35.243])
  by fmsmga006.fm.intel.com with ESMTP; 06 May 2019 06:54:04 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v3 rdma-next 6/6] RDMA/verbs: Extend DMA block iterator support for mixed block sizes
Date:   Mon,  6 May 2019 08:53:37 -0500
Message-Id: <20190506135337.11324-7-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20190506135337.11324-1-shiraz.saleem@intel.com>
References: <20190506135337.11324-1-shiraz.saleem@intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Extend the DMA block iterator for HW that can support mixed
block sizes. A bitmap of HW supported page sizes are provided
to block iterator which returns contiguous aligned memory blocks
within a HW supported page size.

Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/core/verbs.c | 38 ++++++++++++++++++++++++++++++++++++--
 include/rdma/ib_verbs.h         | 18 ++++++++++++++----
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 3806038..fa9725d 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2712,16 +2712,47 @@ int rdma_init_netdev(struct ib_device *device, u8 port_num,
 }
 EXPORT_SYMBOL(rdma_init_netdev);
 
+static unsigned int rdma_find_mixed_pg_bit(struct ib_block_iter *biter)
+{
+	if (biter->__sg == biter->__sgl_head) {
+		return rdma_find_pg_bit(sg_dma_address(biter->__sg) +
+					sg_dma_len(biter->__sg),
+					biter->pgsz_bitmap);
+	} else if (sg_is_last(biter->__sg)) {
+		return rdma_find_pg_bit(sg_dma_address(biter->__sg),
+					biter->pgsz_bitmap);
+	} else {
+		unsigned int remaining =
+			sg_dma_address(biter->__sg) + sg_dma_len(biter->__sg) -
+			biter->__dma_addr;
+		unsigned int pg_bit = rdma_find_pg_bit(biter->__dma_addr,
+						       biter->pgsz_bitmap);
+		if (remaining < BIT_ULL(biter->__pg_bit))
+			pg_bit = rdma_find_pg_bit(remaining,
+						  biter->pgsz_bitmap);
+
+		return pg_bit;
+	}
+}
+
 void __rdma_block_iter_start(struct ib_block_iter *biter,
 			     struct scatterlist *sglist, unsigned int nents,
-			     unsigned long pgsz)
+			     unsigned long pgsz_bitmap)
 {
 	memset(biter, 0, sizeof(struct ib_block_iter));
 	biter->__sg = sglist;
+	biter->pgsz_bitmap = pgsz_bitmap;
 	biter->__sg_nents = nents;
 
 	/* Driver provides best block size to use */
-	biter->__pg_bit = __fls(pgsz);
+	if (hweight_long(pgsz_bitmap) == 1) {
+		biter->__pg_bit = __fls(pgsz_bitmap);
+	} else {
+		/* mixed block size support. compute best block size to use */
+		WARN_ON(!(pgsz_bitmap & GENMASK(PAGE_SHIFT, 0)));
+		biter->__sgl_head = &sglist[0];
+		biter->__mixed = true;
+	}
 }
 EXPORT_SYMBOL(__rdma_block_iter_start);
 
@@ -2733,6 +2764,9 @@ bool __rdma_block_iter_next(struct ib_block_iter *biter)
 		return false;
 
 	biter->__dma_addr = sg_dma_address(biter->__sg) + biter->__sg_advance;
+	if (biter->__mixed)
+		biter->__pg_bit = rdma_find_mixed_pg_bit(biter);
+
 	block_offset = biter->__dma_addr & (BIT_ULL(biter->__pg_bit) - 1);
 	biter->__sg_advance += BIT_ULL(biter->__pg_bit) - block_offset;
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 8a5ed04..1d8725a 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2718,12 +2718,22 @@ struct ib_client {
  * to a HW supported page size.
  */
 struct ib_block_iter {
+	unsigned long pgsz_bitmap;	/* bitmap of supported HW page sizes.
+					 * HW that can handle only blocks of a
+					 * single page size must just provide
+					 * the best page size to use in pgsz_bitmap
+					 */
+
 	/* internal states */
 	struct scatterlist *__sg;	/* sg holding the current aligned block */
+	struct scatterlist *__sgl_head;	/* scatterlist head */
 	dma_addr_t __dma_addr;		/* unaligned DMA address of this block */
 	unsigned int __sg_nents;	/* number of SG entries */
 	unsigned int __sg_advance;	/* number of bytes to advance in sg in next step */
 	unsigned int __pg_bit;		/* alignment of current block */
+	u8 __mixed;			/* HW supports single block size or mixed
+					 * block sizes
+					 */
 };
 
 struct ib_device *_ib_alloc_device(size_t size);
@@ -2749,7 +2759,7 @@ struct ib_block_iter {
 void __rdma_block_iter_start(struct ib_block_iter *biter,
 			     struct scatterlist *sglist,
 			     unsigned int nents,
-			     unsigned long pgsz);
+			     unsigned long pgsz_bitmap);
 bool __rdma_block_iter_next(struct ib_block_iter *biter);
 
 /**
@@ -2768,14 +2778,14 @@ void __rdma_block_iter_start(struct ib_block_iter *biter,
  * @sglist: sglist to iterate over
  * @biter: block iterator holding the memory block
  * @nents: maximum number of sg entries to iterate over
- * @pgsz: best HW supported page size to use
+ * @pgsz_bitmap: bitmap of HW supported page sizes
  *
  * Callers may use rdma_block_iter_dma_address() to get each
  * blocks aligned DMA address.
  */
-#define rdma_for_each_block(sglist, biter, nents, pgsz)		\
+#define rdma_for_each_block(sglist, biter, nents, pgsz_bitmap)	\
 	for (__rdma_block_iter_start(biter, sglist, nents,	\
-				     pgsz);			\
+				     pgsz_bitmap);		\
 	     __rdma_block_iter_next(biter);)
 
 /**
-- 
1.8.3.1

