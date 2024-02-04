Return-Path: <linux-rdma+bounces-886-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41458848D8E
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Feb 2024 13:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C832833A3
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Feb 2024 12:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C68122098;
	Sun,  4 Feb 2024 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6N8QCNq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389A722325;
	Sun,  4 Feb 2024 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707049559; cv=none; b=Asq2LpGLrtoSTdDNTfzNQV4QkZcDuDCd5l2kYdGrjHuythYCKDx7Qr4SDm770mmJcmkc6OBYLpHclv2DdKSJYTllxkCYqFmZ+YlEWyoOCPrM+Njz+/rOSJIqnFcEL0t1ah2X+dKJmrKtALfd5FYBW7ceN/hghO7JlScP01GGmTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707049559; c=relaxed/simple;
	bh=pPkf1DjZwyl0CMDdtkeUm5Qfo49cb+VRkkoce2BPE/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozeZrSgzDb+eW5Pkp7zgS8ydYdkpMEf6SXSEnJpPA2V40Dz/Ek7ToozEtATy3K4rfIEJIZIy+w9n2omc7s1ZYqlCBcE9m2b482ylRozvdTYrvLT+UZr9SAoUejC/Dyhy+jURP41jjDbZzgYIRzHuD/ExMPGEgfYNhdC4Ubc0lcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6N8QCNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2596EC433C7;
	Sun,  4 Feb 2024 12:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707049557;
	bh=pPkf1DjZwyl0CMDdtkeUm5Qfo49cb+VRkkoce2BPE/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M6N8QCNqdUQ7sKy0vNfBU9o4N/7ZRidzigYw9zDrRFp6ILbmzILPnTy1aH0BRS0Gg
	 twmwa5bB8M9fHV0CJVFuoiK9rvJzTSPqQdxYQMqesarr41ONIbhZqfRG2F4NnZDff3
	 ynirJDU1WFKzjwinzaDb6XpYzGmzVIqDB8swfL5lpVioCN1aOH0E6V7MUU8XNuwdMZ
	 8jOSdSpEPkrUw3tTTLAQnYpu2VT8sm0qCa5fh6uHVjoe5gQJDD89FqVQaZLtNrowR7
	 sBbWF8RlGWSsXahqC9dg9RkiLZTww5neqND79lNA+yfKihF7+JUlI7m+XUt/IwiGME
	 iSPzhirxGQPgA==
Date: Sun, 4 Feb 2024 14:25:52 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, sharmaajay@microsoft.com, longli@microsoft.com,
	jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 1/5] RDMA/mana_ib: Add EQ creation for rnic
 adapter
Message-ID: <20240204122552.GD5400@unreal>
References: <1706886397-16600-1-git-send-email-kotaranov@linux.microsoft.com>
 <1706886397-16600-2-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1706886397-16600-2-git-send-email-kotaranov@linux.microsoft.com>

On Fri, Feb 02, 2024 at 07:06:33AM -0800, Konstantin Taranov wrote:
> This patch introduces functions for RNIC creation
> and creates one EQ for RNIC creation.

Please invest more time in commit messages, it is obvious that this
patch "introduces functions for RNIC creation"" by looking in the code.

