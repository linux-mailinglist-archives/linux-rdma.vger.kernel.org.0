Return-Path: <linux-rdma+bounces-6453-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C3C9ED30D
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 18:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A071655B6
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 17:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A771DAC90;
	Wed, 11 Dec 2024 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QFn+QMdm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B4A24634B
	for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733936831; cv=none; b=W8HyGgmid2rHO3MJc02gbLmV+F/po/fL+QlO7fRMDQjwGb3BA34RLr3dj4wann9bEVmcrnqzby2tbSjDegUXTYILvGF28YUnNlRmxfX3fEUEMjalSTj8yoFqnzgyKZZMpkZl600BJz8t/ZAj47XyuJ9F+NQsZqi/OTOjzrte5MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733936831; c=relaxed/simple;
	bh=WX4jCODQRfbngT4qtvVJZ92wrClNrvhXIH/uUSZfxO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EgvA0S8CI+zkuRbup95nxoaz/e11mdEyBu8uTq8n5abyObpxwOYPvxtE2lvB/kK0YD+NLwfxPhEGEuI65OZSgfSMNpMjxt1/mIoWisl1X+TayNyX9psXWlU/BwTI9oEAv3+a85VLSxUP/cK4MvANEGzBMIy4pOKSBixdvL5lKUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QFn+QMdm; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ef7640e484so81708467b3.3
        for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 09:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733936828; x=1734541628; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X3l57LF6haxOIk0KhrggMBSdV+cwHI74Pp+J7LHNkHw=;
        b=QFn+QMdmkdU58tUyC0vtkuazi1fuWNdh7MYGhJJjFc2PjQQw5zU9BfcGcbVz78z79T
         bcsJR5Ju0WEgZfJfcwYBCsagG1SvSbcQ09U6Kfgj2sQDYVWhUlfg62gs+sJvr/+Y7QaH
         YreY3+7yqJRmx6NiWBWVGensJf2DyFejnHbUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733936828; x=1734541628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3l57LF6haxOIk0KhrggMBSdV+cwHI74Pp+J7LHNkHw=;
        b=FbqCLyBavvZXN4aG2/g0BD4mVeQ+oqsXzA99d8Xlk5z8VxPHUeg6ZCiE/JDfzHHzWU
         f4woPLg6o2jmITmzyInjEgY5PNvbbH/PZNCaWD1yEmWQyvgiIGH0hiaL4eo6vQc7JmE4
         Bf7oGITywOO9krAnNfPnJd0NebgUsmUrCNif5SxkR7mIQy4Q4xD6tcPAWVbQjJMMKec0
         7XOAZl2KdWP7gcFiEkpV3ivkCoM48kwnYc6e/gEOKSj0HUmOYOHXhL5KsG8JvHq2HGAX
         u296ByKa4ayOszELe4Rp5WMhZm+CGHEf2lmQ5YoE3avvNU6w67m5Fz0yV9Bjl4J85HXL
         tOYA==
X-Forwarded-Encrypted: i=1; AJvYcCXJwQTdQ6DWWGlqTQtL1VhatliHikf1Pn47OU8wEf5/x579J06kaSijTG7HZONU1pwcnO6JR4U/Rw6z@vger.kernel.org
X-Gm-Message-State: AOJu0YwpTo4+x67MvePWzH6s8nJuK+rzRcUK5h9kbWtPqWNHkW+8mgVQ
	FKubBgTFOZuySlGabS4Dy1gEqT90mOG6BKW2KqA8/Qe/Ku5i3FZksX6BRH+24r5fh4CMy+kXJJZ
	oiKXNQ2eTyCL8a8vs+e9jnIR4jC3BvE1wS79Q
X-Gm-Gg: ASbGnctAPjw8ao6hyiZMwI3dTPYvIDNzfeCsKxnMYSIgs0g/BN4GXisNrse+ToylMl5
	NEneZKPRum5/6fFcppFuxzDh2oGkOI0ObQbU=
