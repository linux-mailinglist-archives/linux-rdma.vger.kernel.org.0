Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98AE5C2ABD
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 01:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbfI3XRi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Sep 2019 19:17:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36669 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731985AbfI3XRh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Sep 2019 19:17:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id t14so8253615pgs.3
        for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2019 16:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oNma/HAel59HGi4qPVyzpJng0X2up6DTL+uZMvwQCEI=;
        b=IaXXnxUS+/eac+CAUvgvGY+f/uV09JUsqJHWqy3F5oyIEZtdWy5q1fNvMzcvmAKQOc
         J003IU3L5vvvdhCXYPx2wGkis5cPvPd/LXhYqDGSLCD1o0e4R9WR2p86aewK3coHcHyx
         /E9TTtBP/xEVHsNVpc/kirR7nlsSBQ4uftUMt8SdYVQgEUlaGi9zdHkLOGrPPyb4vsLH
         xyi9fjZ8qFo9oisaKb7wVldnft5IMu6X/Nn6PRdvuCLC7YChsOumWJGzTRYJ9v8K60jK
         pBDVOOQUnD0OeyQKalouLy1L6xjpgIcPD3HUys3ELNwWvBuFHgDSIXv34XTq6NbMIUby
         lN8g==
X-Gm-Message-State: APjAAAVE0Vp2xdCuIWRUyIyCIhKEA1duq8TQdWRZfpXKtUV0eCNVbdx8
        xm8ewWn0xytEyo3yhOW2Vlc=
X-Google-Smtp-Source: APXvYqxCkUW7nwaBSpMNrTL47GfC+TKgrkfVWwcxrfYk40U6sfM4aj/rm9xC+1QK6r34ik/EVAuf8w==
X-Received: by 2002:aa7:91d4:: with SMTP id z20mr18724223pfa.131.1569885456960;
        Mon, 30 Sep 2019 16:17:36 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id l7sm585406pjy.12.2019.09.30.16.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:17:35 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Honggang LI <honli@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: [PATCH 13/15] RDMA/srpt: Rework the code that waits until an RDMA port is no longer in use
Date:   Mon, 30 Sep 2019 16:17:05 -0700
Message-Id: <20190930231707.48259-14-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20190930231707.48259-1-bvanassche@acm.org>
References: <20190930231707.48259-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The current implementation does not wait until srpt_release_channel()
has finished and hence can trigger a use-after-free. Rework
srpt_release_sport() such that it waits until srpt_release_channel()
has finished. This patch fixes the following KASAN complaint:

==================================================================
BUG: KASAN: use-after-free in srpt_free_ioctx.part.23+0x42/0x100 [ib_srpt]
Read of size 8 at addr ffff888115c71100 by task kworker/4:3/807

CPU: 4 PID: 807 Comm: kworker/4:3 Not tainted 5.3.0-dbg+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
Workqueue: events srpt_release_channel_work [ib_srpt]
Call Trace:
 dump_stack+0x86/0xca
 print_address_description+0x74/0x32d
 __kasan_report.cold.6+0x1b/0x36
 kasan_report+0x12/0x17
 __asan_load8+0x54/0x90
 srpt_free_ioctx.part.23+0x42/0x100 [ib_srpt]
 srpt_free_ioctx_ring.part.24+0x50/0x80 [ib_srpt]
 srpt_release_channel_work+0x2ad/0x390 [ib_srpt]
 process_one_work+0x51a/0xa60
 worker_thread+0x67/0x5b0
 kthread+0x1dc/0x200
 ret_from_fork+0x24/0x30

Allocated by task 984:
 save_stack+0x21/0x90
 __kasan_kmalloc.constprop.9+0xc7/0xd0
 kasan_kmalloc+0x9/0x10
 __kmalloc+0x153/0x370
 srpt_add_one+0x4f/0x570 [ib_srpt]
 add_client_context+0x251/0x290 [ib_core]
 ib_register_client+0x1da/0x220 [ib_core]
 iblock_get_alignment_offset_lbas+0x6b/0x100 [target_core_iblock]
 do_one_initcall+0xcd/0x43a
 do_init_module+0x103/0x380
 load_module+0x3b77/0x3eb0
 __do_sys_finit_module+0x12d/0x1b0
 __x64_sys_finit_module+0x43/0x50
 do_syscall_64+0x6b/0x2d0
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 1128:
 save_stack+0x21/0x90
 __kasan_slab_free+0x139/0x190
 kasan_slab_free+0xe/0x10
 slab_free_freelist_hook+0x67/0x1e0
 kfree+0xcb/0x2a0
 srpt_remove_one+0x569/0x5b0 [ib_srpt]
 remove_client_context+0x9a/0xe0 [ib_core]
 disable_device+0x106/0x1b0 [ib_core]
 __ib_unregister_device+0x5f/0xf0 [ib_core]
 ib_unregister_device_and_put+0x48/0x60 [ib_core]
 nldev_dellink+0x120/0x180 [ib_core]
 rdma_nl_rcv+0x287/0x480 [ib_core]
 netlink_unicast+0x2cc/0x370
 netlink_sendmsg+0x3b1/0x630
 __sys_sendto+0x1db/0x290
 __x64_sys_sendto+0x80/0xa0
 do_syscall_64+0x6b/0x2d0
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff888115c71100
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 0 bytes inside of
 4096-byte region [ffff888115c71100, ffff888115c72100)
