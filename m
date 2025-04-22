Return-Path: <linux-rdma+bounces-9665-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76543A9643C
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 11:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29F218896F1
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 09:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1251F666B;
	Tue, 22 Apr 2025 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZlX6bPiZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670471F583D;
	Tue, 22 Apr 2025 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313986; cv=fail; b=DnHThtca4ynEq/UiZDztbPyT5xLUmep2miDuJmpkTh7MZRWlShNDJtBr32g/cuhbPqZRzgBTLc2DrzunIOrbmI9vByWqHvlOPYSS3sjZtrMrz0RrNeImrSrPgYE2mBWgmkklYpBqdnegvtkyCq3TpDjCcxsJSVHz9ZrMhX5Lii4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313986; c=relaxed/simple;
	bh=sh1VIWrtNNjUMxvYH4F/UB2ZL3oRjtylZIbj9eMGDOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XpszGefF4LGug8Ubq3X62HRx9VCjfN65yC2OiwQO03xx2UbjwAbgX+kEsmyF/SUrbuCPGaqevCftS+Xt5tfa6t7Ljfj9zwZknapU+o7Ci6vNqyUrIwnz5W6V9FvkZfGMkY++BysCpoJ24rBpqyQS06hJMFuIy9u2t08mkszXeuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZlX6bPiZ; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFt/0cPJrVOGEe44fBaK+x4EXHzASLa/3gs0angINtyv5lpMfR9veEmZKWffw0s188GiBItqZ9x0EZe+DOikGV5PgaMS/EdtflyCmUBEd+lEUUSgM/ZaSQNOGiAG5CrFwsddCttjtqiKcWxGZvyql247G+yeNXPLcmoj3dUgQaAf3MA0bakHBVjh2dUE7g3Jw5jX9hycftZ7qRsLdcotFcXIEbgb9Cw725cjGHPYM0tfpkybDUeWhyXpvTPZXYObCrQYvuAog/Zt7DZdt4cWYXMMWtJjoApajwiN+4WdfoYG0UsNKeVLvWz/rQMSY5oltM8F89Cfs8KSSrtH+J47tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U16MJFxlDUV+d56xlMRJQuRXufm9fjaou4jK6AYDdNs=;
 b=aeLEfPUdjTLvE0W/tI3OCGmZE14A/wbG/55+G1IJnUAHDSutwJpK5UVbJBVV+uj4zVCVnoFX5vpr1HYuTUlxPZ07xejSRjWpKNu4vDBsAMrdBslQsQKF1zj7J8NnOPKHCsDU2aeQ8tkQgHBecZ1qPkUyAQE4IAYSlc5tQTNZ+fs+p3xdgHzjmzMt6LIZWBQlpqr/+5xxon+G7mSZxdo8cb0h8TyidS3jo4ViyrtClLUtDK3sAtNhSRWFleF3M2PLdnbUpQl7a3hOS8Fz2SGHqp/L5QxEmINe3hq6WR0MkSU43WYLeU3p2P8QnJE7gBZNeecUMYdDE5APZS6CXiVTXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U16MJFxlDUV+d56xlMRJQuRXufm9fjaou4jK6AYDdNs=;
 b=ZlX6bPiZrzl0du1kVoAW898lqrarxABJz93qTMFasXGXBTswojndegVG0o4ZwEWoKuBr3US9msum6i/5/HwSGzhNuWE+Zv2wkSzvmCTQZbIJ0hZApcuHCXd2ZkCw5Pv93oLO3/E9MInl83u8frmJkxo0ChurftAPT8xOaNfCX192Ls6VOOMsdYn4Y9/P7sUBtWezmYAK9qQviMJ9phWWqz1/b8cl1mdjrVCwXB6JqhxSUdYYSkwyOUw5YQGVnQ0djOhJtjdKA1ia/Tma3haEbJKsHThR7uaRpVbX9+gq0jbc5oy6ZlxN145lpEbl+s8fzthEcZHXHeO+ZxP5Yt5mlg==
