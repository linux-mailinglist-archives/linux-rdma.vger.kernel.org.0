Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6F025C490
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 17:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgICPMW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 11:12:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728780AbgICMTM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Sep 2020 08:19:12 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C2F52080C;
        Thu,  3 Sep 2020 12:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599135550;
        bh=EqZip+goR+5awnnI2IDwhvizx4xvBn+BOYOOIR6lftA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HIWv5qOGInv4AP9/E9dMU30j8LcbRpTVF14QtM+ehQwAikV9VBScwUWXwCArgvk6O
         l3oWgjmLSqVtgcxBUBWvCPhRNtg4JksNnx1lc/D/be32v4x4l6FeqThRFKS7g3zVie
         XlNHcNaeM/2lssL/LNML43QJF3/HwHYbZdBfQaPo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 3/4] lib/scatterlist: Add support in dynamic allocation of SG table from pages
Date:   Thu,  3 Sep 2020 15:18:52 +0300
Message-Id: <20200903121853.1145976-4-leon@kernel.org>
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
 include/linux/scatterlist.h |  10 +++
 lib/scatterlist.c           | 131 ++++++++++++++++++++++++++++++++----
 2 files changed, 128 insertions(+), 13 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 877d6e160b06..b4450e3c3f88 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -45,6 +45,11 @@ struct sg_table {
 	unsigned int orig_nents;	/* original size of list */
 };

+struct sg_append {
+	struct scatterlist *prv; /* Previous entry to append */
+	unsigned int left_pages; /* Left pages to add to table */
+};
+
 /*
  * Notes on SG table design.
  *
@@ -291,6 +296,11 @@ void sg_free_table(struct sg_table *);
 int __sg_alloc_table(struct sg_table *, unsigned int, unsigned int,
 		     struct scatterlist *, unsigned int, gfp_t, sg_alloc_fn *);
 int sg_alloc_table(struct sg_table *, unsigned int, gfp_t);
+struct scatterlist *
+sg_alloc_table_append(struct sg_table *sgt, struct page **pages,
+		      unsigned int n_pages, unsigned int offset,
+		      unsigned long size, unsigned int max_segment,
+		      gfp_t gfp_mask, struct sg_append *append);
 int __sg_alloc_table_from_pages(struct sg_table *sgt, struct page **pages,
 				unsigned int n_pages, unsigned int offset,
 				unsigned long size, unsigned int max_segment,
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 669bd6e6d16a..c16a4eebaa0b 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -403,19 +403,56 @@ int sg_alloc_table(struct sg_table *table, unsigned int nents, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(sg_alloc_table);

+static struct scatterlist *get_next_sg(struct sg_table *table,
+				       struct scatterlist *prv,
+				       unsigned long left_npages,
+				       gfp_t gfp_mask)
+{
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
 static struct scatterlist *
 alloc_from_pages_common(struct sg_table *sgt, struct page **pages,
 			unsigned int n_pages, unsigned int offset,
 			unsigned long size, unsigned int max_segment,
-			gfp_t gfp_mask)
+			gfp_t gfp_mask, struct sg_append *append)
 {
-	unsigned int chunks, cur_page, seg_len, i;
-	struct scatterlist *prv, *s = NULL;
+	unsigned int chunks, cur_page, seg_len, i, prv_len = 0;
+	unsigned int tmp_nents = sgt->nents;
+	struct scatterlist *s, *prv = NULL;
+	unsigned int table_size, left = 0;
 	int ret;

 	if (WARN_ON(!max_segment || offset_in_page(max_segment)))
 		return ERR_PTR(-EINVAL);

+	if (append) {
+		prv = append->prv;
+		left = append->left_pages;
+		if (prv &&
+		    page_to_pfn(sg_page(prv)) + (prv->length >> PAGE_SHIFT) ==
+			    page_to_pfn(pages[0]))
+			prv_len = prv->length;
+	}
+
 	/* compute number of contiguous chunks */
 	chunks = 1;
 	seg_len = 0;
