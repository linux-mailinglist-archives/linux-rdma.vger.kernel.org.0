Return-Path: <linux-rdma+bounces-5264-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DA69928A4
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 12:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6277B1F23F8D
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 10:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF9D1DD88A;
	Mon,  7 Oct 2024 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PVO1xA7v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DB11DD86C
	for <linux-rdma@vger.kernel.org>; Mon,  7 Oct 2024 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728294721; cv=none; b=MXfDXS1Z3saoi3x2iSLh36jxN6brcQotbf7Oq3L7USc2vzgp6u8H0cH99xxv1wcnKMDoTOY5kCfv/zvvAN76E3BtkoLwcLgKOGqWbY90Dlis4d2Mhf9Prm+T5EL82djJ4kF6YasFrxkqN6EHC7ro0zJcSTmKAqBHSm4PKPENryI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728294721; c=relaxed/simple;
	bh=28fEFY/hXxLCXhmVadIh9LyjLJaQY6Kwc8LMdw3jzXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3GdQvu9yLM2qT72xfRhbh85ps118GHsrXrhoBg3GxmRR/61lctzhe3qlKsLCChxgOEbnJHEAXqSaXHNDqg7nvbAZs0iKIUHIgtWmhFysjVtr7tyJeQH/IPSpNV7TWsF0goYIpUn3/ZxrQV3CSsyMxmrgCcCrNbyLzsJsiJCPGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PVO1xA7v; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3108a1da-3eb3-4b9d-8063-eab25c7c2f29@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728294716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gcSzrW1BnujUdglpblDDDF1lftH52B5+5zWrzMqP+B0=;
	b=PVO1xA7vijKPtuXOjS6KwYYbkZFK/RqX3iR8e8Mokkan4S6LepxdfwkaWNdPTUR6J9FVol
	JcW4a+4ydTim55sCtFQgZloAPOR+o3sZDQ027mufpCcgjOQEw+l4Q/du2JW/LIsQZB34Xa
	3LcuEwKp/2utzRN+a+8/md1eBovEBwk=
Date: Mon, 7 Oct 2024 17:51:45 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/srpt: Make slab cache names unique
To: Bart Van Assche <bvanassche@acm.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20241004173730.1932859-1-bvanassche@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20241004173730.1932859-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/10/5 1:37, Bart Van Assche 写道:
> Since commit 4c39529663b9 ("slab: Warn on duplicate cache names when
> DEBUG_VM=y"), slab complains about duplicate cache names. Hence this
> patch that makes cache names unique.
> 
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/linux-block/xpe6bea7rakpyoyfvspvin2dsozjmjtjktpph7rep3h25tv7fb@ooz4cu5z6bq6/
> Fixes: 5dabcd0456d7 ("RDMA/srpt: Add support for immediate data")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/infiniband/ulp/srpt/ib_srpt.c | 32 ++++++++++++++++++++++-----
>   drivers/infiniband/ulp/srpt/ib_srpt.h |  6 +++++
>   2 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 9632afbd727b..4cb462074f00 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -41,6 +41,7 @@
>   #include <linux/string.h>
>   #include <linux/delay.h>
>   #include <linux/atomic.h>
> +#include <linux/idr.h>
>   #include <linux/inet.h>
>   #include <rdma/ib_cache.h>
>   #include <scsi/scsi_proto.h>
> @@ -68,6 +69,7 @@ MODULE_LICENSE("Dual BSD/GPL");
>   static u64 srpt_service_guid;
>   static DEFINE_SPINLOCK(srpt_dev_lock);	/* Protects srpt_dev_list. */
>   static LIST_HEAD(srpt_dev_list);	/* List of srpt_device structures. */
> +static DEFINE_IDA(cache_ida);
>   
>   static unsigned srp_max_req_size = DEFAULT_MAX_REQ_SIZE;
>   module_param(srp_max_req_size, int, 0444);
> @@ -2120,12 +2122,14 @@ static void srpt_release_channel_work(struct work_struct *w)
>   			     ch->rsp_buf_cache, DMA_TO_DEVICE);
>   
>   	kmem_cache_destroy(ch->rsp_buf_cache);
> +	ida_free(&cache_ida, ch->rsp_buf_cache_idx);
>   
>   	srpt_free_ioctx_ring((struct srpt_ioctx **)ch->ioctx_recv_ring,
>   			     sdev, ch->rq_size,
>   			     ch->req_buf_cache, DMA_FROM_DEVICE);
>   
>   	kmem_cache_destroy(ch->req_buf_cache);
> +	ida_free(&cache_ida, ch->req_buf_cache_idx);
>   
>   	kref_put(&ch->kref, srpt_free_ch);
>   }
> @@ -2164,6 +2168,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>   	u32 it_iu_len;
>   	int i, tag_num, tag_size, ret;
>   	struct srpt_tpg *stpg;
> +	char cache_name[32];

