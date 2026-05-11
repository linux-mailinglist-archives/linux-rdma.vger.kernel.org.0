Return-Path: <linux-rdma+bounces-20395-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLdkAu3lAWqKmAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20395-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 16:21:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C07FE50FFF8
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 16:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78397307B3BC
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 14:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796C1224AF9;
	Mon, 11 May 2026 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LgxO2bl+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1AC1DDC1D
	for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508742; cv=none; b=OWg6fn8AmdyLx2WCbn0+eJz/kT3sqxxi8AEM8IV1GqEpa8Ztn2+XFaUY8J94EL0iJpqreVqLUnOKeJLHCNHDw5c+Ia/utgxrJ0yc/fEHHSHhFHJTqrUhfxIv/Cl5klt1+mPYioEMpJCWpQUX6pgLj90F6f07fLUTBHlSD8tWUPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508742; c=relaxed/simple;
	bh=JHaydYq1EUMFFPpm4gzXDgoriQU7A4F3fNpTLWpihdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NfJ97FpGc4WDxpBz9TkUouAQApktoaH1CnOVA/qnRea+WDVgm5m0MKx6u75v9P5uoz+rz8X3Z4+ESCWfun2EwqjNGGZmwWc0SCNGhk2WRFWiyaTIDCcvFdvM4sA7VQmClqXBQB6nkO6LnTxz7/zIulf61TClgcaAkd2LUAPBu0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LgxO2bl+; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778508737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vlON00sd+oSLqSbyQO93gsGUNdPKwumvsqGKACNWq2U=;
	b=LgxO2bl+rMoZi5xj5gGEgSEEBADUH+Qt/gHGvkLEApS4hf8q7YusvvCVfvKYEuyQYDqezv
	RrGDHFRWyGWbgzFlZWBK5AZNFQdfjfSu30pVR2aabAVcS2G1A6Af59PZilHVLOPoJctzbm
	k9buanRsVVdA7YlqvbkqP2VY6qlqR4E=
From: bernard.metzler@linux.dev
To: rosenp@gmail.com
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	linux-rdma@vger.kernel.org,
	Bernard Metzler <bernard.metzler@linux.dev>
Subject: [RFC PATCH v3] RDMA/siw: use kzalloc_flex
Date: Mon, 11 May 2026 16:11:49 +0200
Message-ID: <20260511141149.52362-1-bernard.metzler@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: C07FE50FFF8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20395-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernard.metzler@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action

From: Bernard Metzler <bernard.metzler@linux.dev>

Simplify umem allocation by using flexible array member.
Add __counted_by to get extra runtime analysis.

Suggested-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Bernard Metzler <bernard.metzler@linux.dev>

---
v3:
Considering comments from sashiko.dev to v2:
- To minimize memory footprint of user page list, revert array
  allocation to original kzalloc_objs(),
- Revert siw_get_upage() to original bounds check.

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
 drivers/infiniband/sw/siw/siw.h     |  5 +--
 drivers/infiniband/sw/siw/siw_mem.c | 54 ++++++++++++++---------------
 drivers/infiniband/sw/siw/siw_mem.h |  3 +-
 3 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index f5fd71717b80..dbc998248b1e 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -119,9 +119,10 @@ struct siw_page_chunk {
 
 struct siw_umem {
 	struct ib_umem *base_mem;
-	struct siw_page_chunk *page_chunk;
-	int num_pages;
+	unsigned int num_pages;
+	unsigned int num_chunks;
 	u64 fp_addr; /* First page base address */
+	struct siw_page_chunk page_chunk[] __counted_by(num_chunks);
 };
 
 struct siw_pble {
diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index 98c802b3ed72..88ec3cacfa00 100644
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
+	for (i = 0; i < num_chunks; i++)
 		kfree(umem->page_chunk[i].plist);
-		num_pages -= PAGES_PER_CHUNK;
-	}
-	kfree(umem->page_chunk);
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
@@ -365,33 +358,38 @@ struct siw_umem *siw_umem_get(struct ib_device *base_dev, u64 start,
 	}
 	umem->fp_addr = first_page_va;
 	umem->base_mem = base_mem;
+	umem->num_pages = num_pages;
 
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
+		struct page **plist;
+		unsigned int pix, nents = min(num_pages, PAGES_PER_CHUNK);
 
+		plist = kzalloc_objs(struct page *, nents);
 		if (!plist) {
 			rv = -ENOMEM;
 			goto err_out;
 		}
 		umem->page_chunk[i].plist = plist;
-		while (nents--) {
-			*plist = sg_page_iter_page(&sg_iter);
-			umem->num_pages++;
-			num_pages--;
-			plist++;
+
+		for (pix = 0; pix < nents; pix++) {
 			if (!__sg_page_iter_next(&sg_iter))
 				break;
+			plist[pix] = sg_page_iter_page(&sg_iter);
+			num_pages--;
 		}
 	}
+	if (unlikely(num_pages)) {
+		/*
+		 * Unexpected size of sg list provided by ib_umem_get()
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
index 8e769d30e2ac..2dff6640da5f 100644
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
-- 
2.50.0


