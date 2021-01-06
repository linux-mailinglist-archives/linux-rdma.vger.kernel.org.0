Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396852EBD9C
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jan 2021 13:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbhAFMW7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Jan 2021 07:22:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:58746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbhAFMW6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 Jan 2021 07:22:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 171932312E;
        Wed,  6 Jan 2021 12:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609935737;
        bh=l6mAHeO2hPyGL3rD8YUubEsj4ZlRDz99387tj63HLWo=;
        h=From:To:Cc:Subject:Date:From;
        b=fhqK3yzgocKjezWo4ONPjm6IEY1++gMeteSe5C27gKHEC2KN/2Q/iy9RI/RIpencV
         k9fdCOxog1IaaoJYXtSrQcsEuqrspM8CUXkeej3O6s+v5XResrpMYUXe472uBSOMKY
         3m8lQiQa1Mdd3b8YiPaF+SqVFlSFuTAaAywsu3x39kaAZlfwds8eDNqvpMFnvcg/XJ
         cLn0fq6PL8FWhhdQGzKh47YvHyxWoTPZAk+xX2J7xpZSaO/KDRb4Dhlt+bZYsZoikW
         kX5+U3iCd1zg3hCl6vj2CGP0u57NTRQ6GqtioeDzyGtDP9N4kNjxBhbsFFbz/HEX+J
         baYiutOgawwUg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Avihai Horon <avihaih@nvidia.com>,
        Amit Matityahu <mitm@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] RDMA/ucma: Fix use-after-free bug in ucma_create_uevent
Date:   Wed,  6 Jan 2021 14:22:12 +0200
Message-Id: <20210106122212.498789-1-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

ucma_process_join() allocates struct ucma_multicast mc and frees it if an
error occurs during its run.
Specifically, if an error occurs in copy_to_user(), a use-after-free
might happen in the following scenario:

1. mc struct is allocated.
2. rdma_join_multicast() is called and succeeds. During its run,
   rdma_join_multicast() enqueues a work that will later use the
   aforementioned mc struct.
3. copy_to_user() is called and fails.
4. mc struct is deallocated.
5. The work that was enqueued by rdma_join_multicast() is run and calls
   ucma_create_uevent() which tries to access mc struct (which is freed
   by now).

We fix this bug by flushing the cma_wq workqueue.

The following syzkaller report revealed it:

BUG: KASAN: use-after-free in ucma_create_uevent+0x2dd/0&times;3f0 drivers/infiniband/core/ucma.c:272
Read of size 8 at addr ffff88810b3ad110 by task kworker/u8:1/108
 
CPU: 1 PID: 108 Comm: kworker/u8:1 Not tainted 5.10.0-rc6+ #257
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Workqueue: rdma_cm cma_work_handler
Call Trace:
__dump_stack lib/dump_stack.c:77 [inline]
dump_stack+0xbe/0xf9 lib/dump_stack.c:118
print_address_description.constprop.0+0x3e/0×60 mm/kasan/report.c:385
__kasan_report mm/kasan/report.c:545 [inline]
kasan_report.cold+0x1f/0×37 mm/kasan/report.c:562
ucma_create_uevent+0x2dd/0×3f0 drivers/infiniband/core/ucma.c:272
ucma_event_handler+0xb7/0×3c0 drivers/infiniband/core/ucma.c:349
cma_cm_event_handler+0x5d/0×1c0 drivers/infiniband/core/cma.c:1977
cma_work_handler+0xfa/0×190 drivers/infiniband/core/cma.c:2718
process_one_work+0x54c/0×930 kernel/workqueue.c:2272
worker_thread+0x82/0×830 kernel/workqueue.c:2418
kthread+0x1ca/0×220 kernel/kthread.c:292
ret_from_fork+0x1f/0×30 arch/x86/entry/entry_64.S:296

