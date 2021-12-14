Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC774741E8
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Dec 2021 13:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhLNMBE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Dec 2021 07:01:04 -0500
Received: from mail-bn8nam12on2071.outbound.protection.outlook.com ([40.107.237.71]:25857
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229579AbhLNMBD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Dec 2021 07:01:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1pq0XYbyVteQgYqj/N0aGsAbanguSKapVnqSaSqJQkyszA9TQnjl+wXhde1JdAZPIShM/Vyp4VYn5VRJsiAwaJycpEU5KkYjeY2b4XtnQfy/NctokjnOHaUB4moaSTztPNfjBX6kOd3FD0zIubxEQeoPsDCgDXY2xKoVLXpvktl1vWAh0XNyLwhWI0PKfIbJ4yDZYVNVL50p9c/7lq+W25bXwXPw3XnFdi6m4bDRMSUCMq1hWXjc949E5xQq0/SZWo5/kD/odCA42nKbTBEu8JAfa4yT+eTvAINqHqfxKnBKa8fYX6vshJ3fR2GDqGnrDXpYYYot4QSSruyX8TzBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/EJo69hs4KveXL2+06kOMgg77WQ/zOO+nnN8vKDd6E=;
 b=joORiklz0lEVPrsSg+medWLCPCKiC2J3j8NXxVBlwTLRXhYh9oeWrm2Y9f1fCfRpyIE85jtErVyHd4HDyE+m8+NSDMWMdSKaRkQK9524wVGmkmq5K7pdxl/byIZxQtqjYt8yYrwF0o3PqKy21oNSEZTKQWs1wzsvpRxevs9bg8JH4Nfcj35tQBnoBFgzRR+n/2/3YU4tFu3H8K/Pu1bVLQs++Tbc545F/gni+BOV0AjBiBw8s4wmRGg5EJ5FsvZPz9KTgvcmZQ+2RnzRC82C8kfxUkhW4nxLBNwlim5h8KAsNFKyzUXksCqUZmT5ot73FnsW5VKJy6lxEcbvGJNknA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.12) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/EJo69hs4KveXL2+06kOMgg77WQ/zOO+nnN8vKDd6E=;
 b=RMI2GFnqoDNQUJKH1zI77zkATHS9pyiSPRVXxFM75GY6qUOSziCX3MDeIUKB4RmrYdakVNEjcnLmVVtlCxo1gTH+VOzTcHkmOWFKgtOpSj+qhVCZHbKclokCS5d1alH5oxQGxSuVlZ0xYzPlwNJ14ETO0SvSToAfe6f+tXoTzlym2iTVKbvifvGtKBaNLp1xNfkpbMeBOLNG6rJpf+1qi9f4t/jQcXneJcdO0bbJPTuzpMVMEj4aN6TXQH+BNMFGMTeDtNYTrmHNV5fuC5RFKbSV5UzeM9zedoA8ZZ0+SU46ImAq314zI0eRTFAvFsNdFZWYneo8Ng4rAjKblkWA+Q==
Received: from DM5PR08CA0031.namprd08.prod.outlook.com (2603:10b6:4:60::20) by
 DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.14; Tue, 14 Dec 2021 12:01:01 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::21) by DM5PR08CA0031.outlook.office365.com
 (2603:10b6:4:60::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14 via Frontend
 Transport; Tue, 14 Dec 2021 12:01:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.12)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.12; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.12) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4778.13 via Frontend Transport; Tue, 14 Dec 2021 12:01:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 14 Dec
 2021 12:00:52 +0000
Received: from [10.222.163.54] (172.20.187.5) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Tue, 14 Dec 2021
 04:00:48 -0800
Message-ID: <162ec7c5-9483-3f53-bd1c-502ff5ac9f87@nvidia.com>
Date:   Tue, 14 Dec 2021 14:00:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
        "Max Gurtovoy" <maxg@mellanox.com>
