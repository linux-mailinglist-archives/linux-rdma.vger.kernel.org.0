Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4B8DE8781
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 12:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfJ2Lxk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 07:53:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfJ2Lxk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 07:53:40 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED5E121D56;
        Tue, 29 Oct 2019 11:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572350018;
        bh=99kRYd2ACtt3YqvoB67Y4ciD0K7vc+1qg2O/apzLUGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2gfPopZPickBT/5F4GBUfRfa1ssJ9XpP0dkyq977yw0SASphve3Bs6glDqJVBAW93
         hj1j4RmOGAS2clKV6fG+apMdHUlmJsBpM3tG5vQK06WYCTXPDZTGCsFB5U4Wg4/1nu
         H4+727B/RI28APlvGCyTpEj589CRZ2l+oQ4lrD0A=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next v1 1/2] IB/core: Let IB core distribute cache update events
Date:   Tue, 29 Oct 2019 13:53:26 +0200
Message-Id: <20191029115327.16589-2-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029115327.16589-1-leon@kernel.org>
References: <20191029115327.16589-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

Currently when low level driver notifies Pkey, GID, port change events,
they are notified to the registered handlers in the order they are
registered.
IB core and other ULPs such as IPoIB are interested in GID, LID, Pkey
change events.
Since all GID query done by ULPs is serviced by IB core, in below flow
when GID change event occurs, IB core is yet to update the GID cache
when IPoIB queries the GID, resulting into not updating IPoIB address.

mlx5_ib_handle_event()
  ib_dispatch_event()
    ib_cache_event()
       queue_work() -> slow cache update

    [..]
    ipoib_event()
     queue_work()
       [..]
       work handler
         ipoib_ib_dev_flush_light()
           __ipoib_ib_dev_flush()
              ipoib_dev_addr_changed_valid()
                rdma_query_gid() <- Returns old GID, cache not updated.

Hence, all events which require cache update are handled first by the IB
core. Once cache update work is completed, IB core distributes the event
to subscriber clients.

