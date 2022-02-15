Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFA64B75FC
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242791AbiBOR4J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 12:56:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242773AbiBOR4E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 12:56:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B8F100752;
        Tue, 15 Feb 2022 09:55:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CFA261680;
        Tue, 15 Feb 2022 17:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C8FC340F0;
        Tue, 15 Feb 2022 17:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644947752;
        bh=InSI9IRC0TSnLYg3Oy+j5w3kuyYPnRoF8BcDH5c0t+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JtUUUIgrQwVMp37sfy/ck666DHN8IgasLKz8/4zieqLBJdIPBjPuOkTpdnbgVLuqU
         xXzvGWLm4aoyxWd4aOnxquNilKCHffmJ7rW2KWyneQdzD49npNeQCwH/UIyLgC//m0
         DDkZBhQ8F1kkWO3PkwLlcmu1f5OxPQFSAwLDXVC7FI2ll62UVt/xA2yTeB0ToaKm0W
         zkCHNiHto1KLkXAcP4tehoTYa2KU17hFawxgtuQUx07kXi5SlJlhOcRxI0Y786xuBi
         0wtfZk8Ank0pgGBGJ0y2sPlPnO6FeeehYmqHkXkoKQa2XKTxb9ANOXOgO08/QBoy7V
         orU03nIZenSWg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 3/5] RDMA/mlx5: Merge similar flows of allocating MR from the cache
Date:   Tue, 15 Feb 2022 19:55:31 +0200
Message-Id: <53c85fcd4de6ec9de0b8e6cbb1bf5d5fe19900c3.1644947594.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644947594.git.leonro@nvidia.com>
References: <cover.1644947594.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

When allocating a MR from the cache, the driver calls to get_cache_mr(),
and in case of failure, retries with create_cache_mr(). This is the flow
of mlx5_mr_cache_alloc(), so use it instead.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  3 +-
 drivers/infiniband/hw/mlx5/mr.c      | 47 +++-------------------------
 drivers/infiniband/hw/mlx5/odp.c     | 11 +++++--
 3 files changed, 15 insertions(+), 46 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index bacb6900b39f..751d02bc755b 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1343,7 +1343,8 @@ int mlx5_mr_cache_init(struct mlx5_ib_dev *dev);
 int mlx5_mr_cache_cleanup(struct mlx5_ib_dev *dev);
 
 struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
-				       unsigned int entry, int access_flags);
+				       struct mlx5_cache_ent *ent,
+				       int access_flags);
 
 int mlx5_ib_check_mr_status(struct ib_mr *ibmr, u32 check_mask,
 			    struct ib_mr_status *mr_status);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index bce3cb6af524..0c1dc13b4c45 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -558,23 +558,16 @@ static void delayed_cache_work_func(struct work_struct *work)
 	__cache_work_func(ent);
 }
 
-/* Allocate a special entry from the cache */
 struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
-				       unsigned int entry, int access_flags)
+				       struct mlx5_cache_ent *ent,
+				       int access_flags)
 {
-	struct mlx5_mr_cache *cache = &dev->cache;
-	struct mlx5_cache_ent *ent;
 	struct mlx5_ib_mr *mr;
 
-	if (WARN_ON(entry <= MR_CACHE_LAST_STD_ENTRY ||
-		    entry >= ARRAY_SIZE(cache->ent)))
-		return ERR_PTR(-EINVAL);
-
 	/* Matches access in alloc_cache_mr() */
 	if (!mlx5_ib_can_reconfig_with_umr(dev, 0, access_flags))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	ent = &cache->ent[entry];
 	spin_lock_irq(&ent->lock);
 	if (list_empty(&ent->head)) {
 		queue_adjust_cache_locked(ent);
@@ -592,32 +585,9 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 
 		mlx5_clear_mr(mr);
 	}
-	mr->access_flags = access_flags;
 	return mr;
 }
 
-/* Return a MR already available in the cache */
-static struct mlx5_ib_mr *get_cache_mr(struct mlx5_cache_ent *req_ent)
-{
-	struct mlx5_ib_mr *mr = NULL;
-	struct mlx5_cache_ent *ent = req_ent;
-
-	spin_lock_irq(&ent->lock);
-	if (!list_empty(&ent->head)) {
-		mr = list_first_entry(&ent->head, struct mlx5_ib_mr, list);
-		list_del(&mr->list);
-		ent->available_mrs--;
-		queue_adjust_cache_locked(ent);
-		spin_unlock_irq(&ent->lock);
-		mlx5_clear_mr(mr);
-		return mr;
-	}
-	queue_adjust_cache_locked(ent);
-	spin_unlock_irq(&ent->lock);
-	req_ent->miss++;
-	return NULL;
-}
-
 static void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 {
 	struct mlx5_cache_ent *ent = mr->cache_ent;
@@ -951,16 +921,9 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 		return mr;
 	}
 
-	mr = get_cache_mr(ent);
-	if (!mr) {
-		mr = create_cache_mr(ent);
-		/*
-		 * The above already tried to do the same stuff as reg_create(),
-		 * no reason to try it again.
-		 */
-		if (IS_ERR(mr))
-			return mr;
-	}
+	mr = mlx5_mr_cache_alloc(dev, ent, access_flags);
+	if (IS_ERR(mr))
+		return mr;
 
 	mr->ibmr.pd = pd;
 	mr->umem = umem;
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 86842cd580ba..f834c9590c51 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -407,6 +407,7 @@ static void mlx5_ib_page_fault_resume(struct mlx5_ib_dev *dev,
 static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 						unsigned long idx)
 {
+	struct mlx5_ib_dev *dev = mr_to_mdev(imr);
 	struct ib_umem_odp *odp;
 	struct mlx5_ib_mr *mr;
 	struct mlx5_ib_mr *ret;
@@ -418,13 +419,14 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	if (IS_ERR(odp))
 		return ERR_CAST(odp);
 
-	mr = mlx5_mr_cache_alloc(
-		mr_to_mdev(imr), MLX5_IMR_MTT_CACHE_ENTRY, imr->access_flags);
+	mr = mlx5_mr_cache_alloc(dev, &dev->cache.ent[MLX5_IMR_MTT_CACHE_ENTRY],
+				 imr->access_flags);
 	if (IS_ERR(mr)) {
 		ib_umem_odp_release(odp);
 		return mr;
 	}
 
+	mr->access_flags = imr->access_flags;
 	mr->ibmr.pd = imr->ibmr.pd;
 	mr->ibmr.device = &mr_to_mdev(imr)->ib_dev;
 	mr->umem = &odp->umem;
@@ -493,12 +495,15 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 	if (IS_ERR(umem_odp))
 		return ERR_CAST(umem_odp);
 
-	imr = mlx5_mr_cache_alloc(dev, MLX5_IMR_KSM_CACHE_ENTRY, access_flags);
+	imr = mlx5_mr_cache_alloc(dev,
+				  &dev->cache.ent[MLX5_IMR_KSM_CACHE_ENTRY],
+				  access_flags);
 	if (IS_ERR(imr)) {
 		ib_umem_odp_release(umem_odp);
 		return imr;
 	}
 
+	imr->access_flags = access_flags;
 	imr->ibmr.pd = &pd->ibpd;
 	imr->ibmr.iova = 0;
 	imr->umem = &umem_odp->umem;
-- 
2.35.1

