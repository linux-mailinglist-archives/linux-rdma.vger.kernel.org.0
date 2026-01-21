Return-Path: <linux-rdma+bounces-15835-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CtxGJPkcGk+awAAu9opvQ
	(envelope-from <linux-rdma+bounces-15835-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 15:37:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 578C758850
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 15:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA5C082F153
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 14:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A83230BF52;
	Wed, 21 Jan 2026 14:00:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B8D1D5174
	for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769004020; cv=none; b=HK0Z724nyd05/shCv7KBjt6ANamM05yFsLvfG/z/6fpLx1GxNS3VAbvvayyjrPvIsczuVlXFX/kepIGK9Ad1bNGCnwWFkfPOxJnpdYPbvdjX2yudzy2cF4iegal5bicvzIrTpLox3p8jUtRaPXMLfkIxVyhqILtcCAYRTMQQh7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769004020; c=relaxed/simple;
	bh=Vzv0SqavBw40oYwbSGipwn6UwSgjqqUTMKTm1aEXNxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BcUB4oPjLRLzjNQ68w0hz4Q7pMiQhSZU+7qHI3IQnaEZ92LW7a9AKdM4s2gdRTvyXNLxbBp3P/c/32CuiAhAqXAZf8MGSdhJCQikb2TeT+m/4FzSFQxY5naV6XAkB9HqtZVAl+Gide9j9D7VmVwsEddq4J66bccuAS5MqmUjVo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60LDxmqI083988;
	Wed, 21 Jan 2026 22:59:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60LDxmIe083981
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 21 Jan 2026 22:59:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a5f2ea72-985a-425b-a626-cde052cd4cd9@I-love.SAKURA.ne.jp>
Date: Wed, 21 Jan 2026 22:59:45 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [rdma bug] del_default_gids() is not called upon
 NETDEV_UNREGISTER event
To: Parav Pandit <parav@mellanox.com>, Huy Nguyen <huyn@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Maher Sanalla <msanalla@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>
Cc: OFED mailing list <linux-rdma@vger.kernel.org>
References: <c1f9511c-7ad0-444d-aa0c-516674702b4e@I-love.SAKURA.ne.jp>
 <SJ0PR12MB6806E77B849859B7BAC8CC1CDC89A@SJ0PR12MB6806.namprd12.prod.outlook.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <SJ0PR12MB6806E77B849859B7BAC8CC1CDC89A@SJ0PR12MB6806.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav302.rs.sakura.ne.jp
X-Spamd-Result: default: False [-1.26 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-15835-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,I-love.SAKURA.ne.jp:mid]
X-Rspamd-Queue-Id: 578C758850
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026/01/20 20:43, Parav Pandit wrote:
> I haven’t thought through fully or analyse the code recently,
> gid_table_cleanup_one() should cleanup and release the reference anyway.
> If that is done correctly, the reference is held somewhere else.
> Isn’t it?

Indeed, even if del_gid() from _ib_cache_gid_del() from
ib_cache_gid_set_default_gid() from del_default_gids() is not called upon
NETDEV_UNREGISTER event, del_gid() from cleanup_gid_table_port() from
gid_table_cleanup_one() from ib_cache_cleanup_one() from __ib_unregister_device()
will release the reference.

But there is a possible pitfall; wait_for_completion() from disable_device() from
__ib_unregister_device() will hang if there is a refcount leak. Since the
"unregister_netdevice: waiting for" message is printed after 10 seconds from
start of netdev unregistration whereas the khungtaskd message is printed after
140 seconds from start of unintterruptible wait, we haven't confirmed whether
there is a refcount leak. If wait_for_completion() is blocked due to a refcount
leak, it will also prevent gid_table_cleanup_one() from ib_cache_cleanup_one()
 from being called.

> My suspect is the bug that you reported in [1] is the cause, i.e. the ib
> device REGISTERED and netdev event racing.

Looks like so, for del_gid() would have been called from
ib_cache_gid_del_all_netdev_gids() from del_netdev_ips() from
ib_enum_roce_netdev() from ib_enum_all_roce_netdevs() from
netdevice_event_work_handler() if we didn't hit this race.

Then,

> However, flushing the wq does not seem the robust solution either because
> right after flushing the netdev unregister event may arrive.

can we try something like below diff? This diff tries to expedite

	ndev_storage = entry->ndev_storage;
	if (ndev_storage) {
		entry->ndev_storage = NULL;
		rcu_assign_pointer(entry->attr.ndev, NULL);
		call_rcu(&ndev_storage->rcu_head, put_gid_ndev);
	}

logic in del_gid() without actually calling del_gid(), by calling
NETDEV_UNREGISTER event by polling NETREG_UNREGISTERING state.
I'd like to try using linux-next if you think this approach works.

 drivers/infiniband/core/cache.c  |   37 +++++++++++++++++++++++++++++++++++++
 drivers/infiniband/core/device.c |   13 +++++++++++++
 include/rdma/ib_verbs.h          |    3 +++
 3 files changed, 53 insertions(+)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 6aad66bc5dd7..cd7ca0762add 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2857,6 +2857,7 @@ struct ib_device {
 	refcount_t refcount;
 	struct completion unreg_completion;
 	struct work_struct unregistration_work;
+	struct work_struct netdev_unregistering_work;
 
 	const struct rdma_link_ops *link_ops;
 
@@ -5010,4 +5011,6 @@ static inline void ib_mark_name_assigned_by_user(struct ib_device *ibdev)
 	ibdev->name_assign_type = RDMA_NAME_ASSIGN_TYPE_USER;
 }
 
+void ib_check_netdev_unregistering(struct work_struct *work);
+
 #endif /* IB_VERBS_H */
diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 81cf3c902e81..aa1cebe07f1f 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1652,3 +1652,40 @@ void ib_cache_cleanup_one(struct ib_device *device)
 	 */
 	flush_workqueue(ib_wq);
 }
