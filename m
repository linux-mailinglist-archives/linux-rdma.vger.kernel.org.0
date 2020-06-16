Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963F91FAE67
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 12:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgFPKqZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 06:46:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgFPKqZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Jun 2020 06:46:25 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56FA120734;
        Tue, 16 Jun 2020 10:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592304383;
        bh=PnaBR+tvsBWjt8G2eQUDDR3JTPi2ngY5gfN7oyYmRH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RfJxVFKlJPnS8GzpEMrXU9KrzIrbIBBr0XjMI1N6IohcXj9iEq6/eZJhypAlrsMbG
         8oC9FRbG9V8PIAfPGWlVSHF8rCqT42tznk86uQjJ4o+m/K3BuYRTiUpNDwZU2AV12J
         U6eMArZXBxyVIUxSe0AVAzW7q6C7v1V6jfDpSp7M=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 08/11] RDMA: Add support to dump resource tracker in RAW format
Date:   Tue, 16 Jun 2020 13:40:03 +0300
Message-Id: <20200616104006.2425549-9-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200616104006.2425549-1-leon@kernel.org>
References: <20200616104006.2425549-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

Add support to get resource dump in raw format. It enable vendors
to return the entire QP/CQ/MR context without a need from the vendor
to set each field separately.
When user request to get the data in RAW, we return as key value
the generic fields which not require to query the vendor and in addition
we return the rest of the data as binary.

Example:

$rdma res show mr dev mlx5_1 mrn 2 -r -j
[{"ifindex":7,"ifname":"mlx5_1","mrn":2,"mrlen":4096,"pdn":5,
pid":24336, "comm":"ibv_rc_pingpong",
"data":[0,4,255,254,0,0,0,0,0,0,0,0,16,28,0,216,...]}]

Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/device.c |   3 +
 drivers/infiniband/core/nldev.c  | 144 ++++++++++++++++++++++---------
 include/rdma/ib_verbs.h          |   3 +
 include/uapi/rdma/rdma_netlink.h |   8 ++
 4 files changed, 119 insertions(+), 39 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index cbe95e729cf1..1335ed1f1e4a 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2619,8 +2619,11 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, enable_driver);
 	SET_DEVICE_OP(dev_ops, fill_res_cm_id_entry);
 	SET_DEVICE_OP(dev_ops, fill_res_cq_entry);
+	SET_DEVICE_OP(dev_ops, fill_res_cq_entry_raw);
 	SET_DEVICE_OP(dev_ops, fill_res_mr_entry);
+	SET_DEVICE_OP(dev_ops, fill_res_mr_entry_raw);
 	SET_DEVICE_OP(dev_ops, fill_res_qp_entry);
+	SET_DEVICE_OP(dev_ops, fill_res_qp_entry_raw);
 	SET_DEVICE_OP(dev_ops, fill_stat_mr_entry);
 	SET_DEVICE_OP(dev_ops, get_dev_fw_str);
 	SET_DEVICE_OP(dev_ops, get_dma_mr);
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 394e307c342c..badf2cf33d8e 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -44,7 +44,7 @@
 #include "uverbs.h"
 
 typedef int (*res_fill_func_t)(struct sk_buff*, bool,
-			       struct rdma_restrack_entry*, uint32_t);
+			       struct rdma_restrack_entry*, uint32_t, bool);
 
 /*
  * Sort array elements by the netlink attribute name
@@ -114,6 +114,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_RES_PS]		= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_RES_QP]		= { .type = NLA_NESTED },
 	[RDMA_NLDEV_ATTR_RES_QP_ENTRY]		= { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_RES_RAW]		= { .type = NLA_BINARY },
 	[RDMA_NLDEV_ATTR_RES_RKEY]		= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_RES_RQPN]		= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_RES_RQ_PSN]		= { .type = NLA_U32 },
@@ -446,11 +447,11 @@ static int fill_res_name_pid(struct sk_buff *msg,
 	return err ? -EMSGSIZE : 0;
 }
 
-static int fill_res_qp_entry(struct sk_buff *msg, bool has_cap_net_admin,
-			     struct rdma_restrack_entry *res, uint32_t port)
+static int fill_res_qp_entry_query(struct sk_buff *msg,
+				   struct rdma_restrack_entry *res,
+				   struct ib_device *dev,
+				   struct ib_qp *qp)
 {
-	struct ib_qp *qp = container_of(res, struct ib_qp, res);
-	struct ib_device *dev = qp->device;
 	struct ib_qp_init_attr qp_init_attr;
 	struct ib_qp_attr qp_attr;
 	int ret;
@@ -459,16 +460,6 @@ static int fill_res_qp_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	if (ret)
 		return ret;
 
-	if (port && port != qp_attr.port_num)
-		return -EAGAIN;
-
-	/* In create_qp() port is not set yet */
-	if (qp_attr.port_num &&
-	    nla_put_u32(msg, RDMA_NLDEV_ATTR_PORT_INDEX, qp_attr.port_num))
-		goto err;
-
-	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_LQPN, qp->qp_num))
-		goto err;
 	if (qp->qp_type == IB_QPT_RC || qp->qp_type == IB_QPT_UC) {
 		if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_RQPN,
 				qp_attr.dest_qp_num))
