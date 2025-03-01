Return-Path: <linux-rdma+bounces-8215-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E42CA4A77A
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Mar 2025 02:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E1C3A35CC
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Mar 2025 01:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D414B22318;
	Sat,  1 Mar 2025 01:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="twnF0dWX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FF4B676;
	Sat,  1 Mar 2025 01:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740793026; cv=fail; b=D57vAmhn3AX8SOB99w65cJMxkxDw7cxNuOktjmjdpTGEY4hH1ptg9nRrzuzn22nJCuWm+JZ7jOtU2OLgk5wAjD9kGQwI0kd8G9EUooMbPfhwLR4wIwFcG7AElIjEnlh9+2GlsuJh48itN45KycyjN4gB+GJcjaBXcWdJXJncy1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740793026; c=relaxed/simple;
	bh=PQ1P/e+fbWvHZXE+tJ0AYzdTpu3zDSu/5TrAa8cVkX0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kbXkJ/SrC7itFmMn+hBedEZDQTWOmPgy3GzgQhYSAxfumdjej49kKrc8Cjsf1vsnhO+fu7FyPsyDEqogK8wq/hI5Ub/GzfIfXuecArvcFNNM9LNy8VhUk8ckbNf2LapgTl2Ej6Yp5OrtTU0QN04SC8z/J3SPVdIwUePilaDB1G8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=twnF0dWX; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQCVCsJs9hx/N6g/+OTst4T+NZjleJbkIKfoSXelXmBIAqLcym0FHxRBG1MUO+xZkAHb86h5waHp+ufhGRHCSKZcBIz98pqlhUQ+t16S/JtkPYMB0ezG7X/b37kvgGcsC8ScTpce8M272agGUb3ury+vkkmWyt40hXU6efeGReNf2b2N69AMjbcTi1qi6M6irl1lhlEXGvZNBNLRFdc1j0LFKcyQKRxmEOkUSqh1v0nhu6Es+lx8xb9Ygi5DwS3YnFHY2qHbz0aTVAEVR8BGlOlQV1tBL1CabQ5aVZDqVxcXK8es5jL1x6YGGMnnX4+1ZgbbwB4v1gJp6vrgMQDqkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwsMr9MsDGigc2TYytBKS6iFI3e2qnPZ7SHesamLUGU=;
 b=B5ZeqPrqDmGDRFh6HM/RAtfu1yU0m/yNNMlKHckFFc318HE394L8wlvWMOIxE4HqBsDJSHYLauJ/Gcv6ehZ9dq+5KsrVlBjedDqRErblAlfyVg/OJyd0Dw8gR4ImJmNLo7VIvBurT/uePaeZIt+sz2kHcU8yBFZYv79al3lXCCOLRfbLJsj7vjFwIKpckPkq8G7y3ZdebuQ1wXKEiKPwnbIjXUotiZv0jzGaCoBxG/L7rwNlN05oSQYw5PZgzUffmfVJaaf9fULnwzDGpqACO7b7VSqxgYaxHeGgPxLcP4rV/6Lv1PF+ZOAMxLZPTCaHG0QOexcov5J75m/4t+Ybiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwsMr9MsDGigc2TYytBKS6iFI3e2qnPZ7SHesamLUGU=;
 b=twnF0dWX8RlgysmFWy+W480nCTqIfRC88Hy5k8w3a8QP9p+W4HQ/nM7tLfz2Z9gZSj/njsUjfzzav9vMbr7Ky+ydb3jKVsWGHvoVGd7USavZXLQyJksLp/1DNPGDHACoFc9t7vi538xdXjtFPNhsd4qN4lkuSRfivqUl8z/v/iE=
Received: from BYAPR06CA0013.namprd06.prod.outlook.com (2603:10b6:a03:d4::26)
 by DS0PR12MB8787.namprd12.prod.outlook.com (2603:10b6:8:14e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sat, 1 Mar
 2025 01:37:01 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::23) by BYAPR06CA0013.outlook.office365.com
 (2603:10b6:a03:d4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Sat,
 1 Mar 2025 01:37:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Sat, 1 Mar 2025 01:37:00 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 19:36:58 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 0/6] pds_fwctl: fwctl for AMD/Pensando core devices
