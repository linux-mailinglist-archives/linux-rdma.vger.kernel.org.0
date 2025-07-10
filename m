Return-Path: <linux-rdma+bounces-12019-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631D4AFFA33
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 08:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53F05450B9
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 06:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27986289835;
	Thu, 10 Jul 2025 06:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hAGSFxLg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B82B288C18;
	Thu, 10 Jul 2025 06:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752130361; cv=fail; b=keKnnZpuYr2zwVTENc3prQlkbpWpz8C5g1PX9rJQ6cJxsBmYE+gfs1OPaU000aUStDAr99o7xvkfc2yOtZ2sYmF6FqX+ty9YSb01pH1caf3z+szhmhB1VciA4J1NsmyTR91tef7UfUworqG80K4wYKrOaCLQqN8AYdymxDmny88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752130361; c=relaxed/simple;
	bh=CH2gBlPqxE04QkIWbtGgHzhhNXQD5QacitJEHnTrcc0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4x73rtGMGu3yFJVvaId/QqNzDb4x3P2SLM+3tTytplo/Bj6ZXDLEVA8ap7u606zra0EXTd/B1BKZj4jH9DD0SRJcdF0B7eD6BMJBXT+0HlTrof+Jhbzp3oENkJJyDXENrfRIL5qmS45VLDvv/qTprAkvVbUSwMuiZuwBfrJCbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hAGSFxLg; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXaYAeFyxapG03nzjab9EhRIv9e508A3kQ4jm/UhR2Z0LZKk8BRcSEs6K4jQTEGlJv7ovPUfeLfCmA7E8JVoy+jkrsMDC9QPBC1bNNQj9McppoepdDtqokuqoMd8I/+uF8rNhsi1SYYsAs9SfOpYx15MT8zuWzfr2rz0PFx37KtMCgFYDjHNGAqyIWEBVK3jyRRUrtgAi+cp8Hq/CCaVW/m/smvcImHMIb4znGik8JQS/jO8YN6VSJjQtqVO70K7zJFqwoVBu9bgVRUOGkIR5xlB1aTwdLxbTOpSr1lKLG4qbgQmfrq6lhjJHqsn+R4Y89E84d8fg+K/jQVJKBYW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsqjDe8E5qc7syhD27uZQvs7T/gaINEWypmm/iczSSw=;
 b=bJedqgRqvo4QSwoI43EY1hS9pDCSJrFM8KnfKVUcu22KT+cFTWZDK9smWmkmlG5wuKQ5+jQGaq/T2q+U5+YMkCpZX7hSr7gva+239ZiHVSO1hREGJoI/j87AW6Qw4WVfR0pdNvwqLEpZgGDM4TigpaDcSUbdIlMjnsBAY1UYIKv/+vAXXG4uSf8ihr1NcRXk6q/YH+KWY9KrNSgVfuTHQWxlBGSUCPKpjab2iccfuVjvgaTYdF2prj2oRU5bfM1yQ9oGie/T97lBih0HytNMo8QJXuUfM33oXVaLoJIXybcynPquo53UiUDnE7mbyCMNnw+RdyxAC7L4n6CJfU12Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsqjDe8E5qc7syhD27uZQvs7T/gaINEWypmm/iczSSw=;
 b=hAGSFxLgot1oG6q4Lcg4URUT3DROjZbfht1ITrlHPYeX1e9jDHcg57LQor14T57wPa0Qapav8IXOpeSwwp578ABHOrlZwUhPHpoKRNUgaU79NYQ5WTMjkyaGWK6aabyU+qtXTSXrckubyv5AibRKDYH75z316NCuDTjiljFczZgmZj3z5OBRnpbDYSZWum5Ap9RqRcFDi51AcvlOsi7dC/EDg7Wl2uA/3CCXi2T9IAOFtrChxJ2jaQ6C/fRdOX2Z2Hzy2nNrOMbBPk661l1MaMBTxDWWOLSk6eRlS31lM5Rg7D1WugtQO0QOA1E2Uwce88NXXzPgx4psArKMwYPCYQ==