@@ -492,22 +483,52 @@ static int fill_res_qp_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	if (nla_put_u8(msg, RDMA_NLDEV_ATTR_RES_STATE, qp_attr.qp_state))
 		goto err;
 
+	if (dev->ops.fill_res_qp_entry)
+		return dev->ops.fill_res_qp_entry(msg, qp);
+	return 0;
+
+err:	return -EMSGSIZE;
+}
+
+static int fill_res_qp_entry(struct sk_buff *msg, bool has_cap_net_admin,
+			     struct rdma_restrack_entry *res, uint32_t port,
+			     bool raw)
+{
+	struct ib_qp *qp = container_of(res, struct ib_qp, res);
+	struct ib_device *dev = qp->device;
+	int ret;
+
+	if (port && port != qp->port)
+		return -EAGAIN;
+
+	/* In create_qp() port is not set yet */
+	if (qp->port && nla_put_u32(msg, RDMA_NLDEV_ATTR_PORT_INDEX, qp->port))
+		return -EINVAL;
+
+	ret = nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_LQPN, qp->qp_num);
+	if (ret)
+		goto err;
+
 	if (!rdma_is_kernel_res(res) &&
 	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PDN, qp->pd->res.id))
 		goto err;
 
-	if (fill_res_name_pid(msg, res))
+	ret = fill_res_name_pid(msg, res);
+	if (ret)
 		goto err;
 
-	if (dev->ops.fill_res_qp_entry)
-		return dev->ops.fill_res_qp_entry(msg, qp);
-	return 0;
+	if (!raw)
+		return fill_res_qp_entry_query(msg, res, dev, qp);
+
+	if (dev->ops.fill_res_qp_entry_raw)
+		return dev->ops.fill_res_qp_entry_raw(msg, qp);
 
 err:	return -EMSGSIZE;
 }
 
 static int fill_res_cm_id_entry(struct sk_buff *msg, bool has_cap_net_admin,
-				struct rdma_restrack_entry *res, uint32_t port)
+				struct rdma_restrack_entry *res, uint32_t port,
+				bool raw)
 {
 	struct rdma_id_private *id_priv =
 				container_of(res, struct rdma_id_private, res);
@@ -559,7 +580,8 @@ err: return -EMSGSIZE;
 }
 
 static int fill_res_cq_entry(struct sk_buff *msg, bool has_cap_net_admin,
-			     struct rdma_restrack_entry *res, uint32_t port)
+			     struct rdma_restrack_entry *res, uint32_t port,
+			     bool raw)
 {
 	struct ib_cq *cq = container_of(res, struct ib_cq, res);
 	struct ib_device *dev = cq->device;
@@ -588,15 +610,21 @@ static int fill_res_cq_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	if (fill_res_name_pid(msg, res))
 		goto err;
 
-	if (dev->ops.fill_res_cq_entry)
-		return dev->ops.fill_res_cq_entry(msg, cq);
-	return 0;
+	if (!raw)
+		return (dev->ops.fill_res_cq_entry) ?
+			       dev->ops.fill_res_cq_entry(msg, cq) :
+			       0;
+
+	return (dev->ops.fill_res_cq_entry_raw) ?
+		       dev->ops.fill_res_cq_entry_raw(msg, cq) :
+		       0;
 
 err:	return -EMSGSIZE;
 }
 
 static int fill_res_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
-			     struct rdma_restrack_entry *res, uint32_t port)
+			     struct rdma_restrack_entry *res, uint32_t port,
+			     bool raw)
 {
 	struct ib_mr *mr = container_of(res, struct ib_mr, res);
 	struct ib_device *dev = mr->pd->device;
@@ -622,15 +650,21 @@ static int fill_res_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	if (fill_res_name_pid(msg, res))
 		goto err;
 
-	if (dev->ops.fill_res_mr_entry)
-		return dev->ops.fill_res_mr_entry(msg, mr);
-	return 0;
+	if (!raw)
+		return (dev->ops.fill_res_mr_entry) ?
+			       dev->ops.fill_res_mr_entry(msg, mr) :
+			       0;
+
+	return (dev->ops.fill_res_mr_entry_raw) ?
+		       dev->ops.fill_res_mr_entry_raw(msg, mr) :
+		       0;
 
 err:	return -EMSGSIZE;
 }
 
 static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
