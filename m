Return-Path: <linux-rdma+bounces-15226-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 109EFCDE90C
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Dec 2025 10:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1CEC3005BB0
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Dec 2025 09:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E1729D28B;
	Fri, 26 Dec 2025 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="iVuCqK8p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C373A1E68;
	Fri, 26 Dec 2025 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766742785; cv=none; b=I2nG1dhjAQuEXUUBMJVf52Qo1WJ0p0hr2bw8/6C1Wc9oaSUuVwaPV5rf4SYLZ6hfNIjTR17sP69moK/I7fVCHxuLI3NZB0wyy2ACdjqlj88tusBKKt0rlJYWIix+SrBBF8by78yy9r378RpvXF48YFFQs1y5JeHlr4kvtPArphY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766742785; c=relaxed/simple;
	bh=bEkaRxP55iZCFajpM1hCZQFzoz7c3Om6BdMkXMPbUPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hIXY5T0bvfy0yJdWjRI+gBejCTd7aaHBTCgu0cJBy0hc6VxPydjeGLCmik39rSKvvZbV93kjHAUPJ0fpQqgoyzmwXfxXN9GqyJrSXwZxHS4tntYNLxS/ZzuCmUCEPK+PHsm9HBO9GPka1y4gMVQIERAXEs0iLjoUX+vwn4id2W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=iVuCqK8p; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1766742783; x=1798278783;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bEkaRxP55iZCFajpM1hCZQFzoz7c3Om6BdMkXMPbUPc=;
  b=iVuCqK8pzuk0j8P6uG/I4qFEbGOR1aDi21HEzviL2g9+GDj6yytPUhzC
   2/bElEh8FO5NAbVG/OaDhbjPXDvAcgYZqOsHnn9pcsTxDXrSZfnLNbp7/
   xH+DV/TurBGsEBZcuTZ04GDv8uecpLJtKRwnekDhmotw7sKSSKGkC7pQZ
   R+eIu2HfwaYPR3HW5GzuukaKwfenrqRGYvcKIdRwKOrf2bTYySoC74jd8
   en6GNvczDUP9zwV+CZADlIYrHVlbf+jivL9kZDEanFoYckxU0ImAfg0I5
   Wes/i/1BzwCjchVd7gJ0kpe4dR042SI4gGRvMaFO22QO4j6TIHselsSyD
   g==;
X-CSE-ConnectionGUID: LPWTbIbyTKKyKXt3Gv1u0g==
X-CSE-MsgGUID: pb+jjBOkTwKvxEJdVf/iNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="203035582"
X-IronPort-AV: E=Sophos;i="6.21,177,1763391600"; 
   d="scan'208";a="203035582"
