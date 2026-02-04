Return-Path: <linux-rdma+bounces-16549-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACI7EVemg2l3rgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16549-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 21:04:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F8CEC599
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 21:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65B123014946
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 20:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070AC38BF6C;
	Wed,  4 Feb 2026 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SbqgTgkS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CCE2E7BDE;
	Wed,  4 Feb 2026 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770235471; cv=fail; b=Cs4rW5h+FFlPGajOzhE8PECt7jJTviM6xIAi9dk+s+/DDsuu5v2Ez0owjn2ozONHeCGzqHc2891u7dVXJPvP74ZxvLfV6sSc/jAi8MSoUB8KxC/W5HxgWC2eldx4Dk7ZjgnptbAcpZIQ80x2gFMmVFodEgyRj1C3sL3E4B0VMyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770235471; c=relaxed/simple;
	bh=cYOB3zSYeNt+OVnNLmrsBWo5OJSn1UUTyfxY8eWsuBA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bjlqs7wYBlHVIr78L3Mh9y2clFj69eW/78/aZedGYFRM+8uLN4oJkMjgAOAPh3FpQU+U48L0fpVxhYM3edOQMDHOaJsaodzw3BEAxFZ8ee2cGV1pbv5AaOp7GDBOFxp2kOA8o6GXo2Jt+TRR8+EL3D5tpzIxLuMXbg3bGUnNvPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SbqgTgkS; arc=fail smtp.client-ip=52.101.53.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tn5S6ZTYX+PcTqR+idxQE/MqHsHUhvoyIHf3RRYrAYDMVJYuQH9MbHBq7KkdwazywmFNNR0kR1djpB00kFDtVhAnheBLATCXSDeGIyrda+Ye3UpDfg8Z8aOzBJW/r06BeJEbVj/SpZstslEjHND4m58gdzrKWnBwTtZIPfW+7Lr6HZ9YbX7585egtnAQe4Fe+IG9PHS5vJhNC6LmvGAnAUAcLloHoDsqlAW/hrt9ouE+y6qLOyjBIaN2DfscWCe+H+XV4gZ5RzAhZecHfMjKJdPmvUKTgothStQG2TWZxLJZsaUGXotnTO7LWKmTeBLWKI9Ue5+9PBafK24/w/S/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoX3XOoyDoi9FbiLBNd218LzayoCBxHjJEjvUIzef4U=;
 b=xWvyYMZD+q+kaEtwzCZi5vsxlllXJhqJBGQ5ogt/SVN6GF6o3uQsdBvSqK5o3EDd75K397DmxOgvs7IiAMVePyEkgnpZVzlX7AySdvKtHvM5VRp16kfSSgbz+LkVRvkF+787udUxJtOx2Tq4rTt9JKkpm8DpAam3aysUSsq382jemvcezR9DFyVIQu1cwS3kHQB+3cTYJ5Wf1d/fqXZjlwA4aAgLDVRbEQBPfQJKxzAafg8X6hG+twxd+gAULzwSTvDDyI4+SzCPbOQ7xmvXzi88OFxaRYq8/yyH+yfjwkPLbt1PbHBMH877UiGidcTUN/Wt7r44smbrl5apFpJKyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoX3XOoyDoi9FbiLBNd218LzayoCBxHjJEjvUIzef4U=;
 b=SbqgTgkSK/lCnrUQ5w4jpZzFtl1rlOrIZxW+QMbfqjvfe2u5bgjvct0jz18hCUDCh/5vDFux1eSgJPlyiT10tMYUqYB/C8ALdxSskPIe3UuQl68Amf6OjEBnCt4hGR0B65sVECvTUD3VB3tusVPz+sNllg2WYvuGAj1+UqC8Gnugl+lrtF/P1gIQbaGVF+eNtLTFXOdMJElLqFfxsXEjvRLZuJpXJPYyzHjRoV4EJEcapc0Pal+R2KhAKG8cAAu78kSMrcrv7g5oyQSg2XmP5bcTqr+AmPDULJRBlAOC/sxCmpQlNyduWqo/8aDqAlEHWd7k0znrhQVrIC9Rpsziug==
Received: from BY5PR04CA0016.namprd04.prod.outlook.com (2603:10b6:a03:1d0::26)
 by DM4PR12MB9069.namprd12.prod.outlook.com (2603:10b6:8:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Wed, 4 Feb
 2026 20:04:16 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::bb) by BY5PR04CA0016.outlook.office365.com
 (2603:10b6:a03:1d0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 20:04:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 20:04:14 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 12:03:59 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 4 Feb 2026 12:03:58 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Feb 2026 12:03:55 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V2] net/mlx5e: SHAMPO, Switch to header memcpy
