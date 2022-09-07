Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DC65AFA17
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 04:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiIGCo5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Sep 2022 22:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIGCoz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Sep 2022 22:44:55 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1672B25D;
        Tue,  6 Sep 2022 19:44:53 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="75542771"
X-IronPort-AV: E=Sophos;i="5.93,295,1654527600"; 
   d="scan'208";a="75542771"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 07 Sep 2022 11:44:51 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6D6E9E8BFA;
        Wed,  7 Sep 2022 11:44:50 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 911F5B4B2E;
        Wed,  7 Sep 2022 11:44:49 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 4A661200B33B;
        Wed,  7 Sep 2022 11:44:49 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        rpearsonhpe@gmail.com, yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        y-goto@fujitsu.com, Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [RFC PATCH 4/7] RDMA/rxe: Add page invalidation support
Date:   Wed,  7 Sep 2022 11:43:02 +0900
Message-Id: <592ea028dff90a324af62623933b6c3c60a1dfde.1662461897.git.matsuda-daisuke@fujitsu.com>
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

On page invalidation, an MMU notifier callback is invoked to unmap DMA
addresses and update umem_odp->dma_list. The callback is registered when an
ODP-enabled MR is created.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/Makefile  |  3 ++-
 drivers/infiniband/sw/rxe/rxe_odp.c | 34 +++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_odp.c

diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
index 358f6b06aa64..924f4acb2816 100644
--- a/drivers/infiniband/sw/rxe/Makefile
+++ b/drivers/infiniband/sw/rxe/Makefile
@@ -22,4 +22,5 @@ rdma_rxe-y := \
 	rxe_mcast.o \
 	rxe_wq.o \
 	rxe_net.o \
-	rxe_hw_counters.o
+	rxe_hw_counters.o \
+	rxe_odp.o
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
new file mode 100644
index 000000000000..0f702787a66e
--- /dev/null
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2022 Fujitsu Ltd. All rights reserved.
+ */
+
+#include <rdma/ib_umem_odp.h>
+
+bool rxe_ib_invalidate_range(struct mmu_interval_notifier *mni,
+			     const struct mmu_notifier_range *range,
+			     unsigned long cur_seq)
+{
+	struct ib_umem_odp *umem_odp =
+		container_of(mni, struct ib_umem_odp, notifier);
+	unsigned long start;
+	unsigned long end;
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
2.31.1

