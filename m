Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F6A1E10A3
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 16:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgEYOgw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 10:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEYOgw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 10:36:52 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173C2C061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 07:36:52 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z80so17672601qka.0
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 07:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XYD3yGLuBd54Gzm/Kg7JIuilpeeyo3WyLzXMDdX0Ra0=;
        b=brQol39GcLPqoa9EgR0zHzh/R4jCffGoGcbmvpQgw8GJqBOwlN4tNTCzMrr0JsQoLW
         v7/0FfoYH9SMlYVwz3V3myx4f0YwDXNyb4ILqR/aN8kTKrWYnfZjUvy/9hl35a6wheCU
         jD1vSsJlnwDVsihtL7Wurx3a1aRm1m18A6XzQrPQ9F9uEgNRkG+ZdcUuTRNsMgSpIBaK
         47IgjJLRg6T2I9pEBMdzESsqDKKPtw38FnWM2u9hjiqMJbAl6Fs8f+CcYGBDkRpPI98H
         39GrIsK/kMf9TnOhBV4cZURyB+XGBQVq2vgB8jZ3sQWzuh7A4d5ZVrjaA5sFf+2QeFOW
         WJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XYD3yGLuBd54Gzm/Kg7JIuilpeeyo3WyLzXMDdX0Ra0=;
        b=dJTqsKfOrDz0QefJNa2B/i/3TqZUu6ok2vlh5FSPkRyjOf/sYZcTR8FUHwfkLw2zp+
         w/YLFE02ExvkD2sP2sn+Yhrfw6VIPVnF94INq8o5kS4P7GN9ABX5b2A2vCYa9+g1mosr
         CVWNYYL2x1Xr9HVDHbTgYNfFZnDO5i/CuS/w+KxETqoxHiFjgrq2c8klhWXEeB++Xxf7
         F9Jz77xLCIjgV7Dnww4e993TP7Ez+5eZBM0lP+x05Aw+FKrH8giLDyfGJ7TbkjLEJU73
         P6pNH6+7e+bRY/qsi1qj6iEuzPbRAejAdxhF4OZF0Nt1f7EBEj6aEHvEbjG8uxYeyDvB
         Qi8g==
X-Gm-Message-State: AOAM532tS3PA+iHuQ+kfP+LBOyWPMJlsTOxJ1am6aLPQohEW9VGhAz7d
        wS26/7+CqTDhS3RUaJuS/2tabg==
X-Google-Smtp-Source: ABdhPJzH86ckyYo3zdxFiD8G5mymcU75QQ7oHM8VxS4Y9TjKYTuFRoWfAiJI9A7mJThiJNrqZRXdwA==
X-Received: by 2002:a37:2fc1:: with SMTP id v184mr25886411qkh.444.1590417411262;
        Mon, 25 May 2020 07:36:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id s201sm9603184qka.8.2020.05.25.07.36.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 07:36:50 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdEDi-0005fm-7y; Mon, 25 May 2020 11:36:50 -0300
Date:   Mon, 25 May 2020 11:36:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 06/14] RDMA/core: Add restrack dummy ops
Message-ID: <20200525143650.GA21729@ziepe.ca>
References: <20200513095034.208385-1-leon@kernel.org>
 <20200513095034.208385-7-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513095034.208385-7-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 13, 2020 at 12:50:26PM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
