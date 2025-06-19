Return-Path: <linux-rdma+bounces-11459-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D02CAE047C
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 13:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB63A3A410B
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 11:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F23F2459F9;
	Thu, 19 Jun 2025 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DHe1clpB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D93322FF5E;
	Thu, 19 Jun 2025 11:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750334156; cv=fail; b=mTPZmmAmw9oGwq+dx7O6wU2qIGSPKa5e41l0uHQa7p9zBuBgH4e2QatvOEHJeyblfyZ9ldqTktP8OdUKkWFl/FXyMl8JD66Rwi+AV6CDTdwllFvjXB+4/dEuXd0CHmq/6yMkw03q4XZk7hlBc9jZV7B3hOlPEDzczM70+YaGEbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750334156; c=relaxed/simple;
	bh=lOZl7RwozwK2ifQ7DZx9GSLF2fNVK3CHdTdp4q7qgTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gnk7TrksgPgyhmZaTfXWXTPqQjREXCSbW/q55H65gNppgeaD+fWqeU1tq9DeqCXy9VIUWGw+QeiLYfx1rLKojd7N2BBniDGO4114iOE9taDr4aq7nkX4sR2MX8hd/aLUInLNxHeQji9UgBDTIR3P9DwNrs7vd9V+G0NDdyx+r4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DHe1clpB; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZJ2OWaPeZFpkXnZolDNoRCfdEdjdrqQO8BN3CQz6h1fRM+rCu6obZx8y38lXixTcjhm+JVdTttSaX2Z7CqtCTXBghoUUGuDO52aPCYUcWayNCoh/w9sMuQ0VlGr+9QhZLZ5ik6P3qIn+VD83g6MQeqWJ7adkhM18jbdGGeGlKFHvCcC/3m3BOb/GKtI1ooGsaQmudLFDgcc/95Mxg0eZQCBq+P/J6XH3svvuKnurKof6wlzdtLOvdBPrVfnryCSDAUvSLo1TzHJ9iQg8h/yWPzYZXF0EbYgTC9sGcCs3KDSbnPhMimg54HIVn0kWJEnglEzTFuNha0AGaHCJXhVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVt0N8r3F+maKEiZcu0TfT9wa8S8S02m2rs6mR+F1EI=;
 b=Xib0S1+gy128SpoQ1nELu4YxU5KBvzKtBa3oALNaSBqJRyL5ltHYEoNoSOyVB6qSMX2N2X5QQPAFA/SthyUEYxyTj/TP27MySGySRJ2YVT4j+78eBOKQmqyVGS58TjYv6+LlNKCUeUHK0uum1vACg4ZFXnQ+fbBMQseVoiP10zmNw3ky03Y5zwoPEgWr94OhO0rQ2CNhKDGbg7BCYf+17A7VB3reK6Ez62GehGNVSkulW3uogxhAK9tQwYsFFKu6aHrH4W75hF9791oYU+Biv74E97XoBLFt41/hx+P3C3JQFsZAiMUPIr6PbhXV8yPHkec8m7WQMcQe2foxdDw4cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVt0N8r3F+maKEiZcu0TfT9wa8S8S02m2rs6mR+F1EI=;
 b=DHe1clpB+9aEtCGgclthzRG7c6ECpd3cI4z1PMDPmKS+OWA584E+pQXkeB70HkbAJr1QCOI6omaslV8XUirh7g/vpq3+mhSY1/Ms10jqHg5SjNQbzacODOiBNMmBtVSSY0fP9JITKPKxYNUgawtFqAHFW2pPu7X9ppr+KKn3VfDal7+Q/SGJPdLscTSpNbFpP1QCfvIdClggDgPM0uaRpC5mgScC9ydGZAT+45fM/UAlgoVcXkZfpeWjT9Hix/deN+KtxnOJ04FYj6Qtc5ARw0L2i0UqIpHv8t1bnvF6Y+VjXrzvKJlx5PDMCAv5UWmmFkkL3x/m3SulHGnJvpnTvA==
Received: from BYAPR07CA0034.namprd07.prod.outlook.com (2603:10b6:a02:bc::47)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 19 Jun
 2025 11:55:50 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::25) by BYAPR07CA0034.outlook.office365.com
 (2603:10b6:a02:bc::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.30 via Frontend Transport; Thu,
 19 Jun 2025 11:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 11:55:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Jun
 2025 04:55:46 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 19 Jun 2025 04:55:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 19 Jun 2025 04:55:41 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next 4/8] net/mlx5: HWS, Create STEs directly from matcher
