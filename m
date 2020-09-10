Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E599A265363
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Sep 2020 23:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgIJVeJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Sep 2020 17:34:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730969AbgIJNuh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Sep 2020 09:50:37 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 650802087C;
        Thu, 10 Sep 2020 13:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599745389;
        bh=L6Pwk1G4hd01vHxA+aaPHpUX0cbjzQBKCHd1njAkuCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NvRGoFeZg5m3DaigbaVJIP02BbNArfgR+pYt7l6wsKtrG/I+w/uzD5s8hEdKsJykF
         X66mLVf97oFa1itJNqbdnuMfzW+6D3Z4L5O7PTCZuoYyP+VbN8xMGpD9qyZCdGxqL/
         hhYf+ExVkqmVo/QeSwty0rNFK7d9120dqB20spvI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 1/4] lib/scatterlist: Refactor sg_alloc_table_from_pages
Date:   Thu, 10 Sep 2020 16:42:56 +0300
Message-Id: <20200910134259.1304543-2-leon@kernel.org>
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

Currently, sg_alloc_table_from_pages doesn't support dynamic chaining of
SG entries. Therefore it requires from user to allocate all the pages in
advance and hold them in a large buffer. Such a buffer consumes a lot of
temporary memory in HPC systems which do a very large memory registration.

The next patches introduce API for dynamically allocation from pages and
it requires us to do the following:
 * Extract the code to alloc_from_pages_common.
 * Change the build of the table to iterate on the chunks and not on the
   SGEs. It will allow dynamic allocation of more SGEs.

Since sg_alloc_table_from_pages allocate exactly the number of chunks,
therefore chunks are equal to the number of SG entries.

Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 lib/scatterlist.c | 75 ++++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 30 deletions(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 5d63a8857f36..292e785d21ee 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -365,38 +365,18 @@ int sg_alloc_table(struct sg_table *table, unsigned int nents, gfp_t gfp_mask)
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
+static struct scatterlist *
+alloc_from_pages_common(struct sg_table *sgt, struct page **pages,
+			unsigned int n_pages, unsigned int offset,
+			unsigned long size, unsigned int max_segment,
+			gfp_t gfp_mask)
 {
 	unsigned int chunks, cur_page, seg_len, i;
+	struct scatterlist *prv, *s = NULL;
 	int ret;
-	struct scatterlist *s;

 	if (WARN_ON(!max_segment || offset_in_page(max_segment)))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);

 	/* compute number of contiguous chunks */
 	chunks = 1;
@@ -412,11 +392,12 @@ int __sg_alloc_table_from_pages(struct sg_table *sgt, struct page **pages,

 	ret = sg_alloc_table(sgt, chunks, gfp_mask);
 	if (unlikely(ret))
-		return ret;
+		return ERR_PTR(ret);

 	/* merging chunks and putting them into the scatterlist */
 	cur_page = 0;
-	for_each_sg(sgt->sgl, s, sgt->orig_nents, i) {
+	s = sgt->sgl;
+	for (i = 0; i < chunks; i++) {
 		unsigned int j, chunk_size;

 		/* look for the end of the current chunk */
@@ -435,9 +416,43 @@ int __sg_alloc_table_from_pages(struct sg_table *sgt, struct page **pages,
 		size -= chunk_size;
 		offset = 0;
 		cur_page = j;
+		prv = s;
+		s = sg_next(s);
 	}
+	return prv;
+}

-	return 0;
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
+				     max_segment, gfp_mask);
+	return PTR_ERR_OR_ZERO(sg);
 }
 EXPORT_SYMBOL(__sg_alloc_table_from_pages);

--
2.26.2