+
+void ib_check_netdev_unregistering(struct work_struct *work)
+{
+	struct ib_device *device = container_of(work, struct ib_device, netdev_unregistering_work);
+	u32 port;
+	struct ib_gid_table *table;
+	struct ib_gid_table_entry *entry;
+	struct roce_gid_ndev_storage *ndev_storage;
+	int ix;
+
+	rdma_for_each_port(device, port) {
+		table = rdma_gid_table(device, port);
+		mutex_lock(&table->lock);
+		for (ix = 0; ix < table->sz; ix++) {
+			write_lock_irq(&table->rwlock);
+			entry = table->data_vec[ix];
+			ndev_storage = entry->ndev_storage;
+			if (ndev_storage && ndev_storage->ndev &&
+			    ndev_storage->ndev->reg_state == NETREG_UNREGISTERING) {
+				entry->ndev_storage = NULL;
+				rcu_assign_pointer(entry->attr.ndev, NULL);
+			} else {
+				ndev_storage = NULL;
+			}
+			write_unlock_irq(&table->rwlock);
+			if (ndev_storage)
+				call_rcu(&ndev_storage->rcu_head, put_gid_ndev);
+		}
+		mutex_unlock(&table->lock);
+	}
+	if (refcount_read(&device->refcount) == 1) {
+		ib_device_put(device);
+		return;
+	}
+	schedule_timeout_uninterruptible(HZ / 2);
+	schedule_work(work);
+}
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 1174ab7da629..ce3d8ab42943 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1304,6 +1304,15 @@ static void disable_device(struct ib_device *device)
 	xa_clear_mark(&devices, device->index, DEVICE_REGISTERED);
 	up_write(&devices_rwsem);
 
+	/*
+	 * Start monitoring for NETDEV_UNREGISTER event, for netdevice_event(NETDEV_UNREGISTER)
+	 * for this device became no-op due to clearing DEVICE_REGISTERED mark. Monitoring will
+	 * stop after dropping refcount when refcount becomes 1.
+	 */
+	INIT_WORK(&device->netdev_unregistering_work, ib_check_netdev_unregistering);
+	refcount_inc(&device->refcount);
+	schedule_work(&device->netdev_unregistering_work);
+
 	/*
 	 * Remove clients in LIFO order, see assign_client_id. This could be
 	 * more efficient if xarray learns to reverse iterate. Since no new
@@ -1322,6 +1331,10 @@ static void disable_device(struct ib_device *device)
 
 	/* Pairs with refcount_set in enable_device */
 	ib_device_put(device);
+	/*
+	 * Monitoring will stop here unless there is a refcount leak.
+	 * The khungtaskd will complain if there is a refcount leak.
+	 */
 	wait_for_completion(&device->unreg_completion);
 
 	/*


