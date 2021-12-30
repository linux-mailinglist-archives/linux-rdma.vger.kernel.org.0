Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B465481BAA
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Dec 2021 12:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238886AbhL3LXi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Dec 2021 06:23:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60622 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbhL3LXh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Dec 2021 06:23:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26AAEB80B3A;
        Thu, 30 Dec 2021 11:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A59C36AEA;
        Thu, 30 Dec 2021 11:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640863414;
        bh=YZKLVpxRB2F1djgguiiA+gLT6qBxeg7fWB1+NZn0g3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WGt+ZtiP05KwZgUx8dQTuBEioi/oFiKTi54CpS1ee9M7ZKixpZlPFp30Q84IBvtB0
         ECnUrLrsFZZ9w5LQcWu1e8BRDLhGwApaY9/v5B7l4gStcrkVrHZjZ0akf1FvsJ0JrH
         YzRu4B3taUf75KJ8PwpmtjFNOwJujjW/ELmNfpy9Lid4BjLyh3OueS2DPK7uOe2Xdy
         XlHue8DCW7CRpz4AVUrWfaySLWbPnGyutNSqtWDn/Ja/IOl9u8+I5hnTIS4vEfNe1x
         XrA6ZHc/kQlN+JwyzqUkaDpP7VR5nDuQUf30tLThia+5H7J8443cz/PBWDBjZokZpG
         YRAkndLf8pPWg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 1/7] RDMA/mlx5: Merge similar flows of allocating MR from the cache
Date:   Thu, 30 Dec 2021 13:23:18 +0200
Message-Id: <b35e219a9895101459862bf0e6430d8cdc7622dc.1640862842.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640862842.git.leonro@nvidia.com>
References: <cover.1640862842.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

When allocating an MR from the cache, the driver calls to
get_cache_mr(), and in case of failure, retries with create_cache_mr().
This is the flow of mlx5_mr_cache_alloc(), so use it instead.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  3 +-
 drivers/infiniband/hw/mlx5/mr.c      | 51 +++++-----------------------
 drivers/infiniband/hw/mlx5/odp.c     | 11 ++++--
 3 files changed, 19 insertions(+), 46 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 48eda21a358f..9c3cf6f26ad1 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1344,7 +1344,8 @@ int mlx5_mr_cache_init(struct mlx5_ib_dev *dev);
 int mlx5_mr_cache_cleanup(struct mlx5_ib_dev *dev);
 
 struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
-				       unsigned int entry, int access_flags);
+				       struct mlx5_cache_ent *ent,
+				       int access_flags);
 
 int mlx5_ib_check_mr_status(struct ib_mr *ibmr, u32 check_mask,
 			    struct ib_mr_status *mr_status);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 157d862fb864..2cba55bb7825 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -566,25 +566,22 @@ static void cache_work_func(struct work_struct *work)
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
+		if (ent->limit) {
+			queue_adjust_cache_locked(ent);
+			ent->miss++;
+		}
 		spin_unlock_irq(&ent->lock);
 		mr = create_cache_mr(ent);
 		if (IS_ERR(mr))
@@ -598,32 +595,9 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 
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
@@ -959,16 +933,9 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
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
index 91eb615b89ee..0972afc3e952 100644
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
2.33.1

