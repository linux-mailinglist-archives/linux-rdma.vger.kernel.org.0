Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D323DCAB1
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Aug 2021 10:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhHAIBW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 1 Aug 2021 04:01:22 -0400
Received: from mail-dm6nam08on2043.outbound.protection.outlook.com ([40.107.102.43]:22410
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231347AbhHAIBT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 1 Aug 2021 04:01:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ao6qXeIhdGWQuIOTLKzXzViUeZtnmKx/KWT/gozVmAiA2HgFaMgIaS5Mz2OeaMsYrfmCX3qv+ERo12+3aeU4ygD+ZSBTSjuPmGVu9Fnt8I0Ahoj8Gh2OrhPlHe3zGamPD6VwxWJjdwFvhkN0fT/242VkUuJ4h+39aRZ39Zw0YeT26kN4pRHEMZxbb3nzUZ8ieFr9AmsVos8/CfCEBGTkgdqb/nLcVmyygQQFtJdz7fECurbXIXOg79+3rJCT/GTfYs6AdlepB95HihiusuDtmmMHrhBV7PALxJMkd1uZ/OZtSS3lRR1VRaQ4Ro+I/0LWTcUrV43CbvqkukiXdrKv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Vk+8JtNEInJiEaJOWuHYUZHhcDZ23czzl/8ACfg4G4=;
 b=RWzHO+/WgYeCjtriRiYskt8CxUQZ2yfyhfSD9P+Vout4zke8nVq/vCepMW6zX81Muk3R8RUmMuD05oxhAwqMHB3FVGnG+t0IgA3TFq3ryOqI1iYWfT/gFvdEvgooQvfSLg6Yw/hGY97URikw+o03sUq9fV0GwWvHbwucDVFdp9W5tFHhfnSYdhQ02DMlaDGFJMfwU9QCzW9trD/YgvIxTolArHvyElE56PNgmP1DU62O7j4rqe7X0m0FPivT0BX+5ph7V/cZmDifFZPTqowkivyBFq6dmGUPnD4nWEsn8IEtrFldQZqlz/X7xtXnK2n0SSTQvGZySXyUw/Hhm4VF7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Vk+8JtNEInJiEaJOWuHYUZHhcDZ23czzl/8ACfg4G4=;
 b=Rqu3ZDinPpAtzz1jB5BSWA7tDD/St2XAcF6onIJXo+LVDpM7AIFqIvev29/F0PGu5uzLt3itMcs95WWzYthhh7TYZthJEKaxBEvE7+/3mPIoUoHvi8lyyXQsDTlOEHcih3+AEbFk+6lrVMuCEI3yCljdkG3tHeBeoubdndMYAOS69OHmLEYor/Gox6MMHT+T5pIizQoRW5a71KhDEf9O9wShctzIjL+MDfJLo4TcgZ/0mghASkaY+As+hLbqeEOYGFVSdoiRg/vlQM+RwWWR4/MKv5cd5DPPKx1OrYOA+IVefV6xFOuIZfNB//9gaMrI7/Vvjpuw1OcMEJB/epT1JA==
Received: from BN6PR2001CA0006.namprd20.prod.outlook.com
 (2603:10b6:404:b4::16) by DM6PR12MB3481.namprd12.prod.outlook.com
 (2603:10b6:5:11a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Sun, 1 Aug
 2021 08:01:10 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::7e) by BN6PR2001CA0006.outlook.office365.com
 (2603:10b6:404:b4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend
 Transport; Sun, 1 Aug 2021 08:01:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4373.18 via Frontend Transport; Sun, 1 Aug 2021 08:01:10 +0000
Received: from [172.27.11.246] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 1 Aug
 2021 08:00:08 +0000
Subject: Re: [PATCH rdma-core 00/27] Introduce mlx5 user space driver over
 VFIO
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <maorg@nvidia.com>, <markzhang@nvidia.com>,
        <edwards@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
From:   Yishai Hadas <yishaih@nvidia.com>
Message-ID: <c8b13b98-0c68-939d-0a6c-801beaef7d3e@nvidia.com>
Date:   Sun, 1 Aug 2021 11:00:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd63e3c2-6f58-4b50-97c4-08d954c28683
X-MS-TrafficTypeDiagnostic: DM6PR12MB3481:
X-Microsoft-Antispam-PRVS: <DM6PR12MB348184F607C5C509B8EED3DBC3EE9@DM6PR12MB3481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eb/M4EFxjnAaFp1R2MfLrzXu4/wKTHvswAkbby9MyeCcei4f+vowvtIF3xUnYIpcJCZ2+Q4WkVMRVSFNKcxPh1tdCSgqkupS2RS5FRU7umwo5KK4bxQoa23Thjes3ca9EELan7Hwz6toLM10sf2WHnnozy3gAp/GB3YvvuqLID1+vEeKPxhx9ITXF78NMisGqWS/IJ1cWuozflP4au5SLX6Ua3fwb3L+gzZo6Xlsw86csIuyfLzB5+lcPwojQ7FO4XNJ6DkPSC8OJC8qU7otjSM0bY4KLVllaQktzFDgrN9quUIyN3jEiLMM/lzOh67iRQf1/VEwVwvsymA69mxc8wH3W1akNJiWiHDqJKKeehNB9dpcAE9FE9ATEJIqVMs+lU9rhcwITTSfqWi7UwdtAxmN1WZYaRCg1Oi6znfZmvV0By9uUAydLK8WatHcZ/7G0nVAdr+w8kcrBgh6QnW8Du3ap51RS8U88CjsKNSmvblHHikeLwJBtGr3pCRt3DA5E+dxMF69ozFT5AA0OVC0CBxmZWqVWXhmOiPzjZTkl6mOX2VsCm4ChMghIBudrPgFJckhH8qsZPZ9A02CcJV6RZYjEGcCVP5wyTCMxSwR+/mHQ1omIX6W4VFHLWy24A8ZyOJlAHkjlZANBdXSkmqDd2YGyqGFtVRGdafa4GrbVt6/RuW6kZqeNSsUvpetLTZ7UqTLaP09jaNh3umzE02rVFWkn31wiDFGYO5pV1ti4Y6097Ht4mgbkQGcBMzEROHS6zeDqagc2aYvzv87dFuKb2cvqGo3ASxFumL1tjCWKMN8/4sh2FwxZSmcgwoYbUvRv6PJKaXLUWrejXvfkTSVw4ADmjmPC1B3q05fWObmrco=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(36840700001)(46966006)(4326008)(47076005)(7636003)(8936002)(6916009)(19627235002)(54906003)(16576012)(31686004)(8676002)(16526019)(82310400003)(53546011)(36860700001)(86362001)(70586007)(70206006)(26005)(36756003)(356005)(5660300002)(478600001)(186003)(83380400001)(2616005)(336012)(426003)(966005)(316002)(6666004)(107886003)(36906005)(82740400003)(2906002)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2021 08:01:10.4746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd63e3c2-6f58-4b50-97c4-08d954c28683
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3481
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/20/2021 11:16 AM, Yishai Hadas wrote:
> This series introduces mlx5 user space driver over VFIO.
>
> This enables an application to take full ownership on the opened device and run
> any firmware command (e.g. port up/down) without any concern to hurt someone
> else.
>
> The application look and feel is like regular RDMA application over DEVX, it
> uses verbs API to open/close a device and then mostly uses DEVX APIs to
> interact with the device.
>
> To achieve it, few mlx5 DV APIs were introduced, it includes:
> - An API to get ibv_device for a given mlx5 PCI name.
> - APIs to manage device specific events.
>
> Detailed man pages were added to describe the expected usage of those APIs.
>
> The mlx5 VFIO driver implemented the basic verbs APIs as of managing MR/PD and
> the DEVX APIs which are required to write an RDMA application.
>
> The VFIO uAPIs were used to setup mlx5 vfio context by reading the device
> initialization segment, setup DMA and enables the device command interface.
>
> In addition, the series includes pyverbs stuff which runs DEVX like testing
> over RDMA and VFIO mlx5 devices.
>
> Some extra documentation of the benefits and the motivation to use VFIO can be
> found here [1].
>
> PR was sent [2].
>
> [1] https://www.kernel.org/doc/html/latest/driver-api/vfio.html
> [2] https://github.com/linux-rdma/rdma-core/pull/1034
>
> Yishai
>
> Edward Srouji (10):
>    pyverbs: Support DevX UMEM registration
>    pyverbs/mlx5: Support EQN querying
>    pyverbs/mlx5: Support more DevX objects
>    pyverbs: Add auxiliary memory functions
>    pyverbs/mlx5: Add support to extract mlx5dv objects
>    pyverbs/mlx5: Wrap mlx5_cqe64 struct and add enums
>    tests: Add MAC address to the tests' args
>    tests: Add mlx5 DevX data path test
>    pyverbs/mlx5: Support mlx5 devices over VFIO
>    tests: Add a test for mlx5 over VFIO
>
> Maor Gottlieb (1):
>    mlx5: Enable debug functionality for vfio
>
> Mark Zhang (5):
>    util: Add interval_set support
>    mlx5: Support fast teardown over vfio
>    mlx5: VFIO poll_health support
>    mlx5: Set DV context ops
>    mlx5: Implement mlx5dv devx_obj APIs over vfio
>
> Yishai Hadas (11):
>    Update kernel headers
>    mlx5: Introduce mlx5dv_get_vfio_device_list()
>    verbs: Enable verbs_open_device() to work over non sysfs devices
>    mlx5: Setup mlx5 vfio context
>    mlx5: Add mlx5_vfio_cmd_exec() support
>    mlx5: vfio setup function support
>    mlx5: vfio setup basic caps
>    mlx5: Enable interrupt command mode over vfio
>    mlx5: Introduce vfio APIs to process events
>    mlx5: Implement basic verbs operation for PD and MR over vfio
>    mlx5: Support initial DEVX/DV APIs over vfio
>
>   Documentation/pyverbs.md                           |   34 +
>   debian/ibverbs-providers.symbols                   |    4 +
>   kernel-headers/CMakeLists.txt                      |    4 +
>   kernel-headers/linux/vfio.h                        | 1374 ++++++++
>   libibverbs/device.c                                |   39 +-
>   libibverbs/sysfs.c                                 |    5 +
>   providers/mlx5/CMakeLists.txt                      |    3 +-
>   providers/mlx5/dr_rule.c                           |   10 +-
>   providers/mlx5/libmlx5.map                         |    7 +
>   providers/mlx5/man/CMakeLists.txt                  |    3 +
>   .../mlx5/man/mlx5dv_get_vfio_device_list.3.md      |   64 +
>   providers/mlx5/man/mlx5dv_vfio_get_events_fd.3.md  |   41 +
>   providers/mlx5/man/mlx5dv_vfio_process_events.3.md |   43 +
>   providers/mlx5/mlx5.c                              |  376 ++-
>   providers/mlx5/mlx5.h                              |  187 +-
>   providers/mlx5/mlx5_ifc.h                          | 1206 ++++++-
>   providers/mlx5/mlx5_vfio.c                         | 3379 ++++++++++++++++++++
>   providers/mlx5/mlx5_vfio.h                         |  329 ++
>   providers/mlx5/mlx5dv.h                            |   25 +
>   providers/mlx5/verbs.c                             |  966 +++++-
>   pyverbs/CMakeLists.txt                             |    7 +
>   pyverbs/dma_util.pyx                               |   25 +
>   pyverbs/mem_alloc.pyx                              |   46 +-
>   pyverbs/pd.pyx                                     |    4 +
>   pyverbs/providers/mlx5/CMakeLists.txt              |    4 +-
>   pyverbs/providers/mlx5/libmlx5.pxd                 |  103 +-
>   pyverbs/providers/mlx5/mlx5_vfio.pxd               |   15 +
>   pyverbs/providers/mlx5/mlx5_vfio.pyx               |  116 +
>   pyverbs/providers/mlx5/mlx5dv.pxd                  |   20 +
>   pyverbs/providers/mlx5/mlx5dv.pyx                  |  277 +-
>   pyverbs/providers/mlx5/mlx5dv_enums.pxd            |   42 +
>   pyverbs/providers/mlx5/mlx5dv_objects.pxd          |   28 +
>   pyverbs/providers/mlx5/mlx5dv_objects.pyx          |  214 ++
>   tests/CMakeLists.txt                               |    3 +
>   tests/args_parser.py                               |    5 +
>   tests/base.py                                      |   14 +-
>   tests/mlx5_base.py                                 |  460 ++-
>   tests/mlx5_prm_structs.py                          | 1046 ++++++
>   tests/test_mlx5_devx.py                            |   23 +
>   tests/test_mlx5_vfio.py                            |  104 +
>   util/CMakeLists.txt                                |    2 +
>   util/interval_set.c                                |  208 ++
>   util/interval_set.h                                |   77 +
>   util/util.h                                        |    5 +
>   44 files changed, 10650 insertions(+), 297 deletions(-)
>   create mode 100644 kernel-headers/linux/vfio.h
>   create mode 100644 providers/mlx5/man/mlx5dv_get_vfio_device_list.3.md
>   create mode 100644 providers/mlx5/man/mlx5dv_vfio_get_events_fd.3.md
>   create mode 100644 providers/mlx5/man/mlx5dv_vfio_process_events.3.md
>   create mode 100644 providers/mlx5/mlx5_vfio.c
>   create mode 100644 providers/mlx5/mlx5_vfio.h
>   create mode 100644 pyverbs/dma_util.pyx
>   create mode 100644 pyverbs/providers/mlx5/mlx5_vfio.pxd
>   create mode 100644 pyverbs/providers/mlx5/mlx5_vfio.pyx
>   create mode 100644 pyverbs/providers/mlx5/mlx5dv_objects.pxd
>   create mode 100644 pyverbs/providers/mlx5/mlx5dv_objects.pyx
>   create mode 100644 tests/mlx5_prm_structs.py
>   create mode 100644 tests/test_mlx5_devx.py
>   create mode 100644 tests/test_mlx5_vfio.py
>   create mode 100644 util/interval_set.c
>   create mode 100644 util/interval_set.h
>
The PR was merged.

Yishai

