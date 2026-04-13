Return-Path: <linux-rdma+bounces-19280-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IzrJa/M3GmcWQkAu9opvQ
	(envelope-from <linux-rdma+bounces-19280-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 12:59:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 411183EB03C
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 12:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B85333068EC7
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 10:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A2F3BD624;
	Mon, 13 Apr 2026 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CaB8b+RS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E463BAD94;
	Mon, 13 Apr 2026 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077659; cv=fail; b=GzVwp2DZCiH7UXU9qTk2iJvUnjXC2NVpaIjyJYQU3nRm/LWFdWHXO+oHZ2pxTZTkbnxXhe15bojxF5IyGLmbDzTTIilSJe5bSOgb6KIcYMiasNkouGK8xjkfJG+YXBTkLIj+WX1OqqBYPsiLw15NXBv4GmPiIU/J3MZ8AwKlksY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077659; c=relaxed/simple;
	bh=NenveNx6ZVnGrRln0BP5iu2kdCXUIU2xxBPppC+tyR4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klneQQnECWWSnbTlVO6jbXnOObHcoHGArmDSWXirDvBWN4Tw5ges4Ra2hQAvrbM2dJ6R9YuTwJnN/tE2wnGzQLoDPkwAak0RPtvrUhuoKM1OcdU6kMkwCqV+UQpWM3FpZPsfKkg8G3zJWzB0QiJzaO1XsCghWzrXNQAsJ2VosmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CaB8b+RS; arc=fail smtp.client-ip=52.101.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcmT6cnwRPBgFRlzdloXtjQsflKhUVTQRgWTbWNDN3U1KHk71pyN1Q8lc9MlCGdcEoEodYWM90JitgY3Zd4aRYUrlm9A/E3TR8xVkphfLYYINzSZf9VbWSModVCwQaPP4g34aUZFlPsUDkZuyNHRVV8InmCYcWBewdD9W2fLu4/LUF7L1/ChAhfPWb/OWy14kWzWfWXuBgTFpOUEL+VfCrJ2hm8eaj2CuuOtnoi7VIFF1H+QmzUW9CW25ha/Tok6xYLFUH1DUyIekMK6tAoQA8a7R1gDBjNu3NOwyOkbjnMPCRA/gYT81LuQgwJSqV9bOzAzw3PptbRrdSbu9Af85Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBsRleLDKBlGrWUKpOI+aMGcHx36+oLoZ129HY8AE+I=;
 b=hdT3KrWEG0HFSf1i//fKJIfjKCotyGOo5eiY6n/BUo1tx2W0pNX77SnVME7IbfwOfqZ5wpVvyNiN7Rh61Wh+Daw8W6ZAPg5RyJ57R1MWVN3bAA6yvXpNDMXLDbioMQSfjxmhVlE/kx6/8FqVBkxBkGyG/g62NrFIGHbsvVAq7lcmqK6y+rYnUCNz3aXmByNKON3rgmF9ez70BTovwW7if5GImwALk3R6F2gjtfV8KGXucwgZnX+kJpRbIsBVmGTyYeonnpnEsQLYqyxpz8VeWX/fweS2ECfCmXmAP+SXjv4gnKek6a8s6Ejkbq96kCdw3miolc0y1jGOaXBRjBYViA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBsRleLDKBlGrWUKpOI+aMGcHx36+oLoZ129HY8AE+I=;
 b=CaB8b+RSibj+7D5R5mDxiGsxrCvnrbE+UXNCWuKCAzednAWY9mtbnFDe5DUAPs+OEgpHt8XHVd0tYhiDKI/1m089/n/M+W3D8T23/I3397JOpEWPcudHel9Vl9KYCCYchtd0OtWe9wCOInt8uV9wUESmrMTQdmq1cNBHfxwjvEu0FoUigtyfSriKUoHBqyVRFL2kjQ1P1UXf/oHtHxOPNxyJI2P0D8YIHfCr7pvI2mvh8XTaTwWvKbp4D/ThJo6EaUcdCKK3q22ZZ99rahxYIjxOMBvS2biE8cO5RyCQlkNr3dAB6gv772jRv8q4C3C8RXZM2a6g5Va8wCunIAjboQ==
Received: from PH8PR07CA0039.namprd07.prod.outlook.com (2603:10b6:510:2cf::7)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 10:54:12 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::2d) by PH8PR07CA0039.outlook.office365.com
 (2603:10b6:510:2cf::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 10:54:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 10:54:11 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Apr
 2026 03:54:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 13 Apr 2026 03:54:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Apr 2026 03:53:58 -0700
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
Subject: [PATCH net V2 1/3] net/mlx5: SD: Serialize init/cleanup
Date: Mon, 13 Apr 2026 13:53:21 +0300
Message-ID: <20260413105323.186411-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|IA0PR12MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: 34396ed6-be4b-4545-7f28-08de994afea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	62lHE1ugPj2cuIlxU1p9/5rmQmreL5VLODJdqliS1tNI1N+O7PUf34zvR3KyOn9sZ4BhIaGOwtpBcv56tgTJeCAZtBQhgC50RMfV/Br+V/OnxMM+dNr4D5cnGRpmAvF59uq5iAYs1kpKxOy8kkDlxj0JRB2fFX28muHkfGbWDlMC9/P3b1qzXO2GgeRkGaFJbrHUV1rcUsCZMwzvvlCK7tAghpqX8vidtUo5eYLwr+WPUO+v0k7RRLdMv9f7ege2/jmF0U1JvkdPnLClCdu6GR7cwOlZYqQMJMTD04v3FO1bv24iiH8ziNz9J6N8wpIW3Nxr9wsRCABvwdeMGBcxiNT0K5j8aG7C1JEt2MIMthHNVPcgaAHDDcmgkj+vwHnhjYARnLl0XNvqC/jKu83UmCd/7PxgRvYsaMPEjQ7R2GU70CTUKYxSiRbM7z7WIcCFYmnF3DgaL8a2LcdHUgmJWSad1XYIkzI3oytH3Lskygr01l1atJrxRVOR6KaP4p3xQkPvsIRotndW4yt/D0RNlsSNWlQ7Y61mQrx7lC+RdGeJDAhcSczvNbB2UfpS6m8GD164HFMVSPNTJuw3BGlMoT/0LrHK2jraIIB4VLTudJUVW4QsBqdjcQ8pIkYycmFzH1d+VH3iy+/MdyrB9eeGyreu6Luq7hHW1t1jbfaMAiaYz4Ba9pfEeLcxa7/vPzDd/8HE4QG19u7/HtGjmxrduxutCQmso+z1vzzPhxSESQriT4dA10E5UHArbYOkh4cY6PC7FvxdXiv/bMaZ6YtyUw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y16eMbDBInk26FEPoL10pieIQiuxEFj1AWNVamLdChBCsXgK3b/b3cRhhaJG2LVAASNAtQRbU7UBD5qMMV2SkbWrdrmQp+DWnDY/ajhxkbs7bLwNKc3Ndhkng4AFijpONT2Gg7TU/pgfvouu1yqbexj2t9ot7ABgZGRt8p0qX1msAC+DUo8/X1IRvDx55EY6miE0ZawV0s1qpouRVBdD12+YmPUgs4i7XSYDPSfGpz+WXrqcWXFH6u7fBR7jDiXySmxfYQXjbiM0gDasFp1IqRRBXyYXjgaTDoA7j8iQ/9Qel+8+rmw8afuxRTwP+1hK9O6IXA5yMJ8xZg7CfJOKz4Dgk665eorjiihADZAqTN7/ZyXFvOUaUuznNpVj4Jak4qCOxl4ec2rdUIN9eTVOnSNouBrMxDdFuJRzISh94WZnvyGIW83Y1iGFLLy7Y7k0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 10:54:11.0957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34396ed6-be4b-4545-7f28-08de994afea5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19280-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 411183EB03C
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
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 35 +++++++++++++++++--
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 954942ad93c5..a34860ad231a 100644
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
@@ -31,6 +32,12 @@ struct mlx5_sd {
 	};
 };
 
