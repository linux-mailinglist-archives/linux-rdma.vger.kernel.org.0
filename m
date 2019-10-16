Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48443D8892
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2019 08:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbfJPGX3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Oct 2019 02:23:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbfJPGX3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Oct 2019 02:23:29 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10E4D20873;
        Wed, 16 Oct 2019 06:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571207008;
        bh=Zyf94/MImU4gOUPj4jnuwQs5rTIKEoLCzQs3Bqziry4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aL0QVYH4A6XrL/Ev6gyZIw9CWxxhcm9+ZWL4DQm1U8BvCo9xL5X7O75a8whGBwwPH
         /Kj6pdCALI5cxyyQxOcWvGDsqS1EFtzt4zFKRNfbMWw/L/bGX2RurMsQjIsTbZxF50
         91/woaiEQsQSuSFfxun07tbH+E5At1t27jl8KWis=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: [PATCH rdma-next v3 3/4] RDMA/mlx5: Return ODP type per MR
Date:   Wed, 16 Oct 2019 09:23:07 +0300
Message-Id: <20191016062308.11886-4-leon@kernel.org>
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

Provide an ODP explicit/implicit type as part
of 'rdma -dd resource show mr' dump.

For example:
~$: rdma -dd resource show mr
dev mlx5_0 mrn 1 rkey 0xa99a lkey 0xa99a mrlen 50000000
pdn 9 pid 7372 comm ibv_rc_pingpong drv_odp explicit

For non-ODP MRs, we won't print "drv_odp ..." at all.

Signed-off-by: Erez Alfasi <ereza@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/nldev.c       | 13 ++++++++
 drivers/infiniband/hw/mlx5/Makefile   |  2 +-
 drivers/infiniband/hw/mlx5/main.c     |  1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h  |  3 ++
 drivers/infiniband/hw/mlx5/odp.c      |  2 ++
 drivers/infiniband/hw/mlx5/restrack.c | 48 +++++++++++++++++++++++++++
 include/rdma/restrack.h               |  3 ++
 7 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 drivers/infiniband/hw/mlx5/restrack.c

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 01851467914a..a38e7f5166fc 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -183,6 +183,19 @@ static int _rdma_nl_put_driver_u64(struct sk_buff *msg, const char *name,
 	return 0;
 }

