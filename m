Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286E82FA667
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 17:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405937AbhARQbO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 11:31:14 -0500
Received: from smtp.infotech.no ([82.134.31.41]:45718 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406725AbhARQbH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 Jan 2021 11:31:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 73FE92042B2;
        Mon, 18 Jan 2021 17:30:21 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id biqWdKW9SgrG; Mon, 18 Jan 2021 17:30:17 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        by smtp.infotech.no (Postfix) with ESMTPA id 6C149204278;
        Mon, 18 Jan 2021 17:30:14 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com,
        bostroesser@gmail.com, ddiss@suse.de, bvanassche@acm.org,
        jgg@ziepe.ca
Subject: [PATCH v6 1/4] sgl_alloc_order: remove 4 GiB limit, sgl_free() warning
Date:   Mon, 18 Jan 2021 11:30:03 -0500
Message-Id: <20210118163006.61659-2-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118163006.61659-1-dgilbert@interlog.com>
References: <20210118163006.61659-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch fixes a check done by sgl_alloc_order() before it starts
any allocations. The comment in the original said: "Check for integer
overflow" but the check itself contained an integer overflow! The
right hand side (rhs) of the expression in the condition is resolved
as u32 so it could not exceed UINT32_MAX (4 GiB) which means 'length'
could not exceed that value. If that was the intention then the
comment above it could be dropped and the condition rewritten more
clearly as:
     if (length > UINT32_MAX) <<failure path >>;

After several flawed attempts to detect overflow, take the fastest
route by stating as a pre-condition that the 'order' function argument
cannot exceed 16 (2^16 * 4k = 256 MiB).

This function may be used to replace vmalloc(unsigned long) for a
large allocation (e.g. a ramdisk). vmalloc has no limit at 4 GiB so
it seems unreasonable that:
    sgl_alloc_order(unsigned long long length, ....)
does. sgl_s made with sgl_alloc_order() have equally sized segments
placed in a scatter gather array. That allows O(1) navigation around
a big sgl using some simple integer arithmetic.

Revise some of this function's description to more accurately reflect
what this function is doing.

An earlier patch fixed a memory leak in sg_alloc_order() due to the
misuse of sgl_free(). Take the opportunity to put a one line comment
above sgl_free()'s declaration warning that it is not suitable when
order > 0 .

Reviewed-by: Bodo Stroesser <bostroesser@gmail.com>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 include/linux/scatterlist.h |  1 +
 lib/scatterlist.c           | 21 ++++++++++-----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 6f70572b2938..8adff41f7cfa 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -302,6 +302,7 @@ struct scatterlist *sgl_alloc(unsigned long long length, gfp_t gfp,
 			      unsigned int *nent_p);
 void sgl_free_n_order(struct scatterlist *sgl, int nents, int order);
 void sgl_free_order(struct scatterlist *sgl, int order);
+/* Only use sgl_free() when order is 0 */
 void sgl_free(struct scatterlist *sgl);
 #endif /* CONFIG_SGL_ALLOC */
 
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index a59778946404..24ea2d31a405 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -554,13 +554,16 @@ EXPORT_SYMBOL(sg_alloc_table_from_pages);
 #ifdef CONFIG_SGL_ALLOC
 
 /**
- * sgl_alloc_order - allocate a scatterlist and its pages
+ * sgl_alloc_order - allocate a scatterlist with equally sized elements each
+ *		     of which has 2^@order continuous pages
  * @length: Length in bytes of the scatterlist. Must be at least one
- * @order: Second argument for alloc_pages()
+ * @order: Second argument for alloc_pages(). Each sgl element size will
+ *	   be (PAGE_SIZE*2^@order) bytes. @order must not exceed 16.
  * @chainable: Whether or not to allocate an extra element in the scatterlist
- *	for scatterlist chaining purposes
+ *	       for scatterlist chaining purposes
  * @gfp: Memory allocation flags
- * @nent_p: [out] Number of entries in the scatterlist that have pages
+ * @nent_p: [out] Number of entries in the scatterlist that have pages.
+ *		  Ignored if NULL is given.
  *
  * Returns: A pointer to an initialized scatterlist or %NULL upon failure.
  */
@@ -574,15 +577,11 @@ struct scatterlist *sgl_alloc_order(unsigned long long length,
 	u32 elem_len;
 
 	nent = round_up(length, PAGE_SIZE << order) >> (PAGE_SHIFT + order);
-	/* Check for integer overflow */
-	if (length > (nent << (PAGE_SHIFT + order)))
-		return NULL;
-	nalloc = nent;
 	if (chainable) {
-		/* Check for integer overflow */
-		if (nalloc + 1 < nalloc)
+		if (check_add_overflow(nent, 1U, &nalloc))
 			return NULL;
-		nalloc++;
+	} else {
+		nalloc = nent;
 	}
 	sgl = kmalloc_array(nalloc, sizeof(struct scatterlist),
 			    gfp & ~GFP_DMA);
-- 
2.25.1

