Return-Path: <linux-rdma+bounces-9363-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B0DA851CA
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 04:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8228E9A17A6
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 02:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C551427C141;
	Fri, 11 Apr 2025 02:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F363VJH0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07493215162
	for <linux-rdma@vger.kernel.org>; Fri, 11 Apr 2025 02:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744340192; cv=none; b=uUGcZJDxfGOI83EAVZ8syLfTEsv/kK6GNqo0aQTDZyy8GWdlyw/eqdcT81mvyiaPrQy8za6kEJ90H9lX6jKwoLKwrpK49nxtJF3cB4zSRvOI08ZfsJmsU5Mp9+MCcR3vpEaaAb/VKG/NUIE4oZSbHPnSKgn92dMuw4fzHxvR0qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744340192; c=relaxed/simple;
	bh=xEogTZwEKcGp3GqEdXXDD4xNbYAKv9NYk/iMJ0iBPTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXsIgT5tdv0kfYmRTKENNrzTeW2jNOergMLGpJm96dKk4/TyeLDYsYKm2kXKkStgptKHs3qcRbZsujwiLk8YNuJwjb9n+Qz08OcEpC3vhz0Y21yIeZEvFHMq6EEWLv+Pg3MR2yjtNjb9JofXse5A45l+EJk1BtC8T++JH/4EZ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F363VJH0; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736b98acaadso1476807b3a.1
        for <linux-rdma@vger.kernel.org>; Thu, 10 Apr 2025 19:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744340190; x=1744944990; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y53JKEBtX4FgrKeet1JnGo1IS16D2V/yj57K2h/1uK0=;
        b=F363VJH0nWa1VHGqiluiVDhJgbSmmlMvpEVUppQhtlKemza68iZO4i1P8/dB03FsG2
         utgEyU+QjgHdNWconD4FyYQyYSUx5lpoYOh4wgFRWgpHIovpfE2f7TVqxJjTiDIZLmll
         3YQVLkmDKi6/ea9fm1zBOBKHqSU3bjyb8tX3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744340190; x=1744944990;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y53JKEBtX4FgrKeet1JnGo1IS16D2V/yj57K2h/1uK0=;
        b=cShZsclIp83CWzQDrPdMA6s5+eRH/Hy/wr0GSFUMpsjzqFO9ECSDr//juUwqi4RShl
         4Qiw5VX1V77psNtQiJwFfkkjL0J0hphODyalgti1uZMKjvLFzcNtRXTRM7T9xFV++YYc
         /mhofjr210eoTjj9Zn/1R+TSbvISCB6yjLaMZ2taT5ZDA8LJndhZ9SS8qV496BV+A2of
         05RQHzpdIccI9ORN/nwgmsGXyfoM7CDi/aRrDxF1+nyZgc21p5NUB8Vdbwmlg0XTiO51
         82ypiswswsZTby98suW8Dgsd6IHldgBT6X8otAsKkBT/5lp2FTlvG0NfiHDnD3LfMYKx
         2MIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJZam0+93bacCGoAC2/CjBAXVnlDGcAmTZgaJXre6GFnZyhixS7e4Pn5Gjm9r/R1RqRVZxKr3h5cuI@vger.kernel.org
X-Gm-Message-State: AOJu0YwX3b5Pt03i1Hk30mOv+c62qOmhDEwCCrjVzt2rUgGOe4vVqX1u
	G1UX/8ATAuNJitKDmVF7SQWDXyuRURP/p8Mr0KQSayVqy9NpVNZVBLY2o9JnGnDvKJJxrDvZst/
	MHEaQPeCh6o/ONQNgHC9WyopfeaCXFIwgpeCVtq54neLtsps=
X-Gm-Gg: ASbGnctPcBy7UWSAnSxJdRTgHgr7P0PvOZwbxGJuLtHo/2gaO16NVrQeU5kNuoleuqP
	S/HAIxUIKtonrgVET7gXKIrguVZI+5wlIlvuuMancD7TW9JlUDaQQAj1Kt2dw/mJkt/BEjDaqXr
	fe9dF3E9i68/0sYd9Sj1zpfvi3ty1d1PaJew==
X-Google-Smtp-Source: AGHT+IEoWN9JLcw1JFUmk1iggBuZAxOHiEwGkE7OGsORnNnnTBkFA1lAQSIMnK3Su4AuMCPk6xqFG+1hjihDAAUojVA=
X-Received: by 2002:a05:6a00:2188:b0:736:5dae:6b0d with SMTP id
 d2e1a72fcca58-73bd11e60d1mr1626323b3a.10.1744340189613; Thu, 10 Apr 2025
 19:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8a4343e217d7d1c0a5a786b785c4ac57cb72a2a0.1744288299.git.leonro@nvidia.com>
