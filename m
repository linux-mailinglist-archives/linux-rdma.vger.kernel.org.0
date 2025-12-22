Return-Path: <linux-rdma+bounces-15152-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A17D9CD6079
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 13:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0082930FCF49
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 12:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361092C030E;
	Mon, 22 Dec 2025 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AHdlnak8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E162BE051;
	Mon, 22 Dec 2025 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766407303; cv=fail; b=QIKh8zRcwN/iBxC1cysZv64K71dGMM5RxsRpntLtHwETkg036fLLF3OhYj1D61+FqgHq7fWRGUIbgZqAuSi1s+gTsmVTNhYgldjbiSY2WyBaJNbxCFEzlBSWi3ioiwuXNyynOLwLNOsEHOhARGu4+ChXno9wd4/crHdibWWY2zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766407303; c=relaxed/simple;
	bh=tOY/zvDWV8Sikzol+lNsEKhco3FC0k1GZAz1fusOaFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=aS/nDM/QA9oSa/tkkkvyFVnMz6+URVbjP98hoHrN5ZF/Dzl2Dz8LBgWSrRh75V9npv2aijoH5H/CmKS0Jd+aIZ/vT8HFHwxrc0aryiSQ1yUXn5yjIOFcbOW9SbZNkVVosw0GSIXhTnWPPv0cN/WfESwv5zO5ChjveT53go1coOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AHdlnak8; arc=fail smtp.client-ip=40.93.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COPgRbDt0XmZlpjhor2WlOHBYxF78FCmAr4z8ipPb4LmKZ8AUm3ZUDzYHtBLOScZW1Ut1HnruDmvnlTzX5nDOqKZlW9coAN0CkRkyzEc9IIw1ZcOqnyXcsPHnVTq5k2d6DBBLiLqkMtPjxNFgAHCgukHgv1smRvgCoZdn0FrUKCtFN7zkYkIrI2PiloIyLTfkVxO4jN33eLJ4K9raShUj9SFxUSfZ9Q5rIzFo7BYFpMv2kTV2gdKr/nFid5mPvE2wTJOkEgs3NrdnyKpMNjttXrKs/GaKOLw3/Cb7jPuPDvzzqpyMBWuDF28PUAHl2q9ifoLVu5bQZcLEjemA8NzRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZmiJK5IVxp5w8tioaPR75MVAE1qFIdV3b+cP/xNCV0=;
 b=eivy+cKxCPxYgJxkXUtpYPK7qippqW69Q7X7wYW157x3wDeCi1s0HMo9sNmEFc9XKsAqlgzyRE2+wEBrIN54yIYm1TD/bly+juvA2xs8jP9dml2pYDcMwaDeh+a4yKjIomHfLQuD5F9CrNOA/jwtI5jJvCxxgoc/m9XmLBauLzRzjHCB/Cva37e4naqsZLL+HmlSwfbZJpwHRAbtFPkJx2RlmUMbK2mfLw5nfOea1e9qwFuwluMWZsnh7TGYIHusuLoY/+LbdIky757a/8OOF6qO+HfnAWtc9nHlGqF0vGRuSQHhyTl0XS9ffr5A1ZjkZh4Ai+k4+iqaG3gCWsx2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZmiJK5IVxp5w8tioaPR75MVAE1qFIdV3b+cP/xNCV0=;
 b=AHdlnak852y2xySOnYqTfUItIpTsemlxRpXV8fRVggcwglvUntNwYFfq4c5qPptNueEDTWKW+T+PmXkziPoG+zihmYb33Jf7SBmAveLuTUhH/JEwwegJ+sBqxnn42Uog11P4I1hJZFZj8xfriOBbd5V2KskL0rdVaaiECrAozUolUfZR4EmIQi1VQN5d9j1USTJDQV0+OlYyMOW2E22OLljXZ5lHciHaJWJpnwcWGv14wPhv+4WM2N8yByG0LBiXnep6aGIMlFIeAljqQQvkLjPqB8PTwQkPcO64k89lM0yj8xK4WsVRxsaBJVN8kAVy00KiQ3xqE0mK9A7Qb3lY+A==