Date: Wed, 4 Feb 2026 22:03:45 +0200
Message-ID: <20260204200345.1724098-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DM4PR12MB9069:EE_
X-MS-Office365-Filtering-Correlation-Id: 26332bd1-2e41-40a8-f2e7-08de642891eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qyi5dktDDH9GLQ/KLe+Z64Ha2QBYs47WNN998v3UZ8MPz5xJRzsdayOHdGyO?=
 =?us-ascii?Q?70CniHbnQz1O0cnTFHi6b78ZynLgde0tu783fbeIHPZp5rLIF7NjvSS4BpRC?=
 =?us-ascii?Q?Ny8hCBL6j1x2qLOgb8HhREYWFa7FHtUIOqEilMY2fEROrzX37mUG4BIGPwKz?=
 =?us-ascii?Q?LUCRermN/xhYstDIL0358ll5n8sOJkOLbUlozvApbH27djxTwBEoEiDGSr7o?=
 =?us-ascii?Q?GgRwj6OBPZp9WIf6A79nh0FZR0SJp6dOP90Ji/2jXwnzG+BXW0OzFXHBRIDI?=
 =?us-ascii?Q?gucijU4m/V3j5sokmelLL+r2TjYFDgSTvsTq7bQX9Uq1bMv0q+qAT+KsZ2hq?=
 =?us-ascii?Q?ydru8lCB2NMMZcMUT11cxPvYwcGcshAso/8kCu+r1han65Bh8LQrognQA2+G?=
 =?us-ascii?Q?iKnReXnSGeqQu3JC6Q6egXrjFR8Mks928baBLgdbHLIt2b0uqUswMeEPDpq1?=
 =?us-ascii?Q?Et+sV/58Q7QHp6A/aNS77sRZwdbD9rmfyoWGX/6offbsvHSBBPjSIUOIaWDR?=
 =?us-ascii?Q?iILCdy2BXud++2NrtiIX3L9nyzuSk6/lOUTAyUWmUxHaznTlBOJtgY+8zkvq?=
 =?us-ascii?Q?DQPTESKNcDSmjj9TyDEaw316/a5BV1ot1L8nD6P7ePoOGX9NnLVRS35U/1Al?=
 =?us-ascii?Q?irMdBD41zJjDRlyMwwdris8oLFT/K48jNnLf80eBIM1nQZDLxCnMThimnnAU?=
 =?us-ascii?Q?GiDed96Qmd5XFxpxcQe4bimmUmQ+M7U/3s44gFjbGr9jxdiJmyDW6UNaUgVg?=
 =?us-ascii?Q?oVCJqAejoQVFdDrSjrjmUvVJxzKFvY9IiAVrA1Bvfo7gmfbX4k7/XvmHm9/x?=
 =?us-ascii?Q?r8b/ivioNbgugY2FTOd3FDrYrxVzRkKrbkkG2SMxkTdyZUpUiab4h69aTB0b?=
 =?us-ascii?Q?gZxBT8FaSjamQrFXMHwhRtAKArggj+ya9bNbxAIN1asDbvStoAgoW5IZfeW5?=
 =?us-ascii?Q?nGzdnaWFEx8JGk9qNiAiqb9z/LCxiogtlhzXK6Fiw4aoldcxDt2zrHnnn1zu?=
 =?us-ascii?Q?IWYLsR4BTVpKBf4I3M4vJ2SrXggIub5hx6ZegeJR/G+YkDtMmYS32SkL/oGq?=
 =?us-ascii?Q?vTdEdqWJINywMtWqV5yD/bTQMex9BC+Hr1Clsi2BoAironiw+MgRxQjku9wy?=
 =?us-ascii?Q?FoDxusL2hmEFO9kE9V4JH7HADQ2Hn93X9W4s4z+D+QRR1tsr5YL1Y61RsiCY?=
 =?us-ascii?Q?M72uUCcDmbFszBNl/YeEUqDwbklKkXKYytuKJQLZll5osK3FDpYp7fpw2aGu?=
 =?us-ascii?Q?SrJDtAPMaUGMw1TSoT74MNmsbUk+MEgVD4IwLABhwCjDjcLnDZMFavz1OzjW?=
 =?us-ascii?Q?vwZAbmCGiCEXBHysfHeTkQxEghE09GnKrhwvdPDVpl0QIYZHHYvuhB9RD3bi?=
 =?us-ascii?Q?M1fmfSxkkGMDEyGs6dtfGxxPrzoB5J2T2ooCIbFAglNEpkyGDPXSe2A/vBbR?=
 =?us-ascii?Q?wq5X8mUZlfOxRGpAPTJ2GDvHnuVL1WTqPiWEOBWtALVAMoxfVGCfodOTuaJi?=
 =?us-ascii?Q?O1Rq4BzqJwEuSanPho/7XINMH98iVDNn504W4vFiRmt1yfxUB2mbLxO1bniz?=
 =?us-ascii?Q?Gmn3k/U3moCq+5iGgrDSi6ZcUqlZdO382KAJ3Sq7fGJFD4jdiQwV+beBumdg?=
 =?us-ascii?Q?At/05rgSouFWSLKssDIDbyrX+v2Qb10lt3QphxTZCKPQOztEZIck6eRVjsOx?=
 =?us-ascii?Q?Tz0JeQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gUGYU4MRs3PqspgIUWSxJ+At6MrHu8+lv1ypsHxf42seklKtsXTk1d1GyHDVcE7FheH0gwLLJAxhyGqBg9Ti9o0M5mwrhTOIzGudo2zfNBtyN+XKn8Esd1TD6T1O7EPYIMpfY0WrT1r/adtB9we5izbC9pUvIQSENra7ASpvbhg+onW1F74S/7O06nLxaZDxXrI1JsLvDuNOn3lhs9KR/Yz1jicwMlpplbG0s/4fC9rTGxgxjdXU6XcRBZpfvVcOZWIe5DRoaiPokIPb0cevyChTGaFoucjLCH1EVH/Z5kX+7Sgdohl82VzR6FOfhrroilGRHZQ4fKYGgzH3cb54LDcbhwGWdVdsVJJOkUqM7n8w8OK7m2yDPzxexSBxxrfVRPo2UDCzgtx7W7S3fXtcNqcB1ef7MW4GbNA75ynOl66f4mTTDaNUWhMbci3rSM8s
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 20:04:14.2592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26332bd1-2e41-40a8-f2e7-08de642891eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9069
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16549-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pp_params.dev:url,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 74F8CEC599
X-Rspamd-Action: no action

From: Dragos Tatulea <dtatulea@nvidia.com>

Previously the HW-GRO code was using a separate page_pool for the header
buffer. The pages of the header buffer were replenished via UMR. This
mechanism has some drawbacks:
- Reference counting on the page_pool page frags is not cheap.
- UMRs have HW overhead for updating and also for access. Especially for
  the KLM type which was previously used.
- UMR code for headers is complex.

This patch switches to using a static memory area (static MTT MKEY) for
the header buffer and does a header memcpy. This happens only once per
GRO session. The SKB is allocated from the per-cpu NAPI SKB cache.

Performance numbers for x86:
+---------------------------------------------------------+
| Test                | Baseline   | Header Copy | Change |
|---------------------+------------+-------------+--------|
| iperf3 oncpu        |  59.5 Gbps |  64.00 Gbps |   7 %  |
| iperf3 offcpu       | 102.5 Gbps | 104.20 Gbps |   2 %  |
| kperf oncpu         | 115.0 Gbps | 130.00 Gbps |  12 %  |
| XDP_DROP (skb mode) |   3.9 Mpps |   3.9 Mpps  |   0 %  |
+---------------------------------------------------------+

Notes on test:
- System: Intel(R) Xeon(R) Platinum 8380 CPU @ 2.30GHz
- oncpu: NAPI and application running on same CPU
- offcpu: NAPI and application running on different CPUs
- MTU: 1500
- iperf3 tests are single stream, 60s with IPv6 (for slightly larger
  headers)
- kperf version [1]

[1] git://git.kernel.dk/kperf.git

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  20 +-
 .../ethernet/mellanox/mlx5/core/en/params.c   |  23 --
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |   1 -
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 287 +++++++--------
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 341 +++---------------
 5 files changed, 188 insertions(+), 484 deletions(-)

V2:
- Consolidated mlx5e_shampo_get_header_offset() into a bigger function
  to avoid code duplication in the callers (Paolo).
- Dropped inline from static function (Paolo).
- Removed icosq resize for SHAMPO UMR headers. No longer needed.
- Link to V1: https://lore.kernel.org/all/1768224129-1600265-4-git-send-email-tariqt@nvidia.com/

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 19b9683f4622..843f732e4eed 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -82,9 +82,10 @@ struct page_pool;
 
 #define MLX5E_RX_MAX_HEAD (256)
 #define MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE (8)
