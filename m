Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBE41CED7D
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 09:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgELHDq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 03:03:46 -0400
Received: from mail-db8eur05on2080.outbound.protection.outlook.com ([40.107.20.80]:35361
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725813AbgELHDp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 03:03:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHYGWcyRS/BKtmHZSR8zevYKxH938xmLHkbBHsYtDowveKWHiqrn68SITyWkL0M3SESGJLFRE3HQwE91PYH096n9xtJb+XoKVm6EILng4Rx0/gXG93k2jfV8q4cPYqZ1QsWesKWp44rrzSGKgTjpxOjli3pVCPnXrAImVBq7Q5JXIijSft2HCE+ONT3rzQYFlTD2daCcFQKFALgbMWY4jJq9HhKUJnyE6yZNuxCkfXCd83/AuFLL16vkOE1/7kV0brKkjsUKS4VMPVPhxToM2uj7LNOHkGXv+4qGN5SfNGo1GJYULDg/yyZE+txMrwhaRkr8iGJDH7+mrZ2ZQ7OrRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBiycn+DYvcGCE1Xoh9FHa68bRzxsSNLW6sy8ZJNb8c=;
 b=aTFENol1MlhjJmCk11EfB50dSwNmNErAg1iifFLFrWpkj4y7q/WrmDrHgCetxFRJX9p5QH293FKUerkWjR75GxO1Z2ernuDSFaErfg1hheSyxS+RkZSfYk8EbTozaD1CqAm06WDtopuLQkatBKOWX2iUQ8nl0zEi/yn0QbAwrgeAEONkBjZmJgshXSUQ7FBhYD5cfwGHXijuB71x2XtSpvh0oq4v29JAZ7DP3pkvNcfQG52M6x1gM6NAgYbW1cQ90OwHmksBnNUIMyADA0Rh2V6hI4zq3/AFTllPNVrZA/uiRVMFNWrps4s17xIYOHHHaZRhLJsYKI3QcLMRSIRw7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBiycn+DYvcGCE1Xoh9FHa68bRzxsSNLW6sy8ZJNb8c=;
 b=hYfAV00lHankqzdalX3n987MWbp7aHSwIZwSAOCStvyrh0oVhqvO/p1Lxbq1PIpqDmK5JzRLa/V+NnAJmJAg4M74znXq7L9aeo4Y3GfD/ckaZRbAd9BtDH+KuFoOQjxaqWNdRKmXNyBaIia86sxQvtSMen7PT8XMiWKNPtJTupo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com (2603:10a6:8:9::11)
 by DB3PR0502MB4012.eurprd05.prod.outlook.com (2603:10a6:8:8::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 07:01:04 +0000
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1]) by DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1%6]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 07:01:04 +0000
Subject: Re: [PATCH 2/4] RDMA/core: Introduce shared CQ pool API
From:   Yamin Friedman <yaminf@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org
References: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
 <1589122557-88996-3-git-send-email-yaminf@mellanox.com>
 <20200511050740.GB356445@unreal>
 <345890f8-52d6-1aef-dd63-b3115384def5@mellanox.com>
