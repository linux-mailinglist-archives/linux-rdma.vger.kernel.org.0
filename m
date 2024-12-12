Return-Path: <linux-rdma+bounces-6487-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD299EFF0D
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 23:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB569287D23
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 22:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2961DD0FF;
	Thu, 12 Dec 2024 22:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S5FX7mgw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCF31DAC83;
	Thu, 12 Dec 2024 22:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734041700; cv=fail; b=D1j7T/x9pnBzoSDu1e0PyHY0qmym67I4NcsO2vr91XlEy48eyx3oPHwzwJEVBdB/pGLHmoBVzYZpYQse9ZORxUjV/PWUKNlT5cxxc9FOaJ9YnxgZgRX5npsiFU8Q/4I9QPR5MycSV/rD0ZQ27ACRaDltzRV39Lz0CB9jCJ8Xghg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734041700; c=relaxed/simple;
	bh=Fl+zryhfYVG6gEr9NKP8Z2jjIX/5H6ReIiTbkyl92t4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Of+txSfbeOz3nzCMjjJpT+xY9sC3fQcIcxltoDgdycbXJ1YoINQOJkIuHONM7FnPcbxoAcQj/6CTmLib9ZaOuvNF4pFb9wnegSITD4M/czvOO41N3lFvFbEmHNzjY9+jGP5MeReT0VvEJPANvphhVo3pacxXeOMGRM20OZcSI5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S5FX7mgw; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oW+bAxV1V9HSFGDBfGHABo+VdPciLODqp7jAuXjtN4h/XI5hY6+sqRUmc6zEPVZSEeuQx5INKVJlt5SCcFso8MKhaXfljIQ09S9hsZH2Z1uN5kU1vINpvUlz8o35PmUbooHzuEBtXINiYcd8+2AQDiVvUeUUDMSud+kaf55k4Tn60pFHgdk7VuhbmT42JgzfKJrcAvc3XUDXMoWsCMnWCTmLNx/E1aLE0WCS5pGcH4TPQDZtMw8o891T6uMKtXg/eSu+5ZjVzMvPBNv2zLBgpni1t2VCS0jGe7N0QwE+ZW4vd7d0ONrPzbsr86d5iUVVT91hx4DkDfVY9GaD9+yhqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UrEip40oNw7BVYg8YPY7Lc+yZo8gdTERNtoJm9bzpQ=;
 b=fD3Y3ezdJ2aHXiQ2EIWD//TFhD8SBRCmAv1IEkZy3/OMmJ0skiLqedIQ1hUiyXBXNEQZeeZlwF91be07NPWbpl7/koCiFfI3heh8geSRaXYbjRppTRMvYmIZSRXaWPbugDUGI//pnrNYhFu9hpuPTYFBjK7H16CiAZQY+8bNXqMtQ2BYkxaFI3FJ6DubMs/Lo/vlofknr05PlFEn/J+YNe7HQj0VoAQVMP8pzQptL9+AtUpiGGr16WNUg/F9TxaTW5iji3hOrwyBbK7Z1st/6jcme4RbGyYR62e3ODZ5adGH5YpiPT5SOjDnAj7SxdN/UJs+/wduCtQgHP0FkAfFYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UrEip40oNw7BVYg8YPY7Lc+yZo8gdTERNtoJm9bzpQ=;
 b=S5FX7mgwYwYcIgD0tt2BrqqBseVOcA/yb7lW6l1+woz1xuh9H9kSmTpMfxxOBpTwA69vCkevaWpRRTGDGr+UsEFyYHtBJltqw1Pj/6V4jD1ct8YcL1Z4ecHEWCH50GcJ9uQNCbBLVX793s4/cjpImAty8fNw5AqdsPiK1xxJcc3/BPyrrUFOHzqVo6wEd7shtqmLZor2qtUtAfeunKxNW9aEozt8DWBOt7URsbMkNKOP5uc6C7RbG18lW9Ftj5syMSP28pJyFTriqGC2K7XfM3BDgTAR9rmC9fGW64X6Sva7ikIU3wefAjHhxA87rKq7eDrm1KwGm05bAYH7cRbd8w==
