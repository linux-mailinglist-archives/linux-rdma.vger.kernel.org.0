Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDE67123F
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 09:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbfGWHCM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 03:02:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730794AbfGWHCM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jul 2019 03:02:12 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D332721911;
        Tue, 23 Jul 2019 07:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563865330;
        bh=zni/LAfaEjn557Ujaj8dz4zcS86yMBcC5r2VnIhB3eY=;
        h=From:To:Cc:Subject:Date:From;
        b=BR/lvV3XS8yDBr6ja5pCotngN93dwgrP4gpoh0cqUp3/bIKkHVJSaG3cUSrgBH2h+
         u9+RDsVCPD+7wzy7xOd8x18uB/aj2WOvLV8aFf+MpqLuC9/N8U8Nq/e5gJ7K/EmvZe
         CzWj9eYA5ZDSSLpP6oyErgjtocQXYJ5jVyO4xr7I=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Parav Pandit <parav@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH RESEND rdma-next] IB: Support netlink commands in non init_net net namespaces
Date:   Tue, 23 Jul 2019 10:02:05 +0300
Message-Id: <20190723070205.6247-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

Now that IB core supports RDMA device binding with specific net
namespace, enable IB core to accept netlink commands in non init_net
namespaces.

This is done by having per net namespace netlink socket.

