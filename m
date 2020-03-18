Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEF1E189999
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 11:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgCRKkP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 06:40:15 -0400
Received: from mail-eopbgr130072.outbound.protection.outlook.com ([40.107.13.72]:39041
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726486AbgCRKkO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Mar 2020 06:40:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdXHfmuFE8hGEI9AAnQhV70xTvET40htmhD8mq7dHcXw4tI+7RD945lcUlkxx4pv7KcRSJON917RsaJyZ0ZT0ooP6h2pRDAbyRp5S9k4U2/CzczfK96PTupDmIhmrXUnOJp5WGC75viWVudaF8Co3bOEyPt3jHq0DkBjO+ivM98QJYFm/k1RxEQulJTKl1/k9Ac2LI3DdIJwm1OxSwfMMkPVxO7/ttG03Yb6jgSgk4QW5CZpv7516zmFRD8/LYzfEH1YaFWk63I3j+Q8YTJeU0/mX9622/6rsGn96L4PZuHZZOR9ayNV38h40YkFRHAN6N4yoEHlLIvz0OZVeGmgVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmPidaE0tB2SqcpbxEshXWWzWoc2FSgrNxbaIt5UZXo=;
 b=cNSMsC4xb0pq5tokCvnSSJ9A6DogSpxDgspvksuHjquvwQdnwwBlvpOge6VHtVRxbxoijalbHFSelasX3Qt8gxgMwHBV4dLSEpsW7ayQCKd4Xx0dhITOoopVeRluIw0U3O/DEOvaMMh8EEnPJNSJy8HD/riMPyPU/9EH7WlW8xsvL6M3yR/5KgYg2G/B6uJp3Gtggg88wSMN7rVnwomyE1AcVyso/7Yg1uAUv0nyqkP0LL7Pvpcoz3stNvn3qez73YFsSpXn1wg/qiP6O2e/kavQM9AIlVeuUn0hutt1ylpQyFx6/1l5U5n9jCLWh2FLJThSznCwspfr4rzWshNIFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmPidaE0tB2SqcpbxEshXWWzWoc2FSgrNxbaIt5UZXo=;
 b=MF+OzQ5nVY+tFIHGjd+x0OuZkRkgorwBUXTCbNekc08ieVbr0MnGYagChj7f8cRGrUaFNe6SPy0j6hc/NcGFpEmx5ksifrRl85G82hIy1yCXZ7ElZrOE7H5qSox5eLqeyYJXFPqhrS5rq7oaaQeD2it28SUrCLYkFpYBljQqQ7c=
Received: from AM4PR0202CA0024.eurprd02.prod.outlook.com
 (2603:10a6:200:89::34) by VI1PR05MB4351.eurprd05.prod.outlook.com
 (2603:10a6:803:3e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.19; Wed, 18 Mar
 2020 10:40:10 +0000
Received: from AM5EUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:200:89:cafe::78) by AM4PR0202CA0024.outlook.office365.com
 (2603:10a6:200:89::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend
 Transport; Wed, 18 Mar 2020 10:40:09 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT013.mail.protection.outlook.com (10.152.16.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Wed, 18 Mar 2020 10:40:09 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 18 Mar 2020 12:40:04
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 18 Mar 2020 12:40:04 +0200
Received: from [172.27.15.134] (172.27.15.134) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 18 Mar 2020 12:39:45
 +0200
Subject: Re: [PATCH 1/5] IB/core: add a simple SRQ set per PD
To:     Leon Romanovsky <leonro@mellanox.com>
CC:     <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
        <loberman@redhat.com>, <bvanassche@acm.org>,
        <linux-rdma@vger.kernel.org>, <kbusch@kernel.org>,
        <jgg@mellanox.com>, <dledford@redhat.com>, <idanb@mellanox.com>,
        <shlomin@mellanox.com>, <oren@mellanox.com>,
        <vladimirk@mellanox.com>
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-2-maxg@mellanox.com> <20200317135518.GG3351@unreal>
 <46bb23ed-2941-2eaa-511a-3d0f3b09a9ed@mellanox.com>
 <20200318064724.GP3351@unreal>
 <ec3ff6af-dd68-d049-5ff3-0c01320117e7@mellanox.com>
 <20200318102942.GT3351@unreal>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <32f23851-6f89-18ef-236f-1416c49b079c@mellanox.com>
Date:   Wed, 18 Mar 2020 12:39:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200318102942.GT3351@unreal>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.27.15.134]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(346002)(376002)(199004)(46966005)(6636002)(70586007)(36756003)(86362001)(31696002)(70206006)(6862004)(31686004)(2906002)(107886003)(53546011)(37006003)(54906003)(2616005)(186003)(16526019)(336012)(47076004)(4326008)(26005)(356004)(5660300002)(478600001)(8936002)(81166006)(16576012)(316002)(8676002)(81156014)(36906005)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4351;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0f4ac43-b91a-4b9e-d1c6-08d7cb28bb29
X-MS-TrafficTypeDiagnostic: VI1PR05MB4351:
X-Microsoft-Antispam-PRVS: <VI1PR05MB435166F9ABCD8F969A639A52B6F70@VI1PR05MB4351.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-Forefront-PRVS: 03468CBA43
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6wpwt1VLRX0wJ16dg2AZm+sPYWlPj/jWnhTQX5X7ZW5tK2ExO0D2iAi+FHHx7A3jesMu6Kz7rdTMAEE/fOIv58qSTcKsrM8QgtE26RKXSpjXUcF5+xLY4rgs4y5eX0pgpc0aKkf40qp6T/bUY6wjpQRKfuSQJ1OpC1Ioetg6ICqRsQB157h/15sv3aD6mrmyhfrI0zIO9WBBAGYa/9+fiXs15egWKBaDT1jG8HfsaaGxTKmU10LiHbYlYzTTdLB5tcQVhaezQACqlvm9NtJS3IEriMc9RshBz9MOzL7y5U2E0wuPFnxXVs8E/5dEwmKz7JKmExB57Fs0pn07fu29uDWH2gxKlhk79cS7judNCnfTob3AJQKdB0qRk7by+h6AqU8V67kKqpShNzsk0n85OFMEE25tswnpX9JMRnBmI3J+89bxTSzUcqwvBo+pCRfDDXojRTdC/CfQIvh0Qrwzu2xqy5jV1BtOr7M1Zs3vZiUX+cxohXWgnNaBfrQ/qfool5eRy2EoUV9CFQ+EqUX7Jaq4O0sTZ9804uxUYo1D4A=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 10:40:09.3783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f4ac43-b91a-4b9e-d1c6-08d7cb28bb29
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4351
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/18/2020 12:29 PM, Leon Romanovsky wrote:
> On Wed, Mar 18, 2020 at 11:46:19AM +0200, Max Gurtovoy wrote:
>> On 3/18/2020 8:47 AM, Leon Romanovsky wrote:
>>> On Tue, Mar 17, 2020 at 06:37:57PM +0200, Max Gurtovoy wrote:
>>>> On 3/17/2020 3:55 PM, Leon Romanovsky wrote:
>>>>> On Tue, Mar 17, 2020 at 03:40:26PM +0200, Max Gurtovoy wrote:
>>>>>> ULP's can use this API to create/destroy SRQ's with the same
>>>>>> characteristics for implementing a logic that aimed to save resources
>>>>>> without significant performance penalty (e.g. create SRQ per completion
>>>>>> vector and use shared receive buffers for multiple controllers of the
>>>>>> ULP).
>>>>>>
>>>>>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>>>>>> ---
>>>>>>     drivers/infiniband/core/Makefile  |  2 +-
>>>>>>     drivers/infiniband/core/srq_set.c | 78 +++++++++++++++++++++++++++++++++++++++
>>>>>>     drivers/infiniband/core/verbs.c   |  4 ++
>>>>>>     include/rdma/ib_verbs.h           |  5 +++
>>>>>>     include/rdma/srq_set.h            | 18 +++++++++
>>>>>>     5 files changed, 106 insertions(+), 1 deletion(-)
>>>>>>     create mode 100644 drivers/infiniband/core/srq_set.c
>>>>>>     create mode 100644 include/rdma/srq_set.h
>>>>>>
>>>>>> diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
>>>>>> index d1b14887..1d3eaec 100644
>>>>>> --- a/drivers/infiniband/core/Makefile
>>>>>> +++ b/drivers/infiniband/core/Makefile
>>>>>> @@ -12,7 +12,7 @@ ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
>>>>>>     				roce_gid_mgmt.o mr_pool.o addr.o sa_query.o \
>>>>>>     				multicast.o mad.o smi.o agent.o mad_rmpp.o \
>>>>>>     				nldev.o restrack.o counters.o ib_core_uverbs.o \
>>>>>> -				trace.o
>>>>>> +				trace.o srq_set.o
>>>>> Why did you call it "srq_set.c" and not "srq.c"?
>>>> because it's not a SRQ API but SRQ-set API.
>>> I would say that it is SRQ-pool and not SRQ-set API.
>> If you have some other idea for an API, please share with us.
>>
>> I've created this API in core layer to make the life of the ULPs easier and
>> we can see that it's very easy to add this feature to ULPs and get a big
>> benefit of it.
> No one here said against the feature, but tried to understand the
> rationale behind name *_set and why you decided to use "set" term
> and not "pool", like was done for MR pool.

Ok. But srq_pool was the name I used 2 years ago and you didn't like 
this back then.

So I renamed it to srq_set.

>
> So my suggestion is to name file as srq_pool.c and use rdma_srq_poll_*()
> function names.

No problem.

>
> Thanks
>
>>> Thanks
