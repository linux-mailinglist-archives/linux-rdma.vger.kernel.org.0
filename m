Return-Path: <linux-rdma+bounces-21967-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Esn1IAjNJmodkwIAu9opvQ
	(envelope-from <linux-rdma+bounces-21967-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:09:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3027656F43
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:09:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=lz5jBfTb;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21967-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21967-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C10423011F0C
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 13:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBE03CEB84;
	Mon,  8 Jun 2026 13:57:59 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012020.outbound.protection.outlook.com [52.101.48.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F933C5832;
	Mon,  8 Jun 2026 13:57:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927079; cv=fail; b=dEgSj68jJdkMX0hLMf4ADV5wCy/JT/j7kHi5HzG2KLc+vS6w41tSTtMwYymHlgwh2pl994O7CbqEb+qkVHHJxHysSkTvFsE5e1idLDnGP8y8IP5kDL6+2nwogxl5C3jDMc9B2HmUYl3YzWxxF2Pr2AnNQTNDhdIIIaUE7UNYEYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927079; c=relaxed/simple;
	bh=HboRoWNmPoJ4EBNZJICrwkeILAXmrZVaOeyicSlePpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJjC5o5pxczwQiw18JjYUaX2C7wgax10Noz+nzOiEmoF3naa8tcFSB8JTaQ7hCyHClo7Xy4o3mWO3bRZG2GZGo18V7EknLKOSyxrSJNUMkdpc6Fi0r+R6TI8XCzJ9FSb/i7ck+UsyDOlr3nSPZ7ftmix+BtOy1xEXAFutrCk2Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lz5jBfTb; arc=fail smtp.client-ip=52.101.48.20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHL9QKVszduEEJTF3wqZ/CHrQ4U5t3phyyHQI2tMn1eJcep1AArtSvc/Q2jfbwBKx+9LU1lduvOrkQPCyf5sdXP5G7KUVlDn3PuuZhuvhiqroYs80GvRbURGXjpt63d52tzezM0bN8ncwUQoowOKXUxlc2IAqlobc9kVMCnmPurWLRBaeJYGXeQ6CbaOePcbtc7tJavEdL7O0zrLUaXXhKWmLjg9vzdgJFdAhzgQXwLoi1v0RZidwmm8coKzEEBOUp4BXyGOIVFUi4JRhalr4ILMnWg1h38fjvV4IOvhnkwlXRkUQkfe0x/ga9u6xFzYEVkpg/3yhUwf7NT/k3q3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWah90nIpVusnj1Ba0IuXz+hlEMxKAehNVMRT5rS4Bw=;
 b=b32yoRrH39096S3I0uvGaVJolxCFaJCo3OS0u74XNL8gPks2+wZYb3bc7IrnpOXbD7TsLUvLKn2+iYMRD0cFu9UAqGgHN/ktIEnvAyK4lcoFP35oKCG0NnhxT10CoOC4Blv6EHhV46GcCUCxDVn77jLFpW6ewiaxSOXR3QwhfMbulj+JU270GUDWmhWp1e/7COlk4DApJuQLhuWIjWMkHpn8XTkozQA2Sk3y2PxYysSY0yQeHdUg2/n5LN7L1S24R3ezOUZyVIpr/N0dHxL+dvP08D92VoOGI2TB7KI3XSHSiieyXdtCqSLihso82h9Gu9tP3NsbFDTMFXE/d94ZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWah90nIpVusnj1Ba0IuXz+hlEMxKAehNVMRT5rS4Bw=;
 b=lz5jBfTb/fGZycyUGS/siV3XjkuvqbGTNCplUKYdQ2iLRFu78O2BhvUKNTgmymqAy6+t9DJVVltFTcLioa/7RlT7UTBjd6DHDT6Q/Ugu83ye3ZEYjGTr0da+VPqXbhqPnmB+AnQ9ebNTKS3F3JlXq60ocAc8m/AXaxkjvVjibhmAdgPk4dAectHfoLzZqH9OYebHTaJV1eXf+d91U4J9WO5MOv1nVH0nfGLktjQo0LnFluEjkDVTucMkxj4Coq4hSSg/Uhco3aBYCwRvv/n6IcxvNF9Nt0Kb7Xpl+LzrJmR0N0uE7lvlmVajDqeg64MJGre6icrgPVBDItoNQNSg1w==
Received: from BN9PR03CA0678.namprd03.prod.outlook.com (2603:10b6:408:10e::23)
 by SJ0PR12MB7035.namprd12.prod.outlook.com (2603:10b6:a03:47c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 13:57:49 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::5a) by BN9PR03CA0678.outlook.office365.com
 (2603:10b6:408:10e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 13:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 13:57:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 06:57:33 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Jun 2026 06:57:33 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Jun 2026 06:57:28 -0700
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
Subject: [PATCH net-next V2 11/15] net/mlx5: LAG, introduce software vport LAG implementation
Date: Mon, 8 Jun 2026 16:55:43 +0300
Message-ID: <20260608135547.482825-12-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|SJ0PR12MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: ca027acd-61a4-48bd-f9fc-08dec565ed1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|56012099006|3023799007|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FsPbfku6q19jPTnd5KqodSm24lO3W1Q5sNbsAOEDORJshtiWpLzJhWOm9HcSov6L3o58Rs9g2qAzlQeso8HxVF4J+IQ6pRIabT0qzFEs3wfyZrJccXrQBQkXOT9vV2POWqPl62fSqoL5zr3GNcZToI37S+/Z+mgqQEHe/WtJTHEh1fhLFGo0aEWrBKqFq09VT10tTka++hSn3zPDxvDGulRQqekl/xq5r2048q+ES8x2Rd/bHKz1KUg77VTNTCRQA7HBaMFXAU5S1zXqkbwdkihIPhPuoJoII/C6zNe5NVOCgyVWXXpspu6SY34Qkg8Y3B2EdQH+3rqqGy8pK056kaQhoozSH4T3dTZr8a6w81fnR/pkhBHC1DRWsDQGXVJOL6NDJ67wL2vyVMVXG9bN+NcKy9JmS5hORfEJjlkoPlPkJzTBHFCyyEhUaPUR83IL4tMiWgoJ2YvXMJVe6lN3s4jFW+O5lpMO8fJ5BYoZD6Af/PsTeJ/KT72rTvWVvRAIH9/ewqVlaOkBk+FoDdnEN9fxudUaYG4wsThpkmNThoGV05bgFc1n8fN5QWuEs9Z6Zmfo0rhYGOOWURCBYqjeTwBMyTdUUJbuR/Dj6YERBpPPWuLBozeMnw4rUXDItNTzfFnvY3DGXmQkFirnwqxjU6G0U2BRPtuzlrBQoCd0Va1CoVspQKPJpV+pHqzkvmJklZCJyz+xoCA+JveepCOGKyC6HtOnn5DoR+XjLRo83Wk=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(56012099006)(3023799007)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bgGJyr+Yl4IIpeY5h8v3cCfT1JTKuoyfatL5UWrAhIssOTbFel4LIsvF4OFDTl2VC9XGnyn+GvDnNOiKUMRJRDnhj1hc1Lpuh6/zQAzb8a9mfWzDgFqPkDZCzIX7rTSJnvX3C4OrYCt1u+idThNLCxfKkwJ6+169GChPjRmOhtTxI+RylVCBD+Aj/LrbJSpdXCP4BbXf1gyYeVWbrpo9rf8ctwoZrW7lBZrdK9VNFpRnmc+cfUDSoUzaFMkn8SyhnQ42kqGYPwnq3laUGeVgJfF3nhy5zxh+ylCDYzmjznP6Bd7HeqtHaq3QvzeVaO+DLn8CNSYwNDJ5jy/JUzC+nGnCyO3mxRigkxohO0PGhqFHn09utQ6PXMBbclCLr0VG5Yggi77VQhOcvP9k/4dDYpbDayTX02Hy6wdqiBG4/Gfq0RDe76JWJFw2RONj1WTy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 13:57:49.1988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca027acd-61a4-48bd-f9fc-08dec565ed1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7035
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-21967-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3027656F43

From: Shay Drory <shayd@nvidia.com>

SD LAG is a virtual LAG without hardware LAG support, so it cannot use
the firmware vport LAG commands. Implement a software-based vport LAG
using egress ACL bounce rules.

Add esw_set_slave_egress_rule() to create an egress ACL rule on the
slave's manager vport that bounces traffic to the master's manager
vport. This achieves the same traffic steering as hardware vport LAG.

Redirect mlx5_cmd_create_vport_lag() and mlx5_cmd_destroy_vport_lag()
to the software implementation when operating in SD LAG mode.
In addition, adjust lag_demux creation to check SD LAG mode as well.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |   4 +
 .../mellanox/mlx5/core/eswitch_offloads.c     | 142 ++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  49 +++++-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  14 ++
 .../mellanox/mlx5/core/lag/shared_fdb.c       |  74 ++++++++-
 5 files changed, 280 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 94a530d19828..a5f0774834fe 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -950,6 +950,10 @@ void esw_vport_change_handle_locked(struct mlx5_vport *vport);
 
 bool mlx5_esw_offloads_controller_valid(const struct mlx5_eswitch *esw, u32 controller);
 
+int mlx5_eswitch_offloads_vport_lag_add_one(struct mlx5_eswitch *master_esw,
+					    struct mlx5_eswitch *slave_esw);
+void mlx5_eswitch_offloads_vport_lag_del_one(struct mlx5_eswitch *master_esw,
+					     struct mlx5_eswitch *slave_esw);
 int mlx5_eswitch_offloads_single_fdb_add_one(struct mlx5_eswitch *master_esw,
 					     struct mlx5_eswitch *slave_esw, int max_slaves);
 void mlx5_eswitch_offloads_single_fdb_del_one(struct mlx5_eswitch *master_esw,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 915571a1586c..a24719cfba34 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3041,6 +3041,136 @@ static int __esw_set_master_egress_rule(struct mlx5_core_dev *master,
 	return err;
 }
 
+static int esw_slave_egress_create_resources(struct mlx5_eswitch *esw,
+					     struct mlx5_vport *vport)
+{
+	struct mlx5_flow_table_attr ft_attr = {
+		.max_fte = 1, .prio = 0, .level = 0,
+	};
+	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
+	struct mlx5_flow_namespace *ns;
+	struct mlx5_flow_table *acl;
+	struct mlx5_flow_group *g;
+	u32 *flow_group_in;
+	int err = 0;
+
+	if (vport->egress.acl)
+		return 0;
+
+	xa_init_flags(&vport->egress.offloads.bounce_rules, XA_FLAGS_ALLOC);
+	ns = mlx5_get_flow_vport_namespace(esw->dev,
+					   MLX5_FLOW_NAMESPACE_ESW_EGRESS,
+					   vport->index);
+	if (!ns)
+		return -EINVAL;
+
+	flow_group_in = kvzalloc(inlen, GFP_KERNEL);
+	if (!flow_group_in)
+		return -ENOMEM;
+
+	if (vport->vport || mlx5_core_is_ecpf(esw->dev))
+		ft_attr.flags = MLX5_FLOW_TABLE_OTHER_VPORT;
+
+	acl = mlx5_create_vport_flow_table(ns, &ft_attr, vport->vport);
+	if (IS_ERR(acl)) {
+		err = PTR_ERR(acl);
+		goto out;
+	}
+
+	g = mlx5_create_flow_group(acl, flow_group_in);
+	if (IS_ERR(g)) {
+		err = PTR_ERR(g);
+		goto err_table;
+	}
+
+	vport->egress.acl = acl;
+	vport->egress.offloads.bounce_grp = g;
+	vport->egress.type = VPORT_EGRESS_ACL_TYPE_SHARED_FDB;
+	err = 0;
+
+err_table:
+	if (err && !IS_ERR_OR_NULL(acl)) {
+		mlx5_destroy_flow_table(acl);
+		vport->egress.acl = NULL;
+	}
+out:
+	kvfree(flow_group_in);
+	return err;
+}
+
+static void esw_slave_egress_destroy_resources(struct mlx5_vport *vport)
+{
+	if (!IS_ERR_OR_NULL(vport->egress.offloads.bounce_grp)) {
+		mlx5_destroy_flow_group(vport->egress.offloads.bounce_grp);
+		vport->egress.offloads.bounce_grp = NULL;
+	}
+	if (!IS_ERR_OR_NULL(vport->egress.acl)) {
+		esw_acl_egress_ofld_cleanup(vport);
+		xa_destroy(&vport->egress.offloads.bounce_rules);
+	}
+}
+
+static int esw_set_slave_egress_rule(struct mlx5_core_dev *master,
+				     struct mlx5_core_dev *slave)
+{
+	struct mlx5_eswitch *slave_esw = slave->priv.eswitch;
+	u16 master_vhca = MLX5_CAP_GEN(master, vhca_id);
+	struct mlx5_flow_destination dest = {};
+	struct mlx5_flow_handle *bounce_rule;
+	struct mlx5_flow_act flow_act = {};
+	struct mlx5_vport *slave_vport;
+	int err;
+
+	slave_vport = mlx5_eswitch_get_vport(slave_esw,
+					     slave_esw->manager_vport);
+	if (IS_ERR(slave_vport))
+		return PTR_ERR(slave_vport);
+
+	err = esw_slave_egress_create_resources(slave_esw, slave_vport);
+	if (err)
+		return err;
+
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
+	dest.type = MLX5_FLOW_DESTINATION_TYPE_VPORT;
+	dest.vport.num = master->priv.eswitch->manager_vport;
+	dest.vport.vhca_id = master_vhca;
+	dest.vport.flags = MLX5_FLOW_DEST_VPORT_VHCA_ID;
+
+	bounce_rule = mlx5_add_flow_rules(slave_vport->egress.acl, NULL,
+					  &flow_act, &dest, 1);
+	if (IS_ERR(bounce_rule)) {
+		err = PTR_ERR(bounce_rule);
+		goto err_rule;
+	}
+	err = xa_insert(&slave_vport->egress.offloads.bounce_rules,
+			master_vhca, bounce_rule, GFP_KERNEL);
+	if (err)
+		goto err_insert;
+
+	return 0;
+err_insert:
+	mlx5_del_flow_rules(bounce_rule);
+err_rule:
+	esw_slave_egress_destroy_resources(slave_vport);
+	return err;
+}
+
+static void esw_unset_slave_egress_rule(struct mlx5_core_dev *master,
+					struct mlx5_core_dev *slave)
+{
+	struct mlx5_eswitch *slave_esw = slave->priv.eswitch;
+	u16 master_vhca = MLX5_CAP_GEN(master, vhca_id);
+	struct mlx5_vport *slave_vport;
+
+	slave_vport = mlx5_eswitch_get_vport(slave_esw,
+					     slave_esw->manager_vport);
+	if (IS_ERR(slave_vport))
+		return;
+
+	esw_acl_egress_ofld_bounce_rule_destroy(slave_vport, master_vhca);
+	esw_slave_egress_destroy_resources(slave_vport);
+}
+
 static int esw_master_egress_create_resources(struct mlx5_eswitch *esw,
 					      struct mlx5_flow_namespace *egress_ns,
 					      struct mlx5_vport *vport, size_t count)
@@ -3208,6 +3338,18 @@ void mlx5_eswitch_offloads_single_fdb_del_one(struct mlx5_eswitch *master_esw,
 	esw_unset_master_egress_rule(master_esw->dev, slave_esw->dev);
 }
 
+int mlx5_eswitch_offloads_vport_lag_add_one(struct mlx5_eswitch *master_esw,
+					    struct mlx5_eswitch *slave_esw)
+{
+	return esw_set_slave_egress_rule(master_esw->dev, slave_esw->dev);
+}
+
+void mlx5_eswitch_offloads_vport_lag_del_one(struct mlx5_eswitch *master_esw,
+					     struct mlx5_eswitch *slave_esw)
+{
+	esw_unset_slave_egress_rule(master_esw->dev, slave_esw->dev);
+}
+
 #define ESW_OFFLOADS_DEVCOM_PAIR	(0)
 #define ESW_OFFLOADS_DEVCOM_UNPAIR	(1)
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 84eff995cad1..06e1a61d1f58 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -139,9 +139,44 @@ static int mlx5_cmd_modify_lag(struct mlx5_core_dev *dev, struct mlx5_lag *ldev,
 	return mlx5_cmd_exec_in(dev, modify_lag, in);
 }
 
+static u32 mlx5_lag_dev_group_id(struct mlx5_core_dev *dev)
+{
+	struct mlx5_lag *ldev = mlx5_lag_dev(dev);
+	struct lag_func *pf;
+	int i;
+
+	if (!ldev)
+		return 0;
+
+	mlx5_lag_for_each(i, 0, ldev, MLX5_LAG_FILTER_ALL) {
+		pf = mlx5_lag_pf(ldev, i);
+		if (pf->dev == dev)
+			return pf->sd_fdb_active ? pf->group_id : 0;
+	}
+	return 0;
+}
+
+static int mlx5_lag_is_sw_lag(struct mlx5_core_dev *dev)
+{
+	return mlx5_lag_is_sd(dev);
+}
+
 int mlx5_cmd_create_vport_lag(struct mlx5_core_dev *dev)
 {
 	u32 in[MLX5_ST_SZ_DW(create_vport_lag_in)] = {};
+	struct mlx5_lag *ldev = mlx5_lag_dev(dev);
+	int ret;
+
+	if (mlx5_lag_is_sw_lag(dev)) {
+		if (!ldev)
+			return -ENODEV;
+
+		mutex_lock(&ldev->lock);
+		ret = mlx5_lag_create_vport_lag(mlx5_lag_dev(dev),
+						mlx5_lag_dev_group_id(dev));
+		mutex_unlock(&ldev->lock);
+		return ret;
+	}
 
 	MLX5_SET(create_vport_lag_in, in, opcode, MLX5_CMD_OP_CREATE_VPORT_LAG);
 
@@ -152,6 +187,18 @@ EXPORT_SYMBOL(mlx5_cmd_create_vport_lag);
 int mlx5_cmd_destroy_vport_lag(struct mlx5_core_dev *dev)
 {
 	u32 in[MLX5_ST_SZ_DW(destroy_vport_lag_in)] = {};
+	struct mlx5_lag *ldev = mlx5_lag_dev(dev);
+
+	if (mlx5_lag_is_sw_lag(dev)) {
+		if (!ldev)
+			return 0;
+
+		mutex_lock(&ldev->lock);
+		mlx5_lag_destroy_vport_lag(mlx5_lag_dev(dev),
+					   mlx5_lag_dev_group_id(dev));
+		mutex_unlock(&ldev->lock);
+		return 0;
+	}
 
 	MLX5_SET(destroy_vport_lag_in, in, opcode, MLX5_CMD_OP_DESTROY_VPORT_LAG);
 
@@ -1663,7 +1710,7 @@ int mlx5_lag_demux_init(struct mlx5_core_dev *dev,
 
 	xa_init(&pf->lag_demux_rules);
 
-	if (mlx5_get_sd(dev))
+	if (mlx5_lag_is_sw_lag(dev))
 		return mlx5_lag_demux_ft_fg_init(dev, ft_attr, pf);
 
 	return mlx5_lag_demux_fw_init(dev, ft_attr, pf);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index d645c2cfca4d..57e6f82713b0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -175,6 +175,8 @@ int mlx5_lag_shared_fdb_create(struct mlx5_lag *ldev,
 			       enum mlx5_lag_mode mode,
 			       u32 group_id);
 void mlx5_lag_shared_fdb_destroy(struct mlx5_lag *ldev, u32 group_id);
+int mlx5_lag_create_vport_lag(struct mlx5_lag *ldev, u32 group_id);
+int mlx5_lag_destroy_vport_lag(struct mlx5_lag *ldev, u32 group_id);
 int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev);
 void mlx5_lag_destroy_single_fdb(struct mlx5_lag *ldev);
 bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev);
@@ -191,6 +193,18 @@ static inline int mlx5_lag_shared_fdb_create(struct mlx5_lag *ldev,
 static inline void mlx5_lag_shared_fdb_destroy(struct mlx5_lag *ldev,
 					       u32 group_id) {}
 
+static inline int mlx5_lag_create_vport_lag(struct mlx5_lag *ldev,
+					    u32 group_id)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int mlx5_lag_destroy_vport_lag(struct mlx5_lag *ldev,
+					     u32 group_id)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev)
 {
 	return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
index 1371e14c4c13..8d4f2903a101 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
@@ -89,6 +89,76 @@ static int mlx5_lag_create_single_fdb_filter(struct mlx5_lag *ldev, u32 filter)
 	return err;
 }
 
+int mlx5_lag_create_vport_lag(struct mlx5_lag *ldev, u32 group_id)
+{
+	u32 filter = group_id ? group_id : MLX5_LAG_FILTER_ALL;
+	int master_idx = mlx5_lag_get_dev_index_by_seq_filter(ldev, MLX5_LAG_P1,
+							     filter);
+	struct mlx5_eswitch *master_esw;
+	struct mlx5_core_dev *dev0;
+	int i, j;
+	int err;
+
+	if (master_idx < 0)
+		return -EINVAL;
+
+	dev0 = mlx5_lag_pf(ldev, master_idx)->dev;
+	master_esw = dev0->priv.eswitch;
+
+	mlx5_lag_for_each(i, 0, ldev, filter) {
+		struct mlx5_eswitch *slave_esw;
+
+		if (i == master_idx)
+			continue;
+
+		slave_esw = mlx5_lag_pf(ldev, i)->dev->priv.eswitch;
+		err = mlx5_eswitch_offloads_vport_lag_add_one(master_esw,
+							      slave_esw);
+		if (err)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	mlx5_lag_for_each_reverse(j, i - 1, 0, ldev, filter) {
+		struct mlx5_eswitch *slave_esw;
+
+		if (j == master_idx)
+			continue;
+		slave_esw = mlx5_lag_pf(ldev, j)->dev->priv.eswitch;
+		mlx5_eswitch_offloads_vport_lag_del_one(master_esw, slave_esw);
+	}
+	return err;
+}
+
+int mlx5_lag_destroy_vport_lag(struct mlx5_lag *ldev, u32 group_id)
+{
+	u32 filter = group_id ? group_id : MLX5_LAG_FILTER_ALL;
+	int master_idx = mlx5_lag_get_dev_index_by_seq_filter(ldev, MLX5_LAG_P1,
+							     filter);
+	struct mlx5_eswitch *master_esw;
+	struct mlx5_core_dev *dev0;
+	int i;
+
+	if (master_idx < 0)
+		return 0;
+
+	dev0 = mlx5_lag_pf(ldev, master_idx)->dev;
+	master_esw = dev0->priv.eswitch;
+
+	mlx5_lag_for_each(i, 0, ldev, filter) {
+		struct mlx5_core_dev *dev;
+
+		if (i == master_idx)
+			continue;
+		dev = mlx5_lag_pf(ldev, i)->dev;
+		mlx5_eswitch_offloads_vport_lag_del_one(master_esw,
+							dev->priv.eswitch);
+	}
+	return 0;
+}
+
 static void mlx5_lag_destroy_single_fdb_filter(struct mlx5_lag *ldev,
 					       u32 filter)
 {
@@ -141,7 +211,7 @@ int mlx5_lag_shared_fdb_create(struct mlx5_lag *ldev,
 			       enum mlx5_lag_mode mode,
 			       u32 group_id)
 {
-	u32 filter = group_id ? group_id : MLX5_LAG_FILTER_PORTS;
+	u32 filter = group_id ? group_id : MLX5_LAG_FILTER_ALL;
 	int idx = mlx5_lag_get_dev_index_by_seq_filter(ldev, MLX5_LAG_P1,
 						       filter);
 	struct mlx5_core_dev *dev0;
@@ -209,7 +279,7 @@ int mlx5_lag_shared_fdb_create(struct mlx5_lag *ldev,
 
 void mlx5_lag_shared_fdb_destroy(struct mlx5_lag *ldev, u32 group_id)
 {
-	u32 filter = group_id ? group_id : MLX5_LAG_FILTER_PORTS;
+	u32 filter = group_id ? group_id : MLX5_LAG_FILTER_ALL;
 	struct lag_func *pf;
 	int err;
 	int i;
-- 
2.44.0


