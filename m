Return-Path: <linux-rdma+bounces-15609-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D52AD2ABDE
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 04:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD7563038000
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 03:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAB7340DAD;
	Fri, 16 Jan 2026 03:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="L0F8KqGN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B8B29A1;
	Fri, 16 Jan 2026 03:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768534163; cv=none; b=UKO29aeG6nrejr5qYc9bihCCWWVGjDBGb5mU+0uCO9ZCiUY10BC7LrspoCEa+VgvIgcoPv8EtNAOcMwRqpBKb9mESYwA5CpTRvW8dMXpgQAkVR0H4J3MUpTCjJUjyoMitAbO1f1XuxEImtYEw/IvzKJmusTg6pCsLHAHPDcZwH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768534163; c=relaxed/simple;
	bh=jJFMFlrDbkTj3lL5/H5NmYgSgaUw1QoVTxFsq8B/OX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PckNS5cQTgmc5kHcK2qpF3Q4p2NX5fAJATzHpNwyOrfcySO0trceDuVSMBuoi/HcTyCRoNeheH7Q7EhP+Oiet7Baqxhq5qkJAhR7+c2WUNuQlGilbL5vH5pdSp2Cj2olDV0LTe5wnxJYPD/5bY3vefoydADNyp/Z8/BKr5xRWIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=L0F8KqGN; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1768534161; x=1800070161;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jJFMFlrDbkTj3lL5/H5NmYgSgaUw1QoVTxFsq8B/OX0=;
  b=L0F8KqGNqZjg0JA/8RViIDicKOH1Uw+IWFEdohb0k4cY49Q3mRwqZoqM
   xLaXJa4ehJkBoabRZniiTJ2rehBNM1PQM575I/MQFqTkssDqybLP/5Miw
   JNHiNfiVSk+Cmd9Jspllm7vwIr9wjwLHZJlKPRgaZhNvG5rhw/orGMd0X
   MT4gaJf9dTMkEAnwBCZlhjhjzfdUxtkYY4T7/Yj6xRxUNoZB8ekhevvX4
   er5bP7bqhQdJmi41xJy+0R8WIj+pW32viGSUBVrSq6mqP6hhikBTjBfPb
   Jqt2GWAuSAjnYuA1gF+b0zhWwrghLrfBNsYbmembnAGdVaPHCwL8qtY2X
   A==;
X-CSE-ConnectionGUID: VzktKVCjTUyGLUsR0PHpQQ==
X-CSE-MsgGUID: tBk9SZnTSEOCDNFTwMZrOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="214580106"
X-IronPort-AV: E=Sophos;i="6.21,230,1763391600"; 
   d="scan'208";a="214580106"
Received: from unknown (HELO az2uksmgr1.o.css.fujitsu.com) ([52.151.125.128])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 12:28:10 +0900
Received: from az2uksmgm1.o.css.fujitsu.com (unknown [10.151.22.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgr1.o.css.fujitsu.com (Postfix) with ESMTPS id 95E7B1C1C70F;
	Fri, 16 Jan 2026 03:28:09 +0000 (UTC)
Received: from az2nlsmom4.fujitsu.com (az2nlsmom4.o.css.fujitsu.com [10.150.26.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm1.o.css.fujitsu.com (Postfix) with ESMTPS id 45D6E896E32;
	Fri, 16 Jan 2026 03:28:09 +0000 (UTC)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.135.44])
	by az2nlsmom4.fujitsu.com (Postfix) with ESMTP id 203E42004F87;
	Fri, 16 Jan 2026 03:28:04 +0000 (UTC)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH RFC v2] RDMA/rxe: Fix iova-to-va conversion for MR page sizes != PAGE_SIZE
Date: Fri, 16 Jan 2026 11:27:53 +0800
Message-ID: <20260116032753.2574363-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation incorrectly handles memory regions (MRs) with
page sizes different from the system PAGE_SIZE. The core issue is that
rxe_set_page() is called with mr->page_size step increments, but the
page_list stores individual struct page pointers, each representing
PAGE_SIZE of memory.

ib_sg_to_page() has ensured that when i>=1 either
a) SG[i-1].dma_end and SG[i].dma_addr are contiguous
or
b) SG[i-1].dma_end and SG[i].dma_addr are mr->page_size aligned.

