Return-Path: <linux-rdma+bounces-20744-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOgPMB9oBmrOjQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20744-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 02:26:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7FA54800F
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 02:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C9BA3025D21
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 00:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882CA1F1534;
	Fri, 15 May 2026 00:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oytT8bGg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E4E25776
	for <linux-rdma@vger.kernel.org>; Fri, 15 May 2026 00:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778804761; cv=none; b=V3Vi2IzSeJMzk52FwyZCNMagktxqbDt28ajXNZIH0krViZMQmNJU/AqraFiZd16Uh/1JQ54RbRIRyRLwbPfq+2XvldFFG5TlDIyhgoHC2XwFi6++OKEwPRFFCNl/A/n6pBRA0wBSXNpQjMRSIC92H3uYyOB+L3+OTshVopSMyVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778804761; c=relaxed/simple;
	bh=Qm/j1imBLx9vDVyCC10Q1+LcbKaLu1/tsJg39ep81Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JyZylLgfy0NA1lDhp7u3aRFl4kjKgPTSxmRnlH6l7YB3Q66+77TIhSHQJ0TdPay+7vZgE7mtOT7aMXHNGupvpJGio02OJT3cPny89jcaya1AcN/1WFaRHJ/mvdza70argnMeHYPxnJ/MbgYDME8/n8evYJAnCJKI4zhGkmRMfPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oytT8bGg; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778804755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j04E4w4xG2fmjOdwriHP6vNP8rwzFBg8dUP+TAaXRzI=;
	b=oytT8bGg5eMB+bTC0qogJjqmsY6S5UUTXIA0ZJYFUT0cvCR0z87KOxs0hIBrR5QV+7jGyA
	kcU33X7D/NnwN0f6nTTf5wV3jCHfKCbf0bu7Rdv9GlHzjhiHP1TxJ0+J2WFyvGzydDAnVJ
	+MXUangB2pTCxWAuOablnbXWyFTLWps=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>,
	nasm <n4sm@protonmail.com>
