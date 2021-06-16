Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB61E3A93C8
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jun 2021 09:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhFPH3P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 03:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231913AbhFPH3O (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Jun 2021 03:29:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15F8861356;
        Wed, 16 Jun 2021 07:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623828428;
        bh=KcANELai9z4oRKbo/RBV3hu2dXS6JYx56P/gLJVXPVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i5yYILo0Bpz/n4I36L/IGroD/8kSb+fOHwiiQ5BH4qCyShwjwKmp1oGj3ofQATSx5
         od1y2XuPPfhc6oEcHKcz90/Z3DXLfhBnt/zIxMsJQGFL/YeMOS9aQJKwanlsQCGkQj
         B3naIGTwzV+r6cJasL70s3KZoy7WW0sucaXJPbqBDgQRsQJNvcbvflkmunbfbgMb0M
         Jm4YNRNnhY6CWlQXzitkZem/6Ta2mz/WXaWD+dstiuiUZv9eO6hD9Wmiqffzu3e/9t
         LOy2IdXlGyXcqk1oJ26mz+M8kYuJYqV3J+hHZKXhG81EqQrOpvG884iEhnZaGHvBk0
         rKMxmZ5NK8k0A==
Date:   Wed, 16 Jun 2021 10:27:04 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Anand Khoje <anand.a.khoje@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com
Subject: Re: [PATCH v4 for-next 3/3] IB/core: Obtain subnet_prefix from cache
 in IB devices
Message-ID: <YMmnyE+rpLIf6e0B@unreal>
References: <20210616065213.987-1-anand.a.khoje@oracle.com>
 <20210616065213.987-4-anand.a.khoje@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616065213.987-4-anand.a.khoje@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 16, 2021 at 12:22:13PM +0530, Anand Khoje wrote:
> ib_query_port() calls device->ops.query_port() to get the port
> attributes. The method of querying is device driver specific.
> The same function calls device->ops.query_gid() to get the GID and
> extract the subnet_prefix (gid_prefix).
> 
> The GID and subnet_prefix are stored in a cache. But they do not get
> read from the cache if the device is an Infiniband device. The
> following change takes advantage of the cached subnet_prefix.
> Testing with RDBMS has shown a significant improvement in performance
> with this change.
> 
> The function ib_cache_is_initialised() is introduced because
> ib_query_port() gets called early in the stage when the cache is not
> built while reading port immutable property.
> 
> In that case, the default GID still gets read from HCA for IB link-
> layer devices.
> 
> In the situation of an event causing cache update, the subnet_prefix
> will get retrieved from newly updated GID cache in ib_cache_update(),
> so that we do not end up reading a stale value from cache via
> ib_query_port().
> 
> Fixes: fad61ad ("IB/core: Add subnet prefix to port info")
> Suggested-by: Leon Romanovsky <leonro@nvidia.com>
> Suggested-by: Aru Kolappan <aru.kolappan@oracle.com>
> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>
> ---
> 
> v1 -> v2:
>     -   Split the v1 patch in 3 patches as per Leon's suggestion.
> 
> v2 -> v3:
>     -   Added changes as per Mark Zhang's suggestion of clearing
>         flags in git_table_cleanup_one().
> v3 -> v4:
>     -   Removed the enum ib_port_data_flags and 8 byte flags from
>         struct ib_port_data, and the set_bit()/clear_bit() API
>         used to update this flag as that was not necessary.
>         Done to keep the code simple.
>     -   Added code to read subnet_prefix from updated GID cache in the
>         event of cache update. Prior to this change, ib_cache_update
>         was reading the value for subnet_prefix via ib_query_port(),
>         due to this patch, we ended up reading a stale cached value of
>         subnet_prefix.
> 
> ---
>  drivers/infiniband/core/cache.c  | 18 +++++++++++++++---
>  drivers/infiniband/core/device.c |  9 +++++++++
>  include/rdma/ib_cache.h          |  5 +++++
>  include/rdma/ib_verbs.h          |  1 +
>  4 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> index 2325171..cd99c46 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -917,9 +917,11 @@ static void gid_table_cleanup_one(struct ib_device *ib_dev)
>  {
>  	u32 p;
>  
> -	rdma_for_each_port (ib_dev, p)
> +	rdma_for_each_port (ib_dev, p) {
> +		ib_dev->port_data[p].cache_is_initialized = 0;

I think that this line is not needed, we are removing device anyway and
and query_port is not allowed at this stage.

>  		cleanup_gid_table_port(ib_dev, p,
>  				       ib_dev->port_data[p].cache.gid);
> +	}
>  }
>  
>  static int gid_table_setup_one(struct ib_device *ib_dev)
> @@ -1466,6 +1468,7 @@ static int config_non_roce_gid_cache(struct ib_device *device,
>  	struct ib_port_attr       *tprops = NULL;
>  	struct ib_pkey_cache      *pkey_cache = NULL;
>  	struct ib_pkey_cache      *old_pkey_cache = NULL;
> +	union ib_gid               gid;
>  	int                        i;
>  	int                        ret;
>  
> @@ -1523,13 +1526,21 @@ static int config_non_roce_gid_cache(struct ib_device *device,
>  	device->port_data[port].cache.lmc = tprops->lmc;
>  	device->port_data[port].cache.port_state = tprops->state;
>  
> -	device->port_data[port].cache.subnet_prefix = tprops->subnet_prefix;
> +	ret = rdma_query_gid(device, port, 0, &gid);
> +	if (ret) {
> +		write_unlock_irq(&device->cache.lock);
> +		goto err;
> +	}
> +
> +	device->port_data[port].cache.subnet_prefix =
> +			be64_to_cpu(gid.global.subnet_prefix);
> +
>  	write_unlock_irq(&device->cache_lock);
>  
>  	if (enforce_security)
>  		ib_security_cache_change(device,
>  					 port,
> -					 tprops->subnet_prefix);
> +					 be64_to_cpu(gid.global.subnet_prefix));
>  
>  	kfree(old_pkey_cache);
>  	kfree(tprops);
> @@ -1629,6 +1640,7 @@ int ib_cache_setup_one(struct ib_device *device)
>  		err = ib_cache_update(device, p, true, true, true);
>  		if (err)
>  			return err;
> +		device->port_data[p].cache_is_initialized = 1;
>  	}
>  
>  	return 0;
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 7a617e4..57b9039 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2057,6 +2057,15 @@ static int __ib_query_port(struct ib_device *device,
>  	    IB_LINK_LAYER_INFINIBAND)
>  		return 0;
>  
> +	if (!ib_cache_is_initialised(device, port_num))
> +		goto query_gid_from_device;

IMHO, we don't need this new function and can access ib_port_data
directly. In device.c, we have plenty of places that does it.

Not critical.

> +
> +	ib_get_cached_subnet_prefix(device, port_num,
> +				    &port_attr->subnet_prefix);
> +
> +	return 0;
> +
> +query_gid_from_device:
>  	err = device->ops.query_gid(device, port_num, 0, &gid);
>  	if (err)
>  		return err;
> diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h
> index 226ae37..46b43a7 100644
> --- a/include/rdma/ib_cache.h
> +++ b/include/rdma/ib_cache.h
> @@ -114,4 +114,9 @@ ssize_t rdma_query_gid_table(struct ib_device *device,
>  			     struct ib_uverbs_gid_entry *entries,
>  			     size_t max_entries);
>  
> +static inline bool ib_cache_is_initialised(struct ib_device *device,
> +					u32 port_num)
> +{
> +	return device->port_data[port_num].cache_is_initialized;
> +}
>  #endif /* _IB_CACHE_H */
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index c96d601..405f7da 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -2177,6 +2177,7 @@ struct ib_port_data {
>  
>  	spinlock_t netdev_lock;
>  
> +	u8 cache_is_initialized:1;
>  	struct list_head pkey_list;
>  
>  	struct ib_port_cache cache;
> -- 
> 1.8.3.1
> 
