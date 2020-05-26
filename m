Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DAB1E1AD6
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 07:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgEZFxq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 May 2020 01:53:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgEZFxq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 May 2020 01:53:46 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09F7F2071A;
        Tue, 26 May 2020 05:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590472425;
        bh=AAdM7uhlBSU5ehs+9+mlt1qY+8zr0MbM3yvoY6VYgn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H7URmxayETQ2F1eyS8MzEuql1AF55+Z3pKjFmlaTAJeqVZvg603ZM9ts8AU+MSRXM
         JIiLxYmc+50wZvQLnXKDAxMFBwF4m3SfYFmIjTfeZ95ZbWq5U7zVPC8WZqyt45hat4
         OO25n1sk2yzkVZ80C1RN6w/EY2w6wRVs9o2pYTKc=
Date:   Tue, 26 May 2020 08:53:42 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 04/14] RDMA/core: Allow to override device op
Message-ID: <20200526055342.GP10591@unreal>
References: <20200513095034.208385-1-leon@kernel.org>
 <20200513095034.208385-5-leon@kernel.org>
 <20200525142641.GA20978@ziepe.ca>
 <20200525232125.GA177080@kheib-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525232125.GA177080@kheib-workstation>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 26, 2020 at 02:21:25AM +0300, Kamal Heib wrote:
> On Mon, May 25, 2020 at 11:26:41AM -0300, Jason Gunthorpe wrote:
> > On Wed, May 13, 2020 at 12:50:24PM +0300, Leon Romanovsky wrote:
> > > From: Maor Gottlieb <maorg@mellanox.com>
> > >
> > > Current device ops implementation allows only two stages "set"/"not set"
> > > and requires caller to check if function pointer exists before
> > > calling it.
> > >
> > > In order to simplify this repetitive task, let's give an option to
> > > overwrite those pointers. This will allow us to set dummy functions
> > > for the specific function pointers.
> > >
> > > Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > ---
> > >  drivers/infiniband/core/device.c | 9 ++++-----
> > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> > > index d9f565a779df..9486e60b42cc 100644
> > > --- a/drivers/infiniband/core/device.c
> > > +++ b/drivers/infiniband/core/device.c
> > > @@ -2542,11 +2542,10 @@ EXPORT_SYMBOL(ib_get_net_dev_by_params);
> > >  void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
> > >  {
> > >  	struct ib_device_ops *dev_ops = &dev->ops;
> > > -#define SET_DEVICE_OP(ptr, name)                                               \
> > > -	do {                                                                   \
> > > -		if (ops->name)                                                 \
> > > -			if (!((ptr)->name))				       \
> > > -				(ptr)->name = ops->name;                       \
> > > +#define SET_DEVICE_OP(ptr, name)					\
> > > +	do {								\
> > > +		if (ops->name)						\
> > > +			(ptr)->name = ops->name;			\
> > >  	} while (0)
> >
> > Did you carefully check every driver to be sure it is OK with this?
> >
> > Maybe Kamal remembers why it was like this?
> >
> > Jason
>
> The idea was to set a specific op only once by the provider when there
> is a valid function for the op, this was done to make sure that if
> the op isn't supported by the provider then it will be set to NULL.

This is not changed.

>
> I think it will be more cleaner from the provider point of view to
> see which ops are supported or not supported in the provider code. by
> overriding the ops in the core this will make things more confusing.

Actually the patch does quite opposite, set defaults by IB/core and
overwrite it by the provider later and not vice versa. The IB/core
won't overwrite defined by the provider ops. From provider point of view
no change.

Thanks

>
> Thanks,
> Kamal
