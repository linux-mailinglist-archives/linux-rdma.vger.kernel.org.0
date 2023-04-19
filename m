Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26366E72C1
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Apr 2023 07:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjDSFzK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Apr 2023 01:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDSFzJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Apr 2023 01:55:09 -0400
X-Greylist: delayed 107 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Apr 2023 22:54:38 PDT
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0AF6A65;
        Tue, 18 Apr 2023 22:54:38 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="113885396"
X-IronPort-AV: E=Sophos;i="5.99,208,1677510000"; 
   d="scan'208";a="113885396"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 14:52:57 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 03BE6D42C8;
        Wed, 19 Apr 2023 14:52:55 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (m3003.s.css.fujitsu.com [10.128.233.114])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id C9599BCB79;
        Wed, 19 Apr 2023 14:52:53 +0900 (JST)
Received: from localhost.localdomain (unknown [10.118.237.106])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 82D7C2005334;
        Wed, 19 Apr 2023 14:52:53 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v4 3/8] RDMA/rxe: Make MR functions accessible from other rxe source code
Date:   Wed, 19 Apr 2023 14:51:55 +0900
Message-Id: <2f4b8ab05f4d8495e6a190fb54e087b25c34e029.1681882651.git.matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1681882651.git.matsuda-daisuke@fujitsu.com>
References: <cover.1681882651.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Some functions in rxe_mr.c are going to be used in rxe_odp.c, which is to
be created in the subsequent patch. List the declarations of the functions
in rxe_loc.h.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h | 14 ++++++++++++++
 drivers/infiniband/sw/rxe/rxe_mr.c  | 18 ++++--------------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index bf28ac13c3f5..3476726425d9 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -60,7 +60,9 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 
 /* rxe_mr.c */
 u8 rxe_get_next_key(u32 last_key);
+void rxe_mr_init(int access, struct rxe_mr *mr);
 void rxe_mr_init_dma(int access, struct rxe_mr *mr);
+int rxe_mr_fill_pages_from_sgt(struct rxe_mr *mr, struct sg_table *sgt);
 int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr);
 int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
@@ -71,6 +73,8 @@ int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
 	      void *addr, int length, enum rxe_mr_copy_dir dir);
 int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 		  int sg_nents, unsigned int *sg_offset);
+int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
+		       unsigned int length, enum rxe_mr_copy_dir dir);
 int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 			u64 compare, u64 swap_add, u64 *orig_val);
 int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
@@ -82,6 +86,16 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 key);
 int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 void rxe_mr_cleanup(struct rxe_pool_elem *elem);
 
+static inline unsigned long rxe_mr_iova_to_index(struct rxe_mr *mr, u64 iova)
+{
+	return (iova >> mr->page_shift) - (mr->ibmr.iova >> mr->page_shift);
+}
+
+static inline unsigned long rxe_mr_iova_to_page_offset(struct rxe_mr *mr, u64 iova)
+{
+	return iova & (mr_page_size(mr) - 1);
+}
+
 /* rxe_mw.c */
 int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
 int rxe_dealloc_mw(struct ib_mw *ibmw);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 0e538fafcc20..ffbac6f5e828 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -49,7 +49,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 				| IB_ACCESS_REMOTE_WRITE	\
 				| IB_ACCESS_REMOTE_ATOMIC)
 
-static void rxe_mr_init(int access, struct rxe_mr *mr)
+void rxe_mr_init(int access, struct rxe_mr *mr)
 {
 	u32 lkey = mr->elem.index << 8 | rxe_get_next_key(-1);
 	u32 rkey = (access & IB_ACCESS_REMOTE) ? lkey : 0;
@@ -77,16 +77,6 @@ void rxe_mr_init_dma(int access, struct rxe_mr *mr)
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
@@ -96,7 +86,7 @@ static bool is_pmem_page(struct page *pg)
 				 IORES_DESC_PERSISTENT_MEMORY);
 }
 
-static int rxe_mr_fill_pages_from_sgt(struct rxe_mr *mr, struct sg_table *sgt)
+int rxe_mr_fill_pages_from_sgt(struct rxe_mr *mr, struct sg_table *sgt)
 {
 	XA_STATE(xas, &mr->page_list, 0);
 	struct sg_page_iter sg_iter;
@@ -247,8 +237,8 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
 	return ib_sg_to_pages(ibmr, sgl, sg_nents, sg_offset, rxe_set_page);
 }
 
-static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
-			      unsigned int length, enum rxe_mr_copy_dir dir)
+int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
+		       unsigned int length, enum rxe_mr_copy_dir dir)
 {
 	unsigned int page_offset = rxe_mr_iova_to_page_offset(mr, iova);
 	unsigned long index = rxe_mr_iova_to_index(mr, iova);
-- 
2.39.1