This leads to incorrect iova-to-va conversion in scenarios:

1) page_size < PAGE_SIZE (e.g., MR: 4K, system: 64K):
   ibmr->iova = 0x181800
   sg[0]: dma_addr=0x181800, len=0x800
   sg[1]: dma_addr=0x173000, len=0x1000

   Access iova = 0x181800 + 0x810 = 0x182010
   Expected VA: 0x173010 (second SG, offset 0x10)
   Before fix:
     - index = (0x182010 >> 12) - (0x181800 >> 12) = 1
     - page_offset = 0x182010 & 0xFFF = 0x10
     - xarray[1] stores system page base 0x170000
     - Resulting VA: 0x170000 + 0x10 = 0x170010 (wrong)

2) page_size > PAGE_SIZE (e.g., MR: 64K, system: 4K):
   ibmr->iova = 0x18f800
   sg[0]: dma_addr=0x18f800, len=0x800
   sg[1]: dma_addr=0x170000, len=0x1000

   Access iova = 0x18f800 + 0x810 = 0x190010
   Expected VA: 0x170010 (second SG, offset 0x10)
   Before fix:
     - index = (0x190010 >> 16) - (0x18f800 >> 16) = 1
     - page_offset = 0x190010 & 0xFFFF = 0x10
     - xarray[1] stores system page for dma_addr 0x170000
     - Resulting VA: system page of 0x170000 + 0x10 = 0x170010 (wrong)

Yi Zhang reported a kernel panic[1] years ago related to this defect.

Solution:
1. Replace xarray with pre-allocated rxe_mr_page array for sequential
   indexing (all MR page indices are contiguous)
2. Each rxe_mr_page stores both struct page* and offset within the
   system page
3. Handle MR page_size != PAGE_SIZE relationships:
   - page_size > PAGE_SIZE: Split MR pages into multiple system pages
   - page_size <= PAGE_SIZE: Store offset within system page
4. Add boundary checks and compatibility validation

This ensures correct iova-to-va conversion regardless of MR page size
and system PAGE_SIZE relationship, while improving performance through
array-based sequential access.

Tests on 4K and 64K PAGE_SIZE hosts:
- rdma-core/pytests
  $ ./build/bin/run_tests.py  --dev eth0_rxe
- blktest:
  $ TIMEOUT=30 QUICK_RUN=1 USE_RXE=1 NVMET_TRTYPES=rdma ./check nvme srp rnbd

[1] https://lore.kernel.org/all/CAHj4cs9XRqE25jyVw9rj9YugffLn5+f=1znaBEnu1usLOciD+g@mail.gmail.com/T/
Fixes: 592627ccbdff ("RDMA/rxe: Replace rxe_map and rxe_phys_buf by xarray")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

---
If this patch is too huge, it can be split it to 'convert xarray to normal array' first.

V2:
 - convert xarray to normal array because all MR page indices are contiguous
 - Fix cases in 2+ SG entries and their dma_addr is not contiguous
 - Resize page_info to (num_buf * system_page_per_mr) if needed
 - remove set_page_per_mr(), unify back to rxe_set_page()
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 281 +++++++++++++++++---------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  10 +-
 2 files changed, 194 insertions(+), 97 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 05710d785a7e..c71ab780e379 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -72,14 +72,46 @@ void rxe_mr_init_dma(int access, struct rxe_mr *mr)
 	mr->ibmr.type = IB_MR_TYPE_DMA;
 }
 
