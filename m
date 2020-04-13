Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FADE1A6758
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 15:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgDMNwe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 09:52:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730165AbgDMNwd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Apr 2020 09:52:33 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 539CE2072C;
        Mon, 13 Apr 2020 13:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586785953;
        bh=riMKdoOE/QZAPQWBhiyrI2O9eqjFGsi8rlgcXr6x1Gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A97tiA55PWTTuVzY/UmR6LOPklkCinAwzV4tMaf4oqOMOttE8yyp0+Bl8hTRjvW0v
         VTBjVtWXMFhIkfNYAsedEAOFa/AaUi6wZzUwKybIbcsPgZckRigN3qNRBRqWtNysuR
         gp/IWH6frdJVUVI/Cvq4XE2uEQnKU/V6D3ytlmcA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next 3/4] RDMA/mlx5: Refactor DV create flow
Date:   Mon, 13 Apr 2020 16:52:19 +0300
Message-Id: <20200413135220.934007-4-leon@kernel.org>
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

Move part of the code that get the destinations into function so
the code will be more readable.
In addition change the variables definition to be in reversed
christmas tree.

Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Reviewed-by: Mark Zhang <markz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/flow.c | 108 ++++++++++++++++--------------
 1 file changed, 59 insertions(+), 49 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/flow.c b/drivers/infiniband/hw/mlx5/flow.c
index 862b7bf3e646..7ff8d7188b82 100644
--- a/drivers/infiniband/hw/mlx5/flow.c
+++ b/drivers/infiniband/hw/mlx5/flow.c
@@ -67,40 +67,18 @@ static const struct uverbs_attr_spec mlx5_ib_flow_type[] = {
 	},
 };
 
-#define MLX5_IB_CREATE_FLOW_MAX_FLOW_ACTIONS 2
-static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
-	struct uverbs_attr_bundle *attrs)
+static int get_dests(struct uverbs_attr_bundle *attrs,
+		     struct mlx5_ib_flow_matcher *fs_matcher, int *dest_id,
+		     int *dest_type, struct ib_qp **qp)
 {
-	struct mlx5_flow_context flow_context = {.flow_tag = MLX5_FS_DEFAULT_FLOW_TAG};
-	struct mlx5_ib_flow_handler *flow_handler;
-	struct mlx5_ib_flow_matcher *fs_matcher;
-	struct ib_uobject **arr_flow_actions;
-	struct ib_uflow_resources *uflow_res;
-	struct mlx5_flow_act flow_act = {};
-	void *devx_obj;
-	int dest_id, dest_type;
-	void *cmd_in;
-	int inlen;
 	bool dest_devx, dest_qp;
-	struct ib_qp *qp = NULL;
-	struct ib_uobject *uobj =
-		uverbs_attr_get_uobject(attrs, MLX5_IB_ATTR_CREATE_FLOW_HANDLE);
-	struct mlx5_ib_dev *dev = mlx5_udata_to_mdev(&attrs->driver_udata);
-	int len, ret, i;
-	u32 counter_id = 0;
-	u32 *offset_attr;
-	u32 offset = 0;
-
-	if (!capable(CAP_NET_RAW))
-		return -EPERM;
+	void *devx_obj;
 
-	dest_devx =
-		uverbs_attr_is_valid(attrs, MLX5_IB_ATTR_CREATE_FLOW_DEST_DEVX);
+	dest_devx = uverbs_attr_is_valid(attrs,
+					 MLX5_IB_ATTR_CREATE_FLOW_DEST_DEVX);
 	dest_qp = uverbs_attr_is_valid(attrs,
 				       MLX5_IB_ATTR_CREATE_FLOW_DEST_QP);
 
-	fs_matcher = uverbs_attr_get_obj(attrs,
-					 MLX5_IB_ATTR_CREATE_FLOW_MATCHER);
 	if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_BYPASS &&
 	    ((dest_devx && dest_qp) || (!dest_devx && !dest_qp)))
 		return -EINVAL;
@@ -114,43 +92,79 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
 	    ((!dest_devx && !dest_qp) || (dest_devx && dest_qp)))
 		return -EINVAL;
 
