Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0D6354E76
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 10:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239762AbhDFIWi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 04:22:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15916 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239772AbhDFIWh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 04:22:37 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FF0pL1Fj2zkgVh;
        Tue,  6 Apr 2021 16:20:42 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 16:22:17 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 4/6] RDMA/core: Remove redundant spaces
Date:   Tue, 6 Apr 2021 16:19:42 +0800
Message-ID: <1617697184-48683-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617697184-48683-1-git-send-email-liweihang@huawei.com>
References: <1617697184-48683-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

Space is not required between function name and '(', after '(', before ')',
before ',' and between '*' and symbol name of a definition.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/core/cache.c       | 10 +++---
 drivers/infiniband/core/cm.c          | 31 ++++++++---------
 drivers/infiniband/core/cma.c         | 10 +++---
 drivers/infiniband/core/device.c      | 64 +++++++++++++++++------------------
 drivers/infiniband/core/mad.c         | 20 +++++------
 drivers/infiniband/core/mad_rmpp.c    | 10 +++---
 drivers/infiniband/core/nldev.c       |  2 +-
 drivers/infiniband/core/security.c    | 12 +++----
 drivers/infiniband/core/sysfs.c       |  8 ++---
 drivers/infiniband/core/user_mad.c    |  6 ++--
 drivers/infiniband/core/uverbs_cmd.c  | 20 +++++------
 drivers/infiniband/core/uverbs_main.c |  3 +-
 drivers/infiniband/core/uverbs_uapi.c | 16 ++++-----
 13 files changed, 105 insertions(+), 107 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index d779590..0b8c410 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -886,7 +886,7 @@ static void gid_table_release_one(struct ib_device *ib_dev)
 {
 	u32 p;
 
-	rdma_for_each_port (ib_dev, p) {
+	rdma_for_each_port(ib_dev, p) {
 		release_gid_table(ib_dev, ib_dev->port_data[p].cache.gid);
 		ib_dev->port_data[p].cache.gid = NULL;
 	}
@@ -897,7 +897,7 @@ static int _gid_table_setup_one(struct ib_device *ib_dev)
 	struct ib_gid_table *table;
 	u32 rdma_port;
 
-	rdma_for_each_port (ib_dev, rdma_port) {
+	rdma_for_each_port(ib_dev, rdma_port) {
 		table = alloc_gid_table(
 			ib_dev->port_data[rdma_port].immutable.gid_tbl_len);
 		if (!table)
@@ -917,7 +917,7 @@ static void gid_table_cleanup_one(struct ib_device *ib_dev)
 {
 	u32 p;
 
-	rdma_for_each_port (ib_dev, p)
+	rdma_for_each_port(ib_dev, p)
 		cleanup_gid_table_port(ib_dev, p,
 				       ib_dev->port_data[p].cache.gid);
 }
@@ -1622,7 +1622,7 @@ int ib_cache_setup_one(struct ib_device *device)
 	if (err)
 		return err;
 
-	rdma_for_each_port (device, p) {
+	rdma_for_each_port(device, p) {
 		err = ib_cache_update(device, p, true);
 		if (err)
 			return err;
@@ -1641,7 +1641,7 @@ void ib_cache_release_one(struct ib_device *device)
 	 * all the device's resources when the cache could no
 	 * longer be accessed.
 	 */
-	rdma_for_each_port (device, p)
+	rdma_for_each_port(device, p)
 		kfree(device->port_data[p].cache.pkey);
 
 	gid_table_release_one(device);
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 28c8d13..190ac78 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -420,8 +420,7 @@ static int cm_alloc_response_msg(struct cm_port *port,
 	return 0;
 }
 
-static void * cm_copy_private_data(const void *private_data,
-				   u8 private_data_len)
+static void *cm_copy_private_data(const void *private_data, u8 private_data_len)
 {
 	void *data;
 
@@ -680,8 +679,8 @@ static struct cm_id_private *cm_insert_listen(struct cm_id_private *cm_id_priv,
 	return cm_id_priv;
 }
 
-static struct cm_id_private * cm_find_listen(struct ib_device *device,
-					     __be64 service_id)
+static struct cm_id_private *cm_find_listen(struct ib_device *device,
+					    __be64 service_id)
 {
 	struct rb_node *node = cm.listen_service_table.rb_node;
 	struct cm_id_private *cm_id_priv;
@@ -708,8 +707,8 @@ static struct cm_id_private * cm_find_listen(struct ib_device *device,
 	return NULL;
 }
 
-static struct cm_timewait_info * cm_insert_remote_id(struct cm_timewait_info
-						     *timewait_info)
+static struct cm_timewait_info *cm_insert_remote_id(struct cm_timewait_info
+						    *timewait_info)
 {
 	struct rb_node **link = &cm.remote_id_table.rb_node;
 	struct rb_node *parent = NULL;
@@ -767,8 +766,8 @@ static struct cm_id_private *cm_find_remote_id(__be64 remote_ca_guid,
 	return res;
 }
 
-static struct cm_timewait_info * cm_insert_remote_qpn(struct cm_timewait_info
-						      *timewait_info)
+static struct cm_timewait_info *cm_insert_remote_qpn(struct cm_timewait_info
+						     *timewait_info)
 {
 	struct rb_node **link = &cm.remote_qp_table.rb_node;
 	struct rb_node *parent = NULL;
@@ -797,8 +796,8 @@ static struct cm_timewait_info * cm_insert_remote_qpn(struct cm_timewait_info
 	return NULL;
 }
 
-static struct cm_id_private * cm_insert_remote_sidr(struct cm_id_private
-						    *cm_id_priv)
+static struct cm_id_private *cm_insert_remote_sidr(struct cm_id_private
+						   *cm_id_priv)
 {
 	struct rb_node **link = &cm.remote_sidr_table.rb_node;
 	struct rb_node *parent = NULL;
@@ -897,7 +896,7 @@ struct ib_cm_id *ib_create_cm_id(struct ib_device *device,
 }
 EXPORT_SYMBOL(ib_create_cm_id);
 
-static struct cm_work * cm_dequeue_work(struct cm_id_private *cm_id_priv)
+static struct cm_work *cm_dequeue_work(struct cm_id_private *cm_id_priv)
 {
 	struct cm_work *work;
 
@@ -986,7 +985,7 @@ static void cm_remove_remote(struct cm_id_private *cm_id_priv)
 	}
 }
 
-static struct cm_timewait_info * cm_create_timewait_info(__be32 local_id)
+static struct cm_timewait_info *cm_create_timewait_info(__be32 local_id)
 {
 	struct cm_timewait_info *timewait_info;
 
@@ -1977,8 +1976,8 @@ unlock:	spin_unlock_irq(&cm_id_priv->lock);
 free:	cm_free_msg(msg);
 }
 
-static struct cm_id_private * cm_match_req(struct cm_work *work,
-					   struct cm_id_private *cm_id_priv)
+static struct cm_id_private *cm_match_req(struct cm_work *work,
+					  struct cm_id_private *cm_id_priv)
 {
 	struct cm_id_private *listen_cm_id_priv, *cur_cm_id_priv;
 	struct cm_timewait_info *timewait_info;
@@ -2994,7 +2993,7 @@ static void cm_format_rej_event(struct cm_work *work)
 		IBA_GET_MEM_PTR(CM_REJ_PRIVATE_DATA, rej_msg);
 }
 
-static struct cm_id_private * cm_acquire_rejected_id(struct cm_rej_msg *rej_msg)
+static struct cm_id_private *cm_acquire_rejected_id(struct cm_rej_msg *rej_msg)
 {
 	struct cm_id_private *cm_id_priv;
 	__be32 remote_id;
@@ -3156,7 +3155,7 @@ error2:	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 }
 EXPORT_SYMBOL(ib_send_cm_mra);
 
-static struct cm_id_private * cm_acquire_mraed_id(struct cm_mra_msg *mra_msg)
+static struct cm_id_private *cm_acquire_mraed_id(struct cm_mra_msg *mra_msg)
 {
 	switch (IBA_GET(CM_MRA_MESSAGE_MRAED, mra_msg)) {
 	case CM_MSG_RESPONSE_REQ:
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 5ad22b2..670608c 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -625,7 +625,7 @@ static int cma_acquire_dev_by_src_ip(struct rdma_id_private *id_priv)
 
 	mutex_lock(&lock);
 	list_for_each_entry(cma_dev, &dev_list, list) {
-		rdma_for_each_port (cma_dev->device, port) {
+		rdma_for_each_port(cma_dev->device, port) {
 			gidp = rdma_protocol_roce(cma_dev->device, port) ?
 			       &iboe_gid : &gid;
 			gid_type = cma_dev->default_gid_type[port - 1];
@@ -727,7 +727,7 @@ static int cma_iw_acquire_dev(struct rdma_id_private *id_priv,
 	}
 
 	list_for_each_entry(cma_dev, &dev_list, list) {
-		rdma_for_each_port (cma_dev->device, port) {
+		rdma_for_each_port(cma_dev->device, port) {
 			if (listen_id_priv->cma_dev == cma_dev &&
 			    listen_id_priv->id.port_num == port)
 				continue;
@@ -772,7 +772,7 @@ static int cma_resolve_ib_dev(struct rdma_id_private *id_priv)
 
 	mutex_lock(&lock);
 	list_for_each_entry(cur_dev, &dev_list, list) {
-		rdma_for_each_port (cur_dev->device, p) {
+		rdma_for_each_port(cur_dev->device, p) {
 			if (!rdma_cap_af_ib(cur_dev->device, p))
 				continue;
 
@@ -3128,7 +3128,7 @@ static int cma_bind_loopback(struct rdma_id_private *id_priv)
 		if (!cma_dev)
 			cma_dev = cur_dev;
 
-		rdma_for_each_port (cur_dev->device, p) {
+		rdma_for_each_port(cur_dev->device, p) {
 			if (!ib_get_cached_port_state(cur_dev->device, p, &port_state) &&
 			    port_state == IB_PORT_ACTIVE) {
 				cma_dev = cur_dev;
@@ -4886,7 +4886,7 @@ static int cma_add_one(struct ib_device *device)
 		goto free_gid_type;
 	}
 
-	rdma_for_each_port (device, i) {
+	rdma_for_each_port(device, i) {
 		supported_gids = roce_gid_type_mask_support(device, i);
 		WARN_ON(!supported_gids);
 		if (supported_gids & (1 << CMA_PREFERRED_ROCE_GID_TYPE))
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index c660cef..5d1558c 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -343,7 +343,7 @@ static struct ib_device *__ib_device_get_by_name(const char *name)
 	struct ib_device *device;
 	unsigned long index;
 
-	xa_for_each (&devices, index, device)
+	xa_for_each(&devices, index, device)
 		if (!strcmp(name, dev_name(&device->dev)))
 			return device;
 
@@ -385,7 +385,7 @@ static int rename_compat_devs(struct ib_device *device)
 	int ret = 0;
 
 	mutex_lock(&device->compat_devs_mutex);
-	xa_for_each (&device->compat_devs, index, cdev) {
+	xa_for_each(&device->compat_devs, index, cdev) {
 		ret = device_rename(&cdev->dev, dev_name(&device->dev));
 		if (ret) {
 			dev_warn(&cdev->dev,
@@ -459,7 +459,7 @@ static int alloc_name(struct ib_device *ibdev, const char *name)
 
 	lockdep_assert_held_write(&devices_rwsem);
 	ida_init(&inuse);
-	xa_for_each (&devices, index, device) {
+	xa_for_each(&devices, index, device) {
 		char buf[IB_DEVICE_NAME_MAX];
 
 		if (sscanf(dev_name(&device->dev), name, &i) != 1)
@@ -811,7 +811,7 @@ static int alloc_port_data(struct ib_device *device)
 	 */
 	device->port_data = pdata_rcu->pdata;
 
-	rdma_for_each_port (device, port) {
+	rdma_for_each_port(device, port) {
 		struct ib_port_data *pdata = &device->port_data[port];
 
 		pdata->ib_dev = device;
@@ -838,7 +838,7 @@ static int setup_port_data(struct ib_device *device)
 	if (ret)
 		return ret;
 
-	rdma_for_each_port (device, port) {
+	rdma_for_each_port(device, port) {
 		struct ib_port_data *pdata = &device->port_data[port];
 
 		ret = device->ops.get_port_immutable(device, port,
@@ -881,10 +881,10 @@ static void ib_policy_change_task(struct work_struct *work)
 	unsigned long index;
 
 	down_read(&devices_rwsem);
-	xa_for_each_marked (&devices, index, dev, DEVICE_REGISTERED) {
+	xa_for_each_marked(&devices, index, dev, DEVICE_REGISTERED) {
 		unsigned int i;
 
-		rdma_for_each_port (dev, i) {
+		rdma_for_each_port(dev, i) {
 			u64 sp;
 			int ret = ib_get_cached_subnet_prefix(dev,
 							      i,
@@ -1013,7 +1013,7 @@ static void remove_compat_devs(struct ib_device *device)
 	struct ib_core_device *cdev;
 	unsigned long index;
 
-	xa_for_each (&device->compat_devs, index, cdev)
+	xa_for_each(&device->compat_devs, index, cdev)
 		remove_one_compat_dev(device, index);
 }
 
@@ -1026,7 +1026,7 @@ static int add_compat_devs(struct ib_device *device)
 	lockdep_assert_held(&devices_rwsem);
 
 	down_read(&rdma_nets_rwsem);
-	xa_for_each (&rdma_nets, index, rnet) {
+	xa_for_each(&rdma_nets, index, rnet) {
 		ret = add_one_compat_dev(device, rnet);
 		if (ret)
 			break;
@@ -1042,14 +1042,14 @@ static void remove_all_compat_devs(void)
 	unsigned long index;
 
 	down_read(&devices_rwsem);
-	xa_for_each (&devices, index, dev) {
+	xa_for_each(&devices, index, dev) {
 		unsigned long c_index = 0;
 
 		/* Hold nets_rwsem so that any other thread modifying this
 		 * system param can sync with this thread.
 		 */
 		down_read(&rdma_nets_rwsem);
-		xa_for_each (&dev->compat_devs, c_index, cdev)
+		xa_for_each(&dev->compat_devs, c_index, cdev)
 			remove_one_compat_dev(dev, c_index);
 		up_read(&rdma_nets_rwsem);
 	}
@@ -1064,14 +1064,14 @@ static int add_all_compat_devs(void)
 	int ret = 0;
 
 	down_read(&devices_rwsem);
-	xa_for_each_marked (&devices, index, dev, DEVICE_REGISTERED) {
+	xa_for_each_marked(&devices, index, dev, DEVICE_REGISTERED) {
 		unsigned long net_index = 0;
 
 		/* Hold nets_rwsem so that any other thread modifying this
 		 * system param can sync with this thread.
 		 */
 		down_read(&rdma_nets_rwsem);
-		xa_for_each (&rdma_nets, net_index, rnet) {
+		xa_for_each(&rdma_nets, net_index, rnet) {
 			ret = add_one_compat_dev(dev, rnet);
 			if (ret)
 				break;
@@ -1099,7 +1099,7 @@ int rdma_compatdev_set(u8 enable)
 	/* enable/disable of compat devices is not supported
 	 * when more than default init_net exists.
 	 */
-	xa_for_each (&rdma_nets, index, rnet) {
+	xa_for_each(&rdma_nets, index, rnet) {
 		ret++;
 		break;
 	}
@@ -1132,7 +1132,7 @@ static void rdma_dev_exit_net(struct net *net)
 	up_write(&rdma_nets_rwsem);
 
 	down_read(&devices_rwsem);
-	xa_for_each (&devices, index, dev) {
+	xa_for_each(&devices, index, dev) {
 		get_device(&dev->dev);
 		/*
 		 * Release the devices_rwsem so that pontentially blocking
@@ -1180,7 +1180,7 @@ static __net_init int rdma_dev_init_net(struct net *net)
 	}
 
 	down_read(&devices_rwsem);
-	xa_for_each_marked (&devices, index, dev, DEVICE_REGISTERED) {
+	xa_for_each_marked(&devices, index, dev, DEVICE_REGISTERED) {
 		/* Hold nets_rwsem so that netlink command cannot change
 		 * system configuration for device sharing mode.
 		 */
@@ -1331,7 +1331,7 @@ static int enable_device_and_get(struct ib_device *device)
 	}
 
 	down_read(&clients_rwsem);
-	xa_for_each_marked (&clients, index, client, CLIENT_REGISTERED) {
+	xa_for_each_marked(&clients, index, client, CLIENT_REGISTERED) {
 		ret = add_client_context(device, client);
 		if (ret)
 			break;
@@ -1557,7 +1557,7 @@ void ib_unregister_driver(enum rdma_driver_id driver_id)
 	unsigned long index;
 
 	down_read(&devices_rwsem);
-	xa_for_each (&devices, index, ib_dev) {
+	xa_for_each(&devices, index, ib_dev) {
 		if (ib_dev->ops.driver_id != driver_id)
 			continue;
 
@@ -1783,7 +1783,7 @@ int ib_register_client(struct ib_client *client)
 		return ret;
 
 	down_read(&devices_rwsem);
-	xa_for_each_marked (&devices, index, device, DEVICE_REGISTERED) {
+	xa_for_each_marked(&devices, index, device, DEVICE_REGISTERED) {
 		ret = add_client_context(device, client);
 		if (ret) {
 			up_read(&devices_rwsem);
@@ -1819,7 +1819,7 @@ void ib_unregister_client(struct ib_client *client)
 
 	/* We do not want to have locks while calling client->remove() */
 	rcu_read_lock();
-	xa_for_each (&devices, index, device) {
+	xa_for_each(&devices, index, device) {
 		if (!ib_device_try_get(device))
 			continue;
 		rcu_read_unlock();
@@ -1848,7 +1848,7 @@ static int __ib_get_global_client_nl_info(const char *client_name,
 	int ret = -ENOENT;
 
 	down_read(&clients_rwsem);
-	xa_for_each_marked (&clients, index, client, CLIENT_REGISTERED) {
+	xa_for_each_marked(&clients, index, client, CLIENT_REGISTERED) {
 		if (strcmp(client->name, client_name) != 0)
 			continue;
 		if (!client->get_global_nl_info) {
@@ -1875,8 +1875,8 @@ static int __ib_get_client_nl_info(struct ib_device *ibdev,
 	int ret = -ENOENT;
 
 	down_read(&ibdev->client_data_rwsem);
-	xan_for_each_marked (&ibdev->client_data, index, client_data,
-			     CLIENT_DATA_REGISTERED) {
+	xan_for_each_marked(&ibdev->client_data, index, client_data,
+			    CLIENT_DATA_REGISTERED) {
 		struct ib_client *client = xa_load(&clients, index);
 
 		if (!client || strcmp(client->name, client_name) != 0)
@@ -2182,7 +2182,7 @@ static void free_netdevs(struct ib_device *ib_dev)
 	if (!ib_dev->port_data)
 		return;
 
-	rdma_for_each_port (ib_dev, port) {
+	rdma_for_each_port(ib_dev, port) {
 		struct ib_port_data *pdata = &ib_dev->port_data[port];
 		struct net_device *ndev;
 
@@ -2261,8 +2261,8 @@ struct ib_device *ib_device_get_by_netdev(struct net_device *ndev,
 	struct ib_port_data *cur;
 
 	rcu_read_lock();
-	hash_for_each_possible_rcu (ndev_hash, cur, ndev_hash_link,
-				    (uintptr_t)ndev) {
+	hash_for_each_possible_rcu(ndev_hash, cur, ndev_hash_link,
+				   (uintptr_t)ndev) {
 		if (rcu_access_pointer(cur->netdev) == ndev &&
 		    (driver_id == RDMA_DRIVER_UNKNOWN ||
 		     cur->ib_dev->ops.driver_id == driver_id) &&
@@ -2297,7 +2297,7 @@ void ib_enum_roce_netdev(struct ib_device *ib_dev,
 {
 	u32 port;
 
-	rdma_for_each_port (ib_dev, port)
+	rdma_for_each_port(ib_dev, port)
 		if (rdma_protocol_roce(ib_dev, port)) {
 			struct net_device *idev =
 				ib_device_get_netdev(ib_dev, port);
@@ -2330,7 +2330,7 @@ void ib_enum_all_roce_netdevs(roce_netdev_filter filter,
 	unsigned long index;
 
 	down_read(&devices_rwsem);
-	xa_for_each_marked (&devices, index, dev, DEVICE_REGISTERED)
+	xa_for_each_marked(&devices, index, dev, DEVICE_REGISTERED)
 		ib_enum_roce_netdev(dev, filter, filter_cookie, cb, cookie);
 	up_read(&devices_rwsem);
 }
@@ -2350,7 +2350,7 @@ int ib_enum_all_devs(nldev_callback nldev_cb, struct sk_buff *skb,
 	int ret = 0;
 
 	down_read(&devices_rwsem);
-	xa_for_each_marked (&devices, index, dev, DEVICE_REGISTERED) {
+	xa_for_each_marked(&devices, index, dev, DEVICE_REGISTERED) {
 		if (!rdma_dev_access_netns(dev, sock_net(skb->sk)))
 			continue;
 
@@ -2456,7 +2456,7 @@ int ib_find_gid(struct ib_device *device, union ib_gid *gid,
 	u32 port;
 	int ret, i;
 
-	rdma_for_each_port (device, port) {
+	rdma_for_each_port(device, port) {
 		if (!rdma_protocol_ib(device, port))
 			continue;
 
@@ -2547,8 +2547,8 @@ struct net_device *ib_get_net_dev_by_params(struct ib_device *dev,
 	 * unregistered while we are calling get_net_dev_by_params()
 	 */
 	down_read(&dev->client_data_rwsem);
-	xan_for_each_marked (&dev->client_data, index, client_data,
-			     CLIENT_DATA_REGISTERED) {
+	xan_for_each_marked(&dev->client_data, index, client_data,
+			    CLIENT_DATA_REGISTERED) {
 		struct ib_client *client = xa_load(&clients, index);
 
 		if (!client || !client->get_net_dev_by_params)
diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 16ecb81..f066fb1 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -807,7 +807,7 @@ static int alloc_send_rmpp_list(struct ib_mad_send_wr_private *send_wr,
 
 	/* Allocate data segments. */
 	for (left = send_buf->data_len + pad; left > 0; left -= seg_size) {
-		seg = kmalloc(sizeof (*seg) + seg_size, gfp_mask);
+		seg = kmalloc(sizeof(*seg) + seg_size, gfp_mask);
 		if (!seg) {
 			free_send_rmpp_list(send_wr);
 			return -ENOMEM;
@@ -837,12 +837,12 @@ int ib_mad_kernel_rmpp_agent(const struct ib_mad_agent *agent)
 }
 EXPORT_SYMBOL(ib_mad_kernel_rmpp_agent);
 
-struct ib_mad_send_buf * ib_create_send_mad(struct ib_mad_agent *mad_agent,
-					    u32 remote_qpn, u16 pkey_index,
-					    int rmpp_active,
-					    int hdr_len, int data_len,
-					    gfp_t gfp_mask,
-					    u8 base_version)
+struct ib_mad_send_buf *ib_create_send_mad(struct ib_mad_agent *mad_agent,
+					   u32 remote_qpn, u16 pkey_index,
+					   int rmpp_active,
+					   int hdr_len, int data_len,
+					   gfp_t gfp_mask,
+					   u8 base_version)
 {
 	struct ib_mad_agent_private *mad_agent_priv;
 	struct ib_mad_send_wr_private *mad_send_wr;
@@ -1679,7 +1679,7 @@ static inline int rcv_has_same_class(const struct ib_mad_send_wr_private *wr,
 
 static inline int rcv_has_same_gid(const struct ib_mad_agent_private *mad_agent_priv,
 				   const struct ib_mad_send_wr_private *wr,
-				   const struct ib_mad_recv_wc *rwc )
+				   const struct ib_mad_recv_wc *rwc)
 {
 	struct rdma_ah_attr attr;
 	u8 send_resp, rcv_resp;
@@ -2256,7 +2256,7 @@ void ib_mad_complete_send_wr(struct ib_mad_send_wr_private *mad_send_wr,
 	adjust_timeout(mad_agent_priv);
 	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
-	if (mad_send_wr->status != IB_WC_SUCCESS )
+	if (mad_send_wr->status != IB_WC_SUCCESS)
 		mad_send_wc->status = mad_send_wr->status;
 	if (ret == IB_RMPP_RESULT_INTERNAL)
 		ib_rmpp_send_handler(mad_send_wc);
@@ -3127,7 +3127,7 @@ static void ib_mad_remove_device(struct ib_device *device, void *client_data)
 {
 	unsigned int i;
 
-	rdma_for_each_port (device, i) {
+	rdma_for_each_port(device, i) {
 		if (!rdma_cap_ib_mad(device, i))
 			continue;
 
diff --git a/drivers/infiniband/core/mad_rmpp.c b/drivers/infiniband/core/mad_rmpp.c
index e0573e4..8af0619 100644
--- a/drivers/infiniband/core/mad_rmpp.c
+++ b/drivers/infiniband/core/mad_rmpp.c
@@ -382,8 +382,8 @@ static inline int get_seg_num(struct ib_mad_recv_buf *seg)
 	return be32_to_cpu(rmpp_mad->rmpp_hdr.seg_num);
 }
 
-static inline struct ib_mad_recv_buf * get_next_seg(struct list_head *rmpp_list,
-						    struct ib_mad_recv_buf *seg)
+static inline struct ib_mad_recv_buf *get_next_seg(struct list_head *rmpp_list,
+						   struct ib_mad_recv_buf *seg)
 {
 	if (seg->list.next == rmpp_list)
 		return NULL;
@@ -396,8 +396,8 @@ static inline int window_size(struct ib_mad_agent_private *agent)
 	return max(agent->qp_info->recv_queue.max_active >> 3, 1);
 }
 
-static struct ib_mad_recv_buf * find_seg_location(struct list_head *rmpp_list,
-						  int seg_num)
+static struct ib_mad_recv_buf *find_seg_location(struct list_head *rmpp_list,
+						 int seg_num)
 {
 	struct ib_mad_recv_buf *seg_buf;
 	int cur_seg_num;
@@ -449,7 +449,7 @@ static inline int get_mad_len(struct mad_rmpp_recv *rmpp_recv)
 	return hdr_size + rmpp_recv->seg_num * data_size - pad;
 }
 
-static struct ib_mad_recv_wc * complete_rmpp(struct mad_rmpp_recv *rmpp_recv)
+static struct ib_mad_recv_wc *complete_rmpp(struct mad_rmpp_recv *rmpp_recv)
 {
 	struct ib_mad_recv_wc *rmpp_wc;
 
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index b8dc002..47c0801 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1077,7 +1077,7 @@ static int nldev_port_get_dumpit(struct sk_buff *skb,
 	if (!device)
 		return -EINVAL;
 
-	rdma_for_each_port (device, p) {
+	rdma_for_each_port(device, p) {
 		/*
 		 * The dumpit function returns all information from specific
 		 * index. This specific index is taken from the netlink
diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
index e5a78d1..ea8fe47 100644
--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -50,8 +50,8 @@ static struct pkey_index_qp_list *get_pkey_idx_qp_list(struct ib_port_pkey *pp)
 	struct ib_device *dev = pp->sec->dev;
 
 	spin_lock(&dev->port_data[pp->port_num].pkey_list_lock);
-	list_for_each_entry (tmp_pkey, &dev->port_data[pp->port_num].pkey_list,
-			     pkey_index_list) {
+	list_for_each_entry(tmp_pkey, &dev->port_data[pp->port_num].pkey_list,
+			    pkey_index_list) {
 		if (tmp_pkey->pkey_index == pp->pkey_index) {
 			pkey = tmp_pkey;
 			break;
@@ -418,7 +418,7 @@ int ib_create_qp_security(struct ib_qp *qp, struct ib_device *dev)
 	bool is_ib = false;
 	int ret;
 
-	rdma_for_each_port (dev, i) {
+	rdma_for_each_port(dev, i) {
 		is_ib = rdma_protocol_ib(dev, i);
 		if (is_ib)
 			break;
@@ -543,8 +543,8 @@ void ib_security_cache_change(struct ib_device *device,
 {
 	struct pkey_index_qp_list *pkey;
 
-	list_for_each_entry (pkey, &device->port_data[port_num].pkey_list,
-			     pkey_index_list) {
+	list_for_each_entry(pkey, &device->port_data[port_num].pkey_list,
+			    pkey_index_list) {
 		check_pkey_qps(pkey,
 			       device,
 			       port_num,
@@ -557,7 +557,7 @@ void ib_security_release_port_pkey_list(struct ib_device *device)
 	struct pkey_index_qp_list *pkey, *tmp_pkey;
 	unsigned int i;
 
-	rdma_for_each_port (device, i) {
+	rdma_for_each_port(device, i) {
 		list_for_each_entry_safe(pkey,
 					 tmp_pkey,
 					 &device->port_data[i].pkey_list,
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index dcff5e7..43a3dc7 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -297,7 +297,7 @@ static ssize_t rate_show(struct ib_port *p, struct port_attribute *unused,
 
 static const char *phys_state_to_str(enum ib_port_phys_state phys_state)
 {
-	static const char * phys_state_str[] = {
+	static const char *phys_state_str[] = {
 		"<unknown>",
 		"Sleep",
 		"Polling",
@@ -470,14 +470,14 @@ static ssize_t show_port_pkey(struct ib_port *p, struct port_attribute *attr,
 struct port_table_attribute port_pma_attr_##_name = {			\
 	.attr  = __ATTR(_name, S_IRUGO, show_pma_counter, NULL),	\
 	.index = (_offset) | ((_width) << 16) | ((_counter) << 24),	\
-	.attr_id = IB_PMA_PORT_COUNTERS ,				\
+	.attr_id = IB_PMA_PORT_COUNTERS,				\
 }
 
 #define PORT_PMA_ATTR_EXT(_name, _width, _offset)			\
 struct port_table_attribute port_pma_attr_ext_##_name = {		\
 	.attr  = __ATTR(_name, S_IRUGO, show_pma_counter, NULL),	\
 	.index = (_offset) | ((_width) << 16),				\
-	.attr_id = IB_PMA_PORT_COUNTERS_EXT ,				\
+	.attr_id = IB_PMA_PORT_COUNTERS_EXT,				\
 }
 
 /*
@@ -1390,7 +1390,7 @@ int ib_setup_port_attrs(struct ib_core_device *coredev)
 	if (!coredev->ports_kobj)
 		return -ENOMEM;
 
-	rdma_for_each_port (device, port) {
+	rdma_for_each_port(device, port) {
 		ret = add_port(coredev, port);
 		if (ret)
 			goto err_put;
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index 2e90517..ad5de66 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -165,8 +165,8 @@ static void ib_umad_dev_put(struct ib_umad_device *dev)
 
 static int hdr_size(struct ib_umad_file *file)
 {
-	return file->use_pkey_index ? sizeof (struct ib_user_mad_hdr) :
-		sizeof (struct ib_user_mad_hdr_old);
+	return file->use_pkey_index ? sizeof(struct ib_user_mad_hdr) :
+		sizeof(struct ib_user_mad_hdr_old);
 }
 
 /* caller must hold file->mutex */
@@ -1417,7 +1417,7 @@ static void ib_umad_remove_one(struct ib_device *device, void *client_data)
 	struct ib_umad_device *umad_dev = client_data;
 	unsigned int i;
 
-	rdma_for_each_port (device, i) {
+	rdma_for_each_port(device, i) {
 		if (rdma_cap_ib_mad(device, i))
 			ib_umad_kill_port(
 				&umad_dev->ports[i - rdma_start_port(device)]);
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 9e070ff..aed1a23 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2002,12 +2002,12 @@ static int ib_uverbs_destroy_qp(struct uverbs_attr_bundle *attrs)
 
 static void *alloc_wr(size_t wr_size, __u32 num_sge)
 {
-	if (num_sge >= (U32_MAX - ALIGN(wr_size, sizeof (struct ib_sge))) /
-		       sizeof (struct ib_sge))
+	if (num_sge >= (U32_MAX - ALIGN(wr_size, sizeof(struct ib_sge))) /
+		       sizeof(struct ib_sge))
 		return NULL;
 
-	return kmalloc(ALIGN(wr_size, sizeof (struct ib_sge)) +
-			 num_sge * sizeof (struct ib_sge), GFP_KERNEL);
+	return kmalloc(ALIGN(wr_size, sizeof(struct ib_sge)) +
+		       num_sge * sizeof(struct ib_sge), GFP_KERNEL);
 }
 
 static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
@@ -2216,7 +2216,7 @@ ib_uverbs_unmarshall_recv(struct uverbs_req_iter *iter, u32 wr_count,
 	const struct ib_sge __user *sgls;
 	const void __user *wqes;
 
-	if (wqe_size < sizeof (struct ib_uverbs_recv_wr))
+	if (wqe_size < sizeof(struct ib_uverbs_recv_wr))
 		return ERR_PTR(-EINVAL);
 
 	wqes = uverbs_request_next_ptr(iter, wqe_size * wr_count);
@@ -2249,14 +2249,14 @@ ib_uverbs_unmarshall_recv(struct uverbs_req_iter *iter, u32 wr_count,
 		}
 
 		if (user_wr->num_sge >=
-		    (U32_MAX - ALIGN(sizeof *next, sizeof (struct ib_sge))) /
-		    sizeof (struct ib_sge)) {
+		    (U32_MAX - ALIGN(sizeof *next, sizeof(struct ib_sge))) /
+		    sizeof(struct ib_sge)) {
 			ret = -EINVAL;
 			goto err;
 		}
 
-		next = kmalloc(ALIGN(sizeof *next, sizeof (struct ib_sge)) +
-			       user_wr->num_sge * sizeof (struct ib_sge),
+		next = kmalloc(ALIGN(sizeof *next, sizeof(struct ib_sge)) +
+			       user_wr->num_sge * sizeof(struct ib_sge),
 			       GFP_KERNEL);
 		if (!next) {
 			ret = -ENOMEM;
@@ -2275,7 +2275,7 @@ ib_uverbs_unmarshall_recv(struct uverbs_req_iter *iter, u32 wr_count,
 
 		if (next->num_sge) {
 			next->sg_list = (void *) next +
-				ALIGN(sizeof *next, sizeof (struct ib_sge));
+				ALIGN(sizeof *next, sizeof(struct ib_sge));
 			if (copy_from_user(next->sg_list, sgls + sg_ind,
 					   next->num_sge *
 						   sizeof(struct ib_sge))) {
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index f173ecd..09d9e0e 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -849,8 +849,7 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
 		 */
 		mmap_read_lock(mm);
 		mutex_lock(&ufile->umap_lock);
-		list_for_each_entry_safe (priv, next_priv, &ufile->umaps,
-					  list) {
+		list_for_each_entry_safe(priv, next_priv, &ufile->umaps, list) {
 			struct vm_area_struct *vma = priv->vma;
 
 			if (vma->vm_mm != mm)
diff --git a/drivers/infiniband/core/uverbs_uapi.c b/drivers/infiniband/core/uverbs_uapi.c
index 62f5bcb..f460792 100644
--- a/drivers/infiniband/core/uverbs_uapi.c
+++ b/drivers/infiniband/core/uverbs_uapi.c
@@ -360,8 +360,8 @@ uapi_finalize_ioctl_method(struct uverbs_api *uapi,
 	void __rcu **slot;
 
 	method_elm->destroy_bkey = UVERBS_API_ATTR_BKEY_LEN;
-	radix_tree_for_each_slot (slot, &uapi->radix, &iter,
-				  uapi_key_attrs_start(method_key)) {
+	radix_tree_for_each_slot(slot, &uapi->radix, &iter,
+				 uapi_key_attrs_start(method_key)) {
 		struct uverbs_api_attr *elm =
 			rcu_dereference_protected(*slot, true);
 		u32 attr_key = iter.index & UVERBS_API_ATTR_KEY_MASK;
@@ -422,7 +422,7 @@ static int uapi_finalize(struct uverbs_api *uapi)
 	int rc;
 	int i;
 
-	radix_tree_for_each_slot (slot, &uapi->radix, &iter, 0) {
+	radix_tree_for_each_slot(slot, &uapi->radix, &iter, 0) {
 		struct uverbs_api_ioctl_method *method_elm =
 			rcu_dereference_protected(*slot, true);
 
@@ -452,7 +452,7 @@ static int uapi_finalize(struct uverbs_api *uapi)
 	uapi->write_methods = data;
 	uapi->write_ex_methods = data + uapi->num_write;
 
-	radix_tree_for_each_slot (slot, &uapi->radix, &iter, 0) {
+	radix_tree_for_each_slot(slot, &uapi->radix, &iter, 0) {
 		if (uapi_key_is_write_method(iter.index))
 			uapi->write_methods[iter.index &
 					    UVERBS_API_ATTR_KEY_MASK] =
@@ -471,7 +471,7 @@ static void uapi_remove_range(struct uverbs_api *uapi, u32 start, u32 last)
 	struct radix_tree_iter iter;
 	void __rcu **slot;
 
-	radix_tree_for_each_slot (slot, &uapi->radix, &iter, start) {
+	radix_tree_for_each_slot(slot, &uapi->radix, &iter, start) {
 		if (iter.index > last)
 			return;
 		kfree(rcu_dereference_protected(*slot, true));
@@ -528,7 +528,7 @@ static void uapi_finalize_disable(struct uverbs_api *uapi)
 	void __rcu **slot;
 
 again:
-	radix_tree_for_each_slot (slot, &uapi->radix, &iter, starting_key) {
+	radix_tree_for_each_slot(slot, &uapi->radix, &iter, starting_key) {
 		uapi_key_okay(iter.index);
 
 		if (uapi_key_is_object(iter.index)) {
@@ -686,7 +686,7 @@ void uverbs_disassociate_api_pre(struct ib_uverbs_device *uverbs_dev)
 
 	rcu_assign_pointer(uverbs_dev->ib_dev, NULL);
 
-	radix_tree_for_each_slot (slot, &uapi->radix, &iter, 0) {
+	radix_tree_for_each_slot(slot, &uapi->radix, &iter, 0) {
 		if (uapi_key_is_ioctl_method(iter.index)) {
 			struct uverbs_api_ioctl_method *method_elm =
 				rcu_dereference_protected(*slot, true);
@@ -709,7 +709,7 @@ void uverbs_disassociate_api(struct uverbs_api *uapi)
 	struct radix_tree_iter iter;
 	void __rcu **slot;
 
-	radix_tree_for_each_slot (slot, &uapi->radix, &iter, 0) {
+	radix_tree_for_each_slot(slot, &uapi->radix, &iter, 0) {
 		if (uapi_key_is_object(iter.index)) {
 			struct uverbs_api_object *object_elm =
 				rcu_dereference_protected(*slot, true);
-- 
2.8.1

