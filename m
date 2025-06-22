Return-Path: <linux-rdma+bounces-11524-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743DDAE310B
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Jun 2025 19:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB273AC745
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Jun 2025 17:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ABA1F4163;
	Sun, 22 Jun 2025 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FvKZUgM7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAADC20DD7E;
	Sun, 22 Jun 2025 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750612994; cv=fail; b=Tlce2i2i6RYKdFBNS1yNhrUGKFwzUY3WnGa2y6Ewro2d8NmwL9X7jPk7Y2W+pktNRPTHYrfk9PtUSqn9TQXWPOX8/Dx22lPaZzcqu846rKEe6gPYiARpld+WQtgDa6onAQ3wc5Y/QqBi4zmJnkUJeiyZQRYNbitpgrCh6uH9yhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750612994; c=relaxed/simple;
	bh=BbKwfm+gws0iLnxoLEW36vN0EazJnCwxxaeapi/BZXg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQCu7Dn5qdhd/aCttVeZI6nWXyAD9fHgYChGykaBF6edEx9/WmHpb4cdmW+HzIS/JLM+zxKTVBQu5rY8WVLJnqDGyysmHpAnzLanbUPFshN8oGNe6ehlzI0ds6DuyqrLuObB2kDQcLO2Sv54r6s8+fsYxSQ5BpEJSsAjOvyQVtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FvKZUgM7; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZZillBSnd9fpdbD34+Qh8hQbU0Nq8ccBSfT1f5bhUp9/ptumgVu6cWWLjuScKB3TvcrkkHRWWZmb8cQlQHGm8lQ6NhaGvOwKi/eEUyQC6ItXPLuIb5bByhBTrDt5R6DLyEDS6IlXIWKoNM9xwP/Jl3QqbcxuCVMEACkam3f8S53XdUadDoTjKiX4rduy9xTkWctfRhn3y+7bBiNJjMtCQi9nfga3UNm4s1WrvnAUczB8PGltTgbKxcDsotcEyi1ll9t91Vh9yvaTxnYk8hM1jw2fDuf/WzZN0jMabBCqR/ldgSiRdxQQ4NfNvu3JX4Azwzywhu+dITlCgnpHFqsaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwZIZFEywCDDuLzfpfdT2JPDgZus/YtUSjYELmqX1sA=;
 b=BqdwiEk6VeGZMLZB53unaUqGVFVJQylWJioiWEp1H5POlR/eWq5yY7qm2rAX4h3EsYZif0Cq7tbdRE1tE0RNLYvWWSAN0u36i0ar2TU+Ck2h2FYWxevwmdAjVLUGmRmYT7VXmxEIj+7l0khCsq/mUCM52pt4pqd5TT9xrUUpDNOj9/16ybRQfyq406j1gTZilS8nxt9dKdFDkIUnuO91g5GQV0Ns5ZCgroZTE81ZnZ8KGk5AkOQu0X2L8dbL+mywLtaknUVbdcEd9dEhjNNHRCybQrmGwRySGfLGWxTV7XDGK52wOChv//hyLChVf38ATeM7nKqouSGeVmmHaK2qWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwZIZFEywCDDuLzfpfdT2JPDgZus/YtUSjYELmqX1sA=;
 b=FvKZUgM7ZQBfBdMDhH3N5KFqCUs0CLcrz9uZCGyBxMxC58t4oTcM6h8NLnGw5tHI8jMKx0bJwxuSlRMrZ6v6HGJHgX9cmDCyjaGK0/J1qjnQv4IiYNFdzEWOpqLReZdFsmzWJEOWMWYgR3uGfpntwWOssOm16XBEPgLXxEc6Gp7t5zF1VPiCv+NpLgw+IjPqcrViyy61UVT1p99AVMpl2NnlIbQKoCLkyc1MCCJ7UYRFghCmXIGsNiFp++lS0GPdLOxZTXQyJG9+VaMUS0LvRVE6T3fINU9y47NCJNiXfKYO4kQRPSzQ/B0THXbu2r5BEvYgGFzY/vowZenFSjF+Mg==
