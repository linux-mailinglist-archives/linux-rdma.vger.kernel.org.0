Return-Path: <linux-rdma+bounces-13227-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A38B510FB
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 10:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0704E08B5
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 08:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA01830648E;
	Wed, 10 Sep 2025 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+tLMUqh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81695260563;
	Wed, 10 Sep 2025 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492261; cv=none; b=eeWURIDTu+hFtldUUw4pdCjOSQgEFSpby/o3xSU6MdN9SALxQYP1bi66ut/xZ8UZcqjuN2B0mfgyiyYhKV75ZrZxMuHSZXF+5o/8hf8233DQIrgJPkeN/oL/nHGD3p3DDi3u3CIsVV1jjOGsjsmBcdiMLI/txFucB4xScIL1tFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492261; c=relaxed/simple;
	bh=llVJ5Mm3phDyzlh+448iiXnpalPYNOZBm2FyJR0Gdx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrFOlr11rQuvc7s3uqmInXhll/Y6TlA0t4hOPvnGlV51yLhH6UoAJrQwOELIygvKrrAFx78bOx1iEE0MjubeYcdt6QrtaEE6C8a20wntNIlY938jVFK4LgVxdZfTb5dZW9fBYPgfJZ1vVDc0Xm6kKyRs9V9Yo8+4eAez7N02Qls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+tLMUqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C685C4CEF0;
	Wed, 10 Sep 2025 08:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757492261;
	bh=llVJ5Mm3phDyzlh+448iiXnpalPYNOZBm2FyJR0Gdx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+tLMUqho7QjwIufPMZ4GjWwyExI7gClk5D9d9+OXHSvzCl5SqFSVJ5jUYOoUtkfI
	 UDlTi7EuAmdnm3MZ/he7yZ5hxyulRI48URvpPDcucHovwKqU+ZUwoyI0CdN4b5P/BN
	 M7myHdxsaHLYTRKqRpyj6LmFQ9RvLgl4IPUkD5CzLsZbXbHgCIGm7OEGD3S+WeSKPK
	 ZXLVruDR0Pq1mfKU9t3W3fzNfU9JT0J+ntYG/rtfp319g57FZOJ4G6Lfb4gOUvVKvU
	 gqqYMA65kw2LCFII1jDqQhpr9hX4MI/15Mzu5D0mqfhtYnDv1Eo5SOKj95rjZUvsAy
	 fU1LkhrbY85KA==
Date: Wed, 10 Sep 2025 11:17:35 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Edward Srouji <edwards@nvidia.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	parav@nvidia.com, cratiu@nvidia.com, vdumitrescu@nvidia.com,
	kuba@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
	gal@nvidia.com
Subject: Re: [PATCH 1/4] RDMA/core: Squash a single user static function
Message-ID: <20250910081735.GJ341237@unreal>
References: <20250907160833.56589-1-edwards@nvidia.com>
 <20250907160833.56589-2-edwards@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250907160833.56589-2-edwards@nvidia.com>

On Sun, Sep 07, 2025 at 07:08:30PM +0300, Edward Srouji wrote:
> From: Parav Pandit <parav@nvidia.com>
> 
> In order to reduce dependencies in IFF_LOOPBACK in
> route and neighbour resolution steps, squash the
> static function to its single caller and simplify the
> code. No functional change.

It needs more explanation why it is true. Before this change,
we set dev_addr->network to some value and returned error.
That error propagated upto process_one_req(), which handles only
some errors and ignores rest.

So now, we continue to handle REQ without proper req->addr->network.

Thanks

> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> Signed-off-by: Edward Srouji <edwards@nvidia.com>
> ---
>  drivers/infiniband/core/addr.c | 49 ++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
> index be0743dac3ff..594e7ee335f7 100644
> --- a/drivers/infiniband/core/addr.c
> +++ b/drivers/infiniband/core/addr.c
> @@ -465,34 +465,6 @@ static int addr_resolve_neigh(const struct dst_entry *dst,
>  	return ret;
>  }
>  
> -static int copy_src_l2_addr(struct rdma_dev_addr *dev_addr,
> -			    const struct sockaddr *dst_in,
> -			    const struct dst_entry *dst,
> -			    const struct net_device *ndev)
> -{
> -	int ret = 0;
> -
> -	if (dst->dev->flags & IFF_LOOPBACK)
> -		ret = rdma_translate_ip(dst_in, dev_addr);
> -	else
> -		rdma_copy_src_l2_addr(dev_addr, dst->dev);
> -
> -	/*
> -	 * If there's a gateway and type of device not ARPHRD_INFINIBAND,
> -	 * we're definitely in RoCE v2 (as RoCE v1 isn't routable) set the
> -	 * network type accordingly.
> -	 */
> -	if (has_gateway(dst, dst_in->sa_family) &&
> -	    ndev->type != ARPHRD_INFINIBAND)
> -		dev_addr->network = dst_in->sa_family == AF_INET ?
> -						RDMA_NETWORK_IPV4 :
> -						RDMA_NETWORK_IPV6;
> -	else
> -		dev_addr->network = RDMA_NETWORK_IB;
> -
> -	return ret;
> -}
> -
>  static int rdma_set_src_addr_rcu(struct rdma_dev_addr *dev_addr,
>  				 unsigned int *ndev_flags,
>  				 const struct sockaddr *dst_in,
> @@ -503,6 +475,7 @@ static int rdma_set_src_addr_rcu(struct rdma_dev_addr *dev_addr,
>  	*ndev_flags = ndev->flags;
>  	/* A physical device must be the RDMA device to use */
>  	if (ndev->flags & IFF_LOOPBACK) {
> +		int ret;
>  		/*
>  		 * RDMA (IB/RoCE, iWarp) doesn't run on lo interface or
>  		 * loopback IP address. So if route is resolved to loopback
> @@ -512,9 +485,27 @@ static int rdma_set_src_addr_rcu(struct rdma_dev_addr *dev_addr,
>  		ndev = rdma_find_ndev_for_src_ip_rcu(dev_net(ndev), dst_in);
>  		if (IS_ERR(ndev))
>  			return -ENODEV;
> +		ret = rdma_translate_ip(dst_in, dev_addr);
> +		if (ret)
> +			return ret;
> +	} else {
> +		rdma_copy_src_l2_addr(dev_addr, dst->dev);
>  	}
>  
> -	return copy_src_l2_addr(dev_addr, dst_in, dst, ndev);
> +	/*
> +	 * If there's a gateway and type of device not ARPHRD_INFINIBAND,
> +	 * we're definitely in RoCE v2 (as RoCE v1 isn't routable) set the
> +	 * network type accordingly.
> +	 */
> +	if (has_gateway(dst, dst_in->sa_family) &&
> +	    ndev->type != ARPHRD_INFINIBAND)
> +		dev_addr->network = dst_in->sa_family == AF_INET ?
> +						RDMA_NETWORK_IPV4 :
> +						RDMA_NETWORK_IPV6;
> +	else
> +		dev_addr->network = RDMA_NETWORK_IB;
> +
> +	return 0;
>  }
>  
>  static int set_addr_netns_by_gid_rcu(struct rdma_dev_addr *addr)
> -- 
> 2.21.3
> 
> 

