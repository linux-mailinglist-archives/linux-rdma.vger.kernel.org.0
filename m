Return-Path: <linux-rdma+bounces-4746-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A271296C27B
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 17:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BE09B271BE
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 15:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F26F1DEFF0;
	Wed,  4 Sep 2024 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YH3YWQoN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1981DEFCB
	for <linux-rdma@vger.kernel.org>; Wed,  4 Sep 2024 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463872; cv=fail; b=YPRI9tiatljfs27iuU0F34b/6/Wcy9tBUzmTIYiwOHlDbkusQZ8oueqh9F4g/Ox0TWyMX8cAv2ugPj/MhBKe64LJtXTaDIeOfcDzvWlD/eX6IPCRQ+uuZt2n9ti5ozdeYnxnZ9FWW1AV56HC6+XBY/6SLXrLrLC/nksY/gm7hvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463872; c=relaxed/simple;
	bh=H4jKro83J5HW0TwnP4qj+bSdQGR+Q2uA07HVuTAfIt8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mUQlrxa5K5k8ksKhQazX51eKHiG+Tq5Y6s8Lk4AuQ2ytfqvcFZBYrDo0TqAhmKuEpr5M3Hnw3b5RgdYZ3cjreGgOMzoadOGKkuxFM9naRtZQn413q2VZOTGjKP9LsEPwuhkAC5Rpwt9M8yKMXOrXaUpgxCleLksRgiOKV+K3di4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YH3YWQoN; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcJOkjXj0BiwXMpnX5OPVZIr4eSsOfrai84wyThh5oBhyUt5T5wu898lheS3ZIZ1/M/mRdTfNH8LwjXnjPeHDycua2sWEjDInlMDuB1si6zGZuK21tqf5wcNd5jYpg52Q2S8ztzOtyax4JIbSSzkIV1haoec7MrsHcXq2s77anxp3gfw7rwrHuaD/K/tKRjAv4+2CYOUYSRmOpV4v9TmPbbpEppconENKtdIasi7G0qhmPMkTM2vZged0tp2vzyJZxXgibnFu2gepn6PUpZ8pSCR0IeSkHGrCjsk0QJbkcd3RBBRZSdlxX24TChQJFzQ1Pp25rSpicf9QcU8NIAsBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWUjKSOpXRq8cDNhR5jj9QrnaPn97+HQhdaeOtxhmwo=;
 b=SRF7Q5Mjp6j7FGPmeyznzQP69JVXoOpdR4YD5QvxWy1NKDbssawiZcTXxqUg0sfSi4DY6U3uqMxc2Gpo0xzFfKLRG6fx072X6xiFRDqyuu/Uwf6tQYsVDtHamfyykpdB3hDsjw5aRQV2YgJQrU3Rf00AreBP/X3CiJ9YkPmO3gdxERwXVbY5Pb/h7xAV+hb54DTS2ADmn25IRLXQNrOZDXPp5XkgqY+rJCMoJo0EIptIlsbvMnya+9gma/oSI1si9Ck+Wpr25tUp2J3QVr1m6xtmti8cNyeOX42M6k85guSfnJJxKt2bt8jVJWhsGoxrwLDKamO0RF7oCNBF6cXhZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWUjKSOpXRq8cDNhR5jj9QrnaPn97+HQhdaeOtxhmwo=;
 b=YH3YWQoN5O+fj6EZdoK1Q/GpAxmnpfmPYikRLFZpiv6D9q/ljq0qmBlBtQalW/HebZItLFngVRtp40bz0+qRsPuF1YtmxuOrNsRZO0/rwTCy7uko7QDUf+xGebN8wGPfjUsGVnsdZ7pKZj/uqly4mNZNzNgH1NHn6zkAB7waIo1EHWou6UG5BpuhRNh3v2xW/zLivBVNzT1ZdCh2YO2L5rtLGsbvGB/4AS8zEexc+gV8phVteNYazaler6k8rK8e6Cp7Sl6llUrfRFDYtUJyfpVJrIxbODUnp1U0I23q/M10qDyAwo8MuSNkhvZJBdO1ft8Li5IewBcl/md0dGhVeg==
Received: from BY5PR13CA0008.namprd13.prod.outlook.com (2603:10b6:a03:180::21)
 by DS0PR12MB6605.namprd12.prod.outlook.com (2603:10b6:8:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Wed, 4 Sep
 2024 15:30:54 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::d5) by BY5PR13CA0008.outlook.office365.com
 (2603:10b6:a03:180::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 15:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 15:30:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 08:30:43 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 08:30:42 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 08:30:41 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 0/8] Introduce mlx5 Memory Scheme ODP
