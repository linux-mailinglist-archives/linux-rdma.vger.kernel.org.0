Return-Path: <linux-rdma+bounces-5285-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45756993628
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 20:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A8D2855C9
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 18:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EAD1DDC0C;
	Mon,  7 Oct 2024 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FFfyuS0x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA621DDC2D
	for <linux-rdma@vger.kernel.org>; Mon,  7 Oct 2024 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325594; cv=none; b=epfJwulheZBF6UWbRzXFCuDEKM4P+I4iXTHgxW7U4slfEhjEB4loqHITwx3L5ZSsldwfWcvF+9FhXffv1sZ0n9giV30EwkQks4Y3WX/o4MzsWnb/y+XfbujXBVpZHBPeoeb+jgT52tubPPPl0nGCuVV8QK1BHwifRzEvv3RH5f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325594; c=relaxed/simple;
	bh=3eUmG9lFAKGq8upky75sqTlP7z9g5tFVIf87SMHsVig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLB5JAgT5u3f68AQimExSX4zz9xSmzDyoUB7v7KWwpikRBCRjPgorRY4Kxh9IInGBll2YaaShr8hs3cHJqx+I/zM9gjEdwaTpMyV39EcGGEBP/2t6UG9xSe7ulouyFiszgzUvMeV4NmddRqi2c6ycoMCcqTWZSWyWNJnmbxFG8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FFfyuS0x; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e25d405f255so4221491276.2
        for <linux-rdma@vger.kernel.org>; Mon, 07 Oct 2024 11:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728325590; x=1728930390; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kswfWM9XE4lSI9F8d+HghdQSsfycr1pl0aE/AcAYMmA=;
        b=FFfyuS0xMWj4pBwsjsaH2VAR7SDWNdVWIErf8XsHjV+aztPbkq8ZqiwTHZ3lHLhk86
         eCk/OUqOtR9nBJL4mAh6Lk88f3h6csl8VfVnNoGU6OjC5/X4i9ZhxESXntsEvxFLVaty
         jWkjKSZfTaRAOzJutbfIXBFGwKrHpie0uBT2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728325590; x=1728930390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kswfWM9XE4lSI9F8d+HghdQSsfycr1pl0aE/AcAYMmA=;
        b=cN0ATlaJUl7/OaOMCuz06AMCEFJIu/k1/L4JqHIr8lmj59dwV8KG1MxZ2J4xgjpSKE
         9D4jRqbujXfh9X6cPIleXypRGyN8VfAxfGF631wTN0R7f60jqYmvFYjNKVacDJ9j3d0b
         WJ63ShmYFv85ALp4rOoR/zGUq3F/4hCjuZjg3L5be75ex3BSuoWZEzcPslEUzyW8Bl2H
         onQrkApyhegQxg+LkUr5A/fmD6ablN0AfPiS7OxXMozi4+72auq2AzNx8K9Wic7PWhKB
         KknX24XvNSa2PFsgtAzMxePpUvEpLE0rpk5YXQYHJRdi3MO2XFMsJwCtZnfGDPAIkh4Y
         UbnA==
X-Forwarded-Encrypted: i=1; AJvYcCVVV5w2lyc7C4umxeiKFjnA85qpOqeggwpIbPMC8DK2lyndwqUAvVEfLZrJSamPZHpvcxBILB9YcY20@vger.kernel.org
X-Gm-Message-State: AOJu0YxiCn+qWCLHE0P05WFrFFoAm+5H//mTl0xBLQ41mEcSJW/VshBI
	6Mddo+poqws9SZJ7Twgil09eOs/QLWB5VQjJUgFPqvtQlh9buxsVl3hqZrIXMkD5fWBZvnF6eNh
	h2LS8Sf/KSJ5vYKv+eh9FH/Lgp/MsyWLkRZP1