+	*qp = NULL;
 	if (dest_devx) {
-		devx_obj = uverbs_attr_get_obj(
-			attrs, MLX5_IB_ATTR_CREATE_FLOW_DEST_DEVX);
-		if (IS_ERR(devx_obj))
-			return PTR_ERR(devx_obj);
+		devx_obj =
+			uverbs_attr_get_obj(attrs,
+					    MLX5_IB_ATTR_CREATE_FLOW_DEST_DEVX);
 
 		/* Verify that the given DEVX object is a flow
 		 * steering destination.
 		 */
-		if (!mlx5_ib_devx_is_flow_dest(devx_obj, &dest_id, &dest_type))
+		if (!mlx5_ib_devx_is_flow_dest(devx_obj, dest_id, dest_type))
 			return -EINVAL;
 		/* Allow only flow table as dest when inserting to FDB or RDMA_RX */
 		if ((fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_FDB ||
 		     fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_RDMA_RX) &&
-		    dest_type != MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE)
+		    *dest_type != MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE)
 			return -EINVAL;
 	} else if (dest_qp) {
 		struct mlx5_ib_qp *mqp;
 
-		qp = uverbs_attr_get_obj(attrs,
-					 MLX5_IB_ATTR_CREATE_FLOW_DEST_QP);
-		if (IS_ERR(qp))
-			return PTR_ERR(qp);
+		*qp = uverbs_attr_get_obj(attrs,
+					  MLX5_IB_ATTR_CREATE_FLOW_DEST_QP);
+		if (IS_ERR(*qp))
+			return PTR_ERR(*qp);
 
-		if (qp->qp_type != IB_QPT_RAW_PACKET)
+		if ((*qp)->qp_type != IB_QPT_RAW_PACKET)
 			return -EINVAL;
 
-		mqp = to_mqp(qp);
+		mqp = to_mqp(*qp);
 		if (mqp->flags & MLX5_IB_QP_RSS)
-			dest_id = mqp->rss_qp.tirn;
+			*dest_id = mqp->rss_qp.tirn;
 		else
-			dest_id = mqp->raw_packet_qp.rq.tirn;
-		dest_type = MLX5_FLOW_DESTINATION_TYPE_TIR;
-	} else {
-		dest_type = MLX5_FLOW_DESTINATION_TYPE_PORT;
+			*dest_id = mqp->raw_packet_qp.rq.tirn;
+		*dest_type = MLX5_FLOW_DESTINATION_TYPE_TIR;
+	} else if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_EGRESS) {
+		*dest_type = MLX5_FLOW_DESTINATION_TYPE_PORT;
 	}
 
+	if (*dest_type == MLX5_FLOW_DESTINATION_TYPE_TIR &&
+	    fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_EGRESS)
+		return -EINVAL;
+
+	return 0;
+}
+
+#define MLX5_IB_CREATE_FLOW_MAX_FLOW_ACTIONS 2
+static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct mlx5_flow_context flow_context = {.flow_tag =
+		MLX5_FS_DEFAULT_FLOW_TAG};
+	u32 *offset_attr, offset = 0, counter_id = 0;
+	int dest_id, dest_type, inlen, len, ret, i;
+	struct mlx5_ib_flow_handler *flow_handler;
+	struct mlx5_ib_flow_matcher *fs_matcher;
+	struct ib_uobject **arr_flow_actions;
+	struct ib_uflow_resources *uflow_res;
+	struct mlx5_flow_act flow_act = {};
+	struct ib_qp *qp = NULL;
+	void *devx_obj, *cmd_in;
+	struct ib_uobject *uobj;
+	struct mlx5_ib_dev *dev;
+
+	if (!capable(CAP_NET_RAW))
+		return -EPERM;
+
+	fs_matcher = uverbs_attr_get_obj(attrs,
+					 MLX5_IB_ATTR_CREATE_FLOW_MATCHER);
+	uobj =  uverbs_attr_get_uobject(attrs, MLX5_IB_ATTR_CREATE_FLOW_HANDLE);
+	dev = mlx5_udata_to_mdev(&attrs->driver_udata);
+
+	if (get_dests(attrs, fs_matcher, &dest_id, &dest_type, &qp))
+		return -EINVAL;
+
 	len = uverbs_attr_get_uobjs_arr(attrs,
 		MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX, &arr_flow_actions);
 	if (len) {
@@ -180,10 +194,6 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
 		flow_act.action |= MLX5_FLOW_CONTEXT_ACTION_COUNT;
 	}
 
-	if (dest_type == MLX5_FLOW_DESTINATION_TYPE_TIR &&
-	    fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_EGRESS)
-		return -EINVAL;
-
 	cmd_in = uverbs_attr_get_alloced_ptr(
 		attrs, MLX5_IB_ATTR_CREATE_FLOW_MATCH_VALUE);
 	inlen = uverbs_attr_get_len(attrs,
-- 
2.25.2

