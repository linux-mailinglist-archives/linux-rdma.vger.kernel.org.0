Return-Path: <linux-rdma+bounces-15561-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68683D2097F
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 18:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6ADB3009D6D
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 17:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E575130E828;
	Wed, 14 Jan 2026 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BN4jenXj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1D6306B21
	for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 17:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768412689; cv=none; b=GJ1GXEF7rROStcHLGrP6zy90AzwsZOWxV8MN1MchT1otkC6r54yb02qGU+ss5l/BEboUdmmqpM3eY+u9LWNKE7zjSMz/+JDCPuRlYLDJvvy088HEbjbsLaEZr/u/sUnXYPKfqm3z6VKEV19BJ7jtrohoUyFQr1x8BaaO9Yg7YF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768412689; c=relaxed/simple;
	bh=fCj1q8eiNYDIzmIzNhoDHU8nCdliAGMItKTloT8VYqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNRqsEPn4WyJuPvTACHCq/Ys4QKaXq4wAKLcx66gFFh4MuDvgTUJVPrBak7orlTgZEPL6XjBeB6emm86aW5wRU2C0FWf63qp+xkgkYP3lO/48dNNKWgGBGMghwgyLohA0TfqwOwBJXH3sqGKvVOCqh+7nq27vGO+czGyXOdmdp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BN4jenXj; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-29f30233d8aso890475ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 09:44:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768412688; x=1769017488;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMFooh8aTFIVXDfhKsOV3o8oiVnEz38fSAK6L9pKUdQ=;
        b=YL6g96qzChMSxU5OJk21/T/cJwfR5aKGhOajvYKCP6p2POB0D3Q27M3OYIiwL1hpgw
         jX5SV3LpgJZnya85rlBw/BanhB1OyModnVAftLP+QY9Us4d9sCuzNqn3kwrG4eoiW+xl
         hgelm0zQKZ+25tXZJQtmxhG3+TJNTOzmnLKBY942OQPIme5f0FQLFCWNgCpYEs7CQ/Dl
         9+QDCvw4b+8504WX9X/RonlWC7FR3wgQdOITZrJt3KEZwmvdqWd8UAoorPPh8v/KMudr
         dUpgSo27r0b+TjVVUYnXjdxhrTz2gR42BSH1m4qrpqY7vpW9c5PVOorUlYTKu9uh00wx
         QfNw==
X-Forwarded-Encrypted: i=1; AJvYcCUZahvSNoQwpe+O4h34oYBmEsi5np2l9rRU7iKGjk77VKcHKClS1k/4MosAoWlB5fovN5yOb5cAJDXq@vger.kernel.org
X-Gm-Message-State: AOJu0YzNdqi6GtFhIYUZBg2AY0lT01h86Y0+0q1O2YrIAW/abl7Qi0MM
	xQOfsRC9l15BI4Oz19cqbOG3xI1oXCcJ1uyFHYWZn2OmVftvaed63B964GhWOM7BCO0n+DtFsCE
	P8DHXRgBpvE6RYj196SkELde6kSj//nkGQlsMC0Vmh/ODfL8bJonNaTfizMESx/LAQce/6SI/ZW
	Uykh5FsDAMqbA0posbXAOskuQeKBsRs2fXpx2F3S8ND4CSXC+Oa14OcshP2gj3CPwitdRaLEEmm
	Ya1H/hY7RpA6v2z0x89yDCMctD8
X-Gm-Gg: AY/fxX52pT1kdcmdDsuBXC16/zlpAZMDmfrftxHAbAKMtnjyj22Wsq+brkoYmMU63aJ
	3egl+Ziwgo3xow55iBEUgPVXF/5HOpqx3cqNnR9TIwujJdeGSsvIVPyrHFo6yf5VuEt439dJqXd
	ZEof9/oyVUYxxm+K/JcAGTutxDzQ6oXZZaLcSpsYOoLpTC6XAIdsKvAy+8JDQFd4rCoEFmNbFy3
	3C/vT4/gSMkdpC3BYnsRxa1X4AO+Srk+y9bKsGkbcQiUK79FLFiBlvO2roC1juXoHNpWpcLHxI2
	b8y6oo483hgymOijSLQ3OGgwXHVQXKfIZzFo3pG1/E+HeL9mJWScQ/4oHVGp2oIj9nnd7W3jDvl
	lpvB7giQgqOuVZMJecFufTpwx4YNRRPfPTrIZQBbQ7H1asGEfvKfMggC+iZS5tn7lRhhdKt999d
	XL3vDZAj3TGQPieqNMyIxkNj/W3JRjXYUlc4UTVLdC/kEhVN8ZIRwFZFU7rOY=
X-Received: by 2002:a17:903:2f05:b0:2a2:c4b4:f72d with SMTP id d9443c01a7336-2a599e240c9mr38654055ad.30.1768412687526;
        Wed, 14 Jan 2026 09:44:47 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3cae7edsm28870995ad.28.2026.01.14.09.44.47
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jan 2026 09:44:47 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430f5dcd4cdso50986f8f.2
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 09:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768412685; x=1769017485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rMFooh8aTFIVXDfhKsOV3o8oiVnEz38fSAK6L9pKUdQ=;
        b=BN4jenXjdo895sEskEJikaMpXYDHsDNRwyKfWkBpPwX/a2KUPTHghcWu9WxPEB7lvp
         emJCYVyxH3Dj6DKI4D0SfjKTMEzLDfzbrVAGA4s81OLGSTCd/RK+noB60MDobePIf58j
         CHrbY6g+n7anfxoXP7vjd3XxF50W7v8PkMfaA=
