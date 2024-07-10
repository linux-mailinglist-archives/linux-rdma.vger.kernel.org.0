Return-Path: <linux-rdma+bounces-3786-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA6192CD7F
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 10:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68DEB28A372
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 08:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B1C158D7B;
	Wed, 10 Jul 2024 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cvQRgq7s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2771527A7
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2024 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601413; cv=none; b=U+8hpnfHeNRKov35kT0Hd+WEM/RmCChKJXwCMuHz1V1vP0FX1sERnAjcioftwm8oGMUsj106fXHJ9+3Za8Uh4Wuj05Jdf2FI1T0lopwd5zn6rhUDtKTzV6r3LDRud0Z2vtNGBO3O80Zxkyh4y/0K8uGInw+ZVntK+iza1dPNClc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601413; c=relaxed/simple;
	bh=xIWJZdqQmS40VtfySNljm4qkzaAQCvi0WdVDzPfduPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9V5eDJkiMnI4A1Mv15Sz03NpaUHRUPN48SDsQ8xeB+1OwQY5rlISyO7Ln5NpeuIFPb+Vbzx9Z6GntjlhIbWfsAmL+XVP2GTKAGea1Qg4r8HeLwJPvJ50ZL+GQaAxYdOZoIdLzOGweedX+bUQvK/oY7G3koXJjFE4yALVe+5rZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cvQRgq7s; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5854ac817afso7337824a12.2
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2024 01:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1720601410; x=1721206210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCueOuhK8iVCiyW5xhIkWfPl83yP8Jfl3gqyyj7EmdQ=;
        b=cvQRgq7sOlvT6Cdep1EH82TrvzKGj74TqUfhNXnvcJzVSEat0OiIthAwvq4ixZaWcB
         kdcpCHnOe+rpWU4cyfPDVJSyHOauMcoMUMMHhr6UWUeG6u76DZ6/+8092TEydq14GCEv
         /KS9fHZIfjENhAE4KoEznLxOWn2t6lYEw9eFUaytuibVHB+nDvOXeTvgIQ1GJMDh4tTF
         cn1JwiDHwjJ5VAyl0mb6BqL50PjT8jAECStZWMIQAXhP6Bs9PazY/wn/gLt53bFBDBYL
         6pK4kuLtk8v8Da0x++Nc/tE/7lp1Pf8N9VSeWUycj6dudWF0oUbLxkGRUoAt3jj1qeay
         vxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720601410; x=1721206210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCueOuhK8iVCiyW5xhIkWfPl83yP8Jfl3gqyyj7EmdQ=;
        b=H8+1pMIKeqk1ET1MhOYpTx7j55sg4ma0he40mY8132Z5dWODJvzFampA9EmqalzecD
         uYeKzodKJTuGO4rUjKswJdg7F+LKh6tdMCO6JaJycCjxKdAlwq3bcFt7hzZhIXqBCr7B
         XgvyF75xdVS4ZI4Avg1HnEO1cVKy0+FqR+ODoPYGTbEtzjlgKjCsM1Ko6uF/qYs3o1IR
         bq3wv+soEFQfCosszO93KlG9v/YoEckhU7mN/9Me0HCk+jjwR+FrxLyMBgROV3lOEi0H
         bB4zPh147KI5K9sctnOTJrXqi/kjncNywaShv4e7KjlisAqP6cPFw16mudDMlJHGo1tt
         OcBA==
X-Gm-Message-State: AOJu0YxmGl8jrI7D0XvhwP/B0xsvyHSaftsZUZkZhXrkGZGNUGTCGSSR
	wDIsVozpeNn9yuhprHc0l6iqaH4LmsR9ESoUxQzucvGKeD5HsLz+o0Wpy7L0vt9gtRnPV7im8h1
	fyTmElldGfyKb0Nhbh95VMYJK5uI9ezsZXidzGg==
X-Google-Smtp-Source: AGHT+IHRJQBgRqyofnb9/OduGk0p7jb3RuPG9cpF0n/Nu7p6APj6aSwVk0BOhs7AH0XjupRmhFSiugYXdV+B+yeiFw4=
X-Received: by 2002:a50:d518:0:b0:585:437c:d7fc with SMTP id
 4fb4d7f45d1cf-594bc7c7e61mr3034086a12.32.1720601409630; Wed, 10 Jul 2024
 01:50:09 -0700 (PDT)
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
Date: Wed, 10 Jul 2024 10:49:58 +0200
Message-ID: <CAMGffEkmrWhYpct22io+wwVL8kednUwoH_feXJXryFw9asa7EQ@mail.gmail.com>
Subject: Re: [PATCH for-next 1/2] bnxt_re: Fix imm_data endianness
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org, 
	jgg@ziepe.ca, haris.iqbal@ionos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Selvin,

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
sure, will do.
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
ok, makes sense.
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
ditto
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
will do.
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

