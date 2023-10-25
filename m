Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DA87D72A7
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 19:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjJYRuQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 13:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbjJYRuQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 13:50:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A5B18B
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 10:50:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FC3C433C7;
        Wed, 25 Oct 2023 17:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698256213;
        bh=TB0PXzH1sZqVZOGmiKJwcBlC20b2JtKw3tOB1AHQagw=;
        h=From:To:Cc:Subject:Date:From;
        b=Zg6B/WeHocG4eNgInxFinXE4ZYN2me5SlZYAJqXKxzDdm26mPH2/IahWP475STFnJ
         kR3nx5AKjL9k/WPh1aO84YLVUfi0k4+MyqJjLd8++WENrYG1T2KZnGL9FjHA1T+wPg
         G+X1+lb+DoVzCz3wm3Mn/tp7By8bFvzU75DwUa1UX+d6GtCw3tXIEu+c+DZVobbShf
         1iTiU3XU26ckDhRMuRHkfaoQUiqnpoF4AeTAkhYBNa7/KpBcRmSM3fBlvkikvzbgrU
         EU4ii7MnOkby87rIjE3vdR2/HdSmQLIopYV16wCrl5qC9fT67ue8UI396ADCx846dU
         LAaU0hiLZW2Og==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Moshe Shemesh <moshe@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>,
        Shay Drory <shayd@nvidia.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Fix mkey cache WQ flush
Date:   Wed, 25 Oct 2023 20:49:59 +0300
Message-ID: <b8722f14e7ed81452f791764a26d2ed4cfa11478.1698256179.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
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

From: Moshe Shemesh <moshe@nvidia.com>

The cited patch tries to ensure no pending works on the mkey cache
workqueue by disabling adding new works and call flush_workqueue().
But this workqueue also has delayed works which might still be pending
the delay time to be queued.

Add cancel_delayed_work() for the delayed works which waits to be queued
and then the flush_workqueue() will flush all works which are already
queued and running.

Fixes: 374012b00457 ("RDMA/mlx5: Fix mkey cache possible deadlock on cleanup")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 8a3762d9ff58..e0629898c3c0 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1026,11 +1026,13 @@ void mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
 		return;
 
 	mutex_lock(&dev->cache.rb_lock);
+	cancel_delayed_work(&dev->cache.remove_ent_dwork);
 	for (node = rb_first(root); node; node = rb_next(node)) {
 		ent = rb_entry(node, struct mlx5_cache_ent, node);
 		xa_lock_irq(&ent->mkeys);
 		ent->disabled = true;
 		xa_unlock_irq(&ent->mkeys);
+		cancel_delayed_work(&ent->dwork);
 	}
 	mutex_unlock(&dev->cache.rb_lock);
 
-- 
2.41.0

