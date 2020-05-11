Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5BF1CD0DA
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 06:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbgEKEh7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 00:37:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgEKEh7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 00:37:59 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EAF020820;
        Mon, 11 May 2020 04:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589171878;
        bh=g98qmx1RLHAh9jqdMgIpfFTqXmfhQbclOX4yUPfF37o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZzhrDcWc2aasx5vvco9aBCNK6priZ7LN1R/RFb3t1X9iC3vRzdUtzlv7Cdie1S5s5
         5UrA3V2fS5j8sAbevjzervLfsYE6QBE2GfKQTmhiOOVjZ62V7Vfawy5tHYIGgiiNG2
         3EUoFbFFrNWJspjF386flqB6A4F81ZSu74rbaEHA=
Date:   Mon, 11 May 2020 07:37:53 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yamin Friedman <yaminf@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/4] infiniband/core: Add protection for shared CQs used
 by ULPs
Message-ID: <20200511043753.GA356445@unreal>
References: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
 <1589122557-88996-2-git-send-email-yaminf@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589122557-88996-2-git-send-email-yaminf@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 10, 2020 at 05:55:54PM +0300, Yamin Friedman wrote:
> A pre-step for adding shared CQs. Add the infra-structure to prevent
> shared CQ users from altering the CQ configurations. For now all cqs are
> marked as private (non-shared). The core driver should use the new force
> functions to perform resize/destroy/moderation changes that are not
> allowed for users of shared CQs.
>
> Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
> Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
> ---
>  drivers/infiniband/core/cq.c    | 25 ++++++++++++++++++-------
>  drivers/infiniband/core/verbs.c | 37 ++++++++++++++++++++++++++++++++++---
>  include/rdma/ib_verbs.h         | 20 +++++++++++++++++++-
>  3 files changed, 71 insertions(+), 11 deletions(-)

infiniband/core -> RDMA/core

>
> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> index 4f25b24..443a9cd 100644
> --- a/drivers/infiniband/core/cq.c
> +++ b/drivers/infiniband/core/cq.c
> @@ -37,6 +37,7 @@ static void ib_cq_rdma_dim_work(struct work_struct *w)
>  {
>  	struct dim *dim = container_of(w, struct dim, work);
>  	struct ib_cq *cq = dim->priv;
> +	int ret;
>
>  	u16 usec = rdma_dim_prof[dim->profile_ix].usec;
>  	u16 comps = rdma_dim_prof[dim->profile_ix].comps;
> @@ -44,7 +45,10 @@ static void ib_cq_rdma_dim_work(struct work_struct *w)
>  	dim->state = DIM_START_MEASURE;
>
>  	trace_cq_modify(cq, comps, usec);
> -	cq->device->ops.modify_cq(cq, comps, usec);
> +	ret = rdma_set_cq_moderation_force(cq, comps, usec);
> +	if (ret)
> +		WARN_ONCE(1, "Failed set moderation for CQ 0x%p\n", cq);

First WARN_ONCE(ret, ...), second no to pointer address print and third
this dump stack won't help, because CQ moderation will fail for many
reasons unrelated to the caller.

> +
>  }
>
>  static void rdma_dim_init(struct ib_cq *cq)
> @@ -218,6 +222,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
>  	cq->cq_context = private;
>  	cq->poll_ctx = poll_ctx;
>  	atomic_set(&cq->usecnt, 0);
> +	cq->cq_type = IB_CQ_PRIVATE;

I would say it should be opposite, default is not shared CQ and only
pool sets something specific to mark that it is shared.

>
>  	cq->wc = kmalloc_array(IB_POLL_BATCH, sizeof(*cq->wc), GFP_KERNEL);
>  	if (!cq->wc)
> @@ -300,12 +305,7 @@ struct ib_cq *__ib_alloc_cq_any(struct ib_device *dev, void *private,
>  }
>  EXPORT_SYMBOL(__ib_alloc_cq_any);
>
> -/**
> - * ib_free_cq_user - free a completion queue
> - * @cq:		completion queue to free.
> - * @udata:	User data or NULL for kernel object
> - */
> -void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
> +static void _ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>  {
>  	if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
>  		return;
> @@ -333,4 +333,15 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>  	kfree(cq->wc);
>  	kfree(cq);
>  }
> +
> +/**
> + * ib_free_cq_user - free a completion queue
> + * @cq:		completion queue to free.
> + * @udata:	User data or NULL for kernel object
> + */
> +void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
> +{
> +	if (!WARN_ON_ONCE(cq->cq_type != IB_CQ_PRIVATE))
> +		_ib_free_cq_user(cq, udata);
> +}

It is not preferable kernel style - not on WARN_ON_ONCE() and do
something later.

