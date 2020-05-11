Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBCE1CD963
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 14:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgEKMI5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 08:08:57 -0400
Received: from mail-db8eur05on2074.outbound.protection.outlook.com ([40.107.20.74]:6261
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727019AbgEKMI4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 08:08:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDd2wH3JrVsqEjOWrWZ9oqveuQxNH1dRFL+BFGKAUtoekGrGzfwfhg9ZGIq3MoC9iE6UNVoiSc2Vm686MGzOpDhJgXwsJjcDT08abXESHdPjswVB7dIBN9aLXybzXUrWwC79boAIOfYfPuvQ4l/wdYTzzgKrJrfhv/tCbV9v24ML7ybnmcN/DV53uP2Yb8ZujnmGotRvlRINzc2b/7UE2oedgJ7dA3TS4l/Yx1Q+dWErKK+K7xZ9/Gxwr1/cwUO2ahdVk4TSKEl0Qbwmbjgs39Xq7upaKmxBG8nM4bE7XXTc5wDUI6tHW6fc1tM2loE4UcMbkgmLnaMle7dVjFgWAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLOgSJohSXNaYzBpK4n3aa08ahw4vZXENeD5Jlg8GBE=;
 b=GkFyM/5b0WX5DbXacJ6xKxJ6KEu1641j+96dF/z/P7yUHaN1E4Ftfz9rdkPwUkqsj9Bk1m13WSaQ5/B5mpAwhxn08+S9GhhBs0fd370Nh916VJAtxOKstOCXZraCfsxZ+45nHiw1oWzcLS8rGtOmJneIIbJ1CQNMeR+JV5K/sCQOzCqed/q6zO1F9+NhtNslMm+9ppZmOKKNsciML/pB5YOnftbQX30+i5eqfJpyDgH1uJl8EJIfES6sIpnarpQ2IK9DqpycAlB8sTLGTYXSB8zp748j5s3kCF28ur5pzf/Ogz3NVblg+vDxYP5mdR/ag84yKRyTyrdLN3TRkJG/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLOgSJohSXNaYzBpK4n3aa08ahw4vZXENeD5Jlg8GBE=;
 b=Xs+lqFu1DhLA4+8l+1wKrtB1P3JGtUqAMKnXYgnHdnhUCqZGSdxKnE+Qb334MNk5/INlkbAUVSg7H9qEgQ4Kj8CRlPWfmD1g4PtX6o0MmhRHnSCsgd2H5iKjcMeHVN1v5fTV5Qavr/VkbPKnOWD2NQJJ5TGnqsH6LhknnRw88zQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com (2603:10a6:8:9::11)
 by DB3PR0502MB4010.eurprd05.prod.outlook.com (2603:10a6:8:4::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Mon, 11 May
 2020 12:08:50 +0000
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1]) by DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1%6]) with mapi id 15.20.2958.035; Mon, 11 May 2020
 12:08:49 +0000
Subject: Re: [PATCH 2/4] RDMA/core: Introduce shared CQ pool API
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org
References: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
 <1589122557-88996-3-git-send-email-yaminf@mellanox.com>
 <20200511050740.GB356445@unreal>
From:   Yamin Friedman <yaminf@mellanox.com>
Message-ID: <345890f8-52d6-1aef-dd63-b3115384def5@mellanox.com>
Date:   Mon, 11 May 2020 15:08:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <20200511050740.GB356445@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0089.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::42) To DB3PR0502MB4011.eurprd05.prod.outlook.com
 (2603:10a6:8:9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.102.13] (93.172.45.15) by AM0PR10CA0089.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend Transport; Mon, 11 May 2020 12:08:48 +0000
