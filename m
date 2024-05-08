Return-Path: <linux-rdma+bounces-2334-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 817418BF520
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 06:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5541F262A6
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 04:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3343614AA3;
	Wed,  8 May 2024 04:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ym0ge48V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E8314A83;
	Wed,  8 May 2024 04:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715141129; cv=fail; b=UhR3nHvclXj9OB8ko5QMNbzz+sLEjSBXLSPDCTpXrFv/yKTjxe1yQFMCXURj5FVCw3ivztrPBtYXii0oqANgicrUpEbKRGLdOIRv/kyqNB2lFlizNfcaJNNCpK9/Gp5JUkuuFiDtCB91IXI2GtnY3qk0UE+1JRcViIH+pTMnPFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715141129; c=relaxed/simple;
	bh=C6bhSF7v906wQjyu3lB7rCkmLIXiwBrN/BsNJU+tTwY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GsZ0sL9vity3QqHYhk1RQCl4kQ6czyxPCni+KBZnxtHn0pYPn/vdwP6Se2gklrwB8MAO6xqqMjSYFjW/VB49MKvAlkq4JHImiQ7mk/qoAv3NsGKb4NhvnXbewKJ6Q868zG4LfaH4wJPtX7+dNe8LYj9osBt575jj8/tKyY2o04A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ym0ge48V; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5K1oqIPR10FgRD/kupsn/j2IM3pXXnt/m72rjtD9fU0t2h7YgMvNnHphZeEDx2LQORHO30pub7CytX+25TfuHQoWLiof/nV0NAgICVaff35mMLS+YfmjfN313AikqAijlGG8MxYPb1Y/lvyNRYfRbFTeitkVK01nFIePYEBY/zBOhriMVcZxg7ea0EUDNf5CcmoRlUgKwv//plfabFdUfORdpbkghGJdwcwkS5AyKXskjiZqlrr1vcBEXze5aQj8GvdQ+tu76hzkScWAl7xG0xzbyGfVXFH6G6+YZc9ETUVBaKVwDsjIX/eftGGZBl5PL+LKwtE3LIb6o7zOXHoiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpuayF32NftswDwZ/2WSSo8EK26lezjE1ZXD9vFm1Gg=;
 b=ByOqLIc1L5wO6GhTMMBvQW4IP4AUm/dOk4wK4vDKtDnr5/h0pLDPXi4L2lwq44ncTF7pSmN0jnyQRnucxLA1HIPf0ZvR1aT5+Bjpmw/Bqva5h2Uklq3jin6KsaOdk8M8qYdfbAo5R72ZUg2LsjV/YWRGzli+voTB1lcp/bJzd0WPWT6nM9tpAzktR1RbDmmmjJKlZ1zw/4On2BfCiFNfnJcxHyxFiofL1nc77C5CxVeJ04FDWAgeHOMpm9tLDZmgDWfAHaGVylEpPC3SlUDnt1pMmgYu+f6tNIHW1drospSrAHf/KEjpwJOf+tdFf+Jzb60fhRZP8TlwCmuOOz9rlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpuayF32NftswDwZ/2WSSo8EK26lezjE1ZXD9vFm1Gg=;
 b=Ym0ge48VBU1KfT4wJvSVvmJbgal4LxQHfi3yE7CskJBvB8Kn9hocwmc4DS2+pofIo1/dUNCGuZePsv+0dAHK/Sm0PuX5l+JNL7HCKHZWpqnaZzaY587KS6z2xmjLdBIdH21Qw3CrCaNsbbh8+IhuFG56krQY5KnSEAYLwYRamyA8huI40Fni8L/qG2JNmx4aUzXRwCJFbCFP0tcene9xe+AsN2L4K9DJ4Gv3ihVP328wEXwxaV1dXvD3RkAwI7/CNsq5MQrHPVQl8C2Kk1zSanrrFVswyxKGb1cTBCGAPQl9C4/APa3PB4jFRNJ6GowhV1uupl/7eedqN33se9wSZQ==
Received: from MN2PR16CA0019.namprd16.prod.outlook.com (2603:10b6:208:134::32)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 04:05:24 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:134:cafe::27) by MN2PR16CA0019.outlook.office365.com
 (2603:10b6:208:134::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 04:05:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 04:05:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 May 2024
 21:05:09 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 7 May 2024 21:05:05 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net-next v3 0/2] Introduce auxiliary bus IRQs sysfs
