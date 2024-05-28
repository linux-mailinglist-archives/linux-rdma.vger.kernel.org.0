Return-Path: <linux-rdma+bounces-2623-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F698D16FB
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 11:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E991C22BAC
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 09:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F2313DDA1;
	Tue, 28 May 2024 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uQDOp9tw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E3313D88B;
	Tue, 28 May 2024 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887607; cv=fail; b=p9uEnIGOb3JWQ8zWDYn9xXaqsC6lxG3y1xop5EHkd5OHE0cq/aOrX+qaEBq7loE3ymtpp1TEO7VmVQ8s+DDtePv8gbDMUAzmdHkqcoRmfJ3LdVYhSU0qGREtvH8UUkizOHunErcNjzAoowG1vadqITXWX2hyYVzdqp+GAtYP7Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887607; c=relaxed/simple;
	bh=oQ46hgEfRBMd8IZIWsgxpWkegP1RQg7pO7OILacGyUU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rn8TBTTzdH2pUnvoCRU8F3KcpNhDgN0HTjhIYOZDY3cFLBL7/fovdrkZyOEfWGbsqXqZfoEOmvf5SdHKv52gApmRgp1Tqt79YoF/QdJScQzHtw0ygwkbH0PhCSICPkJPcKYBuBRTX5jUuMOstYc2TpDplHNtYv2zTbtUFJbCXbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uQDOp9tw; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRqJflc/W3Yp59ycRmFTJsLYCSNWQxcgzJQBmlPfPNYMDFVPVbq354nA9dWUOcYzc0eIAf574PUjPXGrzNZd7+d7lCnJRUgHUboM4r/G6jKW3zUgWpXc1C0N+HfkY+F89YhNze9DOKOqjqp5BEsbFnpWFDVBWNmyX3cQ359JGI/c4hUue9A6CgOfuBocfukEptAYnYJU5o/FtzHJQArllOqHM31YcTUKTDRyIQbIpvkQYTNg9N++aguH3+5IjFow7kGgkIsxY18N5d+ub31oseLOd9RtekLm5aCQhSMLeBZgoPXEw7oe5gsK9vSRiO6cCzAb/7I+xUukTg6LpiP7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9mJGMWYQBPxK3wF0CvFI8CP2pxPyt0suZzj1Slh+1k=;
 b=iYGv32zWKKSjiVsDKfs0Sgqr7jG/67p9X0zsIS2it18MdJyRnXajoTDlS8dVgjDovz2olvHT0gmLFXXRAqaVmY9iIgjnz7pZGh+fW04pnHPUFjvb3bs7jatLtnMJuyBWCq/wSNWw/SkGrFbPqvngZosqmRTPEIeZN0N6x6PMKNi96H1jMvZHqh1/Sf5aIp08+pNmMug1/JfbPSHQoSI2nwcRJZYU993Fp/YR8QKcJMw6q/K7JCa4OVKgAwikCznHR7pwy0wenDrZffag6fCe/qGdo20OIKY8A4HzLYqt+mIGJn67qQGa71Y4a1uCWUVct4BVWXdhAQN/KQzrT6bgTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9mJGMWYQBPxK3wF0CvFI8CP2pxPyt0suZzj1Slh+1k=;
 b=uQDOp9twSQifpVDFWGbo8vGcYBjnJ9DR0HxK1acoWYAKRo2WxK2fXDWGc4wOZ/FzMyZP3zO3dZoXX7lsMKGIGWIgNjDVie8eQ29jh/z6uPXxxltWDYULtjJPgHoMvJIVT2+ZqGXHgNjlsqx5OKdvP2rD8R9wMiVMGWOcpNOondRG+IY/ICW8yflJkYAqL5bFSoz7X3lPaBnMwy/DJsj53f3b9PpdIRPAeVMwEFBJnE+w444TRbgm2/rGgrPWGiPW1OU+WqA7tZu1zIIT9/5Sa6Ve7HBR6NWKMescBw7jJL6AnYBq69Q4LCbGUh+BvN0BNWQO34SkIy0pFpAxtqs8JA==
Received: from CH2PR11CA0030.namprd11.prod.outlook.com (2603:10b6:610:54::40)
 by MN6PR12MB8492.namprd12.prod.outlook.com (2603:10b6:208:472::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 09:13:23 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::dd) by CH2PR11CA0030.outlook.office365.com
 (2603:10b6:610:54::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 09:13:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 09:13:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 02:13:10 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 28 May 2024 02:13:06 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net-next v5 0/2] Introduce auxiliary bus IRQs sysfs
