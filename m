Return-Path: <linux-rdma+bounces-3782-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2674792CA65
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 08:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59A3281C50
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 06:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEE050A80;
	Wed, 10 Jul 2024 06:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AijnoF2E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC491A28D
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2024 06:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720591775; cv=none; b=AShhdA4sW0vUJTPdVy62h/1kXSslbZ+W0m5iwfocUCwuQ2sVc10m1GdJdPmczAvBma1iY12XlZRk7jIVf+iOEFRxmKyQ2cdJCUMJXWiRhmT8+Nit1hWoqVu6hV1Unwh5fs8x6z3GU85eplFcY4t4U6gT1QVEd0pABDVU/dmaiDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720591775; c=relaxed/simple;
	bh=MqsduHl6zqAFfFE/sgEssinmtbsFISnVFZmF1aJQOnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=th6g8lmwHc7rvPMuVVyD//yA3ClEd+y3zDZZq8OgqvadyEXoG1TaJjIgtMuLbfbgUSu7grwOXlgqlbemNIHuA0eVc+AwBJWlyF/OS0HLYniOkloV4eDXHBbGEjfD2DlUO8KcbtYEibINnkFwi/hwKFHdyovMDeu9pxpUkSxVkqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AijnoF2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C22C32781;
	Wed, 10 Jul 2024 06:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720591775;
	bh=MqsduHl6zqAFfFE/sgEssinmtbsFISnVFZmF1aJQOnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AijnoF2EkeoCqt439NnRlTCCpsbAyaAr6yVgeWMobS6Sixth2By0emdnBLYeuMotf
	 W3l26co7bPN82D1r10lPy/+CoYIyKHZg7W1Q5kmnF2yM5ey6OXwh3PXxqgj5jBJhc4
	 KSKeePCdtJqk4jX8pQ1lgRagkxh0S2XazSWHcDdIcUl3xCwoXap8DjjnbYJOpZo6Eq
	 9Epu7D+RWID+HPF2bUuF53HAjLJ9LTYL3oyXVhVktxLIuBHJu1805pmP7ajoNlkvi6
	 iCcf9bARvnetZbPcn72IttpK7MCR6NRhJ13qAuwrT0UuvKlJFvL9xoSOt3qkPwWaVs
	 yzXFaHMjaEddg==
Date: Wed, 10 Jul 2024 09:09:29 +0300
From: Leon Romanovsky <leon@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca
Subject: Re: [PATCH] RDMA: Fix netdev tracker in ib_device_set_netdev
Message-ID: <20240710060929.GI6668@unreal>
References: <20240709214455.17823-1-dsahern@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709214455.17823-1-dsahern@kernel.org>

On Tue, Jul 09, 2024 at 03:44:55PM -0600, David Ahern wrote:
> If a netdev has already been assigned, ib_device_set_netdev needs to release
> the reference on the older but it is mistakenly being called for the new
> netdev. Fix it and in the process use netdev_put to be symmetrical with
> the netdev_hold.
> 
> Fixes: 09f530f0c6d6 ("RDMA: Add netdevice_tracker to ib_device_set_netdev()")
> Signed-off-by: David Ahern <dsahern@kernel.org>
> ---
>  drivers/infiniband/core/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 55aa7aa32d4a..7ddaec923569 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2167,7 +2167,7 @@ int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
>  	}
>  
>  	if (old_ndev)
> -		netdev_tracker_free(ndev, &pdata->netdev_tracker);
> +		netdev_put(old_ndev, &pdata->netdev_tracker);

It should stay netdev_tracker_free() and not netdev_put(). We are
calling to __dev_put(old_ndev) later in the function.

Thanks

>  	if (ndev)
>  		netdev_hold(ndev, &pdata->netdev_tracker, GFP_ATOMIC);
>  	rcu_assign_pointer(pdata->netdev, ndev);
> -- 
> 2.30.2

