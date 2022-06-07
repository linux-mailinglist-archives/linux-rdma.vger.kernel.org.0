Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255E453FD8B
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jun 2022 13:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243001AbiFGLdP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jun 2022 07:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242999AbiFGLdK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jun 2022 07:33:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0FC24BC2
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jun 2022 04:33:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6DB7B81F6D
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jun 2022 11:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22842C3411F;
        Tue,  7 Jun 2022 11:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654601577;
        bh=DvoWcYNtfMsvpmZkZ4LyPILpRK0fSIma1peNoLoUxzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sFh5RwCNNyOqGRB53dcFsv3SitweqzSB6pQusq753983lRTvGPKQgxgcjY4o+T4Z3
         s0PtH4S22oICr858EZQTlI8BGF/6Pwn5i19b6xku0K6EA/+zX4rr8gAPD5OSVUvNFb
         2SAK79LVvRWL6znGxXX8rVJ+JSfOrDAhPXiHAz/fuCVfgD+mXORm0Kydak1VfBljdY
         s6ujWy5xpzePcPg5UFf1r9eneylZnqcqT+ssSu39qvdh9sTH0r/tdBrjk0nirIp86Q
         2sVdFtjLWYywBAvreSqNfpz1bcaljmSZVL/elG1fnxOZRayzb0LIH+IVe9y0Vv7u3E
         g1Mn7TP9sakJw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next v2 2/2] RDMA/core: Add a netevent notifier to cma
Date:   Tue,  7 Jun 2022 14:32:44 +0300
Message-Id: <bb255c9e301cd50b905663b8e73f7f5133d0e4c5.1654601342.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654601342.git.leonro@nvidia.com>
References: <cover.1654601342.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/infiniband/core/cma.c | 81 +++++++++++++++++++++++++++++++++++
 include/rdma/rdma_cm.h        |  1 +
 2 files changed, 82 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 0a17b1bb9547..46d06678dfbe 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -21,6 +21,7 @@
 
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <net/netevent.h>
 #include <net/tcp.h>
 #include <net/ipv6.h>
 #include <net/ip_fib.h>
@@ -5047,10 +5048,87 @@ static int cma_netdev_callback(struct notifier_block *self, unsigned long event,
 	return ret;
 }
 
+static void cma_netevent_work_handler(struct work_struct *_work)
+{
+	struct rdma_id_private *id_priv =
+		container_of(_work, struct rdma_id_private, id.net_work);
+	struct rdma_cm_event event = {};
+
+	mutex_lock(&id_priv->handler_mutex);
+
+	if (READ_ONCE(id_priv->state) == RDMA_CM_DESTROYING ||
+	    READ_ONCE(id_priv->state) == RDMA_CM_DEVICE_REMOVAL)
+		goto out_unlock;
+
+	event.event = RDMA_CM_EVENT_UNREACHABLE;
+	event.status = -ETIMEDOUT;
+
+	if (cma_cm_event_handler(id_priv, &event)) {
+		__acquire(&id_priv->handler_mutex);
+		id_priv->cm_id.ib = NULL;
+		cma_id_put(id_priv);
+		destroy_id_handler_unlock(id_priv);
+		return;
+	}
+
+out_unlock:
+	mutex_unlock(&id_priv->handler_mutex);
+	cma_id_put(id_priv);
+}
+
+static int cma_netevent_callback(struct notifier_block *self,
+				 unsigned long event, void *ctx)
+{
+	struct id_table_entry *ips_node = NULL;
+	struct rdma_id_private *current_id;
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
+		INIT_WORK(&current_id->id.net_work, cma_netevent_work_handler);
+		cma_id_get(current_id);
+		queue_work(cma_wq, &current_id->id.net_work);
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
@@ -5273,6 +5351,7 @@ static int __init cma_init(void)
 
 	ib_sa_register_client(&sa_client);
 	register_netdevice_notifier(&cma_nb);
+	register_netevent_notifier(&cma_netevent_cb);
 
 	ret = ib_register_client(&cma_client);
 	if (ret)
@@ -5287,6 +5366,7 @@ static int __init cma_init(void)
 err_ib:
 	ib_unregister_client(&cma_client);
 err:
+	unregister_netevent_notifier(&cma_netevent_cb);
 	unregister_netdevice_notifier(&cma_nb);
 	ib_sa_unregister_client(&sa_client);
 	unregister_pernet_subsys(&cma_pernet_operations);
@@ -5299,6 +5379,7 @@ static void __exit cma_cleanup(void)
 {
 	cma_configfs_exit();
 	ib_unregister_client(&cma_client);
+	unregister_netevent_notifier(&cma_netevent_cb);
 	unregister_netdevice_notifier(&cma_nb);
 	ib_sa_unregister_client(&sa_client);
 	unregister_pernet_subsys(&cma_pernet_operations);
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index d989f030fae0..5b18e2e36ee6 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -108,6 +108,7 @@ struct rdma_cm_id {
 	enum rdma_ucm_port_space ps;
 	enum ib_qp_type		 qp_type;
 	u32			 port_num;
+	struct work_struct net_work;
 };
 
 struct rdma_cm_id *
-- 
2.36.1