X-Originating-IP: [93.172.45.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2281fabd-feb5-4ad8-753b-08d7f5a41076
X-MS-TrafficTypeDiagnostic: DB3PR0502MB4010:|DB3PR0502MB4010:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0502MB4010FEB06C78C1E6B0D244DEB1A10@DB3PR0502MB4010.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LAvUB8abUl901dYAXZAuKHr9dlc+XeJ+1jT1JPPMVzQjou2rW0MwHk6ioxcnEAr+RylittdnO6qHDrB3ln0gEH8j1VUp5dvUat0Q4h38fvArnl5Dk5gWz63GaZXfIzn8zyMJlJwffIa73bc/L4RS3PJEq/YZxnZKtKYYr8YgPb79eFvjKx7OQbNSDvK+a1w1DfTqEbOBTReT/E8HrF8GGmW8lPGZXamYXr6CQAxxnG1/6nT6dEb1wyEeHTbno+o8Ps1D+w0XpbGCelmx+cRtgzeFPY2ZCH3NcKAINdc/RyaBLuuXUN5r6ZuUnlcNvpptBtrK2lTM0A7CQ7LaevYOFKn4fRzXqGPwIahnuHDxASFBuTOiB43hquF/FcfRyTmLfNVlaPLXjSq+pie6uoDPcCxm0AXN0jNpLr+NYeIe2hTzekBaGkKgrE2LNd9XwlbnPGBnJPCexsOgsNpnF8L1DNVsDv+jGAJWvI05TIGazze9ZoY5zAt1263oXfoAvpDWkz31x6Y3qtF680ooynoa068appXZaw0I0mOk7x/4ULJjTLLsC7KgWIO7gtLCNUNh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0502MB4011.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(33430700001)(86362001)(4326008)(8936002)(66556008)(66476007)(66946007)(8676002)(6486002)(16576012)(6916009)(54906003)(33440700001)(316002)(31686004)(52116002)(16526019)(186003)(31696002)(956004)(26005)(30864003)(53546011)(36756003)(6666004)(2906002)(5660300002)(478600001)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zrgpqQIByUyNqwvQ2+9yaAndnMQC+MWSaW1NEj+JKezNUnop06RDK+ZGiD1ce7Verxcyu7zJNcvbl+0I/QCxYB7el7mQbXjuRjFHmAKMoHU8gzE06vFznPH1WRf/2skWkxoeBebc/xfaSstjqnj4A4zIJx70seJLbwRapfTsH9n+80/e585ePCoiGfX678lySQwoZlT9/6q/LGp9q6cAODlOAM0drbKd0IA1Tx7Ulg5LgbmgSIFFkH9YIDBATENLsIkOwOec5xz6LNdqR+47MrG8stmr6fx2j34H6NmdNkEuxWWtSSFE00AJHqjKjnzQ+rcuFFtytbwDPJIOTW+zfsOTwZchGD10GghyjBTuNIMaXl8CaFB4ROpqri3Cg/1jK3w9x8WkCEncrdoa5nnU+xfv60cvOlxykXK24ubWLW8+3oQwyyJZjVCeCOMA2899j3WaPieWNe7nEdzsw1SbtSfVBmhDBLHqM4o/VYSkBHs=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2281fabd-feb5-4ad8-753b-08d7f5a41076
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 12:08:49.8663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kV+Y/PcDGDaz8rxzKapfBEjvWCxM6PtdBBfGN9cpC16eFAA+cZuQYxSviGciD+19LtiQhX++MIzqzJRbLEMjKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0502MB4010
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/11/2020 8:07 AM, Leon Romanovsky wrote:
> On Sun, May 10, 2020 at 05:55:55PM +0300, Yamin Friedman wrote:
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
>> TX-depth = 32. Number of cores refers to the initiator side. Four disks are
>> accessed from each core. In the current case we have four CQs per core and
>> in the shared case we have a single CQ per core. Until 14 cores there is no
>> significant change in performance and the number of interrupts per second
>> is less than a million in the current case.
>> ==================================================
>> |Cores|Current KIOPs  |Shared KIOPs  |improvement|
>> |-----|---------------|--------------|-----------|
>> |14   |2188           |2620          |19.7%      |
>> |-----|---------------|--------------|-----------|
>> |20   |2063           |2308          |11.8%      |
>> |-----|---------------|--------------|-----------|
>> |28   |1933           |2235          |15.6%      |
>> |=================================================
>> |Cores|Current avg lat|Shared avg lat|improvement|
>> |-----|---------------|--------------|-----------|
>> |14   |817us          |683us         |16.4%      |
>> |-----|---------------|--------------|-----------|
>> |20   |1239us         |1108us        |10.6%      |
>> |-----|---------------|--------------|-----------|
>> |28   |1852us         |1601us        |13.5%      |
>> ========================================================
>> |Cores|Current interrupts|Shared interrupts|improvement|
>> |-----|------------------|-----------------|-----------|
>> |14   |2131K/sec         |425K/sec         |80%        |
>> |-----|------------------|-----------------|-----------|
>> |20   |2267K/sec         |594K/sec         |73.8%      |
>> |-----|------------------|-----------------|-----------|
>> |28   |2370K/sec         |1057K/sec        |55.3%      |
>> ====================================================================
>> |Cores|Current 99.99th PCTL lat|Shared 99.99th PCTL lat|improvement|
>> |-----|------------------------|-----------------------|-----------|
>> |14   |85Kus                   |9Kus                   |88%        |
>> |-----|------------------------|-----------------------|-----------|
>> |20   |6Kus                    |5.3Kus                 |14.6%      |
>> |-----|------------------------|-----------------------|-----------|
>> |28   |11.6Kus                 |9.5Kus                 |18%        |
>> |===================================================================
>>
>> Performance improvement with 16 disks (16 CQs per core) is comparable.
>>
>> Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
>> Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
>> ---
>>   drivers/infiniband/core/core_priv.h |   8 ++
>>   drivers/infiniband/core/cq.c        | 145 ++++++++++++++++++++++++++++++++++++
>>   drivers/infiniband/core/device.c    |   3 +-
>>   include/rdma/ib_verbs.h             |  32 ++++++++
>>   4 files changed, 187 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
>> index cf42acc..7fe9c13 100644
>> --- a/drivers/infiniband/core/core_priv.h
>> +++ b/drivers/infiniband/core/core_priv.h
>> @@ -191,6 +191,14 @@ static inline bool rdma_is_upper_dev_rcu(struct net_device *dev,
>>   	return netdev_has_upper_dev_all_rcu(dev, upper);
>>   }
>>
>> +struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int nr_cqe,
>> +			     int cpu_hint, enum ib_poll_context poll_ctx);
>> +void ib_cq_pool_put(struct ib_cq *cq, unsigned int nr_cqe);
>> +
>> +void ib_init_cq_pools(struct ib_device *dev);
>> +
>> +void ib_purge_cq_pools(struct ib_device *dev);
> I don't know how next patches compile to you, but "core_priv.h" is wrong
> place to put function declarations. You also put them here and in ib_verbs.h
> below.
>
> Also, it will be nice if you will use same naming convention like in mr_pool.h
I will remove the use of core_priv and look into refactoring the names.
>
>> +
>>   int addr_init(void);
>>   void addr_cleanup(void);
>>
>> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
>> index 443a9cd..a86e893 100644
>> --- a/drivers/infiniband/core/cq.c
>> +++ b/drivers/infiniband/core/cq.c
>> @@ -6,8 +6,11 @@
>>   #include <linux/err.h>
>>   #include <linux/slab.h>
>>   #include <rdma/ib_verbs.h>
>> +#include "core_priv.h"
> It is wrong header.
See above.
>
>>   #include <trace/events/rdma_core.h>
>> +/* Max size for shared CQ, may require tuning */
>> +#define IB_MAX_SHARED_CQ_SZ		4096
>>
>>   /* # of WCs to poll for with a single call to ib_poll_cq */
>>   #define IB_POLL_BATCH			16
>> @@ -223,6 +226,8 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
>>   	cq->poll_ctx = poll_ctx;
>>   	atomic_set(&cq->usecnt, 0);
>>   	cq->cq_type = IB_CQ_PRIVATE;
>> +	cq->cqe_used = 0;
> It is already default.
>
>> +	cq->comp_vector = comp_vector;
>>
>>   	cq->wc = kmalloc_array(IB_POLL_BATCH, sizeof(*cq->wc), GFP_KERNEL);
>>   	if (!cq->wc)
>> @@ -309,6 +314,8 @@ static void _ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>>   {
>>   	if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
>>   		return;
>> +	if (WARN_ON_ONCE(cq->cqe_used != 0))
>> +		return;
>>
>>   	switch (cq->poll_ctx) {
>>   	case IB_POLL_DIRECT:
>> @@ -345,3 +352,141 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>>   		_ib_free_cq_user(cq, udata);
>>   }
>>   EXPORT_SYMBOL(ib_free_cq_user);
>> +
>> +static void ib_free_cq_force(struct ib_cq *cq)
>> +{
>> +	_ib_free_cq_user(cq, NULL);
>> +}
> This static one liner is better to not exist, call directly.
Understood.
>
>> +
>> +void ib_init_cq_pools(struct ib_device *dev)
>> +{
>> +	int i;
>> +
>> +	spin_lock_init(&dev->cq_pools_lock);
>> +	for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++)
>> +		INIT_LIST_HEAD(&dev->cq_pools[i]);
>> +}
>> +
>> +void ib_purge_cq_pools(struct ib_device *dev)
>> +{
>> +	struct ib_cq *cq, *n;
>> +	LIST_HEAD(tmp_list);
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++) {
>> +		unsigned long flags;
>> +
>> +		spin_lock_irqsave(&dev->cq_pools_lock, flags);
>> +		list_splice_init(&dev->cq_pools[i], &tmp_list);
> You are deleting all lists, why do you need _splice_?
> Why do you need two step free operation?
>
> You are calling to this function when device is unregistered, there is
> no need locks for that and you don't need two step operation.
You are right, I will simplify the process.
>
>> +		spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
>> +	}
>> +
>> +	list_for_each_entry_safe(cq, n, &tmp_list, pool_entry)
>> +		ib_free_cq_force(cq);
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
>> +	nr_cqs = min_t(int, dev->num_comp_vectors, num_possible_cpus());
>> +	for (i = 0; i < nr_cqs; i++) {
>> +		cq = ib_alloc_cq(dev, NULL, nr_cqes, i, poll_ctx);
>> +		if (IS_ERR(cq)) {
>> +			ret = PTR_ERR(cq);
>> +			goto out_free_cqs;
>> +		}
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
>> +			     int cpu_hint, enum ib_poll_context poll_ctx)
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
>> +				 num_possible_cpus());
> num_possible_cpus() or num_online_cpus()?

