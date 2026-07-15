Return-Path: <linux-rdma+bounces-23264-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dfZYOglPV2oRJAEAu9opvQ
	(envelope-from <linux-rdma+bounces-23264-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 11:12:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5485F75C4B2
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 11:12:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=Py3IxgyU;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23264-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23264-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F2E230B98F9
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 09:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF173EA953;
	Wed, 15 Jul 2026 09:05:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f97.google.com (mail-vs1-f97.google.com [209.85.217.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEC1335064
	for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2026 09:05:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106305; cv=none; b=VCMb3UPQ7nX9g7aFOYhiNvdB+BZNCT+XtdfqX48Bkn5+RC1W556SLSaOgkfiRtwWtaKL5uiKSWz4FjlEvarIexMwyz6tkLiF8BZ83bheEg1qBn1XxYmvIn3qqWwA4Dg27Eq7g4xq22YrGJv31bQzDZWodDWsYlFvpkBSTOcnajM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106305; c=relaxed/simple;
	bh=gMpDnY0dUWNEfGuS509Plg3cbFHYx1QAwqfkyy2F2lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOTFNVrhbTohLauIAJdX+kLiIx3CJXaJTPXU87GcJM90E72M8qmhXnxkGPGKQhUvVsR9IYHvzVQZBTaBf8ovAVHKUgBDMwoCyRQOLtLf1Vg8rYmmRpilQOA3SyCzJhCf+Hitmus4UVEE/mB69lupn/jlCN4m1cfHh3RZNjQWnRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Py3IxgyU; arc=none smtp.client-ip=209.85.217.97
Received: by mail-vs1-f97.google.com with SMTP id ada2fe7eead31-73f6a641f6eso1725181137.1
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2026 02:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784106303; x=1784711103;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WTSpH406W32VMPMDef3DFHQwvBWUFBTkkelzJcVvCDs=;
        b=C3KAmhmjZVbJY84KkkZF5yH8DSYbOZe/y2RcwCkjdEx43Tpa3OFOr2oX0g8in4MDq7
         igzRgjXIJyQvAw7piy8M3JhhCcrpHkaw+RxTtkg5EvLytFo7QVDSx0fW/Hz7Presg3it
         1i2swDeO6Sn6K9FdAcq/ryIVe6dGJdJlHMIGtVWAsCWut02IW4MAxeKm3VHeQnAh84Zn
         FWe1aYnTyR5fSBZSWEOI+rS3GFRecXZ9p15+IxeSJJfSaMoINq2WIanCq+gM0xcW1Zpp
         HHfsPFaz9KThA+r4knkxZ4gnK8s5ggF96STa5Ur6LMEBr/Qz2fjWWY2VMX6o6ENfCmvt
         Ya8A==
X-Forwarded-Encrypted: i=1; AHgh+RoBf5qOq9Qv1evl5prO1TEi4otcfoxvZC8x4pJQOYP8leXycx30fmkFWyabIc7hQUogiulypjvBAtnZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ4zfVSdovf0Mdd+fckIKOUjFLoqeJSRtjSDyE6ZHySWJYDkyt
	IVErlga/LAJvSuWxwedQS/yBMfFo8dJsY3DDdObpm0H14ZSWbcxOtQBCJvAB/PaUvqMrYwhvWug
	PzVj6cZmjDoj1Ef1hia5JTUEmhN+/GxzWbzMFClFW/9xjwO5kMMIAwfxQL4J2P+08YlzGtEbp/E
	+bBHFyshWXPsjtfYP3d19nqZtptGup1BzvgPoQyMgiblqis3u6YBckV7DkJbLVUBZRaMNWp6m0Y
	W5Fi9UzPXZAr5Bzcg==
X-Gm-Gg: AfdE7cl2K0tRqEJSxyQwiL6tkNIcG67wt6GkZlAtBeCm2fEtiqVIB+iMz0y/boj84Lx
	r6ErMDGCH5b195nmuOD3T/pvzQxPiDiI6O1q73T/Ks0TK35hY/+LeE5lrls2MMuM8IouwqM6PHs
	+ags2mbLGDT3c9TqIwBENsAL+WWaA59aG3CifKtAbI1fdgmyhKwwl+obbwTMAEGiFlQ7klKztrb
	cWUfF9RSIyPxdXdAhHWJlfaOZ3wfNk70LbUffzP/4BnjPH4GwzskzLkitKbxtEhoB9maaSr4fpT
	lD7SMj8xOpXvNv93bS/Z+Lpi/kG2rkVrkQ72LTKA3fxb9gZHMlKaFyEmp9XeQzfBi2KKlmYQ0Fj
	8jOOmiiLB3bUusQowZJdmXXrudW7em4I0UVQZcNAQtV9l0lIBqPtas3iP69GNyg7pd/6Yy7xzjO
	feo08ZvEkh4ExphCcguBcbXkMfALkP4fc/Q3/q88zdid2PYAXMIQ==
X-Received: by 2002:a05:6102:2921:b0:744:d5f9:ffb1 with SMTP id ada2fe7eead31-74599fbe8d4mr1094997137.16.1784106302766;
        Wed, 15 Jul 2026 02:05:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-744d6a2d88dsm1705431137.1.2026.07.15.02.05.02
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2026 02:05:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6a17ce8b08dso2958527eaf.3
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2026 02:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784106302; x=1784711102; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WTSpH406W32VMPMDef3DFHQwvBWUFBTkkelzJcVvCDs=;
        b=Py3IxgyUc44cpX3KnJ2c4MJdqVgzkmwOdxk5VaDc0xUWUOg9ub13BXsiQMbEPOMHUa
         +z5c6wJ/MyipdiPlPylC8KhbagGFVHTsIyYp4Q2lid8mpcm5TA9ci2iDHki35lqYnf+l
         /bsMX1DEzgDoacFpGvmlVjQixuB+lyySXSA2I=
X-Forwarded-Encrypted: i=1; AHgh+RpTxs2G6Sb1zJ7jfqf7wKFxhyr3kmZhCjIU6DUsNKNNxUTwmrPaVqBWNZhZxum8GGd6mL9gfRZKOL5w@vger.kernel.org
X-Received: by 2002:a05:6820:81f:b0:6a1:8c8c:abd7 with SMTP id 006d021491bc7-6a3d9f2200dmr987224eaf.16.1784106301617;
        Wed, 15 Jul 2026 02:05:01 -0700 (PDT)
X-Received: by 2002:a05:6820:81f:b0:6a1:8c8c:abd7 with SMTP id
 006d021491bc7-6a3d9f2200dmr987198eaf.16.1784106300883; Wed, 15 Jul 2026
 02:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714-fix-destroy-no-udata-v2-1-734fdcf667d5@kernel.org>
In-Reply-To: <20260714-fix-destroy-no-udata-v2-1-734fdcf667d5@kernel.org>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Wed, 15 Jul 2026 14:34:48 +0530
X-Gm-Features: AUfX_mxA6K5wqkPUDjOKUUIfSJnXbiZJRub7Dxt1sE4DwejnmClhSZzIW8VySiA
Message-ID: <CA+sbYW0b0FL-DYm+iNaizi7pWm9YoYAAQ9CBFO1QDjHTfa2w-A@mail.gmail.com>
Subject: Re: [PATCH rdma-next v2] RDMA/bnxt_re: Validate udata before
 executing commands
To: Leon Romanovsky <leon@kernel.org>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jacob Moroni <jmoroni@google.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005f81830656a29e7a"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-11.26 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23264-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:kalesh-anakkur.purayil@broadcom.com,m:jgg@ziepe.ca,m:jmoroni@google.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5485F75C4B2

--0000000000005f81830656a29e7a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 4:20=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> The destroy callbacks currently zero the udata output after tearing down
> driver resources. If the userspace access fails, uverbs preserves the
> uobject and allows the destroy callback to run again, even though the
> driver resource has already been freed.
>
> Call ib_no_udata_io() before teardown so udata failures are detected
> while the resource is still intact, then return success after teardown
> completes.
>
> As part of this change, move ib_respond_empty_udata() to the start of
> the create and modify flows. While this is not strictly required for
> general create flows, as the core layer unwinds uobjects on failure, it
> is necessary for create AH. In _rdma_create_ah(), the HW object is
> otherwise leaked.
>
> Fixes: bed686d8dcd4 ("RDMA/bnxt_re: Use ib_respond_empty_udata()")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>

> ---
> Jacob, Selvin
>
> I didn't add your tags, as this patch was slightly changed from the
> previous version.
>
> Thanks
>
> Changes in v2:
> - Changed create and modify paths too
> - Link to v1: https://patch.msgid.link/20260713-fix-destroy-no-udata-v1-0=
-fcca2e34fd57@nvidia.com
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 65 +++++++++++++++-----------=
------
>  1 file changed, 30 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniban=
d/hw/bnxt_re/ib_verbs.c
> index 90138d64adee..adc693736769 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -694,7 +694,7 @@ int bnxt_re_dealloc_pd(struct ib_pd *ib_pd, struct ib=
_udata *udata)
>         struct bnxt_re_dev *rdev =3D pd->rdev;
>         int ret;
>
> -       ret =3D ib_is_udata_in_empty(udata);
> +       ret =3D ib_no_udata_io(udata);
>         if (ret)
>                 return ret;
>
> @@ -711,7 +711,7 @@ int bnxt_re_dealloc_pd(struct ib_pd *ib_pd, struct ib=
_udata *udata)
>                                            &pd->qplib_pd))
>                         atomic_dec(&rdev->stats.res.pd_count);
>         }
> -       return ib_respond_empty_udata(udata);
> +       return 0;
>  }
>
>  int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
> @@ -843,7 +843,7 @@ int bnxt_re_create_ah(struct ib_ah *ib_ah, struct rdm=
a_ah_init_attr *init_attr,
>         u8 nw_type;
>         int rc;
>
> -       rc =3D ib_is_udata_in_empty(udata);
> +       rc =3D ib_no_udata_io(udata);
>         if (rc)
>                 return rc;
>
> @@ -900,7 +900,7 @@ int bnxt_re_create_ah(struct ib_ah *ib_ah, struct rdm=
a_ah_init_attr *init_attr,
>         if (active_ahs > rdev->stats.res.ah_watermark)
>                 rdev->stats.res.ah_watermark =3D active_ahs;
>
> -       return ib_respond_empty_udata(udata);
> +       return 0;
>  }
>
>  int bnxt_re_query_ah(struct ib_ah *ib_ah, struct rdma_ah_attr *ah_attr)
> @@ -1014,7 +1014,7 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct =
ib_udata *udata)
>         unsigned int flags;
>         int rc;
>
> -       rc =3D ib_is_udata_in_empty(udata);
> +       rc =3D ib_no_udata_io(udata);
>         if (rc)
>                 return rc;
>
> @@ -1063,7 +1063,7 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct =
ib_udata *udata)
>         if (scq_nq !=3D rcq_nq)
>                 bnxt_re_synchronize_nq(rcq_nq);
>
> -       return ib_respond_empty_udata(udata);
> +       return 0;
>  }
>
>  static u8 __from_ib_qp_type(enum ib_qp_type type)
> @@ -2147,7 +2147,7 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, stru=
ct ib_udata *udata)
>         struct bnxt_qplib_srq *qplib_srq =3D &srq->qplib_srq;
>         int ret;
>
> -       ret =3D ib_is_udata_in_empty(udata);
> +       ret =3D ib_no_udata_io(udata);
>         if (ret)
>                 return ret;
>
> @@ -2158,7 +2158,7 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, stru=
ct ib_udata *udata)
>                 free_page((unsigned long)srq->uctx_srq_page);
>         ib_umem_release(srq->umem);
>         atomic_dec(&rdev->stats.res.srq_count);
> -       return ib_respond_empty_udata(udata);
> +       return 0;
>  }
>
>  static int bnxt_re_init_user_srq(struct bnxt_re_dev *rdev,
> @@ -2296,34 +2296,25 @@ int bnxt_re_modify_srq(struct ib_srq *ib_srq, str=
uct ib_srq_attr *srq_attr,
>  {
>         struct bnxt_re_srq *srq =3D container_of(ib_srq, struct bnxt_re_s=
rq,
>                                                ib_srq);
> -       struct bnxt_re_dev *rdev =3D srq->rdev;
>         int ret;
>
> -       ret =3D ib_is_udata_in_empty(udata);
> +       ret =3D ib_no_udata_io(udata);
>         if (ret)
>                 return ret;
>
> -       switch (srq_attr_mask) {
> -       case IB_SRQ_MAX_WR:
> -               /* SRQ resize is not supported */
> +       if (srq_attr_mask !=3D IB_SRQ_LIMIT)
>                 return -EINVAL;
> -       case IB_SRQ_LIMIT:
> -               /* Change the SRQ threshold */
> -               if (srq_attr->srq_limit > srq->qplib_srq.max_wqe)
> -                       return -EINVAL;
>
> -               srq->qplib_srq.threshold =3D srq_attr->srq_limit;
> -               bnxt_qplib_srq_arm_db(&srq->qplib_srq.dbinfo, srq->qplib_=
srq.threshold);
> -
> -               /* On success, update the shadow */
> -               srq->srq_limit =3D srq_attr->srq_limit;
> -               /* No need to Build and send response back to udata */
> -               return ib_respond_empty_udata(udata);
> -       default:
> -               ibdev_err(&rdev->ibdev,
> -                         "Unsupported srq_attr_mask 0x%x", srq_attr_mask=
);
> +       if (srq_attr->srq_limit > srq->qplib_srq.max_wqe)
>                 return -EINVAL;
> -       }
> +
> +       srq->qplib_srq.threshold =3D srq_attr->srq_limit;
> +       bnxt_qplib_srq_arm_db(&srq->qplib_srq.dbinfo, srq->qplib_srq.thre=
shold);
> +
> +       /* On success, update the shadow */
> +       srq->srq_limit =3D srq_attr->srq_limit;
> +       /* No need to Build and send response back to udata */
> +       return 0;
>  }
>
>  int bnxt_re_query_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_att=
r)
> @@ -2436,7 +2427,7 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct i=
b_qp_attr *qp_attr,
>         unsigned int flags;
>         u8 nw_type;
>
> -       rc =3D ib_is_udata_in_empty(udata);
> +       rc =3D ib_no_udata_io(udata);
>         if (rc)
>                 return rc;
>
> @@ -2688,7 +2679,7 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct i=
b_qp_attr *qp_attr,
>                 if (rc)
>                         return rc;
>         }
> -       return ib_respond_empty_udata(udata);
> +       return 0;
>  }
>
>  int bnxt_re_query_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
> @@ -3470,7 +3461,7 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct =
ib_udata *udata)
>         nq =3D cq->qplib_cq.nq;
>         cctx =3D rdev->chip_ctx;
>
> -       ret =3D ib_is_udata_in_empty(udata);
> +       ret =3D ib_no_udata_io(udata);
>         if (ret)
>                 return ret;
>
> @@ -3485,7 +3476,7 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct =
ib_udata *udata)
>         atomic_dec(&rdev->stats.res.cq_count);
>         kfree(cq->cql);
>         ib_umem_release(cq->umem);
> -       return ib_respond_empty_udata(udata);
> +       return 0;
>  }
>
>  int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_a=
ttr *attr,
> @@ -3687,6 +3678,10 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, unsigned=
 int cqe,
