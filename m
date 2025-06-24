Return-Path: <linux-rdma+bounces-11568-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB3EAE644E
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 14:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BACD2168F13
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 12:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6666228ECEA;
	Tue, 24 Jun 2025 12:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q7L4xEBb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDC125BEE4;
	Tue, 24 Jun 2025 12:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767215; cv=fail; b=npjiZbNoMTRhAbv+3jiUlS/F0bTYPYXnf6v330jNn7EWwpGDgIUpMj1CvsAM2yUyFmpcSspqxSMIMxCjVY0pWXfB0EBjuau2FLmuNxfXGKV5T7xFWgBFmeJEhVR5oKsZ0fF1LrWToEnBaVLZ5Fuhi5M3Zu+VubV16RWH71vLZjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767215; c=relaxed/simple;
	bh=TNXLXg6H/2lqRykb4WUsPxpmNWlYnDqT7F+llDNXzXY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UhLMN74vmctGIG/na/ovlO/pAB3kEsTRzif2ZO9TH2XM0rYa/K8hpt9lC4B4OFaOLCRoKXmRjbYpMDcgaKe3/3U/NPIpGiuctR6QsVVOOuFUu0xfckmmshyGXwr+b6X20VhuVf9clQhfk/MqIVFoybedFqBlV92GAwUTbkRvK3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q7L4xEBb; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o69vS5CAkiHwvcQ5hQw4ImwbFbBUY0BYb1l/E0ABByc+GiEGnvpu5o44ThQBJ8roJTnNyzkZBgelkQZ0JcCTvL80crzu1L9Vi92S3zGT6bE79U7g8t95gvRjunWFTvHaPoe7dBuEbxlqFMaAP8WJXqvGi3cBVO469YVGZXal+5dMaPuudiBP+CVY7u8olPy1XkKzDms462gri+QOB27h4BHeO87nnEcZIiviZKdwHbTva3YHOOiCB0r1tAMbzyX/WomLmLvUHOdg2kY4QrF8WO5sl+DG1x7/6ACZYhTZUNmzYW0Pw9IaraRgky7AY8SKGpPbzyUXwIosoUx9TZdM0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpMVdPHnGoxSEa0O9qbmKNN4U72HT0wJ8G/o8hhHaJw=;
 b=iniJGDDao/12tFfavqEwskOo4LaujSCg3SeapxIS/A7rwDNZC6EFmelmXNfA7SLsgF5E5DBZzDp0KV79i+kdFY4WXLcuX3ScwxPFEYlvUgam42/LGQG0/ahBv1VkITXxJ+wzxLM/oFBAOC2MlQLIgPStVw4YgfhzzDMp5UcyCTRgQ2P2BipQAc1hpEeSrTEdL5f+aCofMew0GDpp2J33Q96WgOHh7q7qWnsAE7XH7hu/9fHUmbytCzvzvJefVLtfg8GvnMME+TDhc9kIWK6TBxn/7tGfwI4KarCsWn0rebaUSkyeMSSPj8I4K1s1vkS9Q4RV/dSFpDOKAXKYUXgvYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpMVdPHnGoxSEa0O9qbmKNN4U72HT0wJ8G/o8hhHaJw=;
 b=Q7L4xEBbOwwyOgDdsqckm/8xKC7uQPYNQAdEIWdM97Yw/na6mZgjNUrAISyfGjj7JfophEvwcbpZdSLIJ4GgeswsCsBE1e+kaddZhdTbNXvGmJhQ/vEJ+5WlH1F0uZmFBX0DhG1vAgV52DKo6s93QW14UXmlSxaJKWbc89I6k44=
Received: from CH2PR14CA0033.namprd14.prod.outlook.com (2603:10b6:610:56::13)
 by DM3PR12MB9286.namprd12.prod.outlook.com (2603:10b6:8:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Tue, 24 Jun
 2025 12:13:28 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::d3) by CH2PR14CA0033.outlook.office365.com
 (2603:10b6:610:56::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Tue,
 24 Jun 2025 12:13:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 12:13:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 07:13:26 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 24 Jun 2025 07:13:22 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v3 00/14] Introduce AMD Pensando RDMA driver
