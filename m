Return-Path: <linux-rdma+bounces-12429-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CE9B0F90E
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 19:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D07EF7B0EAE
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 17:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B677205AD7;
	Wed, 23 Jul 2025 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mMLCg361"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18082E36ED;
	Wed, 23 Jul 2025 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291926; cv=fail; b=U+uAcGuNxw3J0bZHKtgl6X/xSpelwXuuPnH/kJpITQ16aDwOWCkdkgpOpjVOQ8KuOdR4rEgw0u/27zpkM3KlVCkbkPbv25PvQHEeSQ6joCFh57Yj/0C9LvRil9IocRL4R+IOd19rTKY5QLd8244GVyZrF4MENxlAIwn0uYBXSZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291926; c=relaxed/simple;
	bh=A7g7T244Mpyzh3Uolz08HkIRaLQy9j3FhSN5ttFN5eU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wx8pB4MSj7V1IaQhV/I4imVeCEqFq2fmiP+AA5eFTPEJZeIznkn4/DLxH9a4yLwbWE3OjBbVyZOQR1mJf8GYzxbRTFPduYlmvSaJ+EKGaIdl5qMylRUBgbLMGMQoRBsx36XvyqYGNtmNhB5WHgozwA9qg600es2euYgBybsfs8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mMLCg361; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtsAuZ3Iguj0tfu/Uwupe9DCE/R5cZQYpQc/EKttJYpijaYRbiE8P4VMPzlGfQiLYW9CyaLmdf2SzB9AzAIsdVuETD4rwY0btrsAiI+wRXWjPzH6wDhrrQ/IWhZqNKzlqD1ZxJcgmuGB0INGqKD73l6gBOVsTdB4T7iphqabrV87BZCZ0b2gZMHUgkL5c0iySYzXd+INLcdgtXBo0K572LNlZdyIy1uJmCbhVV+pEHZPFRFt5skk8BWE0FUHb5wBweOWZ4jYSIw5dvDU0pDnHY0RNL6CMbVhQYvC8oNxHQx6bovSJX5hbYeL7zdoizYiyfzFivMSUXnpRLYsPoZSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtIPecuSrvAs3KueJV5JjScDR/MMct3bXoBF45UVFdM=;
 b=I6w3h+mnc+QhhZopDxV7fuggPK82MCAMwJVCkgaqtfjNMSR8+M2ezMpSiG01pDslGlzWYkH8AyyX/i/IgAegDbu8Jz9Y+TGJn4ND+KOQyhEpaGW6EfvFTK4F+ybbr3gVSGIDwQtJuwXEGJEmuVJ80lusf17rNkzt+65mGLEOrQd5PQ1QibtDBHcTnFe8ZcvdpjCFMvfvanLdFW7OHV3bPjNpMMEFk4XGxFoFa6GKVAftdmzXwe7A/1l2slq3S1UascuAo7eipWfEVAxJPvm5To4Tif07kmSVYZM6GljKhYkoKZ1U/bEnMmIs0KFPCilRVi10N2FnqDNjiEGs6bkc6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtIPecuSrvAs3KueJV5JjScDR/MMct3bXoBF45UVFdM=;
 b=mMLCg361gsyTcQToh6aIxy8iy7O91p5SjEpE0deCMZsCn6bx8487XCRl0gOzxZtyzJYquLqTTw8EwIFSy2g3fCZQASxRhQ45oweiIDbyBJNIuBQZz7wahIziBYTax7aOgCaXVPorNEer5oew5B9+x1qKMwcQkwel07AYaXx5Z7s=
Received: from PH7P221CA0043.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::31)
 by DS4PR12MB9770.namprd12.prod.outlook.com (2603:10b6:8:29d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 17:32:00 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::b3) by PH7P221CA0043.outlook.office365.com
 (2603:10b6:510:33c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.30 via Frontend Transport; Wed,
 23 Jul 2025 17:32:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 17:31:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 12:31:58 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 23 Jul 2025 12:31:54 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v4 00/14] Introduce AMD Pensando RDMA driver
