Return-Path: <linux-rdma+bounces-8810-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FA4A686B7
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 09:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6DF17778A
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 08:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F8E2512CA;
	Wed, 19 Mar 2025 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BfQt/joL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87406250C02;
	Wed, 19 Mar 2025 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372752; cv=fail; b=nDz28F10EIJQXoxPLYWiTsslBkmf5qj/ZLQIiBgR1I86pVXlceHe32601LMtivGx5V0W843iEwqAWX8kh004MFPOCfNiLN+YO/m4pYzBdvcq55FwxONuM1pqWpy3vJRmIg6QnKtxkA28d0P2M+HEmiuw5EKICazWa3oJMyUvoGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372752; c=relaxed/simple;
	bh=z4IsCd23C1101L4JvXqFh7G2dxng8Ehdsj4yFpiQUCk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FK8782A3NVq+zm66j8vso4P+uBqbVP8CjqRj+fP5vjFGowSugSJqX3P9wyW3aLQgg+3eeG7glVSVH5FYoulWd+DaqBF5JjJkIz1jxHCOnuxN8LJZbh46BRCR3GbTQ3SC3oZggo7A5ex0ey9rrq5IxWFI4qZHhl5BDi6XEEszBsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BfQt/joL; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsbHWrM+qLP5RAgBzOroSiABqWsr49efYV8rhkHIrFRy3x6zhTPMWLLdZHgJH1URc1HtQt0/hrJ+g36uGGBnnPbegsUJTI4u6H9Um7JqqVOuyjuAobt5fy480m5etw82vcNiFNbcfkYckqESpjMHvXYXDWWEQMbY82YibjhJxOnae5OIxxLtLZsdriPMDMV3Yt1OFfwJiNech2eMNOFQFidDP4CzEEngKCr7qW3x0h8C9FtITLERLll3sH3PD+VlbM9C16RLX5fM5w4u4b8MqKGUwvnnB6wfHXCzD37OpjLKgNsSsQLakU+1h0alkoTvBy3vJEV+wEQsKL2Z9DWCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RU0G/zpRfqElzZSDPZOEVaDf9yaKjf6RoeIyIrko05U=;
 b=qz7LW/dBNYIy3tmk/cnrJFfAGUqo2MSVPAuGMNzHLAFqhFvGg02Dj6/1nE7GTZSq3Z1dIk8+sU4Rhv8awWaUXGg4+LnFvxcbxv+g6WTUYH2P3mbsUKuYMDEVHyAvkpqDDHdGo0Kp7jY88MF8IcmLFmBl/VMZ/ka7Ul4LnrlIG6t+8tgHNgR3SRo5MyG8Shq2smNz8TsLpI/bGncgaMKA/ZIvG7zvcR2dQXH2l3YBxtdKf0aY22RlL0CVFX5fdWx3eflpBztq+r5KjDsPSJ63kwuMAAQGwCjua7tPV2xvSyGoV7Y8lKpI6UK/p1uGxD/qd+ORfYhTdpc6VU/EVfrfIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RU0G/zpRfqElzZSDPZOEVaDf9yaKjf6RoeIyIrko05U=;
 b=BfQt/joLHzNrMtdr2Xc3Y/wXJrS4vgwgxMuNPEu/O2i7/plFTpLf4CFvPoqiZEp9WLojFneKtyQC74mkU1yxysj/PRxPAeSVCUf/JNaZkrzvwbisPX/Zu1wei0yqyk5mdFDIzOiKWVbM4lDm1Sp3ijvKWsCmnUXUAJ1rYFHyK217NwmmQ0p3DDfdZ/6OgYBApEyBYA3Boz4GXgPLZdZoSwuQhLMQ4BgT1m85/p7GXv/mHdU/Im3wwUwvLMsRVRxWucUFB9Hz6FA0P20qkVhiaA949QsSraSDnQ9pdy/eiggGwgXGnJC6duhpG+WghKyy9UbmEw9SNsHw5/zdAJCTdw==
