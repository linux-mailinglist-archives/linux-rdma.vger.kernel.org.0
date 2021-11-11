Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06ACB44D606
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Nov 2021 12:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhKKLr4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Nov 2021 06:47:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230358AbhKKLrz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Nov 2021 06:47:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F35EB61261;
        Thu, 11 Nov 2021 11:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636631106;
        bh=cxxjYHRSK8HBzFRFlHnXvXqJzZ8JUHisCwGFasAr9xI=;
        h=From:To:Cc:Subject:Date:From;
        b=aoa3LmNGNKHfXBVDWotnWOstCTwhGCbyds2LH2w4PAI/AK3UUN2IFAWn1GkYTLpyN
         5nkXxdOaRBgI03kz+5YsfConZ+EaGwZ4KPbsn8zUxImfVUdjIFCDx4B4hCqbVDGYxh
         L3z9LtZKo4AodejFMT0qwB4hXlqlwad+HuGcg1DI7wzjmLw/cG46Y3ypAwstbDoUd1
         Aod2AU9xLR6im+cKTx6yU1GsKdoffVQjXhYE6khEJExBSspL0LdbewjCb+EKoJ1lgI
         Sylx2dfWOitf1Ew4HePcxrLk+4V3GRj1aNrzpAj5EMz6lf8k3j9vRw56D6oQSs+gzJ
         Btn0B4UBVrSxA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] RDMA/core: Set send and receive CQ before forwarding to the driver
Date:   Thu, 11 Nov 2021 13:45:00 +0200
Message-Id: <2dbb2e2cbb1efb188a500e5634be1d71956424ce.1636631035.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Preset both receive and send CQ pointers prior to call to the drivers and
overwrite it later again till the mlx4 is going to be changed do not overwrite
ibqp properties.

