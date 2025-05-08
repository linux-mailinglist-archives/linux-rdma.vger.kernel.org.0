Return-Path: <linux-rdma+bounces-10131-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC255AAF244
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 07:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ECF24C4276
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 05:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E1D2080C0;
	Thu,  8 May 2025 05:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rOe5fEHp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3477494;
	Thu,  8 May 2025 05:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746680436; cv=fail; b=gyctriQUMz/ZZDwew+gujYJCf75vpcwW6SnmPQltvxcqC5FmbdGO1omGHRGkKgrMvrdyufIaGCFCcKEk6inZsCMQ6Z+orTpQsxU5DEoD7GSvv3E/9al4zvxzpgyAcTBi9Zi+JKZ1tyYF8ATj2mScZKV2PddnitCvSHDKclZbcxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746680436; c=relaxed/simple;
	bh=1STJjpPbD12uPh63mDxQU/4dDY/pNVVBLjjjQM3NW70=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HernxpT/OHIGfv6RRAAseOY6fOhbtRvhiMzWxZ1RiGbql223l7IvoAGsTL/SSdKuflY2KuXIFS7C1rZuzV02P/yEnRmdq7fxVprN72Otzva5vC49yULvei7I1EaJRhwLNNFhbrF8/jCO3ugGaVTYrw2SqV+K4KmR+D5X2ljzae8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rOe5fEHp; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4Oz2Q27uuFq4y7YyReWnMhByExjC7Gt2N7byfUmq78njUtYt6sKEp4i5Udnq5DRB+BgYi3jx2m4YjdnxH+AdPD02AmpHjtRa9AC/iBNqQiyjkuOmzo310kKaDCRsKkLSpeTfVbAPvPdURFrOHFtM1YbzQEge8r6c+UB1l2YZ/J4Upzj26uzFIpIsflk3AAItNryU5GBbp099/fIop7w7kchgATvT63tFk7ziQPQOYXnKnLIqNgyF+VOow3RjxsUKUA4/AFEZf6HcGRXmv0YkWuco0dCqXWxHAq3MuCQgiw4Lfq8zBO7bGItpq17dGbWdq7wAPffIOcoGrObgQX6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZaZGJZzSyO34y296DEjy1VfwVxqgBFEmAbppQylJSQ=;
 b=RwIdBR4IDFDCFqrC1zKiIx456zy6R9YnfFEFrR+7mMiNSpRq1I01tMsZpGCEwhdKroKABA/Nq587wlaIl1NTeJ0BpkSxbYhMRer2NOr1Roq4RiirdVIxpZ3AZcudc0iFymh+gDB0L7kDLR93zxCDgL85t//WTq1oLS9hcgVcV+gCKrDciCqkHAeExBaUpA3X7M5693nBDc/hsZqVIsL5LDqzVK3sOWfuDj6Sgq5KlwPI2rIzcjoZCR76igWQgcYZUktUCQlsl1qaZvWxWeL2trRbnTqop4Q4avokoQzmGVDXo4jFWsggoUSYw2gcQly8WAmW2M4pYQs2ESfXdZYXuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZaZGJZzSyO34y296DEjy1VfwVxqgBFEmAbppQylJSQ=;
 b=rOe5fEHpwUkDtOowKPxzgSPF/O5UAFL0rL3rsSslCy81Q1aS9pCOyiTJ+Rx+9C/2zeN8D1B7/pXdf4R/q5q6nttzB036cQ4gLIaGoUeUw0nTxi8fWMSUt5DbSQCcpa/1ZunmBhOe9jUqj9HpsVDNFtDIQkmPCPD4AQHA/YvSVmY=
