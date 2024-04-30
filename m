Return-Path: <linux-rdma+bounces-2163-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4C68B76E9
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 15:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73531F2318B
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 13:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D827171E45;
	Tue, 30 Apr 2024 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyzanMcW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D9117166C;
	Tue, 30 Apr 2024 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483297; cv=none; b=XckK2s864zjRej8zmlG4B1iQxEYpNvbf/+ppVdEpKK2XwQmYlCPbb1BndlPu4vgSVO7hEVD3QUvqWE16uVATXad7AUf+WhmmsDWtgorbHKGIZqL0AO9+ri7b+HcoU5SXMtAy9qvPnyVUBjtVbdV+pB8N+W4G5XQcNMtfzKP2DPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483297; c=relaxed/simple;
	bh=AKOQrcJJa/PgvbmB77Ei3e3Xgp/1RKlFobDI2jRg6yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bysgEpELKCGP4p8vyo/CmWif4eLnrXXSE+tl2hcPRnmONYahId03pSbG9X68kttYZ1sZy0U62qTjff1x8CtVJxBxMJF0YHKNAMZ7aNYV5nzMmrdwEpKP0mXzfIzx9e2w3a8CxJu+e5uFrDbtFEqlRD+0U+QBnlBR+FhziB72VVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyzanMcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC06EC2BBFC;
	Tue, 30 Apr 2024 13:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714483296;
	bh=AKOQrcJJa/PgvbmB77Ei3e3Xgp/1RKlFobDI2jRg6yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qyzanMcW2Zm9XUgr42I5Z8b8OLIWBd2L66oIpnphw/6Nluus4g86N8cM1gDqAkjlq
	 TqgBq7dJl2TIqNG8GSYb4rAHl38ExSRwEZIk3VclKSgbVRhWQH+H3UNfYs210gETdN
	 ENoKl+tgTzIbTcdwWWOzvtPZ1r8bJNdJi7uPg0TEd3YLjYaxzh3Yws0TvvIIaREDLZ
	 hl5lVLiUDtlbYTa3Hj7aGoHyvk3vQ/RN7xZL14eBBxXUtCZJOYBC7ZB5G3nMQOXo7X
	 M3MR0Z3iqini8O36heR4U3aKWaxp1WTW/wPjL2Yeq2rwONvIocUAE7wJNgoXJyywRx
	 dLIRke2GVGDvQ==
Date: Tue, 30 Apr 2024 16:21:31 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jules Irenge <jbi.octave@gmail.com>
Cc: jgg@ziepe.ca, wenglianfa@huawei.com, gustavoars@kernel.org,
	lishifeng@sangfor.com.cn, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Remove NULL check before dev_{put, hold}
Message-ID: <20240430132131.GG100414@unreal>
References: <Zi5QgLIt9sblrfYs@octinomon.home>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi5QgLIt9sblrfYs@octinomon.home>

On Sun, Apr 28, 2024 at 02:34:56PM +0100, Jules Irenge wrote:
> Coccinelle reports a warning
> 
> WARNING: NULL check before dev_{put, hold} functions is not needed

Please do it for whole drivers/infiniband/core in one patch, please.

> 
> The reason is the call netdev_{put, hold} of dev_{put,hold} will check NULL
> There is no need to check before using dev_{put, hold}
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  drivers/infiniband/core/device.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 07cb6c5ffda0..84be4bb9b625 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2235,8 +2235,7 @@ struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
>  		spin_lock(&pdata->netdev_lock);
>  		res = rcu_dereference_protected(
>  			pdata->netdev, lockdep_is_held(&pdata->netdev_lock));
> -		if (res)
> -			dev_hold(res);
> +		dev_hold(res);
>  		spin_unlock(&pdata->netdev_lock);
>  	}
>  
> -- 
> 2.43.2
> 

