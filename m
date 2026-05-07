Return-Path: <linux-rdma+bounces-20138-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMQjJYt//GkcQwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20138-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:03:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A9F4E7F06
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 514CF301025C
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 12:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5BB3932F7;
	Thu,  7 May 2026 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MKlUwDiT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAA236073E
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778155310; cv=none; b=P9VyLKeSiQi0q7QqhoAJtl4e5H0yHXqFx4hrGaDEKvg/UlIb2fQBEgaz0QAlJuF3aEGSFyN//t8Ov9ih/8a4jH/w97B1hwP78j7BuuOk62s1E1QD6aM299b9V1B52ui8qZaVIBs9uid98+QZmfZxQyc9gkjEQiGu7Hjeh2UrBTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778155310; c=relaxed/simple;
	bh=fy+gHvzrZrT5EKw0CJGQICO7ohf47KhOYHCcbpc7W4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TouOerckVGT3+e10IJpx8nlYD0uXE+dTg/+yxf9gNYfxZrO8pAoivGin4hYmqyGD8UKY+8Vf6O3yvkNAAcJJllR2tXhmXqkgyNR9i38+8wiCREjJtUVl296Zjnx1D/Oizeq9ssKtsDEctEN8d1GB2MjsG5tTj/fN++vvidyxkZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MKlUwDiT; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778155306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eUHkfD5ZE4/5zh7t/d+bVLnz8aCDolTtBvyCjWYrScQ=;
	b=MKlUwDiT+7fGzh0VTl/Ec/ak0iJ62Dlek9nEdBeYB9iCIL1rptfJfq9Nt+sMkjBOikESGM
	pgP9zHdYpJkBu3/v3KCa1h1W5fi/T0QO9Zw50UOzHUNZ40mlkY8YHYeG3EOjVzI2MSF3SI
	aKFHWcc24l+G9DmAL9LacojKZNkMcDw=
From: bernard.metzler@linux.dev
To: rosenp@gmail.com
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	linux-rdma@vger.kernel.org,
	Bernard Metzler <bernard.metzler@linux.dev>
Subject: [RFC PATCH v2] RDMA/siw: use kzalloc_flex
Date: Thu,  7 May 2026 14:01:15 +0200
Message-ID: <20260507120115.2297-1-bernard.metzler@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 38A9F4E7F06
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20138-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernard.metzler@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action

From: Bernard Metzler <bernard.metzler@linux.dev>

Simplify umem allocation by using flexible array member.
Add __counted_by to get extra runtime analysis.

Suggested-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Bernard Metzler <bernard.metzler@linux.dev>

---
v2:
1. Considering comments from sashiko.dev to original patch regarding:
	- avoiding allocation of extra empty page chunk entry,
	  if number of pages is an exact multiplier
	  of PAGES_PER_CHUNK,
	- fix potential signed index overflow case for
	  page list generation and access,
	- restrict page list access in siw_get_upage() to
	  allocated length.

2. Extend flexible array allocation to page list.

