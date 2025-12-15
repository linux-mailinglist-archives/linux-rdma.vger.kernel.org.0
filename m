Return-Path: <linux-rdma+bounces-15001-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40674CBEAFF
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 16:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BFF2300C6E4
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 15:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061E231A552;
	Mon, 15 Dec 2025 15:31:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D1031960F;
	Mon, 15 Dec 2025 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765812671; cv=none; b=MX8/MPbzZOXpxQKASGizGwjllRnVn30Jv8Ijp1bLZ8QQRap/jIFBJRGR/fZXEEBVbianZ4zo04S3nEfA/QohF3OBFXy43Vz/H2vqcag5frrs+Q9l2fWRT05DhmvXwa+JuDB2+NpMazG44ERbTjCwuHMesfvilaU39pw4xmO//rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765812671; c=relaxed/simple;
	bh=Laywh6AoZCLizlR5zkvEenWtgcQ3qvm83Rx9rALleT0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ub6v9MDVW/x4WThbdKxGwA6xYhSoONeu6yo4tn/NtjoZJ+jPLiWEEoQJC9PpOECG/YWRkXVdhghk0JYgbVgFYQ9ZnhztVIDXt95lqkuyB0ZMvvK4VSaaSYkV8qUyfTMGvfemESx4Ke0xAF6DdRfAVBOm4yxIRZ0w8XanAntdPGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5BFE9tjK022316;
	Mon, 15 Dec 2025 23:09:55 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5BFE9tkd022310
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:09:55 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9b4ce0df-1fbf-4052-9eb9-1f3d6ad6a685@I-love.SAKURA.ne.jp>
Date: Mon, 15 Dec 2025 23:09:54 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [not-yet-signed PATCH] RDMA/core: flush gid_cache_wq WQ from
 disable_device()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Majd Dibbiny <majd@mellanox.com>, Doug Ledford <dledford@redhat.com>,
        Yuval Shaia <yuval.shaia@oracle.com>
Cc: Bernard Metzler <bernard.metzler@linux.dev>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
References: <30ec01df-6c32-490c-aa26-c41653f5a257@I-love.SAKURA.ne.jp>
 <8f90fba8-60b9-46e2-8990-45311c7b1540@I-love.SAKURA.ne.jp>
 <1722eff3-14c1-408b-999b-1be3e8fbfe5a@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <1722eff3-14c1-408b-999b-1be3e8fbfe5a@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav304.rs.sakura.ne.jp

On 2025/12/11 22:24, Tetsuo Handa wrote:
> Since a reproducer for this bug is not available, I haven't verified
> whether this is a bug syzbot is currently reporting in
> https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84 .
> But I'd like to add Reported-by: syzbot if netdevice_event_work_handler()
> is supposed to be called for releasing GID entry upon NETDEV_UNREGISTER
> event. Thus, please review this change.

I can observe using simple atomic_t counters that there are sometimes pending
netdevice_event() works as of immediately before clearing DEVICE_REGISTERED flag.
That is, clearing DEVICE_REGISTERED flag without flushing pending netdevice_event()
works results in failing to process some of netdev events.

I considered resolving DEVICE_REGISTERED flag inside netdevice_event() and then
flush pending netdevice_event() works after clearing DEVICE_REGISTERED flag (diff
is shown below). But I immediately got circular locking dependency problem by just
executing "rdma link add siw0 type siw netdev lo" command line. Therefore, I guess
that the reason RDMA code defers netdevice_event() handling to WQ context is to
avoid circular locking dependency problem. But I guess that due to lack of reliable
flushing mechanism when clearing DEVICE_REGISTERED flag, sometimes operations for
deleting GID entry are not invoked, and syzbot is reporting refcount leak...

 drivers/infiniband/core/core_priv.h     |    5 +++++
 drivers/infiniband/core/device.c        |   12 ++++++++++++
 drivers/infiniband/core/roce_gid_mgmt.c |   45 ++++++++++++++++++++++++++-------------------
 3 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 05102769a918..96ccfeb85547 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -99,6 +99,11 @@ void ib_enum_all_roce_netdevs(roce_netdev_filter filter,
 			      void *filter_cookie,
 			      roce_netdev_callback cb,
 			      void *cookie);
