Return-Path: <linux-rdma+bounces-865-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A64DD846FEC
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 13:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B24D1F26EAD
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 12:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B12A140770;
	Fri,  2 Feb 2024 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evdXNEJU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133D87763F
	for <linux-rdma@vger.kernel.org>; Fri,  2 Feb 2024 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875949; cv=none; b=lpKgi+n5XfBxBseGqPjkXq3Ryx1AzAZa29dlViKpVPvLTVdrPhI2Dc0kVgQYjlRY7TO7MB8imxgNNRQAtld80cxeTW2oQ3qrz7j5iEwr53PqWNWtKPbZH75FJcgcTQwdgKu+SR0MVCiLInNK8JR4AOPM1R6QxGL9HwCAf1L/yiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875949; c=relaxed/simple;
	bh=WKJpY2cN0JaLUYW9HeayLJ3gJ5nnyHGko9zjS5TC67E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSbA6DxAQ61tAR5P0C0tOY+zXBLzzzd7IkLM8U2JhAg1rp1wBuk7X7eVVIDfvhq5+desu0AUQuBL5TJFkWu+Sb5MOngRqRLeOq3owVUg1EqiulbZYHRtNP7rR/e0PAr2T0DyhpitVrLDPISl0VXLvRXn6k9z612NU3mI/8QExbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evdXNEJU; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a364b5c5c19so339534366b.1
        for <linux-rdma@vger.kernel.org>; Fri, 02 Feb 2024 04:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706875946; x=1707480746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ryg+zr9KvfMVsxHoJVIZzim4CVODY4CH6hZHeh0ET/o=;
        b=evdXNEJUpgdNLXzsB/8Hgh6MI3Q5XGINHfb3NH3442UTtCmzJWteIGJGw7VSHxbHIv
         DCOr7MZrs/61sVgjkhDcyiNORQ0kZSVfMUqu6IvMlO7PvtEDMnBJD9akVEAlxnSXhDT1
         gBN04L2jUqnAyouyLtB16EcMKpoTWlvciz/2LI2as7LY+RGC8dhUaHI0TB0CWg5teJaS
         EE5NSaTxOz7wIaLHvAK7zdAFE7+1/dw5hrp7Viv7EyuPZsI4vcCnrFk91Yn9E3yVBWhE
         7rFkV0bvqBgxXAncAd9j0YppcAQ2GUlq3ijYkg1OxrE95SWZclEkmGNkMgzBeLHEFvyB
         w+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706875946; x=1707480746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ryg+zr9KvfMVsxHoJVIZzim4CVODY4CH6hZHeh0ET/o=;
        b=f+5PWFmw27+zd6vql0rkXCpJWLzUYv95PegajQUgtv0u2H1DqeHRjAeaJLves1OPdz
         BK0T5RSVwKEwofZ99rvYq8wWVQgpt39ye7OsgE1LLxbYmUsY+0m8ex/CKBGUsbBYWPRe
         tqt6Q8thVzRF4Rm2hqMa5sliQqOkJk4dUe1GX0jW3LtSnqPsV4VlH87v5i+NAVZ6jn8+
         EsI6iUTHpDdGP5rN8qFX334mjcq66xNgzYKxVsSL2srH71o/U0KhTyoH7hgzQuMlJlGC
         yfN5xgCknATaRsYTF8mWpEe4xy7s4wmrdpzFo9og3cYra6bq6QSif75c4i/M8P7lSqIt
         sdXA==
X-Gm-Message-State: AOJu0YxWecCNec1aOwzQu1Mu9KA1bDNuEJ6O60et+VIxH0fcdTX4wxW5
	lHpolRkxbf/7H0CzyKNRkjcpnBuDRfYD+XBZTqkCfJK1c+f6hBTNDklpCUWQzCLJS89iglm96ch
	XhVZzMwEOc8tcV6ZSPiEJ6uf0xtw=
X-Google-Smtp-Source: AGHT+IEtnuk96jdJ/EMqY30nxlRB99SvClQaSX0AvjFFNHVMaYu4n16u0X934vpciQmSJ92tyhww27oSsh6pfeNHtnQ=
X-Received: by 2002:a17:906:c782:b0:a31:83a2:463c with SMTP id
 cw2-20020a170906c78200b00a3183a2463cmr6249386ejb.34.1706875945985; Fri, 02
 Feb 2024 04:12:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201125745.21525-1-guoqing.jiang@linux.dev> <CAD=hENdNnzqBP1jJj-NHRg_BjsQYh-u2CdCQNn6HF8R87JOgzg@mail.gmail.com>
