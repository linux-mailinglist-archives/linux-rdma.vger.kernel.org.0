Return-Path: <linux-rdma+bounces-15131-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2401CD3F41
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 12:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73074300BB9A
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 11:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFFE28C2A1;
	Sun, 21 Dec 2025 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iIEMUrvZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4A9225785
	for <linux-rdma@vger.kernel.org>; Sun, 21 Dec 2025 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766315933; cv=none; b=bNtnoVT4so/6Br9cSODsjOmkwJY+0jQHd8cHICUmyGaBMLjG+3mvR79LYtoArC8ASBzcsuavGwUv2dr8hzDBC5/frP+0OBKQvnmXn6f05ZCdBX6aVGlLaDPRHic+gvIuf/SuPmz+JZgFNsVuRGJy/oHf9w7BBMxyk6ocazlwRvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766315933; c=relaxed/simple;
	bh=5aLyDKIpdPESIlfLPr516eZ+CNBjHRaQjDaOOn5oALg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJp6ONsj7F8F9ONwqAdFdFpyoz8cWCoe+gGeVlh/gak125LgXECsmmlOwWqBSxZFxhyrC1OXOavV+WmbjnI2OOyUgJ6UEKoTGGgt1lZu1HOmoqCxJIxpGGnPCfbNq8Z7SiBTAT3hhMVMqcCBhbymIaa9nNK0QQh9Jh8cMNeNMME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iIEMUrvZ; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-3e7f68df436so2185335fac.1
        for <linux-rdma@vger.kernel.org>; Sun, 21 Dec 2025 03:18:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766315928; x=1766920728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LOfKdmN2r7U+ucDmQ5gMUWqx3pQUoOK5r3lLmIzt0o=;
        b=vQ76ulOv5kN120A8m2f5GOadXdIYSgM4j8DWCfTkOZ6mw22leI8oTDoYQugobpcNbc
         OHWuaEVehAgyCJaGFaenxDr2aWrJ0n+0b624YTL5xb2KyShMk+m8jVQT9ECE1sh+/qkE
         JdWKafTUnnNJdkN9TST6MyzE8Ia3efPsVlrfdGjKXhBxCGZqjHFbCVwNYISa0hMueSVI
         DST7NDSdodS+YhPCajcy8F2LOGVfw8b2Q1wlQ2KqA7ok5eUoV85KmNLqwtltNYx14108
         rNVVxns54RjBC0daUQCUdosENTlLqY59r0h3IeGreh3VYP7kcWrCxI/xsrW/fVViQkfb
         KcIw==
X-Forwarded-Encrypted: i=1; AJvYcCUCZLceQ0KYcbzylFEjOvRZJrH4APEQbghM0m9r/nxDyiGbm15HN4GAgeF9+uKJbZ9DAvdf7IzcC9Qm@vger.kernel.org
X-Gm-Message-State: AOJu0YxLk0/cn+Oc1lzPtqV1j7QgYWODl09X9MhVS+ilURJZEM24YV1s
	h7ixAV2+tt2fnV0GYZvwm67QN+h2mhC2YU29LPumRJNWLJaBHvdqe8ONDD7u4tqJT8Cw7Ovvn9f
	cV9FHF2xSCaAU/ODWyK+7TnciRP2ckV+aQ9xKIUUeuDeRyQmDGZCEm0F25EOdForuwpyyM8G5Vu
	9yrWh5yuhmIwM17YYANgwLsfzl6Z+xLod/T7Etmhy5mkMkcdgOtuRqqz3l7dw0G/yke51NJBnS/
	vjLT97aRn4/zWVVmumpYRNcUnhY1Q==
X-Gm-Gg: AY/fxX5fToA7fFdr/NsM56xghmGLeOByv8PMkB7rYKYz8If/6LgQwnicgsP7c6MD8Lm
	06g+qxcLr3DtqJH24znPCyPW6DmdIBsBEIQ0W6MfYUVs0XImNW9iyyRokKwrYctjrF0vSVXTt7d
	I55VbMQh029GtIqXSLB+2s8jjGLqY5IIwWJwQBwEx9dm9AaykmHAo7naf1tDziXaUcUxZLz1smI
	KhSU5cr43ZPVJBYN4gdJUkI0sNtfiQKnMf4c8XiMA+BAW97cAYy+CK7/RacUPX+KQtQHsroQcj5
	DbHyOdUA2Nve6WTjQJj8Drb2YPN0WODUjzrUWrdWgk+zgAiTB5UL2HIJMFfrBNvd6GLG8LDgQHA
	DYJG9S9ongj6bXblBEToX12H5mj3fnIwlcZp6xudZhoTRxkqUoYW59Jf+g4TMKKbU7UgMu2Zf/t
	ZeUpawoV2T8QN9vBJtAh8fNYSlaHoscC1v1V9FtE85LYYFuoykbOPcqyxHvQ==
