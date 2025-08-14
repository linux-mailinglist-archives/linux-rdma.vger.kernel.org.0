Return-Path: <linux-rdma+bounces-12732-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C88BB25ADB
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 07:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA44C684BC9
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 05:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155FD221736;
	Thu, 14 Aug 2025 05:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ft3Q95U6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B6A1E3DFE;
	Thu, 14 Aug 2025 05:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755149962; cv=fail; b=fcAasvHVB7f/yXoOm5Dz4xK7BOscECd3UXRkBE7gV+EEqc6K71WbTG7n9KaReiVP+hwl9Vv8mQRoejc3Z2y/9TKPH3Inea/zb5xpTgqvrkbYQqT3dDE1Uf+u90Z8PPx6YkPd8KqmRFRvztjLMJXpLrcvpSrKjQ4h9HEtf+ntqSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755149962; c=relaxed/simple;
	bh=SlnmTGalpi8ZMoUVwefy9ottM4wshRYugRQMAWNT+V4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dWMB3bKzu/Vv4ZBNL9sMeFqjihJzU/xMKQyOoLb9y/4+v8kReHZxEf5Rf5xAhPouYcJdHzTAKb1kiyppe7MbjF2UGrPmZfS+/MAtd3cci+JmMJzGoX0qCl8x8SJU5BEhf1uraapnKdxpdwVOeyMz1UC5tqftjdr1qyyDvkHnp6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ft3Q95U6; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YW6IPB3Hf2fQp4b8iWtbzK84nuNDR9jPqEp3H3B0U1JNzWMjwzR1JkzRPHrrRmY1txVeuRmcwrZkdHm2PlQ6ZKQ98OCqhDYkzImwaPTvE+8QO3MXAhnOgRG3wSD4syDmKISnTG30WFkIc63tl5AE1ixw5Scz2opo0XPrMaO1QKfJxe4ubynpyhUGMyTUzRhKxShsI4C5kHqBKIVBEuLT9l9HE3dyZ9+MuowzYbK7L/aMXPM8EOXf09v6kGhcOy/v29nvfHljVMTKQDO+5HvAKBlV5Ubaa1848w/0/bKSbP7NvoXuObsN7w2FTzgcH66YDeCORQDKrO5b2gV03Ad/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u26LbOFiv2e1piQu6/WctApVofAunxQ1aH0H7JaD0wc=;
 b=ICjkSiQ//HoFQisuVF6gEZxq6F33FjQAVx6EG6YnNzTzTwKIcCAqzAIYrXfQkSIFdQBwxhhLw5qmFH8eMLxlVPky+DiCpdCIfRXvbGdtTRypUia7T7FHNpduJNAPsFpVYvOmAEJP6mORWpIGVQX9xEQE83JSHrXOpf5XNM4dZqwTM7nX7tVMrI291JRf53ZKRGMOIlZPlKvLk61eh47kAFN/JBycQKmCwKJHsbxWuiI4iTfJF3WIIx7WwzAIG83oZaxz1NKXC7GQZFG2Eg4HwPtT3DWVqY0HZUGMTYZ3XhLuP81PQdt6xbmpESpy0r5eAl7Xesiga+SaqMWsiFvmMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u26LbOFiv2e1piQu6/WctApVofAunxQ1aH0H7JaD0wc=;
 b=ft3Q95U6KqDH3FLdafRfzUbsb5NiHEmCb90AyG88p5+FOiPXReQMelhX0OSJtVGXaKgN4k5115ihr8UPeaR2n1XJmTsxB6519tmoFU/gURZgATXwMTo+38dZ6C1zJpjMHO10NwY1QFlGpfl5gw0XQskjhqdxEm+c2f/jdm9OxFc=
