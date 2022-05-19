Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9899D52CB38
	for <lists+linux-rdma@lfdr.de>; Thu, 19 May 2022 06:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiESEl4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 May 2022 00:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiESElz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 May 2022 00:41:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DD660065
        for <linux-rdma@vger.kernel.org>; Wed, 18 May 2022 21:41:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3EECACE200A
        for <linux-rdma@vger.kernel.org>; Thu, 19 May 2022 04:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06841C34113;
        Thu, 19 May 2022 04:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652935310;
        bh=hNTs6HpQltwgv7J3xHnZHfSuCcIrg79pP6vrbFxN+5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WAUbGwxoISNSD5VE6enQ6vP4iPwiN0M+v9qdmVHI0mhIBTy0LIpqbDNZgRGBezhGZ
         n6/LHveTguSbJLvTiQV+vF2WFEj8Fc1BbC87ZGiXGOdDnsQ2fmEaai36TBgC3YKH+5
         tHHPyIWZjkalAFEyc5qmfShFrA/OWHdtSIdmOeoDvMq0wan2ms6ct9tCW2N+1v71EJ
         W0lYJ1fCoS/UVpR90hXFwn358XTdo2LtKp3aVnfc4HibhaToMDRoXlcqUKO3fZ9qsC
         PGn6oy/waIyCqJNmIbcjwNh8FAzc+d7+fZlk7fI3H/4RzU7FXSdXfaO4PEA/pazlnK
         7VzHaQUG53m0w==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next v1 1/2] RDMA/core: Add an rb_tree that stores cm_ids sorted by ifindex and remote IP
Date:   Thu, 19 May 2022 07:41:22 +0300
Message-Id: <7362c2ac8a6df98caf3a3f2a0476bb578d80f02e.1652935014.git.leonro@nvidia.com>
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

Add to the cma, a tree that keeps track of all rdma_id_private channels
that were created while in RoCE mode.

The IDs are sorted first according to their netdevice ifindex then their
destination IP. And for IDs with matching IP they would be at the same node
in the tree, since the tree data is a list of all ids with matching destination IP.

The tree allows fast and efficient lookup of ids using an ifindex and
IP address which is useful for identifying relevant net_events promptly.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c      | 151 ++++++++++++++++++++++++++---
 drivers/infiniband/core/cma_priv.h |   1 +
 2 files changed, 140 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index fabca5e51e3d..08bc3ea19716 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -11,6 +11,7 @@
 #include <linux/in6.h>
 #include <linux/mutex.h>
 #include <linux/random.h>
+#include <linux/rbtree.h>
 #include <linux/igmp.h>
 #include <linux/xarray.h>
 #include <linux/inetdevice.h>
@@ -168,6 +169,9 @@ static struct ib_sa_client sa_client;
 static LIST_HEAD(dev_list);
 static LIST_HEAD(listen_any_list);
 static DEFINE_MUTEX(lock);
+static struct rb_root id_table = RB_ROOT;
+/* Serialize operations of id_table tree */
+static DEFINE_SPINLOCK(id_table_lock);
 static struct workqueue_struct *cma_wq;
 static unsigned int cma_pernet_id;
 
@@ -202,6 +206,11 @@ struct xarray *cma_pernet_xa(struct net *net, enum rdma_ucm_port_space ps)
 	}
 }
 
+struct id_table_entry {
+	struct list_head id_list;
+	struct rb_node rb_node;
+};
+
 struct cma_device {
 	struct list_head	list;
 	struct ib_device	*device;
@@ -420,11 +429,21 @@ static inline u8 cma_get_ip_ver(const struct cma_hdr *hdr)
 	return hdr->ip_version >> 4;
 }
 
-static inline void cma_set_ip_ver(struct cma_hdr *hdr, u8 ip_ver)
+static void cma_set_ip_ver(struct cma_hdr *hdr, u8 ip_ver)
 {
 	hdr->ip_version = (ip_ver << 4) | (hdr->ip_version & 0xF);
 }
 
