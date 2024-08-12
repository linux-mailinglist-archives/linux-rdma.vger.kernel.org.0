Return-Path: <linux-rdma+bounces-4331-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6878A94EBAB
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 13:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8432825C6
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 11:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1F1171099;
	Mon, 12 Aug 2024 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="NRGnpszs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E65043AA1
	for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 11:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723461447; cv=none; b=Sqer9Mlg2xMWrhCPaL2gjvdZmv1RltzTT3C+EA53vMh48htGCXec22sdQFkGapOkqLsy9aPAGW9iRhdDzOOAN7+6ZE+GFch4v4L5/rjDN0FQSyXD3oyB1keqn6zGl9S2jMuth/VUSsK/e3vKNs3jfB17zwdF+R2kFmjrDmbp7uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723461447; c=relaxed/simple;
	bh=yDKIgRStq2Rcdku4PtzqwOqg+iQp2kefnDUgXmIiA6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlm0nTQQTfplJQgLY2VW/uvIRpbxXBN9jeQo30hCNDDbqXMgFD1j6FpAGp9iDVXnpw/L9nx4+T8zPhczl+T8N775orQatJOewd8306rj/oejfZhffcEsgtoB/mW6QLx52gq9B0NYJrjGcnEkIIX6GWpq6RgrutDU7lmn8oFkF3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=NRGnpszs; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f1a7faa4d5so30499281fa.3
        for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 04:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1723461443; x=1724066243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toMhSi95OLw4bBWS/hnhIgPiuYtKi/9Yj4dNYH4LWbo=;
        b=NRGnpszsC8+svTAbXwgtlzsRzNip0AAGAAJ4an5fWhWpgEdGVYzZiFq6QMsu0PdQiN
         RoBFbJ7W8DyBxmaopQfhvmBEnEF7hhc5kVZ1FGl9idRQLCyiUlzNhvCLt8NfvdeufDXm
         WaCB+PFpNuws9bhkoLjQXYpOk7Txu9vN0AFdQ+boB0Qsnce7RARqfsCOjpjkXvGOj4B6
         it5WkFoQNm2WV3QhFMtI8Ax9daHW8YK6ZAG9kMvf96pmyS8s4wbRTGahZeLWkq0k4MF4
         6jbbqFlPChNtPMGRsvoPYJk9Dat5qkkaKnvp9rlFthheLu9WWcotoPnI2OBTVNHH8Fl3
         TLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723461443; x=1724066243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toMhSi95OLw4bBWS/hnhIgPiuYtKi/9Yj4dNYH4LWbo=;
        b=HYNwlgA1eyEEWBtK0ZmU7oPNO8RaFIRa3dmlNJYqWqzQ4ml3wb0c7QHJjXNNxfwmt0
         G4OcWl4OdtHcEdNVAwQKdcu306K9u3SLjniP5UNvqTch1aEQ9a8H85wQccZ/JYQaK92i
         NddbTB75bKXX/8dkWn5tMcv8b1BbpbYM5BszcQyLLEXxrqrWh0ggGWp46bf1neH5ZdNm
         PEYoYBsTfAVIKj+RibUGpkM3Ot4vWbYJQ2qdVSJ6X60nawfqjcx6YlYYpdp7YZdSX+Cu
         1cF2+Sof5OmjdB6RL8vRdeDy1G0KtwQTSK8ll8afO6COW3vMBUCWjAv+w+UzKZ2ocf76
         xl1w==
X-Gm-Message-State: AOJu0YzO0T8prHMRm/N6pzOIO55mYXBX3Mm47uELYKzsTgXlFoq1qtqB
	ZrMtd4LcHWLjnb2yjvyK2L87LNmsJgsAsWpv6g1HRi5M4ZUBXinUsacAZ46EnUZqY+1Uz1ABj6P
	AxJ5y5oDYsFkQd5UKM7V8NERbBaad5lxsM8QjBw==
