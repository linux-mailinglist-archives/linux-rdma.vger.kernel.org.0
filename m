Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CA820BD81
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2020 02:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgF0ApX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Jun 2020 20:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgF0ApX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Jun 2020 20:45:23 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF10C03E97A
        for <linux-rdma@vger.kernel.org>; Fri, 26 Jun 2020 17:45:22 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id i25so11738014iog.0
        for <linux-rdma@vger.kernel.org>; Fri, 26 Jun 2020 17:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/oi2LEuTy/0Ld+RhLGkKz44qbsN9XhiFNsWnVD3b5vY=;
        b=TowiYZjfaGJZzomHGCH1xXc76fzVC2WUMZGsu9nv9lfrLlmX+Y/U1g6ywJX9bWuuid
         MS5/LYQiXToF21Piy6ZAP33UFlS+GqPKKQJhfWWHvu8Z82CBOAMS92+FVzyEVr6cIBZ5
         rT8wA4fr/lgbZHQWMTIlfqfyzzINDJ+8Vj6yz/TJs0kjbw32+92hIsC2QkjBWSBd05vA
         rboiHeQNF95bbvRmmYgAJT2DyNtGaal+VsN7sW9MCRWgC4Z8niQdCZlng2CMQ581voK0
         QlSz/bdEJiU4ff58m/b9gh6DB0eCRwYm1/ZeRfam9ytsLOURxoxkMGU9Ve9mlHyzahkP
         YObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/oi2LEuTy/0Ld+RhLGkKz44qbsN9XhiFNsWnVD3b5vY=;
        b=qbDQC4WWvwBqVD+BXM2n3LO4ydWOZiIfRdfcHo32idgJ7Ul+6c1PEEGd2BslbR4bwI
         InakGGkJMuDsI73+oRntXz/8pPS+QsyuCMX6lcazTH8Y5I0ndPXSb9UVdNf+PRQTeKLr
         xKlzCRpKIVMqpu2x9a8yzj9Wk6M7aBgYhuwZf/0hK1OakhreQ/O9VSrDXg3Ar3PIC/2S
         Z5glnUUkIxa9s6yqFzvcOeg1tVhJ0Sm9W4hmyX+iyqnGROtiiWMzSpDO9xhgWX/5hIA6
         hLSL3Yfm3EZfmBYwxYeOEYwDwDex+H7+j6mD09HoH6o4kglsnEY9OhF3qFZREJGuoXoM
         POBg==
X-Gm-Message-State: AOAM532ALMlKYgfJh9BfA3HOYvm3/LGMeI/tOdrEoBEuqSDYSSVVOhEw
        KO3bBpddngyyXnghtftt+1flxA==
X-Google-Smtp-Source: ABdhPJy9+SBJvN1jUJFKf0DFT2vQ9ELF7KMbBOB+IwbLy+TDp5La4aAig9Qx+jwa7N3w+s50FhHVug==
X-Received: by 2002:a02:3501:: with SMTP id k1mr6104740jaa.14.1593218721910;
        Fri, 26 Jun 2020 17:45:21 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id f2sm9778744ioc.52.2020.06.26.17.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 17:45:20 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1joyy7-000SSN-Cf; Fri, 26 Jun 2020 21:45:19 -0300
Date:   Fri, 26 Jun 2020 21:45:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+a929647172775e335941@syzkaller.appspotmail.com>,
        chuck.lever@oracle.com, dledford@redhat.com, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        parav@mellanox.com, Markus Elfring <Markus.Elfring@web.de>,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in addr_handler (2)
Message-ID: <20200627004519.GB25301@ziepe.ca>
References: <000000000000107b4605a7bdce7d@google.com>
 <20200614085321.8740-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200614085321.8740-1-hdanton@sina.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 14, 2020 at 04:53:21PM +0800, Hillf Danton wrote:
