Return-Path: <linux-rdma+bounces-9254-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A4FA80D5B
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 16:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF44D1BA334A
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 14:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643B81E98EF;
	Tue,  8 Apr 2025 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y5Tvv9ze"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B081E25EB;
	Tue,  8 Apr 2025 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744120974; cv=fail; b=FYkvewBnQHxsxPnKn5q/zbXtAUnbfr3VEStuECaBceb3Yi6pfX44abek7nKx+Xr1T2iUdHn+v9gS9+JseVds5ONSmOfd8JhvCip1XttrQYct/CusolXNTAZk5k6KL18VZqKSaW8N5VcwEMy+1yt3YGWaUlomIZloeWL7M5Ee/gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744120974; c=relaxed/simple;
	bh=XhPkBDwch6LS48P8sC30a3+q9R6gV9Dpzl/6JKu44VY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJL0UovlKoHA9H+4u/JXu5nf69FN7pZUzgMJakSKJtxAZ2sqPyQrKUKm3Ud26cat8wgALDzigNqp+En6+03SUUICzqe1Z73kzcIzyBDxhOcF0Ln/DgeGXqBXMnRcaszxqQS8JY+4ngKtPopSk+1wic70kV/PjDgBzZpMlRtccDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y5Tvv9ze; arc=fail smtp.client-ip=40.107.95.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0IrdJeV9y071XGkRmi8u55zljIiiFU6nkkpU1GVomF6FWRAIvm/6ZUib+OTtBYJUz0zHi8M/xteFr0TS1w1fHwKYmGYExZ3PRa/WW5125WguGjgGMShcT6sf0bcihma2TmyLmPAE5ZwpuNfhLHZtTIBKL/m/6HIT0CcvivOeTg9YoFTjl4nikWrXBA7BDVFDoQ0MUsmcUwYQ9k7KZnEQJrxOBg8F02aEHaHesTB/712ISCXEaEaNxaV4GXabo36MDPuHhQbD1WcV7/VO+M9AVfuqDY7XrIfmCWw5RGj5QeEW+EJ9j5voGGmp9iSJ1HA6HC9Jg2KFim8I46P1k60Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7NDWq6bw56SRdnQCOLHcB7BSYQ5KY3qOu+gv4PuwP4=;
 b=VHJSlxC85nN4hZMPlftk8auhx+ypavQYrhOaPclVci2LNmuhLYosx+OmBhMOFVcIwNzzpHATrUDVUEcHT8IfUhtVyq4oNj2JKR9jREn/UUQCoj/9bRPoVBuPqBbd53nQgzCoIgZUX1Mckz6GSpZOlIoRiOiRUSKslTeLidcCXFoI4tSZuCba1/kJhn8ro4gOICE5Nko/uPcUAGKkFnR5E/2EGah8SAhoLcNnmXCbcOSZyGJIjB7hzSBk881dZOKqtPpC8HkvBZhBbstOFQrc3PX/vdpG91wYVtNlJMjEITCOCR9mvO+TJXXth87ZUVuXAhm8YpdRLdwpEUkcj9PUDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7NDWq6bw56SRdnQCOLHcB7BSYQ5KY3qOu+gv4PuwP4=;
 b=Y5Tvv9zewNZlay/IQcqubAlZRDcO9u0Sk879VjXIFtJZcf35MkU98pl9IWQzcnotFbDD4zwDruE9zyktgVTdyadwFoMXFktIPpJ+AKa/Ylu6JA/9ZPlJihD4lEOdPIhJdr8resT4tExyUYtFxkO8UpmAsJ/EoGmKzAM6EoGxBzU5CWT/luBesOUKSu2xjC8lbw+Wi2mO8McTfKP485Fz65l1WZ7KrBQuBWnKl3awSaE32yH/pnK1R6OiKGSnNPI3Ch7QHBnPmHozgRlXFyavLBzqWIrpG1K6EjT1QJJt9ZQM7NLdIIZLeiVi1oaABI9RBHML8wSHsHlonbQNaFywIg==
