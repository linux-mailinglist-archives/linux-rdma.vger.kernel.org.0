Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E38415BF5D
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2020 14:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgBMNa5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Feb 2020 08:30:57 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:37401 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbgBMNa4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Feb 2020 08:30:56 -0500
Received: by mail-qv1-f65.google.com with SMTP id m5so2593488qvv.4
        for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2020 05:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2WVrEZUA1Kt88d+fDaM0+KeRD+kNij8IDCo5M4dkszE=;
        b=Xh4/C5eJXtsl/QayodqJtSH5p++HaaNLQY/g0Pnft7cJixY/y2z127L9b9VixXyJeX
         8mkK47hjj2trmTjqPxtPxOo9drNcZqjOaYAGIFeR/YlVU5ntNAkTwUvskFPn3myK81nc
         R62GkjqEHUO/6mmafjTr/GcB99NYNNuG23vLNMebQxSZ9a5E89Glx7MfszHcq1TNjMQT
         pqoDWdZX88xUndTn5zI2OjD8f5xFVovFXTwASMQua6kSvUFhpSwQnRYcDIifIhjOxkzp
         CQjcz63EuJym8fTtq/5Sj5CmdIw3AivE3KEgZvfHRyiOoJNQAAT2vTqAePRCA0D+vcit
         GEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2WVrEZUA1Kt88d+fDaM0+KeRD+kNij8IDCo5M4dkszE=;
        b=QdU0PYjj5817Qh/f9rgsnTqsiKO5YbZHVYjjlTvEGJMEtt+/RmwxW4Ef7sj3DxiSvz
         HtQJ6zybkslbGwbDSdBFF088dfBqkWfeGvyuJHiyFHtAMh3Y7EgLzykuE0VAXJTAblZy
         zvByjMuCrDoqAaad4y7T+FlAk+Z0Mva184iZKcbPJQVEa58YiTBVClZ3dP+ywFRJd0xs
         LeIRIFcPRYGbvLYdaOJ5tzdJGzxIJVsDk8T+7K2rFRjtSZN+/rGU/ai184UrZw6TEzr5
         zLA5gJZUlHdhCRG03yVcOeCA0y7eagbm55e4mkmg3hTFz6VVnUdfBtZneyWteTzVNyAV
         chKQ==
X-Gm-Message-State: APjAAAUg87N8ppXWFwgGw1j7KyAxtCwPKlx90IO8V5NOuEMvcE2K2yMy
        ft+1oBJz94CvoIhgDvn1ywyX1Q==
X-Google-Smtp-Source: APXvYqwyOvi/hB/0QgfeHeqqgsXJozQ5UISE4KKAqK5zQfrzWgHh4MUd7dIzziedBfS7Ffc2WOHK3w==
X-Received: by 2002:a0c:ed2f:: with SMTP id u15mr11676411qvq.1.1581600655920;
        Thu, 13 Feb 2020 05:30:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id l10sm1298096qke.93.2020.02.13.05.30.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 05:30:55 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j2EZy-00039y-Ny; Thu, 13 Feb 2020 09:30:54 -0400
Date:   Thu, 13 Feb 2020 09:30:54 -0400
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
Message-ID: <20200213133054.GA10333@ziepe.ca>
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

I don't quite understands this - what is "when port range is small" ?
 
> rdma_resolve_addr()
>   cma_bind_addr()
>     rdma_bind_addr()
>       cma_get_port()
>         cma_alloc_any_port()
>           cma_port_is_unique() <- compared with zero daddr

Do you understand why cma_port_is_unique is even testing the dst_addr?
It seems very strange.

Outbound connections should not alias the source port in the first
place??

Jason
