Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAE9165029
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 21:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgBSUk2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 15:40:28 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37803 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSUk2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 15:40:28 -0500
Received: by mail-qv1-f68.google.com with SMTP id s6so837271qvq.4
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 12:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hE7nL1Cxq3qvM6GLvVVZouoRpi+j7PqcM2qj479Viik=;
        b=ifDAsexnvzD6yymCi8lmSKRW97N8ReiXwY4t/7ie4TaeXFn5gxHvTANg55kKJk7mM2
         sKTxJLVGdLZlMx8secwp2j3lg3CneIYUEGo2i3XUcjyksj58jmmiz+DJCr9HBgdVTAkj
         hsZBljfwcGCTO9bJXl9vmT50vRIlqzlCjFUw7pkKf+X+KYS3Sm+7+90WAOoOn5Tll/MM
         OwLvjZLmXMsaBNnFDAbIsHva0NYGIs2s1ft2/FoZxD2+aQs1rF3mwOt4g7yo5I5sxPB5
         gN+m5+OwCyINU24WrYN8fCy5Ze7uRIlgi2YNkDdNd4h5iy8rLxIa0qLhfEl6GZTyoBUq
         TXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hE7nL1Cxq3qvM6GLvVVZouoRpi+j7PqcM2qj479Viik=;
        b=F3nVx0nvEXZ0FW/rG2jqifPyLJAnx2ekoBKVFm+QwwcMeG4lbO2TYe2K/NFobHnGVF
         1jlGH3mQ0hTUMBNxYmkdsOtF5TsgcbzwFT5zavWkZLf+yFAk6BxFVlgbpJjZKbJKzwLt
         Xv8USv6V/DsdltDCbHk8nkzktydlYwTR4QK1WJ/BfamDvC+LkOn4KBVrMnXXlCNudUGJ
         ORmvAnY+VB9o3EHGK5huxJg0QGrsYXbz/JYsNhDHq2iT6ii8wYTDTWF45cH6rZBobHXU
         5GEGZtW/pwLFoSkPvdIWPlh6oxP5FYeJ4KLGF5GmpaK/5A0Hy3Q0Lm3vKSfWZ7BpTZ2x
         F2iA==
X-Gm-Message-State: APjAAAWqUn1MhLdV3k4auwRNumokTj8a5iBhP9tU1IZXUduW/w04vzOv
        mBEGL7J7phne5pMMwgU9CDw8fg==
X-Google-Smtp-Source: APXvYqyoq89QNy1r8caBNMsIpH+ohlk87Uq8uaT8m/MzEo0cbHt7fq6kwZjqRXaoWXEVQNIX4qamVQ==
X-Received: by 2002:ad4:5525:: with SMTP id ba5mr21847249qvb.117.1582144827042;
        Wed, 19 Feb 2020 12:40:27 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id y62sm440681qka.19.2020.02.19.12.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 12:40:26 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4W8w-0000OU-2u; Wed, 19 Feb 2020 16:40:26 -0400
Date:   Wed, 19 Feb 2020 16:40:26 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Valentine Fatiev <valentinef@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Yonatan Cohen <yonatanc@mellanox.com>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: Re: [PATCH rdma-rc 3/9] Revert "RDMA/cma: Simplify
 rdma_resolve_addr() error flow"
Message-ID: <20200219204026.GA1478@ziepe.ca>
References: <20200212072635.682689-1-leon@kernel.org>
 <20200212072635.682689-4-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212072635.682689-4-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 12, 2020 at 09:26:29AM +0200, Leon Romanovsky wrote:
> From: Parav Pandit <parav@mellanox.com>
> 
> This reverts commit 219d2e9dfda9431b808c28d5efc74b404b95b638.
> 
> Below flow requires cm_id_priv's destination address to be setup
> before performing rdma_bind_addr().
> Without which, source port allocation for existing bind list fails
> when port range is small, resulting into rdma_resolve_addr()
> failure.
> 
> rdma_resolve_addr()
>   cma_bind_addr()
>     rdma_bind_addr()
>       cma_get_port()
>         cma_alloc_any_port()
>           cma_port_is_unique() <- compared with zero daddr
> 
> Fixes: 219d2e9dfda9 ("RDMA/cma: Simplify rdma_resolve_addr() error flow")
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/cma.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Applied to for-rc

Thanks,
Jason
