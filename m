Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7491FAEC7
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 12:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgFPK6n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 06:58:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgFPK6l (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Jun 2020 06:58:41 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B789120786;
        Tue, 16 Jun 2020 10:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592305120;
        bh=tWqsgKO8qkEARP9YxEV7Z0xYcoULDGAMWo4bpFFb4Jo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rw5YAy+mRRybH4w2au00BFE8S5hnpspXqql6se6sN51SgXOxE1WsdvDpeyND9Tnjc
         ESA3lsnq+jmsBP1ZYINGI9L99EakClcBFupmQT4hsP7lOLFVOj3PzrW2CKLBrbwzeD
         ANM/y1ljzmvXIw1TTQ/mpcwpI6Q7xlefcZ8f2cw0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 5/7] RDMA/mlx5: Implement the query ucontext functionality
Date:   Tue, 16 Jun 2020 13:55:29 +0300
Message-Id: <20200616105531.2428010-6-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200616105531.2428010-1-leon@kernel.org>
References: <20200616105531.2428010-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Implement the query ucontext functionality by returning the original
ucontext data as part of an extra mlx5 attribute that holds the driver
UAPI response.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/uverbs_ioctl.c   |  1 +
 drivers/infiniband/hw/mlx5/main.c        | 35 ++++++++++++++++++++++++
 include/uapi/rdma/mlx5_user_ioctl_cmds.h |  4 +++
 3 files changed, 40 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
index 2d882c02387c..ef04a261097f 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -790,6 +790,7 @@ int uverbs_copy_to_struct_or_zero(const struct uverbs_attr_bundle *bundle,
 	}
 	return uverbs_copy_to(bundle, idx, from, size);
 }
+EXPORT_SYMBOL(uverbs_copy_to_struct_or_zero);
 
 /* Once called an abort will call through to the type's destroy_hw() */
 void uverbs_finalize_uobj_create(const struct uverbs_attr_bundle *bundle,
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 1c1f1bfb83f1..79cd7db4d32a 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1990,6 +1990,29 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 	return err;
 }
 
+static int mlx5_ib_query_ucontext(struct ib_ucontext *ibcontext,
+				  struct uverbs_attr_bundle *attrs)
+{
+	struct mlx5_ib_alloc_ucontext_resp uctx_resp = {};
+	int ret;
+
+	ret = set_ucontext_resp(ibcontext, &uctx_resp);
+	if (ret)
+		return ret;
+
+	uctx_resp.response_length =
+		min_t(size_t,
+		      uverbs_attr_get_len(attrs,
+				MLX5_IB_ATTR_QUERY_CONTEXT_RESP_UCTX),
+		      sizeof(uctx_resp));
+
+	ret = uverbs_copy_to_struct_or_zero(attrs,
+					MLX5_IB_ATTR_QUERY_CONTEXT_RESP_UCTX,
+					&uctx_resp,
+					sizeof(uctx_resp));
+	return ret;
+}
+
 static void mlx5_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
 {
 	struct mlx5_ib_ucontext *context = to_mucontext(ibcontext);
@@ -6375,6 +6398,16 @@ ADD_UVERBS_ATTRIBUTES_SIMPLE(
 	UVERBS_ATTR_FLAGS_IN(MLX5_IB_ATTR_CREATE_FLOW_ACTION_FLAGS,
 			     enum mlx5_ib_uapi_flow_action_flags));
 
+ADD_UVERBS_ATTRIBUTES_SIMPLE(
+	mlx5_ib_query_context,
+	UVERBS_OBJECT_DEVICE,
+	UVERBS_METHOD_QUERY_CONTEXT,
+	UVERBS_ATTR_PTR_OUT(
+		MLX5_IB_ATTR_QUERY_CONTEXT_RESP_UCTX,
+		UVERBS_ATTR_STRUCT(struct mlx5_ib_alloc_ucontext_resp,
+				   dump_fill_mkey),
+		UA_MANDATORY));
+
 static const struct uapi_definition mlx5_ib_defs[] = {
 	UAPI_DEF_CHAIN(mlx5_ib_devx_defs),
 	UAPI_DEF_CHAIN(mlx5_ib_flow_defs),
@@ -6383,6 +6416,7 @@ static const struct uapi_definition mlx5_ib_defs[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_FLOW_ACTION,
 				&mlx5_ib_flow_action),
 	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_DM, &mlx5_ib_dm),
+	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_DEVICE, &mlx5_ib_query_context),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(MLX5_IB_OBJECT_VAR,
 				UAPI_DEF_IS_OBJ_SUPPORTED(var_is_supported)),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(MLX5_IB_OBJECT_UAR),
@@ -6616,6 +6650,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.query_pkey = mlx5_ib_query_pkey,
 	.query_qp = mlx5_ib_query_qp,
 	.query_srq = mlx5_ib_query_srq,
+	.query_ucontext = mlx5_ib_query_ucontext,
 	.read_counters = mlx5_ib_read_counters,
 	.reg_user_mr = mlx5_ib_reg_user_mr,
 	.req_notify_cq = mlx5_ib_arm_cq,
diff --git a/include/uapi/rdma/mlx5_user_ioctl_cmds.h b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
index 8e316ef896b5..496309e8a856 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_cmds.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
@@ -228,6 +228,10 @@ enum mlx5_ib_flow_matcher_methods {
 	MLX5_IB_METHOD_FLOW_MATCHER_DESTROY,
 };
 
+enum mlx5_ib_device_query_context_attrs {
+	MLX5_IB_ATTR_QUERY_CONTEXT_RESP_UCTX = (1U << UVERBS_ID_NS_SHIFT),
+};
+
 #define MLX5_IB_DW_MATCH_PARAM 0x80
 
 struct mlx5_ib_match_params {
-- 
2.26.2

