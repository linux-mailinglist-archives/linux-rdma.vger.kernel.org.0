Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632F43635B7
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Apr 2021 15:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhDRNu2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Apr 2021 09:50:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231460AbhDRNuW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Apr 2021 09:50:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E01D26052B;
        Sun, 18 Apr 2021 13:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618753794;
        bh=IYDhQViSgL0R8VHANWxTUf0VoI44Roq3uZ442Mv64m4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AknnVTmIHVJLeFEwlScamx151JiwmRBaTdf7UWNqIjDi/yptuhc1AsYy6NROKFfSH
         uxGLMPvfy+Un8kbIVhuBAN5HCdX8s/tRFxv7nib4L9/ZMQ7uEGKCpL+27RKc+JZ+Y/
         9Nc8tXN/EiAIdxKwOyVfhTkHVfbH/LF2n2xmyL+BVc/g1Fsb9FMOnt/MpLRKQ9nXls
         drPBSR0ZE+VBt8KdBAQpXCheGs9PMQgQcJUo663Wvl/p1c/K//OfVa1uyUg6+vKqTE
         4O/IhbKMVmMkrUUlZ471s/I6Sv1nPYIghvzMZ2Z4lbzpc8kINea5eF+/4/+GjKGEPi
         YMMn08w07tPgA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/2] RDMA/mlx5: Fix type assignment for ICM DM
Date:   Sun, 18 Apr 2021 16:49:40 +0300
Message-Id: <58dedbd5c132660f808e59166d434e2eaa6ecf7a.1618753425.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618753425.git.leonro@nvidia.com>
References: <cover.1618753425.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

We should hold the UAPI DM type in the base struct and not
the internal mlx5 type. Fix it.

Fixes: 9905fb65119f ("RDMA/mlx5: Re-organize the DM code")
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/dm.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/dm.c b/drivers/infiniband/hw/mlx5/dm.c
index 235aad6beacb..094bf85589db 100644
--- a/drivers/infiniband/hw/mlx5/dm.c
+++ b/drivers/infiniband/hw/mlx5/dm.c
@@ -331,12 +331,20 @@ static struct ib_dm *handle_alloc_dm_memic(struct ib_ucontext *ctx,
 	return ERR_PTR(err);
 }
 
+static enum mlx5_sw_icm_type get_icm_type(int uapi_type)
+{
+	return uapi_type == MLX5_IB_UAPI_DM_TYPE_STEERING_SW_ICM ?
+		       MLX5_SW_ICM_TYPE_STEERING :
+		       MLX5_SW_ICM_TYPE_HEADER_MODIFY;
+}
+
 static struct ib_dm *handle_alloc_dm_sw_icm(struct ib_ucontext *ctx,
 					    struct ib_dm_alloc_attr *attr,
 					    struct uverbs_attr_bundle *attrs,
 					    int type)
 {
 	struct mlx5_core_dev *dev = to_mdev(ctx->device)->mdev;
+	enum mlx5_sw_icm_type icm_type = get_icm_type(type);
 	struct mlx5_ib_dm_icm *dm;
 	u64 act_size;
 	int err;
@@ -368,7 +376,7 @@ static struct ib_dm *handle_alloc_dm_sw_icm(struct ib_ucontext *ctx,
 	act_size = roundup_pow_of_two(act_size);
 
 	dm->base.size = act_size;
-	err = mlx5_dm_sw_icm_alloc(dev, type, act_size, attr->alignment,
+	err = mlx5_dm_sw_icm_alloc(dev, icm_type, act_size, attr->alignment,
 				   to_mucontext(ctx)->devx_uid,
 				   &dm->base.dev_addr, &dm->obj_id);
 	if (err)
@@ -377,7 +385,7 @@ static struct ib_dm *handle_alloc_dm_sw_icm(struct ib_ucontext *ctx,
 	err = uverbs_copy_to(attrs, MLX5_IB_ATTR_ALLOC_DM_RESP_START_OFFSET,
 			     &dm->base.dev_addr, sizeof(dm->base.dev_addr));
 	if (err) {
-		mlx5_dm_sw_icm_dealloc(dev, type, dm->base.size,
+		mlx5_dm_sw_icm_dealloc(dev, icm_type, dm->base.size,
 				       to_mucontext(ctx)->devx_uid,
 				       dm->base.dev_addr, dm->obj_id);
 		goto free;
@@ -409,11 +417,9 @@ struct ib_dm *mlx5_ib_alloc_dm(struct ib_device *ibdev,
 	case MLX5_IB_UAPI_DM_TYPE_MEMIC:
 		return handle_alloc_dm_memic(context, attr, attrs);
 	case MLX5_IB_UAPI_DM_TYPE_STEERING_SW_ICM:
-		return handle_alloc_dm_sw_icm(context, attr, attrs,
-					     MLX5_SW_ICM_TYPE_STEERING);
+		return handle_alloc_dm_sw_icm(context, attr, attrs, type);
 	case MLX5_IB_UAPI_DM_TYPE_HEADER_MODIFY_SW_ICM:
-		return handle_alloc_dm_sw_icm(context, attr, attrs,
-					      MLX5_SW_ICM_TYPE_HEADER_MODIFY);
+		return handle_alloc_dm_sw_icm(context, attr, attrs, type);
 	default:
 		return ERR_PTR(-EOPNOTSUPP);
 	}
@@ -441,10 +447,7 @@ static void mlx5_dm_memic_dealloc(struct mlx5_ib_dm_memic *dm)
 static int mlx5_dm_icm_dealloc(struct mlx5_ib_ucontext *ctx,
 			       struct mlx5_ib_dm_icm *dm)
 {
-	enum mlx5_sw_icm_type type =
-		dm->base.type == MLX5_IB_UAPI_DM_TYPE_STEERING_SW_ICM ?
-			MLX5_SW_ICM_TYPE_STEERING :
-			MLX5_SW_ICM_TYPE_HEADER_MODIFY;
+	enum mlx5_sw_icm_type type = get_icm_type(dm->base.type);
 	struct mlx5_core_dev *dev = to_mdev(dm->base.ibdm.device)->mdev;
 	int err;
 
-- 
2.30.2

