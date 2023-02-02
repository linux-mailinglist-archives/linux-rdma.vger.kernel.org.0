Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CCE68782B
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 10:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjBBJDd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 04:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjBBJD0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 04:03:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCCBA2
        for <linux-rdma@vger.kernel.org>; Thu,  2 Feb 2023 01:03:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A6AD6192B
        for <linux-rdma@vger.kernel.org>; Thu,  2 Feb 2023 09:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353E4C433D2;
        Thu,  2 Feb 2023 09:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675328600;
        bh=nfiwIFCRHnnUF7GhQ58xsfp6Szun+7IZC8Ii9isYTNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oEt8lVidQtgVOuxfMRh/HWv2QVgjlLd4+RIuCvfzbTyR5aUOW2TkjjdoW2YWpKcfa
         vmDEGDsWVmkrm4eq+xIeK1Q7nxozbrMPghF3rrOshcCAE3a3LepZ2lzzp2ZXlRh2wh
         ZZW5xoiaowUINjkOT8Gzi5NRl9rMLvF96U+4XSyVhvUvQVNynn2DngOLBpxFyYHBEU
         njxY8w+3e4v6ff+VPmH4IjJKVylzMXJjeU/yAt7t5oa2X7niXm6cu2IBx8RIP20KcP
         Xz6gUhiYeH0/Om2VgJueoR+fvcyaREUmvxEKw4BtqnU62ifBPZadnXHUsRImHpugd7
         +xTP4FGeswX5A==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 2/2] RDMA/mlx5: Remove impossible check of mkey cache cleanup failure
Date:   Thu,  2 Feb 2023 11:03:07 +0200
Message-Id: <1acd9528995d083114e7dec2a2afc59436406583.1675328463.git.leon@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675328463.git.leon@kernel.org>
References: <cover.1675328463.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

mlx5_mkey_cache_cleanup() can't fail and can be changed to be void.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c    | 7 +------
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 2 +-
 drivers/infiniband/hw/mlx5/mr.c      | 6 ++----
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 10f12e9a4dc3..e252ba138690 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4005,12 +4005,7 @@ static int mlx5_ib_stage_ib_reg_init(struct mlx5_ib_dev *dev)
 
 static void mlx5_ib_stage_pre_ib_reg_umr_cleanup(struct mlx5_ib_dev *dev)
 {
-	int err;
-
-	err = mlx5_mkey_cache_cleanup(dev);
-	if (err)
-		mlx5_ib_warn(dev, "mr cache cleanup failed\n");
-
+	mlx5_mkey_cache_cleanup(dev);
 	mlx5r_umr_resource_cleanup(dev);
 }
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 58d02e778c4b..93420b73bf20 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1337,7 +1337,7 @@ void mlx5_ib_populate_pas(struct ib_umem *umem, size_t page_size, __be64 *pas,
 void mlx5_ib_copy_pas(u64 *old, u64 *new, int step, int num);
 int mlx5_ib_get_cqe_size(struct ib_cq *ibcq);
 int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev);
-int mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev);
+void mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev);
 struct mlx5_cache_ent *
 mlx5r_cache_create_ent_locked(struct mlx5_ib_dev *dev,
 			      struct mlx5r_cache_rb_key rb_key,
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 3f410eef58e4..68102297b9cb 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1014,14 +1014,14 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 	return ret;
 }
 
-int mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
+void mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
 {
 	struct rb_root *root = &dev->cache.rb_root;
 	struct mlx5_cache_ent *ent;
 	struct rb_node *node;
 
 	if (!dev->cache.wq)
-		return 0;
+		return;
 
 	cancel_delayed_work_sync(&dev->cache.remove_ent_dwork);
 	mutex_lock(&dev->cache.rb_lock);
@@ -1048,8 +1048,6 @@ int mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
 
 	destroy_workqueue(dev->cache.wq);
 	del_timer_sync(&dev->delay_timer);
-
-	return 0;
 }
 
 struct ib_mr *mlx5_ib_get_dma_mr(struct ib_pd *pd, int acc)
-- 
2.39.1

