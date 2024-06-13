Return-Path: <linux-rdma+bounces-3121-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F17907827
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 18:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FDA28510E
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 16:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B5D145FFD;
	Thu, 13 Jun 2024 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PaTewY0A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3833A145A12;
	Thu, 13 Jun 2024 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295646; cv=fail; b=mxhGU4FRRsXl8pRAm3elR6TDxVkBKVAFrA8c3Wf6RPL6ZBeZJf/hHDMUYlvWO5r0QQSQu2usUGBqgsBCtSHKlUbvWv3Wk6S+p8/3z6swNVNSzF9DlozgQ3WFv5YPUWVTNSTUX2JO554A+jIKdtne6oUgX8BSplTHZgfhrkYpbdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295646; c=relaxed/simple;
	bh=it/H+cAK6STPoKl7ezwTdUz3nvLyUEcuPa/zxqaXXbk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jhcximBLsOZSyWyFTzFYiS1hWmDvoUh2xDl1jzSd9iLlDM5UATbCTcUVN58DxL316B5EiQbFrPBfZYmOMZmKNHNJvW9Ui6HOfvi7s5f8GvMu4urpoCX6yvreFZXmSDG6HMdp6ne3OorqU352ihzf+ugC0HVtTBwPm9/2saK8n7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PaTewY0A; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WutEQ4y414k2ja9I/yA+1DAYcc0aSuAysQUQeI3PEjSApCcO+uxSVc+CIWw1v5VAEAubeAQHYbWkE6xfU+KVnx3kQxt1YUdrN9IfbYm5L2PN7D1FNbE1UtoCCZBJzgW1/SzirAjRBzf72UAnQmPxgWTx0E1fZSmUTSjPSTDjYpdyXpgreRa7kTCy2JIYoVzL1IrpypYJyhUtmAA++g3R9uBI6qhfcws+veKDsSmlnt+zqnZTli7Rh/m3BapqjDzPE7U+NNvGWsy+XpDda2FDGWykyHbSyD1vy0HcprC/SADPFTlR/8JvBOuZLShHdnQtWMRFiS/jCmQWDJtxkXR5zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+UK7V8J6zH2blXMWHjTUrRFwWUFIPT2JIo7leqi9EQ=;
 b=YLriEupYOkAh1UsF2D3ib1q6T9ANGIv0AlwxTDCs7RYMZbr5R5bJcJScvUZqX+6JNY1N5AVNg0m2G+DEFxt0/ZmjSO+bfLfaJx6+8d45aYYnY9csVbFSQrGBWZ+6LEsARuHZwLn+aKIiaDVrgMayZeuvM5QmCwp4UQdEm8gyZfSBWoQs9vfZc4h+hXeBFEWs5QYfG7r1c33qHqd6TpxBzl9qS0UBvzu/AlBGYqIhNAon0vUmo6qIJqm3gB4coR6Ep6mbpFFvSU1P9sXDOofgXx2DC6zyKntbor8A2tHjIXyru6g5uihkL9/ykAjkxcpdmc0X+skYEaumdV9Sa4i+JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+UK7V8J6zH2blXMWHjTUrRFwWUFIPT2JIo7leqi9EQ=;
 b=PaTewY0AtBYIBZWPqyXaXMsDG1RNgwOJVPgAidQmwqpo2ibWhkbzyGn86JZXuTSXKcCdUlyH7VF3LnZWzfawrvZPAHcPajty+DsiZrqWz4Ldij0/AzSFYTFtrFVUUgBlvYizWytWI4l7cRC2JVsX/kpjq06JAtrI77+PJ/fMb6GYbSej+SE5Xl0NCI72E9oVuZMsgSU/Va5gFpQ/T5YMPLu3FCKa2xUci/g1GqsB1L2Ycv2z4G/j4rk4He9TWUvAhnDabN55edW9aktyWiyIkuY+aXUy1OJSzvrzYp7wdcc/+gm0WlO6s1DSCVdrZn6DLFehSdJ2UYhrfUq20AKytw==
Received: from PH7PR10CA0011.namprd10.prod.outlook.com (2603:10b6:510:23d::12)
 by SN7PR12MB7251.namprd12.prod.outlook.com (2603:10b6:806:2ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 16:20:38 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::c0) by PH7PR10CA0011.outlook.office365.com
 (2603:10b6:510:23d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Thu, 13 Jun 2024 16:20:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 16:20:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 09:20:21 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 13 Jun 2024 09:20:17 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net-next v6 0/2] Introduce auxiliary bus IRQs sysfs
