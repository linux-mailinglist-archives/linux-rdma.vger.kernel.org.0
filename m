Return-Path: <linux-rdma+bounces-4324-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 107EE94EA95
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 12:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54122B2092E
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 10:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4487C16C440;
	Mon, 12 Aug 2024 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="MSDAcZqQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122FE33C7
	for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723457796; cv=none; b=qG9iQ2bw2+jHsNTICGosIMs7AdWH8wf/kMozF//aU9oyhghAvXJAF/O5g1vEddqwXYYcxsJ4m3Ra7BRmpu8azzxBwOuc1dfUxmn87ZpMnJEFmjTW4jyJPfN6Iwi+HEVVpglspL76ZMbxUOQ5p/s5F7wh04MD/jlCGPRCuy4BZvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723457796; c=relaxed/simple;
	bh=GiT8RDYEbiUcF7LCI2JwOU+GvoS1HTgDcYWcQQmVMK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQODwdBsvlIMfdZ9qiGNBuLSjQIBCA5AXTFuTw4O3oXSAD5vMu/4cCYuIPVObHf0WMIhDSg1ZkVDZ4K3Yk8eelX8xv59kVeWaOU/a/kOon1qDBoUez3NWpjmBZ/rkCtJv4gAUdeiu0Q19/97LZJ8md5ufHQqgHH6iliHNjNquDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=MSDAcZqQ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ef2cb7d562so41456561fa.3
        for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 03:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1723457791; x=1724062591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAHQCroOwgrlg78Fht1qN9UEcBxxThURFhs1Vzwg1MM=;
        b=MSDAcZqQCyz8MIi5pINSjuQuIAH0rZhDRPW3B157YniLFbcWA4ae5llLn+hxwH8SBc
         FdWtBgZjpPo2Qw62DZZCOPdi4zGYQ2PUw3UEx3ZSC2vOfxY0yXRyKX5JBW1nvjDaexQm
         F2n153zA577CJt0gQRuU00/GLsb7D0sbbIKESIO9mYlwMLeu6nUfcp93UlBPEgy1x/wf
         JMUKHq0/Yg0JL4SZLfGra5ySN5QgLuNOdQV5YbQYPpp8khsbtzL0b8wnIIOqmjzEF75+
         At9xzVYkvaN91nvBEBDX2xvZiAWhGnSMmnzf5mlzpmsWUlxZ/oM74VcBYqyoyzRGkNtT
         oD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723457791; x=1724062591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAHQCroOwgrlg78Fht1qN9UEcBxxThURFhs1Vzwg1MM=;
        b=vjY5fyQep/Jgr7B5e0cNYs7Z1Jj2xA7/63S5C3quAHRgFVTRhgFkWSz3iA5plYjqaL
         lvVskiHF8pnj3/AKaPWQtGWis6nz0l/GIGXc5TLr4iS/cBlCZaQDn9VOz+Olb5FSYonf
         KklYyoQtdp2IvIO0SPMGzdbtLyRnKSGm44z+2MUfaj7KXQ3sJXYWswrA3i0wW/OB+AMF
         osddbCfryl1iz+lxYleCbcxdOym3Bp2EPJTch2bJATf6c5YD9GE38kdkA2aNQGCI5Cwe
         RfmwQVq7b9lGOEZ6lVtx4RFYqA4R56JiMheeyvvS17E/L7uwwXY+T9OISW7U6GaUppYY
         kJRg==
X-Gm-Message-State: AOJu0YzMg9tSMcGskEkl2Lw619ncP9D7bDttKNknz+SamDD2DRTExmH4
	5i7TAFD1Nr0IH4QCxgN/plcDMLkae4hWzdRAMGBqQRwy477eRyKICr3jpps3GA5QpGGVZmHAH6L
	LLi6Y6+btiuf7nx/U4WdPxqiiTR5gdiAthiUIu1LDrh8s+axs6e30gw==
X-Google-Smtp-Source: AGHT+IHI+tuAGPGoukf8qAF6Ntz0B0I896dVsa+vZBU7jI2jkNuqRU0TWeG7pNvLETPr/sWWYWUNHyYVfLJJP3r6YFM=
X-Received: by 2002:a2e:be85:0:b0:2ef:296d:1dd5 with SMTP id
 38308e7fff4ca-2f1a6907443mr86438131fa.0.1723457790922; Mon, 12 Aug 2024
 03:16:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809131538.944907-1-haris.iqbal@ionos.com>
 <20240809131538.944907-2-haris.iqbal@ionos.com> <20240811083830.GB5925@unreal>
In-Reply-To: <20240811083830.GB5925@unreal>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Mon, 12 Aug 2024 12:16:19 +0200
Message-ID: <CAJpMwyjksJakyZVvf_jWwrnvbpV_T=jjAKgXG5k0ZCGyoZx_Rg@mail.gmail.com>
Subject: Re: [PATCH for-next 01/13] RDMA/rtrs-srv: Make rtrs_srv_open fail if
 its a second call
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org, jgg@ziepe.ca, 
	jinpu.wang@ionos.com, Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 10:38=E2=80=AFAM Leon Romanovsky <leon@kernel.org> =
