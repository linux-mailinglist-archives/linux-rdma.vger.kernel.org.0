Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F77399D3A
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 10:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhFCI4d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 04:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbhFCI4d (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Jun 2021 04:56:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AD7760FF1;
        Thu,  3 Jun 2021 08:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622710488;
        bh=GsqvnBq33WpcE4YmN+Pd1fKlKnPRMIZjPJ+wZNHLn/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hKutBUY41MNxe01e7r9MvTKwtWZzXlqQm3cjYARCX2XcDIcq/t+9GLXKG6qi+Ko/v
         sMe6eCPhLdfEmd8Uh9Djp1bSrgkiEdgAW2TA1pylSy2vR9MZUwYcMXk5lWbXOJnPn4
         sHx2GIksgNIjlnISex9Raf0VyMQZkBErKqCwSSDxshJoligPOmYPusuH0i+UXbVVcS
         rz1FgpLhV1kuQpm68LyT1fNGUjYgOJwM+5D/zu8M27e3wAuDulmiYbvR1yK+QLvAte
         FYVz360GdTY3Bi1AhPIi8kH0UuCilemL7wD6SWNVB68oMKVGLYfVygigN8dJjdNVjr
         /Vm7ADGfkbCWg==
Date:   Thu, 3 Jun 2021 11:54:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Anand Khoje <anand.a.khoje@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com
Subject: Re: [PATCH v2 1/3] IB/core: Removed port validity check from
 ib_get_cached_subnet_prefix
Message-ID: <YLiY1Q6Y2oTfUJ61@unreal>
References: <20210603065024.1051-1-anand.a.khoje@oracle.com>
 <20210603065024.1051-2-anand.a.khoje@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603065024.1051-2-anand.a.khoje@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 03, 2021 at 12:20:22PM +0530, Anand Khoje wrote:
> Removed port validity check from ib_get_cached_subnet_prefix()
> as this check is not needed because "port_num" is valid.
> 
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/core/cache.c     |  7 ++-----
>  drivers/infiniband/core/core_priv.h |  2 +-
>  drivers/infiniband/core/device.c    | 14 +++++---------
>  drivers/infiniband/core/security.c  |  7 ++-----
>  4 files changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> index 3b0991f..b6700ad 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -1069,19 +1069,16 @@ int ib_get_cached_pkey(struct ib_device *device,
>  }
>  EXPORT_SYMBOL(ib_get_cached_pkey);
>  
> -int ib_get_cached_subnet_prefix(struct ib_device *device, u32 port_num,
> +void ib_get_cached_subnet_prefix(struct ib_device *device, u32 port_num,
>  				u64 *sn_pfx)
>  {
>  	unsigned long flags;
>  
> -	if (!rdma_is_port_valid(device, port_num))
> -		return -EINVAL;
> -
>  	read_lock_irqsave(&device->cache_lock, flags);
>  	*sn_pfx = device->port_data[port_num].cache.subnet_prefix;
>  	read_unlock_irqrestore(&device->cache_lock, flags);
>  
> -	return 0;
> +	return;

"return" is not needed here.

>  }
>  EXPORT_SYMBOL(ib_get_cached_subnet_prefix);
>  
> diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
> index 29809dd..0b23f50 100644
> --- a/drivers/infiniband/core/core_priv.h
> +++ b/drivers/infiniband/core/core_priv.h
> @@ -214,7 +214,7 @@ int ib_nl_handle_ip_res_resp(struct sk_buff *skb,
>  			     struct nlmsghdr *nlh,
>  			     struct netlink_ext_ack *extack);
>  
> -int ib_get_cached_subnet_prefix(struct ib_device *device,
> +void ib_get_cached_subnet_prefix(struct ib_device *device,
>  				u32 port_num,
>  				u64 *sn_pfx);
>  
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index c660cef..c2fa592 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -886,15 +886,11 @@ static void ib_policy_change_task(struct work_struct *work)
>  
>  		rdma_for_each_port (dev, i) {
>  			u64 sp;

Please add extra blank line after variable declaration or simply move it
outside of rdma_for_each_port() loop.

> -			int ret = ib_get_cached_subnet_prefix(dev,
> -							      i,
> -							      &sp);
> -
> -			WARN_ONCE(ret,
> -				  "ib_get_cached_subnet_prefix err: %d, this should never happen here\n",
> -				  ret);
> -			if (!ret)
> -				ib_security_cache_change(dev, i, sp);
> +			ib_get_cached_subnet_prefix(dev,
> +						    i,
> +						    &sp);

Strange line formatting, please use clang-formatter and don't break the line.

> +
> +			ib_security_cache_change(dev, i, sp);
>  		}
>  	}
>  	up_read(&devices_rwsem);
> diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
> index e5a78d1..5433912 100644
> --- a/drivers/infiniband/core/security.c
> +++ b/drivers/infiniband/core/security.c
> @@ -72,7 +72,7 @@ static int get_pkey_and_subnet_prefix(struct ib_port_pkey *pp,
>  	if (ret)
>  		return ret;
>  
> -	ret = ib_get_cached_subnet_prefix(dev, pp->port_num, subnet_prefix);
> +	ib_get_cached_subnet_prefix(dev, pp->port_num, subnet_prefix);
>  
>  	return ret;
>  }
> @@ -664,10 +664,7 @@ static int ib_security_pkey_access(struct ib_device *dev,
>  	if (ret)
>  		return ret;
>  
> -	ret = ib_get_cached_subnet_prefix(dev, port_num, &subnet_prefix);
> -
> -	if (ret)
> -		return ret;
> +	ib_get_cached_subnet_prefix(dev, port_num, &subnet_prefix);
>  
>  	return security_ib_pkey_access(sec, subnet_prefix, pkey);
>  }
> -- 
> 1.8.3.1
> 
