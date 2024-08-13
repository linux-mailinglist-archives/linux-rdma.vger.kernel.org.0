Return-Path: <linux-rdma+bounces-4349-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C654095030D
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2024 12:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471F21F23908
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2024 10:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E581919D089;
	Tue, 13 Aug 2024 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ctbSUMBY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8D419D899
	for <linux-rdma@vger.kernel.org>; Tue, 13 Aug 2024 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546484; cv=none; b=F+MFawr8memNOX1d0GBORxIzTjczrkS87g4yJ6q7+/M6YSfdvhTfJbp61m98B/Hlr5dWL40gjaxx/WA6Btu/13KtVOUz+iIEgP8MxbW0vXth8rTsT6G9vDRquYevVuRRg9IHKKwwzo3SpmCioRl9ExTxh7tETOethUOaJgEssIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546484; c=relaxed/simple;
	bh=hG+eHkq3xjY18k7VtiCj4MOwrb3pf3CcrKn/unPhg9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+hyyAY3/NVWEi5vxkzEQYaUnz60McEM4JgV45h/VTb/rpNygZSnKGhvc0FOnuFB+j6il/qRj3s5fEb8WcGJm+dhWb/EHINPEWJ06yRwFfI73pldDxcaPNJ6J9swudz6EqvpPK+U6SaguPHdUW8FtkW4nftHxnbnI9QJIa5G1lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ctbSUMBY; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7d638a1f27so195900966b.2
        for <linux-rdma@vger.kernel.org>; Tue, 13 Aug 2024 03:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1723546480; x=1724151280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUQFtcBnO/CTwrK6iVG51LoX2OVfGISsjbz+lSr1MyY=;
        b=ctbSUMBYhzykKDR8R9gzBDhs3iv5IwYTtAype0phmeDCmucErhm01vAt0dUaK/Mfyy
         rDfDy8/y0zXBlTqbSdfs43zPCT1mE/jeV76Q8UE3cxOCdSZEcKWJheEVAQbAFzuObfFV
         za5rsg3EUyoBGYXlZ+mol3fOLgMKNSisGuDw/87WiJdHHj8NiRGRcjy5jeDOvNmnCNdw
         bJs6iqB9xsygod/YFBBk9l4C6AxSQ8gi+AeLFvsENBUWPn2ywev9VPX4zeg2WNu5UlPe
         YEVJJdqcdGmWaCTKXR4ClbL6cJ9QpcqM/awWDds8OP8GAnspeMQZIvVuDZ4ydTor+NeP
         rbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723546480; x=1724151280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUQFtcBnO/CTwrK6iVG51LoX2OVfGISsjbz+lSr1MyY=;
        b=WIsk3xu0ZdnjUUL+mFlhbqc0MyxOdMBPnRRKJ+OiocxFgHEr7MTHhEtLuwHzU1MzDy
         /qSZMhebrGsencS2nvuSufcj7Yv466ucFl0gDp0DANSxy4PMuAIz/G5vUgp+Xi2CDvpc
         au6qUGFJMV7oH4RoGT/0TopgHyQ1/bx1IXpSchKRQBXJ3hfdn0lYGWcpGXd6nt0MrHsj
         EbnMPrZaKdYDi0XPRrZw7noZbsJBBxQOa2020TOB6DjlJpH7aw72EqK9VVJWHPKoNGpA
         dbocx5go61Pns8f2q96NdXNJADOLw2clbvRGZe81eTowCDQhH8Vglm8XBxBJNGjP46om
         Hm2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUv8kSeZJ28K2E9F9GNgUsUFtXhkuJ9H+yz0agoqPwf1eolxG5678Pj1jYNoYWNiqJ6keb6oVEMD/cWkxWjHuNTndLzIR6II/b7LQ==
X-Gm-Message-State: AOJu0YxiTlpTbN5vDLlh9zBHtWCqT8DQ37yEGnV+jnLCsCvsr3Nv6iiv
	h4t+FI1eIa9vRPRM5TgJ2t5HC/dB3nwkRFB/jFQEY4JLJuMlmpXJj4rt99pjymcAI01ER0sOmuf
	VpmRKLt3FRZ/IIGSKxLRdYuFhQ6lYYIVA7uU/6zXfd/+D3St2XXU=