Date: Thu, 13 Jun 2024 19:19:10 +0300
Message-ID: <20240613161912.300785-1-shayd@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|SN7PR12MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 5380a00d-5552-47a0-2dab-08dc8bc4c24b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|376009|7416009|1800799019|82310400021|36860700008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qNRlhswepahZqmdmN4lqJ9UZtZ2qnurTVrOGDIVJzSZ++xdl+EHzolRSXaBw?=
 =?us-ascii?Q?BSAcF+Z25R/3NAYP/VI4fNanj0RPTWwx/6mdR8eJSjKPmiPw6y9JiW80RDXt?=
 =?us-ascii?Q?TdvLngIiz3xiBMc917XQ+dD4gcNvKppSOeDJkN0Rh1Wj2N1D9omN7l6eI5t1?=
 =?us-ascii?Q?+Va9CtVnZaU3pPgsikdgdShRoZzaZA5nr7RhvPRuDbrMX4iTkJ5uXiHLJLmw?=
 =?us-ascii?Q?JnLNe0ZpOkzW7/cTLeiPtnuUWd3iUhTFMeWvqmankolg9EE5OqqzoYhj2BXb?=
 =?us-ascii?Q?SolOpdwb5Bp8B6vLm+1KPXC/IlmNq53WwJL3izi9pNJ8Imy3hncZM3At5nl/?=
 =?us-ascii?Q?Qy7Mzz5dsZUrGXY0A5EqlXp6yiKYRRyRhX4b4/z2Mn2M0iNRQT9Za+4zZ/eH?=
 =?us-ascii?Q?WjyWv4+kaoRLC89AiEPnZi64ztIST2yKTvaCxKUp2qpE02rMHRdjYB2DarQ0?=
 =?us-ascii?Q?sB3dq0m9AEsdMBSnSoYdEieLZfq1c3QCqyrbATVszfHHWT20AVsO2WAEYcCp?=
 =?us-ascii?Q?2vvjDoohW7TCMXIPOiYUeoj+ufp6WIzBbF+IrJ66KiBdB7+CsPvVaMQlIJ6B?=
 =?us-ascii?Q?m1OhOugLr8XO/mlLCXbb4c8WtkvzigJfchgqyNqjbMMQyNr33/AL3gfjujlP?=
 =?us-ascii?Q?jck4nLe/38oGGh8/kL1bKJeBC1pIhoQcknrrEzXM+uR7lxpX655oGxhi02uT?=
 =?us-ascii?Q?/hxCNtZL8PKDyQF12O2gELMTFxIQAl+QpOH+PogYoeioatDILJunpoJK9mQU?=
 =?us-ascii?Q?pshaIOSWkwKr0UvkAzoMPJSa30yApG4eqAuzdIUJzae+6W32/77UdpLlI3Ra?=
 =?us-ascii?Q?EmwExTI0utkUw9m287JF9NqFOwg3Z822P7cs5sUDf3jCafd5KqfqyleUj8At?=
 =?us-ascii?Q?PNiJull8ESO2+OJdIaFlXxJ6GiL8LT/brsDXKwVJeqD3OubZGt1IiVlH5oZN?=
 =?us-ascii?Q?AefFb2AggQSvbJC1lbrcClIGyAZ1LYs03zk3/3SuKNXyYZA6eLXVGyZEZ6qz?=
 =?us-ascii?Q?YigaPROK0vyRwi8Bc+4py3iW3zWsjGjVdmILXc9XWBfhfpozk+mF5q1369xp?=
 =?us-ascii?Q?cpOCzvNl2kJxdXBgwXmf/jrCq+pib3h7qS2xw4duhj8S/7bC/nyt1SuqUadw?=
 =?us-ascii?Q?NU15yq9cKEiNsZKMItV6RmgzVkj6ppz1LLXH7xh6r2/8+8B7a/MA05nScfCy?=
 =?us-ascii?Q?Vr6An+gJNEqUsFzuw9VNKjkg4KbYKUdEqQjm0HR6JAMywjo5NZaFaf46ld78?=
 =?us-ascii?Q?QvHDNb6gARb1pUvj7tnef6aolf89M101KHlrtyiI+P5vlsF46G+0mlP+B/S9?=
 =?us-ascii?Q?K7nH35wZoRxHktjRew8hYi3QdyN4S/oFu/Y7VmY98//joiTwDjxItHt4qGs2?=
 =?us-ascii?Q?sN1YA4PNOXMCDSwyrD7JEIjEFyCHH/Auw9EWuxJpaekAzrUNiQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230035)(376009)(7416009)(1800799019)(82310400021)(36860700008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 16:20:36.7919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5380a00d-5552-47a0-2dab-08dc8bc4c24b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7251

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
v5->v6:
- remove concept of shared and exclusive and hence global xarray in patch #1 (Greg).
- fix error flow in patch #2 (Przemek and Parav).
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

 Documentation/ABI/testing/sysfs-bus-auxiliary |  7 ++
 drivers/base/auxiliary.c                      | 96 ++++++++++++++++++-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  |  6 +-
 .../mellanox/mlx5/core/irq_affinity.c         | 18 +++-
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  6 ++
 .../ethernet/mellanox/mlx5/core/mlx5_irq.h    | 12 ++-
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c | 12 ++-
 .../ethernet/mellanox/mlx5/core/sf/dev/dev.c  | 16 ++--
 include/linux/auxiliary_bus.h                 | 24 ++++-
 9 files changed, 174 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary

-- 
2.38.1


