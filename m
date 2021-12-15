Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54C0475870
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 13:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242315AbhLOMKn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Dec 2021 07:10:43 -0500
Received: from mail-bn7nam10on2069.outbound.protection.outlook.com ([40.107.92.69]:13281
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237070AbhLOMKn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Dec 2021 07:10:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlMbvBuir+x2oRBHJp2L8GjsKPkTAzAHrXdCDey2HpF6apcRpQtIhUJylG9V1H2c/Mu6MxgHpdZMgYd3TqOxdyGba6ZCqCmsThbFYhd3lE6zCsUx6VvOZzxyNkiJD7DnJWgcgIFJvMrNqwDazL7AhfftQ6dKi5GAKhe8RTHfEfhZn+sedxy3rhemYjA22o3a/BUNR/bfx6CGNneoNAgGG9gt8+FWtPKB7COdrsL5PFOZ3+KU13xBGocX3FVv562KCOxrPGaSwJDPeJUQkcZCxy95pu4VuyfDpBqYo5FBJ2cSUG8rMJcAKiEauR23oUoGCBsCPrh5N0nP3lid2CP9ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XkPgu2ybf/RRdpsLie7wXGuDupNdkWlBpLq3nP0/Ms=;
 b=R30oFuO3qox2YuV5SneaRNr3jMI7L76KhqYbRyYfmHKGKNxem3atcvxy6D1FbtfJmRq3CO2G8zR2Jztzcob8GfvOw3b21GNmxxKDgoBJIitbETfn6ilHGsIKU3ts0tXI65Ugo75yC3Yi2WOH2R23KS101+JOjkGAze0hufVKRdHHRy4AcI+X8wQgwZ7SFZmf7BR5kenCx9Nvgt7A8BRMQrIWNSecZvFmctCt5zdTsZdTwXZ0Wl4WdLKZKFN1lcxe5jEAZ7mAKsU0oGK8vzPqjkvla8jf5/2rW8/pYn7+5yWlrn7JhCCpVfB3txDgTrA43Lyg5+62oyXlKhAt5f3yLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.14) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XkPgu2ybf/RRdpsLie7wXGuDupNdkWlBpLq3nP0/Ms=;
 b=qTrzansY3VxisMrRHsSl/1uUHQRfeayXs8ZTXruMHbdA10ngvQib0mtM0PkYxyVE8H500px5zXHj0Vg+mh/jragb+q8XLUf5LAJsOp1ZzUDgSDLiQXF4tM5bv8fSxn8t6BQ/ZE+4JCUesPn7MzcpeE8660s62peR8FJh/9MlSnebLfQCKvqfGG6DIXrBc0GkKHPTtBDShb+pbK6M8spQrWe8qP8qGYtA5HT10cFhJnJ5czYv5AgTh/73dskulC3Hy9T81uMULJKN2qV2O0Q8ZFs/7Y25ydeCBEJBj6sr9ec3WjyOjiTA4iF7i4PjQzLa7eJOqhkkIBTbfVzTCJQ0Sg==
Received: from BN6PR11CA0012.namprd11.prod.outlook.com (2603:10b6:405:2::22)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 12:10:41 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::90) by BN6PR11CA0012.outlook.office365.com
 (2603:10b6:405:2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14 via Frontend
 Transport; Wed, 15 Dec 2021 12:10:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.14)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.14; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.14) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4778.13 via Frontend Transport; Wed, 15 Dec 2021 12:10:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Dec
 2021 12:10:35 +0000