-#define MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE (9)
-#define MLX5E_SHAMPO_WQ_HEADER_PER_PAGE (PAGE_SIZE >> MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE)
-#define MLX5E_SHAMPO_LOG_WQ_HEADER_PER_PAGE (PAGE_SHIFT - MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE)
+#define MLX5E_SHAMPO_WQ_HEADER_PER_PAGE \
+	(PAGE_SIZE >> MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE)
+#define MLX5E_SHAMPO_LOG_WQ_HEADER_PER_PAGE \
+	(PAGE_SHIFT - MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE)
 #define MLX5E_SHAMPO_WQ_BASE_HEAD_ENTRY_SIZE_SHIFT (6)
 #define MLX5E_SHAMPO_WQ_RESRV_SIZE_BASE_SHIFT (12)
 #define MLX5E_SHAMPO_WQ_LOG_RESRV_SIZE (16)
@@ -638,16 +639,11 @@ struct mlx5e_dma_info {
 };
 
 struct mlx5e_shampo_hd {
-	struct mlx5e_frag_page *pages;
 	u32 hd_per_wq;
-	u32 hd_per_page;
-	u16 hd_per_wqe;
-	u8 log_hd_per_page;
-	u8 log_hd_entry_size;
-	unsigned long *bitmap;
-	u16 pi;
-	u16 ci;
-	__be32 mkey_be;
+	u32 hd_buf_size;
+	u32 mkey;
+	u32 nentries;
+	DECLARE_FLEX_ARRAY(struct mlx5e_dma_info, hd_buf_pages);
 };
 
 struct mlx5e_hw_gro_data {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index c9bdee9a8b30..8e99d07586fa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -1068,26 +1068,6 @@ u32 mlx5e_shampo_hd_per_wq(struct mlx5_core_dev *mdev,
 	return hd_per_wq;
 }
 
-static u32 mlx5e_shampo_icosq_sz(struct mlx5_core_dev *mdev,
-				 struct mlx5e_params *params,
-				 struct mlx5e_rq_param *rq_param)
-{
-	int max_num_of_umr_per_wqe, max_hd_per_wqe, max_ksm_per_umr, rest;
-	void *wqc = MLX5_ADDR_OF(rqc, rq_param->rqc, wq);
-	int wq_size = BIT(MLX5_GET(wq, wqc, log_wq_sz));
-	u32 wqebbs;
-
-	max_ksm_per_umr = MLX5E_MAX_KSM_PER_WQE(mdev);
-	max_hd_per_wqe = mlx5e_shampo_hd_per_wqe(mdev, params, rq_param);
-	max_num_of_umr_per_wqe = max_hd_per_wqe / max_ksm_per_umr;
-	rest = max_hd_per_wqe % max_ksm_per_umr;
-	wqebbs = MLX5E_KSM_UMR_WQEBBS(max_ksm_per_umr) * max_num_of_umr_per_wqe;
-	if (rest)
-		wqebbs += MLX5E_KSM_UMR_WQEBBS(rest);
-	wqebbs *= wq_size;
-	return wqebbs;
-}
-
 #define MLX5E_LRO_TIMEOUT_ARR_SIZE                      4
 
 u32 mlx5e_choose_lro_timeout(struct mlx5_core_dev *mdev, u32 wanted_timeout)
@@ -1173,9 +1153,6 @@ static u8 mlx5e_build_icosq_log_wq_sz(struct mlx5_core_dev *mdev,
 		wqebbs += max_xsk_wqebbs;
 	}
 
-	if (params->packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO)
-		wqebbs += mlx5e_shampo_icosq_sz(mdev, params, rqp);
-
 	/* UMR WQEs don't cross the page boundary, they are padded with NOPs.
 	 * This padding is always smaller than the max WQE size. That gives us
 	 * at least (PAGE_SIZE - (max WQE size - MLX5_SEND_WQE_BB)) useful bytes
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 7e191e1569e8..f2a8453d8dce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -65,7 +65,6 @@ ktime_t mlx5e_cqe_ts_to_ns(cqe_ts_to_ns func, struct mlx5_clock *clock, u64 cqe_
 enum mlx5e_icosq_wqe_type {
 	MLX5E_ICOSQ_WQE_NOP,
 	MLX5E_ICOSQ_WQE_UMR_RX,
-	MLX5E_ICOSQ_WQE_SHAMPO_HD_UMR,
 #ifdef CONFIG_MLX5_EN_TLS
 	MLX5E_ICOSQ_WQE_UMR_TLS,
 	MLX5E_ICOSQ_WQE_SET_PSV_TLS,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 96dc6a6dc737..28ccb5ccf9b5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -492,40 +492,6 @@ static int mlx5e_create_umr_mkey(struct mlx5_core_dev *mdev,
 	return err;
 }
 
-static int mlx5e_create_umr_ksm_mkey(struct mlx5_core_dev *mdev,
-				     u64 nentries, u8 log_entry_size,
-				     u32 *umr_mkey)
-{
-	int inlen;
-	void *mkc;
-	u32 *in;
-	int err;
-
-	inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
-
-	in = kvzalloc(inlen, GFP_KERNEL);
-	if (!in)
-		return -ENOMEM;
-
-	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
-
-	MLX5_SET(mkc, mkc, free, 1);
-	MLX5_SET(mkc, mkc, umr_en, 1);
-	MLX5_SET(mkc, mkc, lw, 1);
-	MLX5_SET(mkc, mkc, lr, 1);
-	MLX5_SET(mkc, mkc, access_mode_1_0, MLX5_MKC_ACCESS_MODE_KSM);
-	mlx5e_mkey_set_relaxed_ordering(mdev, mkc);
-	MLX5_SET(mkc, mkc, qpn, 0xffffff);
-	MLX5_SET(mkc, mkc, pd, mdev->mlx5e_res.hw_objs.pdn);
-	MLX5_SET(mkc, mkc, translations_octword_size, nentries);
-	MLX5_SET(mkc, mkc, log_page_size, log_entry_size);
-	MLX5_SET64(mkc, mkc, len, nentries << log_entry_size);
-	err = mlx5_core_create_mkey(mdev, umr_mkey, in, inlen);
-
-	kvfree(in);
-	return err;
-}
-
 static int mlx5e_create_rq_umr_mkey(struct mlx5_core_dev *mdev, struct mlx5e_rq *rq)
 {
 	u32 xsk_chunk_size = rq->xsk_pool ? rq->xsk_pool->chunk_size : 0;
@@ -551,29 +517,6 @@ static int mlx5e_create_rq_umr_mkey(struct mlx5_core_dev *mdev, struct mlx5e_rq
 	return err;
 }
 
-static int mlx5e_create_rq_hd_umr_mkey(struct mlx5_core_dev *mdev,
-				       u16 hd_per_wq, __be32 *umr_mkey)
-{
-	u32 max_ksm_size = BIT(MLX5_CAP_GEN(mdev, log_max_klm_list_size));
-	u32 mkey;
-	int err;
-
-	if (max_ksm_size < hd_per_wq) {
-		mlx5_core_err(mdev, "max ksm list size 0x%x is smaller than shampo header buffer list size 0x%x\n",
-			      max_ksm_size, hd_per_wq);
-		return -EINVAL;
-	}
-
-	err = mlx5e_create_umr_ksm_mkey(mdev, hd_per_wq,
-					MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE,
-					&mkey);
-	if (err)
-		return err;
-
-	*umr_mkey = cpu_to_be32(mkey);
-	return 0;
-}
-
 static void mlx5e_init_frags_partition(struct mlx5e_rq *rq)
 {
 	struct mlx5e_wqe_frag_info next_frag = {};
@@ -754,145 +697,169 @@ static int mlx5e_init_rxq_rq(struct mlx5e_channel *c, struct mlx5e_params *param
 				  xdp_frag_size);
 }
 
-static int mlx5e_rq_shampo_hd_info_alloc(struct mlx5e_rq *rq, u16 hd_per_wq,
-					 int node)
+static void mlx5e_release_rq_hd_pages(struct mlx5e_rq *rq,
+				      struct mlx5e_shampo_hd *shampo)
+
 {
-	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
+	for (int i = 0; i < shampo->nentries; i++) {
+		struct mlx5e_dma_info *info = &shampo->hd_buf_pages[i];
 
-	shampo->hd_per_wq = hd_per_wq;
+		if (!info->page)
+			continue;
+
+		dma_unmap_page(rq->pdev, info->addr, PAGE_SIZE,
+			       rq->buff.map_dir);
+		__free_page(info->page);
+	}
+}
+
+static int mlx5e_alloc_rq_hd_pages(struct mlx5e_rq *rq, int node,
+				   struct mlx5e_shampo_hd *shampo)
+{
+	int err, i;
+
+	for (i = 0; i < shampo->nentries; i++) {
+		struct page *page = alloc_pages_node(node, GFP_KERNEL, 0);
+		dma_addr_t addr;
+
+		if (!page) {
+			err = -ENOMEM;
+			goto err_free_pages;
+		}
 
-	shampo->bitmap = bitmap_zalloc_node(hd_per_wq, GFP_KERNEL, node);
-	shampo->pages = kvzalloc_node(array_size(hd_per_wq,
-						 sizeof(*shampo->pages)),
-				      GFP_KERNEL, node);
-	if (!shampo->bitmap || !shampo->pages)
-		goto err_nomem;
+		addr = dma_map_page(rq->pdev, page, 0, PAGE_SIZE,
+				    rq->buff.map_dir);
+		err = dma_mapping_error(rq->pdev, addr);
+		if (err) {
+			__free_page(page);
+			goto err_free_pages;
+		}
+
+		shampo->hd_buf_pages[i].page = page;
+		shampo->hd_buf_pages[i].addr = addr;
+	}
 
 	return 0;
 
-err_nomem:
-	kvfree(shampo->pages);
-	bitmap_free(shampo->bitmap);
+err_free_pages:
+	mlx5e_release_rq_hd_pages(rq, shampo);
 
-	return -ENOMEM;
+	return err;
 }
 
-static void mlx5e_rq_shampo_hd_info_free(struct mlx5e_rq *rq)
+static int mlx5e_create_rq_hd_mkey(struct mlx5_core_dev *mdev,
+				   struct mlx5e_shampo_hd *shampo)
 {
-	kvfree(rq->mpwqe.shampo->pages);
-	bitmap_free(rq->mpwqe.shampo->bitmap);
+	enum mlx5e_mpwrq_umr_mode umr_mode = MLX5E_MPWRQ_UMR_MODE_ALIGNED;
+	struct mlx5_mtt *mtt;
+	void *mkc, *in;
+	int inlen, err;
+	u32 octwords;
+
+	octwords = mlx5e_mpwrq_umr_octowords(shampo->nentries, umr_mode);
+	inlen = MLX5_FLEXIBLE_INLEN(mdev, MLX5_ST_SZ_BYTES(create_mkey_in),
+				    MLX5_OCTWORD, octwords);
+	if (inlen < 0)
+		return inlen;
+
+	in = kvzalloc(inlen, GFP_KERNEL);
+	if (!in)
+		return -ENOMEM;
+
+	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
+
+	MLX5_SET(mkc, mkc, lw, 1);
+	MLX5_SET(mkc, mkc, lr, 1);
+	MLX5_SET(mkc, mkc, access_mode_1_0, MLX5_MKC_ACCESS_MODE_MTT);
+	mlx5e_mkey_set_relaxed_ordering(mdev, mkc);
+	MLX5_SET(mkc, mkc, qpn, 0xffffff);
+	MLX5_SET(mkc, mkc, pd, mdev->mlx5e_res.hw_objs.pdn);
+	MLX5_SET64(mkc, mkc, len, shampo->hd_buf_size);
+	MLX5_SET(mkc, mkc, log_page_size, PAGE_SHIFT);
+	MLX5_SET(mkc, mkc, translations_octword_size, octwords);
+	MLX5_SET(create_mkey_in, in, translations_octword_actual_size,
+		 octwords);
+
+	mtt = MLX5_ADDR_OF(create_mkey_in, in, klm_pas_mtt);
+	for (int i = 0; i < shampo->nentries; i++)
+		mtt[i].ptag = cpu_to_be64(shampo->hd_buf_pages[i].addr);
+
+	err = mlx5_core_create_mkey(mdev, &shampo->mkey, in, inlen);
+
+	kvfree(in);
+	return err;
 }
 
 static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 				struct mlx5e_params *params,
 				struct mlx5e_rq_param *rqp,
 				struct mlx5e_rq *rq,
-				u32 *pool_size,
 				int node)
 {
-	void *wqc = MLX5_ADDR_OF(rqc, rqp->rqc, wq);
-	u8 log_hd_per_page, log_hd_entry_size;
-	u16 hd_per_wq, hd_per_wqe;
-	u32 hd_pool_size;
-	int wq_size;
-	int err;
+	struct mlx5e_shampo_hd *shampo;
+	int nentries, err, shampo_sz;
+	u32 hd_per_wq, hd_buf_size;
 
 	if (!test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
 		return 0;
 
-	rq->mpwqe.shampo = kvzalloc_node(sizeof(*rq->mpwqe.shampo),
-					 GFP_KERNEL, node);
-	if (!rq->mpwqe.shampo)
-		return -ENOMEM;
-
-	/* split headers data structures */
 	hd_per_wq = mlx5e_shampo_hd_per_wq(mdev, params, rqp);
-	err = mlx5e_rq_shampo_hd_info_alloc(rq, hd_per_wq, node);
-	if (err)
-		goto err_shampo_hd_info_alloc;
-
-	err = mlx5e_create_rq_hd_umr_mkey(mdev, hd_per_wq,
-					  &rq->mpwqe.shampo->mkey_be);
-	if (err)
-		goto err_umr_mkey;
-
-	hd_per_wqe = mlx5e_shampo_hd_per_wqe(mdev, params, rqp);
-	wq_size = BIT(MLX5_GET(wq, wqc, log_wq_sz));
-
-	BUILD_BUG_ON(MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE > PAGE_SHIFT);
-	if (hd_per_wqe >= MLX5E_SHAMPO_WQ_HEADER_PER_PAGE) {
-		log_hd_per_page = MLX5E_SHAMPO_LOG_WQ_HEADER_PER_PAGE;
-		log_hd_entry_size = MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE;
-	} else {
-		log_hd_per_page = order_base_2(hd_per_wqe);
-		log_hd_entry_size = order_base_2(PAGE_SIZE / hd_per_wqe);
+	hd_buf_size = hd_per_wq * BIT(MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE);
+	nentries = hd_buf_size / PAGE_SIZE;
+	if (!nentries) {
+		mlx5_core_err(mdev, "SHAMPO header buffer size %u < %lu\n",
+			      hd_buf_size, PAGE_SIZE);
+		return -EINVAL;
 	}
 
-	rq->mpwqe.shampo->hd_per_wqe = hd_per_wqe;
-	rq->mpwqe.shampo->hd_per_page = BIT(log_hd_per_page);
-	rq->mpwqe.shampo->log_hd_per_page = log_hd_per_page;
-	rq->mpwqe.shampo->log_hd_entry_size = log_hd_entry_size;
-
-	hd_pool_size = (hd_per_wqe * wq_size) >> log_hd_per_page;
-
-	if (netif_rxq_has_unreadable_mp(rq->netdev, rq->ix)) {
-		/* Separate page pool for shampo headers */
-		struct page_pool_params pp_params = { };
+	shampo_sz = struct_size(shampo, hd_buf_pages, nentries);
+	shampo = kvzalloc_node(shampo_sz, GFP_KERNEL, node);
+	if (!shampo)
+		return -ENOMEM;
 
-		pp_params.order     = 0;
-		pp_params.flags     = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
-		pp_params.pool_size = hd_pool_size;
-		pp_params.nid       = node;
-		pp_params.dev       = rq->pdev;
-		pp_params.napi      = rq->cq.napi;
-		pp_params.netdev    = rq->netdev;
-		pp_params.dma_dir   = rq->buff.map_dir;
-		pp_params.max_len   = PAGE_SIZE;
+	shampo->hd_per_wq = hd_per_wq;
+	shampo->hd_buf_size = hd_buf_size;
+	shampo->nentries = nentries;
+	err = mlx5e_alloc_rq_hd_pages(rq, node, shampo);
+	if (err)
+		goto err_free;
 
-		rq->hd_page_pool = page_pool_create(&pp_params);
-		if (IS_ERR(rq->hd_page_pool)) {
-			err = PTR_ERR(rq->hd_page_pool);
-			rq->hd_page_pool = NULL;
-			goto err_hds_page_pool;
-		}
-	} else {
-		/* Common page pool, reserve space for headers. */
-		*pool_size += hd_pool_size;
-		rq->hd_page_pool = NULL;
-	}
+	err = mlx5e_create_rq_hd_mkey(mdev, shampo);
+	if (err)
+		goto err_release_pages;
 
 	/* gro only data structures */
 	rq->hw_gro_data = kvzalloc_node(sizeof(*rq->hw_gro_data), GFP_KERNEL, node);
 	if (!rq->hw_gro_data) {
 		err = -ENOMEM;
-		goto err_hw_gro_data;
+		goto err_destroy_mkey;
 	}
 
+	rq->mpwqe.shampo = shampo;
+
 	return 0;
 
-err_hw_gro_data:
-	page_pool_destroy(rq->hd_page_pool);
-err_hds_page_pool:
-	mlx5_core_destroy_mkey(mdev, be32_to_cpu(rq->mpwqe.shampo->mkey_be));
-err_umr_mkey:
-	mlx5e_rq_shampo_hd_info_free(rq);
-err_shampo_hd_info_alloc:
-	kvfree(rq->mpwqe.shampo);
+err_destroy_mkey:
+	mlx5_core_destroy_mkey(mdev, shampo->mkey);
+err_release_pages:
+	mlx5e_release_rq_hd_pages(rq, shampo);
+err_free:
+	kvfree(shampo);
+
 	return err;
 }
 
 static void mlx5e_rq_free_shampo(struct mlx5e_rq *rq)
 {
-	if (!test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
+	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
+
+	if (!shampo)
 		return;
 
 	kvfree(rq->hw_gro_data);
-	if (rq->hd_page_pool != rq->page_pool)
-		page_pool_destroy(rq->hd_page_pool);
-	mlx5e_rq_shampo_hd_info_free(rq);
-	mlx5_core_destroy_mkey(rq->mdev,
-			       be32_to_cpu(rq->mpwqe.shampo->mkey_be));
-	kvfree(rq->mpwqe.shampo);
+	mlx5_core_destroy_mkey(rq->mdev, shampo->mkey);
+	mlx5e_release_rq_hd_pages(rq, shampo);
+	kvfree(shampo);
 }
 
 static int mlx5e_alloc_rq(struct mlx5e_params *params,
@@ -970,7 +937,7 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		if (err)
 			goto err_rq_mkey;
 
-		err = mlx5_rq_shampo_alloc(mdev, params, rqp, rq, &pool_size, node);
+		err = mlx5_rq_shampo_alloc(mdev, params, rqp, rq, node);
 		if (err)
 			goto err_free_mpwqe_info;
 
@@ -1165,8 +1132,7 @@ int mlx5e_create_rq(struct mlx5e_rq *rq, struct mlx5e_rq_param *param, u16 q_cou
 	if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state)) {
 		MLX5_SET(wq, wq, log_headers_buffer_entry_num,
 			 order_base_2(rq->mpwqe.shampo->hd_per_wq));
-		MLX5_SET(wq, wq, headers_mkey,
-			 be32_to_cpu(rq->mpwqe.shampo->mkey_be));
+		MLX5_SET(wq, wq, headers_mkey, rq->mpwqe.shampo->mkey);
 	}
 
 	mlx5_fill_page_frag_array(&rq->wq_ctrl.buf,
@@ -1326,14 +1292,6 @@ void mlx5e_free_rx_missing_descs(struct mlx5e_rq *rq)
 	rq->mpwqe.actual_wq_head = wq->head;
 	rq->mpwqe.umr_in_progress = 0;
 	rq->mpwqe.umr_completed = 0;
-
-	if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state)) {
-		struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
-		u16 len;
-
-		len = (shampo->pi - shampo->ci) & shampo->hd_per_wq;
-		mlx5e_shampo_fill_umr(rq, len);
-	}
 }
 
 void mlx5e_free_rx_descs(struct mlx5e_rq *rq)
