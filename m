Return-Path: <linux-rdma+bounces-15454-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC40DD11C35
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 11:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5706E3003842
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 10:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B0723EA97;
	Mon, 12 Jan 2026 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dHViR8/2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5007523EA89
	for <linux-rdma@vger.kernel.org>; Mon, 12 Jan 2026 10:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212956; cv=none; b=DDP8IwpDqWiPYuk7kmJuxfPZyJQpeFYot9SgM/A+mystcSw/xFTX2wUrjp8DYwy+ttueny9VY2ul8aCxJSDdLQTU3WtvnrleSRH0WMBR3jNkKmlkrf7t4yGb44mpsXt3YPh765DGpmRhTjoQshavKnfDw12rnqftkdqon1T7JTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212956; c=relaxed/simple;
	bh=BORL1u52t+gxRRLXI9evN+opR2JJpdD+n91yHiC3HqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLRJCCFIjRcwSWtmgFjqyGj0MV+0QNrNL6K7ZyscEB3Zn67boC2a9kdcS04OW6b+JLnbFCUGzLqcD7MJSaIfjrB8vvtwUpFZFoy00SThsIzVdlpMIe1xnQeahgDgE3BMvbQ4nfTfe+pybg4sgpUAfaxkxfqLBBfTaW9T0gujS4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dHViR8/2; arc=none smtp.client-ip=209.85.222.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-8b2ed01b95dso694661185a.0
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jan 2026 02:15:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768212954; x=1768817754;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tJ9/PWvZdHPfavXwEmKjk2P3eH9W7WSnaqB5vgrv3E=;
        b=Bd7pv+sQ6Yp2Qx724eyr/1AOy80mE7/+qB3gdvudfALxQYGnOGBEZkT7NeHsKQ6lkr
         m3mo8azRrWaZCOemB/8w4Pj/YIQpbRFXzrv/aVztPWXZkYa0fw72AveukuWJyE98ZC81
         o+/1iVXdgej9SLTn+B0Qs4zj5FxvICgVb/cqByA/Ry6vLuUssGAG/2IwLGoZ3uVzE/zb
         FKOAHg8hORhWFaFKHbRSZSu8JeOowS3JuTRXzyBjU/Sszy6WMhcnqBi+UligpvwVne9P
         BU+XxmLzP2M7CgoYhIxdsicv0DPg67SFGuJoe9nfzq10SFRAOiMFUNbdSPzz9TRyUaDy
         aixg==
X-Forwarded-Encrypted: i=1; AJvYcCWETkj4cU7uh0f4yVwN9WU1dUz+Mo5C1IIYh57pQ3RQr47pyDHEWiR6mGaNkj6ysUdN2qp7wNe7cSnF@vger.kernel.org
X-Gm-Message-State: AOJu0YxjDdFEKu2NfYewaDLXXulFfafMNvfuGKJQxnez+ZXU3CBbmeqp
	mhpRRTtcVkUjIBBSlfKu43uWvcGcfvG6Go7QGKm+QWURZXDf44a0JiLJXoqKz9eO9AFqD/qAOxk
	1aetzbZERcDS/GzMUUXnvUiWjEAMbAHTGnZjKUIZnQ9b/OwRo8Bn89/4p3RhCYpk57P+oBgBP0l
	kgIMwICgrXg4pJnHEhQWyR9gKsDKcaJlTzbcfWwv1hPc3NhLe+2A7/Td1gJ1Lm174UUdD8xkpQu
	EO/ruDSzoP0JUM=
X-Gm-Gg: AY/fxX6x5i5P1LnumM6IQJF2tT98F5/Jt3mhbIjyPgiGhn+8rdj0GJuE3YKWS0zVg9w
	+ji2AO7cxx7PBzCGfNA1WyviZHny/KHxA0PQAoOq0tWtf0DaelrmrsIr3LfBaCHnNVZ+QLfCyBA
	x74+qfv2LFMcsaZhua5B3LZbyYO9nqtt6cKFZQNW3kC8rmQ4NIiJAElXmh9ZfsMICBk1WBKARRD
	m6PkRoaX1GulBvk2NMV59HlSDO0wXOKbbULV6UPIgRFIh87xI7dcARN4MMVvJXpV4xH3jBd17og
	mwZJBjr78W6nsXnyDJrjoobhjWg6GXc8QiOukNrdTB44CLFTFLFzqSKzvlp/0E9plwqMIIZgocO
	fw5CXB/Hp1sbqj1Uv0hW55anctPs93eQQgLiVwhOngqYkeCKgaJxu7/n/dOCRhOJgB35xDQhot9
	SKnXa19ISR+3OruaGC1IqFMjHYkt/h3y4rGOC3eE0y
X-Google-Smtp-Source: AGHT+IFFjudWAwcDsbHmFLDeIXlCZaiPpD5bgbEaTQmCpJ2yG1rVHEf8c1BWKLJPdtVP1T93KyvXRjhbKoOT
X-Received: by 2002:a05:620a:bd3:b0:8a2:6690:2417 with SMTP id af79cd13be357-8c38940bc02mr2530136785a.67.1768212953970;
        Mon, 12 Jan 2026 02:15:53 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8c37f460d66sm190610785a.2.2026.01.12.02.15.53
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Jan 2026 02:15:53 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34ec823527eso1323039a91.2
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jan 2026 02:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768212953; x=1768817753; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/tJ9/PWvZdHPfavXwEmKjk2P3eH9W7WSnaqB5vgrv3E=;
        b=dHViR8/2GLcP1+pUEkL2LbQduufAbE8KL/JZdIP7HAwuwYwGolyQexVWPCQTevIXP5
         kH+E8jS2cvvPILoLWE7mjGgUpAQkpogBWVVsuXpMW2exlirFK3Ua/JMd7F2wQtESjCRH
         MLfGUPYWxlgzr8CFQ/m8CCvw/uEtQ9y9oQE3k=
