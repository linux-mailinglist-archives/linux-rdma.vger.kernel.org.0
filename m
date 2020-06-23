Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CDF2050BE
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 13:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732449AbgFWLbQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 07:31:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732447AbgFWLbP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jun 2020 07:31:15 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1512B20702;
        Tue, 23 Jun 2020 11:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592911874;
        bh=KtLIlE2oLPa7XUrihfBZuZwEw3CqUS0f2DvzYxrVnHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MswIbpAUuUEuhV95pjVs+0xD7+lt8MJv3PsRZzIyhvhZGCIGhAS7rMRvqffVoNnph
         TYBrGmQAZcp0VIe1zEihzdEODfq7CtSspblANsS93obWuYdJvdGaJ9WZUbUJle6GDM
         Qs67AG/j/3m1eFuw0lv7aoMd0cXq3cyimj12MMtM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v3 08/11] RDMA: Add support to dump resource tracker in RAW format
Date:   Tue, 23 Jun 2020 14:30:40 +0300
Message-Id: <20200623113043.1228482-9-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623113043.1228482-1-leon@kernel.org>
References: <20200623113043.1228482-1-leon@kernel.org>
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
[{"ifindex":7,"ifname":"mlx5_1",
"data":[0,4,255,254,0,0,0,0,0,0,0,0,16,28,0,216,...]}]

Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/device.c |   3 +
 drivers/infiniband/core/nldev.c  | 182 ++++++++++++++++++++-----------
 include/rdma/ib_verbs.h          |   3 +
 include/uapi/rdma/rdma_netlink.h |   8 ++
 4 files changed, 134 insertions(+), 62 deletions(-)

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
index 394e307c342c..904e91061f9c 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
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
@@ -492,13 +483,6 @@ static int fill_res_qp_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	if (nla_put_u8(msg, RDMA_NLDEV_ATTR_RES_STATE, qp_attr.qp_state))
 		goto err;

-	if (!rdma_is_kernel_res(res) &&
-	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PDN, qp->pd->res.id))
-		goto err;
-
-	if (fill_res_name_pid(msg, res))
-		goto err;
-
 	if (dev->ops.fill_res_qp_entry)
 		return dev->ops.fill_res_qp_entry(msg, qp);
 	return 0;
@@ -506,6 +490,48 @@ static int fill_res_qp_entry(struct sk_buff *msg, bool has_cap_net_admin,
 err:	return -EMSGSIZE;
 }

+static int fill_res_qp_entry(struct sk_buff *msg, bool has_cap_net_admin,
+			     struct rdma_restrack_entry *res, uint32_t port)
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
+		return -EMSGSIZE;
+
+	if (!rdma_is_kernel_res(res) &&
+	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PDN, qp->pd->res.id))
+		return -EMSGSIZE;
+
+	ret = fill_res_name_pid(msg, res);
+	if (ret)
+		return -EMSGSIZE;
+
+	return fill_res_qp_entry_query(msg, res, dev, qp);
+}
+
+static int fill_res_qp_raw_entry(struct sk_buff *msg, bool has_cap_net_admin,
+				 struct rdma_restrack_entry *res, uint32_t port)
+{
+	struct ib_qp *qp = container_of(res, struct ib_qp, res);
+	struct ib_device *dev = qp->device;
+
+	if (port && port != qp->port)
+		return -EAGAIN;
+	if (!dev->ops.fill_res_qp_entry_raw)
+		return -EINVAL;
+	return dev->ops.fill_res_qp_entry_raw(msg, qp);
+}
+
 static int fill_res_cm_id_entry(struct sk_buff *msg, bool has_cap_net_admin,
 				struct rdma_restrack_entry *res, uint32_t port)
 {
@@ -565,34 +591,42 @@ static int fill_res_cq_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	struct ib_device *dev = cq->device;

 	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CQE, cq->cqe))
-		goto err;
+		return -EMSGSIZE;
 	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_RES_USECNT,
 			      atomic_read(&cq->usecnt), RDMA_NLDEV_ATTR_PAD))
-		goto err;
+		return -EMSGSIZE;

 	/* Poll context is only valid for kernel CQs */
 	if (rdma_is_kernel_res(res) &&
 	    nla_put_u8(msg, RDMA_NLDEV_ATTR_RES_POLL_CTX, cq->poll_ctx))
-		goto err;
+		return -EMSGSIZE;

 	if (nla_put_u8(msg, RDMA_NLDEV_ATTR_DEV_DIM, (cq->dim != NULL)))
-		goto err;
+		return -EMSGSIZE;

 	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CQN, res->id))
-		goto err;
+		return -EMSGSIZE;
 	if (!rdma_is_kernel_res(res) &&
 	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
 			cq->uobject->uevent.uobject.context->res.id))
-		goto err;
+		return -EMSGSIZE;

 	if (fill_res_name_pid(msg, res))
