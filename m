Return-Path: <linux-rdma+bounces-14358-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 344ACC474DA
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Nov 2025 15:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0593D4EC2B7
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Nov 2025 14:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489FF313E15;
	Mon, 10 Nov 2025 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UWvDjUHj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6667B13C3F2
	for <linux-rdma@vger.kernel.org>; Mon, 10 Nov 2025 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785856; cv=none; b=UQHNdEth+xFzImRAvaiSsxu7/nFIO7/Y8C6+JIZSqfv7oo5hu1z+XhCY07MZUSDYE2+WsoWn7Im/6ViB1AYXUNYtSDt7IefBscWrZ17m6Mw4xIa8AjQOHqIVE2tP9IQK/G2z5VCjr/XgEbayFMPXNtnWusvP/lyUMPt+f49zN2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785856; c=relaxed/simple;
	bh=eLEHG7u8vSbdDvMljDk3uQoAbsWwAfQA4Xghmbuz5dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7qbUgwQXDuzzdtouPLAHvFQFlCTcgg3/5/N8xHMM2pjQYgjVt2pU4Cgwy84nl0w3R9zGrYYtvZhRs5UFmaw7EAEVIy6dJHgQn0sX288USk3yWCzubst4Lswmu5iX4YCRhiUp28VkFVJFpTH5aXWeGM9WCIK7w+07qekRlev8/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UWvDjUHj; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-297ec50477aso11483725ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 10 Nov 2025 06:44:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762785854; x=1763390654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SD0OSZPbOQT3qM+DRK9VBhxvdNnM9OyWs60J98Jakc=;
        b=GAQsBXgPV87ZJqwg9LGDbPG1ULNGHVzVhkH2v5sg8fMsnkALvdUpfYi/jUDpytqj4+
         ZF8YfoOf5QcG3PKsBKA5rjzDbeamdkMO39n7d+xl9d3b3l3voubVBD+PKhBkXmsDKtGb
         PtcURNRPWQLmUD13ABruMM+wsvXmkRFsQ6XCOt6VKZBuX2WdMAC99pdTgH5ksEFmx3VA
         h220AOaqAX+1qqUg2u2JUkA6cvdVoM3wpmuvf+2pHObKLeXTGgxYz1uMjI4FUIGlms3D
         YqJqY9uFgE6N9t8YudOX0fRWSzZ06fteHuswnn3KMnqdpjvyf9+p0cAVkP3+KTzT6A4G
         /GJA==
X-Forwarded-Encrypted: i=1; AJvYcCUar6sypvuQKYAISIwhEO/FvrjvFJsBeikMJNU0E0jM99LQ4CITXYmi1GBiK4n9E5boDacudVbN+EqO@vger.kernel.org
X-Gm-Message-State: AOJu0YwZQaDlpqJVYfihAhSNeAbJ5lhHJ/Dxy4w8/w6PhTnBQT6fQJe0
	OrX/9Bgmb7UL1CGzcGGD0ui0EfJm6XExqf26ALCCnIjqIA+NbOUm8NVFqEfqGYtmSzI9CNafz0C
	NbDjrl7968udXYf250RjBk5Bf7jnV50lejJ+9p7BYawU06tnRK2JFg+SojuB59YQ5mYWMmU9jmQ
	GMkRwCA5J3esIWsFwEOU9D05zojyhFEsCqCVaveaqXrzxYSDUPt9XqitrWxhv9B+UYR1cF7zfoo
	46nCx5Js6UjUPG5y+tixEiClR2l
