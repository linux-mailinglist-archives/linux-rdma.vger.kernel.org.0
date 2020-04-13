Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B591A6759
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 15:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbgDMNwj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 09:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730165AbgDMNwh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Apr 2020 09:52:37 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C55162072C;
        Mon, 13 Apr 2020 13:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586785956;
        bh=jRIBj1FU/Gbcm5l/ARPW7K20vuBYCTKDjqe1i7+3Duc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oH2eEP0mMO/3A71qvxwS73ynkuKWfHZbnzbIKsFl6L881gtxzaymTBsxvVwJmyjir
         fjv3bxDrefwRDSnH+Y3f3yR+O6bzf4RcmfYYtJmm/H63Nf7unm2QJHxMdxgm9Ad6xZ
         NEwVP6WwMw1PXmJLtAJ/pp7s6Wr3Qa65TjBriE/4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next 4/4] RDMA/mlx5: Add support in steering default miss
Date:   Mon, 13 Apr 2020 16:52:20 +0300
Message-Id: <20200413135220.934007-5-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200413135220.934007-1-leon@kernel.org>
References: <20200413135220.934007-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

User can configure default miss rule in order to skip matching in
the user domain and forward the packet to the kernel steering domain.
When user requests a default miss rule, we add steering rule
to forward the traffic to the next namespace.

Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Reviewed-by: Mark Zhang <markz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/flow.c        | 35 ++++++++++++++++++++----
 drivers/infiniband/hw/mlx5/main.c        |  9 +++---
 include/uapi/rdma/mlx5_user_ioctl_cmds.h |  5 ++++
 3 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/flow.c b/drivers/infiniband/hw/mlx5/flow.c
index 7ff8d7188b82..7db672fd1395 100644
--- a/drivers/infiniband/hw/mlx5/flow.c
+++ b/drivers/infiniband/hw/mlx5/flow.c
@@ -69,19 +69,35 @@ static const struct uverbs_attr_spec mlx5_ib_flow_type[] = {
 
 static int get_dests(struct uverbs_attr_bundle *attrs,
 		     struct mlx5_ib_flow_matcher *fs_matcher, int *dest_id,
-		     int *dest_type, struct ib_qp **qp)
+		     int *dest_type, struct ib_qp **qp, bool *def_miss)
 {
 	bool dest_devx, dest_qp;
 	void *devx_obj;
+	u32 flags;
 
 	dest_devx = uverbs_attr_is_valid(attrs,
 					 MLX5_IB_ATTR_CREATE_FLOW_DEST_DEVX);
 	dest_qp = uverbs_attr_is_valid(attrs,
 				       MLX5_IB_ATTR_CREATE_FLOW_DEST_QP);
 
-	if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_BYPASS &&
-	    ((dest_devx && dest_qp) || (!dest_devx && !dest_qp)))
-		return -EINVAL;
+	*def_miss = false;
+	if (uverbs_attr_is_valid(attrs, MLX5_IB_ATTR_FLOW_MATCHER_FLOW_FLAGS)) {
+		int err;
+
+		err = uverbs_get_flags32(&flags, attrs,
+					 MLX5_IB_ATTR_CREATE_FLOW_FLAGS,
+					 MLX5_IB_ATTR_CREATE_FLOW_FLAGS_DEFAULT_MISS);
+		if (err)
+			return err;
+		*def_miss = flags & MLX5_IB_ATTR_CREATE_FLOW_FLAGS_DEFAULT_MISS;
+	}
+
+	if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_BYPASS) {
+		if (dest_devx && (dest_qp || *def_miss))
+			return -EINVAL;
+		else if (dest_qp && *def_miss)
+			return -EINVAL;
+	}
 
 	/* Allow only DEVX object as dest when inserting to FDB */
 	if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_FDB && !dest_devx)
@@ -153,6 +169,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
 	void *devx_obj, *cmd_in;
 	struct ib_uobject *uobj;
 	struct mlx5_ib_dev *dev;
