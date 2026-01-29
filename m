Return-Path: <linux-rdma+bounces-16177-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gId9OT7vemnn/wEAu9opvQ
	(envelope-from <linux-rdma+bounces-16177-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 06:25:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F35ABE7B
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 06:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B5183019CBA
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 05:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932732D9797;
	Thu, 29 Jan 2026 05:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K8c4loth"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f227.google.com (mail-oi1-f227.google.com [209.85.167.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31492C3271
	for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 05:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769664316; cv=pass; b=hVUpl6ePrtog879vYTtsMTrWruqLhW/G6Qg/nBR7gHlcF1e/MK5hXKcOzZboCC2GLXSIA95j2Yf3d2KqvB8vM8Iqz7njgnZQr3VkqnbxAjCCrxOhTdPS+qhSq3/KNn4fdfAZ14NtAllEUVj+qC1s7AMiuyDMYk7RiATJW1OsM8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769664316; c=relaxed/simple;
	bh=2ANJVac4pnHTLD1zHBMPHHpCQwz5km7ETDVLavOafRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IS9wH+vSpfNSWFEEdUwj+jVbUtl2L5g3CMdxuJnljd0OmYOmVb0nQxIqX1ssFTzOuYBJPE0gJ99loXwCL/oduV2Cz/0LJl+uyZKE05MWE3ZNY0r1w3wUd3qMBskqmPWal7MEiZ7ya3WZROjp4/TsmbE8yauIJWOsm03AFwcL6zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=K8c4loth; arc=pass smtp.client-ip=209.85.167.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f227.google.com with SMTP id 5614622812f47-45c87d82bd2so405742b6e.1
        for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 21:25:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769664313; x=1770269113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ANJVac4pnHTLD1zHBMPHHpCQwz5km7ETDVLavOafRE=;
        b=c/H68doXExfPwlrNo5CjYjp2c+PA9NqRpIV9MnCqhITzTZQFL87aVB8yQxXNyCLvKW
         SJZIUm/o1ToNWDWBmlGnOZQXDAxFfNdQPpanN1gUYwE7qAN39x8P1B2C2+3eOzfSk3bi
         FC4krum428YkGXy/iORUpCDTNIFb/lkYYtdAxJeOWjiyxFEPet58N/WBCwiU4TZPbI83
         Yiw+oEzdnZM4RFWUbAPoPwg4k25ZWPCa58pCwc/hjIbth4mbBPAls3EJsoT2CTD0sA1i
         HRHbe7LDNZxW5zgtkLqbpKLV+tsUerz4N88N6ffLoiywjE+FqxASCPiOpwhQK0pQBpge
         OqGA==
X-Forwarded-Encrypted: i=2; AJvYcCV5GfMlZxt9VOLSywvtvEErszhHLWh19/ZxgZ5vivoDF1dcA+PVTeWp7sx4peU+gyAZw+WI65SEA0KB@vger.kernel.org
X-Gm-Message-State: AOJu0YwDf/cTUV1Z6VvT0r2AIO/9MWBTqOn0/Bl+vuOJbl2RSDmppzsQ
	GdAa5BO9XrJfhrTy3BknFC5Ns25sQw5YsL1z9JBctMLzgWPLHrHjKYHTt3wcfTGuKa/r8DZdSQV
	/Frf4NzA0k1FcOJJH5ALuXlTlT725P27AlGqILJ0hwSoyb8Uo/DXpNQf3YBH40fv5dB3zocXiQ1
	hOk5JhReN48etk1EcLi1h98K+Kf50ytadXaX4dk0Ou/7czX663YydWTmFL7+NgkD4IpnQpissb0
	sSSxNn8fppuMFaJFA==
X-Gm-Gg: AZuq6aKjP22vLwehg76eMmDStGWjLga7ktt6G5xq+kjJs7gY3Xw2lIM40Slh3Ne7OcP
	NQLd2fgtQ6zEh55YKiV2f7qF5sPoJ/3yFiDK9ie85eTmTtlS+P9v8ZGodU9MzP3W9jPPGaE+ERO
	Ds5ln0pIAcdAmpBLcvbVRwsGpy4eFw8UJIaHexw7xv4Q+sd+Z9uS8Jqj5K+J8yTqdI+0rW8v36z
	LIlSPMYyj+9xAHTeufHa8ADkXUodfcSLt7xz3hi4fDqF4c+GWP5y4S2zccBfbEKDCiEfbJnORIB
	vYvcZIeMf86r93+eJNEhAbXGXasYWSjE7/r4h9a9R+FxZCdR0aT2RtD5MLLP7KPXdTAYLHQvjVb
	ZwRpef3no07md2YpCq7Pg168fgELOAXvavgwQBvm2uY+waIsP5OVT8o8mdgUXS96WpjnMaCPJxi
	pYfBYaU3MBdWQk2NGqJKZ5+gJq/iC6Iajdh3CehFfE33U=
X-Received: by 2002:a05:6808:190c:b0:45c:95ab:bce3 with SMTP id 5614622812f47-45efc6b76f4mr4034953b6e.46.1769664313328;
        Wed, 28 Jan 2026 21:25:13 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4095712337esm448101fac.4.2026.01.28.21.25.12
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jan 2026 21:25:13 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-662ff11fff8so2454855eaf.3
        for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 21:25:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769664312; cv=none;
        d=google.com; s=arc-20240605;
        b=eGlcD8wb2geDH0C0U3ztH2R9LelAy5KCB+FFvIo7OYHjOxzP5hUv5zzmo4Z1ozd6D0
         V1e0mbWCQvro/TH4y8Gd+rQJfz8I/04RBP9j5rEG9+EjBD+4pVVcK6BCcgbaOoSE7n1T
         c9uWyYcDuojpexbQ3AaT0ABW3cmslRsOvC956RLZurRS2/Z84j3GA/Lq+X80gPBuRUxA
         oVjdGHC1MvjeYADnbIyA5tib2LJbPt/8k/4hQOvsO869ETvHu+plyKU97UdZEpCzunaw
         lcPKobUF09XdlE7tuq3i4zhG9/OmhglyqZ20sckIOuoXBZTAO0/oAZPs39P3CVA8m6R+
         2cGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2ANJVac4pnHTLD1zHBMPHHpCQwz5km7ETDVLavOafRE=;
        fh=MS0k80kZC9JC6w+jm2zEkSz/f87YWxBHxFSWxrBGhCY=;
        b=fTWLDfMwEtKeJ62x6D8YrwOv2GV1ihmyJ9C17KqfbpTHnMjpJX3wAbqfE4Z7K4WzHs
         KnkaywQhU1pToh8TmNzi3KTalrfjGCbFfbQK62+KaiO9YkiewYQFjOTx6FMqgfsIF7QH
         ThQE8IClQIHdXte2c3585q8fWj/v3iB5TzajITqsQNuQdQKVbUaZr6jJ9SaV5Kh19Q2o
         h8nkv/1qnRc/it5HbXqYC/mPorJyoEPWCZ+Bgi2llRm4Cl6iddrj/Un6xecqvK0yzEQo
         gE8soPqKzkiIhTj4UgGpkYvXUHwSpgg8HrKXfAvHnFFArHrsSeae4X/W4pnZTEDazP+a
         Q09g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769664312; x=1770269112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2ANJVac4pnHTLD1zHBMPHHpCQwz5km7ETDVLavOafRE=;
        b=K8c4loth4wGi4HY8D739ByVBPE6Q/bLZcXHRaKD2nTe2GC2Az4eay/9083wdNnLcgC
         5Eaj8YljUSY1NOMsRRCZTaLqW+iRDDwzXvRxUSia7kf+mzGCwxq2M2ADc84T+upOPGb4
         ViG2rSMNHkSnHKzdoAFcaq0EkW3Py+naonp/I=
X-Forwarded-Encrypted: i=1; AJvYcCWb3nEkHZ81j8dSqS4xJWZ6iLAuB2fIAMss1H+1eyDmugvX0uJ7hJe8G0kP6vHV2eTpqB23PFKITcRh@vger.kernel.org
X-Received: by 2002:a05:6820:1610:b0:662:ca8c:4b6a with SMTP id 006d021491bc7-662f20d334fmr4587267eaf.56.1769664312316;
        Wed, 28 Jan 2026 21:25:12 -0800 (PST)
X-Received: by 2002:a05:6820:1610:b0:662:ca8c:4b6a with SMTP id
 006d021491bc7-662f20d334fmr4587260eaf.56.1769664311951; Wed, 28 Jan 2026
 21:25:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116091808.2028633-1-kalesh-anakkur.purayil@broadcom.com>
 <CAH-L+nNFR8broz0i6ddQPrGL38AO1ZVaSRdXe9AcEafT3Sqeaw@mail.gmail.com>
 <20260126201857.GP13967@unreal> <CA+sbYW3dLsVqXcaG9xYdh-YRpdf6-ZjrMKRCBnapMY+gFzoA2w@mail.gmail.com>
 <20260129004038.GA1641016@ziepe.ca>
In-Reply-To: <20260129004038.GA1641016@ziepe.ca>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Thu, 29 Jan 2026 10:54:59 +0530
X-Gm-Features: AZwV_Qieg0Y28i7IiAg8jMIwyayk72KIRDd8ZXOpWLgQcrvXBis8h9PNZqXNLAQ
Message-ID: <CA+sbYW3JTSoZ0vnO6w_89zJXDv8HK6PCG7Yh5ZxbMD-7iVxKsA@mail.gmail.com>
Subject: Re: [PATCH rdma-rext 0/4] RDMA/bnxt_re: Add QP rate limit support
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, 
	Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b935140649801498"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16177-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:dkim,ziepe.ca:email]
X-Rspamd-Queue-Id: 64F35ABE7B
X-Rspamd-Action: no action

--000000000000b935140649801498
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 6:10=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Wed, Jan 28, 2026 at 12:33:57PM +0530, Selvin Xavier wrote:
>
> > We have another question. Existing implementation of IB_QP_RATE_LIMIT
> > is applicable only for raw ethernet QP. With this change, we will
> > start supporting for RC QPs also. So mlx driver can also get this
> > request for RC QPs, but it will silently ignored as the QP type is not
> > Raw ethernet QP. Should we fail the request instead?
>
> Yes it should fail, I think that is an existing mlx5 bug
For mlx5, ib_modify_qp_is_ok would previously fail if rate limiting
was attempted on any QP other than raw Ethernet QPs.
With support now being extended to RC QPs, the ib_modify_qp_is_ok
check will pass for RC QPs also, and hence mlx5 requires an explicit
failure now.
We will add this check also in this series.
>
> Jason

--000000000000b935140649801498
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
aJbHXHEH9SpIH1hdQyyG8DEt9kUldhP0Mg9WLypqG64wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYwMTI5MDUyNTEyWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAmWZeLXUUaT3rPoAXk4r8waz077+cNWzrxzBg
UzgqmEAyIhpmpKUyQ0+hcGVgqKX3Bjv90prz23NMlQjiWZyMlkk6W6X8VrppngXUxDj7V97v08je
ZmKpuIqUTtFnY7P5yhWX63BcHYJAl8XYBIXljOqLEYC+UIJA7CMPiwRU9GGoLez7AV+gFeZpXzo4
3XmAUhmLzFUnSybO9GAQ9LuuZNTKL4xAyYRWWESsBnzsNlahCT7H4suTr1UUH5zKaHxSldpolRve
J6g+WtCj96gN8r60RPj2s1Gb7Y8F1JIy8cjkODZVSVN1cPghT7dG8Qg9A/AaH7blGyZJs5spovdL
cA==
--000000000000b935140649801498--

