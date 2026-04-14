Return-Path: <linux-rdma+bounces-19339-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPnJApZL3mmwqAkAu9opvQ
	(envelope-from <linux-rdma+bounces-19339-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 16:13:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0843FAF16
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 16:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FCD830D6515
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 14:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805A83E716B;
	Tue, 14 Apr 2026 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VmrtldXI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E173BBA15
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175627; cv=pass; b=D+EI8o8geYOKZWSpnwcwpBglrSTKNPhrSS61MVyxpjqLfIpVxe8K9G11RvHE+/JuHmeX4N/G7Bncv3j4o6Pb/uJUmahrFNs2KhfRPu+XfuRHKixjcsr87gEO/mYXU0hvY4aQXmaylxAQmoLK8I4xtqoRE9xsnEqEn+LHFXO5Djs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175627; c=relaxed/simple;
	bh=CNsSNh3ouuDU/UqtCSeBdjlUVob+jpoMjCA+B8L+Qf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsuXOJdGkp8f6bWCJ6EUg5HZXXCLdhbr5wUbRVkwL+T2uaslgmAwYCHkuBIGTpRc8GuuZobELnTplDCJ4wH4rcP8D3LAoGL/jgs5857MtoBIuNQ89A09hls0vLRvd6HolqgDBhtcB6PHVS2Eifm3TDLcnONtxbAQWzBvsbAaILA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VmrtldXI; arc=pass smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-89f87257904so46072356d6.1
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 07:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776175625; x=1776780425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNsSNh3ouuDU/UqtCSeBdjlUVob+jpoMjCA+B8L+Qf0=;
        b=exFV4bBn2rlwjCdgPvKhK3zsMiWqx0HcsvebJf7qCg0Rj0laLwzLdf6Ie5DfoC6Bz0
         T2skTQsCf0WpDoMP5RD2wVPncc6thXP1dLAFipVlxK6KkRHHdfKtZlrdh7qQZcq91z81
         Nh2z0tPwfGSjuTc/bCKK7oZnsfJHptu+38gQSkjjDc4RoF1G3ZJiy81oQH376YjbqORM
         2MG/FcdtzPjglem5vfhRopxELmcQZfYT3I+mEEiV/kb8pmfb9IwVGHNmGePmM1JP3IVu
         ks4/yeHygPJUzxNLIi0m6ffBABzoCK4KCIpgarSzstdcz7RI9jnjRCpKMcdHhaA+CWOs
         loZQ==
X-Forwarded-Encrypted: i=2; AFNElJ+/L4uHxIZaxLLPTvuy7vi6eForjc/aYgFdFBKj+y395p/SDiLpe8iyf+OEda9wIJ1ht4TPvvl6zSBv@vger.kernel.org
X-Gm-Message-State: AOJu0YyMAsnUrOnvr4H2NdNVpeFGMoZC/dskoXpJIewATyRIcWqc5wj3
	nSsjoq7tYpOedLwxwSYousC1DOHOI9IhO9xVdq24/bct5HDWozLgBreSakO5K5yVh62fiLZ95eQ
	8ykn/0w+xZFASVceySvcfECB62UXrhccug0HT0A+Pq0bfxiymikbIG3sw+fEE06HDLZxXyW+16i
	bksVjQaAPvyU9hUvHAYbE3/WtsoDEQEuQOI+yJoLZfir2XhKsMEX+/HnUz+gWyipdQ64EQUv8Y1
	H7zTM/DDGnZ5/3zV9DsVEhYU2SY
X-Gm-Gg: AeBDievhsqwyZWPwIXANeYLKE498iHoIIyrIWSaiUSVv1O35OZZKZ0MGPMBdo9TXslf
	8xkzjj23i00Xi7sm9/sVPQ3tQLKbkCBbsXVIUFkVfZL8vOKkoLNnN0wL/1vMdrdm/1jgS3r2rch
	lL4mmu7Z+/HMFR+eOuYMxITbajNNnLAefMb/zfT2/fPvilwzW774vylCA7x5R104OtJjk0hi4mQ
	X0jffjx81tfloQrzID6x9uxJnxfLTAdIj0F8jltqo23Ndh/XxM6L2rpCDu2qLG9+SIHJdFxiQAF
	N56TakkTbGbRxpLZmY42/V0b4sbyqZn1rmlSSA9oalwYTTqHDZBHy5gzKmvsW1QwckTNf5gFduw
	fOuUDXunFWV/qiQ5kOz+oHWlIiDTBTp/XiSqJrYioKsmZWG/tIOJUd2rdSDxSyUnLR6BKzoDElz
	7yXGQOk6ZNlCgkLqzeukZaFmn2NTHOP7e1/QGNmJDcL1th6iySQKzlBFAE+RavXPro55m4
X-Received: by 2002:ad4:5d4c:0:b0:89c:4e50:1921 with SMTP id 6a1803df08f44-8ac8625d1a9mr272495686d6.26.1776175624837;
        Tue, 14 Apr 2026 07:07:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8acadd535b8sm5047306d6.27.2026.04.14.07.07.04
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2026 07:07:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488d8deb75fso26947565e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 07:07:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776175623; cv=none;
        d=google.com; s=arc-20240605;
        b=eRyoEyvkh2VNMDxj3ww2tFDpu7kdti60Z/y31AyTDk50S9NJ78h3712Oeie+D+Ryjf
         7tAfvByH4PqKF+wI1CvDUNbgL8Rc1w4Dpm+W/y5nQl9y37kZO3ESZco6n7fsBpMYrUIN
         xHjLF5Ft2rHCwr7C4DDiD4I5JdsO8pPBm/ZjbXWyfpByI5heTeVeJB9tru4BmF1cTJBT
         s/0nHkWT2Q9QssHbWLKEO+Id6hDEZg9sYQNpwS6ZoXqqAVbLO1iIG01qa+Sef67N+aPv
         MV+k5pv/ar5wdQLA52ne0rhTKIMN3TE4VNOT0CsMkot0zbOum89DwNMW2QiCQQES8QEQ
         Jwxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CNsSNh3ouuDU/UqtCSeBdjlUVob+jpoMjCA+B8L+Qf0=;
        fh=K9BklThT70RHG8aUq5hrClCI2eUAppBjcn3tR9wWqOg=;
        b=EJf60UOhHrky4/4i3tS/Dxz6ipmxuiY1dH24mbi4788jqlI55sufeOkwsaWN+LQgyj
         FQn0Mlk2DKoMl9PHmOnB03uIZjRYWxPvOLjjo2iB5U+UdMLHW5lChUUIX0/hcPwdCze0
         FnY5Tan2tQjMhUoA4eHvCxOzESfAMBWn+8AvsZW2K9TLitpFdcHNU6g8GXg1egog/c3b
         q7tm0BifUvtK7JYf1yASyta6LOuDm+53F2I0GK52gIQN+SKsng+qn5K/okNTiKIaSC10
         DTB7zOr6K9V4mOjOH8liiMTQXLfP0XZrFtsjFs/cqYidDnKv5G/FCBTnBidjo7dvHooP
         2JQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776175623; x=1776780423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CNsSNh3ouuDU/UqtCSeBdjlUVob+jpoMjCA+B8L+Qf0=;
        b=VmrtldXIFtXxjTOO+Ks+P1wmwY7otGtKSRv1cgWC7m7jtcISvzIY7RchyLVxDfinXS
         eBm+elXCo0lhUYJn18VS3RE0GRrvFQ8wEAo1Zo/8mnXx3rS7HF28X4UUOgkVzlkXShK0
         pZ7vcdHU+Z20vNDh73jlwTvEbSKJQ0463WjT8=
X-Forwarded-Encrypted: i=1; AFNElJ9y3F7cITw8xJGjtAThZ7/J24FSioeA732vLTxHFQyKIN34IGf2EWBMG9EtYcNVMCOxdknzbDCTyzqq@vger.kernel.org
X-Received: by 2002:a05:600c:5397:b0:488:b8bc:6a32 with SMTP id 5b1f17b1804b1-488d68a4765mr258716495e9.23.1776175621494;
        Tue, 14 Apr 2026 07:07:01 -0700 (PDT)
X-Received: by 2002:a05:600c:5397:b0:488:b8bc:6a32 with SMTP id
 5b1f17b1804b1-488d68a4765mr258715925e9.23.1776175620939; Tue, 14 Apr 2026
 07:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327091755.47754-1-sriharsha.basavapatna@broadcom.com>
 <20260327091755.47754-9-sriharsha.basavapatna@broadcom.com>
 <20260410152752.GY2551565@ziepe.ca> <CAHHeUGUwCBjho3oJLJdOeTSF3cp1U_DYsN_satsCo4_aEKLWOQ@mail.gmail.com>
 <20260414123434.GX3694781@ziepe.ca> <CAHHeUGVTsMSCrVQ2uSa4_1DfctNYL7Cy2y2QRPF67nW0mPFXzQ@mail.gmail.com>
 <20260414135438.GC2577880@ziepe.ca>
In-Reply-To: <20260414135438.GC2577880@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Tue, 14 Apr 2026 19:36:48 +0530
X-Gm-Features: AQROBzDoU0d1x7IMp28L2j1AEfN2NOSB0lF5OL0cRFvv2PKvM9f0fYL_vIoJouM
Message-ID: <CAHHeUGW_be95eHW55tFszfC753Zp2sJFJA781ywsXtSD+6XArQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next v2 8/8] RDMA/bnxt_re: Enable app allocated QPs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000192b34064f6c1dcf"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19339-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim]
X-Rspamd-Queue-Id: 4D0843FAF16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000192b34064f6c1dcf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 7:24=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Apr 14, 2026 at 07:10:41PM +0530, Sriharsha Basavapatna wrote:
>
> > > Yes, and it's fine, you added app_qp and the only thing it does is
> > > check that userspace set VARIABLE. Why?
> > No, app_qp (boolean) is used to make other decisions too. It is passed
> > down to other routines and all that logic is in earlier patches (2-7).
> > This patch just enables it.
>
> So list what it actually does?
That is described in the commit messages of prior patches. To summarize:
- update rq depth
- update sq depth
- update msn table size
- update hwq depth

Thanks,
-Harsha
>
> Jason
>

--000000000000192b34064f6c1dcf
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCANLkA+ajn1kV8of3gt2sUs4mT7opzaahdl
3k9pVsrKcDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA0MTQx
NDA3MDNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQCLpuigL+TYMK4nNTVHD4Ryaq8Hwbqjxf9zFbU1ho5NkNOmcE2CphnVM9ZnGOzUWkanhtm5
TPtPjilF6aqe4vb4UAY/0vdIfO1ciKLavjLlv3Yyk/bVehK22O166os+2A6IO2lZnxkJx7tUdJnt
J+2qKGEfahaF//ZKPsNbKaWIhQkheSz97zohm4hsvsFp6l5lV5oyraf7kvvRyK/HeaGGe27kRU/+
YAIcAs3Y2QvfxOY9DbBGO2jQeILHMkfnfXpzUtogsD3DDxVf+0eWROEmnhzdmq99qvLs6c4jycJz
4t0gC8RWXcKLRkUZcL/Jq2POpSKXSrAoTY6keHVudvmT
--000000000000192b34064f6c1dcf--

