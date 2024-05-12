Return-Path: <linux-rdma+bounces-2421-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5213F8C34F6
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 05:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE53828191A
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 03:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE35ABE6C;
	Sun, 12 May 2024 03:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NHXkbWoa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907D9C142
	for <linux-rdma@vger.kernel.org>; Sun, 12 May 2024 03:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715485393; cv=none; b=mZm5TewtpqosvtnaKJUEELQZ53Der7IIdnPBgUjgd0mYmry8tn7yi2MWUkkp9Cxywj63CYPK6PdrDujMjdxv8zOV3abBKeBR7N0kP9x4Pu+pmJBaHFe/1F3szDFTgL6c82lWPBH15gKtcfmfOiIbxWxbaZ6vDJM5zz9PgupwM6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715485393; c=relaxed/simple;
	bh=C3UGHlFtEIzulXMhkvLd4DbJpzxafUfc6ili+7Uryl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5FDLh9eGYbRvFwmMeatOGn5mqsvWTdfw487gOVVX9sgzIzUdkfeWWebLMtK/T87J678slQtcGvHOnggsSkg0kugRn6V7hS2QMt2DebhHpx7eWm/YKUED6QyhhLrooKJKZddVk6BgQW+2zA26zOdfiAUGMOP0UqCqxc3xg51My0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NHXkbWoa; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-de462f3d992so3447693276.2
        for <linux-rdma@vger.kernel.org>; Sat, 11 May 2024 20:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715485390; x=1716090190; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vw3L7lJOKWwKswHpy5FqmV+u20EaL5kAGcWo0203pEc=;
        b=NHXkbWoaglC87OzWAw+t3ACOvtC++T/yGoMcRH6f6tiUpmO2nJIz6XyVcumfBEIiEM
         Ecvl4qdyHt/otgr3huov4D0Px9RJi2jx0i9fW6iBoYZtLTugPrz+YWtElYCbBrIyXqMG
         C0yUWoRELavOVyXlqZ7kBcJ0Q0hLfjeS+n8wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715485390; x=1716090190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vw3L7lJOKWwKswHpy5FqmV+u20EaL5kAGcWo0203pEc=;
        b=rg3YlQpKkuWp663dIGNy2HTuQEATWO1l7wAkY5URCDt+N76AC4U/dK0+ZlwMas6rmb
         j/etuZjGwKTfJB6b1eGLrqk3AhicrpP9AyD5P2EVV839JzBI+Toyb6NRKSUJ71YP9z29
         HF7/DLt4d56GmLXbPIBFRL1Qph0bGsKxQP8gyCE5cUAAVPf9ozfzBZzkYf0qZDyPZluq
         H5cJFkf5xT2j1V3vmFMSNBGgFaMEmZYiNaW1R20UmMbUngrHnVNktZRbBmi5nbpAFb8F
         pz2poktQmgIhc2W+poAPVlJrmEzoA6skzVo4wPV/jYN8acJB7eByDP92bW2NMzw8xfXg
         P13A==
X-Forwarded-Encrypted: i=1; AJvYcCXBJB5MG7H97Imnm4VQ7Gc473TsiSdI/zWSQG6bHPW7Hici2UJl7vscb34atj03jj3twzXHhizmLYjxW1H9oUqnx8ExYzvWU6eKvw==
X-Gm-Message-State: AOJu0YyoUgsJaLXkKThONUkvRp8mrSlrMMeosgKsCU3Oi+XFRwjJQHWI
	7Tcso+bd3uRtt000x4edR0qxLx3pUN1lqFuqFokla1COC4hR+kYTk6d8SaOPMd+Wz3hy7ygjod1
	f5uMVLlwjVXkojYdKZpM+RwpqGQelCvxUVb7F
X-Google-Smtp-Source: AGHT+IFlp7/XjQjkqmizS0Dq8RaD83R34+F1K5SiHjvdvtVV7j6l6zJ8NPvQ9tQlwI7P4U0t5enzSUvDRsOblR/aNP8=
X-Received: by 2002:a5b:1c4:0:b0:de5:b002:48ca with SMTP id
 3f1490d57ef6-dee4f370bbbmr5731459276.45.1715485390394; Sat, 11 May 2024
 20:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1715402190-28657-1-git-send-email-selvin.xavier@broadcom.com>
 <1715402190-28657-2-git-send-email-selvin.xavier@broadcom.com> <7c0b4fff-def4-4f71-a30f-44f01d7c5461@linux.dev>
