Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464132FA649
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 17:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406757AbhARQbv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 11:31:51 -0500
Received: from smtp.infotech.no ([82.134.31.41]:45763 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbhARQbs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 Jan 2021 11:31:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 55D67204295;
        Mon, 18 Jan 2021 17:30:32 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hNUSQtqmjh3E; Mon, 18 Jan 2021 17:30:28 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        by smtp.infotech.no (Postfix) with ESMTPA id 666E4204279;
        Mon, 18 Jan 2021 17:30:25 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com,
        bostroesser@gmail.com, ddiss@suse.de, bvanassche@acm.org,
        jgg@ziepe.ca
Subject: [PATCH v6 4/4] scatterlist: add sgl_memset()
Date:   Mon, 18 Jan 2021 11:30:06 -0500
Message-Id: <20210118163006.61659-5-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118163006.61659-1-dgilbert@interlog.com>
References: <20210118163006.61659-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The existing sg_zero_buffer() function is a bit restrictive. For
example protection information (PI) blocks are usually initialized
to 0xff bytes. As its name suggests sgl_memset() is modelled on
memset(). One difference is the type of the val argument which is
u8 rather than int. Plus it returns the number of bytes (over)written.

Change implementation of sg_zero_buffer() to call this new function.

Reviewed-by: Bodo Stroesser <bostroesser@gmail.com>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 include/linux/scatterlist.h | 20 +++++++++-
 lib/scatterlist.c           | 79 +++++++++++++++++++++----------------
 2 files changed, 62 insertions(+), 37 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 71be65f9ebb5..69e87280b44d 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -318,8 +318,6 @@ size_t sg_pcopy_from_buffer(struct scatterlist *sgl, unsigned int nents,
 			    const void *buf, size_t buflen, off_t skip);
 size_t sg_pcopy_to_buffer(struct scatterlist *sgl, unsigned int nents,
 			  void *buf, size_t buflen, off_t skip);
-size_t sg_zero_buffer(struct scatterlist *sgl, unsigned int nents,
-		       size_t buflen, off_t skip);
 
 size_t sgl_copy_sgl(struct scatterlist *d_sgl, unsigned int d_nents, off_t d_skip,
 		    struct scatterlist *s_sgl, unsigned int s_nents, off_t s_skip,
@@ -333,6 +331,24 @@ bool sgl_compare_sgl_idx(struct scatterlist *x_sgl, unsigned int x_nents, off_t
 			 struct scatterlist *y_sgl, unsigned int y_nents, off_t y_skip,
 			 size_t n_bytes, size_t *miscompare_idx);
 
+size_t sgl_memset(struct scatterlist *sgl, unsigned int nents, off_t skip,
+		  u8 val, size_t n_bytes);
+
+/**
+ * sg_zero_buffer - Zero-out a part of a SG list
+ * @sgl:		The SG list
+ * @nents:		Number of SG entries
+ * @buflen:		The number of bytes to zero out
+ * @skip:		Number of bytes to skip before zeroing
+ *
+ * Returns the number of bytes zeroed.
+ **/
+static inline size_t sg_zero_buffer(struct scatterlist *sgl, unsigned int nents,
+				    size_t buflen, off_t skip)
+{
+	return sgl_memset(sgl, nents, skip, 0, buflen);
+}
+
 /*
  * Maximum number of entries that will be allocated in one piece, if
  * a list larger than this is required then chaining will be utilized.
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index e3182de753d0..7e6acc67e9f6 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -1023,41 +1023,6 @@ size_t sg_pcopy_to_buffer(struct scatterlist *sgl, unsigned int nents,
 }
 EXPORT_SYMBOL(sg_pcopy_to_buffer);
 
-/**
- * sg_zero_buffer - Zero-out a part of a SG list
- * @sgl:		 The SG list
- * @nents:		 Number of SG entries
- * @buflen:		 The number of bytes to zero out
- * @skip:		 Number of bytes to skip before zeroing
- *
- * Returns the number of bytes zeroed.
- **/
-size_t sg_zero_buffer(struct scatterlist *sgl, unsigned int nents,
-		       size_t buflen, off_t skip)
-{
-	unsigned int offset = 0;
-	struct sg_mapping_iter miter;
-	unsigned int sg_flags = SG_MITER_ATOMIC | SG_MITER_TO_SG;
-
-	sg_miter_start(&miter, sgl, nents, sg_flags);
-
-	if (!sg_miter_skip(&miter, skip))
-		return false;
-
-	while (offset < buflen && sg_miter_next(&miter)) {
-		unsigned int len;
-
-		len = min(miter.length, buflen - offset);
-		memset(miter.addr, 0, len);
-
-		offset += len;
-	}
-
-	sg_miter_stop(&miter);
-	return offset;
-}
-EXPORT_SYMBOL(sg_zero_buffer);
-
 /**
  * sgl_copy_sgl - Copy over a destination sgl from a source sgl
  * @d_sgl:		 Destination sgl
@@ -1240,3 +1205,47 @@ bool sgl_compare_sgl(struct scatterlist *x_sgl, unsigned int x_nents, off_t x_sk
 	return sgl_compare_sgl_idx(x_sgl, x_nents, x_skip, y_sgl, y_nents, y_skip, n_bytes, NULL);
 }
 EXPORT_SYMBOL(sgl_compare_sgl);
+
+/**
+ * sgl_memset - set byte 'val' up to n_bytes times on SG list
+ * @sgl:		 The SG list
+ * @nents:		 Number of SG entries in sgl
+ * @skip:		 Number of bytes to skip before starting
+ * @val:		 byte value to write to sgl
+ * @n_bytes:		 The (maximum) number of bytes to modify
+ *
+ * Returns:
+ *   The number of bytes written.
+ *
+ * Notes:
+ *   Stops writing if either sgl or n_bytes is exhausted. If n_bytes is
+ *   set SIZE_MAX then val will be written to each byte until the end
+ *   of sgl.
+ *
+ *   The notes in sgl_copy_sgl() about large sgl_s _applies here as well.
+ *
+ **/
+size_t sgl_memset(struct scatterlist *sgl, unsigned int nents, off_t skip,
+		  u8 val, size_t n_bytes)
+{
+	size_t offset = 0;
+	size_t len;
+	struct sg_mapping_iter miter;
+
+	if (n_bytes == 0)
+		return 0;
+	sg_miter_start(&miter, sgl, nents, SG_MITER_ATOMIC | SG_MITER_TO_SG);
+	if (!sg_miter_skip(&miter, skip))
+		goto fini;
+
+	while ((offset < n_bytes) && sg_miter_next(&miter)) {
+		len = min(miter.length, n_bytes - offset);
+		memset(miter.addr, val, len);
+		offset += len;
+	}
+fini:
+	sg_miter_stop(&miter);
+	return offset;
+}
+EXPORT_SYMBOL(sgl_memset);
+
-- 
2.25.1

