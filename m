Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E60625693
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 10:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiKKJZI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Nov 2022 04:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbiKKJZH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Nov 2022 04:25:07 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Nov 2022 01:25:06 PST
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BF36C73A
        for <linux-rdma@vger.kernel.org>; Fri, 11 Nov 2022 01:25:06 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="95511344"
X-IronPort-AV: E=Sophos;i="5.96,156,1665414000"; 
   d="scan'208";a="95511344"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP; 11 Nov 2022 18:24:00 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 27AFAD647F;
        Fri, 11 Nov 2022 18:23:58 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 616BAD5CCD;
        Fri, 11 Nov 2022 18:23:57 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 19F8C20607A2;
        Fri, 11 Nov 2022 18:23:57 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        rpearsonhpe@gmail.com, yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        y-goto@fujitsu.com, Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [RFC PATCH v2 4/7] RDMA/rxe: Add page invalidation support
Date:   Fri, 11 Nov 2022 18:22:25 +0900
Message-Id: <c100a24558b7beb13d54f27a671cfed50d251f6d.1668157436.git.matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1668157436.git.matsuda-daisuke@fujitsu.com>
References: <cover.1668157436.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 000000000000..0787a9b19646
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
+static bool rxe_ib_invalidate_range(struct mmu_interval_notifier *mni,
+				    const struct mmu_notifier_range *range,
+				    unsigned long cur_seq)
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

