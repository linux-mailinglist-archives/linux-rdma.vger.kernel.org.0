Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EF9654C94
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Dec 2022 07:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbiLWGwo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Dec 2022 01:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbiLWGwc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Dec 2022 01:52:32 -0500
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED3924BFB
        for <linux-rdma@vger.kernel.org>; Thu, 22 Dec 2022 22:52:30 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="80703257"
X-IronPort-AV: E=Sophos;i="5.96,267,1665414000"; 
   d="scan'208";a="80703257"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP; 23 Dec 2022 15:52:27 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3C3E4DD994;
        Fri, 23 Dec 2022 15:52:27 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (m3003.s.css.fujitsu.com [10.128.233.114])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 60297D8C86;
        Fri, 23 Dec 2022 15:52:26 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 1538A200B2A8;
        Fri, 23 Dec 2022 15:52:26 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        rpearsonhpe@gmail.com, yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        y-goto@fujitsu.com, Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v3 5/7] RDMA/rxe: Allow registering MRs for On-Demand Paging
Date:   Fri, 23 Dec 2022 15:51:56 +0900
Message-Id: <412a759639776180a187c36632397ee8796d0255.1671772917.git.matsuda-daisuke@fujitsu.com>
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

Allow applications to register an ODP-enabled MR, in which case the flag
IB_ACCESS_ON_DEMAND is passed to rxe_reg_user_mr(). However, there is no
RDMA operation supported right now. They will be enabled later in the
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
 drivers/infiniband/sw/rxe/rxe_loc.h   | 16 ++++++
 drivers/infiniband/sw/rxe/rxe_mr.c    |  7 ++-
 drivers/infiniband/sw/rxe/rxe_odp.c   | 83 +++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c  | 33 +++++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.c |  7 ++-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  2 +
 7 files changed, 147 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 3c7e42e5b0c7..7a8a09487f96 100644
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
index d567aa65b5e0..ab66a07e5700 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -60,6 +60,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 
 /* rxe_mr.c */
 u8 rxe_get_next_key(u32 last_key);
+void rxe_mr_init(int access, struct rxe_mr *mr);
 void rxe_mr_init_dma(int access, struct rxe_mr *mr);
 int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr);
@@ -185,4 +186,19 @@ static inline unsigned int wr_opcode_mask(int opcode, struct rxe_qp *qp)
 	return rxe_wr_opcode_info[opcode].mask[qp->ibqp.qp_type];
 }
 
