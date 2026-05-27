Return-Path: <linux-rdma+bounces-21360-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCS4E33tFmruvgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21360-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:11:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B6A5E4AE9
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D53A5310D015
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 12:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64CE274B23;
	Wed, 27 May 2026 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o+ifNnz4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102F440B6D1;
	Wed, 27 May 2026 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886577; cv=fail; b=uhgau9IjzQOtG7ysQda4V00fxuUPmv2X8mNQR836yzEG2afFabTWS1EhmPJPZqDg7MKGUShPLnXs/mEXIoI1xFxs4K/ea0lwr9vQXpHQzSv5j5hFHyVNJO3JcEeTuic36z0XButelCpA1pSQxcHqnxT2zBgZnvPWuxpLPKjgdCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886577; c=relaxed/simple;
	bh=AB3uEH9dFvhA7iaeyyJ9iAUnoEfIYuhtc7cKP6GYTUw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EjBB3QF9m8XK4vG09w1uQC6HwB3gmZkjIXE6qdpoHtp44ORVLhRywsocOtEW746NWJOuYQRIlER+FaE2XqlT3YUHlBtylpg9buQIACaE+sDHEp076HRzhP7vKDAZRhrGHErIHjJQXvBdGSwX/2xMUM6Mc+NRm9mzuAdGwMzliww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o+ifNnz4; arc=fail smtp.client-ip=52.101.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3y7nG4ZbOKTNLAL1Uw31r+C9Qzli6u9Z3tfbXrPR0p04dUmw+hSsicQ3wDjhP84qb5yybIem8cfkBBCP3Sl5HxG7AKLMzKaOcsUKMru3fK9Qzw1qt1zT50bnvB/BeOA3PVJ8jSwjjKIpmwCkDYliGdPKXz11LioaZIGWFu3uzkcUKwramg6inefFlyNVzDLgskVANH/XUgyBhMyzBNwNrwx5Dz6AVeVR4INB2qsR/EREIftlHWWXDRzgUQehVp+vS8kOXhdQJEt7sluciZ4sUSSlIw2WBjclDYaF7+8XnSHJu8H0kC7XgQc//EXXzKSp/AipZIEzBtvlg0W0ngSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+FE2Rfxfwt/67fFxQINumF5g/yJElwrdMiLljIAXlY=;
 b=YSEM+WEJ3amrZcxPSiLD1WINi6AOTkudrpEVB3V5lZEIbAJLtYr8hA2OvDqUeLqS3P/7ZZgP7qX0FZ18B86XqS9K4iAjNjVcx4m+MCpJfuTH9d+VqlBmXTeYswv2/xUCBbNJhAwDKhGa12vJjZqOMVDqxKqxMqa0ykciSWNB02bNNQHlpejFy9wWwoBkI+wWfiL5Yns40G5+CRw5Xn/RJTizWh57IdMtGprlFvc2J/QQfmatcmXqj2asrDuDw63Yx68lIoJW5qO00a3GafkhnDNolRVFMpIjqK4xxDUwZoNBMMSm/xbrHTLbc6x7WwKKfynvwATmIGE7iGE1ue5vnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+FE2Rfxfwt/67fFxQINumF5g/yJElwrdMiLljIAXlY=;
 b=o+ifNnz4j2KYeEjSlXZG3yRt4ZxxtuchOgu36Zkg2bnJg8vz9CKL3V1vEgNH9NY5cSbXVe0kdh1q043V1zcY9rGBxpjPFaucEoOGSYf6GAHFm5oL75jkU6NcjJDUpHrCqxSwP0DbeDXPAtZl+20Y0CJpNz8EBeD88EkcqCVB4rXoSlM92ZpyIOWKlhNqLaESh1nlYOpa56wQnG3hbSnw6kUWpJrpSv06EVeQVOo/CWh33VnX0jyL1wntlLHBMnf2/AWeXhisdZLK2xCdcYYaN/d1UEpwN4qN5X94EwgyRw2ItRCDZ78PLZsPAYd5ZaHRPfbO+0nHyUln1nuq8LuNvQ==
Received: from SJ0PR13CA0225.namprd13.prod.outlook.com (2603:10b6:a03:2c1::20)
 by MN0PR12MB6247.namprd12.prod.outlook.com (2603:10b6:208:3c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 12:56:10 +0000
Received: from CO1PEPF00012E62.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::8c) by SJ0PR13CA0225.outlook.office365.com
 (2603:10b6:a03:2c1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.4 via Frontend Transport; Wed, 27
 May 2026 12:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF00012E62.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 12:56:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 05:55:52 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 27 May 2026 05:55:52 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 27 May 2026 05:55:47 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Kees Cook <kees@kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 08/13] net/mlx5: LAG, block RoCE and VF LAG for SD devices
