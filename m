Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3924A1D9C6A
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 18:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgESQVv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 12:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbgESQVs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 12:21:48 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA11C08C5C1
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 09:21:47 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id bs4so94381edb.6
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 09:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dm7TwEXp4lhr5q0JgyLJfssXo7pDuSlgCbYoFZyD8x8=;
        b=JcucbRwnAY3oAPJQ3DnkLD8AEFLKvd7kSm8tphkVFWNdCerEC97MAlx5wxfMtuKJic
         r9G3rp606PXroChm0tmelvevNx+GaxbtSdzxw1YFXoYWBm2aZrr0cdMEyBeV85kgQ944
         ENiCGwwr0Ncegl96r3x+wKydoOHhu8YVurYIYOJitKuFsn+4iQTJ9G6vpfTPJVBn2WUp
         avsIEtk9wyhpvggARcKYmpte9+R2/bDXzd9VNy8Hk9iL0i5k47r3XJtfu+MRC7dDgdUU
         svvC5i9ATPfSHpoWK/VO3AQWrnavjSlqlTUBHXbpJwaqjYrmiBnU5A89CvLtgeGaqnjQ
         /q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dm7TwEXp4lhr5q0JgyLJfssXo7pDuSlgCbYoFZyD8x8=;
        b=GiwE1L8MJb31Kik4DDVjAssXHpel7VEg8edc4kJ2d/ZuMbMpRHFFerrv1k2R4Bnjiy
         RN59D49SnmA1M77Q4jPeoQ1XGMd7xgPF+b0YiNbReFW0fgJpAL6Y4Fp5TsCYce2L65Rr
         Vn19Ic7hLxDNsaxl1BZ9io4Rcdh0WGx5tJBZGNRNQk4H+0cfyE2VVdf8gIG2UNQv8M0s
         sjVGrQQinI/uA+twX4Ivi3iaNxDrl2AlWU4ohHd/ciCEZj3uganw+R4QNQDtqKm5//WF
         t6ucbuvwEoE8qCuKk+Fj0/lJ1T0KLaiipLlYJmXgXo2vVz+l/GunIzJzRUMvsIPqAzYg
         Sgaw==
X-Gm-Message-State: AOAM532WUFlvlnwgCqqxndfbUKLxJf0djp53yKVRyvklJ6YPtOeAkaNY
        4Ts0i4dege0a+Xu9QFRgT77M3Twr+RVWKxOOkM/yEw==
X-Google-Smtp-Source: ABdhPJxg9aUP5rG6HYpoyDZEiA16bkewm3N1LqXgR/j9efQBmYKFVB/ih/3ZmLgaXGcj/GUCuFlB7lKKykNH0WHxTGU=
X-Received: by 2002:aa7:d787:: with SMTP id s7mr19137910edq.104.1589905305828;
 Tue, 19 May 2020 09:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200519161345.GA3910@embeddedor> <220e3cd2-2f22-063a-4117-8ee987521c61@acm.org>
In-Reply-To: <220e3cd2-2f22-063a-4117-8ee987521c61@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 19 May 2020 18:21:35 +0200
Message-ID: <CAMGffE=15s=GsO02iHL0qhBAaGx8OCBMUeR--GRWD6g41pnfyw@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs: client: Fix function return on success
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 19, 2020 at 6:16 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-05-19 09:13, Gustavo A. R. Silva wrote:
> > The function should return 0 on success, instead of err.
> >
> > Addresses-Coverity-ID: 1493753 ("Identical code for different branches")
> > Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > index 468fdd0d8713c..465515e46bb1a 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > @@ -1594,7 +1594,8 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
> >
> >       if (err)
> >               return err;
> > -     return err;
> > +
> > +     return 0;
> >  }
>
> Why to keep the if-statement? Has the following been considered?
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 8dfa56dc32bc..a7f5d55f8542 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1587,8 +1587,6 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
>          * since destroy_con_cq_qp() must be called.
>          */
>
> -       if (err)
> -               return err;
>         return err;
>  }
>
> Thanks,
>
> Bart.

This one seems better, thanks Bart and Gustavo, Gustavo, would you
like to send a v2 patch as Bart suggested?

Thanks,
