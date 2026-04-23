Return-Path: <linux-rdma+bounces-19499-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DxdMbsR6mn4sgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19499-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 14:34:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70131452059
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 14:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE5143047BF6
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 12:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A28F3ED5DD;
	Thu, 23 Apr 2026 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Egm+Y0eW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013001.outbound.protection.outlook.com [40.93.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F2C3ED5C0;
	Thu, 23 Apr 2026 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947534; cv=fail; b=O3f3dDbhQr0nXXdA/A9BZaTk47Bv74xCOhIzG+uKD2Xws79kkepVoGEuTvGtiE3nwlADHTBWkphSmXr9Qg79G4YKNJ0jqFA01FMScLzbHlSMTlbPCNLUobazsLmRI/KmYrHqlDUP1P7CZWcGjc/stxpLblfeQXBc2U68yJq3USg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947534; c=relaxed/simple;
	bh=IvsrPLJeI4Y7+eXZ3pUgrCl3JP3VS/c9gZ2DuqYjQfU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qr7UsZThOIqR5BP+juriupYZ0fuB6+/mfzmpUrACW5UBsHIszXyjOmkg5uH47/Bxeq0hqcJOFP3Pzd3AYPMp8vpXiXXsaFvtfNoMMwGCKl3A6rPSJ4RtiHor21avRowwL6bZs49Rm8VaoJE5jQnfFTAgc4+3J0bxSSngLZVmJqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Egm+Y0eW; arc=fail smtp.client-ip=40.93.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyvUHXIraITlq8ndKmG9+vxseYbT4DdncVekoXkK4UGkAnn3utR0yf3BNbgOD94Y9kBoBGQKWhGPPfroQ3sZ2NsF6igvdwNl2m2MVQO1aHQOgC/SFGmZXQH9q5gE2XPnXbotLx08s/MoZp+tgpswVhlcJFUFgtgLBDOu+D377jSu4Oj0FOrh9buSPXIXUiQIsxVtH3UXpuZPqLjIyXsL955rP2PzhWXRkyeL0YchE4dGQVczybwJMEOHBrXYLY1Po9r+tyWuiwPJ56D/yuT1v/ZDqxqCEzDgczQglQ1BRt3dRGGY57eewVslsxynwkjS7nxMm/KWD027BQmVzaWMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJMJNT77KePBesv97y9bPN/S6mtVAl4Je9M2VMmZ3Ck=;
 b=NqNssjn0HvbXdPpaCv2vU9I5uLez0cwPGfy+fTALZ7M9EJ2idLTGUJrEknwEJW2LX48FBldXGW0QHvbANFkdc8bPflDgXpgW6lZzFDtPKPzuex7us1BYq2UqP+JKGTqdx/+Mrc1fZwU9Pb0Y0oZWM4GvR4FFkpQq/i5CRYWf17oO21fEkDR+nPYyXm4FdWvFXcd3f0yslwJ9COp5fZbFvbcGkD8gWhgUTJGjkM/+WEB+ft5n54w5Xgak7Ft6IOf326LUCVpBPiA+rL3XZADdT3RC6IVnS0SZ9reSsDyNujS5xE93dllyR3Rg+4SUkkn7UB/A+UbeYs70bxh/4X3VKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJMJNT77KePBesv97y9bPN/S6mtVAl4Je9M2VMmZ3Ck=;
 b=Egm+Y0eWE4q/C7mINI2WPoeiB+/34pqQmazyXs2tsfKM6+i3JDCbbMemL7K4uWy1TRwJrzcr3uKoZRLV0c+kpdQrwW4t/P4zAVO/jXWC8FpsewQCQjP2xpRzwIhZi+lR3ha9yaN/Vh1Yi7BWdaOQmkXTs2g5A5unRelvaVJycU6xYMUAcABYj9g0LJQZlch3ZQaF91p7/yh5wkwEOjZrgzT+ebcfoUvv+nBzJMxMoPpRr9uMTqmRbMTnR1pw8qTHixL6MYZWx2WqCqhO9owM4Eja4k53v2Fx6IK0azCWt2JnG3o3ZTZWYFQFBEeMPXLDEGZ8y7ShxWiF5F7w+Ow73Q==
Received: from BL1PR13CA0179.namprd13.prod.outlook.com (2603:10b6:208:2bd::34)
 by CH3PR12MB8852.namprd12.prod.outlook.com (2603:10b6:610:17d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Thu, 23 Apr
 2026 12:32:01 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::94) by BL1PR13CA0179.outlook.office365.com
 (2603:10b6:208:2bd::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.20 via Frontend Transport; Thu,
 23 Apr 2026 12:32:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 12:32:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Apr
 2026 05:31:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 23 Apr 2026 05:31:39 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Apr 2026 05:31:35 -0700
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
Subject: [PATCH net V3 1/4] net/mlx5: SD: Serialize init/cleanup
Date: Thu, 23 Apr 2026 15:31:01 +0300
Message-ID: <20260423123104.201552-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|CH3PR12MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: 02799429-899d-4a48-58c5-08dea13451d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	duDk0g6oFKGUM1lanLbL7KwHbW71UWxDbAqdLTNmw2kAvgPVCMLt9/Qe1jfjx8ehCzdtVjXEthlyGAow0R+VMvkEvTMQ/1yneakol5nLQuaf863NBguDVyLVyV5w2iYu3u2gRwSVkXyjMHr+mFDX7llAj1gwIiWxD+d6gEZ9JGeh41xT1vr4Rgr5wLq0+u0tna8vV35UmD8544VPN7Hnq1p7rfaKH4ooXwa7eSwxgzVY+JwZl59fc3eHPsC/jVglL750nIDyvr+3Tj75ca/cj1wHgmt2yoo7rYr66yAVbOXgjbNRyR4BRxQkZgbC5bFptoQVNYImQJEgaztpCsRFQFHIedMbWmjSoUaMeSVccoUW0ew+3WUYZXD/BCjS5qeGFeClnOL5ZK6pn9Tzg9eTh685Dc/YTRv4gkmJzoBq8Prn50YfmUPlVAPTwZZYPLI4suO/+KEBhKYP6V+zzVa/8D2VKfhnZ3Kjji5/OaXtory9lQZDjqafoRam0MgF8Fvtw0eYD5GKUF2YZ6HFudRF9TQcsolaA0cTnf4Qh5yKEzW7XBydr6wJBiCrhkwkdLjavBD2PJpq0v40PAfGvA1/XygqwEwkt2oUQIJXeB6Xh78SQTKLOhgnqAtLYUfRucZQEnX5XKy3uFOqqteh7pCqGX0aaCKZ2wBVYneeNjzM1fi5kq8Sd6LFFGhE2VXm42nX4HhDYcteqXHw/2MNIsw4Youwga6/1/8IBMknG4xEi9xKeJB6J5NcER6trGcfjHp3mn4mJUGTiPWRAYYFKIG3Zg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wViox4l6JcaBoKpFDykbiLFuj7Fmjdrtsg7STu352o+rhVAMdkrqq4EjbZmY31oq8a4M+5+2BTIZCpskxZd8TWbqhHad+7zNPz2BkdGb4fMPvDbuxYVGwmCSWCcNU6YSt9ulccAWGN8Q+9NkX+qy6kefD+Anko1rbjc2qsUQNeAiQvpW2kShI7H9kam0HbixGnwWb7U96YVQHU6BPEVmHgZRn3QMOdoJTgF0OjD5hSxkz6zUBCJIhqy8QD6GxCReHnl0iz2rFMKSvVv13OZMMwduVKctMpCA2a6UJ8tn7lVJD3UB5SFFq7ztKjnhqprXfcKT+pXMPud3ewer6GqvQVGQHEJqxFE5FNJptUHkFpY3IOC3W6BReMtqOI/so6Znw/hAVbecJPUFRDx/vCL/A8/OfPAhMPFWBAo1ssV+u1Ew0ImLUHAIPQMkaMEdK6MT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 12:32:01.4836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02799429-899d-4a48-58c5-08dea13451d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8852
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
	TAGGED_FROM(0.00)[bounces-19499-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 70131452059
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

mlx5_sd_init() / mlx5_sd_cleanup() may run from multiple PFs in the same
Socket-Direct group. This can cause the SD bring-up/tear-down sequence
to be executed more than once or interleaved across PFs.

Protect SD init/cleanup with mlx5_devcom_comp_lock() and track the SD
group state on the primary device. Skip init if the primary is already
UP, and skip cleanup unless the primary is UP.

In addition, move mlx5_devcom_comp_set_ready(false) from sd_unregister()
into the cleanup's locked section. A concurrent init acquiring the
devcom lock will now observe devcom is no longer ready and bail out
immediately.

Fixes: 381978d28317 ("net/mlx5e: Create single netdev per SD group")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 32 +++++++++++++++----
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 762c783156b4..96b4316f570e 100644
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
@@ -270,9 +276,6 @@ static void sd_unregister(struct mlx5_core_dev *dev)
 {
 	struct mlx5_sd *sd = mlx5_get_sd(dev);
 
-	mlx5_devcom_comp_lock(sd->devcom);
-	mlx5_devcom_comp_set_ready(sd->devcom, false);
-	mlx5_devcom_comp_unlock(sd->devcom);
 	mlx5_devcom_unregister_component(sd->devcom);
 }
 
@@ -426,6 +429,7 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	struct mlx5_core_dev *primary, *pos, *to;
 	struct mlx5_sd *sd = mlx5_get_sd(dev);
 	u8 alias_key[ACCESS_KEY_LEN];
+	struct mlx5_sd *primary_sd;
 	int err, i;
 
 	err = sd_init(dev);
@@ -440,10 +444,15 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
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
@@ -472,6 +481,9 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 		sd->group_id, mlx5_devcom_comp_get_size(sd->devcom));
 	sd_print_group(primary);
 
+	primary_sd->state = MLX5_SD_STATE_UP;
+out:
+	mlx5_devcom_comp_unlock(sd->devcom);
 	return 0;
 
 err_unset_secondaries:
@@ -481,6 +493,8 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 	sd_cmd_unset_primary(primary);
 	debugfs_remove_recursive(sd->dfs);
 err_sd_unregister:
+	mlx5_devcom_comp_set_ready(sd->devcom, false);
+	mlx5_devcom_comp_unlock(sd->devcom);
 	sd_unregister(dev);
 err_sd_cleanup:
 	sd_cleanup(dev);
@@ -491,22 +505,28 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
 {
 	struct mlx5_sd *sd = mlx5_get_sd(dev);
 	struct mlx5_core_dev *primary, *pos;
+	struct mlx5_sd *primary_sd;
 	int i;
 
 	if (!sd)
 		return;
 
+	mlx5_devcom_comp_lock(sd->devcom);
 	if (!mlx5_devcom_comp_is_ready(sd->devcom))
-		goto out;
+		goto out_unlock;
 
 	primary = mlx5_sd_get_primary(dev);
+	primary_sd = mlx5_get_sd(primary);
 	mlx5_sd_for_each_secondary(i, primary, pos)
 		sd_cmd_unset_secondary(pos);
 	sd_cmd_unset_primary(primary);
 	debugfs_remove_recursive(sd->dfs);
 
 	sd_info(primary, "group id %#x, uncombined\n", sd->group_id);
-out:
+	primary_sd->state = MLX5_SD_STATE_DOWN;
+	mlx5_devcom_comp_set_ready(sd->devcom, false);
+out_unlock:
+	mlx5_devcom_comp_unlock(sd->devcom);
 	sd_unregister(dev);
 	sd_cleanup(dev);
 }
-- 
2.44.0


