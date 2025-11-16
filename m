Return-Path: <linux-rdma+bounces-14497-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDE2C61B3A
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 20:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26A044E0245
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 19:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ADB239E63;
	Sun, 16 Nov 2025 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ofjQP1lU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010060.outbound.protection.outlook.com [52.101.193.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4467B1C862E;
	Sun, 16 Nov 2025 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763320306; cv=fail; b=XdaMc0ThfRIP1OtfMgOWDeocwQGOGPVryp6IfKasDr7rz7Sc/VeP341YcqlS9VAFCH/u7VAcbZp6r6e7IZLMcMOJ2wFYB0rsSzzWuUIw82+mNRtiGsEiwy01otId0seE12CytTA+0+4OctpMV0oZivpbgp6jxTCfeqDxYrX+VtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763320306; c=relaxed/simple;
	bh=N7Y3T3mnMnX09sIvKeC11eVNfV2oouiDggHtcl/zK4A=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=q5+QddI5lQFaKto7HHdQbNH81uPCytQB4QINBb/LGMmSWbWBEc8D3mjkbawKSKdSQ1GzvlfpWquSfkAxu/bt8SCUIJ7zlOVcXrKmhHbJJtkDClW3B+4wHpX6Gw2s68rF+QWg5Do3KeytSMTTEtD36nov+XwreRSvsaYv2kV9O50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ofjQP1lU; arc=fail smtp.client-ip=52.101.193.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3qb6y//y4dKDGqWId9nNa5QbGTnhC0f0uYNHsvb60MaAriw0PllwrIolk9vQ7LQwgGmJs2st3A3O75csQ4n5kQhZkxksrf3XfgYd2HBhC489f/I4kOnmoasX+XGo+9COGi3m3+FWBDm1RxRMVoEXgR8MyiXHgoQHH1hQrKdFYyWB9q4Op2c6uFL9+I7JVwoVuEVByh+t7MenewOYvK/BbPFqH9PcHdLNsBrKZ8RE+bntXIOKQO9bu86A0V630qCD3iTD3PE7cr5AGXkYJK13qFzxfkrSKEqxBM0vmQ8jYOe5/7SwWIeCO4Rp5pd727pAyC8YrN/psSI7G2qNKm9Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5K/e37qq7uGxhodbG0K4cc3LkRtEq4njCWEflh+sU4=;
 b=X7C5H3JjZIJxi0+dRhOqEdL+7tZX5A9s+r+HVbLWsNqze+YAdjx+ZNQ9Gk0I84IFumc7ohZYL+aNhZae6vfYwaNXOelBX6dVG2Y/t0yvLjq9//h2lkKhfgKgqvIhpUQ39vK+bThvTwBZDiOVD0pTbBR7xdSOnhizMtewfraIRnBPkSikW/qA/d10mAX9rNcN5L1wP1Fr2jMlXhkFbEroSyPJznarKoVR9IjMVxDCSjVahIhVY9+l4OeMkzI36KqF8Xdp1jwKnNNwQMYWDmrdqrvb5xTDi8lMnkLKlLC9LrpmHUdF9PdVEaJ3jnyJdje8TGecFtoFd1XhhU66vNWX7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5K/e37qq7uGxhodbG0K4cc3LkRtEq4njCWEflh+sU4=;
 b=ofjQP1lUW3ChHwJDaoWEhmYirZZcyycq07mobV8Um61BXGud8CwSV1qKVweriWvnPw68exG8wMBLfWBNk2fER4MiWPuRPQNbfpNGsTfOph4nDHedcWLE2Pgc0v5nd7dlaFjQSEN1OPUcGrnm5GvtuUB3FSNo2gcUDfIyLuRrACB6Dp4+mW7H0+1Csbdr3MI4htRpGhr7m9RqoW1Czhu11WfeIF2hBb8ZxHNdJSWqESfj0a+1KCcDXtZn3+5mp7KWdPw7XIj1gxV4WvDwd+9Ra4IXRv4Z0qRX7WqXH3K6e0ANbGjPVkEcllDBeNdrHU7tcNWO88m2WyWlQE62c5DsuQ==
Received: from BY1P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::14)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Sun, 16 Nov
 2025 19:11:40 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::be) by BY1P220CA0001.outlook.office365.com
 (2603:10b6:a03:59d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Sun,
 16 Nov 2025 19:11:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Sun, 16 Nov 2025 19:11:40 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 11:11:36 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 16 Nov 2025 11:11:36 -0800
Received: from c-237-169-180-182.mtl.labs.mlnx (10.127.8.13) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Sun, 16 Nov 2025 11:11:31 -0800
From: Edward Srouji <edwards@nvidia.com>
Subject: [PATCH rdma-next 0/9] RDMA/core: Introduce FRMR pools
 infrastructure
Date: Sun, 16 Nov 2025 21:10:21 +0200
Message-ID: <20251116-frmr_pools-v1-0-5eb3c8f5c9c4@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ8hGmkC/x3MTQqAIBBA4avErBPSMKSrRITYWAP5wxgRRHdPW
 n6L9x4oyIQFxuYBxosKpVgh2wbcbuOGgtZqUJ3SUspBeA685JSOIrxRvXMajdUGapAZPd3/bAJ
 egxUR7xPm9/0ADlHtJGcAAAA=
X-Change-ID: 20251116-frmr_pools-f823cc5e8a58
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, "Patrisious
 Haddad" <phaddad@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763320291; l=4686;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=N7Y3T3mnMnX09sIvKeC11eVNfV2oouiDggHtcl/zK4A=;
 b=z8PA8yhaNEP8sPLSyeJbljdqawAEhylwkfLAqdds7HRKnTUFR/QPngCAE0R3tIzD70N+Dr5cO
 g8Fej1TyOYMCfXO8USzKhjjzAn39/4KWGhYl/1EBAqaZTAt3jit2rk+
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|MW3PR12MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d31897-b0f8-4dee-ecaa-08de2543f90e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1pkbWxxVnZyOHUrNEgyenhoYUJNSFBSZkYwMFJoOXYzMnk0VndQM1hDcGk3?=
 =?utf-8?B?WFBla05rMSt4U09ORXpMZlFHaFdsTGU2aWpGWGRPNDBRTHhrVFFHZUw4UDg2?=
 =?utf-8?B?c1pXT2dsaUdmYmpTZ2ZkQlhXcXBmd2ZrWU1BNVFtbVo0dkh6eW5MeVdSM2ta?=
 =?utf-8?B?N292S1RZU3JmMmlpN0Rma05SdHNBVmJ6VExEQUFqU1lVVmRiL0REelJKYkcz?=
 =?utf-8?B?Tkt1U3NYdStsNlUxSTZyQnY5YlJPQk1MZXlzOENLR2NyTVBneEFlWXBlL05R?=
 =?utf-8?B?VlA1cjRVWjNSbXpnR1J4bU1IbDYvTWx0RHBybHFZdi9NR0h1MWkxaEg5VjNR?=
 =?utf-8?B?RkliZWcySEVQb3duNnlRTWphS2Y4ZER5MDFzWnJYQ2RQZ05zYkxFYkN6Yko5?=
 =?utf-8?B?T3kxSlhQRU00MkQrNVA0SENZVVhkSStuWUd6NTQ1N1k0eVppczFHMW8vMits?=
 =?utf-8?B?ZjhRend3aGgzaEdzbVBiNW9TT243ZjdsN2ZQN3VHRXJnS1pJQkRVWE5IdU1R?=
 =?utf-8?B?enMzeElpZm9BT1grSFJkQUFKVDdDaHhsUVBHaHpOVDFMeThwVWc0T0p2RWVU?=
 =?utf-8?B?bTF3R0djWnRWUmRMWEpIQmtlc2JpTHpoaHNjYnR3YjRWcHFsMm4xZXB4L2x1?=
 =?utf-8?B?STNTYTk0OTVGUHppNE9vZ3VuenJxcVJVSW94UDU5eXArTU16eS9weEg3bzBV?=
 =?utf-8?B?Ti9sTWxEOE8zbVhMeUdOa1h4TlBCbGZsK1BOYXpVUmplK1IxSnM3UmdNOXVI?=
 =?utf-8?B?c1d6eVNuSUNsYVp0SG15aDRIUG9scFJUa2NDSTJKbVczbFJNbmxOdzBSUUVR?=
 =?utf-8?B?eE9jd011ZnA4RXZMMTVtcUtwREFZOUZuNEZ5OFFaWVF5ZzJSZm5ibVdMMUFk?=
 =?utf-8?B?bExWNFhZV1B6VE9LMHpMWERGNTk2b0FTV25QdGZoNFRRank1Z3ZDMVdEK1Rz?=
 =?utf-8?B?YWJlVnU1NXovaHhRcytQeC9aa1VTVkc1dFloaWhCR1JwdkFxQUhtQ1VtTCtu?=
 =?utf-8?B?eEl3UlB1dHp1d0RrazlxNENoWTNlTlBUR2J2OGVERWdOUTBwR3I2ZnR0Uzk0?=
 =?utf-8?B?VFgyOXJLSkpaMWRsVEN0R3hMOTdvdTE3VXVvS0kzUGJQaUtuQXFYbW1tb3lx?=
 =?utf-8?B?SUlVaFBuUmJHMzdRSER5OVhSRVNHVlpxSE1mVlJRaXFrQllSV1VtYTRwRWJI?=
 =?utf-8?B?dE1hOFBqQjVNSmlCUEhoSy9SUlBzVVlrSkRCdytzZ0hOWXJTL3BEOWZDMnJR?=
 =?utf-8?B?OWVWcU52UE9kclRISUFoMlc1L2xGQzR0c0xHbk1MRmtXVTZUZytxc0Ntemc3?=
 =?utf-8?B?cWhXU1NnVUl6UXA5UXZqMHVDTzhPbjJDam5CUkhLb21LcTQ0RzBKdkRFNEJ5?=
 =?utf-8?B?bVZFcktxYlpXajZoNnlnaXB1dXpxY0NSaC9BWE1GM09CVG41czJ2cEMwL0pL?=
 =?utf-8?B?VWdZVTNWK3hpWkFLcFdTTEN0eUhtR3huOTNEL05pMStyQnJGK0g2Q1VXUncr?=
 =?utf-8?B?YUpqWHJ3cThNeEJDZXNsRDQwcnVNOUUyQkpQa1hhdlVlTVFtVG9PVGFSdjV1?=
 =?utf-8?B?b3g4a1pLMmJEdmRmckFRMWFaTkc0VHdoUWJ1bmxJczJ3UVd3NndGTUJObXk4?=
 =?utf-8?B?cC9VNEtCU1QvUE5udFBORVNkMmVKRWRxRExqbEFOYjQzdkdOOTU0amY5UFpY?=
 =?utf-8?B?Q3IwTitoRVdCQ011VVV4UE14Q05BWFBYRDVnNjJmSERNNDk2MjQ1dXVCKys4?=
 =?utf-8?B?TWFQcVlKSXFnOWphSkpoS1dHUTBUVVMvQmlMOHJQVmZXMHhVVG5DaDBXZXU1?=
 =?utf-8?B?L2pmZXE4cFRwVWJpdDU2MGRwVVlHZFNaVGxLalRBa0NGTThYb09KNm1rNmly?=
 =?utf-8?B?VFNZQmhLZDk2V0Y3cHpjU29sM2xLb2ZQT0JwZ0VaM3IwT3pLVmY4WXhVZGxD?=
 =?utf-8?B?dXVwbVlTSnNnTlhOVG9vczFjQVV0c1VtMUtveTRpU2kwVXR2TWw5VzdxSVhK?=
 =?utf-8?B?dTJHRDBheisyWkE5WU9xZlFoNXRsZnNMWHdScTBsemhaZEdkQ2RabXJFZmVH?=
 =?utf-8?B?VmZDODF0ZUFkMldHSTllTmcvOE9IMTNnWWNaQ1d3SUpkVHlramRaYnBFVVc0?=
 =?utf-8?Q?RBRLeCt2V2TdwM0UnecGI8FZX?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 19:11:40.4504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d31897-b0f8-4dee-ecaa-08de2543f90e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442

From Michael:

This patch series introduces a new FRMR (Fast Registration Memory Region)
pool infrastructure for the RDMA core subsystem. The goal is to provide
efficient management and allow reuse of MRs (Memory Regions) for RDMA
device drivers.

Background
==========

Memory registration and deregistration can be a significant bottleneck in
RDMA applications that need to register memory regions dynamically in
their data path or must re-register memory on application restart.
Repeatedly allocating and freeing these resources introduces overhead,
particularly in high-throughput or latency-sensitive environments where
memory regions are frequently cycled. Notably, the mlx5_ib driver has
already adopted memory registration reuse mechanisms and has demonstrated
notable performance improvements as a result.

Device driver integration requires the ability to modify the hardware
objects underlying MRs when reusing FRMR handles, allowing the update
of pre-allocated handles to fit the parameters of requested MR
registrations. The FRMR pools manage memory region handles with respect
to attributes that cannot be changed after allocation such as access flags,
ATS capabilities, vendor keys, and DMA block size so each pool is uniquely
characterized by these non-modifiable attributes.
This ensures compatibility and correctness while allowing drivers
flexibility in managing other aspects of the MR lifecycle.

Solution Overview
=================

This patch series introduces a centralized, per-device FRMR pooling
infrastructure that provides:

1. Pool Organization: Uses an RB-tree to organize pools by FRMR
   characteristics (ATS support, access flags, vendor-specific keys,
   and DMA block count). This allows efficient lookup and reuse of
   compatible FRMR handles.

2. Dynamic Allocation: Pools grow dynamically on demand when no cached
   handles are available, ensuring optimal memory usage without
   sacrificing performance.

3. Aging Mechanism: Implements an aging system. Unused handles are
   gradually moved to the freed after a configurable aging period
   (default: 60 seconds), preventing memory bloat during idle periods.

4. Pinned Handles: Supports pinning a minimum number of handles per
   pool to maintain performance for latency-sensitive workloads, avoiding
   allocation overhead on critical paths.

5. Driver Flexibility: Provides a callback-based interface
   (ib_frmr_pool_ops) that allows drivers to implement their own FRMR
   creation/destruction logic while leveraging the common pooling
   infrastructure.

API
===

The infrastructure exposes the following APIs:

- ib_frmr_pools_init(): Initialize FRMR pools for a device
- ib_frmr_pools_cleanup(): Clean up all pools for a device
- ib_frmr_pool_pop(): Get an FRMR handle from the pool
- ib_frmr_pool_push(): Return an FRMR handle to the pool
- ib_frmr_pools_set_aging_period(): Configure aging period
- ib_frmr_pools_set_pinned(): Set minimum pinned handles per pool

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
Michael Guralnik (9):
      IB/core: Introduce FRMR pools
      RDMA/core: Add aging to FRMR pools
      RDMA/core: Add FRMR pools statistics
      RDMA/core: Add pinned handles to FRMR pools
      RDMA/mlx5: Switch from MR cache to FRMR pools
      net/mlx5: Drop MR cache related code
      RDMA/nldev: Add command to get FRMR pools
      RDMA/core: Add netlink command to modify FRMR aging
      RDMA/core: Add command to set pinned FRMR handles

 drivers/infiniband/core/Makefile               |    2 +-
 drivers/infiniband/core/frmr_pools.c           |  553 ++++++++++++
 drivers/infiniband/core/frmr_pools.h           |   63 ++
 drivers/infiniband/core/nldev.c                |  347 +++++++
 drivers/infiniband/hw/mlx5/main.c              |    7 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h           |   86 +-
 drivers/infiniband/hw/mlx5/mr.c                | 1141 ++++--------------------
 drivers/infiniband/hw/mlx5/odp.c               |   19 -
 drivers/infiniband/hw/mlx5/umr.h               |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c |   67 +-
 include/linux/mlx5/driver.h                    |   11 -
 include/rdma/frmr_pools.h                      |   39 +
 include/rdma/ib_verbs.h                        |    8 +
 include/uapi/rdma/rdma_netlink.h               |   21 +
 14 files changed, 1219 insertions(+), 1146 deletions(-)
---
base-commit: d056bc45b62b5981ebcd18c4303a915490b8ebe9
change-id: 20251116-frmr_pools-f823cc5e8a58

Best regards,
-- 
Edward Srouji <edwards@nvidia.com>


