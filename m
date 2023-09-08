Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AAD798258
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Sep 2023 08:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241142AbjIHG1P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Sep 2023 02:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241855AbjIHG1O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Sep 2023 02:27:14 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E4C19A6;
        Thu,  7 Sep 2023 23:27:07 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="132651174"
X-IronPort-AV: E=Sophos;i="6.02,236,1688396400"; 
   d="scan'208";a="132651174"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 15:27:04 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 38D76C3F80;
        Fri,  8 Sep 2023 15:27:01 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 820BFE67AE;
        Fri,  8 Sep 2023 15:27:00 +0900 (JST)
Received: from localhost.localdomain (unknown [10.118.237.107])
        by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 4F8B92005B08;
        Fri,  8 Sep 2023 15:27:00 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v6 2/7] RDMA/rxe: Make MR functions accessible from other rxe source code
Date:   Fri,  8 Sep 2023 15:26:43 +0900
Message-Id: <78a170cbd55fce11f455968016cd3a161822ccd0.1694153251.git.matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1694153251.git.matsuda-daisuke@fujitsu.com>
References: <cover.1694153251.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
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

