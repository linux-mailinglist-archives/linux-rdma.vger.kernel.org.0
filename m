Return-Path: <linux-rdma+bounces-10513-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3D9AC0335
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 05:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B69EA24AE2
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 03:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39DC14B07A;
	Thu, 22 May 2025 03:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Jav3xui0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934907346F
	for <linux-rdma@vger.kernel.org>; Thu, 22 May 2025 03:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747885920; cv=none; b=mgnnrGYih+jDaJ1OdHjRL1Oe6Ck5r14DYZ6NfSMO6ETsaa5S/Div66juRWnUFFFTzpii4btfhDx56I1MD53Ck2RlQ9sRIUIJmynh7o6J4sQEhpNXaPgPtZwuQ0ZMHbphWPLXmJO5ZBFvS9lPu3MLmoCpn5gqWR+kYUct2ivcYgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747885920; c=relaxed/simple;
	bh=Vk8JGqwbN95+PJTUYhI2j6vrT089b4xQOanLrBLI3no=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNS3XKcRiuS++rGVidE6K7g1kz2Ft9gZ/Km1y5MMN1e9RwMkhXoXZ8Hpy7vh//4WXSdFl/K9q6yjUMnJqHrJSkfpepfa470Qs5QjP+bwJezK//JaHHucac7CqxCbK9CFWXSKlgavYgw1nOyRVU5tiFlLB5z8IHcUVa9M8yjKXdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Jav3xui0; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso7302707b3a.2
        for <linux-rdma@vger.kernel.org>; Wed, 21 May 2025 20:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747885918; x=1748490718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vk8JGqwbN95+PJTUYhI2j6vrT089b4xQOanLrBLI3no=;
        b=Jav3xui0M5bjqgfsytoxIF98U18rXHBzbsEQRu/IvmqPOkcqib7x5gWSGnZDeUZiRk
         u5efwlIIGaoC0raOP2Usd20PxSA8MTm1lm4o1UYmipVhftDJ0ftbMZ8n6/Jh1eALFToQ
         W3d4IIZ2a1UFNfMH3+69lJHRuShi94uyOxQYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747885918; x=1748490718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vk8JGqwbN95+PJTUYhI2j6vrT089b4xQOanLrBLI3no=;
        b=lrBrccnRl5kKlsxJbw/Ej3zupkuCgRZLdNsGL0m81R6h5Jk/MkKEe1WGPWzRVet+zi
         KSsCqFhj8I14xjL8fAW5xRruIZvEfz5yjFgynOTRlMMSvZujd7JJwzRzBSPKYzf1zGO/
         tQUXUohTgIvnyP9IaDZgBFGcMQp0KsTvHDrk0yYZ9/1QzHzv36rLQ7T3DzbPsX/Dg2IX
         NQO0kYL9VhmN3Gr7IH9XYV1y4WGlQc7Jx/YO/DJkjqs6qvdlBMhPTa81awEL2k3Bsi3W
         rOyp/Ez581U/ky5oeFA9px31cwIoLUC/gZD62kY5Bn88lAM//ZWRwmLZ8PCOqW0QnO0U
         cNyw==
X-Forwarded-Encrypted: i=1; AJvYcCWCrv+KLbevQUZs+UcerEvOa4hV0biITRRuEQxkwAp5nOt4xmWEyUEVuSNHmvgOtAl2F/xO568ZAw6w@vger.kernel.org
X-Gm-Message-State: AOJu0YxvVAT+94G0rW3Fw7DaARdbJaxzfLch8hyN+MuDfWk8AcklD3Oo
	XCZd/Scyu3O8rbibYNvGUwW7vOCCNIF+mFqCZxVrAMiVSX/ctnNW23F4Uc+fDlbIl1pAL24NxZl
	XHwOHG+SpLt05UWuUaRJAPPKp50nwIRej26MvALaJ