X-Forwarded-Encrypted: i=1; AJvYcCVmMAewNvK3o0OqMJOPihyrLox7C8rGKUmYBQrAflwmSURH+gJxRjhBcAFOkJ+FaqEb4em02ThXFBR4@vger.kernel.org
X-Received: by 2002:a17:90b:1c87:b0:34c:9cf7:60ab with SMTP id 98e67ed59e1d1-34f68c62b63mr14052528a91.32.1768212952754;
        Mon, 12 Jan 2026 02:15:52 -0800 (PST)
X-Received: by 2002:a17:90b:1c87:b0:34c:9cf7:60ab with SMTP id
 98e67ed59e1d1-34f68c62b63mr14052517a91.32.1768212952395; Mon, 12 Jan 2026
 02:15:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107091607.104468-1-siva.kallam@broadcom.com>
 <20260111132255.GA14378@unreal> <CAMet4B4f1itHok0AxExs2dZdGvAExjuESrB+aUTwO_QbTA-SYA@mail.gmail.com>
 <20260112094530.GD14378@unreal>
In-Reply-To: <20260112094530.GD14378@unreal>
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Mon, 12 Jan 2026 15:45:40 +0530
X-Gm-Features: AZwV_Qjmq_olOv3e10ynu5uvTGkAZgJ4qo1ZzjQ3Ybn1BFRg6lDWzK60D01Wkr4
Message-ID: <CAMet4B4LGg+KrMCJDZWFt2otzdNAfZnKM=+P80kHY7Hzvny7QA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/bng_re: Unwind bng_re_dev_init properly and remove
 unnecessary rdev check
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, usman.ansari@broadcom.com, 
	Simon Horman <horms@kernel.org>, kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f4ff9306482e28fc"

--000000000000f4ff9306482e28fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 3:15=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Mon, Jan 12, 2026 at 02:44:05PM +0530, Siva Reddy Kallam wrote:
> > On Sun, Jan 11, 2026 at 6:53=E2=80=AFPM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > On Wed, Jan 07, 2026 at 09:16:07AM +0000, Siva Reddy Kallam wrote:
> > > > Fix below smatch warnings:
> > > > drivers/infiniband/hw/bng_re/bng_dev.c:113
> > > > bng_re_net_ring_free() warn: variable dereferenced before check 'rd=
ev'
> > > > (see line 107)
> > > > drivers/infiniband/hw/bng_re/bng_dev.c:270
> > > > bng_re_dev_init() warn: missing unwind goto?
> > >
> > > Please provide commit message.
> > Sure, will do in next version of patch.
> > >
> > > >
> > > > Fixes: 4f830cd8d7fe ("RDMA/bng_re: Add infrastructure for enabling =
Firmware channel")
> > > > Reported-by: Simon Horman <horms@kernel.org>
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Reported-by: Dan Carpenter <error27@gmail.com>
> > > > Closes: https://lore.kernel.org/r/202601010413.sWadrQel-lkp@intel.c=
om/
> > > > Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
> > > > Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
> > > > ---
> > > >  drivers/infiniband/hw/bng_re/bng_dev.c | 33 +++++++++++++---------=
----
> > > >  1 file changed, 16 insertions(+), 17 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infin=
iband/hw/bng_re/bng_dev.c
> > > > index d8f8d7f7075f..e2dd2c8eb6d2 100644
> > > > --- a/drivers/infiniband/hw/bng_re/bng_dev.c
> > > > +++ b/drivers/infiniband/hw/bng_re/bng_dev.c
> > > > @@ -124,9 +124,6 @@ static int bng_re_net_ring_free(struct bng_re_d=
ev *rdev,
> > > >       struct bnge_fw_msg fw_msg =3D {};
> > > >       int rc =3D -EINVAL;
> > > >
> > > > -     if (!rdev)
> > >
> > > You have other places with impossible "if (rdev)" check in this path =
which you should
> > > delete as well.
> > Hi Leon,
> > I see only one "if (rdev)" in bng_re_remove . Are you referring to that=
?
>
> Yes, this is the place I noticed as well, but I would welcome a more
> general cleanup.
>
> Thanks
Hi Leon,

Got it. Thanks for the feedback. I will review the code again and
remove unnecessary
checks.

--000000000000f4ff9306482e28fc
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
QSAyMDIzAgxoOshI0IGR+aGCCXkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIP7a
cn78L76XQqZOw6gJHWbiH8n1jIibK899OpaqUthZMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDExMjEwMTU1M1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAIiRx/QOqpvhy3sBcI1NVmCMYdTrqTWrVtV32kng
v4hvnFGebpYhhdgUpZ68xW4XmMXWdOyH+t3LPuW8Wz1CytK/G1Nlgme0vU521EvKsijqMYS6uef9
hh7AHUaxOm+KEAf4kEGZIzpeyu1yIKbCWALWZDMx6ESblz29ekabG9sdECr+soSXll+2UGbAJCf8
kMA93Sjjb1KDluptTdyNk9PHPvKl3rRhG+hqDYor2q8nCjy+b7EP2M09ZX/pIa36HlSSSwp9SjAS
GPZcEWTSfkDRAdRmvEPvgVVkqrc9G5HGbz+QB1rPcFF9qU70SuywH+E7hiywjkPMxg/xD6UoN9s=
--000000000000f4ff9306482e28fc--

