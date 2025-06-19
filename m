Return-Path: <linux-rdma+bounces-11455-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8FEAE0469
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 13:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530C5176F95
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 11:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354AE22DFB8;
	Thu, 19 Jun 2025 11:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FZyqANI6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAE4202F8F;
	Thu, 19 Jun 2025 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750334141; cv=fail; b=IxPVXP1O5efKOwF2kKvse9LJuwovy1fZBnpXMo71XpzSM8muBpFoOy1qy33na0ulCL0XCbhZarqmnpttrIhDqHYZD3dURYXsPgB3jnuJ+owGcgNAvkXtF0mkFY6SjxDZMLauW3Dn1V4bpsOQFBN1n0TqyMG/Eox32xFrrZS6agM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750334141; c=relaxed/simple;
	bh=lncKhI7fIwL9LkctMy/QNoqb9ZhhURK8SYHhLNMCksU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NZC51uA5WRS8tE8MEAKOwZJGhe4Aw6w8642GJnJIy2z8GfVKOAhADfjnItLtlMW1bpXRn2neOYpxI6bUNWwQHcnZlrln+PXEruh3YrZ2vaeBa0gpSeoixnyZ0Ub890V82wSM8nnlI+uO63wurA3szyMEXLqdgACngHSqRmdoyak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FZyqANI6; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4/PAZu4rP9m5EFbc1G7a2g1NFFWznoHORHMJlEwqV9xzasGNOCeUR6tJqozeCo90bGRyKGw3Y/vz8mLANpHGGFA1ou95LAB3fqF8uTc+Lyn2sxwsDc6NvpMFogAFYaN4nTlvOy9cmaOPS0hhvpeW+TTCkw9jBDTm0N1HoQgdAbb4cAwVejlyjzOLaC6wa1TvK0nszXhHiB/hOpUkZrokvtJ1EAeKJjNqC03rkJSqlZdV0GR/DiPvGBXajCQr0RzR34JjvXICJjjgYMgD+IV+RX9SsV99UFxe8xcg56bAZh8YMTQSychrZd1z7xO+LsRpX0QVB8SsKD2uujV+l3l2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaldWr08VqCtskwtb+FDfTa64nzWVqk5DSFIcrQ2YNM=;
 b=EoIM5ZiD7+570vbk9uwWUqiCS5cAjHM7W9Pt5z+1wk2ARZlKpXltd3Cr8ltDSAomtiFArstDnfKLqEF8y8DCPnWb3hiZCNyZjvAItmU8T9DBl1c3VeEWu897jMBow87/MGhBK+XXFghtrF+NOGl+iijO3NUhHi6bk6ZJMNBQHMpCkkcCm5X59dpK/3xIb2x1CHS1nEoNQc5/Sn5KHXuogFZulR9IvLrE3HbBD/fpxFAIStvNM2S1q4jtoLjlkZsJibHZKWjNqMN3RfUxtl2VrSCaobAfCPwYgWA+iEzeZGL2CyigSmaR3dHSlvrxICx8oY+RYJMtqDXzaiXVhs9Z/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaldWr08VqCtskwtb+FDfTa64nzWVqk5DSFIcrQ2YNM=;
 b=FZyqANI6fcC5mwCfZBt89f0JOwf0mpfuv+UosiRI/CxdAqMtZlSteJW5zAO+JAGEFeA4PEnD2rxSPxRH5vMZ+GB+Xy5k1KCIVn3zKNoPtOMTgdFJbCvIB4PLFEN0xk5nWVHPYlBkqhQHROm5qiiW65Y239P2hxtFXwic6VqYca4AMXsfKpN97DgBm/g2/+O8df6aCWr1S3+0aJYfbsKXt1tI4+iw61QUIkUZbhh3DnBdPF6As50bxZzYzn5mDyUkLRnSRge/Tny/bWvN/usI0giatRjlu+WVp7xikW+RRBAUKLOY+h1axMNgRb3Npok8pOMNj8cE33JGHGDonhMA4g==