Received: from MW4P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::14)
 by CH3PR12MB9148.namprd12.prod.outlook.com (2603:10b6:610:19d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Thu, 12 Dec
 2024 22:14:52 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::ae) by MW4P221CA0009.outlook.office365.com
 (2603:10b6:303:8b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 22:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 22:14:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 14:14:45 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Dec 2024 14:14:44 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 14:14:41 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 00/10] mlx5 misc changes 2024-12-11
Date: Fri, 13 Dec 2024 00:13:19 +0200
Message-ID: <20241212221329.961628-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|CH3PR12MB9148:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f9e3c5-9e2e-4123-5d14-08dd1afa6652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oxdm65nOxYk5JCa7mIMiFWi/zW3ZEDEGDu1w2j1PKpxuyR7Yjp2cgYsuLQVO?=
 =?us-ascii?Q?VAf2FoPVihjrcom7EW9Gvua0nWZTfEOl8bJ+mfpElI41ViGJS7lASjb5i2hX?=
 =?us-ascii?Q?IosmhjLFKPJ2fOc2ytVaD9NmglBuMOqq+tRRpjq6IM/owzqdjohDE5xM94Kc?=
 =?us-ascii?Q?tHS1/tZFvQ/IzY9kHNq8tg7E0NX2p6ZPKJxIUyboxfcxuICRoUcnQBHqyf9g?=
 =?us-ascii?Q?HNXwGSmHIB0WmzzC+Jb23nWpXp+6hrXSL5rhMf27FLeHrrj6SWSqC/c39tgF?=
 =?us-ascii?Q?Q1U31i18+ncIdAHlJ045JJ0IjdKfMWZC3FMUITzRg4bL5crOJdz0jInrtgOu?=
 =?us-ascii?Q?a2nkK5tGqtxn5AAzVgezFpjFc93W5D3T6LsKTvTzZ86ihzavGakzI2XdPuLN?=
 =?us-ascii?Q?w/j1jLXqw26CkNO67013oxhDMMWsVeRQetg2o0H0gn0TTZWdEnpjJi8fAyPK?=
 =?us-ascii?Q?Mm5lnGHSA5HgnCFyfU84V77/2fxQ/RaBT+K9gij0LJvhUW9u5f9Vpd5f4gP/?=
 =?us-ascii?Q?fnDUg5q4r3AYTa/qONb8WpzI7I40KY+W53DDqYKqjT18/86RlrAlLc8U+tOj?=
 =?us-ascii?Q?rXEUEiM50kKlA8tQEyiaYnuZM8ljc5/vg0zS45Cql2k4HlxOCOWBuWxInF6I?=
 =?us-ascii?Q?WIi7G5Wef/S4a9paBKGEXlT5I7xRHFB4wcuM2gmJS4CIXT3k7zjgRCAg2nDI?=
 =?us-ascii?Q?7a0tcCL7e/gYjsoepFnOyAtYiR17iVRyZJEQ2muHQCzd6uets3L7UaxGG6CL?=
 =?us-ascii?Q?CpaN+onvFpdQe9rM1BF5PMpQ3IS3RaO6y+ZNvWt8xsLvkZeCC/3DlCrJS7VF?=
 =?us-ascii?Q?/KzyYQEL2023a5JxUVTlAQpEErJMyOYAFkaX7sWONjhRwTuQOslmaHRLmlVv?=
 =?us-ascii?Q?lECttLBdanm5pkqwA+L7jhE3Ip/7/SISQXfuMkw0LgSSd5/aFgKjrd65B0j4?=
 =?us-ascii?Q?WP8nCT6x7B8kvSbhAnVdWNO+y6wbjSQV43+wINhAmuSjZkjZzlxumKA52wzj?=
 =?us-ascii?Q?QLbiGC++ROQ2LdQhqVDcDuAXeKNJjlsC2lvphgjmNIX1zBGTxsdFC/FCubMR?=
 =?us-ascii?Q?Z9C2aVboZ4mK1HPCYRizacoN759iA6bagFZ2BnNOMZrvxqzLyiPdOzl7xISy?=
 =?us-ascii?Q?3wM+PIwfjfu1YAGlG8ShdcvJUMKXP1plwsN9tnpgoymwMEKXQHxpBPqNsnjP?=
 =?us-ascii?Q?C/gbSzW+wF5MuxDy9c5+Q5UQP4TKaT2CCM4eRHzBU+OcVpDBDH9HHweLYz55?=
 =?us-ascii?Q?7z9BbGZ9TbgzQjGIQuH9GviskV0KmYKtdUcR+iczMtuNzqkB6OeLYvBBLHN3?=
 =?us-ascii?Q?Xd3A1KTGfFRJBEIYIOnskT/NZalfha9wg3gn/HYPhXDheg4eGCNVHDFdBi35?=
 =?us-ascii?Q?epsE+UJasdR69OkJhRwekJxDcFSHU7oxHLmNWGiEHtRKot96lP2QucG9YjMu?=
 =?us-ascii?Q?a1mujbvPD8L855z76dxixm47pXdIBchz?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 22:14:51.7142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f9e3c5-9e2e-4123-5d14-08dd1afa6652
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9148

