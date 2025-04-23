Return-Path: <linux-rdma+bounces-9705-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AA6A983D4
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 10:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24D9166CAC
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 08:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CDB26FA5D;
	Wed, 23 Apr 2025 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WD5Aq46G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF12026FA68;
	Wed, 23 Apr 2025 08:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745397407; cv=fail; b=gAZdbAdMl516L63szXVpIp98Dv66ZJVhDd8LQdsONyBJQz4vvGCmUotcMF/ee1QGagpkLhFPupfczeZ+X81vRWuYEbuQ2Rx1eshLQ4e2+7yBZ0FP2v9MsH1uAmCyWfgnx3bmATcvYR+xIFDMcJKHyhdPzf2tdoL/Xi+7WfqQTm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745397407; c=relaxed/simple;
	bh=cCRzA+WDVYL5DpDqiwF0AnPx8C8BXbsWwsC07kUckHI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZkUygdqry/Z8sOEE5ZGWr+AtGQl68o0RmrGfMJQcmikRTCexGJ5bA0yxrSjD22nBlCH6n34bsXG35LnhT53Izq9yN14bdVUw6374cOds+To8ThH2sgQ7EvbajWpYrcMJED+HqdRMi/wXZqt+8YmXeOVVbvCcjNTRr517cgNtkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WD5Aq46G; arc=fail smtp.client-ip=40.107.101.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFkMqyo3NuCQ9VwhEeD1pJXDLKOe/PWExa4xkG55xDws9hy61xarHipQOt78q3MdIjZjZcPH7ti37KoZabF6DUJ7YDBjx1qRb60I/Jz5fmJEMjME7/qmLtVYGoq1HfIDmZ2Fe8/S1RqjfNqc5THPypx7YfKt3NMWdDiwueUm7Hk3diI17jYghTLWQVdXhxeHHLh4iESSQGsgguVnfQWAUwPh2yIkH4+NLm/evY7vUcmMaIX6xEQvIro7k2+epxV5+LpU9xKROPVuKUwK5znI/wBwztswiGJ1WMQCI616kSBPSevH/Z+mEO+wDCU6CwNMYWNOGAVjgMAg2TGzW9oS9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btvmSUxpCcpbJ0mzQpthakQleukSP/xWSc0m+oL3QHg=;
 b=r7B5RgYGNAwu13I0L3PGUkoTeMgKdmAXDsT3EQwhqGCr3uBIsipvHvxJ9rfPgq7m21V0EGXpNsdCyarovK874jjW6oY+/EoPidHL2Q48TUURIpj/Au6p+E4SRGq8lJjCxRMepc3fBCakwpIs0va07N7p85d0Z7yfcynanCypdw3kQpqu9sRqWM9O4wffY10kKB5uSrME0s1ttfn5x2OdNmICHg/GcWVqsxXC8rrpHvEbLNhegZrotrXRp8yUzjWVkX9GmtlL9y9remgEjYETUoYBy4JenI6MuBt8lkRTje7BPhq0xBW39pxryfqaLChEsCdYyiu6TJXGmBKV13VqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btvmSUxpCcpbJ0mzQpthakQleukSP/xWSc0m+oL3QHg=;
 b=WD5Aq46GXQKhxC/19GvDge+beK1AQEEBesp3RvvI6MwZQm6Td+5gmgSzMaI3tqjmLkzNAaCQQF0cVA8GUtBbuz1sVGJwR3Q8ahDFegyN7lpKaZoUsTqbKh/OijCe27et8YmpeReTOPlV0+/M95Ok4tiJQJkPlq3hv9rLlScGevPFkGr3ewDLRmHBBn6X8hTNXyPCBlOn4go8GCFRyBCeD7Ww7NUMbyEay3DZ0IOtLkAE4C67D9J0nW3aZLV1CImKneXj1ki+grCKNS4ZVZm4WC2ocOd71ir2YC5+iCU0/79rXfiS6TkLHkY53XyFCFf3JfeJP6oGICPiDXf0nH3ULQ==
