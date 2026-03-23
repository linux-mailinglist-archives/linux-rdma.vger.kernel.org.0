Return-Path: <linux-rdma+bounces-18507-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ2DNaDbwGn6NQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18507-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 07:20:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 393692ECF83
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 07:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD94C300E727
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 06:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2112F2D23B9;
	Mon, 23 Mar 2026 06:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xk6zw70y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637711EFFA1
	for <linux-rdma@vger.kernel.org>; Mon, 23 Mar 2026 06:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774246621; cv=pass; b=DFhaW/kEtNgZ8Ydcvv520vlXHh9GMOPVGurhCJPXS+lCvFuuD8jz5gvrlgCs90DTWepivm0CQtNFJ1DNVJyLJCc5clUgcT/2zY9onrc4K7vCQmsSp2bsJ1R6FQ5xwOdqRKumot+Uj5yqP+pzRPnjH5dm96XSNw58d6kA8vbAab8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774246621; c=relaxed/simple;
	bh=5Dn30mlE3OIszsh3yJe6xbOHIajWjgBJE+oIuKg2nwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tiTFplBpYKYdHDREyDbH6w0rYGYM1lVTfmRtSafjZndGLlTR64q98iBN/gRV96yJ3R2/tqmbKlG7760P8FfartYiONxaEnJVceZDrTe515VT355ymWFJmGMhZpCpaNFRpHMefgo5hUbd5pgxqiOn+cBZJv0YxASWbIGKiz6pJZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Xk6zw70y; arc=pass smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2b0484a6de4so16379995ad.3
        for <linux-rdma@vger.kernel.org>; Sun, 22 Mar 2026 23:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774246620; x=1774851420;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxVtvRAZOVuJLOFrZ+5GNeN2L0ulnC5AbpgzUzmxEds=;
        b=HDXLY8Bpk6O7UjJ2djfD8ah1RHCgJF3rQEqNbjbh+sImedpcWrRh2VV6k4QssbCo+W
         CowaGudS0jGCAewCZX2vG1OdvKx2y1Do+HR/t2ScdIzvHkenC9FMsU4A1lsc0YrRXvkq
         alPhwL8U0sjI8iu0mnyojrn2zmm5E0wUgW8r+fwVyzo+hUFYjuSnfm31SvSqs4xnarxA
         +EhzT8ze1XTlj9N65MceV6UQy9wtFTB38NeKCaVK8GoGjlscMVOcHYMkY2kHk4Z3QCrB
         s58Im1uwfdTkjCk79vYwf6t1eCpF6iho3Qcu6BxzjFTSxa6C+Sm8f5W7Blo9z/iwwoDb
         qHdQ==
X-Forwarded-Encrypted: i=2; AJvYcCWPFQV8TJ9R72diejSvVUlgnfz5HjJAGTMUsKkRd759ibvcnEms9WrAbUZQKiNZ7n2jKlVQsHTv8cXV@vger.kernel.org
X-Gm-Message-State: AOJu0YzlI1q06hbxAhnZvDUJu9YNJZvm41wcywsZPdw/H3e1+XERstCg
	1pxiCcG6CC9JPZ3Smn64xT4pHkwvalqtz5+ZH//emY/iP3I1a52FXnSDldBVNdc32QHFSxdjyh+
	E5LBxdhYOhMHn3xKy95jsdGbc+BESP1H1LPD/bUAQHHaOE2fsc7PDn7KoUp+hNm8hmR/aEmFhNu
	UyFJc37wq3IWsFJnYo3WY6He2q+f1RLA/psJITAAzpRAjn1cuMquytlbDnuFXb26fJWeSyq2LtT
	hkq2uuEaWYxJXUfpA==
X-Gm-Gg: ATEYQzxMprGQS+wF9KozN8hL/1BUd3pvep2iQXmqn6myTMJuGNVxfApBMghA+E6XCHf
	YJ21k9FCJ96reFDOgdVxQ8Fdnq9CJ0c/JlrunM15RiBsrld8seWaIk1VUdmKHy2QQNPtgHUlFpe
	LYkJyYIa7ivy3aHDGjf0I2hDoaP5ozOKHAywUGO7AtaK/rlws1+ukA3f33BEb8RQ6q16wWwYJAM
	BPo96lz6D0VnKnJqevEG2Xb96fjIe1sfiQM3tKK7dxOve3xJNPLVKIIf5sycK21iB+bqKoEnolQ
	IMvW5MDSDhluEE/aDZgWK+5HA7/fLW4EIIqFTLSpnbZAazfZTvTUkXZgqvVf8hxh0vBIeR5FKGr
	SLLL1FWNBZ/q3C/xJXDTmmK1Y7ejmY3OE9RRn2IIrND0a8O7UkbT8ET9rRWhgO+dLA64lnhxBA0
	7NKzacl2TN5g6UO61bqQwd0QzTOh8ncr/lKlpQ1uyRdG+22doVq1FRv6riKIIt