-			     struct rdma_restrack_entry *res, uint32_t port)
+			     struct rdma_restrack_entry *res, uint32_t port,
+			     bool raw)
 {
 	struct ib_pd *pd = container_of(res, struct ib_pd, res);
 
@@ -758,7 +792,8 @@ int rdma_nl_stat_hwcounter_entry(struct sk_buff *msg, const char *name,
 EXPORT_SYMBOL(rdma_nl_stat_hwcounter_entry);
 
 static int fill_stat_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
-			      struct rdma_restrack_entry *res, uint32_t port)
+			      struct rdma_restrack_entry *res, uint32_t port,
+			      bool raw)
 {
 	struct ib_mr *mr = container_of(res, struct ib_mr, res);
 	struct ib_device *dev = mr->pd->device;
@@ -799,7 +834,7 @@ static int fill_stat_counter_hwcounters(struct sk_buff *msg,
 
 static int fill_res_counter_entry(struct sk_buff *msg, bool has_cap_net_admin,
 				  struct rdma_restrack_entry *res,
-				  uint32_t port)
+				  uint32_t port, bool raw)
 {
 	struct rdma_counter *counter =
 		container_of(res, struct rdma_counter, res);
@@ -1150,6 +1185,7 @@ static int nldev_res_get_dumpit(struct sk_buff *skb,
 struct nldev_fill_res_entry {
 	enum rdma_nldev_attr nldev_attr;
 	enum rdma_nldev_command nldev_cmd;
+	enum rdma_nldev_command nldev_cmd_raw;
 	u8 flags;
 	u32 entry;
 	u32 id;
@@ -1162,6 +1198,7 @@ enum nldev_res_flags {
 static const struct nldev_fill_res_entry fill_entries[RDMA_RESTRACK_MAX] = {
 	[RDMA_RESTRACK_QP] = {
 		.nldev_cmd = RDMA_NLDEV_CMD_RES_QP_GET,
+		.nldev_cmd_raw = RDMA_NLDEV_CMD_RES_QP_GET_RAW,
 		.nldev_attr = RDMA_NLDEV_ATTR_RES_QP,
 		.entry = RDMA_NLDEV_ATTR_RES_QP_ENTRY,
 		.id = RDMA_NLDEV_ATTR_RES_LQPN,
@@ -1174,6 +1211,7 @@ static const struct nldev_fill_res_entry fill_entries[RDMA_RESTRACK_MAX] = {
 	},
 	[RDMA_RESTRACK_CQ] = {
 		.nldev_cmd = RDMA_NLDEV_CMD_RES_CQ_GET,
+		.nldev_cmd_raw = RDMA_NLDEV_CMD_RES_CQ_GET_RAW,
 		.nldev_attr = RDMA_NLDEV_ATTR_RES_CQ,
 		.flags = NLDEV_PER_DEV,
 		.entry = RDMA_NLDEV_ATTR_RES_CQ_ENTRY,
@@ -1181,6 +1219,7 @@ static const struct nldev_fill_res_entry fill_entries[RDMA_RESTRACK_MAX] = {
 	},
 	[RDMA_RESTRACK_MR] = {
 		.nldev_cmd = RDMA_NLDEV_CMD_RES_MR_GET,
+		.nldev_cmd_raw = RDMA_NLDEV_CMD_RES_MR_GET_RAW,
 		.nldev_attr = RDMA_NLDEV_ATTR_RES_MR,
 		.flags = NLDEV_PER_DEV,
 		.entry = RDMA_NLDEV_ATTR_RES_MR_ENTRY,
@@ -1204,7 +1243,7 @@ static const struct nldev_fill_res_entry fill_entries[RDMA_RESTRACK_MAX] = {
 static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 			       struct netlink_ext_ack *extack,
 			       enum rdma_restrack_type res_type,
-			       res_fill_func_t fill_func)
+			       res_fill_func_t fill_func, bool raw)
 {
 	const struct nldev_fill_res_entry *fe = &fill_entries[res_type];
 	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
@@ -1252,9 +1291,11 @@ static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto err_get;
 	}
 
-	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
-			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, fe->nldev_cmd),
-			0, 0);
+	nlh = nlmsg_put(
+		msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
+		RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
+				 (raw ? fe->nldev_cmd_raw : fe->nldev_cmd)),
+		0, 0);
 
 	if (fill_nldev_handle(msg, device)) {
 		ret = -EMSGSIZE;
@@ -1263,7 +1304,7 @@ static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	has_cap_net_admin = netlink_capable(skb, CAP_NET_ADMIN);
 
-	ret = fill_func(msg, has_cap_net_admin, res, port);
+	ret = fill_func(msg, has_cap_net_admin, res, port, raw);
 	if (ret)
 		goto err_free;
 
@@ -1369,7 +1410,7 @@ static int res_get_common_dumpit(struct sk_buff *skb,
 			goto msg_full;
 		}
 
-		ret = fill_func(skb, has_cap_net_admin, res, port);
+		ret = fill_func(skb, has_cap_net_admin, res, port, false);
 
 		rdma_restrack_put(res);
 
@@ -1425,7 +1466,7 @@ next:		idx++;
 					       struct netlink_ext_ack *extack) \
 	{								       \
 		return res_get_common_doit(skb, nlh, extack, type,	       \
-					   fill_res_##name##_entry);	       \
+					   fill_res_##name##_entry, false);    \
 	}
 
 RES_GET_FUNCS(qp, RDMA_RESTRACK_QP);
@@ -1435,6 +1476,19 @@ RES_GET_FUNCS(pd, RDMA_RESTRACK_PD);
 RES_GET_FUNCS(mr, RDMA_RESTRACK_MR);
 RES_GET_FUNCS(counter, RDMA_RESTRACK_COUNTER);
 
+#define RES_GET_FUNCS_RAW(name, type)                                          \
+	static int nldev_res_get_##name##_doit_raw(                            \
+		struct sk_buff *skb, struct nlmsghdr *nlh,                     \
+		struct netlink_ext_ack *extack)                                \
+	{                                                                      \
+		return res_get_common_doit(skb, nlh, extack, type,             \
+					   fill_res_##name##_entry, true);     \
+	}
+
+RES_GET_FUNCS_RAW(qp, RDMA_RESTRACK_QP);
+RES_GET_FUNCS_RAW(cq, RDMA_RESTRACK_CQ);
+RES_GET_FUNCS_RAW(mr, RDMA_RESTRACK_MR);
+
 static LIST_HEAD(link_ops);
 static DECLARE_RWSEM(link_ops_rwsem);
 
@@ -2014,7 +2068,7 @@ static int nldev_stat_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		break;
 	case RDMA_NLDEV_ATTR_RES_MR:
 		ret = res_get_common_doit(skb, nlh, extack, RDMA_RESTRACK_MR,
-					  fill_stat_mr_entry);
+					  fill_stat_mr_entry, false);
 		break;
 	default:
 		ret = -EINVAL;
@@ -2117,6 +2171,18 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 		.doit = nldev_stat_del_doit,
 		.flags = RDMA_NL_ADMIN_PERM,
 	},
+	[RDMA_NLDEV_CMD_RES_QP_GET_RAW] = {
+		.doit = nldev_res_get_qp_doit_raw,
+		.flags = RDMA_NL_ADMIN_PERM,
+	},
+	[RDMA_NLDEV_CMD_RES_CQ_GET_RAW] = {
+		.doit = nldev_res_get_cq_doit_raw,
+		.flags = RDMA_NL_ADMIN_PERM,
+	},
+	[RDMA_NLDEV_CMD_RES_MR_GET_RAW] = {
+		.doit = nldev_res_get_mr_doit_raw,
+		.flags = RDMA_NL_ADMIN_PERM,
+	},
 };
 
 void __init nldev_init(void)
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 5146a472511f..882e6593cdc8 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2584,8 +2584,11 @@ struct ib_device_ops {
 	 * Allows rdma drivers to add their own restrack attributes.
 	 */
 	int (*fill_res_mr_entry)(struct sk_buff *msg, struct ib_mr *ibmr);
+	int (*fill_res_mr_entry_raw)(struct sk_buff *msg, struct ib_mr *ibmr);
 	int (*fill_res_cq_entry)(struct sk_buff *msg, struct ib_cq *ibcq);
+	int (*fill_res_cq_entry_raw)(struct sk_buff *msg, struct ib_cq *ibcq);
 	int (*fill_res_qp_entry)(struct sk_buff *msg, struct ib_qp *ibqp);
+	int (*fill_res_qp_entry_raw)(struct sk_buff *msg, struct ib_qp *ibqp);
 	int (*fill_res_cm_id_entry)(struct sk_buff *msg, struct rdma_cm_id *id);
 
 	/* Device lifecycle callbacks */
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 8e277783fa96..3826143d420d 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -287,6 +287,12 @@ enum rdma_nldev_command {
 
 	RDMA_NLDEV_CMD_STAT_DEL,
 
+	RDMA_NLDEV_CMD_RES_QP_GET_RAW,
+
+	RDMA_NLDEV_CMD_RES_CQ_GET_RAW,
+
+	RDMA_NLDEV_CMD_RES_MR_GET_RAW,
+
 	RDMA_NLDEV_NUM_OPS
 };
 
@@ -525,6 +531,8 @@ enum rdma_nldev_attr {
 	 */
 	RDMA_NLDEV_ATTR_DEV_DIM,                /* u8 */
 
+	RDMA_NLDEV_ATTR_RES_RAW,	/* binary */
+
 	/*
 	 * Always the end
 	 */
-- 
2.26.2