The buggy address belongs to the page:
page:ffffea0004571c00 refcount:1 mapcount:0 mapping:ffff88811ac0de00 index:0xffff888115c70000 compound_mapcount: 0
flags: 0x2fff000000010200(slab|head)
raw: 2fff000000010200 ffffea00045ac408 ffffea0004593208 ffff88811ac0de00
raw: ffff888115c70000 0000000000070002 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888115c71000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888115c71080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888115c71100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888115c71180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888115c71200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Cc: Honggang LI <honli@redhat.com>
Cc: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 42 +++++++++++++--------------
 drivers/infiniband/ulp/srpt/ib_srpt.h |  6 ++--
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 88e11a250c96..5e402f7b9692 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2023,10 +2023,17 @@ static void srpt_set_enabled(struct srpt_port *sport, bool enabled)
 		__srpt_close_all_ch(sport);
 }
 
+static void srpt_drop_sport_ref(struct srpt_port *sport)
+{
+	if (atomic_dec_return(&sport->refcount) == 0 && sport->freed_channels)
+		complete(sport->freed_channels);
+}
+
 static void srpt_free_ch(struct kref *kref)
 {
 	struct srpt_rdma_ch *ch = container_of(kref, struct srpt_rdma_ch, kref);
 
+	srpt_drop_sport_ref(ch->sport);
 	kfree_rcu(ch, rcu);
 }
 
@@ -2087,8 +2094,6 @@ static void srpt_release_channel_work(struct work_struct *w)
 
 	kmem_cache_destroy(ch->req_buf_cache);
 
-	wake_up(&sport->ch_releaseQ);
-
 	kref_put(&ch->kref, srpt_free_ch);
 }
 
@@ -2307,6 +2312,12 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 		goto destroy_ib;
 	}
 
+	/*
+	 * Once a session has been created destruction of srpt_rdma_ch objects
+	 * will decrement sport->refcount. Hence increment sport->refcount now.
+	 */
+	atomic_inc(&sport->refcount);
+
 	mutex_lock(&sport->mutex);
 
 	if ((req->req_flags & SRP_MTCH_ACTION) == SRP_MULTICHAN_SINGLE) {
@@ -2889,39 +2900,29 @@ static void srpt_refresh_port_work(struct work_struct *work)
 	srpt_refresh_port(sport);
 }
 
-static bool srpt_ch_list_empty(struct srpt_port *sport)
-{
-	struct srpt_nexus *nexus;
-	bool res = true;
-
-	rcu_read_lock();
-	list_for_each_entry(nexus, &sport->nexus_list, entry)
-		if (!list_empty(&nexus->ch_list))
-			res = false;
-	rcu_read_unlock();
-
-	return res;
-}
-
 /**
  * srpt_release_sport - disable login and wait for associated channels
  * @sport: SRPT HCA port.
  */
 static int srpt_release_sport(struct srpt_port *sport)
 {
+	DECLARE_COMPLETION_ONSTACK(c);
 	struct srpt_nexus *nexus, *next_n;
 	struct srpt_rdma_ch *ch;
 
 	WARN_ON_ONCE(irqs_disabled());
 
+	sport->freed_channels = &c;
+
 	mutex_lock(&sport->mutex);
 	srpt_set_enabled(sport, false);
 	mutex_unlock(&sport->mutex);
 
-	while (wait_event_timeout(sport->ch_releaseQ,
-				  srpt_ch_list_empty(sport), 5 * HZ) <= 0) {
-		pr_info("%s_%d: waiting for session unregistration ...\n",
-			dev_name(&sport->sdev->device->dev), sport->port);
+	while (atomic_read(&sport->refcount) > 0 &&
+	       wait_for_completion_timeout(&c, 5 * HZ) <= 0) {
+		pr_info("%s_%d: waiting for unregistration of %d sessions ...\n",
+			dev_name(&sport->sdev->device->dev), sport->port,
+			atomic_read(&sport->refcount));
 		rcu_read_lock();
 		list_for_each_entry(nexus, &sport->nexus_list, entry) {
 			list_for_each_entry(ch, &nexus->ch_list, list) {
@@ -3130,7 +3131,6 @@ static void srpt_add_one(struct ib_device *device)
 	for (i = 1; i <= sdev->device->phys_port_cnt; i++) {
 		sport = &sdev->port[i - 1];
 		INIT_LIST_HEAD(&sport->nexus_list);
-		init_waitqueue_head(&sport->ch_releaseQ);
 		mutex_init(&sport->mutex);
 		sport->sdev = sdev;
 		sport->port = i;
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.h b/drivers/infiniband/ulp/srpt/ib_srpt.h
index d0955bc0343d..f3df791dd877 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.h
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
@@ -381,7 +381,8 @@ struct srpt_port_attrib {
  * @port_gid_tpg:  TPG associated with target port GID.
  * @port_gid_wwn:  WWN associated with target port GID.
  * @port_attrib:   Port attributes that can be accessed through configfs.
- * @ch_releaseQ:   Enables waiting for removal from nexus_list.
+ * @refcount:	   Number of objects associated with this port.
+ * @freed_channels: Completion that will be signaled once @refcount becomes 0.
  * @mutex:	   Protects nexus_list.
  * @nexus_list:	   Nexus list. See also srpt_nexus.entry.
  */
@@ -401,7 +402,8 @@ struct srpt_port {
 	struct se_portal_group	port_gid_tpg;
 	struct se_wwn		port_gid_wwn;
 	struct srpt_port_attrib port_attrib;
-	wait_queue_head_t	ch_releaseQ;
+	atomic_t		refcount;
+	struct completion	*freed_channels;
 	struct mutex		mutex;
 	struct list_head	nexus_list;
 };
-- 
2.23.0.444.g18eeb5a265-goog

