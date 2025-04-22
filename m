Return-Path: <linux-rdma+bounces-9666-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 900B8A9643D
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 11:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE23188EFE3
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 09:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C97D1FCFF3;
	Tue, 22 Apr 2025 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mcsVw013"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B89A1F8AD3;
	Tue, 22 Apr 2025 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313989; cv=fail; b=bAdNUCAS1dxWdqCG5eQnsFhSoH8FsbtIYm02iqc2WZ4X1fksTlCSZeaaO6jM9xB6kaxfvKdvMYGvQjGKv56b3/f5l+QKNjRNadpj4i0Uip+jTwOX5n6nkHAWyGOxBsQ/ZKdptiN+xKtE2NczOSazeWXcyGMmn1PqcwNRgykFdMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313989; c=relaxed/simple;
	bh=THquBSAfYacXWS+9tpCZKZ0H5Gv7/pavCAjRXfYqNnI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pI5ICig1JO4hsvPiSppIkK+s2x3cCyut0tZHV8+u2r7Ob4z3ZGpPp866V6OIRsd2ImvBXzhZgwGF2ZXIL+Koc3H6Ltqu2utJFsZkcs0hEMnNUPIu6lbyC6AtnvVdqG+XmZEWmfyA3cjiqIuYiap3/cPEKOwxt4UxKWWZLdznjJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mcsVw013; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sg2PjVprInlOeljA0FKYrKT6l0H3PdYtP9ynOM90aSwBM2B62COdgGT6iza+Nb6ccoferum3ZXoLr9tp3bzKmsaTx4NcSFBXt+tq6eTYVcaK1ZMV5MqlXowoiBQv3hswCZ3phWWpTB/1kpJ6WvhCbO0GqjpXbNMDr7Pf3PMwhPgNdldiiHaf6GbOmrmO9uEY0ygxzz/5xRNezzlrUDkjU0pbAp7b1PqxNy4T5WQ3lNOAGngffMS6FWfT24OarY5jIvzkQSlQdOlFC603y2lD82YNJqL0erYiVojcZJVFdk4C0xFPH8NS/GMHbOggAD9d9xp1MQ6fjCB/mv5f6X9mcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQ6u1iq1rRGgNZPR+l3Xwhhp8EswpY/r77Ef7PgzGYM=;
 b=eoh/ltlsBqUel6mt3YHKij1ch8yLj4NiJOLLZPplo4AaBnZb21zK8wF1KJSvsPjaZ4bMEjiR9NqzI8iDXPSW0wpuN3viWKvfKSQ1ujF/pNcLYbpYoYqImIldwqd/3b7abYYDiuVz6KRMJDOKcT7fmexr3+kcI2ZeiNo8tOfQ/4gnyG3xcCF4T8GW/lu/xlVED/oFRPWW+U9E0OAA0uRSTSYxuz4dHN1etJKg0fToS4a2HX/9v7H1m4yS8izqsvHFpCtzxSE6T4GMVzgb09kgAgsNTsU86J/XfYwFmI/Ei/zK2fvf3a9LpYcC6mEeCycRWPKR0I80Ag+Ts2h9gyfgTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQ6u1iq1rRGgNZPR+l3Xwhhp8EswpY/r77Ef7PgzGYM=;
 b=mcsVw013sM4Qk3vibmCGvmFXRQVw3x46r4a9AskdwrU40UhxeTZU5cj+e2RxYHCI9XsZa1fqTTFw0ADSb76Tt4sa34qmqxom4uVVxCny/KWDvh8te8Q7ESzj0zOlf59Bg1SckqY/zFHpD6fX9E195Bi6zmUKmOA2UnZ9WLADMtIKps9/MihHnNxknz5idYTjjlKfH0+bfPmqK4140Y9DNqGtVBSeSyCbHwHDL/W5+e8hMCW1BVK8GHDuVV2zxeY1pbVovHJCt5g4hCUjVP3rNKHG+TaAfuSyqORvS7lOl9va/Kco5IiT3RvVJi8MVNxxXOkQw0w2081Fl0guRuMfuQ==
