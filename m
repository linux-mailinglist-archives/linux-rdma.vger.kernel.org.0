Return-Path: <linux-rdma+bounces-16990-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIwwHVR4lWl8RwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16990-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 09:29:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB94F1540F1
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 09:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CF14304A9DF
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 08:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F49318EDD;
	Wed, 18 Feb 2026 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ck7MXELX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E108318124
	for <linux-rdma@vger.kernel.org>; Wed, 18 Feb 2026 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771403121; cv=pass; b=oYmLvPQZTgHExYMTgAcjgWhPpUQDu57PPJlhMCTsDDTG8KTU8HERhhkzkZaXLRYUL2urnOn7d+6qQXzJL0JErtz64QfH1XwU/KC4x6xyiGduecptdt41uVMO0iiM2UZyrHaKlmymydLBxUL/YmAwKX62QRfaXLvrG6DFI67eS7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771403121; c=relaxed/simple;
	bh=b5+G3u5jcZTiupM9BUPBrNsxs/ivk2UUbc0PK1GLZ7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QH8rw+DVrR+6La7IKkBtFe41EadGG0FC6V+497W/91HVO61iz4qYQUSF6iFtej1sbH2+0k+phFxjc0PCSgq9VcWG0Z3zof9SZr7dLZmibSvENiIL3izc9YSBBsIBytTqOcU2PENDEy2NlWzyjZmEqXP4zkTS4E7U7L2hVTwZr0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ck7MXELX; arc=pass smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-35621da1a7dso3172501a91.0
        for <linux-rdma@vger.kernel.org>; Wed, 18 Feb 2026 00:25:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771403119; x=1772007919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5+G3u5jcZTiupM9BUPBrNsxs/ivk2UUbc0PK1GLZ7o=;
        b=nGerAdHgJOUbYVBqof5ta87go3wfmg2TI9gr38UArxtJVUU0FSWSEDBIZHQaj+u+JH
         t3eZzKJKckX1ooVoAjE1aGvGXY4h0TPvuEEDrFp/mD7fMCO3+v8j2l9uIERi2gWFLDWi
         sipnIzypco025et7ZuA/ls85YTQSsP1kMWvuBr6Thyt7VpFvlF/07ywHGDWSLOd1pfRP
         qfu6AHK8RQz/W/oEIXw4TmyX2RYP0vuWX08WenCt9ZyY4NT5wKcxVnEC2sBMAN1lXXJT
         dvRjMv5s4ZIiGsmUao+gFqOoUb8NXBEtkXrkFDjcaG3tNqN/5rs/BFX/dIhyDWnTVE/5
         7EuA==
X-Forwarded-Encrypted: i=2; AJvYcCW0szBIafxaqPYI1ry/rJnKcUs/ToZL33N8YXQxJ1Dl7Lqi9spgSLN38/XrqP04XV0ZRoYiRiJ4m42i@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+RaBsoa6SKeesG7vVvg1Xugdw3FyNoIkdWaRPnZYsULO74aIU
	wFvbq+m0q5BsRG/z2D32uTaCpVbz8ntLqmTsK7Ui2hjULwkD22Vgny1oZdtjO58cJ9c47cLqnpK
	h8WnC0WxjTKUK/bjobJfmFPUJxsEKg7Q3Y+SR29dMF1RDeSCbYgMFm3Apb6ac3OgNt07ZYk4dL7
	ENZI/0T+aNWiaPOAYBoJGOCqsmERW/kDWH9hswhctSe4yfEr7TDq2qKy9NUYT6Zwr//B9Soo2DI
	hiAQitqdJJmViY=
