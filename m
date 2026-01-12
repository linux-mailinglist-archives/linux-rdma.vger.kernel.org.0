Return-Path: <linux-rdma+bounces-15460-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C65D12BDE
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 14:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D13BE300EA21
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 13:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA25358D2A;
	Mon, 12 Jan 2026 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UUK2z0gl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D4427602C;
	Mon, 12 Jan 2026 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768224180; cv=fail; b=ZLBMDSkfeIXevbz0+cu+2Ziw/34WdE6xJSMLBrsEfcogprjNhVv47Ryhw2SwAcOwsOHOlcdvi5ubm+HT8KeT9uTZSR71svpXcCfU84q1LdK+mHUrv0vIEuCTzW7yRE5MVaG+SHjVw2lmuMcBEntLbUoGhhnNmcvptDsEqfMIKEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768224180; c=relaxed/simple;
	bh=XsPKDeM9chUns6gELv/tvjyvR18aigNT8zkmAGpNQOE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WQHPuukczxjbRTnnhXyiqFjGruFTZJWHQmLigQZAcHaNcXJ4nUfYxiB++01QzJ73ZFRB5XlXRhAXbvj+WROcZhVBb6hSRwSA8tNHmIN4LJXpBLrz+aaxkWB6XE0t3Z7P7bzNWLGVhn3VxD25liil4tRx4nUSWg+bUXD1+VoIsqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UUK2z0gl; arc=fail smtp.client-ip=52.101.61.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuLZ0E7iVLs0b2XvXpjye3Dp1L94SINpEhDD/tr3IfD0+qOegLqf/oouqAESABM97hrPnubeoX0jIg6KfjjQFW/nnZWC+qlT3/IXykI4n4UuAJXUcT0fltehzVkg2zselSmwHb/zdj8oTgceI9OHH+G88WF1G45FqzHYRlXvhdyZzdup9R/WsRUkp3AT3wTbRhRVauAo3JKjE7l7sHRQegGGZ9iic9yqsiumuQ4FwxTpc9ZF0+hXdHWdAkLPTqXLi7feYctqFMeGgQEUu2Vg8SVFJ/j4O8QBB8b6zMU5GHUfSlcCmmgMNv1A6/dQLxofKpQ96t+BPfS+devQOnU9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaUDQaEBfRIh/hmc20BR6OJz5lcaPoRAm7LztmxjGK8=;
 b=nX8mo3BIzeOntct4sqCD5ZsohFHgfz5rZiadxgzyd6ZpS2g0DgIcOrVM7AltRXk87LZByrMOEPfNpnuF+iA6gqSTKfpNXnGc6VlCbaQb6sE3JRqazqYxOoxyX5RBgJnKJL2SlczmS6iIXyhonq7hhXiHeM26coMUojZZPVoe57bfCxcb7ok47Bqm/FTxow6/6JIzEaz/bMh1iETCr9/eKP+u9l+7mLDRuoi2yotAA25wVpPBqyMwtwqVrBv2bO0C/loDqDN+mVppIOgSZAjGpNBwN0L+dWEADhBFSWZ/pqnZThkh2I5O8OYYZYABV9tAQWkUrguBPC3fTANVBSE6bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaUDQaEBfRIh/hmc20BR6OJz5lcaPoRAm7LztmxjGK8=;
 b=UUK2z0glBAyVhuRhfFMNFaKRoC9VtZRM4pkO+9zg8EiRpfY4Vsa+Jcmqhh/lISTpNtA9Fx836FpxnugCOUtMGOkywIX9QZmCVF4EOcqLn3vm7LtCPCqP4WQ8ZkNhNN5r2sLswTrRMmG+vUh7ct5voemsQJNxQGPINyoHkdUBJEavQPstuUvJkSTfwTxeK/yLQemrMSEmRge2dRznFmC1F1nhtwHcAxOtTWcZHqhmNATzvwJJHKqJi3MUmejDBTXGKkjp5Nh3bUVCL1CwTd33gBxsmZIXs9RmLb/crFDC0Tr9vbKoNmKYc0PxC1uhtBiObLJmtId/qYEHxmxqSl8v7w==
Received: from DS7PR03CA0038.namprd03.prod.outlook.com (2603:10b6:5:3b5::13)
 by LV8PR12MB9081.namprd12.prod.outlook.com (2603:10b6:408:188::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 13:22:52 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::84) by DS7PR03CA0038.outlook.office365.com
 (2603:10b6:5:3b5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 13:22:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 13:22:52 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 05:22:34 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 05:22:32 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 12
 Jan 2026 05:22:28 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next 0/3] net/mlx5e: RX datapath enhancements
