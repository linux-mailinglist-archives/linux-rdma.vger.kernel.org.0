Return-Path: <linux-rdma+bounces-22067-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ju8/Fr8DKWp3OwMAu9opvQ
	(envelope-from <linux-rdma+bounces-22067-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 08:27:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 567A86663D1
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 08:27:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=T3WEfExr;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22067-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22067-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A7903196675
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE95F37205D;
	Wed, 10 Jun 2026 06:20:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com [209.85.222.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E14833F58B
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 06:20:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072401; cv=none; b=TxjO6rRNh8cbtUY3UirhCvS0vQNriUvNsVrgKYDwYHcTNfOmoJwdpM7CHQQ0mKZaXs7sjthY2ipQAlyc+pZtEMB2fSegyPUf3vtakfZk6sHwg9RSKsCzbQ3rHnw4pABdvXZ32EVebKQ6+MuTcSCJZfXwaYVp9ABiYjVMZ3pZtGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072401; c=relaxed/simple;
	bh=X4uKoK7hRcAm7o5+TOwJ5vxzEVIpy5ayOlqL9V/AOY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/zj0ejRmdQSHWSuRk5t42RU8cZrSmW5KtDPkPWGS+J2KTmsUe3y1Sk834Uh6kXt64NDzQ5+Dp1TbUNDQX2olux3fMRH32XyeFbzf4QqhGmF5hpYq074fy/fpMsEvnBgFFWvOk7x9okUpyeVWol4Zob80aSC1gi+6HUwGw8Tnp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T3WEfExr; arc=none smtp.client-ip=209.85.222.98
Received: by mail-ua1-f98.google.com with SMTP id a1e0cc1a2514c-963a722ed59so2073318241.1
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 23:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781072399; x=1781677199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAozmO1nn29jjTONm0jXMi0RD/xB6Hh42P/gfPhXLcU=;
        b=S8vXWKYtwM/qDnt2FEgSxRj97kzlBZUa/S7+bimWjT54IkWU7vHtqOjSz8QYPNsjdB
         DGaY1YKUwdOwih2mnRR6sDEcwGFtJE17pu0TmuIIwl055ANkGYISJ/hqKcsrZ23dsNRn
         gTHF2Y8r8eD9hBvUmvIyhHtWNoJZQN8YZ3imsUt/v4Hwy1qMCgUmYosYmtUPvMpzj5Ke
         DqSfSIAAPFdsb+N1Plu47YMyONEiFgs8etMwDpVwj/0t2lzTqlojffXHnIGUA/zH+c2J
         KjE8aA60JIARzT7DKPxiKCnkzCCFL119mc6w9rP0M/6IewINF6XjaKLxilgHJk7y+C6T
         jDQw==
X-Gm-Message-State: AOJu0YzNyJlqXvuXZTrV1iqRgJqc+uvU5ha/hwkL5uuFjBT56TdEeLSm
	KPqBzkfpZB7T/OBbPCu6mAylEajIAQtvgJRfv4KW9DYFt2jtAMH5y6O2O/nrmfJSFlSNtJKH0ji
	HL+/fXYu9ZVr+JQ+7u5OYgCPrH6ALPkWMuJReOMQ9DFAjqWoKEceLMFFBPJq9+IXpWDEbA3uRnw
	qNSOVsu4yz5RUoQlnRGl5pqoU/Vb2UXQ4xH6PTXbOMeDL5TY0QS48xYNPVlrKl2DVTKc+pVEU2h
	J9Jd+bTWJP+9yzQAg==
X-Gm-Gg: Acq92OFRSRU3chqFzN3CENtJ9l5fCHp5k5Idl0KknxZhnHEQNQjMby0cM4i710cedek
	ZBr9KGDCTdSCOagLpqqgTaOkC8cdhUBGcISLpRqHzbnk620rY6KRCOWAKRqr7820N6Yq1F7MBi+
	y7rbv9Y1gwpKjrM+FV7V9sSvQwAUwJyluPHfpL3o8HsWK7/TwbZpzKLl1DJZwtQ2lOQPPNO4rtP
	wPqg7Xn4f2/INnw1DR0MKivKgXcroA40rjxlbvraD18ljoTZyl49KrO0ZbA7lrpsyhDCVSqvOdr
	menhZjsENrffdl0uu8CC94ZtDl7yzmyFGNA/51Kf0tZ2pZZHbIb3IVKPKuya0BhEseKTe0X0oMS
	wlvhJp50VOPPmZ6Pn5pqcX1XovINA5FtIrJH5zuZHfj9it6I+JiNnyrIdT0aQ2CAayTz8knM11f
	ih/dJZVBMGr/1Bs/GIKXY/hcxFKkma3GZlP2mtOTgZQpvfuWnj6ro8luythTccqjj/e6JK
X-Received: by 2002:a05:6102:32c3:b0:631:3b92:9dcc with SMTP id ada2fe7eead31-6ff14b25feemr13037018137.27.1781072399030;
        Tue, 09 Jun 2026 23:19:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-6eb563006c8sm1445954137.11.2026.06.09.23.19.58
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 23:19:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e6b550a521so7100388a34.0
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 23:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781072397; x=1781677197; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eAozmO1nn29jjTONm0jXMi0RD/xB6Hh42P/gfPhXLcU=;
        b=T3WEfExrMbdf7Fggxx5yjetnZX6QLLdRxpvEFVHvdb2GjB5b0uDR8A1jcH/fpGY2ff
         omcE5nxuNKyziPYt3Uf+/gayvqWfl3RjHIy01Qrsv/Pdc+J9u7Rn/c14+KtWqu/ETExX
         0WAqi4cuDbm0Le7iPGEzjojg6TIBCV9jtY1kk=
X-Received: by 2002:a05:6830:2781:b0:7dc:da80:42b8 with SMTP id 46e09a7af769-7e70ca13f4emr14238086a34.18.1781072397615;
        Tue, 09 Jun 2026 23:19:57 -0700 (PDT)
X-Received: by 2002:a05:6830:2781:b0:7dc:da80:42b8 with SMTP id
 46e09a7af769-7e70ca13f4emr14238068a34.18.1781072397178; Tue, 09 Jun 2026
 23:19:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610100855.64212-1-selvin.xavier@broadcom.com> <20260610100855.64212-7-selvin.xavier@broadcom.com>
In-Reply-To: <20260610100855.64212-7-selvin.xavier@broadcom.com>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Wed, 10 Jun 2026 11:49:44 +0530
X-Gm-Features: AVVi8CdVdnwa36of2MWKyKx1brTU4YEWKQfjXviT4AkGK4CoQLu1x11NMD4Va58
Message-ID: <CA+sbYW2PcaVrj=pRQVa7+xZeJf7oV-BdDP3PEBfC6gh7vBodvQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] RDMA/bnxt_re: Avoid repeated requests to allocate
 WC pages
To: leon@kernel.org, jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, sriharsha.basavapatna@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009923b70653e03b2b"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-11.26 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22067-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:from_mime,vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 567A86663D1

--0000000000009923b70653e03b2b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 10:16=E2=80=AFAM Selvin Xavier
<selvin.xavier@broadcom.com> wrote:
>
> Applications can request for allocating multiple WC pages
> for the same ucontext. As of now, supporting only 1 WC page
> per ucontext. Adding a check to fail the repeated requests.
>
> Fixes: eee6268421a2 ("RDMA/bnxt_re: Move the UAPI methods to a dedicated =
file")
> Fixes: 360da60d6c6e ("RDMA/bnxt_re: Enable low latency push")
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/uapi.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw=
/bnxt_re/uapi.c
> index 0fceaf52bf4d..abd8f90ca0fb 100644
> --- a/drivers/infiniband/hw/bnxt_re/uapi.c
> +++ b/drivers/infiniband/hw/bnxt_re/uapi.c
> @@ -99,6 +99,9 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_ALLOC_PAGE)(st=
ruct uverbs_attr_bundle *
>         switch (alloc_type) {
>         case BNXT_RE_ALLOC_WC_PAGE:
>                 if (cctx->modes.db_push)  {
> +                       /* already allocated =E2=80=94 one WC page per co=
ntext */
> +                       if (uctx->wcdpi.dbr)
> +                               return -EEXIST;
Sashiko pointed out a regression about a synchronization issue. I will
rework on it. thanks.

>                         if (bnxt_qplib_alloc_dpi(&rdev->qplib_res, &uctx-=
>wcdpi,
>                                                  uctx, BNXT_QPLIB_DPI_TYP=
E_WC))
>                                 return -ENOMEM;
> --
> 2.39.3
>

--0000000000009923b70653e03b2b
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
vqLDW9zd++9WHJZOswWeMB7dZXNn9o1qOyAskWwuIEAwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYwNjEwMDYxOTU3WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAgVmplhGqYnTUT4ZgMcruRQ/kZWLH+ojoZNb/
+R4gswoowrMpkUqyhEtimvYfNkAUg4Y5bLvm43xz2zKbzoc5HFiVs7XVWxpjLoQKlT4eKPMzoqvr
gwnVVchxiSfhG3fOqMXOkt+8ykxqsiBcfVKgFziFQNQnTKF6dx/Su7cN5XUGalyALMRsNhM7IFYQ
w9Qvl7hy0nNAZ0Wc4e/Xl2G/4se74EMiMTnhtzkrlxzoa5HDi1eI7of5MvRzg5LND2A5pWHXwOOj
Zirb9qi7fME/FRyqOYdOCh8sF0tgM5zIzOfXSeruiRp7Xkmf4FEoiSqHwg1jniUIWDMyON7V2Vwt
mw==
--0000000000009923b70653e03b2b--