+/*
+ * Convert iova to page_info index. The page_info stores pages of size
+ * PAGE_SIZE, but MRs can have different page sizes. This function
+ * handles the conversion for all cases:
+ *
+ * 1. mr->page_size > PAGE_SIZE:
+ *    The MR's iova may not be aligned to mr->page_size. We use the
+ *    aligned base (iova & page_mask) as reference, then calculate
+ *    which PAGE_SIZE sub-page the iova falls into.
+ *
+ * 2. mr->page_size <= PAGE_SIZE:
+ *    Use simple shift arithmetic since each page_info entry corresponds
+ *    to one or more MR pages.
+ */
 static unsigned long rxe_mr_iova_to_index(struct rxe_mr *mr, u64 iova)
 {
-	return (iova >> mr->page_shift) - (mr->ibmr.iova >> mr->page_shift);
+	int idx;
+
+	if (mr_page_size(mr) > PAGE_SIZE)
+		idx = (iova - (mr->ibmr.iova & mr->page_mask)) >> PAGE_SHIFT;
+	else
+		idx = (iova >> mr->page_shift) -
+			(mr->ibmr.iova >> mr->page_shift);
+
+	WARN_ON(idx >= mr->nbuf);
+	return idx;
 }
 
+/*
+ * Convert iova to offset within the page_info entry.
+ *
+ * For mr_page_size > PAGE_SIZE, the offset is within the system page.
+ * For mr_page_size <= PAGE_SIZE, the offset is within the MR page size.
+ */
 static unsigned long rxe_mr_iova_to_page_offset(struct rxe_mr *mr, u64 iova)
 {
-	return iova & (mr_page_size(mr) - 1);
+	if (mr_page_size(mr) > PAGE_SIZE)
+		return iova & (PAGE_SIZE - 1);
+	else
+		return iova & (mr_page_size(mr) - 1);
 }
 
 static bool is_pmem_page(struct page *pg)
@@ -93,37 +125,69 @@ static bool is_pmem_page(struct page *pg)
 
 static int rxe_mr_fill_pages_from_sgt(struct rxe_mr *mr, struct sg_table *sgt)
 {
-	XA_STATE(xas, &mr->page_list, 0);
 	struct sg_page_iter sg_iter;
 	struct page *page;
 	bool persistent = !!(mr->access & IB_ACCESS_FLUSH_PERSISTENT);
 
+	WARN_ON(mr_page_size(mr) != PAGE_SIZE);
+
 	__sg_page_iter_start(&sg_iter, sgt->sgl, sgt->orig_nents, 0);
 	if (!__sg_page_iter_next(&sg_iter))
 		return 0;
 
-	do {
-		xas_lock(&xas);
-		while (true) {
-			page = sg_page_iter_page(&sg_iter);
-
-			if (persistent && !is_pmem_page(page)) {
-				rxe_dbg_mr(mr, "Page can't be persistent\n");
-				xas_set_err(&xas, -EINVAL);
-				break;
-			}
+	while (true) {
+		page = sg_page_iter_page(&sg_iter);
 
-			xas_store(&xas, page);
-			if (xas_error(&xas))
-				break;
-			xas_next(&xas);
-			if (!__sg_page_iter_next(&sg_iter))
-				break;
+		if (persistent && !is_pmem_page(page)) {
+			rxe_dbg_mr(mr, "Page can't be persistent\n");
+			return -EINVAL;
 		}
-		xas_unlock(&xas);
-	} while (xas_nomem(&xas, GFP_KERNEL));
 
-	return xas_error(&xas);
+		mr->page_info[mr->nbuf].page = page;
+		mr->page_info[mr->nbuf].offset = 0;
+		mr->nbuf++;
+
+		if (!__sg_page_iter_next(&sg_iter))
+			break;
+	}
+
+	return 0;
+}
+
+static int __alloc_mr_page_info(struct rxe_mr *mr, int num_pages)
+{
+	mr->page_info = kcalloc(num_pages, sizeof(struct rxe_mr_page),
+				GFP_KERNEL);
+	if (!mr->page_info)
+		return -ENOMEM;
+
+	mr->max_allowed_buf = num_pages;
+	mr->nbuf = 0;
+
+	return 0;
+}
+
+static int alloc_mr_page_info(struct rxe_mr *mr, int num_pages)
+{
+	int ret;
+
+	WARN_ON(mr->num_buf);
+	ret = __alloc_mr_page_info(mr, num_pages);
+	if (ret)
+		return ret;
+
+	mr->num_buf = num_pages;
+
+	return 0;
+}
+
+static void free_mr_page_info(struct rxe_mr *mr)
+{
+	if (!mr->page_info)
+		return;
+
+	kfree(mr->page_info);
+	mr->page_info = NULL;
 }
 
 int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
@@ -134,8 +198,6 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 
 	rxe_mr_init(access, mr);
 
-	xa_init(&mr->page_list);
-
 	umem = ib_umem_get(&rxe->ib_dev, start, length, access);
 	if (IS_ERR(umem)) {
 		rxe_dbg_mr(mr, "Unable to pin memory region err = %d\n",
@@ -143,46 +205,24 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 		return PTR_ERR(umem);
 	}
 
+	err = alloc_mr_page_info(mr, ib_umem_num_pages(umem));
+	if (err)
+		goto err2;
+
 	err = rxe_mr_fill_pages_from_sgt(mr, &umem->sgt_append.sgt);
-	if (err) {
-		ib_umem_release(umem);
-		return err;
-	}
+	if (err)
+		goto err1;
 
 	mr->umem = umem;
 	mr->ibmr.type = IB_MR_TYPE_USER;
 	mr->state = RXE_MR_STATE_VALID;
 
 	return 0;
-}
-
-static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)
-{
-	XA_STATE(xas, &mr->page_list, 0);
-	int i = 0;
-	int err;
-
-	xa_init(&mr->page_list);
-
-	do {
-		xas_lock(&xas);
-		while (i != num_buf) {
-			xas_store(&xas, XA_ZERO_ENTRY);
-			if (xas_error(&xas))
-				break;
-			xas_next(&xas);
-			i++;
-		}
-		xas_unlock(&xas);
-	} while (xas_nomem(&xas, GFP_KERNEL));
-
-	err = xas_error(&xas);
-	if (err)
-		return err;
-
-	mr->num_buf = num_buf;
-
-	return 0;
+err1:
+	free_mr_page_info(mr);
+err2:
+	ib_umem_release(umem);
+	return err;
 }
 
 int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
