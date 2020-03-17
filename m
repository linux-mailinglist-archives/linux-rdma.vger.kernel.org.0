Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5E9118913A
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 23:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgCQWTI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 18:19:08 -0400
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:28641
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbgCQWTI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Mar 2020 18:19:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WE6C/ElINSUNRql0US3cYd6mrhtl6UtK1dcZzFEbIjYgexbbPHj2JAqhOTz/HDxphXz0vA5YBKXLbCIXzfxVqoYx6y9wgK2P6h4kk9ntHkmONls7gUsgW1JgieTujLOa8dlvz5BoFNdq5UDTIQnpGiqhkgQkzlcraGTC//HdB/t/nSciyo1aU2IVAdr3S/4BhEtwXUNyt+WjICJ/rf26Sdb2NWG/WEMhxA6LF3qML2Pov3R5IoZcDCE8C9vRJkdtkYsUjkqMZlGwDz2i8eUkcEQfdDYLaCJnyLKPILEAh5T+EhKXhJlG/r/S70Ej2o4kUtYlfEOk5xKSqdOK/rFT1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bd/Xgnoy3PqQJbsYjxuaNXzTRZSLdp2gEfvm3bkRKco=;
 b=TWl0nu/eIWI5KbqhA2KFlMCC9wBPyZ0kjuDeqpzSsoOyRPaiq4xgndwvTSoRkhvxstTrSlkWGRzSUy7p0KFvIlcIDFIfNWDX0YejeyE/EIA1Dniok6TLUtNT8/BTpOx7T+0rbKiN3zvmUMkZMIgo+ZvYzWHkfTZHfcHMJHmmlH9toIYVTImxhMQ4Jc9xc1aule1vPgEJmm045X5f2PK78JuZGoqw05U2nqQmLnfjvfXQXovgMCP5P4pA/jTlHnu+v1z0ZvHCrmVUgdnHpDVh+/tFfnRpPjIyoswGrjySNtPRN7zEFZp5X2VwoqnOf1X4uqoAep7/bmfefkQ3FVB9Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bd/Xgnoy3PqQJbsYjxuaNXzTRZSLdp2gEfvm3bkRKco=;
 b=tDtdGs+F+/7t4pcS24k0JJ/0SboGgpHOcZBNpeXrkcvSODvVDLsM8aBUyA61JzUlrmWs2fc5xY8pqHYm3lFE5pThTUCShnHH7cIYIFnos8ayA7OtHmRX/cHY24HdSOx8yJvO/S954p9cR66hIHodDOyQKgSuD5mBx4OOOjCSiZw=