Fixes: f35faa4ba956 ("IB/core: Simplify ib_query_gid to always refer to cache")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cache.c     | 84 ++++++++++++++---------------
 drivers/infiniband/core/core_priv.h |  2 +
 drivers/infiniband/core/device.c    | 27 ++++++----
 include/rdma/ib_verbs.h             |  1 -
 4 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index d535995711c3..1d5c0df7dfab 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -51,9 +51,8 @@ struct ib_pkey_cache {

 struct ib_update_work {
 	struct work_struct work;
-	struct ib_device  *device;
-	u8                 port_num;
-	bool		   enforce_security;
+	struct ib_event event;
+	bool enforce_security;
 };

 union ib_gid zgid;
@@ -130,7 +129,7 @@ static void dispatch_gid_change_event(struct ib_device *ib_dev, u8 port)
 	event.element.port_num	= port;
 	event.event		= IB_EVENT_GID_CHANGE;

-	ib_dispatch_event(&event);
+	ib_dispatch_cache_event_clients(&event);
 }

 static const char * const gid_type_str[] = {
@@ -1381,9 +1380,8 @@ static int config_non_roce_gid_cache(struct ib_device *device,
 	return ret;
 }

-static void ib_cache_update(struct ib_device *device,
-			    u8                port,
-			    bool	      enforce_security)
+static int
+ib_cache_update(struct ib_device *device, u8 port, bool	enforce_security)
 {
 	struct ib_port_attr       *tprops = NULL;
 	struct ib_pkey_cache      *pkey_cache = NULL, *old_pkey_cache;
@@ -1391,11 +1389,11 @@ static void ib_cache_update(struct ib_device *device,
 	int                        ret;

 	if (!rdma_is_port_valid(device, port))
-		return;
+		return -EINVAL;

 	tprops = kmalloc(sizeof *tprops, GFP_KERNEL);
 	if (!tprops)
-		return;
+		return -ENOMEM;

 	ret = ib_query_port(device, port, tprops);
 	if (ret) {
@@ -1413,8 +1411,10 @@ static void ib_cache_update(struct ib_device *device,
 	pkey_cache = kmalloc(struct_size(pkey_cache, table,
 					 tprops->pkey_tbl_len),
 			     GFP_KERNEL);
-	if (!pkey_cache)
+	if (!pkey_cache) {
+		ret = -ENOMEM;
 		goto err;
+	}

 	pkey_cache->table_len = tprops->pkey_tbl_len;

@@ -1446,49 +1446,48 @@ static void ib_cache_update(struct ib_device *device,

 	kfree(old_pkey_cache);
 	kfree(tprops);
-	return;
+	return 0;

 err:
 	kfree(pkey_cache);
 	kfree(tprops);
+	return ret;
 }

 static void ib_cache_task(struct work_struct *_work)
 {
 	struct ib_update_work *work =
 		container_of(_work, struct ib_update_work, work);
+	int ret;
+
+	ret = ib_cache_update(work->event.device, work->event.element.port_num,
+			      work->enforce_security);
+
+	/* GID event is notified already for individual GID entries by
+	 * dispatch_gid_change_event(). Hence, notifiy for rest of the
+	 * events.
+	 */
+	if (!ret && work->event.event != IB_EVENT_GID_CHANGE)
+		ib_dispatch_cache_event_clients(&work->event);

-	ib_cache_update(work->device,
-			work->port_num,
-			work->enforce_security);
 	kfree(work);
 }

-static void ib_cache_event(struct ib_event_handler *handler,
-			   struct ib_event *event)
+void ib_enqueue_cache_update_event(const struct ib_event *event)
 {
 	struct ib_update_work *work;

-	if (event->event == IB_EVENT_PORT_ERR    ||
-	    event->event == IB_EVENT_PORT_ACTIVE ||
-	    event->event == IB_EVENT_LID_CHANGE  ||
-	    event->event == IB_EVENT_PKEY_CHANGE ||
-	    event->event == IB_EVENT_CLIENT_REREGISTER ||
-	    event->event == IB_EVENT_GID_CHANGE) {
-		work = kmalloc(sizeof *work, GFP_ATOMIC);
-		if (work) {
-			INIT_WORK(&work->work, ib_cache_task);
-			work->device   = event->device;
-			work->port_num = event->element.port_num;
-			if (event->event == IB_EVENT_PKEY_CHANGE ||
-			    event->event == IB_EVENT_GID_CHANGE)
-				work->enforce_security = true;
-			else
-				work->enforce_security = false;
-
-			queue_work(ib_wq, &work->work);
-		}
-	}
+	work = kzalloc(sizeof(*work), GFP_ATOMIC);
+	if (!work)
+		return;
+
+	INIT_WORK(&work->work, ib_cache_task);
+	work->event = *event;
+	if (event->event == IB_EVENT_PKEY_CHANGE ||
+	    event->event == IB_EVENT_GID_CHANGE)
+		work->enforce_security = true;
+
+	queue_work(ib_wq, &work->work);
 }

 int ib_cache_setup_one(struct ib_device *device)
@@ -1505,9 +1504,6 @@ int ib_cache_setup_one(struct ib_device *device)
 	rdma_for_each_port (device, p)
 		ib_cache_update(device, p, true);

-	INIT_IB_EVENT_HANDLER(&device->cache.event_handler,
-			      device, ib_cache_event);
-	ib_register_event_handler(&device->cache.event_handler);
 	return 0;
 }

@@ -1529,14 +1525,12 @@ void ib_cache_release_one(struct ib_device *device)

 void ib_cache_cleanup_one(struct ib_device *device)
 {
-	/* The cleanup function unregisters the event handler,
-	 * waits for all in-progress workqueue elements and cleans
-	 * up the GID cache. This function should be called after
-	 * the device was removed from the devices list and all
-	 * clients were removed, so the cache exists but is
+	/* The cleanup function waits for all in-progress workqueue
+	 * elements and cleans up the GID cache. This function should be
+	 * called after the device was removed from the devices list and
+	 * all clients were removed, so the cache exists but is
 	 * non-functional and shouldn't be updated anymore.
 	 */
-	ib_unregister_event_handler(&device->cache.event_handler);
 	flush_workqueue(ib_wq);
 	gid_table_cleanup_one(device);

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 3a8b0911c3bc..137c98098489 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -149,6 +149,8 @@ unsigned long roce_gid_type_mask_support(struct ib_device *ib_dev, u8 port);
 int ib_cache_setup_one(struct ib_device *device);
 void ib_cache_cleanup_one(struct ib_device *device);
 void ib_cache_release_one(struct ib_device *device);
+void ib_enqueue_cache_update_event(const struct ib_event *event);
+void ib_dispatch_cache_event_clients(struct ib_event *event);

 #ifdef CONFIG_CGROUP_RDMA
 void ib_device_register_rdmacg(struct ib_device *device);
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index f8d383ceae05..9db229c628e9 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1931,8 +1931,8 @@ EXPORT_SYMBOL(ib_set_client_data);
  *
  * ib_register_event_handler() registers an event handler that will be
  * called back when asynchronous IB events occur (as defined in
- * chapter 11 of the InfiniBand Architecture Specification).  This
- * callback may occur in interrupt context.
+ * chapter 11 of the InfiniBand Architecture Specification). This
+ * callback always occurring in workqueue context.
  */
 void ib_register_event_handler(struct ib_event_handler *event_handler)
 {
@@ -1962,15 +1962,7 @@ void ib_unregister_event_handler(struct ib_event_handler *event_handler)
 }
 EXPORT_SYMBOL(ib_unregister_event_handler);

-/**
- * ib_dispatch_event - Dispatch an asynchronous event
- * @event:Event to dispatch
- *
- * Low-level drivers must call ib_dispatch_event() to dispatch the
- * event to all registered event handlers when an asynchronous event
- * occurs.
- */
-void ib_dispatch_event(struct ib_event *event)
+void ib_dispatch_cache_event_clients(struct ib_event *event)
 {
 	unsigned long flags;
 	struct ib_event_handler *handler;
@@ -1982,6 +1974,19 @@ void ib_dispatch_event(struct ib_event *event)

 	spin_unlock_irqrestore(&event->device->event_handler_lock, flags);
 }
+
+/**
+ * ib_dispatch_event - Dispatch an asynchronous event
+ * @event:Event to dispatch
+ *
+ * Low-level drivers must call ib_dispatch_event() to dispatch the
+ * event to all registered event handlers when an asynchronous event
+ * occurs.
+ */
+void ib_dispatch_event(struct ib_event *event)
+{
+	ib_enqueue_cache_update_event(event);
+}
 EXPORT_SYMBOL(ib_dispatch_event);

 static int iw_query_port(struct ib_device *device,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 0626b62ed107..6604115f7c85 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2148,7 +2148,6 @@ struct ib_port_cache {

 struct ib_cache {
 	rwlock_t                lock;
-	struct ib_event_handler event_handler;
 };

 struct ib_port_immutable {
--
2.20.1

