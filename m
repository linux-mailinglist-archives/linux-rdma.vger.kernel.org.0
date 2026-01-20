Return-Path: <linux-rdma+bounces-15758-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF3FD3C3B1
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 10:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04ECD664E3B
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 09:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE773BF2F0;
	Tue, 20 Jan 2026 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PQQRkEIL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158BC3BBA1F
	for <linux-rdma@vger.kernel.org>; Tue, 20 Jan 2026 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900318; cv=pass; b=jhI7rSk/sGOkn+cDsDI3FxbEjIQ18y+bqml0V3DlazUHCQMOCJSwarAQL7biBHFa7tbmyE0WWX3ElwoBnGMWQuxOaIsYg90kP6q+SmF/H5QawpA6R2McHAM3luL6Xm4i1DRYmHXS7Fom7i58p/KDd013JmvdR8M2ZxV3IpH/1IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900318; c=relaxed/simple;
	bh=3umlqFtidWDby/V6ce+VreK/FfTVN5nOtJ8DfXHUb6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ckpd+nSvOXdU5kqKvivJfJ9v/XysNU4+aM6a9Y1k4GtO2bAjMV56g54WUDnqWpWDVCnluOeaBjkfC1Rz6STBYO6W2BcRpFB2DZmk+a+Swjl4/f+v1uRqDWa7GcJY0JZ5+FVC65oEwLFrlYIeLBDUV++1zPJRCj5jvwTXpZW6I6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PQQRkEIL; arc=pass smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-c5e051a47ddso3382203a12.1
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jan 2026 01:11:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900316; x=1769505116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKtpqwphBMi7r9R5IEaLMXIca/y8YHeb8n8CnNcrql8=;
        b=M6ISBETIofdfSB15ICyFRhYqDSbI8AvsHpslD4e5S9STgNnI2zBj7/6yzOmsQVuomr
         h9kedsvQ8/p9B8VfC8Ctgxq5MIuVIB7C+QNaf6X35+GzWZbbpkE7LtcZykRju+bhYEQA
         zK00wYBZVpCmiBGJnaqFoFIMT75RfiPJ5T67sIa4yBwTFQGh+Yxrj0Hv7rPXvihq/cKE
         Ytx0UOYL2ukmWOiNzoJbjVqOlBFNuqyUxhyyYYGZZXLUBkjChnOFiXFq3viN6zxDk9Gu
         cghgr8Pr1trHGOsm6uRoDtO1tRnYFWsjgzsAb0BP1F2kf0+nShTCdpECrqxrOjUvbpUw
         /ysw==
X-Forwarded-Encrypted: i=2; AJvYcCUIVr/7kcHh7bw9FQW8lBZou35eO8oO7ADUoDZZgKPzdi1UUEJexxfhgBJKKK/f/VC7J2govRTiwMgC@vger.kernel.org
X-Gm-Message-State: AOJu0YwPdNuOUs8Pu3jL3qbqLMmQSyVM9zV89b/on3zvbkqCFct7I4cF
	8EjHrQ8zB9m7NtHaaeRxTxg4YQazXkIlSsWwCBtSU/Gtmolr9AHn0gmIE5cHrf+uegtwcrDxZKH
	SCVfBB6OvQtFk+7tn2O051nV2OZSQE9nMNHQkI6zcjF340pxiW9tZ5k0A9eiMGxX99dRWMKsKGv
	d+F/fTctPEYoFiTjvdpqathvuA0FUgnVDIjuGFncy+OdMpOiC+VgnHU8XtK5ktUQ2NpFif4lAiy
	aLOYwaOD//dEylBXQ==
