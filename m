Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B6C41BF71
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Sep 2021 09:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244362AbhI2HCw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Sep 2021 03:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhI2HCu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Sep 2021 03:02:50 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E95C06161C
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 00:01:09 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y26so6478380lfa.11
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 00:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EZVV494/s562kX6/Bh7BEv81eDHLbbLoaXBSDTEu6MM=;
        b=oaHR4d2wXaAhjNqkcZ7gh6yelao+3rKw8WkOFPGQkdHJNIAC0ndhDnSN7kKfJ4gY55
         GKBh6717IWvIJEp5CrlXXtGRHyAYc0124gHiXgSWUJoeE4542dILWYCvGo0wuRYhgmTZ
         8JSa+qAfqJuF/AaLuNnj3p3tf0dfpnpFwHwnG3Cp+Soy59FP5mQuT7LgNYrvCMCjvtbW
         IXEunUStPg3dZ23j+vEgpj+GpujNFdKnUW4m2LGF6q1zWgAfwzCDipO6OiX1oea7DMWY
         Yqgua2dvQyvnkwsVFDpvk1s2QZ1onqnohroCJk545f/D3hBhLgnwhYIsMuOkfImnyUqS
         f95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EZVV494/s562kX6/Bh7BEv81eDHLbbLoaXBSDTEu6MM=;
        b=zguLNLzrAQIVpVmzzYHB1tKJAVbsX5bL525JIYrLbKr1x9aew194ZPSPfrbGyZSXGq
         jYKpGOhNiw8afnXON5iwd6GkDvvr1H8A2QIKxJniO27LcILYC+8uhxvNjrIXlxM3Akis
         lm7aFJN009tr9Jt//vJB9B7PHPntTiym62JMztv/Q5DcKLRg4Th4JcNbtPUUKv5MgeD3
         lsiPMyra6+hEYI/moYMFTnmRgewr7Kexr7yFKicwb3rOzoijMtHxzZtmduByNFslSD4j
         sgxVXRfvYAZd7MDqt8qDWP93HnhpzbbrmzHh5DVEbSF0ZzPSr4H3kpM0YNKZxz+mAx4e
         8YoQ==
X-Gm-Message-State: AOAM532psGa2YwMSvdjKScAYE49wGGkvdeW2JNJ8UrzsGQjI/GbpIa6N
        qZ0LzSgEkW765v1Nm+SdVvl0FsxccPWTNAMPX9Tce7fM51kU18q4
X-Google-Smtp-Source: ABdhPJyCwzeWrxaFRPisWwLT4JnuQJBcvxzYD82vw6eSi4cdjhegznRA4WwshlZz7r2egngF9QgDzLYZXCNXPSvXiRw=
X-Received: by 2002:a2e:5c7:: with SMTP id 190mr4223306ljf.277.1632898868064;
 Wed, 29 Sep 2021 00:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210922125333.351454-1-haris.iqbal@ionos.com>
 <20210922125333.351454-7-haris.iqbal@ionos.com> <YVG3cme0KX9CD4oh@unreal>
 <CAD+HZHWTZY=6W4MNEGwVi=e64MJtntVE1Hwm6Lt_m=UaAW2W-A@mail.gmail.com> <YVLEIVz1mCV0cZlC@unreal>
In-Reply-To: <YVLEIVz1mCV0cZlC@unreal>
From:   Jack Wang <xjtuwjp@gmail.com>
Date:   Wed, 29 Sep 2021 09:00:56 +0200
Message-ID: <CAD+HZHW5u1MiB-+C784yYXZc9Q-F0yB+1EvRKb4sAQJe4p2Yeg@mail.gmail.com>
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

Leon Romanovsky <leon@kernel.org> =E4=BA=8E2021=E5=B9=B49=E6=9C=8828=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=889:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Sep 28, 2021 at 09:08:26AM +0200, Jack Wang wrote:
> > Leon Romanovsky <leon@kernel.org> =E4=BA=8E2021=E5=B9=B49=E6=9C=8827=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=882:23=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Wed, Sep 22, 2021 at 02:53:32PM +0200, Md Haris Iqbal wrote:
> > > > Allowing these characters in sessname can lead to unexpected result=
s,
> > > > particularly because / is used as a separator between files in a pa=
th,
> > > > and . points to the current directory.
> > > >
> > > > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > > > Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
> > > > Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
> > > > ---
> > > >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ++++++
> > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 +++++
> > > >  2 files changed, 11 insertions(+)
> > >
> > > It will be safer if you check for only allowed symbols and disallow
> > > everything else. Check for: a-Z, 0-9 and "-".
> > >
> > Hi Leon,
> >
> > Thanks for your suggestions.
> > The reasons we choose to do disallow only '/' and '.':
> > 1 more flexible, most UNIX filenames allow any 8-bit set, except '/' an=
d null.
>
> So you need to add all possible protections and checks that VFS has to al=
low "random" name.
It's only about sysfs here, as we use sessname to create dir in sysfs,
and I checked the code, it allows any 8-bit set, and convert '/' to
'!', see https://elixir.bootlin.com/linux/latest/source/lib/kobject.c#L299
>
> > 2 matching for 2 characters is faster than checking all the allowed
> > symbols during session establishment.
>
> Extra CPU cycles won't make any difference here.
As we can have hundreds of sessions, in the end, it matters.

Thanks
>
> > 3 we do use hostnameA@hostnameB for production usage right now, we
> > don't want to break the user space.
>
> You can add "@" into the list of accepted symbols.
>
> >
> > I hope this makes sense to you.
> >
> > Regards!
> >
> > >
> > > >
> > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infin=
iband/ulp/rtrs/rtrs-clt.c
> > > > index bc8824b4ee0d..15c0077dd27e 100644
> > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > @@ -2788,6 +2788,12 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_c=
lt_ops *ops,
> > > >       struct rtrs_clt *clt;
> > > >       int err, i;
> > > >
> > > > +     if (strchr(sessname, '/') || strchr(sessname, '.')) {
> > > > +             pr_err("sessname cannot contain / and .\n");
> > > > +             err =3D -EINVAL;
> > > > +             goto out;
> > > > +     }
> > > > +
> > > >       clt =3D alloc_clt(sessname, paths_num, port, pdu_sz, ops->pri=
v,
> > > >                       ops->link_ev,
> > > >                       reconnect_delay_sec,
> > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infin=
iband/ulp/rtrs/rtrs-srv.c
> > > > index 078a1cbac90c..7df71f8cf149 100644
> > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > @@ -803,6 +803,11 @@ static int process_info_req(struct rtrs_srv_co=
n *con,
> > > >               return err;
> > > >       }
> > > >
> > > > +     if (strchr(msg->sessname, '/') || strchr(msg->sessname, '.'))=
 {
> > > > +             rtrs_err(s, "sessname cannot contain / and .\n");
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > >       if (exist_sessname(sess->srv->ctx,
> > > >                          msg->sessname, &sess->srv->paths_uuid)) {
> > > >               rtrs_err(s, "sessname is duplicated: %s\n", msg->sess=
name);
> > > > --
> > > > 2.25.1
> > > >
