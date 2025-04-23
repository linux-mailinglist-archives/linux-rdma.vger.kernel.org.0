Return-Path: <linux-rdma+bounces-9715-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1820A98754
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 12:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8351B662CB
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 10:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B87202C44;
	Wed, 23 Apr 2025 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tkFvv7WO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60D92701C6;
	Wed, 23 Apr 2025 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745404226; cv=fail; b=qqLQDxxek/2++R2N7CD5ppPLaAp7LY7QASLXnJOKRiA9YcpbDBtlj2VkIXCP3gJn8XxdDRQ8s5oXJeiFNlfiGFFoSCWei/yMJ+Zjgx4uu/vGipHMaTPPlJWlDQmaL4OXgfoYFnI8WlfCBFb2Z5fZ7eKJY0Xr2gTG6T5epCRA/7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745404226; c=relaxed/simple;
	bh=uKhrbdHdEBmCVD4aSir5qsJXUYOHjk9Jdsh3YbdxJ6o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jYe8qY+zWgzKaQxwNeNe3e4czTUYshvkp7fN8PubC8JEr0jaFumuxrUaXw33T7s41iD3qT0cc2dxR6mzH4Ekx5OxZjUA8K6hXdO/yuXIWGcKu/HLa6jS3fbhJvuRf/bT/3+s2QXmpLia0Sb5NpKjoXO6ZDCpQS8U2kDB+Sl+s60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tkFvv7WO; arc=fail smtp.client-ip=40.107.101.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4q+vFjOyn4nW6s8w13rHidndAP34UkyWO8VntN2M6dwHFrLoXx+aTfp6GQOVQwopwLdsxBrt8gZ7G7J5LcMV3KN4Ok3U/w/hoW1rHyaKVlH6OjvwNhGkSr5lGIt6xk/HuKQKoFw3cv06b+hqVx9aECJcds2AynZQQjtyhT8LeetuM9eWICg7F+XrJWwP2xj6Lj7SO9+oImKKu3sPdu5S84eqMB7KciHGtX9xy0zeBzvFUFMdVk38OTZkWn8aveo0TL4rt5XHrAp7SzArXFDDGTzZ8sCFfdOhWBD09Vr/ekYARrQ2Fah4TTUtMH0e1iMXiBjDMv8JLNE2SCPg1ZqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmLYrYBqGzezUdYG5v4Jg4o46L6Sv+pRc+Jzwe2K1Dk=;
 b=QYh9pIdg2elG+UkUhEcSGdZKLQ3MQetx4Ojcerfp8nobsl0tgiK5JN9lUnPgYldWwfIDaRcjBGHRuXin/PkhX6iWghxlFJ+naXhrEWirzdH7G/vRiqdjKUl5p/amW5BJAZO63Xr39KoHgN2sVgK0UVxaQcS9Rx9dHy6I96wh7dP0v2oQlaW+9hlCCG3N6jJTnlDeVdUhghnQFUI1Vneq6g03VR3OhqiJgcXN0hioxdORXa5njRTJBpz+yiYkA0OYxYaQLIBClJ4kdIwFTyGlMX+MIp5++jy71RSgp8K/o2pxhbXBIWN0WaC73akQ2xUDl8xnja8S5fyRIX9FDrCvqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmLYrYBqGzezUdYG5v4Jg4o46L6Sv+pRc+Jzwe2K1Dk=;
 b=tkFvv7WOCHUl4o2cd9kQLqyS/Hs5251g/0NRmFndphW3P7OBElxMDnhJur9Z+O4ZFfCo7fGtinnfWK88SzoDN3xqg/cf+EpZxUhnFiM9smNsvJ7E41Rx6Dtfh8PNC6jXo/N/joNOkGuzy772yuWrrej63jQfwd9XsS9mXq9P600=
