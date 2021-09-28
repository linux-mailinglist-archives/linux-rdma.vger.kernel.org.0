Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE08F41A952
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Sep 2021 09:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239026AbhI1HKT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Sep 2021 03:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238806AbhI1HKS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Sep 2021 03:10:18 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8D1C061575
        for <linux-rdma@vger.kernel.org>; Tue, 28 Sep 2021 00:08:39 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id e15so88649054lfr.10
        for <linux-rdma@vger.kernel.org>; Tue, 28 Sep 2021 00:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hZrJ5tItdByX8dF8ogMxOoKhSK5fPa27HdHhQMiIEoo=;
        b=ewWaYg39JWGggv6uKsoAKdJF03DtHW35oeKcgzH+EKXwxsIKMlDgwaflzEJkpsrnDy
         WkDeQA7KRGB5ydrP7+ebPyQ/vAs5mQAA8rSpxt9hAL0rGSeDo/aK552xs9/VkSmLL2fV
         6Y2q7HiuITNCbLa0U2QDoPadoWpbZnrHe6yQy0WmNA69zoNDjNJ1yyR4Nt8P6TTlOIxW
         1AD4X+YBFLLXeWwsFwe8SIWy/frMY7B8hlI/iUUIoJLhX3YTeFHYhxG3ZwmdNEgRgcfR
         fh0WaNs5SNDnLHk1pdtI73Ge/EskEwjfOcHDs5e59NUCB4I2VUXul5ISsfWbRIaPMxNx
         PxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hZrJ5tItdByX8dF8ogMxOoKhSK5fPa27HdHhQMiIEoo=;
        b=5nhlQYanOfDLXuAs6nOjNTOGLg0nQZFVvaN2ysDP8aoK8gPYjbSrLq2GVUCMWCO8t3
         4vGIVBAOY1Kf+RkYpL9M6j77xtSKhpE93Ik7lEA1B7D31O2yn7tcICkk4ojI30Q1ClOl
         hoEwynBJVu/TeYjWqWDzCfkiBlceT06NMVfjM8bVaNC/ph4+kaNCGYO5LKWRMVo7zcsK
         3lg43rc8oUTZFAe2ZnJtNc4IFLuKdYkWMkJ9lAif8qzeMkSuLdEwTh9urYiFncun7afc
         j+Zc0lolHJM2iTVeIu8rz+W/RBPTmPvMjZJi8iwj2KGBWx7Yuy4TxgSYZY3gUkt8E/xO
         +bxg==
X-Gm-Message-State: AOAM533TcG2G3/vl46yhktfFZkCXxtiooEPxRmlxI9bVs3eiFFhzpvy2
        WU3nMU/mBPX6WAlHCSGdEzMlM8c1pFcgUWhx+ek=
X-Google-Smtp-Source: ABdhPJxFO5Y1EGu1VQqh5UR6edK0rMq1JEdaFTHHxE4cUZr6C6mNJkBxnr4Lo/lA7A6ueacxR1YS0iE8sMNtKfvjp3w=
X-Received: by 2002:a2e:e1a:: with SMTP id 26mr4273292ljo.331.1632812917469;
 Tue, 28 Sep 2021 00:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210922125333.351454-1-haris.iqbal@ionos.com>
 <20210922125333.351454-7-haris.iqbal@ionos.com> <YVG3cme0KX9CD4oh@unreal>
In-Reply-To: <YVG3cme0KX9CD4oh@unreal>
From:   Jack Wang <xjtuwjp@gmail.com>
Date:   Tue, 28 Sep 2021 09:08:26 +0200
Message-ID: <CAD+HZHWTZY=6W4MNEGwVi=e64MJtntVE1Hwm6Lt_m=UaAW2W-A@mail.gmail.com>
Subject: Re: [PATCH for-next 6/7] RDMA/rtrs: Do not allow sessname to contain
 special symbols / and .
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Md Haris Iqbal <haris.iqbal@ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jack Wang <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Aleksei Marov <aleksei.marov@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Leon Romanovsky <leon@kernel.org> =E4=BA=8E2021=E5=B9=B49=E6=9C=8827=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=882:23=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Sep 22, 2021 at 02:53:32PM +0200, Md Haris Iqbal wrote:
> > Allowing these characters in sessname can lead to unexpected results,
> > particularly because / is used as a separator between files in a path,
> > and . points to the current directory.
> >
> > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
> > Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ++++++
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 +++++
> >  2 files changed, 11 insertions(+)
>
> It will be safer if you check for only allowed symbols and disallow
> everything else. Check for: a-Z, 0-9 and "-".
>
Hi Leon,

Thanks for your suggestions.
The reasons we choose to do disallow only '/' and '.':
1 more flexible, most UNIX filenames allow any 8-bit set, except '/' and nu=
ll.
2 matching for 2 characters is faster than checking all the allowed
symbols during session establishment.
3 we do use hostnameA@hostnameB for production usage right now, we
don't want to break the user space.

I hope this makes sense to you.

Regards!

>
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniban=
d/ulp/rtrs/rtrs-clt.c
> > index bc8824b4ee0d..15c0077dd27e 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > @@ -2788,6 +2788,12 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_o=
ps *ops,
> >       struct rtrs_clt *clt;
> >       int err, i;
> >
> > +     if (strchr(sessname, '/') || strchr(sessname, '.')) {
> > +             pr_err("sessname cannot contain / and .\n");
> > +             err =3D -EINVAL;
> > +             goto out;
> > +     }
> > +
> >       clt =3D alloc_clt(sessname, paths_num, port, pdu_sz, ops->priv,
> >                       ops->link_ev,
> >                       reconnect_delay_sec,
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniban=
d/ulp/rtrs/rtrs-srv.c
> > index 078a1cbac90c..7df71f8cf149 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > @@ -803,6 +803,11 @@ static int process_info_req(struct rtrs_srv_con *c=
on,
> >               return err;
> >       }
> >
> > +     if (strchr(msg->sessname, '/') || strchr(msg->sessname, '.')) {
> > +             rtrs_err(s, "sessname cannot contain / and .\n");
> > +             return -EINVAL;
> > +     }
> > +
> >       if (exist_sessname(sess->srv->ctx,
> >                          msg->sessname, &sess->srv->paths_uuid)) {
> >               rtrs_err(s, "sessname is duplicated: %s\n", msg->sessname=
);
> > --
> > 2.25.1
> >
