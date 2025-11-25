Return-Path: <linux-rdma+bounces-14772-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30617C86F30
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 21:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C9C803532D3
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 20:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED8D33CE82;
	Tue, 25 Nov 2025 20:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XpWGCk0N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010049.outbound.protection.outlook.com [52.101.46.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7051340D98;
	Tue, 25 Nov 2025 20:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101301; cv=fail; b=c6VHcArtc5xz2/n549L+b6lRoBm2n+XHNdLilYZHJ/bsyAWndM1r1UzjWHcU6bf/bHtr0ITbRwHoDLr++owavh7ZYJ2sORRpe/CZEhrwrEjRhIcN+iWqgK29KTwWG1psd6v5CZd/erI5S1wStFoDqz6xI7C8OdfIb3BQ+IPEh08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101301; c=relaxed/simple;
	bh=eCQG3S/yOds8JQUOHWixmpPqBLMdmU/S/TtH7v9dU+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=scUPVJ/vxuiaZf3KtQI5yGsGqdrNH5d/q+9X7s7SsNL22LFhousDDEgvnOoemrE3+0vLFF04yx31VsNtqxRFu1OcRILcHQsWqqVkREMyjoSs/qySbboUjnbXZ9vU4cUYr7xAnkn9d+IKqEm1aoapo/YcNGCUVPIVl+Orfm965Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XpWGCk0N; arc=fail smtp.client-ip=52.101.46.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdDI8Hko3zDyCfZk36fVStZvKZxg/apxd1HT5/InhP6uQFWU+jEK6LEEymRUdXxIGneA8OrHN7acGuGlxNvVPJgjminQkv9vqKpCWh5xnorOBujd+CbKD+S/lh0i9siGdddnL0jWXcvg5hTjCuIWlH1nawEVdk0BOtGxVN838+mVouE6bQtPju9qOqKI1gw5EB7L7lwcVGnUTT3RU4QivyhunVDwR7DO2m5v6nPbtTX4xMrkeSoLVA1BO8Ugt2ckeASeHWR3UAzrSnbp02Qufth1s+QMgr05tpnbHyFq7rxAIDtepGHjaHwrLbdZ/yUnNIBS0i9R5tuho5d7PPMHDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pAm2wQVgo0BwkiOeplsjOGdgWjn/yXUgEfaNOjFTP0=;
 b=Rx5+4AASRVzWP9ZcQ8v62FcF+eopyACF35m85d6rZlcf+/cjxz6swq2CopQ2Hfwug6lXdCuPxMGOLycYtg/mjePJ6MDkTz8mWt5JLY7ywvDz4XByrn8BFf7Tj/1VB1c8eCA3UZSrOhYUOLHks52WE/mRE6GvLN5wSDC6UG4Bajbi7zvsbRmF635TghFz8qjpPunri6waFTLS3ixlHF7SMi5POx5j66H8ph19n/eeb3DwADPwsBnFJu+F89y93ym6VqGq51ab3EGAPrTsaimQK8R3fuHeuo4B6qiHxexYRkXCqQfPW1wXzYQqXPaig8YwrN+wlSnReyMuXJ5FQJDn3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pAm2wQVgo0BwkiOeplsjOGdgWjn/yXUgEfaNOjFTP0=;
 b=XpWGCk0NV0vBMe08duSMgLfM9cxsq8vylu5jtpvFySK6/b48yWim42o7UE0Sa/N7e0S0VV6PAZ6ScgvOTV+mLhjq0V0uFoTxw2AqqwCbZJcgGULLnGtXY4ppe8/15DwziKikGLArxtach9cSJDd4UnLqhqWQmAKex3k62jx0MTLqJTQqSCAk6QqLwcd6495EWoL1YuCiwNAQu6MiiYYZb4S6YLkcysQwYvqm/OkkwpHE6izAM1RRIgQmUHXh33MGzEND9AreGbEfP2PjeBe8/6IIXLNUftMNSmTwfvk0v31+VK/GrtRDTrLtfn8alSfCy6jC499AEID22knzzwEH4A==
Received: from SJ0PR03CA0386.namprd03.prod.outlook.com (2603:10b6:a03:3a1::31)
 by DM6PR12MB4331.namprd12.prod.outlook.com (2603:10b6:5:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 20:08:15 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::47) by SJ0PR03CA0386.outlook.office365.com
 (2603:10b6:a03:3a1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Tue,
 25 Nov 2025 20:08:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 20:08:15 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:07:51 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:07:51 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 25
 Nov 2025 12:07:45 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
	<rdunlap@infradead.org>
Subject: [PATCH net-next V4 13/14] net/mlx5: qos: Enable cross-device scheduling
Date: Tue, 25 Nov 2025 22:06:12 +0200
Message-ID: <1764101173-1312171-14-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
References: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DM6PR12MB4331:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a7de11-6c8d-4119-f15c-08de2c5e5e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P2OYU5QO7qtFSW+/3TNy3h+PKcM7E8HtKhQTH4kNXGarGzoywBDn/o/q/eU2?=
 =?us-ascii?Q?py8+xW0xAM/+EHBmySsZDML27rCTiv97jC0OBlg7QGKHr8siEi0X7nmWb6E3?=
 =?us-ascii?Q?fq9GhCDRFSdBf8TTavtC1mJ6viRD2YmF2srV3kkMqtn3l7gOI0sjNMsv4/Gc?=
 =?us-ascii?Q?oRoLmwvEYd7+Z2tYHBJFW9fL8DoaS1uV7SssgQNObIY4m6NDtvPdM0LxzNLc?=
 =?us-ascii?Q?LJ+MUfUdPN9PeA950T9udHeY13jNGFIT2dcBTptXsjZ4YlwY86pIx7L09IJa?=
 =?us-ascii?Q?JOq/9/0ydTychnPHfKGec9PkRxs+XJLrT1VD5nsY1uPm5v3XYC8NuZqcO4HG?=
 =?us-ascii?Q?SBRdL/jw9qAAvj+RQWNOa5fs3/kvpegaOyvM/wZMfuzDnDrwJpK+tXyfyvio?=
 =?us-ascii?Q?bkPCtolxKhvoQBs2IYbaYBemVjo1gTCNnwduI6rfEGPb0lE9BaJZolxd8CrR?=
 =?us-ascii?Q?D6FN6qID4VbJi+HppZUi4eWGjK4KzkS96jP2DtH32D2jr7MXrK3suN5G1ZnZ?=
 =?us-ascii?Q?JV71+tQcmt5z+p77nQw0xQ79x2iu6ZkBvQJx0oOjf7w6cBFBluIq8+IYkjuC?=
 =?us-ascii?Q?d8UpCieLc9s/Gh6inKC32geLYYIX6Qg5YVI1qKiAJ4Uei0tRyrtMS0rmafVy?=
 =?us-ascii?Q?XurDH6JjMiBO/8p9/9AnN+hwmI20tor1WRFgxk/pRWBrApgiqlf4rzKgPfhG?=
 =?us-ascii?Q?aMcP8EylTIN8UJ7lS+bONYXCtJDPT1CUi7wjsYZE5YdkqdHZcI17yRA18ZVD?=
 =?us-ascii?Q?Y1oX+oMHlHkn3SCCppd5QHI4cy40wLf3HW5el5USt+XtnWYQ0QHDcUMMftsO?=
 =?us-ascii?Q?tOWwOU9nuEgt4x8CA1th74Ssxc3EjyUNuUnuUidx+dAE5KiW+DzTRPnUPxaZ?=
 =?us-ascii?Q?z+JSbtzUmE9/lXdZNy/F9kCnH6nAd1b9sVHZj1Tm1lPWyMImEmXVZCIoP1dH?=
 =?us-ascii?Q?4+AfYt3DWaxrYVVKCYl55+kzbhLqgVuPQiuA0U7eG2eT+i5ESMUrts5gRmrg?=
 =?us-ascii?Q?uJNz+uXRw6abUyCxsq9n8xmmcg8ltoBIdxtB2W/OnoC2X7y5sZ+3tNLKzdyc?=
 =?us-ascii?Q?O6615fYwd0gJe9hl1liXvKiJZhb4ihxn+8BAc++P+Twy6h8vzBwTNnQ9WF0/?=
 =?us-ascii?Q?2NN7pTs2UcSOzkp97FH7pk/BkaITsM8DV+Rl4pskLz4zBaybUK6chzvbSmms?=
 =?us-ascii?Q?atvH/hm3N7jROU413FoSLXPN3hWYhdD/ypK6XV7aznn9UsnOP2iHb9FADbfp?=
 =?us-ascii?Q?QjO7T5JsfN/7TgX3lP5M0bdk7MYEdVq6mFVrFJKcEGas85EXCOLV+w5UTNjq?=
 =?us-ascii?Q?7zVe9uHTSnhRIi5mjg8P8QF78dne43rXvvnG8IoIX7wwK1CRPIBnHn73D+Sr?=
 =?us-ascii?Q?gEIsx9FspjsL7xxpCySfYsf6Rd+RwCO5QbPIHPPAcrYaT/u54PNBVaC9mzW3?=
 =?us-ascii?Q?mmYjJYJ36kzaTeIIS9N3YeLoxbCeacTm/l/oT0B1isXYBLZUpqWi6pnnQRFJ?=
 =?us-ascii?Q?53gQ3NYCEzpvETkwhs+DXDsrqlNkoTAR4077t6INZS5UoR2PI0OOcFajQq+2?=
 =?us-ascii?Q?tHFoXPWAdvJ+MkYu5UU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 20:08:15.4319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a7de11-6c8d-4119-f15c-08de2c5e5e6b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4331

From: Cosmin Ratiu <cratiu@nvidia.com>

Enable the new devlink feature.
All rate nodes will be stored in the shared device, when available.
The shared instance lock will additionally be acquired by all rate
manipulation code to protect against concurrent execution across
different functions of the same physical device.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 887adf4807d1..343fb3c52fce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -380,6 +380,7 @@ static const struct devlink_ops mlx5_devlink_ops = {
 	.rate_node_del = mlx5_esw_devlink_rate_node_del,
 	.rate_leaf_parent_set = mlx5_esw_devlink_rate_leaf_parent_set,
 	.rate_node_parent_set = mlx5_esw_devlink_rate_node_parent_set,
+	.supported_cross_device_rate_nodes = true,
 #endif
 #ifdef CONFIG_MLX5_SF_MANAGER
 	.port_new = mlx5_devlink_sf_port_new,
-- 
2.31.1


