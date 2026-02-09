Return-Path: <linux-rdma+bounces-16683-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFFrFvbUiWmCCAAAu9opvQ
	(envelope-from <linux-rdma+bounces-16683-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Feb 2026 13:37:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9AE10ECB1
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Feb 2026 13:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA77C300BDAF
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Feb 2026 12:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0B8376BC9;
	Mon,  9 Feb 2026 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KqP6E4MQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F11374164
	for <linux-rdma@vger.kernel.org>; Mon,  9 Feb 2026 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770640149; cv=pass; b=OSxnWWT6mkNExmiQMk0ysiVfON1xDE6u7Z9NFDr/m/8BuXoJP7GX/yBBAoPf/ZtxvQ1BlWivQBJhjmWXgoMBxY4nVv6OsyeaFaxqSqRfwrvH20aS23YGx7DzBKN3pwngCyVwuXiNte9Cmz8VIcm4EZgVY2ktkJNdkXAZ0uWORNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770640149; c=relaxed/simple;
	bh=o9wb089uk4mh+/7Tt7Tm63lA+J3DoPkpNCkNb1OozI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ut/yHMA+M9aSPi8RL3JKu25VhzlRWFilo9d9BLMqUK402dQ5cTO61gN7XQw8DyELkBJ3MQtil31M0JFTB410qF5mm0tDxzwvnmgM8oXqfNbaQYQ/9fTy0ZLs4vttiWlxY5chTmOMWlTIDzN0UWX+L5oJ+NDPmQLZHj/joFuycUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KqP6E4MQ; arc=pass smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-823c56765fdso2427977b3a.1
        for <linux-rdma@vger.kernel.org>; Mon, 09 Feb 2026 04:29:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770640149; x=1771244949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+gTajI2Amf6HLIbBobLGvOB8PIFDqrh/Wa03B5+zMk=;
        b=HO2QcKtuvlc19aE/zaC+FAoMLrecd7dBp9y9Arcd/5O4ra54Cjzq0Nhng4kbkFOQEF
         APZDF5o0o/DntUxN4YASFOGzHI7iStObM6koHRtnNpkEWMXsOBL9wOaRmMwyfAN7B744
         1CCBwOQpg4HmxuvD4Kq9x0GssuWUOvuNP565HUZfWG2yL03tvX8X87OpHC2yJLEaTing
         d+64GsKqWdnohMxDg1xeH9b390FLYuxQMw3lRsu261nMddDhERT92Oa3EdjXRFrN+qPR
         I6f+LXz06gW0aGNiHP6MEnneaKKKaxQ544zOHvQcNvD2BTRigKqBD+D673ouIlmo1W63
         ERyQ==
X-Forwarded-Encrypted: i=2; AJvYcCX4vJSUJH9WuW+bW9siyckCfLHq+flxkynIgAMCst4pXkCvqGKWBsE66go9rGzd1+VLpQokS95f7o/a@vger.kernel.org
X-Gm-Message-State: AOJu0YzS2w9w+eMnFSZ4btN6gBx02Ts3QaELI8YhdR0MCdiyvU6cMGBv
	8mFOvBNxvZ/4r/XsSCeRpCs4KTbD3jPEcgienNzFl/Ygr/JT/jsziNHw7g6PjvR54qyI5fS0qxh
	xBHxQ39947MVbHUWH7YBnnhHP0TyrmTUnW3CutX71zT5NVf0Ko0fzIxL6OnzlY9jivM9u1TV6Zc
	OUr5rhfTgB3+v45g7qRGW+rfmWYE7nWrpPvnowdadgCEur989oKeE2f5GO5z/Xm/pAGP0BMfOW4
	EtgSsysUDE7ZtEnwuF8C8Qvh3mG
X-Gm-Gg: AZuq6aLntwmYmV72A8kILbfGPUrblkzXZgB9gmUKzB3fmD5Lt7ULQO9hygu+7yiYNZy
	nH2AQ1cA/31L5RdGK8XvnEYrrE+gqvuay0KhkL+7+IzumdCFzPI4J6rztMwv5zza1SvHxc71Uyb
	5mb5yTWOD/X5MI0i1pTYoblvSHKsi3Izb6K29UUmGbiCMW8lt9h2W//Wgye5NW74mGGMx/qCA/Q
	QNJ5RyN7T71dOxd6wzbvJ7gI2PhD/Yxvr/Jqzqttr1m8/FxB81rgpWDNbnhi9HcaUFp2ZoagI8d
	plzkwHRLyBdlntSJcC7rSGKP/HkBG+g676SOUhiuzYzlZj6j6eFILa0W6WMNKJNqR/wn6ZTxcL/
	1spT3TVZr8IoJwS4gyuq5Nj0fhNDUqkF0LdN55xlKeeZaGsMfC/N2PksquJ2+IigRLcCrgTfyVe
	1IPu6HPE37bTXLX7m6aHZUk0dyb5e/pdvUzIZoSxQZEtRXol5t0h4Cg2Sq2mI=
X-Received: by 2002:a05:6a21:4782:b0:38b:e750:bc27 with SMTP id adf61e73a8af0-393ad36d731mr9376511637.58.1770640148605;
        Mon, 09 Feb 2026 04:29:08 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a951c781fesm14447655ad.19.2026.02.09.04.29.08
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Feb 2026 04:29:08 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43623192c6aso4025041f8f.3
        for <linux-rdma@vger.kernel.org>; Mon, 09 Feb 2026 04:29:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770640146; cv=none;
        d=google.com; s=arc-20240605;
        b=b7HQMfv0Nz5PkCAt59NXzHc4UV676s4gSLtvKENoll7s/WmxhiFC796qQzOB3qpbsf
         SEeB0jVivelLHJ0WayUhagTQ1BWVTBayY/hFrGhYIu6xnZ0mv3sEfm/VC2eVercHh4rf
         E6VizGMajC7o/U0H2D5sEeqgvt8MadlgQIPymr42bvRX8OENzA44MkN2DtpBXflSgdbh
         HlXaTEE2IE5oAbvtjuvMACZPSkNyClf6J0s/zDjE08nOjjsr3phvru0WZvQyCmffSYAj
         PWKP4jCjx+q0xN/nIq3RuhLboNRIBZ1tZIenvFTYXj/RkijcLmXJXImaLFhxt8c6zXay
         8pmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=T+gTajI2Amf6HLIbBobLGvOB8PIFDqrh/Wa03B5+zMk=;
        fh=AOFlr57g0h1iXMY0QwMINpMmqGYX07jLNdjm//SpC/k=;
        b=eFlM2tj28St/+O40MUKiIJ4VNpXOIHoXbQuLYVZzY6LSUP2t2oLd15dC/ezr5965Ky
         N9DD2gKCwgD5PHHbU1nF2yAzkJc19G1oRsC7rGbPM8Q+/0pZSZbLuRhsTDDeOCoiWjLO
         yng+DAAQmHYjBo28ojgqdn8t/65E4X7yCce20Vk9Xj834Ll2H1s/rsiP//IvQlM0RADD
         AKd4QSGTtpARH0lVRiucNfQokAcJKxJhD93lxOjeebearlROp0HCVJ7CIp2q4VzXniZp
         4OLWoiEC29VLqDsahzDwVPhnc6qq3Hcr3ID2iNYXakP9u5GeZBN3WopQTSa3cw/R2mEh
         UkWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770640146; x=1771244946; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T+gTajI2Amf6HLIbBobLGvOB8PIFDqrh/Wa03B5+zMk=;
        b=KqP6E4MQ23ODmKzORvCvENpMfOGAPM5WpDnIbElMlKfl1p55De8kTYAgGGZCgyDUko
         0elhs3K2fdEnO02y4uk+VesUTmMjRpfhqxu9gOMBkND4BTCHWAz6i6mZ1SEIkTIzbNj9
         RGtCQ12GNXDl3zRAUwBgNC2y8P7JFjQwib8z0=
X-Forwarded-Encrypted: i=1; AJvYcCVWqCP1GK1lWDCTMcG8Z8s1kjEgVwipWCUymuN8vg5ZdYk+1hsX05FUS4MAqus69u9lod/FWzYbnplH@vger.kernel.org
X-Received: by 2002:adf:ea06:0:b0:436:307c:b762 with SMTP id ffacd0b85a97d-436307cb87bmr9982600f8f.60.1770640146387;
        Mon, 09 Feb 2026 04:29:06 -0800 (PST)
X-Received: by 2002:adf:ea06:0:b0:436:307c:b762 with SMTP id
 ffacd0b85a97d-436307cb87bmr9982567f8f.60.1770640145887; Mon, 09 Feb 2026
 04:29:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
 <CAHHeUGWw221yuH7Ac8hbsVc+dMBC2GDnPZMmAjKMdu36wkY0Zg@mail.gmail.com> <20260206191101.GC1874040@nvidia.com>
In-Reply-To: <20260206191101.GC1874040@nvidia.com>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Mon, 9 Feb 2026 17:58:52 +0530
X-Gm-Features: AZwV_QitFwbVOMJzRSszOUsK5R5LuX4jeRBhvyldBdfLIStIOAcxrlH9CMbeG_0
Message-ID: <CAHHeUGXQVYkapqi1Dgtjw-sA5Kk3d-VdngMTjdfy1xYGfOk31A@mail.gmail.com>
Subject: Re: [PATCH 00/10] Provide udata helpers and use them in bnxt_re
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, Leon Romanovsky <leon@kernel.org>, 
	linux-rdma@vger.kernel.org, Selvin Xavier <selvin.xavier@broadcom.com>, 
	patches@lists.linux.dev, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f960df064a6348c3"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16683-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim]
X-Rspamd-Queue-Id: CF9AE10ECB1
X-Rspamd-Action: no action

--000000000000f960df064a6348c3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 7, 2026 at 12:41=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Fri, Feb 06, 2026 at 05:50:07PM +0530, Sriharsha Basavapatna wrote:
> > Thanks for this patch series. Patches 6, 7, 8 and 10 failed to apply
> > cleanly, due to conflicts with the recently merged QP rate limit
> > patchset in bnxt_re.  So please rebase it.
> > I applied this series, + QP-dmabuf devop patch, + bnxt_re DV series
> > and tested it.  It worked fine.
>
> Okay, I updated the github branches and we can do this first thing
> next merge window. If you send out just the DBR and revised more
> trivial CQ changes for the other series they can likely be picked up
> immediately on rc1 too. Then you can work on figuring out QP.
>
> Jason
I'm working on the DBR and CQ changes, I should send it out for review
in the next couple of days.
Thanks,
-Harsha

--000000000000f960df064a6348c3
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDNpdlO5XjrmmKOXQFN4jc2gY1Plo20HB3W
dgY7LNznIjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAyMDkx
MjI5MDZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBcqa8dAIiqqzFAXE6Uluh84qpjqPqjS+UEtM68N3+5G3NQWa2K3GHUZsW2UXGSE9hDHapH
wTddi2Q2gH8F1wLXUClyHjshZp/KuxwiFjPco1vuGsP0kBqNxa0kr5TF3Ok1uqFPRBbx7oO2WFGm
lUUT789PXtDG1Em5MYuQopBPKpx/hYkEefTrV1hVEwsZAh1Qn9UCBmEcsWOxvCBjXyRigchPOCSN
OIJZ/lPHHymX3hWZQLenA9gHYgbYVN5boFAQd+3L0mOO8z+xsmmnSghZabYlKPQy4cdWGA28UWZ7
O6y9iKtPIjgZA9k+ZsFA6ULozKtcMtnb+yIPOcouiPwm
--000000000000f960df064a6348c3--

