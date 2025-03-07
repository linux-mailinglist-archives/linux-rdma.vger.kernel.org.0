Return-Path: <linux-rdma+bounces-8480-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADA5A570D5
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 19:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1510B3B9216
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 18:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C062459F2;
	Fri,  7 Mar 2025 18:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BTQivLul"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C4B19DF4A;
	Fri,  7 Mar 2025 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741373639; cv=fail; b=sikQiCw0BjrpBJX5X6DdK3Fv06gKlMkNiFby2XLVUuI/f5TbIZlCOgkgUO83v0l4Tf4Iaar3j0maxTGxZN4mOWsSko6aercInyoiR+7XT1I9ffZElfkiiBHKh6iC8QInqMgNaw6wQ2eup+oa3aDxvj845Q9cMHhjnMj1pGme5DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741373639; c=relaxed/simple;
	bh=F4dFYbZROZ+xS1+oKnJlZ3i9zJanZNCn1KHnD6AqBMc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PjGbtbsw50xDASACYwfwPZoa5lM9x+kYExtP+bP2KiyrISoWD0JC+7pKNYi7kuEb/+f9xqND+lI1rNkr2Ze1C5mZFZ3kQyCYefezQF9wVEx5z8JtGUxIC41hsmTe7AlWGax6X0CGEagCp5h2ncSN0csz8pnW8jEox0drK2gAdBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BTQivLul; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=befS2slt8c8QnQMJ8raRC5sNFPisMD6argpn2V9ED0UovxbAd0r+1P5J3wmQF0Nm8iEJtqPUy0nEde61ilzQhowMxgo3EOzk/jldldCynk3IPB75jarpVl1C0OpcZ93sz8y099RUfBb6P1ZJBPX9BM9Mz0Eaz69aal/t5DXT14m+Sw2x2RqNeeTTKk7+23fQBm4HHqZ990iDaKkLw/Iaq0Od9fcj3GMslAJmGWP7NMM+mGaLSk0um2A8UKUlbNG2VKfJhXPZdt1UT0RorEI5ltWzSMHQCO5EsyGXNEcJSNwG+RbPk+zqPAUtxroKWNf3mm88N4zGVR4dmhDFQxYfWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qr970ZCY8SKZOjQc+A1Px4OqUai1JLQGZnGB/pL5rBg=;
 b=pHq3BcyAjL28adzeuBc5epVWMSg4hKMcejsecdCCz0qryRwqEBzKIE/h8Ak9PhaFUj06cH6sqmzuELEEyp5+g0gAWCQcGbtJMWJX8FNvsN/mfjBXqSScqM2jtaSx1xBcslODdNuoA0FPMvQbwGVWdFcMBYcu/2DKkJhg1iYhbPPUf+R6mZv5K6Piza4SzhxJcAm90YNk/w8wEQCFCKvvsUQTxF7UQHegU8j4sIExOUeM9ivfXpObm9CIlMSNYCAHSnlm3kDB3lrpLq8dUj15l7yJQ0tzB4m8YxGP5VnLCHOI7zethojDrYlZusDz/Ix2Nn8KqgEh8X+PGna32pSP6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qr970ZCY8SKZOjQc+A1Px4OqUai1JLQGZnGB/pL5rBg=;
 b=BTQivLulvqOWjr6AK02OW99P1kbjknrT8v42xzTcW071H+qJoqbpZ1Ns7xY50JICC0Ij9fkkegU8lftEfGdXK89pJkKZ5ldH/vqlk0cm4KkF89jiW2alJB1GUwHUJ7NP7oYGpH3mO+IvKHYb3GdU6T9m6+mRxb4CAJ+4jHqQDWc=
Received: from BL1PR13CA0301.namprd13.prod.outlook.com (2603:10b6:208:2c1::6)
 by SJ5PPFD5E8DE351.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Fri, 7 Mar
 2025 18:53:52 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::9c) by BL1PR13CA0301.outlook.office365.com
 (2603:10b6:208:2c1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.11 via Frontend Transport; Fri,
 7 Mar 2025 18:53:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 18:53:51 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 12:53:50 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v3 0/6] pds_fwctl: fwctl for AMD/Pensando core devices
