Return-Path: <linux-rdma+bounces-7201-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0317FA19DF4
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jan 2025 06:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA401889745
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jan 2025 05:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368931537B9;
	Thu, 23 Jan 2025 05:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SJydttMc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BA03596B
	for <linux-rdma@vger.kernel.org>; Thu, 23 Jan 2025 05:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737609657; cv=none; b=V6r2AVYCwqV9a2VqOjHlb0w+Z7NmoxH74+kBgmjOgtLJFtHnS3vJXLhPuAkyIhmtke4D+d5jh+weRlshoj077ICol5Z7Bd4zf05J1tpr9lLBVTCSY2gnI0iwcyjYA0SI4xIByEmAni397zMRWvuD5Qo3DyJQQ6qHKKp0ys2eUd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737609657; c=relaxed/simple;
	bh=nsJrZFx9eWny48JL8BhP5P9VUsCAh/HyUQ73YFqsM6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9FT75MNqPnmipxSV179V2/WuZmGoKM2oqiFSif9OOL0dQgffN91GGxBVgSEv2FCB796lydO1ZTav2hgiKKoA2YclPjguDpq1CCMCoGDtnK9mkH+VWCaCijH2BRFIdUEliuO9TK9Qew2RaZciSgTSqbKInmmv+94zdnkhdVfCOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SJydttMc; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-29e5aedbebdso347026fac.0
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jan 2025 21:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737609655; x=1738214455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pc2DzyTW1FTYPiDS2igykhJL9jQXqe3OrxgtlqwiKXk=;
        b=SJydttMcTevIV5ghQIAP1DVKmS6xETtTWesIjiIHAizc2BQ6f5sW4vRjjPbZ4N5WHN
         Qay7+s5Oty/VGSUHj9F8a3RkPkmTVtyU+MiLkmgn7joH9ktiMb+rp92/VmQpe21mTo3Z
         UmggcI6NuH2nDYkSQJZE/Hojpm5X8GXgwQ9rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737609655; x=1738214455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pc2DzyTW1FTYPiDS2igykhJL9jQXqe3OrxgtlqwiKXk=;
        b=FpqAOLZZ5FpGONiUgODT6dOB/9LJd8T9aVVylUnkXFHjGVjNtwiscIrfDGaMQJStye
         GIjIq9zqIyszYCemisuTHWk1Hi4UHMi1TzaxBAdd3SUXAU2dpB8XEIZQLy0D2pXfzSWl
         p6MASo0pB/0CWXwpZUIX3nL+wo/ohm6A9vIhTHkU4hfAOdJqrlxBn4Pjixj3W5iAE31f
         tgtPsrdMuhSc1SKLFMy/wab31r3Mh1Vs38wFqFmUcSk+PmnL5zGXQqjRQ7fN2UaCsd+k
         SoFvmrw6JEDnj9BuxZgH5jHwRtu9OcoWEuCmFRGy6bomK+8DFgYcAzXKAxfYfUGJb6fv
         61Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVZHowEe7oAOqFM9+XkhCLGJzZ80EjJ8dkA5GQv+w69FY+Uu9yJ2BnKlXcsLB9Z6p3T3uQg5KkQxb1j@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc4MTN7up31bBqqcm714PN9AIKo7OVBVQwK/FCpolf2b1E3+1w
	r+2XF6T1QLpnk/Cun3JGThONMMl6aVy1msl0dNIQ6WG1JE35p7OwkgrkjLjKYUFZiWvajH7giTr
	nfPr60/JE3BqbU69z9Ael4kDAZor9rXQfqKIQ
X-Gm-Gg: ASbGncsDFpIxi/cz1hOppmajzJF/s5JVyivjeK94PUcZ7onFb4vrUzj3ZOQX/a5h+Tb
	71DnZTYA8seMSmeXF3q1/F6LcYJ1BcUiO5Hy4/rpy4prJ6ZqvQh2cpzXyGCSdf9Y=
