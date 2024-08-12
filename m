Return-Path: <linux-rdma+bounces-4328-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 952A194EB78
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 12:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38EC31F22648
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 10:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9761170A0B;
	Mon, 12 Aug 2024 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="co08j6Xl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4C216E866
	for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723459960; cv=none; b=Qvmw0XtDwa50kBhQkaZYvZBi07NpYbt6yP+icIdjaVD1gN86QltQijcfzkmrN1oekfjiKA6cbt00RZucUWjWM69KhySzioCvkUItnZ04XToG5lvuefV6OkDwpFVmkhYUZvZw1EZtZ+tLEgcQz0EiJK3F1Oyx5WUN+HJHwFUREjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723459960; c=relaxed/simple;
	bh=SKYJj6MLkod2gWLuCRIHI3t4ORBnGMLkjbp99ibMw5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Alve7FzOW+rZ/GbmeMqC3JJKwmCDMeBY7UKkgr/XVqFkp2VH3nxUr0E18pRkATycmSgQva5W8Ti/lRgTx/JNDGTylv3K9jek9HFciKtS/+rzRF8KZJYFAnxGJh+fDRfHsFLC8uHt/CKLWaYCM1VaMEb1/Iuuio3C3DB9Demiio8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=co08j6Xl; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5b9d48d1456so121852a12.1
        for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 03:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1723459956; x=1724064756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCcuLHoAqY2qdDzwVIRmlnHvJrL6TLoBuT9hD5BXRZk=;
        b=co08j6Xl2pF9STddOopcqzqpHU5qwdbXx0KNVb7MJ5EcHGDcZ98aHIM6l+QGntnIoT
         DMKy7TjnQ2U4UEix9cVfiZ0kWwXqHws6nwewIK1BVeHNesAAunDlB4Fw1gfokokNOvtN
         ITgrC/SX80OELFQvEsDJZluPcnSsDWyYGNdEBUHGBOIM2H5M0DbvjL9xE8iBAC98lCZI
         rn0iyi9sjKsolaf2uWuHnpxlyqxGY3p6Nd9tNRAl7trOdwUbgjdWQQASLTvqnWFKImrQ
         qMZOl9dgv6WAQclMS4TccbEy5A0KoLekKlmp6ZU3d7VH1TyNZ1vEuO5Ld6C6vcFunLK2
         wV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723459956; x=1724064756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCcuLHoAqY2qdDzwVIRmlnHvJrL6TLoBuT9hD5BXRZk=;
        b=SL0IJWe+g3hBS45AA8Y9Ys/lThNyQOI9YOsZpDNBTyg9HTznBJqNn6NdSvcHyAwdsI
         iHCJ1cPK4HZs3eEHRXEOJouEshY5RMrKxs/fmphNg0c5QrDRs6kW2/vF5/0rPN/yITQo
         zjpVixZ4hMNgLR1mJSK1LH5QPtLnW1MpgXbQ/FIv4OHTsRykMBRU9POGw3t/zhAJMNWc
         0MmatrDdXJt8XMJ89F6gPG93epsQ44DrTnuwJx8EnatkfZ8E4RiT/RRLf02hrjxq7cZ6
         XQAGelP+8HP/J14DDCCNTnKDSCRnGj+iNABVpiRwAJuFyXwSK0wHru2V9oYZ+EKk7pIa
         ksjA==
X-Forwarded-Encrypted: i=1; AJvYcCW4X/XjSApZUyHIIX0Tw/6ItdFBF7mmvdUHLmy7/b6I4toZH8MgPYcaPVLDN5e2fnZkETO34K/UlFd101Odwj+z65B7UPRFe/A/eA==
X-Gm-Message-State: AOJu0YxiZYNvHaJLl57cun9VJeHzQREGIGNRY6Ml2+Svzhpny4Qihu5O
	tZbRf97gxinExArZeEYVhvm2+nZfH5Z7YJyroTp3jMj7EQtDEMvi/bVC00cUU13+FiNne/L16e5
	SLOatMH0nPGqeXsNulp6hgVOkSJ/spOSfoccbvw==
