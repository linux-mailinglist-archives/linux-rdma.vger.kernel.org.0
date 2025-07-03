Return-Path: <linux-rdma+bounces-11887-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A17AF80FC
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 21:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923823B03CB
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 19:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784312FA655;
	Thu,  3 Jul 2025 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XFoDZdxy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7262E2FF497;
	Thu,  3 Jul 2025 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751569021; cv=fail; b=P9FndVkX6lVVhrhrNusgaOPmAYIScI3Y5hhV4DT0iZO+siZApAZXTeqYApksIWj/fM43FOSVlZQRF1yZVGIuMuc+aM3BOt51YTLEAm4o4zWpIEzcYWfWItpqA8vqys3WgvBp6ZXZRlAC95ir29swij5U8EIATXIBDBk2a8+h9ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751569021; c=relaxed/simple;
	bh=shBTmTTtN4bdSSkK2+UhSSSH9jbTM4DoZqYC2vllB28=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjjcsWN1J95iNyHJdIIEII1YhdAWsy8LjPUbJgNNtoj1ec0Ctg7vpoxsMSEWfZh2TcbSX3mmaq57zaNeld22HxO4Aq47E78i815Q61J2amzZBmNtjfxl7Vot396dskKOZebmA2M1Xb/1Zz+8gE+kdCOqzTA7NTAI6ACeq63h9kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XFoDZdxy; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+el+Ceb88P10xjJvxsGLsmjMVhS16aCkmTScvTPx9MMBFYrnaZf/npe3NbWalDkS3tzhlLpG/VO+fau/R3E/miGz6j0nOHM78gs9sHU/I3i0WOZwcniFx6hrQyQFqKeaufl8vMAT6u9DGvnQVnQE2yOTEki3Q4dc9y8a90A7yRE20/Omgd/A1iL0/dr06NZOwP6Tm0Kpvl96w82ti3KMr6OHUP+MT2ncgeJPs8M7jowU4fmy9KMb6pG4h6cSIcuiK3e93kbxp7v0evUNWVr7kCXAmhkpZEFkQrx8G817sS9tFwG1u5gV/klQ3ltjb8DrhMl/pr8Li/9mJPI/I2ZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zw2/+3bFtZgApOakUYNhNpV/SV7S7Su/S5VG5hBOcho=;
 b=WNwBs4HHqbZC1BaUjiu74rRreRAk8VuUc2BreIvIJYtthN+l1iAkZLmiSsJ0wigwlOqm9axKSAFd1YCUsaAKUi+TtCNRxthCUO6f9OioYMfRd+/GXW1Ze1VZBCiP/QmNzG3zXZJj1zBbmp8/lLYBn65ADePJke98EXwoCnobiWdbDGwhanjPS53txOfz03dNlFV+j491hLMb0QupBLateSFC4rgDr4lpXOTCi1bMSEYk7qNz0QyPvWZVBk9FAElRS37V5rBZ+m0flTX+EwV8hnewcWYkYYAh7dm3ICFn8vstqhG97+q+ISgraaOH2x4wiM4DgWtwj6s3GEplC30OHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zw2/+3bFtZgApOakUYNhNpV/SV7S7Su/S5VG5hBOcho=;
 b=XFoDZdxyfHn4sz6Xi+pmHyrmA0ii7H+eAJIQkB+CYxkZ7rCF0eVLU29HRR7DqM5kxgVqjPQh9U0qy+bRm/J3XOEE/vV9P810D/LOpN1IScB4EdbVNMC+0SX21MmMUEiDmThpQl7icFz294mkK+J28KeVvWrfwxf1fNxb3/u+buyufOCQ8DtPZUG9rROFUYpcs7jhTVByK1SbZJpwNdTBk1xsTSPgQeAE9G7BLFEk3XANtiEVSqGWP2hWNtlvNTTgxhrFtkpItCwqrX0nRMLZR2LvCX4wGTQFPTB3Iy3RziOFroJr/sofS8xBYkFLZyjWtZQzdEvNu3QR0bKubEWhNw==
