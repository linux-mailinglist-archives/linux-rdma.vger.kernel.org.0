Return-Path: <linux-rdma+bounces-6895-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 818F5A0509C
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2025 03:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8D21886188
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2025 02:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930CD15CD74;
	Wed,  8 Jan 2025 02:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OgDPmn2h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9379E1DFFD
	for <linux-rdma@vger.kernel.org>; Wed,  8 Jan 2025 02:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736303256; cv=none; b=qwRk2gyvM9qIIIyzNErG5444NHbEuaZ4Je+P1F2WKC5njBrb83Vmax6mq9Zp/0krAkLwkjgYIFkF29X7PHu/YvDMZfDW3cCKimdAmRTD7qo5uplI7N+bSEWpPDqGkb6n5AcdyL9JjVZhq41dmuieTWO/DM7TkImG9GY+9MHIun4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736303256; c=relaxed/simple;
	bh=tQaIP8KkJSZtTpUtE4q48sCI4x+Fd5BkVDiCKfSClMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7xIIt3IfsSVKFs/alYCb/mQLx+mCQWMwyeAmUDLhw6D9LR2eGQr7xkrZNjbGcXoPu1RGRkC0w8fxr+B0rkplBB2z0SiRMEQlOafWPGHMvUmJT8e01QitNtpC/2r8UCSLkHdOsBxPF5tQSls9x5xhR6QR7xWwGVpFqtUw/nzr+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OgDPmn2h; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3e9f60bf4so29043007a12.3
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jan 2025 18:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736303253; x=1736908053; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ANIRly917shzeLIs9m5c8SASWfq2MU+JYSLAFWwF0V4=;
        b=OgDPmn2hCp+mGDOZR1DVOme/Irfukv4sZaHOP0lCEl6bM6LZlw55NOYsAGhKzgxxlB
         lA0gfklAOoN0cMzPBkDT9+Dg5PlGKwGMOV4yhP1ACH0xBEv71UxLTVgGp2fNbunZVNtG
         cfcQxTKfcZ0XkVahAjFX5B9VT4ZNGeqe9bgVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736303253; x=1736908053;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANIRly917shzeLIs9m5c8SASWfq2MU+JYSLAFWwF0V4=;
        b=w5DXvXvNVRTyohOh3QCUlma6KdXw+qQKFIQnS+WPm+PJ1vj4yYlh+GYiCVpA6qlvjr
         6xoZLRxLNNU8pAWf2Y6VOC7hRqkRcUW66e6Z+VT9CgBmGtBIQCJAEQ1SiyzzCXTasqPm
         FBBfmj17PqhD/B9xdICAk8Z35Qt+GVVrmvj1kmygr83aCjHIGpDMvIb36nSJU8fR9Fun
         fIJniGw0S5KqFt+bpHrnoc7ilNPQgwc/vj55vYPNJveDqMWVx/HC+GyqdMAd73CSbLLM
         r3NKW4Pxz+7K/m/ChWcGllNXpMIC1aMNjTPlQXFa+kdx44PnfXefk+DapA+m6YpvQBGx
         zuEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH3zbsq2OxrpZF9UrzDopreuaaT3xeRxbt1IYhcvbVO5f4Ok+tKZ3EAeR8pSqqd049LRrekmRCzOcu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5eUZD21hl9zlbUgIZRs1URI4gQH1McAJ4ATA5MJQHiNYMzcpi
	GyNbbF6tbHZVhKK+i+h3SoilL53j70JbDzG0Iy4tCvz7ywfoxaTGqHD3dxAvleD7t8hwafbe7ds
	6+Md+r8y//sI5PUJ/29/t3k/eNqU+WR+sEOmY
X-Gm-Gg: ASbGncsUUYqRTQlJaLjYcK1r/p7yCDkNhvb9AYAWskE+SjgijlUzMsZ18BB56OUz1HL
	EnLWLABCYUoREl4SqEH4ut/YEtbRbRXQgOv6Ny8c=
X-Google-Smtp-Source: AGHT+IGz/iPNysbrY/SJGNJVdWbJT30mKa5RXDPAIPBua/O+yzLeFHjj5MrE9CcX90TlC+Rgu9DzgNVhXwUGmkc9vnE=
X-Received: by 2002:a05:6402:26d3:b0:5d9:a59:854a with SMTP id
 4fb4d7f45d1cf-5d972e07f98mr907958a12.13.1736303252920; Tue, 07 Jan 2025
 18:27:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107024553.2926983-1-kalesh-anakkur.purayil@broadcom.com>
 <20250107024553.2926983-3-kalesh-anakkur.purayil@broadcom.com> <20250107152452.GE87447@unreal>
