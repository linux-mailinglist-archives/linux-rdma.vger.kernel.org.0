Return-Path: <linux-rdma+bounces-10276-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB338AB2A93
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 21:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A554916DA06
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 19:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71725264F9A;
	Sun, 11 May 2025 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qoXCIe/5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED332609E4;
	Sun, 11 May 2025 19:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746992380; cv=fail; b=m3PfD9vEE8gFJn/Zy2CNEPrxrUX6X0LekhE9/hyenVeXRSY1ptOrkLYRSrmzGtkkOlg1DEZMnvKFS/cA1nDanGhwQiqa67zVUv3zt4vEctugyjlsj9Czt//Ae2CK4V+fIvXK8Mwm33xmkL16swPuhECue7p4zyG9jDgs76J0jGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746992380; c=relaxed/simple;
	bh=Dp8fP/XxSDyKEPMIR3P0g+OwgF6rBvj8YULcc5wkm04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1fb3bcLT93J0MpXGeMjkD+uEOw2venOQ+smj78bT/EdTemJikFK7P6jTTdcwCciIFw09R/dwZP1lZBue1x7nLbbiwr25Pt23wdlzvhanwopXapPzO9QhFdcWHkrJJe6ICghtmOpDUxl9LV5cxMEs+B+LS/yCYYIZVKKYd+yqNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qoXCIe/5; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hB71bVoUV5kWbOgDAeY+jZ30/cl+CDOkgAj4c5vGBcFddR/aW7RrDL4KARDYXDYuNp9SLApi6/rxBA4PbjmsWWW9kUk4ZBlTB+xD+08HlOrujozCCHp39utKr4qItcBN+4mJWOrwCZxC9Hmt1jEkVI+Xw0PaUckzKcZZ92ry0pwXMZNEUata19xZdUfKJAEsOieXZ6igzUe661ih8LDn/f0jkL9/4+jELVSxuOWdAT96pS7e9ynAqqXQpDSv+z8FnehSj3/S3ruGgYYt0rmnVZ0uq8COh5YtcloNtgcw0CSBpqzC+egDZsGeJdqsXgxu/bmUB3iAzJ8p/ecI4b8G+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yH0Uotgk+F6+BcogpaY+A6OVhqR6nqBHxf0FT+IwxE=;
 b=HY7a0xjLvTACNQ9f9dgtFUvRDrE9sDNgn815EcDHW3et/7VZQZheF0X491uMjOigYLAct6ScQFLlJKX+tKXPfV9doT+Ccv7M/DD7oUuf9/ZXbuTTBtgPeh5uHhCGMhiN0rsj/jzQGV7pXBK9sJcfMaMDMi6z9z1DuWhHco8iJyI6YeiwdYRnOe7qCjA07JMJnO7oKl3ylwzmwWhxDsCf/Y4ejj/Ymi14SUsKWE6H3iURp/8cmE1zNZcEmxY2FJmUkTHMMBv+hHMk6gfCjzyPxmmK2nZXtD5yPlmRSf/E2mfRGPZIcwcl3dp/2nPcbiZL4RcAhJUpT2t2sWkhuwRIUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yH0Uotgk+F6+BcogpaY+A6OVhqR6nqBHxf0FT+IwxE=;
 b=qoXCIe/5EfoqVfhPUliFvLY4lJZpeBM6m2g58Ouxnnj6oERLKEu27lc/Drn/33jUGqOuxmchSEENV9GUAFA8gkgLYYxdVnHTtte4Ob37uMI7W7RkzLnkz4pGmG4U+qpuhRr52CxqswmKqEbIZ+CRzpDYzvzec7q0NDQxjm2E/MMEa076Ox32kg8tp1l1iR//V48FUrLTgwbjX74H47EMxpV1s8gIpXEe3+4h+S8V8sStCK9/F3lyLW/DLXxFelLUP4JEVaKqV5eNSrrBAXwm8hs7a6OIuhRRk841qGh3N/Jc3fbansHg/KtIjbLNubsEDX2cYBBvPw8z+eN8oeVbog==
