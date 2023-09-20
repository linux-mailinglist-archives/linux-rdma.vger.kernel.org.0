Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968A77A7822
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 11:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbjITJ4i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 05:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbjITJ4d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 05:56:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF91D9
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 02:56:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1396C433C8;
        Wed, 20 Sep 2023 09:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695203784;
        bh=GC8ZsRMTlbL2ry+qNVjPAasSA55vbYFUHYGpr4QLDYw=;
        h=From:To:Cc:Subject:Date:From;
        b=pfXD6C4mcr4mzyWifNkv/1Qeji+Vj7N+SC6d7b7OSi5uuXY6WVpWh2fFLjMa5eWa9
         aZAPO+X5nO+2+JKUKeyTsI7ODbQBUGcAEY7AtGWZU/Yv4dwvs0ayUVHtoXaz80rLx+
         PqfrYWIDpHhY4Cp/1VAeyPMOSaHRjAvn0FBWLLjj7l9+MzOi4w8tqiT+ts0wY5FX3r
         gDhA1V8RRuGxCi4ZnjJm09C3XmLuTOOVlaX2BDW9M+eCoeBi2rCX8/0jeyyD68TKh6
         zoAkOcptNH/eq+8HtWjWbe7Lz3Jwp8H2rnFD5rGmXeXhT7OytIdCZ98KmwtXm42zCV
         Qz2h65ud5Ss3g==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shay Drory <shayd@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Fix mkey cache possible deadlock on cleanup
Date:   Wed, 20 Sep 2023 12:56:18 +0300
Message-ID: <2c0452d944a865b060709af71940dafc4aad8b89.1695203715.git.leon@kernel.org>
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

From: Shay Drory <shayd@nvidia.com>

Fix the deadlock by refactoring the MR cache cleanup flow to flush the
workqueue without holding the rb_lock.
This adds a race between cache cleanup and creation of new entries which
we solve by denied creation of new entries after cache cleanup started.

Lockdep:
WARNING: possible circular locking dependency detected
 [ 2785.326074 ] 6.2.0-rc6_for_upstream_debug_2023_01_31_14_02 #1 Not tainted
 [ 2785.339778 ] ------------------------------------------------------
 [ 2785.340848 ] devlink/53872 is trying to acquire lock:
 [ 2785.341701 ] ffff888124f8c0c8 ((work_completion)(&(&ent->dwork)->work)){+.+.}-{0:0}, at: __flush_work+0xc8/0x900
 [ 2785.343403 ]
 [ 2785.343403 ] but task is already holding lock:
 [ 2785.344464 ] ffff88817e8f1260 (&dev->cache.rb_lock){+.+.}-{3:3}, at: mlx5_mkey_cache_cleanup+0x77/0x250 [mlx5_ib]
 [ 2785.346273 ]
 [ 2785.346273 ] which lock already depends on the new lock.
 [ 2785.346273 ]
 [ 2785.347720 ]
 [ 2785.347720 ] the existing dependency chain (in reverse order) is:
 [ 2785.349003 ]
 [ 2785.349003 ] -> #1 (&dev->cache.rb_lock){+.+.}-{3:3}:
 [ 2785.350160 ]        __mutex_lock+0x14c/0x15c0
 [ 2785.350962 ]        delayed_cache_work_func+0x2d1/0x610 [mlx5_ib]
 [ 2785.352044 ]        process_one_work+0x7c2/0x1310
 [ 2785.352879 ]        worker_thread+0x59d/0xec0
 [ 2785.353636 ]        kthread+0x28f/0x330
 [ 2785.354370 ]        ret_from_fork+0x1f/0x30
 [ 2785.355135 ]
 [ 2785.355135 ] -> #0 ((work_completion)(&(&ent->dwork)->work)){+.+.}-{0:0}:
 [ 2785.356515 ]        __lock_acquire+0x2d8a/0x5fe0
 [ 2785.357349 ]        lock_acquire+0x1c1/0x540
 [ 2785.358121 ]        __flush_work+0xe8/0x900
 [ 2785.358852 ]        __cancel_work_timer+0x2c7/0x3f0
 [ 2785.359711 ]        mlx5_mkey_cache_cleanup+0xfb/0x250 [mlx5_ib]
 [ 2785.360781 ]        mlx5_ib_stage_pre_ib_reg_umr_cleanup+0x16/0x30 [mlx5_ib]
 [ 2785.361969 ]        __mlx5_ib_remove+0x68/0x120 [mlx5_ib]
 [ 2785.362960 ]        mlx5r_remove+0x63/0x80 [mlx5_ib]
 [ 2785.363870 ]        auxiliary_bus_remove+0x52/0x70
 [ 2785.364715 ]        device_release_driver_internal+0x3c1/0x600
 [ 2785.365695 ]        bus_remove_device+0x2a5/0x560
 [ 2785.366525 ]        device_del+0x492/0xb80
 [ 2785.367276 ]        mlx5_detach_device+0x1a9/0x360 [mlx5_core]
 [ 2785.368615 ]        mlx5_unload_one_devl_locked+0x5a/0x110 [mlx5_core]
 [ 2785.369934 ]        mlx5_devlink_reload_down+0x292/0x580 [mlx5_core]
 [ 2785.371292 ]        devlink_reload+0x439/0x590
 [ 2785.372075 ]        devlink_nl_cmd_reload+0xaef/0xff0
 [ 2785.372973 ]        genl_family_rcv_msg_doit.isra.0+0x1bd/0x290
 [ 2785.374011 ]        genl_rcv_msg+0x3ca/0x6c0
 [ 2785.374798 ]        netlink_rcv_skb+0x12c/0x360
 [ 2785.375612 ]        genl_rcv+0x24/0x40
 [ 2785.376295 ]        netlink_unicast+0x438/0x710
 [ 2785.377121 ]        netlink_sendmsg+0x7a1/0xca0
 [ 2785.377926 ]        sock_sendmsg+0xc5/0x190
 [ 2785.378668 ]        __sys_sendto+0x1bc/0x290
 [ 2785.379440 ]        __x64_sys_sendto+0xdc/0x1b0
 [ 2785.380255 ]        do_syscall_64+0x3d/0x90
 [ 2785.381031 ]        entry_SYSCALL_64_after_hwframe+0x46/0xb0
 [ 2785.381967 ]
 [ 2785.381967 ] other info that might help us debug this:
 [ 2785.381967 ]
 [ 2785.383448 ]  Possible unsafe locking scenario:
 [ 2785.383448 ]
 [ 2785.384544 ]        CPU0                    CPU1
 [ 2785.385383 ]        ----                    ----
 [ 2785.386193 ]   lock(&dev->cache.rb_lock);
 [ 2785.386940 ]				lock((work_completion)(&(&ent->dwork)->work));
 [ 2785.388327 ]				lock(&dev->cache.rb_lock);
 [ 2785.389425 ]   lock((work_completion)(&(&ent->dwork)->work));
 [ 2785.390414 ]
 [ 2785.390414 ]  *** DEADLOCK ***
 [ 2785.390414 ]
 [ 2785.391579 ] 6 locks held by devlink/53872:
 [ 2785.392341 ]  #0: ffffffff84c17a50 (cb_lock){++++}-{3:3}, at: genl_rcv+0x15/0x40
 [ 2785.393630 ]  #1: ffff888142280218 (&devlink->lock_key){+.+.}-{3:3}, at: devlink_get_from_attrs_lock+0x12d/0x2d0
 [ 2785.395324 ]  #2: ffff8881422d3c38 (&dev->lock_key){+.+.}-{3:3}, at: mlx5_unload_one_devl_locked+0x4a/0x110 [mlx5_core]
 [ 2785.397322 ]  #3: ffffffffa0e59068 (mlx5_intf_mutex){+.+.}-{3:3}, at: mlx5_detach_device+0x60/0x360 [mlx5_core]
 [ 2785.399231 ]  #4: ffff88810e3cb0e8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0x8d/0x600
 [ 2785.400864 ]  #5: ffff88817e8f1260 (&dev->cache.rb_lock){+.+.}-{3:3}, at: mlx5_mkey_cache_cleanup+0x77/0x250 [mlx5_ib]