@@ -1356,9 +1314,6 @@ void mlx5e_free_rx_descs(struct mlx5e_rq *rq)
 			mlx5_wq_ll_pop(wq, wqe_ix_be,
 				       &wqe->next.next_wqe_index);
 		}
-
-		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
-			mlx5e_shampo_dealloc_hd(rq);
 	} else {
 		struct mlx5_wq_cyc *wq = &rq->wqe.wq;
 		u16 missing = mlx5_wq_cyc_missing(wq);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1fc3720d2201..02cebc190e9c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -611,165 +611,6 @@ static void mlx5e_post_rx_mpwqe(struct mlx5e_rq *rq, u8 n)
 	mlx5_wq_ll_update_db_record(wq);
 }
 
-/* This function returns the size of the continuous free space inside a bitmap
- * that starts from first and no longer than len including circular ones.
- */
-static int bitmap_find_window(unsigned long *bitmap, int len,
-			      int bitmap_size, int first)
-{
-	int next_one, count;
-
-	next_one = find_next_bit(bitmap, bitmap_size, first);
-	if (next_one == bitmap_size) {
-		if (bitmap_size - first >= len)
-			return len;
-		next_one = find_next_bit(bitmap, bitmap_size, 0);
-		count = next_one + bitmap_size - first;
-	} else {
-		count = next_one - first;
-	}
-
-	return min(len, count);
-}
-
-static void build_ksm_umr(struct mlx5e_icosq *sq, struct mlx5e_umr_wqe *umr_wqe,
-			  __be32 key, u16 offset, u16 ksm_len)
-{
-	memset(umr_wqe, 0, offsetof(struct mlx5e_umr_wqe, inline_ksms));
-	umr_wqe->hdr.ctrl.opmod_idx_opcode =
-		cpu_to_be32((sq->pc << MLX5_WQE_CTRL_WQE_INDEX_SHIFT) |
-			     MLX5_OPCODE_UMR);
-	umr_wqe->hdr.ctrl.umr_mkey = key;
-	umr_wqe->hdr.ctrl.qpn_ds = cpu_to_be32((sq->sqn << MLX5_WQE_CTRL_QPN_SHIFT)
-					    | MLX5E_KSM_UMR_DS_CNT(ksm_len));
-	umr_wqe->hdr.uctrl.flags = MLX5_UMR_TRANSLATION_OFFSET_EN | MLX5_UMR_INLINE;
-	umr_wqe->hdr.uctrl.xlt_offset = cpu_to_be16(offset);
-	umr_wqe->hdr.uctrl.xlt_octowords = cpu_to_be16(ksm_len);
-	umr_wqe->hdr.uctrl.mkey_mask     = cpu_to_be64(MLX5_MKEY_MASK_FREE);
-}
-
-static struct mlx5e_frag_page *mlx5e_shampo_hd_to_frag_page(struct mlx5e_rq *rq,
-							    int header_index)
-{
-	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
-
-	return &shampo->pages[header_index >> shampo->log_hd_per_page];
-}
-
-static u64 mlx5e_shampo_hd_offset(struct mlx5e_rq *rq, int header_index)
-{
-	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
-	u32 hd_per_page = shampo->hd_per_page;
-
-	return (header_index & (hd_per_page - 1)) << shampo->log_hd_entry_size;
-}
-
-static void mlx5e_free_rx_shampo_hd_entry(struct mlx5e_rq *rq, u16 header_index);
-
-static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
-				     struct mlx5e_icosq *sq,
-				     u16 ksm_entries, u16 index)
-{
-	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
-	u16 pi, header_offset, err, wqe_bbs;
-	u32 lkey = rq->mdev->mlx5e_res.hw_objs.mkey;
-	struct mlx5e_umr_wqe *umr_wqe;
-	int headroom, i;
-
-	headroom = rq->buff.headroom;
-	wqe_bbs = MLX5E_KSM_UMR_WQEBBS(ksm_entries);
-	pi = mlx5e_icosq_get_next_pi(sq, wqe_bbs);
-	umr_wqe = mlx5_wq_cyc_get_wqe(&sq->wq, pi);
-	build_ksm_umr(sq, umr_wqe, shampo->mkey_be, index, ksm_entries);
-
-	for (i = 0; i < ksm_entries; i++, index++) {
-		struct mlx5e_frag_page *frag_page;
-		u64 addr;
-
-		frag_page = mlx5e_shampo_hd_to_frag_page(rq, index);
-		header_offset = mlx5e_shampo_hd_offset(rq, index);
-		if (!header_offset) {
-			err = mlx5e_page_alloc_fragmented(rq->hd_page_pool,
-							  frag_page);
-			if (err)
-				goto err_unmap;
-		}
-
-		addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
-		umr_wqe->inline_ksms[i] = (struct mlx5_ksm) {
-			.key = cpu_to_be32(lkey),
-			.va  = cpu_to_be64(addr + header_offset + headroom),
-		};
-	}
-
-	sq->db.wqe_info[pi] = (struct mlx5e_icosq_wqe_info) {
-		.wqe_type	= MLX5E_ICOSQ_WQE_SHAMPO_HD_UMR,
-		.num_wqebbs	= wqe_bbs,
-		.shampo.len	= ksm_entries,
-	};
-
-	shampo->pi = (shampo->pi + ksm_entries) & (shampo->hd_per_wq - 1);
-	sq->pc += wqe_bbs;
-	sq->doorbell_cseg = &umr_wqe->hdr.ctrl;
-
-	return 0;
-
-err_unmap:
-	while (--i >= 0) {
-		--index;
-		header_offset = mlx5e_shampo_hd_offset(rq, index);
-		if (!header_offset) {
-			struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, index);
-
-			mlx5e_page_release_fragmented(rq->hd_page_pool,
-						      frag_page);
-		}
-	}
-
-	rq->stats->buff_alloc_err++;
-	return err;
-}
-
-static int mlx5e_alloc_rx_hd_mpwqe(struct mlx5e_rq *rq)
-{
-	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
-	u16 ksm_entries, num_wqe, index, entries_before;
-	struct mlx5e_icosq *sq = rq->icosq;
-	int i, err, max_ksm_entries, len;
-
-	max_ksm_entries = MLX5E_MAX_KSM_PER_WQE(rq->mdev);
-	ksm_entries = bitmap_find_window(shampo->bitmap,
-					 shampo->hd_per_wqe,
-					 shampo->hd_per_wq, shampo->pi);
-	ksm_entries = ALIGN_DOWN(ksm_entries, shampo->hd_per_page);
-	if (!ksm_entries)
-		return 0;
-
-	/* pi is aligned to MLX5E_SHAMPO_WQ_HEADER_PER_PAGE */
-	index = shampo->pi;
-	entries_before = shampo->hd_per_wq - index;
-
-	if (unlikely(entries_before < ksm_entries))
-		num_wqe = DIV_ROUND_UP(entries_before, max_ksm_entries) +
-			  DIV_ROUND_UP(ksm_entries - entries_before, max_ksm_entries);
-	else
-		num_wqe = DIV_ROUND_UP(ksm_entries, max_ksm_entries);
-
-	for (i = 0; i < num_wqe; i++) {
-		len = (ksm_entries > max_ksm_entries) ? max_ksm_entries :
-							ksm_entries;
-		if (unlikely(index + len > shampo->hd_per_wq))
-			len = shampo->hd_per_wq - index;
-		err = mlx5e_build_shampo_hd_umr(rq, sq, len, index);
-		if (unlikely(err))
-			return err;
-		index = (index + len) & (rq->mpwqe.shampo->hd_per_wq - 1);
-		ksm_entries -= len;
-	}
-
-	return 0;
-}
-
 static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 {
 	struct mlx5e_mpw_info *wi = mlx5e_get_mpw_info(rq, ix);
@@ -783,12 +624,6 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 	int err;
 	int i;
 
-	if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state)) {
-		err = mlx5e_alloc_rx_hd_mpwqe(rq);
-		if (unlikely(err))
-			goto err;
-	}
-
 	sync_locked = mlx5e_icosq_sync_lock(sq);
 	pi = mlx5e_icosq_get_next_pi(sq, rq->mpwqe.umr_wqebbs);
 	umr_wqe = mlx5_wq_cyc_get_wqe(wq, pi);