> 
> Wed, 10 Jun 2020 10:02:11 -0700
> > syzbot found the following crash on:
> > 
> > HEAD commit:    7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16c0d3a6100000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d195fe572fb15312
> > dashboard link: https://syzkaller.appspot.com/bug?extid=a929647172775e335941
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > 
> > Unfortunately, I don't have any reproducer for this crash yet.
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+a929647172775e335941@syzkaller.appspotmail.com
> > 
> > ==================================================================
> > BUG: KASAN: use-after-free in __mutex_lock_common kernel/locking/mutex.c:938 [inline]
> > BUG: KASAN: use-after-free in __mutex_lock+0x1033/0x13c0 kernel/locking/mutex.c:1103
> > Read of size 8 at addr ffff888088ec33b0 by task kworker/u4:5/14014
> > 
> > CPU: 1 PID: 14014 Comm: kworker/u4:5 Not tainted 5.7.0-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Workqueue: ib_addr process_one_req
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x188/0x20d lib/dump_stack.c:118
> >  print_address_description.constprop.0.cold+0xd3/0x413 mm/kasan/report.c:383
> >  __kasan_report mm/kasan/report.c:513 [inline]
> >  kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
> >  __mutex_lock_common kernel/locking/mutex.c:938 [inline]
> >  __mutex_lock+0x1033/0x13c0 kernel/locking/mutex.c:1103
> >  addr_handler+0xa0/0x340 drivers/infiniband/core/cma.c:3100
> >  process_one_req+0xfa/0x680 drivers/infiniband/core/addr.c:643
> >  process_one_work+0x965/0x16a0 kernel/workqueue.c:2268
> >  worker_thread+0x96/0xe20 kernel/workqueue.c:2414
> >  kthread+0x388/0x470 kernel/kthread.c:268
> >  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:351
> > 
> > Allocated by task 31499:
> >  save_stack+0x1b/0x40 mm/kasan/common.c:48
> >  set_track mm/kasan/common.c:56 [inline]
> >  __kasan_kmalloc mm/kasan/common.c:494 [inline]
> >  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:467
> >  kmem_cache_alloc_trace+0x153/0x7d0 mm/slab.c:3551
> >  kmalloc include/linux/slab.h:555 [inline]
> >  kzalloc include/linux/slab.h:669 [inline]
> >  __rdma_create_id+0x5b/0x850 drivers/infiniband/core/cma.c:861
> >  ucma_create_id+0x1d1/0x590 drivers/infiniband/core/ucma.c:503
> >  ucma_write+0x285/0x350 drivers/infiniband/core/ucma.c:1729
> >  __vfs_write+0x76/0x100 fs/read_write.c:495
> >  vfs_write+0x268/0x5d0 fs/read_write.c:559
> >  ksys_write+0x1ee/0x250 fs/read_write.c:612
> >  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
> >  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> > 
> > Freed by task 31496:
> >  save_stack+0x1b/0x40 mm/kasan/common.c:48
> >  set_track mm/kasan/common.c:56 [inline]
> >  kasan_set_free_info mm/kasan/common.c:316 [inline]
> >  __kasan_slab_free+0xf7/0x140 mm/kasan/common.c:455
> >  __cache_free mm/slab.c:3426 [inline]
> >  kfree+0x109/0x2b0 mm/slab.c:3757
> >  ucma_close+0x111/0x300 drivers/infiniband/core/ucma.c:1807
> >  __fput+0x33e/0x880 fs/file_table.c:281
> >  task_work_run+0xf4/0x1b0 kernel/task_work.c:123
> >  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
> >  exit_to_usermode_loop+0x2fa/0x360 arch/x86/entry/common.c:165
> >  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
> >  syscall_return_slowpath arch/x86/entry/common.c:279 [inline]
> >  do_syscall_64+0x6b1/0x7d0 arch/x86/entry/common.c:305
> >  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> > 
> > The buggy address belongs to the object at ffff888088ec3000
> >  which belongs to the cache kmalloc-2k of size 2048
> > The buggy address is located 944 bytes inside of
> >  2048-byte region [ffff888088ec3000, ffff888088ec3800)
> > The buggy address belongs to the page:
> > page:ffffea000223b0c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
> > flags: 0xfffe0000000200(slab)
> > raw: 00fffe0000000200 ffffea000299f588 ffffea000263d0c8 ffff8880aa000e00
> > raw: 0000000000000000 ffff888088ec3000 0000000100000001 0000000000000000
> > page dumped because: kasan: bad access detected
> > 
> > Memory state around the buggy address:
> >  ffff888088ec3280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff888088ec3300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >ffff888088ec3380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                                      ^
> >  ffff888088ec3400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff888088ec3480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ==================================================================
> 
> Add extra grab to id_priv to make addr_handler() safe.
> It may also fix what's
>   Reported-by: syzbot+08092148130652a6faae@syzkaller.appspotmail.com