+enum mlx5_sd_state {
+	MLX5_SD_STATE_DOWN = 0,
+	MLX5_SD_STATE_UP,
+	MLX5_SD_STATE_DESTROYING,
+};
+
 static int mlx5_sd_get_host_buses(struct mlx5_core_dev *dev)
 {
 	struct mlx5_sd *sd = mlx5_get_sd(dev);
@@ -426,6 +433,7 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	struct mlx5_core_dev *primary, *pos, *to;
 	struct mlx5_sd *sd = mlx5_get_sd(dev);
 	u8 alias_key[ACCESS_KEY_LEN];
+	struct mlx5_sd *primary_sd;
 	int err, i;
 
 	err = sd_init(dev);
@@ -440,10 +448,15 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	if (err)
 		goto err_sd_cleanup;
 
+	mlx5_devcom_comp_lock(sd->devcom);
 	if (!mlx5_devcom_comp_is_ready(sd->devcom))
-		return 0;
+		goto out;
 
 	primary = mlx5_sd_get_primary(dev);
+	primary_sd = mlx5_get_sd(primary);
+
+	if (primary_sd->state != MLX5_SD_STATE_DOWN)
+		goto out;
 
 	for (i = 0; i < ACCESS_KEY_LEN; i++)
 		alias_key[i] = get_random_u8();
@@ -472,6 +485,9 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 		sd->group_id, mlx5_devcom_comp_get_size(sd->devcom));
 	sd_print_group(primary);
 
+	primary_sd->state = MLX5_SD_STATE_UP;
+out:
+	mlx5_devcom_comp_unlock(sd->devcom);
 	return 0;
 
 err_unset_secondaries:
@@ -481,6 +497,7 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	sd_cmd_unset_primary(primary);
 	debugfs_remove_recursive(sd->dfs);
 err_sd_unregister:
+	mlx5_devcom_comp_unlock(sd->devcom);
 	sd_unregister(dev);
 err_sd_cleanup:
 	sd_cleanup(dev);
@@ -491,23 +508,35 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
 {
 	struct mlx5_sd *sd = mlx5_get_sd(dev);
 	struct mlx5_core_dev *primary, *pos;
+	struct mlx5_sd *primary_sd = NULL;
 	int i;
 
 	if (!sd)
 		return;
 
+	mlx5_devcom_comp_lock(sd->devcom);
 	if (!mlx5_devcom_comp_is_ready(sd->devcom))
-		goto out;
+		goto out_unlock;
 
 	primary = mlx5_sd_get_primary(dev);
+	primary_sd = mlx5_get_sd(primary);
+
+	if (primary_sd->state != MLX5_SD_STATE_UP)
+		goto out_unlock;
+
 	mlx5_sd_for_each_secondary(i, primary, pos)
 		sd_cmd_unset_secondary(pos);
 	sd_cmd_unset_primary(primary);
 	debugfs_remove_recursive(sd->dfs);
 
 	sd_info(primary, "group id %#x, uncombined\n", sd->group_id);
-out:
+	primary_sd->state = MLX5_SD_STATE_DESTROYING;
+out_unlock:
+	mlx5_devcom_comp_unlock(sd->devcom);
 	sd_unregister(dev);
+	if (primary_sd)
+		/* devcom isn't ready, reset the state */
+		primary_sd->state = MLX5_SD_STATE_DOWN;
 	sd_cleanup(dev);
 }
 
-- 
2.44.0