Received: from CH0PR04CA0027.namprd04.prod.outlook.com (2603:10b6:610:76::32)
 by IA0PR12MB7556.namprd12.prod.outlook.com (2603:10b6:208:43c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 10:30:19 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::3) by CH0PR04CA0027.outlook.office365.com
 (2603:10b6:610:76::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 23 Apr 2025 10:30:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 10:30:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 05:30:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 05:30:18 -0500
Received: from xhdipdslab48.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 23 Apr 2025 05:30:12 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH 00/14] Introduce AMD Pensando RDMA driver
Date: Wed, 23 Apr 2025 15:58:59 +0530
Message-ID: <20250423102913.438027-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|IA0PR12MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b687be8-d634-4bf0-0d9f-08dd8251d867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXIvSTV2czA1NWI5VjNzZTgrNmd2T1UyNFlyd0dUVmd1NGZXay83R1pKeWtn?=
 =?utf-8?B?K3RUclA2R01CRURnTkF1eUdMdGk0OTBWT0t4WjhmWHRrR0dtYlBheTVRYmFF?=
 =?utf-8?B?cFRadjZPYmlsbUZKYXhXejVaQ0NPQVJETGtrVCtQWFZpTlEvWGdEc1QyMTJM?=
 =?utf-8?B?SHhLK01ibnE4WE1qRnFaT2Jwck55OExLQUd4R2RiZnJSeTd6cGs4K3VkUTFF?=
 =?utf-8?B?ckNpQjhob3hVOTNya3l2WkczRGtHYjhhOEhoTVYyZXJaQXZWNWV3Y1FCc1dT?=
 =?utf-8?B?d3JyMzJHaEU3cWlJY1JMa1V3UlhvWE16UWIzL3p4eldaQW9kMlA4Y0poYkVa?=
 =?utf-8?B?QVpTazVDV0crNU1YcUJDaUg5R0lDSjE1RDM5UWI4V2o5ZHdSM3J3b3JML2dG?=
 =?utf-8?B?a3N4bGhtSjFHM2lNN09aa0xla2dCQWZmb0dlcmc1VUtXQ0hqUm4xVzJ5Vm9D?=
 =?utf-8?B?U2ZwZEltTW5qVVo0dUFrcmkxYktuRGk4bittVkRjSXVQMEt5ejd3WUJOdkt0?=
 =?utf-8?B?ODVGVVpTMEtCU0lUZm9oazJpbTUreFFZUE44dnRuUHJGNTVFMGJwUTF0enIz?=
 =?utf-8?B?RHcxNTRDS2ppbldSSjlqUE90WCtZZlRnYkU2dHhtaXZUWGdCckdKM2FlOFV6?=
 =?utf-8?B?RFM4ZzdaLzRWQlhOd2pjU2ZXRHpxQWtYdzRlcmRYaXU2WHVTbmM3a1FXTlVk?=
 =?utf-8?B?cnM0TGVDWldFbEJMRFBvUUQ3amZkN25jS1cwZnBjdzlRcUZCdHNNQ3BySGUy?=
 =?utf-8?B?VkNvQ1V2YjBjQitJanpMZ2piT0xYU2laRjQwRHNDRjI2ZysrbzNTN21KL2U2?=
 =?utf-8?B?L2tNYjdjUjlqS3Z4TXV2Yk54YWd6V2FOcUpVemFralpGd09aNXRlWDEvUENY?=
 =?utf-8?B?QXVqcmJtZ01HQ0lYeUMveVZGZ0FXSUtUcXVGemNzNHI2QzNSVnQwU094MkNs?=
 =?utf-8?B?Ti8wbU1qUVkrY2tLTkZOZXlGeDQ5eCtDczcya1g0Z0VDNUJGeFhKZjh3bHZv?=
 =?utf-8?B?RnVZc3V1T0VQdm9zSGw2elc3WExYdmdudW1nMGVFbkJQWFY5TkJmSTlxN21z?=
 =?utf-8?B?WDYyaWtnVUFiQ3JzT3ByN1pjMXh1aEN5dG1Jbm9zSlo5OWMwUkR2aWpvaWE2?=
 =?utf-8?B?TE1uQ3lYT3U0K3UzY1p5UXBRc1ltYlh0cEJETG5MUUU1YzNZcDQ5ejZIcVlV?=
 =?utf-8?B?U1lHQ1NrMDRFM2VsWGIzSzVLRVp5Mmx3Z20vYVJjc3l2RWpDcER5cmhtYkUv?=
 =?utf-8?B?WW5KVG43MlFqM2ZCcmtyNTltNktiNmMwbSs5eEVxSTBJMHFtcmNjZjJCZ2tR?=
 =?utf-8?B?Nk5EYUZLSVhWWS85ZU40b3FZbUlodnZTYWY0ak9qUnFYTytaVEMzWk1hakEv?=
 =?utf-8?B?Z0FFZFJEdkFtK0EweDBEUXE2WkIrT05IZVlIS3M4QW9tTk1oQTlyaHovZzM1?=
 =?utf-8?B?V2hBUEREQXBuT2dGbXE3UGxXOWhsUHJEZmI1WUJDYWY4cjhBckdXbnE1TW12?=
 =?utf-8?B?QmI1VXRYS1hUdGVVRTc3QnVPbWRaUDByWVB5VUtuK1ZNQWwxRkl2bnB5Tm14?=
 =?utf-8?B?ZW9uVnZQeWw2VTRGcWx6N0VQSy9tb3NPZDVFcExLOFNQaVA4OVUzbWE1YjVF?=
 =?utf-8?B?WXg4eWc1TEIyVG9rcEkwNmFKOFRwTFRzU2svbXZuenBLZC9xM0tlNUZIOXB4?=
 =?utf-8?B?SjE5MjdRVFAwZnNEbUZmL2tqeVp6cXFCdlArdDEwSkdBZEhKZ1BnTitLNjVB?=
 =?utf-8?B?U1lTUlhCbURyYlNhM1FHL3htOGRpNVdTQWlBeDYwcU1zUTRwRW8zWmJCUUVN?=
 =?utf-8?B?djViSUZYVDE2enVtODBZMkZPQVl6Y3BBMjZaejFOS3RHbnd5Qkl5QU5NUGpL?=
 =?utf-8?B?THVHVEdvNlJoVHFuc0NRVm03TDRKd0ozZk5YdzN6RDBGMzBURDd6ZnZGcVRK?=
 =?utf-8?B?MmVMem5vb3dUTDNUNjNQa3AwYldNbUIxTHNQZk50NTZWWVlMcTR0dU5jR1Qv?=
 =?utf-8?B?YlV0RHVCTENJZHJ6TVY1RHM4UTBBSUdndk5BMFJIKytJMW9zWVZCSi9SNGpR?=
 =?utf-8?B?eXlKZDBTYzE3WXlRMkdyQmRqcncvV3pOR0ozdz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 10:30:19.0447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b687be8-d634-4bf0-0d9f-08dd8251d867
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7556