Received: from DS7PR06CA0009.namprd06.prod.outlook.com (2603:10b6:8:2a::28) by
 DM4PR12MB6544.namprd12.prod.outlook.com (2603:10b6:8:8d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21; Thu, 19 Jun 2025 11:55:35 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::52) by DS7PR06CA0009.outlook.office365.com
 (2603:10b6:8:2a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.25 via Frontend Transport; Thu,
 19 Jun 2025 11:55:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 11:55:34 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Jun
 2025 04:55:27 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 19 Jun 2025 04:55:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 19 Jun 2025 04:55:23 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next 0/8] net/mlx5: HWS, Optimize matchers ICM usage
Date: Thu, 19 Jun 2025 14:55:14 +0300
Message-ID: <20250619115522.68469-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|DM4PR12MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca28b8b-6866-4f54-f37e-08ddaf2832f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p0y3kORaGRvAph/bP1UNzNKbJQ6idljCGryu5qNjEUsgb4rjknPhu8nKjS+K?=
 =?us-ascii?Q?JzhHCpuzTrO1H9YWI+UXGD6Maui8vq4NxbDXrS8OBAqooT0SxhjOKiDiQqoB?=
 =?us-ascii?Q?09XRr3y2s5/93u2QHl05Ff7cXZgv8fuaN34U+rCfTMRQY4LdNlF1pbmT0rmt?=
 =?us-ascii?Q?IGmrGEM1uutRFwdiz//YzEHVFnVyD4AwWMzXkiyjXyJHJ8aYq0gWWJ0NwuIN?=
 =?us-ascii?Q?O63R7czmCx/VuFWAxeIe+zHTMhgiPnWxdx//IXx/AlCzhj55Om7oczrqlkJZ?=
 =?us-ascii?Q?U/FqFxqMym38rkOxxKfB3G5hjPqoFZWSZD86xvVdETq38uBz9TjeRk/Oxf4C?=
 =?us-ascii?Q?hv+rmD9HcBbp1sfoEX/1b4m6pYFAgNgLQIb4J+veYUqxnlqfbvw+3juITBlS?=
 =?us-ascii?Q?kLeZsYoChHITvqYWo4MrmCbpryhElv9DFYIp0zqiZ3UiAaCgDzW5bj2u1TJD?=
 =?us-ascii?Q?zDmyVEZnTejn3twf8DZYRZoe8f3eeJSyuUlz6oP4HqrUZTvijX6RuSnD6bHp?=
 =?us-ascii?Q?yBx4sbWOfliApozFaJZMszBzy2oMsc7XOv9z1ARz8whBJhldpHQ3od+vOqx1?=
 =?us-ascii?Q?SHz4U5+MBHTb864b4dT7t2RiXLGJ5RbCaQAeVwoMOUN5Ah+1epvToRQsjb+M?=
 =?us-ascii?Q?WyOqXbqh7D1pLyzWDzj4wrQJ1mCDdAJSwL2Ca3eRdCau32FhmZITdJe5w1+/?=
 =?us-ascii?Q?v21vb5tx6YJgbrL8Mab062DyNGVA9MPDoEGq+y0ptReJDb6k9332A/90ZTUc?=
 =?us-ascii?Q?aFAsMIB44Ha5+Qo0X5XFkhlAfv44YLC3D7OgAueyXvp841+/Ovcd59mzwU+h?=
 =?us-ascii?Q?1pKTcVehngKmsyo5mPKvWJGIa1KW+8u9q4XXRAJ4uxTLytRvGRB/ZzYM/tur?=
 =?us-ascii?Q?XO7c/AJ7Wldyn65MV2tRfzP4JhYbZlErFqZEMZlMlQwEwlt0tsJggIxuWh1R?=
 =?us-ascii?Q?nBgGSubapgr4QYa6OxuRRTNHgyoiokSV9uK5jAmb5YY8p594YS8dxWgLoSpD?=
 =?us-ascii?Q?3VSL6OHjy+PBp3Wdhtp1I1fHyx7/JAKMTCLGhu/cfBG8PP+pgc0GjAiPnEC5?=
 =?us-ascii?Q?TpA3ZFEx2ikvhAgX2faG2BGqv/UOIXojN3Gzi6wg50cbU6gz1bYW1lIhAVbS?=
 =?us-ascii?Q?wnAwj21XhiAHvy3eHNx20cHUcbyijx4Fg/tAh7SyALgtTyV7QJwS5/hqbcBY?=
 =?us-ascii?Q?7UQaxZ0ifeff40h2Yae/B0NuWfkfZb50fnwlItxXvzHHscmClSzFZOyh6MK0?=
 =?us-ascii?Q?W1tXxLwZ0gPu0I9D2WmtE0ZQDMy3WY4oJrBjEZyPKJndO/FpIXxUvn2wP8r7?=
 =?us-ascii?Q?TNWnnVxdQD6bfwzhz91bN52unjtzF3EmuWpEBFD2zqhNO+Vj+BYQ8l0rh/4k?=
 =?us-ascii?Q?MbLnrsSu6bTM7q534K5Pt5CPmAirUfyA/A8xFz+yZKydxuSXb0gbNfN08gUU?=
 =?us-ascii?Q?ZoKUP4AZ8qJwy4a7I2ICQ6/Hy/2eqkbEsbZCDdRh8cGKHHoEIGnzlwTNJrCx?=
 =?us-ascii?Q?CgfoEwhguH7Dmj8NPGOhNiob8bwFO1Z7JiEF?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 11:55:34.4003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca28b8b-6866-4f54-f37e-08ddaf2832f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6544

