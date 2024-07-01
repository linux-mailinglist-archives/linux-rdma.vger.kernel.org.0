Return-Path: <linux-rdma+bounces-3595-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7597991E250
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 16:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28EAF285760
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 14:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31868161337;
	Mon,  1 Jul 2024 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDMRSgCD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505308C1D
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jul 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843847; cv=none; b=s0QXCDEgphDc7fILNi/3HPHFfWOZSJblgF333tCe6Os6nUgrrWMy6GvssnbEIR+zDfuhXDKJeWl0oQel4b4/JGiE5i75i5fzLt0ib6TTBR5CbV7JHZ7GxM2bmTZhaciQ00yZHQ03rgONKDolbfZZuFbbGYxKNuKUJxhyCinCVeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843847; c=relaxed/simple;
	bh=8wCpjzsvEcYJwO7uz7Cksxml4x0CETvzHLYyJ2ii+ac=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MklSpEHPkn29ATOGvdYm47x6X8gqA/leBt0es3c7QOmHAO0WNZ9Dnp7f29zHEc5QyYavAZFR9g01c8Te+n7Jy2IIWsRl+0kJaNl7hCFhWolDTXGXGm/hjvyYTsKvfTmef7KOKzlVeAhF/khnXmprx3/1QHjB451rH9Xh/TzPgIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dDMRSgCD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719843844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GbfMnOycdlA3xHxqKRVFaGrN8OTl8KSGgKXHSgYRGsU=;
	b=dDMRSgCD2MKTzBBN5CiLuK6Fhbt13H+ocNFgmDjS1WKsQvQaLytkY8eJSBKJ9xqHzD+mFd
	0G4SS/B5GElwZemnzGG9+ep6nqihE1fQFEzcIkPhAf6TCroMxAHT7FBDPKi6R29DByKRER
	TJJpIpbJxpdqNsHUf5uZhdX6SFTkS+M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-7Id9Lg3TNZCWoJed2ZAlpg-1; Mon, 01 Jul 2024 10:24:02 -0400
X-MC-Unique: 7Id9Lg3TNZCWoJed2ZAlpg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a724a6a321cso11586766b.0
        for <linux-rdma@vger.kernel.org>; Mon, 01 Jul 2024 07:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719843842; x=1720448642;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GbfMnOycdlA3xHxqKRVFaGrN8OTl8KSGgKXHSgYRGsU=;
        b=XzLNlZpxL92SW9HJe7XP/tT+QSA+igh9/ouF6lGCdNYOSwCwsmPOtp09n6b3QDh1Id
         b1ZV7ie50EiScAqqmSV2iO2ys0fKsZap/b83fUyDjd3p4j0Dm0LUl4F239091OhxMu6J
         pFUjYrJM8WYJfsvNtoxZnJIFOFabIYwrD72AazG1SbmS3jmNd7tcY+5juHdJ965C4C3B
         QPF80j2xsqCp1tsFnopmz2q0iXB9S5SIUF7TK6S5hs6YO0NVgTrrH4SI+cK513zI75+l
         bW2IRfq04zluvWelpxDW82BwaE2/v+ebxLV8uSnweeyntv1kYEuE2bGZkF5R2367YA5+
         LBJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw7dl2cvqDrtsVdTAb+6kFgT0BMzdRaDkv3LxRwHD6zH7BLo6iGfF8Pb1QxUp4GNiivXUSU7zUDiJ+Kj+JujCdS3TMZznJagNV5w==
X-Gm-Message-State: AOJu0YynWtAtAtyrcXex6X+0XuPz3bSsgu2YEOWNq6E+CVt5v9bsCXFD
	CztrsalM/mx3dRYP457/1IFQKhqE2HLIVV/zJLqs2okfoENQmD4qLRJu1cAZUS0VENOMLkQEkuf
	y5IWlY51UWVytZXRt6kbmCE6McfB2EFiAo0PgP2bmMc9tTO7uSKOhm5PZvY8=