Received: from CH0PR03CA0449.namprd03.prod.outlook.com (2603:10b6:610:10e::25)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 10 Jul
 2025 06:52:34 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::ac) by CH0PR03CA0449.outlook.office365.com
 (2603:10b6:610:10e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 06:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:52:33 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 23:52:20 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 23:52:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 9 Jul
 2025 23:52:16 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Jonathan Corbet
	<corbet@lwn.net>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next V2 3/3] net/mlx5e: Make PCIe congestion event thresholds configurable
Date: Thu, 10 Jul 2025 09:51:32 +0300
Message-ID: <1752130292-22249-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752130292-22249-1-git-send-email-tariqt@nvidia.com>
References: <1752130292-22249-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: b37f2184-99ca-4a8f-f690-08ddbf7e5944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mYBRqVCpC7D/XYdHvEAx6MBBzr/sDbPeqp1E2EHZpdJR5r1/RbY8cBgpdyrD?=
 =?us-ascii?Q?8ESqxJOdGsJDq/NJnq5LvT+xjwdK3m11jUM4OXIvyJiMy1FtbwDmTxDig6J7?=
 =?us-ascii?Q?UivYCsmQ1U04iOOa+XSetJV54k/h/p/7/LHsYPPpcgyzpavtek1cMTi8XLUd?=
 =?us-ascii?Q?dTOb9m+9/v4ACOXmM5z1XdSowntS6v1tI+9lP4hRREHQwJ6Ewr6s/yCcD6Mf?=
 =?us-ascii?Q?L1JJzKTrAHNXspvEVGTvzjFgRMQNVg6/3mHBNAB3VlegGGlxm3Q2S/03Yj8e?=
 =?us-ascii?Q?CRDpass408eVpR3OhelSp0mxNt6mCfA/sWJGt+khZQMiks0Yu0yIDhj57SX6?=
 =?us-ascii?Q?OgMIGZBL3URLWrTilmY5t9QelznWwtIuhKbea9ET16/RTXDPKoMcPo6AcTTk?=
 =?us-ascii?Q?4fdLNJYHxrJMaOoHn48QiDiXC4K7kBa7wnY739ITogch0S9X9XvYLpdxiJ13?=
 =?us-ascii?Q?JFFy1Hs9FeODAd0msuCnkTMxLWC05z5BccgZnhMuWcFU4G/f0iKQqnT2b/Pm?=
 =?us-ascii?Q?m+ha/1s3tpj+Czw3QGFDQQl4BnwISrEA9N6UcG6+fi4e6KSCifvp7+aCCZT5?=
 =?us-ascii?Q?+ZVZetO4E2fGtHR1ymAr82HTobbnwNp4x+aS79r90TT3fE8jyylPfWBd0DCi?=
 =?us-ascii?Q?HegkQnyDtvWCVm/gqief+37Ea8d+3CAvzaJACJlnECJ8zdRBBsLH8FZJ1znY?=
 =?us-ascii?Q?ptiByQYghnCnqg+rrBbfKsFhN/UQs+3G7Br4RWMxxnWUd77EfpaV2vTip6fq?=
 =?us-ascii?Q?UZ6QkvhqTsc9OZKx2VUgLKmzz7NaXqVhmgWQSEAbdcWutwXOSqkegX6NbXRV?=
 =?us-ascii?Q?duUlvNgTx7zVN9DAZqz2IMVl2OstP0D4frVXQPOOuIwH5MYKlQ7QGFZT9laf?=
 =?us-ascii?Q?4ekmWxLXArNrigQEdzgMAicz8GpnhhsiHOB7nBPpw3H/B5BF7zRKKQHDIByS?=
 =?us-ascii?Q?NJ4eYjyBmpj17DGcw1+BRhN0rR9i1x+ijuvrfjLwDDyzeGEm2HaE0XTDxJaC?=
 =?us-ascii?Q?juG1FJanryAr4T6P8GHzBM4RAZgeZxRNWrsKkm0UapOF2UkUClhbKNin8o4o?=
 =?us-ascii?Q?PpBvPu04QI6W0YY5d73aSNpudvRwMiChkSLeulKTiDS/czUh4eOgtq2waviw?=
 =?us-ascii?Q?akmQ0Y8Cd8AjaCV/vc/aTQ6yMYv5R0pgT+kbx9UGmKCWVEX1BkKN6Wa9hVrE?=
 =?us-ascii?Q?8aafDFqfe+EGWJG+QRPFV0vqASQ7FJFIolpArCOzx7bL1/Wyrau3qx+IXmqq?=
 =?us-ascii?Q?7d1DLsO0QITyojN3jMx9sG9tHs/Quh/z6hp2/aXU36gnLCsSQpjuW1EDUJKK?=
 =?us-ascii?Q?IkmHuMCED9gaNH2rM3Tss+Vss+cSNiblkagAK+7oonrfuCFincYf1TThiem2?=
 =?us-ascii?Q?NG6ElXkCmdxefYSVIB6tPlP8N/Wpr1Wc+FanTa0pqwpRRMYqYOw1om0tINp1?=
 =?us-ascii?Q?j0M8QbsJ6GEZaLLJBF1G48heNfkhIMj45yj5jaCPYUj7FsmA4BIrjzc+HZkC?=
 =?us-ascii?Q?qU4ibKvYRfV1J50O5GGx20/a3bVfXCnFytgz?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:52:33.9330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b37f2184-99ca-4a8f-f690-08ddbf7e5944
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525

