Return-Path: <linux-rdma+bounces-16340-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC+pKzS0gGl3AgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16340-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 15:27:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C04CD53E
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 15:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6056B3062235
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 14:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF65C36C0CF;
	Mon,  2 Feb 2026 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NqMp7XEf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87B636C0C8
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770041966; cv=pass; b=p1oz56/V2cBQi320xHIGsQawmf84qFVIt9cq89lpG5+ROxA5MH8wAMb5JGDHW/gCog9RYkliFFQyhQaHE4D8lTSe0rSzmqDvA0pkzpHcyeYQ/kANnWaBjJPTTYL/HRitDsiVjojIPEHGEZyMSkjydavDgnPYVvtX/7UMf4bk+gY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770041966; c=relaxed/simple;
	bh=D/YiBKaO/T8r2FQRPMPu1IFkvwX3A0mezICjEC+d2f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsZnZ+KEXetQXsKI1hYWxyT1mnFSyQukod10cvnTkv+BihulAsUh/jeL1ppdN0gdHxTphN8Dd15HQTsAnIde5vdLEMEBWoeAUkPVzjGxqIgHaZTKY6lOtlogyEydxv42ILXEwIQpovCvXCzCi0giPfIKFwAhQl39C6gCgrNrqGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NqMp7XEf; arc=pass smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-823c56765fdso1139936b3a.1
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 06:19:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770041964; x=1770646764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfOXuqj74TC7uVYdLSw/4IpEZfsiivcRXMsPpj4legc=;
        b=Xb/5Luic05DLkwfblsLg/B7pUEnKTjnMuAT21JhEVyW2CghrH/c9p/eP4fPZII5Bs+
         FtBKg82vs0qEU8L1YoofkqeCzudwG8QvojtoIPBCCvWnkGK4OML4ryJE1efL4bfQVEMr
         8PBer3pfPGRnQim90ee41RfI4Tqq8BbzF343mLbpYlvTePJNNrSLBxDRIb2YqevVtukm
         kxpU+2PelBlml0dAUomIU5DeyUyJdFrBY/3zNntd5kETBsD3LmEYpw+a6CFMK3OwL7WK
         5v+S8204mDFl7DQ2jgk/uatOorYqb28gWFMXWMZzajMRibeM2kkn8ZlAg4aBOVdEm1K5
         HE0w==
X-Forwarded-Encrypted: i=2; AJvYcCVZtO+G+TC3mt/ieDDR7lgjOgbogIbE7k8RUx07PxmyvtXnHjZBgguVTfjDdoGYxvqqXqSA+9oQgEfM@vger.kernel.org
X-Gm-Message-State: AOJu0YyBfkY+Lx2COQwQ2OtiEqz+bRy1y2iRGv90BClLva8TgDmEaUUz
	bYn7j9tQ0adiB51ci4jjd6Knh5oWYymF10jsMFHllXMb2t4oEzDs38xPHvmjt1Vp7aSP5umExTq
	btT52miRJdsiyXqxCuPLJ7loKYlOb4ZcImLI757H/+NRZ932Odn2MO0MUelkJHL331zJgSLi0pa
	QrRXCc6Cvw6Ft1Z/NBDU98cT5CjwTnqQiu9GibAKrFvweisqvGn60x0ADVtdPXHw3ofalUGCUkl
	ehsI4CAot1LfSy0R1uwUNSvoa9i
X-Gm-Gg: AZuq6aLfE9xcTBE52gQMQU3H1AdVscw1vEG4pKxohypB8aTtxt/9+WLCalrTSQxviKA
	YPhfhOSQnauj0UKFa4MDyaD76hScPAoU4ppqZyrQM85TnE0iQXsvrIA0RTulXflLLyglHG9OXav
	pBKEB65AkuYoswAWYj2ojXjwrGYl1WLpLigyZbm/7YDzzyhC3iVmF9zWc0R4On2mUNrjyIkRZXG
	tWifjqtINXOXEpzDYF1aptEsQzNgBIFDLOtqUvt4LTObcUMZ6lFV+OWMEWWGKRopfn+UUZUAhJe
	yc5QUjMePf7PIXET9Z1lwfJHlSN8uyvAdnpV07SMEA+UjrIkbKTd+vXYGtLhrcjQmM/Ydb4SOu3
	qjOMcpZrmWWkMi0WaL917lE9t8bXSkCTb0k+BCQjK119D78DdTWYeKdURjL9KekUe4BKMH2a4Ec
	RNAixwc1zvC46DqI0u7E++7YzEKrtX5JUSjkPXm06OB1ie+Yklld+kWQ==
