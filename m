Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE121CD136
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 07:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgEKFHp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 01:07:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbgEKFHp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 01:07:45 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FE422082E;
        Mon, 11 May 2020 05:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589173664;
        bh=OP4VhOnJeAxMre6f8N1kOMCvVSH7R9PZvaxgJkCXOMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IrmdOrzfBkEo7FqF1QDuhCPlMsXC3we4qtETtbjW9g7kRQoIKVvPizYCVwnT2mSHj
         5qBpCtt2t5jmL6PXEdIidmrEEtUDRsvbfU8WBa7rnQ5S1R7VK3oXKt8HWlSE/Pj8e+
         AR6ZKJIn18MZ0saq195JZOXtF0qD14ttmocgEv2w=
Date:   Mon, 11 May 2020 08:07:40 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yamin Friedman <yaminf@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/4] RDMA/core: Introduce shared CQ pool API
Message-ID: <20200511050740.GB356445@unreal>
References: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
 <1589122557-88996-3-git-send-email-yaminf@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589122557-88996-3-git-send-email-yaminf@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 10, 2020 at 05:55:55PM +0300, Yamin Friedman wrote:
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
>  drivers/infiniband/core/core_priv.h |   8 ++
>  drivers/infiniband/core/cq.c        | 145 ++++++++++++++++++++++++++++++++++++
>  drivers/infiniband/core/device.c    |   3 +-
>  include/rdma/ib_verbs.h             |  32 ++++++++
>  4 files changed, 187 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
> index cf42acc..7fe9c13 100644
> --- a/drivers/infiniband/core/core_priv.h
> +++ b/drivers/infiniband/core/core_priv.h
> @@ -191,6 +191,14 @@ static inline bool rdma_is_upper_dev_rcu(struct net_device *dev,
>  	return netdev_has_upper_dev_all_rcu(dev, upper);
>  }
>
> +struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int nr_cqe,
> +			     int cpu_hint, enum ib_poll_context poll_ctx);
> +void ib_cq_pool_put(struct ib_cq *cq, unsigned int nr_cqe);
> +
> +void ib_init_cq_pools(struct ib_device *dev);
> +
> +void ib_purge_cq_pools(struct ib_device *dev);

I don't know how next patches compile to you, but "core_priv.h" is wrong
place to put function declarations. You also put them here and in ib_verbs.h
below.

Also, it will be nice if you will use same naming convention like in mr_pool.h

> +
>  int addr_init(void);
>  void addr_cleanup(void);
>
> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> index 443a9cd..a86e893 100644
> --- a/drivers/infiniband/core/cq.c
> +++ b/drivers/infiniband/core/cq.c
> @@ -6,8 +6,11 @@
>  #include <linux/err.h>
>  #include <linux/slab.h>
>  #include <rdma/ib_verbs.h>
> +#include "core_priv.h"

It is wrong header.

>
>  #include <trace/events/rdma_core.h>
> +/* Max size for shared CQ, may require tuning */
> +#define IB_MAX_SHARED_CQ_SZ		4096
>
>  /* # of WCs to poll for with a single call to ib_poll_cq */
>  #define IB_POLL_BATCH			16
> @@ -223,6 +226,8 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
>  	cq->poll_ctx = poll_ctx;
>  	atomic_set(&cq->usecnt, 0);
>  	cq->cq_type = IB_CQ_PRIVATE;
> +	cq->cqe_used = 0;

It is already default.

