Return-Path: <linux-rdma+bounces-15134-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C588CD424B
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 16:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B805F3000B55
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 15:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095B62882AA;
	Sun, 21 Dec 2025 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Hcy0TZmF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D2A2101AE
	for <linux-rdma@vger.kernel.org>; Sun, 21 Dec 2025 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766332069; cv=none; b=Xc/EnkJapO0t/jRrMBaQ+Vffu/BbgMsO7e6Q4uCHVdq/0OEbF7zqHERC8NpePyioZ/b+g+KFKoCMsrWoduDxS9ReJAFOOBVfiF2wlMxIPGtfMNvZyMe9l62OCkDSmxXy3PlSPH7gT8UfIZxJvDItRR1E83HvuwZIzbb9xtXdwf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766332069; c=relaxed/simple;
	bh=AULQDI1LWCJF3qIS8X6tjUlsT7X8rJU90L+60MyK5oE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQOFxjaIynFx+BrVmWJibY5mhFziCYGJn2kHF4B/VE85qiJdyTYUdXo53hn4eCLjdIxywsjDJ7BMZPwM9nHeRK7q2OnDX1wMztgE2cMvbLsS+hi7ebPoQTY64xHgk/PkZ2palOmHx2iuY81orG7deIg4IKvbJxffixmIwUe+Ik4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Hcy0TZmF; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-88059c28da1so30634236d6.2
        for <linux-rdma@vger.kernel.org>; Sun, 21 Dec 2025 07:47:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766332065; x=1766936865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AULQDI1LWCJF3qIS8X6tjUlsT7X8rJU90L+60MyK5oE=;
        b=FssE4DYCyyBEOmvcSv7+J1I72l/g+ktuJCT22fRQ1SPuiRGLp9jaX7ngJizqcFM+X9
         6FEjBmrBgkoryekcCc77wSXCItzhBmZ9E70e7lG6A+X2U9W47V/lFwfuNlhNR7wWymru
         Ar45h/Z+3bnbJu/ou2eDZrFpZ+d/OGp4DZknv6M2jVXoy6Jwp5Xsq83XwbrPdqp6YP2j
         wUu6FfZLcf2mN+yW8N04RI/R1QVXb0HPilVdTtruzlulWZjdAw4rliFSN9TSjwZJQ/WX
         s83n+dK1jZC9NX4tbL0Cp6sPXYMaNaJkpA2aupzA2qY5UZ7iX985EQ8klIPrGXvVgljb
         GLuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpQtK93/lFTUOICw0nngUqDR+Io44WEBPY4ZEkZtUSmGEaRkymJzVHc/ewgfym3vHI0IrTpFE3LpUK@vger.kernel.org
X-Gm-Message-State: AOJu0YyTvKTRjTTiC8ev45NNt1TgSveaQIJydQbDqjvT5WcvO9T3rk4z
	cA9PO7WHKJuptcGKZHsZn+oUBQu1IF/iG6Avn0dK4iRIsG9N/ihwchP1o4fnpKig7PakWlpRDYT
	v8HZK2Dg7bdPTUIkpDQ1z4LelUqrwFPCx/2467L/yUM1f9vaZ4t4XUo5eMO1DOflptjOC6BeAfc
	J/nSZOfAo0oKIYLnS/yAwuklRSxloVnUzDhU99jZu+a8Mf2AZKvBz9vpwesu9Zx0S/20eWSXlJy
	QvnGZ2bP/u6cpA6XHqBotGCfm4FGg==
X-Gm-Gg: AY/fxX6dTd7kFgx4F8iByevtXm6quE+pxCKfsXBj9Uix6xTCUX8bIkJGAhP6R0dIzV1
	EdeU1cybj88G29KjPvv8vhRBFCq54AQU5amUkM5p4kwTWb2R8KG1Q+0arnB4PBCHgrJVHZhAt50
	oWv4yY9g4KgOqxwqx9m5lJFCHdf+GZMNohtPGwMYAT49CO+h6sILbgnVYc1MTYALxqfQYVSJfed
	Sgw0+8dRhxC5vBj4AnUulJePb19lgIzyC7DoQQxFPt5nIpQgPQUC30aJr15QzibfK6YNCFNmW0F
	ZSVeI4i3sWJS7IgIaVRwKqPRUnQO/WnKxzhtUGnJJLN7VUM4lL+8ZpZef+ZuqhtIduyWiLac6JI
	YYNayrMCi9YCkziieqCPXQgmDS+kSCylp3O0nJrz+1Ddyu/nYXNCTXJ13YMwo3nYiwjEIaSUmld
	oE1L2V0DW4KKt7iupXd+Sg0Ehoysp5L7KTILqLEZ4/iBgjuJfvOsGoMpCfIQ==