Date: Tue, 28 May 2024 12:11:42 +0300
Message-ID: <20240528091144.112829-1-shayd@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|MN6PR12MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f085d2c-43e0-4ad4-d31f-08dc7ef66c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TuU3C1/F4z6sSd3BbA/fGJu7fks47IviTPgFjVJzW/H29wSpgp7ij26QBE3X?=
 =?us-ascii?Q?wkukm6V26bu2bKH/4DtzzOtWXD0B3/3rpWJJj1zxRNfPiMUYv8YUkxK5LRTZ?=
 =?us-ascii?Q?3BujkVTmG7Sdn6vI4mgsyx+e7RPp5ltMgrub13lyFpWw71RUZpNSe5Oc5ksx?=
 =?us-ascii?Q?mstoEo8HCBghEnJVBpUFKdoBkZghWAs/SElVRDbUMeQsjNvR6LFArwzGRnrz?=
 =?us-ascii?Q?mQYBbDYX1vmwAIFfrQySvwC7PBrVjtPIE013+Y2k22GF8DYH4JQ1He1uSKuv?=
 =?us-ascii?Q?vY2IpZkvRdyAR7f1afDmFhtE9S7u5n2FO8aGPB6iN1/i8/DSTvhAtcvzM+7C?=
 =?us-ascii?Q?TLQfVJreHk+YG6j8ZKlRXKRpZksU+dOZvdpT6cjG23SYbtkOWm27cStwnwjG?=
 =?us-ascii?Q?p9oH0mlxD1vERvp+0uuwq/7TlPE8gcL4LTZr+GI3Wf8zsZrGUdT/ttCZ94VY?=
 =?us-ascii?Q?9Bzw2EsTRr2yNItxt9V6xnE8Xb3ERni+eBtWmfqi0WEB+S4h7jFIrmOGYgn6?=
 =?us-ascii?Q?UM4uBxzVU4jvxbHyPafknxF0YRUU+b2Dv6NTrZwAmNaagSoob2CsXAvc6REL?=
 =?us-ascii?Q?mUa+jo2qEFH/E985BxjXEckKKuSjGS0kNgTnFURm9fH/UYK1rX1+ys1ZwViw?=
 =?us-ascii?Q?ikBKFau3tFcx4wP14K81shCKaaMNYiO7XUJXbNksVVTGz1bxBwYJnAOKA8oN?=
 =?us-ascii?Q?2t/BlpCGAARE3LWg223NLqPX19d2waF3L5z51neAq5PLLEPWa0X1ra7rgkcI?=
 =?us-ascii?Q?WHR6dVvNHkUARV3EoEuSNKg8dGk/PKAqYLjtiXVCpycgf8V7v9F3/Jb/N1zM?=
 =?us-ascii?Q?WNBGWhu8D0Oef2abNUCMrZcWp1/hteZDz9Wi6ppL4VkvtVcXefKN4vVonEIm?=
 =?us-ascii?Q?oswtyNVdpIezSUg2YDEsoZJVgBOOexCcK7I7k2uZLKDnClZCBUqYTujtyZ9t?=
 =?us-ascii?Q?YFZGWPZd+cEjzJ8IJpI0gxWzr6QxT+D2sfI9nvprDgKthFGjBAbV+hneoa5g?=
 =?us-ascii?Q?A7Is2/A9dMAyddIlLgnJcoQ/Nd3/qgjo8AOLQ7l99qsyCd/iicC3yfzYbjbH?=
 =?us-ascii?Q?HHNAy45n6brGEz+w9LsOlmpa3H44Is6Erxq6xiMLvMwNHINDjxV6dSBcf8Lt?=
 =?us-ascii?Q?U4+aIPjCah2R2XdXcoP2uYgcaxjAxwHGYjHKLlQaRmeOo4KT2OVfdqztmyYM?=
 =?us-ascii?Q?y96GlcxctVkNFrIzsrU5s6g655803VFS12mZQJMD5YNCXR8OT0YEPNWgiM4z?=
 =?us-ascii?Q?3OkykrUyMiqaVRzMPQ5mBpwNYsg5e4gbjd/0P7Db0vfztEH00QAaJ/8fqcvv?=
 =?us-ascii?Q?pkSizD9tCxSkh5sSzfKaM2EHznx62cHwhHuRArACD1ElyXVW3jW5/ZIkS5Kt?=
 =?us-ascii?Q?c8LZqBg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 09:13:22.7320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f085d2c-43e0-4ad4-d31f-08dc7ef66c9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8492

Today, PCI PFs and VFs, which are anchored on the PCI bus, display their
IRQ information in the <pci_device>/msi_irqs/<irq_num> sysfs files. PCI
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
<irq_num> sysfs file within it. Sometimes, the PCI SF auxiliary devices
share the IRQ with other SFs, a detail that is also not available to the
users. Consequently, this <irq_num> file indicates whether the IRQ is
'exclusive' or 'shared'.  This 'irqs' directory extenstion is optional,
i.e. only for PCI SFs the sysfs irq information is optionally exposed.

For example:
$ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
50  51  52  53  54  55  56  57  58
$ cat /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/52
exclusive

Patch summary:
==============
patch-1 adds auxiliary bus to support irqs used by auxiliary device
patch-2 mlx5 driver using exposing irqs for PCI SF devices via auxiliary
        bus

---
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

 Documentation/ABI/testing/sysfs-bus-auxiliary |  14 ++
 drivers/base/auxiliary.c                      | 165 +++++++++++++++++-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  |   6 +-
 .../mellanox/mlx5/core/irq_affinity.c         |  15 +-
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |   6 +
 .../ethernet/mellanox/mlx5/core/mlx5_irq.h    |  12 +-
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c |  12 +-
 .../ethernet/mellanox/mlx5/core/sf/dev/dev.c  |  16 +-
 include/linux/auxiliary_bus.h                 |  24 ++-
 9 files changed, 247 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary

-- 
2.38.1


