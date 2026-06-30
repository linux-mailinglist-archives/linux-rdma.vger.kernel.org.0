Return-Path: <linux-rdma+bounces-22579-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UvXOJF+XQ2pEcwoAu9opvQ
	(envelope-from <linux-rdma+bounces-22579-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 12:15:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4126E2B41
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 12:15:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=KzMGIWgc;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22579-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22579-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7F0D300683C
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 10:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBE33EDE6D;
	Tue, 30 Jun 2026 10:15:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26CA3EE1FE
	for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2026 10:15:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814552; cv=none; b=qeQQodL5KP7lNUsAs3pkyCdXxl7vA25Z81pi7c+rQYCBbSkcTBaxbTsnarrcGwtmkNZTnsngSFG82vsgyqYxXjotALXZSWwdjwwU3bnmtht8aUvgLhuRlSYSK96onJnzcJFDDBV6fHmjuJx5UFI3P83bFGPYVvVcXOXnApNxva0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814552; c=relaxed/simple;
	bh=Wxet139kZN4sZS06KDqrmxvBpGOMnhFj8z8sFILSpGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4y43AfkDEqsSimUfqW450P+dHhnsLOkD6dbJe2xhcfCmpinaQ58IBZlKS/j8aeCTW472K7c29EXBF0MffqJBaqKSBN5AhlQYClx2m8iRNDYxdLp8IM85d8IfB07+Mbzg+j9mhLEYa1y0fzG909FRqFvKafxeJX+5s32zkuiz0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KzMGIWgc; arc=none smtp.client-ip=209.85.216.97
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-37df72c9984so1967087a91.3
        for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2026 03:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814549; x=1783419349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3hAfKuWDmESUAAzRkfnDH4k1bTCLydM/xCQa+5ROvE=;
        b=jnMefre38v4/q6Qb6FelxBYmdUvnsO3JyYfE83z3+yZs46PrPBz0hfv/+zNX3kKy+A
         kadbEcPPbHgfWhIfKVoHEBcOXLSszYKIid1gHs9YySSMd+9f9OJzx916VDeKiA4hB/qu
         n2WkqHe1j/0vrwzxvfA/6E2BTQbfWSHtxK0Ckvhv9GikEjRjypQ0X/k9DLBVKxgG/9BZ
         +GbacKaq2y2OGOtxIhelwfa+kbkvxnSwVKH7UYYvCVQeKD8B9pJ20Urhv8fOplF9OucF
         WcN2mOcdAOHiVTkFP52E1SmqIplPkHtBn4FXYAFln3kJ3/PBMCyLPUrdb7MfIsHGA5oG
         1PvQ==
X-Forwarded-Encrypted: i=1; AHgh+RpYEAPlS+It9/EsGVCDzo0h1eDkeCgOEE1Cb13IwhfLbyNrB3pC19d3FbKXMhZ0dbi8vmtDzce8I9TE@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh/Su65CBdjUbvPSMyTvjayODPJAymtnx4smkMe+WKUOahAP+M
	FZ8cTQBOaFBA1HvKw5E/imC9BkJSeANzomnIGFcQwWhNuS5LVgC/HtQdh+f/K9ae/bQIReKnuVe
	9eppB7+QnuAEkKvAC4P7hE4UpAOQQBzrcRHoB5UwR227D2ixpMzKE364cYdkOwI3yPRb4/Gc1jG
	lTtYoU/9vVSIFfEKN9DdEzESbEUa+2EQfLmmzN2srDRUBvj7j5mMa7CamBB0O7lVtXDG9sfgEuK
	+FbM61uMgWfs8K70Q==
X-Gm-Gg: AfdE7ckcrWB7a2Fxp/cGJ+YxxkVHJDyA66jjDI6mo75KHZIvDf0nYodb8JBQIbRjTaR
	cawt//PYzib65B5eXUeRrImuW1RHXewTXx3WZcq/EXZ3sSr/+03xc2OSG59O92DKWp+BY2J1PXt
	Ptv/ObOEGMl3E/cxCdmEfRw8r8UauCj3FFrQm4JxIxz7/oqaoWjhJu9YzLbNpmbDbI//rrhlywi
	FXIdPJSJN4APm7zWXwTLFfg6eUGf6Ps2/waprlEMqHirzI1u0Ju3wIov7D9uRxoNlh6OtLbi9dw
	Zn2uNU7dPtoGi/oejywaxEpF0JgmPnAK+Cr4GCp1+f1YuozfQCSjp+urRPhU6wyxnuPsSSSMAHU
	2pIFr92uDL50TC1tfQ3/Cx2zL3LCKv2Mc6mYGvouqTB4IrQjUB69GQrZDFQkxKvQZz11sZ9qdDV
	mfFQyRF/Zdd3NJbZGd96Qg+nlgRHJBE4jLA6aPmKch9CVmAU/AMQ==
X-Received: by 2002:a17:90b:1c0a:b0:36a:fcf5:64d2 with SMTP id 98e67ed59e1d1-380527ba739mr2245608a91.16.1782814548699;
        Tue, 30 Jun 2026 03:15:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-380533b99c4sm237105a91.3.2026.06.30.03.15.48
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2026 03:15:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e9c87fdd6eso4441927a34.0
        for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2026 03:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782814547; x=1783419347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f3hAfKuWDmESUAAzRkfnDH4k1bTCLydM/xCQa+5ROvE=;
        b=KzMGIWgcvA14LoANrxHU1ZdaHAsFuFD5KpEZn7dQe6OQyqG9yODUwD0x1m7bboZu9H
         XIpxEOgtnRl4zGkl6Dm6Qzb/6+XLuSE1i5S4QY0LYP61u6BmH5vmpYJ3IvnyHAJfWDCo
         Vy/vlAUyEg7Me48TJt6nu5kOJaptuU8bmJi0g=
X-Forwarded-Encrypted: i=1; AFNElJ8to4DEQSC1wvPygUAxUzvIG4neEt1ceo0GC7i38l2vNbyOnuGGXDd/5ntQGtYA85IQwy8WmfHHHxsn@vger.kernel.org
X-Received: by 2002:a05:6830:6ad7:b0:7e9:e9a0:9a8b with SMTP id 46e09a7af769-7e9ec6fa114mr3063498a34.16.1782814547325;
        Tue, 30 Jun 2026 03:15:47 -0700 (PDT)
X-Received: by 2002:a05:6830:6ad7:b0:7e9:e9a0:9a8b with SMTP id
 46e09a7af769-7e9ec6fa114mr3063482a34.16.1782814546921; Tue, 30 Jun 2026
 03:15:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624223927.521882-1-selvin.xavier@broadcom.com>
 <20260624223927.521882-3-selvin.xavier@broadcom.com> <20260629131507.GB7481@nvidia.com>
In-Reply-To: <20260629131507.GB7481@nvidia.com>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Tue, 30 Jun 2026 15:45:33 +0530
X-Gm-Features: AVVi8CchmU1zqrNjUo8LMAGTgEWWwoG4AwiHZxHOZTMXp1YM54_el5TduBEHe90
Message-ID: <CA+sbYW3ZzZ0TuLxfyjLFMc4Xr9GCfCufiDX+73CQkoK9LZX6iA@mail.gmail.com>
Subject: Re: [PATCH for-next v2 2/2] RDMA/bnxt_re: Add uverbs object handle
 path for CQ/SRQ toggle page
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com, 
	sriharsha.basavapatna@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000cea89c065575db7a"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-11.26 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22579-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp,nvidia.com:email,broadcom.com:dkim,broadcom.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D4126E2B41

--000000000000cea89c065575db7a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 6:45=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Jun 24, 2026 at 03:39:27PM -0700, Selvin Xavier wrote:
> > +             } else {
> > +                     /*
> > +                      * Legacy path: old libbnxt_re sends TYPE + RES_I=
D.
> > +                      * Look up the CQ or SRQ in the per-context XArra=
y
> > +                      */
> > +                     enum bnxt_re_get_toggle_mem_type res_type;
> > +                     u32 res_id;
> > +
> > +                     err =3D uverbs_get_const(&res_type, attrs,
> > +                                            BNXT_RE_TOGGLE_MEM_TYPE);
> > +                     if (err)
> > +                             return err;
> > +                     err =3D uverbs_copy_from(&res_id, attrs,
> > +                                            BNXT_RE_TOGGLE_MEM_RES_ID)=
;
> > +                     if (err)
> > +                             return err;
> > +
> > +                     if (res_type =3D=3D BNXT_RE_CQ_TOGGLE_MEM) {
> > +                             struct bnxt_re_cq *cq;
> > +
> > +                             xa_lock(&uctx->cq_xa);
> > +                             cq =3D xa_load(&uctx->cq_xa, res_id);
> > +                             if (cq)
> > +                                     addr =3D (u64)cq->uctx_cq_page;
> > +                             xa_unlock(&uctx->cq_xa);
>
> Does this have the same basic UAF issue on addr?
Yes. It is possible. Will rework.
>
> Can you change this around so it tracks the uobject in the xarray an
> uses proper uobject locking consistently in both legs?
yes.  I will make those changes.
>
> If I understand this right it should also be holding onto a refcount
> of the uobject while the toggle mem exists to ensure it doesn't free
> in the wrong order?
Ok. you are right. We have to provide a way to synchronize the mmap
with the resource's destruction.  Will include in v3.

Thanks,
Selvin
>
> Jason

--000000000000cea89c065575db7a
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
70pZWiFqJ2Bg1B1Atv4I1sIXF2nCdJu1Ejiet4+kS08wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYwNjMwMTAxNTQ3WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAYl+yselGV7jJD2h6ge8P+VYbAUMHGm1lNNhD
7InjOPlYOatOJb6l7plSg/5ZkTXRnPtk04rFbuRiPCpwYKfyiQPx+lsDBWnM6YEGBTRk38IEX6mt
Jcfpr002dY6tTzxOdb41sCYloHYTWrElERcPGzAPdz7JjpIfOd9N1028udZAJaCLDDVAS+YSg36j
3OdAFJ7T8q1YMQeUFn4NNCKEK5DLsTnSzOe6r1yedGb7IahENHLndbneGhBXCTPIrvzXWJyiDjcB
ZYdE8Tvc0NAgfSYlTufEWAJ+WgLuBK/JsUo9tjbwwKZgZmnWYTuh6I78wqknDfJD0JRI4jmBg5JN
dw==
--000000000000cea89c065575db7a--

