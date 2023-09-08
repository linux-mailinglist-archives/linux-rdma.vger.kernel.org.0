Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1AC798265
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Sep 2023 08:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjIHG3g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Sep 2023 02:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjIHG3g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Sep 2023 02:29:36 -0400
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0553A2116;
        Thu,  7 Sep 2023 23:28:47 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="110627120"
X-IronPort-AV: E=Sophos;i="6.02,236,1688396400"; 
   d="scan'208";a="110627120"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 15:27:09 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id EE274DDC6A;
        Fri,  8 Sep 2023 15:27:05 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 20294D621A;
        Fri,  8 Sep 2023 15:27:05 +0900 (JST)
Received: from localhost.localdomain (unknown [10.118.237.107])
        by m3002.s.css.fujitsu.com (Postfix) with ESMTP id D0AB2200537C;
        Fri,  8 Sep 2023 15:27:04 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v6 5/7] RDMA/rxe: Allow registering MRs for On-Demand Paging
Date:   Fri,  8 Sep 2023 15:26:46 +0900
Message-Id: <3fb02f58aa660d2d4a01bb187ce683eee23a138f.1694153251.git.matsuda-daisuke@fujitsu.com>
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

Allow userspace to register an ODP-enabled MR, in which case the flag
IB_ACCESS_ON_DEMAND is passed to rxe_reg_user_mr(). However, there is no
RDMA operation enabled right now. They will be supported later in the
subsequent two patches.

rxe_odp_do_pagefault() is called to initialize an ODP-enabled MR. It syncs
process address space from the CPU page table to the driver page table
(dma_list/pfn_list in umem_odp) when called with RXE_PAGEFAULT_SNAPSHOT
flag. Additionally, It can be used to trigger page fault when pages being
accessed are not present or do not have proper read/write permissions, and
possibly to prefetch pages in the future.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |   7 ++
 drivers/infiniband/sw/rxe/rxe_loc.h   |  14 +++
 drivers/infiniband/sw/rxe/rxe_mr.c    |   9 +-
 drivers/infiniband/sw/rxe/rxe_odp.c   | 122 ++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c  |  15 +++-
 drivers/infiniband/sw/rxe/rxe_verbs.c |   5 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |   1 +
 7 files changed, 167 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 54c723a6edda..f2284d27229b 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -73,6 +73,13 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 			rxe->ndev->dev_addr);
 
 	rxe->max_ucontext			= RXE_MAX_UCONTEXT;
+
+	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
+		rxe->attr.kernel_cap_flags |= IBK_ON_DEMAND_PAGING;
+
+		/* IB_ODP_SUPPORT_IMPLICIT is not supported right now. */
+		rxe->attr.odp_caps.general_caps |= IB_ODP_SUPPORT;
+	}
 }
 
 /* initialize port attributes */
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index eb867f7d0d36..4bda154a0248 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -188,4 +188,18 @@ static inline unsigned int wr_opcode_mask(int opcode, struct rxe_qp *qp)
 	return rxe_wr_opcode_info[opcode].mask[qp->ibqp.qp_type];
 }
 
+/* rxe_odp.c */
+#ifdef CONFIG_INFINIBAND_ON_DEMAND_PAGING
+int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
+			 u64 iova, int access_flags, struct rxe_mr *mr);
+#else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
+static inline int
+rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
+		     int access_flags, struct rxe_mr *mr)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
+
 #endif /* RXE_LOC_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 86b1908d304b..384cb4ba1f2d 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -318,7 +318,10 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
 		return err;
 	}
 
