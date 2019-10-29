Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2777E7FFC
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 06:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbfJ2F7Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 01:59:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfJ2F7Y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 01:59:24 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D9C02053B;
        Tue, 29 Oct 2019 05:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572328762;
        bh=dhA7BM6O4OCHe+9VmGal042F5XBYNq3sC5X0oUnlu8M=;
        h=From:To:Cc:Subject:Date:From;
        b=OaUCoXiJCKoeDVgoBD27lNDMMiI1JrSDYsuUGivmDZMvEJdHeLIYs+NJj5Z846CjP
         jvnflzsJtr/P3+81kswTKx7qy1+sUFaEsAWAzHEqNDjbz9brUe2JXj2hUpoGh9cdHf
         3h0uMaS46v0SvDuihJOaih5ejI26L0fc7iOS/H5I=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yevgeny Kliteynik <kliteyn@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-next] IB/mlx5: Support flow counters offset for bulk counters
Date:   Tue, 29 Oct 2019 07:59:16 +0200
Message-Id: <20191029055916.7322-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yevgeny Kliteynik <kliteyn@mellanox.com>

Add support for flow steering counters action with
a non-base counter ID (offset) for bulk counters.

When creating a flow counter object, save the bulk value.
This value is used when a flow action with a non-base
counter ID is requested - to validate that the required
offset is in the range of the allocated bulk.

Signed-off-by: Yevgeny Kliteynik <kliteyn@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/devx.c        | 12 ++++++++-
 drivers/infiniband/hw/mlx5/flow.c        | 34 ++++++++++++++++++++++--
 drivers/infiniband/hw/mlx5/mlx5_ib.h     |  2 +-
 include/uapi/rdma/mlx5_user_ioctl_cmds.h |  1 +
 4 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 6b1fca91d7d3..3900fcb1ccaf 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -100,6 +100,7 @@ struct devx_obj {
 		struct mlx5_ib_devx_mr	devx_mr;
 		struct mlx5_core_dct	core_dct;
 		struct mlx5_core_cq	core_cq;
+		u32			flow_counter_bulk_size;
 	};
 	struct list_head event_sub; /* holds devx_event_subscription entries */
 };
@@ -192,7 +193,7 @@ bool mlx5_ib_devx_is_flow_dest(void *obj, int *dest_id, int *dest_type)
 	}
 }
 
-bool mlx5_ib_devx_is_flow_counter(void *obj, u32 *counter_id)
+bool mlx5_ib_devx_is_flow_counter(void *obj, u32 *counter_id, u32 *bulk_size)
 {
 	struct devx_obj *devx_obj = obj;
 	u16 opcode = MLX5_GET(general_obj_in_cmd_hdr, devx_obj->dinbox, opcode);
@@ -201,6 +202,7 @@ bool mlx5_ib_devx_is_flow_counter(void *obj, u32 *counter_id)
 		*counter_id = MLX5_GET(dealloc_flow_counter_in,
 				       devx_obj->dinbox,
 				       flow_counter_id);
+		*bulk_size = devx_obj->flow_counter_bulk_size;
 		return true;
 	}
 
@@ -1463,6 +1465,14 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_CREATE)(
 	if (err)
 		goto obj_free;
 
+	if (opcode == MLX5_CMD_OP_ALLOC_FLOW_COUNTER) {
+		u8 bulk = MLX5_GET(alloc_flow_counter_in,
+				   cmd_in,
+				   flow_counter_bulk);
+		if (bulk)
+			obj->flow_counter_bulk_size = 64UL << ffs(bulk);
+	}
+
 	uobj->object = obj;
 	INIT_LIST_HEAD(&obj->event_sub);
 	obj->ib_dev = dev;
diff --git a/drivers/infiniband/hw/mlx5/flow.c b/drivers/infiniband/hw/mlx5/flow.c
index b198ff10cde9..05637039bcd7 100644
--- a/drivers/infiniband/hw/mlx5/flow.c
+++ b/drivers/infiniband/hw/mlx5/flow.c
@@ -85,6 +85,8 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
 	struct mlx5_ib_dev *dev = mlx5_udata_to_mdev(&attrs->driver_udata);
 	int len, ret, i;
 	u32 counter_id = 0;
+	u32 bulk_size = 0;
+	u32 *offset;
 
 	if (!capable(CAP_NET_RAW))
 		return -EPERM;
@@ -151,8 +153,32 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
 	if (len) {
 		devx_obj = arr_flow_actions[0]->object;
 
-		if (!mlx5_ib_devx_is_flow_counter(devx_obj, &counter_id))
+		if (!mlx5_ib_devx_is_flow_counter(devx_obj,
+						  &counter_id,
+						  &bulk_size))
 			return -EINVAL;
+
+		if (uverbs_attr_is_valid(
+			    attrs,
+			    MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX_OFFSET)) {
+			int num_offsets = uverbs_attr_ptr_get_array_size(
+				attrs,
+				MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX_OFFSET,
+				sizeof(uint32_t));
+
+			if (num_offsets != 1)
+				return -EINVAL;
+
+			offset = uverbs_attr_get_alloced_ptr(
+				attrs,
+				MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX_OFFSET);
+
+			if (*offset && *offset >= bulk_size)
+				return -EINVAL;
+
+			counter_id += *offset;
+		}
+
 		flow_act.action |= MLX5_FLOW_CONTEXT_ACTION_COUNT;
 	}
 
@@ -598,7 +624,11 @@ DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_ATTR_IDRS_ARR(MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX,
 			     MLX5_IB_OBJECT_DEVX_OBJ,
 			     UVERBS_ACCESS_READ, 1, 1,
-			     UA_OPTIONAL));
+			     UA_OPTIONAL),
+	UVERBS_ATTR_PTR_IN(MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX_OFFSET,
+			   UVERBS_ATTR_MIN_SIZE(sizeof(uint32_t)),
+			   UA_OPTIONAL,
+			   UA_ALLOC_AND_COPY));
 
 DECLARE_UVERBS_NAMED_METHOD_DESTROY(
 	MLX5_IB_METHOD_DESTROY_FLOW,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 0bdb8b45ea15..0fb58ecccb7e 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1367,7 +1367,7 @@ struct mlx5_ib_flow_handler *mlx5_ib_raw_fs_rule_add(
 	struct mlx5_flow_act *flow_act, u32 counter_id,
 	void *cmd_in, int inlen, int dest_id, int dest_type);
 bool mlx5_ib_devx_is_flow_dest(void *obj, int *dest_id, int *dest_type);
-bool mlx5_ib_devx_is_flow_counter(void *obj, u32 *counter_id);
+bool mlx5_ib_devx_is_flow_counter(void *obj, u32 *counter_id, u32 *bulk_size);
 int mlx5_ib_get_flow_trees(const struct uverbs_object_tree_def **root);
 void mlx5_ib_destroy_flow_action_raw(struct mlx5_ib_flow_action *maction);
 #else
diff --git a/include/uapi/rdma/mlx5_user_ioctl_cmds.h b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
index d0da070cf0ab..20d88307f75f 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_cmds.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
@@ -198,6 +198,7 @@ enum mlx5_ib_create_flow_attrs {
 	MLX5_IB_ATTR_CREATE_FLOW_ARR_FLOW_ACTIONS,
 	MLX5_IB_ATTR_CREATE_FLOW_TAG,
 	MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX,
+	MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX_OFFSET,
 };
 
 enum mlx5_ib_destoy_flow_attrs {
-- 
2.20.1

