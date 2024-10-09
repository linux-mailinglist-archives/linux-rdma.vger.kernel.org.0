Return-Path: <linux-rdma+bounces-5329-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B133995D97
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 04:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0BB1F25889
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 02:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED3C14F136;
	Wed,  9 Oct 2024 02:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="RFPZKS3b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8021465B8;
	Wed,  9 Oct 2024 02:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728439245; cv=none; b=DtZDDRpAtU72F5JgA4rjg24SRlDNFSSpDCQgjbk3zl6QsQIWGGns8a2Qg4B8pLyA/Y2DQgoYK9DxGxk2yz6jtaP/TKPuDNIWvKXFfPNCjuVLgqArh7EkhXi1yDqq1H6ZBq5fOXqwS5v/5EW5D/0JgUmEv/J1cGRJ/KbaC7CsvKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728439245; c=relaxed/simple;
	bh=fhk+Evd71ifM1Bb74g079h1ZJRPyt57FhdeIo8+Bs3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kvu7GnSMcSTXqBRqo05TbZW8wRsFEkhyjsV5FisDZJYHLWQWPJk4V0vpjPL5VVHVQCQakeCbPiyRleCL3tjBD2mtyTwlKC8lGbeSvnq5xZud6u+p9gMWTLx4/6GS+/CoMmXp8U0arTcYUSSsGhtMtmq9yYDE2VewnOih4ugeiIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=RFPZKS3b; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1728439244; x=1759975244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fhk+Evd71ifM1Bb74g079h1ZJRPyt57FhdeIo8+Bs3w=;
  b=RFPZKS3bzPZD2CuIZfdSWzB57BHVruYyEYYbkrjurUvd0uA4iMfU2AhR
   7HX/uvmtC0LSwTe53rYJ+9nJxyxwGBlRIX5IKrXq5nZCtlc081TI00b7j
   Mo+oSTaQ4iyBPMqJ+7URHOsqJH57mHNeHob1wMZw2jEzPKKuErgg3JO1l
   tCufWaz3GC6uCm7Ls1MWDwCUKWn20Ut8JqsqsiJmd+zQ0Yp6rKpjacgMj
   RPcVyA1sk7H6O8+F29qievgR0//kkZgSBSCuPvUajugkrKeC2qL+OPIl5
   cU1LEI2YmcHghDXtICcx/UofDCG2fe71y4m9jQXpSnu7bz3xTI9CjSMn7
   w==;
X-CSE-ConnectionGUID: y+QZOh0oTVemJS9d+3ZzLw==
X-CSE-MsgGUID: Eg2A4bb3RwmRnXGOaCWvXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="178376049"
X-IronPort-AV: E=Sophos;i="6.11,188,1725289200"; 
   d="scan'208";a="178376049"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 10:59:31 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7ED13C68E4;
	Wed,  9 Oct 2024 10:59:28 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id C2357D3F04;
	Wed,  9 Oct 2024 10:59:27 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 9760A2005356;
	Wed,  9 Oct 2024 10:59:27 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: linux-kernel@vger.kernel.org,
	rpearsonhpe@gmail.com,
	lizhijian@fujitsu.com,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v8 4/6] RDMA/rxe: Allow registering MRs for On-Demand Paging
Date: Wed,  9 Oct 2024 10:59:01 +0900
Message-Id: <20241009015903.801987-5-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
References: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

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
index 866c36533b53..51b77e8827aa 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -189,4 +189,18 @@ static inline unsigned int wr_opcode_mask(int opcode, struct rxe_qp *qp)
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
index 1f7b8cf93adc..5589314a1e67 100644
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
 		rxe_dbg_mr(mr, "mr not in valid state\n");
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


