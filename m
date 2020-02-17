Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 938D6160786
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2020 01:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgBQAgN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Feb 2020 19:36:13 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45219 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgBQAgN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 16 Feb 2020 19:36:13 -0500
Received: by mail-qk1-f193.google.com with SMTP id a2so14634309qko.12
        for <linux-rdma@vger.kernel.org>; Sun, 16 Feb 2020 16:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PAiDoNcDSsPnNj5W4mWsQjtsAOyOXebI5Rn/LeRO4A0=;
        b=jtpOapbHFVjp/wJYElpr+0+UN+bnlIm8e5HSRL2u+Y9QkgTx8DY8UMOMNuycHEMJca
         Y4FkUIHdZPwmPx1cJYizjiP458SAypboQ6RKWnROZb8xEEagkFUFAmmJ4gDJzZ5qmwf1
         dM039k0juLOOeE1Bg699rDYhNyGIoPHBHYIGZgiQ9RVTXp6TFbiirga3jYjVWEN0FuUf
         HzrS/XUtO3uRp67ScZMRUVlbcNDCoUIag9WreZ+KXOIaQ7gO/vb1dMcLVf8EOc6mq67D
         DnnGURL6m+33HicB+cg1TApImTExGruhDQE3mqo3kwVwc0Q/pgFUZW1adIWKhpNeRX4U
         fWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PAiDoNcDSsPnNj5W4mWsQjtsAOyOXebI5Rn/LeRO4A0=;
        b=JnXiuuRk9GO1vJ6oM3O6jqaWhtJEr2vjAikck+Rgng9mzhhmGcJuVJnkatThEsUf5C
         GK/+z0u0NC4Pb920MiJLxsXxKwxayIGKhKZkUEIb61zRBM5ISRyY1Du+XEEz0U6dcRoW
         jD/GkIkkO5+TDBWRz3w7b3WapNvrcL8M3OEO9krWYBv9qbvpbicc+qAF4IdFUGWKZ3a2
         srwAivnZgvF63ylUydl4G3ksX+UYcUWwGmRMv3d9KNCTMwpe9miTbebq/N8AuLGqLiuk
         4fHuK4bsiwfGxaopaRioxiSIS+eEcQmoMzUcl6w5AA+pqfZfmLPQ9Ew5bJvAZPUc69vU
         QhRw==
X-Gm-Message-State: APjAAAVsYQRYHNcfXWG4qYo7hEqiIP2BuWucvbJTw61roTZaYeef4mH/
        +fv+jwMZ01aKve/ZaHzLlr0j2g==
X-Google-Smtp-Source: APXvYqxeQ1g+jpqlNityj8TgopMrjNmz4CclX96hSYDzY9HRLgVtbwu71aVJTN32smWAWDoy73fOQw==
X-Received: by 2002:a37:6690:: with SMTP id a138mr9654539qkc.475.1581899772343;
        Sun, 16 Feb 2020 16:36:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h13sm7852610qtu.23.2020.02.16.16.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Feb 2020 16:36:11 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j3UOQ-0003Nj-Fg; Sun, 16 Feb 2020 20:36:10 -0400
Date:   Sun, 16 Feb 2020 20:36:10 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Maxim Mikityanskiy <maximmi@mellanox.com>
Cc:     Alexander Lobakin <alobakin@dlink.ru>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma] IB/mlx5: Fix linkage failure on 32-bit arches
Message-ID: <20200217003610.GC31668@ziepe.ca>
References: <20200214191309.155654-1-alobakin@dlink.ru>
 <20200214192410.GW31668@ziepe.ca>
 <6f7c270fef9ec5bae2dcb780dee3f49f@dlink.ru>
 <3c70c7da-60aa-10ec-767f-5e519357b8e6@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c70c7da-60aa-10ec-767f-5e519357b8e6@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Feb 16, 2020 at 01:53:50PM +0200, Maxim Mikityanskiy wrote:
> On 2020-02-14 21:44, Alexander Lobakin wrote:
> > Jason Gunthorpe wrote 14.02.2020 22:24:
> > > On Fri, Feb 14, 2020 at 10:13:09PM +0300, Alexander Lobakin wrote:
> > > > Commit f164be8c0366 ("IB/mlx5: Extend caps stage to handle VAR
> > > > capabilities") introduced a straight "/" division of the u64
> > > > variable "bar_size", which emits an __udivdi3() libgcc call on
> > > > 32-bit arches and certain GCC versions:
> > > > 
> > > > error: "__udivdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko]
> > > > undefined! [1]
> > > > 
> > > > Replace it with the corresponding div_u64() call.
> > > > Compile-tested on ARCH=mips 32r2el_defconfig BOARDS=ocelot.
> > > > 
> > > > [1] https://lore.kernel.org/linux-mips/CAMuHMdXM9S1VkFMZ8eDAyZR6EE4WkJY215Lcn2qdOaPeadF+EQ@mail.gmail.com/
> > > > 
> > > > 
> > > > Fixes: f164be8c0366 ("IB/mlx5: Extend caps stage to handle VAR
> > > > capabilities")
> > > > Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
> > > >  drivers/infiniband/hw/mlx5/main.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > Randy beat you too it..
> > > 
> > > https://lore.kernel.org/linux-rdma/20200206143201.GF25297@ziepe.ca/
> > 
> > Ah, OK. Sorry for missing this one. I didn't see any fix over
> > git.kernel.org and thought it doesn't exist yet.
> > 
> > > But it seems patchwork missed this somehow.
> > > 
> > > Applied now at least
> 
> Jason, I think Alexander's patch is more correct. It uses div_u64, while
> yours uses div64_u64. The divider is 32-bit, so div_u64 would be more
> optimized on most 32-bit architectures.

Seems so, but it is already done. You can send a followup to fix it

Jason