X-Gm-Gg: ASbGnctAj73q1CQKFg/wUxqYKoPtwSjabNm5jKdnho1MKSharJLrR/TD3h8KHfTG3ux
	MHV0BQiAaKZnHBYgRu9LEbPcPhdPz43qPH5cSwo9qk5wccY3+2RD+0skY6MvQ4lYSC5Le0dEXy7
	GHQiYUXLeinh/GmJwDNEhsOLKltLMz7bN7E1R4hoo+uLGu1/hWSxhseOo2tQrPecYMQphI2RGql
	YXBWy6NfWj2TaQURRpKJJDiTHjRW9Y1kBs7EhJnU31StY7bXJapUP6nGs5aGeh5ne5PosoqitFF
	e4Tw5rKGKT1vC06rI1RTNbxn3Z10CdC8mwi+r8zVxCvToawlySnoeJSwwQpz6o0z/+xvD+ozr8Z
	7RfAz3j7sOT+/ReL6qnySF0TdKT4VtHDzUoKGlJc4aXme1ZTMlYO8prEeCW56TlczVpgOtHMmwV
	6dh3om1G1l43Zxdsiu+kxEJo5TXWmJMOpYeV8OBTmal8tZpUwm
X-Google-Smtp-Source: AGHT+IESSlbV3oLVOAl2sTMSnCLbTNloZbhJuMBVme86MUcoZCCM+CguKkIyC2WPDTjAiFa4EHmse+zw3orB
X-Received: by 2002:a17:903:1a26:b0:25c:43f7:7e40 with SMTP id d9443c01a7336-297e1da7480mr111843875ad.10.1762785853378;
        Mon, 10 Nov 2025 06:44:13 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29651c8d0desm13739115ad.46.2025.11.10.06.44.12
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Nov 2025 06:44:13 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b30184be7so604620f8f.2
        for <linux-rdma@vger.kernel.org>; Mon, 10 Nov 2025 06:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762785851; x=1763390651; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1SD0OSZPbOQT3qM+DRK9VBhxvdNnM9OyWs60J98Jakc=;
        b=UWvDjUHjKezoIdjwWMsOwNu72zX9+mams3OTbK16VK4GzdaGyzU9WOgPHrO4fvQCbm
         orLoMcvANMvG6DSsOTRzLKjqOVTLOPXTC5nqRbSUF9H2LiylMJcSNjxD1R+pErQN1G0h
         FMsfmVcfFOlJA2z5UeyKbYQOwQk18hQUWpgCQ=
X-Forwarded-Encrypted: i=1; AJvYcCWsjWB8ACdmCNwYIX4T0prv9z8BcSxhKorUgHYyhw8fQ5f5riOiv6BQ4oopPkyibfR0mry8dFUtMmOj@vger.kernel.org
X-Received: by 2002:a5d:5d81:0:b0:429:c711:22d8 with SMTP id ffacd0b85a97d-42b2dc1eb5dmr7576384f8f.15.1762785851203;
        Mon, 10 Nov 2025 06:44:11 -0800 (PST)
X-Received: by 2002:a5d:5d81:0:b0:429:c711:22d8 with SMTP id
 ffacd0b85a97d-42b2dc1eb5dmr7576356f8f.15.1762785850761; Mon, 10 Nov 2025
 06:44:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104072320.210596-1-sriharsha.basavapatna@broadcom.com>
 <20251104072320.210596-2-sriharsha.basavapatna@broadcom.com> <20251109091202.GF15456@unreal>
In-Reply-To: <20251109091202.GF15456@unreal>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Mon, 10 Nov 2025 20:13:58 +0530
X-Gm-Features: AWmQ_bmgUWr5lbqwPaGGLK_WPTZpD0Xu1fQ2blq5Aa1AmMSH6TE4vnIFLf20HOo
Message-ID: <CAHHeUGWqHiKxFj_o1-+Q0ANKXi7SsmeJyk4rLW2DagbG+yB95w@mail.gmail.com>
Subject: Re: [PATCH rdma-next v2 1/4] RDMA/bnxt_re: Move the UAPI methods to a
 dedicated file
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000080473606433e904d"