X-Gm-Gg: AY/fxX68nXCbvqy4cGVXUwl8m79a6xt9PNTX0cEku7aLkyuUjmUr7AQZiaQFZfRBOGZ
	ypWhNesz/bEzW492lQYix7PHsk+VVs+JtZAN3bY/pWZ35cVMg6AoMCOGuKdccX7HbCtXFQ4tSjJ
	977uPILbchnYA0PM9By50fk7JHSSw9V2arKw1bXzItE5eje6Nqbjd7MVY21qmaXheIzd9zmDF4W
	z8X6xNMcMqQD2iZrqETCuabTirkGlO9sBsqWrh4eViRQkOAAtdqsmXfxt4EFnrTkkTlxOtDVYea
	Jr2z/XTKuCyvDgffdmgz/SnpGBZdlV1vhH/nsycyQ4eOUT+1bC05KKFjws//NL74hYsjTX6snDY
	Tnh49rEbjUENMZrs4hyExPGpmJt9v8f1mWSZs2Qy/9UHhFuZ+8nhRTxWRKCED/wVAv7uAk4sH7j
	5jJQ8b4amLBQ2LHrFK9XgBCuDVwXOgQmQmA1JsqSn90ShVkw==
X-Received: by 2002:a05:6a21:3288:b0:38b:d9b5:5de2 with SMTP id adf61e73a8af0-38e00d5cc7cmr13043920637.50.1768900316248;
        Tue, 20 Jan 2026 01:11:56 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c5edf2f6ae3sm590204a12.11.2026.01.20.01.11.55
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2026 01:11:56 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b609c0f6522so9314199a12.3
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jan 2026 01:11:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768900314; cv=none;
        d=google.com; s=arc-20240605;
        b=TuLGHE2/RgM9Lg9PrGLZGs/KgtSgBQmuZUg7HhObKAhL6E9ARlOtTGuunbfIXaQ0ec
         0xJKM6DdU78WnYX87GYBXkjNcl3GMr1+bLhyTkHjXhb354K4TFv3skNHICSuD5twlNyp
         VGqG9Kb4t8tx4bVx6VtHtr0vFfCQIp9C51pHPx8x3Z9O0KO7MH45NX/tf1ThS7IlnqQH
         7yfCo9wX5bxSPjgXAekKg5N5vwmQFFMNH0HYEDCPiwPGeEtOWZgizd/YzoBtAAQUEGha
         7fpAl8HFqoRNJ0nTymi+bn761X0LzK4VCG4MiACnHOERWtit38Ff86pobUsL8dH87qa9
         eXHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WKtpqwphBMi7r9R5IEaLMXIca/y8YHeb8n8CnNcrql8=;
        fh=6YnhwosE6meQqjBJveUSF3cGm5hdO3VRR9J+bFq9y/w=;
        b=kiYYffsbN9ratftCgG7xFJrL3Wm2NABY1rJC3eqvWdIDmPKgJMR4fNf3mLCbFQJBfX
         Ht9cmARKywliy3eCvmfLA6weQ29K+okdu6NRbAmKmkSKKAnIGDofzioND2lhjiiQ+MgT
         BymVN2wfn2aHyXmYPtcegVebuYzY6WCimC8nv9KXClkXD96rKo3Kh5xnHcNOH0ef3vms
         qCCDI9r0rHItCo01Symy4jT2SVGW3xupJZXHc7yymY2ivMH6Vsw7gdadlYJHgtejqgcf
         M2Nw4kWOqeRgnLv2o0OlFoP764LUv8My1FQb5SqTRgI9VD8GewwcORhIl9seBnmNYwsB
         3rdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768900314; x=1769505114; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WKtpqwphBMi7r9R5IEaLMXIca/y8YHeb8n8CnNcrql8=;
        b=PQQRkEIL3xWLvyAeaLLTBKzjLVgv+RqzBpw4/3KObstU/dBwu+xV5Xw7J3XZmamkll
         agASGjKpmh7Qj4KP6wx8faW1KfnYYa7Imn4bFWxSm0zLACnni2po7QSdORUMvCbZrpr8
         fXrh+Q9qlyqgB50EM7ijAj98oErFmX4BWFak8=
