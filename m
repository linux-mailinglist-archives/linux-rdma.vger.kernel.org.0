Return-Path: <linux-rdma+bounces-3788-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF9192CE33
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 11:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A77C4B229CB
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 09:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E9417FD;
	Wed, 10 Jul 2024 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="gyteIMkk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424374DA13
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2024 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720603836; cv=none; b=EId1nv0DYn/gVq3JecukC18tevnlhX9BV4KQkfXtDHSwDJPyI/fusT4d18BMU7a+BngGmv3xXnApWltLSIm8xgDasCsypmRL68+pCgEVrMaV9a3mXzidsz6yOy2bHCFjp5nO+JYbk1WEAFVniZK6+Z3ZfulSEzup6m9E7UzsiXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720603836; c=relaxed/simple;
	bh=lOJpGKkxPCApQEyN7fMASYXBv/cIj70U+qaKfiL+N3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUsFigWjGpAgOCOPIxhdUJrGf577a2ZHX92Ewnkdvo7sd4pUxN2saHCTN/IidbUlLfIKshHkCNETLIuLATCvFocuQ0Qi6oM0KQgEAnEkNrpcJqOB3G69tcpb3XAOZ43RFAQ91YhrhrXHp9Z22rCFZ1UPPcSNZ340yavtc71E9OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=gyteIMkk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57d05e0017aso7489476a12.1
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2024 02:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1720603831; x=1721208631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEZRt2lGPoDWh3qo1/xfOj23tGpLu5Lc0o+eyHA8IVU=;
        b=gyteIMkkrUYXkHE9FxlOnVUWXEcBJjTm+XoaIy/60xBp+s5M0lrD2Lw+2qjOC4bz0I
         NZ9SiMv7Mcg0jA1HHb2WbR7tY0iuFlXGFCnxLx+XR0swdlEb4/9QWt3S0bk36rVb9lu9
         wWXryhNnPidxCW/pzrGNiAiTLDA5GVsDHBR2KkZtkfoEQenjokqVYHIIaFJs8kFdJU7k
         o8ZuHBKjQtBGDGX5gWzu7zJ3C/OUyYeTfPwG4lj4geJ0XOBsB4zfQa3B3nID+7+frN6b
         hlKZ9zWV6gx+2pCkzSWFqzHYv/nazobSkP1DF2clnRwL69GWOyzV1qHbjrCpPCGm5g5J
         Ef4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720603831; x=1721208631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEZRt2lGPoDWh3qo1/xfOj23tGpLu5Lc0o+eyHA8IVU=;
        b=dymeZ/ihkas1NWIrxpa/vByW0KvR6Xgf7ADF0kN0DWA3uyQmd9L7c+TQUDMujIfams
         l+Q9toSqz3+LcagOMfMY3ckCrXiaZFu8tCHOyoeXfDMtZ1PM7+VGiIdFdDKiAeuUWGxE
         5FblZcG8DkxRAxiqqqDaWgQ+YyQKGqhMSxbauR5fy81+H6RMRH30pNOHB1WgKeyDqWSd
         bdckUXLDNpOc7VUXRG/9snb3Oxz2kJII06/wcgBMFcVvpWrIR6QBuSvDBTuHFOPHLMrt
         VnL225Du7wm4eoJvLMeQjXZ0o7+lckA7JUEfa+fIs05au/GHCbffWVdhMWHbrsQV9zMJ
         ojVw==
X-Gm-Message-State: AOJu0Yz8HiSJxdPQWWjGVUMLaDt+dZ+G8Ma4KLBaemZfmaaHREk5rbWf
	4v5YdgrHkDhoGa/TVcBkVG2nqxYkq6GzJxQ6Nb942wTZD5jm9Jc+LGEznlOuJOx+X5EIeyENRwW
	JJwgsDFfMlx16uhF+sFaCWgcjQgPIccNjpT028g==
X-Google-Smtp-Source: AGHT+IFC1KPQbYrVpQIfZcsnxnsprH3Ia+s28QhsN5tlaPAs228pe+EFF24iGp+A6VOUa+DOe544pQucjvLhFs+yv4M=
X-Received: by 2002:aa7:cf0e:0:b0:57c:7ed7:897a with SMTP id
 4fb4d7f45d1cf-594bb869e6bmr2860946a12.27.1720603831528; Wed, 10 Jul 2024
 02:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709150119.29937-1-jinpu.wang@ionos.com> <20240709150119.29937-2-jinpu.wang@ionos.com>
 <CA+sbYW0SyjjvYjb++P8P4MHam_YWRXN3Vw8PmNsK4G+e8a3gsA@mail.gmail.com>
In-Reply-To: <CA+sbYW0SyjjvYjb++P8P4MHam_YWRXN3Vw8PmNsK4G+e8a3gsA@mail.gmail.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 10 Jul 2024 11:30:20 +0200
Message-ID: <CAMGffEmSZo_=A-z_WrdoOaedTAqNqgjDOC6i1YJivT1njHyPLA@mail.gmail.com>
Subject: Re: [PATCH for-next 1/2] bnxt_re: Fix imm_data endianness
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org, 
	jgg@ziepe.ca, haris.iqbal@ionos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 10:28=E2=80=AFAM Selvin Xavier