>  EXPORT_SYMBOL(ib_free_cq_user);
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index bf0249f..39c012f 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -1988,15 +1988,29 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
>  }
>  EXPORT_SYMBOL(__ib_create_cq);
>
> -int rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count, u16 cq_period)
> +static int _rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count,
> +				   u16 cq_period)
>  {
>  	return cq->device->ops.modify_cq ?
>  		cq->device->ops.modify_cq(cq, cq_count,
>  					  cq_period) : -EOPNOTSUPP;
>  }
> +
> +int rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count, u16 cq_period)
> +{
> +	if (WARN_ON_ONCE(cq->cq_type != IB_CQ_PRIVATE))
> +		return -EOPNOTSUPP;
> +	else
> +		return _rdma_set_cq_moderation(cq, cq_count, cq_period);
> +}
>  EXPORT_SYMBOL(rdma_set_cq_moderation);
>
> -int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
> +int rdma_set_cq_moderation_force(struct ib_cq *cq, u16 cq_count, u16 cq_period)
> +{
> +	return _rdma_set_cq_moderation(cq, cq_count, cq_period);
> +}

All these one liners makes no sense, the call to
_rdma_set_cq_moderation() in this function and above is exactly the
same. It means there is no need in specific function.

> +
> +static int _ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>  {
>  	if (atomic_read(&cq->usecnt))
>  		return -EBUSY;
> @@ -2004,15 +2018,32 @@ int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>  	rdma_restrack_del(&cq->res);
>  	cq->device->ops.destroy_cq(cq, udata);
>  	kfree(cq);
> +

Not relevant

>  	return 0;
>  }
> +
> +int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
> +{
> +	if (WARN_ON_ONCE(cq->cq_type != IB_CQ_PRIVATE))
> +		return -EOPNOTSUPP;
> +	else
> +		return _ib_destroy_cq_user(cq, udata);
> +}
>  EXPORT_SYMBOL(ib_destroy_cq_user);

I would expect symmetric API, you can call to create_cq_user for your
pool, but can't call to destroy_cq_user, am I right?


>
> -int ib_resize_cq(struct ib_cq *cq, int cqe)
> +static int _ib_resize_cq(struct ib_cq *cq, int cqe)
>  {
>  	return cq->device->ops.resize_cq ?
>  		cq->device->ops.resize_cq(cq, cqe, NULL) : -EOPNOTSUPP;
>  }
> +
> +int ib_resize_cq(struct ib_cq *cq, int cqe)
> +{
> +	if (WARN_ON_ONCE(cq->cq_type != IB_CQ_PRIVATE))
> +		return -EOPNOTSUPP;
> +	else
> +		return _ib_resize_cq(cq, cqe);
> +}
>  EXPORT_SYMBOL(ib_resize_cq);


It is not kernel style and probably dump_stack is not needed too.

>
>  /* Memory regions */
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 4c488ca..c889415 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -1557,6 +1557,10 @@ enum ib_poll_context {
>  	IB_POLL_UNBOUND_WORKQUEUE, /* poll from unbound workqueue */
>  };
>
> +enum ib_cq_type {
> +	IB_CQ_PRIVATE,	/* CQ will be used by only one user */
> +};

Do you see another CQ types? If not it should not be a type but boolean.
If yes, PRIVATE is not really type but property.

> +
>  struct ib_cq {
>  	struct ib_device       *device;
>  	struct ib_ucq_object   *uobject;
> @@ -1582,6 +1586,7 @@ struct ib_cq {
>  	 * Implementation details of the RDMA core, don't use in drivers:
>  	 */
>  	struct rdma_restrack_entry res;
> +	enum ib_cq_type cq_type;
>  };
>
>  struct ib_srq {
> @@ -3832,6 +3837,7 @@ static inline struct ib_cq *ib_alloc_cq_any(struct ib_device *dev,
>   * @cq: The CQ to free
>   *
>   * NOTE: for user cq use ib_free_cq_user with valid udata!
> + * NOTE: this will fail for shared cqs
>   */
>  static inline void ib_free_cq(struct ib_cq *cq)
>  {
> @@ -3881,7 +3887,19 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
>  int rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count, u16 cq_period);
>
>  /**
> - * ib_destroy_cq_user - Destroys the specified CQ.
> + * rdma_set_cq_moderation_force - Modifies moderation params of the CQ.
> + * Meant for use in core driver to work for shared CQs.
> + * @cq: The CQ to modify.
> + * @cq_count: number of CQEs that will trigger an event
> + * @cq_period: max period of time in usec before triggering an event
> + *
> + */
> +int rdma_set_cq_moderation_force(struct ib_cq *cq, u16 cq_count,
> +				 u16 cq_period);
> +
> +/**
> + * ib_destroy_cq_user - Destroys the specified CQ. If the CQ is not
> + * PRIVATE this function will fail.

It is not only fail, but print huge dump_stack.

>   * @cq: The CQ to destroy.
>   * @udata: Valid user data or NULL for kernel objects
>   */
> --
> 1.8.3.1
>
