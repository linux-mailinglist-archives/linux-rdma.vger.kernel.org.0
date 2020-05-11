Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEAD1CD439
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 10:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgEKIuC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 04:50:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34867 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbgEKIuB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 May 2020 04:50:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id j5so9861883wrq.2
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 01:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X/axFlrhrfkIaDLQGB5fH0nxmcVEBLOcuQJpw8hkVIM=;
        b=ELAMEocB1qde1nQ9vWOA0hiVZtL1sjhP9k19DM2Sen2OxvR1fK261I6xArUoWv1JcY
         RCv62yX7vjMkd1VVtad/JEORgq8MU2lUfrOzAQiO72QdM/69hPv3mAghVezcw4eSIGnB
         7u/N0AH1SV2kGZJb0X8kRtIpm9QrgDE5Nd+y0F2fvLSqQ1WwvL2CuilCKV+0peKLmSEL
         Y3I8qjw/YZPgyNYVtAVY/OHvraJQqumDJUqaWUqpEppCtXKT0f9/ZxLNsfAXiPUmvIxb
         PNnwff4d6aTTL+ml6JCGNKpjo5zEZa6PS5ffoidX3Rux3JYb2SwwN64v43/F/aI+oA0a
         cQ4Q==
X-Gm-Message-State: AGi0Pub7xUzksQXNuOj+y454iJWTlYG4DMfEUBYFvr/wa5c/qEPiPT92
        vfTCN2oyCgDyviKwSm8ktr4N5VMf
X-Google-Smtp-Source: APiQypKGxw39JL0gvVPlI5IK5Kz9/J2RAUYBw8iHTh+q2pvEO9ZCovfxU04verHwM7ZFfJWeC9ouMA==
X-Received: by 2002:adf:dcc8:: with SMTP id x8mr3406970wrm.404.1589186998232;
        Mon, 11 May 2020 01:49:58 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:59c:65b4:1d66:e6e? ([2601:647:4802:9070:59c:65b4:1d66:e6e])
        by smtp.gmail.com with ESMTPSA id l13sm211917wrm.55.2020.05.11.01.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 01:49:57 -0700 (PDT)
Subject: Re: [PATCH 2/4] RDMA/core: Introduce shared CQ pool API
To:     Yamin Friedman <yaminf@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-rdma@vger.kernel.org
References: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
 <1589122557-88996-3-git-send-email-yaminf@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f214d59e-2bc1-15f5-4029-99ed322b843e@grimberg.me>
