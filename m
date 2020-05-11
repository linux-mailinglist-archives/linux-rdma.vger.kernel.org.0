Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174B31CD944
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 14:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbgEKMDw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 08:03:52 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:18852
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729573AbgEKMDu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 08:03:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAJYOgnm3gx7t4uG2bytg+miIirvkDO9yIuW5kHv3XVJTskF5sT0meQzgv65z+lXJdMDTe0cqZwziN0QvO9MqH8dD4AU8L7cVS42jQUhpuNdBOAsY3dHz9LxPYhILgZ8i7hGluenScq853DL4dwmja5swqAowQ5Eg7PvABZKTktgLOqckDzSRGqrFzxJfNWr1Gmv7dTxps+Q+U7Z48lWPmaJnPwSSNAqXlSgN7HC3T3uizDdqoRxULt4GsLXSThOtMdST+3/xLz7YgxRsvdk8x8il2huLF5YAP3OMYvJQsFRYjnLjkb3CoPhOkHVNHlVKQkhbErD+0LLfw8KgKU0NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sI8ScX+Ibo9hL1G+fNUuk4jq7ipXNvviZBP7Vjz5RUQ=;
 b=JxHAqQD08bNX0kTek4rsSE/jrTAtwuW2/cEqQalbDkdn0R47gNvH7WvXRFNU/C7NcVzMOf3rsv8R8S5uiHF45o6wBzoYa0o3foVJ8UCl09Lgu/hg2eE8kkSIPdW0wvv8R1lAlxR/Ps7pUTq7HMyGRFoK8+uXDtV1UO0v864TtVzJoXJQNCEYeIAGkKSKY3xV7jHyJTwZZEjftue/5EHHe0duOom+hOq21zEjZXYL+xaTXNXQcbYJaGfygXcal8d5O8ddgT7yqKDuW5GLkgcVXyilNVlV8iIymMYRIwQnEmp96CHs2NS1h/93YfYG+TL73ycGT+MeTBzdYvfxzaUO4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sI8ScX+Ibo9hL1G+fNUuk4jq7ipXNvviZBP7Vjz5RUQ=;
 b=bvL3rFuatAsBZ9VE1r+c63J6Ea3GGv+Tyle4sD5WWjcSEF8xGaeIQVeksC6ek74gMD5OLDKrNdhkLWfUiXvoWWQNG08vKLX9/NKw548FYivApTgOD6Am0a8NkpohRPSteZSbZV0OrHOQDWOAdFw/zpgqtmyv1QGWyjGl6s4ZKrs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com (2603:10a6:8:9::11)
 by DB3PR0502MB4089.eurprd05.prod.outlook.com (2603:10a6:8:9::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Mon, 11 May
 2020 12:03:45 +0000
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1]) by DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1%6]) with mapi id 15.20.2958.035; Mon, 11 May 2020
 12:03:45 +0000
Subject: Re: [PATCH 2/4] RDMA/core: Introduce shared CQ pool API
To:     Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-rdma@vger.kernel.org
References: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
 <1589122557-88996-3-git-send-email-yaminf@mellanox.com>
 <f214d59e-2bc1-15f5-4029-99ed322b843e@grimberg.me>
From:   Yamin Friedman <yaminf@mellanox.com>
Message-ID: <921ae7c2-04f0-e89d-7f80-6534ed3b8aa0@mellanox.com>
Date:   Mon, 11 May 2020 15:03:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <f214d59e-2bc1-15f5-4029-99ed322b843e@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::20) To DB3PR0502MB4011.eurprd05.prod.outlook.com
 (2603:10a6:8:9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.102.13] (93.172.45.15) by FR2P281CA0033.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend Transport; Mon, 11 May 2020 12:03:43 +0000
