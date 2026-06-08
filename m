Return-Path: <linux-rdma+bounces-21966-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /cokGPTMJmobkwIAu9opvQ
	(envelope-from <linux-rdma+bounces-21966-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:08:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B4E656F3B
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:08:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=aTWKLNY1;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21966-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21966-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15A9C30AC694
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 13:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A773C345C;
	Mon,  8 Jun 2026 13:57:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C11D3C379C;
	Mon,  8 Jun 2026 13:57:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927074; cv=fail; b=PtecqjM32upczow0cw5aJ23wNF06F17eEG+9knxjWAFGOhFRbIt4zNJCbf5hFiFADYM9LcTErUCcsb/X4NjPfRQdqlSB+t5ZPJaobMVxgek7I5r6ke0SfF19OYtpVy0G1Z40O3vIUxwEyDQTyODSXs6NtswDSXfqn6tq89t+L5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927074; c=relaxed/simple;
	bh=Z/4gpx6VstyCVW03PzpCd/BGXx5Vtn9OHt/ijK9Sf94=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TizPN0o3Uxq6QjkoSIeWQgiBV4zNcx3cBPHa7k3YjszRqRdzbYMkuB3kdyUYzKvtbLEZigpE2MbzwRYrhA0zFl49zTJbZE4DMCO80DlvuZnZ7Uv5zNijGLZ51Vnbh3uYsXxIbw7K8IBxAIaHNahLyN++1tNCjgoPz8GyJbj2Rn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aTWKLNY1; arc=fail smtp.client-ip=52.101.43.3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ak9NgQ8Wrwjez5EPxOHXJZ15Ir3Szvyg0bOgqFn7Eu+jQcQ/cuFQ2RX7IZ3N2hsmUTdUeitn772fSgZlO3XC3Dw4EFjzfpRp7w3GuV3n6X+HifrClUrLLfCoGc9N+cuGqB5dQxn2dNN68xbOjFjX76gHA4cFrIBH86iBRGzFEUzkwOi/OFoUZ7n4p8ciiUQfT+i+45hS6R125o5wShrc//4t1ctuDrsK837uLpxfVID7Eb4pOVDzOE04p5kAQb4aG7fvQVSO6ToLRvkNWcORW4yqgX+ey85nlDySMoKLp1pHVvL/OzCp0DZc9LOuO5A5ydMyzEXSgOApB38q5BDI3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oaAA6R29GttAJySUj33/K4yDMna8Qo2SfZ5+qAqXC0=;
 b=Fcxy4e2hsiQqLlZK3sufUpYGdVcqll8k15EeDHdEGWIfpRyWRYTsqDIkIlIFDZ2JJ3RL8Wm0UqEPCesR5vC5Kij6y+Zux7BY3xgit/vMSi+5UtoTSRdBlq/IqErJDJ7BXZk3Z6PayKSCj/D4zbX543apZV2xh0GVFaTtlyUlnxc4rDgTFQf3WjAiewFYyYgM+kdsKEm9iB5xE6uNqlO2AsLQuLcljJ65eDTMrGt6UvXXHB5clWQuIVjSlLugiL2e+myUeuo2qg3ND2J1KPYE/Q2mftorNbO9xXagmFzMdOkjho739j/1zKIg3TQS0Ard1wwVKNJ8R6c1Is270P2KIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oaAA6R29GttAJySUj33/K4yDMna8Qo2SfZ5+qAqXC0=;
 b=aTWKLNY1AILRSQqBbBI4Sv0DwGkc1GFlXz7Zp22EMJtAl+LQFteNU5r5LGveBmLK60gvVmPKiroDV0KQSSya7vBGfnahFEL3Vyn6ltjo5XRKhO7+h6WssHeDY6U4BTAtFk0Pu/SooBNuNkiK2BuITYPrqC9uhgXfPlcWEZKEFPO8r2bRSQt7K1S/BoCXEeaZtKbWX8hUm4R97Z9SCQhjdAMQTqkALfHImOthx7sza0VuWEomYyYLAipvuAWZZsn1GhzCil6uWPIwcO3fFFQlM4Q68NUkSzecE3M03UOtBD1mhwFuwYSEHpNbvmwjUCzhjl/UEuoBBikiXTcQ/VXWhw==
Received: from MN2PR06CA0013.namprd06.prod.outlook.com (2603:10b6:208:23d::18)
 by IA1PR12MB6458.namprd12.prod.outlook.com (2603:10b6:208:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 13:57:40 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:208:23d:cafe::61) by MN2PR06CA0013.outlook.office365.com
 (2603:10b6:208:23d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 13:57:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 13:57:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 06:57:22 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Jun 2026 06:57:22 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Jun 2026 06:57:17 -0700
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
Subject: [PATCH net-next V2 09/15] net/mlx5: LAG, store demux resources per master lag_func
Date: Mon, 8 Jun 2026 16:55:41 +0300
Message-ID: <20260608135547.482825-10-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|IA1PR12MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: ca32d8db-33fd-4404-b2df-08dec565e794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|6133799003|3023799007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	5jMXoQ3OPuWUwLsj+iiGpiJM/CMSol5OTAutsVmRh5shLsu+G7pCwZHsyuTFMRJqCsFK2JgWieqNpL3yFlEOuRnLM3djCLEBVyKhEcQKzIeDfAAYnH7UrRMiGWaB4k3G5IsKOJSZypzF7+vsOV5wrbuIhv1SzTliMUAZ7ditridgV5fq73RgHwffrqJGuhvp/By1ttQiidfEx60rPSJKN/qdk7QOEr7hWFPHkE6ZCsZn0FVsxyQ0O+EmsLzXYI/GY5i3eYu/U3e6dGeBjHqr358eYvBa65L3GqzQZkdY09kyx71zM+VjNjUEs9vNVqibIhcfuVWUKl7XFDSTcVeGCDVy5beDQZnOIiazeFCC63wC2wb01aZkXaJcgQON6/UrXdxf1Sjgfd9g1dBoRdj29RMpYb4dKnEEPl20d6RCoDxgEGKvSQi28G9+iRoKi4+KW6oM4vjzk2WZq25+J/FbvFp4Djo0P30zzWimn8VLnVooN3tKONNonBtWCT7qtEAHyfEWUYFkQ0o+h/SaQa2KPkjs85HjcJlEGSPnpu4rtOR72huGYAHIehdpCiqISxZHc9+8LjcoyeZqLnedB7D6OWjtFmUCLubH8fqSSgpj57IHizSyH7RbAVFI+1Duu+Bu3dTHoVj9jaLY70iGeTn5iW3teFQVGw61tS0q1hd2A4KKHat5cM2e901nH95xJJVijWIm+XthQ/59cI1gCQwnq+zP2+iL+YXsyedMW43wXVM=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2lDafdf4oOkts9Av9DV7xCTqdKMG2jJRKBvxxq8MpmGc4+kMCd/14vdeQc1rDh0jxV0d2wmg9qPWaYiwqPDlZQVTQdqAr7NqoNNu+zlxZurInSgEcVejSKSwoYDFhUw0hrbv1g8TNVuEWOmqfQPGFxOr6wNbOasRzrSk644NCJyarQdCd41Vd4MENj7yOgYM/7+QnHTljT1DNalvL4Qy+UVqR/OyOvcgpMttI+RwmeBNHvIBdOGntEKYNO6MkalaL7klaF01fSeoRK6DwqnGEaVx6AP+o7wB+j7FDcnr97yBd/EGxVUr1m2h8I1NUAxENioVO8ot6UKJm8ui6KCht7lCDXz9T2FpjeraWMpg3c1gNx0/LIWTbL1PSWzXnOZwmyIeYveUvauErWf3hYbpU2kLWzVU36G7Nuq857cLoDcJPerKgh1UvMWhm38jYEG/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 13:57:39.8866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca32d8db-33fd-4404-b2df-08dec565e794
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458
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
	TAGGED_FROM(0.00)[bounces-21966-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: B5B4E656F3B

From: Shay Drory <shayd@nvidia.com>

The lag demux resources (flow table, flow group, and rules xarray)
are stored on the shared ldev. With Socket Direct, multiple SD groups
each create their own demux FT/FG during their master's IB device
initialization. Since they all write to the same ldev fields, the
second group's init overwrites the first group's pointers, leaking
the first group's FT/FG.

During teardown, the cleanup uses the overwritten pointers, destroying
the wrong group's resources and leaving leaked flow tables in the LAG
namespace. These leaked tables can interfere with subsequently created
demux tables.

Move the demux resources from the shared ldev to per-master lag_func
instances. Each master device now owns its own independent demux
state. The rule_add and rule_del helpers look up the appropriate
master's lag_func via the existing filter/group infrastructure.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 95 +++++++++++++------
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  7 +-
 2 files changed, 68 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index dd3f18f85466..e23c1e81b98f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1590,7 +1590,7 @@ struct mlx5_devcom_comp_dev *mlx5_lag_get_devcom_comp(struct mlx5_lag *ldev)
 
 static int mlx5_lag_demux_ft_fg_init(struct mlx5_core_dev *dev,
 				     struct mlx5_flow_table_attr *ft_attr,
-				     struct mlx5_lag *ldev)
+				     struct lag_func *pf)
 {
 #ifdef CONFIG_MLX5_ESWITCH
 	struct mlx5_flow_namespace *ns;
@@ -1601,20 +1601,20 @@ static int mlx5_lag_demux_ft_fg_init(struct mlx5_core_dev *dev,
 	if (!ns)
 		return 0;
 
-	ldev->lag_demux_ft = mlx5_create_flow_table(ns, ft_attr);
-	if (IS_ERR(ldev->lag_demux_ft))
-		return PTR_ERR(ldev->lag_demux_ft);
+	pf->lag_demux_ft = mlx5_create_flow_table(ns, ft_attr);
+	if (IS_ERR(pf->lag_demux_ft))
+		return PTR_ERR(pf->lag_demux_ft);
 
 	fg = mlx5_esw_lag_demux_fg_create(dev->priv.eswitch,
-					  ldev->lag_demux_ft);
+					  pf->lag_demux_ft);
 	if (IS_ERR(fg)) {
 		err = PTR_ERR(fg);
-		mlx5_destroy_flow_table(ldev->lag_demux_ft);
-		ldev->lag_demux_ft = NULL;
+		mlx5_destroy_flow_table(pf->lag_demux_ft);
+		pf->lag_demux_ft = NULL;
 		return err;
 	}
 
-	ldev->lag_demux_fg = fg;
+	pf->lag_demux_fg = fg;
 	return 0;
 #else
 	return -EOPNOTSUPP;
@@ -1623,7 +1623,7 @@ static int mlx5_lag_demux_ft_fg_init(struct mlx5_core_dev *dev,
 
 static int mlx5_lag_demux_fw_init(struct mlx5_core_dev *dev,
 				  struct mlx5_flow_table_attr *ft_attr,
-				  struct mlx5_lag *ldev)
+				  struct lag_func *pf)
 {
 	struct mlx5_flow_namespace *ns;
 	int err;
@@ -1632,12 +1632,12 @@ static int mlx5_lag_demux_fw_init(struct mlx5_core_dev *dev,
 	if (!ns)
 		return 0;
 
-	ldev->lag_demux_fg = NULL;
+	pf->lag_demux_fg = NULL;
 	ft_attr->max_fte = 1;
-	ldev->lag_demux_ft = mlx5_create_lag_demux_flow_table(ns, ft_attr);
-	if (IS_ERR(ldev->lag_demux_ft)) {
-		err = PTR_ERR(ldev->lag_demux_ft);
-		ldev->lag_demux_ft = NULL;
+	pf->lag_demux_ft = mlx5_create_lag_demux_flow_table(ns, ft_attr);
+	if (IS_ERR(pf->lag_demux_ft)) {
+		err = PTR_ERR(pf->lag_demux_ft);
+		pf->lag_demux_ft = NULL;
 		return err;
 	}
 
@@ -1648,6 +1648,7 @@ int mlx5_lag_demux_init(struct mlx5_core_dev *dev,
 			struct mlx5_flow_table_attr *ft_attr)
 {
 	struct mlx5_lag *ldev;
+	struct lag_func *pf;
 
 	if (!ft_attr)
 		return -EINVAL;
@@ -1656,12 +1657,16 @@ int mlx5_lag_demux_init(struct mlx5_core_dev *dev,
 	if (!ldev)
 		return -ENODEV;
 
-	xa_init(&ldev->lag_demux_rules);
+	pf = mlx5_lag_pf_by_dev(ldev, dev);
+	if (!pf)
+		return -ENODEV;
+
+	xa_init(&pf->lag_demux_rules);
 
 	if (mlx5_get_sd(dev))
-		return mlx5_lag_demux_ft_fg_init(dev, ft_attr, ldev);
+		return mlx5_lag_demux_ft_fg_init(dev, ft_attr, pf);
 
-	return mlx5_lag_demux_fw_init(dev, ft_attr, ldev);
+	return mlx5_lag_demux_fw_init(dev, ft_attr, pf);
 }
 EXPORT_SYMBOL(mlx5_lag_demux_init);
 
@@ -1670,40 +1675,63 @@ void mlx5_lag_demux_cleanup(struct mlx5_core_dev *dev)
 	struct mlx5_flow_handle *rule;
 	struct mlx5_lag *ldev;
 	unsigned long vport_num;
+	struct lag_func *pf;
 
 	ldev = mlx5_lag_dev(dev);
 	if (!ldev)
 		return;
 
-	xa_for_each(&ldev->lag_demux_rules, vport_num, rule)
+	pf = mlx5_lag_pf_by_dev(ldev, dev);
+	if (!pf)
+		return;
+
+	xa_for_each(&pf->lag_demux_rules, vport_num, rule)
 		mlx5_del_flow_rules(rule);
-	xa_destroy(&ldev->lag_demux_rules);
+	xa_destroy(&pf->lag_demux_rules);
 
-	if (ldev->lag_demux_fg)
-		mlx5_destroy_flow_group(ldev->lag_demux_fg);
-	if (ldev->lag_demux_ft)
-		mlx5_destroy_flow_table(ldev->lag_demux_ft);
-	ldev->lag_demux_fg = NULL;
-	ldev->lag_demux_ft = NULL;
+	if (pf->lag_demux_fg)
+		mlx5_destroy_flow_group(pf->lag_demux_fg);
+	if (pf->lag_demux_ft)
+		mlx5_destroy_flow_table(pf->lag_demux_ft);
+	pf->lag_demux_fg = NULL;
+	pf->lag_demux_ft = NULL;
 }
 EXPORT_SYMBOL(mlx5_lag_demux_cleanup);
 
+static struct lag_func *mlx5_lag_dev_get_master_pf(struct mlx5_lag *ldev,
+						   struct mlx5_core_dev *dev)
+{
+	u32 filter = mlx5_lag_get_filter(ldev, dev);
+	int idx;
+
+	idx = mlx5_lag_get_dev_index_by_seq_filter(ldev, MLX5_LAG_P1, filter);
+	if (idx < 0)
+		return NULL;
+
+	return mlx5_lag_pf(ldev, idx);
+}
+
 int mlx5_lag_demux_rule_add(struct mlx5_core_dev *vport_dev, u16 vport_num,
 			    int index)
 {
 	struct mlx5_flow_handle *rule;
+	struct lag_func *master;
 	struct mlx5_lag *ldev;
 	int err;
 
 	ldev = mlx5_lag_dev(vport_dev);
-	if (!ldev || !ldev->lag_demux_fg)
+	if (!ldev)
 		return 0;
 
-	if (xa_load(&ldev->lag_demux_rules, index))
+	master = mlx5_lag_dev_get_master_pf(ldev, vport_dev);
+	if (!master || !master->lag_demux_fg)
+		return 0;
+
+	if (xa_load(&master->lag_demux_rules, index))
 		return 0;
 
 	rule = mlx5_esw_lag_demux_rule_create(vport_dev->priv.eswitch,
-					      vport_num, ldev->lag_demux_ft);
+					      vport_num, master->lag_demux_ft);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
 		mlx5_core_warn(vport_dev,
@@ -1712,7 +1740,7 @@ int mlx5_lag_demux_rule_add(struct mlx5_core_dev *vport_dev, u16 vport_num,
 		return err;
 	}
 
-	err = xa_err(xa_store(&ldev->lag_demux_rules, index, rule,
+	err = xa_err(xa_store(&master->lag_demux_rules, index, rule,
 			      GFP_KERNEL));
 	if (err) {
 		mlx5_del_flow_rules(rule);
@@ -1728,13 +1756,18 @@ EXPORT_SYMBOL(mlx5_lag_demux_rule_add);
 void mlx5_lag_demux_rule_del(struct mlx5_core_dev *dev, int index)
 {
 	struct mlx5_flow_handle *rule;
+	struct lag_func *master_pf;
 	struct mlx5_lag *ldev;
 
 	ldev = mlx5_lag_dev(dev);
-	if (!ldev || !ldev->lag_demux_fg)
+	if (!ldev)
+		return;
+
+	master_pf = mlx5_lag_dev_get_master_pf(ldev, dev);
+	if (!master_pf || !master_pf->lag_demux_fg)
 		return;
 
-	rule = xa_erase(&ldev->lag_demux_rules, index);
+	rule = xa_erase(&master_pf->lag_demux_rules, index);
 	if (rule)
 		mlx5_del_flow_rules(rule);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index 0296f752bb4c..d645c2cfca4d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -59,6 +59,10 @@ struct lag_func {
 	struct mlx5_nb port_change_nb;
 	u32 group_id;        /* SD group ID, 0 = not SD */
 	bool sd_fdb_active;  /* set on all SD group members */
+	/* Lag demux resources - only populated on master devices */
+	struct mlx5_flow_table   *lag_demux_ft;
+	struct mlx5_flow_group   *lag_demux_fg;
+	struct xarray		  lag_demux_rules;
 };
 
 /* Used for collection of netdev event info. */
@@ -95,9 +99,6 @@ struct mlx5_lag {
 	/* Protect lag fields/state changes */
 	struct mutex		  lock;
 	struct lag_mpesw	  lag_mpesw;
-	struct mlx5_flow_table   *lag_demux_ft;
-	struct mlx5_flow_group   *lag_demux_fg;
-	struct xarray		  lag_demux_rules;
 };
 
 static inline struct mlx5_lag *
-- 
2.44.0


