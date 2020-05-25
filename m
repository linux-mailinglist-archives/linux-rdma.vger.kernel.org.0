Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8471E12D9
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 18:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387794AbgEYQmS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 12:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387766AbgEYQmS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 12:42:18 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10ACC061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 09:42:17 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i68so14139507qtb.5
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 09:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p9c2wAENRuY7p6+WPlp+HWNM99SsckZW8p7A57PkQx0=;
        b=emi/ofI3fPIh5CCNtm7HoZcCpsOM0EBCISUdrP/Q7hoUBz3qFTMRBMYZx1w7OcPIF7
         FhuEFel3pZL5o/pJCTg1UDHvNtlGBDC1LE5HM65TmnwEHo11xQepa61P1OsamP2N2Dkf
         0xzcftmadzAuhsYI9SSohaglKHL0rxBaKyAIOV1WFspXSHMsSL6NGdHfLlDritrlDQCs
         Jlz4by7tVn2gx2lf2ctUWW/yHS9xN7vRtPsMf9lH6WusqXWpm00IK+GXtDGyo1Q5ArJg
         /laOVJY8p+HYtYAvB4R58EjMJP1WzYK/MbRfnRWCfPQJeH7eOOcMJ1ghIIEcJXkKc9n+
         mNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p9c2wAENRuY7p6+WPlp+HWNM99SsckZW8p7A57PkQx0=;
        b=Toifj5Ap/6+lBB/1cHtpw7tzzIvTFJQCjLM5nockAzaGbcjycqEslCuyKDEjVVlycF
         PN3E8eqEhQ8e8rZ0CsUF3yMlixAt9UYV3jXKTp0KpxcEvzyx1Rv4iXV7VNVA8XItqM9Z
         A5dZg92CWckrYYeq7MAAutrQNd2w9XmCpi7jNLvw4gAXIOB4MCc2OtDoO2+o5pGSvc5D
         RgerFVsn8POiv/my94FvJYnnRRGWSgLRnOLb38oHnC1QK53OpIaM6wZ7RinpFBzsubju
         WnxzBcTJpOskz++wSCd6/kW0NQUFm1tf1OVN2HTgEpe7/x9cVq1OUDixuDhm5nSa1uSW
         NJtg==
X-Gm-Message-State: AOAM533AQHTpADLwz9CFDd0eqnIkfKiSSB/EsP/v4L0jHJzCmy9QeomA
        TeW8SSQdd9OkM+ss4uXzyJxosA==
X-Google-Smtp-Source: ABdhPJykFqTxcqi+YrboKl6kj90jYkEyMcnpNcBHMHKZMBxQSbb5AxgJeinN4HouQhagPUFLGGPFxg==
X-Received: by 2002:ac8:340b:: with SMTP id u11mr29587600qtb.38.1590424936931;
        Mon, 25 May 2020 09:42:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id v144sm15527634qka.69.2020.05.25.09.42.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 09:42:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdGB5-0003Ku-S9; Mon, 25 May 2020 13:42:15 -0300
Date:   Mon, 25 May 2020 13:42:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yamin Friedman <yaminf@mellanox.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH V3 2/4] RDMA/core: Introduce shared CQ pool API
Message-ID: <20200525164215.GA3226@ziepe.ca>
References: <1589892216-39283-1-git-send-email-yaminf@mellanox.com>
 <1589892216-39283-3-git-send-email-yaminf@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589892216-39283-3-git-send-email-yaminf@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 19, 2020 at 03:43:34PM +0300, Yamin Friedman wrote:

> +void ib_cq_pool_init(struct ib_device *dev)
> +{
> +	int i;

I generally rather see unsigned types used for unsigned values

> +
> +	spin_lock_init(&dev->cq_pools_lock);
> +	for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++)
> +		INIT_LIST_HEAD(&dev->cq_pools[i]);
> +}
> +
> +void ib_cq_pool_destroy(struct ib_device *dev)
> +{
> +	struct ib_cq *cq, *n;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++) {
> +		list_for_each_entry_safe(cq, n, &dev->cq_pools[i],
> +					 pool_entry) {
> +			cq->shared = false;
> +			ib_free_cq_user(cq, NULL);

WARN_ON cqe_used == 0?

> +		}
> +	}
> +
> +}
> +
> +static int ib_alloc_cqs(struct ib_device *dev, int nr_cqes,

unsigned types especially in function signatures please

> +struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int nr_cqe,
> +			     int comp_vector_hint,
> +			     enum ib_poll_context poll_ctx)
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
> +				 num_online_cpus());
> +	/* Project the affinty to the device completion vector range */
> +	if (comp_vector_hint < 0)
> +		vector = default_comp_vector++ % num_comp_vectors;
> +	else
> +		vector = comp_vector_hint % num_comp_vectors;

