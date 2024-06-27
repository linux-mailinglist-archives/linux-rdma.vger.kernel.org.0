Return-Path: <linux-rdma+bounces-3542-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF1291A95B
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 16:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BCB1C20CB2
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 14:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86184195FEC;
	Thu, 27 Jun 2024 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DIPWsNh9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAF64C6D;
	Thu, 27 Jun 2024 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499129; cv=fail; b=gH3ucL04cIEn5hqq0NHXf9xSmkkhGnKh4Ze7EzIqj1PzW6zK7CTSRsh2xtsXu2xYc7xUqHXt8K+ABThaDWQX1bdgRj9JiyrWOpQyIr98Pjks0OAAOZ7Kq1LDCt70vxwafkUR8mgKJaAdP+hE0irCrj7OYypTF+fTEqsup9SImMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499129; c=relaxed/simple;
	bh=IDOCnukOyFXfaMkAFMqWduBcHzP1SjBT+XQr6vtkcHg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nFzoirWAnIs3nZ243etkiSIKwjhLK0xi2moftpSwBLnL7f9qP3FT2mcFfkLBmHaT8S2R4YiZiuyqm9GbM+fQAcxdId6sUsS1rQYKjYlsjL7DTS5q/ZuW8rxrTaOE4FuURj2rIXe2OpQ9eRTenCPd5IhR2llc28/frlp1l0gd2NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DIPWsNh9; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdWNpHdcUutX8pKRrP6grUmiPiUv4hYxIlms7awl6zFDKrL4JbD4P2cLBXgdp356+HD6oHyD9fYMKcgkWKcISdK4JVgBAn5tAD6l1bxVJPCeK8h6+jGGFz6mU9CnIK+uFKg+eVwT14Y9W7+qVtp2jlsCI3phmoiQzkuQJt+xKDHSuS0MXiCzs45Ou7zgYwYotu4dyAGrHANXkb+mrxKbJeEw0YsnI7RoXrPfzG6H1NxzTl9qeut1LVG7LuYyzZ+iH5zM5OEMLYHklrv8Twh0wfKFXBTbSZbwHXlXzzZV4JrVmu/FLidt4xPulE73ceog65nvFmc6nobV8VrWgu7tOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTA7YbC/TtLBjBOVGfJ6vJvvL5AKtO2mgNezr1sEu1E=;
 b=f0a8LMlbJD4yJR7JkxD7AkSn30oSCHgdkxpKqRDQUkE9PsjuaGRUhskhQuTLfSOockvhgjPGAFJVK1LDhJ/4xP50MZznCMTLb6FdrK0/IlOMLyHoXar40/lI88q4YMcOzcutujPh3r+eiKTvvvBywuFMq8dwkOBhdSf84FwUDZe8CiLVZ6k4/83tCeOw/RO+qOX2Yi9hu5pKEwOxqKMjA7L6pKYtG11Uj/jIzT9t19KXK/KBbjnSI/DhO2hKXBNYw+qzdXf8erTJBCtWmK4TLSymHb5bn7UiuU9tEy7C/QBmcOL3bsK51c/kjK4xHNl192yahmBsl9Gg0hUsh1FJJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTA7YbC/TtLBjBOVGfJ6vJvvL5AKtO2mgNezr1sEu1E=;
 b=DIPWsNh9KkuyYkXzCiQjS+i2s99rhCc0aqzWSxu0Bno/3MANnTR8/FnbFvzNQXNzgkDU6mVlifRI6Jbtq5cmmMxnan8WbIAoLIW3gV3ggtrNPEWmkT8YwA93wHDJOiOdH6zSUuIfzYy3cbG/a7rr+tZBg1gQ7MC9KwwpvKRlQRXFjrLMccCAKwGry+WXfAg630MPjLBUlMk7jCTGCaC8RNq2AybckVCwBqOx9jUHXOTZX5ZTlYh4SEoqSDHl5dN3oD6iWD0Cs2ZgJY5C1pK6cUGGDkQbd8P33Qg2cT7kBlxSLjM1vqsddJDu4EF3XdViX0k2tVFwCHSiuuoznWz17w==
Received: from SA9PR11CA0015.namprd11.prod.outlook.com (2603:10b6:806:6e::20)
 by PH7PR12MB8154.namprd12.prod.outlook.com (2603:10b6:510:2b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Thu, 27 Jun
 2024 14:38:43 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::d1) by SA9PR11CA0015.outlook.office365.com
 (2603:10b6:806:6e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.24 via Frontend
 Transport; Thu, 27 Jun 2024 14:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 14:38:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:38:26 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Jun 2024 07:38:22 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net-next v8 0/2] COVER LETTER: Introduce auxiliary bus IRQs sysfs