X-Google-Smtp-Source: AGHT+IHw8CaOzq3ZFVMGKK//5CEZ5MAVZ0JP/Bruqu+9K9YEVQX4gQh6fV5OTLohzWydqqlpI5VEUC/O0PzgBZdUO+4=
X-Received: by 2002:a05:6402:3481:b0:57d:3e48:165d with SMTP id
 4fb4d7f45d1cf-5bd0ab0ed7amr7498291a12.4.1723459956303; Mon, 12 Aug 2024
 03:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809131538.944907-1-haris.iqbal@ionos.com>
 <20240809131538.944907-3-haris.iqbal@ionos.com> <20240811084110.GC5925@unreal>
In-Reply-To: <20240811084110.GC5925@unreal>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Mon, 12 Aug 2024 12:52:25 +0200
Message-ID: <CAMGffEmvWLy4-ugYVPBLYAAe43xZ73=bp7sH5ackf6M7w2zdZg@mail.gmail.com>
Subject: Re: [PATCH for-next 02/13] RDMA/rtrs-srv: Fix use-after-free during
 session establishment
To: Leon Romanovsky <leon@kernel.org>
Cc: Md Haris Iqbal <haris.iqbal@ionos.com>, linux-rdma@vger.kernel.org, bvanassche@acm.org, 
	jgg@ziepe.ca, Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 11, 2024 at 10:41=E2=80=AFAM Leon Romanovsky <leon@kernel.org> =
wrote:
>
> On Fri, Aug 09, 2024 at 03:15:27PM +0200, Md Haris Iqbal wrote:
> > From: Jack Wang <jinpu.wang@ionos.com>
> >
> > In case of error happening during session stablishment, close_work is
> > running. A new RDMA CM event may arrive since we don't destroy cm_id
> > before destroying qp. To fix this, we first destroy cm_id after drain_q=
p,
> > so no new RDMA CM event will arrive afterwards.
> >
> > Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
> > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
> >  drivers/infiniband/ulp/rtrs/rtrs.c     | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniban=
d/ulp/rtrs/rtrs-srv.c
> > index fb67b58a7f62..90ea25ad6720 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > @@ -1540,6 +1540,7 @@ static void rtrs_srv_close_work(struct work_struc=
t *work)
> >               con =3D to_srv_con(srv_path->s.con[i]);
> >               rdma_disconnect(con->c.cm_id);
> >               ib_drain_qp(con->c.qp);
> > +             rdma_destroy_id(con->c.cm_id);
> >       }
> >
> >       /*
> > @@ -1564,7 +1565,6 @@ static void rtrs_srv_close_work(struct work_struc=
t *work)
> >                       continue;
> >               con =3D to_srv_con(srv_path->s.con[i]);
> >               rtrs_cq_qp_destroy(&con->c);
> > -             rdma_destroy_id(con->c.cm_id);
> >               kfree(con);
> >       }
> >       rtrs_ib_dev_put(srv_path->s.dev);
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ul=
p/rtrs/rtrs.c
> > index 4e17d546d4cc..44167fd1c958 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> > @@ -318,7 +318,7 @@ EXPORT_SYMBOL_GPL(rtrs_cq_qp_create);
> >  void rtrs_cq_qp_destroy(struct rtrs_con *con)
> >  {
> >       if (con->qp) {
> > -             rdma_destroy_qp(con->cm_id);
> > +             ib_destroy_qp(con->qp);
>
> You created that QP with rdma_create_qp() and you should destroy it with =
rdma_destroy_qp().
We can't do it, as we move rdma_destroy_id before rtrs_cq_qp_destroy,
if we still call rdma_destroy_qp, which will lead to use after free as
cm_id could already be free-ed.

>
> Thanks
Thx!
>
> >               con->qp =3D NULL;
> >       }
> >       destroy_cq(con);
> > --
> > 2.25.1
> >

