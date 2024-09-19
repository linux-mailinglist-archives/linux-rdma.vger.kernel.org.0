Return-Path: <linux-rdma+bounces-4999-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FD697C623
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 10:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0091F249E7
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 08:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078EC1991BE;
	Thu, 19 Sep 2024 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PdTtC/d4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCEC16D30B
	for <linux-rdma@vger.kernel.org>; Thu, 19 Sep 2024 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735586; cv=none; b=Bm26nnu0ftjMdcYfoik5UqqaoHC5zoYOZePIeTod4WrKNLTnTsMDK+HNJWta6fMsy9K6zC1z3x6h9xV+VgdL7dlJhv6KfLX6hapJVZ/7KzWJ2h26OVN0Eda/vfYv9yH2JrAlmh9mDalqJp8PDudk+HVxSLeqlabYbdDB3qkXkG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735586; c=relaxed/simple;
	bh=VSd8/L4YWg0WczW7VujbvM81J/iOgI7C83pb0uyvcsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5/sCjwvy6oNiO4Jep7COWe36Hr6comvd2CKDzgUIcPZlypNQXXMVaiDOeggIStEbMjT8eCIFy9hxGwNEFjqET38unlfR7CKE1Mv8g9j/HaOOuqKQOlwShu3lQWL5335/wzZDKKA1aRMwvJwbaM+Kd9YOYaThNu1gH30Big836c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PdTtC/d4; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e1a90780f6dso575422276.0
        for <linux-rdma@vger.kernel.org>; Thu, 19 Sep 2024 01:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726735584; x=1727340384; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kIRt9ecHh8om1r5+4pvKY4PKMn62mxZX6RqDtaJ/OQc=;
        b=PdTtC/d4WZ9oo48kigkf5mK4mSwni1Mbw4Gx77201xRtviqBWnuT7FjjU6Fp/1Mqa6
         ytbeuMqcl5ErbQftjCKWi7MSVO504JAY2/No2fV1ApEZqF1yI1798qI9Hmdm6l/+/gGM
         QT+UBUKkqJEbFV+PKx8ZZ2VPDtDdvrGmILZwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726735584; x=1727340384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIRt9ecHh8om1r5+4pvKY4PKMn62mxZX6RqDtaJ/OQc=;
        b=odL3zkp3gQLMUkgpcmZtkvh+9skw2CfJ4HhXl6ZuOa9GR1oKCC4iEQImFfVXAYcnYb
         BrjGxoJ8ID2IQZujbES0+ekHAMDLvP+zsDXhWw5BNaHv38VifHEA4D9aBZxyMuGnEnU3
         2BsvSPreJXCc3thZ9LHdsXZBd6L/ehtR2qEdQ3gdFwzPWslAQAxOCE89LVfjEF/YrS5n
         4om00L/gOrE0vgBZTCM93g6jrU2LU6L9y3py5sGZup48jA5/88i+fwAQ38IMlRqCCFEV
         0MBLJTrUVSHPDn1lmO1YniY6hQoGEUSI+WSnxYRdqAVjOdUSADECAEciVHbVv4PJj2hs
         gguQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbmo61mlzO5eNgJ1GtcHr4euw0Bq1vpYTXRAjYC/Hgktf7qRIh0cZscnque4p3xzbdmn27XzW8q23G@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8EuexSDEuFfS4u+AGrlKtioJCI4qWT//jJRCJEMv14ROQlg3r
	20KHWQdfxFl6P5gE59VWoIRdZiFUdkBN0BIZB34ay5oYfcga3iVF/INUtd5MmsGdc26mGtSg7Iy
	NwzFHqzVBXjp3TwUgXWQhONs1innpPmGhmaq+CKKnw78bZCiOnw==
X-Google-Smtp-Source: AGHT+IFfqGpCnnLKd2d+91OVkOYImNDWkFYAlBNe9+53dYPYvIgyGUMJb5nasbNBVCSusb9TWJMGBLSWFPW1c8F/MHA=
X-Received: by 2002:a05:6902:c06:b0:e03:61d4:ab35 with SMTP id
 3f1490d57ef6-e1d9dc5cc47mr23063798276.53.1726735584004; Thu, 19 Sep 2024
 01:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918021632.36091-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240918021632.36091-1-jiapeng.chong@linux.alibaba.com>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Thu, 19 Sep 2024 14:16:11 +0530
Message-ID: <CA+sbYW0zy=kD1JyYbG--keYAv146+SXvuxdQh6dHnvbVCHd9kw@mail.gmail.com>
Subject: Re: [PATCH -next] RDMA/bnxt_re: Remove the unused variable en_dev
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001fc23d062274f5d3"

--0000000000001fc23d062274f5d3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 7:46=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Variable en_dev is not effectively used, so delete it.
>
> drivers/infiniband/hw/bnxt_re/main.c:1980:22: warning: variable =E2=80=98=
en_dev=E2=80=99 set but not used.

Not sure if you are applying v1 of a previous patch series. A similar
issue was reported by kernel test robot and i fixed in v2. I dont see
this code in the latest driver code.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D10867
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/bnxt_re/main.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw=
/bnxt_re/main.c
> index adff9e494c9d..777068de4bbc 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -1977,7 +1977,6 @@ static void bnxt_re_remove_device(struct bnxt_re_de=
v *rdev, u8 op_type,
>  static void bnxt_re_remove(struct auxiliary_device *adev)
>  {
>         struct bnxt_re_en_dev_info *en_info =3D auxiliary_get_drvdata(ade=
v);
> -       struct bnxt_en_dev *en_dev;
>         struct bnxt_re_dev *rdev;
>
>         mutex_lock(&bnxt_re_mutex);
> @@ -1985,7 +1984,6 @@ static void bnxt_re_remove(struct auxiliary_device =
*adev)
>                 mutex_unlock(&bnxt_re_mutex);
>                 return;
>         }
> -       en_dev =3D en_info->en_dev;
>         rdev =3D en_info->rdev;
>
>         if (rdev)
> --
> 2.32.0.3.g01195cf9f
>
>

--0000000000001fc23d062274f5d3
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJEYdS3ypy9P
Z9plF+12bS3nCr0vyjeJzUx6ss/ILObYMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MDkxOTA4NDYyNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBkBRCqTeGvXalwzK0/RJmaoAoiXaCs
Ax8UtU6Bg44u0pCgZa5HeE6tA/CD9gnfEHANZ5qcbcyhCzm/5M8sc2jC36lh8ZvS0wKFS2+m6nJr
ycIJsS5w0Bp6LRdLpfHEMK44aPr53oF8EPWzMtxqwQjoppKjcOzsSL1stkutnq0J4ZHRdX4X7MjR
C/WqrHGnaIpKlc9tHhG3ahaBgp6Iaj8OHXuOHfzJiTyEiqJleJZeTJflNEz819yL5NgcbTvpWVGk
AHFWmrbfC7L+hYewxTvw/g4vlbZcHV2BbBP+1ixoOohD3Tds3JcaOjJExA3ZoMKbWeR1P9zzrPiZ
fYTIzjd/
--0000000000001fc23d062274f5d3--