This patchset introduces an RDMA driver for the AMD Pensando adapter. 
An AMD Pensando Ethernet device with RDMA capabilities extends its 
functionality through an auxiliary device.

The first 6 patches of the series modify the ionic Ethernet driver 
to support the RDMA driver. The ionic RDMA driver implementation is 
split into the remaining 8 patches.

Abhijit Gangurde (14):
  net: ionic: Rename neqs_per_lif to reflect rdma capability
  net: ionic: Create an auxiliary device for rdma driver
  net: ionic: Export the APIs from net driver to get RDMA capabilities
  net: ionic: Export the APIs from net driver to support device commands
  net: ionic: Provide doorbell and CMB region information
  net: ionic: Move header files to a common location
  RDMA: Add IONIC to rdma_driver_id definition
  RDMA/ionic: Register auxiliary module for ionic ethernet adapter
  RDMA/ionic: Create device queues to support admin operations
  RDMA/ionic: Register device ops for control path
  RDMA/ionic: Register device ops for datapath
  RDMA/ionic: Register device ops for miscellaneous functionality
  RDMA/ionic: Implement device stats ops
  RDMA/ionic: Add Makefile/Kconfig to kernel build environment

 .../ethernet/pensando/ionic_rdma.rst          |   43 +
 MAINTAINERS                                   |   11 +
 drivers/infiniband/Kconfig                    |    1 +
 drivers/infiniband/hw/Makefile                |    1 +
 drivers/infiniband/hw/ionic/Kconfig           |   17 +
 drivers/infiniband/hw/ionic/Makefile          |    7 +
 drivers/infiniband/hw/ionic/ionic_admin.c     | 1237 +++++++
 .../infiniband/hw/ionic/ionic_controlpath.c   | 2900 +++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_datapath.c  | 1422 ++++++++
 drivers/infiniband/hw/ionic/ionic_fw.h        | 1031 ++++++
 drivers/infiniband/hw/ionic/ionic_hw_stats.c  |  484 +++
 drivers/infiniband/hw/ionic/ionic_ibdev.c     |  546 ++++
 drivers/infiniband/hw/ionic/ionic_ibdev.h     |  540 +++
 drivers/infiniband/hw/ionic/ionic_pgtbl.c     |  143 +
 drivers/infiniband/hw/ionic/ionic_queue.c     |   52 +
 drivers/infiniband/hw/ionic/ionic_queue.h     |  234 ++
 drivers/infiniband/hw/ionic/ionic_res.c       |   42 +
 drivers/infiniband/hw/ionic/ionic_res.h       |  182 ++
 drivers/net/ethernet/pensando/Kconfig         |    1 +
 drivers/net/ethernet/pensando/ionic/Makefile  |    2 +-
 drivers/net/ethernet/pensando/ionic/ionic.h   |   12 +-
 .../net/ethernet/pensando/ionic/ionic_api.c   |  214 ++
 .../net/ethernet/pensando/ionic/ionic_aux.c   |   95 +
 .../net/ethernet/pensando/ionic/ionic_aux.h   |   10 +
 .../net/ethernet/pensando/ionic/ionic_bus.h   |    1 +
 .../ethernet/pensando/ionic/ionic_bus_pci.c   |   13 +
 .../net/ethernet/pensando/ionic/ionic_dev.c   |  268 +-
 .../net/ethernet/pensando/ionic/ionic_dev.h   |   28 +-
 .../net/ethernet/pensando/ionic/ionic_lif.c   |   70 +-
 .../net/ethernet/pensando/ionic/ionic_lif.h   |   21 +-
 .../net/ethernet/pensando/ionic/ionic_main.c  |    2 +-
 include/linux/ionic/ionic_api.h               |  240 ++
 .../linux}/ionic/ionic_if.h                   |  115 +-
 .../linux}/ionic/ionic_regs.h                 |    0
 include/uapi/rdma/ib_user_ioctl_verbs.h       |    1 +
 include/uapi/rdma/ionic-abi.h                 |  115 +
 36 files changed, 10032 insertions(+), 69 deletions(-)
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
 create mode 100644 drivers/infiniband/hw/ionic/ionic_pgtbl.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_queue.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_queue.h
 create mode 100644 drivers/infiniband/hw/ionic/ionic_res.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_res.h
 create mode 100644 drivers/net/ethernet/pensando/ionic/ionic_api.c
 create mode 100644 drivers/net/ethernet/pensando/ionic/ionic_aux.c
 create mode 100644 drivers/net/ethernet/pensando/ionic/ionic_aux.h
 create mode 100644 include/linux/ionic/ionic_api.h
 rename {drivers/net/ethernet/pensando => include/linux}/ionic/ionic_if.h (96%)
 rename {drivers/net/ethernet/pensando => include/linux}/ionic/ionic_regs.h (100%)
 create mode 100644 include/uapi/rdma/ionic-abi.h

-- 
2.34.1


