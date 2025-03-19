Return-Path: <linux-rdma+bounces-8847-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4DFA69AE8
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 22:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE6A189DB6E
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 21:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD89921A43B;
	Wed, 19 Mar 2025 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lfPVerk7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19BF214801;
	Wed, 19 Mar 2025 21:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419983; cv=fail; b=OL/MynoWBexrlWKF4T0DOkHp9J/eiBbD1j23XqLtdWxoV5fG5SD6cRgmfLKAf+t295/qSYJP/+bvddO7FMdHnUAhgdVBT2jEUaFk2SomHQRm9Da032Y5yfgkAi5MlA69lY9THeOsVwKt5aIUoGm5d9nSPwWLHvf+ZfZGHgh3f80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419983; c=relaxed/simple;
	bh=u3NEa5+H3CwPb5pvPzBomkkm3euLBj3e1Z+PYRsu3Pk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gu0ElWoHoajAW5dWQxvLPapuUCrvRNwgXCZUKhp0jEcjR5CF3Q5oyevb1RkJcLRuknWwAlYJVt7ckylyrqCOuI6m7wEXezNCrSFtjRLyRvKBS1WbphebifKJ3HwvoRjnTwnrWOzeWSQJc1FgZpagqJARDdXkE+XASVZxAiXlcjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lfPVerk7; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCsXSwphaRWo5rxLiak7O18Xh3X9GUi9wPhm9hE26lWZ7bbJ5jlLFvJ6I9fd4EbFt0afsTGJyAOokfGH3f+P1PEfoxf8pDwMf/59+gmf5maYfCY1RG47SGE/M1hIbApNVF5LHCi8ghmgePGRehWS0bDooJjsTIaePlRCpTm+qOIMDkpRUHk0uGnnNsaM4DVYVT1CSELod83VTThYisvWD01yR/KSzo0ThKWp9TbB5ugmP/nrPFWhQ7nCzbbooCdafwEsJGLnnr3ErR6leP51ifwQ3t6OfVUbvPUimTxDtpyrfDu52k+/xzJ0QoSacKicGtFcU9TLrgxzurt1B2cdvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OessLv+FDjZDvWkRMC6hSJMW1OgCCrwaGRcVezHDzs=;
 b=BBs3f4QRNbddccamxDdHATN3/w4+AUppJJaDN40Fp0P+XXLK78kZylqN55vyXdj1/E1wWbtuyZPv8b+6Eph0cgXckCbRBKCp2CgTxnRBWO6aHtCURzduNew0PVaWNg2H3gFA+D3iVTPmYRGu0THCNnUMoKonynKRJr4qykK9zNfCIBtY+LPtShmHFRMHEBF0mCHQ+47XQBh3nytl3cMKZUCY8zXtmYxIuifJM0RPz3rvZXnI5Mbb0TMIdaFRWy/w1Di2aWUzgodE20TogYbyBM2OGv20y2xpGrd9OELWuvmvp78/nxZU6MitWz9XVFwdVhtDCvP74NXxRtlTaSxUVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OessLv+FDjZDvWkRMC6hSJMW1OgCCrwaGRcVezHDzs=;
 b=lfPVerk7+r52+c3RgUVYJJaYRUigIh8eBO38O+Yz0rFU4f9W6jN9aamURIJzHYhwsHl1jN05L3GZ6ILqmPBF+0x9oG+GYwNm6SsPbITI9X85KpeA+hw6R8v6U8GuEUDR0GWGgkKCafMb+ONSK7GY7aYnD7/lHcyCTdw1t9RaLLc=
Received: from BYAPR05CA0019.namprd05.prod.outlook.com (2603:10b6:a03:c0::32)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 21:32:54 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:c0:cafe::11) by BYAPR05CA0019.outlook.office365.com
 (2603:10b6:a03:c0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 21:32:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Wed, 19 Mar 2025 21:32:54 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 16:32:51 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v4 0/6] pds_fwctl: fwctl for AMD/Pensando core devices
