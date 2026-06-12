Return-Path: <linux-rdma+bounces-22168-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NB0CJe7xK2ogIQQAu9opvQ
	(envelope-from <linux-rdma+bounces-22168-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:47:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAC567915E
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:47:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=QqMnuBoo;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22168-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22168-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E4D6350FC38
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 11:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606123E95B2;
	Fri, 12 Jun 2026 11:40:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012035.outbound.protection.outlook.com [40.107.200.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2773C3C01;
	Fri, 12 Jun 2026 11:40:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264456; cv=fail; b=uJSEOCVX7M3HVAnYCMk3aBE5EusbVyuLRh6B1eoVtNQof42JVZmRoUbdddn71oyPFW2yjugmnJHSvlid2VcpBRcJKOkbGKj/g89E6y8J2+pOVtCgtzlOXolOFeehkdPIgQGwkTB7BwsqT16iEirU7ERMPEFYrhs4m5SJKlf/gbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264456; c=relaxed/simple;
	bh=KPWPA8X/jS3kiLqZF09ftnqrOIJkyIMA/1tQvfLHc9Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCUKtzuLHbVsNCCSJx5W/V8YNpsbNhC/EaRvL7ud/HXHK4tyod87PrtuVO1B3WhZaRa4LiryEeA7QiB9mpxWKnnHcAQDW4t3ncr/agHvYzawkegSm3rgBh9FsEWsvb6Srx/oOnOIoj4X/qScroBB8jUKXkPO0Ma+Ih2GsKzNTYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QqMnuBoo; arc=fail smtp.client-ip=40.107.200.35
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUwxuCtdQxHCz1X41Z479HPtVQc4zonFu8zpb4IEVy67g56hdGobDeDlG8hR0ap4MkYV7PLv75FJRN9B88mstTkA6vkMKy3L7RRpOf0+W/PSpJHIdt2iiciJXgSNcQ63YaZhyKFnUZ564rHcodQxHtJGz7P6jl7JhupTR0z+eFEfj0hOVyUaDRyhvcwE1fsKV9JERAu28itj+1TwDp3qUbPdlQJkCE8k4QYe3mI+2J+thB/YHB5jDuqWVGz12sWEQ2HTPM4iQW79jCW6wQDPpcraf8dnd1OIE281c7CWVaeg3y+wJfkakZSjKxxUR2wjza1pe8F3tIhR0TuKusvrSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/f1jn4XuesYfYShF4pQve6tfWxwf8Klevz57P621xQ=;
 b=MbWjM+XKiNi8u5JgWBsn76HXMaJ9iVMIL99vhbf8hJjxdFbxuf585+SdRFTbV8MeGSeOG/E1TsJ3mj+HK2iuQl8Uy8lw0z0T5nNgRFz7gXBtby3s26O4LsYBCJIqq5Fw70HQHCq4yyJA802D5/2ixX8cyC2WoVW3iQ/Vdlhanylk68/1ozr8zDrgdvIX6kd0n4lEt2WHIYoATqNNOyXRdmMsyOks6K25vYuApIAmqnT6AkzPax+niIqmF3WsOGFebht6tPWK4kKjNZJSVjqm+Rl04lI3Uw9+IFxE24hFeEvuykBbx4HkH8zZnb7Qj4c9ODQexSKlm3Zs5tpXYX6w2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/f1jn4XuesYfYShF4pQve6tfWxwf8Klevz57P621xQ=;
 b=QqMnuBooA7NOjbchwlFvISRwmAaudi9kSx6AHkv5ZgsJ3R8r2VoJzkmgHYItPUjLTspBMbqum14IL1D7xUkNWUzZOSMbXLSNZiucfAUy/UhPUmlMyL+OSezElOZ75dFjiDQP6KRWpZYiT81FFFCk0IvTPCRGXYMes4r6UIoyZPioM+uYWEQafIkymuX43c2uWDEv8xdM9My10yQYumYnX1x5Abg6Hcf0bbI9v1D80pt8PWhgrTFVMdeu6d1n0X+BxbiA/lPcFHai9A05TRJ4qwbxfa92izV8hcRqWTfJco+JwUXcWCNwgD/mjR+Od/suoEX0Zr/X7RULuAUsfM0r4w==
Received: from PH7P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::32)
 by DS2PR12MB9685.namprd12.prod.outlook.com (2603:10b6:8:27a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 11:40:46 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:326:cafe::43) by PH7P220CA0021.outlook.office365.com
 (2603:10b6:510:326::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 11:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 11:40:46 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:40:28 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:40:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 12
 Jun 2026 04:40:22 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next V3 10/15] net/mlx5: LAG, disable both regular and SD LAG on lag_disable_change
Date: Fri, 12 Jun 2026 14:38:59 +0300
Message-ID: <20260612113904.537595-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260612113904.537595-1-tariqt@nvidia.com>
References: <20260612113904.537595-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|DS2PR12MB9685:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b69418-0e6c-48ae-8cd9-08dec8777194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|7416014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	NaUGQocZS1ZgY2LSaf8FKKSYr8KaBs6jim1YZRolalLFkTtRoXwSLKtXB0/KgbvY2sYNCUI/+zmBOhLGiBnoTl8kGxcjVNbZaItqbRxaCuTYSxW5gzWOIipZh1BSuR+bX1BeWK0WelXY9nufjppHDKp/nl1wI2NAUnpHfcsn8Kz1vdKlQE9HXT2occ23MINBnYOYO4P4ddIXV2RMAbXgP07xmH3cBftuZbLyVqTCk010KrXrpNTijkewqgR0h807+YgtkreDMj+mZ5mj4FdJi8lU3fVTdhDvqDE0llUoEE0HfYlKVi+w067ONJ6A0gzKF1C1km58tCBOM8uXTRk/K6rw+5AtNH5ibS5b76Pkmcp6w2ppKGxesP8Ku7kniqCAFLrlyoboprroroZzyUx+L87VUXyiw9pBG4JdNEtlfV85hBheitMGE5DXVnw7qH/Z+N9PQWkmr3X41qGyaRWfxFs8IwneCzukRZC5FmgT2NRBujW0gOdmeo5MluVRft0hDZ5jnpyBYR1FVyJnPcJurmWPZ3S6cv5CZXKypZKyYk2TVy0KQmjF0VmogtdEWJLyMpl89GfDmQJVmtYOAuzlJQuWwhlZTaVmZ8Fq1+VTUwCNHaPh5cCbdKmTw79jHOOuWFZyGdE9ibkpeS0KVOHeyPyhHQ004Wg88Dr6cHj1q07nZFQI0I2p3dZehQ1fnhweiosUaz/CwhKZZelLKz78DmIR40CD09uISBXkPnGIA9c=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(7416014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GttmYYu7BsAO6B8MBW8v78xGdXbaZxT476ZOGHSVpkMRQfGcD6EETIHdbDC76O+QsqNAUq9kTdnH0k9r9pP5zmmyja61gK4u3qgSq62ixFkibO7VMbnvV+XasE8sdKGbFATAl8ZIrN4WCU76L0PnzTF99m4JgmJQSeJS+HLSezBjzRcvfwQ1H838/lLevPux2VapSp0eae4TYzn6G8DYGNWX0IQKHAaY8YQbMU3RViL9rFQioQ/xDXbVdGnbV7SDpaujl4E+2gedOlI/4/PHPTtMSwB/6JeK0k53l5dWUc4SezTX/2iYKfX12eqJSKnL1YVr9TEn+vOaRo10lCFMStDFBvvc885WvVbD8R84rs49jA5NuD1nbYYxEHhKF84L8Brka3VREyw9IaRLciEtVGYUiKrC9K/bgA90U7ybyOJDbBwV+2k5u90uRLP2wdVW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:40:46.3969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b69418-0e6c-48ae-8cd9-08dec8777194
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9685
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22168-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:msanalla@nvidia.com,m:horms@kernel.org,m:gbayer@linux.ibm.com,m:kees@kernel.org,m:moshe@nvidia.com,m:parav@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EAAC567915E

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


