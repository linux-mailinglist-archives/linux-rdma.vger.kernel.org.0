Return-Path: <linux-rdma+bounces-2278-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0868BC187
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 16:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9E51C20A44
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 14:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3992C6A3;
	Sun,  5 May 2024 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UOf+i/LT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05BE376E6;
	Sun,  5 May 2024 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714920823; cv=fail; b=ifXXBT8cDetANYDE1D2jyaiDncWQPd5+D/HkkjndOynednH7MpW3QTePdi1+/0tQXYeCXu0F53bpnv7Bmb/zBDvYfcQLO7thqBDNkEg+QPXb/TYyVqzk2xuTJGoQcPnfPQPkk9qHHC7Ur8Cx5uiUe4iSR7SKDeUtTXrmV+QuAso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714920823; c=relaxed/simple;
	bh=wf6CRTLrqRPKiUUB7Crfp4+w1D1RQ7LA6wQEcnCodnA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BSiSz2l7yy/XBlZCTC0R1aRVFpwmJga8mpTkmKv4mQVCIvyFxnrVfxK00PEQJwc3d2tEsn3hOoUKq+iiZA2lRPDBRqkdxZ5HK7TG0pAakQzgk0DCmF+xoQxt+bDmw3/lJTjaQrNymc9Y703XqcnJmV8yDetQDEyO7gMn4xciQkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UOf+i/LT; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgZEOVbra4DODsMqSnc8Vuggyj3y299Rja3c8LNfUsOdD4zAeauCB34Bmn62wJQ6CP9KbSPoUhE5uVwYtsyiH7bgoSWrxRfSFkwKAHugJeuAjFrBpIxAN/xQi+2JqOd2M8/f902sUT9JGk0eXQK7OUZObUyTQKHiFyyugSs7W7DYFXg5hkcjGYqTWwFe3N0KwnLYsTJPALb+hFmDaXZHvqcAB1NjNsBISkergga4Mb635seH5J0QDrXnuvROlrAkyzgwEx+BbZ7hju37NrUKNxPO06ao/deCpS0rDpG+v1Z/rweUtYNscDHy3RCOmTy+mkLuLQv88w/UEDLt52LFyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HF4jFmHHrYvnvaCqMp1Hb6zLlLvA+B0KE6M9rCZ7ikc=;
 b=YEi+u1UOte4srdxAr8Mesy0WRVV12iX3F2qZ+g1RTDEq2UYxkRTGRRZxXUg510c7eNztCSuDlPGknun0oR7fElv1TT+DQpcpYZT3MwAzV0DPZlj1SpMKj5aUMEXf1C8jjL2RfkLqqxwXSWV+Iq7cPrR//IYt9VAy93tGAkr3qMShZfWGW5EC2fyGKpXEdN0k4XxfRgiTsy8KHeS6Cc14/5pbdDw6ZcWUHHjb4TSXJug22X4G8LtOdo7JdUG6wiN2KnAGaewNT/OEF+7t6oYSSvuEsV2WPEFqunagbsXNu1PVkW2oulsAPJiZFrhovSuXAKFvv74TE9Ku1iem1hu7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HF4jFmHHrYvnvaCqMp1Hb6zLlLvA+B0KE6M9rCZ7ikc=;
 b=UOf+i/LTzWzDO2lxkK+V5SVPb/z/H9w2N1D2M8dNV0DfME3mboGXtpKQ4za9vALYz5ip0gaQK69vzzcNug/RqYrFfPYBkx6S1Ip/nwwTil6+4W7EHpsJxabmazks8a3W+6d1xQbBNaDT0FQQr80HNBr37XtmlCDmSGcQ6zn/r/2U2LgzTHyb9+DBByvkiWiNlXBbGo8acz+/JHZipoz5ash2ytSU0NSKvDowA9+iaBiyL2zEvvnf6/lHPuQNpF/jkZI835NWKu0MaRqPHAoWlTAnR2bPL4CFGii5bMc6xUF8iRskM9k3sVnQj+PC89v723zSsvcgiVBpXwPvCVGYKA==
Received: from PH0PR07CA0040.namprd07.prod.outlook.com (2603:10b6:510:e::15)
 by SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Sun, 5 May
 2024 14:53:37 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::92) by PH0PR07CA0040.outlook.office365.com
 (2603:10b6:510:e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Sun, 5 May 2024 14:53:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Sun, 5 May 2024 14:53:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 5 May 2024
 07:53:32 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 5 May 2024 07:53:29 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net-next v2 0/2] Introduce auxiliary bus IRQs sysfs
