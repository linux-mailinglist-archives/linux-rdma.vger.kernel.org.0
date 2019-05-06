Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36ED814B48
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 15:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfEFNyD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 09:54:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:48135 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbfEFNyD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 May 2019 09:54:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 06:54:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="344291820"
Received: from ssaleem-mobl4.amr.corp.intel.com ([10.255.35.243])
  by fmsmga006.fm.intel.com with ESMTP; 06 May 2019 06:54:01 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH v3 rdma-next 2/6] RDMA/verbs: Add a DMA iterator to return aligned contiguous memory blocks
Date:   Mon,  6 May 2019 08:53:33 -0500
Message-Id: <20190506135337.11324-3-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20190506135337.11324-1-shiraz.saleem@intel.com>
References: <20190506135337.11324-1-shiraz.saleem@intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This helper iterates over a DMA-mapped SGL and returns contiguous
memory blocks aligned to a HW supported page size.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Gal Pressman <galpress@amazon.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/core/verbs.c | 34 +++++++++++++++++++++++++++++
 include/rdma/ib_verbs.h         | 47 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 7313edc..3806038 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2711,3 +2711,37 @@ int rdma_init_netdev(struct ib_device *device, u8 port_num,
 					     netdev, params.param);
 }
 EXPORT_SYMBOL(rdma_init_netdev);
+
+void __rdma_block_iter_start(struct ib_block_iter *biter,
+			     struct scatterlist *sglist, unsigned int nents,
+			     unsigned long pgsz)
+{
+	memset(biter, 0, sizeof(struct ib_block_iter));
+	biter->__sg = sglist;
+	biter->__sg_nents = nents;
+
+	/* Driver provides best block size to use */
+	biter->__pg_bit = __fls(pgsz);
+}
+EXPORT_SYMBOL(__rdma_block_iter_start);
+
+bool __rdma_block_iter_next(struct ib_block_iter *biter)
+{
+	unsigned int block_offset;
+
+	if (!biter->__sg_nents || !biter->__sg)
+		return false;
+
+	biter->__dma_addr = sg_dma_address(biter->__sg) + biter->__sg_advance;
+	block_offset = biter->__dma_addr & (BIT_ULL(biter->__pg_bit) - 1);
+	biter->__sg_advance += BIT_ULL(biter->__pg_bit) - block_offset;
+
+	if (biter->__sg_advance >= sg_dma_len(biter->__sg)) {
+		biter->__sg_advance = 0;
+		biter->__sg = sg_next(biter->__sg);
+		biter->__sg_nents--;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL(__rdma_block_iter_next);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 5391c24..8a5ed04 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2711,6 +2711,21 @@ struct ib_client {
 	u8 no_kverbs_req:1;
 };
 
+/*
+ * IB block DMA iterator
+ *
+ * Iterates the DMA-mapped SGL in contiguous memory blocks aligned
+ * to a HW supported page size.
+ */
+struct ib_block_iter {
+	/* internal states */
+	struct scatterlist *__sg;	/* sg holding the current aligned block */
+	dma_addr_t __dma_addr;		/* unaligned DMA address of this block */
+	unsigned int __sg_nents;	/* number of SG entries */
+	unsigned int __sg_advance;	/* number of bytes to advance in sg in next step */
+	unsigned int __pg_bit;		/* alignment of current block */
+};
+
 struct ib_device *_ib_alloc_device(size_t size);
 #define ib_alloc_device(drv_struct, member)                                    \
 	container_of(_ib_alloc_device(sizeof(struct drv_struct) +              \
@@ -2731,6 +2746,38 @@ struct ib_client {
 int ib_register_client   (struct ib_client *client);
 void ib_unregister_client(struct ib_client *client);
 
+void __rdma_block_iter_start(struct ib_block_iter *biter,
+			     struct scatterlist *sglist,
+			     unsigned int nents,
+			     unsigned long pgsz);
+bool __rdma_block_iter_next(struct ib_block_iter *biter);
+
+/**
+ * rdma_block_iter_dma_address - get the aligned dma address of the current
+ * block held by the block iterator.
+ * @biter: block iterator holding the memory block
+ */
+static inline dma_addr_t
+rdma_block_iter_dma_address(struct ib_block_iter *biter)
+{
+	return biter->__dma_addr & ~(BIT_ULL(biter->__pg_bit) - 1);
+}
+
+/**
+ * rdma_for_each_block - iterate over contiguous memory blocks of the sg list
+ * @sglist: sglist to iterate over
+ * @biter: block iterator holding the memory block
+ * @nents: maximum number of sg entries to iterate over
+ * @pgsz: best HW supported page size to use
+ *
+ * Callers may use rdma_block_iter_dma_address() to get each
+ * blocks aligned DMA address.
+ */
+#define rdma_for_each_block(sglist, biter, nents, pgsz)		\
+	for (__rdma_block_iter_start(biter, sglist, nents,	\
+				     pgsz);			\
+	     __rdma_block_iter_next(biter);)
+
 /**
  * ib_get_client_data - Get IB client context
  * @device:Device to get context for
-- 
1.8.3.1

