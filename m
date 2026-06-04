Return-Path: <linux-rdma+bounces-21763-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0LhbHfZmIWp+FwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21763-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:52:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0F163F97C
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:52:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=QExu04Jf;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21763-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21763-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 531A030DE54B
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 11:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D91242DFF5;
	Thu,  4 Jun 2026 11:47:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF1F472792;
	Thu,  4 Jun 2026 11:46:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573620; cv=fail; b=dFuNcIWBcYDIJTcjEOz5jkwoU9CLLPKB4gj1EkmG4ePA8yjiXZBBbWyxH3NQ3FSJMOV0nuTOFYvoV+4FJkZgjD2Vz5SkDAg1dQAINCj+VUjAl4DHGqEjo+CRzhh5gsayWoYZbJSTeMmqTuAYU1Dt/kuBCt5xqyhpp+xHXNoNHSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573620; c=relaxed/simple;
	bh=MM6hspcwQRwWkFMQKd7iD5geMoOISo+daQMGo/WxoD8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PUt6jCWx/c9LCNgzemT5Dchg9GclryGbe+MjIuNeb39nHTCYfoOtbMg471RxkOdWQEaXkruBQoS9ds++SLNcWg3Bl0jEGGbuF7+xk+P9O8uqiyBlk4OB6TRpYgfNVa058torSO5duVcvBS7LndCvkZJqEsHivl3ie/U8A8k7ltg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QExu04Jf; arc=fail smtp.client-ip=52.101.85.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsxwyQzCzXb8T8AppYTlNzuFWvMRjWjxjZWo8Sa66V20z1SjAdh5F7fup/r61izJQbprLEnvRUp9jzxh3frMst5zVNm3WwE3dj775HsESXlscxXSTraXPaDFTUBDAlTz2HvN0WGBC80Q/Bh0JChzgZfsoARGo1kVlte4HbmT3Kqvs0xRIUPDYKpS23ctnCfaNA1QR6E77hqvh+j4K3vyHE2+7yFZuAhuaray9mGWQaDroUDkdtEeE1QKRic7j4W1hFnzA+gw+RMX5qgX3XtqCqDyyGBIPEz6HLY9AqE1fuU3oBm9cDvVjmZtj7fifBm4lOsVRtuNcs7Z2GzRRTwDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qljDHMcaFonAE5cvTeNcEbR1BzhLQ788sj+s7W0kC0=;
 b=IKAM7C7pQPSU8rn/AuFP1JidntGYwQ92LN1YR/Rh7q5wHI3Fpm40+dT4dbKD6V8W+klASisC+n/msmNsUEy6SCVvxZzpz9lju0GJXW61W6++moc3QX1IDLYWWgENQh2b3f3u4uaMJ4IWpHXBF2LqKwnh9ZIUQwwrhVUZQokgNd8o2r4GjDpnEwdiyuhALMgPkfOfMtWMcj6GhUdooqwuHhm3sEzOysuaZhkElsMgFL1zJmQCkjyQ8PflyLFNnlXcrv7ig9kGKgWj2EX8/+kT6wKGONL/XY80i/KoFZM4i3qMx+mTzFauMXf3heTnKRI/qn/0UqlC7Z3S2RBaXZj4KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qljDHMcaFonAE5cvTeNcEbR1BzhLQ788sj+s7W0kC0=;
 b=QExu04JfXNMeAlZMB8Go0BsMWIoBpfTMVjey2DGhO6bSWNlSqNvhfjik4iQI5RN7iWFUJgNPB/ThEfBPLj5PWh/JegMwtAA0qRvdwuaOeN0s8TtDsWsr9K9h1HGBZhHQ7mmRva36UjHKiLudiPVTxXyq25ksXoXu6A5I1HfFybrtRa4B2i68LqjEtQalHwtEPF1+4K750zvc7Fw3wrgRZVwp/DreOU6W5zNgl89Yb50qZJfEmQfXuDmH2lptIrianGrwdKOQ7oSuvikmHRMy5EAid9uk3z5SVtWq6L8VCqH22NlFFZ50lr/A5cr4iSQexFsLMgF++CqJl40RD4qsDQ==
