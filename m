Return-Path: <linux-rdma+bounces-1471-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE8487DC70
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Mar 2024 07:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3C51F215F0
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Mar 2024 06:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D85DDD7;
	Sun, 17 Mar 2024 06:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kCZrSe9i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6E5B64B
	for <linux-rdma@vger.kernel.org>; Sun, 17 Mar 2024 06:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710657769; cv=none; b=bn5Z2veoBg1nNG/XpZyj9QMKrtEEm2BuoyeLjsShDj0u2q6yuQfgRLts+06REpZbIuLSk1xBXBBDfeuZdr6w32BdoAkSQU07sZ+ASivgSujPXXvE5wmqoe4HWLOQxahaISk2Dge+MTD0jagrxkupbfjSAwNMAZRhMHt4/OcmR40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710657769; c=relaxed/simple;
	bh=ZfsB+1pGYu6jYdMmo7oGRmrI/LfkTfi9rI98+u8YESQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/R+hPpLINlMbyS43nX9bpjFpqAbEuBYiJcWiDZrLU7kE2arnYWmkut12DDOZiAfZZhAX/TpQA92gmr+lLDHuyC3N946fT4qSiYzxJTndPkBIak7Srat4QyW9NDLmAEwu4kFtfBJmpt/8+m4lZ15G+BPkEqUFhPdbikXuoQnDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kCZrSe9i; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7956dd4b-3002-4073-aff7-f85ea436e6e0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710657764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6rCivtIRV/9sEb9gEWqQ4omSxbzwKf9Z9gpV6zV/+XQ=;
	b=kCZrSe9iTdkK9zkqDXk/6rY8dIzZ5nEEnt9vpnAQzmlzPc/jyh2x3AJxxQPI7+0tL4Pbef
	g1/0WMugpwmS+LJUz0ZTumG3J8MeBCiS3m434MYo0Caf5XF9ULBZiO3YFZCaQo8BE0IGZp
	ocQZhkKsyvdWb2Q+c0pfkfcREoPVbUo=
Date: Sun, 17 Mar 2024 07:42:41 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 1/4] RDMA/mana_ib: Introduce helpers to create
 and destroy mana queues
To: Konstantin Taranov <kotaranov@linux.microsoft.com>,
 kotaranov@microsoft.com, sharmaajay@microsoft.com, longli@microsoft.com,
 jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1710336299-27344-1-git-send-email-kotaranov@linux.microsoft.com>
 <1710336299-27344-2-git-send-email-kotaranov@linux.microsoft.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1710336299-27344-2-git-send-email-kotaranov@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/3/13 14:24, Konstantin Taranov 写道:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Intoduce helpers to work with mana ib queues (struct mana_ib_queue).
> A queue always consists of umem, gdma_region, and id.
> A queue can be used for a WQ or a CQ.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>   drivers/infiniband/hw/mana/main.c    | 40 ++++++++++++++++++++++++++++
>   drivers/infiniband/hw/mana/mana_ib.h | 10 +++++++
>   2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
> index 71e33feee..0ec940b97 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -237,6 +237,46 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
>   		ibdev_dbg(ibdev, "Failed to destroy doorbell page %d\n", ret);
>   }
>   
> +int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, u32 size,
> +			 struct mana_ib_queue *queue)
> +{
> +	struct ib_umem *umem;
> +	int err;
> +
> +	queue->umem = NULL;
> +	queue->id = INVALID_QUEUE_ID;
> +	queue->gdma_region = GDMA_INVALID_DMA_REGION;
> +
> +	umem = ib_umem_get(&mdev->ib_dev, addr, size, IB_ACCESS_LOCAL_WRITE);
> +	if (IS_ERR(umem)) {
> +		err = PTR_ERR(umem);
> +		ibdev_dbg(&mdev->ib_dev, "Failed to get umem, %d\n", err);
> +		return err;
> +	}
> +
> +	err = mana_ib_create_zero_offset_dma_region(mdev, umem, &queue->gdma_region);
> +	if (err) {
> +		ibdev_dbg(&mdev->ib_dev, "Failed to create dma region, %d\n", err);
> +		goto free_umem;
> +	}
> +	queue->umem = umem;
> +
> +	ibdev_dbg(&mdev->ib_dev,
> +		  "create_dma_region ret %d gdma_region 0x%llx\n",
> +		  err, queue->gdma_region);
> +
> +	return 0;
> +free_umem:
> +	ib_umem_release(umem);
> +	return err;
> +}
> +
> +void mana_ib_destroy_queue(struct mana_ib_dev *mdev, struct mana_ib_queue *queue)
> +{
> +	mana_ib_gd_destroy_dma_region(mdev, queue->gdma_region);

The function mana_ib_gd_destroy_dma_region will call 
mana_gd_destroy_dma_region. In the function mana_gd_destroy_dma_region, 
the function mana_gd_send_request will return the error -EPROTO.
The procedure is as below. So the function mana_ib_destroy_queue should 
also handle this error?

mana_ib_gd_destroy_dma_region --- > mana_gd_destroy_dma_region

  693 int mana_gd_destroy_dma_region(struct gdma_context *gc, u64 
dma_region_handle)
  694 {

...

  706         err = mana_gd_send_request(gc, sizeof(req), &req, 
sizeof(resp), &resp);
  707         if (err || resp.hdr.status) {
  708                 dev_err(gc->dev, "Failed to destroy DMA region: 
%d, 0x%x\n",
  709                         err, resp.hdr.status);
  710                 return -EPROTO;
  711         }

...

  714 }

Zhu Yanjun

> +	ib_umem_release(queue->umem);
> +}
> +
>   static int
>   mana_ib_gd_first_dma_region(struct mana_ib_dev *dev,
>   			    struct gdma_context *gc,
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
> index f83390eeb..859fd3bfc 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -45,6 +45,12 @@ struct mana_ib_adapter_caps {
>   	u32 max_inline_data_size;
>   };
>   
> +struct mana_ib_queue {
> +	struct ib_umem *umem;
> +	u64 gdma_region;
> +	u64 id;
> +};
> +
>   struct mana_ib_dev {
>   	struct ib_device ib_dev;
>   	struct gdma_dev *gdma_dev;
> @@ -169,6 +175,10 @@ int mana_ib_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
>   int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev,
>   				  mana_handle_t gdma_region);
>   
> +int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, u32 size,
> +			 struct mana_ib_queue *queue);
> +void mana_ib_destroy_queue(struct mana_ib_dev *mdev, struct mana_ib_queue *queue);
> +
>   struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
>   				struct ib_wq_init_attr *init_attr,
>   				struct ib_udata *udata);


