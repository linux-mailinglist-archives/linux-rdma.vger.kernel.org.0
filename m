Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2DF1E1BF6
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 09:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbgEZHJW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 May 2020 03:09:22 -0400
Received: from mail-db8eur05on2051.outbound.protection.outlook.com ([40.107.20.51]:52449
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730341AbgEZHJV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 May 2020 03:09:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHPU2LtYz75HHZJGqqKCO3lKHHqdpLEMR3224JcVLHy+Gi5tWok0ZH/vLi0RggL+kVsMb8zqPq0KyjDQLA2fmwwQbm+8Fv0/CVCO0ZZFELdbLfgv3v6xNpiWnTjIXUBAwQyzmJCx9ETMOa+uUJxv/M/g2B4SvOOstfK0CSkErL+PYSrlxHeRsUe1X1Bw6O+qseOJbIYVjkITWsHG13e/9M6NOjF9/x8/w6jgY5f+73b3gAhUolGPLeMOuqKLolmdoYqn6tq4oDQ4Ra/OtkADZmpP6nFmql+X1XVTxJHCYSHmIYcGajtZNZZxWQfrTQvd2DX8+NlJnbDm1tuhOaOD5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYKhAuduev0lyZj1ZH3WPjBZWTDbzlgilcGZ+L+Yidw=;
 b=HQ3McnB15+R+/6YT6gJvwLsGZ68p1Hqyz1cDG/2njXjaVHCvqg3dXWcEis2SRYgT9Hx/LERXwbn18PT/HDhw7ZoQTbPjahlgXPhRqTBdr+LxW2V3N1kGbA6sDBdnbK+32r6/hB+vvkhwV13XF4llmHG8KfXBmNEPAbGYyONqTMlZCq8lWuJ+S8HDqKToSZKXGyE4Q7jlcOG27rJNNnYqUFE+lu924LFpwaZ0vp5HyIRCrDwM7EYfTXrKqdY7nrxO+wpAv0qZ4eUpsf5lEz+R6wfhcsDx5vUQNtoUmHIsOLC9Ntnk+t2ejkdoZkRnXhisTjnA5UcVG11HIm2y1KiK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYKhAuduev0lyZj1ZH3WPjBZWTDbzlgilcGZ+L+Yidw=;
 b=rBULMpMnB8ou/2eMAzSboum7nmNhXzLko80DUo/40hQsoLUos4/qTEOvJhlb4pEJ6jvzjvKTsJaVFZQ6i6Vyjvc+Io2N1xfdnG/Clrsp1CjDZZu+9C9IBip4n1gGKW3YWyOkgMVu7XJ/Pet7TpIAEy1Fk1PyrGl5nir8uKj44Xs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com (2603:10a6:8:9::11)
 by DB3PR0502MB3978.eurprd05.prod.outlook.com (2603:10a6:8:3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Tue, 26 May
 2020 07:09:17 +0000
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1]) by DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1%6]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 07:09:17 +0000
Subject: Re: [PATCH V3 2/4] RDMA/core: Introduce shared CQ pool API
From:   Yamin Friedman <yaminf@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
References: <1589892216-39283-1-git-send-email-yaminf@mellanox.com>
 <1589892216-39283-3-git-send-email-yaminf@mellanox.com>
 <04d9de81-7b6f-429f-1f7f-b43ee1d02a6a@mellanox.com>
Message-ID: <4f097a6d-2555-784c-ec26-65688b1a296b@mellanox.com>
Date:   Tue, 26 May 2020 10:09:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <04d9de81-7b6f-429f-1f7f-b43ee1d02a6a@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0099.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::40) To DB3PR0502MB4011.eurprd05.prod.outlook.com
 (2603:10a6:8:9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.102.13] (93.172.45.15) by AM0PR01CA0099.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Tue, 26 May 2020 07:09:15 +0000