X-Gm-Gg: ASbGncstwKd88743OVQu0TevEypcv7sr+tGiV/vOvSdfskuR3BOY0T4dFOXcpXp5o7X
	QHS7z46lG7TlwbHI39yh0Qgib+jPab4ToY0AWo4YkyfaU3g2mLk8Ra6zCN15vALMME0a8dU8oeE
	jmPthXC2Le04pb6e/OjsgsadtZ0ZmJjakMHQ==
X-Google-Smtp-Source: AGHT+IEWcjkNFg+edrlm7X5JYJTziFWnQgyuAK4RGyMlN4lpda8/ReKdiSUt61SJg3kAG0L0TSkwakX+41hXt20uWms=
X-Received: by 2002:a05:6a20:7353:b0:215:df62:7d51 with SMTP id
 adf61e73a8af0-216218ca4acmr34162885637.11.1747885917778; Wed, 21 May 2025
 20:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4f3640b501e48d0166f312a64fdadf72b059bd04.1747827103.git.leon@kernel.org>
In-Reply-To: <4f3640b501e48d0166f312a64fdadf72b059bd04.1747827103.git.leon@kernel.org>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Thu, 22 May 2025 09:21:46 +0530
X-Gm-Features: AX0GCFuM-y_FUk_bYeGGFcqFeDm0bKWxc_uFK9e_XVXnxh3_cj-VMJFogSlVloM
Message-ID: <CAH-L+nN3kUP89FtJ9vFQW1zLs4euONJqEzUZT2Qc1PM3=yXS7A@mail.gmail.com>
Subject: Re: [PATCH rdma-rc] RDMA/cma: Fix hang when cma_netevent_callback
 fails to queue_work
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jack Morgenstein <jackm@nvidia.com>, Feng Liu <feliu@nvidia.com>, 
	=?UTF-8?B?SMOla29uIEJ1Z2dl?= <haakon.bugge@oracle.com>, 
	linux-rdma@vger.kernel.org, Patrisious Haddad <phaddad@nvidia.com>, 
	Sharath Srinivasan <sharath.srinivasan@oracle.com>, Vlad Dumitrescu <vdumitrescu@nvidia.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004146ab0635b1678a"

--0000000000004146ab0635b1678a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 5:06=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Jack Morgenstein <jackm@nvidia.com>
>
> The cited commit fixed a crash when cma_netevent_callback was called for
> a cma_id while work on that id from a previous call had not yet started.
> The work item was re-initialized in the second call, which corrupted the
> work item currently in the work queue.
>
> However, it left a problem when queue_work fails (because the item is
> still pending in the work queue from a previous call). In this case,
> cma_id_put (which is called in the work handler) is therefore not
> called. This results in a userspace process hang (zombie process).
>
> Fix this by calling cma_id_put() if queue_work fails.
>
> Fixes: 45f5dcdd0497 ("RDMA/cma: Fix workqueue crash in cma_netevent_work_=
handler")
> Signed-off-by: Jack Morgenstein <jackm@nvidia.com>
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
LGTM,
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>


--=20
Regards,
Kalesh AP

--0000000000004146ab0635b1678a
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
AQkEMSIEIHRCuFSKxzp+6WC0GSgmrCJsOq37SaSV8OyaUkeFwe5eMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDUyMjAzNTE1OFowXAYJKoZIhvcNAQkPMU8wTTAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAEfENMg7Yp0P9ILV7t1SPIGwD5KJ
S23sqjOF5QxomFCwiate4DjbYXbexLA6K22DbtCvgsZvjl8GoSzQy34CwCVyHfvByArPh28tMxbw
VcJfH3Y6mNOcrJbyq2LKV2pa2t2jrvgHThu3SKG79Lkqu+X6cN+92zVdcFuH4XwwzGutUNqgLjPo
8UuaQzMAyyEb+SwOfRptZxfOEUdK1JwhJcHeGC25f+P0zAuWBwitwZvtiWaGCQAYYNFv+LlAXy2K
CYg/4ENZ+kYZNnujVXNEpyMw6x1wP7Xg14PivyUbFy6e1P6/9uviOfASSIjKgainJmPV82+icm5H
7D2W+7GMmjI=
--0000000000004146ab0635b1678a--