X-Forwarded-Encrypted: i=1; AJvYcCWwVGhMcnswex0pGfa02qokbWKkl0h6mG3s7qrdtI8mPtScNIk8f3D2YCdSkT8sEoyw49C8cLqycNwS@vger.kernel.org
X-Received: by 2002:adf:f352:0:b0:432:dfa8:e1b6 with SMTP id ffacd0b85a97d-4342c549f82mr3744061f8f.39.1768412685444;
        Wed, 14 Jan 2026 09:44:45 -0800 (PST)
X-Received: by 2002:adf:f352:0:b0:432:dfa8:e1b6 with SMTP id
 ffacd0b85a97d-4342c549f82mr3744038f8f.39.1768412684996; Wed, 14 Jan 2026
 09:44:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113170956.103779-1-sriharsha.basavapatna@broadcom.com>
 <20260113170956.103779-5-sriharsha.basavapatna@broadcom.com>
 <20260113173247.GT745888@ziepe.ca> <CAHHeUGWErNHmhFX13VHw3V6feswyV6JVzULegGoBNg+2x6O12w@mail.gmail.com>
 <20260113185957.GU745888@ziepe.ca> <CAHHeUGUgacV=t6pUJDX_orvxwzv4LEH_cnzyN61mCA-MMY7acA@mail.gmail.com>
 <20260114165909.GA961572@ziepe.ca>
In-Reply-To: <20260114165909.GA961572@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Wed, 14 Jan 2026 23:14:30 +0530
X-Gm-Features: AZwV_QgL3w09LvWCpzzFvR4q_HYdLkW8PKMMgYLd4OUmQUicrz9E4Pg084IaApI
Message-ID: <CAHHeUGUuN+WBX5xKHH2MeS0XoRdDbZHDduDD_8aK=Tv8d12Zeg@mail.gmail.com>
Subject: Re: [PATCH rdma-next v7 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f4784a06485ca9fb"

--000000000000f4784a06485ca9fb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 10:29=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Wed, Jan 14, 2026 at 03:06:26PM +0530, Sriharsha Basavapatna wrote:
> > Thanks for the pointer, I looked at uverbs_cmd.c:
> > ...
> >                        scq =3D uobj_get_obj_read(cq, UVERBS_OBJECT_CQ,
> >                                                 cmd->send_cq_handle, at=
trs);
> > ...
> >
> > I can pass the dbr_handle (idr) from the library, in the driver's
> > request structure (bnxt_re_qp_req *req) and then try to lookup the dbr
> > object using the steps below.
> > For example:
> > attrp =3D rdma_udata_to_uverbs_attr_bundle(udata);
> > uobj =3D uobj_get_read(BNXT_RE_OBJECT_DBR, req->dbr_handle, attrp);
>
> Please don't pass object handles in structs, the attributes must be
> used to pass these things. The driver can obtain the pointer with a
> simple
>
>                         send_cq =3D uverbs_attr_get_obj(attrs,
>                                         UVERBS_ATTR_CREATE_QP_SEND_CQ_HAN=
DLE);
But there's no cmd buffer to fill this in as an attribute from the
bnxt_re library, since it is using ibv_cmd_create_qp_ex().
Thanks,
-Harsha
>
> Type of thing.
>
> Then QP uses the uscnt to lock the CQ:
>
> void ib_qp_usecnt_inc(struct ib_qp *qp)
> {
>         if (qp->send_cq)
>                 atomic_inc(&qp->send_cq->usecnt);
>
> And then CQ checks it during it's user destroy function:
>
> int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
> {
>         if (atomic_read(&cq->usecnt))
>                 return -EBUSY;
>
>
> This way the cq remains undestroyable by userspace while the QP is
> using it.
>
> I think you should have the same pattern for these doorbells.
>
> Jason

--000000000000f4784a06485ca9fb
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAT1OeDaaRqxysZZoZGuWlNFW3a38QNNTVO
SKMi7zh+oTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMTQx
NzQ0NDVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQChfH85dL2HBPfPAhO+Tg8gG9Dx5bPciigJ7ZYN/wVpZuAwmlGypx35Q3HZti+jVH8XxiJc
vHiJXid0ywec8IkFWuHrtz2PRm3N73xG2S3b+nckmWv0BFH1MngeX7A61IjAuPFpIbP46OoHeXfS
RMsEVWfAVkjF1yV4KVDKvbTGFvmTdLvK+XkyGmIQ5EXii3y9+QpC2S7edLoEr4OEoHejWjO6n5Hs
+GIMjuzyjYGeWdE3snzDpxstSqovmnSieT9ZFGbG4frjdepxOthWu2RwDf741h/7JgUTOpQ2kxUO
jpgFSc5/uaJFEYZ2WPNRlTuNpspKzTdlHpGU9lbxNLXa
--000000000000f4784a06485ca9fb--

