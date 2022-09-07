Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09B45AFA18
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 04:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiIGCpW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Sep 2022 22:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiIGCpR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Sep 2022 22:45:17 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB68A5D12A;
        Tue,  6 Sep 2022 19:45:09 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="75542829"
X-IronPort-AV: E=Sophos;i="5.93,295,1654527600"; 
   d="scan'208";a="75542829"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 07 Sep 2022 11:45:07 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id A194FD4326;
        Wed,  7 Sep 2022 11:45:06 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id BEFDFD947E;
        Wed,  7 Sep 2022 11:45:05 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 75D47200B33B;
        Wed,  7 Sep 2022 11:45:05 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        rpearsonhpe@gmail.com, yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        y-goto@fujitsu.com, Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [RFC PATCH 6/7] RDMA/rxe: Add support for Send/Recv/Write/Read operations with ODP
Date:   Wed,  7 Sep 2022 11:43:04 +0900
Message-Id: <f2dd21a3d0f2005e02c34c793325317f1c326ce1.1662461897.git.matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1662461897.git.matsuda-daisuke@fujitsu.com>
References: <cover.1662461897.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_mr_copy() is used widely to copy data to/from a user MR. requester uses
it to load payloads of requesting packets; responder uses it to process
Send, Write, and Read operaetions; completer uses it to copy data from
response packets of Read and Atomic operations to a user MR.

Allow these operations to be used with ODP by adding a counterpart function
rxe_odp_mr_copy(). It is comprised of the following steps:
 1. Check the driver page table(umem_odp->dma_list) to see if pages being
    accessed are present with appropriate permission.
 2. If necessary, trigger page fault to map the pages.
 3. Convert their user space addresses to kernel logical addresses using
    PFNs in the driver page table(umem_odp->pfn_list).
 4. Execute data copy fo/from the pages.

umem_mutex is used to ensure that dma_list (an array of addresses of an MR)
is not changed while it is checked and that mapped pages are not
invalidated before data copy completes.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.c      |  10 ++
 drivers/infiniband/sw/rxe/rxe_loc.h  |   2 +
 drivers/infiniband/sw/rxe/rxe_mr.c   |   2 +-
 drivers/infiniband/sw/rxe/rxe_odp.c  | 173 +++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c |   6 +-
 5 files changed, 190 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 0719f451253c..dd287fc60e9d 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -79,6 +79,16 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 
 		/* IB_ODP_SUPPORT_IMPLICIT is not supported right now. */
 		rxe->attr.odp_caps.general_caps |= IB_ODP_SUPPORT;
+
+		rxe->attr.odp_caps.per_transport_caps.ud_odp_caps |= IB_ODP_SUPPORT_SEND;
+		rxe->attr.odp_caps.per_transport_caps.ud_odp_caps |= IB_ODP_SUPPORT_RECV;
+		rxe->attr.odp_caps.per_transport_caps.ud_odp_caps |= IB_ODP_SUPPORT_SRQ_RECV;
+
+		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_SEND;
+		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_RECV;
+		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_WRITE;
+		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_READ;
+		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_SRQ_RECV;
 	}
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 03b4078b90a3..91982b5a690c 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -192,5 +192,7 @@ static inline unsigned int wr_opcode_mask(int opcode, struct rxe_qp *qp)
 /* rxe_odp.c */
 int rxe_create_user_odp_mr(struct ib_pd *pd, u64 start, u64 length, u64 iova,
 			   int access_flags, struct rxe_mr *mr);
+int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
+		    enum rxe_mr_copy_dir dir);
 
 #endif /* RXE_LOC_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 0ae72a4516be..2091e865dd8f 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -439,7 +439,7 @@ int copy_data(
 			iova = sge->addr + offset;
 
 			if (mr->odp_enabled)
-				err = -EOPNOTSUPP;
+				err = rxe_odp_mr_copy(mr, iova, addr, bytes, dir);
 			else
 				err = rxe_mr_copy(mr, iova, addr, bytes, dir);
 			if (err)
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index 1f6930ba714c..85c34995c704 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -3,6 +3,8 @@
  * Copyright (c) 2022 Fujitsu Ltd. All rights reserved.
  */
 
+#include <linux/hmm.h>
+
 #include <rdma/ib_umem_odp.h>
 
 #include "rxe.h"
@@ -112,3 +114,174 @@ int rxe_create_user_odp_mr(struct ib_pd *pd, u64 start, u64 length, u64 iova,
 
 	return err;
 }
