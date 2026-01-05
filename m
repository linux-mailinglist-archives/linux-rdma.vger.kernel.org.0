Return-Path: <linux-rdma+bounces-15296-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A26CACF1BC5
	for <lists+linux-rdma@lfdr.de>; Mon, 05 Jan 2026 04:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99FCA300A355
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jan 2026 03:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE3231AA8B;
	Mon,  5 Jan 2026 03:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NvJfjBV6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A502D73B8
	for <linux-rdma@vger.kernel.org>; Mon,  5 Jan 2026 03:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767584090; cv=none; b=NgKGTUialZcoAMsy+883n3YKaQpnLpRQF6PpNYvCCKz5Sxxk+d1nEUfmSmBi1JVGnE5v9YtsAJw0E8BZ0NIk6MddCuwB3KsbsFvC7I1DxEJpBr061AE5ke2yrKHhAxqle0vkEXU64yXh7H2BDsPc5A8iLZvNgNzGG1tQWUIxiZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767584090; c=relaxed/simple;
	bh=Rtp1ypb3vBcKlItOq8QVtPmsxwEXInpuiFV5kxHCDK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XDxzMwPGTiesWbhzuciVD/JtA3Tq804RxX7y/Ayv02lMfkwrvGrhrfa1UPU2DhO0gjFFlsoNLDaOnJeUKaHNabOzFv8m+MntO541riXcHcQ/p8xpZ+dmU/FAW+sZJTaVB3QokVgMtqIFS8GAVrsjEhAl6O0mGZ8zQNz6VxJGS6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NvJfjBV6; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-64471fcdef0so10526640d50.1
        for <linux-rdma@vger.kernel.org>; Sun, 04 Jan 2026 19:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767584088; x=1768188888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rtp1ypb3vBcKlItOq8QVtPmsxwEXInpuiFV5kxHCDK4=;
        b=ue+Qfh9dN0aHDfe0irqBMKF5FostN041cwqHUfIdl1jt3/89tugYi/6In0gDCX3Ucs
         YJ7Wv/93FnTuYB5LeIXUong9+RZ8hSDeqGb4RolVGBYswVArYQuJMrZIS47YpjbGuy7X
         JCXVNXcbP/g5/4GdLrggCd9AnNYH00r8sanlM0PV29nI0LaMuDkJvl4qQ9sxMxo281TB
         fpBuxvPaCBGT8G7qFy3e2EZhs9ewkEpny9fmxJLZaFvbIQSW8OSmaZgs+KMb+J0IzznV
         78j9Wn1vQaQ8kTpSxb1SlvQykupLPlooDipqTMIF5SeQ+PqVvTe/fzFRXIWgflXx2uTi
         Pi9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQu9WKEdx4mSo197V8Fmk/fJW9mLFL6KMc+XtF+3PWcTsjbzFBw/NztOS7RHSo6rTF69Gj1skYr4vS@vger.kernel.org
X-Gm-Message-State: AOJu0YxBhDpkx4hXvewBs6h/ly6s3ZjFxgvTIkrouTt3S4RsF5G8je3i
	jrDM7ENrt2OVUOOIjHv1pnA/SoDAe8N11K8hV6gdGFdk8hAigzE2z4MDvoI6Uwtj90FHLL8UNaG
	Rh/mM7gjcXaManUBZbq75uh8+X0GHYYwZbL0Tij32a8hdbl5neOa6chjWiArHRPYtyZp8wN0vnn
	7hx2mqpkjBD8ujNe6eKZjAKXLGbR6zsRUdMVuW9x6MEol9HODC+bB9CxbO4ECUWeuSgsaKd7DCb
	9B+ccbZ9EcPRfEkaQ8qqWGdn+2X9A==
