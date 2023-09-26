Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650837AE95F
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 11:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbjIZJh5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 05:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbjIZJh4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 05:37:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0980101
        for <linux-rdma@vger.kernel.org>; Tue, 26 Sep 2023 02:37:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0ED0C433C7;
        Tue, 26 Sep 2023 09:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695721069;
        bh=VTAJ5Fafmv4CUVh49Np2Ot8fbhXr4PT8hPao63KVbP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WxDq04us5t5voPZEIynNNJieksz2jO3EBtVlxF7+Df8wCIPpfdkoxAeSCbQBYGnd8
         4Zr76YfTag/SMNowVgibx9+/gCQrXquB1mU9lBV+vClzYQbjFfmyHHWFWKB2R6g7EN
         Rji8kOA+XY8pTlvoXQOTbJhKulwGbcbu3EbnOYPcJFcr9H52bBNdRkR7JEpB1r7b5q
         D09STPEzamUVXu+UtDHiGLCMk9VHsF3Vwqwv20sp78vc24KuHLbCMpIqigyV43lRUm
         TGAltxwSVfvTAmagtsJZbiIt6/xdgN7wmVQh0fZyYX/7ZmB6OcawEA5eeUOBgs5+u+
         wuqeN11nXkE4w==
Date:   Tue, 26 Sep 2023 12:37:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shay Drory <shayd@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix mkey cache possible deadlock on
 cleanup
