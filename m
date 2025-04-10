Return-Path: <linux-rdma+bounces-9350-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C88A84CD1
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 21:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164424E12A1
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 19:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88034293B72;
	Thu, 10 Apr 2025 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="loNks4OC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2EE293B5A;
	Thu, 10 Apr 2025 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312741; cv=fail; b=hRFL7BvLM0nXq8FenRf/c/8VA6UX7Duv/rZKsW4ZQFJDQUTNY3fxeDTIrN8O2QOWbsywEjPOzOLD93R0mtRTbx1z34TfFcISxxpcRJZ8tb1udFyU0SMvDNRc/eG8YjXNTeddIFDx91/NW4y2qptMcpBO4CZYQb7TKcs/gJ5JE34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312741; c=relaxed/simple;
	bh=HuwT3q0kj/Gvp00vwNdl71rfa56LT07FEHOojjcs+0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WepwmSlMMvIQtSRHJNtZEcd/jjbOs8bjJnsGxoKEEXjE9XZmwQAWoyFiCiDnrkuDRLgzgzvTf1CIkQY4TBEYPJ6bytl3ngZjyMR3SaSD/tM21/Rnl0J41dZhZMqhXtGTi01/X1A9PCI7NEs4f1SE88ErFc4jGN8+6O1ZrUs0Wy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=loNks4OC; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bajF/HRRZWnvwtVclnUY2Hj9PkXLHcJYT8UesISD2VAk6NDwT0Uk0lecv/U0CAJr3DNilFFFE5EAeDHMts0DsIzC7DukLvspGH1EQDDbAdxv4mHYNnP390eaweSraTMWTarw2Ei5jpwn2h3OSTL48GyhimjD4suAL2OUnR2vurPTpOGdbLCbB0hBEM+U9QTTujEgRavWGF2rfCykCmhOiCYfSi6blxKP837p0E3PFUfQThIhPiwq1l4J9R55NGLJKkvW8dJKyu+4j06K0CVufRqduAKNpjeG7Dcgq27BXj7SqkHxcia/5Va2WPv9doag6815qQ1gKaJT25EHc0bmyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yygrMfjDjMDM6+9S+TzX1P4cLtrkB2+R0GIAmVnmz3g=;
 b=KHlfBbmMt+zWqeqfZPFlnpKIZNjEXQGfjjuvbz880WzUxT/UXCUzffTb+a+xjj+jij2VMSz7Pyu7JoanjjcY+4gz8ZhLpBdCZ2sYmFpoJwhpj5n/mioPpdNBFagAQ0nSwarOJrSeHv/mFhJACNZTq+WEqhhZrATtiHLnTA9SHRcCWACtmQtRJZnfYUPJMkUqIVtTK5nZww6odk79pO9ETtG42gmORMxsNKUbOc9N6Y9A5s/rQSofmBLONOVaTYMhsj0OdU/QbzI8z3Dpw3VzWoSGotixKcxjQ7CWG8w5m7y/5zMpGV588nPcGUlPmP2awJ72wji7+bRXid5yaIVNbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yygrMfjDjMDM6+9S+TzX1P4cLtrkB2+R0GIAmVnmz3g=;
 b=loNks4OCeuj6uMSI97IAWcm7H8QQbvkEdbkunJZCyOvJCjVapAqiWqsOatWO9z6kFKdkia/RHn4NCkHp+AgskDZY60KaDUjAyvuoWsDOexFodM/vtKI6pDX/1jPPCxuh8SsM0RZoVHR3lgCzykONVRiq230nX5a1ubWK1lxICwC0KrwZeeCmuH7pZacs9xTSvjMqJuyb0qB192hyHaJpInsFOXlJj58c3wBcBwk8r9V5SGtDmuv8kqVapnQgvVYH7REv9pFGvOcFzF+l0z3DK+sm/WkQVNc+l++wTsCz/Sv/d6aldR0YCMBtpN05ipbnyXgbAk/TkgQ5+84rrYnFYQ==
