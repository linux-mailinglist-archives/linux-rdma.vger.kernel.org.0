Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AAA41D479
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 09:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348636AbhI3HZF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 03:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348699AbhI3HZE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 03:25:04 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1F2C06161C;
        Thu, 30 Sep 2021 00:23:22 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so6169354otb.1;
        Thu, 30 Sep 2021 00:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1I1nXLI6APgtAXVlnSH2tDSE1F+gk/nTZkMd/P13QnM=;
        b=AM00vJx8YutY2y03FGwOzMB4F65tCdTPaWerM11qRrgq55yZhS8ZGBFp0tpAVyO6Wb
         gUwNrDppdPLFqCHICaRzrcwXawyxIM1xDLWZTR4XVuNzTgSUC02vUfp8LzCl7S/VOFS7
         ixqY5BL4KNH9gHHnwpnTTstkk7zIt/1fY/vKdXaW07IkHOvo7iskocXGhAcSWZcDHc+9
         pq6xubaraFJR+yZ6ZDBB2CK7GaOL0fjp52QcsGtdnG5Cq/zzyxIo/UL05C6//UP+ZNtI
         mnGXbC+CLflXmPAY7glOl3xYRbPBxliG0LxRCw2ZtDSsfhE3jDSaWvqfAHkic75hGp5c
         eCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1I1nXLI6APgtAXVlnSH2tDSE1F+gk/nTZkMd/P13QnM=;
        b=GZI7ZG7aS88+dP9KYjFMRQGWc3PodWtXgFFF+EjRFe27iUwpyPtEHrjbeL4mVRnOZD
         E8jPU6q1KJZX8K2XWYbuT0UsEKOHMk6ONlC9hTYdSh9F/zYPYhEDNat0q1sfg0pn6DhY
         3Gim5HFzKIQ1/E/nkyJYeIYOA2KNwqO7VgDyBWlMYtjvzD+cVllqv2Cj/zsRR5jIycrH
         HpbOSVXT2yGWJYiY2nLTt6eVvba62s7Zg4ZiZcEUiZ2MrRXqCa8FS5ZF9Kd99vLENd3f
         SItE65hgwwuG+GuLZO9PttxZh+fGhi2KbzJI0YAIAjyrTF/uBibVMlC57e3iM/NolT5H
         g2qA==
X-Gm-Message-State: AOAM532RJEs7SnEIxk82ZY86sEjNJMw0tohUC24Sa7EeCuhF3lw2Cgnm
        RdHAtG8v4JePgFe9Yb1f1jP3gion0EgTq/9qX1o=
X-Google-Smtp-Source: ABdhPJzkx0SiPJkTwjnw/szFDmj1KPx6Cg36LPLPfN3a1aV1RvHl2MDEPnGNEoGlyj86D+iBI4eONraBUbwXekv8q/s=
X-Received: by 2002:a05:6830:1089:: with SMTP id y9mr3930400oto.335.1632986602241;
 Thu, 30 Sep 2021 00:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210930062014.38200-1-mie@igel.co.jp> <20210930062014.38200-2-mie@igel.co.jp>
 <CAD=hENdzYGNp14fm9y9+A71D2BJSjV5GewHMkSJKUzNOs0hqWg@mail.gmail.com> <CANXvt5pcHbRVa9=Uqi-MN6RY1g6OY1MDecyhdedqL8Xmv0y6QQ@mail.gmail.com>
In-Reply-To: <CANXvt5pcHbRVa9=Uqi-MN6RY1g6OY1MDecyhdedqL8Xmv0y6QQ@mail.gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 30 Sep 2021 15:23:10 +0800
Message-ID: <CAD=hENcANb07bZiAuDYmozsWmZ4uA23Rqca=400+v23QQua_bg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] Providers/rxe: Add dma-buf support
To:     Shunsuke Mie <mie@igel.co.jp>
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

On Thu, Sep 30, 2021 at 2:58 PM Shunsuke Mie <mie@igel.co.jp> wrote:
>
> 2021=E5=B9=B49=E6=9C=8830=E6=97=A5(=E6=9C=A8) 15:37 Zhu Yanjun <zyjzyj200=
0@gmail.com>:
> >
> > On Thu, Sep 30, 2021 at 2:20 PM Shunsuke Mie <mie@igel.co.jp> wrote:
> > >
> > > Implement a new provider method for dma-buf base memory registration.
> > >
> > > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > > ---
> > >  providers/rxe/rxe.c | 21 +++++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > >
> > > diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
> > > index 3c3ea8bb..84e00e60 100644
> > > --- a/providers/rxe/rxe.c
> > > +++ b/providers/rxe/rxe.c
> > > @@ -239,6 +239,26 @@ static struct ibv_mr *rxe_reg_mr(struct ibv_pd *=
pd, void *addr, size_t length,
> > >         return &vmr->ibv_mr;
> > >  }
> > >
> > > +static struct ibv_mr *rxe_reg_dmabuf_mr(struct ibv_pd *pd, uint64_t =
offset,
> > > +                                       size_t length, uint64_t iova,=
 int fd,
> > > +                                       int access)
> > > +{
> > > +       struct verbs_mr *vmr;
> > > +       int ret;
> > > +
> > > +       vmr =3D malloc(sizeof(*vmr));
> > > +       if (!vmr)
> > > +               return NULL;
> > > +
> >
> > Do we need to set vmr to zero like the following?
> >
> > memset(vmr, 0, sizeof(*vmr));
> >
> > Zhu Yanjun
> Thank you for your quick response.
>
> I think it is better to clear the vmr. Actually the mlx5 driver allocates
> the vmr using calloc().
>
> In addition, rxe_reg_mr() (not rxe_reg_dmabuf_mr()) is used the malloc
> and not clear the vmr. I think It has to be fixed too. Should I make
> another patch to fix this problem?

Yes. Please.

Zhu Yanjun

>
> Thanks a lot.
> Shunsuke
>
> ~
