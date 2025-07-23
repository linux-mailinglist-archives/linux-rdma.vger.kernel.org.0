Return-Path: <linux-rdma+bounces-12419-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B80EB0ED46
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 10:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8D3581F31
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 08:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC541280312;
	Wed, 23 Jul 2025 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xjy/Lf3s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC7F280308
	for <linux-rdma@vger.kernel.org>; Wed, 23 Jul 2025 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259570; cv=none; b=uciI54YRuAwdJ2rmDSjbs3GwJtFpKhfByVVMLrFM+O1UP2toHuOyEH4dUwGY2qL1dUL/ge/Yjq+FWk8sP3jP4Nx3Ulk4cszkm4z0ZlSsGVsf3PGOGZyxi2Bvu4E15SDPRRbK0EMcnqNEMhY1pygCkY8XKijZ4yPTR4mPYmymErY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259570; c=relaxed/simple;
	bh=LgLBroRhFwt39wU7ljMhsyGP0Igl2edxVLsS5iFSpKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mb85oAE3214hpEx0dcZzk35HtRK2gMfo8WmWPF8r4Abjn/2ZiYXyemOWyFvrxTph6dgtkt9A/qGPxRUQxOTrOo489SIVHFw/IWodReLNR7AULjr4uFYskmPKzdrYVFAdgtfA54HTYEg/FLlazDrJtwwBYhl9pEa19RytRDKwn4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xjy/Lf3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD701C4CEF4;
	Wed, 23 Jul 2025 08:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753259570;
	bh=LgLBroRhFwt39wU7ljMhsyGP0Igl2edxVLsS5iFSpKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xjy/Lf3sFIcHAChfj6ZPi6+DbAYMb/ycsMbz0IHhK17N0Y5lfxKVKNI8ly+xu8lRX
	 e5XiT7xbWhL+E3D2tE4jP+KKCs4wAbC8gUP4YCuUyFssl+ITTU+gI2zleIyXqyyTn/
	 ngM6UjPwGVG4oqlYZfQAPd+kOtsi9a+t30ct4xAXgoGlT4tj2ynHVkMSsC3lMP5S74
	 gIHhfl+I1osf8hho2ZtmeMEFdLgNzNLMY9hM+CnnoOJwmwAqiZB2iN+XMyncBtat1L
	 6mdhMf0+AJl6QR25gCtLojZER/KVMWl2nowvayBroYmUCsP2WkNOCr0JAbdKhLtKT3
	 xddxjieHgd98g==
Date: Wed, 23 Jul 2025 11:32:45 +0300
From: Leon Romanovsky <leon@kernel.org>
To: bernard.metzler@linux.dev
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/siw: Change maintainer email address
Message-ID: <20250723083245.GN402218@unreal>
References: <20250722094915.2078-1-bernard.metzler@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722094915.2078-1-bernard.metzler@linux.dev>

On Tue, Jul 22, 2025 at 11:49:15AM +0200, bernard.metzler@linux.dev wrote:
> From: Bernard Metzler <bernard.metzler@linux.dev>
> 
> Change siw maintainer email address since old address
> will become disfunctional.
> 
> Signed-off-by: Bernard Metzler <bernard.metzler@linux.dev>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please update .mailmap too.

Thanks

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 10850512c118..84bce0f7aee7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22994,7 +22994,7 @@ S:	Maintained
>  F:	drivers/leds/leds-net48xx.c
>  
>  SOFT-IWARP DRIVER (siw)
> -M:	Bernard Metzler <bmt@zurich.ibm.com>
> +M:	Bernard Metzler <bernard.metzler@linux.dev>
>  L:	linux-rdma@vger.kernel.org
>  S:	Supported
>  F:	drivers/infiniband/sw/siw/
> -- 
> 2.50.0
> 

