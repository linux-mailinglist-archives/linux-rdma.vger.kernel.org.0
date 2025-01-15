Return-Path: <linux-rdma+bounces-7020-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DA6A11836
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2025 05:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6300188861D
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2025 04:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4048F156676;
	Wed, 15 Jan 2025 04:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OOAFbzyU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9464735949
	for <linux-rdma@vger.kernel.org>; Wed, 15 Jan 2025 04:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736913811; cv=none; b=hzniq4JmzagTUFUIs5jKq/5H2lQLjm4rGSWz+7+TFjXNskDN79ICia+uDm1aVHCjhLRv0RwUyxFQl37YvevBrav8OPPdai7Cg3W5y7wDopjOrv8JqV9wu/s1urB691JfJn58mvgpMTXJ+ff5DeWeE2PNzW3f091XBCROLn77k/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736913811; c=relaxed/simple;
	bh=xzAVcVDebsMyPqCylk/wEQgyS9c57GvjPxm7yxxqCjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5WfYWHi9vtLgL+ISWNPMcZfLpRBLPbWNcCBgey/c/Svy/1pC9LPXEMQXckqzEyqOimcrPqMlBjZB+ce4CBcbuZ+wSMRZZpVEoWLzdrjBbsLataDB7rrs9AgKpxY8ziJLusxzEJU4aVEYP/489Uoyd1NxV8K26PFl+8+B8mZvCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OOAFbzyU; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f42992f608so8587434a91.0
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jan 2025 20:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736913809; x=1737518609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Dd0ziXHs51/1i6VAqBt3kwFCUZGJcCyUBdwxIRo3nM=;
        b=OOAFbzyUVcBDKZ9OUdaqz1M1j2WYo+N/D0/bUiBGG5QWpi0T3vPAoqpJ03s8rFPuJo
         xiO/gIc7w+2i9T4YhR0F3PPsFKhQDOMpI7e4rh0fA6+BIT4bMKATEZHy/aymqjhv/gNq
         vTims5z50D96BVRP9StJshZgUVviFXedluQ10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736913809; x=1737518609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Dd0ziXHs51/1i6VAqBt3kwFCUZGJcCyUBdwxIRo3nM=;
        b=BHvkNvXgpI4l/DBmKqRFr17VrZhqxo63iZb0g8pxUdmGYmZ5bGyDpAqwHAvMaQErOf
         +8WS0otHtaOSx/LQHMJOOBO6JSXa/f5HOKm3o0UvRYZHXYpaBIgNq5H4V8ixsubt9pdg
         bc+0uSOZbufOD4oks30l2QyoSljD492EodlKUplDSmtr3AHOoABXAP+9964lU6cXHq5q
         ypO15rixoZd68RM6A/eMACFfkvH4dzXE1TxI05U2t5tHFpwJdQZur1bNyF3+K9oqiA0O
         wn+HmLvJTrf2vC1ZuOGUYj1+jwNn9MqT/BwgnUEwcNuzScc10NKgmNwZ1AXnLVmHvVnR
         lORw==
X-Forwarded-Encrypted: i=1; AJvYcCUImEFQCbYc+xSxVHPabfwvpKbTrLlufQUis5kjzPVsGTqHSUs4vh8BFZ2gwgYaoCVlv0qhTkDDSm0/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Dm+e9Q7slfmXkYS+hBEKpThpv2+eTTjcY50dT+iJuYSPz0Wm
	XOSw32ORHOATXzbEiCZdkxFNT/Q8+Sx0lfespH/iwSFzU2pG9W51QRfmbrix3xprSYmKO23FNEW
	FwHcPE1U7Y1VRIjYMbCcnE6U/rPP5+KJxbNnM
X-Gm-Gg: ASbGnctb1Ncx8jsFjZvFqmfkmKhPDiFwnjkP2Lch3P90JkMM6l/3reK1Xp4Kz9jjPJb
	/VK2iz0y93E9zpt+DM5bgBiBGMZNnttP3d307R/4=
