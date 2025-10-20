Return-Path: <linux-rdma+bounces-13944-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D87BEF94C
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Oct 2025 09:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3DF1890913
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Oct 2025 07:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15A32D8382;
	Mon, 20 Oct 2025 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i2h9Wy9G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8042D9EE1;
	Mon, 20 Oct 2025 07:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944007; cv=fail; b=k0iQldLt7o+EQEIEoYexQ1psOAJYdZ7XlJXyzoFd8AZ3y80EZgnv3vE/b7AAaaZ2djI+PX3BYqmWgcYZXDzqAzx2QfpcLsdtBUKj9OPWVHUP/DugRzRmBT6tkocVdqS+4O/xYS101Q1W+8BcLoC0vbpFmE2InnuixS+OGX2I8t4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944007; c=relaxed/simple;
	bh=Rvfdr5KF89bJ1tgHvFvP6xbNQRuuGyHfcQleCcfX0/s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oxs1bKQV4yJhumW9YZI6NKmnps03vY+psWj0Ys89JlPIjNwrxs02QlpkUPLjppQoNuD1s7Y3Cloa+Cgm6bWX+kvRta0tUONGQLCve4J4pqGFT+ZZohMoPVRqpbBS2Xte40J/LrhhuaNdMqMIOHv96QB60d+wTjMeunuPLU5po8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i2h9Wy9G; arc=fail smtp.client-ip=52.101.48.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WswTjOfAJe/wjnjk/F9ZH1IcmRP4RMasFYfALi4i5VDSXoB6+73+XJp0u4+R3+7ZWpV2hHbChedsAcLr175qTHeoknWCw3/CUGEHkVUhUdVzj4MV/zgadAUroKPUvCFsMO/RMudH2x8C4DLfcK/Fz7AR+adTPfjKnxgaT6CpxC6ucleQ12biJ9zHiLli5k11eknRVCzgY5CoLUC5llo0hc8DFJELEYC+vXMJU8+wJHW2eeygStEr6lVqVpGn1Ue6ca6K1loAin3jLf69jXXajKJZO58zIaE35hb1jFFFJEWPBIZKXjy18DM9mkkjnyoGH1DXwhkgBHq9/VZWXbVDYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYfXVlLncx3O4+p/u4y8QHowmICrhhwZyEVll+sO+BA=;
 b=EDFmO2+FEA9efyPweAByNRKfbu10/VeQI3gx+fDn36hekPYU53G87l8S4SgouNs/6xVnNe/1sFEyi68d71QiYMSiZCzwbzxsjnuTcMHsuAdI57IoZVkMH66eF2nYKZzKBLSbsgPm1fwap8esbxooGbB/PWNPuU3uSNt+3NOC/kXUr3e3gVrMizpWWbsnUI79nybjxmrmExSpelgqlZnTLb8GamBJ40wV5RP6viSGpnSW4IIyxmP81m6R4wHcpEEj5UkPZ0qet9tMcb/5QMgDl8jdZf+AjzuVpdSVsoD1b0WplDW7QWJ9jgo2jU+gGyfky/dgxrD2iETsFNwPzJyCLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYfXVlLncx3O4+p/u4y8QHowmICrhhwZyEVll+sO+BA=;
 b=i2h9Wy9GUCFXPQ+bBhTYadtXbd+LMXkNmMk1JsaFW/jWTpPDeCxs2ADv+MU/lO7Wit0Sh4jiVkWngq2TGBe8AY2RP3RtBaVCM0Vmbht3zQU51qRU+aDRQYN/9kNoxL6S/WYJeUFfSpPtZ0tC+Zg4GvybUwZLom3Ex01SEAUFyDTDUlPUyrAt0boap/i6Z8B00lL7Wzu5xgDj7mqOqhQ8uN2m9E5NQu7dwDtNXtGE5yYFmfKdt44NgE8ou+Ry3UQIUv1OQkT5cVHz5eMzj4HchTvKqbw4eEoAeDdE+9LFYUVpI/VvuWvxgDqNHHBy9u70Q1sO94np68d92OyiM7VftA==
