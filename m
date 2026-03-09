Return-Path: <linux-rdma+bounces-17756-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFDvFOCUrmnRGQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17756-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:37:36 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CAD23641B
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99B5130056F1
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 09:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A1537A490;
	Mon,  9 Mar 2026 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z4D/BGnn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011054.outbound.protection.outlook.com [52.101.57.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2C137B01D;
	Mon,  9 Mar 2026 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048924; cv=fail; b=OgboFxk/Rt5S7m7MzutPTTwhxrjuw7P2228rapoA0mYNC+VuuiYAHIOQvf0NVHZRCA1WANa7fwCRGGhjPuW592uDVNMYWk10FLwyjnKlADebqh2OSLcSMOUwTEJLfYq6QEGL01MLnDy8ZPsCMCmhhW2Gc0+yI1/UYX50yVK+AYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048924; c=relaxed/simple;
	bh=1jyIQU0xtoo7P4mg2sXxdwan7IBK3obhfdzH+22FC9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJsEYm4frJkFC54sUUmZHHee2rXtxumrrGzGhzMWtRQ9v08L5L/Ovr+ss6qyEajkiO5Ar8fu1wUtUuDwqPD6DHPMcgf7ipVrQoTqZFVajz/Ly1DVC/Fpir+ED8Pk7k8MuTZYmJWeKysa9FRPy/tgnKhuqMMHEuIMZHfTTECmZ1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z4D/BGnn; arc=fail smtp.client-ip=52.101.57.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYx7Keg0Nwq6qmKSwlu8HE3krrHyasAQYDE5dqa8977VCGgp2VrWHrb6dUk4dnkaeEWmfp6EXbRAUjZXiKBAyKxBipaCoqc04XODO4fadwE4ad6iLcPCRxq7TH8R6hz/W+2MAMHyNClHVQIp9E0LxKm0591Rou9tW8spIpRnlJwB6YFj43LpHYN3R0y3/lJrJ3UiLqRXyD0Sf08SxFARTAy+kfI29BNAf5JTlpLdXjF5ZAXP4uowY4N5Wad1RakwBZR4uvJSJ+kHVgMWoLyBOkETf5HkvH06JzLd0UIWlQD1KKDC2PhwaJxSJ34OVk4+Mantdxwy+pY1/3LRc4ABZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekn0lKde0n7movVHUf8LrLDOQm98LAswQkzCbyzukJU=;
 b=caPTuSOGH6pQ9/t5NLShx2EErxMCecagc9uSLzTZ22a2xTWmJRPdKFqa62+OQ9A2xwKvnqXPHw3mfyb8UPbpbQQoXJDfaRGqVNy46MonMQXiK1K4IJlddNZ150ULZDI9esjj5odXYvcvIRHHJMegscuYfHYJeV8et1L6xWwQMHPMKw4qLgK8inQc/FSMlTFg3xO++i5U9XQZP8+jkqIm+Bus6dQ9th/D3E719hgph294sQNzp7sYB0KKa/hnbQ9+bjb8JWiFSp3RttVNf+z/Y07mRxHtkG+HIIypFec6FHJMbcFafwxw7nURahNCHRMRS732fw++5vtp2zOhQ7EnPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekn0lKde0n7movVHUf8LrLDOQm98LAswQkzCbyzukJU=;
 b=Z4D/BGnntw3ikzkQfEk8xtyyGhYk3AI4skadJrboR8Q1D+fPBzFc308OHrLDXKU9xSBGaUnRu7mB+ikw7tzZY2GjihE16KN5Fr4BANvZFpgsudZBmnVr47gVG83yafjsejGuFRzIl8lTvwX/GtE2CrZdN3AqRclRU0fblGhG0hxeCjb4JlVtod81Tqo82JqOO/ODqOMx6FWcvWrxGlKQyl2e9+IwHSOH32KR4II29tLJH8VKYqQNwCmbwJdbudW3hjjxct1Emg1zmlpW3j+bzWM5XoovSCTtJe9KNQ5W4EWfw2sF+ImFr8vXZtAmyFvAuphmJBWwKXy1M8qe5gNfjQ==
Received: from BYAPR21CA0007.namprd21.prod.outlook.com (2603:10b6:a03:114::17)
 by IA1PR12MB8264.namprd12.prod.outlook.com (2603:10b6:208:3f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 09:35:11 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:114:cafe::76) by BYAPR21CA0007.outlook.office365.com
 (2603:10b6:a03:114::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.7 via Frontend Transport; Mon, 9
 Mar 2026 09:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 09:35:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 02:34:55 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 9 Mar 2026 02:34:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Mar 2026 02:34:51 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
Subject: [PATCH mlx5-next V2 1/9] net/mlx5: Add IFC bits for shared headroom pool PBMC support
Date: Mon, 9 Mar 2026 11:34:27 +0200
Message-ID: <20260309093435.1850724-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260309093435.1850724-1-tariqt@nvidia.com>
References: <20260309093435.1850724-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|IA1PR12MB8264:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f4fcf4-f9d6-4eac-5c57-08de7dbf28ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	nq3NnyRFwnz3ExpvgRTUyWNAPkDGyZW/WoRQV02+gHSdCeETHPvkYpn83fTDDSNnjz7zofZsQyEbtmub1KCuTBOcI/4lLuVXeL3bBifIsxw4F94Zpc0BlBIld3fRl3K3ukwlHOI78moXERKpiD2G5SbE0p32G0wFZHlPtaugrRdboZM23JiTL/Gn1/M2GDv2AK53RorR+9Z75ONSTFY5RFAZQfIhG6XPVnE2zJ/ZHeLb8YziFbvlC3lrxhH+Z2c+vE57x6g2YsIaBeBiSoKRohoB82CvcQU4GmFZrSCJVrwdfMETSd/MgdpRlQA6VKrwQz7WpcYf01NOTltJ0S5Td/KMhZ/xTw6hsrnShCoVKoZJbDlIJzEna1oPpw+g0kut5IIlQMV154YRGuNz7CyJwi5ec8UfkBSIsBAHpr5/KJR8GhAs+OLbEX4yk+vxyHknaeVxNzDgMvNBYyiufsgQvocEL7BE2aY+ymZduvAcWCr+YrADtd9220rjefrA3ZrzeS4T9QgtYD0FU97s3fOk+KgvCMymSyIWp3sDnc2oK3Jc3v/o2TtK+jWueq/UUgOYqf2tdNxZAhSoIYyF636oxpRlJ8mGyp3WqwQAvHFYmiXnwPb1OS67BMdZnrW8PuYs9uPl3QNzGQyvWpy0vMlGEY6gmm2o1YlRtPDtAIBIpfaaFLc/wd9OFCauUlV7r5hSfhFSRmy2LI1UV17Lix6tTxYDKSzaqp3L51J9jRBn+sH0TIxVE3ES2ZMu2SRBBMvG7AOkERJhKTLIh0VrxwNRLQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ukAPJBX3ofwQCBglZgbYzZwc2fe3a1antSvwABSFhqqkWYzYfiUAX7o9RaHJvfaRaSC9GiwUBENQ6tpoUmSQ8dSXmvi1nnPCwjTTW5nl7fBD7blm4NdIJ4oPNbOsNM0+A/+h0rgUyIWZ4PMjg2Uz+ZN1IQwitk6+F/UuSPN1t2eqeupQZZqFRLZkDX/F0tzbU9jr+Cyy5PFU2YIDrXsdqZIuz+9icN+EsLlLG8OPxjsuRog1pOhRNXPQfQKOFY20ZYAdEGHM2SOwThiAAnrqYGaFvWjmhjy4i2Ilypvw7///gNm031IQBBsTptQuxvFRHUHvl/ITvx88NvRe0AxeSNPcugxewTLGpaOC8QEJMoAuqzLTg1PwrDesyWmIz4zL7X/q5lqFyf8kM8YuaBiJ3Gdpd3nwViKptQdtn5LPY6iHj2kcmXS3/Nt+e8zCRI1S
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 09:35:10.6946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f4fcf4-f9d6-4eac-5c57-08de7dbf28ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8264
X-Rspamd-Queue-Id: C0CAD23641B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17756-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Alexei Lazar <alazar@nvidia.com>

Add hardware interface definitions for shared headroom pool (SHP) in
port buffer management:

- shp_pbmc_pbsr_support: capability bit in PCAM enhanced features
  indicating device support for shared headroom pool in PBMC/PBSR.
- shared_headroom_pool: buffer entry in PBMC register (pbmc_reg_bits)
  for the shared headroom pool configuration, reusing the bufferx
  layout; reduce trailing reserved region accordingly.

Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index a3948b36820d..a76c54bf1927 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -10845,7 +10845,9 @@ struct mlx5_ifc_pcam_enhanced_features_bits {
 	u8         fec_200G_per_lane_in_pplm[0x1];
 	u8         reserved_at_1e[0x2a];
 	u8         fec_100G_per_lane_in_pplm[0x1];
-	u8         reserved_at_49[0xa];
+	u8         reserved_at_49[0x2];
+	u8         shp_pbmc_pbsr_support[0x1];
+	u8         reserved_at_4c[0x7];
 	u8	   buffer_ownership[0x1];
 	u8	   resereved_at_54[0x14];
 	u8         fec_50G_per_lane_in_pplm[0x1];
@@ -12090,8 +12092,9 @@ struct mlx5_ifc_pbmc_reg_bits {
 	u8         port_buffer_size[0x10];
 
 	struct mlx5_ifc_bufferx_reg_bits buffer[10];
+	struct mlx5_ifc_bufferx_reg_bits shared_headroom_pool;
 
-	u8         reserved_at_2e0[0x80];
+	u8         reserved_at_320[0x40];
 };
 
 struct mlx5_ifc_sbpr_reg_bits {
-- 
2.44.0