Received: from SJ0PR05CA0091.namprd05.prod.outlook.com (2603:10b6:a03:334::6)
 by SN7PR12MB7833.namprd12.prod.outlook.com (2603:10b6:806:344::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Sun, 11 May
 2025 19:39:29 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::bb) by SJ0PR05CA0091.outlook.office365.com
 (2603:10b6:a03:334::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.23 via Frontend Transport; Sun,
 11 May 2025 19:39:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Sun, 11 May 2025 19:39:29 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 11 May
 2025 12:39:18 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 11 May
 2025 12:39:18 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 11
 May 2025 12:39:14 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next 04/10] net/mlx5: HWS, introduce isolated matchers
Date: Sun, 11 May 2025 22:38:04 +0300
Message-ID: <1746992290-568936-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1746992290-568936-1-git-send-email-tariqt@nvidia.com>
References: <1746992290-568936-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|SN7PR12MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b94711b-15eb-4511-8918-08dd90c38be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6KDdh3CNq2UO+oxUIYi9XQjkBHwqFuDxN8fpvUXXFQKvlbfLbvs4ciaXVL7j?=
 =?us-ascii?Q?KhXBq82PybzJgBnXp8DwVUHokvT1ly6qjXrV6MSMsWi+0ddQ8bgOboyFHaq9?=
 =?us-ascii?Q?l/jeJ6J5kBz0VWSsx0LXthKDCa3uDsDhnfh5N42rmD8tV3McP19D6k0goOjc?=
 =?us-ascii?Q?7num5RVf+/S3Nlm51O8OwhRxY4V+Qs47khDLXhcT+zfOpSoSe1abb4Hdu8i/?=
 =?us-ascii?Q?eGW9CCNtWXQXJzmjSSMNZnJ9SPkxScSfz+yuH+Rr3arfwchKmtu8H0PAB9wm?=
 =?us-ascii?Q?EsSCzB7pvQ4lXazeFa+y8Mc4HEj/PgbclbBOd1Nm0s0LdLr2mP1JLHPsInKb?=
 =?us-ascii?Q?/gNGCxYBCM9mugCAS9Z7uCQGrWFHot8tKhZUe5Gv/1K+ohaF1v9w6y76/7NM?=
 =?us-ascii?Q?QewSSBHzSlFg5kQgZSUf6O4q8UqqUlSpw5g2rTBlt0o2mDMbKW3QVCFTlcZz?=
 =?us-ascii?Q?CcP+8f5+Qtoho8iWM2CwJ9gJi9q2NmD/j0UHfyt0Dp5x/WpxshIUeFAY2481?=
 =?us-ascii?Q?yoFpjto1qEdBQy31RB8mNXN8Z3A8MpmE5MgrcDv3B7QHIpO708CLDVqFo5gA?=
 =?us-ascii?Q?fZUqvwkHTYdYLqIaKPFUrCDi+uheNLbS7g9IpZD2KwP6mwM3x/Z9tytt2n4C?=
 =?us-ascii?Q?SNfA9yK4It2unL+Jvk1WW+1+B5izyaY5oNYnd2lteLmlUub4WMApoKNZxZO7?=
 =?us-ascii?Q?bflcn088FEjOt0vGQftT7ULyM1r6Yo6qMdSxkDeai5L8PJyC2U/DAUQMQRV7?=
 =?us-ascii?Q?MvLLQsLb54VEzuJIgBkSFYMsfliyywVE00Fmcgx8YFC4MAXhy05H4HK1WLMs?=
 =?us-ascii?Q?XRqemiSCy/q85jtFUZ+dLjvrF+fziHW6ElxDS1298Ho9W9AeQ8HapoftgKI1?=
 =?us-ascii?Q?Dsk9s8PlwBvIyzCfkfGgp4Q5BME7IaEDEzQUlSh0DM3+miB8r9nV/IVDpzAZ?=
 =?us-ascii?Q?3vfGOQ/AoLd1A0RcxvQO/yf8ReVgwbEgx5R3+WKSwTRqZ0QVO+gTEJj92pco?=
 =?us-ascii?Q?hd7cYEvFjIYZAi6YLuOaM3JBwUcWJyEghAEHN1+hkpnz7949pIsHz+wvu4Fr?=
 =?us-ascii?Q?PwTpfXe3SL4n5q1jak8Fjdw+IPfncrpR0FseA0/9O/OTKS1jsGA0in9+7DwR?=
 =?us-ascii?Q?4ExGeigzbuWL9mCX/UG4Llr3KD+wzkfh/pyXHtKi83xyJpTNYrVLx/RiNS/1?=
 =?us-ascii?Q?hndj9KO+VKka8pqB/9ZkWMnI9q2LLM7UD8hampJTS4jpx+KAYiSudtruOYMR?=
 =?us-ascii?Q?tR9s1AaHxIRDC39g738KthnrxPsFI8g7b0xs4mtFdosS4s1/Nq2USnsYblg4?=
 =?us-ascii?Q?SSyR95sKcHOtA7bpUDtHpMWb+KVrqyzJL6hojyJYk1PVJmydzWQCM6nbiOec?=
 =?us-ascii?Q?nMklueh7opDG5fd5Cx2ZM7WElFsuwLDbiQlB364vYkfy+PtqCLWDJyn/Kgtp?=
 =?us-ascii?Q?T+RlNfz25z9fkTPGzaiwDHe9gWvlhCxk+RbKlup7OKfE4BBmf/YOgMYZ6QqS?=
 =?us-ascii?Q?rcqRklYILzKW+oHYorJj+bE2+UrSFeyIYZ3P?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2025 19:39:29.5000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b94711b-15eb-4511-8918-08dd90c38be1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7833

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

