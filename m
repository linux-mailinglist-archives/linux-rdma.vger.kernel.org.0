Return-Path: <linux-rdma+bounces-3785-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A632A92CCFA
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 10:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C812B1C21AB3
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 08:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B0D127B56;
	Wed, 10 Jul 2024 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aduoPbFs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECC512BE9E
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2024 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600076; cv=none; b=ZJQowBFo6T8XSKjUFl0ohRUPCh3nSPJE6Tv/EpngHPi52GtmkCm9dsIi/mAlJ1SvGEdPW118rlOCzV/10Fm/6PGz8p9vikYNEos3BMRZnnK7KVWi/LOJ7b7E5+82sn01jNQu03jH5TGdKEu4AiPThmHqkGnDV+7FOs3RfNhmHwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600076; c=relaxed/simple;
	bh=4vueYzijWYRb9VtzioGKnu72EYUBvPAvqjGA6M11SQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJELSJspNpCbkd3BQmG+NN6JQIJa89j5Yngp42HMJsVhxmiHSH8iq2xnXKgZ9I/HBn0VR6Uk5aHGwHlCy+HZj5Gvf9tJ6qDM2PmcELrxjRs/GIs7TNz3w+5SLp+wTxTUHy1IBkpAy/lowN+tw3qyslS3jwkraCgIQmY9gW8Hg64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aduoPbFs; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e03a6c1741eso5993879276.3
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2024 01:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720600070; x=1721204870; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PO3MOuXAj4o8Qp9HSX0m6xAo8pxLuPynPllPhHe3B+Q=;
        b=aduoPbFse8Iqei9qJGYvwA4Kv649avzsRGr/AzeFfSqt91Yng4hInyBhn35R1ffJrU
         pgE5ooi4V9+qV+em3/YU79ynapaC+sGVt4H8qgLYgecQrANRtrFdhzdaJvkd09x2MjqJ
         AcEnB8DOU1U+K/FvVowZtXQTEwrdMibTMgUNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720600070; x=1721204870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PO3MOuXAj4o8Qp9HSX0m6xAo8pxLuPynPllPhHe3B+Q=;
        b=eOMjo8GldZMyJtJ+Qjxvm+dRMVKLw6BUCni/8sgBV0NCKgGhP5WiyZ+EjO/j/UYwTp
         aq4Dc27vrDrlsgcsHK59RchGX52bhqQynISHdvDymMVZDnx4CxZxmxsYjkkOvR+boRYy
         2jrmtzF9HhWMkEhYglvKIGnFOGMbOLodDUZU+/pIAaLmQr4dKTFKQGA5AfmO3v4VN2SC
         iABHNxsecGq4q2tk+sO3fBfgADNaeaa1Dhu75NSKJvj0+o7Iop74uJYpC9QZLmOSU7KN
         z+S0KutBtK1I5IE7l+4IRiuEikN8GV2tlNo1Tld1e9FWt67LUGCX2PaYwTs/pgBSXlxE
         EMvQ==
X-Gm-Message-State: AOJu0YyU1bk2J2siRf4jTO1Py46UbnXBfQhDiCjCirT47OvNr89Lga/4
	IjgwLW7OuTRBU1Cer4GxMgALpes1T49Ixp1+dXm8wJUe40ARYOdzM0lZCRXiab+lrBTQoDTTvq2
	mrEz4SKZDQ67bywmHi2nU/R7005tgmq74AL2/
X-Google-Smtp-Source: AGHT+IGf6Eq8fi8W6FPfg87cE5OK5GMnId6tnyJ2+EiXHjE7ZhkcshiKqdhD4Aze/gRLBXdmpra/ftn9uHa7+SNdt+g=
X-Received: by 2002:a25:e20f:0:b0:e05:665f:735b with SMTP id
 3f1490d57ef6-e05665f7cd9mr723708276.17.1720600070342; Wed, 10 Jul 2024
 01:27:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709150119.29937-1-jinpu.wang@ionos.com> <20240709150119.29937-2-jinpu.wang@ionos.com>
In-Reply-To: <20240709150119.29937-2-jinpu.wang@ionos.com>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Wed, 10 Jul 2024 13:57:38 +0530
Message-ID: <CA+sbYW0SyjjvYjb++P8P4MHam_YWRXN3Vw8PmNsK4G+e8a3gsA@mail.gmail.com>
Subject: Re: [PATCH for-next 1/2] bnxt_re: Fix imm_data endianness
To: Jack Wang <jinpu.wang@ionos.com>
Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org, 
	jgg@ziepe.ca, haris.iqbal@ionos.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000003b06c061ce06c42"

--00000000000003b06c061ce06c42
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 8:31=E2=80=AFPM Jack Wang <jinpu.wang@ionos.com> wro=
te:
>
> When map a device between servers with MLX and BCM RoCE nics, RTRS
> server complain about unknown imm type, and can't map the device,
>
> After more debug, it seems bnxt_re wrongly handle the
> imm_data, this patch fixed the compat issue with MLX for us.
>
> In offlist discussion, Selvin confirm HW is working in little endian
> format and all data needs to be converted to LE while providing.
>
> This patch fix the endianness for imm_data
>
> Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Hi Jinpu,
 Thank you for this patch and debugging with Broadcom devices. Couple
of comments. Also, maybe you can clean up the commit message by moving
the reference of our discussion to the cover letter.