Date: Tue, 24 Jun 2025 17:43:01 +0530
Message-ID: <20250624121315.739049-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|DM3PR12MB9286:EE_
X-MS-Office365-Filtering-Correlation-Id: 41454350-3c8c-458e-7d83-08ddb3188689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azVjSk4vc2pIdG8wVnMrT0pCZ3dQeEMrblh0dEVYSjBLLzBaMGNsdzl0TUZY?=
 =?utf-8?B?eDJodlpPdnYzMFFvOWVBSzVsTFN5Tzg3VVhPLysvMVVmYmxHb2pLSHRHVjVG?=
 =?utf-8?B?aWpGcXRVeGcxN2xmMkovUGo0QytzN3RLZEk2Q1R4RmRYLzBQWFJRVFh1VjF6?=
 =?utf-8?B?bmFzRTZqSndWcEJkZExCSko0UnUwVnZ6Vy9DbHU5d3NPQmlKOWlQYUtDTDht?=
 =?utf-8?B?N1Ayc2g3dnIzSXhPeFFNTzRKNE55UjRVQ2NvdnB1VkJqWUdIZlp6TFpuS3Q3?=
 =?utf-8?B?M1NnWWhibHBzdjN2SnorVUc2TEV1UzlhTFQxQTJuUVVjR2Y0a05wRHFWOU1u?=
 =?utf-8?B?MTYySFpyNVQyS3B0RmxnWkpqQ3ZMOFZidjNzR084d2pZclNnUjh5cG9LK0kz?=
 =?utf-8?B?bU1zTy9KQUJmdFJBSDdjRWN5YUptZDFGTzNjeWR5b25Nc2JGSWFvODlhandT?=
 =?utf-8?B?NUY1RThVVkJ3WjhHdkU5V0VkYi9SS0NUTjBwbzd2elR4SDFwR2Y1VE91ZXc3?=
 =?utf-8?B?NmR5ZnJCYW56cmNyakd2RWZzM20vSkVONE8wMzExYmgvVjhXT3AyQ2lJbU9H?=
 =?utf-8?B?STVVRDhFU3psU2VSaVROc2pqbFBIcjF0allqbmo4cWEvOG4rd0ZTbEduTWtK?=
 =?utf-8?B?SkV1anZkSWU3UWhtRWJyZ2cyS0JzdEovb3BybktTM01TampXREFiV25MZHRS?=
 =?utf-8?B?MCtjc2VMYTBiSGlpZVJWTnRwc0lyZ0NpMHgvOWMyKzNJVkp6d2dIYjdpeWtn?=
 =?utf-8?B?UGZwQk9xSCtYUW9CYzVTaTBzY3VuaDlYNEVFMGNGc1ZUNmQyM1B3RStuWUJy?=
 =?utf-8?B?TzFNa2hOOTkvb3M5NmFKZHpzbjdNeFpWalp3a3ZhYStKRHR1M3NGV29Ma3lU?=
 =?utf-8?B?alMwclNMUHJhdlozWWVnSEM1RWxCS1hhSmxvb0VmY1poSDJjWHRaRkJ3Q0FV?=
 =?utf-8?B?NUpuZ1JWUFd2VlFtK0Q4aU5TR00zYXNjT2c5YS9IY1BISG15WmJ6RmRra2VF?=
 =?utf-8?B?U2RjTlN5L3NMZDZxci9xVzk0aUM3UEpVcHN5MGt6RCtBTGdhc1BEbGdjMXA4?=
 =?utf-8?B?NVphSW81WEtEMWZFdTZjb2hNR1pUaU9UU2ZaRnd1RjBwSi82bVZuRXNRWXRZ?=
 =?utf-8?B?b3dnWkNsdmhaN2xTd2RKdldHbFdJMlluaWVkenZNWXcvS3ZDekpDQzJTa2Z4?=
 =?utf-8?B?b3ZuR0lGdlJlcWgybjd3dVJqUzIyb2NqZzIwQnNuRHR5S010M2t5K1h5SzI3?=
 =?utf-8?B?SHR6RlFhZjduNEU0VmFDbTJJaTRVMGluM3h3TzFCa3k1TGZCOG1IVW9HYVpr?=
 =?utf-8?B?RGRZWGwzZHVZYTUwaU92UGl0b3JpV3RpLzVSYlZSayt5TzFZMzVxdWFjRzZi?=
 =?utf-8?B?bGxNNlBRTGYwQUY0cDhsRmJueTZwdGIrY0hQNXZNS2d4TEwxdXZ6VFI4TnNU?=
 =?utf-8?B?VFdjSS9XQklUcTJYSURzS3JkUVc0bkNpMVFFUVl1UGpreEU2MUtHYStqNFFy?=
 =?utf-8?B?a0RjVGU3S0JhUytteFgyOE5FOVVtMndwWmNzRHoxVjh2emVyeUZzL29GT1hK?=
 =?utf-8?B?ZndSdEU1NW9tNkZ5NklXNUplTG5VMHBBK0t5SU1tejF4eGMzYkpRelJHbmVO?=
 =?utf-8?B?ZUovQzBBU0wzR1hSelRsRTk5MG1mRDhVbit5c2t5c0UyV1BhV1JNZDUwOWRT?=
 =?utf-8?B?ZGZ0czU0YUVwOVRBYWFRM1FQaFRSOHFNb0huTDY5UTJoUWkxTHNRZ2FmMG9Q?=
 =?utf-8?B?M3dxc2tZWDArNTBmYlhJUXprSmk2YXJCZGc3ZzNPY3lLTCt4ZlVCRnZvRkR0?=
 =?utf-8?B?UVhpRElkTWFMOTR6S0U1a2VELzZoOTMrRHMweVJPWUx1eDFNLzBKWkNpRFA4?=
 =?utf-8?B?Yjdlczl0bnhXYXZQa29KSUozV3JTSnJWSUhqS3RtZENUV2xrZkJPTHZQbzY4?=
 =?utf-8?B?c25NNThjTmd6Si9ycXVUaldpa2o5TUx2NG1pQWIyeDZEYTRiN1R4NWFCTWpP?=
 =?utf-8?B?eVdZWVhEZFlheWxkWmtMMkVPdnAxZUZIdFZHeHNKeFdPZDR0RTlwblJKWFZM?=
 =?utf-8?B?TUJUR0JEZkxtNXNEdG90cXZvelVwcFhlWTBWUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 12:13:27.3690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41454350-3c8c-458e-7d83-08ddb3188689
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9286

