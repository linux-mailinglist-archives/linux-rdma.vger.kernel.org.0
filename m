Return-Path: <linux-rdma+bounces-6680-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFB89F8FE6
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 11:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE5D1896136
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 10:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44931C07FE;
	Fri, 20 Dec 2024 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="H0U0tm/0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE3E1AAA1F;
	Fri, 20 Dec 2024 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734689420; cv=none; b=Vl1U9uGWafMtjkxhrlEgA3UgJ9Wiat8Rt9i73mZxJRbh4ZRPpRyYjwYiLbH73/TtkHLRvhWUe6WOT6I1ZH8TYsLc1X1pZaORaKMcT0x8uKxy+cLrLb7MFZcM+BushCnc9TecifSFKVlY3ClWIoY3B+Y7JsVS3FCkKV9h+/8D78Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734689420; c=relaxed/simple;
	bh=J7NVvzsg5FdA5lOlUazCwTypS47kXGr6IjjXWpJy/oE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ger6nuxAe5hFf+kwMQGNUxlsgkxhcaVSqHB7+1PNq7JHmdidS2aNjB5uEviGUWPSWJnLjDfRe5hJh0jtkjfkBNMHVYHkfCuFy44IUsbkfwVUN1CQG4FyIkkAPPtA7/upDwf1vHjK3PAFdxiorPHJJr7O65ayuZ+CMSvQ7pqIjJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=H0U0tm/0; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1734689418; x=1766225418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J7NVvzsg5FdA5lOlUazCwTypS47kXGr6IjjXWpJy/oE=;
  b=H0U0tm/0Wleg+nu9JBSBtOFEpRCXd6lXByRamDpcccoYGaxeTPHcAgp8
   DUXEHuRD2JBiF1DfkRyrS8UU+JK0BvFHX14TxTzin79ZPZHb0n1uBxULK
   JA2cQICkgP4PCeoeB/493u8vKTtVFYAe6fe2J5Unf7sxAp6Bcx9OAKDUX
   5jBcrSjBTtH7x2GpGgqh4O5YZtcNJpXUGD9eJDtHFCeHFvaNZnr+2ozb2
   VOalgm7MMB3JwBr9058HOBAyx3a8dU2TdkUsFA+qd5eonF8+JxmxzLHOS
   xtjlFQGeU2buR/mu+xIRGw6+l2SfWp1pUVmlscazAhW8IvsUDWGCXdLzG
   A==;
X-CSE-ConnectionGUID: yWNpHhB/QLWS/7XhwTsZTA==
X-CSE-MsgGUID: 0lt8Wx0ZTGeYtzxtd0i7UA==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="163321216"
X-IronPort-AV: E=Sophos;i="6.12,250,1728918000"; 
   d="scan'208";a="163321216"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 19:10:09 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 098B9D480B;
	Fri, 20 Dec 2024 19:10:08 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id CB997D4C30;
	Fri, 20 Dec 2024 19:10:07 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 85FCB200597B;
	Fri, 20 Dec 2024 19:10:07 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: linux-kernel@vger.kernel.org,
	rpearsonhpe@gmail.com,
	lizhijian@fujitsu.com,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v9 3/5] RDMA/rxe: Allow registering MRs for On-Demand Paging
Date: Fri, 20 Dec 2024 19:09:34 +0900
Message-Id: <20241220100936.2193541-4-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20241220100936.2193541-1-matsuda-daisuke@fujitsu.com>
References: <20241220100936.2193541-1-matsuda-daisuke@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 drivers/infiniband/sw/rxe/rxe.c       |  7 +++
 drivers/infiniband/sw/rxe/rxe_loc.h   | 12 ++++
 drivers/infiniband/sw/rxe/rxe_mr.c    |  9 ++-
 drivers/infiniband/sw/rxe/rxe_odp.c   | 86 +++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c  | 15 +++--
 drivers/infiniband/sw/rxe/rxe_verbs.c |  5 +-
 6 files changed, 128 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 255677bc12b2..3ca73f8d96cc 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -75,6 +75,13 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
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
index 0162ac9431c1..1043240daa97 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -185,4 +185,16 @@ static inline unsigned int wr_opcode_mask(int opcode, struct rxe_qp *qp)
 /* rxe_odp.c */
 extern const struct mmu_interval_notifier_ops rxe_mn_ops;
 
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
+#endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
+
 #endif /* RXE_LOC_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 12cacc4f60f2..190225a34139 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -323,7 +323,10 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
 		return err;
 	}
 
-	return rxe_mr_copy_xarray(mr, iova, addr, length, dir);
+	if (mr->umem->is_odp)
+		return -EOPNOTSUPP;
+	else
+		return rxe_mr_copy_xarray(mr, iova, addr, length, dir);
 }
 
 /* copy data in or out of a wqe, i.e. sg list
@@ -532,6 +535,10 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 	struct page *page;
 	u64 *va;
 
+	/* ODP is not supported right now. WIP. */
+	if (mr->umem->is_odp)
+		return RESPST_ERR_UNSUPPORTED_OPCODE;
+
 	/* See IBA oA19-28 */
 	if (unlikely(mr->state != RXE_MR_STATE_VALID)) {
 		rxe_dbg_mr(mr, "mr not in valid state\n");
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index 2be8066db012..141290078754 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -36,3 +36,89 @@ static bool rxe_ib_invalidate_range(struct mmu_interval_notifier *mni,
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
index c11ab280551a..e703a3ab82d4 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -649,6 +649,10 @@ static enum resp_states process_flush(struct rxe_qp *qp,
 	struct rxe_mr *mr = qp->resp.mr;
 	struct resp_res *res = qp->resp.res;
 
+	/* ODP is not supported right now. WIP. */
+	if (mr->umem->is_odp)
+		return RESPST_ERR_UNSUPPORTED_OPCODE;
+
 	/* oA19-14, oA19-15 */
 	if (res && res->replay)
 		return RESPST_ACKNOWLEDGE;
@@ -702,10 +706,13 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
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
index 5c18f7e342f2..13064302d766 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1278,7 +1278,10 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
 	mr->ibmr.pd = ibpd;
 	mr->ibmr.device = ibpd->device;
 
-	err = rxe_mr_init_user(rxe, start, length, access, mr);
+	if (access & IB_ACCESS_ON_DEMAND)
+		err = rxe_odp_mr_init_user(rxe, start, length, iova, access, mr);
+	else
+		err = rxe_mr_init_user(rxe, start, length, access, mr);
 	if (err) {
 		rxe_dbg_mr(mr, "reg_user_mr failed, err = %d\n", err);
 		goto err_cleanup;
-- 
2.43.0


