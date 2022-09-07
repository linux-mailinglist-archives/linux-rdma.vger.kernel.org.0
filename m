Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831505AFA25
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 04:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiIGCpu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Sep 2022 22:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiIGCpl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Sep 2022 22:45:41 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Sep 2022 19:45:35 PDT
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352B77C771;
        Tue,  6 Sep 2022 19:45:34 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="67029789"
X-IronPort-AV: E=Sophos;i="5.93,295,1654527600"; 
   d="scan'208";a="67029789"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 07 Sep 2022 11:45:13 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id BB300D63BA;
        Wed,  7 Sep 2022 11:45:11 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id E495CD6806;
        Wed,  7 Sep 2022 11:45:10 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3002.s.css.fujitsu.com (Postfix) with ESMTP id A03AA200B33B;
        Wed,  7 Sep 2022 11:45:10 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        rpearsonhpe@gmail.com, yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        y-goto@fujitsu.com, Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [RFC PATCH 7/7] RDMA/rxe: Add support for the traditional Atomic operations with ODP
Date:   Wed,  7 Sep 2022 11:43:05 +0900
Message-Id: <e4ae56c3cb40c8d1b6a523d48a84d7e0d9e5d8de.1662461897.git.matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1662461897.git.matsuda-daisuke@fujitsu.com>
References: <cover.1662461897.git.matsuda-daisuke@fujitsu.com>
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

Enable 'fetch and add' and 'compare and swap' operations to manipulate
data in an ODP-enabled MR. This is comprised of the following steps:
 1. Check the driver page table(umem_odp->dma_list) to see if the target
    page is both readable and writable.
 2. If not, then trigger page fault to map the page.
 3. Convert its user space address to a kernel logical address using PFNs
    in the driver page table(umem_odp->pfn_list).
 4. Execute the operation.

umem_mutex is used to ensure that dma_list (an array of addresses of an MR)
is not changed while it is checked and that the target page is not
invalidated before data access completes.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.c      |  1 +
 drivers/infiniband/sw/rxe/rxe_loc.h  |  2 ++
 drivers/infiniband/sw/rxe/rxe_odp.c  | 42 ++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c | 38 ++----------------------
 drivers/infiniband/sw/rxe/rxe_resp.h | 44 ++++++++++++++++++++++++++++
 5 files changed, 91 insertions(+), 36 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_resp.h

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index dd287fc60e9d..8190af3e9afe 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -88,6 +88,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_RECV;
 		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_WRITE;
 		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_READ;
+		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_ATOMIC;
 		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_SRQ_RECV;
 	}
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 91982b5a690c..1d10a58bbd5b 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -194,5 +194,7 @@ int rxe_create_user_odp_mr(struct ib_pd *pd, u64 start, u64 length, u64 iova,
 			   int access_flags, struct rxe_mr *mr);
 int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		    enum rxe_mr_copy_dir dir);
+enum resp_states rxe_odp_atomic_ops(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
+				    struct rxe_mr *mr);
 
 #endif /* RXE_LOC_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index 85c34995c704..3297d124c90e 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -8,6 +8,7 @@
 #include <rdma/ib_umem_odp.h>
 
 #include "rxe.h"
+#include "rxe_resp.h"
 
 bool rxe_ib_invalidate_range(struct mmu_interval_notifier *mni,
 			     const struct mmu_notifier_range *range,
@@ -285,3 +286,44 @@ int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 
 	return __rxe_odp_mr_copy(mr, iova, addr, length, dir);
 }
+
+static inline void *rxe_odp_get_virt_atomic(struct rxe_qp *qp, struct rxe_mr *mr)
+{
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+	u64 iova = qp->resp.va + qp->resp.offset;
+	int idx;
+	size_t offset;
+
+	if (rxe_odp_map_range(mr, iova, sizeof(char), 0))
+		return NULL;
+
+	idx = (iova - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
+	offset = iova & (BIT(umem_odp->page_shift) - 1);
+
+	return rxe_odp_get_virt(umem_odp, idx, offset);
+}
+
+enum resp_states rxe_odp_atomic_ops(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
+				    struct rxe_mr *mr)
+{
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+	u64 *vaddr;
+	int ret;
+
+	if (WARN_ON(!mr->odp_enabled))
+		return RESPST_ERR_RKEY_VIOLATION;
+
+	/* umem mutex is locked here to prevent MR invalidation before memory
+	 * access completes.
+	 */
+	vaddr = (u64 *)rxe_odp_get_virt_atomic(qp, mr);
+
+	if (pkt->mask & RXE_ATOMIC_MASK)
+		ret = rxe_process_atomic(qp, pkt, vaddr);
+	else
+		/* ATOMIC WRITE operation will come here. */
+		ret = RESPST_ERR_RKEY_VIOLATION;
+
+	mutex_unlock(&umem_odp->umem_mutex);
+	return ret;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index bf439004c378..663e5b32c9cb 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -9,41 +9,7 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 #include "rxe_queue.h"
-
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
+#include "rxe_resp.h"
 
 static char *resp_state_name[] = {
 	[RESPST_NONE]				= "NONE",
@@ -673,7 +639,7 @@ static enum resp_states rxe_atomic_reply(struct rxe_qp *qp,
 			return RESPST_ERR_RKEY_VIOLATION;
 
 		if (mr->odp_enabled)
-			ret = RESPST_ERR_UNSUPPORTED_OPCODE;
+			ret = rxe_odp_atomic_ops(qp, pkt, mr);
 		else
 			ret = rxe_atomic_ops(qp, pkt, mr);
 	} else
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.h b/drivers/infiniband/sw/rxe/rxe_resp.h
new file mode 100644
index 000000000000..cb907b49175f
--- /dev/null
+++ b/drivers/infiniband/sw/rxe/rxe_resp.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+
+#ifndef RXE_RESP_H
+#define RXE_RESP_H
+
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
+enum resp_states rxe_process_atomic(struct rxe_qp *qp,
+				    struct rxe_pkt_info *pkt, u64 *vaddr);
+
+#endif /* RXE_RESP_H */
-- 
2.31.1

