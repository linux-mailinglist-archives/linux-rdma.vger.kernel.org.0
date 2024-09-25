Return-Path: <linux-rdma+bounces-5086-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9222B98568B
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2024 11:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BB5C1C22783
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2024 09:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E85C15C12F;
	Wed, 25 Sep 2024 09:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q09PS6GA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21257156257
	for <linux-rdma@vger.kernel.org>; Wed, 25 Sep 2024 09:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727257298; cv=none; b=YIxMoYIZovn7RfOG2eVg4jl29ArYTkpJNtdbw5BiG0uNYonxKkydE79IjR6oFWwKL2gUjZtdgssNrcr1eL0272axBTmF7aH1/r+N2wb6oGEj9q4OJVvlnS35rc8/nx2OwQ4L8x8mMoA0btto0yZUjhncr/PKUBeyQUh1K6YlZCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727257298; c=relaxed/simple;
	bh=kvdbfeDHWgUyrvDNWE4n+HIIiMmYRnJeOCZotDVb9Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWonobF5U5wZHgzkYvy8+qs8mvmBKG7Tc97tajVHrCwUHLuD5HqctRHdp5v8JRhrROEJoWtb/ez+xvqYP+hSNK/1HXg7cypoKLUatmxSBHCnDa/VsF5kEBuk1VsZ5hEspGyUNrp95QsiNVn/iCIABouK3mlJX1nfGk8kSam3EMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q09PS6GA; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-535dc4ec181so6520671e87.3
        for <linux-rdma@vger.kernel.org>; Wed, 25 Sep 2024 02:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727257294; x=1727862094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcEc/KqqTpMPEAnxV6Bnt+k19aAvn2ICJSp20VGGoZc=;
        b=Q09PS6GAaKVqh6cTSwodvObuowL7v5/fWNtyjFBZ+iGYpELL6PjvCI6Fgm8emEKxzY
         v63ci0EIVmDpWhTvRAHywBqaYHI7WLXKUqWoomgHbF5u1OtNUFFViwR5wjen9vf38Q7P
         GMHOilt3n26UGKL+AU/uoyo4xhhy6fISaKEgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727257294; x=1727862094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcEc/KqqTpMPEAnxV6Bnt+k19aAvn2ICJSp20VGGoZc=;
        b=bM0K641hCEZGLWd0LWR2FYbDPjvaMbsL+mbHmWXQ0/jsqFJwgaPSRxdAgOqPQQ/f7+
         bd0Am/5dTeHq9g1SSx78E/fl2Ye9anwJH5h+DgHJvInwv7I2+mP0qhHsPgwc7aM63HyY
         DAZAkHGnN0p/6FwH2c0whLGxxK0vngM6PMwzBCQ0b6q7On3ACIGl9bjZfDnr2zh59fr4
         lsv/HDnHIxv8LuJ/EeVDwnfpH4J7rSV6XmDvpNboQrM8ifucccw34YiUroGBgwqZ2DqT
         ukeDBr3GpUDQ16E66FsfijMDsAL+agF5meSTSbQklTwEPiJvu2u1D7fwP5I9hdv8ngtU
         vUtw==
X-Forwarded-Encrypted: i=1; AJvYcCXFJ8F9Yy5Cc6rKigQxQHrQXp4m+P5ec1hVSmnUkVM6bI0Li6J6M+66E+7rWp2PnyFJ4moyULdw+PpO@vger.kernel.org
X-Gm-Message-State: AOJu0YxPCt3Gc3nGXcQPP1tXUmTYjZU8KnE/0GGDFDLUU+VuPyfV8H7D
	FSzoj2BawzO1V703WVr8jUbrEzPOV6+zuZc7BsPg1gk5rFNCl6Zh4ShqItGYM9bb8saYRUfnfNG
	wyXSdUlH6A8NU9xrOVK3VCWEx65ir3I/6Iy88
X-Google-Smtp-Source: AGHT+IEMA8LWN1SXzuCDH1brJIxPxoEOi7CkQq/v+YGTaEoGQNjreonLiCidEnDTTzRqANPwsrCclajNdsb2sY3pxio=
X-Received: by 2002:a05:6512:1104:b0:52f:159:2dc5 with SMTP id
 2adb3069b0e04-5387755cc3bmr1331612e87.42.1727257294028; Wed, 25 Sep 2024
 02:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <93e73332-d1c4-40f7-a8f3-928600bdd975@stanley.mountain>
