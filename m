Return-Path: <linux-rdma+bounces-2277-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 583058BC0B4
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 16:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9206CB20B8A
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 14:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677082232A;
	Sun,  5 May 2024 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVTDNHPw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F728208CA;
	Sun,  5 May 2024 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714918570; cv=none; b=AMh0Fj/k6gMVaVDRB9+iDBXbXliBe84GQES98y6Jzn2/5no9GTQaOszcXel/Gc5rlo2z/rVwRP78yk/0OB/IjLaT4vxQjxsw++FrbaY8QRdtZum5i6NBMJeoRmOKnLARUmKag6PG+SGlntbp+sx9TJSx8Z5OXBi04R7B/Z/Y6Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714918570; c=relaxed/simple;
	bh=DLchroJz79kbL2e5l1H7RnbQisLdhsuaVztVjGH3kvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAPqBnXSv7IYrAth9Z261pN6+OXBWbND5YhQa26ZeeHVKgQTNrZaf17OUdXkSiQnUvuNIDXiLR5+AyxY89gbb4PPryEd95DRaQWeI1l8OZzmpKElXBL7bg62tqEYPo68ylF//Oaa7Ezrgzmmm3S2gMuwrwYEVK6iI3Xdq4AZgko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVTDNHPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B99C113CC;
	Sun,  5 May 2024 14:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714918569;
	bh=DLchroJz79kbL2e5l1H7RnbQisLdhsuaVztVjGH3kvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OVTDNHPwAr6VpIZAeu3LIunGe1FT2I2+Bc7LitboltauXKb2grFN/LaZDsBpRKXPO
	 yV9fyMEcDhPJbFtufGoWzz0yuLTUMWR5J1QSPj8LOpda35NqL+InZh4w+J9uTFkKf+
	 tkJwYWsvWVxl2keiuqyoCN7ZzUHdP8qO6K+JnrrYLaFexP/NvECP1YoNnhOqGzVSiM
	 RumCcQRFqWSNbrgq5NH57OhjLbBTWw2bXca3W+ABodKXAL64kJlFTOdmrBcgNKfHQz
	 FBoJh81PUktvgnHjNGLZkpeWfFI8dJ2zB1cKCCMHrbAJY4DT1oB4vqRjgPcZfH5wUW
	 FNYh8m8PbKVIQ==
Date: Sun, 5 May 2024 17:16:05 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Breno Leitao <leitao@debian.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, netdev@vger.kernel.org,
	"open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] IB/hfi1: Remove generic .ndo_get_stats64
Message-ID: <20240505141605.GF68202@unreal>
References: <20240503111333.552360-1-leitao@debian.org>
 <20240503111333.552360-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503111333.552360-2-leitao@debian.org>

On Fri, May 03, 2024 at 04:13:32AM -0700, Breno Leitao wrote:
> Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
> configured") moved the callback to dev_get_tstats64() to net core, so,
> unless the driver is doing some custom stats collection, it does not
> need to set .ndo_get_stats64.
> 
> Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
> doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
> function pointer.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/infiniband/hw/hfi1/ipoib_main.c | 1 -
>  1 file changed, 1 deletion(-)

Dennis,

Please pay attention that 3e2f544dd8a33 ("net: get stats64 if device if
driver is configured") is not in RDMA tree yet, but we are approaching
merge window and linux-next is already have it.

Thanks

> 
> diff --git a/drivers/infiniband/hw/hfi1/ipoib_main.c b/drivers/infiniband/hw/hfi1/ipoib_main.c
> index 59c6e55f4119..7c9d5203002b 100644
> --- a/drivers/infiniband/hw/hfi1/ipoib_main.c
> +++ b/drivers/infiniband/hw/hfi1/ipoib_main.c
> @@ -96,7 +96,6 @@ static const struct net_device_ops hfi1_ipoib_netdev_ops = {
>  	.ndo_uninit       = hfi1_ipoib_dev_uninit,
>  	.ndo_open         = hfi1_ipoib_dev_open,
>  	.ndo_stop         = hfi1_ipoib_dev_stop,
> -	.ndo_get_stats64  = dev_get_tstats64,
>  };
>  
>  static int hfi1_ipoib_mcast_attach(struct net_device *dev,
> -- 
> 2.43.0
> 