X-Gm-Gg: AY/fxX5GM1a66KqgwcStxPEyhf8xzmUmcyJua7w6HZkgQbQKwlayv3sXIJIzsvOcYVF
	ZZpUKjgR7cXnL/0LodDMDstbMZLl6mXzyNEgzD0Bxgvwy5gX3mcMKFgfPjQG6ciMbaH5A+ZPU+Q
	pg5/kbbL4isg6wl5txss1ywkhzZ/8oWhzJhAsH4DVJauKXgHPhkNuYzPNgJkfNyaZ7gzcTSDmRp
	yxS9sjyQixbwa1MkH42D7wJUYqvYLQtSFcRqSM4t5T0j286AfdyAclqWQwY6rJLOtoWpFbOEORf
	jJsGBvLJmtP6t/XnnNHyt843wMPf3O4yJtzNYFdy9kuxvdDK9KIdfJ4XFtkGKVrdyb9kXg3R/M+
	3LAitZW/lMO7fNyxt2q+gdvUtKoGXYdHPHBJTjHLVpu4ibfnE1QcGZLALZ+sCm/cFO1N1ckLyki
	XkPzRmRjTNGkLZyaBi9lyIgbOdxgNKZz/2QKs7WzdcWxYNVSlp1QjU/eE9+Sy4
X-Google-Smtp-Source: AGHT+IGaNEQfEtPrxDYO1+uLZPtO5bbYmmD8/nCRqOMnGP1SHVyUYc3nuniOwQXmOmv+QuwjciVUablcgoQv
X-Received: by 2002:a05:690c:6705:b0:78d:7307:76a4 with SMTP id 00721157ae682-78fb3f045a4mr916824907b3.11.1767584087556;
        Sun, 04 Jan 2026 19:34:47 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-646832ed4casm2213841d50.3.2026.01.04.19.34.46
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Jan 2026 19:34:47 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0d43fcb2fso474698795ad.3
        for <linux-rdma@vger.kernel.org>; Sun, 04 Jan 2026 19:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767584086; x=1768188886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rtp1ypb3vBcKlItOq8QVtPmsxwEXInpuiFV5kxHCDK4=;
        b=NvJfjBV6QsQl92QU8j9MK0BrwwIRdkoP3dMIPCQWl+C+j0CzNKQlMAkMB4Gr3CWckL
         YnGNq13FmyxIVignTQA3gajoYEH2BZwHoybpQItWH25v+rchc4JkLehs/1oJtO3nVuFx
         6cjv7ZN3OktbZZelRSYSlSFa1sv6WSZCPVtU4=
X-Forwarded-Encrypted: i=1; AJvYcCV3mD+XAcQ1ETDjqh2t2FV/vgLCgSlreRh3VrWgDbb8Pc9aJHp51FvkaeceTabmqXtdeGWtJNKVjT/e@vger.kernel.org
X-Received: by 2002:a17:902:f544:b0:2a3:bf5f:926c with SMTP id d9443c01a7336-2a3bf5f92e1mr53084775ad.39.1767584085846;
        Sun, 04 Jan 2026 19:34:45 -0800 (PST)
X-Received: by 2002:a17:902:f544:b0:2a3:bf5f:926c with SMTP id
 d9443c01a7336-2a3bf5f92e1mr53084645ad.39.1767584085535; Sun, 04 Jan 2026
 19:34:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104-ib-core-misc-v1-0-00367f77f3a8@nvidia.com> <20260104-ib-core-misc-v1-5-00367f77f3a8@nvidia.com>
In-Reply-To: <20260104-ib-core-misc-v1-5-00367f77f3a8@nvidia.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 5 Jan 2026 09:04:33 +0530
X-Gm-Features: AQt7F2o1nlms_9fezqJLEzec31Kbc7tBw68s9rQiFCh_a58_ox_ZJ6uLiJ53Zrg
Message-ID: <CAH-L+nP0HdJi0v2prq7k3+K-xq7F4FA1EwJ89YU1awiK831Lug@mail.gmail.com>
Subject: Re: [PATCH rdma-next 5/6] RDMA/qedr: Remove unused defines
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, 
	Chiara Meiohas <cmeiohas@nvidia.com>, Michal Kalderon <mkalderon@marvell.com>, 
	Selvin Xavier <selvin.xavier@broadcom.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000915df506479bbd24"

--000000000000915df506479bbd24
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 7:22=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> Perform basic cleanup by removing unused defines from qedr.h.
>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>


--=20
Regards,
Kalesh AP

