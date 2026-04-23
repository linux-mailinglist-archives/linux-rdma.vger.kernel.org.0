Return-Path: <linux-rdma+bounces-19498-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JO9KaoR6mn4sgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19498-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 14:33:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 518E4452049
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 14:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 004E6303D2D6
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 12:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE203ED13A;
	Thu, 23 Apr 2026 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AMJuvUBN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012002.outbound.protection.outlook.com [40.107.200.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34BE3EAC62;
	Thu, 23 Apr 2026 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947533; cv=fail; b=JvQAMdovpig8l25n05d2Ua7WUSST7GPOFa9Mo6SUWdfpHUezcMGRjVNYI4+FuEVCXAujRyR1IFamj+qkYxZkMc592t8DrLmRxztWVdKGlp/vNJhMdVSTIhGJC9CdeQmjBMonyAbfMm6ZWL9t6xaT21wFJElIQcfH6wk0kO1Ut/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947533; c=relaxed/simple;
	bh=9LI4vzEcq8HkfaZG1HAzmXy4oDfUq1rTUzf+9nHVVi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dstLTWK+3vZx3KVpLfizCCz6odYaObBkLcHkcE1y+vUrplxL88miC3n9SZxDdc/iIZxBqG6KW/o53ICyXq7IfydJLPx7T6IsQauaTFKNDM0RyJkdeS4uN7Zv6YgVEtFY7DqwRtZheSwvJlnQmhAkMLfOMGiEzVshqSUqgvlAXi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AMJuvUBN; arc=fail smtp.client-ip=40.107.200.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqwVoYTvQyOSzNLME0L0VCxVPhvFblFflTVolQcN4jl136bDFgrllWQjvH55D3JJZTdomRn2oKI9gtWJwjcp4esqFV9PP6s0vFpV3jT4UvsMrp8xFPg8+TGFbpxdzWro3mouHEvW3+J+bkJqw15Nd4wLo46FzlCGypDzRzcCNGLTzuKVXgdN7n4WlyvgwlBO9PgGTQe7ksuiYlM+lJpFPFBb7E3pzv/DzfnpMfavVdufYo7N98Q0SsFR182IUjMGXp550fyGMX569tRJI/1SXeEZ6g9awrMrHl9XMf9niMaSpqfkAjY2QLf2h1Xt4WetM0XdpYDeE5NYPNcacxlTdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLSUU+SCmQRrivzKcCaZS63S+iTwbnaYpAhkt99feCI=;
 b=FkH74lW04jfY47p0QwBOSUyqamkPZ50nvQtl8rGvOZFxbSPU8oRBKV515zje2f1my6nZBAQAc5RoXLemTKVxukcKbrse+MOiha7Mp0OV+h+NMn91H1iXM7KkEL9qHIL30UadnPvCJPfPZoWhHZ/9Q3I7lIgMGc2cQrUbHrUeXFV8nrJxFLRZFmECnhqfS6O16zGIP11bJ9RMH7L/Jphfuyvi8Dw6gW2ULGtmSEdlHK6SzrDUAxZOgGKkbpMdDURl4VcVNMG5POplGo+hTTVXHmBbGQWaUeu1o00XiAaUIxyKoXUVyfk7PYp/OpSiCtccsYjiaITenpUUR4us9qGRCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLSUU+SCmQRrivzKcCaZS63S+iTwbnaYpAhkt99feCI=;
 b=AMJuvUBNU01A0xhbU63WPpz8EoNAL2wGWplGXx5dELiwwZLJ0SyavqUTRho+22Y1XN8L/hZIvYqs2Sr+x+IlizA+OOr1YlX4LV6Y6MiA0DHBof1QKY/gi6/LwN6ssOTV0hLyWDtj/Dk9ItpqEcY2CLzlqwyzulylFgbrhTh2464Om0pCDTD2BYk4qOtLy6wcX72WiTwZdKiMQBXAcRLbQr94+CDgN/xW0E19Kr5qsRheqMI3J85ezr6cvmAvaFwzusNl+y1lQ7oNGjPpnlGBr02RGNt6VBUVcIDhQ/4++qx8Z0jlBIqpD2glwGlXUZg0Mzvyi03S04DjCkGUSUwF9A==
Received: from BN8PR04CA0058.namprd04.prod.outlook.com (2603:10b6:408:d4::32)
 by PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Thu, 23 Apr
 2026 12:32:04 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:d4:cafe::2d) by BN8PR04CA0058.outlook.office365.com
 (2603:10b6:408:d4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Thu,
 23 Apr 2026 12:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.4 via Frontend Transport; Thu, 23 Apr 2026 12:32:04 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Apr
 2026 05:31:44 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 23 Apr 2026 05:31:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Apr 2026 05:31:40 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shay
 Drory <shayd@nvidia.com>, Simon Horman <horms@kernel.org>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Gal Pressman <gal@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net V3 2/4] net/mlx5: SD, Keep multi-pf debugfs entries on primary