+int rdma_nl_put_driver_string(struct sk_buff *msg, const char *name,
+			      const char *str)
+{
+	if (put_driver_name_print_type(msg, name,
+				       RDMA_NLDEV_PRINT_TYPE_UNSPEC))
+		return -EMSGSIZE;
+	if (nla_put_string(msg, RDMA_NLDEV_ATTR_DRIVER_STRING, str))
+		return -EMSGSIZE;
+
+	return 0;
+}
+EXPORT_SYMBOL(rdma_nl_put_driver_string);
+
 int rdma_nl_put_driver_u32(struct sk_buff *msg, const char *name, u32 value)
 {
 	return _rdma_nl_put_driver_u32(msg, name, RDMA_NLDEV_PRINT_TYPE_UNSPEC,
diff --git a/drivers/infiniband/hw/mlx5/Makefile b/drivers/infiniband/hw/mlx5/Makefile
index 9924be8384d8..d0a043ccbe58 100644
--- a/drivers/infiniband/hw/mlx5/Makefile
+++ b/drivers/infiniband/hw/mlx5/Makefile
@@ -3,7 +3,7 @@ obj-$(CONFIG_MLX5_INFINIBAND)	+= mlx5_ib.o

 mlx5_ib-y :=	main.o cq.o doorbell.o qp.o mem.o srq_cmd.o \
 		srq.o mr.o ah.o mad.o gsi.o ib_virt.o cmd.o \
-		cong.o
+		cong.o restrack.o
 mlx5_ib-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += odp.o
 mlx5_ib-$(CONFIG_MLX5_ESWITCH) += ib_rep.o
 mlx5_ib-$(CONFIG_INFINIBAND_USER_ACCESS) += devx.o
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index b95c2b05f682..3c3c19129cdd 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6269,6 +6269,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.disassociate_ucontext = mlx5_ib_disassociate_ucontext,
 	.drain_rq = mlx5_ib_drain_rq,
 	.drain_sq = mlx5_ib_drain_sq,
+	.fill_res_entry = mlx5_ib_fill_res_entry,
 	.get_dev_fw_str = get_dev_fw_str,
 	.get_dma_mr = mlx5_ib_get_dma_mr,
 	.get_link_layer = mlx5_ib_port_link_layer,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 5aae05ebf64b..a0ca1ef16e4e 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -626,6 +626,7 @@ struct mlx5_ib_mr {
 	struct mlx5_async_work  cb_work;
 	atomic_t		num_pending_prefetch;
 	struct ib_odp_counters	odp_stats;
+	bool			is_odp_implicit;
 };

 static inline bool is_odp_mr(struct mlx5_ib_mr *mr)
@@ -1339,6 +1340,8 @@ struct mlx5_core_dev *mlx5_ib_get_native_port_mdev(struct mlx5_ib_dev *dev,
 						   u8 *native_port_num);
 void mlx5_ib_put_native_port_mdev(struct mlx5_ib_dev *dev,
 				  u8 port_num);
+int mlx5_ib_fill_res_entry(struct sk_buff *msg,
+			   struct rdma_restrack_entry *res);

 #if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user);
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 3601c6ad96f9..2ab6e44aeaae 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -543,6 +543,8 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 	atomic_set(&imr->num_leaf_free, 0);
 	atomic_set(&imr->num_pending_prefetch, 0);

+	imr->is_odp_implicit = true;
+
 	return imr;
 }

diff --git a/drivers/infiniband/hw/mlx5/restrack.c b/drivers/infiniband/hw/mlx5/restrack.c
new file mode 100644
index 000000000000..065049f52b83
--- /dev/null
+++ b/drivers/infiniband/hw/mlx5/restrack.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2019, Mellanox Technologies inc.  All rights reserved.
+ */
+
+#include <uapi/rdma/rdma_netlink.h>
+#include <rdma/ib_umem_odp.h>
+#include <rdma/restrack.h>
+#include "mlx5_ib.h"
+
+static int fill_res_mr_entry(struct sk_buff *msg,
+			     struct rdma_restrack_entry *res)
+{
+	struct ib_mr *ibmr = container_of(res, struct ib_mr, res);
+	struct mlx5_ib_mr *mr = to_mmr(ibmr);
+	struct nlattr *table_attr;
+
+	if (!(mr->access_flags & IB_ACCESS_ON_DEMAND))
+		return 0;
+
+	table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_DRIVER);
+	if (!table_attr)
+		goto err;
+
+	if (mr->is_odp_implicit) {
+		if (rdma_nl_put_driver_string(msg, "odp", "implicit"))
+			goto err;
+	} else {
+		if (rdma_nl_put_driver_string(msg, "odp", "explicit"))
+			goto err;
+	}
+
+	nla_nest_end(msg, table_attr);
+	return 0;
+
+err:
+	nla_nest_cancel(msg, table_attr);
+	return -EMSGSIZE;
+}
+
+int mlx5_ib_fill_res_entry(struct sk_buff *msg,
+			   struct rdma_restrack_entry *res)
+{
+	if (res->type == RDMA_RESTRACK_MR)
+		return fill_res_mr_entry(msg, res);
+
+	return 0;
+}
diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
index 83df1ec6664e..fe9b3c507a9c 100644
--- a/include/rdma/restrack.h
+++ b/include/rdma/restrack.h
@@ -156,6 +156,9 @@ int rdma_nl_put_driver_u32_hex(struct sk_buff *msg, const char *name,
 int rdma_nl_put_driver_u64(struct sk_buff *msg, const char *name, u64 value);
 int rdma_nl_put_driver_u64_hex(struct sk_buff *msg, const char *name,
 			       u64 value);
+int rdma_nl_put_driver_string(struct sk_buff *msg, const char *name,
+			      const char *str);
+
 struct rdma_restrack_entry *rdma_restrack_get_byid(struct ib_device *dev,
 						   enum rdma_restrack_type type,
 						   u32 id);
--
2.20.1