Received: from BYAPR08CA0054.namprd08.prod.outlook.com (2603:10b6:a03:117::31)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 12:41:37 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:117:cafe::c2) by BYAPR08CA0054.outlook.office365.com
 (2603:10b6:a03:117::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 12:41:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 12:41:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 04:41:27 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 04:41:27 -0800
Received: from c-237-150-60-063.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Dec 2025 04:41:23 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 22 Dec 2025 14:40:43 +0200
Subject: [PATCH rdma-next v2 08/11] RDMA/nldev: Add command to get FRMR
 pools
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251222-frmr_pools-v2-8-f06a99caa538@nvidia.com>
References: <20251222-frmr_pools-v2-0-f06a99caa538@nvidia.com>
In-Reply-To: <20251222-frmr_pools-v2-0-f06a99caa538@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766407244; l=7559;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=v2AFSeJ3qTLHF7V5HBE9cjB1buiIfZdFzN7ymNJ1+ak=;
 b=4mDSBF1T9V+C7NSa+iw0WLE6QY2FuD3Z0RcFRhj2I59bAzqsQXvGA1cg6WUrv1eQ1/jwNb4wf
 mYVEMIMkYrHC+WkKRbj6716/zEF8w+uJkDNZTNm88R5k0uXkkdpXK15
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|CH2PR12MB4040:EE_
X-MS-Office365-Filtering-Correlation-Id: 37392f03-43b4-4c62-ebe3-08de41577270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2gxSGZyMCtFMmhsUkZQQTVVbXpHZG1CQlVlVjgxTDk0TlRDclFwdVhudDMy?=
 =?utf-8?B?TmQrTEhJeE9hb0tRTGZHbW9UZVpGSW9LRjZrclczTUx6UnpLNnFCWVFTZGlG?=
 =?utf-8?B?eTdlRUJHTmRjZVE0dnlFZndRQm1SMHJsUWRzb0loNkg3dEtVMHBIajdEMmtB?=
 =?utf-8?B?dlhqVlNsSTExdW1VcmhwYitaUVdEVkN1am1vOC9IU3RaRW5mdHIyQmw0cm4w?=
 =?utf-8?B?T2trdTJsQVVNUlVVOXU2RnRlbCt1OXViaVFSWnRKdUR1QllFVitleDRrOWRz?=
 =?utf-8?B?bmdWZnBuN2trNk5tQy80a0xRdHgyWmlYL25DTlJXNUhLWXVxL1J0djBadys3?=
 =?utf-8?B?bXBtcDBVc1I5NEhNb1YwcmpVcU5FMFdad09MQzMxKzJlcm9ocWd1V3ZwcG9M?=
 =?utf-8?B?dWt3MTJqKzZlZmhrNWFTYkszcmljc0N0Snh6TTI0TDdUVDFib1ZLaWo0SjBC?=
 =?utf-8?B?MUFpcVFRbFA0aFVFMGJMOE13bEE1TmxzQ1pObXdnNW05UDJoVjVsMitJeW9F?=
 =?utf-8?B?U3dYM0hTRm5tKzdGSUdmc1FJM1NBeEZjOEJWVUJnUC9yT0xXaUl6a0FIaVR2?=
 =?utf-8?B?bEJuNkNoNkRhQ2dlNGN2ZmViZ0hrUkVkQWFCNHVzTTNjYTJHOGRZM2sxZUs5?=
 =?utf-8?B?WE4yekVDbkJJdnZCOXBDSkk2enhISVBSdDltT284UkhhaTVnamg5MEJodDhN?=
 =?utf-8?B?VUEydC9jUXdUWi9qaXNPa25jczBCU0Z3ZnhKNk43ampGVm5ObW8yVGM0VVRH?=
 =?utf-8?B?YVRZYXhmaUNJM21KV0dPc1UyUFdhTXFwSXcwRmo2dDB4TUtOSS9JdUx0S1BD?=
 =?utf-8?B?RzNTTWJWK0oyK1dUTm8vNHUzczZVNkVseTk3bWJDWDNPclR5K21UWVF0QnUy?=
 =?utf-8?B?dFVpMUFWWEQyNU1ZOFN3M09YVCt3NzJ0TmRNM1JCeXpYZ08vL1IzbXlFREwv?=
 =?utf-8?B?NDZpVUdlbVQvbjY2SFhOT3VHWnZNWlAydnR1NFFybGtuZHIraWo4K29GdUZr?=
 =?utf-8?B?Z3dlWW9OeGVXK01VWmFXaFJJMDdudUtJT2gwZi9sMk5kL3lYMjNyaW1pdjFG?=
 =?utf-8?B?Tk40RXk4aDRZaGNraEt2dUV6MFVZd09DUG9ZeHlmY1UwZjJRSkdjWGVCeEFG?=
 =?utf-8?B?SEpmVTZMVDdhNExoNjl5Y05PaGt6SnBRVDdhRURNNUlDUi9MUGlvWWE3eDNi?=
 =?utf-8?B?UjJPbFR2ZDR2UXZmUDRVWjh1WnFUOTVMV09KVnVsZ0RXYkd0SW5mRWU1Q0Rm?=
 =?utf-8?B?NEtDa3lrd0FpNDY0SllBOWlvWjVvRjNyVURiZGdaRkpjd28wWFdjQmRSQmU3?=
 =?utf-8?B?WXE4Rk1MTEdrSUp1anUvelZ6UzZiSHZJOHoxZTczL0w5bkx2YU96TnFwb3ht?=
 =?utf-8?B?SDVrcUZmQWRxejVILzB3VUh3cE00TmoxMEMrUEt2U2xLa25pRHRNZkNNK2lH?=
 =?utf-8?B?Qlg5ZmZGakg0WnB0aThQOUVZcXdYWVpHenpXbDNVeEdCc0x5SFpwdEhhSnp0?=
 =?utf-8?B?ZzNxODVsNG1RVHhOZjJ6ak1ObXNUcllTTkRuYlYrSXFFUmk5YVJUN01DZXY5?=
 =?utf-8?B?YmV5bU1MMGlRWVBPYXlUS2w4eWNRVlFvUjcvSU04NWM3NGRoaW9VdmZHMHgz?=
 =?utf-8?B?dGx2Y1UvSEUrWXhXVis5UHd0SXpZRHZlaGdiQVRJdHJIakd5ckJoNmhwVFNq?=
 =?utf-8?B?RW5XUHpFM1RTMGVpb1ZmMnBua3hhTmVOVGNHRVg3WWxCanJOMTZBc3ZmVE1n?=
 =?utf-8?B?alV5SlR2R3V0Y2M4NVVDb0V2UXB2QXJmWTVWcDdwaDBwOWpJaXVEdnduMklv?=
 =?utf-8?B?a09tdXpCOFQ5OE8ybUxaRGtUTml4ZlAxOXVNR2x4cTZGL254TWE5SkMrcm8z?=
 =?utf-8?B?YTVHUm93OXRXelVSdTkvaGNPYkRoelpZUjlWTmRUZ0MwWld6c1BwREJGWW5p?=
 =?utf-8?B?a0FZWjdzWG5uYlZQYU55TUYyVVBXRUZsdmFLNThWQjB3YnFZbWNNS1Vvcm1G?=
 =?utf-8?B?ckZ2KzRUSkdnYzY1VHFmM0JIemppWFl2aDZmVTEwWkV1TVRlNTk4YTAwT0dq?=
 =?utf-8?B?SWdVdE0xOGtFWERuSnZNWXdlZm84UldDSkZBTks2VWVPcytyY25OOUE1c1ZK?=
 =?utf-8?Q?+TKuDWdL7GJHHe56uf7AaBEy+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 12:41:37.0795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37392f03-43b4-4c62-ebe3-08de41577270
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040

From: Michael Guralnik <michaelgur@nvidia.com>

Add support for a new command in netlink to dump to user the state of
the FRMR pools on the devices.
Expose each pool with its key and the usage statistics for it.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/nldev.c  | 165 +++++++++++++++++++++++++++++++++++++++
 include/uapi/rdma/rdma_netlink.h |  17 ++++
 2 files changed, 182 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 2220a2dfab24..6637c76165be 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -37,11 +37,13 @@
 #include <net/netlink.h>
 #include <rdma/rdma_cm.h>
 #include <rdma/rdma_netlink.h>
+#include <rdma/frmr_pools.h>
 
 #include "core_priv.h"
 #include "cma_priv.h"
 #include "restrack.h"
 #include "uverbs.h"
+#include "frmr_pools.h"
 
 /*
  * This determines whether a non-privileged user is allowed to specify a
@@ -172,6 +174,16 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_NAME_ASSIGN_TYPE]	= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_EVENT_TYPE]		= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_STAT_OPCOUNTER_ENABLED] = { .type = NLA_U8 },
+	[RDMA_NLDEV_ATTR_FRMR_POOLS]		= { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_ENTRY]	= { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY]		= { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS]	= { .type = NLA_U8 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS] = { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY] = { .type = NLA_U64 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS] = { .type = NLA_U64 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES] = { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE]	= { .type = NLA_U64 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE]	= { .type = NLA_U64 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -2637,6 +2649,156 @@ static int nldev_deldev(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return ib_del_sub_device_and_put(device);
 }
 
+static int fill_frmr_pool_key(struct sk_buff *msg, struct ib_frmr_key *key)
+{
+	struct nlattr *key_attr;
+
+	key_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_FRMR_POOL_KEY);
+	if (!key_attr)
+		return -EMSGSIZE;
+
+	if (nla_put_u8(msg, RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS, key->ats))
+		goto err;
+	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS,
+			key->access_flags))
+		goto err;
+	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY,
+			      key->vendor_key, RDMA_NLDEV_ATTR_PAD))
+		goto err;
+	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS,
+			      key->num_dma_blocks, RDMA_NLDEV_ATTR_PAD))
+		goto err;
+
+	nla_nest_end(msg, key_attr);
+	return 0;
+
+err:
+	return -EMSGSIZE;
+}
+
+static int fill_frmr_pool_entry(struct sk_buff *msg, struct ib_frmr_pool *pool)
+{
+	if (fill_frmr_pool_key(msg, &pool->key))
+		return -EMSGSIZE;
+
+	spin_lock(&pool->lock);
+	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES,
+			pool->queue.ci + pool->inactive_queue.ci))
+		goto err_unlock;
+	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE,
+			      pool->max_in_use, RDMA_NLDEV_ATTR_PAD))
+		goto err_unlock;
+	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,
+			      pool->in_use, RDMA_NLDEV_ATTR_PAD))
+		goto err_unlock;
+	spin_unlock(&pool->lock);
+
+	return 0;
+
+err_unlock:
+	spin_unlock(&pool->lock);
+	return -EMSGSIZE;
+}
+
+static int nldev_frmr_pools_get_dumpit(struct sk_buff *skb,
+				       struct netlink_callback *cb)
+{
+	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
+	struct ib_frmr_pools *pools;
+	int err, ret = 0, idx = 0;
+	struct ib_frmr_pool *pool;
+	struct nlattr *table_attr;
+	struct nlattr *entry_attr;
+	struct ib_device *device;
+	int start = cb->args[0];
+	struct rb_node *node;
+	struct nlmsghdr *nlh;
+	bool filled = false;
+
+	err = __nlmsg_parse(cb->nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
+			    nldev_policy, NL_VALIDATE_LIBERAL, NULL);
+	if (err || !tb[RDMA_NLDEV_ATTR_DEV_INDEX])
+		return -EINVAL;
+
+	device = ib_device_get_by_index(
+		sock_net(skb->sk), nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]));
+	if (!device)
+		return -EINVAL;
+
+	pools = device->frmr_pools;
+	if (!pools) {
+		ib_device_put(device);
+		return 0;
+	}
+
+	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
+					 RDMA_NLDEV_CMD_FRMR_POOLS_GET),
+			0, NLM_F_MULTI);
+
+	if (!nlh || fill_nldev_handle(skb, device)) {
+		ret = -EMSGSIZE;
+		goto err;
+	}
+
+	table_attr = nla_nest_start_noflag(skb, RDMA_NLDEV_ATTR_FRMR_POOLS);
+	if (!table_attr) {
+		ret = -EMSGSIZE;
+		goto err;
+	}
+
+	read_lock(&pools->rb_lock);
+	for (node = rb_first(&pools->rb_root); node; node = rb_next(node)) {
+		pool = rb_entry(node, struct ib_frmr_pool, node);
+		if (pool->key.kernel_vendor_key)
+			continue;
+
+		if (idx < start) {
+			idx++;
+			continue;
+		}
+
+		filled = true;
+
+		entry_attr = nla_nest_start_noflag(
+			skb, RDMA_NLDEV_ATTR_FRMR_POOL_ENTRY);
+		if (!entry_attr) {
+			ret = -EMSGSIZE;
+			goto end_msg;
+		}
+
+		if (fill_frmr_pool_entry(skb, pool)) {
+			nla_nest_cancel(skb, entry_attr);
+			ret = -EMSGSIZE;
+			goto end_msg;
+		}
+
+		nla_nest_end(skb, entry_attr);
+		idx++;
+	}
+end_msg:
+	read_unlock(&pools->rb_lock);
+
+	nla_nest_end(skb, table_attr);
+	nlmsg_end(skb, nlh);
+	cb->args[0] = idx;
+
+	/*
+	 * No more entries to fill, cancel the message and
+	 * return 0 to mark end of dumpit.
+	 */
+	if (!filled)
+		goto err;
+
+	ib_device_put(device);
+	return skb->len;
+
+err:
+	nlmsg_cancel(skb, nlh);
+	ib_device_put(device);
+	return ret;
+}
+
 static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 	[RDMA_NLDEV_CMD_GET] = {
 		.doit = nldev_get_doit,
@@ -2743,6 +2905,9 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 		.doit = nldev_deldev,
 		.flags = RDMA_NL_ADMIN_PERM,
 	},