X-Received: by 2002:a17:903:2c6:b0:2b0:5694:7b62 with SMTP id d9443c01a7336-2b0827ff60fmr111743335ad.44.1774246619561;
        Sun, 22 Mar 2026 23:16:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b0835f5aabsm13265025ad.39.2026.03.22.23.16.59
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2026 23:16:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-467954d5210so40763585b6e.2
        for <linux-rdma@vger.kernel.org>; Sun, 22 Mar 2026 23:16:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774246618; cv=none;
        d=google.com; s=arc-20240605;
        b=MSmVGcrl/bsiPB7yCk70R4qizkQAHnyXSoAx8CBmp8z2hEksPTC7K5q7gLn6x52g/j
         0xtCPaxvm9ahbrUoU06qBvypLZWKJkkaqiXOg7xBOluFDFTUd3JQhjT+rBiV5m5Cs+Ws
         T4S09K5ReKjn0LoH9qavdS7xl6aHg6xS4PvdPlSjP2vcEATAuG+qZ34TuEHI0K8mZ3lU
         vngGKyGNcHAsgUwjiDUhwGDUf/heEoC79yPjf6njAX0qnmAD4EA57DPOlZPRsQmfw26f
         +qaOUXrovZdiG+JAy5Kt3Wzwo1rbY9J0MaVEh3a8p2+v+xgoZ5NUQYnVahjvc3n/NCQQ
         5jnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wxVtvRAZOVuJLOFrZ+5GNeN2L0ulnC5AbpgzUzmxEds=;
        fh=qPJDHRtSSqQtKJv8GS6VqhYhsKO9ahq7yD7XGIi2cQs=;
        b=iBKHTCm7wSB7PgcCz7pemVnJtxqSfCF89H7AQseqkyVlWKKrH6a//RHYdjm8WUpWlx
         h2AUIRX+cdw7kIcwd2i1i/XEqGEiEadcjIm0aOapu4ASQ0L7D4RCzasAxonttLaHZNqi
         NAp41o2R+5MPvXx97ZG9Qiot7L5PpiEiedu61W9SEzg4aLlXDSxs+Ra67IWQPuErolU4
         DWfDuo2tynOUG9TOdcFSIeZFJjKi9LlK9aDkxeay3yRe04aM+iYjcVu1jBapteB6Y/zA
         xrmpLg4DODAbuevVyw0MxQHLVazO+CwqBmE7vJgBpjjlEW5Jxqwaftps2RpFU9otBidh
         9yAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774246618; x=1774851418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wxVtvRAZOVuJLOFrZ+5GNeN2L0ulnC5AbpgzUzmxEds=;
        b=Xk6zw70yQnoVoO0ayx4zBKoNDf7m2NH8QAXr27AQFMAa/6CeRCdelpE2DIOpWai5sD
         hb/YveOQCi1JIH8UwYq6jOf1W6A7/sZHO44QHYhKS8MU1hKfbiv6kYvrlirYBivuCrCs
         stoj/cUJruQelOcrphaY6JYdF5NMzvJ6l+O2Q=
X-Forwarded-Encrypted: i=1; AJvYcCVsZJEgO07jlPuowf3lOecT91K/utFm0sPVoyogd9gZqXxIAJWfP/1HFmaVZyv2/MJjX+ApKlgfZ15L@vger.kernel.org
X-Received: by 2002:a05:6808:1a24:b0:463:927c:1e3d with SMTP id 5614622812f47-467e5dc1da1mr6636444b6e.23.1774246617932;
        Sun, 22 Mar 2026 23:16:57 -0700 (PDT)
