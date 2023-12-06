Return-Path: <linux-rdma+bounces-284-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DE680719F
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Dec 2023 15:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A892C1F21774
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Dec 2023 14:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1A83DB80;
	Wed,  6 Dec 2023 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXhDziaj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2A33C46C;
	Wed,  6 Dec 2023 14:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7C4C433C7;
	Wed,  6 Dec 2023 14:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701871324;
	bh=o88IFEZmKb0zSYDLYIuSIbrM45xCOBW/YrPsSXa96i0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cXhDziajBznbOMUPDfZuMCw3/cV3FS1eJ1D4yrxPst25gXdxmtb0zWYSFZe4Rfy4A
	 Lc2cuPSq5/FAi+VN52MnsvaWLXCL/f07CoJft3NipFExF05JGxZXk+NhaZBGUHILl8
	 cq5ClmR5GiXGnteFt5g/Jq962Wr3N9yapK8bXBdcZDBrYZ6UU963IkmBr5z6WXZMp6
	 PuWSLAGZ2yWxYfLVIiTQw7AGy6dIFVTTUFzqKzHbNq34OeGHzVwmpSgvOx8ToFgRdV
	 eu9SjTxVtMhpLx1xzM5VvADGr/oUly/+Bxsyh/H76mxwyyczvNQijUl5UiXL5ThtK8
	 RCByoeB4gKW8Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shun Hao <shunh@nvidia.com>
Subject: [PATCH mlx5-next v1 4/5] net/mlx5: E-Switch, expose eswitch manager vport
Date: Wed,  6 Dec 2023 16:01:37 +0200
Message-ID: <614fb0e216250e2ce3340471ec141b83ec45c7f4.1701871118.git.leon@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701871118.git.leon@kernel.org>
References: <cover.1701871118.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Bloch <mbloch@nvidia.com>

Expose the ability the query the eswitch manager vport number.
Next patch will utilize this capability to reveal the correct
register C0 value to the users.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h | 7 -------
 include/linux/mlx5/eswitch.h                      | 8 ++++++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 37ab66e7b403..60a9a6cba0b1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -616,13 +616,6 @@ static inline bool mlx5_esw_allowed(const struct mlx5_eswitch *esw)
 	return esw && MLX5_ESWITCH_MANAGER(esw->dev);
 }
 
-/* The returned number is valid only when the dev is eswitch manager. */
-static inline u16 mlx5_eswitch_manager_vport(struct mlx5_core_dev *dev)
-{
-	return mlx5_core_is_ecpf_esw_manager(dev) ?
-		MLX5_VPORT_ECPF : MLX5_VPORT_PF;
-}
-
 static inline bool
 mlx5_esw_is_manager_vport(const struct mlx5_eswitch *esw, u16 vport_num)
 {
diff --git a/include/linux/mlx5/eswitch.h b/include/linux/mlx5/eswitch.h
index 950d2431a53c..df73a2ccc9af 100644
--- a/include/linux/mlx5/eswitch.h
+++ b/include/linux/mlx5/eswitch.h
@@ -7,6 +7,7 @@
 #define _MLX5_ESWITCH_
 
 #include <linux/mlx5/driver.h>
+#include <linux/mlx5/vport.h>
 #include <net/devlink.h>
 
 #define MLX5_ESWITCH_MANAGER(mdev) MLX5_CAP_GEN(mdev, eswitch_manager)
@@ -210,4 +211,11 @@ static inline bool is_mdev_switchdev_mode(struct mlx5_core_dev *dev)
 	return mlx5_eswitch_mode(dev) == MLX5_ESWITCH_OFFLOADS;
 }
 
+/* The returned number is valid only when the dev is eswitch manager. */
+static inline u16 mlx5_eswitch_manager_vport(struct mlx5_core_dev *dev)
+{
+	return mlx5_core_is_ecpf_esw_manager(dev) ?
+		MLX5_VPORT_ECPF : MLX5_VPORT_PF;
+}
+
 #endif
-- 
2.43.0


