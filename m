Return-Path: <linux-rdma+bounces-14331-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65173C43AC8
	for <lists+linux-rdma@lfdr.de>; Sun, 09 Nov 2025 10:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D7844E2430
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Nov 2025 09:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19D82D480E;
	Sun,  9 Nov 2025 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dn8xE6QW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010035.outbound.protection.outlook.com [52.101.46.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD08B2D3ECA;
	Sun,  9 Nov 2025 09:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762681142; cv=fail; b=l90x7jOs3r6HY1tl5sUPnADyVl68I9Axs8GDcj5jPS6C/fnHissrBhhNKQ/ph2f6wuUofsi3Ty75mRoqZ0kKFV1+U5GvYt4JDvklK5UzCCT2V0jmXN7gmJXF+amigCFjV2/KdOe76UM7g5+BejSakmca/rrhkF4wZy/KI5GImJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762681142; c=relaxed/simple;
	bh=N1mrgsVeqG0QKHBnHklsjk1cPCIrs3UyKo9d5+3jzmQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bUnaYgA73BXYvz5IZdNO7ZONHhC5LPnNAk8GJTVtVmiGVjdb0QVIdKZh/o5JtZ38x6mveQMAM0hTDtuq45H5gw8lSw+LAImF102WPXVBeMg0dKTzWI3ufY4UIzrfBPGHBFqxVDgGa3fD3OsdBZkbmiTzkaK6UFRG+eASg7NbPlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dn8xE6QW; arc=fail smtp.client-ip=52.101.46.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJNBAPetPNDdz8D9zOpbjnyhe/9DvcVf203i3Fcanv6f+pwXuxxdciLw32V22s/5tGs4bv1kfbXLNy0pliwyz7cVjoXrxuv5s4rwLJsHDQyIwS9JcepTqvVVjv4FlRnrBH1h1sCvGA/MjzyqVPNbGqYYup8zlcer0oaUujOQGA6HY03ls8vlctlxDuK/AgvUYlY2K4vWCD6QQakIgTPxOhrAe0BRnYosi8bJVq7gYGla5hcBuhc7S4bsSUxsFvf05oXe+Se7dQnZg+xUxM+cimgJ5/QP0dKKIC8gESdolY7+DH5VKcXcdZ2Gg4oy5PBVTRAX6X163jk7fO3fKf2+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64gbNCR9+nuri5LQ8cPZkG67qn40FoF2+cfBJBDpuoE=;
 b=C4AVaw0nWYGy4K6a6NsQbKr+yg/FgnVg2tARKVVZLj8hZQsoa53iPHmlt7NxW9CkLbVWZUHV+1ghdrU2FGRHURYKg0aGra1xQk6QyrsV8Q8X0prvcM/O3R7HKk626leMhpV48fvTtIkxOM6Vi/M2RIrnTZli4gkRK3TNzHPaf606Hncb4buOli8Lmd+BEFNGavubECsqD5zXh1F6wHaOae4NYwjnMPoQcUjhaA0q8jiYcq81NfQxtl82pf5k59QwdmPMAwjSFiF1Ek85SZ8EIPOD9MHg/24xFaMbQYRnNg0Xs2VKH+uqQRfBaFXxN4AyExADjqYHJTNl2Fi7zggosw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64gbNCR9+nuri5LQ8cPZkG67qn40FoF2+cfBJBDpuoE=;
 b=Dn8xE6QWbAI8cG4KRQXkmihfOSkQiDWiFmhhU8vSwwr9XY4kxQ7xV/UF9CwJ0RQ8D8pL0eKokieoZIf8QUupgIRl/he5Y+VIVCS5uSGLx57jPjurCdwb1k4tnhdYzUe+ogBFBrmXk5uRHWPZxg7frksP4FuVlEq4Mo4SRry31o6nxT/BI6cPIoFIyWWjiHV4H2aZVvhxXjqjLzb7Eg8kPVEv6z4S4q8WxSyw44WXcI7LxUmxH99QQZYk9ZXOsf3cV79XSXVTgEbPSl2M7aMlKDW1aydKZmts6ReN/57QGvdzVd7W6So8gWxJrWX1ew1ZOUGTXEAz+YWZZOEPIhmMKw==
Received: from BY5PR16CA0014.namprd16.prod.outlook.com (2603:10b6:a03:1a0::27)
 by PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Sun, 9 Nov
 2025 09:38:56 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::f9) by BY5PR16CA0014.outlook.office365.com
 (2603:10b6:a03:1a0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.14 via Frontend Transport; Sun,
 9 Nov 2025 09:38:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sun, 9 Nov 2025 09:38:55 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 01:38:46 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 01:38:46 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 9 Nov
 2025 01:38:42 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net 0/5] mlx5e misc fixes 2025-11-09
