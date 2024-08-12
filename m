Return-Path: <linux-rdma+bounces-4326-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D74A94EB4E
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 12:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036812826F4
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 10:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C54916F909;
	Mon, 12 Aug 2024 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="J3EMZMGQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1671216F837
	for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723459162; cv=none; b=GXDMpBK7dz98L63pEHRH5LSoTVu5mb45WFW19lfjkB/UJciLqbp8DRWZ7ovgI1YOlCYBD/aTCsNvWKmkGUdUxe+haXsoTB2n9uld/8EeBihx5jEFpUP2dvCPoplbZq1Y9wtQ6DFQGjhzSjmOfqPyb0NtqpDnYrb01ytu3J1z7FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723459162; c=relaxed/simple;
	bh=1y5PCAhEkoF0RjYS1kJt266s63DhRWrDpEKykkltIi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQrHt0x3ShU4FYAIvW6kOacDssZ9yXXXshy8NoDZ4o5maRh+2w286El1Jrl/e650EE1K5KxyubyUjqVGw09vYdS57CaAKJnmt1vjbCNyEq6tRS6fG2QyuSc/86zQqQQX5fhPyMrDvMKWRSzNXwkZrPhKeUNfsEEyiJCCINn6SRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=J3EMZMGQ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so66469931fa.1
        for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 03:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1723459158; x=1724063958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnMucFnkUeXrBnB5w6Zx0lWiMTeO5C8fDSDmNrEFFsU=;
        b=J3EMZMGQYZWSQ9Kvg7eJwxV5CDQJFpaixo+0S5VTM/SogyUzq2+zDTnRXLEsL5qQ9o
         ogAN8lTmYxeKV5PpECXBdE6w6e6dWa9GXMg25vMS9ZXcovfgaxJSDXWhS3nYtoaAEjNu
         RzdkYetiPXYIh6qXVWQ0txgFv+c7vSUhQwbe9yU9vhKKN4j9LDFZ0lxnMt7nqo7RNxN/
         MQlCuvJTdy5m+LpWD/MoNf855wNWTXw2Rm5dIfPddP/ODq9CL7BAyUdX9XqtXH3KQjfy
         hChy0O9qkDfy7s/GH0fG1jQliB7/A8pt20CyCuDMEiwLl+IMsx6PdB/Nrhqojg8+JMjY
         YJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723459158; x=1724063958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnMucFnkUeXrBnB5w6Zx0lWiMTeO5C8fDSDmNrEFFsU=;
        b=kNN8r+p2O5nzqU0+OZ/SaM8WLtK2hZRd+gX+qCrGwBWMirwo96bBIwqxfgc3QD+G1R
         cexTEFezSAMHDrRJoYqEvxzLj6NINT1JEpf5REfWqraS0QFrFDSBt11vtWr6nXOybT3P
         PuboExnchUijzv7CPwq1lcg7mHKyK7EqkY0aTdFC+7gkTdZNp3JaWJD48Z4Z/iFMgpnh
         f7HjFbTOZfpytbHg7RvqcJsEDcZBZyKL4UwIWeUCKMcP/reQyRjCOcXSrjLbbf+XIMfx
         Vf6442OFqs9SHFAqRCbnJehOQQFjsNsVh8NU3vHJvBvALEWWE7IufKiixHZX31vVV/15
         ezLA==
X-Gm-Message-State: AOJu0YzIbmHBaJYP2ctnObt5ollTrIMngORUV26wOYthXT5A03ePNM5/
	N5ZelkCa1nvpi/2lROn0KUFvW8e+JfB+62Mn3S1i4CcoRFPYQJKviDhZzOuS7ujLgBN4Z0LbKQU
	cyQkJToGSiaJ+u8sNGCGzU1egS1L4PHdEW/DggA==
X-Google-Smtp-Source: AGHT+IGkbSBb8BBvcw/4WHAUuUosl+0+M7UeZwfCnRJAGXJHSuod41NPKuswDJnXOQRBOj8B1FhsBMKPGOoX9WceSW0=
X-Received: by 2002:a2e:809:0:b0:2ef:1b1b:7f42 with SMTP id
 38308e7fff4ca-2f1a6cdcf3bmr77260241fa.36.1723459157902; Mon, 12 Aug 2024
 03:39:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809131538.944907-1-haris.iqbal@ionos.com>
 <20240809131538.944907-2-haris.iqbal@ionos.com> <20240811083830.GB5925@unreal>
 <CAJpMwyjksJakyZVvf_jWwrnvbpV_T=jjAKgXG5k0ZCGyoZx_Rg@mail.gmail.com> <20240812103433.GC12060@unreal>