Date: Fri, 28 Feb 2025 17:35:48 -0800
Message-ID: <20250301013554.49511-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|DS0PR12MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d2991cf-6b94-4ab5-fbca-08dd58618ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|921020|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T3ADpAyshbTfVqX0NJP65X9snWhfa8u1Sc8Ov/+fPW8OwqX0N5oZ7pCdNDbc?=
 =?us-ascii?Q?AoAv7/9ZOwKvOywvZ8s/IWGm0mL+EcMvV25GhoBibuKJL5aC3/KB+yu4EdY+?=
 =?us-ascii?Q?ZSWOtZFs5bRZzdFcNa0v2OrY6hvFmwnv+7i8MgAeKu2YNdgPstcSrOwlT8sT?=
 =?us-ascii?Q?kgR1i6jcZrw5hRcp12q/7YuurZ1TdQef+5jpDezVY6NPML2L/dt7xai+NdVV?=
 =?us-ascii?Q?dso18rkd2DP/WcacLXGiBrNNHjEaUiCJmowkaCe3UhH371uKUIqIvB/ciudO?=
 =?us-ascii?Q?YtVuMKXHw5LjSwid4nopX+szWzvwPOdscXSYfCK0zN+SQhHKt8QJ8QM3Bkwt?=
 =?us-ascii?Q?vchhIOgMUmoSqdOcnW4SXIAMUzx5+cDt4FXaXxluG5cZQ79wNTmlRyQLDH5B?=
 =?us-ascii?Q?iSrEoH5DYT5JbGU8fHgLcw30Q0kj1rIpd0UicpsPmhqUesXQ2Y3h/fd+x+Rd?=
 =?us-ascii?Q?Lo6irE3tCRRp5P22+0jCCrhQPAuya5/7dJplGP6rxrgYZKhbazrWLFvgvR0C?=
 =?us-ascii?Q?GZwmmELzDpHIXC2zA2txpFGgOn95cii4gqIOmqj3HMfL9NeiHGRXBgqYno+5?=
 =?us-ascii?Q?tsqRQIxDZYt1V+/bnIQfMeouaHHeLZi7owvWkrwv11gktbh/2PT66Ikawylt?=
 =?us-ascii?Q?oLOJzyZkWNur25yRbvD1Le11AfbbpuEER4hZ95+9wX9Nj4UdG/kWDBVyiuYk?=
 =?us-ascii?Q?ObFOcbssKYQPrJE57prdda6UmD+diMbBkjA2gmzH3M2nJfsMw6+E3RmxoVEb?=
 =?us-ascii?Q?M6PpUC8xs+UwqN8s6LptxvxMiXSnrFIV6N/Py9SMpFWhV3/ZOererL5UdAZR?=
 =?us-ascii?Q?jduK9HyvKbgGtIJd0qelxWJ92WzAJXLS8t3StoNN9YhBLSQpv0y5/wc338DB?=
 =?us-ascii?Q?2U6neOJJ2nwp/6F+J8nTJ3lIDG4nU3wQ+H9jHzrT1EumOjgcSjrRNTT1AvfL?=
 =?us-ascii?Q?WBlS3dI30VERa9AAyEJkkOvpMXV8cMz2lK6Jqysp5ZFSEgQY3OPOjOU3huy/?=
 =?us-ascii?Q?s+VrLEFvoLkEePzsY6MKzaSjlOVkjSmpNb+vSPJ/3+WbETFGsPyccryVu1z0?=
 =?us-ascii?Q?HkMD+EEEORZVKFw90W6DSGAWLpTt8PqNbJXibRuGBl10M1hPdm1Fwfq6kL+R?=
 =?us-ascii?Q?EuE6dED7fG0juHAP8md/0k/FgXJHtGPSy6z4VobpABvGq6UUshli/CRYbnrP?=
 =?us-ascii?Q?ihgXAaxaRJGnmgCDYidHHVuWbkRkduJ0mcEEE8jMu0y9fYCO/AEZYyFCUJ99?=
 =?us-ascii?Q?zEsfkH95EfmDUZxLDDOoBX6qi8FvmEsm1rzmsRRTIickFYMs72INQ8s+Axfh?=
 =?us-ascii?Q?PpIjyUpvPNNs+Z+pUVpsczfI6MVxeqd/3jB37RIpyYi67u+i8/cWyIWToArI?=
 =?us-ascii?Q?f0tNbYN/5s6rTqj64YCVb4gD1ZYG1QhP3GzF6iWsjgKMaTFOGbLIAdlQ8N3I?=
 =?us-ascii?Q?Img1Dd6jayYcPNdNH4Vz7Y8vBl85lSu3Kg/fH81r93SrpJZPgZWuTXHKDkTD?=
 =?us-ascii?Q?CtWc4NIvCPuYOKShsQe+t8EFJmb+3J2v8GRu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(921020)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2025 01:37:00.5709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2991cf-6b94-4ab5-fbca-08dd58618ffc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8787

