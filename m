Return-Path: <linux-rdma+bounces-8643-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20926A5EE26
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 09:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65E017C831
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 08:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489761F9A86;
	Thu, 13 Mar 2025 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CHBRaTOs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9944926036D
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855050; cv=none; b=HaORhxPbXQ75C8FD4a4/Pp7ctKMDREnOdpGzi8pccfz69UpO3q7V6biekJsjvog+HP0uGQxQJDgt0xXDzAV3GHmEzYFMgIK90TbQ4EGI4anOcFu8EF8hCEGQtzjE78Z6h66I/5frrCqsmjZ2D+gWpymRFGOwNTulV4PYPMOm6lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855050; c=relaxed/simple;
	bh=/Vpcf2//0Xp6CsS4tdHT5c6Ln6LBKynF4UFUJJ7U1IQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msD3dxoC9D1eoCLxCJVtLq3oe4LnO50pC3ow4QzfZ7F2dJ1g3lnM9rbcHKBHg3DLAIL9z2XDVU1iNXYkAp5muXM22NTVouyfrIaPfPT0H0eJIMYYzPr+AN3F/fXzqhnDOAPv7qdQ1V0Uh0eibh04z5wrSl09TxIc+LpQCS/V32A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CHBRaTOs; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3fa6c54cc1aso448912b6e.1
        for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 01:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741855046; x=1742459846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dDE2IUdwyJLLVl/r0bhUjC9yfz2berRPpwOktwUH1pM=;
        b=CHBRaTOsKwjiJppeWewZTuvLVQmB6dchQ3UGJAUW4X/YafCO1s1fcnzf7E5ReZerKf
         h2AV5qX8fH3RGTp/THlxeAcA48MLtp4JP4nfHbc3M0fUd75VmoEM021ta3NvZCi0fnI4
         qHafyCXLMnYO5bvqSxpzrJytNYaynO9ff+VPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741855046; x=1742459846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dDE2IUdwyJLLVl/r0bhUjC9yfz2berRPpwOktwUH1pM=;
        b=oXKcZzx0Gaf+4C75+qlIheaN5/A64tSeeLN2+iRI+nrc0HWbz9lYGaof6AOcWZrj9n
         rBv7XthRuWbisxGDRSefnh8uoH2NSyWAkPems0Vs3zn/E0kYxH1C4lbeR4IrFVr1/rHK
         T6r9X16qAyCvkcyIYcnLmey3YKJNiI7wZIkVfyf7AukRyA0ewzbFdsM5rgCDpGP4zNac
         sNi5q/qpKoWQDXM6Thx/ncZi2djnzEvhAs1iIZzajoJnR6OUJdi2ge1GMXex17Cf0wne
         OdBmiHRoI/WQoZRrpBjipGoLIgAQgnBO356LR9JHCI1DWDM/sM4VViFVYWRG/YX9L+MC
         XyyA==
X-Forwarded-Encrypted: i=1; AJvYcCV4H3REkqbvO53DPe2uEN1yS/tLsP5znlBZoXgr9ybLXudlpaZz5jOXuNaqdVtUpD47GPYPALo226Xx@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrd07ee+DWXC/CvW9sRza8AOgxux2Cm1PwEsz4YFma0hxmiG2W
	uAuehtRscrie/F0XriKhhybpdptlbHDw0Eh6s6/iBjrs3j7mfseSM4J5wFJqZKFvHVysAax+wYo
	RnPc/V9Bp6Rci87vMJSW11DQOEZlnc5ntI7jp
X-Gm-Gg: ASbGnctgAQvaSiIm0lYnc6dx7RTe3a4YVfu8yuK3XF5mDgpkaahp1QiuiDSnrZOLpDQ
	NEvP1/OvTibd3InfTvbAzHknoU62oXNTRIjcr+XnGCVvstqLm1JEhw317iNlCOZpg+DhJU6oVLG
	mv12GJKCuhmPn/KxpmZwN4oMnEdb8=