Date:   Mon, 11 May 2020 01:49:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589122557-88996-3-git-send-email-yaminf@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/10/20 7:55 AM, Yamin Friedman wrote:
> Allow a ULP to ask the core to provide a completion queue based on a
> least-used search on a per-device CQ pools. The device CQ pools grow in a
> lazy fashion when more CQs are requested.
> 
> This feature reduces the amount of interrupts when using many QPs.
> Using shared CQs allows for more effcient completion handling. It also
> reduces the amount of overhead needed for CQ contexts.
> 
> Test setup:
> Intel(R) Xeon(R) Platinum 8176M CPU @ 2.10GHz servers.
> Running NVMeoF 4KB read IOs over ConnectX-5EX across Spectrum switch.
> TX-depth = 32. Number of cores refers to the initiator side. Four disks are
> accessed from each core. In the current case we have four CQs per core and
> in the shared case we have a single CQ per core. Until 14 cores there is no
> significant change in performance and the number of interrupts per second
> is less than a million in the current case.
> ==================================================
> |Cores|Current KIOPs  |Shared KIOPs  |improvement|
> |-----|---------------|--------------|-----------|
> |14   |2188           |2620          |19.7%      |
> |-----|---------------|--------------|-----------|
> |20   |2063           |2308          |11.8%      |
> |-----|---------------|--------------|-----------|
> |28   |1933           |2235          |15.6%      |
> |=================================================
> |Cores|Current avg lat|Shared avg lat|improvement|
> |-----|---------------|--------------|-----------|
> |14   |817us          |683us         |16.4%      |
> |-----|---------------|--------------|-----------|
> |20   |1239us         |1108us        |10.6%      |
> |-----|---------------|--------------|-----------|
> |28   |1852us         |1601us        |13.5%      |
> ========================================================
> |Cores|Current interrupts|Shared interrupts|improvement|
> |-----|------------------|-----------------|-----------|
> |14   |2131K/sec         |425K/sec         |80%        |
> |-----|------------------|-----------------|-----------|
> |20   |2267K/sec         |594K/sec         |73.8%      |
> |-----|------------------|-----------------|-----------|
> |28   |2370K/sec         |1057K/sec        |55.3%      |
> ====================================================================
> |Cores|Current 99.99th PCTL lat|Shared 99.99th PCTL lat|improvement|
> |-----|------------------------|-----------------------|-----------|
> |14   |85Kus                   |9Kus                   |88%        |
> |-----|------------------------|-----------------------|-----------|
> |20   |6Kus                    |5.3Kus                 |14.6%      |
> |-----|------------------------|-----------------------|-----------|
> |28   |11.6Kus                 |9.5Kus                 |18%        |
> |===================================================================
> 
> Performance improvement with 16 disks (16 CQs per core) is comparable.
> 
> Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
> Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
> ---
>   drivers/infiniband/core/core_priv.h |   8 ++
>   drivers/infiniband/core/cq.c        | 145 ++++++++++++++++++++++++++++++++++++
>   drivers/infiniband/core/device.c    |   3 +-
>   include/rdma/ib_verbs.h             |  32 ++++++++
>   4 files changed, 187 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
> index cf42acc..7fe9c13 100644
> --- a/drivers/infiniband/core/core_priv.h
> +++ b/drivers/infiniband/core/core_priv.h
> @@ -191,6 +191,14 @@ static inline bool rdma_is_upper_dev_rcu(struct net_device *dev,
>   	return netdev_has_upper_dev_all_rcu(dev, upper);
>   }
>   
> +struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int nr_cqe,
> +			     int cpu_hint, enum ib_poll_context poll_ctx);
> +void ib_cq_pool_put(struct ib_cq *cq, unsigned int nr_cqe);
> +
> +void ib_init_cq_pools(struct ib_device *dev);
> +
> +void ib_purge_cq_pools(struct ib_device *dev);
> +
>   int addr_init(void);
>   void addr_cleanup(void);
>   
> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> index 443a9cd..a86e893 100644
> --- a/drivers/infiniband/core/cq.c
> +++ b/drivers/infiniband/core/cq.c
> @@ -6,8 +6,11 @@
>   #include <linux/err.h>
>   #include <linux/slab.h>
>   #include <rdma/ib_verbs.h>
> +#include "core_priv.h"
>   
>   #include <trace/events/rdma_core.h>
> +/* Max size for shared CQ, may require tuning */
> +#define IB_MAX_SHARED_CQ_SZ		4096
>   
>   /* # of WCs to poll for with a single call to ib_poll_cq */
>   #define IB_POLL_BATCH			16
> @@ -223,6 +226,8 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
>   	cq->poll_ctx = poll_ctx;
>   	atomic_set(&cq->usecnt, 0);
>   	cq->cq_type = IB_CQ_PRIVATE;
> +	cq->cqe_used = 0;
> +	cq->comp_vector = comp_vector;
>   
>   	cq->wc = kmalloc_array(IB_POLL_BATCH, sizeof(*cq->wc), GFP_KERNEL);
>   	if (!cq->wc)
> @@ -309,6 +314,8 @@ static void _ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>   {
>   	if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
>   		return;
> +	if (WARN_ON_ONCE(cq->cqe_used != 0))
> +		return;
>   
>   	switch (cq->poll_ctx) {
>   	case IB_POLL_DIRECT:
> @@ -345,3 +352,141 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>   		_ib_free_cq_user(cq, udata);
>   }
>   EXPORT_SYMBOL(ib_free_cq_user);
> +
> +static void ib_free_cq_force(struct ib_cq *cq)
> +{
> +	_ib_free_cq_user(cq, NULL);
> +}
> +
> +void ib_init_cq_pools(struct ib_device *dev)
> +{
> +	int i;
> +
> +	spin_lock_init(&dev->cq_pools_lock);
> +	for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++)
> +		INIT_LIST_HEAD(&dev->cq_pools[i]);
> +}
> +
> +void ib_purge_cq_pools(struct ib_device *dev)
> +{
> +	struct ib_cq *cq, *n;
> +	LIST_HEAD(tmp_list);
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&dev->cq_pools_lock, flags);
> +		list_splice_init(&dev->cq_pools[i], &tmp_list);
> +		spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
> +	}
> +
> +	list_for_each_entry_safe(cq, n, &tmp_list, pool_entry)
> +		ib_free_cq_force(cq);
> +}
> +
> +static int ib_alloc_cqs(struct ib_device *dev, int nr_cqes,
> +			enum ib_poll_context poll_ctx)
> +{
> +	LIST_HEAD(tmp_list);
> +	struct ib_cq *cq;
> +	unsigned long flags;
> +	int nr_cqs, ret, i;
> +
> +	/*
> +	 * Allocated at least as many CQEs as requested, and otherwise
> +	 * a reasonable batch size so that we can share CQs between
> +	 * multiple users instead of allocating a larger number of CQs.
> +	 */
> +	nr_cqes = min(dev->attrs.max_cqe, max(nr_cqes, IB_MAX_SHARED_CQ_SZ));
> +	nr_cqs = min_t(int, dev->num_comp_vectors, num_possible_cpus());
> +	for (i = 0; i < nr_cqs; i++) {
> +		cq = ib_alloc_cq(dev, NULL, nr_cqes, i, poll_ctx);
> +		if (IS_ERR(cq)) {
> +			ret = PTR_ERR(cq);
> +			goto out_free_cqs;
> +		}
> +		list_add_tail(&cq->pool_entry, &tmp_list);
> +	}
> +
> +	spin_lock_irqsave(&dev->cq_pools_lock, flags);
> +	list_splice(&tmp_list, &dev->cq_pools[poll_ctx - 1]);
> +	spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
> +
> +	return 0;
> +
> +out_free_cqs:
> +	list_for_each_entry(cq, &tmp_list, pool_entry)
> +		ib_free_cq(cq);
> +	return ret;
> +}
> +
> +struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int nr_cqe,
> +			     int cpu_hint, enum ib_poll_context poll_ctx)
> +{
> +	static unsigned int default_comp_vector;
> +	int vector, ret, num_comp_vectors;
> +	struct ib_cq *cq, *found = NULL;
> +	unsigned long flags;
> +
> +	if (poll_ctx > ARRAY_SIZE(dev->cq_pools) || poll_ctx == IB_POLL_DIRECT)
> +		return ERR_PTR(-EINVAL);
> +
> +	num_comp_vectors = min_t(int, dev->num_comp_vectors,
> +				 num_possible_cpus());
> +	/* Project the affinty to the device completion vector range */
> +	if (cpu_hint < 0)
> +		vector = default_comp_vector++ % num_comp_vectors;
> +	else
> +		vector = cpu_hint % num_comp_vectors;

Why are you using the cpu_hint as the vector? Aren't you suppose
to seach the cq with vector that maps to the cpu?

IIRC my version used ib_get_vector_affinity to locate a cq that
will actually interrupt on the cpu... Otherwise, just call it vector.
