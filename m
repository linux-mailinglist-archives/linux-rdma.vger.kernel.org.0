Return-Path: <linux-rdma+bounces-3815-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215AF92E442
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 12:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12FF28939C
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 10:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74040158A17;
	Thu, 11 Jul 2024 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsrHYEjm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BD3152533
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2024 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692589; cv=none; b=XHMiQYBREG7+LyFFGH//YcQGJvkpIX5Ij6B3oUq5DaC23ucJDH23bIfGTou6MK7sgaL4x8Fz2c6sFAEIytmquiZeGlM8EL0qW4Ka1anuOFLkXUVh1gWYeWytBg6pOPodAvRZa/1DWComkDNopIpKFN40DhVfmvSU4gijq6NyvKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692589; c=relaxed/simple;
	bh=7j1xNdHEBK9mXxUofg9NkttGqq7Y6Yjw2pWIhaKSI6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaUp/hIqOWQRQfoVmVSLGYaI6YdClU+gjYYehm7UE+IFl5eMf76wLUSVmRgX3YLdJjSX+RFqFYMzGRok2wuu4YhA4vCaRkBXovJPvw1LkYFpeZLQVnkHm/H/FPT+o9l6AQYOumQfaSolIZK9nGDt4ccn2RUHLy8vy0nNXqphocQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsrHYEjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426A6C116B1;
	Thu, 11 Jul 2024 10:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720692589;
	bh=7j1xNdHEBK9mXxUofg9NkttGqq7Y6Yjw2pWIhaKSI6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LsrHYEjmWaE0JCguDtxZGjqxy8Mf6giF8rMkqjXR1arwFboazsm/gLnhjxSGRToE4
	 GjplJ/uqGstmya9bNNKCqz09zDyZ7HZ2z8FKtp+Pm/1ihtQ9uy0LObLEctuO/Kdx66
	 i96d3yftoiUQrHyKn3gEc1LjtlnAU+v52N/xpep1qg+11w0ShzkSJEz6uestqEj6Qk
	 wHg7xH/HuPr1XBYPo3tH28Bs7Yewt/R8/6xmhHZZumX80USEmHIAqVaKVu6BflPjIq
	 zq9sndbRTERpQJPA+I8/Ze4xhjcuLhc2s/ORtvMx90elzUO7lwH8YiIOsE4E9Elce9
	 4up/cQ8wPDdZA==
Date: Thu, 11 Jul 2024 13:09:44 +0300
From: Leon Romanovsky <leon@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca
Subject: Re: [PATCH] RDMA: Fix netdev tracker in ib_device_set_netdev
Message-ID: <20240711100944.GO6668@unreal>
References: <20240709214455.17823-1-dsahern@kernel.org>
 <20240710060929.GI6668@unreal>
 <4f38320c-22e4-403e-8d68-ce04e504cedc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f38320c-22e4-403e-8d68-ce04e504cedc@kernel.org>

On Wed, Jul 10, 2024 at 10:59:15AM -0700, David Ahern wrote:
> On 7/10/24 12:09 AM, Leon Romanovsky wrote:
> >> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> >> index 55aa7aa32d4a..7ddaec923569 100644
> >> --- a/drivers/infiniband/core/device.c
> >> +++ b/drivers/infiniband/core/device.c
> >> @@ -2167,7 +2167,7 @@ int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
> >>  	}
> >>  
> >>  	if (old_ndev)
> >> -		netdev_tracker_free(ndev, &pdata->netdev_tracker);
> >> +		netdev_put(old_ndev, &pdata->netdev_tracker);
> > 
> > It should stay netdev_tracker_free() and not netdev_put(). We are
> > calling to __dev_put(old_ndev) later in the function.
> > 
> 
> missed that and KASAN and refcount debugging did not complain ...
> 
> Anyways, why have the 2 split apart? ie., why not remove the __dev_put
> and just do netdev_put here? old_ndev is not needed in between calls.
> Asymmetric calls like this are always confusing.

You probably can combine them, but to do so instead of __dev_put() and
not netdev_tracker_free().

Thanks