X-Gm-Gg: AZuq6aJeny7311tnKpuyZ4nIUJbNNEGH3LrFEefKhYVP5GSvqNli3MHRE4JmT5cT9lA
	tq7YQ4PGQD8RlWUZqeZVcr6QFk/9+BhUaqNj+oJj29s+gVywzJ0Wcs9lXmlsZhX98uSoWGQD/8Z
	eJxUQ9SPfAiz7aOcoGacl3cIR9WU0snXVm0AGv0nwvCIth42g2zVW8GmgSTSSzdvUI0HopVCaJP
	npOevmbUNICKNOQBNU5k3x0IgrdqEP0s6+ClqhJJzoXA7QLFXKpLWa13CbrAWMiY9znIPUR1ZRH
	bONGoOdHR9e/qKGB0pjRItvYgtlBWzvJbYTKbYpV65XJ4U1YpBBwZZIf4bhfMRXuRec/3MWPRuw
	ICbttksk8tJS8fjLPMw/mS7gAnPjCLFlAkH1Y3Myx1/Tq9/Ne3Z/uas3r3HAyvhlj3ynCfTDTgn
	OA8KrtNs2c8T3puaDgjdwH3x7oLYETTF+O6bh5TqmgrAIyxdGmbkoO2Ys=
X-Received: by 2002:a17:90b:1d0e:b0:34c:cb3c:f536 with SMTP id 98e67ed59e1d1-358891e5f32mr1036033a91.36.1771403119204;
        Wed, 18 Feb 2026 00:25:19 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35662e4cf0esm3386243a91.1.2026.02.18.00.25.18
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Feb 2026 00:25:19 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354c0eb08ceso26169347a91.1
        for <linux-rdma@vger.kernel.org>; Wed, 18 Feb 2026 00:25:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771403117; cv=none;
        d=google.com; s=arc-20240605;
        b=cdswljmq6Rmbhvxj6KMWL+Qwa8wXb68q3NPDezy+PlP19kZdFPI8tEmbVku/rp7vdy
         uQDPgu9iuM1ZB79n1wGuI7kb0zE9wfG5BMjFkqKWwIt0gfgMqxb5gSutGAGvzEmJSSlq
         wosy/tZ+0fcWU3IkzanjssRZkGcTpzPe4RTEJpO358mhwW3JzWvwUHmrUtgqslNQSRXp
         DbPQ7x38QYuFflK9dIxVw4E0w0Cwumlc8qKwAno8W9LMd4FbFaIkAV42A6Bmbyp90ZBr
         adWnLcAvQjUB1e/QT5z1mGShzRKFwAMX3B1sArehFzyAfr+O9VLAfMfySfO8UFahf3My
         qBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=b5+G3u5jcZTiupM9BUPBrNsxs/ivk2UUbc0PK1GLZ7o=;
        fh=3q+DweXJH7idEzlt4m63sh5ed6L7xKs3OnwPaQS7JiU=;
        b=TjThH3xMytKAJBrqEB/QojZDfh6xF0XMzKI2Wnoe3FkG8mpgpGaxikeSs+hrkSOZYs
         lNNQfyYWu/P+jNfPREu/IW6BXFWmq0CXO8+3ZMOv30m1SaDp54np8lZlF3YbykiQk9ss
         r7r3XCYUqrH72JEp/+iELoGIHeNjzRVL/jDSSMNCbC1ShO5mEj/Zz/iG1+SB0qTsTMM0
         n7cyWcPQZZSDcmDa1qe7KTKv2ZqOxUo/UijNSzpw53vowH48/58vccRsJzdd7oZO8zBN
         LRwBXja3hFFl778Q00Rq4XB7gydJvEs463PJRiJCqn19UJh/exAlZB2ZU5U6C2blRJef
         4ofw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771403117; x=1772007917; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b5+G3u5jcZTiupM9BUPBrNsxs/ivk2UUbc0PK1GLZ7o=;
        b=ck7MXELXG1HliomlIVJPqjZDAYjw4jOFYdsYHl31mtgLzph0V77CaDqkK61FHsh3ew
         P6nwCUndvrzWLqsubxrmz0q3qFWPcMqIpb5Nt83/vkiyH+cF3v9tahUMP+SUNy+/UBR5
         Ii5MQ69xhym6f1t3ffb+Jpx4auJzTNuGXqPW8=
