Return-Path: <linux-rdma+bounces-15568-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07299D2213A
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 03:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 362DE301E9BE
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 02:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DCD218ACC;
	Thu, 15 Jan 2026 02:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9z8iLqp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B49919E96D
	for <linux-rdma@vger.kernel.org>; Thu, 15 Jan 2026 02:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768442498; cv=none; b=u5Qk1YVwJddBj5SgR8ZIR/HVnZfq6S9bi6dru7N1S/A4Q602JswK9YitBYhuyVuHNxb5mCjYFtmKqVU5AbpPmOEpP/0mATYPvp0bAqHITXhlsn8dlL0Llq0IvrV7vqKaUsGxppsQWYAcJTlmTxGUA0xP6SD8yYoRWAGAwJ1o3NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768442498; c=relaxed/simple;
	bh=DkVv3ggPA/6N7/ir/fzJJuTkTVceOMxCAOgDYhUF5P0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPqK+dj/Jg7r2pIXdhLAu+cBuo2ImUyxZHyxHYK0RByTSlSRQo7ZBYaFapDSI7+XK481kwXw+msutDw4PcExIwkE35v3W3kPJBE3kWPzd/o00ogs9QGR0vMdoq5aSjYbsBtaHENiDeww02cuhmiyGthm0pkH2q/iP7sXwPLqZDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9z8iLqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A6CC19424
	for <linux-rdma@vger.kernel.org>; Thu, 15 Jan 2026 02:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768442497;
	bh=DkVv3ggPA/6N7/ir/fzJJuTkTVceOMxCAOgDYhUF5P0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c9z8iLqpwIdQWJ8QIKm6ytf8a4iHzOqfpkkmFjUega5KKE04PLbDVehATuR0KatG+
	 jcAYhfOW3Hcbg0r0pdTpeHGofQ6qD2zQxvp+OCGoYOcqwJeePnxOUMvLTDODGcBHpl
	 45EPtEFMJiZ3on2bG83fAi1aBOG1A2uommo7/elCT593Ip12Ls5/iA6WCRXMDQhyvj
	 ptPqWyvyU9UdOY9jeE4xgt3cmFtqaPss6PcZYuI5gLepYSLNZVsFHIQo3jteOGomJl
	 Jk0TxiURwuh8xf2jBiIYPVEykZ4sTC7aBXOVZ3uCOEzUiDzk42ekDIQ7FUiFzFXqQt
	 Ajh4ewB1MJNXA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b87003e998bso257062966b.1
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 18:01:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6YeN8Xj2qiKyERCIu468u4Ikm0X41MUtodqSF1iYfgLfKd4w3Vq6iArXTFJwCYSzvlPb4usUuWE09@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyg7u1QUd+jCdf2NibzHyu3wK6CzdwkeSnl6xc2l2jjowLS8bK
	rbF3GZbiSwHEEcWF4wfzvM7QNU45IZLvUsxKhDq7Xyxwqmqn1CMV3SjdbOZSQ65LZ6Iaa5DrShk
	EohGfI/oz1w+2SitAHj3+y/DgMYdV624=
X-Received: by 2002:a17:907:96a7:b0:b87:e76:67a5 with SMTP id
 a640c23a62f3a-b8777c1a984mr130471266b.24.1768442496411; Wed, 14 Jan 2026
 18:01:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <35eec2e6-bf37-43d6-a2d8-7a939a68021b@samba.org>
 <CAKYAXd9p=7BzmSSKi5n41OKkkw4qrr4cWpWet7rUfC+VT-6h1g@mail.gmail.com>
 <f59e0dc7-e91c-4a13-8d49-fe183c10b6f4@samba.org> <CAKYAXd-MF1j+CkbWakFJK2ov_SfRUXaRuT6jE0uHZoLxTu130Q@mail.gmail.com>
 <CAKYAXd__T=L9aWwOuY7Z8fJgMf404=KQ2dTpNRd3mq9dnYCxRw@mail.gmail.com>
 <86b3c222-d765-4a6c-bb79-915609fa3d27@samba.org> <a3760b26-7458-40a0-ae79-bb94dd0e1d01@samba.org>
 <3c0c9728-6601-41f1-892f-469e83dd7f19@samba.org> <721eb7b1-dea9-4510-8531-05b2c95cb240@samba.org>
 <CAKYAXd-WTsVEyONDmOMbKseyAp29q71KiUPwGDp2L_a53oL0vg@mail.gmail.com>
 <183d92a0-6478-41bb-acb3-ccefd664d62f@samba.org> <ee6873d7-6e47-4d42-9822-cb55b2bfb79e@samba.org>
 <6a248fde-e0cd-489b-a640-d096fb458807@samba.org>
