Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A58818BC67
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 17:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgCSQ16 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 12:27:58 -0400
Received: from mail-eopbgr150084.outbound.protection.outlook.com ([40.107.15.84]:56394
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727416AbgCSQ16 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Mar 2020 12:27:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMwNMlXDwTNYzbzcd6cHx6hDHCQhgunOHbSbBp35GUm0mnTf+eLm5ye5TrWbOHQI414BvaKiXijjDY+23ZWa9V86H1mOSxlyOVdpzaVl9EW9QZ+GO/tqx1dLmQZGOlRCfx9oYYjKmWvhkAhQYXbnKcLXggCsBGq7bWHyoDw4j/1AEGvjN1g5jAv/X4oHaq5BfGfr8NedHPU0EBmxjn3J/n/j0xaTPJ9vNBdepai+JvvpZjCXoqov94HLFNFC5QuZftXcElZuGnhfuApIsKHGOhsmnKFmZcnLu+mSXwzvyUsktVp0jvvfEl9Y7uGwviZ37hajHeYJnVktAyumbqRMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWY8XHWlBfImIxF2am7pmFR9Boi8r2+XIHndw+cCaGs=;
 b=XyWBIJWRzMBKzWmh3AslgSpTeHKuIQmAgJmq5J1R3okvCI8KBCutPSz3qqnSmKba6IaRm+hB2XezVGWFTSENcF8fxEvyRPXRD9Lmw5kuXQIEP8Kf7/0MzlZIvzJz4K525EXhOkfwNiEUr+HP5caRsRNe6xtDegBSjKNqNXdzpvLAzlqF1J+NNoV0hbnUlSFEjS49T/lyF6TC5g1u1vyESxnwZIhNzEkOk8fYJhWPdVyL6TbAg/zD3X3n4NYBYzlfW0SfzjUO0RZjnd0Fq5cpS5fakUNQ6xSsV/5qnJ+mqibxkdoy5umJ3gUOwFgOZogm4IP1BylQeY2v3UdbF+IBIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWY8XHWlBfImIxF2am7pmFR9Boi8r2+XIHndw+cCaGs=;
 b=hiCm7irLFYxnfDvwWg1je1T5Qq2eysfeB8BLk9MpEc6L1GHCGHTCmgvbiYgfGS4oimx/IirWfQLg90Vz8S+1Sb/ycjMO4KaVvcoz4XVF5gSxx3DA6YJ6zXfhtUj74NPqli6OQSA7vfN2EMIoUJGZ7UOPlyj+Y0CiqXt2FZ9C+Jo=
Received: from AM6P191CA0047.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::24)
 by DB7PR05MB5657.eurprd05.prod.outlook.com (2603:10a6:10:82::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Thu, 19 Mar
 2020 16:27:55 +0000
Received: from VE1EUR03FT064.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:7f:cafe::fa) by AM6P191CA0047.outlook.office365.com
 (2603:10a6:209:7f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Thu, 19 Mar 2020 16:27:55 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT064.mail.protection.outlook.com (10.152.19.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Thu, 19 Mar 2020 16:27:54 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 19 Mar 2020 18:32:04
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 19 Mar 2020 18:32:04 +0200
Received: from [172.27.15.129] (172.27.15.129) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 19 Mar 2020 18:27:39
 +0200
Subject: Re: [PATCH v2 3/5] nvmet-rdma: use SRQ per completion vector
From:   Max Gurtovoy <maxg@mellanox.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
        <loberman@redhat.com>, <linux-rdma@vger.kernel.org>,
        <kbusch@kernel.org>, <leonro@mellanox.com>, <dledford@redhat.com>,
        <idanb@mellanox.com>, <shlomin@mellanox.com>, <oren@mellanox.com>,
        <vladimirk@mellanox.com>, <rgirase@redhat.com>
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-4-maxg@mellanox.com>
 <d72e0312-1dfd-460e-bc83-49699d86dd64@acm.org>
 <5623419a-39e6-6090-4ae2-d4725a8b9740@mellanox.com>
 <20200319115654.GV13183@mellanox.com>
 <0b11c26f-d3de-faf5-5609-c290ea46ed9c@mellanox.com>
 <20200319135356.GZ13183@mellanox.com>
 <6dcf300c-d010-829b-b996-285ad16786d5@acm.org>
 <50dd8f5d-d092-54bc-236d-1e702fb95240@mellanox.com>
 <6e3cc1c4-b24e-f607-42b3-5b83dd8c312c@mellanox.com>
Message-ID: <d5afe0a5-5fab-203e-a3fc-bba9db86ff05@mellanox.com>
Date:   Thu, 19 Mar 2020 18:27:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6e3cc1c4-b24e-f607-42b3-5b83dd8c312c@mellanox.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.27.15.129]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(199004)(46966005)(316002)(54906003)(31696002)(16576012)(53546011)(6636002)(47076004)(36906005)(86362001)(110136005)(31686004)(36756003)(8936002)(81166006)(81156014)(8676002)(2906002)(5660300002)(478600001)(70206006)(70586007)(4326008)(186003)(356004)(2616005)(26005)(16526019)(336012)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB5657;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0624cb03-0768-4e21-93e1-08d7cc227a3f
X-MS-TrafficTypeDiagnostic: DB7PR05MB5657:
X-Microsoft-Antispam-PRVS: <DB7PR05MB56577807643CE0E2E0BFE352B6F40@DB7PR05MB5657.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0347410860
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5sg5w7yxpHJjh1Z6R3L9sV4RavtMBRsZhHpUkchSEOCC01ZLYhxVXeeqoooIcZi7Sc9Pyzxfw2HYTm1eIntF6AdwfOyIs5SUn/KMFk56dvGkt2X26BFNxYgvJOPKkpNM7mnwu50YrcQ+wbVNziF7WGCTUqSqP2XICBdzGsNm06Zs/fO5uuhAEeIltHQv9Fy+Cxs4wdCIZmIhGxRD/iVKPv8u33J9mr4NT0K8q+k/r51E976olHO/XM0sXhCfV51jvfIH1d7huVmdyXOTt1OfcGgCliHAiV/uQitwoFBc0euZzUJCjr+j3Z9KuqbNVxmNyguGAVmwSMbzlAIQ2Lk98O+w3j6PoP/Zh0ZsjVyjitJaOLLcu3ZJcXKNc4w6EcHrhwUpM79MnL6WFzbqao3ReU/mPyGNxXdCUb9qommdWD6GQ7E8OmYvynTF88qpBiFmD4UTwY7EINd3rf7Jwt8ayQmtjinNGjvYubVY5je83+alW9MpeEyPnbtedXK4u+Yzut+wp6O3LQW73bIDcXJth08qtOObPC8CGM+D3zGW7P4=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 16:27:54.6204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0624cb03-0768-4e21-93e1-08d7cc227a3f
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5657
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

and again - hopefully last time I'm blocked...

On 3/19/2020 5:44 PM, Max Gurtovoy wrote:
>
> sending again - I think the previous mail was blocked.
>
> On 3/19/2020 5:10 PM, Max Gurtovoy wrote:
>>
>>
>> On 3/19/2020 4:49 PM, Bart Van Assche wrote:
>>> On 3/19/20 6:53 AM, Jason Gunthorpe wrote:
>>>> On Thu, Mar 19, 2020 at 02:48:20PM +0200, Max Gurtovoy wrote:
>>>>
>>>>> Nevertheless, this situation is better from the current SRQ per HCA
>>>>> implementation.
>>>>
>>>> nvme/srp/etc already use srq? I see it in the target but not 
>>>> initiator?
>>>>
>>>> Just worried about breaking some weird target somewhere
>>
>> Jason,
>>
>> The feature is only for target side and has no influence on initiator 
>> an the ULP level.
>>
>> The only thing that I did is fixed the SRQ implementation for 
>> nvme/rdma and srpt that allocate 1 SRQ per device.
>>
>> Now there are N SRQs per device that try to act as pure MQ 
>> implementation (without SRQ).
>>
>>>
>>> From the upstream SRP target driver:
>>>
>>> static void srpt_get_ioc(struct srpt_port *sport, u32 slot,
>>>              struct ib_dm_mad *mad)
>>> {
>>>     [ ... ]
>>>     if (sdev->use_srq)
>>>         send_queue_depth = sdev->srq_size;
>>>     else
>>>         send_queue_depth = min(MAX_SRPT_RQ_SIZE,
>>>                        sdev->device->attrs.max_qp_wr);
>>>     [ ... ]
>>>     iocp->send_queue_depth = cpu_to_be16(send_queue_depth);
>>>     [ ... ]
>>> }
>>>
>>> I'm not sure the SRP initiator uses that data from the device 
>>> management
>>> I/O controller profile.
>>>
>>> Anyway, with one SRQ per initiator it is possible for the initiator to
>>> prevent SRQ overflows. I don't think that it is possible for an 
>>> initiator
>>> to prevent target side SRQ overflows if shared receive queues are 
>>> shared
>>> across multiple initiators.
>>
>> I don't to change initiator code and prevent overflow.
>>
>> As I explained earlier, the SRQs in the target side will be assigned 
>> for all controllers for specific device (instead of global 1 per 
>> device) and share the receive buffers.
>>
>> Not per initiator. This will cause lock contention.
>>
>> In case the target SRQ has no resources in the specific time, the low 
>> level (RC qp) is responsible to send rnr to the initiator and the 
>> initiator (RC qp) will retry in the transport layer and not in the ULP.
>>
>> This is set by min_rnr_timer value that by default set to 0 (max 
>> value).For SRQ case in general, IMO better to set it to 1 (minimal 
>> value) to avoid longer latency since there is a chance that SRQ is full.
>>
>> In my testing I didn't see a real need to set the min_rnr_timer but I 
>> have patches for that in case Jason thinks that this should be part 
>> of this series that is not so small without it.
>>
>>
>>>
>>> Thanks,
>>>
>>> Bart.
