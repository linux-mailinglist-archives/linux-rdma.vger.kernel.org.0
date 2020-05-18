Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855AA1D7970
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2020 15:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgERNQQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 May 2020 09:16:16 -0400
Received: from mail-eopbgr30065.outbound.protection.outlook.com ([40.107.3.65]:7707
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726726AbgERNQP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 May 2020 09:16:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ff2slYRHSuKFnL3x3KlVVFcRjQzSrxF1//7LBwV6koTBU9mMKPMK58AFlI7GtIVMjuo3gWhwTZBS1MXJKtEpS32Uj6IIwy9s1DTlkaib0LD0vDq3UkkdUymODKEZe+EZAfQ9ocdSTjor9ASErD7tIvNuPlL41pqhWmE/tubhhP6oZzTs6zJnzl3peYR8dBrbfEWNRG+owE7Rb1E6HZq+1GwXlA2WBOapZMKPhbQ1a83kQqkKuduX8NK8Gh1SoGaJ22AlHiM6Ce2KV0d35NGlk+F4ro46hwrjf+nervB7kuoio+KbBtX/7u3Bfs93gZkY11FAbcDHBJsLMa8gDVLIlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYlz56rGICChP0hCHtu5ordwHOMSETpVTyoJ1ziritM=;
 b=PpOq7K55YsqDIJp8U5q7zU/lAH/azEoS0IyDDWszE6devIiTh2jLdaBdmLMSRZ4SvX2gw5ts01n448udS3by1yXJLNEmuvyCcuYif0C4Enj8i1JPGojtJuAifV1e7CP2NNLsgXtEzzNHXVYLtN5S9co9N8HO/JZgQbvcMExofjOUMbfHmk4JAAl01xvlhyIpiWiqvJMiw/CvYLkDKJ6B6tZ9U2UGSGWTbPB0h4anunP9O8C4x5ikRoA2iOJkExBw9yuojtg3uc1hki0eJngKs0TAO30vxZ6bSMemT2EstBF5NkiIKtyAzPepPx77872qbdESiiTDm7/w4e1H1GsI1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYlz56rGICChP0hCHtu5ordwHOMSETpVTyoJ1ziritM=;
 b=X+TkFNc3q4q+oMiEhOHDw/4zuHTrUlGV8UKDJhDtECQtBvS6ydzw6LPf/tFWPPpDazxf4q8zzysPmRjKM5DMWROWiX1jmm6ZYCZXXA317/peIr+p5zzU9W34pgy+TN+t1ym3bOtYJ20vGHdyw697hqU/p89hkwyFvu+imrqLSFA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com (2603:10a6:8:9::11)
 by DB3PR0502MB4011.eurprd05.prod.outlook.com (2603:10a6:8:9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Mon, 18 May
 2020 13:16:09 +0000
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1]) by DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1%6]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 13:16:09 +0000
Subject: Re: [PATCH V2 2/4] RDMA/core: Introduce shared CQ pool API
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Or Gerlitz <ogerlitz@mellanox.com>, linux-rdma@vger.kernel.org
References: <1589370763-81205-1-git-send-email-yaminf@mellanox.com>
 <1589370763-81205-3-git-send-email-yaminf@mellanox.com>
 <20200518083032.GB185893@unreal>
From:   Yamin Friedman <yaminf@mellanox.com>
Message-ID: <a6281ce2-71e1-db0f-1038-8aa0db0aa6be@mellanox.com>
Date:   Mon, 18 May 2020 16:16:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <20200518083032.GB185893@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::17) To DB3PR0502MB4011.eurprd05.prod.outlook.com
 (2603:10a6:8:9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.102.13] (93.172.45.15) by AM0PR10CA0037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Mon, 18 May 2020 13:16:08 +0000