--00000000000080473606433e904d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 2:42=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Tue, Nov 04, 2025 at 12:53:17PM +0530, Sriharsha Basavapatna wrote:
> > From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> >
> > This is in preparation for upcoming patches in the series.
> > Driver has to support additional UAPIs for Direct verbs.
> > Moving current UAPI implementation to a new file, dv.c.
> >
> > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > Reviewed-by: Selvin Thyparampil Xavier <selvin.xavier@broadcom.com>
> > Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.co=
m>
> > ---
> >  drivers/infiniband/hw/bnxt_re/Makefile   |   2 +-
> >  drivers/infiniband/hw/bnxt_re/dv.c       | 356 +++++++++++++++++++++++
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 305 +------------------
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.h |   3 +
> >  4 files changed, 361 insertions(+), 305 deletions(-)
> >  create mode 100644 drivers/infiniband/hw/bnxt_re/dv.c
>
> <...>
>
> > +++ b/drivers/infiniband/hw/bnxt_re/dv.c
> > @@ -0,0 +1,356 @@
> > +/*
> > + * Broadcom NetXtreme-E RoCE driver.
> > + *
> > + * Copyright (c) 2025, Broadcom. All rights reserved.  The term
> > + * Broadcom refers to Broadcom Inc. and/or its subsidiaries.
> > + *
> > + * This software is available to you under a choice of one of two
> > + * licenses.  You may choose to be licensed under the terms of the GNU
> > + * General Public License (GPL) Version 2, available from the file
> > + * COPYING in the main directory of this source tree, or the
> > + * BSD license below:
> > + *
> > + * Redistribution and use in source and binary forms, with or without
> > + * modification, are permitted provided that the following conditions
> > + * are met:
> > + *
> > + * 1. Redistributions of source code must retain the above copyright
> > + *    notice, this list of conditions and the following disclaimer.
> > + * 2. Redistributions in binary form must reproduce the above copyrigh=
t
> > + *    notice, this list of conditions and the following disclaimer in
> > + *    the documentation and/or other materials provided with the
> > + *    distribution.
> > + *
> > + * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS''
> > + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED T=
O,
> > + * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICU=
LAR
> > + * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTOR=
S
> > + * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,=
 OR
> > + * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT O=
F
> > + * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
> > + * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILIT=
Y,
> > + * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENC=
E
> > + * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, E=
VEN
> > + * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> > + *
> > + * Description: Direct Verbs interpreter
> > + */
>
> Please remove all this boilerplate and use SPDX tag instead,
ack.
>
> > +
> > +#include <rdma/ib_addr.h>
> > +#include <rdma/uverbs_types.h>
> > +#include <rdma/uverbs_std_types.h>
> > +#include <rdma/ib_user_ioctl_cmds.h>
> > +#define UVERBS_MODULE_NAME bnxt_re
> > +#include <rdma/uverbs_named_ioctl.h>
> > +#include <rdma/bnxt_re-abi.h>
>
> <...>
>
> > +     uctx =3D container_of(ib_uverbs_get_ucontext(attrs), struct bnxt_=
re_ucontext, ib_uctx);
> > +     if (IS_ERR(uctx))
>
> This is can't be right, you should check ib_uverbs_get_ucontext() for
> error first, before doing container_of().
>
> > +             return PTR_ERR(uctx);
ack.
>
> Thanks

