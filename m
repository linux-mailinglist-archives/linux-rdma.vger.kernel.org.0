Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C28707BDC
	for <lists+linux-rdma@lfdr.de>; Thu, 18 May 2023 10:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjERIWg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 May 2023 04:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjERIWd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 May 2023 04:22:33 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E2ADF;
        Thu, 18 May 2023 01:22:31 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="117164683"
X-IronPort-AV: E=Sophos;i="5.99,284,1677510000"; 
   d="scan'208";a="117164683"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 17:22:29 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 52A0AD6473;
        Thu, 18 May 2023 17:22:27 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 83F64D94AA;
        Thu, 18 May 2023 17:22:26 +0900 (JST)
Received: from localhost.localdomain (unknown [10.118.237.106])
        by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 3FB84200A4E1;
        Thu, 18 May 2023 17:22:26 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v5 4/7] RDMA/rxe: Add page invalidation support
Date:   Thu, 18 May 2023 17:21:49 +0900
Message-Id: <6e9d5e2d1b2a63385d1e4fc2a74c3b11d4909842.1684397037.git.matsuda-daisuke@fujitsu.com>
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

On page invalidation, an MMU notifier callback is invoked to unmap DMA
addresses and update the driver page table(umem_odp->dma_list). It also
set the corresponding entries in MR xarray to NULL to prevent any access.
The callback is registered when an ODP-enabled MR is created.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/Makefile  |  2 ++
 drivers/infiniband/sw/rxe/rxe_odp.c | 56 +++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_odp.c

diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
index 5395a581f4bb..93134f1d1d0c 100644
--- a/drivers/infiniband/sw/rxe/Makefile
+++ b/drivers/infiniband/sw/rxe/Makefile
@@ -23,3 +23,5 @@ rdma_rxe-y := \
 	rxe_task.o \
 	rxe_net.o \
 	rxe_hw_counters.o
+
+rdma_rxe-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += rxe_odp.o
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
new file mode 100644
index 000000000000..b69b25e0fef6
--- /dev/null
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2022-2023 Fujitsu Ltd. All rights reserved.
+ */
+
+#include <linux/hmm.h>
+
+#include <rdma/ib_umem_odp.h>
+
+#include "rxe.h"
+
+static void rxe_mr_unset_xarray(struct rxe_mr *mr, unsigned long start,
+				unsigned long end)
+{
+	unsigned long lower, upper, idx;
+
+	lower = rxe_mr_iova_to_index(mr, start);
+	upper = rxe_mr_iova_to_index(mr, end);
+
+	/* make elements in xarray NULL */
+	spin_lock(&mr->page_list.xa_lock);
+	for (idx = lower; idx <= upper; idx++)
+		__xa_erase(&mr->page_list, idx);
+	spin_unlock(&mr->page_list.xa_lock);
+}
+
+static bool rxe_ib_invalidate_range(struct mmu_interval_notifier *mni,
+				    const struct mmu_notifier_range *range,
+				    unsigned long cur_seq)
+{
+	struct ib_umem_odp *umem_odp =
+		container_of(mni, struct ib_umem_odp, notifier);
+	struct rxe_mr *mr = umem_odp->private;
+	unsigned long start, end;
+
+	if (!mmu_notifier_range_blockable(range))
+		return false;
+
+	mutex_lock(&umem_odp->umem_mutex);
+	mmu_interval_set_seq(mni, cur_seq);
+
+	start = max_t(u64, ib_umem_start(umem_odp), range->start);
+	end = min_t(u64, ib_umem_end(umem_odp), range->end);
+
+	rxe_mr_unset_xarray(mr, start, end);
+
+	/* update umem_odp->dma_list */
+	ib_umem_odp_unmap_dma_pages(umem_odp, start, end);
+
+	mutex_unlock(&umem_odp->umem_mutex);
+	return true;
+}
+
+const struct mmu_interval_notifier_ops rxe_mn_ops = {
+	.invalidate = rxe_ib_invalidate_range,
+};
-- 
2.39.1