wrote:
>
> On Fri, Aug 09, 2024 at 03:15:26PM +0200, Md Haris Iqbal wrote:
> > Do not allow opening RTRS server if it is already in use and print
> > proper error message.
>
> 1. How is it even possible? I see only one call to rtrs_srv_open() and
> it is happening when the driver is loaded.

rtrs_srv_open() is NOT called during RTRS driver load. It is called
during RNBD driver load, which is a client which uses RTRS.
RTRS server currently works with only a single client. Hence if, while
in use by RNBD, another driver wants to use RTRS and calls
rtrs_srv_open(), it should fail.

> 2. You already print an error message, why do you need to add another
> one?

This patch adds only a single error print, in function
rtrs_srv_open(). And it has not other print message. Am I missing
something?

>
> Thanks
>
> >
> > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 27 +++++++++++++++++++++++---
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.h |  1 +
> >  2 files changed, 25 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniban=
d/ulp/rtrs/rtrs-srv.c
> > index 1d33efb8fb03..fb67b58a7f62 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > @@ -2174,9 +2174,18 @@ struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_s=
rv_ops *ops, u16 port)
> >       struct rtrs_srv_ctx *ctx;
> >       int err;
> >
> > +     mutex_lock(&ib_ctx.rtrs_srv_ib_mutex);
> > +     if (ib_ctx.srv_ctx) {
> > +             pr_err("%s: Already in use.\n", __func__);
> > +             ctx =3D ERR_PTR(-EEXIST);
> > +             goto out;
> > +     }
> > +
> >       ctx =3D alloc_srv_ctx(ops);
> > -     if (!ctx)
> > -             return ERR_PTR(-ENOMEM);
> > +     if (!ctx) {
> > +             ctx =3D ERR_PTR(-ENOMEM);
> > +             goto out;
> > +     }
> >
> >       mutex_init(&ib_ctx.ib_dev_mutex);
> >       ib_ctx.srv_ctx =3D ctx;
> > @@ -2185,9 +2194,11 @@ struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_s=
rv_ops *ops, u16 port)
> >       err =3D ib_register_client(&rtrs_srv_client);
> >       if (err) {
> >               free_srv_ctx(ctx);
> > -             return ERR_PTR(err);
> > +             ctx =3D ERR_PTR(err);
> >       }
> >
> > +out:
> > +     mutex_unlock(&ib_ctx.rtrs_srv_ib_mutex);
> >       return ctx;
> >  }
> >  EXPORT_SYMBOL(rtrs_srv_open);
> > @@ -2221,10 +2232,16 @@ static void close_ctx(struct rtrs_srv_ctx *ctx)
> >   */
> >  void rtrs_srv_close(struct rtrs_srv_ctx *ctx)
> >  {
> > +     mutex_lock(&ib_ctx.rtrs_srv_ib_mutex);
> > +     WARN_ON(ib_ctx.srv_ctx !=3D ctx);
> > +
> >       ib_unregister_client(&rtrs_srv_client);
> >       mutex_destroy(&ib_ctx.ib_dev_mutex);
> >       close_ctx(ctx);
> >       free_srv_ctx(ctx);
> > +
> > +     ib_ctx.srv_ctx =3D NULL;
> > +     mutex_unlock(&ib_ctx.rtrs_srv_ib_mutex);
> >  }
> >  EXPORT_SYMBOL(rtrs_srv_close);
> >
> > @@ -2282,6 +2299,9 @@ static int __init rtrs_server_init(void)
> >               goto out_dev_class;
> >       }
> >
> > +     mutex_init(&ib_ctx.rtrs_srv_ib_mutex);
> > +     ib_ctx.srv_ctx =3D NULL;
> > +
> >       return 0;
> >
> >  out_dev_class:
> > @@ -2292,6 +2312,7 @@ static int __init rtrs_server_init(void)
> >
> >  static void __exit rtrs_server_exit(void)
> >  {
> > +     mutex_destroy(&ib_ctx.rtrs_srv_ib_mutex);
> >       destroy_workqueue(rtrs_wq);
> >       class_unregister(&rtrs_dev_class);
> >       rtrs_rdma_dev_pd_deinit(&dev_pd);
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniban=
d/ulp/rtrs/rtrs-srv.h
> > index 5e325b82ff33..4924dde0a708 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > @@ -127,6 +127,7 @@ struct rtrs_srv_ib_ctx {
> >       u16                     port;
> >       struct mutex            ib_dev_mutex;
> >       int                     ib_dev_count;
> > +     struct mutex            rtrs_srv_ib_mutex;
> >  };
> >
> >  extern const struct class rtrs_dev_class;
> > --
> > 2.25.1
> >