X-Google-Smtp-Source: AGHT+IHHtG93MnghWk6FKq1WM5utj4Nd/tQXRlAJdwf5nd+b/nQTEAfpec2N+tXrcESFHXT6evO3Cq0xxewHQ3Q6f2o=
X-Received: by 2002:a05:6871:7b84:b0:29e:2d50:11aa with SMTP id
 586e51a60fabf-2b1c0afc5ebmr13151669fac.18.1737609655247; Wed, 22 Jan 2025
 21:20:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1737301535-6599-1-git-send-email-selvin.xavier@broadcom.com>
 <20250120164000.GO674319@ziepe.ca> <CA+sbYW2oDbrodgYdzOgUiSv6v+8aBcACLbfrXM+0NZGmHquUFw@mail.gmail.com>
 <20250121153127.GQ674319@ziepe.ca> <CA+sbYW21WJsFECZ9tWDBqZy_p1C+H2Z2chOJcv93JnJ6TdzJFA@mail.gmail.com>
 <20250122152243.GU674319@ziepe.ca>
In-Reply-To: <20250122152243.GU674319@ziepe.ca>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Thu, 23 Jan 2025 10:50:42 +0530
X-Gm-Features: AbW1kvarg_NgPacHrlkmn-jVJQyGYOBjxQiA90vH55Ztt47VwXk52Zkg3ZUfTT8
Message-ID: <CA+sbYW0B0ktrcYywAPuQVByD+kBBuMezNG+iFpWhNrN-PFk_1A@mail.gmail.com>
Subject: Re: [PATCH for-next v2] RDMA/bnxt_re: Congestion control settings
 using debugfs hook
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: andrew.gospodarek@broadcom.com, leon@kernel.org, 
	linux-rdma@vger.kernel.org, kalesh-anakkur.purayil@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000465d9c062c58c6c7"

--000000000000465d9c062c58c6c7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 8:52=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Wed, Jan 22, 2025 at 01:39:16PM +0530, Selvin Xavier wrote:
> > On Tue, Jan 21, 2025 at 9:01=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
> > >
> > > On Tue, Jan 21, 2025 at 04:10:33PM +0530, Selvin Xavier wrote:
> > > > On Mon, Jan 20, 2025 at 10:10=E2=80=AFPM Jason Gunthorpe <jgg@ziepe=
.ca> wrote:
> > > > >
> > > > > On Sun, Jan 19, 2025 at 07:45:35AM -0800, Selvin Xavier wrote:
> > > > > > Implements routines to set and get different settings  of
> > > > > > the congestion control. This will enable the users to modify
> > > > > > the settings according to their network.
> > > > >
> > > > > Should something like this be in debugfs though?
> > > > Since these are Broadcom specific parameters, i thought its better =
to
> > > > be under debugfs. Also I took the reference of a similar
> > > > implementation in mlx5.
> > >
> > > debugfs is disabled in a lot of deployments, it is a big part of why
> > > we are doing fwctl. If you know it works for you cases, debugfs is
> > > pretty open ended..
> > The main use case for this debugfs support is for evaluation customers =
and
> > the tuning for their network. So debugfs should be okay.
>
> In my experience it makes no difference, if the customer is using
> secure boot then they are always using secure boot expect in small lab
> systems perhaps.
>
> Are you certain this is useful not just "should be okay" ?
Yes. It is useful based on the request we have seen from our customers.
>
> Jason

--000000000000465d9c062c58c6c7
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMdv3WnCIBlh
RlmwiyYXp/5QqK5WzFcNHxhK5tqyoJoBMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI1MDEyMzA1MjA1NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCWVbezwogJ3vVMp2fdxt8xbPg+Y6Rw
rku6ilUiKo1zWCFvgFIpUcPz+gUpmFGcyT8qEw77pIRmvs6QNWINHkesT0oGn/QqF00heNVflwkg
+RG0d81TABoIVdIMXmSRCe8oxnzFooDvKaXewRodA+EPDEnZgKSZH2nOQdu6KX/GgsyTPd87ij0Z
SdeWbuO7ZCJ40MBllT8nRIds01vOtOhWUGEHE/R2BPpkr5i2kkH+HG9OcIIlvSUCXSTYclFXpV/D
nO1C34NiaAk7GsQ9/LJtPkkCVb9dAQPfC8TW1h4MFdk0+u9sGXVN4i1TMSA2S6ifVy1U+MrZrQAr
tYvQ6fvx
--000000000000465d9c062c58c6c7--

