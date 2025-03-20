Return-Path: <linux-rdma+bounces-8877-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2E4A6AEAD
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 20:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5B5189B050
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 19:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99387229B12;
	Thu, 20 Mar 2025 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZXSuKUxo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CBC1E2852;
	Thu, 20 Mar 2025 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499879; cv=fail; b=fvbG0GTlY4eGdJqQ0uFsPkILzihFFzuTtVonqftUS14w7Sh++QeTdZVEjO752rxdWmqmLHyvxqv0nBPnJoYI7WI5tAA3YYQGVEpGTXFjW3SehX6aCHhVU63pJjH8mMC4evmCBk0iMjlKWmDqWHndvFskADEB06+OIc+GRgWettw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499879; c=relaxed/simple;
	bh=CvmGlbovPXjfzUzbJD2d0Y3QWi9g4FYNtLPyYLjgXS4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gxExkCRJRUeePp1NUz9YIjdOqN0Rtm6Qvox7nFfiBznsZbu3wHJ1KJ6fDk8qDpTNonxPahMRbUytqZQJAwNT8APnWABDKZ70h+xJoi1YkLOEwTINGJMWAVGC+FGNCpOm+D4fNhNUL/fR7Ss2klqRFO4qvn055Cqxu7Nw0HqUF1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZXSuKUxo; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D753ShzsltyOjXd+sYR5qXL+uBhfMiXJjE/ZgFVq4uP5VdoleTUaOS60sEVafw6cnpaXq5DkOx3fkBxx3a/I6WJaEErm2xraUhkNbdzjr5fJECQYaTEZ3kjlqYl5Ev2NBsITdcZP3epR+RvjraGWJgLkFuDmI/UHNZe0fq+Uaif8Aj+Ws0Hk+VcjMpVkjNIWC1ev9sybNAdHSEOaJEQ3I7mzN9lp7ey/VpBVkwxhUbY0Zc1sxgrlndj68cnwvv4+mmek+jOeym3O7JFzdbRxJv8Llk12itIboCLI0VoglJnRCY1rd2rJtsGfMvHtsd/M67SpI/05HXetjh/Lz7nbVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v09+BTI5R2fKkXduo0dZ07/pB3tcLjgXr3NO44vpp/M=;
 b=sB1P2WeQI0EZg8mag4tkDRR8Te0bl1ZBgdxQrirGgq4h0TmDM5EhMSOLEsS6qpi5/0KjgDOfL/L5fq1U/IcIA740jwBF8PKRCEzJl1OF/YwN85Q/8cIm3pCcudGhUQ3FFiAKn78ZIyMmEnhLJNSPNyvysjU2OmRqnUq4TjdXbA59H+F8BOSAvRfBJFDgG1CPCoeFJqoPuV3GAgHpINyqC5MqXeM8s3x3Wg3zBljNz/VlrcWkXkIgIzI9GSDgX6TqzpNpawCnlXXOhRPKYwt/rjZKwvXOQjAUckTXTRXQtBMqQlH1rbW0JT1snpl2EgQOf+oUD51LYE+hBdCG/G2zew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v09+BTI5R2fKkXduo0dZ07/pB3tcLjgXr3NO44vpp/M=;
 b=ZXSuKUxoOnoZWH/PsS03fZgirBkE+mw7bHS0/zL1T88sikMQrWiet2Rq9pLlfLDpF+8NDwO1fKP+uvWNB0nrQ/J4H/tAsyk0ikRevidE0Q+VAow8b8EyYvusZIoc/bH77PiVJhjpACKPgDFIt0jfMCcbvpFDXRfCVBx20CxYIkU=
Received: from BN9PR03CA0088.namprd03.prod.outlook.com (2603:10b6:408:fc::33)
 by CH3PR12MB8753.namprd12.prod.outlook.com (2603:10b6:610:178::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 19:44:30 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:408:fc:cafe::d0) by BN9PR03CA0088.outlook.office365.com
 (2603:10b6:408:fc::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 20 Mar 2025 19:44:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 19:44:30 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 14:44:28 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v5 0/6] pds_fwctl: fwctl for AMD/Pensando core devices