Date: Sun, 5 May 2024 17:53:16 +0300
Message-ID: <20240505145318.398135-1-shayd@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|SA1PR12MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 80630b09-3579-4ed3-aa8d-08dc6d1324d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|7416005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WqnrrYC7hp5I0lCEbt3hUwtv4gXSB26ibQQdyRRfwckoiIhgJNrwOZ+V7WpA?=
 =?us-ascii?Q?N4iqj4Iv0yaaqqzWiRwGvENTpWvwyJENSsedYHM0WKKUk4s9cwMG8Pi9UF00?=
 =?us-ascii?Q?L7XzRuzL+R69uD7yjkTVfXaaeg4GpyFUHqcT7fGZDj/oe6oTaaS2JhjDRSLO?=
 =?us-ascii?Q?oLRbMYq1jE7682kOFOvx6MnHbG677WQiE+cU+oSCL3MYbWGF9N6hIKLPa0aR?=
 =?us-ascii?Q?vygEU5zowLdyTdu4/dBsMCHWq+36KHQ92mVSsvpJvoNFxl9H/171souf0biB?=
 =?us-ascii?Q?cOBh+F33d72kZaoVmVizJnI+Lkp/WXX2hvBaj1jYZ6T+WT+0c+25vySgrYIT?=
 =?us-ascii?Q?/yYHDJv3d4xF0Zz1hxbNo/nHMbzn2hMJbc69xyqK/u2pP0yKHDzMr8pr87SC?=
 =?us-ascii?Q?0O9Lhcdw4ulyFB6zSBw5e0yqA3IWRxtWHM7tYk+lG8o5O6HQ3Y6bAdrtfrSr?=
 =?us-ascii?Q?iAzqiUXA/xrM02TUbCiAFelRia7k7fDTPFQhQkQolco0+JVfwu74Dppq5VQG?=
 =?us-ascii?Q?CAT0hVzNpbA4f7X+pvpOBJSso/F3nRQnRjCkzTQMFC8mGP2SBZfsV1tDajlq?=
 =?us-ascii?Q?LBpPeVsmc6BdAmVpl5ln2rF31RlekwnH6TMXnwm8ybhtEAEhEaEbuqEyb5rk?=
 =?us-ascii?Q?kzwNsVugDAc6j5IhfGa/aSRkJAyM6uuWrWqSFMRZR5gdW9OS8zonJTWXLjn0?=
 =?us-ascii?Q?1I56w2yl5qTA1jC87VQ7XprftyyuSUaNlAiQmwFhczYh1nNCX765GaKFhKOL?=
 =?us-ascii?Q?HRp8NtLHetOxgu+efng9iaK4eH63A/EZciVe2AeIPQOhGEVm+zv/Zok6OXa5?=
 =?us-ascii?Q?xgdA/psrWR5tnzH2dQWdlbgIK/G0EpMIIptIkU087483xsOKvHwUYo62pBpr?=
 =?us-ascii?Q?JYfuuvp5l0fvwTqy71M5cbeg6SiMaAItntilSrgihwKLSlZZnMlGup2gu6lv?=
 =?us-ascii?Q?o1868E9apCYaRI80KutjxOSOWTvxqN6KspchYXhSOyhFnfGHa5lrfq1Hl+tV?=
 =?us-ascii?Q?Xut2WzLkBxsXWfgoERY9iQYlA1JBEQqgkcjdKvgocWLANEaLE6COxFJJEjH4?=
 =?us-ascii?Q?uXyLTawUmoGVA9J7sybJ60/pSZz9ixKlt4maVgPtIMJZb1WjX4yj+4mptPfD?=
 =?us-ascii?Q?UB067qbtMFA8yK66LX0ycQc7qA6FBJeqKuSNElHPzPIJVeX5LYlfqUOZEr6N?=
 =?us-ascii?Q?0TE//3W0ghYihy2qVNssHcyzEDmvagziQUbzMFW8yTZW1S/BEJ33OnoCB4HB?=
 =?us-ascii?Q?WGF0sJ6WOo4u7flqw4URlF8jZ+w0xAuxnr4OsJ2mIXUD0pwDYFfcn2j6RH7h?=
 =?us-ascii?Q?CiJTizM4BBWSi2OhXzWfO7+Mo/fNbj1hbv6qdUuNpQByH36Ij4OMLt/Ytmtb?=
 =?us-ascii?Q?7RuxiUo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(376005)(7416005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 14:53:36.8528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80630b09-3579-4ed3-aa8d-08dc6d1324d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970

Today, PCI PFs and VFs, which are anchored on the PCI bus, display their
IRQ information in the <pci_device>/msi_irqs/<irq_num> sysfs files.
PCI subfunctions (SFs) are similar to PFs and VFs and these SFs are
anchored on the auxiliary bus. However, these PCI SFs lack such IRQ
information on the auxiliary bus, leaving users without visibility into
which IRQs are used by the SFs. This absence makes it impossible to debug
situations and to understand the source of interrupts/SFs for performance
tuning and debug.

Additionally, the SFs are multifunctional devices supporting RDMA,
network devices, clocks, and more, similar to their peer PCI PFs and
VFs. Therefore, it is desirable to have SFs' IRQ information available
at the bus/device level.

To overcome the above limitations, this short series extends the auxiliary
bus to display IRQ information in sysfs, similar to that of PFs and VFs.

It adds an 'irqs' directory under the auxiliary device and includes an
<irq_num> sysfs file within it. Sometimes, the PCI SF auxiliary devices
share the IRQ with other SFs, a detail that is also not available to the
users. Consequently, this <irq_num> file indicates whether the IRQ is
'exclusive' or 'shared'.

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
v1->v2:
- addressed comments from Greg, Simon H and kernel test boot in patch #1.

Shay Drory (2):
  driver core: auxiliary bus: show auxiliary device IRQs
  net/mlx5: Expose SFs IRQs

 Documentation/ABI/testing/sysfs-bus-auxiliary |  14 ++
 drivers/base/auxiliary.c                      | 170 +++++++++++++++++-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  |   6 +-
 .../mellanox/mlx5/core/irq_affinity.c         |  15 +-
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |   6 +
 .../ethernet/mellanox/mlx5/core/mlx5_irq.h    |  12 +-
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c |  12 +-
 .../ethernet/mellanox/mlx5/core/sf/dev/dev.c  |   2 +-
 include/linux/auxiliary_bus.h                 |  15 +-
 9 files changed, 237 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary

-- 
2.38.1


