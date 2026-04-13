Return-Path: <linux-rdma+bounces-19282-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNGJCW3L3GmcWQkAu9opvQ
	(envelope-from <linux-rdma+bounces-19282-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 12:54:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4A53EAF09
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 12:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A1A630072B7
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 10:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4323BD640;
	Mon, 13 Apr 2026 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GdsF/U2E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013029.outbound.protection.outlook.com [40.107.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5740B362125;
	Mon, 13 Apr 2026 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077666; cv=fail; b=LjBjp9UggAWQILHGzMAubbRaV+g87HO6n5MARtXrAjtsIJOlZz6oZ9bqm1Lzc4GqV9FhVpQBpA1+BxFSzljyrT8bEWr4ZN9L+MGw2vZ/1kbve2CH/v2OxBkOga6Ef/s0iQCdxEVTDDQkzoDJZZN/kELqAo6va+FHsSUVwB0CczI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077666; c=relaxed/simple;
	bh=UKnkwYXKgII3Wxr/jo0fM0ziuPowwPJ2EbSnqJa9WUs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=esMgBDmQUwI3Ai/floHrG8q0+6BeBDDNxXtrcCjF3aldZGRNf0DWY658a/PdmRt3N5BPKBPIQ6TwqrSQI1Qe7BtvXwQy0ElGN9sZftspLd2GuY4kAOt4rfwbF1QcIrNbCUL/BZxARwFc80f6PnV0cm2I1x8XVouTHAriGiPXDkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GdsF/U2E; arc=fail smtp.client-ip=40.107.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CttOMatIfiPeKHCLjbWUc015ntut4mMttvrAxGoqPSutUyzv5tmFqHOZhHWPEGqn1JWCZlG+SJPEsaLXOX2zOoW58ccf+arGA9ORaqm2SsWPgsPPDjZN4/8UWBWeppH1m/yhwkAkqF+zr/HcSIoK9cQvNRBa3qHbRbHqRKT6y9J/GDcTGqiYsnhtgNMNtCJHZdIKG7fasqc2klKMV4mteJxzRzXLq8MKXlACMD3FhhS8mfT+j6Ikv3RLgebSk6D59thivwe6jIjC960qZqU53WT/lpHIOT636jYaxY0y79TpMmrim1jXijhWUul67lliBE0loKBGqtx7RjrZZWYaFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nldx1sLbLVJ/1qPzgjywXWzFF9Q9/+H/R9qzV3XJR7A=;
 b=C5Ruoxo7UqZfQmOaENf6r29FweHPSAPbdwEAa8tMHzcFmYVUYlFq8onMx8VQEJXCRKSukf6czhoEVnjPPydwu0+8Qt1Plpbml9e28qegSXJYqwPNskGafDkCmaYl2veuRsiI8yypkr64/OtaRp3Y49+bPi/ZSBe/hWpqsIdTP427kTD1R7+3gs4tjKQWCym5X6c8G/qf3qwTUvG1Ks6LyzdGSfexu41EnKTCUR48xkuYiofKIcimcYTBo1nG8oO0V6KE2wkYCoMbsOcO0wqpesRDUE5/JUIbpJhQBC+WjXI5XIAy6ph8LKaOJ+GK3g6T0Enez8h7QNQAdkgjcf90yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nldx1sLbLVJ/1qPzgjywXWzFF9Q9/+H/R9qzV3XJR7A=;
 b=GdsF/U2Ew+0S/i/6DPZR0zT2ioWykmUw48CVORWRf6jCatEdtqTTc1Z4gDBR3KzKe9NUA1F97F/3tTInXajdhsNI+i+51SNX4uDGu0izqKb7LNLPE1/AenwO4tcanuzKxU7hTqc//GUsgOwsJ2FRAAgvsoWAqS8+0K5rQGsfEIVtjsgzqkRWmP/hnEGRf3/+IzWMVJkWpPQ+kboqJUtHuN7tFXNTxXqrdGzh/jNOLmqKjFDX23QlRDS1JcgLELud64C2U96Mnw4CjXjlAIA+rQ8c2AhTSXapyCd15jwBqVU7+iW+e6FntqOIWa++7nwD53pXCM6415hEIK6EjtoFtA==
Received: from PH7PR13CA0002.namprd13.prod.outlook.com (2603:10b6:510:174::6)
 by PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 13 Apr
 2026 10:54:19 +0000
Received: from MW1PEPF00016160.namprd21.prod.outlook.com
 (2603:10b6:510:174:cafe::2e) by PH7PR13CA0002.outlook.office365.com
 (2603:10b6:510:174::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 10:54:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MW1PEPF00016160.mail.protection.outlook.com (10.167.249.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.0 via Frontend Transport; Mon, 13 Apr 2026 10:54:19 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Apr
 2026 03:54:09 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 13 Apr 2026 03:54:08 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Apr 2026 03:54:04 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shay
 Drory <shayd@nvidia.com>, Simon Horman <horms@kernel.org>, Kees Cook
	<kees@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net V2 2/3] net/mlx5: SD, Keep multi-pf debugfs entries on primary
Date: Mon, 13 Apr 2026 13:53:22 +0300
Message-ID: <20260413105323.186411-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260413105323.186411-1-tariqt@nvidia.com>
References: <20260413105323.186411-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF00016160:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 8064be40-46df-4ccc-0acb-08de994b036a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	X8RWsB0+iPQqi5oeiBwYFyipbfXtGmFRcI0rNoSXUvGkctSevkTkme0bsOFvaNMzvOxo8tKQxO1U2JK7RyF1RHSEIBZsduylq4FJKheJpWk2ay+NcF2hYHHd0ell9rWOYfH83W0fvAvfZUV/Ee5lOKtbkr0fehFxRffwOuDRaraOXe7dbMr6qGHnioGDOXKOxlBVSbrnSPPt8bBsxIB7dBi7YEka9ZBMugYpJRbF0V0vdIOlN38vEdytdHO9swcII1wdYFDTkb+czvyfn6P47a2x/NwguhFm0NbHxXGuMpviyHAA2Nx4q6OaPOdqzdvHoMIJ0oC7Z0aft+Yk9BoLQDS1I972oZ9fRbsoqVYM22J3Z+MZpKnxdJ78CeGbsOQeYDEavPN202avswZrKMiVvl1YoB1r/SIuNvfbtcmQrEiKubjdfjRVgQGEZw8+eZrKZFu/QlNCx7pFZ8z998bVuXvn9pn0KiMVhbA/+4q7W4xSnyDIIMMpKLd3LE/IAE7E69qOOTPY+2k45AvwCl66YiJtZU/9FWB62IvJX6nclUTwwnixWt08hDa5rc3q7XzYPajSNEn9wPBtWqO6kEzj9cct2KgEioPEG7tigU46L01JjmPC1wi7UCBwUBDIg8XJqEjFqCcNsnE4S3pCG2swMe9qZUmrnPVg2/fPCEzBEq07QgfWaJx8OYvb8JxzhwNISemWHo3ipJ9s9bsoz8AD4usEzV9bhYf0UxeZx9B8bIHNq77QBhSEVWkeAUm7p8L7Ph8v/FIj2hh1zIm8d/y5JQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BWudpMkPWRSrryMAO3uq5fbBVHMIPI+XMgL/rwnUXa0MDDl9WAZnmLQkEdzBvkMwOtICVesf4ybio+f2CB5ykiaGtKmStTAiqxCIZz7nBBxU45LMMeM8FldcAd50fcRJlbT6Y+Ps2lDFfURlzsigpa0Jh8b2ABo4BivgcpNz3E/gg08WhGqxq5hpaG31nEy4P+dScRGs9szDIrH4MnwtJdF9GBYQW90Xlj5x88KVYfGBxGEcFFrFYAZk1Cq6EVlnM8eUgH1soH52SdWdNYNkdCMlXcGKZ3nHpKjcGToBumpK8npva2YANIsCAWf4DD75cd4QVcilnDHdvubECpGBGw+ZcVBZZAE7pdo0yGReTRZQju2S/FDd5OxjLfRe6N1wgKuCA1awhQ2uwouAH2WETjSneRSzKreNt5rGo0epccvKSLjB+e3eJZe0u/yDVhN2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 10:54:19.0883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8064be40-46df-4ccc-0acb-08de994b036a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00016160.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19282-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6E4A53EAF09
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
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index a34860ad231a..a5e2e0a411df 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -465,9 +465,13 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
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
@@ -477,7 +481,8 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 			goto err_unset_secondaries;
 
 		snprintf(name, sizeof(name), "secondary_%d", i - 1);
-		debugfs_create_file(name, 0400, sd->dfs, pos, &dev_fops);
+		debugfs_create_file(name, 0400, primary_sd->dfs, pos,
+				    &dev_fops);
 
 	}
 
@@ -495,7 +500,8 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	mlx5_sd_for_each_secondary_to(i, primary, to, pos)
 		sd_cmd_unset_secondary(pos);
 	sd_cmd_unset_primary(primary);
-	debugfs_remove_recursive(sd->dfs);
+	debugfs_remove_recursive(primary_sd->dfs);
+	primary_sd->dfs = NULL;
 err_sd_unregister:
 	mlx5_devcom_comp_unlock(sd->devcom);
 	sd_unregister(dev);
@@ -520,14 +526,14 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
 
 	primary = mlx5_sd_get_primary(dev);
 	primary_sd = mlx5_get_sd(primary);
-
 	if (primary_sd->state != MLX5_SD_STATE_UP)
 		goto out_unlock;
 
 	mlx5_sd_for_each_secondary(i, primary, pos)
 		sd_cmd_unset_secondary(pos);
 	sd_cmd_unset_primary(primary);
-	debugfs_remove_recursive(sd->dfs);
+	debugfs_remove_recursive(primary_sd->dfs);
+	primary_sd->dfs = NULL;
 
 	sd_info(primary, "group id %#x, uncombined\n", sd->group_id);
 	primary_sd->state = MLX5_SD_STATE_DESTROYING;
-- 
2.44.0