Received: from BN9PR03CA0059.namprd03.prod.outlook.com (2603:10b6:408:fb::34)
 by DS7PR12MB6022.namprd12.prod.outlook.com (2603:10b6:8:86::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.23; Wed, 23 Apr 2025 08:36:38 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:fb:cafe::44) by BN9PR03CA0059.outlook.office365.com
 (2603:10b6:408:fb::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 23 Apr 2025 08:36:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 08:36:37 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Apr
 2025 01:36:22 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 01:36:21 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 23 Apr 2025 01:36:18 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Leon Romanovsky" <leon@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net 1/5] net/mlx5e: Use custom tunnel header for vxlan gbp
Date: Wed, 23 Apr 2025 11:36:07 +0300
Message-ID: <20250423083611.324567-2-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423083611.324567-1-mbloch@nvidia.com>
References: <20250423083611.324567-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|DS7PR12MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: 41226a8c-4ec8-4db6-5b85-08dd8241f6c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fSYYLMJx8pHZ/158cFeh78ziE1+NqTuWvPH574e5mgPdINSuV1ncMSppFl+H?=
 =?us-ascii?Q?ShoLe1TQ3LYW1l3hXtZB6eqAdqofkMw1nG2cPaFn9Dce643Jo3i33z27GEYM?=
 =?us-ascii?Q?rti2m1qkHTfbmFr21HymRFDDaXqRYADnYVhEkwjkXnTp3xaGmiEIMaTszbf6?=
 =?us-ascii?Q?fPUBBVPgitvSk2wXSTiPsmz2Q2q+0ZvI9NoN9mtURPYy3AchbQJXD/FkysP7?=
 =?us-ascii?Q?QdPbIn+0k0kXCthaTje3UWpX+r/2gXYaHa2G4Rln4nAPLMoPMme++xaUoU+s?=
 =?us-ascii?Q?z8d4A3d1Yn5pbI9EZyNxrqaxLkNHedy7kL990DMO2O/C5uLsD6Il2PEcT713?=
 =?us-ascii?Q?kdeBmF4o2VDaY3Tm9+av8qfPrESbpDaPXFEW1ESkXoCccNk8R9pTfP4t7bQu?=
 =?us-ascii?Q?zumSv3IQRRJNm3XoTklqPk/pBBOqQzAjB3EFQrKO5MZE2RvD3Okc+TBfOBPh?=
 =?us-ascii?Q?uioNvMfEPELiCxcvGgI9GKFDQ15PHeTbl7G8PbGwMTd2B9T1WO+pjC8+dglf?=
 =?us-ascii?Q?jsBDWUux0+C1NnRjpUk6CT32RF2FnCJubdtisfdgykYBpkSUVYjvr0F8xTP7?=
 =?us-ascii?Q?gVlE0L/t3fIyFcDjjHkbnXoHGiyUhfQfUxCIbMhU0BCo/OQzfMD3Bt6/ImbL?=
 =?us-ascii?Q?EnQ7aMhiaxq2c0/TbD8O7MoP23v6WbcYoJOvGDJ1gFuhM7b5q1U9R0fA25A0?=
 =?us-ascii?Q?PVXi2xr+qw/i06NsGTmdq7wUFbP0GwOsPatil7cZVhL9njAu+92oo/I88uqH?=
 =?us-ascii?Q?gCrXKcJJUln8XexBRFl6PlnKUwGf1pjDLZDOjwMV55OQ1Ccmec9X7tmaDhXy?=
 =?us-ascii?Q?Dn2N48svNKsGvwZsldtnYCubXmRNr7allVVJg9snLZxpyY1CwjYXsY3s77us?=
 =?us-ascii?Q?03MOXq0p+KNq1YzLutEaSnbQmTy3zVhAabBxtgisNgkTRWqN5JRnoPakV3J+?=
 =?us-ascii?Q?GEJHgsfmqemRU10fj5ia1WZ7Zx9ES3MSa65qIF73jQ3hOtUy83njfCNq0Ira?=
 =?us-ascii?Q?WkiiqHasb4KH+04KUb1BuY97EbFZNAH90j4xmgHm1+M67uTRqeDzXP9YyzQw?=
 =?us-ascii?Q?9dcmrBuOJrSXBvGE9pRnKGNDXDYQjxF7yrxCCBafIctYjRRI3DgF4ArZQHzq?=
 =?us-ascii?Q?mRWl58gYbUi8kCULumkx7z3x5GYEagvzBZv64ePP7TGOsX4aEmnXuOcSKVlR?=
 =?us-ascii?Q?fjxUSktIeaSd7e3wcpfRtdwECSmX/TW/anzVEGmQFbb2rGkHrtNNZjF27VuR?=
 =?us-ascii?Q?PP9cYWpurZDQ2X6oeWc8/L3Tjn3IRJoQuqwDm4/OV6bB+oX9YMZRZa5ahjMA?=
 =?us-ascii?Q?BW6OTVBTyp3qlwbicBqmbizlfddvNk1jnMal30cvDFOHm/Jy6e2mL8Z6N/e/?=
 =?us-ascii?Q?lNeFxIpgzdReK+SDF62aPXp+BLRVWVZlUbl9r7LH4Zosq/rxYuN68yJrj6+J?=
 =?us-ascii?Q?ZenA8rSIrUDoqjh2CG5n7nHKDD1YTga129p1lDsHm5FC3ijSASr7lK3ZOwAd?=
 =?us-ascii?Q?aQhWkXx3QINKpQzqs4GjkbRfovQ9Spb6C9LY?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 08:36:37.8643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41226a8c-4ec8-4db6-5b85-08dd8241f6c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6022

From: Vlad Dogaru <vdogaru@nvidia.com>

Symbolic (e.g. "vxlan") and custom (e.g. "tunnel_header_0") tunnels
cannot be combined, but the match params interface does not have fields
for matching on vxlan gbp. To match vxlan bgp, the tc_tun layer uses
tunnel_header_0.

Allow matching on both VNI and GBP by matching the VNI with a custom
tunnel header instead of the symbolic field name.

Matching solely on the VNI continues to use the symbolic field name.

Fixes: 74a778b4a63f ("net/mlx5: HWS, added definers handling")
Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mellanox/mlx5/core/en/tc_tun_vxlan.c      | 32 +++++++++++++++++--
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c
index 5c762a71818d..7a18a469961d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c
@@ -165,9 +165,6 @@ static int mlx5e_tc_tun_parse_vxlan(struct mlx5e_priv *priv,
 	struct flow_match_enc_keyid enc_keyid;
 	void *misc_c, *misc_v;
 
-	misc_c = MLX5_ADDR_OF(fte_match_param, spec->match_criteria, misc_parameters);
-	misc_v = MLX5_ADDR_OF(fte_match_param, spec->match_value, misc_parameters);
-
 	if (!flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ENC_KEYID))
 		return 0;
 
@@ -182,6 +179,30 @@ static int mlx5e_tc_tun_parse_vxlan(struct mlx5e_priv *priv,
 		err = mlx5e_tc_tun_parse_vxlan_gbp_option(priv, spec, f);
 		if (err)
 			return err;
+
+		/* We can't mix custom tunnel headers with symbolic ones and we
+		 * don't have a symbolic field name for GBP, so we use custom
+		 * tunnel headers in this case. We need hardware support to
+		 * match on custom tunnel headers, but we already know it's
+		 * supported because the previous call successfully checked for
+		 * that.
+		 */
+		misc_c = MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
+				      misc_parameters_5);
+		misc_v = MLX5_ADDR_OF(fte_match_param, spec->match_value,
+				      misc_parameters_5);
+
+		/* Shift by 8 to account for the reserved bits in the vxlan
+		 * header after the VNI.
+		 */
+		MLX5_SET(fte_match_set_misc5, misc_c, tunnel_header_1,
+			 be32_to_cpu(enc_keyid.mask->keyid) << 8);
+		MLX5_SET(fte_match_set_misc5, misc_v, tunnel_header_1,
+			 be32_to_cpu(enc_keyid.key->keyid) << 8);
+
+		spec->match_criteria_enable |= MLX5_MATCH_MISC_PARAMETERS_5;
+
+		return 0;
 	}
 
 	/* match on VNI is required */
@@ -195,6 +216,11 @@ static int mlx5e_tc_tun_parse_vxlan(struct mlx5e_priv *priv,
 		return -EOPNOTSUPP;
 	}
 
+	misc_c = MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
+			      misc_parameters);
+	misc_v = MLX5_ADDR_OF(fte_match_param, spec->match_value,
+			      misc_parameters);
+
 	MLX5_SET(fte_match_set_misc, misc_c, vxlan_vni,
 		 be32_to_cpu(enc_keyid.mask->keyid));
 	MLX5_SET(fte_match_set_misc, misc_v, vxlan_vni,
-- 
2.34.1