X-Received: by 2002:a05:6808:1a24:b0:463:927c:1e3d with SMTP id
 5614622812f47-467e5dc1da1mr6636429b6e.23.1774246617356; Sun, 22 Mar 2026
 23:16:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318-bnxt_re-cq-v1-0-381cb1b5e625@nvidia.com> <20260318-bnxt_re-cq-v1-1-381cb1b5e625@nvidia.com>
In-Reply-To: <20260318-bnxt_re-cq-v1-1-381cb1b5e625@nvidia.com>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Mon, 23 Mar 2026 11:46:43 +0530
X-Gm-Features: AQROBzCY5eLV28pOUWijK1ssx7c_S6TyD2jgk-JIH71wbun1t-aTtUlVjz-34aU
Message-ID: <CA+sbYW0vhjp49vngMs21DXErN=tMRN3M8uxqSSjOHL+H0uAbvw@mail.gmail.com>
Subject: Re: [PATCH rdma-next 1/4] RDMA/bnxt_re: Simplify bnxt_re_init_depth()
 callers and implementation
To: Leon Romanovsky <leon@kernel.org>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006f1612064daafb39"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18507-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 393692ECF83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000006f1612064daafb39
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 3:39=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> All callers of bnxt_re_init_depth() compute the minimum between its retur=
n
> value and another internal variable, often mixing variable types in the
> process. Clean this up by making the logic simpler and more readable.
>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 81 ++++++++++++++------------=
------
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h |  9 ++--
>  2 files changed, 42 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniban=
d/hw/bnxt_re/ib_verbs.c
> index 182128ee4f242..40ac546f113bc 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -1442,7 +1442,6 @@ static int bnxt_re_init_rq_attr(struct bnxt_re_qp *=
qp,
>         struct bnxt_qplib_qp *qplqp;
>         struct bnxt_re_dev *rdev;
>         struct bnxt_qplib_q *rq;
> -       int entries;
>
>         rdev =3D qp->rdev;
>         qplqp =3D &qp->qplib_qp;
> @@ -1465,8 +1464,9 @@ static int bnxt_re_init_rq_attr(struct bnxt_re_qp *=
qp,
>                 /* Allocate 1 more than what's provided so posting max do=
esn't
>                  * mean empty.
>                  */
> -               entries =3D bnxt_re_init_depth(init_attr->cap.max_recv_wr=
 + 1, uctx);
> -               rq->max_wqe =3D min_t(u32, entries, dev_attr->max_qp_wqes=
 + 1);
> +               rq->max_wqe =3D bnxt_re_init_depth(init_attr->cap.max_rec=
v_wr + 1,
> +                                                dev_attr->max_qp_wqes + =
1,
> +                                                uctx);
>                 rq->max_sw_wqe =3D rq->max_wqe;
>                 rq->q_full_delta =3D 0;
>                 rq->sg_info.pgsize =3D PAGE_SIZE;
> @@ -1504,7 +1504,6 @@ static int bnxt_re_init_sq_attr(struct bnxt_re_qp *=
qp,
>         struct bnxt_re_dev *rdev;
>         struct bnxt_qplib_q *sq;
>         int diff =3D 0;
> -       int entries;
>         int rc;
>
>         rdev =3D qp->rdev;
> @@ -1513,7 +1512,6 @@ static int bnxt_re_init_sq_attr(struct bnxt_re_qp *=
qp,
>         dev_attr =3D rdev->dev_attr;
>
>         sq->max_sge =3D init_attr->cap.max_send_sge;
> -       entries =3D init_attr->cap.max_send_wr;
>         if (uctx && qplqp->wqe_mode =3D=3D BNXT_QPLIB_WQE_MODE_VARIABLE) =
{
>                 sq->max_wqe =3D ureq->sq_slots;
>                 sq->max_sw_wqe =3D ureq->sq_slots;
> @@ -1529,10 +1527,11 @@ static int bnxt_re_init_sq_attr(struct bnxt_re_qp=
 *qp,
>                         return rc;
>
>                 /* Allocate 128 + 1 more than what's provided */
> -               diff =3D (qplqp->wqe_mode =3D=3D BNXT_QPLIB_WQE_MODE_VARI=
ABLE) ?
> -                       0 : BNXT_QPLIB_RESERVED_QP_WRS;
> -               entries =3D bnxt_re_init_depth(entries + diff + 1, uctx);
> -               sq->max_wqe =3D min_t(u32, entries, dev_attr->max_qp_wqes=
 + diff + 1);
> +               if (qplqp->wqe_mode !=3D BNXT_QPLIB_WQE_MODE_VARIABLE)
> +                       diff =3D BNXT_QPLIB_RESERVED_QP_WRS;
> +               sq->max_wqe =3D bnxt_re_init_depth(
> +                       init_attr->cap.max_send_wr + diff + 1,
> +                       dev_attr->max_qp_wqes + diff + 1, uctx);
>                 if (qplqp->wqe_mode =3D=3D BNXT_QPLIB_WQE_MODE_VARIABLE)
>                         sq->max_sw_wqe =3D bnxt_qplib_get_depth(sq, qplqp=
->wqe_mode, true);
>                 else
> @@ -1559,16 +1558,15 @@ static void bnxt_re_adjust_gsi_sq_attr(struct bnx=
t_re_qp *qp,
>         struct bnxt_qplib_dev_attr *dev_attr;
>         struct bnxt_qplib_qp *qplqp;
>         struct bnxt_re_dev *rdev;
> -       int entries;
>
>         rdev =3D qp->rdev;
>         qplqp =3D &qp->qplib_qp;
>         dev_attr =3D rdev->dev_attr;
>
>         if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx)) {
> -               entries =3D bnxt_re_init_depth(init_attr->cap.max_send_wr=
 + 1, uctx);
> -               qplqp->sq.max_wqe =3D min_t(u32, entries,
> -                                         dev_attr->max_qp_wqes + 1);
> +               qplqp->sq.max_wqe =3D
> +                       bnxt_re_init_depth(init_attr->cap.max_send_wr + 1=
,
> +                                          dev_attr->max_qp_wqes + 1, uct=
x);
>                 qplqp->sq.q_full_delta =3D qplqp->sq.max_wqe -
>                         init_attr->cap.max_send_wr;
>                 qplqp->sq.max_sge++; /* Need one extra sge to put UD head=
er */
> @@ -2086,7 +2084,7 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
>         struct bnxt_re_pd *pd;
>         struct ib_pd *ib_pd;
>         u32 active_srqs;
> -       int rc, entries;
> +       int rc;
>
>         ib_pd =3D ib_srq->pd;
>         pd =3D container_of(ib_pd, struct bnxt_re_pd, ib_pd);
> @@ -2112,10 +2110,9 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
>         /* Allocate 1 more than what's provided so posting max doesn't
>          * mean empty
>          */
> -       entries =3D bnxt_re_init_depth(srq_init_attr->attr.max_wr + 1, uc=
tx);
> -       if (entries > dev_attr->max_srq_wqes + 1)
> -               entries =3D dev_attr->max_srq_wqes + 1;
> -       srq->qplib_srq.max_wqe =3D entries;
> +       srq->qplib_srq.max_wqe =3D
> +               bnxt_re_init_depth(srq_init_attr->attr.max_wr + 1,
> +                                  dev_attr->max_srq_wqes + 1, uctx);
>
>         srq->qplib_srq.max_sge =3D srq_init_attr->attr.max_sge;
>          /* 128 byte wqe size for SRQ . So use max sges */
> @@ -2296,7 +2293,7 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct i=
b_qp_attr *qp_attr,
>         struct bnxt_re_dev *rdev =3D qp->rdev;
>         struct bnxt_qplib_dev_attr *dev_attr =3D rdev->dev_attr;
>         enum ib_qp_state curr_qp_state, new_qp_state;
> -       int rc, entries;
> +       int rc;
>         unsigned int flags;
>         u8 nw_type;
>
> @@ -2510,9 +2507,9 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct i=
b_qp_attr *qp_attr,
>                                   "Create QP failed - max exceeded");
>                         return -EINVAL;
>                 }
> -               entries =3D bnxt_re_init_depth(qp_attr->cap.max_send_wr, =
uctx);
> -               qp->qplib_qp.sq.max_wqe =3D min_t(u32, entries,
> -                                               dev_attr->max_qp_wqes + 1=
);
> +               qp->qplib_qp.sq.max_wqe =3D
> +                       bnxt_re_init_depth(qp_attr->cap.max_send_wr,
> +                                          dev_attr->max_qp_wqes + 1, uct=
x);
>                 qp->qplib_qp.sq.q_full_delta =3D qp->qplib_qp.sq.max_wqe =
-
>                                                 qp_attr->cap.max_send_wr;
>                 /*
> @@ -2523,9 +2520,9 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct i=
b_qp_attr *qp_attr,
>                 qp->qplib_qp.sq.q_full_delta -=3D 1;
>                 qp->qplib_qp.sq.max_sge =3D qp_attr->cap.max_send_sge;
>                 if (qp->qplib_qp.rq.max_wqe) {
> -                       entries =3D bnxt_re_init_depth(qp_attr->cap.max_r=
ecv_wr, uctx);
> -                       qp->qplib_qp.rq.max_wqe =3D
> -                               min_t(u32, entries, dev_attr->max_qp_wqes=
 + 1);
> +                       qp->qplib_qp.rq.max_wqe =3D bnxt_re_init_depth(
> +                               qp_attr->cap.max_recv_wr,
> +                               dev_attr->max_qp_wqes + 1, uctx);
>                         qp->qplib_qp.rq.max_sw_wqe =3D qp->qplib_qp.rq.ma=
x_wqe;
>                         qp->qplib_qp.rq.q_full_delta =3D qp->qplib_qp.rq.=
max_wqe -
>                                                        qp_attr->cap.max_r=
ecv_wr;
> @@ -3381,8 +3378,8 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, cons=
t struct ib_cq_init_attr *att
>         struct bnxt_re_cq_resp resp =3D {};
>         struct bnxt_re_cq_req req;
>         int cqe =3D attr->cqe;
> -       int rc, entries;
> -       u32 active_cqs;
> +       int rc;
> +       u32 active_cqs, entries;
>
>         if (attr->flags)
>                 return -EOPNOTSUPP;
> @@ -3397,17 +3394,16 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, co=
nst struct ib_cq_init_attr *att
>         cctx =3D rdev->chip_ctx;
>         cq->qplib_cq.cq_handle =3D (u64)(unsigned long)(&cq->qplib_cq);
>
> -       entries =3D bnxt_re_init_depth(cqe + 1, uctx);
> -       if (entries > dev_attr->max_cq_wqes + 1)
> -               entries =3D dev_attr->max_cq_wqes + 1;
> -
>         rc =3D ib_copy_validate_udata_in_cm(udata, req, cq_handle,
>                                           BNXT_RE_CQ_FIXED_NUM_CQE_ENABLE=
);
>         if (rc)
>                 return rc;
>
>         if (req.comp_mask & BNXT_RE_CQ_FIXED_NUM_CQE_ENABLE)
> -               entries =3D cqe;
> +               entries =3D attr->cqe;
> +       else
> +               entries =3D bnxt_re_init_depth(attr->cqe + 1,
> +                                            dev_attr->max_cq_wqes + 1, u=
ctx);
>
>         if (!ibcq->umem) {
>                 ibcq->umem =3D ib_umem_get(&rdev->ibdev, req.cq_va,
> @@ -3480,7 +3476,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const str=
uct ib_cq_init_attr *attr,
>                 rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext,=
 ib_uctx);
>         struct bnxt_qplib_dev_attr *dev_attr =3D rdev->dev_attr;
>         int cqe =3D attr->cqe;
> -       int rc, entries;
> +       int rc;
>         u32 active_cqs;
>
>         if (udata)
> @@ -3498,11 +3494,8 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const st=
ruct ib_cq_init_attr *attr,
>         cq->rdev =3D rdev;
>         cq->qplib_cq.cq_handle =3D (u64)(unsigned long)(&cq->qplib_cq);
>
> -       entries =3D bnxt_re_init_depth(cqe + 1, uctx);
> -       if (entries > dev_attr->max_cq_wqes + 1)
> -               entries =3D dev_attr->max_cq_wqes + 1;
> -
> -       cq->max_cql =3D min_t(u32, entries, MAX_CQL_PER_POLL);
> +       cq->max_cql =3D bnxt_re_init_depth(attr->cqe + 1,
> +                                        dev_attr->max_cq_wqes + 1, uctx)=
;
>         cq->cql =3D kcalloc(cq->max_cql, sizeof(struct bnxt_qplib_cqe),
>                           GFP_KERNEL);
>         if (!cq->cql)
> @@ -3511,7 +3504,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const str=
uct ib_cq_init_attr *attr,
>         cq->qplib_cq.sg_info.pgsize =3D SZ_4K;
>         cq->qplib_cq.sg_info.pgshft =3D __builtin_ctz(SZ_4K);
>         cq->qplib_cq.dpi =3D &rdev->dpi_privileged;
> -       cq->qplib_cq.max_wqe =3D entries;
> +       cq->qplib_cq.max_wqe =3D cq->max_cql;
>         cq->qplib_cq.coalescing =3D &rdev->cq_coalescing;
>         cq->qplib_cq.nq =3D bnxt_re_get_nq(rdev);
>         cq->qplib_cq.cnq_hw_ring_id =3D cq->qplib_cq.nq->ring_id;
> @@ -3522,7 +3515,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const str=
uct ib_cq_init_attr *attr,
>                 goto fail;
>         }
>
> -       cq->ib_cq.cqe =3D entries;
> +       cq->ib_cq.cqe =3D cq->max_cql;
>         cq->cq_period =3D cq->qplib_cq.period;
>         active_cqs =3D atomic_inc_return(&rdev->stats.res.cq_count);
>         if (active_cqs > rdev->stats.res.cq_watermark)
> @@ -3560,7 +3553,8 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, =
struct ib_udata *udata)
>         struct bnxt_re_resize_cq_req req;
>         struct bnxt_re_dev *rdev;
>         struct bnxt_re_cq *cq;
> -       int rc, entries;
> +       int rc;
> +       u32 entries;
>
>         cq =3D  container_of(ibcq, struct bnxt_re_cq, ib_cq);
>         rdev =3D cq->rdev;
> @@ -3584,10 +3578,7 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe,=
 struct ib_udata *udata)
>         }
>
>         uctx =3D rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext=
, ib_uctx);
> -       entries =3D bnxt_re_init_depth(cqe + 1, uctx);
> -       if (entries > dev_attr->max_cq_wqes + 1)
> -               entries =3D dev_attr->max_cq_wqes + 1;
> -
> +       entries =3D bnxt_re_init_depth(cqe + 1, dev_attr->max_cq_wqes + 1=
, uctx);
>         /* uverbs consumer */
>         rc =3D ib_copy_validate_udata_in(udata, req, cq_va);
>         if (rc)
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniban=
d/hw/bnxt_re/ib_verbs.h
> index 3d02c16f54b61..dfe790ef42d75 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> @@ -190,10 +190,13 @@ enum {
>         BNXT_RE_UCNTX_CAP_VAR_WQE_ENABLED =3D 0x2ULL,
>  };
>
> -static inline u32 bnxt_re_init_depth(u32 ent, struct bnxt_re_ucontext *u=
ctx)
> +static inline u32 bnxt_re_init_depth(u32 ent, u32 max,
> +                                    struct bnxt_re_ucontext *uctx)
>  {
> -       return uctx ? (uctx->cmask & BNXT_RE_UCNTX_CAP_POW2_DISABLED) ?
> -               ent : roundup_pow_of_two(ent) : ent;
> +       if (uctx && !(uctx->cmask & BNXT_RE_UCNTX_CAP_POW2_DISABLED))
> +               return min(roundup_pow_of_two(ent), max);
Looks like the min setting is missing in the else case. shouldn't we add th=
at?

> +
> +       return ent;
>  }
>
>  static inline bool bnxt_re_is_var_size_supported(struct bnxt_re_dev *rde=
v,
>
> --
> 2.53.0
>

--0000000000006f1612064daafb39
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
UYE4ee0XCqDzdEmWm19/2l9GL6w/Z8+rrsjUsy490F4wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYwMzIzMDYxNjU4WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAbgHW73t8Whtj4V3aA11k/SjkCcMqgpS+obZH
TfC8AtQyCi8zcgmRMlKJsNG0cCZklAfCA49uibUHXMFquWNWMPXdZ2wGBrvgFQ1s2cVgNNEn42dh
nHy4Ug9ZHH/vhVfe5v/EVV70PncIHvtg2vXH0FXDxPJkMCUihBmtHDIDsab53c6tpyMTscob0yvP
LF9kdqPFMyGuV6o+pePbL0fBNSRr85Q8I3nwn4znpw2hnQH3BoxgeIukxyp0bjKvl9VSr/oh4FPy
KCDA+9hUzSDxi/0GBFqjqAfhDNMIs9FEo7DLsATTFA66OFdn1HsTcnkB5y5GbnbhoxLoDhOAS1up
EA==
--0000000000006f1612064daafb39--

