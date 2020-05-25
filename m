Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A911E12A6
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 18:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbgEYQ27 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 12:28:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731458AbgEYQ27 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 May 2020 12:28:59 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78EC620723;
        Mon, 25 May 2020 16:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590424139;
        bh=k4/JdOnIdKs9+s6AaSCOHlAVsSO6iNIrnoVBZXxbpXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aLwIDJr4CQ0mlhfBqiXCEHVgAFstJp5ouXZkEA/T5UlshTuhvwIVl2EdpwyJQOyJo
         4/ufmlZAxnc++Il1QDeSHYQ7JP/4t0hkH9wgbPn4Bye6YDfoin7/YF5KrcXfBpfZIv
         ZtclYtXXdXECnq1wMujCamUS7oRwZWVEROfYDR8k=
Date:   Mon, 25 May 2020 19:28:55 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kamal Heib <kamalheib1@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 04/14] RDMA/core: Allow to override device op
Message-ID: <20200525162855.GE10591@unreal>
References: <20200513095034.208385-1-leon@kernel.org>
 <20200513095034.208385-5-leon@kernel.org>
 <20200525142641.GA20978@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525142641.GA20978@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 25, 2020 at 11:26:41AM -0300, Jason Gunthorpe wrote:
> On Wed, May 13, 2020 at 12:50:24PM +0300, Leon Romanovsky wrote:
> > From: Maor Gottlieb <maorg@mellanox.com>
> >
> > Current device ops implementation allows only two stages "set"/"not set"
> > and requires caller to check if function pointer exists before
> > calling it.
> >
> > In order to simplify this repetitive task, let's give an option to
> > overwrite those pointers. This will allow us to set dummy functions
> > for the specific function pointers.
> >
> > Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >  drivers/infiniband/core/device.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> > index d9f565a779df..9486e60b42cc 100644
> > --- a/drivers/infiniband/core/device.c
> > +++ b/drivers/infiniband/core/device.c
> > @@ -2542,11 +2542,10 @@ EXPORT_SYMBOL(ib_get_net_dev_by_params);
> >  void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
> >  {
> >  	struct ib_device_ops *dev_ops = &dev->ops;
> > -#define SET_DEVICE_OP(ptr, name)                                               \
> > -	do {                                                                   \
> > -		if (ops->name)                                                 \
> > -			if (!((ptr)->name))				       \
> > -				(ptr)->name = ops->name;                       \
> > +#define SET_DEVICE_OP(ptr, name)					\
> > +	do {								\
> > +		if (ops->name)						\
> > +			(ptr)->name = ops->name;			\
> >  	} while (0)
>
> Did you carefully check every driver to be sure it is OK with this?

We will recheck.

Thanks
