Return-Path: <linux-rdma+bounces-21964-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WZAkLyfMJmrikgIAu9opvQ
	(envelope-from <linux-rdma+bounces-21964-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:05:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EDD656EAA
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:05:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=A35ANqT3;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21964-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21964-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53254309961C
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 13:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1F03C3456;
	Mon,  8 Jun 2026 13:57:42 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012028.outbound.protection.outlook.com [40.93.195.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCB23C0A10;
	Mon,  8 Jun 2026 13:57:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927062; cv=fail; b=cny/WHRy2sYM5kVQNMCPyfmwpg5xujqf/SepQD/N/Vrmtmxlr3xwtgSSVvclEuQ+R/Dz9eCOH/KTc7bDwyFcpUadRpEZAD/rXu+JRNSishWz32HfgIbPb1ifufRazMX7iVHjYJXTq1iGPpEA541j1hSVRk94vA4HXbv945CQapo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927062; c=relaxed/simple;
	bh=VgXq6M8XVl205C6as7WC8UDl21sko+5McOSyc8usBpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dL/9dXQKlpSEgc43VY5IvetTUvkDJLr/xlJIowzJa2DB3ZQRp8IoQTGd7zc4ZCOJh8bnd8xLMCA7uAGQI8qSkCRrLv3oExrCHUgQkHiVwJiUu3t3jAzr6NKO0PBJXwUNgkxmm8C9Kx7o5ShkFh3nvAxHVcLVmf2eddxbSRgcVQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A35ANqT3; arc=fail smtp.client-ip=40.93.195.28
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSdv6LFko+2gVbWVwU1T9DY0n9H738Opk7avxpclDZjwQGYgFWSPEIGCKMoUOkKXoSUv5bsQDEqhqXDx8L2e+pvbhF0GfFbDoKtrqH4bQi8g4LwDfImpn5JXn43VSFbNrvqSR9xjm7OYQ3jAe6ezyTOwKTTW9CVRITnd+X/5xfCdFVYAYhwGNGy7W8/762GXMUxRx0AwdxVbmKG1s6C5BycU+HXdI7zE7TxpvMMF4kE+oNsRNZcb4r8wHpqQDE2v6QTp+/piKBZwE8h1vAvpKG6x0N+Wqh5Z2reAWDm1BXNoU359OLnv2IOJzLbPoP9/6u9VJ+9IyRO02iF+QsYIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGLMv4Kby72lGJCau0SwTIznPOYS/SnrAgM7iJx1Dac=;
 b=MEIbsK6u/uWxHv5dgLDM8a5OpQSoPu+QgFgNIP3P/IbC+18r4f/s+403Ui7G6KJ+pMZpD5ssR6OgSL4W9LxnGcqnSgyz7CwIFmUPn+4PpPGu91HUxp8Sno4wdFFYg4XtlqIKC+8J7TCvXc7JNvNGcSGwBraE7+iKfkaQG339MvOPuQ95lnhtaBcZx4hcQWlYvqpxq0xW61LScymAUyT0QDfg7jD0P4liqOjOCEOBKlmQm3yXk5LiE1A9Yr+58a8zNHxNSoOnTINUeqkO+XuKhYOnBcqqkSHby27pJXlXILZeu4LYau5j9oOaaiXyr0OmJPh3W9F1m36U+k8dD+yxiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGLMv4Kby72lGJCau0SwTIznPOYS/SnrAgM7iJx1Dac=;
 b=A35ANqT3ChZ1OfXTv90OQ8eVsovsaz3J72+66VYb8wLGODcplh0cnH+HFD+x84KjhwfCcveYaE0nt13y8leUiva0s6OpQgRtILrwUoltGbN4EblfB5Oc+Fi2APMnnRofoHRtVkDx35rcyDBciVFkLxRvtwcKnTq4j/Xx4t1xROAwl1tFQT34PaM5tWDJdgZpITvEwcZQDhnXjwtTWBPj7EehxGN+yxovkcI5tZbIS73YAjLTPDHqT28E6QWdxXhjXq9I+7JQNFYDarCLlECwY4x9x/R0rC9HWOWHoY0gK5fHA5Y1riKHVOHN9lkE/HwM+S5aH2XLTgrYwqoE+pX+og==
Received: from BN0PR10CA0013.namprd10.prod.outlook.com (2603:10b6:408:143::17)
 by SA5PPF37951B1C9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 13:57:34 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:143:cafe::a7) by BN0PR10CA0013.outlook.office365.com
 (2603:10b6:408:143::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 13:57:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 13:57:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 06:57:17 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Jun 2026 06:57:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Jun 2026 06:57:11 -0700
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
Subject: [PATCH net-next V2 08/15] net/mlx5: E-Switch, notify SD on eswitch disable
Date: Mon, 8 Jun 2026 16:55:40 +0300
Message-ID: <20260608135547.482825-9-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|SA5PPF37951B1C9:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f916eae-91ea-4e35-43ec-08dec565e3d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xSlPMwYMp+vo94+fQKYxyvRuIDMQI067nm3YCT1UPc3vwT1+XwocsXv5vj5rIhFRWQvifRdJddW6Pc1ila+3YTQ6XZ/mvET0+Nn5GKvvsOpmuBgO/gv7ne+3EegWmp+DDArxb8p0nQTQ1jY6Zk/G7/Fi34dI0h+nWCaJl8YDIsjQ4+Me7Tayr0Lf2+FESzYSiMozX/14O0HEbJ2OH/QETwxjtTnu1+L2P7FwStThbVH+dt71I33QJvsUPoAbv4s+vwpoD1SZj/MfnEP2GFxGxiT5kJKmUccbrviLzvoKmWrttVPFZZVRk5ew7gpk2UgX4Df0YZjVX9EuHEEz5JeTFUjYAUOhz8IqIIwYd6gHUmYHu8T//QJ0lCpVmYMnbtekHlwGaxaZr/aH0n+wJLdNrpKOAOzYHFDLo6pbaMnjScxsqmUhpAmj1UXuFR+BtGNZOlJen56AGpxoni4qLxCftZAt79oogEAxHJpnRgzrApCmuDcWduLfwaYZvcIyTo3QmGYRSuH4DDJuEQGV+q0oka28Xe6k/x7NmpsuWLsw9JGlWMEPTd7ASSdiTo05SWj3G23FAyi5+rmldyrAufC0PdkiwhvkyFtf6Ja8XA8s5gh+ZFDv3h6eJdp/Tgc4E7g+WBS4thNqzSUORG5lhwcpxYoTwULWZD+kLiCCuGTcRqoKuws2ZbHu3letP7pfu6x+hOLzB03fnwv8I0aduW6ceCyW1FTwxOIQbEHYeR/gKfk=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ad2NkYRZx+pplGeW1pY/nnn3smtecZi+KMRXCqyNUT86rK9i856NBHnKW6Ix4x/HR0EwRwBmgv6KoTJSFGIbEouR14/19yhW0DPoxqc5eH6nnhneaRh0AQtTswVBKqp8w3BsWIhLxlCn16aol3oolWRVogO+V7ZOlYzJ4fpsHN5RgubdmbdgrUf76ioyONp6mkdrQj93n0i9zcZZdjSEBrD4+efJYDfyLASJqHpGIA7COSIH9BtR/TFhzfIvxST6Qy0Nniy99q8ztedaj9+568HHwNGqbr7xmKRX9LhefiT8+0a7TgR3gz7T1M9lAV/SYkTegIhZ5YxR+11lm5eLmi8L6HUBO378xrz5+ljBM2P6tQzWlXGBXcpq9qsBGMDpMpLMFtnCwJReXhA0IqdmauZMfwS1sBs4J2bAlMOJDimU/UjklxRcB8CHjYhDKRVG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 13:57:33.6204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f916eae-91ea-4e35-43ec-08dec565e3d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF37951B1C9
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
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-21964-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21EDD656EAA

From: Shay Drory <shayd@nvidia.com>

When eswitch is disabled, notify the SD layer so it can clean up
SD-specific resources such as the TX flow table root configuration
on secondary devices.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index f8cfbf76dd6a..93d51f09b17f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -2072,6 +2072,7 @@ void mlx5_eswitch_disable(struct mlx5_eswitch *esw)
 	mlx5_esw_reps_unblock(esw);
 
 	esw->mode = MLX5_ESWITCH_LEGACY;
+	mlx5_sd_eswitch_mode_set(esw->dev, MLX5_ESWITCH_LEGACY);
 	mlx5_lag_enable_change(esw->dev);
 }
 
-- 
2.44.0