Date: Thu, 19 Jun 2025 14:55:18 +0300
Message-ID: <20250619115522.68469-5-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250619115522.68469-1-mbloch@nvidia.com>
References: <20250619115522.68469-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c76bc3-4694-409c-32b9-08ddaf283c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YRz0E4Oj+5nI5cF08ppAGkFRb4DHwby9/3JmIxHleG3n07JU4l7IuQ35Kx1d?=
 =?us-ascii?Q?f8IKiqQHs4FPzxtdbhitUYCYaf74YeJRZS87Dfr1tywBaK8gudkUzeTvJ6gS?=
 =?us-ascii?Q?/3BJhv6J0XoqtR0Se5SvSvEYGjrC/2CsmRuWBYeXaQbzs0JZNrnM467vR39P?=
 =?us-ascii?Q?BQif4jntiiJtKKrh5KjbMXsNbIDA4RCVlG7SqxQ1iqRY+rSt+L+TqMRQldUr?=
 =?us-ascii?Q?eMmxa9f3VYHJukYSd+wB96kKVrxx51gnhteLzzn+el7HcSlMfHhJgT+NH7Za?=
 =?us-ascii?Q?hPMu3VCC9H9I2VlyOqQFdUTmFovBKL5BhqHSH+FUSFyxmsKa8946Kt17Zk0Z?=
 =?us-ascii?Q?kGegl+6787hs873U2tsBdOjE6/3Oa6dOW17JFEb1FmXSwoSL/G2w9Qv9MWpN?=
 =?us-ascii?Q?1I2CeSmkHSxC6ldiZnf2mfZ9CJZXGcwqp/lCKZWah08BrFA+gcgapTzLRCnO?=
 =?us-ascii?Q?ttPbWZHPHyR8V6s11WFzqRbc+gnKj1a531UWNosx5F5pzdIB+oUD4yHXG9JQ?=
 =?us-ascii?Q?3V2PPPCHdidBOLQduSv656/dx7PMKG6NGm0NOW6v697IyoUybDNwmXx3CLLu?=
 =?us-ascii?Q?WKzh2GCuSKRPupxSa1Q4eI22IQdkBqmUsGP/M5AZarM38lkC7NDFloiARhEy?=
 =?us-ascii?Q?kyOoVS6ecfVkTVS0vwgIuV+BHmCv8iKeEdsIEHn2e0jjM9jNdN4cQj0iLfiY?=
 =?us-ascii?Q?u3iCivyIrNoi//l7CleJ/rrZj4rSECliReivfb/ylYCerHx4/g2QLK0uyaT+?=
 =?us-ascii?Q?aW3YhiO/r76i6znWKAbGAqU121v9zc71oAE3+BH/2XiKGEAMUjVYC1NmYbJk?=
 =?us-ascii?Q?vZmCIPoLnd0MLljoSTHGn563LuGom/CLUkKbUf2589Yl1ST+oZ4Xs03RlJ2B?=
 =?us-ascii?Q?D2UGvM40lRA6ZfoKqcfJgq5n2UWjy3X4dsux9uFbAPoCs74o4g9R5g7s06y5?=
 =?us-ascii?Q?7o7WEc6I1BjqZ+9xOSYOFq8j3aoHL9xOP94D3lWKuKs3JkHXer+vfko3ROHY?=
 =?us-ascii?Q?1kk6vvpjCaWk4lVgvcL3jVOwmOk+9kSgq/YEhKYgv8B8jMskR/C1HB1pjw1S?=
 =?us-ascii?Q?GcDhNIZ3ey2bjJc0rHdEDZ/8XTaN2MEwdCcvDsmuKMtLtnMteZi9fLlLm0hP?=
 =?us-ascii?Q?tt3/lNnUWpLvcREndToJAwvCS+0FTwa+8ggq/SIwpMeW7DBNAZlzbJGlm6yC?=
 =?us-ascii?Q?mufDs/Ux9J5DoeVhFD14zP8eDEtZe6Iyrde20ilxBUuU7RSbBQbuJlByWblG?=
 =?us-ascii?Q?K1qb+XhpdlX88dGuPjRgSIeelJ5vW71S3zVaHyc3L74NFpnG2eBeXRYqqn8M?=
 =?us-ascii?Q?aBI5xk6h9N+VWCOYp4yKk5Oqvs2Vfrs7XsuToyevaFhPdeMejOMJ948bLwex?=
 =?us-ascii?Q?AS5BMt5aThRm5r1mIYYvK9le+2ag5fEuNftu4h2PiP7u+o9Hfitvy1mAa7tW?=
 =?us-ascii?Q?LG1y/VyBtpJc/eiXRllyaA4NVPyR1FVJky1nbgWn/1pCEJdZGpROqESN92tf?=
 =?us-ascii?Q?NRBwAtXJirKZD2h5FVboWqDtd2LbAIZ5xSBh?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 11:55:49.7729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c76bc3-4694-409c-32b9-08ddaf283c15
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656

