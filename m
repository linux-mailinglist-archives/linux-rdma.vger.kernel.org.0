Return-Path: <linux-rdma+bounces-119-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0B47FBA20
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Nov 2023 13:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F321C21485
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Nov 2023 12:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6008454F99;
	Tue, 28 Nov 2023 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzoeXu76"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AB557884;
	Tue, 28 Nov 2023 12:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E980C433C7;
	Tue, 28 Nov 2023 12:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701174619;
	bh=o88IFEZmKb0zSYDLYIuSIbrM45xCOBW/YrPsSXa96i0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dzoeXu76e95YohI7t3MUzuEUkIra5Ta/l61fMSc2k15M1EHk8UCmsFjqfd4l4kmpN
	 S80LFQjVBBI+JDgGIloH2Yzuxx7Q03IwZ7MQS9ZCwLtGFp0tJC1NNBr2sR1ZCZxj80
	 7Wu65uVokuyG4f2LQFTiFRxhNOdiNmrxopQGFBvLcL16lpDOo8mq7kKo540Xr+5Zo9
	 q2cY+c/uqtKYXjzWlnFEM4p+dtNQRm3Za/ozY6u/Kwg3rE3vxjO4yOYeW+UWnqKQNP
	 5MBvrchibr9Es0PVdqzo7kuOu5McC9uieDSyCXgoesPn08zdAmJNWoY4ZIm6+9EvnS
	 wsGjo/Zmng9SA==
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
Subject: [PATCH mlx5-next 4/5] net/mlx5: E-Switch, expose eswitch manager vport
Date: Tue, 28 Nov 2023 14:29:48 +0200
Message-ID: <8bb596d1f6dbd77fb611c33349bbaef08ad10052.1701172481.git.leon@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701172481.git.leon@kernel.org>
References: <cover.1701172481.git.leon@kernel.org>
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


