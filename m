Return-Path: <linux-rdma+bounces-12803-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BFBB29509
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Aug 2025 22:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECF82042DA
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Aug 2025 20:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D373B304BAB;
	Sun, 17 Aug 2025 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gp9VwxnK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D760121CA03;
	Sun, 17 Aug 2025 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755462249; cv=fail; b=gw5t7djWNB4QnkaHWNvUXsj5GzgLcUfVxhleZ4ZhH1gF2afGryqQJoZqS68ySv2LPRuHiNWPI8zi9cZ9kqBBsvk8WX3N89cUf7Bv9DIMqXgqF8KLaaofN0vXY6a8jOCFrisMsHrntJCnzq7qCQgfdb2ZKiPzAQkO+6+5kf1m26A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755462249; c=relaxed/simple;
	bh=UsQ3VbiLKNcvsQ0i0T2MmYS9DYktSkx17PLk3xdKn3Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b6nKP0XUx/aOWCwBw/wjDhykPR6RXNCxBFqTLUiM2kTrwmXBydbDpxuWJdgrNZ4FYbaDfzkWfBbmJ8T5zfvrtoRp+Xu/aytrrTyqSHB2Ek19l4WqvUVm5zAIfCnu2ztBZH963x4LVdAKN3dojz3tVe7O+SZvw6N2BNxmVq9go/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gp9VwxnK; arc=fail smtp.client-ip=40.107.100.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdhFVBTS87nR4rUhHTg7SAGsyh/YXu9uYXhNWOxRQ4W63tuNT4YumvklRcid0o0N3IILi12XKfphDG5TMJyLMWsZwQnE/WBoy4YoS+eZjapwxV+nkFeVOB625GiHkOn4sVVjMBtb0Ywawu6clthlBRrk8QXpI+Txvv2hrNW9HbNVu9oRmy6PrP4jDCWyGNa0q15ZVHm88ymYqj/wnaL1e85Rx2z4jsoulbnYAuNK9Cgrc1fZkrZvhlnJPucwsT/Efyojf4SdroIzEBH0UisGNFnKy7LpD92RRv3ZUB4bZpS8UKw35L6j7Lgi+2q4sTQMwq3ZjCVpDHOUmspd4iTnSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/JzRVciFpkE7IHm+XzL7tsdhSTvJEUgzB/kqj2EDqY=;
 b=HvDSTKT7SyjGqhZV4gV8C0UpBAiecHw1W6mOQJ0faCeI9GhPbfBvRaYOu7oaqZy1gyg9EV3GuVGk5DnPanjQHTSHQKFehgEFVS7Jn6yIc0f9IOIkp8FNqkHOZ6Z3FeQQeTp85dL+SCiCMlo4UEMHhgVAjBGDIV4BwS4DT/vCUxTbUHt34l5A4zxOYxUrffajGbNw6l4T3sCpIC5oxj0Xld6+ifthRN6AVVJDlESQs1OeXxsnkoeQHdutX8Fu/jT+3uqfJvMjLExW9RwQ6GA6YzPrTF6BnLR/gpIIpW26dbcomUh02z2obYtbx+z4s2bGxt6uvQYe5o9Nl6BkB2nTJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/JzRVciFpkE7IHm+XzL7tsdhSTvJEUgzB/kqj2EDqY=;
 b=Gp9VwxnKjWTwAY37ecVj5JgxmfPN4lCwcgvMT+KUgrE2CP8cVhft/woM1Idymwtmb+I6fDR/b9HnSqPoBW43xfDm03U3mUISvDX6H7dHbdzbCJZ6n8n6SWMHd7EtHF4JnfY/fS+uAGcKi/sGWaCERe5oshz1+QF/OHYyziRnVSCwoiP7gS31cZdFX42iNrqg3AapjHnGdGZJ5YRtpRJm4hKGfI5W5a7FoaNT/Eyuhrsk2VYutalxxNNkJqaBiGCfclX46p5v00wIcP2NmzjVUrBEwMwBWuLctGzjuipQLD2ZHduLHSn8WmtPMTmTi6ihkloxmXbiDYborz/6dvDiKw==