X-Forwarded-Encrypted: i=1; AJvYcCXERlF6ULINl92S3ErZ9XUt5YlJQK0zoTNd9myg8eOv8zc6Gan58U0TyeJa8j/Kq3+QEABelUHq76Xp@vger.kernel.org
X-Received: by 2002:a17:90b:4ec7:b0:354:a780:6667 with SMTP id 98e67ed59e1d1-358890a054cmr982097a91.3.1771403117473;
        Wed, 18 Feb 2026 00:25:17 -0800 (PST)
X-Received: by 2002:a17:90b:4ec7:b0:354:a780:6667 with SMTP id
 98e67ed59e1d1-358890a054cmr982087a91.3.1771403116976; Wed, 18 Feb 2026
 00:25:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114100728.484834-1-siva.kallam@broadcom.com>
 <20260114115858.GA10680@unreal> <CAMet4B5RtLYaY=wB_T3fBUGYQk-peaLbLsqXy_0Vhp=mqLDm8g@mail.gmail.com>
 <20260217135209.GA281368@unreal>
In-Reply-To: <20260217135209.GA281368@unreal>
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Wed, 18 Feb 2026 13:55:05 +0530
X-Gm-Features: AaiRm53vY_IyLaXh6ejcVFgndGm0TARmgquzEJD3obx6A01gAeZf2Daxkdjhdcs
Message-ID: <CAMet4B5jhJXU8WYmcuw1ba=SuJ2f-YCqnD9fGwQ1MNyjF_u3MQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA: Add BNG_RE to rdma_driver_id definition
To: Leon Romanovsky <leonro@nvidia.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000979745064b14ed49"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-16990-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[siva.kallam@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: EB94F1540F1
X-Rspamd-Action: no action

--000000000000979745064b14ed49
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 7:22=E2=80=AFPM Leon Romanovsky <leonro@nvidia.com>=
 wrote:
>
> On Thu, Jan 15, 2026 at 04:35:20PM +0530, Siva Reddy Kallam wrote:
> > On Wed, Jan 14, 2026 at 5:29=E2=80=AFPM Leon Romanovsky <leonro@nvidia.=
com> wrote:
> > >
> > > On Wed, Jan 14, 2026 at 10:07:28AM +0000, Siva Reddy Kallam wrote:
> > > > Define RDMA_DRIVER_BNG_RE in enum rdma_driver_id.
> > >
> > > This should be accompanied with use of such define, where is the call=
 to
> > > ib_register_device() in bng_re?
> > >
> > > Thanks
> > Hi Leon,
> > I was under the impression that driver_id can be added independently.
> > I am planning to send the next patch series including ib_register_devic=
e.
> > So, This change can be sent along with my next series. Thanks for the
> > clarification.
>
> What's the current status of enabling this driver?
>
> Thanks

Hi Leon,

Next series of bng_re is in progress. bng_re is dependent on some of
the bnge driver's code.
Next series of bng_re will be sent once required bnge changes are
merged. Internal testing of
bng_re with bnge is in progress.

Thanks

--000000000000979745064b14ed49
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
QSAyMDIzAgxoOshI0IGR+aGCCXkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIP4G
BpqrZArGGpgYccdBD6p2pbS2D1xSoHk0JlEzfcfzMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDIxODA4MjUxN1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBACYlm+xZbN9lMvnVgLsn5JguR3K4iX7bGrDsKpMF
mRSAoajnItlUvpb4kqYHHWVAoQyidH3sVaCdaQWy0YH52HtO22NJyyKY27X/wZQGLb1hrl9FM/mU
1IZWeibV3p+XXwLJIqqxzkA+a5BRMElvchlnGnmIckJaiXxsNQnBMDksARXiu67Kj03+NYR/YXRH
6QEAnXoIx/sp0ii9p8vKC63Nie+5yPkgp0LkvvfrzZNn3vtxlZbgIIJOeEnHhT2U61qUOVt5UUp7
T0P/L+cpajAjGF3J1K1nHgH1VyAQWjUX9pFNBNHoR0RqzKtHQp3UM9tVc26zrjiTeunvzFMy/KA=
--000000000000979745064b14ed49--