+extern struct workqueue_struct *gid_cache_wq;
+struct netdev_event_work_cmd;
+void roce_reserve_netdev_callback(struct ib_device *ib_dev, struct netdev_event_work_cmd *cmds,
+				  struct net_device *ndev);
+void ib_reserve_enum_all_roce_netdevs(struct netdev_event_work_cmd *cmds, struct net_device *ndev);
 
 typedef int (*nldev_callback)(struct ib_device *device,
 			      struct sk_buff *skb,
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 13e8a1714bbd..1817a6d207d1 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1303,6 +1303,7 @@ static void disable_device(struct ib_device *device)
 	down_write(&devices_rwsem);
 	xa_clear_mark(&devices, device->index, DEVICE_REGISTERED);
 	up_write(&devices_rwsem);
+	flush_workqueue(gid_cache_wq);
 
 	/*
 	 * Remove clients in LIFO order, see assign_client_id. This could be
@@ -2446,6 +2447,17 @@ void ib_enum_all_roce_netdevs(roce_netdev_filter filter,
 	up_read(&devices_rwsem);
 }
 
+void ib_reserve_enum_all_roce_netdevs(struct netdev_event_work_cmd *cmds, struct net_device *ndev)
+{
+	struct ib_device *dev;
+	unsigned long index;
+
+	down_read(&devices_rwsem);
+	xa_for_each_marked(&devices, index, dev, DEVICE_REGISTERED)
+		roce_reserve_netdev_callback(dev, cmds, ndev);
+	up_read(&devices_rwsem);
+}
+
 /*
  * ib_enum_all_devs - enumerate all ib_devices
  * @cb: Callback to call for each found ib_device
diff --git a/drivers/infiniband/core/roce_gid_mgmt.c b/drivers/infiniband/core/roce_gid_mgmt.c
index a9f2c6b1b29e..371f3bc564eb 100644
--- a/drivers/infiniband/core/roce_gid_mgmt.c
+++ b/drivers/infiniband/core/roce_gid_mgmt.c
@@ -42,7 +42,7 @@
 #include <rdma/ib_cache.h>
 #include <rdma/ib_addr.h>
 
-static struct workqueue_struct *gid_cache_wq;
+struct workqueue_struct *gid_cache_wq;
 
 enum gid_op_type {
 	GID_DEL = 0,
@@ -69,6 +69,12 @@ struct netdev_event_work {
 	struct netdev_event_work_cmd	cmds[ROCE_NETDEV_CALLBACK_SZ];
 };
 
+struct netdev_event_work2 {
+	struct work_struct		work;
+	struct ib_device		*ib_dev;
+	struct netdev_event_work_cmd	cmds[ROCE_NETDEV_CALLBACK_SZ];
+};
+
 static const struct {
 	bool (*is_supported)(const struct ib_device *device, u32 port_num);
 	enum ib_gid_type gid_type;
@@ -633,39 +639,41 @@ static void del_netdev_default_ips_join(struct ib_device *ib_dev, u32 port,
 	}
 }
 
-/* The following functions operate on all IB devices. netdevice_event and
- * addr_event execute ib_enum_all_roce_netdevs through a work.
+/* The following functions operate on all IB devices.
+ * netdevice_event executes ib_enum_roce_netdev through netdev_event_work2.
+ * addr_event executes ib_enum_all_roce_netdevs through update_gid_event_work.
  * ib_enum_all_roce_netdevs iterates through all IB devices.
  */
 
 static void netdevice_event_work_handler(struct work_struct *_work)
 {
-	struct netdev_event_work *work =
-		container_of(_work, struct netdev_event_work, work);
+	struct netdev_event_work2 *work =
+		container_of(_work, struct netdev_event_work2, work);
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(work->cmds) && work->cmds[i].cb; i++) {
-		ib_enum_all_roce_netdevs(work->cmds[i].filter,
-					 work->cmds[i].filter_ndev,
-					 work->cmds[i].cb,
-					 work->cmds[i].ndev);
+		ib_enum_roce_netdev(work->ib_dev,
+				    work->cmds[i].filter,
+				    work->cmds[i].filter_ndev,
+				    work->cmds[i].cb,
+				    work->cmds[i].ndev);
 		dev_put(work->cmds[i].ndev);
 		dev_put(work->cmds[i].filter_ndev);
 	}
 
+	ib_device_put(work->ib_dev); /* Acquired by roce_reserve_netdev_callback(). */
 	kfree(work);
 }
 