From: Vlad Dogaru <vdogaru@nvidia.com>

Matchers were using the pool abstraction solely as a convenience
to allocate two STE ranges. The pool's core functionality, that
of allocating individual items from the range, was unused.
Matchers rely either on the hardware to hash rules into a table,
or on a user-provided index.

Remove the STE pool from the matcher and allocate the STE ranges
manually instead.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/debug.c   | 10 +--
 .../mellanox/mlx5/core/steering/hws/matcher.c | 71 ++++++++++---------
 .../mellanox/mlx5/core/steering/hws/matcher.h |  3 +-
 3 files changed, 41 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
index 91568d6c1dac..f9b75aefcaa7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
@@ -118,7 +118,6 @@ static int hws_debug_dump_matcher(struct seq_file *f, struct mlx5hws_matcher *ma
 {
 	enum mlx5hws_table_type tbl_type = matcher->tbl->type;
 	struct mlx5hws_cmd_ft_query_attr ft_attr = {0};
-	struct mlx5hws_pool *ste_pool;
 	u64 icm_addr_0 = 0;
 	u64 icm_addr_1 = 0;
 	u32 ste_0_id = -1;
@@ -133,12 +132,9 @@ static int hws_debug_dump_matcher(struct seq_file *f, struct mlx5hws_matcher *ma
 		   matcher->end_ft_id,
 		   matcher->col_matcher ? HWS_PTR_TO_ID(matcher->col_matcher) : 0);
 
-	ste_pool = matcher->match_ste.pool;
-	if (ste_pool) {
-		ste_0_id = mlx5hws_pool_get_base_id(ste_pool);
-		if (tbl_type == MLX5HWS_TABLE_TYPE_FDB)
-			ste_1_id = mlx5hws_pool_get_base_mirror_id(ste_pool);
-	}
+	ste_0_id = matcher->match_ste.ste_0_base;
+	if (tbl_type == MLX5HWS_TABLE_TYPE_FDB)
+		ste_1_id = matcher->match_ste.ste_1_base;
 
 	seq_printf(f, ",%d,%d,%d,%d",
 		   matcher->match_ste.rtc_0_id,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
index ce28ee1c0e41..b0fcaf508e06 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
@@ -507,10 +507,8 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher)
 		}
 	}
 
-	obj_id = mlx5hws_pool_get_base_id(matcher->match_ste.pool);
-
 	rtc_attr.pd = ctx->pd_num;
-	rtc_attr.ste_base = obj_id;
+	rtc_attr.ste_base = matcher->match_ste.ste_0_base;
 	rtc_attr.reparse_mode = mlx5hws_context_get_reparse_mode(ctx);
 	rtc_attr.table_type = mlx5hws_table_get_res_fw_ft_type(tbl->type, false);
 	hws_matcher_set_rtc_attr_sz(matcher, &rtc_attr, false);
