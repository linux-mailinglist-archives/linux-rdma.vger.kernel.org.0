Return-Path: <linux-rdma+bounces-15667-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 825E0D3933F
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jan 2026 09:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 039643004E14
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jan 2026 08:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDE527EFE9;
	Sun, 18 Jan 2026 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnOTzdUK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFC0238166
	for <linux-rdma@vger.kernel.org>; Sun, 18 Jan 2026 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768723394; cv=none; b=T75wszFgbVI1fa1JYOMa84oUDSMf54wBC33Z7qKOp8TIAJIVNgEA902Ct5sZ6A1nf0HhlGoA3rVfQl/HyEP8P/LL2l9fuD67R1YInQuW06O+vOPkkGDZ2TGBFY3evPnbwV8ztZw0weeoNsW9DUkYbH2iwE0ORdudrNGGDWgz8xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768723394; c=relaxed/simple;
	bh=iwqBFXkkKNeYDTBsbdcu8UTXT6pZ8J40BE6rF+0SMbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvRIh9ftKnWbAr0yYX69LixmQtm/MX8/sgYubNKsE0umkLQ8Z/Yc8t3I5He7x8awaYIGEXRl/p9+h4N0ojg5CVdAikvCdZ0JxSupHAz84pzGPAgnIfJc09umw1hQSDtCchHO43umPkMeCS6wHlUIw6h0TzkQtDZLUwoP2AySbJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnOTzdUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A59C19421
	for <linux-rdma@vger.kernel.org>; Sun, 18 Jan 2026 08:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768723394;
	bh=iwqBFXkkKNeYDTBsbdcu8UTXT6pZ8J40BE6rF+0SMbk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nnOTzdUKyXDMAK4bQEZq+zyrEozZkwwjdWhzkEUCydKGdpDyhCwpBcH7uKoYY+Wqw
	 paSngj/VmCqLWh92YggrrK5tkGQ04zzxnWtMYcU/Mj4Y4Yr/NCxJMowj1kFShbgemf
	 H5jnJ433hvbUdZ/0tcaYVox8tNB6Cn0MPXfabd0N+pLNgFGcJjTykTYBlar92OaJt5
	 OmUUhsTZHGjRLfTOavAeAt1qFJ9W0yq+yS2nQt68NvApQ9/Sg+3LVJGD/Ko9bFeSX6
	 ivVqgOA1KBW9HIjThLJdTDFgg2IxISue5AoN+XKh0HYh2ALDakWXBcxZVcxXZ4YI8T
	 rZMCwiAv+MQdw==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64d30dc4ed7so6357150a12.0
        for <linux-rdma@vger.kernel.org>; Sun, 18 Jan 2026 00:03:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWPuyuceZxzJ+/rNlOm5nJpbl/qAWMylJOXo2DEs0ku8viCMH+vZoYg8hbXeOm6kE0uW85cFONp+Li@vger.kernel.org
X-Gm-Message-State: AOJu0YzcxYVrxtYdq+Vap/3r26w8TB+BlpyvafTX5XNy9e0UtQYFq2G7
	/IsxKkWpcfYsbixqceRcx3rxGBUaw1T0fx+LYdjxKiuA1vtxNP3W3sAnUfP0v7FYeZM3UPG37ux
	bmpWr4Rc/boUHpi3riaoawINZCh5xglk=
X-Received: by 2002:a05:6402:3593:b0:64b:4f44:60ef with SMTP id
 4fb4d7f45d1cf-65452bcc0b8mr5604147a12.27.1768723392526; Sun, 18 Jan 2026
 00:03:12 -0800 (PST)
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
 <6a248fde-e0cd-489b-a640-d096fb458807@samba.org> <CAKYAXd-42_fSHBL7iZbuOtYFKqKyhPS-4C+nqbX=-Djq5L6Okg@mail.gmail.com>
 <b58fa352-2386-4145-b42e-9b4b1d484e17@samba.org> <8b4cc986-cf06-42a9-ab5d-8b35615fa809@samba.org>
 <84554ae8-574c-4476-88df-ed9cfcc347f5@samba.org>
