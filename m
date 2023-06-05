Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA36672238F
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jun 2023 12:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjFEKdr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 06:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFEKdq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 06:33:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB48F2
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 03:33:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D830760F07
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 10:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB319C4339B;
        Mon,  5 Jun 2023 10:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685961223;
        bh=haWfC2gFWXCmKrL5rQVMTLh/YHC1sL8+awkGk7ZCSog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nXc8mOv2Q5AmrBgDIoib4bQc92Y0nsSFngO3DgOOz8Jf1ROB010l+6bD7JIIXdv3M
         RmSg2GcNoKEQeYnM//yBmwcoGRIgMjzcivLL44SLu9qD1VlAs+0lF3hr+UI/TbFTfm
         +aTsUNPrG6sQK8kf5NM7bK1UJxBsBseysf4EudiMvMULccuHooHUE+Zbdn7VXrN6Cd
         7hnQUcy2J4E4NMGmBO7JaHK4kT9TNrTiTx+K6CourXOEfjh4/1CwrIBfpRLGs+z5/8
         7YJhfcnDu0lnc8yOD3F2mJIB2CNLLGd33yAoPxlgl5hqVNIL6gr8AgtZewpumCvitC
         cGhPwL+vynP4Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Bloch <mbloch@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-rc 02/10] RDMA/mlx5: Create an indirect flow table for steering anchor
Date:   Mon,  5 Jun 2023 13:33:18 +0300
Message-Id: <b4a88a871d651fa4e8f98d552553c1cfe9ba2cd6.1685960567.git.leon@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685960567.git.leon@kernel.org>
References: <cover.1685960567.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Bloch <mbloch@nvidia.com>

A misbehaved user can create a steering anchor that points to a kernel
flow table and then destroy the anchor without freeing the associated
STC. This creates a problem as the kernel can't destroy the flow
table since there is still a reference to it. As a result, this can
exhaust all available flow table resources, preventing other users from
using the RDMA device.

To prevent this problem, a solution is implemented where a special flow
table with two steering rules is created when a user creates a steering
anchor for the first time. The rules include one that drops all traffic
and another that points to the kernel flow table. If the steering anchor
is destroyed, only the rule pointing to the kernel's flow table is removed.
Any traffic reaching the special flow table after that is dropped.

Since the special flow table is not destroyed when the steering anchor is
destroyed, any issues are prevented from occurring. The remaining resources
are only destroyed when the RDMA device is destroyed, which happens after
all DEVX objects are freed, including the STCs, thus mitigating the issue.

