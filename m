Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BCB4B75F6
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbiBORz4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 12:55:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242756AbiBORzz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 12:55:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FADEFEB34;
        Tue, 15 Feb 2022 09:55:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A425E6162D;
        Tue, 15 Feb 2022 17:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDD0C340EB;
        Tue, 15 Feb 2022 17:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644947744;
        bh=QyV7kFKKmd0PI+vsDi5l34CgtVCqlawfJZ2+4/CwQCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RNoHIdk+vlykC7yuziJRGAZm3YVRSKx2Y8IeGOl/auKCUhFbjImG854zSweX6ljUl
         aodKHY9AVj2rv7zeP864copQ3pnfHXjQAodCak/kC+//oZwMsoqIFvynPZ4G/H2SbQ
         v/w6pLQexGcjKpYcLr4UX5QVzlRWptRLm6glVP4MKJqEpI0iE7R9+tVY1gNsmIj4Rz
         bSdoAXOYNsTQW4r5vKG4Gb7em1xxG1m7EHTNDMdxctCh5CKQoX4M+Dt+oEy/2zE+zX
         hiUDg3zK/BRcmdQNNq33XBo/Zvw0bGU66DfU0EkshdJ1wofulLOGcW6C8yaQG5QFR3
         4J8+xrEAgDhtw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 1/5] RDMA/mlx5: Remove redundant work in struct mlx5_cache_ent
Date:   Tue, 15 Feb 2022 19:55:29 +0200
Message-Id: <18b6ae205e75f087aa4a2a05c81ea8b66d8d88dc.1644947594.git.leonro@nvidia.com>
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

delayed_cache_work_func() and the cache_work_func() are both wrappers of
__cache_work_func(). Instead of having a special not delayed work, use
the delayed work with delay = 0.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 -
 drivers/infiniband/hw/mlx5/mr.c      | 16 +++-------------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index af68bce056a7..bacb6900b39f 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -788,7 +788,6 @@ struct mlx5_cache_ent {
 	u32                     miss;
 
 	struct mlx5_ib_dev     *dev;
-	struct work_struct	work;
 	struct delayed_work	dwork;
 };
 
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 157d862fb864..cd14d1b9dc1d 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -465,14 +465,14 @@ static void queue_adjust_cache_locked(struct mlx5_cache_ent *ent)
 		return;
 	if (ent->available_mrs < ent->limit) {
 		ent->fill_to_high_water = true;
-		queue_work(ent->dev->cache.wq, &ent->work);
+		mod_delayed_work(ent->dev->cache.wq, &ent->dwork, 0);
 	} else if (ent->fill_to_high_water &&
 		   ent->available_mrs + ent->pending < 2 * ent->limit) {
 		/*
 		 * Once we start populating due to hitting a low water mark
 		 * continue until we pass the high water mark.
 		 */
-		queue_work(ent->dev->cache.wq, &ent->work);
+		mod_delayed_work(ent->dev->cache.wq, &ent->dwork, 0);
 	} else if (ent->available_mrs == 2 * ent->limit) {
 		ent->fill_to_high_water = false;
 	} else if (ent->available_mrs > 2 * ent->limit) {
@@ -482,7 +482,7 @@ static void queue_adjust_cache_locked(struct mlx5_cache_ent *ent)
 			queue_delayed_work(ent->dev->cache.wq, &ent->dwork,
 					   msecs_to_jiffies(1000));
 		else
-			queue_work(ent->dev->cache.wq, &ent->work);
+			mod_delayed_work(ent->dev->cache.wq, &ent->dwork, 0);
 	}
 }
 
@@ -558,14 +558,6 @@ static void delayed_cache_work_func(struct work_struct *work)
 	__cache_work_func(ent);
 }
 
-static void cache_work_func(struct work_struct *work)
-{
-	struct mlx5_cache_ent *ent;
-
-	ent = container_of(work, struct mlx5_cache_ent, work);
-	__cache_work_func(ent);
-}
-
 /* Allocate a special entry from the cache */
 struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 				       unsigned int entry, int access_flags)
@@ -726,7 +718,6 @@ int mlx5_mr_cache_init(struct mlx5_ib_dev *dev)
 		ent->dev = dev;
 		ent->limit = 0;
 
-		INIT_WORK(&ent->work, cache_work_func);
 		INIT_DELAYED_WORK(&ent->dwork, delayed_cache_work_func);
 
 		if (i > MR_CACHE_LAST_STD_ENTRY) {
@@ -770,7 +761,6 @@ int mlx5_mr_cache_cleanup(struct mlx5_ib_dev *dev)
 		spin_lock_irq(&ent->lock);
 		ent->disabled = true;
 		spin_unlock_irq(&ent->lock);
-		cancel_work_sync(&ent->work);
 		cancel_delayed_work_sync(&ent->dwork);
 	}
 
-- 
2.35.1

