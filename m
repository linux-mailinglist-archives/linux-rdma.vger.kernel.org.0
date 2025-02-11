Return-Path: <linux-rdma+bounces-7660-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4CBA319DC
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 00:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFEFB1687C1
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2025 23:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF9226A1B1;
	Tue, 11 Feb 2025 23:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Isgx2YBC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D14E26B96B;
	Tue, 11 Feb 2025 23:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317765; cv=fail; b=oyUvBJsFF8wMqdud87KgesTf53qfDoq9ozz4LqA6jpqqo00xJ94fjEQZpxDbtxwaWL/qgLkyZFKCu3rMnk+hu6qTa0vqJZtRa0D3zOOyq1+EFXTXxdeGsNvsMkvAfrnQB0OowJSYmGsD6UMATkrZ7q6I1SjMb6CD4ImGapBRtCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317765; c=relaxed/simple;
	bh=l6J0CrgQ/AyZqNVt/SefLdkaWvD+ClaBm0154bzFsts=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ed7iUrmXlILihHquZbtTVWDuKYXAi1Jcvvlxqnk5rdO+lqMLAdm/2VHFt31wssJpP27eY7FT8Bdm8EvgoLy72icDitVtY8PNXnMsBw5Dtrj5r3ZsWfrXDnvzoMiVbBldWDy6T1YHxHbvS+DkNgKGXnej85sbk0vOHSROxhTcWn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Isgx2YBC; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmuf133PJwqG5u076HC/Q7XOaV8gfQadJeSkJqWqklg4gva7wB25Pb0BU96ntoatb5l6R501JciwiBsvrSeWxmaumTgilvBXSvZi60tp5oG1bLmRl4v/y2FwEHWp9Y3JmHk5i4b/HB87iBKQ58UUKDzgT83q5o93Ze1jh+c+9XOnRFDPjreEAFO8JGg3CK4lZMypip8g7FlX8T94cueyIQKQsZm5kRzjEy15H14OaP5rLiBMuCiqlfpMf2KI6sFNIFFvkLXW36q4K8yvM293rBob6kMUxQjtnND5cuP2hQKV49QAQ9JKLVCWUdtQzwRLpX60TJfmLW2CgkD2lR4PXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qw7qFxCV3mE2Hx5t3tQhcgdznqsutn6eFnz4LHZiaUI=;
 b=kUfm4XYH3J8zP/Q+Eu6yX4+JG2OiJvImCiHbOb4TXgzJ6FVlsKpIuNiKBmj/TfYCAfkjE2UQq6/sjBlxR4YP5GHqynmuxFZ5PtDDwy+cJv0HX21LUUnHk7emgT0LBE4LbcYaT7qafFldcfvXG/kzcA2P4NlZ28OuecHUJ8ktq7Z1QJv05eQ+Y0msm/vLDJ9NA7nLFpu2kwokmLcAFpqv3x0rFTmwDkplCJ2Q8ZSfIfxaYrMJmhAvoCSSXn/BHDRgVwTSNB4to3m2aMxM4ze9l8DKZrwr3Lu02RLWokKrjXDcRumagLLKuZXbMTeBAzR0aMjLQj657GYmh5qcZdT9lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qw7qFxCV3mE2Hx5t3tQhcgdznqsutn6eFnz4LHZiaUI=;
 b=Isgx2YBCxQ4DkKumgwfn2MFO8Zw+E94rIzmNuFWPTlbMxq1gfXwokq8qJkaHocWMZvoJSImX0tk57q/h3KDdRMw/9eBVUN6AbMXq4RBW3ulIpiriK6wjx67biF8qfIMsMvGhWVMZlQeBU3L1yM9f5deZTQH+qOXsfJ05gj40L2Q=