In preparation for complex matcher support, introduce the isolated
matcher.

Isolated matcher is a matcher that has its own isolated table.
It is used as the second half of the complex matcher: when the rule
is split into two parts (complex rule), then matching on the first
part will send the packet to the isolated matcher that will try to
match on the second part. In case of miss, the packet goes back to
the matcher's end flow table.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/matcher.c | 278 +++++++++++++++++-
 .../mellanox/mlx5/core/steering/hws/matcher.h |   9 +
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h |   2 +
 3 files changed, 288 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
index 5b0c1623499b..ce28ee1c0e41 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
@@ -23,19 +23,199 @@ static void hws_matcher_destroy_end_ft(struct mlx5hws_matcher *matcher)
 	mlx5hws_table_destroy_default_ft(matcher->tbl, matcher->end_ft_id);
 }
 
+int mlx5hws_matcher_update_end_ft_isolated(struct mlx5hws_table *tbl,
+					   u32 miss_ft_id)
+{
+	struct mlx5hws_matcher *tmp_matcher;
+
+	if (list_empty(&tbl->matchers_list))
+		return -EINVAL;
+
+	/* Update isolated_matcher_end_ft_id attribute for all
+	 * the matchers in isolated table.
+	 */
+	list_for_each_entry(tmp_matcher, &tbl->matchers_list, list_node)
+		tmp_matcher->attr.isolated_matcher_end_ft_id = miss_ft_id;
+
+	tmp_matcher = list_last_entry(&tbl->matchers_list,
+				      struct mlx5hws_matcher,
+				      list_node);
+
+	return mlx5hws_table_ft_set_next_ft(tbl->ctx,
+					    tmp_matcher->end_ft_id,
+					    tbl->fw_ft_type,
+					    miss_ft_id);
+}
+
+static int hws_matcher_connect_end_ft_isolated(struct mlx5hws_matcher *matcher)
+{
+	struct mlx5hws_table *tbl = matcher->tbl;
+	u32 end_ft_id;
+	int ret;
+
+	/* Reset end_ft next RTCs */
+	ret = mlx5hws_table_ft_set_next_rtc(tbl->ctx,
+					    matcher->end_ft_id,
+					    matcher->tbl->fw_ft_type,
+					    0, 0);
+	if (ret) {
+		mlx5hws_err(tbl->ctx, "Isolated matcher: failed to reset FT's next RTCs\n");
+		return ret;
+	}
+
+	/* Connect isolated matcher's end_ft to the complex matcher's end FT */
+	end_ft_id = matcher->attr.isolated_matcher_end_ft_id;
+	ret = mlx5hws_table_ft_set_next_ft(tbl->ctx,
+					   matcher->end_ft_id,
+					   matcher->tbl->fw_ft_type,
+					   end_ft_id);
+
+	if (ret) {
+		mlx5hws_err(tbl->ctx, "Isolated matcher: failed to set FT's miss_ft_id\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int hws_matcher_create_end_ft_isolated(struct mlx5hws_matcher *matcher)
+{
+	struct mlx5hws_table *tbl = matcher->tbl;
+	int ret;
+
+	ret = mlx5hws_table_create_default_ft(tbl->ctx->mdev,
+					      tbl,
+					      &matcher->end_ft_id);
+	if (ret) {
+		mlx5hws_err(tbl->ctx, "Isolated matcher: failed to create end flow table\n");
+		return ret;
+	}
+
+	ret = hws_matcher_connect_end_ft_isolated(matcher);
+	if (ret) {
+		mlx5hws_err(tbl->ctx, "Isolated matcher: failed to connect end FT\n");
+		goto destroy_default_ft;
+	}
+
+	return 0;
+
+destroy_default_ft:
+	mlx5hws_table_destroy_default_ft(tbl, matcher->end_ft_id);
+	return ret;
+}
+
 static int hws_matcher_create_end_ft(struct mlx5hws_matcher *matcher)
 {
 	struct mlx5hws_table *tbl = matcher->tbl;
 	int ret;
 
-	ret = mlx5hws_table_create_default_ft(tbl->ctx->mdev, tbl, &matcher->end_ft_id);
+	if (mlx5hws_matcher_is_isolated(matcher))
+		ret = hws_matcher_create_end_ft_isolated(matcher);
+	else
+		ret = mlx5hws_table_create_default_ft(tbl->ctx->mdev, tbl,
+						      &matcher->end_ft_id);
+
 	if (ret) {
 		mlx5hws_err(tbl->ctx, "Failed to create matcher end flow table\n");
 		return ret;
 	}
+
+	return 0;
+}
+
+static int hws_matcher_connect_isolated_first(struct mlx5hws_matcher *matcher)
+{
+	struct mlx5hws_table *tbl = matcher->tbl;
+	struct mlx5hws_context *ctx = tbl->ctx;
+	int ret;
+
+	/* Isolated matcher's end_ft is already pointing to the end_ft
+	 * of the complex matcher - it was set at creation of end_ft,
+	 * so no need to connect it.
+	 * We still need to connect the isolated table's start FT to
+	 * this matcher's RTC.
+	 */
+	ret = mlx5hws_table_ft_set_next_rtc(ctx,
+					    tbl->ft_id,
+					    tbl->fw_ft_type,
+					    matcher->match_ste.rtc_0_id,
+					    matcher->match_ste.rtc_1_id);
+	if (ret) {
+		mlx5hws_err(ctx, "Isolated matcher: failed to connect start FT to match RTC\n");
+		return ret;
+	}
+
+	/* Reset table's FT default miss (drop refcount) */
+	ret = mlx5hws_table_ft_set_default_next_ft(tbl, tbl->ft_id);
+	if (ret) {
+		mlx5hws_err(ctx, "Isolated matcher: failed to reset table ft default miss\n");
+		return ret;
+	}
+
+	list_add(&matcher->list_node, &tbl->matchers_list);
+
+	return ret;
+}
+
+static int hws_matcher_connect_isolated_last(struct mlx5hws_matcher *matcher)
+{
+	struct mlx5hws_table *tbl = matcher->tbl;
+	struct mlx5hws_context *ctx = tbl->ctx;
+	struct mlx5hws_matcher *last;
+	int ret;
+
+	last = list_last_entry(&tbl->matchers_list,
+			       struct mlx5hws_matcher,
+			       list_node);
+
+	/* New matcher's end_ft is already pointing to the end_ft of
+	 * the complex matcher.
+	 * Connect previous matcher's end_ft to this new matcher RTC.
+	 */
+	ret = mlx5hws_table_ft_set_next_rtc(ctx,
+					    last->end_ft_id,
+					    tbl->fw_ft_type,
+					    matcher->match_ste.rtc_0_id,
+					    matcher->match_ste.rtc_1_id);
+	if (ret) {
+		mlx5hws_err(ctx,
+			    "Isolated matcher: failed to connect matcher end_ft to new match RTC\n");
+		return ret;
+	}
+
+	/* Reset prev matcher FT default miss (drop refcount) */
+	ret = mlx5hws_table_ft_set_default_next_ft(tbl, last->end_ft_id);
+	if (ret) {
+		mlx5hws_err(ctx, "Isolated matcher: failed to reset matcher ft default miss\n");
+		return ret;
+	}
+
+	/* Insert after the last matcher */
+	list_add(&matcher->list_node, &last->list_node);
+
 	return 0;
 }
 
+static int hws_matcher_connect_isolated(struct mlx5hws_matcher *matcher)
+{
+	/* Isolated matcher is expected to be the only one in its table.
+	 * However, it can have a collision matcher, and it can go through
+	 * rehash process, in which case we will temporary have both old and
+	 * new matchers in the isolated table.
+	 * Check if this is the first matcher in the isolated table.
+	 */
+	if (list_empty(&matcher->tbl->matchers_list))
+		return hws_matcher_connect_isolated_first(matcher);
+
+	/* If this wasn't the first matcher, then we have 3 possible cases:
+	 *  - this is a collision matcher for the first matcher
+	 *  - this is a new rehash dest matcher
+	 *  - this is a collision matcher for the new rehash dest matcher
+	 * The logic to add new matcher is the same for all these cases.
+	 */
+	return hws_matcher_connect_isolated_last(matcher);
+}
+
 static int hws_matcher_connect(struct mlx5hws_matcher *matcher)
 {
 	struct mlx5hws_table *tbl = matcher->tbl;
@@ -45,6 +225,9 @@ static int hws_matcher_connect(struct mlx5hws_matcher *matcher)
 	struct mlx5hws_matcher *tmp_matcher;
 	int ret;
 
+	if (mlx5hws_matcher_is_isolated(matcher))
+		return hws_matcher_connect_isolated(matcher);
+
 	/* Find location in matcher list */
 	if (list_empty(&tbl->matchers_list)) {
 		list_add(&matcher->list_node, &tbl->matchers_list);
@@ -121,6 +304,92 @@ static int hws_matcher_connect(struct mlx5hws_matcher *matcher)
 	return ret;
 }
 
+static int hws_matcher_disconnect_isolated(struct mlx5hws_matcher *matcher)
+{
+	struct mlx5hws_matcher *first, *last, *prev, *next;
+	struct mlx5hws_table *tbl = matcher->tbl;
+	struct mlx5hws_context *ctx = tbl->ctx;
+	u32 end_ft_id;
+	int ret;
+
+	first = list_first_entry(&tbl->matchers_list,
+				 struct mlx5hws_matcher,
+				 list_node);
+	last = list_last_entry(&tbl->matchers_list,
+			       struct mlx5hws_matcher,
+			       list_node);
+	prev = list_prev_entry(matcher, list_node);
+	next = list_next_entry(matcher, list_node);
+
+	list_del_init(&matcher->list_node);
+
+	if (first == last) {
+		/* This was the only matcher in the list.
+		 * Reset isolated table FT next RTCs and connect it
+		 * to the whole complex matcher end FT instead.
+		 */
+		ret = mlx5hws_table_ft_set_next_rtc(ctx,
+						    tbl->ft_id,
+						    tbl->fw_ft_type,
+						    0, 0);
+		if (ret) {
+			mlx5hws_err(tbl->ctx, "Isolated matcher: failed to reset FT's next RTCs\n");
+			return ret;
+		}
+
+		end_ft_id = matcher->attr.isolated_matcher_end_ft_id;
+		ret = mlx5hws_table_ft_set_next_ft(tbl->ctx,
+						   tbl->ft_id,
+						   tbl->fw_ft_type,
+						   end_ft_id);
+		if (ret) {
+			mlx5hws_err(tbl->ctx, "Isolated matcher: failed to set FT's miss_ft_id\n");
+			return ret;
+		}
+
+		return 0;
+	}
+
+	/* At this point we know that there are more matchers in the list */
+
+	if (matcher == first) {
+		/* We've disconnected the first matcher.
+		 * Now update isolated table default FT.
+		 */
+		if (!next)
+			return -EINVAL;
+		return mlx5hws_table_ft_set_next_rtc(ctx,
+						     tbl->ft_id,
+						     tbl->fw_ft_type,
+						     next->match_ste.rtc_0_id,
+						     next->match_ste.rtc_1_id);
+	}
+
+	if (matcher == last) {
+		/* If we've disconnected the last matcher - update prev
+		 * matcher's end_ft to point to the complex matcher end_ft.
+		 */
+		if (!prev)
+			return -EINVAL;
+		return hws_matcher_connect_end_ft_isolated(prev);
+	}
+
+	/* This wasn't the first or the last matcher, which means that it has
+	 * both prev and next matchers. Note that this only happens if we're
+	 * disconnecting collision matcher of the old matcher during rehash.
+	 */
+	if (!prev || !next ||
+	    !(matcher->flags & MLX5HWS_MATCHER_FLAGS_COLLISION))
+		return -EINVAL;
+
+	/* Update prev end FT to point to next match RTC */
+	return mlx5hws_table_ft_set_next_rtc(ctx,
+					     prev->end_ft_id,
+					     tbl->fw_ft_type,
+					     next->match_ste.rtc_0_id,
+					     next->match_ste.rtc_1_id);
+}
+
 static int hws_matcher_disconnect(struct mlx5hws_matcher *matcher)
 {
 	struct mlx5hws_matcher *next = NULL, *prev = NULL;
@@ -128,6 +397,9 @@ static int hws_matcher_disconnect(struct mlx5hws_matcher *matcher)
 	u32 prev_ft_id = tbl->ft_id;
 	int ret;
 
+	if (mlx5hws_matcher_is_isolated(matcher))
+		return hws_matcher_disconnect_isolated(matcher);
+
 	if (!list_is_first(&matcher->list_node, &tbl->matchers_list)) {
 		prev = list_prev_entry(matcher, list_node);
 		prev_ft_id = prev->end_ft_id;
@@ -531,6 +803,8 @@ hws_matcher_process_attr(struct mlx5hws_cmd_query_caps *caps,
 		attr->table.sz_col_log = hws_matcher_rules_to_tbl_depth(attr->rule.num_log);
 
 	matcher->flags |= attr->resizable ? MLX5HWS_MATCHER_FLAGS_RESIZABLE : 0;
+	matcher->flags |= attr->isolated_matcher_end_ft_id ?
+			  MLX5HWS_MATCHER_FLAGS_ISOLATED : 0;
 
 	return hws_matcher_check_attr_sz(caps, matcher);
 }
@@ -617,6 +891,8 @@ hws_matcher_create_col_matcher(struct mlx5hws_matcher *matcher)
 		col_matcher->attr.table.sz_row_log -= MLX5HWS_MATCHER_ASSURED_ROW_RATIO;
 
 	col_matcher->attr.max_num_of_at_attach = matcher->attr.max_num_of_at_attach;
+	col_matcher->attr.isolated_matcher_end_ft_id =
+		matcher->attr.isolated_matcher_end_ft_id;
 
 	ret = hws_matcher_process_attr(ctx->caps, col_matcher);
 	if (ret)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
index 8e95158a66b5..32e83cddcd60 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
@@ -34,6 +34,7 @@ enum mlx5hws_matcher_offset {
 enum mlx5hws_matcher_flags {
 	MLX5HWS_MATCHER_FLAGS_COLLISION = 1 << 2,
 	MLX5HWS_MATCHER_FLAGS_RESIZABLE	= 1 << 3,
+	MLX5HWS_MATCHER_FLAGS_ISOLATED	= 1 << 4,
 };
 
 struct mlx5hws_match_template {
@@ -96,9 +97,17 @@ static inline bool mlx5hws_matcher_is_in_resize(struct mlx5hws_matcher *matcher)
 	return !!matcher->resize_dst;
 }
 
+static inline bool mlx5hws_matcher_is_isolated(struct mlx5hws_matcher *matcher)
+{
+	return !!(matcher->flags & MLX5HWS_MATCHER_FLAGS_ISOLATED);
+}
+
 static inline bool mlx5hws_matcher_is_insert_by_idx(struct mlx5hws_matcher *matcher)
 {
 	return matcher->attr.insert_mode == MLX5HWS_MATCHER_INSERT_BY_INDEX;
 }
 
+int mlx5hws_matcher_update_end_ft_isolated(struct mlx5hws_table *tbl,
+					   u32 miss_ft_id);
+
 #endif /* HWS_MATCHER_H_ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
index 5121951f2778..fbd63369da10 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
@@ -119,6 +119,8 @@ struct mlx5hws_matcher_attr {
 	};
 	/* Optional AT attach configuration - Max number of additional AT */
 	u8 max_num_of_at_attach;
+	/* Optional end FT (miss FT ID) for match RTC (for isolated matcher) */
+	u32 isolated_matcher_end_ft_id;
 };
 
 struct mlx5hws_rule_attr {
-- 
2.31.1


