Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D26E3A1A56
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 17:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbhFIQBp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 12:01:45 -0400
Received: from mail-bn1nam07on2058.outbound.protection.outlook.com ([40.107.212.58]:14982
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232468AbhFIQBo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Jun 2021 12:01:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1FU4IHWYBYCbJ9XeX42n03vXVit6C2jgAAnOJqb7VYDX6VP5gJMOcXHHjIbNv5R3eLTMgCJcBILLoadu1W9Aw5p+zV3wIdxjjwm3+julkay8R7QHUU9jcrvn4nUUViArcppzrGyNlxp6De1jTtZf/exwD3Iek4XzNnd3VOuC8szwK1GmaXcSmBQcD/mdYjRN16KqorVnxdmOiH57J3IyGWo91JK2ffYpHpJwcdyM7sl+MKh0OgPTfvb9fKX259ckPETIta8FUJvwxLVYZH92iXGq2YquXC1R4FO8dsiiIti3bDxGm/1lIS6Axh9K4EyXv8gfrjmkGHsKX/6HBI8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6ga6v56MBPzSj573UUZsO/6FsUL3NJ5OBjjWL1Y7W8=;
 b=Be8j4issVABAjlMWBOIccFLBr5qPRsSaAskE3goapUISRod8lxAfsUAvE6YAa/wM3ZfKhqXSeOdPPQtA/ekasLP+Ou86UMZhlXLwuMTdj7XOboEWrpKgupxRFthY1GcyeBoRM7Al+B7tB9RmPWHWm+vxHNd7nzfzirqaJp9d1dNzQ3/3DXkD2/Bqf5RlXa3uuWomjYH/HALvEb4vXEnwQtExrUIYfVB/fMdAIOdQWbjeRQPCKjiP0o9C3QfX3RouBVnRaHtnLs9a9Cba7VV0UX+Jmg+MGNz9Tys+BoRqSs5OR1/veE9+pr0lWdTpjpqXRKAWqDYUqfNbFuScWMCc7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6ga6v56MBPzSj573UUZsO/6FsUL3NJ5OBjjWL1Y7W8=;
 b=apsMXi5ONdlrlAMV1Zu+q846ovFPIjeimmFxjS72eOEz3xa3RGBAAFMXsAGkb+ugdwSXgKIOxDrr1bSVYhvn0MZ1GgSlBfZDTYNor7EtHu8KF1/CZIdExpWOd8dp0Vi/nLvvIrshGOFpz9LOIxjISJBlY5vUGvc/Cn3vCpD70dIJjav+BhbMGm96DUYHweuqTZ0jrK6ZCjulVvwJg5d7CWZhq+8b1Ea9evGHZpZqLXfhV6unEGnOik7No1M55o+y0hT1O7k9M0ihm/EllIwJUU/u9Q+RM80OPpFK0bRYktkSkuVlO/dqvG+NaDMo0SKhCc3/WYQeVS6nzmTMIC7OZg==
Received: from MW4PR04CA0011.namprd04.prod.outlook.com (2603:10b6:303:69::16)
 by DM4PR12MB5264.namprd12.prod.outlook.com (2603:10b6:5:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Wed, 9 Jun
 2021 15:59:48 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:69:cafe::3e) by MW4PR04CA0011.outlook.office365.com
 (2603:10b6:303:69::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Wed, 9 Jun 2021 15:59:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 15:59:48 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Jun
 2021 08:59:47 -0700
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Jun 2021 15:59:44 +0000
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@mellanox.com>, <yishaih@mellanox.com>, <maorg@mellanox.com>,
        <phaddad@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-core 0/4] verbs: Introduce ibv_query_qp_data_in_order() verb
Date:   Wed, 9 Jun 2021 18:59:28 +0300
Message-ID: <20210609155932.218005-1-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a41aefe-b087-40d6-5eed-08d92b5f9bd4
X-MS-TrafficTypeDiagnostic: DM4PR12MB5264:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5264B9A898E604B8ED20548CC3369@DM4PR12MB5264.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQ1XPtFRhSvHaYKCeyahu+hU0+8VPeicUFP8GM9nzJzIbluzJEuV2+gsX+JfLoKmsMfc4IJ3UzHkXjKe33LHXU5Gf6mlFQtdXtc37cHj7bL0X+xRwter4BPIYQ2lvDrt2NvTLRoN5CF5QlKZij4GQ6zrMecYfArgeSiuoKsPThX+USHlUmKH7Eed8BO/PNbV9D3SINRW1l3twURU8rD0/4C5mDD1KA2gc9MPoFGQLiaZrGdv3wGQRQxqJKhyRd8C8IYZEL+HZqemYLW55DJq3Yj2Ej0F522EDSLNfESiZW0y1I1vyYMzCyJ1JgXGEce+ch/PvrG1M5cwXxgww92Mf6Gc4Y56SY4QY1YE+Nbz8y3wqMWf3TU6pqnOazwtXvuJe+TLUqyOlqg+ndbomt5ixKIOY3n2vd8Q2E41R5ZAFVYNnF6fRUHg+aMMdLmBnS6sNoEomgmjntaCU2Q4ya/38nEyyxeenlf9fjhxdZoQL1mdxcKgLaNPZPfh/Mxc0pH4Lwpghqqd5TOZaUZUa5/1dpfpIovoOTiBWKd+LNN2atYT7HhzdXdvheU+VYuAa1G9E3W1BJ2xl2zJAeBl+iLgnm8SB5qXXcbJ2cWq6Ya7u7vDP0SDhIb54z/7WFPMOHBU2BvjoEyT/kDBVxnt5pmBMLYQ+CvJV+KRtkRW1oDTDT4Z/KI/8iPplfcJgkV2kbhOzyQih5GGpFIDTgqAk+x2mDUdn36z5HXX26eM3PS/rIELt9EEVzZd9I9TYeeg1DvGUJjcP+ONAw4d9svQl6Zy+Q==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(46966006)(36840700001)(5660300002)(107886003)(70206006)(2906002)(70586007)(1076003)(2616005)(82740400003)(36756003)(8676002)(966005)(186003)(47076005)(6916009)(426003)(7636003)(82310400003)(86362001)(316002)(356005)(6666004)(54906003)(26005)(336012)(83380400001)(4326008)(8936002)(36860700001)(7696005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 15:59:48.4830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a41aefe-b087-40d6-5eed-08d92b5f9bd4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5264
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series introduces ibv_query_qp_data_in_order() verb.

This verb enables an application to check whether the receiving data of the
local QP is guaranteed to be in order for a given operation within its WQE.

Once true, it allows user to poll for data instead of poll for completion.

The API was implemented by mlx5 driver over DEVX.

A detailed man page and some pyverbs stuff were added as well.

PR: https://github.com/linux-rdma/rdma-core/pull/1009

Patrisious Haddad (2):
  verbs: Introduce ibv_query_qp_data_in_order() verb
  mlx5: Implement ibv_query_qp_data_in_order() verb

Shachar Kagan (2):
  pyverbs: Add query QP data in order support
  tests: Add query QP data in order coverage

 debian/libibverbs1.symbols                     |  2 +
 libibverbs/CMakeLists.txt                      |  2 +-
 libibverbs/driver.h                            |  2 +
 libibverbs/dummy_ops.c                         |  8 ++++
 libibverbs/libibverbs.map.in                   |  5 +++
 libibverbs/man/CMakeLists.txt                  |  1 +
 libibverbs/man/ibv_query_qp_data_in_order.3.md | 62 ++++++++++++++++++++++++++
 libibverbs/verbs.c                             |  6 +++
 libibverbs/verbs.h                             | 14 ++++++
 providers/mlx5/mlx5.c                          |  1 +
 providers/mlx5/mlx5.h                          |  3 ++
 providers/mlx5/mlx5_ifc.h                      | 39 +++++++++++++++-
 providers/mlx5/verbs.c                         | 55 +++++++++++++++++++++++
 pyverbs/libibverbs.pxd                         |  1 +
 pyverbs/qp.pyx                                 |  9 ++++
 tests/test_qp.py                               | 13 ++++++
 16 files changed, 220 insertions(+), 3 deletions(-)
 create mode 100644 libibverbs/man/ibv_query_qp_data_in_order.3.md

-- 
1.8.3.1