Received: from MW4PR03CA0147.namprd03.prod.outlook.com (2603:10b6:303:8c::32)
 by SJ0PR12MB8114.namprd12.prod.outlook.com (2603:10b6:a03:4e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Sun, 22 Jun
 2025 17:23:06 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:303:8c:cafe::7d) by MW4PR03CA0147.outlook.office365.com
 (2603:10b6:303:8c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.28 via Frontend Transport; Sun,
 22 Jun 2025 17:23:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Sun, 22 Jun 2025 17:23:06 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 22 Jun
 2025 10:23:05 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 22 Jun 2025 10:23:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 22 Jun 2025 10:23:01 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <moshe@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next v2 6/8] net/mlx5: HWS, Track matcher sizes individually
Date: Sun, 22 Jun 2025 20:22:24 +0300
Message-ID: <20250622172226.4174-7-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250622172226.4174-1-mbloch@nvidia.com>
References: <20250622172226.4174-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|SJ0PR12MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 65738419-04db-486f-8a83-08ddb1b17385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Muy9+K/iuv4J2Yg7koOKmiKxmyT27CikJL8ZXcW9JAoxTldohidQM9kNdpKL?=
 =?us-ascii?Q?DduSgCd1t3ztMfa52OZg+H5m5hLR9enyvTmDITPKDQVvlHLa+f/bdK4K2pSQ?=
 =?us-ascii?Q?OZjPBk0X34UVbTFW+wzBIcufXXUz71iDHXjQ3rt4XEyv49pENOsRxDoQsL70?=
 =?us-ascii?Q?6t8lFp7un2/TOYlsxJOQmtl4hUlQEqSROz79Ua5AXftDAtzqelQ/geEa79Sg?=
 =?us-ascii?Q?6AH9+2Ed3sFPx6i4n/bciuw6m1WHtaGD95qtkWHaZ0YpV4jk8H08P3HO2gH2?=
 =?us-ascii?Q?VMzntit2XBV39GmYihnaGTKvb7RemewFHQxCT5/ulimENfz6fVXetgNkKk5q?=
 =?us-ascii?Q?aFTMpVah3uxfIzJYE6r3FW2xM8rp+VYOe4PAo7r3l+KwlbpN+kBdOt1FGHZ9?=
 =?us-ascii?Q?lHgNdjsfHj0PXAgPDrgBjuBa4NsyUZS9/WugG2RF6Wik1sFAduYqcOMcMpUG?=
 =?us-ascii?Q?ZcN/w3hg1gtoD4HtYgXYVOe3VVAhE/qWq/tVfeXwjmKD+gN0ZTSRGZEurBbV?=
 =?us-ascii?Q?BCy37a6bQZ1vtZHxFfowHOeY5JWfbm8hi94Y/i9KDH+xGgQdyqYnnLlOYO6z?=
 =?us-ascii?Q?mtwovKW9sgEt0rlsKUMsbOldhRJtjqfFCmYyZT6n0Xa9PW0XGiSHbS28448d?=
 =?us-ascii?Q?yyPkNWs4eMcWafTxXmmIUZkEnHDPdtJ1YraLcr7U/FYG8qAZ3XQRdhWnl2Em?=
 =?us-ascii?Q?2yoGlzjjz3argzosz84fE0HXBVz1vcox+QxcaJSaI/V3LlidBwA+tMOja0lU?=
 =?us-ascii?Q?MEs0j5tVHjNW+XG3qaglO2fATHmYdf0gRuOfMRtdsDHhWZQnhgbIxf4YHf9Z?=
 =?us-ascii?Q?dgAmO6uiiI7IKJVJUt2h8u9VOb8/Jmes5jq4zs47hwJJQ+BV92hRiW30Je6M?=
 =?us-ascii?Q?KOHBqHGkUBKTXTJ3Tq1DpFh4NjihgnP2LmQiXZ+9A3+nu9tBJurpJDV9M/Uw?=
 =?us-ascii?Q?4KXEHS7UoOaq6vuqANpp3SU3BVDzwZuIkIS/JbZIsPpV+JUahVdxsh3Lb0LR?=
 =?us-ascii?Q?4UpFkwCYyuvZj8lYG/+LQzdDy1UTgXhERFsD8nHF3yTVUUPnOzlMyGIJWYhD?=
 =?us-ascii?Q?wYKZ02IxJZor0V8gDxqmfzudYwOcO/VKOQG/GRonCBc/NrfWeilBXeRcB3W9?=
 =?us-ascii?Q?3iGeE+vJX5e4sq3BiKXfCj41rdIwJfp3v3tMkxH1XGki9f7QLn70kIqD271w?=
 =?us-ascii?Q?r7DL37kw4z3PVELRRrjVsRkaJmIXTuPFfZwaDf5zB0MWfs3O7YQgxNBTVsf1?=
 =?us-ascii?Q?v0kqvPNA1uaG3OXrerVQ1gXzH08vpiDB0Zar0JBTbEyXYg/CYDzpXhoFeiIu?=
 =?us-ascii?Q?JuJtuL4QKruJcSrgIaQiIXV4dEkh+pxEnyBOiyJBNvAKfOXIIFstc8YrKdCm?=
 =?us-ascii?Q?jme4QISrIl6VsHpmwrVsq/amC1TQUIgulhQfT9z28XbZiK0L6rnEGFIHQ0rC?=
 =?us-ascii?Q?7ZWh1fFWoGG6L5Z9dpM2vDdaE/fFRrY2BRPy4J0hST9vJWoenoJT2yNSs2b8?=
 =?us-ascii?Q?AWBMjhRqUiFnRShOhgaD+0chgSkCH8mecJw3?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2025 17:23:06.1076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65738419-04db-486f-8a83-08ddb1b17385
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8114

