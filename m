Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77BCAA31FB
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2019 10:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfH3IQb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Aug 2019 04:16:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfH3IQb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Aug 2019 04:16:31 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C91EC21726;
        Fri, 30 Aug 2019 08:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567152990;
        bh=0vpd9ZOrBdCtR8xSNAKN5Me/MRlHvYlMx8HhPhQOeNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SCe2AEY09+HCUHx0XsUb70r+HEHNlPV3+BSRPc1AWI2Qy4nl4LunGk02n4YpcUL8T
         DA8j464oILeD3MrAZBpUl9KxqAAb21cz6NTAWFPKn+kFoCUiml74voIHg0n5dH0f5b
         V1twQysP73BYq2s82qmtHPaKOaDu2xZbpmUFOu0U=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: [PATCH rdma-next v1 4/4] RDMA/mlx5: Return ODP type per MR
Date:   Fri, 30 Aug 2019 11:16:12 +0300
Message-Id: <20190830081612.2611-5-leon@kernel.org>
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
 drivers/infiniband/hw/mlx5/mlx5_ib.h  |  2 ++
 drivers/infiniband/hw/mlx5/restrack.c | 48 +++++++++++++++++++++++++++
 include/rdma/restrack.h               |  3 ++
 6 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 drivers/infiniband/hw/mlx5/restrack.c

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 47fee3d68cb9..82ed8e339d8f 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -181,6 +181,19 @@ static int _rdma_nl_put_driver_u64(struct sk_buff *msg, const char *name,
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
index 05095fda03cc..084145757549 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6328,6 +6328,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.disassociate_ucontext = mlx5_ib_disassociate_ucontext,
 	.drain_rq = mlx5_ib_drain_rq,
 	.drain_sq = mlx5_ib_drain_sq,
+	.fill_res_entry = mlx5_ib_fill_res_entry,
 	.get_dev_fw_str = get_dev_fw_str,
 	.get_dma_mr = mlx5_ib_get_dma_mr,
 	.get_link_layer = mlx5_ib_port_link_layer,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 6abfbf3a69b7..c67ede31d7dc 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1334,6 +1334,8 @@ struct mlx5_core_dev *mlx5_ib_get_native_port_mdev(struct mlx5_ib_dev *dev,
 						   u8 *native_port_num);
 void mlx5_ib_put_native_port_mdev(struct mlx5_ib_dev *dev,
 				  u8 port_num);
+int mlx5_ib_fill_res_entry(struct sk_buff *msg,
+			   struct rdma_restrack_entry *res);
 
 #if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user);
diff --git a/drivers/infiniband/hw/mlx5/restrack.c b/drivers/infiniband/hw/mlx5/restrack.c
new file mode 100644
index 000000000000..427011d20250
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
+	if (!is_odp_mr(mr))
+		return 0;
+
+	table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_DRIVER);
+	if (!table_attr)
+		goto err;
+
+	if (to_ib_umem_odp(mr->umem)->is_implicit_odp) {
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
index b0fc6b26bdf5..cb779b311703 100644
--- a/include/rdma/restrack.h
+++ b/include/rdma/restrack.h
@@ -157,6 +157,9 @@ int rdma_nl_put_driver_u32_hex(struct sk_buff *msg, const char *name,
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

