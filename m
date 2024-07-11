Return-Path: <linux-rdma+bounces-3816-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7F192E44A
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 12:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8E11C21B14
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 10:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A40158206;
	Thu, 11 Jul 2024 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBlxCrAg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3793515748F
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2024 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692763; cv=none; b=FBLtd5XF9MQXoWGL4TzyYekDyefEgaG3OaKuSskbtuwRUjCX4YdjOmpY2Zq4K/vzD9gLajQCGwTl+GemdqpYUUe3FB/vd0pzKo8d0zf1MMf0QSAL8DWNxpcst5u76nSUqe2fGpxTVTjPNyIYKIgXVM6KUKcgJ5Ku0kU5gN5RJfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692763; c=relaxed/simple;
	bh=xsYOWhwY0MS2Zr/cCYKcYcDoA9RBXfkjYoEFfPgDTNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eY241Zn/6znbI4cme3u8nDA6lZEKonSO8WUOfy/FBIKZAk7vrjM01KaMOv+3aP82XAfaD+iBeYddwPiyE17WzWiRI3s/T+COaLp8YIhhcAFHKLkh1hFrRZ/EvKMeDtHjFhgINwvrgI+kL46Qm77jnypj1pVlUMmK6rTMWRi+pqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBlxCrAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10880C116B1;
	Thu, 11 Jul 2024 10:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720692762;
	bh=xsYOWhwY0MS2Zr/cCYKcYcDoA9RBXfkjYoEFfPgDTNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UBlxCrAgRJamjpAjkKFqkyUY6dqix47/u+skoudR+0VeUeLdT7KglC530Ya8KueeP
	 YHtqaiPFcm8Z7u7Ne8FqlV1awEgx2Dl976OqDxVntWXer7K4/omBO/Q+3nWaaagPMC
	 DhLxPd3f712EFNlvQ4NXu2KqHPpSwrFVD0SDfgeqxtqbouOWNTs0w8tIKRqeN2xKKQ
	 dyH+aEwSQDF1wzTUKz8djcfAGSkblThUFB1ey2D6/OI0MrW4uJrz2rbBOITxzF5hDB
	 RrU8dqLHSZO5845egYWzzBWjV9AkMdb6NuTn5P7bjbb0wlHde7tZieRyeGk0idVbC3
	 cZjejKEQbWR9g==
Date: Thu, 11 Jul 2024 13:12:37 +0300
From: Leon Romanovsky <leon@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca
Subject: Re: [PATCH v2] RDMA: Fix netdev tracker in ib_device_set_netdev
Message-ID: <20240711101237.GP6668@unreal>
References: <20240710203310.19317-1-dsahern@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710203310.19317-1-dsahern@kernel.org>

On Wed, Jul 10, 2024 at 01:33:10PM -0700, David Ahern wrote:
> If a netdev has already been assigned, ib_device_set_netdev needs to
> release the reference on the older netdev but it is mistakenly being
> called for the new netdev. Fix it and in the process use netdev_put
> to be symmetrical with the netdev_hold.
> 
> Fixes: 09f530f0c6d6 ("RDMA: Add netdevice_tracker to ib_device_set_netdev()")
> Signed-off-by: David Ahern <dsahern@kernel.org>
> ---
> v2
> - remove __dev_put now that netdev_put is used
> 
>  drivers/infiniband/core/device.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 55aa7aa32d4a..9b99112baf47 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2167,14 +2167,13 @@ int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
>  	}
>  
>  	if (old_ndev)
> -		netdev_tracker_free(ndev, &pdata->netdev_tracker);
> +		netdev_put(old_ndev, &pdata->netdev_tracker);
>  	if (ndev)
>  		netdev_hold(ndev, &pdata->netdev_tracker, GFP_ATOMIC);
>  	rcu_assign_pointer(pdata->netdev, ndev);
>  	spin_unlock_irqrestore(&pdata->netdev_lock, flags);
>  
>  	add_ndev_hash(pdata);
> -	__dev_put(old_ndev);

I applied with the following change:
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 49a2ddaf5a38..1f867b7f7020 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2184,14 +2184,12 @@ int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
                return 0;
        }

-       if (old_ndev)
-               netdev_put(old_ndev, &pdata->netdev_tracker);
-       if (ndev)
-               netdev_hold(ndev, &pdata->netdev_tracker, GFP_ATOMIC);
+       netdev_hold(ndev, &pdata->netdev_tracker, GFP_ATOMIC);
        rcu_assign_pointer(pdata->netdev, ndev);
        spin_unlock_irqrestore(&pdata->netdev_lock, flags);

        add_ndev_hash(pdata);
+       netdev_put(old_ndev, &pdata->netdev_tracker);

        return 0;
 }


>  
>  	return 0;
>  }
> -- 
> 2.39.3 (Apple Git-146)
> 
> 