Received: from BN0PR04CA0175.namprd04.prod.outlook.com (2603:10b6:408:eb::30)
 by SJ0PR12MB8616.namprd12.prod.outlook.com (2603:10b6:a03:485::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 11:46:53 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::36) by BN0PR04CA0175.outlook.office365.com
 (2603:10b6:408:eb::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 11:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 11:46:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 04:46:41 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 4 Jun 2026 04:46:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Jun 2026 04:46:36 -0700
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
Subject: [PATCH net-next 13/15] net/mlx5: E-Switch, defer rep load while SD LAG is not active
Date: Thu, 4 Jun 2026 14:44:53 +0300
Message-ID: <20260604114455.434711-14-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|SJ0PR12MB8616:EE_
X-MS-Office365-Filtering-Correlation-Id: bcbe4fbc-e535-4c96-f1f9-08dec22ef7d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	jcC129pp1l9S1eAyGaHxsKNLpyiRKiyMMB/0LhmDcdX0l3tuYSFyFSL2z5ZLs+CycgwEFkQDP7hYVinItXdmlG2DQbRBqbMyXKb0H7KWslFJ9gthg8jnyR2l3vyiipwXfyYdpfFMIJewc5Em1tct7PE1e5ZisOjjEziRy+8TC7bZ9ddjVukCUs2ppFLOp2/mGzvjwfXg5Cm84/9XyCeSo5Uh5IhM3gNrmS+U9wQi54pN5Xfb1YK0ZY0Oa3t/wYzsu4UxPseulA5SBvMAcDZFg0ilkB11+DWnb78TrARZFxDvJ8rSc0UaV9N7gNRvFh5DgEua9QqLh6fnvJFzENz0AENlaNtDrg6mH/U2xJAyVW0FMgWiKpHDYYri6PA69krYpQ47EOlPXtV3Xcu6TFFPYuB2mB07as4eKMWKhhrt9cknwdRlIFY6xVJFdTaFBtMwvMZArTsv1v2QQ+hpLatytNmNsrnDKeEBeaO6D0recrr9f6XzlpZaQVC1m1iGJDbFnKPjCJ0k+e99K7jatjXmW3dicjU0iWcaO9k2jbsknursaVf9K6/OpPTdrBf8IsHXVNHLEgjc674umx1Iz53GARwUrmnNWqPPpk0ZISuL/hK9Px4kLmeqssXJcvHeqg6Ik1W8ITSwkseN/FFqa/4IRc+ozu8YEVEJc2jTGX4ezGazyExUlgm0oM5swlKjECYLGrAdAobrvN3ucnxnL9slVEIgb5S3gqZXZD7JMEQla0I=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xjdbpLOxFCDVsc+7LlDxJccCGTmorRRJYUG1aoIKQuBNmcAKDjJDW40QwUQS1OlTelXdOFWIrLclxjc3kjXVm89LFx8Jvw8QOVjB5f7YGLEOk6fOzULTiDhUNGDs4O45JELS5pAHr0hE7DOp+P4BNYAJMk2fjgzeW1CCa58+01dE5WfUEF4mwHavOXo2tYQQF1OnKtS7Py0MzHESfBuJqM082snGGJt+esGIkxL5HOq4folZOtHoeMHjDdwkbe+y/w54nrcqK/Z0gJjYO/pWKe3JPp4nCcDEIHlEXj0V2VUtmQ6agvA0Vy6nLTheMJH/aNnX4h5tUDXf8UyaUekdOmFpVVhz5FeMMNWgDkgmBHkRQUO1hIo/SVrzhKy4L9Mq4wvS/IDSGH5puDlRAlE4yoBYSKz45zdD5eTLIV3oCtf0Q4maEKo6nMg0Ob9u30/m
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:46:51.3691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbe4fbc-e535-4c96-f1f9-08dec22ef7d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8616
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-21763-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E0F163F97C

From: Shay Drory <shayd@nvidia.com>

On an SD device, vport representors are not functional until the SD
group is combined and shared FDB is active. Skip both the initial load
and the reload path in that window; reps are loaded as part of the SD
LAG activation flow once it becomes active.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index ad812fb1bb80..4d3f80bd6af0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2863,6 +2863,10 @@ static int mlx5_esw_offloads_rep_load(struct mlx5_eswitch *esw, u16 vport_num)
 	int rep_type;
 	int err;
 
+	if (vport_num != MLX5_VPORT_UPLINK &&
+	    mlx5_get_sd(esw->dev) && !mlx5_lag_is_active(esw->dev))
+		return 0;
+
 	rep = mlx5_eswitch_get_rep(esw, vport_num);
 	for (rep_type = 0; rep_type < NUM_REP_TYPES; rep_type++) {
 		err = __esw_offloads_load_rep(esw, rep, rep_type,
@@ -4766,6 +4770,9 @@ static void mlx5_eswitch_reload_reps_blocked(struct mlx5_eswitch *esw)
 		return;
 	}
 
+	if (mlx5_get_sd(esw->dev) && !mlx5_lag_is_active(esw->dev))
+		return;
+
 	mlx5_esw_for_each_vport(esw, i, vport) {
 		if (!vport)
 			continue;
-- 
2.44.0


