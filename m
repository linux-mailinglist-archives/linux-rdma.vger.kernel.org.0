Return-Path: <linux-rdma+bounces-15789-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHUSK340cGkSXAAAu9opvQ
	(envelope-from <linux-rdma+bounces-15789-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 03:05:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B59F64F7C7
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 03:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 323469021B5
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 02:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A516329392;
	Wed, 21 Jan 2026 02:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Qp9Z8GTU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33CA320393
	for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 02:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768960979; cv=pass; b=sNlpiGkpXmIGRiBt1ZSFRQJsniuA3GDlYE7d0BrWQ/snQaF2/3gnOoyKUrlC81gX1HOjSX4qLnhC1AqlS1cCecxfgC0LyOPV/LJTPpiYcd8u+TR5+tb58H0UfqnonT0rNPO9wz5nn68qarb1TWuY12nGN/vRmpXOyIKMvRvMVho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768960979; c=relaxed/simple;
	bh=J1T65TvlvaQLWFyDfvxf4ts99Fr6EJh/JBYE5tQdHmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOvwZi3U46HczhK77u74L/ZzQE+QgDZRbbFrlfQpsSVRrhgyBGpcXdaTRNiPiFQXUGWRMvhJlCia4bk/GOUJO5dbI74LgzZhdwUOLhFaW3z4NHnQIsPeTPs5k2citssTV7qPMvNrBTfl0+ZdCAzM7cqStR9DevsTBBu0ISct+uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Qp9Z8GTU; arc=pass smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-c54f700b5b1so3582227a12.0
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jan 2026 18:02:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768960972; x=1769565772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lfzPRfsPfF0VM9H0ma0dW/S2Y2spRl6qJNAfIj660U=;
        b=rNfKbzLfj7kund/wA+58P71EkTv6gRGUO1rqoF7GH0nTaVYVqXjIE9xNh+ktW/VxZl
         PHDagOtcUIj8/Gy8IfIN9YEcoyeu2GGMCKeKqqEuvtO/vK1XExt2ZevHj9VyOm+onji2
         sPoCi3vnyOMslxKkUngGWF4PgeewsXnDVRe44iQntFfTDDjpjSwnzk0H3UKFPRGMa1s8
         wmB0GtNgdgCsMXUorXfJR1XMvlQ/M3adRHnIykrfxjhTHiG5H7MN6laGwLPxJVnq5ehD
         Hl1ymHt2ssPe8cefK8hVf810PFGZEGOX/EH8qcaeMLzkyrYRhPka+qUJRdDup73cyqQR
         nWqw==
X-Forwarded-Encrypted: i=2; AJvYcCWIuO1K4Bru+UuxFPrIyY0gzDsKh8Q8WzTbA/ihQgATdjJurdiqfsmx9a9E05xu7IiYm3seXY7BU5Bb@vger.kernel.org
X-Gm-Message-State: AOJu0Yz64p76Va0IqqVvkjY7V/vA2XbqBJCnyUgxSvO6dRQjVnd9Q7bQ
	wfqWAUOPhcZzM0qpVbQ2g8pyN+8Akyi7j1edLOVqDYZUVzf7X3cnmPqFsvbrVMto1csUrW8YdRt
	ZrBkrjjgOnj14yPLIYYuEAWnrah2/C5nue04ukAVNDyN6I32Ix5NHdV/anOgBFUbPmmhYrYHErj
	IoCErW3XTctR693RvQ7Nygu0eq5kLf5TFYjr6siIdnLxqz8FqkJwEeJpRQKQHWtfNVeLqKcs1iA
	1ocM8p7/BztnzNYnRVv4Cjz4T5c
X-Gm-Gg: AZuq6aI5DExGXeOpIZSziKb3ubrYyXpTXn4qztie3vX6BxmfrYZIlhmUcvAPmI/T/iL
	jM+4kLqo92EjROFHWeszg9u7AWzVbmIEyz9PgOI65aX2XbxpyX1qMJu297uc+VqBfbu4/Xj3dc3
	7oc1AHyjxsExCIxijAlE7B696XlLlku85Zc8PpKQKijONAEAmdlEmLJ8DR5OlC3aqodhnepbLrE
	snHt6An6TQPSu76cmnugmVXsOzUBYkxnsp6RmkgDDjEmRoZuvaS/LwyhsvlWT9rYZa7g+/uf7hl
	Uzvamj9znpSVpXU2sHhbAAglYLF+vRMwjt5Hv8cvd2LJlC2+ilEh7jFQx77D9FIR21GqGnhj7ZP
	1EiJ/pQMmPIPc9vesc9QOqhbcqwqxXQNCnItObWiVHlIxIIwJKT6LOeviXySvogP3THff17Khda
	YMsajvc6nTLORJHFVHPJqCBPdzo0cjCxuaRlJqcRXHmYffjOHoRChq69oXoUw=
X-Received: by 2002:a17:903:2ecd:b0:2a5:99e9:569d with SMTP id d9443c01a7336-2a71887c84emr169444285ad.18.1768960971958;
        Tue, 20 Jan 2026 18:02:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a77d36a696sm3279625ad.34.2026.01.20.18.02.51
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2026 18:02:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48025e12b5bso33915965e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jan 2026 18:02:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768960970; cv=none;
        d=google.com; s=arc-20240605;
        b=EZOguA3pnVLK7TPe/kHeIffbe5UIhkFKphxKk4R22vxLW+cO5izEMNGd3VBIcWiWv6
         bYCIGa4LYVa6gscboFm8wFDxpSOrMismdGPt7Ezb5x5YT9nkE86Yw/TAFFMcUWRxaMT/
         F+E0x0GvBvTbeDGiXviypHby6iWk52HQcFnyqxvS7tap0QbmHv7xD5iW+XwrwAGB3C2O
         NijpwlLr1u0k+ac5ocj4Tv2Np6RmXjhzc0l7CJHhruJxoVhvaa8BJ7gbwED2AFKJJ74t
         +RYC/FsmbwlfR7x1B6tyFKQndnOFre4y4ZCoYgyriwapvlfaU1NwT3gu/3Yd9GB+IJmw
         X14g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7lfzPRfsPfF0VM9H0ma0dW/S2Y2spRl6qJNAfIj660U=;
        fh=wOYpzdK7RdToQMcprE4eDFByhXCH8DrobQpmCrcLTdA=;
        b=O5KhVlJOAFytnryP9mX8oq2Y5cujCNstP7cpnjh4AS72xiFg2dS3y1B3Dp5S5DeS15
         0nS5fViMUc29zX9V+9uW8HPIiOeXykQlv8fB3/33gH9tUrz0JPMu1YFgBLjva4H7YC0S
         LXBNwZsrQzBxtjIyAcZppjqf/VkmmxyeJnegs4+5te/bSKgGp0HwzGuRv5PhQ8ukZPOZ
         cA6sIz9xM8JTJzs0ReYMVxC4MjU9g5QNlRGqMDqbAveiIzGOKNUuKJat5xSjoe1WcJTt
         VOvzIQgU8/nW/IC37YOwzTf09h/h4E1KmCZBe/MTXkCh0Sl/0ovz7UVGFadnluNxlOxp
         ZOSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768960970; x=1769565770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7lfzPRfsPfF0VM9H0ma0dW/S2Y2spRl6qJNAfIj660U=;
        b=Qp9Z8GTUz6fyPlbLZ6CcAy3pXNfTCgBLfjaA1poYAXBh+qfpstSd7H/ZFtNm0vs6NP
         xvyuH9qv8PyiCcfyGJYec5BoSGh009p0w7skN0gg5vo4fyPMCXTaLT12SnYEyTnZCDxe
         GoIZemly+oA0aL9+Vct0lEqtNIf+mUv6Gx22Y=
X-Forwarded-Encrypted: i=1; AJvYcCX4UUxO4J+ZndKDjrqWGaIc+wpgOVsuvA+Cqa88HYa7GTga2gf5QiEHFMjC7bAHprWumSeyHD19P/Fw@vger.kernel.org
X-Received: by 2002:a05:600c:8b0c:b0:47e:e2ec:9960 with SMTP id 5b1f17b1804b1-4803e804534mr49912285e9.35.1768960969896;
        Tue, 20 Jan 2026 18:02:49 -0800 (PST)
X-Received: by 2002:a05:600c:8b0c:b0:47e:e2ec:9960 with SMTP id
 5b1f17b1804b1-4803e804534mr49911975e9.35.1768960969429; Tue, 20 Jan 2026
 18:02:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260117080052.43279-1-sriharsha.basavapatna@broadcom.com>
 <20260117080052.43279-4-sriharsha.basavapatna@broadcom.com> <20260120185419.GU961572@ziepe.ca>
In-Reply-To: <20260120185419.GU961572@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Wed, 21 Jan 2026 07:32:36 +0530
X-Gm-Features: AZwV_QgfeCD5rHRpW0sd8tAu0Sp8im2BK9_rUclv8dVjcJIQedgjMzHnd32TLY8
Message-ID: <CAHHeUGXtiDezOVwmFJ3y-0daHD_3ENayqtDJUSHnDE9rVRiAKA@mail.gmail.com>
Subject: Re: [PATCH rdma-next v8 3/4] RDMA/bnxt_re: Direct Verbs: Support DBR verbs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000040b0f50648dc523e"
X-Spamd-Result: default: False [-4.06 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[broadcom.com,reject];
	TAGGED_FROM(0.00)[bounces-15789-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,ziepe.ca:email,broadcom.com:dkim]
X-Rspamd-Queue-Id: B59F64F7C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000040b0f50648dc523e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 12:24=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Sat, Jan 17, 2026 at 01:30:51PM +0530, Sriharsha Basavapatna wrote:
> > diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infinib=
and/hw/bnxt_re/ib_verbs.h
> > index a11f56730a31..33e0f66b39eb 100644
> > --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> > +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> > @@ -164,6 +164,13 @@ struct bnxt_re_user_mmap_entry {
> >       u8 mmap_flag;
> >  };
> >
> > +struct bnxt_re_dbr_obj {
> > +     struct bnxt_re_dev *rdev;
> > +     struct bnxt_qplib_dpi dpi;
> > +     struct bnxt_re_user_mmap_entry *entry;
> > +     atomic_t usecnt; /* QPs using this dbr */
> > +};
>
> This added usecnt but it doesn't use it
>
> It is supposed to prevent destroying the object by the user out of sequen=
ce.
>
> > +static int bnxt_re_dv_dbr_cleanup(struct ib_uobject *uobject,
> > +                               enum rdma_remove_reason why,
> > +                               struct uverbs_attr_bundle *attrs)
> > +{
> > +     struct bnxt_re_dbr_obj *obj =3D uobject->object;
> > +     struct bnxt_re_dev *rdev =3D obj->rdev;
> > +
> > +     rdma_user_mmap_entry_remove(&obj->entry->rdma_entry);
> > +     bnxt_qplib_free_uc_dpi(&rdev->qplib_res, &obj->dpi);
> > +     return 0;
> > +}
>
> For instance CQ did it in the above function:
>
> static int uverbs_free_cq(struct ib_uobject *uobject,
>                           enum rdma_remove_reason why,
>                           struct uverbs_attr_bundle *attrs)
> {
>         ret =3D ib_destroy_cq_user(cq, &attrs->driver_udata);
>         if (ret)
>                 return ret;
>
> int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
> {
>         if (atomic_read(&cq->usecnt))
>                 return -EBUSY;
>
> So this patch should be doing the usecnt check as well, otherwise it
> won't work right.
The consumer of dbr, which is qp, is in the next patch. So the actual
usecnt logic (incr/decr) is in the next patch.
Thanks,
-Harsha
>
> Jason

--00000000000040b0f50648dc523e
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBoHJOEantjKP8DcAulD31Xcbqmx11xMhJc
4sKmDNwBbTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMjEw
MjAyNTBaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQAoL7Zh1Yz/Lhr3PVLyHzc6isHE/0K2yYucnLsvTR3IWbWX279cnNk7w56bS2nMI6k6J1s8
lFDO9RLSLLA3Ovyx+L/Tf4At3c09OYQw5jB9ZGc+yT4hc8HC1X6atDvQgOr8ZwjqEkjtMTRMgvpM
5QwFtRz0IyJOlwOwOKt8ruS4cYYWWCPUDmsl06uNBqs1slb061dPWArm4CwSqnRKXdUC1rowPhxt
zMwEwllEbYt+DP23CMNMBcCqzA18doaN1MFwjNhVq3r/kXPxJRKPDNrGCruRNiYvXql20EgLrzJ/
zeFc/VUy5B+G778CYT0uHfXH40+CBM3X/DJ3ffDUDDQR
--00000000000040b0f50648dc523e--

