Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8516025C487
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 17:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgICPMW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 11:12:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgICMTI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Sep 2020 08:19:08 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B59620775;
        Thu,  3 Sep 2020 12:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599135547;
        bh=5tR9/jXDc3DUFXp2sFmOEg1HyE6RFBcOc3si0NIQTnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KFr9zVjRNbJpFYx9gkAYaV2R/gY8f6t2ueF/v8PDP76zYWfaYXJt2iVxsdXAd+Nx1
         1Z30/AbtuMRfOIopNMKot8bnN99PlTEeSdXm+cZ86KOIREDxUcgH1JmattMs5wqMC1
         4yMASStP6ZFV5iVQpNOUNAl9dNUwG8aMIWmXViXQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/4] lib/scatterlist: Add support in dynamically allocation of SG entries
Date:   Thu,  3 Sep 2020 15:18:51 +0300
Message-Id: <20200903121853.1145976-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903121853.1145976-1-leon@kernel.org>
References: <20200903121853.1145976-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

In order to support dynamic allocation of SG table, this patch
introduces sg_alloc_next. This function should be called to add more
entries to the table. In order to share the code, we will do the
following:
 * Extract the allocation code from __sg_alloc_table to sg_alloc.
 * Add a function to chain SGE to the next page.

Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/scatterlist.h |  29 ++++++----
 lib/scatterlist.c           | 110 ++++++++++++++++++++++++------------
 2 files changed, 91 insertions(+), 48 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 45cf7b69d852..877d6e160b06 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -165,6 +165,22 @@ static inline void sg_set_buf(struct scatterlist *sg, const void *buf,
 #define for_each_sgtable_dma_sg(sgt, sg, i)	\
 	for_each_sg((sgt)->sgl, sg, (sgt)->nents, i)

+static inline void _sg_chain(struct scatterlist *chain_sg,
+			     struct scatterlist *sgl)
+{
+	/*
+	 * offset and length are unused for chain entry. Clear them.
+	 */
+	chain_sg->offset = 0;
+	chain_sg->length = 0;
+
+	/*
+	 * Set lowest bit to indicate a link pointer, and make sure to clear
+	 * the termination bit if it happens to be set.
+	 */
+	chain_sg->page_link = ((unsigned long) sgl | SG_CHAIN) & ~SG_END;
+}
+
 /**
  * sg_chain - Chain two sglists together
  * @prv:	First scatterlist
@@ -178,18 +194,7 @@ static inline void sg_set_buf(struct scatterlist *sg, const void *buf,
 static inline void sg_chain(struct scatterlist *prv, unsigned int prv_nents,
 			    struct scatterlist *sgl)
 {
-	/*
-	 * offset and length are unused for chain entry.  Clear them.
-	 */
-	prv[prv_nents - 1].offset = 0;
-	prv[prv_nents - 1].length = 0;
-
-	/*
-	 * Set lowest bit to indicate a link pointer, and make sure to clear
-	 * the termination bit if it happens to be set.
-	 */
-	prv[prv_nents - 1].page_link = ((unsigned long) sgl | SG_CHAIN)
-					& ~SG_END;
+	_sg_chain(&prv[prv_nents - 1], sgl);
 }

 /**
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 292e785d21ee..669bd6e6d16a 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -242,38 +242,15 @@ void sg_free_table(struct sg_table *table)
 }
 EXPORT_SYMBOL(sg_free_table);

-/**
- * __sg_alloc_table - Allocate and initialize an sg table with given allocator
- * @table:	The sg table header to use
- * @nents:	Number of entries in sg list
- * @max_ents:	The maximum number of entries the allocator returns per call
- * @nents_first_chunk: Number of entries int the (preallocated) first
- * 	scatterlist chunk, 0 means no such preallocated chunk provided by user
- * @gfp_mask:	GFP allocation mask
- * @alloc_fn:	Allocator to use
- *
- * Description:
- *   This function returns a @table @nents long. The allocator is
- *   defined to return scatterlist chunks of maximum size @max_ents.
- *   Thus if @nents is bigger than @max_ents, the scatterlists will be
- *   chained in units of @max_ents.
- *
- * Notes:
- *   If this function returns non-0 (eg failure), the caller must call
- *   __sg_free_table() to cleanup any leftover allocations.
- *
- **/
-int __sg_alloc_table(struct sg_table *table, unsigned int nents,
-		     unsigned int max_ents, struct scatterlist *first_chunk,
-		     unsigned int nents_first_chunk, gfp_t gfp_mask,
-		     sg_alloc_fn *alloc_fn)
+static int sg_alloc(struct sg_table *table, struct scatterlist *prv,
+		    unsigned int nents, unsigned int max_ents,
+		    struct scatterlist *first_chunk,
+		    unsigned int nents_first_chunk,
+		    gfp_t gfp_mask, sg_alloc_fn *alloc_fn)
 {
-	struct scatterlist *sg, *prv;
-	unsigned int left;
-	unsigned curr_max_ents = nents_first_chunk ?: max_ents;
-	unsigned prv_max_ents;
-
-	memset(table, 0, sizeof(*table));
+	unsigned int curr_max_ents = nents_first_chunk ?: max_ents;
+	unsigned int left, prv_max_ents = 0;
+	struct scatterlist *sg;

 	if (nents == 0)
 		return -EINVAL;
@@ -283,7 +260,6 @@ int __sg_alloc_table(struct sg_table *table, unsigned int nents,
 #endif

 	left = nents;
-	prv = NULL;
 	do {
 		unsigned int sg_size, alloc_size = left;

@@ -308,7 +284,7 @@ int __sg_alloc_table(struct sg_table *table, unsigned int nents,
 			 * linkage.  Without this, sg_kfree() may get
 			 * confused.
 			 */
-			if (prv)
+			if (prv_max_ents)
 				table->nents = ++table->orig_nents;

 			return -ENOMEM;
@@ -321,10 +297,17 @@ int __sg_alloc_table(struct sg_table *table, unsigned int nents,
 		 * If this is the first mapping, assign the sg table header.
 		 * If this is not the first mapping, chain previous part.
 		 */
-		if (prv)
-			sg_chain(prv, prv_max_ents, sg);
-		else
+		if (!prv)
 			table->sgl = sg;
+		else if (prv_max_ents)
+			sg_chain(prv, prv_max_ents, sg);
+		else {
+			_sg_chain(prv, sg);
+			/* We decrease one since the prvious last sge in used to
+			 * chainning.
+			 */
+			table->nents = table->orig_nents -= 1;
+		}

 		/*
 		 * If no more entries after this one, mark the end
@@ -339,6 +322,61 @@ int __sg_alloc_table(struct sg_table *table, unsigned int nents,

 	return 0;
 }
+
+/**
+ * sg_alloc_next - Allocate and initialize new entries in the sg table
+ * @table:	The sg table header to use
+ * @last:	The last scatter list entry in the table
+ * @nents:	Number of entries in sg list
+ * @max_ents:	The maximum number of entries the allocator returns per call
+ * @gfp_mask:	GFP allocation mask
+ * @alloc_fn:	Allocator to use
+ *
+ * Description:
+ *   This function extend @table with @nents long. The allocator is
+ *   defined to return scatterlist chunks of maximum size @max_ents.
+ *   Thus if @nents is bigger than @max_ents, the scatterlists will be
+ *   chained in units of @max_ents.
+ *
+ **/
+static int sg_alloc_next(struct sg_table *table, struct scatterlist *last,
+			 unsigned int nents, unsigned int max_ents,
+			 gfp_t gfp_mask)
+{
+	return sg_alloc(table, last, nents, max_ents, NULL, 0, gfp_mask,
+			sg_kmalloc);
+}
+
+/**
+ * __sg_alloc_table - Allocate and initialize an sg table with given allocator
+ * @table:	The sg table header to use
+ * @nents:	Number of entries in sg list
+ * @max_ents:	The maximum number of entries the allocator returns per call
+ * @nents_first_chunk: Number of entries int the (preallocated) first
+ * scatterlist chunk, 0 means no such preallocated chunk provided by user
+ * @gfp_mask:	GFP allocation mask
+ * @alloc_fn:	Allocator to use
+ *
+ * Description:
+ *   This function returns a @table @nents long. The allocator is
+ *   defined to return scatterlist chunks of maximum size @max_ents.
+ *   Thus if @nents is bigger than @max_ents, the scatterlists will be
+ *   chained in units of @max_ents.
+ *
+ * Notes:
+ *   If this function returns non-0 (eg failure), the caller must call
+ *   __sg_free_table() to cleanup any leftover allocations.
+ *
+ **/
+int __sg_alloc_table(struct sg_table *table, unsigned int nents,
+		     unsigned int max_ents, struct scatterlist *first_chunk,
+		     unsigned int nents_first_chunk, gfp_t gfp_mask,
+		     sg_alloc_fn *alloc_fn)
+{
+	memset(table, 0, sizeof(*table));
+	return sg_alloc(table, NULL, nents, max_ents, first_chunk,
+			nents_first_chunk, gfp_mask, alloc_fn);
+}
 EXPORT_SYMBOL(__sg_alloc_table);

 /**
--
2.26.2

