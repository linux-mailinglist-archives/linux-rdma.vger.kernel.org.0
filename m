Return-Path: <linux-rdma+bounces-18508-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAH2CA7cwGn6NQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18508-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 07:22:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAE12ED000
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 07:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CE363009B15
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 06:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889CC2D5C8E;
	Mon, 23 Mar 2026 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H849zWcf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1371DE3DB
	for <linux-rdma@vger.kernel.org>; Mon, 23 Mar 2026 06:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774246921; cv=pass; b=tomSHe4rBGh/ePMjENftwByX+hlk+t4lw7B7nSTkwqhjeayo7AsgM54E2EpTtVyx7QvP24nt59K6stO6jVVJ4BO6aKoLAWEgi7ei7h/kh/r+7MGBy33SDxbd99ninT4EAyKrl847vtjcrMwL9h3uVwSAxhBTfIRzPhobcXMzv0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774246921; c=relaxed/simple;
	bh=l73icBlLOmH2yGp3wIahxNi61vVwZOGaoGbOV58kSHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AK+0lvbSSaEEsZKsKP/Vc5IlkQv+fMqb2Rq3pdbWMHSf9zUH2FliDk7DSElek/b+hFBwKuKVhRThSkLS6La10Pm2cqN5A06vLnKhcO9JHOrLny6IEnxaAk5rC4v2cUqiBy0uRujPUgTV/gvNiJkA3nQLpnuZ4jZuBGLT93sZpE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H849zWcf; arc=pass smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-899a9f445cbso46437346d6.0
        for <linux-rdma@vger.kernel.org>; Sun, 22 Mar 2026 23:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774246919; x=1774851719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l73icBlLOmH2yGp3wIahxNi61vVwZOGaoGbOV58kSHw=;
        b=WRLCviXEoz1uMaTe5g7qNRLEMZLpxUYbfuStp44nOMdqLV6W0Czk4J1axjxYCUccyI
         5UhK0oavi5SVioyiApKrciMBmqyyRGOKhP1s50UcWqMgqiqx3yWaOxZunQTncH2TEOFF
         RKwc3qo7sralpG6afxtJ5shtUoSn94vvEjuIObsrX0jm5qZ37rGPwEVlGCGI6WuPrS4N
         WdAzF0B+vOoxC13A+/VIt9VWaOsuGxF5lCDJ6VuGI7HzFyAwsOiWwZlyY0Ct3wjLIs8d
         +W9ZOj3unrpcMZ9mhn08v0oN3GhOZw3NiiYW7AgHDsK6SQ81GdQmKqB/q+ztvCE17r2L
         PUQQ==
X-Forwarded-Encrypted: i=2; AJvYcCXC5miXXkVO3f50gO95QxwlxouldSoCueU0/svf9WLVTRlIqF/BFyBTB3aJLLMxlh1wNK+45j08WCuv@vger.kernel.org
X-Gm-Message-State: AOJu0YxdrzQpDovT8Twxr3269P95BChx1tSgVBRExG3Jmb+eLWtepTi+
	erhn5LvByyPkHB0terQ7eg3X2+BXn1bHhcBtK09o6+iLBynNrcKgqB3I8ghi3rU1ZSqJzc3oUKG
	9iZhtloDTyE7u+fKFkmkiczf8j+gti9FyMzbXMe2Kqc6BWlcm0sdaZFY6yxC8CUd/No+7D9/b8Z
	Z7mWMAT8WDXmTYQtcFempUtSgUWYQokiXSkX03+xMm/biTgdAbY9MikNhBsSVP/a4RsaSMmKy3/
	yZCFuO2z8wmph6yFQ==
X-Gm-Gg: ATEYQzxbUh8LjD5XTUaAEVtrjypQXHQ8a2pZIf9W7IjwRRJswBdurDtNGvfMQ80WTmk
	biob0ouiNkn/oTj/Wje09IropaGUsTWb5DxWQB8pffH+DiY98bbAh+V3muuPgCBzwqZ7AAz1tfg
	kEZtBtvgwgH73LMo4wONK6KRfuPqfpNwE7kl5s/U7VRUBoX5KcOF8ecYLOVSobKkbjD7WbTnw1m
	trVcBBP6vUKHMtpxkcznlWebFdq4mHX8DvbGyogmcJ8xGXxvwuvJvN86A1QTnCCMcWJ0hkd7eNu
	hBErxJHzlLxJIFTF2jK/ZSDpWmtFQhf5p+TewYfPblhpUYvBezrVHRI6IbpEy9iVxJdAeto+i6p
	gmeUH19eH/RigwHq0g/mTMkVfvmQSprLTxZK628tt9n7/WtRt3wVjNjPt2XdVrD/FJUu71L8MS0
	6Mjgt2uS7hfHGnUZ9zzCNe+hoxmtJOgr5a8sr562am8Y+kBedI11INfSl0a/dR
