Return-Path: <linux-rdma+bounces-1287-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 914E8872976
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Mar 2024 22:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4BCD1C21A3D
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Mar 2024 21:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA4A12CD90;
	Tue,  5 Mar 2024 21:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kLDQesw9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AA012BE8C
	for <linux-rdma@vger.kernel.org>; Tue,  5 Mar 2024 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674335; cv=none; b=ep1pXjmCAvKEvVg6YjKODLVT3F7BHVpRTcYwoF7ymu7vzQPeeK7/V5pAMZ0oHLHX4rrR9mNkL5oDhDycB3LxTbM7Uz4Rj0GWKvZDawhpcfemsnLhKKJKZoc+bZ66HlA8NB1sQ7bLaRUBxtiVqF6S5oijI+t8/po9lfxe2EP098M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674335; c=relaxed/simple;
	bh=2ZPXv69KRnZGaiTeZKI9iodcUDQkJ3Xfpldq4g4nfhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LT/0rakntw4K5uje6jR2pAbt+v727hE+Ds9c5vxppkkvNy8Ns9qVkfFV6yF0PNVnWDA3Sf5rIzLg8+J9C1q794agzNVOjomP3snQz5yWduUZpl7VUb9VTgqpDrjesT95PrQ8e5K45/h041p9RJwazQeOGaZQkOCNMZZS3xJKBXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kLDQesw9; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3d71d615-1310-4aee-ba7f-f0d2670817cb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709674330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Eda8L/E50+vkPtrt+0gUrFiZFHoOF06xD4xnQtsBU4=;
	b=kLDQesw99GSUGBVjcGfg6ZpViOSREEut/y9Sbzik7DmyihJtqGWRR+vxd5DOpZucUROOf+
	1xtloLfBH2x1Y9v+R9Q0GFD08Z6aFzxW6GV+feTPw85ZjFAed1ypY+ZYsiMFl89Np2RtL2
	N1jgnNIJPpVLiGe+XxwK0C/PEEgwuJo=
Date: Tue, 5 Mar 2024 22:32:04 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next v3 2/2] RDMA/mana_ib: Use virtual address in dma
 regions for MRs
To: Konstantin Taranov <kotaranov@linux.microsoft.com>,
 kotaranov@microsoft.com, sharmaajay@microsoft.com, longli@microsoft.com,
 jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1709560361-26393-1-git-send-email-kotaranov@linux.microsoft.com>
 <1709560361-26393-3-git-send-email-kotaranov@linux.microsoft.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1709560361-26393-3-git-send-email-kotaranov@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/3/4 14:52, Konstantin Taranov 写道:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Introduce mana_ib_create_dma_region() to create dma regions with iova