In-Reply-To: <84554ae8-574c-4476-88df-ed9cfcc347f5@samba.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 18 Jan 2026 17:03:00 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8np_b1RUkPQj2pz6=F5dciDLooES-gZVkSMSrbWRjWSQ@mail.gmail.com>
X-Gm-Features: AZwV_QhvxQz3D66iFDyaL3Mtpncmh0yjlPaMihISNjo8nO1RH1EMyXI1yk_vnig
Message-ID: <CAKYAXd8np_b1RUkPQj2pz6=F5dciDLooES-gZVkSMSrbWRjWSQ@mail.gmail.com>
Subject: Re: Problem with smbdirect rw credits and initiator_depth
To: Stefan Metzmacher <metze@samba.org>
Cc: Tom Talpey <tom@talpey.com>, 
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 17, 2026 at 10:15=E2=80=AFPM Stefan Metzmacher <metze@samba.org=
> wrote:
>
> Am 17.01.26 um 00:08 schrieb Stefan Metzmacher:
> > Am 15.01.26 um 10:50 schrieb Stefan Metzmacher:
> >> Am 15.01.26 um 03:01 schrieb Namjae Jeon:
> >>> On Thu, Jan 15, 2026 at 3:13=E2=80=AFAM Stefan Metzmacher <metze@samb=
a.org> wrote:
> >>>>
> >>>> Am 15.12.25 um 21:17 schrieb Stefan Metzmacher:
> >>>>> Am 14.12.25 um 23:56 schrieb Stefan Metzmacher:
> >>>>>> Am 13.12.25 um 03:14 schrieb Namjae Jeon:
> >>>>>>>> I've put these changes a long with rw credit fixes into my
> >>>>>>>> for-6.18/ksmbd-smbdirect-regression-v4 branch, are you able to
> >>>>>>>> test this?
> >>>>>>> Problems still occur. See:
> >>>>>>
> >>>>>> :-( Would you be able to use rxe and cake a network capture?
> >>>>>>
> >>>>>> Using test files with all zeros, e.g.
> >>>>>> dd if=3D/dev/zero of=3D/tmp/4096MBzeros-sparse.dat seek=3D4096MB b=
s=3D1 count=3D1
> >>>>>> would allow gzip --best on the capture file to compress well...
> >>>>>
> >>>>> I think I found something that explains it and
> >>>>> I was able to reproduce and what I have in mind.
> >>>>>
> >>>>> We increment recv_io.posted.count after ib_post_recv()
> >>>>>
> >>>>> And manage_credits_prior_sending() uses
> >>>>>
> >>>>> new_credits =3D recv_io.posted.count - recv_io.credits.count
> >>>>>
> >>>>> But there is a race between the hardware receiving a message
> >>>>> and recv_done being called in order to decrement recv_io.posted.cou=
nt
> >>>>> again. During that race manage_credits_prior_sending() might grant
> >>>>> too much credits.
> >>>>>
> >>>>> Please test my for-6.18/ksmbd-smbdirect-regression-v5 branch,
> >>>>> I haven't tested this branch yet, I'm running out of time
> >>>>> for the day.
> >>>>>
> >>>>> But I tested it with smbclient and having a similar
> >>>>> logic in fs/smb/common/smbdirect/smbdirect_connection.c
> >>>>
> >>>> I was able to reproduce the problem and the fix I created
> >>>> for-6.18/ksmbd-smbdirect-regression-v5 was not correct.
> >>>>
> >>>> I needed to use
> >>>>
> >>>> available =3D atomic_xchg(&sc->recv_io.credits.available, 0);
> >>>>
> >>>> instead of
> >>>>
> >>>> available =3D atomic_read(&sc->recv_io.credits.available);
> >>>> atomic_sub(new_credits, &sc->recv_io.credits.available);
> >>>>
> >>>> This following branch works for me:
> >>>> for-6.18/ksmbd-smbdirect-regression-v7
> >>>> and with the fixes again master this should also work:
> >>>> for-6.19/ksmbd-smbdirect-regression-v1
> >>>>
> >>>> I'll post real patches tomorrow.
> >>>>
> >>>> Please check.
> >>> Okay, I will test it with two branches.
> >>> I'll try it too, but I recommend running frametest for performance
> >>> difference and stress testing.
> >>>
> >>> https://support.dvsus.com/hc/en-us/articles/212925466-How-to-use-fram=
etest
> >>>
> >>> ex) frametest.exe -w 4k -t 20 -n 2000
> >>
> >> That works fine, but
> >>
> >>   frametest.exe -r 4k -t 20 -n 2000
> >>
> >> generates a continues stream of such messages:
> >> ksmbd: Failed to send message: -107
> >>
> >> Both with 6.17.2 and for-6.19/ksmbd-smbdirect-regression-v1,
> >> so this is not a regression.
> >>
> >> I'll now check if the is related to the other problems
> >> I found and fixes in for-6.18/ksmbd-smbdirect-regression-v5
> >
> > Ok, I found the problem.
> >
> > On send we are not allowed to consume the last send credit
> > without granting any credit to the peer.
> >
> >      MS-SMBD 3.1.5.1 Sending Upper Layer Messages
> >
> >      ...
> >      If Connection.SendCredits is 1 and the CreditsGranted field of the=
 message is 0, stop
> >      processing.
> >      ...
> >
> >      MS-SMBD 3.1.5.9 Managing Credits Prior to Sending
> >
> >      ...
> >      If Connection.ReceiveCredits is zero, or if Connection.SendCredits=
 is one and the
> >      Connection.SendQueue is not empty, the sender MUST allocate and po=
st at least one receive of size
> >      Connection.MaxReceiveSize and MUST increment Connection.ReceiveCre=
dits by the number
> >      allocated and posted. If no receives are posted, the processing MU=
ST return a value of zero to indicate
> >      to the caller that no Send message can be currently performed.
> >      ...
> >
> > It works in my master-ipproto-smbdirect branch, see the top commit.
> >
> > I'll backport the related logic to ksmbd on top of
> > for-6.19/ksmbd-smbdirect-regression-v1 tomorrow.
>
> for-6.19/ksmbd-smbdirect-regression-v2 has the fixes and works for
> me, I'll prepare official patches (most likely) on Monday.
I have tested the for-6.19/ksmbd-smbdirect-regression-v2 branch, and I
can confirm that the issues I previously encountered in my test
environment have been fixed.
I have a couple of follow-up questions regarding this fix:
1. Regarding your frametest results, did you not observe any
performance degradation or difference compared to linux-6.17.9?
2. You mentioned previously testing with Intel E810-CQDA2 NICs. Have
you tested both iWARP and RoCEv2 modes on the E810?

Thanks.
>
> metze
>
>