-		goto err;
+		return -EMSGSIZE;

-	if (dev->ops.fill_res_cq_entry)
-		return dev->ops.fill_res_cq_entry(msg, cq);
-	return 0;
+	return (dev->ops.fill_res_cq_entry) ?
+		dev->ops.fill_res_cq_entry(msg, cq) : 0;
+}

-err:	return -EMSGSIZE;
+static int fill_res_cq_raw_entry(struct sk_buff *msg, bool has_cap_net_admin,
+				 struct rdma_restrack_entry *res, uint32_t port)
+{
+	struct ib_cq *cq = container_of(res, struct ib_cq, res);
+	struct ib_device *dev = cq->device;
+
+	if (!dev->ops.fill_res_cq_entry_raw)
+		return -EINVAL;
+	return dev->ops.fill_res_cq_entry_raw(msg, cq);
 }

 static int fill_res_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
@@ -603,30 +637,39 @@ static int fill_res_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,

 	if (has_cap_net_admin) {
 		if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_RKEY, mr->rkey))
-			goto err;
+			return -EMSGSIZE;
 		if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_LKEY, mr->lkey))
-			goto err;
+			return -EMSGSIZE;
 	}

 	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_RES_MRLEN, mr->length,
 			      RDMA_NLDEV_ATTR_PAD))
-		goto err;
+		return -EMSGSIZE;

 	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_MRN, res->id))
-		goto err;
+		return -EMSGSIZE;

 	if (!rdma_is_kernel_res(res) &&
 	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PDN, mr->pd->res.id))
-		goto err;
+		return -EMSGSIZE;

 	if (fill_res_name_pid(msg, res))
-		goto err;
+		return -EMSGSIZE;

-	if (dev->ops.fill_res_mr_entry)
-		return dev->ops.fill_res_mr_entry(msg, mr);
-	return 0;
+	return (dev->ops.fill_res_mr_entry) ?
+		       dev->ops.fill_res_mr_entry(msg, mr) :
+		       0;
+}

-err:	return -EMSGSIZE;
+static int fill_res_mr_raw_entry(struct sk_buff *msg, bool has_cap_net_admin,
+				 struct rdma_restrack_entry *res, uint32_t port)
+{
+	struct ib_mr *mr = container_of(res, struct ib_mr, res);
+	struct ib_device *dev = mr->pd->device;
+
+	if (!dev->ops.fill_res_mr_entry_raw)
+		return -EINVAL;
+	return dev->ops.fill_res_mr_entry_raw(msg, mr);
 }

 static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
@@ -1149,7 +1192,6 @@ static int nldev_res_get_dumpit(struct sk_buff *skb,

 struct nldev_fill_res_entry {
 	enum rdma_nldev_attr nldev_attr;
-	enum rdma_nldev_command nldev_cmd;
 	u8 flags;
 	u32 entry;
 	u32 id;
@@ -1161,40 +1203,34 @@ enum nldev_res_flags {

 static const struct nldev_fill_res_entry fill_entries[RDMA_RESTRACK_MAX] = {
 	[RDMA_RESTRACK_QP] = {
-		.nldev_cmd = RDMA_NLDEV_CMD_RES_QP_GET,
 		.nldev_attr = RDMA_NLDEV_ATTR_RES_QP,
 		.entry = RDMA_NLDEV_ATTR_RES_QP_ENTRY,
 		.id = RDMA_NLDEV_ATTR_RES_LQPN,
 	},
 	[RDMA_RESTRACK_CM_ID] = {
-		.nldev_cmd = RDMA_NLDEV_CMD_RES_CM_ID_GET,
 		.nldev_attr = RDMA_NLDEV_ATTR_RES_CM_ID,
 		.entry = RDMA_NLDEV_ATTR_RES_CM_ID_ENTRY,
 		.id = RDMA_NLDEV_ATTR_RES_CM_IDN,
 	},
 	[RDMA_RESTRACK_CQ] = {
-		.nldev_cmd = RDMA_NLDEV_CMD_RES_CQ_GET,
 		.nldev_attr = RDMA_NLDEV_ATTR_RES_CQ,
 		.flags = NLDEV_PER_DEV,
 		.entry = RDMA_NLDEV_ATTR_RES_CQ_ENTRY,
 		.id = RDMA_NLDEV_ATTR_RES_CQN,
 	},
 	[RDMA_RESTRACK_MR] = {
-		.nldev_cmd = RDMA_NLDEV_CMD_RES_MR_GET,
 		.nldev_attr = RDMA_NLDEV_ATTR_RES_MR,
 		.flags = NLDEV_PER_DEV,
 		.entry = RDMA_NLDEV_ATTR_RES_MR_ENTRY,
 		.id = RDMA_NLDEV_ATTR_RES_MRN,
 	},
 	[RDMA_RESTRACK_PD] = {
-		.nldev_cmd = RDMA_NLDEV_CMD_RES_PD_GET,
 		.nldev_attr = RDMA_NLDEV_ATTR_RES_PD,
 		.flags = NLDEV_PER_DEV,
 		.entry = RDMA_NLDEV_ATTR_RES_PD_ENTRY,
 		.id = RDMA_NLDEV_ATTR_RES_PDN,
 	},
 	[RDMA_RESTRACK_COUNTER] = {
-		.nldev_cmd = RDMA_NLDEV_CMD_STAT_GET,
 		.nldev_attr = RDMA_NLDEV_ATTR_STAT_COUNTER,
 		.entry = RDMA_NLDEV_ATTR_STAT_COUNTER_ENTRY,
 		.id = RDMA_NLDEV_ATTR_STAT_COUNTER_ID,
@@ -1253,7 +1289,8 @@ static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}

 	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
-			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, fe->nldev_cmd),
+			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
+					 RDMA_NL_GET_OP(nlh->nlmsg_type)),
 			0, 0);

 	if (fill_nldev_handle(msg, device)) {
@@ -1264,6 +1301,8 @@ static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	has_cap_net_admin = netlink_capable(skb, CAP_NET_ADMIN);

 	ret = fill_func(msg, has_cap_net_admin, res, port);
+
+	rdma_restrack_put(res);
 	if (ret)
 		goto err_free;

@@ -1331,7 +1370,8 @@ static int res_get_common_dumpit(struct sk_buff *skb,
 	}

 	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
-			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, fe->nldev_cmd),
+			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
+					 RDMA_NL_GET_OP(cb->nlh->nlmsg_type)),
 			0, NLM_F_MULTI);

 	if (fill_nldev_handle(skb, device)) {
@@ -1413,26 +1453,29 @@ next:		idx++;
 	return ret;
 }

