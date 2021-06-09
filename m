Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819E13A0ED1
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 10:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbhFIIjS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 04:39:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232333AbhFIIjS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Jun 2021 04:39:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E57261285;
        Wed,  9 Jun 2021 08:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623227844;
        bh=TG0XNosqjGnib4pkkze7Jw7/X+EAzPSRH0ty43ce6EI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l4voZ/2Inn6lOW+y3VoWnc0Lt4jTaU4g2GIN87FcotsIeYHN9N5e57He1a6uBWSPi
         HDRkH36CRTgpYMrB53g+VQ5swizXsnsQrEIGZ154b4iCYeCsSLOHDiBZJJWYjkT/I7
         YDip+fwcUFuuXDolzbl4a8hGQ8mE8fBpw3yO4SUyzPJ97/idEzqbau1ElnR7s6Je+E
         mno1L32X5vteD7BX0QjFQIiyy/eHpNF3Oe4qoXb//jy3dH5ZDNVJVZjQTe7nDaGixK
         IrljHQSBxgtyHIutdKlLaK50VtLUTrRDXem+zEN2cmExu9p4byFN633mXyt+lsB1KI
         7nv8QAuuwabww==
Date:   Wed, 9 Jun 2021 11:37:20 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Anand Khoje <anand.a.khoje@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com
Subject: Re: [PATCH v3 1/3] IB/core: Removed port validity check from
 ib_get_cached_subnet_prefix
Message-ID: <YMB9wEygi58hjDLy@unreal>
References: <20210609055534.855-1-anand.a.khoje@oracle.com>
 <20210609055534.855-2-anand.a.khoje@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609055534.855-2-anand.a.khoje@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 09, 2021 at 11:25:32AM +0530, Anand Khoje wrote:
> Removed port validity check from ib_get_cached_subnet_prefix()
> as this check is not needed because "port_num" is valid.
> 
> Suggested-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>
> 
> ---
> 
> v1 -> v2:
>     -	Added changes as per Leon's suggestion of removing port
>     validity check from ib_get_cached_subnet_prefix().
>     -	Split the v1 patch in 3 patches as per Leon's suggestion.
> v2 -> v3:
>     -	Added some formatting changes per Leon's suggestions
>     and removed return from ib_get_cached_subnet_prefix.
> 
> ---
>  drivers/infiniband/core/cache.c     |  6 +-----
>  drivers/infiniband/core/core_priv.h |  2 +-
>  drivers/infiniband/core/device.c    | 13 ++++---------
>  drivers/infiniband/core/security.c  |  7 ++-----
>  4 files changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> index 3b0991fedd81..e957f0c915a3 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -1069,19 +1069,15 @@ int ib_get_cached_pkey(struct ib_device *device,
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
>  }
>  EXPORT_SYMBOL(ib_get_cached_subnet_prefix);
>  
> diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
> index 29809dd30041..0b23f50fa958 100644
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
> index c660cef66ac6..595128b26c34 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -886,15 +886,10 @@ static void ib_policy_change_task(struct work_struct *work)
>  
>  		rdma_for_each_port (dev, i) {
>  			u64 sp;
> -			int ret = ib_get_cached_subnet_prefix(dev,
> -							      i,
> -							      &sp);
> -
> -			WARN_ONCE(ret,
> -				  "ib_get_cached_subnet_prefix err: %d, this should never happen here\n",
> -				  ret);
> -			if (!ret)
> -				ib_security_cache_change(dev, i, sp);
> +
> +			ib_get_cached_subnet_prefix(dev, i, &sp);
> +
> +			ib_security_cache_change(dev, i, sp);

nitpick, the blank line is not needed.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
