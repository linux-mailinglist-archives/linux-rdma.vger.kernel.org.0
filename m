Return-Path: <linux-rdma+bounces-13140-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB414B47C38
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Sep 2025 18:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667B6177D24
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Sep 2025 16:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921532836A0;
	Sun,  7 Sep 2025 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G5KDyQs9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9011A285041;
	Sun,  7 Sep 2025 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757261426; cv=fail; b=N5FcNpTYRVFHROlbQsMMWFh3QWhxYSzmV8U0PBPgVHHCVR5snT6HBa597TGtg89wt5eP0gzFS1/wkfMouJfuvyHlKAjBv+pJ8bdIYMAESXKEfr8iIYKiW4mbHBA86Vzls6a4NQ9Kh8g/YInhx25jJUk/0lUMvYOPXtrZbCMeSHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757261426; c=relaxed/simple;
	bh=OsM1IvLb7Tjl3y9Kw5quZqmGSjslvt1pXYbX+a0Khdg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PqAnFGEl8CIQW6OwXPP3twSNL0dCgiTORQ+KnGDnr12kqVeZH53QHNHGhkaLYYZY8HbEJwcO6Jeig+K3oUNtWgd5O8K/qKzeRyYY+gdbVGdFSDNrwp+ZbPrBCuQABB8E3fK7I0WFohU3zWskoR0F5eiDoX+eAnmB2s3F60AjwL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G5KDyQs9; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObYQQYOsZDUEGIHPM9WEeO46eS/qAE+G3t8UyIKGCYTXH+QIZn0/q8TWj+N2tY2wNCIuthBK6lbMV3vKwqzxqkB4RU0v4LTS2mEr0IzP/hFtKus0CFCMcxu2/hgmqDqEBmbbolC0gWbDtlb+OmhBvpRIc/6OnP9lT3asAtomybhpkk4nMDgUkOh1GiNNc7xSdi7ECkqOncabHWD0slym17VNh9u8m43OpAEWJDVGjzqxrvZAuqjD7yfihgI9Xoq/odNH0vqvEukCWkUnfTNyb5i4QP8lTtY0Bo2+wlOHBkHSJogqQBTwV9BKYRzY9DibVNFUpuW+IbfTnqPh958jsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/UuhiwaZOzoDQJMivL1a7qyjkl8MdUJk+33hK0cuhs=;
 b=gZww1xKZBzCKsgBNxsCtwIIWNOLqT+x2VfcJjD/I3OyZnZ0+rw94o0UUytyj3zQz0Vr46dpzEahI5u/MnybgOR2fsCFBkvl1ABgIL/usrnmypmJSDmlV2jyb/fBF14B7dNRb7T76A7n/yPBHjJnAh+yICJzfErEUedHwSLtsj+MPMsJID1FcXE/fDrQLITOrnIVFgbJnf237ZIOWaufK6Cs339Dzyd4NNW4Wp9fKJUoTtipoonIwvylUlj2EEmJm0MvaWm2CaRMlvJbHzyOjKKbVvu7tY2YltgX2jySZLXQQeVPuH0MRnwNL5W1m3BesPVzIAidARiw0LReOc1NjfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/UuhiwaZOzoDQJMivL1a7qyjkl8MdUJk+33hK0cuhs=;
 b=G5KDyQs96c3OUM4OE/7J+Yo6bXHqnGJbx4lxf5foqN0PSaYvD4OfjCgAPW69Piua9JjTSpfI3Js4q2hL+JksitDRUPhMle4+kmWQ2vddetmXeOgA/mXIGUJmpqL23gIoERG6g27dYdWOILs/lU54MYSXT2X2pTl4wR01kfIdUzEfD1djFXkfmOGUxT6WSgNPWvPPvbXbs5BYgch+3P1FCJoC+kRXPXFmPhQO1jniRZAOBUwxo86GACsY/Cxd1AGk3nC2ULNw7hw6MLu5s4JLpTbyxmUL8tj4pogDU8EXgnljlBlNftDFFc/6NePZcyS9aEUwdz3h7aJ5hrY0HsRd7Q==