Date: Wed, 4 Sep 2024 18:30:30 +0300
Message-ID: <20240904153038.23054-1-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|DS0PR12MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 06961f61-94c9-48eb-ad01-08dcccf690a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eumObO0xmhLKP9fSAX+7xnVdX3mszOY1OZxvpLg7p45ItWg+bCX/FrEP7/20?=
 =?us-ascii?Q?6JkQO5gojLIlA7SJBjOsy6MRqsj8NjmYSZHUknwIUlqeEBkIWieNuiLNBIKS?=
 =?us-ascii?Q?L/3fnxcee5DWpkz5GDA3p0QYgnsxVrbyKQe46lzQMv19f4UaOYN0d4igcxwF?=
 =?us-ascii?Q?H7KiV2bL4csUAFk5xtlJtBIJzi5o6y0UcbNB16g/t2loYvMPYLbzSa4amqRf?=
 =?us-ascii?Q?a6utn7HebsCs3BnUqzsopd1GGl1lqAt6XcOYMkHbblIRgbnNWjnTA2tMt2dA?=
 =?us-ascii?Q?MTd0dZj+SZhB8YPSNvbhr0ZLqROy+ukQnd+HT2RF1XH39hPM2u5hZdudkPZD?=
 =?us-ascii?Q?01HsBWqaYHsmTETRtlGu0laYABV+33BFR4mA1iUreRDSygt6OLGNVgrsSuig?=
 =?us-ascii?Q?QcNM/C5C7h4aLZhQc9EJNl2TpjJ0pWqDkQFNA2CxhnlMp1qtIM5AocUnWulB?=
 =?us-ascii?Q?onE4AGYF63mw+3G1qYb6R2rowZcT5vIGzcDYtQfH+QlW4goTDITTmc493ZEu?=
 =?us-ascii?Q?kLMEMv5NXZOz8uGoxjGrU/BIvPWI4wkz2kqohzBdoVte3w23QTiZuLgu7y4q?=
 =?us-ascii?Q?HywrD44qZOVivMaKw3hFapCeUC47MUmpWgKOva+7Y/Rfi+TgOTGLa6NYoOM6?=
 =?us-ascii?Q?ooo4/9dOkotvVfNDMNIX9zmjZyVsJXJCDhJdS1hzZvi8ZNpZr8NBr4yofABK?=
 =?us-ascii?Q?BLv3dpUvdsWPKyK/7EXrEQWt9pU+1kyCaUlS4OyQc7BjiGItZ/WRBvFL45b2?=
 =?us-ascii?Q?DI6pdXnymDITut/ga4aVnqxLtldFb/DX3r+FVNLd8LOVRJsqaeZq7h4o5lWz?=
 =?us-ascii?Q?3+vjkelt0I/SvG3Dsp1qULdzKN5O08FhLqOshrlYnxAH3sOv6WvvP3t29vdc?=
 =?us-ascii?Q?LXW+bnyGWYtopUbf58jL09NW18scFUPvXPx9+ROSUZoOSG+p0cx8pO4/5KWg?=
 =?us-ascii?Q?kPeFmxN6PITbIAx9jD/Fppld7Eb3D7MLl1JOlfl1WfnfUzp/L8sFigw+wMXv?=
 =?us-ascii?Q?kBVfltSvnyv2JrStVNNkiEaIieQChUDEWrz+YxXt6r218EvxdumeeTiG2bI4?=
 =?us-ascii?Q?jknVEblzRkcRx3o/WShHeX0aAfQ7Z3pTHJ4ytXar7cPLnHm7oDHnruGjkXUQ?=
 =?us-ascii?Q?ai4mhOuB9QE9BALN18LQnrkVXBGmEf+yV5TuCFgCWAb9Me19k38ncBD845Jl?=
 =?us-ascii?Q?HBw7srrCvQCLm6mRT3yG7PgkhU6W9atKCyF3gxKbGFbzKDf0YjEC1gFtFdfo?=
 =?us-ascii?Q?5U0lMIq4Cl3R+mDB7TvNvTb2zK4EfY8ix4ePzqUh15YoXvBG+j17doc9xYDr?=
 =?us-ascii?Q?w1fzq+vvzDdjF4w3zaLG5iPD2s8LuMLoCsEsmRmtL/sfd3mXvX6SZs1XiOHN?=
 =?us-ascii?Q?VDx+G6jsy25HC3qxM9aopGv0Wm6Q0T256Vzo02yw3VBYzzlcJoPvJss/08dh?=
 =?us-ascii?Q?f+3zqVxbBVRjPLTw1Xv6jvZDb8+eM3d+?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:30:54.0056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06961f61-94c9-48eb-ad01-08dcccf690a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6605

This series introduces a new ODP scheme in mlx5 where the FW takes the
responsibility of parsing and providing page fault data to the driver
to handle the fault.
As opposed to the current ODP transport scheme where the driver is
responsible for reading and parsing work queues and querying mkeys to
acquire needed info to handle the page fault.

The new scheme allows driver to support ODP over Devx QPs where driver
is not able to access the QP buffers, owned by the user application,
to read the work queue requests.
Furthermore, the new scheme allows support for ODP with new indirect
MKEY types as the driver doesn't need to query or parse indirect mkeys
in this scheme.

The driver will enable the new scheme on devices that have the relevant
capabilities. Otherwise, transport scheme ODP will be the default.

The move to memory scheme ODP is transparent to existing ODP
applications and no change is needed.
New application that want to take advantage of the new functionality
should query which scheme is active and it's capabilities using Devx.

Michael Guralnik (8):
  net/mlx5: Expand mkey page size to support 6 bits
  net/mlx5: Expose HW bits for Memory scheme ODP
  RDMA/mlx5: Add new ODP memory scheme eqe format
  RDMA/mlx5: Enforce umem boundaries for explicit ODP page faults
  RDMA/mlx5: Split ODP mkey search logic
  RDMA/mlx5: Add handling for memory scheme page fault events
  RDMA/mlx5: Add implicit MR handling to ODP memory scheme
  net/mlx5: Handle memory scheme ODP capabilities

 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  17 +-
 drivers/infiniband/hw/mlx5/mr.c               |  10 +-
 drivers/infiniband/hw/mlx5/odp.c              | 400 ++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/main.c    |  54 ++-
 include/linux/mlx5/device.h                   |  30 +-
 include/linux/mlx5/mlx5_ifc.h                 |  64 ++-
 6 files changed, 449 insertions(+), 126 deletions(-)

-- 
2.17.2


