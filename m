Return-Path: <linux-rdma+bounces-13711-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4825DBA7861
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 23:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E56667AAE39
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 21:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54C629ACE5;
	Sun, 28 Sep 2025 21:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R71V4ey4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008AE225D6;
	Sun, 28 Sep 2025 21:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759094751; cv=fail; b=UNZPYZsqvOgFqYytLqBiRI18wi/K/yWIqUhCshVfSpVhUuUchyFwbyZCK617kYOxLamsC6FVSyZg+pYx1BHzpvSPKw+AdNnsDAsMzdvIuLzJ6suHSzx7WbnXJJ5Ytap3BVEvg4OYU9ZPpgYA/nsdQFBC7Cgj7ojxA7RH2RQdBW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759094751; c=relaxed/simple;
	bh=ijW8ALPkzEdRHLQMM4ptjnl29xi0KQJjCL5x4HL8poo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b5euKaWNpbxuT9Ypv2AR7CPLD+bcjxqd1VFG6x0LNszQp0+7FCgkpxAYK12KV1x7SGs/RCOJ/vbrQnQ6PM0P6xiyTp+vMVgDyOOJAyYW4ioENHF2z1su/433APlIURUX8n7B4H8mMsw6jiaGwbX4e4GmO4Zaeiknt3atstZD1oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R71V4ey4; arc=fail smtp.client-ip=40.107.209.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5JmXVy0GlO4ey4aK1NMzPFCEOj/1HOKCbefocFCKYfniAZ/bML3zm4dpiS6THe5sdN5FIPav+vUyCU50i0BAmjkdDu62+zBSfLAJLmP2aWolMDQnPD8kZIQWaoSKn6mADNt9d7L3xblbcOXAxgX78ruDUQ8XVjfU/BbfTa6p9hAU02nB2Cp+Y7lPVbfGOHwnlAeCd2r3i9tliOZl1dTTQOOXUG7o3fdgNcGeGMQPmXu97DAor2NhxI8OBvlWSP1osA0cHVzqsCEHcW8cLKl1skeiHhDgXItvEbTaqwQXraXsmkflwTl4BNBmAB0G/wTVfNDmzzM6+0W/MNPAr4fCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjkYRR7YVbl9JeBmiY+ul7qwLR+HNwPc6xsTw7Sa9V0=;
 b=wQCnuDNzYOmpZUCFNov41QRUgMm3c79Yr50GICXNsILxXBmBGfr3MqKmij2HM+y0JZ3PX1OnIJiwOMzG01bW+KGNPKSGdacT/1fBsd0QH74pzjkNxikN1foogyhaKk6tC/q8ciA8rwdi4SB48Et0Ej1uTOKgXjF0VeZA3ZKJ8/UzwinxB77vEdJ7eKnBSUKtWIcydmsPQobwBDk9zVtr3FKpD/xbaOK6ZpZyrEKkM1csEDsc7dt718LmnIht4kR1OKqGgYntlAps1ZYQbLoSmLGM8l0DHH1rrlRZOh6xNPiujwnVmwfkF24iVuNa1c7LcAwBC4eTKLjSmg+rdeNrxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjkYRR7YVbl9JeBmiY+ul7qwLR+HNwPc6xsTw7Sa9V0=;
 b=R71V4ey4kYjWkmTlVJTn4mz5aWuqGhdIOUrM5A6zw2+pEDwpRvLVrylIiFC/qyaavNhioN9pjlYefn9s78NTTUuYJQpKcvITV1k4Cqn59Ch6uT4vl2U01nc9+6g1xRsrLMHRkqv52DfXNpb4hxY0qU1hZ/ahnCKudtyUCd5959L4For2TS3iqniYkgJUd5jpi/w+hhXx8I/3t96GUDimuJGx2M1K5CjFGbjguS1GDFddsjTioxC2Mqt8EN0GrwhuNdmezWbVJASw3tt51tlgChh3YTNsAK2N80fEEAR9wxzyv/IYGJ/u0g1K/PAi7DgJ5h4ZtRMVLUHfSCV2Yz6V/Q==
