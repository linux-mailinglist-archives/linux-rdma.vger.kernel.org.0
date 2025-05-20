Return-Path: <linux-rdma+bounces-10450-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD142ABE319
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 20:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006013BAC48
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 18:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA9127054F;
	Tue, 20 May 2025 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LQecFnp1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D383248F75;
	Tue, 20 May 2025 18:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747766859; cv=fail; b=Z2+kUYZv0cTyQGqRailBVmxc88H1aHUx3pNWMooBJW7CGXstwS+tp9uePnciPmJNInjOoqmVn8S+3UDt8+/7bse8hDbVJqDf2clWg1D48rZbkAl0G+cZ7A92TichRqPz2U3nY4OSHWPBGbgph0PWrIL3zEBMfmKclAfWkuQAu+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747766859; c=relaxed/simple;
	bh=72BRmgZDwMp4HT9LU2xf9HGhqTEMUPULAtVgj2vN9x4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3/ndlHTRgESvuEN4Vm1S2dqVUEgebmudlQmalp7Fz0mWSCFNOFxaxshxSae2472aCMz6jLrCNgLb4hcw3kEkSLfm9U+JZ5HjFhKcRP2kztCUNss6gA9GxLSzoKJSLfLX9SIPBIoZCtTIP9FAY9g5cmgvH49LFgw7Ww7DPT7wiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LQecFnp1; arc=fail smtp.client-ip=40.107.96.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNRQM9RE/TBOgZRBu4XsW1nrPxIuv9OqZMqEnYalVMRgRcuefkKV4HD/hkACRawoAbje9sGf38Dwa17juc0Vg9kGlL6m/hzbKoMk85026qtgQl53YNqlhQZAebbyvDmMi8t/kAEDcD6wDHaM4m5hZnHIQts9DtPDuE3Zs+J/cH54uASgNh5RvpbE/+8zNAbvzwb1xARvodbm0GFyO2GMWDt9nj3Wka1lximWSvlHqF9eplSJ0Ntmq6LWCw2195lQn8XfBUwvkiKrUAX3bpKrg6V5/sTkqRhmwOAoXz5gHOnBQO7b/c7MToTM5hoq6A73CW/IsAHb85c4wuJC91RvEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWo9GcRuO+9eyKK9n7x1SCAjaDyayUyXKa7H2r9SJ5Y=;
 b=vYlzWnLCuB/CTd7iC6LlI2NIr2FGqi1VriM6/UxGY7nN3t/kDuxq6mxOdYjV5nFrvVct7kxB4+4RtgmSiQi7ZPl34jGE03dYB4nUH6pwJsGLHtEaXIi/upnkmLg/IqGwtUY3P9xD896tN4eqOFVpvAP1yFuwMflRH6wbtZujUQSVfGzv0cU7fMf8qFQUE15C7+rjogzyclEYOULd72omgPMY/z+k/W05KoCzlPZabYFfJmZ8C+nLyOLTsBqY7/PxtCaJKwuwbvnjJTWGVVYXy/4HoTCQf+i+Rkraz23PrJrKkmanHneFHrTevOFHQBsBxJoLP2B6gtcmCOUgc4AIwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWo9GcRuO+9eyKK9n7x1SCAjaDyayUyXKa7H2r9SJ5Y=;
 b=LQecFnp1zytlqof9xffgBvwTHm3qqTDvRlEaqZDCuc9IEuUdgjXXPL/79Xjsy8dAJDZPu66T/jOFqnmiCGvkp2pjPaypVRORaDexoX5GPWhidn5G4elXrcQcwH/wD02aUtqET6xpRiDFyIRY75B67LjT7wBeAkyHfDHiyNH8GuGTXYrAvnTVVzZNMpBez0rPHxUVG7R4IBYj+Xb7JbpB4UqOXsU70TzN/s/hEBD9aj1M+5/YetoWGZC5PzxVnEBxd3TCjvlz792uOcCGKFsKjVvEl76JqA9ARoyOq1Ci13Jk8C8Y7Xq1Z+JxPmx/xIXV4yFLqRSxjrWNeOi2FZkYSQ==
