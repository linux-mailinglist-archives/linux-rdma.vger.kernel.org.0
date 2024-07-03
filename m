Return-Path: <linux-rdma+bounces-3621-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FA09254CB
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2024 09:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEFFB1F23BE7
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2024 07:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E130A32C8E;
	Wed,  3 Jul 2024 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IEs4o/f2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A1B13213B;
	Wed,  3 Jul 2024 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719992377; cv=fail; b=NmqgeudZDwDWP3wd08jrZinV/KKVqln3+2RFHNaQQeim3JbUAqlYTD8XLpjiRpBBWgJFcMc9/ymeIQFREVpYCRIwJvuYcTCQeIxNLcRrDYiZobROGdHGOxKCH5vRcCej2l7PmODm3moGfg3ZX7kHAByu3vt8EPQlX7rlGPPKdUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719992377; c=relaxed/simple;
	bh=JB2gy/5Ea6JjHoBqH5Sd0rdNJZTG+Ux2FUzCk7VPgAI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bJrIev634P3qABvcLvgQTgufIVl8YThfDsPhZQ7Jo3V3QWsskF6W+CdeakWbBZp+UtMr9IFl8kxx1LLsDKmRmfIkE6dDw/8zYdd0UYBYxnEk/mjpY4VUJ//06a/UOhqOxVPrgsNuFsF8THD6taKyrtpbJKF1RkT1nNXsPUAU8ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IEs4o/f2; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odY/TqjKNbpYHbiLzh454F3/Q0XA2hmO90ZjmSiUyxrUX4J9xBBAndBLNiw7fajPUmM9CtY0WmYFl4F3bdpJNiFLWLD3L7lX5v1o3ldIXNaCFCe/xFK2zEZ7DQswI/5a95NcsMJMEAuiqs/+bdCVmJQfTSaTv19/OckadPEnFUXIShhLA/Pq1+snEg5V9FAGXB1OiqMEE2ekM61IL/g+EQb7YCQw56MS39YpAvwdTSSqpIierw+39+n5wki4KGeUX0M2BXAKu7bxzb2/owLEIyqui/ViD8YhDCxXQ0p5qZesSS98IDpofl6nX1/KyxGZXaij4xzs4eCpOjUxpyqOtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cddrETxKf1qgAgVEhOjZGHb/ID5xTIh8hOLWdNdNJxU=;
 b=brJT/2R0T25T4tapfdktQef4bhD0nQZIpA9vty02tBfeD3/002PM19kF81xsl2R6RvhcQuDtsw/PPr83UXo4pBTXpfZMRT69DJWTEAKXOsFdkuQtlYv73JW3CZSMFhUTBsqu7NvEPrB4JdNtQGqG47J1fMP2Ryb9P8OSUGZHCZ3mmkTx+9YU213YXKRaiqFWu7mOH2ok0nG3NtL8yhktFnOzfaEH22Do/WFeF1C8xZI0Wge1sWjFkkRhViGINLFd7c2GDck3K8h6r7MjcHlDwMzfR5+7zTb+8xdYTH9KpenMx9SiL4A1vAk2LPCoW6hHlCq2ejxHxV9sAnrFdGxOuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cddrETxKf1qgAgVEhOjZGHb/ID5xTIh8hOLWdNdNJxU=;
 b=IEs4o/f2l4D+ZRomkz2rCj58CvXC900+A4jwIVyje/mqXd729H/k18suRkN+tBpcC5a9wC7JZ8330q8VHBOWaMjufK13nMmX/JgkCwDz6wqphXLZn+bJHxDzpTikh0VC5jRoDMnWahQy7diWse8bHipejuTg6b+1lcEQqrXiv8JAasfmgwsOnYkRZG37wQccg9R/m5Eq6poGiXUeuW/A4oia1pdjpPRBbk4wip6fKUe7p/MGZAF4Sk446etZlRpae1ReQFV+GbWoW0Bm38ckKrhF7cfZESWIuRCNzdnHr3TYS16VRQsKWR/kXvz+rkuSNd1/yvGWJZXdAK8AhhpVSA==
Received: from MN2PR19CA0053.namprd19.prod.outlook.com (2603:10b6:208:19b::30)
 by PH7PR12MB5928.namprd12.prod.outlook.com (2603:10b6:510:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 07:39:32 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:19b:cafe::d0) by MN2PR19CA0053.outlook.office365.com
 (2603:10b6:208:19b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Wed, 3 Jul 2024 07:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 07:39:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Jul 2024
 00:39:16 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 3 Jul 2024 00:39:12 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net-next v9 0/2] Introduce auxiliary bus IRQs sysfs
