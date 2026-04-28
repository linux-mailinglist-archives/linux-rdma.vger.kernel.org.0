Return-Path: <linux-rdma+bounces-19639-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DLdBwVO8GkcRgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19639-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 08:04:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D44A047DDFF
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 08:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BC263051D8C
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 06:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865D7349B02;
	Tue, 28 Apr 2026 06:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TYemepbf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA2B345CC0;
	Tue, 28 Apr 2026 06:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777356164; cv=fail; b=GivXXOFxco6/TlEBLgcHCihd9uBOI+1WusNYx03e4G9yiypAqMuBSzihG1T5jLazlhHAMyViP7XApr2AxSlXO95QAzj7p1G0rxX+u3Xh3jNZtofW+K58ZvWIUbkTbGBfXemF0553Fp6H+7TCKcG/Dy4/fGC70fplayKJLFLwhlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777356164; c=relaxed/simple;
	bh=mPpKJ3WMvPWHhFcyep2W4+MK4KvLiomlJsaHvhLNO8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qvsNc18S1a84OK2qUxyGLxFqbkr2FomuMNXMk9ZdHkIRkb52tjj/CL1xXSqdT6sHOf/vC0C0Sn8zPQixrRVEZlSZeaT6YfxtovpFP9DUpS0V8U4vGvp/vWWm/UNpbTQg3o1WGPJyG3RaYub5uvzTcMQ+rnLh2MX1FR8NwdlEciE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TYemepbf; arc=fail smtp.client-ip=52.101.56.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frHZKJAAYroB7TEMq2ix5+7lRhHRh43lVTRD6l9LG49EGq0g3LzmVilha6EuBYtRogOBDK67VLGQ3Vf1bb790nsZ3Yl9f0kB+jlf5UASixwtM4ZXh+JAnxcAVeP/rS7XImKULbjf2MRMp5Vz5thAQifBLpsz2DNucX1NbQLyEztbRE9vgS4sNCcNcueDYmf/1TZMZZjSf4wEppXuNLFdfL71YIw+VmRY2hdQnQLiOmc9ZMh7s6nuGTiq8Ml2/lmBAkXjPglAPUMLdAtNxq6VE7Sp7pdccMet2e8nk43D5uDIcRzV+MrIj+Isjh2azvW7sW73odMWZ+tvW/z8RiGU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3JEqkxsHPlJOZ5Rl7+T9q7BGhO12RFswsuVwgPlLy8=;
 b=Jh26AfoR+40mM2D12c11JlPxQTz8GOy3EBD/d7RsusSAaAezUhUJsNUzxHIK7XqZh9IBsdtAcIVmOamPMqGx3E927CycXzWBCB00Gq1w89E/rSh98pOrK7THpj54Yj6hM4rWE7u1NiaVYE1qDu2H/N3lzwf5New6fSpzhmEd5CMhTrv9FO/lH6BWW120WzUPWxe6k8/ZJMctFB1yZJL+KcvY5Chf0M2qQYWJ97kQDHfuaa5dPagNnb2ruLx0JxrkbLXkD/zFywqnMBEtB9mSSiBOZcFEf4BZSziCyYDHwbbnIKZzow8BsYWhB8s4s68OJ/1gdH3BsUsdiS++5oaj4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3JEqkxsHPlJOZ5Rl7+T9q7BGhO12RFswsuVwgPlLy8=;
 b=TYemepbfxtjCxkqVl//nznQRMDje44ixtDAtUc8GRYF88hlQjc7UmOW5cZfp90YBUE2mX1nsq20J7ddh9sp+380/PDrpL2vIsnyIJhvx4A8Aa6kuqqVZ3V1N7aY0NuRchJrs7FhaKz0dEMbxlhxe4oXlvrtrbUzNITA6fV83r9LXy+z6UMN2Rl/HB1Dt65whZPrcSVVx8CZpHoWAJ+Kh68dfVAsPlwkmZsWHjoNStM60wxvPSbQnHi0AeX8pBvSmScQQjq3PBSFT5lgJTgeCj9mz6cPHJT5arZKiw/Y7+8zOohYoE5C73Gtl3Ga1I8XgX5htRMzuduDt6RpntqKHnA==
Received: from SJ0PR13CA0173.namprd13.prod.outlook.com (2603:10b6:a03:2c7::28)
 by SA5PPF8DEAB7A29.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Tue, 28 Apr
 2026 06:02:32 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::e7) by SJ0PR13CA0173.outlook.office365.com
 (2603:10b6:a03:2c7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 06:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 06:02:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 23:02:11 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 23:02:11 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Apr 2026 23:02:06 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shay
 Drory <shayd@nvidia.com>, Simon Horman <horms@kernel.org>, Patrisious Haddad
	<phaddad@nvidia.com>, Kees Cook <kees@kernel.org>, Parav Pandit
	<parav@nvidia.com>, Gal Pressman <gal@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net V4 2/4] net/mlx5: SD, Keep multi-pf debugfs entries on primary
