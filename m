Return-Path: <linux-rdma+bounces-20881-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HYAI+y8CmqF7AQAu9opvQ
	(envelope-from <linux-rdma+bounces-20881-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 09:17:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3745674E4
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 09:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03C65302F6A1
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 07:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD263AC0C0;
	Mon, 18 May 2026 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wvpeb8qF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB05384245;
	Mon, 18 May 2026 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088545; cv=fail; b=W7e+/7mu6wgOLMpa9Kp7WTPXakEPGm8Ipd8oWlFssUUU+fEA9xR/9K25y1ZiUqqylq+bZu8ZKzFXk9ibgJRBp3uHJo2PePuY1HbJCsE8ZsCt4V8lhdlOmzrvzhOjgeMdxuR7M42MVQuV/wfg37ZQHxko5Cl5sW8oE1D+FZ5HHto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088545; c=relaxed/simple;
	bh=KsIjP4CqM/+gQ6LfrqdvKL7QuauvxqQSXB37hJqm0d0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g03saMDkOcKNQOiXo5HsDjJpgDq+wqOBxayV8UIqcZOSYpIsv56r/CarKS+igRoBSEUHzw80xb2V+tb29LHqSljXymBC2TB3Rg2uL/nLKlYFY43n8Rv4AbXU3yCeK+1tFYeyWBkIOPawTiHxzU+iSWi+CycwfoHXCzjfaNV/kdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wvpeb8qF; arc=fail smtp.client-ip=52.101.48.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDDnTOVK0uz38cpajlqvAY4wlzLXut7cb8G4kRxR1vBv/6KEpUMwBRj4jswvNlsZkh2yM2oeLn3vsCvYt90mK4RrIVRZA5wC8lS8aYq2OcuHvhesGFfHXCJmrWJ25Q86MczklcUV//73Lgh4UXAvw8A/2kOxN7gvpJBbnKF2FLHXeMopdpLhQcPM91olUs6ztFYW9eFS4MrrUsCEE1bJoYl4cXX5SF0eEiE4IVLW9BBH3lxhXqgqJ5kC9ugYTUfLieBTRSrwLF8rMKzu7D1/09sBFcs+9YRzA7pVS7c5wdNj4raWq62Xhq0IZQModrGKNdFFX8Dl2069FqAJ+ksmpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nxl7uYW8EnJ02wSrfhdGlj6juwCERjMWyIAXJP34RDU=;
 b=Zw8e/6uSvHrsnHHSlWdYxcJycDGe+3wHiTSXAQDnS9b2wx2yakgPQ4y179VBvfrv036vFjWTI4slS7pqGEpBCqplhQ1lPQyj0BkwAc/UTMoT7Df0bJ+DcqwZzk5SmzugovL5NtT4KxJpNPAeIsCUC0SsnKpHeD5lwTJDyjB5ckq2DZMOwSru5+0uuEyrdMaGhk8VGUPuwKcxWI0EH9avLJEzkvEqDjohklrPWyYJJyT96/qoFlKi/WxPVZR2/wlXPlpgbv2me+Ms5hUM98sZmOTO0S5hzl8A+8x9W55JGonHTd6ODF93Ho0pJaYyJFGcuJ0u9aIBTkHWgFS4MYdU6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nxl7uYW8EnJ02wSrfhdGlj6juwCERjMWyIAXJP34RDU=;
 b=Wvpeb8qFeS8x+sG51+18ztaMdYFAxyanLlasSuRq13mlMBhK4w2/++MPQfa6cTslPJLxxROhv7Jcym9fUwGtjW2aFA0jCiFr/av6JJsaU0QXLgTR7GGikb0MrHYfS/8bJx9cR2fsdqct3AE2IaOIATU6oFCBxmofRc4F+VgjTnM97D1cI+7ET9hxE15vctHjwQ+AlUKl4AGIVag5l9X3l59Y6LF7oNl6hYZfcont4XEJvAoNyW+l62mTTMLqAQoHjwEC+GAyNnwgoBGJbrE5Sc459bXxnDmCcpcwuFr0qRjfVFZDgMofB8v4F+JbxK+9dXDWcC+MFqtW/1cftKhFig==
Received: from BN0PR04CA0004.namprd04.prod.outlook.com (2603:10b6:408:ee::9)
 by CY8PR12MB7363.namprd12.prod.outlook.com (2603:10b6:930:51::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Mon, 18 May
 2026 07:15:30 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:ee:cafe::1f) by BN0PR04CA0004.outlook.office365.com
 (2603:10b6:408:ee::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 07:15:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.0 via Frontend Transport; Mon, 18 May 2026 07:15:30 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 00:15:18 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 18 May 2026 00:15:17 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 00:15:13 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Akiva Goldberger <agoldberger@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V2 4/8] net/mlx5: Switch vport HCA cap helpers to kvzalloc
Date: Mon, 18 May 2026 10:13:52 +0300
Message-ID: <20260518071356.345723-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260518071356.345723-1-tariqt@nvidia.com>
References: <20260518071356.345723-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|CY8PR12MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: f0dc51c7-a728-4ecb-0b77-08deb4ad3e8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|56012099003|11063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Bo/H3lW+hg2ey5n+kuAHcyg0VNh9HGvlzpRX5vOdJdTQepNpjBufk02JOIDpEgmZsXcwFQLLTvS+SnY5+6tGIeF0bxSAg8ONAnsU1LBYVu93U6pOjDmnSRR/dAhz2dbCZsNqQszfWFxG/dhVxQ3xFjfWxdezOJkIeMxhtXDmTKybaI2vge7tNZ9pnNTKAFpKYs1Ug653TeKoOAtRKzTrjOBiCEnghGPJOR61EkCiRqYqEtQVhaPbPL9V8mQwGgnr2mMS0cs0OO8WiLAvB1pF4n6LddSo3zaaAeXo0srKjaMeTU633okIg0NqicXisaFzFaQIz3V+K5RKDl7PTG75kQnDky/mM3XLXaZyCOASQpOgIMOXjxUjZTdtvo3a1ky7cKiEiEWKUxRPMQIbu3BsgBBy7XG4k4g4UiQbJp3smhqRWPLaMBA5YmvsMGdGZevNINnAMedePj2oZjFxHjrTRI1IxMf3kjtKMD5uP7I3I6ZActozteIGlhDH0gPqi/l6dDryCdrzfP8j88b0EIZpyKWvuGKj8G+pLkBFezjHVSVQyswRoCSmsGNhjTkiCz3tehVds9uAwaD7RWDHu2g6Dsy8S2YMX4uavTnuFiE1uMIVVBIO07Yb1gmJ2UJAAGi+cvWoP3ftzY+9cGy9CHi9fdJ6CkconSiKffGmQoPYlBik3MhPIBLKud1qjicsMnYA2qgiB/qXQt/ZBNTKSgaR9ZAykgsRzEBRrM1UcEphlEc=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(56012099003)(11063799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H92rQlT2KEltwA/QvBzVSpDEojJ+IVLBnDrSRHY+ps1gr28qhACVDKV3kQmZh2Ujp/2qiMfaF3HW9aM7BxhNpD8t2RiuwEwlFmaRPdkNkcaEGYzhOkPcV/fcTCqUvtoAPQl7EDgFbzyTF51LpanZ7n99fmE273ORKIh4JXqW2yQUUAqwhc+n07CI83hr5ao143Tk3oo+nFF741S0OnABsnAqYljWjY2TRR3rhAgVVCbq5K0q+r5vvl/dcHAVBex5r5cFm5Xqg2jNlNdHnR7Pg2A/s85wNf9Sr6VRKWIeA/brxOmuq9mDGRviBP00hz4aTb3sHkDaRCthF3p+dh/zL6blMkPbSEutUi8732vsCg9xO2JvrIhMK4c38vSOXBjvFyCEX/aAAdBsjyHKPZjL5BhOR7YuR1RfkRr5Xm98lgCcFgQprTzJ1epNxc7SKF1B
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:15:30.3042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0dc51c7-a728-4ecb-0b77-08deb4ad3e8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7363
X-Rspamd-Queue-Id: 4D3745674E4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20881-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Moshe Shemesh <moshe@nvidia.com>

mlx5_vport_set_other_func_cap() and mlx5_vport_get_vhca_id() allocate
command buffers that embed the HCA capability union, exceeding 4KiB.
Use kvzalloc/kvfree so the allocation can fall back to vmalloc when
contiguous memory is scarce.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/vport.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
index 4effe37fd455..f8e6b1ab7c5c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -1336,7 +1336,7 @@ int mlx5_vport_get_vhca_id(struct mlx5_core_dev *dev, u16 vport, u16 *vhca_id)
 	if (mlx5_esw_vport_vhca_id(dev->priv.eswitch, vport, vhca_id))
 		return 0;
 
-	query_ctx = kzalloc(query_out_sz, GFP_KERNEL);
+	query_ctx = kvzalloc(query_out_sz, GFP_KERNEL);
 	if (!query_ctx)
 		return -ENOMEM;
 
@@ -1348,7 +1348,7 @@ int mlx5_vport_get_vhca_id(struct mlx5_core_dev *dev, u16 vport, u16 *vhca_id)
 	*vhca_id = MLX5_GET(cmd_hca_cap, hca_caps, vhca_id);
 
 out_free:
-	kfree(query_ctx);
+	kvfree(query_ctx);
 	return err;
 }
 EXPORT_SYMBOL_GPL(mlx5_vport_get_vhca_id);
@@ -1363,7 +1363,7 @@ int mlx5_vport_set_other_func_cap(struct mlx5_core_dev *dev, const void *hca_cap
 	void *set_ctx;
 	int ret;
 
-	set_ctx = kzalloc(set_sz, GFP_KERNEL);
+	set_ctx = kvzalloc(set_sz, GFP_KERNEL);
 	if (!set_ctx)
 		return -ENOMEM;
 
@@ -1392,6 +1392,6 @@ int mlx5_vport_set_other_func_cap(struct mlx5_core_dev *dev, const void *hca_cap
 	MLX5_SET(set_hca_cap_in, set_ctx, function_id, function_id);
 	ret = mlx5_cmd_exec_in(dev, set_hca_cap, set_ctx);
 
-	kfree(set_ctx);
+	kvfree(set_ctx);
 	return ret;
 }
-- 
2.44.0


