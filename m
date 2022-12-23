Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F65D654C95
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Dec 2022 07:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiLWGwo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Dec 2022 01:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbiLWGwe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Dec 2022 01:52:34 -0500
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DD7264B6
        for <linux-rdma@vger.kernel.org>; Thu, 22 Dec 2022 22:52:31 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="101163247"
X-IronPort-AV: E=Sophos;i="5.96,267,1665414000"; 
   d="scan'208";a="101163247"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP; 23 Dec 2022 15:52:30 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 14F28C3F95;
        Fri, 23 Dec 2022 15:52:29 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (m3003.s.css.fujitsu.com [10.128.233.114])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 57C5FF0A3A;
        Fri, 23 Dec 2022 15:52:28 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 1D0AB200B2A8;
        Fri, 23 Dec 2022 15:52:28 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        rpearsonhpe@gmail.com, yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        y-goto@fujitsu.com, Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v3 6/7] RDMA/rxe: Add support for Send/Recv/Write/Read operations with ODP
Date:   Fri, 23 Dec 2022 15:51:57 +0900
Message-Id: <9fc493c713731e03d31cfbb0e0b76aa9524dc228.1671772917.git.matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1671772917.git.matsuda-daisuke@fujitsu.com>
References: <cover.1671772917.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 4. Execute data copy to/from the pages.

umem_mutex is used to ensure that dma_list (an array of addresses of an MR)
is not changed while it is checked and that mapped pages are not
invalidated before data copy completes.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.c      |  10 ++
 drivers/infiniband/sw/rxe/rxe_loc.h  |   5 +
 drivers/infiniband/sw/rxe/rxe_mr.c   |   2 +-
 drivers/infiniband/sw/rxe/rxe_odp.c  | 176 +++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c |  43 +------
 drivers/infiniband/sw/rxe/rxe_resp.h |  37 ++++++
 6 files changed, 233 insertions(+), 40 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 7a8a09487f96..2c9f0cf96671 100644
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
index ab66a07e5700..fb468999e81e 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -190,6 +190,8 @@ static inline unsigned int wr_opcode_mask(int opcode, struct rxe_qp *qp)
 /* rxe_odp.c */
 int rxe_create_user_odp_mr(struct ib_pd *pd, u64 start, u64 length, u64 iova,
 			   int access_flags, struct rxe_mr *mr);
+int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
+		    enum rxe_mr_copy_dir dir);
 
 #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 static inline int
@@ -198,6 +200,9 @@ rxe_create_user_odp_mr(struct ib_pd *pd, u64 start, u64 length, u64 iova,
 {
 	return -EOPNOTSUPP;
 }
+static inline int
+rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
+		int length, enum rxe_mr_copy_dir dir) { return 0; }
 
 #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 261bb462341b..09a9a8ea3411 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -479,7 +479,7 @@ int copy_data(
 			iova = sge->addr + offset;
 
 			if (mr->odp_enabled)
-				err = -EOPNOTSUPP;
+				err = rxe_odp_mr_copy(mr, iova, addr, bytes, dir);
 			else
 				err = rxe_mr_copy(mr, iova, addr, bytes, dir);
 			if (err)
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index 8b01ceaeee36..c55512417d11 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -3,9 +3,12 @@
  * Copyright (c) 2022 Fujitsu Ltd. All rights reserved.
  */
 
+#include <linux/hmm.h>
+
 #include <rdma/ib_umem_odp.h>
 
 #include "rxe.h"