X-Google-Smtp-Source: AGHT+IH4SFHYDtC88mGEsLnLQGXbsPMuvBsixbc4CLy6fo0qp8BxO66rvLHEcubLBADN+VWFVgo0Jnqx0ZtU
X-Received: by 2002:a05:6871:cd:b0:3e7:dea2:9607 with SMTP id 586e51a60fabf-3fda523a919mr4703248fac.11.1766315927830;
        Sun, 21 Dec 2025 03:18:47 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3fdaa8da691sm788212fac.2.2025.12.21.03.18.47
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Dec 2025 03:18:47 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29f25e494c2so31843895ad.0
        for <linux-rdma@vger.kernel.org>; Sun, 21 Dec 2025 03:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1766315926; x=1766920726; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/LOfKdmN2r7U+ucDmQ5gMUWqx3pQUoOK5r3lLmIzt0o=;
        b=iIEMUrvZs9RyEFuVVc8U9QQOMfNbmtZ/D4Fl4VpfVfsvUKXXSRX4fTsb0vCPyA7HQy
         jc7Erq+xO230lz/GsAYOQT/EGCfz0WXOsHv0kMI0o+INm25Nd2MxUfMl01zJFixt+eOr
         PWkqrORZMId5ZrEfNmQQB/W8pGmkYDtjT/6j8=
X-Forwarded-Encrypted: i=1; AJvYcCUpTIDW98fRN+w7kgePoNe6AxaZRzaRU74u+c2ho8lbDAeIu3lcUlZeYzUhMj4cHZSyyiRe16rR24wS@vger.kernel.org
X-Received: by 2002:a17:902:dad0:b0:269:7840:de24 with SMTP id d9443c01a7336-2a2cab3259dmr95603365ad.21.1766315925734;
        Sun, 21 Dec 2025 03:18:45 -0800 (PST)
X-Received: by 2002:a17:902:dad0:b0:269:7840:de24 with SMTP id
 d9443c01a7336-2a2cab3259dmr95603285ad.21.1766315925318; Sun, 21 Dec 2025
 03:18:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208072110.28874-1-dinghui@sangfor.com.cn>
 <022b32b6-6ed5-465d-af01-a52deea16d62@sangfor.com.cn> <20251221080059.GB13030@unreal>
In-Reply-To: <20251221080059.GB13030@unreal>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Sun, 21 Dec 2025 16:48:32 +0530
X-Gm-Features: AQt7F2rXX_C6Cpnsng0H8Uq5LtNdIPdsNJGHFcnzwDabxxVoKan6Oukv_FErfZE
Message-ID: <CAH-L+nN=qLmtHSJ87TXWJHWTts5NrtO=TapGm1wysYfWw50zvA@mail.gmail.com>
Subject: Re: [RFC PATCH] RDMA/bnxt_re: Fix OOB write in bnxt_re_copy_err_stats()
To: Leon Romanovsky <leon@kernel.org>
Cc: Ding Hui <dinghui@sangfor.com.cn>, selvin.xavier@broadcom.com, 
	saravanan.vajravel@broadcom.com, vasuthevan.maheswaran@broadcom.com, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhengyingying@sangfor.com.cn, jgg@ziepe.ca
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005937ff06467479c9"

--0000000000005937ff06467479c9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ding/Leon,

We will validate the changes on BCM957414A4142CC and confirm.

