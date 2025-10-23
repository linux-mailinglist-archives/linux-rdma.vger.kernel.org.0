Return-Path: <linux-rdma+bounces-14005-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D815C00328
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 11:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00A60347B55
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 09:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538F32FE066;
	Thu, 23 Oct 2025 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CcYbrJCc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012071.outbound.protection.outlook.com [40.93.195.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7BB2FBE0E;
	Thu, 23 Oct 2025 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761211075; cv=fail; b=sZyPl+XdPiZq7Tf0vpqlNDJ6w1ihww215oPOyr/xph9owDsdd9y1J+L+dAlEoPNGCqEthFmcbl672+0lcthozIhxCznH5kkSaN1QeXrDqZdtqYhMaZxUyVneRAxHWAI6TbtdDpYAC9CN/Zy4ew9aalEk/OkxZhBJhlzdpkYkDjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761211075; c=relaxed/simple;
	bh=uq+wXNZMnUefMMYE/JEP1A4iaON20SRzH2zJwL1MpFQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GYoddKxMa99vvU0gm9WFh/9GdkZZCHzL4ym6g4EE1PAfwL2eM17dv7lbDc42ib0ncXzlRRYyM+cVHMJgX70/WDheGTBQgt1ybqfkAjXxOcoMu4BObooha1l43Qw3hkRXiwm4V7CqKMGkwwxUGyBkidmbkBzeigumuV+vsjnuLuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CcYbrJCc; arc=fail smtp.client-ip=40.93.195.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNGTqjskT0duwrW85Ukbef2bhzCHP+1whIQ4Yhew3ns9Y+eTKP7B7a2YYYkTH4F5CUl/EFWvSaugktRflvxF9hdJsRiElxcmA+DOtEVEyc3czsX0pK1aDixIAZTo+eQX/x1V78VGjKBxO15PGYZuY8zIiKEevk2uSyNgProppmqqOiGbRVSNM7BhotzvpJ+HsuIgZDdmUGn+3XGIuKfTRdeLC7OF4xsMowQOobZlpGH6XQuviUoA8enhC0z21sthCCHbGkzOyT0C29zJ+3/QpWQNq8rjlZa3hBkH1CvHuYzqM51SsAnetvQzDKaIJCDgT023nJK1geZ/0SorynlAyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ixk2eNPNFFU3I5GsPVHw3NdowKVnJ8MrgkUzLDk7YA=;
 b=qajX2YhGssdSbFzArvW8u67VEbr+Nzz8KlRyYtytozaKJhpS16jVQMWt1CTbRbAlyG+zbPvgGaUA2F+b0gR1glS6ourFc8gQxJ/r7cHnh1DRfjQaCqXHkvfZHkHRqm0uB64WXvcEoAeVGuzeeFTIzfVgOih7NxMOp71DjahWbS1GR51H6WpM/0vHeMNHSSI5yGXK9YFrej4Km5s9YyW/dGRkRPToY30cfcEEySvg/UDIvlIvDbIHfSXZREUiQVIZPG5zcZPmudKXHcanikdS4S9oRQ86reXv4jXRZb9Ow/MiIg8QZe85rkofEoQF+UUv7HGYNG1thgtRZqYWpZMbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ixk2eNPNFFU3I5GsPVHw3NdowKVnJ8MrgkUzLDk7YA=;
 b=CcYbrJCcZGEKmfe65sFWqHz0LDu8UrYJaxbtf4xOhSCY9WZuDzQChhmBetoOjiHyoPuqLkNF61hDFa+OjE4s4BmTltoq+/xQV/+4OXtfmDU17qS9RRNlS3chhrDNV6sFGBNcyYT51NzPmHAZl25kUDQPDgHD8Qo5juKcgcmnTXFXFQk37kwY5CWqskfkuZ3Ywb0SBm7CcRjZ1FWdh49+ysWYx8kZikJk7VZShUUFdeAvG60CKmtaiEg6wBXjiubdOZd66O8T8WWZUt2QxsQfcAMWysob6/V/f8y16AfF7BAiCd1aUYj3aIZlCMVyjtIskTjhZ3jqHJsGZSHvFbnMdw==
Received: from SJ0PR05CA0187.namprd05.prod.outlook.com (2603:10b6:a03:330::12)
 by BN5PR12MB9538.namprd12.prod.outlook.com (2603:10b6:408:2ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 09:17:47 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:330:cafe::f8) by SJ0PR05CA0187.outlook.office365.com
 (2603:10b6:a03:330::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.11 via Frontend Transport; Thu,
 23 Oct 2025 09:17:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 09:17:46 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 23 Oct
 2025 02:17:32 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Oct
 2025 02:17:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 23
 Oct 2025 02:17:28 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>
Subject: [PATCH net-next 0/5] net/mlx5: Add balance ID support for LAG multiplane groups
Date: Thu, 23 Oct 2025 12:16:55 +0300
Message-ID: <1761211020-925651-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|BN5PR12MB9538:EE_
X-MS-Office365-Filtering-Correlation-Id: ec8e59c8-a91f-4343-c7af-08de121507c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u3fHarSBUU5TNSrDnHi5wTcqvs07azKAHO9OX9h7wxqNPilzcfLJ0DpebW9i?=
 =?us-ascii?Q?BIXJLIhai53zN6z76NDlMp8NVAYaZ2mLYhRWpVvZcsX08s/fSSSSQQBQYtTn?=
 =?us-ascii?Q?ueNxnaKHdde/6d5zaqNbEQ36zkmKiTq9DxkhSOHxDT6gRh/7IFQfkVvR5ign?=
 =?us-ascii?Q?eWDiA+8GX7BWzCtMtK7qTlgZ++8G310uGFjJN1WCFjd/avUZ2U0vhnUBijCu?=
 =?us-ascii?Q?4hPCD7DawPjnqC8RrtqE2LgvPRNx9StC4RbpWSjwbLoXHbAxv4sQRhkC9d43?=
 =?us-ascii?Q?LWbNWHeYaiDCDTGqujJ6FhurDopHFD3+Ct7U6Z8VkqtF12GrY49eGDA3t3Y5?=
 =?us-ascii?Q?3Y6bKTVGCKzXCWKaxYFsd9US32eh0ivNFT7V0bo/2P7A7MnSl7h2bcrXDu/n?=
 =?us-ascii?Q?Uqtfx4dcaacOPLYSiHspYQy3XcIkyjAXnG7YBNggSKVv1BZ7TJUrNumuSckR?=
 =?us-ascii?Q?GYpOZRSKkDTVKgqMeSnIlmoYylsXHlZoZZ7zlAb9ZJCnBSz0pRrKupkX7ixJ?=
 =?us-ascii?Q?/B+49bp9nEzSPKooAiqHbuP4oeFuMl1pQ8+OLGkEwUvtWsapuQtkAVPZowRp?=
 =?us-ascii?Q?fh+6YA3nQa5WkqXBDUtTQ5T0wdzS0T4kqSpp6wogP+HUkEschj1bI6lptZwM?=
 =?us-ascii?Q?2kJlkPQackckSpLC9MOYAIum+ucLwXcxyCc0fjJI6TbI4k6ZH79Vk5kDSHEH?=
 =?us-ascii?Q?D9fxyyTBw1NPBTjhL/hXjZOl4d81Viriy8QQQm18yPOyhdajktIoJhvDdPLU?=
 =?us-ascii?Q?v9/C9phpX7S4oUN8Bek46KewK2EXJC2pL7KgwnrKwf1w5LzHn9GefVwgBGsj?=
 =?us-ascii?Q?biTMj79QTaYG3Y69bMXw1du4KCUOZd0zD9ht9zB5rgOtkzO4ZUVknqMUEhMa?=
 =?us-ascii?Q?2aga7rpP3iY78WFRZzlLVbfCVpvenzw2uJTTL+0LlDD+Mv9V6q2RAM/Q383I?=
 =?us-ascii?Q?yVLq4qM+VFBdQthso77bbi6dFlwfOA7XocRI7WRaim7ACxH2XFcwpkxiC6/N?=
 =?us-ascii?Q?C2ZgBEZg3lVUKICC7ki2D/IlMANxZQbWlNYcvCUT+HRRxK6V4T3wV3IWdqnv?=
 =?us-ascii?Q?4CaGQkqBx9UgVm5r24aFE1d0BsKNNWktokTCBD/sfr4W3Z9PjVdTfHMmOSx3?=
 =?us-ascii?Q?XYh6y5jbsl10rZ5///Yu8OMcDEO8+Ltxj8TU/I6miuQz/Zytdun1FrQxKr98?=
 =?us-ascii?Q?2qQGrvdDOnte2mvriE1ugzKVIyyLRjdZWcqt2bUZyRWLDaYQsR2WxEgDaeE6?=
 =?us-ascii?Q?uujE/7wMArQJ+dv9GGV4LT2NwX2mc/rP6I9O9O77jM9FCm8Kf3XEkPpoVwzs?=
 =?us-ascii?Q?SQYJg4Du9YaNMo51gikAHWFPzNelijgoWt29eRiMRopHey/MArmoCNXAmMn/?=
 =?us-ascii?Q?xuxUXDWRIjZYhYe5batsGcQflBzbXs5/7XZoDyb+D2tRO7ukBgH5GjOuYM7p?=
 =?us-ascii?Q?vXsjI7TKfEJuo0roxh5lrQrArSLkysHCL8g9QFNcogs+5GST6503tmfjVOdZ?=
 =?us-ascii?Q?0LI1KU1csl93d2xsDQFBC7xVldhV/RwYXH4lTZhdytsc1qxPU8/vosB6f0fU?=
 =?us-ascii?Q?HdKu1iha0Vkq3xUiSHg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 09:17:46.6965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8e59c8-a91f-4343-c7af-08de121507c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9538

Hi,

This series adds balance ID support for MLX5 LAG in multiplane
configurations.

See detailed description by Mark below [1].

Regards,
Tariq


[1]
The problem: In complex multiplane LAG setups, we need finer control over LAG
groups. Currently, devices with the same system image GUID are treated
identically, but hardware now supports per-multiplane-group balance IDs that
let us differentiate between them. On such systems image system guid
isn't enough to decide which devices should be part of which LAG.

The solution: Extend the system image GUID with a balance ID byte when the
hardware supports it. This gives us the granularity we need without breaking
existing deployments.

What this series does:

1. Add the hardware interface bits (load_balance_id and lag_per_mp_group)
2. Clean up some duplicate code while we're here
3. Rework the system image GUID infrastructure to handle variable lengths
4. Update PTP clock pairing to use the new approach
5. Restructure capability setting to make room for the new feature
6. Actually implement the balance ID support

The key insight is in patch 6: we only append the balance ID when both
capabilities are present, so older hardware and software continue to work
exactly as before. For newer setups, you get the extra byte that enables
per-multiplane-group load balancing.

This has been tested with both old and new hardware configurations.


Mark Bloch (5):
  net/mlx5: Use common mlx5_same_hw_devs function
  net/mlx5: Add software system image GUID infrastructure
  net/mlx5: Refactor PTP clock devcom pairing
  net/mlx5: Refactor HCA cap 2 setting
  net/mlx5: Add balance ID support for LAG multiplane groups

 drivers/net/ethernet/mellanox/mlx5/core/dev.c | 12 ++++---
 .../ethernet/mellanox/mlx5/core/en/devlink.c  |  7 ++--
 .../ethernet/mellanox/mlx5/core/en/mapping.c  | 13 +++++---
 .../ethernet/mellanox/mlx5/core/en/mapping.h  |  3 +-
 .../mellanox/mlx5/core/en/rep/bridge.c        |  6 +---
 .../mellanox/mlx5/core/en/tc/int_port.c       |  8 +++--
 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    | 11 ++++---
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 32 ++++++++++---------
 .../mellanox/mlx5/core/esw/devlink_port.c     |  6 +---
 .../mellanox/mlx5/core/eswitch_offloads.c     |  8 +++--
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  4 ++-
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 19 ++++++-----
 .../ethernet/mellanox/mlx5/core/lib/devcom.h  |  2 ++
 .../net/ethernet/mellanox/mlx5/core/main.c    | 23 +++++++++----
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  2 ++
 .../net/ethernet/mellanox/mlx5/core/vport.c   | 19 +++++++++++
 include/linux/mlx5/driver.h                   |  3 ++
 17 files changed, 112 insertions(+), 66 deletions(-)


base-commit: d550d63d0082268a31e93a10c64cbc2476b98b24
-- 
2.31.1