X-Google-Smtp-Source: AGHT+IGjc5r31UySokkCXWgoYQfBHemWPqz97Km34tDDWf0BjEasXAJmbh6EnbeOmUFCZm8Y1llX+cu66ut32g4Zo40=
X-Received: by 2002:a05:6402:524a:b0:5a0:e303:8f0f with SMTP id
 4fb4d7f45d1cf-5bd44c263fcmr2833255a12.10.1723546480288; Tue, 13 Aug 2024
 03:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809131538.944907-1-haris.iqbal@ionos.com>
 <20240809131538.944907-3-haris.iqbal@ionos.com> <20240811084110.GC5925@unreal>
 <CAMGffEmvWLy4-ugYVPBLYAAe43xZ73=bp7sH5ackf6M7w2zdZg@mail.gmail.com> <20240812110059.GE12060@unreal>
In-Reply-To: <20240812110059.GE12060@unreal>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Tue, 13 Aug 2024 12:54:29 +0200
Message-ID: <CAMGffE=VBWTt5k-2mXNXsDnM670up6pV2ERfXHxsQcGKKiHWrQ@mail.gmail.com>
Subject: Re: [PATCH for-next 02/13] RDMA/rtrs-srv: Fix use-after-free during
 session establishment
To: Leon Romanovsky <leon@kernel.org>
Cc: Md Haris Iqbal <haris.iqbal@ionos.com>, linux-rdma@vger.kernel.org, bvanassche@acm.org, 
	jgg@ziepe.ca, Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 1:01=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Mon, Aug 12, 2024 at 12:52:25PM +0200, Jinpu Wang wrote:
> > Hi,
> >
> > On Sun, Aug 11, 2024 at 10:41=E2=80=AFAM Leon Romanovsky <leon@kernel.o=
rg> wrote:
> > >
> > > On Fri, Aug 09, 2024 at 03:15:27PM +0200, Md Haris Iqbal wrote:
> > > > From: Jack Wang <jinpu.wang@ionos.com>
> > > >
> > > > In case of error happening during session stablishment, close_work =
is
> > > > running. A new RDMA CM event may arrive since we don't destroy cm_i=
d
> > > > before destroying qp. To fix this, we first destroy cm_id after dra=
in_qp,
> > > > so no new RDMA CM event will arrive afterwards.
> > > >
> > > > Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> > > > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > > Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
> > > > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > > > ---
> > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
> > > >  drivers/infiniband/ulp/rtrs/rtrs.c     | 2 +-
> > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infin=
iband/ulp/rtrs/rtrs-srv.c
> > > > index fb67b58a7f62..90ea25ad6720 100644
> > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > @@ -1540,6 +1540,7 @@ static void rtrs_srv_close_work(struct work_s=
truct *work)
> > > >               con =3D to_srv_con(srv_path->s.con[i]);
> > > >               rdma_disconnect(con->c.cm_id);
> > > >               ib_drain_qp(con->c.qp);
> > > > +             rdma_destroy_id(con->c.cm_id);
> > > >       }
> > > >
> > > >       /*
> > > > @@ -1564,7 +1565,6 @@ static void rtrs_srv_close_work(struct work_s=
truct *work)
> > > >                       continue;
> > > >               con =3D to_srv_con(srv_path->s.con[i]);
> > > >               rtrs_cq_qp_destroy(&con->c);
> > > > -             rdma_destroy_id(con->c.cm_id);
> > > >               kfree(con);
> > > >       }
> > > >       rtrs_ib_dev_put(srv_path->s.dev);
> > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniban=
d/ulp/rtrs/rtrs.c
> > > > index 4e17d546d4cc..44167fd1c958 100644
> > > > --- a/drivers/infiniband/ulp/rtrs/rtrs.c
> > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> > > > @@ -318,7 +318,7 @@ EXPORT_SYMBOL_GPL(rtrs_cq_qp_create);
> > > >  void rtrs_cq_qp_destroy(struct rtrs_con *con)
> > > >  {
> > > >       if (con->qp) {
> > > > -             rdma_destroy_qp(con->cm_id);
> > > > +             ib_destroy_qp(con->qp);
> > >
> > > You created that QP with rdma_create_qp() and you should destroy it w=
ith rdma_destroy_qp().
> > We can't do it, as we move rdma_destroy_id before rtrs_cq_qp_destroy,
> > if we still call rdma_destroy_qp, which will lead to use after free as
> > cm_id could already be free-ed.
>
> It is a hint that you are doing something wrong.
will drop it for now, will see if there is other way to fix it.
>
> Thanks
Thx
>
> >
> > >
> > > Thanks
> > Thx!
> > >
> > > >               con->qp =3D NULL;
> > > >       }
> > > >       destroy_cq(con);
> > > > --
> > > > 2.25.1
> > > >
> >