+#ifdef CONFIG_INFINIBAND_ON_DEMAND_PAGING
+/* rxe_odp.c */
+int rxe_create_user_odp_mr(struct ib_pd *pd, u64 start, u64 length, u64 iova,
+			   int access_flags, struct rxe_mr *mr);
+
+#else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
+static inline int
+rxe_create_user_odp_mr(struct ib_pd *pd, u64 start, u64 length, u64 iova,
+		       int access_flags, struct rxe_mr *mr)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
+
 #endif /* RXE_LOC_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 072eac4b65d2..261bb462341b 100644
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
@@ -478,7 +478,10 @@ int copy_data(
 		if (bytes > 0) {
 			iova = sge->addr + offset;
 
-			err = rxe_mr_copy(mr, iova, addr, bytes, dir);
+			if (mr->odp_enabled)
+				err = -EOPNOTSUPP;
+			else
+				err = rxe_mr_copy(mr, iova, addr, bytes, dir);
 			if (err)
 				goto err2;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index 0787a9b19646..8b01ceaeee36 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -5,6 +5,8 @@
 
 #include <rdma/ib_umem_odp.h>
 
+#include "rxe.h"
+
 static bool rxe_ib_invalidate_range(struct mmu_interval_notifier *mni,
 				    const struct mmu_notifier_range *range,
 				    unsigned long cur_seq)
@@ -32,3 +34,84 @@ static bool rxe_ib_invalidate_range(struct mmu_interval_notifier *mni,
 const struct mmu_interval_notifier_ops rxe_mn_ops = {
 	.invalidate = rxe_ib_invalidate_range,
 };
+
+#define RXE_PAGEFAULT_RDONLY BIT(1)
+#define RXE_PAGEFAULT_SNAPSHOT BIT(2)
+static int rxe_odp_do_pagefault(struct rxe_mr *mr, u64 user_va, int bcnt, u32 flags)
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
+
+	return np;
+}
+
+static int rxe_init_odp_mr(struct rxe_mr *mr)
+{
+	int ret;
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+
+	ret = rxe_odp_do_pagefault(mr, mr->umem->address, mr->umem->length,
+				   RXE_PAGEFAULT_SNAPSHOT);
+
+	if (ret >= 0)
+		mutex_unlock(&umem_odp->umem_mutex);
+
+	return ret >= 0 ? 0 : ret;
+}
+
+int rxe_create_user_odp_mr(struct ib_pd *pd, u64 start, u64 length, u64 iova,
+			   int access_flags, struct rxe_mr *mr)
+{
+	int err;
+	struct ib_umem_odp *umem_odp;
+	struct rxe_dev *dev = container_of(pd->device, struct rxe_dev, ib_dev);
+
+	if (!IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING))
+		return -EOPNOTSUPP;
+
+	rxe_mr_init(access_flags, mr);
+
+	if (!start && length == U64_MAX) {
+		if (iova != 0)
+			return -EINVAL;
+		if (!(dev->attr.odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
+			return -EINVAL;
+
+		/* Never reach here, for implicit ODP is not implemented. */
+	}
+
+	umem_odp = ib_umem_odp_get(pd->device, start, length, access_flags,
+				   &rxe_mn_ops);
+	if (IS_ERR(umem_odp))
+		return PTR_ERR(umem_odp);
+
+	umem_odp->private = mr;
+
+	mr->odp_enabled = true;
+	mr->ibmr.pd = pd;
+	mr->umem = &umem_odp->umem;
+	mr->access = access_flags;
+	mr->ibmr.length = length;
+	mr->ibmr.iova = iova;
+	mr->offset = ib_umem_offset(&umem_odp->umem);
+	mr->state = RXE_MR_STATE_VALID;
+	mr->ibmr.type = IB_MR_TYPE_USER;
+
+	err = rxe_init_odp_mr(mr);
+
+	return err;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index e18bca076337..f2c803036888 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -627,8 +627,16 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
 	int	err;
 	int data_len = payload_size(pkt);
 
-	err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
-			  payload_addr(pkt), data_len, RXE_TO_MR_OBJ);
+	/* resp.mr is not set in check_rkey() for zero byte operations */
+	if (data_len == 0)
+		goto out;
+
+	if (qp->resp.mr->odp_enabled)
+		err = RESPST_ERR_UNSUPPORTED_OPCODE;
+	else
+		err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
+				  payload_addr(pkt), data_len, RXE_TO_MR_OBJ);
+
 	if (err) {
 		rc = RESPST_ERR_RKEY_VIOLATION;
 		goto out;
@@ -693,6 +701,9 @@ static enum resp_states process_flush(struct rxe_qp *qp,
 	struct rxe_mr *mr = qp->resp.mr;
 	struct resp_res *res = qp->resp.res;
 
+	if (mr->odp_enabled)
+		return RESPST_ERR_UNSUPPORTED_OPCODE;
+
 	/* oA19-14, oA19-15 */
 	if (res && res->replay)
 		return RESPST_ACKNOWLEDGE;
@@ -807,7 +818,11 @@ static enum resp_states rxe_atomic_reply(struct rxe_qp *qp,
 	if (!res->replay) {
 		if (mr->state != RXE_MR_STATE_VALID)
 			return RESPST_ERR_RKEY_VIOLATION;
-		ret = rxe_atomic_ops(qp, pkt, mr);
+
+		if (mr->odp_enabled)
+			ret = RESPST_ERR_UNSUPPORTED_OPCODE;
+		else
+			ret = rxe_atomic_ops(qp, pkt, mr);
 	} else
 		ret = RESPST_ACKNOWLEDGE;
 
@@ -822,6 +837,9 @@ static enum resp_states do_atomic_write(struct rxe_qp *qp,
 	int payload = payload_size(pkt);
 	u64 src, *dst;
 
+	if (mr->odp_enabled)
+		return RESPST_ERR_UNSUPPORTED_OPCODE;
+
 	if (mr->state != RXE_MR_STATE_VALID)
 		return RESPST_ERR_RKEY_VIOLATION;
 
@@ -1031,8 +1049,13 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		return RESPST_ERR_RNR;
 	}
 
-	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
-			  payload, RXE_FROM_MR_OBJ);
+	/* mr is NULL for a zero byte operation. */
+	if ((res->read.resid != 0) && mr->odp_enabled)
+		err = RESPST_ERR_UNSUPPORTED_OPCODE;
+	else
+		err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
+				  payload, RXE_FROM_MR_OBJ);
+
 	if (mr)
 		rxe_put(mr);
 	if (err) {
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 025b35bf014e..54cbb7a86019 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -903,7 +903,12 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	mr->ibmr.pd = ibpd;
 	mr->ibmr.device = ibpd->device;
 
-	err = rxe_mr_init_user(rxe, start, length, iova, access, mr);
+	if (access & IB_ACCESS_ON_DEMAND)
+		err = rxe_create_user_odp_mr(&pd->ibpd, start, length, iova,
+					     access, mr);
+	else
+		err = rxe_mr_init_user(rxe, start, length, iova, access, mr);
+
 	if (err)
 		goto err1;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 19ddfa890480..f90116576e7b 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -327,6 +327,8 @@ struct rxe_mr {
 	atomic_t		num_mw;
 
 	struct rxe_map		**map;
+
+	bool		        odp_enabled;
 };
 
 enum rxe_mw_state {
-- 
2.31.1