Received: from BYAPR07CA0106.namprd07.prod.outlook.com (2603:10b6:a03:12b::47)
 by LV8PR12MB9110.namprd12.prod.outlook.com (2603:10b6:408:18b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 09:26:19 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::4c) by BYAPR07CA0106.outlook.office365.com
 (2603:10b6:a03:12b::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Tue,
 22 Apr 2025 09:26:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 09:26:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Apr
 2025 02:25:54 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 22 Apr
 2025 02:25:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 22
 Apr 2025 02:25:50 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Leon Romanovsky" <leon@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next 1/3] net/mlx5: HWS, Fix IP version decision
Date: Tue, 22 Apr 2025 12:25:38 +0300
Message-ID: <20250422092540.182091-2-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|LV8PR12MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a684153-f172-4020-3a29-08dd817fbc83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x85PN9GzSjTrfoNX4gA8uCxc33prT4JxTJHVKy+ETPyGkS/9KPDmV0e6Q6NI?=
 =?us-ascii?Q?JErX4lJI5NIfUI4qwLBO8mMzAjXltgM3eN0EJ+fxf7LaebeLC8jfXs3bWJr2?=
 =?us-ascii?Q?PA1aS6CPXRV9iH00ec2UGUNuDnHO/lxg+BvB0eVkxQcD9uE1VzHe4pPaWUCs?=
 =?us-ascii?Q?ftbfm9D4lvIIOpuPfZQDIAgAhmnquIqyv0YGruPEkT2CoSshN9GX04Db4WWj?=
 =?us-ascii?Q?ml5pM82wtoJYYTwbUoKFoQx9i1+CS2Gq2PjgoP+6uBAO3DbvvKga9HP844zV?=
 =?us-ascii?Q?1PA+eP8qJFTqkhbaQP4l5raEIswwL7amtqSradW9lOUtobaIX1IXiNPO+c6T?=
 =?us-ascii?Q?rA4cU5SNO9K7j1dUOKlP14CjufDe2Y2vOPFXxKEp4VEjM4EhRdhZn6aj5iAu?=
 =?us-ascii?Q?a2HLvZjqq0UZJMSa8UCaDoG9cZLGTK3TSAuRYQh5jW3sKE0hhBQ19oieMsBW?=
 =?us-ascii?Q?iQrPXm2NTnyXylrgf0snKLJe3Hewi2BxSE1wwBNiMautAOyML/0jurj3jA+n?=
 =?us-ascii?Q?ExENSlhLmqhKhXLlIRfxHWQ1ch6TbWkkxYaPpIsXkMJjyjP744pxYrrPbgxB?=
 =?us-ascii?Q?5I5AoYO1gRVREUFC8MgPeSeYDAEVSdsSP5KqVNF9WrhkJ2u1Ex7TFHI/JPbK?=
 =?us-ascii?Q?UfUswaWJdSYMBXShg63M+wU5G15NlmTFyA3s5LZaF/884Sg58sv04UxqLWt1?=
 =?us-ascii?Q?ICUz+TbODahTDGU9RcFw/rLOwn8Ujq7Luh22ZVn34SebYQcWPrHC7NmbEtW1?=
 =?us-ascii?Q?DWvRrywnopLthyi0hrMcyAj9Yw7Q79doBnv31i+vELDSTLiJoZc5UisNRXDg?=
 =?us-ascii?Q?G4tHlZGjMo8qV09XvqGfqtOy8b44TUiuqiOaHs5N7eTajZneB+K+WZx8MGqQ?=
 =?us-ascii?Q?TBCdwgGa8T8N3bzwVe2CYj9S3IYnlwuSZicpHaGrI28Y+3CNj/Rfp7N5QxCx?=
 =?us-ascii?Q?IAIaBXPUOou1glRjw/8O3nAaB8NIAV9n3xn3Y6SHq2q7U6rzK8AzH77PXYjo?=
 =?us-ascii?Q?SPf/5qVYEprGbnGkk7ydQDgjkmU5MUN2hqscYl5JGv4upKseyc2TZiAAdoqL?=
 =?us-ascii?Q?KYBStgak4m0T0KIY+Py+XR2EtQggDtpQusmxvUFJ5JUKMtpaimwX8fY6wkUz?=
 =?us-ascii?Q?gR8+sXFBZzIJSJqwjP6+dM0UsMBJGr/lgd0bbYO8aXqcoPHUTHjp3W3k2xaC?=
 =?us-ascii?Q?R1nO9lZU2GUP3pOs/J3qlpvJC+DSXz7dBisWN5leOxRihP4Ydd10R5KANKkJ?=
 =?us-ascii?Q?O3THgUPgO3JVue9SSCbOkLlfZKxlpoOlj7W0jEuqjXzUfLGhcsVUMs1tYqu7?=
 =?us-ascii?Q?Nk1wWv0acXW0SaulYdnospRVPE4jAsxP9ZdjETcHT6EfXftwheGByLnbzL0r?=
 =?us-ascii?Q?HMyqjBCDkIs4Nec+i1fQooYKfrvi0iGzem2GwvRaFA1JmjpsmZxIDiZl0/CU?=
 =?us-ascii?Q?qjc5dCs9vk4hfwMGDOpKz8OWzgW7pu9OzaZSwTB/16GylcjDV3z5Jcic3quq?=
 =?us-ascii?Q?Hiw1FkuPBolrCBYGvgMPy0fNgnCQGlaxc1r0?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 09:26:17.9087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a684153-f172-4020-3a29-08dd817fbc83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9110

From: Vlad Dogaru <vdogaru@nvidia.com>

Unify the check for IP version when creating a definer. A given matcher
is deemed to match on IPv6 if any of the higher order (>31) bits of
source or destination address mask are set.

A single packet cannot mix IP versions between source and destination
addresses, so it makes no sense that they would be decided on
independently.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/definer.c | 38 ++++++++-----------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
index c8cc0c8115f5..5257e706dde2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
@@ -509,9 +509,9 @@ static int
 hws_definer_conv_outer(struct mlx5hws_definer_conv_data *cd,
 		       u32 *match_param)
 {
-	bool is_s_ipv6, is_d_ipv6, smac_set, dmac_set;
 	struct mlx5hws_definer_fc *fc = cd->fc;
 	struct mlx5hws_definer_fc *curr_fc;
+	bool is_ipv6, smac_set, dmac_set;
 	u32 *s_ipv6, *d_ipv6;
 
 	if (HWS_IS_FLD_SET_SZ(match_param, outer_headers.l4_type, 0x2) ||
@@ -570,10 +570,10 @@ hws_definer_conv_outer(struct mlx5hws_definer_conv_data *cd,
 			      outer_headers.dst_ipv4_dst_ipv6.ipv6_layout);
 
 	/* Assume IPv6 is used if ipv6 bits are set */
-	is_s_ipv6 = s_ipv6[0] || s_ipv6[1] || s_ipv6[2];
-	is_d_ipv6 = d_ipv6[0] || d_ipv6[1] || d_ipv6[2];
+	is_ipv6 = s_ipv6[0] || s_ipv6[1] || s_ipv6[2] ||
+		  d_ipv6[0] || d_ipv6[1] || d_ipv6[2];
 
-	if (is_s_ipv6) {
+	if (is_ipv6) {
 		/* Handle IPv6 source address */
 		HWS_SET_HDR(fc, match_param, IPV6_SRC_127_96_O,
 			    outer_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_127_96,
@@ -587,13 +587,6 @@ hws_definer_conv_outer(struct mlx5hws_definer_conv_data *cd,
 		HWS_SET_HDR(fc, match_param, IPV6_SRC_31_0_O,
 			    outer_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_31_0,
 			    ipv6_src_outer.ipv6_address_31_0);
-	} else {
-		/* Handle IPv4 source address */
-		HWS_SET_HDR(fc, match_param, IPV4_SRC_O,
-			    outer_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_31_0,
-			    ipv4_src_dest_outer.source_address);
-	}
-	if (is_d_ipv6) {
 		/* Handle IPv6 destination address */
 		HWS_SET_HDR(fc, match_param, IPV6_DST_127_96_O,
 			    outer_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_127_96,
@@ -608,6 +601,10 @@ hws_definer_conv_outer(struct mlx5hws_definer_conv_data *cd,
 			    outer_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_31_0,
 			    ipv6_dst_outer.ipv6_address_31_0);
 	} else {
+		/* Handle IPv4 source address */
+		HWS_SET_HDR(fc, match_param, IPV4_SRC_O,
+			    outer_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_31_0,
+			    ipv4_src_dest_outer.source_address);
 		/* Handle IPv4 destination address */
 		HWS_SET_HDR(fc, match_param, IPV4_DST_O,
 			    outer_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_31_0,
@@ -665,9 +662,9 @@ static int
 hws_definer_conv_inner(struct mlx5hws_definer_conv_data *cd,
 		       u32 *match_param)
 {
-	bool is_s_ipv6, is_d_ipv6, smac_set, dmac_set;
 	struct mlx5hws_definer_fc *fc = cd->fc;
 	struct mlx5hws_definer_fc *curr_fc;
+	bool is_ipv6, smac_set, dmac_set;
 	u32 *s_ipv6, *d_ipv6;
 
 	if (HWS_IS_FLD_SET_SZ(match_param, inner_headers.l4_type, 0x2) ||
@@ -728,10 +725,10 @@ hws_definer_conv_inner(struct mlx5hws_definer_conv_data *cd,
 			      inner_headers.dst_ipv4_dst_ipv6.ipv6_layout);
 
 	/* Assume IPv6 is used if ipv6 bits are set */
-	is_s_ipv6 = s_ipv6[0] || s_ipv6[1] || s_ipv6[2];
-	is_d_ipv6 = d_ipv6[0] || d_ipv6[1] || d_ipv6[2];
+	is_ipv6 = s_ipv6[0] || s_ipv6[1] || s_ipv6[2] ||
+		  d_ipv6[0] || d_ipv6[1] || d_ipv6[2];
 
-	if (is_s_ipv6) {
+	if (is_ipv6) {
 		/* Handle IPv6 source address */
 		HWS_SET_HDR(fc, match_param, IPV6_SRC_127_96_I,
 			    inner_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_127_96,
@@ -745,13 +742,6 @@ hws_definer_conv_inner(struct mlx5hws_definer_conv_data *cd,
 		HWS_SET_HDR(fc, match_param, IPV6_SRC_31_0_I,
 			    inner_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_31_0,
 			    ipv6_src_inner.ipv6_address_31_0);
-	} else {
-		/* Handle IPv4 source address */
-		HWS_SET_HDR(fc, match_param, IPV4_SRC_I,
-			    inner_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_31_0,
-			    ipv4_src_dest_inner.source_address);
-	}
-	if (is_d_ipv6) {
 		/* Handle IPv6 destination address */
 		HWS_SET_HDR(fc, match_param, IPV6_DST_127_96_I,
 			    inner_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_127_96,
@@ -766,6 +756,10 @@ hws_definer_conv_inner(struct mlx5hws_definer_conv_data *cd,
 			    inner_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_31_0,
 			    ipv6_dst_inner.ipv6_address_31_0);
 	} else {
+		/* Handle IPv4 source address */
+		HWS_SET_HDR(fc, match_param, IPV4_SRC_I,
+			    inner_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_31_0,
+			    ipv4_src_dest_inner.source_address);
 		/* Handle IPv4 destination address */
 		HWS_SET_HDR(fc, match_param, IPV4_DST_I,
 			    inner_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_31_0,
-- 
2.34.1


