Return-Path: <linux-rdma+bounces-8151-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B941A46001
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 14:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C051C3AEAFE
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 13:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F762185B8;
	Wed, 26 Feb 2025 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUr4YRdJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F71913AA2A;
	Wed, 26 Feb 2025 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574917; cv=none; b=ha3hhh0P8xpMxPoLILOg8fIphsYnO5Ju34WRtP43vDCogskKNsiVfhV8rFwbxfFGGB0c1nmi+TstrfdfluiHdfcRHmF8wujZBKfvQFHsJa97KQnlvebpbmKChG/HfbdxL8PqGnkpTAXs+bYRIs2FY1LZVqgELd1KfTt9lxEmGig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574917; c=relaxed/simple;
	bh=S5F9bhYUkyfLnfVjHMnI/n8VWOJwPBOi+YoqTk9KjuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agKzG6GqEGkkGfkKKTCjmuRBR7uLC+KPY2QdZrtbdN9QXJ/Eb2j4R5ascGQCtT85h0BZJdJklkaDGLQlE9yAvVROO5all6N2uq/2FLR69TqZBYFn2cEDhaoib1LpZhpAtLBtdc3ommv4yNuCK/IgGaI5/k6t6E9TX4CUjWEIOUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUr4YRdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D4AC4CED6;
	Wed, 26 Feb 2025 13:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740574917;
	bh=S5F9bhYUkyfLnfVjHMnI/n8VWOJwPBOi+YoqTk9KjuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GUr4YRdJtGHmR8+L8K1HPI9DcrjUusk4NvsavLRwlq2QYO9wEiAU8wQLs00DFoEvc
	 XiVstNLDcrFO52GIrCfEP1LaLzYCR6br5/O3+8eWp+fSBAX0fPWJ/55yMSIGS+JbQg
	 RcHqBxqhYFn/wi+YzmhlO7z0S4IcGJ67u+TExAi/n1lDVWBEZNaTQDQ82LzWYAE4nM
	 56NmVqX4Yp3/uhc7Zwvgq1nTgrHrIfSuOIjEyTjIjD/9hJ832QuF7PK5W9bbKpmk7A
	 5l9GgqyGVEBV8/qTw0HeTnxchWtE1R0zRTJMDPIkxAkNAENlB3kzrLUibUZC1U3uWP
	 MS1eulEgS4rcw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next 4/5] net/mlx5: Query ADV_RDMA capabilities
Date: Wed, 26 Feb 2025 15:01:08 +0200
Message-ID: <e3e6ede03ea31cd201078dcdd4e407608e4a5a87.1740574103.git.leon@kernel.org>
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

From: Patrisious Haddad <phaddad@nvidia.com>

Query ADV_RDMA capabilities which provide information for
advanced RDMA related features.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |  7 ++++
 .../net/ethernet/mellanox/mlx5/core/main.c    |  1 +
 include/linux/mlx5/device.h                   |  5 +++
 include/linux/mlx5/mlx5_ifc.h                 | 42 ++++++++++++++++++-
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index b253d1673398..57476487e31f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -287,6 +287,13 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 			return err;
 	}
 
+	if (MLX5_CAP_GEN(dev, adv_rdma)) {
+		err = mlx5_core_get_caps_mode(dev, MLX5_CAP_ADV_RDMA,
+					      HCA_CAP_OPMOD_GET_CUR);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index ec956c4bcebd..af0b677393d0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1795,6 +1795,7 @@ static const int types[] = {
 	MLX5_CAP_ADV_VIRTUALIZATION,
 	MLX5_CAP_CRYPTO,
 	MLX5_CAP_SHAMPO,
+	MLX5_CAP_ADV_RDMA,
 };
 
 static void mlx5_hca_caps_free(struct mlx5_core_dev *dev)
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index fd37f4e54d76..0ae6d69c5221 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -1251,6 +1251,7 @@ enum mlx5_cap_type {
 	MLX5_CAP_GENERAL_2 = 0x20,
 	MLX5_CAP_PORT_SELECTION = 0x25,
 	MLX5_CAP_ADV_VIRTUALIZATION = 0x26,
+	MLX5_CAP_ADV_RDMA = 0x28,
 	/* NUM OF CAP Types */
 	MLX5_CAP_NUM
 };
@@ -1384,6 +1385,10 @@ enum mlx5_qcam_feature_groups {
 	MLX5_GET(adv_virtualization_cap, \
 		 mdev->caps.hca[MLX5_CAP_ADV_VIRTUALIZATION]->cur, cap)
 
+#define MLX5_CAP_ADV_RDMA(mdev, cap) \
+	MLX5_GET(adv_rdma_cap, \
+		 mdev->caps.hca[MLX5_CAP_ADV_RDMA]->cur, cap)
+
 #define MLX5_CAP_FLOWTABLE_PORT_SELECTION(mdev, cap) \
 	MLX5_CAP_PORT_SELECTION(mdev, flow_table_properties_port_selection.cap)
 
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 3b3d88ffcacc..fea8af42f954 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1993,7 +1993,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         max_geneve_tlv_options[0x8];
 	u8         reserved_at_568[0x3];
 	u8         max_geneve_tlv_option_data_len[0x5];
-	u8         reserved_at_570[0x9];
+	u8         reserved_at_570[0x1];
+	u8         adv_rdma[0x1];
+	u8         reserved_at_572[0x7];
 	u8         adv_virtualization[0x1];
 	u8         reserved_at_57a[0x6];
 
@@ -13076,6 +13078,44 @@ struct mlx5_ifc_load_vhca_state_out_bits {
 	u8         reserved_at_40[0x40];
 };
 
+struct mlx5_ifc_adv_rdma_cap_bits {
+	u8         rdma_transport_manager[0x1];
+	u8         rdma_transport_manager_other_eswitch[0x1];
+	u8         reserved_at_2[0x1e];
+
+	u8         rcx_type[0x8];
+	u8         reserved_at_28[0x2];
+	u8         ps_entry_log_max_value[0x6];
+	u8         reserved_at_30[0x6];
+	u8         qp_max_ps_num_entry[0xa];
+
+	u8         mp_max_num_queues[0x8];
+	u8         ps_user_context_max_log_size[0x8];
+	u8         message_based_qp_and_striding_wq[0x8];
+	u8         reserved_at_58[0x8];
+
+	u8         max_receive_send_message_size_stride[0x10];
+	u8         reserved_at_70[0x10];
+
+	u8         max_receive_send_message_size_byte[0x20];
+
+	u8         reserved_at_a0[0x160];
+
+	struct mlx5_ifc_flow_table_prop_layout_bits rdma_transport_rx_flow_table_properties;
+
+	struct mlx5_ifc_flow_table_prop_layout_bits rdma_transport_tx_flow_table_properties;
+
+	struct mlx5_ifc_flow_table_fields_supported_2_bits rdma_transport_rx_ft_field_support_2;
+
+	struct mlx5_ifc_flow_table_fields_supported_2_bits rdma_transport_tx_ft_field_support_2;
+
+	struct mlx5_ifc_flow_table_fields_supported_2_bits rdma_transport_rx_ft_field_bitmask_support_2;
+
+	struct mlx5_ifc_flow_table_fields_supported_2_bits rdma_transport_tx_ft_field_bitmask_support_2;
+
+	u8         reserved_at_800[0x3800];
+};
+
 struct mlx5_ifc_adv_virtualization_cap_bits {
 	u8         reserved_at_0[0x3];
 	u8         pg_track_log_max_num[0x5];
-- 
2.48.1


