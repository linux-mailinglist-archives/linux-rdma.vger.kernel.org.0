Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE901650CF
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 22:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgBSVBf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 16:01:35 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:37214 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgBSVBd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 16:01:33 -0500
Received: by mail-qv1-f65.google.com with SMTP id s6so867414qvq.4
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 13:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v594jXI6BxuvSctASIqp/10obeML/AEvwnKC9T7KLCs=;
        b=ldXYzIwNvVi2sSI/giJwe2vtBHJ7FVp9WU8vV8tJAqmK0lFfvZMnbCG1I4Cv7YepJU
         FP/bNUcyg+HmPh6nApM58Vx11JIweJOk//hAOpiUKqjb1cJ1rZn9zhXezT9GrGceSHHC
         wZzVTFTBlwwDSuXoa3iIjKLpZyGFd9oR3b4QL2jpjqq9XQHMn7epyDq9PrrzgGmEIYT8
         LbyeHQ/OQzxD8sucDjOT5XmhSqYycXKEBXEC5kYlqIouYuqfA4G0WVVo+GjWK2KMft5i
         r9QiOXGgsWWTewgmu4R47DofitwgGlEFK6jk2ua4isfSl2ZgaoEGcweJVkSy3UZbgNXf
         r9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v594jXI6BxuvSctASIqp/10obeML/AEvwnKC9T7KLCs=;
        b=POL/kazCXYUL2P67UdLOuGwACh3J+yPy9oWJnH4FfFovLaE2nhdLfen3/5vT9pxDkr
         2H+ANEhsKOysy2/gBad+N6XY5y7LnJDXvpuvvVAM8TdfLoNEbTQA/iHGhsBrE42NBQHq
         sc2XbRNs/GWBoW37rTEDaWSzMWAqI1s3cwfyb7LUQ3O5RSeSwGGdJbmmmIuLBQHrtiLQ
         usWNhqFl9TVaBJrBe4gthgi6+oxANRcCO8VIPykiTa6eyLDd2V4sQS2jphzR3cSnEIJi
         oHlU3p/uFb+hW0GEFfORthoutceF/t2+ENVz37wTrkUmPz0o0j9wCNHd3otC++/P6Aos
         wDpA==
X-Gm-Message-State: APjAAAXW0YD6bU/rfdrZa6FASTcbIP+DpKXlKFMePQHaFditFsHcFVsH
        soTVhWHMMbJkCcm0+0BdtpZ86g==
X-Google-Smtp-Source: APXvYqxFNf/EEHkw+Bh5HCSzgjsWryY9i60n2ONGtmN7oOxsLg0nmrIxpIJ8WHpAy2mvBi8I+blNuQ==
X-Received: by 2002:a0c:c250:: with SMTP id w16mr21761725qvh.24.1582146091472;
        Wed, 19 Feb 2020 13:01:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id j58sm665819qtk.27.2020.02.19.13.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 13:01:31 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4WTK-0006xS-K6; Wed, 19 Feb 2020 17:01:30 -0400
Date:   Wed, 19 Feb 2020 17:01:30 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH RFC v2 for-next 1/7] RDMA/core: add inactive attribute of
 ib_port_cache
Message-ID: <20200219210130.GY31668@ziepe.ca>
References: <20200204082408.18728-1-liweihang@huawei.com>
 <20200204082408.18728-2-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204082408.18728-2-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 04, 2020 at 04:24:02PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> Add attribute inactive to mark bonding backup port.
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>  drivers/infiniband/core/cache.c | 16 +++++++++++++++-
>  include/rdma/ib_cache.h         | 10 ++++++++++
>  include/rdma/ib_verbs.h         |  2 ++
>  3 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> index d535995..7a7ef0e 100644
> +++ b/drivers/infiniband/core/cache.c
> @@ -1175,6 +1175,19 @@ int ib_get_cached_port_state(struct ib_device   *device,
>  }
>  EXPORT_SYMBOL(ib_get_cached_port_state);
>  
> +u8 ib_get_cached_port_inactive_status(struct ib_device *device, u8 port_num)
> +{
> +	unsigned long flags;
> +	u8 inactive;
> +
> +	read_lock_irqsave(&device->cache.lock, flags);
> +	inactive = device->port_data[port_num].cache.inactive;
> +	read_unlock_irqrestore(&device->cache.lock, flags);
> +
> +	return inactive;
> +}
> +EXPORT_SYMBOL(ib_get_cached_port_inactive_status);
> +
>  /**
>   * rdma_get_gid_attr - Returns GID attributes for a port of a device
>   * at a requested gid_index, if a valid GID entry exists.
> @@ -1393,7 +1406,7 @@ static void ib_cache_update(struct ib_device *device,
>  	if (!rdma_is_port_valid(device, port))
>  		return;
>  
> -	tprops = kmalloc(sizeof *tprops, GFP_KERNEL);
> +	tprops = kzalloc(sizeof *tprops, GFP_KERNEL);
>  	if (!tprops)
>  		return;
>  
> @@ -1435,6 +1448,7 @@ static void ib_cache_update(struct ib_device *device,
>  	device->port_data[port].cache.pkey = pkey_cache;
>  	device->port_data[port].cache.lmc = tprops->lmc;
>  	device->port_data[port].cache.port_state = tprops->state;
> +	device->port_data[port].cache.inactive = tprops->inactive;
>  
>  	device->port_data[port].cache.subnet_prefix = tprops->subnet_prefix;
>  	write_unlock_irq(&device->cache.lock);
> diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h
> index 870b5e6..63b2dd6 100644
> +++ b/include/rdma/ib_cache.h
> @@ -131,6 +131,16 @@ int ib_get_cached_port_state(struct ib_device *device,
>  			      u8                port_num,
>  			      enum ib_port_state *port_active);
>  
> +/**
> + * ib_get_cached_port_inactive_status - Returns a cached port inactive status
> + * @device: The device to query.
> + * @port_num: The port number of the device to query.
> + *
> + * ib_get_cached_port_inactive_status() fetches the specified event inactive
> + * status stored in the local software cache.
> + */
> +u8 ib_get_cached_port_inactive_status(struct ib_device *device, u8 port_num);
> +

kdocs belong with the implementation, not in the header file

>  bool rdma_is_zero_gid(const union ib_gid *gid);
>  const struct ib_gid_attr *rdma_get_gid_attr(struct ib_device *device,
>  					    u8 port_num, int index);
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 5608e14..e17d846 100644
> +++ b/include/rdma/ib_verbs.h
> @@ -665,6 +665,7 @@ struct ib_port_attr {
>  	u8			active_speed;
>  	u8                      phys_state;
>  	u16			port_cap_flags2;
> +	u8 			inactive;
>  };

Why is a major structure being changed for this? 

If LAG is to be brought up to the core code then the core should know
what leg is active or not, not the driver.

>  enum ib_device_modify_flags {
> @@ -2145,6 +2146,7 @@ struct ib_port_cache {
>  	struct ib_gid_table   *gid;
>  	u8                     lmc;
>  	enum ib_port_state     port_state;
> +	u8                     inactive;
>  };

Please think carefully about structure patcking here, both placements
of u8 seem poor

Jason
