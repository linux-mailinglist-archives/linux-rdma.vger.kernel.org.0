Return-Path: <linux-rdma+bounces-22170-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8YnqGyfxK2rEIAQAu9opvQ
	(envelope-from <linux-rdma+bounces-22170-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:44:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6206790D7
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:44:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=QtKUWcTZ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22170-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22170-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52BD7302D0B9
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 11:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0CF3E866B;
	Fri, 12 Jun 2026 11:41:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013009.outbound.protection.outlook.com [40.93.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8DB3E835B;
	Fri, 12 Jun 2026 11:41:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264467; cv=fail; b=bdHOq3H3lTCGCtlCAoO4nZbBUVTJU5Kh7ywgwC4DeqZcZFRV7QMOc6JQnHVvFcDyGFkMK7OkpXv7c6qxaQ4cswUF1oYxul+m2ey0IrT0YvZx/wlnVWvQSEUVwy2dk5i+Eoq9KcGR3wXnF4qLvq5e0079TA8W919mml6nJrkb2dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264467; c=relaxed/simple;
	bh=5FoVCNax0wVmGJpS4F4sn2AkM02fs7VOkgElDCxHEU4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMj7UnzqdmgsT5hO+GpnGKwFQphmfVqdxhsr0AdWyPp1mRkMFKalOHsapiKnRbtCY/E37ymlz67nhvvqPcehis2RWVGIqPhOlCpr0d77GXKFp1McHwBOZ3HAFf3XUhAwbPng8QCFUVcAyNdPypB+0FGwl6MKTUbTGsjDjoxUUKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QtKUWcTZ; arc=fail smtp.client-ip=40.93.201.9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=porXfwcJNR7x19uTPhVPZeMIzOGHYzuX1CVtt7+U2sadnzbU3laSxZBW6U2tTYu6VfOWKmVnKtR+QWRGQzB1CQYdlW1SO1tUKTCrId2jjgXyPkda6mOnBnTGEf9bwVc4c2Ae4S1OAl2ErfrZ6tU5iacc50aGZeSW4WLqR7MGsgz66hph350QkaEXkNqMfVv1BLUp8ERaTJU2QnhWCpHNWwszLGoMWKA7xZ9rsGt8odJ7AZm6K9Zpt5fJ9gDVnogXfBpb4RA3o9N8BuYgbUyVM3POIKZPscU7H7goOnHj/TRuxkiHZE1Cg8Fnvuj4AXHzaAU2lVksgOwLrdnUgmbWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8NsRfav2BmZHpCwlbQ9iJYhuWDsEP3WdAkyvFNjR7o=;
 b=VWW27C7P0tJL4OV185rzQGbiOxf9ZYTNYZb9uGoStC57ZRfSngk4ZNF1JmUPbw4APmrxnqvy52AWEs6RlRQK6j/y0371ApW6k/ejZppXYx03CpvS5yyEJjBfLHhbb/qxbFT1ja9WxZmGs/J/Y8QVeFmLNowLZenc7Kwy/4hi1QP2DCfoHM0PaOKx8bTuFFUSBbF5x/d4fvy81uK9y+A3JzWie4mVWBhvhpwAJAE4A8Nc0dMD2sIVds2cbvGKHnAmWlfW2hONAJID2ld+7Qtj7XSEMPX/EwaTU5ADxB5NXpI+rXkC7d10T6kxqMicAuBKIS5D+9zb6h5YndqpKlPwdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8NsRfav2BmZHpCwlbQ9iJYhuWDsEP3WdAkyvFNjR7o=;
 b=QtKUWcTZ8Q6tisOWVmIt9wzZRwJ+q+8uSfuPfSDXRKFlAYGc3Wb2zmPc0WvjUG4wXdki32xqWjCjZuEt6aQfR+IPE52lt2QaT38iRsgvq0lH0Ow1OTKrtQ+qonNuNUHak9/HptfEA9GpjpJJjL+rTbuukJiTjJAj1bWEJbyIe9CJeF6LCNkik/qKyXeTBFOUHYD17WYmS9/iyaUBMwwB6dRjLQUnRBmUM/h58WzKxq53MtQ3y041JxXmn5Q0v8NvcYV4uoR8/UFlfh2JwPLmUM/ZEQwI8HpFBePzpnd5iuIaRO4CCcgojihuVSw8VX0cQOaroCzZmhWvnYhFez6Ggw==
Received: from PH8PR05CA0005.namprd05.prod.outlook.com (2603:10b6:510:2cc::14)
 by SA0PR12MB7090.namprd12.prod.outlook.com (2603:10b6:806:2d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Fri, 12 Jun
 2026 11:40:59 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:510:2cc:cafe::6) by PH8PR05CA0005.outlook.office365.com
 (2603:10b6:510:2cc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.6 via Frontend Transport; Fri, 12
 Jun 2026 11:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Fri, 12 Jun 2026 11:40:58 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:40:41 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:40:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 12
 Jun 2026 04:40:35 -0700
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
Subject: [PATCH net-next V3 12/15] net/mlx5: LAG, add MPESW over SD LAG support
Date: Fri, 12 Jun 2026 14:39:01 +0300
Message-ID: <20260612113904.537595-13-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|SA0PR12MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 43893ad3-9994-48c4-628d-08dec87778f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|7416014|36860700016|376014|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	axrnxbKu1w63BRI/Ow1Euy3uR1vB7tT6pwRpc7z55JoEf+vpeXfHsM8NAzUHQkOCQXNjaW517pLfpgrqYqwnIr1etkGa1/i3umj8W4IhY1bevDd9HUZHnh7N843tPfn/GH0NDuUP79Vm6oOffBqgNM4T5AoC7V510XSpo1/Bj5ok/b2VIxioWfeHdnzT9G1A28A+Fx2zryOILjbEqobdXj1UhJPbK79HbVLe7ZHRomM/h5JTGNRLqNgeIhJDX/ARGatJO56L/wd9nF5lHtfy65facppZiVobXcye/sOUsIeKRwOgrf37CWBMDULnTYnVpCaF++rzz1Xpa1SUOg2yNz88NvSemG3czJhNzGWqQlEevF3boIPcBl7M/tjONG46bA2YI+DdDrUEPYOkTRTMLqcgUIULztFFJLk+ScM7DKLf61cfVTsp5NeOF2/ZkUkJ1AO2bmCIjr422EIFdFNhatWWGnQ5zQi8AhkXvn71Lx9zoVJw77MjVFmFQzkocd2aOZ+YJ9WPG9Fdo2r64+0HaaWKzLnjGwh3HC0HwH/MpN998Bf1rr8DPDluOtY0ncjHEACN4OnIWfA4IhbKRG71ig1ozakJXrXDU+n5zoJOdMFy7iMVnegNca00zCwoGnSRkSAPPxBKeWm5BqJGKKIf3cIdv98iG5zeqK2yGP0nq+K4DU+zl59wJDc+ZC852q8X8E0mSF7hXNYjVMzeRFb6sEdxu9yoO2R/k0jPWZvOAeo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(7416014)(36860700016)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3wtIoTIwgxJZUgfNxJPFcsrs1ZO0higipaY5i1NJPQC6FTL2LPoPO33ur1fNWPwpEqoWGHNWL3oPrGjKwWxeqf6YJtW3HGeNMslEWsJYL3l24uQSKa6OreKhGex6TK9olzSsBBlRjrbayNjMdDDuTGcjyz6986CX2t2QU3tMoCxb86oz3w7AdjFP4qT9zU1iXcqCLpWhv2NoSvC2WRhSiAEh4gNl4qyQB3/svHilwc5jJvedAAykZWODkyNGdHwVbctVhcIFfvg/AconI8xvsui6VvNL6umOOLn2TFzcduAsY6L3X2UYgZbxVGNDhWQbYSKJmKVfdBcEJ99mhyfOGCVTfOlmwKv2ryT/8RHXXoZQTzeOXJvd9wjH3szz9j25NA4tX5OnUmUl4dOe9dHacHS+GtcOFIZYhZ+1g1NsptolVsfoIDVhXmyClo0ldKsb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:40:58.8817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43893ad3-9994-48c4-628d-08dec87778f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7090
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22170-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A6206790D7

From: Shay Drory <shayd@nvidia.com>

Enable MPESW LAG creation over SD LAG members, forming a composite LAG
hierarchy. This allows bonding multiple SD groups together under a
single MPESW configuration with shared FDB.

When enabling composite MPESW, the individual SD LAG shared FDB
configurations are temporarily torn down and recreated when the
composite LAG is disabled.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  6 ++
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  8 ++
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   | 95 +++++++++++++++++--
 .../ethernet/mellanox/mlx5/core/lag/mpesw.h   |  4 +
 4 files changed, 105 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 06e1a61d1f58..424478e649ef 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -2545,6 +2545,7 @@ void mlx5_lag_disable_change(struct mlx5_core_dev *dev)
 	struct mlx5_core_dev *primary = dev;
 	struct mlx5_lag *ldev;
 	struct lag_func *pf;
+	bool mpesw;
 	int i;
 
 	ldev = mlx5_lag_dev(dev);
@@ -2557,6 +2558,9 @@ void mlx5_lag_disable_change(struct mlx5_core_dev *dev)
 		mlx5_devcom_comp_unlock(sd_devcom);
 	}
 	mlx5_devcom_comp_lock(primary->priv.hca_devcom_comp);
+	mpesw = ldev->mode == MLX5_LAG_MODE_MPESW;
+	if (mpesw)
+		mlx5_mpesw_sd_devcoms_lock(ldev);
 	mutex_lock(&ldev->lock);
 
 	ldev->mode_changes_in_progress++;
@@ -2568,6 +2572,8 @@ void mlx5_lag_disable_change(struct mlx5_core_dev *dev)
 	}
 
 	mutex_unlock(&ldev->lock);
+	if (mpesw)
+		mlx5_mpesw_sd_devcoms_unlock(ldev);
 	mlx5_devcom_comp_unlock(primary->priv.hca_devcom_comp);
 
 	if (!sd_devcom)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index 57e6f82713b0..8481ce55c10a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -157,6 +157,14 @@ __mlx5_lag_is_sd(struct mlx5_lag *ldev, struct mlx5_core_dev *dev)
 	return pf && pf->group_id != 0;
 }
 
