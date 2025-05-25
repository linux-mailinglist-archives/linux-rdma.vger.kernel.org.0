Return-Path: <linux-rdma+bounces-10683-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ED6AC341A
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 13:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55CBF3B554F
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 11:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559881F03C5;
	Sun, 25 May 2025 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MbsSCIQQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AC3143748;
	Sun, 25 May 2025 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748171753; cv=fail; b=XxU0u/x4UrGREv2XPNY1csrVW/f63g/EXpKe8WF3eL/6+GQnWdGqQRuz7wQBXyidy32Usm0ZLLbTrIFA3H2Wh+cs1KMm8cfSZoLcZUl+FhmtqnRnOAG2qKUzYBocTSDZL8gs+VsOvMjIDhh55wJcKHe8jerpLjJZdDozxG9V3T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748171753; c=relaxed/simple;
	bh=azJEqI9LPBbZdjPFJTl84Tie/GDnc+3ZrqlUPj5YdYo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zypsd4/2JABo/GEcyqAFg9JIxQfVGT1ecHseLmnDjTMM3ArJQpanHD5IkOcBN/Gx+K4baujRCkndkt119EA55qxQNRekfMREcWAm0CQx8eerzqtkUAXd/JMtBh0cQzMyluBhLI3VbWkLFR8J7tGDitqQxNCkuSR9BcEH0EuCAF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MbsSCIQQ; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSkE+fCCYO6zGbqKk6uDd9sl0mTwrWaBRYJQX52zt12yog56SWtCngIQAFqxVmT0OBIdPZUjVFJNAY7esmF4Hgfnc2tB61L7eE8uomFFgVvC0rSIRujdRfX6LiQyhaP3cFdqy+u9gV8np0mZg8h0JYwBqSdFkT1lEthrZK+FuOsRM1pR1KKFO7x1EL6Lqhbq8yqYJO0+b1GEtIZl7zcvDRJ6rUQHZqnlwVLdI6pKBAnRj8Y3ctE4Cv3QDwWeQWHSGyMY+w39Fu99VC9qkgI5VP+FWhsvfz6Lw/pYsXdwaqcOGZRAUJEqSEoJiM314zwY8DrEvUpU6lsTxlgHTBiG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD72BDg8mYZyKF1hkEOIfZqgax9BQBSegt4nFw7+xgU=;
 b=mygOwhCYI+rCGwX0iQ4iB9vtCXXhhzSVVJj10NhtAR1SRl+CZFTnynHOH6hHXScWQjZ2/FDg2V/dojukiuf5uhj9gr/bg+EwAobMF6jxS/Xvg6NgCOMAjGjwDGhKB37x/C98mOEtHy0/meA3jl53QvwQpCiQ7jcTMpwyOAYPMO7e8LDjo5r9zCvNBT0MHPAGuArVIG2fa3wTHmgVpdIbdlmesRYz7RuNWWdEgUSD8hEaibU9Iv0TjfV+cFaUIzdZBJ32XH8IT/bhWc6PmIsnWVemrXOnJWTeAZYMgIVMu6IQFFEUggk4OordSWCgNiatffwXPh45PoP4rz+0GfZO/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HD72BDg8mYZyKF1hkEOIfZqgax9BQBSegt4nFw7+xgU=;
 b=MbsSCIQQHdK8Pcx83kbbiRQtJKGuhIX5tCqokHYUj99QWY6s3vBHdXAZMAKpXoZ1ZNM4wP10bLcGB6R9KQJ/TN7pTx9JNPVqdyh/96pd2M7r1kJjC6RD9dRk+2gmCzVsMGR/59Udv2aKM8gTwB5219Z4T/7vpqOsRwMoQqD3Mfr/inomXL13kl7PmxLu1yK2q+JEJ8uCWsmzAfRGIPNg/kgrvzeimKy1kMxwgCsvlPOPbAbCCjT9V4xrR+EY4iQUE7ZwGmI6ComA1NC30a4+JMVS4rwX3Iej7jaVp0oY4bZ6YNL41XYle1XBnZSUwj7nXNb3LVSaXCRrR7KyykSA/w==
