Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00DBB85C99
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2019 10:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbfHHIPo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Aug 2019 04:15:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731281AbfHHIPo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Aug 2019 04:15:44 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F26A52187F;
        Thu,  8 Aug 2019 08:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565252143;
        bh=7l+Revhy61U0YPSvsDYCuYATZBLiuA6R/YIQ1f5tHtI=;
        h=From:To:Cc:Subject:Date:From;
        b=MZpPBMY5DL0ONGDENPE6BNZ2rchXJ/ZVtVZAqXkd3Dkf6J0U/lMqz1z0du172OiyG
         ex2L4Ljq5S/k32EZaaS+fAHtzHce+scwVOJQSOv3iK9vKu9gcgd9KUWpNiSyDHsATx
         M4tnCNbRCtdkE4xkaB9bnUDIH5JcXvBZ9ZvFO8+k=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-rc] IB/mlx5: Fix use-after-free error while accessing ev_file pointer
Date:   Thu,  8 Aug 2019 11:15:38 +0300
Message-Id: <20190808081538.28772-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Call to uverbs_close_fd() releases file pointer to 'ev_file' and
mlx5_ib_dev is going to be inaccessible. Cache pointer prior cleaning
resources to solve the KASAN warning below.

BUG: KASAN: use-after-free in devx_async_event_close+0x391/0x480 [mlx5_ib]
Read of size 8 at addr ffff888301e3cec0 by task devx_direct_tes/4631
CPU: 1 PID: 4631 Comm: devx_direct_tes Tainted: G OE 5.3.0-rc1-for-upstream-dbg-2019-07-26_01-19-56-93 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu2 04/01/2014
Call Trace:
dump_stack+0x9a/0xeb
print_address_description+0x1e2/0x400
? devx_async_event_close+0x391/0x480 [mlx5_ib]
__kasan_report+0x15c/0x1df
? devx_async_event_close+0x391/0x480 [mlx5_ib]
kasan_report+0xe/0x20
devx_async_event_close+0x391/0x480 [mlx5_ib]
__fput+0x26a/0x7b0
task_work_run+0x10d/0x180
exit_to_usermode_loop+0x137/0x160
do_syscall_64+0x3c7/0x490
entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f5df907d664
Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f
80 00 00 00 00 8b 05 6a cd 20 00 48 63 ff 85 c0 75 13 b8
03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 44 f3 c3 66 90
48 83 ec 18 48 89 7c 24 08 e8
RSP: 002b:00007ffd353cb958 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 000056017a88c348 RCX: 00007f5df907d664
RDX: 00007f5df969d400 RSI: 00007f5de8f1ec90 RDI: 0000000000000006
RBP: 00007f5df9681dc0 R08: 00007f5de8736410 R09: 000056017a9d2dd0
R10: 000000000000000b R11: 0000000000000246 R12: 00007f5de899d7d0
R13: 00007f5df96c4248 R14: 00007f5de8f1ecb0 R15: 000056017ae41308

Allocated by task 4631:
save_stack+0x19/0x80
kasan_kmalloc.constprop.3+0xa0/0xd0
alloc_uobj+0x71/0x230 [ib_uverbs]
alloc_begin_fd_uobject+0x2e/0xc0 [ib_uverbs]
rdma_alloc_begin_uobject+0x96/0x140 [ib_uverbs]
ib_uverbs_run_method+0xdf0/0x1940 [ib_uverbs]
ib_uverbs_cmd_verbs+0x57e/0xdb0 [ib_uverbs]
ib_uverbs_ioctl+0x177/0x260 [ib_uverbs]
do_vfs_ioctl+0x18f/0x1010
ksys_ioctl+0x70/0x80
__x64_sys_ioctl+0x6f/0xb0
do_syscall_64+0x95/0x490
entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 4631:
save_stack+0x19/0x80
__kasan_slab_free+0x11d/0x160
slab_free_freelist_hook+0x67/0x1a0
kfree+0xb9/0x2a0
uverbs_close_fd+0x118/0x1c0 [ib_uverbs]
devx_async_event_close+0x28a/0x480 [mlx5_ib]
__fput+0x26a/0x7b0
task_work_run+0x10d/0x180
exit_to_usermode_loop+0x137/0x160
do_syscall_64+0x3c7/0x490
entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff888301e3cda8
which belongs to the cache kmalloc-512 of size 512
The buggy address is located 280 bytes inside of 512-byte region
[ffff888301e3cda8, ffff888301e3cfa8)
The buggy address belongs to the page:
page:ffffea000c078e00 refcount:1 mapcount:0
mapping:ffff888352811300 index:0x0 compound_mapcount: 0
flags: 0x2fffff80010200(slab|head)
raw: 002fffff80010200 ffffea000d152608 ffffea000c077808 ffff888352811300
raw: 0000000000000000 0000000000250025 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
Memory state around the buggy address:
ffff888301e3cd80: fc fc fc fc fc fb fb fb fb fb fb fb fb fb fb fb
ffff888301e3ce00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff888301e3ce80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff888301e3cf00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff888301e3cf80: fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc
Disabling lock debugging due to kernel taint

Cc: <stable@vger.kernel.org> # 5.2
Fixes: 759738537142 ("IB/mlx5: Enable subscription for device events over DEVX")
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 2d1b3d9609d9..af5bbb35c058 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2644,12 +2644,13 @@ static int devx_async_event_close(struct inode *inode, struct file *filp)
 	struct devx_async_event_file *ev_file = filp->private_data;
 	struct devx_event_subscription *event_sub, *event_sub_tmp;
 	struct devx_async_event_data *entry, *tmp;
+	struct mlx5_ib_dev *dev = ev_file->dev;
 
-	mutex_lock(&ev_file->dev->devx_event_table.event_xa_lock);
+	mutex_lock(&dev->devx_event_table.event_xa_lock);
 	/* delete the subscriptions which are related to this FD */
 	list_for_each_entry_safe(event_sub, event_sub_tmp,
 				 &ev_file->subscribed_events_list, file_list) {
-		devx_cleanup_subscription(ev_file->dev, event_sub);
+		devx_cleanup_subscription(dev, event_sub);
 		if (event_sub->eventfd)
 			eventfd_ctx_put(event_sub->eventfd);
 
@@ -2658,7 +2659,7 @@ static int devx_async_event_close(struct inode *inode, struct file *filp)
 		kfree_rcu(event_sub, rcu);
 	}
 
-	mutex_unlock(&ev_file->dev->devx_event_table.event_xa_lock);
+	mutex_unlock(&dev->devx_event_table.event_xa_lock);
 
 	/* free the pending events allocation */
 	if (!ev_file->omit_data) {
@@ -2670,7 +2671,7 @@ static int devx_async_event_close(struct inode *inode, struct file *filp)
 	}
 
 	uverbs_close_fd(filp);
-	put_device(&ev_file->dev->ib_dev.dev);
+	put_device(&dev->ib_dev.dev);
 	return 0;
 }
 
-- 
2.20.1