@@ -192,7 +232,7 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
 	/* always allow remote access for FMRs */
 	rxe_mr_init(RXE_ACCESS_REMOTE, mr);
 
-	err = rxe_mr_alloc(mr, max_pages);
+	err = alloc_mr_page_info(mr, max_pages);
 	if (err)
 		goto err1;
 
@@ -205,26 +245,43 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
 	return err;
 }
 
+/*
+ * I) MRs with page_size >= PAGE_SIZE,
+ * Split a large MR page (mr->page_size) into multiple PAGE_SIZE
+ * sub-pages and store them in page_info, offset is always 0.
+ *
+ * Called when mr->page_size > PAGE_SIZE. Each call to rxe_set_page()
+ * represents one mr->page_size region, which we must split into
+ * (mr->page_size >> PAGE_SHIFT) individual pages.
+ *
+ * II) MRs with page_size < PAGE_SIZE,
+ * Save each PAGE_SIZE page and its offset within the system page in page_info.
+ */
 static int rxe_set_page(struct ib_mr *ibmr, u64 dma_addr)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
-	struct page *page = ib_virt_dma_to_page(dma_addr);
 	bool persistent = !!(mr->access & IB_ACCESS_FLUSH_PERSISTENT);
-	int err;
+	u32 i, pages_per_mr = mr_page_size(mr) >> PAGE_SHIFT;
 
-	if (persistent && !is_pmem_page(page)) {
-		rxe_dbg_mr(mr, "Page cannot be persistent\n");
-		return -EINVAL;
-	}
+	pages_per_mr = MAX(1, pages_per_mr);
 