Received: from CH0PR03CA0428.namprd03.prod.outlook.com (2603:10b6:610:10e::23)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Sun, 17 Aug
 2025 20:24:03 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::60) by CH0PR03CA0428.outlook.office365.com
 (2603:10b6:610:10e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.19 via Frontend Transport; Sun,
 17 Aug 2025 20:24:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Sun, 17 Aug 2025 20:24:02 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 17 Aug
 2025 13:23:59 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 17 Aug 2025 13:23:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 17 Aug 2025 13:23:55 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Alex Vesker <valex@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Hamdan Agbariya
	<hamdani@nvidia.com>
Subject: [PATCH net 6/7] net/mlx5: HWS, Fix table creation UID
Date: Sun, 17 Aug 2025 23:23:22 +0300
Message-ID: <20250817202323.308604-7-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250817202323.308604-1-mbloch@nvidia.com>
References: <20250817202323.308604-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: f22d802f-fd0f-4b23-776b-08ddddcc01c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iT9pqA0Qq4VFL6FsLOGed92Xr6pH8IJqnLB4tXJb4kyvT6sbyeP16bTd9Qu3?=
 =?us-ascii?Q?w0PZluVdIHFR1uf54dB/8FWgjgK9m1XkOZMeGN11YXJjpumZa0B87M1q2Yp7?=
 =?us-ascii?Q?8Hyf/rvWy5ukaHjMHkR8L9w1rn646fwuvThfLGX3uB5aLuSLewKDut+pvdpT?=
 =?us-ascii?Q?CQ++PyZYzs/iClN86uWH0Y3uAsGX0JBmT+m0rEO/z9si5MStosyitxbyBdQe?=
 =?us-ascii?Q?iBzBHBwoISnRf1A+JHnbhP4PGA9Yy5TvJ/FP+kmSLCMNgWdopQrEtvyEshF5?=
 =?us-ascii?Q?fZ343cKF/+xYewCkc8LuP5h/u9D82mSCzJGQOL8Zkh37R2IQq1F+yCeS+AUq?=
 =?us-ascii?Q?q1J50XU43rlm+WaOtjL+whM/Mh/wF1wYR5GAdsdGtYX5yT/tZSdkbT4s/ivu?=
 =?us-ascii?Q?+abEEbJOdxH8YCUP8YMFZKiiPK+8lL3q+JH9M1SYBhg+QIDPzeZWU59AGqbw?=
 =?us-ascii?Q?EQUZJ2NYajNKCi+0Dzms2v7aHiaPc+ip2XeRRc8c4uYAr9QCkepdBOI9IteZ?=
 =?us-ascii?Q?XfnAFxiaS4h2eQIFa0vC11IYL+Cn83EHiFSfiY7vuW2K41ll6qFju7NZCiPP?=
 =?us-ascii?Q?UFteeyUI0ce+R8eWYughYNrMtQAv4N2jTrARzPj/GKrc/xu+VrhqTO+AXdlB?=
 =?us-ascii?Q?BTHHFTGRXrcCtG7gdpH6DFeisxqTO6ZV8r73lfh6D4DmKxDItVJwGs6PR2TV?=
 =?us-ascii?Q?fLSYmil2toaPYwVfgQcB2TB7jRjDXzI8OeVACGipf0GAcugcX08BJdWlv59J?=
 =?us-ascii?Q?mcutvBynSMpnmZylNExeY0chi6RFdc0KQ/ql4PvBRYlSXV2D4Hvs4bieZLR+?=
 =?us-ascii?Q?RU258MZJYUCXNjZYnMoXIht867DCmX9z0ohAyrXDYCAKcQJ8xNzb9pFixNV5?=
 =?us-ascii?Q?H94/a/6m4JHjem0Gdo++U/j8SLOfOgcY99MM9MMvWrotNNgpIV9AGkep8dXg?=
 =?us-ascii?Q?KqiNC6jYTCvf62ac3E10schrj4lVDX767ph+8END/JSSOZrkyorSXWL9Qn8D?=
 =?us-ascii?Q?2wnbDKAN7fZ18AP2EHKkS13Plhe1zeZeecT4UlKw69QR8jHjVdJOTGEhbZwd?=
 =?us-ascii?Q?5iuRG+kkWQNmHvgcN/YF6//dJ7sIvgoJnh4I/1bqvdZKLS3aXVsj0I1f+may?=
 =?us-ascii?Q?vYfB+LhTRXH7jICkT6TBTkQsEEzs9D+MWHxyZBQMPmELQn8+qvOiPUAjuxzo?=
 =?us-ascii?Q?PWDMFn1ZdcEGmQxYPdz8sBN7Jgp9v3gh4TutrGSUjhbPA7apES8D6xUa33yl?=
 =?us-ascii?Q?SxoJg/SDvLU7cNbZuY7YN+ZM+tpToeeSMpnkMFeV+CT7Z4oJ8JBFT6ox2l8l?=
 =?us-ascii?Q?waVBLGwdHNvKsuIciOqVMi8kg/ZQjuhoJgSxx0cdbitIm37NWuppkN9P78kC?=
 =?us-ascii?Q?PAlgDDTWsYOrDf9345UbdYjHpAqxNFPnXn52DGAmyZThYyrqoWTIZB4kyfFs?=
 =?us-ascii?Q?PW/iE/+2HzC2rM8Vv89Ew5EHqnPJknIOzkTijhekDknPG6nLMQhgCTxi5Z/4?=
 =?us-ascii?Q?eaIaCaItUVDFUowwY9Ra8jm+cJOUYnsexJcz?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2025 20:24:02.7409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f22d802f-fd0f-4b23-776b-08ddddcc01c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106

From: Alex Vesker <valex@nvidia.com>

During table creation, caller passes a UID using ft_attr. The UID
value was ignored, which leads to problems when the caller sets the
UID to a non-zero value, such as SHARED_RESOURCE_UID (0xffff) - the
internal FT objects will be created with UID=0.

Fixes: 0869701cba3d ("net/mlx5: HWS, added FW commands handling")
Signed-off-by: Alex Vesker <valex@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/steering/hws/cmd.c  |  1 +
 .../ethernet/mellanox/mlx5/core/steering/hws/cmd.h  |  1 +
 .../mellanox/mlx5/core/steering/hws/fs_hws.c        |  1 +
 .../mellanox/mlx5/core/steering/hws/matcher.c       |  5 ++++-
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h       |  1 +
 .../mellanox/mlx5/core/steering/hws/table.c         | 13 ++++++++++---
 .../mellanox/mlx5/core/steering/hws/table.h         |  3 ++-
 7 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
index 9c83753e4592..0bdcab2e5cf3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
@@ -55,6 +55,7 @@ int mlx5hws_cmd_flow_table_create(struct mlx5_core_dev *mdev,
 
 	MLX5_SET(create_flow_table_in, in, opcode, MLX5_CMD_OP_CREATE_FLOW_TABLE);
 	MLX5_SET(create_flow_table_in, in, table_type, ft_attr->type);
+	MLX5_SET(create_flow_table_in, in, uid, ft_attr->uid);
 
 	ft_ctx = MLX5_ADDR_OF(create_flow_table_in, in, flow_table_context);
 	MLX5_SET(flow_table_context, ft_ctx, level, ft_attr->level);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h
index fa6bff210266..122ccc671628 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h
@@ -36,6 +36,7 @@ struct mlx5hws_cmd_set_fte_attr {
 struct mlx5hws_cmd_ft_create_attr {
 	u8 type;
 	u8 level;
+	u16 uid;
 	bool rtc_valid;
 	bool decap_en;
 	bool reformat_en;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index 57592b92e24b..131e74b2b774 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -267,6 +267,7 @@ static int mlx5_cmd_hws_create_flow_table(struct mlx5_flow_root_namespace *ns,
 
 	tbl_attr.type = MLX5HWS_TABLE_TYPE_FDB;
 	tbl_attr.level = ft_attr->level;
+	tbl_attr.uid = ft_attr->uid;
 	tbl = mlx5hws_table_create(ctx, &tbl_attr);
 	if (!tbl) {
 		mlx5_core_err(ns->dev, "Failed creating hws flow_table\n");
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
index f3ea09caba2b..32f87fdf3213 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
@@ -85,6 +85,7 @@ static int hws_matcher_create_end_ft_isolated(struct mlx5hws_matcher *matcher)
 
 	ret = mlx5hws_table_create_default_ft(tbl->ctx->mdev,
 					      tbl,
+					      0,
 					      &matcher->end_ft_id);
 	if (ret) {
 		mlx5hws_err(tbl->ctx, "Isolated matcher: failed to create end flow table\n");
@@ -112,7 +113,9 @@ static int hws_matcher_create_end_ft(struct mlx5hws_matcher *matcher)
 	if (mlx5hws_matcher_is_isolated(matcher))
 		ret = hws_matcher_create_end_ft_isolated(matcher);
 	else
-		ret = mlx5hws_table_create_default_ft(tbl->ctx->mdev, tbl,
+		ret = mlx5hws_table_create_default_ft(tbl->ctx->mdev,
+						      tbl,
+						      0,
 						      &matcher->end_ft_id);
 
 	if (ret) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
index 59c14745ed0c..2498ceff2060 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
@@ -75,6 +75,7 @@ struct mlx5hws_context_attr {
 struct mlx5hws_table_attr {
 	enum mlx5hws_table_type type;
 	u32 level;
+	u16 uid;
 };
 
 enum mlx5hws_matcher_flow_src {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c
index 568f691733f3..6113383ae47b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c
@@ -9,6 +9,7 @@ u32 mlx5hws_table_get_id(struct mlx5hws_table *tbl)
 }
 
 static void hws_table_init_next_ft_attr(struct mlx5hws_table *tbl,
+					u16 uid,
 					struct mlx5hws_cmd_ft_create_attr *ft_attr)
 {
 	ft_attr->type = tbl->fw_ft_type;
@@ -16,7 +17,9 @@ static void hws_table_init_next_ft_attr(struct mlx5hws_table *tbl,
 		ft_attr->level = tbl->ctx->caps->fdb_ft.max_level - 1;
 	else
 		ft_attr->level = tbl->ctx->caps->nic_ft.max_level - 1;
+
 	ft_attr->rtc_valid = true;
+	ft_attr->uid = uid;
 }
 
 static void hws_table_set_cap_attr(struct mlx5hws_table *tbl,
@@ -119,12 +122,12 @@ static int hws_table_connect_to_default_miss_tbl(struct mlx5hws_table *tbl, u32
 
 int mlx5hws_table_create_default_ft(struct mlx5_core_dev *mdev,
 				    struct mlx5hws_table *tbl,
-				    u32 *ft_id)
+				    u16 uid, u32 *ft_id)
 {
 	struct mlx5hws_cmd_ft_create_attr ft_attr = {0};
 	int ret;
 
-	hws_table_init_next_ft_attr(tbl, &ft_attr);
+	hws_table_init_next_ft_attr(tbl, uid, &ft_attr);
 	hws_table_set_cap_attr(tbl, &ft_attr);
 
 	ret = mlx5hws_cmd_flow_table_create(mdev, &ft_attr, ft_id);
@@ -189,7 +192,10 @@ static int hws_table_init(struct mlx5hws_table *tbl)
 	}
 
 	mutex_lock(&ctx->ctrl_lock);
-	ret = mlx5hws_table_create_default_ft(tbl->ctx->mdev, tbl, &tbl->ft_id);
+	ret = mlx5hws_table_create_default_ft(tbl->ctx->mdev,
+					      tbl,
+					      tbl->uid,
+					      &tbl->ft_id);
 	if (ret) {
 		mlx5hws_err(tbl->ctx, "Failed to create flow table object\n");
 		mutex_unlock(&ctx->ctrl_lock);
@@ -239,6 +245,7 @@ struct mlx5hws_table *mlx5hws_table_create(struct mlx5hws_context *ctx,
 	tbl->ctx = ctx;
 	tbl->type = attr->type;
 	tbl->level = attr->level;
+	tbl->uid = attr->uid;
 
 	ret = hws_table_init(tbl);
 	if (ret) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.h
index 0400cce0c317..1246f9bd8422 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.h
@@ -18,6 +18,7 @@ struct mlx5hws_table {
 	enum mlx5hws_table_type type;
 	u32 fw_ft_type;
 	u32 level;
+	u16 uid;
 	struct list_head matchers_list;
 	struct list_head tbl_list_node;
 	struct mlx5hws_default_miss default_miss;
@@ -47,7 +48,7 @@ u32 mlx5hws_table_get_res_fw_ft_type(enum mlx5hws_table_type tbl_type,
 
 int mlx5hws_table_create_default_ft(struct mlx5_core_dev *mdev,
 				    struct mlx5hws_table *tbl,
-				    u32 *ft_id);
+				    u16 uid, u32 *ft_id);
 
 void mlx5hws_table_destroy_default_ft(struct mlx5hws_table *tbl,
 				      u32 ft_id);
-- 
2.34.1