This patchset introduces an RDMA driver for the AMD Pensando adapter.
An AMD Pensando Ethernet device with RDMA capabilities extends its
functionality through an auxiliary device.

The first 6 patches of the series modify the ionic Ethernet driver
to support the RDMA driver. The ionic RDMA driver implementation is
split into the remaining 8 patches.

v2->v3
  - Used IDA for resource id allocation
  - Fixed lockdep warning
  - Removed rw locks around xarrays
  - Used rdma_user_mmap_* APIs for mappings
  - Removed uverbs_cmd_mask
  - Registered main ib ops at once
  - Fixed sparse checks
  - Fixed make htmldocs error
v1->v2
  - Removed netdev references from ionic RDMA driver
  - Moved to ionic_lif* instead of void* to convey information between
    aux devices and drivers

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

 .../device_drivers/ethernet/index.rst         |    1 +
 .../ethernet/pensando/ionic_rdma.rst          |   43 +
 MAINTAINERS                                   |    9 +
 drivers/infiniband/Kconfig                    |    1 +
 drivers/infiniband/hw/Makefile                |    1 +
 drivers/infiniband/hw/ionic/Kconfig           |   15 +
 drivers/infiniband/hw/ionic/Makefile          |    9 +
 drivers/infiniband/hw/ionic/ionic_admin.c     | 1270 ++++++++
 .../infiniband/hw/ionic/ionic_controlpath.c   | 2714 +++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_datapath.c  | 1392 +++++++++
 drivers/infiniband/hw/ionic/ionic_fw.h        | 1029 +++++++
 drivers/infiniband/hw/ionic/ionic_hw_stats.c  |  484 +++
 drivers/infiniband/hw/ionic/ionic_ibdev.c     |  452 +++
 drivers/infiniband/hw/ionic/ionic_ibdev.h     |  521 ++++
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c   |  128 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h   |   67 +
 drivers/infiniband/hw/ionic/ionic_pgtbl.c     |  143 +
 drivers/infiniband/hw/ionic/ionic_queue.c     |   52 +
 drivers/infiniband/hw/ionic/ionic_queue.h     |  234 ++
 drivers/infiniband/hw/ionic/ionic_res.h       |  154 +
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
 35 files changed, 9516 insertions(+), 64 deletions(-)
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
 create mode 100644 drivers/infiniband/hw/ionic/ionic_res.h
 create mode 100644 drivers/net/ethernet/pensando/ionic/ionic_api.h
 create mode 100644 drivers/net/ethernet/pensando/ionic/ionic_aux.c
 create mode 100644 drivers/net/ethernet/pensando/ionic/ionic_aux.h
 create mode 100644 include/uapi/rdma/ionic-abi.h

-- 
2.43.0


