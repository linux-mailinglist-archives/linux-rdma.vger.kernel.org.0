Return-Path: <linux-rdma+bounces-18805-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JvoLTrRymmsAQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18805-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 21:38:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F99360817
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 21:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B994301C380
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 19:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B814D39B97E;
	Mon, 30 Mar 2026 19:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GJhhNw1I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D3C39B94C;
	Mon, 30 Mar 2026 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899356; cv=fail; b=V25AtK/YVfE3vmz1CCHhDWRvvqcw7/W0QF5yOIQ4fXABZDrG3T6pv9W/0Y+oIQHlMTZ2jPHngsCibOh0FppEkRTYLrGHFaHJSvwMycC0HZPHABuDgW60/BcZLFDoMoTKUwqFDIx37NCIML9/VIrY/4AiJwrf0WLL0urM74tdbXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899356; c=relaxed/simple;
	bh=s3BoXJ3ErA+LNHnfn5ku2+fO1k2J9BQ6j+dbdZE/o+s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvNA26aTdOOgBsCMMOfVccMRWbB5sHYZHRoy/1FzuEVb1HucZS12r8ZcSy11ZAweUJxNlPtLRqNXjnpaOSoBp/Ix4VannZwe9lFMydOT3dE/l9Sn45ZEznA/pmocdNRp1wKG3sh8QCpUmwklX5OygW8xx7buxWopcnHViTrpYkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GJhhNw1I; arc=fail smtp.client-ip=52.101.85.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXWX+ivpy+XUdntIOOSADEJB8LBXZY6E6ZKLSV2tE/2CUNnP8bdUlywUbxJk5Mm9HpcCMWzO+kpA8PUoMooZDRABs9CRNd5Bps343Qr6czTUpPB8G0nb9jDx5wmikAFK8+Nhb6l6EzB+AVj1Yj9bKThAaDbCrbSANU0UECob1sQ2W/uE9RSQS7Vgdw/tdElI9kL62kkEC5oZk19HHVihs0NNndjNUjgP1N2zam3CevciW84eJjzra1To8nrrEZlQsUFl5ajDM6Cklgb+kzuvc7zWrn4C40yFLaKphTpQiGKqddkcJPURF2FfT19+fzCKh1LCS7PnUH0Eo1NZ/zozLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2RNdM87O/uRyNSWZEyxFjB2/+swKDcr4uPA92mUKgE=;
 b=Jsyz1AD1mraFGXZ9SfWn6bEkRMZYk/nSPHUzifGqDNtAg4rHcVjAc9+RaKQl1Oq8efLrjt9Z9FHKZ7WrFdlY3e5NGTZsZEYPr6+G32zjZHVwH9l3DB2hQkcf8TmdPrLdQj1spOjxjcOfe7yJlxYKebi6qG9F9R+Mo+BXBIQ2MOmQZDTp3OSaO9sJbMyZj3XS55aALB5sEipVSFlpCwu/eMpyM3A9C0e0E7vtkNv/yUT9DqZFwGhczbXnMdaaaXYamBNfENkYgyjo2T4oKCQuVB7aYWZdGUJ7sFmkgWKncwgAOrQMDMv8IUdBSiiQ6HqE1tXcDeA1OfAI92C7huV6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2RNdM87O/uRyNSWZEyxFjB2/+swKDcr4uPA92mUKgE=;
 b=GJhhNw1I7x6W40XoKPCFXwHYLbbJMBDyUb0L1oyXHIg0b6o53VgMhq+5s9SaZ5xCsJbUL77sUZ1MUlTZLPFT7yTeRrte/o8w/FFLxVZSEj+ZVV5vjWU/R91w/DZJJZI9k8gJ7wDe10rsp+xiFfqUTOAJxJAoStB5BGwYXkNjA+etoi/MgfAomINxPZC+PS614QXqjJIUvMPpA85cA57k5AlMfuGUUV5OvpnXhFdccVbIFE4v9PbdujCO6b44Sz/yt+0A/xrKymvhxkB9JMJhmNLsPCUxGS98nPCzn0iKYD+qgidzC1tDo6Z9YzDOlVEsshnfsFlmxa5/9OnHrO/eWA==
