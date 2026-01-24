Return-Path: <linux-rdma+bounces-15941-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP+PFw2hdGmd8AAAu9opvQ
	(envelope-from <linux-rdma+bounces-15941-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Jan 2026 11:38:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9B17D429
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Jan 2026 11:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55B373012BDB
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Jan 2026 10:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A72258CE5;
	Sat, 24 Jan 2026 10:38:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7C33EBF3A
	for <linux-rdma@vger.kernel.org>; Sat, 24 Jan 2026 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769251080; cv=none; b=IeAy8Wv3xI/tsm9SudIfNCSZ/xBLnhU2NM+7MozP9m1AaCozooT4jP3URmhujpRTaTT9/NjFow+hGpjZ8sO0zX6E+yRpijEHaMl9+VkpLAKqFPqvmvP4Gh6Vvw/Hyr5BDQH3ephAwQmkHpaNAZGyvKj9XH7WBJM+S+ItMgtHMKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769251080; c=relaxed/simple;
	bh=KGXI6hVtjw7RMcTKSmN8RvNleI4H2qRYrhduA9/Rz+M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SSSWiRlEWHMuiBssECJlzuQWpmVMMqDEwa0n4B+l8sS2Kv53QsAL+/pkVl9cVHUUvb1Ng9EcTqxj1AT1ilV+YDGb8RsXnJdDDyiiw2vH8fNG2u0NAZESS9u0vXZsmgXyCO8qW1WgchrTDA+iPRApEnBkLyl63DWlXSVKwLb6qFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60OAbVH2045637;
	Sat, 24 Jan 2026 19:37:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60OAbV2E045634
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 24 Jan 2026 19:37:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b4a09ad8-97cc-4fe1-b02a-6192248694a8@I-love.SAKURA.ne.jp>
Date: Sat, 24 Jan 2026 19:37:31 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [rdma bug] del_default_gids() is not called upon
 NETDEV_UNREGISTER event
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Parav Pandit <parav@mellanox.com>, Huy Nguyen <huyn@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Maher Sanalla <msanalla@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>
Cc: OFED mailing list <linux-rdma@vger.kernel.org>
References: <c1f9511c-7ad0-444d-aa0c-516674702b4e@I-love.SAKURA.ne.jp>
 <SJ0PR12MB6806E77B849859B7BAC8CC1CDC89A@SJ0PR12MB6806.namprd12.prod.outlook.com>
 <a5f2ea72-985a-425b-a626-cde052cd4cd9@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <a5f2ea72-985a-425b-a626-cde052cd4cd9@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav205.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_FROM(0.00)[bounces-15941-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,I-love.SAKURA.ne.jp:mid]
X-Rspamd-Queue-Id: 5C9B17D429
X-Rspamd-Action: no action

I think that the diff shown below makes the NETDEV_UNREGISTER event handler
valid until wait_for_completion(&device->unreg_completion) in disable_device()
returns. What do you think about this change? Is this change safe?

Comparing gid_table_cleanup_one() and del_netdev_ips(), the latter seems
to be a subset of the former because of rdma_protocol_roce() check; the
NETDEV_UNREGISTER event handler can call dev_put() on only "struct net_device"
references where rdma_protocol_roce() returned true.

  int ib_cache_gid_del_all_netdev_gids(struct ib_device *ib_dev, u32 port,
                                       struct net_device *ndev)
  {
          struct ib_gid_table *table;
          int ix;
          bool deleted = false;
  
          table = rdma_gid_table(ib_dev, port);
  
          mutex_lock(&table->lock);
  
          for (ix = 0; ix < table->sz; ix++) {
                  if (is_gid_entry_valid(table->data_vec[ix]) &&
                      table->data_vec[ix]->attr.ndev == ndev) {
                          del_gid(ib_dev, port, table, ix);
                          deleted = true;
                  }
          }
  
          mutex_unlock(&table->lock);
  
          if (deleted)
                  dispatch_gid_change_event(ib_dev, port);
  
          return 0;
  }
  
  void ib_enum_roce_netdev(struct ib_device *ib_dev,
                           roce_netdev_filter filter,
                           void *filter_cookie,
                           roce_netdev_callback cb,
                           void *cookie)
  {
          u32 port;
  
          rdma_for_each_port(ib_dev, port)
                  if (rdma_protocol_roce(ib_dev, port))
                          ib_cache_gid_del_all_netdev_gids(ib_dev, port, cookie); // <= assume del_netdev_ips() case
  }
  
  static void cleanup_gid_table_port(struct ib_device *ib_dev, u32 port,
                                     struct ib_gid_table *table)
  {
          int i;
  
          if (!table)
                  return;
  
          mutex_lock(&table->lock);
          for (i = 0; i < table->sz; ++i) {
                  if (is_gid_entry_valid(table->data_vec[i]))
                          del_gid(ib_dev, port, table, i);
          }
          mutex_unlock(&table->lock);
  }
  
  static void gid_table_cleanup_one(struct ib_device *ib_dev)
  {
          u32 p;
  
          rdma_for_each_port(ib_dev, p)
                  cleanup_gid_table_port(ib_dev, p, ib_dev->port_data[p].cache.gid);
  }

Therefore, even if the diff shown below is safe, there will be a race window
where dev_put() cannot be called on some of "struct net_device" references in
the gid table.

Is there a guarantee that cleanup operations after
wait_for_completion(&device->unreg_completion) from disable_device() from
__ib_unregister_device() returned can continue running until
gid_table_cleanup_one() from __ib_unregister_device() returns?

 drivers/infiniband/core/core_priv.h     |    2 +-
 drivers/infiniband/core/device.c        |   12 +++++++++++-
 drivers/infiniband/core/roce_gid_mgmt.c |   11 +++++++----
 include/rdma/ib_verbs.h                 |    1 +
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 6aad66bc5dd7..2e3eacedfa9a 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2857,6 +2857,7 @@ struct ib_device {
 	refcount_t refcount;
 	struct completion unreg_completion;
 	struct work_struct unregistration_work;
+	struct work_struct netdev_unregistering_work;
 
 	const struct rdma_link_ops *link_ops;
 
diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 05102769a918..68eaf706af4a 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -98,7 +98,7 @@ void ib_enum_roce_netdev(struct ib_device *ib_dev,
 void ib_enum_all_roce_netdevs(roce_netdev_filter filter,
 			      void *filter_cookie,
 			      roce_netdev_callback cb,
-			      void *cookie);
+			      void *cookie, bool is_unregister);
 
 typedef int (*nldev_callback)(struct ib_device *device,
 			      struct sk_buff *skb,
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 1174ab7da629..4ee91175d9c8 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -93,6 +93,7 @@ static struct workqueue_struct *ib_unreg_wq;
 static DEFINE_XARRAY_FLAGS(devices, XA_FLAGS_ALLOC);
 static DECLARE_RWSEM(devices_rwsem);
 #define DEVICE_REGISTERED XA_MARK_1
+#define DEVICE_UNREGISTERING XA_MARK_2
 
 static u32 highest_client_id;
 #define CLIENT_REGISTERED XA_MARK_1
@@ -1302,6 +1303,7 @@ static void disable_device(struct ib_device *device)
 
 	down_write(&devices_rwsem);
 	xa_clear_mark(&devices, device->index, DEVICE_REGISTERED);
+	xa_set_mark(&devices, device->index, DEVICE_UNREGISTERING);
 	up_write(&devices_rwsem);
 
 	/*
@@ -1324,6 +1326,10 @@ static void disable_device(struct ib_device *device)
 	ib_device_put(device);
 	wait_for_completion(&device->unreg_completion);
 
+	down_write(&devices_rwsem);
+	xa_clear_mark(&devices, device->index, DEVICE_UNREGISTERING);
+	up_write(&devices_rwsem);
+
 	/*
 	 * compat devices must be removed after device refcount drops to zero.
 	 * Otherwise init_net() may add more compatdevs after removing compat
@@ -2427,6 +2433,7 @@ void ib_enum_roce_netdev(struct ib_device *ib_dev,
  * @filter_cookie: Cookie passed to filter
  * @cb: Callback to call for each found RoCE ports
  * @cookie: Cookie passed back to the callback
+ * @is_unregister: Whether this is NETDEV_UNREGISTER callback
  *
  * Enumerates all RoCE devices' physical ports which are related
  * to netdevices and calls callback() on each device for which
@@ -2435,7 +2442,7 @@ void ib_enum_roce_netdev(struct ib_device *ib_dev,
 void ib_enum_all_roce_netdevs(roce_netdev_filter filter,
 			      void *filter_cookie,
 			      roce_netdev_callback cb,
-			      void *cookie)
+			      void *cookie, bool is_unregister)
 {
 	struct ib_device *dev;
 	unsigned long index;
@@ -2443,6 +2450,9 @@ void ib_enum_all_roce_netdevs(roce_netdev_filter filter,
 	down_read(&devices_rwsem);
 	xa_for_each_marked (&devices, index, dev, DEVICE_REGISTERED)
 		ib_enum_roce_netdev(dev, filter, filter_cookie, cb, cookie);
+	if (is_unregister)
+		xa_for_each_marked(&devices, index, dev, DEVICE_UNREGISTERING)
+			ib_enum_roce_netdev(dev, filter, filter_cookie, cb, cookie);
 	up_read(&devices_rwsem);
 }
 
diff --git a/drivers/infiniband/core/roce_gid_mgmt.c b/drivers/infiniband/core/roce_gid_mgmt.c
index a9f2c6b1b29e..658f50e113e8 100644
--- a/drivers/infiniband/core/roce_gid_mgmt.c
+++ b/drivers/infiniband/core/roce_gid_mgmt.c
@@ -67,6 +67,7 @@ struct netdev_event_work_cmd {
 struct netdev_event_work {
 	struct work_struct		work;
 	struct netdev_event_work_cmd	cmds[ROCE_NETDEV_CALLBACK_SZ];
+	bool				is_unregister;
 };
 
 static const struct {
@@ -648,7 +649,8 @@ static void netdevice_event_work_handler(struct work_struct *_work)
 		ib_enum_all_roce_netdevs(work->cmds[i].filter,
 					 work->cmds[i].filter_ndev,
 					 work->cmds[i].cb,
-					 work->cmds[i].ndev);
+					 work->cmds[i].ndev,
+					 work->is_unregister);
 		dev_put(work->cmds[i].ndev);
 		dev_put(work->cmds[i].filter_ndev);
 	}
@@ -657,7 +659,7 @@ static void netdevice_event_work_handler(struct work_struct *_work)
 }
 
 static int netdevice_queue_work(struct netdev_event_work_cmd *cmds,
-				struct net_device *ndev)
+				struct net_device *ndev, bool is_unregister)
 {
 	unsigned int i;
 	struct netdev_event_work *ndev_work =
@@ -666,6 +668,7 @@ static int netdevice_queue_work(struct netdev_event_work_cmd *cmds,
 	if (!ndev_work)
 		return NOTIFY_DONE;
 
+	ndev_work->is_unregister = is_unregister;
 	memcpy(ndev_work->cmds, cmds, sizeof(ndev_work->cmds));
 	for (i = 0; i < ARRAY_SIZE(ndev_work->cmds) && ndev_work->cmds[i].cb; i++) {
 		if (!ndev_work->cmds[i].ndev)
@@ -820,7 +823,7 @@ static int netdevice_event(struct notifier_block *this, unsigned long event,
 		return NOTIFY_DONE;
 	}
 
-	return netdevice_queue_work(cmds, ndev);
+	return netdevice_queue_work(cmds, ndev, event == NETDEV_UNREGISTER);
 }
 
 static void update_gid_event_work_handler(struct work_struct *_work)
@@ -830,7 +833,7 @@ static void update_gid_event_work_handler(struct work_struct *_work)
 
 	ib_enum_all_roce_netdevs(is_eth_port_of_netdev_filter,
 				 work->gid_attr.ndev,
-				 callback_for_addr_gid_device_scan, work);
+				 callback_for_addr_gid_device_scan, work, false);
 
 	dev_put(work->gid_attr.ndev);
 	kfree(work);