X-Google-Smtp-Source: AGHT+IGex0jMKTWqxEg39UK1sewbf8Hic6zh9jIek8zDrETgup11q8nSbovysPiXS1F1nkRJFgMabFa4DH4O/Z4Dq2g=
X-Received: by 2002:a05:6902:2601:b0:e21:505c:3e9c with SMTP id
 3f1490d57ef6-e28936c762dmr10172720276.10.1728325590502; Mon, 07 Oct 2024
 11:26:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1726715161-18941-1-git-send-email-selvin.xavier@broadcom.com>
 <1726715161-18941-6-git-send-email-selvin.xavier@broadcom.com>
 <20241004192730.GA3284463@nvidia.com> <CA+sbYW3C_aQmTpguYahHRoy46AEo8r35Ca4RVhRKGcQ34qtDjA@mail.gmail.com>
 <20241007122838.GN1365916@nvidia.com>
In-Reply-To: <20241007122838.GN1365916@nvidia.com>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Mon, 7 Oct 2024 23:56:16 +0530
Message-ID: <CA+sbYW1ds5gfBAe06vcbc5H4O_4i1m__ToBEjS8QYnm8nH8+5Q@mail.gmail.com>
Subject: Re: [PATCH v2 for-rc 5/6] RDMA/bnxt_re: synchronize the qp-handle
 table array
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e6ccd40623e728ba"

--000000000000e6ccd40623e728ba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 5:58=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Mon, Oct 07, 2024 at 11:20:24AM +0530, Selvin Xavier wrote:
> > On Sat, Oct 5, 2024 at 12:57=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com=
> wrote:
> > >
> > > On Wed, Sep 18, 2024 at 08:06:00PM -0700, Selvin Xavier wrote:
> > >
> > > > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/i=
nfiniband/hw/bnxt_re/qplib_rcfw.c
> > > > index 5bef9b4..85bfedc 100644
> > > > --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > > > +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > > > @@ -634,17 +634,21 @@ static int bnxt_qplib_process_qp_event(struct=
 bnxt_qplib_rcfw *rcfw,
> > > >       case CREQ_QP_EVENT_EVENT_QP_ERROR_NOTIFICATION:
> > > >               err_event =3D (struct creq_qp_error_notification *)qp=
_event;
> > > >               qp_id =3D le32_to_cpu(err_event->xid);
> > > > +             spin_lock_nested(&rcfw->tbl_lock, SINGLE_DEPTH_NESTIN=
G);
> > >
> > > Why would you need this lockdep annotation? tbl_lock doesn't look
> > > nested into itself to me.
> > bnxt_qplib_process_qp_event is always called with a spinlock
> > (hwq->lock ) in the caller. i.e. bnxt_qplib_service_creq. I have used
> > the nested variant because of this.
>
> That is not what nested is for. Nested different locks are fine, you
> only need nested if you are nesting the same lock
Ok. I will modify the patch and post it this week.
>
> Jason

--000000000000e6ccd40623e728ba
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILHbXuDSQAsb
t5AyKzXiNIRDYmr87DyyBPCkiPBotM1OMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MTAwNzE4MjYzMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDM1Ha5eOrWzRhQXRrsB9ndnGfbKo2e
8aHlTLXmp+t191kq+BOJ/TrnfVaLT4E0p5BS6/F4BRBAL2CwwPIybZTXdDs1G2BELNGXhUK5Nmjd
zfEJQ2qlyyLJzdGUtuFxzWPn3IMwCriZJWc3QlLKZ74Wg/ZPsiZ/yX6j3KUPTJGOow+aYRXXYJOs
Cd1qbOBWS/Ouzg4sP6EIZ/AZHcE5FeUOJcm8CYFQp/vn68/0C3L2JzS3ykPYVkSSNtFN6eFJZe5I
tdHqDWp04LBJ90SDtOj6tr5dfjERBRn8wGsckHtT3zM5WkLizuMEw74XFEp7YxWMY5qR0VxztVQJ
t9a5MXZU
--000000000000e6ccd40623e728ba--