Date: Thu, 20 Mar 2025 12:44:06 -0700
Message-ID: <20250320194412.67983-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CH3PR12MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: ef34bc09-bd75-48ce-bce5-08dd67e7a1cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|13003099007|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xzjD7WgMafTTqQ5rYGqr9kTd4WDTOD/I2W83/16BzZJIWTj0fN4k8R5h/+fP?=
 =?us-ascii?Q?U1Cg5buyk8HdT6BZKroMDo9aae3gxUODxN2ePOLGkV2nyZfwYaeU4ZrFAtcl?=
 =?us-ascii?Q?QvFJha1wwEQhJzJIXeIiFMv3vcUR1HCcyqVbUm6csBTCpQG2yfgJu8xfUJ45?=
 =?us-ascii?Q?KW4WYF7jcNgptkJfVbVK2SW/TsoWYHWw7SLVbl8Anksbekk0Id2oHSxu5Or1?=
 =?us-ascii?Q?ZjEnC/FSKZ2N93wdsX1Ar12zMDpNAR5i1vQEaSku1aexfTSB9T1r76TlOILV?=
 =?us-ascii?Q?CmR48y5FJQjZRDYZV7PFaxGe4DWoDbv4ixHRKvs5HJ+U6BXjLeBxEjzMb9W5?=
 =?us-ascii?Q?pbRl95CKnPdZ+HpGMJ8ghHoHx/kdFYaobq3AshQY/M4XjHU7YZud9eH7uBJG?=
 =?us-ascii?Q?+lg4SAIZgCtqc1lfDwRqwv9XnyD2WrCxHzCxDeGTDXFIA9g2sYdSjRQ85uuu?=
 =?us-ascii?Q?KNin1H9+FShwgeGyNTErwv8SjqFQO01oaMG1YIN/d9frcspmuiXX1VFFyWyF?=
 =?us-ascii?Q?4RVxigt68HJAXpifwqbVNaAVYp4CZEv8X31m8fWGtiwF7Tp+iuCpQgh8INGd?=
 =?us-ascii?Q?DDvTE7RQf9cpSXF/aflg/bICgI3KievRSWwT2VP95PSdKGQ1i5N+ppW0Lgwr?=
 =?us-ascii?Q?Z9aEY6ylnDz3wcqlYSd2EBzNhtlZx87TwCRd4Ms/eS9cR9nI33qVgpzVH3bZ?=
 =?us-ascii?Q?iirjRumgYm1sCUAea8P285ndSSHzecAEUm7w5EAijc2NexxV+vIL6oSTjFZa?=
 =?us-ascii?Q?Qe8QC12uHfRYGz5TCkEtKapGjlKa1vHQhS6GjfCULR8VcnKjwcVjxoJkJ+cN?=
 =?us-ascii?Q?sXkTXpzTYMTd2g06PfI61mmdsegVC/wN2tulGCv/J+ZG8VPGPrCKMm/lNvv1?=
 =?us-ascii?Q?e+coNP94w8dhANQxRKoUdMprWsenQBKpn2WiHMjO7Hw7Ol3KXFV+LhEsqU9Y?=
 =?us-ascii?Q?6zAQcFu4yN2U7TuI8uqBMXWFY4KfiCdVCppOMwYaXSErYbTRV/R1NIZE9oKu?=
 =?us-ascii?Q?DCtL/hnFiFtoDMuW+bXB/Uv2B33Ht7jmaJQ1XUhIVTFzvZS6WdWkPZjknr9s?=
 =?us-ascii?Q?UOF47RzxZYec8pJfF2E3fEiREwbUp7/1YjzIewYgkJ/RvVUHayKBLGR5yIDm?=
 =?us-ascii?Q?s8En9K4zVP2OQBunjJKZdkSfEJuNF4tRQstyuQ+YwvHKonsheyTZ+sOElGyT?=
 =?us-ascii?Q?R+VcyOExAWY6D45kdac41yjeUNODzzmWMyGts3fPqImRUabWWKJLr8rwVLXR?=
 =?us-ascii?Q?lDCNjpFF2YEg6d2hiWTY4/i77CRnz24AiVnRzb8Goj2yiBM2xMi/8hEDpddh?=
 =?us-ascii?Q?+3pEqQfOOgKujYSqYM2RMRU0ziSHXq5Nbu2lF+ScZkoocv9J73GI11BgFXQ+?=
 =?us-ascii?Q?+6RD01Y4XhD3nbcInHFuPi5T08ogyLm/6X9uxgoelJCW+T6nvMAxGZZ5oPkx?=
 =?us-ascii?Q?ECuP43TAq2Js+IAAs6Yk6oe5uxU3nOIU2E+hnNz9f+koOfdkitHkr01Gs0Fx?=
 =?us-ascii?Q?LigTkR3Zrkz+2U1zoXO52XePIlTzQm40Uc0t?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(13003099007)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 19:44:30.5862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef34bc09-bd75-48ce-bce5-08dd67e7a1cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8753

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

v5:
  - fix missing variable declaration
  - fix kernel-doc complaint

v4: https://lore.kernel.org/netdev/20250319213237.63463-1-shannon.nelson@amd.com/
  - fix commit description for better imperative (David)
  - fix comment wording (David)
  - add kdoc comment on struct fwctl_info_pds (David)
  - #include <linux/bitfield.h>  (Jason)
  - fix for error pointer check in pdsfc_validate_rpc() (Brett and Dan)
  - initialize pdsfc->caps
  - add translation of FW opcode scope to fwctl scope
  - several doc edits (David)
  - added received Reviewd-by tags

v3: https://lore.kernel.org/netdev/20250307185329.35034-1-shannon.nelson@amd.com/
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
 .../userspace-api/fwctl/pds_fwctl.rst         |  46 ++
 MAINTAINERS                                   |   7 +
 drivers/fwctl/Kconfig                         |  10 +
 drivers/fwctl/Makefile                        |   1 +
 drivers/fwctl/pds/Makefile                    |   4 +
 drivers/fwctl/pds/main.c                      | 539 ++++++++++++++++++
 drivers/net/ethernet/amd/pds_core/auxbus.c    |  44 +-
 drivers/net/ethernet/amd/pds_core/core.c      |   7 +
 drivers/net/ethernet/amd/pds_core/core.h      |   8 +-
 drivers/net/ethernet/amd/pds_core/devlink.c   |   7 +-
 drivers/net/ethernet/amd/pds_core/main.c      |  25 +-
 include/linux/pds/pds_adminq.h                | 277 +++++++++
 include/linux/pds/pds_common.h                |   2 +
 include/uapi/fwctl/fwctl.h                    |   1 +
 include/uapi/fwctl/pds.h                      |  62 ++
 17 files changed, 1008 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/userspace-api/fwctl/pds_fwctl.rst
 create mode 100644 drivers/fwctl/pds/Makefile
 create mode 100644 drivers/fwctl/pds/main.c
 create mode 100644 include/uapi/fwctl/pds.h

-- 
2.17.1