Hi,

This patchset from the team consists of misc additions to the mlx5 core
driver. It requires pulling 4 IFC patches that were applied to
mlx5-next:
https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-next

The first patch is an IFC change that's targeted to mlx5-next.  It's
followed by two more patches by Rongwei that add support for multi-host
LAG. The new multi-host NICs provide each host with partial ports,
allowing each host to maintain its unique LAG configuration.

Patch 4 by Mark is an enhancement to fs_core.

Patches 5-6 by Yevgeny are HW steering cleanups, in preparation for
future patchsets to come.

Patches 7-8 by Itamar add SW Steering support for ConnectX-8. They are
moved here after being part of previous submissions, yet to be accepted.

Patch 9 by Carolina cleans up an unnecessary log message.

Patch 10 by Patrisious allows RDMA RX steering creation over devices
with IB link layer.

Regards,
Tariq

V2:
- Remove Moshe's 2 fs_core patches from the series.

Carolina Jubran (1):
  net/mlx5: Remove PTM support log message

Itamar Gozlan (2):
  net/mlx5: DR, expand SWS STE callbacks and consolidate common structs
  net/mlx5: DR, add support for ConnectX-8 steering

Mark Bloch (1):
  net/mlx5: fs, retry insertion to hash table on EBUSY

Patrisious Haddad (1):
  net/mlx5: fs, Add support for RDMA RX steering over IB link layer

Rongwei Liu (3):
  net/mlx5: Add device cap abs_native_port_num
  net/mlx5: LAG, Refactor lag logic
  net/mlx5: LAG, Support LAG over Multi-Host NICs

Yevgeny Kliteynik (2):
  net/mlx5: HWS, no need to expose mlx5hws_send_queues_open/close
  net/mlx5: HWS, do not initialize native API queues

 .../net/ethernet/mellanox/mlx5/core/Makefile  |   1 +
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.c  |   3 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  11 +-
 .../ethernet/mellanox/mlx5/core/lag/debugfs.c |  13 +-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 365 ++++++++++++------
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  17 +-
 .../net/ethernet/mellanox/mlx5/core/lag/mp.c  |  77 ++--
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  16 +-
 .../mellanox/mlx5/core/lag/port_sel.c         |  55 ++-
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
 .../mlx5/core/steering/sws/mlx5_ifc_dr.h      |  40 ++
 .../mellanox/mlx5/core/steering/sws/mlx5dr.h  |   2 +-
 include/linux/mlx5/mlx5_ifc.h                 |   3 +-
 28 files changed, 1062 insertions(+), 567 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c

-- 
2.44.0


