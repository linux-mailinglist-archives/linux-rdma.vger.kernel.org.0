Return-Path: <linux-rdma+bounces-20402-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Iob3GJAYAmqonwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20402-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 19:57:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F60513ED8
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 19:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE32C3178519
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 17:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADF0453482;
	Mon, 11 May 2026 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RWuL58Et"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011004.outbound.protection.outlook.com [52.101.62.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C36F423A6B;
	Mon, 11 May 2026 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520498; cv=fail; b=szA8AAMaBodrnLLsoJVcIyoFqa2eoxrMy7WSzydDwYHw0urzA1NAuIMr/5OBcR3SYq33FefonzOIpKNYGS9NqUi/IyUymP+hQG9hbjRwOzCAS5MH/k/dhsVUsYF3litt3fHYd9Mo8RW5QnbpZHQiM00nkx51WDFT1Yv4uWtnkd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520498; c=relaxed/simple;
	bh=j0hWcyxBhOe0kRaP6PKvt4WzdK1lqWTDxwKgB9Sj8ro=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e109eNUeLFi6NnQH88v46cmL2zrSVBtEy/1kLqVKlSAvnISXQ9zrDeU4lVvfKzkjqcGxNe4jx6RsmJ304zgJxwulN3472B84/uDET/bNC1hj5M5oUxnOTontB0oTs+dN/4JtGQWUHZHv9i62fJAt1bJpWm+DPkU8WK67+xMya5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RWuL58Et; arc=fail smtp.client-ip=52.101.62.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kb1al1RTxdf/Rwuob1pXtYhHQfa7NDK7uSeJZnwhWKvpFyAR5npBvADp4oFwu5iPRwzopItmSM0jKXUJx9+vNcRE6kX/hVj6kVbpZvBwgFnA5V7NwMQvAZaciyb55zqjXt0SzyLYiXlIvbP9GRfF/ytYtgkXEhh5iFZdDtpHkWyso281ko1LG+myTMbeb26d7biQG2J7EftFhQX59scuua5We4Jbet2rCfYwnPIFLnzUunK26IUFp7JN1BOrUm4V8YnoVySuWfciZ0izoUhRtIy+sWwMc/jj+Udrbtp5Jfn/UIy1On5f63i7CvBvSkDgJ4oyK34iTe8FxYZ/4Tg5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPMHpKixMFUSjdcyz3H6k8vSL0myZb7T/kys3I+1VYk=;
 b=eq5FVwivk3QFNdMCsrKFonYOB6k219YqfQJAaGWvBzVHuqGLkM+P0nJTyfQH1SBF83BdvaLyMDSQK+kiTEXveRJ+F9sBYKw2QoSZDiR3Ar4KKmW/VrjbRNvwPhj7OjuK9zu4rnSIkzzf4j46bU3sOHD/n2Lws2WfNx1Lw79XtMnwOeFq9Y5u4ph7tmm2rJfKpoe77VU9AYAgykzivuNIUqfnz0ValPcocArM8uFFK18SzhwsVe+E3yT9hZgwwbUz8Phk//GEUlLN8Ce+K1Tmeax/4lULEP4FBuIBbPIuPFrq33ZVGVExZjEhe9Cxl65THJmkc7MwCKrz9PYmn6SRIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPMHpKixMFUSjdcyz3H6k8vSL0myZb7T/kys3I+1VYk=;
 b=RWuL58EtbwzeD+uUHhSZEqF6oZPjYAVPlxLUIULy8C2mDdxZxe6IcmOHxdrHhXtp5Q+bYEFH0yZsobdjjDGDhpmzEl71TXqYlMdhkUu5jwrhZBqmKMxu/CvP+4rrWnIDICBcxtSqEPRjbssjiOJZ29grcbdb/69U3Wo+iGvpq3HUvBzwJ3xOa0L6weAMLAXpAUdbmmId7Qkx4mdVyqzls2qia93A/l7BzpTixZtyrxKhW6bDyYThyEi8uP1hk/i9PjqJBhlo0p3WrLnHHDrJKzLn8swUQ71zdtzAOJA0Sz5qOvuCDfg1cxihTms5fgci1pj9qLJ9XmBpACfs8X+eVg==
Received: from SJ0PR05CA0011.namprd05.prod.outlook.com (2603:10b6:a03:33b::16)
 by DS0PR12MB7826.namprd12.prod.outlook.com (2603:10b6:8:148::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 17:28:06 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::83) by SJ0PR05CA0011.outlook.office365.com
 (2603:10b6:a03:33b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Mon,
 11 May 2026 17:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 17:28:05 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 10:27:44 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 10:27:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 11
 May 2026 10:27:39 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Simon Horman <horms@kernel.org>, Gal Pressman
	<gal@nvidia.com>, Kees Cook <kees@kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 1/5] net/mlx5e: remove channel count limit for XOR8 RSS hash
