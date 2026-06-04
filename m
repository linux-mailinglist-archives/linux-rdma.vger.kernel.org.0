Return-Path: <linux-rdma+bounces-21765-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RXxQIhZnIWqBFwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21765-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:52:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F54D63F989
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:52:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=fAWDg8vY;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21765-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21765-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF92030EA642
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 11:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B0A477E4A;
	Thu,  4 Jun 2026 11:47:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42173CC9F6;
	Thu,  4 Jun 2026 11:47:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573635; cv=fail; b=gaeAAiVlKOGSroOCreWoIFUxsxWoLTKmatmkLQ9unGff1LkVeWG63ouXukO1wqQyZ5VkGeTIQ4Rzu0Fiu8KaLom7DVnkZqu3s1+AyeRBX34ISzJdrivcCrpTsGEpEY0PWj/1OZEabgZ1P3poczmO3lERuCcyNW+p6b8oHM012/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573635; c=relaxed/simple;
	bh=nT6wbnG/ChXvtA9dcqLzYsA6Xghp9ILT/XfXQwgbyCE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qUUQq7BVVP/ce3OzjTkNOTD4FsjWMejpKmm8n+UOjArMWG36ZiQrbSRtwmrlM1aYk4lW6TJtkLIFVQ/MZpqRIHQ88/zU3xDUGD9Ge50GoaKHy5EzKoRSVGJIGBaGgqcOzSHKljkb3/wBK4urW2RScJC9Iv6kpWLEMGI0IYvpsDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fAWDg8vY; arc=fail smtp.client-ip=52.101.48.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5bFhfiAImeyBBPsg0nZmR9PRBPUn780liGuFNO4iHrDdDGEGOuvkBLWjGrGEZFeOixia9jC7mnb+QNqajGQp80HsJgzXHEBhSAL6zLGvhOmEz2aR7oWmsIvilsZjV+s/YqsjsBM+N80FxZvl2IIgfJ4m3qO4gg6ov0yypa7tY2++oc6MDRyf5mvbSOCRLbRvmK1iQLlKypyGLXnw+DiBpYuYJe3KyipTmj8U4TJSopiUm3m1wf5MASS5nSj5xScCyp0A5K/75bk3SdV1ty4UgVuixL3D0ead8dLxCws+J0QhEv/mj1ZN4gaigz4I/ZKc2BSJBB4aqkW8fwGZOF1/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHPX2AAFKz4/CRXk2Q/lCWcbYkd5GeTKICkB0nn3L3E=;
 b=aTcQvRbjMcQ2RKAhzHEg0/UqByWJnSFKnNcVnLS9rg0EPdb78Qgzhrhdb127HEuTik7CRt4KJv/IYT7QlyVLAXenx4E2JGSIx1/c74x2nd7QQ7ezmrjIj9ct7f6uXPyGMjBZQFzsloevU4QZotwixE1xrWGlh4eshvcW2FjmAbX323UviNb1Lr9LAfSTXz0prQ3epRIyglm45Us0B3k15+tujOVmujnsbvMpFFK4aLGkFCRt6Nargvcp9bdT6XK7tPaF3crwviT/t3BJKfKD1c+GnbIjKBdilOP5M6xg1q0wNNV3X/YBm/zDUm7ulPO8h1B/iVdZbPi2F4lfd3Kk1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHPX2AAFKz4/CRXk2Q/lCWcbYkd5GeTKICkB0nn3L3E=;
 b=fAWDg8vYH5CP8XTHfbi0B9beFoC9Ih/4nV6d5+T4FPGutz6n0ZKdVWBVEldnG3MXXJxqivRUnYahNumcUUXfsA7X2yhN1Q7BCliXwg5kj4lRcgm9D5sUndVQ8BegGfoYUIVKcAMIglbuDTrf4zFZINsa1ZKRMRmPhWrHsprvxqtJZc0W4KqoEapxFLcPCGuMrowgo8GDlV0gHDW3aZ9Kll5/co7INpGOtkhZCGTCHaxrq46/etHXPcuTbFqHA300Z+Uq+bZTBFApvpRF0Eq52FfQxb7KyNWukjfFeYbm3TIUgxrHoBo7Si/Ws1WiWKRMoKTZruaeaiiSTqr3MQaucQ==
Received: from BN9PR03CA0800.namprd03.prod.outlook.com (2603:10b6:408:13f::25)
 by SA3PR12MB9227.namprd12.prod.outlook.com (2603:10b6:806:398::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 11:47:07 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:13f:cafe::46) by BN9PR03CA0800.outlook.office365.com
 (2603:10b6:408:13f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 11:47:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 11:47:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 04:46:52 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 4 Jun 2026 04:46:52 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Jun 2026 04:46:47 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 15/15] net/mlx5: SD, enable SD over ECPF and allow switchdev transition
