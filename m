Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB06E188E78
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 20:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgCQT7b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 15:59:31 -0400
Received: from mail-eopbgr30065.outbound.protection.outlook.com ([40.107.3.65]:61698
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726491AbgCQT7b (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Mar 2020 15:59:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlfkjbMwZCpZKvU7tO8l1SUmNUA0IsfZ8NgRyonoDWLpKwYNXhI2KmIiGv8+a0rAY2oNzL18VhFrrgH271JV9zEVArcoCKIa8mkNrsTzPbtjne9h3n1ZcbkArHbkYJcgJFKbPay5FtKda4BGxcJCUup/kCsJ8usyfTIjCoAkr/woRP8k64yy4+L8SsnzvRKPGNj0jzGd9pvy+mtn9Hf4ec6PezvvjGXHG7n01Ga0VhzFa9Me3+ZFTT8p/DaQkJJ9GI9R92AW6ktvViOxn5Wf/p6Zk5VOGqPSfncfCepxXKrftv0IHxV0cDhc1VmxPr9bDnwFPmldmNxpGUXDgzhoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=en2IT065kz052PYnTIft97VJA5+kFePoRzBHMXwp8ZM=;
 b=HwfCRyAV7upNVOVAqURwadDxzhyzQwbDda4nBjEySynASMH5Q0VHobkuK/JfetpSKhHBcuJp5cL/PaUxpKEpTLbHV0yvPFRJfcDHmQwoImCQMoHY1JmfQpFcpBqbZ9iGdU/kZx2K3u9ktwYzBbHr3ogt+QukDY/f5+ZRx4tlsyo8ArZCRuPhCGbvlKdSw2Qzf1yaVF1cB1Znv2nymCp+zHX9RdE6dczz89R/JzhEy2gr3SJGDFS+lWYrXXo1Ruwls4P5kA0pb1JD6cjT21dXDg2n/Mqzx+COMTTeFzzEqWPJ77nZP84a7JtwiymiN47JShfc8KkmQj4UfJPlMpJonA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=en2IT065kz052PYnTIft97VJA5+kFePoRzBHMXwp8ZM=;
 b=Ay1zeYcD2Rgiv5CJqHhBOhcy4gZt+i7jyh+IUvr1BeAV5fn4alh/CodRdLzYcuUKyaJNM/KqyPtQ/Qv/5WMXrLALSlBWRO81mUXzVlmMOMZaqhGFIi8mjiToaWI8+q48jePKCEKCYrqU7jOzQlOnII8tip3NYsHtTtfZ4wccYyg=
Received: from DB6PR0202CA0015.eurprd02.prod.outlook.com (2603:10a6:4:29::25)
 by HE1PR0502MB3914.eurprd05.prod.outlook.com (2603:10a6:7:87::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Tue, 17 Mar
 2020 19:59:26 +0000
Received: from DB5EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:29:cafe::54) by DB6PR0202CA0015.outlook.office365.com
 (2603:10a6:4:29::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21 via Frontend
 Transport; Tue, 17 Mar 2020 19:59:26 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT010.mail.protection.outlook.com (10.152.20.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Tue, 17 Mar 2020 19:59:25 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 17 Mar 2020 18:47:53
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 17 Mar 2020 18:47:53 +0200
Received: from [172.27.14.181] (172.27.14.181) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 17 Mar 2020 18:43:40
 +0200
Subject: Re: [PATCH 5/5] RDMA/srpt: use SRQ per completion vector
To:     Leon Romanovsky <leonro@mellanox.com>
CC:     <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
        <loberman@redhat.com>, <bvanassche@acm.org>,
        <linux-rdma@vger.kernel.org>, <kbusch@kernel.org>,
        <jgg@mellanox.com>, <dledford@redhat.com>, <idanb@mellanox.com>,
        <shlomin@mellanox.com>, <oren@mellanox.com>,
        <vladimirk@mellanox.com>
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-6-maxg@mellanox.com> <20200317135812.GH3351@unreal>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <ece3acbf-316e-cbb5-fd98-9bf8813ee682@mellanox.com>
Date:   Tue, 17 Mar 2020 18:43:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317135812.GH3351@unreal>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.27.14.181]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(199004)(46966005)(81166006)(8676002)(6636002)(81156014)(47076004)(36756003)(356004)(8936002)(70206006)(70586007)(478600001)(16576012)(54906003)(31686004)(2906002)(37006003)(316002)(16526019)(6862004)(2616005)(86362001)(53546011)(31696002)(186003)(26005)(107886003)(4326008)(336012)(5660300002)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0502MB3914;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f088fdf3-58fc-44a6-135c-08d7caadb1fa
X-MS-TrafficTypeDiagnostic: HE1PR0502MB3914:
X-Microsoft-Antispam-PRVS: <HE1PR0502MB391448E7FA730CEFB8967E81B6F60@HE1PR0502MB3914.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0345CFD558
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lhv94tkbqS3/PzTnV4TNb92tH4MDP6uWkwm651g4mw+kqKkmvM1BTJTPJniZqc3wC1zsgjxnU8DayrlQxZ6WcjrN/3bvTbPnMEY2wIg8gzPLf4z/Hy7rP4fl1sQ831rZxyvU7ClMmHbzxcsfTUjsa0KUXTWoSD06vCbz2zGhsr5GaJx4uBDhdMJPzCNvE8dLCVOMGcapA6/l8KSsYnQ43zYfHpVQN3wm2aCAdUV2EnChyNWHeUygiGChKxEMliHza2J0ZEnPvzFsSAESK59RNfGGFJBGD+YEuXEXQiOlmpFUddZrJ10cu9cIuAUj4dgU/DuAlWi3Js3cnF8fM5jitxJSMySo334jTU1vDcN6wGcsqxAzctKrHsXVOIpzUiRnTqoQK/qHP6ZCg4FJHXJJ72fkbzJ1U0g8FeqVkUaLSpZekmswl0Jwqd0vW79nkthU/JZuQPziN/vKjASQ8kI50CsiPdmhT+oTeDJyUaadMzZcCzMRDP68Snu9s/rWUdwaYJTzzIf0lMc1et3+LQiqatO9/bKS0z4gaf3h2Ab580M=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 19:59:25.8492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f088fdf3-58fc-44a6-135c-08d7caadb1fa
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB3914
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/17/2020 3:58 PM, Leon Romanovsky wrote:
> On Tue, Mar 17, 2020 at 03:40:30PM +0200, Max Gurtovoy wrote:
>> In order to save resource allocation and utilize the completion
>> locality in a better way (compared to SRQ per device that exist
>> today), allocate Shared Receive Queues (SRQs) per completion vector.
>> Associate each created channel with an appropriate SRQ according to the
>> completion vector index. This association will reduce the lock
>> contention in the fast path (compared to SRQ per device solution) and
>> increase the locality in memory buffers.
>>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>> ---
>>   drivers/infiniband/ulp/srpt/ib_srpt.c | 169 +++++++++++++++++++++++++---------
>>   drivers/infiniband/ulp/srpt/ib_srpt.h |  26 +++++-
>>   2 files changed, 148 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
>> index 9855274..34869b7 100644
>> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
>> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
>> @@ -811,6 +811,31 @@ static bool srpt_test_and_set_cmd_state(struct srpt_send_ioctx *ioctx,
>>   }
>>
>>   /**
>> + * srpt_srq_post_recv - post an initial IB receive request for SRQ
>> + * @srq: SRPT SRQ context.
>> + * @ioctx: Receive I/O context pointer.
>> + */
>> +static int srpt_srq_post_recv(struct srpt_srq *srq, struct srpt_recv_ioctx *ioctx)
>> +{
>> +	struct srpt_device *sdev = srq->sdev;
>> +	struct ib_sge list;
>> +	struct ib_recv_wr wr;
>> +
>> +	BUG_ON(!srq);
>> +	list.addr = ioctx->ioctx.dma + ioctx->ioctx.offset;
>> +	list.length = srp_max_req_size;
>> +	list.lkey = sdev->lkey;
>> +
>> +	ioctx->ioctx.cqe.done = srpt_recv_done;
>> +	wr.wr_cqe = &ioctx->ioctx.cqe;
>> +	wr.next = NULL;
>> +	wr.sg_list = &list;
>> +	wr.num_sge = 1;
>> +
>> +	return ib_post_srq_recv(srq->ibsrq, &wr, NULL);
>> +}
>> +
>> +/**
>>    * srpt_post_recv - post an IB receive request
>>    * @sdev: SRPT HCA pointer.
>>    * @ch: SRPT RDMA channel.
>> @@ -823,6 +848,7 @@ static int srpt_post_recv(struct srpt_device *sdev, struct srpt_rdma_ch *ch,
>>   	struct ib_recv_wr wr;
>>
>>   	BUG_ON(!sdev);
>> +	BUG_ON(!ch);
>>   	list.addr = ioctx->ioctx.dma + ioctx->ioctx.offset;
>>   	list.length = srp_max_req_size;
>>   	list.lkey = sdev->lkey;
>> @@ -834,7 +860,7 @@ static int srpt_post_recv(struct srpt_device *sdev, struct srpt_rdma_ch *ch,
>>   	wr.num_sge = 1;
>>
>>   	if (sdev->use_srq)
>> -		return ib_post_srq_recv(sdev->srq, &wr, NULL);
>> +		return ib_post_srq_recv(ch->srq->ibsrq, &wr, NULL);
>>   	else
>>   		return ib_post_recv(ch->qp, &wr, NULL);
>>   }
>> @@ -1820,7 +1846,8 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
>>   					SRPT_MAX_SG_PER_WQE);
>>   	qp_init->port_num = ch->sport->port;
>>   	if (sdev->use_srq) {
>> -		qp_init->srq = sdev->srq;
>> +		ch->srq = sdev->srqs[ch->cq->comp_vector % sdev->srq_count];
>> +		qp_init->srq = ch->srq->ibsrq;
>>   	} else {
>>   		qp_init->cap.max_recv_wr = ch->rq_size;
>>   		qp_init->cap.max_recv_sge = min(attrs->max_recv_sge,
>> @@ -1878,6 +1905,8 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
>>
>>   static void srpt_destroy_ch_ib(struct srpt_rdma_ch *ch)
>>   {
>> +	if (ch->srq)
>> +		ch->srq = NULL;
>>   	ib_destroy_qp(ch->qp);
>>   	ib_free_cq(ch->cq);
>>   }
>> @@ -3018,20 +3047,75 @@ static struct se_wwn *srpt_lookup_wwn(const char *name)
>>   	return wwn;
>>   }
>>
>> -static void srpt_free_srq(struct srpt_device *sdev)
>> +static void srpt_free_srq(struct srpt_srq *srq)
>>   {
>> -	if (!sdev->srq)
>> -		return;
>>
>> -	ib_destroy_srq(sdev->srq);
>> -	srpt_free_ioctx_ring((struct srpt_ioctx **)sdev->ioctx_ring, sdev,
>> -			     sdev->srq_size, sdev->req_buf_cache,
>> +	srpt_free_ioctx_ring((struct srpt_ioctx **)srq->ioctx_ring, srq->sdev,
>> +			     srq->sdev->srq_size, srq->sdev->req_buf_cache,
>>   			     DMA_FROM_DEVICE);
>> +	rdma_srq_put(srq->sdev->pd, srq->ibsrq);
>> +	kfree(srq);
>> +
>> +}
>> +
>> +static void srpt_free_srqs(struct srpt_device *sdev)
>> +{
>> +	int i;
>> +
>> +	if (!sdev->srqs)
>> +		return;
>> +
>> +	for (i = 0; i < sdev->srq_count; i++)
>> +		srpt_free_srq(sdev->srqs[i]);
>>   	kmem_cache_destroy(sdev->req_buf_cache);
>> -	sdev->srq = NULL;
>> +	rdma_srq_set_destroy(sdev->pd);
>> +	kfree(sdev->srqs);
>> +	sdev->srqs = NULL;
>>   }
>>
>> -static int srpt_alloc_srq(struct srpt_device *sdev)
>> +static struct srpt_srq *srpt_alloc_srq(struct srpt_device *sdev)
>> +{
>> +	struct srpt_srq	*srq;
>> +	int i, ret;
>> +
>> +	srq = kzalloc(sizeof(*srq), GFP_KERNEL);
>> +	if (!srq) {
>> +		pr_debug("failed to allocate SRQ context\n");
> Please no to kzalloc prints and no to pr_* prints.

Sure no problem.

I'll remove the above print.


>
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>> +	srq->ibsrq = rdma_srq_get(sdev->pd);
>> +	if (!srq) {
> !srq->ibsrq ????

Yup good catch.


>
>> +		ret = -EAGAIN;
>> +		goto free_srq;
>> +	}
> Thanks
