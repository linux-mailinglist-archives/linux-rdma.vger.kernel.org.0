Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA79537229
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 12:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfFFKyZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 06:54:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfFFKyZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Jun 2019 06:54:25 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C43F206E0;
        Thu,  6 Jun 2019 10:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559818464;
        bh=Vt3y1XrGZe3qa1DVBekKYI1ZSAay8fhUSGOd4ybV008=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=roPeKf+qAs7WtET+Ik+1mHVCC+EJ6xeRiJ5GqYi5lTA8NO34epZBphQ/CjFKQbmkD
         qYO7GaJxNlbrsKe4pUPkvg5Od5BgBzS4A21QLWbmVy9SPcjizt9T9FGpag03wfQmZ2
         vnmV77jAa4/waM1yWDDJ05h+FF2JN/JiYSPmvb0g=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH rdma-next v3 11/17] RDMA/netlink: Implement counter dumpit calback
Date:   Thu,  6 Jun 2019 13:53:39 +0300
Message-Id: <20190606105345.8546-12-leon@kernel.org>
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

This patch adds the ability to return all available counters
together with their properties and hwstats.

Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Majd Dibbiny <majd@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/counters.c |  27 +++++
 drivers/infiniband/core/device.c   |   2 +
 drivers/infiniband/core/nldev.c    | 165 +++++++++++++++++++++++++++++
 include/rdma/ib_verbs.h            |  10 ++
 include/rdma/rdma_counter.h        |   3 +
 include/uapi/rdma/rdma_netlink.h   |  10 +-
 6 files changed, 216 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index c5396a16a84a..6acbb7fad9d5 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -59,6 +59,9 @@ static struct rdma_counter *rdma_counter_alloc(struct ib_device *dev, u8 port,
 {
 	struct rdma_counter *counter;
 
+	if (!dev->ops.counter_alloc_stats)
+		return NULL;
+
 	counter = kzalloc(sizeof(*counter), GFP_KERNEL);
 	if (!counter)
 		return NULL;
@@ -66,16 +69,25 @@ static struct rdma_counter *rdma_counter_alloc(struct ib_device *dev, u8 port,
 	counter->device    = dev;
 	counter->port      = port;
 	counter->res.type  = RDMA_RESTRACK_COUNTER;
+	counter->stats     = dev->ops.counter_alloc_stats(counter);
+	if (!counter->stats)
+		goto err_stats;
+
 	counter->mode.mode = mode;
 	atomic_set(&counter->usecnt, 0);
 	mutex_init(&counter->lock);
 
 	return counter;
+
+err_stats:
+	kfree(counter);
+	return NULL;
 }
 
 static void rdma_counter_dealloc(struct rdma_counter *counter)
 {
 	rdma_restrack_del(&counter->res);
+	kfree(counter->stats);
 	kfree(counter);
 }
 
@@ -275,6 +287,21 @@ int rdma_counter_unbind_qp(struct ib_qp *qp, bool force)
 	return 0;
 }
 
+int rdma_counter_query_stats(struct rdma_counter *counter)
+{
+	struct ib_device *dev = counter->device;
+	int ret;
+
+	if (!dev->ops.counter_update_stats)
+		return -EINVAL;
+
+	mutex_lock(&counter->lock);
+	ret = dev->ops.counter_update_stats(counter);
+	mutex_unlock(&counter->lock);
+
+	return ret;
+}
+
 void rdma_counter_init(struct ib_device *dev)
 {
 	struct rdma_port_counter *port_counter;
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 810c3521621a..e0d0db54ffc6 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2353,8 +2353,10 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, alloc_xrcd);
 	SET_DEVICE_OP(dev_ops, attach_mcast);
 	SET_DEVICE_OP(dev_ops, check_mr_status);
+	SET_DEVICE_OP(dev_ops, counter_alloc_stats);
 	SET_DEVICE_OP(dev_ops, counter_bind_qp);
 	SET_DEVICE_OP(dev_ops, counter_unbind_qp);
+	SET_DEVICE_OP(dev_ops, counter_update_stats);
 	SET_DEVICE_OP(dev_ops, create_ah);
 	SET_DEVICE_OP(dev_ops, create_counters);
 	SET_DEVICE_OP(dev_ops, create_cq);
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 9819dc718928..3ddbc870ed55 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -123,6 +123,13 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_STAT_MODE]		= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_STAT_RES]		= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_STAT_AUTO_MODE_MASK]	= { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_STAT_COUNTER]		= { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_STAT_COUNTER_ENTRY]	= { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_STAT_COUNTER_ID]       = { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_STAT_HWCOUNTERS]       = { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY]  = { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_NAME] = { .type = NLA_NUL_STRING },
+	[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_VALUE] = { .type = NLA_U64 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -626,6 +633,152 @@ static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
 err:	return -EMSGSIZE;
 }
 
