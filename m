Return-Path: <linux-rdma+bounces-11885-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BFCAF80F7
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 21:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAE3D7A4EB1
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 18:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F76D2FA637;
	Thu,  3 Jul 2025 18:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rn7Hm8NK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303682FEE15;
	Thu,  3 Jul 2025 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751569008; cv=fail; b=tUOj3s0DsD9n5DVZeNYmzqeeCMILsC+ffm/qNqHMM+wwJI0jWLaalBu45Le5MFJkzGrOJfEIPNYwOSsP/0FzaTXLKmByEi5QGVZh8viNwTAzFNYwTMwDViel2XuOHXLEBxb5Mcnp08XHQdVVapCI1RppGcc3DAXI0fF8PkZpotw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751569008; c=relaxed/simple;
	bh=AzluDkSd3zxR3LqKxYTnpT4rC4i3FLLhqD2Qin5R4J8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQO/GME5YAWxk7U1aqW6BMkRCtHcRUb0TINlFnpbhbc5dwsg5mAb80cPFbf1m218CEHEgyvtvZO4QFoJ/yrvHML6xjovgT/e/vOApcaaEadHgSeICZ6FT7+2wpgHG0nJo+suesHFIR0DCh1JSvV7XYk7BoLrfeMH5e2cUHPu2So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rn7Hm8NK; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mn+smHiaH9L1zZtWHvyKJHvrpPNPyUnR842X8AaQjyuYy50A9DhkmlzUrxbdynAl5zb3nLZgoU1DZgD+5DyFHRCeKp6ICV/3Aq+s2nNsxZvw6yqwH7r+V5pSdEys9X6AjQFSxrvKW9cUjy7hBAm+LTFa5XQuphnVLHelNo+MCwOvAJ933xzIDHawAGqcBVVz+yR9FDSw7gW4nInjtXTjDrFtOgFsPrdIHoG/puJ/twuIixk1TeiQmrcbUYPyEVTqmyE5ra+cllB+zxSaOG6rnKUN8pagKUB8xvK1UBqhUIAJ1swADQ3HJyg33eVM4F5a7gXDFrCN9O+lh0W9FlUjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBDT1UDGj8b7T3/ErrhFbidtz4CmzbCBftSXpJ/oqWM=;
 b=QR9ujjKSwOP5NxqSGR4f1EIQlncRxQoJoV0eZaNF8zBmRdGyDaIjnyHat8UXx7ecVkDVZA2kGPTpVOl1RIGkCXG5fT31TYUNiKPBxJSM0io0nF5LxINUhBeVUeNHmFPdp50obOeOGq1x2s1ImVYOa1WmiVS2oFXCdnbk3MvPawk6DqZONHHE5Kx126mzTBL+NG/S36D7CAG212Wudgs0VqMctQ0ld4CzgOevNM+aoSTuZxZab2g8GS8D4R6s3LH7cPkE5AqhNoNLyAn9Aq2PPF58xRkMOQN23jU1IrmZ12RoAYpbT0eD5+++YX2hGgmHlBS/cj6GLa53JDPNtzFANQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBDT1UDGj8b7T3/ErrhFbidtz4CmzbCBftSXpJ/oqWM=;
 b=Rn7Hm8NKhupNcGcxZUw8JvQPMOXT02eCzaVlXm8oucUwUhH5R6wiq8uIaxPhfpJ3VDw2XVNN0AEZb860GAyLlLT1tHv6bLZUdc3w2ESt7jhVRbkHRDuI/G+Y3uQTBuIVfuir2shDCXbIeEp9CU1aV8SkNQkCjocbG0sbk71E3SskvAqrctoqIF9+SwpD63Z+7wxq7xMJhRnCR4j0cUa5xtpmfyr4MknFCR7xeIIcz3uQaT82SGJSZ41fd5ZwT+WexrABocMU70xRRxBaedwiIMJkjFOIBbuo9wtcFIo1uqWFx9Oih/ZHODjtp7szrk9KoEqEO/QMU4/nx4SxPys+/Q==