Following along from Jason's work [1] we have our initial patchset
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

The first two patches are a bit of clean up for pds_core's add and delete
of auxiliary_devices.  Those are followed by a patch to add the new
pds_core.fwctl auxiliary_device.  This is only supported by the pds_core
PF and not on any VFs.

The remaining patches add the pds_fwctl driver framework and then fill
in the details for the fwctl services.

[1] https://lore.kernel.org/netdev/0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com/

v2:
  - removed the RFC tag
  - add a patch to make pdsc_auxbus_dev_del() a void type (Jonathan)
  - fix up error handling if pdsc_auxbus_dev_add() fails in probe (Jonathan)
  - fix auxiliary spelling in commit subject header (Jonathan)
  - clean up of code around use of __free() gizmo (Jonathan, David)
  - removed extra whitespace and dev_xxx() calls (Leon)
  - copy ident info from DMA and release DMA memory in probe (Jonathan)
  - use dev_err_probe() (Jonathan)
  - add counted_by_le(num_entries) (Jonathan, David)
  - convert num_entries from __le32 to host in get_endpoints() (Jonathan)
  - remove unnecessary variable inits (Jonathan, Leon)

v1: https://lore.kernel.org/netdev/20250211234854.52277-1-shannon.nelson@amd.com/

Brett Creeley (1):
  pds_fwctl: add rpc and query support

Shannon Nelson (5):
  pds_core: make pdsc_auxbus_dev_del() void
  pds_core: specify auxiliary_device to be created
  pds_core: add new fwctl auxiliary_device
  pds_fwctl: initial driver framework
  pds_fwctl: add Documentation entries

 Documentation/userspace-api/fwctl/fwctl.rst   |   1 +
 Documentation/userspace-api/fwctl/index.rst   |   1 +
 .../userspace-api/fwctl/pds_fwctl.rst         |  41 ++
 MAINTAINERS                                   |   7 +
 drivers/fwctl/Kconfig                         |  10 +
 drivers/fwctl/Makefile                        |   1 +
 drivers/fwctl/pds/Makefile                    |   4 +
 drivers/fwctl/pds/main.c                      | 506 ++++++++++++++++++
 drivers/net/ethernet/amd/pds_core/auxbus.c    |  44 +-
 drivers/net/ethernet/amd/pds_core/core.c      |   7 +
 drivers/net/ethernet/amd/pds_core/core.h      |   8 +-
 drivers/net/ethernet/amd/pds_core/devlink.c   |   7 +-
 drivers/net/ethernet/amd/pds_core/main.c      |  22 +-
 include/linux/pds/pds_adminq.h                | 264 +++++++++
 include/linux/pds/pds_common.h                |   2 +
 include/uapi/fwctl/fwctl.h                    |   1 +
 include/uapi/fwctl/pds.h                      |  43 ++
 17 files changed, 936 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/userspace-api/fwctl/pds_fwctl.rst
 create mode 100644 drivers/fwctl/pds/Makefile
 create mode 100644 drivers/fwctl/pds/main.c
 create mode 100644 include/uapi/fwctl/pds.h

-- 
2.17.1


