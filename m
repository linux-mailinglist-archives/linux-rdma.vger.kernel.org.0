Return-Path: <linux-rdma+bounces-16523-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJVFDW9Rg2mJlQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16523-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 15:02:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEB7E6C81
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 15:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C210830D137C
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 13:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5780540B6E4;
	Wed,  4 Feb 2026 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XKQEXwpF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com [74.125.224.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD28B3EFD12
	for <linux-rdma@vger.kernel.org>; Wed,  4 Feb 2026 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213364; cv=pass; b=PQcyT9SL9ykDEgXUOm66IpPOuN4TCgYLJFuiD/MFUIZV8JE4SFgnOgDeiWgDvdujO5O/1jIyDfEzVNie9czJC08y0okgo5usgg9CgYoZ/YccbtGMz/zQpAKpcUVfnEc9iPBtFC4xKKpJ2UMyDD5bNZLr8KbjRfjB6hWSWB8YbQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213364; c=relaxed/simple;
	bh=ZFr+wG3p4uUPGbC7y0GUO22BcQMbx42/LTJTpCM+aCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukvwmZh9UCmQplUd1So8cxi/Tyqxl4oI+GnU6B+O1iIKGmD83ApY8GUeP27cenZaDJoKWwymX5Ts7UkR/LbsPwVBzOwCp3ix1KdlAhlHJyanwP5h7g+o4tnK+Z4XxpvZXnoO/nf82lrgdNhbhmTUKi1y5uVyE6UP1F7iCgsECEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XKQEXwpF; arc=pass smtp.client-ip=74.125.224.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f98.google.com with SMTP id 956f58d0204a3-649df3c22d4so563357d50.3
        for <linux-rdma@vger.kernel.org>; Wed, 04 Feb 2026 05:56:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770213363; x=1770818163;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAkVol7MQyL3BLUCOwDEcDfiPYtq6ACvvpupR+OYSyI=;
        b=DXfn1RohrEiGVSrDI9VblY5Uui3lPMjLzKqI9K5BM+OzJ0GTiYuWVHJsJeMV5jCxzg
         JWUytMbBM/1SjUt7l/jqEOqFHyv1wECQ7HmVWdgHXKnJsL4RhJ+FONP3jcyR5nAs2BLT
         2RSCGedh2igrbnkRtf1jFB2HplT/9gnBwawzpP5C0YcsjZaIiZPyuYXxV7ZJSCgT6LH0
         w0FOuP7DaEoPGx7kN9Y7CtEEsIPahwbG/a4fBFGq/9PBJygUEqUX9RwsuM3hyfsdZQwE
         G6vBjXnU3OmNmO5BMyousvAZG+gHmtytSeLt7kPpmLGHg/hvtH7by0V6DVLUioVsQDjU
         39qg==
X-Forwarded-Encrypted: i=2; AJvYcCUEhj6i3PMMKCB/HgSp6GQ1bC1WZnKMjK8Vxxoot4l03814bxiNTV560q54DrkJHlAtm1At0Hd0m5Gu@vger.kernel.org
X-Gm-Message-State: AOJu0YzBbIhCc+wYv5hqjDB4ekTWRGGW6okljdQPDMZ3rLPtCCmAls1H
	FCzfa5drrvxA4F2VofxOswqEyoS/3+PimZYXM/7rIHHCCPs6b0Gu69kGYfAZ9L62w86hjHkCnIr
	E6yn2sTZItNL+OvE0H3Jemf/Naa5CSrj2+VXE9GfNX8tHinokaq+NE51rpaHMA9A4wdG5N8LAPg
	gOSIicw9goYlV4llzncNhnigYpq/iOQFrP4w3ug0ysdvTn59aYPuZrH8pEiANliBg7dgR5cp9s4
	oFZbCrQgldX31tkpZyI3kvzTvh0
X-Gm-Gg: AZuq6aJdGoc/Mu/ZEK+PNvIH86O6QFhRQHUBV8KUok3o0lqOpG9L0DjGjlWtobGQ1lW
	UcSXLDMnshFWLdlttjMdEhkCHJtp5hnRIkSRPtoGeYkOeg2CRHsTXVDgliN5HsVfaV3ZdA/IMbA
	s+TVyWpO+/E9PbXWf7ehhLRZRyyFBHdYwSBT2MQLvTAOue9RNDfuJJgUCqH3o7i6bxjeKla/7kz
	RQecHKIPmcQrDcrU4xt6E9PaG08PSZDRv1KIbZh957ROY6CAIDGmqJgnye9tS2KZraWwPu77flg
	4BE3mEk86lL6fthKEkcm+iiiYrCMQfVK6ol/Fl0rSTAQPlU+arU7V8r2OY6Cz4XW9QvcZVlwsMA
	yVUwQiVWdXjT6hXjWAEkwbfsZ+CrJZAOZiHj3rebvMP1wE9sNtnVgVhUj12RZbtAVbJzPjACwdR
	Gz8bccruyIZdvno10Y++m+LmzefjFq8AYX7WUO2nefgBBSREfADjIHeg==
X-Received: by 2002:a05:690e:124a:b0:649:4997:3e9d with SMTP id 956f58d0204a3-649db33eedamr2784263d50.23.1770213362756;
        Wed, 04 Feb 2026 05:56:02 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-649dc5c5cedsm120778d50.9.2026.02.04.05.56.02
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Feb 2026 05:56:02 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-435ab907109so506699f8f.3
        for <linux-rdma@vger.kernel.org>; Wed, 04 Feb 2026 05:56:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770213361; cv=none;
        d=google.com; s=arc-20240605;
        b=KoywUgiyj6LOTbX1x6ChINlSuDsAF0aB8nwaSniWt8VcyrjwQ87spupFGg8fwpISMq
         3ZeuD9kRMHNCvIszTJWbkXqDFYW30QmkKRrY9Gzgp5QK3Yd5bfTh4fgzNawb0dBszi42
         Lyyku7CfOyG1dNj/OvSmk97ErkTXeL0CwsjpH9aSCU7z+m/5nt5sFJ6P/cUcPvBBWKMN
         YqF/A3YOK0fa/iRjBQDwjitCbjQHkQE+5/dSCB+f0F1Fen8PrFTTR9TRpJgb70P5wpog
         soyvdV16Ws5+kudrB2dsqu017MAt9xlQ6I6M/CSaQU+eZYmLbAf3dFQH3lx3j5ageQ7o
         CoTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OAkVol7MQyL3BLUCOwDEcDfiPYtq6ACvvpupR+OYSyI=;
        fh=WOx+6pSJEXAwj6xZQm09/UASLLA6mYAsqoB75ZvNre8=;
        b=hWhw0XfJ70IgEbNnvBh0ysnNLN6kpKg9HTc+XzoaGyJRsGw8FBiVfg7ONS3AeztDQL
         Kog/qfE8GBs8vvEH0oRAAv2r70FdcsO7b2jH9QnyC/+3UBlHAuut7XXztmI+NAK0oMOU
         JQucZ5z7FXW5gWw0e6r1tMPS3fsmBzns6PdYxUOITKrGzHY7PoPu/kxhAd6fXPtC0xjs
         UW4q9azbZHMqzUDnuwSbiqVwAdrsptB19ybEMZFTIeTYKEwSDM5CC2D0/p2v4mJ1Mg/P
         SlNZCcntRhkUO0NCS1UwOu9RiaL4y3i4m5pQGqnZ4DUhD0M1zEjVAwtCarZok7TRJCWm
         3elQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770213361; x=1770818161; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OAkVol7MQyL3BLUCOwDEcDfiPYtq6ACvvpupR+OYSyI=;
        b=XKQEXwpFI/muVv+WKKPzhGiATEZ8xYxUL4T+kyf4wCmY6HJXOFJcVm7L+sweLSL1aR
         bYdlAfBNfM4H8J6IfxYMgqnd9XSB3NQPBYPEhTpVOF8MWrdw7zRlTUk5bWSmBw4+LPej
         5Hk5mjLovz6rZ1lzTwrytECBA78AtM+TECXUE=
X-Forwarded-Encrypted: i=1; AJvYcCWTJ9/ep/1sUejaDFgNP+zz9DI20Bd3yt2XPpxvKVGSjOrRnGY33iGGcX54NM+GInWkGH9j9PA8nZcB@vger.kernel.org
X-Received: by 2002:a05:6000:2913:b0:436:141:82ee with SMTP id ffacd0b85a97d-43617e3c85amr4489702f8f.22.1770213361103;
        Wed, 04 Feb 2026 05:56:01 -0800 (PST)
X-Received: by 2002:a05:6000:2913:b0:436:141:82ee with SMTP id
 ffacd0b85a97d-43617e3c85amr4489665f8f.22.1770213360673; Wed, 04 Feb 2026
 05:56:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203050049.171026-1-sriharsha.basavapatna@broadcom.com>
 <20260203050049.171026-6-sriharsha.basavapatna@broadcom.com> <20260204011019.GZ2328995@ziepe.ca>
In-Reply-To: <20260204011019.GZ2328995@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Wed, 4 Feb 2026 19:25:48 +0530
X-Gm-Features: AZwV_QitGvPAP61bTnVgUyPX8Ct8i_YMje2qQsyTaekJwYg9hGmZNtwLVB5HVT4
Message-ID: <CAHHeUGXky2H8NSWy8ZwCcqKDQEBn=CkMAzsLDT5gBFnZrn0WYg@mail.gmail.com>
Subject: Re: [PATCH rdma-next v10 5/6] RDMA/bnxt_re: Direct Verbs: Support CQ verbs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000097a0c80649ffea4f"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16523-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[broadcom.com:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9FEB7E6C81
X-Rspamd-Action: no action

--00000000000097a0c80649ffea4f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 6:40=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Tue, Feb 03, 2026 at 10:30:48AM +0530, Sriharsha Basavapatna wrote:
>
> > diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_r=
e-abi.h
> > index 51f8614a7c4f..4c079d60b43d 100644
> > --- a/include/uapi/rdma/bnxt_re-abi.h
> > +++ b/include/uapi/rdma/bnxt_re-abi.h
> > @@ -56,6 +56,7 @@ enum {
> >       BNXT_RE_UCNTX_CMASK_DBR_PACING_ENABLED =3D 0x08ULL,
> >       BNXT_RE_UCNTX_CMASK_POW2_DISABLED =3D 0x10ULL,
> >       BNXT_RE_UCNTX_CMASK_MSN_TABLE_ENABLED =3D 0x40,
> > +     BNXT_RE_UCNTX_CMASK_DV_CQ_SUPPORTED =3D 0x80,
> >  };
>
> This is not what I outlined before.. You should have a patch that
> makes the driver implement the uapi compatability protocol across the
> board.
>
> Then add a UCNTX flag that says 'compatibility works'. I don't want to
> fix these problems peicemeal forever.
>
> This is done by
> 1) checking all existing comp_mask for valid values and returning
>    failure
> 2) Checking that structs have trailing zeros only by calling
>    ib_is_udata_cleared()
>
> Here, I made you a branch that takes care of it all:
>
> https://github.com/jgunthorpe/linux/commits/for-sriharsha/
>
> And makes the required whole flow a lot clearer since it has evolved
> into something that is far too open coded..
>
> Let me know what you think.
>
> Jason
Thanks for sharing these changes, it looks great. I certainly missed
the point that you were suggesting a kernel helper function for
structure validation and one that also includes comp_mask validation.
For bnxt_re, it also eliminates the need to have a separate compat
flag in ucontext for each type of ureq.

