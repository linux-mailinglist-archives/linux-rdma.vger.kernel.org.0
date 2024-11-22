Return-Path: <linux-rdma+bounces-6072-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEC89D5FE2
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 14:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 797D0B248E1
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 13:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544FF2AE93;
	Fri, 22 Nov 2024 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dGkzOYWj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A511CA9C
	for <linux-rdma@vger.kernel.org>; Fri, 22 Nov 2024 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732283166; cv=none; b=bwlBuEfsB1Zqjcuz/EIGSMHZysqUh1jbz3NlUmUHMml7BdTAtIar7/cInun/5lr5s4wla585pXMX8VqPhXAVcqV29s2fLQ/R2OZ1ay1fATHv39wkcvJK8FabntLLlTz6kYhwFLaNPdMTWdxabdm3EN1e/a9mvBrcg+vVkSP/rho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732283166; c=relaxed/simple;
	bh=g4+aWKCVeW6BOU349A2+d9XXg0NyZX4n5ovhjyAicWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJUJ6KvqJi/vO/Tg1uPf9/2U6EG0QEGO8NtcQHeuQGqOJx7pUbdsftFnWpeB9x3Ocxqdd4+KQc5bc1rYNUpxXTENZk6ECLTc2Fq49jHlxM2pZd6AdpgZmo613+/vKUwgUpPlNHoCWf5qpWYu1ly1p9t8Eb3h10hmzgqwZNDucvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dGkzOYWj; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38232c6311fso1472663f8f.3
        for <linux-rdma@vger.kernel.org>; Fri, 22 Nov 2024 05:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732283162; x=1732887962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wtwdUdechqydhagfX3wqbY8b+3dtHo5Gk73m96iUg24=;
        b=dGkzOYWjLyoX3QJLFK5LcZEctrEvMot9LjnqOXpb2pvOjOipjD/pVcUL+QmttU8ybH
         hQ8AI4XwKJY2gThVtR1MIf9zfzhMECUHVdWUVnJz1DcbcjDfOJ3htOWIdVjhV5Ust6FR
         KiD3BRNhVgDb4k/lsyf9ChB2yJcv4UZZUd4dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732283162; x=1732887962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtwdUdechqydhagfX3wqbY8b+3dtHo5Gk73m96iUg24=;
        b=FiI3Z/EyoyybVfk3PW/bcw0A78xOIWkVDwSTXiwPx1PySPRObAGVMwMgtViLwn8dEx
         Sln7WgrVoy9HJhAjlYIMqTSJ/ZlZZd8tO1bzIIPLQyJq/2V98RdqcsN9VAIwNPGc/cgi
         GBHWRJfXLzRBEnAL7nmnVwCT1/PaEI0luOf/wQrGPFDfAvxKbQWghCNMOsBNbBTz//jK
         81DJZ8h1LFup17rWcS2mZXUwOycb2GyjFnALzhhXoxOla8EKbaeLg5Al0f83fyYcqbrL
         Qqeyizg3dYmqtmHbdoo8MG7osEZjFNecQwiTrvokog1CTu6XY6U8XcNXgQdLtslP4dVN
         dsAw==
X-Forwarded-Encrypted: i=1; AJvYcCUqX/h24P9dW6FwTgMniw+5+G/qrilsCcU9KK3n/6ZfEEv4hvVfI200cyRRfxKnu7XZ3ckUEN6FoUFr@vger.kernel.org
X-Gm-Message-State: AOJu0YxDryFq+vXrONJvAm5p1Gk4pLTQKBam0uozPaTVH+TxQihwcksM
	ipRFuxFWyDM0xNVEWzji7PF+6xcNhCibO0acN706P+40arSHRiChw/faLAsN+VTqOzokQNRCk3F
	vFd2rSKycx+pB7K9IYLDK2D7wr/jq/NLK3L2l
X-Gm-Gg: ASbGncsNeQzWx3orYflL+cMZyrzSUTp387UfpeDH6u5kEXimjAxuz9tk4/wM+IRnV9l
	Sn6pIJNgQbMJldvD5IVHBP/1bhx1nog==
