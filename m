Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E3141D897
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 13:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350404AbhI3L0m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 07:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350387AbhI3L0m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 07:26:42 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C28C06176C
        for <linux-rdma@vger.kernel.org>; Thu, 30 Sep 2021 04:24:59 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x27so23958079lfu.5
        for <linux-rdma@vger.kernel.org>; Thu, 30 Sep 2021 04:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uXuubpiaHvCGjqJffAaQTQ1G86vGkNu1fG+McR/4pJE=;
        b=1YXxmYyDwyXa/pLD69OSg2dh2mD/CUMQXRNl40rzYEuhbROwsKquSxKvdFuafnh9vu
         vYUv21YMe6/waaoWrHcGy9OAvWlWqt+7dQwi4CwP7Ou/STf13JOOpmLQUE/rQ70KI9CI
         KdhgUmW8bEVEEcVf9ek3SNqrlb6QD4+nD3cWr0fLeTWesHQsbzWK0vj/6Bq6gHy6zov3
         WDcdEgbBKrYpRCx/lgkqmSkSdWfy/ee6civKUNyF51TXweZEq9IS8wZ4eoWb+HvTKOo6
         8jKkubBqoMB8V8kxGb0nPYbNuLDNlG6siN2Q6X4afp3NO8jFV2mPIDxL0UDVeOOgG4xB
         uayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uXuubpiaHvCGjqJffAaQTQ1G86vGkNu1fG+McR/4pJE=;
        b=NEH267Zg2vyVyVoJQ31iqVRlv4ZUA2oGLbUCyvVJa4qMwsfu968xK8VTITdy9rmRVg
         0+TWyo/7LdHABkcupM6giqhJDPVlkhx5NOoqU3V9sPaEkAT3hFs03j2QDbRCojf/Qlyb
         dz2tY2+Q0iLQpEoBtFS0Zz6KemNCLlUjJ59gW1k+xgiTVRdsUBas6+xfrAkbhlYuUxRx
         ojX3FDeMALTMUlZ1tZ79qvL2UUiJhfKoPQAOhd5IPLZ8hXQKnCAqOqQVnsQVYKQh2zHX
         KJ3OLWJLbHZOY8Lx4p54M1M+7AbyTn69QFlHWYYO0Yf2aFwsNk+p+rsbRPF3ZcLkAue+
         wA1g==
X-Gm-Message-State: AOAM5312yud0TzxIpgw/PUcIjHHC1gbeoCGHq42+2IKytgaYPMTXdxT3
        g3uvpU1hEv1AJkhwUu6bJpRm/7ql87usxgrf/EKuDQ==
X-Google-Smtp-Source: ABdhPJxdfAUcC0QOenFkKvmeHW4aJET0/QGn+h1YaNdBa6n8HLQG3FkbKif1NKriNUpSsDncNn7d4vM/CQGGK3Cz1uc=
X-Received: by 2002:a2e:904a:: with SMTP id n10mr5131362ljg.124.1633001098105;
 Thu, 30 Sep 2021 04:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210930062014.38200-1-mie@igel.co.jp> <20210930062014.38200-2-mie@igel.co.jp>
 <CAD=hENdzYGNp14fm9y9+A71D2BJSjV5GewHMkSJKUzNOs0hqWg@mail.gmail.com>
 <CANXvt5pcHbRVa9=Uqi-MN6RY1g6OY1MDecyhdedqL8Xmv0y6QQ@mail.gmail.com>
 <CAD=hENcANb07bZiAuDYmozsWmZ4uA23Rqca=400+v23QQua_bg@mail.gmail.com>
 <CANXvt5oZp=Ap3fEm4nsiP2WfG_c_8o57mN4+PHrQAGHcp-EH2A@mail.gmail.com> <CAD=hENfMu+OEW7K-WiYqbP7TpksU=0C9e0YZu3xCbqAurNpT9A@mail.gmail.com>
