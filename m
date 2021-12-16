Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCC5477306
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Dec 2021 14:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbhLPNVs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Dec 2021 08:21:48 -0500
Received: from mail-bn7nam10on2054.outbound.protection.outlook.com ([40.107.92.54]:11489
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232110AbhLPNVs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Dec 2021 08:21:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihzpG1NMoz7zEr/Ti53LgfnL4ugx2AtqV0BOrJ5H1Qns5pFlAn7nrCyjtKN/mBsHjVYjS/ymLihfflY3ltw/NLFnbKkwLzWREy+wUfJ4fE1b3CiPzO53dqziP6m2N8RfZjZjbrVFMltTg1/1b8EL8MU/Ay/gIpgSCXjcXYovic8jlE03GE8B2indbFMMmNjRcLW0rkGoocEgqeQgYhaXS+j4mGC/MHO0v343qbbP7+tC4LdfL9QvGsemMB3bQBJ3qOGCPF8LUgQeMdADime5Qm/d54pO9OSEC/rjyy1fvZAa4iMEvfUsS5LkXYo0Klxik5Dpr6/S2IwKHuC0wQCHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQQ6V+0YpO9i3CDSNut8xF0XOzdX/7hbABZ6B8vqWdE=;
 b=QcrH3yWifEIPldPjzRyiV2ZWiVOs6fbRH1sGlaZ99RIEq/jJDQqGK61bxI08vk7NXmmIPGyp6vE3ep4+S96qSRSnNXo8MoTsDPpFfc5NGV6vq9555Rbva+xOYXgPVmvSrKOvut2pqO5FzFh712o6vJ+JL8hMlffcje+CDbWhAKStctcrcHOfKlZM3EMbQY8qjVJDfbvkuBfhupCM9N8mIZUXhOO22Pk81ZxiJ2FAZXhuamgXDDTUS4Us6X0dzDMA0bwRGb05erO+sh1ARkoh/C18a8IHq1XytuKabXnB0E7HzH9u2XMCpMsCg2gDoTfLzuJREW9BcjgBzy7DPcqCHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQQ6V+0YpO9i3CDSNut8xF0XOzdX/7hbABZ6B8vqWdE=;
 b=ced+j2MdHo93Sl3vcvbmMc2HXcIIoHwIpx0VJvaZgBBr0VvVNpNdla64oET3ycwOidxgjmW6D/TKQ8UA4zqDwSu2FGMH2pBtbVA4VkLz6GiNaYCTxlaO3M8vB9Uh3Nq7s1xlZMdiIZnOGJTGP/pkvzD0LTAL0+NadeadVx+D1iXbw6Zo9KiJXpYN29nBx94eAwoLilr2kCruwH4gkj15z168Cqz13tYOG5e6qiu/9ewd75FNeChaMn07nhDUXu9ocLqUG/nsZ+kvVDawt2FTOcoaZPdRmYJdAGnHbUwhVvLDrcIetnWjpR14LmArSG8/PMOFW3mJCwKhwx1xK/qZ2A==
Received: from MW4PR04CA0142.namprd04.prod.outlook.com (2603:10b6:303:84::27)
 by SN6PR12MB4718.namprd12.prod.outlook.com (2603:10b6:805:ee::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Thu, 16 Dec
 2021 13:21:45 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::f1) by MW4PR04CA0142.outlook.office365.com
 (2603:10b6:303:84::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17 via Frontend
 Transport; Thu, 16 Dec 2021 13:21:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 13:21:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Dec
 2021 13:21:44 +0000
Received: from [172.27.15.177] (172.20.187.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Thu, 16 Dec 2021
 05:21:42 -0800
Message-ID: <fcad6dac-6d40-98d7-93e2-bfa307e8e101@nvidia.com>
Date:   Thu, 16 Dec 2021 15:21:39 +0200
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
 <3292547e-2453-0320-c2e7-e17dbc20bbdd@nvidia.com>
 <CAHj4cs9QuANriWeLrhDvkahnNzHp-4WNFoxtWi2qGH9V0L3+Rw@mail.gmail.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <CAHj4cs9QuANriWeLrhDvkahnNzHp-4WNFoxtWi2qGH9V0L3+Rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e5d7856-612b-4a39-7d85-08d9c09701da
X-MS-TrafficTypeDiagnostic: SN6PR12MB4718:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB4718C9C216EC7CF6D2ECD041DE779@SN6PR12MB4718.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pLyJNh155I1q34qzweL0KHH6Jopq2NUnr57ooPCdrkynZFrf/6LEmYlEQFNG/pxCtcQo9SJI72nn/NsJDy+hl5NYeJhpvE7T7e1a5x5nzSjtz4ak3kPV0ttM8vI4oC7n7kisrs3zksahoKDu1iqLd8pZ+TXY+qSOhPMJHORHYpftM2IOjSmlwKXkMa054fFRpm/YbHEOvu8tVIBj62O4+7AuZ+wzf1tw5w4q/TtFC9wQivr+3vq2IWVwEV/WIw+AtJVs27N7Z34UHFCxxGRrA82156kHrgfa5eqwbxakhCvzfQPEjNNCz7oydj8wrRkOPy0YHw2cS99b2QIjZJdVBQ7XRziqJORefxoS5VnIDwS2W9WcvKsYWf+SjRBU6gdnBJ6VTmID/Px1SzFCOnvRm0e9sMmFAYKGVlFnHZvC7ddYzEyy6Rus0f2lJmfDET81QI0Zsv1wv17eDzte4ldgn5kGgNsg4mie37cTmsO+58R/FZ4sKriVYUDeZP9fvTUu2smeD3YlnANASZHT++SAJiVtnn3mNB8akfyRRXc7eHPFuePEjgT77W4Zy6oF/tzyXrYJ4NVO3+y5PnXiFuIbZAen2DTOkcsqDvtblXFvIRf85gbE7bKIgflesV5k6u+EmRG+pb6Blpw7axJYtUqpJauIIBDmB+O/aWMWW/iOUFtF1a9tll5qd3gjsXYG+QSYCHHoVm0j+6A1PsKSPdTIqsl9J4Y0jxs/Fg3YCxDIf+wHL9cTbOYgNHbQksfpoWxf+PfNDIduyl89gY1kVU8H2RwYrGwZpAeaSHaSqeDWDYvoszcu+HRpfublTVgzypWVtUxWuU7C3sulgqDYh62giMLclyCtrZP0ytbNeMMUH1w=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(4326008)(34020700004)(36860700001)(16576012)(31696002)(186003)(26005)(86362001)(70206006)(16526019)(36756003)(31686004)(426003)(2616005)(81166007)(356005)(6916009)(82310400004)(2906002)(508600001)(5660300002)(53546011)(316002)(336012)(70586007)(40460700001)(8936002)(54906003)(47076005)(8676002)(6666004)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 13:21:45.2213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5d7856-612b-4a39-7d85-08d9c09701da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4718
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 12/16/2021 4:18 AM, Yi Zhang wrote:
> On Wed, Dec 15, 2021 at 8:10 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>
>> On 12/15/2021 3:15 AM, Yi Zhang wrote:
>>> On Tue, Dec 14, 2021 at 8:01 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>>> On 12/14/2021 12:39 PM, Sagi Grimberg wrote:
>>>>>>>> Hi Sagi
>>>>>>>> It is still reproducible with the change, here is the log:
>>>>>>>>
>>>>>>>> # time nvme reset /dev/nvme0
>>>>>>>>
>>>>>>>> real    0m12.973s
>>>>>>>> user    0m0.000s
>>>>>>>> sys     0m0.006s
>>>>>>>> # time nvme reset /dev/nvme0
>>>>>>>>
>>>>>>>> real    1m15.606s
>>>>>>>> user    0m0.000s
>>>>>>>> sys     0m0.007s
>>>>>>> Does it speed up if you use less queues? (i.e. connect with -i 4) ?
>>>>>> Yes, with -i 4, it has stablee 1.3s
>>>>>> # time nvme reset /dev/nvme0
>>>>> So it appears that destroying a qp takes a long time on
>>>>> IB for some reason...
>>>>>
>>>>>> real 0m1.225s
>>>>>> user 0m0.000s
>>>>>> sys 0m0.007s
>>>>>>
>>>>>>>> # dmesg | grep nvme
>>>>>>>> [  900.634877] nvme nvme0: resetting controller
>>>>>>>> [  909.026958] nvme nvme0: creating 40 I/O queues.
>>>>>>>> [  913.604297] nvme nvme0: mapped 40/0/0 default/read/poll queues.
>>>>>>>> [  917.600993] nvme nvme0: resetting controller
>>>>>>>> [  988.562230] nvme nvme0: I/O 2 QID 0 timeout
>>>>>>>> [  988.567607] nvme nvme0: Property Set error: 881, offset 0x14
>>>>>>>> [  988.608181] nvme nvme0: creating 40 I/O queues.
>>>>>>>> [  993.203495] nvme nvme0: mapped 40/0/0 default/read/poll queues.
>>>>>>>>
>>>>>>>> BTW, this issue cannot be reproduced on my NVME/ROCE environment.
>>>>>>> Then I think that we need the rdma folks to help here...
>>>>> Max?
>>>> It took me 12s to reset a controller with 63 IO queues with 5.16-rc3+.
>>>>
>>>> Can you try repro with latest versions please ?
>>>>
>>>> Or give the exact scenario ?
>>> Yeah, both target and client are using Mellanox Technologies MT27700
>>> Family [ConnectX-4], could you try stress "nvme reset /dev/nvme0", the
>>> first time reset will take 12s, and it always can be reproduced at the
>>> second reset operation.
>> I created a target with 1 namespace backed by null_blk and connected to
>> it from the same server in loopback rdma connection using the ConnectX-4
>> adapter.
> Could you share your loop.json file so I can try it on my environment?

{
   "hosts": [],
   "ports": [
     {
       "addr": {
         "adrfam": "ipv4",
         "traddr": "<ip>",
         "treq": "not specified",
         "trsvcid": "4420",
         "trtype": "rdma"
       },
       "portid": 1,
       "referrals": [],
       "subsystems": [
         "testsubsystem_0"
       ]
     }
   ],
   "subsystems": [
     {
       "allowed_hosts": [],
       "attr": {
         "allow_any_host": "1",
         "cntlid_max": "65519",
         "cntlid_min": "1",
         "model": "Linux",
         "serial": "3d83c78b76623f1d",
         "version": "1.3"
       },
       "namespaces": [
         {
           "device": {
             "nguid": "5b722b05-e9b6-542d-ba80-62010b57775d",
             "path": "/dev/nullb0",
             "uuid": "26ffc8ce-73b4-321d-9685-7d7a9872c460"
           },
           "enable": 1,
           "nsid": 1
         }
       ],
       "nqn": "testsubsystem_0"
     }
   ]
}


>
> And can you try it with two servers that both have CX-4? This should
> be easier to reproduce it.

I did this experiment. I have only a setup with 12 cores so I created 12 
nvmf queues.

The reset took 4 seconds. The test did 100 loops of "nvme reset".

I saw that you also complained on the disconnect flow so I assume the 
root cause is the same.

My disconnect took 2 seconds.

My FW version is 12.28.2006.

>> I run a loop with the "nvme reset" command and it took me 4-5 secs to
>> reset each time..
>>
>>
>