@@ -428,13 +465,16 @@ alloc_from_pages_common(struct sg_table *sgt, struct page **pages,
 		}
 	}

-	ret = sg_alloc_table(sgt, chunks, gfp_mask);
-	if (unlikely(ret))
-		return ERR_PTR(ret);
+	if (!prv) {
+		/* Only the last allocation could be less than the maximum */
+		table_size = left ? SG_MAX_SINGLE_ALLOC : chunks;
+		ret = sg_alloc_table(sgt, table_size, gfp_mask);
+		if (unlikely(ret))
+			return ERR_PTR(ret);
+	}

 	/* merging chunks and putting them into the scatterlist */
 	cur_page = 0;
-	s = sgt->sgl;
 	for (i = 0; i < chunks; i++) {
 		unsigned int j, chunk_size;

@@ -444,21 +484,86 @@ alloc_from_pages_common(struct sg_table *sgt, struct page **pages,
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
+				s = prv;
+				sg_set_page(s, sg_page(s),
+					    s->length + chunk_size, s->offset);
+				goto next;
+			}
+		}
+
+		/* Pass how many chunks might left */
+		s = get_next_sg(sgt, prv, chunks - i + left, gfp_mask);
+		if (IS_ERR(s)) {
+			/* Adjust entry length to be as before function was
+			 * called
+			 */
+			if (prv_len)
+				append->prv->length = prv_len;
+			goto out;
+		}
+		sg_set_page(s, pages[cur_page], chunk_size, offset);
+		tmp_nents++;
+next:
 		size -= chunk_size;
 		offset = 0;
 		cur_page = j;
 		prv = s;
-		s = sg_next(s);
 	}
-	return prv;
+	sgt->nents = tmp_nents;
+out:
+	return s;
+}
+
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
+ * @append:	 Used to append pages to last entry in sgt
+ *
+ *  Description:
+ *    If prv field in @append is NULL, it allocates and initialize an sg table
+ *    from a list of pages. Contiguous ranges of the pages are squashed into a
+ *    single scatterlist node up to the maximum size specified in @max_segment.
+ *    A user may provide an offset at a start and a size of valid data in a buffer
+ *    specified by the page array. A user may provide @append to chain pages to
+ *    last entry in sgt.
+ *    The returned sg table is released by sg_free_table.
+ *
+ * Returns:
+ *   Last SGE in sgt on success, negative error on failure.
+ *
+ * Notes:
+ *   If this function returns non-0 (eg failure), the caller must call
+ *   sg_free_table() to cleanup any leftover allocations.
+ */
+struct scatterlist *
+sg_alloc_table_append(struct sg_table *sgt, struct page **pages,
+		      unsigned int n_pages, unsigned int offset,
+		      unsigned long size, unsigned int max_segment,
+		      gfp_t gfp_mask, struct sg_append *append)
+{
+#ifdef CONFIG_ARCH_NO_SG_CHAIN
+	if (append->left_pages)
+		return ERR_PTR(-EOPNOTSUPP);
+#endif
+	return alloc_from_pages_common(sgt, pages, n_pages, offset, size,
+				       max_segment, gfp_mask, append);
 }
+EXPORT_SYMBOL(sg_alloc_table_append);

 /**
  * __sg_alloc_table_from_pages - Allocate and initialize an sg table from
@@ -489,7 +594,7 @@ int __sg_alloc_table_from_pages(struct sg_table *sgt, struct page **pages,
 	struct scatterlist *sg;

 	sg = alloc_from_pages_common(sgt, pages, n_pages, offset, size,
-				     max_segment, gfp_mask);
+				     max_segment, gfp_mask, NULL);
 	return PTR_ERR_OR_ZERO(sg);
 }
 EXPORT_SYMBOL(__sg_alloc_table_from_pages);
--
2.26.2

