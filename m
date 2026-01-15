Return-Path: <linux-rdma+bounces-15578-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 869ACD2412E
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 12:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFD3C30D1841
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 11:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE06A378D71;
	Thu, 15 Jan 2026 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dhbAOUTq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A39374176
	for <linux-rdma@vger.kernel.org>; Thu, 15 Jan 2026 11:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475141; cv=none; b=Ce7+NC666gJNvxq3i4Lwy7FOMVPzikY7NPNTQzfLadnh+uo4GrjqG4EPg8iAuR0Drw23wJ9T8Fp56NuYDarIIy8N8wKvHuXhhvRSfYXpZ0vz5EaXH3WIXulwhass15ZYhdnMr+gMMTer82i0ShyJFIR/VG7UcUQHemFlvJ3VCIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475141; c=relaxed/simple;
	bh=o0FeOA7XzUMq3e2CckjcoVYZJtY7nLrpPdntZPOrpsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MoljuYcM1gY2Dk6nxxrkgQZG95EYi8p8cWwN29WsM9agyqEx3E47+5eO05UOsFA3VeoFil28N/UKH3EMz8W5tryteI3743jdBZYxsHI5Lu6PuXNT+IR3KSIExyKhXguXM65fvYO0GJFTB3NN+0Bm7ctAAA+SuqwxhxN9MnhiEkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dhbAOUTq; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-81e821c3d4eso677120b3a.3
        for <linux-rdma@vger.kernel.org>; Thu, 15 Jan 2026 03:05:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768475136; x=1769079936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4GcPdQGhsLTDJJtn0lBVDqZP5bYttR7nauatfGfkP8=;
        b=Cq6SdUq3C28H0gtkbDCoUPLRHUPT4d1/Ro10neMm5iM7uGzYV0brDkmgLOqGYjYSyz
         46/c0RuHLg5pEVSRgC3qqkdXZjlciO4qRU8rd8U+/jC0QUW537AM91xyQbxyvD34PnMX
         Gh8ptJKKX9ri5dKBThBe7k2I88DXjRUeTEf2Ysx1KGTj0hB130VWiwLLfbtGc9rxSVBW
         eOkA8MSjA5+aT1Goxdl1dcoTT5fawJMarefUcimsQUhNxateAkhjaH7woOqxIAy9FVXP
         mcxFJEDtTPAHuPXEeYvwNYAG0325gqTyWkfm/wjI24S8UBYpimOj6n0186TfGP334ui0
         +Rdg==
X-Forwarded-Encrypted: i=1; AJvYcCW5hxZiyrvoXDp8Jfy8oatx2bKl0IiVeGUMotPEimQdwQ1L0gVNmzkgmB5qmnl4KUPHycWttHExjvmb@vger.kernel.org
X-Gm-Message-State: AOJu0YzDZyIhU035PzPlDwiOhLi7dR+ABTiFDMrxjJF6GG6XAH6JZ/4w
	lTGkLlTBehYnwUIL2nrx+PIiio7Y+Bug/Zo7MYoWWwt511pZ443ETbKLgF08r6IlDkBUNLejre1
	3u3Kf0hMmoB9mxq+DZsl03K5WrCVafuH+oPN0TesyZDJUCXOIm70vC9BGc4XrI7SSHZBYC7OrYC
	A6AhUWQkQjOjuDcD6isbpMEkXC5SfvIx8CojVPS2faSg6ZAqvXgRzmNuafdm/ySsyKIb/ajWtAS
	6+49YI6hqg8Qow=
X-Gm-Gg: AY/fxX7KN8GZxPC86Dl38QsdIOgHfy8Bvae50FZLHJpygtAp4OoB7cWZK03sBiAqSsJ
	zGdr2LSDAglOgpPBCQg6mAUaOGyw54MYm00CuwzrrGAsZzLEbWJ/RKeDP6LUd4OfSuWtYwhUE4B
	wcsFyGwfxl2OaaajS5T11FnEqNYCYVFBdwbfPfZMRYF9rOuHIvvY/zui0qoVmsk/JEtCTZ2K1ec
	Ps+NuIEr1El0gGORhjh8yOvVqgajFMv47wCHTQP4l1Hchssyv+YdnPRe5AfZjl5pcMDWth5tGgw
	KDfcDoSm0g82HHL/93vCnd45sBKtc3TQjyKMt/QHPJfoJLNsiA+PLbgEiDlFDZMdowGMc1VwKa5
	eKpOSDduSA66TUiQWmqIPi8d1DABgVoHnhIpIKBqj9Lgwt6Ps8Q3SQUebDD9l61FESEGdYgBXWZ
	bfUVE2k1huIW3gcA7r4UCr4Bh9b9BmsRC87vJZ+5x+CuchIg==
