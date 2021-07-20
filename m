Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3AF3CF5F1
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhGTHhA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:37:00 -0400
Received: from mail-bn7nam10on2062.outbound.protection.outlook.com ([40.107.92.62]:41664
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233945AbhGTHg4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:36:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VM09BLtq0WiSrUFq7fWeks3BcEXIHJPDr8yvWrbgdXEKIwgDk513i+4Ib3fBGcpMxQjuOCtS/kLWURzIHfSuCB1QdsjvJ9U/M8+c6kvSuX8vYfyyQI1GCZzQnEnd1tmwrT53u4uP0SC2el88Z4cjdEqcGhLXRCTNlqFbSNd0YWiJL0EqJb+lbCDLLdjyQufVkBWnmKCZkLlFYNQ2i9XIy4CQgq62y1hevC9ODwKZ/PVL5RvUSmK3oKc5PlpuZE2K7zH4+pc2ZqhJ0SJmy/DSE02B/bRPiez3zgjK8c4Slzlhsv7sq/A14x23oWr0lr0nTK2o7alGndqZO6/WAxy0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QIR0msEHqcRSyD6jFjMXtD+y2mOCzJJahiGAyyMDfE=;
 b=VrMXb0kYm6hj5oXUBKszzxBG+fD95qaBkZW//K8mcuVjUFzQmkXzax1/2tPkEl29n9VBPcddisqnEOK+sgX+5o+YmI4KMvpDVQmi2AfRTUdZMRMTJDEknCVAHhmvEhiTVVPuAl1ThKuzGsEARSyHJlg93MUI3mx6RJZdTDc+3hQ7OVxfZWz3ZtPg2x/KqZifNls9rRvwpfsvb0CqEugIFj24pPUQdX40EXt4AOUCLZgBJg8Wl0l6n8aYuym0WjZVb/6dz/QCZrIpMLGcdxLjmLYiKle/WKQPY9DoGB5wcMLpZS70slwSX1hogk9S6+xH2yv7V19U4kohlr1ez8j2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QIR0msEHqcRSyD6jFjMXtD+y2mOCzJJahiGAyyMDfE=;
 b=lNoOya3ifA4pdXgp7mhu1/lGyrgMhrM6Z9qCDzgKKxv/CYSn85O6mOcvOYCqpLJ1Joj0Gp4/ErdBNhhtu/6TRiJcC4rbwVw3MqDQUur7Mz3+tab1tIGUGOInDgpSGPal3jsmX8knCWgVI18SEw9hVpthO2cNDUD3nO3nR/6dnkGXQDVBOod3AZ8h7oKZwcqEz9yTlLV47LX8IAW1jCSWDcU+f/1Ob8QX1JHBsnf8siid/Tfckb0KCY0ztnBwWA/sKoKxLA8T/U0+3Iwk+b8gWnb/hoNH4cMFok/vglACk+2LGtEqBLVZ7/lqIuqMdZ5sjstU7NrYckKeEhMhEIOSGA==
Received: from MW4PR03CA0038.namprd03.prod.outlook.com (2603:10b6:303:8e::13)
 by CH2PR12MB4971.namprd12.prod.outlook.com (2603:10b6:610:6b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 08:17:34 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::f9) by MW4PR03CA0038.outlook.office365.com
 (2603:10b6:303:8e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Tue, 20 Jul 2021 08:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:17:33 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:17:27 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:17:25 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>
Subject: [PATCH rdma-core 00/27] Introduce mlx5 user space driver over VFIO
Date:   Tue, 20 Jul 2021 11:16:20 +0300
Message-ID: <20210720081647.1980-1-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bc81d82-f59e-4a09-a423-08d94b56d32c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4971:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4971A946F8C486FF4E039F62C3E29@CH2PR12MB4971.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UgQqvmj5DJdOwpAmpMz9z5nyo96QDG1wP5lVc2bX2AxRGEq4399X9tQ+U0sZwK++w0QYD6kKnJfmibQbP7qgaSSHoNjUG/86FuTqALX4M6ypT/IwiuLKWnXEZHQCgYoeN4tZZUWtw5ipqQWw2INPKdl9cGWblMpfCjzSwSqztBgN2DA+2Z0uB8w8LIjLJsiXgAG2x9up5PM+1xj6oHPfkV/SL64T676UEW4jEU8EUxipcIwWGY2Q3xASt19Fgt2kD96T0NsTShNRJ9GFkUcSVdXa6xVvT2mfRrdYgoIaN6LGM4tNN24brzCg6+ErwuO1FtGTQ9eTkukv9uzQfPKNTAl9DUJFcCyw8KWF8SMkpC4Yh/bXdtc1jjtlKHzYN74o25SEn8TmTsfBaKHa7oRHVIPQYk7CeDinVZOUyM7YUmcT7t+zwlweMVTM5fIt+MJt3u6WhnzU0lo3Z+XxPPcas13+mrDDi7da6c+VvohS+jXWeH8Gqqpf9WmxmcYAPggDMPQLsPEuENrfz4LbB71z7bGjJ2iNKIN9MayfqTS1k2Leu84O67HUEhQbYRUo4Wnbt6DgFNy+AI1vpnfFnEwPW3OLxzf5o4nc5Mk/cspAxHe9tCetjarXSGqRRJFt0RrNcqEqQh07hmOE5ePBiecYz9AcK66hz1iEfOMl4WZN+TQGwtxdsfp4a8Z7Yw+cZG/TkGbR8PtmCIlmWpr+nyuVf6IIczMsg7NudNH3nWgcX8XWK0yuPKjXJeuVjXl+awz6gkRwMDzrTMnsUEFpM1EKoIcZzc7MR+f3pNCUhtZG7q8PgcFvcaGjrF9bFe9vi7m5bFhH3ipyw79/0SnUOzNong==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966006)(36840700001)(19627235002)(6916009)(426003)(2906002)(2616005)(336012)(107886003)(6666004)(8676002)(86362001)(36860700001)(82310400003)(8936002)(36756003)(83380400001)(966005)(82740400003)(70586007)(70206006)(47076005)(26005)(478600001)(54906003)(186003)(36906005)(316002)(356005)(7696005)(5660300002)(7636003)(1076003)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:17:33.0635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc81d82-f59e-4a09-a423-08d94b56d32c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4971
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series introduces mlx5 user space driver over VFIO.

This enables an application to take full ownership on the opened device and run
any firmware command (e.g. port up/down) without any concern to hurt someone
else.

The application look and feel is like regular RDMA application over DEVX, it
uses verbs API to open/close a device and then mostly uses DEVX APIs to
interact with the device.

To achieve it, few mlx5 DV APIs were introduced, it includes:
- An API to get ibv_device for a given mlx5 PCI name.
- APIs to manage device specific events.

Detailed man pages were added to describe the expected usage of those APIs.

The mlx5 VFIO driver implemented the basic verbs APIs as of managing MR/PD and
the DEVX APIs which are required to write an RDMA application.

The VFIO uAPIs were used to setup mlx5 vfio context by reading the device
initialization segment, setup DMA and enables the device command interface.

In addition, the series includes pyverbs stuff which runs DEVX like testing
over RDMA and VFIO mlx5 devices.

Some extra documentation of the benefits and the motivation to use VFIO can be
found here [1].

PR was sent [2].

[1] https://www.kernel.org/doc/html/latest/driver-api/vfio.html
[2] https://github.com/linux-rdma/rdma-core/pull/1034

Yishai

Edward Srouji (10):
  pyverbs: Support DevX UMEM registration
  pyverbs/mlx5: Support EQN querying
  pyverbs/mlx5: Support more DevX objects
  pyverbs: Add auxiliary memory functions
  pyverbs/mlx5: Add support to extract mlx5dv objects
  pyverbs/mlx5: Wrap mlx5_cqe64 struct and add enums
  tests: Add MAC address to the tests' args
  tests: Add mlx5 DevX data path test
  pyverbs/mlx5: Support mlx5 devices over VFIO
  tests: Add a test for mlx5 over VFIO

Maor Gottlieb (1):
  mlx5: Enable debug functionality for vfio

Mark Zhang (5):
  util: Add interval_set support
  mlx5: Support fast teardown over vfio
  mlx5: VFIO poll_health support
  mlx5: Set DV context ops
  mlx5: Implement mlx5dv devx_obj APIs over vfio

Yishai Hadas (11):
  Update kernel headers
  mlx5: Introduce mlx5dv_get_vfio_device_list()
  verbs: Enable verbs_open_device() to work over non sysfs devices
  mlx5: Setup mlx5 vfio context
  mlx5: Add mlx5_vfio_cmd_exec() support
  mlx5: vfio setup function support
  mlx5: vfio setup basic caps
  mlx5: Enable interrupt command mode over vfio
  mlx5: Introduce vfio APIs to process events
  mlx5: Implement basic verbs operation for PD and MR over vfio
  mlx5: Support initial DEVX/DV APIs over vfio

 Documentation/pyverbs.md                           |   34 +
 debian/ibverbs-providers.symbols                   |    4 +
 kernel-headers/CMakeLists.txt                      |    4 +
 kernel-headers/linux/vfio.h                        | 1374 ++++++++
 libibverbs/device.c                                |   39 +-
 libibverbs/sysfs.c                                 |    5 +
 providers/mlx5/CMakeLists.txt                      |    3 +-
 providers/mlx5/dr_rule.c                           |   10 +-
 providers/mlx5/libmlx5.map                         |    7 +
 providers/mlx5/man/CMakeLists.txt                  |    3 +
 .../mlx5/man/mlx5dv_get_vfio_device_list.3.md      |   64 +
 providers/mlx5/man/mlx5dv_vfio_get_events_fd.3.md  |   41 +
 providers/mlx5/man/mlx5dv_vfio_process_events.3.md |   43 +
 providers/mlx5/mlx5.c                              |  376 ++-
 providers/mlx5/mlx5.h                              |  187 +-
 providers/mlx5/mlx5_ifc.h                          | 1206 ++++++-
 providers/mlx5/mlx5_vfio.c                         | 3379 ++++++++++++++++++++
 providers/mlx5/mlx5_vfio.h                         |  329 ++
 providers/mlx5/mlx5dv.h                            |   25 +
 providers/mlx5/verbs.c                             |  966 +++++-
 pyverbs/CMakeLists.txt                             |    7 +
 pyverbs/dma_util.pyx                               |   25 +
 pyverbs/mem_alloc.pyx                              |   46 +-
 pyverbs/pd.pyx                                     |    4 +
 pyverbs/providers/mlx5/CMakeLists.txt              |    4 +-
 pyverbs/providers/mlx5/libmlx5.pxd                 |  103 +-
 pyverbs/providers/mlx5/mlx5_vfio.pxd               |   15 +
 pyverbs/providers/mlx5/mlx5_vfio.pyx               |  116 +
 pyverbs/providers/mlx5/mlx5dv.pxd                  |   20 +
 pyverbs/providers/mlx5/mlx5dv.pyx                  |  277 +-
 pyverbs/providers/mlx5/mlx5dv_enums.pxd            |   42 +
 pyverbs/providers/mlx5/mlx5dv_objects.pxd          |   28 +
 pyverbs/providers/mlx5/mlx5dv_objects.pyx          |  214 ++
 tests/CMakeLists.txt                               |    3 +
 tests/args_parser.py                               |    5 +
 tests/base.py                                      |   14 +-
 tests/mlx5_base.py                                 |  460 ++-
 tests/mlx5_prm_structs.py                          | 1046 ++++++
 tests/test_mlx5_devx.py                            |   23 +
 tests/test_mlx5_vfio.py                            |  104 +
 util/CMakeLists.txt                                |    2 +
 util/interval_set.c                                |  208 ++
 util/interval_set.h                                |   77 +
 util/util.h                                        |    5 +
 44 files changed, 10650 insertions(+), 297 deletions(-)
 create mode 100644 kernel-headers/linux/vfio.h
 create mode 100644 providers/mlx5/man/mlx5dv_get_vfio_device_list.3.md
 create mode 100644 providers/mlx5/man/mlx5dv_vfio_get_events_fd.3.md
 create mode 100644 providers/mlx5/man/mlx5dv_vfio_process_events.3.md
 create mode 100644 providers/mlx5/mlx5_vfio.c
 create mode 100644 providers/mlx5/mlx5_vfio.h
 create mode 100644 pyverbs/dma_util.pyx
 create mode 100644 pyverbs/providers/mlx5/mlx5_vfio.pxd
 create mode 100644 pyverbs/providers/mlx5/mlx5_vfio.pyx
 create mode 100644 pyverbs/providers/mlx5/mlx5dv_objects.pxd
 create mode 100644 pyverbs/providers/mlx5/mlx5dv_objects.pyx
 create mode 100644 tests/mlx5_prm_structs.py
 create mode 100644 tests/test_mlx5_devx.py
 create mode 100644 tests/test_mlx5_vfio.py
 create mode 100644 util/interval_set.c
 create mode 100644 util/interval_set.h

-- 
1.8.3.1