X-Google-Smtp-Source: AGHT+IHYpy/Q/5G0XBCLQLzOA5k+rGYT96lgrDTrVPzCVxGcfdpbzoPASqP3eYDSMDNMUfqQz5eiLsbq/tfHpXOzHl4=
X-Received: by 2002:a05:6808:1b11:b0:3fa:d6c:cdb8 with SMTP id
 5614622812f47-3fa0d6cd1a9mr6202660b6e.38.1741855046399; Thu, 13 Mar 2025
 01:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1741770069-1455-1-git-send-email-selvin.xavier@broadcom.com> <20250312185957.GH1322339@unreal>
In-Reply-To: <20250312185957.GH1322339@unreal>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Thu, 13 Mar 2025 14:07:14 +0530
X-Gm-Features: AQ5f1JpYEuy75b_OIPL1Ia4bDYWD-QOc94k9D3sJQp5CsfyPOdKHHKdRwJZFK9I
Message-ID: <CA+sbYW2bMOtep_EXXGHH_SCFyRCNF=fdpk2xM4992SikdrDdxA@mail.gmail.com>
Subject: Re: [PATCH rdma-next v2] RDMA/bnxt_re: Support Perf management counters
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Preethi G <preethi.gurusiddalingeswaraswamy@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000502f230630353bff"

