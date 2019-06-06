Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD9E37230
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 12:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfFFKyy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 06:54:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbfFFKyy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Jun 2019 06:54:54 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6866920868;
        Thu,  6 Jun 2019 10:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559818493;
        bh=TxvXKFUAdSUMomABdPR858GwO0nexoRQsLG8H+9jJdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v6+661ULDHI8p+dqVS8d+5xgoao5Ow3FDou66Oqigp/fuNni3zFyioHq21HKRrUBx
         pd/2y9jjVXEHaLLGFacQkWJ00d3dcMO05FtH+GJciaSzOhPmUvZ2limNXeHrc9KIW+
         vmGItKtBWcI/tdCwB127+lie+R57aaWyu2DdPqZ8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH rdma-next v3 17/17] RDMA/nldev: Allow get default counter statistics through RDMA netlink
Date:   Thu,  6 Jun 2019 13:53:45 +0300
Message-Id: <20190606105345.8546-18-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606105345.8546-1-leon@kernel.org>
References: <20190606105345.8546-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

This patch adds the ability to return the hwstats of per-port default
counters (which can also be queried through sysfs nodes).

Signed-off-by: Mark Zhang <markz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/nldev.c | 102 +++++++++++++++++++++++++++++++-
 drivers/infiniband/core/sysfs.c |   6 ++
 include/rdma/ib_verbs.h         |   1 +
 3 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 615c9377d6b0..b12e22eacf3c 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1705,6 +1705,99 @@ static int nldev_stat_del_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return ret;
 }
 
+static int nldev_res_get_default_counter_doit(struct sk_buff *skb,
+					      struct nlmsghdr *nlh,
+					      struct netlink_ext_ack *extack,
+					      struct nlattr *tb[])
+{
+	struct rdma_hw_stats *stats;
+	struct nlattr *table_attr;
+	struct ib_device *device;
+	int ret, num_cnts, i;
+	struct sk_buff *msg;
+	u32 index, port;
+	u64 v;
+
+	if (!tb[RDMA_NLDEV_ATTR_DEV_INDEX] || !tb[RDMA_NLDEV_ATTR_PORT_INDEX])
+		return -EINVAL;
+
+	index = nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
+	device = ib_device_get_by_index(sock_net(skb->sk), index);
+	if (!device)
+		return -EINVAL;
+
+	if (!device->ops.alloc_hw_stats || !device->ops.get_hw_stats) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	port = nla_get_u32(tb[RDMA_NLDEV_ATTR_PORT_INDEX]);
+	if (!rdma_is_port_valid(device, port)) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
+			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
+					 RDMA_NLDEV_CMD_STAT_GET),
+			0, 0);
+
+	if (fill_nldev_handle(msg, device) ||
+	    nla_put_u32(msg, RDMA_NLDEV_ATTR_PORT_INDEX, port)) {
+		ret = -EMSGSIZE;
+		goto err_msg;
+	}
+
+	stats = device->port_data ? device->port_data[port].hw_stats : NULL;
+	if (stats == NULL) {
+		ret = -EINVAL;
+		goto err_msg;
+	}
+	mutex_lock(&stats->lock);
+
+	num_cnts = device->ops.get_hw_stats(device, stats, port, 0);
+	if (num_cnts < 0) {
+		ret = -EINVAL;
+		goto err_stats;
+	}
+
+	table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_STAT_HWCOUNTERS);
+	if (!table_attr) {
+		ret = -EMSGSIZE;
+		goto err_stats;
+	}
+	for (i = 0; i < num_cnts; i++) {
+		v = stats->value[i] +
+			rdma_counter_get_hwstat_value(device, port, i);
+		if (fill_stat_hwcounter_entry(msg, stats->names[i], v)) {
+			ret = -EMSGSIZE;
+			goto err_table;
+		}
+	}
+	nla_nest_end(msg, table_attr);
+
+	mutex_unlock(&stats->lock);
+	nlmsg_end(msg, nlh);
+	ib_device_put(device);
+	return rdma_nl_unicast(msg, NETLINK_CB(skb).portid);
+
+err_table:
+	nla_nest_cancel(msg, table_attr);
+err_stats:
+	mutex_unlock(&stats->lock);
+err_msg:
+	nlmsg_free(msg);
+err:
+	ib_device_put(device);
+	return ret;
+}
+
 static int nldev_stat_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 			       struct netlink_ext_ack *extack)
 {
@@ -1721,8 +1814,13 @@ static int nldev_stat_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (ret)
 		return -EINVAL;
 
-	if (!tb[RDMA_NLDEV_ATTR_STAT_MODE])
-		return nldev_res_get_counter_doit(skb, nlh, extack);
+	if (!tb[RDMA_NLDEV_ATTR_STAT_MODE]) {
+		if (!tb[RDMA_NLDEV_ATTR_STAT_COUNTER_ID])
+			return nldev_res_get_default_counter_doit(skb, nlh,
+								  extack, tb);
+		else
+			return nldev_res_get_counter_doit(skb, nlh, extack);
+	}
 
 	if (!tb[RDMA_NLDEV_ATTR_STAT_RES] || !tb[RDMA_NLDEV_ATTR_DEV_INDEX] ||
 	    !tb[RDMA_NLDEV_ATTR_PORT_INDEX])
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index c59b80e0a740..b477295a96c2 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1003,6 +1003,8 @@ static void setup_hw_stats(struct ib_device *device, struct ib_port *port,
 			goto err;
 		port->hw_stats_ag = hsag;
 		port->hw_stats = stats;
+		if (device->port_data)
+			device->port_data[port_num].hw_stats = stats;
 	} else {
 		struct kobject *kobj = &device->dev.kobj;
 		ret = sysfs_create_group(kobj, hsag);
@@ -1293,6 +1295,8 @@ const struct attribute_group ib_dev_attr_group = {
 
 void ib_free_port_attrs(struct ib_core_device *coredev)
 {
+	struct ib_device *device = rdma_device_to_ibdev(&coredev->dev);
+	bool is_full_dev = &device->coredev == coredev;
 	struct kobject *p, *t;
 
 	list_for_each_entry_safe(p, t, &coredev->port_list, entry) {
@@ -1302,6 +1306,8 @@ void ib_free_port_attrs(struct ib_core_device *coredev)
 		if (port->hw_stats_ag)
 			free_hsag(&port->kobj, port->hw_stats_ag);
 		kfree(port->hw_stats);
+		if (device->port_data && is_full_dev)
+			device->port_data[port->port_num].hw_stats = NULL;
 
 		if (port->pma_table)
 			sysfs_remove_group(p, port->pma_table);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 160245d4604c..e56ee0fa62e2 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2248,6 +2248,7 @@ struct ib_port_data {
 	struct net_device __rcu *netdev;
 	struct hlist_node ndev_hash_link;
 	struct rdma_port_counter port_counter;
+	struct rdma_hw_stats *hw_stats;
 };
 
 /* rdma netdev type - specifies protocol type */
-- 
2.20.1

