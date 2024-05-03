Return-Path: <linux-rdma+bounces-2231-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 022568BA60E
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 06:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD596283ABC
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 04:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF3615EA6;
	Fri,  3 May 2024 04:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aP8V9z7k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA8E634;
	Fri,  3 May 2024 04:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714710733; cv=fail; b=h9q0LybwPbFCL19Q9RLFZC6lAHXtZiAT81Fl4E+04P0Ct5lh+UgM/BOCV+hYJUa/cZ+w8gAMPZ5M1TgypHPAFP5a8CqiUbQw+FKmkbiz8ahSiWjooh5RHasuX+iBhQSUZYgkzX3zTWZAdqtXBTjuH0VJIB3Vwj1VprjXA+DPSHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714710733; c=relaxed/simple;
	bh=oDXCnHuYSmqlSaAeeF3L4fmOgJAACMdQh523+PDdOBE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qVGCTE6CNXAkQf4egULiTvTSY3j1QCF8u35b6zsbrA/OkIblyClzKngwAItzm9o2lfv9Vae8S0ZtxQjcAT0Do+/tWIvivjYAmvvCzMT3HQRdJMG5v2VjkjyfQZme2ShO3ke1SmnHNHamcsEZQS6KGd8MEtaCnW4PT1Td9fJmTtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aP8V9z7k; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgf9qhVXg7VTt9GrQoIkDtneMI5OHjOf3z4ioA3p2yj8X4AGMX8VsZz0VKiRSSEc+MkFV9X3WDETmxJ3+ivJE96oFz3uy42AGEoHx82pR29MOudcln1ZCo0Gku3QinQ7ao4WJVP7Vzz2OPsFKEbUIjDEs5hoHZ5s46EJNAbfXVJLYOQsJrhgoRN8WTGwhDFzW8SvPTQLuVdCfcBzc2tmC5cOz6TthXDCzLDtJ8N21FBkgSZXjDIOnMZCv5kS15eKKorriHaB15pDcbmiW/Q7jxFdkjmsVn+ZkEW8OxzgqDVOSFNIYISMc25XsKdg1XbyjgxLsEaQRSKsQMy9Rgy5xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKh+bu3gtzMehHyoUvDhN4KtgdesAFrqES74OFZghpc=;
 b=C/t1oDVA7Phply7abXhF0sqxg/y1epo/mz44Qv8E/M/X+DLsYNXwAwjyR4peGiitvvmsfG448+tbKhEKI8E2KRMCvL60YHgxn0PcCll8paCjINeOKJnDkDfDZrf9GpgjcNGotjwB5A554JYXPsz8ibiU7nK60ZBjoiFf9LLpxpZdwgHZXTVJelggwUZPgU3UUYXtvoV3H5sLxifqnJ6BajXcnmVRJPwZeqI7a0oIldwiiBPHjxjAois+mgVxJNrqYByot7b1kP2nU6psI1ItmQaiplNrL+0PdhuQzC/jESiTiL054m6S9qlc2xOrVYIvDG9yQhq1cFDNLq+t1qj4VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKh+bu3gtzMehHyoUvDhN4KtgdesAFrqES74OFZghpc=;
 b=aP8V9z7kHoStlUO35/x5LbNm4AzWWh9y80xFrYWrg+7oKQaMw/WyoOHgTY0pndLdynkOVieE/bfi5QMDi2dcNXCXv1eYUbp/6MBYzabd7b67q5jyBP5IHaYiVa4TKLaXYgnp51adgkBUJwFiefT4uFSOr8zqC+DO6bepGIwk4yLFT7tgwGUa3wMgvE6nonpZ1ZK9KEJHhph2QP2DNdUSRaKjIUzX65hSdXfbk/hAe25N1Box2EED3wiABDBUvjI6LFQSUgakFhO6iY1hQ31StmdVyzUc59Q7u4jXYhp9VpbQY498ILh8l70QS3vZ7dqig9kgomXVqsMkR40PAG4rDw==
Received: from BL1PR13CA0137.namprd13.prod.outlook.com (2603:10b6:208:2bb::22)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 04:31:36 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2bb:cafe::4b) by BL1PR13CA0137.outlook.office365.com
 (2603:10b6:208:2bb::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Fri, 3 May 2024 04:31:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 04:31:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 May 2024
 21:31:20 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 2 May 2024 21:31:16 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH 0/2] Introduce auxiliary bus IRQs sysfs
