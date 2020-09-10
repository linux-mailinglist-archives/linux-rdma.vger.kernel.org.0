Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30008264780
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Sep 2020 15:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbgIJNv7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Sep 2020 09:51:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730957AbgIJNuh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Sep 2020 09:50:37 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7BD620C09;
        Thu, 10 Sep 2020 13:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599745399;
        bh=nqUozDsWHKFfK8W6Zmuq3D8dIUc6nBawbFyjEB7VGKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RZ5D8wygQYIg8oUMLgaF0zYDleFR6e+9IoW4WXZ78laPqeE8jd88MnFlwU7rp+Lc5
         U3QPa0XDOWRUg7YvOE+XovMe/piv/VtX+1yPnClvdT2tAkQVtwCp4+YVbwcPgCQCYr
         E2o3xf2EHhbCrDLaiwu6+4DO+b/m5Y3WVzPgCOsA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 3/4] lib/scatterlist: Add support in dynamic allocation of SG table from pages
Date:   Thu, 10 Sep 2020 16:42:58 +0300
Message-Id: <20200910134259.1304543-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910134259.1304543-1-leon@kernel.org>
References: <20200910134259.1304543-1-leon@kernel.org>
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

This function returns the last populated sge in the table. Users should
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
 include/linux/scatterlist.h |   6 ++
 lib/scatterlist.c           | 131 +++++++++++++++++++++++++++++++-----
 2 files changed, 119 insertions(+), 18 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 9d13004334aa..9fcc5783dfbc 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -291,6 +291,12 @@ void sg_free_table(struct sg_table *);
 int __sg_alloc_table(struct sg_table *, unsigned int, unsigned int,
 		     struct scatterlist *, unsigned int, gfp_t, sg_alloc_fn *);
 int sg_alloc_table(struct sg_table *, unsigned int, gfp_t);
+#ifndef CONFIG_ARCH_NO_SG_CHAIN
+struct scatterlist *sg_alloc_table_append(
+	struct sg_table *sgt, struct page **pages, unsigned int n_pages,
+	unsigned int offset, unsigned long size, unsigned int max_segment,
+	gfp_t gfp_mask, struct scatterlist *prv, unsigned int left_pages);
+#endif
 int __sg_alloc_table_from_pages(struct sg_table *sgt, struct page **pages,
 				unsigned int n_pages, unsigned int offset,
 				unsigned long size, unsigned int max_segment,
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index ade5c4a6fbf9..8249a6764efe 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -403,19 +403,51 @@ int sg_alloc_table(struct sg_table *table, unsigned int nents, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(sg_alloc_table);

-static struct scatterlist *
-alloc_from_pages_common(struct sg_table *sgt, struct page **pages,
-			unsigned int n_pages, unsigned int offset,
-			unsigned long size, unsigned int max_segment,
-			gfp_t gfp_mask)
+static struct scatterlist *get_next_sg(struct sg_table *table,
+				       struct scatterlist *prv,
+				       unsigned long left_npages,
+				       gfp_t gfp_mask)
 {
-	unsigned int chunks, cur_page, seg_len, i;
-	struct scatterlist *prv, *s = NULL;
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
+	ret = sg_alloc_next(table, next_sg,
+			    min_t(unsigned long, left_npages,
+				  SG_MAX_SINGLE_ALLOC),
+			    SG_MAX_SINGLE_ALLOC, gfp_mask);
+	if (ret)
+		return ERR_PTR(ret);
+	return sg_next(prv);
+}
+
+static struct scatterlist *alloc_from_pages_common(
+	struct sg_table *sgt, struct page **pages, unsigned int n_pages,
+	unsigned int offset, unsigned long size, unsigned int max_segment,
+	gfp_t gfp_mask, struct scatterlist *prv, unsigned int left_pages)
+{
+	unsigned int chunks, cur_page, seg_len, i, prv_len = 0;
+	unsigned int tmp_nents = sgt->nents;
+	struct scatterlist *s = prv;
+	unsigned int table_size;
 	int ret;

 	if (WARN_ON(!max_segment || offset_in_page(max_segment)))
 		return ERR_PTR(-EINVAL);

+	if (prv &&
+	    page_to_pfn(sg_page(prv)) + (prv->length >> PAGE_SHIFT) ==
+	    page_to_pfn(pages[0]))
+		prv_len = prv->length;
+
 	/* compute number of contiguous chunks */
 	chunks = 1;
 	seg_len = 0;
@@ -428,13 +460,16 @@ alloc_from_pages_common(struct sg_table *sgt, struct page **pages,
 		}
 	}

-	ret = sg_alloc_table(sgt, chunks, gfp_mask);
-	if (unlikely(ret))
-		return ERR_PTR(ret);
+	if (!prv) {
+		/* Only the last allocation could be less than the maximum */
+		table_size = left_pages ? SG_MAX_SINGLE_ALLOC : chunks;
+		ret = sg_alloc_table(sgt, table_size, gfp_mask);
+		if (unlikely(ret))
+			return ERR_PTR(ret);
+	}

 	/* merging chunks and putting them into the scatterlist */
 	cur_page = 0;
-	s = sgt->sgl;
 	for (i = 0; i < chunks; i++) {
 		unsigned int j, chunk_size;

@@ -444,22 +479,82 @@ alloc_from_pages_common(struct sg_table *sgt, struct page **pages,
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
+			/* Adjust entry length to be as before function was
+			 * called
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
-		prv = s;
-		s = sg_next(s);
 	}
-	return prv;
+	sgt->nents = tmp_nents;
+out:
+	return s;
 }

+#ifndef CONFIG_ARCH_NO_SG_CHAIN
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
+	struct sg_table *sgt, struct page **pages, unsigned int n_pages,
+	unsigned int offset, unsigned long size, unsigned int max_segment,
+	gfp_t gfp_mask, struct scatterlist *prv, unsigned int left_pages)
+{
+	return alloc_from_pages_common(sgt, pages, n_pages, offset, size,
+				       max_segment, gfp_mask, prv, left_pages);
+}
+EXPORT_SYMBOL_GPL(sg_alloc_table_append);
+#endif
+
 /**
  * __sg_alloc_table_from_pages - Allocate and initialize an sg table from
  *			         an array of pages
@@ -489,7 +584,7 @@ int __sg_alloc_table_from_pages(struct sg_table *sgt, struct page **pages,
 	struct scatterlist *sg;

 	sg = alloc_from_pages_common(sgt, pages, n_pages, offset, size,
-				     max_segment, gfp_mask);
+				     max_segment, gfp_mask, NULL, 0);
 	return PTR_ERR_OR_ZERO(sg);
 }
 EXPORT_SYMBOL(__sg_alloc_table_from_pages);
--
2.26.2

