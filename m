Return-Path: <linux-rdma+bounces-23105-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vaXxFZ2mVGpUowMAu9opvQ
	(envelope-from <linux-rdma+bounces-23105-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 10:49:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A78AE748EDF
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 10:49:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=FMktS7Sy;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23105-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23105-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E7C83052E7A
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 08:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC6C3BFAEB;
	Mon, 13 Jul 2026 08:44:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A553C09F2;
	Mon, 13 Jul 2026 08:44:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932279; cv=fail; b=Xvj/Noda7UXhvlLx8qARvvG6srjZAb5PLxim8HYmmH6QSsxKJ+KLvn9OOh4T0ZKQpuf7zP56bNvf7TC0QhX3tpM19QMT4JmPagY2yIdm+aJtXXVTWBjVzbu+hMGoTjjkIp/rRPDVi8wPhBbEFatK30sN+G6VjEo5GBVdnrY/bas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932279; c=relaxed/simple;
	bh=p9wFoVjMuFvVQ8ha8dHTnG5MYDUDPaDihpfamETzBWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HuhuGd5B+MLVtzdsguuCEQgdgf/z5f5YmAEgiVuWpj4mv0iZBtgzv72R5Vxr8fQUUQMUqxBaqSenQIuv+T64ippcL+BsG9iQQfYG9XvTLWvnu+0cOf0okW8aoHKbnftei5L75SOXPfcIC9xetV1HaFnNC7DvYiF+FPe7FQv7ybw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FMktS7Sy; arc=fail smtp.client-ip=52.101.48.36
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhmboLhFre3jDCheRdT1jmm08XAvn3WRs/SmucaItTBhFfgOskIzbR4HX8lkS08zJ8QzG6XwU6jy0DEDVq2rbBaQ2cXxxPDfL0+M0UOwt6QzaOeDrFEFvvm+je8zwE4CtmlrDBz86+dySlWpVwIP8GZisaAPFII7t+H+qE6/LlvHEjq+2jB6QHvnqp/co/l+4OpeADOZbb8hk+4BpfTZMuKlDeOOYc3FHIw/QHrlsysRmAxVtt1mDLQTYL/STtxk1PQy8ZAkd65A/ygCjgEmVXiuiEjxj+H5SKyuCRU9b/xdrl2dM67ik3Szk47p84CldYlmyvH4i2CtYqNwrOYPzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ncKCB3u9eu8r06MHmlfSbXtPeePlEfbzZY2sPNYGqo=;
 b=lteHMJ4d1webFwwWppB9Box8+OmHPzbw2ZQV1CKdG1wmGs+q3Al+A5a4wrFf61TrDzyfKQzDBIWEQVfbUUcVMVFMRQH2E8o8GhJMhr9SHdqi77Ikb5UPKF40mmhgw6AUkhiIHnw36c8hpFNllRgtoHqswy/eA+UkDvFGCFSOs3FhXxjZIU2nJZBFo3yfOu1JNy/p/roeec/GViFo1oiCvcI3Auixt7o7y9ps1SrAFoHbGUMnhLMJOSJGHu7xyWcoVhtFe80YUqDw0ZQOM+cSbjbTpLbDsa3ohRw/qfQaA1XQPzmMAQ/gioU6eHuKpCNpUspTmGBSa8UEwQzfcxmzCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ncKCB3u9eu8r06MHmlfSbXtPeePlEfbzZY2sPNYGqo=;
 b=FMktS7SyoqcWIipNf6l/Pef/2kV88qMvHGb9gDVFOlA4xqO4ojhK6/bU+DeUO7AqcMWFkqjkg/JaSmKp1TOOz8tCLKfkVI7vvZfnKaiidfWU4dY9Gw+JNIH5y0/yC8XfFSW/znst/ZUDEQwCCJjMfjjw3pH+VuL6pFqMXUh8C7axzznJf8sGKe215+oytCzmhzhsFizaTHEq+peqhgLss0Hiajf6F/Utxd2AMcwcQyyxK9nr5faFaGSAB+QTrZApfSXjOhPD7qmKyh2+HPDYoWRqRyytyaDDSqg7QDLv4F95FqyCrjtdku2NQ6XyKoA3e5Vn3eLOmRp3zIW0DwCJfA==
Received: from CY8PR12CA0057.namprd12.prod.outlook.com (2603:10b6:930:4c::24)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 08:44:18 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:4c:cafe::63) by CY8PR12CA0057.outlook.office365.com
 (2603:10b6:930:4c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 08:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 08:44:18 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 01:44:03 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 01:44:02 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 13
 Jul 2026 01:43:57 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, <linux-rdma@vger.kernel.org>, "Mark
 Bloch" <mbloch@nvidia.com>, <netdev@vger.kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Alexei Lazar <alazar@nvidia.com>, Alex Vesker <valex@nvidia.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Cosmin Ratiu <cratiu@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>, Dragos Tatulea <dtatulea@nvidia.com>, "Eric
 Dumazet" <edumazet@google.com>, Feng Liu <feliu@nvidia.com>, Jakub Kicinski
	<kuba@kernel.org>, Kees Cook <kees@kernel.org>,
	<linux-kernel@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Parav Pandit
	<parav@nvidia.com>, Shay Drory <shayd@nvidia.com>, Simon Horman
	<horms@kernel.org>, Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [PATCH mlx5-next 2/2] net/mlx5: ifc: Add PSP related fields
Date: Mon, 13 Jul 2026 11:43:20 +0300
Message-ID: <20260713084320.1015240-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260713084320.1015240-1-tariqt@nvidia.com>
References: <20260713084320.1015240-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b81d54-ab96-4b32-85b0-08dee0baed4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|1800799024|82310400026|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	UA6M24yFh9uJ63juORNBi9ixMSkvBKGVg4Wu8Sx8/R6/zzDclW2o+73vgdM2XsBSJlHAs3GuORhcZooqX4P4btog+mpjYHaIzZsfAoFM/UYfwXJjFfKS1bJ3qhlIufqAonjwoTjpsooVGQ7ISRUfpy88WyTKs06NqukMuSQJ+Z0CsYW1Gt1QKFQymjyuHM/pIq9o0warJEWG6siQbQlaFpayGMqjZJNpFqfLfYcE23nk3/mAONqgSY72lQA1CD9ny0JDy7M5rLhKRcwo5cptEsSzEcls7WxxCw9MYrZXee1+TqBxcRg+dLh0Cntx6EBWbbl8ZCBZGHxv6GyEbHA1iEXMGqWObce3OzYTfwqzlPhj8uDgFsApTmji6sf6FnW5iaCK09GgChlKs3k17OvI588RM86gBozUq8rzV41JlF5TKJM6K3CGMwO5x0Q1aqprMGvsX5IlpYoWV0CvPdkm3U3TBl0Cp6UHuZ23R9HvHhIeAIsSFjEmONoo9smp9mIDTkJ/k2Upu6Hkgb9AcTKzMZNZK1WDYIcTziJ1r98SftLYfaKG8UpRa1H+g6z3NtlwyD/dHtu5r/Dl7lzbyoWgz2/ZlNvSHNS34X1OY/Jua4mWMRZMsu/IJs7ESySb/UVq6vjpdm8ApdDcXDbbJzfFCfgaIYTzMmbz1Zh5CAZMb1fsWxKSr84O6+/Cif9jgSPv0axgUzpcncodAJvn2kiXKA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gQk3VKlzIN2nimeTmCRGosB49ncQ78Bz78rBCJ8lpfDCnvE/u8tXGJ/wjlGTeqNYhbpNDR5CtOjJgA9odoHAoXK3u+fF0Wm7QoyP+3vID3cPFFBtawhLn/k2tN9FJMrOFMdC7+VlMlA6i3/k1XF5sOLzm00UibTjC0M6IcmvxHLcCagNaVQ0DfHAAhkp1/ICQdVgRK4nvf3KlZyyBe51yPmdCB2dKufROcAGXt2tKtImTwqs0w+GXWYYs5XWkjbdnAxRTAbLeT8cSLHkLHlZTg/M96/3V37FgPxuMKdGlQf7gMaOpo27041zSIVUUbndMofFqQ8mecmYFrQgYOGAaeD1p2XEojEFD94LFjfXkEuI+ba00CR+5dGnoojhMoKjbD+U0pM0aC6O0TsuTQtLdTSiIcz8/LYe/AFNINllhtTXvMdZ3YqPNd6WLL4CsSSS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 08:44:18.1430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b81d54-ab96-4b32-85b0-08dee0baed4b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,vger.kernel.org:server fail,Nvidia.com:server fail,nvidia.com:server fail];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23105-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:netdev@vger.kernel.org,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:alazar@nvidia.com,m:valex@nvidia.com,m:andrew+netdev@lunn.ch,m:cratiu@nvidia.com,m:davem@davemloft.net,m:dtatulea@nvidia.com,m:edumazet@google.com,m:feliu@nvidia.com,m:kuba@kernel.org,m:kees@kernel.org,m:linux-kernel@vger.kernel.org,m:pabeni@redhat.com,m:parav@nvidia.com,m:shayd@nvidia.com,m:horms@kernel.org,m:kliteyn@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A78AE748EDF

