Return-Path: <linux-rdma+bounces-4702-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 804C596878A
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 14:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081A41F21115
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 12:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A8119C556;
	Mon,  2 Sep 2024 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkHGI45Z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EFB1849CB
	for <linux-rdma@vger.kernel.org>; Mon,  2 Sep 2024 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280189; cv=none; b=FAvtxdwBBF3ocWZz9YwJcXu+LpHUuCV3w/70ZrKV589PKrRebgNS8B7T7+GDO0XzYE1d9Ofe2nreQxn5300gDr/GHO1R8+1DTRjWCg+QvulyYFEpACdN+6pAG2o+OqLm04Yyw6cYS75iv5Dl5jvKNhJMVix4moS9C0tfESlZW5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280189; c=relaxed/simple;
	bh=NChDe0bNZrK+tXF8C8j78d6fkfdEtuTfH+iELTEp4Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUT0DQeL3VLxYtLtIn2cwt+8azq315LNOROPpWNj4M/9oda1ZQEkOnBZPlL7wGYu+hUBYahJiqtLklHX1TRgjH55qAbHIoIRZZ0TbaOBtJLYWliFw9rZQg0oeHUG+F7JKvCuYeJTHQxH1hdPVmuyl49+0xPc+R5kpSjvp9RXevU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkHGI45Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFF3C4CEC2;
	Mon,  2 Sep 2024 12:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725280188;
	bh=NChDe0bNZrK+tXF8C8j78d6fkfdEtuTfH+iELTEp4Vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RkHGI45ZAyEfCkeoB0kR44jWFwMqotb4YXkK47rMx1tTZSa1pllmGjAhQKbUQoyE4
	 Eu5UQil1bas402Cm5wBFzFxW3nsay5yLkf2kRlL+c0SPcm2xkaOo6qW9Sd3FOalvM3
	 DdRHEtYsGsIYpz1dVMMU9JjvD1z5j5BnJqxKWcFBGix62jw9mXwULS8TYR+wMR+QC4
	 7o2ByCiNYAALlYTgBXl2h2dQbs/QzAzlnzxMfEcxgURXu143tyNhNJ4vP+RqBc6EeR
	 Zfl5BhNu4jrkTFaR4TLEijGezlEH6KF8GLJ+5WPdk1VFEl/GVzK9tT3CpFglUZFwtU
	 DxUZXE0sUYncg==
Date: Mon, 2 Sep 2024 15:29:43 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Michael Guralnik <michaelgur@nvidia.com>, cmeiohas@nvidia.com,
	msanalla@nvidia.com
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, mbloch@nvidia.com
Subject: Re: [PATCH rdma-next v2 6/7] RDMA/nldev: Add support for RDMA
 monitoring
Message-ID: <20240902122943.GF4026@unreal>
References: <20240830073130.29982-1-michaelgur@nvidia.com>
 <20240830073130.29982-7-michaelgur@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830073130.29982-7-michaelgur@nvidia.com>

On Fri, Aug 30, 2024 at 10:31:29AM +0300, Michael Guralnik wrote:
> From: Chiara Meiohas <cmeiohas@nvidia.com>
> 
> Introduce a new netlink command to allow rdma event monitoring.
> The rdma events supported now are IB device
> registration/unregistration and net device attachment/detachment.
> 
> Example output of rdma monitor and the commands which trigger
> the events:
> 
> $ rdma monitor
> $ rmmod mlx5_ib
> [UNREGISTER]    dev 3
> [UNREGISTER]    dev 0
> 
> $modprobe mlx5_ib
> [REGISTER]      dev 4
> [NETDEV_ATTACH] dev 4 port 1 netdev 4
> [REGISTER]      dev 5
> [NETDEV_ATTACH] dev 5 port 1 netdev 5
> 
> $ devlink dev eswitch set pci/0000:08:00.0 mode switchdev
> [UNREGISTER]    dev 4
> [REGISTER]      dev 6
> [NETDEV_ATTACH] dev 6 port 6 netdev 4
> 
> $ echo 4 > /sys/class/net/eth2/device/sriov_numvfs
> [NETDEV_ATTACH] dev 6 port 2 netdev 7
> [NETDEV_ATTACH] dev 6 port 3 netdev 8
> [NETDEV_ATTACH] dev 6 port 4 netdev 9
> [NETDEV_ATTACH] dev 6 port 5 netdev 10
> [REGISTER]      dev 7
> [NETDEV_ATTACH] dev 7 port 1 netdev 11
> [REGISTER]      dev 8
> [NETDEV_ATTACH] dev 8 port 1 netdev 12
> [REGISTER]      dev 9
> [NETDEV_ATTACH] dev 9 port 1 netdev 13
> [REGISTER]      dev 10
> [NETDEV_ATTACH] dev 10 port 1 netdev 14
> 
> $ echo 0 > /sys/class/net/eth2/device/sriov_numvfs
> [UNREGISTER]    dev 7
> [UNREGISTER]    dev 8
> [UNREGISTER]    dev 9
> [UNREGISTER]    dev 10
> [NETDEV_DETACH] dev 6 port 2
> [NETDEV_DETACH] dev 6 port 3
> [NETDEV_DETACH] dev 6 port 4
> [NETDEV_DETACH] dev 6 port 5
> 
> Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
> Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/device.c  |  38 ++++++++++
>  drivers/infiniband/core/netlink.c |   1 +
>  drivers/infiniband/core/nldev.c   | 118 ++++++++++++++++++++++++++++++
>  include/rdma/rdma_netlink.h       |  12 +++
>  include/uapi/rdma/rdma_netlink.h  |  15 ++++
>  5 files changed, 184 insertions(+)

