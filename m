Return-Path: <linux-rdma+bounces-3639-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 571A3926F90
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 08:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69CC1F211F1
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 06:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E971A01DE;
	Thu,  4 Jul 2024 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YOG4+rm5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7FF1A01CA
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jul 2024 06:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720074571; cv=fail; b=hvxCBU5ZPbBbWv9MfKYOmJtgoU8hhxrICxJmtyKibIzQ7JaLnN8z/nK4wQrOGrMclbReOA7gBmiibHyJoF+CChjZOjNFgtcyUzW34hPtfehiDzjAiFaotQa60kuWxJdoDDEMgenD6Nw45pJqHHlHVd2xRYmitbbBQo68vtCGfC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720074571; c=relaxed/simple;
	bh=3Ziaz8AB4cV81Xqt5ZDv1Q6kQlw1VDOP25OQ6L+v1Ec=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LC7KFZx/++eFH4iXYSKB3nKo+prMC99Xi4UUZB7Zg22HsvsaHRZo4gB5cy1segqYsmK4A5eSSlHSffcAo2fp7t6A+WUgjRn1BqXN5hpS+oXbG6BH2ckr2iEY/rw1n5eFL/EMbSirl/EMliEV0cjOljOwmtxfV71WQyBC4pIDO2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YOG4+rm5; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnSI3GbX7smzSFz4hvfSuipE1tpoqbPBK0Eqo7UHOzobZlzcrBsxyNGr9jmG/tOKFEPaljISpcE6qF3ic2uzQXhe6NRkiQYxdN1NLQtCc52Xc9Lk0CXv7lNP0MFGRnSEtLvQsqcJ3WNB9ujRzkLSxG9MrqR15NTWIXpFAMYWuhzF0AC06f/+UPzWzOty2Nj1HSWUvj34hihKjXoCM9KXkjj0L+l5y/nGGZ3nlvCL5v5hqMwrQGffRGBisuIptWl4eU8Mibtpf0OLqNThuIHToDobf9yWZsiag/gycBfAjFm2hYlHLIGvrAlIoOrGyckP4iFkTVN/koyRFG86UP9EEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdQB+rEArzdzGlw0wEh4XjYJS9lTV5QLh9rprmD00r4=;
 b=G0DTzKJIOUcGyqK7Lp6o6KZjLTiVD8UDYaOeYhdG/6JLSkwp7gmUjd9K1GudcvfP5lWdrAmXJCbBEJTXyMLgkQVUBagn4gVmUnL2i/Aukv6SNtpqnLCAEiwvc3MBST2ldCZpUNWu2XO2qL1l5tpXwD8Ve60OHKEcQvWB40+W7Cgga5VARcGNpT5We5yeQ+CZkCPFxFoMDhRGuMrKdsRjfdvH3VX2fEE769nmUKsF39BaI7plZqPUiSN6UOm/eU6+yUyVnKOEXLe11cDoZ5omzIV6W2Ro69B4cqVe8GtbwZil4UPvebpzDFI1TBCXy0asjkCA4nUBOb3CkgZQvvhmgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdQB+rEArzdzGlw0wEh4XjYJS9lTV5QLh9rprmD00r4=;
 b=YOG4+rm5E3IOGhMBkVkiht3x7BmqDO5NvjZ+JnoDWwWn7zKo6TCyvCbhVWgkjaGMxVBrvr8MNMaG6s2D3tzk7Gq4BSZtyNfU3IR5rpJYZs3nKXVcCw/4kVRiBS8TWjXjNrFOA40jy+dIxnwEuvvLwXeYmUHAaXfhWIUJ/QG0ierBoSjkT3oyIQNfuNM458LROVBqyfkAbvUNYELq04IwzjRIkAQsgIn9p79NO9ep8uM22sBkTvlA5boVbh42McbQ66nYnCMEazCtlAKwRfOfxcg77Fjnmq0l/r4XFU63MdYj3uJEHzpW0d3l+PknJTlqMKZxkth191fMbnSwFxgz3A==
