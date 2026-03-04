Return-Path: <linux-rdma+bounces-17473-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LqXNAhIqGlOrwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17473-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 15:56:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B8420208D
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 15:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B9F2300D6A8
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 14:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BF93A2547;
	Wed,  4 Mar 2026 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fa0aqtpS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com [209.85.222.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE0130BB93
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772635990; cv=pass; b=C2rB0nh4ANcxR8PCZgPem6Baz1Z/lo8B33teLnU2Dm9132JEwx6W7cKpqvX3QHZT89HPjM0YaBEkN9psgW6I6+77SHmEByHe1I25LMymivjnZOfvTKHREtyc927aFGBZmTVf5XyhEHygFyYxr+VVi/NmwiR026HFMpqTYuzrn6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772635990; c=relaxed/simple;
	bh=cu7e6xqXswgDenpwQwtwhIRpmIDej25XFdzB3Iwap7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0OGBbGdpxX45V/GbFMzFRKwM7ivuBOnwGyl+koL/dr9+punEk/HymVgYzK584dt1y+ZdQdLT0wGadehOGX5g01gb+MN0tQXqNORy3ub/LbgE614bm10jLdMEHUstSguxSyX1kq+7TjI1Fp3fnLVtoS4bd9a6rZxgWortzFuLm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fa0aqtpS; arc=pass smtp.client-ip=209.85.222.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f99.google.com with SMTP id a1e0cc1a2514c-94aaa5d3bfcso4145000241.3
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2026 06:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772635988; x=1773240788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfh5wbOO9L7ssLcrf111hI9eogYVbtfxnNwae8If+7M=;
        b=SC7DF6YSbuobvCZMpSbJbEqWlSA0EPzIOVwK+MZ38vDrwzAr83+WjbuEkiNnswtB0b
         xZdx1nleZs4BBz2wEgszG7japazm++cGBWfzudcq5I7PFrCZKqfGo1HcQTPWyITpu8XI
         9DvUO2siByxVzEHxIXaUJJFkhkFIriBbGo421wpJrbeqaseiz2rhPs1/xLlk2h+SIvMj
         a9dQz3CjLpz5maPYWIPc0e6QuZBodpyesbH1vUS23DXHivGkf3F3uHmJ4b4UECGXD5mS
         jPmqbbQXQQRLxbCA/DKrdSM5ENCNS/Y5MamMvvm94xQuor/jUfYkwTQNuvG+ChuLo8kK
         sJQA==
X-Forwarded-Encrypted: i=2; AJvYcCW4ztXl8XXhpEdhXs70MDy8ePsa7Y/G3sL3pjCDvWeZAh/f2M0kbagMpOcTXFCtPJAHEJZeKuIubP95@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8M/uNsVS8uek4tOtVQIMeNoyBnmRT1b3UfWqNdn6TTFJrikVg
	RfpOCnbS9nCUFsO3dbgzE6VknLHxtxmJzWZrw8aRvAXQBaPeva5puYtK0+mrrAy4cLdIA/82xpe
	ZaVPxifJMJc4NhthXZeEmvdbEEX+P4n9CHRjgg2OsqRZb4qVQrIgPdTRVVRwGaeBuO0EbtgVR4O
	wykb6zGhIVdXFGTNGfkXSNjpBXiWGSnLO3svybdrb29js2J+AewztbnKWf0pmuVuhWFrmsaAN3Z
	ufcn2RN09+drh0Xo3c7pbIN2Cl6
X-Gm-Gg: ATEYQzzyyWeZODXfvECTK1jGGMp0FjQwF0cNQDO5r8LgaihwVpmyGmy2g0dCUnZglkQ
	S397YlzPn2LXSG7uVyfqxVvdmKyd7zc6PTB6tVsZgHI9VjWIniXSnl78Qi59gFOm0Fj/hjXPLRr
	E0TGJXMEx0222whAWVY53z44+rg97jeEIiyG2nxwqBCSw4jo0Z1NR4tZ3vcGPeCK0mrnQU4tLhg
	BzId4lt7hhDluCIKJgfag5StZk9tBZT6Cbx7/2KTVZoztkVdwjWe0OounkeVDn3l3SK8dHDM6gh
	VPI4OTjNpu5t9T+NuCmvgsa+NEQnqijYpU+z6oZKFiQAudwrwjynM9fIxLSF+HnWyVoc9QvNhr/
	zwRnHhsgw+yBsC5ZLW2PZgUtKVmGLDrIAspdYwU+yMThGtc7m9+w9FdpbL/FCQPZfO+0VaL6fQo
	LPSXQFUyQXz3cjL647VEsDySNlubA713/sHycKDKPe26UFFmZxWpCLg2uPWeqAAwsp6rlw
X-Received: by 2002:a05:6102:3588:b0:5e8:1dcb:4dfd with SMTP id ada2fe7eead31-5ffaac1e77emr996059137.5.1772635988094;
        Wed, 04 Mar 2026 06:53:08 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-94df64dfca1sm2013912241.3.2026.03.04.06.53.07
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2026 06:53:08 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439cbc5fb4fso288368f8f.0
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2026 06:53:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772635986; cv=none;
        d=google.com; s=arc-20240605;
        b=Tw/VErR7VXlhOvB/VM6pLPwUNHzyWQJ8c3GxwN60863HpxggmH90jrgI/0h4sBnY2G
         wxu1xdMHpw86h3w2lq657oGGBtpSI7t3CRvCDa9uMywEAOQ2Q5BWEYVJFoElt7JN3gH4
         PYpLRi6zTYuWR60OFx8w+eaipePBgvv5P4I6kjquWm+DJNviN3sw/jLticrV3oO+H1MH
         O+M6iMApZYkJ6moK8zEzlyeHbaO2A9R2Uw1JVyDhGLgPXZWvbeWTpiyd4dFiLndYlhEg
         fBh+Eu9J6DuszrBDVsHk9dPKKMfIvr21V36tCGthTMGoJVV7YvC+kxp1locZz+uIgZ7l
         uDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lfh5wbOO9L7ssLcrf111hI9eogYVbtfxnNwae8If+7M=;
        fh=kbEaGMKJ5ZRlFW039G7yJmKpuA2LSaM9evVxCJsL5Ag=;
        b=Q3KVnZdb7+5xwpzotahO0kzda6rCer+rJ/bYwFbuPPyI9Mn/dmQsayH7jyDfznzs85
         n1cOlsfNslbxsC7kHZMoQZGTrjj2Jn2qxMqEIp4LwHxTQjRYa6H7AhkFKrTg6G+O0vGw
         gMO3RrEER6rTPxz2oWJRL9wfoeJlQFxns+CQcNUluv+AtYzjwS5hVbLny9oHcOz23EXz
         MSfx01scKN2C/8o9d4L3qI9uLrNmwyXvVT5KVO0BJATd74KM/5r+MHU3q74kIU914+Vt
         /tpMn4gCOYGWunkZ6AXJnGGUeQQIW1+7moPwt0GwXec/yyIzgy9Uqqa9XbwVfGp2O6LR
         Cd/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772635986; x=1773240786; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lfh5wbOO9L7ssLcrf111hI9eogYVbtfxnNwae8If+7M=;
        b=fa0aqtpSNOWFhV13MXMFpZTj7PHHJVEhMsuw7e2arRGFgpXL/nXbLKhdQwnPfEFRHB
         ejN7SxRf83uHEnyA0qQcJmiWqg6F48h198Tc5p/Ez1xCuiZRj+2nmnvuW0F2pBsLLK0x
         /v0WwXQA9wnPIgnIKvMX/hlVp/N5Ay0DQT6E0=
X-Forwarded-Encrypted: i=1; AJvYcCVD0e6tzd7xfEXP9fYNl6hNFnrPGUcWORAxa58uo2YFKATNe5QlPtwHL4DxcTt2xE2L0ZR3rSTCAljw@vger.kernel.org
X-Received: by 2002:a05:6000:2912:b0:439:b886:20da with SMTP id ffacd0b85a97d-439c7fb0c37mr3904849f8f.17.1772635986531;
        Wed, 04 Mar 2026 06:53:06 -0800 (PST)
X-Received: by 2002:a05:6000:2912:b0:439:b886:20da with SMTP id
 ffacd0b85a97d-439c7fb0c37mr3904800f8f.17.1772635986016; Wed, 04 Mar 2026
 06:53:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
 <13-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com> <CAHHeUGW5aOHbhETW624fM_MSkXAqUgw=T+6skPaA=R3py+9EQQ@mail.gmail.com>
 <20260304141149.GO972761@nvidia.com>
In-Reply-To: <20260304141149.GO972761@nvidia.com>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Wed, 4 Mar 2026 20:22:54 +0530
X-Gm-Features: AaiRm50uoJCcSQYZgdb957JNsYl5fxpfWzbvWOnVYNeV0tioMWbd1EDEYi703Qo
Message-ID: <CAHHeUGWuWCnLw4-mqAPhPt+f_qZThjOBQU9V=x0MyCO7bkxyqA@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] RDMA: Add IB_UVERBS_CORE_SUPPORT_ROBUST_UDATA
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, Leon Romanovsky <leon@kernel.org>, 
	linux-rdma@vger.kernel.org, Selvin Xavier <selvin.xavier@broadcom.com>, 
	patches@lists.linux.dev, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000510dd2064c33faa4"
