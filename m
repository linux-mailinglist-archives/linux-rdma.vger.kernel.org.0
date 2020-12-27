Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A232E305B
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Dec 2020 08:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgL0HOb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Dec 2020 02:14:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:60730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgL0HOb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Dec 2020 02:14:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EFDE207F7;
        Sun, 27 Dec 2020 07:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609053230;
        bh=wYfU/khwimF4RK5SPumvGDlK/392P/6YdLUMLsIFrl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CzPS3bm6Kh3vsKNSIDx1JuSwDVj63fscgWXK/egR8GJI62/H6frpMlt1CQKPj7yiX
         B9q2TY4XlVdG4YO3mmOywqyQhfBjNvOlu0fBLIsSfUkgx9ucaUCNBLeHt6A84j+F3E
         SfsT6ujTZa6q2PASHsfaYvs7PnVV7OKJgtX0jbJvFTonTL3EgpItuWNx4WRv2y0v7w
         y/1qiL2npnIOCwgPIVZRdHp2NRAnE6VCtK8IeDg5u1+xxToEKkoWwH88pRr8DYx1vb
         KT+K8z+V1X5zshgZdoe3ZqbOJwaqlgfmUOhkSl7ihCr4LuL4Hmwk7933wczmp+tcAO
         snV1GgNNHRxkA==
Date:   Sun, 27 Dec 2020 09:13:46 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        Divya Indi <divya.indi@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/sa: Fix memleak in ib_nl_make_request
Message-ID: <20201227071346.GB4457@unreal>
References: <20201220081317.18728-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201220081317.18728-1-dinghao.liu@zju.edu.cn>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Dec 20, 2020 at 04:13:14PM +0800, Dinghao Liu wrote:
> When rdma_nl_multicast() fails, skb should be freed
> just like when ibnl_put_msg() fails.

It is not so simple as you wrote in the description.

There are no other places in the linux kernel that free
SKBs after netlink_multicast() failure.

Thanks

>
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/infiniband/core/sa_query.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
> index 89a831fa1885..8bd23b5cc913 100644
> --- a/drivers/infiniband/core/sa_query.c
> +++ b/drivers/infiniband/core/sa_query.c
> @@ -873,8 +873,10 @@ static int ib_nl_make_request(struct ib_sa_query *query, gfp_t gfp_mask)
>  	spin_lock_irqsave(&ib_nl_request_lock, flags);
>  	ret = rdma_nl_multicast(&init_net, skb, RDMA_NL_GROUP_LS, gfp_flag);
>
> -	if (ret)
> +	if (ret) {
> +		nlmsg_free(skb);
>  		goto out;
> +	}
>
>  	/* Put the request on the list.*/
>  	delay = msecs_to_jiffies(sa_local_svc_timeout_ms);
> --
> 2.17.1
>
