Return-Path: <linux-rdma+bounces-10451-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64568ABE31D
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 20:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57473189F233
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 18:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B98283147;
	Tue, 20 May 2025 18:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NlO7c4qu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2646428003E;
	Tue, 20 May 2025 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747766869; cv=fail; b=AAYNkTnQ/CvjcY/f8eECrmrTDZcaYQj6dKD+5sJv6fBRHD/wDahoDgy78sXoEUFrLltXoeVRMGhBIypNpJhVdIXCOObve6fvU1U0FaIytzo26cpt7CG+fCwkT6A7Jb+cA3kREi+MjYQmQz5JT+isjwIAmuHkKFOWQFoqKenh4Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747766869; c=relaxed/simple;
	bh=AsS2TI+YUBsT3NTsKXcvUYa7Jjv1d1Rkq7PZkIHhSf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/RVWvJC2PZVQc8QRmgp513WTuvKIYoy7+8MJvDLYNnlVSDH3gkW2suKtl1cn7YGwDXKjycZ3YtGx3XNYzztBeh3QOtGedsZD2+wbCbx/MLKCwT01oqbNACVTkalRsOXc9ukLtaVi6DejIpcYH9IH3kxUlso5Pz6O5YoRRDt714=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NlO7c4qu; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efLhg93EMLsSbLKGNETdqJ4hjjsmqP7BSPfZNIT12zimmwpbFlmsRdby1pvnSZwejSZ3ovLWrcmue1C5Yzpvs4CK9vApCHB5ESUmp4Xwanc17ClgW3ZMu5XZE6aaGzQ5O4V8OE3Ye8WRfUDgT8Tg9Do4/ca+ZTlOB5Ey+XCdvj17rMhS9DmOPiQWPTQNv9hWJk1nMH5r8uP3+jIPEzxPwIkmybZ4S9SQpMQ4/EoTrjpnQ8HDGpUS+HzNm1zYuZU5BJCIIGDskJn9M8oRjuNiNICpwhQrV4G2kVbuCv+k8CqUJgjBNjk4EISDRed5LvqOrNgAl7nalEWJQyhmE5lUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mpVJNyvkUuDp8nWq3lQUYYsZd59xExJiD2ADKyH/fc=;
 b=WYUcoUiDgw0r2LAbjMRTEX/fORbMEXyfpIYoGPv4dBNrNE7WT0IcRyjCbi0sK3RQVweIQOSon+Jc8+9ZG4h2qwITICVADMIDT/ehj45OdQ6qXWhQRoKn0WaiCLnzr2GHWjUyUouiFbn4DNxBtO+3zUl2zqzkwYp+2MfbpmctNvU4bZq5LQ8cHq/7ulA7WfotokFzby2f5z3iHxHJD+uWBce3TahzDifdu7HBFS1Ecwr/zpBbJelZmRc4KfId9+gqiQr6smrQVZlJKVv77/6gdw+6YhM8gEcaS/3eudPIpInOVO5rCuVecpJOu+WttIgAbpgjs8rWwnNyevuJMwKSaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mpVJNyvkUuDp8nWq3lQUYYsZd59xExJiD2ADKyH/fc=;
 b=NlO7c4quhchIoEbvibtrk4q1dKQB38DHRlxMvBQ1wgBQTLz05ezZvAEB+iGnNIIKsDvhxAfITBcNwcbQMkzj9Jjg1icwz+UMTE/RIB9cGw2zfgDWtzXQ9OWCAV7iC7soqnRgBCvTDndjG9FbIPUq4xhTfSlzc9ySq0L5T1sYOSkJ3bBFfT0dcpNZFAThm83GnZGpQLV3S7IUozVGSgxrjj4l6CS3lqFGGHVQcyhB5KUsRMGc/M9w2ipRuZyi0PvMo9wWNxwzLRaSQa3PrDpOqpWVq+9Eg9/b7o+IdzaiI5z9HUOUYNyimN8GWa/8K5Xnn8krbDVPcmlKXVTf9XdAhw==
