Return-Path: <linux-rdma+bounces-15430-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD99D0EF87
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jan 2026 14:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A2633008F86
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jan 2026 13:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C163314B8;
	Sun, 11 Jan 2026 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpyEDGyL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A33C14F70
	for <linux-rdma@vger.kernel.org>; Sun, 11 Jan 2026 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768137782; cv=none; b=Lf3DkDKfoLSUrdp87ZCsiPIqKRaclc14XxE66sLyPywaAoOj6KSdTtHPSpZvQZJ0e6RRmHW25AausUae6PDIzwFWpUqJJhNHGR3pEf5lIkNVjU/nMDLcMEctBpfkR7S1+SV7ONq8HduVgU+fxINkNn67KqR6SrIojpjZBcGrWW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768137782; c=relaxed/simple;
	bh=j9BQpkRe4mmr5UY3vF5OEp81SlkDXz3Q+XOlsZlHfac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccEpwoS4KKNEgaA+IEhdtqYHZq8GWPlERH3VwBfGinRN5rWS3ifBrLpEt8EfS5khMdeyEybjHR264TKjltmc1UQmTRSd0IGTVgJVaosnpjy3iNUW9WM2G24av8uj1S4YwG94/Aaakm3fcFw3Pg9ol5+hsa64Cs8E2ld+E7Yc74U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpyEDGyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9752C4CEF7;
	Sun, 11 Jan 2026 13:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768137782;
	bh=j9BQpkRe4mmr5UY3vF5OEp81SlkDXz3Q+XOlsZlHfac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IpyEDGyLkF6vHJcAnHsU4N+AV5RWjj1EtCp3ir0Aj90WR2da+cUzoWcMq3nW+UahI
	 DmiUN4VF6Bsbu/8JYOj7B46URLK6TVPdc75KQyFPJ7vqRE8voQKP8RsFOaL2LLjZ8s
	 imN/JPLzA0bMoYAS9yH1UKad2u8pW5QWLLR0lBG0kADesyklSeShHKO7H67ERX6SSS
	 VFKLNHqCF9Sr+hr6w8Q1DwbEfQGl/O/6r6hDipfrtGM9BHbVzEeEqY2bd01ud2DtFZ
	 wqa4nYPpZmdFBF9kdo7wHfkoU2YlTNGR6Pf6dQ0oqo9H/A5S90V0gYNlmBZi7jEuXu
	 nbC02qqO/XpTQ==
Date: Sun, 11 Jan 2026 15:22:55 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Siva Reddy Kallam <siva.kallam@broadcom.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, usman.ansari@broadcom.com,
	Simon Horman <horms@kernel.org>, kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] RDMA/bng_re: Unwind bng_re_dev_init properly and remove
 unnecessary rdev check
Message-ID: <20260111132255.GA14378@unreal>
References: <20260107091607.104468-1-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107091607.104468-1-siva.kallam@broadcom.com>

On Wed, Jan 07, 2026 at 09:16:07AM +0000, Siva Reddy Kallam wrote:
> Fix below smatch warnings:
> drivers/infiniband/hw/bng_re/bng_dev.c:113
> bng_re_net_ring_free() warn: variable dereferenced before check 'rdev'
> (see line 107)
> drivers/infiniband/hw/bng_re/bng_dev.c:270
> bng_re_dev_init() warn: missing unwind goto?

Please provide commit message.

> 
> Fixes: 4f830cd8d7fe ("RDMA/bng_re: Add infrastructure for enabling Firmware channel")
> Reported-by: Simon Horman <horms@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202601010413.sWadrQel-lkp@intel.com/
> Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
> Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
> ---
>  drivers/infiniband/hw/bng_re/bng_dev.c | 33 +++++++++++++-------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
> index d8f8d7f7075f..e2dd2c8eb6d2 100644
> --- a/drivers/infiniband/hw/bng_re/bng_dev.c
> +++ b/drivers/infiniband/hw/bng_re/bng_dev.c
> @@ -124,9 +124,6 @@ static int bng_re_net_ring_free(struct bng_re_dev *rdev,
>  	struct bnge_fw_msg fw_msg = {};
>  	int rc = -EINVAL;
>  
> -	if (!rdev)

You have other places with impossible "if (rdev)" check in this path which you should
delete as well.

> -		return rc;
> -
>  	if (!aux_dev)

You should remove this check too.

>  		return rc;
>  
> @@ -303,7 +300,7 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
>  	if (rc) {
>  		ibdev_err(&rdev->ibdev,
>  				"Failed to register with netedev: %#x\n", rc);
> -		return -EINVAL;
> +		goto reg_netdev_fail;
>  	}
>  
>  	set_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
> @@ -312,19 +309,16 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
>  		ibdev_err(&rdev->ibdev,
>  			  "RoCE requires minimum 2 MSI-X vectors, but only %d reserved\n",
>  			  rdev->aux_dev->auxr_info->msix_requested);
> -		bnge_unregister_dev(rdev->aux_dev);
> -		clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
> -		return -EINVAL;
> +		rc = -EINVAL;
> +		goto msix_ctx_fail;
>  	}
>  	ibdev_dbg(&rdev->ibdev, "Got %d MSI-X vectors\n",
>  		  rdev->aux_dev->auxr_info->msix_requested);
>  
>  	rc = bng_re_setup_chip_ctx(rdev);
>  	if (rc) {
> -		bnge_unregister_dev(rdev->aux_dev);
> -		clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
>  		ibdev_err(&rdev->ibdev, "Failed to get chip context\n");
> -		return -EINVAL;
> +		goto msix_ctx_fail;
>  	}
>  
>  	bng_re_query_hwrm_version(rdev);
> @@ -333,16 +327,14 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
>  	if (rc) {
>  		ibdev_err(&rdev->ibdev,
>  			  "Failed to allocate RCFW Channel: %#x\n", rc);
> -		goto fail;
> +		goto alloc_fw_chl_fail;
>  	}
>  
>  	/* Allocate nq record memory */
>  	rdev->nqr = kzalloc(sizeof(*rdev->nqr), GFP_KERNEL);
>  	if (!rdev->nqr) {
> -		bng_re_destroy_chip_ctx(rdev);
> -		bnge_unregister_dev(rdev->aux_dev);
> -		clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
> -		return -ENOMEM;
> +		rc = -ENOMEM;
> +		goto nq_alloc_fail;
>  	}
>  
>  	rdev->nqr->num_msix = rdev->aux_dev->auxr_info->msix_requested;
> @@ -411,9 +403,16 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
>  free_ring:
>  	bng_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id, type);
>  free_rcfw:
> +	kfree(rdev->nqr);
> +	rdev->nqr = NULL;

Why do you need to set NULL here?

> +nq_alloc_fail:
>  	bng_re_free_rcfw_channel(&rdev->rcfw);
> -fail:
> -	bng_re_dev_uninit(rdev);
> +alloc_fw_chl_fail:
> +	bng_re_destroy_chip_ctx(rdev);
> +msix_ctx_fail:
> +	bnge_unregister_dev(rdev->aux_dev);
> +	clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
> +reg_netdev_fail:
>  	return rc;
>  }
>  
> -- 
> 2.25.1
> 
> 

