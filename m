Return-Path: <linux-rdma+bounces-2724-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40FD8D5921
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 05:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12FD1C22B15
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 03:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E413238DEC;
	Fri, 31 May 2024 03:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMeP96xV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC7C187562;
	Fri, 31 May 2024 03:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717127337; cv=none; b=EpwuW8HKPnxUMQkjlP9G8uP7whf9TJrd+J/kZbMAORc6WBDReHGcBj/R0QxAhCVgiRtVVPc8kT7SUlSTqFNQGl/s8kpqkzee7uiAX6ITQFUITcISmNOPGuji0qRURKRErcvV8sQEI8dIHlUEkcHnPmoOQ1ejCnIa8Ngs8XBkg+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717127337; c=relaxed/simple;
	bh=4eyWO6BTiWV78FwZiJQV1iMx7IDxtI3gimgxu/VNTIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRUKOQJepQ/MTlItXzlU/hiZcO2xwGfhSyVmaYKG3oCCGpgfBYWeAbPyyAl6JAUDiXDViLiUX9klYTOCWk+GdneJNm7fU1nslRTZnw1/9/xbdEA6QUbbpbeBiGiKhdMvrKCUjpdsozFAB1/EWiQQYRNyr6iIKQbjoT2DkshUdH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMeP96xV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE56C116B1;
	Fri, 31 May 2024 03:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717127337;
	bh=4eyWO6BTiWV78FwZiJQV1iMx7IDxtI3gimgxu/VNTIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EMeP96xVWrEmNv3ntDRCaR6XIxYWaUXoXHB5uMSLOo/G9ewg1dLGhpJzKK9heAyC3
	 wjMFo3HGmRCqskip0HDCKAb4LYZZyP23Pwmw+herqzpyalIl2m/SS3yrV+BU30r7gT
	 y+72nyI5hYKXOq0jhqIoq8tfrA4+2rnbRYHCiLvjLlm224CLxD778Dj71CUmysRONA
	 qAOMxpXR7J/nY2ipyxs+A6IAZtqB3CzSPL3Eccz7I2EVuXhx01HRB7G4io+mXdTBlm
	 UiGd+ihqTjBoiUsUYkcxuIfPQi/LzrTV6BpjhUChnjMPjXDfS0nObx7jb9WZpOL4LG
	 lI7khstNwvV9g==
Date: Fri, 31 May 2024 06:48:51 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH -rc] workqueue: Reimplement UAF fix to avoid lockdep
 worning
Message-ID: <20240531034851.GF3884@unreal>
References: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org>
 <ZljyqODpCD0_5-YD@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZljyqODpCD0_5-YD@slm.duckdns.org>

