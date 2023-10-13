Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19C07C7B1B
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Oct 2023 03:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjJMBQ6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Oct 2023 21:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJMBQ6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Oct 2023 21:16:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E263183
        for <linux-rdma@vger.kernel.org>; Thu, 12 Oct 2023 18:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697159816; x=1728695816;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8RuBkrRji07HlwA9sWtBYP/iQOqQUybFi4f6zHvClkk=;
  b=eN2doTFwJMDK+Hlwitk1UUba/2VhQ4wyDFcioP8oKLuxEFvBTC9Qdjo8
   6qZqWt0A5rijUBfKmVQ+1XY/DuBlUIDntPnw2OZEJg4lN211CoPJVGutz
   N0ADD9QYhB9yK8rsQjejjrzbmJFmrqiShMNtK3zymmnOqP87YG02hFho7
   O3ROA1yp+OUvpYBAyJ775tYlIagOekzfeGWuYr/88IvtXbKgCjzBCF0bP
   V5BTPJk6Yn+LBdPuW1lvBG6N34Kymw94Rb3TprVFvwqbqFbVpeblgpYMe
   KBe9//+P3JHPhm9IoCUm82kx2VNvaWzZR0GSBPh2XAVjdkyxmKqhcCv3U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="388942438"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="388942438"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 18:16:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="898352303"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="898352303"
Received: from intel-85-97.bj.intel.com ([10.238.154.97])
  by fmsmga001.fm.intel.com with ESMTP; 12 Oct 2023 18:15:04 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, yi.zhang@redhat.com
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with 64k page size
Date:   Thu, 12 Oct 2023 21:18:03 -0400
Message-Id: <20231013011803.70474-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

The page_size of mr is set in infiniband core originally. In the commit
325a7eb85199 ("RDMA/rxe: Cleanup page variables in rxe_mr.c"), the
page_size is also set. Sometime this will cause conflict.

Fixes: 325a7eb85199 ("RDMA/rxe: Cleanup page variables in rxe_mr.c")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/all/CAHj4cs9XRqE25jyVw9rj9YugffLn5+f=1znaBEnu1usLOciD+g@mail.gmail.com/T/
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 11 ++++-------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  5 -----
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index f54042e9aeb2..dc9d31bfb689 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -58,7 +58,6 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
 	mr->rkey = mr->ibmr.rkey = key;
 
 	mr->access = access;
-	mr->ibmr.page_size = PAGE_SIZE;
 	mr->page_mask = PAGE_MASK;
 	mr->page_shift = PAGE_SHIFT;
 	mr->state = RXE_MR_STATE_INVALID;
@@ -79,7 +78,7 @@ static unsigned long rxe_mr_iova_to_index(struct rxe_mr *mr, u64 iova)
 
 static unsigned long rxe_mr_iova_to_page_offset(struct rxe_mr *mr, u64 iova)
 {
-	return iova & (mr_page_size(mr) - 1);
+	return iova & (PAGE_SIZE - 1);
 }
 
 static bool is_pmem_page(struct page *pg)
@@ -232,7 +231,7 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
 		  int sg_nents, unsigned int *sg_offset)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
-	unsigned int page_size = mr_page_size(mr);
+	unsigned int page_size = ibmr->page_size;
 
 	mr->nbuf = 0;
 	mr->page_shift = ilog2(page_size);
@@ -256,8 +255,7 @@ static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
 		if (!page)
 			return -EFAULT;
 
-		bytes = min_t(unsigned int, length,
-				mr_page_size(mr) - page_offset);
+		bytes = min_t(unsigned int, length, PAGE_SIZE - page_offset);
 		va = kmap_local_page(page);
 		if (dir == RXE_FROM_MR_OBJ)
 			memcpy(addr, va + page_offset, bytes);
@@ -450,8 +448,7 @@ int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length)
 		page_offset = rxe_mr_iova_to_page_offset(mr, iova);
 		if (!page)
 			return -EFAULT;
-		bytes = min_t(unsigned int, length,
-				mr_page_size(mr) - page_offset);
+		bytes = min_t(unsigned int, length, PAGE_SIZE - page_offset);
 
 		va = kmap_local_page(page);
 		arch_wb_cache_pmem(va + page_offset, bytes);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index ccb9d19ffe8a..9fcaa974e079 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -319,11 +319,6 @@ struct rxe_mr {
 	struct xarray		page_list;
 };
 
-static inline unsigned int mr_page_size(struct rxe_mr *mr)
-{
-	return mr ? mr->ibmr.page_size : PAGE_SIZE;
-}
-
 enum rxe_mw_state {
 	RXE_MW_STATE_INVALID	= RXE_MR_STATE_INVALID,
 	RXE_MW_STATE_FREE	= RXE_MR_STATE_FREE,
-- 
2.40.1

