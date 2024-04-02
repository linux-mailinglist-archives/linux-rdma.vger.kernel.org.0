Return-Path: <linux-rdma+bounces-1727-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D56894DAB
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 10:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DA91C216D6
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 08:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC0B40C15;
	Tue,  2 Apr 2024 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icB4wbFC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183D03EA73;
	Tue,  2 Apr 2024 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046947; cv=none; b=cYn7IDW14nZHBBDbCzdXWm+ga9gu/k26WbNY0LQBsxnB8gQ7Cw4pqgHTTWSytUBZnipjtJw2iL7+LBb4rV7SifqQCGKjXv8X7aLYJyevMQ4NzNDc5GoRJh19NlbnYnHTWrX4w+2NxjedvTJi1qqAomYK/ShXsG1m3KiEFUvPKzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046947; c=relaxed/simple;
	bh=uR+WPn6LQ+T2m5pe49GHjccpQrV57vEXtJxgVft/4kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyYrOCXzBExG9ob+m55WFvG/de12dHLi85QnbkqBMra/ysXotV2w//1YNL628ZaYgO6nt2EYQLFcLVYjnCSykTlNFc1PFEfhKhwkooXwpLaqiekG0UzTXWu3bwEttnvOeKnCgsf4SjXdVBJzEhFe95793pAGhvjyToq0XGYOpQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icB4wbFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22DAC433A6;
	Tue,  2 Apr 2024 08:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712046946;
	bh=uR+WPn6LQ+T2m5pe49GHjccpQrV57vEXtJxgVft/4kQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=icB4wbFC+ejSnDtKZ9C2ulym3AkjuJlcIZYJMwUNowa/UKPmKhwYOvutjSVEp72uA
	 OHWPe6lURlXht/grYa+TfQzMGcJkn9388CDFxQRhj1EqSOtPr2hM50T09SqoT8ySSu
	 oS/Qz3iXP8nbfM0UdhjuNxuq/XxHgT0W6SzlPY6CXjaLMTxUxvFLxEO7REqLqT1pM7
	 XhmLlvy1t+hcl7DTvNlJwqIeNa5c8WLrSbhhoLKXY3UKBXsSIdirshffU358x/+DAS
	 wx/CwkUfHG6JIot27bGOtT/elsPX9iqlMbvUfeZgAloM5zckb42fVzLg3e/pHY2yTP
	 XVFM0vaOiv9sQ==
Date: Tue, 2 Apr 2024 11:35:41 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, sharmaajay@microsoft.com, longli@microsoft.com,
	jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v3 1/4] RDMA/mana_ib: Introduce helpers to
 create and destroy mana queues
Message-ID: <20240402083541.GE11187@unreal>
References: <1711483688-24358-1-git-send-email-kotaranov@linux.microsoft.com>
 <1711483688-24358-2-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711483688-24358-2-git-send-email-kotaranov@linux.microsoft.com>

On Tue, Mar 26, 2024 at 01:08:05PM -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Intoduce helpers to work with mana ib queues (struct mana_ib_queue).
> A queue always consists of umem, gdma_region, and id.
> A queue can become a WQ or a CQ.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> Reviewed-by: Long Li <longli@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/main.c    | 43 ++++++++++++++++++++++++++++
>  drivers/infiniband/hw/mana/mana_ib.h | 10 +++++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
> index 71e33feee..4524c6b80 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -237,6 +237,49 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
>  		ibdev_dbg(ibdev, "Failed to destroy doorbell page %d\n", ret);
>  }
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

I see such prints in all code and patches, please remove them. We assume
that the code works and you don't need to print about success.

Also you are printing "err" too which is always 0 in this case.

Thanks

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
> +	ib_umem_release(queue->umem);
> +}
> +
>  static int
>  mana_ib_gd_first_dma_region(struct mana_ib_dev *dev,
>  			    struct gdma_context *gc,
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
> index f83390eeb..859fd3bfc 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -45,6 +45,12 @@ struct mana_ib_adapter_caps {
>  	u32 max_inline_data_size;
>  };
>  
> +struct mana_ib_queue {
> +	struct ib_umem *umem;
> +	u64 gdma_region;
> +	u64 id;
> +};
> +
>  struct mana_ib_dev {
>  	struct ib_device ib_dev;
>  	struct gdma_dev *gdma_dev;
> @@ -169,6 +175,10 @@ int mana_ib_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
>  int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev,
>  				  mana_handle_t gdma_region);
>  
> +int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, u32 size,
> +			 struct mana_ib_queue *queue);
> +void mana_ib_destroy_queue(struct mana_ib_dev *mdev, struct mana_ib_queue *queue);
> +
>  struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
>  				struct ib_wq_init_attr *init_attr,
>  				struct ib_udata *udata);
> -- 
> 2.43.0
> 
> 