@@ -852,34 +687,11 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 
 	bitmap_fill(wi->skip_release_bitmap, rq->mpwqe.pages_per_wqe);
 
-err:
 	rq->stats->buff_alloc_err++;
 
 	return err;
 }
 
-static void
-mlx5e_free_rx_shampo_hd_entry(struct mlx5e_rq *rq, u16 header_index)
-{
-	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
-
-	if (((header_index + 1) & (shampo->hd_per_page - 1)) == 0) {
-		struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
-
-		mlx5e_page_release_fragmented(rq->hd_page_pool, frag_page);
-	}
-	clear_bit(header_index, shampo->bitmap);
-}
-
-void mlx5e_shampo_dealloc_hd(struct mlx5e_rq *rq)
-{
-	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
-	int i;
-
-	for_each_set_bit(i, shampo->bitmap, rq->mpwqe.shampo->hd_per_wq)
-		mlx5e_free_rx_shampo_hd_entry(rq, i);
-}
-
 static void mlx5e_dealloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 {
 	struct mlx5e_mpw_info *wi = mlx5e_get_mpw_info(rq, ix);
@@ -972,33 +784,6 @@ void mlx5e_free_icosq_descs(struct mlx5e_icosq *sq)
 	sq->cc = sqcc;
 }
 