From: Cosmin Ratiu <cratiu@nvidia.com>

This adds:
- misc_parameters_6, containing a few fields for matching PSP headers.
As this is the last misc_parameters field defined, retire the old
optimization added in commit [1] to not touch the reserved part.
- PSP decap action.
- PSP SPI header field pointer.

[1] commit 667cb65ae5ad ("net/mlx5: Don't store reserved part in FTEs
and FGs")

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_core.h   | 12 +-----------
 include/linux/mlx5/device.h                     |  1 +
 include/linux/mlx5/mlx5_ifc.h                   | 17 +++++++++++++++--
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index dbaf33b537f7..906584345a02 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -214,17 +214,7 @@ struct mlx5_ft_underlay_qp {
 	u32 qpn;
 };
 
-#define MLX5_FTE_MATCH_PARAM_RESERVED	reserved_at_e00
-/* Calculate the fte_match_param length and without the reserved length.
- * Make sure the reserved field is the last.
- */
-#define MLX5_ST_SZ_DW_MATCH_PARAM					    \
-	((MLX5_BYTE_OFF(fte_match_param, MLX5_FTE_MATCH_PARAM_RESERVED) / sizeof(u32)) + \
-	 BUILD_BUG_ON_ZERO(MLX5_ST_SZ_BYTES(fte_match_param) !=		     \
-			   MLX5_FLD_SZ_BYTES(fte_match_param,		     \
-					     MLX5_FTE_MATCH_PARAM_RESERVED) +\
-			   MLX5_BYTE_OFF(fte_match_param,		     \
-					 MLX5_FTE_MATCH_PARAM_RESERVED)))
+#define MLX5_ST_SZ_DW_MATCH_PARAM MLX5_ST_SZ_DW(fte_match_param)
 
 struct fs_fte_action {
 	int				modify_mask;
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 07a25f264292..8cb321a9fb3d 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -1171,6 +1171,7 @@ enum {
 	MLX5_MATCH_MISC_PARAMETERS_3	= 1 << 4,
 	MLX5_MATCH_MISC_PARAMETERS_4	= 1 << 5,
 	MLX5_MATCH_MISC_PARAMETERS_5	= 1 << 6,
+	MLX5_MATCH_MISC_PARAMETERS_6	= 1 << 7,
 };
 
 enum {
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 7de01d4f1b5e..cf01922cf69f 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -508,7 +508,8 @@ struct mlx5_ifc_flow_table_prop_layout_bits {
 	u8         reformat_l2_to_l3_audp_tunnel[0x1];
 	u8         reformat_l3_audp_tunnel_to_l2[0x1];
 	u8         ignore_flow_level_rtc_valid[0x1];
-	u8         reserved_at_70[0x8];
+	u8         reserved_at_70[0x7];
+	u8         reformat_del_psp_transport[0x1];
 	u8         log_max_ft_num[0x8];
 
 	u8         reserved_at_80[0x10];
@@ -798,6 +799,15 @@ struct mlx5_ifc_fte_match_set_misc5_bits {
 	u8         reserved_at_100[0x100];
 };
 
+struct mlx5_ifc_fte_match_set_misc6_bits {
+	u8         reserved_at_0[0x1a];
+	u8         psp_version[0x4];
+	u8         reserved_at_1e[0x2];
+
+	u8         reserved_at_20[0x1e0];
+};
+
+
 struct mlx5_ifc_cmd_pas_bits {
 	u8         pa_h[0x20];
 
@@ -2339,7 +2349,7 @@ struct mlx5_ifc_fte_match_param_bits {
 
 	struct mlx5_ifc_fte_match_set_misc5_bits misc_parameters_5;
 
-	u8         reserved_at_e00[0x200];
+	struct mlx5_ifc_fte_match_set_misc6_bits misc_parameters_6;
 };
 
 enum {
@@ -6984,6 +6994,7 @@ enum {
 	MLX5_QUERY_FLOW_GROUP_IN_MATCH_CRITERIA_ENABLE_MISC_PARAMETERS_3 = 0x4,
 	MLX5_QUERY_FLOW_GROUP_IN_MATCH_CRITERIA_ENABLE_MISC_PARAMETERS_4 = 0x5,
 	MLX5_QUERY_FLOW_GROUP_IN_MATCH_CRITERIA_ENABLE_MISC_PARAMETERS_5 = 0x6,
+	MLX5_QUERY_FLOW_GROUP_IN_MATCH_CRITERIA_ENABLE_MISC_PARAMETERS_6 = 0x7,
 };
 
 struct mlx5_ifc_query_flow_group_out_bits {
@@ -7245,6 +7256,7 @@ enum mlx5_reformat_ctx_type {
 	MLX5_REFORMAT_TYPE_REMOVE_HDR = 0x10,
 	MLX5_REFORMAT_TYPE_ADD_MACSEC = 0x11,
 	MLX5_REFORMAT_TYPE_DEL_MACSEC = 0x12,
+	MLX5_REFORMAT_TYPE_REMOVE_PSP_TRANSPORT = 0x16,
 };
 
 struct mlx5_ifc_alloc_packet_reformat_context_in_bits {
@@ -7368,6 +7380,7 @@ enum {
 	MLX5_ACTION_IN_FIELD_OUT_EMD_47_32     = 0x6F,
 	MLX5_ACTION_IN_FIELD_OUT_EMD_31_0      = 0x70,
 	MLX5_ACTION_IN_FIELD_PSP_SYNDROME      = 0x71,
+	MLX5_ACTION_IN_FIELD_PSP_HEADER_1      = 0x78,
 };
 
 struct mlx5_ifc_alloc_modify_header_context_out_bits {
-- 
2.44.0


