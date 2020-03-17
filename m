Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95B8F1890E7
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 22:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgCQV46 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 17:56:58 -0400
Received: from mail-eopbgr120045.outbound.protection.outlook.com ([40.107.12.45]:3632
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbgCQV46 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Mar 2020 17:56:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dO+ABR8atUPp71iBhU6SGbTK5bf7NvI9ibbFMt+U2zNeQ32pfxmzpqyks0UfkoiGKbHHsuEP/YFczPMzkn563b/luVAj/kVNh3cZwzQg+XA2FB/jyO74FxhN/CyH+2Q/eACaiGorbxAekBRapZtaAKgWBFZEGHgtFfj1VpCwp9JGa2LOIZbstaJm7ePqQ5Pxv0CwGZ0yxH4UR6cQwWkowJwxWbkxkCf3lOZ3BnF61UxJP9mpCkIP2+JlxRMMmJnDUXENuLE97Gshj4os6rtIjNyE+xzjMweeNzvOtyOIZQ2kRg1pDhcRtUq4Xlx4O+43euOAMsjCqpB0XcXNX/tQsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCOV0b9sx1SlfGSKVGBSA+gLRUuwd3Z017RAawaOGSE=;
 b=Yh6QkEezrT2BKuAPrD3gH7dpzKQP73ETDUqXUjeM8DhD7mMPK17ArQqNKUzcC3Fz87ueoDIyQMV9SEgagPwSKxR0p3QdGhfg+66ldzk1fGh/XPg8BPphYqkTfW6d8825GORiFRc/DZIDuSh9Vkt7ideJnkblkLfxJHYocc64eqxstyo45T8NoME9gC7uaq+BPvO2YjaxJ2PHAR7PGMOEf9Pyw2imjaUrY2TxkqgnFyEVTm92BNTi38tMxxzCg7ZmMbgcEX/v/00okD7ydxxm1cAkgbULWX6au+9Eq6qLpxcgXzkLZjBh4qf9C7ieP30Pv0kca02+n71ffWHS2QCpZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCOV0b9sx1SlfGSKVGBSA+gLRUuwd3Z017RAawaOGSE=;
 b=hAdL4K/3o49qFaJmcEtDHVLknudBVidL5dFjaW6q7i5yoZuF8fOvTJnhcN+GfQAxNc8HW7/QmbxqvorD8FVVe7sMPCJzxjStdJcUBt9P1PJH7TBWu2WpSZTFFfevzIrxBle64Aw3y3OQ2SUdQwqwQxSAMoZvh1pUhOeK4qZydmA=
Received: from VI1PR0701CA0068.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::30) by PR1PR05MB5483.eurprd05.prod.outlook.com
 (2603:10a6:102:c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Tue, 17 Mar
 2020 21:56:40 +0000
Received: from VE1EUR03FT022.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:800:5f:cafe::1b) by VI1PR0701CA0068.outlook.office365.com
 (2603:10a6:800:5f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.12 via Frontend
 Transport; Tue, 17 Mar 2020 21:56:40 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT022.mail.protection.outlook.com (10.152.18.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Tue, 17 Mar 2020 21:56:38 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 17 Mar 2020 23:56:37
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 17 Mar 2020 23:56:36 +0200
Received: from [172.27.14.181] (172.27.14.181) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 17 Mar 2020 23:56:17
 +0200
Subject: Re: [PATCH 1/5] IB/core: add a simple SRQ set per PD
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
        <loberman@redhat.com>, <bvanassche@acm.org>,
        <linux-rdma@vger.kernel.org>, <kbusch@kernel.org>,
        <dledford@redhat.com>, <idanb@mellanox.com>,
        <shlomin@mellanox.com>, <oren@mellanox.com>,
        <vladimirk@mellanox.com>
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-2-maxg@mellanox.com> <20200317135518.GG3351@unreal>
 <46bb23ed-2941-2eaa-511a-3d0f3b09a9ed@mellanox.com>
 <20200317181036.GX13183@mellanox.com>
 <290500dc-7a89-2326-2abf-1ab9f613162e@mellanox.com>
 <20200317184338.GY13183@mellanox.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <d2e06706-4671-aeab-1c7e-c5bf0f3c65a4@mellanox.com>
Date:   Tue, 17 Mar 2020 23:56:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317184338.GY13183@mellanox.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.27.14.181]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(396003)(346002)(199004)(46966005)(336012)(16526019)(81156014)(26005)(186003)(31696002)(8676002)(86362001)(2616005)(81166006)(107886003)(37006003)(6862004)(2906002)(6636002)(54906003)(16576012)(4326008)(70586007)(356004)(53546011)(478600001)(31686004)(8936002)(316002)(36906005)(36756003)(70206006)(47076004)(5660300002)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:PR1PR05MB5483;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ef0a246-ff5d-445e-6d43-08d7cabe11dd
X-MS-TrafficTypeDiagnostic: PR1PR05MB5483:
X-Microsoft-Antispam-PRVS: <PR1PR05MB548323DD6E59370B79C54844B6F60@PR1PR05MB5483.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0345CFD558
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +/7+PfaPqTV4zAGoqp22Qi0rr1SpV1JVlxRgCFml/LBC8VYPwvShtgs27NGCsms/Q0WbCOCw/lga1/mxGZz3q3hUFI2lqdGI2sOwPvDG9NeeyYAIjSkEMLK3HKsix/zFt37+kiOCGtFI9uWD5txnbZoQ1Q/+6TXFffucr/cTUTVM+Ah0OQowH4v8R7tyYwh027jiEVL+OOARJdSMaudqRt68O0d99oR/g56r/Syqi4La4JWpLij5/aiiu5VRK7KhrqPUwqGghSFqM8WF3+ui6MV8yM60ZH9Lz3rHNjynljtkJVQZtoYmi/t1ywF/NvVaz9PKJdwLiP8VFnNdEvd1G6CFnHMH4cca8+5MX+9NkbYQ9gEdaqgwglOZZylsZB6INJsmqpdNQr+magWNm7OeaJq2SXjCMsBgfQotViu5/AuSu4sp4HYYJ4gKdghrqKBNPfdP0Huo2cDHenHLOOiFPg16S41TuO3Fhm6Fp35A/+RXABL3QpvUDqfgqW8EhHtfea9962KIEs/xIf9WNuKRhnHinKTTl1cg5jdpwaWXby0=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 21:56:38.6373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef0a246-ff5d-445e-6d43-08d7cabe11dd
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR05MB5483
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/17/2020 8:43 PM, Jason Gunthorpe wrote:
> On Tue, Mar 17, 2020 at 08:24:30PM +0200, Max Gurtovoy wrote:
>> On 3/17/2020 8:10 PM, Jason Gunthorpe wrote:
>>> On Tue, Mar 17, 2020 at 06:37:57PM +0200, Max Gurtovoy wrote:
>>>
>>>>>> +#include <rdma/ib_verbs.h>
>>>>>> +
>>>>>> +struct ib_srq *rdma_srq_get(struct ib_pd *pd);
>>>>>> +void rdma_srq_put(struct ib_pd *pd, struct ib_srq *srq);
>>>>> At the end, it is not get/put semantics but more add/remove.
>>>> srq = rdma_srq_add ?
>>>>
>>>> rdma_srq_remove(pd, srq) ?
>>>>
>>>> Doesn't seems right to me.
>>>>
>>>> Lets make it simple. For asking a SRQ from the PD set lets use rdma_srq_get
>>>> and returning to we'll use rdma_srq_put.
>>> Is there reference couting here? get/put should be restricted to
>>> refcounting APIs, IMHO.
>> I've added a counter (pd->srqs_used) that Leon asked to remove .
>>
>> There is no call to kref get/put here.
> I didn't look closely, any kind of refcount scheme is reasonable, but
> if add is supposed to create a new srq then that isn't 'get'..

No, we don't create new srq during the "get". We create a set using 
"rdma_srq_set_init".

"get" will simple pull some srq from the set and "put" will push it back.

>
>> Do you prefer that I'll change it to be array in PD: "struct
>> ib_srq           **srqs;" ?
> Not particularly..
>
> It actually feels a bit weird, should there be some numa-ness involved
> here so that the SRQ with memory on the node that is going to be
> polling it is returned?

Maybe this will be the next improvement. But for now the receive buffers 
are allocated by the ULP.

The idea is to spread the SRQs as much as possible as we do for QP/CQ to 
reach almost the same performance.

In case of 1 SRQ we can't reach good performance since many resources 
and cores are racing for 1 resources.

In case of regular RQ we allocate many buffers that most of the time are 
idle.

If we'll spread SRQs for all cores/vectors we have we'll get great perf 
with saving resources that might be critical in MQ ULPs as NVMf/SRP 
targets that might serve hundreds initiators with hundreds of queues each.


>
>> And update ib_alloc_pd API to get pd_attrs and allocate the array during PD
>> allocation ?
> The API is a bit more composable if things can can be done as
> following function calls are done that way.. I don't like the giant
> multiplexor structs in general
>
> Jason
