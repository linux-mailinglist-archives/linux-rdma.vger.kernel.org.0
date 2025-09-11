Return-Path: <linux-rdma+bounces-13268-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F031FB52996
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 09:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A08EA01AF4
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 07:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B64A2698A2;
	Thu, 11 Sep 2025 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N5fWZEnz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57431226D1F;
	Thu, 11 Sep 2025 07:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757574655; cv=fail; b=PwwvbZdD0/902mF0RjId+O6lth5sfm6mU4umLgPNyfav6oEbYebeseixhKYWRLT2Ee2YKkdQ9gDIGzxXdEqY+dAmQdC5G8n47RPx0FXWAn7Nu8b8Zzz6K7GaZKE8k3rFHTKsICn82KhcLbKsZwIGc0zsMY4hcm+7tZgYlDHQhBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757574655; c=relaxed/simple;
	bh=0618bqFhMhET3U9eg57d8Oh0xUMKdJ3CmbjjrM5fT60=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RxP+jFAKwkzBO3RBNSb9Nw4UvKqOsT582exqt5u0WxwFQNThjwgCQbkRlw6760sboUN8WmH3agvTLqwrQvq0rWQrg/r4HbJUqLi6hQoOFb5nRQeM/q1NofJJVCWm2Cxpp//XRh7VYAd4iykSNAscmyIjkJdW6Ik8P+Nlvlpq/o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N5fWZEnz; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4y9UDUSOgfeQ7aNkCDucNDnueTjZONhNvml90AxIvM8wAZRskexf47i62IGhCW/IjCnItHEZ91NGfV/ZkLWWtwYPo1vcdxv7z9oqtGfuyfH/JU2Ie37AMtfcQl06nQRgXFaG9DfiEFJ8wiQLtZgF+/m8tbwtXoBHtOowhowYsbjbwgQq/oDvJvpqiOxRgOTMH63FI7Am/wy5WFocKwFXW8dKhDx8FlSwYKKw9tNSXn4LiQo8zKrlFgb0mRFTtWRkzMW8qLe5iIDflmyqIosLKpWTGHP1T2+qL5jDTHFwY87hufTISZnhOVMvbXIZ1N6CTLuk4Y0en1YCWdpj4E+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJJM981ZsRzPMcruCaE78mfzfQTgkktGkPG4cp9EafA=;
 b=KKJVh5G1TceZw1RPUNCVEGOrzch7No+m4KPCEmM8Zqoovz677Fc5zfRm0gAedvSayaEppAIWrpl8RLozbAZr6e3dvsWHMxm3tbzaYwtNyXXlLKOOXu4T0kswYqyNgU65ks3EXwMans1rg9trstaZzphn8EpUaRP/9RaSXY6aqU+AGqoVFdfqM65OEATXDseEMambvlxfi8x36rFMmS6LmqD3Gx8D2Au+uN7TD9QFwLjEBrl/8VRay9nEfam/dglNhThmyCrrFil5be6AXnDjKzQ3XdUV3p2Jd4GELOkJ2zUDq6IoKA3MUGSbj4oKYA4eB/jREw2P9FWSSdupwDh1tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJJM981ZsRzPMcruCaE78mfzfQTgkktGkPG4cp9EafA=;
 b=N5fWZEnzMhz/xphUBKbZWZ1pXSkCALeT96agt863p0wA1VFWJbfUmanFdCeLzoj5UD2ppAe7qVSedXf0WTpcaEnLJG5M3QTHLqf1vKrRRnAJuczXPV9p0ZP06Snz/0bEexR8Hg1AbNQiWh2qI6yrDq7JAUZ5+60e8/iiz9fZ7/R1zhG8v0NYA2/Dk5fvMEuaQCnERBfriSZFkpwOFzz9NtatmSVXxbE5EcAhhIIvBabSK04SScnmf6sareXgBUvIEluokgUqsZu0VB3n1qYa3IgW7kSbr7HPXT21QfipsM4OfctrGxVagQ1tBr6gzqhq69Ab2Kcm8ZgcItFLUusctA==