Received: from unknown (HELO az2uksmgr2.o.css.fujitsu.com) ([52.151.125.19])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2025 18:52:55 +0900
Received: from az2uksmgm3.o.css.fujitsu.com (unknown [10.151.22.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgr2.o.css.fujitsu.com (Postfix) with ESMTPS id 7603F820C11;
	Fri, 26 Dec 2025 09:52:55 +0000 (UTC)
Received: from az2uksmom3.o.css.fujitsu.com (az2uksmom3.o.css.fujitsu.com [10.151.22.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm3.o.css.fujitsu.com (Postfix) with ESMTPS id 2D5BCC0030C;
	Fri, 26 Dec 2025 09:52:55 +0000 (UTC)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.135.44])
	by az2uksmom3.o.css.fujitsu.com (Postfix) with ESMTP id 84A291004B2B;
	Fri, 26 Dec 2025 09:52:51 +0000 (UTC)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH RFC] rxe: Fix iova-to-va conversion for MR page sizes != PAGE_SIZE
Date: Fri, 26 Dec 2025 17:52:37 +0800
Message-ID: <20251226095237.3047496-1-lizhijian@fujitsu.com>
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

Problem scenarios with concrete examples:

1. mr->page_size > PAGE_SIZE (e.g., 64K MR with 4K system pages):

   Suppose: PAGE_SIZE=4K, mr->page_size=64K, mr->ibmr.iova=0x13010
   When rxe_set_page() is called with dma_addr=0x10000 (64K-aligned),
   it stores only one 4K page at page_list[0], but should store 16 pages.

   Accessing iova=0x13034:
   - Current code: index = (0x13034 >> 16) - (0x13010 >> 16) = 0
                  offset = 0x13034 & (64K-1) = 0x3034
   This calculates offset within 64K page, but page_list[0] is only 4K.

   - Expected: The iova=0x13034 should map to:
                  base_align = 0x13010 & ~(64K-1) = 0x10000
                  index = (0x13034 - 0x10000) / 4K = 0x3034 / 0x1000 = 3
                  offset = 0x13034 & (4K-1) = 0x034
                  So: page_list[3] with offset 0x34

2. mr->page_size < PAGE_SIZE (e.g., 2K MR with 4K system pages):

   Suppose: PAGE_SIZE=4K, mr->page_size=2K, mr->ibmr.iova=0x1100
   When rxe_set_page() is called with dma_addr=0x1000, it stores a 4K page
   at page_list[0]. Another call with dma_addr=0x1800 should not store
   a new page since 0x1800 is within the same 4K page as 0x1000.

   Accessing iova=0x1890:
   - Current code: index = (0x1890 >> 11) - (0x1100 >> 11) = 3
                  offset = 0x1890 & (2K-1) = 0x90
                  This assumes page_list[3] exists and is a 2K page.

   - Expected: Both 0x1000 and 0x1800 are within the same 4K page:
                  index = (0x1890 >> 12) - (0x1100 >> 12) = 0
                  offset = 0x1890 & (4K-1) = 0x890
                  So: page_list[0] with offset 0x890

Yi Zhang reported a kernel panic[1] years ago related to this defect.

The fix introduces:

1. Enhanced iova-to-index conversion with proper alignment handling:
   - For mr->page_size > PAGE_SIZE: Uses aligned base address
     (mr->ibmr.iova & mr->page_mask) as reference, correctly calculating
     which PAGE_SIZE sub-page contains the iova
   - For mr->page_size <= PAGE_SIZE: Uses PAGE_SIZE shift arithmetic
     to ensure each page_list entry corresponds to a PAGE_SIZE page

2. Page splitting in rxe_set_page():
   - When mr->page_size > PAGE_SIZE, set_pages_per_mr() splits each
     MR page into multiple PAGE_SIZE pages stored consecutively
   - For mr->page_size <= PAGE_SIZE, maintains original behavior

3. Always use PAGE_SIZE for offset calculation:
   - Since page_list stores PAGE_SIZE pages, offsets must be within
     [0, PAGE_SIZE-1]

4. Compatibility checks:
   - Ensures mr->page_size and PAGE_SIZE have a compatible relationship
     (one is multiple of the other) for correct mapping

The solution ensures correct iova-to-va conversion for all MR page sizes
while maintaining the existing IB verbs semantics for MR registration
and memory access.

This patch enables srp rnbd nvme in 64K system page environment.

Tests on (4K and 64K PAGE_SIZE):
- rdma-core/pytests
  $ ./build/bin/run_tests.py  --dev eth0_rxe
- blktest:
  $ TIMEOUT=30 QUICK_RUN=1 USE_RXE=1 NVMET_TRTYPES=rdma ./check nvme srp rnbd

In 64K environment, srp/012 is failed while it's passed in 4K environment.

[1] https://lore.kernel.org/all/CAHj4cs9XRqE25jyVw9rj9YugffLn5+f=1znaBEnu1usLOciD+g@mail.gmail.com/T/
ixes: 592627ccbdff ("RDMA/rxe: Replace rxe_map and rxe_phys_buf by xarray")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 83 +++++++++++++++++++++++++++---
 1 file changed, 76 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index b28b56db725a..8ad7d163b418 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -72,14 +72,40 @@ void rxe_mr_init_dma(int access, struct rxe_mr *mr)
 	mr->ibmr.type = IB_MR_TYPE_DMA;
 }
 
+/*
+ * Convert iova to page_list index. The page_list stores pages of size
+ * PAGE_SIZE, but MRs can have different page sizes. This function
+ * handles the conversion for all cases:
+ *
+ * 1. mr->page_size > PAGE_SIZE:
+ *    The MR's iova may not be aligned to mr->page_size. We use the
+ *    aligned base (iova & page_mask) as reference, then calculate
+ *    which PAGE_SIZE sub-page the iova falls into.
+ *
+ * 2. mr->page_size <= PAGE_SIZE:
+ *    Use simple shift arithmetic since each page_list entry corresponds
+ *    to one or more MR pages.
+ *
+ * Example for mr->page_size=64K, PAGE_SIZE=4K, iova=0x11034:
+ *   base = iova & ~(64K-1) = 0x10000
+ *   index = (0x11034 - 0x10000) / 4K = 0x1034 / 0x1000 = 4
+ */
 static unsigned long rxe_mr_iova_to_index(struct rxe_mr *mr, u64 iova)
 {
-	return (iova >> mr->page_shift) - (mr->ibmr.iova >> mr->page_shift);
+	if (mr_page_size(mr) > PAGE_SIZE)
+		return (iova - (mr->ibmr.iova & mr->page_mask)) / PAGE_SIZE;
+	else
+		return (iova >> mr->page_shift) - (mr->ibmr.iova >> mr->page_shift);
 }
 
