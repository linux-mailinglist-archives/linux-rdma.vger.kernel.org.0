Return-Path: <linux-rdma+bounces-21749-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yi5pLPJmIWp8FwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21749-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:52:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9F963F979
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:52:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=g2IBvHq8;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21749-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21749-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C1FB3118F34
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 11:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA5C43900F;
	Thu,  4 Jun 2026 11:45:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012056.outbound.protection.outlook.com [40.107.200.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC6143635F;
	Thu,  4 Jun 2026 11:45:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573555; cv=fail; b=UEN7eoJUVwXWOGcUKCATeUeDWFvSh+3+sDVRGfgIB8n2tYm0QE17lABPA7WZKXKshhKhWFfk2sbsqq7qW5kuX3T4xp/pCqkELt6ES51LZBBJUSR3jeQBTKuWwVh48Pu4fKkqHADY7vjV4C/fPSN6oZfqh6Of8EDs7geupP75UAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573555; c=relaxed/simple;
	bh=M1dOb2bQOboX+CpJ0QXD9c5E4AIxftyGwAY6tfZ9IxE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5hblR1ihXjmWUjemkSPH2vvm6gZsshO/TS4SBtQoFGbLfYtvVlcfROPML8M0k/LGdS+b7td/t6re9ela6KaeuqJtlzoIPU3yv5qzJQODVF6W4PeEiDHTEkn2w1RJMXw+ZCKmf5MxxZMrD01zxGuijqmYI5yVfEcwH8CHMN7A9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g2IBvHq8; arc=fail smtp.client-ip=40.107.200.56
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMFqFAuoafgR468MrJAlDE+I2vXoZr4UyzDUB7kKFh8CBM0r8LvaGC6uymg3hYwrs2LR72IfTh84MO3WmOIzSttS3mO7QBdc8O1td1cP+5Mco7sA+SfkvCdKfYCStj7H0IjoBQ7kU3dPwv67aKZej1rVLnE9X5FHkKPFJdm4kPBebAX2q4kPWX9xsXgP5r7zp9UO9dhrUW5ChQqUSIdJiqysnVfjrlh+R0Rdx5X+1aWBC352CuXHUETw8L7oX/J9bRZG7B2YXVbH+Lj0Nn3Ei0b7fCmTVUjvyXQ1bPNxBjuQI5A20NEqxQGAt2PT/u+L8F3zbfj3nBUKh81RDBoh8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBCXsAQ/jwwIrD0DS0bM4lxGPnGi0S2TIic+YbA4XN8=;
 b=JtipHLGJqPjSqnKYlRshfFq4PupHHwavOoOuil9yvewb+gWikcAxxjzV7NC1wh4Qip8ifNHV34ZXjNYWI4VFhq0IVHgJic3UN/0RbV8YMThLHxHvG8N9pDxbRHf87HsNPy0Tj3HIEwqb9pzj66Duijr3XeV63bFxELHAwS2iIeykbD4ApDipgt3y2GfVxYbpc2pAp0qauwDj14lKg39sh5zTsj+lwsZyYqZCMwqTxi3r2oknlNX3q7QJHTUyOwDZrm0biKG0R25JWqsOntS+7t+W/PNLMkVOoP8EkeABmSrrC5YvsmDeIKpQMIBwLGRROEcRgm200PXKyOpQXsi8yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBCXsAQ/jwwIrD0DS0bM4lxGPnGi0S2TIic+YbA4XN8=;
 b=g2IBvHq8MIb60VpG+NJi9Ipv+LSRFxO0VfR+hQ9xMT72JzRgFCuGmw98t0bgKNXnU5sI/kXXuRTHQda1j6K9V8NUGP3rPJ7UxBDEAyRzCDMe6EcRYkbd7UP+zhFB8vbaIZ0j9WswHJ2HytBQ1kv2v9BG8hpUnB/lAUkuhFcRrjSMfoCLkYmAZbsrqF4XJx9FDYZaDpcBj5cLbnSZFT9JavX+XEdh33B1qlDn+2JZIH3FQR7A4nY+caoZW8LM3LuYN0/3beX0IHd6g0IppHP85Rn2IvniHU1Y6FrTgOSNDKBDtnXKiGqpLyD6GlWI6KufCYaVgyGBkWE5Vp2dYd+wcQ==
Received: from PH8PR20CA0022.namprd20.prod.outlook.com (2603:10b6:510:23c::22)
 by PH7PR12MB7425.namprd12.prod.outlook.com (2603:10b6:510:200::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 11:45:49 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::1f) by PH8PR20CA0022.outlook.office365.com
 (2603:10b6:510:23c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 11:45:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 11:45:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 04:45:35 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 4 Jun 2026 04:45:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Jun 2026 04:45:29 -0700
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
Subject: [PATCH net-next 01/15] net/mlx5: E-Switch, skip uplink IB rep load for SD secondary devices
Date: Thu, 4 Jun 2026 14:44:41 +0300
Message-ID: <20260604114455.434711-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|PH7PR12MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 42358554-5aea-4d5d-d298-08dec22ed2af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|7416014|82310400026|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LEzDfpJm27t/iiOHwoFNIV1Gm34bmrp5zqninbgqJC3Nmom7JqIl1Ax7B4J1HpSj93yesAvXBPQTibH4nO0YKXY6Rg7BuJ1kSNzBBuIsDtMcn6KfStKvqrqHhkyWMigeVarBqDIxbT4hWpGc6ST4QL94fqxM2gT97e40fKwzHp6q+5q9dc5+gMnd/LdxWPfmI/t81AzUa+/w5eZTG2MY53jdfY1YgMLvgGi6rqs8cd4yUR6Kd8NeFv0EaTWjqbjPRnZmWMLR62S1dEG8ym6479SNaEb8a8QRr9aMo00HwVVD5UbMR/g0z2lUbktF4bEvAsiCjWrHEuGgbGxoaNbeXL5iZTi5U82eMGx5WtFWhOJAuLuvoD/lanjN0Y7IALIB6vlnR03tHqZI6yDaF3KDMK6ygblGxOAKGtBVmrHU7JEPaldeDUOo8mKkA6MpBg4EzJ+PAqFHAoescWHHW8vfSrUPGw8XSpLuUfQxpEaNBpMb6ee9n92JZYYKlnenGtprM0TF5PGtypt/5lcTv+WpD8R4m5t+PL/tV4V8KKbJpmSAoSuPlCHBU79xwqL0MoQFaNj7j7Ajv1kj50iMBciIpOc2eq7YI0EwOFtc1O/wWZpnpZEPkiMY4049RECXryCyPH4w53n5B1WSz8N+k691StkJ6huwukJkoEjmJUStW25wZkGC+XVxd9Rrj+vBW+kpuaZq/mKOiOzCYuVl7lBu7Oe68Tpddx30UAKo/M0jh78=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(7416014)(82310400026)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QxWNex0J95XWE6go/GkqHOR07NE+vsKWg/ihbzWOJE+fHU1bMmQdqySmY8rpt/0G+33FIuTr/nZButlqjLxS7MxkR+pRl1YX/w6/kPCLRxjHpOIjcEfL7BY9IF/KsPTl+KuQwk/sE+KVGiU2lRYkEtdm9L/qvoHqTCR5exP9GCiWdAyzP6gOydGV1ykxByr0UEgdv8wTm/wC3gRxUDABNbIXBZTDQjaN7086Hpy3hDM5o98FYKnS7833mtPbZgGjYRIJj9bl2dBVyuPB3n7VMzppLSVsriuqs7yWUOdcaHDGcNgx10FDY+2yiuBsJSuBWpBaBQBOCMrPrOBEj1bVugVb05aZwzFTHXiTa8cnhHQQfuzrilNl50oBI8bX1I63ZivNlIf8xfmohlZRvUDR2FxijqTsM5yuu6RkYodciNiHIEXUQzPTM1KR+9JrZcre
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:45:49.1081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42358554-5aea-4d5d-d298-08dec22ed2af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7425
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
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-21749-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E9F963F979

From: Shay Drory <shayd@nvidia.com>

SD secondary devices share the primary's uplink and do not have
their own uplink representor. When reloading IB reps on secondary
devices, skip the uplink and only load VF/SF vport IB reps.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 25 ++++++++++++++++---
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 830fc910a080..12805e80ce57 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3643,11 +3643,19 @@ int mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw)
 	if (atomic_read(&rep->rep_data[REP_ETH].state) != REP_LOADED)
 		return 0;
 
-	ret = __esw_offloads_load_rep(esw, rep, REP_IB, NULL);
-	if (ret)
-		return ret;
+	/* SD secondary devices share the primary's uplink and do not
+	 * have their own uplink representor. Only load VF/SF vports.
+	 */
+	if (mlx5_sd_is_primary(esw->dev)) {
+		ret = __esw_offloads_load_rep(esw, rep, REP_IB, NULL);
+		if (ret)
+			return ret;
+	}
 
 	mlx5_esw_for_each_rep(esw, i, rep) {
+		if (!mlx5_sd_is_primary(esw->dev) &&
+		    rep->vport == MLX5_VPORT_UPLINK)
+			continue;
 		if (atomic_read(&rep->rep_data[REP_ETH].state) == REP_LOADED)
 			__esw_offloads_load_rep(esw, rep, REP_IB, NULL);
 	}
@@ -4586,14 +4594,23 @@ mlx5_eswitch_register_vport_reps_blocked(struct mlx5_eswitch *esw,
 
 static void mlx5_eswitch_reload_reps_blocked(struct mlx5_eswitch *esw)
 {
+	struct mlx5_eswitch_rep *uplink;
 	struct mlx5_vport *vport;
+	bool newly_loaded;
 	unsigned long i;
 
 	if (esw->mode != MLX5_ESWITCH_OFFLOADS)
 		return;
 
-	if (mlx5_esw_offloads_rep_load(esw, MLX5_VPORT_UPLINK))
+	uplink = mlx5_eswitch_get_rep(esw, MLX5_VPORT_UPLINK);
+	if (__esw_offloads_load_rep(esw, uplink, REP_ETH, &newly_loaded))
+		return;
+	if (mlx5_sd_is_primary(esw->dev) &&
+	    __esw_offloads_load_rep(esw, uplink, REP_IB, NULL)) {
+		if (newly_loaded)
+			__esw_offloads_unload_rep(esw, uplink, REP_ETH);
 		return;
+	}
 
 	mlx5_esw_for_each_vport(esw, i, vport) {
 		if (!vport)
-- 
2.44.0


