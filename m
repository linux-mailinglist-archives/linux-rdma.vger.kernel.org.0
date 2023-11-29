Return-Path: <linux-rdma+bounces-140-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2973E7FE0E9
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 21:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29EB41C20A22
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 20:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9824760ED3;
	Wed, 29 Nov 2023 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M7yAmVl0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098CFD67
	for <linux-rdma@vger.kernel.org>; Wed, 29 Nov 2023 12:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701289319; x=1732825319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=31W6JZXVjw964ovWR3NRCyhYxMPPkzH2G8WZef67O20=;
  b=M7yAmVl057C4s2hda9qCA0t/eaP4XcyUrM4yBIPN9m8HNS7Nm4bcrbrs
   hsvDtpWsLg41jMPIZ7fATsKe8LDqi3sRKj51/8L/6Qnud8I8RLN/32zqq
   EuvLvu46hFdFB3LSfgPZPS+3OZjJH1pRfUxnbp9JDJqlKtp1Sf36E9t4y
   n4z211D6CUQ9omS80uO5HH7rwGzQngcSpYH3c3sgK9AzS3hgHVcchtxVx
   HE/9luE4XX98wo7lHMrFZzsyCY/TPm+NDq8KJ8PTLhUgbw0pv8FEt7ASx
   775Xd7tg6YC4ucFqS1kJ0/h8iiiQMroo2Bf8p+bZ9enr9T/UVPvpXZn7Q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="392087194"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="392087194"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 12:21:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="859952979"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="859952979"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.124.161.227])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 12:21:58 -0800
From: Shiraz Saleem <shiraz.saleem@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v2 for-rc 1/3] RDMA/core: Fix umem iterator when PAGE_SIZE is greater then HCA pgsz
Date: Wed, 29 Nov 2023 14:21:41 -0600
Message-Id: <20231129202143.1434-2-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20231129202143.1434-1-shiraz.saleem@intel.com>
References: <20231129202143.1434-1-shiraz.saleem@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

64k pages introduce the situation in this diagram when the HCA
4k page size is being used:

 +-------------------------------------------+ <--- 64k aligned VA
 |                                           |
 |              HCA 4k page                  |
 |                                           |
 +-------------------------------------------+
 |                   o                       |
 |                                           |
 |                   o                       |
 |                                           |
 |                   o                       |
 +-------------------------------------------+
 |                                           |
 |              HCA 4k page                  |
 |                                           |
 +-------------------------------------------+ <--- Live HCA page
 |OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO| <--- offset
 |                                           | <--- VA
 |                MR data                    |
 +-------------------------------------------+
 |                                           |
 |              HCA 4k page                  |
 |                                           |
 +-------------------------------------------+
 |                   o                       |
 |                                           |
 |                   o                       |
 |                                           |
 |                   o                       |
 +-------------------------------------------+
 |                                           |
 |              HCA 4k page                  |
 |                                           |
 +-------------------------------------------+

The VA addresses are coming from rdma-core in this diagram can
be arbitrary, but for 64k pages, the VA may be offset by some
number of HCA 4k pages and followed by some number of HCA 4k
pages.

The current iterator doesn't account for either the preceding
4k pages or the following 4k pages.

Fix the issue by extending the ib_block_iter to contain
the number of DMA pages like comment [1] says and by using
__sg_advance to start the iterator at the first live HCA page.

The changes are contained in a parallel set of iterator start
and next functions that are umem aware and specfic to umem
since there is one user of the rdma_for_each_block() without
umem.

These two fixes prevents the extra pages before and after the
user MR data.

Fix the preceding pages by using the __sq_advance field to start
at the first 4k page containing MR data.

Fix the following pages by saving the number of pgsz blocks in
the iterator state and downcounting on each next.

This fix allows for the elimination of the small page crutch noted
in the Fixes.

Fixes: 10c75ccb54e4 ("RDMA/umem: Prevent small pages from being returned by ib_umem_find_best_pgsz()")
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/rdma/ib_umem.h#n91 [1]
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/core/umem.c | 6 ------
 include/rdma/ib_umem.h         | 9 ++++++++-
 include/rdma/ib_verbs.h        | 1 +
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index f9ab671c8eda..07c571c7b699 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -96,12 +96,6 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 		return page_size;
 	}
 
-	/* rdma_for_each_block() has a bug if the page size is smaller than the
-	 * page size used to build the umem. For now prevent smaller page sizes
-	 * from being returned.
-	 */
-	pgsz_bitmap &= GENMASK(BITS_PER_LONG - 1, PAGE_SHIFT);
-
 	/* The best result is the smallest page size that results in the minimum
 	 * number of required pages. Compute the largest page size that could
 	 * work based on VA address bits that don't change.
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 95896472a82b..726773747764 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -77,6 +77,13 @@ static inline void __rdma_umem_block_iter_start(struct ib_block_iter *biter,
 {
 	__rdma_block_iter_start(biter, umem->sgt_append.sgt.sgl,
 				umem->sgt_append.sgt.nents, pgsz);
+	biter->__sg_advance = ib_umem_offset(umem) & ~(pgsz - 1);
+	biter->__sg_numblocks = ib_umem_num_dma_blocks(umem, pgsz);
+}
+
+static inline bool __rdma_umem_block_iter_next(struct ib_block_iter *biter)
+{
+	     return __rdma_block_iter_next(biter) && biter->__sg_numblocks--;
 }
 
 /**
@@ -92,7 +99,7 @@ static inline void __rdma_umem_block_iter_start(struct ib_block_iter *biter,
  */
 #define rdma_umem_for_each_dma_block(umem, biter, pgsz)                        \
 	for (__rdma_umem_block_iter_start(biter, umem, pgsz);                  \
-	     __rdma_block_iter_next(biter);)
+	     __rdma_umem_block_iter_next(biter);)
 
 #ifdef CONFIG_INFINIBAND_USER_MEM
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index fb1a2d6b1969..b7b6b58dd348 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2850,6 +2850,7 @@ struct ib_block_iter {
 	/* internal states */
 	struct scatterlist *__sg;	/* sg holding the current aligned block */
 	dma_addr_t __dma_addr;		/* unaligned DMA address of this block */
+	size_t __sg_numblocks;		/* ib_umem_num_dma_blocks() */
 	unsigned int __sg_nents;	/* number of SG entries */
 	unsigned int __sg_advance;	/* number of bytes to advance in sg in next step */
 	unsigned int __pg_bit;		/* alignment of current block */
-- 
1.8.3.1