Received: from BYAPR01CA0013.prod.exchangelabs.com (2603:10b6:a02:80::26) by
 SN7PR12MB7884.namprd12.prod.outlook.com (2603:10b6:806:343::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Tue, 22 Apr
 2025 09:26:23 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::2e) by BYAPR01CA0013.outlook.office365.com
 (2603:10b6:a02:80::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 22 Apr 2025 09:26:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 09:26:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Apr
 2025 02:25:59 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 22 Apr
 2025 02:25:58 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 22
 Apr 2025 02:25:55 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Leon Romanovsky" <leon@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next 2/3] net/mlx5: HWS, Harden IP version definer checks
Date: Tue, 22 Apr 2025 12:25:39 +0300
Message-ID: <20250422092540.182091-3-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422092540.182091-1-mbloch@nvidia.com>
References: <20250422092540.182091-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 053d98df-0bc2-46eb-52e5-08dd817fbf2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fPD6D2EaCwdulQ1Jd1z7AYv38YrEL823P3/sXlRXGiRpc4exG+HHE2VXLVIv?=
 =?us-ascii?Q?rK+mJ2mvRFED0dtsR2mFIzGT1CC7l6vOF7/oAW6kWsYKkI39v6wWo6r/vPJ0?=
 =?us-ascii?Q?QuUAd6yTv8csOGXp1u1zPDygxwYvEPGo8VpKIIrDJZhQzquVfb+c0nQNfBUg?=
 =?us-ascii?Q?2JIQeJkqFIYWg3xoCRPQ6jtbEoZqYN6PwQlT3UKAuoFtBBVed5KycLbeRHJV?=
 =?us-ascii?Q?B45mB5DVFDj6HQdOhx7pEkq7CuPCBVRYW0kwH11LSdnpwkEO0n194gc2pJRC?=
 =?us-ascii?Q?1LVjZnzJTm/0gNP37DbIFbrO0QLrKrKw56ze350gBmDr+nlkmq0IS3Vnx2UI?=
 =?us-ascii?Q?+Cgt7ORyljj4UbTmpOtCw0EPCgeV+htuiKTXJ5XEBP6IHpoVjO9lr43YAnNL?=
 =?us-ascii?Q?FkCKo0xoCJhmpt3HBNxz7Nui1WH5IgzA/Mog0X2Ux680P14jBy66EbM8+PVB?=
 =?us-ascii?Q?fhb489cHm+svTpplRu1eich/+o16MVJA7honDYX/SWH6PZMY4/F+JBnAhAOA?=
 =?us-ascii?Q?DZQ7cuKlo1OPwG0S1ngsbw0tDk4G2CBErquKi01JeUlxeOJnO0mvUkRxDtJ5?=
 =?us-ascii?Q?LtCBP8xI/Ey3//rnlF/4qpMX+b+MTxYZXZF7v21lroC4Uv1XdxI261sPNRtE?=
 =?us-ascii?Q?STqlrd8++85QVESGSkn2vsDcsnlFG8zNJd9RomIBUAdmwq0oFsr+ZY7GBj5M?=
 =?us-ascii?Q?5/j2TGqfYnF1pmFgyAf0665vgCCeEa4WTGzbtE7ELDml7OOeAwk7oK125iDt?=
 =?us-ascii?Q?IjPUToWNUJCGJeMFFqH7hBqdKoV+C5oRqRmUA8zGMLSEQzBiWQ1OEb3AK5kN?=
 =?us-ascii?Q?yMLgTBPhLB9YAKgKfM9P8FeeqOQaE5DT7cvyXdFIeXUMgG0fl+YH30vdTIzC?=
 =?us-ascii?Q?B55NO8AmTvcyUF4G2wlYNXGF9SZgIzDht07jyJG4OpA5Xlp3DMvmOT7xMogo?=
 =?us-ascii?Q?Stu+A56wh2JXsYj6If/hRca0yM0yJ0q3HPo6yVznMmGWCSPPlhkIgneQuUem?=
 =?us-ascii?Q?LZSwctLGGeLfaA+klcRIArL0D4ZEv/INgZXX8puWO8rZGlxx+smrHdk9h+xo?=
 =?us-ascii?Q?8jTb5ZU3p0UR5aJsSJ5L6s91c6xkY73sdspRI29LwSQdilKhh77SwIGOzORQ?=
 =?us-ascii?Q?wfeRDrEjbjMhxOUIArOlWyONc2k9XgN4V9gfunPs23KGwoRZdfjH2iZzpZq9?=
 =?us-ascii?Q?iw7FHY8RrrWB+w8hypqOsrhdu9vE9R8RMgh7N2frSrRs3WDBEaE6SsfDg1or?=
 =?us-ascii?Q?SZLBqa9MmjjC5VNKLgQpNJqPPHczHsZ32uH8bFK8oxfv7u35E4GgvTwhbU5Y?=
 =?us-ascii?Q?ioHDoHzq+6F1t1YeTnh2TXXMqdMVkWOTHbsiyd7aLXgWQmm77PZx3pPyj4Tg?=
 =?us-ascii?Q?QFCmBuS6YPDCdzHOiteC5uqpEH9QiQiECMEbpVcsTwKw2nbMRKCwm5HUteBn?=
 =?us-ascii?Q?ziWN2oeWfhghjoFrB2UZkAheFT7daiNGvaitisCBXiUyr/zFPERZbTlxwTEU?=
 =?us-ascii?Q?ldFwtdgo+m1B2GwwSIjYZoqIdoUG6Q4sLqPZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 09:26:22.3320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 053d98df-0bc2-46eb-52e5-08dd817fbf2d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884

From: Vlad Dogaru <vdogaru@nvidia.com>

Replicate some sanity checks that firmware does, since hardware steering
does not go through firmware.

When creating a definer, disallow matching on IP addresses without also
matching on IP version. The latter can be satisfied by matching either
on the version field in the IP header, or on the ethertype field.

Also refuse to match IPv4 IHL alongside IPv6.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/definer.c | 44 ++++++++++++++++++-
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
index 5257e706dde2..1061a46811ac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
@@ -509,9 +509,9 @@ static int
 hws_definer_conv_outer(struct mlx5hws_definer_conv_data *cd,
 		       u32 *match_param)
 {
+	bool is_ipv6, smac_set, dmac_set, ip_addr_set, ip_ver_set;
 	struct mlx5hws_definer_fc *fc = cd->fc;
 	struct mlx5hws_definer_fc *curr_fc;
-	bool is_ipv6, smac_set, dmac_set;
 	u32 *s_ipv6, *d_ipv6;
 
 	if (HWS_IS_FLD_SET_SZ(match_param, outer_headers.l4_type, 0x2) ||
@@ -521,6 +521,20 @@ hws_definer_conv_outer(struct mlx5hws_definer_conv_data *cd,
 		return -EINVAL;
 	}
 
+	ip_addr_set = HWS_IS_FLD_SET_SZ(match_param,
+					outer_headers.src_ipv4_src_ipv6,
+					0x80) ||
+		      HWS_IS_FLD_SET_SZ(match_param,
+					outer_headers.dst_ipv4_dst_ipv6, 0x80);
+	ip_ver_set = HWS_IS_FLD_SET(match_param, outer_headers.ip_version) ||
+		     HWS_IS_FLD_SET(match_param, outer_headers.ethertype);
+
+	if (ip_addr_set && !ip_ver_set) {
+		mlx5hws_err(cd->ctx,
+			    "Unsupported match on IP address without version or ethertype\n");
+		return -EINVAL;
+	}
+
 	/* L2 Check ethertype */
 	HWS_SET_HDR(fc, match_param, ETH_TYPE_O,
 		    outer_headers.ethertype,
@@ -573,6 +587,12 @@ hws_definer_conv_outer(struct mlx5hws_definer_conv_data *cd,
 	is_ipv6 = s_ipv6[0] || s_ipv6[1] || s_ipv6[2] ||
 		  d_ipv6[0] || d_ipv6[1] || d_ipv6[2];
 
+	/* IHL is an IPv4-specific field. */
+	if (is_ipv6 && HWS_IS_FLD_SET(match_param, outer_headers.ipv4_ihl)) {
+		mlx5hws_err(cd->ctx, "Unsupported match on IPv6 address and IPv4 IHL\n");
+		return -EINVAL;
+	}
+
 	if (is_ipv6) {
 		/* Handle IPv6 source address */
 		HWS_SET_HDR(fc, match_param, IPV6_SRC_127_96_O,
@@ -662,9 +682,9 @@ static int
 hws_definer_conv_inner(struct mlx5hws_definer_conv_data *cd,
 		       u32 *match_param)
 {
+	bool is_ipv6, smac_set, dmac_set, ip_addr_set, ip_ver_set;
 	struct mlx5hws_definer_fc *fc = cd->fc;
 	struct mlx5hws_definer_fc *curr_fc;
-	bool is_ipv6, smac_set, dmac_set;
 	u32 *s_ipv6, *d_ipv6;
 
 	if (HWS_IS_FLD_SET_SZ(match_param, inner_headers.l4_type, 0x2) ||
@@ -674,6 +694,20 @@ hws_definer_conv_inner(struct mlx5hws_definer_conv_data *cd,
 		return -EINVAL;
 	}
 
+	ip_addr_set = HWS_IS_FLD_SET_SZ(match_param,
+					inner_headers.src_ipv4_src_ipv6,
+					0x80) ||
+		      HWS_IS_FLD_SET_SZ(match_param,
+					inner_headers.dst_ipv4_dst_ipv6, 0x80);
+	ip_ver_set = HWS_IS_FLD_SET(match_param, inner_headers.ip_version) ||
+		     HWS_IS_FLD_SET(match_param, inner_headers.ethertype);
+
+	if (ip_addr_set && !ip_ver_set) {
+		mlx5hws_err(cd->ctx,
+			    "Unsupported match on IP address without version or ethertype\n");
+		return -EINVAL;
+	}
+
 	/* L2 Check ethertype */
 	HWS_SET_HDR(fc, match_param, ETH_TYPE_I,
 		    inner_headers.ethertype,
@@ -728,6 +762,12 @@ hws_definer_conv_inner(struct mlx5hws_definer_conv_data *cd,
 	is_ipv6 = s_ipv6[0] || s_ipv6[1] || s_ipv6[2] ||
 		  d_ipv6[0] || d_ipv6[1] || d_ipv6[2];
 
+	/* IHL is an IPv4-specific field. */
+	if (is_ipv6 && HWS_IS_FLD_SET(match_param, inner_headers.ipv4_ihl)) {
+		mlx5hws_err(cd->ctx, "Unsupported match on IPv6 address and IPv4 IHL\n");
+		return -EINVAL;
+	}
+
 	if (is_ipv6) {
 		/* Handle IPv6 source address */
 		HWS_SET_HDR(fc, match_param, IPV6_SRC_127_96_I,
-- 
2.34.1


