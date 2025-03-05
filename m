Return-Path: <linux-rdma+bounces-8353-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A63F2A4FB4F
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 11:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B3D57A910C
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 10:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308DC2063DA;
	Wed,  5 Mar 2025 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Eg4Er2oB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3D6205AD0
	for <linux-rdma@vger.kernel.org>; Wed,  5 Mar 2025 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169354; cv=none; b=Mx2T8JSeGqA10n8/vu7XkOc+dmePoz0yIJjFqTfjjupXNHKE3k9lEI/N3JPflXxiiil82e9DFaa6Ykz71n+jyVEyhs6UBRvlNJXdD7TF6ibAcPi2oLHcRSj/J1dSOyMBejCHjQljLMSMMm2xnv+Z4Q6OVjff4vtdXN0GJXrTVyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169354; c=relaxed/simple;
	bh=TSC0xlF44ssF1eVZcwE/uhvMqu3hNDU7ZYZ8ljxfqHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUELZPT8Y7ZIXPxTgpUgrOMdjNZ+YifeO+bv5+6JSzAKPfmwkhpMFbTZt06kkV2cYVozJm8GO6PDXlvYJQwNOn63KTmBSozBrybmCQTysI0GhG62DF9h41Qn98qTXp9GJ0fTniJ7XmLJQ5MH31z+99tDC9qLy15tKda26uwW37c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Eg4Er2oB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2234bec7192so117874485ad.2
        for <linux-rdma@vger.kernel.org>; Wed, 05 Mar 2025 02:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741169352; x=1741774152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1T5dSp14bIekjGfd0E0y4TxzY9jLeDNYJDAOe0bDeGo=;
        b=Eg4Er2oB9Ovf3Rm+ZNvSlpjXqjFQHEYM9BV7ZAgFXBwwTo4Wmed8sbnwtGPHRL5zs2
         X32aVW2T21n40yLEsQzNxXU5cgGWcER10rJ4fKNPxw2cLa7PQvOXPoqLf6iswhqW7ox2
         2vjtXJ2U3+Nuy0fQjlbC1AvVtKaVtN/uLhUgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741169352; x=1741774152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1T5dSp14bIekjGfd0E0y4TxzY9jLeDNYJDAOe0bDeGo=;
        b=SHRXvKJfNgJPkM9ekqvUZ3GJk91aM9tAhBZi9IErlgMo/G0SoeJwK6l1EZ3TuYRsus
         lal0J398SLsFn/aOY4QeMklkG93mn6cI/04XsgTXJvenEGKeaxrgsjeSLUQAHezIJGqF
         Z2Nzy4KgrxYygOE6/Hzk/XH6XEvZgYfeZJfj5j6wu7fYYUJcRJUTzwxKhd7QkxDJlG7n
         dDwd+/8YY1ykbtdyvCP0pvnoaADfunR0F+TOmVc6jl/aqGiXI6bP/u9SHVtKjM4JBmmf
         4vwxhc5If6G1OrUbkmzWt7bCbZQHiqcBA+OI8E74f3nHf6T+nEYcZ+mhVruGJFysXkzQ
         BLhg==
X-Forwarded-Encrypted: i=1; AJvYcCW+oOCOd/sw116dlacCQDQOuuk+iekpZZaMTM5BCZwjaWcPw84u3KGkXA4Zg8JPFPXYV5JLnaxxxkMY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz5xSH/oBGqgca4fgp+ubapKldS9Yp9mfPUjwRdgtyx549zYFV
	GNdF9/g4Q8GxJDSQn3q8SM2ujtZZgtqyFScEFPZGj8aSLgMz0IGx/+D6etr5uWZn8Csny11dwmb
	BIv2YiFdqn1hyewx9AYOFUXQG9hlX3LdNP5CP
X-Gm-Gg: ASbGncskRtB137gE4OcxkCiTpdvm5bsyfqQ+UmMM+z2wJwL34BBWScw8fNWWiyAZ6D1
	+1XXo1JGnJbaKtCvOp8P1FLkF9g+eG5ftXJWhUlPnC8yo9epVdkjisM9Nn4hhLiE7WrfUCdHUAZ
	2fYRbYtzWzgBbWUkcSOhENZ/55xcY=
X-Google-Smtp-Source: AGHT+IH24vbxw+ivmGO2YHNZrEktM6vQpjz5JA9Z65jkWmTKXBfwf/phMv2Hsh+a2j9cPPanUMnfEEJB5OlWSOostTg=
X-Received: by 2002:a17:903:230b:b0:21f:8677:5961 with SMTP id
 d9443c01a7336-223f1cf4883mr44621575ad.34.1741169352419; Wed, 05 Mar 2025
 02:09:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740574943.git.leon@kernel.org> <558b28bc07d2067478ec638da87e01a551caa367.1740574943.git.leon@kernel.org>
 <CAH-L+nPoVOMHq-hzAVBXa5-8Ehc75qg0pP4mBnYtT8qH7zNUpg@mail.gmail.com> <20250305095511.GI1955273@unreal>
