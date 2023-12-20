Return-Path: <linux-rdma+bounces-471-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B27C819C84
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Dec 2023 11:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6478B26B17
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Dec 2023 10:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E862D208B3;
	Wed, 20 Dec 2023 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvwcWJOj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33BC20B03
	for <linux-rdma@vger.kernel.org>; Wed, 20 Dec 2023 10:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27ADC433C7;
	Wed, 20 Dec 2023 10:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703067168;
	bh=pfk7j1pXnDIZocmTrDk06nRMoCTjRd43qJPKfvuE9WE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LvwcWJOj30+ShAYlEfu0q0XSZJFf1FP8A53/FcUqqs0f8pDyNPXCsGWJ0wVokR4ud
	 UAN4STIpwrv2XfXpUyCijMjSQshw5vv+RUsGH4newi28w4ICAEHUWAWiAA8RdhALm1
	 nCbSFi6/Jcd4Cy2Nx2BsczaUdx+tmCuBhCzph823IRbwPZs+ZQTBObnblihuTc1P2l
	 DEz2SeWvNXMBA5hHYVcgOCoMrK14QW5KVCIJ/pLVPDMEnDwmyzQIIJrvJn+WmY+eA3
	 +FXJYIN1L9n+B518UiqufcgkQas+aVUBtLVmUEp3epTpxynyIjJNa0v3D4OdqrVGur
	 dE4KcJCjk0i6g==
Date: Wed, 20 Dec 2023 12:12:43 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Cheng Xu <chengyou@linux.alibaba.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next 1/2] RDMA/erdma: Introduce dma pool for hardware
 responses of CMDQ requests
Message-ID: <20231220101243.GD136797@unreal>
References: <20231220085424.97407-1-chengyou@linux.alibaba.com>
 <20231220085424.97407-2-chengyou@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220085424.97407-2-chengyou@linux.alibaba.com>

On Wed, Dec 20, 2023 at 04:54:23PM +0800, Cheng Xu wrote:
> Hardware response, such as the result of query statistics, may be too
> long to be directly accommodated within the CQE structure. To address
> this, we introduce a DMA pool to hold the hardware's responses of CMDQ
> requests.
> 
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/erdma/erdma.h      |  2 ++
>  drivers/infiniband/hw/erdma/erdma_main.c | 38 ++++++++++++++++++++++--
>  2 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
> index f190111840e9..5df401a30cb9 100644
> --- a/drivers/infiniband/hw/erdma/erdma.h
> +++ b/drivers/infiniband/hw/erdma/erdma.h
> @@ -212,6 +212,8 @@ struct erdma_dev {
>  
>  	atomic_t num_ctx;
>  	struct list_head cep_list;
> +
> +	struct dma_pool *resp_pool;
>  };
>  
>  static inline void *get_queue_entry(void *qbuf, u32 idx, u32 depth, u32 shift)
> diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
> index 0880c79a978c..541e77aea494 100644
> --- a/drivers/infiniband/hw/erdma/erdma_main.c
> +++ b/drivers/infiniband/hw/erdma/erdma_main.c
> @@ -168,18 +168,48 @@ static void erdma_comm_irq_uninit(struct erdma_dev *dev)
>  	free_irq(dev->comm_irq.msix_vector, dev);
>  }
>  
> +static int erdma_dma_pools_init(struct erdma_dev *dev)
> +{
> +	dev->resp_pool = dma_pool_create("erdma_resp_pool", &dev->pdev->dev,
> +					 ERDMA_HW_RESP_SIZE, ERDMA_HW_RESP_SIZE,
> +					 0);
> +	if (!dev->resp_pool)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void erdma_dma_pools_destroy(struct erdma_dev *dev)
> +{
> +	dma_pool_destroy(dev->resp_pool);
> +}

Please don't add extra layer of functions which will be called in same
file anyway. Call directly to dma_pool_destroy(), same goes for dma_pool_create().

Thanks