Received: from DM6PR04CA0024.namprd04.prod.outlook.com (2603:10b6:5:334::29)
 by DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Thu, 14 Aug
 2025 05:39:16 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::f7) by DM6PR04CA0024.outlook.office365.com
 (2603:10b6:5:334::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Thu,
 14 Aug 2025 05:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 05:39:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 00:39:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 13 Aug
 2025 22:39:14 -0700
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 14 Aug 2025 00:39:11 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <sln@onemain.com>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v5 00/14] Introduce AMD Pensando RDMA driver
Date: Thu, 14 Aug 2025 11:08:46 +0530
Message-ID: <20250814053900.1452408-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: e822cefb-4383-4fca-77ca-08dddaf4e832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkdUZjVEWmVKa1RBVDVyWTJQMTJzb2g2cU41QXNSTWxGN2tvYTZRVTV2VFI0?=
 =?utf-8?B?WnM1U3ZYUHVwMXd4aTlDVnJyc3VoUVdkZk1oWDhXZGVrbm5rUWZ2ekhDUXhE?=
 =?utf-8?B?MytyTXdtS2JaOHNtZUR6aTh0dnBCVVBid25zQVNXMzhKdWluTEYxOWFnekRC?=
 =?utf-8?B?cFJockt4Sm1KQ0J0KzlqV0VkZW01eDhkZDYwY0E5MjBweUJHQVdmM294cVBY?=
 =?utf-8?B?VHJYN01kNlNUanVnSGQ2S1JwUUJLL20wSVRjamVIMS9lNlJTMElCY0JQSEE0?=
 =?utf-8?B?QXJBNDZCM2tBbFVjbW5vYWxOdGl5SkFSdFV3dytlVDZaNDB0UGtIWW9yeldj?=
 =?utf-8?B?dDdPUk1IcTYrRVB0RXpOaDJYbU1VZlJUWjJzWGdjU2hiY2RvYktlY0xvTFdE?=
 =?utf-8?B?ZFFWOCtOS040Z1cvaGZoSDZlTVpWNWY2eVdlZFdBV0NXQzNEdWVFMmFTZkNZ?=
 =?utf-8?B?SlYxQjJ2SjM4ZE50eTZWbTd1N0RPeFVtNzFZRERzSkk5bVFibHJWUXcwYnRQ?=
 =?utf-8?B?dFRKaWJmVmk5a3kzNFJua1kwSEgwUmNMSGtkZjJzdW5tK21RL0hHdVljVElY?=
 =?utf-8?B?TEdlZWg3T0ZuL1p3cGlVMGE2dkJnY3VKUFJLczhhTmZJUHlJUUcwdGRpQ0JU?=
 =?utf-8?B?dmdWTWdyZVdMQmRwTWxiZzB4RXpFeWVRYUI0MU9HaGticlBYcnVVRnE1bGIw?=
 =?utf-8?B?V055OEo1bmFZQWttLzNIdXRRVjlRZVJHR0paUGNpbVo4dWpCZDhMeHpXeXJ4?=
 =?utf-8?B?eFUwSy9JUkRlOFp2eDBwY3BvVEFteDdjTUJhNGY1ekcyR1ArdjhxMVNtT0lq?=
 =?utf-8?B?UlRpRFRHNlI4Y3kveWU5YWR3Q29LREVGd2V4WVFadzJpZzdqWnRQME9qYk9j?=
 =?utf-8?B?dWQwa0cyZzgxYUU1OW9YSHFGVlZ5NERJYVZ1NzBmejNpMmN0UktIWkdVREdG?=
 =?utf-8?B?WjEwbDdpUUVmTkRUREZmSzBPZEh0aTI3QUltbldXQXNudzdHRDN5UW0vVnhS?=
 =?utf-8?B?Vk1vSzlJUmUrNWVGZjBCaXNYYUpUanV3K1U2WkoxUXprV1dEZmFWb283UE1H?=
 =?utf-8?B?UU5SSVJ3NGJFUkZ3VVE3TDNKWnN2S3o5NHJtSndUSHZwWEpDZ3NrdGFWOStp?=
 =?utf-8?B?MlV3WHo5ZHcwVi9sSVJaVjc2enQ5OEtrcFUvS1R5Ymhwb3hNK2o3elVseGRz?=
 =?utf-8?B?NzA3K3N1V1VtcmYwTFJKSm1YVkZwWllTSDVhUjBwaG4yUlhYYW1kcjVkUlUx?=
 =?utf-8?B?TEo2eTBpMnYzOFp6b0M2b3RPU0J0V0JaZzN4TEk4Mmh2ZTdSaDZiQ2lmWk52?=
 =?utf-8?B?MmEwMjBlRUIyS2xHVTZLSXAzYjVYeUdqcFVQN0RURE4rZHFEMkl5OGRFTlBs?=
 =?utf-8?B?R3JzUjhMT2R3aFZqMmIzSzdvUzNLNFFhR2dFZzZwc056dTNYd1pYc0RGS3cy?=
 =?utf-8?B?TFhzWHZqZjFiNTNPdkJiTmw0TDF5bGR2bkR4bm9SbDBjVFIyZlNvaFp0MFhz?=
 =?utf-8?B?Q0gvY2VYbGlqUzJWWTR6N0dXQWhoMVMvZTYySjJhVEh2SE9CdnlsYS9hSmp1?=
 =?utf-8?B?eTExeVNxZEQ0SmluN3NYQmU3c2xOSVNhLyt2a1JNVzNkSGJRQkI2K1ZkRlM0?=
 =?utf-8?B?SFlnUTNvSGpaMXdkdk1ydmE2V0dKNFd6WlQ5R1V6Y2VWcGdHV0R3azJ1Z0hr?=
 =?utf-8?B?c1BkdDZWVVg2OXB5Z1JvMTFWc1JnbGRhWjBEdTE5ZnJXYmI1TmlOK3pyeFE0?=
 =?utf-8?B?eWY1YUg5a1krWFpaKzdzYVo0YWE1SkYxYndHOVVtZ2RjQXd0dG95Q25XSTBC?=
 =?utf-8?B?V3Q2ZUwxYzdoVFBuVjhwWmV3Q05YVnM0NTlCbExVYXdUYzlYVE5yZ3lzb2pB?=
 =?utf-8?B?M2lVL1VCeDhXRThTRjNNTDlxREFSTVlzZVV6NDVWbDBMVGtrNEltKys5Vkw0?=
 =?utf-8?B?ZDhTNHZjTXU1ckVlZEJ1QTlyd2dYWDYwb1lHNlBQRG96MnBkTmdMN1oxd1VU?=
 =?utf-8?B?aWRlcGQzTGhKVlpCR2JheDFnQnFhNnpLcXJjd1JiQkdyb2VUbWdGYUFDVlpQ?=
 =?utf-8?B?YWFRNTE2OE53eHlrWnZDU0huK1J5OUNtM2oyUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 05:39:15.8165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e822cefb-4383-4fca-77ca-08dddaf4e832
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352

