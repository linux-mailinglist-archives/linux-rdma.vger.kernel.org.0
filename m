Return-Path: <linux-rdma+bounces-15540-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BE96BD1CF04
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 08:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 413FB30146D7
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 07:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A5336654D;
	Wed, 14 Jan 2026 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XCwbC9+W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD19E35B15A;
	Wed, 14 Jan 2026 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376920; cv=fail; b=GlmvDVL6o1q/TE1YkfGwNLR7h1hrJ3O9jw+vXQzFvaNIdUcjfiICnmaE0L4/1abkJjnsy0pbkLltRdUClwtm8YM2Vp6E7kID22j9DUtQKdmVCTPW9jeCsXmBEfjDfFz5Z41BijubOrASw8tOcCeZKqRgwPohbs77tXx4s0NLxfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376920; c=relaxed/simple;
	bh=QG3L+zHCVlSNPIPW5EjCcwyAuWo4Km69Y7zstZYv2hQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rDOUuEWX+3ACTRVXBHE9l98MiV2MG2nE938v2aFsR2LtIsFOZS2bUrOnH0nfYdTskgjS6bnnc9g3w1uIZvTRbESbU/1cYoBPC5jcuedQn6aeQohWgkGMqpl65ELyZzLwu+SXfkhtRJmSeDVgdWFl/C2Plu/nf+Q3ziGGGgtk1Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XCwbC9+W; arc=fail smtp.client-ip=52.101.62.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VV3xFqT0UPD2f+9jhmNBukhlaMUBeBiRvlr5L6YBq4au6FnpYv6DbhpFMJw+27IYZTNn5BkCjq57IH2IWkNxGSmurmU+74hfPVhPYKWAr7Qj4zLo7rve/+IZ8J+ClY7gvGmxIkAaPqCc+QmIk+j8IW770wpbIL1ooniy+hpW51gs6YyCS6EWxYGbPi5G1Wngt8KXsO7dAK9IVbedRQ3w2WtH+Pt5zzj6m5p9+GV5P61bcbPpHF9/Y4eqJsSjRZfjlWmMk1N3Bw+LsrHadCHqhzZcVr84z+19WT7ISkX88UDi9ud6+BmUPaxJNPmgSjOalX/z0ubSmUm8+bWEJp7Qyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/ssp8c2zg2LN8a92J1youH3synIUIAaD9Iz+WIs44I=;
 b=WgKjNoGa+LD5Rxlo1+1vCS+nUnOg5WDHioE/7wfs2H83Utm4PQmlVkFn12Dq9NCqYfp+vOeWmBCqlps+By0kRhHBA45B/5B8zJ26mxwXo6IZQx5kt5j27QlP30B7nk1vFzpDL0vFz9D4M36j4YUS9dNcGyX4YZiccXz2VupRBKliu6rduTS5MjR3yexAMZa8eADEW0rWSGnSVCI6bTPnrstTyan1nNyfCOVVYG3kroqQfYII+p74bspN06C8Ym4iL86aqhdJbARyuslmjVb/rGkf7PcZ6p8McZB9QAD3RVBymwwZ8l4KJ1YSoyPBYp31u4Lvat/ErzS5aK+vQIPXXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/ssp8c2zg2LN8a92J1youH3synIUIAaD9Iz+WIs44I=;
 b=XCwbC9+WclnqjiplApNQST07JZuTVPXGskEfPu/r4Oz3cK5uMngkCZPAxYQKJHBHLqzQj1FVfw8rLJMZgWyVaGhnbuyG0aQM+EM8p2imNkWqugxfKVJTPuqUreHjpn/u2JfoHG50XY0PBf2VKly0+K7gQ7k1CqASnk/XuLI+js448GZs1b84L/pzmUn4WUtOC7dsCnA2RM9jyJ1T9RZ396KPL7GlbQKVet1Dus2gB+2aOKHufQH5e3km1PmZy0ZtLzeQV9gsCCqSsjxWADL86f8WOjuU3SFUNRucn1bU557LJGBWveYb1ZyroenI8aSmpB+QQ0/ZiS2aHxHvMigHPQ==
