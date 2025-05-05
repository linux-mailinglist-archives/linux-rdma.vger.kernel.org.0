Return-Path: <linux-rdma+bounces-10035-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA38FAAB11B
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 05:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A6587B9906
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 03:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3972832BF41;
	Tue,  6 May 2025 00:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Twp6pj+H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70802BFC8F;
	Mon,  5 May 2025 22:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485319; cv=none; b=QMfY2TShf0BEjysfeEnHtubUWUjqkab28vDauruHodM+xw/WuS/a4WhCABJv35ksHNz72J6eDHUxIFSxSAQqn8shno5fWzEuEjNhgwwuzgMF+lwSEbhjRf+/4flYaByd1gDLlbK3oywe9YWhtECiFxjIsqYq5aAOmLxvD95dws8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485319; c=relaxed/simple;
	bh=aRRAC58GmU7TO84FzTLTF9KRFvbEn75CXgkjNnBxEGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C/yQEeYfzrEvoLDjsmfCq7ex8v1CBbbw8Q2ERQcM1X5hWlD45hMsnlCe/MnQelprLA9toHquqS94Rf+Rc3ZjWagZzpeVbOH9QydMKnT78SUIM2Tw8VZ4pMDTdvHAtud9FZL2+9XbWYFej1igU4HpFpDeyBE43ts0EucVGM74OCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Twp6pj+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BCBC4CEE4;
	Mon,  5 May 2025 22:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485317;
	bh=aRRAC58GmU7TO84FzTLTF9KRFvbEn75CXgkjNnBxEGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Twp6pj+HFJnwQFC3Q67Piw+X00sH23Vk+pXbPBOYKRDreQTvwuhWCPvbaSwwPbMAW
	 x1mE8yE4WzNE2bJTdIkkMuhXP/hAoDlj9yw9SnVsNDfPK0eg/PtqS2YBPKu9FAyrBw
	 s4Aa9JTYM96RibLNQ0jhv3zXhXhNU6zwqN8K4Zil9mYuAVASvp1EWgnQXIvpNo0ID8
	 yPv/PNooqI45T3KooWdwpPxRdiBjLE7pv5NctOJkFoSOr7lz6ePpCtt7MA/9cY257Q
	 Ga3lojeT1x5itq38nWLqplUd+iMbE1BzRBhKKE+6gNNnN34Jb3Mtr5Fy4OsyfGaqf3
	 QQY2KI79X5H5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	saeedm@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	rrameshbabu@nvidia.com,
	moshe@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 263/486] net/mlx5e: Add correct match to check IPSec syndromes for switchdev mode
Date: Mon,  5 May 2025 18:35:39 -0400
Message-Id: <20250505223922.2682012-263-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

[ Upstream commit 85e4a808af2545fefaf18c8fe50071b06fcbdabc ]

In commit dddb49b63d86 ("net/mlx5e: Add IPsec and ASO syndromes check
in HW"), IPSec and ASO syndromes checks after decryption for the
specified ASO object were added. But they are correct only for eswith
in legacy mode. For switchdev mode, metadata register c1 is used to
save the mapped id (not ASO object id). So, need to change the match
accordingly for the check rules in status table.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20250220213959.504304-4-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 28 ++++++++++++++-----
 .../mellanox/mlx5/core/esw/ipsec_fs.c         | 13 +++++++++
 .../mellanox/mlx5/core/esw/ipsec_fs.h         |  5 ++++
 include/linux/mlx5/eswitch.h                  |  2 ++
 4 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 57861d34d46f8..59b9653f573c8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -165,6 +165,25 @@ static void ipsec_rx_status_pass_destroy(struct mlx5e_ipsec *ipsec,
 #endif
 }
 
+static void ipsec_rx_rule_add_match_obj(struct mlx5e_ipsec_sa_entry *sa_entry,
+					struct mlx5e_ipsec_rx *rx,
+					struct mlx5_flow_spec *spec)
+{
+	struct mlx5e_ipsec *ipsec = sa_entry->ipsec;
+
+	if (rx == ipsec->rx_esw) {
+		mlx5_esw_ipsec_rx_rule_add_match_obj(sa_entry, spec);
+	} else {
+		MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
+				 misc_parameters_2.metadata_reg_c_2);
+		MLX5_SET(fte_match_param, spec->match_value,
+			 misc_parameters_2.metadata_reg_c_2,
+			 sa_entry->ipsec_obj_id | BIT(31));
+
+		spec->match_criteria_enable |= MLX5_MATCH_MISC_PARAMETERS_2;
+	}
+}
+
 static int rx_add_rule_drop_auth_trailer(struct mlx5e_ipsec_sa_entry *sa_entry,
 					 struct mlx5e_ipsec_rx *rx)
 {
@@ -200,11 +219,8 @@ static int rx_add_rule_drop_auth_trailer(struct mlx5e_ipsec_sa_entry *sa_entry,
 
 	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria, misc_parameters_2.ipsec_syndrome);
 	MLX5_SET(fte_match_param, spec->match_value, misc_parameters_2.ipsec_syndrome, 1);
-	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria, misc_parameters_2.metadata_reg_c_2);
-	MLX5_SET(fte_match_param, spec->match_value,
-		 misc_parameters_2.metadata_reg_c_2,
-		 sa_entry->ipsec_obj_id | BIT(31));
 	spec->match_criteria_enable = MLX5_MATCH_MISC_PARAMETERS_2;
