Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CAE377648
	for <lists+linux-rdma@lfdr.de>; Sun,  9 May 2021 13:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhEILJI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 May 2021 07:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhEILJH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 9 May 2021 07:09:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED17C61396;
        Sun,  9 May 2021 11:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620558484;
        bh=jnkySADCIs5Pzpl5DJMqRKXJjdljHKpLIiFpwXEeqVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YRU1G7fW7vNcTSOyGtdEua5pDSvKwP/Zmc9x8P5YRcR66+kGioCCSqjY4SGWxqGmN
         buH8gLoPwAkRIM6h9gJIYw5GwdbE9KYYAFfcexsEPXnBcFCHrQbEmoKZG/EkdPhSJq
         GDDNkoIsb6Of8Xn5uDgv6HL4sAJ2B5DB1xKYZjBsaDdWWOWkNBBTz+D5PmZMAnC+CN
         srD7pN6lxpYfMWs7DrpCLVMvHugADIzztPzBtu5XXkmWIhX1CewF72An2i8UNh4bAR
         Uuce7pd7vCPJ7cjA3RFLoQW2D2DVEHymynOY5So+EUkL+9wsu44zkWZktykrBzSpn9
         5VuRGARJQfCCw==
Date:   Sun, 9 May 2021 14:08:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Anand Khoje <anand.a.khoje@oracle.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, avihaih@nvidia.com,
        liangwenpeng@huawei.com, jackm@dev.mellanox.co.il,
        galpress@amazon.com, kamalheib1@gmail.com, mbloch@nvidia.com,
        lee.jones@linaro.org, maorg@mellanox.com, maxg@mellanox.com,
        parav@nvidia.com, eli@mellanox.com, ogerlitz@mellanox.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haakon Bugge <haakon.bugge@oracle.com>
Subject: Re: [PATCH] IB/core: Obtain subnet_prefix from cache in IB devices
Message-ID: <YJfCkMETxfnzd5rD@unreal>
References: <20210507140638.339-1-anand.a.khoje@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507140638.339-1-anand.a.khoje@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 07, 2021 at 07:36:38PM +0530, Anand Khoje wrote:
> ib_query_port() calls device->ops.query_port() to get the port
> attributes. The method of querying is device driver specific.
> The same function calls device->ops.query_gid() to get the GID and
> extract the subnet_prefix (gid_prefix).

Please add blank lines to separate paragraphs.

> The GID and subnet_prefix are stored in a cache. But they do not get
> read from the cache if the device is an Infiniband device. The
> following change takes advantage of the cached subnet_prefix.
> Testing with RDBMS has shown a significant improvement in performance
> with this change.

Here too

> The function ib_cache_is_initialised() is introduced because
> ib_query_port() gets called early in the stage when the cache is not
> built while reading port immutable property.
> In that case, the default GID still gets read from HCA for IB link
> layer.  The shuffling of netdev_lock in struct ib_port_data is done
> such that the size of struct ib_port_data remains the same after
> adding flags.
> 
> Fixes: fad61ad ("IB/core: Add subnet prefix to port info")
> 

No blank line here.

> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/core/cache.c  |  7 ++++++-
>  drivers/infiniband/core/device.c | 11 +++++++++++
>  include/rdma/ib_cache.h          |  7 +++++++
>  include/rdma/ib_verbs.h          | 10 +++++++++-
>  4 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> index 3b0991f..b580c26 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -1627,6 +1627,8 @@ int ib_cache_setup_one(struct ib_device *device)
>  		err = ib_cache_update(device, p, true);
>  		if (err)
>  			return err;
> +		set_bit(IB_PORT_CACHE_INITIALIZED,
> +			&device->port_data[p].flags);
>  	}
>  
>  	return 0;
> @@ -1642,8 +1644,11 @@ void ib_cache_release_one(struct ib_device *device)
>  	 * all the device's resources when the cache could no
>  	 * longer be accessed.
>  	 */
> -	rdma_for_each_port (device, p)
> +	rdma_for_each_port (device, p) {
> +		clear_bit(IB_PORT_CACHE_INITIALIZED,
> +			  &device->port_data[p].flags);
>  		kfree(device->port_data[p].cache.pkey);
> +	}
>  
>  	gid_table_release_one(device);
>  }
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index c660cef..6d62023 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2064,6 +2064,17 @@ static int __ib_query_port(struct ib_device *device,
>  	    IB_LINK_LAYER_INFINIBAND)
>  		return 0;
>  
> +	if (!ib_cache_is_initialised(device, port_num))
> +		goto query_gid_from_device;
> +
> +	err = ib_get_cached_subnet_prefix(device, port_num,
> +			&port_attr->subnet_prefix);

Can you please make ib_get_cached_subnet_prefix() void and move port
check to the security.c?

> +	if (err)
> +		goto query_gid_from_device;
> +
> +	return 0;
> +
> +query_gid_from_device:
>  	err = device->ops.query_gid(device, port_num, 0, &gid);
>  	if (err)
>  		return err;
> diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h
> index 226ae37..bebeb94 100644
> --- a/include/rdma/ib_cache.h
> +++ b/include/rdma/ib_cache.h
> @@ -114,4 +114,11 @@ ssize_t rdma_query_gid_table(struct ib_device *device,
>  			     struct ib_uverbs_gid_entry *entries,
>  			     size_t max_entries);
>  
> +static inline bool ib_cache_is_initialised(struct ib_device *device,
> +					   u8 port_num)
> +{
> +	return test_bit(IB_PORT_CACHE_INITIALIZED,
> +			&device->port_data[port_num].flags);
> +}
> +
>  #endif /* _IB_CACHE_H */
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 7e2f369..ad2a55e 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -2169,17 +2169,25 @@ struct ib_port_immutable {
>  	u32                           max_mad_size;
>  };
>  
> +enum ib_port_data_flags {
> +	IB_PORT_CACHE_INITIALIZED = 1 << 0,
> +};
> +
>  struct ib_port_data {
>  	struct ib_device *ib_dev;
>  
>  	struct ib_port_immutable immutable;
>  
>  	spinlock_t pkey_list_lock;
> +
> +	spinlock_t netdev_lock;

This change is unrelated.

> +
> +	unsigned long flags;
> +
>  	struct list_head pkey_list;
>  
>  	struct ib_port_cache cache;
>  
> -	spinlock_t netdev_lock;
>  	struct net_device __rcu *netdev;
>  	struct hlist_node ndev_hash_link;
>  	struct rdma_port_counter port_counter;
> -- 
> 1.8.3.1
> 
