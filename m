Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B5220F1D0
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2020 11:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732020AbgF3Jjt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jun 2020 05:39:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729193AbgF3Jjq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jun 2020 05:39:46 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55F2A206A1;
        Tue, 30 Jun 2020 09:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593509986;
        bh=M6l0Hsd+5RnEKjC7htMTHZr12e+GDVXFDzdODTzJHW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mKW4gR6s2dAoH48lmClrFkPiYGMQlfJy/pzqd4aHiudiKxVuQDQeY+SresTx9+v94
         fD2Sxq6+l9a6ahuBB/GVksSWpO0fl2Z4lcNO4UFLIXfUHoGatTgbOEV6l4ztcA6bhj
         WpdfAjSh34kqG3sjef+yVln/NRhu0ehKqSOh3eGA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 6/7] RDMA/mlx5: Introduce UAPI to query PD attributes
Date:   Tue, 30 Jun 2020 12:39:15 +0300
Message-Id: <20200630093916.332097-7-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200630093916.332097-1-leon@kernel.org>
References: <20200630093916.332097-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Introduce UAPI to query PD attributes, this can be used to retrieve PD
attributes by having the PD handle of the created one and owning the
command FD for the ucontxet.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/Makefile      |  3 +-
 drivers/infiniband/hw/mlx5/main.c        |  1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h     |  2 ++
 drivers/infiniband/hw/mlx5/std_types.c   | 45 ++++++++++++++++++++++++
 include/uapi/rdma/mlx5_user_ioctl_cmds.h | 10 ++++++
 5 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 drivers/infiniband/hw/mlx5/std_types.c

diff --git a/drivers/infiniband/hw/mlx5/Makefile b/drivers/infiniband/hw/mlx5/Makefile
index 8cca61c671f8..9838719aacb9 100644
--- a/drivers/infiniband/hw/mlx5/Makefile
+++ b/drivers/infiniband/hw/mlx5/Makefile
@@ -23,4 +23,5 @@ mlx5_ib-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += odp.o
 mlx5_ib-$(CONFIG_MLX5_ESWITCH) += ib_rep.o
 mlx5_ib-$(CONFIG_INFINIBAND_USER_ACCESS) += devx.o \
 					    flow.o \
-					    qos.o
+					    qos.o \
+					    std_types.o
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 79cd7db4d32a..47a0c091eea5 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6412,6 +6412,7 @@ static const struct uapi_definition mlx5_ib_defs[] = {
 	UAPI_DEF_CHAIN(mlx5_ib_devx_defs),
 	UAPI_DEF_CHAIN(mlx5_ib_flow_defs),
 	UAPI_DEF_CHAIN(mlx5_ib_qos_defs),
+	UAPI_DEF_CHAIN(mlx5_ib_std_types_defs),

 	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_FLOW_ACTION,
 				&mlx5_ib_flow_action),
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 2fd199c07dda..26545e88709d 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1384,6 +1384,8 @@ int mlx5_ib_fill_stat_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr);
 extern const struct uapi_definition mlx5_ib_devx_defs[];
 extern const struct uapi_definition mlx5_ib_flow_defs[];
 extern const struct uapi_definition mlx5_ib_qos_defs[];
+extern const struct uapi_definition mlx5_ib_std_types_defs[];
+

 #if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user);
diff --git a/drivers/infiniband/hw/mlx5/std_types.c b/drivers/infiniband/hw/mlx5/std_types.c
new file mode 100644
index 000000000000..16145fda68d0
--- /dev/null
+++ b/drivers/infiniband/hw/mlx5/std_types.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2020, Mellanox Technologies inc.  All rights reserved.
+ */
+
+#include <rdma/uverbs_ioctl.h>
+#include <rdma/mlx5_user_ioctl_cmds.h>
+#include <rdma/mlx5_user_ioctl_verbs.h>
+#include <linux/mlx5/driver.h>
+#include "mlx5_ib.h"
+
+#define UVERBS_MODULE_NAME mlx5_ib
+#include <rdma/uverbs_named_ioctl.h>
+
+static int UVERBS_HANDLER(MLX5_IB_METHOD_PD_QUERY)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct ib_pd *pd =
+		uverbs_attr_get_obj(attrs, MLX5_IB_ATTR_QUERY_PD_HANDLE);
+	struct mlx5_ib_pd *mpd = to_mpd(pd);
+
+	return uverbs_copy_to(attrs, MLX5_IB_ATTR_QUERY_PD_RESP_PDN,
+			      &mpd->pdn, sizeof(mpd->pdn));
+}
+
+DECLARE_UVERBS_NAMED_METHOD(
+	MLX5_IB_METHOD_PD_QUERY,
+	UVERBS_ATTR_IDR(MLX5_IB_ATTR_QUERY_PD_HANDLE,
+			UVERBS_OBJECT_PD,
+			UVERBS_ACCESS_READ,
+			UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(MLX5_IB_ATTR_QUERY_PD_RESP_PDN,
+			   UVERBS_ATTR_TYPE(u32),
+			   UA_MANDATORY));
+
+ADD_UVERBS_METHODS(mlx5_ib_pd,
+		   UVERBS_OBJECT_PD,
+		   &UVERBS_METHOD(MLX5_IB_METHOD_PD_QUERY));
+
+const struct uapi_definition mlx5_ib_std_types_defs[] = {
+	UAPI_DEF_CHAIN_OBJ_TREE(
+		UVERBS_OBJECT_PD,
+		&mlx5_ib_pd),
+	{},
+};
diff --git a/include/uapi/rdma/mlx5_user_ioctl_cmds.h b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
index 496309e8a856..b330e6eee626 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_cmds.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
@@ -290,4 +290,14 @@ enum mlx5_ib_create_flow_action_create_packet_reformat_attrs {
 	MLX5_IB_ATTR_CREATE_PACKET_REFORMAT_DATA_BUF,
 };

+enum mlx5_ib_query_pd_attrs {
+	MLX5_IB_ATTR_QUERY_PD_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+	MLX5_IB_ATTR_QUERY_PD_RESP_PDN,
+};
+
+enum mlx5_ib_pd_methods {
+	MLX5_IB_METHOD_PD_QUERY = (1U << UVERBS_ID_NS_SHIFT),
+
+};
+
 #endif
--
2.26.2

