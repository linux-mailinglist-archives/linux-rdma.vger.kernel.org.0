Return-Path: <linux-rdma+bounces-3079-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD8E9059B8
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2024 19:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3912837BB
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2024 17:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BA817E90B;
	Wed, 12 Jun 2024 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cvN2U8dJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7666EB74
	for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2024 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718212578; cv=none; b=ViX+MkmZ8It7QTdIYtW4VZbz2wAKGyOZa7Z8S8xffY+tYT/Vx1upeXij1x07mUXRv/ATJN9JevAgFdUA7gfEs0mcKVPyTfgUyAs6Ah+LYcx8yyyFCd19oTxdSHzB03NXRix6FLpf/mqbeuNsmWLxN/qpIkTzasNQaL69PIW5h/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718212578; c=relaxed/simple;
	bh=Nn7xZ6+M5HdAuAeWF9NxwJw/t9JGnQ5Iyz6NBnsOiks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHP2UYeJLq8L1/127ESeqPvQW2CZY24ackreun+MpNgr7FJebtHsVM/4DBIskc5fpnd0MeP8JxgXTJWQ2WolcWfOKzZfRdovLDc20yXTr9L+Kq8RyRDH8mSGWcY3OBoaDvyxpZ/wHtfEE5CfcnIxl4aUoOpHM1ya9Dzz1GHo2Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cvN2U8dJ; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dfe398bc50dso94083276.2
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2024 10:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718212575; x=1718817375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nn7xZ6+M5HdAuAeWF9NxwJw/t9JGnQ5Iyz6NBnsOiks=;
        b=cvN2U8dJdNg6YCdqXeGF9eTjh/WPuYX/RjdAtsGY5UhYbCDZONyUiKScswePz0EEcb
         Vw9KbuR/7IrlPvOmf1VpfxZa68l6jQ/5LlZAMdDjGtHSpJNZz+buIjmvWjE3lT27l3Yn
         Da7D7+HKpRkeHlQce8yv48YoVE0vtDlwRZ2yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718212575; x=1718817375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nn7xZ6+M5HdAuAeWF9NxwJw/t9JGnQ5Iyz6NBnsOiks=;
        b=Nwm9yMK2uSLhgdMnnwD/7CVPO4QJdcRZ4hoWoLmHD+xm4bQ+suQTQtWybk2h7sIp1i
         2iq9qeVMSH4VirPk7DtRXcJgrKS+Of/mN5LonA+rT1ECr+/uTfMULf9av3bOdNBsdEDu
         tM2+2B7PyoUCtGFavbYKvGeDvUJ46m6X25aVqJSS+dWDbhi+lVESoWUbAovjeADoNDcv
         17gjJPIL0va7ulWIrC3mc0cSqq/xET2bY3AXbF84DuEtEYmkiZPGYN7X6uDgwF+qIDK7
         5a5j+GpC4iffMGbDjA5n3UTCJu37X8+uJvVoR0/Obr8kBllseRV72DFYvmTt647K2+Kb
         6yZg==
X-Gm-Message-State: AOJu0Yw2VqgsGN8BDs/jKKpfPwN9Q+p5BWKQt52SoQ9Rei7MihJg7gqN
	HOdxJkHMEe8B4UedJ0CQq9RkOHWkFqKvOaS/jqHBFFoSfFAfoXRdmYqE5I1l/rmSqaJ9pz45JxK
	29GYgx4hKeWacJoB1yRbiqc3pmnvZVOMBGGhDtTr36wEogfs9T/Ep
X-Google-Smtp-Source: AGHT+IEZLJF5o17E+zrFj+L6S9fsCGnwYRx8Qq/eDAQXobNJlz6Jko15z45pBEFFVpgyHebtzCN7GzfBOo0pu/8bXNU=
X-Received: by 2002:a25:2904:0:b0:dfe:7582:b491 with SMTP id
 3f1490d57ef6-dfe7582b6c0mr2527517276.62.1718212575371; Wed, 12 Jun 2024
 10:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87jziucdlj.fsf@daath.pimeys.fr> <87frticdf8.fsf@daath.pimeys.fr>
In-Reply-To: <87frticdf8.fsf@daath.pimeys.fr>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Wed, 12 Jun 2024 22:46:04 +0530
Message-ID: <CA+sbYW1bONzFsrKAD+NLbBEuSDvqdZ+mPT1srwXrp67go6GRaQ@mail.gmail.com>
Subject: Re: What's the current status with bnxt_re-abi.h
To: =?UTF-8?Q?Pierre=2DElliott_B=C3=A9cue?= <peb@debian.org>
Cc: linux-rdma@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003add4a061ab48a2d"

--0000000000003add4a061ab48a2d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
 bnxt_re-abi.h in linux kernel and rdma-core uses abi version 1. We
dont bump up the version in upstream and backward compatibility is
maintained using the comp_mask field of the interface structures.

If you are using the latest drivers maintained in the Broadcom site
(which uses ABI version 6), you need to use the libbnxt_re hosted in
the Broacom site itself. We maintain compatibility between the Out of
tree driver and Out of tree library.

Thanks,
Selvin

On Wed, Jun 12, 2024 at 10:21=E2=80=AFPM Pierre-Elliott B=C3=A9cue <peb@deb=
ian.org> wrote:
>
> Pierre-Elliott B=C3=A9cue <peb@debian.org> wrote on 12/06/2024 at 18:47:3=
6+0200:
>
> > Hello,
> >
> > In bnxt_re-abi.h, the abi version mentioned is 1. It's used as it's in
> > all libibverbs to determine the min AND max supported ABI.
> >
> > bnxt_re isn't currently mainlined in the kernel,
>
> Sorry, a word is missing: "Recent bnxt_re isn't currently mainlined"
>
> > and those eager to use
> > the driver need to rely on the one provided by broadcom on their
> > website.
> >
> > The thing is, they bumped their ABI version multiple times (current is
> > 6). In the current context, one can't use the manually compiled bnxt_re
> > driver with libibverbs as any call will error due to the bnxt_re abi
> > version being outside of min/max supported abi version.
> >
> > What's the current situation regarding bnxt_re, should we consider
> > libibverb support of bnxt_re as deprecated?
> >
> > Of course I could have missed something, sorry for that if that's the
> > case.
> >
> > Bests,

--0000000000003add4a061ab48a2d
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAXDH6+uOoEh
U/R4bQPVe2Zcov0ciTw2i6Eae4pDto2tMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MDYxMjE3MTYxNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCaAXT7KQ8StdVK1cCJtv6Fyyzh1CiJ
aKoaZH+fHSboFL4cozzscK/TEcYFg2TOJx3S1nw2FQoWglmgALLv5Iyv69jqk5yiJ60pZS2Io2Fj
0biHtOgQIK/ILgirC9FHEpDct+tYSMK95ScicikwevTBYtskrxxjhJM1mxnKU7haOZgfpF43BUHk
8hqhzUH+Dro4ThJsh59YmJZKNCcy74Pk8DTQtq3gFT76J8tqtWrvhjhIHJfBBZAsDwNBnXP88/2+
z6snMgR+PCUqIFP1mmxJfa2aLDMJAPgCG13TpQIS3V7JttT33bvRRV8umnRTayth29LPE8ZcB8+i
VFDs1YuK
--0000000000003add4a061ab48a2d--