X-Forwarded-Encrypted: i=1; AJvYcCXYOxC5GBY43IOSzZI6InUDSPIj4zhUxS0C3ZHkFoy+cS1yUo/NLWd8rf5mpKJqzTSuncFQdFXqIrgB@vger.kernel.org
X-Received: by 2002:a05:6a21:62cc:b0:38d:f661:9940 with SMTP id adf61e73a8af0-38e00d98fb8mr11606792637.60.1768900314500;
        Tue, 20 Jan 2026 01:11:54 -0800 (PST)
X-Received: by 2002:a05:6a21:62cc:b0:38d:f661:9940 with SMTP id
 adf61e73a8af0-38e00d98fb8mr11606778637.60.1768900314129; Tue, 20 Jan 2026
 01:11:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120090204.635526-1-siva.kallam@broadcom.com> <aW9F0QZ5E-VaENOO@stanley.mountain>
In-Reply-To: <aW9F0QZ5E-VaENOO@stanley.mountain>
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Tue, 20 Jan 2026 14:41:42 +0530
X-Gm-Features: AZwV_QiW1v-B7osLUbK1BP1l5sPXFxo4Vqid5REhtTpW_E-JxjKMtTtxDrTOcVk
Message-ID: <CAMet4B7TyRZR7KyuAjQFiCiRzc20v7Qgt2dojdid-VrCY8Z_Fw@mail.gmail.com>
Subject: Re: [v2] RDMA/bng_re: Unwind bng_re_dev_init properly and remove
 unnecessary rdev check
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: leonro@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>, 
	Usman Ansari <usman.ansari@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e8ac0e0648ce3216"

