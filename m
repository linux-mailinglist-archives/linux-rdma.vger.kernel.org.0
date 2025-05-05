Return-Path: <linux-rdma+bounces-10020-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB015AAACC3
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 04:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2132D169985
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 02:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C623CDB83;
	Mon,  5 May 2025 23:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba1jMMUy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F89E3A6F97;
	Mon,  5 May 2025 23:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487009; cv=none; b=GxHFd6Zu5OeRTsb9bYHXM0BGRdJYHWHxwFl3/b6uygD2YS3K85Zvk1tqeY+gkepLp/iAzvf1i5G1XKQ/22Q/qhaCksvFCisSaiVt2Cw1YJclILcD4oO+SetODVMXNg7iFi/PDbhMHuZNvbLlSr0LudKYIZllUEGm3Ukah38G4pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487009; c=relaxed/simple;
	bh=P9SF1ybADYKoGQiqDuLrMRKeuvK/iNSd3RpUFcB4AN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZoU8AfrOGQendYrPBcjh26WooES23jq8UW+tASFyW+BzxwhHl45RZzARUTX54bW3WaP3jVQNI3Osh3fYaxdArMd6cpGrnBAfGrOzD+ZCnscY6Osy+J1YEFntRwwe6lAGgvax3RO7yVkxAr+5FP7jekgvaHKM1Lmf2nT0TO7MQKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ba1jMMUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9B3C4CEE4;
	Mon,  5 May 2025 23:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487009;
	bh=P9SF1ybADYKoGQiqDuLrMRKeuvK/iNSd3RpUFcB4AN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ba1jMMUyjUCUrDbZusVhQIcmPhk9RAbJsjdQz5FZaxVMs13pEaQ9veumXdp8D2MB9
	 72IvWXak6n0J1IJR/cRcaQZXKY+XiF9QV/E89X8ybIRFl+1SrGkEv/bgd+EXaFazFB
	 +TO963hRvKStuHp1BLlz8AG6De9UT6jy7RA8V6VYX0up+u89vaXNpZqOnJEP/mLt7K
	 R0/5KVrsoR/wnGMjhe2P3V8niQaAONwdo4VRMM7vUpj6MSi1/WOxjr4vMSpsHw1Nd7
	 XnZqRDdqv2P1hQfDD7B/jVNnMmq+qNPp54LLFFqBGRN1hUs8FGzC6KQ8Xpyrai4RtQ
	 FlxDjAc8fvoRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Margolin <mrgolin@amazon.com>,
	Firas Jahjah <firasj@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mgurtovoy@nvidia.com,
	phaddad@nvidia.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 105/153] RDMA/core: Fix best page size finding when it can cross SG entries
Date: Mon,  5 May 2025 19:12:32 -0400
Message-Id: <20250505231320.2695319-105-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

From: Michael Margolin <mrgolin@amazon.com>

[ Upstream commit 486055f5e09df959ad4e3aa4ee75b5c91ddeec2e ]

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
Link: https://patch.msgid.link/20250217141623.12428-1-mrgolin@amazon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/umem.c  | 36 ++++++++++++++++++++++++---------
 drivers/infiniband/core/verbs.c | 11 +++++-----
 2 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 8ce569bf7525e..1d154055a335b 100644
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
index cae013130eb1d..bdc9564f0ff82 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2967,22 +2967,23 @@ EXPORT_SYMBOL(__rdma_block_iter_start);
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
2.39.5


