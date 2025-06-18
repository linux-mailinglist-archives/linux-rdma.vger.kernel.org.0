Return-Path: <linux-rdma+bounces-11427-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66266ADE960
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 12:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A893ABC4B
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 10:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702BA283CB3;
	Wed, 18 Jun 2025 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDvcYXuJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203A815D1;
	Wed, 18 Jun 2025 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750243845; cv=none; b=ZhICvSDtZfNRgO/rk7zfYFavNgfIll1AMk0iRU1fZr+DwOWDPaL+1Ga4m7V/l+KJYLhOXY3ywrCxsjMp99zisfjNmGD18fiRlkB7wdyDPRqJwnmvB4RluCd8wIxQ1smuNDF1XsiWAqLyQbQOeqzMho6NcfeE/y3rF8Ds1KGlWFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750243845; c=relaxed/simple;
	bh=P9DpeVaEogu2weAKQYMLvPOBSRCiK1DvlDpPcXEYd6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEf0i4cQvWXS8AULZN1NBEe/fbgJFNYRxIWp6z5wSupQ9XUELD3fFHmDeWcT2APxBC5eXItuct5fwVOV7nU4PAlvCK0ij5dN0YY/gmHfejPA223A4Sd4Hby/UCMAiQAfZzA1DzK1HnnhUUJCkN1m0PFimY5TwGyILmPpYQE00Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDvcYXuJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A825BC4CEE7;
	Wed, 18 Jun 2025 10:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750243844;
	bh=P9DpeVaEogu2weAKQYMLvPOBSRCiK1DvlDpPcXEYd6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QDvcYXuJMFj2g78UHlONH5p31qSY0DNV2n8XZ5V8NQa5dMzH56dbUY8sl4x8uBor6
	 hvo2mxCluHglVPdeqxAYH44Xpscmvi2grGmfz4JkTxTshVXQwvJHzGn9P7AUrIqELX
	 4PdDPvm3YzksDR2XMVil0MX2+qmLK2nH6tKyw933d0k+d8zWz942/RmegYCbA3qe4X
	 sGHdq3hply8wwWm49Maer8R1eIDuKIpe63WX6nvwpt9yT8IwAaiq48IUA6N18pdjMV
	 1lQJsCGEGXuZwJXnqOJjXf6hQMkGcjntE0Jf7wW1coNaP6LdW9rK3IOYUojb6nHHYE
	 gTxrg5dt5uS5g==
Date: Wed, 18 Jun 2025 11:50:39 +0100
From: Simon Horman <horms@kernel.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] net/smc: replace strncpy with strscpy
Message-ID: <20250618105039.GE1699@horms.kernel.org>
References: <20250617122512.21979-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617122512.21979-1-pranav.tyagi03@gmail.com>

On Tue, Jun 17, 2025 at 05:55:12PM +0530, Pranav Tyagi wrote:
> Replace the deprecated strncpy() with strscpy() as the destination
> buffer should be NUL-terminated and does not require any trailing
> NUL-padding.
> 
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> ---
>  net/smc/smc_pnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> index b391c2ef463f..b70e1f3179c5 100644
> --- a/net/smc/smc_pnet.c
> +++ b/net/smc/smc_pnet.c
> @@ -370,7 +370,7 @@ static int smc_pnet_add_eth(struct smc_pnettable *pnettable, struct net *net,
>  		goto out_put;
>  	new_pe->type = SMC_PNET_ETH;
>  	memcpy(new_pe->pnet_name, pnet_name, SMC_MAX_PNETID_LEN);
> -	strncpy(new_pe->eth_name, eth_name, IFNAMSIZ);
> +	strscpy(new_pe->eth_name, eth_name, IFNAMSIZ);

Hi Pranav,

I think that because strscpy always results in a NULL terminated string
the length argument can be increased by one to IFNAMSIZ + 1, matching
the size of the destination.

But I also think that we can handle this automatically by switching
to the two-argument version of strscpy() because the destination is an
array.

	strscpy(new_pe->eth_name, eth_name);

>  	rc = -EEXIST;
>  	new_netdev = true;
>  	mutex_lock(&pnettable->lock);
> -- 
> 2.49.0
> 

-- 
pw-bot: changes-requested

