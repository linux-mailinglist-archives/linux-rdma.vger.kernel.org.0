Return-Path: <linux-rdma+bounces-21766-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gUtSFLhpIWo5GAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21766-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 14:04:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D04D63FAFB
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 14:04:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=l7n3tnvy;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21766-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21766-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB26430E3D74
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 11:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0134542B749;
	Thu,  4 Jun 2026 11:48:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010026.outbound.protection.outlook.com [52.101.56.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9280B4266B5;
	Thu,  4 Jun 2026 11:48:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573685; cv=fail; b=TsXwFEg2ACKZxYmzUzeEzoTbVaJyB/H/nicasdt8oz1t/p3IxxuOe3FEXiYTfFtetm1RqUqiX0g3ZsiD9Obq6u5I9PBoHUmbXgTATTjO47+JHtyahRA5Fv3RkMYga0HHoLS1V4Per4gWjJVwWQXaVicHNCyMo2nI2+m4DPb8y9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573685; c=relaxed/simple;
	bh=o2Ia+Xl788kMjkm6ma4MzMLh6xc99Q6fKWyfnnH8W4A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p5ToZUv4gsxaZHhg92E9TcgbaorBvZEB67mJhUNOME9N/mDwlshvLjTYTgJV2kKiCtrcZ1jApN19/Srll5PSlV3cNuedqXDkkCpES+O0YRBnx9cbKU++r5ZkR7KXO5y3Eqh/hBVxLa3RK5WcDSG64KWTCEqSnoOsPZHVzAYtk0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l7n3tnvy; arc=fail smtp.client-ip=52.101.56.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g06hbWgTXubSPEk9Kno6tRAa3eBUZ67GLrJ/V84VKOUuNRGyY7ro7FcFwvChbRtns1YJwHeUoBJCZYx9ZduJ7bpa6CZb3mM9WdAWfux+jB4iBJDItbVL8toDsdcPvogZUWy+qelE1CgSZoazw95qtMnck0QIQtlOQ944VybhY43YNWr6RhF8AvFjd+nNUpMT6vHlalnOSH3dBHYI1n7LHjqy20lNTeDRVM7Rhi5x4uRp5uSeBrBDJn8DrvUMciEVHqH8MGq+Ayngmm0Us3ldMn6thmbBhAjO4GGIMLIQcslt3SiRyNcOmGsoraOiiqxRruJd92bRzdRxpKovHh5VXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQW7aHy4ogXvBVkF0sHqjGsQp1wTXMvfKnX33FdOy/I=;
 b=AFPIF2qSHMxsJAEtlE1VpBclrfHRKtfoYHCaTHFsACorn5TMck4Jr8oewVAOtfOOxi24yBn/acQ4V0G8/ahB4TjusiaVtvDwqWclTuUFI9uXj+Qs1Fl3IbeWxyLs44/+X9n7XbB5WoGqa68an7NOTE6pUdng8SE65ZLXeYvNe1b8GwEhrSwge774Q9PC3hE40NuC1rXolhePrzApGa/9BKXVGAg+3PXMXZuNWUifxDfZLAtHIK5//lx5oLNLVqJzxSQb0/OkZKD7rUCIpDzH52YehBpZMbA0Xr7OYZJIvQvN8rNosewRXQSzZ9hpcAbIEoH6XK/NUPEllESMzAMQ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQW7aHy4ogXvBVkF0sHqjGsQp1wTXMvfKnX33FdOy/I=;
 b=l7n3tnvyaoI37ce+XxQcTXA3nRZ/dLjyUCW0G8+VHnCfZojsArVIeJr0cA9F2AFbeqC37qwlKluSUJp4XKJepBxG92441z5knCempWa+iJyieX0gX37p1gmP4TVGMWV0LGb6wJg+L7n0uqTZqdrnVbTYa6aEIoiYh0hyxud0ddVVnON9alRAngw/OLrUywE5JMIAlaqYDMHHqPE4n/ScPhJgblIp7zQw0ia76AyKcMqlJtESGZVFZXEc+KHC6wTysxog8klWbir0uW2EJJBOLpHPyY3HZDziZvRNt+2a1a9x3zXS1vFGbbLnMXcQY8MFkvS0oq3d0nKkV5GNXiz/wA==
Received: from BN0PR04CA0168.namprd04.prod.outlook.com (2603:10b6:408:eb::23)
 by DS0PR12MB8564.namprd12.prod.outlook.com (2603:10b6:8:167::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 11:46:34 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::3c) by BN0PR04CA0168.outlook.office365.com
 (2603:10b6:408:eb::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 11:46:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 11:46:34 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 04:46:25 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 4 Jun 2026 04:46:24 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Jun 2026 04:46:19 -0700
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
Subject: [PATCH net-next 10/15] net/mlx5: LAG, disable both regular and SD LAG on lag_disable_change
Date: Thu, 4 Jun 2026 14:44:50 +0300
Message-ID: <20260604114455.434711-11-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|DS0PR12MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f74df4-7c63-45e4-ed29-08dec22eedaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	A8YdVkbkqFje9kgxFHJmdZ8fy/KLUejG9zUtsjmg51Idc0cDJ+0eGgT3wI6hRbQb4UE4jnMijncxl6U6n4kPT7lkCXjtKAqoPCk9z9JfggcrDgl008igQ+MVRp+eNAf/wFhGXW59HZu/rBchaXMhW4YD7VkVO8ZKkhhU77depG/DaspyEeYZzpiGbdnFExc0bcYc/vY55RpadsURuT9GgNLedrv8cxjvADurg4CMkjwt1MUAzRK6Xf5mhY0LmTszDpY2TrzZ7MuBGBIzmHPJk0T7pmoatwJadjBU7Lc52NAeRWhXql5YCQq3lZy9hPW3Ic+189nyNBvFd+pzJmaEktJnMn5ChofPOoBNkMrbvlNPLHtt0Mz22e39SuIcVdxkGChbcXxAmQy6lf5++wTjYCob8ESHxNV/zzpZomjt1NbgkSRX72FcMT4AesvN1OO+nNxStsEhXPrGmmpRZsXWVS86Rdrr9hPPmZjloTI1pmS7zhph0kxZf5fBFCYJpZsoEogyVYpmHE4PCyH9xJAYf9qXZ5DV2Ftahmt2sYLfYpmrZ1VGOFAPR/WeGqQk52QbdLIVLOr2BDv4Ayp+9P/RLHJrrHHC0MKg1BGKG6+zphvBmA0bXRylLt1V+02U9HV5JTz10njU9F9+NveNVkxh6QqEe+6Mf19w8n2aGABjQQS7AZhYSzxpQ7c5jE4/A6QA5nS2A9vjl3yzhWdIe/xnR5bFfQw/6ULiUn4AGhQjL60=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sKwMPvpRHXkPiSWoFZgfKXFDZEdXTxML0ZYlgQiQ9DBRL2ykRfZ5IReFbJEwiExyNjwA4B7LtOGWtvpwCF5aGG2hQbCqt2qDvK8jz4LWIw1G2GFNkMBfq/53svgFWW7o5C/lLF+K7nTZwzZKAcWl4N6l6IcYpsPz3vSzlpKp53WvIlNg8p/WxF3aY78rGSluhbc+AX17K9KRa2feYZz8gKqUcwtf97NkNsk/MgjQFgoI8xrFyXJX1D1ExhKVUjpermZpCeCgTzTrddz+dilUfVN+ekc6FRGZLk1YUNnrPC+npxgiqUltp4P3u8xMui5sRN4yrnGTmyMgFjxaTnXNPla/ZoRJrseI37IzfiV8vZmWgziEY+vGPGD2TVbYP16/XMRqf7qLbZPeI8pDDusscnfthL0tufp0fpMe/TvPVbjTAZc4Qmei3cu9KZ3KfObV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:46:34.3182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f74df4-7c63-45e4-ed29-08dec22eedaf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8564
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-21766-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D04D63FAFB

From: Shay Drory <shayd@nvidia.com>

Extend mlx5_lag_disable_change() to properly disable both regular LAG
and SD LAG when requested. Each LAG type uses its own devcom component
for locking.

Use mlx5_sd_get_devcom() helper to retrieve the SD devcom component,
needed for proper locking when disabling SD LAG.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index e23c1e81b98f..b660253ffc6d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -2494,13 +2494,18 @@ EXPORT_SYMBOL(mlx5_lag_is_shared_fdb);
 
 void mlx5_lag_disable_change(struct mlx5_core_dev *dev)
 {
+	struct mlx5_devcom_comp_dev *sd_devcom = mlx5_sd_get_devcom(dev);
+	struct mlx5_core_dev *primary;
 	struct mlx5_lag *ldev;
+	struct lag_func *pf;
+	int i;
 
 	ldev = mlx5_lag_dev(dev);
 	if (!ldev)
 		return;
 
-	mlx5_devcom_comp_lock(dev->priv.hca_devcom_comp);
+	primary = mlx5_sd_get_primary(dev) ?: dev;
+	mlx5_devcom_comp_lock(primary->priv.hca_devcom_comp);
 	mutex_lock(&ldev->lock);
 
 	ldev->mode_changes_in_progress++;
@@ -2512,7 +2517,23 @@ void mlx5_lag_disable_change(struct mlx5_core_dev *dev)
 	}
 
 	mutex_unlock(&ldev->lock);
-	mlx5_devcom_comp_unlock(dev->priv.hca_devcom_comp);
+	mlx5_devcom_comp_unlock(primary->priv.hca_devcom_comp);
+
+	if (!sd_devcom)
+		return;
+
+	/* Teardown SD shared FDB for this device's group if active */
+	mlx5_devcom_comp_lock(sd_devcom);
+	mutex_lock(&ldev->lock);
+	mlx5_lag_for_each(i, 0, ldev, MLX5_LAG_FILTER_ALL) {
+		pf = mlx5_lag_pf(ldev, i);
+		if (pf->dev == dev && pf->sd_fdb_active) {
+			mlx5_lag_shared_fdb_destroy(ldev, pf->group_id);
+			break;
+		}
+	}
+	mutex_unlock(&ldev->lock);
+	mlx5_devcom_comp_unlock(sd_devcom);
 }
 
 void mlx5_lag_enable_change(struct mlx5_core_dev *dev)
-- 
2.44.0


