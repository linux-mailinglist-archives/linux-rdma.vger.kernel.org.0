Return-Path: <linux-rdma+bounces-17528-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHlkK1GUqWlCAQEAu9opvQ
	(envelope-from <linux-rdma+bounces-17528-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 15:33:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D24521389A
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 15:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 70495309C523
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 14:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAAC3822BC;
	Thu,  5 Mar 2026 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nAurtT8M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C518031A549;
	Thu,  5 Mar 2026 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720849; cv=fail; b=J8q9TEaP1tWhwBXPGAnu2S45MM0gLLBgAXwrq0wqFE9C8TDcXFeL4wMImE4xGpAr+nW7eJhAoU3+a3tmHa8KlKn27sRX7AAQ2Pe/gKS3g6s0uFzZIefkym07oV5V7rD9gVHLffFaVfn3Ntemong92WddaVp23DjXK0aZ06dbHs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720849; c=relaxed/simple;
	bh=q3lZLY4pYx8ChLcxS9i9fzJpFPO3uMdYLMJhuKnu+vw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZ3h7z1HmRGHGxAVnz1DoAEAsc0z6eV9gCLzpLHe7qimhrRgb12g06wOfDZjRYD1ZSEMWBrmale3BaLFdvlpwkGH8y+2Po4DxCLUuXSNPJ+SJTRCOK93VeXyYHMgiuq1D/rIkI1y6EYzzBqgV91dffuLI6PyuzaW+g/7UVbGbdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nAurtT8M; arc=fail smtp.client-ip=52.101.85.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHBc3+0b6gvtTqUQxGc2O6NFlI6nQLmEzB+7JVt1Ba2gZ9l4kDbra8ZMGhgwv03+0PeUd9sodEkxjI5FOH49gTrmhIAUznY4xfaHb6vqM9Zyrm3oXo3vy3H9FfgFvsP4ZxluHxm4xHs6DoeDJHszHiBMJIsaCaW3FBAwjTTh48hINpcQsev2Nji2uBB29jYC2gFqJQnV5g6GUJWrr8nhhGYGD1i5xgZ0UMRFr/qCT5LVO1KRVcr7lxbC6Y2F7OK5ScRgH98Z70K2r7Zi5GdLe3kpZ65RbO3+Es0Aqr9AiGdKZJO9DYJdeYqdkfvGfxKpb9IgmrPyRb5fNOx7xUkr7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIyYQx3wIFYhfvYAK3SjfXpBPecR215q9igDxYDz6Zw=;
 b=uirPKdvciWM5mkc5pd0U0YLYW33XGMu5gcHIeYJhQRzeT8+laResc0V46Ebu0pWFo6FRATJ8VQxf/Ho3c+rir/cdRSLNff9PlHkmVaT0vm4xDMupwnQLDQcotLnu5CkYSEcU3yZJ31vEd4qRPK7uKmvbMvOIduALrfo1Shc5I9lfLJa4+NnmgkNaeQuwrhTqh41P2t8/yRp/GTAmxwR+6BGvGQP0Ez3W+tgxRkUst224JPSVp6MyrfA3k5TV3rrGT3x26Jdml7BmpriQZjTLC2iMQGPhDlUbb3OZCDwx0Rf+3q6VQHc+4n6Rpwh6J4wjeAuyrQeuctJd+ZuoQG8+8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIyYQx3wIFYhfvYAK3SjfXpBPecR215q9igDxYDz6Zw=;
 b=nAurtT8M5A2IHh7tJYtsn9bjxwrrwDV50Vr83mLmNUdb1V4sXAwPbTZcAd5Zu8shrKgvWAXvD4anjGiaChaditppOW4uePsri7h2Ywp91q/DeygzMGBPWl9v435vJpmYFTDioi01kvTDKXYwwU3kPW3TCvwkYnC0O8RQ8PfO9y/gLz3PdYjX64CNmSqwpEFW7uZG5j8YnpXzD5UJxiRkXIRfse08e35X+gjlxwL5ZlSp0175UCopeKWARaM6laI4+3NZ4ZHScZd/rewoL5V2njUDGUQh3by/t7ycj8UvTRQDCUYPuBDVK2FO2dODzksmtuGjcjwzpIKMKHBHsimS3g==
Received: from BN0PR02CA0005.namprd02.prod.outlook.com (2603:10b6:408:e4::10)
 by CYXPR12MB9387.namprd12.prod.outlook.com (2603:10b6:930:e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 14:27:20 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::82) by BN0PR02CA0005.outlook.office365.com
 (2603:10b6:408:e4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Thu,
 5 Mar 2026 14:27:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 14:27:20 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 06:27:05 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Mar 2026 06:27:05 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Mar 2026 06:27:00 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>
Subject: [PATCH net 2/5] net/mlx5: Fix peer miss rules host disabled checks
Date: Thu, 5 Mar 2026 16:26:31 +0200
Message-ID: <20260305142634.1813208-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260305142634.1813208-1-tariqt@nvidia.com>
References: <20260305142634.1813208-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|CYXPR12MB9387:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c68ff84-350f-42f3-e67e-08de7ac34f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700016;
X-Microsoft-Antispam-Message-Info:
	mYL4fDbyRP3l4Ej5BCx/pa+bcPgqUjdvRmo6nauMFLrFXXluv3x5XxRF/gY46EZGDoTA1CIAklYeutd8EwDE1kA6o21aptOWTmFxiSSOstok0OU3CsO1VuF6sJTxe6Q3S62/9OqWIxwHNykae9nF+xbCMdEBeM0CJZ/YKkR7Nlg/fTeFH6I1BULnehadiDlkk1bxiHI+2ayIg72WE2/cjOuR6g/RG41bnExVmlsjJ5+M2AMZ0OprQLUcXtJqZKyk4RCeXengBdjnm+iTP0CilfhVq7/HnkcTLVLDXxY3eV1/4TOVsGZzXZtnRVBGEDNQCdWedr9COpkfBhQ81qQQri1pzmKOo8z3vfwbsmLAqc6EwR0zSfDgj6OzAk1Pdf/MsYyPunzIPY4iGTtC/EIqeCoc5J4UTc6VIefJD/i0+FiAFC/6Pn8k1Qtox90Mq+Zo6H05cIOo/s1roEi6UNXHb7y9+QTiEwWf8WC804TPrLyypQcmX86Hc4jt/vPvbw7vdAHbCnFNaWFAgt5Y2U/sftjALqN5G5jnZkNgWxJ3bp7IxouK9Kegc2MxIu7u4NCWoDgYnw+jen9E8uu6TQCywz6+gbz9q72npL+4ci8lAAnyVH4BQf2p5nMNHHpN7EuuE+d1NvslnkO1GcJ79Bqg9jqS/wfLV5yfgHEODD14ep7nw2n2xP73n/N7lwsR/QHQs7AGYGi+FIWp6KCfhLkvhi6Nq/QKcZGjL1FSujg50q+NYlhCAon+lLKuCMUwtTiCs6PCrqH2yyvJJe/PrY/pEA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9JpuhDBrxC3ne0AOT2aiqQDtd/PWdfrECzpW8vT7ohjfp+mYrTUdqSX+HUbizQzrv03Mz/L4jgBtnuKi+d6IszfgfVz+l3ErXvFODP/R/g53PRZjrDV0MMy6rA1BpFlZM43oMQh3VKlXUtezT3wSOxr0ZSaz0l4fAiLRIuXrftj/D/Dei6xWjt25+2HfKAd/+0HmVCEfE/QPSY7ebdDe0e516PTngkKhIXNlETRzYmklGw+WUkDHANIxSiIdWLyNEzg5H+3NlIpsqnG8SQ9HZwxOvR9IBOLWjCXpdaxwg5DvOxdgDGtqUyIX4m6CHRsIXVHRBn2VPvFimcnGJD+FRxMIbsR8U8/gNczw/LJo2IRyL6g8Qp4lBg5ci1EjfdH4XVzCvWp6aavYxA8aGbLMBbUeoiNh4PMQw/fXzp7C6l/JzqciMpHzHMj1d8sGPQkW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 14:27:20.2456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c68ff84-350f-42f3-e67e-08de7ac34f81
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9387
X-Rspamd-Queue-Id: 4D24521389A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17528-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Carolina Jubran <cjubran@nvidia.com>

The check on mlx5_esw_host_functions_enabled(esw->dev) for adding VF
peer miss rules is incorrect. These rules match traffic from peer's VFs,
so the local device's host function status is irrelevant. Remove this
check to ensure peer VF traffic is properly handled regardless of local
host configuration.

Also fix the PF peer miss rule deletion to be symmetric with the add
path, so only attempt to delete the rule if it was actually created.

Fixes: 520369ef43a8 ("net/mlx5: Support disabling host PFs")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 27 +++++++++----------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 1366f6e489bd..2f55ea3f8bf8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -1241,21 +1241,17 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 		flows[peer_vport->index] = flow;
 	}
 
-	if (mlx5_esw_host_functions_enabled(esw->dev)) {
-		mlx5_esw_for_each_vf_vport(peer_esw, i, peer_vport,
-					   mlx5_core_max_vfs(peer_dev)) {
-			esw_set_peer_miss_rule_source_port(esw, peer_esw,
-							   spec,
-							   peer_vport->vport);
-
-			flow = mlx5_add_flow_rules(mlx5_eswitch_get_slow_fdb(esw),
-						   spec, &flow_act, &dest, 1);
-			if (IS_ERR(flow)) {
-				err = PTR_ERR(flow);
-				goto add_vf_flow_err;
-			}
-			flows[peer_vport->index] = flow;
+	mlx5_esw_for_each_vf_vport(peer_esw, i, peer_vport,
+				   mlx5_core_max_vfs(peer_dev)) {
+		esw_set_peer_miss_rule_source_port(esw, peer_esw, spec,
+						   peer_vport->vport);
+		flow = mlx5_add_flow_rules(mlx5_eswitch_get_slow_fdb(esw),
+					   spec, &flow_act, &dest, 1);
+		if (IS_ERR(flow)) {
+			err = PTR_ERR(flow);
+			goto add_vf_flow_err;
 		}
+		flows[peer_vport->index] = flow;
 	}
 
 	if (mlx5_core_ec_sriov_enabled(peer_dev)) {
@@ -1347,7 +1343,8 @@ static void esw_del_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 		mlx5_del_flow_rules(flows[peer_vport->index]);
 	}
 
-	if (mlx5_core_is_ecpf_esw_manager(peer_dev)) {
+	if (mlx5_core_is_ecpf_esw_manager(peer_dev) &&
+	    mlx5_esw_host_functions_enabled(peer_dev)) {
 		peer_vport = mlx5_eswitch_get_vport(peer_esw, MLX5_VPORT_PF);
 		mlx5_del_flow_rules(flows[peer_vport->index]);
 	}
-- 
2.44.0


