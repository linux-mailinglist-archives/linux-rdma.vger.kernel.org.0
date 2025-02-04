Return-Path: <linux-rdma+bounces-7403-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03625A27769
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 17:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF91C18820E8
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 16:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD3C2153F3;
	Tue,  4 Feb 2025 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dzdvFL+8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058C82153EF
	for <linux-rdma@vger.kernel.org>; Tue,  4 Feb 2025 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687253; cv=none; b=BUUf9B6ioso1OK41SiLFTUnU07mOEyPuAoVRPx2HScvc4uPu9y99VHOMqobBfq52m0oBbBsXnR8zGl36KBBvIyh5eZXPwy/fYbeC7C5aOhTFSIawhB38N+ufGNO6G6jFfsHtaY4CjdaSnlWu39MVNb+Y2WhpjEYTDIn/3lzjmk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687253; c=relaxed/simple;
	bh=+sWG/Whtiv5hLhaaOr1gDihEsjuwTeA9MNZsHMYP3RY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKQ5SGX8uOz0x/6GopC2vBm6Q12f8OOMikhbuY/nqgN9+pd9hpPLzAk/hI7Msoawj6cccB6cpkGpCiXUzVnwBKGDMgF6KFPLDKi8P7a7Sv2lW8c/k29xn9aeG/dKHANlHb+W0p5A46m/u6zEQag4LfGXf8vA/Mb1aGgpnsjXvWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dzdvFL+8; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f44353649aso7704992a91.0
        for <linux-rdma@vger.kernel.org>; Tue, 04 Feb 2025 08:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738687251; x=1739292051; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V0odHrCCb7aVxCww94fNUREllLnxEpXv0GfXjyGtEfM=;
        b=dzdvFL+80n3EtowNZmaUnzE6V5rIB9hW5JDXiXljbt1zYHsBEvoe82Y1+9P7GhSwhY
         LmrdSIkQphWN3dPnx75p+0ciKomF5U+/ddhY11ABrG6HGVlnnXzDF6xW0HA+SC4PYBAU
         se+uADIQLhh9eIAQbndUS6op5NC/9D6AyJ8kE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738687251; x=1739292051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0odHrCCb7aVxCww94fNUREllLnxEpXv0GfXjyGtEfM=;
        b=STLLd1+8nGR3ZK0Si1i2CcyuRqxWBONDBcZCWMOD0gWtRZS+z4uFuBADDkt/T5oZ2o
         ONIwQVeZP1fX2UyMSeJ0kANAJ7EQDB9KghRgtJjCrnh7OkxEvEjLIgFyZD8cZvShPHnl
         c8wMDasI/VMQdV+rBkKrD9J576t82j2K6ttIgMhoQrQfZBK8/z5CahA91HLnGFj047/y
         kylVUiATW6qhxD/JqSpxKNN04p7q8bFswmfophK+atgWP0qqNi2pCRTc0ZWYuiGSqdXk
         PnLRLmQ6b/9f/voaDdE2hVr4e8G3STq1OEwAXuYMuKYbbgcRPTpTrnk7DjhpxAdH5bzJ
         R9Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVffTXRfrH0UeNTbm5YdM0diecZSng31Bob7ihSebJ+JiQPJrzd90ZErZ00vUie4/ngCIxOZNyU0arg@vger.kernel.org
X-Gm-Message-State: AOJu0YxKsAgbvDUaSJ+kEmVnkJzKCORJ8AoNDrv4NrBTqoi62X5HDDc6
	4H/X5oXSm/ypcUw+gw4POweaFXnrSh0Mwq59KziSge2QG4Aa96uGq/ZiYj0Bpzs+almQxD+9ofS
	vPdmTakbvSNgDoSYcxo0nzthTYahr8x55MqnX
X-Gm-Gg: ASbGncsPILycx/oHV1RlIPhhlKuVeu/qphBEni/8If8q1uG2XGuYfJQ2gTDZlsjBbB8
	UGsnlZM4w6jKmFD/l+K9KQOT0s17iyHqfgt0Y8GskMkqMAPeE68lTKnre6h1LoZt/BmqjoYg=
X-Google-Smtp-Source: AGHT+IFLlXriod/VCGUdHVo9R3faS7h0x6PQ+9G1U8xASuyheC8fhZp8vZKMJxRnPR0x40FMGJtezhoC0n33I8PNqAA=
X-Received: by 2002:a05:6a00:1d88:b0:725:456e:76e with SMTP id
 d2e1a72fcca58-72fd0be3561mr35443631b3a.6.1738687251161; Tue, 04 Feb 2025
 08:40:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1738657285-23968-1-git-send-email-selvin.xavier@broadcom.com>
 <1738657285-23968-3-git-send-email-selvin.xavier@broadcom.com> <20250204114400.GK74886@unreal>
