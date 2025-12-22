Return-Path: <linux-rdma+bounces-15157-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D06CD6258
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 14:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82C5D3030FFE
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 13:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F29A2DECC6;
	Mon, 22 Dec 2025 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YzlhyItl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0F52D877B;
	Mon, 22 Dec 2025 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766409971; cv=fail; b=MHabYM120oao8BQcRsKt2o0lxYM8NV95NbVyR2+IV/rvSgXC24qJ1eP5XPnKns2uBZn4KXhBWmqAH86rUAPCVC0l0Sh53yyOnVA2L2wQycCMwqFiDCAy7jj0G1M6ypT6PXk4HqiWI1HacIN6BcL1/BK0Xp0WNN9Pszmba9ahoSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766409971; c=relaxed/simple;
	bh=Dq1SaCWk5u00sOdnXGu7EBxlElf9XgsEws8Myocjp7U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tbFebfHs1iIDRwe49ie90xTJT2H14E/JnEPemJUbA7PuPj2BsdiU/5TMGynGVHW4fAm/wgx1azthwRDUXLIhfTR0ICfRKMCvZTzIN9U9BoI4RZ22O4rwZUjR7ACN4mJRCHC8V4FnmhCF2674NL6jSGNADwgwmoyqA45NA45VpvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YzlhyItl; arc=fail smtp.client-ip=52.101.52.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbaopW6znyreaTYgeNsbOGjz4PiRPh6H8WYPowZumO85o/vgz00Gxt+Ts+wwDZBpmokmf/8vK9TP3FwFmqzuitvtYBOlIgSPcRCcMBBYKy/pEiVn149EZWDNyEsXAXTDIis3x2ivUK2VwgRTXfq62m/CWHWW7ibCXw8pis9TCdF37sLTxi49f8fI9ywJCKYg9HbwmYZbCpsPQrmPSU05q+1C8Gf9GNpbdvEkfF9855xOq2AEpvVusODkhO8ZYOG0Gfqt6kwgx2p8E244Ij52sOmijta1lz91j4QwjHoW4ExMm5ypzcNgJcskeq9SskKbcIb8WLM0qduKkR/8LeYOHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0b6j7fDILSbj7w3cHPbjkP3+MIznUpeSXeYDMqDqgY=;
 b=iLMuJCrvTPtQGPFfQwwSCjKQ9IREWB71Qe4WHrRbD9hqYOkig7L4MsUsGgpiAFOCFy5AILCb+p6xv4l/VaQhjyevBsx/4susENjEt4SMtS9urIO9rwTjAa7lDPMhz93A1UyFLgScS12vV7TfM3+HYbd+prnCX0aooJLXaxUo36/JLm1OUN8BSyph/HBG479NG40RtToCfiSdErg4N9eYnLbt75kjn57rFhpm2vj2jtXCE88HtOTJi1WqIjLRxM2EuCh3jg+7SYeFHl3fJ33ajx+2KtRQJ3RbaDRI11fX5FjGgqgjF2ojByUhkHky60PnLBNip5zzXR96hnjvK9H9Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0b6j7fDILSbj7w3cHPbjkP3+MIznUpeSXeYDMqDqgY=;
 b=YzlhyItl0yS3EXpZdEB1YV2UKl2meAEEKAMTKqwllXT7BgaF0CQvI6osdW5KssW+LA2UsDGYy7nyLvuaKRP16brcJyZSZzgU7yVW2NlAIsdCKF5Vc+oTnFb5RBMJr3I6BWktOqqAVm4MgitJmfuEHTPfx5riQQ8xTCpd1jkXbsF8EGWuGcNiVdeVpvBQs0h/Qe25rGMdTL33wCpzodAgHybDE6IzNdLHCiXcGDhKaFKWGQz+7dhc5/C70CPZzhw6LA7pq0aUKziCgqCTatxKv1CQVdD0lBy1dxLwQHCymrMcXMMIamGb+4yzf36AH3EnwbCsithbsVpHv1FO5iJ5Xg==