Subject: [PATCH 1/1] RDMA/rxe: Fix a use-after-free problem in rxe_mmap
Date: Fri, 15 May 2026 02:25:37 +0200
Message-ID: <20260515002537.6209-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: BF7FA54800F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20744-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,protonmail.com];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[protonmail.com:email,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action

rxe_mmap() removes a rxe_mmap_info struct from the pending_mmaps list
and releases pending_lock while the struct's kref is still at 1:
"
   list_del_init(&ip->pending_mmaps);
   spin_unlock_bh(&rxe->pending_lock);   /* ref == 1, no lock held */
   ret = remap_vmalloc_range(vma, ip->obj, 0);  /* walks PTEs */
   [...]
   rxe_vma_open(vma);                    /* kref_get, ref → 2 */
   remap_vmalloc_range_partial() walks PTEs without any lock.
"

A concurrent DESTROY_CQ ioctl on another CPU calls:
"
   → kref_put(&q->ip->ref, rxe_mmap_release)   /* ref 1→0 */
   → vfree(ip->obj)   /* clears vmalloc PTEs mid-walk */
   → kfree(ip)        /* frees rxe_mmap_info */
"
   This yields:

   1. Kernel crash, vmalloc_to_page() returns NULL when vfree wins the
   per-PTE race → vm_insert_page(NULL) → GPF in validate_page_before_insert

   2. Page UAF, vmalloc_to_page() reads a stale PTE before vfree clears it
   → user VMA holds a PTE to a free'd page which might eventually get
   reallocated later by vmalloc which allows the attacker to get a clean
   page-level UAF.

   It is worth noting that even though a page-level UAF is possible given
   the strong primitive, it is statistically very difficult to achieve
   given the very short time window (after the last insert_page and before
   the kref_get).

The call trace are as below:

  [   67.916353] Oops: general protection fault, probably for
   non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI

   [   67.916865] KASAN: null-ptr-deref in range
   [0x0000000000000008-0x000000000000000f]

   [   67.917755] CPU: 0 UID: 1000 PID: 413 Comm: poc Not tainted
   7.0.0-rc5-dirty #28 PREEMPT(lazy)

   [   67.918164] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
   BIOS 1.15.0-1 04/01/2014

   [   67.918512] RIP: 0010:validate_page_before_insert+0x32/0x300

   [   67.919173] Code: e5 41 57 41 56 49 89 fe 41 55 41 54 53 48 89 f3 e8
   93 b5 a3 ff 48 8d 7b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea
   03 <80> 3c 02 00 0f 85 7b 02 00 00 4c 8b 63 08 31 ff 4d 89 e5 41 83 e5

   [   67.919645] RSP: 0018:ffff88811b15f2f0 EFLAGS: 00000202

   [   67.919919] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
   0000000000000000

   [   67.920125] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
   0000000000000008

   [   67.920356] RBP: ffff88811b15f318 R08: 0000000000000000 R09:
   0000000000000000

   [   67.920599] R10: 0000000000000000 R11: 0000000000000000 R12:
   ffff8881181eee00

   [   67.920822] R13: 0000000000000000 R14: ffff8881181eee00 R15:
   ffff8881181eee20

   [   67.921073] FS:  00007b1e000f76c0(0000) GS:ffff8884268e0000(0000)
   knlGS:0000000000000000

   [   67.921335] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

   [   67.921543] CR2: 00007b1e00a24ac0 CR3: 0000000116eb3000 CR4:
   00000000000006f0

   [   67.921881] Call Trace:
   [   67.922064]  <TASK>
   [   67.922339]  insert_page+0x8f/0x190
   [   67.922681]  ? __pfx_insert_page+0x10/0x10
   [   67.922916]  ? kasan_save_alloc_info+0x38/0x60
   [   67.923149]  vm_insert_page+0x2e7/0x400
   [   67.923405]  remap_vmalloc_range_partial+0x212/0x3e0
   [   67.923662]  remap_vmalloc_range+0x6e/0xb0
   [   67.923883]  ? __kasan_check_write+0x14/0x30
   [   67.924096]  rxe_mmap+0x2e9/0x5d0
   [   67.924289]  ib_uverbs_mmap+0x1ad/0x2c0
   [   67.924492]  __mmap_region+0x12c2/0x2ad0
   [   67.924736]  ? __pfx___mmap_region+0x10/0x10
   [   67.924956]  ? __sanitizer_cov_trace_switch+0x58/0xb0
   [   67.925188]  ? mas_prev_slot+0x360/0x39c0
   [   67.925419]  ? __sanitizer_cov_trace_switch+0x58/0xb0
   [   67.925660]  ? mas_next_slot+0x1e5b/0x2f40
   [   67.925904]  ? __sanitizer_cov_trace_cmp8+0x18/0x30
   [   67.926132]  ? unmapped_area_topdown+0x4dd/0x610
   [   67.926381]  ? kfree+0x1b1/0x440
   [   67.926634]  ? free_cpumask_var+0x16/0x30
   [   67.926844]  ? __kasan_slab_free+0x7d/0xa0
   [   67.927079]  ? __sanitizer_cov_trace_cmp8+0x18/0x30
   [   67.927353]  mmap_region+0x2e6/0x3c0
   [   67.927560]  do_mmap+0xa3e/0x12a0
   [   67.927776]  ? __pfx_do_mmap+0x10/0x10
   [   67.927991]  ? __kasan_check_write+0x14/0x30
   [   67.928224]  ? down_write_killable+0xba/0x160
   [   67.928451]  ? __pfx_down_write_killable+0x10/0x10
   [   67.928657]  ? __sanitizer_cov_trace_cmp4+0x16/0x30
   [   67.928908]  vm_mmap_pgoff+0x2d4/0x4a0
   [   67.929138]  ? __pfx_vm_mmap_pgoff+0x10/0x10
   [   67.929398]  ? fget+0x1bf/0x270
   [   67.929594]  ksys_mmap_pgoff+0x40c/0x690
   [   67.929814]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x30
   [   67.930058]  ? __pfx_ksys_mmap_pgoff+0x10/0x10
   [   67.930273]  ? __kasan_check_write+0x14/0x30
   [   67.930495]  ? _raw_spin_trylock+0xbb/0x130
   [   67.930706]  ? __pfx__raw_spin_trylock+0x10/0x10
   [   67.930932]  __x64_sys_mmap+0x135/0x1e0
   [   67.931142]  x64_sys_call+0x1c14/0x2790
   [   67.931385]  do_syscall_64+0xd2/0x1050
   [   67.931588]  ? rcu_core+0x352/0x7d0
   [   67.931819]  ? rcu_core_si+0xe/0x20
   [   67.932061]  ? handle_softirqs+0x1aa/0x650
   [   67.932313]  ? __sanitizer_cov_trace_cmp4+0x16/0x30
   [   67.932550]  ? fpregs_assert_state_consistent+0xe1/0x160
   [   67.932800]  ? irqentry_exit+0xb1/0x670
   [   67.933026]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
   [   67.933285] RIP: 0033:0x7b1e00a08e22
   [   67.933955] Code: 00 00 00 0f 1f 44 00 00 41 f7 c1 ff 0f 00 00 75 27
   55 89 cd 53 48 89 fb 48 85 ff 74 3b 41 89 ea 48 89 df b8 09 00 00 00 0f
   05 <48> 3d 00 f0 ff ff 77 76 5b 5d c3 0f 1f 00 48 8b 05 b9 7f 0d 00 64
   [   67.934388] RSP: 002b:00007b1e000f6dd8 EFLAGS: 00000246 ORIG_RAX:
   0000000000000009
   [   67.934683] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
   00007b1e00a08e22
   [   67.934896] RDX: 0000000000000003 RSI: 0000000000005000 RDI:
   0000000000000000
   [   67.935097] RBP: 0000000000000001 R08: 0000000000000003 R09:
   0000000000006000
   [   67.935296] R10: 0000000000000001 R11: 0000000000000246 R12:
   0000000000000021
   [   67.935496] R13: 0000000000000018 R14: 00007ffe0e245730 R15:
   00007b1dff8f7000
   [   67.935751]  </TASK>

   [   67.935915] Modules linked in:
   [   67.936701] ---[ end trace 0000000000000000 ]---
   [   67.937421] RIP: 0010:validate_page_before_insert+0x32/0x300
   [   67.937729] Code: e5 41 57 41 56 49 89 fe 41 55 41 54 53 48 89 f3 e8
   93 b5 a3 ff 48 8d 7b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea
   03 <80> 3c 02 00 0f 85 7b 02 00 00 4c 8b 63 08 31 ff 4d 89 e5 41 83 e5
   [   67.938129] RSP: 0018:ffff88811b15f2f0 EFLAGS: 00000202
   [   67.938486] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
   0000000000000000
   [   67.938708] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
   0000000000000008
   [   67.938954] RBP: ffff88811b15f318 R08: 0000000000000000 R09:
   0000000000000000
   [   67.939157] R10: 0000000000000000 R11: 0000000000000000 R12:
   ffff8881181eee00
   [   67.939446] R13: 0000000000000000 R14: ffff8881181eee00 R15:
   ffff8881181eee20
   [   67.939660] FS:  00007b1e000f76c0(0000) GS:ffff8884268e0000(0000)
   knlGS:0000000000000000
   [   67.939889] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   [   67.940079] CR2: 00007b1e00a24ac0 CR3: 0000000116eb3000 CR4:
   00000000000006f0

Reported-and-tested-by: nasm <n4sm@protonmail.com>
Suggested-by: nasm <n4sm@protonmail.com>
Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_mmap.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mmap.c b/drivers/infiniband/sw/rxe/rxe_mmap.c
index db380302149e..3407785c582c 100644
--- a/drivers/infiniband/sw/rxe/rxe_mmap.c
+++ b/drivers/infiniband/sw/rxe/rxe_mmap.c
@@ -93,18 +93,29 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 	goto done;
 
 found_it:
+	/* Increment refcount and check whether it is being freed atm while
+	 * holding lock to prevent UAF */
+	if (!kref_get_unless_zero(&ip->ref)) {
+		spin_unlock_bh(&rxe->pending_lock);
+		ret = -ENXIO;
+		goto done;
+	}
+
 	list_del_init(&ip->pending_mmaps);
 	spin_unlock_bh(&rxe->pending_lock);
 
+	vma->vm_ops = &rxe_vm_ops;
+	vma->vm_private_data = ip;
+
 	ret = remap_vmalloc_range(vma, ip->obj, 0);
 	if (ret) {
+		vma->vm_private_data = NULL;
+		vma->vm_ops = NULL;
+		kref_put(&ip->ref, rxe_mmap_release);
 		rxe_dbg_dev(rxe, "err %d from remap_vmalloc_range\n", ret);
 		goto done;
 	}
 
-	vma->vm_ops = &rxe_vm_ops;
-	vma->vm_private_data = ip;
-	rxe_vma_open(vma);
 done:
 	return ret;
 }
-- 
2.43.0