Received: from DB6PR0801CA0053.eurprd08.prod.outlook.com (2603:10a6:4:2b::21)
 by AM0PR05MB6132.eurprd05.prod.outlook.com (2603:10a6:208:133::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Tue, 17 Mar
 2020 22:19:04 +0000
Received: from DB5EUR03FT006.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:2b:cafe::23) by DB6PR0801CA0053.outlook.office365.com
 (2603:10a6:4:2b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend
 Transport; Tue, 17 Mar 2020 22:19:04 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT006.mail.protection.outlook.com (10.152.20.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Tue, 17 Mar 2020 22:19:03 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 18 Mar 2020 00:19:02
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 18 Mar 2020 00:19:02 +0200
Received: from [172.27.14.181] (172.27.14.181) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 18 Mar 2020 00:19:00
 +0200
Subject: Re: [PATCH 4/5] IB/core: cache the CQ completion vector
To:     Chuck Lever <chucklever@gmail.com>
CC:     <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
        <loberman@redhat.com>, <bvanassche@acm.org>,
        <linux-rdma@vger.kernel.org>, <kbusch@kernel.org>,
        <leonro@mellanox.com>, <jgg@mellanox.com>, <dledford@redhat.com>,
        <idanb@mellanox.com>, <shlomin@mellanox.com>,
        "Oren Duer" <oren@mellanox.com>, <vladimirk@mellanox.com>
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-5-maxg@mellanox.com>
 <448195E1-CE26-4658-8106-91BAFF115853@gmail.com>
 <078fd456-b1bc-a103-070b-d1a8ea6bff9c@mellanox.com>
 <82D6A70B-A201-4592-A031-F8EC581C0123@gmail.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <48d76fb8-538d-7e0b-c5c8-9b984f229a0c@mellanox.com>
Date:   Wed, 18 Mar 2020 00:18:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <82D6A70B-A201-4592-A031-F8EC581C0123@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.27.14.181]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(396003)(346002)(136003)(199004)(46966005)(70586007)(70206006)(86362001)(31696002)(107886003)(478600001)(47076004)(186003)(2616005)(26005)(53546011)(336012)(16526019)(356004)(54906003)(31686004)(4326008)(2906002)(5660300002)(16576012)(36756003)(81166006)(8676002)(8936002)(81156014)(6916009)(316002)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6132;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1ff8467-4b2d-456f-85a3-08d7cac1339c
X-MS-TrafficTypeDiagnostic: AM0PR05MB6132:
X-Microsoft-Antispam-PRVS: <AM0PR05MB6132A4EB536A69770FF1E918B6F60@AM0PR05MB6132.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0345CFD558
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E3wQTS9DowfiHKUAkgHZhU67890LW48/MNIPXUWVCqpWZiMrYv+06p6JgCedvZoWYDEDrt5F/sEm5in0EL+V+01uBy9WiATdtkvF2J6td5B2wlrqT22ruVJumMoTDq45kf4+rxh9gzNlBwC/USuGWxWTdg6L6s1kDTAPbTrXYxuJxVXkY8gLHchebPka+Dv2zgRfYzlPcCvUkvIfk8tSST6inKqFF05DzNJ3/ovOHTph7nBopAppBy5DupgDD9SabPXdV3jPHVzGHmMdRVXHa31AvTM9kt03lLgLsLnwbRtFE0me/WRyHlOUFks6ydOG/ODLn/FZZzoZMFLVAVhaYd+e/6ay4JuqOYK8xf0LVZHGziwi4i6nqrlfh1eUH2q3TZ54zoXKxfyG4HbiRPLxvUCrHSPfuBZ7nB9wWTksA6aP5fnwOegZ0kQTlQsvfZXldETCE1qvE+GYmNkP/LgX2t2kO6gZaYUiZewSUILaVlFTVwZ27XP20ZWEEdBXCMOJEdnhXth89g8gmULlz5SaLPYCkd1fPO15pK1GOrGECgg=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 22:19:03.7717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ff8467-4b2d-456f-85a3-08d7cac1339c
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6132
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/17/2020 10:36 PM, Chuck Lever wrote:
>
>> On Mar 17, 2020, at 11:41 AM, Max Gurtovoy <maxg@mellanox.com> wrote:
>>
>>
>> On 3/17/2020 5:19 PM, Chuck Lever wrote:
>>> Hi Max-
>>>
>>>> On Mar 17, 2020, at 9:40 AM, Max Gurtovoy <maxg@mellanox.com> wrote:
>>>>
>>>> In some cases, e.g. when using ib_alloc_cq_any, one would like to know
>>>> the completion vector that eventually assigned to the CQ. Cache this
>>>> value during CQ creation.
>>> I'm confused by the mention of the ib_alloc_cq_any() API here.
>> Can't the user use ib_alloc_cq_any() and still want to know what is the final comp vector for his needs ?
> If your caller cares about the final cv value, then it should not use
> the _any API. The point of _any is that the caller really does not care,
> the cv value is hidden because it is not consequential. Your design
> breaks that assumption/contract.

How come it breaks ?

If the ULP want to let the rdma-core layer to allocate the optimal 
vector and rely on it to do so, why is it wrong to know the final vector 
assigned ?

I can remove it and change the SRP target to use ib_alloc_cq but it 
doesn't break the contract.

>
>>> Is your design somehow dependent on the way the current ib_alloc_cq_any()
>>> selects comp_vectors? The contract for _any() is that it is an API for
>>> callers that simply do not care about what comp_vector is chosen. There's
>>> no guarantee that the _any() comp_vector allocator will continue to use
>>> round-robin in the future, for instance.
>> it's fine. I just want to make sure that I'll spread the SRQ's equally.
> The _any algorithm is simplistic, it spreads cvs for the system as a whole.
> All devices, all callers. You're going to get some bad degenerate cases
> as soon as you have multiple users of the SRQ facility.

how come ? This facility is per PD that is created by the ULP.


>
> So, you really want to have a more specialized comp_vector selector for
> the SRQ facility; one that is careful to spread cvs per device, independent
> of the global allocator, which is good enough for normal cases.
>
> I think your tests perform well simply because there was no other contender
> for comp_vectors on your test system.

For the testing result I did I used NVMf target that uses ib_alloc_cq so 
it would be good anyway.

According to your theory ib_alloc_cq_any will not perform well and have 
degenerate cases anyway regardless the SRQ feature that was intended to 
save resources and stay with great performance.

>
>
>>> If you want to guarantee that there is an SRQ for each comp_vector and a
>>> comp_vector for each SRQ, stick with a CQ allocation API that enables
>>> explicit selection of the comp_vector value, and cache that value in the
>>> caller, not in the core data structures.
>> I'm Ok with that as well. This is exactly what we do in the nvmf/rdma but I wanted to stick also with the SRP target approach.
>>
>> Bart,
>>
>> Any objection to remove the call for ib_alloc_cq_any() from ib_srpt and use ib_alloc_cq() ?
>>
>>
>>>
>>>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>>>> ---
>>>> drivers/infiniband/core/cq.c | 1 +
>>>> include/rdma/ib_verbs.h      | 1 +
>>>> 2 files changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
>>>> index 4f25b24..a7cbf52 100644
>>>> --- a/drivers/infiniband/core/cq.c
>>>> +++ b/drivers/infiniband/core/cq.c
>>>> @@ -217,6 +217,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
>>>> 	cq->device = dev;
>>>> 	cq->cq_context = private;
>>>> 	cq->poll_ctx = poll_ctx;
>>>> +	cq->comp_vector = comp_vector;
>>>> 	atomic_set(&cq->usecnt, 0);
>>>>
>>>> 	cq->wc = kmalloc_array(IB_POLL_BATCH, sizeof(*cq->wc), GFP_KERNEL);
>>>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>>>> index fc8207d..0d61772 100644
>>>> --- a/include/rdma/ib_verbs.h
>>>> +++ b/include/rdma/ib_verbs.h
>>>> @@ -1558,6 +1558,7 @@ struct ib_cq {
>>>> 	struct ib_device       *device;
>>>> 	struct ib_ucq_object   *uobject;
>>>> 	ib_comp_handler   	comp_handler;
>>>> +	u32			comp_vector;
>>>> 	void                  (*event_handler)(struct ib_event *, void *);
>>>> 	void                   *cq_context;
>>>> 	int               	cqe;
>>>> -- 
>>>> 1.8.3.1
>>>>
>>> --
>>> Chuck Lever
>>> chucklever@gmail.com
>>>
>>>
>>>
> --
> Chuck Lever
> chucklever@gmail.com
>
>
>
