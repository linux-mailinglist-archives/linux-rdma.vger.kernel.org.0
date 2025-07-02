Return-Path: <linux-rdma+bounces-11825-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B04AF0FE5
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 11:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002A91C40042
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 09:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0419A248884;
	Wed,  2 Jul 2025 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ONbqvuQ8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DEF248883;
	Wed,  2 Jul 2025 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751448289; cv=none; b=d744Q4k6zrh4EKsiio6Umom+2w5NXyhcgZyO6a+GSWocfbzjG8rHZxgFLrK4rytNQEvMkxXTXZUgUl4pPjabA8oM329abQDC9unEAOvYEi+P7PhWL/6fTMghqcj772IF2FbZmtKfk4MIf/U8R4fwiTBPsHZSxzUJwEY8BRokkDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751448289; c=relaxed/simple;
	bh=A6Zgby+nTiFE3jSlZGYlVIn5Tqhm0CzwNJz53mOyGv4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YPQbXgNTlNd3bplztnCLB8VIoVr9jz+e6mRVpibm0OnwRt5nYcHUvdYPBrGI9UkXVDrFHP0gG/mg9ww8Ks33Usfj2NDBRG4hh92SGrw5V4o6zb4TfxQ4LTklJoPayQif7hFrvdM+gD7CM9T0bSSHial+Hnp6+qOlQDWw0hiGvkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ONbqvuQ8; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751448282; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=gMDwvqQ9L9NQMU8cE/cICQqPymkcmXpH3/yhJsouDq4=;
	b=ONbqvuQ8G63urdKJS9UiSYyuqUB0x3HeIpDzt/R0PZfiIVhVBRIuXixoWHwKcuJbXas8BvJaZeAM8tCD5I2044OX0dDqoCP8/LFRheacARwDQRsn5ldN4gtNdi2uNCwMnvQUn7xVKP0Cvb7CAjnFsFGa8OF6aTwnt943dvy/syo=
Received: from 30.221.114.234(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0Wgdc04K_1751448281 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 02 Jul 2025 17:24:42 +0800
Message-ID: <0d4684ef-eb54-2977-dc38-b21c0779fee4@linux.alibaba.com>
Date: Wed, 2 Jul 2025 17:24:41 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
From: Cheng Xu <chengyou@linux.alibaba.com>
Subject: Re: [PATCH] Fix dma_unmap_sg() nents value
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Kai Shen <kaishen@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250630092346.81017-2-fourier.thomas@gmail.com>
Content-Language: en-US
In-Reply-To: <20250630092346.81017-2-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/30/25 5:23 PM, Thomas Fourier wrote:
> The dma_unmap_sg() functions should be called with the same nents as the
> dma_map_sg(), not the value the map function returned.
> 
> Fixes: ed10435d3583 ("RDMA/erdma: Implement hierarchical MTT")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>  drivers/infiniband/hw/erdma/erdma_verbs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Hi Thomas,

This patch is already accepted by Leon, and a late thanks to you.

Cheng Xu


> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
> index af36a8d2df22..ec0ad4086066 100644
> --- a/drivers/infiniband/hw/erdma/erdma_verbs.c
> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
> @@ -629,7 +629,8 @@ static struct erdma_mtt *erdma_create_cont_mtt(struct erdma_dev *dev,
>  static void erdma_destroy_mtt_buf_sg(struct erdma_dev *dev,
>  				     struct erdma_mtt *mtt)
>  {
> -	dma_unmap_sg(&dev->pdev->dev, mtt->sglist, mtt->nsg, DMA_TO_DEVICE);
> +	dma_unmap_sg(&dev->pdev->dev, mtt->sglist,
> +		     DIV_ROUND_UP(mtt->size, PAGE_SIZE), DMA_TO_DEVICE);
>  	vfree(mtt->sglist);
>  }
>  

