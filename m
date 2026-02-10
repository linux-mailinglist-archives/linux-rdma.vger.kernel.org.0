Return-Path: <linux-rdma+bounces-16726-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MV+Mkhli2kMUQAAu9opvQ
	(envelope-from <linux-rdma+bounces-16726-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 18:05:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7AA11D86A
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 18:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D63DC303428E
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 17:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF14C325702;
	Tue, 10 Feb 2026 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HiDctiDh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f97.google.com (mail-vs1-f97.google.com [209.85.217.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2443254AC
	for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770743085; cv=pass; b=W7Mp2ibroPrYnXf2y8Hyn93mRs6Y/GTg0SPC53PMX1GVuF5STh74/NtOz3M9c3kxzt7QWNvWqrYWlVd6qdqz4BJsVFeEYxL/97JepWLmfv2GpqB+4eIVcqdyPLGs6ACfSvOZW6gPSfK3HNj6QbMcKIwhue3rh19dp33V4BA97p8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770743085; c=relaxed/simple;
	bh=yheYI4ybNWc3w9T0uIgz2PUsQNmy9zEcOuoqjglMrfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2+OTZlADFRL3SZw/xUBmV5uEpVdqRG6AN8z//ONOYqrujtwWnfphWlvb6BVrHo1P8C18sUrTqSGY9ciKLm/5OXEv1Lh0n+Bdvc8H5tpn+Y75GXuB+zZIATYhlzgnP8Q1TkDqvliQVWsCETa+vgKta1d7lvOi6PnoRxuqc6tFtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HiDctiDh; arc=pass smtp.client-ip=209.85.217.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f97.google.com with SMTP id ada2fe7eead31-5fc66c4a052so129002137.2
        for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 09:04:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770743083; x=1771347883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTPStklYPVqXmdgCUhVVjbQQKR5tNh44fAaCdTxcRC8=;
        b=q6c4zoGA7CnffvlPoDGNqtUU2dHR48NWDEDrAFiWu04aeWSJGxAiJ3U+ZLFkmpzro7
         4gNgkm7L7hLtcV0D5AKRCG7aghnvAKgLWEF3y2xcoCifA1e6X81drSaTVfdsgq+ZeFXt
         ckcM8jyr6Lh8NkgIkZclJI8LXpa1FUkkIk7vhfMRHIx1IFlqaRlTpL5etMPUvi3j7QqE
         UNUN/ZZUKBvs1Xq2iwRO0lgyXuOLwH2Qwflp7flFBNHXe2E89QGAKZe8pKLz+FPKj4Fu
         mmTjMNz/XSd1cVEPkL1tUy82q6pEwjVPhmyWCKgyhbWRNoImkz2c3ni9nkunXYKzxWFx
         o1kg==
X-Forwarded-Encrypted: i=2; AJvYcCXoiOidxqjwMwmsMYTvqPgE42hP1ofm0SqyCRrvy/JgIBqMjbkqqO+cRvo1IbcTraSRSNA6jG/myDFt@vger.kernel.org
X-Gm-Message-State: AOJu0YyMsTtEY6judsxN0FKVW/iJTxTVeksWTzMhFbIFVHjyXuthdIDj
	sL7yv7w+71tAC3Q+RA3+Viua7I62mioGR/GqYCF7/hwu87I8eGHfdQ3ti7yrow4senr3zrP7xnz
	M4G2GyNFgy2GBvyfowsAV3vRY+gXU06B9PXANAkmHSqwRqQ6479tNmjsxe44qruJYW/NlHLcxTg
	bfldPD94F6n9PRKEJnVRVvwUZ1H1ZMe1DnTTBt9YSMH0sb8Ktb6WnQrLfwLLC7GrQj3r58wNInX
	/UyZgmMj//NE9HLFnxJKVKF3+fN
X-Gm-Gg: AZuq6aItpEmRn0j2l4iIsd1OxvFV1C71qO2A5abHswPRKmL+7TvY2LGMPonnIayx/V6
	awCQyxcOjqo6RJ8d0QAdb66J7I/X5aQOwAOt8yidzxaCv8mLngZazv/gKuiHph8TYKDP4giwjnC
	1EBsslZGi5qrBBGo7kbtcXnu0Hin7lEAXDT2hf9lgFdIDX4OX1viX/Uwp1vEWR3lBmK7zmhYCHl
	fxks/aXeVg8l5WIh8NQoT9UGpqeYq1gOMCOdgy+5bEAFakpit9E+D/yDNe2Nm1Dek553D0dNfw/
	hqjLtQGii4P4ydgc3QeXBgtj/AB9RVqGUR1H/5flLFcvJ1NcEGcjYRvIv417ELC8EhOyfUGLFpa
	6ZxIsyF5/8O50AP5dJLY+CXxyW7d50HaLxWnNPMEKZN2Tgw93PGsaRkh7/l9lUTmhbYehY2OHAh
	4jVGeFydbunAp8evbiU4VcSnkOcRZNwUYSBUZlPiahh1OqBfDAxFACeb+K1aEjRMC+oHsa
X-Received: by 2002:a05:6102:290d:b0:5df:b5d4:e45d with SMTP id ada2fe7eead31-5fae8c05495mr3882443137.33.1770743081561;
        Tue, 10 Feb 2026 09:04:41 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8caf47b1f33sm196145085a.0.2026.02.10.09.04.41
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Feb 2026 09:04:41 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43591aacca2so929091f8f.1
        for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 09:04:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770743080; cv=none;
        d=google.com; s=arc-20240605;
        b=AKy7niOykW0lNDZCakgs9FGRjOm2wlmKpfHEpv6WkFpyKOv4iKE23mgUIQilD6oZ33
         VJU386CmabEh98+0YwHS5MNEcrKfn0vFiyyXTLZ+ip32g/RO3NuEoLmCg2b+kcxCy/gs
         KfbYs+qFQ4oH9939bTJDywuE4tLuBJaq3rY/ybTfL5dnPjnlpuVWvKSI7Z5Gqi5BSFJ0
         a5i6RP0Z7ZtauU4H2QjFR37etFpx9rKV3lYYK3w2AojOhnZiHtL894jnCYLfyZwU0eZ6
         lv7dCt+275LRMD9BoMDEjf5l5ifFj3w5OLDUw4xG6OQjKjWvv56y88etzbuaTXdJMvlf
         ERvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZTPStklYPVqXmdgCUhVVjbQQKR5tNh44fAaCdTxcRC8=;
        fh=HtxYsaK92tMI/B3FitVKLo8UK2S7KClKJLcF6PNMqf4=;
        b=GBFFwHrBHoh/NCQwhRb5K0RX4IB1xmB8g6N+ramhKISchzFdjo3xfitJ9mSwztcK/d
         bivSkTGvKzn4if1Na4lMjEqlJWYwk8ZTMZRbKJvDtMqx/mZusq5hpZidhK7m0O+AXPK2
         SsLgMVlcIU+oyYHPva8JRQ7OiPpOxxpJ6HxRdbYjUQBLpAh1MPj+q0BDbUHyzZUfpoWW
         oLrT3bEpw5IoytPnTdTxZHtOqAHWZlMWu8ltfuN1o4l/+BKrV5VlNiWaipW24wEMTquv
         LNkWFQz0+tMipnGhqzOZKDdvmQCqw/TO3+nKYu8IdvUPnZYh5nU+OT4600Pb/UKkG7Wh
         EFYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770743080; x=1771347880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTPStklYPVqXmdgCUhVVjbQQKR5tNh44fAaCdTxcRC8=;
        b=HiDctiDhIil1T36xHQoxbZMQ/AwxvlYFOpggMQaowzYbl/NklPa9H7RKFYPg+KN+nR
         82gOA48JHVtO9ZedwE9xzZUSbZVqYwCeavqmR44RdQTeTis+PG3DYa/u0mVwoZQUP3jw
         2g+VNMH9G1uiKnmOY62zXY6BxUi9udXbNQ1a4=
X-Forwarded-Encrypted: i=1; AJvYcCU9v10Rie64bfVuC4r5gD8wdhSAlKe7W6Wis+hHnr/V5Xj5GGG1A0zGZ87XzL7q+D0mxhRUcb56/4bG@vger.kernel.org
X-Received: by 2002:a5d:5d85:0:b0:437:6c2b:2f52 with SMTP id ffacd0b85a97d-4376c2b31ccmr11655868f8f.14.1770743079855;
        Tue, 10 Feb 2026 09:04:39 -0800 (PST)
X-Received: by 2002:a5d:5d85:0:b0:437:6c2b:2f52 with SMTP id
 ffacd0b85a97d-4376c2b31ccmr11655827f8f.14.1770743079409; Tue, 10 Feb 2026
 09:04:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203050049.171026-1-sriharsha.basavapatna@broadcom.com>
 <20260203050049.171026-5-sriharsha.basavapatna@broadcom.com> <20260206134921.GE943673@ziepe.ca>
In-Reply-To: <20260206134921.GE943673@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Tue, 10 Feb 2026 22:34:26 +0530
X-Gm-Features: AZwV_QgElYBIiZRVjFpCKMdBVGNbUFt61wEaK3MYDp0JWCIfxJSkDXpOgSMvUYY
Message-ID: <CAHHeUGWU0mhi_i3mop3si6mGvtK0vnP5f1DLaqfXXTrRNMo9tw@mail.gmail.com>
Subject: Re: [PATCH rdma-next v10 4/6] RDMA/bnxt_re: Direct Verbs: Support DBR verbs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004a2ee8064a7b405a"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16726-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:dkim]
X-Rspamd-Queue-Id: 1B7AA11D86A
X-Rspamd-Action: no action

--0000000000004a2ee8064a7b405a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 7:19=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Tue, Feb 03, 2026 at 10:30:47AM +0530, Sriharsha Basavapatna wrote:
> > --- a/include/uapi/rdma/bnxt_re-abi.h
> > +++ b/include/uapi/rdma/bnxt_re-abi.h
> > @@ -162,6 +162,8 @@ enum bnxt_re_objects {
> >       BNXT_RE_OBJECT_ALLOC_PAGE =3D (1U << UVERBS_ID_NS_SHIFT),
> >       BNXT_RE_OBJECT_NOTIFY_DRV,
> >       BNXT_RE_OBJECT_GET_TOGGLE_MEM,
> > +     BNXT_RE_OBJECT_DBR,
> > +     BNXT_RE_OBJECT_DEFAULT_DBR,
> >  };
> >
> >  enum bnxt_re_alloc_page_type {
> > @@ -215,4 +217,31 @@ enum bnxt_re_toggle_mem_methods {
> >       BNXT_RE_METHOD_GET_TOGGLE_MEM =3D (1U << UVERBS_ID_NS_SHIFT),
> >       BNXT_RE_METHOD_RELEASE_TOGGLE_MEM,
> >  };
> > +
> > +struct bnxt_re_dv_db_region {
> > +     __u32 dpi;
> > +     __u32 reserved;
> > +     __aligned_u64 umdbr;
> > +};
> > +
> > +enum bnxt_re_obj_dbr_alloc_attrs {
> > +     BNXT_RE_DV_ALLOC_DBR_HANDLE =3D (1U << UVERBS_ID_NS_SHIFT),
> > +     BNXT_RE_DV_ALLOC_DBR_ATTR,
> > +     BNXT_RE_DV_ALLOC_DBR_OFFSET,
> > +};
>
> I think this patch is OK now, but please remove all the _DV_ from
> it and the commit message.
>
> This is just a way to get more doorbells into userspace and userspace
> can do whatever it wants with them.
>
> You can explain the commit message some of the motivation for why your
> HW needs mutiple doorbells, that would be helpful.
>
> We shouldn't be using the "direct verbs" phrasing at all in the
> kernel.
>
> Jason
Ack.
Thanks,
-Harsha

--0000000000004a2ee8064a7b405a
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCD3TlHfESqRMFkmGJf8/M+1bpGP15wgF19H
DjIEFOGA3TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAyMTAx
NzA0NDBaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBZQtU2l0ovuw0Gt1kJfnDHBFO5/zjZtpy4QI4CO74xpIA7681jeLtd+HhyWyX4Rk+L0OjA
h+CgQ50Vvv130suKVdCbDsEugyjqakQiKfwXsbpJv7dbhNHuHRndkhP+nrDD796lZ0EJrbhtzTHg
g9vcdxF0h2c78ikArVgqacAW0xi+PG5g6wqEVpGcrjpQd7nvsYjjzOhFfxzVzvVBpcREDTSW0r0j
/36Kllt9R8SFhM2SeKguYNHysVnoduxlQE1E3yKAHFjmwPwbEkuwvYqpqZdbZjgcVvgbJ/Co4lol
w7kfKLt3sw00AyJV2K4bwqOMsjV2bxs/D06h00Igf3rC
--0000000000004a2ee8064a7b405a--