Date: Wed, 23 Jul 2025 23:01:35 +0530
Message-ID: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DS4PR12MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c4c80e1-7372-489e-8f8a-08ddca0ed451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1RteFJjZmdLUEpMQkJDNlAyWk82ZEtjZTlkeGZlTWQ1emdKU1ZpN0M2QVli?=
 =?utf-8?B?K05rc2VCUnVaQnViM0ZSbUlXMzkwbFN0VlFFUVIwQnozOFhzTW9jaENyLzJH?=
 =?utf-8?B?L3NyZzVFRDdBL3hIRjJDanZkcmZidzIvdHZhV3JKOTRpVmVNZW1tNzlJZ1U5?=
 =?utf-8?B?WTBMOWNCR1Q4WHZsU29GNzRQNzl3N2FJR0NOV1BJcUo5Vy9BdmlPTzhrZWpO?=
 =?utf-8?B?bW9SWHhldS9VWXJwVjhUVk56cUJoZU5uSi92cXJmOTlybmNKWW9oaE5HZnY0?=
 =?utf-8?B?cTE0anhMWEprNUhVSS9BYmVVMHZZdlkyRW1OVWxUdm5WdnFHT0NIMlZlemlQ?=
 =?utf-8?B?aEZFaDRvTENkNzZhdnZYWXZTMFl3Zk5zd3diOGpyQ25OWTdqNjZiNStaQm1s?=
 =?utf-8?B?czdQdS9veVc5MDhvUVJlcWZwbFFnc2JXVklXdEswWVg1OThRK2xndEtocm5m?=
 =?utf-8?B?RWp6U2paOHRYY05FTi9TTG5Rcll3dkNvWEpDanREK1BTbHpiSHY2T2dUclJ0?=
 =?utf-8?B?T2k4V29UY1c1LzN0N2REMFBwK3dFN2lLZmN5dWMvc0JseWtqYUdlaHBSV2ll?=
 =?utf-8?B?V3BsU25USURydy9zaUE4cVBkbE1iOENYb2dsTGNUSXpWaHBoV01ScjFZRnhQ?=
 =?utf-8?B?MFdLZVpabk5USlFoMjBZalZOU0luK01KMDlaWUdKWGhyWkllbzJKcklJS1hv?=
 =?utf-8?B?bjQ2MmNCU1gzeXFYbkVJMWN4YzYyZUFNekszWGRicVVJZFplMklDWjA0SVNG?=
 =?utf-8?B?czlmeU5hSy9kM3hUdlZMVXpFSSsrUzlEekVwMUZ6TThvUTFhMUlUNk5NbnZN?=
 =?utf-8?B?VEwyU1ZIVzY3b2RCbGkxN3NyUENUdEV5cVJQaWFYYVB2UzNUQU5MbVV2azBK?=
 =?utf-8?B?TGhxVWExQjk3LzhJc3d2SDExeDljKzRrekxjRStlUDRFZFFYNVRnZGlBVlRQ?=
 =?utf-8?B?ZWpvWW1RMlRva3JqT3RjcEdkNXQ5UUU4bjZQMXdMZ2JiNC9NeVl1NDc0aFUy?=
 =?utf-8?B?eU1KRm03cnNJREdtcktDZy8vcDBrbFowdjJ5a0hKRGQvTDlZWHoxdWZTSXJB?=
 =?utf-8?B?d1VRc3pUNFhiQ1pPcHkxZVVnY3Y3eFM1SklxcDFGU2JkQTRVQ2lISlpxWEZB?=
 =?utf-8?B?WDB4U0V5UWdyWDJNcHhjemxWRm1hOFZFNFQ4MGNtWXh2TzVPWnBlaUNROXNm?=
 =?utf-8?B?dG5Gbkh2WkFlbHZwQWFFWHcyZjUyakl6b0doSjJML2wwNDVQZlFMLytMaWxB?=
 =?utf-8?B?bXhTRjVHK1duZEpOWGlkKzdUVzFrSGR6LzRUdjB0L1kwMDd2TFBqQmRabU9M?=
 =?utf-8?B?dTFwQjR0Wk8vMFl1ZzdpZFUwL28yOXByZGtLak4rcGNSc1lVNUM2MHd0Smlr?=
 =?utf-8?B?djRyV25xNjNrRURId0FUVE1CTjZWbFV3QmJOblhETm1KaU5jMEJzSndKY2JY?=
 =?utf-8?B?TnhhTW80RGJxOEJ2eGdZMS9oNlF6cFJzRUx5REVQZ3paZE05aHdkT2ZzTER5?=
 =?utf-8?B?QmlJS05qekJ5QnUwVGJYRUlkNTI0ejNlN1JEb0g1SjUzdWFWYVNSdnFpQzZw?=
 =?utf-8?B?ZXArdWZpa2Z1VjV0amhndWtsZnFxWEpHOGt0d3JTdzRZRENZemJQMHN2Q3Mr?=
 =?utf-8?B?OHN1Wk1jS25GR2E5eWJBSytoUGxaMEI5RDV1OFFZa0Y1cVBuZDVaUngrVi9y?=
 =?utf-8?B?cHVTVk9Ta2hUMnhNMzQwMFRTdzk5aHRkYTBPQlZ4Z1ZFV3BjUEVkbkw4TWpw?=
 =?utf-8?B?bjIyRHVSTXNVcGFyRDdTWFZwRGgwSmwxeVY4UUVibm0rOWczYXd0My9veEM4?=
 =?utf-8?B?SCtld0VXYTM2OHVOSVJZZ25pZmZqV05xa0FySnhrTWtyWlhEMFpxemR6VVlv?=
 =?utf-8?B?TW5pdjArdVBkU3FndnhBcUdITytPcm0wNythdE5aWFYvZDNWMXNPVXlua3h1?=
 =?utf-8?B?LzZ0cVcxTlErYlFRQkNtbml0TzljVllYay9ZMmozcDYwVDhpbTIyVE1sVmNv?=
 =?utf-8?B?aEF5NnF6UkxDdGFqY01PSjR6a0c4bGNSM0x2UU1rSFc5N3RPZGRuMnViRGpO?=
 =?utf-8?B?bGNoZUw4L2JXckQ5NWdTNDJ6SHRuYW5NKy9mUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 17:31:59.6065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4c80e1-7372-489e-8f8a-08ddca0ed451
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9770

