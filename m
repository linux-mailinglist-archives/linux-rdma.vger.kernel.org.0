Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690A61E1073
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 16:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390886AbgEYO0n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 10:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390879AbgEYO0n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 10:26:43 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752E6C061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 07:26:43 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i68so13875996qtb.5
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 07:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dEZdjqWpTAGAQ9pHR4cTtpllQZRcglIbxAMSHm05Ij0=;
        b=jU3sxwHNOj33wnTyHMOgLszGF0uowiKlS4m7KBHJW+0g/rdls6O0HuOrPHGHJcbZtC
         o3xm0qDqp97wUV9oWghxzrVhzT0qHsNcleLpQ35PBqMjqUEgYHlFvEnUf4JHFGDOjtUL
         8xWj8yC9dvKJ32ZuxC7A6Q3kVeBjZbFJkzA5pcPEYsBJdLLWxVLkS0IASqmq7GjrE8PY
         +0kUY9ndzw5TUJ5+hdxFhcYxKMqdGapEZSkCkX90kFjc5wkJWczr16oS8xwJFugRl/R5
         tevjT6wFnZ3p/u1rklpIwAmRHE0tTQFO+9DxOPiTJOa7oVE6WaulBLU7fqS+FOWQeKdV
         +7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dEZdjqWpTAGAQ9pHR4cTtpllQZRcglIbxAMSHm05Ij0=;
        b=s03d6DZAHrqzDmuqxhfQqPyLiauhPo8ljBl3jjuzBKxsnWLOtiyxN3iNX6fA0LRaIS
         49N56V5q6g6owCH7ZSIXu2mRVXCbz/05daNS0neI/+rnfiAR1vo5dGOl7HUsHeUtyvVh
         81aR4BXbP1JQchiegbbvpEiLwW1ZjJ/x3WVV+2v4FSgEQq/uLr+8UBWnbWr60m+B0GNR
         7U8/1apjnp81E9RZMeMoY7q6wvyL46RxeXVUvJnpXgoM2a3HzulxoUJO1ZYHD3xxgyDj
         prNB4kDq2kSBRn4oNL9V7s9asXyl/E6vMwAS4jhzoCKOKqVyiVif4y/qJNdB4YIEVGzt
         qlKQ==
X-Gm-Message-State: AOAM530A5W2bwWetV/Aj+nu0woWvapeLV+ldka9aTjCDf0ADajdorH4y
        eAAYkcMuaNcy342y3Bj51ROYCQ==
X-Google-Smtp-Source: ABdhPJxrxqWt0zrfIkJW9ccXLX+G2OZ9Kj7bOl5tyjECwNgjijJtd6xwkc+FpH9dONWgQI90NT+cSQ==
X-Received: by 2002:ac8:5253:: with SMTP id y19mr5973353qtn.291.1590416802730;
        Mon, 25 May 2020 07:26:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id a12sm13910659qko.103.2020.05.25.07.26.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 07:26:42 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdE3t-0005UT-TM; Mon, 25 May 2020 11:26:41 -0300
Date:   Mon, 25 May 2020 11:26:41 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kamalheib1@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 04/14] RDMA/core: Allow to override device op
Message-ID: <20200525142641.GA20978@ziepe.ca>
References: <20200513095034.208385-1-leon@kernel.org>
 <20200513095034.208385-5-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513095034.208385-5-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 13, 2020 at 12:50:24PM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
> 
> Current device ops implementation allows only two stages "set"/"not set"
> and requires caller to check if function pointer exists before
> calling it.
> 
> In order to simplify this repetitive task, let's give an option to
> overwrite those pointers. This will allow us to set dummy functions
> for the specific function pointers.
> 
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/device.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index d9f565a779df..9486e60b42cc 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2542,11 +2542,10 @@ EXPORT_SYMBOL(ib_get_net_dev_by_params);
>  void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
>  {
>  	struct ib_device_ops *dev_ops = &dev->ops;
> -#define SET_DEVICE_OP(ptr, name)                                               \
> -	do {                                                                   \
> -		if (ops->name)                                                 \
> -			if (!((ptr)->name))				       \
> -				(ptr)->name = ops->name;                       \
> +#define SET_DEVICE_OP(ptr, name)					\
> +	do {								\
> +		if (ops->name)						\
> +			(ptr)->name = ops->name;			\
>  	} while (0)

Did you carefully check every driver to be sure it is OK with this?

Maybe Kamal remembers why it was like this?

Jason