Date: Sun, 9 Nov 2025 11:37:48 +0200
Message-ID: <1762681073-1084058-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|PH7PR12MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 146494e7-2f0b-4df5-2cca-08de1f73cd4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JhEH0ByK+gSDu7jkbbCWcQ7xOP3JYods+TwyZtBKp4TKhGh9KlJLwmEjl30L?=
 =?us-ascii?Q?0HPk+LB8Dt8RxkGp2oFY8h1jF+VJZVK7BN8fOHsA/mI/mbaZX0SmGPYAHo6b?=
 =?us-ascii?Q?V/av+mv6OEda5Xm3oE576GLtYxLRZmWj3DUh9UIECIiLFEUXrNP7X4xKg6tv?=
 =?us-ascii?Q?HRThSxp/QAPnGpb0RV8OAf4eme0S9VS3fooOP9SlQPfAip9v/LZVOD+qjU8+?=
 =?us-ascii?Q?db8qDdKCN5HDoGa+iDvoUZOCCTgYKZKU9RIRFI97vwkarD6cTTE+9Q2SmMqB?=
 =?us-ascii?Q?/hoSc7amKB1TV050hUvnXUFzUrKiAfv73sGcVCUH8f5GWtrA0u2OgJ6NZgZB?=
 =?us-ascii?Q?MyWUeKtYiCS0KXZcq+ZfyR2W2VqekV/RyBJCSaLHfSuimx97iH9hfufp3Q2z?=
 =?us-ascii?Q?ddbRpk+5aep1pa5Xb8JGCNuiDtsSbqYItgZvQQIVx257PNaV+PZ8dML1NxWJ?=
 =?us-ascii?Q?kr4opENYDKFw1mGOWpZGcnpRttpz0Kjx3iyKnRkOp66j5OgdDvTTMUDhYkbK?=
 =?us-ascii?Q?S2SGGnHgQht2Z5CkRD2O4XrVzfvMWmUd9yGjKYWi7vddmJZfTicwU0QKHhmf?=
 =?us-ascii?Q?TDJbqg6ASKE06diPQyWnfEmnOagBG7kumXSmXklaO46AtR+F6fowvTE+3V9f?=
 =?us-ascii?Q?RtseqlJ8Rz2obtQ81CtGQjq1eN8A8r4Un7SCmyvy4T08Cf1t7c/nwSoyP+lg?=
 =?us-ascii?Q?XUM+pDW3UMRDamKIHrYZhTDp3YmccxEWtAWmzMZtZK81j4fUZ3rS4M27q37Z?=
 =?us-ascii?Q?ZSAb+vkzOrJGjcmXg+LfGsTdE6zcW6ubgMh8auzRtHOGrjCzCgDNotWiHsqF?=
 =?us-ascii?Q?l+kEyI2kzbSRmRVkHAgKUXeBe/dnP8uv803YVWpvJ59ehYmN+KJIkXZjIEzR?=
 =?us-ascii?Q?sNgZc178JysKNK0dHKVysFpUJRE5Pj3B3qrl909v391/uVnZFeHFwwZ4G68n?=
 =?us-ascii?Q?Ce7GXBokSnsP19l4gIMDs+RfjHRgviQqHJimraObmxYe8F1QlXGvWD/VRD+j?=
 =?us-ascii?Q?jc+e0Eoe6o+pWIG/4M0Y0tGewGlF3P0R/FbEveWvCe91B0eojlHbsKnHJAkZ?=
 =?us-ascii?Q?zyfFE+Zwa1ItfH4sA/I5+UQGN2e3TKOlrBg3oQ1cB2xyvdNM3L9YMW5xAZq0?=
 =?us-ascii?Q?0aNnqlIjx3lrxEZa4TT465H1iawnloPaXu9yOLk4lnygh62nFn/4sufHhTZU?=
 =?us-ascii?Q?Csvul90elErwZbpgdCLstFw/I0tgf0TVBoPpbY9pOysGo7ZCvZhvF/MHSJLY?=
 =?us-ascii?Q?iZBvR9Osmo63FiMfcPqyMI5r1RVJ35yFPsLQMQVKMA80WC1zm93Hczwz9Y1k?=
 =?us-ascii?Q?THQykhCc00wJcfm6JHgScWkisR0WMJvKo7QH1jRNjqOoQ/Q6SUBV9GfeJbWU?=
 =?us-ascii?Q?51FPr3vFjFqDabqckorBW8aZyOAH6baj7C2LHfGpG68VQDmR4ONxSlAstkjy?=
 =?us-ascii?Q?IHYznidqqPx+FwXAe13TJ6aIb3MTiPwx4Gwmg9n8JHWXVvii/7W5fd7oEKAu?=
 =?us-ascii?Q?wyHty3cTqJ0VDPhKLoEwEoXurMv9RgL2Mz+9GA2L5Kq0BtLswjCLwhjlW/yE?=
 =?us-ascii?Q?djl8qHiJUlkx59htflo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 09:38:55.8228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 146494e7-2f0b-4df5-2cca-08de1f73cd4d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781

Hi,

This patchset provides misc bug fixes from the team to the mlx5 Eth
driver.

Thanks,
Tariq.


Carolina Jubran (1):
  net/mlx5e: Fix missing error assignment in mlx5e_xfrm_add_state()

Cosmin Ratiu (1):
  net/mlx5e: Trim the length of the num_doorbell error

Gal Pressman (3):
  net/mlx5e: Fix maxrate wraparound in threshold between units
  net/mlx5e: Fix wraparound in rate limiting for values above 255 Gbps
  net/mlx5e: Fix potentially misleading debug message

 .../net/ethernet/mellanox/mlx5/core/devlink.c |  2 +-
 .../mellanox/mlx5/core/en_accel/ipsec.c       |  3 +-
 .../ethernet/mellanox/mlx5/core/en_dcbnl.c    | 33 ++++++++++++++++---
 3 files changed, 31 insertions(+), 7 deletions(-)


base-commit: 96a9178a29a6b84bb632ebeb4e84cf61191c73d5
-- 
2.31.1


