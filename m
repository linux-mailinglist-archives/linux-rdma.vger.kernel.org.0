Return-Path: <linux-rdma+bounces-14757-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2AEC8481C
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 11:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D44A34D108
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 10:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4329F30DD12;
	Tue, 25 Nov 2025 10:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f2fxnEqD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4BB2EB845
	for <linux-rdma@vger.kernel.org>; Tue, 25 Nov 2025 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764066942; cv=none; b=CG+EcwgChDNYlYlEkXfyxsla1F2i/zRRZBNvkoo8+eOGWrjw6Uui+/ZSPA7l66STrw54gHhsSScs79BiNQ8D0ipqpFE0uN/eRAZJuLSPz4unHZPXrHfqfLpV9W8gBNgEzFBct6tJ0kZInG2iYbWiF/kDkqKsvuCFZ7TKgj+RB60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764066942; c=relaxed/simple;
	bh=VGhGlIHbXz9lOo51yxKgwntQ14hgzSd5JMUJfYEN568=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anfPk392f60KKhoMlFYN15Yfs3M0HiQF1E6eAt8tb8iYErTW+UweIm4dwJXsDX349g/4Cq80Mle+ya2/h151k1OqUQRM4pTYJM4K9USNCITEz34dGIYTvNgCI9Orc4wqsPI3A92FXmfI+xnXYNfKuI8eDFD0YAsIBMCTY0t94s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=f2fxnEqD; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-63f996d4e1aso5630665d50.0
        for <linux-rdma@vger.kernel.org>; Tue, 25 Nov 2025 02:35:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764066939; x=1764671739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jt8lkdCeit8DSkpq+4p2lXkje65hXAWg3rjvznMOz4c=;
        b=ZbCKZi3MXWR8xzV7oY3HqLV+yL7ig6LN3GH5urGr90aGt7OCRfbxGVV3z9pJ372efF
         Y5lW9uqXOQSzV6pLN34G44gL4fMu42OpoxVNY9v0WLq4uhdTTPWPaAmHukqI/e2lo0OO
         BeUykNRjJTRFaFXrkRgwkq3Po1jTZ4+MfXdDxWN6pS9UNiPAuX6uIhNg1/k9tMV/ELXn
         HsCRgQ/uBatDlETpyGlS6+F/F6QQGuP6S761SxeId5pozMFgV27zjDUDeYxVXhjk1x+5
         H1tacexfCyGUi9+0DzAhJM2yeLykuTK0So7kh1upJR987AfW430vL6cKHWFlZBztRl1M
         mbcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+YkEY8yuuJxD+2mKDzH5CCG0lTnFUBzKUBj17xd/3+I7gkTU2VvLJ6pOzNZaKQuJ2NMyhBYztAtDs@vger.kernel.org
X-Gm-Message-State: AOJu0YzQDEFUzeqs67qCEFx3Dso1rIPgxlWwQga62iaj3BcnI3eSiix/
	DW8TxMBKNvo65lvL7by6EjE9opweID11q1PrrosrTXg0zHi6FfH+v7/8swSNtEsXGDTEO+4B60i
	ALeKeJd5aql+8BrJD5VgkwffSxyu3tUGsaGKXEXs9npNwbIZywdy+sO4CXJrJ25gRJMwVZEh91f
	BEorN4VHN6v5EwWreQurONix31nMCH6j7R+EyRZ8RDaZO2dDhaHHA93iAIJIB1NZ7s5+Mpoz9hw
	hoW6v+jvtc5jlA=
X-Gm-Gg: ASbGnctDBz8xk+KFGYHxLWh+d3I971H+0mpHdigbAxkyz6EuI4BT+68DoRex/IUWpcb
	G1bINBO5pX1s/hog5FyUNu+MwJkSRZa6KkaRzkcj5oGbkcH9dsNC8kUpolGdcwgprh0O/M4qOm+
	sWB9mQP7G79x+T7efFCXX4oEQazlNvyeZZCqP4stM2Xg9yhtAjJ5KrD+tZDcZ6OSx0vq5+vonVh
	UivPcLNYw25fTmmfLDBPoynaYR6Jugg4r2R5LihVhaZlfHz806s/Wq55HyxjkAPg3dotKXU3YIQ
	H+M62D58GK8kPonbPVweJweYXDEuMzOLTQDaukdsMK6ohjb2r0GDI0QwNvp5sPBNeY9ZRoUv4m4
	qj4gN9XxVqqbnECCZQmsSqn5FO+EdxAGZ9qbHrtX+YY6WmMY0Fe0BzJ0vM3a23T0iZsuGNcueLD
	HYgM+onoEzT9tEMg0PkueWRVq49OxHDXwM8E9oIJ4aHXE=
X-Google-Smtp-Source: AGHT+IHqnr+UFVy2v2dYLZSWBkJ8M9bWuQpnttwl0JMNT/lckPw3IAYDqfnNpUwD04GvNj+iP6d9iq8b7VvB
X-Received: by 2002:a05:690e:885:b0:63f:a488:ba46 with SMTP id 956f58d0204a3-64302a5edbamr7408059d50.32.1764066939180;
        Tue, 25 Nov 2025 02:35:39 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-642f6ec3a75sm1295463d50.0.2025.11.25.02.35.38
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Nov 2025 02:35:39 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34378c914b4so14914035a91.1
        for <linux-rdma@vger.kernel.org>; Tue, 25 Nov 2025 02:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764066938; x=1764671738; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jt8lkdCeit8DSkpq+4p2lXkje65hXAWg3rjvznMOz4c=;
        b=f2fxnEqDom2WYmA3UbrzJNFa7Xj/z4ZXTJO8tnw244y76ji/W4QZXnNvAOiJAa7hob
         n9YFiAcaN6hBpUPNZD/iQ2T05KRg+MfLyUxeuLYmm0r/Yf4+6FoYbjnP41hUTNFWSdIW
         OLWPT7bm8kCwA+/2fMjVLqlgA8Q7l+RWo5/N4=
