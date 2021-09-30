Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E862C41D3BE
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 08:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348435AbhI3G76 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 02:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348393AbhI3G74 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 02:59:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CDCC06161C
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 23:58:13 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id m3so20900540lfu.2
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 23:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AM58cnJzWheq7pN6e6L+Di8EyxwT/TZuwdLAOFe5lTM=;
        b=zUA02mDiD7ySh4VXdtJEkfF+YdiTY26SnB/zKlU6AV6H7K06hWuMhIkqyICSRgwmLh
         mMJqj75qYMRjZUryj8QznGOt1/uDr4q20FUyRlmfjvyWGDa9fNh1/KqmeTmllPC6LWsE
         x4UA5ycScWSfPjOhkCW04pIaQRZYoSk1kxBDhV5iIfdgOPXgQIurppjGXWQBQKV44tdK
         e3xYCw8TWtFK4EQHVWDRiAj+PrQUHjPo23h+iyjT1HwajPzvid5J/T6xDSKDma7HJFnH
         Cj5iu6tWUHc/wClUvPhMJJqFlksmjgvu0yQ5HqUPJilAeIxDFCaEgOlTE9y+38eHL9g4
         81Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AM58cnJzWheq7pN6e6L+Di8EyxwT/TZuwdLAOFe5lTM=;
        b=IQJbTOodddui5SvSh9Z41PaMrfiQdMQ138VG4Kx3w6ybjSwb2aegPxwym6Sb0SG009
         XfguZqO/ZGMjvz+ve1f+KaLd4gX410fmhkeSMcc7Rm8dN/Fe1Z8VSAgXLuddt0ksdsvU
         dx31s2lLC9Uhy0qnV9lsKBduVN7SNF9zHdiSY0onjGCr8H5+6vXk1reeJTAAYw4mwDDk
         pWcmPJc7QRZwbZY77lfDGlCyfefzWGiMNTbq0h15xToEUkKpqqdG/4cgHQWZzyqmFfGn
         e/mmq4upFosk0gErrHRF830pzbF5cZUoV9xvnTTcF30H+idyhAK96T5aOgLM0EmzIYh4
         FQWQ==
X-Gm-Message-State: AOAM531QLslqXwfdjz7NjxRK3ZC4CISTyOOJPM3lFLmuMjjJMkCYroU/
        4JbZVplkXy3iFzsetw1zXzxA1IlFNwcPXen5D1R//w==
X-Google-Smtp-Source: ABdhPJyBqEgHtMpNYqgONgpO8bSsYcGCUmFFaeLYGEyFgNwtKcwbfga4y3No6ih2UN25mIxw8sdz+lK6j2VMsBbQMOg=
X-Received: by 2002:a19:f507:: with SMTP id j7mr4119788lfb.645.1632985091555;
 Wed, 29 Sep 2021 23:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210930062014.38200-1-mie@igel.co.jp> <20210930062014.38200-2-mie@igel.co.jp>
 <CAD=hENdzYGNp14fm9y9+A71D2BJSjV5GewHMkSJKUzNOs0hqWg@mail.gmail.com>
In-Reply-To: <CAD=hENdzYGNp14fm9y9+A71D2BJSjV5GewHMkSJKUzNOs0hqWg@mail.gmail.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Thu, 30 Sep 2021 15:58:00 +0900
Message-ID: <CANXvt5pcHbRVa9=Uqi-MN6RY1g6OY1MDecyhdedqL8Xmv0y6QQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] Providers/rxe: Add dma-buf support
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Maor Gottlieb <maorg@nvidia.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>,
        Tomohito Esaki <etom@igel.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

2021=E5=B9=B49=E6=9C=8830=E6=97=A5(=E6=9C=A8) 15:37 Zhu Yanjun <zyjzyj2000@=
gmail.com>:
>
> On Thu, Sep 30, 2021 at 2:20 PM Shunsuke Mie <mie@igel.co.jp> wrote:
> >
> > Implement a new provider method for dma-buf base memory registration.
> >
> > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > ---
> >  providers/rxe/rxe.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
> > index 3c3ea8bb..84e00e60 100644
> > --- a/providers/rxe/rxe.c
> > +++ b/providers/rxe/rxe.c
> > @@ -239,6 +239,26 @@ static struct ibv_mr *rxe_reg_mr(struct ibv_pd *pd=
, void *addr, size_t length,
> >         return &vmr->ibv_mr;
> >  }
> >
> > +static struct ibv_mr *rxe_reg_dmabuf_mr(struct ibv_pd *pd, uint64_t of=
fset,
> > +                                       size_t length, uint64_t iova, i=
nt fd,
> > +                                       int access)
> > +{
> > +       struct verbs_mr *vmr;
> > +       int ret;
> > +
> > +       vmr =3D malloc(sizeof(*vmr));
> > +       if (!vmr)
> > +               return NULL;
> > +
>
> Do we need to set vmr to zero like the following?
>
> memset(vmr, 0, sizeof(*vmr));
>
> Zhu Yanjun
Thank you for your quick response.

I think it is better to clear the vmr. Actually the mlx5 driver allocates
the vmr using calloc().

In addition, rxe_reg_mr() (not rxe_reg_dmabuf_mr()) is used the malloc
and not clear the vmr. I think It has to be fixed too. Should I make
another patch to fix this problem?

Thanks a lot.
Shunsuke

~