This series optimizes ICM usage for unidirectional rules and
empty matchers and with the last patch we make hardware steering
the default FDB steering provider for NICs that don't support software
steering.

Hardware steering (HWS) uses a type of rule table container (RTC) that
is unidirectional, so matchers consist of two RTCs to accommodate
bidirectional rules.

This small series enables resizing the two RTCs independently by
tracking the number of rules separately. For extreme cases where all
rules are unidirectional, this results in saving close to half the
memory footprint.

Results for inserting 1M unidirectional rules using a simple module:

			Pages		Memory
Before this patch:	300k		1.5GiB
After this patch:	160k		900MiB

The 'Pages' column measures the number of 4KiB pages the device requests
for itself (the ICM).

The 'Memory' column is the difference between peak usage and baseline
usage (before starting the test) as reported by `free -h`.

In addition, second to last patch of the series handles a case where all
the matcher's rules were deleted: the large RTCs of the matcher are no
longer required, and we can save some more ICM by shrinking the matcher
to its initial size.

Finally the last patch makes hardware steering the default mode
when in swichdev for NICs that don't have software steering support.

Moshe Shemesh (1):
  net/mlx5: Add HWS as secondary steering mode

Vlad Dogaru (3):
  net/mlx5: HWS, remove unused create_dest_array parameter
  net/mlx5: HWS, Refactor and export rule skip logic
  net/mlx5: HWS, Create STEs directly from matcher

Yevgeny Kliteynik (4):
  net/mlx5: HWS, remove incorrect comment
  net/mlx5: HWS, Decouple matcher RX and TX sizes
  net/mlx5: HWS, Track matcher sizes individually
  net/mlx5: HWS, Shrink empty matchers

 .../net/ethernet/mellanox/mlx5/core/fs_core.c |   2 +
 .../mellanox/mlx5/core/steering/hws/action.c  |   7 +-
 .../mellanox/mlx5/core/steering/hws/bwc.c     | 284 ++++++++++++++----
 .../mellanox/mlx5/core/steering/hws/bwc.h     |  14 +-
 .../mellanox/mlx5/core/steering/hws/debug.c   |  20 +-
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  |  15 +-
 .../mellanox/mlx5/core/steering/hws/matcher.c | 166 ++++++----
 .../mellanox/mlx5/core/steering/hws/matcher.h |   3 +-
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h |  36 ++-
 .../mellanox/mlx5/core/steering/hws/rule.c    |  35 +--
 .../mellanox/mlx5/core/steering/hws/rule.h    |   3 +
 11 files changed, 403 insertions(+), 182 deletions(-)


base-commit: d3623dd5bd4e1fc9acfc08dd0064658bbbf1e8de
-- 
2.34.1


