Return-Path: <linux-rdma+bounces-3271-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7367890D69C
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 17:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789051C240B7
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 15:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8FB1CD39;
	Tue, 18 Jun 2024 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cbKuWyX/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF5718C22;
	Tue, 18 Jun 2024 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723385; cv=fail; b=YZMDxhmKX3ISgzFbkKyC0szRyjzHHtkgKBRu7hikZQf2kInEbVi4QsKsNqXsAGLx4y7RA1EdXMwyKx0eMtzFZmUtUIDzUbSu6XEwysETxrffnx6Q83x5BTy/HsaRMzIHDmQehEpVSNjvrkGQFqe8HPlcfjpHxDGvGax3fNjyry4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723385; c=relaxed/simple;
	bh=7+f129sMNDnIF8MSL9imzrSpb57PmKmpdHC21SVaqwg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VpL1yB8gwNyO76yMcRzA2G2V485I7hdJJE3FoCp7A4onDjCc7r6V1wKxUFjVZzioQZPGniI6cSchHwvtlLjW3Js71kpozco0shTYnEeKShZERtI7HnYGsFO/kAag8dqKIfqaLZscHuxJdUzohTgLG+8Eqvj0+hKT6CXWtb3prI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cbKuWyX/; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYwrA1z84BysnUw5/thmIjLVYowK5x5OQ525d8QMIk/xnEvJ5VPhZX/Qwo7UsZIxjpxoFVgn4trq0cJscVeSpI1fFzST1rfqz5kBm5JeU39/r/6FLel0Phj/upKMtcsevJqkAWZIykxvi2gE2pxbmkhauipiwER+C5C0CeV4tf2+3IgVna81VGkL276o3U9CV4IHNHg/hbam6yPqggA74pH50sRzXscDCN8OlCdafYfkbdSPvD32YWqqWDePAIxSagBwx1Elek+AWNTwIQh9KoZzULc9qFP258q3Va1G+Hq9dCg58uxdROTyY2Vy0YFEFWeOPVciVCio7ALlrOhUdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gYCcoYIelFopz57Vt+1OcPDRBxM9n9EY+230bblJBM=;
 b=g3x9D9onpute1bX1b1RzkzEDKiHBZD07AbOjyc1lBR+9oyJhnRo2srxzw7ypBoGFnafgwIHPM6vUNHh8B4tbt/w7sBp1XV0GBymbq4ilF4Gpcq3rDOIXRZjTtp7e1/GaGPkp8EEb+FSRDtedKdcRyhZte/5hwenyIg0S23ouXegY+kGk7Ddp8PpD+4Q4ALsTtJcyGiFrY6Tid9jqH+n9vzsJ+0vhJGTd7Ls5W7Kym3/hjqDHyuQcCi7c1G4p8FYV2P41sRmz2mDGmtUEgeP8rH7JOPGTtGEGN8UljdmrvpmjvwScwjtgbOCN2E1me7WXqGN0IMRBgEhSkIaIXWmwxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gYCcoYIelFopz57Vt+1OcPDRBxM9n9EY+230bblJBM=;
 b=cbKuWyX//gzlA7oNDVXFa8az/0nDUi4Fb1BhorW0Yv6cHF2267pmosUYOatqf2xEJ38eqplxRpYj5hJt09uZw3AzmMgxja51lk1DJ6mEWrSxaO8M5eC3lURfrsexfSDsD3HbZYOXl+a9/jLzj8Y7OvpyyVlpk21FMdkAasariDkiXxPHlJn727uboNidzblYzWBaAThIhKQX6k6cpJVUvJ0hI6cFjA0RwB4LRsDuwcU41YhXzxkzeHCrKs4IOeeLAWwDooTE9WARLnU16zeYHZe7yjOO5Oor1JOO4elEYAKgT433r69kRu0qUbPuhxqNxWiKAGfNKUlkph9INHRbrw==