+static inline bool
+__mlx5_lag_dev_is_port(struct mlx5_lag *ldev, struct mlx5_core_dev *dev)
+{
+	struct lag_func *pf = mlx5_lag_pf_by_dev(ldev, dev);
+
+	return pf && xa_get_mark(&ldev->pfs, pf->idx, MLX5_LAG_XA_MARK_PORT);
+}
+
 static inline bool
 __mlx5_lag_is_active(struct mlx5_lag *ldev)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
index 2cb44084e239..50bfb450c71e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
@@ -15,7 +15,7 @@ static void mlx5_mpesw_metadata_cleanup(struct mlx5_lag *ldev)
 	u32 pf_metadata;
 	int i;
 
-	mlx5_ldev_for_each(i, 0, ldev) {
+	mlx5_lag_for_each(i, 0, ldev, MLX5_LAG_FILTER_ALL) {
 		dev = mlx5_lag_pf(ldev, i)->dev;
 		esw = dev->priv.eswitch;
 		pf_metadata = ldev->lag_mpesw.pf_metadata[i];
@@ -36,7 +36,7 @@ static int mlx5_mpesw_metadata_set(struct mlx5_lag *ldev)
 	u32 pf_metadata;
 	int i, err;
 
-	mlx5_ldev_for_each(i, 0, ldev) {
+	mlx5_lag_for_each(i, 0, ldev, MLX5_LAG_FILTER_ALL) {
 		dev = mlx5_lag_pf(ldev, i)->dev;
 		esw = dev->priv.eswitch;
 		pf_metadata = mlx5_esw_match_metadata_alloc(esw);
@@ -52,7 +52,7 @@ static int mlx5_mpesw_metadata_set(struct mlx5_lag *ldev)
 			goto err_metadata;
 	}
 
-	mlx5_ldev_for_each(i, 0, ldev) {
+	mlx5_lag_for_each(i, 0, ldev, MLX5_LAG_FILTER_ALL) {
 		dev = mlx5_lag_pf(ldev, i)->dev;
 		mlx5_notifier_call_chain(dev->priv.events, MLX5_DEV_EVENT_MULTIPORT_ESW,
 					 (void *)0);
@@ -65,6 +65,48 @@ static int mlx5_mpesw_metadata_set(struct mlx5_lag *ldev)
 	return err;
 }
 
+static void mlx5_mpesw_restore_sd_fdb(struct mlx5_lag *ldev)
+{
+	struct lag_func *pf;
+	int err, i;
+
+	mlx5_ldev_for_each(i, 0, ldev) {
+		pf = mlx5_lag_pf(ldev, i);
+		err = mlx5_lag_shared_fdb_create(ldev, NULL, 0, pf->group_id);
+		if (err)
+			mlx5_core_warn(pf->dev,
+				       "Failed to restore SD shared FDB (%d)\n",
+				       err);
+	}
+}
+
+static int mlx5_mpesw_teardown_sd_fdb(struct mlx5_lag *ldev)
+{
+	struct lag_func *pf;
+	int i;
+
+	mlx5_ldev_for_each(i, 0, ldev) {
+		pf = mlx5_lag_pf(ldev, i);
+		if (!pf->sd_fdb_active)
+			continue;
+		mlx5_lag_shared_fdb_destroy(ldev, pf->group_id);
+	}
+	return 0;
+}
+
+static bool mlx5_lag_has_sd_group(struct mlx5_lag *ldev)
+{
+	struct lag_func *pf;
+	int i;
+
+	mlx5_ldev_for_each(i, 0, ldev) {
+		pf = mlx5_lag_pf(ldev, i);
+		if (pf->group_id)
+			return true;
+	}
+	return false;
+}
+
 static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
 {
 	int idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
@@ -92,10 +134,17 @@ static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
 	if (err)
 		return err;
 
+	if (mlx5_lag_has_sd_group(ldev))
+		mlx5_mpesw_teardown_sd_fdb(ldev);
+
 	err = mlx5_lag_shared_fdb_create(ldev, NULL, MLX5_LAG_MODE_MPESW,
 					 MLX5_LAG_FILTER_ALL);
 	if (err) {
-		mlx5_core_warn(dev0, "Failed to create LAG in MPESW mode (%d)\n", err);
+		mlx5_core_warn(dev0,
+			       "Failed to create LAG in MPESW mode (%d)\n",
+			       err);
+		if (mlx5_lag_has_sd_group(ldev))
+			mlx5_mpesw_restore_sd_fdb(ldev);
 		mlx5_mpesw_metadata_cleanup(ldev);
 		return err;
 	}
@@ -105,9 +154,36 @@ static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
 
 void mlx5_lag_disable_mpesw(struct mlx5_lag *ldev)
 {
-	if (ldev->mode == MLX5_LAG_MODE_MPESW) {
-		mlx5_mpesw_metadata_cleanup(ldev);
-		mlx5_lag_shared_fdb_destroy(ldev, MLX5_LAG_FILTER_ALL);
+	if (ldev->mode != MLX5_LAG_MODE_MPESW)
+		return;
+
+	mlx5_mpesw_metadata_cleanup(ldev);
+	mlx5_lag_shared_fdb_destroy(ldev, MLX5_LAG_FILTER_ALL);
+	if (mlx5_lag_has_sd_group(ldev))
+		mlx5_mpesw_restore_sd_fdb(ldev);
+}
+
+void mlx5_mpesw_sd_devcoms_lock(struct mlx5_lag *ldev)
+{
+	struct mlx5_devcom_comp_dev *sd_devcom;
+	int i;
+
+	mlx5_ldev_for_each(i, 0, ldev) {
+		sd_devcom = mlx5_sd_get_devcom(mlx5_lag_pf(ldev, i)->dev);
+		if (sd_devcom)
+			mlx5_devcom_comp_lock(sd_devcom);
+	}
+}
+
+void mlx5_mpesw_sd_devcoms_unlock(struct mlx5_lag *ldev)
+{
+	struct mlx5_devcom_comp_dev *sd_devcom;
+	int i;
+
+	mlx5_ldev_for_each_reverse(i, MLX5_MAX_PORTS, 0, ldev) {
+		sd_devcom = mlx5_sd_get_devcom(mlx5_lag_pf(ldev, i)->dev);
+		if (sd_devcom)
+			mlx5_devcom_comp_unlock(sd_devcom);
 	}
 }
 
@@ -122,6 +198,7 @@ static void mlx5_mpesw_work(struct work_struct *work)
 		return;
 
 	mlx5_devcom_comp_lock(devcom);
+	mlx5_mpesw_sd_devcoms_lock(ldev);
 	mutex_lock(&ldev->lock);
 	if (ldev->mode_changes_in_progress) {
 		mpesww->result = -EAGAIN;
@@ -134,6 +211,7 @@ static void mlx5_mpesw_work(struct work_struct *work)
 		mlx5_lag_disable_mpesw(ldev);
 unlock:
 	mutex_unlock(&ldev->lock);
+	mlx5_mpesw_sd_devcoms_unlock(ldev);
 	mlx5_devcom_comp_unlock(devcom);
 	complete(&mpesww->comp);
 }
@@ -199,7 +277,8 @@ bool mlx5_lag_is_mpesw(struct mlx5_core_dev *dev)
 {
 	struct mlx5_lag *ldev = mlx5_lag_dev(dev);
 
-	return ldev && ldev->mode == MLX5_LAG_MODE_MPESW;
+	return ldev && ldev->mode == MLX5_LAG_MODE_MPESW &&
+	       __mlx5_lag_dev_is_port(ldev, dev);
 }
 EXPORT_SYMBOL(mlx5_lag_is_mpesw);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h
index b767dbb4f457..5099723ba0f7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h
@@ -33,8 +33,12 @@ void mlx5_lag_mpesw_disable(struct mlx5_core_dev *dev);
 int mlx5_lag_mpesw_enable(struct mlx5_core_dev *dev);
 #ifdef CONFIG_MLX5_ESWITCH
 void mlx5_lag_disable_mpesw(struct mlx5_lag *ldev);
+void mlx5_mpesw_sd_devcoms_lock(struct mlx5_lag *ldev);
+void mlx5_mpesw_sd_devcoms_unlock(struct mlx5_lag *ldev);
 #else
 static inline void mlx5_lag_disable_mpesw(struct mlx5_lag *ldev) {}
+static inline void mlx5_mpesw_sd_devcoms_lock(struct mlx5_lag *ldev) {}
+static inline void mlx5_mpesw_sd_devcoms_unlock(struct mlx5_lag *ldev) {}
 #endif /* CONFIG_MLX5_ESWITCH */
 
 #ifdef CONFIG_MLX5_ESWITCH
-- 
2.44.0