Received: from PH8P221CA0041.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::13)
 by BN7PPF3C1137D8A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 20 May
 2025 18:47:29 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:510:346:cafe::33) by PH8P221CA0041.outlook.office365.com
 (2603:10b6:510:346::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 20 May 2025 18:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.4 via Frontend Transport; Tue, 20 May 2025 18:47:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 May
 2025 11:47:10 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 20 May
 2025 11:47:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 20
 May 2025 11:47:06 -0700
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
Subject: [PATCH net-next 2/4] net/mlx5: HWS, register reformat actions with fw
Date: Tue, 20 May 2025 21:46:40 +0300
Message-ID: <1747766802-958178-3-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|BN7PPF3C1137D8A:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b8cff2-1b36-405c-190d-08dd97cec576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1idv8MVPmIE4jFxrvLTENKinNx4WXQyS1k0j/uYDnolDtY6DN3D2Z0QD5dAC?=
 =?us-ascii?Q?QFWnRcDpqORJu/i1iiQ20+iNhZ17Cly3gpZtFSDpLgb1Z6Fmt3HlnYhEAHR7?=
 =?us-ascii?Q?Q924j+METtF2+gaT4cx+z2vOW/BhFuh26rovbV3UNJNjfKw4PJVGitu7kXlm?=
 =?us-ascii?Q?udL7p64d2ryDl6bktRmiaqJ1SZI161ArugDUqpobVoWPgQ6iWsLLVXCw2Pxt?=
 =?us-ascii?Q?4gI1O0W8EOoi77KCZfMAJszJqctV4KRUK2wrtyTwHgiYACuKkP/RlW2gFt8n?=
 =?us-ascii?Q?wRyopVJL7a2KLySGY5BXR9/gH1Au5X3GUHosVrEhaV+z7XsOBkZEjlAmSnZm?=
 =?us-ascii?Q?OXCCDBDx6aUuiwdvrkAaRcj9lMH0dgSSm7VofUUfatj+2VKx+M3RIqYP7ETv?=
 =?us-ascii?Q?mBmxmADxBb1pa5trGUMMn0pG9R3IGe/546B/GhTa9GfM7dV2zZKVbdkqVP6T?=
 =?us-ascii?Q?YN+qXAq2St6zwfYbIo9lqv2uNyfgMC5BvCirP0CFdZkVbTOAJtLb7XDWVsYw?=
 =?us-ascii?Q?2Y2udrXd8HWTRbVLRsyPntWwdR3Rm9znhUMCmqz8bYzsJHYqV10XS5+3+veg?=
 =?us-ascii?Q?zdl4qZaw6hUYK91OQ4cEfEe+N5b/Dd6hJT5/r6+ydw3+ggQfebZRaZqzKraT?=
 =?us-ascii?Q?0Fz+NSrsFs/5E5r4JIV1bX3tRRSZTnuYkCvcgCiBaxfL5Q6frzOPCulUTnH6?=
 =?us-ascii?Q?rS3XTICUVMoTpF4CNvdSFCwpjnNRqANV1jcylRgt6eGwyYs7om9/lilo4noE?=
 =?us-ascii?Q?K41RGxEGjS7djcDs2c7vIhvK1G/2MIhHS62FeRDmwdz3pLlS5w76hy/LgGAX?=
 =?us-ascii?Q?+Az3Nm5lmRioG4Upwn033pxn6IZbTlaTNyGwCLjtUX1UHAUnscQ+ffX9MUTU?=
 =?us-ascii?Q?iq/D3zMLIqbDzlFqQhx0oQS6FaihyBNafQ4Dvl1rgnrfWo4v3QTxYZm1fqff?=
 =?us-ascii?Q?eYV1w5vOJsCGQUw1oVn025dK2EWv6cAUrSAJcq4FBAgmX29g7LkwqFfVYZ6i?=
 =?us-ascii?Q?9AAftGAf1yzdB0AGos15RGVADDk9K2Vc0eNSqt7UaRfqN3JI8krAUN9lo/TX?=
 =?us-ascii?Q?S2uuRHuysbIW1PcMMulbl2s0Guu0VN6LyUmYcOaOEeWqoI8F8sZ9Zu3TN5NV?=
 =?us-ascii?Q?j5zQCebHEz1F7s7Y7A3vLrDOtIhpIYLIPNgIQynzR7zG0G2vFEozpwJB7vLR?=
 =?us-ascii?Q?QCPGg4oaJybrPsFHHZhK53PeOhIXWSWzvZ0FU3R9BTJ/d4db29cD00UipDMf?=
 =?us-ascii?Q?rz8mmGhuXbWN9US9xKvBi7vdT0+uCwGFQTTUrBaHSX8F+/YKH41A0pT3cN4h?=
 =?us-ascii?Q?SL9e1vFqXsWcWaFGBMGUcK5GkLXS1dGYPe0Mjdr8vSVQ9WEy+iUlwhlbHsiO?=
 =?us-ascii?Q?aOwlSoidqr4J4xxL/v2cvLgr9BEZ8S2t9UX/6CgI0UiinbhfXkpIysEOaz86?=
 =?us-ascii?Q?z0m3SmvayqB6GWIYPVYZwvdvkCAHY26LADdbp/NDTcsH1vqsnuey/MoFOifG?=
 =?us-ascii?Q?6+/O31Qw3A2HAFEo4cZaIrr7QfBplW1IgwDh?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 18:47:28.7003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b8cff2-1b36-405c-190d-08dd97cec576
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF3C1137D8A

From: Vlad Dogaru <vdogaru@nvidia.com>

Hardware steering handles actions differently from firmware, but for
termination rules that use encapsulation the firmware needs to be aware
of the action.

Fix this by registering reformat actions with the firmware the first
time this is needed. To do this, add a third possible owner for an
action, and also a lock to protect against registration of the same
action from different threads.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  2 +
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |  1 +
 .../mellanox/mlx5/core/steering/hws/action.c  |  5 ++
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 71 +++++++++++++++++--
 .../mellanox/mlx5/core/steering/hws/fs_hws.h  | 16 +++++
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h |  9 +++
 6 files changed, 97 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index a81b81a3b8f0..23a7e8e7adfa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -1839,6 +1839,8 @@ int mlx5_fs_get_packet_reformat_id(struct mlx5_pkt_reformat *pkt_reformat,
 		return 0;
 	case MLX5_FLOW_RESOURCE_OWNER_SW:
 		return mlx5_fs_dr_action_get_pkt_reformat_id(pkt_reformat, id);
+	case MLX5_FLOW_RESOURCE_OWNER_HWS:
+		return mlx5_fs_hws_action_get_pkt_reformat_id(pkt_reformat, id);
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 248a74108fb1..500826229b0b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -58,6 +58,7 @@ struct mlx5_flow_definer {
 enum mlx5_flow_resource_owner {
 	MLX5_FLOW_RESOURCE_OWNER_FW,
 	MLX5_FLOW_RESOURCE_OWNER_SW,
+	MLX5_FLOW_RESOURCE_OWNER_HWS,
 };
 
 struct mlx5_modify_hdr {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
index bef4d25c1a2a..aa47a7af6f50 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
@@ -72,6 +72,11 @@ enum mlx5hws_action_type mlx5hws_action_get_type(struct mlx5hws_action *action)
 	return action->type;
 }
 
+struct mlx5_core_dev *mlx5hws_action_get_dev(struct mlx5hws_action *action)
+{
+	return action->ctx->mdev;
+}
+
 static int hws_action_get_shared_stc_nic(struct mlx5hws_context *ctx,
 					 enum mlx5hws_context_shared_stc_type stc_type,
 					 u8 tbl_type)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index 1b787cd66e6f..9d1c0e4b224a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -1081,13 +1081,8 @@ static int mlx5_cmd_hws_create_fte(struct mlx5_flow_root_namespace *ns,
 	struct mlx5hws_bwc_rule *rule;
 	int err = 0;
 
-	if (mlx5_fs_cmd_is_fw_term_table(ft)) {
-		/* Packet reformat on terminamtion table not supported yet */
-		if (fte->act_dests.action.action &
-		    MLX5_FLOW_CONTEXT_ACTION_PACKET_REFORMAT)
-			return -EOPNOTSUPP;
+	if (mlx5_fs_cmd_is_fw_term_table(ft))
 		return mlx5_fs_cmd_get_fw_cmds()->create_fte(ns, ft, group, fte);
-	}
 
 	err = mlx5_fs_fte_get_hws_actions(ns, ft, group, fte, &ractions);
 	if (err)
@@ -1362,7 +1357,7 @@ mlx5_cmd_hws_packet_reformat_alloc(struct mlx5_flow_root_namespace *ns,
 		pkt_reformat->fs_hws_action.pr_data = pr_data;
 	}
 
-	pkt_reformat->owner = MLX5_FLOW_RESOURCE_OWNER_SW;
+	pkt_reformat->owner = MLX5_FLOW_RESOURCE_OWNER_HWS;
 	pkt_reformat->fs_hws_action.hws_action = hws_action;
 	return 0;
 
@@ -1380,6 +1375,15 @@ static void mlx5_cmd_hws_packet_reformat_dealloc(struct mlx5_flow_root_namespace
 	struct mlx5_fs_hws_pr *pr_data;
 	struct mlx5_fs_pool *pr_pool;
 
+	if (pkt_reformat->fs_hws_action.fw_reformat_id != 0) {
+		struct mlx5_pkt_reformat fw_pkt_reformat = { 0 };
+
+		fw_pkt_reformat.id = pkt_reformat->fs_hws_action.fw_reformat_id;
+		mlx5_fs_cmd_get_fw_cmds()->
+			packet_reformat_dealloc(ns, &fw_pkt_reformat);
+		pkt_reformat->fs_hws_action.fw_reformat_id = 0;
+	}
+
 	if (pkt_reformat->reformat_type == MLX5_REFORMAT_TYPE_REMOVE_HDR)
 		return;
 
@@ -1499,6 +1503,7 @@ static int mlx5_cmd_hws_modify_header_alloc(struct mlx5_flow_root_namespace *ns,
 		err = -ENOMEM;
 		goto release_mh;
 	}
+	mutex_init(&modify_hdr->fs_hws_action.lock);
 	modify_hdr->fs_hws_action.mh_data = mh_data;
 	modify_hdr->fs_hws_action.fs_pool = pool;
 	modify_hdr->owner = MLX5_FLOW_RESOURCE_OWNER_SW;
@@ -1532,6 +1537,58 @@ static void mlx5_cmd_hws_modify_header_dealloc(struct mlx5_flow_root_namespace *
 	modify_hdr->fs_hws_action.mh_data = NULL;
 }
 
+int
+mlx5_fs_hws_action_get_pkt_reformat_id(struct mlx5_pkt_reformat *pkt_reformat,
+				       u32 *reformat_id)
+{
+	enum mlx5_flow_namespace_type ns_type = pkt_reformat->ns_type;
+	struct mutex *lock = &pkt_reformat->fs_hws_action.lock;
+	u32 *id = &pkt_reformat->fs_hws_action.fw_reformat_id;
+	struct mlx5_pkt_reformat fw_pkt_reformat = { 0 };
+	struct mlx5_pkt_reformat_params params = { 0 };
+	struct mlx5_flow_root_namespace *ns;
+	struct mlx5_core_dev *dev;
+	int ret;
+
+	mutex_lock(lock);
+
+	if (*id != 0) {
+		*reformat_id = *id;
+		ret = 0;
+		goto unlock;
+	}
+
+	dev = mlx5hws_action_get_dev(pkt_reformat->fs_hws_action.hws_action);
+	if (!dev) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	ns = mlx5_get_root_namespace(dev, ns_type);
+	if (!ns) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	params.type = pkt_reformat->reformat_type;
+	params.size = pkt_reformat->fs_hws_action.pr_data->data_size;
+	params.data = pkt_reformat->fs_hws_action.pr_data->data;
+
+	ret = mlx5_fs_cmd_get_fw_cmds()->
+		packet_reformat_alloc(ns, &params, ns_type, &fw_pkt_reformat);
+	if (ret)
+		goto unlock;
+
+	*id = fw_pkt_reformat.id;
+	*reformat_id = *id;
+	ret = 0;
+
+unlock:
+	mutex_unlock(lock);
+
+	return ret;
+}
+
 static int mlx5_cmd_hws_create_match_definer(struct mlx5_flow_root_namespace *ns,
 					     u16 format_id, u32 *match_mask)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
index 8b56298288da..b92d55b2d147 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
@@ -41,6 +41,11 @@ struct mlx5_fs_hws_action {
 	struct mlx5_fs_pool *fs_pool;
 	struct mlx5_fs_hws_pr *pr_data;
 	struct mlx5_fs_hws_mh *mh_data;
+	u32 fw_reformat_id;
+	/* Protect `fw_reformat_id` against being initialized from multiple
+	 * threads.
+	 */
+	struct mutex lock;
 };
 
 struct mlx5_fs_hws_matcher {
@@ -84,12 +89,23 @@ void mlx5_fs_put_hws_action(struct mlx5_fs_hws_data *fs_hws_data);
 
 #ifdef CONFIG_MLX5_HW_STEERING
 
+int
+mlx5_fs_hws_action_get_pkt_reformat_id(struct mlx5_pkt_reformat *pkt_reformat,
+				       u32 *reformat_id);
+
 bool mlx5_fs_hws_is_supported(struct mlx5_core_dev *dev);
 
 const struct mlx5_flow_cmds *mlx5_fs_cmd_get_hws_cmds(void);
 
 #else
 
+static inline int
+mlx5_fs_hws_action_get_pkt_reformat_id(struct mlx5_pkt_reformat *pkt_reformat,
+				       u32 *reformat_id)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline bool mlx5_fs_hws_is_supported(struct mlx5_core_dev *dev)
 {
 	return false;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
index fbd63369da10..9bbadc4d8a0b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
@@ -503,6 +503,15 @@ int mlx5hws_rule_action_update(struct mlx5hws_rule *rule,
 enum mlx5hws_action_type
 mlx5hws_action_get_type(struct mlx5hws_action *action);
 
+/**
+ * mlx5hws_action_get_dev - Get mlx5 core device.
+ *
+ * @action: The action to get the device from.
+ *
+ * Return: mlx5 core device.
+ */
+struct mlx5_core_dev *mlx5hws_action_get_dev(struct mlx5hws_action *action);
+
 /**
  * mlx5hws_action_create_dest_drop - Create a direct rule drop action.
  *
-- 
2.31.1