--000000000000502f230630353bff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 12:30=E2=80=AFAM Leon Romanovsky <leon@kernel.org> =
wrote:
>
> On Wed, Mar 12, 2025 at 02:01:09AM -0700, Selvin Xavier wrote:
> > From: Preethi G <preethi.gurusiddalingeswaraswamy@broadcom.com>
> >
> > Add support for process_mad hook to retrieve the perf management counte=
rs.
> > Supports IB_PMA_PORT_COUNTERS and IB_PMA_PORT_COUNTERS_EXT counters.
> > Query the data from HW contexts and FW commands.
> >
> > Signed-off-by: Preethi G <preethi.gurusiddalingeswaraswamy@broadcom.com=
>
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> > v1->v2:
> >       Fix the warning reported by kernel test robot by returning rc
> >  drivers/infiniband/hw/bnxt_re/bnxt_re.h     |  4 ++
> >  drivers/infiniband/hw/bnxt_re/hw_counters.c | 88 +++++++++++++++++++++=
++++++++
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c    | 36 ++++++++++++
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.h    |  6 ++
> >  drivers/infiniband/hw/bnxt_re/main.c        |  1 +
> >  5 files changed, 135 insertions(+)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniba=
nd/hw/bnxt_re/bnxt_re.h
> > index b33b04e..8bc0237 100644
> > --- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> > +++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> > @@ -246,6 +246,10 @@ struct bnxt_re_dev {
> >  #define BNXT_RE_CHECK_RC(x) ((x) && ((x) !=3D -ETIMEDOUT))
> >  void bnxt_re_pacing_alert(struct bnxt_re_dev *rdev);
> >
> > +int bnxt_re_assign_pma_port_counters(struct bnxt_re_dev *rdev, struct =
ib_mad *out_mad);
> > +int bnxt_re_assign_pma_port_ext_counters(struct bnxt_re_dev *rdev,
> > +                                      struct ib_mad *out_mad);
> > +
> >  static inline struct device *rdev_to_dev(struct bnxt_re_dev *rdev)
> >  {
> >       if (rdev)
> > diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infi=
niband/hw/bnxt_re/hw_counters.c
> > index 3ac47f4..d90f2cb 100644
> > --- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
> > +++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
> > @@ -39,6 +39,8 @@
> >
> >  #include <linux/types.h>
> >  #include <linux/pci.h>
> > +#include <rdma/ib_mad.h>
> > +#include <rdma/ib_pma.h>
> >
> >  #include "roce_hsi.h"
> >  #include "qplib_res.h"
> > @@ -285,6 +287,92 @@ static void bnxt_re_copy_db_pacing_stats(struct bn=
xt_re_dev *rdev,
> >               readl(rdev->en_dev->bar0 + rdev->pacing.dbr_db_fifo_reg_o=
ff);
> >  }
> >
> > +int bnxt_re_assign_pma_port_ext_counters(struct bnxt_re_dev *rdev, str=
uct ib_mad *out_mad)
> > +{
> > +     struct ib_pma_portcounters_ext *pma_cnt_ext;
> > +     struct bnxt_qplib_ext_stat *estat =3D &rdev->stats.rstat.ext_stat=
;
> > +     struct ctx_hw_stats *hw_stats =3D NULL;
> > +     int rc =3D 0;
> > +
> > +     hw_stats =3D rdev->qplib_ctx.stats.dma;
> > +
> > +     pma_cnt_ext =3D (void *)(out_mad->data + 40);
> > +     if (_is_ext_stats_supported(rdev->dev_attr->dev_cap_flags)) {
> > +             u32 fid =3D PCI_FUNC(rdev->en_dev->pdev->devfn);
> > +
> > +             rc =3D bnxt_qplib_qext_stat(&rdev->rcfw, fid, estat);
>
> And why don't you stop after getting an "rc !=3D 0" here?
We can. I will post v3.
>
> Thanks
>
> > +     }
> > +
> > +     pma_cnt_ext =3D (void *)(out_mad->data + 40);
> > +     if ((bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) && rdev->is_virtfn=
) ||
> > +         !bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx)) {
> > +             pma_cnt_ext->port_xmit_data =3D
> > +                     cpu_to_be64(le64_to_cpu(hw_stats->tx_ucast_bytes)=
 / 4);
> > +             pma_cnt_ext->port_rcv_data =3D
> > +                     cpu_to_be64(le64_to_cpu(hw_stats->rx_ucast_bytes)=
 / 4);
> > +             pma_cnt_ext->port_xmit_packets =3D
> > +                     cpu_to_be64(le64_to_cpu(hw_stats->tx_ucast_pkts))=
;
> > +             pma_cnt_ext->port_rcv_packets =3D
> > +                     cpu_to_be64(le64_to_cpu(hw_stats->rx_ucast_pkts))=
;
> > +             pma_cnt_ext->port_unicast_rcv_packets =3D
> > +                     cpu_to_be64(le64_to_cpu(hw_stats->rx_ucast_pkts))=
;
> > +             pma_cnt_ext->port_unicast_xmit_packets =3D
> > +                     cpu_to_be64(le64_to_cpu(hw_stats->tx_ucast_pkts))=
;
> > +
> > +     } else {
> > +             pma_cnt_ext->port_rcv_packets =3D cpu_to_be64(estat->rx_r=
oce_good_pkts);
> > +             pma_cnt_ext->port_rcv_data =3D cpu_to_be64(estat->rx_roce=
_good_bytes / 4);
> > +             pma_cnt_ext->port_xmit_packets =3D cpu_to_be64(estat->tx_=
roce_pkts);
> > +             pma_cnt_ext->port_xmit_data =3D cpu_to_be64(estat->tx_roc=
e_bytes / 4);
> > +             pma_cnt_ext->port_unicast_rcv_packets =3D cpu_to_be64(est=
at->rx_roce_good_pkts);
> > +             pma_cnt_ext->port_unicast_xmit_packets =3D cpu_to_be64(es=
tat->tx_roce_pkts);
> > +     }
> > +     return rc;
> > +}
> > +
> > +int bnxt_re_assign_pma_port_counters(struct bnxt_re_dev *rdev, struct =
ib_mad *out_mad)
> > +{
> > +     struct bnxt_qplib_ext_stat *estat =3D &rdev->stats.rstat.ext_stat=
;
> > +     struct ib_pma_portcounters *pma_cnt;
> > +     struct ctx_hw_stats *hw_stats =3D NULL;
> > +     int rc =3D 0;
> > +
> > +     hw_stats =3D rdev->qplib_ctx.stats.dma;
> > +
> > +     pma_cnt =3D (void *)(out_mad->data + 40);
> > +     if (_is_ext_stats_supported(rdev->dev_attr->dev_cap_flags)) {
> > +             u32 fid =3D PCI_FUNC(rdev->en_dev->pdev->devfn);
> > +
> > +             rc =3D bnxt_qplib_qext_stat(&rdev->rcfw, fid, estat);
> > +     }
> > +     if ((bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) && rdev->is_virtfn=
) ||
> > +         !bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx)) {
> > +             pma_cnt->port_rcv_packets =3D
> > +                     cpu_to_be32((u32)(le64_to_cpu(hw_stats->rx_ucast_=
pkts)) & 0xFFFFFFFF);
> > +             pma_cnt->port_rcv_data =3D
> > +                     cpu_to_be32((u32)((le64_to_cpu(hw_stats->rx_ucast=
_bytes) &
> > +                                        0xFFFFFFFF) / 4));
> > +             pma_cnt->port_xmit_packets =3D
> > +                     cpu_to_be32((u32)(le64_to_cpu(hw_stats->tx_ucast_=
pkts)) & 0xFFFFFFFF);
> > +             pma_cnt->port_xmit_data =3D
> > +                     cpu_to_be32((u32)((le64_to_cpu(hw_stats->tx_ucast=
_bytes)
> > +                                        & 0xFFFFFFFF) / 4));
> > +     } else {
> > +             pma_cnt->port_rcv_packets =3D cpu_to_be32(estat->rx_roce_=
good_pkts);
> > +             pma_cnt->port_rcv_data =3D cpu_to_be32((estat->rx_roce_go=
od_bytes / 4));
> > +             pma_cnt->port_xmit_packets =3D cpu_to_be32(estat->tx_roce=
_pkts);
> > +             pma_cnt->port_xmit_data =3D cpu_to_be32((estat->tx_roce_b=
ytes / 4));
> > +     }
> > +     pma_cnt->port_rcv_constraint_errors =3D (u8)(le64_to_cpu(hw_stats=
->rx_discard_pkts) & 0xFF);
> > +     pma_cnt->port_rcv_errors =3D cpu_to_be16((u16)(le64_to_cpu(hw_sta=
ts->rx_error_pkts)
> > +                                                  & 0xFFFF));
> > +     pma_cnt->port_xmit_constraint_errors =3D (u8)(le64_to_cpu(hw_stat=
s->tx_error_pkts) & 0xFF);
> > +     pma_cnt->port_xmit_discards =3D cpu_to_be16((u16)(le64_to_cpu(hw_=
stats->tx_discard_pkts)
> > +                                                     & 0xFFFF));
> > +
> > +     return rc;
> > +}
> > +
> >  int bnxt_re_ib_get_hw_stats(struct ib_device *ibdev,
> >                           struct rdma_hw_stats *stats,
> >                           u32 port, int index)
> > diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infinib=
and/hw/bnxt_re/ib_verbs.c
> > index 2de101d..dc31973 100644
> > --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > @@ -49,6 +49,7 @@
> >  #include <rdma/ib_addr.h>
> >  #include <rdma/ib_mad.h>
> >  #include <rdma/ib_cache.h>
> > +#include <rdma/ib_pma.h>
> >  #include <rdma/uverbs_ioctl.h>
> >  #include <linux/hashtable.h>
> >
> > @@ -4489,6 +4490,41 @@ void bnxt_re_mmap_free(struct rdma_user_mmap_ent=
ry *rdma_entry)
> >       kfree(bnxt_entry);
> >  }
> >
> > +int bnxt_re_process_mad(struct ib_device *ibdev, int mad_flags,
> > +                     u32 port_num, const struct ib_wc *in_wc,
> > +                     const struct ib_grh *in_grh,
> > +                     const struct ib_mad *in_mad, struct ib_mad *out_m=
ad,
> > +                     size_t *out_mad_size, u16 *out_mad_pkey_index)
> > +{
> > +     struct bnxt_re_dev *rdev =3D to_bnxt_re_dev(ibdev, ibdev);
> > +     struct ib_class_port_info cpi =3D {};
> > +     int ret =3D IB_MAD_RESULT_SUCCESS;
> > +     int rc =3D 0;
> > +
> > +     if (in_mad->mad_hdr.mgmt_class  !=3D IB_MGMT_CLASS_PERF_MGMT)
> > +             return ret;
> > +
> > +     switch (in_mad->mad_hdr.attr_id) {
> > +     case IB_PMA_CLASS_PORT_INFO:
> > +             cpi.capability_mask =3D IB_PMA_CLASS_CAP_EXT_WIDTH;
> > +             memcpy((out_mad->data + 40), &cpi, sizeof(cpi));
> > +             break;
> > +     case IB_PMA_PORT_COUNTERS_EXT:
> > +             rc =3D bnxt_re_assign_pma_port_ext_counters(rdev, out_mad=
);
> > +             break;
> > +     case IB_PMA_PORT_COUNTERS:
> > +             rc =3D bnxt_re_assign_pma_port_counters(rdev, out_mad);
> > +             break;
> > +     default:
> > +             rc =3D -EINVAL;
> > +             break;
> > +     }
> > +     if (rc)
> > +             return IB_MAD_RESULT_FAILURE;
> > +     ret |=3D IB_MAD_RESULT_REPLY;
> > +     return ret;
> > +}
> > +
> >  static int UVERBS_HANDLER(BNXT_RE_METHOD_NOTIFY_DRV)(struct uverbs_att=
r_bundle *attrs)
> >  {
> >       struct bnxt_re_ucontext *uctx;
> > diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infinib=
and/hw/bnxt_re/ib_verbs.h
> > index fbb16a4..22c9eb8 100644
> > --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> > +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> > @@ -268,6 +268,12 @@ void bnxt_re_dealloc_ucontext(struct ib_ucontext *=
context);
> >  int bnxt_re_mmap(struct ib_ucontext *context, struct vm_area_struct *v=
ma);
> >  void bnxt_re_mmap_free(struct rdma_user_mmap_entry *rdma_entry);
> >
> > +int bnxt_re_process_mad(struct ib_device *device, int process_mad_flag=
s,
> > +                     u32 port_num, const struct ib_wc *in_wc,
> > +                     const struct ib_grh *in_grh,
> > +                     const struct ib_mad *in_mad, struct ib_mad *out_m=
ad,
> > +                     size_t *out_mad_size, u16 *out_mad_pkey_index);
> > +
> >  static inline u32 __to_ib_port_num(u16 port_id)
> >  {
> >       return (u32)port_id + 1;
> > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/=
hw/bnxt_re/main.c
> > index e9e4da4..59ddb36 100644
> > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > @@ -1276,6 +1276,7 @@ static const struct ib_device_ops bnxt_re_dev_ops=
 =3D {
> >       .post_recv =3D bnxt_re_post_recv,
> >       .post_send =3D bnxt_re_post_send,
> >       .post_srq_recv =3D bnxt_re_post_srq_recv,
> > +     .process_mad =3D bnxt_re_process_mad,
> >       .query_ah =3D bnxt_re_query_ah,
> >       .query_device =3D bnxt_re_query_device,
> >       .modify_device =3D bnxt_re_modify_device,
> > --
> > 2.5.5
> >

--000000000000502f230630353bff
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
hImmkM1unboxggJgMIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEINNqd3eUjVIR
7hYaHmlVpW3cgU0L3huskkXJ3N9kwIBxMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI1MDMxMzA4MzcyNlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBACBAy0906V/MPAQ6o8AbL9E2zBdqTlZ1QXmmX0WS8s1KTPmf
w2KBjnV1IylGPGRkw/LIRcBKp5fRgJrJjCi5oAjIzvYoXkLL2O9D/6QtRR31DERNCavpoWI66gIK
UKsZjXAfmnoqn8HaZmU20NAbCQqNVWvmW3Z47+zaJkfmIGHilzTGTbe1EUD3F0wp9MkJjRP86MGG
5M1QGJOcn5UwN+yN2B0whMrAdC3+wYvzPNxq3dkKGShbnRpK/cRnELHfljQL/4Cy5gyHaZZ7lnWu
25TSitQZriLTnUaGDSjzTXLpnjVnGJNeNQrfQkbfwcrb0JiVX4imESsBLlj+zfQVigs=
--000000000000502f230630353bff--