Received: from CH0PR03CA0427.namprd03.prod.outlook.com (2603:10b6:610:10e::30)
 by DS7PR12MB8291.namprd12.prod.outlook.com (2603:10b6:8:e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 07:48:33 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::f4) by CH0PR03CA0427.outlook.office365.com
 (2603:10b6:610:10e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Wed,
 14 Jan 2026 07:48:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 07:48:31 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 23:48:20 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 13 Jan 2026 23:48:19 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 13 Jan 2026 23:48:16 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, William Tu
	<witu@nvidia.com>, <toke@redhat.com>
Subject: [PATCH net-next V2 0/4] net/mlx5e: Save per-channel async ICOSQ in default
Date: Wed, 14 Jan 2026 09:46:36 +0200
Message-ID: <1768376800-1607672-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|DS7PR12MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d56f05-353a-4357-387d-08de53415064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnBhNmxDTVZpd251MVRjb2hxayt6UnhvUXFTZ2VaRy9ac0FYY1luMEU0cEZC?=
 =?utf-8?B?WjVWUzNPRlFJZlE5WnVBNFltVG83bkU4L0FJR1FyK1Q0Tm00SGZTSCtiNnlw?=
 =?utf-8?B?LzhZaTBobTNFeUszMkVIYlpmalpWV0FMSDhEMStJM25tWmJyU3Vackt3K0Z4?=
 =?utf-8?B?THRidkFSYXljQ09uZDRLSnkxTmswSDUya0QwYi9hV0ptY0kvZ0o1UTYvK0ND?=
 =?utf-8?B?WlgrSjlPcVlVYmw2L01TVGk1NThrTisvQUZZQkxQNDBMQ2FkUk1JU3JuV3dN?=
 =?utf-8?B?VWgvZUNkR2VwN29SbDB0cDFYaTZPbng2UFBSM2c5bHdaTUxzaTdiNXc1MjVP?=
 =?utf-8?B?bVZEY3Z4MUk1OFRzSlZlOEowemd6MEJiUlVpZ3N6MmZYQlBQWFFiNlRhbjdr?=
 =?utf-8?B?aXU5S0tEUDFyZy9jV3I1TlRrQk9RM0Z0MW9ndmpSZGYrTDNZYkNJR1djeVla?=
 =?utf-8?B?SWY1T0JTQzE5K25ZSVZiTmwrQnNLVnFtMTMveHRudktua1Zuc3B1c21GUVpv?=
 =?utf-8?B?OFEyTzlFRGxUb25Td0VFWlFhdGU2WGh6dktuclFxVGdMZU1pcDNzb2JSZXFv?=
 =?utf-8?B?NStMaEROQUQvSzdiQ2dOa2tYcmR5NWI1ZGRwOWJ5cUIxSERFclZ6N1hPYmp4?=
 =?utf-8?B?R3ZhOVZVZ0pnVGtPWGZhTVZCbEszSmlFcW5tQlNONUZxbktFRm05M01nc05o?=
 =?utf-8?B?QlJVQ0E1Yk13eUt2WVpqeU1ROUZhbkJ2UFRyQ1pOaXJhdHlMRURTUmRxS1F1?=
 =?utf-8?B?WVQwNU8zVVFHSGZCbTVzcmhiaEVKTVdMNHYycmwyMGlaU0R3TEw4eUU0N3Za?=
 =?utf-8?B?eXNOYk43VDZwK0pKSWlySncyWHhCNEM4d0VyTUdqNHdhU0Q2akc1VkMzMzJT?=
 =?utf-8?B?WFBydlRlbTNUaTFkVFZaRXZPc3ZubnAzd2NPREJaTCtOUjhhTDJFcy9KSG1Z?=
 =?utf-8?B?Y3BmRVN1bjlsclJxbXJMNWNVWFFVVWtXZ3llbit6THB6N1NFdVNtdVdhU1JS?=
 =?utf-8?B?MGp0bFpaMCtaRzFHNURRUi82V0J2N2pTeTRSd0N1aHJPd01nd0Juc1hXNFhD?=
 =?utf-8?B?Mmh4anhlTUo2eWRySG80dXpaK2lmdTFya3MwekpRcFJVdEJTUmpNcWxOT1JP?=
 =?utf-8?B?SlJNVm5yamN2d0lwbkkvS3FIZGJnTk9VZjkrcEs5MU5BTFBXYnliQnRKTTQ2?=
 =?utf-8?B?RGp3OWJMNkZzNW5URGhWcjlwRThZM2FmZW5oT0NIVEJsVXBwSmVqY3laVFNR?=
 =?utf-8?B?cWUzVVJYTUNXbFduOWVhelA0dE9qendEa0tnc1dhRTFoUTh2TkZidE8vNDUw?=
 =?utf-8?B?cDFjUGNWQys4SUl5T1NmUncwYllkVzlBM2g5V1UvcDNaZWNuRmdVTUtNQVd3?=
 =?utf-8?B?d3YzL08rR3dTYjM3RHFLUDlwd2wrakRmdkllQm5FbTFwR2l2bDhTMkg3a0gx?=
 =?utf-8?B?cWNxU0w3SDlpa1EyenA5Ky82bFRBZXFka1hyTjVpdkhMUk13RmxNY0dvczNG?=
 =?utf-8?B?S0lZVHpHeUhvY2U2K2dzZ01TN0Q5SC96NWZTa1BraldBc2pQTHlVNzZRZXlI?=
 =?utf-8?B?TjFhQzU2T2ZqeEVBTm13RU1XdHlqTHhiaktBTWZ6SmpWS3drRFRhd08vdzEy?=
 =?utf-8?B?K1BiczljQ2RGOHBRWlVVak9MV1VZaHZhMlo4RUphV3V4ZE5jTnNlOEdoV3lM?=
 =?utf-8?B?dUk0QUdOS0lPWG9sU29PUEhiZDJSU3ZPQjRZNW1NVk1GaUtveEE4U2pQZjJM?=
 =?utf-8?B?YStQNGhVUVpzQnU4SG5uUENTQ1pWb21yQWVjcHlyb3RTb3Q5aFY4SzBrNUly?=
 =?utf-8?B?bUpEQ3dQZXlEMFJXZ2wwTHZZTHAzVlU0ZjV4QzBhZldKcWRXbzJnUXVHUWFE?=
 =?utf-8?B?aUVJb3ArUk0ra3hwd2NMN3J0M1BWMUFXbGdLbEN2RDJ0cU4xTUxsZTdGSitP?=
 =?utf-8?B?VnZKVmpWU3l2aUlJcHA4ekZ2VzdvNUdUSG9CVEdGTEt4N2pqYnhxcWdpbHlm?=
 =?utf-8?B?bndpWU9MTUR1aG14bHdyTXdCMVkyeE1FQmV2a244VXRLVGxhU3VWSitBYzF3?=
 =?utf-8?B?OXFDc0ZDVW5uaStwVHJ2WW5JQ2QxOUxkZGtHa0lvTkNCWmxLSE1VR0xmWThT?=
 =?utf-8?Q?404Q=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 07:48:31.8487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d56f05-353a-4357-387d-08de53415064
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8291

Hi,

This is V2, find V1 here:
https://lore.kernel.org/all/1762939749-1165658-1-git-send-email-tariqt@nvidia.com/

This series by William reduces the default number of SQs in a channel
from 3 down to 2, by not creating the async ICOSQ (asynchronous
internal-communication-operations send-queue).

This significantly improves the latency of channel configuration
operations, like interface up (create channels), interface down (destroy
channels), and channels reconfiguration (create new set, destroy old
one).

This reduces the per-channel memory usage, saves hardware resources, in
addition to the improved latency.

This significantly speeds up the setup/config stage on systems with high
number of channels or many netdevs, in particular systems with hundreds
or K's of SFs.

The two remaining default SQs per channel after this series:
1 TXQ SQ (for traffic), and 1 ICOSQ (for internal communication
operations with the device).

Perf numbers:
NIC: Connect-X7.
Test: Latency of interface up + down operations.

Measured 20% speedup.
Saving ~0.36 sec for 248 channels (~1.45 msec per channel).

Regards,
Tariq

V2:
- Drop accepted parts (patches 5-6).
- Patch 2:
  Add conditional locking justification in commit message.
  Remove in_softirq() optimization.
- Patch 4:
  Simple code enhancements.
  Update commit message.

William Tu (4):
  net/mlx5e: Move async ICOSQ lock into ICOSQ struct
  net/mlx5e: Use regular ICOSQ for triggering NAPI
  net/mlx5e: Move async ICOSQ to dynamic allocation
  net/mlx5e: Conditionally create async ICOSQ

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  26 ++++-
 .../mellanox/mlx5/core/en/reporter_tx.c       |   1 +
 .../ethernet/mellanox/mlx5/core/en/xsk/rx.c   |   3 +
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |   6 +-
 .../mellanox/mlx5/core/en_accel/ktls.c        |  10 +-
 .../mellanox/mlx5/core/en_accel/ktls_rx.c     |  26 ++---
 .../mellanox/mlx5/core/en_accel/ktls_txrx.h   |   3 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 100 +++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   4 +
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c |  37 ++++---
 10 files changed, 154 insertions(+), 62 deletions(-)


base-commit: 3b194343c25084a8d2fa0c0f2c9e80f3080fd732
-- 
2.31.1


