Return-Path: <linux-rdma+bounces-5826-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1C79BFF90
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 09:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A0CFB225D4
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 08:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2511199FA1;
	Thu,  7 Nov 2024 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r5KM4a5/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD8B18755C;
	Thu,  7 Nov 2024 08:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730966643; cv=fail; b=QEq47hp/7pyiGcvdVTzQ+zlOu4KZK1ULQPhOumGYM/D6xEDn4LKJYfMxxdeCSM8ndM08pE1Hu4RgUo5iEluTVxwM63XB20NEzrabXDQyLoZiwM+uDaNNGxysDvRRNetpce5tQzJdN6ZsXqaWq37g/21fFB9GisOm8BIm1YVy0UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730966643; c=relaxed/simple;
	bh=ifbbT5SLqk69jmXpMRN2+S7EeXMvWGAs874I8h8Dszw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=biu/oncGBWZdVrnG1R4FjzJaejcDTSe77TVYCqzVtbaiYBzzirHUAunWmcL6NJ2MzNqf/gvB8BArmsr3xf1c7BvKZ0vQ7hwI/Re4Y7fTw2qH8hbvODEJdDWYi5Uhhf9Hzx8s2EZPpIDRyqRo9IINsysMzygK/LY8AqmwyJhe6t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r5KM4a5/; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xK1UGlieM9CHi1i1UqOX1+j3DNa9X8wytjCCWiU29lEoBk2X5RiVYsM97qlFTLGk/E2sKznXPQJcGPlW0rn8bgnqy0mOwNUBQVEI5gm4ITHeurmcBq4I/b4Kb8w2WjAFpidOHzHWlALzldnw4ex75iJcYoA1YVoWMVqJTsEkOH7Cie989PUqFQrrxFvFw/PeFHu95J+4hHF53SGTVy4/gKyhqBDE07unq+FTjFOD8mw60pfb8p9VzFe19fGIfnNcyllMN7ZIC98wqeYFGIMLLMwPE1L+roCmh1+wukOcFM74f6bLMEoyNToy/U3p4FVsHuNyvXq9QUYOUB4lUNf+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dT9McGKXAZ+klYbH3avszvGz3fNkjL06YVQjRQT2AHI=;
 b=xX0hYTlnANDt+JyZ+2a0wV+OhiZrMLfWF4V1GOn0ZXsCwagOvrbIihtCzOhxlIbWM1WYGZFHpYCnp6pEfGlJygsnSPmmBKhXKIXpuLzlCFh9mLRAMq6uBMUGIB/30nQCKCy1uy2F3jY/LHC5h6Dg9hC/ld49+dOeRjh7wWy+Cj80g3QeAPryxYKoA+l/r/6GA1AIelLpCmNoGhFZGkaS8StXPDIfHSu7DlpbLSbwsqIep5J4jxTuHZUhi6Fr8P+sj4T3tnaYYWYFJTFU2umYot9NrcWC6r+k6tCyo5PgRXE7Sh8IzEzVEQSwILlBYIFn3fzCthv6Mq0b76WnOpd9ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dT9McGKXAZ+klYbH3avszvGz3fNkjL06YVQjRQT2AHI=;
 b=r5KM4a5/PX3p66ur54Fx4wwHjAQ89NOf3l1OXbwCBJvO8ecA3q/PL4pd8K7XXS23tPezP3cGekwCF8U8Ts7Wb/KP1QzPjNaxcBQGZzDpR3XVtSnUFCQZ7QKXGzMxqBNYXDt4vMH/eZMaWgdFGTXheWi1gXFOZtXBjX1Scimcp7cZPvN2ldHPdLyNxr/XJHRjrStkozS+ilgDXLwDJlr92w5+hycyQPQNJvu8AscEKOHqvsKxMZw9nkcAhBJk1LZ1NUKTD3WKtEOpgvDJNUpoLMu09NzBjnpR8QcgJLS79qTeckIFtJS8zXhLVeyd8u9V8Mdf1yT1gpKzMCFpVc0ncw==