This patchset introduces an RDMA driver for the AMD Pensando adapter.
An AMD Pensando Ethernet device with RDMA capabilities extends its
functionality through an auxiliary device.

The first 6 patches of the series modify the ionic Ethernet driver
to support the RDMA driver. The ionic RDMA driver implementation is
split into the remaining 8 patches.

The user-mode of the driver is being reviewed at:
https://github.com/linux-rdma/rdma-core/pull/1620

v3->v4
  - Used xa lock instead of rcu lock for qp and cq access
  - Removed empty labels
  - Improved comments
  - Removed unwanted warning and error prints.
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
 drivers/infiniband/hw/ionic/ionic_admin.c     | 1228 ++++++++
 .../infiniband/hw/ionic/ionic_controlpath.c   | 2671 +++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_datapath.c  | 1392 +++++++++
 drivers/infiniband/hw/ionic/ionic_fw.h        | 1029 +++++++
 drivers/infiniband/hw/ionic/ionic_hw_stats.c  |  484 +++
 drivers/infiniband/hw/ionic/ionic_ibdev.c     |  452 +++
 drivers/infiniband/hw/ionic/ionic_ibdev.h     |  515 ++++
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c   |  111 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h   |   66 +
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
 35 files changed, 9407 insertions(+), 64 deletions(-)
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


base-commit: e1bed9a94da86a7c01b985c2e9a030207269cbc7
-- 
2.43.0


