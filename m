Return-Path: <linux-rdma+bounces-3703-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C66F929BD9
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 07:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A112817C5
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 05:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A2510A1C;
	Mon,  8 Jul 2024 05:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mZjAeWlj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3271B11712;
	Mon,  8 Jul 2024 05:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720418189; cv=fail; b=QJ7+HjSNG2qyOPpaBeqEl5G6/rfhfAsXjzznfufLln84ZYObZhMP4QkVXxMp1N/oI/TsPVy0utfkZ45vGC3Ygf6xBdj0268yFKofQdqyQRRV0GTh5OSdMlXNpgyLRSoywInGVjRLv2v6wNmT9BZ96WSCv1aC4feZgVStwPKcLlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720418189; c=relaxed/simple;
	bh=LlsELXxJQld/rL0MnlYZz/MjUqlCUYvNKQpc6854OOY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DEK1gJha7Syi9jct/NX5tQ37udD/Q//3xIS+/vsvpwoUI21Svmbe8IN5wdpuiNMOznZLOufVCueBIP7ram7I0aHJB86vTto10k+TlhW6Enjzl5NrJVtitwRWu6MFDpj62r6TGPGWjdBwNrP/tRlNZeuV+uogckaqtNFaXlzhOZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mZjAeWlj; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAO6XvPMDRJZiKVxMGuABwWoVvvM1Zbdivap5i4i2kj2LShwnFC+4sWwxEJ4cx0ih5OboH4iwy9pg+hssstADDK8VVuM2hIK/aD/srMwbXpLt+ZgnNfnw5vOl1fCU2eQTeUToFbyk9cI13+1mSEOOzBzmOgdTN7IPN7FvQ7faDfo8iUKCbAV5lVfMIjMADgxOXfugjTxj64Mzif6Hqe5qVaqSNxvD3f2fhFNsU9+G9UHhwGkw7w8gBJZtOKOFIcMuVQW5MgKEY18ateQcTcQE/EppcIKd0eT8VPHphxuwj4Wwg0o0iLAoBOen8bzmDyikZRUUTA4f0aqAPRtAJ4WRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRNapwjjJZa+UGA+3a9uAjd/1KBfibHDq6zRVlY3oK0=;
 b=fvX7ZFdcYseGx4DA07KMWyKibkNmOvVvwUn331lbFwq/0ENaf/tfLNrPycWWZfv+KigAsUcrDmzxAJXbSRH3SIfxyb6FUlIAgZig1OiOgnlzi8Mqm8QldXvhXPL/Ce7+7nbmUUBjz14eC1VL2LrEj5vlVVx+uJtwK25Dr/gixLNOnoNsUW07bXHjCx09/kMIollnoaIAo+Ng30AjmDcKaqzbSnioEwZjVBcn2K0KdT1JHKXqoDx8reG3BtG4Me8DOf4o5ojO/+C3YjhMBtYS0iFnXFksFFOlEGvzt6c1JIgvt6tNeNrHaNg/TNhJNnXFJKs+mfd0x6t9052/bjU21A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRNapwjjJZa+UGA+3a9uAjd/1KBfibHDq6zRVlY3oK0=;
 b=mZjAeWljyTZKRH6U9ulAFpIbrbaRtbKYbdjTAhLvt8XTsnVWdFN1BHO2nvHO0osS6Zl1nmMe29neORcYg0QIeh4K3XWoxcsImNM9gNCHgCFtyepm3nluKerwUhDz71aL68/qLaJDAsMo7Wai9H86Hete4lwtuOR7NyN8N9xXXOW/ebqhaD4HQivBtl5z1J73+5sXjLDUlBf3x1OW3j5Tna9rOVgtQ2rFFX+qKxB2LBGka5jqOIwElZjqCZ+ylnX6ORD36QIwX01RkLbCvbTAmYmqrWG+FhtdEpsLwJHw/VWA4CuKGsNpc4gO0mj6pjKikD44Uuz7gBKvXDXnv73w/Q==
Received: from MN2PR20CA0023.namprd20.prod.outlook.com (2603:10b6:208:e8::36)
 by PH7PR12MB9103.namprd12.prod.outlook.com (2603:10b6:510:2f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 05:56:21 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::9c) by MN2PR20CA0023.outlook.office365.com
 (2603:10b6:208:e8::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 05:56:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 05:56:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 7 Jul 2024
 22:56:09 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 7 Jul 2024 22:56:05 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net-next v10 0/2] Introduce auxiliary bus IRQs sysfs