X-Originating-IP: [93.172.45.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 562ed00a-df45-442a-039b-08d80143b407
X-MS-TrafficTypeDiagnostic: DB3PR0502MB3978:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0502MB39789C3CAD489B1A76137B32B1B00@DB3PR0502MB3978.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KNCuniLtFnq5WyXz4yFs29AR7J45Yk2GuAxAPaklkKvGemVM89Gp/lNLgBAqqzr94qCRo3/dq+zL2UWWZyjVY64bdMrINcuo+JXAz6YHeowaULF55mKYVFfu2OFIx+sAiYPdkwnvT7J3tBIUJ0rafWGfRsTTscexE1yN7m48+x9rdeC2YE9fJN0anBlTz0IPabVk9gjpwAeU9Bwc2yyyRnU2gQqSFeY2BkvHFnn1hYma7LLoKCTOjrM8kPMZKJRUwYE9OySP84IoqmwXhzvoMLkFKTqL4AKHpXjlcjkDnmoygRfygcYsItKWw8NjjP9gZd7HG/WpzGL7Iu+lzkwPbGltf5fEEN2N2iTY+WRTtYEwoRSdGZfY5kTfFSwEpsD3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0502MB4011.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(66946007)(66556008)(66476007)(478600001)(956004)(16526019)(186003)(30864003)(5660300002)(4326008)(36756003)(52116002)(26005)(6486002)(2616005)(8936002)(8676002)(2906002)(86362001)(16576012)(31696002)(110136005)(31686004)(316002)(6636002)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: MwNuMKJXp2JA1k7igsKsaylfv8/fGQSpS1c1/+Zrd7OVOCcmhTeHmowz4GI2TUxsJw7aRMRLXTX8UzAHLLEM531VBv4+5sWxjT8Y2u15UPAlF54U5HTknJuJG8e4Lnoad+07UlUrTMgJtADRqTS2j/gDZGiZbVI8hODJyoh2yWIXD6ZXD8KJcB5lV7PFqosJjm7ylkaxDfGxojYyIdFUmR1l31p3i8h5lqNqtaEm+9cU2Yzhc5Gu5hYwz6Qr30VxXVIUF3aqQO5RR2wPV65ObFkgETsknGRQk8hSzGluAWywW0Sro57XlykNESRV4QAZK00l8+evCGR0dgCLTjxxRr8cs0aBqN5A1YAXRQxuAnnxGKneriEsOOfXWAVYnf98TcigT7ixr+F9Ss9OKvI6dDHHnaNLcHZapjxQLHaadSL0m6nLGwZFzCjKoh3DS0icAkMF40YDxgJhnE57QTgKOQWESVCqpx7GANkGa6uPOSc=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562ed00a-df45-442a-039b-08d80143b407
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 07:09:17.0828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFXumSJYq9PdoAIUeJJ9Z7PLArDuiHiGdb+XDNy/bi+FRKQmqDac4C+8puMqfgTuD4rQp35sjpIVkYyN3H2Dvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0502MB3978
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/25/2020 4:06 PM, Yamin Friedman wrote:
> Minor fix brought to my attention by MaxG.
>
> On 5/19/2020 3:43 PM, Yamin Friedman wrote:
>> Allow a ULP to ask the core to provide a completion queue based on a
>> least-used search on a per-device CQ pools. The device CQ pools grow 
>> in a
>> lazy fashion when more CQs are requested.
>>
>> This feature reduces the amount of interrupts when using many QPs.
>> Using shared CQs allows for more effcient completion handling. It also
>> reduces the amount of overhead needed for CQ contexts.
>>
>> Test setup:
>> Intel(R) Xeon(R) Platinum 8176M CPU @ 2.10GHz servers.
>> Running NVMeoF 4KB read IOs over ConnectX-5EX across Spectrum switch.
>> TX-depth = 32. The patch was applied in the nvme driver on both the 
>> target
>> and initiator. Four controllers are accessed from each core. In the
>> current test case we have exposed sixteen NVMe namespaces using four
>> different subsystems (four namespaces per subsystem) from one NVM port.
>> Each controller allocated X queues (RDMA QPs) and attached to Y CQs.
>> Before this series we had X == Y, i.e for four controllers we've created
>> total of 4X QPs and 4X CQs. In the shared case, we've created 4X QPs and
>> only X CQs which means that we have four controllers that share a
>> completion queue per core. Until fourteen cores there is no significant
>> change in performance and the number of interrupts per second is less 
>> than
>> a million in the current case.
>> ==================================================
>> |Cores|Current KIOPs  |Shared KIOPs  |improvement|
>> |-----|---------------|--------------|-----------|
>> |14   |2332           |2723          |16.7%      |
>> |-----|---------------|--------------|-----------|
>> |20   |2086           |2712          |30%        |
>> |-----|---------------|--------------|-----------|
>> |28   |1971           |2669          |35.4%      |
>> |=================================================
>> |Cores|Current avg lat|Shared avg lat|improvement|
>> |-----|---------------|--------------|-----------|
>> |14   |767us          |657us         |14.3%      |
>> |-----|---------------|--------------|-----------|
>> |20   |1225us         |943us         |23%        |
>> |-----|---------------|--------------|-----------|
>> |28   |1816us         |1341us        |26.1%      |
>> ========================================================
>> |Cores|Current interrupts|Shared interrupts|improvement|
>> |-----|------------------|-----------------|-----------|
>> |14   |1.6M/sec          |0.4M/sec         |72%        |
>> |-----|------------------|-----------------|-----------|
>> |20   |2.8M/sec          |0.6M/sec         |72.4%      |
>> |-----|------------------|-----------------|-----------|
>> |28   |2.9M/sec          |0.8M/sec         |63.4%      |
>> ====================================================================
>> |Cores|Current 99.99th PCTL lat|Shared 99.99th PCTL lat|improvement|
>> |-----|------------------------|-----------------------|-----------|
>> |14   |67ms                    |6ms |90.9%      |
>> |-----|------------------------|-----------------------|-----------|
>> |20   |5ms                     |6ms |-10%       |
>> |-----|------------------------|-----------------------|-----------|
>> |28   |8.7ms                   |6ms |25.9%      |
>> |===================================================================
>>
>> Performance improvement with sixteen disks (sixteen CQs per core) is
>> comparable.
>>
>> Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
>> Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
>> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
>> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
>> ---
>>   drivers/infiniband/core/core_priv.h |   3 +
>>   drivers/infiniband/core/cq.c        | 144 
>> ++++++++++++++++++++++++++++++++++++
>>   drivers/infiniband/core/device.c    |   2 +
>>   include/rdma/ib_verbs.h             |  35 +++++++++
>>   4 files changed, 184 insertions(+)
>>
>> diff --git a/drivers/infiniband/core/core_priv.h 
>> b/drivers/infiniband/core/core_priv.h
>> index cf42acc..a1e6a67 100644
>> --- a/drivers/infiniband/core/core_priv.h
>> +++ b/drivers/infiniband/core/core_priv.h
>> @@ -414,4 +414,7 @@ void rdma_umap_priv_init(struct rdma_umap_priv 
>> *priv,
>>                struct vm_area_struct *vma,
>>                struct rdma_user_mmap_entry *entry);
>>   +void ib_cq_pool_init(struct ib_device *dev);
>> +void ib_cq_pool_destroy(struct ib_device *dev);
>> +
>>   #endif /* _CORE_PRIV_H */
>> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
>> index 4f25b24..7175295 100644
>> --- a/drivers/infiniband/core/cq.c
>> +++ b/drivers/infiniband/core/cq.c
>> @@ -7,7 +7,11 @@
>>   #include <linux/slab.h>
>>   #include <rdma/ib_verbs.h>
>>   +#include "core_priv.h"
>> +
>>   #include <trace/events/rdma_core.h>
>> +/* Max size for shared CQ, may require tuning */
>> +#define IB_MAX_SHARED_CQ_SZ        4096
>>     /* # of WCs to poll for with a single call to ib_poll_cq */
>>   #define IB_POLL_BATCH            16
>> @@ -218,6 +222,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device 
>> *dev, void *private,
>>       cq->cq_context = private;
>>       cq->poll_ctx = poll_ctx;
>>       atomic_set(&cq->usecnt, 0);
>> +    cq->comp_vector = comp_vector;
>>         cq->wc = kmalloc_array(IB_POLL_BATCH, sizeof(*cq->wc), 
>> GFP_KERNEL);
>>       if (!cq->wc)
>> @@ -309,6 +314,8 @@ void ib_free_cq_user(struct ib_cq *cq, struct 
>> ib_udata *udata)
>>   {
>>       if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
>>           return;
>> +    if (WARN_ON_ONCE(cq->cqe_used))
>> +        return;
>>         switch (cq->poll_ctx) {
>>       case IB_POLL_DIRECT:
>> @@ -334,3 +341,140 @@ void ib_free_cq_user(struct ib_cq *cq, struct 
>> ib_udata *udata)
>>       kfree(cq);
>>   }
>>   EXPORT_SYMBOL(ib_free_cq_user);
>> +
>> +void ib_cq_pool_init(struct ib_device *dev)
>> +{
>> +    int i;
>> +
>> +    spin_lock_init(&dev->cq_pools_lock);
>> +    for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++)
>> +        INIT_LIST_HEAD(&dev->cq_pools[i]);
>> +}
>> +
>> +void ib_cq_pool_destroy(struct ib_device *dev)
>> +{
>> +    struct ib_cq *cq, *n;
>> +    int i;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++) {
>> +        list_for_each_entry_safe(cq, n, &dev->cq_pools[i],
>> +                     pool_entry) {
>> +            cq->shared = false;
>> +            ib_free_cq_user(cq, NULL);
>> +        }
>> +    }
>> +
>> +}
>> +
>> +static int ib_alloc_cqs(struct ib_device *dev, int nr_cqes,
>> +            enum ib_poll_context poll_ctx)
>> +{
>> +    LIST_HEAD(tmp_list);
>> +    struct ib_cq *cq;
>> +    unsigned long flags;
>> +    int nr_cqs, ret, i;
>> +
>> +    /*
>> +     * Allocated at least as many CQEs as requested, and otherwise
>> +     * a reasonable batch size so that we can share CQs between
>> +     * multiple users instead of allocating a larger number of CQs.
>> +     */
>> +    nr_cqes = min(dev->attrs.max_cqe, max(nr_cqes, 
>> IB_MAX_SHARED_CQ_SZ));
>> +    nr_cqs = min_t(int, dev->num_comp_vectors, num_online_cpus());
>> +    for (i = 0; i < nr_cqs; i++) {
>> +        cq = ib_alloc_cq(dev, NULL, nr_cqes, i, poll_ctx);
>> +        if (IS_ERR(cq)) {
>> +            ret = PTR_ERR(cq);
>> +            goto out_free_cqs;
>> +        }
>> +        cq->shared = true;
>> +        list_add_tail(&cq->pool_entry, &tmp_list);
>> +    }
>> +
>> +    spin_lock_irqsave(&dev->cq_pools_lock, flags);
>> +    list_splice(&tmp_list, &dev->cq_pools[poll_ctx - 1]);
>> +    spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
>> +
>> +    return 0;
>> +
>> +out_free_cqs:
>> +    list_for_each_entry(cq, &tmp_list, pool_entry) {
>> +        cq->shared = false;
>> +        ib_free_cq(cq);
>> +    }
>> +    return ret;
>> +}
>> +
>> +struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int 
>> nr_cqe,
>> +                 int comp_vector_hint,
>> +                 enum ib_poll_context poll_ctx)
>> +{
>> +    static unsigned int default_comp_vector;
>> +    int vector, ret, num_comp_vectors;
>> +    struct ib_cq *cq, *found = NULL;
>> +    unsigned long flags;
>> +
>> +    if (poll_ctx > ARRAY_SIZE(dev->cq_pools) || poll_ctx == 
>> IB_POLL_DIRECT)
>> +        return ERR_PTR(-EINVAL);
>> +
>> +    num_comp_vectors = min_t(int, dev->num_comp_vectors,
>> +                 num_online_cpus());
>> +    /* Project the affinty to the device completion vector range */
>> +    if (comp_vector_hint < 0)
>> +        vector = default_comp_vector++ % num_comp_vectors;
>> +    else
>> +        vector = comp_vector_hint % num_comp_vectors;
>> +
>> +    /*
>> +     * Find the least used CQ with correct affinity and
>> +     * enough free CQ entries
>> +     */
>> +    while (!found) {
>> +        spin_lock_irqsave(&dev->cq_pools_lock, flags);
>> +        list_for_each_entry(cq, &dev->cq_pools[poll_ctx - 1],
>> +                    pool_entry) {
>> +            /*
>> +             * Check to see if we have found a CQ with the
>> +             * correct completion vector
>> +             */
>> +            if (vector != cq->comp_vector)
>> +                continue;
>> +            if (cq->cqe_used + nr_cqe > cq->cqe)
>> +                continue;
>> +            found = cq;
>> +            break;
>> +        }
>> +
>> +        if (found) {
>> +            found->cqe_used += nr_cqe;
>> +            spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
>> +
>> +            return found;
>> +        }
>> +        spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
>> +
>> +        /*
>> +         * Didn't find a match or ran out of CQs in the device
>> +         * pool, allocate a new array of CQs.
>> +         */
>> +        ret = ib_alloc_cqs(dev, nr_cqe, poll_ctx);
>> +        if (ret)
>> +            return ERR_PTR(ret);
>> +    }
>> +
>> +    return found;
>> +}
>> +EXPORT_SYMBOL(ib_cq_pool_get);
>> +
>> +void ib_cq_pool_put(struct ib_cq *cq, unsigned int nr_cqe)
>> +{
>> +    unsigned long flags;
>> +
>> +    if (WARN_ON_ONCE(nr_cqe > cq->cqe_used))
>> +        return;
>> +
>> +    spin_lock_irqsave(&cq->device->cq_pools_lock, flags);
>> +    cq->cqe_used -= nr_cqe;
>> + spin_unlock_irqrestore(&cq->device->cq_pools_lock, flags);
>> +}
>> +EXPORT_SYMBOL(ib_cq_pool_put);
>> diff --git a/drivers/infiniband/core/device.c 
>> b/drivers/infiniband/core/device.c
>> index d9f565a..0966f86 100644
>> --- a/drivers/infiniband/core/device.c
>> +++ b/drivers/infiniband/core/device.c
>> @@ -1418,6 +1418,7 @@ int ib_register_device(struct ib_device 
>> *device, const char *name)
>>           device->ops.dealloc_driver = dealloc_fn;
>>           return ret;
>>       }
>> +    ib_cq_pool_init(device);
>>       ib_device_put(device);
>>         return 0;
>> @@ -1446,6 +1447,7 @@ static void __ib_unregister_device(struct 
>> ib_device *ib_dev)
>>       if (!refcount_read(&ib_dev->refcount))
>>           goto out;
>>   +    ib_cq_pool_destroy(ib_dev);
>>       disable_device(ib_dev);
>>         /* Expedite removing unregistered pointers from the hash 
>> table */
>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>> index 1659131..d40604a 100644
>> --- a/include/rdma/ib_verbs.h
>> +++ b/include/rdma/ib_verbs.h
>> @@ -1555,6 +1555,7 @@ enum ib_poll_context {
>>       IB_POLL_SOFTIRQ,       /* poll from softirq context */
>>       IB_POLL_WORKQUEUE,       /* poll from workqueue */
>>       IB_POLL_UNBOUND_WORKQUEUE, /* poll from unbound workqueue */
>> +    IB_POLL_LAST,
>>   };
>>     struct ib_cq {
>> @@ -1564,9 +1565,12 @@ struct ib_cq {
>>       void                  (*event_handler)(struct ib_event *, void *);
>>       void                   *cq_context;
>>       int                   cqe;
>> +    int            cqe_used;
>>       atomic_t              usecnt; /* count number of work queues */
>>       enum ib_poll_context    poll_ctx;
>> +    int                     comp_vector;
>>       struct ib_wc        *wc;
>> +    struct list_head        pool_entry;
>>       union {
>>           struct irq_poll        iop;
>>           struct work_struct    work;
>> @@ -2695,6 +2699,10 @@ struct ib_device {
>>   #endif
>>         u32                          index;
>> +
>> +    spinlock_t                   cq_pools_lock;
>> +    struct list_head             cq_pools[IB_POLL_LAST - 1];
>> +
>>       struct rdma_restrack_root *res;
>>         const struct uapi_definition   *driver_def;
>> @@ -3952,6 +3960,33 @@ static inline int ib_req_notify_cq(struct 
>> ib_cq *cq,
>>       return cq->device->ops.req_notify_cq(cq, flags);
>>   }
>>   +/*
>> + * ib_cq_pool_get() - Find the least used completion queue that matches
>> + *     a given cpu hint (or least used for wild card affinity)
>> + *     and fits nr_cqe
>> + * @dev: rdma device
>> + * @nr_cqe: number of needed cqe entries
>> + * @comp_vector_hint: completion vector hint (-1) for the driver to 
>> assign
>> + *   a comp vector based on internal counter
>> + * @poll_ctx: cq polling context
>> + *
>> + * Finds a cq that satisfies @comp_vector_hint and @nr_cqe 
>> requirements and
>> + * claim entries in it for us. In case there is no available cq, 
>> allocate
>> + * a new cq with the requirements and add it to the device pool.
>> + * IB_POLL_DIRECT cannot be used for shared cqs so it is not a valid 
>> value
>> + * for @poll_ctx.
>> + */
>> +struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int 
>> nr_cqe,
>> +                 int comp_vector_hint,
>> +                 enum ib_poll_context poll_ctx);
>> +
>> +/**
>> + * ib_cq_pool_put - Return a CQ taken from a shared pool.
>> + * @cq: The CQ to return.
>> + * @nr_cqe: The max number of cqes that the user had requested.
>> + */
>> +void ib_cq_pool_put(struct ib_cq *cq, unsigned int nr_cqe);
>> +
>>   /**
>>    * ib_req_ncomp_notif - Request completion notification when there are
>>    *   at least the specified number of unreaped completions on the CQ.

 From dabcad9a5813d9cb4bb5f5ac6931a5a9b1dd2dc2 Mon Sep 17 00:00:00 2001
From: Yamin Friedman <yaminf@mellanox.com>
Date: Mon, 25 May 2020 16:39:05 +0300
Subject: [PATCH] Fixup RDMA/core: Correct ib_cq_free usage

Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
---
  drivers/infiniband/core/cq.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 7175295..c462d48 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -360,7 +360,7 @@ void ib_cq_pool_destroy(struct ib_device *dev)
                 list_for_each_entry_safe(cq, n, &dev->cq_pools[i],
                                          pool_entry) {
                         cq->shared = false;
-                       ib_free_cq_user(cq, NULL);
+                       ib_free_cq(cq);
                 }
         }