--000000000000915df506479bbd24
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGtzCCBJ+g
AwIBAgIMEvVs5DNhf00RSyR0MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNDI1N1oXDTI3MDYyMTEzNDI1N1owgfUxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEYMBYGA1UEBBMPQW5ha2t1ciBQdXJheWlsMQ8wDQYDVQQqEwZLYWxlc2gxFjAUBgNVBAoT
DUJST0FEQ09NIElOQy4xLDAqBgNVBAMMI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20u
Y29tMTIwMAYJKoZIhvcNAQkBFiNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29tLmNvbTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOG5Nf+oQkB79NOTXl/T/Ixz4F6jXeF0+Qnn
3JsEcyfkKD4bFwFz3ruqhN2XmFFaK0T8gjJ3ZX5J7miihNKl0Jxo5asbWsM4wCQLdq3/+QwN/xAm
+ZAt/5BgDoPqdN61YPyPs8KNAQ8zHt8iZA0InZgmNkDcHhnOJ38cszc1S0eSlOqFa4W9TiQXDRYT
NFREznPoL3aCNNbDPWAkAc+0/X1XdV1kt4D9jrei4RoDevg15euOaij9X7stUsj+IMgzCt2Fyp7+
CeElPmNQ0YOba2ws52no4x/sT5R2k3DTPisRieErWuQNhePfW2fZFFXYv7N2LMgfMi9hiLi2Q3eO
1jMCAwEAAaOCAecwggHjMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcB
AQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQv
Z3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2ln
bi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAy
ASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNv
bS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29t
L2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwLgYDVR0RBCcwJYEja2FsZXNoLWFuYWtrdXIucHVyYXlp
bEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAUACk2nlx6ug+v
LVAt26AjhRiwoJIwHQYDVR0OBBYEFJ/R8BNY0JEVQpirvzzFQFgflqtJMA0GCSqGSIb3DQEBCwUA
A4ICAQCLsxTSA9ERT90FGuX/UM2ZQboBpTPs7DwZPq12XIrkD58GkHWgWAYS2xL1yyvD7pEtN28N
8d4+o6IcPz7yPrfWUCCpAitaeSbu0QiZzIAZlFWNUaOXCgZmHam8Oc+Lp/+XJFrRLhNkzczcw3zT
cyViuRF/upsrQ3KY/kqimiQjR9BduvKiX/w/tMWDib1UhbVhXxuhuWMr8j8sja2/QR9fk670ViD9
amx7b5x595AulQfiDhcN0qxG4fr7L22Y/RYX8fCoBAGo0SF7IpxSukVsp6z5uZp5ggdNr2Cq88qk
if7GG/Oy1beosYD9I5S5dIRcP25oNbcJkbCb/GuvWegzGfxCCBuirb09mTSZRxaBmb1P6dANmPvh
PdqGqxfFrXagvwbO15DN46GarD9KiHa8QHyTtWghL3q+G6ZHlZUWnyS4YMacrx8Ngy0x7HR4dNdT
pqAqOOsOwDmQFBNRYomMdAaOXm6x6MFDnp51sIWVNGWK2u4le2VI6RJMzEqLzMZKL0vTW+HPqMaT
hWv2s5x6cJdLio1vP63rDxJS7vH++zMaY0Jcptrx6eAhzfcq+y/TkHJaZ4dWrtbof1yw3z5EpCvT
YDxV0XFQiCRLNKuZhkVvQ8dtmVhcpiT/mENrWKWOt0DwNEeC/3Fr1ruoyriggbnRmBQt1bC5uxfv
+CEHcDGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1FIENBIDIwMjMCDBL1bOQzYX9NEUsk
dDANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgZP9yaJHweZWCjlFNPAm2pqgF/otP
cnNvPNXOIoCdENMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
MTA1MDMzNDQ2WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAZWT2uKXOqBl+uRo4rcB3Y+x9pAI74yQpOCPSo+1XGJO9pctKi7HxBdgoTc3mCQ8b
sLARShaP+OdmonKE6ZlgTu+0BqhhXDebToV8rnr81I0TlmNKwZWAi+cKNV1c2UUHnhRrSAlJn+ML
TTzVCMg+58Jv+zzGOasqdqtZw5Ihk6qrTCyTSgCaf6O+a9ahm8Qv+JpQI2mHTrWOgE/gqpyagBZM
7LboI5eAw/L+0dV/g9yQCkPjYWho11Nk4meTt6Y6yv9o6O0rTJ34wk5BhztVlzqaYhSII0JbMRWP
qkuh5F+gvovAwKZLuYJKqiPV7eREnN/i90kYfoHw2fJTqj4k1g==
--000000000000915df506479bbd24--

