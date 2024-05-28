Return-Path: <linux-rdma+bounces-2622-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A7B8D167C
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 10:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EEC1C21EBF
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 08:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9316913D29E;
	Tue, 28 May 2024 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEO8RrDe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0E713D25E;
	Tue, 28 May 2024 08:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716885616; cv=none; b=p48dCQW7jlZ9YzZDayWpd/1vnajtjTGgeIQsWZSNhT5Ul3aRdT+vdRszOkZllkY+GJ6t1zEvfjyj2Xr/C08O4M/c1bBoeMoIhRl/7e72CbUndSdKCLsfdSu4L1zjWZITI+T+F1Z2oFLsdF05YxudtzSiloXdfKhzuVNew9gx0PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716885616; c=relaxed/simple;
	bh=LWvPZ3qxbcAW+yiU7uRYspkMX5X3P5LhzhtlVdu6fw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ggl1WuDPW2qyZdV2mvZFpUPDHMREJnASJfg5WY6bs5PN73kknoX7IKpUyltcSftNJxvQax0HgjwPySbi4aB2enbV+K34NA8l1hOgH9zmoZoSo1ttSQygpcsrh32kQAIWW7iSmaIbq73swLcTl6PcowtVrky7eFHBNXqtD2y4CKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEO8RrDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AA1C32782;
	Tue, 28 May 2024 08:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716885615;
	bh=LWvPZ3qxbcAW+yiU7uRYspkMX5X3P5LhzhtlVdu6fw8=;
	h=From:To:Cc:Subject:Date:From;
	b=HEO8RrDexy5jJaSvZgWqwGTXU9LGGbRAY1+ocVhmUcGdyT47iTwk52mze0Tbu7F2y
	 KrHgsN/jzrejJAKpFeHbN/qMTgPETX5S+iQDRCJGFZKmxmTC91MqpDMRIaZYCbC/on
	 sxjUTengsL8rLVVElYzpm2YrRj9Bbb3EC3ELjexD3JUAB5O03EP7Zx0D/P64IF7AW0
	 92gY+ilDSrQ86VQE5WXVVl0xoPXLMyzhy7NcE9dhc2EzcF/NRzUVe2LMgAeoPQB+DA
	 M2tXLrnCOAy+CvSpIs8DsyOZevqUzs0N6ws33FtSVMIUvi8+6PhX1dxtsGEp37INAL
	 UQ+fo5m0f4PZg==
From: Leon Romanovsky <leon@kernel.org>
To: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH -rc] workqueue: Reimplement UAF fix to avoid lockdep worning
Date: Tue, 28 May 2024 11:39:58 +0300
Message-ID: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