X-Received: by 2002:a05:6214:6016:b0:899:e545:4f74 with SMTP id 6a1803df08f44-89c859d02c1mr151079506d6.7.1774246918938;
        Sun, 22 Mar 2026 23:21:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89c85310e7dsm9049616d6.26.2026.03.22.23.21.58
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2026 23:21:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-67c258734aeso52085709eaf.1
        for <linux-rdma@vger.kernel.org>; Sun, 22 Mar 2026 23:21:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774246918; cv=none;
        d=google.com; s=arc-20240605;
        b=eGaBgjX47jnKt+mCk7wZxQxgf+fCUkwu3TKPSo1ypqO6CKKI1E1lKP5P6/PEeWvfTz
         bpjFMSq1XPkGf8Fxo3uQDrE5HYSsQwDlvf/Q3TyJVY/OPorLzF31KFoHkxf4ZYjW7TGN
         ADj63VdHcTNKJFHXp0Fi9scJaX9Rq6uNdt8MQlxxff8pQaNwwMXPVH8XtXQF57icO0GN
         dqOIVrm0J7wO/9YAIA9G5kG35L7Cor4bqgApQz2KwBWQPlrdAL10fxWrcVUjFhOT7d19
         o8eRC66WPBtLAKpI9lXdCIDNiqpwYddh9fc4K+I/cPSOnwMrSqF9WthLX/jRdDUT2zAD
         OPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=l73icBlLOmH2yGp3wIahxNi61vVwZOGaoGbOV58kSHw=;
        fh=pxCjyT1okgpyvq2RybGXJpdWvxZPwaWYmFYZGk4b1GM=;
        b=A8h2SMqorztkz9IkIEtPkdIL+iicSq9jA6XjMxqwMXvDI0iJjjw3TP1ezdUgv1w3ul
         /XQxKz/Os4ASy18sQaY6VokyGrDRyYyhq88W2Fo51HcvikS4G02osd5S9r8yTi2FIgYj
         fg0AZ34WA1NqESqlEYnfynWM4sFebnTpgbBu7j0EklxOkaJuv7Dpvr3R5HqBO4DARwNb
         4L/M+cdwdVIYofU5B/3QcRogUuASJvObxxX8BymE46dsqvCyH5JzFMtaSjytOP5vuklE
         VSPXDZu+znDfTiFcPsXVu9HJ/ckXP5VLkwAcf6RPtsY8v2WB+hTpdD5qxFjtSGVSt3BX
         tjEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774246918; x=1774851718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l73icBlLOmH2yGp3wIahxNi61vVwZOGaoGbOV58kSHw=;
        b=H849zWcfCFZYEaFx0ELan+rSa/QcB0Z/kMxT25gJmj5BZziPw2sfpUMnG/aV+l1cGx
         PdtqBnRxpoQ3Um6wvKTbOuMs7XIpSIwqh4EVeW3kRtt+B8mpd/iTq3cEhMWwIdSaD3zg
         ELVPzuVZ+WPG/vNdv1/e15vBKMBVR+hcycg6A=
X-Forwarded-Encrypted: i=1; AJvYcCUaa/lxVZVOHIGMxJWLhkh8HE3HXRw+nQYI34daHFmTgjzbHBJOB5TpE2Fb73GvwwghyE521wdpLu3f@vger.kernel.org
X-Received: by 2002:a05:6820:80b:b0:67d:eef1:bde with SMTP id 006d021491bc7-67deef11905mr835848eaf.1.1774246918192;
        Sun, 22 Mar 2026 23:21:58 -0700 (PDT)
X-Received: by 2002:a05:6820:80b:b0:67d:eef1:bde with SMTP id
 006d021491bc7-67deef11905mr835842eaf.1.1774246917766; Sun, 22 Mar 2026
 23:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318-bnxt_re-cq-v1-0-381cb1b5e625@nvidia.com> <20260318-bnxt_re-cq-v1-2-381cb1b5e625@nvidia.com>
In-Reply-To: <20260318-bnxt_re-cq-v1-2-381cb1b5e625@nvidia.com>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Mon, 23 Mar 2026 11:51:45 +0530
X-Gm-Features: AaiRm50ZjWlCsjhxzs8fINzLI80YcAoHVK2i8gXeL1A3thfMCGa6HQONR622P-0
Message-ID: <CA+sbYW3L2bf5u1mL78a4UDhCETfxQVFUeSmng_CecDDE-bHrEg@mail.gmail.com>
Subject: Re: [PATCH rdma-next 2/4] RDMA/bnxt_re: Remove unnecessary checks in
 kernel CQ creation path
To: Leon Romanovsky <leon@kernel.org>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000519370064dab0dd2"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18508-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,broadcom.com:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: 7AAE12ED000
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000519370064dab0dd2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 3:39=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> bnxt_re_create_cq() is a kernel verb, which means udata will always be
> NULL and attr->cqe is valid. Remove the code handling this unreachable
> case.
>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>

--000000000000519370064dab0dd2
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
yv6Y2FTOx/hwxSsNVuA4XfzsP3mxP3xLD93Evx4c5UIwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYwMzIzMDYyMTU4WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAXQdUNfL2bO6u1+wximO95AFi45vEG0hpBCh/
1yRBR0r7j+/kNCtrraAUV1b1QE03RawH3fRUB5Xla6t2VTVRYRz+k7/krVgCe2Sq/TucZ/u4e58t
0DKisw2GW20giPBrw3aIFWy1h2tBLHKpXXzoSWBpoYtz8KhpIGyd6cgaGpjWi5jX0MgXLIMxjMsF
OwdhQszDpryBb7tJJdVQEM43CXa3vbR3EdU2Xt9v5BhXrTBAD6uPWLL72cWdX39Iq1wsY2TExYRi
xZH0nfQnixQ/NBLb8/vvvFE6HcnvbLoUgXh8g1uPMON4K6lcZY3TAEJuVIesb4Lt8LSOa9OIVZYI
oQ==
--000000000000519370064dab0dd2--

