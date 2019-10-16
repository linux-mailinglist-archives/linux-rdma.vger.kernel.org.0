Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 286F4D8893
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2019 08:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbfJPGXf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Oct 2019 02:23:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbfJPGXf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Oct 2019 02:23:35 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 023FF20873;
        Wed, 16 Oct 2019 06:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571207014;
        bh=wExeg08dnC9hjHSrh+fnDshufIpwyWOA6a0dutrid7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0RExWcdE4NXY72loIIg2TbU6cvBQRVFFBhUam2Sy6C2/uIjkDAbTJ9aPDufO+LXVM
         NPDJRHEuB84Nc2lZ4EE3Eirz7S9ZZ9a2OLoqT/GTeGsfAzPOFn1TWUyZkIIMRQQptP
         cvEMPvAR6l2DzwL1vVzTj68MzUVgarajDoTUmCHg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: [PATCH rdma-next v3 4/4] RDMA/nldev: Provide MR statistics
Date:   Wed, 16 Oct 2019 09:23:08 +0300
Message-Id: <20191016062308.11886-5-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191016062308.11886-1-leon@kernel.org>
References: <20191016062308.11886-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Erez Alfasi <ereza@mellanox.com>

Add RDMA nldev netlink interface for dumping MR
statistics information.

Output example:
ereza@dev~$: ./ibv_rc_pingpong -o -P -s 500000000
  local address:  LID 0x0001, QPN 0x00008a, PSN 0xf81096, GID ::

ereza@dev~$: rdma stat show mr
dev mlx5_0 mrn 2 page_faults 122071 page_invalidations 0

Signed-off-by: Erez Alfasi <ereza@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/device.c      |  1 +
 drivers/infiniband/core/nldev.c       | 41 +++++++++++++++++++++++---
 drivers/infiniband/hw/mlx5/main.c     |  2 ++
 drivers/infiniband/hw/mlx5/mlx5_ib.h  |  2 ++
 drivers/infiniband/hw/mlx5/restrack.c | 42 +++++++++++++++++++++++++++
 include/rdma/ib_verbs.h               |  7 +++++
 include/rdma/restrack.h               |  3 ++
 7 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index a667636f74bf..2e53aa25f0c7 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2606,6 +2606,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, drain_sq);
 	SET_DEVICE_OP(dev_ops, enable_driver);
 	SET_DEVICE_OP(dev_ops, fill_res_entry);
+	SET_DEVICE_OP(dev_ops, fill_stat_entry);
 	SET_DEVICE_OP(dev_ops, get_dev_fw_str);
 	SET_DEVICE_OP(dev_ops, get_dma_mr);
 	SET_DEVICE_OP(dev_ops, get_hw_stats);
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index a38e7f5166fc..5e056d5e5be3 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -453,6 +453,14 @@ static bool fill_res_entry(struct ib_device *dev, struct sk_buff *msg,
 	return dev->ops.fill_res_entry(msg, res);
 }

+static bool fill_stat_entry(struct ib_device *dev, struct sk_buff *msg,
+			    struct rdma_restrack_entry *res)
+{
+	if (!dev->ops.fill_stat_entry)
+		return false;
+	return dev->ops.fill_stat_entry(msg, res);
+}
+
 static int fill_res_qp_entry(struct sk_buff *msg, bool has_cap_net_admin,
 			     struct rdma_restrack_entry *res, uint32_t port)
 {
@@ -750,8 +758,8 @@ static int fill_stat_counter_qps(struct sk_buff *msg,
 	return ret;
 }

-static int fill_stat_hwcounter_entry(struct sk_buff *msg,
-				     const char *name, u64 value)
+int fill_stat_hwcounter_entry(struct sk_buff *msg,
+			      const char *name, u64 value)
 {
 	struct nlattr *entry_attr;

@@ -773,6 +781,25 @@ static int fill_stat_hwcounter_entry(struct sk_buff *msg,
 	nla_nest_cancel(msg, entry_attr);
 	return -EMSGSIZE;
 }
+EXPORT_SYMBOL(fill_stat_hwcounter_entry);
+
+static int fill_stat_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
+			      struct rdma_restrack_entry *res, uint32_t port)
+{
+	struct ib_mr *mr = container_of(res, struct ib_mr, res);
+	struct ib_device *dev = mr->pd->device;
+
+	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_MRN, res->id))
+		goto err;
+
+	if (fill_stat_entry(dev, msg, res))
+		goto err;
+
+	return 0;
+
+err:
+	return -EMSGSIZE;
+}

 static int fill_stat_counter_hwcounters(struct sk_buff *msg,
 					struct rdma_counter *counter)
@@ -2009,7 +2036,10 @@ static int nldev_stat_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	case RDMA_NLDEV_ATTR_RES_QP:
 		ret = stat_get_doit_qp(skb, nlh, extack, tb);
 		break;
