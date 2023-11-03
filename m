Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E147E003F
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Nov 2023 11:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347478AbjKCJ55 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Nov 2023 05:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347425AbjKCJ54 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Nov 2023 05:57:56 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Nov 2023 02:57:09 PDT
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BE719BC;
        Fri,  3 Nov 2023 02:57:08 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="137953602"
X-IronPort-AV: E=Sophos;i="6.03,273,1694703600"; 
   d="scan'208";a="137953602"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 18:56:02 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5147ED3EAC;
        Fri,  3 Nov 2023 18:55:59 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 817E7C8BFE;
        Fri,  3 Nov 2023 18:55:58 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 15438E5E53;
        Fri,  3 Nov 2023 18:55:58 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by edo.cn.fujitsu.com (Postfix) with ESMTP id 83B731A006F;
        Fri,  3 Nov 2023 17:55:57 +0800 (CST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        matsuda-daisuke@fujitsu.com, bvanassche@acm.org,
        yi.zhang@redhat.com, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH RFC V2 4/6] RDMA/rxe: Use PAGE_SIZE and PAGE_SHIFT to extract address from page_list
Date:   Fri,  3 Nov 2023 17:55:47 +0800
Message-ID: <20231103095549.490744-5-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231103095549.490744-1-lizhijian@fujitsu.com>
References: <20231103095549.490744-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27974.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27974.006
X-TMASE-Result: 10--5.509000-10.000000
X-TMASE-MatchedRID: VULvqRy0JHoHl9LdO3B7p4Olbll4OMtkyiKgKtIyB4qe38zXnNg9Q2ZY
        /RdXrUKNkAkq19PK0vC12HagvbwDji/7QU2czuUNA9lly13c/gFb4dXBMpIkhqoDeu6wu7bqE0o
        8W+GU3zCqyptwK2nPv7Qj8USEuwVGZSqIGAn5t/jknMSTG9lH+MZiegX8JN5lmyiLZetSf8mfop
        0ytGwvXiq2rl3dzGQ1dQgZJSoREhTm9DV/P8jWkbzOOaYWQHGCZ3g1SwoJbflW8/kkz9GZ0g==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

As we said in previous commit, page_list only stores PAGE_SIZE page, so
when we extract an address from the page_list, we should use PAGE_SIZE
and PAGE_SHIFT instead of the ibmr.page_size.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 42 +++++++++------------------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  5 ----
 2 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index bbfedcd8d2cb..d39c02f0c51e 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -72,16 +72,6 @@ void rxe_mr_init_dma(int access, struct rxe_mr *mr)
 	mr->ibmr.type = IB_MR_TYPE_DMA;
 }
 
-static unsigned long rxe_mr_iova_to_index(struct rxe_mr *mr, u64 iova)
-{
-	return (iova >> mr->page_shift) - (mr->ibmr.iova >> mr->page_shift);
-}
-
-static unsigned long rxe_mr_iova_to_page_offset(struct rxe_mr *mr, u64 iova)
-{
-	return iova & (mr_page_size(mr) - 1);
-}
-
 static bool is_pmem_page(struct page *pg)
 {
 	unsigned long paddr = page_to_phys(pg);
@@ -232,17 +222,16 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
 		  int sg_nents, unsigned int *sg_offset)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
-	unsigned int page_size = mr_page_size(mr);
 
-	if (page_size != PAGE_SIZE) {
+	if (ibmr->page_size != PAGE_SIZE) {
 		rxe_err_mr(mr, "Unsupport mr page size %x, expect PAGE_SIZE(%lx)\n",
-			   page_size, PAGE_SIZE);
+			   ibmr->page_size, PAGE_SIZE);
 		return -EINVAL;
 	}
 
 	mr->nbuf = 0;
-	mr->page_shift = ilog2(page_size);
-	mr->page_mask = ~((u64)page_size - 1);
+	mr->page_shift = PAGE_SHIFT;
+	mr->page_mask = PAGE_MASK;
 
 	return ib_sg_to_pages(ibmr, sgl, sg_nents, sg_offset, rxe_set_page);
 }
@@ -250,8 +239,8 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
 static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
 			      unsigned int length, enum rxe_mr_copy_dir dir)
 {
-	unsigned int page_offset = rxe_mr_iova_to_page_offset(mr, iova);
-	unsigned long index = rxe_mr_iova_to_index(mr, iova);
+	unsigned int page_offset = iova & (PAGE_SIZE - 1);
+	unsigned long index = (iova - mr->ibmr.iova) >> PAGE_SHIFT;
 	unsigned int bytes;
 	struct page *page;
 	void *va;
@@ -261,8 +250,7 @@ static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
 		if (!page)
 			return -EFAULT;
 
-		bytes = min_t(unsigned int, length,
-				mr_page_size(mr) - page_offset);
+		bytes = min_t(unsigned int, length, PAGE_SIZE - page_offset);
 		va = kmap_local_page(page);
 		if (dir == RXE_FROM_MR_OBJ)
 			memcpy(addr, va + page_offset, bytes);
@@ -450,14 +438,12 @@ int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length)
 		return err;
 
 	while (length > 0) {
-		index = rxe_mr_iova_to_index(mr, iova);
+		index = (iova - mr->ibmr.iova) >> PAGE_SHIFT;
 		page = xa_load(&mr->page_list, index);
-		page_offset = rxe_mr_iova_to_page_offset(mr, iova);
+		page_offset = iova & (PAGE_SIZE - 1);
 		if (!page)
 			return -EFAULT;
-		bytes = min_t(unsigned int, length,
-				mr_page_size(mr) - page_offset);
-
+		bytes = min_t(unsigned int, length, PAGE_SIZE - page_offset);
 		va = kmap_local_page(page);
 		arch_wb_cache_pmem(va + page_offset, bytes);
 		kunmap_local(va);
@@ -498,8 +484,8 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 			rxe_dbg_mr(mr, "iova out of range");
 			return RESPST_ERR_RKEY_VIOLATION;
 		}
-		page_offset = rxe_mr_iova_to_page_offset(mr, iova);
-		index = rxe_mr_iova_to_index(mr, iova);
+		page_offset = iova & (PAGE_SIZE - 1);
+		index = (iova - mr->ibmr.iova) >> PAGE_SHIFT;
 		page = xa_load(&mr->page_list, index);
 		if (!page)
 			return RESPST_ERR_RKEY_VIOLATION;
@@ -556,8 +542,8 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 			rxe_dbg_mr(mr, "iova out of range");
 			return RESPST_ERR_RKEY_VIOLATION;
 		}
-		page_offset = rxe_mr_iova_to_page_offset(mr, iova);
-		index = rxe_mr_iova_to_index(mr, iova);
+		page_offset = iova & (PAGE_SIZE - 1);
+		index = (iova - mr->ibmr.iova) >> PAGE_SHIFT;
 		page = xa_load(&mr->page_list, index);
 		if (!page)
 			return RESPST_ERR_RKEY_VIOLATION;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 11647e976282..ccc75f8c0985 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -318,11 +318,6 @@ struct rxe_mr {
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
2.41.0

