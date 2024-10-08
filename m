Return-Path: <linux-rdma+bounces-5314-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 787D8994BF9
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 14:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C596281653
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 12:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D661DE2A5;
	Tue,  8 Oct 2024 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CNRkBjN4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2E71C2420
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391729; cv=none; b=mwIazmwdXSq2tDncHNODg/PjFsfROtlxvfRF3+86QYq8sTWTpLxhBc7c+kddSH8FMEKZOmCpbmbaFQOWCm0hO7MkQ6B5+Sx4CY8n7ajWGkZLMSriynjNXgpHWc4Ju1zNc86RtnqFMT3pc4Sxu1UEhaB+GRWqOTSfjy1Ia4FvEVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391729; c=relaxed/simple;
	bh=w3mNVLtrh62hZK98Obdn4B9gHmZQFeQkVohl8ZEHjfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qSiwTfNAc2iiCUmhz3WrDnbCpgaw5A1rw4TVKSq8Nsj+brNY2YqIr8YMTMKIts03EGqcWLp4e89DMOVkRdK2JLNRhSXhAnbCFRUTF9GTv/wMQ14DyfFcR4Wsa3/k22DLVq+9dc5Zf66Wk8WEpG0fZOc1Jjcq8nyP5kh4porV3RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CNRkBjN4; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a5036e8c-4981-4910-a805-34fcc0521def@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728391724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7a9rZ2+hVW4oSbI9GrxYXDIQ3Oie1AJu5JfXm84QjYs=;
	b=CNRkBjN4PVgZJOFOTm2bqOcip2lR8EAgQHt7G6ObSTAxopl+uepIIYGA4OGqXNc/DDOkb2
	R6w+7hwnk4xpfJhE2/IJEnKdoPwizQXy1jUG5DgXK9+PdCykFyz06XL4qrs6spPlSv1jQS
	TcF+UYAb/92tT17QJKJo9/mgLdckUmo=