>         if (rc)
>                 goto fail;
>
> +       rc =3D ib_respond_empty_udata(udata);
> +       if (rc)
> +               goto fail;
> +
>         cq->resize_umem =3D ib_umem_get_va(&rdev->ibdev, req.cq_va,
>                                          entries * sizeof(struct cq_base)=
,
>                                          IB_ACCESS_LOCAL_WRITE);
> @@ -3716,7 +3711,7 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, unsigned =
int cqe,
>         cq->ib_cq.cqe =3D cq->resize_cqe;
>         atomic_inc(&rdev->stats.res.resize_count);
>
> -       return ib_respond_empty_udata(udata);
> +       return 0;
>
>  fail:
>         if (cq->resize_umem) {
> @@ -4448,7 +4443,7 @@ int bnxt_re_dereg_mr(struct ib_mr *ib_mr, struct ib=
_udata *udata)
>         struct bnxt_re_dev *rdev =3D mr->rdev;
>         int rc;
>
> -       rc =3D ib_is_udata_in_empty(udata);
> +       rc =3D ib_no_udata_io(udata);
>         if (rc)
>                 return rc;
>
> @@ -4471,7 +4466,7 @@ int bnxt_re_dereg_mr(struct ib_mr *ib_mr, struct ib=
_udata *udata)
>         atomic_dec(&rdev->stats.res.mr_count);
>         if (rc)
>                 return rc;
> -       return ib_respond_empty_udata(udata);
> +       return 0;
>  }
>
>  static int bnxt_re_set_page(struct ib_mr *ib_mr, u64 addr)
>
> ---
> base-commit: eeb9697db6c16d9bb2ce7b7ddf95aa20305aa9f2
> change-id: 20260712-fix-destroy-no-udata-dfa990b985ea
>
> Best regards,
> --
> Leon Romanovsky <leon@kernel.org>
>

--0000000000005f81830656a29e7a
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
1CD2pD5RbAT9SOdRFSptHLSZAA1j70/79rA1x8/p/pIwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYwNzE1MDkwNTAyWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEANH0MN6ytw7DxGrlx4MJ/lBMCbB/RoQUP+L+P
te7+FnEb9OPsIcudC46ByV0LUBHs8hW5fTnvmPMJOzvqPTplS6yY6AIcLYrYGoeWmIPh/9/DFzRQ
7+cjj6Tm5/ChA5pyOxRw31Hv2jlRbiQomkc1uQAqK9u1l+w8QXhslg0SsrGLLmtqgp2PJ8rchBZ0
zNrfUnsk1daHJB3RVGlrUNBEzb+WlXdofjhaDNeDAxTrm8f9QFgxsqNqeT9b7NWJguLOPLSZrvj8
izWAF004I1t9GK4hM+FZwFCRNlTJ1BBJgwCestoWo9io0aPskWbcnjF4IZN8p8v8w1I9bZ1mUnOe
TQ==
--0000000000005f81830656a29e7a--