In-Reply-To: <20240812103433.GC12060@unreal>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Mon, 12 Aug 2024 12:39:06 +0200
Message-ID: <CAJpMwyjgNnCb4D8D_hHm5sQAzwLurPig=MzLdNtScVU2CzvMQA@mail.gmail.com>
Subject: Re: [PATCH for-next 01/13] RDMA/rtrs-srv: Make rtrs_srv_open fail if
 its a second call
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org, jgg@ziepe.ca, 
	jinpu.wang@ionos.com, Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 12:34=E2=80=AFPM Leon Romanovsky <leon@kernel.org> =
wrote:
>
> On Mon, Aug 12, 2024 at 12:16:19PM +0200, Haris Iqbal wrote:
> > On Sun, Aug 11, 2024 at 10:38=E2=80=AFAM Leon Romanovsky <leon@kernel.o=
rg> wrote:
> > >
> > > On Fri, Aug 09, 2024 at 03:15:26PM +0200, Md Haris Iqbal wrote:
> > > > Do not allow opening RTRS server if it is already in use and print
> > > > proper error message.
> > >
> > > 1. How is it even possible? I see only one call to rtrs_srv_open() an=
d
> > > it is happening when the driver is loaded.
> >
> > rtrs_srv_open() is NOT called during RTRS driver load. It is called
> > during RNBD driver load, which is a client which uses RTRS.
> > RTRS server currently works with only a single client. Hence if, while
> > in use by RNBD, another driver wants to use RTRS and calls
> > rtrs_srv_open(), it should fail.
>
> =E2=9E=9C  kernel git:(rdma-next) =E2=9C=97 git grep rtrs_srv_open
> drivers/block/rnbd/rnbd-srv.c:  rtrs_ctx =3D rtrs_srv_open(&rtrs_ops, por=
t_nr); <---- SINGLE CALL
> drivers/block/rnbd/rnbd-srv.c:          pr_err("rtrs_srv_open(), err: %pe=
\n", rtrs_ctx);
> drivers/infiniband/ulp/rtrs/rtrs-srv.c: * rtrs_srv_open() - open RTRS ser=
ver context
> drivers/infiniband/ulp/rtrs/rtrs-srv.c:struct rtrs_srv_ctx *rtrs_srv_open=
(struct rtrs_srv_ops *ops, u16 port)
> drivers/infiniband/ulp/rtrs/rtrs-srv.c:EXPORT_SYMBOL(rtrs_srv_open);
> drivers/infiniband/ulp/rtrs/rtrs.h:struct rtrs_srv_ctx *rtrs_srv_open(str=
uct rtrs_srv_ops *ops, u16 port);
>
>   807 static int __init rnbd_srv_init_module(void)
>   808 {
>   809         int err =3D 0;
>   810
>   811         BUILD_BUG_ON(sizeof(struct rnbd_msg_hdr) !=3D 4);
>   812         BUILD_BUG_ON(sizeof(struct rnbd_msg_sess_info) !=3D 36);
>   813         BUILD_BUG_ON(sizeof(struct rnbd_msg_sess_info_rsp) !=3D 36)=
;
>   814         BUILD_BUG_ON(sizeof(struct rnbd_msg_open) !=3D 264);
>   815         BUILD_BUG_ON(sizeof(struct rnbd_msg_close) !=3D 8);
>   816         BUILD_BUG_ON(sizeof(struct rnbd_msg_open_rsp) !=3D 56);
>   817         rtrs_ops =3D (struct rtrs_srv_ops) {
>   818                 .rdma_ev =3D rnbd_srv_rdma_ev,
>   819                 .link_ev =3D rnbd_srv_link_ev,
>   820         };
>   821         rtrs_ctx =3D rtrs_srv_open(&rtrs_ops, port_nr);
>   822         if (IS_ERR(rtrs_ctx)) {
>   823                 pr_err("rtrs_srv_open(), err: %pe\n", rtrs_ctx);   =
<---- ALREADY PRINTED ERROR
>   824                 return PTR_ERR(rtrs_ctx);
>   825         }
>
>   ...
>
>   843 module_init(rnbd_srv_init_module); <---- SINGLE CALL
>
> Upstream code has only on RNBD and one RTRS.

Yes. But they are different drivers. RTRS as a stand-alone ULP does
not know about RNBD or for that matter any other client driver, which
may use it, either out of tree or in the future. If RTRS can serve
only a single client, then it should should have protection for
multiple calls to *_open().

>
> Thanks
>
>
> >
> > > 2. You already print an error message, why do you need to add another
> > > one?
> >
> > This patch adds only a single error print, in function
> > rtrs_srv_open(). And it has not other print message. Am I missing
> > something?
> >
> > >
> > > Thanks
> > >
> > > >
> > > > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > > > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > > Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
> > > > ---
> > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 27 ++++++++++++++++++++++=
+---
> > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.h |  1 +
> > > >  2 files changed, 25 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infin=
iband/ulp/rtrs/rtrs-srv.c
> > > > index 1d33efb8fb03..fb67b58a7f62 100644
> > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > @@ -2174,9 +2174,18 @@ struct rtrs_srv_ctx *rtrs_srv_open(struct rt=
rs_srv_ops *ops, u16 port)
> > > >       struct rtrs_srv_ctx *ctx;
> > > >       int err;
> > > >
> > > > +     mutex_lock(&ib_ctx.rtrs_srv_ib_mutex);
> > > > +     if (ib_ctx.srv_ctx) {
> > > > +             pr_err("%s: Already in use.\n", __func__);
> > > > +             ctx =3D ERR_PTR(-EEXIST);
> > > > +             goto out;
> > > > +     }
> > > > +
> > > >       ctx =3D alloc_srv_ctx(ops);
> > > > -     if (!ctx)
> > > > -             return ERR_PTR(-ENOMEM);
> > > > +     if (!ctx) {
> > > > +             ctx =3D ERR_PTR(-ENOMEM);
> > > > +             goto out;
> > > > +     }
> > > >
> > > >       mutex_init(&ib_ctx.ib_dev_mutex);
> > > >       ib_ctx.srv_ctx =3D ctx;
> > > > @@ -2185,9 +2194,11 @@ struct rtrs_srv_ctx *rtrs_srv_open(struct rt=
rs_srv_ops *ops, u16 port)
> > > >       err =3D ib_register_client(&rtrs_srv_client);
> > > >       if (err) {
> > > >               free_srv_ctx(ctx);
> > > > -             return ERR_PTR(err);
> > > > +             ctx =3D ERR_PTR(err);
> > > >       }
> > > >
> > > > +out:
> > > > +     mutex_unlock(&ib_ctx.rtrs_srv_ib_mutex);
> > > >       return ctx;
> > > >  }
> > > >  EXPORT_SYMBOL(rtrs_srv_open);
> > > > @@ -2221,10 +2232,16 @@ static void close_ctx(struct rtrs_srv_ctx *=
ctx)
> > > >   */
> > > >  void rtrs_srv_close(struct rtrs_srv_ctx *ctx)
> > > >  {
> > > > +     mutex_lock(&ib_ctx.rtrs_srv_ib_mutex);
> > > > +     WARN_ON(ib_ctx.srv_ctx !=3D ctx);
> > > > +
> > > >       ib_unregister_client(&rtrs_srv_client);
> > > >       mutex_destroy(&ib_ctx.ib_dev_mutex);
> > > >       close_ctx(ctx);
> > > >       free_srv_ctx(ctx);
> > > > +
> > > > +     ib_ctx.srv_ctx =3D NULL;
> > > > +     mutex_unlock(&ib_ctx.rtrs_srv_ib_mutex);
> > > >  }
> > > >  EXPORT_SYMBOL(rtrs_srv_close);
> > > >
> > > > @@ -2282,6 +2299,9 @@ static int __init rtrs_server_init(void)
> > > >               goto out_dev_class;
> > > >       }
> > > >
> > > > +     mutex_init(&ib_ctx.rtrs_srv_ib_mutex);
> > > > +     ib_ctx.srv_ctx =3D NULL;
> > > > +
> > > >       return 0;
> > > >
> > > >  out_dev_class:
> > > > @@ -2292,6 +2312,7 @@ static int __init rtrs_server_init(void)
> > > >
> > > >  static void __exit rtrs_server_exit(void)
> > > >  {
> > > > +     mutex_destroy(&ib_ctx.rtrs_srv_ib_mutex);
> > > >       destroy_workqueue(rtrs_wq);
> > > >       class_unregister(&rtrs_dev_class);
> > > >       rtrs_rdma_dev_pd_deinit(&dev_pd);
> > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infin=
iband/ulp/rtrs/rtrs-srv.h
> > > > index 5e325b82ff33..4924dde0a708 100644
> > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > > > @@ -127,6 +127,7 @@ struct rtrs_srv_ib_ctx {
> > > >       u16                     port;
> > > >       struct mutex            ib_dev_mutex;
> > > >       int                     ib_dev_count;
> > > > +     struct mutex            rtrs_srv_ib_mutex;
> > > >  };
> > > >
> > > >  extern const struct class rtrs_dev_class;
> > > > --
> > > > 2.25.1
> > > >

