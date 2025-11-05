Return-Path: <linux-rdma+bounces-14257-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC438C35BB1
	for <lists+linux-rdma@lfdr.de>; Wed, 05 Nov 2025 13:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B9B3BDD8B
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Nov 2025 12:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBC43161B5;
	Wed,  5 Nov 2025 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyVp+qtp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1953128B4;
	Wed,  5 Nov 2025 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347441; cv=none; b=dejmu6cTNSX+ZEmUn0F/LtuYpsWLmMbL+SdeI2NmGL4HuQ/agMkB/gFE88HaUZ60NDdEhjQmrCzawR8Inx2uSuxbJD/sMzjO4yKgjXaLapA6pI78CG0aRp9uo6y6tRh/1WBuum/pha1a3pksgsd06mudITBENkFoSbtzUCtrP/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347441; c=relaxed/simple;
	bh=hIATDbt/RsrH8ZIiC8JoCLILbqxUzH0/OZQz+Ym01Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aY1C71m+bSH9P9X9bpbNiQI5DRithDwuUQh8CNPW0CKQM/VKz4upAnMSewJi61bFF8FHIHnvwTixnFRPw4ucJNuYhfBQznU5DcBCBVzL2ctVGQwGPk3/rFgGom3mRYyhby3BHrfVvu//0du/1/yDkE81IbprldwPstPExPa9Zzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyVp+qtp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F873C4CEF8;
	Wed,  5 Nov 2025 12:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762347440;
	bh=hIATDbt/RsrH8ZIiC8JoCLILbqxUzH0/OZQz+Ym01Tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uyVp+qtp31l6qzqBBFg/KjZ/r3ewyocLtuGIKSTuRAtNZ56Kx7tGofQuowtlA6uGQ
	 qHni5QDiVeZ1HxgesDoA2pjDrzTH/QHRs4e4NQznZPgMTltS9YPWu8oJ/tHsEHXMh/
	 BvOfRNPbbd8ZVvwDBOgDTbgLrBIunisc4GCSeKcF1inNZTCo+KXX9dkKqRcRorq4lb
	 bZeo74gn3u5LgxjXguB6c5thwN4C898ujDtCSPFlBirRdrplh5m2pOCw/gw4TmDL5U
	 3HRnZDbTcBMVbuCIKmiutz5j23n8WyHxUYzUUdR3P70WfXBsvqhqnA83bMjLU9O3mT
	 2eQoPEdtWUfMg==
Date: Wed, 5 Nov 2025 14:57:13 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
	danil.kipnis@cloud.ionos.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] RDMA/rtrs: server: Fix error handling in
 get_or_create_srv
Message-ID: <20251105125713.GC16832@unreal>
References: <20251104021900.11896-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104021900.11896-1-make24@iscas.ac.cn>

On Tue, Nov 04, 2025 at 10:19:00AM +0800, Ma Ke wrote:
> get_or_create_srv() fails to call put_device() after
> device_initialize() when memory allocation fails. This could cause
> reference count leaks during error handling, preventing proper device
> cleanup and resulting in memory leaks.

Nothing from above is true. put_device is preferable way to release
memory after call to device_initialize(), but direct call to kfree is
also fine.

> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org

There is no need in this line at all, it is not fixing anything.

Please rewrite commit message, thanks.

> Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index ef4abdea3c2d..9ecc6343455d 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1450,7 +1450,7 @@ static struct rtrs_srv_sess *get_or_create_srv(struct rtrs_srv_ctx *ctx,
>  	kfree(srv->chunks);
>  
>  err_free_srv:
> -	kfree(srv);
> +	put_device(&srv->dev);
>  	return ERR_PTR(-ENOMEM);
>  }
>  
> -- 
> 2.17.1
> 

