Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2920C3B52D3
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Jun 2021 12:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhF0KeC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Jun 2021 06:34:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229761AbhF0KeA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Jun 2021 06:34:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40AB261C2F;
        Sun, 27 Jun 2021 10:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624789896;
        bh=Yg3PEQXj/hhg8wzzZw7LQErrjnCH+JFghREWauYEEJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l/xrrFhYet5iQJWymEv9kX+EgkYIDDRXHGJWLZDpRkr4hepnleinLv8KjGtx/OPyX
         haIR3V4OWrGuaYfNuCVrbaeibxLlUZ8NkoZjl3q2lTzlr9V0xIQcMl43vjNBf8+PIM
         MAg5QzB30ALK2B5Jkh6X1990Ea1ZvvHr2CnLDWx+ghOQPbttJWhOq6CmujoDWMRNyS
         mVZcKN3f9xcXJ61fMkuUuhpNdW1rs2lLRqtkrwXNT+a3wCe5omxsM9laWdvROvip6U
         B37A8PGrofYb09fBe/H47HVf28YHBQK79LSOWSRKk2DH4aXe81qo0pTfKsb2je64Ty
         dYSizO+/h3kOQ==
Date:   Sun, 27 Jun 2021 13:31:32 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Anand Khoje <anand.a.khoje@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com
Subject: Re: [PATCH v6 for-next 0/2] IB/core: Obtaining subnet_prefix from
 cache in
Message-ID: <YNhThN0tiA5v5Q4v@unreal>
References: <20210627064753.1012-1-anand.a.khoje@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210627064753.1012-1-anand.a.khoje@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 27, 2021 at 12:17:51PM +0530, Anand Khoje wrote:
> This v6 patch series is used to read the port_attribute subnet_prefix
> from a valid cache entry instead of having to call
> device->ops.query_gid() for Infiniband link-layer devices in
> __ib_query_port().
> 
> In the event of a cache update, the value for subnet_prefix gets read
> using device->ops.query_gid() in config_non_roce_gid_cache().
> 
> Anand Khoje (2):
>   IB/core: Updating cache for subnet_prefix in
>     config_non_roce_gid_cache()
>   IB/core: Read subnet_prefix in ib_query_port via cache.

