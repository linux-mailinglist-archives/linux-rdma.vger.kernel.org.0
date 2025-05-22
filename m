Return-Path: <linux-rdma+bounces-10510-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D800AC0288
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 04:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773969E5EA8
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 02:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D06C2CCA5;
	Thu, 22 May 2025 02:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DXk3HicK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF48645
	for <linux-rdma@vger.kernel.org>; Thu, 22 May 2025 02:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747881585; cv=none; b=T3I5ZtF3xDxUWmtt0stpCFQXJIW/8liAt5e44qiOYQE3kvU+ueC8oxeVy/YI2+kWX+oKOgetS8ll4B8ym2iw94Emy9fV9aTLZ4HZQ/Cl175Sgm3UgsaO3ZB5xaUZMx5ruN2y1M/P1qqxBhur3X2sJCcN5+AY0cdG0smrix13/mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747881585; c=relaxed/simple;
	bh=6ntddXkstVz5uk8MTksaEwFqnmWAfy5+xQSQbowXaHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEnDamTIhi/rLPK7yCg7gqQJBNNF/sCKhPUKenLEhDSXGUMUiecbaji5d058VdXFVuKLy7m0z8iucY79x+XgrA3pKblzOLuQ8v0FBUa6NquXgJLdLNchABklmvyF2fqEhZCOy+aZUrwQb05p8r4FGeXhthc+QaVycVnEVPyifNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DXk3HicK; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742c3d06de3so5236315b3a.0
        for <linux-rdma@vger.kernel.org>; Wed, 21 May 2025 19:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747881583; x=1748486383; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/dpCEEKL5dgdDuzapeN7Sdzp2B0DOfbTgbjfjOtWHKI=;
        b=DXk3HicKbqVwAMBebuF6+kYPeX7FCKEu2sEFExaSFKoujnClbczKszyQSoWcOSs/5b
         HEcznkQ++ZuIvA26SQa+oqSwoG4woS8rIQkqqqpn8Sp0LMdJdSczN1rB+9K7rU2sZHe1
         GiqfPeKB2k8Fw2XTp6BLN6iNc3kuTUO/gFbhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747881583; x=1748486383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dpCEEKL5dgdDuzapeN7Sdzp2B0DOfbTgbjfjOtWHKI=;
        b=LDkEvQ+yoSRwy2W6SSS8dRM/1AO97R8rEbpWTswM/CgmAdHydHyGZPStlG5kdAfX18
         4cBEhVbCqIWZnyD5cCeJMDQnT3BhjEShtUXgKZ+yUGrruMViEB6wemWmfq7QBquenEOr
         a8Pb6uoyDw2Mt3YB3ZyBbFHftAlGyBIbFaOC4LqyLoXSWN3nBvoL1Dy9RTlPKM4Jgr5e
         OF62/wHawRm1J2Frr24Q/0ROKH+KpAIJxoMA1KP7lNwbIK0oq2Um4sZS22HX3eSnMplE
         o50SqfF7SbSJNB3DDZ7L9RAq1oAr9wtw89wYILU14E5NaXlETnKy4sCVWDciB5WVikt6
         a1sw==
X-Forwarded-Encrypted: i=1; AJvYcCUBbgosEa7tcssHVyK/cdkfUB7sXmp+99s9fdoLy1WRS0PD2IQVt0Ke0nJFjIRxwa0rO559e9y93VjE@vger.kernel.org
X-Gm-Message-State: AOJu0YxE3XfxzcYRhIbvYIf1vcnR+oZu5PB1XeYCDiiOHZGxH4D1ps4N
	gPuw/OHwOFDuciL4wK8CazgSpNGYpn0TQRA50zvKMxY7EfbbQBnLTfJeQ2Ej7jLYyA1mpu9AaKy
	R2tAFhcJzP1NcW06VotJVvD5ZQKcpCHCQ6sgczghP
X-Gm-Gg: ASbGnctN0qfvIJ3j6PE067W2oWDdWfyAdXBvKVFwTrLFo4+BOFXuOa5StgvNFGyQw4P
	La8rv6CDXjpn+w4EACcAUW+94BR2mKOl0WsEICrutxjb8ASDvcuoWwyuVFD5aZSLJi7ahl5KBsV
	Xh66Rdf4nhCBZ1cmczDaAJFQ2FmmDiuEE4gA==
