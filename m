Return-Path: <linux-rdma+bounces-13047-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0889B414D5
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 08:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EED95E624D
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 06:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDDB2D63F4;
	Wed,  3 Sep 2025 06:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qOUawXk/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20482C18A;
	Wed,  3 Sep 2025 06:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756880246; cv=fail; b=I9PwAwxOhSN7R3wnaaPs7ATFG2YxX8V3Y5Nzwj1DJGuEb1rRVLfvEVByM3OQm33SVP+jUuxlYGthIK2ufofDdGUU8O5+ZsyNJgtKzw0UOpyvVbK1PPlrKlUSBsCPE2H5XflzpU2QBxuoLw51qFAyW8muz4eeXkGoLG/PzetBEAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756880246; c=relaxed/simple;
	bh=3ZgbQXyaHOO/MjkRoeaM2F9BN/k0Oxva15RMt0s/i/g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pcdRCf93/3nZJHEl8rnsqlthrCWeiXc2lpz2DJV3GYPXypDppqDybpPNTZKNsEnuIp99FtMCkTzGG+Fm64KQvyveKFUPkaLR1CihJeiVUd2E0XQubL+kPxt33Vg9TpUZtMmWVVIJHwKs412wO0LWKUwWWRY5I5KGxOEfA5a60xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qOUawXk/; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuL1IuNqH9kQR3ZejfI0Y+hS3GpjLQSDEruMM7ujB1ZBpxgdI0smxV5CsCvL8EQez6E+en61/BwKdzCvIsuDlA1fP/I2ZVm+AM6TB3d9Glzb7mPcOuShpIbWjezFoBMz7njGGylgWymwh9sZkiPfKk6dgmyhopSmPdgvSHWV9Iadu4xxhKVk+iJgbeyxpHSZA1RzVbqo6RRsCk0vMkK8GvjWhLw0NF2xwDQH1DvihYrUkrObHBlnmUM0//wwY2WOv+Kl9JogNKPIdyyXx12v3B+Uu4XOLf+gAsPvN+QwuJGsi1LCpf+B7BdhS70RfWvfL97mE6cJiRslCpbFbN6C5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHgHOwW0kfyO++BK0S5WrKEQMKP/9YwTSbVGUJWpUNI=;
 b=v3sjvt6jZnOR3HWi1uW/1qqoP25QLZHLuk7O4NDPN9Pr1QNBk+UDEWos3ehnCsNE+HZkIVV2ZRZNi/wam6+ZBMOCLmryl4dT7gFhKZ7f1N3lWuMqUTDIZFNuL4p4KXM1SDTJ7puzrrVtbsIuwunhZv7D9+PSQeJVMNGj/IhbNnzUq06xDC+hpX71h8Zrm5x08kKqOCxeYyfpwa9fr5FkBETfciH4mpISRYbqHgUzGJOCaZFMoBPwFFRm6otqm2XRuBtX+le5WD600nIJMkLjoB0UtB6iwTcF/CtXf6otflYMuft6H8v4b194N89PmVFp2yFTiZdS9Sz0ceCxZXz51g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHgHOwW0kfyO++BK0S5WrKEQMKP/9YwTSbVGUJWpUNI=;
 b=qOUawXk/Mgil7QGuyid4aTG2+gzwdVDK+yBXI/vwKh/fsxq7/DAKffpMRd2yg/Mf/CRsRUbYp0epCHBw2StwISCBxIRKN++BFQlPeJDALKjloy0nD/rMBXVREu5QjVC+uBP+kXufTGfbsA3A/7Q4ca7JBFBu9iPauEOfTC4RASY=
Received: from CH0P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::26)
 by DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 06:17:20 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::b1) by CH0P223CA0011.outlook.office365.com
 (2603:10b6:610:116::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Wed,
 3 Sep 2025 06:17:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 06:17:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 01:17:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 01:17:16 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 3 Sep 2025 01:17:12 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <sln@onemain.com>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v6 00/14] Introduce AMD Pensando RDMA driver