In-Reply-To: <20250305095511.GI1955273@unreal>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 5 Mar 2025 15:38:59 +0530
X-Gm-Features: AQ5f1JpPAc2w8IbOYQ2peMfTuX_09-YvMGltmhKjm397cWNjzOCRX_S-QIq0qoE
Message-ID: <CAH-L+nOA-fS3M+X0vBqJ960nshaSKKQdy0wHR4O2iRLtZpC1wg@mail.gmail.com>
Subject: Re: [PATCH rdma-next 1/6] RDMA/uverbs: Introduce UCAP (User
 CAPabilities) API
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Chiara Meiohas <cmeiohas@nvidia.com>, linux-rdma@vger.kernel.org, 
	Yishai Hadas <yishaih@nvidia.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c39fd0062f9594b0"

--000000000000c39fd0062f9594b0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 3:25=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Wed, Mar 05, 2025 at 02:01:13PM +0530, Kalesh Anakkur Purayil wrote:
> > On Wed, Feb 26, 2025 at 7:50=E2=80=AFPM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > From: Chiara Meiohas <cmeiohas@nvidia.com>
> > >
> > > Implement a new User CAPabilities (UCAP) API to provide fine-grained
> > > control over specific firmware features.
> > >
> > > This approach offers more granular capabilities than the existing Lin=
ux
> > > capabilities, which may be too generic for certain FW features.
> > >
> > > This mechanism represents each capability as a character device with
> > > root read-write access. Root processes can grant users special
> > > privileges by allowing access to these character devices (e.g., using
> > > chown).
> > >
> > > UCAP character devices are located in /dev/infiniband and the class p=
ath
> > > is /sys/class/infiniband_ucaps.
> > >
> > > Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
> > > Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
> > > Signed-off-by: Leon Romanovsky <leon@kernel.org>
> > > ---
> > >  drivers/infiniband/core/Makefile      |   3 +-
> > >  drivers/infiniband/core/ucaps.c       | 255 ++++++++++++++++++++++++=
++
> > >  drivers/infiniband/core/uverbs_main.c |   2 +
> > >  include/rdma/ib_ucaps.h               |  25 +++
> > >  4 files changed, 284 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/infiniband/core/ucaps.c
> > >  create mode 100644 include/rdma/ib_ucaps.h
>
> <...>
>
> > > +       device_initialize(&ucap->dev);
> > > +       ucap->dev.class =3D &ucaps_class;
> > > +       ucap->dev.devt =3D MKDEV(MAJOR(ucaps_base_dev), type);
> > > +       ucap->dev.release =3D ucap_dev_release;
> > > +       dev_set_name(&ucap->dev, ucap_names[type]);
> > > +
> > > +       cdev_init(&ucap->cdev, &ucaps_cdev_fops);
> > > +       ucap->cdev.owner =3D THIS_MODULE;
> > > +
> > > +       ret =3D cdev_device_add(&ucap->cdev, &ucap->dev);
> > > +       if (ret)
> > > +               goto err_device;
> > Memory leak in the error path, need to free ucap here?
>
> It is done through call to put_device(&ucap->dev) below.
> This is how device is freed after device_initialize().

Got it, missed the ucap_dev_release() part.
Sorry for the confusion.
>
> <...>
>
> > > +err_device:
> > > +       put_device(&ucap->dev);
> > > +unlock:
> > > +       mutex_unlock(&ucaps_mutex);
> > > +       return ret;
> > > +}
> > > +EXPORT_SYMBOL(ib_create_ucap);
>
> <...>
>
> > > +       ucaps_list[type] =3D NULL;
> > > +       cdev_device_del(&ucap->cdev, &ucap->dev);
> > > +       put_device(&ucap->dev);
> > need to free ucap here
>
> Same as above.
>
> Thanks



--=20
Regards,
Kalesh AP

--000000000000c39fd0062f9594b0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJgMIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcN
AQkEMSIEIMtQKlD3ca17ZfWOuM1Bs+tshuR2ISfCPYKNuNHUEmLZMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDMwNTEwMDkxMlowXAYJKoZIhvcNAQkPMU8wTTAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAHd9YxZeDNf5K5yDhZXpW4o0vHcU
EObCTj7xzsQg5Ozq+Z8MGU1NKu8GWiO8VTDYJM+kAntdj55DyIM6pVjfKuebwWoqdxOBh260HxpP
JWfNZGWaePs2h2Ap87/KYc+U6ST13xzu9o8IG3wZ2Xf0JOUnIbUZe5dN+3xn07xQ9tAOHPXbAIV8
D6BGQaxFK525teJLzD6NG8nnKcdykH06ZNHNrzoeZT03bFdPEtR1AGDYgc/P9yKw49BE4FFUeSWc
zVssLIpCAwST32GjqmBOZ9iFZuD5ZIVJ29Qwozfhf+AFvyN/lns4SY2PYMr8sFeMqxiDdqbyww6f
QbBHSLuvEW4=
--000000000000c39fd0062f9594b0--