Date: Thu, 27 Jun 2024 17:38:08 +0300
Message-ID: <20240627143810.805224-1-shayd@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|PH7PR12MB8154:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f5055b-43f9-46cb-c2ba-08dc96b6d809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U6RfnAA3RJNNHrIwYiFwXo2zoF8qU5HUsXjU6E9/9KewYGtXr+zQAK/PXKK+?=
 =?us-ascii?Q?6B/Rh3N92+nPN2TM9WawC2XaMn6lLhqPSi0SPQutsRG6dbUErM9tNa/0zA8j?=
 =?us-ascii?Q?KV2KojK2JL+nbb0zq02eYg6yi4buXVUaL3bIs26WQA7DnQTBwI3c+uiCKJIl?=
 =?us-ascii?Q?XuNrr+I+FXdXG9TfiTAwqjkEcjS5h2Uwn5lNeMLoQyTRN/rSiPv7xSSENG+A?=
 =?us-ascii?Q?7peEWXA3JmsycLysa6RpCh3hGfYCEsOIbUUPzcAJqxuIj22+LUAhaEGUG4oD?=
 =?us-ascii?Q?VGUgm2i+XN872lT7h/U2vYyClR/xHraHMuBA+WGj1cuva6xeiyCcVplZaCyk?=
 =?us-ascii?Q?KEo1fk8s2ZUajthYJ6xuabNA5SqhmH+G9f0rV820i0ZV1WoLF5FsB3cL349O?=
 =?us-ascii?Q?8jelOejhF6duE/Acqx8fPXEdE/jLtk2yBLqNtPy+MV0jz8D8OXpSHya6niVo?=
 =?us-ascii?Q?fakBKvGMpAr/8a2QOXdgTfWQwUQ6ZeDFH2VjFPZyJdFa1NZj64cQEwLZxI33?=
 =?us-ascii?Q?mb4SRLDtcy8mJ2PPGBRHifFyEFwTGOEu4OklHkOwtDpILwhn5ixsYSsc6oL/?=
 =?us-ascii?Q?8n4A9R1MLeiu8rQBGRzITyTlDdjcYHOeYc8g4muoK1PxoaTsQYbiitiQqSPy?=
 =?us-ascii?Q?/60Bf9kyUTj670fxyXauNcNaBJqYswErVA7v/uMV3irdk1mZgHpcqbh2Tp7n?=
 =?us-ascii?Q?joHXRVEqaK19puUPFnEBAMmIne/POlTWBVdvdt/CNZGwiPy16WXMq8RRXApv?=
 =?us-ascii?Q?sLe5nuqPkXdMm85kPNtf4+RB8dm+F34h1Y4Q0zltJUkWhRMSGKb0h7V1xSQY?=
 =?us-ascii?Q?U5DbYG3HtcsxEKjajKu6X88xMhIOUei6FBBjm0HvqgHxKJjjWtVhMgVgHW4p?=
 =?us-ascii?Q?NeixXyXwrmsmeGFkFax37diBRz6ZFW8WS0jPDz4NanS6OCIlcx3hBWOabxob?=
 =?us-ascii?Q?qKfATG3ufHLseXD5QDAApViQ+8wYEBEVDrWEit742mc/C+L2IAPQRpLF/n8L?=
 =?us-ascii?Q?tumUsM5i4/RztuO2nJZluReBOYyuF9ZqazhEJ4PWTWdvMW8DkpRVWeOY5MqX?=
 =?us-ascii?Q?+dx1FK11SmBVUlw7mrziAUXrHxRLFTvF4FenYXyLbBbkMQY451V4QIyij+pa?=
 =?us-ascii?Q?6CdH3FNyfSYmK3jj2+y8CnPmRz0VH0kUKDhoD9TiqiVyjmA4y54QtNGgwSsx?=
 =?us-ascii?Q?c75c7cp3t28dBzMzAlx1hWJ+kYkN7YVOTVLOS1Dkk9WONr+zMbeX/JwT9Fut?=
 =?us-ascii?Q?VDMujjObrNj0dMvfHFf363Q4fa9Q9zBwTlZTIbW90HgIvAp/ZSwt3jj+dj+8?=
 =?us-ascii?Q?tjNEbZH1QGtyUG69erlmoMeAqYUZxU64bXrxd7kiohqMXdO3/F3EY9WftJea?=
 =?us-ascii?Q?vBvbtT4yMiIoZuj7Vr8fp4r721kNVtbDLdQPLuvFv40Ut6JqZwsybAZYh8f/?=
 =?us-ascii?Q?8AjDyIsNPkA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:38:43.1094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f5055b-43f9-46cb-c2ba-08dc96b6d809
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8154

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


