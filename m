Return-Path: <linux-rdma+bounces-15575-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A05D23F87
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 11:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A28C300B839
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 10:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D573C36C0B1;
	Thu, 15 Jan 2026 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnIOtNBV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916D936BCF8;
	Thu, 15 Jan 2026 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768473415; cv=none; b=VvPfuGHwidXFoUHy2VgBn8c1sZPPHdq6igeFfEVfvsWBCBL/ukGltvC+BlDFb9dJb5j2q2Z6I5X9EQDJCOAFvieUY8KCg06zpixr6xZCcHt6tJfpE35Y33gPX3kw7mbObRH2Ymer/s5lBV3Bvynaqs24C5gs19LEz1+/6pN0E7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768473415; c=relaxed/simple;
	bh=JkNdweq4ujZj38nY1IHX1JBSxak2V5gWLQrmU3h0E44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lttUsNm3+cIBqNPqsxy+rm3OiQVVQgDOvvtib9hrEstD89KxzeGobcigpJ0WBj4RQZkRp60JxuhbiP3jwuFbRyfITnYhWXyXO6Fkzy0QIfwTTGir3Mhz4gHXLq1y4sSW/rHuyml1D9B1xk0A6pjQQGRhXR546bvkSvp4lhx8BLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnIOtNBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05A2C116D0;
	Thu, 15 Jan 2026 10:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768473415;
	bh=JkNdweq4ujZj38nY1IHX1JBSxak2V5gWLQrmU3h0E44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YnIOtNBVqXDtR+ZVAl8zWZ6bAdM81HTnUARB1/YQjGf06y9UkprJwltlBt5klXLcd
	 iRxrLTa2fmWckZddzJ3YUfu3UgVsaLU5pHumN1bSQNIfatwciBD9Q9VVmhiBfOocJQ
	 MkjVvaf53UXWrrl9xGlCfb1B2eiZPS/pml9y6pWmlKiZs6YXIaFx2Lc2/MaTgb7BJ6
	 QhDibfqIXSzbhOYcG4+EY/IU7LN7SydvOHNYSPqYu//9C0BlpQr8EyoluLnl1tsqQU
	 2ws3MYnuXLgOUruMa8Uizhpl4KY9D3bRPRXq/Uq3q9VgOsE/BK8xZ0U8PUBhRHcw91
	 droe/3z4R3Jpw==
Date: Thu, 15 Jan 2026 12:36:50 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Danila Chernetsov <listdansp@mail.ru>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] RDMA/core: Add error handling in
 rdma_user_mmap_disassociate.
Message-ID: <20260115103650.GC14359@unreal>
References: <20260114205324.136273-1-listdansp@mail.ru>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114205324.136273-1-listdansp@mail.ru>

On Wed, Jan 14, 2026 at 08:53:24PM +0000, Danila Chernetsov wrote:
> rdma_user_mmap_disassociate can be called before
> ib_set_client_data(device, &uverbs_client, uverbs_dev);

It is not.

Thanks

> and cause an error when calling ib_get_client_data.
> Also, consider checking the result of ib_get_client_data to handle errors
>  in other functions.
> 
> Fixes: 51976c6cd786 ("RDMA/core: Provide rdma_user_mmap_disassociate() to disassociate mmap pages")
> Signed-off-by: Danila Chernetsov <listdansp@mail.ru>
> ---
>  drivers/infiniband/core/uverbs_main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> index 973fe2c7ef53..a8a2d87f4d3e 100644
> --- a/drivers/infiniband/core/uverbs_main.c
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -901,10 +901,12 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
>   * This function should be called by drivers that need to disable mmaps for the
>   * device, for instance because it is going to be reset.
>   */
> -void rdma_user_mmap_disassociate(struct ib_device *device)
> +int rdma_user_mmap_disassociate(struct ib_device *device)
>  {
>  	struct ib_uverbs_device *uverbs_dev =
>  		ib_get_client_data(device, &uverbs_client);
> +	if (!uverbs_dev)
> +		return -ENODEV;
>  	struct ib_uverbs_file *ufile;
>  
>  	mutex_lock(&uverbs_dev->lists_mutex);
> @@ -913,6 +915,7 @@ void rdma_user_mmap_disassociate(struct ib_device *device)
>  			uverbs_user_mmap_disassociate(ufile);
>  	}
>  	mutex_unlock(&uverbs_dev->lists_mutex);
> +	return 0;
>  }
>  EXPORT_SYMBOL(rdma_user_mmap_disassociate);
>  
> -- 
> 2.25.1
> 
> 