X-Received: by 2002:a05:6a20:728c:b0:366:14ac:e1ec with SMTP id adf61e73a8af0-38befbffbfamr5577595637.62.1768475136015;
        Thu, 15 Jan 2026 03:05:36 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3c49d15sm31144705ad.14.2026.01.15.03.05.35
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jan 2026 03:05:36 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8888447ffebso21659636d6.1
        for <linux-rdma@vger.kernel.org>; Thu, 15 Jan 2026 03:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768475135; x=1769079935; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B4GcPdQGhsLTDJJtn0lBVDqZP5bYttR7nauatfGfkP8=;
        b=dhbAOUTq/Gl4Tde/L0r62tiu8BnfPGyOrztMsTmhFYF22nz8P3JeZX0/RN7F9L1Da/
         wgB1ZychTQH8elunhiGx8lEbQx6DPFaxUIPuPnR7Z/FvJmnO780Sd2TK+mM2dqM7Rowb
         JCeIfOHJLzH78gnnd3o7tFvZsCxcL5jC49f7o=
X-Forwarded-Encrypted: i=1; AJvYcCVryLaA4H86JauuJc0Bb505yljmEqXsmXmkepc4kv5PIWc5BB4WerBoYEFc5EsydBwwQuH3kft9ax8M@vger.kernel.org
X-Received: by 2002:a05:6214:19ee:b0:882:6cd3:7f64 with SMTP id 6a1803df08f44-89275bfe15amr76801656d6.44.1768475134815;
        Thu, 15 Jan 2026 03:05:34 -0800 (PST)
X-Received: by 2002:a05:6214:19ee:b0:882:6cd3:7f64 with SMTP id
 6a1803df08f44-89275bfe15amr76801106d6.44.1768475134228; Thu, 15 Jan 2026
 03:05:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114100728.484834-1-siva.kallam@broadcom.com> <20260114115858.GA10680@unreal>
In-Reply-To: <20260114115858.GA10680@unreal>
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Thu, 15 Jan 2026 16:35:20 +0530
X-Gm-Features: AZwV_Qj3zCTOGtIceba_USnoSZjg0MYCasG8KM53_iM4z74kHQj-huUOSaUUO6w
Message-ID: <CAMet4B5RtLYaY=wB_T3fBUGYQk-peaLbLsqXy_0Vhp=mqLDm8g@mail.gmail.com>
Subject: Re: [PATCH] RDMA: Add BNG_RE to rdma_driver_id definition
To: Leon Romanovsky <leonro@nvidia.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003c2adb06486b3475"

--0000000000003c2adb06486b3475
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 5:29=E2=80=AFPM Leon Romanovsky <leonro@nvidia.com>=
 wrote:
>
> On Wed, Jan 14, 2026 at 10:07:28AM +0000, Siva Reddy Kallam wrote:
> > Define RDMA_DRIVER_BNG_RE in enum rdma_driver_id.
>
> This should be accompanied with use of such define, where is the call to
> ib_register_device() in bng_re?
>
> Thanks
Hi Leon,
I was under the impression that driver_id can be added independently.
I am planning to send the next patch series including ib_register_device.
So, This change can be sent along with my next series. Thanks for the
clarification.

>
> >
> > Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
> > ---
> >  include/uapi/rdma/ib_user_ioctl_verbs.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdm=
a/ib_user_ioctl_verbs.h
> > index 89e6a3f13191..b78bcc8cf3e7 100644
> > --- a/include/uapi/rdma/ib_user_ioctl_verbs.h
> > +++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
> > @@ -256,6 +256,7 @@ enum rdma_driver_id {
> >       RDMA_DRIVER_ERDMA,
> >       RDMA_DRIVER_MANA,
> >       RDMA_DRIVER_IONIC,
> > +     RDMA_DRIVER_BNG_RE,
> >  };
> >
> >  enum ib_uverbs_gid_type {
> > --
> > 2.25.1
> >
> >

--0000000000003c2adb06486b3475
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
QSAyMDIzAgxoOshI0IGR+aGCCXkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIIWW
EON+9DfMP+5SPVB3cmOQ8vBtipd1cC5JgCFE0zPZMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDExNTExMDUzNVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAHxPRCvZd42yXyQCm6iUu0gPOUnDfpnlK6Fmkrhq
+QiRSb+C61ew8oiuZo31y+0Nq+2XO9BNJ9t2ANydDWfv8ZGFNn1VxVHrqVbuzqH1gMXr+ttJz/rz
ytDTP7BUkiaOi24UVHTmHqH2U1gSJROaes2ks58JywTdAZcVkPKo1D0eHbzyO9ejoi+fSnlhllaa
FZErI6w9knLTslQjpuffFZuKlKKZHsnMFYZUaa36MdQCLq7c2K1EcW5QYfOhoxmqW0XCaEYU/2QK
KIoqe+D4zAM9nUQwVrEjaDGu7KVQ5x2gPZzZMONSVZE2a1Vp1QZplUPTQCz4Avedh1mOIKecNws=
--0000000000003c2adb06486b3475--