Date: Thu, 4 Jun 2026 14:44:55 +0300
Message-ID: <20260604114455.434711-16-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260604114455.434711-1-tariqt@nvidia.com>
References: <20260604114455.434711-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|SA3PR12MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: b760f387-fbe0-414d-ce0b-08dec22f017e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	hnOuk+4siPXlVSHJPBqN+M8ePy7/Mo/ApW0pa4f9vcNmkhFkxOr9EIXWOCvq2VdBGWVHZ5I0FUrN7CVaF6k6KJmLqABmbrfmhesAlx/HkVTcRRUK9y/aCZH5bJ21tX9Maw0xFgPMPQTbvpfArhxiyUZNi7guTKsCm6I8pv/s1kLZWyaKPDYi1DkfAwK7ZexfPHoP2VLcoIjNsagytZY3nsd7+KtCwkzK5ALtZ4LUrGdZWRwNK83S6yYoTSafZMuN9dXMaomRYP2QsAh9G+ni/J9NAPYvGfGSvs7S0Lf9ghtL3Z4eNnIzg0pxkrdt/CPWcgc3SIKsgK3O4h2UWGw62Hfdq5jsEronWjnoYjeKDlPO1zvruDkbZoQWSE6ML5pRflR8kvNF05sawj6b/Kr+A5M1FsUrWBdmef1SS7fykqhPuDl/IF8EG9ogRDp4WJgErpVNUlGGO08qKfZo2ksXUWQwqilGcJBf3lDCtBlfVxG6Lv6Bl3cxYfbXh6zF8gQ1OUszJHjNiqb250m1EzHH2rSBl+xjHvoxYRMddPhaQU9bUEbhUI344j9zTmSbVfM92pKtJEj5z+empgtA36MjOV3tN7a//wGuQ1iQpYA+mgHhuwIo9iKDnheAtkfvq2uASvaNhLQ/wgZjMi6HMDfg38yVvJ/GyWOUfkS1nd+0lQuBDLzZDbhqFv2h+N8p1nEBbrDT2Q/nVETt+N+fAKwsIPPcvVfOzjod4LBcwrST4ZE=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1VMZEuKpX1VQbNzrGy8ZaZdq5JBZ1ym4+esPjoVOSi0igezdCy8AwA8wZz+YLh+XfpQlDGZ1c4d0CEneKz6lfsMNzIN3Cu1Nb+45NITW4/9ZKKLLQKxWkXZw8ixyyRnHKRBWAQug1ucJBnUDNhy6O+26rT3mbtGtJmMjBSHIgqndOvMEmCCgNe6le4nZTuXTtP4DFgnfdZyRkycV1mL+Ia+QRrWKOUzYZxE2gVOGDSbWvKqRPUZ0JVWb+KzjPiACQIUnbqiTsxVRHLJXHj+m2MzJkdAuP/RlR65EsUzXGygQ3/wOt43zn7sJNnt6TldKkGo6KhLgkVA0/Xzaa4y0uuuTH3lM5BX78RiAEwV/O5pGu72ANUqfnq5t4Ny5ukimViaQK4cINhPucmTuYrWqtLf7Tia/1ZvzitwLv8u9Fut5K9Rqrva0Q3svupuhydBJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:47:07.5545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b760f387-fbe0-414d-ce0b-08dec22f017e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9227
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-21765-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:moshe@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F54D63F989

From: Shay Drory <shayd@nvidia.com>

Remove the restriction blocking SD on embedded CPU PFs (ECPF), enabling
SD functionality on BlueField DPUs. Remove the blocker preventing SD
devices from transitioning to switchdev mode.

The infrastructure added in earlier patches properly handles this case.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch_offloads.c    | 6 ------
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c          | 8 --------
 2 files changed, 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 503530b0acba..e3911da555e9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4419,12 +4419,6 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	if (esw_mode_from_devlink(mode, &mlx5_mode))
 		return -EINVAL;
 
-	if (mlx5_mode == MLX5_ESWITCH_OFFLOADS && mlx5_get_sd(esw->dev)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Can't change E-Switch mode to switchdev when multi-PF netdev (Socket Direct) is configured.");
-		return -EPERM;
-	}
-
 	if (mlx5_fw_reset_in_progress(esw->dev)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Can't change eswitch mode during firmware reset");
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 82ae8c3969fe..a9cc5a6ab007 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -222,10 +222,6 @@ bool mlx5_sd_is_supported(struct mlx5_core_dev *dev)
 	if (!mlx5_core_is_pf(dev))
 		return false;
 
-	/* Block on embedded CPU PFs */
-	if (mlx5_core_is_ecpf(dev))
-		return false;
-
 	err = mlx5_query_nic_vport_sd_group(dev, &sd_group);
 	if (err || !sd_group)
 		return false;
@@ -252,10 +248,6 @@ static int sd_init(struct mlx5_core_dev *dev)
 	if (!mlx5_core_is_pf(dev))
 		return 0;
 
-	/* Block on embedded CPU PFs */
-	if (mlx5_core_is_ecpf(dev))
-		return 0;
-
 	err = mlx5_query_nic_vport_sd_group(dev, &sd_group);
 	if (err)
 		return err;
-- 
2.44.0