Message-ID: <20230926093745.GH1642130@unreal>
References: <2c0452d944a865b060709af71940dafc4aad8b89.1695203715.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c0452d944a865b060709af71940dafc4aad8b89.1695203715.git.leon@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 20, 2023 at 12:56:18PM +0300, Leon Romanovsky wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> Fix the deadlock by refactoring the MR cache cleanup flow to flush the
> workqueue without holding the rb_lock.
> This adds a race between cache cleanup and creation of new entries which
> we solve by denied creation of new entries after cache cleanup started.
> 
> Lockdep:
> WARNING: possible circular locking dependency detected
>  [ 2785.326074 ] 6.2.0-rc6_for_upstream_debug_2023_01_31_14_02 #1 Not tainted
>  [ 2785.339778 ] ------------------------------------------------------
>  [ 2785.340848 ] devlink/53872 is trying to acquire lock:
>  [ 2785.341701 ] ffff888124f8c0c8 ((work_completion)(&(&ent->dwork)->work)){+.+.}-{0:0}, at: __flush_work+0xc8/0x900
>  [ 2785.343403 ]
>  [ 2785.343403 ] but task is already holding lock:
>  [ 2785.344464 ] ffff88817e8f1260 (&dev->cache.rb_lock){+.+.}-{3:3}, at: mlx5_mkey_cache_cleanup+0x77/0x250 [mlx5_ib]
>  [ 2785.346273 ]
>  [ 2785.346273 ] which lock already depends on the new lock.
>  [ 2785.346273 ]
>  [ 2785.347720 ]
>  [ 2785.347720 ] the existing dependency chain (in reverse order) is:
>  [ 2785.349003 ]
>  [ 2785.349003 ] -> #1 (&dev->cache.rb_lock){+.+.}-{3:3}:
>  [ 2785.350160 ]        __mutex_lock+0x14c/0x15c0
>  [ 2785.350962 ]        delayed_cache_work_func+0x2d1/0x610 [mlx5_ib]
>  [ 2785.352044 ]        process_one_work+0x7c2/0x1310
>  [ 2785.352879 ]        worker_thread+0x59d/0xec0
>  [ 2785.353636 ]        kthread+0x28f/0x330
>  [ 2785.354370 ]        ret_from_fork+0x1f/0x30
>  [ 2785.355135 ]
>  [ 2785.355135 ] -> #0 ((work_completion)(&(&ent->dwork)->work)){+.+.}-{0:0}:
>  [ 2785.356515 ]        __lock_acquire+0x2d8a/0x5fe0
>  [ 2785.357349 ]        lock_acquire+0x1c1/0x540
>  [ 2785.358121 ]        __flush_work+0xe8/0x900
>  [ 2785.358852 ]        __cancel_work_timer+0x2c7/0x3f0
>  [ 2785.359711 ]        mlx5_mkey_cache_cleanup+0xfb/0x250 [mlx5_ib]
>  [ 2785.360781 ]        mlx5_ib_stage_pre_ib_reg_umr_cleanup+0x16/0x30 [mlx5_ib]
>  [ 2785.361969 ]        __mlx5_ib_remove+0x68/0x120 [mlx5_ib]
>  [ 2785.362960 ]        mlx5r_remove+0x63/0x80 [mlx5_ib]
>  [ 2785.363870 ]        auxiliary_bus_remove+0x52/0x70
>  [ 2785.364715 ]        device_release_driver_internal+0x3c1/0x600
>  [ 2785.365695 ]        bus_remove_device+0x2a5/0x560
>  [ 2785.366525 ]        device_del+0x492/0xb80
>  [ 2785.367276 ]        mlx5_detach_device+0x1a9/0x360 [mlx5_core]
>  [ 2785.368615 ]        mlx5_unload_one_devl_locked+0x5a/0x110 [mlx5_core]
>  [ 2785.369934 ]        mlx5_devlink_reload_down+0x292/0x580 [mlx5_core]
>  [ 2785.371292 ]        devlink_reload+0x439/0x590
>  [ 2785.372075 ]        devlink_nl_cmd_reload+0xaef/0xff0
>  [ 2785.372973 ]        genl_family_rcv_msg_doit.isra.0+0x1bd/0x290
>  [ 2785.374011 ]        genl_rcv_msg+0x3ca/0x6c0
>  [ 2785.374798 ]        netlink_rcv_skb+0x12c/0x360
>  [ 2785.375612 ]        genl_rcv+0x24/0x40
>  [ 2785.376295 ]        netlink_unicast+0x438/0x710
>  [ 2785.377121 ]        netlink_sendmsg+0x7a1/0xca0
>  [ 2785.377926 ]        sock_sendmsg+0xc5/0x190
>  [ 2785.378668 ]        __sys_sendto+0x1bc/0x290
>  [ 2785.379440 ]        __x64_sys_sendto+0xdc/0x1b0
>  [ 2785.380255 ]        do_syscall_64+0x3d/0x90
>  [ 2785.381031 ]        entry_SYSCALL_64_after_hwframe+0x46/0xb0
>  [ 2785.381967 ]
>  [ 2785.381967 ] other info that might help us debug this:
>  [ 2785.381967 ]
>  [ 2785.383448 ]  Possible unsafe locking scenario:
>  [ 2785.383448 ]
>  [ 2785.384544 ]        CPU0                    CPU1
>  [ 2785.385383 ]        ----                    ----
>  [ 2785.386193 ]   lock(&dev->cache.rb_lock);
>  [ 2785.386940 ]				lock((work_completion)(&(&ent->dwork)->work));
>  [ 2785.388327 ]				lock(&dev->cache.rb_lock);
>  [ 2785.389425 ]   lock((work_completion)(&(&ent->dwork)->work));
>  [ 2785.390414 ]
>  [ 2785.390414 ]  *** DEADLOCK ***
>  [ 2785.390414 ]
>  [ 2785.391579 ] 6 locks held by devlink/53872:
>  [ 2785.392341 ]  #0: ffffffff84c17a50 (cb_lock){++++}-{3:3}, at: genl_rcv+0x15/0x40
>  [ 2785.393630 ]  #1: ffff888142280218 (&devlink->lock_key){+.+.}-{3:3}, at: devlink_get_from_attrs_lock+0x12d/0x2d0
>  [ 2785.395324 ]  #2: ffff8881422d3c38 (&dev->lock_key){+.+.}-{3:3}, at: mlx5_unload_one_devl_locked+0x4a/0x110 [mlx5_core]
>  [ 2785.397322 ]  #3: ffffffffa0e59068 (mlx5_intf_mutex){+.+.}-{3:3}, at: mlx5_detach_device+0x60/0x360 [mlx5_core]
>  [ 2785.399231 ]  #4: ffff88810e3cb0e8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0x8d/0x600
>  [ 2785.400864 ]  #5: ffff88817e8f1260 (&dev->cache.rb_lock){+.+.}-{3:3}, at: mlx5_mkey_cache_cleanup+0x77/0x250 [mlx5_ib]
> 
> Fixes: b95845178328 ("RDMA/mlx5: Change the cache structure to an RB-tree")
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
>  drivers/infiniband/hw/mlx5/mr.c      | 16 ++++++++++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)

Applied