The local variable cache_name is not zeroed.

>   
>   	WARN_ON_ONCE(irqs_disabled());
>   
> @@ -2245,8 +2250,11 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>   	INIT_LIST_HEAD(&ch->cmd_wait_list);
>   	ch->max_rsp_size = ch->sport->port_attrib.srp_max_rsp_size;
>   
> -	ch->rsp_buf_cache = kmem_cache_create("srpt-rsp-buf", ch->max_rsp_size,
> -					      512, 0, NULL);
> +	ch->rsp_buf_cache_idx = ida_alloc(&cache_ida, GFP_KERNEL);
> +	snprintf(cache_name, sizeof(cache_name), "srpt-rsp-buf-%u",
> +		 ch->rsp_buf_cache_idx);

IIRC, snprintf will append a '\0' to the string "cache_name". So this 
string "cache_name" will be used correctly even though this string 
"cache_name" is not zeroed before it is used.

> +	ch->rsp_buf_cache =
> +		kmem_cache_create(cache_name, ch->max_rsp_size, 512, 0, NULL);
>   	if (!ch->rsp_buf_cache)
>   		goto free_ch;
>   
> @@ -2280,8 +2288,11 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>   		alignment_offset = round_up(imm_data_offset, 512) -
>   			imm_data_offset;
>   		req_sz = alignment_offset + imm_data_offset + srp_max_req_size;
> -		ch->req_buf_cache = kmem_cache_create("srpt-req-buf", req_sz,
> -						      512, 0, NULL);
> +		ch->req_buf_cache_idx = ida_alloc(&cache_ida, GFP_KERNEL);
> +		snprintf(cache_name, sizeof(cache_name), "srpt-req-buf-%u",
> +			 ch->req_buf_cache_idx);

Ditto

> +		ch->req_buf_cache =
> +			kmem_cache_create(cache_name, req_sz, 512, 0, NULL);
>   		if (!ch->req_buf_cache)
>   			goto free_rsp_ring;
>   
> @@ -2479,6 +2490,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>   
>   free_recv_cache:
>   	kmem_cache_destroy(ch->req_buf_cache);
> +	ida_free(&cache_ida, ch->req_buf_cache_idx);
>   
>   free_rsp_ring:
>   	srpt_free_ioctx_ring((struct srpt_ioctx **)ch->ioctx_ring,
> @@ -2487,6 +2499,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>   
>   free_rsp_cache:
>   	kmem_cache_destroy(ch->rsp_buf_cache);
> +	ida_free(&cache_ida, ch->rsp_buf_cache_idx);
>   
>   free_ch:
>   	if (rdma_cm_id)
> @@ -3056,6 +3069,7 @@ static void srpt_free_srq(struct srpt_device *sdev)
>   			     sdev->srq_size, sdev->req_buf_cache,
>   			     DMA_FROM_DEVICE);
>   	kmem_cache_destroy(sdev->req_buf_cache);
> +	ida_free(&cache_ida, sdev->req_buf_cache_idx);
>   	sdev->srq = NULL;
>   }
>   
> @@ -3070,6 +3084,7 @@ static int srpt_alloc_srq(struct srpt_device *sdev)
>   	};
>   	struct ib_device *device = sdev->device;
>   	struct ib_srq *srq;
> +	char cache_name[32];