Received: from BN9PR03CA0802.namprd03.prod.outlook.com (2603:10b6:408:13f::27)
 by DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.24; Thu, 3 Jul
 2025 18:56:42 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:13f:cafe::a3) by BN9PR03CA0802.outlook.office365.com
 (2603:10b6:408:13f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Thu,
 3 Jul 2025 18:56:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Thu, 3 Jul 2025 18:56:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 3 Jul 2025
 11:56:23 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 3 Jul
 2025 11:56:23 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 3 Jul
 2025 11:56:19 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vlad Dogaru <vdogaru@nvidia.com>, "Yevgeny
 Kliteynik" <kliteyn@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v3 05/10] net/mlx5: HWS, Create STEs directly from matcher
Date: Thu, 3 Jul 2025 21:54:26 +0300
Message-ID: <20250703185431.445571-6-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703185431.445571-1-mbloch@nvidia.com>
References: <20250703185431.445571-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|DS7PR12MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e2cd04-c187-4816-0e50-08ddba635922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Iof/FWmo9F4nKXfFunkLDQSZIcmO+84RLCK/ts7tyMCciMmvA0VkdH+6iT96?=
 =?us-ascii?Q?wt8oDsdIxRkfJMmh53pFf2Vbx+X7M4O/oACWY400T3OoC7cFVvu/78wlrA0a?=
 =?us-ascii?Q?mErdp/8Jrkt2ZveGArYpYNTXzaYjJnrUBiwhdWu7VULBh1+39c9p4JpH9REN?=
 =?us-ascii?Q?hHN49Lr7tRRTj7cOubBPqjZDqUgaAFQ2+Dz/d812aKKcA5yyYV8P56Fios5E?=
 =?us-ascii?Q?aVkOxzccAvwn7fatWk2PbM1OlV67e270ogDeGZDibZhpHORBtXehi9Dmrv5p?=
 =?us-ascii?Q?7osaeMlvHYP8js5ouu2NSroracSwrXV1NLzwPLumSkizbToGjXXkbfh3inio?=
 =?us-ascii?Q?JtM0Ij8usgw+SwUu02qQIH1l11mnSGeLW0NLHdvoKoyZPH6rqIdgHIFYgvoE?=
 =?us-ascii?Q?7I9LgKrgkajQmQNxA3M3hOK5tYpSrL0oNi6QSO1VScOTlaxAUL1GDlYEirwX?=
 =?us-ascii?Q?xu0z5VYNzoaAnUkFw9vbKB6G/3AfnIIJuTYqLnYjycif2073VnffDjARsPy5?=
 =?us-ascii?Q?5ugzIWYR4IRVa/HjGgwmgHxtDtq86whG/tRThveYa96+7SMlq0Kms9+NhoHU?=
 =?us-ascii?Q?OmuRpn0BC4+8/uGEGTNV3WnUTBWXK1zL/jganCygcSck7TziaKK45Db/kP9K?=
 =?us-ascii?Q?hkEqJY+X+R1ZQu6TfMFq1YX/v/QGGg8ysUitJUXvjqcsXx1flGpMz0Sxu6ll?=
 =?us-ascii?Q?UERw346ASG5RymU1677tNZVUNOYK0IQP8fH1kB+qYjjRLOnmFXrYm7hYkApT?=
 =?us-ascii?Q?9T8ZZnMwM5Sz+xhdbc9tSk2G/2I218SkZ2iy4wQ1WXt3qciRVdiX+mpfr4DG?=
 =?us-ascii?Q?lJn4XbcLtRo736OZzL9NgVTlMYgg4KXdk1sq2PNF62jCHQh2/TThhKIpXk0k?=
 =?us-ascii?Q?bRJHZSvstqQH+Vucbwvpszzi52CIzhRAj4G38tHFa0fgk8mRNI26feWkbSep?=
 =?us-ascii?Q?51G7g/pv7xb95g9/0MoRADAw8dxV6Ypr9UK6odRhiimk/Fm42N2ufhseMLOu?=
 =?us-ascii?Q?DJb7ZOnhanOYmb9NPCE6gEmF95SVxnThHb8XTEN2v7NQw4I5vxw6gAQfcGmx?=
 =?us-ascii?Q?yWTtELF4nDjJJn9LZ8Bt5sypB3yWdaobwUFpnCpCTct3F/kP6Xf1ZztA44i3?=
 =?us-ascii?Q?pkcv+fLbo/vEo/1ReghiQf3gYlTzI/7C63Uva5o5iMuP+FtdGXhwZ5BqWsBy?=
 =?us-ascii?Q?MwRzEt5cRN3wFkPztPDYKZEeCDplsT7afbM9Xx7Gcn1l1PXMCh+D8XIPf4px?=
 =?us-ascii?Q?N1a5ih6iaXnG2fTCIY1/elnSIkLJq9wgBEPq/M77h20VwpjXOTaK4/XfF01l?=
 =?us-ascii?Q?WW311U76NzcHv90M4iGFl6iBDrrVaV6DoBqpcLB4Qv93K1RIK4UAKyddLXzP?=
 =?us-ascii?Q?9JnsBQOdGp2e5I3BkB655kxiUDAj44g9T9cskvGPn9aVT+4j+gkrbJyUnPDn?=
 =?us-ascii?Q?+h7BGgHHnTg4PVDrlWfY+FuFahwZc7bfWtwPJ9rqPYoZnN0qNgPaChgplk/3?=
 =?us-ascii?Q?GAAxZEQpj8alrogQTs7da2uILJy67F1x/9tb?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 18:56:41.4942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e2cd04-c187-4816-0e50-08ddba635922
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888

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
Reviewed-by: Simon Horman <horms@kernel.org>
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