X-Received: by 2002:a05:6300:6682:b0:35d:6b4e:91f1 with SMTP id adf61e73a8af0-392e007f2e6mr11070027637.34.1770041963708;
        Mon, 02 Feb 2026 06:19:23 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c65a223d382sm948483a12.9.2026.02.02.06.19.23
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Feb 2026 06:19:23 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430ffc4dc83so4734802f8f.3
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 06:19:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770041961; cv=none;
        d=google.com; s=arc-20240605;
        b=jbpskNc8cn5ia50eYjKh0jUP04W19HOqLseS5BZEQPj4LFrQCthCeDMMy5MS0bbe6Z
         akcFncyJjeSXbZaepnCKturbndOreJdBzPlB2+nTIgMfCaLYTRndD/09L4W80kjAAeBG
         QQr1khLXE+JPBLl4Q47IN3aWe3Gjffpae4Eif9jBxRAB7z5VP3q1gdy6oFL1axbwZEeL
         wTboaN5Wd7NWiv7Cf7n0gsQSGWR1NbXFeW9L4oIFWRO1kBl4qyMclnGaPSJ50Z+nVU0c
         30Hqyaou6HGLXSjfZRk/0rPQu0+IjLUzdjuP9i8B1UzlhtzJrPvD5fukLHU7VunVUb0R
         Dc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SfOXuqj74TC7uVYdLSw/4IpEZfsiivcRXMsPpj4legc=;
        fh=MNjoWWOsVDef/JMyDfOC3r9n2Z6SDPhpWGlvWKQqT7A=;
        b=TVsM8nCBxJeoqJ//U6lq5iUNusUs3kv11VlkeBcIHrQFVQ6U/lQahjFv1BSEHfGpGd
         WUSSqs8pSJ4XNxVMZ8XTxYK4P5GVOfK9SwhxqFKE9lMiOe7Z3S/lYLHxTMTSlMg3nDRZ
         OGUKWdFUVVX4xFdUBT9+RxJtkNPTfAhDmQzs6k3tX5UDaf3DaRM5qQHN3OEy75wB+gCO
         asAMkW4wOPIo+8kDIeGhcG6aKEVa0b0Fc3MjP0kB/vZl1gPm7ClNn89VD5fWbao1GD1C
         zXW34UK9YYTrWAZ9xuMnqooEOQB/lp9yEQuHO/ZV1CkCWYDGLQvtWZ+cuHJjgyMroeG7
         zBmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770041961; x=1770646761; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SfOXuqj74TC7uVYdLSw/4IpEZfsiivcRXMsPpj4legc=;
        b=NqMp7XEfdiU2WdIxLpowbWexPeqXn6s7arv95OjDyAVml30HbdySQUGJcc8lgRPv22
         zk1M6Sv/dMJJmspmH5iPSeE55uLbIp19UkkIeBatLuyNCD4/vP7+9At8QUmKcD3Jtvbc
         V8+gtziMak1Db51XsxiEJ+INu+FgKnV8ub0Nk=
X-Forwarded-Encrypted: i=1; AJvYcCX7HvpGIqA58UJCu/EspY0S8fIpkHjXtCxtB/aASvuwfgG1xbTTlmHD9dw+LkaIE5k5n3m7XJ+mclO8@vger.kernel.org
X-Received: by 2002:a05:6000:1863:b0:435:a136:b891 with SMTP id ffacd0b85a97d-435f3a6a7e0mr16313885f8f.13.1770041961328;
        Mon, 02 Feb 2026 06:19:21 -0800 (PST)
X-Received: by 2002:a05:6000:1863:b0:435:a136:b891 with SMTP id
 ffacd0b85a97d-435f3a6a7e0mr16313834f8f.13.1770041960819; Mon, 02 Feb 2026
 06:19:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127103109.32163-1-sriharsha.basavapatna@broadcom.com>
 <20260127103109.32163-6-sriharsha.basavapatna@broadcom.com> <20260128154654.GM1641016@ziepe.ca>
In-Reply-To: <20260128154654.GM1641016@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Mon, 2 Feb 2026 19:49:09 +0530
X-Gm-Features: AZwV_QjxglT9P_5oY989KX9uSj94Ityf_lUUayXxv60bKnZ_1a0_xsUbFaVw8-s
Message-ID: <CAHHeUGXq08KCjS_MiuxvQFtybnfFmo2Z3k1_zYF2KmXF=mUBAw@mail.gmail.com>
Subject: Re: [PATCH rdma-next v9 5/5] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005c7d1a0649d802a1"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16340-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:dkim]
X-Rspamd-Queue-Id: 04C04CD53E
X-Rspamd-Action: no action