Received: from MN2PR18CA0024.namprd18.prod.outlook.com (2603:10b6:208:23c::29)
 by CH2PR12MB4150.namprd12.prod.outlook.com (2603:10b6:610:a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 15:09:39 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::30) by MN2PR18CA0024.outlook.office365.com
 (2603:10b6:208:23c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Tue, 18 Jun 2024 15:09:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 15:09:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 08:09:17 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 18 Jun 2024 08:09:13 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net-next v7 0/2] Introduce auxiliary bus IRQs sysfs
Date: Tue, 18 Jun 2024 18:09:00 +0300
Message-ID: <20240618150902.345881-1-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|CH2PR12MB4150:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e382ac0-3924-4d16-b81b-08dc8fa8acb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|36860700010|82310400023|7416011|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IBclnDhbIRL3YmJ9qZVdgPLCpBF8JGoP2ddsr9dPECchGAEenDqKp/jvIUwx?=
 =?us-ascii?Q?Ey0zBkRIImILNpZZP8CmeIvKj2kLgskl4s8Ct78n3vd2ZFkMa5ImGgYJVP3r?=
 =?us-ascii?Q?8hA71Uc10xUl1v9Y1nPYU0vG8Ti/5vTzti+xNv6Sunc2Dk4AwDIrw7130adK?=
 =?us-ascii?Q?OnZZYyDOjyEezk4dHYVeUbg85O/yZV3X6GQfdHv2FSBK/kh4JwrGrD6H7Td4?=
 =?us-ascii?Q?7vwJ0VXlxBQJk1hEWTwV15xSqtuxlwSIf0GK72+LdSzhxNGJj+kne8Qtn3yT?=
 =?us-ascii?Q?Gq45dGI1bK3GRtkanI9ga7W2qJ7ObV98bJGYJ0t+pv4s92vlllVYnSuAnPKJ?=
 =?us-ascii?Q?NIr2yxYHtZmu1gP+97BvujjFH6xH4rFAVJyLf4rOlejZjfrVqhnuX0J4KDmj?=
 =?us-ascii?Q?DdXlJ7o8ByaTwGnrjBi5Ewlw0SDhwa3q6c8mD+gl0cXJD7mtzehYiP4SakVU?=
 =?us-ascii?Q?nwQ74RTCcKJ4d7wWso1lW44qwm/OZsVPYjai6hSefLcqYkw4m3d2+KHgniWo?=
 =?us-ascii?Q?TXwMXLD/Y3CTDHtDeAOHSMJQm4P7raWhq0nP4z1VRqNLbgtIiZ15ZKbU2mPd?=
 =?us-ascii?Q?6h8nNI/M9DxYFt3oySxG8Hdh4Ivl874mLL15N4G0PwraXD8BPrJC3xwhd8wS?=
 =?us-ascii?Q?wEmC0PzL/85KAd2NSmx7W/jw8DwHBIOUPFphA8GtXVFyxtzd30mRQc1/CynK?=
 =?us-ascii?Q?pjE76UQXlwvvhfE8/r3wsHz4ryvbya7CNUj31q2GHHrjDtUmCHO/rMd9S2hl?=
 =?us-ascii?Q?GBSkKAwLFARg2kwRuNDXE+HEiARy9S8vUlkWphBmyL1+oBJ2jWiC0KHHnXea?=
 =?us-ascii?Q?QnbSliKb5yzzqR7P381KvgdClfgoKsnd5Xh3iPJoA40Udhth1h+srwZxbVvM?=
 =?us-ascii?Q?Bllb5zclt2us5k35Pc0bWIVQm00BG1NlvqIfgLeeUooYXHR1dnABzl4ZmE2s?=
 =?us-ascii?Q?9MVQSXzlBLt1chfcRBkTdE/MZqO9soAS1J8six+QNlaQyzyOGUaf/tGveQIi?=
 =?us-ascii?Q?vXGQRwM/c7ZeNapAXvyCjoR6kJtqbksHGlUmzKrww5IN+scsi2794Gw47Fcl?=
 =?us-ascii?Q?OsEiXP56andZid9jxrLg1jD7BxvK6rAhYpY8Lw6mKnN1V1F8iMASqwBRj3GC?=
 =?us-ascii?Q?8fy7qz4J78isI6fS4VoDTB4soL2LCBuOVc0HA3AI5ToplKw7qhs6uUzKG/7A?=
 =?us-ascii?Q?5o21RFeViLYSROT21wEFcLga287PnaKwl1wRUTFBpN8stlU/7KRxsAILWd4Z?=
 =?us-ascii?Q?VUyf1nDGtAhs4cPkvt8Z5CJujiQ3PcNj5mXRXpwYxB+PweCFokb7kTcgl52x?=
 =?us-ascii?Q?94CrLYVtQ17r7MJ8/Uigi8gtOIlr5yMhE1+kGNk68K280d/ddDU/2doMeHlc?=
 =?us-ascii?Q?Xa1ozx/OEbBIpYuCsrc80YNzc4gRt484VaaTbeNSgHOve6brcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(1800799021)(36860700010)(82310400023)(7416011)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 15:09:39.2735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e382ac0-3924-4d16-b81b-08dc8fa8acb7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4150

