Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC413E58A6
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Aug 2021 12:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbhHJKyj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Aug 2021 06:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239946AbhHJKyj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Aug 2021 06:54:39 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CD7C0613D3
        for <linux-rdma@vger.kernel.org>; Tue, 10 Aug 2021 03:54:15 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x8so40639652lfe.3
        for <linux-rdma@vger.kernel.org>; Tue, 10 Aug 2021 03:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1QkSp5J3Hvrsj4YNWtcb2tRi/kV4gKqkTdigi6eM6HA=;
        b=bs7I9DaKjLQpPxkIc78koJ7zeO/Mu344/XAG6rfFhrmZ0wAoLeBsXt6GOH/MsoBkOs
         zlaxDWQwsa2/mq32ju9pUUK2cLMDv6NU/GFiBhw+mIrwj+bzlnxD3VZB7SISBbseS5d7
         RpmXOtsRQuAeTXDKA7uGrap//zwTgmw2pbZlqMyxLQij9vdADLWavQnuDHzaz93Ufkdq
         TGkcPdH/SH6GBNFc1j9ZorkS4LJFrdV6C7XQmTa6e07czMHmprsACK2lrimWdZDcMic5
         jAoY1f+unV5zHZFVklr4EgkBahPBLDSYiqz5y7IK7ypmY6y1f6A7OnAG8qtkgCQqKVNE
         0FMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1QkSp5J3Hvrsj4YNWtcb2tRi/kV4gKqkTdigi6eM6HA=;
        b=jgld2VUb33cRrWEpLAY9kM7xGqxWokGJibkl4ekk5rLzshaAYRUTcH1uNK14PGzVwt
         NNjItSE/rDFAjWylF4FpUEsLEWwgR7orJtmu3o58ksDHK5F4hEUgtjRiks5WKK6ERZhw
         xLMWCuzHlH6oLB12uPVxyEIXjdHC88X8cmKU3L0wuLhLnIkC94el3qi68ZVLvfSEyhbY
         gy3jh8ez4/KBDhYIXNyuhhs+p7tQNUj+d17D/YPAPNY17h2CvJ4thmQ6v6KK0cXj2iI4
         3UlQPgqqGoDjiUEBqbriUaJggWU+giRlfO9FSI5Y9wIko3c8xpEJ8TzSu/pzql2a+tUX
         KV8Q==
X-Gm-Message-State: AOAM533qJmGpZAjGoRmxAeKQPSwWBiPMdMzmhHaUnntHEfSiaKp/Jp00
        SnASlGn49z16zAiH4e+p0ozuZC73U3XYZLzVJwn0AA==
X-Google-Smtp-Source: ABdhPJycIpLAkHQPq+sE0AeJl82uJ4GXUUavpTTGg6YfjdmYsVq2M8XS8yj6XkWNudO1auMiow/wD8Wbt9MkTYcBUw8=
X-Received: by 2002:a05:6512:e81:: with SMTP id bi1mr2951883lfb.58.1628592854021;
 Tue, 10 Aug 2021 03:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210806112112.124313-1-haris.iqbal@ionos.com>
 <20210806112112.124313-4-haris.iqbal@ionos.com> <YQ+d1Ssiw+G5THYe@unreal>
 <CAD+HZHXM_MvTrNtAm=egQwKFhyHAi5WHDcXhTC0wvSegHbd4sg@mail.gmail.com> <YQ/AUHeLg5kaqMiH@unreal>