Date: Wed, 27 May 2026 15:54:22 +0300
Message-ID: <20260527125427.385976-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260527125427.385976-1-tariqt@nvidia.com>
References: <20260527125427.385976-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E62:EE_|MN0PR12MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b516d7e-bd34-4d04-c99c-08debbef52be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|6133799003|11063799006|5023799004|3023799007|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	WLU3k4EY2wUwhxv6DxKFJlfFLuGg5sBi7mPVn6FxFMiORD/CL4xbqf/9QH+osyFADVhYqZOpBJ5xZaL8AP3kqoi3LLzBIEwwdMI8m2glJfp9NG0Eg0P6Lf2roWJy1288YSyiGNYXCijuVvehgp9/6tZJN6TMbVhNUe/vekfRLCu5+StDtJL0sjWxpiSw6uL88gISlnufnf3YyM62EB/M0KSZezt8dVGGuhdc+4JzgkQHn+QFH2ibsgoJ3QYXUV/ivagIyE2d34TcioHCJJdsGl909WgZ+fz+fcgNH7GnD76MHgLq6OLkPIrulrGUOVs91eMbT9JrOA0bAt8XYTWSNGNBrmRS2szPWzmgxw7rbvyuRxCs40B8FrKvZysB12Emh34GjYQMhgbc6rQOnULLMI+l/4D3J0hsty7x/bdOMFXAdNK2ctAbN/3ChFa9E9jAiGXio71N7paooUu006GpOt5JEBjVWTxeRAVXvrbf4ERet/3Y4oM+eLTjyEMnMmfazDN3/Oi52whSrF1F+VViWT9BL2PjutPzMCo2MaH+RQYmmfiKiIzAyWlAuedVH7dIcE6ypIBy2HOX85zh0Y+6QwIgb14ObMluxfvfdbMmbzuYokcFnTAFGff8kdvYM4yenlQqAdoGGPrKzbZpYNqN3jSpdyCO1Qolc9ngM3qj7Jd6O7Rzxp1cT/torQy2aDd4WUDxaYMsn3ciANmkLOh2Zz61oNkGXZ1Wmn3WMYmJviY=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(6133799003)(11063799006)(5023799004)(3023799007)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2pFPkEUk5Gii3XVGem80AoY1+6wlhLmyyr1uTwfDFHQTiPIQVjUK3ZDhE87JrtAFrrZscb9oXSUhsVZdywDyQ84HCApq8Z0yc7z2jqWHvQGQ9xHGE0bj2LBawDwvcM3ObA8Uq7yW5vbgp6r0jiAihj+7sN02pU6HMruFqCeWqGpiFiWezj63eAxXuTXbAqY1Yxh3KdeHRUXF5NixgSZN/GlT2Hiv5Rv0YU9kFLJhvF07+2b3B+SjCGvpQd5CGzi2zFrjvZItlNw9yp+QTh4bDge/bQTQeK5VFbC5IX9R4MSwB5NhrON/6QCwr0r8rKyG/a6/a/2UviKxfltScE00Kn9ho5MLbY3i4B9oWYdQxkpdU2mXtDTn7WZfjY/K/Tgf0esmaw2SCu3m9oPubLnnAPofwFEjGYC1Vfmzs5uFF4MmtMVaFyo6rjS2Uzw7Fjpc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 12:56:09.2011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b516d7e-bd34-4d04-c99c-08debbef52be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6247
X-Spamd-Result: default: False [2.84 / 15.00];
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
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21360-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A8B6A5E4AE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

Socket Direct devices manage their own LAG via SD LAG infrastructure.
Block the standard netdev-event-driven LAG path (RoCE LAG and VF LAG)
for SD devices to prevent conflicting LAG configurations.

Expose mlx5_sd_is_supported() as a public helper that encapsulates all
SD eligibility checks. Use it in mlx5_lag_dev_alloc() to skip netdev
notifier registration for SD-capable devices at alloc time. Some sd
code is reordered to expose the new function, no logic is changed.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 13 ++--
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 60 ++++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h  | 11 ++++
 3 files changed, 63 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 3decb49e9f19..a2c7e2927431 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -293,11 +293,14 @@ static struct mlx5_lag *mlx5_lag_dev_alloc(struct mlx5_core_dev *dev)
 	INIT_DELAYED_WORK(&ldev->bond_work, mlx5_do_bond_work);
 	INIT_WORK(&ldev->speed_update_work, mlx5_mpesw_speed_update_work);
 
-	ldev->nb.notifier_call = mlx5_lag_netdev_event;
-	write_pnet(&ldev->net, mlx5_core_net(dev));
-	if (register_netdevice_notifier_net(read_pnet(&ldev->net), &ldev->nb)) {
-		ldev->nb.notifier_call = NULL;
-		mlx5_core_err(dev, "Failed to register LAG netdev notifier\n");
+	if (!mlx5_sd_is_supported(dev)) {
+		ldev->nb.notifier_call = mlx5_lag_netdev_event;
+		write_pnet(&ldev->net, mlx5_core_net(dev));
+		if (register_netdevice_notifier_net(read_pnet(&ldev->net),
+						    &ldev->nb)) {
+			ldev->nb.notifier_call = NULL;
+			mlx5_core_err(dev, "Failed to register LAG netdev notifier\n");
+		}
 	}
 	ldev->mode = MLX5_LAG_MODE_NONE;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index e341d814873a..8991db3a19cf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -115,7 +115,28 @@ static bool ft_create_alias_supported(struct mlx5_core_dev *dev)
 	return true;
 }
 
