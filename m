Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17183A93EB
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jun 2021 09:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhFPHca (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 03:32:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232010AbhFPHcZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Jun 2021 03:32:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 671AD6044F;
        Wed, 16 Jun 2021 07:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623828620;
        bh=AtPZETMQfDlVwaPKTN13KJ1TnXAOl86TlunvJ+giqQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SmbwDkTaAtzCdGIoo3TjArnHzGu4mMtE5z69zB4RF6vPqusQ/pDqCQ1zDLZPLj4Ju
         0LjblC76piWB8sZ3PZXQi6QbKSY+HPvCi61FNrq49Lrk/VlAPGTdeNafVPkj174Ie5
         vRyAmtL9XVFUxnmejAUBsiOA9NK90S2xbXlbpkuhogGpD2LOvz3KEhP25uS7GpbA2K
         sNdKzrk8vo3broeYW22Dr4a++wkQRu4A/+pARShU4NqEuYcudYaSGBirvCvnZvz9Kc
         q5DDVkslM6XZ2fi0AbPNardkV8RhhPWaMTiYJ1HrnmfXAYxmRbD4Vtu932X7l30K4t
         1beWfKGXgIDhg==
Date:   Wed, 16 Jun 2021 10:30:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Anand Khoje <anand.a.khoje@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com
Subject: Re: [PATCH v4 for-next 3/3] IB/core: Obtain subnet_prefix from cache
 in IB devices
Message-ID: <YMmoiD5mXm4/OWj3@unreal>
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

<...>

> @@ -1523,13 +1526,21 @@ static int config_non_roce_gid_cache(struct ib_device *device,
>  	device->port_data[port].cache.lmc = tprops->lmc;
>  	device->port_data[port].cache.port_state = tprops->state;
>  
> -	device->port_data[port].cache.subnet_prefix = tprops->subnet_prefix;
> +	ret = rdma_query_gid(device, port, 0, &gid);
> +	if (ret) {
> +		write_unlock_irq(&device->cache.lock);

And this patch can't compile. It should be cache_lock and not cache.lock.

Thanks