Received: from MN2PR22CA0018.namprd22.prod.outlook.com (2603:10b6:208:238::23)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Tue, 20 May
 2025 18:47:43 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::ba) by MN2PR22CA0018.outlook.office365.com
 (2603:10b6:208:238::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.32 via Frontend Transport; Tue,
 20 May 2025 18:47:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Tue, 20 May 2025 18:47:43 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 May
 2025 11:47:14 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 20 May
 2025 11:47:14 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 20
 May 2025 11:47:10 -0700
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
Subject: [PATCH net-next 3/4] net/mlx5: HWS, fix typo - 'nope' to 'nop'
Date: Tue, 20 May 2025 21:46:41 +0300
Message-ID: <1747766802-958178-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1747766802-958178-1-git-send-email-tariqt@nvidia.com>
References: <1747766802-958178-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: e036af51-c344-44f2-85ef-08dd97cece0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?faH3xVDAbr+cnBtv0QsT1eCMPCfxJKW6r/mfX9WnLmM45A2YdNECkaA1LOEc?=
 =?us-ascii?Q?E3w/F+qEBVJcu5H1GWSBsjhuTC7+5gW+4Hin1U+MQQsoVRKCM4yDhtjocj2v?=
 =?us-ascii?Q?8zsPtxnGrTIZEQ/wIgFscvn0QUXu9inLn6VFOI9Dru7ovihk8HnH6qCdQ6kZ?=
 =?us-ascii?Q?FTqGoCefQjp2f2toOzva2essEtvzAXoulPVXhjb8W+r4o6MydLjQbhQthbRN?=
 =?us-ascii?Q?ANSdKf82SVUpsNQwaH70zyliHmmvBEJvYySyvTqllR9D3mWOIe5otC6W9UcO?=
 =?us-ascii?Q?BskZa1aTQ6iDARiYHaHleFGqX4MBlMOS/D/tMkzfgS/2kCqwIIW4TXRWR0FQ?=
 =?us-ascii?Q?ObeBLjIRtJpBpClJjKsRaN53cGv+crdg/XTH4l5Ow5tz+gcXJSh6o+67MWE9?=
 =?us-ascii?Q?etOg5Ej4pYiS9ZSNE2j0ZSDNrAXcRKCYBQkAzS1GHTWZ5vgQfFdfYw7CXN97?=
 =?us-ascii?Q?F22XumQx+RwhON+YZC3vIG+I4sfiACcqHRqW7tx+bL2DSoa3P0YvWIoI3NNQ?=
 =?us-ascii?Q?9VBQhQHY9/thBWYAQ+Oj3+/TlYW1RlKeajj/jbs7Zag8aOaFCU4YViPrARU9?=
 =?us-ascii?Q?Dk+PSIkmhzk2Cz5vD57yqZ6IcsqcqTslPhBokhA6PUOsDTjOJsIfI1MJMzHR?=
 =?us-ascii?Q?+EQFirnEsP7gNH94POYqYTEhaXhfhzHqTK2kOfOKVG9tBwGBzYrKD3XhpVAm?=
 =?us-ascii?Q?a5EESYhyt0WwIhBJ9w/RGw8tD5UJLvEsSIIHnVfR73/fxaxGdv+MyanzOrQj?=
 =?us-ascii?Q?8xnfngCbi3cxOZQgaK6my/uRRxdCfL7oHu7zTB+OBEOy9rdvz5Z4eV0gGnka?=
 =?us-ascii?Q?uytZufWTxybEmlzyXUsdd/YrOGi6IMwa4Zsx9J4C1d0C1+5vW00vmPvL7JRx?=
 =?us-ascii?Q?eomRy6l++Qgca5v8HWcfh6asgdWNaEF5V/Kj8sMZmjiQWtAEHlR4YIYmkTqa?=
 =?us-ascii?Q?8pbEvNBHGcCDsaYxNQQTF0/KIPka90p3jRshLVkEH/djc/UTybQ6CMdJuVNs?=
 =?us-ascii?Q?LT7UtE/q/QGEsxBX4PdPFXGjnIQWXKFhk3GgF+ebpXXQ4mUYs/9A7rY4BSUC?=
 =?us-ascii?Q?FYv97/c42XQIR0uBZilWnAOmjoUzyAINL25wutCVYDIJEGEha6CuweMWqcJc?=
 =?us-ascii?Q?9X5DLzTS2Pf7fXQPvWtvU46IYd/mmKGGdYuEx1eUczjLV1hPiMuIGZiX+12E?=
 =?us-ascii?Q?z9rRbBanPRp5uob3m3S0bl6N4dLqepny9laXQiFmtSoAnq4iVvSIiP/7qvuM?=
 =?us-ascii?Q?X40lAlUuuYWPm5ReUss0KB4RQz8yZieNv+Hw2OjprABqUipUzytR3TUhlzOS?=
 =?us-ascii?Q?L473zd1Xh5Ep+azFyb6YfCGWZouHZQkV0+oRGvUxyVo7bna4b+7qXYrdVBQE?=
 =?us-ascii?Q?lHRLjMn/yNrU+zOM2FcurO/PFWDjET7NV1yCKedsIHJXDnOUaouEOYdZ9bHZ?=
 =?us-ascii?Q?W5TSbXwkG2L7G9y3Bq7/wdTgckrP36zqmy5fQHn3++QN3S2XngXj3J3mjWhB?=
 =?us-ascii?Q?KJpASZH7Hp2Bye5NqAFm++9+EzAdb1w5TuCH?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 18:47:43.0350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e036af51-c344-44f2-85ef-08dd97cece0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Fix typo - rename 'nope_locations' to 'nop_locations', which describes
the locations of 'nop' actions. To shorten the lines, this renaming
also required some refactoring.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/action.c  | 53 ++++++++++---------
 .../mellanox/mlx5/core/steering/hws/action.h  |  2 +-
 .../mellanox/mlx5/core/steering/hws/pat_arg.c | 18 +++----
 .../mellanox/mlx5/core/steering/hws/pat_arg.h |  5 +-
 4 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
index aa47a7af6f50..64d115feef2c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
@@ -1207,16 +1207,16 @@ hws_action_create_modify_header_hws(struct mlx5hws_action *action,
 	for (i = 0; i < num_of_patterns; i++) {
 		size_t new_num_actions;
 		size_t cur_num_actions;
-		u32 nope_location;
+		u32 nop_locations;
 
 		cur_num_actions = pattern[i].sz / MLX5HWS_MODIFY_ACTION_SIZE;
 
-		mlx5hws_pat_calc_nope(pattern[i].data, cur_num_actions,
-				      pat_max_sz / MLX5HWS_MODIFY_ACTION_SIZE,
-				      &new_num_actions, &nope_location,
-				      &new_pattern[i * pat_max_sz]);
+		mlx5hws_pat_calc_nop(pattern[i].data, cur_num_actions,
+				     pat_max_sz / MLX5HWS_MODIFY_ACTION_SIZE,
+				     &new_num_actions, &nop_locations,
+				     &new_pattern[i * pat_max_sz]);
 
-		action[i].modify_header.nope_locations = nope_location;
+		action[i].modify_header.nop_locations = nop_locations;
 		action[i].modify_header.num_of_actions = new_num_actions;
 
 		max_mh_actions = max(max_mh_actions, new_num_actions);
@@ -1263,7 +1263,7 @@ hws_action_create_modify_header_hws(struct mlx5hws_action *action,
 				MLX5_GET(set_action_in, pattern[i].data, action_type);
 		} else {
 			/* Multiple modify actions require a pattern */
-			if (unlikely(action[i].modify_header.nope_locations)) {
+			if (unlikely(action[i].modify_header.nop_locations)) {
 				size_t pattern_sz;
 
 				pattern_sz = action[i].modify_header.num_of_actions *
@@ -2105,12 +2105,12 @@ static void hws_action_modify_write(struct mlx5hws_send_engine *queue,
 				    u32 arg_idx,
 				    u8 *arg_data,
 				    u16 num_of_actions,
-				    u32 nope_locations)
+				    u32 nop_locations)
 {
 	u8 *new_arg_data = NULL;
 	int i, j;
 
-	if (unlikely(nope_locations)) {
+	if (unlikely(nop_locations)) {
 		new_arg_data = kcalloc(num_of_actions,
 				       MLX5HWS_MODIFY_ACTION_SIZE, GFP_KERNEL);
 		if (unlikely(!new_arg_data))
@@ -2118,7 +2118,7 @@ static void hws_action_modify_write(struct mlx5hws_send_engine *queue,
 
 		for (i = 0, j = 0; i < num_of_actions; i++, j++) {
 			memcpy(&new_arg_data[j], arg_data, MLX5HWS_MODIFY_ACTION_SIZE);
-			if (BIT(i) & nope_locations)
+			if (BIT(i) & nop_locations)
 				j++;
 		}
 	}
@@ -2215,6 +2215,7 @@ hws_action_setter_modify_header(struct mlx5hws_actions_apply_data *apply,
 	struct mlx5hws_action *action;
 	u32 arg_sz, arg_idx;
 	u8 *single_action;
+	u8 max_actions;
 	__be32 stc_idx;
 
 	rule_action = &apply->rule_action[setter->idx_double];
@@ -2242,21 +2243,23 @@ hws_action_setter_modify_header(struct mlx5hws_actions_apply_data *apply,
 
 		apply->wqe_data[MLX5HWS_ACTION_OFFSET_DW7] =
 			*(__be32 *)MLX5_ADDR_OF(set_action_in, single_action, data);
-	} else {
-		/* Argument offset multiple with number of args per these actions */
-		arg_sz = mlx5hws_arg_get_arg_size(action->modify_header.max_num_of_actions);
-		arg_idx = rule_action->modify_header.offset * arg_sz;
-
-		apply->wqe_data[MLX5HWS_ACTION_OFFSET_DW7] = htonl(arg_idx);
-
-		if (!(action->flags & MLX5HWS_ACTION_FLAG_SHARED)) {
-			apply->require_dep = 1;
-			hws_action_modify_write(apply->queue,
-						action->modify_header.arg_id + arg_idx,
-						rule_action->modify_header.data,
-						action->modify_header.num_of_actions,
-						action->modify_header.nope_locations);
-		}
+		return;
+	}
+
+	/* Argument offset multiple with number of args per these actions */
+	max_actions = action->modify_header.max_num_of_actions;
+	arg_sz = mlx5hws_arg_get_arg_size(max_actions);
+	arg_idx = rule_action->modify_header.offset * arg_sz;
+
+	apply->wqe_data[MLX5HWS_ACTION_OFFSET_DW7] = htonl(arg_idx);
+
+	if (!(action->flags & MLX5HWS_ACTION_FLAG_SHARED)) {
+		apply->require_dep = 1;
+		hws_action_modify_write(apply->queue,
+					action->modify_header.arg_id + arg_idx,
+					rule_action->modify_header.data,
+					action->modify_header.num_of_actions,
+					action->modify_header.nop_locations);
 	}
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.h
index 25fa0d4c9221..55a079fdd08f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.h
@@ -136,7 +136,7 @@ struct mlx5hws_action {
 					u32 pat_id;
 					u32 arg_id;
 					__be64 single_action;
-					u32 nope_locations;
+					u32 nop_locations;
 					u8 num_of_patterns;
 					u8 single_action_type;
 					u8 num_of_actions;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
index f51ed24526b9..78de19c074a7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
@@ -522,9 +522,9 @@ bool mlx5hws_pat_verify_actions(struct mlx5hws_context *ctx, __be64 pattern[], s
 	return true;
 }
 
-void mlx5hws_pat_calc_nope(__be64 *pattern, size_t num_actions,
-			   size_t max_actions, size_t *new_size,
-			   u32 *nope_location, __be64 *new_pat)
+void mlx5hws_pat_calc_nop(__be64 *pattern, size_t num_actions,
+			  size_t max_actions, size_t *new_size,
+			  u32 *nop_locations, __be64 *new_pat)
 {
 	u16 prev_src_field = 0, prev_dst_field = 0;
 	u16 src_field, dst_field;
@@ -532,7 +532,7 @@ void mlx5hws_pat_calc_nope(__be64 *pattern, size_t num_actions,
 	size_t i, j;
 
 	*new_size = num_actions;
-	*nope_location = 0;
+	*nop_locations = 0;
 
 	if (num_actions == 1)
 		return;
@@ -546,18 +546,18 @@ void mlx5hws_pat_calc_nope(__be64 *pattern, size_t num_actions,
 			if (action_type == MLX5_ACTION_TYPE_COPY &&
 			    (prev_src_field == src_field ||
 			     prev_dst_field == dst_field)) {
-				/* need Nope */
+				/* need Nop */
 				*new_size += 1;
-				*nope_location |= BIT(i);
+				*nop_locations |= BIT(i);
 				memset(&new_pat[j], 0, MLX5HWS_MODIFY_ACTION_SIZE);
 				MLX5_SET(set_action_in, &new_pat[j],
 					 action_type,
 					 MLX5_MODIFICATION_TYPE_NOP);
 				j++;
 			} else if (prev_src_field == src_field) {
-				/* need Nope*/
+				/* need Nop */
 				*new_size += 1;
-				*nope_location |= BIT(i);
+				*nop_locations |= BIT(i);
 				MLX5_SET(set_action_in, &new_pat[j],
 					 action_type,
 					 MLX5_MODIFICATION_TYPE_NOP);
@@ -568,7 +568,7 @@ void mlx5hws_pat_calc_nope(__be64 *pattern, size_t num_actions,
 		/* check if no more space */
 		if (j > max_actions) {
 			*new_size = num_actions;
-			*nope_location = 0;
+			*nop_locations = 0;
 			return;
 		}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.h
index 8ddb51980044..91bd2572a341 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.h
@@ -96,6 +96,7 @@ int mlx5hws_arg_write_inline_arg_data(struct mlx5hws_context *ctx,
 				      u8 *arg_data,
 				      size_t data_size);
 
-void mlx5hws_pat_calc_nope(__be64 *pattern, size_t num_actions, size_t max_actions,
-			   size_t *new_size, u32 *nope_location, __be64 *new_pat);
+void mlx5hws_pat_calc_nop(__be64 *pattern, size_t num_actions,
+			  size_t max_actions, size_t *new_size,
+			  u32 *nop_locations, __be64 *new_pat);
 #endif /* MLX5HWS_PAT_ARG_H_ */
-- 
2.31.1