+static int fill_stat_counter_mode(struct sk_buff *msg,
+				  struct rdma_counter *counter)
+{
+	struct rdma_counter_mode *m = &counter->mode;
+
+	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_STAT_MODE, m->mode))
+		return -EMSGSIZE;
+
+	if (m->mode == RDMA_COUNTER_MODE_AUTO)
+		if ((m->mask & RDMA_COUNTER_MASK_QP_TYPE) &&
+		    nla_put_u8(msg, RDMA_NLDEV_ATTR_RES_TYPE, m->param.qp_type))
+			return -EMSGSIZE;
+
+	return 0;
+}
+
+static int fill_stat_counter_qp_entry(struct sk_buff *msg, u32 qpn)
+{
+	struct nlattr *entry_attr;
+
+	entry_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_RES_QP_ENTRY);
+	if (!entry_attr)
+		return -EMSGSIZE;
+
+	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_LQPN, qpn))
+		goto err;
+
+	nla_nest_end(msg, entry_attr);
+	return 0;
+
+err:
+	nla_nest_cancel(msg, entry_attr);
+	return -EMSGSIZE;
+}
+
+static int fill_stat_counter_qps(struct sk_buff *msg,
+				 struct rdma_counter *counter)
+{
+	struct rdma_restrack_entry *res;
+	struct rdma_restrack_root *rt;
+	struct nlattr *table_attr;
+	struct ib_qp *qp = NULL;
+	unsigned long id = 0;
+	int ret = 0;
+
+	table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_RES_QP);
+
+	rt = &counter->device->res[RDMA_RESTRACK_QP];
+	xa_lock(&rt->xa);
+	xa_for_each(&rt->xa, id, res) {
+		if (!rdma_is_visible_in_pid_ns(res))
+			continue;
+
+		qp = container_of(res, struct ib_qp, res);
+		if (qp->qp_type == IB_QPT_RAW_PACKET && !capable(CAP_NET_RAW))
+			continue;
+
+		if (!qp->counter || (qp->counter->id != counter->id))
+			continue;
+
+		ret = fill_stat_counter_qp_entry(msg, qp->qp_num);
+		if (ret)
+			goto err;
+	}
+
+	xa_unlock(&rt->xa);
+	nla_nest_end(msg, table_attr);
+	return 0;
+
+err:
+	xa_unlock(&rt->xa);
+	nla_nest_cancel(msg, table_attr);
+	return ret;
+}
+
+static int fill_stat_hwcounter_entry(struct sk_buff *msg,
+				     const char *name, u64 value)
+{
+	struct nlattr *entry_attr;
+
+	entry_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY);
+	if (!entry_attr)
+		return -EMSGSIZE;
+
+	if (nla_put_string(msg, RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_NAME,
+			   name))
+		goto err;
+	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_VALUE,
+			      value, RDMA_NLDEV_ATTR_PAD))
+		goto err;
+
+	nla_nest_end(msg, entry_attr);
+	return 0;
+
+err:
+	nla_nest_cancel(msg, entry_attr);
+	return -EMSGSIZE;
+}
+
+static int fill_stat_counter_hwcounters(struct sk_buff *msg,
+					struct rdma_counter *counter)
+{
+	struct rdma_hw_stats *st = counter->stats;
+	struct nlattr *table_attr;
+	int i;
+
+	table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_STAT_HWCOUNTERS);
+	if (!table_attr)
+		return -EMSGSIZE;
+
+	for (i = 0; i < st->num_counters; i++)
+		if (fill_stat_hwcounter_entry(msg, st->names[i], st->value[i]))
+			goto err;
+
+	nla_nest_end(msg, table_attr);
+	return 0;
+
+err:
+	nla_nest_cancel(msg, table_attr);
+	return -EMSGSIZE;
+}
+
+static int fill_res_counter_entry(struct sk_buff *msg, bool has_cap_net_admin,
+				  struct rdma_restrack_entry *res,
+				  uint32_t port)
+{
+	struct rdma_counter *counter =
+		container_of(res, struct rdma_counter, res);
+
+	if (port && port != counter->port)
+		return 0;
+
+	/* Dump it even query failed */
+	rdma_counter_query_stats(counter);
+
+	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_PORT_INDEX, counter->port) ||
+	    nla_put_u32(msg, RDMA_NLDEV_ATTR_STAT_COUNTER_ID, counter->id) ||
+	    fill_res_name_pid(msg, &counter->res) ||
+	    fill_stat_counter_mode(msg, counter) ||
+	    fill_stat_counter_qps(msg, counter) ||
+	    fill_stat_counter_hwcounters(msg, counter))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 static int nldev_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 			  struct netlink_ext_ack *extack)
 {
@@ -993,6 +1146,13 @@ static const struct nldev_fill_res_entry fill_entries[RDMA_RESTRACK_MAX] = {
 		.entry = RDMA_NLDEV_ATTR_RES_PD_ENTRY,
 		.id = RDMA_NLDEV_ATTR_RES_PDN,
 	},
+	[RDMA_RESTRACK_COUNTER] = {
+		.fill_res_func = fill_res_counter_entry,
+		.nldev_cmd = RDMA_NLDEV_CMD_STAT_GET,
+		.nldev_attr = RDMA_NLDEV_ATTR_STAT_COUNTER,
+		.entry = RDMA_NLDEV_ATTR_STAT_COUNTER_ENTRY,
+		.id = RDMA_NLDEV_ATTR_STAT_COUNTER_ID,
+	},
 };
 
 static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -1229,6 +1389,7 @@ RES_GET_FUNCS(cm_id, RDMA_RESTRACK_CM_ID);
 RES_GET_FUNCS(cq, RDMA_RESTRACK_CQ);
 RES_GET_FUNCS(pd, RDMA_RESTRACK_PD);
 RES_GET_FUNCS(mr, RDMA_RESTRACK_MR);