In-Reply-To: <20250107152452.GE87447@unreal>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 8 Jan 2025 07:57:19 +0530
X-Gm-Features: AbW1kvZ7km3QePOhqPJT3M982PhFuJ_xN06RUBtWZggWS_H_mIqvyF6JPPj5ZTA
Message-ID: <CAH-L+nOVi5ef6hNo7+JrPRJ6dsrzqTymApU7BGqSk53OhKd9rg@mail.gmail.com>
Subject: Re: [PATCH rdma-next v2 RESEND 2/4] RDMA/bnxt_re: Add Async event
 handling support
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, andrew.gospodarek@broadcom.com, 
	selvin.xavier@broadcom.com, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a2045d062b289a77"

--000000000000a2045d062b289a77
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 8:54=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Tue, Jan 07, 2025 at 08:15:50AM +0530, Kalesh AP wrote:
> > Using the option provided by Ethernet driver, register for FW Async
> > event. During probe, while registeriung with Ethernet driver, provide
> > the ulp hook 'ulp_async_notifier' for receiving the firmware events.
> >
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/bnxt_re.h |  1 +
> >  drivers/infiniband/hw/bnxt_re/main.c    | 47 +++++++++++++++++++++++++
> >  2 files changed, 48 insertions(+)
>
> <...>
>
> > +static void bnxt_re_net_unregister_async_event(struct bnxt_re_dev *rde=
v)
> > +{
> > +     int rc;
> > +
> > +     if (rdev->is_virtfn)
> > +             return;
> > +
> > +     memset(&rdev->event_bitmap, 0, sizeof(rdev->event_bitmap));
> > +     rc =3D bnxt_register_async_events(rdev->en_dev, &rdev->event_bitm=
ap,
> > +                                     ASYNC_EVENT_CMPL_EVENT_ID_DCB_CON=
FIG_CHANGE);
> > +     if (rc)
> > +             ibdev_err(&rdev->ibdev, "Failed to unregister async event=
");
> > +}
> > +
> > +static void bnxt_re_net_register_async_event(struct bnxt_re_dev *rdev)
> > +{
> > +     int rc;
> > +
> > +     if (rdev->is_virtfn)
> > +             return;
> > +
> > +     rdev->event_bitmap |=3D (1 << ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFI=
G_CHANGE);
> > +     rc =3D bnxt_register_async_events(rdev->en_dev, &rdev->event_bitm=
ap,
> > +                                     ASYNC_EVENT_CMPL_EVENT_ID_DCB_CON=
FIG_CHANGE);
> > +     if (rc)
> > +             ibdev_err(&rdev->ibdev, "Failed to unregister async event=
");
>
> s/Failed to unregister async event/Failed to register async event
Looks like it was a copy-paste error :)

>
> If it is the only comment, we will get for this series. You don't need to=
 resend, I'll fix it.
>
> Thanks

Thank you Leon.
>
> > +}



--=20
Regards,
Kalesh AP

--000000000000a2045d062b289a77
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
AQkEMSIEIKBrmDRd9QGQ5Rfr+FT/1Nwy8K+5Sn++KSGUtTpj15XZMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDEwODAyMjczM1owaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCEWpDZCqM7
oSwinAZPxZJ7E0wn7QS3xzHVijhrXIUoANOFI9VrNp4bVWhfh4NUZecItdLIcG3hbnQXtdLDhHHk
YdGJdwecop7VRRJLPkiMtQchACCLZXgkJqBVdbQ7j5rjFiJD/xq8njvAGzEbnEMVjN/ud4CmQvSE
TDf/OyBjl2x7jgoOP59vlsMjXeqAdpyWW2/fiU1RVYJyPY53gF4Ihj1E8GaAjkwbtB9Apb4jk797
5Ar4ikwGyy1muX+CPpN088tqRAGmEHQGk7HYaCcZVEINXGN7rDF2W56SqG19GAexLSFaOIS8eSCw
ItXrxTlv3exs/mzDorxIwXMZ09pz
--000000000000a2045d062b289a77--

