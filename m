Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F9B2E6CAE
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Dec 2020 01:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgL2AAS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Dec 2020 19:00:18 -0500
Received: from smtp.infotech.no ([82.134.31.41]:59792 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728892AbgL2AAR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Dec 2020 19:00:17 -0500
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Dec 2020 19:00:16 EST
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 2F6E2204269;
        Tue, 29 Dec 2020 00:50:08 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BHB3k8zUEvGN; Tue, 29 Dec 2020 00:50:06 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        by smtp.infotech.no (Postfix) with ESMTPA id 8066620426D;
        Tue, 29 Dec 2020 00:50:03 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com,
        bostroesser@gmail.com, bvanassche@acm.org, ddiss@suse.de
Subject: [PATCH v5 3/4] scatterlist: add sgl_compare_sgl() function
Date:   Mon, 28 Dec 2020 18:49:54 -0500
Message-Id: <20201228234955.190858-4-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201228234955.190858-1-dgilbert@interlog.com>
References: <20201228234955.190858-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

After enabling copies between scatter gather lists (sgl_s), another
storage related operation is to compare two sgl_s. This new function
is modelled on NVMe's Compare command and the SCSI VERIFY(BYTCHK=1)
command. Like memcmp() this function returns false on the first
miscompare and stops comparing.

A helper function called sgl_compare_sgl_idx() is added. It takes an
additional parameter (miscompare_idx) which is a pointer. If that
pointer is non-NULL and a miscompare is detected (i.e. the function
returns false) then the byte index of the first miscompare is written
to *miscomapre_idx. Knowing the location of the first miscompare is
needed to implement the SCSI COMPARE AND WRITE command properly.

Reviewed-by: Bodo Stroesser <bostroesser@gmail.com>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 include/linux/scatterlist.h |   8 +++
 lib/scatterlist.c           | 109 ++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 3f836a3246aa..71be65f9ebb5 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -325,6 +325,14 @@ size_t sgl_copy_sgl(struct scatterlist *d_sgl, unsigned int d_nents, off_t d_ski
 		    struct scatterlist *s_sgl, unsigned int s_nents, off_t s_skip,
 		    size_t n_bytes);
 
+bool sgl_compare_sgl(struct scatterlist *x_sgl, unsigned int x_nents, off_t x_skip,
+		     struct scatterlist *y_sgl, unsigned int y_nents, off_t y_skip,
+		     size_t n_bytes);
+
+bool sgl_compare_sgl_idx(struct scatterlist *x_sgl, unsigned int x_nents, off_t x_skip,
+			 struct scatterlist *y_sgl, unsigned int y_nents, off_t y_skip,
+			 size_t n_bytes, size_t *miscompare_idx);
+
 /*
  * Maximum number of entries that will be allocated in one piece, if
  * a list larger than this is required then chaining will be utilized.
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index af9cd7b9dc19..9332365e7eb6 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -1134,3 +1134,112 @@ size_t sgl_copy_sgl(struct scatterlist *d_sgl, unsigned int d_nents, off_t d_ski
 	return offset;
 }
 EXPORT_SYMBOL(sgl_copy_sgl);
+
+/**
+ * sgl_compare_sgl_idx - Compare x and y (both sgl_s)
+ * @x_sgl:		 x (left) sgl
+ * @x_nents:		 Number of SG entries in x (left) sgl
+ * @x_skip:		 Number of bytes to skip in x (left) before starting
+ * @y_sgl:		 y (right) sgl
+ * @y_nents:		 Number of SG entries in y (right) sgl
+ * @y_skip:		 Number of bytes to skip in y (right) before starting
+ * @n_bytes:		 The (maximum) number of bytes to compare
+ * @miscompare_idx:	 if return is false, index of first miscompare written
+ *			 to this pointer (if non-NULL). Value will be < n_bytes
+ *
+ * Returns:
+ *   true if x and y compare equal before x, y or n_bytes is exhausted.
+ *   Otherwise on a miscompare, returns false (and stops comparing). If return
+ *   is false and miscompare_idx is non-NULL, then index of first miscompared
+ *   byte written to *miscompare_idx.
+ *
+ * Notes:
+ *   x and y are symmetrical: they can be swapped and the result is the same.
+ *
+ *   Implementation is based on memcmp(). x and y segments may overlap.
+ *
+ *   The notes in sgl_copy_sgl() about large sgl_s _applies here as well.
+ *
+ **/
+bool sgl_compare_sgl_idx(struct scatterlist *x_sgl, unsigned int x_nents, off_t x_skip,
+			 struct scatterlist *y_sgl, unsigned int y_nents, off_t y_skip,
+			 size_t n_bytes, size_t *miscompare_idx)
+{
+	bool equ = true;
+	size_t len;
+	size_t offset = 0;
+	struct sg_mapping_iter x_iter, y_iter;
+
+	if (n_bytes == 0)
+		return true;
+	sg_miter_start(&x_iter, x_sgl, x_nents, SG_MITER_ATOMIC | SG_MITER_FROM_SG);
+	sg_miter_start(&y_iter, y_sgl, y_nents, SG_MITER_ATOMIC | SG_MITER_FROM_SG);
+	if (!sg_miter_skip(&x_iter, x_skip))
+		goto fini;
+	if (!sg_miter_skip(&y_iter, y_skip))
+		goto fini;
+
+	while (offset < n_bytes) {
+		if (!sg_miter_next(&x_iter))
+			break;
+		if (!sg_miter_next(&y_iter))
+			break;
+		len = min3(x_iter.length, y_iter.length, n_bytes - offset);
+
+		equ = !memcmp(x_iter.addr, y_iter.addr, len);
+		if (!equ)
+			goto fini;
+		offset += len;
+		/* LIFO order is important when SG_MITER_ATOMIC is used */
+		y_iter.consumed = len;
+		sg_miter_stop(&y_iter);
+		x_iter.consumed = len;
+		sg_miter_stop(&x_iter);
+	}
+fini:
+	if (miscompare_idx && !equ) {
+		u8 *xp = x_iter.addr;
+		u8 *yp = y_iter.addr;
+		u8 *x_endp;
+
+		for (x_endp = xp + len ; xp < x_endp; ++xp, ++yp) {
+			if (*xp != *yp)
+				break;
+		}
+		*miscompare_idx = offset + len - (x_endp - xp);
+	}
+	sg_miter_stop(&y_iter);
+	sg_miter_stop(&x_iter);
+	return equ;
+}
+EXPORT_SYMBOL(sgl_compare_sgl_idx);
+
+/**
+ * sgl_compare_sgl - Compare x and y (both sgl_s)
+ * @x_sgl:		 x (left) sgl
+ * @x_nents:		 Number of SG entries in x (left) sgl
+ * @x_skip:		 Number of bytes to skip in x (left) before starting
+ * @y_sgl:		 y (right) sgl
+ * @y_nents:		 Number of SG entries in y (right) sgl
+ * @y_skip:		 Number of bytes to skip in y (right) before starting
+ * @n_bytes:		 The (maximum) number of bytes to compare
+ *
+ * Returns:
+ *   true if x and y compare equal before x, y or n_bytes is exhausted.
+ *   Otherwise on a miscompare, returns false (and stops comparing).
+ *
+ * Notes:
+ *   x and y are symmetrical: they can be swapped and the result is the same.
+ *
+ *   Implementation is based on memcmp(). x and y segments may overlap.
+ *
+ *   The notes in sgl_copy_sgl() about large sgl_s _applies here as well.
+ *
+ **/
+bool sgl_compare_sgl(struct scatterlist *x_sgl, unsigned int x_nents, off_t x_skip,
+		     struct scatterlist *y_sgl, unsigned int y_nents, off_t y_skip,
+		     size_t n_bytes)
+{
+	return sgl_compare_sgl_idx(x_sgl, x_nents, x_skip, y_sgl, y_nents, y_skip, n_bytes, NULL);
+}
+EXPORT_SYMBOL(sgl_compare_sgl);
-- 
2.25.1