Today, PCI PFs and VFs, which are anchored on the PCI bus, display their
IRQ information in the <pci_device>/msi_irqs/<irq_num> sysfs files.  PCI
subfunctions (SFs) are similar to PFs and VFs and these SFs are anchored
on the auxiliary bus. However, these PCI SFs lack such IRQ information
on the auxiliary bus, leaving users without visibility into which IRQs
are used by the SFs. This absence makes it impossible to debug
situations and to understand the source of interrupts/SFs for
performance tuning and debug.

Additionally, the SFs are multifunctional devices supporting RDMA,
network devices, clocks, and more, similar to their peer PCI PFs and
VFs. Therefore, it is desirable to have SFs' IRQ information available
at the bus/device level.

To overcome the above limitations, this short series extends the
auxiliary bus to display IRQ information in sysfs, similar to that of
PFs and VFs.

It adds an 'irqs' directory under the auxiliary device and includes an
<irq_num> sysfs file within it.

For example:
$ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
50  51  52  53  54  55  56  57  58

Patch summary:
==============
patch-1 adds auxiliary bus to support irqs used by auxiliary device
patch-2 mlx5 driver using exposing irqs for PCI SF devices via auxiliary
        bus

---
v6->v7:
- dynamically creating irqs directory when first irq file created, patch #1 (Greg).
- removed irqs flag and simplified the dev_add() API, patch #1 (Greg).
- move sysfs related new code to a new auxiliary_sysfs.c file, patch #1 (Greg).
v5->v6:
- fix error flow in patch #2 (Przemek and Parav).
- remove concept of shared and exclusive and hence global xarray in patch #1 (Greg).
v4->v5:
- addressed comments from Greg in patch #1.
v3->4:
- addressed comments from Przemek in patch #1.
v2->v3:
- addressed comments from Parav and Przemek in patch #1.
- fixed a bug in patch #2.
v1->v2:
- addressed comments from Greg, Simon H and kernel test boot in patch #1.

Shay Drory (2):
  driver core: auxiliary bus: show auxiliary device IRQs
  net/mlx5: Expose SFs IRQs

 Documentation/ABI/testing/sysfs-bus-auxiliary |   7 ++
 drivers/base/Makefile                         |   1 +
 drivers/base/auxiliary.c                      |   1 +
 drivers/base/auxiliary_sysfs.c                | 110 ++++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  |   6 +-
 .../mellanox/mlx5/core/irq_affinity.c         |  18 ++-
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |   6 +
 .../ethernet/mellanox/mlx5/core/mlx5_irq.h    |  12 +-
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c |  12 +-
 include/linux/auxiliary_bus.h                 |  20 ++++
 10 files changed, 182 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary
 create mode 100644 drivers/base/auxiliary_sysfs.c

-- 
2.38.1