From: Vlad Dogaru <vdogaru@nvidia.com>

Track and grow matcher sizes individually for RX and TX RTCs. This
allows RX-only or TX-only use cases to effectively halve the device
resources they use.

For testing we used a simple module that inserts 1M RX-only rules and
measured the number of pages the device requests, and memory usage as
reported by `free -h`.

			Pages		Memory
Before this patch:	300k		1.5GiB
After this patch:	160k		900MiB

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/bwc.c     | 213 +++++++++++++-----
 .../mellanox/mlx5/core/steering/hws/bwc.h     |  14 +-
 2 files changed, 167 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 009641e6c874..0a7903cf75e8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -93,12 +93,11 @@ int mlx5hws_bwc_matcher_create_simple(struct mlx5hws_bwc_matcher *bwc_matcher,
 
 	hws_bwc_matcher_init_attr(bwc_matcher,
 				  priority,
-				  MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG,
-				  MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG,
+				  bwc_matcher->rx_size.size_log,
+				  bwc_matcher->tx_size.size_log,
 				  &attr);
 
 	bwc_matcher->priority = priority;
-	bwc_matcher->size_log = MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG;
 
 	bwc_matcher->size_of_at_array = MLX5HWS_BWC_MATCHER_ATTACH_AT_NUM;
 	bwc_matcher->at = kcalloc(bwc_matcher->size_of_at_array,
@@ -150,6 +149,20 @@ int mlx5hws_bwc_matcher_create_simple(struct mlx5hws_bwc_matcher *bwc_matcher,
 	return -EINVAL;
 }
 
+static void
+hws_bwc_matcher_init_size_rxtx(struct mlx5hws_bwc_matcher_size *size)
+{
+	size->size_log = MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG;
+	atomic_set(&size->num_of_rules, 0);
+	atomic_set(&size->rehash_required, false);
+}
+
+static void hws_bwc_matcher_init_size(struct mlx5hws_bwc_matcher *bwc_matcher)
+{
+	hws_bwc_matcher_init_size_rxtx(&bwc_matcher->rx_size);
+	hws_bwc_matcher_init_size_rxtx(&bwc_matcher->tx_size);
+}
+
 struct mlx5hws_bwc_matcher *
 mlx5hws_bwc_matcher_create(struct mlx5hws_table *table,
 			   u32 priority,
@@ -170,8 +183,7 @@ mlx5hws_bwc_matcher_create(struct mlx5hws_table *table,
 	if (!bwc_matcher)
 		return NULL;
 
-	atomic_set(&bwc_matcher->num_of_rules, 0);
-	atomic_set(&bwc_matcher->rehash_required, false);
+	hws_bwc_matcher_init_size(bwc_matcher);
 
 	/* Check if the required match params can be all matched
 	 * in single STE, otherwise complex matcher is needed.
@@ -221,12 +233,13 @@ int mlx5hws_bwc_matcher_destroy_simple(struct mlx5hws_bwc_matcher *bwc_matcher)
 
 int mlx5hws_bwc_matcher_destroy(struct mlx5hws_bwc_matcher *bwc_matcher)
 {
-	u32 num_of_rules = atomic_read(&bwc_matcher->num_of_rules);
+	u32 rx_rules = atomic_read(&bwc_matcher->rx_size.num_of_rules);
+	u32 tx_rules = atomic_read(&bwc_matcher->tx_size.num_of_rules);
 
-	if (num_of_rules)
+	if (rx_rules || tx_rules)
 		mlx5hws_err(bwc_matcher->matcher->tbl->ctx,
-			    "BWC matcher destroy: matcher still has %d rules\n",
-			    num_of_rules);
+			    "BWC matcher destroy: matcher still has %u RX and %u TX rules\n",
+			    rx_rules, tx_rules);
 
 	if (bwc_matcher->complex)
 		mlx5hws_bwc_matcher_destroy_complex(bwc_matcher);
@@ -386,6 +399,16 @@ hws_bwc_rule_destroy_hws_sync(struct mlx5hws_bwc_rule *bwc_rule,
 	return 0;
 }
 
+static void hws_bwc_rule_cnt_dec(struct mlx5hws_bwc_rule *bwc_rule)
+{
+	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
+
+	if (!bwc_rule->skip_rx)
+		atomic_dec(&bwc_matcher->rx_size.num_of_rules);
+	if (!bwc_rule->skip_tx)
+		atomic_dec(&bwc_matcher->tx_size.num_of_rules);
+}
+
 int mlx5hws_bwc_rule_destroy_simple(struct mlx5hws_bwc_rule *bwc_rule)
 {
 	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
@@ -402,7 +425,7 @@ int mlx5hws_bwc_rule_destroy_simple(struct mlx5hws_bwc_rule *bwc_rule)
 	mutex_lock(queue_lock);
 
 	ret = hws_bwc_rule_destroy_hws_sync(bwc_rule, &attr);
-	atomic_dec(&bwc_matcher->num_of_rules);
+	hws_bwc_rule_cnt_dec(bwc_rule);
 	hws_bwc_rule_list_remove(bwc_rule);
 
 	mutex_unlock(queue_lock);
@@ -489,25 +512,27 @@ hws_bwc_rule_update_sync(struct mlx5hws_bwc_rule *bwc_rule,
 }
 
 static bool
-hws_bwc_matcher_size_maxed_out(struct mlx5hws_bwc_matcher *bwc_matcher)
+hws_bwc_matcher_size_maxed_out(struct mlx5hws_bwc_matcher *bwc_matcher,
+			       struct mlx5hws_bwc_matcher_size *size)
 {
 	struct mlx5hws_cmd_query_caps *caps = bwc_matcher->matcher->tbl->ctx->caps;
 
 	/* check the match RTC size */
-	return (bwc_matcher->size_log + MLX5HWS_MATCHER_ASSURED_MAIN_TBL_DEPTH +
+	return (size->size_log + MLX5HWS_MATCHER_ASSURED_MAIN_TBL_DEPTH +
 		MLX5HWS_BWC_MATCHER_SIZE_LOG_STEP) >
 	       (caps->ste_alloc_log_max - 1);
 }
 
 static bool
 hws_bwc_matcher_rehash_size_needed(struct mlx5hws_bwc_matcher *bwc_matcher,
+				   struct mlx5hws_bwc_matcher_size *size,
 				   u32 num_of_rules)
 {
-	if (unlikely(hws_bwc_matcher_size_maxed_out(bwc_matcher)))
+	if (unlikely(hws_bwc_matcher_size_maxed_out(bwc_matcher, size)))
 		return false;
 
 	if (unlikely((num_of_rules * 100 / MLX5HWS_BWC_MATCHER_REHASH_PERCENT_TH) >=
-		     (1UL << bwc_matcher->size_log)))
+		     (1UL << size->size_log)))
 		return true;
 
 	return false;
@@ -564,20 +589,21 @@ hws_bwc_matcher_extend_at(struct mlx5hws_bwc_matcher *bwc_matcher,
 }
 
 static int
-hws_bwc_matcher_extend_size(struct mlx5hws_bwc_matcher *bwc_matcher)
+hws_bwc_matcher_extend_size(struct mlx5hws_bwc_matcher *bwc_matcher,
+			    struct mlx5hws_bwc_matcher_size *size)
 {
 	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
 	struct mlx5hws_cmd_query_caps *caps = ctx->caps;
 
-	if (unlikely(hws_bwc_matcher_size_maxed_out(bwc_matcher))) {
+	if (unlikely(hws_bwc_matcher_size_maxed_out(bwc_matcher, size))) {
 		mlx5hws_err(ctx, "Can't resize matcher: depth exceeds limit %d\n",
 			    caps->rtc_log_depth_max);
 		return -ENOMEM;
 	}
 
-	bwc_matcher->size_log =
-		min(bwc_matcher->size_log + MLX5HWS_BWC_MATCHER_SIZE_LOG_STEP,
-		    caps->ste_alloc_log_max - MLX5HWS_MATCHER_ASSURED_MAIN_TBL_DEPTH);
+	size->size_log = min(size->size_log + MLX5HWS_BWC_MATCHER_SIZE_LOG_STEP,
+			     caps->ste_alloc_log_max -
+				     MLX5HWS_MATCHER_ASSURED_MAIN_TBL_DEPTH);
 
 	return 0;
 }
@@ -697,8 +723,8 @@ static int hws_bwc_matcher_move(struct mlx5hws_bwc_matcher *bwc_matcher)
 
 	hws_bwc_matcher_init_attr(bwc_matcher,
 				  bwc_matcher->priority,
-				  bwc_matcher->size_log,
-				  bwc_matcher->size_log,
+				  bwc_matcher->rx_size.size_log,
+				  bwc_matcher->tx_size.size_log,
 				  &matcher_attr);
 
 	old_matcher = bwc_matcher->matcher;
@@ -736,21 +762,39 @@ static int hws_bwc_matcher_move(struct mlx5hws_bwc_matcher *bwc_matcher)
 static int
 hws_bwc_matcher_rehash_size(struct mlx5hws_bwc_matcher *bwc_matcher)
 {
+	bool need_rx_rehash, need_tx_rehash;
 	int ret;
 
-	/* If the current matcher size is already at its max size, we can't
-	 * do the rehash. Skip it and try adding the rule again - perhaps
-	 * there was some change.
+	need_rx_rehash = atomic_read(&bwc_matcher->rx_size.rehash_required);
+	need_tx_rehash = atomic_read(&bwc_matcher->tx_size.rehash_required);
+
+	/* It is possible that another rule has already performed rehash.
+	 * Need to check again if we really need rehash.
 	 */
-	if (hws_bwc_matcher_size_maxed_out(bwc_matcher))
+	if (!need_rx_rehash && !need_tx_rehash)
 		return 0;
 
-	/* It is possible that other rule has already performed rehash.
-	 * Need to check again if we really need rehash.
+	/* If the current matcher RX/TX size is already at its max size,
+	 * it can't be rehashed.
 	 */
-	if (!atomic_read(&bwc_matcher->rehash_required) &&
-	    !hws_bwc_matcher_rehash_size_needed(bwc_matcher,
-						atomic_read(&bwc_matcher->num_of_rules)))
+	if (need_rx_rehash &&
+	    hws_bwc_matcher_size_maxed_out(bwc_matcher,
+					   &bwc_matcher->rx_size)) {
+		atomic_set(&bwc_matcher->rx_size.rehash_required, false);
+		need_rx_rehash = false;
+	}
+	if (need_tx_rehash &&
+	    hws_bwc_matcher_size_maxed_out(bwc_matcher,
+					   &bwc_matcher->tx_size)) {
+		atomic_set(&bwc_matcher->tx_size.rehash_required, false);
+		need_tx_rehash = false;
+	}
+
+	/* If both RX and TX rehash flags are now off, it means that whatever
+	 * we wanted to rehash is now at its max size - no rehash can be done.
+	 * Return and try adding the rule again - perhaps there was some change.
+	 */
+	if (!need_rx_rehash && !need_tx_rehash)
 		return 0;
 
 	/* Now we're done all the checking - do the rehash:
@@ -759,12 +803,22 @@ hws_bwc_matcher_rehash_size(struct mlx5hws_bwc_matcher *bwc_matcher)
 	 *  - move all the rules to the new matcher
 	 *  - destroy the old matcher
 	 */
+	atomic_set(&bwc_matcher->rx_size.rehash_required, false);
+	atomic_set(&bwc_matcher->tx_size.rehash_required, false);
 
-	atomic_set(&bwc_matcher->rehash_required, false);
+	if (need_rx_rehash) {
+		ret = hws_bwc_matcher_extend_size(bwc_matcher,
+						  &bwc_matcher->rx_size);
+		if (ret)
+			return ret;
+	}
 
-	ret = hws_bwc_matcher_extend_size(bwc_matcher);
-	if (ret)
-		return ret;
+	if (need_tx_rehash) {
+		ret = hws_bwc_matcher_extend_size(bwc_matcher,
+						  &bwc_matcher->tx_size);
+		if (ret)
+			return ret;
+	}
 
 	return hws_bwc_matcher_move(bwc_matcher);
 }
@@ -816,6 +870,62 @@ static int hws_bwc_rule_get_at_idx(struct mlx5hws_bwc_rule *bwc_rule,
 	return at_idx;
 }
 
+static void hws_bwc_rule_cnt_inc_rxtx(struct mlx5hws_bwc_rule *bwc_rule,
+				      struct mlx5hws_bwc_matcher_size *size)
+{
+	u32 num_of_rules = atomic_inc_return(&size->num_of_rules);
+
+	if (unlikely(hws_bwc_matcher_rehash_size_needed(bwc_rule->bwc_matcher,
+							size, num_of_rules)))
+		atomic_set(&size->rehash_required, true);
+}
+
+static void hws_bwc_rule_cnt_inc(struct mlx5hws_bwc_rule *bwc_rule)
+{
+	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
+
+	if (!bwc_rule->skip_rx)
+		hws_bwc_rule_cnt_inc_rxtx(bwc_rule, &bwc_matcher->rx_size);
+	if (!bwc_rule->skip_tx)
+		hws_bwc_rule_cnt_inc_rxtx(bwc_rule, &bwc_matcher->tx_size);
+}
+
+static int hws_bwc_rule_cnt_inc_with_rehash(struct mlx5hws_bwc_rule *bwc_rule,
+					    u16 bwc_queue_idx)
+{
+	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
+	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
+	struct mutex *queue_lock; /* Protect the queue */
+	int ret;
+
+	hws_bwc_rule_cnt_inc(bwc_rule);
+
+	if (!atomic_read(&bwc_matcher->rx_size.rehash_required) &&
+	    !atomic_read(&bwc_matcher->tx_size.rehash_required))
+		return 0;
+
+	queue_lock = hws_bwc_get_queue_lock(ctx, bwc_queue_idx);
+	mutex_unlock(queue_lock);
+
+	hws_bwc_lock_all_queues(ctx);
+	ret = hws_bwc_matcher_rehash_size(bwc_matcher);
+	hws_bwc_unlock_all_queues(ctx);
+
+	mutex_lock(queue_lock);
+
+	if (likely(!ret))
+		return 0;
+
+	/* Failed to rehash. Print a diagnostic and rollback the counters. */
+	mlx5hws_err(ctx,
+		    "BWC rule insertion: rehash to sizes [%d, %d] failed (%d)\n",
+		    bwc_matcher->rx_size.size_log,
+		    bwc_matcher->tx_size.size_log, ret);
+	hws_bwc_rule_cnt_dec(bwc_rule);
+
+	return ret;
+}
+
 int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 				   u32 *match_param,
 				   struct mlx5hws_rule_action rule_actions[],
@@ -826,7 +936,6 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
 	struct mlx5hws_rule_attr rule_attr;
 	struct mutex *queue_lock; /* Protect the queue */
-	u32 num_of_rules;
 	int ret = 0;
 	int at_idx;
 
@@ -844,26 +953,10 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 		return -EINVAL;
 	}
 
-	/* check if number of rules require rehash */
-	num_of_rules = atomic_inc_return(&bwc_matcher->num_of_rules);
-
-	if (unlikely(hws_bwc_matcher_rehash_size_needed(bwc_matcher, num_of_rules))) {
+	ret = hws_bwc_rule_cnt_inc_with_rehash(bwc_rule, bwc_queue_idx);
+	if (unlikely(ret)) {
 		mutex_unlock(queue_lock);
-
-		hws_bwc_lock_all_queues(ctx);
-		ret = hws_bwc_matcher_rehash_size(bwc_matcher);
-		hws_bwc_unlock_all_queues(ctx);
-
-		if (ret) {
-			mlx5hws_err(ctx, "BWC rule insertion: rehash size [%d -> %d] failed (%d)\n",
-				    bwc_matcher->size_log - MLX5HWS_BWC_MATCHER_SIZE_LOG_STEP,
-				    bwc_matcher->size_log,
-				    ret);
-			atomic_dec(&bwc_matcher->num_of_rules);
-			return ret;
-		}
-
-		mutex_lock(queue_lock);
+		return ret;
 	}
 
 	ret = hws_bwc_rule_create_sync(bwc_rule,
@@ -881,8 +974,11 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 	 * It could be because there was collision, or some other problem.
 	 * Try rehash by size and insert rule again - last chance.
 	 */
+	if (!bwc_rule->skip_rx)
+		atomic_set(&bwc_matcher->rx_size.rehash_required, true);
+	if (!bwc_rule->skip_tx)
+		atomic_set(&bwc_matcher->tx_size.rehash_required, true);
 
-	atomic_set(&bwc_matcher->rehash_required, true);
 	mutex_unlock(queue_lock);
 
 	hws_bwc_lock_all_queues(ctx);
@@ -891,7 +987,7 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 
 	if (ret) {
 		mlx5hws_err(ctx, "BWC rule insertion: rehash failed (%d)\n", ret);
-		atomic_dec(&bwc_matcher->num_of_rules);
+		hws_bwc_rule_cnt_dec(bwc_rule);
 		return ret;
 	}
 
@@ -907,7 +1003,7 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 	if (unlikely(ret)) {
 		mutex_unlock(queue_lock);
 		mlx5hws_err(ctx, "BWC rule insertion failed (%d)\n", ret);
-		atomic_dec(&bwc_matcher->num_of_rules);
+		hws_bwc_rule_cnt_dec(bwc_rule);
 		return ret;
 	}
 
@@ -937,6 +1033,9 @@ mlx5hws_bwc_rule_create(struct mlx5hws_bwc_matcher *bwc_matcher,
 	if (unlikely(!bwc_rule))
 		return NULL;
 
+	mlx5hws_rule_skip(bwc_matcher->matcher, flow_source,
+			  &bwc_rule->skip_rx, &bwc_rule->skip_tx);
+
 	bwc_queue_idx = hws_bwc_gen_queue_idx(ctx);
 
 	if (bwc_matcher->complex)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
index d21fc247a510..1e9de6b9222c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
@@ -19,6 +19,13 @@
 #define MLX5HWS_BWC_POLLING_TIMEOUT 60
 
 struct mlx5hws_bwc_matcher_complex_data;
+
+struct mlx5hws_bwc_matcher_size {
+	u8 size_log;
+	atomic_t num_of_rules;
+	atomic_t rehash_required;
+};
+
 struct mlx5hws_bwc_matcher {
 	struct mlx5hws_matcher *matcher;
 	struct mlx5hws_match_template *mt;
@@ -27,10 +34,9 @@ struct mlx5hws_bwc_matcher {
 	struct mlx5hws_bwc_matcher *complex_first_bwc_matcher;
 	u8 num_of_at;
 	u8 size_of_at_array;
-	u8 size_log;
 	u32 priority;
-	atomic_t num_of_rules;
-	atomic_t rehash_required;
+	struct mlx5hws_bwc_matcher_size rx_size;
+	struct mlx5hws_bwc_matcher_size tx_size;
 	struct list_head *rules;
 };
 
@@ -40,6 +46,8 @@ struct mlx5hws_bwc_rule {
 	struct mlx5hws_bwc_rule *isolated_bwc_rule;
 	struct mlx5hws_bwc_complex_rule_hash_node *complex_hash_node;
 	u16 bwc_queue_idx;
+	bool skip_rx;
+	bool skip_tx;
 	struct list_head list_node;
 };
 
-- 
2.34.1