Date: Fri, 3 May 2024 07:31:02 +0300
Message-ID: <20240503043104.381938-1-shayd@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 3266a01d-9ea3-4bc4-1c7c-08dc6b29eb1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K5Wnjc+7v3y3ruAkjOUNSqFDB2YVP95DQ3h9htJ/73OWWUAU3P52N+WqqBkO?=
 =?us-ascii?Q?R6xOCINeeeqHWIrCf3qwx2kVwFKAbaODDvTAr9Qt8+r/1L1DyzhM8f6DqDyt?=
 =?us-ascii?Q?+pzaJlbs95YdovJgLf8gWKXmLpkPHHw11+i4jpXR5umCYkuwYxqpJUBxncMm?=
 =?us-ascii?Q?FWhIMMOkUL0uuKNxzQ7ZVjs55yRAqL+vCUpTsrOKG0Wz2mZL9V/DYnBul7kT?=
 =?us-ascii?Q?mg2A3C+u7b7DFdDOBl/kN7Gqp0LRYbAr8FXknTgnhZsqjz0DFi00rVyVf5od?=
 =?us-ascii?Q?0orL4zzz4I3mO0WhSiVUopsdEFX7ijaOSGp76D/vJO/n/iNDuAyiT6zGZJyR?=
 =?us-ascii?Q?ivr0Hsa6Z76fGlGfCv+jkOpD/fusZgS7RhT6ZnWCAcSWpGlmaCXR8BQKxCf3?=
 =?us-ascii?Q?NyidW9lf//cnNUKL5MSHUy73/rrTcLtZKRYzVJ15gVhMi0cp32CqTNAqg8EO?=
 =?us-ascii?Q?UwjR0MQRxel6+zLI4UCd/PAauQNcko1EWAOCCMptGebPTF+ABxEcFQJhQxid?=
 =?us-ascii?Q?Cwwa2RY9uKNoUwbPJDYafEQPD2LeWaZNvdag35PypOrFgxfgz2CGgFN7rCyU?=
 =?us-ascii?Q?dtHiTooE9J0N+7Op3SyYl0VToJu78ol3nixg8FtK59EnejVv/+1Puu7BNp9B?=
 =?us-ascii?Q?dJUtjybZnH+0HGEFc30dKqM4u6RtNl5YIKKDcBfx4Wfo5I45mSScVHs/+Meb?=
 =?us-ascii?Q?ZaOgyQ21bUWMcFArxhnA4sA547ppGd62GquCAiJ6Zni5w7Q+LZoHu1NX6PwN?=
 =?us-ascii?Q?bwh8S5ybi54RnuZUyCCUpb9IHSJc359SwDG1h79wDhIfYg+EPGglufsWjP4I?=
 =?us-ascii?Q?2NRaAkGvFHYNb2zaDi3Bh7AxTgtfykNPB4KC1RaFyLMKlG0yBi2bhoAmX55L?=
 =?us-ascii?Q?s57B8wsX+MGUWR7fp0RfbBzWOPtHLQ2TdT8eFxC05sw1fUEJ1YJuTU6L8Wi6?=
 =?us-ascii?Q?r74STBj9jy2yEw1NQYJ8ZKSSEQTw/3fFVjTo2a0n2LZnXAIV6R1Sd4i7yfsy?=
 =?us-ascii?Q?6rC4fMfKoyjqr8wnhpVxiqjhqO5HNO6791GrG6/ZaLn+lfMu693CzznwKvjO?=
 =?us-ascii?Q?geHgp/cUKnIveEZ9xl1rxBj1GofjwUuwJSMP/frztUY1oDrwBv3tdtj01nCv?=
 =?us-ascii?Q?7XCo5SYa26yHB6HDkptCxcEMUC6Q5bJ1np60FEacsWFKEMWIS2Jx8qS0h/Vs?=
 =?us-ascii?Q?Dss3B6KoG8jPur6vZa/A84AdZGv/zoCnqXs+FqgCcZfnxpc0bosZdlIIW+6o?=
 =?us-ascii?Q?+nNqmZBQ01pDHGyDd9HlZRZs84hPU6JwSyphe/0I15J6YTofRk6Qw0vbqLp1?=
 =?us-ascii?Q?glYx6ZH9BychIGdnktSRyQTYmGsdVtKVmFGK59qFD9mAWdRLJ9PGa+R/ZhHn?=
 =?us-ascii?Q?sHE1pus=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 04:31:35.9768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3266a01d-9ea3-4bc4-1c7c-08dc6b29eb1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930

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


