Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58EDB26911
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2019 19:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfEVR0i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 13:26:38 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41025 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEVR0h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 May 2019 13:26:37 -0400
Received: by mail-qk1-f195.google.com with SMTP id m18so1983887qki.8
        for <linux-rdma@vger.kernel.org>; Wed, 22 May 2019 10:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LDcokZZHZ/+Mn77KN7wGmQSkag0EDoTyhaCWpLt/LhA=;
        b=SeOV3XDAvG8tGc4O8/A/HdR29fB8hYRP3STkOG1L/OBvVfMwlsRuUONfx+0JXYTC60
         bDSoYexV0GLf8DnsHhv/U+r4MYxQNpIqE9GAMqSyfFjRi+NzxdYoQHeoVDbZ/LsUnYMh
         NVN7bZ+i5rp9KTGbOYt2lMBk5WEuA86/uCrwtkG7Vk+HdJKw/CDI/6AfCDokrmY3YIdc
         OqaRb/k95QM1HnCXQQwEvDd9ZZhDkekA7HiNq52pfeJwDeAl1qAWw9+TOXsvK5LUT/SJ
         W+AhAFT40Uv0lwCkuTvYNRddbxS07eqsWfJwLVmTITJQ/bk4wPLxtTgqONJzVJQMiQ89
         F63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LDcokZZHZ/+Mn77KN7wGmQSkag0EDoTyhaCWpLt/LhA=;
        b=YGSfc8dM1UfN5OiDB9I0xYacFGDE6vz9k1YlY1oFh0d72ppwZz6fou/3zfdjQEa/8P
         cv3t+QyJPjs8RNKQtzydfokwnVw4dNa4931fFVty1n/1UkkRq68dOaA5PVPuxTqO6qwp
         bR70AzWOj9qz6mkGw6LOilWYldHk7TVcTNqx62plh7TjT9/iUG0kzbxTahxUvNIlo6tO
         Scb0+6znzXy2TnLfJ/XymyTpxmwDnBUTcKD1RGgkdTqtWzVh+nT054iwBOadq7F9tC+x
         M20K2tLaflO3sQ1XSE/84rroBtOY+O9vUcTXWamWcL1SLC6N6g4hhQDPJY1nUn9qELq+
         8RiQ==
X-Gm-Message-State: APjAAAUpZkmCyd3beIi09VT/FCxGRA2hW8p4wM4eIgIydilTrl7hOqfH
        RlruZjlcEWzujn46VUZXdovikA==
X-Google-Smtp-Source: APXvYqzxIXbuQpW9VtAoinhd9xGxM8XVqWPwSItoh1BKoir1aj1A9KmXCxGYABPeX0NAXZZ2sUkZlg==
X-Received: by 2002:a05:620a:16c8:: with SMTP id a8mr57055298qkn.4.1558545997061;
        Wed, 22 May 2019 10:26:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id a58sm11853539qtc.13.2019.05.22.10.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 10:26:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTV0e-00044c-9e; Wed, 22 May 2019 14:26:36 -0300
Date:   Wed, 22 May 2019 14:26:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        linux-netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 13/17] RDMA/core: Get sum value of all
 counters when perform a sysfs stat read
Message-ID: <20190522172636.GF15023@ziepe.ca>
References: <20190429083453.16654-1-leon@kernel.org>
 <20190429083453.16654-14-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429083453.16654-14-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 29, 2019 at 11:34:49AM +0300, Leon Romanovsky wrote:
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index c56ffc61ab1e..8ae4906a60e7 100644
> +++ b/drivers/infiniband/core/device.c
> @@ -1255,7 +1255,11 @@ int ib_register_device(struct ib_device *device, const char *name)
>  		goto dev_cleanup;
>  	}
>  
> -	rdma_counter_init(device);
> +	ret = rdma_counter_init(device);
> +	if (ret) {
> +		dev_warn(&device->dev, "Couldn't initialize counter\n");
> +		goto sysfs_cleanup;
> +	}

Don't put this things randomly, if there is some reason it should be
after sysfs it needs a comment, otherwise if it is just allocating
memory it belongs earlier, and the unwind should be done in release.

I also think it is very strange/wrong that both sysfs and counters are
allocating the same alloc_hw_stats object

Why can't they share?

Jason