Received: from MW4PR03CA0133.namprd03.prod.outlook.com (2603:10b6:303:8c::18)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Sun, 25 May
 2025 11:15:47 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:303:8c:cafe::97) by MW4PR03CA0133.outlook.office365.com
 (2603:10b6:303:8c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Sun,
 25 May 2025 11:15:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Sun, 25 May 2025 11:15:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 25 May
 2025 04:15:32 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 25 May
 2025 04:15:31 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 25
 May 2025 04:15:27 -0700
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
Subject: [PATCH net-next 0/4] net/mlx5: HWS, more fixes and adjustments
Date: Sun, 25 May 2025 14:15:06 +0300
Message-ID: <1748171710-1375837-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: 2694a4d1-7c93-43fd-9939-08dd9b7d7fb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?17VpyMD7USz1p/zAyq6rD0x6Nb4BrOaRPNnFrYPzpk0pm7Hsf1cj2VE+sCuo?=
 =?us-ascii?Q?IU4V+z6V+5Ge533/jHDa1CFD6F7deqs3aKBPiG5QvWAU8WtTzoM2gZhws2Zf?=
 =?us-ascii?Q?1DnPPWMWz1w1NtwZY1v/56b8Lxtkiy9DtLF4dKpBHgQA3xr5xV9lo33B2smO?=
 =?us-ascii?Q?QdnvOSEaGrDrfJBqJkxlF4O0haqeiVMr7n+GoTpiG2R7C2Dto1hWY1hnLNfU?=
 =?us-ascii?Q?nsrsl7sEzAgXV3UbGbWeZs//8rGGxw/4wlMD74cyFpJm7Lm0iCr4Ak3OrGrI?=
 =?us-ascii?Q?8SLZAnxYZazAv95Jzx5LZyg5EZBnD9v/3V7KCyg/ZE7fACeP+8RoVJ0BVegg?=
 =?us-ascii?Q?pbSVEdANpd2IyZIs/6gYJYJfIK/9cwU8CefnjUzX/o2OJ/VSp4VeHPpjnqmv?=
 =?us-ascii?Q?TfSQQ0w7Gz6szttueeU1686iCDv6flkqoMstlEjWsQ5GX1ueW4Jw1s7cKDAZ?=
 =?us-ascii?Q?JxNaFxkHgk0/vpu4gjIX2I9bVSHH0oiQ4VLIaj5i0uaG4sjfrC6EjrL9NvX5?=
 =?us-ascii?Q?gS6u6a50mXQh0F1WkwUmFDMUxyrFUxu1jjJztmn3ksO0jBzJpOQyygN9PJGL?=
 =?us-ascii?Q?RJ5NsnZb2g7Og7dm5OsJV3/DtU6nNXFTowAykvxjMiS+w227tb+7/too/Cqf?=
 =?us-ascii?Q?acTmC14dHp1EOH1xQDyKtruGrxETA9rvmgCTwZ4NVOt8AJ9x1JCqpXL8hGIc?=
 =?us-ascii?Q?mBthvp4U+UZgNruLsLyXX6I/srRiWPpzcdFYrwZglnB4SxjEgHbKsONwyI/1?=
 =?us-ascii?Q?qdMk7OHUO6v5DTVArYLzVgwn8xar1MuQbL/kednGEbvmBnvU2ifdQBgTgcGH?=
 =?us-ascii?Q?TfYy7+qny/3Clr0+KB4h0pPqbknchN9BAi08Olem0btcR7cXen0jBvnC1wtZ?=
 =?us-ascii?Q?rbTYSChURGtWlDvYcp4vn83AgCZ2ICh7cfC5eGinHSL791jgYTi5b2aw+18S?=
 =?us-ascii?Q?/JXBo17p2167P1yiWhVdng6rQ3ACHkk9IKby1K1PnnVXXBfX8PmfK8WjZ6zt?=
 =?us-ascii?Q?+aqs83QeTOJkTx6j1Jihcmf5Q+r1eUPoICM9sUQuD4cj/6euQvc7BSrvBSQF?=
 =?us-ascii?Q?+4XCkW6VLmiRz2CG4+aNGGh0hT3xq/fRw5gaGVH+mUBMBcxkx/ja+NwwsHzE?=
 =?us-ascii?Q?nhXyQ7eTJMXQ/5C4c8gTc0K6ZjuQNJT3FojJaQpLpz5RYrr4e1YEjRbj1dUv?=
 =?us-ascii?Q?IXQfvsXic9Q2coDFU/KImEcl2nnIbJ4liTfwO9ed5HpHMjf5Cv04pmb31YUq?=
 =?us-ascii?Q?y+T0BoMiBVKWYzMT29Bn1nL0e47dgx1PSVQ+gOADyz0W12FNygL1UtAHb81l?=
 =?us-ascii?Q?ptU+flZhzGKKLf5r5SodqNRkafMh4jMGLu2pjCa6EA7vSiIcW5yhusoFHd1g?=
 =?us-ascii?Q?5w6YOatfZR5rl+JEGLC3j1FSaqAwRNqhUq16UuOJli77J2vpvGgf66Jq1b02?=
 =?us-ascii?Q?AjmzVzzp/Nd4jmpXqzqnnTWCSIgIfKKbOqOToQE/CqFCSm1famcMP8IHpynh?=
 =?us-ascii?Q?9Lpt6t08077LDzkb+uTsBvRsQ8cUg2fwDGIu?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 11:15:46.9791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2694a4d1-7c93-43fd-9939-08dd9b7d7fb1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743

This patch series by Yevgeny and Vlad introduces one more set of
steering fixes and adjustments.

Regards,
Tariq

Vlad Dogaru (2):
  net/mlx5: HWS, make sure the uplink is the last destination
  net/mlx5: HWS, remove unused create_dest_array parameter

Yevgeny Kliteynik (2):
  net/mlx5: HWS, fix missing ip_version handling in definer
  net/mlx5: HWS, remove incorrect comment

 .../mellanox/mlx5/core/steering/hws/action.c  | 26 ++++++++++---------
 .../mellanox/mlx5/core/steering/hws/bwc.c     |  2 --
 .../mellanox/mlx5/core/steering/hws/definer.c |  3 +++
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 18 ++++++-------
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h |  9 +++----
 5 files changed, 29 insertions(+), 29 deletions(-)


base-commit: 33e1b1b3991ba8c0d02b2324a582e084272205d6
-- 
2.31.1