CC:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        "RDMA mailing list" <linux-rdma@vger.kernel.org>
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
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <c6d43a10-44bc-e73a-8836-d75367df049b@grimberg.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ba66a62-d31b-4379-5910-08d9bef965fb
X-MS-TrafficTypeDiagnostic: DM6PR12MB4402:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4402097F1D08BC19560DCE4ADE759@DM6PR12MB4402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BS8pgS0yZpdXpd+SsOeQdkj/R+S7GDnf+5PpoZC4XmCwLZVbUmrJQZC9u9Xkr5aMp96BBJiL7cofcQv2Iy+OatWunzrEAziXSy4T5pqstkxwXw6QQpHQdwAE6dN8WscAQC1b9JA45PlwhRRr67TdgSskxQ+VOt9VlIKpiDnvD3vL8e6oUF6y2XJVLksq3XCPwSeitFWzGO9Tj+GL+uKcIQRqNN8p/PJCXQUSmXAwXa/+ZKFeHHYpSGX8L0Hp20VgjbWkM39BZzusLI3MS9NpEc6jvl3bdUcN1PNJsJYQXJBDNM/QQIwMbJ+cynj+8LgUNr1EdR55esaAP8/khBj0Rxns8ZhgHiPnkbsVK6y75QbqGy5FOFtW5CiFXlG+xFJwHH2E4+6iZaWo7p7E2ZwEy/7Wm6ZpCFES1f7wu5M4PWONPFbtqPDJ+F67HMIFf3W6FGj6BSpOetsvF1898Z5hgLtyzMOZ2Hjqgw9xx78GV4pCMLG686xR3CmxaimAU9QfcGcY8O0em3O3tpBHkukRLjSvoVP1QV5XJK2FszAmJNnm7TqSKhsmM+20X4vJAXr2x3OfmXntPpbFfibglRAiEizNGgB9DLy1v/hoBabDFuVbC8fFkKC5+uFa0AjqWCpRIkV6dJb8OVgyjLL827hvJvWK4reTfEkoFju9MbbUrb1IZZntvgGKiarFYrb3QoNx8Dl6BjSLQ7CEYI9BrA81SvaWOjEtcucC8EmIoQY2zzODUrgHx2Opa5K9r+q3fFkYTR+419f9ZwJWl72Pw6GNBIJvaHXN3tTLw6GlfaAfBCo5PBRYeLixaHtDYA/ALCOrAzmmII6jVzN1K47I6zOa7w==
X-Forefront-Antispam-Report: CIP:203.18.50.12;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(70206006)(70586007)(34020700004)(40460700001)(336012)(31696002)(36860700001)(2616005)(86362001)(426003)(110136005)(54906003)(5660300002)(8936002)(508600001)(36756003)(4326008)(8676002)(26005)(16576012)(7636003)(2906002)(316002)(356005)(53546011)(47076005)(16526019)(6666004)(31686004)(186003)(82310400004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 12:01:01.2210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba66a62-d31b-4379-5910-08d9bef965fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.12];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 12/14/2021 12:39 PM, Sagi Grimberg wrote:
>
>>>> Hi Sagi
>>>> It is still reproducible with the change, here is the log:
>>>>
>>>> # time nvme reset /dev/nvme0
>>>>
>>>> real    0m12.973s
>>>> user    0m0.000s
>>>> sys     0m0.006s
>>>> # time nvme reset /dev/nvme0
>>>>
>>>> real    1m15.606s
>>>> user    0m0.000s
>>>> sys     0m0.007s
>>>
>>> Does it speed up if you use less queues? (i.e. connect with -i 4) ?
>> Yes, with -i 4, it has stablee 1.3s
>> # time nvme reset /dev/nvme0
>
> So it appears that destroying a qp takes a long time on
> IB for some reason...
>
>> real 0m1.225s
>> user 0m0.000s
>> sys 0m0.007s
>>
>>>
>>>>
>>>> # dmesg | grep nvme
>>>> [  900.634877] nvme nvme0: resetting controller
>>>> [  909.026958] nvme nvme0: creating 40 I/O queues.
>>>> [  913.604297] nvme nvme0: mapped 40/0/0 default/read/poll queues.
>>>> [  917.600993] nvme nvme0: resetting controller
>>>> [  988.562230] nvme nvme0: I/O 2 QID 0 timeout
>>>> [  988.567607] nvme nvme0: Property Set error: 881, offset 0x14
>>>> [  988.608181] nvme nvme0: creating 40 I/O queues.
>>>> [  993.203495] nvme nvme0: mapped 40/0/0 default/read/poll queues.
>>>>
>>>> BTW, this issue cannot be reproduced on my NVME/ROCE environment.
>>>
>>> Then I think that we need the rdma folks to help here...
>
> Max?

It took me 12s to reset a controller with 63 IO queues with 5.16-rc3+.

Can you try repro with latest versions please ?

Or give the exact scenario ?


