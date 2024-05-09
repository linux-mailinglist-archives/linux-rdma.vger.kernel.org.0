Return-Path: <linux-rdma+bounces-2369-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7248C0D55
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 11:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52CDF28166C
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 09:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9E914A4EE;
	Thu,  9 May 2024 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QiqUJwak"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EA914A605;
	Thu,  9 May 2024 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715246102; cv=fail; b=SQhfP8w9uc0pFN5mQ6uTHeyiCP3/b/ME8yA9Std98aMQ/AjcVrSI+WdJU+XZYX7m6JvHi4/QOK6m8as7tZQdhy5q8BKpT5L1lMxuA23+eaDltqa+BLPfEDVth+HvPSxRVo3xdHdroEG7yNN5IQOJb+LjIVq6+OtwA45HeURdCI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715246102; c=relaxed/simple;
	bh=fFpaaihJ5eXCJREoDZ5Miyfd/fZBe7XmFuuFxtDFTwY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LYdh8BmmADsAgZezs0/p+nRq263SYFZuisDTkW60eKwbi7s1MXGkqKM04beZjcIpG1fJgfrEVGQS+LbuUO6FS3Z59OjVnvRTcCBLHx3isJ7Na5vVapkOPHV4mTaVuQFVpddlxJEY7k79lg+WbZl7teyyyB5pD1Uq52dvaAv1MZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QiqUJwak; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AENMI8P+VcTZIesRDRHIbPS2+NKKfdPBW5okp5dVMvL34vQhnO/4DThOOpjDTLUa+do1jlu7+U3x60bQtrwLWQoSG9DM0/ETCPnaEYX+EjNpyIiWcAFMBfrfrHZ+kf2FxtcpBfARjSP+NUL75ipEO6Qvx995Irgs/plPrekwS1kAPq4lOrPFgZu8ICdnWsWq8/QDzuAFFdFAZKDy9iouzH+XkISZHmYNmU2q2J0jDMeuGOl9TbxE+Z2xRYwihUV49TY+JIOemQ7lc44RRI57jV6X+jjKqmSdN4ohPqq+FYbuj8/fuqz+dX70j5y8nn1qhgdk99q5VEvOD7+06Z9LRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vf9eGtvlozndl5YLaoHcmvMP/bVAiPZz4DjJyGQgKvk=;
 b=jEGdnv31L6N73bqXIrtOId5jZQYwlycZJvEj5/OKBfasLUAUK/tiz7gexpjLQLYcRWGigEU4cynaKAsQfxz6OHswvqSbESIbyZwnIxCF8imd0C22Du3hCQ7+zdmBvs0ajj2+zxZ4o4gAWFr/6ofUyirJDOu5eiz6IBRkmUp3NTy8FkUn7GiXHArYPuVvkoB2sfOj0v198aNCmRVKztO9EIIxXLqEnpp2oBaINAgCo0pssARiHbdXyrBL46e+CCiaA6eBkdGTYsHnhCvc7vOgSpEQlrVvsq74ktgurDTaXT6rcOctQ8hEPykzClfUh6QI6obD+IstuiZKMhXj9mUlnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vf9eGtvlozndl5YLaoHcmvMP/bVAiPZz4DjJyGQgKvk=;
 b=QiqUJwakldtSR6CnnlCNdCE+NOQF2m/J8FlbFtWEOHpOc4xIdaGktBNII55YjxhWGTSWUUgc4vmEIVjg46px6mDEKIAtz7eT0/jR31HMf6tCikU08lfePFUMWRZQJJ3TKp5Y9Z/+6A3hQ3mZAdVyEYqdTpDq0GtHMfFuxpIQe4pi62j6MXh6Omo4BZ+2bIqQ3ZDZyHADYrp4Z8SUpq9Gmlgv/dq3nS5nq94YP7SAwOD/vXzzS8fWfcvSz8jLGf5QxerSihgGm5RI2Ngk0ORYVpDMHBjmT9LT8DW9fK1cn8YFsvlXE95ZnNH+HSX+zzWio3epqFjPhPUXiaCAs9XhCA==
Received: from PH7P220CA0108.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::27)
 by DS0PR12MB8563.namprd12.prod.outlook.com (2603:10b6:8:165::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 09:14:56 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::fc) by PH7P220CA0108.outlook.office365.com
 (2603:10b6:510:32d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48 via Frontend
 Transport; Thu, 9 May 2024 09:14:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 09:14:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 02:14:33 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 9 May 2024 02:14:29 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net-next v4 0/2] Introduce auxiliary bus IRQs sysfs
