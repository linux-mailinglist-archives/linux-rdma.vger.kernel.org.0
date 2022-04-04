Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8FD4F14BF
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Apr 2022 14:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343578AbiDDM3k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 08:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343964AbiDDM3k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 08:29:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3D03E0E5;
        Mon,  4 Apr 2022 05:27:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE839B8165E;
        Mon,  4 Apr 2022 12:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0223C2BBE4;
        Mon,  4 Apr 2022 12:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649075260;
        bh=Fjyu3Mm43bmPbpUEJYRQuHeGgiet8bhGJPq1YPIhX04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R3TxaXpksoyQHTxqc5NbOXuxvtrmhNcFJfYHOxB3DUiGlNdwM0APQ8jT2M/KdZvTz
         Pz3Gv08NE2yi1ixceLHnDn3mP5dy1U3bJfz0cXo1JJGaZfZhhPZ5OgbgN5b79dUo7v
         s8Rt5b+/Wzs5JfGb2/XTMowickBIda/7Mkg3miOKFVKIK/JLdeW4ztWM0qatBWkb0B
         J3jXenWEupWpPHGah/gdME39YPP8PwWUUyTkLyGIe0iWwBHQ4R5NHoAO3XcbtE7kcr
         IVhP1Dc19XELR9Ppz2QdVKHU1QdIlcT/+lPp2FYFTgITQczHWHqZgHrz/3TKKQlI6e
         cj69aQFojXBAg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Patrisious Haddad <phaddad@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next 2/2] RDMA/core: Add a netevent notifier to cma
Date:   Mon,  4 Apr 2022 15:27:27 +0300
Message-Id: <8c85028f89a877e9b4e6bb58bdd8a7f2cb4567a9.1649075034.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649075034.git.leonro@nvidia.com>
References: <cover.1649075034.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrisious Haddad <phaddad@nvidia.com>

Add a netevent callback for cma, mainly to catch NETEVENT_NEIGH_UPDATE.

Previously, when a system with failover MAC mechanism change its MAC address
during a CM connection attempt, the RDMA-CM would take a lot of time till
it disconnects and timesout due to the incorrect MAC address.

Now when we get a NETEVENT_NEIGH_UPDATE we check if it is due to a failover
MAC change and if so, we instantly destroy the CM and notify the user in order
to spare the unnecessary waiting for the timeout.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c | 104 ++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index bfe2b70daf39..c26fec94d032 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -21,6 +21,7 @@
 
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <net/netevent.h>
 #include <net/tcp.h>
 #include <net/ipv6.h>
 #include <net/ip_fib.h>
@@ -173,6 +174,7 @@ static struct rb_root id_table = RB_ROOT;
 /* Serialize operations of id_table tree */
 static DEFINE_SPINLOCK(id_table_lock);
 static struct workqueue_struct *cma_wq;