-	return rxe_mr_copy_xarray(mr, iova, addr, length, dir);
+	if (mr->umem->is_odp)
+		return -EOPNOTSUPP;
+	else
+		return rxe_mr_copy_xarray(mr, iova, addr, length, dir);
 }
 
 /* copy data in or out of a wqe, i.e. sg list
@@ -527,6 +530,10 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 	struct page *page;
 	u64 *va;
 
+	/* ODP is not supported right now. WIP. */
+	if (mr->umem->is_odp)
+		return RESPST_ERR_UNSUPPORTED_OPCODE;
+
 	/* See IBA oA19-28 */
 	if (unlikely(mr->state != RXE_MR_STATE_VALID)) {
 		rxe_dbg_mr(mr, "mr not in valid state");
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index 834fb1a84800..713bef9161e3 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -32,6 +32,31 @@ static void rxe_mr_unset_xarray(struct rxe_mr *mr, unsigned long start,
 	xas_unlock(&xas);
 }
 
+static void rxe_mr_set_xarray(struct rxe_mr *mr, unsigned long start,
+			      unsigned long end, unsigned long *pfn_list)
+{
+	unsigned long lower = rxe_mr_iova_to_index(mr, start);
+	unsigned long upper = rxe_mr_iova_to_index(mr, end - 1);
+	struct page *page;
+	void *entry;
+
+	XA_STATE(xas, &mr->page_list, lower);
+
+	/* ib_umem_odp_unmap_dma_pages() ensures pages are HMM_PFN_VALID */
+	xas_lock(&xas);
+	while (true) {
+		page = hmm_pfn_to_page(pfn_list[xas.xa_index]);
+		xas_store(&xas, page);
+
+		entry = xas_next(&xas);
+		if (xas_retry(&xas, entry) || (xas.xa_index <= upper))
+			continue;
+
+		break;
+	}
+	xas_unlock(&xas);
+}
+
 static bool rxe_ib_invalidate_range(struct mmu_interval_notifier *mni,
 				    const struct mmu_notifier_range *range,
 				    unsigned long cur_seq)
@@ -62,3 +87,100 @@ static bool rxe_ib_invalidate_range(struct mmu_interval_notifier *mni,
 const struct mmu_interval_notifier_ops rxe_mn_ops = {
 	.invalidate = rxe_ib_invalidate_range,
 };
+
+#define RXE_PAGEFAULT_RDONLY BIT(1)
+#define RXE_PAGEFAULT_SNAPSHOT BIT(2)
+static int rxe_odp_do_pagefault_and_lock(struct rxe_mr *mr, u64 user_va, int bcnt, u32 flags)
+{
+	int np;
+	u64 access_mask;
+	bool fault = !(flags & RXE_PAGEFAULT_SNAPSHOT);
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+
+	access_mask = ODP_READ_ALLOWED_BIT;
+	if (umem_odp->umem.writable && !(flags & RXE_PAGEFAULT_RDONLY))
+		access_mask |= ODP_WRITE_ALLOWED_BIT;
+
+	/*
+	 * ib_umem_odp_map_dma_and_lock() locks umem_mutex on success.
+	 * Callers must release the lock later to let invalidation handler
+	 * do its work again.
+	 */
+	np = ib_umem_odp_map_dma_and_lock(umem_odp, user_va, bcnt,
+					  access_mask, fault);
+	if (np < 0)
+		return np;
+
+	/*
+	 * umem_mutex is still locked here, so we can use hmm_pfn_to_page()
+	 * safely to fetch pages in the range.
+	 */
+	rxe_mr_set_xarray(mr, user_va, user_va + bcnt, umem_odp->pfn_list);
+
+	return np;
+}
+
+static int rxe_odp_init_pages(struct rxe_mr *mr)
+{
+	int ret;
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+
+	ret = rxe_odp_do_pagefault_and_lock(mr, mr->umem->address,
+					    mr->umem->length,
+					    RXE_PAGEFAULT_SNAPSHOT);
+
+	if (ret >= 0)
+		mutex_unlock(&umem_odp->umem_mutex);
+
+	return ret >= 0 ? 0 : ret;
+}
+
+int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
+			 u64 iova, int access_flags, struct rxe_mr *mr)
+{
+	int err;
+	struct ib_umem_odp *umem_odp;
+
+	if (!IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING))
+		return -EOPNOTSUPP;
+
+	rxe_mr_init(access_flags, mr);
+
+	xa_init(&mr->page_list);
+
+	if (!start && length == U64_MAX) {
+		if (iova != 0)
+			return -EINVAL;
+		if (!(rxe->attr.odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
+			return -EINVAL;
+
+		/* Never reach here, for implicit ODP is not implemented. */
+	}
+
+	umem_odp = ib_umem_odp_get(&rxe->ib_dev, start, length, access_flags,
+				   &rxe_mn_ops);
+	if (IS_ERR(umem_odp)) {
+		rxe_dbg_mr(mr, "Unable to create umem_odp err = %d\n",
+			   (int)PTR_ERR(umem_odp));
+		return PTR_ERR(umem_odp);
+	}
+
+	umem_odp->private = mr;
+
+	mr->umem = &umem_odp->umem;
+	mr->access = access_flags;
+	mr->ibmr.length = length;
+	mr->ibmr.iova = iova;
+	mr->page_offset = ib_umem_offset(&umem_odp->umem);
+
+	err = rxe_odp_init_pages(mr);
+	if (err) {
+		ib_umem_odp_release(umem_odp);
+		return err;
+	}
+
+	mr->state = RXE_MR_STATE_VALID;
+	mr->ibmr.type = IB_MR_TYPE_USER;
+
+	return err;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 969e057bbfd1..9159f1bdfc6f 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -635,6 +635,10 @@ static enum resp_states process_flush(struct rxe_qp *qp,
 	struct rxe_mr *mr = qp->resp.mr;
 	struct resp_res *res = qp->resp.res;
 
+	/* ODP is not supported right now. WIP. */
+	if (mr->umem->is_odp)
+		return RESPST_ERR_UNSUPPORTED_OPCODE;
+
 	/* oA19-14, oA19-15 */
 	if (res && res->replay)
 		return RESPST_ACKNOWLEDGE;
@@ -688,10 +692,13 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 	if (!res->replay) {
 		u64 iova = qp->resp.va + qp->resp.offset;
 
-		err = rxe_mr_do_atomic_op(mr, iova, pkt->opcode,
-					  atmeth_comp(pkt),
-					  atmeth_swap_add(pkt),
-					  &res->atomic.orig_val);
+		if (mr->umem->is_odp)
+			err = RESPST_ERR_UNSUPPORTED_OPCODE;
+		else
+			err = rxe_mr_do_atomic_op(mr, iova, pkt->opcode,
+						  atmeth_comp(pkt),
+						  atmeth_swap_add(pkt),
+						  &res->atomic.orig_val);
 		if (err)
 			return err;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 48f86839d36a..192ad835c712 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1278,7 +1278,10 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
 	mr->ibmr.pd = ibpd;
 	mr->ibmr.device = ibpd->device;
 
-	err = rxe_mr_init_user(rxe, start, length, iova, access, mr);
+	if (access & IB_ACCESS_ON_DEMAND)
+		err = rxe_odp_mr_init_user(rxe, start, length, iova, access, mr);
+	else
+		err = rxe_mr_init_user(rxe, start, length, iova, access, mr);
 	if (err) {
 		rxe_dbg_mr(mr, "reg_user_mr failed, err = %d", err);
 		goto err_cleanup;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 1058b5de8920..24dd747586e0 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -298,6 +298,7 @@ enum {
 				| IB_ACCESS_LOCAL_WRITE
 				| IB_ACCESS_MW_BIND
 				| IB_ACCESS_ON_DEMAND
+				| IB_ACCESS_HUGETLB
 				| IB_ACCESS_FLUSH_GLOBAL
 				| IB_ACCESS_FLUSH_PERSISTENT
 				| IB_ACCESS_OPTIONAL,
-- 
2.39.1