+static struct sockaddr *cma_src_addr(struct rdma_id_private *id_priv)
+{
+	return (struct sockaddr *)&id_priv->id.route.addr.src_addr;
+}
+
+static inline struct sockaddr *cma_dst_addr(struct rdma_id_private *id_priv)
+{
+	return (struct sockaddr *)&id_priv->id.route.addr.dst_addr;
+}
+
 static int cma_igmp_send(struct net_device *ndev, union ib_gid *mgid, bool join)
 {
 	struct in_device *in_dev = NULL;
@@ -445,6 +464,119 @@ static int cma_igmp_send(struct net_device *ndev, union ib_gid *mgid, bool join)
 	return (in_dev) ? 0 : -ENODEV;
 }
 
+static int compare_netdev_and_ip(int ifindex_a, struct sockaddr *sa,
+				 struct id_table_entry *entry_b)
+{
+	struct rdma_id_private *id_priv = list_first_entry(
+		&entry_b->id_list, struct rdma_id_private, id_list_entry);
+	int ifindex_b = id_priv->id.route.addr.dev_addr.bound_dev_if;
+	struct sockaddr *sb = cma_dst_addr(id_priv);
+
+	if (ifindex_a != ifindex_b)
+		return (ifindex_a > ifindex_b) ? 1 : -1;
+
+	if (sa->sa_family != sb->sa_family)
+		return sa->sa_family - sb->sa_family;
+
+	if (sa->sa_family == AF_INET)
+		return (int)__be32_to_cpu(
+			       ((struct sockaddr_in *)sa)->sin_addr.s_addr) -
+		       (int)__be32_to_cpu(
+			       ((struct sockaddr_in *)sb)->sin_addr.s_addr);
+
+	return memcmp((char *)&((struct sockaddr_in6 *)sa)->sin6_addr,
+		      (char *)&((struct sockaddr_in6 *)sb)->sin6_addr,
+		      sizeof(((struct sockaddr_in6 *)sa)->sin6_addr));
+}
+
+static int cma_add_id_to_tree(struct rdma_id_private *node_id_priv)
+{
+	struct rb_node **new, *parent = NULL;
+	struct id_table_entry *this, *node;
+	unsigned long flags;
+	int result;
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	spin_lock_irqsave(&id_table_lock, flags);
+	new = &id_table.rb_node;
+	while (*new) {
+		this = container_of(*new, struct id_table_entry, rb_node);
+		result = compare_netdev_and_ip(
+			node_id_priv->id.route.addr.dev_addr.bound_dev_if,
+			cma_dst_addr(node_id_priv), this);
+
+		parent = *new;
+		if (result < 0)
+			new = &((*new)->rb_left);
+		else if (result > 0)
+			new = &((*new)->rb_right);
+		else {
+			list_add_tail(&node_id_priv->id_list_entry,
+				      &this->id_list);
+			kfree(node);
+			goto unlock;
+		}
+	}
+
+	INIT_LIST_HEAD(&node->id_list);
+	list_add_tail(&node_id_priv->id_list_entry, &node->id_list);
+
+	rb_link_node(&node->rb_node, parent, new);
+	rb_insert_color(&node->rb_node, &id_table);
+
+unlock:
+	spin_unlock_irqrestore(&id_table_lock, flags);
+	return 0;
+}
+
+static struct id_table_entry *
+node_from_ndev_ip(struct rb_root *root, int ifindex, struct sockaddr *sa)
+{
+	struct rb_node *node = root->rb_node;
+	struct id_table_entry *data;
+	int result;
+
+	while (node) {
+		data = container_of(node, struct id_table_entry, rb_node);
+		result = compare_netdev_and_ip(ifindex, sa, data);
+		if (result < 0)
+			node = node->rb_left;
+		else if (result > 0)
+			node = node->rb_right;
+		else
+			return data;
+	}
+
+	return NULL;
+}
+
+static void cma_remove_id_from_tree(struct rdma_id_private *id_priv)
+{
+	struct id_table_entry *data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&id_table_lock, flags);
+	if (list_empty(&id_priv->id_list_entry))
+		goto out;
+
+	data = node_from_ndev_ip(&id_table,
+				 id_priv->id.route.addr.dev_addr.bound_dev_if,
+				 cma_dst_addr(id_priv));
+	if (!data)
+		goto out;
+
+	list_del_init(&id_priv->id_list_entry);
+	if (list_empty(&data->id_list)) {
+		rb_erase(&data->rb_node, &id_table);
+		kfree(data);
+	}
+out:
+	spin_unlock_irqrestore(&id_table_lock, flags);
+}
+
 static void _cma_attach_to_dev(struct rdma_id_private *id_priv,
 			       struct cma_device *cma_dev)
 {
@@ -481,16 +613,6 @@ static void cma_release_dev(struct rdma_id_private *id_priv)
 	mutex_unlock(&lock);
 }
 