Date: Thu, 23 Apr 2026 15:31:02 +0300
Message-ID: <20260423123104.201552-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260423123104.201552-1-tariqt@nvidia.com>
References: <20260423123104.201552-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|PH8PR12MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c09bdd-ab2b-4578-e408-08dea1345355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZUkllDIa2rrf+lZrMDYJVW7aW29dCZgo6IQDaF59KdYcM4FnihcWxTQth6bIm8ny1j6dCqGCkvhSM6fYx3KbjEfpTuPTJ0cDKfPHU/LC0LDWV0+vv1lSNzOhxcR1qShbAsaoOUKfrP9Z4qJZF35OhevNjxysew0Uys90uxr+UK9drsbrE85QHnCv//3UlYTkUNaQEUdPCJMsXRTQ/KGiA/EZa9cdWJ/35A8p/wRPWEtxJBSDTD9K5kyAqN/Fc/JtT6aG7PGsho9OiUvr4fUyzCXi2tZOoIFQCDN741jatZnh8I2+42vNfHH3F0oVZI469BBqgVb55l2AF+NnEi7S7+xOgjgiRAB7eFqNWayFZqCfwNpWZWYUdj+bgnC0LJNQkwiQfl/YLN5lX+/QtGodGkfURpzZEubhxIy9x+ODC4mPDL1xS/+aMq7B8eHaw1nIt/hkJ+b/VWGajEdKTTqn27LP6lxjmRU+hR+oWYMUfxLzOCuAjcGADcPpT7RSAcpvnUTI3GIuhsr1mQdV91AOK9vOWjsAnNr/g+uuiBuuRseqHQVKzembZhk6+bhX9S6h0u2lxb2DyxWbahuRjcb19xA0fXq5j825GaSSVxuuvo/d1CGQ6KOSGBFCCfb77jMY1oHxOmA4J40i7e72QnvPLa2riFMpg+SW3+F/O1HxcybAO3bOY8BP+7YXScRvRNpISgPt2K+lZ6Xh7LiHllDjIZC1IOMolylJw83DcJwRG9pesjDkcmywvqpH2TmN/K8FwkUld3Vc6OryCqLZsWnwkg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Md5nIH7oT91qJci63UvzpmraIgmSS1mL+iGkTD+Wu12CaOw7hJxpBFJSCwoZJeBjgZaChX+OH+5wDo9whtgb6P641oWeNwqbW/usRViE28CjmPXh5c9SLXCPbP8ZGu8gc5pDaYndbNuCbNZMAxvQwXAjyaWODYK1f83F1745Z8w809O8FFH303LmlOFZymL2Jv9oH9wKdQsx/Sh58i9f+vDdIxBL7dEBWECd6xzigTAgO8urCu7md4TYMQuUvGZijpAkVnN0lvlqfbmvcdi6IaeOkwr9Tc6LTmpFtsDNMJ+BkY+47EandQFzpuBAG6z1cMym4vejORE6b5f4A7u74AwT1oWVgAji9gPL4vFC6PYw6p0mklHAjGYK94AfTYmwBPA7ZBYCmDiSxAZP9ZfcYy4czFP7dlNlt8NiDX4PyKaPemD50UezdXz6o9q6NpAz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 12:32:04.0224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c09bdd-ab2b-4578-e408-08dea1345355
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6939
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
	TAGGED_FROM(0.00)[bounces-19498-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 518E4452049
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

mlx5_sd_init() creates the "multi-pf" debugfs directory under the
primary device debugfs root, but stored the dentry in the calling
device's sd struct. When sd_cleanup() run on a different PF,
this leads to using the wrong sd->dfs for removing entries, which
results in memory leak and an error in when re-creating the SD.[1]

Fix it by explicitly storing the debugfs dentry in the primary
device sd struct and use it for all per-group files.

[1]
debugfs: 'multi-pf' already exists in '0000:08:00.1'

Fixes: 4375130bf527 ("net/mlx5: SD, Add debugfs")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 96b4316f570e..897b0d81b27d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -461,9 +461,13 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	if (err)
 		goto err_sd_unregister;
 
-	sd->dfs = debugfs_create_dir("multi-pf", mlx5_debugfs_get_dev_root(primary));
-	debugfs_create_x32("group_id", 0400, sd->dfs, &sd->group_id);
-	debugfs_create_file("primary", 0400, sd->dfs, primary, &dev_fops);
+	primary_sd->dfs =
+		debugfs_create_dir("multi-pf",
+				   mlx5_debugfs_get_dev_root(primary));
+	debugfs_create_x32("group_id", 0400, primary_sd->dfs,
+			   &primary_sd->group_id);
+	debugfs_create_file("primary", 0400, primary_sd->dfs, primary,
+			    &dev_fops);
 
 	mlx5_sd_for_each_secondary(i, primary, pos) {
 		char name[32];
@@ -473,7 +477,8 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 			goto err_unset_secondaries;
 
 		snprintf(name, sizeof(name), "secondary_%d", i - 1);
-		debugfs_create_file(name, 0400, sd->dfs, pos, &dev_fops);
+		debugfs_create_file(name, 0400, primary_sd->dfs, pos,
+				    &dev_fops);
 
 	}
 
@@ -491,7 +496,8 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	mlx5_sd_for_each_secondary_to(i, primary, to, pos)
 		sd_cmd_unset_secondary(pos);
 	sd_cmd_unset_primary(primary);
-	debugfs_remove_recursive(sd->dfs);
+	debugfs_remove_recursive(primary_sd->dfs);
+	primary_sd->dfs = NULL;
 err_sd_unregister:
 	mlx5_devcom_comp_set_ready(sd->devcom, false);
 	mlx5_devcom_comp_unlock(sd->devcom);
@@ -520,7 +526,8 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
 	mlx5_sd_for_each_secondary(i, primary, pos)
 		sd_cmd_unset_secondary(pos);
 	sd_cmd_unset_primary(primary);
-	debugfs_remove_recursive(sd->dfs);
+	debugfs_remove_recursive(primary_sd->dfs);
+	primary_sd->dfs = NULL;
 
 	sd_info(primary, "group id %#x, uncombined\n", sd->group_id);
 	primary_sd->state = MLX5_SD_STATE_DOWN;
-- 
2.44.0