On Thu, May 30, 2024 at 11:42:00AM -1000, Tejun Heo wrote:
> Hello, Leon. Sorry about the delay.
> 
> On Tue, May 28, 2024 at 11:39:58AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > The commit 643445531829 ("workqueue: Fix UAF report by KASAN in
> > pwq_release_workfn()") causes to the following lockdep warning.
> 
> KASAN warning?

Yes

> 
> >  [ 1818.839405] ==================================================================
> >  [ 1818.840636] BUG: KASAN: slab-use-after-free in lockdep_register_key+0x707/0x810
> >  [ 1818.841827] Read of size 8 at addr ffff888156864928 by task systemd-udevd/71399
> ...
> >  [ 1818.846493] Call Trace:
> >  [ 1818.846981]  <TASK>
> >  [ 1818.847439]  dump_stack_lvl+0x7e/0xc0
> >  [ 1818.848089]  print_report+0xc1/0x600
> >  [ 1818.850978]  kasan_report+0xb9/0xf0
> >  [ 1818.852381]  lockdep_register_key+0x707/0x810
> >  [ 1818.855329]  alloc_workqueue+0x466/0x1800
> 
> Can you please map this to the source line?

I'm not sure if it is accurate, as my object is slightly different from
the report, but the area is the same.

➜  kernel git:(wip/leon-for-next) ./scripts/faddr2line vmlinux alloc_workqueue+0x466
alloc_workqueue+0x466/0x19f0:
kernel/workqueue.c:5710
  5709         wq_init_lockdep(wq);
  5710         INIT_LIST_HEAD(&wq->list);  

> 
> >  [ 1818.857997]  ib_mad_init_device+0x809/0x1760 [ib_core]
> 
> ...
> 
> >  [ 1818.907242] Allocated by task 1:
> >  [ 1818.907819]  kasan_save_stack+0x20/0x40
> >  [ 1818.908512]  kasan_save_track+0x10/0x30
> >  [ 1818.909173]  __kasan_slab_alloc+0x51/0x60
> >  [ 1818.909849]  kmem_cache_alloc_noprof+0x139/0x3f0
> >  [ 1818.910608]  getname_flags+0x4f/0x3c0
> >  [ 1818.911236]  do_sys_openat2+0xd3/0x150
> >  [ 1818.911878]  __x64_sys_openat+0x11f/0x1d0
> >  [ 1818.912554]  do_syscall_64+0x6d/0x140
> >  [ 1818.913189]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >  [ 1818.913996]
> >  [ 1818.914359] Freed by task 1:
> >  [ 1818.914897]  kasan_save_stack+0x20/0x40
> >  [ 1818.915553]  kasan_save_track+0x10/0x30
> >  [ 1818.916210]  kasan_save_free_info+0x37/0x50
> >  [ 1818.916911]  poison_slab_object+0x10c/0x190
> >  [ 1818.917606]  __kasan_slab_free+0x11/0x30
> >  [ 1818.918271]  kmem_cache_free+0x12c/0x460
> >  [ 1818.918939]  do_sys_openat2+0x102/0x150
> >  [ 1818.919586]  __x64_sys_openat+0x11f/0x1d0
> >  [ 1818.920264]  do_syscall_64+0x6d/0x140
> >  [ 1818.920899]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >  [ 1818.921699]
> >  [ 1818.922059] The buggy address belongs to the object at ffff888156864400
> >  [ 1818.922059]  which belongs to the cache names_cache of size 4096
> 
> This is a dcache name. I'm a bit lost on how we're hitting this.

We have similar issues but with different workqueue.

 [ 1233.554381] ==================================================================
 [ 1233.555215] BUG: KASAN: slab-use-after-free in lockdep_register_key+0x707/0x810
 [ 1233.555983] Read of size 8 at addr ffff88811f1d8928 by task test-ovs-bond-m/10149
 [ 1233.556774] 
 [ 1233.557020] CPU: 0 PID: 10149 Comm: test-ovs-bond-m Not tainted 6.10.0-rc1_external_1613e604df0c #1
 [ 1233.557951] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 [ 1233.559044] Call Trace:
 [ 1233.559367]  <TASK>
 [ 1233.559653]  dump_stack_lvl+0x7e/0xc0
 [ 1233.560078]  print_report+0xc1/0x600
 [ 1233.560496]  ? __virt_addr_valid+0x1cf/0x390
 [ 1233.560964]  ? lockdep_register_key+0x707/0x810
 [ 1233.561463]  ? lockdep_register_key+0x707/0x810
 [ 1233.561975]  kasan_report+0xb9/0xf0
 [ 1233.562382]  ? lockdep_register_key+0x707/0x810
 [ 1233.562872]  lockdep_register_key+0x707/0x810
 [ 1233.563344]  ? add_lock_to_list+0x5b0/0x5b0
 [ 1233.563813]  ? lockdep_init_map_type+0x2c3/0x7a0
 [ 1233.564312]  ? __raw_spin_lock_init+0x3b/0x110
 [ 1233.564799]  alloc_workqueue+0x466/0x1800
 [ 1233.565261]  ? workqueue_sysfs_register+0x370/0x370
 [ 1233.565808]  ? is_module_address+0x2d/0x40
 [ 1233.566268]  ? static_obj+0x98/0xd0
 [ 1233.566671]  ? lockdep_init_map_type+0x2c3/0x7a0
 [ 1233.567170]  ? queue_work_node+0x2c0/0x2c0
 [ 1233.567627]  mlx5_pagealloc_init+0x7d/0x180 [mlx5_core]
 [ 1233.568322]  mlx5_mdev_init+0x482/0xad0 [mlx5_core]
 [ 1233.568915]  ? devlink_alloc_ns+0x883/0xaa0
 [ 1233.569387]  probe_one+0x11d/0xc80 [mlx5_core]
 [ 1233.572996]  ? remove_one+0x210/0x210 [mlx5_core]
 [ 1233.573604]  local_pci_probe+0xd7/0x180
 [ 1233.574063]  pci_device_probe+0x228/0x720
 [ 1233.574516]  ? pci_match_device+0x690/0x690
 [ 1233.574985]  ? kernfs_create_link+0x16f/0x230
 [ 1233.575460]  ? do_raw_spin_unlock+0x54/0x220
 [ 1233.575933]  ? kernfs_put+0x18/0x30
 [ 1233.576342]  ? sysfs_do_create_link_sd+0x8c/0xf0
 [ 1233.576844]  really_probe+0x1e4/0x920
 [ 1233.577269]  __driver_probe_device+0x261/0x3e0
 [ 1233.577766]  driver_probe_device+0x49/0x130
 [ 1233.578232]  __device_attach_driver+0x187/0x290
 [ 1233.578723]  ? driver_probe_device+0x130/0x130
 [ 1233.579202]  bus_for_each_drv+0x103/0x190
 [ 1233.579644]  ? mark_held_locks+0x9f/0xe0
 [ 1233.580090]  ? bus_for_each_dev+0x170/0x170
 [ 1233.580553]  ? lockdep_hardirqs_on_prepare+0x284/0x400
 [ 1233.581108]  __device_attach+0x1a3/0x3f0
 [ 1233.581544]  ? device_driver_attach+0x1e0/0x1e0
 [ 1233.582047]  ? pci_bridge_d3_possible+0x1e0/0x1e0
 [ 1233.582558]  ? pci_create_resource_files+0xeb/0x170
 [ 1233.583081]  pci_bus_add_device+0x9f/0xf0
 [ 1233.583531]  pci_iov_add_virtfn+0x9c6/0xde0
 [ 1233.583994]  ? __wake_up+0x40/0x50
 [ 1233.584396]  sriov_enable+0x658/0xd10
 [ 1233.584813]  ? pcibios_sriov_disable+0x10/0x10
 [ 1233.585317]  mlx5_core_sriov_configure+0xb1/0x310 [mlx5_core]
 [ 1233.586030]  sriov_numvfs_store+0x209/0x370
 [ 1233.586497]  ? sriov_totalvfs_show+0xc0/0xc0
 [ 1233.586972]  ? sysfs_file_ops+0x170/0x170
 [ 1233.587430]  ? sysfs_file_ops+0x11a/0x170
 [ 1233.587883]  ? sysfs_file_ops+0x170/0x170
 [ 1233.588334]  kernfs_fop_write_iter+0x347/0x520
 [ 1233.588817]  vfs_write+0x96f/0xf30
 [ 1233.589234]  ? do_user_addr_fault+0x812/0xd20
 [ 1233.589714]  ? kernel_write+0x530/0x530
 [ 1233.590168]  ? __fget_light+0x53/0x1d0
 [ 1233.590600]  ksys_write+0xf1/0x1d0
 [ 1233.591003]  ? __x64_sys_read+0xb0/0xb0
 [ 1233.591437]  ? do_user_addr_fault+0x895/0xd20
 [ 1233.591924]  do_syscall_64+0x6d/0x140
 [ 1233.592348]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 [ 1233.592888] RIP: 0033:0x7f8d663018b7
 [ 1233.593312] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
 [ 1233.595070] RSP: 002b:00007ffdbae78c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
 [ 1233.595853] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f8d663018b7
 [ 1233.596551] RDX: 0000000000000002 RSI: 000055e696bc2070 RDI: 0000000000000001
 [ 1233.597270] RBP: 000055e696bc2070 R08: 0000000000000000 R09: 00007f8d663b64e0
 [ 1233.598001] R10: 00007f8d663b63e0 R11: 0000000000000246 R12: 0000000000000002
 [ 1233.598716] R13: 00007f8d663fb5a0 R14: 0000000000000002 R15: 00007f8d663fb7a0
 [ 1233.599431]  </TASK>
 [ 1233.599735] 
 [ 1233.599979] Allocated by task 9589:
 [ 1233.600382]  kasan_save_stack+0x20/0x40
 [ 1233.600828]  kasan_save_track+0x10/0x30
 [ 1233.601265]  __kasan_kmalloc+0x77/0x90
 [ 1233.601696]  kernfs_iop_get_link+0x61/0x5a0
 [ 1233.602181]  vfs_readlink+0x1ab/0x320
 [ 1233.602582] mlx5_core 0000:08:00.6 enp8s0f1v0: renamed from eth4
 [ 1233.602605]  do_readlinkat+0x1cb/0x290
 [ 1233.602610]  __x64_sys_readlinkat+0x92/0xf0
 [ 1233.602612]  do_syscall_64+0x6d/0x140
 [ 1233.605196]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 [ 1233.605731] 
 [ 1233.605986] Freed by task 9589:
 [ 1233.606373]  kasan_save_stack+0x20/0x40
 [ 1233.606801]  kasan_save_track+0x10/0x30
 [ 1233.607232]  kasan_save_free_info+0x37/0x50
 [ 1233.607695]  poison_slab_object+0x10c/0x190
 [ 1233.608161]  __kasan_slab_free+0x11/0x30
 [ 1233.608604]  kfree+0x11b/0x340
 [ 1233.608970]  vfs_readlink+0x120/0x320
 [ 1233.609413]  do_readlinkat+0x1cb/0x290
 [ 1233.609849]  __x64_sys_readlinkat+0x92/0xf0
 [ 1233.610308]  do_syscall_64+0x6d/0x140
 [ 1233.610741]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 [ 1233.611276] 
 [ 1233.611524] The buggy address belongs to the object at ffff88811f1d8000
 [ 1233.611524]  which belongs to the cache kmalloc-4k of size 4096
 [ 1233.612714] The buggy address is located 2344 bytes inside of
 [ 1233.612714]  freed 4096-byte region [ffff88811f1d8000, ffff88811f1d9000)
 [ 1233.613920] 
 [ 1233.614168] The buggy address belongs to the physical page:
 [ 1233.614743] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11f1d8
 [ 1233.615556] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
 [ 1233.616338] flags: 0x200000000000040(head|node=0|zone=2)
 [ 1233.616894] page_type: 0xffffefff(slab)
 [ 1233.617340] raw: 0200000000000040 ffff888100043040 ffffea00051bd800 dead000000000002
 [ 1233.618151] raw: 0000000000000000 0000000000040004 00000001ffffefff 0000000000000000
 [ 1233.618958] head: 0200000000000040 ffff888100043040 ffffea00051bd800 dead000000000002
 [ 1233.619763] head: 0000000000000000 0000000000040004 00000001ffffefff 0000000000000000
 [ 1233.620573] head: 0200000000000003 ffffea00047c7601 ffffffffffffffff 0000000000000000
 [ 1233.621386] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
 [ 1233.622201] page dumped because: kasan: bad access detected
 [ 1233.622778] 
 [ 1233.623027] Memory state around the buggy address:
 [ 1233.623532]  ffff88811f1d8800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 [ 1233.624280]  ffff88811f1d8880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 [ 1233.625029] >ffff88811f1d8900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 [ 1233.625803]                                   ^
 [ 1233.626296]  ffff88811f1d8980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 [ 1233.627047]  ffff88811f1d8a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 [ 1233.627801] ==================================================================

> 
> Thanks.
> 
> -- 
> tejun

