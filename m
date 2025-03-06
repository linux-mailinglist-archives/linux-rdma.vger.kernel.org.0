Return-Path: <linux-rdma+bounces-8421-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3369A54A16
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 12:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0133E3A860E
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 11:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAE220897A;
	Thu,  6 Mar 2025 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4GK9LpL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11360156225
	for <linux-rdma@vger.kernel.org>; Thu,  6 Mar 2025 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261948; cv=none; b=ARJBJQhu3NHCt8KP/R0Ng8RYihEcNmlIQxf7eqQY3mRbgwfh5JEae5t/TLZKBmT/8nwWAgHzU0uGQJIMxm4VPoc+0Ad2uVwsLndIS0721Ryp/4t2CIQ+hwJilKAdnWU4pEPO+4PuWfZWtRuPPC1+Gull3tZ9dREPak0xYwwQynE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261948; c=relaxed/simple;
	bh=bTciPm5xpivDDQ68z1qsRozR+LSvcKNYFP1QeDj14ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiPuD//NudNGdPgsUs59MndSVqakJYas9QBEhzH+/9QpkLs96EPHzmCjrB0Gx6s/Ve6XYZO859at0N/HAMI2RhHODx0gGhIYeQ3EJW0RMsxnjXPd/mhmBV0WKkk7HDrqiTFU+VrLDbhFiSBx8HE86gm6vo6yDFk4tU5MD8mTTq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4GK9LpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1690FC4CEE0;
	Thu,  6 Mar 2025 11:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741261947;
	bh=bTciPm5xpivDDQ68z1qsRozR+LSvcKNYFP1QeDj14ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T4GK9LpLYW7vBdObT4U5/N1TBgpfWp/VLBydmQs/ErO4QGRRqiFvNkwfKxnMspaP4
	 L8OajwH87HB5RjkPhldyB7Ab0WEuCubxVHbRxhizgzM+6jNOr2HqqJK2bUTut9lQlY
	 Y3XpIZDfcAUvW6BRkBnwb9oKP7tzLAj+pKgWz2gFJmC7j6nhHG4yedPMnsRebk70jv
	 Iy1wi2qkQKNCLKqS0e23ADFRu4E9UA0uOOrlp5mRi96swTg1pR1QQNSQdcb4HwdGW1
	 F2KQhJ1oh4XhjohRW0ztKClIjSJauguHix5wUJYqdDGgaBXEL7E3JkQ5rn0NP9rSip
	 go1x2JyxIe6+Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next v1 4/6] RDMA/mlx5: Check enabled UCAPs when creating ucontext
Date: Thu,  6 Mar 2025 13:51:29 +0200
Message-ID: <8b180583a207cb30deb7a2967934079749cdcc44.1741261611.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741261611.git.leon@kernel.org>
References: <cover.1741261611.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chiara Meiohas <cmeiohas@nvidia.com>

Verify that the enabled UCAPs are supported by the device before
creating the ucontext.
If supported, create the ucontext with the associated capabilities.

Store the privileged ucontext UID on creation and remove it when
destroying the privileged ucontext. This allows the command interface
to recognize privileged commands through its UID.

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
---
 drivers/infiniband/hw/mlx5/devx.c | 31 +++++++++++++++++++++++++++++--
 drivers/infiniband/hw/mlx5/devx.h |  5 +++--
 drivers/infiniband/hw/mlx5/main.c | 30 ++++++++++++++++++++++++++----
 3 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 39304cae5b10..2479da8620ca 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -13,6 +13,7 @@
 #include <rdma/uverbs_std_types.h>
 #include <linux/mlx5/driver.h>
 #include <linux/mlx5/fs.h>
+#include <rdma/ib_ucaps.h>
 #include "mlx5_ib.h"
 #include "devx.h"
 #include "qp.h"
@@ -122,7 +123,27 @@ devx_ufile2uctx(const struct uverbs_attr_bundle *attrs)
 	return to_mucontext(ib_uverbs_get_ucontext(attrs));
 }
 
-int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user)
+static int set_uctx_ucaps(struct mlx5_ib_dev *dev, u64 req_ucaps, u32 *cap)
+{
+	if (UCAP_ENABLED(req_ucaps, RDMA_UCAP_MLX5_CTRL_LOCAL)) {
+		if (MLX5_CAP_GEN(dev->mdev, uctx_cap) & MLX5_UCTX_CAP_RDMA_CTRL)
+			*cap |= MLX5_UCTX_CAP_RDMA_CTRL;
+		else
+			return -EOPNOTSUPP;
+	}
+
+	if (UCAP_ENABLED(req_ucaps, RDMA_UCAP_MLX5_CTRL_OTHER_VHCA)) {
+		if (MLX5_CAP_GEN(dev->mdev, uctx_cap) &
+		    MLX5_UCTX_CAP_RDMA_CTRL_OTHER_VHCA)
+			*cap |= MLX5_UCTX_CAP_RDMA_CTRL_OTHER_VHCA;
+		else
+			return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user, u64 req_ucaps)
 {
 	u32 in[MLX5_ST_SZ_DW(create_uctx_in)] = {};
 	u32 out[MLX5_ST_SZ_DW(create_uctx_out)] = {};
@@ -146,6 +167,12 @@ int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user)
 	    capable(CAP_SYS_RAWIO))
 		cap |= MLX5_UCTX_CAP_INTERNAL_DEV_RES;
 