Received: from DM6PR21CA0021.namprd21.prod.outlook.com (2603:10b6:5:174::31)
 by DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 8 May
 2025 05:00:28 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::f1) by DM6PR21CA0021.outlook.office365.com
 (2603:10b6:5:174::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.4 via Frontend Transport; Thu, 8
 May 2025 05:00:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 05:00:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:00:24 -0500
Received: from xhdipdslab61.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 May 2025 00:00:20 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v2 00/14] Introduce AMD Pensando RDMA driver
Date: Thu, 8 May 2025 10:29:43 +0530
Message-ID: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|DS7PR12MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 3044362e-a62c-4e61-c8ce-08dd8ded3fde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEh2UHAycHJLYndoK0JZSEdZbUlPK0JJODVPbC9Dem1zd2lML2tLMmdGclZG?=
 =?utf-8?B?SFdBWEhqb3NaUmJPblpDR21YZC9qWTA4QU00MW9NUy9uaHpycllsR2dsbitr?=
 =?utf-8?B?SHd3ZXBMYUZPRWN4Z09PS2pWRnNtZzZOODZOZFhmcEgyWkJhSGpsRENYb0p4?=
 =?utf-8?B?QTMreTAxVk5sQ2txT1RseHZTWjU5RjJsN250SkY1ZkxDcXlDa2E1enR5RVNS?=
 =?utf-8?B?WXJGZFI5WVRtZllmeW1TQUlRaGVwZ1pkZFlRelBOQ3FCOTFtOTViNmdBZHly?=
 =?utf-8?B?UXVldnAyMXNKdEp4S2syZlFRWmlxMEYvY21tMTdYcmRLZDE4STkvaTZFdysv?=
 =?utf-8?B?ZTlLVnNka1ZiS1p1WnZVWEZCb0NHTmJJNUJNVjlpL21NWG1tRnhqMUFMaTBn?=
 =?utf-8?B?dXljMEFuNzk5aWdCUFhobEpNUElBR0E5OU92YWQ5V01HbHVBVGo4b0VkNHpx?=
 =?utf-8?B?N1BSN0tvVFF0V3JlWWhsZG8xTXJ3WEZIa08xUkRWM2ZXcFlwWmdYTitpeXor?=
 =?utf-8?B?MmxVa1NxWlJGRnl2aStkcEpQRTZ2bDNYSjNBdVQ1azF2RUtxbStianlONVZa?=
 =?utf-8?B?bEZtNEFiZVZjVVFSNlNGd3YxaUg2MFowckJIOG9icDZrZU5xRGtwUkQ0VExi?=
 =?utf-8?B?VEFiZytEMFpYdXpVS2toSEpLUHpycE9mY1BITHgvQ3VrQTliQmdEUmdUaEpq?=
 =?utf-8?B?VmlVQTBEbkJtNnZrc1BPOFZwL0t0M21kMzNoVXhaU2pDOGlwRjg0TndxeExz?=
 =?utf-8?B?ZG5WRUVydTNwZ3IzSTlBM0laQlkwVzFlSFR4a0Uwelhvd0kwTDBjNUxZOWRs?=
 =?utf-8?B?QjR5NXNYb2o5TFI4STJvbFExYkhCNFAyL3FUVFBXait0eUJEUit5dFo5N2Vy?=
 =?utf-8?B?VWllNjlaaDZYWWRkbkt3dUNyOVFuZW5FSjZvMVFVUUhVeHpMOGx0MjFFQ2RV?=
 =?utf-8?B?V0JKMWErVHA2bXE1VGpUeHVid3hlMUg2RFh1MXNxbWsxR3NDVGtiYnh0dmRh?=
 =?utf-8?B?M1UwcUo4cnVyMXBuS3YyaEh4cFNQK1Q3SHRFWGdORkNCcnQvK2xYQlF5OGRE?=
 =?utf-8?B?L25LNU9LQ1ZSSUdZeWl3ZmtVVUw3Q2lrRGR1aElVWEVGU3RzKy9MSVZJSnk0?=
 =?utf-8?B?cldtQ3o1WS9EUElkVm1qa21TRnVhRCtLSUg1Wno4QmY4d0pLNzZHVm03a1hs?=
 =?utf-8?B?YjlrRUw3OHc1V0NvcTUybStaL3BSZTYwdk5QdDkwcmNQZWZMQ21kTjJXUXB3?=
 =?utf-8?B?SDBtTGpGYUZRUnlGK252YnpqSzZSUGVMemlhajVwRjFNMmFBY21hcUVoR0tw?=
 =?utf-8?B?ak5CdTd5Rkc0a1dDYW9VUDBCZVBrc0tKS0tLaVVpTFo3eGU1ZWw1ZG9KbHdh?=
 =?utf-8?B?OXJwbnZWTy9uNHlIRTRNWEZkcTNFYXhzS3ZqZitOcDBqUmFxU1hjVnZBQ2xG?=
 =?utf-8?B?aGNQSW42bGZudlFPUXZSNEk5cTBseG9aTmkwbFF0azNyQ3hRS055Z3dBb0xF?=
 =?utf-8?B?MzlkaUhYOEtoQTg5TWdZV2tFQzZiRXNpZjRzOVJnZXB6a0RzeTFaVlNrVVd4?=
 =?utf-8?B?a05lU1ZlTjlCbGxnL3RlUlQ3bTFKalFyYUNQdFFQNEo3Um5QTFN2RG84VDBE?=
 =?utf-8?B?SlRnZXZ1NGhreUZaRGFoYnhxbjFjb3NOZWxzeDlxdk1FbTIrZDEzd3E5b0lL?=
 =?utf-8?B?M3dDa2ttTDVyVk5sQTJkVUJKZ1Z3Rngyd01ya0hqWE16aDlWOHE2MFN4ck9V?=
 =?utf-8?B?UGNoNUI0MktnOVRxSTdROXgvNis5MDhXSDR6aGhxRXhFWmtIZGtLdUxFaWpM?=
 =?utf-8?B?MTVSS2NPaVpHUTVsakRBemJ4YmtaaUxHUDI0ZlVuVnUwSkhZOCs5VDBKb1oy?=
 =?utf-8?B?QWdpL1ZPQ0l0U3h6WnpDK2JWdkRzc0kvUVI4ZGFZWm1pMWpUTVRVY21LbVky?=
 =?utf-8?B?TEM2OFJORm4wMXU2RkVMdmFxNzNCSnlVREhsalQzTGUvNlQ3VE1tdjE0SWdG?=
 =?utf-8?B?Ty9vTUpYakFiaFMweWkvWTFrSUNxdnhtQmswVXROaFdDL2NtTFd3dE45Y3RC?=
 =?utf-8?B?eUt4SjJTZVQwTUVTZzdwVzFMYmwzcnUwbFA4UT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:00:27.3276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3044362e-a62c-4e61-c8ce-08dd8ded3fde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8371

