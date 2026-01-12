Return-Path: <linux-rdma+bounces-15443-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFE2D116ED
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 10:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 019B830194B1
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 09:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E5D346E5F;
	Mon, 12 Jan 2026 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DResmUv6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f98.google.com (mail-dl1-f98.google.com [74.125.82.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B71346FD7
	for <linux-rdma@vger.kernel.org>; Mon, 12 Jan 2026 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768209262; cv=none; b=UwgGtumWE0jv089Z4xauYxsdWtxZH6XrdUXPgNcATjprxCKIDUblaanLQ9VXnSG3xv8wFvItkO9yiogi9m3rXrS01zLvIGxyX/ZOpEQtUpGsc9m3W5qNOfHkqHd+gB7VLiWqDFoQIfDQr7oeguGmqtsyCif3wG12rClg7DLV3Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768209262; c=relaxed/simple;
	bh=NwdjNAN9NMSorOTjLd86NpA/QPZm5vyafOBOtxc0Ins=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctBWSyJnEqa6+W3tJ2bKs4SiYWMF2wCU90O0+u89UeTjAkFOnSVgV68qWm3WEWeEU2+lia0mMR8igmkm7g+5rXbO9YxpAGPdGaAOxTtoS8gj5blXK+63nchqWumJXSc6VQmEzuGVAWyN3PxhpJUCCJmANTmmgh8Td70PTcWQ960=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DResmUv6; arc=none smtp.client-ip=74.125.82.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f98.google.com with SMTP id a92af1059eb24-122008d3936so3914997c88.1
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jan 2026 01:14:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768209260; x=1768814060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFqvpX49AoHP8iFrAR4Enx+CCFa6se3spuShw0dZi5c=;
        b=pclx1xmq0TFDP1m01NCymKg8pEy4gXlz/eVX8lzgVHGeCRuVBDbbxjL7piQRDgiOAi
         4IwBWDUMtgzn2E3WB8kmcG+oD0pwH9Qc8j+hp6ksIftz7FSzTQzN0HlJNkj3eoZMkHiW
         mcNDVirfDlhIYagtvXOzTPXJQGrmit5eTnPtdbyvXFr0d0g0NqxsHZLtVXPlpV8rlnn/
         S1gRAiYXqx8dAl17hBAjxNL3gui6cHJ/t3peUztHv+eZPimHG7ibbyIHqcCJ0aepLpiD
         6Wd6cpcSuuFFe2xeWPvOMVUPluCc8g2PLOKwxMpcS4OlATeWle08L9Q1d6CaDVyvZ5Ed
         AuuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwTasMJVBOnLzeh6pPqgKaqH/DQFeVOJsTCKdOVvrzFeXZH2LBYofs+6SAJt+b0uvvqvFWpTaeF9kh@vger.kernel.org
X-Gm-Message-State: AOJu0YwOAYa4RL+VV3Nlgz4fdv0G4fz6KGhGi7YW2I/SVYBTJ6PwjHpL
	V7eJAD9sGcv6nBCxRdMqPXfuYW+kxoCNXOMMS6gAk+X6oV8DoYJAGNW2Sd8Ul46q0irZaFE0YZ8
	cvV4+Ue8Qvt5PfrjXcSQ6hESjye9FK6SZAptdaNVRJ7Ce7c07xnaFL+5tOQ5My5mYPOG6/dtw+w
	fBADqLqYoUHhDc+jsp1xOytQKRIfPeXLiKgXvLiswwUD0FyMlpHtZMrZXDTYbHJcknlRBeugDo3
	NUxCVmdQH4Wge8=
X-Gm-Gg: AY/fxX6acQN50yqmw43FiGhA/Jt9d9VQXjwiHI498AVPVOmOX2mQMFqVsJDELESpb0/
	+rZJFzET4bhinO4bcqG8nfYA5AOcnbxa2+JaOGMPLMKx++SPmE8C+NHontjlADlxUaHEZ/lcgBd
	d19+25rkA84ZBCgB25TvEQVd0/+AkzyXyrxKYkGQf66/LhNmCrR1J0llIV0faCE1KQecUUHMgSI
	cUA7ep0dZxkJRiwrcj3CUxgOl67ysQYsOsjbXG8uRhZoiPk2oqfiglyr90rr3odwq/y6NBydC+L
	YLHpHVHK+3N3++kGkQa7hTH5E0SkE01Qz9k3rJrdpL4dI/DV2/FgEXIrDoks71R4MCuqP6lHJb9
	YsjC4SPRJR16qJTFosYn3GFlvdmWG1INk+97lVD11/wBdWzF/pKl+0hMYiSVT00ASr8VoBK68NL
	cO4U9TwSt2dzAP93/6B8MDMAgvcbmE/Rn4WfexK6ym
X-Google-Smtp-Source: AGHT+IFBB2J+Fb1bLqS07dKFRx0m9bpI49/EhwEVGcEf+cYHYk2YnK54Gy4NvxDxD/WwqEc1GwO44TSoQYPF
X-Received: by 2002:a05:7022:6723:b0:121:a01a:85d8 with SMTP id a92af1059eb24-121f8b9cf5cmr16921826c88.45.1768209259399;
        Mon, 12 Jan 2026 01:14:19 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-121f24a554dsm3710031c88.7.2026.01.12.01.14.18
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Jan 2026 01:14:19 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c66cb671fso6155678a91.3
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jan 2026 01:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768209257; x=1768814057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vFqvpX49AoHP8iFrAR4Enx+CCFa6se3spuShw0dZi5c=;
        b=DResmUv6XdgLMlTJBZPta/EeNEFcNNUwO/EwbIWERKC2t6e4mTlz52g3NAk2rMibNu
         UtdDuKHggEL+GdImdOUstXdpuqyDE18/msHdKZnoe+m9ezftapSAPjvQR+jUtcW+ZFg8
         Ii9mTgHYa2c4rpGslb4M8LG9rTjp/Ku09d1vQ=
X-Forwarded-Encrypted: i=1; AJvYcCWI4SdkZOiTkczV8D95eQpMv8Ua4AWs5vfnZdbHcVQ50NJV/1Azh6A/hbmg7IUffPX1cPw6lVLhbGT4@vger.kernel.org
X-Received: by 2002:a17:90b:4d8d:b0:34c:aba2:dd95 with SMTP id 98e67ed59e1d1-34f68c2818dmr16999574a91.26.1768209257579;
        Mon, 12 Jan 2026 01:14:17 -0800 (PST)
X-Received: by 2002:a17:90b:4d8d:b0:34c:aba2:dd95 with SMTP id
 98e67ed59e1d1-34f68c2818dmr16999563a91.26.1768209257186; Mon, 12 Jan 2026
 01:14:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107091607.104468-1-siva.kallam@broadcom.com> <20260111132255.GA14378@unreal>
In-Reply-To: <20260111132255.GA14378@unreal>
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Mon, 12 Jan 2026 14:44:05 +0530
X-Gm-Features: AZwV_QjtRFbvk9vxFAW06uBrbpcNlxdM5qvvSAx6bzjEdAvF9j9bTDHSOL7mROc
Message-ID: <CAMet4B4f1itHok0AxExs2dZdGvAExjuESrB+aUTwO_QbTA-SYA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/bng_re: Unwind bng_re_dev_init properly and remove
 unnecessary rdev check
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, usman.ansari@broadcom.com, 
	Simon Horman <horms@kernel.org>, kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b5376106482d4cc3"

--000000000000b5376106482d4cc3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 6:53=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Wed, Jan 07, 2026 at 09:16:07AM +0000, Siva Reddy Kallam wrote:
> > Fix below smatch warnings:
> > drivers/infiniband/hw/bng_re/bng_dev.c:113
> > bng_re_net_ring_free() warn: variable dereferenced before check 'rdev'
> > (see line 107)
> > drivers/infiniband/hw/bng_re/bng_dev.c:270
> > bng_re_dev_init() warn: missing unwind goto?
>
> Please provide commit message.
Sure, will do in next version of patch.
>
> >
> > Fixes: 4f830cd8d7fe ("RDMA/bng_re: Add infrastructure for enabling Firm=
ware channel")
> > Reported-by: Simon Horman <horms@kernel.org>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <error27@gmail.com>
> > Closes: https://lore.kernel.org/r/202601010413.sWadrQel-lkp@intel.com/
> > Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
> > Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bng_re/bng_dev.c | 33 +++++++++++++-------------
> >  1 file changed, 16 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniban=
d/hw/bng_re/bng_dev.c
> > index d8f8d7f7075f..e2dd2c8eb6d2 100644
> > --- a/drivers/infiniband/hw/bng_re/bng_dev.c
> > +++ b/drivers/infiniband/hw/bng_re/bng_dev.c
> > @@ -124,9 +124,6 @@ static int bng_re_net_ring_free(struct bng_re_dev *=
rdev,
> >       struct bnge_fw_msg fw_msg =3D {};
> >       int rc =3D -EINVAL;
> >
> > -     if (!rdev)
>
> You have other places with impossible "if (rdev)" check in this path whic=
h you should
> delete as well.
Hi Leon,
I see only one "if (rdev)" in bng_re_remove . Are you referring to that?
Thanks,
Siva

>
> > -             return rc;
> > -
> >       if (!aux_dev)
>
> You should remove this check too.
Yes, This can be removed.
>
> >               return rc;
> >
> > @@ -303,7 +300,7 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
> >       if (rc) {
> >               ibdev_err(&rdev->ibdev,
> >                               "Failed to register with netedev: %#x\n",=
 rc);
> > -             return -EINVAL;
> > +             goto reg_netdev_fail;
> >       }
> >
> >       set_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
> > @@ -312,19 +309,16 @@ static int bng_re_dev_init(struct bng_re_dev *rde=
v)
> >               ibdev_err(&rdev->ibdev,
> >                         "RoCE requires minimum 2 MSI-X vectors, but onl=
y %d reserved\n",
> >                         rdev->aux_dev->auxr_info->msix_requested);
> > -             bnge_unregister_dev(rdev->aux_dev);
> > -             clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
> > -             return -EINVAL;
> > +             rc =3D -EINVAL;
> > +             goto msix_ctx_fail;
> >       }
> >       ibdev_dbg(&rdev->ibdev, "Got %d MSI-X vectors\n",
> >                 rdev->aux_dev->auxr_info->msix_requested);
> >
> >       rc =3D bng_re_setup_chip_ctx(rdev);
> >       if (rc) {
> > -             bnge_unregister_dev(rdev->aux_dev);
> > -             clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
> >               ibdev_err(&rdev->ibdev, "Failed to get chip context\n");
> > -             return -EINVAL;
> > +             goto msix_ctx_fail;
> >       }
> >
> >       bng_re_query_hwrm_version(rdev);
> > @@ -333,16 +327,14 @@ static int bng_re_dev_init(struct bng_re_dev *rde=
v)
> >       if (rc) {
> >               ibdev_err(&rdev->ibdev,
> >                         "Failed to allocate RCFW Channel: %#x\n", rc);
> > -             goto fail;
> > +             goto alloc_fw_chl_fail;
> >       }
> >
> >       /* Allocate nq record memory */
> >       rdev->nqr =3D kzalloc(sizeof(*rdev->nqr), GFP_KERNEL);
> >       if (!rdev->nqr) {
> > -             bng_re_destroy_chip_ctx(rdev);
> > -             bnge_unregister_dev(rdev->aux_dev);
> > -             clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
> > -             return -ENOMEM;
> > +             rc =3D -ENOMEM;
> > +             goto nq_alloc_fail;
> >       }
> >
> >       rdev->nqr->num_msix =3D rdev->aux_dev->auxr_info->msix_requested;
> > @@ -411,9 +403,16 @@ static int bng_re_dev_init(struct bng_re_dev *rdev=
)
> >  free_ring:
> >       bng_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id, type);
> >  free_rcfw:
> > +     kfree(rdev->nqr);
> > +     rdev->nqr =3D NULL;
>
> Why do you need to set NULL here?
Not needed. I will remove this in next version of the patch.
>
> > +nq_alloc_fail:
> >       bng_re_free_rcfw_channel(&rdev->rcfw);
> > -fail:
> > -     bng_re_dev_uninit(rdev);
> > +alloc_fw_chl_fail:
> > +     bng_re_destroy_chip_ctx(rdev);
> > +msix_ctx_fail:
> > +     bnge_unregister_dev(rdev->aux_dev);
> > +     clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
> > +reg_netdev_fail:
> >       return rc;
> >  }
> >
> > --
> > 2.25.1
> >
> >

--000000000000b5376106482d4cc3
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
QSAyMDIzAgxoOshI0IGR+aGCCXkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIKLA
0JGj2DryqS/fFhn/tI9iDQcwYNV3+glLOjfGika/MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDExMjA5MTQxN1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBALO15fxMAOo0+fNb25QsKXuS29Qp6ZQ+Zvv/3Ogf
1srXX+2PAUKbvMOnGMaikKdpM7YxZqNQ2wexq9SuyjZwYXieFUXQNelWczG+T+6gVhObcLYYXLzh
B82rLWxi1Y+3NiDsd8K/Q/uBqhmT4wQjbauREXCrvNt6/vLHkt8OcfArwavHhF4IWl4exklf3bCa
y1EZzw/1OGg5AmTztC6ZAbTznUQUmGEiFYuXIF2hTSEIKj401P/2rpmvB19o7AGzaFTyuw/s0Vjs
vQ7qk/Cgtc2TIDFoP42RRPB2OKx5bWZCbZ6fz2S0jDrPC7Ul3xFOkTP7DNJpqSjikSOZ6c4HkDE=
--000000000000b5376106482d4cc3--

