Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD3717F1D3
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 09:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgCJIW4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 04:22:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgCJIW4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 04:22:56 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA40F2467D;
        Tue, 10 Mar 2020 08:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583828575;
        bh=5MGYsTRI+cFZ28Y1jxtnUR/dUjHDkzUGziMoWdeQQTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eMhnPDFx/d7MS+4jCg/rfLFIo5P3thP0xo+h/QDUx3jI93nXkkVJjR6xHqNLljENP
         wFAV5dxPfqck+0NLOByTzQRLbqHE+VKy+Y9s7LWvi2poTKlDrVk2lwm4yk/F2+07UR
         YiJgwW6NR+1MjIHJUMh6K5gyTWJiHyJZ7zzOZ04U=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Saeed Mahameed <saeedm@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 03/12] IB/mlx5: Replace spinlock protected write with atomic var
Date:   Tue, 10 Mar 2020 10:22:29 +0200
Message-Id: <20200310082238.239865-4-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310082238.239865-1-leon@kernel.org>
References: <20200310082238.239865-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Saeed Mahameed <saeedm@mellanox.com>

mkey variant calculation was spinlock protected to make it atomic, replace
that with one atomic variable.

Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c    | 2 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 5 +----
 drivers/infiniband/hw/mlx5/mr.c      | 6 +-----
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 73127c52958f..9da2787dfcb2 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6393,7 +6393,7 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	spin_lock_init(&dev->reset_flow_resource_lock);
 	xa_init(&dev->odp_mkeys);
 	xa_init(&dev->sig_mrs);
-	spin_lock_init(&dev->mkey_lock);
+	atomic_set(&dev->mkey_var, 0);
 
 	spin_lock_init(&dev->dm.lock);
 	dev->dm.dev = mdev;
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 9d00cf9ccb08..a00b2e8c82f0 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1000,10 +1000,7 @@ struct mlx5_ib_dev {
 	 */
 	struct mlx5_ib_resources	devr;
 
-	/* protect mkey key part */
-	spinlock_t			mkey_lock;
-	u8				mkey_key;
-
+	atomic_t			mkey_var;
 	struct mlx5_mr_cache		cache;
 	struct timer_list		delay_timer;
 	/* Prevents soft lock on massive reg MRs */
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 1b83d00e8ecd..70ae3372411a 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -54,12 +54,8 @@ static void
 assign_mkey_variant(struct mlx5_ib_dev *dev, struct mlx5_core_mkey *mkey,
 		    u32 *in)
 {
+	u8 key = atomic_inc_return(&dev->mkey_var);
 	void *mkc;
-	u8 key;
-
-	spin_lock_irq(&dev->mkey_lock);
-	key = dev->mkey_key++;
-	spin_unlock_irq(&dev->mkey_lock);
 
 	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
 	MLX5_SET(mkc, mkc, mkey_7_0, key);
-- 
2.24.1

