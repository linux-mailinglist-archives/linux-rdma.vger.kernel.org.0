Return-Path: <linux-rdma+bounces-21958-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SOQkLDbLJmq1kgIAu9opvQ
	(envelope-from <linux-rdma+bounces-21958-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:01:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2AC656E2E
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:01:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=kSvCDB3I;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21958-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21958-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9713304A913
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 13:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC083C1F4F;
	Mon,  8 Jun 2026 13:57:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B933C1413;
	Mon,  8 Jun 2026 13:57:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927030; cv=fail; b=Nc8DmcQYbZ/vBS+tPjcYZdypuIchjmM+tp+KmNGm36gg5XLjbSxV+YfLO3Ux67gm0GfVl4WEZuv8tFJpO0aIGlHJQlrEf9D2Mq6AR+8RYApCdOxSy/XVWjM8IVj+ewB1QzkQ/SUnQtdfkv9awCMR2C/xwGDSJ+6fcjPfrxZcCps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927030; c=relaxed/simple;
	bh=M1dOb2bQOboX+CpJ0QXD9c5E4AIxftyGwAY6tfZ9IxE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kkKSiAHJjK55MGDvhwWZV+A1UUu3IS2uhbXbPk1Wb3kXIlTH2FRO67FCcMcBTJqvpiPfhM2xppK8EfdI1x52yaeKY4ksN3L7NBrV3V29Mk+GpnY00obNEtIqhLjdPt3IMIqb7HGt2w0ILKLSi+9QBlCqFd/RxdP4CzDo47lEHKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kSvCDB3I; arc=fail smtp.client-ip=52.101.52.48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFfHr8wXC1mT2QL1YnmhmG3RX1nWo010JrATAD4kFcNMpVLnIwQGPj34NVCt6l+WDSAPamhqsgzvjQ83FoIAv+s8aQjVQbaufEtF/hkmAuR+FxWfNrYXzdQoacJrWRgWz0guqohiTpfZoefdpXtzHOa3LAND+l9tFZAyBuKgJ4BbiWc9FWyBmkoqbJib00tmrdsMmMIrSm8yFY+D9DhkZlDnTqyFjbpiBdX1fPfJifA+Cn8dTwDN1vEzJ48/4Mt8GQEgt4iQowTA7iaI5TlM3x68UE3T5UWaVGm4FjaPkwog+uhIPE8npbAKdWn70W+HWF/NKjWLEHUAk86Ll9sgIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBCXsAQ/jwwIrD0DS0bM4lxGPnGi0S2TIic+YbA4XN8=;
 b=Qzb4nQhkpz1bdPR3KvzlHmV08KFIVE6pCaRnNwcy93vfEE4H6ulpmYMZ3z7ZnzVnbErE5Qv1JA2v7Uy4Fuf4d46BxwgeME7a3kyAsaIXocKpA0Ynu995GKNUBNixCSEx+5ZO0Li7xY0Mw/1D88jGdo5GRPVrkujjYLHRKgeuFI9OLffJ79AkJC0HsZ1i4mpEyWt+GtA6J8oqPMPvMMGB1BkJsHRxYmzLLShHL4o63gjmGJoejaLj3mwjaWfR8iZj6KmrK99TDgC2EKETOF3Q8vujAGSUwE42YGjfpuBUFKjiPj+O+U+KvyZAB6tVhRZrDTnzjYooYwoD0UiwwblJug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBCXsAQ/jwwIrD0DS0bM4lxGPnGi0S2TIic+YbA4XN8=;
 b=kSvCDB3IJKwTjv/ly918/5YVtMY2K2SJD3KRkO4dqy365DCm7R43IHMpXLaNSz33UGDAC6Z55m1EMzAI749UEkL+bogONhni4o77/+kiP5kkQcb7hIdFkDxYHruN1sdAKEZ+1YY0jAgu4NziuBfzA65wl2O2GjyZY4miRvFb6MQI4DvNrHpPRP5wVOgwNLzs+MvVhQGFUDz7IvTloQvehvdukoRUvslMhIl5g4BjS7hTSImfDRrrJR4dK/rsWNf5mrAi8YpprqBv+UPzbESxYWNokxpekgNiBHi02zA7+q5vmhideBJ2hNLiavlRUXy2t+b2DmAGob5qt0eygw3Vyg==
Received: from BL0PR02CA0088.namprd02.prod.outlook.com (2603:10b6:208:51::29)
 by SJ2PR12MB8033.namprd12.prod.outlook.com (2603:10b6:a03:4c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 13:56:55 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:208:51:cafe::77) by BL0PR02CA0088.outlook.office365.com
 (2603:10b6:208:51::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 13:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 13:56:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 06:56:37 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Jun 2026 06:56:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Jun 2026 06:56:31 -0700
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
Subject: [PATCH net-next V2 01/15] net/mlx5: E-Switch, skip uplink IB rep load for SD secondary devices
Date: Mon, 8 Jun 2026 16:55:33 +0300
Message-ID: <20260608135547.482825-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|SJ2PR12MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 5579b422-2da1-42be-2695-08dec565cc75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ffFx44ytnbqt0MTtAPUpV1MTSup2Rre/Z3JhemtWX4+0A+pEB61QlcCENUszz9dD6kGOdyKyag1I5KNHc1g2M6GgkEjBtXh/1eqdJYpbVYUbnFR3YhwIH6lYZ85keXlvyQzc/OoBYWCgi/b3aFFhsuJOxTqQePkRLJbeFd4y7kMmwukrT4Bbn4nxyUtvwvte7jnFRT2XUd/Ye/pkH3hkS1F/LVF+2abnHkK/hBdRYeZCMWcHUvu4c6Cp7B84LtRTbK+sO+7irO9dHNfXXqxU7Bxi505Qzli5wSefkdWwxX/pH+mbG+DeeHZevo9jIqWkvMn8XGmuNdCAzkARm03GIPDz1FtAx89B9dXvcuE+8xvnYwHst9s6bWAg+TXP7iIftcnM77j4XcStTMBV5a0ow/1RlOR5kcFSD5NeXpYKnIAHAzWIt7KeFT8TaYH+pQBB0yjiZcHuhzPeej+toDidQPBEMLH/7PqgyvuZeA7HTyPGNlG1kX9kSgXggv3EFVlaYDMpLmY4SvcYAGLcDcC8ALIpDYB2V9/TjFBqF4BrGWmAMPRs1inCGIhVaKNh2yv5Ukr+q//gghflkL18ClYe6NGoKWH26L6oSFPNDvXzFqoHxK/psXWBbFQDrbeu/7BPcUroOvVtSBP40w2kAPydiTJNr9NYKkYAkWFL9qg5fp5pNxzE6JhxC9F36NhNSXA82wbSNOsBFBAN1IRVG9wKr6UStBGlHrAJSSBnfvssfP4=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8vYeLqmMzAe45u82G2QucFqd80XSBSE+ktXVrnaad9ROLTNWF2GCOaZjP+ie2NtmpWwzncUOvfOAiZTDvU+xaPIK93p8LLmtayEchCzuQAZUKWB6uxEzoZDY1KRORn4DNLc16TumgmgzINCiio5LCG3JaYq/y8bzo695/ImUTF9USrgdXXaLownhoeIRAsWWusr/0TZrX6wLEX+GoQfOGw2YXOaVayWEOInSuO2pKiGeSzaMgGo+kRH4LEXvFzdVa9QQ3INXqa4pA13X3eYj+pUTfU0qPidFzvdI6kShiZE1rdLC77CiNXwmoHWxE5JuL1jqbdYVCYVBd6tTFwYOmzd8XCQry9Kq3GyeDAr9GfXJ8ibcOQCKxu3BkEyayRJbDTqDq+AnDNtrCtJgAm77tUasqFxYbJeXdGG3qcDeF4yrq2b3rsO9Sx7btmXO9AUS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 13:56:54.3935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5579b422-2da1-42be-2695-08dec565cc75
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8033
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
	TAGGED_FROM(0.00)[bounces-21958-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F2AC656E2E

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