Received: from [172.27.13.177] (172.20.187.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Wed, 15 Dec 2021
 04:10:32 -0800
Message-ID: <3292547e-2453-0320-c2e7-e17dbc20bbdd@nvidia.com>
Date:   Wed, 15 Dec 2021 14:10:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me>
 <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
 <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com>
 <84208be5-a7a9-5261-398c-fa9bda3efbe3@grimberg.me>
 <CAHj4cs8dgNNE5qcX3Y4ykuTYU8z_kea6=q64Pn_2vsdodgOJZQ@mail.gmail.com>
 <CAHj4cs-aDo7DufnKazyKuZVR-1AWr5FK1LDsN=Do=CVUJ2pH3g@mail.gmail.com>
 <9f115198-bafc-be4e-1c90-06444b8a37f6@grimberg.me>
 <CAHj4cs8wBwDGhhtEPodyBdR-sCqJLYhwLhNHuPDm+KCan0hwWg@mail.gmail.com>
 <42ccd095-b552-32f7-96b0-d34d46f7c83e@grimberg.me>
 <CAHj4cs9EazUmtbjPKp5TXO4kRPcSShiYbhmsHwfh7SOTQAeoyw@mail.gmail.com>
 <c6d43a10-44bc-e73a-8836-d75367df049b@grimberg.me>
 <162ec7c5-9483-3f53-bd1c-502ff5ac9f87@nvidia.com>
 <CAHj4cs_kCorBjHcvamhZLBNXP2zWE0n_e-3wLwb-ERfpJWJxUA@mail.gmail.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <CAHj4cs_kCorBjHcvamhZLBNXP2zWE0n_e-3wLwb-ERfpJWJxUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc9b338d-68ee-4c10-d6ca-08d9bfc3e94f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4068:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4068FA985C46058AA0415A86DE769@BY5PR12MB4068.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89PoNkBHaN3jfVbn9/KEj/Pyh3jaLvOzL63bLOlQTHhY3hp5sWrAICVEdPqGs+ZY0JxiEHQ4hy0aGPGUaOJJnRnm/EGFYE2+8JFui3ljsF3Id+JRmBWNYGJNTpToYdGtQ6kRJDpt70dTy4DtJkMJg4udlvLXYn6Gp9s+lSeWGApceg7f7XBob6TXaBgZ6M57M3jnZsBYjYotPrkO3St3kZFHpHDK9e7YKh8D2A8PfO5R2OumXatFC888bZSzQt3q3pNe/KP+TLwrQyV17TXQcoud4EXN3wlarkOiZtAYzeng+jY/VSgkka2WRrFZ7vcb1Rgnk2BcAe6BQ3Aqa54QCXeUem05SZ7SGVbjb4K+GV7/CJljs4w8vh1AookAtXZXaVegh/9oWqY+k/5fPcnnnczJtrTpOBVidXJB9jqqEG0NpF3Cspy7SDi9vmFmsqCoopdHP02rUCFNKBvQhz4hY8zP3Ul43MNU4gQRM1A1Zht1fHu93R0BIht3KjElHnH/xA2m4uDvFoeC04BCW4b11Q494y4toq1TsFt7QL8z0KLzxq8pxDEjv7f0l6njJgRwF5/2LcJj7DgwcCLfWJBRiaovSzMuV7smUJpZPPVPtwr6SMTfsAXl+nIaq9xq6PrRlP+ejd9faV1YCovvTqLjd5QuZszQXozotlJuLy0UI3gfeD5nZcsdNmihAk6I/wUG2VVHw0eZLtLqL3N+i/m0xsm2UTzlR2Y8LMSM1JtQ6eJCTyNADfQjOqshN0ZQfx1E2cI9+EmJJ8yrcJTN6rIHrRCE6+qgqmIuvF7el6Pl1r13BjyIHYP4Zlt6jQ6uDUlX2QAaE5zV/EB9IKGiqNVjTQ==
X-Forefront-Antispam-Report: CIP:203.18.50.14;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(508600001)(54906003)(8676002)(5660300002)(6666004)(86362001)(8936002)(36756003)(7636003)(356005)(47076005)(4326008)(34020700004)(36860700001)(53546011)(70206006)(70586007)(2616005)(186003)(31686004)(16526019)(26005)(31696002)(16576012)(316002)(82310400004)(426003)(6916009)(40460700001)(2906002)(336012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 12:10:39.8487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9b338d-68ee-4c10-d6ca-08d9bfc3e94f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.14];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 12/15/2021 3:15 AM, Yi Zhang wrote:
> On Tue, Dec 14, 2021 at 8:01 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>
>> On 12/14/2021 12:39 PM, Sagi Grimberg wrote:
>>>>>> Hi Sagi
>>>>>> It is still reproducible with the change, here is the log:
>>>>>>
>>>>>> # time nvme reset /dev/nvme0
>>>>>>
>>>>>> real    0m12.973s
>>>>>> user    0m0.000s
>>>>>> sys     0m0.006s
>>>>>> # time nvme reset /dev/nvme0
>>>>>>
>>>>>> real    1m15.606s
>>>>>> user    0m0.000s
>>>>>> sys     0m0.007s
>>>>> Does it speed up if you use less queues? (i.e. connect with -i 4) ?
>>>> Yes, with -i 4, it has stablee 1.3s
>>>> # time nvme reset /dev/nvme0
>>> So it appears that destroying a qp takes a long time on
>>> IB for some reason...
>>>
>>>> real 0m1.225s
>>>> user 0m0.000s
>>>> sys 0m0.007s
>>>>
>>>>>> # dmesg | grep nvme
>>>>>> [  900.634877] nvme nvme0: resetting controller
>>>>>> [  909.026958] nvme nvme0: creating 40 I/O queues.
>>>>>> [  913.604297] nvme nvme0: mapped 40/0/0 default/read/poll queues.
>>>>>> [  917.600993] nvme nvme0: resetting controller
>>>>>> [  988.562230] nvme nvme0: I/O 2 QID 0 timeout
>>>>>> [  988.567607] nvme nvme0: Property Set error: 881, offset 0x14
>>>>>> [  988.608181] nvme nvme0: creating 40 I/O queues.
>>>>>> [  993.203495] nvme nvme0: mapped 40/0/0 default/read/poll queues.
>>>>>>
>>>>>> BTW, this issue cannot be reproduced on my NVME/ROCE environment.
>>>>> Then I think that we need the rdma folks to help here...
>>> Max?
>> It took me 12s to reset a controller with 63 IO queues with 5.16-rc3+.
>>
>> Can you try repro with latest versions please ?
>>
>> Or give the exact scenario ?
> Yeah, both target and client are using Mellanox Technologies MT27700
> Family [ConnectX-4], could you try stress "nvme reset /dev/nvme0", the
> first time reset will take 12s, and it always can be reproduced at the
> second reset operation.

I created a target with 1 namespace backed by null_blk and connected to 
it from the same server in loopback rdma connection using the ConnectX-4 
adapter.

I run a loop with the "nvme reset" command and it took me 4-5 secs to 
reset each time..


>
>>
>
