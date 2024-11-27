Return-Path: <linux-rdma+bounces-6117-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 591589DA197
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2024 05:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0D88B21E2F
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2024 04:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9FF81AD7;
	Wed, 27 Nov 2024 04:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IiRtYyxB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9F74689
	for <linux-rdma@vger.kernel.org>; Wed, 27 Nov 2024 04:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683360; cv=none; b=uvSKKgCqXHgGb6iJB7fxLoygNxlES+zRMqWwaL482tt+X/ELzrqzwXeR/rdl7Zyp74w0G/ANpe0pkpDRbD78UhKk/CBKel+uk1hkxIukQ7jA8Z781mcH7RdBhxwoEezcxkMYbGIZ+cLZRaVX4crW5fhDUcUFWxcAGL1Pxe4vyrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683360; c=relaxed/simple;
	bh=EdM4lkkh79386861JPaIqrqqjYz+5fY4gqWCKqBpbjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpJnqFCO2k0J4Rynfly9xIOzp93i+5uZCYhjZYLmjrVYTLvvDAKrUJeUB+sRR7n+xIt1V5GJ9WPYWNNw2X79dUaT+7rPFMQzIpvTKWIpuOJLEsdPGiAtr4Xsx9GuDaaCe02RuFkj6Is+4fJC+BLw9Ul9BagKpTb4xBhyZfhRJKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IiRtYyxB; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e3824e1adcdso6019055276.3
        for <linux-rdma@vger.kernel.org>; Tue, 26 Nov 2024 20:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732683357; x=1733288157; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PwOULCQrguHeZO6ecVkvf83S8sZtS0w0WJOeRUPSmRs=;
        b=IiRtYyxB9l76JjVIQZXdtUXDlXUF5r1xCEpS6vY/lwj5FWz2PXAjHit1Tw2FsqSGNk
         aOD7LyO3UdUfwRxlNeD4G7CLi3dUSy+HswInptAyqmy0Uiipzs8TFvDx3dRgQdJcNbdE
         0mC65qU9QRkrh04arhuXQ4L4x4Zv4+BEHYh6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683357; x=1733288157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PwOULCQrguHeZO6ecVkvf83S8sZtS0w0WJOeRUPSmRs=;
        b=PbH9RMZXISKXanJ3NKE2BaKjBVcj7wxKtMXERv1jUTQdLJ1FnwtlchHo0LjitxaBcD
         zvu+AKTttt4S/Fa9HdcUn7YQGW6UvaPLbgOPQjcw+6TNFFO+7QwnnvWZLu948l4amUFT
         5qlpDrHhWT9UK7u+UtDsAIKLMR2eIslQNqcKrJsOjSGfOPK6DsnDuoW4ExTu5LIIP30s
         fcfeyKpJA/Jgd+ol/lSOc/0xIX8CMRkSF8OzbLmdmrmf7UVlINCXRGgWraCUdGSQgiiv
         080r/RQ4P1Yoy+qY09esUnkJAFY05+ulEBEOQjK/c/3mrI64I2+oocZ8zMsrNK1ruM3H
         +SQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmySz/4FAEy86gU4Xm31RDzGElEJyBxild1GGsMk6V2WcHpUAGBw09s1h6LWifVQixubb0p9ETvNac@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0B1T//c9c9PgI3E35dcpCAXUlfYlM64oMdrJGrkCBoSURMHBV
	d3xhp5sK9QhFTwo5XS2ZgZhsvZFKBeHu3j/CFJVa9vDHGYn6IQGybzoXjscTZuURtdh8EDvuml6
	En/XXyEIAQO/IrHV80Np23iONAlFTJn8xxE6h
X-Gm-Gg: ASbGncvbCbld323ckl6zf8aRfPd2FPsm9frF4dZcxkZ8tdC9OMaJ/kpqDbkjc+7XmtR
	01biU6gEWJkuG3gI19UKlOI56tNv5/aLE
X-Google-Smtp-Source: AGHT+IE/qvOekEX6xPqzcm67iBey0PQVndvjVZuCKzl2AJ/Cww/aLVBxLnvLLlK51WoL3IFZ9VHjsaOYg/Aggc9990w=
X-Received: by 2002:a05:6902:18c2:b0:e38:931b:c93c with SMTP id
 3f1490d57ef6-e395b87735dmr1634631276.4.1732683357399; Tue, 26 Nov 2024
 20:55:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <be0d8836b64cba3e479fbcbca717acad04aae02e.1732626579.git.leonro@nvidia.com>
In-Reply-To: <be0d8836b64cba3e479fbcbca717acad04aae02e.1732626579.git.leonro@nvidia.com>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Wed, 27 Nov 2024 10:25:44 +0530
Message-ID: <CA+sbYW3eNwHWQH-hxT911q3c1iTGf_GAyHZfMWE9xCcmKV6Xog@mail.gmail.com>
Subject: Re: [PATCH rdma-next] RDMA/bnxt_re: Remove always true dattr validity check
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, kernel test robot <lkp@intel.com>, linux-rdma@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000b92de0627ddc8fe"

--0000000000000b92de0627ddc8fe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 6:40=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> res->dattr is always valid at this point as it was initialized
> during device addition in bnxt_re_add_device().
>
> This change is fixing the following smatch error:
> drivers/infiniband/hw/bnxt_re/qplib_fp.c:1090 bnxt_qplib_create_qp()
>      error: we previously assumed 'res->dattr' could be null (see line 98=
5)
>
> Fixes: 07f830ae4913 ("RDMA/bnxt_re: Adds MSN table capability for Gen P7 =
adapters")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202411222329.YTrwonWi-lkp@intel.com/
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
Thanks,
Selvin
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniban=
d/hw/bnxt_re/qplib_fp.c
> index 256c4379ab7f..90e4faebef09 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> @@ -995,9 +995,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, =
struct bnxt_qplib_qp *qp)
>         u32 tbl_indx;
>         u16 nsge;
>
> -       if (res->dattr)
> -               qp->is_host_msn_tbl =3D _is_host_msn_table(res->dattr->de=
v_cap_flags2);
> -
> +       qp->is_host_msn_tbl =3D _is_host_msn_table(res->dattr->dev_cap_fl=
ags2);
>         sq->dbinfo.flags =3D 0;
>         bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
>                                  CMDQ_BASE_OPCODE_CREATE_QP,
> --
> 2.47.0
>

--0000000000000b92de0627ddc8fe
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICPqX9UAGxNQ
q869J2XIBCwEXpHN+ZTsm9Y5w7GYLqaAMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MTEyNzA0NTU1N1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCHU7g+COaqHR/P/n1Ef96MDmFxQer9
NjbnN/sa6EW8kl2knXdg5HBCKGxubjjFr6T3H9rkVFUqCUkzmFSsdk4SKUkaHYPG/dzyJIHfeFcJ
iIqzwRsB8zVPM03bIUyNIewIYnooUHFnI0o87vxtS5Z06Szur8GjlP6bGwBvZlsKpMF1H2/xSMbO
QxaeTEwEok+jgaYnMr9qISyr89MxWsVhOS9Fq1rSbHPgTt1P8YgP26rHhyc0BVXzWq97gFhkXqIV
MntMpqxwbpPhQ57+jLFH790eW5VhPD/+gv/zvEs2lY3pkNu6MGU7nFEMoIW9Je+/b6iNj6VenVlr
cFajX/mn
--0000000000000b92de0627ddc8fe--

