Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590291E1CEB
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 10:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbgEZIH5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 May 2020 04:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgEZIH5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 May 2020 04:07:57 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C66C03E97E
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2020 01:07:56 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c71so2231108wmd.5
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2020 01:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oo2fmPnDs30YNi2WnYEPREs9cw2kFE9N89jzkl6L2uM=;
        b=AZQvZOffdzuYrG7Y7DOi6NcBcBFEz4Xp0NxaPH+oUSnH6mS+9oZ+GzKYiBYAxP6eMk
         gIALD259d/BJ61QDMkNuDao/jcLfnyIhpt8yr5b1FPjSkWiXsGUOh+u5ssnrH78+zP56
         eTGBG3kyTMj/ceZhKlD2H7RClmu+2ECfv2m2Ml97ZPu7zVG1RWLYQUoGZG1XIL+S5L7x
         RFYMwnA6ryb0tJhxo1rwf+thYxP55/eISz1LutM341GXpy2Ne3P3nklewOFpADhRI7At
         79yypbGDfiMlsO7YylpFyxfOlQZqCPMT0FDBrkL9qDlzSU2H09IFtKDiBXBhLm/ksuAr
         Ydig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oo2fmPnDs30YNi2WnYEPREs9cw2kFE9N89jzkl6L2uM=;
        b=k1CPlJ1nAqwfuNAux2ZzOQ5Lp3JlFSz3Zspv9rz3m1S+t6hzkK+WTneh/YzP5DwUw2
         aPzmU4xD0a3m6TOMVXZ43uMZ2WQSaQBaY4NU5vgJULWFaCWZG0rVP01OLfx/lnIO5t4i
         iL6vhte73s0DU39+qHLdmIEMcWvVA+jKJjLay5QQ25OZZnQdVBK1GWcabUsKMgdTZy5R
         ika86PdGtDcTw/XtWM40dm7mqiXthv2B5caECvTwOaui6ZJK58chwAE/1CkwkYFxg1Nl
         MqOeXn9Afqt/BxBGFY4X+JpmU08B0hRefzFt59o0w0q7Yvv4dKKWIeeTsq5vHcqNcvxG
         G3Hw==
X-Gm-Message-State: AOAM531tB+KMRT5cRcFt10IQoTlrJkoxMePyrRoBV84AkOtfLnQ79/Fz
        TTuvcVDAEODKyrcnZcCeyjY=
X-Google-Smtp-Source: ABdhPJxUBqtZdjEPFKULjouVP/oRokh8vrLjI1bROkbaUcVgJGghek0G2ZviFpM73A1ptJUbD5V1NA==
X-Received: by 2002:a1c:7e43:: with SMTP id z64mr232984wmc.72.1590480475417;
        Tue, 26 May 2020 01:07:55 -0700 (PDT)
Received: from kheib-workstation ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id z25sm7427756wmf.10.2020.05.26.01.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 01:07:54 -0700 (PDT)
Date:   Tue, 26 May 2020 11:07:51 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 04/14] RDMA/core: Allow to override device op
Message-ID: <20200526080751.GA182953@kheib-workstation>
References: <20200513095034.208385-1-leon@kernel.org>
 <20200513095034.208385-5-leon@kernel.org>
 <20200525142641.GA20978@ziepe.ca>
 <20200525232125.GA177080@kheib-workstation>
 <20200526055342.GP10591@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526055342.GP10591@unreal>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 26, 2020 at 08:53:42AM +0300, Leon Romanovsky wrote:
> On Tue, May 26, 2020 at 02:21:25AM +0300, Kamal Heib wrote:
> > On Mon, May 25, 2020 at 11:26:41AM -0300, Jason Gunthorpe wrote:
> > > On Wed, May 13, 2020 at 12:50:24PM +0300, Leon Romanovsky wrote:
> > > > From: Maor Gottlieb <maorg@mellanox.com>
> > > >
> > > > Current device ops implementation allows only two stages "set"/"not set"
> > > > and requires caller to check if function pointer exists before
> > > > calling it.
> > > >
> > > > In order to simplify this repetitive task, let's give an option to
> > > > overwrite those pointers. This will allow us to set dummy functions
> > > > for the specific function pointers.
> > > >
> > > > Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> > > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > > ---
> > > >  drivers/infiniband/core/device.c | 9 ++++-----
> > > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> > > > index d9f565a779df..9486e60b42cc 100644
> > > > --- a/drivers/infiniband/core/device.c
> > > > +++ b/drivers/infiniband/core/device.c
> > > > @@ -2542,11 +2542,10 @@ EXPORT_SYMBOL(ib_get_net_dev_by_params);
> > > >  void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
> > > >  {
> > > >  	struct ib_device_ops *dev_ops = &dev->ops;
> > > > -#define SET_DEVICE_OP(ptr, name)                                               \
> > > > -	do {                                                                   \
> > > > -		if (ops->name)                                                 \
> > > > -			if (!((ptr)->name))				       \
> > > > -				(ptr)->name = ops->name;                       \
> > > > +#define SET_DEVICE_OP(ptr, name)					\
> > > > +	do {								\
> > > > +		if (ops->name)						\
> > > > +			(ptr)->name = ops->name;			\
> > > >  	} while (0)
> > >
> > > Did you carefully check every driver to be sure it is OK with this?
> > >
> > > Maybe Kamal remembers why it was like this?
> > >
> > > Jason
> >
> > The idea was to set a specific op only once by the provider when there
> > is a valid function for the op, this was done to make sure that if
> > the op isn't supported by the provider then it will be set to NULL.
> 
> This is not changed.
>

Well, This is changed in patch #6 as dummy functions are now allowed...,
Instead of setting NULL when the op isn't supported by the provider.

I'm wondering why allow only fill_res_entry() and fill_stat_entry() to
be a dummy function as there is multiple ops that can be dummy too,
and why this has to be in this patch set instead in a seperiate patch
set for all the ops that can be dummy? 

Thanks,
Kamal

> >
> > I think it will be more cleaner from the provider point of view to
> > see which ops are supported or not supported in the provider code. by
> > overriding the ops in the core this will make things more confusing.
> 
> Actually the patch does quite opposite, set defaults by IB/core and
> overwrite it by the provider later and not vice versa. The IB/core
> won't overwrite defined by the provider ops. From provider point of view
> no change.
> 
> Thanks
> 
> >
> > Thanks,
> > Kamal
