Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE09722392
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jun 2023 12:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjFEKeA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 06:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjFEKd7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 06:33:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DB7122
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 03:33:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 269C3615D7
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 10:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17874C433EF;
        Mon,  5 Jun 2023 10:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685961230;
        bh=QVUDK/aRoQ7jFxhURfJyIlysyNbdKu1oCPBu1IjHqGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gM1CubwMBs3piNgGWod006B626JQLcipSssakZdEtA2EJ5Bx+LyioVPn4y06EI+BF
         cbhNCpWM2TM01dU7mNZ8wSR9txYKbqVeVrMWiUbOqmR/1vX3KJz8SYRfbr0ZQ+31+V
         R0QKgKP5roJEiJGtVezqxd7STPo2iw+zwuEHPvBgrN1Mej2sfxpY6a2cNwljXzAvJ6
         wssmoS4SRx8UM0vs4Enwtv1LiIqPudBWR+EVaWMMsV1gwBEUA2RqdTT/EZQesdwjDS
         tZL3kW2Ym0LTleETIlGzl2BYSNOPvbidQvFZG/ti899G4T3pl2LF8AuYRyI92/Jo1s
         +0gvK6rohGTpg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Michael Guralnik <michaelgur@nvidia.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-rc 06/10] RDMA/mlx5: Fix mkey cache possible deadlock on cleanup
Date:   Mon,  5 Jun 2023 13:33:22 +0300
Message-Id: <babba5ce5a995ced9ea35133dbc938d2a19510d2.1685960567.git.leon@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685960567.git.leon@kernel.org>
References: <cover.1685960567.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Michael Guralnik <michaelgur@nvidia.com>

Move cancellation of delayed cache work that adds or removes mkeys to the
a separate iteration in the mkey cleanup so that we don't call
someone_adding() while holding the rb_lock.

Lockdep:
WARNING: possible circular locking dependency detected
 6.2.0-rc6_for_upstream_debug_2023_01_31_14_02 #1 Not tainted
 ------------------------------------------------------
 devlink/53872 is trying to acquire lock:
 ffff888124f8c0c8 ((work_completion)(&(&ent->dwork)->work)){+.+.}-{0:0}, at: __flush_work+0xc8/0x900

 but task is already holding lock:
 ffff88817e8f1260 (&dev->cache.rb_lock){+.+.}-{3:3}, at: mlx5_mkey_cache_cleanup+0x77/0x250 [mlx5_ib]

 which lock already depends on the new lock.


 the existing dependency chain (in reverse order) is:

 -> #1 (&dev->cache.rb_lock){+.+.}-{3:3}:
        __mutex_lock+0x14c/0x15c0
        delayed_cache_work_func+0x2d1/0x610 [mlx5_ib]
        process_one_work+0x7c2/0x1310
        worker_thread+0x59d/0xec0
        kthread+0x28f/0x330
        ret_from_fork+0x1f/0x30

 -> #0 ((work_completion)(&(&ent->dwork)->work)){+.+.}-{0:0}:
        __lock_acquire+0x2d8a/0x5fe0
        lock_acquire+0x1c1/0x540
        __flush_work+0xe8/0x900
        __cancel_work_timer+0x2c7/0x3f0
        mlx5_mkey_cache_cleanup+0xfb/0x250 [mlx5_ib]
        mlx5_ib_stage_pre_ib_reg_umr_cleanup+0x16/0x30 [mlx5_ib]
        __mlx5_ib_remove+0x68/0x120 [mlx5_ib]
        mlx5r_remove+0x63/0x80 [mlx5_ib]
        auxiliary_bus_remove+0x52/0x70
        device_release_driver_internal+0x3c1/0x600
        bus_remove_device+0x2a5/0x560
        device_del+0x492/0xb80
        mlx5_detach_device+0x1a9/0x360 [mlx5_core]
        mlx5_unload_one_devl_locked+0x5a/0x110 [mlx5_core]
        mlx5_devlink_reload_down+0x292/0x580 [mlx5_core]
        devlink_reload+0x439/0x590
        devlink_nl_cmd_reload+0xaef/0xff0
        genl_family_rcv_msg_doit.isra.0+0x1bd/0x290
        genl_rcv_msg+0x3ca/0x6c0
        netlink_rcv_skb+0x12c/0x360
        genl_rcv+0x24/0x40
        netlink_unicast+0x438/0x710
        netlink_sendmsg+0x7a1/0xca0
        sock_sendmsg+0xc5/0x190
        __sys_sendto+0x1bc/0x290
        __x64_sys_sendto+0xdc/0x1b0
        do_syscall_64+0x3d/0x90
        entry_SYSCALL_64_after_hwframe+0x46/0xb0

 other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&dev->cache.rb_lock);
                                lock((work_completion)(&(&ent->dwork)->work));
                                lock(&dev->cache.rb_lock);
   lock((work_completion)(&(&ent->dwork)->work));

  *** DEADLOCK ***

 6 locks held by devlink/53872:
  #0: ffffffff84c17a50 (cb_lock){++++}-{3:3}, at: genl_rcv+0x15/0x40
  #1: ffff888142280218 (&devlink->lock_key){+.+.}-{3:3}, at: devlink_get_from_attrs_lock+0x12d/0x2d0
  #2: ffff8881422d3c38 (&dev->lock_key){+.+.}-{3:3}, at: mlx5_unload_one_devl_locked+0x4a/0x110 [mlx5_core]
  #3: ffffffffa0e59068 (mlx5_intf_mutex){+.+.}-{3:3}, at: mlx5_detach_device+0x60/0x360 [mlx5_core]
  #4: ffff88810e3cb0e8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0x8d/0x600
  #5: ffff88817e8f1260 (&dev->cache.rb_lock){+.+.}-{3:3}, at: mlx5_mkey_cache_cleanup+0x77/0x250 [mlx5_ib]

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 1ce48e485c5b..f113656e4027 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1033,7 +1033,15 @@ void mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
 		xa_lock_irq(&ent->mkeys);
 		ent->disabled = true;
 		xa_unlock_irq(&ent->mkeys);
-		cancel_delayed_work_sync(&ent->dwork);
+	}
+
+	/* Run the canceling of delayed works on the cache in a separate loop after
+	 * disabling all entries to ensure someone_adding() will not try taking the
+	 * rb_lock while flushing the workqueue.
+	 */
+	for (node = rb_first(root); node; node = rb_next(node)) {
+		ent = rb_entry(node, struct mlx5_cache_ent, node);
+		cancel_delayed_work(&ent->dwork);
 	}
 
 	mlx5_mkey_cache_debugfs_cleanup(dev);
-- 
2.40.1