+#include "rxe_resp.h"
 
 static bool rxe_ib_invalidate_range(struct mmu_interval_notifier *mni,
 				    const struct mmu_notifier_range *range,
@@ -115,3 +118,176 @@ int rxe_create_user_odp_mr(struct ib_pd *pd, u64 start, u64 length, u64 iova,
 
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
+/* umem mutex must be locked before entering this function. */
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
+	if (unlikely(length < 1)) {
+		mutex_unlock(&umem_odp->umem_mutex);
+		return -EINVAL;
+	}
+
+	perm = ODP_READ_ALLOWED_BIT;
+	if (!(flags & RXE_PAGEFAULT_RDONLY))
+		perm |= ODP_WRITE_ALLOWED_BIT;
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
+		/* umem_mutex is locked on success. */
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
+	if (unlikely(!mr->odp_enabled))
+		return -EOPNOTSUPP;
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
+	/* If pagefault is not required, umem mutex will be held until data
+	 * copy to the MR completes. Otherwise, it is released and locked
+	 * again in rxe_odp_map_range() to let invalidation handler do its
+	 * work meanwhile.
+	 */
+	mutex_lock(&umem_odp->umem_mutex);
+
+	err = rxe_odp_map_range(mr, iova, length, flags);
+	if (err)
+		return err;
+
+	err =  __rxe_odp_mr_copy(mr, iova, addr, length, dir);
+
+	mutex_unlock(&umem_odp->umem_mutex);
+
+	return err;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index f2c803036888..7ef492e50e20 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -11,43 +11,6 @@
 #include "rxe_queue.h"
 #include "rxe_resp.h"
 
-enum resp_states {
-	RESPST_NONE,
-	RESPST_GET_REQ,
-	RESPST_CHK_PSN,
-	RESPST_CHK_OP_SEQ,
-	RESPST_CHK_OP_VALID,
-	RESPST_CHK_RESOURCE,
-	RESPST_CHK_LENGTH,
-	RESPST_CHK_RKEY,
-	RESPST_EXECUTE,
-	RESPST_READ_REPLY,
-	RESPST_ATOMIC_REPLY,
-	RESPST_ATOMIC_WRITE_REPLY,
-	RESPST_PROCESS_FLUSH,
-	RESPST_COMPLETE,
-	RESPST_ACKNOWLEDGE,
-	RESPST_CLEANUP,
-	RESPST_DUPLICATE_REQUEST,
-	RESPST_ERR_MALFORMED_WQE,
-	RESPST_ERR_UNSUPPORTED_OPCODE,
-	RESPST_ERR_MISALIGNED_ATOMIC,
-	RESPST_ERR_PSN_OUT_OF_SEQ,
-	RESPST_ERR_MISSING_OPCODE_FIRST,
-	RESPST_ERR_MISSING_OPCODE_LAST_C,
-	RESPST_ERR_MISSING_OPCODE_LAST_D1E,
-	RESPST_ERR_TOO_MANY_RDMA_ATM_REQ,
-	RESPST_ERR_RNR,
-	RESPST_ERR_RKEY_VIOLATION,
-	RESPST_ERR_INVALIDATE_RKEY,
-	RESPST_ERR_LENGTH,
-	RESPST_ERR_CQ_OVERFLOW,
-	RESPST_ERROR,
-	RESPST_RESET,
-	RESPST_DONE,
-	RESPST_EXIT,
-};
-
 static char *resp_state_name[] = {
 	[RESPST_NONE]				= "NONE",
 	[RESPST_GET_REQ]			= "GET_REQ",
@@ -632,7 +595,8 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
 		goto out;
 
 	if (qp->resp.mr->odp_enabled)
-		err = RESPST_ERR_UNSUPPORTED_OPCODE;
+		err = rxe_odp_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
+				      payload_addr(pkt), data_len, RXE_TO_MR_OBJ);
 	else
 		err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
 				  payload_addr(pkt), data_len, RXE_TO_MR_OBJ);
@@ -1051,7 +1015,8 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 
 	/* mr is NULL for a zero byte operation. */
 	if ((res->read.resid != 0) && mr->odp_enabled)
-		err = RESPST_ERR_UNSUPPORTED_OPCODE;
+		err = rxe_odp_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
+				      payload, RXE_FROM_MR_OBJ);
 	else
 		err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
 				  payload, RXE_FROM_MR_OBJ);
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.h b/drivers/infiniband/sw/rxe/rxe_resp.h
index 94a4869fdab6..242506f57fd3 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.h
+++ b/drivers/infiniband/sw/rxe/rxe_resp.h
@@ -3,6 +3,43 @@
 #ifndef RXE_RESP_H
 #define RXE_RESP_H
 
+enum resp_states {
+	RESPST_NONE,
+	RESPST_GET_REQ,
+	RESPST_CHK_PSN,
+	RESPST_CHK_OP_SEQ,
+	RESPST_CHK_OP_VALID,
+	RESPST_CHK_RESOURCE,
+	RESPST_CHK_LENGTH,
+	RESPST_CHK_RKEY,
+	RESPST_EXECUTE,
+	RESPST_READ_REPLY,
+	RESPST_ATOMIC_REPLY,
+	RESPST_ATOMIC_WRITE_REPLY,
+	RESPST_PROCESS_FLUSH,
+	RESPST_COMPLETE,
+	RESPST_ACKNOWLEDGE,
+	RESPST_CLEANUP,
+	RESPST_DUPLICATE_REQUEST,
+	RESPST_ERR_MALFORMED_WQE,
+	RESPST_ERR_UNSUPPORTED_OPCODE,
+	RESPST_ERR_MISALIGNED_ATOMIC,
+	RESPST_ERR_PSN_OUT_OF_SEQ,
+	RESPST_ERR_MISSING_OPCODE_FIRST,
+	RESPST_ERR_MISSING_OPCODE_LAST_C,
+	RESPST_ERR_MISSING_OPCODE_LAST_D1E,
+	RESPST_ERR_TOO_MANY_RDMA_ATM_REQ,
+	RESPST_ERR_RNR,
+	RESPST_ERR_RKEY_VIOLATION,
+	RESPST_ERR_INVALIDATE_RKEY,
+	RESPST_ERR_LENGTH,
+	RESPST_ERR_CQ_OVERFLOW,
+	RESPST_ERROR,
+	RESPST_RESET,
+	RESPST_DONE,
+	RESPST_EXIT,
+};
+
 enum resp_states rxe_process_atomic(struct rxe_qp *qp,
 				    struct rxe_pkt_info *pkt, u64 *vaddr);
 
-- 
2.31.1