X-Google-Smtp-Source: AGHT+IEV0m3LtIY9hphERlpbYafPDSs5wvmu9pHPPvl8oghuzAlOPb2YIyRcddBYb9k+NVu29iZFENMDlIlJ1Rahosw=
X-Received: by 2002:a2e:b8c1:0:b0:2ee:974c:596f with SMTP id
 38308e7fff4ca-2f1a6c68b39mr66823521fa.28.1723461442880; Mon, 12 Aug 2024
 04:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809131538.944907-1-haris.iqbal@ionos.com>
 <20240809131538.944907-2-haris.iqbal@ionos.com> <20240811083830.GB5925@unreal>
 <CAJpMwyjksJakyZVvf_jWwrnvbpV_T=jjAKgXG5k0ZCGyoZx_Rg@mail.gmail.com>
 <20240812103433.GC12060@unreal> <CAJpMwyjgNnCb4D8D_hHm5sQAzwLurPig=MzLdNtScVU2CzvMQA@mail.gmail.com>
 <20240812105942.GD12060@unreal>
In-Reply-To: <20240812105942.GD12060@unreal>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Mon, 12 Aug 2024 13:17:11 +0200
Message-ID: <CAJpMwyh7ytEawa=Yzg8CM=QZROvoBY70unhFvJdbAW9BU+xoUg@mail.gmail.com>
Subject: Re: [PATCH for-next 01/13] RDMA/rtrs-srv: Make rtrs_srv_open fail if
 its a second call
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org, jgg@ziepe.ca, 
	jinpu.wang@ionos.com, Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 12:59=E2=80=AFPM Leon Romanovsky <leon@kernel.org> =
wrote:
>
> On Mon, Aug 12, 2024 at 12:39:06PM +0200, Haris Iqbal wrote:
> > On Mon, Aug 12, 2024 at 12:34=E2=80=AFPM Leon Romanovsky <leon@kernel.o=
rg> wrote:
> > >
> > > On Mon, Aug 12, 2024 at 12:16:19PM +0200, Haris Iqbal wrote:
> > > > On Sun, Aug 11, 2024 at 10:38=E2=80=AFAM Leon Romanovsky <leon@kern=
el.org> wrote:
> > > > >
> > > > > On Fri, Aug 09, 2024 at 03:15:26PM +0200, Md Haris Iqbal wrote:
> > > > > > Do not allow opening RTRS server if it is already in use and pr=
int
> > > > > > proper error message.
> > > > >
> > > > > 1. How is it even possible? I see only one call to rtrs_srv_open(=
) and
> > > > > it is happening when the driver is loaded.
> > > >
> > > > rtrs_srv_open() is NOT called during RTRS driver load. It is called
> > > > during RNBD driver load, which is a client which uses RTRS.
> > > > RTRS server currently works with only a single client. Hence if, wh=
ile
> > > > in use by RNBD, another driver wants to use RTRS and calls
> > > > rtrs_srv_open(), it should fail.
> > >
> > > =E2=9E=9C  kernel git:(rdma-next) =E2=9C=97 git grep rtrs_srv_open
> > > drivers/block/rnbd/rnbd-srv.c:  rtrs_ctx =3D rtrs_srv_open(&rtrs_ops,=
 port_nr); <---- SINGLE CALL
