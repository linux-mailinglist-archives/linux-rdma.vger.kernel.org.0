Return-Path: <linux-rdma+bounces-15033-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D90CC3BBB
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 15:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 549FA30699ED
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 14:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A139E3385A8;
	Tue, 16 Dec 2025 14:41:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6AA336EF0
	for <linux-rdma@vger.kernel.org>; Tue, 16 Dec 2025 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765896078; cv=none; b=WDKpGJnKXZ0FvsNTr/4tQOTlGAPny2Xoj6QA+xmFTuKK2YGJ49FElYYOtnva02IdjoVPqUkQJ6Tmo+H8piQwTJlZ/yGRNpuHT1gHzpPp2mTn0IN+dWCK5PYYIC7X6jqrlMC1HI9qnCeFJwzSQ/cNjZFbfU/X26QmqpLNvTn2cVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765896078; c=relaxed/simple;
	bh=b1k+1VZGu+5jj64DAxHNDoZ4uxvQQI5DwLS8flan4TU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AeSjhOCNf0pw2OewfwJt1mFCmgWJ06VoTCWOeC1UWcQ2O2z/ZMj4RiayO7VUX8TGdgyvlEJKGVsy5bESSNzhuO/AdDyKCXMdsNJ0njWEp7jkqdYUhk7GjqT7a61dwI2fTTAlv1PbH1WHbloExjL7AM/LWWCSTcaY3xljXfNUpdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5BGEcdcI065864;
	Tue, 16 Dec 2025 23:38:39 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5BGEcc9d065861
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 16 Dec 2025 23:38:38 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <10caea5b-9ad1-44ce-9eaf-a0f4023f2017@I-love.SAKURA.ne.jp>
Date: Tue, 16 Dec 2025 23:38:37 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] RDMA/core: flush gid_cache_wq WQ from disable_device()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Majd Dibbiny <majd@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, Yuval Shaia <yshaia@marvell.com>,
        Bernard Metzler <bernard.metzler@linux.dev>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
References: <30ec01df-6c32-490c-aa26-c41653f5a257@I-love.SAKURA.ne.jp>
 <8f90fba8-60b9-46e2-8990-45311c7b1540@I-love.SAKURA.ne.jp>
 <1722eff3-14c1-408b-999b-1be3e8fbfe5a@I-love.SAKURA.ne.jp>
 <9b4ce0df-1fbf-4052-9eb9-1f3d6ad6a685@I-love.SAKURA.ne.jp>
 <13f54775-7a36-48f2-b9cd-62ab9f15a82b@I-love.SAKURA.ne.jp>
 <ace1ebe4-4fdb-49f4-a3fa-bbf11e1b40ed@I-love.SAKURA.ne.jp>
 <20251216140512.GC6079@nvidia.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20251216140512.GC6079@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav203.rs.sakura.ne.jp

syzbot is reporting a net_device refcount leak in RDMA code.
A debug printk() patch reported that ib_enum_roce_netdev() is called for
allocating GID entry but is not called for releasing GID entry.
This result suggests that something is preventing ib_enum_roce_netdev()
 from ib_enum_all_roce_netdevs() from netdevice_event_work_handler() from
being called when releasing GID entry.

Commit 03db3a2d81e6 ("IB/core: Add RoCE GID table management") introduced
ib_enum_all_roce_netdevs(), but calling this function asynchronously from
WQ context is racy. I can observe using simple atomic_t counters that there
are sometimes pending netdevice_event() works as of immediately before
clearing DEVICE_REGISTERED flag in disable_device() from
__ib_unregister_device(). If pending works contained ib_enum_roce_netdev()
call for releasing GID entry, this race can result in a net_device refcount
leak.

Therefore, flush pending works immediately before clearing
DEVICE_REGISTERED flag.

Also, since commit 8fe8bacb92f2 ("IB/core: Add ordered workqueue for RoCE
GID management") was intended to ensure that netdev events are processed
in the order netdevice_event() is called, failing to invoke corresponding
event handler due to memory allocation failure is as bad as processing
netdev events in parallel.

Therefore, add __GFP_NOFAIL when allocating memory for a work for netdev
events.

Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
Fixes: 03db3a2d81e6 ("IB/core: Add RoCE GID table management")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
I haven't confirmed that netdevice_event_work_handler() is called for
releasing GID entry.
But I'd like to try this patch in linux-next tree via my tree for testing.

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



