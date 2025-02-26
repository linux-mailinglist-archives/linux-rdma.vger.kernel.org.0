Return-Path: <linux-rdma+bounces-8157-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBECA4624C
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 15:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE13A3B0105
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 14:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3059221D90;
	Wed, 26 Feb 2025 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOlNda1y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948FC22171D
	for <linux-rdma@vger.kernel.org>; Wed, 26 Feb 2025 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579481; cv=none; b=KQCnyGHI3Tqyg1OS/avcmaSJc8gjgA4nkpSo24sHgYDW96HeOp0euaP/xBqKDfMJ9BOJdUHA7NOnpXwPswZ9v22QK7sUYdAf3Q+3+lA2oHn155iH65wTxbZx2eFoEsHGZA+FvGJu1jqm/GkFIjbgH5CNcbD9aEfl0NCWrQp6V8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579481; c=relaxed/simple;
	bh=Aoz+QavRXw18FJ5GW865BMZ0YWdhhTInaHJmTTVVK78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwNSG4+FenbMLet4ENUaFRdSaJw7lSybrmDgxGkJJHqH+m4G+TthZ3f960oKsiehrBIaXFQgDPL+RTXD4Pu0Z6SdAwHb0C72RapadO687opDd3JiwD+N+km57pTQEATlH4qh51TYSILM6+oBReFOTGUVXL1chhNf5qSZUgl3EAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOlNda1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE23C4CED6;
	Wed, 26 Feb 2025 14:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740579481;
	bh=Aoz+QavRXw18FJ5GW865BMZ0YWdhhTInaHJmTTVVK78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QOlNda1y59UsA0gETiqm2yrvq/Rszqcc6zl9+FLPpII4kLyVBtohxbMWNET5IDzI/
	 uMR1Rg/Hk1K0QZCmNfvu/q83nTRv0brmQY9HpLHl+DrN031ObCibrQy7Nz6+ma8kzC
	 O8DrkOzD4/AzK7xKPZrRRz1JUETNAypz6VSQB6sVLNMln5vd2gMPELzbOJPj5WjZmI
	 ZJRevaSrMQFKuc5pJ+n86AQp66YaNjns/dluGgStleRUGYX1oQO8redYU2ORbvlpMX
	 IZOT2EvJdmLOC7wLawHqywFlJv+1p3IiX5LQblYez5T7xq4+ikcQYSybLN+0kYYpK6
	 vaaxhzFJgcYfQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 2/6] RDMA/mlx5: Create UCAP char devices for supported device capabilities
Date: Wed, 26 Feb 2025 16:17:28 +0200
Message-ID: <c7324d9fbaf7151fdce04ac6d4efce07bfa2f382.1740574943.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740574943.git.leon@kernel.org>
References: <cover.1740574943.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chiara Meiohas <cmeiohas@nvidia.com>

Create UCAP character devices when probing an IB device with supported
firmware capabilities.

If the RDMA_CTRL general object type is supported, check for specific
UCTX capabilities:
Create /dev/infiniband/mlx5_perm_ctrl_local for RDMA_UCAP_MLX5_CTRL_LOCAL
Create /dev/infiniband/mlx5_perm_ctrl_other_vhca for RDMA_UCAP_MLX5_CTRL_OTHER_VHCA

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
---
 drivers/infiniband/hw/mlx5/main.c | 47 +++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 81849eb671a1..04b489a6a449 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -47,6 +47,7 @@
 #include <rdma/uverbs_ioctl.h>
 #include <rdma/mlx5_user_ioctl_verbs.h>
 #include <rdma/mlx5_user_ioctl_cmds.h>
+#include <rdma/ib_ucaps.h>
 #include "macsec.h"
 #include "data_direct.h"
 
@@ -4201,8 +4202,47 @@ static int mlx5_ib_init_var_table(struct mlx5_ib_dev *dev)
 	return (var_table->bitmap) ? 0 : -ENOMEM;
 }
 
+static void mlx5_ib_cleanup_ucaps(struct mlx5_ib_dev *dev)
+{
+	if (MLX5_CAP_GEN(dev->mdev, uctx_cap) & MLX5_UCTX_CAP_RDMA_CTRL)
+		ib_remove_ucap(RDMA_UCAP_MLX5_CTRL_LOCAL);
+
+	if (MLX5_CAP_GEN(dev->mdev, uctx_cap) &
+	    MLX5_UCTX_CAP_RDMA_CTRL_OTHER_VHCA)
+		ib_remove_ucap(RDMA_UCAP_MLX5_CTRL_OTHER_VHCA);
+}
+
+static int mlx5_ib_init_ucaps(struct mlx5_ib_dev *dev)
+{
+	int ret;
+
+	if (MLX5_CAP_GEN(dev->mdev, uctx_cap) & MLX5_UCTX_CAP_RDMA_CTRL) {
+		ret = ib_create_ucap(RDMA_UCAP_MLX5_CTRL_LOCAL);
+		if (ret)
+			return ret;
+	}
+
+	if (MLX5_CAP_GEN(dev->mdev, uctx_cap) &
+	    MLX5_UCTX_CAP_RDMA_CTRL_OTHER_VHCA) {
+		ret = ib_create_ucap(RDMA_UCAP_MLX5_CTRL_OTHER_VHCA);
+		if (ret)
+			goto remove_local;
+	}
+
+	return 0;
+
+remove_local:
+	if (MLX5_CAP_GEN(dev->mdev, uctx_cap) & MLX5_UCTX_CAP_RDMA_CTRL)
+		ib_remove_ucap(RDMA_UCAP_MLX5_CTRL_LOCAL);
+	return ret;
+}
+
 static void mlx5_ib_stage_caps_cleanup(struct mlx5_ib_dev *dev)
 {
+	if (MLX5_CAP_GEN_2_64(dev->mdev, general_obj_types_127_64) &
+	    MLX5_HCA_CAP_2_GENERAL_OBJECT_TYPES_RDMA_CTRL)
+		mlx5_ib_cleanup_ucaps(dev);
+
 	bitmap_free(dev->var_table.bitmap);
 }
 
@@ -4253,6 +4293,13 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 			return err;
 	}
 
+	if (MLX5_CAP_GEN_2_64(dev->mdev, general_obj_types_127_64) &
+	    MLX5_HCA_CAP_2_GENERAL_OBJECT_TYPES_RDMA_CTRL) {
+		err = mlx5_ib_init_ucaps(dev);
+		if (err)
+			return err;
+	}
+
 	dev->ib_dev.use_cq_dim = true;
 
 	return 0;
-- 
2.48.1


