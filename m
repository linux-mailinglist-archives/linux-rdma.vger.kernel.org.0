Return-Path: <linux-rdma+bounces-7095-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22500A162D2
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 17:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E351885322
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 16:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EBF1DF26E;
	Sun, 19 Jan 2025 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UEKmqfxN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031C9C2ED
	for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737302652; cv=none; b=tae/2aOe3OVHffjoidqL1a6umCV4NVQ0CDO44kZXEGjgtaLasaKtjbe0pwB7vxeYrEPfHB5EhVcqRGyS1MSRzHwMisH10I19gKSQfrGmo/pOOiO6i54mdcl9EyCGO2LawQ4spuDaSDTQN9TsxD84Jr8jU6fK6zE6DIh7wHnEZj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737302652; c=relaxed/simple;
	bh=heB3NA6PesqOsrl2uBmnRwajbkc+JwfRMfQ8m2cezvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCDsiaDm4nSakwEbSFfW9qj2FuMsOy/dGTHTHNQdjNEpcdZ6O1LA8CCC+3r05uLoToOjk5iKhmjv9k1PWlxzKTeT4Vy2HbPeEAx57/3NQZbfCmBzAwu809E1aSY4hgm/d6VdHXbRGhS8UCSFkz6qY79Ps1AOZCWLWvrKJ8UKWM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UEKmqfxN; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-29fe83208a4so2050219fac.0
        for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 08:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737302650; x=1737907450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlxX/SvE26EO9ri8ooeIBsE3wY/rXDNERYHvgx/ShPk=;
        b=UEKmqfxNiATIKA1hszp0PuL3PbhuxiShz+PuIP9Pp7x+4Ju1xqLqlSRe/JjolBcnc4
         +TZg62QEUK0p3tGFYjTHtrvTD7+zOkOwhssjHooXCSYldTZITi7tKGGPSVJxxTSSxJe8
         Shic9URIQAmjrqX3fpLaYlNMND1mg/ccOD24U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737302650; x=1737907450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlxX/SvE26EO9ri8ooeIBsE3wY/rXDNERYHvgx/ShPk=;
        b=ZAIr0DLsZb3moG6HEVK1mORV6LB/wPULS6zX8ma0QfZtnPc+1goCCw4JfULgGb0+WG
         OI8aqP+mqDsK+r2MveQ9wl6fVld7e++MXjSjY3/WlDN6n6pkle+/yJfCfvXE13Fq9srb
         ictspZQG9h+BksKzsgJe3PbjSkO8oIt5NhRx29NYfq/wkKjKoS6ThPi1oA2a0Y2VoajE
         BT5pujfA/ui4aoen0sLRHfjmB0+tfkKPJ5JyiiVtoCROR1b4aJHnlJhYrJRg2bsPmjgb
         4HvawYzgCfi6hiEoM+xdj3kO/SeiTIkhg64iJY20pNwUpwvEPXrxHL1TxRuKPaXWIJod
         FuCA==
X-Forwarded-Encrypted: i=1; AJvYcCVKfS3LrRgiPcElZOec9+LNO8ZCeIO5M1SUhapse5GeOGUL1Las0LDhx4YBLfvxXPI0Ql2M15LgpIOd@vger.kernel.org
X-Gm-Message-State: AOJu0YwvKeRlB6PItCnlwwM5BKhryVGCMa00d846t/aV6dAPEZ4QrwNr
	2deZh+nQhNUmO25usIggwAEJzGvJKG3l7QfH4NfwvV1UvUB0ZE30CGCbGj/Xp/9cYSFZe0RIC86
	OnEbmbQy2ubc5YSTcmHYYr5xZWb713bJpww7g
X-Gm-Gg: ASbGncvU/rcsnIwascwdz4ErDSt35gbvls0rL3tQTczPwOVB1JbW6PirWKqBrimPHAn
	VA3J6cWsFHgPeTrl9RJkoBS7Fwyb/z6AFsMcmW2dSzkNylpm2coOz
