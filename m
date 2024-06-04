Return-Path: <linux-rdma+bounces-2812-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 870B78FAD25
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 10:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB2A9B217D1
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 08:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B9B1428FD;
	Tue,  4 Jun 2024 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnnbzbqo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1601422B2;
	Tue,  4 Jun 2024 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717488604; cv=none; b=tZJoDAtLA/GR+ITxZa/edfoZKbbA4vDri+gqoT/+psrOsNj8uglDBWQ5r0pDs1HFgbDAde110GsZxS9yh8DUSXBWO4YdMI4Le2xQSoAYLOSRncGmwD78v5XoJIORiiJVDAOLT4CAIyF8XPRtWRSG3dYYa/SEClpQFuFBK9M/a4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717488604; c=relaxed/simple;
	bh=0Cf0CyzkCzo4+hwTBl+a4NoUWxaLyIjWgwlG7ygjWgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bb+E7IrVh4Ns5W3awj0hIsyXCSfcO9bY5J8zOsygwJ6nCztNb8094YPRpPCk55zyg54A0T2t4JIpyD5OJWYQd0p3cp9RpDGQvHYZpboQCQGfcBBDAnWQYWtnfvwYD2pVWv1/Qkq3rhIoNSpr+n+B0JSJ65DAIS4TzdxsJkPBRnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnnbzbqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F2DC4AF07;
	Tue,  4 Jun 2024 08:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717488604;
	bh=0Cf0CyzkCzo4+hwTBl+a4NoUWxaLyIjWgwlG7ygjWgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tnnbzbqo+xubxtkdswPid2Z9Tk81ICVLIZ7XKLuA0Iv3mYvbKEJ0wIpJUu9kyp/O0
	 ZP7eV4+/hD3WubWEcoFgdM0FYFS9LwNDpaKneAX1n8fOHLG4Hv1E4iQjcXjcmrBKMm
	 27VSy2+pBKrbRg5pGM7P3KxLkEpyfWheJ3vP/SRuVKt7gI+ZNWgHX2HpGT2+JvkQTQ
	 HVPhZBomTODLCemy9c+WFuIbdjIfcSyiZdrl08gp16DZ8WtbD8hfRs6ehtwOkeAlMJ
	 2FSEGA7OuocO5fS2d5a2nD9Q8/s0NkdnuyG2HnzKZ7mfjBYO/QHL4LERG4kzxksprm
	 NC2BS36cY+VSw==
Date: Tue, 4 Jun 2024 11:09:58 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH -rc] workqueue: Reimplement UAF fix to avoid lockdep
 worning
Message-ID: <20240604080958.GL3884@unreal>
References: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org>
 <ZljyqODpCD0_5-YD@slm.duckdns.org>
 <20240531034851.GF3884@unreal>
 <Zl4jPImmEeRuYQjz@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zl4jPImmEeRuYQjz@slm.duckdns.org>