-
+	case RDMA_NLDEV_ATTR_RES_MR:
+		ret = res_get_common_doit(skb, nlh, extack, RDMA_RESTRACK_MR,
+					  fill_stat_mr_entry);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -2033,7 +2063,10 @@ static int nldev_stat_get_dumpit(struct sk_buff *skb,
 	case RDMA_NLDEV_ATTR_RES_QP:
 		ret = nldev_res_get_counter_dumpit(skb, cb);
 		break;
-
+	case RDMA_NLDEV_ATTR_RES_MR:
+		ret = res_get_common_dumpit(skb, cb, RDMA_RESTRACK_MR,
+					    fill_stat_mr_entry);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 3c3c19129cdd..fa23c8e7043b 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -67,6 +67,7 @@
 #include <rdma/uverbs_std_types.h>
 #include <rdma/mlx5_user_ioctl_verbs.h>
 #include <rdma/mlx5_user_ioctl_cmds.h>
+#include <rdma/ib_umem_odp.h>

 #define UVERBS_MODULE_NAME mlx5_ib
 #include <rdma/uverbs_named_ioctl.h>
@@ -6270,6 +6271,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.drain_rq = mlx5_ib_drain_rq,
 	.drain_sq = mlx5_ib_drain_sq,
 	.fill_res_entry = mlx5_ib_fill_res_entry,
+	.fill_stat_entry = mlx5_ib_fill_stat_entry,
 	.get_dev_fw_str = get_dev_fw_str,
 	.get_dma_mr = mlx5_ib_get_dma_mr,
 	.get_link_layer = mlx5_ib_port_link_layer,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index a0ca1ef16e4e..e9bdb48cf1d3 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1342,6 +1342,8 @@ void mlx5_ib_put_native_port_mdev(struct mlx5_ib_dev *dev,
 				  u8 port_num);
 int mlx5_ib_fill_res_entry(struct sk_buff *msg,
 			   struct rdma_restrack_entry *res);
+int mlx5_ib_fill_stat_entry(struct sk_buff *msg,
+			    struct rdma_restrack_entry *res);

 #if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user);
diff --git a/drivers/infiniband/hw/mlx5/restrack.c b/drivers/infiniband/hw/mlx5/restrack.c
index 065049f52b83..2b1f916570f9 100644
--- a/drivers/infiniband/hw/mlx5/restrack.c
+++ b/drivers/infiniband/hw/mlx5/restrack.c
@@ -8,6 +8,39 @@
 #include <rdma/restrack.h>
 #include "mlx5_ib.h"

+static int fill_stat_mr_entry(struct sk_buff *msg,
+			      struct rdma_restrack_entry *res)
+{
+	struct ib_mr *ibmr = container_of(res, struct ib_mr, res);
+	struct mlx5_ib_mr *mr = to_mmr(ibmr);
+	struct nlattr *table_attr;
+
+	if (!(mr->access_flags & IB_ACCESS_ON_DEMAND))
+		return 0;
+
+	table_attr = nla_nest_start(msg,
+				    RDMA_NLDEV_ATTR_STAT_HWCOUNTERS);
+
+	if (!table_attr)
+		goto err;
+
+	if (fill_stat_hwcounter_entry(msg, "page_faults",
+				      atomic64_read(&mr->odp_stats.faults)))
+		goto err_table;
+	if (fill_stat_hwcounter_entry(
+		    msg, "page_invalidations",
+		    atomic64_read(&mr->odp_stats.invalidations)))
+		goto err_table;
+
+	nla_nest_end(msg, table_attr);
+	return 0;
+
+err_table:
+	nla_nest_cancel(msg, table_attr);
+err:
+	return -EMSGSIZE;
+}
+
 static int fill_res_mr_entry(struct sk_buff *msg,
 			     struct rdma_restrack_entry *res)
 {
@@ -46,3 +79,12 @@ int mlx5_ib_fill_res_entry(struct sk_buff *msg,

 	return 0;
 }
+
+int mlx5_ib_fill_stat_entry(struct sk_buff *msg,
+			    struct rdma_restrack_entry *res)
+{
+	if (res->type == RDMA_RESTRACK_MR)
+		return fill_stat_mr_entry(msg, res);
+
+	return 0;
+}
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 26600dfb345d..aa8306f9ad83 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2568,6 +2568,13 @@ struct ib_device_ops {
 	 */
 	int (*counter_update_stats)(struct rdma_counter *counter);

+	/**
+	 * Allows rdma drivers to add their own restrack attributes
+	 * dumped via 'rdma stat' iproute2 command.
+	 */
+	int (*fill_stat_entry)(struct sk_buff *msg,
+			       struct rdma_restrack_entry *entry);
+
 	DECLARE_RDMA_OBJ_SIZE(ib_ah);
 	DECLARE_RDMA_OBJ_SIZE(ib_cq);
 	DECLARE_RDMA_OBJ_SIZE(ib_pd);
diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
index fe9b3c507a9c..90fdbe8a24a6 100644
--- a/include/rdma/restrack.h
+++ b/include/rdma/restrack.h
@@ -162,4 +162,7 @@ int rdma_nl_put_driver_string(struct sk_buff *msg, const char *name,
 struct rdma_restrack_entry *rdma_restrack_get_byid(struct ib_device *dev,
 						   enum rdma_restrack_type type,
 						   u32 id);
+int fill_stat_hwcounter_entry(struct sk_buff *msg,
+			      const char *name, u64 value);
+
 #endif /* _RDMA_RESTRACK_H_ */
--
2.20.1

