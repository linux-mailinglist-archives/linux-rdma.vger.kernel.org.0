Return-Path: <linux-rdma+bounces-6011-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743269CFD2B
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Nov 2024 09:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32405287E78
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Nov 2024 08:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E6818F2FC;
	Sat, 16 Nov 2024 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e+l2kQyu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1825EB64A
	for <linux-rdma@vger.kernel.org>; Sat, 16 Nov 2024 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731744208; cv=none; b=q+Cghiih8gdNBLtZDikCfnRhwCmZn3oPaFtKfHv+hsb3WsQqNOIVXdiJIoC4RMrsF+EXQyeeYBSbUec0C3odQHQuaEm2Nn26w9u2I4KHB/Ktd7uwIROAN8/96tZbaVYFQZ8+JIFACjvMOw2h6Uut8rdWbgEqy0vBmbWKemAo/hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731744208; c=relaxed/simple;
	bh=QjLxkHDsM/W+JUt7e32Hr14XRSm3DWoDadvK+hVt8/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDjIooiOJqFvDU1TKCoIOT//SuXVCl9XA+uqi2XPuMBPwJaO1uN6lwTgNZc5VRHU98lCOalChzcwv/PRhpjh313VSpwCgCCGutvvAUnKT84BEmoQMGqFdpsR0h2EUt+h7vPwrzO1H14nN0W7r5HM1hZSb3iC3iUT1kGzUwMnJ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e+l2kQyu; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e3839177651so1103908276.3
        for <linux-rdma@vger.kernel.org>; Sat, 16 Nov 2024 00:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731744205; x=1732349005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx00ZHsLVeUY4t2HQj7NNiF3Xb5UukXiuk3sO1e24C8=;
        b=e+l2kQyu2jZVabA7PeSGsaWj8pE2Dw67xNNB3OjIzDAG/7W6AmZvp1E2jTBvX3zFVx
         Lf8im/tg+C8ZtkSvdZIAypKcoZ8kXMYWC64UxZl9NdKvY+OC06jn7MSNdALM8ROd2M0Z
         b2k8dkm2PqAS/kMwBMba2ojJlgic0J/nRzJ8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731744205; x=1732349005;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cx00ZHsLVeUY4t2HQj7NNiF3Xb5UukXiuk3sO1e24C8=;
        b=HwHn5w5iVo0y/6kp4v4B+ihlWUiroXSh2qvMKfGPDO5jlauex4G1jrQ6eUuPbykYkQ
         qnj/ApqqcpF+Bak9uUf37u3/LvqqPncioOUwRp5gX6ogX3N7I5hPOAT2GUI8ETgXv9nP
         Y2AUZhRXsSy6tJNYPe+JITgYOHxfnMgfUICuVfeFFhXq0RcvarIaVmVCHQq1zgkUlnJ7
         Ojl1d+MlePwJi0c21STIoGWPtEkw3O51MzqgErwwx3NFiMAM3nn87UcjCxlu3tDbmnww
         QKHo4d5JMEIzEj2hXbalF4tMRJ2QOOpL0KvGfYPu25grihTX3mL70gKGPY/fIXP0YCoR
         n7iw==
X-Forwarded-Encrypted: i=1; AJvYcCUOUu6sAvpeKDTUV2XgwVzVPp6JaBJUP22mUrmOddISUitn5gJ6VHyrtVngEAk7ewL5z0Wii6UrMZRg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9/0+9tep66BzFUCiNKPacnKUpRoXXn3pJMi0IasQ0X2Axy3/q
	vNMdm/jyzik2nhrobE24rIQSevaV+MMM1rfqfdzyFkFjcneM9OZwhljZmb8P06+luezR1mpjIBr
	2mxpe/8nOTQQcZLaVdL/Wb5G6XRq/DGvfWTEl
X-Google-Smtp-Source: AGHT+IGqfLBVOTUF58s0Mm8kzx+7Qv7rB3O0EPNYNoFhhs/aV0AchZ5Veq7ddoO291mzAoa9gXaRJbp5W6MDWXr6LQw=
X-Received: by 2002:a05:6902:f82:b0:e29:481d:1454 with SMTP id
 3f1490d57ef6-e3825d3e218mr4071814276.9.1731744204907; Sat, 16 Nov 2024
 00:03:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112134956.1415343-1-mheib@redhat.com> <20241114100413.GA499069@unreal>
 <CA+sbYW1cp17tH-p8ffjtgBecyMP_fECmes9RN9Bj=bdNPD_W2g@mail.gmail.com> <20241114114521.GF499069@unreal>
In-Reply-To: <20241114114521.GF499069@unreal>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Sat, 16 Nov 2024 13:33:13 +0530
Message-ID: <CA+sbYW13g5f-CW=QEt-SKtpssw1=Qbqp6d=055a=v5N-r2C9sA@mail.gmail.com>
Subject: Re: [PATCH rdma] RDMA/bnxt_re: cmds completions handler avoid
 accessing invalid memeory
To: Leon Romanovsky <leon@kernel.org>
Cc: Mohammad Heib <mheib@redhat.com>, linux-rdma@vger.kernel.org, 
	kashyap.desai@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000032c2cd0627031e34"

