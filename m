Return-Path: <linux-rdma+bounces-7421-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A80A28577
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 09:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F10077A35E7
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 08:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C758229B1A;
	Wed,  5 Feb 2025 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M9yvbkQe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56743215077
	for <linux-rdma@vger.kernel.org>; Wed,  5 Feb 2025 08:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738743870; cv=none; b=EKwIt4G5itm0IZ3bcKYdcrROWvhOfYrIFw70gCgWkNz7eFzk3BFgyT9M2RdG3tTy0DbB5z7PNs2XcsoVNOrWS/K5D4LcV5kOuLosgID4Wao5IEXRbGhs8QWnPCDwff9CA2r9RGTRSEP9PYqKXM/j4EDmhlpBKzn/AXCpW1zcnhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738743870; c=relaxed/simple;
	bh=d3yjDHbCDIhClncjQ+uaIU7E3SPx09B+CJI8Qxq5C6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sB1FQh4cc0KVK027/rekbvjfUA04/dcyxs/BnFp1vGUelhYk5l/ZNt2RDvFK1yLdlG1wHfrCNXa4PLF2Ex4TgWeZ+kQejKtM/osPt8BVU8vFq6GKQxpyYuOM8wbXLOdyPtnSIhxkzdYSCgLVUONU1VV6qvuG/isAAcESCsoHMr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=M9yvbkQe; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21644aca3a0so151344185ad.3
        for <linux-rdma@vger.kernel.org>; Wed, 05 Feb 2025 00:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738743867; x=1739348667; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HD5vslN4STumfYaBEo0p+YfhJLGC13DYFMWJAbGjkNc=;
        b=M9yvbkQe1N+sdYRIu+MlCm5CyXzoGpl3wBBa3/i4yZklwo7Tajo6S654ad8SocWQlA
         67RH/U0GlMkmcyMGpc3odsTuxy/lP5PQZM1767+CsaWzh4XANy8vbIwFbHDlbUxgX4sW
         UKJikwCVMHn8F9w6dqO3/Nqv1n14RZWJ4rMV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738743867; x=1739348667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HD5vslN4STumfYaBEo0p+YfhJLGC13DYFMWJAbGjkNc=;
        b=AYpnRC4N08JkSmienbgxkRLHBLWk3m8RFgZtXhiASBrvWu0Ln6OlRLqwdaVd9eWBjY
         p4S4jMXPwGmxP/eCfW/ZPl8r8z7tcg6TOUYj5LBMFCYNliXnTPN6g6Drf+MgQShgN4Ud
         Hm8LbAS0ULNqfCNte/aizXmFsGqm+dSfbxZINVn6D9kKCXJLX83FA6wajt1WzX8i2WL4
         boWL1Lvxir06ZWYEeYPZjgZk2kb0lEaRhbuN4vcqdcBb7EC9DA5TYlzlAlvV24fyfNED
         IUMHsj7vZMJgQyUuzRpStyylbcGWy9/2yvgXKalvnaQaTl3WG8Timty4O3aBKkqCIxqJ
         j5RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoSplcsCJGBPS555/5n6hjZALexYJsRUInFIXoVmNddTDvaN8SFGlPWDAV4PCxJwop2LmTR5veMNOr@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe+zFUvltpjDs8LvZBNr7nZvRDzTXa8U3A8JnPd/GnqraNOPl3
	apgv6drmFtewYSKXQArNaroEdll2ZomcUytiAh1tEngGlXBuOzmr8OCJunkZ+7r9mOtKuxm4UfP
	g4FJo3wL2EwNFITrNpOpnWrVGY/DBzUzUnMJmjpkzjUMJmSqC6g==
X-Gm-Gg: ASbGncthwBRMbIqgHCW0s+0SO6BLE47Y8Ynb3TLIoA7KNNiNh5oPiFGgvxwNpnLaRJk
	+gcz1umw70bnoEzcAw4BW0W6VyUdyv3pBTw2o7FFk0Uesm1Fz3OYcwd3s+4R5gFbima+9hvsx5A
	==
X-Google-Smtp-Source: AGHT+IEZRyZGfc4tF2rnBcs6zrK8pV1yyvlADHX1d/K+kLC+cYZ80J475jinSGgdc1x5yZFG0fzqKYa8krKIh5Or5kk=
X-Received: by 2002:a05:6a00:ad8d:b0:730:1da:8824 with SMTP id
 d2e1a72fcca58-730351ec1d0mr3236020b3a.19.1738743867182; Wed, 05 Feb 2025
 00:24:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1738657285-23968-1-git-send-email-selvin.xavier@broadcom.com>
 <1738657285-23968-3-git-send-email-selvin.xavier@broadcom.com>
 <20250204114400.GK74886@unreal> <CAH-L+nPzuSdKN=WQccTP2crfMp8hSLqq-uTXqw_Ck=sHtWbyEQ@mail.gmail.com>
 <20250205071747.GM74886@unreal>
In-Reply-To: <20250205071747.GM74886@unreal>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 5 Feb 2025 13:54:14 +0530
X-Gm-Features: AWEUYZk7n_1Tnt3yDVuHa_2r5kR2uD_XojVC1XMu9IZEfKNJvhIGW1c6E6nWJUo
Message-ID: <CAH-L+nM6+-v6dvgzA6UDhgbhjysr55BJ859N5aWWXNEm4k+EDw@mail.gmail.com>
Subject: Re: [PATCH rdma-rc 2/4] RDMA/bnxt_re: Add sanity checks on rdev validity
To: Leon Romanovsky <leon@kernel.org>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000952712062d60da9b"

--000000000000952712062d60da9b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leon,

