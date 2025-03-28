Return-Path: <linux-rdma+bounces-9021-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 776C1A74A6E
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Mar 2025 14:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6673A9D0E
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Mar 2025 13:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C33128819;
	Fri, 28 Mar 2025 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIf9rDPQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB07F35942;
	Fri, 28 Mar 2025 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743167427; cv=none; b=CHVnFydaXhZLrwqXi+wsIMJXCTY5PcSBMuQfSTm4+Xl0bGWKt72jeNVSrLCv5itmXSp4uzItMG55mAES/jGkJe8vMfE9gCwnd1xLKe4QkbUmKtEjf3yi+rZu5KSqvth3JdMt/v9WSG2Qz6AAN38jSpBrlUNKWCayURq2e1TxrtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743167427; c=relaxed/simple;
	bh=7w996QN1O4O8YD3ULgad71VmijrAh9VTtgICgRhxWvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m6lzNtmS43dXXkMe9geUU1N1F3adWo+hRkt3XjrDFesgTJRHx3RUFW82O1BUzBvzBTmgMGOtgYG9JA1UUBoRg2lZZ/iGB/03EfKE2pMPVBbKUq1riSIzCc5ypvJieyyFjFXC4AiVC9eMjt6E06cvs2hw4CHxj48WxAviYUa4lmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIf9rDPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E81C4CEE4;
	Fri, 28 Mar 2025 13:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743167427;
	bh=7w996QN1O4O8YD3ULgad71VmijrAh9VTtgICgRhxWvg=;
	h=From:To:Cc:Subject:Date:From;
	b=EIf9rDPQ765ru6baxUXCoGAyYdh7S8f/ANAepRCWpCssctmDStc+u3VI6grYD0c6K
	 ucJ//rV7RXeQeIsrtwD5fgQ4bTYAn+7oJyBdbOBs5Xoz+q4Ahu3rKVajJYW9S2KijS
	 qdpZ7Q2bJvqDLe0Rh+QMYD8fogDOoPCAN+k2RK1FkAAwMDA9z7ys1/9U3g5wNXRznj
	 6LIi3a/0b2lsoZ+UGVOXP1KnXBoPjPP9kyTRVSOXIXFxVNYQIxIGQA/egjLNMYOwnO
	 /I5oRRQM3RG2cfYZdoUThjP7EuW2at41qRTDt+R+o5mHm6p5GbnxezI5TtyRZ0yOaG
	 FQ+GSG9AlehvQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Patrisious Haddad <phaddad@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Mark Bloch <mbloch@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Moshe Shemesh <moshe@nvidia.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/mlx5: hide unused code
Date: Fri, 28 Mar 2025 14:10:17 +0100
Message-Id: <20250328131022.452068-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

After a recent rework, a few 'static const' objects have become unused:

In file included from drivers/infiniband/hw/mlx5/fs.c:27:
drivers/infiniband/hw/mlx5/fs.c:26:28: error: 'mlx5_ib_object_MLX5_IB_OBJECT_STEERING_ANCHOR' defined but not used [-Werror=unused-const-variable=]
include/rdma/uverbs_named_ioctl.h:52:47: note: in expansion of macro 'UVERBS_OBJECT'
   52 |         static const struct uverbs_object_def UVERBS_OBJECT(_object_id) = {    \
      |                                               ^~~~~~~~~~~~~
drivers/infiniband/hw/mlx5/fs.c:3457:1: note: in expansion of macro 'DECLARE_UVERBS_NAMED_OBJECT'
 3457 | DECLARE_UVERBS_NAMED_OBJECT(
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~

drivers/infiniband/hw/mlx5/fs.c:26:28: error: 'mlx5_ib_object_MLX5_IB_OBJECT_FLOW_MATCHER' defined but not used [-Werror=unused-const-variable=]
include/rdma/uverbs_named_ioctl.h:52:47: note: in expansion of macro 'UVERBS_OBJECT'
   52 |         static const struct uverbs_object_def UVERBS_OBJECT(_object_id) = {    \
      |                                               ^~~~~~~~~~~~~
drivers/infiniband/hw/mlx5/fs.c:3429:1: note: in expansion of macro 'DECLARE_UVERBS_NAMED_OBJECT'
 3429 | DECLARE_UVERBS_NAMED_OBJECT(MLX5_IB_OBJECT_FLOW_MATCHER,
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~

These come from a complex set of macros, and it would be possible to
shut up the warnings here by adding __maybe_unused annotations inside
of the macros, it seems cleaner in this case to have a large #ifdef block
around all the unused parts of the file, in order to still be able to
catch unused ones elsewhere.

It is a bit suspicious that the various "create" functions are unused
but the corresponding "destroy" functions are still called, so it's
likely that a different approach of changing the cleanup logic as well
is actually more correct.

Fixes: 36e0d433672f ("RDMA/mlx5: Compile fs.c regardless of INFINIBAND_USER_ACCESS config")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/hw/mlx5/fs.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 251246c73b33..f089abbed6af 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -684,12 +684,14 @@ enum flow_table_type {
 #define MLX5_FS_MAX_TYPES	 6
 #define MLX5_FS_MAX_ENTRIES	 BIT(16)
 
-static bool __maybe_unused mlx5_ib_shared_ft_allowed(struct ib_device *device)
+#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
+static bool mlx5_ib_shared_ft_allowed(struct ib_device *device)
 {
 	struct mlx5_ib_dev *dev = to_mdev(device);
 
 	return MLX5_CAP_GEN(dev->mdev, shared_object_to_user_object_allowed);
 }
+#endif
 
 static struct mlx5_ib_flow_prio *_get_prio(struct mlx5_ib_dev *dev,
 					   struct mlx5_flow_namespace *ns,
@@ -1888,6 +1890,7 @@ static struct ib_flow *mlx5_ib_create_flow(struct ib_qp *qp,
 	return ERR_PTR(err);
 }
 
+#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 static int mlx5_ib_fill_transport_ns_info(struct mlx5_ib_dev *dev,
 					  enum mlx5_flow_namespace_type type,
 					  u32 *flags, u16 *vport_idx,
@@ -2227,6 +2230,7 @@ static struct mlx5_ib_flow_handler *raw_fs_rule_add(
 
 	return ERR_PTR(err);
 }
+#endif
 
 static void destroy_flow_action_raw(struct mlx5_ib_flow_action *maction)
 {
@@ -2263,6 +2267,7 @@ static int mlx5_ib_destroy_flow_action(struct ib_flow_action *action)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 static int
 mlx5_ib_ft_type_to_namespace(enum mlx5_ib_uapi_flow_table_type table_type,
 			     enum mlx5_flow_namespace_type *namespace)
@@ -2618,6 +2623,7 @@ static int steering_anchor_create_ft(struct mlx5_ib_dev *dev,
 
 	return 0;
 }
+#endif
 
 static void steering_anchor_destroy_ft(struct mlx5_ib_flow_prio *ft_prio)
 {
@@ -2627,6 +2633,7 @@ static void steering_anchor_destroy_ft(struct mlx5_ib_flow_prio *ft_prio)
 	}
 }
 
+#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 static int
 steering_anchor_create_fg_drop(struct mlx5_ib_flow_prio *ft_prio)
 {
@@ -2658,6 +2665,7 @@ steering_anchor_create_fg_drop(struct mlx5_ib_flow_prio *ft_prio)
 
 	return err;
 }
+#endif
 
 static void
 steering_anchor_destroy_fg_drop(struct mlx5_ib_flow_prio *ft_prio)
@@ -2668,6 +2676,7 @@ steering_anchor_destroy_fg_drop(struct mlx5_ib_flow_prio *ft_prio)
 	}
 }
 
+#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 static int
 steering_anchor_create_fg_goto_table(struct mlx5_ib_flow_prio *ft_prio)
 {
@@ -2695,6 +2704,7 @@ steering_anchor_create_fg_goto_table(struct mlx5_ib_flow_prio *ft_prio)
 
 	return err;
 }
+#endif
 
 static void
 steering_anchor_destroy_fg_goto_table(struct mlx5_ib_flow_prio *ft_prio)
@@ -2705,6 +2715,7 @@ steering_anchor_destroy_fg_goto_table(struct mlx5_ib_flow_prio *ft_prio)
 	}
 }
 
+#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 static int
 steering_anchor_create_rule_drop(struct mlx5_ib_flow_prio *ft_prio)
 {
@@ -2726,6 +2737,7 @@ steering_anchor_create_rule_drop(struct mlx5_ib_flow_prio *ft_prio)
 
 	return 0;
 }
+#endif
 
 static void steering_anchor_destroy_rule_drop(struct mlx5_ib_flow_prio *ft_prio)
 {
@@ -2735,6 +2747,7 @@ static void steering_anchor_destroy_rule_drop(struct mlx5_ib_flow_prio *ft_prio)
 	}
 }
 
+#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 static int
 steering_anchor_create_rule_goto_table(struct mlx5_ib_flow_prio *ft_prio)
 {
@@ -2761,6 +2774,7 @@ steering_anchor_create_rule_goto_table(struct mlx5_ib_flow_prio *ft_prio)
 
 	return 0;
 }
+#endif
 
 static void
 steering_anchor_destroy_rule_goto_table(struct mlx5_ib_flow_prio *ft_prio)
@@ -2771,6 +2785,7 @@ steering_anchor_destroy_rule_goto_table(struct mlx5_ib_flow_prio *ft_prio)
 	}
 }
 