Received: from PH7P220CA0086.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::15)
 by IA1PR12MB9521.namprd12.prod.outlook.com (2603:10b6:208:593::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 08:25:47 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::7d) by PH7P220CA0086.outlook.office365.com
 (2603:10b6:510:32c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 08:25:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 08:25:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Mar
 2025 01:25:36 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Mar 2025 01:25:35 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Mar 2025 01:25:33 -0700
From: Patrisious Haddad <phaddad@nvidia.com>
To: <leon@kernel.org>, <dsahern@gmail.com>, <stephen@networkplumber.org>
CC: Patrisious Haddad <phaddad@nvidia.com>, <netdev@vger.kernel.org>,
	<jgg@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: [PATCH iproute2-next 0/2] Add optional-counters binding support
Date: Wed, 19 Mar 2025 10:25:24 +0200
Message-ID: <20250319082529.287168-1-phaddad@nvidia.com>
X-Mailer: git-send-email 2.47.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|IA1PR12MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: d0947370-5226-42f8-accf-08dd66bfa644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PdqQh6tVsU3g3OkiSah0FUnkob3mMKUB04KKunp76uZ7Xd6X/GIO4ZNKfDze?=
 =?us-ascii?Q?AXUaFPN4j2e6qTCmBuJatHntXDImft1elbo4dBN692NslOitRTgId6iVlMWt?=
 =?us-ascii?Q?GT7+or7PW4tckDooCKFab8x6rvwe9m9EupHZpCWxkQ6RiSaQE7x27swncw+z?=
 =?us-ascii?Q?Ee0sdTw1RYm1BtyQnE223S7EAFPGlHEpoEHAg2gKC2zloJJMmbJldF1ay1vl?=
 =?us-ascii?Q?6rXp635JL0FH7RcSPfUjyiEnw1BAnz7aKaVhcbIgFwzWxpKa7Favcgfs6Z6i?=
 =?us-ascii?Q?hMBaKw3F5HyKeGa2bfRGePLtYTObBwwrYme5fy7wzccC79zLfZAfi87s/FoR?=
 =?us-ascii?Q?JJYgAvUtGHgLelnRAHvwj56+/7r8lnpv9aWfuClorqVoTYiVDLsouTB0z6zX?=
 =?us-ascii?Q?XL/F1qkqlmjpwF0prNa+Q2OHWdtWcwSOG1655Jp7EHSfQbkj087lHzRO7OWC?=
 =?us-ascii?Q?wgxeGjMDT1AIujeQ+yGgds6E1YBmHoKSx46H0cHvXWbMMc0aJw6OEOtx7lTB?=
 =?us-ascii?Q?as/2qFfgEqrI33ULQdf6ziQZfyn1WG9HmYW7jXPC6rpkWrchgfywTGl+CkwH?=
 =?us-ascii?Q?Z+vc/Xs+wwQFtR4vfOXlZHOGKwz2NSRYvFRBoXBuccI+52GiPiqmcMMNu/OM?=
 =?us-ascii?Q?pbfxxOh8YMQmpxsyrvcxwmgmlwZxXVyEEe6CGgxte26x6rAhMzEgwvHJYThF?=
 =?us-ascii?Q?NRAiw7mNKTF89JsP6No4F3hYTseqTBY6dB/nRLjYcDYl9Wv6XeHtP91gFy7t?=
 =?us-ascii?Q?oD9eWxl/eRFWanfrd9ujcb+Kao880WVWPbLa1C/im97MwGi0KreCosu0nmMp?=
 =?us-ascii?Q?02UQcV/cFY2ox6de5W4vD4GtvLI6kr3fTVqkMtCGXg/Zdo9V2oaBn5hpuAjF?=
 =?us-ascii?Q?iw+KuuSkqBfb6EQqSjsvcRn8Sv5BXtBdp5lssbE/aWcdRimZFZhtAGuBa7Uq?=
 =?us-ascii?Q?jHkMcGsyVZdvshbWU++bFoKFzCAYzU9XOzqz0N23p1IoYK286m/h+bRQV6hc?=
 =?us-ascii?Q?MJFdnfXl6wcbSkpUDhRkTYC8tF2GLycpklZqk+nNkoajviALiLtAnu2MuH3l?=
 =?us-ascii?Q?X+Nvv9nI6+d3xFKjcynC/yHfLs/OOsndpbfGt2wxLFYZjWRfqxVStHVcM1VT?=
 =?us-ascii?Q?VPd8LKocisyxsqGdVQTHh9yN1q4hlxJ9mTc/3uPH2SzHheTun1k2HFcqGzY+?=
 =?us-ascii?Q?vwIOcTphCeyvJKeZfr7W0b1CtFRjvVC9kQo2f40SGyVq3cD+kpmD5Sqyc/fh?=
 =?us-ascii?Q?tW0C7Bc7txT8Oa4mlJKIP8Jx0KCvzG5cYguXjPW3ZUWjzkUojmtOl4m0VJFt?=
 =?us-ascii?Q?h//rO0DMvaJ23yDni6F3C23K0bQwA9nWCFQ58bqE9QcI7K15TtfV2zQyS7MQ?=
 =?us-ascii?Q?XN/BTV87LxeMZSWDZQyt3D4nozeqiOVIPzRQ7d7u5EGP+ftVS1JDSDafC5YK?=
 =?us-ascii?Q?wQwO69YTSjIsZ0uG0qIyDtxrdyxQGa8cdcUZ2yjQ8k82/AWGcRaJmw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 08:25:46.9533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0947370-5226-42f8-accf-08dd66bfa644
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9521

Add optional-counters binding support together with new packets/bytes
counters. Previously optional-counters were on a per link basis, this
series allows users to bind optional-counters to a specific counter,
which allows tracking optional-counter over a specific QP group.

The support is added for both binding modes, automatic and manual,
in both cases the bound optional counters are those that are currently
configured over the link when trying to bind the QP.

In addition introduce four new optional-counters :
rdma_tx_bytes, rdma_tx_packets, rdma_rx_bytes, rdma_rx_packets
That just as their name implies allow tracking RDMA egress and ingress
traffic.

This is exposed to users through the iproute2 package which needs to be
updated as well to provide the support for this feature.

Example commands:
- rdma stat set link rocep8s0f0/1 optional-counters
  rdma_tx_bytes,rdma_rx_packets
        Enables rdma_tx_bytes and rdma_rx_packets optional-counters over
        the link.

- rdma stat qp set link rocep8s0f0/1 auto type on optional-counters on
        Enabled link automatic counter binding for QPs of same type,
        with optional-counter binding support.

- rdma stat qp bind link rocep8s0f0/1 lqpn 134
        Manually bind QP number 134 to all available counters.

- rdma stat qp bind link rocep8s0f0/1 lqpn 134 cntn 4
        Manually bind QP number 134 to counter number 4 depending on its
        configured counters.

Thanks

Patrisious Haddad (2):
  rdma: update uapi headers
  rdma: Add optional-counter option to rdma stat bind commands

 man/man8/rdma-statistic.8             |  6 ++++
 rdma/include/uapi/rdma/rdma_netlink.h |  2 ++
 rdma/stat.c                           | 50 +++++++++++++++++++++++++--
 rdma/utils.c                          |  1 +
 4 files changed, 57 insertions(+), 2 deletions(-)

-- 
2.47.0


