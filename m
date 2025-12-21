Return-Path: <linux-rdma+bounces-15135-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 350C3CD4290
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 16:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2151330133AC
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 15:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D668E2FFDD8;
	Sun, 21 Dec 2025 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cM9exKrj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895782FE56F
	for <linux-rdma@vger.kernel.org>; Sun, 21 Dec 2025 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766332636; cv=none; b=mAspuanwx3m+4LHn2aX5ERkDNqTCAZSpHXLkIX9QTMbNmvO1zK2f0QQpjfNy0i2XA9mElbh0OO9zXyWNFpZAXqcGawRglQIV6/wpq+/CGZUAIirN9nm+jjzSG2wLBJJhhs/cRe9dJktn3DW4j39J59QfJ2OGbyaoOQrNlUhORTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766332636; c=relaxed/simple;
	bh=5cxNSAWtrLesy6twR7ZS7EoMgFLx0e6cU6Joz08j2ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EF7bp/Cm77gG64MMCAdw/AUiIY58GCIJrzBW172+DpA3OH9crhrobfP2pJQ4PvtdKLKx6kkG31SbNIArs1+3n7p8b78UDdREZmilNrd2jzcic430ZTTLaXoPnNI8jnPSeU5dsNlJWViKydD3A4Wemde8/rnATYk08aZWPdBzecM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cM9exKrj; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-88a2ad13c24so31734826d6.1
        for <linux-rdma@vger.kernel.org>; Sun, 21 Dec 2025 07:57:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766332633; x=1766937433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R94hhqTxDDFgwMirmtP3qCuPfMwbFRm5YLjPuIK/q04=;
        b=lPRED7xDp2HYgIa5006GIBpAlERnMEmTo8QbiMSvLoxhjgZWpPKSRJBfFHnXA4WiMK
         8MHKvS+GykdeBSXJ2LRfhu69TrBP/zOuuBt8jUN0ZyGR7mJ+dAjCU+BWT59kAA6KKFlf
         xW6laD4K/MRhnemKbkoNTIWApQ9pEMQPBJuqr8IAw1b3LJF6S+8Xi0FmFlCdI9vfsKxX
         Elz3KTa2qKdLAFH6cDqWLo20uvZFl/vw5FvyIyK0jRDUbd7b5WsafR0wsa+wMO9Oc5iG
         icKcTjF2Een/Y57aal7V4nTOIEiiaEhbQ3lL8YNnS9w2gk14ESiIopw5dzntV+UaKZ/A
         PK1g==
X-Forwarded-Encrypted: i=1; AJvYcCWG7RtVFkwPiu+GiFqPNvkYFisM+MxhM6WW8th9yF/xk8kr68lDi95VaDTTsC83FNZAgDs+S4+i6zo1@vger.kernel.org
X-Gm-Message-State: AOJu0YzdKEmMiU8G3j+PsVnfZu0xzJLpPTcdEasgmNiq+t9su4JI/LRT
	dUUq2HeEnAFE0u4zW9rAE9LRmm64hCT2jfB0q8H3J7laZ8yOqtBbhZ4wnscomb3oREVZGpoocR2
	Ed4XpKp8Kx6R3cpixRJDsxKIxuDzVShYU/hXZeq6KcCxdE7i99WcU1NNx2GKAHHzKhRrzgc3AAd
	oETXVkaBx5XiiTC0vfT1VV8zFZldBJtD2ChdoY/1lcuUARMwtf+QvfpI7P9XZolfo0r+HrulzCR
	SqjYyKQIWmcziZ7hRY0vvfulJbBiA==
X-Gm-Gg: AY/fxX6BkregYr55W/gLXVvLtf6mMMVik+w5caunJmtf0aqdMAUuiIFuxj9hCoa5lbr
	rSqC0Lzpaym7LNTBXGY0g/hLFquv2aBav9JLISUxks/1pvv/nkjc3yGVamRmEs2TpM3UHQ8jpV3
	HXiSXDQmKQqmv4JfKk8UuH1WRwZX6Hfebl6Ivf84Hbbsl5dYsDlua39kaZwGPXnXmHFp/7g8Xv/
	bLKr5kqbiC/R1wx/Wce2GPqDORWD3x0I7MgJS1Bmt/s1fh76rLo/RegIYODjo16xMntgn98OExa
	ZV5kmeZ5un5RHKmnzJn+ankBswbKeUh4vyN21/xm21jUBasJp3aWy/IDjWu0R7jJffqfU1OkUS/
	RUa58lXrhjW7Vs/LY08Izba/7jWSybvvUn0E6d6B0u6PNbVs9TeFGKaMTiOu61NR4qmI3oAohxN
	1vZWE9Y62cqC5r3y1KWRFY0TAY8CkI/nt3gtdAijlSxGfyitTcqwQDez2meA==
