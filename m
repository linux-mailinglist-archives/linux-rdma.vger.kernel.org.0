Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6CF62568C
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 10:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbiKKJYB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Nov 2022 04:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbiKKJYA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Nov 2022 04:24:00 -0500
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21996C729;
        Fri, 11 Nov 2022 01:23:55 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="96366187"
X-IronPort-AV: E=Sophos;i="5.96,156,1665414000"; 
   d="scan'208";a="96366187"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 11 Nov 2022 18:23:54 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 719DCD66A2;
        Fri, 11 Nov 2022 18:23:52 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id C683FE535F;
        Fri, 11 Nov 2022 18:23:51 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 9083620607A2;
        Fri, 11 Nov 2022 18:23:51 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        rpearsonhpe@gmail.com, yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        y-goto@fujitsu.com, Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [RFC PATCH v2 1/7] IB/mlx5: Change ib_umem_odp_map_dma_single_page() to retain umem_mutex
Date:   Fri, 11 Nov 2022 18:22:22 +0900
Message-Id: <b9974985069900c80b8ff9e6b0b0b346c1592910.1668157436.git.matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1668157436.git.matsuda-daisuke@fujitsu.com>
References: <cover.1668157436.git.matsuda-daisuke@fujitsu.com>
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

ib_umem_odp_map_dma_single_page(), which has been used only by the mlx5
driver, holds umem_mutex on success and releases on failure. This
behavior is not convenient for other drivers to use it, so change it to
always retain mutex on return.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/core/umem_odp.c | 8 +++-----
 drivers/infiniband/hw/mlx5/odp.c   | 4 +++-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index e9fa22d31c23..49da6735f7c8 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -328,8 +328,8 @@ static int ib_umem_odp_map_dma_single_page(
  *
  * Maps the range passed in the argument to DMA addresses.
  * The DMA addresses of the mapped pages is updated in umem_odp->dma_list.
- * Upon success the ODP MR will be locked to let caller complete its device
- * page table update.
+ * The umem mutex is locked in this function. Callers are responsible for
+ * releasing the lock.
  *
  * Returns the number of pages mapped in success, negative error code
  * for failure.
@@ -453,11 +453,9 @@ int ib_umem_odp_map_dma_and_lock(struct ib_umem_odp *umem_odp, u64 user_virt,
 			break;
 		}
 	}
-	/* upon success lock should stay on hold for the callee */
+
 	if (!ret)
 		ret = dma_index - start_idx;
-	else
-		mutex_unlock(&umem_odp->umem_mutex);
 
 out_put_mm:
 	mmput_async(owning_mm);
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index bc97958818bb..a0de27651586 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -572,8 +572,10 @@ static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 		access_mask |= ODP_WRITE_ALLOWED_BIT;
 
 	np = ib_umem_odp_map_dma_and_lock(odp, user_va, bcnt, access_mask, fault);
-	if (np < 0)
+	if (np < 0) {
+		mutex_unlock(&odp->umem_mutex);
 		return np;
+	}
 
 	/*
 	 * No need to check whether the MTTs really belong to this MR, since
-- 
2.31.1

