Return-Path: <linux-rdma+bounces-19461-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id povcEvXP52k4BAIAu9opvQ
	(envelope-from <linux-rdma+bounces-19461-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 21:28:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DE843EF04
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 21:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF589300AB39
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 19:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62853D8919;
	Tue, 21 Apr 2026 19:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sQuiSVBA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D7D288D0
	for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2026 19:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776799728; cv=none; b=KwIW6tSDljMCm3gfJpzcOPnjDOq7N5f+N+QOf10d15O77N4SlgKy6bqcQefbEMLQZ2/OI5x9IelQB7Sn8yCpyeT8jsSJ8SNTkEpBZj9x/joArWqFl0T61rt246MkwJpzjht524yvpzB3g3RqSTOfF7j9hkMDY1utW4gqWXYIHu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776799728; c=relaxed/simple;
	bh=7xdyRkRstof0Z6MwpHGkGDCId3KYlkUlM8WT3eby/KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nc3qlM8hLMSkAl4Ywb+p6IH9Wwlz/aOH9s8+6mQH0UkrV/3t/077RE9R8UJAyjkLclpfy4HwemOPzGpJKyWvc326+wtdasS90iPYi1gM2lBxH4BU3+ER7QyQTXJFn4/1Vsm8V50N94aRJe8meHQyOdvpqPvLGTgY+cFhQ0a5f/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sQuiSVBA; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776799725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=59AKvMbljrLinLv4mIlFd2+hFyZkxKswdJWlS+mSze8=;
	b=sQuiSVBAqMjA76eQByJQn8lRkJDN2ZOKquWy/UNbfy415MTKiAHNLLL5hcjeo0R4OCQiMi
	ftjuxD9GrjR9tNwGxNF/lJ45AxxTZtMNTI3PynGUwrJ/Zty1kuZBX8nzGfYtNC+CB457sD
	H7WrluCwXdZsA1zIAxuXlNvbhAoQEXM=
From: bernard.metzler@linux.dev
To: rosenp@gmail.com
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	linux-rdma@vger.kernel.org,
	Bernard Metzler <bernard.metzler@linux.dev>
Subject: [RFC PATCH] RDMA/siw: use kzalloc_flex
Date: Tue, 21 Apr 2026 21:28:21 +0200
Message-ID: <20260421192821.2305-1-bernard.metzler@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19461-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91DE843EF04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bernard Metzler <bernard.metzler@linux.dev>

Simplify umem allocation by using flexible array member.
Add __counted_by to get extra runtime analysis.

Suggested-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Bernard Metzler <bernard.metzler@linux.dev>
---
 drivers/infiniband/sw/siw/siw.h     |  4 ++--
 drivers/infiniband/sw/siw/siw_mem.c | 19 ++++++-------------
 drivers/infiniband/sw/siw/siw_mem.h |  2 +-
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index f5fd71717b80..a4088caec2ae 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -119,9 +119,9 @@ struct siw_page_chunk {
 
 struct siw_umem {
 	struct ib_umem *base_mem;
-	struct siw_page_chunk *page_chunk;
-	int num_pages;
+	int num_chunks;
 	u64 fp_addr; /* First page base address */
+	struct siw_page_chunk page_chunk[] __counted_by(num_chunks);
 };
 
 struct siw_pble {
diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index 98c802b3ed72..56d24db729d0 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -41,16 +41,14 @@ struct siw_mem *siw_mem_id2obj(struct siw_device *sdev, int stag_index)
 
 void siw_umem_release(struct siw_umem *umem)
 {
-	int i, num_pages = umem->num_pages;
+	int i, num_chunks = umem->num_chunks;
 
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
 
@@ -347,16 +345,12 @@ struct siw_umem *siw_umem_get(struct ib_device *base_dev, u64 start,
 	num_pages = PAGE_ALIGN(start + len - first_page_va) >> PAGE_SHIFT;
 	num_chunks = (num_pages >> CHUNK_SHIFT) + 1;
 
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
+	umem->num_chunks = num_chunks;
+
 	base_mem = ib_umem_get(base_dev, start, len, rights);
 	if (IS_ERR(base_mem)) {
 		rv = PTR_ERR(base_mem);
@@ -385,7 +379,6 @@ struct siw_umem *siw_umem_get(struct ib_device *base_dev, u64 start,
 		umem->page_chunk[i].plist = plist;
 		while (nents--) {
 			*plist = sg_page_iter_page(&sg_iter);
-			umem->num_pages++;
 			num_pages--;
 			plist++;
 			if (!__sg_page_iter_next(&sg_iter))
diff --git a/drivers/infiniband/sw/siw/siw_mem.h b/drivers/infiniband/sw/siw/siw_mem.h
index 8e769d30e2ac..86af61d422d5 100644
--- a/drivers/infiniband/sw/siw/siw_mem.h
+++ b/drivers/infiniband/sw/siw/siw_mem.h
@@ -61,7 +61,7 @@ static inline struct page *siw_get_upage(struct siw_umem *umem, u64 addr)
 		     chunk_idx = page_idx >> CHUNK_SHIFT,
 		     page_in_chunk = page_idx & ~CHUNK_MASK;
 
-	if (likely(page_idx < umem->num_pages))
+	if (likely(chunk_idx < umem->num_chunks))
 		return umem->page_chunk[chunk_idx].plist[page_in_chunk];
 
 	return NULL;
-- 
2.50.0