In-Reply-To: <CAD=hENfMu+OEW7K-WiYqbP7TpksU=0C9e0YZu3xCbqAurNpT9A@mail.gmail.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Thu, 30 Sep 2021 20:24:46 +0900
Message-ID: <CANXvt5qAesicr6m=YE0ZT4DMqo=MihfWfgdasXRJOhpnaKWbUA@mail.gmail.com>
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

2021=E5=B9=B49=E6=9C=8830=E6=97=A5(=E6=9C=A8) 20:18 Zhu Yanjun <zyjzyj2000@=
gmail.com>:
>
> On Thu, Sep 30, 2021 at 7:06 PM Shunsuke Mie <mie@igel.co.jp> wrote:
> >
> > 2021=E5=B9=B49=E6=9C=8830=E6=97=A5(=E6=9C=A8) 16:23 Zhu Yanjun <zyjzyj2=
000@gmail.com>:
> > >
> > > On Thu, Sep 30, 2021 at 2:58 PM Shunsuke Mie <mie@igel.co.jp> wrote:
> > > >
> > > > 2021=E5=B9=B49=E6=9C=8830=E6=97=A5(=E6=9C=A8) 15:37 Zhu Yanjun <zyj=
zyj2000@gmail.com>:
> > > > >
> > > > > On Thu, Sep 30, 2021 at 2:20 PM Shunsuke Mie <mie@igel.co.jp> wro=
te:
> > > > > >
> > > > > > Implement a new provider method for dma-buf base memory registr=
ation.
> > > > > >
> > > > > > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > > > > > ---
> > > > > >  providers/rxe/rxe.c | 21 +++++++++++++++++++++
> > > > > >  1 file changed, 21 insertions(+)
> > > > > >
> > > > > > diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
> > > > > > index 3c3ea8bb..84e00e60 100644
> > > > > > --- a/providers/rxe/rxe.c
> > > > > > +++ b/providers/rxe/rxe.c
> > > > > > @@ -239,6 +239,26 @@ static struct ibv_mr *rxe_reg_mr(struct ib=
v_pd *pd, void *addr, size_t length,
> > > > > >         return &vmr->ibv_mr;
> > > > > >  }
> > > > > >
> > > > > > +static struct ibv_mr *rxe_reg_dmabuf_mr(struct ibv_pd *pd, uin=
t64_t offset,
> > > > > > +                                       size_t length, uint64_t=
 iova, int fd,
> > > > > > +                                       int access)
> > > > > > +{
> > > > > > +       struct verbs_mr *vmr;
> > > > > > +       int ret;
> > > > > > +
> > > > > > +       vmr =3D malloc(sizeof(*vmr));
> > > > > > +       if (!vmr)
> > > > > > +               return NULL;
> > > > > > +
> > > > >
> > > > > Do we need to set vmr to zero like the following?
> > > > >
> > > > > memset(vmr, 0, sizeof(*vmr));
> > > > >
> > > > > Zhu Yanjun
> > > > Thank you for your quick response.
> > > >
> > > > I think it is better to clear the vmr. Actually the mlx5 driver all=
ocates
> > > > the vmr using calloc().
> > > >
> > > > In addition, rxe_reg_mr() (not rxe_reg_dmabuf_mr()) is used the mal=
loc
> > > > and not clear the vmr. I think It has to be fixed too. Should I mak=
e
> > > > another patch to fix this problem?
> > >
> > > Yes. Please.
> > >
> > > Zhu Yanjun
> > >
> > > >
> > > > Thanks a lot.
> > > > Shunsuke
> > > >
> > > > ~
> >
> > I looked into the vmr more, but there was no need to clear it. Moreover=
,
> > some implementations also use malloc without memory clear.
> >
>
> I confronted a lot of problems with memory not initialization.
> And a latest bug is https://www.spinics.net/lists/linux-rdma/msg105001.ht=
ml
>
> So it is a good habit to clear a newly allocated memory.
>
> Zhu Yanjun
>
> > Thanks,
> > Shunsuke
Ok, I understand that thought. I'll send a patch.

Shunsuke.
