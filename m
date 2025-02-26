Return-Path: <linux-rdma+bounces-8127-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43403A45DA9
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 12:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02FAB16F541
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 11:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0C121D3E1;
	Wed, 26 Feb 2025 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sRsUzdW9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BEE21D3E3;
	Wed, 26 Feb 2025 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570518; cv=fail; b=ljBcqQRvZ4KT/+4Ox/8ZMtK+KDJB8QqL0XgFV3WkvoJPKgjbK7+bpVcTf6K+pct2w4oxrU9FRv9lQ0NUmuGGchsTmjzfWE5liThHgcG/x/g/EY9yaRI1prehyGexUzSwx/4RE/B2rhCL/1ZXve/4edawc7ZQ35Msgg0gj0CJE4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570518; c=relaxed/simple;
	bh=SOEz5O+23gUGn+16INVoJWGrDPx6MM11/BxmJ9YrZrQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B1+gd9XzXvdAJTqWkEP22KsjxRI0xnVPThbYN5E2ghciYHIN0rQpn/xTGuy30ghirGkk9cKk4/v99mhhCba8ZhB13SE25aw6k8oCW9/AmMaFu0rfoN4SmOtB+DwXG5h8kzoKhXN4yDqFAo1PJjNJ5Lv+8nXfN6E5JqTkEZqd4v0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sRsUzdW9; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enYnIDkHPc++J1wchxh9tj4kZRAGrbU8GJTKobL39lxdILg78RBZ2cWXi/qXVLmx/43t9if2PN1i3dsP7IjsvH7nUVGD/g31dyAM46esTzQhjbCeJumGpSba3K4g/DFKCCjmU56xGBYdWjT/7TbFVz7+0xKyK1mh/cYIg9TnPx7bMVh3DnkG+EVEAe/Jf193vFlRuFFg7OILATSiE7V1RnHtqrAdZZ9uLhIMPZcIKwlyK3kv4xv6vtMFGyA/gs1x3d3Os5Z1v53HGcjJZ4zNnDfI74iak6fEwVLg3d2denhRKIr73YlKpTjLS9bDiFp6jHfWhKe0I9XGm3tg8UWcvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsIPL8vJkD9DxaB1KBFEdxmnZCAy1f88hDaaJsQRefs=;
 b=DeeSEqh2TDiys/69gtJlQzfegyRmifpkCZl1EWHdzUwN/1rWzUCEU/URe9nxXjtfLddr8vawx4OwFhBKYACxsPDNQumU+D/5b1ntSk5wrUr3M5Lr3jOenOsQRWFdHpvRJxsp5X48REtTle2tiPJzHiX6m1MSOdO5geUy6gN4liGE0ryTYqouXVzdK5O00n5lvWBx540Y0LT3WIPUiyFTvwbZwcnaV93U8Kyif1HdPC5B7ss3/vfKykJrsse5WLwjJKHZplhhfUOecXE4hVQeaMsnsD2ewjhmuSV/qCMIk2YpZbyZou270Lf49pfrq7fvBJz5UCjwljSWIVVKZl2bdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsIPL8vJkD9DxaB1KBFEdxmnZCAy1f88hDaaJsQRefs=;
 b=sRsUzdW95wtqlF7W23W44hMOsQMiKbI23tmvgdMqbnSczK8RQD5g+6xj08kdt09A4YvvnZZhAEqA4Jl7SyYoPPkN15BQkODgXMydGyaPpyr8X5hgAvyB0NXjxpk0QZHqvJnYKHZtuMJMgESOEK0I4cVWQczqaAPoqL+L/R0TBVnblUD159ij2tIvjEAmmZTs0cZEBn6Ui6uF6mJDZJceO4MTLgzLMpQml6vqvOUNT7WGXyELPbOhvamm+k5VGecf5oSdbr4UAUspks6+J74ySv0zMZdxuL5Yq5WKS00mdE4bR8kvmPnercW1N/nKe9acOh8lV1vNlaq6ncniohJ+0w==
Received: from BYAPR07CA0101.namprd07.prod.outlook.com (2603:10b6:a03:12b::42)
 by PH7PR12MB7017.namprd12.prod.outlook.com (2603:10b6:510:1b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 11:48:32 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:12b:cafe::b7) by BYAPR07CA0101.outlook.office365.com
 (2603:10b6:a03:12b::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Wed,
 26 Feb 2025 11:48:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 11:48:32 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 03:48:21 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 03:48:21 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 26
 Feb 2025 03:48:18 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/6] mlx5 misc enhancements 2025-02-26