Received: from SJ0PR03CA0180.namprd03.prod.outlook.com (2603:10b6:a03:338::35)
 by CH8PR12MB9792.namprd12.prod.outlook.com (2603:10b6:610:2b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Sun, 28 Sep
 2025 21:25:45 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::8a) by SJ0PR03CA0180.outlook.office365.com
 (2603:10b6:a03:338::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.12 via Frontend Transport; Sun,
 28 Sep 2025 21:25:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Sun, 28 Sep 2025 21:25:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 28 Sep
 2025 14:25:44 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 28 Sep 2025 14:25:43 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 28 Sep 2025 14:25:40 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
Subject: [PATCH net-next V2 0/7] net/mlx5: misc changes 2025-09-28
Date: Mon, 29 Sep 2025 00:25:16 +0300
Message-ID: <1759094723-843774-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|CH8PR12MB9792:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a99fd0-f99f-4f46-05bf-08ddfed595d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dy1aOGdL9X6p2eLFgPlU2qiMKMUcxlu0Bsu1tSCjKGut6BzJ2v60BtghhMRI?=
 =?us-ascii?Q?yl9hZvVc4eU13cO4jBipkeWY0YRNcqJNBCmM2iUBndlMfc8d8G3oHCttld+P?=
 =?us-ascii?Q?z1DB2M2mtu3w7DhidxWuQvY8W6sa+rCv6d6iXMCIkspqFV2WJn0sjCjeM4vL?=
 =?us-ascii?Q?aJsq23v6iqdFuCVvXbtjutfnU8VFCT75ehnUQj+zvA4XSvmdBXGL6cRUDx/d?=
 =?us-ascii?Q?kZ26SmxmilUIdzxhkGCbenxWjiA14tQ6XYef/pMm3Q+xnfOiAUejTEFn1DQ4?=
 =?us-ascii?Q?KZB12OmMuC+a6ntGxkxc9jk0gX3DEH+tW2sm51vuK5wZGO1pl7OKwxadLyLd?=
 =?us-ascii?Q?rtNUysETszPLw/UADu1kVVtfy6pLfIUk3C6rt4Hyzy3xhIwWk04NuWs78+mh?=
 =?us-ascii?Q?qNAQPK9E8uvDZRDjbNAdgQn2RL6zghj76CVQfToY6aW13pxGqRv+KcdkpCJQ?=
 =?us-ascii?Q?SvdDtWiTRf1NGNnTDj9ajt+N46AyhGs0gIKV+KN44jJKs9ni7KW3OSOjOooS?=
 =?us-ascii?Q?LvHYTnNf87VHhdWcbhQWeoxv9ZfgiQcuO4bjbw/unMkatoCOOASernrx6zvf?=
 =?us-ascii?Q?3XDI2IeLPIhmjIBLCoiw35ZAB9R2zMLQzX3TujZxXY7vl4bsZt6Xs3U7T+rM?=
 =?us-ascii?Q?ZBn5fPkJLMRWYlHlvW3NNgF1fs2UqM8gMejoMZ+MGvqgnK6mf14/1xt4GTQn?=
 =?us-ascii?Q?iSGu5OxUtXM3YnakLl3oJc9wkPgea6WovXT1h4HXwJlMmREWGOXIQD68NBrt?=
 =?us-ascii?Q?jZy1dWIPgQ6nWPRX0oP0w2xPv4ilPRnH/smsV1GjPhQ8xg1a+AxQ/Xsz/ESo?=
 =?us-ascii?Q?vDhaYkvoIsYnwi8ZrFeFVMf+RWbapwD3NKbNtop+QJuliuR7NNY8lehwb9pw?=
 =?us-ascii?Q?6iBqby8aZNWBTrpcZ9/PTkawCV+E+NcWl2CbPUuxav85GJfk6bMOwzh5vbuu?=
 =?us-ascii?Q?J3W/cRZGQNVWw9Us9BOuE7n/D1OJ4hlQp9vpfLc5tGh0Ql/A8PEHlHgmfs4K?=
 =?us-ascii?Q?FHWJO40XYkDH5POC6JrJY7FsIUeSsfcDly6LX80vRShdExB4Bq3w4pcKTo3k?=
 =?us-ascii?Q?uGM/bI7e+BqkXKVJXJb8dFuFDOdwrgQDHs9RsGOGAEc0tJ3QfyJbcptEvsrL?=
 =?us-ascii?Q?FICLdJmEAfcB3ujWQvWUF1TlZSnYgX/SIicEnpruxEUEFniXW+YoEk6I0vF4?=
 =?us-ascii?Q?fbw585QGbosBDOdnClHgrJR7y0gbbFEdxwRDWZ+wyvmkiOrz4SZHwSraXWLw?=
 =?us-ascii?Q?OH9SzOm2Zb2x1TA4LIipocN3OS5aK3LMeN0GhPSg8t5X9MZWnrAA1QU6VPL0?=
 =?us-ascii?Q?GV7zf72JZKUhgzAlrkMHtj1TGyDrtw55XH6A1opr4lWT/VjqcAU+8F7fZ/v0?=
 =?us-ascii?Q?mKKOPJMC9b18CslV2UZQS41TH7xB031Z70d56qISC9/KQgoJKmmyr0WoQzBl?=
 =?us-ascii?Q?13dUgdU4iwuRZcxM0DYCVRVABp1qV8dmU4L+cu7cpJyAmWV1KIr9TdAWY2ht?=
 =?us-ascii?Q?FaBDP431skW3l+oDPLWjwqLBc7XlYif+SolBPj4PpWjzqTrnpy1zWyrRj5J6?=
 =?us-ascii?Q?MGA0J/eR/ojnKphImZE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 21:25:45.0727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a99fd0-f99f-4f46-05bf-08ddfed595d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9792

Hi,

This series contains misc enhancements to the mlx5 driver.

Find V1 here:
https://lore.kernel.org/all/1758531671-819655-1-git-send-email-tariqt@nvidia.com/

Regards,
Tariq

V2:
- Fix wrong goto in patch #1.
- Shorten NL_SET_ERR_MSG_FMT_MOD message in patches #3,7.
- Improve commit message in patch #7.

Carolina Jubran (4):
  net/mlx5: Improve QoS error messages with actual depth values
  net/mlx5e: Remove unused mdev param from RSS indir init
  net/mlx5e: Introduce mlx5e_rss_init_params
  net/mlx5e: Introduce mlx5e_rss_params for RSS configuration

Gal Pressman (1):
  net/mlx5e: Use extack in set rxfh callback

Jianbo Liu (1):
  net/mlx5e: Prevent entering switchdev mode with inconsistent netns

Vlad Dogaru (1):
  net/mlx5: HWS, Generalize complex matchers

 .../net/ethernet/mellanox/mlx5/core/en/rss.c  |   91 +-
 .../net/ethernet/mellanox/mlx5/core/en/rss.h  |   30 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   |   43 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |    2 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |   15 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |    6 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c |   15 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |   33 +
 .../mellanox/mlx5/core/steering/hws/bwc.c     |   37 +-
 .../mellanox/mlx5/core/steering/hws/bwc.h     |   21 +-
 .../mlx5/core/steering/hws/bwc_complex.c      | 1821 +++++++----------
 .../mlx5/core/steering/hws/bwc_complex.h      |   60 +-
 .../mellanox/mlx5/core/steering/hws/definer.c |   87 +-
 .../mellanox/mlx5/core/steering/hws/definer.h |    9 +-
 14 files changed, 995 insertions(+), 1275 deletions(-)


base-commit: e835faaed2f80ee8652f59a54703edceab04f0d9
-- 
2.31.1


