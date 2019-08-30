Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D07EA31FA
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2019 10:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfH3IQ2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Aug 2019 04:16:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfH3IQ2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Aug 2019 04:16:28 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50A712173E;
        Fri, 30 Aug 2019 08:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567152987;
        bh=2qn6JgCDn3jKhdfHqCPfCGW6v/MfpumXRcSeShevXrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WDNX97OqhMRvq2Af5LyzZgFXIG3soB3BdA3Wo1AFvOQNP84H2i36uL32RoVksKsU9
         k9Em0tEs2030sfaVFfCEZIXcbVA8+/2TFR1/wqaUuyFJf2uizRhsSxtgUzKwzbOQbm
         PfF1370dMAEEUgbKwmRwXrJqDJ7gZR1TFPv+/fVc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: [PATCH rdma-next v1 3/4] RDMA/nldev: Provide MR statistics
Date:   Fri, 30 Aug 2019 11:16:11 +0300
Message-Id: <20190830081612.2611-4-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190830081612.2611-1-leon@kernel.org>
References: <20190830081612.2611-1-leon@kernel.org>
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
prefetched_pages 122071

Signed-off-by: Erez Alfasi <ereza@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/device.c  |  1 +
 drivers/infiniband/core/nldev.c   | 54 +++++++++++++++++++++++++++++--
 drivers/infiniband/hw/mlx5/main.c | 16 +++++++++
 include/rdma/ib_verbs.h           |  9 ++++++
 4 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 99c4a55545cf..34a9e37c5c61 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2610,6 +2610,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, get_dma_mr);
 	SET_DEVICE_OP(dev_ops, get_hw_stats);
 	SET_DEVICE_OP(dev_ops, get_link_layer);
+	SET_DEVICE_OP(dev_ops, fill_odp_stats);
 	SET_DEVICE_OP(dev_ops, get_netdev);
 	SET_DEVICE_OP(dev_ops, get_port_immutable);
 	SET_DEVICE_OP(dev_ops, get_vector_affinity);
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 47f7fe5432db..47fee3d68cb9 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -37,6 +37,7 @@
 #include <net/netlink.h>
 #include <rdma/rdma_cm.h>
 #include <rdma/rdma_netlink.h>
+#include <rdma/ib_umem_odp.h>
 
 #include "core_priv.h"
 #include "cma_priv.h"
@@ -748,6 +749,49 @@ static int fill_stat_hwcounter_entry(struct sk_buff *msg,
 	return -EMSGSIZE;
 }
 
+static int fill_stat_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
+			      struct rdma_restrack_entry *res, uint32_t port)
+{
+	struct ib_mr *mr = container_of(res, struct ib_mr, res);
+	struct ib_device *dev = mr->pd->device;
+	struct ib_odp_counters odp_stats;
+	struct nlattr *table_attr;
+
+	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_MRN, res->id))
+		goto err;
+
+	if (!dev->ops.fill_odp_stats)
+		return 0;
+
+	if (!dev->ops.fill_odp_stats(mr, &odp_stats))
+		return 0;
+
+	table_attr = nla_nest_start(msg,
+				    RDMA_NLDEV_ATTR_STAT_HWCOUNTERS);
+
+	if (!table_attr)
+		return -EMSGSIZE;
+
+	if (fill_stat_hwcounter_entry(msg, "page_faults",
+				      (u64)atomic64_read(&odp_stats.faults)))
+		goto err_table;
+	if (fill_stat_hwcounter_entry(
+		    msg, "page_invalidations",
+		    (u64)atomic64_read(&odp_stats.invalidations)))
+		goto err_table;
+	if (fill_stat_hwcounter_entry(msg, "prefetched_pages",
+				      (u64)atomic64_read(&odp_stats.prefetched)))
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
 static int fill_stat_counter_hwcounters(struct sk_buff *msg,
 					struct rdma_counter *counter)
 {
@@ -2008,7 +2052,10 @@ static int nldev_stat_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
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
@@ -2032,7 +2079,10 @@ static int nldev_stat_get_dumpit(struct sk_buff *skb,
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
index 07aecba16019..05095fda03cc 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -67,6 +67,7 @@
 #include <rdma/uverbs_std_types.h>
 #include <rdma/mlx5_user_ioctl_verbs.h>
 #include <rdma/mlx5_user_ioctl_cmds.h>
+#include <rdma/ib_umem_odp.h>
 
 #define UVERBS_MODULE_NAME mlx5_ib
 #include <rdma/uverbs_named_ioctl.h>
@@ -121,6 +122,20 @@ struct mlx5_ib_dev *mlx5_ib_get_ibdev_from_mpi(struct mlx5_ib_multiport_info *mp
 	return dev;
 }
 
+static bool mlx5_ib_fill_odp_stats(struct ib_mr *ibmr,
+				   struct ib_odp_counters *cnt)
+{
+	struct mlx5_ib_mr *mr = to_mmr(ibmr);
+
+	if (!is_odp_mr(mr))
+		return false;
+
+	memcpy(cnt, &to_ib_umem_odp(mr->umem)->odp_stats,
+	       sizeof(struct ib_odp_counters));
+
+	return true;
+}
+
 static enum rdma_link_layer
 mlx5_port_type_cap_to_rdma_ll(int port_type_cap)
 {
@@ -6316,6 +6331,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.get_dev_fw_str = get_dev_fw_str,
 	.get_dma_mr = mlx5_ib_get_dma_mr,
 	.get_link_layer = mlx5_ib_port_link_layer,
+	.fill_odp_stats = mlx5_ib_fill_odp_stats,
 	.map_mr_sg = mlx5_ib_map_mr_sg,
 	.map_mr_sg_pi = mlx5_ib_map_mr_sg_pi,
 	.mmap = mlx5_ib_mmap,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index de5bc352f473..48d6513b3b59 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -72,6 +72,7 @@
 #define IB_FW_VERSION_NAME_MAX	ETHTOOL_FWVERS_LEN
 
 struct ib_umem_odp;
+struct ib_odp_counters;
 
 extern struct workqueue_struct *ib_wq;
 extern struct workqueue_struct *ib_comp_wq;
@@ -2566,6 +2567,14 @@ struct ib_device_ops {
 	 */
 	int (*counter_update_stats)(struct rdma_counter *counter);
 
+	/**
+	 * fill_odp_stats - Fill MR ODP stats into a given
+	 * ib_odp_counters struct.
+	 * Return value - true in case counters has been filled,
+	 * false otherwise (if its non-ODP registered MR for example).
+	 */
+	bool (*fill_odp_stats)(struct ib_mr *mr, struct ib_odp_counters *cnt);
+
 	DECLARE_RDMA_OBJ_SIZE(ib_ah);
 	DECLARE_RDMA_OBJ_SIZE(ib_cq);
 	DECLARE_RDMA_OBJ_SIZE(ib_pd);
-- 
2.20.1