Received: from SJ0PR03CA0069.namprd03.prod.outlook.com (2603:10b6:a03:331::14)
 by SA3PR12MB8000.namprd12.prod.outlook.com (2603:10b6:806:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Thu, 10 Apr
 2025 19:18:52 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::be) by SJ0PR03CA0069.outlook.office365.com
 (2603:10b6:a03:331::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.36 via Frontend Transport; Thu,
 10 Apr 2025 19:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 19:18:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 12:18:34 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 12:18:33 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 12:18:29 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Michal Kubiak
	<michal.kubiak@intel.com>
Subject: [PATCH net-next V2 05/12] net/mlx5: HWS, Cleanup after pool refactoring
Date: Thu, 10 Apr 2025 22:17:35 +0300
Message-ID: <1744312662-356571-6-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1744312662-356571-1-git-send-email-tariqt@nvidia.com>
References: <1744312662-356571-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|SA3PR12MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: 3531a678-b117-4e61-e1b2-08dd78648751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sM5ejIvP6WOQbq+DEINcm10xw9wYwLhGnlRryvDel7Egtxz1KLck6rPDFZNx?=
 =?us-ascii?Q?bp6zxOUb4TKF+XnszEtf/DC/1RhgqgbtCRGTmOdLsyLeXB3RhBW3H/hHC9b4?=
 =?us-ascii?Q?Z+0wK6WxpR9J5xK0U+Q68GHxcBJQWfoP1xLS5fMl24mTaTNUwnX5aR8WIrqd?=
 =?us-ascii?Q?ECf1iY4kGoNTapQGb1tJi44RLeUccUNoPAg7u0IM8p6yjLwT7sWvNKrNaQu3?=
 =?us-ascii?Q?RZ55hYXSXhPCGsEWeTcWKwjw7016/eYg4mImH5S0myMPKbwjVFfL8gMEeO2c?=
 =?us-ascii?Q?84kRUeidqx4PsAijWi1g0dckP1kY+n3X/3lTRVspidbKJrIRD3FsNTOKQIFH?=
 =?us-ascii?Q?8s1/nCIM+DzJKjLXj6hKhVwUSfrGszEH6/GRkelQa6+QanBEb15JkJoH3pHb?=
 =?us-ascii?Q?ZqyPpWy02cgPfgXJydXkZ6buHP664YfsC/95ITbcZXJuv/I23TdoaQ++zZSo?=
 =?us-ascii?Q?heAer0PAC8t7mPlFY15YTZeC4Hq/slmhBZ1fHxzQpLbaN5pen6qsTRoLODKb?=
 =?us-ascii?Q?UIG0o/c6Cst3HnTxtI13OFdtcskuQnb1eTKbj0of4jJ6XZUcl2+fMWNlaOLZ?=
 =?us-ascii?Q?T+Fyhx35gePAHRiOHyrcsu+BFKi0bdhNthHe4HspwOG3QsoW0Hojp9nR23Y1?=
 =?us-ascii?Q?0deL/ZM9CD1sU5TF0w63A2jise5YDdW0qoNQZMtPrfQumg5hCPQALeuWZwne?=
 =?us-ascii?Q?8MQ1kknuY3R7clmqjsTGkuWV8UicTMlXxradHJeoaQgMHpJT8cq06iaEVX+W?=
 =?us-ascii?Q?V+TgJn1tgLzKTjxfKKQa3Xn3IE1MJWSCxeZCPw/LZmnKmH13vxFSl+k1SOcP?=
 =?us-ascii?Q?ZkaDrOZov8JG1m2guIgbRXMMYwDtvoLwFTVePdZbux3q6Z9pb5LsQCqp2Iy/?=
 =?us-ascii?Q?ThRleFnVHd18ojVNoSQQzSan17TStw8Dos80UInNCnJCFsz/2ujCXciuU8u9?=
 =?us-ascii?Q?Yp04UcTKMFg5fQOqGkwlYHH234B8D/TXdfPxyX73qGl+6RntzAhvUbI/PNRS?=
 =?us-ascii?Q?8J9alR1TIyzjpS7LOlqK12PmIDM1LNMDbP6NB9WNzCYZBygZ6ELD1uWPfo5P?=
 =?us-ascii?Q?davcDNGxUs7UoEV2vGQ1ceJXBzdjI+wTD9DzAm54j9kzGeDxEa9+ms8tV66O?=
 =?us-ascii?Q?9sac3evIE2HOI4roYctajkFxAj6M+ANulDWznwL+i11KF1Raubk3AbuHdgft?=
 =?us-ascii?Q?x+Yd1ue8BT6n6+XsVuwH7fXoVNhaXYdCGXbbjFgmAllPqpX6k+IE44GxMgKe?=
 =?us-ascii?Q?53/mmi1XsFJ2XT3nwYjMVO3JWOe7NjHZ1FzfEZUMqrsgV4izC1KcVtXfAHx+?=
 =?us-ascii?Q?lfXLj8MNJyCVwbvLcFtve7rzW70Ih5IGTK9N21aS9KREfXY8VDZlZ5Us80bd?=
 =?us-ascii?Q?qT6tb1NUeDAWJJseL3AYZ79sEw5H2e8F9PM8hs7h/J4QrFWLrt5aj9FIRf8h?=
 =?us-ascii?Q?dYvsuywvLBknDvlym//0GBp+lNHpWWSFKiQkXDg1RRKTfayfK4TxZs0GFPUt?=
 =?us-ascii?Q?YuzVHLGwzYHr+Vs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 19:18:51.8050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3531a678-b117-4e61-e1b2-08dd78648751
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8000

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
 .../mellanox/mlx5/core/steering/hws/action.c  |  5 --
 .../mellanox/mlx5/core/steering/hws/cmd.c     |  1 -
 .../mellanox/mlx5/core/steering/hws/cmd.h     |  1 -
 .../mellanox/mlx5/core/steering/hws/matcher.c | 47 ++++++-------------
 .../mellanox/mlx5/core/steering/hws/matcher.h |  2 -
 5 files changed, 14 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
index 39904b337b81..161ad720b339 100644
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
@@ -1630,7 +1627,6 @@ hws_action_create_dest_match_range_table(struct mlx5hws_context *ctx,
 
 	rtc_attr.pd = ctx->pd_num;
 	rtc_attr.ste_base = obj_id;
-	rtc_attr.ste_offset = ste->offset;
 	rtc_attr.reparse_mode = mlx5hws_context_get_reparse_mode(ctx);
 	rtc_attr.table_type = mlx5hws_table_get_res_fw_ft_type(MLX5HWS_TABLE_TYPE_FDB, false);
 
@@ -1833,7 +1829,6 @@ mlx5hws_action_create_dest_match_range(struct mlx5hws_context *ctx,
 	stc_attr.action_offset = MLX5HWS_ACTION_OFFSET_HIT;
 	stc_attr.action_type = MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_STE_TABLE;
 	stc_attr.reparse_mode = MLX5_IFC_STC_REPARSE_IGNORE;
-	stc_attr.ste_table.ste = table_ste->ste;
 	stc_attr.ste_table.ste_pool = table_ste->pool;
 	stc_attr.ste_table.match_definer_id = ctx->caps->trivial_match_definer;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
index e8f98c109b99..9c83753e4592 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
@@ -406,7 +406,6 @@ int mlx5hws_cmd_rtc_create(struct mlx5_core_dev *mdev,
 	MLX5_SET(rtc, attr, match_definer_1, rtc_attr->match_definer_1);
 	MLX5_SET(rtc, attr, stc_id, rtc_attr->stc_base);
 	MLX5_SET(rtc, attr, ste_table_base_id, rtc_attr->ste_base);
-	MLX5_SET(rtc, attr, ste_table_offset, rtc_attr->ste_offset);
 	MLX5_SET(rtc, attr, miss_flow_table_id, rtc_attr->miss_ft_id);
 	MLX5_SET(rtc, attr, reparse_mode, rtc_attr->reparse_mode);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h
index 51d9e0291ac1..fa6bff210266 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h
@@ -70,7 +70,6 @@ struct mlx5hws_cmd_rtc_create_attr {
 	u32 pd;
 	u32 stc_base;
 	u32 ste_base;
-	u32 ste_offset;
 	u32 miss_ft_id;
 	bool fw_gen_wqe;
 	u8 update_index_mode;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
index 95d31fd6c976..3028e0387e3f 100644
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
@@ -300,21 +289,19 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 
 	rtc_attr.pd = ctx->pd_num;
 	rtc_attr.ste_base = obj_id;
-	rtc_attr.ste_offset = ste->offset;
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
@@ -322,9 +309,9 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 		rtc_attr.ste_base = obj_id;
 		rtc_attr.table_type = mlx5hws_table_get_res_fw_ft_type(tbl->type, true);
 
-		obj_id = mlx5hws_pool_get_base_mirror_id(stc_pool);
+		obj_id = mlx5hws_pool_get_base_mirror_id(ctx->stc_pool);
 		rtc_attr.stc_base = obj_id;
-		hws_matcher_set_rtc_attr_sz(matcher, &rtc_attr, rtc_type, true);
+		hws_matcher_set_rtc_attr_sz(matcher, &rtc_attr, true);
 
 		ret = mlx5hws_cmd_rtc_create(ctx->mdev, &rtc_attr, rtc_1_id);
 		if (ret) {
@@ -338,16 +325,12 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 
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
 
@@ -357,18 +340,17 @@ static void hws_matcher_destroy_rtc(struct mlx5hws_matcher *matcher,
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
@@ -564,7 +546,6 @@ static int hws_matcher_bind_at(struct mlx5hws_matcher *matcher)
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