+#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 static int steering_anchor_create_res(struct mlx5_ib_dev *dev,
 				      struct mlx5_ib_flow_prio *ft_prio,
 				      enum mlx5_flow_namespace_type ns_type)
@@ -2810,6 +2825,7 @@ static int steering_anchor_create_res(struct mlx5_ib_dev *dev,
 
 	return err;
 }
+#endif
 
 static void mlx5_steering_anchor_destroy_res(struct mlx5_ib_flow_prio *ft_prio)
 {
@@ -2820,6 +2836,7 @@ static void mlx5_steering_anchor_destroy_res(struct mlx5_ib_flow_prio *ft_prio)
 	steering_anchor_destroy_ft(ft_prio);
 }
 
+#ifdef CONFIG_INFINIBAND_USER_ACCESS
 static int steering_anchor_cleanup(struct ib_uobject *uobject,
 				   enum rdma_remove_reason why,
 				   struct uverbs_attr_bundle *attrs)
@@ -2839,6 +2856,7 @@ static int steering_anchor_cleanup(struct ib_uobject *uobject,
 	kfree(obj);
 	return 0;
 }
+#endif
 
 static void fs_cleanup_anchor(struct mlx5_ib_flow_prio *prio,
 			      int count)
@@ -2858,6 +2876,7 @@ void mlx5_ib_fs_cleanup_anchor(struct mlx5_ib_dev *dev)
 	fs_cleanup_anchor(dev->flow_db->rdma_tx, MLX5_IB_NUM_FLOW_FT);
 }
 
+#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 static int mlx5_ib_matcher_ns(struct uverbs_attr_bundle *attrs,
 			      struct mlx5_ib_flow_matcher *obj)
 {
@@ -3459,6 +3478,7 @@ DECLARE_UVERBS_NAMED_OBJECT(
 	UVERBS_TYPE_ALLOC_IDR(steering_anchor_cleanup),
 	&UVERBS_METHOD(MLX5_IB_METHOD_STEERING_ANCHOR_CREATE),
 	&UVERBS_METHOD(MLX5_IB_METHOD_STEERING_ANCHOR_DESTROY));
+#endif
 
 const struct uapi_definition mlx5_ib_flow_defs[] = {
 #if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
-- 
2.39.5