3. Remove useless PAGE_CHUNK_SIZE definition.
---
 drivers/infiniband/sw/siw/siw.h     |  7 ++--
 drivers/infiniband/sw/siw/siw_mem.c | 59 ++++++++++++++---------------
 drivers/infiniband/sw/siw/siw_mem.h |  9 +++--
 3 files changed, 37 insertions(+), 38 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index f5fd71717b80..6ce30211d066 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -114,14 +114,15 @@ struct siw_ucontext {
  */
 
 struct siw_page_chunk {
-	struct page **plist;
+	unsigned int nents;
+	struct page *plist[] __counted_by(nents);
 };
 
 struct siw_umem {
 	struct ib_umem *base_mem;
-	struct siw_page_chunk *page_chunk;
-	int num_pages;
+	unsigned int num_chunks;
 	u64 fp_addr; /* First page base address */
+	struct siw_page_chunk *page_chunk[] __counted_by(num_chunks);
 };
 
 struct siw_pble {
diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index 98c802b3ed72..d8075e44491a 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -41,16 +41,14 @@ struct siw_mem *siw_mem_id2obj(struct siw_device *sdev, int stag_index)
 
 void siw_umem_release(struct siw_umem *umem)
 {
-	int i, num_pages = umem->num_pages;
+	unsigned int i, num_chunks = umem->num_chunks;
 
 	if (umem->base_mem)
 		ib_umem_release(umem->base_mem);
 
-	for (i = 0; num_pages > 0; i++) {
-		kfree(umem->page_chunk[i].plist);
-		num_pages -= PAGES_PER_CHUNK;
-	}
-	kfree(umem->page_chunk);
+	for (i = 0; i < num_chunks; i++)
+		kfree(umem->page_chunk[i]);
+
 	kfree(umem);
 }
 
@@ -188,7 +186,7 @@ int siw_check_mem(struct ib_pd *pd, struct siw_mem *mem, u64 addr,
  * lookup is being done and mem is not released it check fails.
  */
 int siw_check_sge(struct ib_pd *pd, struct siw_sge *sge, struct siw_mem *mem[],
-		  enum ib_access_flags perms, u32 off, int len)
+		  enum ib_access_flags perms, u32 off, u32 len)
 {
 	struct siw_device *sdev = to_siw_dev(pd->device);
 	struct siw_mem *new = NULL;
@@ -338,25 +336,20 @@ struct siw_umem *siw_umem_get(struct ib_device *base_dev, u64 start,
 	struct sg_page_iter sg_iter;
 	struct sg_table *sgt;
 	u64 first_page_va;
-	int num_pages, num_chunks, i, rv = 0;
+	unsigned int num_pages, num_chunks, i;
+	int rv = 0;
 
 	if (!len)
 		return ERR_PTR(-EINVAL);
 
 	first_page_va = start & PAGE_MASK;
 	num_pages = PAGE_ALIGN(start + len - first_page_va) >> PAGE_SHIFT;
-	num_chunks = (num_pages >> CHUNK_SHIFT) + 1;
+	num_chunks = ((num_pages - 1) >> CHUNK_SHIFT) + 1;
 
-	umem = kzalloc_obj(*umem);
+	umem = kzalloc_flex(*umem, page_chunk, num_chunks);
 	if (!umem)
 		return ERR_PTR(-ENOMEM);
 
-	umem->page_chunk =
-		kzalloc_objs(struct siw_page_chunk, num_chunks);
-	if (!umem->page_chunk) {
-		rv = -ENOMEM;
-		goto err_out;
-	}
 	base_mem = ib_umem_get(base_dev, start, len, rights);
 	if (IS_ERR(base_mem)) {
 		rv = PTR_ERR(base_mem);
@@ -369,29 +362,33 @@ struct siw_umem *siw_umem_get(struct ib_device *base_dev, u64 start,
 	sgt = &base_mem->sgt_append.sgt;
 	__sg_page_iter_start(&sg_iter, sgt->sgl, sgt->orig_nents, 0);
 
-	if (!__sg_page_iter_next(&sg_iter)) {
-		rv = -EINVAL;
-		goto err_out;
-	}
-	for (i = 0; num_pages > 0; i++) {
-		int nents = min_t(int, num_pages, PAGES_PER_CHUNK);
-		struct page **plist =
-			kzalloc_objs(struct page *, nents);
+	for (i = 0; i < num_chunks; i++) {
+		struct siw_page_chunk *pchunk;
+		unsigned int pix, nents = min(num_pages, PAGES_PER_CHUNK);
 
-		if (!plist) {
+		pchunk = kzalloc_flex(*pchunk, plist, nents);
+		if (!pchunk) {
 			rv = -ENOMEM;
 			goto err_out;
 		}
-		umem->page_chunk[i].plist = plist;
-		while (nents--) {
-			*plist = sg_page_iter_page(&sg_iter);
-			umem->num_pages++;
-			num_pages--;
-			plist++;
+		umem->page_chunk[i] = pchunk;
+
+		for (pix = 0; pix < nents; pix++) {
 			if (!__sg_page_iter_next(&sg_iter))
 				break;
+			pchunk->plist[pix] = sg_page_iter_page(&sg_iter);
+			num_pages--;
 		}
 	}
+	if (unlikely(num_pages)) {
+		/*
+		 * Unexpected end of sg list provided by ib_umem_get()
+		 */
+		siw_dbg(base_dev, "Short SG list, missing %u pages\n",
+			num_pages);
+		rv = -EINVAL;
+		goto err_out;
+	}
 	return umem;
 err_out:
 	siw_umem_release(umem);
diff --git a/drivers/infiniband/sw/siw/siw_mem.h b/drivers/infiniband/sw/siw/siw_mem.h
index 8e769d30e2ac..47ab38faad7c 100644
--- a/drivers/infiniband/sw/siw/siw_mem.h
+++ b/drivers/infiniband/sw/siw/siw_mem.h
@@ -17,7 +17,7 @@ int siw_check_mem(struct ib_pd *pd, struct siw_mem *mem, u64 addr,
 		  enum ib_access_flags perms, int len);
 int siw_check_sge(struct ib_pd *pd, struct siw_sge *sge,
 		  struct siw_mem *mem[], enum ib_access_flags perms,
-		  u32 off, int len);
+		  u32 off, u32 len);
 void siw_wqe_put_mem(struct siw_wqe *wqe, enum siw_opcode op);
 int siw_mr_add_mem(struct siw_mr *mr, struct ib_pd *pd, void *mem_obj,
 		   u64 start, u64 len, int rights);
@@ -45,7 +45,6 @@ static inline void siw_unref_mem_sgl(struct siw_mem **mem, unsigned int num_sge)
 #define CHUNK_SHIFT 9 /* sets number of pages per chunk */
 #define PAGES_PER_CHUNK (_AC(1, UL) << CHUNK_SHIFT)
 #define CHUNK_MASK (~(PAGES_PER_CHUNK - 1))
-#define PAGE_CHUNK_SIZE (PAGES_PER_CHUNK * sizeof(struct page *))
 
 /*
  * siw_get_upage()
@@ -60,9 +59,11 @@ static inline struct page *siw_get_upage(struct siw_umem *umem, u64 addr)
 	unsigned int page_idx = (addr - umem->fp_addr) >> PAGE_SHIFT,
 		     chunk_idx = page_idx >> CHUNK_SHIFT,
 		     page_in_chunk = page_idx & ~CHUNK_MASK;
+	struct siw_page_chunk *page_chunk = umem->page_chunk[chunk_idx];
 
-	if (likely(page_idx < umem->num_pages))
-		return umem->page_chunk[chunk_idx].plist[page_in_chunk];
+	if (likely(chunk_idx < umem->num_chunks &&
+		   page_in_chunk < page_chunk->nents))
+		return page_chunk->plist[page_in_chunk];
 
 	return NULL;
 }
-- 
2.50.0