This patchset introduces an RDMA driver for the AMD Pensando adapter. 
An AMD Pensando Ethernet device with RDMA capabilities extends its 
functionality through an auxiliary device.

The first 6 patches of the series modify the ionic Ethernet driver 
to support the RDMA driver. The ionic RDMA driver implementation is 
split into the remaining 8 patches.

v1->v2
  - Removed netdev references from ionic RDMA driver
  - Moved to ionic_lif* instead of void* to convey information between
    aux devices and drivers.

Abhijit Gangurde (14):
  net: ionic: Create an auxiliary device for rdma driver
  net: ionic: Update LIF identity with additional RDMA capabilities
  net: ionic: Export the APIs from net driver to support device commands
  net: ionic: Provide RDMA reset support for the RDMA driver
  net: ionic: Provide interrupt allocation support for the RDMA driver
  net: ionic: Provide doorbell and CMB region information
  RDMA: Add IONIC to rdma_driver_id definition
  RDMA/ionic: Register auxiliary module for ionic ethernet adapter
  RDMA/ionic: Create device queues to support admin operations
  RDMA/ionic: Register device ops for control path
  RDMA/ionic: Register device ops for datapath
  RDMA/ionic: Register device ops for miscellaneous functionality
  RDMA/ionic: Implement device stats ops
  RDMA/ionic: Add Makefile/Kconfig to kernel build environment

 .../ethernet/pensando/ionic_rdma.rst          |   43 +
 MAINTAINERS                                   |    9 +
 drivers/infiniband/Kconfig                    |    1 +
 drivers/infiniband/hw/Makefile                |    1 +
 drivers/infiniband/hw/ionic/Kconfig           |   17 +
 drivers/infiniband/hw/ionic/Makefile          |    9 +
 drivers/infiniband/hw/ionic/ionic_admin.c     | 1241 +++++++
 .../infiniband/hw/ionic/ionic_controlpath.c   | 2929 +++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_datapath.c  | 1422 ++++++++
 drivers/infiniband/hw/ionic/ionic_fw.h        | 1031 ++++++
 drivers/infiniband/hw/ionic/ionic_hw_stats.c  |  484 +++
 drivers/infiniband/hw/ionic/ionic_ibdev.c     |  489 +++
 drivers/infiniband/hw/ionic/ionic_ibdev.h     |  506 +++
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c   |  131 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h   |   67 +
 drivers/infiniband/hw/ionic/ionic_pgtbl.c     |  143 +
 drivers/infiniband/hw/ionic/ionic_queue.c     |   52 +
 drivers/infiniband/hw/ionic/ionic_queue.h     |  234 ++
 drivers/infiniband/hw/ionic/ionic_res.c       |   42 +
 drivers/infiniband/hw/ionic/ionic_res.h       |  182 +
 drivers/net/ethernet/pensando/Kconfig         |    1 +
 drivers/net/ethernet/pensando/ionic/Makefile  |    2 +-
 drivers/net/ethernet/pensando/ionic/ionic.h   |    7 -
 .../net/ethernet/pensando/ionic/ionic_api.h   |  131 +
 .../net/ethernet/pensando/ionic/ionic_aux.c   |  117 +
 .../net/ethernet/pensando/ionic/ionic_aux.h   |   10 +
 .../ethernet/pensando/ionic/ionic_bus_pci.c   |    7 +
 .../net/ethernet/pensando/ionic/ionic_dev.c   |  270 +-
 .../net/ethernet/pensando/ionic/ionic_dev.h   |   28 +-
 .../net/ethernet/pensando/ionic/ionic_if.h    |  118 +-
 .../net/ethernet/pensando/ionic/ionic_lif.c   |   47 +-
 .../net/ethernet/pensando/ionic/ionic_lif.h   |    3 +
 .../net/ethernet/pensando/ionic/ionic_main.c  |    4 +-
 include/uapi/rdma/ib_user_ioctl_verbs.h       |    1 +
 include/uapi/rdma/ionic-abi.h                 |  115 +
 35 files changed, 9830 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
 create mode 100644 drivers/infiniband/hw/ionic/Kconfig
 create mode 100644 drivers/infiniband/hw/ionic/Makefile
 create mode 100644 drivers/infiniband/hw/ionic/ionic_admin.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_controlpath.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_datapath.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_fw.h
 create mode 100644 drivers/infiniband/hw/ionic/ionic_hw_stats.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_ibdev.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_ibdev.h
 create mode 100644 drivers/infiniband/hw/ionic/ionic_lif_cfg.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_lif_cfg.h
 create mode 100644 drivers/infiniband/hw/ionic/ionic_pgtbl.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_queue.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_queue.h
 create mode 100644 drivers/infiniband/hw/ionic/ionic_res.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_res.h
 create mode 100644 drivers/net/ethernet/pensando/ionic/ionic_api.h
 create mode 100644 drivers/net/ethernet/pensando/ionic/ionic_aux.c
 create mode 100644 drivers/net/ethernet/pensando/ionic/ionic_aux.h
 create mode 100644 include/uapi/rdma/ionic-abi.h

-- 
2.34.1