In-Reply-To: <7c0b4fff-def4-4f71-a30f-44f01d7c5461@linux.dev>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Sun, 12 May 2024 09:12:57 +0530
Message-ID: <CA+sbYW26sjcw6=NQEF+YtJsZ93-TVTLqqC3aNDJE5Z0nHuZpMg@mail.gmail.com>
Subject: Re: [PATCH v2 for-next 1/2] RDMA/bnxt_re: Allow MSN table capability check
To: Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: leon@kernel.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000056370d0618399147"

--00000000000056370d0618399147
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 7:07=E2=80=AFPM Zhu Yanjun <zyjzyj2000@gmail.com> w=
rote:
>
> On 11.05.24 06:36, Selvin Xavier wrote:
> > FW reports the HW capability to use PSN table or MSN table and
> > driver/library need to select it based on this capability.
> > Use the new capability instead of the older capability check for HW
> > retransmission while handling the MSN/PSN table. FW report
> > zero (PSN table) for older adapters to maintain backward compatibility.
> >
> > Also, Updated the FW interface structures to handle the new fields.
> >
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >   drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 12 ++++++------
> >   drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  2 +-
> >   drivers/infiniband/hw/bnxt_re/qplib_res.h |  6 ++++++
> >   drivers/infiniband/hw/bnxt_re/qplib_sp.c  |  1 +
> >   drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  1 +
> >   drivers/infiniband/hw/bnxt_re/roce_hsi.h  | 30 ++++++++++++++++++++++=
+++++++-
> >   6 files changed, 44 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infinib=
and/hw/bnxt_re/qplib_fp.c
> > index 439d0c7..3c961a8 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> > @@ -984,7 +984,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res=
, struct bnxt_qplib_qp *qp)
> >       u16 nsge;
> >
> >       if (res->dattr)
> > -             qp->dev_cap_flags =3D res->dattr->dev_cap_flags;
> > +             qp->is_host_msn_tbl =3D _is_host_msn_table(res->dattr->de=
v_cap_flags2);
> >
> >       sq->dbinfo.flags =3D 0;
> >       bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
> > @@ -1002,7 +1002,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *r=
es, struct bnxt_qplib_qp *qp)
> >                        sizeof(struct sq_psn_search_ext) :
> >                        sizeof(struct sq_psn_search);
> >
> > -             if (BNXT_RE_HW_RETX(qp->dev_cap_flags)) {
> > +             if (qp->is_host_msn_tbl) {
> >                       psn_sz =3D sizeof(struct sq_msn_search);
> >                       qp->msn =3D 0;
> >               }
> > @@ -1015,7 +1015,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *r=
es, struct bnxt_qplib_qp *qp)
> >       hwq_attr.aux_stride =3D psn_sz;
> >       hwq_attr.aux_depth =3D bnxt_qplib_set_sq_size(sq, qp->wqe_mode);
> >       /* Update msn tbl size */
> > -     if (BNXT_RE_HW_RETX(qp->dev_cap_flags) && psn_sz) {
> > +     if (qp->is_host_msn_tbl && psn_sz) {
> >               hwq_attr.aux_depth =3D roundup_pow_of_two(bnxt_qplib_set_=
sq_size(sq, qp->wqe_mode));
> >               qp->msn_tbl_sz =3D hwq_attr.aux_depth;
> >               qp->msn =3D 0;
> > @@ -1636,7 +1636,7 @@ static void bnxt_qplib_fill_psn_search(struct bnx=
t_qplib_qp *qp,
> >       if (!swq->psn_search)
> >               return;
> >       /* Handle MSN differently on cap flags  */
> > -     if (BNXT_RE_HW_RETX(qp->dev_cap_flags)) {
> > +     if (qp->is_host_msn_tbl) {
> >               bnxt_qplib_fill_msn_search(qp, wqe, swq);
> >               return;
> >       }
> > @@ -1818,7 +1818,7 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp=
,
> >       }
> >
> >       swq =3D bnxt_qplib_get_swqe(sq, &wqe_idx);
> > -     bnxt_qplib_pull_psn_buff(qp, sq, swq, BNXT_RE_HW_RETX(qp->dev_cap=
_flags));
> > +     bnxt_qplib_pull_psn_buff(qp, sq, swq, qp->is_host_msn_tbl);
> >
> >       idx =3D 0;
> >       swq->slot_idx =3D hwq->prod;
> > @@ -2008,7 +2008,7 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp=
,
> >               rc =3D -EINVAL;
> >               goto done;
> >       }
> > -     if (!BNXT_RE_HW_RETX(qp->dev_cap_flags) || msn_update) {
> > +     if (!qp->is_host_msn_tbl || msn_update) {
> >               swq->next_psn =3D sq->psn & BTH_PSN_MASK;
> >               bnxt_qplib_fill_psn_search(qp, wqe, swq);
> >       }
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infinib=
and/hw/bnxt_re/qplib_fp.h
> > index 7fd4506..5b8d097 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> > @@ -340,7 +340,7 @@ struct bnxt_qplib_qp {
> >       struct list_head                rq_flush;
> >       u32                             msn;
> >       u32                             msn_tbl_sz;
> > -     u16                             dev_cap_flags;
> > +     u16                             is_host_msn_tbl;
>
> Because qp->is_host_msn_tbl is set to
> _is_host_msn_table(res->dattr->dev_cap_flags2);
>
>
> is_host_msn_tbl is also declared as bool type?

No. its currently defined as u16. I will fix this.
>
> Zhu Yanjun
>
> >   };
> >
> >   #define BNXT_QPLIB_MAX_CQE_ENTRY_SIZE       sizeof(struct cq_base)
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infini=
band/hw/bnxt_re/qplib_res.h
> > index 61628f7..a0f78cd 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
> > @@ -554,6 +554,12 @@ static inline bool _is_hw_retx_supported(u16 dev_c=
ap_flags)
> >
> >   #define BNXT_RE_HW_RETX(a) _is_hw_retx_supported((a))
> >
> > +static inline bool _is_host_msn_table(u16 dev_cap_ext_flags2)
> > +{
> > +     return (dev_cap_ext_flags2 & CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSM=
ISSION_SUPPORT_MASK) =3D=3D
> > +             CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_HOST_M=
SN_TABLE;
> > +}
> > +
> >   static inline u8 bnxt_qplib_dbr_pacing_en(struct bnxt_qplib_chip_ctx =
*cctx)
> >   {
> >       return cctx->modes.dbr_pacing;
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infinib=
and/hw/bnxt_re/qplib_sp.c
> > index 8beeedd..9328db9 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> > @@ -156,6 +156,7 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw =
*rcfw,
> >                                   (0x01 << RCFW_DBR_BASE_PAGE_SHIFT);
> >       attr->max_sgid =3D BNXT_QPLIB_NUM_GIDS_SUPPORTED;
> >       attr->dev_cap_flags =3D le16_to_cpu(sb->dev_cap_flags);
> > +     attr->dev_cap_flags2 =3D le16_to_cpu(sb->dev_cap_ext_flags_2);
> >
> >       bnxt_qplib_query_version(rcfw, attr->fw_ver);
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infinib=
and/hw/bnxt_re/qplib_sp.h
> > index d33c78b..16a67d7 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> > @@ -72,6 +72,7 @@ struct bnxt_qplib_dev_attr {
> >       u8                              tqm_alloc_reqs[MAX_TQM_ALLOC_REQ]=
;
> >       bool                            is_atomic;
> >       u16                             dev_cap_flags;
> > +     u16                             dev_cap_flags2;
> >       u32                             max_dpi;
> >   };
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infinib=
and/hw/bnxt_re/roce_hsi.h
> > index 605c946..0425309 100644
> > --- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
> > +++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
> > @@ -2157,8 +2157,36 @@ struct creq_query_func_resp_sb {
> >       __le32  tqm_alloc_reqs[12];
> >       __le32  max_dpi;
> >       u8      max_sge_var_wqe;
> > -     u8      reserved_8;
> > +     u8      dev_cap_ext_flags;
> > +     #define CREQ_QUERY_FUNC_RESP_SB_ATOMIC_OPS_NOT_SUPPORTED         =
0x1UL
> > +     #define CREQ_QUERY_FUNC_RESP_SB_DRV_VERSION_RGTR_SUPPORTED       =
0x2UL
> > +     #define CREQ_QUERY_FUNC_RESP_SB_CREATE_QP_BATCH_SUPPORTED        =
0x4UL
> > +     #define CREQ_QUERY_FUNC_RESP_SB_DESTROY_QP_BATCH_SUPPORTED       =
0x8UL
> > +     #define CREQ_QUERY_FUNC_RESP_SB_ROCE_STATS_EXT_CTX_SUPPORTED     =
0x10UL
> > +     #define CREQ_QUERY_FUNC_RESP_SB_CREATE_SRQ_SGE_SUPPORTED         =
0x20UL
> > +     #define CREQ_QUERY_FUNC_RESP_SB_FIXED_SIZE_WQE_DISABLED          =
0x40UL
> > +     #define CREQ_QUERY_FUNC_RESP_SB_DCN_SUPPORTED                    =
0x80UL
> >       __le16  max_inline_data_var_wqe;
> > +     __le32  start_qid;
> > +     u8      max_msn_table_size;
> > +     u8      reserved8_1;
> > +     __le16  dev_cap_ext_flags_2;
> > +     #define CREQ_QUERY_FUNC_RESP_SB_OPTIMIZE_MODIFY_QP_SUPPORTED     =
        0x1UL
> > +     #define CREQ_QUERY_FUNC_RESP_SB_CHANGE_UDP_SRC_PORT_WQE_SUPPORTED=
        0x2UL
> > +     #define CREQ_QUERY_FUNC_RESP_SB_CQ_COALESCING_SUPPORTED          =
        0x4UL
> > +     #define CREQ_QUERY_FUNC_RESP_SB_MEMORY_REGION_RO_SUPPORTED       =
        0x8UL
> > +     #define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_MASK  =
        0x30UL
> > +     #define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_SFT   =
        4
> > +     #define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_HOST_P=
SN_TABLE  (0x0UL << 4)
> > +     #define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_HOST_M=
SN_TABLE  (0x1UL << 4)
> > +     #define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_IQM_MS=
N_TABLE   (0x2UL << 4)
> > +     #define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_LAST \
> > +                     CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPOR=
T_IQM_MSN_TABLE
> > +     __le16  max_xp_qp_size;
> > +     __le16  create_qp_batch_size;
> > +     __le16  destroy_qp_batch_size;
> > +     __le16  reserved16;
> > +     __le64  reserved64;
> >   };
> >
> >   /* cmdq_set_func_resources (size:448b/56B) */
>

--00000000000056370d0618399147
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
FYMZp2DojLAq9f4Oi2OBetbnWxo0WGycXpmq/jC4PUx2u9mazQ79i80VLagGRshWniESXuf+SYG8
+zBimjld9ZZnwm7itHAZdtme4YYFxx+EHa4PUxPV8t+hPHhsiIjirPa1pVXPbQIDAQABo4IB2zCC
AdcwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU3TaH
dsgUhTW3LwObmZ20fj+8Xj8wDQYJKoZIhvcNAQELBQADggEBAAbt6Sptp6ZlTnhM2FDhkVXks68/
iqvfL/e8wSPVdBxOuiP+8EXGLV3E72KfTTJXMbkcmFpK2K11poBDQJhz0xyOGTESjXNnN6Eqq+iX
hQtF8xG2lzPq8MijKI4qXk5Vy5DYfwsVfcF0qJw5AhC32nU9uuIPJq8/mQbZfqmoanV/yadootGr
j1Ze9ndr+YDXPpCymOsynmmw0ErHZGGW1OmMpAEt0A+613glWCURLDlP8HONi1wnINV6aDiEf0ad
9NMGxDsp+YWiRXD3txfo2OMQbpIxM90QfhKKacX8t1J1oAAWxDrLVTJBXBNvz5tr+D1sYwuye93r
hImmkM1unboxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHCzdYVE0+V8
XZOdsHDzowk2lYALdd8N5/TYYQtG0I0uMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MDUxMjAzNDMxMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB3zIaU5TX+oMSAx7eUIG9Z051v2Iup
kI3StHnoCFFu/9WuGdf5PHVjEJToXNbPrTBJIjauicYame9hZDFxrdVrfYub62VM1NDDiTYV6r17
0yO4+2nLnWgkcS4eRYFzN60xba8exvJVM83jzZsLjWdiSNt5TgB6XY/QRf/InR8mceo4ZoHTcCJR
OwkZYY98V9g/k/NgEQU/g4P3xPaYLYSY5pKAUkoRWRACEt+sg/8xCY6zJ3dsoPypos27tnsb1G+d
Hl0Iuskd6gdp0aR5nyg2Tjx3xUFLeJwhvqUDeOu0P7AECIFko54pkeVc2BYqJXw+LUXOC5OCXsme
aMTrqa5w
--00000000000056370d0618399147--

