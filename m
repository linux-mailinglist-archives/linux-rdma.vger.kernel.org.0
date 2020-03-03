Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0580D177333
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2020 10:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgCCJ5R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Mar 2020 04:57:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:50954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgCCJ5R (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Mar 2020 04:57:17 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFFA320866;
        Tue,  3 Mar 2020 09:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583229436;
        bh=gAxKZOyNPR2fcthCAZ/bwdTPjRoBd+d4u/B7FZInYzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1BREo6ZkWhvu6YkFsWwFqWOUjD5jPGqEy5MHUOFWe+P57bbSt7UF89QTR9WlnI4pJ
         ZZEl98JdoDdakCHtA8mAP/cYeBilveeaXg89Ob6XcFBSIM29n0dY8vmdiiGUJE3UGD
         Ze5B6KB3P+O0Cbmx+0hy4LT+a2On8wU3dAEhR/p0=
Date:   Tue, 3 Mar 2020 11:57:13 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpuwang@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, dledford@redhat.com, jgg@ziepe.ca,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de, pankaj.gupta@cloud.ionos.com
Subject: Re: [PATCH v9 04/25] RDMA/rtrs: core: lib functions shared between
 client and server modules
Message-ID: <20200303095713.GK121803@unreal>
References: <20200221104721.350-1-jinpuwang@gmail.com>
 <20200221104721.350-5-jinpuwang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221104721.350-5-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 21, 2020 at 11:47:00AM +0100, Jack Wang wrote:
> From: Jack Wang <jinpu.wang@cloud.ionos.com>
>
> This is a set of library functions existing as a rtrs-core module,
> used by client and server modules.
>
> Mainly these functions wrap IB and RDMA calls and provide a bit higher
> abstraction for implementing of RTRS protocol on client or server
> sides.
>
> Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs.c | 594 +++++++++++++++++++++++++++++
>  1 file changed, 594 insertions(+)
>  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs.c

<...>

> +
> +static void dev_free(struct kref *ref)
> +{
> +	struct rtrs_rdma_dev_pd *pool;
> +	struct rtrs_ib_dev *dev;
> +
> +	dev = container_of(ref, typeof(*dev), ref);
> +	pool = dev->pool;
> +
> +	mutex_lock(&pool->mutex);
> +	list_del(&dev->entry);
> +	mutex_unlock(&pool->mutex);
> +
> +	if (pool->ops && pool->ops->deinit)
> +		pool->ops->deinit(dev);
> +
> +	ib_dealloc_pd(dev->ib_pd);
> +
> +	if (pool->ops && pool->ops->free)
> +		pool->ops->free(dev);
> +	else
> +		kfree(dev);
> +}
> +
> +int rtrs_ib_dev_put(struct rtrs_ib_dev *dev)
> +{
> +	return kref_put(&dev->ref, dev_free);
> +}
> +EXPORT_SYMBOL(rtrs_ib_dev_put);
> +
> +static int rtrs_ib_dev_get(struct rtrs_ib_dev *dev)
> +{
> +	return kref_get_unless_zero(&dev->ref);
> +}
> +
> +struct rtrs_ib_dev *
> +rtrs_ib_dev_find_or_add(struct ib_device *ib_dev,
> +			 struct rtrs_rdma_dev_pd *pool)
> +{
> +	struct rtrs_ib_dev *dev;
> +
> +	mutex_lock(&pool->mutex);

The scope of this mutex is unclear, you protected everything here with
this mutex, but in dev_free() you guarded list_del() only.

> +	list_for_each_entry(dev, &pool->list, entry) {
> +		if (dev->ib_dev->node_guid == ib_dev->node_guid &&
> +		    rtrs_ib_dev_get(dev))
> +			goto out_unlock;
> +	}
> +	if (pool->ops && pool->ops->alloc)
> +		dev = pool->ops->alloc();
> +	else
> +		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +	if (IS_ERR_OR_NULL(dev))
> +		goto out_err;
> +
> +	kref_init(&dev->ref);
> +	dev->pool = pool;
> +	dev->ib_dev = ib_dev;
> +	dev->ib_pd = ib_alloc_pd(ib_dev, pool->pd_flags);
> +	if (IS_ERR(dev->ib_pd))
> +		goto out_free_dev;
> +
> +	if (pool->ops && pool->ops->init && pool->ops->init(dev))
> +		goto out_free_pd;
> +
> +	list_add(&dev->entry, &pool->list);
> +out_unlock:
> +	mutex_unlock(&pool->mutex);
> +	return dev;
> +
> +out_free_pd:
> +	ib_dealloc_pd(dev->ib_pd);
> +out_free_dev:
> +	if (pool->ops && pool->ops->free)
> +		pool->ops->free(dev);
> +	else
> +		kfree(dev);
> +out_err:
> +	mutex_unlock(&pool->mutex);
> +	return NULL;
> +}
> +EXPORT_SYMBOL(rtrs_ib_dev_find_or_add);
> --
> 2.17.1
>