At present only netlink device handling client RDMA_NL_NLDEV supports
device handling in multiple net namespaces.
Hence do not accept netlink messages for other clients in non init_net
net namespaces.

Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 Rebased on top v5.3-rc1
---
 drivers/infiniband/core/addr.c      |  2 +-
 drivers/infiniband/core/core_priv.h | 24 ++++++++++-
 drivers/infiniband/core/device.c    | 38 ++++++-----------
 drivers/infiniband/core/iwpm_msg.c  |  8 ++--
 drivers/infiniband/core/iwpm_util.c |  6 +--
 drivers/infiniband/core/netlink.c   | 63 ++++++++++++++++++++---------
 drivers/infiniband/core/nldev.c     | 20 ++++-----
 drivers/infiniband/core/sa_query.c  |  2 +-
 include/rdma/rdma_netlink.h         | 10 +++--
 9 files changed, 105 insertions(+), 68 deletions(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 9b76a8fcdd24..1dd467bed8fc 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -183,7 +183,7 @@ static int ib_nl_ip_send_msg(struct rdma_dev_addr *dev_addr,

 	/* Repair the nlmsg header length */
 	nlmsg_end(skb, nlh);
-	rdma_nl_multicast(skb, RDMA_NL_GROUP_LS, GFP_KERNEL);
+	rdma_nl_multicast(&init_net, skb, RDMA_NL_GROUP_LS, GFP_KERNEL);

 	/* Make the request retry, so when we get the response from userspace
 	 * we will have something.
diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 888d89ce81df..589ed805e0ad 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -36,6 +36,8 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/cgroup_rdma.h>
+#include <net/net_namespace.h>
+#include <net/netns/generic.h>

 #include <rdma/ib_verbs.h>
 #include <rdma/opa_addr.h>
@@ -54,8 +56,26 @@ struct pkey_index_qp_list {
 	struct list_head    qp_list;
 };

+/**
+ * struct rdma_dev_net - rdma net namespace metadata for a net
+ * @nl_sock:	Pointer to netlink socket
+ * @net:	Pointer to owner net namespace
+ * @id:		xarray id to identify the net namespace.
+ */
+struct rdma_dev_net {
+	struct sock *nl_sock;
+	possible_net_t net;
+	u32 id;
+};
+
 extern const struct attribute_group ib_dev_attr_group;
 extern bool ib_devices_shared_netns;
+extern unsigned int rdma_dev_net_id;
+
+static inline struct rdma_dev_net *rdma_net_to_dev_net(struct net *net)
+{
+	return net_generic(net, rdma_dev_net_id);
+}

 int ib_device_register_sysfs(struct ib_device *device);
 void ib_device_unregister_sysfs(struct ib_device *device);
@@ -179,7 +199,6 @@ void ib_mad_cleanup(void);
 int ib_sa_init(void);
 void ib_sa_cleanup(void);

-int rdma_nl_init(void);
 void rdma_nl_exit(void);

 int ib_nl_handle_resolve_resp(struct sk_buff *skb,
@@ -362,4 +381,7 @@ void ib_port_unregister_module_stat(struct kobject *kobj);

 int ib_device_set_netns_put(struct sk_buff *skb,
 			    struct ib_device *dev, u32 ns_fd);
+
+int rdma_nl_net_init(struct rdma_dev_net *rnet);
+void rdma_nl_net_exit(struct rdma_dev_net *rnet);
 #endif /* _CORE_PRIV_H */
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 9773145dee09..c56993e5e5ea 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -39,7 +39,6 @@
 #include <linux/init.h>
 #include <linux/netdevice.h>
 #include <net/net_namespace.h>
-#include <net/netns/generic.h>
 #include <linux/security.h>
 #include <linux/notifier.h>
 #include <linux/hashtable.h>
@@ -105,17 +104,7 @@ static DECLARE_RWSEM(clients_rwsem);
  */
 #define CLIENT_DATA_REGISTERED XA_MARK_1

-/**
- * struct rdma_dev_net - rdma net namespace metadata for a net
- * @net:	Pointer to owner net namespace
- * @id:		xarray id to identify the net namespace.
- */
-struct rdma_dev_net {
-	possible_net_t net;
-	u32 id;
-};
-
-static unsigned int rdma_dev_net_id;
+unsigned int rdma_dev_net_id;

 /*
  * A list of net namespaces is maintained in an xarray. This is necessary
@@ -1047,7 +1036,7 @@ int rdma_compatdev_set(u8 enable)

 static void rdma_dev_exit_net(struct net *net)
 {
-	struct rdma_dev_net *rnet = net_generic(net, rdma_dev_net_id);
+	struct rdma_dev_net *rnet = rdma_net_to_dev_net(net);
 	struct ib_device *dev;
 	unsigned long index;
 	int ret;
@@ -1081,25 +1070,32 @@ static void rdma_dev_exit_net(struct net *net)
 	}
 	up_read(&devices_rwsem);

+	rdma_nl_net_exit(rnet);
 	xa_erase(&rdma_nets, rnet->id);
 }

 static __net_init int rdma_dev_init_net(struct net *net)
 {
-	struct rdma_dev_net *rnet = net_generic(net, rdma_dev_net_id);
+	struct rdma_dev_net *rnet = rdma_net_to_dev_net(net);
 	unsigned long index;
 	struct ib_device *dev;
 	int ret;

+	write_pnet(&rnet->net, net);
+
+	ret = rdma_nl_net_init(rnet);
+	if (ret)
+		return ret;
+
 	/* No need to create any compat devices in default init_net. */
 	if (net_eq(net, &init_net))
 		return 0;

-	write_pnet(&rnet->net, net);
-
 	ret = xa_alloc(&rdma_nets, &rnet->id, rnet, xa_limit_32b, GFP_KERNEL);
-	if (ret)
+	if (ret) {
+		rdma_nl_net_exit(rnet);
 		return ret;
+	}

 	down_read(&devices_rwsem);
 	xa_for_each_marked (&devices, index, dev, DEVICE_REGISTERED) {
@@ -2626,12 +2622,6 @@ static int __init ib_core_init(void)
 		goto err_comp_unbound;
 	}

-	ret = rdma_nl_init();
-	if (ret) {
-		pr_warn("Couldn't init IB netlink interface: err %d\n", ret);
-		goto err_sysfs;
-	}
-
 	ret = addr_init();
 	if (ret) {
 		pr_warn("Could't init IB address resolution\n");
@@ -2677,8 +2667,6 @@ static int __init ib_core_init(void)
 err_addr:
 	addr_cleanup();
 err_ibnl:
-	rdma_nl_exit();
-err_sysfs:
 	class_unregister(&ib_class);
 err_comp_unbound:
 	destroy_workqueue(ib_comp_unbound_wq);
diff --git a/drivers/infiniband/core/iwpm_msg.c b/drivers/infiniband/core/iwpm_msg.c
index 2452b0ddcf0d..f1a873d4e842 100644
--- a/drivers/infiniband/core/iwpm_msg.c
+++ b/drivers/infiniband/core/iwpm_msg.c
@@ -112,7 +112,7 @@ int iwpm_register_pid(struct iwpm_dev_data *pm_msg, u8 nl_client)
 	pr_debug("%s: Multicasting a nlmsg (dev = %s ifname = %s iwpm = %s)\n",
 		__func__, pm_msg->dev_name, pm_msg->if_name, iwpm_ulib_name);

-	ret = rdma_nl_multicast(skb, RDMA_NL_GROUP_IWPM, GFP_KERNEL);
+	ret = rdma_nl_multicast(&init_net, skb, RDMA_NL_GROUP_IWPM, GFP_KERNEL);
 	if (ret) {
 		skb = NULL; /* skb is freed in the netlink send-op handling */
 		iwpm_user_pid = IWPM_PID_UNAVAILABLE;
@@ -202,7 +202,7 @@ int iwpm_add_mapping(struct iwpm_sa_data *pm_msg, u8 nl_client)
 	nlmsg_end(skb, nlh);
 	nlmsg_request->req_buffer = pm_msg;

-	ret = rdma_nl_unicast_wait(skb, iwpm_user_pid);
+	ret = rdma_nl_unicast_wait(&init_net, skb, iwpm_user_pid);
 	if (ret) {
 		skb = NULL; /* skb is freed in the netlink send-op handling */
 		iwpm_user_pid = IWPM_PID_UNDEFINED;
@@ -297,7 +297,7 @@ int iwpm_add_and_query_mapping(struct iwpm_sa_data *pm_msg, u8 nl_client)
 	nlmsg_end(skb, nlh);
 	nlmsg_request->req_buffer = pm_msg;

-	ret = rdma_nl_unicast_wait(skb, iwpm_user_pid);
+	ret = rdma_nl_unicast_wait(&init_net, skb, iwpm_user_pid);
 	if (ret) {
 		skb = NULL; /* skb is freed in the netlink send-op handling */
 		err_str = "Unable to send a nlmsg";
@@ -364,7 +364,7 @@ int iwpm_remove_mapping(struct sockaddr_storage *local_addr, u8 nl_client)

 	nlmsg_end(skb, nlh);

-	ret = rdma_nl_unicast_wait(skb, iwpm_user_pid);
+	ret = rdma_nl_unicast_wait(&init_net, skb, iwpm_user_pid);
 	if (ret) {
 		skb = NULL; /* skb is freed in the netlink send-op handling */
 		iwpm_user_pid = IWPM_PID_UNDEFINED;
diff --git a/drivers/infiniband/core/iwpm_util.c b/drivers/infiniband/core/iwpm_util.c
index 41929bb83739..c7ad3499228c 100644
--- a/drivers/infiniband/core/iwpm_util.c
+++ b/drivers/infiniband/core/iwpm_util.c
@@ -645,7 +645,7 @@ static int send_mapinfo_num(u32 mapping_num, u8 nl_client, int iwpm_pid)

 	nlmsg_end(skb, nlh);

-	ret = rdma_nl_unicast(skb, iwpm_pid);
+	ret = rdma_nl_unicast(&init_net, skb, iwpm_pid);
 	if (ret) {
 		skb = NULL;
 		err_str = "Unable to send a nlmsg";
@@ -674,7 +674,7 @@ static int send_nlmsg_done(struct sk_buff *skb, u8 nl_client, int iwpm_pid)
 		return -ENOMEM;
 	}
 	nlh->nlmsg_type = NLMSG_DONE;
-	ret = rdma_nl_unicast(skb, iwpm_pid);
+	ret = rdma_nl_unicast(&init_net, skb, iwpm_pid);
 	if (ret)
 		pr_warn("%s Unable to send a nlmsg\n", __func__);
 	return ret;
@@ -824,7 +824,7 @@ int iwpm_send_hello(u8 nl_client, int iwpm_pid, u16 abi_version)
 		goto hello_num_error;
 	nlmsg_end(skb, nlh);

-	ret = rdma_nl_unicast(skb, iwpm_pid);
+	ret = rdma_nl_unicast(&init_net, skb, iwpm_pid);
 	if (ret) {
 		skb = NULL;
 		err_str = "Unable to send a nlmsg";
diff --git a/drivers/infiniband/core/netlink.c b/drivers/infiniband/core/netlink.c
index eecfc0b377c9..67a76aca2dd6 100644
--- a/drivers/infiniband/core/netlink.c
+++ b/drivers/infiniband/core/netlink.c
@@ -36,20 +36,22 @@
 #include <linux/export.h>
 #include <net/netlink.h>
 #include <net/net_namespace.h>
+#include <net/netns/generic.h>
 #include <net/sock.h>
 #include <rdma/rdma_netlink.h>
 #include <linux/module.h>
 #include "core_priv.h"

 static DEFINE_MUTEX(rdma_nl_mutex);
-static struct sock *nls;
 static struct {
 	const struct rdma_nl_cbs   *cb_table;
 } rdma_nl_types[RDMA_NL_NUM_CLIENTS];

 bool rdma_nl_chk_listeners(unsigned int group)
 {
-	return netlink_has_listeners(nls, group);
+	struct rdma_dev_net *rnet = rdma_net_to_dev_net(&init_net);
+
+	return netlink_has_listeners(rnet->nl_sock, group);
 }
 EXPORT_SYMBOL(rdma_nl_chk_listeners);

@@ -73,13 +75,21 @@ static bool is_nl_msg_valid(unsigned int type, unsigned int op)
 	return (op < max_num_ops[type]) ? true : false;
 }

-static bool is_nl_valid(unsigned int type, unsigned int op)
+static bool
+is_nl_valid(const struct sk_buff *skb, unsigned int type, unsigned int op)
 {
 	const struct rdma_nl_cbs *cb_table;

 	if (!is_nl_msg_valid(type, op))
 		return false;

+	/*
+	 * Currently only NLDEV client is supporting netlink commands in
+	 * non init_net net namespace.
+	 */
+	if (sock_net(skb->sk) != &init_net && type != RDMA_NL_NLDEV)
+		return false;
+
 	if (!rdma_nl_types[type].cb_table) {
 		mutex_unlock(&rdma_nl_mutex);
 		request_module("rdma-netlink-subsys-%d", type);
@@ -161,7 +171,7 @@ static int rdma_nl_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	unsigned int op = RDMA_NL_GET_OP(type);
 	const struct rdma_nl_cbs *cb_table;

-	if (!is_nl_valid(index, op))
+	if (!is_nl_valid(skb, index, op))
 		return -EINVAL;

 	cb_table = rdma_nl_types[index].cb_table;
@@ -185,7 +195,7 @@ static int rdma_nl_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 			.dump = cb_table[op].dump,
 		};
 		if (c.dump)
-			return netlink_dump_start(nls, skb, nlh, &c);
+			return netlink_dump_start(skb->sk, skb, nlh, &c);
 		return -EINVAL;
 	}

@@ -258,52 +268,65 @@ static void rdma_nl_rcv(struct sk_buff *skb)
 	mutex_unlock(&rdma_nl_mutex);
 }

-int rdma_nl_unicast(struct sk_buff *skb, u32 pid)
+int rdma_nl_unicast(struct net *net, struct sk_buff *skb, u32 pid)
 {
+	struct rdma_dev_net *rnet = rdma_net_to_dev_net(net);
 	int err;

-	err = netlink_unicast(nls, skb, pid, MSG_DONTWAIT);
+	err = netlink_unicast(rnet->nl_sock, skb, pid, MSG_DONTWAIT);
 	return (err < 0) ? err : 0;
 }
 EXPORT_SYMBOL(rdma_nl_unicast);

-int rdma_nl_unicast_wait(struct sk_buff *skb, __u32 pid)
+int rdma_nl_unicast_wait(struct net *net, struct sk_buff *skb, __u32 pid)
 {
+	struct rdma_dev_net *rnet = rdma_net_to_dev_net(net);
 	int err;

-	err = netlink_unicast(nls, skb, pid, 0);
+	err = netlink_unicast(rnet->nl_sock, skb, pid, 0);
 	return (err < 0) ? err : 0;
 }
 EXPORT_SYMBOL(rdma_nl_unicast_wait);

-int rdma_nl_multicast(struct sk_buff *skb, unsigned int group, gfp_t flags)
+int rdma_nl_multicast(struct net *net, struct sk_buff *skb,
+		      unsigned int group, gfp_t flags)
 {
-	return nlmsg_multicast(nls, skb, 0, group, flags);
+	struct rdma_dev_net *rnet = rdma_net_to_dev_net(net);
+
+	return nlmsg_multicast(rnet->nl_sock, skb, 0, group, flags);
 }
 EXPORT_SYMBOL(rdma_nl_multicast);

-int __init rdma_nl_init(void)
+void rdma_nl_exit(void)
+{
+	int idx;
+
+	for (idx = 0; idx < RDMA_NL_NUM_CLIENTS; idx++)
+		WARN(rdma_nl_types[idx].cb_table,
+		     "Nelink client %d wasn't released prior to unloading %s\n",
+		     idx, KBUILD_MODNAME);
+}
+
+int rdma_nl_net_init(struct rdma_dev_net *rnet)
 {
+	struct net *net = read_pnet(&rnet->net);
 	struct netlink_kernel_cfg cfg = {
 		.input	= rdma_nl_rcv,
 	};
+	struct sock *nls;

-	nls = netlink_kernel_create(&init_net, NETLINK_RDMA, &cfg);
+	nls = netlink_kernel_create(net, NETLINK_RDMA, &cfg);
 	if (!nls)
 		return -ENOMEM;

 	nls->sk_sndtimeo = 10 * HZ;
+	rnet->nl_sock = nls;
 	return 0;
 }

-void rdma_nl_exit(void)
+void rdma_nl_net_exit(struct rdma_dev_net *rnet)
 {
-	int idx;
-
-	for (idx = 0; idx < RDMA_NL_NUM_CLIENTS; idx++)
-		rdma_nl_unregister(idx);
-
-	netlink_kernel_release(nls);
+	netlink_kernel_release(rnet->nl_sock);
 }

 MODULE_ALIAS_NET_PF_PROTO(PF_NETLINK, NETLINK_RDMA);
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 783e465e7c41..e287b71a1cfd 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -832,7 +832,7 @@ static int nldev_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	nlmsg_end(msg, nlh);

 	ib_device_put(device);
-	return rdma_nl_unicast(msg, NETLINK_CB(skb).portid);
+	return rdma_nl_unicast(sock_net(skb->sk), msg, NETLINK_CB(skb).portid);

 err_free:
 	nlmsg_free(msg);
@@ -972,7 +972,7 @@ static int nldev_port_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	nlmsg_end(msg, nlh);
 	ib_device_put(device);

-	return rdma_nl_unicast(msg, NETLINK_CB(skb).portid);
+	return rdma_nl_unicast(sock_net(skb->sk), msg, NETLINK_CB(skb).portid);

 err_free:
 	nlmsg_free(msg);
@@ -1074,7 +1074,7 @@ static int nldev_res_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,

 	nlmsg_end(msg, nlh);
 	ib_device_put(device);
-	return rdma_nl_unicast(msg, NETLINK_CB(skb).portid);
+	return rdma_nl_unicast(sock_net(skb->sk), msg, NETLINK_CB(skb).portid);

 err_free:
 	nlmsg_free(msg);
@@ -1251,7 +1251,7 @@ static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,

 	nlmsg_end(msg, nlh);
 	ib_device_put(device);
-	return rdma_nl_unicast(msg, NETLINK_CB(skb).portid);
+	return rdma_nl_unicast(sock_net(skb->sk), msg, NETLINK_CB(skb).portid);

 err_free:
 	nlmsg_free(msg);
@@ -1596,7 +1596,7 @@ static int nldev_get_chardev(struct sk_buff *skb, struct nlmsghdr *nlh,
 	put_device(data.cdev);
 	if (ibdev)
 		ib_device_put(ibdev);
-	return rdma_nl_unicast(msg, NETLINK_CB(skb).portid);
+	return rdma_nl_unicast(sock_net(skb->sk), msg, NETLINK_CB(skb).portid);

 out_data:
 	put_device(data.cdev);
@@ -1636,7 +1636,7 @@ static int nldev_sys_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return err;
 	}
 	nlmsg_end(msg, nlh);
-	return rdma_nl_unicast(msg, NETLINK_CB(skb).portid);
+	return rdma_nl_unicast(sock_net(skb->sk), msg, NETLINK_CB(skb).portid);
 }

 static int nldev_set_sys_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -1734,7 +1734,7 @@ static int nldev_stat_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,

 	nlmsg_end(msg, nlh);
 	ib_device_put(device);
-	return rdma_nl_unicast(msg, NETLINK_CB(skb).portid);
+	return rdma_nl_unicast(sock_net(skb->sk), msg, NETLINK_CB(skb).portid);

 err_fill:
 	rdma_counter_unbind_qpn(device, port, qpn, cntn);
@@ -1802,7 +1802,7 @@ static int nldev_stat_del_doit(struct sk_buff *skb, struct nlmsghdr *nlh,

 	nlmsg_end(msg, nlh);
 	ib_device_put(device);
-	return rdma_nl_unicast(msg, NETLINK_CB(skb).portid);
+	return rdma_nl_unicast(sock_net(skb->sk), msg, NETLINK_CB(skb).portid);

 err_fill:
 	rdma_counter_bind_qpn(device, port, qpn, cntn);
@@ -1893,7 +1893,7 @@ static int stat_get_doit_default_counter(struct sk_buff *skb,
 	mutex_unlock(&stats->lock);
 	nlmsg_end(msg, nlh);
 	ib_device_put(device);
-	return rdma_nl_unicast(msg, NETLINK_CB(skb).portid);
+	return rdma_nl_unicast(sock_net(skb->sk), msg, NETLINK_CB(skb).portid);

 err_table:
 	nla_nest_cancel(msg, table_attr);
@@ -1961,7 +1961,7 @@ static int stat_get_doit_qp(struct sk_buff *skb, struct nlmsghdr *nlh,

 	nlmsg_end(msg, nlh);
 	ib_device_put(device);
-	return rdma_nl_unicast(msg, NETLINK_CB(skb).portid);
+	return rdma_nl_unicast(sock_net(skb->sk), msg, NETLINK_CB(skb).portid);

 err_msg:
 	nlmsg_free(msg);
diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 7d8071c7e564..17fc2936c077 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -860,7 +860,7 @@ static int ib_nl_send_msg(struct ib_sa_query *query, gfp_t gfp_mask)
 	/* Repair the nlmsg header length */
 	nlmsg_end(skb, nlh);

-	return rdma_nl_multicast(skb, RDMA_NL_GROUP_LS, gfp_mask);
+	return rdma_nl_multicast(&init_net, skb, RDMA_NL_GROUP_LS, gfp_mask);
 }

 static int ib_nl_make_request(struct ib_sa_query *query, gfp_t gfp_mask)
diff --git a/include/rdma/rdma_netlink.h b/include/rdma/rdma_netlink.h
index 6631624e4d7c..ab22759de7ea 100644
--- a/include/rdma/rdma_netlink.h
+++ b/include/rdma/rdma_netlink.h
@@ -76,28 +76,32 @@ int ibnl_put_attr(struct sk_buff *skb, struct nlmsghdr *nlh,

 /**
  * Send the supplied skb to a specific userspace PID.
+ * @net: Net namespace in which to send the skb
  * @skb: The netlink skb
  * @pid: Userspace netlink process ID
  * Returns 0 on success or a negative error code.
  */
-int rdma_nl_unicast(struct sk_buff *skb, u32 pid);
+int rdma_nl_unicast(struct net *net, struct sk_buff *skb, u32 pid);

 /**
  * Send, with wait/1 retry, the supplied skb to a specific userspace PID.
+ * @net: Net namespace in which to send the skb
  * @skb: The netlink skb
  * @pid: Userspace netlink process ID
  * Returns 0 on success or a negative error code.
  */
-int rdma_nl_unicast_wait(struct sk_buff *skb, __u32 pid);
+int rdma_nl_unicast_wait(struct net *net, struct sk_buff *skb, __u32 pid);

 /**
  * Send the supplied skb to a netlink group.
+ * @net: Net namespace in which to send the skb
  * @skb: The netlink skb
  * @group: Netlink group ID
  * @flags: allocation flags
  * Returns 0 on success or a negative error code.
  */
-int rdma_nl_multicast(struct sk_buff *skb, unsigned int group, gfp_t flags);
+int rdma_nl_multicast(struct net *net, struct sk_buff *skb,
+		      unsigned int group, gfp_t flags);

 /**
  * Check if there are any listeners to the netlink group
--
2.20.1