--0000000000005c7d1a0649d802a1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 9:16=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Jan 27, 2026 at 04:01:09PM +0530, Sriharsha Basavapatna wrote:
> > diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniba=
nd/hw/bnxt_re/bnxt_re.h
> > index 0999a42c678c..f28acde3a274 100644
> > --- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> > +++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> > @@ -234,6 +234,8 @@ struct bnxt_re_dev {
> >       union ib_gid ugid;
> >       u32 ugid_index;
> >       u8 sniffer_flow_created : 1;
> > +     atomic_t dv_cq_count;
> > +     atomic_t dv_qp_count;
> >  };
>
> Why? Nothing reads these? If they are stats then put them in your
> stats struct and return them to userspace. I'd drop it and come later
> with a user visible stat.
They are debug counters, deleted them.
>
> This patch is really big now, can you at least split it to cq/qp?
Ack.
>
> > @@ -459,11 +463,454 @@ DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_GET_D=
EFAULT_DBR,
> >  DECLARE_UVERBS_GLOBAL_METHODS(BNXT_RE_OBJECT_DEFAULT_DBR,
> >                             &UVERBS_METHOD(BNXT_RE_METHOD_GET_DEFAULT_D=
BR));
> >
> > +static int bnxt_re_dv_create_cq_resp(struct bnxt_re_dev *rdev,
> > +                                  struct bnxt_re_cq *cq,
> > +                                  struct bnxt_re_cq_resp *resp)
> > +{
> > +     struct bnxt_qplib_cq *qplcq =3D &cq->qplib_cq;
> > +
> > +     resp->cqid =3D qplcq->id;
> > +     resp->tail =3D qplcq->hwq.cons;
> > +     resp->phase =3D qplcq->period;
> > +     resp->comp_mask =3D BNXT_RE_CQ_DV_SUPPORT;
> > +     return 0;
> > +}
> > +
> > +static int bnxt_re_dv_setup_umem(struct bnxt_re_dev *rdev,
> > +                              struct ib_umem *umem,
> > +                              struct bnxt_qplib_sg_info *sginfo,
> > +                              struct ib_umem **umem_ptr)
> > +{
> > +     unsigned long page_size;
> > +
> > +     if (!umem)
> > +             return -EINVAL;
> > +
> > +     page_size =3D ib_umem_find_best_pgsz(umem, SZ_4K, 0);
> > +     if (!page_size)
> > +             return -EINVAL;
> > +
> > +     if (umem_ptr)
> > +             *umem_ptr =3D umem;
>
> Why?? Just have the caller store to the right variable.
Ack.
>
> > @@ -3324,12 +3418,11 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const=
 struct ib_cq_init_attr *attr,
> >       cq->qplib_cq.sg_info.pgsize =3D PAGE_SIZE;
> >       cq->qplib_cq.sg_info.pgshft =3D PAGE_SHIFT;
> >       if (udata) {
> > -             struct bnxt_re_cq_req req;
> > -             if (ib_copy_from_udata(&req, udata, sizeof(req))) {
> > -                     rc =3D -EFAULT;
> > +             if (umem) {
> > +                     /* Standard CQ (non-DV): use req.cq_va */
> > +                     rc =3D -EINVAL;
> >                       goto fail;
> >               }
>
> I think this should support the umem interface here, it is trivial
> right, just skip the below if the umem is passed:
Ack.
>
> >               cq->umem =3D ib_umem_get(&rdev->ibdev, req.cq_va,
> >                                      entries * sizeof(struct cq_base),
> >                                      IB_ACCESS_LOCAL_WRITE);
>
> Jason
Thanks,
-Harsha

--0000000000005c7d1a0649d802a1
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAo0KUEbWtaxBgYDaOdPRm6eDUHOInfzj9j
J7nazSlQYjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAyMDIx
NDE5MjFaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQA+IFX7h4LULblzZoRl7XXBR8xu+s4ADn8iMXCeLX4FQQ6XdtkcKvrMJGZvRpzc9QD2K1i8
El+hYM7QYPVB8kor6jaiS0NGzGcFGqXkYDs+/erxZTLJlSj3ye4a9wKLk9DdjIrfU9NA2mZ6p7WB
svqUgbmjIbfo1tpwaSPR0TIQojQOeOy3TxvW3OFdtbjHGtfP4vatP0R/dlKItWPr+GiNCE7u/Qar
u+OgGYH4Pk/lpCdLK94bZmnMFVBZMdNbTFgXiTXOUwve1mI6pwJLuPp0Z4efmUI7y27K9YoVD1D8
/ailf49t1wFyLK0b18C+DuC7Tqg+pgXEXYIHvX1Jxwiv
--0000000000005c7d1a0649d802a1--