Fixes: b95845178328 ("RDMA/mlx5: Change the cache structure to an RB-tree")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
 drivers/infiniband/hw/mlx5/mr.c      | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 261c86fe6433..0f3a227fd378 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -811,6 +811,7 @@ struct mlx5_mkey_cache {
 	struct dentry		*fs_root;
 	unsigned long		last_add;
 	struct delayed_work	remove_ent_dwork;
+	u8			disable: 1;
 };
 
 struct mlx5_ib_port_resources {
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index b0fa2d644973..5d3cc225be29 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -998,19 +998,27 @@ void mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
 	if (!dev->cache.wq)
 		return;
 
-	cancel_delayed_work_sync(&dev->cache.remove_ent_dwork);
 	mutex_lock(&dev->cache.rb_lock);
+	dev->cache.disable = true;
 	for (node = rb_first(root); node; node = rb_next(node)) {
 		ent = rb_entry(node, struct mlx5_cache_ent, node);
 		spin_lock_irq(&ent->mkeys_queue.lock);
 		ent->disabled = true;
 		spin_unlock_irq(&ent->mkeys_queue.lock);
-		cancel_delayed_work_sync(&ent->dwork);
 	}
+	mutex_unlock(&dev->cache.rb_lock);
+
+	/*
+	 * After all entries are disabled and will not reschedule on WQ,
+	 * flush it and all async commands.
+	 */
+	flush_workqueue(dev->cache.wq);
 
 	mlx5_mkey_cache_debugfs_cleanup(dev);
 	mlx5_cmd_cleanup_async_ctx(&dev->async_ctx);
 
+	/* At this point all entries are disabled and have no concurrent work. */
+	mutex_lock(&dev->cache.rb_lock);
 	node = rb_first(root);
 	while (node) {
 		ent = rb_entry(node, struct mlx5_cache_ent, node);
@@ -1796,6 +1804,10 @@ static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
 	}
 
 	mutex_lock(&cache->rb_lock);
+	if (cache->disable) {
+		mutex_unlock(&cache->rb_lock);
+		return 0;
+	}
 	ent = mkey_cache_ent_from_rb_key(dev, mr->mmkey.rb_key);
 	if (ent) {
 		if (ent->rb_key.ndescs == mr->mmkey.rb_key.ndescs) {
-- 
2.41.0