> 
> Signed-off-by: Konstantin Taranov <kotaranov@linux.microsoft.com>
> ---
>  drivers/infiniband/hw/mana/device.c  |  9 ++++--
>  drivers/infiniband/hw/mana/main.c    | 53 ++++++++++++++++++++++++++++++++++++
>  drivers/infiniband/hw/mana/mana_ib.h |  5 ++++
>  3 files changed, 64 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
> index 6fa902e..d8e8b10 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -92,15 +92,19 @@ static int mana_ib_probe(struct auxiliary_device *adev,
>  		goto deregister_device;
>  	}
>  
> +	mana_ib_gd_create_rnic_adapter(dev);
> +
>  	ret = ib_register_device(&dev->ib_dev, "mana_%d",
>  				 mdev->gdma_context->dev);
>  	if (ret)
> -		goto deregister_device;
> +		goto destroy_rnic_adapter;
>  
>  	dev_set_drvdata(&adev->dev, dev);
>  
>  	return 0;
>  
> +destroy_rnic_adapter:
> +	mana_ib_gd_destroy_rnic_adapter(dev);
>  deregister_device:
>  	mana_gd_deregister_device(dev->gdma_dev);
>  free_ib_device:
> @@ -113,9 +117,8 @@ static void mana_ib_remove(struct auxiliary_device *adev)
>  	struct mana_ib_dev *dev = dev_get_drvdata(&adev->dev);
>  
>  	ib_unregister_device(&dev->ib_dev);
> -
> +	mana_ib_gd_destroy_rnic_adapter(dev);
>  	mana_gd_deregister_device(dev->gdma_dev);
> -
>  	ib_dealloc_device(&dev->ib_dev);
>  }
>  
> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
> index 29dd243..c64d569 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -548,3 +548,56 @@ int mana_ib_gd_query_adapter_caps(struct mana_ib_dev *dev)
>  
>  	return 0;
>  }
> +
> +static int mana_ib_create_eqs(struct mana_ib_dev *mdev)
> +{
> +	struct gdma_context *gc = mdev_to_gc(mdev);
> +	struct gdma_queue_spec spec = {};
> +	int err;
> +
> +	spec.type = GDMA_EQ;
> +	spec.monitor_avl_buf = false;
> +	spec.queue_size = EQ_SIZE;
> +	spec.eq.callback = NULL;
> +	spec.eq.context = mdev;
> +	spec.eq.log2_throttle_limit = LOG2_EQ_THROTTLE;
> +	spec.eq.msix_index = 0;
> +
> +	err = mana_gd_create_mana_eq(&gc->mana_ib, &spec, &mdev->fatal_err_eq);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static void mana_ib_destroy_eqs(struct mana_ib_dev *mdev)
> +{
> +	if (!mdev->fatal_err_eq)
> +		return;
> +
> +	mana_gd_destroy_queue(mdev_to_gc(mdev), mdev->fatal_err_eq);
> +	mdev->fatal_err_eq = NULL;

Please don't set NULL to the pointers if they are not used anymore.

> +}
> +
> +void mana_ib_gd_create_rnic_adapter(struct mana_ib_dev *mdev)
> +{
> +	int err;
> +
> +	err = mana_ib_create_eqs(mdev);
> +	if (err) {
> +		ibdev_err(&mdev->ib_dev, "Failed to create EQs for RNIC err %d", err);
> +		goto cleanup;
> +	}
> +
> +	return;
> +
> +cleanup:
> +	ibdev_warn(&mdev->ib_dev,
> +		   "RNIC is not available. Only RAW QPs are supported");
> +	mana_ib_destroy_eqs(mdev);

If mana_ib_create_eqs() fails, you shouldn't call to mana_ib_destroy_eqs().
mana_ib_create_eqs() needs to clean everything when it fails.

Thanks

> +}
> +
> +void mana_ib_gd_destroy_rnic_adapter(struct mana_ib_dev *mdev)
> +{
> +	mana_ib_destroy_eqs(mdev);
> +}
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
> index 6a03ae6..a4b94ee 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -48,6 +48,7 @@ struct mana_ib_adapter_caps {
>  struct mana_ib_dev {
>  	struct ib_device ib_dev;
>  	struct gdma_dev *gdma_dev;
> +	struct gdma_queue *fatal_err_eq;
>  	struct mana_ib_adapter_caps adapter_caps;
>  };
>  
> @@ -228,4 +229,8 @@ int mana_ib_query_gid(struct ib_device *ibdev, u32 port, int index,
>  void mana_ib_disassociate_ucontext(struct ib_ucontext *ibcontext);
>  
>  int mana_ib_gd_query_adapter_caps(struct mana_ib_dev *mdev);
> +
> +void mana_ib_gd_create_rnic_adapter(struct mana_ib_dev *mdev);
> +
> +void mana_ib_gd_destroy_rnic_adapter(struct mana_ib_dev *mdev);
>  #endif
> -- 
> 1.8.3.1
> 

