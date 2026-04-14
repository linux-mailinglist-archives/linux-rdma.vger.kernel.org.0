Return-Path: <linux-rdma+bounces-19318-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CKZBT7b3WnukAkAu9opvQ
	(envelope-from <linux-rdma+bounces-19318-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 08:14:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D573F5E11
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 08:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA25A303D327
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 06:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D3B30C368;
	Tue, 14 Apr 2026 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RgDO545Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f228.google.com (mail-oi1-f228.google.com [209.85.167.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D012C40DFD6
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 06:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776147256; cv=pass; b=jUJOhXNObmhRpPiP9UhH1MonttvH7xnOSOwel6ds4HeslRVX88M11I1xJ7r/bRu9GFEM2b7iVaMA5BahGOPDSfSBaGRTQNkUG3w53LJmsMInr46X1UWvJH3OnQQgnouCbSWwnpiS4SP10w+9wkCQZEwqhG/ZdoWC+EMpMu7XMaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776147256; c=relaxed/simple;
	bh=6pK3wQBsgP5P+fiGXl2aAstvI+/0jTW0eX64W5eOL3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtFxtH/CQ5Fn1Lccf8pKxnL+mvFfBcrqP3KOm3O49DsIvzNOgi14ZVPMVr+dpz8XC4Ll8OoTmFkaB48F9C6ETqRwZG6lDjG4MKwxcYl1HkPxEvJf04CuUi9U+9r/UGe8g1SDFe9oEWOWv4HQb2Ei4phrys1GmSlWveDDVoZtetM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RgDO545Q; arc=pass smtp.client-ip=209.85.167.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f228.google.com with SMTP id 5614622812f47-4756e74f8edso3619900b6e.1
        for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 23:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776147254; x=1776752054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyVTWr/Z2BSqM9LQ0rcovlQkU7sZdjt7ue30jel9Ips=;
        b=fNead2yTaL8KouoL6blYofMte+GyYkZtUXNPgrmxN11WRcVw5iEqR6Oac+tc5I9oQ1
         1nWZiH/9sMEgLMEC+p/z8BbfMy/643mH6GGLHoDk5s4ImAcwTNrrM+p/aX/HIh9/uk6o
         5tMwuW8Tjy9j8b44A3gicwyniLJE7ZrX7SphMVt01z+qe2oP4DOFD6dIn1gTkCw6DF4y
         Ogvno7zs6a4t2TsLu+jPu/z7K5Yar3eZrWa2RLwPKLNzxYxOLApOPpS+h+/Jnk6LY5Jb
         xY6doj7wwr+WrFeOjlSMCeZA1sCNQs1hRA6LDahmQNnPcIYepU/wraQB9GboYd4he8jc
         HYQQ==
X-Forwarded-Encrypted: i=2; AFNElJ8ZlOOUYCQBCXEQCs2i3uQNBsND6MSuIoN1AZnwyk0yLC60rZ6d/whdXs3ir66BEQWE2Y8GSWNGDyE5@vger.kernel.org
X-Gm-Message-State: AOJu0YxegXNJO0XrUemGxvPav3W8fVRbn/sDFaXt6thrx7J7O8+y85P0
	QqAHQmHVY33wHqnvWzpds6wF3Jj/A3LF32G8kKe4hUJJDodPq9ml1afmtHunDPCz3Jrk97Rlmc0
	Tle5DUiiHK6VWCkD4feCaiSbPUaABXaqvGKPgSLcSskUoC7qvDbFJvl8W7gUZRb2OZiSs4Kx13n
	UXRqi8drpmZ5YxHkoHGUQAfQG3b42JiknLVhuKnI4KVDuUv9ksk5VWIM62n5HP7EotGL9n8MTS/
	1le4rNK26zdro7WEFQM9HVVNTzw
X-Gm-Gg: AeBDievM0+4CgHgbfC85bc6B2gmOLUYVFtCNX/v0vSXIcGZMZgokSqZ4oIkx0MpwvRh
	60WvM0CMYh+lo5qRjeRishltYWm8slK/OzZIBc3IvXeppsnakPwof7F+1QpA0c/anphfFvAFOiZ
	afn5sa/+hOrymc8FX2mXurw9lXp8EHCbkSG68pCgkgYQNZc04tcStvtYaTBCbYWVO+6A4kviHZ1
	chGn4GJwon0Z42a9y6RgY2YnsAbrgiTnhWNsHKTHovDR4DH2tON7Fp0CUh2N/ZAmuFnz82H1qbk
	a+hOmlewS0SnQNVh9vkUlZVd8eqZClccaCfOM5RkbY1ldlXw91We5JJz0f+V6Y9pP6XZ7aEMn5v
	cSkcZzsRyTwLdH6rkBmihZRuoFY8QndhhiE9fcDbbS16q8e5tsul4ar+txMzcqg+0Cxcn+DZSHv
	oAeqIZLXkzlb1/5RcQhhUGVIBZDDWdPPsJJkowfdRUcjdot39QqJFconKb0k3hzUeU1D0J
X-Received: by 2002:a05:6808:17a2:b0:467:1e7b:72cd with SMTP id 5614622812f47-4789e71c56emr8453885b6e.1.1776147253672;
        Mon, 13 Apr 2026 23:14:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-423dd788a6fsm1579630fac.7.2026.04.13.23.14.12
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2026 23:14:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35fbaada0caso1777390a91.3
        for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 23:14:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776147252; cv=none;
        d=google.com; s=arc-20240605;
        b=lRidHjwxdfcaESRWT/tU4lltv6HWzP8E2AX/ubJc44kG0XuQx9+Do9jD8+OVRw2zNI
         OsEzIxPqiaInDDAfStdKEwe2YcGcEdtzqLTK8oj4iyscTQknwBtNMGfkpgFL4VLq3n8+
         IhyTXuDhMBrebwiRVFRZ84nmgb1jKV5d1ukb4C32I7g3SGch6xNOvw4xw5G1A3C17Zl4
         tPJyY+OPqkaZmIzW0sbXVz76wYo5vXf9qxXefCEWLItk78bgr5ghYudI/wBWKeHNR3ig
         6XBy4GNTLoObXefKZxj9oLRPhFbsI0T0z3LYYzs3biV0kU+u0cY4tlfTDZy77Rc4i4Yi
         KzSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fyVTWr/Z2BSqM9LQ0rcovlQkU7sZdjt7ue30jel9Ips=;
        fh=+AhMdqLWrk0jIbY9TLQ+6iWUj2H6zunDBSnuy37LA6Q=;
        b=cQ2su0qm75r+gANj8eKbGfCaomIDuJRRcST6WNaROj6+YoB13aLstimto3vu+AMPV5
         TfO4GFNrYYW3NbEN7Yr3dcqfKe6l3Zx/e0MbFrbCM0vJQGWjLpp1thABC1x1phbog6PT
         lqKDpZjaFlX67jg1qsaIqVMUAqg5aUQQwuYNxdxKp2UGAfDw6wIodPMrJ0o9RlS487lv
         t9wR3szgloOgAFFufi+0CYz2mpkL1jSbScPKYMpj5+q4x+VW++s1uKkFNuqxMDU44Hsw
         1drhFecnAYNG6RQN0hiU1jtFNdn20WFn4VDxzQRkZOXVE8fyIhRWRdU/63hh6MTsovVR
         Igdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776147252; x=1776752052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fyVTWr/Z2BSqM9LQ0rcovlQkU7sZdjt7ue30jel9Ips=;
        b=RgDO545Qd+zZyyC1ZYPGmoS0plC88Y1hlykcc+eh5MGCeXAfmf4UXMRLgaKSnUKQcp
         wDp+tgzrtAvVxLM1KEuuCo/VMaKPdZ53ZzZDvrJLl/zIS5fGPO7SITO74jFErxgGqqxL
         BNDF+p1lyBXCx5fCLuj8IWXa74BnPh0LzDevA=
X-Forwarded-Encrypted: i=1; AFNElJ8H+sY8bD4IwqK8PgSUio5KUUV96Vyye8WQeB5dafsCMf/Wkmw9myBq60IW+3dgvxomN8KkJ0WwZxLb@vger.kernel.org
X-Received: by 2002:a17:90b:4c8e:b0:35b:9ab6:1d4a with SMTP id 98e67ed59e1d1-35e4280ebc7mr16555521a91.18.1776147251792;
        Mon, 13 Apr 2026 23:14:11 -0700 (PDT)
X-Received: by 2002:a17:90b:4c8e:b0:35b:9ab6:1d4a with SMTP id
 98e67ed59e1d1-35e4280ebc7mr16555491a91.18.1776147251354; Mon, 13 Apr 2026
 23:14:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327091755.47754-1-sriharsha.basavapatna@broadcom.com>
 <20260327091755.47754-9-sriharsha.basavapatna@broadcom.com> <20260410152752.GY2551565@ziepe.ca>
In-Reply-To: <20260410152752.GY2551565@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Tue, 14 Apr 2026 11:43:51 +0530
X-Gm-Features: AQROBzC3GRBspQ9-bpNRJeLcrnsQPDw10DqF0nDtyXgPdP_qI9H1RjJn0ciAbo4
Message-ID: <CAHHeUGUwCBjho3oJLJdOeTSF3cp1U_DYsN_satsCo4_aEKLWOQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next v2 8/8] RDMA/bnxt_re: Enable app allocated QPs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000924a0064f65821c"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19318-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:email,mail.gmail.com:mid,broadcom.com:dkim]
X-Rspamd-Queue-Id: 74D573F5E11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000000924a0064f65821c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 8:57=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, Mar 27, 2026 at 02:47:55PM +0530, Sriharsha Basavapatna wrote:
> > The driver supports a new comp_mask: APP_ALLOCATED_QP_ENABLE.
> > The application sets this comp_mask bit in the CREATE_QP ureq
> > to indicate direct control of the QP. The driver goes through
> > the required processing for app allocated QPs. Only variable
> > WQE mode is supported for these QPs.
>
> I thought we talked about this, no weird names like this.
Are you talking about the comp_mask name or the wqe_mode (VARIABLE)
name? We used the comp_mask name (APP_ALLOCATED_QP) because the
application allocates (and owns/manages) this QP memory instead of the
library.
If it is the comp_mask, how about one of these alternatives?
- USER_MEMORY_QP
- USER_MANAGED_QP
- USER_CONFIGURABLE_QP
- EXTERNAL_MEMORY_QP
- DIRECT_ACCESS_QP

For the WQE variable mode, please see my response below.

>
> > @@ -1734,6 +1734,8 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp=
 *qp, struct bnxt_re_pd *pd,
> >               return qptype;
> >       qplqp->type =3D (u8)qptype;
> >       qplqp->wqe_mode =3D bnxt_re_is_var_size_supported(rdev, uctx);
> > +     if (app_qp && qplqp->wqe_mode !=3D BNXT_QPLIB_WQE_MODE_VARIABLE)
> > +             return -EOPNOTSUPP;
>
> Give a sensible name for whatever this is and use it only for this.
>
> I kind of thinking you can just fully drop it? What is the point in
> checking userspace set VARIABLE? It isn't signalling HW and it isn't
> protecting anything.
VARIABLE wqe_mode is not something that we introduced in this series.
It already exists and is understood by the FW/HW. In
bnxt_qplib_create_qp(), hardware is signaled through flags.

>
> > -             attrs =3D rdma_udata_to_uverbs_attr_bundle(udata);
> > -             if (uverbs_attr_is_valid(attrs,
> > -                                      BNXT_RE_CREATE_QP_ATTR_DBR_HANDL=
E)) {
> > -                     dbr_obj =3D uverbs_attr_get_obj(attrs,
> > -                                                   BNXT_RE_CREATE_QP_A=
TTR_DBR_HANDLE);
> > -                     if (IS_ERR(dbr_obj))
> > -                             return PTR_ERR(dbr_obj);
> > -                     atomic_inc(&dbr_obj->usecnt);
> > -                     qp->dbr_obj =3D dbr_obj;
> > +             if (ureq.comp_mask & BNXT_RE_QP_REQ_MASK_APP_ALLOCATED_QP=
_ENABLE) {
> > +                     attrs =3D rdma_udata_to_uverbs_attr_bundle(udata)=
;
>
> And don't do this, BNXT_RE_CREATE_QP_ATTR_DBR_HANDLE is perfectly fine
> to be signaled by attribute and it looks like it is fully orthogonal
> to the other features.
I'll update this.

Thanks,
-Harsha
>
> Jason

--0000000000000924a0064f65821c
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBu+mXaSeLAzDSZQg0LVYJ+UwwDDrbtEu3r
gc8efoeCazAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA0MTQw
NjE0MTJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQCHqdtPNv6t5rpr+zsfl8SyYIyGVJ9oc2NY91Qt4/sLVsMmwGCORp7SU9dEdYK1I/wDIrDS
gzl1p0bp8oh6YAVZVTHEOzdq5zQP+ZIqEIbxj+KViTURx9W3ZqoJiJiVV1lFaSwgDtIDs73Wr2CA
oarlc9UhaqAj4rf7SKU16mYd7UFukM4P7+XAdcUQEQrbmX3ObaR9XPwXkP0n4U2Jp+8efnQxFKVC
BpuehJDairCzkuh4eAqPmZUmJDgIPpSTLlP1mi2khiLHNzvko2QLmZweQV0RJIk0arhc0NPsoMUK
A+FTKQBz0yI6/lgzfYo6DC0vhg86rkJINjt3TER0ibN7
--0000000000000924a0064f65821c--

