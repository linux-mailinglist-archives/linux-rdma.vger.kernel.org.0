Return-Path: <linux-rdma+bounces-6437-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23599ECD79
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 14:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8F8164153
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 13:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31C9233684;
	Wed, 11 Dec 2024 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R5hOrcM0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7B23FD00;
	Wed, 11 Dec 2024 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924646; cv=fail; b=pFXkFQqoH7I8rnzuzj0/7KoSdaOzydA7vYLJOH7fT7rNsnask2oNfliy1U7mdi19AKZEFDxBK7lSGMIrILdTnYYTdhNPOu4lHOuw+oRqMuBKHEE+mVJ/sEXsTNYCAlLKLusBLbOtB9Q5K3N+Dhly9qI5RBS1FDv/cUR21wltIvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924646; c=relaxed/simple;
	bh=YfwkFq5UY4yIbvAUpKUaF2AB7t7Z7ZtZCmPmXq04HqM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jHNt7Ss63wYnHjOX9nFhXtdknp1/9QfGJrM+YoYjI8Uc27yRdWkS+NW1VoDr8fi+ba9AT2y6mrqmpJXQP8RefpHOEobOUcsIHP8FMOQT92Jle0UOeFoj6IIw74KsPiJ3aEs8XD3dPal6qa+TPsHxUTuDJYXomL3tqmDiB1B1/2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R5hOrcM0; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhVSt/Z93VHp2BuUEXY+/XgrGxWK/lT5F/M4eOTI4KeJ3ScnS0uLRQGPijwgD/irTrWZPuJUSBV4HLB40ntiOXhtJZaujXq9nwar1S8Q5DgirOPy2DJyTkBkjQKD+dBQvi4x+/VtvqIUDnGhlQEuk5w2CgRHBcbByF6UtEQBOUXLH0eEqbDBFRcT1j8Hr+1NzZSuja24d9Me7tbwP/f2N3zas6eCD8C2xhsz6TcDN+JVnPhYk69nz/xICMZzSL/WMbhwrc9QVgh+xpvjYIymK+RYsRF9iKf36ywnsq+Jp4jdZmAcaNj1j0mFhYT24A2qDV1Kj1vXs63IxIF2VSubFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9OPGYzN9zt6JPK8B965RG/NUpNm7vddNuaqAWq96RQ=;
 b=np8NXJudHRikFh8B1Btio6Q09csEqcbQVpBhY+BVwfIaGIolhfVBb2N+UeEiZkldfsBPosM1JyWoSR2rys9O17M6RaUa9mGli+Ra4bu09fR1k5UI8oyeC5/0upRUtVFEVowzlsENduW4rLDC2cOS4SwT3WKBjo4t4nBrTun6jhf/HZGx+U5+QG0dDSzx9a1aypVHgRVZNSM0oXJJti4wbX6xOvGVVV5yUCJTmxB7OmKTkQwu1y9XOmmaTLwWp+H5XzQtDDxauql0etaMSS7elI73H4xfRaUDkkXMKAWOvRLK6lfgv3rOS1Pg70Eic+fUwzN4i2a1s7ZcxJ8lZbOFdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9OPGYzN9zt6JPK8B965RG/NUpNm7vddNuaqAWq96RQ=;
 b=R5hOrcM0ggJ0xDSJLVH5UABhPweCcR2yf1YNpYvOCJfmNJppDIZR70eBigZWmjl6tOmmlX5tO/WO/9BGIANj0QozW8mYqfMG9CDSNxtNQrWUfiF2TlEgJ2r8A8WcAHNeKV8kSEKhS9nIrxPFh9H6flsSZtBG5yZ7pimaMDix33huoLr+8M0jUSHmeAPXAt9dEPwoXdOhnKO7OdL+MRezeNBK+fNgNzDQEqXIrnLpgnuxsvJAAFDYGbmmtBcAPCY5o6EwryvhGMQYXLXXd6CPOtHoGHLvnLNEJgAoLAyAK/+2Q168bidaGyWUi+yRJ1eZjHBWL3OCdsgHJ01UzAfGXQ==
Received: from PH7P220CA0144.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::6)
 by DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 13:43:51 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::be) by PH7P220CA0144.outlook.office365.com
 (2603:10b6:510:327::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Wed,
 11 Dec 2024 13:43:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 13:43:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Dec
 2024 05:43:37 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Dec
 2024 05:43:36 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 11 Dec
 2024 05:43:33 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 00/12] mlx5 misc changes 2024-12-11
