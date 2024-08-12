Return-Path: <linux-rdma+bounces-4314-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7F694E5A2
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 06:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900C31C2145A
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 04:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE6C13BAE2;
	Mon, 12 Aug 2024 04:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="YCqP/TSo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB92680C
	for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 04:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723435853; cv=none; b=EOvfxYCtIyjLyguLKpiNYR+Lc2Cdz7JT99/M88ADhc8+0FWr0SbIL47UfR72J/e9INHJFgK0nGcPFIX9RA5hDr61/ZAgMjBYFMIbOW3se5Eq7MD7XDrb/nOxcQNeVjl+5vSxnzpDo/TaGGMLiKsBWDqdffawgZbLex98jsJlfjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723435853; c=relaxed/simple;
	bh=+NW5KWAex/4G/54oPieo7hgWsUfmqcUcWveAdR33m6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4uVgQmx4PIh9IpoWBfigoQUkKQsCtMxZ0fVOXOZvNVt6+KSsYwjKCA7Cg4Im0JccGVpLxtl+mVlUoL6nxzgBjvNo9Q2tZyXFo5dN6j0uYqTZ5vNYJvv7H/W4ksi8ufX5kvnrMtFtz47GmTwvqDyO6qH4z93+vKlkpXjHKo1M5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=YCqP/TSo; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5b9d48d1456so2851216a12.1
        for <linux-rdma@vger.kernel.org>; Sun, 11 Aug 2024 21:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1723435849; x=1724040649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQ4lbfQp3UCcE85xEmP0sLKN8SdbGpz/cPHmessf0v4=;
        b=YCqP/TSouOp7Qv+PbsL48ulhUqrOCKTHSulw9gvZGeyq0HyI/hhg++tNK+QkCgC/t3
         elbXxTJzyL31aqZI10JRy0ymzxR+5QsHx4GXf+wUbEVhD1WH2B6TlcQfLojgDZWzaBcc
         9ABdnj28vG7IHDJ2p/WPEpg0TNXPRnEN9HgdsXUycJJ9Zy+5Ol/LPIYafnLzG//7t4J7
         g8j9+kZFiKLigzKNVEqCkR9XEzvhjNFYUly7a9l52Ehszhe/qy3bI50Nug0dPfxCaRJ1
         yZwcX4eoWXgb8jFeakewoEtMM+TfoO1NsMUs5xM/WitAo6P+BDHqYggWqh4CvlvTdZ4r
         +Eqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723435849; x=1724040649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQ4lbfQp3UCcE85xEmP0sLKN8SdbGpz/cPHmessf0v4=;
        b=INkeCO2FT8JelLk5I7/C/4XMV52d1f4Eaao1juYckL/GiNwT0ZuRb1e2Q19XP1RF5k
         ypku9IVuCtx6tE3K9jbaFZoOztmODvkt4aa8ejq1QdCdIljuS9pFAS2WGnoVROQl2TUo
         qbUhAvEa2u7CbEy1eg1GKq1s7T2gGJfJjyq3BxxBsOzUJ3HDXo+G1cQjdAG5LJE23uA7
         HPkBiXrvFxT1j78pH1mXlKOAEDnxfsBaVEo7rU1mPD6IJy8vUEqH2JGfYXoQ/P+JFYgo
         CYvgJD7Xk51tE+XtuWW8M67/RGWVOuBBkCPbDssqqUy12LTozyI9iE0BLzndJTjOOx72
         scIw==
X-Forwarded-Encrypted: i=1; AJvYcCU9QUp1gd+7HSPLU81KrBKz8rOwS3PJBszIJ+BJs0ZlcraSIcvOF2PNOdPOzdpEqAb5KJEe8LdE/92DBLt5LLObxlPx6VcutVmU5Q==
X-Gm-Message-State: AOJu0Yy4RfLj+YKbgSV+ZxttSctStMqx/WhRT6UIDRtvk6/+F5qOOCJ8
	A6HefwpinC5kf4/+zOp8DN2AOuw6W5/mtKLu49y2R8msGuyURFKBKSpYhALWBpFe6VjmtCw9tEO
	DOkXcUVFyhHRY9fuuQd1oIAk8165g8Rdt2h1jSw==
X-Google-Smtp-Source: AGHT+IHNJKimqLy8wg5CKT8Bn1DFOJYuSmd1Euwb6wwr+umToOjwbv1iO5D7uav4blvPTNKm0HupcPUv9bJMaImG2QQ=
X-Received: by 2002:a05:6402:11c9:b0:5b4:cbba:902a with SMTP id
 4fb4d7f45d1cf-5bbb3bafabbmr10923493a12.4.1723435848872; Sun, 11 Aug 2024
 21:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809131538.944907-1-haris.iqbal@ionos.com>
 <20240809131538.944907-14-haris.iqbal@ionos.com> <20240811084325.GD5925@unreal>
In-Reply-To: <20240811084325.GD5925@unreal>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Mon, 12 Aug 2024 06:10:38 +0200
Message-ID: <CAMGffEk1iuHiDOF5CmPyCXb+_gJWea2hJT7sV05mf27+JftpyA@mail.gmail.com>
Subject: Re: [PATCH for-next 13/13] RDMA/rtrs-clt: Remove an extra space
To: Leon Romanovsky <leon@kernel.org>
Cc: Md Haris Iqbal <haris.iqbal@ionos.com>, linux-rdma@vger.kernel.org, bvanassche@acm.org, 
	jgg@ziepe.ca, Alexei Pastuchov <alexei.pastuchov@ionos.com>, 
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 10:43=E2=80=AFAM Leon Romanovsky <leon@kernel.org> =
wrote:
>
> On Fri, Aug 09, 2024 at 03:15:38PM +0200, Md Haris Iqbal wrote:
> > From: Jack Wang <jinpu.wang@ionos.com>
> >
>
> No empty commit message, please provide a proper description.
This is really simple change, the subject should explain it clear, but
ok, I will extend it also in the commit message.
>
> Thanks
Thx & Regards
>
>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > Signed-off-by: Alexei Pastuchov <alexei.pastuchov@ionos.com>
> > Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
> > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniban=
d/ulp/rtrs/rtrs-clt.c
> > index fb548d6a0aae..71387811b281 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > @@ -1208,7 +1208,7 @@ static int rtrs_clt_read_req(struct rtrs_clt_io_r=
eq *req)
> >               ret =3D rtrs_map_sg_fr(req, count);
> >               if (ret < 0) {
> >                       rtrs_err_rl(s,
> > -                                  "Read request failed, failed to map =
 fast reg. data, err: %d\n",
> > +                                  "Read request failed, failed to map =
fast reg. data, err: %d\n",
> >                                    ret);
> >                       ib_dma_unmap_sg(dev->ib_dev, req->sglist, req->sg=
_cnt,
> >                                       req->dir);
> > --
> > 2.25.1
> >