Received: from BN9PR03CA0388.namprd03.prod.outlook.com (2603:10b6:408:f7::33)
 by IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 07:10:46 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::26) by BN9PR03CA0388.outlook.office365.com
 (2603:10b6:408:f7::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Thu,
 11 Sep 2025 07:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 07:10:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 11 Sep
 2025 00:10:32 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 11 Sep
 2025 00:10:31 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 11
 Sep 2025 00:10:27 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Sabrina Dubroca <sd@queasysnail.net>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>
Subject: [PATCH mlx5-next 0/3] mlx5-next updates 2025-09-11
Date: Thu, 11 Sep 2025 10:10:16 +0300
Message-ID: <1757574619-604874-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|IA1PR12MB9031:EE_
X-MS-Office365-Filtering-Correlation-Id: 7933a2e7-52d7-405a-eacb-08ddf102546d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WE5CaFdlY0RQRFdzSEdDbUYyVUNTamVGRC9Rbk9QRHdXYWMrWUhJZ3lmbmVY?=
 =?utf-8?B?VXpNcUZOd3BxbU9lUTByQ0YrSGhMVTA3WUUzaGs5dG5Pa0tkb3VhMHJMeVJh?=
 =?utf-8?B?M3FrMWZRaEt5Q2xDUTJPRWkvVi9WMzVlU1NxVHpUWG9lVUVaVFdRWjhrZVp2?=
 =?utf-8?B?aXZjeTJwTEkyNm1TSEhjckZsamxTek10L0xzdG5HQ25xM1BEb3pQL1pmQ3ZL?=
 =?utf-8?B?K2hqR1Z0ZWdDVVNoanVjS1FBT3FMUGlwaXBvU2xFczJQVjYyNG1hTXpUa2xS?=
 =?utf-8?B?cEFNQlM4M3ZTeEgzOTdNcjdoMk9TNGRHYXEySE9qZXUwMVVGUzZpdGZmU1RT?=
 =?utf-8?B?S09QSnN1bzdlejA1eXgrcDIwalg2QzRkV2xHU1lVMGdnVmk3TldnZlhleU84?=
 =?utf-8?B?ZkxXLzBFOUYxRThNdE13QXhnZ0hLbm5LcDZxMW1pdnFHVVhnR2tjMFJiK3VL?=
 =?utf-8?B?dXAyUHNQUGk3d0htOGFISm11UHVTUUZBdnRWNXhuNVZPdWE1L25UK2lTNlBT?=
 =?utf-8?B?WGRseVRVbTgwQlVxZlZkMWFwTk9yQnMvL01Hby9XRUxYVUZUTDEzdUFiK3ky?=
 =?utf-8?B?QXBoWUh0N3dsTDlTUytmMU9rMHpzTzJNNWViRlloQ3R5eE9HQjNldlNIQnl4?=
 =?utf-8?B?bnYyN0paUlpGMTloOHNqbzR1OHJTbzBVSkhKSi9HWCtrdXJTWFFTZEp5V0VB?=
 =?utf-8?B?WStFd3E0TTgzcGo4WkhrLzlSbGtHS3pENEIzS1IwRG9kUTNGQkw3aUNOaDNE?=
 =?utf-8?B?U08rTWtxUk9UZmtDREpSMXVEaEt3RlJyRU1zUWx2WDV6b3FNcjZyTExicmNV?=
 =?utf-8?B?Tjh4dDl6R0wxVVpWbXJyTWhLclN5UitiK1FMWmpsNU9DMUpnZ1I2dXJ5ak5C?=
 =?utf-8?B?RU5MdVZuL1lGNnE3dDIrZ0xUNFkvWHZiQ1ZGMjFqWk55SFVxYys3UWNLNDRE?=
 =?utf-8?B?WGJPYnNjTTNsVDN0VVhMOEhibnZRUitHSnY2NkhndG5SR1A2bzdUSUxWc3Fz?=
 =?utf-8?B?YVN1cUtQc3M5ZmU1cysycDlQT3Jhd2hzQ0dsNFV1dzR4STRYNmRGVENqOFBG?=
 =?utf-8?B?SnBXeExka0RuY0dMcjFhWmtLRm95WXNkanZQVHhrNHlhODY4RVVoejJiUUhN?=
 =?utf-8?B?Mk5pdzJSL0ZFUzBEcGFLR3dFaUhmRjBLei9PTFRhcGl0QlR1VEVPemNoMno0?=
 =?utf-8?B?RmNSSmJLM0k5NkJJRmliZjdERTBTU25JTkFGWEVKWXkrUlBjOTJ2WnptQnZC?=
 =?utf-8?B?NXlZTVVqeGlmKzV3Ylp3RTZOblc3aFJ5bkVXYlErbU5Bc1k5RHhVWWhFOUVs?=
 =?utf-8?B?Nk9iQzFqS1BDc3NTY1ZMSytXWVBuWTlVbDN3ZnRiNHJwNU5jQzRucUtWamdS?=
 =?utf-8?B?TVpwZTkxUGJtVEJRN2lKL2VCWGtXZUhyWTRPcHdQd0lpWXpyckN0b2VodmJp?=
 =?utf-8?B?RHVCQWNVVHY4ZjhCVUg2aUt0M3QrRlRvMGpiV0t2bnBPT2xEVjR1Qk51NnBB?=
 =?utf-8?B?TGZyYWRqMW1BRE4xdWFHUUkrRzBENXoyM3c4eDNISU81U3pBWGhkZUFNbTNy?=
 =?utf-8?B?U1pyZ3NSWFAvOGZyRWZDY2N2WEx3SlJYTlc1KzEvU0FTMVZlN1BVUFNyZUcx?=
 =?utf-8?B?SW8zUzZvcm1UekUzSkZMRERQUmNITXFoRkFaUFRrSWNLZHBKY3BZUWVlQjhz?=
 =?utf-8?B?cUFPM2FuU2dpVzU4YjNrbG0remdkdGhMTStCbG9zajk3REFsMTd5R3hua2RZ?=
 =?utf-8?B?QUVMbEZQZFQxN1dXMENXY3NEbUdEZVFEQWw0VGhsOXVNMUNDbG5RUGttampZ?=
 =?utf-8?B?RStncjh3UEEyUGtJWEZRQVY3U1VXcy9kbTBDRC9YTk13M3lSL2xEcEtVTnhR?=
 =?utf-8?B?WVRmc0ptWEo4K1kxVG5XZ2FyTlFDNFUxRmp6YVNjNWtzS0VPd3N3ZThCWUNU?=
 =?utf-8?B?S003b1gwSWJmR25ZNVpNQzh2ZnpybkdhekVjVnFveWFMWHFNSWcvSkJpOXRa?=
 =?utf-8?B?NzlCeVBhRE1wZHcya0RJMllPazRnek9VUHhBcGEza283cVVYTmJaeXF5NnJn?=
 =?utf-8?Q?lNHcLc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 07:10:46.3429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7933a2e7-52d7-405a-eacb-08ddf102546d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9031

Hi,

This series by Carolina contains cleanups significantly touching shared
mlx5 net and rdma headers.

Regards,
Tariq

Carolina Jubran (3):
  net/mlx5: Remove VLAN insertion fields from WQE Ether segment
  net/mlx5: Refactor MACsec WQE metadata shifts
  net/mlx5e: Prevent WQE metadata conflicts between timestamping and
    offloads

 .../mellanox/mlx5/core/en_accel/macsec.c         |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c  |  2 +-
 .../ethernet/mellanox/mlx5/core/lib/macsec_fs.c  | 14 ++++++--------
 .../ethernet/mellanox/mlx5/core/lib/macsec_fs.h  | 15 +++++++++++++++
 include/linux/mlx5/qp.h                          | 16 ++++++++--------
 5 files changed, 31 insertions(+), 18 deletions(-)


base-commit: ff97bc38be343e4530e2f140b40cbdce2e09152f
-- 
2.31.1