X-Google-Smtp-Source: AGHT+IGVz3pV1TLArDOtM/fOHzpQtqwcyspIJwsR/JFtrl8fBFf60giN7N3rsvBDss0e7ZEvJY+43uE8E7Iy7qDRZJY=
X-Received: by 2002:a05:6871:e40c:b0:29f:c94b:3a06 with SMTP id
 586e51a60fabf-2b186a513e0mr12024243fac.8.1737302649912; Sun, 19 Jan 2025
 08:04:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1737174544-2059-1-git-send-email-selvin.xavier@broadcom.com>
 <20250119095750.GC21007@unreal> <CA+sbYW3fsjMxqMPyq7HGLMuhb2TEkG8Jo3PmgOyMR7ba5TF3DQ@mail.gmail.com>
 <20250119123417.GE21007@unreal>
In-Reply-To: <20250119123417.GE21007@unreal>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Sun, 19 Jan 2025 21:33:55 +0530
X-Gm-Features: AbW1kvbiNFe6J2_rCKxh322xoU_kqXfJLZ_3gufiFxQ0XCupipdAhS8AadXtDy4
Message-ID: <CA+sbYW0V0RRRTfR0oKcxzZ8U9kD3SW77WMJrcFv+i-pnKBNmaw@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/bnxt_re: Congestion control settings using
 debugfs hook
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000557418062c114b32"

--000000000000557418062c114b32
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 19, 2025 at 6:04=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Sun, Jan 19, 2025 at 04:01:55PM +0530, Selvin Xavier wrote:
> > On Sun, Jan 19, 2025 at 3:27=E2=80=AFPM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > On Fri, Jan 17, 2025 at 08:29:04PM -0800, Selvin Xavier wrote:
> > > > Implements routines to set and get different settings  of
> > > > the congestion control. This will enable the users to modify
> > > > the settings according to their network.
> > > >
> > > > Currently supporting only GEN 0 version of the parameters.
> > > > Reading these files queries the firmware and report the values
> > > > currently programmed. Writing to the files sends commands that
> > > > update the congestion control settings.
> > > >
> > > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > > ---
> > > >  drivers/infiniband/hw/bnxt_re/bnxt_re.h |   2 +
> > > >  drivers/infiniband/hw/bnxt_re/debugfs.c | 215 ++++++++++++++++++++=
+++++++++++-
> > > >  drivers/infiniband/hw/bnxt_re/debugfs.h |  15 +++
> > > >  3 files changed, 231 insertions(+), 1 deletion(-)
> > >
> > > <...>
> > >
> > > > +static const char * const bnxt_re_cc_gen0_name[] =3D {
> > > > +     "enable_cc",
> > > > +     "g",
> > >
> > > ????
> > It is the "running avg. weight" used by Congestion control algo in HW.
> > It is referred as "g" in the parameters and the FW command. So used
> > the same name for the debugfs file.
>
> At the end, it is your debugfs for your customers. IMHO, it doesn't look
> nice to them.
ok. I am renaming this  in v2.
thanks

>
> Thanks

--000000000000557418062c114b32
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDiyrPTJizCP
s9MmM14f4SmPy7XcIwfKNljdHIZNGPsHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI1MDExOTE2MDQxMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCto38rx7lQFVNUGxlfMueeDAHAXmNZ
auXzmPIO8u83n0Xf5j4b86OAaZI+h82ObwZN/qoDla4pWuiz7UKTrgs++/2J3oIsPwISGskU/UYl
eFV+tsAj/NxK0Ie/Wphf7gs03Ow5JycZs8D9gFLBs/8xyyMXAQwsCNp8di7F8F5rDR0vjEjVyE2h
lxcB/hfR7M6rg9NCPlrtWUtImdkihNwyBDQPQjXiXjVNRRqErmc5KaDlksNwiaCSbgZifQxsiVmr
BlIY+3MyBlDK0IcJjIJudvGUyLZ1cVP4RYOg6y0+k+D1WOaY/S0OhJRSR7a5hB95fWCRURWZ/ofC
k4tQUdCP
--000000000000557418062c114b32--