Date: Fri, 7 Mar 2025 10:53:23 -0800
Message-ID: <20250307185329.35034-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|SJ5PPFD5E8DE351:EE_
X-MS-Office365-Filtering-Correlation-Id: 40382e42-391b-4e2b-a858-08dd5da9672a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|921020|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kVPtwKWmSS9XLekWqmr/Qg64jHImdFmmIbKpm5TGGhypm7DibIlrsirbD2J9?=
 =?us-ascii?Q?aLJxKub4dIg9XEMTdgV6NswMWYYCumXlkiK5QgjruWHm5a8og+/Zj31Dh0z2?=
 =?us-ascii?Q?EaL5oWwuUi/qYtpZBmZ0/1GBwUM/1xqv7yk2cTdNsXCAi8KW9TizLT2iN4K/?=
 =?us-ascii?Q?soR53f9K1j9wLaFCMDNy/b2hJrboB3/UGBtejD3Pp0Wf94rheLqoX3p5RDsX?=
 =?us-ascii?Q?mxLJe1xzR0cYo8xInfyjE4FSjYQK5rDBPJ+zj8BioCt3W0UXdF64W1J/I+mx?=
 =?us-ascii?Q?Ds3eNoiPqhIaiEHYwnBawL1fo6UI6WG4dBviI2IlNFICNijB+xa5u+xKuKo6?=
 =?us-ascii?Q?B98fZwfMyNSSf26As9esaKrzfyiwW1dzSvdy2e3P5PHzRZRlZwUBO6h9fkhA?=
 =?us-ascii?Q?PxS4AhwrzwZvWFQwPWVaLDB7rLIauHWmVNkuBfAEY2+6ZF+j052kguIKBlBt?=
 =?us-ascii?Q?ywsm9/T13XGzAbDK1j9qPIe3ayJMnaHJbe1lSnUm9WIR6rkQ3cFInXFQQofe?=
 =?us-ascii?Q?sxPh+Ps1O0uheOnwnSqnqH0VVhSWHdPnvLUB3xRo1TiZLV/WRQV5k22L9Rrs?=
 =?us-ascii?Q?JMqcZNjcW+LRtzIWtzqYJ/hgwDAsWKtxlb74t+09rud2xxS7C8z0UJq/Kxy0?=
 =?us-ascii?Q?AcLWnqThF8yZ/TEnz/AKbiFbI9vz6NACD01f+SZ3f4K2/pLShiiKxE5KHAJr?=
 =?us-ascii?Q?/WjZXD6PluFOp/h9USr40WKNRpDFUeah0By4M6zxRzvV+0ZK20+5Hdmii4Sy?=
 =?us-ascii?Q?VEalUu21XX544fm1pbvt8a9sfnDV19iHnytEU3YULvBwvO7JdcLtoIpEu7nm?=
 =?us-ascii?Q?EbRH47R8UiJUjOpJR9XWzD+m0uKTnjAEK7GohBIkhROweSeBUfBJfDFA71VB?=
 =?us-ascii?Q?VyqAo/NUTQf03NxvD4MyW74V3UO1HDMnukpnWakJ6E/KZxQQKEGgsc6UDOr6?=
 =?us-ascii?Q?8AOT+iZhScxMQSACzvWRhoHlwgsLRWcaafR1xKrEsi6yOo1Kl0iFqaNL77wU?=
 =?us-ascii?Q?kh5FwbT1rljZacjDt+VhvS9XOAVDShuuqPo8emtZlFjy/7TKkaYpwKlR24vd?=
 =?us-ascii?Q?Z6ocdI3+zpnInFe9NfKvJsaZudGoJmCi0JAIDjqU7xVCNgcu04/nUwHz+u5z?=
 =?us-ascii?Q?GHwcOqwe96DBZ08IY9JEFnCuTPnZnTonvtsc3umx6NkK+EZ+rocyTTwil89D?=
 =?us-ascii?Q?d7aWW98nYmnBrFTcTtO1MuIWiHfPFnvvWX8wVnbS+aKAfpgGwmDhVg4DqcQz?=
 =?us-ascii?Q?5qK1trTBYoAyxjx+as3h6GKnKqdu9wxHRL+zq01uzFcfa7+uLeeYLXjxz4O9?=
 =?us-ascii?Q?W7cSdcDCgVflryIERS/s6O6cjoe8yzpnwJFwMCxSU5xyiiNo8T92shCI9BvB?=
 =?us-ascii?Q?riPDfbyybSl2hLJbjwYStQ7nx/GHTVxoYxxiT5Pcu/6xGu23ey7r3Q3b/it2?=
 =?us-ascii?Q?vkdCMpHYpPkx5hyrk0PfJTurYfskKBkuzabVUQVGDTFzYN6cSXsuvtBkewuJ?=
 =?us-ascii?Q?2qbu73MYGeo4IMRbFh//ca002NdTjIZhNP1Y?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(921020)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 18:53:51.7714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40382e42-391b-4e2b-a858-08dd5da9672a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD5E8DE351

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