Received: from SA0PR11CA0035.namprd11.prod.outlook.com (2603:10b6:806:d0::10)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 06:29:26 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:d0:cafe::a9) by SA0PR11CA0035.outlook.office365.com
 (2603:10b6:806:d0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23 via Frontend
 Transport; Thu, 4 Jul 2024 06:29:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Thu, 4 Jul 2024 06:29:26 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Jul 2024
 23:29:14 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Jul 2024
 23:29:14 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 3 Jul
 2024 23:29:12 -0700
From: Mark Zhang <markzhang@nvidia.com>
To: <dsahern@gmail.com>, <leonro@nvidia.com>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, Mark Zhang
	<markzhang@nvidia.com>
Subject: [RFC RESEND iproute2-next 0/2] Supports to add/delete IB devices with type SMI
Date: Thu, 4 Jul 2024 09:28:59 +0300
Message-ID: <20240704062901.1906597-1-markzhang@nvidia.com>
X-Mailer: git-send-email 2.26.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 446a6ddf-8cd7-40fd-2973-08dc9bf2a6e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GoT5QcjhVFVWtCtegpwmmpEDTPsRIL9Iz/2fLVVdAhAL4aZj6dMRow88kFBC?=
 =?us-ascii?Q?6qjpgcR46JOH5kfW1Y/BkkH+1ma43k6jyT9Ajt5viORuS+rngDZTBKXsUdLb?=
 =?us-ascii?Q?UE0PbCwZKRUn0F3RO+Gr/dcDcSTBbZedBTqscBCcZaC1/oPS3ZZPMrwXWEwv?=
 =?us-ascii?Q?kgQMR+i5wv8/T57hvu2EA0n015/RGD3M2gJ0ao/477J6T1CcKiVRxJ+mBWfi?=
 =?us-ascii?Q?FmlxVa1uEAG6Fd/LNchAvXrW9URdgTgij0twuAoCCKXhPkf+7HTvk1ik8W9a?=
 =?us-ascii?Q?S6bKaKHqGTu2ZKFvePpc60g/Kk1Mx3X1TtCeGTIPGlnrzzKzGNvEAePoXNhl?=
 =?us-ascii?Q?D+aJLxzTe95Jcp49HJR76uY6WC9bRTaXJJ5+IwfufvBZtwyjHk21onO8ubcA?=
 =?us-ascii?Q?xVdjSkdke64uSbJiUwMq507Nt5K5xnPTk1e1mzywMcwviuSTUY7224XgAhkL?=
 =?us-ascii?Q?VyqvrdEGPtlITZiDtMYKxGNqg5mqDw9+aDpNA3hgBUO+iG/M5U9eALcOqiQn?=
 =?us-ascii?Q?7Sy3ZjF6ljxU4kjG8rQvWRc3PxFNIwR2cuX+EW6/PP/EUBfcTarfoLSobEJN?=
 =?us-ascii?Q?DMbhDt/vZMulQqk1NL6NKsJXw9M6nA70GixLPX6aHXSV/IGwGalWqG2MFgsN?=
 =?us-ascii?Q?K2OPclADlvdAwccXkfT1pb7WUVocw5MU2apUUPQJeeiKyeyrys2uTd5BDhbM?=
 =?us-ascii?Q?4/GybgaLsZ+lje8R96YYZ9HLZWRAMAv2W6btxBZ7c9H3o0dp5XyR+ud7wI+d?=
 =?us-ascii?Q?+s2VlKEK/eWtHGpRs6gFqN4zw80Yt33pWbzSbgd6se2CGYPGwjyrtswghVsq?=
 =?us-ascii?Q?ouDMn1q6IdHyjdD7G3/Y9HfBkJC8UNMm1W7J0u+7kIaBvT3ypQOYcsbRgarT?=
 =?us-ascii?Q?+Ty0bJnY8fweEcunhkKmsfgk1khDqtlmcJEe2xcgCLtX2wyRSdSrv89h6SqG?=
 =?us-ascii?Q?xeE7N+IFmBy54yDdhDKZ/HID8+SrfM6o7IQpcy0ixpoqm3MVn1YlTBnX5GyI?=
 =?us-ascii?Q?Vxdgi8Cw1Ie9xtfHzkIIw86/Layd4J1nETQO/hlp7t65K3I9bwDlDlcev7Jq?=
 =?us-ascii?Q?TS174IBMy3gg3+ABUoFPJjsafqtNAVO8GSLBHYFK+iIn6esGLexPVL3Y6Q9K?=
 =?us-ascii?Q?it2Ej790uSbbVs3vq+93CVpyFyqJFyt5zsTk/OmOZ1CfwgIV18IWhBWce9dL?=
 =?us-ascii?Q?rUiagdlP8ksqzZ0oLniV20nF+wB8nNd5ssLdxsmgzJz1zJmEMjlYmbHmzZN4?=
 =?us-ascii?Q?I57M6cy8QY2ZokDZI0M193vTBuBVjZAPPnCkVSD1lZVUIJDlbAwtZwwfMRtc?=
 =?us-ascii?Q?eZ/veI70asWhbMlpwHvWMKxhtETmDaXL/v9Mdwk/TPz40CGtfSF/TEtNODLE?=
 =?us-ascii?Q?fIM2Iu3JDWG/Y7MF4gpvUxLd2jvQrbPUS+CdizB0ySuGxHaB17JhUHxqvVrr?=
 =?us-ascii?Q?CBECeOV8ANLpLS6dOBiuchR7im0i7Opj?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 06:29:26.1694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 446a6ddf-8cd7-40fd-2973-08dc9bf2a6e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069

This series supports to add/delete an IB device with type SMI. This is
complimentary to the kernel patches that support to IB sub device
and mlx5 implementation.

https://lore.kernel.org/all/cover.1718553901.git.leon@kernel.org/

Thanks

Mark Zhang (2):
  rdma: update uapi header
  rdma: Supports to add/delete a device with type SMI

 man/man8/rdma-dev.8                   |  40 +++++++++
 rdma/dev.c                            | 120 ++++++++++++++++++++++++++
 rdma/include/uapi/rdma/rdma_netlink.h |  13 +++
 rdma/rdma.h                           |   2 +
 rdma/utils.c                          |   2 +
 5 files changed, 177 insertions(+)

-- 
2.26.3


