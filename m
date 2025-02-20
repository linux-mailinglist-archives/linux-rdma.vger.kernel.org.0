Return-Path: <linux-rdma+bounces-7914-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132F7A3E6CA
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 22:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F323BDE6E
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 21:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09247264639;
	Thu, 20 Feb 2025 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dek5FiXo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E132638B8;
	Thu, 20 Feb 2025 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087664; cv=fail; b=QfLGmzlS/PlAHNfYwe0s3OYvMWZkZTcfc1uuGFGmFM3chLVw/v79XVgyBCl/S+c6tZLGxLA2tHlTXFVgHeBWNGn9dbuyzKvXQT4h6Yhsn6B4OVHLsqicxsU6+K5uPsYYwfwPv9i/J6RL9+XPyCXxSQl7c8YgbXLSVoqRJyad28E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087664; c=relaxed/simple;
	bh=rhhVF5oHD97YHuWAIHw7c+umqMt0g2jvEeiO5jVUFos=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UOMWQlnOi9KR94C9j0cgXbypGlYyU8KbULhgwxuZzMHEnokXoJ/1zadDVE/zFkkfFmUBSXT/Y17I5fAPTbztvTohl29KEpK+CsSDVS5vSmEEvLToDL25cScIebs/BogWNhEC24YG87W8hBVaxmOvwUoXFGLAnee5KdubDSKdPNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dek5FiXo; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtgUqxEUyITN3lqteqNivapAocn8mYyhtq26veP0KPEHZa87Q+l+ROvjCl2WDOTl1FCENLrcHaUF6wfOiRoaNtAOiaqX5CSziVXTAsP5tNCeqlc4IuGvEoHHRFOQag5HqP+98krh43H7xm2XG6gCoyXBHX2BhhLGBGLui21Kp1rIqsoY9auWQwjAvv9/y7pQ/FtZJPPdarN9mTJzrV6lcqvkN0L0TPblqvUsZgBKXzZOEaaZLfp+kfRwmtbAcXaagnQuffxdzJ2rvAn7kPSmr62rIzOtA1thNwddHfUgct2bLsxgh17Yy5Z1aFVsAluQQbS87XgsHXy26qObIeMlXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZI4YGyeyBiOWEiiV5OuMBv0V24LtnJljyPE2c4Bslc=;
 b=Qp7/N1NISAU4taPv/N4c/CXEs5tOexACz1One+7NuKE7uK5s09m/sk+YPZTnsdgR9O1ePA9IzPBVLUbi4onV5j0XvJSdPMtqWJkQO7aGWqVUcZLNd/2U4LsI8ixyywSTll+xqhm8luaKn+tEa9qivJCB2VK5N6Kbzqsoiht6+Yb3Ua6LAWn4fr78ANamNWppwKBL/LkH2fjhWZzVEFnEQ2r9WW34JEv4vu44QQGuWUq+IgmcNho3f5BfjPG4GB6SvNIg8bicvKkHvUxX+cQfGn1bnO2+NNKL+/j4nNtmuUPdRox4D1Tkwbn95C1RwbAZT2Omg/8ONtyyjNmd0PXqZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZI4YGyeyBiOWEiiV5OuMBv0V24LtnJljyPE2c4Bslc=;
 b=dek5FiXoeuDZm+VIaME/X6TQskUpzhx0vNzwf99aW/Mv1hGp89mMxS7h3RdNQto4/VutCumfNIOsSQVgJhFIulbZGs5UDWmaa3tUAQm7ljnM6ziUglEJKwKtw1zpOKb4RHPUVu6MeD2lOqf6hrqwOoxFQ2AkPSAiEmRNvpjfd6r8ag4TOHKALnO484sRdyJ6zSGVPXTrLkX14PUaQSe/PKTf3Ca8xoKZuyQi1OsbTq9bKJh0oqwN00CgcG4JntIWrW6qwDkwuS2EFATPm7kP4Xh7F+BlkuCaJHnRqwo/5NPDTmDzCZz6sQZnnPrYjTyXWX2GlAvKsS5gu4EtXG+vyA==