Date: Mon, 11 May 2026 20:27:15 +0300
Message-ID: <20260511172719.330490-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260511172719.330490-1-tariqt@nvidia.com>
References: <20260511172719.330490-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|DS0PR12MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: e66f99ef-0eb9-4eb4-8b2a-08deaf82a99b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	tgvARal6la+2HLQ7msL/1ECGn9mDt6qmNVCken2oZ21Ve2o1p0L+X2auokKbA83oKbE3V88tSe0npwUqiYlw40GS9L8BleJmI8srfYBd7bd0D3dhtcjJUi2DRaPsOJFznL/rCNcoB5uURmIP9h+ISJtGg8xyHLzdeI7qe+Owv65NCovAEj6FtS5cGAQvb8RvSiPfqQ8a7rIp/OX1Dzre+U3jvPjLFDcucnpUl9fUe5FO0kw6//lpHj0Eocx1Sz3zyp1S0/5jnVsGb9cr8p/IuxDj3u4eD+DtFGHHa7TJ8znp/pQB3wH1trYOnIBN6LrC1pQoUtuH8OUUkarAIT9w5qBbx+vOfgoK+9iJCczdeftII6DfX2uv3EEbeHwDp4xA99uNe8bYOHSoXL1me0G9jLLxBdbbHtQxKxPCFwgwjx9xg70j2J4HqNdGxaN+4lIGD5CH4VHyMaMWmvF1ZoCGQninE+CqaUyLnre/+udXN66WrKfsuJJ0s0oLSqPPxHgmh7TJQ5MnnNrKHNyKfLat7fFV1i7Aq7zMqxS5YKaaZgWu51lBWmMNDBNRfYZW83f+OIR/8J7d3/QTMNL0vSkCGZDVnpzl2XAtz24hyYlB8TISDElCoqjujkw6LEcYHJZTeVPAWjgdtLDRAJSEnJWE9He/jDMNwbnGbcW79LkxEO0wW3POVLwjXvjNJkd7kqTnvIQGpR3NuRjD1Jnz2/SqXcIdo/jZeI5VnAxsDSMRtAY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zWn1D8mlzaxjLw43jQ96Owgtfl+HiU37IPj+8MWnFAn+SMagUIB7BSsHC+vMaMf0/ywMEJW0zlBrU+f9ruaVSv0o5N8tV8dwGatVEstu7WOql0KQg4CMyTa3TtYP4DaLhTUSnHfg5p7eguMNz3fRjTvvQfL0fDhLVonKDEPYp40zaJIDll3L+GD/3EM7pj30VgzPbcPnZviqm+zsWI18zOlBorypsAEPycY3m4LrfyTmmT8BdnUA+pEV9pYv1Kiqc7LtmyAOyArCp+LcvKW6U7hDJxQZjXiJmQZ5TLyNGhG+IKjiIB9YUmbgwC2M19jwHQ2AuxP4m4GPsQ1c+6+rithLrXeu6Uj3wV7MBYLbmydpSIfX5/2xnMNQdgMIcm9Jt1VDm1FrZSgjhmVMHf5cXLHhqIDtOPBNG77iQQSF1vnKQL8F7VpVY2qBxLon29UM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 17:28:05.8035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e66f99ef-0eb9-4eb4-8b2a-08deaf82a99b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7826
X-Rspamd-Queue-Id: 07F60513ED8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20402-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Yael Chemla <ychemla@nvidia.com>

mlx5e_ethtool_set_channels() and mlx5e_rxfh_hfunc_check() rejected
channel counts that would produce an indirection table larger than 256
entries when the XOR8 hash function was active. This check was
introduced in commit 49e6c9387051 ("net/mlx5e: RSS, Block XOR hash
with over 128 channels").

XOR8 yields an 8-bit hash, so in practice only up to 256 entries in the
indirection table can be reached due to limited entropy. However, this
does not provide a strong justification for prohibiting larger
indirection tables. Remove the limitation.

Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/rqt.c  |  7 ---
 .../net/ethernet/mellanox/mlx5/core/en/rqt.h  |  1 -
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 48 -------------------
 3 files changed, 56 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c
index 8d9a3b5ec973..bcafb4bf9415 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c
@@ -179,13 +179,6 @@ u32 mlx5e_rqt_size(struct mlx5_core_dev *mdev, unsigned int num_channels)
 	return min_t(u32, rqt_size, max_cap_rqt_size);
 }
 