-	if (unlikely(mr->nbuf == mr->num_buf))
-		return -ENOMEM;
+	for (i = 0; i < pages_per_mr; i++) {
+		u64 addr = dma_addr + i * PAGE_SIZE;
+		struct page *sub_page = ib_virt_dma_to_page(addr);
 
-	err = xa_err(xa_store(&mr->page_list, mr->nbuf, page, GFP_KERNEL));
-	if (err)
-		return err;
+		if (unlikely(mr->nbuf >= mr->max_allowed_buf))
+			return -ENOMEM;
+
+		if (persistent && !is_pmem_page(sub_page)) {
+			rxe_dbg_mr(mr, "Page cannot be persistent\n");
+			return -EINVAL;
+		}
+
+		mr->page_info[mr->nbuf].page = sub_page;
+		mr->page_info[mr->nbuf].offset = addr & (PAGE_SIZE - 1);
+		mr->nbuf++;
+	}
 
-	mr->nbuf++;
 	return 0;
 }
 
@@ -234,6 +291,31 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
 	struct rxe_mr *mr = to_rmr(ibmr);
 	unsigned int page_size = mr_page_size(mr);
 
+	/*
+	 * Ensure page_size and PAGE_SIZE are compatible for mapping.
+	 * We require one to be a multiple of the other for correct
+	 * iova-to-page conversion.
+	 */
+	if (!IS_ALIGNED(page_size, PAGE_SIZE) &&
+	    !IS_ALIGNED(PAGE_SIZE, page_size)) {
+		rxe_dbg_mr(mr, "MR page size %u must be compatible with PAGE_SIZE %lu\n",
+			   page_size, PAGE_SIZE);
+		return -EINVAL;
+	}
+
+	if (mr_page_size(mr) > PAGE_SIZE) {
+		/* resize page_info if needed */
+		u32 map_mr_pages = (page_size >> PAGE_SHIFT) * mr->num_buf;
+
+		if (map_mr_pages > mr->max_allowed_buf) {
+			rxe_dbg_mr(mr, "requested pages %u exceed max %u\n",
+				   map_mr_pages, mr->max_allowed_buf);
+			free_mr_page_info(mr);
+			if (__alloc_mr_page_info(mr, map_mr_pages))
+				return -ENOMEM;
+		}
+	}
+
 	mr->nbuf = 0;
 	mr->page_shift = ilog2(page_size);
 	mr->page_mask = ~((u64)page_size - 1);
