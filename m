Return-Path: <linux-rdma+bounces-15751-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F2BD3C21C
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 09:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9CB1602293
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 08:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D13E3BC4D0;
	Tue, 20 Jan 2026 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RI5Bxchq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013061.outbound.protection.outlook.com [40.93.196.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C353BC4C5;
	Tue, 20 Jan 2026 08:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768897053; cv=fail; b=upu/VHq9TYSDOjHaHzDJk5tLRrTID9s3fJ5HZs6KY3s8126md9d2RKf1700D8RfJCMZLUtl5M/Aeijb2ZklhsH0t9OFRTKnGGkf3nQeYL7k1//RcWEIf54976nhLkxR3KQRJUFuZC6noQhpTUFi0W4Y/dp0nCeNICGJysjBhLCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768897053; c=relaxed/simple;
	bh=SgP1awjkKRy5m1MDtyuDJ4ttSy+QMIKtni9A8YPDVm8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HkBpxzMO781QE6tX0jUA3wIPziOVY7g/AvGzwd1j+feCNHqhUzbRTU8v4o8zOo9vTs71OacxsZPRq40tkSvkz4dhovQjTbd13nlxTe/ir1d1SNpEaCyoqnbGskO5ui0rkKslYg9Tr4p6ZrgTUkomMQoJvJJwVCG+0mlxgLAG0Ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RI5Bxchq; arc=fail smtp.client-ip=40.93.196.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5I9l4noHdWvziaNQQpM7I2K5HNkFvdWId6dBhEccLFwT+Ry8JVUIUmjUv4Sfan3u3aHD+lfrqRyCwRpFbH09YeFmsBc1mxsWnU76yvlm7YQLbLdh1FalbhylWyIQGBZ2141ItsDZho61Skrrp4dggW9AxekRb6UCisFVxBNGAo79FFo1BeMKOTUu1Hi+i34H2jJ+9umED3qkbLI0YjE7zHG/VXZRi52vM91PDw67WCNpGPHcBvQCexlERx5Y4M/XZpt7ZMWAz4yTXQeUUZuVwQCzFhGNor47fOtz3hxuuOJIccJb1XS2RbwEktDX6PYQDI/ZBm2ta52z4LFi7AyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eOR91XErnjgPdg1afX4kpFNrSuhkJyWxIdxsYyu5a0=;
 b=lRsBs7WTIG5xZTRVfjHpx0OpZzTwcmmBjP65u4136IjCA5Jae1wqQlkP8pdqJGiu3awLYlamwFCENsqzLYbuxu6eOi4r6UA2FDKJLZPMQ0OrLSMe5iSCErom4W+NdOYY2bcYiSQ8C7uag4cwdanzXZLQwP/4i3MkFw3Grw4VmT12lG6yakFiG5M+/vn1Wx1QnLz3sd1uclLhjDh4nV/KAIaI8EjgxlsBWVmgyPbD/Lpn4D+RlOXlgwd6Km33ZAKxMOQio2l+MMjxRJf0F2+4KT9+joc9YQHAMYMfmTpjl1aVzvZg0RtcchUssC/wBzAPgEd2nwrSlN8BxSiMApnWhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eOR91XErnjgPdg1afX4kpFNrSuhkJyWxIdxsYyu5a0=;
 b=RI5BxchqTf7hYmhfKpM3ONZ7lZM5+z7GemckOq06eO1NZ7IAnCM8eD0JsTm3aJekgBMhTbWmG1yU5z9AWzBbau9WKHuvZQoG2q68I1bJD+DKLVM0XcnoZJaD9vk/CSolpl3UpQD0jFBA9wTr3Oq650FSGzDtBWgRgeCHo45savUiJ5E5XKVpjOhmyUhtg9jKzNQc2cpZGa6CcK5EdNEi50IGa2pbbUuxSyeDQWsFgDcSfHmhkNgc0i91V1+KJte0TbAaqwuCbHKxLLH5zAIaEulePrivL/8HeCKykm6vJJOeclDmTbSSqVddllbhTrLBPWAR4rBFaMvR2Jz4YzYVRw==
Received: from PH8P221CA0056.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::11)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 08:17:29 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:349:cafe::78) by PH8P221CA0056.outlook.office365.com
 (2603:10b6:510:349::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 08:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 08:17:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 00:17:13 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 00:17:13 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 20
 Jan 2026 00:17:09 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
Subject: [PATCH net 0/4] mlx5 misc fixes 2026-01-20
Date: Tue, 20 Jan 2026 10:16:50 +0200
Message-ID: <20260120081654.1639138-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 55a59624-3073-48df-b492-08de57fc5a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GvjUNKfkkaN5TjVsFoHhNA6rkMTqQp6derQ7RBG45MdP3Y8LhRDNXuLn0qqa?=
 =?us-ascii?Q?SbJHxEjbV7ghEKcSjuHeNFSgjScuQDn9HDgMsYCqf2RY97Vl5ITs2J/JLD8K?=
 =?us-ascii?Q?b+jgIuO2RpWl8Upx3MiyfcKViAsGswnzD63aFcAVpCOwUHdzYizR4jVKNKoq?=
 =?us-ascii?Q?mkODGsygG3DhYGLfifaHBZ6IQ0TjYow5we9XaXwGZazEilhIqkfpjroLLKG7?=
 =?us-ascii?Q?AsqzM5OJz5dekKHiMo/Opis8AtORp495WhX7fez8FJQrsY0/mtMUJ4x1j5Wm?=
 =?us-ascii?Q?P+ZOTHDyuIRCgPApCnkJaR9MKNmoDyV8ncupAb0EhfQA17e2CmhnVTko9bhW?=
 =?us-ascii?Q?+/7Jhw2ITiutfzbeFN1UvOLTcE95DfU76ImjX8cr6Ee0rGqQ11ynr0tGLvUe?=
 =?us-ascii?Q?YNoFzCkrvPj51SGc3V5U+a3JWReO16RyMsf/MSRXmYQ9ty7Mj17OEuhXKfZT?=
 =?us-ascii?Q?4wScTC4/TfwrFb+aVCH1AH36DGriHFU+IxrrZk+CSiqg++uJWUCye8KJkk9L?=
 =?us-ascii?Q?eb0ytADh3vtexXuHv3QI98jiJg649BrOo93dKGB7PwrqSGwWgjGVVxvRX2Yn?=
 =?us-ascii?Q?0wrn1taey/JP17qnfwJD8cW2poQmIE9CvvLvKsUHXPrwwxpoMxpIXTkNQpC9?=
 =?us-ascii?Q?pomu5BecWkaMAmyg46t0K4SaftPlOTyjZPxcV4KoXikqczMm9+ixJ+5AfbDR?=
 =?us-ascii?Q?6HUCGPf9rs5efjMQfeh2pkT1ZeRDVmy5k8HJDZeYnDP49cW8WeVpf7KlwxwF?=
 =?us-ascii?Q?On6xEVnTDWkEeqfFVt5NaL5QBG4MuUkPMTQ2AZ0vKzS8Zg+vlIxZhGoZI5kn?=
 =?us-ascii?Q?oZBNZj0MMlqkJ7Uc8SlUD2AZg2qJe9kB5LBJZl47SGsY2v75Y4DgICU3GTeA?=
 =?us-ascii?Q?dfCToMd3s+xmFL3r79NgE5A8l/AyUSqDOzwoz5l1yTAyEHOeHS/OWRLaA6QS?=
 =?us-ascii?Q?4/gsSIWxM6opEjTNzyWGPFXUgGoyzwPz0V63M7hfGaatqQci0eezc8nXtxIJ?=
 =?us-ascii?Q?bK/CNd22afgoIVfVV6KEo8K6Ew2LEmNO9cQ2DoHW/NTBWpjS6YYsyOjBY4D3?=
 =?us-ascii?Q?Dpzaq3SNEbwEGcyFerq+jl0iBQiaDg0g5HxzpvoZMJzLTtE6LSIejXbdtUBI?=
 =?us-ascii?Q?thi+gibRcP9Srs3rLNqNTkF7l42G70Zuz4djJbo/3ru95HSJ7+YpNR4F/uDE?=
 =?us-ascii?Q?ifkajnx15+viZTWus0p0K6seBehTs69Q3QW5xww7UE5ErCuqj4Cxf5lhLhxc?=
 =?us-ascii?Q?ReMAC/pFdccZnR1cz4w85SMZw8jSOuQS76NLCOWEAjLrWGSyXmxwkHhQTQfI?=
 =?us-ascii?Q?fRQ96xIzyXEq3EDGzo1efdu4egGTOcZ6V6WS0IE5ZTj0GYWAh7+bKlt5xET/?=
 =?us-ascii?Q?jAvHD1UNKA+xs1vwqiRok9PuI+FK1l9Z+mNeduaWCSac5LTXuvFQn/wxOFQA?=
 =?us-ascii?Q?3YifTBJeSCywkKMPmJSzeBteQTfDImFNkEUHtTE407XthDoKc3d/pZcQ4E7C?=
 =?us-ascii?Q?8aqB3MNeTqZakBa/GcUk/VvLPaDw3d42Jq/kdauTh1BkW9MziOOmQwXNSHBa?=
 =?us-ascii?Q?PQ+xTkDrZnsQ/ql9m5K3CNTPi5QwqSuyPIYyMJzCz7F2VRg+oLmpQUi+i2Nn?=
 =?us-ascii?Q?WEHVsF/tXtfAdiPkqoFGt2D7H0i3Lhjj/YTiXB9OWtwHIDEoaF4MqNfIHCtw?=
 =?us-ascii?Q?OprfbA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 08:17:28.6130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a59624-3073-48df-b492-08de57fc5a0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930

Hi,

This patchset provides misc bug fixes from the team to the mlx5 core and
Eth drivers.

Thanks,
Tariq.


Cosmin Ratiu (1):
  net/mlx5: Fix deadlock between devlink lock and esw->wq

Jianbo Liu (1):
  net/mlx5e: Skip ESN replay window setup for IPsec crypto offload

Parav Pandit (1):
  net/mlx5: Fix vhca_id access call trace use before alloc

Shay Drory (1):
  net/mlx5: fs, Fix inverted cap check in tx flow table root disconnect

 .../net/ethernet/mellanox/mlx5/core/debugfs.c    | 16 ++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c |  3 ++-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c    |  6 +++++-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h    |  1 +
 .../mellanox/mlx5/core/eswitch_offloads.c        | 12 +++++++++++-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c |  3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/main.c   | 14 +++-----------
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h  |  1 +
 .../ethernet/mellanox/mlx5/core/sf/dev/driver.c  |  1 +
 9 files changed, 42 insertions(+), 15 deletions(-)


base-commit: 58bae918d73e3b6cd57d1e39fcf7c75c7dd1a8fe
-- 
2.44.0