In-Reply-To: <YQ/AUHeLg5kaqMiH@unreal>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Tue, 10 Aug 2021 12:54:03 +0200
Message-ID: <CAJpMwyjUunS_sx9EoP6--Gau8ukP8E5H9Q6ckRbxYdJB6j9iOQ@mail.gmail.com>
Subject: Re: [PATCH v2 for-next 3/6] RDMA/rtrs: Fix warning when use poll mode
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <xjtuwjp@gmail.com>, Gioh Kim <gi-oh.kim@ionos.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 8, 2021 at 1:30 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Sun, Aug 08, 2021 at 01:07:29PM +0200, Jack Wang wrote:
> > Leon Romanovsky <leon@kernel.org>=E4=BA=8E2021=E5=B9=B48=E6=9C=888=E6=
=97=A5 =E5=91=A8=E6=97=A511:05=E5=86=99=E9=81=93=EF=BC=9A
> >
> > > On Fri, Aug 06, 2021 at 01:21:09PM +0200, Md Haris Iqbal wrote:
> > > > From: Jack Wang <jinpu.wang@ionos.com>
> > > >
> > > > when test with poll mode, it will fail and lead to warning below:
> > > > echo "sessname=3Dbla path=3Dgid:fe80::2:c903:4e:d0b3@gid:fe80::2:c9=
03:8:ca17
> > > > device_path=3D/dev/nullb2 nr_poll_queues=3D-1" |
> > > > sudo tee /sys/devices/virtual/rnbd-client/ctl/map_device
> > > >
> > > > rnbd_client L597: Mapping device /dev/nullb2 on session bla,
> > > > (access_mode: rw, nr_poll_queues: 8)
> > > > WARNING: CPU: 3 PID: 9886 at drivers/infiniband/core/cq.c:447
> > > ib_cq_pool_get+0x26f/0x2a0 [ib_core]
> > > >
> > > > The problem is, when poll_queues are used, there will be more
> > > connections than
> > > > number of cpus; and those extra connections will have ib poll conte=
xt
> > > set to
> > > > IB_POLL_DIRECT, which is not allowed to be used for shared CQs.
> > > >
> > > > So, in case those extra connections when poll queues are used, use
> > > > ib_alloc_cq/ib_free_cq.
> > > >
> > > > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > > Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
> > > > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > > > ---
> > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c |  1 +
> > > >  drivers/infiniband/ulp/rtrs/rtrs.c     | 17 ++++++++++++++---
> > > >  2 files changed, 15 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > index cd9a4ccf4c28..47775987f91a 100644
> > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > @@ -1768,6 +1768,7 @@ static struct rtrs_srv_sess *__alloc_sess(str=
uct
> > > rtrs_srv *srv,
> > > >       strscpy(sess->s.sessname, str, sizeof(sess->s.sessname));
> > > >
> > > >       sess->s.con_num =3D con_num;
> > > > +     sess->s.irq_con_num =3D con_num;
> > > >       sess->s.recon_cnt =3D recon_cnt;
> > > >       uuid_copy(&sess->s.uuid, uuid);
> gTgT> > >       spin_lock_init(&sess->state_lock);
> > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c
> > > b/drivers/infiniband/ulp/rtrs/rtrs.c
> > > > index ca542e477d38..9bc323490ce3 100644
> > > > --- a/drivers/infiniband/ulp/rtrs/rtrs.c
> > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> > > > @@ -228,7 +228,12 @@ static int create_cq(struct rtrs_con *con, int
> > > cq_vector, int nr_cqe,
> > > >       struct rdma_cm_id *cm_id =3D con->cm_id;
> > > >       struct ib_cq *cq;
> > > >
> > > > -     cq =3D ib_cq_pool_get(cm_id->device, nr_cqe, cq_vector, poll_=
ctx);
> > > > +     if (con->cid >=3D con->sess->irq_con_num)
> > > > +             cq =3D ib_alloc_cq(cm_id->device, con, nr_cqe, cq_vec=
tor,
> > > > +                              poll_ctx);
> > > > +     else
> > > > +             cq =3D ib_cq_pool_get(cm_id->device, nr_cqe, cq_vecto=
r,
> > > poll_ctx);
> > >
> > > I see same "if (con->c.cid >=3D sess->s.irq_con_num)" checks when cal=
ling
> > > to rtrs_cq_qp_create() that will take poll_ctx and convey it to
> > > create_cq().
> > >
> > > Please take a look on nvme_rdma_create_cq() which does the same witho=
ut
> > > passing poll_ctx.
> > >
> > > Thanks
> >
> > Hi,
> >
> > The reason rtrs needs to have poll_ctx is rtrs-clt and rtrs-srv use
> > different poll_ctx, and they all call into rtrs_cq_qp_create, while
> > nvme_rdma_create_cq is only for host (client) side.
> >
> > I guess you wanted to convert the same if
> > (con->c.cid>=3Dsess->s.irq_con_num), this can be done in a new patch.
>
> I don't want to see code that does something like that:
>  if (a_cond)
>    f(...)
>       if (a_cond)
>         do_X
>        else
>         do_Y
>
> The ideal flow should have minimal number of ifs to make the code
> more clear and readable, and definitely shouldn't have same if()
> checks in various places of the callstack.
>
> In your case, rtrs-srv uses IB_POLL_WORKQUEUE as poll_ctx which doesn't
> look related to the issue stated in the commit message.

Thanks for the inputs Leon.

This patch can be dropped. I will make the changes and send the patchset ag=
ain.


>
> Thanks
>
> >
> > Thanks
> >
> > >
> > >
