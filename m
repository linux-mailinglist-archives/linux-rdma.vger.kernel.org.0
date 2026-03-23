Return-Path: <linux-rdma+bounces-18523-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNdDLjd2wWkQTQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18523-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 18:19:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D432F9BC6
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 18:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 260363137531
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 17:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7C73C5554;
	Mon, 23 Mar 2026 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PCmsZNcO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f100.google.com (mail-dl1-f100.google.com [74.125.82.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600E3BAD93
	for <linux-rdma@vger.kernel.org>; Mon, 23 Mar 2026 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285756; cv=pass; b=m2JM2ERqqWEYeGAEYlOlMsArRp2Q/s2IcmRmknB0jNsDzPc/B4P/xaxFVlXQgdBikAUvvbDgRh/3X+fxAeaOGFWOZveBrqqwK+0WqueGQMvnjHQgKDWpO3sgMpxJyL6ii0JZ93FQKQASBoJoAo/7/r8NjDRzTbi3+txLkQrZInY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285756; c=relaxed/simple;
	bh=ya0qhg9K1eNcmJeHIcc8lhhcXNwHx/dYfhIBQaGQXbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQFg3JUJRDa0E8zmiSArXvAtH0a8aD4rOnO+lvF98BRiowAzqVnbk3SOEzbR8whCipPWBDcl3EY12sd//LaJe7FEXN4OaHCyCZVxIXhrrYyKENucL3van3zebuheoZUaWAp0G+A8i3FitAFdoQ3I5rYTMVk0KnbXwQDNZ4Psuso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PCmsZNcO; arc=pass smtp.client-ip=74.125.82.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f100.google.com with SMTP id a92af1059eb24-12a74039dc6so331153c88.0
        for <linux-rdma@vger.kernel.org>; Mon, 23 Mar 2026 10:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774285754; x=1774890554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7f77ATGguAgrkd4aag3TnwAs4FOnSyD2DXN40lz/J4=;
        b=fJx1eUMoc2xLP1Ds4BihCAUCGVsU8oQMXCmQCjms+ipVz0Pb+K4AGksJa/afw0Xclt
         BQNbCjolOLu3yoHwqQYsoHSliILbH5KBL644GwRQlp5jNxePvQm+TATieHPOVzV7RvWv
         POUxs3tEeSApRbsV9QfClY698l2kbrzP8Op0BwftoxwdMXGhbdBvsqCbrlKI1FxgFmLU
         HmOyeC4TOy0hRbBEmQ9v5XLWeQBu/wm60xKnRIByPYXphiHppFVE7UfKx+BAiRObI76h
         HCK8I7uCeOFQwNIojHYkNikPgBFE8CL4NrC4Lp8yCx0Hxpbf54JUJ5Ce04Crhkp4I/3U
         H+BA==
X-Forwarded-Encrypted: i=2; AJvYcCWFrNSa4Qk0CCoVbOMCmyCqHmHHxEVNhYYicssL/UwWx/RZP5zi60qaWhhJ4QV8pbvjpT/9gK6DJRai@vger.kernel.org
X-Gm-Message-State: AOJu0Yysz423gdOEl5C6QHMNacl03346+7B0liGHxORmyWwuRWe++lv3
	j4KeHWHuIfhJN/ODdeOe6g3fFeYDTZf4xxMJohp0MO7zG2xj+9yKKjP13SvWTN8tYLis1o6BkLQ
	87QPAkPFcoqHVLgUVvVi1g90RUexUp9JUnWqD/izwSUzqVng7Ihmk/Ug4DTczLNh5VXtC4CSS38
	h9EjLkpKV2nlyfMY0Y0G789YExrExhialQu9R7Otz4oC7HccjtBFqt4+Rua+N6o1hXF5v6i5r1V
	ykYvKrmc2eQDhEauQ==
X-Gm-Gg: ATEYQzzm2BSWJqaswPBRVT4XtAHD62Bnl8VrrlaLSwcJ2UsAeR42qx0ygb67tR0og9b
	H+khqgIl6l2p4kb133MI1DzQ+lzzzv28E3RdF5t2Fk5f4Fc0oRFXg2F7u8IaNwLhdkZEq4KVwvX
	2YQcfqxYUbosINJp0ZYu4IJAax097iwCeMlQ+vv6ucVkU6yDcGJ223atphlO1TbtX43oG7oqZJd
	ykBPIrC8t4pgYAncomETbDMvODxtMtM5ld4DKYMA2ZzgR1vgv4N/FdcMKX2ZwUblFXlg5yte4XV
	xZpOTN5+7oiQL3yJUbEH5kUx2SRkL1tkFbWbzjdDq2CHEGb+4Ik+hEAd2hodEqhZvlTDdfYqmY7
	r/CNxq4wQIpWh8+XXVHbeDakIwUB9ztCx3EZjX9HL+CpqP6Z0TvknMBypVDgYfh5NAbZWO1TXRf
	uN44a4Cy/YelWX3iBbcfsfDaYoylX/KiCL1GOmk4FTjsXAugFjt+I8iRa1CQ==
X-Received: by 2002:a05:7022:ff46:b0:119:e56b:98be with SMTP id a92af1059eb24-12a726d2986mr5649774c88.37.1774285753833;
        Mon, 23 Mar 2026 10:09:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-12a7349a4cbsm624404c88.8.2026.03.23.10.09.13
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Mar 2026 10:09:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-899f671ceb2so19716716d6.3
        for <linux-rdma@vger.kernel.org>; Mon, 23 Mar 2026 10:09:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774285753; cv=none;
        d=google.com; s=arc-20240605;
        b=cMfBDobd/XAsyAwOFYys5cEyBiun40SBzyNWIEo1XAQBSL1YUFcALNlxGhVtefnL0w
         JfUEUI3BmCl303M+P80MwkHu2m09MBH5ma3OYKL4Bd+o6m/JQXUW0z9eTaTuIbhqDMFH
         vnEzQnjGeq5fpdgiuJmRJT5QCe79RSY69VFmXKC9T4yv13xc9kQKI28IxUjmJ6hk9nzE
         hrdA49fYOU7JgPQfuwsG03y9ioRL61pJUXzBHj5JyRuLZxEPoTiyeuYRlt1bpr9J6+ea
         7vwnc86DWO/Hg5R3ZwDOQ9GEDht+s/cEbX5BHwius79ZWMLIXj5pRvS4zk7Vbe9lBFRC
         5v6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L7f77ATGguAgrkd4aag3TnwAs4FOnSyD2DXN40lz/J4=;
        fh=8lYO+vD7lDCkFUm1Yy1RUXdW/65SKYKO+AQ3ybURMCE=;
        b=PKJ+Wdq+IhyJcON3R6/RZnrwRaHSCGuVcKD5/XxWXeARQob5a5QG+BUX6FK6c7FMvH
         eZ//BuJBcmVT2sQXQw2cr5RhZhpSOzP13ggZ1ySGVNVnLZBsOMy1gcCV1Y3moQZAgfFA
         klbDISVi72Yr82bp8XTkLUpgPUFszQGVvRwgbPBlmKEupp8gDX0pyU/Ma/h+VGv1Xp5n
         7u3MZMwLz2mBe2wIqRKT7e6n99u44J9uon9PIJst1+dqVq7L446l+bXT70SN+AkCXaXs
         0GsIPw9mYpsHtw6VCON4dx/ajaA0fY7xYQ+mBZAQiS/C8jGqvef0WLO9RyrZjBVKCHCc
         42yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774285753; x=1774890553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L7f77ATGguAgrkd4aag3TnwAs4FOnSyD2DXN40lz/J4=;
        b=PCmsZNcOn7Z/ob4S+awRXdSI6AeBK4oAwKr7OTEGU+/eFAE8XpFLbEPB1D/7zn6c0z
         xwjBARxd85xTVWE2HT0DPx+L82ob23lAuUj8776Vl8jQ0yVkuPR5gzPd76Rb7SWInPl5
         E9Kw8wZ+71/0c4S0RPbkkbaJ4GnOR/ZumnwUI=
X-Forwarded-Encrypted: i=1; AJvYcCUkVy8aQi5/bEvtLEigtmCH9ynWXjx4UASNiJTdURWbTvKLjTlCOLMx9p30WasMVG+rTLGy29YKjyMB@vger.kernel.org
X-Received: by 2002:a05:6214:3981:b0:89c:4ea7:a716 with SMTP id 6a1803df08f44-89ca503405dmr82449516d6.63.1774285752566;
        Mon, 23 Mar 2026 10:09:12 -0700 (PDT)
X-Received: by 2002:a05:6214:3981:b0:89c:4ea7:a716 with SMTP id
 6a1803df08f44-89ca503405dmr82448846d6.63.1774285751909; Mon, 23 Mar 2026
 10:09:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318-bnxt_re-cq-v1-0-381cb1b5e625@nvidia.com>
 <20260318-bnxt_re-cq-v1-1-381cb1b5e625@nvidia.com> <CA+sbYW0vhjp49vngMs21DXErN=tMRN3M8uxqSSjOHL+H0uAbvw@mail.gmail.com>
 <20260323111401.GH814676@unreal>
In-Reply-To: <20260323111401.GH814676@unreal>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Mon, 23 Mar 2026 22:38:58 +0530
X-Gm-Features: AQROBzAlqgU--uWGEK7vfZUUIc81J664AbGhCj39DzYAenJpNhEj28YiB1ApsoA
Message-ID: <CA+sbYW0LNO7j7w-SBS-rt4oudmtUsjwG6-Ay7C0-1MbWPD95mQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next 1/4] RDMA/bnxt_re: Simplify bnxt_re_init_depth()
 callers and implementation
To: Leon Romanovsky <leon@kernel.org>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000ae9eb064db41825"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18523-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 30D432F9BC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000000ae9eb064db41825
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 4:44=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Mon, Mar 23, 2026 at 11:46:43AM +0530, Selvin Xavier wrote:
> > On Wed, Mar 18, 2026 at 3:39=E2=80=AFPM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > >
> > > All callers of bnxt_re_init_depth() compute the minimum between its r=
eturn
> > > value and another internal variable, often mixing variable types in t=
he
> > > process. Clean this up by making the logic simpler and more readable.
> > >
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 81 ++++++++++++++--------=
----------
> > >  drivers/infiniband/hw/bnxt_re/ib_verbs.h |  9 ++--
> > >  2 files changed, 42 insertions(+), 48 deletions(-)
>
> <...>
>
> > > -static inline u32 bnxt_re_init_depth(u32 ent, struct bnxt_re_ucontex=
t *uctx)
> > > +static inline u32 bnxt_re_init_depth(u32 ent, u32 max,
> > > +                                    struct bnxt_re_ucontext *uctx)
> > >  {
> > > -       return uctx ? (uctx->cmask & BNXT_RE_UCNTX_CAP_POW2_DISABLED)=
 ?
> > > -               ent : roundup_pow_of_two(ent) : ent;
> > > +       if (uctx && !(uctx->cmask & BNXT_RE_UCNTX_CAP_POW2_DISABLED))
> > > +               return min(roundup_pow_of_two(ent), max);
> > Looks like the min setting is missing in the else case. shouldn't we ad=
d that?
>
> I did not add it because all callers of bnxt_re_init_depth() already chec=
k
> that ent is less than max. However, roundup_pow_of_two() requires a
> min() guard because it can overflow the prior range check.

Oh. ok. i missed that. Thanks
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
>
> Thanks
>
> >
> > > +
> > > +       return ent;
> > >  }
> > >
> > >  static inline bool bnxt_re_is_var_size_supported(struct bnxt_re_dev =
*rdev,
> > >
> > > --
> > > 2.53.0
> > >
>
>

--0000000000000ae9eb064db41825
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
zJH6Ivyz2skA36zh/px/UmF2ORX4Y0CY6GtU8/vxuN2j4rd2medlyifwALUm+KI3SsD782IwKLCf
8bNhYGiw4YxsbyX7dV7O4SNQc5U9ktrSKH3D4SuTnK/xdjca5PiNI2NTcBVmP7+u2bvVLdRqISop
9dpRkJ6xxhGJjxakljIxHdcZLXltxX4YM0Onf3agcjY3boIqnVlDjBwSZX674ZU+YVrcIlcRcqs/
W83e6PmIRFwpkKOhuLNKSpW5mZoEQdpnxGwE9U7qLGECAwEAAaOCAd4wggHaMA4GA1UdDwEB/wQE
AwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5Bggr
BgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUG
A1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUF
BwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDag
NKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJQYD
VR0RBB4wHIEac2VsdmluLnhhdmllckBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQw
HwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt26AjhRiwoJIwHQYDVR0OBBYEFJA9fV7cOoiN64ws5XPC
J5qtayo5MA0GCSqGSIb3DQEBCwUAA4ICAQBFCIF4AxAiXVz6gX5YfFEbIYtbGFifcfe+QGc5cfac
CSzIrQWUPXAYAef3G5WouD2AKwa2tPGJgK2L7n1r2W4NIvr93588EDVnGgfMfWaFsB8VlLsPlH8Y
fLfaTdN3OQPnFFp54yK9wv8AtTIiTQcailMw7QX5x5GE6HVZElxf0V0Ljc2NrUQLoYzHzAU+sysl
6JQzomxjIfuXiIiUfmnWQdhO95kQchRdOUAaguLTV+RRfPZ1p54dRmgGEpJtzjGLdsrLkZ2rCN5j
cOTTXyxJmvlgm9jfT0Uy5SOPHdq1jtZbQyXrNT4fQ07Odmq3xQCUTi+a59IiC+6V7nFJ8zyCSk+p
n/iGouvun/owYzTmFxB6sVLWZcaWz2Ufcm7b6nOYV+pwUS/n6+6oFRKmGLrl0CRCF0AOph5p81aV
kgKuS5oXBoDefJfjKHuu5lJVelBx3n++iMGMW9FWFmXErCHy2d+L42Raai5X2PL8jAmh+lpPRDX4
CT9jL6xWM5QkCBtxyVKuxGxxUY2wczmVcQ1nGh9mGghI04Scs4OtE8Qh9LMOe2PXzxcV6lpF+yay
B3fwJWxl7miwNFjWuu9M6Z+rcjm3JF5srcAu2fp/VzQD4AE5Kq7ywukMvlU4Y3X2t+D2eU1DH8pk
c8mM1CtQWfWUboaoLABVmYmYfihDvTURkzGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAX
BgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1F
IENBIDIwMjMCDDy76dRYp65lyF2c4zANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg
RsjDnCKr2IL2sRJRh1WcR1exDzjYaaolHIPGeRsYicUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYwMzIzMTcwOTEzWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAi9mUIL1IhtaANBNsWFsuVjG1DyJ2N6GQXbn0
7hg+mZ+PyR5AjtjNnYfI5I9bLNDq4V5S0DOq1kd2AnU+utqqyRn7fwF8XDXhCqBcB5SJCveTLJ2B
kVIBqjBMybOSbP/gV/1S+vmnnRofm0FVB7UYwl65L83yJsYtzFxjAEHrXjGCj8OuQvuwKQSvNACp
bl9QTgORYSm4Lkyw01ph9Z6fESN7XvDLjroHJRWwsfUwSnrOgRe3bghrE+047seOPym9Nt3dyaD6
uKfOJdvP8OneGsyOP6OUiHEw5XQJOdJ6VS0wt/go4zgeMjqw9QvhYCrAnYvLD37Xyaa/HkBx7iw3
BQ==
--0000000000000ae9eb064db41825--