+/*
+ * Always return offset within a PAGE_SIZE page since page_list
+ * stores individual struct page pointers, each representing
+ * PAGE_SIZE of memory.
+ */
 static unsigned long rxe_mr_iova_to_page_offset(struct rxe_mr *mr, u64 iova)
 {
-	return iova & (mr_page_size(mr) - 1);
+	return iova & (PAGE_SIZE - 1);
 }
 
 static bool is_pmem_page(struct page *pg)
@@ -205,11 +231,40 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
 	return err;
 }
 
+/*
+ * Split a large MR page (mr->page_size) into multiple PAGE_SIZE
+ * sub-pages and store them in page_list.
+ *
+ * Called when mr->page_size > PAGE_SIZE. Each call to rxe_set_page()
+ * represents one mr->page_size region, which we must split into
+ * (mr->page_size / PAGE_SIZE) individual pages.
+ */
+static int set_pages_per_mr(struct ib_mr *ibmr, u64 dma_addr)
+{
+	struct rxe_mr *mr = to_rmr(ibmr);
+	u32 page_size = mr_page_size(mr);
+	u64 addr = dma_addr & ~(u64)(page_size - 1);
+	u32 i, pages_per_mr = page_size / PAGE_SIZE;
+
+	for (i = 0; i < pages_per_mr; i++) {
+		struct page *sub_page =
+			ib_virt_dma_to_page(addr + i * PAGE_SIZE);
+		int err = xa_err(xa_store(&mr->page_list, mr->nbuf, sub_page,
+					  GFP_KERNEL));
+		if (err)
+			return err;
+
+		mr->nbuf++;
+	}
+	return 0;
+}
+
 static int rxe_set_page(struct ib_mr *ibmr, u64 dma_addr)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
 	struct page *page = ib_virt_dma_to_page(dma_addr);
 	bool persistent = !!(mr->access & IB_ACCESS_FLUSH_PERSISTENT);
+	u32 page_size = mr_page_size(mr);
 	int err;
 
 	if (persistent && !is_pmem_page(page)) {
@@ -217,9 +272,13 @@ static int rxe_set_page(struct ib_mr *ibmr, u64 dma_addr)
 		return -EINVAL;
 	}
 
-	if (unlikely(mr->nbuf == mr->num_buf))
+	if (unlikely(mr->nbuf >= mr->num_buf))
 		return -ENOMEM;
 
+	if (page_size > PAGE_SIZE)
+		return set_pages_per_mr(ibmr, dma_addr);
+
+	/* page_size <= PAGE_SIZE */
 	err = xa_err(xa_store(&mr->page_list, mr->nbuf, page, GFP_KERNEL));
 	if (err)
 		return err;
@@ -234,6 +293,18 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
 	struct rxe_mr *mr = to_rmr(ibmr);
 	unsigned int page_size = mr_page_size(mr);
 
+	/*
+	 * Ensure page_size and PAGE_SIZE are compatible for mapping.
+	 * We require one to be a multiple of the other for correct
+	 * iova-to-page conversion.
+	 */
+	if (!IS_ALIGNED(page_size, PAGE_SIZE) &&
+	    !IS_ALIGNED(PAGE_SIZE, page_size)) {
+		rxe_err_mr(mr, "MR page size %u must be compatible with PAGE_SIZE %lu\n",
+			   page_size, PAGE_SIZE);
+		return -EINVAL;
+	}
+
 	mr->nbuf = 0;
 	mr->page_shift = ilog2(page_size);
 	mr->page_mask = ~((u64)page_size - 1);
@@ -255,8 +326,7 @@ static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
 		if (!page)
 			return -EFAULT;
 
-		bytes = min_t(unsigned int, length,
-				mr_page_size(mr) - page_offset);
+		bytes = min_t(unsigned int, length, PAGE_SIZE - page_offset);
 		va = kmap_local_page(page);
 		if (dir == RXE_FROM_MR_OBJ)
 			memcpy(addr, va + page_offset, bytes);
@@ -442,8 +512,7 @@ static int rxe_mr_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int leng
 		page_offset = rxe_mr_iova_to_page_offset(mr, iova);
 		if (!page)
 			return -EFAULT;
-		bytes = min_t(unsigned int, length,
-			      mr_page_size(mr) - page_offset);
+		bytes = min_t(unsigned int, length, PAGE_SIZE - page_offset);
 
 		va = kmap_local_page(page);
 		arch_wb_cache_pmem(va + page_offset, bytes);
-- 
2.41.0