X-Google-Smtp-Source: AGHT+IEJkpUwUdXOZswp5BhWCYgVuTaOfK5fGuvAtOlGG2EGWPqzf4cIGeeW3vj2H+imxcyyv3dCsiOPjUvCSN9FUTQ=
X-Received: by 2002:a17:90b:2588:b0:2ee:c9b6:c26a with SMTP id
 98e67ed59e1d1-2f548eae05amr40522802a91.11.1736913808848; Tue, 14 Jan 2025
 20:03:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1736446693-6692-1-git-send-email-selvin.xavier@broadcom.com>
 <1736446693-6692-3-git-send-email-selvin.xavier@broadcom.com> <20250114112555.GG3146852@unreal>
In-Reply-To: <20250114112555.GG3146852@unreal>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 15 Jan 2025 09:33:18 +0530
X-Gm-Features: AbW1kvbypQTPYC5byN0YkdrviNoFmYuXRmPXEnKLC_YSDknTTjBQWYbXOfozc6Q
Message-ID: <CAH-L+nMe0BPbXesZH_nc7tQut84dEtNR=mz8sdUXF6K_E7RyWg@mail.gmail.com>
Subject: Re: [PATCH for-next 2/2] RDMA/bnxt_re: Allocate dev_attr information dynamically
To: Leon Romanovsky <leon@kernel.org>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000099e755062bb6c2f7"

--00000000000099e755062bb6c2f7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 4:56=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Thu, Jan 09, 2025 at 10:18:13AM -0800, Selvin Xavier wrote:
> > From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> >
> > In order to optimize the size of driver private structure,
> > the memory for dev_attr is allocated dynamically during the
> > chip context initialization. In order to make certain runtime
> > decisions, store dev_attr in the qplib_res structure.
> >
> > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/bnxt_re.h     |  2 +-
> >  drivers/infiniband/hw/bnxt_re/hw_counters.c |  2 +-
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c    | 38 ++++++++++++++-------=
--------
> >  drivers/infiniband/hw/bnxt_re/main.c        | 36 +++++++++++++++++----=
------
> >  drivers/infiniband/hw/bnxt_re/qplib_res.c   |  7 +++---
> >  drivers/infiniband/hw/bnxt_re/qplib_res.h   |  4 +--
> >  drivers/infiniband/hw/bnxt_re/qplib_sp.c    |  4 +--
> >  drivers/infiniband/hw/bnxt_re/qplib_sp.h    |  3 +--
> >  8 files changed, 51 insertions(+), 45 deletions(-)
>
> <...>
>
> > index 33956fc..7c7057b 100644
> > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > @@ -148,6 +148,10 @@ static void bnxt_re_destroy_chip_ctx(struct bnxt_r=
e_dev *rdev)
> >
> >       if (!rdev->chip_ctx)
> >               return;
> > +
> > +     kfree(rdev->dev_attr);
> > +     rdev->dev_attr =3D NULL;
> > +
>
> I'm taking this patch, but please let's stop this practice of setting NUL=
L
> for the pointers which are not going to be reused. Such assignment hides =
bugs.

Sure, we will try to remove such occurrences in the driver and push a
cleanup patch. Thanks!
>
> Thanks



--=20
Regards,
Kalesh AP

--00000000000099e755062bb6c2f7
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
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIAKvyTWy8xA1/9FMTmpq48QzyYfhIi8l/UUvWj/WbdXBMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDExNTA0MDMyOVowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCEKcxLPtP8
EO8USuGqGL1rjJNinxTq4+tRhyBV+4oGI6/hAJ/iZ4lB+6ORo/wrmOoa2ZlzhhcAXEmBiiyDO7CB
f3dKrY0CpIsneYbXI9i7vOOKxULk2goCWOozavf6YWdvkeDpxvJXr50WbZqaXEs9ywyywZt3c2n4
OjyMENYbhbWxqzB7V1XFqXpvCko+XfBupRKPOpypOmBIJOk7mw8i6gu/fKtXALZDpIDPTBhPtDDY
hJ5aZEFAOvioc9ek5evE1zhl9RjVkF61psYbo0GGDHzvmSvdVbCA4u3YCzZi9zf6OBNqotOWmSik
ElbgWIcVVAbe6v+5VKbHqq56hLHQ
--00000000000099e755062bb6c2f7--

