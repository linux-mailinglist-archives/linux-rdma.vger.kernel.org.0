Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133AC5B1804
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 11:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiIHJID (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 05:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiIHJID (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 05:08:03 -0400
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E593A896D
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 02:08:01 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="66535390"
X-IronPort-AV: E=Sophos;i="5.93,299,1654527600"; 
   d="scan'208";a="66535390"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP; 08 Sep 2022 18:07:59 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 26442DAFCF
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 18:07:58 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (m3003.s.css.fujitsu.com [10.128.233.114])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4C139F7DB
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 18:07:57 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 20F8B200B435;
        Thu,  8 Sep 2022 18:07:57 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     leonro@nvidia.com, jgg@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     liangwenpeng@huawei.com, liweihang@huawei.com, yishaih@nvidia.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH 2/2] RDMA/rxe: Use members of generic struct in rxe_mr
Date:   Thu,  8 Sep 2022 18:07:08 +0900
Message-Id: <20220908090708.3997456-2-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220908090708.3997456-1-matsuda-daisuke@fujitsu.com>
References: <20220908090708.3997456-1-matsuda-daisuke@fujitsu.com>
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

rxe_mr and ib_mr have interchangeable members. Remove device specific
members and use ones in the generic struct. Both 'iova' and 'length' are
filled in ib_uverbs layer after MR registration.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 10 ++++------
 drivers/infiniband/sw/rxe/rxe_mw.c    |  6 +++---
 drivers/infiniband/sw/rxe/rxe_verbs.c |  4 +---
 drivers/infiniband/sw/rxe/rxe_verbs.h |  2 --
 4 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 814116ec4778..6b0c2e7b8145 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -32,8 +32,8 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 
 	case IB_MR_TYPE_USER:
 	case IB_MR_TYPE_MEM_REG:
-		if (iova < mr->iova || length > mr->length ||
-		    iova > mr->iova + mr->length - length)
+		if (iova < mr->ibmr.iova || length > mr->ibmr.length ||
+		    iova > mr->ibmr.iova + mr->ibmr.length - length)
 			return -EFAULT;
 		return 0;
 
@@ -178,8 +178,6 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	mr->ibmr.pd = &pd->ibpd;
 	mr->umem = umem;
 	mr->access = access;
-	mr->length = length;
-	mr->iova = iova;
 	mr->offset = ib_umem_offset(umem);
 	mr->state = RXE_MR_STATE_VALID;
 	mr->type = IB_MR_TYPE_USER;
@@ -221,7 +219,7 @@ int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
 static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
 			size_t *offset_out)
 {
-	size_t offset = iova - mr->iova + mr->offset;
+	size_t offset = iova - mr->ibmr.iova + mr->offset;
 	int			map_index;
 	int			buf_index;
 	u64			length;
@@ -604,7 +602,7 @@ int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	mr->access = access;
 	mr->lkey = key;
 	mr->rkey = (access & IB_ACCESS_REMOTE) ? key : 0;
-	mr->iova = wqe->wr.wr.reg.mr->iova;
+	mr->ibmr.iova = wqe->wr.wr.reg.mr->iova;
 	mr->state = RXE_MR_STATE_VALID;
 
 	return 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 104993801a80..902b7df7aaed 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -114,15 +114,15 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 
 	/* C10-75 */
 	if (mw->access & IB_ZERO_BASED) {
-		if (unlikely(wqe->wr.wr.mw.length > mr->length)) {
+		if (unlikely(wqe->wr.wr.mw.length > mr->ibmr.length)) {
 			pr_err_once(
 				"attempt to bind a ZB MW outside of the MR\n");
 			return -EINVAL;
 		}
 	} else {
-		if (unlikely((wqe->wr.wr.mw.addr < mr->iova) ||
+		if (unlikely((wqe->wr.wr.mw.addr < mr->ibmr.iova) ||
 			     ((wqe->wr.wr.mw.addr + wqe->wr.wr.mw.length) >
-			      (mr->iova + mr->length)))) {
+			      (mr->ibmr.iova + mr->ibmr.length)))) {
 			pr_err_once(
 				"attempt to bind a VA MW outside of the MR\n");
 			return -EINVAL;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 9ebe9decad34..da1c484798dd 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1007,11 +1007,9 @@ static int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 
 	n = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, rxe_set_page);
 
-	mr->iova = ibmr->iova;
-	mr->length = ibmr->length;
 	mr->page_shift = ilog2(ibmr->page_size);
 	mr->page_mask = ibmr->page_size - 1;
-	mr->offset = mr->iova & mr->page_mask;
+	mr->offset = ibmr->iova & mr->page_mask;
 
 	return n;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index a51819d0c345..5f5cbfcb3569 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -305,8 +305,6 @@ struct rxe_mr {
 	u32			rkey;
 	enum rxe_mr_state	state;
 	enum ib_mr_type		type;
-	u64			iova;
-	size_t			length;
 	u32			offset;
 	int			access;
 
-- 
2.31.1