X-Google-Smtp-Source: AGHT+IEYucmzWewxtlcqbgw928nQA2tMlGzfauZRBUdLzPkZbzqAoaMwSJzZ+0eM+DC3BQjUpBzs0AF8MzuZOop9ItU=
X-Received: by 2002:a05:690c:7241:b0:6ef:4a57:fc7c with SMTP id
 00721157ae682-6f19e4fca49mr3402977b3.16.1733936828137; Wed, 11 Dec 2024
 09:07:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204075416.478431-1-kalesh-anakkur.purayil@broadcom.com>
 <20241204075416.478431-5-kalesh-anakkur.purayil@broadcom.com>
 <20241205090716.GU1245331@unreal> <CAH-L+nN0C=0ZoJmAgBTbjCUcwoQO00WoUc3d3BKn_tGPdk5UbA@mail.gmail.com>
 <20241205113841.GY1245331@unreal> <CA+sbYW21nc0JPs-N0rmR-DgUvX0pydCY_bZXUC57aA0rXUst1A@mail.gmail.com>
 <20241210114841.GE1245331@unreal> <CA+sbYW0n5CPupxByysd7Dc9=QLQm33ivC1YH5T2UbvG6MBVymg@mail.gmail.com>
 <20241211155610.GL1888283@ziepe.ca>
In-Reply-To: <20241211155610.GL1888283@ziepe.ca>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Wed, 11 Dec 2024 22:36:55 +0530
Message-ID: <CA+sbYW2kuQjbUKtKrWkcSTTM3NZL9miBjf=OCRP+LCxFEZsH4Q@mail.gmail.com>
Subject: Re: [PATCH for-rc 4/5] RDMA/bnxt_re: Fix error recovery sequence
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, 
	Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, Kashyap Desai <kashyap.desai@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ba2ca5062901a08b"

--000000000000ba2ca5062901a08b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 9:26=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Wed, Dec 11, 2024 at 11:33:38AM +0530, Selvin Xavier wrote:
>
> > ib_unregister will trigger the destroy_qp (at least QP1) and
> > destroy_cqs. Those verbs will be trying to issue the FW command and
> > we are trying to prevent sending it to FW here.  We need a check
> > here in the common path to avoid sending any commands and i dont see
> > a way to handle this otherwise. Current check has a bug where the
> > return code check was not correct and we ended up sending some of
> > the commands that eventually timeout.
> >
> > Just to add, We have similar implementation in our L2 driver also,
> > which we were trying to replicate using
> > bnxt_re data structures.
>
> Doesn't that suggest this is layered wrong? Shouldn't these tests be
> inside the shared command submission code?
There are two separate communication channel for this adapter. One owned by
L2 driver and another owned by RoCE driver. The RoCE driver checks are
for the second communication channel. L2 doesn't use this channel.
>
> Jason

--000000000000ba2ca5062901a08b
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMMIhml44yDI
AAk7EPVDR1UDX50xG5Ye018DTPM9EujwMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MTIxMTE3MDcwOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB/k4IU/uc9lLr4x5qRwawu4GKEgInK
ij48w1B3wV1usbMY64qLChXjzpbzBDSjKCHlW/qdC2Aw2/rCqd7snpojIL7+cZ1wYLoxOZAxgd2y
M/LUzACh8Ozl3XWc/AjZbUK/EBt7IkhB4Sq9qnUaxpfiYxVkKjWkeUR6bBKYDYZFN8ORlmUHnwH1
RJVuobDXAjEYxupfv4fCXBMcvKnVa1VJP5ziLmlOnJcXuxcRyYd7BsL0iazh6h1C7OOgO54qf8tP
9Mm6wJEWbSgcrAvW6Z/wOuxBntT66DCOc6O+dPCfQ3rNW7jqAUogAwgKRihILYX7IKtlGRUA/rkR
MDMg+ANC
--000000000000ba2ca5062901a08b--