Modulo with signed types..

> +	/*
> +	 * Find the least used CQ with correct affinity and
> +	 * enough free CQ entries
> +	 */
> +	while (!found) {
> +		spin_lock_irqsave(&dev->cq_pools_lock, flags);
> +		list_for_each_entry(cq, &dev->cq_pools[poll_ctx - 1],
> +				    pool_entry) {
> +			/*
> +			 * Check to see if we have found a CQ with the
> +			 * correct completion vector
> +			 */
> +			if (vector != cq->comp_vector)
> +				continue;
> +			if (cq->cqe_used + nr_cqe > cq->cqe)
> +				continue;
> +			found = cq;
> +			break;
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

It doesn't look to me like this spinlock can be used from anywhere but
a user context, why is it an irqsave?

> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index d9f565a..0966f86 100644
> +++ b/drivers/infiniband/core/device.c
> @@ -1418,6 +1418,7 @@ int ib_register_device(struct ib_device *device, const char *name)
>  		device->ops.dealloc_driver = dealloc_fn;
>  		return ret;
>  	}
> +	ib_cq_pool_init(device);
>  	ib_device_put(device);

This look like wrong placement, it should be done before enable_device
as enable_device triggers ULPs t start using the device and they might
start allocating using this API.
  
>  	return 0;
> @@ -1446,6 +1447,7 @@ static void __ib_unregister_device(struct ib_device *ib_dev)
>  	if (!refcount_read(&ib_dev->refcount))
>  		goto out;
>  
> +	ib_cq_pool_destroy(ib_dev);
>  	disable_device(ib_dev);

similar issue, should be after disable_device as ULPs are still
running here

  
>  	/* Expedite removing unregistered pointers from the hash table */
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 1659131..d40604a 100644
> +++ b/include/rdma/ib_verbs.h
> @@ -1555,6 +1555,7 @@ enum ib_poll_context {
>  	IB_POLL_SOFTIRQ,	   /* poll from softirq context */
>  	IB_POLL_WORKQUEUE,	   /* poll from workqueue */
>  	IB_POLL_UNBOUND_WORKQUEUE, /* poll from unbound workqueue */
> +	IB_POLL_LAST,
>  };
>  
>  struct ib_cq {
> @@ -1564,9 +1565,12 @@ struct ib_cq {
>  	void                  (*event_handler)(struct ib_event *, void *);
>  	void                   *cq_context;
>  	int               	cqe;
> +	int			cqe_used;

unsigned

>  	atomic_t          	usecnt; /* count number of work queues */
>  	enum ib_poll_context	poll_ctx;
> +	int                     comp_vector;

and put new members in sane places, don't make holes, etc

>  	const struct uapi_definition   *driver_def;
> @@ -3952,6 +3960,33 @@ static inline int ib_req_notify_cq(struct ib_cq *cq,
>  	return cq->device->ops.req_notify_cq(cq, flags);
>  }
>  
> +/*
> + * ib_cq_pool_get() - Find the least used completion queue that matches
> + *     a given cpu hint (or least used for wild card affinity)
> + *     and fits nr_cqe
> + * @dev: rdma device
> + * @nr_cqe: number of needed cqe entries
> + * @comp_vector_hint: completion vector hint (-1) for the driver to assign
> + *   a comp vector based on internal counter
> + * @poll_ctx: cq polling context
> + *
> + * Finds a cq that satisfies @comp_vector_hint and @nr_cqe requirements and
> + * claim entries in it for us. In case there is no available cq, allocate
> + * a new cq with the requirements and add it to the device pool.
> + * IB_POLL_DIRECT cannot be used for shared cqs so it is not a valid value
> + * for @poll_ctx.
> + */
> +struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int nr_cqe,
> +			     int comp_vector_hint,
> +			     enum ib_poll_context poll_ctx);

kdoc comments belong in the C files please, and this isn't even in
proper kdoc format.

Jason
