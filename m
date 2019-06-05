Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E91C355FC
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 06:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfFEE3n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 00:29:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfFEE3n (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jun 2019 00:29:43 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29F0520717;
        Wed,  5 Jun 2019 04:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559708982;
        bh=w2CzsgB03HnwH8N+KwXOYidngpX3ROt58BgSkWlBqH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rfP+t6Lw6NIOhWUezyYpW9OtfeIfMo16FqjNrslR9zKUz295zUOUjDu+wYOzGiLUw
         LuiIGLxX3/shn+kM5wnt/KVV3WcbmRq7wyPasvGXMSQFfwNsdDU1P4UEFC6Oq+CWF1
         a7GY6dvLO/3+7jN6qKx4z0iHDkITBZkgB4zgQjVc=
Date:   Wed, 5 Jun 2019 07:29:38 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/ucma: Use struct_size() helper
Message-ID: <20190605042938.GL5261@mtr-leonro.mtl.com>
References: <20190604154222.GA8938@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604154222.GA8938@embeddedor>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 04, 2019 at 10:42:22AM -0500, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes, in particular in the
> context in which this code is being used.

What does "in particular in the context in which this code is being
used" mean?

>
> So, replace the following form:
>
> sizeof(*resp) + (i * sizeof(struct ib_path_rec_data))
>
> with:
>
> struct_size(resp, path_data, i)

It is already written inside commit itself.

>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/infiniband/core/ucma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> index 140a338a135f..cbe460076611 100644
> --- a/drivers/infiniband/core/ucma.c
> +++ b/drivers/infiniband/core/ucma.c
> @@ -951,8 +951,7 @@ static ssize_t ucma_query_path(struct ucma_context *ctx,
>  		}
>  	}
>
> -	if (copy_to_user(response, resp,
> -			 sizeof(*resp) + (i * sizeof(struct ib_path_rec_data))))
> +	if (copy_to_user(response, resp, struct_size(resp, path_data, i)))
>  		ret = -EFAULT;
>
>  	kfree(resp);
> --
> 2.21.0
>