Received: from SJ0PR05CA0092.namprd05.prod.outlook.com (2603:10b6:a03:334::7)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Mon, 22 Dec
 2025 13:26:05 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::92) by SJ0PR05CA0092.outlook.office365.com
 (2603:10b6:a03:334::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.10 via Frontend Transport; Mon,
 22 Dec 2025 13:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 13:26:04 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 05:25:55 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 22 Dec 2025 05:25:55 -0800
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Dec 2025 05:25:53 -0800
From: Patrisious Haddad <phaddad@nvidia.com>
To: <leon@kernel.org>, <dsahern@gmail.com>, <stephen@networkplumber.org>
CC: Patrisious Haddad <phaddad@nvidia.com>, <netdev@vger.kernel.org>,
	<jgg@nvidia.com>, <michaelgur@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: [RFC iproute2-next 0/4] Introduce FRMR pools
Date: Mon, 22 Dec 2025 15:25:42 +0200
Message-ID: <20251222132549.995921-1-phaddad@nvidia.com>
X-Mailer: git-send-email 2.47.0
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|MN2PR12MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d8e7b2-176e-4644-6585-08de415da844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OROAvjRtS3pQGe7D5F7bIiN8O5HOYyX5D2Vuu4qc3K8DG6ppTJZw2e7cPHgQ?=
 =?us-ascii?Q?/MqCHqtegNUjNefSMFOISL3BZCa2GnHFrwn/8dFZhCOw0PCwQ1aHiO9PeLVu?=
 =?us-ascii?Q?TSXeyO3R9IuclJu/QV8xdqP1J/lmUqrgWq8YONIZgln/x+Nn6OXtwaAOAFQV?=
 =?us-ascii?Q?lKN5vFMV3vEdrgK3ZWUwaeIgIZB184y3KjWBQbv8j/pnNM9g5kfXe5w833bL?=
 =?us-ascii?Q?N68nMi1uOc4b3iqxRzKhNNegQQdohiCodjEzNdAHnhwaMIiafSeuncwV07DT?=
 =?us-ascii?Q?0lstkRCje/Y75MHF90m85tzvAGDgl28RZr5LzJ043lVhcud4RcnVnhU1Zd5p?=
 =?us-ascii?Q?RpLf/qOtqPVgoCX2MwB/X+32Aqmd7bV5Wua0HqOEbqnFJUy0roYvBYOnOMng?=
 =?us-ascii?Q?lqmCy9ntK9CWRoGncRr8o3/+1xrtpuU0JYR1uQnJ9IDkFwFtEmkF7HJk4rVE?=
 =?us-ascii?Q?DZY57EjfcTX3tYJE3DwN+vbzvWqE2KbyIGu7TvK6MbnbEuPKOCDPquyiONBR?=
 =?us-ascii?Q?owYUTHqXXW9hDZjx4bnSAdISRmVJzOS7P6/1zHJ9u8pCBnmI8iHTH6UAabrk?=
 =?us-ascii?Q?XwnDe4sYIF5QbW4DiKPQnLzol//UaGnYHmkOPOSVmasKRMg9Sh4CHVEtTgHb?=
 =?us-ascii?Q?aF7ugKkajOGAdLjjvRbyIa7ZWSAS3OMzX0IJnyrZZY9itRQkwH96z8GnnPdX?=
 =?us-ascii?Q?gjyAyppVn4Y7PJxT3YPPuocyVQKjqmTYWRa4AqryfHWfLx3T1HJUiiT9QxCL?=
 =?us-ascii?Q?ueMsMa6QzHk9Jm5woN09SPQeEtO3YgF4DRwoCSPUUCqVoewZ4VuvUaTTOWnV?=
 =?us-ascii?Q?dBEy4WuhOOSiHqaMObsnPQhJzZnFR1671CdBfC4T5fc7v/1ecsnb0I+iM/yq?=
 =?us-ascii?Q?3H3k5oQYPzs75DlM0TCa2CFl4rmY4bHrZR9qNE49Z7EpOOcsRcEAiMYGSULY?=
 =?us-ascii?Q?ao4k1FOu6Uu71qRE9K+JrsMGJQQuXa636RI1zixGywEcQrOPvu3czoSyzG1l?=
 =?us-ascii?Q?6fG/D/qoLaDfXreg4F2bzIMsphFxjf4Gl6eB76CKdaSs1jIxiqPCDnTdrs7Z?=
 =?us-ascii?Q?xmuYxXdo7hzh07hbv4wwQ4m1s8sbj2mdNJcGEhj//VyEDy7mk2d26fWvPLQq?=
 =?us-ascii?Q?JFcr89B4xr31YnhJltW5/mKxnVWxTGOoAMoJ18qidYlCB8PCS/y5fnBax+59?=
 =?us-ascii?Q?rfXUWSAIInkD+s9/CQh+5oU/zR3uONCGsibZI5hWB8Y6HUlVzsxE8Q/n7D9x?=
 =?us-ascii?Q?EK8w/LmtmBU5py1xwCYWj3ToDsF1Qs+d5504LpoyoEPH36Ql61lOzgdIclND?=
 =?us-ascii?Q?WR4UQvq5FSvCpXEdfYhg0bl6FJ2Ftz9dIG+dh0+EgmSbXJkPtXgk1/+AYddp?=
 =?us-ascii?Q?GpCWeJVCWOAJ6tW/y7b0eDk57xbAy/AOjXz/OuhTgImNiW7HRwjlBVTXVqV5?=
 =?us-ascii?Q?0zBdlHO11TVHdIBwEJXq4+e/jKddmZEjVfYNMul//CkvtZEzInFE5Ov3+RaO?=
 =?us-ascii?Q?YAE8+tvm3pwHpHaWnhTuoPp5Jep8nyGtprnLWb3hlQMTgrmu6+41iF5w4ZlG?=
 =?us-ascii?Q?qTif9z5i6YG7stIJ+pk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 13:26:04.3833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d8e7b2-176e-4644-6585-08de415da844
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304

From Michael:

This series adds support for managing Fast Registration Memory Region
(FRMR) pools in rdma tool, enabling users to monitor and configure FRMR
pool behavior.

FRMR pools are used to cache and reuse Fast Registration Memory Region
handles to improve performance by avoiding the overhead of repeated
memory region creation and destruction. This series introduces commands
to view FRMR pool statistics and configure pool parameters such as
aging time and pinned handle count.

The 'show' command allows users to display FRMR pools created on
devices, their properties, and usage statistics. Each pool is identified
by a unique key (hex-encoded properties) for easy reference in
subsequent operations.

The aging 'set' command allows users to modify the aging time parameter,
which controls how long unused FRMR handles remain in the pool before
being released.

The pinned 'set' command allows users to configure the number of pinned
handles in a pool. Pinned handles are exempt from aging and remain
permanently available for reuse, which is useful for workloads with
predictable memory region usage patterns.

Command usage and examples are included in the commits and man pages.

Michael Guralnik (4):
  rdma: Update headers
  rdma: Add resource FRMR pools show command
  rdma: Add FRMR pools set aging command
  rdma: Add FRMR pools set pinned command

 man/man8/rdma-resource.8              |  51 +++-
 rdma/Makefile                         |   2 +-
 rdma/include/uapi/rdma/rdma_netlink.h |  22 ++
 rdma/res-frmr-pools.c                 | 342 ++++++++++++++++++++++++++
 rdma/res.c                            |  19 +-
 rdma/res.h                            |  20 ++
 6 files changed, 453 insertions(+), 3 deletions(-)
 create mode 100644 rdma/res-frmr-pools.c

-- 
2.47.0