Date: Wed, 19 Mar 2025 14:32:31 -0700
Message-ID: <20250319213237.63463-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 98724419-20bc-4cdc-9993-08dd672d9bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EhXlSII8wWGOe8O1Nco6afxJI2mUMJKmzOJTbjhKaDbdXPU8Gm6k6DTCpbFJ?=
 =?us-ascii?Q?jCrODJ38CnVcMRYRl9M66/w0ZdDJ1liJ2dOANljzYv37hYoDCRmY7VGIGXVi?=
 =?us-ascii?Q?x7Ja7PYAwUd2Cb08kWYPVcbcmgvAfOCFRHB6fTo/jxzu6kJvE1uZrUJelf1Z?=
 =?us-ascii?Q?uiL/VW7jYAIFYJadFzkCWG645VLcKwhDlt4MfM7BK1TTyvMOGSDStCidmyDe?=
 =?us-ascii?Q?33RYWNVnqhMCr9mhgw7GHEeM6wqdMcNYkbhCe6NjYa5vvzs2TvBtntKcI2is?=
 =?us-ascii?Q?Yu0QMoC2Qkc1/87el71iHK5xnQ7RQozo3xLlDo/bOc+481IPkxU7yuSr5vzP?=
 =?us-ascii?Q?XG4mUYUgWMm4K+9SU1b9bB6aktOy6JixTLI8IruUobcp1XMLRJBwwGknskPa?=
 =?us-ascii?Q?gaSdoQ3bIYrAD0TA63W3eOmQ2WUrQvJ+lsZ0TosHNUEerlYMukYBR/5ByT/x?=
 =?us-ascii?Q?xJ08gGV2uc9ulQkq76uwESnO3bRsImoevIWMMpj2Zn3Y2qjG+IEbVvSGJCUS?=
 =?us-ascii?Q?PCgkulCRWs81N5afZHLjYgONt1bdsYYcev+lj099MMIlaQr2Ao0wjlzo76UG?=
 =?us-ascii?Q?ODfUSrbhULpyUOKrj1ZQtUf3qGxIv7ZHIV6+tx/S+gMQNa+mCKeROXuhTI8p?=
 =?us-ascii?Q?n+3WuFD8Tw4oUhjmSiq/1Kfca56RGOfUcFn8kfZamkUaIfBMinYl89sn7rPX?=
 =?us-ascii?Q?/xelEajv0BjQeghipMVfrqrDsRGXk3YojIR5PFad2ehht+HkNr+KmXX3Esr4?=
 =?us-ascii?Q?l29obEH56fbdLdKK7em2/JYqvll90Ed/fjdO8uoC2TMUgAr8cEukKO/ARQht?=
 =?us-ascii?Q?KvItWdYRaBCq1x3Xh/zgA5DY2a5/322LjYwM3263kaTsccN6UOEcprUuMkZB?=
 =?us-ascii?Q?3eLfGj8CzblV2z6aWrb51wgWsKanFim2pEz5A4DXi6I8ovrCivhmefvSAgqo?=
 =?us-ascii?Q?CxDUoNBNnKJa1A7nyDCbaa9IKJTvCaEPh0bgu/cauecCNGtScMggqdIGjCBO?=
 =?us-ascii?Q?/v6Ro6MC+jjhjr20X+B5cwxXUhEAOyn+boWRtaCKG1B8wgip/9kRsrdiRdvz?=
 =?us-ascii?Q?g8nBhFQ59EezQKZKF7MypPX2Io99ST/8vYY8n9OMGQPGoDeE4h4+y3ZLbGyA?=
 =?us-ascii?Q?tQBhQWMKzoGWpd9DksthuSUvTwCp1zBBb7a5b05c1vlyb9DFk1rwFBU4sAPm?=
 =?us-ascii?Q?c40yLOiXlpMlzWNREOXONm3ur9LapYmfys2ghQH+DEYW6fZlkxftbWW4UOHT?=
 =?us-ascii?Q?rdjES2l5S2D0z+v0htJcweygkNv1KuOe3kq/B20pXY+nDI6shNWPn+GeVLmI?=
 =?us-ascii?Q?oqU2vc4MrQCROH9ejGN2G3If3HgRpnqgrKgyMoQKycQMxzD/w6L38rpJvv/5?=
 =?us-ascii?Q?aB550hCghvbkpaQAop5H3j5qLqD/jpNluhB+1xOyUUTbcE52ivHd1jfXiO25?=
 =?us-ascii?Q?gvChUEPKgPwk/jqOku0o21uH92ZnNeq8FophP8TgILLC3U5B+cwY/w0f6a4W?=
 =?us-ascii?Q?/hW32r4+Z3t5zDLyaSIgfK2jWp1VCd5hucgy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 21:32:54.0138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98724419-20bc-4cdc-9993-08dd672d9bcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782

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

v4:
  - fix commit description for better imperative (David)
  - fix comment wording (David)
  - add kdoc comment on struct fwctl_info_pds (David)
  - #include <linux/bitfield.h>  (Jason)
  - fix for error pointer check in pdsfc_validate_rpc() (Brett and Dan)
  - initialize pdsfc->caps
  - add translation of FW opcode scope to fwctl scope
  - several doc edits (David)
  - added received Reviewd-by tags

v3: Lots of little cleaning tweaks
https://lore.kernel.org/netdev/20250307185329.35034-1-shannon.nelson@amd.com/
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
 .../userspace-api/fwctl/pds_fwctl.rst         |  48 ++
 MAINTAINERS                                   |   7 +
 drivers/fwctl/Kconfig                         |  10 +
 drivers/fwctl/Makefile                        |   1 +
 drivers/fwctl/pds/Makefile                    |   4 +
 drivers/fwctl/pds/main.c                      | 538 ++++++++++++++++++
 drivers/net/ethernet/amd/pds_core/auxbus.c    |  44 +-
 drivers/net/ethernet/amd/pds_core/core.c      |   7 +
 drivers/net/ethernet/amd/pds_core/core.h      |   8 +-
 drivers/net/ethernet/amd/pds_core/devlink.c   |   7 +-
 drivers/net/ethernet/amd/pds_core/main.c      |  25 +-
 include/linux/pds/pds_adminq.h                | 277 +++++++++
 include/linux/pds/pds_common.h                |   2 +
 include/uapi/fwctl/fwctl.h                    |   1 +
 include/uapi/fwctl/pds.h                      |  60 ++
 17 files changed, 1007 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/userspace-api/fwctl/pds_fwctl.rst
 create mode 100644 drivers/fwctl/pds/Makefile
 create mode 100644 drivers/fwctl/pds/main.c
 create mode 100644 include/uapi/fwctl/pds.h

-- 
2.17.1