On Wed, Feb 5, 2025 at 12:47=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Tue, Feb 04, 2025 at 10:10:38PM +0530, Kalesh Anakkur Purayil wrote:
> > Hi Leon,
> >
> > On Tue, Feb 4, 2025 at 5:14=E2=80=AFPM Leon Romanovsky <leon@kernel.org=
> wrote:
> > >
> > > On Tue, Feb 04, 2025 at 12:21:23AM -0800, Selvin Xavier wrote:
> > > > From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > > >
> > > > There is a possibility that ulp_irq_stop and ulp_irq_start
> > > > callbacks will be called when the device is in detached state.
> > > > This can cause a crash due to NULL pointer dereference as
> > > > the rdev is already freed.
> > >
> > > Description and code doesn't match. If "possibility" exists, there is
> > > no protection from concurrent detach and ulp_irq_stop. If there is su=
ch
> > > protection, they can't race.
> > >
> > > The main idea of auxiliary bus is to remove the need to implement dri=
ver
> > > specific ops.
> >
> > There is no race condition here.
> >
> > Let me explain the scenario.
> >
> > User is doing a devlink reload reinit. As part of that, the Ethernet
> > driver first invokes the auxiliary bus suspend callback. The RDMA drive=
r
> > will do the unwinding operation and hence rdev will be freed.
> >
> > After that, during the devlink sequence, Ethernet driver invokes the
> > ulp_irq_stop() callback and this resulted in the NULL pointer
> > dereference as the RDMA driver is in detached state and the rdev is
> > already freed.
>
> Shouldn't devlink reload completely release all auxiliary drivers?
> Why are you keeping BNXT RDMA driver during reload?

That is the current design. BNXT core Ethernet driver will not destroy
the auxiliary device for RDMA, but just calls the suspend callback. As
a result, RDMA driver will remains loaded and remains registered with
the Ethernet driver instance.
> BNXT core driver controls reload, it shouldn't call to drivers which
> doesn't exist.
Since the RDMA driver instance is registered with Ethernet driver,
core Ethernet driver invokes the callback.
>
> >
> > We are trying to address the NULL pointer dereference issue here.
>
> You are hiding bugs and not fixing them.

Yes, but this change is critical for the current design of the driver.
>
> >
> > The driver specific ops, ulp_irq_stop and ulp_irq_start are required.
> > Broadcom Ethernet and RDMA drivers are designed like that to manage
> > IRQs between them.
> >
> > Hope this clarifies your question.
> > >
> > > >
> > > > Fixes: cc5b9b48d447 ("RDMA/bnxt_re: Recover the device when FW erro=
r is detected")
> > > > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > > ---
> > > >  drivers/infiniband/hw/bnxt_re/main.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infinib=
and/hw/bnxt_re/main.c
> > > > index c4c3d67..89ac5c2 100644
> > > > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > > > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > > > @@ -438,6 +438,8 @@ static void bnxt_re_stop_irq(void *handle, bool=
 reset)
> > > >       int indx;
> > > >
> > > >       rdev =3D en_info->rdev;
> > > > +     if (!rdev)
> > > > +             return;
> > >
> > > This can be seen as an example why I'm so negative about assigning NU=
LL
> > > to the pointers after object is destroyed. Such assignment makes laye=
r
> > > violation much easier job to do.
> > >
> > > Thanks
> > >
> > > >       rcfw =3D &rdev->rcfw;
> > > >
> > > >       if (reset) {
> > > > @@ -466,6 +468,8 @@ static void bnxt_re_start_irq(void *handle, str=
uct bnxt_msix_entry *ent)
> > > >       int indx, rc;
> > > >
> > > >       rdev =3D en_info->rdev;
> > > > +     if (!rdev)
> > > > +             return;
> > > >       msix_ent =3D rdev->nqr->msix_entries;
> > > >       rcfw =3D &rdev->rcfw;
> > > >       if (!ent) {
> > > > @@ -2438,6 +2442,7 @@ static int bnxt_re_suspend(struct auxiliary_d=
evice *adev, pm_message_t state)
> > > >       ibdev_info(&rdev->ibdev, "%s: L2 driver notified to stop en_s=
tate 0x%lx",
> > > >                  __func__, en_dev->en_state);
> > > >       bnxt_re_remove_device(rdev, BNXT_RE_PRE_RECOVERY_REMOVE, adev=
);
> > > > +     bnxt_re_update_en_info_rdev(NULL, en_info, adev);
> > > >       mutex_unlock(&bnxt_re_mutex);
> > > >
> > > >       return 0;
> > > > --
> > > > 2.5.5
> > > >
> >
> >
> >
> > --
> > Regards,
> > Kalesh AP
>
>


--=20
Regards,
Kalesh AP

--000000000000952712062d60da9b
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
AQkEMSIEIPYdR//9Ye3vMvswn8CKAxQVX/lGh7r0Y8/fERyHMcaNMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIwNTA4MjQyN1owaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBy6/DrXA1k
L/KLNzfx+TSfJjlv7hYA8vqHmpuOvoguPhcOl2hPlp4gJfL1dWWCTGR86p42gQu3bEcmtiIOhtS2
qSbeNzUH038gzAlH8zWBZx2havEkrjohWajT3hWBZHp3TjDZH5Ou+tR8x+Am0R8K1cbyq2CnkpfN
4rhmjuWNz/AULUZ6VwjNMUpHzxQrzQcpGT1skrg798XjyslIL4EKBM69MN3h/7W1y9cFScSVxkVG
+gXSWf9Lh8ZukLGR+bIrMeIr9KMRmbb5k7PaP3rgS82to7lOg/WMxV6rd9qxaADWalEGgeLNPHou
hCf+LcttjGBNIJOtXcKgKJCOQm55
--000000000000952712062d60da9b--

