Return-Path: <linux-rdma+bounces-19157-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABgRO+OU12mGPwgAu9opvQ
	(envelope-from <linux-rdma+bounces-19157-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 14:00:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAB93C9FD2
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 14:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D455F3031389
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 11:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7953C5DDB;
	Thu,  9 Apr 2026 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BNpBcVx4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011063.outbound.protection.outlook.com [40.93.194.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006943C4548;
	Thu,  9 Apr 2026 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735858; cv=fail; b=cWWn4d6ed3w6fMKMc0fp4qumGOFYwRhlQhb1nH7/elVzAvWuEQTUxRyWHzYX5Mgx/718qdPLrz3f3D5tQc1Yd6ZeNYkZpnAF4p+tXrVhuAuWOyuZCEYT9lP8iQaLR3CG6+Aw/26BuhDVBcoXGH1OIz1EMvJaDdBBfEcuaH6fj28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735858; c=relaxed/simple;
	bh=LYR/ltn4CMagiED1G8lcP62zqYnBR4eBjbaF2yFTxgg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qF7DiMVw/m0EsRjZZdNcnsg43B89gAWogOKh7GEXnQy3gvnwlo06oSLJjZp8lMV70xNAdAqefIhvnkcfgieQxkd0LUcL5+cbxfcfdKog8Wjp9+Ep5l5KrTaK+8kATowTDeUwR5ZJdwHzY1GVlAtoZhwJxqJKMJ5MvrWLB9+QBCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BNpBcVx4; arc=fail smtp.client-ip=40.93.194.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uet7qfMpkC/9EHqLnMny1acg+muxWJnNot7505qrk5NxnnSzHWN2c885uz0tAqhTwQjjcwN/t7+zBlIRWzw+ZXwnJqn4lPyFp2LILJ09ViiWAdIwDvpZQ6YUuA+fYxY/erLVyPhOTxJuH/gi2bR5QbrQCNR9DCYcf9wsKM2Qrp7pIN4XBMufoVIOt79BdQvVCA15YXkv6QHi0QP/cTSMk0Ar7QcmbrqUn2jznsWRVUPqhpcU3fhe61XKy5xjXOAm4+ko8exu6k9Bg5LlCL25xL6M/xn12IA8ikb7KED0AQEoaEsb4sbMsq/1yQsnIvi0wsoAiIcP4Q60W8wZCU9TSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cI6quZi1k4VuvNG5W2limgcbOJynwR6mNWHPHwrN0R8=;
 b=R1IMxSadloDh/9REJDvqOc0QEGgzF0HtuJy2auAifUUfp/D4ITxQF0b4EKfvG+/u1aPZGiYrjd78xgK0T4WjueITXjZjukTkJkHDvMOTFpeZ3dR0V4WOkrxzmUCgjJibN+LQO72skyClCLSmrbWxXvtKnxcQFR6qsSZ9GvsXxI7fIBx8jiq3EdGFEqFqziinH9ksuBogmjDXuDV36gj1foYpOOPzG98Q8n5OLQPdsdOxd3K8z1MnqWFtjTvTDraMvTyzUVKbB/mPu46mnQioIK0LMoPLOpM//4zb0cm6Q2Nz9/fZ3tdw8nd2HFS0/lZZZo6Jgxjs1Uwb1ogKGPXnhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cI6quZi1k4VuvNG5W2limgcbOJynwR6mNWHPHwrN0R8=;
 b=BNpBcVx4TF9dMcsRGT626CcyFyBp56+pdRSsrCdLxCdXh2ozO1vO+eZ7w7U4tpbpYuhoM/Yb1TPbAnE6TLQI+K67kfCElXf9fgMEsR5KU19AF8nWxGvV3OaeeO2nqwcqDvty+3Uj0PbvqQCslOa6sDil/MicSOWpqeolpS+JxFNsbmBbVw2TRz8FdzSapg/YyezY0yFKezqgVLLAnZBOzszJS7hxAwDM5XRHWVkWw4EH9y/o6XwNU2L0BmRLNgluwqpHoIYQxe0pzfhue5+BJ29/XymWsp/5oJM4JPw4fmCLd/hkp/QCdDk2+dgZtrCR7/Qrx40lilSKrW8ikTGF+Q==
Received: from BYAPR03CA0022.namprd03.prod.outlook.com (2603:10b6:a02:a8::35)
 by SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 9 Apr
 2026 11:57:28 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a02:a8:cafe::42) by BYAPR03CA0022.outlook.office365.com
 (2603:10b6:a02:a8::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 11:57:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 11:57:28 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 04:57:13 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 9 Apr 2026 04:57:12 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 04:57:06 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Gerd Bayer
	<gbayer@linux.ibm.com>, Parav Pandit <parav@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next 7/7] net/mlx5: Add profile to auto-enable switchdev mode at device init
Date: Thu, 9 Apr 2026 14:55:50 +0300
Message-ID: <20260409115550.156419-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260409115550.156419-1-tariqt@nvidia.com>
References: <20260409115550.156419-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f0a6bdf-ae38-425f-b55a-08de962f2c47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	37/R/MgZmBakGszC1A7D59A7VWx9cFQrRTKq/oq5yl50ELHgSWvHOVwHZKj8McbDKLtwwP+OyIoOnEeUSb02LiCp37rJ223pQXO/lqdP28czVJY29JOjV/6tZ5yYkGVKbukgaJq58ydvv3otfYxMqCE5ZIKHs5iKpK/lVXwvZlnP/HMh4J64XFATZ/j0A3S8ZIHEKgrzvMJGa6ASUX3tuhlTp89rgZYiwrw+EKcrExLM6M5+eEkdaV4flF+JdehEY0zI2Q8iTinQtc7O9nwxewCjO4lhHhI5LubRg+1KE2v0vCgSGH0hfnz5RReg8pnQXeud7X1WHHebOD+LFm5xmE2/3+Fzl+WPSWWzkRBxojKO1ncDzlFef6d5QXEiTDaSZmvndjyHbCOcdFiLxCeKDqwAZv5W6dMPXloe7ce/PKcTNX50KoB/iM5oIHce55MfzcU9cEgvVUb5iU1Jl4dv3feX+WSUMNS4DIJZiqm73GPUVzkQbCToOq4bHjn9l/bXJ4r0hMfsdhKUp6OQdXMob315QmOFMhI05gRA0fbniQmV6t5wsfyZWUOoK6vIys7uXcuaUzU3noiwYXe/U6QeJBGC500lmIKRwTM8kmzP6lOK7hRwrF02GYk83XrGSY9Szph8yNShyG8sro6gplRwt/7+I158lUPxqT2MPJmC88PzD2t6P6Ij+hnGNSTk4AKYiVwcD6xTER+alOW+18ulpL4SdhOFzOVb8pNGY8rtK6nqrFKAxcUy5e1CRogXj5lDrGgIaZjFKtPRl8Ag08iLkA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8i4eO/VxYEWwjj9RcjJl+2/mi4YOXYqOsi0rI+zgFSrkKfOUFLLTOTmXzM79nyPkCaab3U9ZtcY1Rj4TvTTg9DhQBT0cujCTof2GcUJVVu5G6eTNe3YMdbBVe8drsTxL9nHdx+/6QOh+ITuS9G0mpDe8vnSguTJELj6SB5Kdv0grNBWpQ2fBX7tyZp1pn08QzP4eVWsDVlxEm3umSS6d9qhrt7e1amNuQjfOVvjKpl6+EDVAUjqyZdy1guhEU1CPo0T1Yy1/mDfmAMnrI8fTAVC87y9eLqTXtU2429wXJ4dDssF4Ej4ciqTFSVuNgdo0whpLNkhiPBxZSroXtP4YWNC6RU9fN+G8VZ3UUOwnyt0YyWqLZPSUoJIetM7sh78FFEZBqmxXdkKENJbXCh6yxLvhOXFCIIjM3pvqUXvu92Wg8SmDiJTu2hOlZqxsoFln
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 11:57:28.3506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0a6bdf-ae38-425f-b55a-08de962f2c47
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19157-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8FAB93C9FD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mark Bloch <mbloch@nvidia.com>

Deployments that always operate in switchdev mode currently require
manual devlink configuration after driver probe, which complicates
automated provisioning.

Introduce MLX5_PROF_MASK_DEF_SWITCHDEV, a new profile mask bit, and
profile index 4. When a device is initialized or reloaded with this
profile, the driver automatically switches the e-switch to switchdev
mode by calling mlx5_devlink_eswitch_mode_set() immediately after
bringing the device online.

A no-op stub of mlx5_devlink_eswitch_mode_set() is added for builds
without CONFIG_MLX5_ESWITCH.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  6 +++++
 .../net/ethernet/mellanox/mlx5/core/main.c    | 26 ++++++++++++++++++-
 include/linux/mlx5/driver.h                   |  1 +
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 256ac3ad37bc..5dcca59c3125 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -1047,6 +1047,12 @@ mlx5_esw_lag_demux_rule_create(struct mlx5_eswitch *esw, u16 vport_num,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline int
+mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
+			      struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_MLX5_ESWITCH */
 
 #endif /* __MLX5_ESWITCH_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index dc7f20a357d9..12f39b4b6c2a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -86,7 +86,7 @@ MODULE_PARM_DESC(debug_mask, "debug mask: 1 = dump cmd data, 2 = dump cmd exec t
 
 static unsigned int prof_sel = MLX5_DEFAULT_PROF;
 module_param_named(prof_sel, prof_sel, uint, 0444);
-MODULE_PARM_DESC(prof_sel, "profile selector. Valid range 0 - 2");
+MODULE_PARM_DESC(prof_sel, "profile selector. Valid range 0 - 4");
 
 static u32 sw_owner_id[4];
 #define MAX_SW_VHCA_ID (BIT(__mlx5_bit_sz(cmd_hca_cap_2, sw_vhca_id)) - 1)
@@ -185,6 +185,11 @@ static struct mlx5_profile profile[] = {
 		.log_max_qp	= LOG_MAX_SUPPORTED_QPS,
 		.num_cmd_caches = 0,
 	},
+	[4] = {
+		.mask = MLX5_PROF_MASK_DEF_SWITCHDEV | MLX5_PROF_MASK_QP_SIZE,
+		.log_max_qp = LOG_MAX_SUPPORTED_QPS,
+		.num_cmd_caches = MLX5_NUM_COMMAND_CACHES,
+	},
 };
 
 static int wait_fw_init(struct mlx5_core_dev *dev, u32 max_wait_mili,
@@ -1451,6 +1456,17 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
 	mlx5_free_bfreg(dev, &dev->priv.bfreg);
 }
 
+static void mlx5_set_default_switchdev(struct mlx5_core_dev *dev)
+{
+	int err;
+
+	err = mlx5_devlink_eswitch_mode_set(priv_to_devlink(dev),
+					    DEVLINK_ESWITCH_MODE_SWITCHDEV,
+					    NULL);
+	if (err && err != -EOPNOTSUPP)
+		mlx5_core_warn(dev, "failed setting switchdev as default\n");
+}
+
 int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
 {
 	bool light_probe = mlx5_dev_is_lightweight(dev);
@@ -1497,6 +1513,10 @@ int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
 		mlx5_core_err(dev, "mlx5_hwmon_dev_register failed with error code %d\n", err);
 
 	mutex_unlock(&dev->intf_state_mutex);
+
+	if (dev->profile.mask & MLX5_PROF_MASK_DEF_SWITCHDEV)
+		mlx5_set_default_switchdev(dev);
+
 	return 0;
 
 err_register:
@@ -1598,6 +1618,10 @@ int mlx5_load_one_devl_locked(struct mlx5_core_dev *dev, bool recovery)
 		goto err_attach;
 
 	mutex_unlock(&dev->intf_state_mutex);
+
+	if (dev->profile.mask & MLX5_PROF_MASK_DEF_SWITCHDEV)
+		mlx5_set_default_switchdev(dev);
+
 	return 0;
 
 err_attach:
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 1268fcf35ec7..cfbc0ff6292a 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -706,6 +706,7 @@ struct mlx5_st;
 enum {
 	MLX5_PROF_MASK_QP_SIZE		= (u64)1 << 0,
 	MLX5_PROF_MASK_MR_CACHE		= (u64)1 << 1,
+	MLX5_PROF_MASK_DEF_SWITCHDEV    = (u64)1 << 2,
 };
 
 enum {
-- 
2.44.0