On Mon, Jun 03, 2024 at 10:10:36AM -1000, Tejun Heo wrote:
> Hello, again, Leon.
> 
> Re-reading the warning, I'm not sure this is a bug on workqueue side.
> 
> On Fri, May 31, 2024 at 06:48:51AM +0300, Leon Romanovsky wrote:
> >  [ 1233.554381] ==================================================================
> >  [ 1233.555215] BUG: KASAN: slab-use-after-free in lockdep_register_key+0x707/0x810
> >  [ 1233.555983] Read of size 8 at addr ffff88811f1d8928 by task test-ovs-bond-m/10149
> >  [ 1233.556774] 
> >  [ 1233.557020] CPU: 0 PID: 10149 Comm: test-ovs-bond-m Not tainted 6.10.0-rc1_external_1613e604df0c #1
> >  [ 1233.557951] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> >  [ 1233.559044] Call Trace:
> >  [ 1233.559367]  <TASK>
> >  [ 1233.559653]  dump_stack_lvl+0x7e/0xc0
> >  [ 1233.560078]  print_report+0xc1/0x600
> >  [ 1233.561975]  kasan_report+0xb9/0xf0
> >  [ 1233.562872]  lockdep_register_key+0x707/0x810
> >  [ 1233.564799]  alloc_workqueue+0x466/0x1800
> >  [ 1233.567627]  mlx5_pagealloc_init+0x7d/0x180 [mlx5_core]
> >  [ 1233.568322]  mlx5_mdev_init+0x482/0xad0 [mlx5_core]
> >  [ 1233.569387]  probe_one+0x11d/0xc80 [mlx5_core]
> 
> So, this is saying that alloc_workqueue() allocated a name during lockdep
> initialization. This is before pwq init or anything else complicated
> happening. It just allocated the workqueue struct and called into
> lockep_register_key(&wq->key).
> 
> >  [ 1233.599979] Allocated by task 9589:
> >  [ 1233.600382]  kasan_save_stack+0x20/0x40
> >  [ 1233.600828]  kasan_save_track+0x10/0x30
> >  [ 1233.601265]  __kasan_kmalloc+0x77/0x90
> >  [ 1233.601696]  kernfs_iop_get_link+0x61/0x5a0
> >  [ 1233.602181]  vfs_readlink+0x1ab/0x320
> >  [ 1233.602605]  do_readlinkat+0x1cb/0x290
> >  [ 1233.602610]  __x64_sys_readlinkat+0x92/0xf0
> >  [ 1233.602612]  do_syscall_64+0x6d/0x140
> >  [ 1233.605196]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >  [ 1233.605731] 
> >  [ 1233.605986] Freed by task 9589:
> >  [ 1233.606373]  kasan_save_stack+0x20/0x40
> >  [ 1233.606801]  kasan_save_track+0x10/0x30
> >  [ 1233.607232]  kasan_save_free_info+0x37/0x50
> >  [ 1233.607695]  poison_slab_object+0x10c/0x190
> >  [ 1233.608161]  __kasan_slab_free+0x11/0x30
> >  [ 1233.608604]  kfree+0x11b/0x340
> >  [ 1233.608970]  vfs_readlink+0x120/0x320
> >  [ 1233.609413]  do_readlinkat+0x1cb/0x290
> >  [ 1233.609849]  __x64_sys_readlinkat+0x92/0xf0
> >  [ 1233.610308]  do_syscall_64+0x6d/0x140
> >  [ 1233.610741]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> And KASAN is reporting use-after-free on a completely unrelated VFS object.
> I can't tell for sure from the logs alone but lockdep_register_key()
> iterates entries in the hashtable trying to find whether the key is a
> duplicate and it could be that that walk is triggering the use-after-free
> warning. If so, it doesn't really have much to do with workqueue. The
> corruption happened elsewhere and workqueue just happens to traverse the
> hashtable afterwards.

The problem is that revert of commit 643445531829 ("workqueue: Fix UAF report by KASAN in pwq_release_workfn()")
fixed these use-after-free reports. In addition, we didn't get any other failures (related to memory corruption)
except these lockdeps reports.

Tariq showed me another lockdep report. I don't think that it is
related, but adding here to make sure.