X-Received: by 2002:a17:907:7ea4:b0:a72:7404:deb2 with SMTP id a640c23a62f3a-a75145d05d1mr486694066b.7.1719843841736;
        Mon, 01 Jul 2024 07:24:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYCOaXQVOURhrWbLAmhpKyeJYd7HQOC2OdUGBazt2HV2n/uRW1KKGallc0kiVP3UneUtIi7A==
X-Received: by 2002:a17:907:7ea4:b0:a72:7404:deb2 with SMTP id a640c23a62f3a-a75145d05d1mr486690266b.7.1719843841310;
        Mon, 01 Jul 2024 07:24:01 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:2451:6610::f71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf58cc0sm336288266b.47.2024.07.01.07.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 07:24:00 -0700 (PDT)
Message-ID: <7348f2c9f594dd494732c481c0e35638ae064988.camel@redhat.com>
Subject: Re: [PATCH 13/15] net: jme: Convert tasklet API to new bottom half
 workqueue mechanism
From: Paolo Abeni <pabeni@redhat.com>
To: Allen <allen.lkml@gmail.com>
Cc: kuba@kernel.org, Guo-Fu Tseng <cooldavid@cooldavid.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 jes@trained-monkey.org, kda@linux-powerpc.org, cai.huoqing@linux.dev, 
 dougmill@linux.ibm.com, npiggin@gmail.com, christophe.leroy@csgroup.eu, 
 aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, nnac123@linux.ibm.com,
  tlfalcon@linux.ibm.com, marcin.s.wojtas@gmail.com, mlindner@marvell.com, 
 stephen@networkplumber.org, nbd@nbd.name, sean.wang@mediatek.com, 
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, borisp@nvidia.com, 
 bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com, 
 louis.peens@corigine.com, richardcochran@gmail.com,
 linux-rdma@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-acenic@sunsite.dk, linux-net-drivers@amd.com,  netdev@vger.kernel.org
Date: Mon, 01 Jul 2024 16:23:56 +0200
In-Reply-To: <CAOMdWSKKyqaJB2Psgcy9piUv3LTDBHhbo_g404fSmqQrVSyr7Q@mail.gmail.com>
References: <20240621050525.3720069-1-allen.lkml@gmail.com>
	 <20240621050525.3720069-14-allen.lkml@gmail.com>
	 <ba3b8f5907c071e40be68758f2a11662008713e8.camel@redhat.com>
	 <CAOMdWSKKyqaJB2Psgcy9piUv3LTDBHhbo_g404fSmqQrVSyr7Q@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-01 at 03:13 -0700, Allen wrote:
> > > @@ -1326,22 +1326,22 @@ static void jme_link_change_work(struct work_=
struct *work)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0jme_start_shutdown_timer(jme);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > >=20
> > > -     goto out_enable_tasklet;
> > > +     goto out_enable_bh_work;
> > >=20
> > > =C2=A0err_out_free_rx_resources:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0jme_free_rx_resources(jme);
> > > -out_enable_tasklet:
> > > -     tasklet_enable(&jme->txclean_task);
> > > -     tasklet_enable(&jme->rxclean_task);
> > > -     tasklet_enable(&jme->rxempty_task);
> > > +out_enable_bh_work:
> > > +     enable_and_queue_work(system_bh_wq, &jme->txclean_bh_work);
> > > +     enable_and_queue_work(system_bh_wq, &jme->rxclean_bh_work);
> > > +     enable_and_queue_work(system_bh_wq, &jme->rxempty_bh_work);
> >=20
> > This will unconditionally schedule the rxempty_bh_work and is AFAICS a
> > different behavior WRT prior this patch.
> >=20
> > In turn the rxempty_bh_work() will emit (almost unconditionally) the
> > 'RX Queue Full!' message, so the change should be visibile to the user.
> >=20
> > I think you should queue the work only if it was queued at cancel time.
> > You likely need additional status to do that.
> >=20
>=20
> =C2=A0Thank you for taking the time out to review. Now that it's been a w=
eek, I was
> preparing to send out version 3. Before I do that, I want to make sure if=
 this