+
+static inline bool rxe_is_pagefault_neccesary(struct ib_umem_odp *umem_odp,
+					      u64 iova, int length, u32 perm)
+{
+	int idx;
+	u64 addr;
+	bool need_fault = false;
+
+	addr = iova & (~(BIT(umem_odp->page_shift) - 1));
+
+	/* Skim through all pages that are to be accessed. */
+	while (addr < iova + length) {
+		idx = (addr - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
+
+		if (!(umem_odp->dma_list[idx] & perm)) {
+			need_fault = true;
+			break;
+		}
+
+		addr += BIT(umem_odp->page_shift);
+	}
+	return need_fault;
+}
+
+/* umem mutex is always locked when returning from this function. */
+static int rxe_odp_map_range(struct rxe_mr *mr, u64 iova, int length, u32 flags)
+{
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+	const int max_tries = 3;
+	int cnt = 0;
+
+	int err;
+	u64 perm;
+	bool need_fault;
+
+	if (unlikely(length < 1))
+		return -EINVAL;
+
+	perm = ODP_READ_ALLOWED_BIT;
+	if (!(flags & RXE_PAGEFAULT_RDONLY))
+		perm |= ODP_WRITE_ALLOWED_BIT;
+
+	mutex_lock(&umem_odp->umem_mutex);
+
+	/*
+	 * A successful return from rxe_odp_do_pagefault() does not guarantee
+	 * that all pages in the range became present. Recheck the DMA address
+	 * array, allowing max 3 tries for pagefault.
+	 */
+	while ((need_fault = rxe_is_pagefault_neccesary(umem_odp,
+							iova, length, perm))) {
+
+		if (cnt >= max_tries)
+			break;
+
+		mutex_unlock(&umem_odp->umem_mutex);
+
+		/* rxe_odp_do_pagefault() locks the umem mutex. */
+		err = rxe_odp_do_pagefault(mr, iova, length, flags);
+		if (err < 0)
+			return err;
+
+		cnt++;
+	}
+
+	if (need_fault)
+		return -EFAULT;
+
+	return 0;
+}
+
+static inline void *rxe_odp_get_virt(struct ib_umem_odp *umem_odp, int umem_idx,
+				     size_t offset)
+{
+	struct page *page;
+	void *virt;
+
+	/*
+	 * Step 1. Get page struct from the pfn array.
+	 * Step 2. Convert page struct to kernel logical address.
+	 * Step 3. Add offset in the page to the address.
+	 */
+	page = hmm_pfn_to_page(umem_odp->pfn_list[umem_idx]);
+	virt = page_address(page);
+
+	if (!virt)
+		return NULL;
+
+	virt += offset;
+
+	return virt;
+}
+
+static int __rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
+			     int length, enum rxe_mr_copy_dir dir)
+{
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+
+	int idx, bytes;
+	u8 *user_va;
+	size_t offset;
+
+	idx = (iova - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
+	offset = iova & (BIT(umem_odp->page_shift) - 1);
+
+	while (length > 0) {
+		u8 *src, *dest;
+
+		user_va = (u8 *)rxe_odp_get_virt(umem_odp, idx, offset);
+		if (!user_va)
+			return -EFAULT;
+
+		src = (dir == RXE_TO_MR_OBJ) ? addr : user_va;
+		dest = (dir == RXE_TO_MR_OBJ) ? user_va : addr;
+
+		bytes = BIT(umem_odp->page_shift) - offset;
+
+		if (bytes > length)
+			bytes = length;
+
+		memcpy(dest, src, bytes);
+
+		length  -= bytes;
+		idx++;
+		offset = 0;
+	}
+
+	/* The mutex was locked in rxe_odp_map_range().
+	 * Now it is safe to invalidate the MR, so unlock it
+	 */
+	mutex_unlock(&umem_odp->umem_mutex);
+
+	return 0;
+}
+
+int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
+		    enum rxe_mr_copy_dir dir)
+{
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+	u32 flags = 0;
+
+	int err;
+
+	if (length == 0)
+		return 0;
+
+	WARN_ON_ONCE(!mr->odp_enabled);
+
+	switch (dir) {
+	case RXE_TO_MR_OBJ:
+		break;
+
+	case RXE_FROM_MR_OBJ:
+		flags = RXE_PAGEFAULT_RDONLY;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	/* umem mutex is locked here to prevent MR invalidation before data copy
+	 * completes; On success, it is unlocked in __rxe_odp_mr_copy()
+	 */
+	err = rxe_odp_map_range(mr, iova, length, flags);
+	if (err) {
+		mutex_unlock(&umem_odp->umem_mutex);
+		return err;
+	}
+
+	return __rxe_odp_mr_copy(mr, iova, addr, length, dir);
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index dd8632e783f6..bf439004c378 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -536,7 +536,8 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
 	int data_len = payload_size(pkt);
 
 	if (qp->resp.mr->odp_enabled)
-		err = -EOPNOTSUPP;
+		err = rxe_odp_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
+				      payload_addr(pkt), data_len, RXE_TO_MR_OBJ);
 	else
 		err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
 				  payload_addr(pkt), data_len, RXE_TO_MR_OBJ);
@@ -839,7 +840,8 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		return RESPST_ERR_RNR;
 
 	if (mr->odp_enabled)
-		err = -EOPNOTSUPP;
+		err = rxe_odp_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
+				      payload, RXE_FROM_MR_OBJ);
 	else
 		err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
 				  payload, RXE_FROM_MR_OBJ);
-- 
2.31.1

