Return-Path: <linux-rdma+bounces-8147-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C74A45FFA
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 14:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7FE177F32
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 13:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CB621884A;
	Wed, 26 Feb 2025 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRnuafyE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104A576035;
	Wed, 26 Feb 2025 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574899; cv=none; b=hjqa9MBkduVsuystcBPjz+57GNtFNKtZlYO+066/xE7uM1HdnZSWHwrUlZFXU5m+90JkGGnTaWwurjh9XPpkeXcfGVnxj+pQmrjWKnIrtvCG4znim6k2XAu3GNVWXaM3DWYw1GUYMbKTjHiGHg5Ce3NwgdxYI7u6cW6SV2muqDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574899; c=relaxed/simple;
	bh=V7a7tW5zyMDWmz+fgaPP7yrvrVUcpG6OC5kD4ULtQgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3GZ1rtP0fMX2lwetmb9sBu+S9OWt4UvUP2UT0clMiAHb+em/q0lsvmp+nHTdz2Yhv31HZ2dw8vn3q64ILT+jS69BJ3McQsLQHFDCQRMn6eXg0Z7NbxEdtECfSjqR14ayKLbKLLr2dVKhuC0oW9h2EIDLtdxiv7G7knNT7MeeII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRnuafyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFF4C4CEE4;
	Wed, 26 Feb 2025 13:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740574898;
	bh=V7a7tW5zyMDWmz+fgaPP7yrvrVUcpG6OC5kD4ULtQgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QRnuafyElJSpiMJDlU/zNen2PenJjoA97jVrDlnM3NUD+XkywjPpMIl6Am8Q158e1
	 wqfxQFlC74Ys8/5wXQMtj5iMNhzEQgswGXtJ9uIi2/6/L/L75JY6li7W8+Fo1XasEh
	 5XRqCI3x1R9xkLtw4OzuuRJylJgp5eKbLfceNnzKFpIkbZjWtYMP6I6cuKyrDVTLaj
	 EVSO3Qjriba72dzJ9mEWspmlbEnoQdJ5EfEueRlzIDZdpQ7bV0s+G1EX4HKJdgtvJr
	 YUG7vWWlW2Qf1c2yBQdiFMn1jam43Pn4XkaTyd75lRIKC5fVWDrvd+BkppEReQctGZ
	 W0wg6S+Dnu2Ww==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Moshe Shemesh <moshe@nvidia.com>,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next 1/5] net/mlx5: Add RDMA_CTRL HW capabilities
Date: Wed, 26 Feb 2025 15:01:05 +0200
Message-ID: <ef7eb24be9a6f247ab52e8b4480350072e5182f5.1740574103.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740574103.git.leon@kernel.org>
References: <cover.1740574103.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chiara Meiohas <cmeiohas@nvidia.com>

Add RDMA_CTRL UCTX capabilities and add the RDMA_CTRL general object
type in hca_cap_2.

Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index cc2875e843f7..3b3d88ffcacc 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1570,6 +1570,8 @@ enum {
 enum {
 	MLX5_UCTX_CAP_RAW_TX = 1UL << 0,
 	MLX5_UCTX_CAP_INTERNAL_DEV_RES = 1UL << 1,
+	MLX5_UCTX_CAP_RDMA_CTRL = 1UL << 3,
+	MLX5_UCTX_CAP_RDMA_CTRL_OTHER_VHCA = 1UL << 4,
 };
 
 #define MLX5_FC_BULK_SIZE_FACTOR 128
@@ -2140,7 +2142,8 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8	   log_min_mkey_entity_size[0x5];
 	u8	   reserved_at_1b0[0x10];
 
-	u8	   reserved_at_1c0[0x60];
+	u8	   general_obj_types_127_64[0x40];
+	u8	   reserved_at_200[0x20];
 
 	u8	   reserved_at_220[0x1];
 	u8	   sw_vhca_id_valid[0x1];
@@ -12494,6 +12497,10 @@ enum {
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = BIT_ULL(0x24),
 };
 
+enum {
+	MLX5_HCA_CAP_2_GENERAL_OBJECT_TYPES_RDMA_CTRL = BIT_ULL(0x13),
+};
+
 enum {
 	MLX5_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = 0xc,
 	MLX5_GENERAL_OBJECT_TYPES_IPSEC = 0x13,
@@ -12501,6 +12508,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = 0x24,
 	MLX5_GENERAL_OBJECT_TYPES_MACSEC = 0x27,
 	MLX5_GENERAL_OBJECT_TYPES_INT_KEK = 0x47,
+	MLX5_GENERAL_OBJECT_TYPES_RDMA_CTRL = 0x53,
 	MLX5_GENERAL_OBJECT_TYPES_FLOW_TABLE_ALIAS = 0xff15,
 };
 
-- 
2.48.1