num_online_cpus().

>
>> +	/* Project the affinty to the device completion vector range */
>> +	if (cpu_hint < 0)
>> +		vector = default_comp_vector++ % num_comp_vectors;
>> +	else
>> +		vector = cpu_hint % num_comp_vectors;
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
>> +				continue;
>> +			if (cq->cqe_used + nr_cqe > cq->cqe)
>> +				continue;
>> +			if (found && cq->cqe_used >= found->cqe_used)
>> +				continue;
>> +			found = cq;
> Don't you need to break from this loop at some point of time?
In order to find the emptiest cq it loops over the entire list. If you 
think it is better just to find the first one with enough space I will 
break once one is found.
>
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
>> +	if (WARN_ON_ONCE(nr_cqe > cq->cqe_used))
>> +		return;
>> +
>> +	spin_lock_irqsave(&cq->device->cq_pools_lock, flags);
>> +	cq->cqe_used -= nr_cqe;
>> +	spin_unlock_irqrestore(&cq->device->cq_pools_lock, flags);
>> +}
>> +EXPORT_SYMBOL(ib_cq_pool_put);
>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
>> index d9f565a..30660a0 100644
>> --- a/drivers/infiniband/core/device.c
>> +++ b/drivers/infiniband/core/device.c
>> @@ -600,6 +600,7 @@ struct ib_device *_ib_alloc_device(size_t size)
>>   	mutex_init(&device->compat_devs_mutex);
>>   	init_completion(&device->unreg_completion);
>>   	INIT_WORK(&device->unregistration_work, ib_unregister_work);
>> +	ib_init_cq_pools(device);
>>
>>   	return device;
>>   }
>> @@ -1455,7 +1456,7 @@ static void __ib_unregister_device(struct ib_device *ib_dev)
>>   	device_del(&ib_dev->dev);
>>   	ib_device_unregister_rdmacg(ib_dev);
>>   	ib_cache_cleanup_one(ib_dev);
>> -
>> +	ib_purge_cq_pools(ib_dev);
>>   	/*
>>   	 * Drivers using the new flow may not call ib_dealloc_device except
>>   	 * in error unwind prior to registration success.
>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>> index c889415..2a939c0 100644
>> --- a/include/rdma/ib_verbs.h
>> +++ b/include/rdma/ib_verbs.h
>> @@ -1555,10 +1555,12 @@ enum ib_poll_context {
>>   	IB_POLL_SOFTIRQ,	   /* poll from softirq context */
>>   	IB_POLL_WORKQUEUE,	   /* poll from workqueue */
>>   	IB_POLL_UNBOUND_WORKQUEUE, /* poll from unbound workqueue */
>> +	IB_POLL_LAST,
>>   };
>>
>>   enum ib_cq_type {
>>   	IB_CQ_PRIVATE,	/* CQ will be used by only one user */
>> +	IB_CQ_SHARED,	/* CQ may be shared by multiple users*/
> As I said before, IMHO bool will be enough.
I Agree.
>
> Thanks