Received: from MW4P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::10)
 by PH0PR12MB7485.namprd12.prod.outlook.com (2603:10b6:510:1e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 23:49:13 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::9f) by MW4P222CA0005.outlook.office365.com
 (2603:10b6:303:114::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 23:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 23:49:12 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 17:49:09 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gospo@broadcom.com>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <saeedm@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [RFC PATCH fwctl 0/5] pds_fwctl: fwctl for AMD/Pensando core devices
Date: Tue, 11 Feb 2025 15:48:49 -0800
Message-ID: <20250211234854.52277-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|PH0PR12MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 467f9783-b40e-4196-e56f-08dd4af6afd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013|921020|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?amB3ZPO6pwfQIknjSrDu8hRcbuhTeLDsYmO3GL+wQIwrD8gE5kLQBMbS8syS?=
 =?us-ascii?Q?+mWQAMND1/FLJoWCUeACvM+T2Ibh2f4Rjmmpe7NmziKIRfOM85IPg4Q3ZZXy?=
 =?us-ascii?Q?9j5Mw7QRSMyIRfHJRvUqBy7zQVzf0b8EZCubMklPjnE6DShBg4usJn14jcJp?=
 =?us-ascii?Q?K00iLk9er4tfXeIcp33oJt+u/98sfHbgzTQFPSWvv3px3k83Nf8ePQuQMoTB?=
 =?us-ascii?Q?zRfsZDuf48valkqpldk9F2BdhKQQ94YeDYLqOuc3QfHW38X4jNEZbnQjsVXt?=
 =?us-ascii?Q?/xuZMIFmDcgk4GufmrwslaJW9iSjj8Os21nq8uqzHZ8UDCnp8hxT6ZP/bgpH?=
 =?us-ascii?Q?gYPCRVNMTWVWwoxx95QiasE0nhB+nTtYByqF8+8teBXz2xpXFSN5gsxJPt66?=
 =?us-ascii?Q?3f2xbwPpuio03zeDDT0c2Bz30TqGbQdCksrc1j54dYopw5A/DVkzkDCzfwLC?=
 =?us-ascii?Q?UQF4JrLcxtfhqXqtY7Gp/Ia3y7vOcEKrFrf5OyBHwgzA44gwW789dvWVtlQs?=
 =?us-ascii?Q?WFu+02gEXL6FDT9UeMQ/h11ye/5urzOe/LwPDD0fLRNoqs2UZeGBo4rgbpvL?=
 =?us-ascii?Q?Egj5M0D4zKxCp+lbNjwOR+YVd6R3PBEok9H6F1zE5SpNtOBOTyM5LKxc/5JU?=
 =?us-ascii?Q?SA1ImYthAWYbOQre0HpkwFQEDLU43uXGOfbZXpBUd3ok/S5jJf9XJQ6ItCBf?=
 =?us-ascii?Q?9tuPC0P983Fwzh82lUmUHCLJMJGXMgob4dOANIWGkz8COZhjuI7hnMdERxyR?=
 =?us-ascii?Q?NooorQhOkGqtOOcByXQZHelitKn6I4UpjDie1wWZ5/n1wReOLMVVGLjfe744?=
 =?us-ascii?Q?Bkwb0LOil+Svyu91UBCJIN0SShfsev0o3map3KSjGWp8yOmFFHBhPoKyrKbj?=
 =?us-ascii?Q?l1PhDJOOOWucYfU0YwECIq4FCbS7kpmMU2W2gfR/9pUWXZj7foEmCS7jYFof?=
 =?us-ascii?Q?jQqWXaqzlmmkzSRYyXTuEsn1lkZuoCIPFiaz0jYGTEvRpIol5fcmNQUEcrdu?=
 =?us-ascii?Q?sPzH1WAT6tYB/f20hMKKDQ+9RtRhisyCVnaUwRf71kWlilRm7ZODqnA7vBtu?=
 =?us-ascii?Q?SJaFcIvWL4jYffUym6jWss4my2tyafeg5yJagKVJTjKpVkjk7HejGxHdyshV?=
 =?us-ascii?Q?lxVchcJWzPyGpXtukRQgqD/tR2BtrLUwxIl455+xCi8pjXdGf5uVJMkTl0vh?=
 =?us-ascii?Q?hQph/KCRQIBlDZJgjtUNs3vecdSEm4LgLIV2jjop5/OIZOHWNCPl2kcvch6V?=
 =?us-ascii?Q?kxg8X8DFUdVJ7D43C12nLxvtwQGK3e+Cxu0IFw/NvmEN5W3uPYJxi2exhoSA?=
 =?us-ascii?Q?qiwzrhVWgptxvYP7UKm3gs5vv+1HHEecNAhrk3y85/9KtUr3ZPtcl89zxCZK?=
 =?us-ascii?Q?/kJcBmGVw9804unmPDONjWjosZKOBG/AKaTtNyW7RZ4VTedbV9OyhiAhWuTN?=
 =?us-ascii?Q?UCTXUrA8+ebJpsnn5GrWkroWm4B+XTC9RHA3RPDY/JS+iaxIW+Qe7YU/RrKs?=
 =?us-ascii?Q?vlst/sqmsy+ccTZxHWZB46ehf43X05ek2fFJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013)(921020)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 23:49:12.7397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 467f9783-b40e-4196-e56f-08dd4af6afd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7485