-static inline struct sockaddr *cma_src_addr(struct rdma_id_private *id_priv)
-{
-	return (struct sockaddr *) &id_priv->id.route.addr.src_addr;
-}
-
-static inline struct sockaddr *cma_dst_addr(struct rdma_id_private *id_priv)
-{
-	return (struct sockaddr *) &id_priv->id.route.addr.dst_addr;
-}
-
 static inline unsigned short cma_family(struct rdma_id_private *id_priv)
 {
 	return id_priv->id.route.addr.src_addr.ss_family;
@@ -861,6 +983,7 @@ __rdma_create_id(struct net *net, rdma_cm_event_handler event_handler,
 	refcount_set(&id_priv->refcount, 1);
 	mutex_init(&id_priv->handler_mutex);
 	INIT_LIST_HEAD(&id_priv->device_item);
+	INIT_LIST_HEAD(&id_priv->id_list_entry);
 	INIT_LIST_HEAD(&id_priv->listen_list);
 	INIT_LIST_HEAD(&id_priv->mc_list);
 	get_random_bytes(&id_priv->seq_num, sizeof id_priv->seq_num);
@@ -1883,6 +2006,7 @@ static void _destroy_id(struct rdma_id_private *id_priv,
 	cma_cancel_operation(id_priv, state);
 
 	rdma_restrack_del(&id_priv->res);
+	cma_remove_id_from_tree(id_priv);
 	if (id_priv->cma_dev) {
 		if (rdma_cap_ib_cm(id_priv->id.device, 1)) {
 			if (id_priv->cm_id.ib)
@@ -3172,8 +3296,11 @@ int rdma_resolve_route(struct rdma_cm_id *id, unsigned long timeout_ms)
 	cma_id_get(id_priv);
 	if (rdma_cap_ib_sa(id->device, id->port_num))
 		ret = cma_resolve_ib_route(id_priv, timeout_ms);
-	else if (rdma_protocol_roce(id->device, id->port_num))
+	else if (rdma_protocol_roce(id->device, id->port_num)) {
 		ret = cma_resolve_iboe_route(id_priv);
+		if (!ret)
+			cma_add_id_to_tree(id_priv);
+	}
 	else if (rdma_protocol_iwarp(id->device, id->port_num))
 		ret = cma_resolve_iw_route(id_priv);
 	else
diff --git a/drivers/infiniband/core/cma_priv.h b/drivers/infiniband/core/cma_priv.h
index 757a0ef79872..b7354c94cf1b 100644
--- a/drivers/infiniband/core/cma_priv.h
+++ b/drivers/infiniband/core/cma_priv.h
@@ -64,6 +64,7 @@ struct rdma_id_private {
 		struct list_head listen_item;
 		struct list_head listen_list;
 	};
+	struct list_head        id_list_entry;
 	struct cma_device	*cma_dev;
 	struct list_head	mc_list;
 
-- 
2.36.1

