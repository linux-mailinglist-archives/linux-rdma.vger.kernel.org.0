Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6DE0149B0D
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2020 15:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387431AbgAZO1N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jan 2020 09:27:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:42726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387401AbgAZO1N (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Jan 2020 09:27:13 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EB5A20720;
        Sun, 26 Jan 2020 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580048832;
        bh=MsGWuButJgDzQ6UNjMCPO1j3Gx15fp5X2Ahyzyylj28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LMOylENvimZa019E4+OZ5vLFVwRl3L8AqR1rIWVfPRxK2uf/DUQBS0+oRcGRvKN4M
         LXr9el5ljePk4HKKjySwb1ywrzMo/bYnf8qIrwbf8pg3xijPfjTd1qX2MIzJfkngBF
         FM+GSNSK7JJjGk4Z44yQjQ+R/kgT7PAS4y/QK/eg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next 6/7] RDMA/cma: Rename cma_device ref/deref helpers to to get/put
Date:   Sun, 26 Jan 2020 16:26:51 +0200
Message-Id: <20200126142652.104803-7-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200126142652.104803-1-leon@kernel.org>
References: <20200126142652.104803-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

Helper functions which increment/decrement reference count of the
structure are read better when they are named with get/put suffix.

Hence, rename cma_ref/deref_id() to cma_id_get/put().
Also use cma_get_id() wrapper to find the balancing put() calls.

Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c | 42 ++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index a5fd44194d77..d6355e21cc87 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -841,7 +841,12 @@ static int cma_resolve_ib_dev(struct rdma_id_private *id_priv)
 	return 0;
 }
 
-static void cma_deref_id(struct rdma_id_private *id_priv)
+static void cma_id_get(struct rdma_id_private *id_priv)
+{
+	atomic_inc(&id_priv->refcount);
+}
+
+static void cma_id_put(struct rdma_id_private *id_priv)
 {
 	if (atomic_dec_and_test(&id_priv->refcount))
 		complete(&id_priv->comp);
@@ -1847,11 +1852,11 @@ void rdma_destroy_id(struct rdma_cm_id *id)
 	}
 
 	cma_release_port(id_priv);
-	cma_deref_id(id_priv);
+	cma_id_put(id_priv);
 	wait_for_completion(&id_priv->comp);
 
 	if (id_priv->internal_id)
-		cma_deref_id(id_priv->id.context);
+		cma_id_put(id_priv->id.context);
 
 	kfree(id_priv->id.route.path_rec);
 
@@ -2188,7 +2193,7 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_id,
 	 * Protect against the user destroying conn_id from another thread
 	 * until we're done accessing it.
 	 */
-	atomic_inc(&conn_id->refcount);
+	cma_id_get(conn_id);
 	ret = cma_cm_event_handler(conn_id, &event);
 	if (ret)
 		goto err3;
@@ -2205,13 +2210,13 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_id,
 	mutex_unlock(&lock);
 	mutex_unlock(&conn_id->handler_mutex);
 	mutex_unlock(&listen_id->handler_mutex);
-	cma_deref_id(conn_id);
+	cma_id_put(conn_id);
 	if (net_dev)
 		dev_put(net_dev);
 	return 0;
 
 err3:
-	cma_deref_id(conn_id);
+	cma_id_put(conn_id);
 	/* Destroy the CM ID by returning a non-zero value. */
 	conn_id->cm_id.ib = NULL;
 err2:
@@ -2392,7 +2397,7 @@ static int iw_conn_req_handler(struct iw_cm_id *cm_id,
 	 * Protect against the user destroying conn_id from another thread
 	 * until we're done accessing it.
 	 */
-	atomic_inc(&conn_id->refcount);
+	cma_id_get(conn_id);
 	ret = cma_cm_event_handler(conn_id, &event);
 	if (ret) {
 		/* User wants to destroy the CM ID */
@@ -2400,13 +2405,13 @@ static int iw_conn_req_handler(struct iw_cm_id *cm_id,
 		cma_exch(conn_id, RDMA_CM_DESTROYING);
 		mutex_unlock(&conn_id->handler_mutex);
 		mutex_unlock(&listen_id->handler_mutex);
-		cma_deref_id(conn_id);
+		cma_id_put(conn_id);
 		rdma_destroy_id(&conn_id->id);
 		return ret;
 	}
 
 	mutex_unlock(&conn_id->handler_mutex);
-	cma_deref_id(conn_id);
+	cma_id_put(conn_id);
 
 out:
 	mutex_unlock(&listen_id->handler_mutex);
@@ -2493,7 +2498,7 @@ static void cma_listen_on_dev(struct rdma_id_private *id_priv,
 
 	_cma_attach_to_dev(dev_id_priv, cma_dev);
 	list_add_tail(&dev_id_priv->listen_list, &id_priv->listen_list);
-	atomic_inc(&id_priv->refcount);
+	cma_id_get(id_priv);
 	dev_id_priv->internal_id = 1;
 	dev_id_priv->afonly = id_priv->afonly;
 	dev_id_priv->tos_set = id_priv->tos_set;
@@ -2648,7 +2653,7 @@ static void cma_work_handler(struct work_struct *_work)
 	}
 out:
 	mutex_unlock(&id_priv->handler_mutex);
-	cma_deref_id(id_priv);
+	cma_id_put(id_priv);
 	if (destroy)
 		rdma_destroy_id(&id_priv->id);
 	kfree(work);
@@ -2672,7 +2677,7 @@ static void cma_ndev_work_handler(struct work_struct *_work)
 
 out:
 	mutex_unlock(&id_priv->handler_mutex);
-	cma_deref_id(id_priv);
+	cma_id_put(id_priv);
 	if (destroy)
 		rdma_destroy_id(&id_priv->id);
 	kfree(work);
@@ -2691,7 +2696,8 @@ static void cma_init_resolve_route_work(struct cma_work *work,
 static void enqueue_resolve_addr_work(struct cma_work *work,
 				      struct rdma_id_private *id_priv)
 {
-	atomic_inc(&id_priv->refcount);
+	/* Balances with cma_id_put() in cma_work_handler */
+	cma_id_get(id_priv);
 
 	work->id = id_priv;
 	INIT_WORK(&work->work, cma_work_handler);
@@ -2987,7 +2993,7 @@ int rdma_resolve_route(struct rdma_cm_id *id, unsigned long timeout_ms)
 	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_RESOLVED, RDMA_CM_ROUTE_QUERY))
 		return -EINVAL;
 
-	atomic_inc(&id_priv->refcount);
+	cma_id_get(id_priv);
 	if (rdma_cap_ib_sa(id->device, id->port_num))
 		ret = cma_resolve_ib_route(id_priv, timeout_ms);
 	else if (rdma_protocol_roce(id->device, id->port_num))
@@ -3003,7 +3009,7 @@ int rdma_resolve_route(struct rdma_cm_id *id, unsigned long timeout_ms)
 	return 0;
 err:
 	cma_comp_exch(id_priv, RDMA_CM_ROUTE_QUERY, RDMA_CM_ADDR_RESOLVED);
-	cma_deref_id(id_priv);
+	cma_id_put(id_priv);
 	return ret;
 }
 EXPORT_SYMBOL(rdma_resolve_route);
@@ -4582,7 +4588,7 @@ static int cma_netdev_change(struct net_device *ndev, struct rdma_id_private *id
 		INIT_WORK(&work->work, cma_ndev_work_handler);
 		work->id = id_priv;
 		work->event.event = RDMA_CM_EVENT_ADDR_CHANGE;
-		atomic_inc(&id_priv->refcount);
+		cma_id_get(id_priv);
 		queue_work(cma_wq, &work->work);
 	}
 
@@ -4716,11 +4722,11 @@ static void cma_process_remove(struct cma_device *cma_dev)
 
 		list_del(&id_priv->listen_list);
 		list_del_init(&id_priv->list);
-		atomic_inc(&id_priv->refcount);
+		cma_id_get(id_priv);
 		mutex_unlock(&lock);
 
 		ret = id_priv->internal_id ? 1 : cma_remove_id_dev(id_priv);
-		cma_deref_id(id_priv);
+		cma_id_put(id_priv);
 		if (ret)
 			rdma_destroy_id(&id_priv->id);
 
-- 
2.24.1

