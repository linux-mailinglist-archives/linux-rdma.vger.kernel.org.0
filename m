Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BAB26C655
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 19:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbgIPRqY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 13:46:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbgIPRqS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Sep 2020 13:46:18 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4CC4223BF;
        Wed, 16 Sep 2020 14:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600265255;
        bh=+H3gmvoiKmz4Qey6lHhpUCqGYgX8Cgjx4VB2YdMOxoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w/RgppP+vC59q7MByzYQ00/sqg8odOimtNWb0zJmfafWo4YHHzltzCOdsXn5QqG1X
         +osvkLaazv7XMg29+sS8m83K9psBC4r9YAfsjtKDjcIe53YeYB/h4nj3vyBcgO92ni
         miuX76LGDZLI1JGb51EDSHNTKm/+YMU63JBdMtZ0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 1/2] lib/scatterlist: Add support in dynamic allocation of SG table from pages
Date:   Wed, 16 Sep 2020 17:07:25 +0300
Message-Id: <20200916140726.839377-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200916140726.839377-1-leon@kernel.org>
References: <20200916140726.839377-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

Add an API that supports dynamic allocation of the SG table from pages,
such function should be used by drivers that can't supply all the pages
at one time.

This function returns the last populated SGE in the table. Users should
pass it as an argument to the function from the second call and forward.
As for sg_alloc_table_from_pages, nents will be equal to the number of
populated SGEs (chunks).

With this new API, drivers can benefit the optimization of merging
contiguous pages without a need to allocate all pages in advance and
hold them in a large buffer.

E.g. with the Infiniband driver that allocates a single page for hold the
pages. For 1TB memory registration, the temporary buffer would consume only
4KB, instead of 2GB.

Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/scatterlist.h |  34 +++--
 lib/scatterlist.c           | 273 ++++++++++++++++++++++++++----------
 2 files changed, 223 insertions(+), 84 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 45cf7b69d852..f8984ddff0d5 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -165,6 +165,22 @@ static inline void sg_set_buf(struct scatterlist *sg, const void *buf,
 #define for_each_sgtable_dma_sg(sgt, sg, i)	\
 	for_each_sg((sgt)->sgl, sg, (sgt)->nents, i)

+static inline void __sg_chain(struct scatterlist *chain_sg,
+			      struct scatterlist *sgl)
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
+	__sg_chain(&prv[prv_nents - 1], sgl);
 }

 /**
@@ -286,6 +291,11 @@ void sg_free_table(struct sg_table *);
 int __sg_alloc_table(struct sg_table *, unsigned int, unsigned int,
 		     struct scatterlist *, unsigned int, gfp_t, sg_alloc_fn *);
 int sg_alloc_table(struct sg_table *, unsigned int, gfp_t);
+struct scatterlist *sg_alloc_table_append(
+		struct sg_table *sgt, struct page **pages, unsigned int n_pages,
+		unsigned int offset, unsigned long size,
+		unsigned int max_segment, gfp_t gfp_mask,
+		struct scatterlist *prv, unsigned int left_pages);
 int __sg_alloc_table_from_pages(struct sg_table *sgt, struct page **pages,
 				unsigned int n_pages, unsigned int offset,
 				unsigned long size, unsigned int max_segment,
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 5d63a8857f36..559a5eee86a7 100644
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
@@ -321,10 +297,18 @@ int __sg_alloc_table(struct sg_table *table, unsigned int nents,
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
+			__sg_chain(prv, sg);
+			/*
+			 * We decrease one since the prvious last sge in used to
+			 * chain the chunks together.
+			 */
+			table->nents = table->orig_nents -= 1;
+		}

 		/*
 		 * If no more entries after this one, mark the end
@@ -339,6 +323,37 @@ int __sg_alloc_table(struct sg_table *table, unsigned int nents,

 	return 0;
 }
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
@@ -365,38 +380,50 @@ int sg_alloc_table(struct sg_table *table, unsigned int nents, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(sg_alloc_table);

-/**
- * __sg_alloc_table_from_pages - Allocate and initialize an sg table from
- *			         an array of pages
- * @sgt:	 The sg table header to use
- * @pages:	 Pointer to an array of page pointers
- * @n_pages:	 Number of pages in the pages array
- * @offset:      Offset from start of the first page to the start of a buffer
- * @size:        Number of valid bytes in the buffer (after offset)
- * @max_segment: Maximum size of a scatterlist node in bytes (page aligned)
- * @gfp_mask:	 GFP allocation mask
- *
- *  Description:
- *    Allocate and initialize an sg table from a list of pages. Contiguous
- *    ranges of the pages are squashed into a single scatterlist node up to the
- *    maximum size specified in @max_segment. An user may provide an offset at a
- *    start and a size of valid data in a buffer specified by the page array.
- *    The returned sg table is released by sg_free_table.
- *
- * Returns:
- *   0 on success, negative error on failure
- */
-int __sg_alloc_table_from_pages(struct sg_table *sgt, struct page **pages,
-				unsigned int n_pages, unsigned int offset,
-				unsigned long size, unsigned int max_segment,
-				gfp_t gfp_mask)
+static struct scatterlist *get_next_sg(struct sg_table *table,
+				       struct scatterlist *prv,
+				       unsigned long left_npages,
+				       gfp_t gfp_mask)
 {
-	unsigned int chunks, cur_page, seg_len, i;
+	struct scatterlist *next_sg;
+	int ret;
+
+	/* If table was just allocated */
+	if (!prv)
+		return table->sgl;
+
+	/* Check if last entry should be keeped for chainning */
+	next_sg = sg_next(prv);
+	if (!sg_is_last(next_sg) || left_npages == 1)
+		return next_sg;
+
+	ret = sg_alloc(table, next_sg,
+		       min_t(unsigned long, left_npages, SG_MAX_SINGLE_ALLOC),
+		       SG_MAX_SINGLE_ALLOC, NULL, 0, gfp_mask, sg_kmalloc);
+	if (ret)
+		return ERR_PTR(ret);
+	return sg_next(prv);
+}
+
+static struct scatterlist *alloc_from_pages_common(
+		struct sg_table *sgt, struct page **pages, unsigned int n_pages,
+		unsigned int offset, unsigned long size,
+		unsigned int max_segment, gfp_t gfp_mask,
+		struct scatterlist *prv, unsigned int left_pages)
+{
+	unsigned int chunks, cur_page, seg_len, i, prv_len = 0;
+	unsigned int tmp_nents = sgt->nents;
+	struct scatterlist *s = prv;
+	unsigned int table_size;
 	int ret;
-	struct scatterlist *s;

 	if (WARN_ON(!max_segment || offset_in_page(max_segment)))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
+
+	if (prv &&
+	    page_to_pfn(sg_page(prv)) + (prv->length >> PAGE_SHIFT) ==
+	    page_to_pfn(pages[0]))
+		prv_len = prv->length;

 	/* compute number of contiguous chunks */
 	chunks = 1;
@@ -410,13 +437,17 @@ int __sg_alloc_table_from_pages(struct sg_table *sgt, struct page **pages,
 		}
 	}