Date: Wed, 8 May 2024 07:04:51 +0300
Message-ID: <20240508040453.602230-1-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: b23bcdf4-82b2-4949-220d-08dc6f14162d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|7416005|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y9tjJK4w3QYlw/+K9k8IjwBf1on92eWSiqvoVvb1J/Jp6dANvtVp9jlSVraD?=
 =?us-ascii?Q?+4xOBQMepNli2JhDXUdLIMRYgbFUfagXzyGJnckfEMstLbUF/ZsSsv8+b6wd?=
 =?us-ascii?Q?y79iZU/dtPEbyjDtA2EddLfKn8Ftr02A4dpuz92053Ig74QpbqCVRasSR0qg?=
 =?us-ascii?Q?iotJ0LIo9bTYmTuLDLv0at/HRr2mdx7vNb55QzNBu1T/VaZlqhVtXGkhUctG?=
 =?us-ascii?Q?hCFbswjY0UJtDjGuZai2/6rDYqU3+XqLg8M+UQ/3+dhWkRS/ipuDYbgoPLaO?=
 =?us-ascii?Q?+OU37un0A5fEJgS5jp09VueppSXRdGKU6+GzUHqfeKM2vWD7xoNe0xUB7y68?=
 =?us-ascii?Q?8jf3P82GMjXuR06CDYH6eKnE1V8vDwyAthnegM8aQLoZ8qmBIE9EHk2XUgSf?=
 =?us-ascii?Q?yQ3lidKVjiUegmEG7dAcryArZ/oUSpRfz0SD6TE0d6RPFYjy7SpnpFcJhrOL?=
 =?us-ascii?Q?hbk/N3Ow6kxMuKfmFONVC9mH4hWMeDn6ObhNAO3n2CkomNqOsWPtYUsVciD4?=
 =?us-ascii?Q?NYvH7m0g79QKSSb1yLsknj9KkQ9wjuzUwQM1dGMgm7B3mjp2HvJ13ckdBk3l?=
 =?us-ascii?Q?9pa07HV+vLNeazUQLRu6OF7ed0amEu4u0e5WTvS/EYHF5RQ3kOcWAYWmpNu2?=
 =?us-ascii?Q?hgP2j091hGXeqw1nS4o7KZm4W8J+jMa1wuRvR2fr+79SNWbnyoFrhjy0zP+w?=
 =?us-ascii?Q?Wp/g4CqsyKnVvKLrATPtK0QR10ytVQwfWiCKmJgykM+KCc/oiQgOPgRLNsTG?=
 =?us-ascii?Q?VoHe2911e4HnHTzfP5wj6nOC3qfQQFjiVHmqCz6zM2I6MjJEsqaQmSgl4N2N?=
 =?us-ascii?Q?4nFlpriZuFJ7lfZ2wBnsdDlekF9dCZ9/a/A7ZHl/um6T7g/BJqbXq8I3szDB?=
 =?us-ascii?Q?t3C9BQKrdX310ElEiPW/Z0vMPshqP9eps57fI/KCqw1y8TyLdmVNAIKBQTcu?=
 =?us-ascii?Q?tBZy05w+2jyjLukrQi/fLyzHiQQUyI1R5oeyZBmus6YEoCF4jmimj8PGAu6K?=
 =?us-ascii?Q?HoEAzoGzWHg0AHxNeOMBYdhpPQm1dIwIwLciEq8majftJnnp+30DRiUVW+IY?=
 =?us-ascii?Q?hLi/8mNlZtK16GUtjBAlSrqTZzyX9WFbqt6FEPzNo4Hol2xo8mYpNR0eRU8r?=
 =?us-ascii?Q?hvt7xtTwwanGevuQqxp1hlkrKwwRcT02XO+Vvmt1HCP1VwYDVpNX9o1oPWll?=
 =?us-ascii?Q?2RwStJWH660FRjAL9AHZDfvrHqnmpkqSW2CKJEVY6ponci/RsV/ns/cIfh/J?=
 =?us-ascii?Q?YWPNGHA0UXeBYtxQrfJA2VdTr9oEL8yTjmstUA8DLS8/EiINGgUHTWfbvIM9?=
 =?us-ascii?Q?h5adB1qnwhIypcPPiIh/psgEiek97uGeckoiiaU6bBotGeq0CXm65oQ2BCaK?=
 =?us-ascii?Q?wNYKAyc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(7416005)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 04:05:23.9822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b23bcdf4-82b2-4949-220d-08dc6f14162d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452

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
This 'irqs' directory extenstion is optional, i.e. only for PCI SFs the
sysfs irq information is optionally exposed.

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
v2->v3:
- addressed comments from Parav and Przemek in patch #1.
- fixed a bug in patch #2.
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