Allocated by task 359:
kasan_save_stack+0x1b/0×40 mm/kasan/common.c:48
kasan_set_track mm/kasan/common.c:56 [inline]
__kasan_kmalloc mm/kasan/common.c:461 [inline]
__kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:434
kmalloc include/linux/slab.h:552 [inline]
kzalloc include/linux/slab.h:664 [inline]
ucma_process_join+0x16e/0×3f0 drivers/infiniband/core/ucma.c:1453
ucma_join_multicast+0xda/0×140 drivers/infiniband/core/ucma.c:1538
ucma_write+0x1f7/0×280 drivers/infiniband/core/ucma.c:1724
vfs_write fs/read_write.c:603 [inline]
vfs_write+0x191/0×4c0 fs/read_write.c:585
ksys_write+0x1a1/0×1e0 fs/read_write.c:658
do_syscall_64+0x2d/0×40 arch/x86/entry/common.c:46
entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 359:
kasan_save_stack+0x1b/0×40 mm/kasan/common.c:48
kasan_set_track+0x1c/0×30 mm/kasan/common.c:56
kasan_set_free_info+0x1b/0×30 mm/kasan/generic.c:355
__kasan_slab_free+0x112/0×160 mm/kasan/common.c:422
slab_free_hook mm/slub.c:1544 [inline]
slab_free_freelist_hook mm/slub.c:1577 [inline]
slab_free mm/slub.c:3142 [inline]
kfree+0xb3/0×3e0 mm/slub.c:4124
ucma_process_join+0x22d/0×3f0 drivers/infiniband/core/ucma.c:1497
ucma_join_multicast+0xda/0×140 drivers/infiniband/core/ucma.c:1538
ucma_write+0x1f7/0×280 drivers/infiniband/core/ucma.c:1724
vfs_write fs/read_write.c:603 [inline]
vfs_write+0x191/0×4c0 fs/read_write.c:585
ksys_write+0x1a1/0×1e0 fs/read_write.c:658
do_syscall_64+0x2d/0×40 arch/x86/entry/common.c:46
entry_SYSCALL_64_after_hwframe+0x44/0xa9
The buggy address belongs to the object at ffff88810b3ad100
which belongs to the cache kmalloc-192 of size 192
The buggy address is located 16 bytes inside of
192-byte region [ffff88810b3ad100, ffff88810b3ad1c0)

The buggy address belongs to the page:
page:00000000796da98e refcount:1 mapcount:0 mapping:0000000000000000
index:0×0 pfn:0×10b3ad
flags: 0×8000000000000200(slab)
raw: 8000000000000200 dead000000000100 dead000000000122 ffff888100043540
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
Memory state around the buggy address:
ffff88810b3ad000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff88810b3ad080: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
>ffff88810b3ad100: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
^
ffff88810b3ad180: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
ffff88810b3ad200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

Fixes: c8f6a362bf3e ("RDMA/cma: Add multicast communication support")
Reported-by: Amit Matityahu <mitm@nvidia.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c  | 6 ++++++
 drivers/infiniband/core/ucma.c | 7 +++++++
 include/rdma/rdma_cm.h         | 2 ++
 3 files changed, 15 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index e17ba841e204..9b24ea0276a5 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -172,6 +172,12 @@ static DEFINE_MUTEX(lock);
 static struct workqueue_struct *cma_wq;
 static unsigned int cma_pernet_id;

+void cma_flush_wq(void)
+{
+	flush_workqueue(cma_wq);
+}
+EXPORT_SYMBOL(cma_flush_wq);
+
 struct cma_pernet {
 	struct xarray tcp_ps;
 	struct xarray udp_ps;
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index da2512c30ffd..d6cd72ff213b 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1430,6 +1430,12 @@ static ssize_t ucma_notify(struct ucma_file *file, const char __user *inbuf,
 	return ret;
 }

+static void ucma_flush_wq(struct rdma_cm_id *id)
+{
+	if (rdma_protocol_roce(id->device, id->port_num))
+		cma_flush_wq();
+}
+
 static ssize_t ucma_process_join(struct ucma_file *file,
 				 struct rdma_ucm_join_mcast *cmd,  int out_len)
 {
@@ -1495,6 +1501,7 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 	return 0;

 err_leave_multicast:
+	ucma_flush_wq(ctx->cm_id);
 	mutex_lock(&ctx->mutex);
 	rdma_leave_multicast(ctx->cm_id, (struct sockaddr *) &mc->addr);
 	mutex_unlock(&ctx->mutex);
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index 32a67af18415..9b10ae4e8ff8 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -377,4 +377,6 @@ void rdma_read_gids(struct rdma_cm_id *cm_id, union ib_gid *sgid,
 struct iw_cm_id *rdma_iw_cm_id(struct rdma_cm_id *cm_id);
 struct rdma_cm_id *rdma_res_to_id(struct rdma_restrack_entry *res);

+void cma_flush_wq(void);
+
 #endif /* RDMA_CM_H */
--
2.29.2