X-Google-Smtp-Source: AGHT+IHEe774K8S3IUh4vF6pKT9M/k1E+Lhnqw9IlLeegZg5DOy3kjMUIKzDlbiet5YDDeXIi85Aed+20j0j
X-Received: by 2002:a05:6214:4801:b0:882:7571:c012 with SMTP id 6a1803df08f44-88d86963c7dmr162743106d6.55.1766332633042;
        Sun, 21 Dec 2025 07:57:13 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88fca762f09sm2642756d6.12.2025.12.21.07.57.12
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Dec 2025 07:57:13 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f29ae883bso46868935ad.3
        for <linux-rdma@vger.kernel.org>; Sun, 21 Dec 2025 07:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1766332632; x=1766937432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R94hhqTxDDFgwMirmtP3qCuPfMwbFRm5YLjPuIK/q04=;
        b=cM9exKrj7DA5/LtjikVWr4UFO2AZUgsJhmjJApzgPwhOCohO9Bir5igKLbJyiLTlZ8
         eGv9juJBlltPsKUwyu+E9PkR+mt+VIPAFwn6lY73/j5SohErW42h/UudIHy4pQM2aVlZ
         BWARzxVQzNCwcIvjHd4qgbXWu70VsPaZ49kLw=
X-Forwarded-Encrypted: i=1; AJvYcCUbSY4sxKEC+kaYXcFivka+RFvqB6jzSEXk3TctjNwsqJZQhX/Hlymg5BnLpiLsxPCCXJf2auBap1LE@vger.kernel.org
X-Received: by 2002:a17:903:40cb:b0:2a0:f0e5:3f5c with SMTP id d9443c01a7336-2a2f283109dmr78988285ad.34.1766332631779;
        Sun, 21 Dec 2025 07:57:11 -0800 (PST)
X-Received: by 2002:a17:903:40cb:b0:2a0:f0e5:3f5c with SMTP id
 d9443c01a7336-2a2f283109dmr78988205ad.34.1766332631414; Sun, 21 Dec 2025
 07:57:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219093308.2415620-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20251219093308.2415620-1-alok.a.tiwari@oracle.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Sun, 21 Dec 2025 21:26:58 +0530
X-Gm-Features: AQt7F2o0FDjraPeDqPxweC6K-ASuNx-T4W7SPSfxjfiY4TbWBmaOMNJg5kgHw2E
Message-ID: <CAH-L+nOfgC6Ns1vyM1H3Qx02QTw08VX1=HLuKx63_5XcKedrvA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/bnxt_re: Fix IB_SEND_IP_CSUM handling in post_send
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com, 
	leon@kernel.org, jgg@ziepe.ca, selvin.xavier@broadcom.com, 
	linux-rdma@vger.kernel.org, alok.a.tiwarilinux@gmail.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001795ac0646785d5a"

--0000000000001795ac0646785d5a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 3:03=E2=80=AFPM Alok Tiwari <alok.a.tiwari@oracle.c=
om> wrote:
>
> The bnxt_re SEND path checks wr->send_flags to enable features such as
> IP checksum offload. However, send_flags is a bitmask and may contain
> multiple flags (e.g. IB_SEND_SIGNALED | IB_SEND_IP_CSUM), while the
> existing code uses a switch() statement that only matches when
> send_flags is exactly IB_SEND_IP_CSUM.
>
> As a result, checksum offload is not enabled when additional SEND
> flags are present.
>
> Replace the switch() with a bitmask test:
>
>     if (wr->send_flags & IB_SEND_IP_CSUM)
>
> This ensures IP checksum offload is enabled correctly when multiple
> SEND flags are used.
>
> Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniban=
d/hw/bnxt_re/ib_verbs.c
> index f19b55c13d58..ff91511bd338 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -2919,14 +2919,9 @@ int bnxt_re_post_send(struct ib_qp *ib_qp, const s=
truct ib_send_wr *wr,
>                                 wqe.rawqp1.lflags |=3D
>                                         SQ_SEND_RAWETH_QP1_LFLAGS_ROCE_CR=
C;
>                         }
> -                       switch (wr->send_flags) {
> -                       case IB_SEND_IP_CSUM:
> +                       if (wr->send_flags & IB_SEND_IP_CSUM)
>                                 wqe.rawqp1.lflags |=3D
>                                         SQ_SEND_RAWETH_QP1_LFLAGS_IP_CHKS=
UM;
> -                               break;
> -                       default:
> -                               break;
> -                       }
>                         fallthrough;
>                 case IB_WR_SEND_WITH_INV:
>                         rc =3D bnxt_re_build_send_wqe(qp, wr, &wqe);
> --
> 2.50.1
>
Thank you Alok for the patch and the changes look good to me.

Just curious to know, how did you identify this issue? Is that through
a code review or did any test cases fail for you?

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

--=20
Regards,
Kalesh AP

--0000000000001795ac0646785d5a
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
dDANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgVJnALfPAGJwCJaD3j6LcgS7ztVY9
HU313sFgA/ioPrUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUx
MjIxMTU1NzEyWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAmiwH9Psub6qkSkJXcp6r7L0nfKLfwISnl8mmRWNtpzomBbPb6P+fi+TibLqPr+U+
JHTzGOfa9AKcCOA1G9br4E2JcrLl5jhHmxLsFB9XtjdIl3ik1p022cU1NiW+adM6ykGowUPWSGt+
MDf5VnXHAzUEvYspK4LOh0o+6CxISdD34wo8Z/ZbENW+V2frwdZ/GtQA+IMg5F/CHX7FU+GjFkgS
Th6S4oLKR6fn19/rSqG+TqeUPVuDvG0l8qPe2gvqtXugEAQG8h7hjEiAnj1vR6Vq/iSaSMlGcX55
Xp6N2qs0aL7xEGMEA1UYEQJlVuqWCqphDLNk7WPCrxAXcWYBaA==
--0000000000001795ac0646785d5a--

