Return-Path: <linux-rdma+bounces-13063-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C6AB4153C
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 08:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB6C5E7765
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 06:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CE82D7DFF;
	Wed,  3 Sep 2025 06:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rT4K4aO4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D690D19F12A;
	Wed,  3 Sep 2025 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756881089; cv=none; b=DInyANQAHEQqa/1hqh+oKETXizuB83mebatJfhlvW+zoE+GGHcAncXgdEj/TSmhyF3ylSRLxRyHlIoPFWj0ihat+A2/gT/unVPn+llvGITKmWw6jT3xY9d/Wfpw1IZdul6TnRYhRtB6FMPII484p6mowl2cYX/tUi+q169fZQDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756881089; c=relaxed/simple;
	bh=ldislTIt+17gO2sVf1eVo5RITYkzJQ6Xjsnbxe8sLgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ll8JhtKcqxQiuSNs2Upx13SaVf90i45IduKKBv//FuYbgR3LuYNSipnm1Wqzs/zYyR5i0QQqqEOymcpqthgRj/f6rHYAykHoDdyJLxFbHnK3mXPq+72pY2cneKLa53ixWaMp2YNCERvGKJ8ziP+ndS/T4QAkSQEU2Ti6NvygN4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rT4K4aO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B7CC4CEF0;
	Wed,  3 Sep 2025 06:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756881088;
	bh=ldislTIt+17gO2sVf1eVo5RITYkzJQ6Xjsnbxe8sLgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rT4K4aO4GfuAXb/TeKFqa6NWGxW6ZQv3WbZZr4nKPcI76lspWISAz9YqyJupyYmHJ
	 s3+BttvuS1sTpmFNMlJ++nNx9JK/WT95CQx+3vaPsnMyYiBTb5rj5ZNjRJiqUC4zDN
	 N/0txuV019o59RZcTF8iADecJF3Brbyl/uTni6eaxEpMWU3XCNdOqYH1AdyShH1y0/
	 21xFCcEtE/W25LbDmO1kfVkjIqOzpMwWIVWTN6VhOXI4K/1jJ/DHLE31lKNyJBhg4s
	 PxAfPw8ed8CThGbNSY3yENccSTlZzGWD7IASM5Qb5sgLzPpoLKh2POH29go9KSS6q8
	 Me85sMK9zO71g==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>,
	netdev@vger.kernel.org,
	mbloch@nvidia.com,
	Tariq Toukan <tariqt@nvidia.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Raed Salem <raeds@nvidia.com>
Subject: [PATCH 1/1] net/mlx5: Add PSP capabilities structures and bits
Date: Tue,  2 Sep 2025 23:30:50 -0700
Message-ID: <20250903063050.668442-2-saeed@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250903063050.668442-1-saeed@kernel.org>
References: <20250903063050.668442-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Add mlx5_ifc PSP related capabilities structures and HW definitions
needed for PSP support in mlx5.

Link: https://lore.kernel.org/netdev/20250828162953.2707727-1-daniel.zahka@gmail.com/
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |  6 ++
 .../net/ethernet/mellanox/mlx5/core/main.c    |  1 +
 .../mellanox/mlx5/core/steering/hws/definer.c |  2 +-
 include/linux/mlx5/device.h                   |  4 +
 include/linux/mlx5/mlx5_ifc.h                 | 95 ++++++++++++++++++-
 5 files changed, 103 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index 57476487e31f..eeb4437975f2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -294,6 +294,12 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 			return err;
 	}
 