-static bool mlx5_sd_is_supported(struct mlx5_core_dev *dev, u8 host_buses)
+static int mlx5_query_sd(struct mlx5_core_dev *dev, bool *sdm,
+			 u8 *host_buses)
+{
+	u32 out[MLX5_ST_SZ_DW(mpir_reg)];
+	int err;
+
+	err = mlx5_query_mpir_reg(dev, out);
+	if (err)
+		return err;
+
+	*sdm = MLX5_GET(mpir_reg, out, sdm);
+	*host_buses = MLX5_GET(mpir_reg, out, host_buses);
+
+	return 0;
+}
+
+static u32 mlx5_sd_group_id(struct mlx5_core_dev *dev, u8 sd_group)
+{
+	return (u32)((MLX5_CAP_GEN(dev, native_port_num) << 8) | sd_group);
+}
+
+static bool mlx5_sd_caps_supported(struct mlx5_core_dev *dev, u8 host_buses)
 {
 	/* Honor the SW implementation limit */
 	if (host_buses > MLX5_SD_MAX_GROUP_SZ)
@@ -142,25 +163,32 @@ static bool mlx5_sd_is_supported(struct mlx5_core_dev *dev, u8 host_buses)
 	return true;
 }
 
-static int mlx5_query_sd(struct mlx5_core_dev *dev, bool *sdm,
-			 u8 *host_buses)
+bool mlx5_sd_is_supported(struct mlx5_core_dev *dev)
 {
-	u32 out[MLX5_ST_SZ_DW(mpir_reg)];
+	u8 host_buses, sd_group;
+	bool sdm;
 	int err;
 
-	err = mlx5_query_mpir_reg(dev, out);
-	if (err)
-		return err;
+	/* Feature is currently implemented for PFs only */
+	if (!mlx5_core_is_pf(dev))
+		return false;
 
-	*sdm = MLX5_GET(mpir_reg, out, sdm);
-	*host_buses = MLX5_GET(mpir_reg, out, host_buses);
+	/* Block on embedded CPU PFs */
+	if (mlx5_core_is_ecpf(dev))
+		return false;
 
-	return 0;
-}
+	err = mlx5_query_nic_vport_sd_group(dev, &sd_group);
+	if (err || !sd_group)
+		return false;
 
-static u32 mlx5_sd_group_id(struct mlx5_core_dev *dev, u8 sd_group)
-{
-	return (u32)((MLX5_CAP_GEN(dev, native_port_num) << 8) | sd_group);
+	if (!MLX5_CAP_MCAM_REG(dev, mpir))
+		return false;
+
+	err = mlx5_query_sd(dev, &sdm, &host_buses);
+	if (err || !sdm)
+		return false;
+
+	return mlx5_sd_caps_supported(dev, host_buses);
 }
 
 static int sd_init(struct mlx5_core_dev *dev)
@@ -198,8 +226,8 @@ static int sd_init(struct mlx5_core_dev *dev)
 
 	group_id = mlx5_sd_group_id(dev, sd_group);
 
-	if (!mlx5_sd_is_supported(dev, host_buses)) {
-		sd_warn(dev, "can't support requested netdev combining for group id 0x%x), skipping\n",
+	if (!mlx5_sd_caps_supported(dev, host_buses)) {
+		sd_warn(dev, "can't support requested netdev combining for group id 0x%x, skipping\n",
 			group_id);
 		return 0;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
index 2ab259095d7e..bf59903ab23f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
@@ -4,6 +4,8 @@
 #ifndef __MLX5_LIB_SD_H__
 #define __MLX5_LIB_SD_H__
 
+#include <linux/types.h>
+
 #define MLX5_SD_MAX_GROUP_SZ 2
 
 struct mlx5_sd;
@@ -18,6 +20,15 @@ struct auxiliary_device *mlx5_sd_get_adev(struct mlx5_core_dev *dev,
 void mlx5_sd_put_adev(struct auxiliary_device *actual_adev,
 		      struct auxiliary_device *adev);
 
+#ifdef CONFIG_MLX5_CORE_EN
+bool mlx5_sd_is_supported(struct mlx5_core_dev *dev);
+#else
+static inline bool mlx5_sd_is_supported(struct mlx5_core_dev *dev)
+{
+	return false;
+}
+#endif
+
 int mlx5_sd_init(struct mlx5_core_dev *dev);
 void mlx5_sd_cleanup(struct mlx5_core_dev *dev);
 
-- 
2.44.0