+	bool def_miss;
 
 	if (!capable(CAP_NET_RAW))
 		return -EPERM;
@@ -162,9 +179,12 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
 	uobj =  uverbs_attr_get_uobject(attrs, MLX5_IB_ATTR_CREATE_FLOW_HANDLE);
 	dev = mlx5_udata_to_mdev(&attrs->driver_udata);
 
-	if (get_dests(attrs, fs_matcher, &dest_id, &dest_type, &qp))
+	if (get_dests(attrs, fs_matcher, &dest_id, &dest_type, &qp, &def_miss))
 		return -EINVAL;
 
+	if (def_miss)
+		flow_act.action |= MLX5_FLOW_CONTEXT_ACTION_FWD_NEXT_NS;
+
 	len = uverbs_attr_get_uobjs_arr(attrs,
 		MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX, &arr_flow_actions);
 	if (len) {
@@ -636,7 +656,10 @@ DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_ATTR_PTR_IN(MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX_OFFSET,
 			   UVERBS_ATTR_MIN_SIZE(sizeof(u32)),
 			   UA_OPTIONAL,
-			   UA_ALLOC_AND_COPY));
+			   UA_ALLOC_AND_COPY),
+	UVERBS_ATTR_FLAGS_IN(MLX5_IB_ATTR_CREATE_FLOW_FLAGS,
+			     enum mlx5_ib_create_flow_flags,
+			     UA_OPTIONAL));
 
 DECLARE_UVERBS_NAMED_METHOD_DESTROY(
 	MLX5_IB_METHOD_DESTROY_FLOW,
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index c6bece8f6b2f..b8ac77ea8125 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4198,18 +4198,17 @@ mlx5_ib_raw_fs_rule_add(struct mlx5_ib_dev *dev,
 
 	if (dest_type == MLX5_FLOW_DESTINATION_TYPE_TIR) {
 		dst[dst_num].type = dest_type;
-		dst[dst_num].tir_num = dest_id;
+		dst[dst_num++].tir_num = dest_id;
 		flow_act->action |= MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
 	} else if (dest_type == MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE) {
 		dst[dst_num].type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE_NUM;
-		dst[dst_num].ft_num = dest_id;
+		dst[dst_num++].ft_num = dest_id;
 		flow_act->action |= MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
-	} else {
-		dst[dst_num].type = MLX5_FLOW_DESTINATION_TYPE_PORT;
+	} else  if (dest_type == MLX5_FLOW_DESTINATION_TYPE_PORT) {
+		dst[dst_num++].type = MLX5_FLOW_DESTINATION_TYPE_PORT;
 		flow_act->action |= MLX5_FLOW_CONTEXT_ACTION_ALLOW;
 	}
 
-	dst_num++;
 
 	if (flow_act->action & MLX5_FLOW_CONTEXT_ACTION_COUNT) {
 		dst[dst_num].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
diff --git a/include/uapi/rdma/mlx5_user_ioctl_cmds.h b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
index 24f3388c3182..07cf54333193 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_cmds.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
@@ -241,6 +241,10 @@ enum mlx5_ib_flow_type {
 	MLX5_IB_FLOW_TYPE_MC_DEFAULT,
 };
 
+enum mlx5_ib_create_flow_flags {
+	MLX5_IB_ATTR_CREATE_FLOW_FLAGS_DEFAULT_MISS = 1 << 0,
+};
+
 enum mlx5_ib_create_flow_attrs {
 	MLX5_IB_ATTR_CREATE_FLOW_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
 	MLX5_IB_ATTR_CREATE_FLOW_MATCH_VALUE,
@@ -251,6 +255,7 @@ enum mlx5_ib_create_flow_attrs {
 	MLX5_IB_ATTR_CREATE_FLOW_TAG,
 	MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX,
 	MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX_OFFSET,
+	MLX5_IB_ATTR_CREATE_FLOW_FLAGS,
 };
 
 enum mlx5_ib_destoy_flow_attrs {
-- 
2.25.2