In-Reply-To: <20250204114400.GK74886@unreal>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 4 Feb 2025 22:10:38 +0530
X-Gm-Features: AWEUYZmX0B0mFIhAQCxMA2u-qfFt1QIukv_ijCBV4baRwoY4yEOUeEB0z3vTvFI
Message-ID: <CAH-L+nPzuSdKN=WQccTP2crfMp8hSLqq-uTXqw_Ck=sHtWbyEQ@mail.gmail.com>
Subject: Re: [PATCH rdma-rc 2/4] RDMA/bnxt_re: Add sanity checks on rdev validity
To: Leon Romanovsky <leon@kernel.org>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ff7b68062d53ab38"

--000000000000ff7b68062d53ab38
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leon,

On Tue, Feb 4, 2025 at 5:14=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Tue, Feb 04, 2025 at 12:21:23AM -0800, Selvin Xavier wrote:
> > From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> >
> > There is a possibility that ulp_irq_stop and ulp_irq_start
> > callbacks will be called when the device is in detached state.
> > This can cause a crash due to NULL pointer dereference as
> > the rdev is already freed.
>
> Description and code doesn't match. If "possibility" exists, there is
> no protection from concurrent detach and ulp_irq_stop. If there is such
> protection, they can't race.
>
> The main idea of auxiliary bus is to remove the need to implement driver
> specific ops.

There is no race condition here.

Let me explain the scenario.

User is doing a devlink reload reinit. As part of that, the Ethernet
driver first invokes the auxiliary bus suspend callback. The RDMA driver
will do the unwinding operation and hence rdev will be freed.

After that, during the devlink sequence, Ethernet driver invokes the
ulp_irq_stop() callback and this resulted in the NULL pointer
dereference as the RDMA driver is in detached state and the rdev is
already freed.

We are trying to address the NULL pointer dereference issue here.

The driver specific ops, ulp_irq_stop and ulp_irq_start are required.
Broadcom Ethernet and RDMA drivers are designed like that to manage
IRQs between them.

Hope this clarifies your question.
>
> >
> > Fixes: cc5b9b48d447 ("RDMA/bnxt_re: Recover the device when FW error is=
 detected")
> > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/main.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/=
hw/bnxt_re/main.c
> > index c4c3d67..89ac5c2 100644
> > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > @@ -438,6 +438,8 @@ static void bnxt_re_stop_irq(void *handle, bool res=
et)
> >       int indx;
> >
> >       rdev =3D en_info->rdev;
> > +     if (!rdev)
> > +             return;
>
> This can be seen as an example why I'm so negative about assigning NULL
> to the pointers after object is destroyed. Such assignment makes layer
> violation much easier job to do.
>
> Thanks
>
> >       rcfw =3D &rdev->rcfw;
> >
> >       if (reset) {
> > @@ -466,6 +468,8 @@ static void bnxt_re_start_irq(void *handle, struct =
bnxt_msix_entry *ent)
> >       int indx, rc;
> >
> >       rdev =3D en_info->rdev;
> > +     if (!rdev)
> > +             return;
> >       msix_ent =3D rdev->nqr->msix_entries;
> >       rcfw =3D &rdev->rcfw;
> >       if (!ent) {
> > @@ -2438,6 +2442,7 @@ static int bnxt_re_suspend(struct auxiliary_devic=
e *adev, pm_message_t state)
> >       ibdev_info(&rdev->ibdev, "%s: L2 driver notified to stop en_state=
 0x%lx",
> >                  __func__, en_dev->en_state);
> >       bnxt_re_remove_device(rdev, BNXT_RE_PRE_RECOVERY_REMOVE, adev);
> > +     bnxt_re_update_en_info_rdev(NULL, en_info, adev);
> >       mutex_unlock(&bnxt_re_mutex);
> >
> >       return 0;
> > --
> > 2.5.5
> >



--=20
Regards,
Kalesh AP

--000000000000ff7b68062d53ab38
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
AQkEMSIEIEM4ovC99kxQUAL2zyH1NrUvqRThuv8e/sFE7KCfqNyDMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIwNDE2NDA1MVowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCgmsYf+++F
7Rw3wZWcbdFyDJoxsZDIygXnKmozb1iQ6JjPQqNBstwUs0Jj4ab1L7xriHDPXlTMuh9cEZnl9GsE
M/oF/EM5mgkLnTR8zTUZ4/OsT9g0GkOy5atLobq/ablsTwvtKsyDVpXzBXNjNVYNqot1h5r4rMGZ
iaeETfWpbOF1TqOdUOxyTdmZWmqS/9PV3aalCzPXuNiNeO7nblpbpoMBY7ufwQWrqjnYvbH8WyLE
ckbMs576CxQx1H63cYMXkwowrYW86cImL4qyLkVPg/CqcyBXkhDuSFpCE0gdsMtSMzRMd20RHFa5
y9OujVHuGzOteWU6W9o3ds5v3BNl
--000000000000ff7b68062d53ab38--

