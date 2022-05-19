Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74152CB37
	for <lists+linux-rdma@lfdr.de>; Thu, 19 May 2022 06:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiESElr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 May 2022 00:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbiESElp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 May 2022 00:41:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850E4C5DA9
        for <linux-rdma@vger.kernel.org>; Wed, 18 May 2022 21:41:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C324619BD
        for <linux-rdma@vger.kernel.org>; Thu, 19 May 2022 04:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377EEC34100;
        Thu, 19 May 2022 04:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652935303;
        bh=wjOnibFltXvMRIFfYwINRkCs7nCewTgWA4FxzflgSpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lkwCOa+cNvqWnrdvW9kGdvESM8l09+mnpMcU2Na+GwWyPZuvXoHzgrW2oDPXDhJnW
         ntZpY6PxvQSMFuhDLiz0odTHF5cbk6DUUJIyX0T23V4CIzMAjpsuAiTinTdE/IQXA6
         03aidALycZeQ4Ii5AJO8t/gf7ytm2AgTECuU9pBVIRp/qGI5DHswPUB40tx4cBhO17
         EuvzPC2YL1fXU27UyuKtVq6sOMrjKCatUCJ0fLqMyM8JvMJp8SrfP+Z5E7HpoB524I
         BwMEuKhfPYbMeNZis5dCHECy1glgUNBOiFchWnD69ENpAvT6fpLriSz00kyANsV8mj
         Qy+UBpAMQodyA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next v1 2/2] RDMA/core: Add a netevent notifier to cma
Date:   Thu, 19 May 2022 07:41:23 +0300
Message-Id: <c9febb1bbd678058a2b98933305ce8e3bca47dfb.1652935014.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1652935014.git.leonro@nvidia.com>
References: <cover.1652935014.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/infiniband/core/cma.c | 83 +++++++++++++++++++++++++++++++++++
 include/rdma/rdma_cm.h        |  6 +++
 2 files changed, 89 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 08bc3ea19716..644f5f1e1f46 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -21,6 +21,7 @@
 
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <net/netevent.h>
 #include <net/tcp.h>
 #include <net/ipv6.h>
 #include <net/ip_fib.h>
@@ -5049,10 +5050,89 @@ static int cma_netdev_callback(struct notifier_block *self, unsigned long event,
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
+		return;
+	}
+
+out_unlock:
+	mutex_unlock(&network->id_priv->handler_mutex);
+	cma_id_put(network->id_priv);
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
+		INIT_WORK(&current_id->id.network.work,
+			  cma_netevent_work_handler);
+		current_id->id.network.id_priv = current_id;
+		cma_id_get(current_id);
+		queue_work(cma_wq, &current_id->id.network.work);
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
@@ -5275,6 +5355,7 @@ static int __init cma_init(void)
 
 	ib_sa_register_client(&sa_client);
 	register_netdevice_notifier(&cma_nb);
+	register_netevent_notifier(&cma_netevent_cb);
 
 	ret = ib_register_client(&cma_client);
 	if (ret)
@@ -5289,6 +5370,7 @@ static int __init cma_init(void)
 err_ib:
 	ib_unregister_client(&cma_client);
 err:
+	unregister_netevent_notifier(&cma_netevent_cb);
 	unregister_netdevice_notifier(&cma_nb);
 	ib_sa_unregister_client(&sa_client);
 	unregister_pernet_subsys(&cma_pernet_operations);
@@ -5301,6 +5383,7 @@ static void __exit cma_cleanup(void)
 {
 	cma_configfs_exit();
 	ib_unregister_client(&cma_client);
+	unregister_netevent_notifier(&cma_netevent_cb);
 	unregister_netdevice_notifier(&cma_nb);
 	ib_sa_unregister_client(&sa_client);
 	unregister_pernet_subsys(&cma_pernet_operations);
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index d989f030fae0..d7de0958b76a 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -87,6 +87,11 @@ struct rdma_cm_event {
 	struct rdma_ucm_ece ece;
 };
 
+struct cma_netevent_work {
+	struct work_struct work;
+	struct rdma_id_private *id_priv;
+};
+
 struct rdma_cm_id;
 
 /**
@@ -108,6 +113,7 @@ struct rdma_cm_id {
 	enum rdma_ucm_port_space ps;
 	enum ib_qp_type		 qp_type;
 	u32			 port_num;
+	struct cma_netevent_work network;
 };
 
 struct rdma_cm_id *
-- 
2.36.1

