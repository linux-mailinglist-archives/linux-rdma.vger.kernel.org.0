Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267251C732E
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 16:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgEFOnr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 10:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbgEFOnq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 May 2020 10:43:46 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B043AC061A0F
        for <linux-rdma@vger.kernel.org>; Wed,  6 May 2020 07:43:46 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o16so1133609qtb.13
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2020 07:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vC8V5IgrLvuYI9dNH24yVEg2AjcJWyHR5x3n1AaZfls=;
        b=XitEmQrMQXVpdZ4zts5ZKt4ddZFyzhWGx2NgbR6NmYj+7uUVkVSQ9chV2Ha4GYbnkt
         u5Kt1KW6xXqIbMXNAdj9p8P6Y+VxbztWpojOFaSnFpm938aP6RpEBaRhjxUm2XtJT/Bb
         5CRa93rsO9PX7UclSrBO2lPJEg85N2WeBBxJCrrjPb8C5t+tlR1On5CSw3hrN3ElVQnv
         huXu6xCYp608JR2HepLZHflp5eBlNTYXohIskqRw9CkJPWOpkpRrt0MDH+DSG9mA0Q/Z
         os13oUak0Aq5NnlERGulJkJE3VxmmbLDz7eN2JLigfLXypZgFnN7ER5e7H+heGE+xp3I
         ix+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vC8V5IgrLvuYI9dNH24yVEg2AjcJWyHR5x3n1AaZfls=;
        b=hee+eizfskk2zFekfiloud2or079R5MIUHpmqd3rvN/7m+VOOHXBs3JOgJ5LCcZ7WA
         3ytRr2nGGS3ptKfxGL6o7O5GT2xx71Oe0omvAgOjjVFKwAxZlGJtGOkH+yAxRGnTz6X9
         q22jTHc+VPa6wDoWYt3TNXLwrYiG0jq6cV/wVwv9ed7Mxc5VJxc0+tT+1Urr2X2IkXQH
         8gafcbbrfuflGq6G0o+krYrHkcacLGSJz/K1Czo7O2+dvyBLcW2Vt3Tx42k88uMqXjXM
         PCyY9q90wCeFYHkIVwVfJr5ICLyzgJz5VJhgYIJ6Ai/zMp4kWBUsYfLObVhC6hN2S0MU
         SL8Q==
X-Gm-Message-State: AGi0PuZfxYla2mbq8wJ6+5HFd0TnBVjcPiRDZTWtaCEBxnZr+A9QtTNM
        KYoHeRhF3prGxa5F42HUkD4xWw==
X-Google-Smtp-Source: APiQypIu/sKwSAd//5HqvppL5VUxItiZ41aXzqklebk+J5KBSRurku2XgNpjswpQYwNOAqcjhGsPYQ==
X-Received: by 2002:ac8:27ed:: with SMTP id x42mr8467371qtx.231.1588776225853;
        Wed, 06 May 2020 07:43:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n65sm1817154qka.128.2020.05.06.07.43.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 May 2020 07:43:45 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jWLGy-0002KU-Dx; Wed, 06 May 2020 11:43:44 -0300
Date:   Wed, 6 May 2020 11:43:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc v1] IB/core: Fix potential NULL pointer
 dereference in pkey cache
Message-ID: <20200506144344.GA8875@ziepe.ca>
References: <20200506053213.566264-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506053213.566264-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 06, 2020 at 08:32:13AM +0300, Leon Romanovsky wrote:
> From: Jack Morgenstein <jackm@dev.mellanox.co.il>
> 
> The IB core pkey cache is populated by procedure ib_cache_update().
> Initially, the pkey cache pointer is NULL. ib_cache_update allocates
> a buffer and populates it with the device's pkeys, via repeated calls
> to procedure ib_query_pkey().
> 
> If there is a failure in populating the pkey buffer via ib_query_pkey(),
> ib_cache_update does not replace the old pkey buffer cache with the
> updated one -- it leaves the old cache as is.
> 
> Since initially the pkey buffer cache is NULL, when calling
> ib_cache_update the first time, a failure in ib_query_pkey() will cause
> the pkey buffer cache pointer to remain NULL.
> 
> In this situation, any calls subsequent to ib_get_cached_pkey(),
> ib_find_cached_pkey(), or ib_find_cached_pkey_exact() will try to
> dereference the NULL pkey cache pointer, causing a kernel panic.
> 
> Fix this by checking the ib_cache_update() return value.
> 
> Fixes: 8faea9fd4a39 ("RDMA/cache: Move the cache per-port data into the main ib_port_data")
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> Changelog:
> v1: I rewrote the patch to take care of ib_cache_update() return value.
> v0: https://lore.kernel.org/linux-rdma/20200426075811.129814-1-leon@kernel.org
> ---
>  drivers/infiniband/core/cache.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> --
> 2.26.2
> 
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> index 717b798cddad..1cbebfa374a5 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -1553,10 +1553,17 @@ int ib_cache_setup_one(struct ib_device *device)
>  	if (err)
>  		return err;
> 
> -	rdma_for_each_port (device, p)
> -		ib_cache_update(device, p, true);
> +	rdma_for_each_port (device, p) {
> +		err = ib_cache_update(device, p, true);
> +		if (err)
> +			goto out;
> +	}
> 
>  	return 0;
> +
> +out:
> +	ib_cache_release_one(device);
> +	return err;

ib_cache_release_once can be called only once, and it is always called
by ib_device_release(), it should not be called here

Jason