Date: Wed, 11 Dec 2024 15:42:11 +0200
Message-ID: <20241211134223.389616-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|DS0PR12MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d2718a3-7597-4954-a479-08dd19e9d83f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2hkTQOFUcAu5GROGmkX/ZHpcZubaR4uIQRqv0Ml8b1J1lo6lpV+3pYhcXy88?=
 =?us-ascii?Q?i7KoFfPxadIL+xIhH3S50Z0qIrAJucnHnJVNRWXQ37fdxFd1So+MAObz2ocJ?=
 =?us-ascii?Q?rTPGgpIF3pCHPu/WxmfrSDcIvE9lado0uYGTeT2md2qeJEUw1sm1pCKhEAZO?=
 =?us-ascii?Q?bY7Y9LbZq1Q8gDh/cxa8svCqJ1RoKfRJik0If01MLKVAaJHo3FnwfZuaUvKZ?=
 =?us-ascii?Q?8T4CpM21gVS5BAD8CSXCAYUq+1PCf+U/E8Ge0Ti2U+4TLINmor9ngbq0VJCM?=
 =?us-ascii?Q?JP89nl8b6+lcJlHjVoiLw8KxqHJ7qxLXcNp9NFA98ZFfBXYHCqxG+47lNvhS?=
 =?us-ascii?Q?4yoojWu5QKQtxAosnX/37bfpUHq7jQHjJ6U7QP1hl5J6J0Hkatj4YRWd8aXf?=
 =?us-ascii?Q?uEtt/ksXvhZXlZUpYIbsvq4+9WjYKEhqs3CTasJxYbU4XED1DTW43IYJFMZ9?=
 =?us-ascii?Q?LiJjBgK2f5D/gcUcUsHxtPieedScEOTgSMqZPZLFdkBrXk44gRVe/CwByDHY?=
 =?us-ascii?Q?WIojwA/oG1CviHQzz65CMLQpz435y61bg8vMqT6cYmyau4Qt7SKI6YtTH+xV?=
 =?us-ascii?Q?2/duMYBLMaNaYHI7fQnibt4cJNZ8qnizFXfZhMwLYxRAfJrrrd0BNe1Kb2V9?=
 =?us-ascii?Q?+deVgefkPv+NGXdeCm2LrW/Ua5niXijTlr5CoxLq2b7aU5gZwRZ6DtGXJd0+?=
 =?us-ascii?Q?5Ncmddr5xo7OCoziNsIbrdJFkorEmcGCw1gzU5stavwGgEx6VXT8MgQd/8XT?=
 =?us-ascii?Q?oOt2j29jJ7+tEZVhhSaB0atCYclblABB7+NqAteWXHrt1tgiuOkszXoKmeYv?=
 =?us-ascii?Q?VihFAt17X7Ln0/mPhyN3xSAB2UtUIm2yPuY0MoF+501rqyvogWw5kWyEwbUI?=
 =?us-ascii?Q?3xmVGNAMXr9koXL4VcPX3RFwV5c74M3dfpuji7MN9nB+v2yJPjHzXQbF91yN?=
 =?us-ascii?Q?kpFV7jhjZZscqCKSABYRs21wA1lLpkDxam13i2atNzZPrSlULOUe0z3ler0U?=
 =?us-ascii?Q?0GzMw1TZOdW3h0Bm31NJs84xU8NO4pIzdGlrS/SMU54ikJeNfgoSVT1RFzBa?=
 =?us-ascii?Q?ZIAUVrfnu09ySZkge2g4uHmIiX2+aX6qKBSxfGadrtn5s/ROQJbpt5P1RIMm?=
 =?us-ascii?Q?gqQ1bhipGrl4QdIpjo+b2H3GMyWpJlpKqi5d0qyq9VrDoqMFyVYdWVhBJH4a?=
 =?us-ascii?Q?xJKufJYAATj52Zn2AUWmejs1LchDJfrB/KVcos4QK0fUkoMxdedw9PgEo1BU?=
 =?us-ascii?Q?p84shI6+jDnb+J1CMgs3m3SVLrJgUCHlLJ3sJYE+jV+/Zprn8pmM58K9wHFx?=
 =?us-ascii?Q?gmtLYzfi5rRLIcNPU+cJShK/V6ucaWzzb2jRa5OhEkagim8qEUWpxzoHUcBh?=
 =?us-ascii?Q?iswhOgOdeJEvSUnwLS256T8djP/aMvP9Pgzl/a5dkjXpqxD7thXnMZ/suBsM?=
 =?us-ascii?Q?Pd6LRkXtHYEFDXvQHiQ8dJtS+6/TfFQu?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 13:43:50.1196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2718a3-7597-4954-a479-08dd19e9d83f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654

Hi,

This patchset from the team consists of misc additions to the mlx5 core
driver. It requires pulling 4 IFC patches that were applied to
mlx5-next:
https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-next