-void mlx5e_shampo_fill_umr(struct mlx5e_rq *rq, int len)
-{
-	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
-	int end, from, full_len = len;
-
-	end = shampo->hd_per_wq;
-	from = shampo->ci;
-	if (from + len > end) {
-		len -= end - from;
-		bitmap_set(shampo->bitmap, from, end - from);
-		from = 0;
-	}
-
-	bitmap_set(shampo->bitmap, from, len);
-	shampo->ci = (shampo->ci + full_len) & (shampo->hd_per_wq - 1);
-}
-
-static void mlx5e_handle_shampo_hd_umr(struct mlx5e_shampo_umr umr,
-				       struct mlx5e_icosq *sq)
-{
-	struct mlx5e_channel *c = container_of(sq, struct mlx5e_channel, icosq);
-	/* assume 1:1 relationship between RQ and icosq */
-	struct mlx5e_rq *rq = &c->rq;
-
-	mlx5e_shampo_fill_umr(rq, umr.len);
-}
-
 int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
 {
 	struct mlx5e_icosq *sq = container_of(cq, struct mlx5e_icosq, cq);
@@ -1059,9 +844,6 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
 				break;
 			case MLX5E_ICOSQ_WQE_NOP:
 				break;
-			case MLX5E_ICOSQ_WQE_SHAMPO_HD_UMR:
-				mlx5e_handle_shampo_hd_umr(wi->shampo, sq);
-				break;
 #ifdef CONFIG_MLX5_EN_TLS
 			case MLX5E_ICOSQ_WQE_UMR_TLS:
 				break;
@@ -1227,15 +1009,6 @@ static unsigned int mlx5e_lro_update_hdr(struct sk_buff *skb,
 	return (unsigned int)((unsigned char *)tcp + tcp->doff * 4 - skb->data);
 }
 
-static void *mlx5e_shampo_get_packet_hd(struct mlx5e_rq *rq, u16 header_index)
-{
-	struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
-	u16 head_offset = mlx5e_shampo_hd_offset(rq, header_index);
-	void *addr = netmem_address(frag_page->netmem);
-
-	return addr + head_offset + rq->buff.headroom;
-}
-
 static void mlx5e_shampo_update_ipv4_udp_hdr(struct mlx5e_rq *rq, struct iphdr *ipv4)
 {
 	int udp_off = rq->hw_gro_data->fk.control.thoff;
@@ -1274,15 +1047,46 @@ static void mlx5e_shampo_update_ipv6_udp_hdr(struct mlx5e_rq *rq, struct ipv6hdr
 	skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_L4;
 }
 
+static void mlx5e_shampo_get_hd_buf_info(struct mlx5e_rq *rq,
+					 struct mlx5_cqe64 *cqe,
+					 struct mlx5e_dma_info **di,
+					 u32 *head_offset)
+{
+	u32 header_index = mlx5e_shampo_get_cqe_header_index(rq, cqe);
+	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
+	u32 di_index;
+
+	di_index = header_index >> MLX5E_SHAMPO_LOG_WQ_HEADER_PER_PAGE;
+	*di = &shampo->hd_buf_pages[di_index];
+	*head_offset = (header_index & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1)) *
+		       BIT(MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE);
+}
+
+static void *mlx5e_shampo_get_hdr(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe,
+				  int len)
+{
+	struct mlx5e_dma_info *di;
+	u32 head_offset;
+
+	mlx5e_shampo_get_hd_buf_info(rq, cqe, &di, &head_offset);
+
+	dma_sync_single_range_for_cpu(rq->pdev, di->addr, head_offset,
+				      len, rq->buff.map_dir);
+
+	return page_address(di->page) + head_offset;
+}
+
 static void mlx5e_shampo_update_fin_psh_flags(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe,
 					      struct tcphdr *skb_tcp_hd)
 {
-	u16 header_index = mlx5e_shampo_get_cqe_header_index(rq, cqe);
+	int nhoff = ETH_HLEN + rq->hw_gro_data->fk.control.thoff;
+	int len = nhoff + sizeof(struct tcphdr);
 	struct tcphdr *last_tcp_hd;
 	void *last_hd_addr;
 
-	last_hd_addr = mlx5e_shampo_get_packet_hd(rq, header_index);
-	last_tcp_hd =  last_hd_addr + ETH_HLEN + rq->hw_gro_data->fk.control.thoff;
+	last_hd_addr = mlx5e_shampo_get_hdr(rq, cqe, len);
+	last_tcp_hd = (struct tcphdr *)(last_hd_addr + nhoff);
+
 	tcp_flag_word(skb_tcp_hd) |= tcp_flag_word(last_tcp_hd) & (TCP_FLAG_FIN | TCP_FLAG_PSH);
 }
 
@@ -2272,52 +2076,25 @@ static struct sk_buff *
 mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 			  struct mlx5_cqe64 *cqe, u16 header_index)
 {
-	struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
-	u16 head_offset = mlx5e_shampo_hd_offset(rq, header_index);
-	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
 	u16 head_size = cqe->shampo.header_size;
-	u16 rx_headroom = rq->buff.headroom;
-	struct sk_buff *skb = NULL;
-	dma_addr_t page_dma_addr;
-	dma_addr_t dma_addr;
-	void *hdr, *data;
-	u32 frag_size;
-
-	page_dma_addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
-	dma_addr = page_dma_addr + head_offset;
-
-	hdr		= netmem_address(frag_page->netmem) + head_offset;
-	data		= hdr + rx_headroom;
-	frag_size	= MLX5_SKB_FRAG_SZ(rx_headroom + head_size);
+	struct mlx5e_dma_info *di;
+	struct sk_buff *skb;
+	u32 head_offset;
+	int len;
 
-	if (likely(frag_size <= BIT(shampo->log_hd_entry_size))) {
-		/* build SKB around header */
-		dma_sync_single_range_for_cpu(rq->pdev, dma_addr, 0, frag_size, rq->buff.map_dir);
-		net_prefetchw(hdr);
-		net_prefetch(data);
-		skb = mlx5e_build_linear_skb(rq, hdr, frag_size, rx_headroom, head_size, 0);
-		if (unlikely(!skb))
-			return NULL;
+	len = ALIGN(head_size, sizeof(long));
+	skb = napi_alloc_skb(rq->cq.napi, len);
+	if (unlikely(!skb)) {
+		rq->stats->buff_alloc_err++;
+		return NULL;
+	}
 
-		frag_page->frags++;
-	} else {
-		/* allocate SKB and copy header for large header */
-		rq->stats->gro_large_hds++;
-		skb = napi_alloc_skb(rq->cq.napi,
-				     ALIGN(head_size, sizeof(long)));
-		if (unlikely(!skb)) {
-			rq->stats->buff_alloc_err++;
-			return NULL;
-		}
+	net_prefetchw(skb->data);
 
-		net_prefetchw(skb->data);
-		mlx5e_copy_skb_header(rq, skb, frag_page->netmem, dma_addr,
-				      head_offset + rx_headroom,
-				      rx_headroom, head_size);
-		/* skb linear part was allocated with headlen and aligned to long */
-		skb->tail += head_size;
-		skb->len  += head_size;
-	}
+	mlx5e_shampo_get_hd_buf_info(rq, cqe, &di, &head_offset);
+	mlx5e_copy_skb_header(rq, skb, page_to_netmem(di->page), di->addr,
+			      head_offset, head_offset, len);
+	__skb_put(skb, head_size);
 
 	/* queue up for recycling/reuse */
 	skb_mark_for_recycle(skb);
@@ -2418,7 +2195,7 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 			 * prevent the kernel from touching it.
 			 */
 			if (unlikely(netmem_is_net_iov(frag_page->netmem)))
-				goto free_hd_entry;
+				goto mpwrq_cqe_out;
 			*skb = mlx5e_skb_from_cqe_mpwrq_nonlinear(rq, wi, cqe,
 								  cqe_bcnt,
 								  data_offset,
@@ -2426,19 +2203,22 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 		}
 
 		if (unlikely(!*skb))
-			goto free_hd_entry;
+			goto mpwrq_cqe_out;
 
 		NAPI_GRO_CB(*skb)->count = 1;
 		skb_shinfo(*skb)->gso_size = cqe_bcnt - head_size;
 	} else {
 		NAPI_GRO_CB(*skb)->count++;
+
 		if (NAPI_GRO_CB(*skb)->count == 2 &&
 		    rq->hw_gro_data->fk.basic.n_proto == htons(ETH_P_IP)) {
-			void *hd_addr = mlx5e_shampo_get_packet_hd(rq, header_index);
-			int nhoff = ETH_HLEN + rq->hw_gro_data->fk.control.thoff -
-				    sizeof(struct iphdr);
-			struct iphdr *iph = (struct iphdr *)(hd_addr + nhoff);
+			int len = ETH_HLEN + rq->hw_gro_data->fk.control.thoff;
+			int nhoff = len - sizeof(struct iphdr);
+			void *last_hd_addr;
+			struct iphdr *iph;
 
+			last_hd_addr = mlx5e_shampo_get_hdr(rq, cqe, len);
+			iph = (struct iphdr *)(last_hd_addr + nhoff);
 			rq->hw_gro_data->second_ip_id = ntohs(iph->id);
 		}
 	}
@@ -2460,13 +2240,10 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 
 	if (mlx5e_shampo_complete_rx_cqe(rq, cqe, cqe_bcnt, *skb)) {
 		*skb = NULL;
-		goto free_hd_entry;
+		goto mpwrq_cqe_out;
 	}
 	if (flush && rq->hw_gro_data->skb)
 		mlx5e_shampo_flush_skb(rq, cqe, match);
-free_hd_entry:
-	if (likely(head_size))
-		mlx5e_free_rx_shampo_hd_entry(rq, header_index);
 mpwrq_cqe_out:
 	if (likely(wi->consumed_strides < rq->mpwqe.num_strides))
 		return;

base-commit: 9a9424c756feee9ee6e717405a9d6fa7bacdef08
-- 
2.44.0


