Return-Path: <linux-rdma+bounces-23176-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UefMIHTcVWrouQAAu9opvQ
	(envelope-from <linux-rdma+bounces-23176-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 08:51:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE11D751A78
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 08:51:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=J1sx62+M;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23176-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23176-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A105630422CE
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 06:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08A23DA5C8;
	Tue, 14 Jul 2026 06:51:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f99.google.com (mail-oo1-f99.google.com [209.85.161.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD9A3016F2
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 06:51:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784011875; cv=none; b=t5p2XkaXo/8eToRdFl+eYH7ouB3jCaWqnvPFxoQVswkbTA1zOc4l9QoOc34ZMd0xvJBaJD2t45Vm1WQnWbRTDgNgVlyljzjx9Skx0aqQ0S46D589AqPSohqo+nUSqU0DZzxnCzskBZ5z0yYky/kzz6PIy1rx7eaU1NqLsb5KL+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784011875; c=relaxed/simple;
	bh=zzZVfH2VJ71sE+Q4bqobUCgqT9Mg+NqMIEp0uH8HV5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pp8B9jRAEE+q63yZx7eRKKr6O9QBGLWt0y83WPPEYW5DfhStFtLT0GrPYOjEqLbW0Roh7w4200jPBvRnNMz2+AwwP6ulETPuF6OzfEod+ACvo6+iaXAf6fn24DH36hnrFpKj8IV3FNt0ZNRwDJLypUgMsFJFH4D71a2BRNnFlq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=J1sx62+M; arc=none smtp.client-ip=209.85.161.99
Received: by mail-oo1-f99.google.com with SMTP id 006d021491bc7-6a1888969ddso2284072eaf.3
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 23:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784011873; x=1784616673;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zzZVfH2VJ71sE+Q4bqobUCgqT9Mg+NqMIEp0uH8HV5o=;
        b=PyX9Xe9W09hn010ZDiKBJb7gu33Q0nIWUtvL1HOXOlh+lcioVbeh997NauyXp/n15o
         +VYqD4mZNT97rib1knRLtqW3bBLX+KyTejLqLBeMqVabVCJ0y8gwi+3gOLskZUFE8Iy7
         3E0nbpfvo0EUv51lQ0GUt6DaukHMvrX0NViqtkkKW0zd+Le34iiyFdN/GclCtNMcw3N6
         2k9hGWjLtqdmiOt/iwFSt/PIoLMXYczPhZBDeMuxSBVBx3DtqP+xk5ay/ycRFDjFMJFm
         xVR0kIXeFQa15PWJDfWBC5GrRn7bSBP9a3b1uv0p23jyYxRNIGF5+8F5slpppDt+q9UM
         nlyw==
X-Forwarded-Encrypted: i=1; AFNElJ90BM0QI7XUx4VE+Z9T6RxRqn04sbMXaeYwFmK3tgGe6xBll8mrbn9Itx8fGl1f1AlT4h9N/o6M3/2y@vger.kernel.org
X-Gm-Message-State: AOJu0YyG9bMgGCndnqid1zRQG5VEGFbYziB3uzjHjbrbwDMQh0mvrLUm
	DzcNuXqyXT3S+zwuIiQNCAUuVkfuDayrXCCpUJfhSluIjoR+qjtd53eui0QZzvhW0yiaWKEIR/a
	ERI2DtPN//PjHykK3qXyt3GNeHgSWbUvDvxjm/R0mYkyg2/ay3DG3HH1u1x/5QhwcxQC7ul9/Vd
	h/UlSmEgSgc8ElWzXf8pfIakxupHku4kc/IjW9G4Lhd/QTIFx9al1UI7uxgrQXQ6Kq4ijSdBDpq
	7WRVfDDvZZIj4JYBg==
X-Gm-Gg: AfdE7cm6ZaUMFU6/ka3Eae1uqrF4DUydfZdTLNJdP/DNJGoZSi3gZgH9uuBQ+4/+FS0
	bJHOU4E6b0LaTwsnfL7eZhwYUwxTotFKu85nfI1nxPtPBwOGbHoWbNn3qPGv9gBIHK4uYjP2N1k
	P4QPQDXZjzKSzz8RCBGjbYcP+L1HDel+SV42BDyGZgl5NHZXtv+VFMF7bhc2Ulbp4P1ZylX73g1
	VisNDAH7lHqPKlLuq8b80cf8ur0hZ2cXUgeqZ7VURK6+Vv6vIvrwZ5cNDRg3Xc17gu+b050mHXN
	djX/bi52UMuPMLP20l+UzbmMkYBMzZcMhMOoUOfqnDI/kKfdCfK41iFPd1cZcYXl+QKW8ORrfOJ
	vIhsIxpXLpaRmGFvNJbvmAh49FGYZGMSv/Y0YMF4G6X1CT5uRk+LrMZrXQ7hacXzFk1ZLKOKYcJ
	X2dEbPi5xSIHhOPioF8nuMhXzMeyHigYmIQU7Jcg8mrsO+vxg0lw==
X-Received: by 2002:a05:6820:16aa:b0:6a1:7fa0:114e with SMTP id 006d021491bc7-6a3cbc0e9a9mr538219eaf.64.1784011873177;
        Mon, 13 Jul 2026 23:51:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-6a38261c33csm685121eaf.23.2026.07.13.23.51.12
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2026 23:51:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-49ce04870f8so7093630b6e.0
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 23:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784011872; x=1784616672; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zzZVfH2VJ71sE+Q4bqobUCgqT9Mg+NqMIEp0uH8HV5o=;
        b=J1sx62+Mq8OaqXHOXZ6LfhdPXFA99/JNVSL8gI0oDdO/hm333XUi4Phqn1G7RRLZDc
         bMPq7snieiN7RcLeoGOI9O5d0ApGlsx/jO5IR9aQaH6kjcLmOcbfwRIXPWn2NlYNXv+q
         isZiEsFz9nqQj3VgJe4+DpQAh4oTbzIQbS6AQ=
X-Forwarded-Encrypted: i=1; AFNElJ8GlJbg5yw8yAMIxA4ptRLXAffQpso8/tdXFC4aM7PZ4+oXbN5e0HNTDuAEZ25rkvYXVvthc2sKRx48@vger.kernel.org
X-Received: by 2002:a05:6808:1a06:b0:495:fecb:bf9c with SMTP id 5614622812f47-4a47a40d0e5mr577152b6e.6.1784011872002;
        Mon, 13 Jul 2026 23:51:12 -0700 (PDT)
X-Received: by 2002:a05:6808:1a06:b0:495:fecb:bf9c with SMTP id
 5614622812f47-4a47a40d0e5mr577127b6e.6.1784011871612; Mon, 13 Jul 2026
 23:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713-fix-destroy-no-udata-v1-0-fcca2e34fd57@nvidia.com>
 <20260713-fix-destroy-no-udata-v1-1-fcca2e34fd57@nvidia.com>
 <CAHYDg1S5jpZY=CRmbcH8MYHzyV4ro4MdzJ2gAj2fhaFfQo-yXA@mail.gmail.com> <20260713145608.GO33197@unreal>
In-Reply-To: <20260713145608.GO33197@unreal>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Tue, 14 Jul 2026 12:20:59 +0530
X-Gm-Features: AUfX_mxcDvPZaBXFhUmOfS2YFyqfq4IvmVrFTDAE5Zw2_bTUXWVk5R67VWx3dl8
Message-ID: <CA+sbYW2sdsmugsAS2d9eJG0TDOrnZsfoo5qZAXXEeQCOQWCjLQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/bnxt_re: Validate udata before
 destroying resources
To: Leon Romanovsky <leon@kernel.org>
Cc: Jacob Moroni <jmoroni@google.com>, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Michael Margolin <mrgolin@amazon.com>, Gal Pressman <gal.pressman@linux.dev>, 
	Yossi Leybovich <sleybo@amazon.com>, Cheng Xu <chengyou@linux.alibaba.com>, 
	Kai Shen <kaishen@linux.alibaba.com>, Chengchang Tang <tangchengchang@huawei.com>, 
	Junxian Huang <huangjunxian6@hisilicon.com>, 
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>, Long Li <longli@microsoft.com>, 
	Konstantin Taranov <kotaranov@microsoft.com>, Yishai Hadas <yishaih@nvidia.com>, 
	Michal Kalderon <mkalderon@marvell.com>, Nelson Escobar <neescoba@cisco.com>, 
	Satish Kharat <satishkh@cisco.com>, Bernard Metzler <bernard.metzler@linux.dev>, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ee294706568ca115"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-11.26 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jmoroni@google.com,m:kalesh-anakkur.purayil@broadcom.com,m:jgg@ziepe.ca,m:mrgolin@amazon.com,m:gal.pressman@linux.dev,m:sleybo@amazon.com,m:chengyou@linux.alibaba.com,m:kaishen@linux.alibaba.com,m:tangchengchang@huawei.com,m:huangjunxian6@hisilicon.com,m:tatyana.e.nikolova@intel.com,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:yishaih@nvidia.com,m:mkalderon@marvell.com,m:neescoba@cisco.com,m:satishkh@cisco.com,m:bernard.metzler@linux.dev,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-23176-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:from_mime,broadcom.com:email,broadcom.com:dkim,mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE11D751A78

--000000000000ee294706568ca115
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 8:26=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Mon, Jul 13, 2026 at 10:21:49AM -0400, Jacob Moroni wrote:
> > These changes look good but there is also a call to ib_respond_empty_ud=
ata
> > in bnxt_re_resize_cq (but that method does take input data).
> >
> > Is that one a problem? I guess the resize could complete but the upper
> > layers would think it failed if the ib_respond_empty_udata call fails?
>
> I think that modify verbs should be fixed too.
>
> >
> > Reviewed-by: Jacob Moroni <jmoroni@google.com>
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
Thanks
>
> Thanks

--000000000000ee294706568ca115
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
fM5Vl9MQ2DUUETwdnH4eg3MBnla87CCgCfnPjmnxJtMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYwNzE0MDY1MTEyWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAXZcBjvhnllmY2IzCqJh72XwOPzl8Vq0JFMGo
f3vCFg5TwFJQb3NGdlcC7ZUkL0cZ3qMk8po9r1GgogvfdS522yR4b6Ii8xt9JsZbOhexjfzjUI99
BoOY0GqXlO42OCZw3gS1Y7q/VKhlCe6eLOghK9ZxSpleOEU1NqkIf11eYTDfkG/O+75PkQWXY9md
8W1XGOHzIFQ7wonAa2gj/2MnUijDSMyVGAmrM3GsZNtZ/aRzV9L9i68/fAqK5iKKgNrJEJb0KezU
er+DCN0YzkBHpKmA449r+GSEyQxDgWBtam7KCO/AhbI4o/VYFeQWBu1OMfgacKwGUoptC6aF3Qpq
1w==
--000000000000ee294706568ca115--

