Return-Path: <linux-rdma+bounces-20985-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEIRMrWGDGo1iwUAu9opvQ
	(envelope-from <linux-rdma+bounces-20985-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:50:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B438581BFB
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C03493035D70
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 15:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D90E285CAE;
	Tue, 19 May 2026 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VaJk7gwU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D930A403E93
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203898; cv=none; b=N8M9+Si0kJff/7uCVRSzWrWLw+/ICgZn04otRJDTOAZSew1eTOrdyRb9nVZTvhKp+4HNEJtWIOkYaMuFT+5W8wUFHUlrU3zqvgdmUjJD/ALKlyP3dQ8vANMabHOrB0eocL7//DhuXDTiVa8I2xoTL7/maDmTzqsrYlEQdnE6c6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203898; c=relaxed/simple;
	bh=REerB0d9ee2NFzJULujV3BBQFQQfomZbFPGFJjt88R4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0lrWCSj+wgud+2abMHpRoLSnjdG6mce/kIVQRUoU9bmTw++1bfv+WCEITiMRUauKzhK3l23LAn1y/yBirSBdHaYPUZRBmHEr1C4v6oToxHw9V6oJn760YQgqCtuqGxUW0vzRc40XHH22nk8QUQ4lISLGOQUa3WUE2C4zwbiHy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VaJk7gwU; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-8b701756684so53251986d6.1
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 08:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203893; x=1779808693;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REerB0d9ee2NFzJULujV3BBQFQQfomZbFPGFJjt88R4=;
        b=e+bllPYqhe3lKyFbuOUfWNyPnl3o2nRI17ftDqzt8rS9v7597pD4YNx6Qsn8JBKP9v
         +T2JtL6gAEgqUyKXVEu1fwPwhrugYNC6rj5bV97GT4fs+ZCAAcBYGshe/kJZeRBa+mOi
         qZfCnzoKamoHUJPS0gJULiMV2ShSbcxacoG6OXLm1aHwALZA+wjur/EH4IZPeU4NfnNY
         Tl2oPmfvTlpQD772/pqk5MDJ0OPkqR8/kizvs45pRj6labE+iatIVzbhlCbeGrpadq37
         SBoJJGPo72N98kcfBz/Hjldq4i7FChMJDUvZJaVa0c8pj6qSHXSkVj7SqO4QejuBMcS7
         QhFA==
X-Forwarded-Encrypted: i=1; AFNElJ/LAK9rwk8djcII2cwAvHkyTmlF1+wdai7YJHbq13DV5BpjxML036WERJVoEK8ijXDQR1jpp9VZDlJ6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7cS40IjbE0LGSlnujocVVIXDZ0hu+CUsTtjcJzjTkN1ZCOVKJ
	wN0Oqc5N1fSBIyXzHQvlQtLrj7GahEn7fo7MFFKO+iqYo7R0lojcUNvjwZdSHB5fV9Luh5zofQl
	2bl9MzFnSqJXFsa4NTQDTNsH4OT5WrGEU7iIovs8QCSFEGhr/3qQJzvziWsp5zpoh5HL8AZAN0t
	oIx0xdoYV9QisQIoEa5JH7ju4SKYb2h7uW1QDt5+OLhb6xUalb4f+tqT6GjEfgaULZPKUXsL1Kh
	GpLbKihjHP3Ai6JoycU18ZUYMIb
X-Gm-Gg: Acq92OE4EN0RnL9QItD5tN1Q6+RJrgTGDpYsN/93clwgaDphDy4nGddBmcuq+6ddaCg
	5zjWIOMXED61zv4QpXpnJpXjLRlF208rfZPywUW/DFaFJHFDkAhh3KvDo9Zy0IgA2sOIVJznRB6
	Xsi3zl8MDyaz0KAJNaX40duFjfoL07vOSnFDKrOLXCH/NoN09GvEepbPd9+5S+eWkYU5dhf9VE3
	bCd17IkDECnbWExGNBWnPkhhHICMP7rpqGbqEyFX3ZjqPnTkV4pDoqqLU5cc8X/2ITYT5XYg8/m
	7faWLzSJFxMf0glxR9KYdQ24SS0oh4zgrZFTj/99n/7TjiKx+Rii0mCiXdgYraWaGtcYSxggNV7
	NpKQpAE+tInoo0tjfe5OrMrHiDwxc1XnfP2T/SgPVVZLgQX0wojv9qtIWUgWV81BYcDOpzQXTuU
	5kw5D5QknzNCjv6KXyjuXUVdXix1KxMsp6+ziiMr/PjHaVQh5GWOAK6CeUk2jUB4AQuN9c
X-Received: by 2002:ac8:59c3:0:b0:50d:7632:ddb2 with SMTP id d75a77b69052e-5164159ee2dmr303650921cf.12.1779203893340;
        Tue, 19 May 2026 08:18:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-516456bd3ebsm9646321cf.7.2026.05.19.08.18.12
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2026 08:18:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44b186b715aso2316692f8f.0
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 08:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779203892; x=1779808692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=REerB0d9ee2NFzJULujV3BBQFQQfomZbFPGFJjt88R4=;
        b=VaJk7gwUXxY2Ot1DtV0dMKNXQkWtd7TwSTPlA//h++D+NRYGSqQdkcPjfdm9iUraZj
         +4EC0dTsEhNQi4yPPKbVlBYv/n4lqL/KZ+2rKkYGxkwwGVVFVX2/OKOdkPFKMxXVk1AK
         X99MsCO+n+exoZFKRP8RhXWw509uxAvHvS/8w=
X-Forwarded-Encrypted: i=1; AFNElJ+9/ELWa4pO/zKG87MzRXwB8scBiXZzPDOXO5262zqzd1Y7dhcUHEPoz2VSd17wN82Ag/NzcrMx22uX@vger.kernel.org
X-Received: by 2002:a5d:5d13:0:b0:43c:fc5c:a9fe with SMTP id ffacd0b85a97d-45e5c5879d9mr32736010f8f.20.1779203890145;
        Tue, 19 May 2026 08:18:10 -0700 (PDT)
X-Received: by 2002:a5d:5d13:0:b0:43c:fc5c:a9fe with SMTP id
 ffacd0b85a97d-45e5c5879d9mr32735768f8f.20.1779203888339; Tue, 19 May 2026
 08:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518153721.183749-1-sriharsha.basavapatna@broadcom.com>
 <20260518153721.183749-8-sriharsha.basavapatna@broadcom.com>
 <CAHHeUGWK_2RNG=CaHTnNh2JeAXa9mcTam6p_7Qp6eG+6Nip+_w@mail.gmail.com>
 <20260519124600.GX7702@ziepe.ca> <CAHHeUGWpp8n1dHAu=MfYiLhntzK=PtvNyRBHhD0W9KkthEgYUw@mail.gmail.com>
 <20260519132730.GZ7702@ziepe.ca> <CAHHeUGUeQssyz2fsb_aOzgi=wu2KaCyRJHU7vBC=wk4XRbpgOQ@mail.gmail.com>
 <20260519144049.GF7702@ziepe.ca>
In-Reply-To: <20260519144049.GF7702@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Tue, 19 May 2026 20:47:56 +0530
X-Gm-Features: AVHnY4JuBcgwUSurDNuxhQOkFPralQL_DLoINI1la5sb8jSCkcw8mupAvxjo2Gk
Message-ID: <CAHHeUGWzuF4Uqh+MBxZria_a+BOL2QcT4jLQi-PHS8tBQmxW+w@mail.gmail.com>
Subject: Re: [PATCH rdma-next v6 7/9] RDMA/bnxt_re: Enhance dpi lifecycle
 logic in doorbell uapis
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f7feaa06522d2f9f"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20985-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,broadcom.com:dkim]
X-Rspamd-Queue-Id: 2B438581BFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000f7feaa06522d2f9f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 8:10=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, May 19, 2026 at 07:29:08PM +0530, Sriharsha Basavapatna wrote:
> > "Does tying the hardware DPI slot lifecycle to the VMA lifecycle allow
> > userspace to exhaust the hardware DPI pool? If a process allocates a
> > DBR object, maps it via mmap(), and then immediately destroys the DBR
> > object, the uverbs object is freed (replenishing the process's general
> > RDMA object quota). Since the active VMA keeps the mmap entry alive,
> > bnxt_re_mmap_free() is not called, and the hardware DPI slot is
> > leaked. Could a user repeat this process to hoard hardware DPI slots
> > until the device's entire DPI table capacity is exhausted?"
>
> Yes that's true, but nothing you can do about this without moving the
> lifecycle to the uobject, which we don't have infrastructure for.
>
> > Even without this change, the DBR_ALLOC() uverb allows a process to
> > allocate multiple DPIs (that are meant to be distributed across QPs).
> > We don't want to restrict it. Again here, the library properly handles
> > this by unmapping and destroying each DBR object.
>
> Yes, but there is a cgroup limit on the number of uobjs a driver can
> create, so it can be technically limited.

Thanks, that's good to know.

There was one other warning in v6, for which I just posted a fix in
v7. Here it is for reference:

"If BNXT_RE_MMAP_UC_DB is also used by other paths (like
bnxt_re_alloc_pd()) that do not populate entry->dpi, the
zero-initialized dpi struct will have
dpi->bit =3D=3D 0. This would cause bnxt_qplib_free_uc_dpi() to
erroneously mark DPI slot 0 as free, potentially breaking hardware
doorbell isolation."

Thanks,
-Harsha
>
> Jason
>

--000000000000f7feaa06522d2f9f
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDznEiZo6xQQpnDrwmAAUO2ctg22Zi/XZ9D
Ds/P2tCC8DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA1MTkx
NTE4MTJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBcx4nMG+ucHhctq9is5A+3u5DFBKTnVrtk4Fz59EEg9OpyrIqqIW9Wz1R3RmOQSreV50iz
k9/5tNQe/C02oEaHw1m5jtV/sJT7n5zEx34+kabx4X/0HCVPoksR+0VIQDUjAfejQsD/7xPpNeyg
EZXXllNwyOyDjn2Q9S1cN8v+ObqwZUNXnzx6EpALSqPc2Hz5l5mNlhlidDzWqenfxAABhuxNhrUt
22vC+alzIS1YW8hM84gF+im9Y2qFkbglr5yXZDJWFnyR55GAr16ypPi0qVduxBGOZ2pXtbSIQuyV
v6AK/tEPQyGG0bzYJ6YGOI+rHYD6fkIFVbw588MDQgqU
--000000000000f7feaa06522d2f9f--

