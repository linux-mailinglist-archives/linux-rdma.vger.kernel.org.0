Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2D31FBEDE
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 21:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbgFPTVU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 15:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbgFPTU4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jun 2020 15:20:56 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAB4C061573
        for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2020 12:20:55 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q2so1155163qkb.2
        for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2020 12:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sy4Vk3XIq+g3R+EaE80k0CE3FKg1J6tytjvtAtDVzoc=;
        b=FeY0n1Hsl13QQlJqeeuEKvewYecj8I5zja2busongYGdPXwJ16G+02wos3Icqn6dK0
         GbVsDl4899r3NfKrXKC7rf5wfdYjXoirR2PxJWkv4ytuTS6EZDJmhv6vrsa07yJmh4Zv
         PKwLNxsD3LFuziL8LQZ87NF2qmltx9ivGSbvlOlqPlq252eMqu/Xy/75KjcboI9Z8UoA
         4G8MGnoMwas6DS/Xz2rpapPpka0GpxlroMvmlsaZvbdn2548RHidKbZDNQ8Jf82ceCNI
         t1NjyqcVCmv3bLrD/spJqBhdLX+SBgk6ATOZziEw42wqx7Lk4fQkSovaj+1rvjXOKEmv
         Ed1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sy4Vk3XIq+g3R+EaE80k0CE3FKg1J6tytjvtAtDVzoc=;
        b=kBVYdmkaXp6tOaLXP7+AuuXk5w9rlNX/NLHyRqXb4TTCoawLNfcGHifsqqFtfXLWse
         tMy9xUmJ2gAxicXlILWaK4qYcEoNsQ5LXxK1UeqIwA4MXr5YXtrV7A3cXgDQFNH0Rc2W
         hWT49w3qTzlpNvBQNbcuQb4xOe3AJLsifCBsVJQDX3fZ9V135xzFnNOHhZia+mJP5MyD
         FrL7eCkuJ6sue7HD4ylbQoiuJ0SYjds9zycOFpTZp5ACSh8lK0EZSfQa91rivJ6vI8XS
         k257jz4zKOGtlHmJv9CiAQUlQeqUiFvMEvksKZBWcLZF7Nptd0/ckB01qnnkjLytB+L8
         C4nA==
X-Gm-Message-State: AOAM530LnW+77AdpYbEmOkuSqx4esK4uQkkVAHciAhtaBsv3wgX1atPj
        Q83qsol8wNfulnSWmEYF2qYkIg==
X-Google-Smtp-Source: ABdhPJyOu4ElVhV4T+kIAm8Da9sSC7z+IFVy3wnYQPdsWfxscc3QZL1mhVieEr5QyhhtfqIhm0w65Q==
X-Received: by 2002:a37:9b0d:: with SMTP id d13mr22446855qke.351.1592335255177;
        Tue, 16 Jun 2020 12:20:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 126sm15165657qkj.89.2020.06.16.12.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 12:20:54 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jlH8g-009Ehz-5h; Tue, 16 Jun 2020 16:20:54 -0300
Date:   Tue, 16 Jun 2020 16:20:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/core: Check that type_attrs is not NULL
 prior access
Message-ID: <20200616192054.GE6578@ziepe.ca>
References: <20200616105813.2428412-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616105813.2428412-1-leon@kernel.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 16, 2020 at 01:58:13PM +0300, Leon Romanovsky wrote:
> diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
> index 38de4942c682..16b86635d752 100644
> +++ b/drivers/infiniband/core/rdma_core.c
> @@ -470,40 +470,41 @@ static struct ib_uobject *
>  alloc_begin_fd_uobject(const struct uverbs_api_object *obj,
>  		       struct uverbs_attr_bundle *attrs)
>  {
> -	const struct uverbs_obj_fd_type *fd_type =
> -		container_of(obj->type_attrs, struct uverbs_obj_fd_type, type);
> +	const struct uverbs_obj_fd_type *fd_type;
>  	int new_fd;
>  	struct ib_uobject *uobj;
>  	struct file *filp;
> 
> +	uobj = alloc_uobj(attrs, obj);
> +	if (IS_ERR(uobj))
> +		return uobj;
> +
> +	fd_type =
> +		container_of(obj->type_attrs, struct uverbs_obj_fd_type, type);
>  	if (WARN_ON(fd_type->fops->release != &uverbs_uobject_fd_release &&
> -		    fd_type->fops->release != &uverbs_async_event_release))
> +		    fd_type->fops->release != &uverbs_async_event_release)) {
> +		uverbs_uobject_put(uobj);
>  		return ERR_PTR(-EINVAL);
> +	}

I feel like this is a bit cleaner with a goto unwind ?

Jason
