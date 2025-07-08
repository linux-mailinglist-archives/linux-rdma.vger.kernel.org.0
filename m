Return-Path: <linux-rdma+bounces-11971-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD55AFD859
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 22:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B5017A4F08
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 20:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074172417C2;
	Tue,  8 Jul 2025 20:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="qUERDrFl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E60E14EC73
	for <linux-rdma@vger.kernel.org>; Tue,  8 Jul 2025 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006208; cv=none; b=uAuU7xh7iOka9Bwq+EF1VDOXMjOM5FXXH3Px8y6fPuLmhqW2rMA/AXJQUWysXMjp9eVxyh0s+GDR2z4TSoQOA2DRMRhdiRseEg5EUN6yhSE006yl/1H3LX1jtZHeYVz4liSE+fdie8tCoQ2n8qoq1WZZcDlOy/qGR5lSr2AsEV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006208; c=relaxed/simple;
	bh=m1Rv1Bl4QYEd+wp4lJK47T4mb5en1c1aTJSxdx8W+1I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYcJqlaPO4LxO4v1bFOGcNOBPnmgDVad0JsTDCbzB5EAr8EeGTDnmSuvqKfzNpbdbaSDuNCa+aZYgVWwsbpnE9IEi0CN83Mggpz43ipwSPJ2lDbVjKOo3h0ETL6g5exAkX9jZ+g/6LinyRPQzGKckXmULKEFKg7PwOnumwTmDuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=qUERDrFl; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1752006207; x=1783542207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A4NDqW0wEASA88iAlkn8KgmK92ZOBCGjLReUwJseVoU=;
  b=qUERDrFlw2q2OGZvrXF8TN2bj1EfIafj9tKhGDbQE2HW45njKno+cWDR
   MpWovzK7fpp0PdBwen9EAuEAdilnriISvtFUhdeHCp3nGUg7XD8yQxGxN
   IJzK8v8uJfd4XgxRvEHc+oEwHqUIOCKUOPTI2WmX75sw7eBNO+tbfUK1q
   /7zT9iH3S+rG2fR8tVTP2d9iodcgjJr5KgbiBcgHc0l1E7ruiQz1HPhPg
   DkJK1SL/4emmvkq20dtBcFGGKEPNLp/WRBHU90X1aZ7HECQ6X0nE1xm2z
   O7UNkx6iFU/Gw4JyalgSdZkIQOq5PFl2A3m+U4+/oFPQghSmUTf7kCXz6
   g==;
X-IronPort-AV: E=Sophos;i="6.16,298,1744070400"; 
   d="scan'208";a="36371867"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:23:21 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:64163]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.9.212:2525] with esmtp (Farcaster)
 id c9e1865d-3230-4d2b-bf5f-11938478773b; Tue, 8 Jul 2025 20:23:20 +0000 (UTC)
X-Farcaster-Flow-ID: c9e1865d-3230-4d2b-bf5f-11938478773b
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Jul 2025 20:23:19 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D031EUB003.ant.amazon.com (10.252.61.88) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Tue, 8 Jul 2025
 20:23:17 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>
Subject: [PATCH for-next v2 2/3] RDMA/core: Add umem "is_contiguous" and "start_dma_addr" helpers
Date: Tue, 8 Jul 2025 20:23:07 +0000
Message-ID: <20250708202308.24783-3-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250708202308.24783-1-mrgolin@amazon.com>
References: <20250708202308.24783-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)

In some cases drivers may need to check if a given umem is contiguous.
Add a helper function in core code so that drivers don't need to deal
with umem or scatter-gather lists structure.
Additionally add a helper for getting umem's start DMA address and use
it in other helper functions that open code it.

Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 include/rdma/ib_umem.h | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 7dc7b1cc71b5..0a8e092c0ea8 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -52,11 +52,15 @@ static inline int ib_umem_offset(struct ib_umem *umem)
 	return umem->address & ~PAGE_MASK;
 }
 
+static inline dma_addr_t ib_umem_start_dma_addr(struct ib_umem *umem)
+{
+	return sg_dma_address(umem->sgt_append.sgt.sgl) + ib_umem_offset(umem);
+}
+
 static inline unsigned long ib_umem_dma_offset(struct ib_umem *umem,
 					       unsigned long pgsz)
 {
-	return (sg_dma_address(umem->sgt_append.sgt.sgl) + ib_umem_offset(umem)) &
-	       (pgsz - 1);
+	return ib_umem_start_dma_addr(umem) & (pgsz - 1);
 }
 
 static inline size_t ib_umem_num_dma_blocks(struct ib_umem *umem,
@@ -135,14 +139,27 @@ static inline unsigned long ib_umem_find_best_pgoff(struct ib_umem *umem,
 						    unsigned long pgsz_bitmap,
 						    u64 pgoff_bitmask)
 {
-	struct scatterlist *sg = umem->sgt_append.sgt.sgl;
 	dma_addr_t dma_addr;
 
-	dma_addr = sg_dma_address(sg) + (umem->address & ~PAGE_MASK);
+	dma_addr = ib_umem_start_dma_addr(umem);
 	return ib_umem_find_best_pgsz(umem, pgsz_bitmap,
 				      dma_addr & pgoff_bitmask);
 }
 
+static inline bool ib_umem_is_contiguous(struct ib_umem *umem)
+{
+	dma_addr_t dma_addr;
+	unsigned long pgsz;
+
+	/*
+	 * Select the smallest aligned page that can contain the whole umem if
+	 * it was contiguous.
+	 */
+	dma_addr = ib_umem_start_dma_addr(umem);
+	pgsz = roundup_pow_of_two((dma_addr ^ (umem->length - 1 + dma_addr)) + 1);
+	return !!ib_umem_find_best_pgoff(umem, pgsz, U64_MAX);
+}
+
 struct ib_umem_dmabuf *ib_umem_dmabuf_get(struct ib_device *device,
 					  unsigned long offset, size_t size,
 					  int fd, int access,
-- 
2.47.1