Date: Wed, 3 Jul 2024 10:38:56 +0300
Message-ID: <20240703073858.932299-1-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|PH7PR12MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: af450ef8-4f5e-4a32-a0fb-08dc9b3346f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WWE4l2rJlGkeUeqmE9CKQ55Gdx2OJ4Z9oEeFGfHdsw/xe1j67OgZYOA4RwbM?=
 =?us-ascii?Q?70LQxe9Q8i9qIppYjF4lfBZjRBK6KE0S59A29TbAsTBBk+6oR22NX8HY++DB?=
 =?us-ascii?Q?7WSau2TKxyj0LQ/a/qlHhgSYC+a7EaPouptsrJtQw/GDy0ZEIv9e25oxQ2zP?=
 =?us-ascii?Q?jHKPj+ocu9tZrtHa18Xr/onCAE9RNmnfGTtwJHcgSmfNuUxW0MLY9WtBgvzv?=
 =?us-ascii?Q?UR6vvtCcSg9pQqHFoS1JWL8Ia12jSyQb27XzJhNY+lvf9yT1XGkK/GXZDD16?=
 =?us-ascii?Q?htaiYLhKSHO9PAdeVzDNdpiXSDV8QTAlpCWcK10gD0//Sfk8ivLUuLNUa+g2?=
 =?us-ascii?Q?mKLuicO9m9INloNrzE4eCIP/VRJk7DqmNlvPl/vi+M9uAqyJd9QFbaqcczNF?=
 =?us-ascii?Q?CodG7Mb6hlRapPsZiwM5mY3JOXwYcVmOM7nuboIg51O3E73/YPpHYTHc1tAe?=
 =?us-ascii?Q?0nYyX/OZLuSRQJ0sNgeTq/cTHfFZ/fKI7vPq5yq3DNdNRXIqkptmnZFSifAA?=
 =?us-ascii?Q?LAXff2FZsWETVBc7dvXla2eddkaySEU0rujKAqEnqQ+8UgRmD4xzV4PMhRoO?=
 =?us-ascii?Q?6zTrgleG93fh6Zqb80r3jCRy5Ftun5xrBOdpGU/8w67POofsqJQIMCesq1V7?=
 =?us-ascii?Q?rvK3E9lZG5px8ToARBqxFIehHFq1rlXYPZQhfZ0NWAPTCJVrP+J47Wp8U9tc?=
 =?us-ascii?Q?+P5cLgB6rkSlEjdYJW/QJg9OtvN0sKqrVVty3y32KjDPvTAB8Ei09m757gTx?=
 =?us-ascii?Q?9EfhMuZxVzJy8LRtJsMJ+wmUjJgL7KeipgtscL7Ak7Pa4iDA5+H6pFy3GEn4?=
 =?us-ascii?Q?6IFbF1Njx5dc2cDa6YQdcztxnxUBHamDoo6KY5WNGt1quxys4wCqTxri+QGp?=
 =?us-ascii?Q?j5qVjiIwiZnHQMA3ZrWGVPFvFwahxDmkeZYiuEoW4h/O7UeM3faU5B1GThkH?=
 =?us-ascii?Q?vuCrr+oNdDIqXf03EsaiTywgoirXRlCE/G4osObUK1zAcMUFbHNxvruXM45J?=
 =?us-ascii?Q?0HBqCcjU/RGMEATAweNbbIpIvpgemSEnVwVJ4ALbvB3vNAdSxy058/gM2nrt?=
 =?us-ascii?Q?atRd5z1zbqBQUCDAPN+e9o4f2vJhLD2v1P7+RKIFwQsCGRTDdD1ktw8AXydW?=
 =?us-ascii?Q?ZFli7HFxNuSRu6HmqNBT4EFx5EP23OQukVZfOUtdjOWrpGEVpXUKZgn1oYto?=
 =?us-ascii?Q?tPUabLnoKsuIUN07zRZckNKIkW8oIiQ3f/O74CxykTC7IKacJPA4yip0V6vF?=
 =?us-ascii?Q?GMBrJLTPEhpmWLsKiFfF5CRzRdvOHooIPGBVcN/k43O+/XWtJlk1nO9JvSwO?=
 =?us-ascii?Q?tGE4dKCGuSHAhcF7+bL8PmpSMTv7ZEm0Uwcd3grItmP/wRn9SDmP7KmjI6qP?=
 =?us-ascii?Q?FU2SEK6lEj63rQ/Maq6IGGZvkC8LGGP/3SCh6GUYqFd5tMDZyELlKHjK5yz3?=
 =?us-ascii?Q?WwHcQ5p0bNo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 07:39:31.3548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af450ef8-4f5e-4a32-a0fb-08dc9b3346f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5928

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
 drivers/base/auxiliary_sysfs.c                | 111 ++++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  |   6 +-
 .../mellanox/mlx5/core/irq_affinity.c         |  18 ++-
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |   6 +
 .../ethernet/mellanox/mlx5/core/mlx5_irq.h    |  12 +-
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c |  12 +-
 include/linux/auxiliary_bus.h                 |  22 ++++
 10 files changed, 187 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary
 create mode 100644 drivers/base/auxiliary_sysfs.c

-- 
2.38.1