This patch breaks RXE and the following splat can be reproduced with
"sudo rdma link add rxe1 type rxe netdev eth1" command:

[   16.871877][  T344] rdma_rxe: loaded
[   17.057211][  T343] infiniband rxe1: set active
[   17.057493][  T343] infiniband rxe1: added eth1
[   17.080757][  T343]
[   17.080891][  T343] ======================================================
[   17.081170][  T343] WARNING: possible circular locking dependency detected
[   17.081465][  T343] 6.11.0-rc5+ #2367 Not tainted
[   17.081675][  T343] ------------------------------------------------------
[   17.081886][  T343] rdma/343 is trying to acquire lock:
[   17.082048][  T343] ffff88800ef6d188 (&rxe->usdev_lock){+.+.}-{3:3}, at: rxe_query_port+0x41/0x170 [rdma_rxe]
[   17.082385][  T343]
[   17.082385][  T343] but task is already holding lock:
[   17.082628][  T343] ffff88800ef6ce90 (&device->compat_devs_mutex){+.+.}-{3:3}, at: add_one_compat_dev+0xe4/0x6e0 [ib_core]
[   17.083002][  T343]
[   17.083002][  T343] which lock already depends on the new lock.
[   17.083002][  T343]
[   17.083302][  T343]
[   17.083302][  T343] the existing dependency chain (in reverse order) is:
[   17.083580][  T343]
[   17.083580][  T343] -> #3 (&device->compat_devs_mutex){+.+.}-{3:3}:
[   17.083866][  T343]        __mutex_lock+0x14a/0x1940
[   17.084038][  T343]        ib_device_rename+0x110/0x3b0 [ib_core]
[   17.084274][  T343]        nldev_set_doit+0x2ef/0x3d0 [ib_core]
[   17.084500][  T343]        rdma_nl_rcv_msg+0x2b0/0x4f0 [ib_core]
[   17.084715][  T343]        rdma_nl_rcv_skb.constprop.0.isra.0+0x238/0x390 [ib_core]
[   17.084981][  T343]        netlink_unicast+0x438/0x730
[   17.085194][  T343]        netlink_sendmsg+0x72a/0xbc0                                                                                                                                                                  15:20:28 [177/6052]
[   17.085438][  T343]        __sock_sendmsg+0xc5/0x190
[   17.085668][  T343]        ____sys_sendmsg+0x52e/0x6a0
[   17.085901][  T343]        ___sys_sendmsg+0xdf/0x150
[   17.086128][  T343]        __sys_sendmsg+0x161/0x1d0
[   17.086354][  T343]        do_syscall_64+0x6d/0x140
[   17.086584][  T343]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   17.086872][  T343]
[   17.086872][  T343] -> #2 (devices_rwsem){++++}-{3:3}:
[   17.087171][  T343]        down_read+0x96/0x450
[   17.087322][  T343]        ib_device_set_netdev.part.0+0x36b/0x640 [ib_core]
[   17.087554][  T343]        ib_device_set_netdev+0xb7/0xe0 [ib_core]
[   17.087749][  T343]        mlx5_netdev_event+0x428/0x990 [mlx5_ib]
[   17.087945][  T343]        call_netdevice_register_net_notifiers+0xdb/0x290
[   17.088113][  T343]        __register_netdevice_notifier_net+0x4b/0x70
[   17.088277][  T343]        register_netdevice_notifier_dev_net+0x53/0x160
[   17.088448][  T343]        mlx5e_mdev_notifier_event+0x8a/0xf0 [mlx5_ib]
[   17.088630][  T343]        notifier_call_chain+0x96/0x270
[   17.088773][  T343]        blocking_notifier_call_chain+0x60/0x80
[   17.088970][  T343]        mlx5_core_uplink_netdev_event_replay+0x4d/0x60 [mlx5_core]
[   17.089289][  T343]        mlx5_ib_roce_init+0x1f5/0x720 [mlx5_ib]
[   17.089509][  T343]        __mlx5_ib_add+0x6b/0x140 [mlx5_ib]
[   17.089727][  T343]        mlx5r_probe+0x24f/0x5d0 [mlx5_ib]
[   17.089951][  T343]        auxiliary_bus_probe+0x9d/0xe0
[   17.090112][  T343]        really_probe+0x1cf/0x8b0
[   17.090278][  T343]        __driver_probe_device+0x190/0x370
[   17.090464][  T343]        driver_probe_device+0x4a/0x120
[   17.090614][  T343]        __driver_attach+0x195/0x470                                                                                                                                                                  15:20:28 [150/6052]
[   17.090761][  T343]        bus_for_each_dev+0xf0/0x170
[   17.090928][  T343]        bus_add_driver+0x21d/0x4d0
[   17.091080][  T343]        driver_register+0x1a1/0x350
[   17.091238][  T343]        __auxiliary_driver_register+0x14e/0x230
[   17.091440][  T343]        cm_dev_release+0xb7/0x170 [ib_cm]
[   17.091657][  T343]        do_one_initcall+0xbf/0x390
[   17.091830][  T343]        do_init_module+0x22e/0x710
[   17.091987][  T343]        load_module+0x4e40/0x65a0
[   17.092142][  T343]        init_module_from_file+0xcf/0x120
[   17.092305][  T343]        idempotent_init_module+0x22d/0x720
[   17.092510][  T343]        __x64_sys_finit_module+0xc1/0x130
[   17.092703][  T343]        do_syscall_64+0x6d/0x140
[   17.092876][  T343]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   17.093091][  T343]
[   17.093091][  T343] -> #1 (rtnl_mutex){+.+.}-{3:3}:
[   17.093338][  T343]        __mutex_lock+0x14a/0x1940
[   17.093506][  T343]        ib_get_eth_speed+0xe8/0x9c0 [ib_core]
[   17.093735][  T343]        rxe_query_port+0x56/0x170 [rdma_rxe]
[   17.093950][  T343]        ib_query_port+0x338/0x670 [ib_core]
[   17.094178][  T343]        rxe_port_immutable+0x10f/0x230 [rdma_rxe]
[   17.094388][  T343]        ib_register_device+0x3a2/0xac0 [ib_core]
[   17.094618][  T343]        rxe_register_device+0x2cd/0x3a0 [rdma_rxe]
[   17.094842][  T343]        rxe_net_add+0xaf/0x100 [rdma_rxe]
[   17.095065][  T343]        rxe_newlink+0x4f/0xe0 [rdma_rxe]
[   17.095231][  T343]        nldev_newlink+0x29d/0x4b0 [ib_core]
[   17.095468][  T343]        rdma_nl_rcv_msg+0x2b0/0x4f0 [ib_core]
[   17.095712][  T343]        rdma_nl_rcv_skb.constprop.0.isra.0+0x238/0x390 [ib_core]                                                                                                                                     15:20:28 [123/6052]
[   17.096026][  T343]        netlink_unicast+0x438/0x730
[   17.096206][  T343]        netlink_sendmsg+0x72a/0xbc0
[   17.096379][  T343]        __sock_sendmsg+0xc5/0x190
[   17.096570][  T343]        __sys_sendto+0x25d/0x310
[   17.096742][  T343]        __x64_sys_sendto+0xdc/0x1b0
[   17.096928][  T343]        do_syscall_64+0x6d/0x140
[   17.097138][  T343]        entry_SYSCALL_64_after_hwframe+0x4b/0x53                                                 
[   17.097362][  T343]                                     
[   17.097362][  T343] -> #0 (&rxe->usdev_lock){+.+.}-{3:3}:                                                           
[   17.097630][  T343]        __lock_acquire+0x2be0/0x6490
[   17.097803][  T343]        lock_acquire+0x1b2/0x4e0
[   17.097974][  T343]        __mutex_lock+0x14a/0x1940
[   17.098164][  T343]        rxe_query_port+0x41/0x170 [rdma_rxe]                                                     
[   17.098397][  T343]        ib_query_port+0x338/0x670 [ib_core]                                                      
[   17.098639][  T343]        ib_setup_port_attrs+0x194/0x4b0 [ib_core]                                                
[   17.098878][  T343]        add_one_compat_dev+0x450/0x6e0 [ib_core]                                                 
[   17.099122][  T343]        enable_device_and_get+0x2ae/0x330 [ib_core]                                              
[   17.099363][  T343]        ib_register_device+0x6c0/0xac0 [ib_core]                                                 
[   17.099598][  T343]        rxe_register_device+0x2cd/0x3a0 [rdma_rxe]                                               
[   17.099824][  T343]        rxe_net_add+0xaf/0x100 [rdma_rxe]                                                        
[   17.100049][  T343]        rxe_newlink+0x4f/0xe0 [rdma_rxe]                                                         
[   17.100272][  T343]        nldev_newlink+0x29d/0x4b0 [ib_core]                                                      
[   17.100496][  T343]        rdma_nl_rcv_msg+0x2b0/0x4f0 [ib_core]                                                    
[   17.100755][  T343]        rdma_nl_rcv_skb.constprop.0.isra.0+0x238/0x390 [ib_core]                                 
[   17.101023][  T343]        netlink_unicast+0x438/0x730
[   17.101204][  T343]        netlink_sendmsg+0x72a/0xbc0
[   17.101354][  T343]        __sock_sendmsg+0xc5/0x190                                                                                                                                                                     15:20:28 [96/6052]
[   17.101511][  T343]        __sys_sendto+0x25d/0x310
[   17.101660][  T343]        __x64_sys_sendto+0xdc/0x1b0
[   17.101819][  T343]        do_syscall_64+0x6d/0x140
[   17.101969][  T343]        entry_SYSCALL_64_after_hwframe+0x4b/0x53                                                 
[   17.102149][  T343]                                     
[   17.102149][  T343] other info that might help us debug this:                                                       
[   17.102149][  T343]                                     
[   17.102462][  T343] Chain exists of:
[   17.102462][  T343]   &rxe->usdev_lock --> devices_rwsem --> &device->compat_devs_mutex                             
[   17.102462][  T343]                                     
[   17.102835][  T343]  Possible unsafe locking scenario:
[   17.102835][  T343]                                     
[   17.103073][  T343]        CPU0                    CPU1
[   17.103219][  T343]        ----                    ----
[   17.103364][  T343]   lock(&device->compat_devs_mutex);
[   17.103514][  T343]                                lock(devices_rwsem);                                             
[   17.103692][  T343]                                lock(&device->compat_devs_mutex);                                
[   17.103909][  T343]   lock(&rxe->usdev_lock);
[   17.104057][  T343]                                     
[   17.104057][  T343]  *** DEADLOCK ***
[   17.104057][  T343]                                     
[   17.104290][  T343] 5 locks held by rdma/343:
[   17.104450][  T343]  #0: ffffffffa06fcff8 (&rdma_nl_types[idx].sem){.+.+}-{3:3}, at: rdma_nl_rcv_msg+0x125/0x4f0 [ib_core]
[   17.104767][  T343]  #1: ffffffffa06f4f50 (link_ops_rwsem){++++}-{3:3}, at: nldev_newlink+0x37f/0x4b0 [ib_core]     
[   17.105109][  T343]  #2: ffffffffa06e79d0 (devices_rwsem){++++}-{3:3}, at: enable_device_and_get+0xf9/0x330 [ib_core]
[   17.105472][  T343]  #3: ffffffffa06e7750 (rdma_nets_rwsem){.+.+}-{3:3}, at: enable_device_and_get+0x250/0x330 [ib_core]
[   17.105874][  T343]  #4: ffff88800ef6ce90 (&device->compat_devs_mutex){+.+.}-{3:3}, at: add_one_compat_dev+0xe4/0x6e0 [ib_core]                                                                                          15:20:28 [69/6052]
[   17.106365][  T343]                                     
[   17.106365][  T343] stack backtrace:
[   17.106586][  T343] CPU: 3 UID: 0 PID: 343 Comm: rdma Not tainted 6.11.0-rc5+ #2367                                 
[   17.106828][  T343] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   17.107172][  T343] Call Trace:
[   17.107301][  T343]  <TASK>
[   17.107397][  T343]  dump_stack_lvl+0x57/0x80
[   17.107560][  T343]  check_noncircular+0x2f4/0x3d0
[   17.107736][  T343]  ? print_circular_bug+0x410/0x410
[   17.107893][  T343]  ? __fprop_add_percpu_max+0xb3/0x130
[   17.108043][  T343]  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0                                                      
[   17.108219][  T343]  ? find_held_lock+0x2d/0x110
[   17.108369][  T343]  __lock_acquire+0x2be0/0x6490
[   17.108519][  T343]  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0                                                      
[   17.108700][  T343]  ? lock_release+0x221/0x780
[   17.108857][  T343]  ? reacquire_held_locks+0x4a0/0x4a0
[   17.109013][  T343]  lock_acquire+0x1b2/0x4e0
[   17.109172][  T343]  ? rxe_query_port+0x41/0x170 [rdma_rxe]                                                         
[   17.109342][  T343]  ? __lock_acquire+0x6490/0x6490
[   17.109506][  T343]  ? kernfs_add_one+0x397/0x490
[   17.109671][  T343]  ? kernfs_new_node+0x133/0x240
[   17.109841][  T343]  ? lock_is_held_type+0x81/0xe0
[   17.110003][  T343]  __mutex_lock+0x14a/0x1940
[   17.110168][  T343]  ? rxe_query_port+0x41/0x170 [rdma_rxe]                                                         
[   17.110339][  T343]  ? rxe_query_port+0x41/0x170 [rdma_rxe]                                                         
[   17.110513][  T343]  ? lock_release+0x221/0x780
[   17.110679][  T343]  ? kfree+0x167/0x2e0                                                                                                                                                                                 15:20:28 [42/6052]
[   17.110814][  T343]  ? mutex_lock_io_nested+0x16e0/0x16e0                                                           
[   17.110978][  T343]  ? kobject_add_internal+0x292/0x920
[   17.111149][  T343]  ? kobject_add+0x117/0x180
[   17.111315][  T343]  ? kset_create_and_add+0x160/0x160
[   17.111484][  T343]  ? rxe_query_port+0x41/0x170 [rdma_rxe]                                                         
[   17.111658][  T343]  rxe_query_port+0x41/0x170 [rdma_rxe]                                                           
[   17.111836][  T343]  ib_query_port+0x338/0x670 [ib_core]
[   17.112036][  T343]  ib_setup_port_attrs+0x194/0x4b0 [ib_core]                                                      
[   17.112307][  T343]  ? ib_free_port_attrs+0x3c0/0x3c0 [ib_core]                                                     
[   17.112539][  T343]  ? __init_waitqueue_head+0xcb/0x150
[   17.112710][  T343]  add_one_compat_dev+0x450/0x6e0 [ib_core]                                                       
[   17.112950][  T343]  enable_device_and_get+0x2ae/0x330 [ib_core]                                                    
[   17.113185][  T343]  ? add_client_context+0x430/0x430 [ib_core]                                                     
[   17.113416][  T343]  ? rdma_counter_init+0x139/0x390 [ib_core]                                                      
[   17.113656][  T343]  ib_register_device+0x6c0/0xac0 [ib_core]                                                       
[   17.113894][  T343]  ? ib_device_get_netdev+0x3a0/0x3a0 [ib_core]                                                   
[   17.114124][  T343]  ? crypto_alg_mod_lookup+0x23b/0x3d0
[   17.114289][  T343]  ? crypto_alloc_tfm_node+0xd5/0x1e0
[   17.114455][  T343]  rxe_register_device+0x2cd/0x3a0 [rdma_rxe]                                                     
[   17.114667][  T343]  rxe_net_add+0xaf/0x100 [rdma_rxe]
[   17.114846][  T343]  rxe_newlink+0x4f/0xe0 [rdma_rxe]
[   17.115020][  T343]  nldev_newlink+0x29d/0x4b0 [ib_core]
[   17.115216][  T343]  ? nldev_port_get_dumpit+0x7a0/0x7a0 [ib_core]                                                  
[   17.115454][  T343]  ? __lock_acquire+0x6490/0x6490
[   17.115621][  T343]  ? lock_release+0x221/0x780
[   17.115795][  T343]  ? lock_chain_count+0x20/0x20
[   17.115965][  T343]  ? security_capable+0x68/0xa0                                                                                                                                                                                 [15/6052]
[   17.116130][  T343]  rdma_nl_rcv_msg+0x2b0/0x4f0 [ib_core]                                                          
[   17.116321][  T343]  ? rdma_nl_multicast+0xf0/0xf0 [ib_core]                                                        
[   17.116552][  T343]  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0                                                      
[   17.116752][  T343]  ? lock_acquire+0x1b2/0x4e0
[   17.116921][  T343]  ? find_held_lock+0x2d/0x110
[   17.117098][  T343]  ? __netlink_lookup+0x339/0x670
[   17.117277][  T343]  rdma_nl_rcv_skb.constprop.0.isra.0+0x238/0x390 [ib_core]                                       
[   17.117560][  T343]  ? rdma_nl_rcv_msg+0x4f0/0x4f0 [ib_core]                                                        
[   17.117809][  T343]  ? lock_release+0x221/0x780
[   17.117970][  T343]  ? netlink_deliver_tap+0xcd/0xa20
[   17.118127][  T343]  ? netlink_deliver_tap+0x152/0xa20
[   17.118283][  T343]  netlink_unicast+0x438/0x730
[   17.118434][  T343]  ? netlink_attachskb+0x710/0x710
[   17.118602][  T343]  ? lock_acquire+0x1b2/0x4e0
[   17.118772][  T343]  netlink_sendmsg+0x72a/0xbc0
[   17.118933][  T343]  ? netlink_unicast+0x730/0x730
[   17.119099][  T343]  ? reacquire_held_locks+0x4a0/0x4a0
[   17.119270][  T343]  ? __might_fault+0xae/0x120
[   17.119423][  T343]  ? netlink_unicast+0x730/0x730
[   17.119589][  T343]  __sock_sendmsg+0xc5/0x190
[   17.119757][  T343]  ? _copy_from_user+0x56/0xa0
[   17.119921][  T343]  __sys_sendto+0x25d/0x310
[   17.120085][  T343]  ? __x64_sys_getpeername+0xb0/0xb0
[   17.120273][  T343]  ? move_addr_to_user+0x54/0x80
[   17.120446][  T343]  ? __sys_getsockname+0x19d/0x230
[   17.120617][  T343]  ? fd_install+0x1c4/0x510
[   17.120798][  T343]  ? __sys_setsockopt+0xdc/0x160
[   17.120969][  T343]  __x64_sys_sendto+0xdc/0x1b0
[   17.121154][  T343]  ? lockdep_hardirqs_on_prepare+0x268/0x3e0                                                      
[   17.121358][  T343]  do_syscall_64+0x6d/0x140
[   17.121524][  T343]  entry_SYSCALL_64_after_hwframe+0x4b/0x53                                                       
[   17.121723][  T343] RIP: 0033:0x7f2aadc078b7
[   17.121895][  T343] Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 80 3d 95 17 0d 00 00 41 89 ca 74 10 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 69 c3 55 48 89 e5 53 48 83 ec 38 44 89 4d d0
[   17.122385][  T343] RSP: 002b:00007ffccd9b5638 EFLAGS: 00000202 ORIG_RAX: 000000000000002c                          
[   17.122651][  T343] RAX: ffffffffffffffda RBX: 00005625dd51d320 RCX: 00007f2aadc078b7                               
[   17.122908][  T343] RDX: 0000000000000030 RSI: 00005625dd51c2a0 RDI: 0000000000000004                               
[   17.123158][  T343] RBP: 00007ffccd9b5670 R08: 00007f2aadcec200 R09: 000000000000000c                               
[   17.123401][  T343] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffccd9b58b0                               
[   17.123642][  T343] R13: 00007ffccd9b5644 R14: 0000000066d5ad8b R15: 0000000000000000                               
[   17.123898][  T343]  </TASK>