Date: Tue, 28 Apr 2026 09:01:09 +0300
Message-ID: <20260428060111.221086-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260428060111.221086-1-tariqt@nvidia.com>
References: <20260428060111.221086-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|SA5PPF8DEAB7A29:EE_
X-MS-Office365-Filtering-Correlation-Id: cd082292-71bf-48f5-b81c-08dea4ebbc9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	OqFaZccP/Dyj8XcYuNGW8ladkhZLs3dbbNHmYLQkxO54IYSTJwriDPKTfk8/lBAmEYQlbQj4uAp3IABc6UhtRlQe/89+JSL/FkfhFuGyTCgECUh0AyzXKDtfeUr2BkkYRHxEywspW6NgYUhkkku7FAdTJDLTltvG7HZ6hVu+F85tay1pLRL5jvjxm3nwN6hE/i+KoirTUFKifVYdnDNAUlNmmfBQatrIwUK8Jr9F+IsKRWCc5o5+EjrCt5HXJXA4WyuWYLhUdQ7R+vjJTNGcm75Lg7IDONibJ4auPsOIV00V0smF2B3uvl08I9i1ul00sBhCg/PT/FePM+fxeqI9FGCkVcm2be5+Hge3AybsOuc/bVmsRJQKHQRSX9q4Y1a3hZ1iznaNqh16/FuybRDOMF4ZdToxy3M0YTH3S5KGhvvK4qpWX0rv1b8ByXFmiSrzoJQXVpdZKpg/AiFHVMufee7IdSSHLpLcVVfU6KOIYfFBzYjppOpbaHOtilbj/1dTNBQ3qIf+NF0LutLNskyI/LJ5TJFLzKuTuememLQRj5FK9DOTKGoOge44MO33GYezn74qWrD8aUoihzxqw0cRsSjePbKl1Hyi7/BfrOU2l1O834u/9WDrUm+hYEoQrjByJ+QRPwmboao2J8W9lCx/GyATDesRcHH3iQZbLQQoalrLZII6KIjTCKYrYE7bViObaXq890AD9y/brCmBo7oYpCAiN0zFZwNN4ldvPITT2DbmmY98Mvq867P/HhIOrQ0RQ4vR6R/4AxopaWj17cBYDw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XDN3X6eNVhaG1A8Zz8BR3SinP/0oFS5Rs5L1o4ca2WdCSm91kpoE9ad0wGHQ2bmtjzOJbIomZa0K2hTsWPPWg4cq0NtU1SzKAg9SCZsQTyaOf5csurHc0qzJmx8cpQoJKRm1n+4zYNBgJAOu8aW6FFh7qx02Hcc4jta18Ws0SaLJkwJIJIJNFMq5iResRzal31a9BsrxuJEP9B9HPCbKe5JnDAihC1QaZjUZWGoSZShESX2A7rgRnmRYm90ZbMLQ3ZKSWGK7jH4bGEBuKjxpg6z1vyod2px52+/GHr52/92zs+ai6vkmx7mxIIOPXu8kj2XW4I5p0mGbWHO0K5u2eq7xOnLXeXSUkFNbLKVBBWD81H8M+L/FhiHC3omDsnT2G76pqfEVyu+tZQTYfADUZnzDvkYr/7qa92xLBq3JSc8c1URU500E95CaANS/fvM0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 06:02:32.0604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd082292-71bf-48f5-b81c-08dea4ebbc9f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8DEAB7A29
X-Rspamd-Queue-Id: D44A047DDFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19639-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

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
index d42c283cbb38..7a1787f15320 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -463,9 +463,13 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
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
@@ -475,7 +479,8 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 			goto err_unset_secondaries;
 
 		snprintf(name, sizeof(name), "secondary_%d", i - 1);
-		debugfs_create_file(name, 0400, sd->dfs, pos, &dev_fops);
+		debugfs_create_file(name, 0400, primary_sd->dfs, pos,
+				    &dev_fops);
 
 	}
 
@@ -493,7 +498,8 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	mlx5_sd_for_each_secondary_to(i, primary, to, pos)
 		sd_cmd_unset_secondary(pos);
 	sd_cmd_unset_primary(primary);
-	debugfs_remove_recursive(sd->dfs);
+	debugfs_remove_recursive(primary_sd->dfs);
+	primary_sd->dfs = NULL;
 err_sd_unregister:
 	mlx5_devcom_comp_set_ready(sd->devcom, false);
 	mlx5_devcom_comp_unlock(sd->devcom);
@@ -528,7 +534,8 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
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


