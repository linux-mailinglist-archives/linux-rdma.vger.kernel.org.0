Return-Path: <linux-rdma+bounces-3818-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC5592E451
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 12:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67E1FB21B45
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 10:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B64156C6C;
	Thu, 11 Jul 2024 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tx+O+0Ox"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8644779E
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2024 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693053; cv=none; b=FXIzHA26colcqU8Q1Q3e/e8o6u7cfWRK7qzy+uIpLIzgZS07p9lk3htBsOsY7aOkznMmPADnm3hupyiliHGK5zOktQgur9AEn62WDyquNHziVvSFtK+mwhP8I3jCeaJiUtHxpO7dCEL6M4p5MZPrSAqcI+GMFBqGdA0trFuv2l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693053; c=relaxed/simple;
	bh=63VmztZOe71lG+bsMiHLqjU+wBdPOPym35n/Kgb3G8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZ1TiQpZmYfbQOYzTGoIIwHO9SsKDbWpTKd/u98wdjJ/a9XNTsjjVjTJqTH/jZQE31J0XEt22EM9PbCQXxRX7EkgDjsJfX5dFkQ/mtJoUgT/Bo4rkN4DPZmMcBUDKdhWhi7Wnc+oobVIb5XMf9lO+uEACaFPLeuqryGzl4DvlVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tx+O+0Ox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0635C116B1;
	Thu, 11 Jul 2024 10:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720693053;
	bh=63VmztZOe71lG+bsMiHLqjU+wBdPOPym35n/Kgb3G8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tx+O+0OxhnOWd1I0RG97Zd8Q28Yov3H6q6riFUCHQxx56gr45TefHNI1Bp0QME3cf
	 auW+rHW+gxuka0wzMh+Ajh1PKpzFJR5PjjTnb6OLQu1DNWqMOfHBWVtNvs9fswapMy
	 yVbJeBdu4t+KP7UkZwVYXefkmT6Rq0L5F5ZY8LFyRTNJ8EPIUmAqg4LrFKS8gexmIh
	 6Ps5Ei/o38vJ8POfjox2x3tPrQNn31QAn0QlTspavaF/QuBnz4MhnsPHBkz9uJ5h6J
	 QxmE8IDbgyg7c1oOklr5FiQK0o85mnJm3sqotDbYFlYRmMsOFNVtLf+ldAu5LswHz5
	 y2zhljRUJEvtQ==
Date: Thu, 11 Jul 2024 13:17:29 +0300
From: Leon Romanovsky <leon@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca
Subject: Re: [PATCH v2] RDMA: Fix netdev tracker in ib_device_set_netdev
Message-ID: <20240711101729.GQ6668@unreal>
References: <20240710203310.19317-1-dsahern@kernel.org>
 <20240711101237.GP6668@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711101237.GP6668@unreal>

On Thu, Jul 11, 2024 at 01:12:37PM +0300, Leon Romanovsky wrote:
> On Wed, Jul 10, 2024 at 01:33:10PM -0700, David Ahern wrote:
> > If a netdev has already been assigned, ib_device_set_netdev needs to
> > release the reference on the older netdev but it is mistakenly being
> > called for the new netdev. Fix it and in the process use netdev_put
> > to be symmetrical with the netdev_hold.
> > 
> > Fixes: 09f530f0c6d6 ("RDMA: Add netdevice_tracker to ib_device_set_netdev()")
> > Signed-off-by: David Ahern <dsahern@kernel.org>
> > ---
> > v2
> > - remove __dev_put now that netdev_put is used
> > 
> >  drivers/infiniband/core/device.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> > index 55aa7aa32d4a..9b99112baf47 100644
> > --- a/drivers/infiniband/core/device.c
> > +++ b/drivers/infiniband/core/device.c
> > @@ -2167,14 +2167,13 @@ int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
> >  	}
> >  
> >  	if (old_ndev)
> > -		netdev_tracker_free(ndev, &pdata->netdev_tracker);
> > +		netdev_put(old_ndev, &pdata->netdev_tracker);
> >  	if (ndev)
> >  		netdev_hold(ndev, &pdata->netdev_tracker, GFP_ATOMIC);
> >  	rcu_assign_pointer(pdata->netdev, ndev);
> >  	spin_unlock_irqrestore(&pdata->netdev_lock, flags);
> >  
> >  	add_ndev_hash(pdata);
> > -	__dev_put(old_ndev);
> 
> I applied with the following change:
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 49a2ddaf5a38..1f867b7f7020 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2184,14 +2184,12 @@ int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
>                 return 0;
>         }
> 
> -       if (old_ndev)
> -               netdev_put(old_ndev, &pdata->netdev_tracker);
> -       if (ndev)
> -               netdev_hold(ndev, &pdata->netdev_tracker, GFP_ATOMIC);
> +       netdev_hold(ndev, &pdata->netdev_tracker, GFP_ATOMIC);
>         rcu_assign_pointer(pdata->netdev, ndev);
>         spin_unlock_irqrestore(&pdata->netdev_lock, flags);
> 
>         add_ndev_hash(pdata);
> +       netdev_put(old_ndev, &pdata->netdev_tracker);
> 
>         return 0;
>  }

The final version is:
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 49a2ddaf5a38..9c31eef9f590 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2184,15 +2184,12 @@ int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
                return 0;
        }

-       if (old_ndev)
-               netdev_put(old_ndev, &pdata->netdev_tracker);
-       if (ndev)
-               netdev_hold(ndev, &pdata->netdev_tracker, GFP_ATOMIC);
+       netdev_put(old_ndev, &pdata->netdev_tracker);
+       netdev_hold(ndev, &pdata->netdev_tracker, GFP_ATOMIC);
        rcu_assign_pointer(pdata->netdev, ndev);
        spin_unlock_irqrestore(&pdata->netdev_lock, flags);

        add_ndev_hash(pdata);
-
        return 0;
 }
 EXPORT_SYMBOL(ib_device_set_netdev);


> 
> 
> >  
> >  	return 0;
> >  }
> > -- 
> > 2.39.3 (Apple Git-146)
> > 
> > 
> 