Date: Wed, 3 Sep 2025 11:45:52 +0530
Message-ID: <20250903061606.4139957-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|DS2PR12MB9567:EE_
X-MS-Office365-Filtering-Correlation-Id: fc15f76c-44b8-4419-2092-08ddeab18846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azkxcWhZcGNvZllWbDJtemd3QmthNlMwN1dCS0d5SkVhODNVVFQvZFFkWi9t?=
 =?utf-8?B?cTkxRUxIeE5uL3RRQlU2em4xOE95SzhKbUpYVUtWZncrS2N4aGNWVlRNK1FT?=
 =?utf-8?B?M210T2wyZlB3TTJ4ZWFHYTBDK0RwbmJGMHR0bjQ3TExwcjhxbHFLam5zNzNm?=
 =?utf-8?B?em1hdEUvMjdXWWdFTzR6YTFnTkxzT3VIczZSNXdiRTFSVUJ5cCtzT2g1a25F?=
 =?utf-8?B?YUFMZzNqVFdMcUNhcGsvaGlBMy92d211SlY5TUN5cnEreWZIY3RHOFlSb29w?=
 =?utf-8?B?OUVORUdycXZjakhydVZRQnNZWnhMc1BLdElTSlMycURRRmpOVzJ2UUxtZXlO?=
 =?utf-8?B?Tm1rOFFmaGdIR2NRblk4Rm93aHQ0ZE9IclQrWlpYMGZ0c2VBbHF6YjVYQkxt?=
 =?utf-8?B?bytkZmFNTk1oRUJjUkNReFJkRWhqTVVFTnBnSVhUSkRmenlEamZjeDhOWFAy?=
 =?utf-8?B?TEhvMnU3Tk1EZVdPR2lmb0MxeTNxU3hpUDJmY0V4MW9ndll3VG9QRUl4OXJz?=
 =?utf-8?B?NmpVNFY0K2VtWW1zTlRDc3plcDF4REYwT1ZMSENOQzdQRzNXTzlMYVduVXdi?=
 =?utf-8?B?M3NrZ1VkOS8zaVMwNmVFdkZLVlQ2cENlcTgrMHBXMk1vRW8zMy9XZWVpVTVB?=
 =?utf-8?B?bm9SNWNzVjRsSnByOEZUY0hiUTBBVTFjNHZnR1ZHMkg1b1MyT01Ta3pWQVdE?=
 =?utf-8?B?d0RPVjNhVVJsWXpGM0Y4TlFoZDZVbDRSWWR2bndVNWpBY3R3djZnOWhoY2pJ?=
 =?utf-8?B?MFFkUDEwOGFmQm9BLzdIRzF6UitiUGtpcnFNZUFTVUFqRnd2a1kzRzU3bjlH?=
 =?utf-8?B?TE1tY3I3SGhTNEp3M2NwR0JhT0VScjJHMnVpYnZaZWFlSXZhN2pCLzJ6OS9F?=
 =?utf-8?B?YVluam91WWt6Vk5MV2pwSUZzOEpRVFl3eFFnaEYyamlITW5sMllRU1ZiNWVY?=
 =?utf-8?B?RysxckVVTGZxNDk5RFVGSWpLQ0VmU1oxQ3lGWEhrd2l1VUJQVy80TUF1cFdV?=
 =?utf-8?B?dkdEQ004T0xrYkZ1Q0FkZTJ3SXRuT0w4c0hCZnZhQlZGQjZiOCtEem1KZmZt?=
 =?utf-8?B?d25nTWVLKytXOXI5NGFSLy9Wd25UQU96djFtb2p2R1lOYTNXbHliL3E1L3Jv?=
 =?utf-8?B?ejNGTU91VDdVVnViSEJ6aHJ3Wm4zNjFZUFhiOTBnZFV6bitPMDhsbFE3S2s2?=
 =?utf-8?B?WEFDYTU3M1ZkRWcraVE0KzVDN2FCZE5UaXlLYUVwZ1N6cVpsZy9mbWFWSEpx?=
 =?utf-8?B?R1Z3dkhGNHlkYVZaRzROSTFFVmRqZE1GaHlHa2tBdTZjd0hFYS9LL0g1aEhn?=
 =?utf-8?B?SkZyWHJPU0NXNDBiTDMvd3RwRjR0ZUp0S0tQaXYyZmxtU2VYSC94VDFuRExj?=
 =?utf-8?B?YTZZRk5qZVBTUjJ6dTV1NVlRM3ExbUhIclR0Y0ZEVjRwODEyamJBcWRKdVRq?=
 =?utf-8?B?OWszWmdhN1lZbkRBV29uZ05TQVgwVVN2dGh1cnJXdHFiSmozMldWU2pMTEJU?=
 =?utf-8?B?OE5XdmxISnpHU3lUVmpicUZ2Sm5CeXA3Uy9zNmU2WGp2dlA0QVcyWjF4dDNs?=
 =?utf-8?B?Yk1hMGllZkMvOTVmbmxLZzhWRzRCV0c5eVFEelBUdVg5QSt4eHBhTlN4Vmpw?=
 =?utf-8?B?b0dVSEc0Mkx2ZzBuSUVHNWpIRTVQRzZCOEswbVpDWGQrOXFWdFU1K3ZWZjkv?=
 =?utf-8?B?SFMwZ2YxdXFIZk1ISTZCbGpvSWVtbTFVWGZGbHRPYzJkdTI5bkNlazd4aW9J?=
 =?utf-8?B?U3JMcjM0dlNlZFBWN3lHUU9TRk5jaWtBUktCTmdHWTFTa3ozVnFRWk8wMCs4?=
 =?utf-8?B?UHpqMXRWWHpNUEoxRWErUEprRVZ1V3I5OXpiaTRoM3g5SXlCWXlEd0ZIZ0Nx?=
 =?utf-8?B?ODc0bmdoWTVtNVdDWGR0R2p5QnhqZkFhMjdNVytEZUo1cHYzNDlBR1EyZVU2?=
 =?utf-8?B?WXpKZVdENUlScGxGeEhvbEZtZUdydkNTVmFwalpDTEpRS1d4dEd6WGxCd2th?=
 =?utf-8?B?ZmdrZG5iTFV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 06:17:17.2085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc15f76c-44b8-4419-2092-08ddeab18846
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9567

This patchset introduces an RDMA driver for the AMD Pensando adapter.
An AMD Pensando Ethernet device with RDMA capabilities extends its
functionality through an auxiliary device.

The first 6 patches of the series modify the ionic Ethernet driver
to support the RDMA driver. The ionic RDMA driver implementation is
split into the remaining 8 patches.

The user-mode of the driver is being reviewed at:
https://github.com/linux-rdma/rdma-core/pull/1620

v5->v6
  - Updated documentation
  - Removed unused ib op
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
 drivers/infiniband/hw/ionic/ionic_datapath.c  | 1399 +++++++++
 drivers/infiniband/hw/ionic/ionic_fw.h        | 1029 +++++++
 drivers/infiniband/hw/ionic/ionic_hw_stats.c  |  484 +++
 drivers/infiniband/hw/ionic/ionic_ibdev.c     |  440 +++
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
 36 files changed, 9416 insertions(+), 64 deletions(-)
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


base-commit: 2aa35b24ad12fb960d30e9e282f768e1a0af9291
-- 
2.43.0