Message-ID: <eada151f-b763-f300-fb60-8b38c9a7be2d@mellanox.com>
Date:   Tue, 12 May 2020 10:00:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <345890f8-52d6-1aef-dd63-b3115384def5@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR03CA0008.eurprd03.prod.outlook.com
 (2603:10a6:208:14::21) To DB3PR0502MB4011.eurprd05.prod.outlook.com
 (2603:10a6:8:9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.102.13] (93.172.45.15) by AM0PR03CA0008.eurprd03.prod.outlook.com (2603:10a6:208:14::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend Transport; Tue, 12 May 2020 07:01:02 +0000
X-Originating-IP: [93.172.45.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a856b1df-dc37-4500-3c1d-08d7f6423c79
X-MS-TrafficTypeDiagnostic: DB3PR0502MB4012:|DB3PR0502MB4012:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0502MB4012D8584F168DB1D01814FCB1BE0@DB3PR0502MB4012.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9uLAtsoqDaJg3j2/lxSw/y2l/pCauJXvu73yWxh6lGxgMBPYGeYoU6vIKL1O7YVbLasz64ErLhRqCju1bfolbYF9/C98Cpv7Jpj8/NIkkoR1OWg3n3SE2ga5KBw8VjhmSNfgB7FS+yk0vTpWhNJNEUJd5u/mSJSRO8I9PKmPPAwUkoF+jNOZUKL81aZNEigzIAhfGnnd489UvpMndmHT3KWti8zlQjVW1S01cd3t0yvUUZntKMZsd9XmGQEA8pWv2Gvs+qnd3ZIyTkfzUKYf2PUitA4J6k5oLfHhLXwDmBu2kxk/sCx9aVoBAZct673tIcnkQ6zk5P+DIdyJwysict3AeA0aL20sKvNYqHt/Hc5PJovbZJVOTi4UzguMXM1ySfuw7eKWcMMO75RjsGXwZMBGMYKBZsUDZVIQsxHM4m5GjBat+iIKZ8mW7rfx5fwvMUn/wGshiyePQL90TLTT5N148V+TuXGnZqzS1482vLDqqgApISGANxgJGeoO6K4oWYsUARaJ3d/rQ6NdaTGlqUD5nYBhtRo3xnV9MDk/tWiBDTpcu3Gi7VCd9nU9Gfv6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0502MB4011.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(33430700001)(5660300002)(956004)(36756003)(4326008)(2616005)(66946007)(66476007)(66556008)(8936002)(26005)(8676002)(16526019)(30864003)(186003)(54906003)(52116002)(2906002)(478600001)(53546011)(86362001)(6666004)(316002)(31696002)(31686004)(6916009)(33440700001)(6486002)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Ag56/V85JxxGMeWfIpur+knwwZxkZA7K0TEUXQPS3MUilfsWQCy1OF6lwZEYb5GkZPZjJPS5lTjQ+E/LG+tpIN8zrwUZ4bIR5aF9z6l/ySBHNhHyw/hVRUppGGzmYh+AdxDF6QbereG0WzB/CufGvAxYITjoTE59v5cxinPLO6dVRbTaavB0TNSBkzWPC1xZN4U3nz/u8EcP3j2fOCYDIhU0Jyu9j5MmJiBZCO3WXBc4+IPfsi3G7m3NJdb8VrqLHqmsfmS5TF9E9yJwwWTfFHIYzeBXMGMx0cgkWqVK3poZbMe4kK25ONkHzgEuhfnY5VzdA0yj4K5Ba3+jxsKUIUqvFDSPgWoCziItWQl7r3VGZdsK1u7a2e8eRHvrQHnlpEC0aAVKpkVHuMzprf0BoZvWQwq9/PmcKjzbKHwiaYySVD0JQMCth50TH17uXKfr8s5UXTNHHGRCAUouyJIYeP6BbWC31DqeA0yfwaF+wNU=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a856b1df-dc37-4500-3c1d-08d7f6423c79
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 07:01:04.1056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiadgtSMYvnyWx7tvY8AWpaZSPp66uMusAhQpl5YuuYvhGR126s39aB+iE8iv3mJHq+3bm+BrSuf/TmzPPPONA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0502MB4012
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/11/2020 3:08 PM, Yamin Friedman wrote:
>
> On 5/11/2020 8:07 AM, Leon Romanovsky wrote:
>> On Sun, May 10, 2020 at 05:55:55PM +0300, Yamin Friedman wrote:
>>> Allow a ULP to ask the core to provide a completion queue based on a
>>> least-used search on a per-device CQ pools. The device CQ pools grow 
>>> in a
>>> lazy fashion when more CQs are requested.
>>>
>>> This feature reduces the amount of interrupts when using many QPs.
>>> Using shared CQs allows for more effcient completion handling. It also
>>> reduces the amount of overhead needed for CQ contexts.
>>>
>>> Test setup:
>>> Intel(R) Xeon(R) Platinum 8176M CPU @ 2.10GHz servers.
>>> Running NVMeoF 4KB read IOs over ConnectX-5EX across Spectrum switch.
>>> TX-depth = 32. Number of cores refers to the initiator side. Four 
>>> disks are
>>> accessed from each core. In the current case we have four CQs per 
>>> core and
>>> in the shared case we have a single CQ per core. Until 14 cores 
>>> there is no
>>> significant change in performance and the number of interrupts per 
>>> second
>>> is less than a million in the current case.
>>> ==================================================
>>> |Cores|Current KIOPs  |Shared KIOPs  |improvement|
>>> |-----|---------------|--------------|-----------|
>>> |14   |2188           |2620          |19.7%      |
>>> |-----|---------------|--------------|-----------|
>>> |20   |2063           |2308          |11.8%      |
>>> |-----|---------------|--------------|-----------|
>>> |28   |1933           |2235          |15.6%      |
>>> |=================================================
>>> |Cores|Current avg lat|Shared avg lat|improvement|
>>> |-----|---------------|--------------|-----------|
>>> |14   |817us          |683us         |16.4%      |
>>> |-----|---------------|--------------|-----------|
>>> |20   |1239us         |1108us        |10.6%      |
>>> |-----|---------------|--------------|-----------|
>>> |28   |1852us         |1601us        |13.5%      |
>>> ========================================================
>>> |Cores|Current interrupts|Shared interrupts|improvement|
>>> |-----|------------------|-----------------|-----------|
>>> |14   |2131K/sec         |425K/sec         |80%        |
>>> |-----|------------------|-----------------|-----------|
>>> |20   |2267K/sec         |594K/sec         |73.8%      |
>>> |-----|------------------|-----------------|-----------|
>>> |28   |2370K/sec         |1057K/sec        |55.3%      |
>>> ====================================================================
>>> |Cores|Current 99.99th PCTL lat|Shared 99.99th PCTL lat|improvement|
>>> |-----|------------------------|-----------------------|-----------|
>>> |14   |85Kus                   |9Kus |88%        |
>>> |-----|------------------------|-----------------------|-----------|
>>> |20   |6Kus                    |5.3Kus |14.6%      |
>>> |-----|------------------------|-----------------------|-----------|
>>> |28   |11.6Kus                 |9.5Kus |18%        |
>>> |===================================================================
>>>
>>> Performance improvement with 16 disks (16 CQs per core) is comparable.
>>>
>>> Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
>>> Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
>>> ---
>>>   drivers/infiniband/core/core_priv.h |   8 ++
>>>   drivers/infiniband/core/cq.c        | 145 
>>> ++++++++++++++++++++++++++++++++++++
>>>   drivers/infiniband/core/device.c    |   3 +-
>>>   include/rdma/ib_verbs.h             |  32 ++++++++
>>>   4 files changed, 187 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/infiniband/core/core_priv.h 
>>> b/drivers/infiniband/core/core_priv.h
>>> index cf42acc..7fe9c13 100644
>>> --- a/drivers/infiniband/core/core_priv.h
>>> +++ b/drivers/infiniband/core/core_priv.h
>>> @@ -191,6 +191,14 @@ static inline bool rdma_is_upper_dev_rcu(struct 
>>> net_device *dev,
>>>       return netdev_has_upper_dev_all_rcu(dev, upper);
>>>   }
>>>
>>> +struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int 
>>> nr_cqe,
>>> +                 int cpu_hint, enum ib_poll_context poll_ctx);
>>> +void ib_cq_pool_put(struct ib_cq *cq, unsigned int nr_cqe);
>>> +
>>> +void ib_init_cq_pools(struct ib_device *dev);
>>> +
>>> +void ib_purge_cq_pools(struct ib_device *dev);
>> I don't know how next patches compile to you, but "core_priv.h" is wrong
>> place to put function declarations. You also put them here and in 
>> ib_verbs.h
>> below.
>>
>> Also, it will be nice if you will use same naming convention like in 
>> mr_pool.h
> I will remove the use of core_priv and look into refactoring the names.
Init_cq_pools and purge_cq_pools are not exported functions they are for 
internal core use, is ib_verbs really the place for them?
>>
>>> +
>>>   int addr_init(void);
>>>   void addr_cleanup(void);
>>>
>>> diff --git a/drivers/infiniband/core/cq.c 
>>> b/drivers/infiniband/core/cq.c
>>> index 443a9cd..a86e893 100644
>>> --- a/drivers/infiniband/core/cq.c
>>> +++ b/drivers/infiniband/core/cq.c
>>> @@ -6,8 +6,11 @@
>>>   #include <linux/err.h>
>>>   #include <linux/slab.h>
>>>   #include <rdma/ib_verbs.h>
>>> +#include "core_priv.h"
>> It is wrong header.
> See above.
>>
>>>   #include <trace/events/rdma_core.h>
>>> +/* Max size for shared CQ, may require tuning */
>>> +#define IB_MAX_SHARED_CQ_SZ        4096
>>>
>>>   /* # of WCs to poll for with a single call to ib_poll_cq */
>>>   #define IB_POLL_BATCH            16
>>> @@ -223,6 +226,8 @@ struct ib_cq *__ib_alloc_cq_user(struct 
>>> ib_device *dev, void *private,
>>>       cq->poll_ctx = poll_ctx;
>>>       atomic_set(&cq->usecnt, 0);
>>>       cq->cq_type = IB_CQ_PRIVATE;
>>> +    cq->cqe_used = 0;
>> It is already default.
>>
>>> +    cq->comp_vector = comp_vector;
>>>
>>>       cq->wc = kmalloc_array(IB_POLL_BATCH, sizeof(*cq->wc), 
>>> GFP_KERNEL);
>>>       if (!cq->wc)
>>> @@ -309,6 +314,8 @@ static void _ib_free_cq_user(struct ib_cq *cq, 
>>> struct ib_udata *udata)
>>>   {
>>>       if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
>>>           return;
>>> +    if (WARN_ON_ONCE(cq->cqe_used != 0))
>>> +        return;
>>>
>>>       switch (cq->poll_ctx) {
>>>       case IB_POLL_DIRECT:
>>> @@ -345,3 +352,141 @@ void ib_free_cq_user(struct ib_cq *cq, struct 
>>> ib_udata *udata)
>>>           _ib_free_cq_user(cq, udata);
>>>   }
>>>   EXPORT_SYMBOL(ib_free_cq_user);
>>> +
>>> +static void ib_free_cq_force(struct ib_cq *cq)
>>> +{
>>> +    _ib_free_cq_user(cq, NULL);
>>> +}
>> This static one liner is better to not exist, call directly.
> Understood.
>>
>>> +
>>> +void ib_init_cq_pools(struct ib_device *dev)
>>> +{
>>> +    int i;
>>> +
>>> +    spin_lock_init(&dev->cq_pools_lock);
>>> +    for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++)
>>> +        INIT_LIST_HEAD(&dev->cq_pools[i]);
>>> +}
>>> +
>>> +void ib_purge_cq_pools(struct ib_device *dev)
>>> +{
>>> +    struct ib_cq *cq, *n;
>>> +    LIST_HEAD(tmp_list);
>>> +    int i;
>>> +
>>> +    for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++) {
>>> +        unsigned long flags;
>>> +
>>> +        spin_lock_irqsave(&dev->cq_pools_lock, flags);
>>> +        list_splice_init(&dev->cq_pools[i], &tmp_list);
>> You are deleting all lists, why do you need _splice_?
>> Why do you need two step free operation?
>>
>> You are calling to this function when device is unregistered, there is
>> no need locks for that and you don't need two step operation.
> You are right, I will simplify the process.
>>
>>> + spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
>>> +    }
>>> +
>>> +    list_for_each_entry_safe(cq, n, &tmp_list, pool_entry)
>>> +        ib_free_cq_force(cq);
>>> +}
>>> +
>>> +static int ib_alloc_cqs(struct ib_device *dev, int nr_cqes,
>>> +            enum ib_poll_context poll_ctx)
>>> +{
>>> +    LIST_HEAD(tmp_list);
>>> +    struct ib_cq *cq;
>>> +    unsigned long flags;
>>> +    int nr_cqs, ret, i;
>>> +
>>> +    /*
>>> +     * Allocated at least as many CQEs as requested, and otherwise
>>> +     * a reasonable batch size so that we can share CQs between
>>> +     * multiple users instead of allocating a larger number of CQs.
>>> +     */
>>> +    nr_cqes = min(dev->attrs.max_cqe, max(nr_cqes, 
>>> IB_MAX_SHARED_CQ_SZ));
>>> +    nr_cqs = min_t(int, dev->num_comp_vectors, num_possible_cpus());
>>> +    for (i = 0; i < nr_cqs; i++) {
>>> +        cq = ib_alloc_cq(dev, NULL, nr_cqes, i, poll_ctx);
>>> +        if (IS_ERR(cq)) {
>>> +            ret = PTR_ERR(cq);
>>> +            goto out_free_cqs;
>>> +        }
>>> +        list_add_tail(&cq->pool_entry, &tmp_list);
>>> +    }
>>> +
>>> +    spin_lock_irqsave(&dev->cq_pools_lock, flags);
>>> +    list_splice(&tmp_list, &dev->cq_pools[poll_ctx - 1]);
>>> +    spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
>>> +
>>> +    return 0;
>>> +
>>> +out_free_cqs:
>>> +    list_for_each_entry(cq, &tmp_list, pool_entry)
>>> +        ib_free_cq(cq);
>>> +    return ret;
>>> +}
>>> +
>>> +struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int 
>>> nr_cqe,
>>> +                 int cpu_hint, enum ib_poll_context poll_ctx)
>>> +{
>>> +    static unsigned int default_comp_vector;
>>> +    int vector, ret, num_comp_vectors;
>>> +    struct ib_cq *cq, *found = NULL;
>>> +    unsigned long flags;
>>> +
>>> +    if (poll_ctx > ARRAY_SIZE(dev->cq_pools) || poll_ctx == 
>>> IB_POLL_DIRECT)
>>> +        return ERR_PTR(-EINVAL);
>>> +
>>> +    num_comp_vectors = min_t(int, dev->num_comp_vectors,
>>> +                 num_possible_cpus());
>> num_possible_cpus() or num_online_cpus()?
>
> num_online_cpus().
>
>>
>>> +    /* Project the affinty to the device completion vector range */
>>> +    if (cpu_hint < 0)
>>> +        vector = default_comp_vector++ % num_comp_vectors;
>>> +    else
>>> +        vector = cpu_hint % num_comp_vectors;
>>> +
>>> +    /*
>>> +     * Find the least used CQ with correct affinity and
>>> +     * enough free CQ entries
>>> +     */
>>> +    while (!found) {
>>> +        spin_lock_irqsave(&dev->cq_pools_lock, flags);
>>> +        list_for_each_entry(cq, &dev->cq_pools[poll_ctx - 1],
>>> +                    pool_entry) {
>>> +            if (vector != cq->comp_vector)
>>> +                continue;
>>> +            if (cq->cqe_used + nr_cqe > cq->cqe)
>>> +                continue;
>>> +            if (found && cq->cqe_used >= found->cqe_used)
>>> +                continue;
>>> +            found = cq;
>> Don't you need to break from this loop at some point of time?
> In order to find the emptiest cq it loops over the entire list. If you 
> think it is better just to find the first one with enough space I will 
> break once one is found.
>>
>>> +        }
>>> +
>>> +        if (found) {
>>> +            found->cqe_used += nr_cqe;
>>> + spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
>>> +
>>> +            return found;
>>> +        }
>>> +        spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
>>> +
>>> +        /*
>>> +         * Didn't find a match or ran out of CQs in the device
>>> +         * pool, allocate a new array of CQs.
>>> +         */
>>> +        ret = ib_alloc_cqs(dev, nr_cqe, poll_ctx);
>>> +        if (ret)
>>> +            return ERR_PTR(ret);
>>> +    }
>>> +
>>> +    return found;
>>> +}
>>> +EXPORT_SYMBOL(ib_cq_pool_get);
>>> +
>>> +void ib_cq_pool_put(struct ib_cq *cq, unsigned int nr_cqe)
>>> +{
>>> +    unsigned long flags;
>>> +
>>> +    if (WARN_ON_ONCE(nr_cqe > cq->cqe_used))
>>> +        return;
>>> +
>>> +    spin_lock_irqsave(&cq->device->cq_pools_lock, flags);
>>> +    cq->cqe_used -= nr_cqe;
>>> + spin_unlock_irqrestore(&cq->device->cq_pools_lock, flags);
>>> +}
>>> +EXPORT_SYMBOL(ib_cq_pool_put);
>>> diff --git a/drivers/infiniband/core/device.c 
>>> b/drivers/infiniband/core/device.c
>>> index d9f565a..30660a0 100644
>>> --- a/drivers/infiniband/core/device.c
>>> +++ b/drivers/infiniband/core/device.c
>>> @@ -600,6 +600,7 @@ struct ib_device *_ib_alloc_device(size_t size)
>>>       mutex_init(&device->compat_devs_mutex);
>>>       init_completion(&device->unreg_completion);
>>>       INIT_WORK(&device->unregistration_work, ib_unregister_work);
>>> +    ib_init_cq_pools(device);
>>>
>>>       return device;
>>>   }
>>> @@ -1455,7 +1456,7 @@ static void __ib_unregister_device(struct 
>>> ib_device *ib_dev)
>>>       device_del(&ib_dev->dev);
>>>       ib_device_unregister_rdmacg(ib_dev);
>>>       ib_cache_cleanup_one(ib_dev);
>>> -
>>> +    ib_purge_cq_pools(ib_dev);
>>>       /*
>>>        * Drivers using the new flow may not call ib_dealloc_device 
>>> except
>>>        * in error unwind prior to registration success.
>>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>>> index c889415..2a939c0 100644
>>> --- a/include/rdma/ib_verbs.h
>>> +++ b/include/rdma/ib_verbs.h
>>> @@ -1555,10 +1555,12 @@ enum ib_poll_context {
>>>       IB_POLL_SOFTIRQ,       /* poll from softirq context */
>>>       IB_POLL_WORKQUEUE,       /* poll from workqueue */
>>>       IB_POLL_UNBOUND_WORKQUEUE, /* poll from unbound workqueue */
>>> +    IB_POLL_LAST,
>>>   };
>>>
>>>   enum ib_cq_type {
>>>       IB_CQ_PRIVATE,    /* CQ will be used by only one user */
>>> +    IB_CQ_SHARED,    /* CQ may be shared by multiple users*/
>> As I said before, IMHO bool will be enough.
> I Agree.
>>
>> Thanks