Date: Thu, 9 May 2024 12:14:09 +0300
Message-ID: <20240509091411.627775-1-shayd@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DS0PR12MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e2c277d-97e9-4d60-dd7f-08dc70087e49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|7416005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iexfejynWKoGe3ViyMmi6Z3IA7Gg2Rv7YxZwQuK2dGe8TH/imUAvW/gpu/ox?=
 =?us-ascii?Q?Xt01z3qkXSmOb5o7Ou7OlS3rgfcjWxWi7vGEfhqf71GGpZbXxvIDh/eh4jl8?=
 =?us-ascii?Q?3sJCk3MEWfFWxnrqOF3/c42n+JkwpzuEscYwyC9PHVGN0dQ4eaiBXQdCsAv0?=
 =?us-ascii?Q?nle7K/MAUnELtQcfj0AjBooOTgePZSOLJmBKx9ifcre2ArmhKIo/RlEaLm0h?=
 =?us-ascii?Q?rvSfRjY9VJGls4AwLE8nbFBMcdSr+t2UeIv6lTzWbSzaa+c/JgZqd+D3NGzO?=
 =?us-ascii?Q?HP2d6pJBs6ATxYSDyroLijxb/ouSTRtiruryI1YIkIoSxWXcCtYONTT0t63x?=
 =?us-ascii?Q?H5tZwbjqrNh8s+9rGQLzeJJKLVG4vOoYmyANphgTIpyNsey9HHRqaqZjYIH/?=
 =?us-ascii?Q?E5MzdIwC17hvLn2BtYKS8ziv4ElOVqq1np+qF7wqR4Ye8IRPI6rMlGz5vRaH?=
 =?us-ascii?Q?WpbGo+1z3/8la8CanOouceKWm2F/nmujGM267bYq7ezTxixU8VhgRCNaRFrl?=
 =?us-ascii?Q?BrykeW/QOsh2GCut0C+JseUvMQDnQIAa7nrGHibjNUqBJCaXQSzPjZ+N9fos?=
 =?us-ascii?Q?OpUDYApU6mkDQ87kf7uhvsAyesr9N6WtLtBuS6aCW0DJn95hfS2dvNkPlcgV?=
 =?us-ascii?Q?0AyO5N8pfG2eiV1ZqSrVAwkBvPoEsfFdTt1E8x09mGt2B56CaCRGHyIkemAJ?=
 =?us-ascii?Q?SdJiP5rSvaBQi4dRVigIUFQ3BB1TwYqiIY17N+sou2VyFOECixbZUHdmeSmV?=
 =?us-ascii?Q?5IxR//ykGogUfhargyCGDFfBwpbHiH64rLkIXbhfMWVeH0DR1f7NfTGNF+pz?=
 =?us-ascii?Q?gCj2UQ/QRixu366pS+4rQSDVqr5FOSITmpi/n00sN/RFFqpO9Urc9dw+ZInX?=
 =?us-ascii?Q?EfRODqNI88h1rf/nuhh2LgWEeHY+2tR9F4ZlU+f0KRbitWn0W1T8cw91Ae32?=
 =?us-ascii?Q?nvJwDnVUWtrC9hNLw3ovSRI/W5LjMZx+wNORnHwPQIlRWMEdYCTIsvIauL9S?=
 =?us-ascii?Q?MKtHvP/ZoNHtWJvYhX98Rkw1Zhn7sZvNMfWtxaOud3LMAyduAQtNquI2cxUb?=
 =?us-ascii?Q?CjTx9K/smilr1oinSNjWJBfravUU9KNvuuPQlcu7XPezFBEsXgIz5pI3RoZB?=
 =?us-ascii?Q?AddPAwHQ8o0+fC2C7XnHmYnwuCWV99MfE4mwCCViItM2DZ/VypJhldSE91b9?=
 =?us-ascii?Q?6M+NC/zPenTDzbNuL0/06AOZPZ9SKi9cXzCIajrpGAMQBf0lBg8YQwHxeKyw?=
 =?us-ascii?Q?jGhB30sgmsdQQBxvJPcuu55gXGYxL70MFPKKBrc9XpnUBAOdZcf78bbv9xG4?=
 =?us-ascii?Q?TZUOg3bmitVuXicLMl7vJHPkD4paNaaGd5hsV21AXXLE3SYq/d0yaTDwUgJF?=
 =?us-ascii?Q?/+Fw6Lo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(7416005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 09:14:55.9180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2c277d-97e9-4d60-dd7f-08dc70087e49
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563

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


