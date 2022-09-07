Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF38B5AFA1A
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 04:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiIGCo0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Sep 2022 22:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiIGCoY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Sep 2022 22:44:24 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CFE23B
        for <linux-rdma@vger.kernel.org>; Tue,  6 Sep 2022 19:44:22 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="75686890"
X-IronPort-AV: E=Sophos;i="5.93,295,1654527600"; 
   d="scan'208";a="75686890"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP; 07 Sep 2022 11:44:19 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id CAA71DAFCF;
        Wed,  7 Sep 2022 11:44:18 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 2AFA7D35ED;
        Wed,  7 Sep 2022 11:44:18 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3002.s.css.fujitsu.com (Postfix) with ESMTP id EA7D3200B45F;
        Wed,  7 Sep 2022 11:44:17 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        rpearsonhpe@gmail.com, yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        y-goto@fujitsu.com, Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [RFC PATCH 1/7] IB/mlx5: Change ib_umem_odp_map_dma_single_page() to retain umem_mutex
Date:   Wed,  7 Sep 2022 11:42:59 +0900
Message-Id: <33fae63a51729aa44470f2fbafe0d0d7ac90d58d.1662461897.git.matsuda-daisuke@fujitsu.com>
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

ib_umem_odp_map_dma_single_page(), which has been used only by the mlx5
driver, holds umem_mutex on success and releases on failure. This
behavior is not convenient for other drivers to use it, so change it to
always retain mutex on return.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/core/umem_odp.c | 6 ++----
 drivers/infiniband/hw/mlx5/odp.c   | 4 +++-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index c459c4d011cf..92617a021439 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -328,8 +328,8 @@ static int ib_umem_odp_map_dma_single_page(
  *
  * Maps the range passed in the argument to DMA addresses.
  * The DMA addresses of the mapped pages is updated in umem_odp->dma_list.
- * Upon success the ODP MR will be locked to let caller complete its device
- * page table update.
+ * The umem mutex is locked and not released in this function. The caller should
+ * complete its device page table update before releasing the lock.
  *
  * Returns the number of pages mapped in success, negative error code
  * for failure.
@@ -456,8 +456,6 @@ int ib_umem_odp_map_dma_and_lock(struct ib_umem_odp *umem_odp, u64 user_virt,
 	/* upon success lock should stay on hold for the callee */
 	if (!ret)
 		ret = dma_index - start_idx;
-	else
-		mutex_unlock(&umem_odp->umem_mutex);
 
 out_put_mm:
 	mmput(owning_mm);
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

