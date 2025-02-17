Return-Path: <linux-rdma+bounces-7794-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A287A385F4
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 15:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BAB13B770C
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 14:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DADC21D585;
	Mon, 17 Feb 2025 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gm0hTyBA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70C5216E00
	for <linux-rdma@vger.kernel.org>; Mon, 17 Feb 2025 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801794; cv=none; b=pKhZDyWfKH7mKb0QYxl4ypdJsxPprWt9gZcbqrpP3soRFb5fq0aaRFEvYpW0stSh5IZt8wz6UW2pKlBLhrh0XUVEAyz2ZhiI2xStray0D36BzeaGnSGBfqBR5yWaOLAl38nJ0b1Av3ZwVZc+YT5XyDK6KCmOuZhok76u0b8iJ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801794; c=relaxed/simple;
	bh=xQgXu7LiAXEogE+z9uZWTufGuOTmjexeSXgn1tR3Q9U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xj0gf9LqKZoNPVxt+6HbZ+UFdWdLNG6Usw/LACxuuvbN6VSOD0U6oWwh4yNSTYUFXnFKP7v4CbK8/N8fVPj1m6R+iFaD6kp6CjwYlP+3h0p6I9psJJmtdMgmdfQMb5MqGeqbilFEsVhm+NcZdVNG09zh7orEFlcJJfSSKRtcPLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gm0hTyBA; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739801793; x=1771337793;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uiwueedDkX8sbB4jOK0Wlue45MqJU8u/g4SHM0Nukqw=;
  b=gm0hTyBAIR5182Au0tXMS3OWNlHRrT7euCAQHVhtIP/HC+4In7CCFKzr
   tffl2D0jD7rk0U+eQOAcLCv9WT82Yj4RxY7KOA1aN1i6iN6pgTGOPnKRB
   DE2R9ONSraboOuVjZJkrslg8WMXTLbX7wyTCmeSnoG7E4oWS9HpTfJ9oR
   M=;
X-IronPort-AV: E=Sophos;i="6.13,293,1732579200"; 
   d="scan'208";a="409286703"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 14:16:28 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:8997]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.30.55:2525] with esmtp (Farcaster)
 id 28f6094c-3f19-41d2-9183-1743a2b228fd; Mon, 17 Feb 2025 14:16:26 +0000 (UTC)
X-Farcaster-Flow-ID: 28f6094c-3f19-41d2-9183-1743a2b228fd
Received: from EX19D011EUA002.ant.amazon.com (10.252.50.195) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 17 Feb 2025 14:16:26 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D011EUA002.ant.amazon.com (10.252.50.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 17 Feb 2025 14:16:25 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Mon, 17 Feb 2025 14:16:25 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com (dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com [10.253.103.172])
	by email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com (Postfix) with ESMTP id F0AD2A0628;
	Mon, 17 Feb 2025 14:16:23 +0000 (UTC)
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Firas
 Jahjah" <firasj@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH for-next v2] RDMA/core: Fix best page size finding when it can cross SG entries
Date: Mon, 17 Feb 2025 14:16:23 +0000
Message-ID: <20250217141623.12428-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

A single scatter-gather entry is limited by a 32 bits "length" field
that is practically 4GB - PAGE_SIZE. This means that even when the
memory is physically contiguous, we might need more than one entry to
represent it. Additionally when using dmabuf, the sg_table might be
originated outside the subsystem and optimized for other needs.

For instance an SGT of 16GB GPU continuous memory might look like this:
(a real life example)

dma_address 34401400000, length fffff000
dma_address 345013ff000, length fffff000
dma_address 346013fe000, length fffff000
dma_address 347013fd000, length fffff000
dma_address 348013fc000, length 4000

Since ib_umem_find_best_pgsz works within SG entries, in the above case
we will result with the worst possible 4KB page size.

Fix this by taking into consideration only the alignment of addresses of
real discontinuity points rather than treating SG entries as such, and
adjust the page iterator to correctly handle cross SG entry pages.

There is currently an assumption that drivers do not ask for pages
bigger than maximal DMA size supported by their devices.

Reviewed-by: Firas Jahjah <firasj@amazon.com>
Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/core/umem.c  | 36 ++++++++++++++++++++++++---------
 drivers/infiniband/core/verbs.c | 11 +++++-----
 2 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 07c571c7b699..c5b686394760 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -80,9 +80,12 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 				     unsigned long pgsz_bitmap,
 				     unsigned long virt)
 {
-	struct scatterlist *sg;
+	unsigned long curr_len = 0;
+	dma_addr_t curr_base = ~0;
 	unsigned long va, pgoff;
+	struct scatterlist *sg;
 	dma_addr_t mask;
+	dma_addr_t end;
 	int i;
 
 	umem->iova = va = virt;
@@ -107,17 +110,30 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 	pgoff = umem->address & ~PAGE_MASK;
 
 	for_each_sgtable_dma_sg(&umem->sgt_append.sgt, sg, i) {
-		/* Walk SGL and reduce max page size if VA/PA bits differ
-		 * for any address.
+		/* If the current entry is physically contiguous with the previous
+		 * one, no need to take its start addresses into consideration.
 		 */
-		mask |= (sg_dma_address(sg) + pgoff) ^ va;
+		if (check_add_overflow(curr_base, curr_len, &end) ||
+		    end != sg_dma_address(sg)) {
+
+			curr_base = sg_dma_address(sg);
+			curr_len = 0;
+
+			/* Reduce max page size if VA/PA bits differ */
+			mask |= (curr_base + pgoff) ^ va;
+
+			/* The alignment of any VA matching a discontinuity point
+			* in the physical memory sets the maximum possible page
+			* size as this must be a starting point of a new page that
+			* needs to be aligned.
+			*/
+			if (i != 0)
+				mask |= va;
+		}
+
+		curr_len += sg_dma_len(sg);
 		va += sg_dma_len(sg) - pgoff;
-		/* Except for the last entry, the ending iova alignment sets
-		 * the maximum possible page size as the low bits of the iova
-		 * must be zero when starting the next chunk.
-		 */
-		if (i != (umem->sgt_append.sgt.nents - 1))
-			mask |= va;
+
 		pgoff = 0;
 	}
 
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 473ee0831307..dc40001072a5 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -3109,22 +3109,23 @@ EXPORT_SYMBOL(__rdma_block_iter_start);
 bool __rdma_block_iter_next(struct ib_block_iter *biter)
 {
 	unsigned int block_offset;
-	unsigned int sg_delta;
+	unsigned int delta;
 
 	if (!biter->__sg_nents || !biter->__sg)
 		return false;
 
 	biter->__dma_addr = sg_dma_address(biter->__sg) + biter->__sg_advance;
 	block_offset = biter->__dma_addr & (BIT_ULL(biter->__pg_bit) - 1);
-	sg_delta = BIT_ULL(biter->__pg_bit) - block_offset;
+	delta = BIT_ULL(biter->__pg_bit) - block_offset;
 
-	if (sg_dma_len(biter->__sg) - biter->__sg_advance > sg_delta) {
-		biter->__sg_advance += sg_delta;
-	} else {
+	while (biter->__sg_nents && biter->__sg &&
+	       sg_dma_len(biter->__sg) - biter->__sg_advance <= delta) {
+		delta -= sg_dma_len(biter->__sg) - biter->__sg_advance;
 		biter->__sg_advance = 0;
 		biter->__sg = sg_next(biter->__sg);
 		biter->__sg_nents--;
 	}
+	biter->__sg_advance += delta;
 
 	return true;
 }
-- 
2.47.1