> > > drivers/block/rnbd/rnbd-srv.c:          pr_err("rtrs_srv_open(), err:=
 %pe\n", rtrs_ctx);
> > > drivers/infiniband/ulp/rtrs/rtrs-srv.c: * rtrs_srv_open() - open RTRS=
 server context
> > > drivers/infiniband/ulp/rtrs/rtrs-srv.c:struct rtrs_srv_ctx *rtrs_srv_=
open(struct rtrs_srv_ops *ops, u16 port)
> > > drivers/infiniband/ulp/rtrs/rtrs-srv.c:EXPORT_SYMBOL(rtrs_srv_open);
> > > drivers/infiniband/ulp/rtrs/rtrs.h:struct rtrs_srv_ctx *rtrs_srv_open=
(struct rtrs_srv_ops *ops, u16 port);
> > >
> > >   807 static int __init rnbd_srv_init_module(void)
> > >   808 {
> > >   809         int err =3D 0;
> > >   810
> > >   811         BUILD_BUG_ON(sizeof(struct rnbd_msg_hdr) !=3D 4);
> > >   812         BUILD_BUG_ON(sizeof(struct rnbd_msg_sess_info) !=3D 36)=
;
> > >   813         BUILD_BUG_ON(sizeof(struct rnbd_msg_sess_info_rsp) !=3D=
 36);
> > >   814         BUILD_BUG_ON(sizeof(struct rnbd_msg_open) !=3D 264);
> > >   815         BUILD_BUG_ON(sizeof(struct rnbd_msg_close) !=3D 8);
> > >   816         BUILD_BUG_ON(sizeof(struct rnbd_msg_open_rsp) !=3D 56);
> > >   817         rtrs_ops =3D (struct rtrs_srv_ops) {
> > >   818                 .rdma_ev =3D rnbd_srv_rdma_ev,
> > >   819                 .link_ev =3D rnbd_srv_link_ev,
> > >   820         };
> > >   821         rtrs_ctx =3D rtrs_srv_open(&rtrs_ops, port_nr);
> > >   822         if (IS_ERR(rtrs_ctx)) {
> > >   823                 pr_err("rtrs_srv_open(), err: %pe\n", rtrs_ctx)=
;   <---- ALREADY PRINTED ERROR
> > >   824                 return PTR_ERR(rtrs_ctx);
> > >   825         }
> > >
> > >   ...
> > >
> > >   843 module_init(rnbd_srv_init_module); <---- SINGLE CALL
> > >
> > > Upstream code has only on RNBD and one RTRS.
> >
> > Yes. But they are different drivers. RTRS as a stand-alone ULP does
> > not know about RNBD or for that matter any other client driver, which
> > may use it, either out of tree or in the future. If RTRS can serve
> > only a single client, then it should should have protection for
> > multiple calls to *_open().
>
> For now, there is only one upstream client and server.

In my understanding, its the general rule of abstraction that this
type of limitation is handled where it exists.

>
> I want to remind you that during initial submission of RTR code, the
> feedback was that this ULP shouldn't exist in first place and right
> thing to do it is to use NVMe over fabrics.
>
> So chances that we will have real out-of-tree client are very low.

One reason for us to write this patch is that we are working on
another client which uses RTRS. We could have kept this change
out-of-tree, but frankly, it felt right to add this protection.

>
> Thanks
>
> >
> > >
> > > Thanks
> > >
> > >
> > > >
> > > > > 2. You already print an error message, why do you need to add ano=
ther
> > > > > one?
> > > >
> > > > This patch adds only a single error print, in function
> > > > rtrs_srv_open(). And it has not other print message. Am I missing
> > > > something?
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > > > > > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > > > > Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
> > > > > > ---
> > > > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 27 ++++++++++++++++++=
+++++---
> > > > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.h |  1 +
> > > > > >  2 files changed, 25 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/i=
nfiniband/ulp/rtrs/rtrs-srv.c
> > > > > > index 1d33efb8fb03..fb67b58a7f62 100644
> > > > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > > > @@ -2174,9 +2174,18 @@ struct rtrs_srv_ctx *rtrs_srv_open(struc=
t rtrs_srv_ops *ops, u16 port)
> > > > > >       struct rtrs_srv_ctx *ctx;
> > > > > >       int err;
> > > > > >
> > > > > > +     mutex_lock(&ib_ctx.rtrs_srv_ib_mutex);
> > > > > > +     if (ib_ctx.srv_ctx) {
> > > > > > +             pr_err("%s: Already in use.\n", __func__);
> > > > > > +             ctx =3D ERR_PTR(-EEXIST);
> > > > > > +             goto out;
> > > > > > +     }
> > > > > > +
> > > > > >       ctx =3D alloc_srv_ctx(ops);
> > > > > > -     if (!ctx)
> > > > > > -             return ERR_PTR(-ENOMEM);
> > > > > > +     if (!ctx) {
> > > > > > +             ctx =3D ERR_PTR(-ENOMEM);
> > > > > > +             goto out;
> > > > > > +     }
> > > > > >
> > > > > >       mutex_init(&ib_ctx.ib_dev_mutex);
> > > > > >       ib_ctx.srv_ctx =3D ctx;
> > > > > > @@ -2185,9 +2194,11 @@ struct rtrs_srv_ctx *rtrs_srv_open(struc=
t rtrs_srv_ops *ops, u16 port)
> > > > > >       err =3D ib_register_client(&rtrs_srv_client);
> > > > > >       if (err) {
> > > > > >               free_srv_ctx(ctx);
> > > > > > -             return ERR_PTR(err);
> > > > > > +             ctx =3D ERR_PTR(err);
> > > > > >       }
> > > > > >
> > > > > > +out:
> > > > > > +     mutex_unlock(&ib_ctx.rtrs_srv_ib_mutex);
> > > > > >       return ctx;
> > > > > >  }
> > > > > >  EXPORT_SYMBOL(rtrs_srv_open);
> > > > > > @@ -2221,10 +2232,16 @@ static void close_ctx(struct rtrs_srv_c=
tx *ctx)
> > > > > >   */
> > > > > >  void rtrs_srv_close(struct rtrs_srv_ctx *ctx)
> > > > > >  {
> > > > > > +     mutex_lock(&ib_ctx.rtrs_srv_ib_mutex);
> > > > > > +     WARN_ON(ib_ctx.srv_ctx !=3D ctx);
> > > > > > +
> > > > > >       ib_unregister_client(&rtrs_srv_client);
> > > > > >       mutex_destroy(&ib_ctx.ib_dev_mutex);
> > > > > >       close_ctx(ctx);
> > > > > >       free_srv_ctx(ctx);
> > > > > > +
> > > > > > +     ib_ctx.srv_ctx =3D NULL;
> > > > > > +     mutex_unlock(&ib_ctx.rtrs_srv_ib_mutex);
> > > > > >  }
> > > > > >  EXPORT_SYMBOL(rtrs_srv_close);
> > > > > >
> > > > > > @@ -2282,6 +2299,9 @@ static int __init rtrs_server_init(void)
> > > > > >               goto out_dev_class;
> > > > > >       }
> > > > > >
> > > > > > +     mutex_init(&ib_ctx.rtrs_srv_ib_mutex);
> > > > > > +     ib_ctx.srv_ctx =3D NULL;
> > > > > > +
> > > > > >       return 0;
> > > > > >
> > > > > >  out_dev_class:
> > > > > > @@ -2292,6 +2312,7 @@ static int __init rtrs_server_init(void)
> > > > > >
> > > > > >  static void __exit rtrs_server_exit(void)
> > > > > >  {
> > > > > > +     mutex_destroy(&ib_ctx.rtrs_srv_ib_mutex);
> > > > > >       destroy_workqueue(rtrs_wq);
> > > > > >       class_unregister(&rtrs_dev_class);
> > > > > >       rtrs_rdma_dev_pd_deinit(&dev_pd);
> > > > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/i=
nfiniband/ulp/rtrs/rtrs-srv.h
> > > > > > index 5e325b82ff33..4924dde0a708 100644
> > > > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > > > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > > > > > @@ -127,6 +127,7 @@ struct rtrs_srv_ib_ctx {
> > > > > >       u16                     port;
> > > > > >       struct mutex            ib_dev_mutex;
> > > > > >       int                     ib_dev_count;
> > > > > > +     struct mutex            rtrs_srv_ib_mutex;
> > > > > >  };
> > > > > >
> > > > > >  extern const struct class rtrs_dev_class;
> > > > > > --
> > > > > > 2.25.1
> > > > > >