In-Reply-To: <93e73332-d1c4-40f7-a8f3-928600bdd975@stanley.mountain>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 25 Sep 2024 15:11:21 +0530
Message-ID: <CAH-L+nMCwymKGqf5pd8-FZNhxEkDD=kb6AoCaE6fAVi7b3e5Qw@mail.gmail.com>
Subject: Re: [bug report] RDMA/bnxt_re: Change aux driver data to en_info to
 hold more information
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Chandramohan Akula <chandramohan.akula@broadcom.com>, linux-rdma@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000079b6c90622ee6dca"

--00000000000079b6c90622ee6dca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Dan for the report.

We will post a fix upstream at the earliest.

On Wed, Sep 25, 2024 at 3:00=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Hello Chandramohan Akula,
>
> Commit dee3da3422d5 ("RDMA/bnxt_re: Change aux driver data to en_info
> to hold more information") from Sep 10, 2024 (linux-next), leads to
> the following Smatch static checker warning:
>
>     drivers/infiniband/hw/bnxt_re/main.c:1875 bnxt_re_add_device()
>     error: NULL dereference inside function 'bnxt_re_update_en_info_rdev(=
(0), en_info, adev)()'
>
> drivers/infiniband/hw/bnxt_re/main.c
>     1830 static int bnxt_re_add_device(struct auxiliary_device *adev, u8 =
op_type)
>     1831 {
>     1832         struct bnxt_aux_priv *aux_priv =3D
>     1833                 container_of(adev, struct bnxt_aux_priv, aux_dev=
);
>     1834         struct bnxt_re_en_dev_info *en_info;
>     1835         struct bnxt_en_dev *en_dev;
>     1836         struct bnxt_re_dev *rdev;
>     1837         int rc;
>     1838
>     1839         en_info =3D auxiliary_get_drvdata(adev);
>     1840         en_dev =3D en_info->en_dev;
>     1841
>     1842
>     1843         rdev =3D bnxt_re_dev_add(aux_priv, en_dev);
>     1844         if (!rdev || !rdev_to_dev(rdev)) {
>     1845                 rc =3D -ENOMEM;
>     1846                 goto exit;
>     1847         }
>     1848
>     1849         bnxt_re_update_en_info_rdev(rdev, en_info, adev);
>     1850
>     1851         rc =3D bnxt_re_dev_init(rdev, op_type);
>     1852         if (rc)
>     1853                 goto re_dev_dealloc;
>     1854
>     1855         rc =3D bnxt_re_ib_init(rdev);
>     1856         if (rc) {
>     1857                 pr_err("Failed to register with IB: %s",
>     1858                         aux_priv->aux_dev.name);
>     1859                 goto re_dev_uninit;
>     1860         }
>     1861
>     1862         rdev->nb.notifier_call =3D bnxt_re_netdev_event;
>     1863         rc =3D register_netdevice_notifier(&rdev->nb);
>     1864         if (rc) {
>     1865                 rdev->nb.notifier_call =3D NULL;
>     1866                 pr_err("%s: Cannot register to netdevice_notifie=
r",
>     1867                        ROCE_DRV_MODULE_NAME);
>     1868                 return rc;
>     1869         }
>     1870         bnxt_re_setup_cc(rdev, true);
>     1871
>     1872         return 0;
>     1873
>     1874 re_dev_uninit:
> --> 1875         bnxt_re_update_en_info_rdev(NULL, en_info, adev);
>                                              ^^^^
> Passing NULL here will lead to a crash.
>
>     1876         bnxt_re_dev_uninit(rdev, BNXT_RE_COMPLETE_REMOVE);
>     1877 re_dev_dealloc:
>     1878         ib_dealloc_device(&rdev->ibdev);
>     1879 exit:
>     1880         return rc;
>     1881 }
>
> regards,
> dan carpenter
>


--=20
Regards,
Kalesh A P

--00000000000079b6c90622ee6dca
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
AQkEMSIEIEoLMQlmXMv+EAHqahcUQwfIvqmDSxB3e0NLb8Wd6u2HMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDkyNTA5NDEzNFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAgYUgRnhci
YI8S0d8MAjCsWuCaa+oOxei734reaPzjG6cNopXB6pFfg5SeAZMFlAZuvxW/wYe/y1OgH+fJXoXM
pcJz7Ma6S++3ZYxZgLiCvR5AA72KFa1Hn6OkgLmmczosncidBZt7KngN1TorCkNMHr/Mee1BzVRc
NZccqN3TzAH9iiCSRI5PlWdNtbPjEakdKBLn3FX6gCjTq/d/GXYddNAJOSlQCTK4hYfige4yvB39
sWZelAUEx8XqUx88rTnwSJtF4mnCle66UFkfTW9A0Nghuub/5mLdN1JOFH1NNW6mpNHPrDJ7faav
Qjn73opvBYS2I5iHcPqdptJj7lUR
--00000000000079b6c90622ee6dca--

