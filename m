Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6DE1D0D3B
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 11:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387644AbgEMJvY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 05:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733121AbgEMJvW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 May 2020 05:51:22 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8CF520575;
        Wed, 13 May 2020 09:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363480;
        bh=6SirQoTHT0Ecs+YVuzDvuyCcwZDigBxpy6tHfp+E59o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UThEeHfVCVATGu8g5DcOhbTVqYoF53tN2QJ9dlQ+OHNLk6xCDjBh01KIK3ry2EjAG
         tWvhye/8qcipfmKLQ3P5LdNfs5IhMONCwjSoW1bl5HwCceF5/pZjDmF+RD65gRUi2p
         EARgXRSb7TBsPdd+vRkuoDMjNwkDuyzmTA14EFl4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, Lijun Ou <oulijun@huawei.com>,
        linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>
Subject: [PATCH rdma-next 11/14] RDMA: Add support to dump resource tracker in RAW format
Date:   Wed, 13 May 2020 12:50:31 +0300
Message-Id: <20200513095034.208385-12-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513095034.208385-1-leon@kernel.org>
References: <20200513095034.208385-1-leon@kernel.org>
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
 drivers/infiniband/core/nldev.c               | 84 ++++++++++++-------
 drivers/infiniband/core/restrack.c            | 18 ++--
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |  6 +-
 drivers/infiniband/hw/cxgb4/restrack.c        | 15 +++-
 drivers/infiniband/hw/hns/hns_roce_device.h   |  2 +-
 drivers/infiniband/hw/hns/hns_roce_restrack.c |  5 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  3 +-
 drivers/infiniband/hw/mlx5/restrack.c         |  5 +-
 include/rdma/ib_verbs.h                       |  9 +-
 include/uapi/rdma/rdma_netlink.h              |  2 +
 10 files changed, 102 insertions(+), 47 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 02a1f50b23be..7437b5c22479 100644
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
@@ -492,20 +483,48 @@ static int fill_res_qp_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	if (nla_put_u8(msg, RDMA_NLDEV_ATTR_RES_STATE, qp_attr.qp_state))
 		goto err;
 
+	return dev->ops.fill_res_qp_entry(msg, qp, false);
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
 
-	return dev->ops.fill_res_qp_entry(msg, qp);
+	if (raw)
+		return dev->ops.fill_res_qp_entry(msg, qp, raw);
+	return fill_res_qp_entry_query(msg, res, dev, qp);
 
 err:	return -EMSGSIZE;
 }
 
 static int fill_res_cm_id_entry(struct sk_buff *msg, bool has_cap_net_admin,
-				struct rdma_restrack_entry *res, uint32_t port)
+				struct rdma_restrack_entry *res, uint32_t port,
+				bool raw)
 {
 	struct rdma_id_private *id_priv =
 				container_of(res, struct rdma_id_private, res);
@@ -555,7 +574,8 @@ err: return -EMSGSIZE;
 }
 
 static int fill_res_cq_entry(struct sk_buff *msg, bool has_cap_net_admin,
-			     struct rdma_restrack_entry *res, uint32_t port)
+			     struct rdma_restrack_entry *res, uint32_t port,
+			     bool raw)
 {
 	struct ib_cq *cq = container_of(res, struct ib_cq, res);
 	struct ib_device *dev = cq->device;
@@ -584,13 +604,14 @@ static int fill_res_cq_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	if (fill_res_name_pid(msg, res))
 		goto err;
 
-	return dev->ops.fill_res_cq_entry(msg, cq);
+	return dev->ops.fill_res_cq_entry(msg, cq, raw);
 
 err:	return -EMSGSIZE;
 }
 
 static int fill_res_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