In-Reply-To: <CAD=hENdNnzqBP1jJj-NHRg_BjsQYh-u2CdCQNn6HF8R87JOgzg@mail.gmail.com>
From: Zhu Yanjun <zyjzyj2000@gmail.com>
Date: Fri, 2 Feb 2024 20:12:14 +0800
Message-ID: <CAD=hENezdmFzjrDowq9N0Kk+1SSrv3BEmjROGTFWJoDkvJG3Lw@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Remove unused 'iova' parameter from rxe_mr_init_user
To: Guoqing Jiang <guoqing.jiang@linux.dev>
Cc: jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 7:49=E2=80=AFPM Zhu Yanjun <zyjzyj2000@gmail.com> wr=
ote:
>
> On Thu, Feb 1, 2024 at 8:58=E2=80=AFPM Guoqing Jiang <guoqing.jiang@linux=
.dev> wrote:
> >
> > This one is not needed since commit 954afc5a8fd8 ("RDMA/rxe:
> > Use members of generic struct in rxe_mr").
> >
> > Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> > ---
> >  drivers/infiniband/sw/rxe/rxe_loc.h | 2 +-
> >  drivers/infiniband/sw/rxe/rxe_mr.c  | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/s=
w/rxe/rxe_loc.h
> > index 4d2a8ef52c85..746110898a0e 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> > +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> > @@ -59,7 +59,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_a=
rea_struct *vma);
> >  /* rxe_mr.c */
> >  u8 rxe_get_next_key(u32 last_key);
> >  void rxe_mr_init_dma(int access, struct rxe_mr *mr);
> > -int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 i=
ova,
> > +int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
> >                      int access, struct rxe_mr *mr);
> >  int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
> >  int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int leng=
th);
> > diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw=
/rxe/rxe_mr.c
> > index bc81fde696ee..da3dee520876 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> > @@ -126,7 +126,7 @@ static int rxe_mr_fill_pages_from_sgt(struct rxe_mr=
 *mr, struct sg_table *sgt)
> >         return xas_error(&xas);
> >  }
> >
> > -int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 i=
ova,
> > +int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
> >                      int access, struct rxe_mr *mr)
> >  {
> >         struct ib_umem *umem;
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c
> b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 48f86839d36a..04427238fcab 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1278,7 +1278,7 @@ static struct ib_mr *rxe_reg_user_mr(struct
> ib_pd *ibpd, u64 start,
>         mr->ibmr.pd =3D ibpd;
>         mr->ibmr.device =3D ibpd->device;
>
> -       err =3D rxe_mr_init_user(rxe, start, length, iova, access, mr);
> +       err =3D rxe_mr_init_user(rxe, start, length, access, mr);
>         if (err) {
>                 rxe_dbg_mr(mr, "reg_user_mr failed, err =3D %d", err);
>                 goto err_cleanup;
>
Without the above, the following will appear.

drivers/infiniband/sw/rxe/rxe_verbs.c: In function =E2=80=98rxe_reg_user_mr=
=E2=80=99:
drivers/infiniband/sw/rxe/rxe_verbs.c:1281:58: warning: passing
argument 5 of =E2=80=98rxe_mr_init_user=E2=80=99 makes pointer from integer=
 without a
cast [-Wint-conversion]
 1281 |         err =3D rxe_mr_init_user(rxe, start, length, iova, access, =
mr);
      |                                                          ^~~~~~
      |                                                          |
      |                                                          int
In file included from drivers/infiniband/sw/rxe/rxe.h:31,
                 from drivers/infiniband/sw/rxe/rxe_verbs.c:11:
drivers/infiniband/sw/rxe/rxe_loc.h:63:49: note: expected =E2=80=98struct
rxe_mr *=E2=80=99 but argument is of type =E2=80=98int=E2=80=99
   63 |                      int access, struct rxe_mr *mr);
      |                                  ~~~~~~~~~~~~~~~^~
drivers/infiniband/sw/rxe/rxe_verbs.c:1281:15: error: too many
arguments to function =E2=80=98rxe_mr_init_user=E2=80=99
 1281 |         err =3D rxe_mr_init_user(rxe, start, length, iova, access, =
mr);
      |               ^~~~~~~~~~~~~~~~
drivers/infiniband/sw/rxe/rxe_loc.h:62:5: note: declared here
   62 | int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
      |     ^~~~~~~~~~~~~~~~
make[6]: *** [scripts/Makefile.build:243:
drivers/infiniband/sw/rxe/rxe_verbs.o] Error 1
make[6]: *** Waiting for unfinished jobs....
make[5]: *** [scripts/Makefile.build:480: drivers/infiniband/sw/rxe] Error =
2
make[4]: *** [scripts/Makefile.build:480: drivers/infiniband/sw] Error 2
make[3]: *** [scripts/Makefile.build:480: drivers/infiniband] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:480: drivers] Error 2
make[1]: *** [/images/upstream-linux/Makefile:1911: .] Error 2
make: *** [Makefile:234: __sub-make] Error 2

Zhu Yanjun

> Zhu Yanjun
> > --
> > 2.35.3
> >