Received: from BN9PR03CA0562.namprd03.prod.outlook.com (2603:10b6:408:138::27)
 by CH3PR12MB8484.namprd12.prod.outlook.com (2603:10b6:610:158::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 14:02:45 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:138:cafe::a5) by BN9PR03CA0562.outlook.office365.com
 (2603:10b6:408:138::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.33 via Frontend Transport; Tue,
 8 Apr 2025 14:02:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 14:02:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Apr 2025
 07:02:24 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 8 Apr
 2025 07:02:24 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 8 Apr
 2025 07:02:19 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [PATCH net-next 05/12] net/mlx5: HWS, Cleanup after pool refactoring
Date: Tue, 8 Apr 2025 17:00:49 +0300
Message-ID: <1744120856-341328-6-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|CH3PR12MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bcf48e3-67ef-44c2-8a58-08dd76a6090b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nnVAD3oSbk2BJYIJ2QqhusMs7NwCwNTZlHzTuUrfOYpfIsuJQffIDDYgK7/J?=
 =?us-ascii?Q?Tiyrig5bMcAVdPfjenFhDgvrhYAgVCA2/17LblLqdMIc+KXydObSGd5yBmnU?=
 =?us-ascii?Q?KmS2P4AWOe63P2l4+Zrxjf7z4cMTZe+64N1CzSwKi+h0R1VjmxZPbZMvsu1n?=
 =?us-ascii?Q?EC1qkCLxrNUSUVyDW6lNCnzL8dv6SIFdrrXxMvNGYR+u/XOtZQMI1QStfcBK?=
 =?us-ascii?Q?8EjTo4FLIepuhM4z4d9ZV+/NBWYFszE4h19m2nmaKPrCv5o+Bok/XzpZHCyK?=
 =?us-ascii?Q?GEcHbOXxDjwWtCAK7jQGIfg1qJwvCrYpZEo4h5bpps5Alazeofot2d7xvZ6f?=
 =?us-ascii?Q?Iytn/OBYMr3iBoi/+O0pzOLLb1mLIQPX6Zzu6jtaQle0uuRcxwkpNaTEt6Ub?=
 =?us-ascii?Q?rtmcA4/9hCHzW1nF02piHEl/0RbCPbOh96UGQZGJnywn48+V194zogeZfK3m?=
 =?us-ascii?Q?EetxxiAQG6q2v28mEx0y4guCsL1wdBT4yHaAdPFyqM76dhDMsb3EgBro25x/?=
 =?us-ascii?Q?Fn05DLcXva9bduFn2NRiRpCiBAJ3Tx5XPtKiVCNSCI0uXuvuP9YCesuQaQ7E?=
 =?us-ascii?Q?oReKJ4dKCQl9fej9qPT+/0zb9gYVmLUYr4aMelAajKu0+qVBa8MHNdKk/YZF?=
 =?us-ascii?Q?qpRCdjWRh/TSBMD9FGdPPUp89V0WNnk5UK3HgH7ZbffBSC0gJcqoSjHZFaXN?=
 =?us-ascii?Q?fK93Uq9IXqu4xggrqT8WUg7Sn5sBO50EZGOsrEmoWcOewUZ3k5ZFenR1Ykk0?=
 =?us-ascii?Q?m/JvyJDR52A1MR6g2Gq9PLePAXrG57UVYeliUxqAqPeI9HmdPu2wHJZkT+Xy?=
 =?us-ascii?Q?7nxZUBClWS/BUzF1kfptezpHLrkJPWsv4Qvs8r8D5bEuqovyNh4sCtRKgIcf?=
 =?us-ascii?Q?iEBxRPnmTcah2dudcERGIRJ4q2l9EVvmulRIZWUtJg7IBLE6NlixEInVtlqT?=
 =?us-ascii?Q?fCvBpEFAat6CG584mhX5G2SXlOz49PAzYgenFo1DZtrU8Ofw1wUsIEdc0aVO?=
 =?us-ascii?Q?5rbyfSTurPeVmQZmnXYFYKomStirumBOBerAxkQznH9kiyFLBXRxjCYRTSOT?=
 =?us-ascii?Q?CFJl9kgcAxJtDxulCNdFNDolAS/QkDfyW2PEpY4jGB2zRm9HIlGdos08iDao?=
 =?us-ascii?Q?HI/YGZMIQ1+f6nhDmuGNTf8KdMv6O6hNFoQmwYFELyiJ7EMHJG7r8EpyWd8Z?=
 =?us-ascii?Q?7Z7Jw8OvXtnQv7drY9OeFwcGaLVrlQxeK8YcPT6plsHd0o70dpGfUujIzDAY?=
 =?us-ascii?Q?XtH9OuEL+niiqy5m1V24CfIfsxSUvY/P5wEZcSMSzTAAcDnn5Ju06aq+n4Q2?=
 =?us-ascii?Q?FV7ObM7haAkAhJealJcn6Z9J7CIs7V3WOpTXT7WXPX09jLBfx0iZbFW2sjdp?=
 =?us-ascii?Q?2yJbDwCn6Yb06f177/EKrdjr3xbde06RKgKJrBcN9oFjJvDROhgiMvG+NaCO?=
 =?us-ascii?Q?c6uiBjXIR2yGEwMMHymfThDgt+HjCXhz0qn+Jdemhoaw11p6ZsJOZBbIFCvo?=
 =?us-ascii?Q?ttbar4+LyQGy6Cg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 14:02:44.3159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcf48e3-67ef-44c2-8a58-08dd76a6090b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8484

From: Vlad Dogaru <vdogaru@nvidia.com>

Remove members which are now no longer used. In fact, many of the
`struct mlx5hws_pool_chunk` were not even written to beyond being
initialized, but they were used in various internals.

Also cleanup some local variables which made more sense when the API was
thicker.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/action.c  |  6 +--
 .../mellanox/mlx5/core/steering/hws/matcher.c | 48 ++++++-------------
 .../mellanox/mlx5/core/steering/hws/matcher.h |  2 -
 3 files changed, 16 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
index 39904b337b81..44b4640b47db 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
@@ -1583,7 +1583,6 @@ hws_action_create_dest_match_range_table(struct mlx5hws_context *ctx,
 	struct mlx5hws_matcher_action_ste *table_ste;
 	struct mlx5hws_pool_attr pool_attr = {0};
 	struct mlx5hws_pool *ste_pool, *stc_pool;
-	struct mlx5hws_pool_chunk *ste;
 	u32 *rtc_0_id, *rtc_1_id;
 	u32 obj_id;
 	int ret;
@@ -1613,8 +1612,6 @@ hws_action_create_dest_match_range_table(struct mlx5hws_context *ctx,
 	rtc_0_id = &table_ste->rtc_0_id;
 	rtc_1_id = &table_ste->rtc_1_id;
 	ste_pool = table_ste->pool;
-	ste = &table_ste->ste;
-	ste->order = 1;
 
 	rtc_attr.log_size = 0;
 	rtc_attr.log_depth = 0;
@@ -1630,7 +1627,7 @@ hws_action_create_dest_match_range_table(struct mlx5hws_context *ctx,
 
 	rtc_attr.pd = ctx->pd_num;
 	rtc_attr.ste_base = obj_id;
-	rtc_attr.ste_offset = ste->offset;
+	rtc_attr.ste_offset = 0;
 	rtc_attr.reparse_mode = mlx5hws_context_get_reparse_mode(ctx);
 	rtc_attr.table_type = mlx5hws_table_get_res_fw_ft_type(MLX5HWS_TABLE_TYPE_FDB, false);
 
@@ -1833,7 +1830,6 @@ mlx5hws_action_create_dest_match_range(struct mlx5hws_context *ctx,
 	stc_attr.action_offset = MLX5HWS_ACTION_OFFSET_HIT;
 	stc_attr.action_type = MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_STE_TABLE;
 	stc_attr.reparse_mode = MLX5_IFC_STC_REPARSE_IGNORE;
-	stc_attr.ste_table.ste = table_ste->ste;
 	stc_attr.ste_table.ste_pool = table_ste->pool;
 	stc_attr.ste_table.match_definer_id = ctx->caps->trivial_match_definer;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
index 95d31fd6c976..54dd5433a3ca 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
@@ -197,22 +197,15 @@ static int hws_matcher_disconnect(struct mlx5hws_matcher *matcher)
 
 static void hws_matcher_set_rtc_attr_sz(struct mlx5hws_matcher *matcher,
 					struct mlx5hws_cmd_rtc_create_attr *rtc_attr,
-					enum mlx5hws_matcher_rtc_type rtc_type,
 					bool is_mirror)
 {
-	struct mlx5hws_pool_chunk *ste = &matcher->action_ste.ste;
 	enum mlx5hws_matcher_flow_src flow_src = matcher->attr.optimize_flow_src;
-	bool is_match_rtc = rtc_type == HWS_MATCHER_RTC_TYPE_MATCH;
 
 	if ((flow_src == MLX5HWS_MATCHER_FLOW_SRC_VPORT && !is_mirror) ||
 	    (flow_src == MLX5HWS_MATCHER_FLOW_SRC_WIRE && is_mirror)) {
 		/* Optimize FDB RTC */
 		rtc_attr->log_size = 0;
 		rtc_attr->log_depth = 0;
-	} else {
-		/* Keep original values */
-		rtc_attr->log_size = is_match_rtc ? matcher->attr.table.sz_row_log : ste->order;
-		rtc_attr->log_depth = is_match_rtc ? matcher->attr.table.sz_col_log : 0;
 	}
 }
 
@@ -225,8 +218,7 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 	struct mlx5hws_context *ctx = matcher->tbl->ctx;
 	struct mlx5hws_matcher_action_ste *action_ste;
 	struct mlx5hws_table *tbl = matcher->tbl;
-	struct mlx5hws_pool *ste_pool, *stc_pool;
-	struct mlx5hws_pool_chunk *ste;
+	struct mlx5hws_pool *ste_pool;
 	u32 *rtc_0_id, *rtc_1_id;
 	u32 obj_id;
 	int ret;
@@ -236,8 +228,6 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 		rtc_0_id = &matcher->match_ste.rtc_0_id;
 		rtc_1_id = &matcher->match_ste.rtc_1_id;
 		ste_pool = matcher->match_ste.pool;
-		ste = &matcher->match_ste.ste;
-		ste->order = attr->table.sz_col_log + attr->table.sz_row_log;
 
 		rtc_attr.log_size = attr->table.sz_row_log;
 		rtc_attr.log_depth = attr->table.sz_col_log;
@@ -273,16 +263,15 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 		rtc_0_id = &action_ste->rtc_0_id;
 		rtc_1_id = &action_ste->rtc_1_id;
 		ste_pool = action_ste->pool;
-		ste = &action_ste->ste;
 		/* Action RTC size calculation:
 		 * log((max number of rules in matcher) *
 		 *     (max number of action STEs per rule) *
 		 *     (2 to support writing new STEs for update rule))
 		 */
-		ste->order = ilog2(roundup_pow_of_two(action_ste->max_stes)) +
-			     attr->table.sz_row_log +
-			     MLX5HWS_MATCHER_ACTION_RTC_UPDATE_MULT;
-		rtc_attr.log_size = ste->order;
+		rtc_attr.log_size =
+			ilog2(roundup_pow_of_two(action_ste->max_stes)) +
+			attr->table.sz_row_log +
+			MLX5HWS_MATCHER_ACTION_RTC_UPDATE_MULT;
 		rtc_attr.log_depth = 0;
 		rtc_attr.update_index_mode = MLX5_IFC_RTC_STE_UPDATE_MODE_BY_OFFSET;
 		/* The action STEs use the default always hit definer */
@@ -300,21 +289,20 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 
 	rtc_attr.pd = ctx->pd_num;
 	rtc_attr.ste_base = obj_id;
-	rtc_attr.ste_offset = ste->offset;
+	rtc_attr.ste_offset = 0;
 	rtc_attr.reparse_mode = mlx5hws_context_get_reparse_mode(ctx);
 	rtc_attr.table_type = mlx5hws_table_get_res_fw_ft_type(tbl->type, false);
-	hws_matcher_set_rtc_attr_sz(matcher, &rtc_attr, rtc_type, false);
+	hws_matcher_set_rtc_attr_sz(matcher, &rtc_attr, false);
 
 	/* STC is a single resource (obj_id), use any STC for the ID */
-	stc_pool = ctx->stc_pool;
-	obj_id = mlx5hws_pool_get_base_id(stc_pool);
+	obj_id = mlx5hws_pool_get_base_id(ctx->stc_pool);
 	rtc_attr.stc_base = obj_id;
 
 	ret = mlx5hws_cmd_rtc_create(ctx->mdev, &rtc_attr, rtc_0_id);
 	if (ret) {
 		mlx5hws_err(ctx, "Failed to create matcher RTC of type %s",
 			    hws_matcher_rtc_type_to_str(rtc_type));
-		goto free_ste;
+		return ret;
 	}
 
 	if (tbl->type == MLX5HWS_TABLE_TYPE_FDB) {
@@ -322,9 +310,9 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 		rtc_attr.ste_base = obj_id;
 		rtc_attr.table_type = mlx5hws_table_get_res_fw_ft_type(tbl->type, true);
 
-		obj_id = mlx5hws_pool_get_base_mirror_id(stc_pool);
+		obj_id = mlx5hws_pool_get_base_mirror_id(ctx->stc_pool);
 		rtc_attr.stc_base = obj_id;
-		hws_matcher_set_rtc_attr_sz(matcher, &rtc_attr, rtc_type, true);
+		hws_matcher_set_rtc_attr_sz(matcher, &rtc_attr, true);
 
 		ret = mlx5hws_cmd_rtc_create(ctx->mdev, &rtc_attr, rtc_1_id);
 		if (ret) {
@@ -338,16 +326,12 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 
 destroy_rtc_0:
 	mlx5hws_cmd_rtc_destroy(ctx->mdev, *rtc_0_id);
-free_ste:
-	if (rtc_type == HWS_MATCHER_RTC_TYPE_MATCH)
-		mlx5hws_pool_chunk_free(ste_pool, ste);
 	return ret;
 }
 
 static void hws_matcher_destroy_rtc(struct mlx5hws_matcher *matcher,
 				    enum mlx5hws_matcher_rtc_type rtc_type)
 {
-	struct mlx5hws_matcher_action_ste *action_ste;
 	struct mlx5hws_table *tbl = matcher->tbl;
 	u32 rtc_0_id, rtc_1_id;
 
@@ -357,18 +341,17 @@ static void hws_matcher_destroy_rtc(struct mlx5hws_matcher *matcher,
 		rtc_1_id = matcher->match_ste.rtc_1_id;
 		break;
 	case HWS_MATCHER_RTC_TYPE_STE_ARRAY:
-		action_ste = &matcher->action_ste;
-		rtc_0_id = action_ste->rtc_0_id;
-		rtc_1_id = action_ste->rtc_1_id;
+		rtc_0_id = matcher->action_ste.rtc_0_id;
+		rtc_1_id = matcher->action_ste.rtc_1_id;
 		break;
 	default:
 		return;
 	}
 
 	if (tbl->type == MLX5HWS_TABLE_TYPE_FDB)
-		mlx5hws_cmd_rtc_destroy(matcher->tbl->ctx->mdev, rtc_1_id);
+		mlx5hws_cmd_rtc_destroy(tbl->ctx->mdev, rtc_1_id);
 
-	mlx5hws_cmd_rtc_destroy(matcher->tbl->ctx->mdev, rtc_0_id);
+	mlx5hws_cmd_rtc_destroy(tbl->ctx->mdev, rtc_0_id);
 }
 
 static int
@@ -564,7 +547,6 @@ static int hws_matcher_bind_at(struct mlx5hws_matcher *matcher)
 	stc_attr.action_offset = MLX5HWS_ACTION_OFFSET_HIT;
 	stc_attr.action_type = MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_STE_TABLE;
 	stc_attr.reparse_mode = MLX5_IFC_STC_REPARSE_IGNORE;
-	stc_attr.ste_table.ste = action_ste->ste;
 	stc_attr.ste_table.ste_pool = action_ste->pool;
 	stc_attr.ste_table.match_definer_id = ctx->caps->trivial_match_definer;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
index 20b32012c418..0450b6175ac9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
@@ -45,14 +45,12 @@ struct mlx5hws_match_template {
 };
 
 struct mlx5hws_matcher_match_ste {
-	struct mlx5hws_pool_chunk ste;
 	u32 rtc_0_id;
 	u32 rtc_1_id;
 	struct mlx5hws_pool *pool;
 };
 
 struct mlx5hws_matcher_action_ste {
-	struct mlx5hws_pool_chunk ste;
 	struct mlx5hws_pool_chunk stc;
 	u32 rtc_0_id;
 	u32 rtc_1_id;
-- 
2.31.1