-			     struct rdma_restrack_entry *res, uint32_t port)
+			     struct rdma_restrack_entry *res, uint32_t port,
+			     bool raw)
 {
 	struct ib_mr *mr = container_of(res, struct ib_mr, res);
 	struct ib_device *dev = mr->pd->device;
@@ -616,13 +637,14 @@ static int fill_res_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	if (fill_res_name_pid(msg, res))
 		goto err;
 
-	return dev->ops.fill_res_mr_entry(msg, mr);
+	return dev->ops.fill_res_mr_entry(msg, mr, raw);
 
 err:	return -EMSGSIZE;
 }
 
 static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
-			     struct rdma_restrack_entry *res, uint32_t port)
+			     struct rdma_restrack_entry *res, uint32_t port,
+			     bool raw)
 {
 	struct ib_pd *pd = container_of(res, struct ib_pd, res);
 
@@ -750,7 +772,8 @@ int rdma_nl_stat_hwcounter_entry(struct sk_buff *msg, const char *name,
 EXPORT_SYMBOL(rdma_nl_stat_hwcounter_entry);
 
 static int fill_stat_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
-			      struct rdma_restrack_entry *res, uint32_t port)
+			      struct rdma_restrack_entry *res, uint32_t port,
+			      bool raw)
 {
 	struct ib_mr *mr = container_of(res, struct ib_mr, res);
 	struct ib_device *dev = mr->pd->device;
@@ -786,7 +809,7 @@ static int fill_stat_counter_hwcounters(struct sk_buff *msg,
 
 static int fill_res_counter_entry(struct sk_buff *msg, bool has_cap_net_admin,
 				  struct rdma_restrack_entry *res,
-				  uint32_t port)
+				  uint32_t port, bool raw)
 {
 	struct rdma_counter *counter =
 		container_of(res, struct rdma_counter, res);
@@ -1200,6 +1223,7 @@ static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	u32 index, id, port = 0;
 	bool has_cap_net_admin;
 	struct sk_buff *msg;
+	bool raw = false;
 	int ret;
 
 	ret = nlmsg_parse_deprecated(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
@@ -1207,6 +1231,11 @@ static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (ret || !tb[RDMA_NLDEV_ATTR_DEV_INDEX] || !fe->id || !tb[fe->id])
 		return -EINVAL;
 
+	if (tb[RDMA_NLDEV_ATTR_RES_RAW])
+		raw = nla_get_u8(tb[RDMA_NLDEV_ATTR_RES_RAW]);
+	if (raw && res_type == RDMA_RESTRACK_CM_ID)
+		return -EOPNOTSUPP;
+
 	index = nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
 	device = ib_device_get_by_index(sock_net(skb->sk), index);
 	if (!device)
@@ -1249,8 +1278,7 @@ static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	has_cap_net_admin = netlink_capable(skb, CAP_NET_ADMIN);
-
-	ret = fill_func(msg, has_cap_net_admin, res, port);
+	ret = fill_func(msg, has_cap_net_admin, res, port, raw);
 	if (ret)
 		goto err_free;
 
@@ -1356,7 +1384,7 @@ static int res_get_common_dumpit(struct sk_buff *skb,
 			goto msg_full;
 		}
 
-		ret = fill_func(skb, has_cap_net_admin, res, port);
+		ret = fill_func(skb, has_cap_net_admin, res, port, false);
 
 		rdma_restrack_put(res);
 
diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index bad96ab58fc9..dfebe992fab6 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -15,17 +15,23 @@
 #include "restrack.h"
 
 #define FILL_DUMMY(type) \
-	static int fill_res_##type(struct sk_buff *msg,		\
-				   struct ib_##type *res)	\
-	{							\
-		return 0;					\
-	}
+	static int fill_res_##type(struct sk_buff *msg,			\
+				   struct ib_##type *res, bool raw)	\
+	{								\
+		return 0;						\
+	}								\
+									\
 
 static int fill_res_cm_id(struct sk_buff *msg, struct rdma_cm_id *id)
 {
 	return 0;
 }
 
+static int fill_stat_mr(struct sk_buff *msg, struct ib_mr *ibmr)
+{
+	return 0;
+}
+
 FILL_DUMMY(mr);
 FILL_DUMMY(cq);
 FILL_DUMMY(qp);
@@ -35,7 +41,7 @@ static const struct ib_device_ops restrack_dummy_ops = {
 	.fill_res_cq_entry = fill_res_cq,
 	.fill_res_mr_entry = fill_res_mr,
 	.fill_res_qp_entry = fill_res_qp,
-	.fill_stat_mr_entry = fill_res_mr,
+	.fill_stat_mr_entry = fill_stat_mr,
 };
 
 /**
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index 27da0705c88a..858c9ae9a5e3 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -1053,9 +1053,9 @@ int c4iw_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 		       const struct ib_recv_wr **bad_wr);
 struct c4iw_wr_wait *c4iw_alloc_wr_wait(gfp_t gfp);
 
-int c4iw_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ibmr);
-int c4iw_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ibcq);
-int c4iw_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ibqp);
+int c4iw_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ibmr, bool raw);
+int c4iw_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ibcq, bool raw);
+int c4iw_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ibqp, bool raw);
 int c4iw_fill_res_cm_id_entry(struct sk_buff *msg, struct rdma_cm_id *cm_id);
 
 #endif
diff --git a/drivers/infiniband/hw/cxgb4/restrack.c b/drivers/infiniband/hw/cxgb4/restrack.c
index b32e6516d65f..5ca11daae9d4 100644
--- a/drivers/infiniband/hw/cxgb4/restrack.c
+++ b/drivers/infiniband/hw/cxgb4/restrack.c
@@ -134,7 +134,7 @@ static int fill_swsqes(struct sk_buff *msg, struct t4_sq *sq,
 	return -EMSGSIZE;
 }
 
-int c4iw_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ibqp)
+int c4iw_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ibqp, bool raw)
 {
 	struct t4_swsqe *fsp = NULL, *lsp = NULL;
 	struct c4iw_qp *qhp = to_c4iw_qp(ibqp);
@@ -143,6 +143,9 @@ int c4iw_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ibqp)
 	struct nlattr *table_attr;
 	struct t4_wq wq;
 
+	if (raw)
+		return -EOPNOTSUPP;
+
 	/* User qp state is not available, so don't dump user qps */
 	if (qhp->ucontext)
 		return 0;
@@ -369,7 +372,7 @@ static int fill_swcqes(struct sk_buff *msg, struct t4_cq *cq,
 	return -EMSGSIZE;
 }
 
-int c4iw_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ibcq)
+int c4iw_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ibcq, bool raw)
 {
 	struct c4iw_cq *chp = to_c4iw_cq(ibcq);
 	struct nlattr *table_attr;
@@ -378,6 +381,9 @@ int c4iw_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ibcq)
 	struct t4_cq cq;
 	u16 idx;
 
+	if (raw)
+		return -EOPNOTSUPP;
+
 	/* User cq state is not available, so don't dump user cqs */
 	if (ibcq->uobject)
 		return 0;
@@ -428,7 +434,7 @@ int c4iw_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ibcq)
 	return -EMSGSIZE;
 }
 
