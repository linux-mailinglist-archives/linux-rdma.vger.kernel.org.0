Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87DC303536
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 06:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbhAZFh1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 00:37:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:35038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbhAYMWV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Jan 2021 07:22:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2078922DFB;
        Mon, 25 Jan 2021 12:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611577268;
        bh=2OI6VE4ClZYuDY5dTeXReVytKfBGlN0vMAottIbDQc8=;
        h=From:To:Cc:Subject:Date:From;
        b=jYtUK8yQiMEKPjAz/RqnhT9TZuDatKjWcIkrsu8vgtIokycI/D9uOif9Q0YPqL7sU
         GKTqG3AjSfX1QWQfslay8aiCvYyqJddvyB9Tv/7/6GQ7K7YIfcLAQAJHfYZxYIAaMg
         MwhZrXmNXPNT15/e/RqbUXTjVFAbaFkE7YTZhGieVzWrkiTAFAyw5fIdssVlbARywf
         TUzyibysh/w0Zqd8GleLhmLejis+bOlyiKEo4B+Q7PlMOLsXRoAy38vNOMm8TkTMWH
         hxB9zHQ42xyTrIwoTU4LK4G7BQz1EX41ppmI2MgaF/BhkiEDSqjkjZkhy1ulUxd8gI
         Q3me1MUfSiagQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Avihai Horon <avihaih@nvidia.com>,
        Amit Matityahu <mitm@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1] RDMA/ucma: Fix use-after-free bug in ucma_create_uevent
Date:   Mon, 25 Jan 2021 14:15:56 +0200
Message-Id: <20210125121556.838290-1-leon@kernel.org>
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
   cma_iboe_join_multicast() enqueues a work that will later use the
   aforementioned mc struct.
3. copy_to_user() is called and fails.
4. mc struct is deallocated.
5. The work that was enqueued by cma_iboe_join_multicast() is run and
   calls ucma_create_uevent() which tries to access mc struct (which is
   freed by now).

Fix this bug by cancelling the work enqueued by cma_iboe_join_multicast().
Since cma_work_handler() frees struct cma_work, we don't use it in
cma_iboe_join_multicast() so we can safely cancel the work later.

The following syzkaller report revealed it:

BUG: KASAN: use-after-free in ucma_create_uevent+0x2dd/0&times;3f0
drivers/infiniband/core/ucma.c:272
Read of size 8 at addr ffff88810b3ad110 by task kworker/u8:1/108
 
CPU: 1 PID: 108 Comm: kworker/u8:1 Not tainted 5.10.0-rc6+ #257
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
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

Fixes: b5de0c60cc30 ("RDMA/cma: Fix use after free race in roce multicast join")
Reported-by: Amit Matityahu <mitm@nvidia.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c | 55 +++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index e17ba841e204..7ce4d9dea826 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -352,7 +352,13 @@ struct ib_device *cma_get_ib_dev(struct cma_device *cma_dev)
 
 struct cma_multicast {
 	struct rdma_id_private *id_priv;
-	struct ib_sa_multicast *sa_mc;
+	union {
+		struct ib_sa_multicast *sa_mc;
+		struct {
+			struct work_struct work;
+			struct rdma_cm_event event;
+		} iboe_join;
+	};
 	struct list_head	list;
 	void			*context;
 	struct sockaddr_storage	addr;
@@ -1839,6 +1845,12 @@ static void destroy_mc(struct rdma_id_private *id_priv,
 			cma_igmp_send(ndev, &mgid, false);
 			dev_put(ndev);
 		}
+
+		if (cancel_work_sync(&mc->iboe_join.work))
+			/* Compensate for cma_iboe_join_work_handler that
+			 * didn't run.
+			 */
+			cma_id_put(mc->id_priv);
 	}
 	kfree(mc);
 }
@@ -2702,6 +2714,32 @@ static int cma_query_ib_route(struct rdma_id_private *id_priv,
 	return (id_priv->query_id < 0) ? id_priv->query_id : 0;
 }
 
+static void cma_iboe_join_work_handler(struct work_struct *work)
+{
+	struct cma_multicast *mc =
+		container_of(work, struct cma_multicast, iboe_join.work);
+	struct rdma_cm_event *event = &mc->iboe_join.event;
+	struct rdma_id_private *id_priv = mc->id_priv;
+
+	mutex_lock(&id_priv->handler_mutex);
+	if (READ_ONCE(id_priv->state) == RDMA_CM_DESTROYING ||
+	    READ_ONCE(id_priv->state) == RDMA_CM_DEVICE_REMOVAL)
+		goto out_unlock;
+
+	if (cma_cm_event_handler(id_priv, event)) {
+		cma_id_put(id_priv);
+		destroy_id_handler_unlock(id_priv);
+		goto out;
+	}
+
+out_unlock:
+	mutex_unlock(&id_priv->handler_mutex);
+	cma_id_put(id_priv);
+out:
+	if (event->event == RDMA_CM_EVENT_MULTICAST_JOIN)
+		rdma_destroy_ah_attr(&event->param.ud.ah_attr);
+}
+
 static void cma_work_handler(struct work_struct *_work)
 {
 	struct cma_work *work = container_of(_work, struct cma_work, work);
@@ -4625,7 +4663,6 @@ static void cma_iboe_set_mgid(struct sockaddr *addr, union ib_gid *mgid,
 static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
 				   struct cma_multicast *mc)
 {
-	struct cma_work *work;
 	struct rdma_dev_addr *dev_addr = &id_priv->id.route.addr.dev_addr;
 	int err = 0;
 	struct sockaddr *addr = (struct sockaddr *)&mc->addr;
@@ -4639,10 +4676,6 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
 	if (cma_zero_addr(addr))
 		return -EINVAL;
 
-	work = kzalloc(sizeof *work, GFP_KERNEL);
-	if (!work)
-		return -ENOMEM;
-
 	gid_type = id_priv->cma_dev->default_gid_type[id_priv->id.port_num -
 		   rdma_start_port(id_priv->cma_dev->device)];
 	cma_iboe_set_mgid(addr, &ib.rec.mgid, gid_type);
@@ -4681,16 +4714,14 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
 	}
 	rdma_ip2gid((struct sockaddr *)&id_priv->id.route.addr.src_addr,
 		    &ib.rec.port_gid);
-	work->id = id_priv;
-	INIT_WORK(&work->work, cma_work_handler);
-	cma_make_mc_event(0, id_priv, &ib, &work->event, mc);
-	/* Balances with cma_id_put() in cma_work_handler */
+	INIT_WORK(&mc->iboe_join.work, cma_iboe_join_work_handler);
+	cma_make_mc_event(0, id_priv, &ib, &mc->iboe_join.event, mc);
+	/* Balances with cma_id_put() in cma_iboe_join_work_handler */
 	cma_id_get(id_priv);
-	queue_work(cma_wq, &work->work);
+	queue_work(cma_wq, &mc->iboe_join.work);
 	return 0;
 
 err_free:
-	kfree(work);
 	return err;
 }
 
-- 
2.29.2