+	ipsec_rx_rule_add_match_obj(sa_entry, rx, spec);
 	rule = mlx5_add_flow_rules(ft, spec, &flow_act, &dest, 1);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
@@ -281,10 +297,8 @@ static int rx_add_rule_drop_replay(struct mlx5e_ipsec_sa_entry *sa_entry, struct
 
 	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria, misc_parameters_2.metadata_reg_c_4);
 	MLX5_SET(fte_match_param, spec->match_value, misc_parameters_2.metadata_reg_c_4, 1);
-	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria, misc_parameters_2.metadata_reg_c_2);
-	MLX5_SET(fte_match_param, spec->match_value,  misc_parameters_2.metadata_reg_c_2,
-		 sa_entry->ipsec_obj_id | BIT(31));
 	spec->match_criteria_enable = MLX5_MATCH_MISC_PARAMETERS_2;
+	ipsec_rx_rule_add_match_obj(sa_entry, rx, spec);
 	rule = mlx5_add_flow_rules(ft, spec, &flow_act, &dest, 1);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
index ed977ae75fab8..4bba2884c1c05 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
@@ -85,6 +85,19 @@ int mlx5_esw_ipsec_rx_setup_modify_header(struct mlx5e_ipsec_sa_entry *sa_entry,
 	return err;
 }
 
+void mlx5_esw_ipsec_rx_rule_add_match_obj(struct mlx5e_ipsec_sa_entry *sa_entry,
+					  struct mlx5_flow_spec *spec)
+{
+	MLX5_SET(fte_match_param, spec->match_criteria,
+		 misc_parameters_2.metadata_reg_c_1,
+		 ESW_IPSEC_RX_MAPPED_ID_MATCH_MASK);
+	MLX5_SET(fte_match_param, spec->match_value,
+		 misc_parameters_2.metadata_reg_c_1,
+		 sa_entry->rx_mapped_id << ESW_ZONE_ID_BITS);
+
+	spec->match_criteria_enable |= MLX5_MATCH_MISC_PARAMETERS_2;
+}
+
 void mlx5_esw_ipsec_rx_id_mapping_remove(struct mlx5e_ipsec_sa_entry *sa_entry)
 {
 	struct mlx5e_ipsec *ipsec = sa_entry->ipsec;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
index ac9c65b89166e..514c15258b1d1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
@@ -20,6 +20,8 @@ int mlx5_esw_ipsec_rx_ipsec_obj_id_search(struct mlx5e_priv *priv, u32 id,
 void mlx5_esw_ipsec_tx_create_attr_set(struct mlx5e_ipsec *ipsec,
 				       struct mlx5e_ipsec_tx_create_attr *attr);
 void mlx5_esw_ipsec_restore_dest_uplink(struct mlx5_core_dev *mdev);
+void mlx5_esw_ipsec_rx_rule_add_match_obj(struct mlx5e_ipsec_sa_entry *sa_entry,
+					  struct mlx5_flow_spec *spec);
 #else
 static inline void mlx5_esw_ipsec_rx_create_attr_set(struct mlx5e_ipsec *ipsec,
 						     struct mlx5e_ipsec_rx_create_attr *attr) {}
@@ -48,5 +50,8 @@ static inline void mlx5_esw_ipsec_tx_create_attr_set(struct mlx5e_ipsec *ipsec,
 						     struct mlx5e_ipsec_tx_create_attr *attr) {}
 
 static inline void mlx5_esw_ipsec_restore_dest_uplink(struct mlx5_core_dev *mdev) {}
+static inline void
+mlx5_esw_ipsec_rx_rule_add_match_obj(struct mlx5e_ipsec_sa_entry *sa_entry,
+				     struct mlx5_flow_spec *spec) {}
 #endif /* CONFIG_MLX5_ESWITCH */
 #endif /* __MLX5_ESW_IPSEC_FS_H__ */
diff --git a/include/linux/mlx5/eswitch.h b/include/linux/mlx5/eswitch.h
index df73a2ccc9af3..67256e776566c 100644
--- a/include/linux/mlx5/eswitch.h
+++ b/include/linux/mlx5/eswitch.h
@@ -147,6 +147,8 @@ u32 mlx5_eswitch_get_vport_metadata_for_set(struct mlx5_eswitch *esw,
 
 /* reuse tun_opts for the mapped ipsec obj id when tun_id is 0 (invalid) */
 #define ESW_IPSEC_RX_MAPPED_ID_MASK GENMASK(ESW_TUN_OPTS_BITS - 1, 0)
+#define ESW_IPSEC_RX_MAPPED_ID_MATCH_MASK \
+	GENMASK(31 - ESW_RESERVED_BITS, ESW_ZONE_ID_BITS)
 
 u8 mlx5_eswitch_mode(const struct mlx5_core_dev *dev);
 u16 mlx5_eswitch_get_total_vports(const struct mlx5_core_dev *dev);
-- 
2.39.5


