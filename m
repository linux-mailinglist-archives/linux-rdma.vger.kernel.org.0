Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF5C707BE4
	for <lists+linux-rdma@lfdr.de>; Thu, 18 May 2023 10:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjERIWv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 May 2023 04:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjERIWp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 May 2023 04:22:45 -0400
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFA1DA
        for <linux-rdma@vger.kernel.org>; Thu, 18 May 2023 01:22:35 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="116583933"
X-IronPort-AV: E=Sophos;i="5.99,284,1677510000"; 
   d="scan'208";a="116583933"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 17:22:33 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id D6B0FD5041;
        Thu, 18 May 2023 17:22:30 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 31585D21D5;
        Thu, 18 May 2023 17:22:30 +0900 (JST)
Received: from localhost.localdomain (unknown [10.118.237.106])
        by m3004.s.css.fujitsu.com (Postfix) with ESMTP id F0FBF200A4E1;
        Thu, 18 May 2023 17:22:29 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v5 6/7] RDMA/rxe: Add support for Send/Recv/Write/Read with ODP
Date:   Thu, 18 May 2023 17:21:51 +0900
Message-Id: <25d903e0136ea1e65c612d8f6b8c18c1f010add7.1684397037.git.matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
References: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
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

rxe_mr_copy() is used widely to copy data to/from a user MR. requester uses
it to load payloads of requesting packets; responder uses it to process
Send, Write, and Read operaetions; completer uses it to copy data from
response packets of Read and Atomic operations to a user MR.

Allow these operations to be used with ODP by adding a subordinate function
rxe_odp_mr_copy(). It is comprised of the following steps:
 1. Check the driver page table(umem_odp->dma_list) to see if pages being
    accessed are present with appropriate permission.
 2. If necessary, trigger page fault to map the pages.
 3. Update the MR xarray using PFNs in umem_odp->pfn_list.
 4. Execute data copy to/from the pages.

umem_mutex is used to ensure that dma_list (an array of addresses of an MR)
is not changed while it is being checked and that mapped pages are not
invalidated before data copy completes.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.c     |  10 +++
 drivers/infiniband/sw/rxe/rxe_loc.h |   8 ++
 drivers/infiniband/sw/rxe/rxe_mr.c  |   2 +-
 drivers/infiniband/sw/rxe/rxe_odp.c | 109 ++++++++++++++++++++++++++++
 4 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index f2284d27229b..207a022156f0 100644
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
index 93247d123642..4b95c8c46bdc 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -206,6 +206,8 @@ static inline unsigned int wr_opcode_mask(int opcode, struct rxe_qp *qp)
 #ifdef CONFIG_INFINIBAND_ON_DEMAND_PAGING
 int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 			 u64 iova, int access_flags, struct rxe_mr *mr);
+int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
+		    enum rxe_mr_copy_dir dir);
 #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 static inline int
 rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
@@ -213,6 +215,12 @@ rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 {
 	return -EOPNOTSUPP;
 }
+static inline int
+rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
+		int length, enum rxe_mr_copy_dir dir)
+{
+	return -EOPNOTSUPP;
+}
 
 #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index cd368cd096c8..0e3cda59d702 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -319,7 +319,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
 	}
 
 	if (mr->odp_enabled)
-		return -EOPNOTSUPP;
+		return rxe_odp_mr_copy(mr, iova, addr, length, dir);
 	else
 		return rxe_mr_copy_xarray(mr, iova, addr, length, dir);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index e5497d09c399..cbe5d0c3fcc4 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -174,3 +174,112 @@ int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 
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
+int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
+		    enum rxe_mr_copy_dir dir)
+{
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+	u32 flags = 0;
+	int err;
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
+	err =  rxe_mr_copy_xarray(mr, iova, addr, length, dir);
+
+	mutex_unlock(&umem_odp->umem_mutex);
+
+	return err;
+}
-- 
2.39.1

