Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8323C3AAC9F
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jun 2021 08:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhFQGoC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Jun 2021 02:44:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhFQGn7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Jun 2021 02:43:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF7D3610A1;
        Thu, 17 Jun 2021 06:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623912112;
        bh=k22wDppAh/+MfBvxHK3lLfrhgV48Cp0+hy+NlhOezjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k08qDhZlti1TGwtsRZt2sGX5il6HZSEPQc9KEU9lcYZJ9epJmsJhpdQhHJo+8JEH8
         z+uvVXOG6rQoPoalYEBq8a1AQBGwW+LtHW7etqnBNL7/j4hsMvJ+/o8WeqsxHMjh1r
         LoLKrExPTPT9OJWkitYeLYaZCCX3meQ69TMJ7Znqc0tM5loMkBaZGKTqg347zPV1Di
         m+ggFt9C8a2N2O+Vu6BQR+c2q8UtqJIU6tl3lpFSlys9YeSoNedn3zzesycIq24dpL
         jh/zQzUaBGBKVRPGLSEgwiOx0s75d+5KfrJphRDuHnDmmNuQz9ZAZjJ45s4pWnHvgg
         U9W90I8i+UCbQ==
Date:   Thu, 17 Jun 2021 09:41:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Anand Khoje <anand.a.khoje@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com
Subject: Re: [PATCH v5 for-next 3/3] IB/core: Obtain subnet_prefix from cache
 in IB devices
Message-ID: <YMruq7pXGcxwW1Ne@unreal>
References: <20210616154509.1047-1-anand.a.khoje@oracle.com>
 <20210616154509.1047-4-anand.a.khoje@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616154509.1047-4-anand.a.khoje@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 16, 2021 at 09:15:09PM +0530, Anand Khoje wrote:
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
> v4 -> v5:
>     -   Removed the code to reset cache_is_initialised bit from cleanup
>         as per Leon's suggestion.
>     -   Removed ib_cache_is_initialised() function.
> 
> ---
>  drivers/infiniband/core/cache.c  | 14 ++++++++++++--
>  drivers/infiniband/core/device.c |  9 +++++++++
>  include/rdma/ib_verbs.h          |  1 +
>  3 files changed, 22 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