Also let's add Peter to this report, maybe he can guide us to find the root cause.
➜  kernel git:(rdma-next) ./scripts/faddr2line vmlinux lockdep_register_key+0x8f
lockdep_register_key+0x8f/0x800:
lockdep_lock at kernel/locking/lockdep.c:141
(inlined by) graph_lock at kernel/locking/lockdep.c:170
(inlined by) lockdep_register_key at kernel/locking/lockdep.c:1223

 [ 1078.101755] ====================================================================================================
 [ 1078.584085] mlx5_core 0000:08:00.0: firmware version: 16.35.1012
 [ 1078.585182] mlx5_core 0000:08:00.0: 126.016 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x16 link at 0000:00:02.7 (capable of 252.048 Gb/s with 16.0 GT/s PCIe x16 link)
 [ 1079.013341] mlx5_core 0000:08:00.0: Rate limit: 127 rates are supported, range: 0Mbps to 97656Mbps
 [ 1079.015912] mlx5_core 0000:08:00.0: E-Switch: Total vports 6, per vport: max uc(128) max mc(2048)
 [ 1079.048423] mlx5_core 0000:08:00.0: Port module event: module 0, Cable plugged
 [ 1079.053400] mlx5_core 0000:08:00.0: mlx5_pcie_event:301:(pid 10308): PCIe slot advertised sufficient power (75W).
 [ 1079.283669] mlx5_core 0000:08:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0 basic)
 [ 1079.288969] BUG: unable to handle page fault for address: 000000330000000a
 [ 1079.290036] #PF: supervisor read access in kernel mode
 [ 1079.290902] #PF: error_code(0x0000) - not-present page
 [ 1079.292016] PGD 0 P4D 0
 [ 1079.292808] Oops: Oops: 0000 [#1] SMP
 [ 1079.293561] CPU: 8 PID: 31777 Comm: modprobe Not tainted 6.10.0-rc2_internal_net_next_60d8b51 #1
 [ 1079.295087] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 [ 1079.296804] RIP: 0010:lockdep_register_key+0x8f/0x220
 [ 1079.297600] Code: bf 31 fa 01 65 4c 8b 25 7f 56 e5 7e 45 85 c0 4c 89 25 3d 33 e0 03 74 25 48 8b 04 ed 00 37 e2 84 48 85 c0 75 11 e9 c2 00 00 00 <48> 8b 00 48 85 c0 0f 84 b6 00 00 00 48 39 d8 75 ef 0f 0b 8b 3d a0
 [ 1079.300226] RSP: 0018:ffff888108e97a80 EFLAGS: 00010003
 [ 1079.301034] RAX: 000000330000000a RBX: ffff8881095c6278 RCX: 000000000000000a
 [ 1079.302076] RDX: 0000000000000001 RSI: 000000000000000a RDI: ffffffff826a4700
 [ 1079.303148] RBP: 00000000000001ae R08: 0000000000000001 R09: 0000000000000000
 [ 1079.304215] R10: 0000000000000000 R11: 0000000000000001 R12: ffff888122ff8000
 [ 1079.305281] R13: 0000000000000202 R14: ffffffff84e24470 R15: ffffffff84ffdf18
 [ 1079.306338] FS:  00007fb8b7277740(0000) GS:ffff88852cc00000(0000) knlGS:0000000000000000
 [ 1079.307593] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [ 1079.308482] CR2: 000000330000000a CR3: 00000001167d7004 CR4: 0000000000370eb0
 [ 1079.309540] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 [ 1079.310628] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 [ 1079.311713] Call Trace:
 [ 1079.312195]  <TASK>
 [ 1079.312623]  ? __die+0x20/0x60
 [ 1079.313178]  ? page_fault_oops+0x150/0x400
 [ 1079.313852]  ? exc_page_fault+0x79/0x240
 [ 1079.314522]  ? asm_exc_page_fault+0x22/0x30
 [ 1079.315213]  ? lockdep_register_key+0x8f/0x220
 [ 1079.315963]  devlink_alloc_ns+0x306/0x390
 [ 1079.316623]  probe_one+0x24/0x4e0 [mlx5_core]
 [ 1079.317432]  local_pci_probe+0x3e/0x90
 [ 1079.318071]  pci_device_probe+0xbf/0x240
 [ 1079.318735]  ? sysfs_do_create_link_sd+0x69/0xd0
 [ 1079.319491]  really_probe+0xd4/0x3b0
 [ 1079.320104]  __driver_probe_device+0x8c/0x160
 [ 1079.320811]  driver_probe_device+0x1e/0xb0
 [ 1079.321488]  __driver_attach+0xff/0x1e0
 [ 1079.322128]  ? __device_attach_driver+0x130/0x130
 [ 1079.322886]  bus_for_each_dev+0x74/0xc0
 [ 1079.323555]  bus_add_driver+0xf0/0x250
 [ 1079.324188]  driver_register+0x58/0x100
 [ 1079.324837]  ? 0xffffffffa0242000
 [ 1079.325420]  mlx5_init+0x65/0x1000 [mlx5_core]
 [ 1079.326226]  do_one_initcall+0x61/0x2b0
 [ 1079.326887]  ? kmalloc_trace_noprof+0x1a9/0x400
 [ 1079.327647]  do_init_module+0x8a/0x270
 [ 1079.328293]  init_module_from_file+0x8b/0xd0
 [ 1079.328999]  idempotent_init_module+0x17d/0x230
 [ 1079.329735]  __x64_sys_finit_module+0x61/0xb0
 [ 1079.330459]  do_syscall_64+0x6d/0x140
 [ 1079.331084]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 [ 1079.331900] RIP: 0033:0x7fb8b6b0af3d
 [ 1079.332507] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bb ee 0e 00 f7 d8 64 89 01 48
 [ 1079.335157] RSP: 002b:00007ffe04497818 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
 [ 1079.336362] RAX: ffffffffffffffda RBX: 000055b05c326c10 RCX: 00007fb8b6b0af3d
 [ 1079.337407] RDX: 0000000000000000 RSI: 000055b049840a2a RDI: 0000000000000003
 [ 1079.338466] RBP: 0000000000040000 R08: 0000000000000000 R09: 00007ffe04497950
 [ 1079.339533] R10: 0000000000000003 R11: 0000000000000246 R12: 000055b049840a2a
 [ 1079.340581] R13: 000055b05c326d80 R14: 000055b05c326c10 R15: 000055b05c329600
 [ 1079.341634]  </TASK>
 [ 1079.342076] Modules linked in: mlx5_core(+) ip6_tunnel tunnel6 nf_tables vfio_pci vfio_pci_core act_tunnel_key vxlan act_mirred act_skbedit cls_matchall act_gact cls_flower sch_ingress nfnetlink_cttimeout vfio_iommu_type1 vfio iptable_raw openvswitch nsh xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter rpcsec_gss_krb5 auth_rpcgss oid_registry overlay rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core zram zsmalloc fuse [last unloaded: nf_tables]
 [ 1079.352250] CR2: 000000330000000a
 [ 1079.352838] ---[ end trace 0000000000000000 ]---
 [ 1079.353575] RIP: 0010:lockdep_register_key+0x8f/0x220
 [ 1079.354380] Code: bf 31 fa 01 65 4c 8b 25 7f 56 e5 7e 45 85 c0 4c 89 25 3d 33 e0 03 74 25 48 8b 04 ed 00 37 e2 84 48 85 c0 75 11 e9 c2 00 00 00 <48> 8b 00 48 85 c0 0f 84 b6 00 00 00 48 39 d8 75 ef 0f 0b 8b 3d a0
 [ 1079.357025] RSP: 0018:ffff888108e97a80 EFLAGS: 00010003
 [ 1079.357832] RAX: 000000330000000a RBX: ffff8881095c6278 RCX: 000000000000000a
 [ 1079.358899] RDX: 0000000000000001 RSI: 000000000000000a RDI: ffffffff826a4700
 [ 1079.359967] RBP: 00000000000001ae R08: 0000000000000001 R09: 0000000000000000
 [ 1079.361005] R10: 0000000000000000 R11: 0000000000000001 R12: ffff888122ff8000
 [ 1079.362044] R13: 0000000000000202 R14: ffffffff84e24470 R15: ffffffff84ffdf18
 [ 1079.363090] FS:  00007fb8b7277740(0000) GS:ffff88852cc00000(0000) knlGS:0000000000000000
 [ 1079.364347] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [ 1079.365217] CR2: 000000330000000a CR3: 00000001167d7004 CR4: 0000000000370eb0
 [ 1079.366259] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 [ 1079.367304] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 [ 1079.368353] note: modprobe[31777] exited with irqs disabled
 [ 1080.829334] ------------[ cut here ]------------
 [ 1080.830879] WARNING: CPU: 8 PID: 31850 at kernel/locking/lockdep.c:467 lockdep_set_lock_cmp_fn+0x7e/0xa0
 [ 1080.833713] Modules linked in: mlx5_core(+) ip6_tunnel tunnel6 nf_tables vfio_pci vfio_pci_core act_tunnel_key vxlan act_mirred act_skbedit cls_matchall act_gact cls_flower sch_ingress nfnetlink_cttimeout vfio_iommu_type1 vfio iptable_raw openvswitch nsh xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter rpcsec_gss_krb5 auth_rpcgss oid_registry overlay rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core zram zsmalloc fuse [last unloaded: nf_tables]
 [ 1080.842428] CPU: 8 PID: 31850 Comm: bash Tainted: G      D            6.10.0-rc2_internal_net_next_60d8b51 #1
 [ 1080.843911] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 [ 1080.845516] RIP: 0010:lockdep_set_lock_cmp_fn+0x7e/0xa0
 [ 1080.846331] Code: f8 01 75 26 9c 58 f6 c4 02 75 2e 41 f7 c4 00 02 00 00 74 01 fb 5b 5d 41 5c c3 31 d2 31 f6 e8 49 f8 ff ff 48 85 c0 74 ca eb a0 <0f> 0b 65 c7 05 0d ce e3 7e 00 00 00 00 eb cb e8 6e b7 c9 00 eb cb
 [ 1080.848956] RSP: 0018:ffff8881c8f5fe68 EFLAGS: 00010002
 [ 1080.849774] RAX: 0000000000000002 RBX: ffffffff81467940 RCX: 0000000000000000
 [ 1080.850839] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888101959068
 [ 1080.851911] RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
 [ 1080.852962] R10: ffff8881c8f5fe88 R11: 0000000000000000 R12: 0000000000000246
 [ 1080.854017] R13: 0000000000000360 R14: 0000000000000000 R15: 0000000000000000
 [ 1080.855077] FS:  00007f2434925740(0000) GS:ffff88852cc00000(0000) knlGS:0000000000000000
 [ 1080.856344] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [ 1080.857222] CR2: 0000559940a36088 CR3: 00000001ba6a0004 CR4: 0000000000370eb0
 [ 1080.858273] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 [ 1080.859329] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 [ 1080.860389] Call Trace:
 [ 1080.860860]  <TASK>
 [ 1080.861293]  ? __warn+0x88/0x190
 [ 1080.861867]  ? lockdep_set_lock_cmp_fn+0x7e/0xa0
 [ 1080.862631]  ? report_bug+0x160/0x170
 [ 1080.863260]  ? handle_bug+0x3c/0x60
 [ 1080.863874]  ? exc_invalid_op+0x14/0x70
 [ 1080.864512]  ? asm_exc_invalid_op+0x16/0x20
 [ 1080.865201]  ? begin_new_exec+0xd30/0xd30
 [ 1080.865867]  ? lockdep_set_lock_cmp_fn+0x7e/0xa0
 [ 1080.866609]  ? lockdep_set_lock_cmp_fn+0x77/0xa0
 [ 1080.867354]  alloc_pipe_info+0x17a/0x240
 [ 1080.868015]  create_pipe_files+0x40/0x220
 [ 1080.868680]  do_pipe2+0x3a/0xf0
 [ 1080.869248]  ? trace_hardirqs_on_prepare+0x3f/0xb0
 [ 1080.870022]  __x64_sys_pipe+0x10/0x20
 [ 1080.870661]  do_syscall_64+0x6d/0x140
 [ 1080.871285]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 [ 1080.872103] RIP: 0033:0x7f24347020ab
 [ 1080.872723] Code: 73 01 c3 48 8b 0d 7d 7d 0f 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 16 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4d 7d 0f 00 f7 d8 64 89 01 48
 [ 1080.875408] RSP: 002b:00007ffdcba2e4e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000016
 [ 1080.876594] RAX: ffffffffffffffda RBX: 00007ffdcba2ea5c RCX: 00007f24347020ab
 [ 1080.877649] RDX: 0000559c1936fbaf RSI: 0000559940a19010 RDI: 00007ffdcba2e5c0
 [ 1080.878710] RBP: 0000559940a35a90 R08: 0000559940a2f0d0 R09: 00746f6f723d5245
 [ 1080.879772] R10: 0000000000000048 R11: 0000000000000246 R12: 0000000000000001
 [ 1080.880812] R13: 0000559940a35bc0 R14: 0000000000000000 R15: 0000000000000022
 [ 1080.881859]  </TASK>
 [ 1080.882299] irq event stamp: 0
 [ 1080.882859] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
 [ 1080.883818] hardirqs last disabled at (0): [<ffffffff81174b38>] copy_process+0x928/0x2a80
 [ 1080.885058] softirqs last  enabled at (0): [<ffffffff81174b38>] copy_process+0x928/0x2a80
 [ 1080.886325] softirqs last disabled at (0): [<0000000000000000>] 0x0
 [ 1080.887273] ---[ end trace 0000000000000000 ]---
 [ 1083.381768] ====================================================================================================

Thanks

> 
> Thanks.
> 
> -- 
> tejun

