Return-Path: <linux-rdma+bounces-16748-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APL6HBpnjGkdnAAAu9opvQ
	(envelope-from <linux-rdma+bounces-16748-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 12:25:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE268123D57
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 12:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EBBF300F13D
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 11:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B623E36B064;
	Wed, 11 Feb 2026 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FsceLoEZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com [209.85.210.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388E135581D
	for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 11:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770809111; cv=pass; b=gCbBYnT4ez+btB+wjFF7KmlgYmhcZEck0iadWZw+jMQ3pIB11EUKN8ZKFmIsAr9IqSHxrHxPHcbAdiYn9LIMJrZ3hAwA4yx5SqachNSU5WIAJWD0jCsn9Rxfe4cj4BLH7+PXM8jQBFuhFDfrqT59KtpvfkMLztup4uOy69nSE+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770809111; c=relaxed/simple;
	bh=gtbaCkrAPJoYQtglaBP3HjiTo66pOBmoy0x6jlGKj6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mHJka4sTPpt9sbNUIF2gNVDHnXJouM5l2P3LfUImXyUHKWT+m5iNyZf3pbVCiPJ2pN550rJwHik13tcuHweAgl7FknUtGLmorZbWkU9jVl1oQSPYamzE9sJEdKtssWyV1VXDVRekEFC/K1bEi4RgX78Vlz89t+eFeurJuRHl614=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FsceLoEZ; arc=pass smtp.client-ip=209.85.210.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f99.google.com with SMTP id 46e09a7af769-7d18c654458so2495754a34.3
        for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 03:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770809109; x=1771413909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGgJhZjwryNQf5iiqIdONgNlNvvKKUL/mlqvjEeT0fI=;
        b=OtHkyd+yZ6iYPqXWHIMkkTnK3jU7LwRyHKTn7k/Nyd0Yn0h0458sR04Zr7QtPYkvO6
         cH+PH6io3izlGFrDwBv4tnEutfv/NjcL3Yw/vDBmA7qcyF8HueYUMclEljNsdGsSwZv1
         fjn1tbdcVwTHN/DDnkjz8VA3azZAUMTpsTATWun9b98ehbWkNLjdY7OwijCccww7F+mY
         F38eN1uOVNQQ8DaYEW9jV5aSMUCap1L8bU82kihORaOaJRu9o1mW/bg+KPw6p34MZd+c
         8L2hyygbcN+vabDz8pAN6RxGGD8nTq/rLyG/NM7xMrKVjXPsQt49e6L4EYnF0bPk8SQM
         lo4Q==
X-Forwarded-Encrypted: i=2; AJvYcCXvEECDukirWwVDHqgvQPA0GperumFhT59RwcJSX1j2RqpnH/lU9EfmDYskHLwFIjFVudoAEyz2m4sT@vger.kernel.org
X-Gm-Message-State: AOJu0Yzce/C8dVhaNAUaNCl02YlFJ5ND1kSEkveqHPJL3ut4BlXZp+2C
	/wNkL/2VtVEmFtCohyvLwfM6PAZjXlIaXR6amYy9ZGmWq0ZVXdZROb0IC+DcP3ucSyfuE4EUyiH
	V4JdpVejU6c7PhRfYyDfp+2zYp/B72g4ZjqVJX31nBPEp5ZNNrDRxyyMKRRRGkoC/OOLsJXCipz
	SRWTQK3hcXsRYAYSeE7tT5GD7IOBLVk411pr+BL8q7gpLqIi9Y4HAt3hJxv7UC4IjvEUt94ZxCv
	apc3kHNp4twg72KvKEsTAYXAbOZ
X-Gm-Gg: AZuq6aKVgrxIO0u0Wr8RV7qVLrTHy8DxXCc6PPBBQIs0Wf2JD3zZJB/3mmseXfQaZir
	s6XiqD9OvWBn/VRRWYPyhefh+n1jkoupjSWwniN/dAjRplitMNv7NcvrDm1AjBNcYeEoGj5wat9
	2o6Y2g79Y5EhaJTa4em7g5MTauo94HJg5dfASHVpjAhh0IJWKpChihhbJPUIYBV3kvCt68nbNxa
	WRY5C+QKPNuBYRCnG9B3+p5wisVE1C4Od7e8jIJAt0fBF62z93UQtRXmxjXmsZqhDtG4pcpqCG1
	2dUKvKpA9t3UFTRXm4+Wd40nHYGtOGJx387FQpN8K31ybBQdV0tUgB505VwbtX1pFz97q1rk9MI
	c8+sOS2G5r9rTfa0+o9njmmMFpLdpJA2TYo/LLYZcsJ2jveRFxhblHhGKnEctNLX3mGAZ8+H9dG
	KhyG7Da5vWC+mn2Q+GDnVluZtyRTf8//X5OmSs3IyyrLjalccWkRypnbkhsFsYGSFszNs7RL0=
X-Received: by 2002:a05:6830:67ed:b0:7c7:63b6:89d3 with SMTP id 46e09a7af769-7d4998a4c1bmr2236701a34.19.1770809109002;
        Wed, 11 Feb 2026 03:25:09 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7d4a75cfa5fsm244432a34.6.2026.02.11.03.25.07
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Feb 2026 03:25:08 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-483129eb5ccso27040605e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 03:25:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770809106; cv=none;
        d=google.com; s=arc-20240605;
        b=XMCTE/SLrIVRKWFZu7+UYAPVaH50ln2Y6bpa9yx8CdtiV07ZHiLK/ftIu/TBRjkMAH
         7cNgjfzv82d+NDjhWW3VKmuG3FciLDskMvZhH79WZeHmU1B/45hy9WLwSSRls7X9rFdr
         t6fgMDUUxjuLRm4JCcgN2sa7BYSg4UlXF+McxPFM0VjLgzqmYAs9iYUQpFfPxbNLcW9I
         6YmXnQJ382ZMAhR5pVis28pHjUKR8R/sKECL2gbix+tzfMHR2P9HiEnEqpkWMK1YNph1
         d54Suwt0OBRC7YI+et0Mrjg2uKuzD1eca7OVfOkQt5GPMXt+ChlCNzzPKqyKQTyWBCbb
         Bihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QGgJhZjwryNQf5iiqIdONgNlNvvKKUL/mlqvjEeT0fI=;
        fh=sYxuOS8W/XRBrkt+0y1HYwejp+6vvWf0+oxX368E4D0=;
        b=KSQhx5epUynDta94YmK0cmFh3s4n+mNZRfpjsLTlKIJRZzj1aUgBoOVWGiVw7Uuwts
         XIALDmSHBZDq81N5zJ76EHHOFb1HKamDHq5va9q0xu/CZadzgE2C9uBRSehhZCO0dlFd
         WBNd//f9a+fAu9dXwqF19Y+0sL1F0TdVyKcH8vo6nPB8/g+BdsaWePNpNwFAzPbgZ/At
         1p9cfw/9vnKbNqGi5+ePw5sbC9pkAiToheGQAXfzfHW34JgQVfi//8GOkh6OBX1L7+MH
         M6jobceVphW3Zg4t0kjplu7Qa68qwuaRXnzHsCMc5Jc7l1B/D3jLS8qOb+r8eeO71gap
         gnDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770809106; x=1771413906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QGgJhZjwryNQf5iiqIdONgNlNvvKKUL/mlqvjEeT0fI=;
        b=FsceLoEZV7V15z4J54BZfUD/lnDDjRHsRymGszaWYkXBDkPKstdg6piYhKdEFC75uD
         Oe5HCFaRxcQoY9+ayZBMB6DcNI0y6oIt4zww6uEBnD9RA6liqiuNk6CVYzAvQ8Mn/4JL
         e0ost4cMZ70kWgbfpjuolDXl+qAYY8EPCS5Eo=
X-Forwarded-Encrypted: i=1; AJvYcCWSDB75Th1NKEInbXzwprxGWeeZ2As2a7Hmk7GSk2QVzG6cy6TU7lbqZ2awHFfRAoVp+dRDKq52LLCH@vger.kernel.org
X-Received: by 2002:a05:600c:4f8a:b0:480:3230:6c9b with SMTP id 5b1f17b1804b1-483201dd004mr262820285e9.7.1770809106368;
        Wed, 11 Feb 2026 03:25:06 -0800 (PST)
X-Received: by 2002:a05:600c:4f8a:b0:480:3230:6c9b with SMTP id
 5b1f17b1804b1-483201dd004mr262819685e9.7.1770809105850; Wed, 11 Feb 2026
 03:25:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210165939.41625-1-sriharsha.basavapatna@broadcom.com>
 <20260210165939.41625-7-sriharsha.basavapatna@broadcom.com> <20260210191449.GE750753@ziepe.ca>
In-Reply-To: <20260210191449.GE750753@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Wed, 11 Feb 2026 16:54:52 +0530
X-Gm-Features: AZwV_QhYjIahknoFgViLDH7FJ06Qc21ADz-qzQ9iMGQr1zA-iYVyCLCMd_HVxa8
Message-ID: <CAHHeUGXT74wdVa_awy6pcL-N267xstHuFHH3rC7LKU0b1_=-nQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next v11 6/6] RDMA/bnxt_re: Support application
 specific CQs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c76501064a8a9f4a"
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
	TAGGED_FROM(0.00)[bounces-16748-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CE268123D57
X-Rspamd-Action: no action

--000000000000c76501064a8a9f4a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 12:44=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Tue, Feb 10, 2026 at 10:29:39PM +0530, Sriharsha Basavapatna wrote:
> > diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infinib=
and/hw/bnxt_re/ib_verbs.c
> > index dc73f0072528..04588b4f79c0 100644
> > --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > @@ -3372,6 +3372,9 @@ static int bnxt_re_setup_sginfo(struct bnxt_re_de=
v *rdev,
> >       return 0;
> >  }
> >
> > +static u64 bnxt_re_cq_cmask_supported =3D (BNXT_RE_CQ_TOGGLE_PAGE_SUPP=
ORT |
> > +                                      BNXT_RE_CQ_APP_ALLOC_ENABLE);
>
> Don't mix req and resp flags together!!!
done.
>
> Also don't make a global static variable, just pass the flags directly
> to the helper.
done.
>
> >  int bnxt_re_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init=
_attr *attr,
> >                          struct ib_umem *umem, struct uverbs_attr_bundl=
e *attrs)
> >  {
> > @@ -3382,6 +3385,7 @@ int bnxt_re_create_cq_umem(struct ib_cq *ibcq, co=
nst struct ib_cq_init_attr *att
> >               rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext,=
 ib_uctx);
> >       struct bnxt_qplib_dev_attr *dev_attr =3D rdev->dev_attr;
> >       struct bnxt_qplib_chip_ctx *cctx;
> > +     struct bnxt_re_cq_req req =3D {};
>
> No need to zero memory being passed to ib_copy_validate_udata_in_cm(),
> it always writes to the whole struct.
done.
>
> > diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_r=
e-abi.h
> > index 1f7685665db1..26eeb78193fa 100644
> > --- a/include/uapi/rdma/bnxt_re-abi.h
> > +++ b/include/uapi/rdma/bnxt_re-abi.h
> > @@ -103,10 +103,12 @@ struct bnxt_re_pd_resp {
> >  struct bnxt_re_cq_req {
> >       __aligned_u64 cq_va;
> >       __aligned_u64 cq_handle;
> > +     __aligned_u64 comp_mask;
> >  };
> >
> >  enum bnxt_re_cq_mask {
> >       BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT =3D 0x1,
> > +     BNXT_RE_CQ_APP_ALLOC_ENABLE =3D 0x2,
> >  };
>
> The req/resp comp masks should be kept separate.
>
> The name should be much more specific "BNXT_RE_CQ_EXACT_CQE" or something=
.
done (BNXT_RE_CQ_FIXED_NUM_CQE_ENABLE).
>
> This is all alot better now, thanks
>
> Jhason
Thanks,
-Harsha

--000000000000c76501064a8a9f4a
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDlDXNLNpZ7Fv1OvG3dA6sGJTP4pEzZAPER
D2JAx+hjJzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAyMTEx
MTI1MDZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQCXylWYvRRmvOsf9kRINAs+wdnsg9RHngBjkKOAPzLUXISZPoXd0KEEPqtwSL1KOvLi8tv2
lsmjAs5FDj48vtVLxiMoN9cEWu6XmlIlZZkSMFea/ji5PpL0prZnKqdUvHxgah2/SIWL4SScG0g8
KxgNf++NKq4Os3+K2o1QN/XhokheTfTr0wsqKqSeImme/UvEdNHM9CnqSaRkXTZMiDFQjfCw+iWQ
K2rBCC9CtXqfC28DJcS/2BdihKh0Ru6zLmUBkOIHMjmS8Zelnq83DPj6E82EThS2vM4/viE1x/rb
Pu2QBAgiwZbB1e0WayDRc0DdJmHCtx3V9IsrFA7TpYhK
--000000000000c76501064a8a9f4a--