+	if (MLX5_CAP_GEN(dev, psp)) {
+		err = mlx5_core_get_caps(dev, MLX5_CAP_PSP);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 8517d4e5d5ef..0951c7cc1b5f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1798,6 +1798,7 @@ static const int types[] = {
 	MLX5_CAP_VDPA_EMULATION,
 	MLX5_CAP_IPSEC,
 	MLX5_CAP_PORT_SELECTION,
+	MLX5_CAP_PSP,
 	MLX5_CAP_MACSEC,
 	MLX5_CAP_ADV_VIRTUALIZATION,
 	MLX5_CAP_CRYPTO,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
index c6436c3a7a83..c4bb6967f74d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
@@ -1280,7 +1280,7 @@ hws_definer_conv_misc2(struct mlx5hws_definer_conv_data *cd,
 	struct mlx5hws_definer_fc *fc = cd->fc;
 	struct mlx5hws_definer_fc *curr_fc;
 
-	if (HWS_IS_FLD_SET_SZ(match_param, misc_parameters_2.reserved_at_1a0, 0x8) ||
+	if (HWS_IS_FLD_SET_SZ(match_param, misc_parameters_2.psp_syndrome, 0x8) ||
 	    HWS_IS_FLD_SET_SZ(match_param,
 			      misc_parameters_2.ipsec_next_header, 0x8) ||
 	    HWS_IS_FLD_SET_SZ(match_param, misc_parameters_2.reserved_at_1c0, 0x40) ||
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 9d2467f982ad..72a83666e67f 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -1248,6 +1248,7 @@ enum mlx5_cap_type {
 	MLX5_CAP_IPSEC,
 	MLX5_CAP_CRYPTO = 0x1a,
 	MLX5_CAP_SHAMPO = 0x1d,
+	MLX5_CAP_PSP = 0x1e,
 	MLX5_CAP_MACSEC = 0x1f,
 	MLX5_CAP_GENERAL_2 = 0x20,
 	MLX5_CAP_PORT_SELECTION = 0x25,
@@ -1487,6 +1488,9 @@ enum mlx5_qcam_feature_groups {
 #define MLX5_CAP_SHAMPO(mdev, cap) \
 	MLX5_GET(shampo_cap, mdev->caps.hca[MLX5_CAP_SHAMPO]->cur, cap)
 
+#define MLX5_CAP_PSP(mdev, cap)\
+	MLX5_GET(psp_cap, (mdev)->caps.hca[MLX5_CAP_PSP]->cur, cap)
+
 enum {
 	MLX5_CMD_STAT_OK			= 0x0,
 	MLX5_CMD_STAT_INT_ERR			= 0x1,
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 44d497272162..e9f14a0c7f4f 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -314,6 +314,8 @@ enum {
 	MLX5_CMD_OP_CREATE_UMEM                   = 0xa08,
 	MLX5_CMD_OP_DESTROY_UMEM                  = 0xa0a,
 	MLX5_CMD_OP_SYNC_STEERING                 = 0xb00,
+	MLX5_CMD_OP_PSP_GEN_SPI                   = 0xb10,
+	MLX5_CMD_OP_PSP_ROTATE_KEY                = 0xb11,
 	MLX5_CMD_OP_QUERY_VHCA_STATE              = 0xb0d,
 	MLX5_CMD_OP_MODIFY_VHCA_STATE             = 0xb0e,
 	MLX5_CMD_OP_SYNC_CRYPTO                   = 0xb12,
@@ -489,12 +491,14 @@ struct mlx5_ifc_flow_table_prop_layout_bits {
 	u8         execute_aso[0x1];
 	u8         reserved_at_47[0x19];
 
-	u8         reserved_at_60[0x2];
+	u8         reformat_l2_to_l3_psp_tunnel[0x1];
+	u8         reformat_l3_psp_tunnel_to_l2[0x1];
 	u8         reformat_insert[0x1];
 	u8         reformat_remove[0x1];
 	u8         macsec_encrypt[0x1];
 	u8         macsec_decrypt[0x1];
-	u8         reserved_at_66[0x2];
+	u8         psp_encrypt[0x1];
+	u8         psp_decrypt[0x1];
 	u8         reformat_add_macsec[0x1];
 	u8         reformat_remove_macsec[0x1];
 	u8         reparse[0x1];
@@ -703,7 +707,7 @@ struct mlx5_ifc_fte_match_set_misc2_bits {
 
 	u8         metadata_reg_a[0x20];
 
-	u8         reserved_at_1a0[0x8];
+	u8         psp_syndrome[0x8];
 	u8         macsec_syndrome[0x8];
 	u8         ipsec_syndrome[0x8];
 	u8         ipsec_next_header[0x8];
@@ -1511,6 +1515,21 @@ struct mlx5_ifc_macsec_cap_bits {
 	u8    reserved_at_40[0x7c0];
 };
 
+struct mlx5_ifc_psp_cap_bits {
+	u8         reserved_at_0[0x1];
+	u8         psp_crypto_offload[0x1];
+	u8         reserved_at_2[0x1];
+	u8         psp_crypto_esp_aes_gcm_256_encrypt[0x1];
+	u8         psp_crypto_esp_aes_gcm_128_encrypt[0x1];
+	u8         psp_crypto_esp_aes_gcm_256_decrypt[0x1];
+	u8         psp_crypto_esp_aes_gcm_128_decrypt[0x1];
+	u8         reserved_at_7[0x4];
+	u8         log_max_num_of_psp_spi[0x5];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x7e0];
+};
+
 enum {
 	MLX5_WQ_TYPE_LINKED_LIST  = 0x0,
 	MLX5_WQ_TYPE_CYCLIC       = 0x1,
@@ -1876,7 +1895,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 
 	u8         reserved_at_2a0[0x7];
 	u8         mkey_pcie_tph[0x1];
-	u8         reserved_at_2a8[0x3];
+	u8         reserved_at_2a8[0x2];
+
+	u8         psp[0x1];
 	u8         shampo[0x1];
 	u8         reserved_at_2ac[0x4];
 	u8         max_wqe_sz_rq[0x10];
@@ -3803,6 +3824,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
 	struct mlx5_ifc_ipsec_cap_bits ipsec_cap;
+	struct mlx5_ifc_psp_cap_bits psp_cap;
 	u8         reserved_at_0[0x8000];
 };
 
@@ -3832,6 +3854,7 @@ enum {
 enum {
 	MLX5_FLOW_CONTEXT_ENCRYPT_DECRYPT_TYPE_IPSEC   = 0x0,
 	MLX5_FLOW_CONTEXT_ENCRYPT_DECRYPT_TYPE_MACSEC  = 0x1,
+	MLX5_FLOW_CONTEXT_ENCRYPT_DECRYPT_TYPE_PSP     = 0x2,
 };
 
 struct mlx5_ifc_vlan_bits {
@@ -7159,6 +7182,8 @@ enum mlx5_reformat_ctx_type {
 	MLX5_REFORMAT_TYPE_DEL_ESP_TRANSPORT_OVER_UDP = 0xa,
 	MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_OVER_IPV6 = 0xb,
 	MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_OVER_UDPV6 = 0xc,
+	MLX5_REFORMAT_TYPE_ADD_PSP_TUNNEL = 0xd,
+	MLX5_REFORMAT_TYPE_DEL_PSP_TUNNEL = 0xe,
 	MLX5_REFORMAT_TYPE_INSERT_HDR = 0xf,
 	MLX5_REFORMAT_TYPE_REMOVE_HDR = 0x10,
 	MLX5_REFORMAT_TYPE_ADD_MACSEC = 0x11,
@@ -7285,6 +7310,7 @@ enum {
 	MLX5_ACTION_IN_FIELD_IPSEC_SYNDROME    = 0x5D,
 	MLX5_ACTION_IN_FIELD_OUT_EMD_47_32     = 0x6F,
 	MLX5_ACTION_IN_FIELD_OUT_EMD_31_0      = 0x70,
+	MLX5_ACTION_IN_FIELD_PSP_SYNDROME      = 0x71,
 };
 
 struct mlx5_ifc_alloc_modify_header_context_out_bits {
@@ -13079,6 +13105,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_TLS = 0x1,
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_IPSEC = 0x2,
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_MACSEC = 0x4,
+	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_PSP = 0x6,
 };
 
 struct mlx5_ifc_tls_static_params_bits {
@@ -13496,4 +13523,64 @@ enum mlx5e_pcie_cong_event_mod_field {
 	MLX5_PCIE_CONG_EVENT_MOD_THRESH   = BIT(2),
 };
 
+struct mlx5_ifc_psp_rotate_key_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x40];
+};
+
+struct mlx5_ifc_psp_rotate_key_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x40];
+};
+
+enum mlx5_psp_gen_spi_in_key_size {
+	MLX5_PSP_GEN_SPI_IN_KEY_SIZE_128 = 0x0,
+	MLX5_PSP_GEN_SPI_IN_KEY_SIZE_256 = 0x1,
+};
+
+struct mlx5_ifc_key_spi_bits {
+	u8         spi[0x20];
+
+	u8         reserved_at_20[0x60];
+
+	u8         key[8][0x20];
+};
+
+struct mlx5_ifc_psp_gen_spi_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x20];
+
+	u8         key_size[0x2];
+	u8         reserved_at_62[0xe];
+	u8         num_of_spi[0x10];
+};
+
+struct mlx5_ifc_psp_gen_spi_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x10];
+	u8         num_of_spi[0x10];
+
+	u8         reserved_at_60[0x20];
+
+	struct mlx5_ifc_key_spi_bits key_spi[];
+};
+
 #endif /* MLX5_IFC_H */
-- 
2.50.1