This change is needed for mlx5, because in case of QP creation failure,
it will go to the path of QP destroy which relies on proper CQ pointers.

 ==================================================================
 BUG: KASAN: use-after-free in create_qp.cold+0x164/0x16e [mlx5_ib]
 Write of size 8 at addr ffff8880064c55c0 by task a.out/246

 CPU: 0 PID: 246 Comm: a.out Not tainted 5.15.0+ #291
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 Call Trace:
  dump_stack_lvl+0x45/0x59
  print_address_description.constprop.0+0x1f/0x140
  ? create_qp.cold+0x164/0x16e [mlx5_ib]
  kasan_report.cold+0x83/0xdf
  ? create_qp.cold+0x164/0x16e [mlx5_ib]
  create_qp.cold+0x164/0x16e [mlx5_ib]
  ? lock_acquire+0x1a9/0x4a0
  ? __might_fault+0x8f/0x160
  ? lock_is_held_type+0x98/0x110
  ? _create_user_qp.constprop.0+0x18a0/0x18a0 [mlx5_ib]
  ? rcu_read_lock_sched_held+0x3f/0x70
  ? __module_address.part.0+0x25/0x300
  ? is_kernel_percpu_address+0x7d/0x100
  ? static_obj+0x8a/0xc0
  ? lockdep_init_map_type+0x2c3/0x780
  ? __raw_spin_lock_init+0x3b/0x110
  mlx5_ib_create_qp+0x358/0x28a0 [mlx5_ib]
  ? create_qp+0xc210/0xc210 [mlx5_ib]
  ? __module_address.part.0+0x25/0x300
  create_qp.part.0+0x45b/0x6a0 [ib_core]
  ib_create_qp_user+0x97/0x150 [ib_core]
  ib_uverbs_handler_UVERBS_METHOD_QP_CREATE+0x92c/0x1250 [ib_uverbs]
  ? _uverbs_copy_from+0x120/0x120 [ib_uverbs]
  ? lock_downgrade+0x6d0/0x6d0
  ? lock_acquire+0x1a9/0x4a0
  ? __might_fault+0x8f/0x160
  ? ib_uverbs_cq_event_handler+0x120/0x120 [ib_uverbs]
  ? uverbs_fill_udata+0x103/0x510 [ib_uverbs]
  ib_uverbs_cmd_verbs+0x1c38/0x3150 [ib_uverbs]
  ? _uverbs_copy_from+0x120/0x120 [ib_uverbs]
  ? __kernel_text_address+0xe/0x30
  ? unwind_get_return_address+0x56/0xa0
  ? xfer_to_guest_mode_handle_work+0xd0/0xd0
  ? uverbs_fill_udata+0x510/0x510 [ib_uverbs]
  ? __lock_acquire+0xbec/0x5a40
  ? kmem_cache_free+0xb1/0x2e0
  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
  ? kasan_save_stack+0x1b/0x40
  ? lock_acquire+0x1a9/0x4a0
  ? lock_acquire+0x1a9/0x4a0
  ? ib_uverbs_ioctl+0x11e/0x260 [ib_uverbs]
  ? __might_fault+0xba/0x160
  ? lock_release+0x6c0/0x6c0
  ? ib_uverbs_ioctl+0x19c/0x260 [ib_uverbs]
  ib_uverbs_ioctl+0x169/0x260 [ib_uverbs]
  ? ib_uverbs_ioctl+0x11e/0x260 [ib_uverbs]
  ? ib_uverbs_cmd_verbs+0x3150/0x3150 [ib_uverbs]
  ? kasan_quarantine_put+0x78/0x1b0
  ? trace_hardirqs_on+0x32/0x120
  ? kasan_quarantine_put+0x78/0x1b0
  __x64_sys_ioctl+0x866/0x14d0
  ? rcu_read_lock_sched_held+0x3f/0x70
  ? do_sys_openat2+0x10a/0x400
  ? vfs_fileattr_set+0x9f0/0x9f0
  ? do_sys_openat2+0x10a/0x400
  ? build_open_flags+0x450/0x450
  ? vfs_write+0x470/0x8e0
  ? __x64_sys_openat+0x11f/0x1d0
  ? __x64_sys_open+0x1a0/0x1a0
  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
  ? syscall_enter_from_user_mode+0x1d/0x50
  do_syscall_64+0x3d/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xae
 RIP: 0033:0x7fdafc4f2e0d
 Code: c8 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 3b 80 0c 00 f7 d8 64 89 01 48
 RSP: 002b:00007ffc1e7ee158 EFLAGS: 00000286 ORIG_RAX: 0000000000000010
 RAX: ffffffffffffffda RBX: 0000000000402b40 RCX: 00007fdafc4f2e0d
 RDX: 0000000020000980 RSI: 00000000c0181b01 RDI: 0000000000000003
 RBP: 00007ffc1e7ee170 R08: 00007ffc1e7ee260 R09: 00007ffc1e7ee260
 R10: 00007ffc1e7ee260 R11: 0000000000000286 R12: 0000000000401050
 R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

 Allocated by task 246:
  kasan_save_stack+0x1b/0x40
  __kasan_kmalloc+0xa4/0xd0
  create_qp.part.0+0x92/0x6a0 [ib_core]
  ib_create_qp_user+0x97/0x150 [ib_core]
  ib_uverbs_handler_UVERBS_METHOD_QP_CREATE+0x92c/0x1250 [ib_uverbs]
  ib_uverbs_cmd_verbs+0x1c38/0x3150 [ib_uverbs]
  ib_uverbs_ioctl+0x169/0x260 [ib_uverbs]
  __x64_sys_ioctl+0x866/0x14d0
  do_syscall_64+0x3d/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xae

 Freed by task 246:
  kasan_save_stack+0x1b/0x40
  kasan_set_track+0x1c/0x30
  kasan_set_free_info+0x20/0x30
  __kasan_slab_free+0x10c/0x150
  slab_free_freelist_hook+0xb4/0x1b0
  kfree+0xe7/0x2a0
  create_qp.part.0+0x52b/0x6a0 [ib_core]
  ib_create_qp_user+0x97/0x150 [ib_core]
  ib_uverbs_handler_UVERBS_METHOD_QP_CREATE+0x92c/0x1250 [ib_uverbs]
  ib_uverbs_cmd_verbs+0x1c38/0x3150 [ib_uverbs]
  ib_uverbs_ioctl+0x169/0x260 [ib_uverbs]
  __x64_sys_ioctl+0x866/0x14d0
  do_syscall_64+0x3d/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xae

 Last potentially related work creation:
  kasan_save_stack+0x1b/0x40
  kasan_record_aux_stack+0xc7/0xd0
  insert_work+0x44/0x280
  __queue_work+0x4e3/0xd30
  queue_work_on+0x69/0x80
  tty_release_struct+0xa6/0xd0
  tty_release+0x9bb/0xef0
  __fput+0x1fe/0x8d0
  task_work_run+0xc5/0x160
  exit_to_user_mode_prepare+0x1d4/0x1e0
  syscall_exit_to_user_mode+0x19/0x50
  do_syscall_64+0x4a/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xae

 Second to last potentially related work creation:
  kasan_save_stack+0x1b/0x40
  kasan_record_aux_stack+0xc7/0xd0
  insert_work+0x44/0x280
  __queue_work+0x4e3/0xd30
  queue_work_on+0x69/0x80
  tty_release_struct+0xa6/0xd0
  tty_release+0x9bb/0xef0
  __fput+0x1fe/0x8d0
  task_work_run+0xc5/0x160
  exit_to_user_mode_prepare+0x1d4/0x1e0
  syscall_exit_to_user_mode+0x19/0x50
  do_syscall_64+0x4a/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xae

 The buggy address belongs to the object at ffff8880064c5000
  which belongs to the cache kmalloc-2k of size 2048
 The buggy address is located 1472 bytes inside of
  2048-byte region [ffff8880064c5000, ffff8880064c5800)
 The buggy address belongs to the page:
 page:000000006ea34cf4 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x64c0
 head:000000006ea34cf4 order:3 compound_mapcount:0 compound_pincount:0
 flags: 0x4000000000010200(slab|head|zone=1)
 raw: 4000000000010200 ffffea0000571c00 0000000200000002 ffff888005042f00
 raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ffff8880064c5480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880064c5500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 >ffff8880064c5580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                            ^
  ffff8880064c5600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880064c5680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ==================================================================
 Disabling lock debugging due to kernel taint

Fixes: 514aee660df4 ("RDMA: Globally allocate and release QP memory")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/verbs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 692d5ff657df..c18634bec212 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1232,6 +1232,9 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
 	INIT_LIST_HEAD(&qp->rdma_mrs);
 	INIT_LIST_HEAD(&qp->sig_mrs);
 
+	qp->send_cq = attr->send_cq;
+	qp->recv_cq = attr->recv_cq;
+
 	rdma_restrack_new(&qp->res, RDMA_RESTRACK_QP);
 	WARN_ONCE(!udata && !caller, "Missing kernel QP owner");
 	rdma_restrack_set_name(&qp->res, udata ? NULL : caller);
-- 
2.33.1