> for MRs. It allows creating MRs with any page offset. Previously,
> only page-aligned addresses worked.
> 
> For dma regions that must have a zero dma offset (e.g., for queues),
> mana_ib_create_zero_offset_dma_region() is added.
> To get the zero offset, ib_umem_find_best_pgoff() is used with zero
> pgoff_bitmask.
> 
> Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>   drivers/infiniband/hw/mana/cq.c      |  4 +--
>   drivers/infiniband/hw/mana/main.c    | 40 +++++++++++++++++++++-------
>   drivers/infiniband/hw/mana/mana_ib.h |  7 +++--
>   drivers/infiniband/hw/mana/mr.c      |  4 +--
>   drivers/infiniband/hw/mana/qp.c      |  6 ++---
>   drivers/infiniband/hw/mana/wq.c      |  4 +--
>   6 files changed, 45 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
> index 83d20c3f0..4a71e678d 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -48,7 +48,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>   		return err;
>   	}
>   
> -	err = mana_ib_gd_create_dma_region(mdev, cq->umem, &cq->gdma_region);
> +	err = mana_ib_create_zero_offset_dma_region(mdev, cq->umem, &cq->gdma_region);
>   	if (err) {
>   		ibdev_dbg(ibdev,
>   			  "Failed to create dma region for create cq, %d\n",
> @@ -57,7 +57,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>   	}
>   
>   	ibdev_dbg(ibdev,
> -		  "mana_ib_gd_create_dma_region ret %d gdma_region 0x%llx\n",
> +		  "create_dma_region ret %d gdma_region 0x%llx\n",
>   		  err, cq->gdma_region);
>   
>   	/*
> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
> index dd570832d..71e33feee 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -301,8 +301,8 @@ mana_ib_gd_add_dma_region(struct mana_ib_dev *dev, struct gdma_context *gc,
>   	return 0;
>   }
>   
> -int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
> -				 mana_handle_t *gdma_region)
> +static int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
> +					mana_handle_t *gdma_region, unsigned long page_sz)
>   {
>   	struct gdma_dma_region_add_pages_req *add_req = NULL;
>   	size_t num_pages_processed = 0, num_pages_to_handle;
> @@ -314,7 +314,6 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
>   	size_t max_pgs_create_cmd;
>   	struct gdma_context *gc;
>   	size_t num_pages_total;
> -	unsigned long page_sz;
>   	unsigned int tail = 0;
>   	u64 *page_addr_list;
>   	void *request_buf;
> @@ -323,12 +322,6 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
>   	gc = mdev_to_gc(dev);
>   	hwc = gc->hwc.driver_data;
>   
> -	/* Hardware requires dma region to align to chosen page size */
> -	page_sz = ib_umem_find_best_pgsz(umem, PAGE_SZ_BM, 0);
> -	if (!page_sz) {
> -		ibdev_dbg(&dev->ib_dev, "failed to find page size.\n");
> -		return -ENOMEM;
> -	}
>   	num_pages_total = ib_umem_num_dma_blocks(umem, page_sz);
>   
>   	max_pgs_create_cmd =
> @@ -414,6 +407,35 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
>   	return err;
>   }
>   
> +int mana_ib_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
> +			      mana_handle_t *gdma_region, u64 virt)
> +{
> +	unsigned long page_sz;
> +
> +	page_sz = ib_umem_find_best_pgsz(umem, PAGE_SZ_BM, virt);
> +	if (!page_sz) {
> +		ibdev_dbg(&dev->ib_dev, "Failed to find page size.\n");
> +		return -EINVAL;
> +	}
> +
> +	return mana_ib_gd_create_dma_region(dev, umem, gdma_region, page_sz);
> +}
> +
> +int mana_ib_create_zero_offset_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
> +					  mana_handle_t *gdma_region)
> +{
> +	unsigned long page_sz;
> +
> +	/* Hardware requires dma region to align to chosen page size */
> +	page_sz = ib_umem_find_best_pgoff(umem, PAGE_SZ_BM, 0);
> +	if (!page_sz) {
> +		ibdev_dbg(&dev->ib_dev, "Failed to find page size.\n");
> +		return -EINVAL;
> +	}

Thanks a lot. I am fine with it.
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> +
> +	return mana_ib_gd_create_dma_region(dev, umem, gdma_region, page_sz);
> +}
> +
>   int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev, u64 gdma_region)
>   {
>   	struct gdma_context *gc = mdev_to_gc(dev);
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
> index 6a03ae645..f83390eeb 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -160,8 +160,11 @@ static inline struct net_device *mana_ib_get_netdev(struct ib_device *ibdev, u32
>   
>   int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq);
>   
> -int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
> -				 mana_handle_t *gdma_region);
> +int mana_ib_create_zero_offset_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
> +					  mana_handle_t *gdma_region);
> +
> +int mana_ib_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
> +			      mana_handle_t *gdma_region, u64 virt);
>   
>   int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev,
>   				  mana_handle_t gdma_region);
> diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
> index ee4d4f834..b70b13484 100644
> --- a/drivers/infiniband/hw/mana/mr.c
> +++ b/drivers/infiniband/hw/mana/mr.c
> @@ -127,7 +127,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
>   		goto err_free;
>   	}
>   
> -	err = mana_ib_gd_create_dma_region(dev, mr->umem, &dma_region_handle);
> +	err = mana_ib_create_dma_region(dev, mr->umem, &dma_region_handle, iova);
>   	if (err) {
>   		ibdev_dbg(ibdev, "Failed create dma region for user-mr, %d\n",
>   			  err);
> @@ -135,7 +135,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
>   	}
>   
>   	ibdev_dbg(ibdev,
> -		  "mana_ib_gd_create_dma_region ret %d gdma_region %llx\n", err,
> +		  "create_dma_region ret %d gdma_region %llx\n", err,
>   		  dma_region_handle);
>   
>   	mr_params.pd_handle = pd->pd_handle;
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
> index 5d4c05dcd..6e7627745 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -357,8 +357,8 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
>   	}
>   	qp->sq_umem = umem;
>   
> -	err = mana_ib_gd_create_dma_region(mdev, qp->sq_umem,
> -					   &qp->sq_gdma_region);
> +	err = mana_ib_create_zero_offset_dma_region(mdev, qp->sq_umem,
> +						    &qp->sq_gdma_region);
>   	if (err) {
>   		ibdev_dbg(&mdev->ib_dev,
>   			  "Failed to create dma region for create qp-raw, %d\n",
> @@ -367,7 +367,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
>   	}
>   
>   	ibdev_dbg(&mdev->ib_dev,
> -		  "mana_ib_gd_create_dma_region ret %d gdma_region 0x%llx\n",
> +		  "create_dma_region ret %d gdma_region 0x%llx\n",
>   		  err, qp->sq_gdma_region);
>   
>   	/* Create a WQ on the same port handle used by the Ethernet */
> diff --git a/drivers/infiniband/hw/mana/wq.c b/drivers/infiniband/hw/mana/wq.c
> index 372d36151..7c9c69962 100644
> --- a/drivers/infiniband/hw/mana/wq.c
> +++ b/drivers/infiniband/hw/mana/wq.c
> @@ -46,7 +46,7 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
>   	wq->wq_buf_size = ucmd.wq_buf_size;
>   	wq->rx_object = INVALID_MANA_HANDLE;
>   
> -	err = mana_ib_gd_create_dma_region(mdev, wq->umem, &wq->gdma_region);
> +	err = mana_ib_create_zero_offset_dma_region(mdev, wq->umem, &wq->gdma_region);
>   	if (err) {
>   		ibdev_dbg(&mdev->ib_dev,
>   			  "Failed to create dma region for create wq, %d\n",
> @@ -55,7 +55,7 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
>   	}
>   
>   	ibdev_dbg(&mdev->ib_dev,
> -		  "mana_ib_gd_create_dma_region ret %d gdma_region 0x%llx\n",
> +		  "create_dma_region ret %d gdma_region 0x%llx\n",
>   		  err, wq->gdma_region);
>   
>   	/* WQ ID is returned at wq_create time, doesn't know the value yet */