--000000000000e8ac0e0648ce3216
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 2:37=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Tue, Jan 20, 2026 at 09:02:04AM +0000, Siva Reddy Kallam wrote:
> > Fix below smatch warnings:
> > drivers/infiniband/hw/bng_re/bng_dev.c:113
> > bng_re_net_ring_free() warn: variable dereferenced before check 'rdev'
> > (see line 107)
> > drivers/infiniband/hw/bng_re/bng_dev.c:270
> > bng_re_dev_init() warn: missing unwind goto?
>
> I would probably split this into two patches, one to remove the NULL
> checks and one to fix the unwinding.  I would say that even though
> removing the NULL checks doesn't fix a real life bug, it's probably
> still worth having a Fixes tag because otherwise if this is backported
> to an older kernel it will trigger the warning again and we'll have
> to review it again.  Where if it has a fixes tag, the cleanup will be
> backported as well.
>
> >
> > The first warning is due to accessing rdev before validity check in
> > bng_re_net_ring_free.So, removed unnecessary rdev check in
> > bng_re_net_ring_free.
> > The smatch also flagged about unwinding bng_re_dev_init. So, added prop=
er
> > unwinding ladder in bng_re_dev_init.
> >
> > ------
> > Changes from:
> > v1->v2
> > Addressed the following comments by Leon Romanovsky:
> > - provide proper commit message
> > - remove aux_dev check in bng_re_net_ring_free
> > - remove uncessary validity checks in driver paths
> > - remove uncessary NULL assignment to rdev->nqr in bng_re_dev_init.
> > --------
> >
>
> This isn't the right way to send a v2 patch.  I have written a blog
> which explains more.
>
> https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/
Thank you for the details. I will modify and send it again.
>
> > Fixes: 4f830cd8d7fe ("RDMA/bng_re: Add infrastructure for enabling Firm=
ware channel")
> > Reported-by: Simon Horman <horms@kernel.org>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <error27@gmail.com>
> > Closes: https://lore.kernel.org/r/202601010413.sWadrQel-lkp@intel.com/
> > Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
> > Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bng_re/bng_dev.c | 56 +++++++++-----------------
> >  1 file changed, 19 insertions(+), 37 deletions(-)
> >
>
> regards,
> dan carpenter
>

--000000000000e8ac0e0648ce3216
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
fyIFUZVWSBcxHWtNNVK4Oi0mqSJut0p/SwfLg6IMaVBU9VdXgVmw35CgcX/9B1ITmih041Oz+Qyo
wTULsXik3lHJuyhYevN9h4259CoDPt+tpaykVaqa4luUmGv8k3F6aC4+fZl83ywHGVun9fBVk/GE
2hmynyIEon1w6Me72fdjaPht4V1tbZBu/76zGxBiBFc13nAKU0dYrvIGPgKN9j0HDuOVC7UhhdTq
Gw+wN3sPJk9D2VtNAzNGw0sa/eJF1wQiBy4RVYG9r0MCAwEAAaOCAdwwggHYMA4GA1UdDwEB/wQE
AwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5Bggr
BgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUG
A1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUF
BwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDag
NKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIwYD
VR0RBBwwGoEYc2l2YS5rYWxsYW1AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBTNBMIvX7vsfxNYWor1Hxth
tmNmHzANBgkqhkiG9w0BAQsFAAOCAgEAJDoTbZO7LdV1ut7GZK90O0jIsqSEJT1CqxcFnoWsIoxV
i/YuVL61y6Pm+Twv6/qzkLprsYs7SNIf/JfosIRPSFz6S7Yuq9sGXNKpdPyCaALMbWtPQDwdNhT7
uJgZw5Rq9FQRZgAJNC9+HBtCdnzIW5GUmw040YclUNHFEKDfycJMKjSPez044QcDoN0T2mIzOM8O
Dt+sJTrC1YJ6+HI6F2H6igZUL79y9qYUz8FNshyITihg/1VBVCiMU9WRK3tNfUlLFzLBuTTr245d
xMh/e75vypL3qDSF4UG6Mpy++Plsnjfwab70KFFyCvNwB2hT1g/y8MLgslfxJl6fCyGdWqOmUB2J
QiuiqbSy8mlnucIPuGWQqqt8VBQjxKYIHdjXtkvw0uVvOHUC2QJWfGWDhMncxF5LFoaRPer4tlXJ
b5zmz9Mn+uQPQQLYUqYzs+EvX1REmGLGUuzlaNwAC20+8CVPY2EkU1mjU78+aW5Zbb2MyjQrLc6J
5IdkekEtk+xjpM992MC/aNMTpWIWhorGq8NmPXbuoUZf9MSi7WrVCaO69ro68FXPTErr/e13lJ/5
GAkwcxdTC+YVPVa/xpdHyAFW03/Oow/7fV8qjy6PAWfqEV97D2Tspc2aEFkbeuFS6UkPRy1OKjGc
/IUTSY4h9roe7Bh1ecqtofP9XL8E88sxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxoOshI0IGR+aGCCXkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIHG6
YIaoWq1uWbg+lKiY4kZy+yHWbQcbYP4ApDUVo/nbMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDEyMDA5MTE1NFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBADTGPatnOn8f1dF6oya5s4eow38yKgJOicwcBX+f
hjFVfW5M40psqOm2xXWGvcwaRRKXqTpCPInVNtBu0zlhO2/5Nt+0lbhgBR5K7+3FI0mVKVKuXTfe
rmFCM+rg0IRNbnlArvP0bXYZOGV9liETka07i6Lq+vL/oUi4gPSd00kd3kURLADcCGl5ViaBjUcc
88CO1wW8PKHifJ9KY5GDjk8jhv72fcqF8JwZfZqToFhq3Pk5H6sP5N3KL82AKnYq7q/gEuBJmAlo
wgQRJkxpiRgJUZJQPTtPv0kwx4yaEqpBaXk3kauqsXf1JiIeI/XByCliJeVQdqnWjDS+hga8c2I=
--000000000000e8ac0e0648ce3216--

