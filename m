Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEEA268A06
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 13:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgINL2B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 07:28:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbgINL1P (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 14 Sep 2020 07:27:15 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B82C21973;
        Mon, 14 Sep 2020 11:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600082828;
        bh=5q8ktS+khzrRk/xAS0GYjWiFPQt6lw2T7rj8Dfp2Z8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDPPp7WqyyaI5g9T3tZGonJqCGJ1hAYGNuGqIczyErNn1/aIserGWeqtbvr5TPwTP
         rvPL3w4q6UG+Q4NTcZ37BKyjxxLmLWlzskZAbmv1/5IqFcSpYQJAhzdIimGCWssj6m
         TtAtz4y5aROmF5TeqOm7nIDUMVMsMEgQ5GuL6yZQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Artemy Kovalyov <artemyko@mellanox.com>,
        linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next 3/5] RDMA/mlx5: Make mkeys always owned by the kernel's PD when not enabled
Date:   Mon, 14 Sep 2020 14:26:51 +0300
Message-Id: <20200914112653.345244-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914112653.345244-1-leon@kernel.org>
References: <20200914112653.345244-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Any mkey that is not enabled and assigned to userspace should have the PD
set to a kernel owned PD.

When cache entries are created for the first time the PDN is set to 0,
which is probably a kernel PD, but be explicit.

When a MR is registered using the hybrid reg_create with UMR xlt & enable
the disabled mkey is pointing at the user PD, keep it pointing at the
kernel until a UMR enables it and sets the user PD.

Fixes: 9ec4483a3f0f ("IB/mlx5: Move MRs to a kernel PD when freeing them to the MR cache")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 51 +++++++++++++++++----------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index b21eb9dec185..76cca9885556 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -52,6 +52,29 @@ enum {
 static void
 create_mkey_callback(int status, struct mlx5_async_work *context);
 
+static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
+					  struct ib_pd *pd)
+{
+	struct mlx5_ib_dev *dev = to_mdev(pd->device);
+
+	MLX5_SET(mkc, mkc, a, !!(acc & IB_ACCESS_REMOTE_ATOMIC));
+	MLX5_SET(mkc, mkc, rw, !!(acc & IB_ACCESS_REMOTE_WRITE));
+	MLX5_SET(mkc, mkc, rr, !!(acc & IB_ACCESS_REMOTE_READ));
+	MLX5_SET(mkc, mkc, lw, !!(acc & IB_ACCESS_LOCAL_WRITE));
+	MLX5_SET(mkc, mkc, lr, 1);
+
+	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write))
+		MLX5_SET(mkc, mkc, relaxed_ordering_write,
+			 !!(acc & IB_ACCESS_RELAXED_ORDERING));
+	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read))
+		MLX5_SET(mkc, mkc, relaxed_ordering_read,
+			 !!(acc & IB_ACCESS_RELAXED_ORDERING));
+
+	MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
+	MLX5_SET(mkc, mkc, qpn, 0xffffff);
+	MLX5_SET64(mkc, mkc, start_addr, start_addr);
+}
+
 static void
 assign_mkey_variant(struct mlx5_ib_dev *dev, struct mlx5_core_mkey *mkey,
 		    u32 *in)
@@ -154,12 +177,12 @@ static struct mlx5_ib_mr *alloc_cache_mr(struct mlx5_cache_ent *ent, void *mkc)
 	mr->cache_ent = ent;
 	mr->dev = ent->dev;
 
+	set_mkc_access_pd_addr_fields(mkc, 0, 0, ent->dev->umrc.pd);
 	MLX5_SET(mkc, mkc, free, 1);
 	MLX5_SET(mkc, mkc, umr_en, 1);
 	MLX5_SET(mkc, mkc, access_mode_1_0, ent->access_mode & 0x3);
 	MLX5_SET(mkc, mkc, access_mode_4_2, (ent->access_mode >> 2) & 0x7);
 
-	MLX5_SET(mkc, mkc, qpn, 0xffffff);
 	MLX5_SET(mkc, mkc, translations_octword_size, ent->xlt);
 	MLX5_SET(mkc, mkc, log_page_size, ent->page);
 	return mr;
@@ -776,29 +799,6 @@ int mlx5_mr_cache_cleanup(struct mlx5_ib_dev *dev)
 	return 0;
 }
 
-static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
-					  struct ib_pd *pd)
-{
-	struct mlx5_ib_dev *dev = to_mdev(pd->device);
-
-	MLX5_SET(mkc, mkc, a, !!(acc & IB_ACCESS_REMOTE_ATOMIC));
-	MLX5_SET(mkc, mkc, rw, !!(acc & IB_ACCESS_REMOTE_WRITE));
-	MLX5_SET(mkc, mkc, rr, !!(acc & IB_ACCESS_REMOTE_READ));
-	MLX5_SET(mkc, mkc, lw, !!(acc & IB_ACCESS_LOCAL_WRITE));
-	MLX5_SET(mkc, mkc, lr, 1);
-
-	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write))
-		MLX5_SET(mkc, mkc, relaxed_ordering_write,
-			 !!(acc & IB_ACCESS_RELAXED_ORDERING));
-	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read))
-		MLX5_SET(mkc, mkc, relaxed_ordering_read,
-			 !!(acc & IB_ACCESS_RELAXED_ORDERING));
-
-	MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
-	MLX5_SET(mkc, mkc, qpn, 0xffffff);
-	MLX5_SET64(mkc, mkc, start_addr, start_addr);
-}
-
 struct ib_mr *mlx5_ib_get_dma_mr(struct ib_pd *pd, int acc)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
@@ -1199,7 +1199,8 @@ static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
 	MLX5_SET(create_mkey_in, in, pg_access, !!(pg_cap));
 
 	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
-	set_mkc_access_pd_addr_fields(mkc, access_flags, virt_addr, pd);
+	set_mkc_access_pd_addr_fields(mkc, access_flags, virt_addr,
+				      populate ? pd : dev->umrc.pd);
 	MLX5_SET(mkc, mkc, free, !populate);
 	MLX5_SET(mkc, mkc, access_mode_1_0, MLX5_MKC_ACCESS_MODE_MTT);
 	MLX5_SET(mkc, mkc, umr_en, 1);
-- 
2.26.2