> +	cq->comp_vector = comp_vector;
>
>  	cq->wc = kmalloc_array(IB_POLL_BATCH, sizeof(*cq->wc), GFP_KERNEL);
>  	if (!cq->wc)
> @@ -309,6 +314,8 @@ static void _ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>  {
>  	if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
>  		return;
> +	if (WARN_ON_ONCE(cq->cqe_used != 0))
> +		return;
>
>  	switch (cq->poll_ctx) {
>  	case IB_POLL_DIRECT:
> @@ -345,3 +352,141 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>  		_ib_free_cq_user(cq, udata);
>  }
>  EXPORT_SYMBOL(ib_free_cq_user);
> +
> +static void ib_free_cq_force(struct ib_cq *cq)
> +{
> +	_ib_free_cq_user(cq, NULL);
> +}

This static one liner is better to not exist, call directly.

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

You are deleting all lists, why do you need _splice_?
Why do you need two step free operation?

You are calling to this function when device is unregistered, there is
no need locks for that and you don't need two step operation.

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

num_possible_cpus() or num_online_cpus()?

> +	/* Project the affinty to the device completion vector range */
> +	if (cpu_hint < 0)
> +		vector = default_comp_vector++ % num_comp_vectors;
> +	else
> +		vector = cpu_hint % num_comp_vectors;
> +
> +	/*
> +	 * Find the least used CQ with correct affinity and
> +	 * enough free CQ entries
> +	 */
> +	while (!found) {
> +		spin_lock_irqsave(&dev->cq_pools_lock, flags);
> +		list_for_each_entry(cq, &dev->cq_pools[poll_ctx - 1],
> +				    pool_entry) {
> +			if (vector != cq->comp_vector)
> +				continue;
> +			if (cq->cqe_used + nr_cqe > cq->cqe)
> +				continue;
> +			if (found && cq->cqe_used >= found->cqe_used)
> +				continue;
> +			found = cq;

Don't you need to break from this loop at some point of time?

> +		}
> +
> +		if (found) {
> +			found->cqe_used += nr_cqe;
> +			spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
> +
> +			return found;
> +		}
> +		spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
> +
> +		/*
> +		 * Didn't find a match or ran out of CQs in the device
> +		 * pool, allocate a new array of CQs.
> +		 */
> +		ret = ib_alloc_cqs(dev, nr_cqe, poll_ctx);
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
> +
> +	return found;
> +}
> +EXPORT_SYMBOL(ib_cq_pool_get);
> +
> +void ib_cq_pool_put(struct ib_cq *cq, unsigned int nr_cqe)
> +{
> +	unsigned long flags;
> +
> +	if (WARN_ON_ONCE(nr_cqe > cq->cqe_used))
> +		return;
> +
> +	spin_lock_irqsave(&cq->device->cq_pools_lock, flags);
> +	cq->cqe_used -= nr_cqe;
> +	spin_unlock_irqrestore(&cq->device->cq_pools_lock, flags);
> +}
> +EXPORT_SYMBOL(ib_cq_pool_put);
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index d9f565a..30660a0 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -600,6 +600,7 @@ struct ib_device *_ib_alloc_device(size_t size)
>  	mutex_init(&device->compat_devs_mutex);
>  	init_completion(&device->unreg_completion);
>  	INIT_WORK(&device->unregistration_work, ib_unregister_work);
> +	ib_init_cq_pools(device);
>
>  	return device;
>  }
> @@ -1455,7 +1456,7 @@ static void __ib_unregister_device(struct ib_device *ib_dev)
>  	device_del(&ib_dev->dev);
>  	ib_device_unregister_rdmacg(ib_dev);
>  	ib_cache_cleanup_one(ib_dev);
> -
> +	ib_purge_cq_pools(ib_dev);
>  	/*
>  	 * Drivers using the new flow may not call ib_dealloc_device except
>  	 * in error unwind prior to registration success.
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index c889415..2a939c0 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -1555,10 +1555,12 @@ enum ib_poll_context {
>  	IB_POLL_SOFTIRQ,	   /* poll from softirq context */
>  	IB_POLL_WORKQUEUE,	   /* poll from workqueue */
>  	IB_POLL_UNBOUND_WORKQUEUE, /* poll from unbound workqueue */
> +	IB_POLL_LAST,
>  };
>
>  enum ib_cq_type {
>  	IB_CQ_PRIVATE,	/* CQ will be used by only one user */
> +	IB_CQ_SHARED,	/* CQ may be shared by multiple users*/

As I said before, IMHO bool will be enough.

Thanks