On Sun, Dec 21, 2025 at 1:31=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Thu, Dec 18, 2025 at 10:16:02AM +0800, Ding Hui wrote:
> > Friendly ping.
>
> I'm waiting for some sort of response from Broadcom people.
>
> Thanks
>
> >
> > On 2025/12/8 15:21, Ding Hui wrote:
> > > Recently we encountered an OOB write issue on BCM957414A4142CC with o=
utbox
> > > NetXtreme-E-235.1.160.0 driver from broadcom. After a litte research,
> > > we found the inbox driver from upstream maybe have the same issue.
> > >
> > > The commit ef56081d1864 ("RDMA/bnxt_re: RoCE related hardware counter=
s
> > > update") introduced 3 counters, and appended after BNXT_RE_OUT_OF_SEQ=
_ERR.
> > >
> > > However, BNXT_RE_OUT_OF_SEQ_ERR serves as a boundary marker for alloc=
ating
> > > hw stats with different num_counters for chip_gen_p5_p7 hardware.
> > >
> > > For BNXT_RE_NUM_STD_COUNTERS allocated hw_stats, leading to an
> > > out-of-bounds write in bnxt_re_copy_err_stats().
> > >
> > > It seems like that the BNXT_RE_REQ_CQE_ERROR, BNXT_RE_RESP_CQE_ERROR,
> > > and BNXT_RE_RESP_REMOTE_ACCESS_ERRS can be updated for generic hardwa=
re,
> > > not only for p5/p7 hardware.
> > >
> > > Fix this by moving them before BNXT_RE_OUT_OF_SEQ_ERR so they become
> > > part of the generic counter.
> > >
> > > Compile tested only.
> > >
> > > Fixes: ef56081d1864 ("RDMA/bnxt_re: RoCE related hardware counters up=
date")
> > > Reported-by: Yingying Zheng <zhengyingying@sangfor.com.cn>
> > > Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> > > ---
> > >   drivers/infiniband/hw/bnxt_re/hw_counters.h | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.h b/drivers/in=
finiband/hw/bnxt_re/hw_counters.h
> > > index 09d371d442aa..cebec033f4a0 100644
> > > --- a/drivers/infiniband/hw/bnxt_re/hw_counters.h
> > > +++ b/drivers/infiniband/hw/bnxt_re/hw_counters.h
> > > @@ -89,6 +89,9 @@ enum bnxt_re_hw_stats {
> > >     BNXT_RE_RES_SRQ_LOAD_ERR,
> > >     BNXT_RE_RES_TX_PCI_ERR,
> > >     BNXT_RE_RES_RX_PCI_ERR,
> > > +   BNXT_RE_REQ_CQE_ERROR,
> > > +   BNXT_RE_RESP_CQE_ERROR,
> > > +   BNXT_RE_RESP_REMOTE_ACCESS_ERRS,
> > >     BNXT_RE_OUT_OF_SEQ_ERR,
> > >     BNXT_RE_TX_ATOMIC_REQ,
> > >     BNXT_RE_TX_READ_REQ,
> > > @@ -110,9 +113,6 @@ enum bnxt_re_hw_stats {
> > >     BNXT_RE_TX_CNP,
> > >     BNXT_RE_RX_CNP,
> > >     BNXT_RE_RX_ECN,
> > > -   BNXT_RE_REQ_CQE_ERROR,
> > > -   BNXT_RE_RESP_CQE_ERROR,
> > > -   BNXT_RE_RESP_REMOTE_ACCESS_ERRS,
> > >     BNXT_RE_NUM_EXT_COUNTERS
> > >   };
> >
> > --
> > Thanks,
> > - Ding Hui
> >
> >



--=20
Regards,
Kalesh AP

--0000000000005937ff06467479c9
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
dDANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg1LF9sLxt2jIZl5wDpr4v8tLo8Uif
TJAlD6uMBO/tgFswGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUx
MjIxMTExODQ2WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEApyqh8Lq6FpMT293iBKNesfw7k3MITmGBkWULhmjXlsdYcX2rkAfN334cHU0hSqxF
fzeLfKn3AsJ6PwOCnC0YeqU+eTBSu+5Hvkcm7zXkSfX5zy3l8Y/Gobhe7xUj5oCOmr1/uMzqoPRS
ieNu1aRkeG0Qgi6cZ+TGMhEZOWDABjE1v9HFvUzkdZmdIrTuCzvtMcCxUMwyY7yfwe+f+fGb1/EO
ThUR2tMx/194ZUuIUEVIzDjJ6fxLMQRI7BGoi5G66OGKptmS7adL03wiaumWW+PmDws6cfd54dzo
Duyf29lMpYWa1nPqrM0fDfOHC1VKN50+frppZjpK0AVNlvDNKQ==
--0000000000005937ff06467479c9--