@@ -527,9 +525,7 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher)
 	}
 
 	if (tbl->type == MLX5HWS_TABLE_TYPE_FDB) {
-		obj_id = mlx5hws_pool_get_base_mirror_id(
-			matcher->match_ste.pool);
-		rtc_attr.ste_base = obj_id;
+		rtc_attr.ste_base = matcher->match_ste.ste_1_base;
 		rtc_attr.table_type = mlx5hws_table_get_res_fw_ft_type(tbl->type, true);
 
 		obj_id = mlx5hws_pool_get_base_mirror_id(ctx->stc_pool);
@@ -588,21 +584,6 @@ hws_matcher_check_attr_sz(struct mlx5hws_cmd_query_caps *caps,
 	return 0;
 }
 
-static void hws_matcher_set_pool_attr(struct mlx5hws_pool_attr *attr,
-				      struct mlx5hws_matcher *matcher)
-{
-	switch (matcher->attr.optimize_flow_src) {
-	case MLX5HWS_MATCHER_FLOW_SRC_VPORT:
-		attr->opt_type = MLX5HWS_POOL_OPTIMIZE_ORIG;
-		break;
-	case MLX5HWS_MATCHER_FLOW_SRC_WIRE:
-		attr->opt_type = MLX5HWS_POOL_OPTIMIZE_MIRROR;
-		break;
-	default:
-		break;
-	}
-}
-
 static int hws_matcher_check_and_process_at(struct mlx5hws_matcher *matcher,
 					    struct mlx5hws_action_template *at)
 {
@@ -683,8 +664,8 @@ static void hws_matcher_set_ip_version_match(struct mlx5hws_matcher *matcher)
 
 static int hws_matcher_bind_mt(struct mlx5hws_matcher *matcher)
 {
+	struct mlx5hws_cmd_ste_create_attr ste_attr = {};
 	struct mlx5hws_context *ctx = matcher->tbl->ctx;
-	struct mlx5hws_pool_attr pool_attr = {0};
 	int ret;
 
 	/* Calculate match, range and hash definers */
@@ -699,22 +680,39 @@ static int hws_matcher_bind_mt(struct mlx5hws_matcher *matcher)
 
 	hws_matcher_set_ip_version_match(matcher);
 
-	/* Create an STE pool per matcher*/
-	pool_attr.table_type = matcher->tbl->type;
-	pool_attr.pool_type = MLX5HWS_POOL_TYPE_STE;
-	pool_attr.alloc_log_sz = matcher->attr.table.sz_col_log +
-				 matcher->attr.table.sz_row_log;
-	hws_matcher_set_pool_attr(&pool_attr, matcher);
-
-	matcher->match_ste.pool = mlx5hws_pool_create(ctx, &pool_attr);
-	if (!matcher->match_ste.pool) {
-		mlx5hws_err(ctx, "Failed to allocate matcher STE pool\n");
-		ret = -EOPNOTSUPP;
+	/* Create an STE range each for RX and TX. */
+	ste_attr.table_type = FS_FT_FDB_RX;
+	ste_attr.log_obj_range =
+		matcher->attr.optimize_flow_src ==
+				MLX5HWS_MATCHER_FLOW_SRC_VPORT ?
+				0 : matcher->attr.table.sz_col_log +
+				    matcher->attr.table.sz_row_log;
+
+	ret = mlx5hws_cmd_ste_create(ctx->mdev, &ste_attr,
+				     &matcher->match_ste.ste_0_base);
+	if (ret) {
+		mlx5hws_err(ctx, "Failed to allocate RX STE range (%d)\n", ret);
 		goto uninit_match_definer;
 	}
 
+	ste_attr.table_type = FS_FT_FDB_TX;
+	ste_attr.log_obj_range =
+		matcher->attr.optimize_flow_src ==
+				MLX5HWS_MATCHER_FLOW_SRC_WIRE ?
+				0 : matcher->attr.table.sz_col_log +
+				    matcher->attr.table.sz_row_log;
+
+	ret = mlx5hws_cmd_ste_create(ctx->mdev, &ste_attr,
+				     &matcher->match_ste.ste_1_base);
+	if (ret) {
+		mlx5hws_err(ctx, "Failed to allocate TX STE range (%d)\n", ret);
+		goto destroy_rx_ste_range;
+	}
+
 	return 0;
 
+destroy_rx_ste_range:
+	mlx5hws_cmd_ste_destroy(ctx->mdev, matcher->match_ste.ste_0_base);
 uninit_match_definer:
 	if (!(matcher->flags & MLX5HWS_MATCHER_FLAGS_COLLISION))
 		mlx5hws_definer_mt_uninit(ctx, matcher->mt);
@@ -723,9 +721,12 @@ static int hws_matcher_bind_mt(struct mlx5hws_matcher *matcher)
 
 static void hws_matcher_unbind_mt(struct mlx5hws_matcher *matcher)
 {
-	mlx5hws_pool_destroy(matcher->match_ste.pool);
+	struct mlx5hws_context *ctx = matcher->tbl->ctx;
+
+	mlx5hws_cmd_ste_destroy(ctx->mdev, matcher->match_ste.ste_1_base);
+	mlx5hws_cmd_ste_destroy(ctx->mdev, matcher->match_ste.ste_0_base);
 	if (!(matcher->flags & MLX5HWS_MATCHER_FLAGS_COLLISION))
-		mlx5hws_definer_mt_uninit(matcher->tbl->ctx, matcher->mt);
+		mlx5hws_definer_mt_uninit(ctx, matcher->mt);
 }
 
 static int
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
index 32e83cddcd60..ae20bcebfdde 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
@@ -48,7 +48,8 @@ struct mlx5hws_match_template {
 struct mlx5hws_matcher_match_ste {
 	u32 rtc_0_id;
 	u32 rtc_1_id;
-	struct mlx5hws_pool *pool;
+	u32 ste_0_base;
+	u32 ste_1_base;
 };
 
 enum {
-- 
2.34.1