From: Dragos Tatulea <dtatulea@nvidia.com>

Add a new sysfs entry for reading and configuring the PCIe congestion
event thresholds. The format is the following:
<inbound_low> <inbound_high> <outbound_low> <outbound_high>

Units are 0.01 %. Accepted values are in range (0, 10000].

When new thresholds are configured, a object modify operation will
happen. The set function is updated accordingly to act as a modify
as well.

The threshold configuration is stored and queried directly
in the firmware.

To prevent fat fingering the numbers, read them initially as u64.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en/pcie_cong_event.c   | 152 +++++++++++++++++-
 1 file changed, 144 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
index a24e5465ceeb..a74d1e15c92e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
@@ -39,9 +39,13 @@ struct mlx5e_pcie_cong_event {
 
 	/* For ethtool stats group. */
 	struct mlx5e_pcie_cong_stats stats;
+
+	struct device_attribute attr;
 };
 
 /* In units of 0.01 % */
+#define MLX5E_PCIE_CONG_THRESH_MAX 10000
+
 static const struct mlx5e_pcie_cong_thresh default_thresh_config = {
 	.inbound_high = 9000,
 	.inbound_low = 7500,
@@ -97,6 +101,7 @@ MLX5E_DEFINE_STATS_GRP(pcie_cong, 0);
 static int
 mlx5_cmd_pcie_cong_event_set(struct mlx5_core_dev *dev,
 			     const struct mlx5e_pcie_cong_thresh *config,
+			     bool modify,
 			     u64 *obj_id)
 {
 	u32 in[MLX5_ST_SZ_DW(pcie_cong_event_cmd_in)] = {};
@@ -108,8 +113,16 @@ mlx5_cmd_pcie_cong_event_set(struct mlx5_core_dev *dev,
 	hdr = MLX5_ADDR_OF(pcie_cong_event_cmd_in, in, hdr);
 	cong_obj = MLX5_ADDR_OF(pcie_cong_event_cmd_in, in, cong_obj);
 
-	MLX5_SET(general_obj_in_cmd_hdr, hdr, opcode,
-		 MLX5_CMD_OP_CREATE_GENERAL_OBJECT);
+	if (!modify) {
+		MLX5_SET(general_obj_in_cmd_hdr, hdr, opcode,
+			 MLX5_CMD_OP_CREATE_GENERAL_OBJECT);
+	} else {
+		MLX5_SET(general_obj_in_cmd_hdr, hdr, opcode,
+			 MLX5_CMD_OP_MODIFY_GENERAL_OBJECT);
+		MLX5_SET(general_obj_in_cmd_hdr, in, obj_id, *obj_id);
+		MLX5_SET64(pcie_cong_event_obj, cong_obj, modify_select_field,
+			   MLX5_PCIE_CONG_EVENT_MOD_THRESH);
+	}
 
 	MLX5_SET(general_obj_in_cmd_hdr, hdr, obj_type,
 		 MLX5_GENERAL_OBJECT_TYPES_PCIE_CONG_EVENT);
@@ -131,10 +144,12 @@ mlx5_cmd_pcie_cong_event_set(struct mlx5_core_dev *dev,
 	if (err)
 		return err;
 
-	*obj_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
+	if (!modify)
+		*obj_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
 
-	mlx5_core_dbg(dev, "PCIe congestion event (obj_id=%llu) created. Config: in: [%u, %u], out: [%u, %u]\n",
+	mlx5_core_dbg(dev, "PCIe congestion event (obj_id=%llu) %s. Config: in: [%u, %u], out: [%u, %u]\n",
 		      *obj_id,
+		      modify ? "modified" : "created",
 		      config->inbound_high, config->inbound_low,
 		      config->outbound_high, config->outbound_low);
 
@@ -160,13 +175,13 @@ static int mlx5_cmd_pcie_cong_event_destroy(struct mlx5_core_dev *dev,
 
 static int mlx5_cmd_pcie_cong_event_query(struct mlx5_core_dev *dev,
 					  u64 obj_id,
-					  u32 *state)
+					  u32 *state,
+					  struct mlx5e_pcie_cong_thresh *config)
 {
 	u32 in[MLX5_ST_SZ_DW(pcie_cong_event_cmd_in)] = {};
 	u32 out[MLX5_ST_SZ_DW(pcie_cong_event_cmd_out)];
 	void *obj;
 	void *hdr;
-	u8 cong;
 	int err;
 
 	hdr = MLX5_ADDR_OF(pcie_cong_event_cmd_in, in, hdr);
@@ -184,6 +199,8 @@ static int mlx5_cmd_pcie_cong_event_query(struct mlx5_core_dev *dev,
 	obj = MLX5_ADDR_OF(pcie_cong_event_cmd_out, out, cong_obj);
 
 	if (state) {
+		u8 cong;
+
 		cong = MLX5_GET(pcie_cong_event_obj, obj, inbound_cong_state);
 		if (cong == MLX5E_CONG_HIGH_STATE)
 			*state |= MLX5E_INBOUND_CONG;
@@ -193,6 +210,19 @@ static int mlx5_cmd_pcie_cong_event_query(struct mlx5_core_dev *dev,
 			*state |= MLX5E_OUTBOUND_CONG;
 	}
 
+	if (config) {
+		*config = (struct mlx5e_pcie_cong_thresh) {
+			.inbound_low = MLX5_GET(pcie_cong_event_obj, obj,
+						inbound_cong_low_threshold),
+			.inbound_high = MLX5_GET(pcie_cong_event_obj, obj,
+						inbound_cong_high_threshold),
+			.outbound_low = MLX5_GET(pcie_cong_event_obj, obj,
+						 outbound_cong_low_threshold),
+			.outbound_high = MLX5_GET(pcie_cong_event_obj, obj,
+						  outbound_cong_high_threshold),
+		};
+	}
+
 	return 0;
 }
 
@@ -210,7 +240,7 @@ static void mlx5e_pcie_cong_event_work(struct work_struct *work)
 	dev = priv->mdev;
 
 	err = mlx5_cmd_pcie_cong_event_query(dev, cong_event->obj_id,
-					     &new_cong_state);
+					     &new_cong_state, NULL);
 	if (err) {
 		mlx5_core_warn(dev, "Error %d when querying PCIe cong event object (obj_id=%llu).\n",
 			       err, cong_event->obj_id);
@@ -249,6 +279,101 @@ static int mlx5e_pcie_cong_event_handler(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static bool mlx5e_thresh_check_val(u64 val)
+{
+	return val > 0 && val <= MLX5E_PCIE_CONG_THRESH_MAX;
+}
+
+static bool
+mlx5e_thresh_config_check_order(const struct mlx5e_pcie_cong_thresh *config)
+{
+	if (config->inbound_high <= config->inbound_low)
+		return false;
+
+	if (config->outbound_high <= config->outbound_low)
+		return false;
+
+	return true;
+}
+
+#define MLX5E_PCIE_CONG_THRESH_SYSFS_VALUES 4
+
+static ssize_t thresh_config_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf,
+				   size_t count)
+{
+	struct mlx5e_pcie_cong_thresh config = {};
+	struct mlx5e_pcie_cong_event *cong_event;
+	u64 outbound_high, outbound_low;
+	u64 inbound_high, inbound_low;
+	struct mlx5e_priv *priv;
+	int ret;
+	int err;
+
+	cong_event = container_of(attr, struct mlx5e_pcie_cong_event, attr);
+	priv = cong_event->priv;
+
+	ret = sscanf(buf, "%llu %llu %llu %llu",
+		     &inbound_low, &inbound_high,
+		     &outbound_low, &outbound_high);
+	if (ret != MLX5E_PCIE_CONG_THRESH_SYSFS_VALUES) {
+		mlx5_core_err(priv->mdev, "Invalid format for PCIe congestion threshold configuration. Expected %d, got %d.\n",
+			      MLX5E_PCIE_CONG_THRESH_SYSFS_VALUES, ret);
+		return -EINVAL;
+	}
+
+	if (!mlx5e_thresh_check_val(inbound_high) ||
+	    !mlx5e_thresh_check_val(inbound_low) ||
+	    !mlx5e_thresh_check_val(outbound_high) ||
+	    !mlx5e_thresh_check_val(outbound_low)) {
+		mlx5_core_err(priv->mdev, "Invalid values for PCIe congestion threshold configuration. Valid range [1, %d]\n",
+			      MLX5E_PCIE_CONG_THRESH_MAX);
+		return -EINVAL;
+	}
+
+	config = (struct mlx5e_pcie_cong_thresh) {
+		.inbound_low = inbound_low,
+		.inbound_high = inbound_high,
+		.outbound_low = outbound_low,
+		.outbound_high = outbound_high,
+
+	};
+
+	if (!mlx5e_thresh_config_check_order(&config)) {
+		mlx5_core_err(priv->mdev, "Invalid order of values for PCIe congestion threshold configuration.\n");
+		return -EINVAL;
+	}
+
+	err = mlx5_cmd_pcie_cong_event_set(priv->mdev, &config,
+					   true, &cong_event->obj_id);
+
+	return err ? err : count;
+}
+
+static ssize_t thresh_config_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct mlx5e_pcie_cong_event *cong_event;
+	struct mlx5e_pcie_cong_thresh config;
+	struct mlx5e_priv *priv;
+	int err;
+
+	cong_event = container_of(attr, struct mlx5e_pcie_cong_event, attr);
+	priv = cong_event->priv;
+
+	err = mlx5_cmd_pcie_cong_event_query(priv->mdev, cong_event->obj_id,
+					     NULL, &config);
+
+	if (err)
+		return err;
+
+	return sysfs_emit(buf, "%u %u %u %u\n",
+			  config.inbound_low, config.inbound_high,
+			  config.outbound_low, config.outbound_high);
+}
+
 bool mlx5e_pcie_cong_event_supported(struct mlx5_core_dev *dev)
 {
 	u64 features = MLX5_CAP_GEN_2_64(dev, general_obj_types_127_64);
@@ -283,7 +408,7 @@ int mlx5e_pcie_cong_event_init(struct mlx5e_priv *priv)
 	cong_event->priv = priv;
 
 	err = mlx5_cmd_pcie_cong_event_set(mdev, &default_thresh_config,
-					   &cong_event->obj_id);
+					   false, &cong_event->obj_id);
 	if (err) {
 		mlx5_core_warn(mdev, "Error creating a PCIe congestion event object\n");
 		goto err_free;
@@ -295,10 +420,20 @@ int mlx5e_pcie_cong_event_init(struct mlx5e_priv *priv)
 		goto err_obj_destroy;
 	}
 
+	cong_event->attr = (struct device_attribute)__ATTR_RW(thresh_config);
+	err = sysfs_create_file(&mdev->device->kobj,
+				&cong_event->attr.attr);
+	if (err) {
+		mlx5_core_warn(mdev, "Error creating a sysfs entry for pcie_cong limits.\n");
+		goto err_unregister_nb;
+	}
+
 	priv->cong_event = cong_event;
 
 	return 0;
 
+err_unregister_nb:
+	mlx5_eq_notifier_unregister(mdev, &cong_event->nb);
 err_obj_destroy:
 	mlx5_cmd_pcie_cong_event_destroy(mdev, cong_event->obj_id);
 err_free:
@@ -316,6 +451,7 @@ void mlx5e_pcie_cong_event_cleanup(struct mlx5e_priv *priv)
 		return;
 
 	priv->cong_event = NULL;
+	sysfs_remove_file(&mdev->device->kobj, &cong_event->attr.attr);
 
 	mlx5_eq_notifier_unregister(mdev, &cong_event->nb);
 	cancel_work_sync(&cong_event->work);
-- 
2.31.1