Following along from Jason's work [1] we have our initial RFC patchset
for pds_fwctl - an auxiliary_bus driver for supporting fwctl through the
pds_core driver and its PDS core device.

The PDS core is PCI device that is separate and distinct from the
ionic Eth device and from the other PCI devices that can be supported
by the AMD/Pensando DSC.  It is used by pds_vdpa and pds_vfio_pci to
coordinate/communicate with the FW for setting up their services.

Until now the DSC's basic configurations for defining what devices to
support and for getting low-level device debug information have been
through internal commands not available from the host side, requiring
access into the DSC's own OS.  Adding the fwctl service allows us to start
bringing these capabilities up into the host, but they don't replace the
existing function-specific tools.  For example, these are things that make
the Eth PCI device appear on the PCI bus, while the tuning of the specific
Eth features still go through the standard ethtool/devlink/ip/etc tools.

The first two patches add a new pds_core.fwctl auxiliary_device to the
pds_core driver.  This is only supported by the pds_core PF and not on
any VFs.

The remaining patches add the pds_fwctl driver framework and then fill
in the details for the fwctl services.

[1] https://lore.kernel.org/netdev/0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com/
    [PATCH v4 00/10] Introduce fwctl subystem

Brett Creeley (1):
  pds_fwctl: add rpc and query support

Shannon Nelson (4):
  pds_core: specify auxiliary_device to be created
  pds_core: add new fwctl auxilary_device
  pds_fwctl: initial driver framework
  pds_fwctl: add Documentation entries

 Documentation/userspace-api/fwctl/fwctl.rst   |   1 +
 Documentation/userspace-api/fwctl/index.rst   |   1 +
 .../userspace-api/fwctl/pds_fwctl.rst         |  41 ++
 MAINTAINERS                                   |   7 +
 drivers/fwctl/Kconfig                         |  10 +
 drivers/fwctl/Makefile                        |   1 +
 drivers/fwctl/pds/Makefile                    |   4 +
 drivers/fwctl/pds/main.c                      | 558 ++++++++++++++++++
 drivers/net/ethernet/amd/pds_core/auxbus.c    |  44 +-
 drivers/net/ethernet/amd/pds_core/core.c      |   7 +
 drivers/net/ethernet/amd/pds_core/core.h      |   8 +-
 drivers/net/ethernet/amd/pds_core/devlink.c   |   6 +-
 drivers/net/ethernet/amd/pds_core/main.c      |  21 +-
 include/linux/pds/pds_adminq.h                | 264 +++++++++
 include/linux/pds/pds_common.h                |   2 +
 include/uapi/fwctl/fwctl.h                    |   1 +
 include/uapi/fwctl/pds.h                      |  43 ++
 17 files changed, 988 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/userspace-api/fwctl/pds_fwctl.rst
 create mode 100644 drivers/fwctl/pds/Makefile
 create mode 100644 drivers/fwctl/pds/main.c
 create mode 100644 include/uapi/fwctl/pds.h

-- 
2.17.1