-int c4iw_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ibmr)
+int c4iw_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ibmr, bool raw)
 {
 	struct c4iw_mr *mhp = to_c4iw_mr(ibmr);
 	struct c4iw_dev *dev = mhp->rhp;
@@ -437,6 +443,9 @@ int c4iw_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ibmr)
 	struct fw_ri_tpte tpte;
 	int ret;
 
+	if (raw)
+		return -EOPNOTSUPP;
+
 	if (!stag)
 		return 0;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 556449a143ed..08375b5dfb27 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1258,5 +1258,5 @@ int hns_roce_init(struct hns_roce_dev *hr_dev);
 void hns_roce_exit(struct hns_roce_dev *hr_dev);
 
 int hns_roce_fill_res_cq_entry(struct sk_buff *msg,
-			       struct ib_cq *ib_cq);
+			       struct ib_cq *ib_cq, bool raw);
 #endif /* _HNS_ROCE_DEVICE_H */
diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index 259444c0a630..c3e95ef8decd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -77,7 +77,7 @@ static int hns_roce_fill_cq(struct sk_buff *msg,
 }
 
 int hns_roce_fill_res_cq_entry(struct sk_buff *msg,
-			       struct ib_cq *ib_cq)
+			       struct ib_cq *ib_cq, bool raw)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ib_cq->device);
 	struct hns_roce_cq *hr_cq = to_hr_cq(ib_cq);
