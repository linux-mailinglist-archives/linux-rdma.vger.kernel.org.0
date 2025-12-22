Return-Path: <linux-rdma+bounces-15145-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3134DCD603D
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 13:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66F1F3038F7E
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 12:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C9B29D277;
	Mon, 22 Dec 2025 12:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CXz7hjLI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011036.outbound.protection.outlook.com [40.93.194.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFD225DB12;
	Mon, 22 Dec 2025 12:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766407267; cv=fail; b=npvlO1y9YtbDT7WB0W6xrMz/1JJfdxLWRG+SwypGVD0O3DPS0xyOfPY7qG1LdbMQRCulJTP1vG1wrTDpnGoDCTFJu0FPiIRQdqItnzYVLILLW1EPtOnasVvAPGbyF/GP2tw1NwTCZHm11aKEurBRHmPwyYqBosGU8EGFG5FCDLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766407267; c=relaxed/simple;
	bh=T4nEALWUlfPYeFmIqNzONrC2rR1J683StrOUzF9QxpU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=f735aZicAr3HUoyxVzcbHq6Wi+1PVrYsFowKaDUmHU4ur3l5rCSvRgUa6cIp1yO5EK3RMFqCBY4D7aqC08rMB1F5VEakskqSLQS0K25tGquB1b+bR0dq+aon1594qPz2HFftnWY6oUXYIviJS3/0thCkPHuiEHAScTp5ZiR90hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CXz7hjLI; arc=fail smtp.client-ip=40.93.194.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OP1ra/gupy3s9MwLeNn5CNZg87ABlZyq19/AAIXwdd5hlSKPKLOSg+ezFcCK5JMDhdd8HLu2o56SsxUteBWFHlS6thXzXRE0Q0mhqujmA2LVB0An2vtpWnIIcPFTiMmTKvDsbPvIWoBAGfzRRmH2WBVL5tnQQiEPBpMqYkoxVaLb2SjClfnOuTb2yWaJticXARcobqpsituvoavsbubLsbRMJvFceqyoP3+5rFM62b7ktplZP0jajtxlHqUZhlcXS+VUJgVswe/zams0Zzt6xXBtFEeHRW2USdT1cQq6uaeCsI7Yh/4OmFv/faER+safOxedemuXqEj05dYyVJiMtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lw4hCceYq4sahPWnDn5fwion6deqOQB2zEXmSojZTdk=;
 b=q+sXkPJHUnQm/M+AHVvLqZ50bll8QM3/DItadVGn6nu4MAg7WfW/8XM05p2SBgteMI8wXP/Kmn+WuhaJ1P1spNqctIHIQKba2mxXSqDffPxbxkULJQNGmpbVbET/QXYTdKgH2ngWBKm33gKAiOOb0hE/RSqC5VfOCvwHIhngMx9/J7DeNeQdcP6Yi1EKyS1xNDgTEZi2+8Ey0g9MLlkrL9QO44IUyUX50R9Pd/E7X4UFuL8jK0XWTwHSoCGOB7hDAh2siYrtCcly2I4iwNPis1+dk80OJlrY8rgkSgfx7k/cf5BAMKHZgm2sLlkWJ5bBcOsHUY3l27iGga9uDY3yOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lw4hCceYq4sahPWnDn5fwion6deqOQB2zEXmSojZTdk=;
 b=CXz7hjLIIbJssFfbUtPC6q93+qAJerkfMUGF8W1gf4JA7nqPge3NdIXT6pt3JhdOxxewp1E3d+K/dS7KXLpIjLabBrSTWwUH3PLXa4LnAgU6I7bxW+Dw7VDYUiIYy2xlvgU19x8rPW9D6oaQSIF9eBm6F+RvLgDoXVPPI8sr6yc9bfz9F/4aGGZL9V60xWjRRvAzGXyMxUOGjYJNaUPmpblz8yij5ap3FGb5OhsVs1zmh5yi2tfO0kPT74jeOkANFZvgwrwmAVFM9hFO9pzg4HoK9AGeLtom0aw8GXaD2gm+3sETwmQI03r01PRNB3YUPYk0cLNt4u4EBhVdBM/i3w==
Received: from BY5PR17CA0010.namprd17.prod.outlook.com (2603:10b6:a03:1b8::23)
 by BL4PR12MB9479.namprd12.prod.outlook.com (2603:10b6:208:58e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 12:41:00 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::67) by BY5PR17CA0010.outlook.office365.com
 (2603:10b6:a03:1b8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 12:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 12:40:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 04:40:50 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 04:40:49 -0800
Received: from c-237-150-60-063.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Dec 2025 04:40:45 -0800
From: Edward Srouji <edwards@nvidia.com>
Subject: [PATCH rdma-next v2 00/11] RDMA/core: Introduce FRMR pools
 infrastructure
Date: Mon, 22 Dec 2025 14:40:35 +0200
Message-ID: <20251222-frmr_pools-v2-0-f06a99caa538@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEQ8SWkC/22NwQrCMBBEf0X2bKRJjURP/ocUiduNXbBJ2ZRQK
 f13Q88eHzPzZoVMwpThdlhBqHDmFCuY4wFw8PFNivvKYBpjtdYXFWSU55TSJ6vgTItoyXnroA4
 mocDLLnuA9KNXkZYZuhoNnOck3/2m6L3wz1i0apSlV4suWLzi+R4L9+xPmEbotm37AW870VSwA
 AAA
X-Change-ID: 20251116-frmr_pools-f823cc5e8a58
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Chiara Meiohas <cmeiohas@nvidia.com>, "Yishai
 Hadas" <yishaih@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766407244; l=5917;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=T4nEALWUlfPYeFmIqNzONrC2rR1J683StrOUzF9QxpU=;
 b=6htRRzbXihT2k8LRTfu5huhmeMskV/UinbUUs82p61tf5Bu3T9Nrd8DG3hqFYFnfXJJNsXKKt
 3W13kuFHh1NBpCd29pW4r2xoRMFD54LSabvzZ16mgBSi8ZTocnIaMC8
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|BL4PR12MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: 729ee03a-ae91-4d5d-12e7-08de41575c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2F4UXJ5dlVlRHVNMkQ0RXNDVlV0aWM5WktSQW14RDNmY0ZVbENvOGt5Y3F4?=
 =?utf-8?B?dHhvSEVkNHowR2tab1JjKytuam9RRGpzOFB0U21scEQ3bzNCUTE0YjlsbUpB?=
 =?utf-8?B?bjFUb2RMMVp1eml0RzFTcHQ1eTk3Q3NQRTBBTW5TRnM0UTV2dVplS2h6eUJN?=
 =?utf-8?B?aWI1R3NlNHlmalFEODRlMHJOd1QzdWxaZ083UTNaT2JiVk10aWd5cEJlQWVt?=
 =?utf-8?B?cFpXcXhDK1NHSXk2emFWSWtBWXB6NTZ1NnJnQUVtc0dTTTBMQmFiZkEydk5X?=
 =?utf-8?B?ZzBWcUhnMDUrbUZZdjJkK01zYzFwYUR2emlUaHE0ZktCWko3dW5IRHlSNStr?=
 =?utf-8?B?Q1lyUXM2WHlUNlVhQ3E5TlVSRDBaWWZtRTUwNm5FU2twdTBPbjdvcFhud3d1?=
 =?utf-8?B?QWNuV251OWFnUGZkUFg5WStzTWp1V0pzQkFzNCsyeGJJV0RhNHJ6SExZc1NO?=
 =?utf-8?B?K0VPTmhKRW12NEZlQkpYQnFRb0NlTXVwVnR3c2Fjc0YrclgyUEJUSGs2Y210?=
 =?utf-8?B?cVZqL1RZZENTSGMvRWltN3orZG9yKzg1cFBSWGRNZVBGanVKRTNXUDhoNVoz?=
 =?utf-8?B?bWhQTHhvU2lWMkhYSlI5YldsdjhNUk4zbDg1aEo4L0Z3YTNmbHZ0WVY4R041?=
 =?utf-8?B?VGh4bVNHd25YOVM2RmptazFlRG5YdUVOWmozOGtNcUZYYVFHM2VuOUVNSkpU?=
 =?utf-8?B?ZkhGbWJIUzk4eldWNDdyS3gyMmE2WlZJYTFpOE1OZTB5clpYQmZVUXBsZ3pl?=
 =?utf-8?B?aVJYRjFiV0VVUDVoVEd3RGlRNm5kWExMV1lib1U3WVRhUnFIVHV1dGQ4eTNS?=
 =?utf-8?B?Wmd4QmlEVVFpSTBlS2ZtOWo4QjJOVjlYWDVjeDVqa1A1TzBFeVJrZnlHK2Vw?=
 =?utf-8?B?WEFpeTAyb0prUktWZnZCN3ROeFlyV3VwUXVsL0pwaXhHSlFqd1JhN0dyT2xU?=
 =?utf-8?B?U0g3NHU5Q3FyK2RxaHlOMzNsWUY2bmlWV0NPaDJTZ3ByQ25JZ09QVlgrZXQz?=
 =?utf-8?B?UnVxS2ROemZDZ2M1ZVlIamx4UU1XZ28zRU9vU1QzdXZmQmFCOEVyQ2VYb3NQ?=
 =?utf-8?B?a2h2MjBwTXJQRkN4SG1aeVRCOGM5aHljQkMzUVZVZVNIMHorUktJWVVON0Qr?=
 =?utf-8?B?dGxESmhtY1pMbktqZklORE92L3hoV3IwYWFoMTNQM0MwM2daekpqNkNjZDVB?=
 =?utf-8?B?WlVhRFJJUXhoSHc3UEpEVmI1NnV3TjN0SDRpbktIZEZtR1NORStzeWt2UlRP?=
 =?utf-8?B?R2tFZzdqWU5tekJoK1Fpay83Y01WMmIyaGl2N2R5NXhMT3kyNmtNTEdZbUJF?=
 =?utf-8?B?MnQ3UHFTMEttNnQ5aW5PdFNVYTQ2dzAxZ0trT24xNFNIaGhiQllkZG4xdnhG?=
 =?utf-8?B?TVVwcUZudzNNYXBSVzRodXE0Qm1IU0tQWHA5NjY3ZGJPY1RWU253eGxTc3B1?=
 =?utf-8?B?RDBkM0pEa2l2MndCZ3Y5c2FvSUcyR0F3TU9HSFJQbmtHc2lxaXo0U1NTakF4?=
 =?utf-8?B?aTkzUEkzS2VUaDdBcTY1T1NXN2VsNDJKZUgydmpIVkxxSWRPcDY5ZTBmV09a?=
 =?utf-8?B?UHRNUWY3NTRLZTJBYXM3dzZyUFdCRFVVNmdmMWhpNTJFa1V1c3JLK2tIaG85?=
 =?utf-8?B?TC9Xa1Iwb3RMYVdVa0RlaUorU2RoaE11UG9ZMEROVUloYlpTRkhkalorTFdC?=
 =?utf-8?B?c3BGd2p1RWlacy9qWit1UHpHWTBPMm1ZZ1ltNHNCeEc1SXREczNDVWpGRmdP?=
 =?utf-8?B?L0srMkI0TkozTWU1UHlPTDdSQ1c2ZVozZWdlS01XRC9YdEVEbFQ4eHMydFlH?=
 =?utf-8?B?aHlmZlZOSUFVRHhBN1diaGFTbDVDRndiQXdSRTlVK0M5eG52UEExSDVXMmpo?=
 =?utf-8?B?R2ZKMXd0QjNYWUR2RFcxYXUzYmpkSG04M25sTVdidE1OSmhjakh0Z2ZDRHZi?=
 =?utf-8?B?MTlSbUhlMmlMSC9PaDFNeUxEa0YvWUI1b1ZOdGVWeHRpUGVWYVRxeHpDS2tQ?=
 =?utf-8?B?RjNTb0xNNmE0VDlVTVdrVGJxRkVEOElBTnpFQy9OMXFwQVMvaTBQU2hHblF2?=
 =?utf-8?B?T1RQbm1yb1VTSFFLL2hMckFWQitqdW03Yy9ZNGgrNU5CVDJndnk0Tk9wVTB4?=
 =?utf-8?Q?JgYezvXgmTRv5tzoFjvDTaQUt?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 12:40:59.7962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 729ee03a-ae91-4d5d-12e7-08de41575c3e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9479

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

FRMR pools will store handles of the reusable objects, giving drivers
the flexibility to choose what to store (e.g: pointers or indexes).
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

mlx5_ib
=======

The partial control and visability we had only over the 'persistent'
cache entries through debugfs is replaced by the netlink FRMR API that
allows showing and setting properties of all available pools.
This series also changes the default behavior MR cache had for PFs
(Physical Functions) by dropping the pre-allocation of MKEYs that was
costing 100MB of memory per PF and slowing down the loading and
unloading of the driver.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
Changes in v2:
- Fix stack size warning in netlink set_pinned flow.
- Add commit to move async command context init and cleanup out of MR
  cache logic.
- Add enforcement of access flags in set_pinned flow and enforce used
  bits in vendor specific fields to ensure old kernels fail if any
  unknown parameter is passed.
- Add an option to expose kernel-internal pools through netlink.
- Link to v1: https://lore.kernel.org/r/20251116-frmr_pools-v1-0-5eb3c8f5c9c4@nvidia.com

---
Chiara Meiohas (1):
      RDMA/mlx5: Move device async_ctx initialization

Michael Guralnik (10):
      IB/core: Introduce FRMR pools
      RDMA/core: Add aging to FRMR pools
      RDMA/core: Add FRMR pools statistics
      RDMA/core: Add pinned handles to FRMR pools
      RDMA/mlx5: Switch from MR cache to FRMR pools
      net/mlx5: Drop MR cache related code
      RDMA/nldev: Add command to get FRMR pools
      RDMA/core: Add netlink command to modify FRMR aging
      RDMA/nldev: Add command to set pinned FRMR handles
      RDMA/nldev: Expose kernel-internal FRMR pools in netlink

 drivers/infiniband/core/Makefile               |    2 +-
 drivers/infiniband/core/frmr_pools.c           |  557 ++++++++++++
 drivers/infiniband/core/frmr_pools.h           |   63 ++
 drivers/infiniband/core/nldev.c                |  286 ++++++
 drivers/infiniband/hw/mlx5/main.c              |   10 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h           |   86 +-
 drivers/infiniband/hw/mlx5/mr.c                | 1145 ++++--------------------
 drivers/infiniband/hw/mlx5/odp.c               |   19 -
 drivers/infiniband/hw/mlx5/umr.h               |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c |   67 +-
 include/linux/mlx5/driver.h                    |   11 -
 include/rdma/frmr_pools.h                      |   39 +
 include/rdma/ib_verbs.h                        |    8 +
 include/uapi/rdma/rdma_netlink.h               |   22 +
 14 files changed, 1171 insertions(+), 1145 deletions(-)
---
base-commit: d056bc45b62b5981ebcd18c4303a915490b8ebe9
change-id: 20251116-frmr_pools-f823cc5e8a58

Best regards,
-- 
Edward Srouji <edwards@nvidia.com>


