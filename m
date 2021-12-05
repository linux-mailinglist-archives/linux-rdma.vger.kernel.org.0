Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBDC4689E3
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Dec 2021 09:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhLEIUz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Dec 2021 03:20:55 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:53123 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhLEIUy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Dec 2021 03:20:54 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id tmi5mYC8yFGqttmi5mmE92; Sun, 05 Dec 2021 09:17:26 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 05 Dec 2021 09:17:26 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] RDMA/irdma: Fix a potential memory allocation issue in 'irdma_prm_add_pble_mem()'
Date:   Sun,  5 Dec 2021 09:17:24 +0100
Message-Id: <5e670b640508e14b1869c3e8e4fb970d78cbe997.1638692171.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

'pchunk->bitmapbuf' is a bitmap. Its size (in number of bits) is stored in
'pchunk->sizeofbitmap'.

When it is allocated, the size (in bytes) is computed by:
   size_in_bits >> 3

There are 2 issues (numbers bellow assume that longs are 64 bits):
   - there is no guarantee here that 'pchunk->bitmapmem.size' is modulo
     BITS_PER_LONG but bitmaps are stored as longs
     (sizeofbitmap=8 bits will only allocate 1 byte, instead of 8 (1 long))

   - the number of bytes is computed with a shift, not a round up, so we
     may allocate less memory than needed
     (sizeofbitmap=65 bits will only allocate 8 bytes (i.e. 1 long), when 2
     longs are needed = 16 bytes)

Fix both issues by using 'bitmap_zalloc()' and remove the useless
'bitmapmem' from 'struct irdma_chunk'.

While at it, remove some useless NULL test before calling
kfree/bitmap_free.

Fixes: 915cc7ac0f8e ("RDMA/irdma: Add miscellaneous utility definitions")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/hw/irdma/pble.c  | 6 ++----
 drivers/infiniband/hw/irdma/pble.h  | 1 -
 drivers/infiniband/hw/irdma/utils.c | 9 ++-------
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/pble.c b/drivers/infiniband/hw/irdma/pble.c
index aeeb1c310965..941dd6310161 100644
--- a/drivers/infiniband/hw/irdma/pble.c
+++ b/drivers/infiniband/hw/irdma/pble.c
@@ -25,8 +25,7 @@ void irdma_destroy_pble_prm(struct irdma_hmc_pble_rsrc *pble_rsrc)
 		list_del(&chunk->list);
 		if (chunk->type == PBLE_SD_PAGED)
 			irdma_pble_free_paged_mem(chunk);
-		if (chunk->bitmapbuf)
-			kfree(chunk->bitmapmem.va);
+		bitmap_free(chunk->bitmapbuf);
 		kfree(chunk->chunkmem.va);
 	}
 }
@@ -299,8 +298,7 @@ add_pble_prm(struct irdma_hmc_pble_rsrc *pble_rsrc)
 	return 0;
 
 error:
-	if (chunk->bitmapbuf)
-		kfree(chunk->bitmapmem.va);
+	bitmap_free(chunk->bitmapbuf);
 	kfree(chunk->chunkmem.va);
 
 	return ret_code;
diff --git a/drivers/infiniband/hw/irdma/pble.h b/drivers/infiniband/hw/irdma/pble.h
index faf71c99e12e..d0d4f2b77d34 100644
--- a/drivers/infiniband/hw/irdma/pble.h
+++ b/drivers/infiniband/hw/irdma/pble.h
@@ -78,7 +78,6 @@ struct irdma_chunk {
 	u32 pg_cnt;
 	enum irdma_alloc_type type;
 	struct irdma_sc_dev *dev;
-	struct irdma_virt_mem bitmapmem;
 	struct irdma_virt_mem chunkmem;
 };
 
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 8b42c43fc14f..981107b40c90 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -2239,15 +2239,10 @@ enum irdma_status_code irdma_prm_add_pble_mem(struct irdma_pble_prm *pprm,
 
 	sizeofbitmap = (u64)pchunk->size >> pprm->pble_shift;
 
-	pchunk->bitmapmem.size = sizeofbitmap >> 3;
-	pchunk->bitmapmem.va = kzalloc(pchunk->bitmapmem.size, GFP_KERNEL);
-
-	if (!pchunk->bitmapmem.va)
+	pchunk->bitmapbuf = bitmap_zalloc(sizeofbitmap, GFP_KERNEL);
+	if (!pchunk->bitmapbuf)
 		return IRDMA_ERR_NO_MEMORY;
 
-	pchunk->bitmapbuf = pchunk->bitmapmem.va;
-	bitmap_zero(pchunk->bitmapbuf, sizeofbitmap);
-
 	pchunk->sizeofbitmap = sizeofbitmap;
 	/* each pble is 8 bytes hence shift by 3 */
 	pprm->total_pble_alloc += pchunk->size >> 3;
-- 
2.30.2