X-Rspamd-Queue-Id: 44B8420208D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17473-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,broadcom.com:dkim,nvidia.com:email]
X-Rspamd-Action: no action

--000000000000510dd2064c33faa4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 7:41=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Wed, Mar 04, 2026 at 12:05:11PM +0530, Sriharsha Basavapatna wrote:
> > On Wed, Mar 4, 2026 at 1:20=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com>=
 wrote:
> > >
> > > This flag can be set by drivers once they have finished auditing and
> > > implementing the full udata support on every udata operation.
> > >
> > > My intention going forward is that driver authors proposing new udata=
 uAPI
> > > for their drivers must first do the work and set this flag.
> > >
> > > If this flag is not set the userspace should not try to use udata bas=
ed
> > > uAPI newer than this commit, though on a case by case basis it may be=
 OK
> > > based on what checks historical kernels performed on the specific cal=
l.
> > >
> > > Since bnxt_re is audited now, it is the first driver to set the flag.
> > >
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > > ---
> > >  drivers/infiniband/core/device.c                  | 1 +
> > >  drivers/infiniband/core/uverbs_std_types_device.c | 8 ++++++++
> > >  drivers/infiniband/hw/bnxt_re/main.c              | 1 +
> > >  include/rdma/ib_verbs.h                           | 6 ++++++
> > >  include/uapi/rdma/ib_user_ioctl_verbs.h           | 1 +
> > >  5 files changed, 17 insertions(+)
> > >
> > > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/co=
re/device.c
> > > index 558b73940d6681..5b4fb47cbaeee6 100644
> > > --- a/drivers/infiniband/core/device.c
> > > +++ b/drivers/infiniband/core/device.c
> > > @@ -2706,6 +2706,7 @@ void ib_set_device_ops(struct ib_device *dev, c=
onst struct ib_device_ops *ops)
> > >
> > >         dev_ops->uverbs_no_driver_id_binding |=3D
> > >                 ops->uverbs_no_driver_id_binding;
> > > +       dev_ops->uverbs_robust_udata |=3D dev_ops->uverbs_robust_udat=
a;
> > this should be: dev_ops->uverbs_robust_udata |=3D ops->uverbs_robust_ud=
ata;
>
> Oops, are you OK otherwise?
>
> Thanks,
> Jason
Yes, it worked with this minor change.
Thanks,
-Harsha

--000000000000510dd2064c33faa4
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBJz7vTD4Z50Y+u2eB16pfu99T9xWLvxY3J
51yQqCgU2TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAzMDQx
NDUzMDZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQAzZrFFZm8sV7D/1pz02ssXAoWP77C9hkuloQhbgWT1RvLc94sGvmGwjgD6jS5ZFoO0IfN2
8FTIYXBFAU2GydmTEu3X17x2U22wn7239YDJZo15LZkFvUT/xlwOtzxH2iVW/xsZhnF59qRq5PTZ
tPopuWR3u+lx7OxBhD/Uv00upaIQhIxmqp8LaTDsHzcDoRmkmxCry/yoGpApDalJRjdmr0MW21VN
IFAUNodkCeYM/g3UCwqcVHvnZKKJWB3teMbwb/+e7cirmRKLTHY60qjUlpwXRJsHY0cW62kXFMRe
ZPgr9QwYZWWjwdAMQEZqoukz3evMc5v5/WdTdEg1sHw4
--000000000000510dd2064c33faa4--