In some way adding the refcounting is appealing, but it is not quite
right..

Once rdma_resolve_addr() is called the cm_id state is supposed to go
to RDMA_CM_ADDR_QUERY and stay there until the address is resolved.

The first thing rdma_destroy_id() does (which is what triggered the
kfree) is to call cma_cancel_operation(), which does a
cancel_delayed_work_sync().

So, to hit this syzkaller one of these must have happened:
 1) rdma_addr_cancel() didn't work and the process_one_work() is still
    runnable/running
 2) The state changed away from RDMA_CM_ADDR_QUERY without doing
    rdma_addr_cancel()
 3) rdma_resolve_addr() ran concurrently with rdma_destroy_id()

I think #1 and #3 are not likely as I've already fixed those in the
past, but maybe you can see something?

So, this is probably #2. Actually it looks like there are many cases
where #2 is possible, so lets start there.

Something sort of like this should help:

From 036b462378a376725d81072c47754a89a51e4774 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Fri, 26 Jun 2020 16:54:30 -0300
Subject: [PATCH] RDMA/cma: Execute rdma_cm destruction from a handler properly

When a rdma_cm_id needs to be destroyed after a handler callback fails,
part of the destruction pattern is open coded into each call site.

Unfortunately the blind assignment to state discards important information
needed to do cma_cancel_operation(). This results in active operations
being left running after rdma_destroy_id() completes, and the
use-after-free bugs from KASAN.

Consolidate this entire pattern into destroy_id_handler_unlock() and
manage the locking correctly. The state should be set to
RDMA_CM_DESTROYING under the handler_lock to atomically ensure no futher
handlers are called.

Reported-by: syzbot+a929647172775e335941@syzkaller.appspotmail.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/cma.c | 212 ++++++++++++++++------------------
 1 file changed, 101 insertions(+), 111 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 3d7cc9f0f3d40c..a599a628e45dc7 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1825,23 +1825,11 @@ static void cma_leave_mc_groups(struct rdma_id_private *id_priv)
 	}
 }
 