X-Google-Smtp-Source: AGHT+IGD4OZwXbRWr9O09PiGmQGZ/5ny+O15COgPcVJ/A7HvQb1L0vqK6dY2TNUJFZTof39R7GgNaOAXh+HL
X-Received: by 2002:a05:6214:54c3:b0:880:85cd:6d98 with SMTP id 6a1803df08f44-88d81278efbmr136546306d6.4.1766332065317;
        Sun, 21 Dec 2025 07:47:45 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88d97a82eb6sm11883426d6.17.2025.12.21.07.47.44
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Dec 2025 07:47:45 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29efd658fadso106510725ad.0
        for <linux-rdma@vger.kernel.org>; Sun, 21 Dec 2025 07:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1766332064; x=1766936864; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AULQDI1LWCJF3qIS8X6tjUlsT7X8rJU90L+60MyK5oE=;
        b=Hcy0TZmFiSehXYf1lMboCFMYVs/0U4wrXj5H9ApZzhCbPj9I0kOpHqmxF3gjXQOiXk
         riDJIubzvAhsdziBcPwwPF76QDcRwWVi/LMcDGybWxsR4zisxq2xoMTCOamaspogfvwm
         vLS/388epJTz4cSgXtrVgtrZQgkoM6VbUV5kU=
X-Forwarded-Encrypted: i=1; AJvYcCUW2afsMisc88gbiSl/HCcucXvMS9SFmGUlutECPOdpuf56pmX96T/ePj9dE0jcsAVvJXqhj4gwE6Ad@vger.kernel.org
X-Received: by 2002:a17:902:f70d:b0:2a0:be68:9456 with SMTP id d9443c01a7336-2a2f28404a0mr80125035ad.46.1766332064098;
        Sun, 21 Dec 2025 07:47:44 -0800 (PST)
X-Received: by 2002:a17:902:f70d:b0:2a0:be68:9456 with SMTP id
 d9443c01a7336-2a2f28404a0mr80124915ad.46.1766332063721; Sun, 21 Dec 2025
 07:47:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208072110.28874-1-dinghui@sangfor.com.cn>
In-Reply-To: <20251208072110.28874-1-dinghui@sangfor.com.cn>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Sun, 21 Dec 2025 21:17:31 +0530
X-Gm-Features: AQt7F2qBsyLPkHxTKlwpHgoit9HbT6gXs5xPE0LCM59wzzLloPR_oXxAv8RhuK0
Message-ID: <CAH-L+nMzQ9Xcm0WukZjJM4owJ5+wXoF31arRxPs=5-k=Y5LQfQ@mail.gmail.com>
Subject: Re: [RFC PATCH] RDMA/bnxt_re: Fix OOB write in bnxt_re_copy_err_stats()
To: Ding Hui <dinghui@sangfor.com.cn>
Cc: selvin.xavier@broadcom.com, jgg@ziepe.ca, leon@kernel.org, 
	saravanan.vajravel@broadcom.com, vasuthevan.maheswaran@broadcom.com, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhengyingying@sangfor.com.cn
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000418e640646783bc5"

--000000000000418e640646783bc5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 12:52=E2=80=AFPM Ding Hui <dinghui@sangfor.com.cn> w=
rote:
>
> Recently we encountered an OOB write issue on BCM957414A4142CC with outbo=
x
> NetXtreme-E-235.1.160.0 driver from broadcom. After a litte research,
> we found the inbox driver from upstream maybe have the same issue.
>
> The commit ef56081d1864 ("RDMA/bnxt_re: RoCE related hardware counters
> update") introduced 3 counters, and appended after BNXT_RE_OUT_OF_SEQ_ERR=
.
>
> However, BNXT_RE_OUT_OF_SEQ_ERR serves as a boundary marker for allocatin=
g
> hw stats with different num_counters for chip_gen_p5_p7 hardware.
>
> For BNXT_RE_NUM_STD_COUNTERS allocated hw_stats, leading to an
> out-of-bounds write in bnxt_re_copy_err_stats().
>
> It seems like that the BNXT_RE_REQ_CQE_ERROR, BNXT_RE_RESP_CQE_ERROR,
> and BNXT_RE_RESP_REMOTE_ACCESS_ERRS can be updated for generic hardware,
> not only for p5/p7 hardware.
>
> Fix this by moving them before BNXT_RE_OUT_OF_SEQ_ERR so they become
> part of the generic counter.
>
> Compile tested only.
>
> Fixes: ef56081d1864 ("RDMA/bnxt_re: RoCE related hardware counters update=
")
> Reported-by: Yingying Zheng <zhengyingying@sangfor.com.cn>
> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>

Thank you Ding, the fix looks good to me and I have verified it locally.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Tested-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

--=20
Regards,
Kalesh AP

--000000000000418e640646783bc5
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
dDANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgC0q+Dc3W8elP4jknsavRJmRvwa9r
Ypp9MeexXXjsiSMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUx
MjIxMTU0NzQ0WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAopKVUpMJ+pmlmpgckTdAxcKUXK9ZQ2WdAlN7acJx4A93glC4GcZsPrAvq0kK5eez
u0qm4MHjxfNDb0rJFWHKv0AnI7nr0hh9vXVwGGQihZm/sEqStA50aQaCKxNQI0PqU4cZbyCu+Es4
S9hnulKKT2/CMf5O1Jwgbox7pKxY/UBYw9jQvDKlbS2prmKHkBy+pBm824DL7QnldEJ0rl/on6FK
htHcoIwm0iek3owuf6Q/rknPfNItsEDJXeLBt0loBtsRMXiP+PBVFUsfyegM7ZmCZszVCjn9b9ma
4Iwwc9r39tYIVpHXohmFYFrq24OQpDNqPzQDLKtoWAv6w6Xj6w==
--000000000000418e640646783bc5--

