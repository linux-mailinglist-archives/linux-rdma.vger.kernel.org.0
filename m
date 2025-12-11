Return-Path: <linux-rdma+bounces-14959-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEDDCB6020
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Dec 2025 14:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 221F53014100
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Dec 2025 13:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4443126A0;
	Thu, 11 Dec 2025 13:25:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5409F2F5473;
	Thu, 11 Dec 2025 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765459551; cv=none; b=pEGL3uYx069DgMy2ALuN5BeK9wFhg4F+FdE2urKK6OhkbFKohDzmM0IqxSpS+2xxDy5D96Shkb0Ha6aduq3JziIQG1dRBlS+8isyuVgg2+HJ4pPPf+Fp/04EIO9NA99mA2dZZVeDQ+odC7KmuNvJLBH5oHa1hXgiru63UXBc/Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765459551; c=relaxed/simple;
	bh=VLBhCFygsztsQ8BtAiJ2nMgwMLnuq8LlPDi0Qvj7P+o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=kBITxBbN9hXhRDiHBbOjTllW/OL/Xb58FK5sf293WHslSBR5L4H8UV2H4B2rxw6Jd/KJs4Y5nXazXK82WhtaAHTbyyzHDzS8IXryP+yuKqPIZJ3VxnBwGwemEkGK6Iz7Oj3UK1lC9edlvwtoIEqwCF+eEUL/ubuQL75JHnYuvjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5BBDP2Rv008491;
	Thu, 11 Dec 2025 22:25:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5BBDP2MI008482
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 11 Dec 2025 22:25:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1722eff3-14c1-408b-999b-1be3e8fbfe5a@I-love.SAKURA.ne.jp>
Date: Thu, 11 Dec 2025 22:24:59 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [not-yet-signed PATCH] RDMA/core: flush gid_cache_wq WQ from
 disable_device()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Majd Dibbiny <majd@mellanox.com>, Doug Ledford <dledford@redhat.com>,
        Yuval Shaia <yuval.shaia@oracle.com>
References: <30ec01df-6c32-490c-aa26-c41653f5a257@I-love.SAKURA.ne.jp>
 <8f90fba8-60b9-46e2-8990-45311c7b1540@I-love.SAKURA.ne.jp>
Content-Language: en-US
Cc: Bernard Metzler <bernard.metzler@linux.dev>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
In-Reply-To: <8f90fba8-60b9-46e2-8990-45311c7b1540@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav202.rs.sakura.ne.jp
X-Virus-Status: clean

syzbot is reporting a net_device refcount leak in RDMA code.
A debug printk() patch in next-20251204 reported that there is a refcount
leak in ib_gid_table_entry handling. Another debug printk() patch in
next-20251210 reported that netdevice_event_work_handler() is called for
allocating GID entry but is not called for releasing GID entry.

  unregister_netdevice: waiting for ipvlan0 to become free. Usage count = 5
  Call trace for ipvlan0@ffff888076d9da00 +1 at
       alloc_gid_entry drivers/infiniband/core/cache.c:410 [inline]
       add_modify_gid+0x317/0xcc0 drivers/infiniband/core/cache.c:550
       __ib_cache_gid_add+0x230/0x370 drivers/infiniband/core/cache.c:681
       ib_cache_gid_set_default_gid+0x5f9/0x710 drivers/infiniband/core/cache.c:960
       ib_enum_roce_netdev+0x1ab/0x2e0 drivers/infiniband/core/device.c:2451
       ib_enum_all_roce_netdevs+0xcc/0x160 drivers/infiniband/core/device.c:2477
       netdevice_event_work_handler+0xef/0x260 drivers/infiniband/core/roce_gid_mgmt.c:660
       process_one_work+0x93a/0x15a0 kernel/workqueue.c:3279
  Call trace for ipvlan0@ffff888076d9de00 +1 at
       alloc_gid_entry drivers/infiniband/core/cache.c:410 [inline]
       add_modify_gid+0x317/0xcc0 drivers/infiniband/core/cache.c:550
       __ib_cache_gid_add+0x230/0x370 drivers/infiniband/core/cache.c:681
       update_gid drivers/infiniband/core/roce_gid_mgmt.c:110 [inline]
       update_gid_ip drivers/infiniband/core/roce_gid_mgmt.c:294 [inline]
       enum_netdev_ipv4_ips drivers/infiniband/core/roce_gid_mgmt.c:368 [inline]
       _add_netdev_ips+0x98c/0x1560 drivers/infiniband/core/roce_gid_mgmt.c:424
       ib_enum_roce_netdev+0x1ab/0x2e0 drivers/infiniband/core/device.c:2451
       ib_enum_all_roce_netdevs+0xcc/0x160 drivers/infiniband/core/device.c:2477
       netdevice_event_work_handler+0xef/0x260 drivers/infiniband/core/roce_gid_mgmt.c:660
       process_one_work+0x93a/0x15a0 kernel/workqueue.c:3279
  Call trace for ipvlan0@ffff888031e4eb00 +1 at
       alloc_gid_entry drivers/infiniband/core/cache.c:410 [inline]
       add_modify_gid+0x317/0xcc0 drivers/infiniband/core/cache.c:550
       __ib_cache_gid_add+0x230/0x370 drivers/infiniband/core/cache.c:681
       update_gid drivers/infiniband/core/roce_gid_mgmt.c:110 [inline]
       enum_netdev_ipv6_ips drivers/infiniband/core/roce_gid_mgmt.c:415 [inline]
       _add_netdev_ips+0x12d9/0x1560 drivers/infiniband/core/roce_gid_mgmt.c:426
       ib_enum_roce_netdev+0x1ab/0x2e0 drivers/infiniband/core/device.c:2451
       ib_enum_all_roce_netdevs+0xcc/0x160 drivers/infiniband/core/device.c:2477
       netdevice_event_work_handler+0xef/0x260 drivers/infiniband/core/roce_gid_mgmt.c:660
       process_one_work+0x93a/0x15a0 kernel/workqueue.c:3279
  Call trace for ipvlan0@ffff888076d9da00 +1 at
       get_gid_entry drivers/infiniband/core/cache.c:435 [inline]
       rdma_get_gid_attr+0x2ee/0x3f0 drivers/infiniband/core/cache.c:1300
       smc_ib_fill_mac net/smc/smc_ib.c:160 [inline]
       smc_ib_remember_port_attr net/smc/smc_ib.c:369 [inline]
       smc_ib_port_event_work+0x196/0x940 net/smc/smc_ib.c:388
       process_one_work+0x93a/0x15a0 kernel/workqueue.c:3279
  Call trace for ipvlan0@ffff888076d9da00 -1 at
       put_gid_entry drivers/infiniband/core/cache.c:441 [inline]
       rdma_put_gid_attr+0x7c/0x130 drivers/infiniband/core/cache.c:1381
       smc_ib_fill_mac net/smc/smc_ib.c:165 [inline]
       smc_ib_remember_port_attr net/smc/smc_ib.c:369 [inline]
       smc_ib_port_event_work+0x1d4/0x940 net/smc/smc_ib.c:388
       process_one_work+0x93a/0x15a0 kernel/workqueue.c:3279
  balance for ipvlan0@ib_gid_table_entry is 3