Received: from MW4PR04CA0247.namprd04.prod.outlook.com (2603:10b6:303:88::12)
 by MN0PR12MB5956.namprd12.prod.outlook.com (2603:10b6:208:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Sun, 7 Sep
 2025 16:10:20 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:303:88:cafe::8c) by MW4PR04CA0247.outlook.office365.com
 (2603:10b6:303:88::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Sun,
 7 Sep 2025 16:10:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Sun, 7 Sep 2025 16:10:20 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 7 Sep
 2025 09:10:04 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 7 Sep
 2025 09:10:03 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 7 Sep
 2025 09:10:00 -0700
From: Edward Srouji <edwards@nvidia.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parav@nvidia.com>, <cratiu@nvidia.com>, <vdumitrescu@nvidia.com>,
	<edwards@nvidia.com>, <kuba@kernel.org>, <tariqt@nvidia.com>,
	<mbloch@nvidia.com>, <gal@nvidia.com>
Subject: [PATCH 0/4] Fix local destination address resolution with VRF
Date: Sun, 7 Sep 2025 19:08:29 +0300
Message-ID: <20250907160833.56589-1-edwards@nvidia.com>
X-Mailer: git-send-email 2.21.0
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|MN0PR12MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ae6ff0-af28-4373-1234-08ddee290b02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YS1Dnr97ybz72mpCvEQ5pSCRvPSiHf1ji/NxJMe88cCG1hMnD9JnnwvseS8r?=
 =?us-ascii?Q?TsZVG7nSogCE6d4P9DGUuId3XIjHmyYVpXyawYptp7G+PPqbkaiwyevigfAs?=
 =?us-ascii?Q?Lmq2KHvaF6cFIyVJ1xrVlgVrrmoAcgFMSiLHLsihBMOqe5V4BxBq3whNjWIM?=
 =?us-ascii?Q?r53heMxWYtkDYFYBuwkXIfJmxiZV3Q8MUKe4gwTjyf84tCyzZcDx9PB/EiML?=
 =?us-ascii?Q?8jSp1OocZIeHi8C9cSuxeLhYZq6hoPwIv+XRWJt7Sip6//Pv2qZSPaoi8hhI?=
 =?us-ascii?Q?VWnUadVQPMh0q9IFhNFTtvguYn19z4fYfWUmmL/e3KXZI9X3a0sdAUsAjYAy?=
 =?us-ascii?Q?HYCCJoZRLhrKShEXINlw68927h027cLGQlLuV3SUJmgwS6pbI/uIXmedQnrn?=
 =?us-ascii?Q?+Pom8gM1aYO+iW6ykTWFDQuAwyZNgffg9IkF3ZTm3RX91PJyPp1Pq6CdVvN3?=
 =?us-ascii?Q?CH0b8g25qDZqG9TlD8mTRYU/16R+OldxTsX6YVajCgtgBVYYKTDC5lTDEY8e?=
 =?us-ascii?Q?dbBgbJSkhcAqy3Ekzp/lc41N7x+tP3Rdw1TmCosq8EYDfa5m/KQ+tPBp5wzz?=
 =?us-ascii?Q?TWDoYZFWFA7B+jpjOlYp+PGXQfygeYxwNrsl5x8sue3Uq1SU1ZemNii3jVQc?=
 =?us-ascii?Q?VrZwqy1xoMIbtwn+E7T64gtdDlSp+9ORFv1F5FS/oeWSmjnnOd4i5cTvo7T4?=
 =?us-ascii?Q?1HxdiUSA0tp0jCcit7GzEUpnt0W2G+asj6BQ2gA9B2BLeGYSFCSVx17jOsxf?=
 =?us-ascii?Q?jCpo4UYorXrVbcMFwahqoDP4A3wNJaLjGWFddDLjle5sSDRwDvxRV/mKayhT?=
 =?us-ascii?Q?ZoHLht0DYjbscW5fjP1OW2YVDKSXcAJiFU29zf86rWw1rdm12LxiBFl1wFUt?=
 =?us-ascii?Q?Q4813HxNp1wsqB1s1iAbuZKrqCr3vSN+APvFlaRW+SnkkIW4I5t23O70LLv/?=
 =?us-ascii?Q?GTv8cYNeenS+RAUH0ysai80E8JMr32kXoe9X+vnjanOpSn1I5L5QowltU6uH?=
 =?us-ascii?Q?FIKF/XtDq4eotRfEHRs3kiE6rEMzJZrXqvqC6ZRJWur5EzVaOVsiP0uq06NF?=
 =?us-ascii?Q?rqBa5NDwSm31IaYMJpCLzrhaoy8Ie9I3U7ogcJOpoX9yYgujOpsWG6DY0JvG?=
 =?us-ascii?Q?Z10BwqwC+qcJzs4/t6V9jrkYd5i0k9whG77WgDbQPgMXrmTVlCRaGml+qgwn?=
 =?us-ascii?Q?ppClrDweWVX0zSX9uZbbTwWZwwuFF3WH6gDkq0A/Yi0XLZuCDdVZJu5oyuzw?=
 =?us-ascii?Q?ch1Uy2nE2SoaNyj9VVftthTds+4RsaCxp0ipnTulvSJfGKnCtjQkyX/9qETd?=
 =?us-ascii?Q?pV335EpDLlwkSC4MWQciSUNiSupzKuREWZXZtBqZAJBNJU3xm2x9PSqrw4NM?=
 =?us-ascii?Q?gujWYZn5kagGTeNT7Ms132p1sJRugoQafEy7At5riPdqbRcs8J7ZfrVIIzov?=
 =?us-ascii?Q?JjLlaG/Smc1G39NIQY/L9xlyKa1CjuMwz4nz89QecmxH3mMeGFj7KS9zsxKr?=
 =?us-ascii?Q?HE11rX4gKsdiBLpYkOVN2KGtXna0uRBXihwP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2025 16:10:20.0549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ae6ff0-af28-4373-1234-08ddee290b02
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956

From Parav:

Presently, address resolve routines consider a destination to be local
if the next-hop device of the resolved route for the destination is the
loopback netdevice. While this works for simple configurations, it fails
when the source and destination IP addresses belong to an enslaved
netdevice of a VRF.
In that case the next-hop device is the VRF itself, so packets are
generated with an incorrect destination MAC on the VRF netdevice and
ib_write_bw times out.

This patch series fixes that by determining whether a destination is
local based on the resolved route's type rather than on the next-hop
netdevice's loopback flag.
That approach resolves loopback traffic consistently both with and
without VRF configurations.

This series contains 4 patches:
  1/4: refactor address resolution code for reuse by subsequent patches
  2/4: resolve destination MAC via IP stack
  3/4: use route table entry instead of netdev loopback flag
  4/4: fix netdev lookup for IPoIB interfaces

Parav.

Parav Pandit (3):
  RDMA/core: Squash a single user static function
  RDMA/core: Resolve MAC of next-hop device without ARP support
  RDMA/core: Use route entry flag to decide on loopback traffic

Vlad Dumitrescu (1):
  IB/ipoib: Ignore L3 master device

 drivers/infiniband/core/addr.c            | 83 +++++++++++------------
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 21 +++---
 2 files changed, 50 insertions(+), 54 deletions(-)

-- 
2.21.3