Received: from CY5PR15CA0121.namprd15.prod.outlook.com (2603:10b6:930:68::12)
 by SA5PPFE494AA682.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 07:06:40 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:68:cafe::f4) by CY5PR15CA0121.outlook.office365.com
 (2603:10b6:930:68::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 07:06:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 07:06:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 20 Oct
 2025 00:06:31 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 20 Oct 2025 00:06:31 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Oct 2025 00:06:26 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "John
 Fastabend" <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>
Subject: [PATCH net V2 0/3] tls: Introduce and use RX async resync request cancel function
Date: Mon, 20 Oct 2025 10:05:51 +0300
Message-ID: <1760943954-909301-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|SA5PPFE494AA682:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f4fde2f-9047-48dd-69e3-08de0fa737db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iR9KJdDW5877rOkbz2g/+FlIwKqdfAedh1tgN/nuSeGHH/gTwh615nrg0GXX?=
 =?us-ascii?Q?Yv6/3nNYCf+gdYxYcZGMYy/IMIqyh6hz/nIwo4NL5COeHnS7r/C81BvFI4//?=
 =?us-ascii?Q?bdGS3a4FQYsTfn88FuAgcRLujDUzLg/d7Jl3PV9K3iFYdg8Fwqm0rBuQ/LLb?=
 =?us-ascii?Q?XhRWM9O4cR3DGY72xgLnThxxiF0NKECGd9bK26/J2ZC0DT6ep4PFcpia6VBE?=
 =?us-ascii?Q?rO9W+4FiH/P3zB3TRL3weeGkDFiMSiRufRz2Frf/vdFt0WC5dupRzo81/a3v?=
 =?us-ascii?Q?CcVFOQWT/mLSy53DphoVYn8u2usarzNbdxFFl1zMqPYQ5wEeCy9smaZBa/Tr?=
 =?us-ascii?Q?lEGDJs95RxqpLtIRga2CJaAppLfE9M5TVD9FTu6IEIjN6bLDV9izYwgJKhgZ?=
 =?us-ascii?Q?4dCM98Q4rtKeuMnsb/2r4eFIZJ4WGwZAcJQBqMjnC9HoMFCGfc+Ft025L5E2?=
 =?us-ascii?Q?ePkpdJ6NLJ76zipsALTBhn4XfdZuH1GJslOkhr2JLbpAb5TSYvzzYZVmdP2C?=
 =?us-ascii?Q?MqkW0GZ8I4olPDml6ogorfGxzcru5Pzduvn3DTHj8qUxaSesyO9OXmKmSxUK?=
 =?us-ascii?Q?HKQggmbVV16NjbYnx7sbKyLZLdTe/2G8N9ma8Zggs+6GgUCHV2yaK/3fC5Ye?=
 =?us-ascii?Q?ArJE+L3rKQeF8wghcvR00yZfpEtSnepc9fM4bnJiDLXUnkIyyTmqqACcqCUO?=
 =?us-ascii?Q?ksMkQhkdchI+yNqg+5wyNS8N6ABsmuyN1cZeg7ZNyFrdOkAJmnlv6HjjIgmt?=
 =?us-ascii?Q?tn5LLi0uJ+tCNxfn/akJ+D/fL/flEyoWksWeiV/EMPzieYqY9UgAbYRiFiX8?=
 =?us-ascii?Q?uByA6S4rbclPQOjXLXFArLp9aawodyzxnzK1rgaRbNssMl6AcejCIaRzdUW3?=
 =?us-ascii?Q?Xz5lRmgb2hztitPJB+kCLWkjILc5dcqRKNagBPCk8HqQPgzW/MqDxTugC16C?=
 =?us-ascii?Q?0oEzEjj2R8g1lIZx0Jpxpym7E5/F9spFnvZb1LF0QDr4VI5l6a0+4LCZiwMw?=
 =?us-ascii?Q?beLwYmw8L04hs+bZ4jCRm5nL6RPBMmehxuI1wRpFMmTO5FdAc8hvYj57ndwI?=
 =?us-ascii?Q?muuPRv2NOO9AvMz0DvgH0G9qzG8URMXvKKurBq4npX8xbXz6t5bcnjaLdTVx?=
 =?us-ascii?Q?zJknF7zVUcCynZsXozPJZg9GumjLxne4z1+DTL3YMFrM2QYXyhECqwjfyD3B?=
 =?us-ascii?Q?BJjcx3e2umAiRhUp3LVsR5NCYbOMoRKsXKm1gQo1LpzeyYYMngsP8FVl7TMD?=
 =?us-ascii?Q?es8pD3xuEhuuDaWss3abOKaPnw1QEPXuEeHn0Ykjg6kq+vQuEh8BjkjA1Car?=
 =?us-ascii?Q?rrfabGrRbTKf8BSrSkp2Lka/VT3Urlyw9S3jX6i+zm1AIkNw0WDzdLuFi8mx?=
 =?us-ascii?Q?9MQRscSR72kQFID32xB+LtS/oKnlmBZEW0KebLqemFxM3m7TFEnSjB8XLsG+?=
 =?us-ascii?Q?VvMlBbECw5aNcB+gxX83QbEa5rncIDsyaEbiT46mjqADzVgoHEthGSYM0zjO?=
 =?us-ascii?Q?DhLerB7RWtXsSqWEfK8YMtEM8W/BZOz0+3kitfiqXTRH9riCx9qnpPa2UKYq?=
 =?us-ascii?Q?9Zgn1+eto4sEqBpc/mQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 07:06:40.3242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4fde2f-9047-48dd-69e3-08de0fa737db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE494AA682

Hi,

This is V2. Find previous one here:
https://lore.kernel.org/all/1757486861-542133-1-git-send-email-tariqt@nvidia.com/

This series by Shahar introduces RX async resync request cancel function
in tls module, and uses it in mlx5e driver.

For a device-offloaded TLS RX connection, the TLS module increments
rcd_delta each time a new TLS record is received, tracking the distance
from the original resync request. In the meanwhile, the device is
queried and is expected to respond, asynchronously.

However, if the device response is delayed or fails (e.g due to unstable
connection and device getting out of tracking, hardware errors, resource
exhaustion etc.), the TLS module keeps logging and incrementing
rcd_delta, which can lead to a WARN() when rcd_delta exceeds the
threshold.

This series improves this code area by canceling the resync request when
spotting an issue with the device response.

Regards,
Tariq


V2:
- Introduce and use tls_offload_rx_resync_async_request_cancel()
  in tls module in one patch.
- Change argument type for tls_offload_rx_resync_async_request_start()
  and tls_offload_rx_resync_async_request_end().

Shahar Shitrit (3):
  net: tls: Change async resync helpers argument
  net: tls: Cancel RX async resync request on rdc_delta overflow
  net/mlx5e: kTLS, Cancel RX async resync request in error flows

 .../mellanox/mlx5/core/en_accel/ktls_rx.c     | 40 ++++++++++++++++---
 .../mellanox/mlx5/core/en_accel/ktls_txrx.h   |  4 ++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  4 ++
 include/net/tls.h                             | 25 ++++++------
 net/tls/tls_device.c                          |  4 +-
 5 files changed, 59 insertions(+), 18 deletions(-)


base-commit: ffff5c8fc2af2218a3332b3d5b97654599d50cde
-- 
2.31.1