If netdevice_event_work_handler() is supposed to be called for releasing
GID entry upon NETDEV_UNREGISTER event, we can consider that something is
preventing ib_enum_all_roce_netdevs() from being called. And I found
possible race window explained below.

Since ib_enum_all_roce_netdevs() uses xa_for_each_marked(DEVICE_REGISTERED)
with devices_rwsem held for read, we need to ensure that all works queued
by netdevice_event(NETDEV_UNREGISTER) completes before disable_device()
calls xa_clear_mark(DEVICE_REGISTERED) with devices_rwsem held for write.
Otherwise, ib_enum_all_roce_netdevs() will fail to find devices for
NETDEV_UNREGISTER event (which is needed for dropping a refcount on
ib_gid_table_entry which is holding a refcount on net_device).

Since flush_workqueue(gid_cache_wq) is not called before disable_device()
calls xa_clear_mark(), and commit 8fe8bacb92f2 ("IB/core: Add ordered
workqueue for RoCE GID management") introduced gid_cache_wq as ordered,
possibility of failing to complete some of works before xa_clear_mark() is
called might not be negligible. Therefore, flush gid_cache_wq WQ before
disable_device() calls xa_clear_mark().

Also, add __GFP_NOFAIL when allocating memory for a work for netdev events.
Since that commit is intended to ensure that netdev events are processed
in the order netdevice_event() is called, failing to invoke corresponding
event handler due to memory allocation failure is as bad as processing
netdev events in parallel.
---
Since a reproducer for this bug is not available, I haven't verified
whether this is a bug syzbot is currently reporting in
https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84 .
But I'd like to add Reported-by: syzbot if netdevice_event_work_handler()
is supposed to be called for releasing GID entry upon NETDEV_UNREGISTER
event. Thus, please review this change.

 drivers/infiniband/core/core_priv.h     |  1 +
 drivers/infiniband/core/device.c        |  1 +
 drivers/infiniband/core/roce_gid_mgmt.c | 10 ++++++----
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 05102769a918..8355020bb98a 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -142,6 +142,7 @@ int ib_cache_gid_del_all_netdev_gids(struct ib_device *ib_dev, u32 port,
 
 int roce_gid_mgmt_init(void);
 void roce_gid_mgmt_cleanup(void);
+void roce_flush_gid_cache_wq(void);
 
 unsigned long roce_gid_type_mask_support(struct ib_device *ib_dev, u32 port);
 
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 13e8a1714bbd..8638583a64f2 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1300,6 +1300,7 @@ static void disable_device(struct ib_device *device)
 
 	WARN_ON(!refcount_read(&device->refcount));
 
+	roce_flush_gid_cache_wq();
 	down_write(&devices_rwsem);
 	xa_clear_mark(&devices, device->index, DEVICE_REGISTERED);
 	up_write(&devices_rwsem);
diff --git a/drivers/infiniband/core/roce_gid_mgmt.c b/drivers/infiniband/core/roce_gid_mgmt.c
index a9f2c6b1b29e..79982d448cd2 100644
--- a/drivers/infiniband/core/roce_gid_mgmt.c
+++ b/drivers/infiniband/core/roce_gid_mgmt.c
@@ -661,10 +661,7 @@ static int netdevice_queue_work(struct netdev_event_work_cmd *cmds,
 {
 	unsigned int i;
 	struct netdev_event_work *ndev_work =
-		kmalloc(sizeof(*ndev_work), GFP_KERNEL);
-
-	if (!ndev_work)
-		return NOTIFY_DONE;
+		kmalloc(sizeof(*ndev_work), GFP_KERNEL | __GFP_NOFAIL);
 
 	memcpy(ndev_work->cmds, cmds, sizeof(ndev_work->cmds));
 	for (i = 0; i < ARRAY_SIZE(ndev_work->cmds) && ndev_work->cmds[i].cb; i++) {
@@ -948,3 +945,8 @@ void __exit roce_gid_mgmt_cleanup(void)
 	 */
 	destroy_workqueue(gid_cache_wq);
 }
+
+void roce_flush_gid_cache_wq(void)
+{
+	flush_workqueue(gid_cache_wq);
+}
-- 
2.47.3