Received: from SJ0PR05CA0034.namprd05.prod.outlook.com (2603:10b6:a03:33f::9)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 19:35:50 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::3) by SJ0PR05CA0034.outlook.office365.com
 (2603:10b6:a03:33f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 19:35:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 19:35:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 12:35:28 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 12:35:28 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 30
 Mar 2026 12:35:23 -0700
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
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 3/3] net/mlx5: SD: Serialize init/cleanup
Date: Mon, 30 Mar 2026 22:34:12 +0300
Message-ID: <20260330193412.53408-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260330193412.53408-1-tariqt@nvidia.com>
References: <20260330193412.53408-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: f44bd22f-86ec-4848-afd0-08de8e938c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hEzJqC2yrH3aB96owbLwVDPk698YCo29t9T4EoiDb1Zz61M/3BTguJMUom7W7FuvhzC+mCszckXJLvGiTIvHclh8dm200ZQi4HHIUIMuryi4icPk3tzaTEcJ+ua3Nkcco/u/l7pB6LTCwEQMPvEU+o01Jl1r/POc+EJJzjNi74adLLmIXHsI4WfICSk2Hw1EqUiZNpjLh1QLoYXNLv+uZS6vQpK/tW2X2FNqa1xRgGUcDsyZs1IaGGwK3xnlu0pgMM6qn78E+xZIQspSR2pkhEQfWf9rtLiaI+drgIG7bQhpbUKmfTMy1eevAg+cYkKvF6Qw+ljrpkBVWEHEJe3y0C5WMNxmawACMRlJh4fYoUGBzCqmlHqg1ix+XSQC6xTwGtOYPREtU3eY0xy2Tc9cm+pxUQO/L2YnQrnZDDaxXcR0kVR/4XD1pmaT5hiTg1C7KyEPEjD+oprdvYrn3gWfaQHK2rQuwZh0SnioYfW28sRO83mCYF0oy/CM7r/1iCqnrlCbE96QUPIneaZIDxJcnQ+aLC7xB4kYudAfo8+1sHqqxGdQXS672tz9J8mjS6fH+c0/D/Qj5vJdVuwN26BL53a5KUWqm+XQZ4I+veZ0go7cnLkpxP3PWRpzCEJRZ1gfLbF89zmd7sn1A6WUaU4IS2mN5nKj2+UX9oka55Uj1P9JYuMYwnuYKdrBwk0WwpE9uXsCc4EKuXjqY3e1zLprRKJ86LS5TJgz6KhKb8IIIHEpDv1Q224dWyKbvAEfcFqj3GOtj169CBnqysfAb8R4nA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pVLUN36n/pLIwk36glmrLET9bkysTDVFDNJI6nAJE3q3+puZjRpsGBdmCC7IlgwKYJLRsmrsf8+xOEgJaNFgkrX4hMPNEgfOK3/OrtvAWYHwKG/WGn8pBZYFcrnX+NHiq6aNvzJfZofcQzFG7RutL0Ie2ysmFU5/EU4XtLnbyFIXFgQ8PPoNAi0KHdITYKZOLT2rlEq3/vOn48EnYT2YNoY2TyKfitXan3320Njgy8Qs1rBQQvT0+XqdP9KdzFSuApnshKthI+TQqkFTdGKxV2ES8PGikXTTS9YpsGUXHsZomwRhqBD6FfEuaUmGQTXlSuHgfH0USAKj5cVhCXcBrOy/sMmRvDlskG1J0pA6Cgf6sK0prDioRtay4fVqVTLclbsj517MYs3D8wxwS7sguLETpiLdHBFBAkp/Fo3Gj5HuviONWSu11Zd3x4KNrqz7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 19:35:49.5343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f44bd22f-86ec-4848-afd0-08de8e938c33
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18805-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B8F99360817
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

