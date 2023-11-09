Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011B87E6365
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Nov 2023 06:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjKIFrS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Nov 2023 00:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjKIFq6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Nov 2023 00:46:58 -0500
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CFA2D72;
        Wed,  8 Nov 2023 21:46:46 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="118471671"
X-IronPort-AV: E=Sophos;i="6.03,288,1694703600"; 
   d="scan'208";a="118471671"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 14:45:42 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 80418CF1C3;
        Thu,  9 Nov 2023 14:45:38 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id C1E9FD20B6;
        Thu,  9 Nov 2023 14:45:37 +0900 (JST)
Received: from localhost.localdomain (unknown [10.118.237.107])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 8E2BE2005323;
        Thu,  9 Nov 2023 14:45:37 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v7 5/7] RDMA/rxe: Allow registering MRs for On-Demand Paging
Date:   Thu,  9 Nov 2023 14:44:50 +0900
Message-Id: <5d46bd682aa8e3d5cabc38ca1cd67d2976f2731d.1699503619.git.matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1699503619.git.matsuda-daisuke@fujitsu.com>
References: <cover.1699503619.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
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
 6 files changed, 166 insertions(+), 6 deletions(-)

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
index ea55b79be0c6..c5e24901c141 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -9,6 +9,8 @@
 
 #include "rxe.h"
 
+#define RXE_ODP_WRITABLE_BIT    1UL
+
 static void rxe_mr_unset_xarray(struct rxe_mr *mr, unsigned long start,
 				unsigned long end)
 {
@@ -25,6 +27,29 @@ static void rxe_mr_unset_xarray(struct rxe_mr *mr, unsigned long start,
 	xas_unlock(&xas);
 }
 
+static void rxe_mr_set_xarray(struct rxe_mr *mr, unsigned long start,
+			      unsigned long end, unsigned long *pfn_list)
+{
+	unsigned long upper = rxe_mr_iova_to_index(mr, end - 1);
+	unsigned long lower = rxe_mr_iova_to_index(mr, start);
+	void *page, *entry;
+
+	XA_STATE(xas, &mr->page_list, lower);
+
+	xas_lock(&xas);
+	while (xas.xa_index <= upper) {
+		if (pfn_list[xas.xa_index] & HMM_PFN_WRITE) {
+			page = xa_tag_pointer(hmm_pfn_to_page(pfn_list[xas.xa_index]),
+					      RXE_ODP_WRITABLE_BIT);
+		} else
+			page = hmm_pfn_to_page(pfn_list[xas.xa_index]);
+
+		xas_store(&xas, page);
+		entry = xas_next(&xas);
+	}
+	xas_unlock(&xas);
+}
+
 static bool rxe_ib_invalidate_range(struct mmu_interval_notifier *mni,
 				    const struct mmu_notifier_range *range,
 				    unsigned long cur_seq)
@@ -55,3 +80,100 @@ static bool rxe_ib_invalidate_range(struct mmu_interval_notifier *mni,
 const struct mmu_interval_notifier_ops rxe_mn_ops = {
 	.invalidate = rxe_ib_invalidate_range,
 };
+
+#define RXE_PAGEFAULT_RDONLY BIT(1)
+#define RXE_PAGEFAULT_SNAPSHOT BIT(2)
+static int rxe_odp_do_pagefault_and_lock(struct rxe_mr *mr, u64 user_va, int bcnt, u32 flags)
+{
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+	bool fault = !(flags & RXE_PAGEFAULT_SNAPSHOT);
+	u64 access_mask;
+	int np;
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
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+	int ret;
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
+	struct ib_umem_odp *umem_odp;
+	int err;
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
-- 
2.39.1