-	ret = sg_alloc_table(sgt, chunks, gfp_mask);
-	if (unlikely(ret))
-		return ret;
+	if (!prv) {
+		/* Only the last allocation could be less than the maximum */
+		table_size = left_pages ? SG_MAX_SINGLE_ALLOC : chunks;
+		ret = sg_alloc_table(sgt, table_size, gfp_mask);
+		if (unlikely(ret))
+			return ERR_PTR(ret);
+	}

 	/* merging chunks and putting them into the scatterlist */
 	cur_page = 0;
-	for_each_sg(sgt->sgl, s, sgt->orig_nents, i) {
+	for (i = 0; i < chunks; i++) {
 		unsigned int j, chunk_size;

 		/* look for the end of the current chunk */
@@ -425,19 +456,117 @@ int __sg_alloc_table_from_pages(struct sg_table *sgt, struct page **pages,
 			seg_len += PAGE_SIZE;
 			if (seg_len >= max_segment ||
 			    page_to_pfn(pages[j]) !=
-			    page_to_pfn(pages[j - 1]) + 1)
+				    page_to_pfn(pages[j - 1]) + 1)
 				break;
 		}

 		chunk_size = ((j - cur_page) << PAGE_SHIFT) - offset;
-		sg_set_page(s, pages[cur_page],
-			    min_t(unsigned long, size, chunk_size), offset);
+		chunk_size = min_t(unsigned long, size, chunk_size);
+		if (!i && prv_len) {
+			if (max_segment - prv->length >= chunk_size) {
+				sg_set_page(s, sg_page(s),
+					    s->length + chunk_size, s->offset);
+				goto next;
+			}
+		}
+
+		/* Pass how many chunks might left */
+		s = get_next_sg(sgt, s, chunks - i + left_pages, gfp_mask);
+		if (IS_ERR(s)) {
+			/*
+			 * Adjust entry length to be as before function was
+			 * called.
+			 */
+			if (prv_len)
+				prv->length = prv_len;
+			goto out;
+		}
+		sg_set_page(s, pages[cur_page], chunk_size, offset);
+		tmp_nents++;
+next:
 		size -= chunk_size;
 		offset = 0;
 		cur_page = j;
 	}