X-Forwarded-Encrypted: i=1; AJvYcCU87k9RUKG5ax683ufkh227/ZzYF/kc3YlO8jmqjexA731NQt7N9R9hla0CXPxFrAdM0OlSF3tgvK3t@vger.kernel.org
X-Received: by 2002:a17:90b:4b09:b0:341:6164:c27d with SMTP id 98e67ed59e1d1-34733e2d49amr13893787a91.3.1764066937694;
        Tue, 25 Nov 2025 02:35:37 -0800 (PST)
X-Received: by 2002:a17:90b:4b09:b0:341:6164:c27d with SMTP id
 98e67ed59e1d1-34733e2d49amr13893758a91.3.1764066937206; Tue, 25 Nov 2025
 02:35:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117171136.128193-1-siva.kallam@broadcom.com>
 <20251117171136.128193-5-siva.kallam@broadcom.com> <aSSMpzADtbAOBU2r@horms.kernel.org>
In-Reply-To: <aSSMpzADtbAOBU2r@horms.kernel.org>
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Tue, 25 Nov 2025 16:05:25 +0530
X-Gm-Features: AWmQ_blS7u7UyAuIQ-l6ny2AVjnw2tcjbryGMQeY27S4GES7zcK-SqNQt3RgJUI
Message-ID: <CAMet4B55Usiq25oFOPMY6O_A9PUBgM3a8_pEWfbzt49DdaUtag@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] RDMA/bng_re: Allocate required memory resources
 for Firmware channel
To: Simon Horman <horms@kernel.org>
Cc: leonro@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, vikas.gupta@broadcom.com, selvin.xavier@broadcom.com, 
	anand.subramanian@broadcom.com, usman.ansari@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000338506064468d79b"

--000000000000338506064468d79b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 10:19=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Mon, Nov 17, 2025 at 05:11:22PM +0000, Siva Reddy Kallam wrote:
>
> ...
>
> > +static void bng_re_dev_uninit(struct bng_re_dev *rdev)
> > +{
> > +     bng_re_free_rcfw_channel(&rdev->rcfw);
> > +     bng_re_destroy_chip_ctx(rdev);
> > +     if (test_and_clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flag=
s))
> > +             bnge_unregister_dev(rdev->aux_dev);
> > +}
> > +
> >  static int bng_re_dev_init(struct bng_re_dev *rdev)
> >  {
> >       int rc;
> > @@ -170,14 +184,18 @@ static int bng_re_dev_init(struct bng_re_dev *rde=
v)
> >
> >       bng_re_query_hwrm_version(rdev);
> >
> > +     rc =3D bng_re_alloc_fw_channel(&rdev->bng_res, &rdev->rcfw);
> > +     if (rc) {
> > +             ibdev_err(&rdev->ibdev,
> > +                       "Failed to allocate RCFW Channel: %#x\n", rc);
> > +             goto fail;
> > +     }
> > +
> >       return 0;
> > -}
> >
> > -static void bng_re_dev_uninit(struct bng_re_dev *rdev)
> > -{
> > -     bng_re_destroy_chip_ctx(rdev);
> > -     if (test_and_clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flag=
s))
> > -             bnge_unregister_dev(rdev->aux_dev);
> > +fail:
> > +     bng_re_dev_uninit(rdev);
> > +     return rc;
>
> Hi Siva,
>
> IMHO, I think that it would best to handle unwind using a ladder
> of goto statements, that reverse the order of the incremental
> initialisation performed by this function.
>
> As is, this may not have much effect, other than seeming to duplicate
> bng_re_dev_uninit(). But I think that as bng_re_dev_init() grows,
> as it does in this patch-set, this will lead to clearer error handling
> (and ideally a lower chance of bugs later).
>
> I would also suggest that it would be best to name the label
> after what tit does, rather than somewhat general name 'fail'.

Thanks Simon. I will send a patch to fix this.
>
> >  }
> >
> >  static int bng_re_add_device(struct auxiliary_device *adev)
>
> ...

--000000000000338506064468d79b
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
QSAyMDIzAgxoOshI0IGR+aGCCXkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIGsy
w2F4mOw3DK0ZjaT/ngF2ba5d1J3JmCaH3N0Y3iKZMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI1MTEyNTEwMzUzOFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAHoRP1XGP7wxrAFhPy8soP0jNoiYSkAgFttXzQpd
ym1Z8bkZ0aUEj4/CAJg70nW+jHi9ZbTAPP+NGbuPh8K+cyXzZG9ORulhcvsnFHdTnYEe1wKYjPty
b+4gKtgCJjP+oZNcc4qgTKt/gdvd+L9Q7NzwYbnHLsyQ1v/bLESgCKloStAqplr4kPlPTDpAQdxJ
8LqpHwnPtnY9WA9MAML7nZQjSc1EOYTWJqF4gr+KeiYEE1bDhEjrM+iHxogtPSyBRhTT5r+8xPII
eEg5u+2291TLkuQQJlzpo8Ym+E6zKAkFYYLI3kgzW1HNkL5FGqh3rEL0Eso80xISA21e3g7XxG4=
--000000000000338506064468d79b--