> 
> When fill_res_entry is not implemented by the vendor, then we just
> need to return 0. Reduce some code and make it more clear by
> set dummy ops.
> 
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/nldev.c    | 46 ++++--------------------------
>  drivers/infiniband/core/restrack.c | 13 +++++++++
>  2 files changed, 19 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index 8548f09746ab..8b4115bc26b2 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -446,22 +446,6 @@ static int fill_res_name_pid(struct sk_buff *msg,
>  	return err ? -EMSGSIZE : 0;
>  }
>  
> -static bool fill_res_entry(struct ib_device *dev, struct sk_buff *msg,
> -			   struct rdma_restrack_entry *res)
> -{
> -	if (!dev->ops.fill_res_entry)
> -		return false;
> -	return dev->ops.fill_res_entry(msg, res);
> -}
> -
> -static bool fill_stat_entry(struct ib_device *dev, struct sk_buff *msg,
> -			    struct rdma_restrack_entry *res)
> -{
> -	if (!dev->ops.fill_stat_entry)
> -		return false;
> -	return dev->ops.fill_stat_entry(msg, res);
> -}
> -
>  static int fill_res_qp_entry(struct sk_buff *msg, bool has_cap_net_admin,
>  			     struct rdma_restrack_entry *res, uint32_t port)
>  {
> @@ -515,10 +499,7 @@ static int fill_res_qp_entry(struct sk_buff *msg, bool has_cap_net_admin,
>  	if (fill_res_name_pid(msg, res))
>  		goto err;
>  
> -	if (fill_res_entry(dev, msg, res))
> -		goto err;
> -
> -	return 0;
> +	return dev->ops.fill_res_entry(msg, res);
>  
>  err:	return -EMSGSIZE;
>  }
> @@ -568,10 +549,7 @@ static int fill_res_cm_id_entry(struct sk_buff *msg, bool has_cap_net_admin,
>  	if (fill_res_name_pid(msg, res))
>  		goto err;
>  
> -	if (fill_res_entry(dev, msg, res))
> -		goto err;
> -
> -	return 0;
> +	return dev->ops.fill_res_entry(msg, res);
>  
>  err: return -EMSGSIZE;
>  }
> @@ -606,10 +584,7 @@ static int fill_res_cq_entry(struct sk_buff *msg, bool has_cap_net_admin,
>  	if (fill_res_name_pid(msg, res))
>  		goto err;
>  
> -	if (fill_res_entry(dev, msg, res))
> -		goto err;
> -
> -	return 0;
> +	return dev->ops.fill_res_entry(msg, res);
>  
>  err:	return -EMSGSIZE;
>  }
> @@ -641,10 +616,7 @@ static int fill_res_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
>  	if (fill_res_name_pid(msg, res))
>  		goto err;
>  
> -	if (fill_res_entry(dev, msg, res))
> -		goto err;
> -
> -	return 0;
> +	return dev->ops.fill_res_entry(msg, res);
>  
>  err:	return -EMSGSIZE;
>  }
> @@ -784,15 +756,9 @@ static int fill_stat_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
>  	struct ib_device *dev = mr->pd->device;
>  
>  	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_MRN, res->id))
> -		goto err;
> -
> -	if (fill_stat_entry(dev, msg, res))
> -		goto err;
> -
> -	return 0;
> +		return -EMSGSIZE;
>  
> -err:
> -	return -EMSGSIZE;
> +	return dev->ops.fill_stat_entry(msg, res);
>  }
>  
>  static int fill_stat_counter_hwcounters(struct sk_buff *msg,
> diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> index 62fbb0ae9cb4..093b27c0bbe6 100644
> --- a/drivers/infiniband/core/restrack.c
> +++ b/drivers/infiniband/core/restrack.c
> @@ -14,6 +14,17 @@
>  #include "cma_priv.h"
>  #include "restrack.h"
>  
> +static int fill_res_dummy(struct sk_buff *msg,
> +			  struct rdma_restrack_entry *entry)
> +{
> +	return 0;
> +}
> +
> +static const struct ib_device_ops restrack_dummy_ops = {
> +	.fill_res_entry = fill_res_dummy,
> +	.fill_stat_entry = fill_res_dummy,
> +};

If you are going to do this then you should do it for substantially
everything, as we did in rdma-core. I don't want to see easy stuff
like this half done..

And this should be a broken out series or two as it really has nothing
to do with 'raw format dumps'

Jason