Date: Mon, 8 Jul 2024 08:55:35 +0300
Message-ID: <20240708055537.1014744-1-shayd@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|PH7PR12MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d07521a-2bb0-4e28-f58b-08dc9f12b12c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OO0hoUDavpCfyCPYnC2lhZ9868i3nU0SwMQa2DzEKLjJoTZ4CIAuE0zazWoi?=
 =?us-ascii?Q?AE/wq60V+ub9nVkzif1N0H+t3nzFmOfQ0vz1rNwpab4p0A3ZUQwAGl3y/UcK?=
 =?us-ascii?Q?CHeuQrD/qRJvbZMz1hYP1SaxAttZSpPx8SYajKCaPsIcFKZUc3qjqrKnK9TY?=
 =?us-ascii?Q?1WOZfDG32ieiFsZ/88+FO4UaK90PXegQBQTQ06L6KT3p43CTnE99YQZQV2WM?=
 =?us-ascii?Q?9afINJPr+ZTWSKkL9WwQkIu/kT/Gmja+uMjmcwzqrfX2bLaw3LDAtRRijsS6?=
 =?us-ascii?Q?shq/3l199hk5roigZzzQ13IAF4y+0ArhZJqpSxQdTVMBw4JEgPG1ozWffmlj?=
 =?us-ascii?Q?PKZDV3oMfYuxxSbVUc6SsazJurcVRoA/dmKnKAbO/bT5NCaOfgr+60erZazD?=
 =?us-ascii?Q?hHJa/ddTE5y4gTe/kvPldggqBfse5PIlQZtNUnNb6iBWIsX82Jh3xOYwsJ6v?=
 =?us-ascii?Q?rzhy3eadlOAjXuguHO1A8V6n0LLuHpLyp42FebnWhP/qLqJB2QpYuXM4ibBf?=
 =?us-ascii?Q?8bRAaDOVAyOqrewIAixCoOpU3K516sK2S6/5j81WBlMGTk7bLjfHpdcCoffP?=
 =?us-ascii?Q?jnY44beFKzeApam5lUJfCxAtIriGuvpe8XV0k9VHqth6rQs4TMz6zV126AxH?=
 =?us-ascii?Q?zfUXSojk9YC28EKR6U1ZOn9ORosySKvawQqCTREQW0+M46W+P9myf+AAlYno?=
 =?us-ascii?Q?2nFPVylDiFNDnzhoR5oafP8NTLZ/UtqooR6E2OBiD1eMLLRj43llPqIChzdZ?=
 =?us-ascii?Q?qfCXi9Bo/a1fYLs57JB/8niZx4ZG2UVzMkAyZZhGS3BNiJX38DLsuEcLFd71?=
 =?us-ascii?Q?GngF+jhmW+cS3/1IcebKettAV+v4OUPQEiIhB2mPHed3IRK9jSGDHh+vD3KS?=
 =?us-ascii?Q?x2pvDriPQhQmsA2oREn2JnerAfgtzNfvW6O4LAjr9BffqD7EZeWUYnUhdRG7?=
 =?us-ascii?Q?0tpMNFLAECAynnY+NcjQtw3jFZnq5U/EhobNMaP71OCF8rm/5bhVy0dc+maw?=
 =?us-ascii?Q?ryP0l8M5qrL74MizO+OHOM9gbhilS7h0IKe8dnt8OYPDIaj4dwsrl8v93Il5?=
 =?us-ascii?Q?JdMuc6jAPvZuYRiWU18ro82hFihyGkH37UoErt3ec4X+Z0oZ+LxqMS4RDLia?=
 =?us-ascii?Q?bjt/R6M8YwaV5gnjlRXYcl23d78a63wFAbxa3DsmQFiU1izRTwXY+VkwcK+7?=
 =?us-ascii?Q?nFSajufU6SF6l+VihuHMd/dXOx8SxfAdDfeCV/OO+bri3T5Bfk7PznFni8W5?=
 =?us-ascii?Q?eXzI1JUxhUQpHyFF2gswu/S6f2yfrMAJRX4qNibM1sMerJba6wXZE6z8662p?=
 =?us-ascii?Q?to1+8d+kpnOAsZzOjvB8z7w9SbErrz+9gS9E5jAe0V5m/P+pVVosuL8P5uMr?=
 =?us-ascii?Q?hQGc6j3uVyiogn3C/wprL5pdK2k3ulDo5vU0AMAtxAHIpO8vOo5LeLGjdQIT?=
 =?us-ascii?Q?dWPHHMk95Xk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 05:56:20.8634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d07521a-2bb0-4e28-f58b-08dc9f12b12c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9103

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
v9-v10:
- remove Przemek RB
- add name field to auxiliary_irq_info (Greg and Przemek)
- handle bogus IRQ in auxiliary_device_sysfs_irq_remove (Greg)
v8-v9:
- add Przemek RB
- use guard() in auxiliary_irq_dir_prepare (Paolo)
v7-v8:
- use cleanup.h for info and name fields (Greg)
- correct error flow in auxiliary_irq_dir_prepare (Przemek)
- add documentation for new fields of auxiliary_device (Simon)
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

 Documentation/ABI/testing/sysfs-bus-auxiliary |   9 ++
 drivers/base/Makefile                         |   1 +
 drivers/base/auxiliary.c                      |   1 +
 drivers/base/auxiliary_sysfs.c                | 113 ++++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  |   6 +-
 .../mellanox/mlx5/core/irq_affinity.c         |  18 ++-
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |   6 +
 .../ethernet/mellanox/mlx5/core/mlx5_irq.h    |  12 +-
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c |  12 +-
 include/linux/auxiliary_bus.h                 |  22 ++++
 10 files changed, 189 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary
 create mode 100644 drivers/base/auxiliary_sysfs.c

-- 
2.38.1


