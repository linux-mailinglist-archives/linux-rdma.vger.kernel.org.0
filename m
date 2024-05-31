Return-Path: <linux-rdma+bounces-2740-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2A08D6AC8
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 22:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B399CB25582
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 20:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC38717C7BD;
	Fri, 31 May 2024 20:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEzLN/gu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2346A219FD;
	Fri, 31 May 2024 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717187742; cv=none; b=r5TXm8hFAOFog/sewe1bQ/QdzYRo7g46mf7A/tP3M8mzimUbi9eYU+VwHr27pVhd9+Uh2rtraz1AseLbT8AEMv+XykRBqpHSRfAyHWjbOAQbd0Gu9UyOqMTe3/pOIV6JVF9SnS3C4gXd2fcYGJgoCFDrVTehqbXFUD6d5oPsVRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717187742; c=relaxed/simple;
	bh=0CmcRHniS6CcUIkLP1yl6718VzBuj0z6wHS7QPZ0Acw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tinn53fBJObyIT4y7vxRtkiJTFV5MYVqu0G8zEcqzSNYrEmULYMOaoby3FxRCWw6FyRvRAeYvqIqa3zfBNyLo01+skohV3+P6FBRm67mL4GRWGIxwZXXM5/QlOPsHvj9zLGDNlfRuQy3Js7ck2EpAj+HqghqOdlvk4OAM9MlMVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEzLN/gu; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52962423ed8so2928610e87.2;
        Fri, 31 May 2024 13:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717187739; x=1717792539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3bObn2HYdzZsPQsK/+7bsdRUNbYSCHbt5PS/gQ/0a4=;
        b=GEzLN/gu2cl415/0yipXa4+D3pJ0fnK43RmwfHoVD2d3eQWpQRF12rPr7iUfd9CiBU
         RxkueTzVUhePsQktV2aEnc9fF59n87Yl4qtMgQjLrF2yB95PzPpTlctua9maZTQVTLLj
         i93kacccUnUH9RiKNgvbt2zp8x75YN9VXouQz375rWhyOmFaIL07HdOTOYY7/j96EGSy
         JHAaSuxHB8DmAlRAK81vkraETWrcl0W+TWRHobKlu63NpFAgP8jpPkzk52GnXqVG4T/B
         UFMEnPLvrLwCm/sUW0a88ro1RCvxZlWE/uRiRDLo8KP0QIc2FQLCrV3XV5kbIsg1Nl/L
         pytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717187739; x=1717792539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3bObn2HYdzZsPQsK/+7bsdRUNbYSCHbt5PS/gQ/0a4=;
        b=va613aViuEAdZN/M9gppKRxRawtqhyY1a708nGiefrwB5uupJz7jq6xLDRs2qffQB8
         j7IjlLf1abOIa7ZbwDIh+uDvIxAyp4D/D6A7XtIYQQAhTTqUimPayxLg1YcAcFQOIyQL
         NJvJuGQp5HurHr3zcv2t+8wjp9AqFn4ckmWBeIk3sQtf+48cfOYh4d1eWjZyC6gMrv31
         OMtbNuOt2k+xyL6/wWRklnLySMiW8dw8ClPaOGp/5rtMZ9t036IO2HfkjcWQJdBSDKCZ
         HEI6fI67RiXjl6x6OMRM/t8UvtoJj64w7qhkL/Ts9uQfwOoV4f28HNAKJw4Nelzclina
         gSDA==
X-Forwarded-Encrypted: i=1; AJvYcCWxHmx5Od2vGJ7PaE3JGdn1EyZoAu0GbLnC3OMg9L38ER0y/ssKomRCwxCcSMz1s6sh7/6TxYzYwSsdPdMDGynL7WOpdIIsTQatb7CnJxLMv6oNZR+yAkKI/mhq5yzf42Zba4KsfezSuTZQaR7Ouk7c/79HnrmC04qsQJeSdqUzerOPcQ==
X-Gm-Message-State: AOJu0YwHCvfOmq+aP99GfIHSSWY/2zVB1nGUuQWs6wYXVsdfsEecfWgB
	s95ITWi/KIy6jXSgazPyJO9zvpn1YqbhFq3CCQrGt0Fx7Hibvf1hwfe3SOLvMUfc0yWEkKUwC3h
	1eIsAaf7jPMwSIdrecx2XvwM6VP0=
X-Google-Smtp-Source: AGHT+IEPEZTe85ma2n710NtfCYlQmJCM/+/sKx/9xMzB3Wn5S/worLuBz06Zmk2YjdZw5BwQykOfkrxtin/JB3RMFkI=
X-Received: by 2002:a05:6512:3d10:b0:52b:851e:256 with SMTP id
 2adb3069b0e04-52b8956960bmr2274835e87.2.1717187739001; Fri, 31 May 2024
 13:35:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <wnucs5oboi4flje5yvtea7puvn6zzztcnlrfz3lpzlwgblrxgw@7wvqdzioejgl>
 <6cd21274-50b3-44c5-af48-179cbd08b1ba@linux.dev> <b29f3a7a-3d58-44e1-b4ab-dbb4420c04a9@acm.org>
 <CAD=hENdBGcBSzcaniH+En6gecpay7S-fm1foEg5vmuXiVYxhpQ@mail.gmail.com> <0a82785a-a417-4f53-8f3a-2a9ad3ab3bf7@acm.org>
In-Reply-To: <0a82785a-a417-4f53-8f3a-2a9ad3ab3bf7@acm.org>
From: Zhu Yanjun <zyjzyj2000@gmail.com>
Date: Fri, 31 May 2024 22:35:28 +0200
Message-ID: <CAD=hENdgS40CmZs2o5M_O71k07Q7txg9-2XnaHP97_+eC9xT3w@mail.gmail.com>
Subject: Re: blktests failures with v6.10-rc1 kernel
To: Bart Van Assche <bvanassche@acm.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "nbd@other.debian.org" <nbd@other.debian.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 10:08=E2=80=AFPM Bart Van Assche <bvanassche@acm.or=
g> wrote:
>
> On 5/31/24 13:06, Zhu Yanjun wrote:
> > On Fri, May 31, 2024 at 10:01=E2=80=AFPM Bart Van Assche <bvanassche@ac=
m.org> wrote:
> >>
> >> On 5/31/24 07:35, Zhu Yanjun wrote:
> >>> IIRC, the problem with srp/002, 011 also occurs with siw driver, do y=
ou make
> >>> tests with siw driver to verify whether the problem with srp/002, 011=
 is also > fixed or not?
> >>
> >> I have not yet seen any failures of any of the SRP tests when using th=
e siw driver.
> >> What am I missing?
>  >
>  > (left out a bunch of forwarded emails)
>
> Forwarding emails is not useful, especially if these emails do not answer=
 the question
> that I asked.

Bob had made tests with siw. From his mail, it seems that the similar
problem also occurs with SIW.

It is up to you^_^

Zhu Yanjun

>
> Thanks,
>
> Bart.

