Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97BD357F2D
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 11:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhDHJbc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 05:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhDHJb3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Apr 2021 05:31:29 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C13C061760
        for <linux-rdma@vger.kernel.org>; Thu,  8 Apr 2021 02:31:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w18so1619719edc.0
        for <linux-rdma@vger.kernel.org>; Thu, 08 Apr 2021 02:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eoTzasxUkZY3HLXBRLOvfPtkTUdcBihhjtLstNaTC7E=;
        b=U5Z8Bnx0GS7Xs1KgAUmwLYFv94dwf77Y3yvg0LjDZkgGAIkLvoW3gmEMQAQkcCdfl7
         QoZf2uomtFCDEVbfzTn3rIkb6ol82URImVQEuPtzAXR/x+X1RbzFMnvyJr0hBczhE4eW
         bQk+LdK5Db6g+ILucYA5iARE5aFJF8TkScx9AF6Cjmit11Va0fnCMzvNXWETYOKYkL6Q
         CS1SKCa1qOhLRILfz8QXBIXKknSILhvUWE2GkLBdOUQ1bMyDYSlUQxWGpMypVQ50dMjv
         I9DsmuChauRC90FKkmgW0dn3DW55REZnP2s3wcs22ptKyC9GMQ+si7hGzzgogs7BtUZJ
         0j/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eoTzasxUkZY3HLXBRLOvfPtkTUdcBihhjtLstNaTC7E=;
        b=pr+dhtJQ+k3ZDXSRC9OjNkWYXZ4TEJvNC6xX6c6mTzZcnIOyOrnLFetOWKn8H9FANI
         nNNgo7dow5PDyWHCQE3f5GnEBodhBQ+eut6MeL0ap7l7KAbwa+oLFefriSzElYySLhBR
         uBrHHY7bQNu3ViV+E4QzHWIWp38exy6bkmpB1YpRG/r7DKI/jl0cf97KB5P4Bd475+k6
         6o/0RSxkdds5J+4fHUxaFdV9ItpdzwzNuSzVIWki0gfd7W5exEGIXfTYgvSC9BaoVXNw
         I0rHwTZymU/RRXTIZWEGRBVHIWwMHrTKQGxs2pBYEfRgdP/By/GLyageL3dGP2lDXGgu
         fQtA==
X-Gm-Message-State: AOAM530c0flZzM//uy7SnnL/IeGz6CzzDJ0PYmp1VoWBc0uxP6MtC/2Y
        U+1Hx2ssUn11/JbxLnryP4t/MPf6etoAvTt04f6rPQ==
X-Google-Smtp-Source: ABdhPJwgy1NModVchE/CCjQYJvRlpoBvivORiqRXI4Hd3TsKv273s7ZiUSdlB7i/wC3xVW3eu3FTnkkBB1eQEAzaj84=
X-Received: by 2002:a05:6402:447:: with SMTP id p7mr10103853edw.89.1617874276885;
 Thu, 08 Apr 2021 02:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210408083435.13043-1-jinpu.wang@ionos.com> <YG7ImyPNyqjWW8k2@unreal>
In-Reply-To: <YG7ImyPNyqjWW8k2@unreal>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 8 Apr 2021 11:31:06 +0200
Message-ID: <CAMGffEkDM06C+yk1Pqhj9fF5db4oWVcChxzBNWCx6xQsrB1B0A@mail.gmail.com>
Subject: Re: [PATCH] RDMA/ipoib: print a message if only child interface is UP
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 8, 2021 at 11:10 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, Apr 08, 2021 at 10:34:35AM +0200, Jack Wang wrote:
> > When "enhanced IPoIB" enabled for CX-5 devices, it requires
> > the parent device to be UP, otherwise the child devices won't
> > work.[1]
> >
> > This add a debug message to give admin a hint, if only child interface
> > is UP, but parent interface is not.
> >
> > [1]https://lore.kernel.org/linux-rdma/CAMGffE=3YYxv9i7_qQr3-Uv-NGr-7VsnMk8DTjR0YbX1vJBzXQ@mail.gmail.com/T/#u
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > ---
> >  drivers/infiniband/ulp/ipoib/ipoib_main.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> > index e16b40c09f82..782b792985b8 100644
> > --- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
> > +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> > @@ -164,8 +164,12 @@ int ipoib_open(struct net_device *dev)
> >                       dev_change_flags(cpriv->dev, flags | IFF_UP, NULL);
> >               }
> >               up_read(&priv->vlan_rwsem);
> > -     }
> > +     } else if (priv->parent) {
> > +             struct ipoib_dev_priv *ppriv = ipoib_priv(priv->parent);
> >
> > +             if (!test_bit(IPOIB_FLAG_ADMIN_UP, &ppriv->flags))
> > +                     ipoib_dbg(priv, "parent deivce %s is not up, so child may be not functioning.\n", ((struct ipoib_dev_priv *) ppriv)->dev->name);
>
> Why do you need extra casting? "ppriv" is already "struct ipoib_dev_priv *".

Indeed, will remove that.

Thanks
>
> Thanks
>
> > +     }
> >       netif_start_queue(dev);
> >
> >       return 0;
> > --
> > 2.25.1
> >