--00000000000080473606433e904d
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
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGszCCBJug
AwIBAgIMPiCpKhlPGjqoQ++SMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTQwNVoXDTI3MDYyMTEzNTQwNVowgfIxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEUMBIGA1UEBBMLQmFzYXZhcGF0bmExEjAQBgNVBCoTCVNyaWhhcnNoYTEWMBQGA1UEChMN
QlJPQURDT00gSU5DLjErMCkGA1UEAwwic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNv
bTExMC8GCSqGSIb3DQEJARYic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNvbTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKS3kXt4zVFK0i5F3y88WV5rV0rr2S3nOVTaCGMB
o6Se8pIb2HJcdpQ4rMiJuIRSyG2XDWv6OB+66eM/6cD2oklFcdzpC4/eYOQFWJ/XM8+ms6HT7P5e
uE7sY6CeUzLzHNjcRwVgZRWlELghY7DIW9fbMzRNDFsbxuIN/7eSofavP1q7PF3+DqhHZpmrVkDu
vcEBTRZSn8NWZ0Xhy4a+Y3KN2W55hh6pWQWO0lt2TtpyaqYp95egJGqDUPtqydci+qrBzXbL05Q0
gcK0NfqGJwLsEVqxHwzz/jRrzKBYKQEK4Bpau91oxVGLmxy1nQDiyI1121xyvsJBDctKH245XZkC
AwEAAaOCAeYwggHiMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSB
hjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3Nn
Y2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5j
b20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgw
QgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9y
ZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjZzbWltZWNhMjAyMy5jcmwwLQYDVR0RBCYwJIEic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJy
b2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3b
oCOFGLCgkjAdBgNVHQ4EFgQU9Dwqof/Zp1ZdK6zi7XdRGdBWQt0wDQYJKoZIhvcNAQELBQADggIB
AKzx/6ognUMhNv+rh7iQOeHdGA7WMDixk+zrD7TZL6O5DPqXfFqaTLpswyruTymA3AVxZkMJyF6D
zOAsRfU23BjVlgC95zl1glr7DorZW7B/CQDwbLHlkFy92Oa3E+gBzwdiDMjnq6tOW5p83zoVqiV4
qm4OwC9JILEkslV4uZVXHPm5cZoOQURTECE2BN34Qhg5qD3EKYqOTeMVRed1qQiIPqQv1b4xjPVS
qBwNPl7/4TJGiZGnRB7FsNnNUQRJONnEFifM3KGqjbqA4F8BhLXCYjqtBxxCGA5506StNfsjT8UU
28E6lcuJXC4hQXau+xXQ5GWqS4ecWwm22FAVy/i8FJVfXPTJnZeixmqaadbIU3fOJs5+XfyNkU2T
mlCafSr7KgV570M6tITSyminW/7rc8hdznGYypCNa+45JYJTaK4x1+Ejptaxc7TCS12B1zQNCxa7
AHX5PZra3SpDb7g1p1i1Ax0JVJTkThiCSNDbiauVn7xIJpf+H8HC6O2ddGmtKUxe6NseFnSGJsi6
7lO/cU+TpduV7w3weUy+nHhp+GsbClfvAGhFAs/GkyONExCwwIEVlFp9Mj5JLAgB+ceMbojBIoaO
d5rOzdIII5FDwKAAqyjHuniYLrP0xIH4L5kWOAy+LudP4PSze7uAxTiCiSJg5AaNBTa5NuwTnSX6
MYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEo
MCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMPiCpKhlPGjqoQ++SMA0G
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCCnILOm7krpTDFjCWl4KyARnmyoQCQ0FNf
GWEYZiN1dTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTExMTAx
NDQ0MTFaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQCAh5kLhueR9Z4aJCc5tzOHtg9EisWJrNjWfyg5zKkor5nillEqnXmRYRV7W0zUz7GTPh/0
AAtPbaoXmgaxVhryqItLKguDmtVWgPthdN0IjeslHu3Ng8pb7+EAdDoCl30RfxxsXC0OR0O5BvwR
srqn1hmh3DCJkLtKrqLLR1JIJJa+hsPWHUttLwoyu/qrGRZGCpSH8VaShEZlI6OvwDvCiAW9Jiji
mXTQRF5k8ptwb5vNdVd1s3ZiLrCXjL/S1CAzGxW8unAQvSo+UpLSDa1qinVxx1ULP0uykIezfT24
bV1TV6ldtfFJEnuKGFullaQDJ9W3D+cgiCnA792Ooykb
--00000000000080473606433e904d--