-#define MLX5E_MAX_RQT_SIZE_ALLOWED_WITH_XOR8_HASH 256
-
-unsigned int mlx5e_rqt_max_num_channels_allowed_for_xor8(void)
-{
-	return MLX5E_MAX_RQT_SIZE_ALLOWED_WITH_XOR8_HASH / MLX5E_UNIFORM_SPREAD_RQT_FACTOR;
-}
-
 void mlx5e_rqt_destroy(struct mlx5e_rqt *rqt)
 {
 	mlx5_core_destroy_rqt(rqt->mdev, rqt->rqtn);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h
index 2f9e04a8418f..e0bc30308c77 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h
@@ -38,7 +38,6 @@ static inline u32 mlx5e_rqt_get_rqtn(struct mlx5e_rqt *rqt)
 }
 
 u32 mlx5e_rqt_size(struct mlx5_core_dev *mdev, unsigned int num_channels);
-unsigned int mlx5e_rqt_max_num_channels_allowed_for_xor8(void);
 int mlx5e_rqt_redirect_direct(struct mlx5e_rqt *rqt, u32 rqn, u32 *vhca_id);
 int mlx5e_rqt_redirect_indir(struct mlx5e_rqt *rqt, u32 *rqns, u32 *vhca_ids,
 			     unsigned int num_rqns,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index bb61e2179078..a6da0219723c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -511,17 +511,6 @@ int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
 
 	mutex_lock(&priv->state_lock);
 
-	if (mlx5e_rx_res_get_current_hash(priv->rx_res).hfunc == ETH_RSS_HASH_XOR) {
-		unsigned int xor8_max_channels = mlx5e_rqt_max_num_channels_allowed_for_xor8();
-
-		if (count > xor8_max_channels) {
-			err = -EINVAL;
-			netdev_err(priv->netdev, "%s: Requested number of channels (%d) exceeds the maximum allowed by the XOR8 RSS hfunc (%d)\n",
-				   __func__, count, xor8_max_channels);
-			goto out;
-		}
-	}
-
 	/* If RXFH is configured, changing the channels number is allowed only if
 	 * it does not require resizing the RSS table. This is because the previous
 	 * configuration may no longer be compatible with the new RSS table.
@@ -1501,29 +1490,6 @@ static int mlx5e_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *
 	return 0;
 }
 
-static int mlx5e_rxfh_hfunc_check(struct mlx5e_priv *priv,
-				  const struct ethtool_rxfh_param *rxfh,
-				  struct netlink_ext_ack *extack)
-{
-	unsigned int count;
-
-	count = priv->channels.params.num_channels;
-
-	if (rxfh->hfunc == ETH_RSS_HASH_XOR) {
-		unsigned int xor8_max_channels = mlx5e_rqt_max_num_channels_allowed_for_xor8();
-
-		if (count > xor8_max_channels) {
-			NL_SET_ERR_MSG_FMT_MOD(
-				extack,
-				"Number of channels (%u) exceeds the max for XOR8 RSS (%u)",
-				count, xor8_max_channels);
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
-
 static int mlx5e_set_rxfh(struct net_device *dev,
 			  struct ethtool_rxfh_param *rxfh,
 			  struct netlink_ext_ack *extack)
@@ -1535,16 +1501,11 @@ static int mlx5e_set_rxfh(struct net_device *dev,
 
 	mutex_lock(&priv->state_lock);
 
-	err = mlx5e_rxfh_hfunc_check(priv, rxfh, extack);
-	if (err)
-		goto unlock;
-
 	err = mlx5e_rx_res_rss_set_rxfh(priv->rx_res, rxfh->rss_context,
 					rxfh->indir, rxfh->key,
 					hfunc == ETH_RSS_HASH_NO_CHANGE ? NULL : &hfunc,
 					rxfh->input_xfrm == RXH_XFRM_NO_CHANGE ? NULL : &symmetric);
 
-unlock:
 	mutex_unlock(&priv->state_lock);
 	return err;
 }
@@ -1561,10 +1522,6 @@ static int mlx5e_create_rxfh_context(struct net_device *dev,
 
 	mutex_lock(&priv->state_lock);
 
-	err = mlx5e_rxfh_hfunc_check(priv, rxfh, extack);
-	if (err)
-		goto unlock;
-
 	err = mlx5e_rx_res_rss_init(priv->rx_res, rxfh->rss_context,
 				    priv->channels.params.num_channels);
 	if (err)
@@ -1601,16 +1558,11 @@ static int mlx5e_modify_rxfh_context(struct net_device *dev,
 
 	mutex_lock(&priv->state_lock);
 
-	err = mlx5e_rxfh_hfunc_check(priv, rxfh, extack);
-	if (err)
-		goto unlock;
-
 	err = mlx5e_rx_res_rss_set_rxfh(priv->rx_res, rxfh->rss_context,
 					rxfh->indir, rxfh->key,
 					hfunc == ETH_RSS_HASH_NO_CHANGE ? NULL : &hfunc,
 					rxfh->input_xfrm == RXH_XFRM_NO_CHANGE ? NULL : &symmetric);
 
-unlock:
 	mutex_unlock(&priv->state_lock);
 	return err;
 }
-- 
2.44.0