-static int netdevice_queue_work(struct netdev_event_work_cmd *cmds,
-				struct net_device *ndev)
+void roce_reserve_netdev_callback(struct ib_device *ib_dev, struct netdev_event_work_cmd *cmds,
+				  struct net_device *ndev)
 {
 	unsigned int i;
-	struct netdev_event_work *ndev_work =
-		kmalloc(sizeof(*ndev_work), GFP_KERNEL);
-
-	if (!ndev_work)
-		return NOTIFY_DONE;
+	struct netdev_event_work2 *ndev_work =
+		kmalloc(sizeof(*ndev_work), GFP_KERNEL | __GFP_NOFAIL);
 
+	refcount_inc(&ib_dev->refcount); /* Dropped by netdevice_event_work_handler(). */
+	ndev_work->ib_dev = ib_dev;
 	memcpy(ndev_work->cmds, cmds, sizeof(ndev_work->cmds));
 	for (i = 0; i < ARRAY_SIZE(ndev_work->cmds) && ndev_work->cmds[i].cb; i++) {
 		if (!ndev_work->cmds[i].ndev)
@@ -678,8 +686,6 @@ static int netdevice_queue_work(struct netdev_event_work_cmd *cmds,
 	INIT_WORK(&ndev_work->work, netdevice_event_work_handler);
 
 	queue_work(gid_cache_wq, &ndev_work->work);
-
-	return NOTIFY_DONE;
 }
 
 static const struct netdev_event_work_cmd add_cmd = {
@@ -820,7 +826,8 @@ static int netdevice_event(struct notifier_block *this, unsigned long event,
 		return NOTIFY_DONE;
 	}
 
-	return netdevice_queue_work(cmds, ndev);
+	ib_reserve_enum_all_roce_netdevs(cmds, ndev);
+	return NOTIFY_DONE;
 }
 
 static void update_gid_event_work_handler(struct work_struct *_work)


[   T1228] SoftiWARP attached
[   T1222] lo speed is unknown, defaulting to 1000
[   T1222] lo speed is unknown, defaulting to 1000
[   T1222] lo speed is unknown, defaulting to 1000

[   T1222] ======================================================
[   T1222] WARNING: possible circular locking dependency detected
[   T1222] 6.19.0-rc1-dirty #232 Not tainted
[   T1222] ------------------------------------------------------
[   T1222] rdma/1222 is trying to acquire lock:
[   T1222] ffffffffba281a28 (rtnl_mutex){+.+.}-{4:4}, at: ib_get_eth_speed+0x7a/0x360 [ib_core]
[   T1222] 
           but task is already holding lock:
[   T1222] ffff88d54bd34fa8 (&device->compat_devs_mutex){+.+.}-{4:4}, at: add_one_compat_dev+0x72/0x380 [ib_core]
[   T1222] 
           which lock already depends on the new lock.

[   T1222] 
           the existing dependency chain (in reverse order) is:
[   T1222] 
           -> #3 (&device->compat_devs_mutex){+.+.}-{4:4}:
[   T1222]        __lock_acquire+0x56d/0xbe0
[   T1222]        lock_acquire.part.0+0x78/0x1c0
[   T1222]        __mutex_lock+0xc7/0x10b0
[   T1222]        add_one_compat_dev+0x72/0x380 [ib_core]
[   T1222]        enable_device_and_get+0x1a4/0x200 [ib_core]
[   T1222]        ib_register_device+0xf3/0x260 [ib_core]
[   T1222]        siw_newlink+0xa4/0x140 [siw]
[   T1222]        nldev_newlink+0x1d9/0x300 [ib_core]
[   T1222]        rdma_nl_rcv_msg+0x12f/0x2f0 [ib_core]
[   T1222]        rdma_nl_rcv_skb.constprop.0.isra.0+0xb2/0x100 [ib_core]
[   T1222]        netlink_unicast+0x203/0x2e0
[   T1222]        netlink_sendmsg+0x1f8/0x420
[   T1222]        sock_sendmsg_nosec+0x81/0x90
[   T1222]        __sys_sendto+0x125/0x180
[   T1222]        __x64_sys_sendto+0x24/0x30
[   T1222]        do_syscall_64+0x98/0x3c0
[   T1222]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   T1222] 
           -> #2 (rdma_nets_rwsem){.+.+}-{4:4}:
[   T1222]        __lock_acquire+0x56d/0xbe0
[   T1222]        lock_acquire.part.0+0x78/0x1c0
[   T1222]        down_read+0x31/0x150
[   T1222]        enable_device_and_get+0x147/0x200 [ib_core]
[   T1222]        ib_register_device+0xf3/0x260 [ib_core]
[   T1222]        siw_newlink+0xa4/0x140 [siw]
[   T1222]        nldev_newlink+0x1d9/0x300 [ib_core]
[   T1222]        rdma_nl_rcv_msg+0x12f/0x2f0 [ib_core]
[   T1222]        rdma_nl_rcv_skb.constprop.0.isra.0+0xb2/0x100 [ib_core]
[   T1222]        netlink_unicast+0x203/0x2e0
[   T1222]        netlink_sendmsg+0x1f8/0x420
[   T1222]        sock_sendmsg_nosec+0x81/0x90
[   T1222]        __sys_sendto+0x125/0x180
[   T1222]        __x64_sys_sendto+0x24/0x30
[   T1222]        do_syscall_64+0x98/0x3c0
[   T1222]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   T1222] 
           -> #1 (devices_rwsem){++++}-{4:4}:
[   T1222]        __lock_acquire+0x56d/0xbe0
[   T1222]        lock_acquire.part.0+0x78/0x1c0
[   T1222]        down_read+0x31/0x150
[   T1222]        ib_reserve_enum_all_roce_netdevs+0x36/0xc0 [ib_core]
[   T1222]        netdevice_event+0x114/0x240 [ib_core]
[   T1222]        call_netdevice_register_net_notifiers+0x79/0x1b0
[   T1222]        register_netdevice_notifier+0x8e/0x130
[   T1222]        0xffffffffc08992a4
[   T1222]        0xffffffffc089918f
[   T1222]        do_one_initcall+0x70/0x380
[   T1222]        do_init_module+0x84/0x260
[   T1222]        init_module_from_file+0xd3/0xf0
[   T1222]        idempotent_init_module+0x11a/0x310
[   T1222]        __x64_sys_finit_module+0x71/0xe0
[   T1222]        do_syscall_64+0x98/0x3c0
[   T1222]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   T1222] 
           -> #0 (rtnl_mutex){+.+.}-{4:4}:
[   T1222]        check_prev_add+0xe1/0xca0
[   T1222]        validate_chain+0x52c/0x7e0
[   T1222]        __lock_acquire+0x56d/0xbe0
[   T1222]        lock_acquire.part.0+0x78/0x1c0
[   T1222]        __mutex_lock+0xc7/0x10b0
[   T1222]        ib_get_eth_speed+0x7a/0x360 [ib_core]
[   T1222]        siw_query_port+0x4b/0x190 [siw]
[   T1222]        ib_setup_port_attrs+0x99/0x250 [ib_core]
[   T1222]        add_one_compat_dev+0x286/0x380 [ib_core]
[   T1222]        enable_device_and_get+0x1a4/0x200 [ib_core]
[   T1222]        ib_register_device+0xf3/0x260 [ib_core]
[   T1222]        siw_newlink+0xa4/0x140 [siw]
[   T1222]        nldev_newlink+0x1d9/0x300 [ib_core]
[   T1222]        rdma_nl_rcv_msg+0x12f/0x2f0 [ib_core]
[   T1222]        rdma_nl_rcv_skb.constprop.0.isra.0+0xb2/0x100 [ib_core]
[   T1222]        netlink_unicast+0x203/0x2e0
[   T1222]        netlink_sendmsg+0x1f8/0x420
[   T1222]        sock_sendmsg_nosec+0x81/0x90
[   T1222]        __sys_sendto+0x125/0x180
[   T1222]        __x64_sys_sendto+0x24/0x30
[   T1222]        do_syscall_64+0x98/0x3c0
[   T1222]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   T1222] 
           other info that might help us debug this:

[   T1222] Chain exists of:
             rtnl_mutex --> rdma_nets_rwsem --> &device->compat_devs_mutex

[   T1222]  Possible unsafe locking scenario:

[   T1222]        CPU0                    CPU1
[   T1222]        ----                    ----
[   T1222]   lock(&device->compat_devs_mutex);
[   T1222]                                lock(rdma_nets_rwsem);
[   T1222]                                lock(&device->compat_devs_mutex);
[   T1222]   lock(rtnl_mutex);
[   T1222] 
            *** DEADLOCK ***

[   T1222] 5 locks held by rdma/1222:
[   T1222]  #0: ffffffffc0ae1b18 (&rdma_nl_types[idx].sem){.+.+}-{4:4}, at: rdma_nl_rcv_msg+0x9e/0x2f0 [ib_core]
[   T1222]  #1: ffffffffc0ae8a30 (link_ops_rwsem){++++}-{4:4}, at: nldev_newlink+0x278/0x300 [ib_core]
[   T1222]  #2: ffffffffc0ae3e50 (devices_rwsem){++++}-{4:4}, at: enable_device_and_get+0x5c/0x200 [ib_core]
[   T1222]  #3: ffffffffc0ae3c50 (rdma_nets_rwsem){.+.+}-{4:4}, at: enable_device_and_get+0x147/0x200 [ib_core]
[   T1222]  #4: ffff88d54bd34fa8 (&device->compat_devs_mutex){+.+.}-{4:4}, at: add_one_compat_dev+0x72/0x380 [ib_core]
[   T1222] 
           stack backtrace:
[   T1222] CPU: 5 UID: 0 PID: 1222 Comm: rdma Not tainted 6.19.0-rc1-dirty #232 PREEMPT(voluntary) 
[   T1222] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[   T1222] Call Trace:
[   T1222]  <TASK>
[   T1222]  dump_stack_lvl+0x6e/0xa0
[   T1222]  print_circular_bug.cold+0x38/0x46
[   T1222]  check_noncircular+0x148/0x170
[   T1222]  check_prev_add+0xe1/0xca0
[   T1222]  ? is_bpf_text_address+0x6e/0x100
[   T1222]  ? kernel_text_address+0x120/0x130
[   T1222]  validate_chain+0x52c/0x7e0
[   T1222]  __lock_acquire+0x56d/0xbe0
[   T1222]  lock_acquire.part.0+0x78/0x1c0
[   T1222]  ? ib_get_eth_speed+0x7a/0x360 [ib_core]
[   T1222]  __mutex_lock+0xc7/0x10b0
[   T1222]  ? ib_get_eth_speed+0x7a/0x360 [ib_core]
[   T1222]  ? find_held_lock+0x2b/0x80
[   T1222]  ? ib_get_eth_speed+0x7a/0x360 [ib_core]
[   T1222]  ? ib_get_eth_speed+0x7a/0x360 [ib_core]
[   T1222]  ib_get_eth_speed+0x7a/0x360 [ib_core]
[   T1222]  ? netlink_sendmsg+0x1f8/0x420
[   T1222]  siw_query_port+0x4b/0x190 [siw]
[   T1222]  ib_setup_port_attrs+0x99/0x250 [ib_core]
[   T1222]  add_one_compat_dev+0x286/0x380 [ib_core]
[   T1222]  enable_device_and_get+0x1a4/0x200 [ib_core]
[   T1222]  ib_register_device+0xf3/0x260 [ib_core]
[   T1222]  siw_newlink+0xa4/0x140 [siw]
[   T1222]  nldev_newlink+0x1d9/0x300 [ib_core]
[   T1222]  rdma_nl_rcv_msg+0x12f/0x2f0 [ib_core]
[   T1222]  ? __lock_acquire+0x56d/0xbe0
[   T1222]  rdma_nl_rcv_skb.constprop.0.isra.0+0xb2/0x100 [ib_core]
[   T1222]  netlink_unicast+0x203/0x2e0
[   T1222]  netlink_sendmsg+0x1f8/0x420
[   T1222]  sock_sendmsg_nosec+0x81/0x90
[   T1222]  __sys_sendto+0x125/0x180
[   T1222]  __x64_sys_sendto+0x24/0x30
[   T1222]  do_syscall_64+0x98/0x3c0
[   T1222]  ? switch_fpu_return+0xd6/0x100
[   T1222]  ? do_syscall_64+0x16d/0x3c0
[   T1222]  ? lockdep_hardirqs_on_prepare.part.0+0x9b/0x140
[   T1222]  ? irqentry_exit+0x8c/0x5b0
[   T1222]  ? trace_hardirqs_off+0x44/0xa0
[   T1222]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   T1222] RIP: 0033:0x7f38bc63d77e
[   T1222] Code: 4d 89 d8 e8 d4 bc 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[   T1222] RSP: 002b:00007ffd972ef0b0 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[   T1222] RAX: ffffffffffffffda RBX: 00005612aac892d0 RCX: 00007f38bc63d77e
[   T1222] RDX: 000000000000002c RSI: 00005612aac882a0 RDI: 0000000000000004
[   T1222] RBP: 00007ffd972ef0c0 R08: 00007f38bc7d19a0 R09: 000000000000000c
[   T1222] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffd972ef380
[   T1222] R13: 00007ffd972ef3d8 R14: 00007ffd972f15ba R15: 0000000069401105
[   T1222]  </TASK>
[   T1222] lo speed is unknown, defaulting to 1000
[   T1222] lo speed is unknown, defaulting to 1000
[   T1222] lo speed is unknown, defaulting to 1000


