Return-Path: <linux-rdma+bounces-8603-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF691A5DBF6
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 12:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 760CE3A6358
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 11:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507BF23F384;
	Wed, 12 Mar 2025 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N1qbR8qh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B7923A9BA;
	Wed, 12 Mar 2025 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780234; cv=fail; b=lefp39TiEL2a9+BtP8OTg9V+sNNeMLiTPK8yiISh9tN+M//X2sgJ/yCBOxAUxdEQoCI0dFs1enkK9dTZR+zmls65Pj4/cHSFAYorbJCKilrWU7qFgsKsnawuyVI0sAJGk+kpxj34R1+j/gVCA/BY+bpJpAPV1so/othBLCRr1qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780234; c=relaxed/simple;
	bh=L25bbeOXOtgoSBR8uD8uuSkXENDzYmGorhXr7Ubsy44=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpC4JTJ6riPXdWflbGB29axIC+bcW8n2ayBQHrMsbwzN5TicsJCO+9EYfNjGfK88WtsRB3uQ4NI7HPa5nXbDVVrJUg1ZhnxFcrmdW9Tg6E7ZkBRzVFHvcuVWHdoh3bw67S8sKBcQHOJ3mM4TQVPakR9JUzDrO5jSk8sNAxztFuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N1qbR8qh; arc=fail smtp.client-ip=40.107.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czMhpvtPbEgDhyweMjMifQI3OVVyIgOoatVpDcyAFOJlK5BKpuOy1xiSv7keyQQVkXdRoBdofTch9A++uHDAQ/5A8p3b775eGqaGcmhgcuUn0t/FGcT8/0l+m/UyWzKRfnAhJfADl55BB6vVQV9LG+zDAzSwr41BMCjA5+jFNhRk8DaeP9jkwektFizAudx42emxraY4uWkEA2vqHbOKLSiGeGPeQmoU1aJDvu7gmR0BYSyewuYhcx+Db4I45oNbUlsBu7wxWm6wa0ZNRyyeXpepv6ZPtaJLQHg2sHaCb64KHG6bTYUbeyGkHdffn/Sa0BvLNRoazxzgiusXwF0AnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YZgqj57GLXbFuCqYYx0SQQpmhcsAArjPzw93OpXd84=;
 b=cQTQ7yDp5pymID+iIgCeSbsfj5XBD2QORRepswiE9gTfrBWtYlpJrEDCWNTrhWHk3TaczgrmSHs2YR+CBv92vY+doifUDrWrUY/tyFo5Gb5FtIpoD5oiNr3twST2Ri9mAwMCuQVKRPAqgSh2wdjNo4h2rbdc1eMdDD0ytFIZI8B9uqmjEE78R3HFwEuO3C+Cn8J7BfloQlh9BkAuhuqcIrR0nUPXR30jo0CMMn2LsAV/yXIOIBx2TYsBXgERt2LyAnbARlhxUigMhd3fh7iSrQdM+cmVWQQ2tbLZNKYQUmrcP69KJ9+hPF/y33nWgiujrV2taEErvgMPF/QbJTFAfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YZgqj57GLXbFuCqYYx0SQQpmhcsAArjPzw93OpXd84=;
 b=N1qbR8qh+Lal0Vj3joi0HB961agkfPL9l7EGkeebCxKeFGoQ2vqgyahaeVzNTDilvx53+x2/cgY435m/HwmWsrTTlqd+4EQQoTdZieMhqsDAZcpFBYDid1+8P5F9GiX+bxiteWiLFAnCCKRjOmDuqbiekoGzRVz97/hU3HaT9QWg8WBa2Xa+aldGJzTte24BwI7e6R/kUGOyDiuOnaowVTdPUpJDMHSChje89plsiU4Pc9unSKfj7KmJIWAOGA18z2lqCbLPmja+NWKsltd4YGCGqYAySUwEQYHCsW0lbqqYNWztxdfzyaKvj54luOxn2zZ8daFerdEkqGLoWs6yhA==