Thanks,
Selvin
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 8 ++++----
>  drivers/infiniband/hw/bnxt_re/qplib_fp.h | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniban=
d/hw/bnxt_re/ib_verbs.c
> index e453ca701e87..c5080028247e 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -2479,7 +2479,7 @@ static int bnxt_re_build_send_wqe(struct bnxt_re_qp=
 *qp,
>                 break;
>         case IB_WR_SEND_WITH_IMM:
>                 wqe->type =3D BNXT_QPLIB_SWQE_TYPE_SEND_WITH_IMM;
> -               wqe->send.imm_data =3D wr->ex.imm_data;
> +               wqe->send.imm_data =3D cpu_to_le32(be32_to_cpu(wr->ex.imm=
_data));
If you see bnxt_re/qplib_fp.c, we have the following code. This
ensures that le32
is passed down. So in your patch, we just need to do be32_to_cpu of
the immediate data.
sqe->inv_key_or_imm_data =3D cpu_to_le32(wqe->send.inv_key);
>                 break;
>         case IB_WR_SEND_WITH_INV:
>                 wqe->type =3D BNXT_QPLIB_SWQE_TYPE_SEND_WITH_INV;
> @@ -2509,7 +2509,7 @@ static int bnxt_re_build_rdma_wqe(const struct ib_s=
end_wr *wr,
>                 break;
>         case IB_WR_RDMA_WRITE_WITH_IMM:
>                 wqe->type =3D BNXT_QPLIB_SWQE_TYPE_RDMA_WRITE_WITH_IMM;
> -               wqe->rdma.imm_data =3D wr->ex.imm_data;
> +               wqe->rdma.imm_data =3D cpu_to_le32(be32_to_cpu(wr->ex.imm=
_data));
Same comment as above
>                 break;
>         case IB_WR_RDMA_READ:
>                 wqe->type =3D BNXT_QPLIB_SWQE_TYPE_RDMA_READ;
> @@ -3582,7 +3582,7 @@ static void bnxt_re_process_res_shadow_qp_wc(struct=
 bnxt_re_qp *gsi_sqp,
>         wc->byte_len =3D orig_cqe->length;
>         wc->qp =3D &gsi_qp->ib_qp;
>
> -       wc->ex.imm_data =3D orig_cqe->immdata;
> +       wc->ex.imm_data =3D cpu_to_be32(le32_to_cpu(orig_cqe->immdata));
>         wc->src_qp =3D orig_cqe->src_qp;
>         memcpy(wc->smac, orig_cqe->smac, ETH_ALEN);
>         if (bnxt_re_is_vlan_pkt(orig_cqe, &vlan_id, &sl)) {
> @@ -3727,7 +3727,7 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_en=
tries, struct ib_wc *wc)
>                                  (unsigned long)(cqe->qp_handle),
>                                  struct bnxt_re_qp, qplib_qp);
>                         wc->qp =3D &qp->ib_qp;
> -                       wc->ex.imm_data =3D cqe->immdata;
> +                       wc->ex.imm_data =3D cpu_to_be32(le32_to_cpu(cqe->=
immdata));
>                         wc->src_qp =3D cqe->src_qp;
>                         memcpy(wc->smac, cqe->smac, ETH_ALEN);
>                         wc->port_num =3D 1;
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniban=
d/hw/bnxt_re/qplib_fp.h
> index 4aaac84c1b1b..1fcaba0f680b 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> @@ -164,7 +164,7 @@ struct bnxt_qplib_swqe {
>                 /* Send, with imm, inval key */
>                 struct {
>                         union {
> -                               __be32  imm_data;
> +                               __le32  imm_data;
Once you implement according to my comment above, this can be a u32
>                                 u32     inv_key;
>                         };
>                         u32             q_key;
> @@ -182,7 +182,7 @@ struct bnxt_qplib_swqe {
>                 /* RDMA write, with imm, read */
>                 struct {
>                         union {
> -                               __be32  imm_data;
> +                               __le32  imm_data;
>                                 u32     inv_key;
>                         };
>                         u64             remote_va;
> @@ -389,7 +389,7 @@ struct bnxt_qplib_cqe {
>         u16                             cfa_meta;
>         u64                             wr_id;
>         union {
> -               __be32                  immdata;
> +               __le32                  immdata;
>                 u32                     invrkey;
>         };
>         u64                             qp_handle;
> --
> 2.34.1
>

--00000000000003b06c061ce06c42
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILOCuyJ0tI4y
qLwNXJl6ZwY5o6kYLEhxfI78b5bhmFOVMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MDcxMDA4Mjc1MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCFR+y2cD/95u8MT4hUkcDAKnTKGBRk
Ql3sjDiORO+yYkeuFZdQNFA+t21IqqRcK5Tpd+a35zpAMMrVC6SMX+gj607U0GFuNgHFXm9GXFUI
5ADuWc0josEg0pguJ9ZE8STz8+jOD8TEjTeQQL/JImpa3gbyEmMCVMGJUUluha7f50XgnHYKnDaP
C8e44PuaxYYCQiLUzEaT9tb/QMWcCMH+SGjgEiwVYbyPDQz/kKPV3h+JlKPCK/gcEz6wVLXfxh0l
pNfmpwANZhgg87AvEU62Maqc7ed56FkmXLFlwCuodYcUNWdudIGGDvLlORkU7OPZv5uNKV8JiJqy
lVyw56QZ
--00000000000003b06c061ce06c42--

