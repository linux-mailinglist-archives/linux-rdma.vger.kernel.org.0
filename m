Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261DD41D300
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 08:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348171AbhI3GFf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 02:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348054AbhI3GFf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 02:05:35 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFDDC06161C
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 23:03:52 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id dj4so18082039edb.5
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 23:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SIzN3lYylRHVYgGHVCc2R7kTgWtLZY1Hy9pZLRozj3U=;
        b=O7nSrd3g+Im+vja9Dch+rDwHoqevrA/q5zLPVSbYFKDwiakDuu292cH7e2/9wNHd4z
         SzFfGt1fU0OI/649p22B/pgNYAL1Mxk8Tpw9REa1tzdXtT4HHOs0AEmurokJV/9odbfp
         9wdoAnFf/p+ArLUdpxoaEr62x2LiHVrfblqbpF5WV+5oWd2ZnZhsEuuMcpDXPIUb7/Pm
         dJ2q9Ttg78XKlgGRg3I/ylg6VXzABOXblRZih972yYxg5CdzMuJPLVUzC09Jvgp1pUU6
         /UPiQNTEMv9PqMPqlyGjq0xCI4UL8ood5rkOVSjDL4FfMELnjsgkFR792sX7F6P48iBH
         gEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SIzN3lYylRHVYgGHVCc2R7kTgWtLZY1Hy9pZLRozj3U=;
        b=RF3EDm32Y0X+sIkDnfrldc2AHiabY5WTnIbOFcXicqEJxE1/eE8DRrTJqrJt1hVnyX
         z+IaWtObVm4nUsc32jKCjtx/AmznylV8XmNBxLOsrL26+SrunrVPMSY6l89iTX03dOUw
         xUu/cfy27chMNd20bFsPjEK66OwE2fdfPQfYlfxeJFKdBVqBhbBNSmtMIWN4Rq58AmDJ
         Lwbam0d1H2QSVH6JvCJeIpXRJGtLmT4cpqgczmITV0b/8xyFnGG6V5kSZUyXcfBFMf8l
         IAGP18mFNdjk2ZDFNeyPMw9ZprNzqu1n/U0QtlugmkS5uPTFH+0SiBhFdnLOS2xJl9LJ
         l6CQ==
X-Gm-Message-State: AOAM531e7VdBTCd3AcatVb2YEAiU/PlsBJ+BmE6LhivdRpzL3AtFHfpZ
        3Tch4OJx2CdzaBMYqK5JbiFtj31bIzsZencniljEnQ==
X-Google-Smtp-Source: ABdhPJzxylIusNjOzaPPzosm/X2CajDTMJ7NBWo1/wfgEfubavWDIck6R+bRV3czWL72i6bC1EATgNHhCB6feiR3q+g=
X-Received: by 2002:a05:6402:222b:: with SMTP id cr11mr5147267edb.392.1632981830833;
 Wed, 29 Sep 2021 23:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210922125333.351454-1-haris.iqbal@ionos.com>
 <20210922125333.351454-7-haris.iqbal@ionos.com> <YVG3cme0KX9CD4oh@unreal>
 <CAD+HZHWTZY=6W4MNEGwVi=e64MJtntVE1Hwm6Lt_m=UaAW2W-A@mail.gmail.com>
 <YVLEIVz1mCV0cZlC@unreal> <CAD+HZHW5u1MiB-+C784yYXZc9Q-F0yB+1EvRKb4sAQJe4p2Yeg@mail.gmail.com>
 <YVRWXim7T0mReBu/@unreal>
In-Reply-To: <YVRWXim7T0mReBu/@unreal>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 30 Sep 2021 08:03:40 +0200
Message-ID: <CAMGffE=mv8jJYeNC7BjiGbOt4qEFAQhXWROk4Uwzg5ED4a0sug@mail.gmail.com>
Subject: Re: [PATCH for-next 6/7] RDMA/rtrs: Do not allow sessname to contain
 special symbols / and .
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <xjtuwjp@gmail.com>,
        Md Haris Iqbal <haris.iqbal@ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Gioh Kim <gi-oh.kim@ionos.com>,
        Aleksei Marov <aleksei.marov@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 29, 2021 at 2:04 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Wed, Sep 29, 2021 at 09:00:56AM +0200, Jack Wang wrote:
> > Leon Romanovsky <leon@kernel.org> =E4=BA=8E2021=E5=B9=B49=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=889:28=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Tue, Sep 28, 2021 at 09:08:26AM +0200, Jack Wang wrote:
> > > > Leon Romanovsky <leon@kernel.org> =E4=BA=8E2021=E5=B9=B49=E6=9C=882=
7=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=882:23=E5=86=99=E9=81=93=EF=BC=
=9A
> > > > >
> > > > > On Wed, Sep 22, 2021 at 02:53:32PM +0200, Md Haris Iqbal wrote:
> > > > > > Allowing these characters in sessname can lead to unexpected re=
sults,
> > > > > > particularly because / is used as a separator between files in =
a path,
> > > > > > and . points to the current directory.
> > > > > >
> > > > > > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > > > > > Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
> > > > > > Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
> > > > > > ---
> > > > > >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ++++++
> > > > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 +++++
> > > > > >  2 files changed, 11 insertions(+)
> > > > >
> > > > > It will be safer if you check for only allowed symbols and disall=
ow
> > > > > everything else. Check for: a-Z, 0-9 and "-".
> > > > >
> > > > Hi Leon,
> > > >
> > > > Thanks for your suggestions.
> > > > The reasons we choose to do disallow only '/' and '.':
> > > > 1 more flexible, most UNIX filenames allow any 8-bit set, except '/=
' and null.
> > >
> > > So you need to add all possible protections and checks that VFS has t=
o allow "random" name.
> > It's only about sysfs here, as we use sessname to create dir in sysfs,
> > and I checked the code, it allows any 8-bit set, and convert '/' to
> > '!', see https://elixir.bootlin.com/linux/latest/source/lib/kobject.c#L=
299
> > >
> > > > 2 matching for 2 characters is faster than checking all the allowed
> > > > symbols during session establishment.
> > >
> > > Extra CPU cycles won't make any difference here.
> > As we can have hundreds of sessions, in the end, it matters.
>
> Your rtrs_clt_open() function is far from being optimized for
> performance. It allocates memory, iterates over all paths, creates
> sysfs and kobject.
>
> So no, it doesn't matter here.
>
Let me reiterate, why do we want to further slow it down, what do you
anticipate if we only do the disallow approach
as we do it now?

Thanks!
>
> Thanks
>
> >
> > Thanks
> > >
> > > > 3 we do use hostnameA@hostnameB for production usage right now, we
> > > > don't want to break the user space.
> > >
> > > You can add "@" into the list of accepted symbols.
> > >
> > > >
> > > > I hope this makes sense to you.
> > > >
> > > > Regards!
> > > >
> > > > >
> > > > > >
> > > > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/i=
nfiniband/ulp/rtrs/rtrs-clt.c
> > > > > > index bc8824b4ee0d..15c0077dd27e 100644
> > > > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > > > @@ -2788,6 +2788,12 @@ struct rtrs_clt *rtrs_clt_open(struct rt=
rs_clt_ops *ops,
> > > > > >       struct rtrs_clt *clt;
> > > > > >       int err, i;
> > > > > >
> > > > > > +     if (strchr(sessname, '/') || strchr(sessname, '.')) {
> > > > > > +             pr_err("sessname cannot contain / and .\n");
> > > > > > +             err =3D -EINVAL;
> > > > > > +             goto out;
> > > > > > +     }
> > > > > > +
> > > > > >       clt =3D alloc_clt(sessname, paths_num, port, pdu_sz, ops-=
>priv,
> > > > > >                       ops->link_ev,
> > > > > >                       reconnect_delay_sec,
> > > > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/i=
nfiniband/ulp/rtrs/rtrs-srv.c
> > > > > > index 078a1cbac90c..7df71f8cf149 100644
> > > > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > > > @@ -803,6 +803,11 @@ static int process_info_req(struct rtrs_sr=
v_con *con,
> > > > > >               return err;
> > > > > >       }
> > > > > >
> > > > > > +     if (strchr(msg->sessname, '/') || strchr(msg->sessname, '=
.')) {
> > > > > > +             rtrs_err(s, "sessname cannot contain / and .\n");
> > > > > > +             return -EINVAL;
> > > > > > +     }
> > > > > > +
> > > > > >       if (exist_sessname(sess->srv->ctx,
> > > > > >                          msg->sessname, &sess->srv->paths_uuid)=
) {
> > > > > >               rtrs_err(s, "sessname is duplicated: %s\n", msg->=
sessname);
> > > > > > --
> > > > > > 2.25.1
> > > > > >