I applied the draft version of QP-umem support patch (not the series),
followed by bnxt_re DV patch set, updated bnxt_re to use the new
helper for CQ/QP - ib_copy_validate_udata_in_cm(). Tested it and it
works fine.

One question (maybe I'm missing something) is, copy_struct_from_user()
seems to have similar logic to check for trailing bytes when user-size
> kernel-size. Is it also needed in _ib_copy_validate_udata_in()?

Let me know the next steps.
Thanks,
-Harsha

--00000000000097a0c80649ffea4f
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCC74sAr2D/zCcnO73uNB1KYI0wtgefmQROw
pN6dAu7jbDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAyMDQx
MzU2MDFaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBhLXHmoXrQwUDmnAozappj3UFgZQULPBTBt/ZX3uFz/G/vp/SYf0rwvfmmuAnDos+iPyB8
V7gGNbse1dEl6hQBKrIIkEuyqQRolhnayG0FQS2O3KyqoxHYnQVSSd2HTr7st0EQMFX6HBWXJN49
emCLklAeiOUxjYm37T7WCJQ9Xx1WPCHlgNmjSD5cIJsUl0jlHVrHysY0VN/dpaCJiQve5mLwQlsY
x6PwLzolO/oVk8RvRTqbE4a/MQq40Rq9/Zpn+KI9EBKqf/n6pEzjoa3XujwE9MqpCHz9wbbi1UvA
dybqqPlwwENno+8NAIwqq0Ge3zjMsQKA/MVylDn7Z3df
--00000000000097a0c80649ffea4f--