This series breaks mlx4/mlx5. You forgot to call to lock_init or
something like that.

 [   18.231107] INFO: trying to register non-static key.
 [   18.232775] The code is fine but needs lockdep annotation, or maybe
 [   18.247970] you didn't initialize this object before use?
 [   18.249458] turning off the locking correctness validator.
 [   18.250867] CPU: 6 PID: 333 Comm: systemd-udevd Not tainted 5.13.0-rc7_2021_06_27_07_56_03_ #1
 [   18.253147] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 [   18.255850] Call Trace:
 [   18.256649]  dump_stack+0xa5/0xe6
 [   18.257625]  register_lock_class+0x159a/0x1990
 [   18.258848]  ? really_probe+0x217/0xd70
 [   18.260017]  ? driver_probe_device+0x111/0x3c0
 [   18.261322]  ? device_driver_attach+0x209/0x270
 [   18.261330]  ? __driver_attach+0x133/0x280
 [[0;32m  OK  [0m] Started [0;[   18.261334]  ? bus_for_each_dev+0x11e/0x1a0
 1;39mNetwork Manager Script Dispatcher Service[[   18.261338]  ? bus_add_driver+0x309/0x580
 0m.
 [   18.261347]  ? is_dynamic_key+0x1d0/0x1d0
 [   18.261353]  ? do_init_module+0x1c8/0x780
 [   18.261360]  ? load_module+0x7131/0x9a50
 [   18.261364]  ? __do_sys_finit_module+0x118/0x1b0
 [   18.261371]  ? do_syscall_64+0x3f/0x80
 [   18.261377]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
 [   18.261384]  ? check_chain_key+0x229/0x5b0
 [   18.261389]  __lock_acquire+0x10a/0x5fe0
 [   18.261396]  ? register_lock_class+0x1990/0x1990
 [   18.261400]  ? kasan_quarantine_put+0xd1/0x1f0
 [   18.261405]  ? trace_hardirqs_on+0x32/0x120
 [   18.261413]  lock_acquire+0x1b1/0x700
 [   18.261419]  ? ib_get_cached_subnet_prefix+0x28/0xd0 [ib_core]
 [   18.283989]  ? lockdep_hardirqs_on_prepare+0x400/0x400
 [   18.285397]  ? mlx5_ib_query_port+0x982/0x12b0 [mlx5_ib]
 [   18.286861]  ? __kasan_kmalloc+0x7c/0x90
 [   18.287939]  ? alloc_port_data.part.0+0xa6/0x380 [ib_core]
 [   18.289408]  ? mlx5_ib_rep_query_port+0x10/0x10 [mlx5_ib]
 [   18.290861]  ? auxiliary_bus_probe+0x9d/0xe0
 [   18.292016]  ? really_probe+0x217/0xd70
 [   18.293113]  ? driver_probe_device+0x111/0x3c0
 [   18.294311]  ? device_driver_attach+0x1f4/0x270
 [   18.295588]  ? __driver_attach+0x133/0x280
 [   18.296772]  _raw_read_lock_irqsave+0x72/0x90
 [   18.297965]  ? ib_get_cached_subnet_prefix+0x28/0xd0 [ib_core]
 [   18.299564]  ib_get_cached_subnet_prefix+0x28/0xd0 [ib_core]
 [   18.301150]  ib_query_port+0x388/0x6c0 [ib_core]
 [   18.303752]  mlx5_port_immutable+0x3bf/0x4b0 [mlx5_ib]
 [   18.305691]  ? mlx5_ib_stage_caps_init+0xa90/0xa90 [mlx5_ib]
 [   18.307757]  ? rcu_read_lock_sched_held+0x3f/0x70
 [   18.309543]  ? is_module_address+0x25/0x40
 [   18.311093]  ? static_obj+0x8a/0xc0
 [   18.312496]  ? alloc_port_data.part.0+0x1e6/0x380 [ib_core]
 [   18.314642]  ib_register_device+0x36f/0x950 [ib_core]
 [   18.316585]  ? enable_device_and_get+0x340/0x340 [ib_core]
 [   18.318701]  ? do_raw_spin_unlock+0x54/0x220
 [   18.320373]  ? _raw_spin_unlock+0x1f/0x30
 [   18.321971]  __mlx5_ib_add+0x6c/0x140 [mlx5_ib]
 [   18.323737]  mlx5r_probe+0x1f5/0x380 [mlx5_ib]
 [   18.325495]  ? kernfs_add_one+0x2a3/0x400
 [   18.327085]  ? __mlx5_ib_add+0x140/0x140 [mlx5_ib]
 [   18.329009]  ? kernfs_create_link+0x16c/0x230
 [   18.330682]  ? auxiliary_match_id+0xe9/0x140
 [   18.332352]  ? __mlx5_ib_add+0x140/0x140 [mlx5_ib]
 [   18.334359]  auxiliary_bus_probe+0x9d/0xe0
 [   18.336398]  really_probe+0x217/0xd70
 [   18.338001]  driver_probe_device+0x111/0x3c0
 [   18.339659]  device_driver_attach+0x209/0x270
 [   18.341368]  __driver_attach+0x133/0x280
 [   18.342892]  ? device_driver_attach+0x270/0x270
 [   18.344651]  bus_for_each_dev+0x11e/0x1a0
 [   18.346237]  ? lockdep_init_map_type+0x2c3/0x790
 [   18.348016]  ? subsys_dev_iter_exit+0x10/0x10
 [   18.349682]  bus_add_driver+0x309/0x580
 [   18.351374]  driver_register+0x1ee/0x380
 [   18.353003]  mlx5_ib_init+0x100/0x15f [mlx5_ib]
 [   18.354745]  ? 0xffffffffa07c0000
 [   18.356096]  do_one_initcall+0xd5/0x430
 [   18.357618]  ? trace_event_raw_event_initcall_finish+0x1c0/0x1c0
 [   18.359808]  ? rcu_read_lock_sched_held+0x3f/0x70
 [   18.361638]  ? kasan_unpoison+0x23/0x50
 [   18.363124]  do_init_module+0x1c8/0x780
 [   18.364659]  load_module+0x7131/0x9a50
 [   18.366166]  ? module_frob_arch_sections+0x20/0x20
 [   18.368037]  ? lock_downgrade+0x6e0/0x6e0
 [   18.369645]  ? kernel_read_file+0x284/0x6a0
 [   18.371279]  ? __x64_sys_fsconfig+0x980/0x980
 [   18.373007]  ? kernel_read_file_from_fd+0x4b/0x90
 [   18.374769]  __do_sys_finit_module+0x118/0x1b0
 [   18.376506]  ? __do_sys_init_module+0x250/0x250
 [   18.378234]  ? seccomp_do_user_notification.constprop.0+0xb30/0xb30
 [   18.380549]  do_syscall_64+0x3f/0x80
 [   18.382002]  entry_SYSCALL_64_after_hwframe+0x44/0xae
 [   18.383968] RIP: 0033:0x7f52e7cac13d
 [   18.385444] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2b 6d 0c 00 f7 d8 64 89 01 48
 [   18.392025] RSP: 002b:00007fff8a5ab448 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
 [   18.394893] RAX: ffffffffffffffda RBX: 0000563420129ce0 RCX: 00007f52e7cac13d
 [   18.397513] RDX: 0000000000000000 RSI: 00007f52e790995d RDI: 000000000000000f
 [   18.400106] RBP: 0000000000020000 R08: 0000000000000000 R09: 00005634200e5f10
 [   18.402670] R10: 000000000000000f R11: 0000000000000246 R12: 0000000000000000
 [   18.405185] R13: 00007f52e790995d R14: 00005634201261c0 R15: 00005634201245f0




> ---
> v1 -> v2:
>     -   Split the v1 patch in 3 patches as per Leon's suggestion.
> 
> v2 -> v3:
>     -   Added changes as per Mark Zhang's suggestion of clearing
>         flags in git_table_cleanup_one().
> v3 -> v4:
>     -   Removed the enum ib_port_data_flags and 8 byte flags from
>         struct ib_port_data, and the set_bit()/clear_bit() API
>         used to update this flag as that was not necessary.
>         Done to keep the code simple.
>     -   Added code to read subnet_prefix from updated GID cache in the
>         event of cache update. Prior to this change, ib_cache_update
>         was reading the value for subnet_prefix via ib_query_port(),
>         due to this patch, we ended up reading a stale cached value of
>         subnet_prefix.
> v4 -> v5:
>     -   Removed the code to reset cache_is_initialised bit from cleanup
>         as per Leon's suggestion.
>     -   Removed ib_cache_is_initialised() function.
> 
> v5 -> v6:
>     -   Added changes as per Jason's suggestion of updating subnet_prefix
> 	in config_non_roce_gid_cache() and removing the flag
> 	cache_is_initialized in __ib_query_port().
> ---
> 
>  drivers/infiniband/core/cache.c  | 8 +++++---
>  drivers/infiniband/core/device.c | 7 ++-----
>  2 files changed, 7 insertions(+), 8 deletions(-)
> 
> -- 
> 1.8.3.1
> 
