Return-Path: <linux-rdma+bounces-21968-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JXyHKBvNJmoikwIAu9opvQ
	(envelope-from <linux-rdma+bounces-21968-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:09:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA608656F58
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:09:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=JA1S4oVq;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21968-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21968-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68B0B30277E8
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 13:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5825B3CF208;
	Mon,  8 Jun 2026 13:58:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012065.outbound.protection.outlook.com [40.107.200.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31633CF203;
	Mon,  8 Jun 2026 13:58:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927086; cv=fail; b=r+R9mIfJtvflfkAzY6QmVsH6vygn3IikQSaRIKgxU1T1SSM6WkholN3YYBuKhzUM5gm23HcGGu/c9nBzyFNzEUlxGBsoIlkFLt9oPQ1oG/osK7BVU5XCIBSaCgXvu3gLdQaEHzq8rOOPlB2rPY4a+qIGhYhEQz9mYcgwdFyx++c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927086; c=relaxed/simple;
	bh=5FoVCNax0wVmGJpS4F4sn2AkM02fs7VOkgElDCxHEU4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O6t6jLVI92jlnTlSEWYxHonCzMlbWV6zAvU5C0WTHoe8LolEtrNSx/0wIK6FcDIiVE/dlS8VVmpAIlMmVavBGV3UPCpxAZOONUbi2/pGfhZQ7bazFkU/rg0tqLgRqVTPzkACuLgC7g5pB8S5TA2iJo8FkDX4oO+WzTIkOLMXnrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JA1S4oVq; arc=fail smtp.client-ip=40.107.200.65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BF2IluWdJ3zFzO9vN6PFNDKbdB04xZvD6bnOqNuCYacY1iYga5ZV4hiRDpsVI1+e3qCp5pZMwwaqt0To4wQlx/+LK9SlnYzmKOjqvmY+U23zWVAPeG5y0J9sLk+2P+bz5XAlr4/JcsgFZf4UIMluV2pxWN39H/SvRg4ColQtx+CyUZT5w3usZhwJd9pCVbbQA4LzIaCLfoQLRuT0CObsQ3b+BbIjkI/Av2F2TgnReERJ7s/9pw4Yz0xBF2K/eomie28RxvwR0u843UixS1ujHOrawLv3RvJAFBYNiJtAKX6kGm1/pzRbkuM5CajQJxWykcp4VtKtjLe+zweq5E+7Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8NsRfav2BmZHpCwlbQ9iJYhuWDsEP3WdAkyvFNjR7o=;
 b=MzdnQ5YgJ3LR1DZqOCUqgr927dzboUPxAvTFIGHkxNGdNHypWkm5CM4ogkbaoxCyNbYMfmtoyMDMvRSiIsvoyyMymPG31IuZhp53wLcjrUAD1tfLz56FUn5jxDV2s/gMxPB3S6nOLRrMQN+e4JLQ+EZTlxvCAT9ZG58XqwYvfubMCj8r0e3jtWv0IZeqXDACpqMwJSmmDBxaX3YqTYZe+PpgJE5Ox4uBLzLg2bclE9JIPJwqRlsgh5VbXfx7iTOuKX7jEkAGzPzIVYOh/BAm5RbnXhQG3EPHe086vMzne3ZXU8j1eGWlmHbdjlnqd3O7slh9bBXKLAWrncGcABdRTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8NsRfav2BmZHpCwlbQ9iJYhuWDsEP3WdAkyvFNjR7o=;
 b=JA1S4oVqzPGdyhvPGZQcxHBQxiKeAm4QIEbFwAqUiSS/TT/5etUyvdzJWmbjTQTZaibFl6A4+RhRXeQ7lZ6eWQVK+XyfAQrv8YBQzKWsCckquWB7HzA+8loCp2r0Wky2Rkp8h0PNI/i/K/AJh+LzggHtUk7uVSc14wP/DAZq2g2QII7zf0mXqOuTgiG8GO6yLpKr+pJwbNgz6c/vzmUM1aAlDBfd+lcWbxARsCCwRan3odL2kmquHztrfM1ScpfUVqzg4bm6I7XoYGy6QJWykTSyIag0XreHEJ/butjhCj3jeZuCpHieUH8lkkFpIL02/3GjCI94+V5v1DsLbeMxNg==
Received: from BN9PR03CA0667.namprd03.prod.outlook.com (2603:10b6:408:10e::12)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 13:57:54 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::48) by BN9PR03CA0667.outlook.office365.com
 (2603:10b6:408:10e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 13:57:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 13:57:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 06:57:39 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Jun 2026 06:57:39 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Jun 2026 06:57:34 -0700
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
Subject: [PATCH net-next V2 12/15] net/mlx5: LAG, add MPESW over SD LAG support
Date: Mon, 8 Jun 2026 16:55:44 +0300
Message-ID: <20260608135547.482825-13-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: 67102084-332f-447e-dd0b-08dec565f047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	B5ujzly09w5cTDLo3UeBeOcLnfvGzUIXxOvz5gMQRteIgdc+uCZ6B3iLaN9TranZww+Hoet/UfdPidE0lCsmDgM0AZTbvvLQwerc4DwzlaZhZwj9s5pGww/LWYOO6UYVfLPao/QYRQ/zHnLiTQXjwOxlS9oFBm889bTAmsr1o0IIQSJ5pHZqKK0thQXOqFxcVOYFWGIwdtP8lrPYENKc45S5M+6Qi6lPUk3q+h1zt706nMD55fvzbQmYAhdXk9P82+mr33JLZO7cmMN5g8FWx+InL+Cbfu9z5g2YIL+RwfxJdloJDbEC9e0rdEbFLfChLzhYdASXRsmqlTmCbqE5ABSWIEXBAizivpRKIkNpoe0960N5keDdb8U61npp6SxlKANprn8Mzvm7XIBXlpHcoabYIUeqIaQPdoF7uFV1jMXlLPTeNWzrQ2KRpkT84wB4YlWakll5CTnhEuhRVNlk032K91mO1c9HP3eQ9dkS19eWorlbHH8bLh76IBRi9etd2fw8noRUT57Axmk7DtzQU+f8AsvHMm3NjfVFNsFw8Dgxx4aPwN2JB2GcV42s54fvpJtRZYFYRNgRp0xRpOypztxcKVx6cCadMojrNTS7U8yLXbsDqtc6MZP6FdYeu+nOdZB61J6L/Zv8wjfpHfPdRjwjCY3t+2jw2FIQwbOVE8MzzAG5SVpByT3goF+p4qr7V7C3P8atlL2gFgY0FiiZwVNIRmgmkodnWM7S51fk8yM=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	41iTPGCvCzyXUdUjTCOZuoPCSficlTHJ9oLNcnf4MuDMnacDj6/LhUt7mrsF76xxw6ey4H5hunnMBaotCskSrJsLcK6Vsih1zlmhMdX4etHx7S4LPhN7sz+C6hMj4nZCZmO1oxsMLgInSX2bwbyh7OzmWSX6hkE+DVGEpTQWrICx6V3QXdm4lRrdOsLqqXRkiJ6HvVQxdKoXQnwILwKSsIFo0yv53IfxUcnO+2sAKQk6AQL7kjOgQFzXLBU8D8X2SQRVSrOq07pOV8+NXedLYUYlRs46JxHK/kx7/1rn6k282n6vOXTvMVud+dkFswSrwflibxhOE7ZAVILMC7AdCO34Dv/fnxnTDfaEikuhPhL7WloHTNVU3kUQ73+59pSaKHZDAx/p3m32KfbDrouKSgNs8YI/+keRZC4BVkqjWGEcoMjovgHoi20zHJunQduX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 13:57:54.4785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67102084-332f-447e-dd0b-08dec565f047
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-21968-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:moshe@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:dtatulea@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA608656F58

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