X-Originating-IP: [93.172.45.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f4ef4433-aeb4-41a4-635b-08d7f5a35abc
X-MS-TrafficTypeDiagnostic: DB3PR0502MB4089:|DB3PR0502MB4089:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0502MB40891E3049FA6899811130D9B1A10@DB3PR0502MB4089.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RnqiFQeMxBP/efXDcskJSmBVrbln4d+BqQP46G8QSAU0d39NrpJazE+63NGt5sWBtgYKNIIK0YvhLBqB5/Zi/wOjky2AQX1Lxhpk4zn3bI4yXP47lMWCvcOaSzIMZzhsr7LfzmYv8PUkpU1b+fkRFJnzE8d9Qx5wgLgFVhVLJrraiXaA75qWg4hD+u2hKut4XZmwluwUuZ/2LKm5XTPYqAMGv78AlMybT6jMspNyVqFhkx07IXSRVIx7k8lp9jvE8wjLngfPMT7gWBJE44igXPD1dASp7GTMCAXmCJDb9+aMUNVkla3g57d1j6ft2ssBJeVmFcXx06dSaicNNFMri7xUVsaCdzZCHjYXHdFn3DuFmrXUi5fXt/SuaFQQWygyEEzfrXCPkRXKanJ1qDdwGBSxv0RNTJyjm5lo2QkrKiax1tqRY3MFGEOKmdrweZuld0BoblPdf104r0POMB9vqdGaMUb6ofO4Qgd5ASoeUhHoPLlPdGl57MCe/292f1F2w0075khv1Y6dRHyQyreqfzQBvnitEZXAQOydSrkK6UwoZOW+vMBhrAlImdjinXVF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0502MB4011.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(33430700001)(186003)(26005)(6486002)(16526019)(33440700001)(110136005)(16576012)(2906002)(956004)(316002)(2616005)(66476007)(66556008)(5660300002)(8676002)(66946007)(36756003)(8936002)(86362001)(478600001)(31696002)(4326008)(31686004)(53546011)(52116002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pGXcddnCUGImsf5P6igPBLhnpaEQ6RnM0cL0ppUGn6jIq07aOeHcMIXrBeerwLsY7iQd7dr7gut0+7a79qgKSHXi5ef2PH1mlhKyJSION9oN9kHghAw02jIsGwDZVA90CfsboxlRmyok94gldfqF0xJ2iC3ZN6ig9rbpEyx3C7brqjRHROA7uMC4SSIyB53Pl7pUaw3HkS7njXGHp14l2l2kfHeeZi7KBIQ6cQ5ECS4UuVWf/gvASriy7rAG0X8P/8iBKu2NH6HwNaSRs1Vm4KP4aHOY+JXUjg0TMQMjfFtUlTieO2WFShWI13MwmMEYozGKaqaxLbVQ44k7spK0580GQHnsztm+H6D/DIISlMdVc6JlkG2v6cO3kOappCgkz+SrX0bxlGMa6q0jEtzDvUMzLEbf4Zjo1EwHv9z6A5FHoOnd3eMOFQJbwKdHQ6IoMSqdEHbMQcEBdRsE+P5En/fBx/c712B8rbhr0zCM2c8=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ef4433-aeb4-41a4-635b-08d7f5a35abc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 12:03:45.6039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7WsmXbzSBhCIV6BHHBfwqVIvwpMYXk1iHdQZ8jhANn3Oa2lGuNEoKwD4g4WyQ6AjOoIGjQnmOs5ri9UGbnfe6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0502MB4089
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/11/2020 11:49 AM, Sagi Grimberg wrote:
>
>
> On 5/10/20 7:55 AM, Yamin Friedman wrote:
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
>> TX-depth = 32. Number of cores refers to the initiator side. Four 
>> disks are
>> accessed from each core. In the current case we have four CQs per 
>> core and
>> in the shared case we have a single CQ per core. Until 14 cores there 
>> is no
>> significant change in performance and the number of interrupts per 
>> second
>> is less than a million in the current case.
>> ==================================================
>> |Cores|Current KIOPs  |Shared KIOPs  |improvement|
>> |-----|---------------|--------------|-----------|
>> |14   |2188           |2620          |19.7%      |
>> |-----|---------------|--------------|-----------|
>> |20   |2063           |2308          |11.8%      |
>> |-----|---------------|--------------|-----------|
>> |28   |1933           |2235          |15.6%      |
>> |=================================================
>> |Cores|Current avg lat|Shared avg lat|improvement|
>> |-----|---------------|--------------|-----------|
>> |14   |817us          |683us         |16.4%      |
>> |-----|---------------|--------------|-----------|
>> |20   |1239us         |1108us        |10.6%      |
>> |-----|---------------|--------------|-----------|
>> |28   |1852us         |1601us        |13.5%      |
>> ========================================================
>> |Cores|Current interrupts|Shared interrupts|improvement|
>> |-----|------------------|-----------------|-----------|
>> |14   |2131K/sec         |425K/sec         |80%        |
>> |-----|------------------|-----------------|-----------|
>> |20   |2267K/sec         |594K/sec         |73.8%      |
>> |-----|------------------|-----------------|-----------|
>> |28   |2370K/sec         |1057K/sec        |55.3%      |
>> ====================================================================
>> |Cores|Current 99.99th PCTL lat|Shared 99.99th PCTL lat|improvement|
>> |-----|------------------------|-----------------------|-----------|
>> |14   |85Kus                   |9Kus |88%        |
>> |-----|------------------------|-----------------------|-----------|
>> |20   |6Kus                    |5.3Kus |14.6%      |
>> |-----|------------------------|-----------------------|-----------|
>> |28   |11.6Kus                 |9.5Kus |18%        |
>> |===================================================================
>>
>> Performance improvement with 16 disks (16 CQs per core) is comparable.
>>
>> Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
>> Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
>> ---
>>   drivers/infiniband/core/core_priv.h |   8 ++
>>   drivers/infiniband/core/cq.c        | 145 
>> ++++++++++++++++++++++++++++++++++++
>>   drivers/infiniband/core/device.c    |   3 +-
>>   include/rdma/ib_verbs.h             |  32 ++++++++
>>   4 files changed, 187 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/core/core_priv.h 
>> b/drivers/infiniband/core/core_priv.h
>> index cf42acc..7fe9c13 100644
>> --- a/drivers/infiniband/core/core_priv.h
>> +++ b/drivers/infiniband/core/core_priv.h
>> @@ -191,6 +191,14 @@ static inline bool rdma_is_upper_dev_rcu(struct 
>> net_device *dev,
>>       return netdev_has_upper_dev_all_rcu(dev, upper);
>>   }
>>   +struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int 
>> nr_cqe,
>> +                 int cpu_hint, enum ib_poll_context poll_ctx);
>> +void ib_cq_pool_put(struct ib_cq *cq, unsigned int nr_cqe);
>> +
>> +void ib_init_cq_pools(struct ib_device *dev);
>> +
>> +void ib_purge_cq_pools(struct ib_device *dev);
>> +
>>   int addr_init(void);
>>   void addr_cleanup(void);
>>   diff --git a/drivers/infiniband/core/cq.c 
>> b/drivers/infiniband/core/cq.c
>> index 443a9cd..a86e893 100644
>> --- a/drivers/infiniband/core/cq.c
>> +++ b/drivers/infiniband/core/cq.c
>> @@ -6,8 +6,11 @@
>>   #include <linux/err.h>
>>   #include <linux/slab.h>
>>   #include <rdma/ib_verbs.h>
>> +#include "core_priv.h"
>>     #include <trace/events/rdma_core.h>
>> +/* Max size for shared CQ, may require tuning */
>> +#define IB_MAX_SHARED_CQ_SZ        4096
>>     /* # of WCs to poll for with a single call to ib_poll_cq */
>>   #define IB_POLL_BATCH            16
>> @@ -223,6 +226,8 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device 
>> *dev, void *private,
>>       cq->poll_ctx = poll_ctx;
>>       atomic_set(&cq->usecnt, 0);
>>       cq->cq_type = IB_CQ_PRIVATE;
>> +    cq->cqe_used = 0;
>> +    cq->comp_vector = comp_vector;
>>         cq->wc = kmalloc_array(IB_POLL_BATCH, sizeof(*cq->wc), 
>> GFP_KERNEL);
>>       if (!cq->wc)
>> @@ -309,6 +314,8 @@ static void _ib_free_cq_user(struct ib_cq *cq, 
>> struct ib_udata *udata)
>>   {
>>       if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
>>           return;
>> +    if (WARN_ON_ONCE(cq->cqe_used != 0))
>> +        return;
>>         switch (cq->poll_ctx) {
>>       case IB_POLL_DIRECT:
>> @@ -345,3 +352,141 @@ void ib_free_cq_user(struct ib_cq *cq, struct 
>> ib_udata *udata)
>>           _ib_free_cq_user(cq, udata);
>>   }
>>   EXPORT_SYMBOL(ib_free_cq_user);
>> +
>> +static void ib_free_cq_force(struct ib_cq *cq)
>> +{
>> +    _ib_free_cq_user(cq, NULL);
>> +}
>> +
>> +void ib_init_cq_pools(struct ib_device *dev)
>> +{
>> +    int i;
>> +
>> +    spin_lock_init(&dev->cq_pools_lock);
>> +    for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++)
>> +        INIT_LIST_HEAD(&dev->cq_pools[i]);
>> +}
>> +
>> +void ib_purge_cq_pools(struct ib_device *dev)
>> +{
>> +    struct ib_cq *cq, *n;
>> +    LIST_HEAD(tmp_list);
>> +    int i;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++) {
>> +        unsigned long flags;
>> +
>> +        spin_lock_irqsave(&dev->cq_pools_lock, flags);
>> +        list_splice_init(&dev->cq_pools[i], &tmp_list);
>> +        spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
>> +    }
>> +
>> +    list_for_each_entry_safe(cq, n, &tmp_list, pool_entry)
>> +        ib_free_cq_force(cq);
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
>> +    nr_cqs = min_t(int, dev->num_comp_vectors, num_possible_cpus());
>> +    for (i = 0; i < nr_cqs; i++) {
>> +        cq = ib_alloc_cq(dev, NULL, nr_cqes, i, poll_ctx);
>> +        if (IS_ERR(cq)) {
>> +            ret = PTR_ERR(cq);
>> +            goto out_free_cqs;
>> +        }
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
>> +    list_for_each_entry(cq, &tmp_list, pool_entry)
>> +        ib_free_cq(cq);
>> +    return ret;
>> +}
>> +
>> +struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int 
>> nr_cqe,
>> +                 int cpu_hint, enum ib_poll_context poll_ctx)
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
>> +                 num_possible_cpus());
>> +    /* Project the affinty to the device completion vector range */
>> +    if (cpu_hint < 0)
>> +        vector = default_comp_vector++ % num_comp_vectors;
>> +    else
>> +        vector = cpu_hint % num_comp_vectors;
>
> Why are you using the cpu_hint as the vector? Aren't you suppose
> to seach the cq with vector that maps to the cpu?
>
> IIRC my version used ib_get_vector_affinity to locate a cq that
> will actually interrupt on the cpu... Otherwise, just call it vector.
You are right, I ended up removing the call to ib_get_vector_affinity 
because it wasn't implemented anyway. I think it would be best just to 
change it from cpu_hint to comp_vector_hint and then we will get the 
desired spread over comp vectors which is what happens anyway without 
ib_get_vector_affinity.