mlx5_sd_init() / mlx5_sd_cleanup() may run from multiple PFs in the same
Socket-Direct group. This can cause the SD bring-up/tear-down sequence
to be executed more than once or interleaved across PFs.

Protect SD init/cleanup with mlx5_devcom_comp_lock() and track the SD
group state on the primary device. Skip init if the primary is already
UP, and skip cleanup unless the primary is UP.

Fixes: 381978d28317 ("net/mlx5e: Create single netdev per SD group")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 28 +++++++++++++++++--
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 4c80b9d25283..374f27b78fbe 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -18,6 +18,7 @@ struct mlx5_sd {
 	u8 host_buses;
 	struct mlx5_devcom_comp_dev *devcom;
 	struct dentry *dfs;
+	u8 state;
 	bool primary;
 	union {
 		struct { /* primary */
@@ -31,6 +32,11 @@ struct mlx5_sd {
 	};
 };
 
+enum mlx5_sd_state {
+	MLX5_SD_STATE_DOWN = 0,
+	MLX5_SD_STATE_UP,
+};
+
 static int mlx5_sd_get_host_buses(struct mlx5_core_dev *dev)
 {
 	struct mlx5_sd *sd = mlx5_get_sd(dev);
@@ -441,12 +447,16 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	if (err)
 		goto err_sd_cleanup;
 
+	mlx5_devcom_comp_lock(sd->devcom);
 	if (!mlx5_devcom_comp_is_ready(sd->devcom))
-		return 0;
+		goto out;
 
 	primary = mlx5_sd_get_primary(dev);
 	primary_sd = mlx5_get_sd(primary);
 
+	if (primary_sd->state == MLX5_SD_STATE_UP)
+		goto out;
+
 	for (i = 0; i < ACCESS_KEY_LEN; i++)
 		alias_key[i] = get_random_u8();
 
@@ -479,6 +489,9 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 		sd->group_id, mlx5_devcom_comp_get_size(sd->devcom));
 	sd_print_group(primary);
 
+	primary_sd->state = MLX5_SD_STATE_UP;
+out:
+	mlx5_devcom_comp_unlock(sd->devcom);
 	return 0;
 
 err_unset_secondaries:
@@ -489,6 +502,8 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	debugfs_remove_recursive(primary_sd->dfs);
 	primary_sd->dfs = NULL;
 err_sd_unregister:
+	primary_sd->state = MLX5_SD_STATE_DOWN;
+	mlx5_devcom_comp_unlock(sd->devcom);
 	sd_unregister(dev);
 err_sd_cleanup:
 	sd_cleanup(dev);
@@ -505,11 +520,16 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
 	if (!sd)
 		return;
 
+	mlx5_devcom_comp_lock(sd->devcom);
 	if (!mlx5_devcom_comp_is_ready(sd->devcom))
-		goto out;
+		goto out_unlock;
 
 	primary = mlx5_sd_get_primary(dev);
 	primary_sd = mlx5_get_sd(primary);
+
+	if (primary_sd->state != MLX5_SD_STATE_UP)
+		goto out_unlock;
+
 	mlx5_sd_for_each_secondary(i, primary, pos)
 		sd_cmd_unset_secondary(pos);
 	sd_cmd_unset_primary(primary);
@@ -517,7 +537,9 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
 	primary_sd->dfs = NULL;
 
 	sd_info(primary, "group id %#x, uncombined\n", sd->group_id);
-out:
+	primary_sd->state = MLX5_SD_STATE_DOWN;
+out_unlock:
+	mlx5_devcom_comp_unlock(sd->devcom);
 	sd_unregister(dev);
 	sd_cleanup(dev);
 }
-- 
2.44.0