+	sgt->nents = tmp_nents;
+out:
+	return s;
+}

-	return 0;
+/**
+ * sg_alloc_table_append - Allocate and initialize an sg table from
+ *                         an array of pages
+ * @sgt:	 The sg table header to use
+ * @pages:	 Pointer to an array of page pointers
+ * @n_pages:	 Number of pages in the pages array
+ * @offset:      Offset from start of the first page to the start of a buffer
+ * @size:        Number of valid bytes in the buffer (after offset)
+ * @max_segment: Maximum size of a scatterlist node in bytes (page aligned)
+ * @gfp_mask:	 GFP allocation mask
+ * @prv:	 Last populated sge in sgt
+ * @left_pages:  Left pages caller have to set after this call
+ *
+ *  Description:
+ *    If @prv is NULL, it allocates and initialize an sg table from a list of
+ *    pages. Contiguous ranges of the pages are squashed into a single
+ *    scatterlist node up to the maximum size specified in @max_segment. A user
+ *    may provide an offset at a start and a size of valid data in a buffer
+ *    specified by the page array. A user may provide @append to chain pages
+ *    to last entry in sgt. The returned sg table is released by sg_free_table.
+ *
+ * Returns:
+ *   Last SGE in sgt on success, negative error on failure.
+ *
+ * Notes:
+ *   If this function returns non-0 (eg failure), the caller must call
+ *   sg_free_table() to cleanup any leftover allocations.
+ */
+struct scatterlist *sg_alloc_table_append(
+		struct sg_table *sgt, struct page **pages, unsigned int n_pages,
+		unsigned int offset, unsigned long size,
+		unsigned int max_segment, gfp_t gfp_mask,
+		struct scatterlist *prv, unsigned int left_pages)
+{
+#ifdef CONFIG_ARCH_NO_SG_CHAIN
+	if (prv)
+		return ERR_PTR(-EOPNOTSUPP);
+#endif
+	return alloc_from_pages_common(sgt, pages, n_pages, offset, size,
+				       max_segment, gfp_mask, prv, left_pages);
+}
+EXPORT_SYMBOL_GPL(sg_alloc_table_append);
+
+/**
+ * __sg_alloc_table_from_pages - Allocate and initialize an sg table from
+ *			         an array of pages
+ * @sgt:	 The sg table header to use
+ * @pages:	 Pointer to an array of page pointers
+ * @n_pages:	 Number of pages in the pages array
+ * @offset:      Offset from start of the first page to the start of a buffer
+ * @size:        Number of valid bytes in the buffer (after offset)
+ * @max_segment: Maximum size of a scatterlist node in bytes (page aligned)
+ * @gfp_mask:	 GFP allocation mask
+ *
+ *  Description:
+ *    Allocate and initialize an sg table from a list of pages. Contiguous
+ *    ranges of the pages are squashed into a single scatterlist node up to the
+ *    maximum size specified in @max_segment. A user may provide an offset at a
+ *    start and a size of valid data in a buffer specified by the page array.
+ *    The returned sg table is released by sg_free_table.
+ *
+ * Returns:
+ *   0 on success, negative error on failure
+ */
+int __sg_alloc_table_from_pages(struct sg_table *sgt, struct page **pages,
+				unsigned int n_pages, unsigned int offset,
+				unsigned long size, unsigned int max_segment,
+				gfp_t gfp_mask)
+{
+	struct scatterlist *sg;
+
+	sg = alloc_from_pages_common(sgt, pages, n_pages, offset, size,
+				     max_segment, gfp_mask, NULL, 0);
+	return PTR_ERR_OR_ZERO(sg);
 }
 EXPORT_SYMBOL(__sg_alloc_table_from_pages);

--
2.26.2

