Return-Path: <linux-rdma+bounces-15323-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0964ECF7A97
	for <lists+linux-rdma@lfdr.de>; Tue, 06 Jan 2026 11:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2A6E300AC4A
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jan 2026 10:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85A630E0ED;
	Tue,  6 Jan 2026 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Zv3VqVVl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF5730DEC0
	for <linux-rdma@vger.kernel.org>; Tue,  6 Jan 2026 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767693834; cv=none; b=XfvHsO3xGicrxNxZXxe1nUvNpgKHlizcO3xlzvhl0IMiime5qbClUNxG2RPi3BaEsFierr1IvZyhX5XWdj2ki9SkgEM/UfXaiYqfPVl1kJbethZiyOrGhqAJ6bJ3MyqjvXJquC2ZsQSleS6KpA/PNuEcIZIsuHadLOFAovG0C9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767693834; c=relaxed/simple;
	bh=pdglNR8NkI/pqmhfPDrEqH408Th+6TPC+hgJ0zLsvC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGYVPLocvi68R2FOjezBuWi2hbMkEmuEB5yfBSpZ9c/RmTKEswf3/Gmv4Zvth6S14+437gWkEnbNk93hY5sH6b9ZvGjl6QQt7Egi7PoddDI9hqkLAUeLffuB4LUAePIxHBY+9gxaal3IwSRtgHrKvQkgWzFbyExlXwiQjEl3P60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Zv3VqVVl; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5957ac0efc2so856165e87.1
        for <linux-rdma@vger.kernel.org>; Tue, 06 Jan 2026 02:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1767693830; x=1768298630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JabrQA7wNjpD7Ni3uIWd7NjKHio14esd2ttcoMQMI1c=;
        b=Zv3VqVVlFhUBY1YqJ3yQ1KQsqN6iCblaiYKao8vviyrdy7kUMPEdZxZk6PkrOu43VZ
         xtiH1Q+uerHmVr4jpwN8VlXp4T1xfplIE/XMnF4WW7M/hfa7MBNQrGGMfRORDt38SF6b
         +6SpMsiW4DPEiYcBixOoAODaTMolcD6zBZJITt3xQr3ZBdmOGbzLRTKCHU+1gZrkagct
         wMILM6cSUzUqw/RQpliDVN1yCBdN0sX3TeyR3LARZsacfZ3mdoxGz5S4eyHh94UyDZNy
         ocBaOx6nnQY6gJesN6mmCiyifiiYG9aV92jsCY7joA7FQXhqd+knFXqy9jT7vEFsTlLo
         cRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767693830; x=1768298630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JabrQA7wNjpD7Ni3uIWd7NjKHio14esd2ttcoMQMI1c=;
        b=ZFpF8gwIsXZOD4vRfOWNyL+QKR+1nAxsXX4tVuXJSzknCH8Hzo3bBC10rt+jtyXR+r
         gYX9o46YT95XiQQl5aqHolo5kl4PcPfWvtBC+6LA64v5/QftbooqZ3iYg8wBb6efmkkV
         yrfedjwb/w3T9K2QORuszp9dqZ4e9WOOoCn8rf+oE3YJP5xcj57pgap8wrB2uvEjmKqE
         HgrYZQYD/TCCmH4ro11i6Qh86bXVisXR3OHCgT9jfTkV8nLC1bYm4HifyKUCYhlfufoo
         ZTkZrTn8guHQA2s1Ijb0tIIMTwtYPn9Jq/haIPObwYrGy5ezMkw02ydBQ2hfFeNc/sCn
         xoqA==
X-Gm-Message-State: AOJu0Yyu+LjdypjKt+c/7eAzNQ7acI/AqSGFvgptL9DBY5/yGXJLzzGZ
	m1TI9p1B0M2/s+qkDcVW8CF1p1lQ62kf+enSvDEmrCOVW+L8zEXd4y4qWIIdQi8x5DuMFliejEU
	bPzg8nHvsQDOKY2DH2zOJqYgcOuoXitxZg2kCOj/Vfw==
X-Gm-Gg: AY/fxX68xpARBea4u96uRlLTAH/XVnPG8PyMHnQEY8hcTruhcRIDL+XQ/+hXJVvR+uX
	A+K8ZmeGXq+dX7j/I2EvoB/rbjVQoK57LuzXNTxt0e8mQHtXYcYho2uxKuOv/K8/3BozEIXIId+
	TSiawOrmceXBtVMZ1jts0FHWaO8QFNsjXduoXviBP5DHVrCu8tNYnzazEtRu1VqLcCpGRGcX/bY
	mpxuGqB6A9/h+ekq5EQ5em/HNiwyeQlWJRmu702hzNTAvkjKt+oXmqvNIleQVes2AWDvb0=
X-Google-Smtp-Source: AGHT+IF80WretgXxYJYAJ9okdNaSXoLlSwuspls/kS2Zjwjez30+fkV4QUADem2AGTEB91AQ0+FPuyHBRgVgFXittAw=
X-Received: by 2002:a05:651c:1469:b0:363:fea4:dcfa with SMTP id
 38308e7fff4ca-382eaa054femr6492451fa.10.1767693830343; Tue, 06 Jan 2026
 02:03:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208161513.127049-1-haris.iqbal@ionos.com>
 <20251208161513.127049-3-haris.iqbal@ionos.com> <20251218155129.GB400630@unreal>
In-Reply-To: <20251218155129.GB400630@unreal>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Tue, 6 Jan 2026 11:03:38 +0100
X-Gm-Features: AQt7F2pDzFGQemJPhHgJnJIQnAGhID_je_PXpGHeUQEkSL2aoUU5hZ5uZfP3fQo
Message-ID: <CAJpMwyhGq0iNPbaOoP04B_3Op=NyrazaOhXGhM6jO=c9b-VJMQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] RDMA/rtrs: Add error description to the logs
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org, jgg@ziepe.ca, 
	jinpu.wang@ionos.com, grzegorz.prajsner@ionos.com, 
	Kim Zhu <zhu.yanjun@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 4:51=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Mon, Dec 08, 2025 at 05:15:06PM +0100, Md Haris Iqbal wrote:
> > From: Kim Zhu <zhu.yanjun@ionos.com>
> >
> > Print error description besides the error number.
> >
> > Signed-off-by: Kim Zhu <zhu.yanjun@ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c |  8 +-
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 89 ++++++++++----------
> >  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 12 +--
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 78 ++++++++---------
> >  drivers/infiniband/ulp/rtrs/rtrs.c           |  9 +-
> >  5 files changed, 101 insertions(+), 95 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/inf=
iniband/ulp/rtrs/rtrs-clt-sysfs.c
> > index 4aa80c9388f0..b318acc12b10 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> > @@ -439,19 +439,19 @@ int rtrs_clt_create_path_files(struct rtrs_clt_pa=
th *clt_path)
> >                                  clt->kobj_paths,
> >                                  "%s", str);
> >       if (err) {
> > -             pr_err("kobject_init_and_add: %d\n", err);
> > +             pr_err("kobject_init_and_add: %d(%pe)\n", err, ERR_PTR(er=
r));
>
> Or print error or print error description, not both.

Makes sense. Will change it.
Thanks

>
> Thanks