Ditto

>   	int i;
>   
>   	WARN_ON_ONCE(sdev->srq);
> @@ -3082,8 +3097,11 @@ static int srpt_alloc_srq(struct srpt_device *sdev)
>   	pr_debug("create SRQ #wr= %d max_allow=%d dev= %s\n", sdev->srq_size,
>   		 sdev->device->attrs.max_srq_wr, dev_name(&device->dev));
>   
> -	sdev->req_buf_cache = kmem_cache_create("srpt-srq-req-buf",
> -						srp_max_req_size, 0, 0, NULL);
> +	sdev->req_buf_cache_idx = ida_alloc(&cache_ida, GFP_KERNEL);
> +	snprintf(cache_name, sizeof(cache_name), "srpt-srq-req-buf-%u",
> +		 sdev->req_buf_cache_idx);

Ditto

> +	sdev->req_buf_cache =
> +		kmem_cache_create(cache_name, srp_max_req_size, 0, 0, NULL);
>   	if (!sdev->req_buf_cache)
>   		goto free_srq;
>   
> @@ -3106,6 +3124,7 @@ static int srpt_alloc_srq(struct srpt_device *sdev)
>   
>   free_cache:
>   	kmem_cache_destroy(sdev->req_buf_cache);
> +	ida_free(&cache_ida, sdev->req_buf_cache_idx);
>   
>   free_srq:
>   	ib_destroy_srq(srq);
> @@ -3926,6 +3945,7 @@ static void __exit srpt_cleanup_module(void)
>   		rdma_destroy_id(rdma_cm_id);
>   	ib_unregister_client(&srpt_client);
>   	target_unregister_template(&srpt_template);
> +	ida_destroy(&cache_ida);
>   }
>   
>   module_init(srpt_init_module);
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.h b/drivers/infiniband/ulp/srpt/ib_srpt.h
> index 4c46b301eea1..6d10cd7c9f21 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.h
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
> @@ -276,6 +276,8 @@ enum rdma_ch_state {
>    * @state:         channel state. See also enum rdma_ch_state.
>    * @using_rdma_cm: Whether the RDMA/CM or IB/CM is used for this channel.
>    * @processing_wait_list: Whether or not cmd_wait_list is being processed.
> + * @rsp_buf_cache_idx: @rsp_buf_cache index for slab.
> + * @req_buf_cache_idx: @req_buf_cache index for slab.
>    * @rsp_buf_cache: kmem_cache for @ioctx_ring.
>    * @ioctx_ring:    Send ring.
>    * @req_buf_cache: kmem_cache for @ioctx_recv_ring.
> @@ -316,6 +318,8 @@ struct srpt_rdma_ch {
>   	u16			imm_data_offset;
>   	spinlock_t		spinlock;
>   	enum rdma_ch_state	state;
> +	int			rsp_buf_cache_idx;
> +	int			req_buf_cache_idx;

Thanks.
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun
>   	struct kmem_cache	*rsp_buf_cache;
>   	struct srpt_send_ioctx	**ioctx_ring;
>   	struct kmem_cache	*req_buf_cache;
> @@ -443,6 +447,7 @@ struct srpt_port {
>    * @srq_size:      SRQ size.
>    * @sdev_mutex:	   Serializes use_srq changes.
>    * @use_srq:       Whether or not to use SRQ.
> + * @req_buf_cache_idx: @req_buf_cache index for slab.
>    * @req_buf_cache: kmem_cache for @ioctx_ring buffers.
>    * @ioctx_ring:    Per-HCA SRQ.
>    * @event_handler: Per-HCA asynchronous IB event handler.
> @@ -459,6 +464,7 @@ struct srpt_device {
>   	int			srq_size;
>   	struct mutex		sdev_mutex;
>   	bool			use_srq;
> +	int			req_buf_cache_idx;
>   	struct kmem_cache	*req_buf_cache;
>   	struct srpt_recv_ioctx	**ioctx_ring;
>   	struct ib_event_handler	event_handler;


