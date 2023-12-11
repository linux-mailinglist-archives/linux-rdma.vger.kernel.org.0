Return-Path: <linux-rdma+bounces-353-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 926DB80CAD6
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 14:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32115B20F0B
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 13:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15E63E460;
	Mon, 11 Dec 2023 13:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8V92woZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61343D989
	for <linux-rdma@vger.kernel.org>; Mon, 11 Dec 2023 13:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DC5C433C8;
	Mon, 11 Dec 2023 13:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702300942;
	bh=kMg/GXuAw0NwjiwcG9lf2WoRc4TxLCeq2bQHpKvPkLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o8V92woZX3BPHpaqYPqwZL7XLYYtjzRIj3wFUbj9x0jxILnQvZpYgWvKOYjbcpMI4
	 Tniti74WD7uNwuGe1iALxBuof8tOulSwKPQkYGzaKHkA/0S6TffsrQiTlPxnG8h/BX
	 /25UQi/TwADNf58AaJBQHI2bbOtG6TbwWJnpBmrsLL9jiufF0qyiTfUffqII5FlPdh
	 VL8Ixj3f7d6gU0FYNeinZNPXWETtzbGoKgvwnSVcnFGGjBFgpZfJ3NmSScwf1N1KOx
	 adT+dKv/MFQ1BAfwPI+EiOBtJ+V40Va0htKkSDzWVroZbclUoYuCTLCBwu4Br7sccQ
	 55EskjMXlUcAQ==
Date: Mon, 11 Dec 2023 15:22:17 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Daniel Vacek <neelx@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/ipoib: No need to hold the lock while printing the
 warning
Message-ID: <20231211132217.GF4870@unreal>
References: <20231211131051.1500834-1-neelx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211131051.1500834-1-neelx@redhat.com>

On Mon, Dec 11, 2023 at 02:10:50PM +0100, Daniel Vacek wrote:
> Signed-off-by: Daniel Vacek <neelx@redhat.com>

Please fill some text in commit message.

Thanks

> ---
>  drivers/infiniband/ulp/ipoib/ipoib_multicast.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> index 5b3154503bf4..ae2c05806dcc 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> @@ -536,17 +536,17 @@ static int ipoib_mcast_join(struct net_device *dev, struct ipoib_mcast *mcast)
>  	multicast = ib_sa_join_multicast(&ipoib_sa_client, priv->ca, priv->port,
>  					 &rec, comp_mask, GFP_KERNEL,
>  					 ipoib_mcast_join_complete, mcast);
> -	spin_lock_irq(&priv->lock);
>  	if (IS_ERR(multicast)) {
>  		ret = PTR_ERR(multicast);
>  		ipoib_warn(priv, "ib_sa_join_multicast failed, status %d\n", ret);
> +		spin_lock_irq(&priv->lock);
>  		/* Requeue this join task with a backoff delay */
>  		__ipoib_mcast_schedule_join_thread(priv, mcast, 1);
>  		clear_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
>  		spin_unlock_irq(&priv->lock);
>  		complete(&mcast->done);
> -		spin_lock_irq(&priv->lock);
>  	}
> +	spin_lock_irq(&priv->lock);
>  	return 0;
>  }
>  
> -- 
> 2.43.0
> 