X-Google-Smtp-Source: AGHT+IFJEMIY7K1oIwCm/zagwlX5eMr5wOT3vUOcn9jZmsTuL1zw/4tPrbpKeFtbPt5BMxFCPEXh6L8VYfqJUoHbPII=
X-Received: by 2002:a05:6000:42c6:b0:382:4b6b:bcfd with SMTP id
 ffacd0b85a97d-38260b999a8mr1924318f8f.33.1732283161552; Fri, 22 Nov 2024
 05:46:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112134956.1415343-1-mheib@redhat.com> <20241114100413.GA499069@unreal>
 <CA+sbYW1cp17tH-p8ffjtgBecyMP_fECmes9RN9Bj=bdNPD_W2g@mail.gmail.com>
 <20241114114521.GF499069@unreal> <CA+sbYW13g5f-CW=QEt-SKtpssw1=Qbqp6d=055a=v5N-r2C9sA@mail.gmail.com>
 <Z0CGDwp32NDOsweB@fedora>
In-Reply-To: <Z0CGDwp32NDOsweB@fedora>
From: Kashyap Desai <kashyap.desai@broadcom.com>
Date: Fri, 22 Nov 2024 19:15:10 +0530
Message-ID: <CAHsXFKEVkwjOsjdnmzsv5jZNJD83jKBbSXsJgenP+7a=f0kcsQ@mail.gmail.com>
Subject: Re: [PATCH rdma] RDMA/bnxt_re: cmds completions handler avoid
 accessing invalid memeory
To: Mohammad Heib <mheib@redhat.com>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>, Leon Romanovsky <leon@kernel.org>, 
	linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000088d6040627809abd"

--00000000000088d6040627809abd
Content-Type: multipart/alternative; boundary="0000000000007ee5160627809a10"

--0000000000007ee5160627809a10
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

We will work with Redhat for final go.

For now this patch is on hold and not urgent.

Leon,

Hold this discussion for now.


Kashyap

On Fri, 22 Nov 2024, 18:54 Mohammad Heib, <mheib@redhat.com> wrote:

> On Sat, Nov 16, 2024 at 01:33:13PM +0530, Selvin Xavier wrote:
> > On Thu, Nov 14, 2024 at 5:15=E2=80=AFPM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > On Thu, Nov 14, 2024 at 03:37:30PM +0530, Selvin Xavier wrote:
> > > > On Thu, Nov 14, 2024 at 3:34=E2=80=AFPM Leon Romanovsky <leon@kerne=
l.org>
> wrote:
> > > > >
> > > > > On Tue, Nov 12, 2024 at 03:49:56PM +0200, Mohammad Heib wrote:
> > > > > > If bnxt FW behaves unexpectedly because of FW bug or unexpected
> behavior it
> > > > > > can send completions for old  cookies that have already been
> handled by the
> > > > > > bnxt driver. If that old cookie was associated with an old
> calling context
> > > > > > the driver will try to access that caller memory again because
> the driver
> > > > > > never clean the is_waiter_alive flag after the caller
> successfully complete
> > > > > > waiting, and this access will cause the following kernel panic:
> > > > > >
> > > > > > Call Trace:
> > > > > >  <IRQ>
> > > > > >  ? __die+0x20/0x70
> > > > > >  ? page_fault_oops+0x75/0x170
> > > > > >  ? exc_page_fault+0xaa/0x140
> > > > > >  ? asm_exc_page_fault+0x22/0x30
> > > > > >  ? bnxt_qplib_process_qp_event.isra.0+0x20c/0x3a0 [bnxt_re]
> > > > > >  ? srso_return_thunk+0x5/0x5f
> > > > > >  ? __wake_up_common+0x78/0xa0
> > > > > >  ? srso_return_thunk+0x5/0x5f
> > > > > >  bnxt_qplib_service_creq+0x18d/0x250 [bnxt_re]
> > > > > >  tasklet_action_common+0xac/0x210
> > > > > >  handle_softirqs+0xd3/0x2b0
> > > > > >  __irq_exit_rcu+0x9b/0xc0
> > > > > >  common_interrupt+0x7f/0xa0
> > > > > >  </IRQ>
> > > > > >  <TASK>
> > > > > >
> > > > > > To avoid the above unexpected behavior clear the is_waiter_aliv=
e
> flag
> > > > > > every time the caller finishes waiting for a completion.
> > Mohammad,
> >  We were trying to see the possibility. FW shouldn't be giving an old
> > cookie. One possibility
> > could be if FW crashes and we are in the recovery routine.
> > Adding this check is okay, but may be hiding some other error.
> > Is it possible to share your test scripts to repro this problem? Also,
> > can you share
> > the vmcore-demsg also
> >
> > Thanks
> > Selvin
> >
> I have sent you all the needed data in a separate email.
> Thanks,
> >
> > > > > >
> > > > > > Fixes: 691eb7c6110f ("RDMA/bnxt_re: handle command completions
> after driver detect a timedout")
> > > > > > Signed-off-by: Mohammad Heib <mheib@redhat.com>
> > > > > > ---
> > > > > >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 16 ++++++++------=
--
> > > > > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > > > >
> > > > > Selvin?
> > > > Someone is confirming the fix. Will ack in a day. Thanks
> > >
> > > Thanks
>
>
>

--0000000000007ee5160627809a10
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi All,=C2=A0<div dir=3D"auto"><br></div><div dir=3D"auto=
">We will work with Redhat for final go.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">For now this patch is on hold and not urgent.</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Leon,=C2=A0</div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Hold this discussion for now.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto">Kashyap</div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Fri, 22 Nov 2024, 18:54 Mohammad Heib, &lt;<a href=3D"mailto:mheib@redhat=
.com">mheib@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">On Sat, Nov 16, 2024 at 01:33:13PM +0530, Selvin Xavier wrote:<br>
&gt; On Thu, Nov 14, 2024 at 5:15=E2=80=AFPM Leon Romanovsky &lt;<a href=3D=
"mailto:leon@kernel.org" target=3D"_blank" rel=3D"noreferrer">leon@kernel.o=
rg</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; On Thu, Nov 14, 2024 at 03:37:30PM +0530, Selvin Xavier wrote:<br=
>
&gt; &gt; &gt; On Thu, Nov 14, 2024 at 3:34=E2=80=AFPM Leon Romanovsky &lt;=
<a href=3D"mailto:leon@kernel.org" target=3D"_blank" rel=3D"noreferrer">leo=
n@kernel.org</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Tue, Nov 12, 2024 at 03:49:56PM +0200, Mohammad Heib=
 wrote:<br>
&gt; &gt; &gt; &gt; &gt; If bnxt FW behaves unexpectedly because of FW bug =
or unexpected behavior it<br>
&gt; &gt; &gt; &gt; &gt; can send completions for old=C2=A0 cookies that ha=
ve already been handled by the<br>
&gt; &gt; &gt; &gt; &gt; bnxt driver. If that old cookie was associated wit=
h an old calling context<br>
&gt; &gt; &gt; &gt; &gt; the driver will try to access that caller memory a=
gain because the driver<br>
&gt; &gt; &gt; &gt; &gt; never clean the is_waiter_alive flag after the cal=
ler successfully complete<br>
&gt; &gt; &gt; &gt; &gt; waiting, and this access will cause the following =
kernel panic:<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Call Trace:<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 &lt;IRQ&gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 ? __die+0x20/0x70<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 ? page_fault_oops+0x75/0x170<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 ? exc_page_fault+0xaa/0x140<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 ? asm_exc_page_fault+0x22/0x30<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 ? bnxt_qplib_process_qp_event.isra.0+0x20c/0=
x3a0 [bnxt_re]<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 ? srso_return_thunk+0x5/0x5f<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 ? __wake_up_common+0x78/0xa0<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 ? srso_return_thunk+0x5/0x5f<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 bnxt_qplib_service_creq+0x18d/0x250 [bnxt_re=
]<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 tasklet_action_common+0xac/0x210<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 handle_softirqs+0xd3/0x2b0<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 __irq_exit_rcu+0x9b/0xc0<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 common_interrupt+0x7f/0xa0<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 &lt;/IRQ&gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 &lt;TASK&gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; To avoid the above unexpected behavior clear the i=
s_waiter_alive flag<br>
&gt; &gt; &gt; &gt; &gt; every time the caller finishes waiting for a compl=
etion.<br>
&gt; Mohammad,<br>
&gt;=C2=A0 We were trying to see the possibility. FW shouldn&#39;t be givin=
g an old<br>
&gt; cookie. One possibility<br>
&gt; could be if FW crashes and we are in the recovery routine.<br>
&gt; Adding this check is okay, but may be hiding some other error.<br>
&gt; Is it possible to share your test scripts to repro this problem? Also,=
<br>
&gt; can you share<br>
&gt; the vmcore-demsg also<br>
&gt; <br>
&gt; Thanks<br>
&gt; Selvin<br>
&gt; <br>
I have sent you all the needed data in a separate email. <br>
Thanks, <br>
&gt; <br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Fixes: 691eb7c6110f (&quot;RDMA/bnxt_re: handle co=
mmand completions after driver detect a timedout&quot;)<br>
&gt; &gt; &gt; &gt; &gt; Signed-off-by: Mohammad Heib &lt;<a href=3D"mailto=
:mheib@redhat.com" target=3D"_blank" rel=3D"noreferrer">mheib@redhat.com</a=
>&gt;<br>
&gt; &gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |=
 16 ++++++++--------<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 1 file changed, 8 insertions(+), 8 deletions=
(-)<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Selvin?<br>
&gt; &gt; &gt; Someone is confirming the fix. Will ack in a day. Thanks<br>
&gt; &gt;<br>
&gt; &gt; Thanks<br>
<br>
<br>
</blockquote></div>

--0000000000007ee5160627809a10--

--00000000000088d6040627809abd
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
//gyd5clTejfGxz7u6TjAKPT7G/PY9BaxKSEf8zLsYtlHAJMVeCFF20jzwQHb5/L+5h2CkPOrrSB
JSieWyW6UjDpmJdXnnM3sqAtuQHYoZ76TqNQWkummLSqMwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRprYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUuFb0TqXOZcrcNo5g7TmU
kbW0uVQwDQYJKoZIhvcNAQELBQADggEBAEpkK1pEFLXwM8dPS+Y+gSbbTOhzvfHfnB1tKMepSjVT
Sh0CvvfRgpBkaqZJv2+/9W5dfZejA+3xFc/G/lurpofq2yVp2Zik+RbO/FjpFfg24MHjkSr2foJm
RImddZVt810u7w3qtY2pQQ/QHCS9fHkLtz5dKfmePAebpPuX2BJ+FmPfFZyHLpLHr4CJwUU9ETgH
GRRQamqDhA+VgD34fZSymk33umJA6SDgqaX9pDs276nwbY0g8TSOZwohc/6eTzU0Gsl1jSuJezXm
/bctt3Fx6+DwYeO9905PrJUE+iBLLHPm5cHBNF9yWCy/FrP9ZMFvsUvcPiWyEWFPYhsVxAMxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwQyr9ygXXwrg7q
ph4wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGo8KcUZK3av6J/+vD6hr0dbcNyN
qibfbs+ixXWtbWmIMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MTEyMjEzNDYwMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAAkt95ZLqSK+dX/rnuQ1/cuV6DjMm+uVVuKGCCuOE6yEgA
oEv0ehlZ1JJM9/Ty8ngq/wUVHMFlRmqXpKFNJsLavjsqb6eR8qR7z6NfKuL4MIQpHQeRWU+5JkQZ
xJmdxAO+KW7zGMysJV4D3Qgiyi5i2ZeKs2m7Dg7ONm0eK1dRl4OFnUPiAtokncxp7zxOGIwSrW8W
y63qLQQ9uczapBGl7+ujrF/GyYzbNBpUxEPXLXd3f+EDhk9iNmZBGbgIg/gf3xflFmawDOCkgWV+
VjfKGI/4xlB8R3tPLA2rzasTbOj9B+0YvwFWyBNDMcR3Xk6MI6z0zixaoX+Z0Rz5MEpI
--00000000000088d6040627809abd--