@@ -85,6 +85,9 @@ int hns_roce_fill_res_cq_entry(struct sk_buff *msg,
 	struct nlattr *table_attr;
 	int ret;
 
+	if (raw)
+		return -EOPNOTSUPP;
+
 	if (!hr_dev->dfx->query_cqc_info)
 		return -EINVAL;
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index d2b36f4ce508..270a9f1c92c4 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1383,7 +1383,8 @@ struct mlx5_core_dev *mlx5_ib_get_native_port_mdev(struct mlx5_ib_dev *dev,
 						   u8 *native_port_num);
 void mlx5_ib_put_native_port_mdev(struct mlx5_ib_dev *dev,
 				  u8 port_num);
-int mlx5_ib_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr);
+int mlx5_ib_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr,
+			      bool raw);
 int mlx5_ib_fill_stat_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr);
 
 extern const struct uapi_definition mlx5_ib_devx_defs[];
diff --git a/drivers/infiniband/hw/mlx5/restrack.c b/drivers/infiniband/hw/mlx5/restrack.c
index 598a09796d09..32b1bdf5768b 100644
--- a/drivers/infiniband/hw/mlx5/restrack.c
+++ b/drivers/infiniband/hw/mlx5/restrack.c
@@ -41,11 +41,14 @@ int mlx5_ib_fill_stat_mr_entry(struct sk_buff *msg,
 }
 
 int mlx5_ib_fill_res_mr_entry(struct sk_buff *msg,
-			      struct ib_mr *ibmr)
+			      struct ib_mr *ibmr, bool raw)
 {
 	struct mlx5_ib_mr *mr = to_mmr(ibmr);
 	struct nlattr *table_attr;
 
+	if (raw)
+		return -EOPNOTSUPP;
+
 	if (!(mr->access_flags & IB_ACCESS_ON_DEMAND))
 		return 0;
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 4b7812340167..4bf222e8195f 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2568,9 +2568,12 @@ struct ib_device_ops {
 	/**
 	 * Allows rdma drivers to add their own restrack attributes.
 	 */
-	int (*fill_res_mr_entry)(struct sk_buff *msg, struct ib_mr *ibmr);
-	int (*fill_res_cq_entry)(struct sk_buff *msg, struct ib_cq *ibcq);
-	int (*fill_res_qp_entry)(struct sk_buff *msg, struct ib_qp *ibqp);
+	int (*fill_res_mr_entry)(struct sk_buff *msg, struct ib_mr *ibmr,
+				 bool raw);
+	int (*fill_res_cq_entry)(struct sk_buff *msg, struct ib_cq *ibcq,
+				 bool raw);
+	int (*fill_res_qp_entry)(struct sk_buff *msg, struct ib_qp *ibqp,
+				 bool raw);
 	int (*fill_res_cm_id_entry)(struct sk_buff *msg, struct rdma_cm_id *id);
 
 	/* Device lifecycle callbacks */
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 8e277783fa96..122658d1fae4 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -525,6 +525,8 @@ enum rdma_nldev_attr {
 	 */
 	RDMA_NLDEV_ATTR_DEV_DIM,                /* u8 */
 
+	RDMA_NLDEV_ATTR_RES_RAW,	/* binary */
+
 	/*
 	 * Always the end
 	 */
-- 
2.26.2

