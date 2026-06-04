Return-Path: <linux-rdma+bounces-21757-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zYVdKSdpIWodGAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21757-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 14:01:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA5363FABE
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 14:01:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=gVnIl+ww;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21757-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21757-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF701314AD1C
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 11:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE28C44D001;
	Thu,  4 Jun 2026 11:46:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013045.outbound.protection.outlook.com [40.107.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A367C43CEE9;
	Thu,  4 Jun 2026 11:46:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573598; cv=fail; b=iR8i2oBGdAfBSDLE4sCsPoJP/XaMyHKJv6s3tw7cdVwUXpLzoRq1+CxCnUroMnY9jPnOt1GogyHY5KL6/j44ICdfQxlyW1MnJxdoyytKmE77ihwt7zAFkOfImDFLlpDNZ2rCZ8flbB4FrPDuoPUDwfJAdTWErGG5PUt30A2gMbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573598; c=relaxed/simple;
	bh=H4AgOUu3CCZa9yPnC9NVhBkmq4c1hyOLpsHKVXyZkVE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNd1zmbOapG3eXrDrjdlMt1Ldx05CPGiLCrIb3DvNtxfGrhNZFL+Oqr19cpdiCFwY0tyH0zU7rPDAl2HDBCu0mxkepC8+77Oiqqumxj0PrsRfgRoBYjWm1qDCwesHcwh49JURrRZ6cd03cvFcqHvpxJsAIi612Nm7hL7qJHPSCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gVnIl+ww; arc=fail smtp.client-ip=40.107.201.45
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMcivWMZ730BCRzukpts5nMZJUIVGCV/ukr3gRIx+cTzSTiIGx7n4Lmu+h32DnzuD70HemwDGhSZvnV4hIM/oNj0Vebl4KQxWI69gaz/lWFqFj6kMICXCTiJY+M+md7TwP3LdMvYU+NQyMsOBPzbnxvFs7jJ6QDwvkUc721h+7BFzO4VlGQZTQ57w74WY2XdSvxabm+qGYoXzytgQOLZi6YYrvRK/rNtbk0O5xUXb05jaD+mGr0m5+EmlNra2yc7Mtb2aDciN4jcCVZ3Uk8a+Y8/6+56E7ZVS7U/964CSrACDMbDyJrh6P6bt6pABBPSCCN9vxbSoDyfZvHcafJr2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXTsoDag5F/DayBU+Ott+tNPrAl0MXEG+LyND2iN3kk=;
 b=cAb78GzStzZjWviK5G05iOws8eeRKnagtqZpgpzi1nCqVqkAlWvNwIkDUfLFgdvTy15mC7Is7BazzgZOItGlh3sJI98MVTrCJtAKaklULpnT4mg9XpJAC429KHU61xpBS2NQ9TsCd+3CJqMcsB51XpGaS0W+E4o+0r3bNfhgveOyu6zR1DEAk3vMaMvlV/p/1ChgnX048RMDC1vo9qNpKW3ZnDNYFAik6odWrzGveaNaoAAqnRZCes+CdF3SHTmf65YVomAZsiQTW9/BqmIR0KEPCzcmxlzVTSGh71MERHlhVV6prLn9yexGb+ViX48l7IjpD++C0dUnEXBdDiBCLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXTsoDag5F/DayBU+Ott+tNPrAl0MXEG+LyND2iN3kk=;
 b=gVnIl+wwv3NjFhAeR2tLgMra7nZDdHevwhNGVMTJuprJElt4hQf+07uVeEezDAIqJVMTql0ZgEto21XmrC2GvCBJoc/qCaAB5pAkDdeznYmuHVefB9mR3MFFXSLFHCUcJFVhef4oQ7u7kMGHsat1VD05BfmFrqKpxTmLOxR18WzwdtmhCJ76+8dRw4cl1xx9+WZl9acwI2N1UrJB93zimKCPbQ/Tt/gGF/1HzK0TnxopXTkWKdKJm7LKJyni0Jvlwq3nA5chjmmmdtuv2oLAGQySllGgF7JOksiDT1/6QZ1q3ybKOUibbGJzm6V7xJAej2YJBjtdIomZL0aS6PiVCg==
Received: from BN9PR03CA0867.namprd03.prod.outlook.com (2603:10b6:408:13d::32)
 by LV8PR12MB9451.namprd12.prod.outlook.com (2603:10b6:408:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 11:46:29 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::7c) by BN9PR03CA0867.outlook.office365.com
 (2603:10b6:408:13d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 11:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 11:46:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 04:46:19 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 4 Jun 2026 04:46:19 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Jun 2026 04:46:14 -0700
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
Subject: [PATCH net-next 09/15] net/mlx5: LAG, store demux resources per master lag_func
Date: Thu, 4 Jun 2026 14:44:49 +0300
Message-ID: <20260604114455.434711-10-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee61e5a-0af2-4ce3-55d4-08dec22eea6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|1800799024|376014|82310400026|11063799006|3023799007|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lg/OjLMkdoyv379ECc5EfeS2cEva/QiQqyshWjg5OkE48M6XzG7LddCs3N0Wnkkvs/Nn2VsF0oB8qwencrAi24ztwCxIrmfVztpUPTR7AuX7u6c5OoX8OIWC0SGmshf6Tjlva9TaDSlpyyatcyk9VERU4l2bx5hhwjaczl1VBZvuy3BdIth97FwOL3gN51roL8yr31gfy0NH4zFQddxMqqzvzBZMHOku8/DPehNZLz+c/f1Hol1YL7idBBUMm/8XhWThhIInw1RZA4+iQYeSOL3zXA/7rr4lDACp7JnD7I0AFpt8FOdJlnguQfmszVYi2av27+8OTw73E0IimBUqNBGhMYPcVxtwAZDR2Ll0kTp0fbKttpSErwlcoKqxipsE5uJ8pW4hAcs7gcCrl/rc3exMPS2Zu9nVHAW7+cSBGTp6QVQZTiNvOlaPi3iSkr1J+YPQiv5IxasV33dwdsaBkR4c690YLkcz3P30xTRI0NDVRNMvLYySatxgzbzwYjl2OTRa4GFEpuq0iPapTWR9IPm6xOKXzTbyEHV1blO1LQ1LZ1gucm5SjXYrFnwQD3YL/2irZt1lWCB7cnxzgMFo/Z8g6f9R96uaiWEGWTvKSrLPIa8w14nEO0xDt9KSzsCJBKfKsq25f6DfT7zoulcf22PWg/rnRBkwCUGDUS3ReMLY4CHkJ6Ub5jwO137VyWwO3U5zF3QQC9PSTg8FLh1k5g/jR9jp8/fPfUkdVWUp9M4=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(1800799024)(376014)(82310400026)(11063799006)(3023799007)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hWGUjvY8wL6EHa2zHklZX1om79qVdiq9CwKw4GG8oODm+u+D1iXay6rUnXBQFQ39R+alY532u9qTXHzPl9IFCd9XMPXxgcEbXvRFftSP4teC+hNKNw4Nv9Yi51XT3RSssDkegrGNogAOTv6qd55x60hgR2DpIPbhNfewJA1ogFClvArvG2FDg/BNo4hGS26lcd71ltjmH+uqYODoKsLhhgxkaSJDtBi93bUMFuJwBhZh+G5MkLO/8s6vn/iVy213NKgJ86wxd1o6uw4AYEKUMTsVKImk7SLaRCyTz2vmClqjEwaZIgGOLs/HV3fGYydHSC6JVOjFl22kPe5FwoJgDL/YBo436wB2eS0yC3VVIa74N7H9wj3BbBeogYppEHPXLv35e/RSuIXxHZd/wsMWiCzWnb2KBj2c8FSZQL0nDfLBQEfozj/pbqmFNytSQtjf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:46:28.8667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee61e5a-0af2-4ce3-55d4-08dec22eea6e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451
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
	TAGGED_FROM(0.00)[bounces-21757-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1EA5363FABE

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
index 0296f752bb4c..c689f1951cd8 100644
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


