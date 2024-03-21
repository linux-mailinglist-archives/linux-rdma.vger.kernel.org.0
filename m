Return-Path: <linux-rdma+bounces-1495-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D24B3881C87
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Mar 2024 07:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885241F2268D
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Mar 2024 06:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25963FE42;
	Thu, 21 Mar 2024 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rVq3RGYO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F8E3C489
	for <linux-rdma@vger.kernel.org>; Thu, 21 Mar 2024 06:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711003079; cv=none; b=iQEKcuLEi85DvNgeGI2ZXJxF8dmjk2cNQTRYKnL25k+kEDbYEMKUqLSBKhBzy+9vBumM/uglZL7/QF1JuLXLADkzxM7+Z/JTDX4xu41u3ZB1Tu5YHwrzkFboGh0wp6w8zuf4sVlf856U/gOGSI7VZHpr6bpCWhtAUJd19lmJiiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711003079; c=relaxed/simple;
	bh=+6OX9AAFD/A2shwhkbexJL9wxEW4EZcX6kD05LvwinA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQoNk7PxWDv5L75yRA54wfCObgGgErAcRv7Jf80YX2JoOMvFQr5q3W7Yuw3Qmj1ezpiyXiX+ZHA+PX4sQsJye95rhTpfzZZKVnm+TdlnDdfSCLVbnyapucjKARCr0+8nMlZi4zxua/b4ex+sgRhHrJYpeqQXjob/B+6Kdgx1HrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rVq3RGYO; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d5d9a8a5-5929-4a06-afef-95f35a1fcefc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711003074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OIf1hdM5OpPSavxQGmay0F2nG/wud8USfVO0Ik8WoYs=;
	b=rVq3RGYOWIVY0l14+uwhPsKWVOBbRMfjwxBEOG+jXzTKm8XvM47sWMhP3PaJhuYDN5Y9a9
	bR4zVedx1B81N36Y2NsnoahoJe6OJ3qVMzd01vH51MYczAWcYhmAsNW/qGZRzlLY4K0/Hb
	ctPjCCnmrb93PxNANGL4GTFutfssftk=
Date: Thu, 21 Mar 2024 07:37:50 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next v2 1/4] RDMA/mana_ib: Introduce helpers to
 create and destroy mana queues
To: Konstantin Taranov <kotaranov@linux.microsoft.com>,
 kotaranov@microsoft.com, sharmaajay@microsoft.com, longli@microsoft.com,
 jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1710867613-4798-1-git-send-email-kotaranov@linux.microsoft.com>
 <1710867613-4798-2-git-send-email-kotaranov@linux.microsoft.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1710867613-4798-2-git-send-email-kotaranov@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/3/19 18:00, Konstantin Taranov 写道:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Intoduce helpers to work with mana ib queues (struct mana_ib_queue).
> A queue always consists of umem, gdma_region, and id.
> A queue can become a WQ or a CQ.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>   drivers/infiniband/hw/mana/main.c    | 43 ++++++++++++++++++++++++++++
>   drivers/infiniband/hw/mana/mana_ib.h | 10 +++++++
>   2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
> index 71e33feee..4524c6b80 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -237,6 +237,49 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
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
> +	/* Ignore return code as there is not much we can do about it.
> +	 * The error message is printed inside.
> +	 */
> +	mana_ib_gd_destroy_dma_region(mdev, queue->gdma_region);

Thanks a lot. I am fine with it.

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