In-Reply-To: <8a4343e217d7d1c0a5a786b785c4ac57cb72a2a0.1744288299.git.leonro@nvidia.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Fri, 11 Apr 2025 08:26:16 +0530
X-Gm-Features: ATxdqUFZbfNG4M9rUjIZ8YQl4kaPr7DC7JiQ3tHp0wFqShAo60iE7zAWhH41uzQ
Message-ID: <CAH-L+nOZwww1yzG2ccHZL3GL=cd1k89e7Nvy-VRwCiu6g_a4jw@mail.gmail.com>
Subject: Re: [PATCH rdma-rc] RDMA/bnxt_re: Remove unusable nq variable
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Kashyap Desai <kashyap.desai@broadcom.com>, kernel test robot <lkp@intel.com>, linux-rdma@vger.kernel.org, 
	Selvin Xavier <selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006c10f8063277d99b"

--0000000000006c10f8063277d99b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 6:02=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> Remove nq variable from bnxt_re_create_srq() and bnxt_re_destroy_srq()
> as it generates the following compilation warnings:
>
> >> drivers/infiniband/hw/bnxt_re/ib_verbs.c:1777:24: warning: variable
> 'nq' set but not used [-Wunused-but-set-variable]
>     1777 |         struct bnxt_qplib_nq *nq =3D NULL;
>          |                               ^
>    drivers/infiniband/hw/bnxt_re/ib_verbs.c:1828:24: warning: variable
> 'nq' set but not used [-Wunused-but-set-variable]
>     1828 |         struct bnxt_qplib_nq *nq =3D NULL;
>          |                               ^
>    2 warnings generated.
>
> Fixes: 6b395d31146a ("RDMA/bnxt_re: Fix budget handling of notification q=
ueue")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202504091055.CzgXnk4C-lkp@i=
ntel.com/
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Thank you Leon for the patch, LGTM.

> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniban=
d/hw/bnxt_re/ib_verbs.c
> index e14b05cd089a..063801384b2b 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -1774,10 +1774,7 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, str=
uct ib_udata *udata)
>                                                ib_srq);
>         struct bnxt_re_dev *rdev =3D srq->rdev;
>         struct bnxt_qplib_srq *qplib_srq =3D &srq->qplib_srq;
> -       struct bnxt_qplib_nq *nq =3D NULL;
>
> -       if (qplib_srq->cq)
> -               nq =3D qplib_srq->cq->nq;
>         if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT=
) {
>                 free_page((unsigned long)srq->uctx_srq_page);
>                 hash_del(&srq->hash_entry);
> @@ -1825,7 +1822,6 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
>                        struct ib_udata *udata)
>  {
>         struct bnxt_qplib_dev_attr *dev_attr;
> -       struct bnxt_qplib_nq *nq =3D NULL;
>         struct bnxt_re_ucontext *uctx;
>         struct bnxt_re_dev *rdev;
>         struct bnxt_re_srq *srq;
> @@ -1871,7 +1867,6 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
>         srq->qplib_srq.eventq_hw_ring_id =3D rdev->nqr->nq[0].ring_id;
>         srq->qplib_srq.sg_info.pgsize =3D PAGE_SIZE;
>         srq->qplib_srq.sg_info.pgshft =3D PAGE_SHIFT;
> -       nq =3D &rdev->nqr->nq[0];
>
>         if (udata) {
>                 rc =3D bnxt_re_init_user_srq(rdev, pd, srq, udata);
> --
> 2.49.0
>


--=20
Regards,
Kalesh AP

--0000000000006c10f8063277d99b
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
AQkEMSIEIJ9pI5CWIio1iYKPdwrP5IRaDe3nwpro5CBS9Sv5br2bMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDQxMTAyNTYzMFowXAYJKoZIhvcNAQkPMU8wTTAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBADj+UmADneFUi4mp03TnPYvXeMOF
D9wHYPd/fbk8eTGyX8ssRvxl4DCLMvsLhQFQoxFO4UQvnClNcicijin4BP/Thzeoo46ReYmI0C8S
kF5zPggLOUsczph6sbxdRalt5C0PynTUgx81X03HbBYryy6Bewk1i6aBwA6hv0TKOAWFxLpvRP2Q
e/yrFuZmmXFCnj/tRz8uU822+fN6RAGRtBDky/MeT594M1lyXXGckHlmP3d81zcWnxwoI8hQLgnj
Dj9BLeTX74J35whaHxX2ObOOwM2KCpLie4rfG4stH0/ZSYoHOSlXMhTBdSKNO+FzunCN28uhRJgB
wTSr2TVA3fY=
--0000000000006c10f8063277d99b--