Received: from MN0P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::35)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 3 Jul
 2025 18:56:56 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::ae) by MN0P222CA0027.outlook.office365.com
 (2603:10b6:208:531::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Thu,
 3 Jul 2025 18:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Thu, 3 Jul 2025 18:56:55 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 3 Jul 2025
 11:56:37 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 3 Jul
 2025 11:56:37 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 3 Jul
 2025 11:56:33 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yevgeny Kliteynik <kliteyn@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>
Subject: [PATCH net-next v3 08/10] net/mlx5: HWS, Rearrange to prevent forward declaration
Date: Thu, 3 Jul 2025 21:54:29 +0300
Message-ID: <20250703185431.445571-9-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|DM6PR12MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cecaa19-9502-4a9d-89f8-08ddba63614c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8cc3vTP90JrbvW+6HPH3Zlmhd+45Xxzx4CHetk/3AlPrj35GHSi2G66URFpR?=
 =?us-ascii?Q?ACGtk7B3bS8p4WP6eLIWWM2Gw5M8r3+YIo4YXIu9BYaVLr2EAKqzkO4t41F9?=
 =?us-ascii?Q?19E1DxMye1k/Kx3jx2Gxq8cgoyepFEr6Jy44/OScRp8aEdoneOFkkBkSVnCd?=
 =?us-ascii?Q?RPorTUTlSQXzdVru4mfOqqq9WVWtVH6ooKRc1XRxM2jTJzFXEJcVxy9QWtFR?=
 =?us-ascii?Q?xLRuFtQakKVheudpJvFdVBXRtFqmNddNjNW0boMSrX1VTVKyHaZx9eVh4uLk?=
 =?us-ascii?Q?lZUE1QgrzI9JjBPFYKClgpmIj6vp8XB5keAralASvvB7b9PymLdENTPHTNxm?=
 =?us-ascii?Q?edHqLEeHvyDK9tZpoEXXKkssSzugLynHsvLiK7QaFdokkSdQVxx9jxnXVj3i?=
 =?us-ascii?Q?oV+lDiSeaC81L1zwt4+JxuB8rSN+Q8s3zABhNeDwTX4JAuxvjlMlfXslJ3dR?=
 =?us-ascii?Q?ld7RxFWBGn+Meeuqg9QBubVjf8pvNGt34OBVatjbvXwPdGRtVvnpufeJbxYK?=
 =?us-ascii?Q?Qw6k95SdNI4NYGtRhHqijq1M0OybL538u8+R8ERgT/bH1n0MOcyWCKOViDoI?=
 =?us-ascii?Q?DICd4E3/3TOt9N4O5BVo4cbqr5kyeUInjPFaUTEihpPoNGz2BCWokKLAC9Y6?=
 =?us-ascii?Q?Ohjp6G+WzQMiLe3kLxDW67KiFVcx6Be+A33u0nBG6cZrIyE0YXYRC1q6LBGU?=
 =?us-ascii?Q?KZf92GvFgVidAsP6tnjeI/VL29sOCcVpwy8TikxhUItvytRXFZNI76mifWPI?=
 =?us-ascii?Q?9y43+kOCbLjxLPn2rqpo+BA4aX2YKChb19w2ytQJzn6nk3w51q7KdnyEUL4b?=
 =?us-ascii?Q?BHYqPiRkFEEYfSCO2OeVBqFfTwypVc433MpR4VvAXXFAc1gxEoiB7UV0HG25?=
 =?us-ascii?Q?Ouq3AmQ4LvNT3VCOuAGnfkpF5NL5sZOhr4APT5hpHJKhNU1cX644QPq0G6Hi?=
 =?us-ascii?Q?cCPN+0r8EvaiNBYwuAOWq1H8ziUvYNeHur8znMko45kh0/7uCQlqV870gZJi?=
 =?us-ascii?Q?seHz63II3Ti1IpShayj5pFM+icrD7KvE6T9KRT5zk6JDCKsL2KhGDIYwlDug?=
 =?us-ascii?Q?Gq84HbpvyPJHVdGEhRVdj6YPd0v8IcI7074Jv5Irl0jSjLtsgr/NbXJodw8h?=
 =?us-ascii?Q?bNEbKwpagVxvSzxka7R/Sr0hPgKHTsAoLB+JRVDjI7d0al9/J89dKNfaSgJq?=
 =?us-ascii?Q?oIi+oIqbm3EcZx7mDO4EMCKWW5Mx9qnOYhKshte+yLkSYK4jpaxlrbXx/rl8?=
 =?us-ascii?Q?YdHzKcOzrLeb5yk0GePnLK1MSjEDoo6QStiO3Nrge1nmjTku3u+HZC3mhfDw?=
 =?us-ascii?Q?gabvd+3exNVn781aidA+C5+Irr6A0zkNqQUHIFeQmkJXUNFWTDokD13q0RLk?=
 =?us-ascii?Q?HFM+mec+HNmJhJUzB/WWobuis3frdSE8u7FHTOHWtm9dkhYs9dcXU+h2d6iE?=
 =?us-ascii?Q?6yud9PkjeVMQVIEodMEa+rlymDJx0Ymr8rnyGN7QEfXq0Wy1ITzhLHpt1paE?=
 =?us-ascii?Q?YtBlOV2e25nfYkQPrQJqFB2gto8LJZVwQOPw?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 18:56:55.1545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cecaa19-9502-4a9d-89f8-08ddba63614c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

As a preparation for the following patch that will add support
for shrinking empty matchers, rearrange the code to prevent
forward declaration of functions.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/bwc.c     | 247 +++++++++---------
 1 file changed, 124 insertions(+), 123 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 516634237cb8..15d817cbcd9d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -71,6 +71,130 @@ static void hws_bwc_matcher_init_attr(struct mlx5hws_bwc_matcher *bwc_matcher,
 		first_matcher ? first_matcher->matcher->end_ft_id : 0;
 }
 
+static int
+hws_bwc_matcher_move_all_simple(struct mlx5hws_bwc_matcher *bwc_matcher)
+{
+	bool move_error = false, poll_error = false, drain_error = false;
+	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
+	struct mlx5hws_matcher *matcher = bwc_matcher->matcher;
+	u16 bwc_queues = mlx5hws_bwc_queues(ctx);
+	struct mlx5hws_rule_attr rule_attr;
+	struct mlx5hws_bwc_rule *bwc_rule;
+	struct mlx5hws_send_engine *queue;
+	struct list_head *rules_list;
+	u32 pending_rules;
+	int i, ret = 0;
+
+	mlx5hws_bwc_rule_fill_attr(bwc_matcher, 0, 0, &rule_attr);
+
+	for (i = 0; i < bwc_queues; i++) {
+		if (list_empty(&bwc_matcher->rules[i]))
+			continue;
+
+		pending_rules = 0;
+		rule_attr.queue_id = mlx5hws_bwc_get_queue_id(ctx, i);
+		rules_list = &bwc_matcher->rules[i];
+
+		list_for_each_entry(bwc_rule, rules_list, list_node) {
+			ret = mlx5hws_matcher_resize_rule_move(matcher,
+							       bwc_rule->rule,
+							       &rule_attr);
+			if (unlikely(ret && !move_error)) {
+				mlx5hws_err(ctx,
+					    "Moving BWC rule: move failed (%d), attempting to move rest of the rules\n",
+					    ret);
+				move_error = true;
+			}
+
+			pending_rules++;
+			ret = mlx5hws_bwc_queue_poll(ctx,
+						     rule_attr.queue_id,
+						     &pending_rules,
+						     false);
+			if (unlikely(ret && !poll_error)) {
+				mlx5hws_err(ctx,
+					    "Moving BWC rule: poll failed (%d), attempting to move rest of the rules\n",
+					    ret);
+				poll_error = true;
+			}
+		}
+
+		if (pending_rules) {
+			queue = &ctx->send_queue[rule_attr.queue_id];
+			mlx5hws_send_engine_flush_queue(queue);
+			ret = mlx5hws_bwc_queue_poll(ctx,
+						     rule_attr.queue_id,
+						     &pending_rules,
+						     true);
+			if (unlikely(ret && !drain_error)) {
+				mlx5hws_err(ctx,
+					    "Moving BWC rule: drain failed (%d), attempting to move rest of the rules\n",
+					    ret);
+				drain_error = true;
+			}
+		}
+	}
+
+	if (move_error || poll_error || drain_error)
+		ret = -EINVAL;
+
+	return ret;
+}
+
+static int hws_bwc_matcher_move_all(struct mlx5hws_bwc_matcher *bwc_matcher)
+{
+	if (!bwc_matcher->complex)
+		return hws_bwc_matcher_move_all_simple(bwc_matcher);
+
+	return mlx5hws_bwc_matcher_move_all_complex(bwc_matcher);
+}
+
+static int hws_bwc_matcher_move(struct mlx5hws_bwc_matcher *bwc_matcher)
+{
+	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
+	struct mlx5hws_matcher_attr matcher_attr = {0};
+	struct mlx5hws_matcher *old_matcher;
+	struct mlx5hws_matcher *new_matcher;
+	int ret;
+
+	hws_bwc_matcher_init_attr(bwc_matcher,
+				  bwc_matcher->priority,
+				  bwc_matcher->rx_size.size_log,
+				  bwc_matcher->tx_size.size_log,
+				  &matcher_attr);
+
+	old_matcher = bwc_matcher->matcher;
+	new_matcher = mlx5hws_matcher_create(old_matcher->tbl,
+					     &bwc_matcher->mt, 1,
+					     bwc_matcher->at,
+					     bwc_matcher->num_of_at,
+					     &matcher_attr);
+	if (!new_matcher) {
+		mlx5hws_err(ctx, "Rehash error: matcher creation failed\n");
+		return -ENOMEM;
+	}
+
+	ret = mlx5hws_matcher_resize_set_target(old_matcher, new_matcher);
+	if (ret) {
+		mlx5hws_err(ctx, "Rehash error: failed setting resize target\n");
+		return ret;
+	}
+
+	ret = hws_bwc_matcher_move_all(bwc_matcher);
+	if (ret)
+		mlx5hws_err(ctx, "Rehash error: moving rules failed, attempting to remove the old matcher\n");
+
+	/* Error during rehash can't be rolled back.
+	 * The best option here is to allow the rehash to complete and remove
+	 * the old matcher - can't leave the matcher in the 'in_resize' state.
+	 */
+
+	bwc_matcher->matcher = new_matcher;
+	mlx5hws_matcher_destroy(old_matcher);
+
+	return ret;
+}
+
 int mlx5hws_bwc_matcher_create_simple(struct mlx5hws_bwc_matcher *bwc_matcher,
 				      struct mlx5hws_table *table,
 				      u32 priority,
@@ -636,129 +760,6 @@ hws_bwc_matcher_find_at(struct mlx5hws_bwc_matcher *bwc_matcher,
 	return -1;
 }
 
-static int hws_bwc_matcher_move_all_simple(struct mlx5hws_bwc_matcher *bwc_matcher)
-{
-	bool move_error = false, poll_error = false, drain_error = false;
-	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
-	struct mlx5hws_matcher *matcher = bwc_matcher->matcher;
-	u16 bwc_queues = mlx5hws_bwc_queues(ctx);
-	struct mlx5hws_rule_attr rule_attr;
-	struct mlx5hws_bwc_rule *bwc_rule;
-	struct mlx5hws_send_engine *queue;
-	struct list_head *rules_list;
-	u32 pending_rules;
-	int i, ret = 0;
-
-	mlx5hws_bwc_rule_fill_attr(bwc_matcher, 0, 0, &rule_attr);
-
-	for (i = 0; i < bwc_queues; i++) {
-		if (list_empty(&bwc_matcher->rules[i]))
-			continue;
-
-		pending_rules = 0;
-		rule_attr.queue_id = mlx5hws_bwc_get_queue_id(ctx, i);
-		rules_list = &bwc_matcher->rules[i];
-
-		list_for_each_entry(bwc_rule, rules_list, list_node) {
-			ret = mlx5hws_matcher_resize_rule_move(matcher,
-							       bwc_rule->rule,
-							       &rule_attr);
-			if (unlikely(ret && !move_error)) {
-				mlx5hws_err(ctx,
-					    "Moving BWC rule: move failed (%d), attempting to move rest of the rules\n",
-					    ret);
-				move_error = true;
-			}
-
-			pending_rules++;
-			ret = mlx5hws_bwc_queue_poll(ctx,
-						     rule_attr.queue_id,
-						     &pending_rules,
-						     false);
-			if (unlikely(ret && !poll_error)) {
-				mlx5hws_err(ctx,
-					    "Moving BWC rule: poll failed (%d), attempting to move rest of the rules\n",
-					    ret);
-				poll_error = true;
-			}
-		}
-
-		if (pending_rules) {
-			queue = &ctx->send_queue[rule_attr.queue_id];
-			mlx5hws_send_engine_flush_queue(queue);
-			ret = mlx5hws_bwc_queue_poll(ctx,
-						     rule_attr.queue_id,
-						     &pending_rules,
-						     true);
-			if (unlikely(ret && !drain_error)) {
-				mlx5hws_err(ctx,
-					    "Moving BWC rule: drain failed (%d), attempting to move rest of the rules\n",
-					    ret);
-				drain_error = true;
-			}
-		}
-	}
-
-	if (move_error || poll_error || drain_error)
-		ret = -EINVAL;
-
-	return ret;
-}
-
-static int hws_bwc_matcher_move_all(struct mlx5hws_bwc_matcher *bwc_matcher)
-{
-	if (!bwc_matcher->complex)
-		return hws_bwc_matcher_move_all_simple(bwc_matcher);
-
-	return mlx5hws_bwc_matcher_move_all_complex(bwc_matcher);
-}
-
-static int hws_bwc_matcher_move(struct mlx5hws_bwc_matcher *bwc_matcher)
-{
-	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
-	struct mlx5hws_matcher_attr matcher_attr = {0};
-	struct mlx5hws_matcher *old_matcher;
-	struct mlx5hws_matcher *new_matcher;
-	int ret;
-
-	hws_bwc_matcher_init_attr(bwc_matcher,
-				  bwc_matcher->priority,
-				  bwc_matcher->rx_size.size_log,
-				  bwc_matcher->tx_size.size_log,
-				  &matcher_attr);
-
-	old_matcher = bwc_matcher->matcher;
-	new_matcher = mlx5hws_matcher_create(old_matcher->tbl,
-					     &bwc_matcher->mt, 1,
-					     bwc_matcher->at,
-					     bwc_matcher->num_of_at,
-					     &matcher_attr);
-	if (!new_matcher) {
-		mlx5hws_err(ctx, "Rehash error: matcher creation failed\n");
-		return -ENOMEM;
-	}
-
-	ret = mlx5hws_matcher_resize_set_target(old_matcher, new_matcher);
-	if (ret) {
-		mlx5hws_err(ctx, "Rehash error: failed setting resize target\n");
-		return ret;
-	}
-
-	ret = hws_bwc_matcher_move_all(bwc_matcher);
-	if (ret)
-		mlx5hws_err(ctx, "Rehash error: moving rules failed, attempting to remove the old matcher\n");
-
-	/* Error during rehash can't be rolled back.
-	 * The best option here is to allow the rehash to complete and remove
-	 * the old matcher - can't leave the matcher in the 'in_resize' state.
-	 */
-
-	bwc_matcher->matcher = new_matcher;
-	mlx5hws_matcher_destroy(old_matcher);
-
-	return ret;
-}
-
 static int
 hws_bwc_matcher_rehash_size(struct mlx5hws_bwc_matcher *bwc_matcher)
 {
-- 
2.34.1