<selvin.xavier@broadcom.com> wrote:
>
> On Tue, Jul 9, 2024 at 8:31=E2=80=AFPM Jack Wang <jinpu.wang@ionos.com> w=
rote:
> >
> > When map a device between servers with MLX and BCM RoCE nics, RTRS
> > server complain about unknown imm type, and can't map the device,
> >
> > After more debug, it seems bnxt_re wrongly handle the
> > imm_data, this patch fixed the compat issue with MLX for us.
> >
> > In offlist discussion, Selvin confirm HW is working in little endian
> > format and all data needs to be converted to LE while providing.
> >
> > This patch fix the endianness for imm_data
> >
> > Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Hi Jinpu,
>  Thank you for this patch and debugging with Broadcom devices. Couple
> of comments. Also, maybe you can clean up the commit message by moving
> the reference of our discussion to the cover letter.
>
> Thanks,
> Selvin
> > ---
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 8 ++++----
> >  drivers/infiniband/hw/bnxt_re/qplib_fp.h | 6 +++---
> >  2 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infinib=
and/hw/bnxt_re/ib_verbs.c
> > index e453ca701e87..c5080028247e 100644
> > --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > @@ -2479,7 +2479,7 @@ static int bnxt_re_build_send_wqe(struct bnxt_re_=
qp *qp,
> >                 break;
> >         case IB_WR_SEND_WITH_IMM:
> >                 wqe->type =3D BNXT_QPLIB_SWQE_TYPE_SEND_WITH_IMM;
> > -               wqe->send.imm_data =3D wr->ex.imm_data;
> > +               wqe->send.imm_data =3D cpu_to_le32(be32_to_cpu(wr->ex.i=
mm_data));
> If you see bnxt_re/qplib_fp.c, we have the following code. This
> ensures that le32
> is passed down. So in your patch, we just need to do be32_to_cpu of
> the immediate data.
> sqe->inv_key_or_imm_data =3D cpu_to_le32(wqe->send.inv_key);
I will also drop the second patch, as it is redundant to the above.
> >                 break;
> >         case IB_WR_SEND_WITH_INV:
> >                 wqe->type =3D BNXT_QPLIB_SWQE_TYPE_SEND_WITH_INV;
> > @@ -2509,7 +2509,7 @@ static int bnxt_re_build_rdma_wqe(const struct ib=
_send_wr *wr,
> >                 break;
> >         case IB_WR_RDMA_WRITE_WITH_IMM:
> >                 wqe->type =3D BNXT_QPLIB_SWQE_TYPE_RDMA_WRITE_WITH_IMM;
> > -               wqe->rdma.imm_data =3D wr->ex.imm_data;
> > +               wqe->rdma.imm_data =3D cpu_to_le32(be32_to_cpu(wr->ex.i=
mm_data));
> Same comment as above
> >                 break;
> >         case IB_WR_RDMA_READ:
> >                 wqe->type =3D BNXT_QPLIB_SWQE_TYPE_RDMA_READ;
> > @@ -3582,7 +3582,7 @@ static void bnxt_re_process_res_shadow_qp_wc(stru=
ct bnxt_re_qp *gsi_sqp,
> >         wc->byte_len =3D orig_cqe->length;
> >         wc->qp =3D &gsi_qp->ib_qp;
> >
> > -       wc->ex.imm_data =3D orig_cqe->immdata;
> > +       wc->ex.imm_data =3D cpu_to_be32(le32_to_cpu(orig_cqe->immdata))=
;
> >         wc->src_qp =3D orig_cqe->src_qp;
> >         memcpy(wc->smac, orig_cqe->smac, ETH_ALEN);
> >         if (bnxt_re_is_vlan_pkt(orig_cqe, &vlan_id, &sl)) {
> > @@ -3727,7 +3727,7 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_=
entries, struct ib_wc *wc)
> >                                  (unsigned long)(cqe->qp_handle),
> >                                  struct bnxt_re_qp, qplib_qp);
> >                         wc->qp =3D &qp->ib_qp;
> > -                       wc->ex.imm_data =3D cqe->immdata;
> > +                       wc->ex.imm_data =3D cpu_to_be32(le32_to_cpu(cqe=
->immdata));
> >                         wc->src_qp =3D cqe->src_qp;
> >                         memcpy(wc->smac, cqe->smac, ETH_ALEN);
> >                         wc->port_num =3D 1;
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infinib=
and/hw/bnxt_re/qplib_fp.h
> > index 4aaac84c1b1b..1fcaba0f680b 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> > @@ -164,7 +164,7 @@ struct bnxt_qplib_swqe {
> >                 /* Send, with imm, inval key */
> >                 struct {
> >                         union {
> > -                               __be32  imm_data;
> > +                               __le32  imm_data;
> Once you implement according to my comment above, this can be a u32
> >                                 u32     inv_key;
> >                         };
> >                         u32             q_key;
> > @@ -182,7 +182,7 @@ struct bnxt_qplib_swqe {
> >                 /* RDMA write, with imm, read */
> >                 struct {
> >                         union {
> > -                               __be32  imm_data;
> > +                               __le32  imm_data;
> >                                 u32     inv_key;
> >                         };
> >                         u64             remote_va;
> > @@ -389,7 +389,7 @@ struct bnxt_qplib_cqe {
> >         u16                             cfa_meta;
> >         u64                             wr_id;
> >         union {
> > -               __be32                  immdata;
> > +               __le32                  immdata;
> >                 u32                     invrkey;
> >         };
> >         u64                             qp_handle;
> > --
> > 2.34.1
> >