+	if (req_ucaps) {
+		err = set_uctx_ucaps(dev, req_ucaps, &cap);
+		if (err)
+			return err;
+	}
+
 	MLX5_SET(create_uctx_in, in, opcode, MLX5_CMD_OP_CREATE_UCTX);
 	MLX5_SET(uctx, uctx, cap, cap);
 
@@ -2575,7 +2602,7 @@ int mlx5_ib_devx_init(struct mlx5_ib_dev *dev)
 	struct mlx5_devx_event_table *table = &dev->devx_event_table;
 	int uid;
 
-	uid = mlx5_ib_devx_create(dev, false);
+	uid = mlx5_ib_devx_create(dev, false, 0);
 	if (uid > 0) {
 		dev->devx_whitelist_uid = uid;
 		xa_init(&table->event_xa);
diff --git a/drivers/infiniband/hw/mlx5/devx.h b/drivers/infiniband/hw/mlx5/devx.h
index 1344bf4c9d21..ee9e7d3af93f 100644
--- a/drivers/infiniband/hw/mlx5/devx.h
+++ b/drivers/infiniband/hw/mlx5/devx.h
@@ -24,13 +24,14 @@ struct devx_obj {
 	struct list_head event_sub; /* holds devx_event_subscription entries */
 };
 #if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
-int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user);
+int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user, u64 req_ucaps);
 void mlx5_ib_devx_destroy(struct mlx5_ib_dev *dev, u16 uid);
 int mlx5_ib_devx_init(struct mlx5_ib_dev *dev);
 void mlx5_ib_devx_cleanup(struct mlx5_ib_dev *dev);
 void mlx5_ib_ufile_hw_cleanup(struct ib_uverbs_file *ufile);
 #else
-static inline int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user)
+static inline int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user,
+				      u64 req_ucaps)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 04b489a6a449..d07cacaa0abd 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1935,6 +1935,12 @@ static int set_ucontext_resp(struct ib_ucontext *uctx,
 	return 0;
 }
 
+static bool uctx_rdma_ctrl_is_enabled(u64 enabled_caps)
+{
+	return UCAP_ENABLED(enabled_caps, RDMA_UCAP_MLX5_CTRL_LOCAL) ||
+	       UCAP_ENABLED(enabled_caps, RDMA_UCAP_MLX5_CTRL_OTHER_VHCA);
+}
+
 static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 				  struct ib_udata *udata)
 {
@@ -1977,10 +1983,17 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 		return -EINVAL;
 
 	if (req.flags & MLX5_IB_ALLOC_UCTX_DEVX) {
-		err = mlx5_ib_devx_create(dev, true);
+		err = mlx5_ib_devx_create(dev, true, uctx->enabled_caps);
 		if (err < 0)
 			goto out_ctx;
 		context->devx_uid = err;
+
+		if (uctx_rdma_ctrl_is_enabled(uctx->enabled_caps)) {
+			err = mlx5_cmd_add_privileged_uid(dev->mdev,
+							  context->devx_uid);
+			if (err)
+				goto out_devx;
+		}
 	}
 
 	lib_uar_4k = req.lib_caps & MLX5_LIB_CAP_4K_UAR;
@@ -1995,7 +2008,7 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 	/* updates req->total_num_bfregs */
 	err = calc_total_bfregs(dev, lib_uar_4k, &req, bfregi);
 	if (err)
-		goto out_devx;
+		goto out_ucap;
 
 	mutex_init(&bfregi->lock);
 	bfregi->lib_uar_4k = lib_uar_4k;
@@ -2003,7 +2016,7 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 				GFP_KERNEL);
 	if (!bfregi->count) {
 		err = -ENOMEM;
-		goto out_devx;
+		goto out_ucap;
 	}
 
 	bfregi->sys_pages = kcalloc(bfregi->num_sys_pages,
@@ -2067,6 +2080,11 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 out_count:
 	kfree(bfregi->count);
 
+out_ucap:
+	if (req.flags & MLX5_IB_ALLOC_UCTX_DEVX &&
+	    uctx_rdma_ctrl_is_enabled(uctx->enabled_caps))
+		mlx5_cmd_remove_privileged_uid(dev->mdev, context->devx_uid);
+
 out_devx:
 	if (req.flags & MLX5_IB_ALLOC_UCTX_DEVX)
 		mlx5_ib_devx_destroy(dev, context->devx_uid);
@@ -2111,8 +2129,12 @@ static void mlx5_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
 	kfree(bfregi->sys_pages);
 	kfree(bfregi->count);
 
-	if (context->devx_uid)
+	if (context->devx_uid) {
+		if (uctx_rdma_ctrl_is_enabled(ibcontext->enabled_caps))
+			mlx5_cmd_remove_privileged_uid(dev->mdev,
+						       context->devx_uid);
 		mlx5_ib_devx_destroy(dev, context->devx_uid);
+	}
 }
 
 static phys_addr_t uar_index2pfn(struct mlx5_ib_dev *dev,
-- 
2.48.1