The commit 643445531829 ("workqueue: Fix UAF report by KASAN in
pwq_release_workfn()") causes to the following lockdep warning.

 [ 1818.839405] ==================================================================
 [ 1818.840636] BUG: KASAN: slab-use-after-free in lockdep_register_key+0x707/0x810
 [ 1818.841827] Read of size 8 at addr ffff888156864928 by task systemd-udevd/71399
 [ 1818.843007]
 [ 1818.843378] CPU: 8 PID: 71399 Comm: systemd-udevd Not tainted 6.10.0-rc1_external_1613e604df0c #1
 [ 1818.844806] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 [ 1818.846493] Call Trace:
 [ 1818.846981]  <TASK>
 [ 1818.847439]  dump_stack_lvl+0x7e/0xc0
 [ 1818.848089]  print_report+0xc1/0x600
 [ 1818.848728]  ? __virt_addr_valid+0x1cf/0x390
 [ 1818.849458]  ? lockdep_register_key+0x707/0x810
 [ 1818.850221]  ? lockdep_register_key+0x707/0x810
 [ 1818.850978]  kasan_report+0xb9/0xf0
 [ 1818.851604]  ? lockdep_register_key+0x707/0x810
 [ 1818.852381]  lockdep_register_key+0x707/0x810
 [ 1818.853121]  ? add_lock_to_list+0x5b0/0x5b0
 [ 1818.853842]  ? lockdep_init_map_type+0x2c3/0x7a0
 [ 1818.854594]  ? __raw_spin_lock_init+0x3b/0x110
 [ 1818.855329]  alloc_workqueue+0x466/0x1800
 [ 1818.856005]  ? pointer+0x8a0/0x8a0
 [ 1818.856615]  ? workqueue_sysfs_register+0x370/0x370
 [ 1818.857399]  ? vsprintf+0x10/0x10
 [ 1818.857997]  ib_mad_init_device+0x809/0x1760 [ib_core]
 [ 1818.858893]  ? ib_mad_post_receive_mads+0xf20/0xf20 [ib_core]
 [ 1818.859809]  ? rwsem_mark_wake+0x990/0x990
 [ 1818.860505]  ? do_raw_spin_unlock+0x54/0x220
 [ 1818.861224]  add_client_context+0x2e9/0x430 [ib_core]
 [ 1818.862058]  ? ib_unregister_driver+0x1a0/0x1a0 [ib_core]
 [ 1818.862933]  enable_device_and_get+0x1a7/0x340 [ib_core]
 [ 1818.863788]  ? add_client_context+0x430/0x430 [ib_core]
 [ 1818.864643]  ? rdma_counter_init+0x139/0x390 [ib_core]
 [ 1818.865487]  ib_register_device+0x6d0/0xa60 [ib_core]
 [ 1818.866320]  ? alloc_port_data.part.0+0x390/0x390 [ib_core]
 [ 1818.867212]  ? mlx5_lag_is_active+0x7c/0xb0 [mlx5_core]
 [ 1818.868204]  __mlx5_ib_add+0x88/0x1e0 [mlx5_ib]
 [ 1818.868989]  mlx5r_probe+0x1d0/0x3c0 [mlx5_ib]
 [ 1818.869744]  ? __mlx5_ib_add+0x1e0/0x1e0 [mlx5_ib]
 [ 1818.870542]  auxiliary_bus_probe+0xa1/0x110
 [ 1818.871234]  really_probe+0x1e4/0x920
 [ 1818.871862]  __driver_probe_device+0x261/0x3e0
 [ 1818.872609]  driver_probe_device+0x49/0x130
 [ 1818.873311]  __driver_attach+0x215/0x4c0
 [ 1818.873969]  ? __device_attach_driver+0x290/0x290
 [ 1818.874726]  bus_for_each_dev+0xf0/0x170
 [ 1818.875392]  ? lockdep_init_map_type+0x2c3/0x7a0
 [ 1818.876151]  ? bus_remove_file+0x40/0x40
 [ 1818.876820]  bus_add_driver+0x21d/0x5d0
 [ 1818.877472]  driver_register+0x133/0x460
 [ 1818.878138]  __auxiliary_driver_register+0x14e/0x230
 [ 1818.878930]  ? 0xffffffffa07f8000
 [ 1818.879516]  ? 0xffffffffa07f8000
 [ 1818.880110]  mlx5_ib_init+0x111/0x190 [mlx5_ib]
 [ 1818.880879]  do_one_initcall+0xc4/0x3c0
 [ 1818.881532]  ? trace_event_raw_event_initcall_level+0x1f0/0x1f0
 [ 1818.882447]  ? __create_object+0x5e/0x80
 [ 1818.883115]  ? kmalloc_trace_noprof+0x1f9/0x410
 [ 1818.883860]  ? kasan_unpoison+0x23/0x50
 [ 1818.884520]  do_init_module+0x22d/0x740
 [ 1818.885184]  load_module+0x5077/0x6690
 [ 1818.885839]  ? module_frob_arch_sections+0x20/0x20
 [ 1818.886618]  ? kernel_read_file+0x560/0x6c0
 [ 1818.887311]  ? kernel_read_file+0x246/0x6c0
 [ 1818.888005]  ? __x64_sys_fsopen+0x190/0x190
 [ 1818.888708]  ? expand_stack+0x440/0x440
 [ 1818.889367]  ? init_module_from_file+0xd2/0x130
 [ 1818.890102]  init_module_from_file+0xd2/0x130
 [ 1818.890824]  ? __x64_sys_init_module+0xb0/0xb0
 [ 1818.891558]  ? do_raw_spin_unlock+0x54/0x220
 [ 1818.892291]  idempotent_init_module+0x326/0x5a0
 [ 1818.893030]  ? init_module_from_file+0x130/0x130
 [ 1818.893783]  ? security_capable+0x51/0x90
 [ 1818.894461]  __x64_sys_finit_module+0xc1/0x130
 [ 1818.895192]  do_syscall_64+0x6d/0x140
 [ 1818.895818]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 [ 1818.896631] RIP: 0033:0x7f29a2b0af3d
 [ 1818.897254] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bb ee 0e 00 f7 d8 64 89 01 48
 [ 1818.899904] RSP: 002b:00007ffc9cd4cda8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
 [ 1818.901092] RAX: ffffffffffffffda RBX: 00005643c8995670 RCX: 00007f29a2b0af3d
 [ 1818.902157] RDX: 0000000000000000 RSI: 00007f29a31ef32c RDI: 0000000000000011
 [ 1818.903224] RBP: 0000000000020000 R08: 0000000000000000 R09: 0000000000000002
 [ 1818.904292] R10: 0000000000000011 R11: 0000000000000246 R12: 00007f29a31ef32c
 [ 1818.905365] R13: 00005643c89efca0 R14: 0000000000000007 R15: 00005643c8993530
 [ 1818.906431]  </TASK>
 [ 1818.906877]
 [ 1818.907242] Allocated by task 1:
 [ 1818.907819]  kasan_save_stack+0x20/0x40
 [ 1818.908512]  kasan_save_track+0x10/0x30
 [ 1818.909173]  __kasan_slab_alloc+0x51/0x60
 [ 1818.909849]  kmem_cache_alloc_noprof+0x139/0x3f0
 [ 1818.910608]  getname_flags+0x4f/0x3c0
 [ 1818.911236]  do_sys_openat2+0xd3/0x150
 [ 1818.911878]  __x64_sys_openat+0x11f/0x1d0
 [ 1818.912554]  do_syscall_64+0x6d/0x140
 [ 1818.913189]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 [ 1818.913996]
 [ 1818.914359] Freed by task 1:
 [ 1818.914897]  kasan_save_stack+0x20/0x40
 [ 1818.915553]  kasan_save_track+0x10/0x30
 [ 1818.916210]  kasan_save_free_info+0x37/0x50
 [ 1818.916911]  poison_slab_object+0x10c/0x190
 [ 1818.917606]  __kasan_slab_free+0x11/0x30
 [ 1818.918271]  kmem_cache_free+0x12c/0x460
 [ 1818.918939]  do_sys_openat2+0x102/0x150
 [ 1818.919586]  __x64_sys_openat+0x11f/0x1d0
 [ 1818.920264]  do_syscall_64+0x6d/0x140
 [ 1818.920899]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 [ 1818.921699]
 [ 1818.922059] The buggy address belongs to the object at ffff888156864400
 [ 1818.922059]  which belongs to the cache names_cache of size 4096
 [ 1818.923872] The buggy address is located 1320 bytes inside of
 [ 1818.923872]  freed 4096-byte region [ffff888156864400, ffff888156865400)
 [ 1818.925674]
 [ 1818.926034] The buggy address belongs to the physical page:
 [ 1818.926905] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x156860
 [ 1818.928155] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
 [ 1818.929358] flags: 0x200000000000040(head|node=0|zone=2)
 [ 1818.930195] page_type: 0xffffefff(slab)
 [ 1818.930844] raw: 0200000000000040 ffff8881009ab040 dead000000000122 0000000000000000
 [ 1818.932049] raw: 0000000000000000 0000000000070007 00000001ffffefff 0000000000000000
 [ 1818.933277] head: 0200000000000040 ffff8881009ab040 dead000000000122 0000000000000000
 [ 1818.934506] head: 0000000000000000 0000000000070007 00000001ffffefff 0000000000000000
 [ 1818.935728] head: 0200000000000003 ffffea00055a1801 ffffffffffffffff 0000000000000000
 [ 1818.936962] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
 [ 1818.938186] page dumped because: kasan: bad access detected
 [ 1818.939065]
 [ 1818.939429] Memory state around the buggy address:
 [ 1818.940197]  ffff888156864800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 [ 1818.941358]  ffff888156864880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 [ 1818.942504] >ffff888156864900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 [ 1818.943656]                                   ^
 [ 1818.944399]  ffff888156864980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 [ 1818.945564]  ffff888156864a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 [ 1818.946711] ==================================================================

As a solution, let's rewrite the commit mentioned in Fixes line to
properly unwind error without need to flash anything.

Fixes: 643445531829 ("workqueue: Fix UAF report by KASAN in pwq_release_workfn()")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 kernel/workqueue.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 003474c9a77d..c3df0a1f908b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5454,7 +5454,7 @@ static void wq_update_pod(struct workqueue_struct *wq, int cpu,
 static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 {
 	bool highpri = wq->flags & WQ_HIGHPRI;
-	int cpu, ret;
+	int cpu, ret = -ENOMEM;
 
 	wq->cpu_pwq = alloc_percpu(struct pool_workqueue *);
 	if (!wq->cpu_pwq)
@@ -5502,14 +5502,10 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 		ret = apply_workqueue_attrs(wq, unbound_std_wq_attrs[highpri]);
 	}
 	cpus_read_unlock();
-
-	/* for unbound pwq, flush the pwq_release_worker ensures that the
-	 * pwq_release_workfn() completes before calling kfree(wq).
-	 */
 	if (ret)
-		kthread_flush_worker(pwq_release_worker);
+		goto enomem;
 
-	return ret;
+	return 0;
 
 enomem:
 	if (wq->cpu_pwq) {
@@ -5522,7 +5518,7 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 		free_percpu(wq->cpu_pwq);
 		wq->cpu_pwq = NULL;
 	}
-	return -ENOMEM;
+	return ret;
 }
 
 static int wq_clamp_max_active(int max_active, unsigned int flags,
@@ -5714,7 +5710,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 			goto err_unreg_lockdep;
 	}
 
-	if (alloc_and_link_pwqs(wq) < 0)
+	if (alloc_and_link_pwqs(wq))
 		goto err_free_node_nr_active;
 
 	if (wq_online && init_rescuer(wq) < 0)
-- 
2.45.1