X-Google-Smtp-Source: AGHT+IHm/2hUXiCASFdv277TNkuMWwUW8P8kz/LiGERoFy9mPUUifL634glYCfdv1EDQiWoBwsBXGvM+J7wUx3zDZC0=
X-Received: by 2002:a05:6a00:3c83:b0:736:2a73:6756 with SMTP id
 d2e1a72fcca58-742acd736ffmr33036581b3a.21.1747881583314; Wed, 21 May 2025
 19:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520035910.1061918-1-kalesh-anakkur.purayil@broadcom.com>
 <20250520035910.1061918-5-kalesh-anakkur.purayil@broadcom.com> <20250521100147.GI7435@unreal>
In-Reply-To: <20250521100147.GI7435@unreal>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Thu, 22 May 2025 08:09:32 +0530
X-Gm-Features: AX0GCFtUYZhZU8uMMdyKCOu_S6Ws9PW-f2VjeUuXuvjoxXZEt2dywtutlANqdOg
Message-ID: <CAH-L+nPW=RnLdFvWBcVYvW=zK1CgL75U95KkYZjGFwu2MW7=hA@mail.gmail.com>
Subject: Re: [PATCH rdma-rc 4/4] RDMA/bnxt_re: Fix null pointer dereference in bnxt_re_suspend
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	selvin.xavier@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e707600635b06404"

--000000000000e707600635b06404
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leon,

On Wed, May 21, 2025 at 3:31=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Tue, May 20, 2025 at 09:29:10AM +0530, Kalesh AP wrote:
> > There is a possibility that the Ethernet driver invokes bnxt_ulp_stop()
> > twice during reset recovery scenario. This will result in a NULL pointe=
r
> > dereference in bnxt_re_suspend() as en_info->rdev has been set to NULL
> > during the first invocation.
>
> Please fix bnxt_ulp_stop() to do not do that. The fix should be there
> and not in bnxt_re.

Thank you for the review and feedback. Sure, let me see if we can fix
it in the core bnxt driver.
>
> Thanks
>
> >
> > Fixes: dee3da3422d5 ("RDMA/bnxt_re: Change aux driver data to en_info t=
o hold more information")
> > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/main.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/=
hw/bnxt_re/main.c
> > index 293b0a96c8e3..bc0b40073461 100644
> > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > @@ -2410,6 +2410,8 @@ static int bnxt_re_suspend(struct auxiliary_devic=
e *adev, pm_message_t state)
> >       struct bnxt_re_dev *rdev;
> >
> >       rdev =3D en_info->rdev;
> > +     if (!rdev)
> > +             return 0;
> >       en_dev =3D en_info->en_dev;
> >       mutex_lock(&bnxt_re_mutex);
> >
> > --
> > 2.43.5
> >
> >



--=20
Regards,
Kalesh AP

--000000000000e707600635b06404
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
AQkEMSIEIOYXZzPZ6S0MHJW9rTDehGTblyUu2jNsk3rIPICxZVgiMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDUyMjAyMzk0M1owXAYJKoZIhvcNAQkPMU8wTTAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAKlThr32L0dIr2PtIjk9Pyl8C6R4
4pfA2+N/lNX6lJw0ZmnmArLCA3/k9OKZIvO6f/K718R9ovXWNpCpcf4lXlrOgwW7CP8UkAbrPJlZ
Jz4AD1nw8zVdw8UumV++8Q5bwJuI1JW8YNyAj9q95giGC08iCzED6nbHByj3QyMohV9NnqpFNNdq
R0rddUah3BjPiMXIiMqsvXpDuIeRgTpYYapJ1g2SeEp+NL0bPmu3Q4Bt8FwBXhFVSOr7rtVQY3B7
rBQXl92XQdmawkXD2gPrE9zuWw6BG8StK+xb8OhG5PMG0JuV7LWcZfaWI2AX7H62aOgMGDzhYE/H
ttYzcMAv9oE=
--000000000000e707600635b06404--

