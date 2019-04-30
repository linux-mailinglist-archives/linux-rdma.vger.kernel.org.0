Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32785F54D
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 13:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfD3LSS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 07:18:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbfD3LSS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Apr 2019 07:18:18 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBC3720835;
        Tue, 30 Apr 2019 11:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556623097;
        bh=VQusQrvCrV2pXa9YNpfE4FU9RMU4H7Yhd17HcZpUkgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ItyCaxfMqGh/ymApMIRit3NUpd4BvZ1R4UZnt6B600/JZM6GptYQBfMVnq6vmh708
         Oz/ncEGIxajTY1k/0RSBRgsycdUMm8I0wX2xGVwMtOFCp7VWVeTZcQng8rLD3rlWvT
         9HrcelrYEVADfExe/xxcx0K5xWZMxLxdSOWv5dHU=
Date:   Tue, 30 Apr 2019 14:18:14 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     linux-rdma@vger.kernel.org,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-next] RDMA/uverbs: Initialize udata struct on destroy
 flows
Message-ID: <20190430111814.GE6705@mtr-leonro.mtl.com>
References: <1556613999-14823-1-git-send-email-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556613999-14823-1-git-send-email-galpress@amazon.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 30, 2019 at 11:46:39AM +0300, Gal Pressman wrote:
> Cited commit introduced the udata parameter to different destroy flows
> but the uapi method definition does not have udata (i.e has_udata flag
> is not set). As a result, an uninitialized udata struct is being passed
> down to the driver callbacks.
>
> Fix that by clearing the driver udata even in cases where has_udata flag
> is not set.
>
> Fixes: c4367a26357b ("IB: Pass uverbs_attr_bundle down ib_x destroy path")
> Cc: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> Co-developed-by: Jason Gunthorpe <jgg@ziepe.ca>

What is wrong with Signed-off-by that caused you to add new tag?

Thanks

> Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/core/uverbs_ioctl.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
> index cfbef25b3a73..829b0c6944d8 100644
> --- a/drivers/infiniband/core/uverbs_ioctl.c
> +++ b/drivers/infiniband/core/uverbs_ioctl.c
> @@ -453,6 +453,8 @@ static int ib_uverbs_run_method(struct bundle_priv *pbundle,
>  		uverbs_fill_udata(&pbundle->bundle,
>  				  &pbundle->bundle.driver_udata,
>  				  UVERBS_ATTR_UHW_IN, UVERBS_ATTR_UHW_OUT);
> +	else
> +		pbundle->bundle.driver_udata = (struct ib_udata){};
>
>  	if (destroy_bkey != UVERBS_API_ATTR_BKEY_LEN) {
>  		struct uverbs_obj_attr *destroy_attr =
> --
> 2.7.4
>