@@ -244,30 +326,30 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
 static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
 			      unsigned int length, enum rxe_mr_copy_dir dir)
 {
-	unsigned int page_offset = rxe_mr_iova_to_page_offset(mr, iova);
-	unsigned long index = rxe_mr_iova_to_index(mr, iova);
 	unsigned int bytes;
-	struct page *page;
-	void *va;
+	u8 *va;
 
 	while (length) {
-		page = xa_load(&mr->page_list, index);
-		if (!page)
+		unsigned long index = rxe_mr_iova_to_index(mr, iova);
+		struct rxe_mr_page *info = &mr->page_info[index];
+		unsigned int page_offset = rxe_mr_iova_to_page_offset(mr, iova);
+
+		if (!info->page)
 			return -EFAULT;
 
-		bytes = min_t(unsigned int, length,
-				mr_page_size(mr) - page_offset);
-		va = kmap_local_page(page);
+		page_offset += info->offset;
+		bytes = min_t(unsigned int, length, PAGE_SIZE - page_offset);
+		va = kmap_local_page(info->page);
+
 		if (dir == RXE_FROM_MR_OBJ)
 			memcpy(addr, va + page_offset, bytes);
 		else
 			memcpy(va + page_offset, addr, bytes);
 		kunmap_local(va);
 
-		page_offset = 0;
 		addr += bytes;
+		iova += bytes;
 		length -= bytes;
-		index++;
 	}
 
 	return 0;
@@ -425,9 +507,6 @@ int copy_data(
 
 static int rxe_mr_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length)
 {
-	unsigned int page_offset;
-	unsigned long index;
-	struct page *page;
 	unsigned int bytes;
 	int err;
 	u8 *va;
@@ -437,15 +516,17 @@ static int rxe_mr_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int leng
 		return err;
 
 	while (length > 0) {
-		index = rxe_mr_iova_to_index(mr, iova);
-		page = xa_load(&mr->page_list, index);
-		page_offset = rxe_mr_iova_to_page_offset(mr, iova);
-		if (!page)
+		unsigned long index = rxe_mr_iova_to_index(mr, iova);
+		struct rxe_mr_page *info = &mr->page_info[index];
+		unsigned int page_offset = rxe_mr_iova_to_page_offset(mr, iova);
+
+		if (!info->page)
 			return -EFAULT;
-		bytes = min_t(unsigned int, length,
-			      mr_page_size(mr) - page_offset);
 
-		va = kmap_local_page(page);
+		page_offset += info->offset;
+		bytes = min_t(unsigned int, length, PAGE_SIZE - page_offset);
+
+		va = kmap_local_page(info->page);
 		arch_wb_cache_pmem(va + page_offset, bytes);
 		kunmap_local(va);
 
@@ -500,6 +581,7 @@ enum resp_states rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 	} else {
 		unsigned long index;
 		int err;
+		struct rxe_mr_page *info;
 
 		err = mr_check_range(mr, iova, sizeof(value));
 		if (err) {
@@ -508,9 +590,12 @@ enum resp_states rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 		}
 		page_offset = rxe_mr_iova_to_page_offset(mr, iova);
 		index = rxe_mr_iova_to_index(mr, iova);
-		page = xa_load(&mr->page_list, index);
-		if (!page)
+		info = &mr->page_info[index];
+		if (!info->page)
 			return RESPST_ERR_RKEY_VIOLATION;
+
+		page_offset += info->offset;
+		page = info->page;
 	}
 
 	if (unlikely(page_offset & 0x7)) {
@@ -549,6 +634,7 @@ enum resp_states rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 	} else {
 		unsigned long index;
 		int err;
+		struct rxe_mr_page *info;
 
 		/* See IBA oA19-28 */
 		err = mr_check_range(mr, iova, sizeof(value));
@@ -558,9 +644,12 @@ enum resp_states rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 		}
 		page_offset = rxe_mr_iova_to_page_offset(mr, iova);
 		index = rxe_mr_iova_to_index(mr, iova);
-		page = xa_load(&mr->page_list, index);
-		if (!page)
+		info = &mr->page_info[index];
+		if (!info->page)
 			return RESPST_ERR_RKEY_VIOLATION;
+
+		page_offset += info->offset;
+		page = info->page;
 	}
 
 	/* See IBA A19.4.2 */
@@ -724,5 +813,5 @@ void rxe_mr_cleanup(struct rxe_pool_elem *elem)
 	ib_umem_release(mr->umem);
 
 	if (mr->ibmr.type != IB_MR_TYPE_DMA)
-		xa_destroy(&mr->page_list);
+		free_mr_page_info(mr);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index f94ce85eb807..fb149f37e91d 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -335,6 +335,11 @@ static inline int rkey_is_mw(u32 rkey)
 	return (index >= RXE_MIN_MW_INDEX) && (index <= RXE_MAX_MW_INDEX);
 }
 
+struct rxe_mr_page {
+	struct page		*page;
+	unsigned int		offset; /* offset in system page */
+};
+
 struct rxe_mr {
 	struct rxe_pool_elem	elem;
 	struct ib_mr		ibmr;
@@ -350,10 +355,13 @@ struct rxe_mr {
 	unsigned int		page_shift;
 	u64			page_mask;
 
+	/* size of page_info when mr allocated */
 	u32			num_buf;
+	/* real size of page_info */
+	u32			max_allowed_buf;
 	u32			nbuf;
 
-	struct xarray		page_list;
+	struct rxe_mr_page	*page_info;
 };
 
 static inline unsigned int mr_page_size(struct rxe_mr *mr)
-- 
2.41.0