Received: from SN7PR04CA0033.namprd04.prod.outlook.com (2603:10b6:806:120::8)
 by CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Wed, 12 Mar
 2025 11:50:28 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::5c) by SN7PR04CA0033.outlook.office365.com
 (2603:10b6:806:120::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Wed,
 12 Mar 2025 11:50:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 11:50:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Mar
 2025 04:50:17 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Mar
 2025 04:50:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 12
 Mar 2025 04:50:13 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [PATCH net-next 1/3] net/mlx5: HWS, remove unused code for alias flow tables
Date: Wed, 12 Mar 2025 13:49:52 +0200
Message-ID: <1741780194-137519-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1741780194-137519-1-git-send-email-tariqt@nvidia.com>
References: <1741780194-137519-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|CH2PR12MB4165:EE_
X-MS-Office365-Filtering-Correlation-Id: 99e19a48-46f0-4e15-d71c-08dd615c159e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qQr7UA8HtU1qjjX+hsQzNcUUJL0RN4fIUgTHNj6sDNI9pnT9lo17e1grrpmm?=
 =?us-ascii?Q?JEz+NB7Fms/hNVcvtzbLVge4uw1htX1fvdL4CgR9tOfb6b2G9guTFGQ09kTN?=
 =?us-ascii?Q?aVy0dDfX1PluCBthyMPLKS06Ar1KJDU1K6OnaMOx37XnOBQl4/jl0GpGUhHS?=
 =?us-ascii?Q?DzFqS8t4C+DN1hGG/erjGtKnMon8wUjy8w6gEI5ZYoBrlES27jMl3r5LgxT+?=
 =?us-ascii?Q?cVlSoL0g9VZepgARIARwpEPwMpwkPT4Wcpd9ltURt/52mpIWvaSaPrJlL24w?=
 =?us-ascii?Q?ywYtxaiD1J8xjXL2hRYNktOQFyUwYHJx8uHGYLU+QLdo612qzf30GDJFXlWJ?=
 =?us-ascii?Q?rMOuo9XjLKiArf4C072scjss30DjDiZjrd+lmcQc2loDA9vDDU/CizQsDAE7?=
 =?us-ascii?Q?jYL3HrgxkjnTPABvblhAmv0K/q6CLMvDWm2WvxzyeA7+sm4lXzOr1cIZYF6y?=
 =?us-ascii?Q?bOf7pcXrf9u4HvXTnCHfo359D55ceOV4fA0bmHQ5O7OTlPVpA5OTamYAcvxo?=
 =?us-ascii?Q?U64a4ZA7kzMQO/YV++6Do009wFsNrXfqg6lxfhZVaEDaMwSj13z2K/f4KkeB?=
 =?us-ascii?Q?ETmi1bCyTkQjzKRR/sWQ0Diq3+gMarU8QKjy0LdksoBOnALGenFrFfjh8AzZ?=
 =?us-ascii?Q?rM/TvQ4mfR5Y5/MJ2JHp/x+Ooqcha1p0ey/ULz6RLRxFx7Rn4zql8YZf8F+Y?=
 =?us-ascii?Q?BNI9HOzBot3a1tGYAI84w5DmXiREFjjp6oso1/t3Og5UaC/iJyAlQzdl4U8Z?=
 =?us-ascii?Q?vSE7JTACWEPHtHFyPz79uzwPObdRVEkKYpTYb+TSzAPZnGXydauHnJ7At6W4?=
 =?us-ascii?Q?7qRATtdTwh6rMnCbIjg7/i6QSVSYEKckseej48jtMt8Y5gsu37GRv/TBR3jg?=
 =?us-ascii?Q?0rAbWGnH+Cy22HiatHCGqkKgrkIuW0dvLAI78hF8UYPAotCkbGLpedyVLd4F?=
 =?us-ascii?Q?4o7BvlsewW5k0dACQprW9PsBq4zyowkCWTZWix1FzEB96jG2CbM8zm8GN+Hy?=
 =?us-ascii?Q?KZs+VLyzQu8wrjGLwgcyWbLShvdpxXYH3DqfwhneLIk18a6dVb+vVFcAz2b7?=
 =?us-ascii?Q?B8hd0nwPLz9Xys5zvAsw+77H/E28FrqM4f07xY2cdJR0NoxaqPLFpksznkqV?=
 =?us-ascii?Q?G5dn5mpMmn1oAauwwadn9DQtinXW4n3mb6WmokTyYAfUUoqyFunxsl5l3V7V?=
 =?us-ascii?Q?7D1YFB/P/4SI+FVr6J7eNjSGFjwGKUq7UvpVa+1OTnRjdMp0dYof6NG6dSo+?=
 =?us-ascii?Q?/wx4MMtHUiH+fT3i9icZmNvQkEP0cTcK1hor1c11n+fVcM63+NqhQOhZ8pO1?=
 =?us-ascii?Q?9kb02MxRSF7R2L9AQXdWioUwWHVAGgBnrt0vG/s765YWRhb1sny2Gl2KJ8i/?=
 =?us-ascii?Q?alvmzjBBxRiDHcwgooMkecymNaHbVBkivG2lSbbwI0KD60/MWEnprQ5qor7t?=
 =?us-ascii?Q?ZzRTrdLedqrcTwtoipRgciSufWMqey4samkzHRE8gYJG9Sg5t4j4w4xbAGdJ?=
 =?us-ascii?Q?3bL3GxwcdROQqhs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:50:28.2845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e19a48-46f0-4e15-d71c-08dd615c159e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Alias flow tables are not in use by HWS - remove the unused code.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c | 6 ------
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h | 3 ---
 2 files changed, 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
index 487e75476b0a..e8f98c109b99 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
@@ -130,12 +130,6 @@ int mlx5hws_cmd_flow_table_destroy(struct mlx5_core_dev *mdev,
 	return mlx5_cmd_exec_in(mdev, destroy_flow_table, in);
 }
 
-void mlx5hws_cmd_alias_flow_table_destroy(struct mlx5_core_dev *mdev,
-					  u32 table_id)
-{
-	hws_cmd_general_obj_destroy(mdev, MLX5_OBJ_TYPE_FT_ALIAS, table_id);
-}
-
 static int hws_cmd_flow_group_create(struct mlx5_core_dev *mdev,
 				     struct mlx5hws_cmd_fg_attr *fg_attr,
 				     u32 *group_id)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h
index 610c63d81ad9..51d9e0291ac1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h
@@ -258,9 +258,6 @@ int mlx5hws_cmd_flow_table_query(struct mlx5_core_dev *mdev,
 int mlx5hws_cmd_flow_table_destroy(struct mlx5_core_dev *mdev,
 				   u8 fw_ft_type, u32 table_id);
 
-void mlx5hws_cmd_alias_flow_table_destroy(struct mlx5_core_dev *mdev,
-					  u32 table_id);
-
 int mlx5hws_cmd_rtc_create(struct mlx5_core_dev *mdev,
 			   struct mlx5hws_cmd_rtc_create_attr *rtc_attr,
 			   u32 *rtc_id);
-- 
2.31.1


