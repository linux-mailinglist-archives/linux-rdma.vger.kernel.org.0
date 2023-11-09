Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A9E7E6361
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Nov 2023 06:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjKIFrK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Nov 2023 00:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjKIFq5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Nov 2023 00:46:57 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Nov 2023 21:46:42 PST
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BD42705;
        Wed,  8 Nov 2023 21:46:42 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="139093709"
X-IronPort-AV: E=Sophos;i="6.03,288,1694703600"; 
   d="scan'208";a="139093709"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 14:45:37 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 85FA9DC146;
        Thu,  9 Nov 2023 14:45:35 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id B7FAAD52D3;
        Thu,  9 Nov 2023 14:45:34 +0900 (JST)
Received: from localhost.localdomain (unknown [10.118.237.107])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 735122005323;
        Thu,  9 Nov 2023 14:45:34 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v7 2/7] RDMA/rxe: Make MR functions accessible from other rxe source code
Date:   Thu,  9 Nov 2023 14:44:47 +0900
Message-Id: <945befecbcb4d7c0a3a02d03cfa444aafc7c27b8.1699503619.git.matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1699503619.git.matsuda-daisuke@fujitsu.com>
References: <cover.1699503619.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Some functions in rxe_mr.c are going to be used in rxe_odp.c, which is to
be created in the subsequent patch. List the declarations of the functions
in rxe_loc.h.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h |  8 ++++++++
 drivers/infiniband/sw/rxe/rxe_mr.c  | 11 +++--------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 4d2a8ef52c85..eb867f7d0d36 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -58,6 +58,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 
 /* rxe_mr.c */
 u8 rxe_get_next_key(u32 last_key);
+void rxe_mr_init(int access, struct rxe_mr *mr);
 void rxe_mr_init_dma(int access, struct rxe_mr *mr);
 int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr);
@@ -69,6 +70,8 @@ int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
 	      void *addr, int length, enum rxe_mr_copy_dir dir);
 int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 		  int sg_nents, unsigned int *sg_offset);
+int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
+		       unsigned int length, enum rxe_mr_copy_dir dir);
 int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 			u64 compare, u64 swap_add, u64 *orig_val);
 int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
@@ -80,6 +83,11 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 key);
 int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 void rxe_mr_cleanup(struct rxe_pool_elem *elem);
 
+static inline unsigned long rxe_mr_iova_to_index(struct rxe_mr *mr, u64 iova)
+{
+	return (iova >> mr->page_shift) - (mr->ibmr.iova >> mr->page_shift);
+}
+
 /* rxe_mw.c */
 int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
 int rxe_dealloc_mw(struct ib_mw *ibmw);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index f54042e9aeb2..86b1908d304b 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -45,7 +45,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 	}
 }
 
-static void rxe_mr_init(int access, struct rxe_mr *mr)
+void rxe_mr_init(int access, struct rxe_mr *mr)
 {
 	u32 key = mr->elem.index << 8 | rxe_get_next_key(-1);
 
@@ -72,11 +72,6 @@ void rxe_mr_init_dma(int access, struct rxe_mr *mr)
 	mr->ibmr.type = IB_MR_TYPE_DMA;
 }
 
-static unsigned long rxe_mr_iova_to_index(struct rxe_mr *mr, u64 iova)
-{
-	return (iova >> mr->page_shift) - (mr->ibmr.iova >> mr->page_shift);
-}
-
 static unsigned long rxe_mr_iova_to_page_offset(struct rxe_mr *mr, u64 iova)
 {
 	return iova & (mr_page_size(mr) - 1);
@@ -242,8 +237,8 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
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

