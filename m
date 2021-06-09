Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF273A11FE
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 13:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbhFILHD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 07:07:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232165AbhFILHD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Jun 2021 07:07:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A97C26136D;
        Wed,  9 Jun 2021 11:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623236709;
        bh=cYAlIYrOiggPuMzoh6tvhaibv5NV1lgP/RvjETO+QoE=;
        h=From:To:Cc:Subject:Date:From;
        b=mCe5T4dz6g9nybpJjowAMnqpb8edfNWB4L+Uk5I/fcZNtDEJBjglVId/0UkITYWCT
         T2esUM/a0w3QuzI+dOEYR135Txs2GKPTQ+/Vt1PhEa6iz/fk2aSeM5kdsM9U9XH9GW
         GYsqK44KxoOHhlE+WRNVwpUHUYoo3HgzaT2/blI3NrI4tK0BDfceG14drtefMP9u4I
         34Miio6O6nAPBwxaIj/xlvaSkW2Exth+vPWHRwalYMGCj9yvcPpN9qihs4NrJV2zkv
         aXMsROsY6jQKP3t0GS1AdDUgS4iHpYwIqGyBD/L1+oq/MLLhz3g2ElLsh5rdGucaWG
         vyXHPK26x9zpA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Avihai Horon <avihaih@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Tom Talpey <tom@talpey.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Honggang LI <honli@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v2 rdma-next] RDMA/mlx5: Enable Relaxed Ordering by default for kernel ULPs
Date:   Wed,  9 Jun 2021 14:05:03 +0300
Message-Id: <b7e820aab7402b8efa63605f4ea465831b3b1e5e.1623236426.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

Relaxed Ordering is a capability that can only benefit users that support
it. All kernel ULPs should support Relaxed Ordering, as they are designed
to read data only after observing the CQE and use the DMA API correctly.

Hence, implicitly enable Relaxed Ordering by default for kernel ULPs.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Changelog:
v2:
 * Dropped IB/core patch and set RO implicitly in mlx5 exactly like in
   eth side of mlx5 driver.
v1: https://lore.kernel.org/lkml/cover.1621505111.git.leonro@nvidia.com
 * Enabled by default RO in IB/core instead of changing all users
v0: https://lore.kernel.org/lkml/20210405052404.213889-1-leon@kernel.org
---
 drivers/infiniband/hw/mlx5/mr.c | 10 ++++++----
 drivers/infiniband/hw/mlx5/wr.c |  5 ++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 3363cde85b14..2182e76ae734 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -69,6 +69,7 @@ static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
 					  struct ib_pd *pd)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
+	bool ro_pci_enabled = pcie_relaxed_ordering_enabled(dev->mdev->pdev);
 
 	MLX5_SET(mkc, mkc, a, !!(acc & IB_ACCESS_REMOTE_ATOMIC));
 	MLX5_SET(mkc, mkc, rw, !!(acc & IB_ACCESS_REMOTE_WRITE));
@@ -78,10 +79,10 @@ static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
 
 	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write))
 		MLX5_SET(mkc, mkc, relaxed_ordering_write,
-			 !!(acc & IB_ACCESS_RELAXED_ORDERING));
+			 acc & IB_ACCESS_RELAXED_ORDERING && ro_pci_enabled);
 	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read))
 		MLX5_SET(mkc, mkc, relaxed_ordering_read,
-			 !!(acc & IB_ACCESS_RELAXED_ORDERING));
+			 acc & IB_ACCESS_RELAXED_ORDERING && ro_pci_enabled);
 
 	MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
 	MLX5_SET(mkc, mkc, qpn, 0xffffff);
@@ -812,7 +813,8 @@ struct ib_mr *mlx5_ib_get_dma_mr(struct ib_pd *pd, int acc)
 
 	MLX5_SET(mkc, mkc, access_mode_1_0, MLX5_MKC_ACCESS_MODE_PA);
 	MLX5_SET(mkc, mkc, length64, 1);
-	set_mkc_access_pd_addr_fields(mkc, acc, 0, pd);
+	set_mkc_access_pd_addr_fields(mkc, acc | IB_ACCESS_RELAXED_ORDERING, 0,
+				      pd);
 
 	err = mlx5_ib_create_mkey(dev, &mr->mmkey, in, inlen);
 	if (err)
@@ -2022,7 +2024,7 @@ static void mlx5_set_umr_free_mkey(struct ib_pd *pd, u32 *in, int ndescs,
 	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
 
 	/* This is only used from the kernel, so setting the PD is OK. */
-	set_mkc_access_pd_addr_fields(mkc, 0, 0, pd);
+	set_mkc_access_pd_addr_fields(mkc, IB_ACCESS_RELAXED_ORDERING, 0, pd);
 	MLX5_SET(mkc, mkc, free, 1);
 	MLX5_SET(mkc, mkc, translations_octword_size, ndescs);
 	MLX5_SET(mkc, mkc, access_mode_1_0, access_mode & 0x3);
diff --git a/drivers/infiniband/hw/mlx5/wr.c b/drivers/infiniband/hw/mlx5/wr.c
index 6880627c45be..8841620af82f 100644
--- a/drivers/infiniband/hw/mlx5/wr.c
+++ b/drivers/infiniband/hw/mlx5/wr.c
@@ -866,7 +866,10 @@ static int set_reg_wr(struct mlx5_ib_qp *qp,
 	bool atomic = wr->access & IB_ACCESS_REMOTE_ATOMIC;
 	u8 flags = 0;
 
-	/* Matches access in mlx5_set_umr_free_mkey() */
+	/* Matches access in mlx5_set_umr_free_mkey().
+	 * Relaxed Ordering is set implicitly in mlx5_set_umr_free_mkey() and
+	 * kernel ULPs are not aware of it, so we don't set it here.
+	 */
 	if (!mlx5_ib_can_reconfig_with_umr(dev, 0, wr->access)) {
 		mlx5_ib_warn(
 			to_mdev(qp->ibqp.device),
-- 
2.31.1

