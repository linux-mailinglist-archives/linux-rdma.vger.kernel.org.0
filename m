Return-Path: <linux-rdma+bounces-21969-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Bj3SB0/MJmrtkgIAu9opvQ
	(envelope-from <linux-rdma+bounces-21969-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:06:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B15656ED2
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:06:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=oXPbp6Dr;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21969-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21969-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AE7730C4623
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 13:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD013CF68E;
	Mon,  8 Jun 2026 13:58:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013045.outbound.protection.outlook.com [40.107.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54D33C768E;
	Mon,  8 Jun 2026 13:58:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927088; cv=fail; b=lewPR2nWUgaFERmBB2/+cVrhEsZuNDnRnFIlYWMBU6tMjiK56vdyTzl338IO6+5iCM/Wl1B5RKJjWkmgLsCe+yEz+AOZDmZzi3zfBANM3Iazyq+5QqxEPwasB1WgBZxlWK9pXPh+YPxdbNdrgGasy937+BvyY2MGfSw9NK3THpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927088; c=relaxed/simple;
	bh=lYaNI/v+dxVGnNwp+XksJosVo0fULTZJBhzYopoVLtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqAgDXn5WguoGar3UG+VkprymFgYvxbG2IepZ+zaDebaCSNoZkTIIVMDSLBV9/y3FxqdvPQL2E6eFU6VzqkTGiGkZKKgDrx3hhjKZ4FAhBy2Mh/4WNa0xmaznbcWY9texNmE/n9BVB1iMbmoufApcJHCTIFv/maXxGljG9NjjDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oXPbp6Dr; arc=fail smtp.client-ip=40.107.201.45
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZd4bQyRm3x8OeA8n+ffgG+/O+tEyc0d92jBpVB8pqo29s4M+xdCIbnYmVbCsJ+BoLtgApGpMmru4L8KLYhukIx/bQDsW4sFcxtwdwKi4qdhY+12oswXjGMKIQ7YdieSWBIap15HX6bEi8zAtBGj0Dgc9Nh8e721iVIzlyQaJyL7RS6zLi7BJ9WlRgfSan1y01j4S7KX+JVeSrR9bSlqtSqrKCUH1k69SDOmPPYY80XNbv5Uk/y+WXyALBqeR86c0m6I0HpeQrOxeon47ELJgJ9KEeznGXcp1oOjfimx1WdRNlEmklX4/1aWPC623TPv9PYfel7BxuexMCqs7dzkoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/o6DISCmBfFgjGMlRZagjnafkTWr1c+7FpaOCIIX34=;
 b=pTj2QxSzbfg5vI2DML7TVUY9ORGo34XW2cv2COxkdCOt5ESLil4TkHl4gb4t1oF1GSqpPs9Z/qXhQhh/z9kOo+isR9sNuADlghfYefxAkUaOU4puBA0FJrDDmIqH9FE/ivJR7WVSCaB8tDPUzVxE77YgfQ6e2SE1CAn6TXGaD5v21dHzJcFSFhNCMWjwrqSgmqLM2e/g9Y/tUcxEbMN1X7JRnCyBpMTOqsIavZ8vkcN45zqak9lQ6XUDPHChb4fHkyPgg0kix0f5CbhCk5L6bP+fdlOlQiYGwlxAU5ZfzOqforbv0V2WmnYUnVunchje/nHz5fKXymZVHJLCEmGoUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/o6DISCmBfFgjGMlRZagjnafkTWr1c+7FpaOCIIX34=;
 b=oXPbp6DruakKpm8hvkCtBJtfvYOOzPE53hNfHoSZxdiTo8MFscKKdLaq0vNV/g6xpXx5dWbusAeeOleJCMJg2urLSRIi4/dsP+LnALmIc/PUd5otynVtPDXQfxnpfxmNzZezx9ej3LO17e1h0gD09XKWiVQGmhvAYhEpMvV91onGb9wFavDtRDzovfqWJQn1LyBv7uAB6JThEkFK00oloRjrRpxVMXbYbBshTcB3hGoUVj/T0gC4bW96LF50asnNxM24lKt8/KJ8YZbZPl/frA99F+ZoMbriYNQ3M7Qz1VJgUBJBfFwiSsbgPwSn4cpTGUfCPpmWxy90kYGjPrBTgA==
Received: from BN9PR03CA0035.namprd03.prod.outlook.com (2603:10b6:408:fb::10)
 by DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Mon, 8 Jun 2026
 13:58:03 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:fb:cafe::af) by BN9PR03CA0035.outlook.office365.com
 (2603:10b6:408:fb::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 13:58:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 13:58:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 06:57:45 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Jun 2026 06:57:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Jun 2026 06:57:39 -0700
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
Subject: [PATCH net-next V2 13/15] net/mlx5: E-Switch, defer rep load while SD LAG is not active
Date: Mon, 8 Jun 2026 16:55:45 +0300
Message-ID: <20260608135547.482825-14-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|DM6PR12MB4300:EE_
X-MS-Office365-Filtering-Correlation-Id: 3800ff7d-dcf9-484f-96e1-08dec565f563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	NTioloO2X1KZ1dCNcVeturSXt4WtW1p3mRt4vrIEEZVa2Re0YoLGQS5UQaTpkiX+QhplDT0TpTPFrH2LOHTmZaOfdFXall2YZxCBjqY/qucPGanF/Gkp4M7l7Il86AadS2RLwr51WNzDHC1iGPjFG8LQ3sTAUDdG9kqak8FOpBXJlI7cpcBIYgAZvX//TuBT38XLS+UYNA5zv/4j4RyAHrjqeW5RnBEuXrchRyQ/nRrgJ8JZdSXDUFQz5e/JI43J32py/2xTlbPQTaizcrIhjPBJr4wnG+JLOafNaAI4AsIzUS3vls03jHzils92x4MTvVZeyskiar/ke/nVWQe1oKSzPGeH3ktvY6UsFw6u1SrwHt5N/2WPCYNZxcKDy0SbDx9SUOPJrxQnt+VBugolOB+PCgswXGuzowvy1QRpKffe6TIg4PsovP1W4+iIJTG/CZDWvLmD6Z5KBNnmOcm66BM44BHz6gQwNLrAIhMRE6V1XxOJ7BVjCkr3VaWc30cfbowR6R+J7noGLpGKpOON5imFtnjpogfzymdiOZ7s+Zs0I4l3EurctiDzceFM9hXlmfLTPhce+gUChcM4hrc+aT+nhUQh9fn55ibK7sAKQSmEGBwVadbLXDnAdF9aVPI5gPCJ73qwMqOI9Tt7ptcYlUDo+C4PD9XW8Qi+LVIgjf67/duPyESfV067Do10/2HLS+xvQ+cfJpwpU+CzqBKarBtYlE/XTrZtruUYXBBDy14=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NC84gi6F6dD9QbxkFwB+a6nluTCxLJjLEDQU7C9HWJhEARHoJvJcdsTwBksaO3iahNFdU8B4j0EYfh1vqgf7A5NgZUOyrxvcyD/HfHo1m/xJqiCQYzalpg8INQyV1Tvi31Zuiu+nf1CAXVNNdjZlfAKV0Wf7fGU/FquCgTzerSFKT45Q5Ao2KV7MKC7Xjx+j1o1LQXXVn0sYPaCXLxTcL2XJszHy+cDkXxfdaOdUdnbORAprJQ5/BofrpLurW+/JHUbZ/zoAV56Em8v+iHTnHvEtQDqXGyVF9yKZuqpvLPqmWzEqCOQSlTWVcWKl3h8+hwJT9DjHQgYp0YChUxWt2lKaM3qqPCc0IrXd6ScdrC1KBXCI1ekVuSpuVEXyVnUDvQ2g9WZ2B/BgiwtbkVwz5AKs7t+1qJKA9tGHOnD1pTfqkFQzy0uiGnz3nM7197VC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 13:58:03.0701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3800ff7d-dcf9-484f-96e1-08dec565f563
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4300
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
	TAGGED_FROM(0.00)[bounces-21969-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70B15656ED2

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
index a24719cfba34..e87837fbc372 100644
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
@@ -4764,6 +4768,9 @@ static void mlx5_eswitch_reload_reps_blocked(struct mlx5_eswitch *esw)
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