Date: Wed, 26 Feb 2025 13:47:46 +0200
Message-ID: <20250226114752.104838-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|PH7PR12MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2cfa82-4a91-4b71-69ae-08dd565b7ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bk/CjOhNflOs7AKtnDLbCEs3JTpM943Wip8hoR85Sg/XR308BMqjI6Hhbx7T?=
 =?us-ascii?Q?R26pN/4SpPFUULDWD2AiiU6uoeE49qYjL7wmXEDo8uabe7LyZy34S1sEp/J7?=
 =?us-ascii?Q?vdapwpNqrqLf6+OokmcwuHtJKgRop7p0Y+3o4aT81c1OhYqpRaesxkVRfrSS?=
 =?us-ascii?Q?AUwxTPp4TvqVR0JbINKEf9mVE30sgJcQfUfR968dIaxkjBD0qMOFrqS4n0LG?=
 =?us-ascii?Q?APyFLCpVs1VNLcgU0bXlYieW85D3IsaYIZQTdcIjrU8yxFfy19f1UVPqrPoO?=
 =?us-ascii?Q?OvbYq1R4wKIpDnNznmh+YKEbtYcV+rDpDdclliE1BQgikIN0yLiFScCe/djn?=
 =?us-ascii?Q?ul6/O6h/WviXXv/9WOmcUGLins22yA+v+wjiUrCKLdXOb+eDDLGFrP6x9AbK?=
 =?us-ascii?Q?aO7EoHE/y0TsVOvngTBufALEnb+82piDm9+IQocqez/8xIMzUm9qY12qsWqR?=
 =?us-ascii?Q?7az0AxZcGfbyNM/DJLdBiau7SRMb2okas1QOSdNCPXZs6dzM0Mf/rkiUjQR7?=
 =?us-ascii?Q?IpOqhYLJi+AMawYxbfoFKInGTVLy0+7Im6WIpiyU2Z5QOVHC/7V7T1q9u5eT?=
 =?us-ascii?Q?gwqqcELHg3KrdWLVrnV4V7Qof8fxlbBKTgRbBF/EfNOT0sg7cDISe3JoNGv8?=
 =?us-ascii?Q?HbBKk2hXH3RgAG1uP9oH71D37p8gweRauAZj9jfpqEsyS8yTfe8HwpDQGa6A?=
 =?us-ascii?Q?AnACTtRBoPxl7qXjEW8mFrzJ7SjbIMrWijupcOeoHkKfL5u3GgFg4EYEPb6n?=
 =?us-ascii?Q?ge3sL3uejiL+zPqCZiJkhtOfqRnrkHDmVMRzSWExYVspp+BvZ2hSaGuXPaT7?=
 =?us-ascii?Q?IGrcFMNcGz7XjPaVAlxy5yGdAE4cpB5c/9okNgsc/xD1Y7gEuwwfhrG2yCxj?=
 =?us-ascii?Q?wsUr9hcdcV+/2oX4boOx0YkgS9qqJEmKBlZwZY+cBGT0F28zZ2csTlebNmGh?=
 =?us-ascii?Q?VK8Sy0raYcUgH4zowYuvcUxuCuvElzooAEC86UcIjbGsmr/H2V6MGOTBycC7?=
 =?us-ascii?Q?pdT4p67dcXfpyn4LkQ0mV1jm/h0ahRWQSRqAFlGZlJCh7bgxkfXtcfDuhAXn?=
 =?us-ascii?Q?zVHjBtJW0i+bYbHFxcXtI59pXVhmox8CgzqNmtYWmq/6aR6A9+8NYXXkqsWj?=
 =?us-ascii?Q?WrH93btydAUkEtkrLbT0nYklJLk7ZC+7MbA/BOoI4lpnay8ccp1Izsou07o2?=
 =?us-ascii?Q?tcM+Vw3Xj4JH16tV/Yk7D5R50u2drmjw8VHXcGvI3rUWQrfoCnGybNeiADoR?=
 =?us-ascii?Q?ZYHnSuHvkRBFSDNc33DTN4tIDuUWrp7Xu+Y+VTOn8kPTzve3EMt24xN5eMbd?=
 =?us-ascii?Q?KeTH7LFH3WIqjtzsfiRWdWrt4zw3eivctH9livzTBZ8m9jQrSfZVth0y6RWL?=
 =?us-ascii?Q?mk6B7dmcRvfG5Es9QRbv2l4QBaCxbpCUTMsdtFyCKhp7zjmNWW7exa/vFi2R?=
 =?us-ascii?Q?sIdSDVKxmzsh9RPQWU8uBYLplFF3H+luDh3Y7uGP3bZvBXJzyoWd4QDxv6bX?=
 =?us-ascii?Q?DpEQy9OQB2wbPLw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 11:48:32.2060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2cfa82-4a91-4b71-69ae-08dd565b7ea1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7017

Hi,

This series introduces enhancements to the mlx5 core and Eth drivers.

Patches 1-3 by Shahar introduce support for configuring lanes alongside
speed when autonegotiation is disabled. The combination of speed and the
number of lanes corresponds to a specific link mode (in the extended
mask typically used in newer hardware), allowing the user to select a
precise link mode when autonegotiation is off, instead of just choosing
the speed.

Patch 4 by Amir extends the multi-port LAG support.

Patches 5-6 by Leon enhance IPsec matching logic.

Regards,
Tariq


Amir Tzin (1):
  net/mlx5: Lag, Enable Multiport E-Switch offloads on 8 ports LAG

Leon Romanovsky (2):
  net/mlx5e: Separate address related variables to be in struct
  net/mlx5e: Properly match IPsec subnet addresses

Shahar Shitrit (3):
  net/mlx5: Relocate function declarations from port.h to mlx5_core.h
  net/mlx5: Refactor link speed handling with mlx5_link_info struct
  net/mlx5e: Enable lanes configuration when auto-negotiation is off

 .../net/ethernet/mellanox/mlx5/core/en/port.c |   9 +-
 .../mellanox/mlx5/core/en_accel/ipsec.c       |  81 +++++++--
 .../mellanox/mlx5/core/en_accel/ipsec.h       |  35 ++--
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    |  95 +++++-----
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  44 ++---
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |   4 -
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  92 ++++++++++
 .../net/ethernet/mellanox/mlx5/core/port.c    | 168 ++++++++----------
 include/linux/mlx5/port.h                     |  85 +--------
 include/uapi/linux/ethtool.h                  |   2 +
 10 files changed, 341 insertions(+), 274 deletions(-)


base-commit: 91c8d8e4b7a38dc099b26e14b22f814ca4e75089
-- 
2.45.0