Fixes: 0c6ab0ca9a66 ("RDMA/mlx5: Expose steering anchor to userspace")
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/fs.c      | 276 ++++++++++++++++++++++++++-
 drivers/infiniband/hw/mlx5/fs.h      |  16 ++
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  11 ++
 3 files changed, 296 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 3008632a6c20..1e419e080b53 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -695,8 +695,6 @@ static struct mlx5_ib_flow_prio *_get_prio(struct mlx5_ib_dev *dev,
 	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_flow_table *ft;
 
-	if (mlx5_ib_shared_ft_allowed(&dev->ib_dev))
-		ft_attr.uid = MLX5_SHARED_RESOURCE_UID;
 	ft_attr.prio = priority;
 	ft_attr.max_fte = num_entries;
 	ft_attr.flags = flags;
@@ -2025,6 +2023,237 @@ static int flow_matcher_cleanup(struct ib_uobject *uobject,
 	return 0;
 }
 
+static int steering_anchor_create_ft(struct mlx5_ib_dev *dev,
+				     struct mlx5_ib_flow_prio *ft_prio,
+				     enum mlx5_flow_namespace_type ns_type)
+{
+	struct mlx5_flow_table_attr ft_attr = {};
+	struct mlx5_flow_namespace *ns;
+	struct mlx5_flow_table *ft;
+
+	if (ft_prio->anchor.ft)
+		return 0;
+
+	ns = mlx5_get_flow_namespace(dev->mdev, ns_type);
+	if (!ns)
+		return -EOPNOTSUPP;
+
+	ft_attr.flags = MLX5_FLOW_TABLE_UNMANAGED;
+	ft_attr.uid = MLX5_SHARED_RESOURCE_UID;
+	ft_attr.prio = 0;
+	ft_attr.max_fte = 2;
+	ft_attr.level = 1;
+
+	ft = mlx5_create_flow_table(ns, &ft_attr);
+	if (IS_ERR(ft))
+		return PTR_ERR(ft);
+
+	ft_prio->anchor.ft = ft;
+
+	return 0;
+}
+
+static void steering_anchor_destroy_ft(struct mlx5_ib_flow_prio *ft_prio)
+{
+	if (ft_prio->anchor.ft) {
+		mlx5_destroy_flow_table(ft_prio->anchor.ft);
+		ft_prio->anchor.ft = NULL;
+	}
+}
+
+static int
+steering_anchor_create_fg_drop(struct mlx5_ib_flow_prio *ft_prio)
+{
+	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
+	struct mlx5_flow_group *fg;
+	void *flow_group_in;
+	int err = 0;
+
+	if (ft_prio->anchor.fg_drop)
+		return 0;
+
+	flow_group_in = kvzalloc(inlen, GFP_KERNEL);
+	if (!flow_group_in)
+		return -ENOMEM;
+
+	MLX5_SET(create_flow_group_in, flow_group_in, start_flow_index, 1);
+	MLX5_SET(create_flow_group_in, flow_group_in, end_flow_index, 1);
+
+	fg = mlx5_create_flow_group(ft_prio->anchor.ft, flow_group_in);
+	if (IS_ERR(fg)) {
+		err = PTR_ERR(fg);
+		goto out;
+	}
+
+	ft_prio->anchor.fg_drop = fg;
+
+out:
+	kvfree(flow_group_in);
+
+	return err;
+}
+
+static void
+steering_anchor_destroy_fg_drop(struct mlx5_ib_flow_prio *ft_prio)
+{
+	if (ft_prio->anchor.fg_drop) {
+		mlx5_destroy_flow_group(ft_prio->anchor.fg_drop);
+		ft_prio->anchor.fg_drop = NULL;
+	}
+}
+
+static int
+steering_anchor_create_fg_goto_table(struct mlx5_ib_flow_prio *ft_prio)
+{
+	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
+	struct mlx5_flow_group *fg;
+	void *flow_group_in;
+	int err = 0;
+
+	if (ft_prio->anchor.fg_goto_table)
+		return 0;
+
+	flow_group_in = kvzalloc(inlen, GFP_KERNEL);
+	if (!flow_group_in)
+		return -ENOMEM;
+
+	fg = mlx5_create_flow_group(ft_prio->anchor.ft, flow_group_in);
+	if (IS_ERR(fg)) {
+		err = PTR_ERR(fg);
+		goto out;
+	}
+	ft_prio->anchor.fg_goto_table = fg;
+
+out:
+	kvfree(flow_group_in);
+
+	return err;
+}
+
+static void
+steering_anchor_destroy_fg_goto_table(struct mlx5_ib_flow_prio *ft_prio)
+{
+	if (ft_prio->anchor.fg_goto_table) {
+		mlx5_destroy_flow_group(ft_prio->anchor.fg_goto_table);
+		ft_prio->anchor.fg_goto_table = NULL;
+	}
+}
+
+static int
+steering_anchor_create_rule_drop(struct mlx5_ib_flow_prio *ft_prio)
+{
+	struct mlx5_flow_act flow_act = {};
+	struct mlx5_flow_handle *handle;
+
+	if (ft_prio->anchor.rule_drop)
+		return 0;
+
+	flow_act.fg = ft_prio->anchor.fg_drop;
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP;
+
+	handle = mlx5_add_flow_rules(ft_prio->anchor.ft, NULL, &flow_act,
+				     NULL, 0);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+
+	ft_prio->anchor.rule_drop = handle;
+
+	return 0;
+}
+
+static void steering_anchor_destroy_rule_drop(struct mlx5_ib_flow_prio *ft_prio)
+{
+	if (ft_prio->anchor.rule_drop) {
+		mlx5_del_flow_rules(ft_prio->anchor.rule_drop);
+		ft_prio->anchor.rule_drop = NULL;
+	}
+}
+
+static int
+steering_anchor_create_rule_goto_table(struct mlx5_ib_flow_prio *ft_prio)
+{
+	struct mlx5_flow_destination dest = {};
+	struct mlx5_flow_act flow_act = {};
+	struct mlx5_flow_handle *handle;
+
+	if (ft_prio->anchor.rule_goto_table)
+		return 0;
+
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
+	flow_act.flags |= FLOW_ACT_IGNORE_FLOW_LEVEL;
+	flow_act.fg = ft_prio->anchor.fg_goto_table;
+
+	dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+	dest.ft = ft_prio->flow_table;
+
+	handle = mlx5_add_flow_rules(ft_prio->anchor.ft, NULL, &flow_act,
+				     &dest, 1);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+
+	ft_prio->anchor.rule_goto_table = handle;
+
+	return 0;
+}
+
+static void
+steering_anchor_destroy_rule_goto_table(struct mlx5_ib_flow_prio *ft_prio)
+{
+	if (ft_prio->anchor.rule_goto_table) {
+		mlx5_del_flow_rules(ft_prio->anchor.rule_goto_table);
+		ft_prio->anchor.rule_goto_table = NULL;
+	}
+}
+
+static int steering_anchor_create_res(struct mlx5_ib_dev *dev,
+				      struct mlx5_ib_flow_prio *ft_prio,
+				      enum mlx5_flow_namespace_type ns_type)
+{
+	int err;
+
+	err = steering_anchor_create_ft(dev, ft_prio, ns_type);
+	if (err)
+		return err;
+
+	err = steering_anchor_create_fg_drop(ft_prio);
+	if (err)
+		goto destroy_ft;
+
+	err = steering_anchor_create_fg_goto_table(ft_prio);
+	if (err)
+		goto destroy_fg_drop;
+
+	err = steering_anchor_create_rule_drop(ft_prio);
+	if (err)
+		goto destroy_fg_goto_table;
+
+	err = steering_anchor_create_rule_goto_table(ft_prio);
+	if (err)
+		goto destroy_rule_drop;
+
+	return 0;
+
+destroy_rule_drop:
+	steering_anchor_destroy_rule_drop(ft_prio);
+destroy_fg_goto_table:
+	steering_anchor_destroy_fg_goto_table(ft_prio);
+destroy_fg_drop:
+	steering_anchor_destroy_fg_drop(ft_prio);
+destroy_ft:
+	steering_anchor_destroy_ft(ft_prio);
+
+	return err;
+}
+
+static void mlx5_steering_anchor_destroy_res(struct mlx5_ib_flow_prio *ft_prio)
+{
+	steering_anchor_destroy_rule_goto_table(ft_prio);
+	steering_anchor_destroy_rule_drop(ft_prio);
+	steering_anchor_destroy_fg_goto_table(ft_prio);
+	steering_anchor_destroy_fg_drop(ft_prio);
+	steering_anchor_destroy_ft(ft_prio);
+}
+
 static int steering_anchor_cleanup(struct ib_uobject *uobject,
 				   enum rdma_remove_reason why,
 				   struct uverbs_attr_bundle *attrs)
@@ -2035,6 +2264,9 @@ static int steering_anchor_cleanup(struct ib_uobject *uobject,
 		return -EBUSY;
 
 	mutex_lock(&obj->dev->flow_db->lock);
+	if (!--obj->ft_prio->anchor.rule_goto_table_ref)
+		steering_anchor_destroy_rule_goto_table(obj->ft_prio);
+
 	put_flow_table(obj->dev, obj->ft_prio, true);
 	mutex_unlock(&obj->dev->flow_db->lock);
 
@@ -2042,6 +2274,24 @@ static int steering_anchor_cleanup(struct ib_uobject *uobject,
 	return 0;
 }
 
+static void fs_cleanup_anchor(struct mlx5_ib_flow_prio *prio,
+			      int count)
+{
+	while (count--)
+		mlx5_steering_anchor_destroy_res(&prio[count]);
+}
+
+void mlx5_ib_fs_cleanup_anchor(struct mlx5_ib_dev *dev)
+{
+	fs_cleanup_anchor(dev->flow_db->prios, MLX5_IB_NUM_FLOW_FT);
+	fs_cleanup_anchor(dev->flow_db->egress_prios, MLX5_IB_NUM_FLOW_FT);
+	fs_cleanup_anchor(dev->flow_db->sniffer, MLX5_IB_NUM_SNIFFER_FTS);
+	fs_cleanup_anchor(dev->flow_db->egress, MLX5_IB_NUM_EGRESS_FTS);
+	fs_cleanup_anchor(dev->flow_db->fdb, MLX5_IB_NUM_FDB_FTS);
+	fs_cleanup_anchor(dev->flow_db->rdma_rx, MLX5_IB_NUM_FLOW_FT);
+	fs_cleanup_anchor(dev->flow_db->rdma_tx, MLX5_IB_NUM_FLOW_FT);
+}
+
 static int mlx5_ib_matcher_ns(struct uverbs_attr_bundle *attrs,
 			      struct mlx5_ib_flow_matcher *obj)
 {
@@ -2182,21 +2432,31 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_STEERING_ANCHOR_CREATE)(
 		return -ENOMEM;
 
 	mutex_lock(&dev->flow_db->lock);
+
 	ft_prio = _get_flow_table(dev, priority, ns_type, 0);
 	if (IS_ERR(ft_prio)) {
-		mutex_unlock(&dev->flow_db->lock);
 		err = PTR_ERR(ft_prio);
 		goto free_obj;
 	}
 
 	ft_prio->refcount++;
-	ft_id = mlx5_flow_table_id(ft_prio->flow_table);
-	mutex_unlock(&dev->flow_db->lock);
+
+	if (!ft_prio->anchor.rule_goto_table_ref) {
+		err = steering_anchor_create_res(dev, ft_prio, ns_type);
+		if (err)
+			goto put_flow_table;
+	}
+
+	ft_prio->anchor.rule_goto_table_ref++;
+
+	ft_id = mlx5_flow_table_id(ft_prio->anchor.ft);
 
 	err = uverbs_copy_to(attrs, MLX5_IB_ATTR_STEERING_ANCHOR_FT_ID,
 			     &ft_id, sizeof(ft_id));
 	if (err)
-		goto put_flow_table;
+		goto destroy_res;
+
+	mutex_unlock(&dev->flow_db->lock);
 
 	uobj->object = obj;
 	obj->dev = dev;
@@ -2205,8 +2465,10 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_STEERING_ANCHOR_CREATE)(
 
 	return 0;
 
+destroy_res:
+	--ft_prio->anchor.rule_goto_table_ref;
+	mlx5_steering_anchor_destroy_res(ft_prio);
 put_flow_table:
-	mutex_lock(&dev->flow_db->lock);
 	put_flow_table(dev, ft_prio, true);
 	mutex_unlock(&dev->flow_db->lock);
 free_obj:
diff --git a/drivers/infiniband/hw/mlx5/fs.h b/drivers/infiniband/hw/mlx5/fs.h
index ad320adaf321..b9734904f5f0 100644
--- a/drivers/infiniband/hw/mlx5/fs.h
+++ b/drivers/infiniband/hw/mlx5/fs.h
@@ -10,6 +10,7 @@
 
 #if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 int mlx5_ib_fs_init(struct mlx5_ib_dev *dev);
+void mlx5_ib_fs_cleanup_anchor(struct mlx5_ib_dev *dev);
 #else
 static inline int mlx5_ib_fs_init(struct mlx5_ib_dev *dev)
 {
@@ -21,9 +22,24 @@ static inline int mlx5_ib_fs_init(struct mlx5_ib_dev *dev)
 	mutex_init(&dev->flow_db->lock);
 	return 0;
 }
+
+inline void mlx5_ib_fs_cleanup_anchor(struct mlx5_ib_dev *dev) {}
 #endif
+
 static inline void mlx5_ib_fs_cleanup(struct mlx5_ib_dev *dev)
 {
+	/* When a steering anchor is created, a special flow table is also
+	 * created for the user to reference. Since the user can reference it,
+	 * the kernel cannot trust that when the user destroys the steering
+	 * anchor, they no longer reference the flow table.
+	 *
+	 * To address this issue, when a user destroys a steering anchor, only
+	 * the flow steering rule in the table is destroyed, but the table
+	 * itself is kept to deal with the above scenario. The remaining
+	 * resources are only removed when the RDMA device is destroyed, which
+	 * is a safe assumption that all references are gone.
+	 */
+	mlx5_ib_fs_cleanup_anchor(dev);
 	kfree(dev->flow_db);
 }
 #endif /* _MLX5_IB_FS_H */
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 2c148ef60088..2a2d2a356c41 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -238,8 +238,19 @@ enum {
 #define MLX5_IB_NUM_SNIFFER_FTS		2
 #define MLX5_IB_NUM_EGRESS_FTS		1
 #define MLX5_IB_NUM_FDB_FTS		MLX5_BY_PASS_NUM_REGULAR_PRIOS
+
+struct mlx5_ib_anchor {
+	struct mlx5_flow_table *ft;
+	struct mlx5_flow_group *fg_goto_table;
+	struct mlx5_flow_group *fg_drop;
+	struct mlx5_flow_handle *rule_goto_table;
+	struct mlx5_flow_handle *rule_drop;
+	unsigned int rule_goto_table_ref;
+};
+
 struct mlx5_ib_flow_prio {
 	struct mlx5_flow_table		*flow_table;
+	struct mlx5_ib_anchor		anchor;
 	unsigned int			refcount;
 };
 
-- 
2.40.1