+RES_GET_FUNCS(counter, RDMA_RESTRACK_COUNTER);
 
 static LIST_HEAD(link_ops);
 static DECLARE_RWSEM(link_ops_rwsem);
@@ -1518,6 +1679,10 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 		.doit = nldev_stat_set_doit,
 		.flags = RDMA_NL_ADMIN_PERM,
 	},
+	[RDMA_NLDEV_CMD_STAT_GET] = {
+		.doit = nldev_res_get_counter_doit,
+		.dump = nldev_res_get_counter_dumpit,
+	},
 };
 
 void __init nldev_init(void)
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 823a775dea7b..160245d4604c 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2614,6 +2614,16 @@ struct ib_device_ops {
 	 *   used in cases like qp destroy.
 	 */
 	int (*counter_unbind_qp)(struct ib_qp *qp, bool force);
+	/**
+	 * counter_alloc_stats - Allocate a struct rdma_hw_stats and fill in
+	 * the driver initialized data.
+	 */
+	struct rdma_hw_stats *(*counter_alloc_stats)(
+		struct rdma_counter *counter);
+	/**
+	 * counter_update_stats - Query the stats value of this counter
+	 */
+	int (*counter_update_stats)(struct rdma_counter *counter);
 
 	DECLARE_RDMA_OBJ_SIZE(ib_ah);
 	DECLARE_RDMA_OBJ_SIZE(ib_pd);
diff --git a/include/rdma/rdma_counter.h b/include/rdma/rdma_counter.h
index 36fa47136da2..ea142debfa11 100644
--- a/include/rdma/rdma_counter.h
+++ b/include/rdma/rdma_counter.h
@@ -37,6 +37,7 @@ struct rdma_counter {
 	atomic_t			usecnt;
 	struct rdma_counter_mode	mode;
 	struct mutex			lock;
+	struct rdma_hw_stats		*stats;
 	u8				port;
 };
 
@@ -47,4 +48,6 @@ int rdma_counter_set_auto_mode(struct ib_device *dev, u8 port,
 int rdma_counter_bind_qp_auto(struct ib_qp *qp, u8 port);
 int rdma_counter_unbind_qp(struct ib_qp *qp, bool force);
 
+int rdma_counter_query_stats(struct rdma_counter *counter);
+
 #endif /* _RDMA_COUNTER_H_ */
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 357c0477b454..18437dfb35d7 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -269,6 +269,8 @@ enum rdma_nldev_command {
 
 	RDMA_NLDEV_CMD_STAT_SET,
 
+	RDMA_NLDEV_CMD_STAT_GET, /* can dump */
+
 	RDMA_NLDEV_NUM_OPS
 };
 
@@ -486,7 +488,13 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_STAT_MODE,		/* u32 */
 	RDMA_NLDEV_ATTR_STAT_RES,		/* u32 */
 	RDMA_NLDEV_ATTR_STAT_AUTO_MODE_MASK,	/* u32 */
-
+	RDMA_NLDEV_ATTR_STAT_COUNTER,		/* nested table */
+	RDMA_NLDEV_ATTR_STAT_COUNTER_ENTRY,	/* nested table */
+	RDMA_NLDEV_ATTR_STAT_COUNTER_ID,	/* u32 */
+	RDMA_NLDEV_ATTR_STAT_HWCOUNTERS,	/* nested table */
+	RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY,	/* nested table */
+	RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_NAME,	/* string */
+	RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_VALUE,	/* u64 */
 	/*
 	 * Always the end
 	 */
-- 
2.20.1