+	[RDMA_NLDEV_CMD_FRMR_POOLS_GET] = {
+		.dump = nldev_frmr_pools_get_dumpit,
+	},
 };
 
 static int fill_mon_netdev_rename(struct sk_buff *msg,
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index f41f0228fcd0..8f17ffe0190c 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -308,6 +308,8 @@ enum rdma_nldev_command {
 
 	RDMA_NLDEV_CMD_MONITOR,
 
+	RDMA_NLDEV_CMD_FRMR_POOLS_GET, /* can dump */
+
 	RDMA_NLDEV_NUM_OPS
 };
 
@@ -582,6 +584,21 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_SYS_ATTR_MONITOR_MODE,	/* u8 */
 
 	RDMA_NLDEV_ATTR_STAT_OPCOUNTER_ENABLED,	/* u8 */
+
+	/*
+	 * FRMR Pools attributes
+	 */
+	RDMA_NLDEV_ATTR_FRMR_POOLS,		/* nested table */
+	RDMA_NLDEV_ATTR_FRMR_POOL_ENTRY,	/* nested table */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY,		/* nested table */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS,	/* u8 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS,	/* u32 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY,	/* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS,	/* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES,	/* u32 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE,	/* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,	/* u64 */
+
 	/*
 	 * Always the end
 	 */

-- 
2.49.0