-#define RES_GET_FUNCS(name, type)					       \
-	static int nldev_res_get_##name##_dumpit(struct sk_buff *skb,	       \
+#define RES_GET_FUNCS(name, type)                                              \
+	static int nldev_res_get_##name##_dumpit(struct sk_buff *skb,          \
 						 struct netlink_callback *cb)  \
-	{								       \
-		return res_get_common_dumpit(skb, cb, type,		       \
-					     fill_res_##name##_entry);	       \
-	}								       \
-	static int nldev_res_get_##name##_doit(struct sk_buff *skb,	       \
-					       struct nlmsghdr *nlh,	       \
+	{                                                                      \
+		return res_get_common_dumpit(skb, cb, type,                    \
+					     fill_res_##name##_entry);         \
+	}                                                                      \
+	static int nldev_res_get_##name##_doit(struct sk_buff *skb,            \
+					       struct nlmsghdr *nlh,           \
 					       struct netlink_ext_ack *extack) \
-	{								       \
-		return res_get_common_doit(skb, nlh, extack, type,	       \
-					   fill_res_##name##_entry);	       \
+	{                                                                      \
+		return res_get_common_doit(skb, nlh, extack, type,             \
+					   fill_res_##name##_entry);           \
 	}

 RES_GET_FUNCS(qp, RDMA_RESTRACK_QP);
+RES_GET_FUNCS(qp_raw, RDMA_RESTRACK_QP);
 RES_GET_FUNCS(cm_id, RDMA_RESTRACK_CM_ID);
 RES_GET_FUNCS(cq, RDMA_RESTRACK_CQ);
+RES_GET_FUNCS(cq_raw, RDMA_RESTRACK_CQ);
 RES_GET_FUNCS(pd, RDMA_RESTRACK_PD);
 RES_GET_FUNCS(mr, RDMA_RESTRACK_MR);
+RES_GET_FUNCS(mr_raw, RDMA_RESTRACK_MR);
 RES_GET_FUNCS(counter, RDMA_RESTRACK_COUNTER);

 static LIST_HEAD(link_ops);
@@ -2117,6 +2160,21 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 		.doit = nldev_stat_del_doit,
 		.flags = RDMA_NL_ADMIN_PERM,
 	},
+	[RDMA_NLDEV_CMD_RES_QP_GET_RAW] = {
+		.doit = nldev_res_get_qp_raw_doit,
+		.dump = nldev_res_get_qp_raw_dumpit,
+		.flags = RDMA_NL_ADMIN_PERM,
+	},
+	[RDMA_NLDEV_CMD_RES_CQ_GET_RAW] = {
+		.doit = nldev_res_get_cq_raw_doit,
+		.dump = nldev_res_get_cq_raw_dumpit,
+		.flags = RDMA_NL_ADMIN_PERM,
+	},
+	[RDMA_NLDEV_CMD_RES_MR_GET_RAW] = {
+		.doit = nldev_res_get_mr_raw_doit,
+		.dump = nldev_res_get_mr_raw_dumpit,
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