v3: Lots of little cleaning tweaks (no changes to patch 1 and 2)
  - rebase on Jason's tree
  - better comment on "an error if there is no auxbus device support" (Jonathan)
  - don't call pdsc_auxbus_dev_del() if pdsc_auxbus_dev_add() failed (Jonathan)
  - struct pdsc *pdsc; is unnecessary in struct pdsfc_dev (Jonathan)
  - remove unused UID field in pdsfc_info (Jonathan, Jason)
  - change "Word boundary padding" to "Reserved" (Jonathan)
  - remove the remaining use of cleanup pattern
  - don't lose err from pds_client_adminq_cmd() in pdsfc_identify() (Jason)
  - comment on pds_fwctl_ident.features (Jonathan)
  - change noisy dev_errs to dev_dbg and remove a couple unnecessary ones (Jonathan, Jason)
  - no cast needed on struct fwctl_rpc_pds *rpc = (struct fwctl_rpc_pds *)in (Jonathan)
  - more labels and reverse order for cleanup in pdsfc_fw_rpc  (Jonathan)
  - __counted_by_le() on struct pds_fwctl_query_data (Jonathan)
  - other comment comments on new structs (Jonathan)
  - use FIELD_GET (Jason)
  - Use __aligned_u64 in the uapi headers (Jason)
  - call fwctl a subsystem in Docs (Jonathan)
  - clean up text around endpoints in Docs (Jonathan)

v2: https://lore.kernel.org/netdev/20250301013554.49511-1-shannon.nelson@amd.com/
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
 .../userspace-api/fwctl/pds_fwctl.rst         |  40 ++
 MAINTAINERS                                   |   7 +
 drivers/fwctl/Kconfig                         |  10 +
 drivers/fwctl/Makefile                        |   1 +
 drivers/fwctl/pds/Makefile                    |   4 +
 drivers/fwctl/pds/main.c                      | 506 ++++++++++++++++++
 drivers/net/ethernet/amd/pds_core/auxbus.c    |  44 +-
 drivers/net/ethernet/amd/pds_core/core.c      |   7 +
 drivers/net/ethernet/amd/pds_core/core.h      |   8 +-
 drivers/net/ethernet/amd/pds_core/devlink.c   |   7 +-
 drivers/net/ethernet/amd/pds_core/main.c      |  25 +-
 include/linux/pds/pds_adminq.h                | 268 ++++++++++
 include/linux/pds/pds_common.h                |   2 +
 include/uapi/fwctl/fwctl.h                    |   1 +
 include/uapi/fwctl/pds.h                      |  42 ++
 17 files changed, 940 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/userspace-api/fwctl/pds_fwctl.rst
 create mode 100644 drivers/fwctl/pds/Makefile
 create mode 100644 drivers/fwctl/pds/main.c
 create mode 100644 include/uapi/fwctl/pds.h

-- 
2.17.1