This patchset introduces an RDMA driver for the AMD Pensando adapter.
An AMD Pensando Ethernet device with RDMA capabilities extends its
functionality through an auxiliary device.

The first 6 patches of the series modify the ionic Ethernet driver
to support the RDMA driver. The ionic RDMA driver implementation is
split into the remaining 8 patches.

The user-mode of the driver is being reviewed at:
https://github.com/linux-rdma/rdma-core/pull/1620

v4->v5
  - Updated documentation
  - Fixed error path in aux device creation
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
 .../ethernet/pensando/ionic.rst               |   10 +
 .../ethernet/pensando/ionic_rdma.rst          |   52 +
 MAINTAINERS                                   |    9 +
 drivers/infiniband/Kconfig                    |    1 +
 drivers/infiniband/hw/Makefile                |    1 +
 drivers/infiniband/hw/ionic/Kconfig           |   15 +
 drivers/infiniband/hw/ionic/Makefile          |    9 +
 drivers/infiniband/hw/ionic/ionic_admin.c     | 1228 ++++++++
 .../infiniband/hw/ionic/ionic_controlpath.c   | 2679 +++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_datapath.c  | 1392 +++++++++
 drivers/infiniband/hw/ionic/ionic_fw.h        | 1029 +++++++
 drivers/infiniband/hw/ionic/ionic_hw_stats.c  |  484 +++
 drivers/infiniband/hw/ionic/ionic_ibdev.c     |  452 +++
 drivers/infiniband/hw/ionic/ionic_ibdev.h     |  517 ++++
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
 .../net/ethernet/pensando/ionic/ionic_aux.c   |  102 +
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
 36 files changed, 9421 insertions(+), 64 deletions(-)
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


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.43.0