Date: Tue, 8 Oct 2024 20:48:18 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] RDMA/srpt: Make slab cache names unique
To: Bart Van Assche <bvanassche@acm.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20241007203726.3076222-1-bvanassche@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20241007203726.3076222-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/10/8 4:37, Bart Van Assche 写道:
> Since commit 4c39529663b9 ("slab: Warn on duplicate cache names when
> DEBUG_VM=y"), slab complains about duplicate cache names. Hence this
> patch. The approach is as follows:
> - Maintain an xarray with the slab size as index and a reference count
>    and a kmem_cache pointer as contents. Use srpt-${slab_size} as kmem
>    cache name.
> - Use 512-byte alignment for all slabs instead of only for some of the
>    slabs.
> - Increment the reference count instead of calling kmem_cache_create().
> - Decrement the reference count instead of calling kmem_cache_destroy().
> 
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/linux-block/xpe6bea7rakpyoyfvspvin2dsozjmjtjktpph7rep3h25tv7fb@ooz4cu5z6bq6/
> Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Fixes: 5dabcd0456d7 ("RDMA/srpt: Add support for immediate data")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/infiniband/ulp/srpt/ib_srpt.c | 79 +++++++++++++++++++++++----
>   1 file changed, 67 insertions(+), 12 deletions(-)
> 
> Changes compared to v1:
>   - Instead of using an ida to make slab names unique, maintain an xarray
>     with the slab size as index and the slab pointer and a reference count as
>     contents.
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 9632afbd727b..cc18179693bf 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -68,6 +68,8 @@ MODULE_LICENSE("Dual BSD/GPL");
>   static u64 srpt_service_guid;
>   static DEFINE_SPINLOCK(srpt_dev_lock);	/* Protects srpt_dev_list. */
>   static LIST_HEAD(srpt_dev_list);	/* List of srpt_device structures. */
> +static DEFINE_MUTEX(srpt_mc_mutex);	/* Protects srpt_memory_caches. */

Not sure if a function mutex_destroy is also needed in this commit or not.

Zhu Yanjun

> +static DEFINE_XARRAY(srpt_memory_caches); /* See also srpt_memory_cache_entry */
>   
>   static unsigned srp_max_req_size = DEFAULT_MAX_REQ_SIZE;
>   module_param(srp_max_req_size, int, 0444);
> @@ -105,6 +107,62 @@ static void srpt_recv_done(struct ib_cq *cq, struct ib_wc *wc);
>   static void srpt_send_done(struct ib_cq *cq, struct ib_wc *wc);
>   static void srpt_process_wait_list(struct srpt_rdma_ch *ch);
>   
> +/* Type of the entries in srpt_memory_caches. */
> +struct srpt_memory_cache_entry {
> +	refcount_t ref;
> +	struct kmem_cache *c;
> +};
> +
> +static struct kmem_cache *srpt_cache_get(unsigned int object_size)
> +{
> +	struct srpt_memory_cache_entry *e;
> +	char name[32];
> +
> +	guard(mutex)(&srpt_mc_mutex);
> +	e = xa_load(&srpt_memory_caches, object_size);
> +	if (e) {
> +		refcount_inc(&e->ref);
> +		return e->c;
> +	}
> +	snprintf(name, sizeof(name), "srpt-%u", object_size);
> +	e = kmalloc(sizeof(*e), GFP_KERNEL);
> +	if (!e)
> +		return NULL;
> +	refcount_set(&e->ref, 1);
> +	e->c = kmem_cache_create(name, object_size, /*align=*/512, 0, NULL);
> +	if (!e->c)
> +		goto free_entry;
> +	if (IS_ERR(xa_store(&srpt_memory_caches, object_size, e, GFP_KERNEL)))
> +		goto destroy_cache;
> +	return e->c;
> +
> +destroy_cache:
> +	kmem_cache_destroy(e->c);
> +
> +free_entry:
> +	kfree(e);
> +	return NULL;
> +}
> +
> +static void srpt_cache_put(struct kmem_cache *c)
> +{
> +	struct srpt_memory_cache_entry *e = NULL;
> +	unsigned long object_size;
> +
> +	guard(mutex)(&srpt_mc_mutex);
> +	xa_for_each(&srpt_memory_caches, object_size, e)
> +		if (e->c == c)
> +			break;
> +	if (WARN_ON_ONCE(!e))
> +		return;
> +	WARN_ON_ONCE(e->c != c);
> +	if (!refcount_dec_and_test(&e->ref))
> +		return;
> +	WARN_ON_ONCE(xa_erase(&srpt_memory_caches, object_size) != e);
> +	kmem_cache_destroy(e->c);
> +	kfree(e);
> +}
> +
>   /*
>    * The only allowed channel state changes are those that change the channel
>    * state into a state with a higher numerical value. Hence the new > prev test.
> @@ -2119,13 +2177,13 @@ static void srpt_release_channel_work(struct work_struct *w)
>   			     ch->sport->sdev, ch->rq_size,
>   			     ch->rsp_buf_cache, DMA_TO_DEVICE);
>   
> -	kmem_cache_destroy(ch->rsp_buf_cache);
> +	srpt_cache_put(ch->rsp_buf_cache);
>   
>   	srpt_free_ioctx_ring((struct srpt_ioctx **)ch->ioctx_recv_ring,
>   			     sdev, ch->rq_size,
>   			     ch->req_buf_cache, DMA_FROM_DEVICE);
>   
> -	kmem_cache_destroy(ch->req_buf_cache);
> +	srpt_cache_put(ch->req_buf_cache);
>   
>   	kref_put(&ch->kref, srpt_free_ch);
>   }
> @@ -2245,8 +2303,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>   	INIT_LIST_HEAD(&ch->cmd_wait_list);
>   	ch->max_rsp_size = ch->sport->port_attrib.srp_max_rsp_size;
>   
> -	ch->rsp_buf_cache = kmem_cache_create("srpt-rsp-buf", ch->max_rsp_size,
> -					      512, 0, NULL);
> +	ch->rsp_buf_cache = srpt_cache_get(ch->max_rsp_size);
>   	if (!ch->rsp_buf_cache)
>   		goto free_ch;
>   
> @@ -2280,8 +2337,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>   		alignment_offset = round_up(imm_data_offset, 512) -
>   			imm_data_offset;
>   		req_sz = alignment_offset + imm_data_offset + srp_max_req_size;
> -		ch->req_buf_cache = kmem_cache_create("srpt-req-buf", req_sz,
> -						      512, 0, NULL);
> +		ch->req_buf_cache = srpt_cache_get(req_sz);
>   		if (!ch->req_buf_cache)
>   			goto free_rsp_ring;
>   
> @@ -2478,7 +2534,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>   			     ch->req_buf_cache, DMA_FROM_DEVICE);
>   
>   free_recv_cache:
> -	kmem_cache_destroy(ch->req_buf_cache);
> +	srpt_cache_put(ch->req_buf_cache);
>   
>   free_rsp_ring:
>   	srpt_free_ioctx_ring((struct srpt_ioctx **)ch->ioctx_ring,
> @@ -2486,7 +2542,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>   			     ch->rsp_buf_cache, DMA_TO_DEVICE);
>   
>   free_rsp_cache:
> -	kmem_cache_destroy(ch->rsp_buf_cache);
> +	srpt_cache_put(ch->rsp_buf_cache);
>   
>   free_ch:
>   	if (rdma_cm_id)
> @@ -3055,7 +3111,7 @@ static void srpt_free_srq(struct srpt_device *sdev)
>   	srpt_free_ioctx_ring((struct srpt_ioctx **)sdev->ioctx_ring, sdev,
>   			     sdev->srq_size, sdev->req_buf_cache,
>   			     DMA_FROM_DEVICE);
> -	kmem_cache_destroy(sdev->req_buf_cache);
> +	srpt_cache_put(sdev->req_buf_cache);
>   	sdev->srq = NULL;
>   }
>   
> @@ -3082,8 +3138,7 @@ static int srpt_alloc_srq(struct srpt_device *sdev)
>   	pr_debug("create SRQ #wr= %d max_allow=%d dev= %s\n", sdev->srq_size,
>   		 sdev->device->attrs.max_srq_wr, dev_name(&device->dev));
>   
> -	sdev->req_buf_cache = kmem_cache_create("srpt-srq-req-buf",
> -						srp_max_req_size, 0, 0, NULL);
> +	sdev->req_buf_cache = srpt_cache_get(srp_max_req_size);
>   	if (!sdev->req_buf_cache)
>   		goto free_srq;
>   
> @@ -3105,7 +3160,7 @@ static int srpt_alloc_srq(struct srpt_device *sdev)
>   	return 0;
>   
>   free_cache:
> -	kmem_cache_destroy(sdev->req_buf_cache);
> +	srpt_cache_put(sdev->req_buf_cache);
>   
>   free_srq:
>   	ib_destroy_srq(srq);