Received: from SA0PR12CA0012.namprd12.prod.outlook.com (2603:10b6:806:6f::17)
 by CY8PR12MB8411.namprd12.prod.outlook.com (2603:10b6:930:6e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 21:40:58 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::1a) by SA0PR12CA0012.outlook.office365.com
 (2603:10b6:806:6f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 21:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 21:40:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 13:40:42 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 13:40:41 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Feb 2025 13:40:38 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jianbo Liu
	<jianbol@nvidia.com>
Subject: [PATCH net-next 0/8] net/mlx5e: Move IPSec policy check after decryption
Date: Thu, 20 Feb 2025 23:39:50 +0200
Message-ID: <20250220213959.504304-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|CY8PR12MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f37fb3-c47b-4470-81e2-08dd51f7432f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUJuVXhaek1ld2xlN3Y4KzY4RnhLZm00K1F4Qm10Q0RwbmtlRzNiSkVzZ3Vu?=
 =?utf-8?B?bktaS0dOMHVrN0hDOEd6clpDV2w1aTc5dEtTVmtwaEJVWFBuQzhGeHBZT1dU?=
 =?utf-8?B?MkhnNnhJTjUvVm5md3FrQ3hlY2UwWTRrSkQ4SXF5dEo4T2hoOU90YldtOWh1?=
 =?utf-8?B?VHllZW03WFYvWFFyQVhWTDRhL1cyWURZRk9zSCtWTkZLcnd5RUVQb0krNW5k?=
 =?utf-8?B?cUVrajBWQ1V2dUxZQVdCbDhzVDNucThJK0tLa3d4dy94Q3Y1emcyU1lxUE8z?=
 =?utf-8?B?VVlOSDFPOXJ4ZDFXU3ZXaDh1b3ZOdjBwdC9LeWp1aGRnRERNMFRLTzBnbzRU?=
 =?utf-8?B?aHVmMU1DOXl3TnFFR1JCY0VzcUpYSzN2VzhyVmRXMjgvc0EwYytDRlF6QkIw?=
 =?utf-8?B?aFJ1YlNiQ3J3NWJna0ZnZGVNRzZKYUZvTXFocm5qYzBQdWxtSnZrempBQ3RS?=
 =?utf-8?B?ekdZTmVhSUM0WHRQOXRrUDk3b0w5Z0kwQTJna1hTc3lGeWovdUtXL3BDdGlL?=
 =?utf-8?B?TWVxenorN2hIL2MyVEtLOVY2ckh4ZzhmUDdXbWEzc2pBdTgxeDNYNFdRV2M1?=
 =?utf-8?B?SnRiZXpyVHlXRk85WXhLVS90ZVRyMTFSVk9MMkxSejN1OFVpMWxkbUJuZlUx?=
 =?utf-8?B?a0FSTDkxbFQwdDNTNDJVSU1YWVRHMmlzTUNZTm9tcHNKZmpHYXpjMXRibkRM?=
 =?utf-8?B?eVpsaGtUYmVxY2wwejg0NmE3eXBQU3E5czgrVW90b1k2Tjl1M3NtT1dQZVlE?=
 =?utf-8?B?MmN6emdQUXMxL05nNFk4N2NDK1Jad0xJejJha0xBK3M5RjdlcXNsWGFndXZ5?=
 =?utf-8?B?cFI4VG5EalV4UklCNEhrRXk2cERrY0l3eElqbEpMc0RDSHQ1aWM2emYrcUhp?=
 =?utf-8?B?MjZoOHFiTm12WWlFOVRuQWdmY1QwNFRJK084YkM3K01wV3B6M3Vxc3dURisv?=
 =?utf-8?B?V1loQnNLc1ZtNDQ4S05UenhVK3pLdmFreDdzcEtybGxhMXpESitHVnB1T1FH?=
 =?utf-8?B?UWtDWmNZb20wOVNHWFJDSlN4NDVZVHNNSEg4Zk9UTGZxWC81NCtuajhpZm1Z?=
 =?utf-8?B?cDM2bzg1UmtSL3hBWXk3N2NqSXlxa0FSc2VjdGpPTU5JK0hMZkdTemY4MTlR?=
 =?utf-8?B?N2ZONjgzdEJ1YTBEbkRWVmtLOFVSNzU1S2MyZ2ZIdmxYUWVnYVNzUW03bUlu?=
 =?utf-8?B?U0lYb0JFeEN1YUJ3Qjh2cExxYXpkdFNlR09EdTZIbThvNDh1d2VwcWFXNXZ6?=
 =?utf-8?B?bzBCbDB2THVrZCtZOTdZb2VVSm9WbmxMQ2pJYkxBQzJjSkNxaThvZWNyWkJo?=
 =?utf-8?B?ZmZWbW5OTHBObFVwV0xxa1A4VzFhMUxkOXBWdERTZm04akJ3ekVtdWhvdHB6?=
 =?utf-8?B?QUY4M3ZzaE9NOCtFc05FbXBrMUNNTXR5VFBzWDc0QTc4Q2RyNjJUdXIydDZ2?=
 =?utf-8?B?SjlneEZySnQ4eHozQ29xRTZkektHYVNnRjhGdUY3ME1Pbks5Ry9Xb2tzZld5?=
 =?utf-8?B?N2FUbFprc0NIQ1RUZDErZnpCQkZNaW9hOUZUVTdFaU5WQkxJRW9FSEJHOXQ2?=
 =?utf-8?B?cEtSQjJsdThMRXJmR2Z2YmxCeUsxbjJ0dXp1czRZTmkwZVpqWm9DYkRFcjds?=
 =?utf-8?B?bmtyS2hrdWRoUUt3Nk5TSmJWU0lyLzVlam41SFh4eUtHTmtPUVcwTXJoUG1v?=
 =?utf-8?B?MjJUVkNkcnFuTG1naDBadXhIcVJ1Y0Z2MVlFckRaWDJOdzdqYmhhemlPS1Jq?=
 =?utf-8?B?dklDVVFyN0pmbVhHSUJISmVMNUJ2ZUtMNXBOaWlkTS9RUmY0NEFVUEpIRWIz?=
 =?utf-8?B?NnFGUDRjMVJWSWJQdk9kREVDaWZvb0YyOGg1RkxSNnA4TitGdDFrL3hTdzhE?=
 =?utf-8?B?SDJTS1BRL2JmUWkwQ2NGUjkzYU9wMzcxMloybExWQmNpdWhRVGlZREtqWDV0?=
 =?utf-8?B?cWkxbjZvZGdyLzVhQm9BMWNSaG9LaS9IZ0c4UFMxa1FGbnZhenhLSnJuUFF3?=
 =?utf-8?Q?C7iub7foPQRwIvFHgeuDfdupbj9HjU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 21:40:58.1187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f37fb3-c47b-4470-81e2-08dd51f7432f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8411

Hi,

This series by Jianbo adds IPsec policy check after decryption.

In current mlx5 driver, the policy check is done before decryption for
IPSec crypto and packet offload. This series changes that order to
make it consistent with the processing in kernel xfrm. Besides, RX
state with UPSPEC selector is supported correctly after new steering
table is added after decryption and before the policy check.

Regards,
Tariq

Jianbo Liu (8):
  net/mlx5e: Add helper function to update IPSec default destination
  net/mlx5e: Change the destination of IPSec RX SA miss rule
  net/mlx5e: Add correct match to check IPSec syndromes for switchdev
    mode
  net/mlx5e: Move IPSec policy check after decryption
  net/mlx5e: Skip IPSec RX policy check for crypto offload
  net/mlx5e: Add num_reserved_entries param for ipsec_ft_create()
  net/mlx5e: Add pass flow group for IPSec RX status table
  net/mlx5e: Support RX xfrm state selector's UPSPEC for packet offload

 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |   4 +-
 .../mellanox/mlx5/core/en_accel/ipsec.h       |   5 +
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 620 +++++++++++++++---
 .../mellanox/mlx5/core/en_accel/ipsec_stats.c |   1 +
 .../mellanox/mlx5/core/esw/ipsec_fs.c         |  15 +-
 .../mellanox/mlx5/core/esw/ipsec_fs.h         |   5 +
 include/linux/mlx5/eswitch.h                  |   2 +
 7 files changed, 558 insertions(+), 94 deletions(-)


base-commit: 5d6ba5ab8582aa35c1ee98e47af28e6f6772596c
-- 
2.45.0


