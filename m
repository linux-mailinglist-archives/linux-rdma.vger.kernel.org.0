Return-Path: <linux-rdma+bounces-21972-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ++h1FgvNJmoekwIAu9opvQ
	(envelope-from <linux-rdma+bounces-21972-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:09:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C788E656F46
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:09:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="I+gucA/v";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21972-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21972-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56F4830B4574
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 14:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9F93C555C;
	Mon,  8 Jun 2026 13:59:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38BE3C37A9;
	Mon,  8 Jun 2026 13:59:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927164; cv=fail; b=T+JdczxXpdVYTlxPntJdSo73OulRb+/8g/1Kl24l5Q7OAW1skwqwFAQhiT/hrIRFXVedn9HeohJKNw2Dlkehh1tbb/lOSIYqY/uKxy0jS1FKDCtv2swldl3XBlkZsImE5RE8RXMfmWqrb8vQvrr6TH803TY9Y3XUmZfMxUBd48Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927164; c=relaxed/simple;
	bh=KPWPA8X/jS3kiLqZF09ftnqrOIJkyIMA/1tQvfLHc9Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SU2Osez0sZAk/eKHTqRvc0pZpSWrsn5bCVHd2kMM4nzPFzWJA4cchsv9EESR86KnQXknPdE+nFZYggHvlytMSsKEPN1Z/Qcr/Y9J3dXO3uiSuh3YtZlXVaixcVKq11/CZOzbCadQvkHl3+6Sr+IXMykuSCkYpV4KZLD9d9HspQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I+gucA/v; arc=fail smtp.client-ip=52.101.85.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTCClJAYXeYcD0i3gYLSXqs/fmnjLJq+eRGzTN4Utj1bXL08grF5T5EZVuXGjWUlIC9runTaD0K0a+eM9VTM0EsfZjdDrG6vCktw7sA8xQSK1F7q2M31lLy2QNRXCRJ7KnHz03oUmYPHgSbn2hYpo/r81JFwP/XsRo1URh50p7ICcdxE8Sab69ZBBtBFSvMgzE4BqSCVBEBC6TZGnkCOw63TeM7PUSEzJEOrkilQNlB4u+6+Y+bqmk6L+C3Sr/qpg3mjg7vc93k+cBlScCP7Xf+f4LGwrInL/ACCtaEy3wKr9bu36rR00tmQQzv+QeGfmYMur89S6z+7bWhqV/czbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/f1jn4XuesYfYShF4pQve6tfWxwf8Klevz57P621xQ=;
 b=QHiWBrga5x1/uFneiKfjfutFPbZ7Cl8EG4kRNrzlzXTJJYzBQcUQAIBxPPgz8mjS+kr830lBoGV74nms4nU3z+ub8pjbkh9zAA+rS2oT0Qy+hLG0CLTxBPQsBpgUHS/cQR5reARe9z6vK60G7FgmM0BHfbAfTasRwVsqTN0yclyiJeeecAV8xio9L0xbfIBC0I2CIC5UiREZGDR5NGumJPiyR19L7MPsfUHCftC/lunJoI5Yxa2AWYzSM7W5e2QUHCidd58W8/mNo64LbSWeMImMUXNPQ1eIoFIC6X4GRPzGtOP7+C40HPcdJYFSqHzOObPT3xxjximJ6I6rwJJxWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/f1jn4XuesYfYShF4pQve6tfWxwf8Klevz57P621xQ=;
 b=I+gucA/vc8OiuIrvKIQg1G9mGybUOwPxbJwdbxHfCzxjlXmNnlxsQuyziPRWj0qdjESKJWu8XfL6c7vu6thkilbOpIRju377eNVXY8VblT2zdpcDNq7oWU/p2fNN3VrqcUyHMRSGli+YJQVlcPo+ReEUWISqdffheQ/VbCHDt326T+yxX6VjJ/pnPJ8Wd4LG0EV46nswXqgI8HSVJP6feTzOI9JoMr+B7dfHJb+DyjASHEbFWdt8NCVtBlngawKUAUjKb9M62mgglFIAExmex0HWuweiqnnr1A9Z7daGyH4UdgvcWhx2H5A39/4Ni3xxmN8dgMGETUYcer3y5wP5sQ==
Received: from BN9PR03CA0677.namprd03.prod.outlook.com (2603:10b6:408:10e::22)
 by CH1PPF931B95D07.namprd12.prod.outlook.com (2603:10b6:61f:fc00::619) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 13:57:45 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::8) by BN9PR03CA0677.outlook.office365.com
 (2603:10b6:408:10e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 13:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 13:57:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 06:57:28 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Jun 2026 06:57:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Jun 2026 06:57:22 -0700
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
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next V2 10/15] net/mlx5: LAG, disable both regular and SD LAG on lag_disable_change
Date: Mon, 8 Jun 2026 16:55:42 +0300
Message-ID: <20260608135547.482825-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260608135547.482825-1-tariqt@nvidia.com>
References: <20260608135547.482825-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|CH1PPF931B95D07:EE_
X-MS-Office365-Filtering-Correlation-Id: f1caff83-2e90-49e8-b5bc-08dec565ea6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	PcjDm+ZDR2r56pkoJtjjUL1M/D+RtMRhFoV6W6skrHwsDUxC8Z0J/eSEtpLPTod2dqt7eANFIdb/tOlfBcA+RYvHzrjrKuSnNBU6rC2PVc/glkRpsYATVj/u2hA/yiIwpu6bAh1JM7gRmwBhAfdBRXTfkVZAPO7NmHBMyRU1GQbAYDzoLNfMbGdz3KdAf1DR0TiV22WLx7CxlbicaHt4J5B54dXSqjcr4ncYYiVYuGPllnVJXEkSkWYDoFkZNl/EqO6TsDoPdAA6ifsy3OYj5le8a3KmnwFlXCu0K5f3b2OUwGEjVuhUKTSji8H47K2h8wbna7YM/adLPTF1vCM2R8EuQPJ3+0b64DTGVyea1PXnJsDJUv7gjgQl70rW92Rtn2OfQl+yrwt2k+uUItz7cklw52vX7zVYJ4Kn5Sg/Jow4LR3RAsrrKZaoAfQ4KJlhRWNauZN/Q6MGzY8ZyG1myQr53yoT0vFtZ/1t/U2OnpJ9Tys2g2CI4VoLC25r6/FY1+e3zLuqfsnd8ancPPUVVqU6UEv7e7FPrFxwXmBIkQoyYY8VBKBOcHX4DEm0N7xQTsAzLY+VCpzWGV/WVVzsfX5wc3wjRINIbPnsY+AKt61d9/mFyYkjUBnX6gks+fMbkshAXEGFgDOCAyqmLpcJc8QgCaSR8V9/vOkcCLy5q5SVs/j1959X/XKWv/l42GbgRM+JQrFy3y0FPhVFRHv8oOkm7Ny/V1R57W0B48WxpZM=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Q1aj2BjVbhv4VAHkWNCCUrqv3hGAeMPApQLaCj3ylHOKptwirAHFD3oBnWqwmUcdJSJX6w8RKtOsFdgfP+iaf0ATulwFwAy40Gox8XwfBlK7IFwNtcP5HUxpoZZJVTZeHP3p4ykZSSxG7IzO7RQECfl05FaVsV8u2ECwFGX4Ij3HSVmWeDXZtSH5m1iRWWTWzFs8ZxEh899xPKS7435A23KxU8pp6gnyfZ4i8YIR9JZV5urbUfQ0wBMaWcbMjqolixlqFIGsIuKReDM/i5exfWcQzCvD267d8SRZudkoPhXetKRS7S63fvcFP85t3m6y/D+l2HaNlVm6BJjz3eQgUe5E7ffVhu+u7zorAq+Lmf82g4HOXMOR9JiAygxqS7a2oUS3Cr0EWPe5uDHpyHiJ+c5d3vXqgnKck8tk1C+sJGJaXgu+QXHaKGgH8nJXvGq9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 13:57:44.6896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1caff83-2e90-49e8-b5bc-08dec565ea6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF931B95D07
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-21972-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:moshe@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:dtatulea@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C788E656F46

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
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 29 +++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index e23c1e81b98f..84eff995cad1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -2494,13 +2494,22 @@ EXPORT_SYMBOL(mlx5_lag_is_shared_fdb);
 
 void mlx5_lag_disable_change(struct mlx5_core_dev *dev)
 {
+	struct mlx5_devcom_comp_dev *sd_devcom = mlx5_sd_get_devcom(dev);
+	struct mlx5_core_dev *primary = dev;
 	struct mlx5_lag *ldev;
+	struct lag_func *pf;
+	int i;
 
 	ldev = mlx5_lag_dev(dev);
 	if (!ldev)
 		return;
 
-	mlx5_devcom_comp_lock(dev->priv.hca_devcom_comp);
+	if (sd_devcom) {
+		mlx5_devcom_comp_lock(sd_devcom);
+		primary = mlx5_sd_get_primary(dev) ?: dev;
+		mlx5_devcom_comp_unlock(sd_devcom);
+	}
+	mlx5_devcom_comp_lock(primary->priv.hca_devcom_comp);
 	mutex_lock(&ldev->lock);
 
 	ldev->mode_changes_in_progress++;
@@ -2512,7 +2521,23 @@ void mlx5_lag_disable_change(struct mlx5_core_dev *dev)
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