> the below approach is acceptable.

I _think_ the following does not track the  rxempty_bh_work 'queued'
status fully/correctly.

> @@ -1282,9 +1282,9 @@ static void jme_link_change_work(struct work_struct=
 *work)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0jme_stop_shutdown_timer(jme);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0jme_stop_pcc_timer(jme);
> -       tasklet_disable(&jme->txclean_task);
> -       tasklet_disable(&jme->rxclean_task);
> -       tasklet_disable(&jme->rxempty_task);
> +       disable_work_sync(&jme->txclean_bh_work);
> +       disable_work_sync(&jme->rxclean_bh_work);
> +       disable_work_sync(&jme->rxempty_bh_work);

I think the above should be:

	  jme->rxempty_bh_work_queued =3D disable_work_sync(&jme->rxempty_bh_work)=
;

[...]
> @@ -1326,22 +1326,23 @@ static void jme_link_change_work(struct
> work_struct *work)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0jme_start_shutdown_timer(jme);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>=20
> -       goto out_enable_tasklet;
> +       goto out_enable_bh_work;
>=20
> =C2=A0err_out_free_rx_resources:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0jme_free_rx_resources(jme=
);
> -out_enable_tasklet:
> -       tasklet_enable(&jme->txclean_task);
> -       tasklet_enable(&jme->rxclean_task);
> -       tasklet_enable(&jme->rxempty_task);
> +out_enable_bh_work:
> +       enable_and_queue_work(system_bh_wq, &jme->txclean_bh_work);
> +       enable_and_queue_work(system_bh_wq, &jme->rxclean_bh_work);
> +       if (jme->rxempty_bh_work_queued)
> +               enable_and_queue_work(system_bh_wq, &jme->rxempty_bh_work=
);

Missing:

	  else
		enable_work(system_bh_wq, &jme->rxempty_bh_work);

[...]
> @@ -3180,9 +3182,9 @@ jme_suspend(struct device *dev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0netif_stop_queue(netdev);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0jme_stop_irq(jme);
>=20
> -       tasklet_disable(&jme->txclean_task);
> -       tasklet_disable(&jme->rxclean_task);
> -       tasklet_disable(&jme->rxempty_task);
> +       disable_work_sync(&jme->txclean_bh_work);
> +       disable_work_sync(&jme->rxclean_bh_work);
> +       disable_work_sync(&jme->rxempty_bh_work);

should be:

	  jme->rxempty_bh_work_queued =3D disable_work_sync(&jme->rxempty_bh_work)=
;=09


>=20
> @@ -3198,9 +3200,10 @@ jme_suspend(struct device *dev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0jme->phylink =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>=20
> -       tasklet_enable(&jme->txclean_task);
> -       tasklet_enable(&jme->rxclean_task);
> -       tasklet_enable(&jme->rxempty_task);
> +       enable_and_queue_work(system_bh_wq, &jme->txclean_bh_work);
> +       enable_and_queue_work(system_bh_wq, &jme->rxclean_bh_work);
> +       jme->rxempty_bh_work_queued =3D true;
> +       enable_and_queue_work(system_bh_wq, &jme->rxempty_bh_work);

should be:

	if (jme->rxempty_bh_work_queued)
        	enable_and_queue_work(system_bh_wq, &jme->rxempty_bh_work);
	else
		enable_work(system_bh_wq, &jme->rxempty_bh_work);

I think the above ones are the only places where you need to touch
'rxempty_bh_work_queued'.


[...]
> =C2=A0=C2=A0Do we need a flag for rxclean and txclean too?

Functionally speaking I don't think it will be necessary, as
rxclean_bh_work() and txclean_bh_work() don't emit warnings on spurious
invocation.

Thanks,

Paolo