-void rdma_destroy_id(struct rdma_cm_id *id)
+static void _destroy_id(struct rdma_id_private *id_priv,
+			enum rdma_cm_state state)
 {
-	struct rdma_id_private *id_priv;
-	enum rdma_cm_state state;
-
-	id_priv = container_of(id, struct rdma_id_private, id);
-	trace_cm_id_destroy(id_priv);
-	state = cma_exch(id_priv, RDMA_CM_DESTROYING);
 	cma_cancel_operation(id_priv, state);
 
-	/*
-	 * Wait for any active callback to finish.  New callbacks will find
-	 * the id_priv state set to destroying and abort.
-	 */
-	mutex_lock(&id_priv->handler_mutex);
-	mutex_unlock(&id_priv->handler_mutex);
-
 	rdma_restrack_del(&id_priv->res);
 	if (id_priv->cma_dev) {
 		if (rdma_cap_ib_cm(id_priv->id.device, 1)) {
@@ -1870,6 +1858,38 @@ void rdma_destroy_id(struct rdma_cm_id *id)
 	put_net(id_priv->id.route.addr.dev_addr.net);
 	kfree(id_priv);
 }
+
+/*
+ * destroy an ID from within the handler_mutex. This ensures that no other
+ * handlers can start running concurrently.
+ */
+static void destroy_id_handler_unlock(struct rdma_id_private *id_priv)
+	__releases(&idprv->handler_mutex)
+{
+	enum rdma_cm_state state;
+
+	trace_cm_id_destroy(id_priv);
+
+	/*
+	 * Setting the state to destroyed under the handler mutex provides a
+	 * fence against calling handler callbacks. If this is invoked due to
+	 * the failure of a handler callback then it guarentees that no future
+	 * handlers will be called.
+	 */
+	lockdep_assert_held(&id_priv->handler_mutex);
+	state = cma_exch(id_priv, RDMA_CM_DESTROYING);
+	mutex_unlock(&id_priv->handler_mutex);
+	_destroy_id(id_priv, state);
+}
+
+void rdma_destroy_id(struct rdma_cm_id *id)
+{
+	struct rdma_id_private *id_priv =
+		container_of(id, struct rdma_id_private, id);
+
+	mutex_lock(&id_priv->handler_mutex);
+	destroy_id_handler_unlock(id_priv);
+}
 EXPORT_SYMBOL(rdma_destroy_id);
 
 static int cma_rep_recv(struct rdma_id_private *id_priv)
@@ -2001,9 +2021,7 @@ static int cma_ib_handler(struct ib_cm_id *cm_id,
 	if (ret) {
 		/* Destroy the CM ID by returning a non-zero value. */
 		id_priv->cm_id.ib = NULL;
-		cma_exch(id_priv, RDMA_CM_DESTROYING);
-		mutex_unlock(&id_priv->handler_mutex);
-		rdma_destroy_id(&id_priv->id);
+		destroy_id_handler_unlock(id_priv);
 		return ret;
 	}
 out:
@@ -2170,7 +2188,7 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_id,
 	mutex_lock(&listen_id->handler_mutex);
 	if (listen_id->state != RDMA_CM_LISTEN) {
 		ret = -ECONNABORTED;
-		goto err1;
+		goto err_unlock;
 	}
 
 	offset = cma_user_data_offset(listen_id);
@@ -2187,55 +2205,38 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_id,
 	}
 	if (!conn_id) {
 		ret = -ENOMEM;
-		goto err1;
+		goto err_unlock;
 	}
 
 	mutex_lock_nested(&conn_id->handler_mutex, SINGLE_DEPTH_NESTING);
 	ret = cma_ib_acquire_dev(conn_id, listen_id, &req);
-	if (ret)
-		goto err2;
+	if (ret) {
+		destroy_id_handler_unlock(conn_id);
+		goto err_unlock;
+	}
 
 	conn_id->cm_id.ib = cm_id;
 	cm_id->context = conn_id;
 	cm_id->cm_handler = cma_ib_handler;
 
-	/*
-	 * Protect against the user destroying conn_id from another thread
-	 * until we're done accessing it.
-	 */
-	cma_id_get(conn_id);
 	ret = cma_cm_event_handler(conn_id, &event);
-	if (ret)
-		goto err3;
-	/*
-	 * Acquire mutex to prevent user executing rdma_destroy_id()
-	 * while we're accessing the cm_id.
-	 */
-	mutex_lock(&lock);
+	if (ret) {
+		/* Destroy the CM ID by returning a non-zero value. */
+		conn_id->cm_id.ib = NULL;
+		destroy_id_handler_unlock(conn_id);
+		goto err_unlock;
+	}
+
+	/* NOTE: Holding handler_mutex prevents concurrent destroy */
 	if (cma_comp(conn_id, RDMA_CM_CONNECT) &&
 	    (conn_id->id.qp_type != IB_QPT_UD)) {
 		trace_cm_send_mra(cm_id->context);
 		ib_send_cm_mra(cm_id, CMA_CM_MRA_SETTING, NULL, 0);
 	}
-	mutex_unlock(&lock);
 	mutex_unlock(&conn_id->handler_mutex);
-	mutex_unlock(&listen_id->handler_mutex);
-	cma_id_put(conn_id);
-	if (net_dev)
-		dev_put(net_dev);
-	return 0;
 
-err3:
-	cma_id_put(conn_id);
-	/* Destroy the CM ID by returning a non-zero value. */
-	conn_id->cm_id.ib = NULL;
-err2:
-	cma_exch(conn_id, RDMA_CM_DESTROYING);
-	mutex_unlock(&conn_id->handler_mutex);
-err1:
+err_unlock:
 	mutex_unlock(&listen_id->handler_mutex);
-	if (conn_id)
-		rdma_destroy_id(&conn_id->id);
 
 net_dev_put:
 	if (net_dev)
@@ -2335,9 +2336,7 @@ static int cma_iw_handler(struct iw_cm_id *iw_id, struct iw_cm_event *iw_event)
 	if (ret) {
 		/* Destroy the CM ID by returning a non-zero value. */
 		id_priv->cm_id.iw = NULL;
-		cma_exch(id_priv, RDMA_CM_DESTROYING);
-		mutex_unlock(&id_priv->handler_mutex);
-		rdma_destroy_id(&id_priv->id);
+		destroy_id_handler_unlock(id_priv);
 		return ret;
 	}
 
@@ -2384,15 +2383,13 @@ static int iw_conn_req_handler(struct iw_cm_id *cm_id,
 
 	ret = rdma_translate_ip(laddr, &conn_id->id.route.addr.dev_addr);
 	if (ret) {
-		mutex_unlock(&conn_id->handler_mutex);
-		rdma_destroy_id(new_cm_id);
+		destroy_id_handler_unlock(conn_id);
 		goto out;
 	}
 
 	ret = cma_iw_acquire_dev(conn_id, listen_id);
 	if (ret) {
-		mutex_unlock(&conn_id->handler_mutex);
-		rdma_destroy_id(new_cm_id);
+		destroy_id_handler_unlock(conn_id);
 		goto out;
 	}
 
@@ -2403,25 +2400,15 @@ static int iw_conn_req_handler(struct iw_cm_id *cm_id,
 	memcpy(cma_src_addr(conn_id), laddr, rdma_addr_size(laddr));
 	memcpy(cma_dst_addr(conn_id), raddr, rdma_addr_size(raddr));
 
-	/*
-	 * Protect against the user destroying conn_id from another thread
-	 * until we're done accessing it.
-	 */
-	cma_id_get(conn_id);
 	ret = cma_cm_event_handler(conn_id, &event);
 	if (ret) {
 		/* User wants to destroy the CM ID */
 		conn_id->cm_id.iw = NULL;
-		cma_exch(conn_id, RDMA_CM_DESTROYING);
-		mutex_unlock(&conn_id->handler_mutex);
-		mutex_unlock(&listen_id->handler_mutex);
-		cma_id_put(conn_id);
-		rdma_destroy_id(&conn_id->id);
-		return ret;
+		destroy_id_handler_unlock(conn_id);
+		goto out;
 	}
 
 	mutex_unlock(&conn_id->handler_mutex);
-	cma_id_put(conn_id);
 
 out:
 	mutex_unlock(&listen_id->handler_mutex);
@@ -2478,6 +2465,10 @@ static int cma_listen_handler(struct rdma_cm_id *id,
 {
 	struct rdma_id_private *id_priv = id->context;
 
+	/* Listening IDs are always destroyed on removal */
+	if (event->event == RDMA_CM_EVENT_DEVICE_REMOVAL)
+		return -1;
+
 	id->context = id_priv->id.context;
 	id->event_handler = id_priv->id.event_handler;
 	trace_cm_event_handler(id_priv, event);
@@ -2651,21 +2642,21 @@ static void cma_work_handler(struct work_struct *_work)
 {
 	struct cma_work *work = container_of(_work, struct cma_work, work);
 	struct rdma_id_private *id_priv = work->id;
-	int destroy = 0;
 
 	mutex_lock(&id_priv->handler_mutex);
 	if (!cma_comp_exch(id_priv, work->old_state, work->new_state))
-		goto out;
+		goto out_unlock;
 
 	if (cma_cm_event_handler(id_priv, &work->event)) {
-		cma_exch(id_priv, RDMA_CM_DESTROYING);
-		destroy = 1;
+		cma_id_put(id_priv);
+		destroy_id_handler_unlock(id_priv);
+		goto out_free;
 	}
-out:
+
+out_unlock:
 	mutex_unlock(&id_priv->handler_mutex);
 	cma_id_put(id_priv);
-	if (destroy)
-		rdma_destroy_id(&id_priv->id);
+out_free:
 	kfree(work);
 }
 
@@ -2673,23 +2664,22 @@ static void cma_ndev_work_handler(struct work_struct *_work)
 {
 	struct cma_ndev_work *work = container_of(_work, struct cma_ndev_work, work);
 	struct rdma_id_private *id_priv = work->id;
-	int destroy = 0;
 
 	mutex_lock(&id_priv->handler_mutex);
 	if (id_priv->state == RDMA_CM_DESTROYING ||
 	    id_priv->state == RDMA_CM_DEVICE_REMOVAL)
-		goto out;
+		goto out_unlock;
 
 	if (cma_cm_event_handler(id_priv, &work->event)) {
-		cma_exch(id_priv, RDMA_CM_DESTROYING);
-		destroy = 1;
+		cma_id_put(id_priv);
+		destroy_id_handler_unlock(id_priv);
+		goto out_free;
 	}
 
-out:
+out_unlock:
 	mutex_unlock(&id_priv->handler_mutex);
 	cma_id_put(id_priv);
-	if (destroy)
-		rdma_destroy_id(&id_priv->id);
+out_free:
 	kfree(work);
 }
 
@@ -3165,9 +3155,7 @@ static void addr_handler(int status, struct sockaddr *src_addr,
 		event.event = RDMA_CM_EVENT_ADDR_RESOLVED;
 
 	if (cma_cm_event_handler(id_priv, &event)) {
-		cma_exch(id_priv, RDMA_CM_DESTROYING);
-		mutex_unlock(&id_priv->handler_mutex);
-		rdma_destroy_id(&id_priv->id);
+		destroy_id_handler_unlock(id_priv);
 		return;
 	}
 out:
@@ -3822,9 +3810,7 @@ static int cma_sidr_rep_handler(struct ib_cm_id *cm_id,
 	if (ret) {
 		/* Destroy the CM ID by returning a non-zero value. */
 		id_priv->cm_id.ib = NULL;
-		cma_exch(id_priv, RDMA_CM_DESTROYING);
-		mutex_unlock(&id_priv->handler_mutex);
-		rdma_destroy_id(&id_priv->id);
+		destroy_id_handler_unlock(id_priv);
 		return ret;
 	}
 out:
@@ -4354,9 +4340,7 @@ static int cma_ib_mc_handler(int status, struct ib_sa_multicast *multicast)
 
 	rdma_destroy_ah_attr(&event.param.ud.ah_attr);
 	if (ret) {
-		cma_exch(id_priv, RDMA_CM_DESTROYING);
-		mutex_unlock(&id_priv->handler_mutex);
-		rdma_destroy_id(&id_priv->id);
+		destroy_id_handler_unlock(id_priv);
 		return 0;
 	}
 
@@ -4771,29 +4755,38 @@ static int cma_add_one(struct ib_device *device)
 	return ret;
 }
 
-static int cma_remove_id_dev(struct rdma_id_private *id_priv)
+static void cma_send_device_removal_put(struct rdma_id_private *id_priv)
 {
-	struct rdma_cm_event event = {};
+	struct rdma_cm_event event = { .event = RDMA_CM_EVENT_DEVICE_REMOVAL };
 	enum rdma_cm_state state;
-	int ret = 0;
+	unsigned long flags;
 
 	/* Record that we want to remove the device */
-	state = cma_exch(id_priv, RDMA_CM_DEVICE_REMOVAL);
-	if (state == RDMA_CM_DESTROYING)
-		return 0;
-
-	cma_cancel_operation(id_priv, state);
 	mutex_lock(&id_priv->handler_mutex);
+	spin_lock_irqsave(&id_priv->lock, flags);
+	state = id_priv->state;
+	if (state == RDMA_CM_DESTROYING || state == RDMA_CM_DEVICE_REMOVAL) {
+		spin_unlock_irqsave(&id_priv->lock, flags);
+		mutex_unlock(&id_priv->handler_mutex);
+		cm_id_put(id_priv);
+		return;
+	}
+	id_priv->state = RDMA_CM_DEVICE_REMOVAL;
+	spin_unlock_irqsave(&id_priv->lock, flags);
 
-	/* Check for destruction from another callback. */
-	if (!cma_comp(id_priv, RDMA_CM_DEVICE_REMOVAL))
-		goto out;
-
-	event.event = RDMA_CM_EVENT_DEVICE_REMOVAL;
-	ret = cma_cm_event_handler(id_priv, &event);
-out:
+	if (cma_cm_event_handler(id_priv, &event)) {
+		mutex_unlock(&id_priv->handler_mutex);
+		cm_id_put(id_priv);
+		trace_cm_id_destroy(id_priv);
+		_destroy_id(id_priv, state);
+		return;
+	}
 	mutex_unlock(&id_priv->handler_mutex);
-	return ret;
+
+	/* The thread that assigns state does the cancel */
+	cma_cancel_operation(id_priv, state);
+
+	cm_id_put(id_priv);
 }
 
 static void cma_process_remove(struct cma_device *cma_dev)
@@ -4811,10 +4804,7 @@ static void cma_process_remove(struct cma_device *cma_dev)
 		cma_id_get(id_priv);
 		mutex_unlock(&lock);
 
-		ret = id_priv->internal_id ? 1 : cma_remove_id_dev(id_priv);
-		cma_id_put(id_priv);
-		if (ret)
-			rdma_destroy_id(&id_priv->id);
+		cma_send_device_removal_put(id_priv);
 
 		mutex_lock(&lock);
 	}
-- 
2.27.0