+static struct workqueue_struct *cma_netevent_wq;
 static unsigned int cma_pernet_id;
 
 struct cma_pernet {
@@ -373,6 +375,11 @@ struct cma_work {
 	struct rdma_cm_event	event;
 };
 
+struct cma_netevent_work {
+	struct work_struct work;
+	struct rdma_id_private *id_priv;
+};
+
 union cma_ip_addr {
 	struct in6_addr ip6;
 	struct {
@@ -5054,10 +5061,95 @@ static int cma_netdev_callback(struct notifier_block *self, unsigned long event,
 	return ret;
 }
 
+static void cma_netevent_work_handler(struct work_struct *_work)
+{
+	struct cma_netevent_work *network =
+		container_of(_work, struct cma_netevent_work, work);
+	struct rdma_cm_event event = {};
+
+	mutex_lock(&network->id_priv->handler_mutex);
+
+	if (READ_ONCE(network->id_priv->state) == RDMA_CM_DESTROYING ||
+	    READ_ONCE(network->id_priv->state) == RDMA_CM_DEVICE_REMOVAL)
+		goto out_unlock;
+
+	event.event = RDMA_CM_EVENT_UNREACHABLE;
+	event.status = -ETIMEDOUT;
+
+	if (cma_cm_event_handler(network->id_priv, &event)) {
+		__acquire(&network->id_priv->handler_mutex);
+		network->id_priv->cm_id.ib = NULL;
+		cma_id_put(network->id_priv);
+		destroy_id_handler_unlock(network->id_priv);
+		kfree(network);
+		return;
+	}
+
+out_unlock:
+	mutex_unlock(&network->id_priv->handler_mutex);
+	cma_id_put(network->id_priv);
+	kfree(network);
+}
+
+static int cma_netevent_callback(struct notifier_block *self,
+				 unsigned long event, void *ctx)
+{
+	struct id_table_entry *ips_node = NULL;
+	struct rdma_id_private *current_id;
+	struct cma_netevent_work *network;
+	struct neighbour *neigh = ctx;
+	unsigned long flags;
+
+	if (event != NETEVENT_NEIGH_UPDATE)
+		return NOTIFY_DONE;
+
+	spin_lock_irqsave(&id_table_lock, flags);
+	if (neigh->tbl->family == AF_INET6) {
+		struct sockaddr_in6 neigh_sock_6;
+
+		neigh_sock_6.sin6_family = AF_INET6;
+		neigh_sock_6.sin6_addr = *(struct in6_addr *)neigh->primary_key;
+		ips_node = node_from_ndev_ip(&id_table, neigh->dev->ifindex,
+					     (struct sockaddr *)&neigh_sock_6);
+	} else if (neigh->tbl->family == AF_INET) {
+		struct sockaddr_in neigh_sock_4;
+
+		neigh_sock_4.sin_family = AF_INET;
+		neigh_sock_4.sin_addr.s_addr = *(__be32 *)(neigh->primary_key);
+		ips_node = node_from_ndev_ip(&id_table, neigh->dev->ifindex,
+					     (struct sockaddr *)&neigh_sock_4);
+	} else
+		goto out;
+
+	if (!ips_node)
+		goto out;
+
+	list_for_each_entry(current_id, &ips_node->id_list, id_list_entry) {
+		if (!memcmp(current_id->id.route.addr.dev_addr.dst_dev_addr,
+			   neigh->ha, ETH_ALEN))
+			continue;
+		network = kzalloc(sizeof(*network), GFP_ATOMIC);
+		if (!network)
+			goto out;
+
+		INIT_WORK(&network->work, cma_netevent_work_handler);
+		network->id_priv = current_id;
+		cma_id_get(current_id);
+		queue_work(cma_netevent_wq, &network->work);
+	}
+out:
+	spin_unlock_irqrestore(&id_table_lock, flags);
+	return NOTIFY_DONE;
+}
+
 static struct notifier_block cma_nb = {
 	.notifier_call = cma_netdev_callback
 };
 
+static struct notifier_block cma_netevent_cb = {
+	.notifier_call = cma_netevent_callback
+};
+
 static void cma_send_device_removal_put(struct rdma_id_private *id_priv)
 {
 	struct rdma_cm_event event = { .event = RDMA_CM_EVENT_DEVICE_REMOVAL };
@@ -5274,12 +5366,19 @@ static int __init cma_init(void)
 	if (!cma_wq)
 		return -ENOMEM;
 
+	cma_netevent_wq = alloc_ordered_workqueue("rdma_cm_netevent", 0);
+	if (!cma_netevent_wq) {
+		ret = -ENOMEM;
+		goto err_netevent_wq;
+	}
+
 	ret = register_pernet_subsys(&cma_pernet_operations);
 	if (ret)
 		goto err_wq;
 
 	ib_sa_register_client(&sa_client);
 	register_netdevice_notifier(&cma_nb);
+	register_netevent_notifier(&cma_netevent_cb);
 
 	ret = ib_register_client(&cma_client);
 	if (ret)
@@ -5294,10 +5393,13 @@ static int __init cma_init(void)
 err_ib:
 	ib_unregister_client(&cma_client);
 err:
+	unregister_netevent_notifier(&cma_netevent_cb);
 	unregister_netdevice_notifier(&cma_nb);
 	ib_sa_unregister_client(&sa_client);
 	unregister_pernet_subsys(&cma_pernet_operations);
 err_wq:
+	destroy_workqueue(cma_netevent_wq);
+err_netevent_wq:
 	destroy_workqueue(cma_wq);
 	return ret;
 }
@@ -5306,9 +5408,11 @@ static void __exit cma_cleanup(void)
 {
 	cma_configfs_exit();
 	ib_unregister_client(&cma_client);
+	unregister_netevent_notifier(&cma_netevent_cb);
 	unregister_netdevice_notifier(&cma_nb);
 	ib_sa_unregister_client(&sa_client);
 	unregister_pernet_subsys(&cma_pernet_operations);
+	destroy_workqueue(cma_netevent_wq);
 	destroy_workqueue(cma_wq);
 }
 
-- 
2.35.1