Received: from BLAPR03CA0103.namprd03.prod.outlook.com (2603:10b6:208:32a::18)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 08:03:57 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::c8) by BLAPR03CA0103.outlook.office365.com
 (2603:10b6:208:32a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Thu, 7 Nov 2024 08:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 08:03:57 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 00:03:45 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 00:03:45 -0800
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 00:03:43 -0800
From: Chiara Meiohas <cmeioahs@nvidia.com>
To: <dsahern@gmail.com>, <leonro@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>,
	<stephen@networkplumber.org>, Chiara Meiohas <cmeiohas@nvidia.com>
Subject: [PATCH v2 iproute2-next 0/5] Add RDMA monitor support
Date: Thu, 7 Nov 2024 10:02:43 +0200
Message-ID: <20241107080248.2028680-1-cmeioahs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 83576ba3-e410-4a41-f1a3-08dcff02bb3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GQEh4ngG+o7k9yvYwm+NwCv+LJ8fswFkRZjW+dvjCOhPB7+5MW4UiQwAzz7e?=
 =?us-ascii?Q?SzybFGRilsmyISiXBQ9MARGqVyJJd8ALw/y9nzAFVGMxQuBtq1WH5Qq4AdGh?=
 =?us-ascii?Q?3KIsf1OD4amykS8hCd0mdJ56LlmHfQVGAJPK77pX+zXCzY2p6UcL/yINoQZy?=
 =?us-ascii?Q?YVlbXxwqpNnEIrNie6MMucUPDtwmJPWCj9bVjZK2KLKHxa/1U79Vc9BeHP5h?=
 =?us-ascii?Q?ATiUDNfZno7ORM8MZsXnQO1Lp8APQyrsvC9JnkCmS+kANLOgcQiB9LFhtq5n?=
 =?us-ascii?Q?C8XELoIMkAFrCygpr3wHUMPlR7eFNCmZPhm0UBx3eQ0gabKcXddGov+sBZUP?=
 =?us-ascii?Q?KFIedTLVoNjSK5VZThTLJaS+TP6fc0A+6oVdtO3wxT03/wC2G90eg07oJ+PP?=
 =?us-ascii?Q?ZvFeU8sahEhygTNEfCrgFOBpTmb9MrlupbO3kMu6il6XEuMsQZXtamYgh8Ia?=
 =?us-ascii?Q?bqrSfgxLqua1htiS+PXaCP8c5CSmV2vcIhz2rv4izlaIkl9fGAS0xfH96aKn?=
 =?us-ascii?Q?0kf8LOcUv0uByd9iHjZZfqFWx+VAFQJpQastqBCbZA4vbGM5/bghQPWNUGlU?=
 =?us-ascii?Q?ySLfSRokhnpAIb3zS7/GXV6SZQqfMWrcmB8p6q6xUDuyQCFQa0furulxrvUh?=
 =?us-ascii?Q?+WX1ibGUMXM561LkPtYnRjkb6Enano5rLP8bhdghElbTMWPHt2haOJ9lAoK9?=
 =?us-ascii?Q?yjMliaJJmflhmtQxfp75PFdZXDMY/1EXBq8lFqJVoPMidmC3XTyxFMVLUDme?=
 =?us-ascii?Q?R8WVzhUoQknGavzla/O+LgYrX/k5HgbC6QX52N/anofLMYCqbHdNGREa4ysK?=
 =?us-ascii?Q?Tps7X+/Tmy5/Nm20jf1x6q92TVPKq6KqejdMdo9EnIwD5gi0oICHMabfjPoY?=
 =?us-ascii?Q?frpZ0i+lJZZu+kRDNq59ZpZc6OjcAcnplb6KLuUMtj1e8mZN5GV7Y4kXdI8g?=
 =?us-ascii?Q?f1XDQ5MDIyc1+1K5LhDqjDDGkyVSgB8An6raOXuZjVs3PJYfC2aT/dFLVI9l?=
 =?us-ascii?Q?VOReIM0IccEzPVz2VE3yKqo4QN2bTs8Hd3YdyXX1bXNoVgzI+9UCULhFhuJ0?=
 =?us-ascii?Q?GtQOa9TXXWwNd++JfgoMiQcJRtGfpdsT7QDEZxY9HBD9V81rzPo+3HCRcDgr?=
 =?us-ascii?Q?YWc3lZg8jo3PN33Lky02u7kFvmH7MKyBgd4qSvQNAnftm13rBF0s9MC2WinS?=
 =?us-ascii?Q?HJBdRfuOGNH3OBhxH8Ulb3JlIyi6YOj/D0aqIIGPW2N++93va6k2+X1usY3j?=
 =?us-ascii?Q?HwSvcrCgmVuKBVICDO1StZ2+8UFVtCGNLT+7UVG8xP+NrEpZbBPc3AZDCkiY?=
 =?us-ascii?Q?gZtyO3TZzzaeWOonYwy8VH3X7LngdKxd8FV5XHwHbuhMeIYqIknlHs6RQyso?=
 =?us-ascii?Q?iDpz+kqE+g1wcPB1e4hPXxUbHm4BwZl6gQ8RljXIjrMTVwBycg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 08:03:57.4218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83576ba3-e410-4a41-f1a3-08dcff02bb3e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103

From: Chiara Meiohas <cmeiohas@nvidia.com>

This series adds support to a new command to monitor IB events
and expands the rdma-sys command to indicate whether this new
functionality is supported.
We've also included a fix for a typo in rdma-link man page.

Command usage and examples are in the commits and man pages.

These patches are complimentary to the kernel patches:
https://lore.kernel.org/linux-rdma/20240821051017.7730-1-michaelgur@nvidia.com/
https://lore.kernel.org/linux-rdma/093c978ef2766fd3ab4ff8798eeb68f2f11582f6.1730367038.git.leon@kernel.org/

--
v1->v2
- Print hex value if an unknown event is received
- Add IB device and net device names in the output
- Add IB device and net device rename events

Chiara Meiohas (5):
  rdma: Add support for rdma monitor
  rdma: Expose whether RDMA monitoring is supported
  rdma: Fix typo in rdma-link man page
  rdma: update uapi headers
  rdma: Add IB device and net device rename events

 include/mnl_utils.h                   |   1 +
 lib/mnl_utils.c                       |   5 +
 man/man8/rdma-link.8                  |   2 +-
 man/man8/rdma-monitor.8               |  51 ++++++++
 man/man8/rdma-system.8                |   9 +-
 man/man8/rdma.8                       |   7 +-
 rdma/Makefile                         |   3 +-
 rdma/include/uapi/rdma/rdma_netlink.h |   2 +
 rdma/monitor.c                        | 171 ++++++++++++++++++++++++++
 rdma/rdma.c                           |   3 +-
 rdma/rdma.h                           |   1 +
 rdma/sys.c                            |   6 +
 rdma/utils.c                          |   2 +
 13 files changed, 255 insertions(+), 8 deletions(-)
 create mode 100644 man/man8/rdma-monitor.8
 create mode 100644 rdma/monitor.c

-- 
2.44.0