In-Reply-To: <6a248fde-e0cd-489b-a640-d096fb458807@samba.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 15 Jan 2026 11:01:23 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-42_fSHBL7iZbuOtYFKqKyhPS-4C+nqbX=-Djq5L6Okg@mail.gmail.com>
X-Gm-Features: AZwV_QiICHmZTgWfUa8HpPmEG2AIn5JtvyNQUfRqLhCdXNs6jRjKxnX9Ow3akaM
Message-ID: <CAKYAXd-42_fSHBL7iZbuOtYFKqKyhPS-4C+nqbX=-Djq5L6Okg@mail.gmail.com>
Subject: Re: Problem with smbdirect rw credits and initiator_depth
To: Stefan Metzmacher <metze@samba.org>
Cc: Tom Talpey <tom@talpey.com>, 
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 3:13=E2=80=AFAM Stefan Metzmacher <metze@samba.org>=
 wrote:
>
> Am 15.12.25 um 21:17 schrieb Stefan Metzmacher:
> > Am 14.12.25 um 23:56 schrieb Stefan Metzmacher:
> >> Am 13.12.25 um 03:14 schrieb Namjae Jeon:
> >>>> I've put these changes a long with rw credit fixes into my
> >>>> for-6.18/ksmbd-smbdirect-regression-v4 branch, are you able to
> >>>> test this?
> >>> Problems still occur. See:
> >>
> >> :-( Would you be able to use rxe and cake a network capture?
> >>
> >> Using test files with all zeros, e.g.
> >> dd if=3D/dev/zero of=3D/tmp/4096MBzeros-sparse.dat seek=3D4096MB bs=3D=
1 count=3D1
> >> would allow gzip --best on the capture file to compress well...
> >
> > I think I found something that explains it and
> > I was able to reproduce and what I have in mind.
> >
> > We increment recv_io.posted.count after ib_post_recv()
> >
> > And manage_credits_prior_sending() uses
> >
> > new_credits =3D recv_io.posted.count - recv_io.credits.count
> >
> > But there is a race between the hardware receiving a message
> > and recv_done being called in order to decrement recv_io.posted.count
> > again. During that race manage_credits_prior_sending() might grant
> > too much credits.
> >
> > Please test my for-6.18/ksmbd-smbdirect-regression-v5 branch,
> > I haven't tested this branch yet, I'm running out of time
> > for the day.
> >
> > But I tested it with smbclient and having a similar
> > logic in fs/smb/common/smbdirect/smbdirect_connection.c
>
> I was able to reproduce the problem and the fix I created
> for-6.18/ksmbd-smbdirect-regression-v5 was not correct.
>
> I needed to use
>
> available =3D atomic_xchg(&sc->recv_io.credits.available, 0);
>
> instead of
>
> available =3D atomic_read(&sc->recv_io.credits.available);
> atomic_sub(new_credits, &sc->recv_io.credits.available);
>
> This following branch works for me:
> for-6.18/ksmbd-smbdirect-regression-v7
> and with the fixes again master this should also work:
> for-6.19/ksmbd-smbdirect-regression-v1
>
> I'll post real patches tomorrow.
>
> Please check.
Okay, I will test it with two branches.
I'll try it too, but I recommend running frametest for performance
difference and stress testing.

https://support.dvsus.com/hc/en-us/articles/212925466-How-to-use-frametest

ex) frametest.exe -w 4k -t 20 -n 2000

Thanks.
>
> Thanks!
> metze
>