The first patch is an IFC change that's targeted to mlx5-next.  It's
followed by two more patches by Rongwei that add support for multi-host
LAG. The new multi-host NICs provide each host with partial ports,
allowing each host to maintain its unique LAG configuration.

Patches 4-8 by Moshe, Mark and Yevgeny are enhancements and preparations
in fs_core and HW steering, in preparation for future patchsets.

Patches 9-10 by Itamar add SW Steering support for ConnectX-8. They are
moved here after being part of previous submissions, yet to be accepted.

Patch 11 by Carolina cleans up an unnecessary log message.

Patch 12 by Patrisious allows RDMA RX steering creation over devices
with IB link layer.

Regards,
Tariq


Carolina Jubran (1):
  net/mlx5: Remove PTM support log message

Itamar Gozlan (2):
  net/mlx5: DR, expand SWS STE callbacks and consolidate common structs
  net/mlx5: DR, add support for ConnectX-8 steering

Mark Bloch (1):
  net/mlx5: fs, retry insertion to hash table on EBUSY

Moshe Shemesh (2):
  net/mlx5: fs, add counter object to flow destination
  net/mlx5: fs, add mlx5_fs_pool API

Patrisious Haddad (1):
  net/mlx5: fs, Add support for RDMA RX steering over IB link layer

Rongwei Liu (2):
  net/mlx5: Add device cap abs_native_port_num
  net/mlx5: LAG, Refactor lag logic

Tariq Toukan (1):
  net/mlx5: LAG, Support LAG over Multi-Host NICs

Yevgeny Kliteynik (2):
  net/mlx5: HWS, no need to expose mlx5hws_send_queues_open/close
  net/mlx5: HWS, do not initialize native API queues

 drivers/infiniband/hw/mlx5/fs.c               |  37 +-
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   3 +-
 .../mellanox/mlx5/core/diag/fs_tracepoint.h   |   2 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    |  20 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |   2 +-
 .../mellanox/mlx5/core/esw/acl/egress_lgcy.c  |   2 +-
 .../mellanox/mlx5/core/esw/acl/ingress_lgcy.c |   2 +-
 .../ethernet/mellanox/mlx5/core/esw/bridge.c  |  20 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |   2 +-
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.c  |   5 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  12 +-
 .../ethernet/mellanox/mlx5/core/fs_counters.c | 290 +++++---------
 .../net/ethernet/mellanox/mlx5/core/fs_pool.c | 194 ++++++++++
 .../net/ethernet/mellanox/mlx5/core/fs_pool.h |  54 +++
 .../ethernet/mellanox/mlx5/core/lag/debugfs.c |  13 +-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 365 ++++++++++++------
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  17 +-
 .../net/ethernet/mellanox/mlx5/core/lag/mp.c  |  77 ++--
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  16 +-
 .../mellanox/mlx5/core/lag/port_sel.c         |  55 ++-
 .../mellanox/mlx5/core/lib/macsec_fs.c        |   8 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |   8 +-
 .../mellanox/mlx5/core/steering/hws/bwc.h     |   6 +-
 .../mellanox/mlx5/core/steering/hws/context.c |   6 +-
 .../mellanox/mlx5/core/steering/hws/context.h |   6 +
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h |   1 -
 .../mellanox/mlx5/core/steering/hws/send.c    |  48 ++-
 .../mellanox/mlx5/core/steering/hws/send.h    |   6 -
 .../mlx5/core/steering/sws/dr_domain.c        |   2 +-
 .../mellanox/mlx5/core/steering/sws/dr_ste.c  |   6 +-
 .../mellanox/mlx5/core/steering/sws/dr_ste.h  |  19 +-
 .../mlx5/core/steering/sws/dr_ste_v0.c        |   6 +-
 .../mlx5/core/steering/sws/dr_ste_v1.c        | 207 ++--------
 .../mlx5/core/steering/sws/dr_ste_v1.h        | 147 ++++++-
 .../mlx5/core/steering/sws/dr_ste_v2.c        | 169 +-------
 .../mlx5/core/steering/sws/dr_ste_v2.h        | 168 ++++++++
 .../mlx5/core/steering/sws/dr_ste_v3.c        | 221 +++++++++++
 .../mellanox/mlx5/core/steering/sws/fs_dr.c   |   2 +-
 .../mlx5/core/steering/sws/mlx5_ifc_dr.h      |  40 ++
 .../mellanox/mlx5/core/steering/sws/mlx5dr.h  |   2 +-
 include/linux/mlx5/fs.h                       |   4 +-
 include/linux/mlx5/mlx5_ifc.h                 |   3 +-
 42 files changed, 1478 insertions(+), 795 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/fs_pool.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/fs_pool.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c

-- 
2.44.0