--00000000000032c2cd0627031e34
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 5:15=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Thu, Nov 14, 2024 at 03:37:30PM +0530, Selvin Xavier wrote:
> > On Thu, Nov 14, 2024 at 3:34=E2=80=AFPM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > On Tue, Nov 12, 2024 at 03:49:56PM +0200, Mohammad Heib wrote:
> > > > If bnxt FW behaves unexpectedly because of FW bug or unexpected beh=
avior it
> > > > can send completions for old  cookies that have already been handle=
d by the
> > > > bnxt driver. If that old cookie was associated with an old calling =
context
> > > > the driver will try to access that caller memory again because the =
driver
> > > > never clean the is_waiter_alive flag after the caller successfully =
complete
> > > > waiting, and this access will cause the following kernel panic:
> > > >
> > > > Call Trace:
> > > >  <IRQ>
> > > >  ? __die+0x20/0x70
> > > >  ? page_fault_oops+0x75/0x170
> > > >  ? exc_page_fault+0xaa/0x140
> > > >  ? asm_exc_page_fault+0x22/0x30
> > > >  ? bnxt_qplib_process_qp_event.isra.0+0x20c/0x3a0 [bnxt_re]
> > > >  ? srso_return_thunk+0x5/0x5f
> > > >  ? __wake_up_common+0x78/0xa0
> > > >  ? srso_return_thunk+0x5/0x5f
> > > >  bnxt_qplib_service_creq+0x18d/0x250 [bnxt_re]
> > > >  tasklet_action_common+0xac/0x210
> > > >  handle_softirqs+0xd3/0x2b0
> > > >  __irq_exit_rcu+0x9b/0xc0
> > > >  common_interrupt+0x7f/0xa0
> > > >  </IRQ>
> > > >  <TASK>
> > > >
> > > > To avoid the above unexpected behavior clear the is_waiter_alive fl=
ag
> > > > every time the caller finishes waiting for a completion.
Mohammad,
 We were trying to see the possibility. FW shouldn't be giving an old
cookie. One possibility
could be if FW crashes and we are in the recovery routine.
Adding this check is okay, but may be hiding some other error.
Is it possible to share your test scripts to repro this problem? Also,
can you share
the vmcore-demsg also

Thanks
Selvin




> > > >
> > > > Fixes: 691eb7c6110f ("RDMA/bnxt_re: handle command completions afte=
r driver detect a timedout")
> > > > Signed-off-by: Mohammad Heib <mheib@redhat.com>
> > > > ---
> > > >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 16 ++++++++--------
> > > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > >
> > > Selvin?
> > Someone is confirming the fix. Will ack in a day. Thanks
>
> Thanks

--00000000000032c2cd0627031e34
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
FYMZp2DojLAq9f4Oi2OBetbnWxo0WGycXpmq/jC4PUx2u9mazQ79i80VLagGRshWniESXuf+SYG8
+zBimjld9ZZnwm7itHAZdtme4YYFxx+EHa4PUxPV8t+hPHhsiIjirPa1pVXPbQIDAQABo4IB2zCC
AdcwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU3TaH
dsgUhTW3LwObmZ20fj+8Xj8wDQYJKoZIhvcNAQELBQADggEBAAbt6Sptp6ZlTnhM2FDhkVXks68/
iqvfL/e8wSPVdBxOuiP+8EXGLV3E72KfTTJXMbkcmFpK2K11poBDQJhz0xyOGTESjXNnN6Eqq+iX
hQtF8xG2lzPq8MijKI4qXk5Vy5DYfwsVfcF0qJw5AhC32nU9uuIPJq8/mQbZfqmoanV/yadootGr
j1Ze9ndr+YDXPpCymOsynmmw0ErHZGGW1OmMpAEt0A+613glWCURLDlP8HONi1wnINV6aDiEf0ad
9NMGxDsp+YWiRXD3txfo2OMQbpIxM90QfhKKacX8t1J1oAAWxDrLVTJBXBNvz5tr+D1sYwuye93r
hImmkM1unboxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILeW3PHJC+fh
/0k0H/EC3G4aVIpNcMxI5t/ZmkzID1GfMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MTExNjA4MDMyNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBsm61DZd1Ca3ohT8bT4RPZrE8MFdta
//Jp/Nh8nFKmiidWNinnHjp7OqEX/2odixwbpUWpnXyLzNhzR703gSbhsvWGs3DrwKbr0fD8jtaa
GLK0LLSetmm4bkY3QKHdQoSNFgzzvy5KYqKiPH+fspiGBY+rbrrKpHYuJmpiSDAPKbVq8kqPVqGk
6EuSfvNEQxbyOxmau54wqvKcnNATKZd1/xPlVIqwZy37uT30KHU5TnJIwADClUSxRxU2Y5pq6J71
lDSfr7f05OS50EYbv4uxtBWe38yiYX4z3shQq081p9ZohqujxnfY8q6EBxEpRTpZ9Wy8JZxJl+Ii
DwbPDxGP
--00000000000032c2cd0627031e34--

