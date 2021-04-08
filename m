Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9C6358057
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 12:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhDHKML (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 06:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhDHKMK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Apr 2021 06:12:10 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE679C061760
        for <linux-rdma@vger.kernel.org>; Thu,  8 Apr 2021 03:11:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h10so1672438edt.13
        for <linux-rdma@vger.kernel.org>; Thu, 08 Apr 2021 03:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qyKMK6jH1smytgrau7hYtCg2cqz/mIRAd8/Q7BIbCnU=;
        b=WLYbOPqGlYkns39ByHPZT7YGpjGxqHGGWJ/Jf4EhXkQyNvaebvfcgepnArvZwhnq/w
         mC5t2jAFBOOmSqTK3x1WYDEUjaljXotKBjWuPTj3tUHQMozh9qNS8wcDh1rMYEehRHmu
         bqB8jgCHqfdo+j4JzOm/7i29b+B40R0F8eEq1ydYKtqgfWAwuAxRKwsvU+q/cR63cnFM
         Y8qTL7cC41IZdM6bRLgk3GzNxNJQhvm1tynITIQJXT1DOvGSU8AHWPePD2pczYYFnJMg
         4Rbg5QoH9t4lgboZaCbT8rKSDgAccBcc0oGI4zz7Bz+DwaYhqeH/W/AAnRgkMVMXbUwL
         f2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyKMK6jH1smytgrau7hYtCg2cqz/mIRAd8/Q7BIbCnU=;
        b=ot1B8yKII9ZzPBQA4cBNk1cNHPy8lA5qtCFAQM3ZP4oar+5YCXuQKzlVXGoLfe+TwE
         gVgHW5+k/m4pkPP0NqxCNKy6BbMFZv7nZPTQcLSHzdi3APOVpSZAHFdFH2c1btdnslui
         VsucCU9Uq+m+6aKlMoCiwhxpYJh9Y95IKLjOKAdO1tjjySITpG7elp60mCK9oydWcvYa
         hJXaXTim6sCewcqO9c+JtKhLy8QRBnyNe1Kx3ngATS56KBcOhM7ZMXmNMwkC60iAgtAX
         WnGLpY86p8wStKPIOreeEWo5KSsiXrrvAuHkHciRvVvaZTKrkvnyqRbjPskQYpRbpZyu
         1aQw==
X-Gm-Message-State: AOAM530tR1O0r+u8GWfvRb0R0yR9VXfyMCbPDPPiMmo4UWuY1Xu/IRNJ
        vGWQpopo1kvuQ0wsTHGx9Bklc+SPeBFbI7bqD1uUNw==
X-Google-Smtp-Source: ABdhPJyfmdHSXXShz+KCotKpXYe+NJJcEj2Ph+hszRtwjWxOyYkdp9kIwhvYiQrmSuTLaVl9HqndX5KyWp62VhCaZho=
X-Received: by 2002:a05:6402:447:: with SMTP id p7mr10302658edw.89.1617876718609;
 Thu, 08 Apr 2021 03:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210408093215.24023-1-jinpu.wang@ionos.com> <YG7RbOo/N1TeoqJB@unreal>
In-Reply-To: <YG7RbOo/N1TeoqJB@unreal>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 8 Apr 2021 12:11:48 +0200
Message-ID: <CAMGffEmF+khz=Jgn8PtNMdBQ__rLocVf2oY_8WwmvEGnQ=rUGQ@mail.gmail.com>
Subject: Re: [PATCH v3] RDMA/ipoib: print a message if only child interface is UP
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 8, 2021 at 11:48 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, Apr 08, 2021 at 11:32:15AM +0200, Jack Wang wrote:
> > When "enhanced IPoIB" enabled for CX-5 devices, it requires
> > the parent device to be UP, otherwise the child devices won't
> > work.
> >
> > This add a debug message to give admin a hint, if only child interface
> > is UP, but parent interface is not.
> >
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > ---
> >  drivers/infiniband/ulp/ipoib/ipoib_main.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> > index e16b40c09f82..df6329abac1d 100644
> > --- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
> > +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> > @@ -164,8 +164,13 @@ int ipoib_open(struct net_device *dev)
> >                       dev_change_flags(cpriv->dev, flags | IFF_UP, NULL);
> >               }
> >               up_read(&priv->vlan_rwsem);
> > -     }
> > +     } else if (priv->parent) {
> > +             struct ipoib_dev_priv *ppriv = ipoib_priv(priv->parent);
> >
> > +             if (!test_bit(IPOIB_FLAG_ADMIN_UP, &ppriv->flags))
> > +                     ipoib_dbg(priv, "parent device %s is not up, so child device may be not functioning.\n",
> > +                               ppriv->dev->name);
>
>
> I personally would use stronger language than that.
As there is configuration like on old CX-2/CX-3 HCA, it works fine, so
I use such language.
>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Thanks
Thanks for the review!
>
> > +     }
> >       netif_start_queue(dev);
> >
> >       return 0;
> > --
> > 2.25.1
> >