X-Originating-IP: [93.172.45.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e1f5a450-ff06-4811-61e6-08d7fb2da142
X-MS-TrafficTypeDiagnostic: DB3PR0502MB4011:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0502MB4011F2D09820B737FF7EA473B1B80@DB3PR0502MB4011.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qJI1QR75xLjTfGMixwhbIR7cl6+/wrJX1+0LAdF+7k/+OWsxbshCT3BN1eFnb4x/j3+Zd9MBY4tA/KibvUtWzWfi5h2sN1Eqgkye8FTc78pGuHbaN0UQ5ntd9f37HbP/7m45CsHCIc8Rsq+8+3lcrh4Nnk8YXktSl4Pv/Q2E5nQu8X3HmP7A0V/1mAgZIJooLOF3b4Svs8/Dg/h8Jhac5vBF/9hOLYlbycS1YXbXowPtKvwUXa+DnYwocuMt6Uym1zgjWHF8Cj6y7A40T1mpVqL+Cuo8dgn5HvoKyERHdB/3vru7+CHqo/D6XTRXIUNcv31RilAbMihS53/dzxoVI4Ni8mOivLgbxbG/p6Ta+TsaST3F0Cw0CTo0esoOj045U2RzG55p5iZYxolzKr+3mXjU3DH9w6bSclKKN7shL9+YvPb5jj0HblJWs7oSyj/CISRLoD2XjQi5pI6DYU7MOoo6/pJYoGNVw818//xOAP1M8GJdBr1l2R8jtPAUbyOu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0502MB4011.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(6486002)(66946007)(66556008)(66476007)(8936002)(36756003)(2906002)(8676002)(31696002)(86362001)(31686004)(478600001)(4326008)(6636002)(54906003)(6862004)(37006003)(16576012)(30864003)(53546011)(316002)(186003)(16526019)(956004)(6666004)(52116002)(2616005)(26005)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: UbopqubxP9Ulj6ua7khxRzcqQBbOg0fOa9vpdGVXnAoCZys0XiUVI2YDJvPIJo4D/WlIoK3oz//dNAIZUz0+zFxTB/4SQi8NMZPF7mf4BG8G+unI9KLnQyLrOMDte+jPjj8GGfLbih2vux3B2GHa0mhNAsZgxdtWN4tKoj9cH4MJqho1moLUk3yZHjqeu0ihA3ZNrHcieisjBlcXHhLADkgHYY2QwnR0UYMBPunuVLDdSvpfcD1EICspLnKiTxdo8jKZYK+c34B1p4LSWKe06D6l36cvCsTVpd7v8cm6BONI0Uu8VrIOWyvvUt7ZdqKcvCHHkL0bTJznUoxPkLbqhnO0oxSmkSMWjHU420ZscMAcHuqNut4wU0vbN1O3/7Zct5mOZYNiWAs6bt5nZisE/tRa0rh8z2akF/upfWyQThbEesyoezAJ8y+CyGoJsg4rFLSfvczKlMiRsG44RiE0/edmjHPMUDLiivvTxvuYJAk=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f5a450-ff06-4811-61e6-08d7fb2da142
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 13:16:09.5315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpGTkdraYbNTWCy71jfI/gEJBFSUe4UVAAnjkHIoAIe2cKsmavPlkobX8P6Efr9fJrGsg2xMLN3dg4mHwjXCXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0502MB4011
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/18/2020 11:30 AM, Leon Romanovsky wrote:
> On Wed, May 13, 2020 at 02:52:41PM +0300, Yamin Friedman wrote:
>> Allow a ULP to ask the core to provide a completion queue based on a
>> least-used search on a per-device CQ pools. The device CQ pools grow in a
>> lazy fashion when more CQs are requested.
>>
>> This feature reduces the amount of interrupts when using many QPs.
>> Using shared CQs allows for more effcient completion handling. It also
>> reduces the amount of overhead needed for CQ contexts.
>>
>> Test setup:
>> Intel(R) Xeon(R) Platinum 8176M CPU @ 2.10GHz servers.
>> Running NVMeoF 4KB read IOs over ConnectX-5EX across Spectrum switch.
>> TX-depth = 32. The patch was applied in the nvme driver on both the target
>> and initiator. Four controllers are accessed from each core. In the
>> current test case we have exposed sixteen NVMe namespaces using four
>> different subsystems (four namespaces per subsystem) from one NVM port.
>> Each controller allocated X queues (RDMA QPs) and attached to Y CQs.
>> Before this series we had X == Y, i.e for four controllers we've created
>> total of 4X QPs and 4X CQs. In the shared case, we've created 4X QPs and
>> only X CQs which means that we have four controllers that share a
>> completion queue per core. Until fourteen cores there is no significant
>> change in performance and the number of interrupts per second is less than
>> a million in the current case.
>> ==================================================
>> |Cores|Current KIOPs  |Shared KIOPs  |improvement|
>> |-----|---------------|--------------|-----------|
>> |14   |2332           |2723          |16.7%      |
>> |-----|---------------|--------------|-----------|
>> |20   |2086           |2712          |30%        |
>> |-----|---------------|--------------|-----------|
>> |28   |1971           |2669          |35.4%      |
>> |=================================================
>> |Cores|Current avg lat|Shared avg lat|improvement|
>> |-----|---------------|--------------|-----------|
>> |14   |767us          |657us         |14.3%      |
>> |-----|---------------|--------------|-----------|
>> |20   |1225us         |943us         |23%        |
>> |-----|---------------|--------------|-----------|
>> |28   |1816us         |1341us        |26.1%      |
>> ========================================================
>> |Cores|Current interrupts|Shared interrupts|improvement|
>> |-----|------------------|-----------------|-----------|
>> |14   |1.6M/sec          |0.4M/sec         |72%        |
>> |-----|------------------|-----------------|-----------|
>> |20   |2.8M/sec          |0.6M/sec         |72.4%      |
>> |-----|------------------|-----------------|-----------|
>> |28   |2.9M/sec          |0.8M/sec         |63.4%      |
>> ====================================================================
>> |Cores|Current 99.99th PCTL lat|Shared 99.99th PCTL lat|improvement|
>> |-----|------------------------|-----------------------|-----------|
>> |14   |67ms                    |6ms                    |90.9%      |
>> |-----|------------------------|-----------------------|-----------|
>> |20   |5ms                     |6ms                    |-10%       |
>> |-----|------------------------|-----------------------|-----------|
>> |28   |8.7ms                   |6ms                    |25.9%      |
>> |===================================================================
>>
>> Performance improvement with sixteen disks (sixteen CQs per core) is
>> comparable.
>>
>> Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
>> Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
>> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
>> ---
>>   drivers/infiniband/core/core_priv.h |   4 ++
>>   drivers/infiniband/core/cq.c        | 137 ++++++++++++++++++++++++++++++++++++
>>   drivers/infiniband/core/device.c    |   2 +
>>   include/rdma/ib_verbs.h             |  35 +++++++++
>>   4 files changed, 178 insertions(+)
>>
>> diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
>> index cf42acc..fa3151b 100644
>> --- a/drivers/infiniband/core/core_priv.h
>> +++ b/drivers/infiniband/core/core_priv.h
>> @@ -414,4 +414,8 @@ void rdma_umap_priv_init(struct rdma_umap_priv *priv,
>>   			 struct vm_area_struct *vma,
>>   			 struct rdma_user_mmap_entry *entry);
>>
>> +void ib_cq_pool_init(struct ib_device *dev);
>> +
>> +void ib_cq_pool_destroy(struct ib_device *dev);
>> +
>>   #endif /* _CORE_PRIV_H */
>> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
>> index 04046eb..5319c14 100644
>> --- a/drivers/infiniband/core/cq.c
>> +++ b/drivers/infiniband/core/cq.c
>> @@ -7,7 +7,11 @@
>>   #include <linux/slab.h>
>>   #include <rdma/ib_verbs.h>
>>
>> +#include "core_priv.h"
>> +
>>   #include <trace/events/rdma_core.h>
>> +/* Max size for shared CQ, may require tuning */
>> +#define IB_MAX_SHARED_CQ_SZ		4096
>>
>>   /* # of WCs to poll for with a single call to ib_poll_cq */
>>   #define IB_POLL_BATCH			16
>> @@ -218,6 +222,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
>>   	cq->cq_context = private;
>>   	cq->poll_ctx = poll_ctx;
>>   	atomic_set(&cq->usecnt, 0);
>> +	cq->comp_vector = comp_vector;
>>
>>   	cq->wc = kmalloc_array(IB_POLL_BATCH, sizeof(*cq->wc), GFP_KERNEL);
>>   	if (!cq->wc)
>> @@ -304,6 +309,8 @@ static void _ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>>   {
>>   	if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
>>   		return;
>> +	if (WARN_ON_ONCE(cq->cqe_used != 0))
> Let's do WARN_ON_ONCE(cq->cqe_used)
>
>> +		return;
>>
>>   	switch (cq->poll_ctx) {
>>   	case IB_POLL_DIRECT:
>> @@ -340,3 +347,133 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>>   		_ib_free_cq_user(cq, udata);
>>   }
>>   EXPORT_SYMBOL(ib_free_cq_user);
>> +
>> +void ib_cq_pool_init(struct ib_device *dev)
>> +{
>> +	int i;
>> +
>> +	spin_lock_init(&dev->cq_pools_lock);
>> +	for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++)
>> +		INIT_LIST_HEAD(&dev->cq_pools[i]);
>> +}
>> +
>> +void ib_cq_pool_destroy(struct ib_device *dev)
>> +{
>> +	struct ib_cq *cq, *n;
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++) {
>> +		list_for_each_entry_safe(cq, n, &dev->cq_pools[i], pool_entry)
>> +			_ib_free_cq_user(cq, NULL);
>> +	}
>> +
>> +}
>> +
>> +static int ib_alloc_cqs(struct ib_device *dev, int nr_cqes,
>> +			enum ib_poll_context poll_ctx)
>> +{
>> +	LIST_HEAD(tmp_list);
>> +	struct ib_cq *cq;
>> +	unsigned long flags;
>> +	int nr_cqs, ret, i;
>> +
>> +	/*
>> +	 * Allocated at least as many CQEs as requested, and otherwise
>> +	 * a reasonable batch size so that we can share CQs between
>> +	 * multiple users instead of allocating a larger number of CQs.
>> +	 */
>> +	nr_cqes = min(dev->attrs.max_cqe, max(nr_cqes, IB_MAX_SHARED_CQ_SZ));
>> +	nr_cqs = min_t(int, dev->num_comp_vectors, num_online_cpus());
>> +	for (i = 0; i < nr_cqs; i++) {
>> +		cq = ib_alloc_cq(dev, NULL, nr_cqes, i, poll_ctx);
>> +		if (IS_ERR(cq)) {
>> +			ret = PTR_ERR(cq);
>> +			goto out_free_cqs;
>> +		}
>> +		cq->shared = true;
>> +		list_add_tail(&cq->pool_entry, &tmp_list);
>> +	}
>> +
>> +	spin_lock_irqsave(&dev->cq_pools_lock, flags);
>> +	list_splice(&tmp_list, &dev->cq_pools[poll_ctx - 1]);
>> +	spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
>> +
>> +	return 0;
>> +
>> +out_free_cqs:
>> +	list_for_each_entry(cq, &tmp_list, pool_entry)
>> +		ib_free_cq(cq);
>> +	return ret;
>> +}
>> +
>> +struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int nr_cqe,
>> +			     int comp_vector_hint,
>> +			     enum ib_poll_context poll_ctx)
>> +{
>> +	static unsigned int default_comp_vector;
>> +	int vector, ret, num_comp_vectors;
>> +	struct ib_cq *cq, *found = NULL;
>> +	unsigned long flags;
>> +
>> +	if (poll_ctx > ARRAY_SIZE(dev->cq_pools) || poll_ctx == IB_POLL_DIRECT)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	num_comp_vectors = min_t(int, dev->num_comp_vectors,
>> +				 num_online_cpus());
>> +	/* Project the affinty to the device completion vector range */
>> +	if (comp_vector_hint < 0)
>> +		vector = default_comp_vector++ % num_comp_vectors;
>> +	else
>> +		vector = comp_vector_hint % num_comp_vectors;
>> +
>> +	/*
>> +	 * Find the least used CQ with correct affinity and
>> +	 * enough free CQ entries
>> +	 */
>> +	while (!found) {
>> +		spin_lock_irqsave(&dev->cq_pools_lock, flags);
>> +		list_for_each_entry(cq, &dev->cq_pools[poll_ctx - 1],
>> +				    pool_entry) {
>> +			if (vector != cq->comp_vector)
> I think that this check worth to have a comment.
> At least for me, it is not clear if it will work correctly if
> comp_vector == 0.
>
>> +				continue;
>> +			if (cq->cqe_used + nr_cqe > cq->cqe)
>> +				continue;
>> +			if (found && cq->cqe_used >= found->cqe_used)
>> +				continue;
>> +			found = cq;
>> +			break;
>> +		}
>> +
>> +		if (found) {
>> +			found->cqe_used += nr_cqe;
>> +			spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
>> +
>> +			return found;
>> +		}
>> +		spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
>> +
>> +		/*
>> +		 * Didn't find a match or ran out of CQs in the device
>> +		 * pool, allocate a new array of CQs.
>> +		 */
>> +		ret = ib_alloc_cqs(dev, nr_cqe, poll_ctx);
>> +		if (ret)
>> +			return ERR_PTR(ret);
>> +	}
>> +
>> +	return found;
>> +}
>> +EXPORT_SYMBOL(ib_cq_pool_get);
>> +
>> +void ib_cq_pool_put(struct ib_cq *cq, unsigned int nr_cqe)
>> +{
>> +	unsigned long flags;
>> +
>> +	if (nr_cqe > cq->cqe_used)
>> +		return;
> Is it possible?
> 1. It is racy
> 2. It is a bug in the ib_cq_pool_put() caller.

It is possible, the pool doesn't save the amount of cqes used per user.

I think to make it really secure I would have to never reduce the cqes 
used, save the number of active users, and have some form of garbage 
collection for used up CQs but that seems to me a lot for something that 
should not occur during proper use.

Would it be better to just have a WARN for this case?

>
>> +
>> +	spin_lock_irqsave(&cq->device->cq_pools_lock, flags);
>> +	cq->cqe_used -= nr_cqe;
>> +	spin_unlock_irqrestore(&cq->device->cq_pools_lock, flags);
>> +}
>> +EXPORT_SYMBOL(ib_cq_pool_put);
>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
>> index d9f565a..abd7cd0 100644
>> --- a/drivers/infiniband/core/device.c
>> +++ b/drivers/infiniband/core/device.c
>> @@ -600,6 +600,7 @@ struct ib_device *_ib_alloc_device(size_t size)
>>   	mutex_init(&device->compat_devs_mutex);
>>   	init_completion(&device->unreg_completion);
>>   	INIT_WORK(&device->unregistration_work, ib_unregister_work);
>> +	ib_cq_pool_init(device);
> Why did you add this function in _ib_alloc_device() and not
> to the ib_register_device()?
I will move it to the register device.
>
>>   	return device;
>>   }
>> @@ -1455,6 +1456,7 @@ static void __ib_unregister_device(struct ib_device *ib_dev)
>>   	device_del(&ib_dev->dev);
>>   	ib_device_unregister_rdmacg(ib_dev);
>>   	ib_cache_cleanup_one(ib_dev);
>> +	ib_cq_pool_destroy(ib_dev);
> It is not symmetric to the registration flow.
>
>>   	/*
>>   	 * Drivers using the new flow may not call ib_dealloc_device except
>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>> index b79737b..0ca6617 100644
>> --- a/include/rdma/ib_verbs.h
>> +++ b/include/rdma/ib_verbs.h
>> @@ -1555,6 +1555,7 @@ enum ib_poll_context {
>>   	IB_POLL_SOFTIRQ,	   /* poll from softirq context */
>>   	IB_POLL_WORKQUEUE,	   /* poll from workqueue */
>>   	IB_POLL_UNBOUND_WORKQUEUE, /* poll from unbound workqueue */
>> +	IB_POLL_LAST,
>>   };
>>
>>   struct ib_cq {
>> @@ -1564,9 +1565,12 @@ struct ib_cq {
>>   	void                  (*event_handler)(struct ib_event *, void *);
>>   	void                   *cq_context;
>>   	int               	cqe;
>> +	int			cqe_used;
>>   	atomic_t          	usecnt; /* count number of work queues */
>>   	enum ib_poll_context	poll_ctx;
>> +	int                     comp_vector;
>>   	struct ib_wc		*wc;
>> +	struct list_head        pool_entry;
>>   	union {
>>   		struct irq_poll		iop;
>>   		struct work_struct	work;
>> @@ -2695,6 +2699,10 @@ struct ib_device {
>>   #endif
>>
>>   	u32                          index;
>> +
>> +	spinlock_t                   cq_pools_lock;
>> +	struct list_head             cq_pools[IB_POLL_LAST - 1];
>> +
>>   	struct rdma_restrack_root *res;
>>
>>   	const struct uapi_definition   *driver_def;
>> @@ -3957,6 +3965,33 @@ static inline int ib_req_notify_cq(struct ib_cq *cq,
>>   	return cq->device->ops.req_notify_cq(cq, flags);
>>   }
>>
>> +/*
>> + * ib_cq_pool_get() - Find the least used completion queue that matches
>> + *     a given cpu hint (or least used for wild card affinity)
>> + *     and fits nr_cqe
>> + * @dev: rdma device
>> + * @nr_cqe: number of needed cqe entries
>> + * @comp_vector_hint: completion vector hint (-1) for the driver to assign
>> + *   a comp vector based on internal counter
>> + * @poll_ctx: cq polling context
>> + *
>> + * Finds a cq that satisfies @comp_vector_hint and @nr_cqe requirements and
>> + * claim entries in it for us. In case there is no available cq, allocate
>> + * a new cq with the requirements and add it to the device pool.
>> + * IB_POLL_DIRECT cannot be used for shared cqs so it is not a valid value
>> + * for @poll_ctx.
>> + */
>> +struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int nr_cqe,
>> +			     int comp_vector_hint,
>> +			     enum ib_poll_context poll_ctx);
>> +
>> +/**
>> + * ib_cq_pool_put - Return a CQ taken from a shared pool.
>> + * @cq: The CQ to return.
>> + * @nr_cqe: The max number of cqes that the user had requested.
>> + */
>> +void ib_cq_pool_put(struct ib_cq *cq, unsigned int nr_cqe);
>> +
>>   /**
>>    * ib_req_ncomp_notif - Request completion notification when there are
>>    *   at least the specified number of unreaped completions on the CQ.
>> --
>> 1.8.3.1
>>