Date: Mon, 12 Jan 2026 15:22:06 +0200
Message-ID: <1768224129-1600265-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|LV8PR12MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb5093d-88ac-41a9-cbac-08de51ddb079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CvFyUAfvxXShHi54tCmAtV+KMEteO3NYV7EiPsazuV6+Jm/6vCBj0ZWX4lVW?=
 =?us-ascii?Q?UXXvvA7rPNx+rnznqp5ELBNZqUazeUG/1FvMKyU0o9WSJi4ET3ywRcjMO1ct?=
 =?us-ascii?Q?vHd2w6qA0GlfrnwwtDV4cB7UYFDkv3PZNtv5AmXyY+b6TDZKPQs658kWQrSS?=
 =?us-ascii?Q?PEgWgLWB758p6Axd6cV8mGxopFhGcFvD7pCm7dEA6Ws2Rmzce7xwXTLK5meI?=
 =?us-ascii?Q?BDdYKbFKhxGBEjunmnySGim5OH2Km4+V1SW0a5Ukir92JyHT60Z0uBGMBc0t?=
 =?us-ascii?Q?J4YJgIhYh6T4GIUtZ5aMdPXKIIPSPzh3ptueXslkosiInRbWNBJLm4d4mG4r?=
 =?us-ascii?Q?zfek/Tg+cEnL+jz4DJ5Kx4lCBRK9IXGnNr+BACn17Zw6mVPXmfRjC2ah4lAg?=
 =?us-ascii?Q?WtY4z81kyf1HUd9BFRmw62Y0eoUEf2ADBjS3kn3Y+n8VbQ9cd62jU54v9cLQ?=
 =?us-ascii?Q?OxyJCHueET83Q31WS/ODTy3iagGwTa62uG8SYn188Z2z/EefOaGwOIk/1glH?=
 =?us-ascii?Q?b8BE8L9pRinH2QbHQ34ts7UXk5YV2LOFduLjVNIEdoH6gSO8njosw/91gDqL?=
 =?us-ascii?Q?TbuZB8kBNCk5GNQYtbodUZ77GANVSVjGolqlPMLxfCjUMSdYrudKqcLqHKHR?=
 =?us-ascii?Q?b7t9Q+fCru6xd0AhY6EENvA7kbqL5S7IxpfFTxhwHGzyqZWv6pzSgrY0hm6T?=
 =?us-ascii?Q?dN70xcI3fDf/WCGGI+0xfP1PMKx5IQefcZowutCPiB8Bv1NadwaXGxXXRgSt?=
 =?us-ascii?Q?g/ztE09wGWSCHqaR4RmHJxxWEXZnonrgAs2X3hyuOjRol7nyVJ0X6sXuWSoq?=
 =?us-ascii?Q?4qKYeqnS8JE4xBB/bSHa1CjHnly9Dt+nBU5W1TaOAVO+NsoTXzArjmvYbnHR?=
 =?us-ascii?Q?oOB4/B7sSDZy+XQxv6qagn5NmGccRE8pqnioQfeaLsKPPWpl5Ru1V9W/bxNv?=
 =?us-ascii?Q?cIKfKtZdS0FADEbE1VJp4N8BsQmPCJnugcHNLODufggtKJEHyxDej/ZDfrV6?=
 =?us-ascii?Q?eJoERxWqAiENI1Ad0tn3gtH9GmX3UtRVicY4JvjIlqTDNKanq2JS0pwfvM1p?=
 =?us-ascii?Q?xN/lxpcYj4863VRXM4on47aW2av8CecDYQsax+ykAIwFR/RZ9Hn5GVzjL27j?=
 =?us-ascii?Q?+SQaWPKvBVDBth6m+Eme6kOxsp24SG08xy3q3cO1vPKU59Ty16a9DBguZRsw?=
 =?us-ascii?Q?s8lxnrT6tn1gnQs7uEvXmBNJuNoNQl393609UeRjHqg1OFp3tGrMMKG+V8Hl?=
 =?us-ascii?Q?MruIg5VlRygM5J6B1+JIVCGzBg4MTiPwO0aSDFx09w5BlDmTtozT5n4yP4cS?=
 =?us-ascii?Q?i2epegc4WFCFc+Qng0XLfNbyh8pw8n6tt0M8A7+iLIpT6JTv9NyGFw7DTeEP?=
 =?us-ascii?Q?GQQFg5Dp2crB2E7Yu6y5+q+h5w/SoV/R9QmJHRzPGSR8UeaHDNcRVZaq4kRD?=
 =?us-ascii?Q?mekjq7hvSmo+6kqjZIRVxV3nxkLswMEmnTquj8qktGAibXK+f7fkpReVJOGI?=
 =?us-ascii?Q?X7V9Vf5VKSLpKpADvP08meIZeEhFjY2wa0kgV4cQ+CKfaOR3cDF3NLnUjbVj?=
 =?us-ascii?Q?+0hC5M67t2kWigypb6k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 13:22:52.2133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb5093d-88ac-41a9-cbac-08de51ddb079
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9081

Hi,

This series by Dragos introduces multiple RX datapath enhancements to
the mlx5e driver.

First patch adds SW handling for oversized packets in non-linear SKB
mode.

Second patch adds a reclaim mechanism to mitigate memory allocation
failures with memory providers.

Third patch moves SHAMPO to use static memory for the headers, rather
than replenishing the memory from a page_pool.
This introduces an interesting performance tradeoff where copying the
header pays off.

Regards,
Tariq

Dragos Tatulea (3):
  net/mlx5e: RX, Drop oversized packets in non-linear mode
  net/mlx5e: SHAMPO, Improve allocation recovery
  net/mlx5e: SHAMPO, Switch to header memcpy

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  20 +-
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |   1 -
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 312 ++++++---------
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 373 +++++-------------
 include/linux/mlx5/device.h                   |   6 +
 5 files changed, 227 insertions(+), 485 deletions(-)


base-commit: 60d8484c4cec811f5ceb6550655df74490d1a165
-- 
2.31.1


