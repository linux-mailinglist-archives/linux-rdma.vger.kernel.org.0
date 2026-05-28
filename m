Return-Path: <linux-rdma+bounces-21416-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBVYAj7cF2phTQgAu9opvQ
	(envelope-from <linux-rdma+bounces-21416-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 08:10:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 577135ED257
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 08:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E31EA301DE2A
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 06:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468AD32548B;
	Thu, 28 May 2026 06:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ZOFqU3Ho"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC2121D3CC
	for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 06:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779948458; cv=fail; b=eUzcDY1RYKSreYHVyJQ95QsinEts/fdG+lwUHGoxzTsn65tekD0zTKkphQxrcfgfJrKQ5SbCsIv5m5YOUyESNiSox2FdKYBdmOnG5V3PiT+VnCy0spg8sWoGBuINs5N+EHP55N1FkMBrEy7V8RekyoiyOVnIfnvVaCiCk5zhcWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779948458; c=relaxed/simple;
	bh=HybfouVWXzRjvqZuKWAwoAOqax6hVl/L0qzWeXk42y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJ5T7fuf4EvIAwxLhL7dKx4+gY10cg9sq41kAnBNZG4bOhGKjIZ6rO4ExhA/x89xP6X8OeRGFArSleGZXHtoDJ96c0VYYEqRAsc8X+lsGa3aIJqeThiYGg/MZbFnM93sdKicLvMKWsM5k7h30yIotlRdZgvmsIK3cdf5bM9OwE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ZOFqU3Ho; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKjGp94094128
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 23:07:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=GzyvN6ALmGZhc9sEe0zXVntaZeAULheQgTQ/UjOlmfA=; b=ZOFqU3Hokw+Y
	1tWm8OSAw3VppcsXhCy7NjQiED7GF+zwJ1AY0cTIbpcpdYBGC9llvuLJbd1+8rlL
	AXglm2b6A1JTOk8fAn271XgFKVQJNxo2oeVdhw6YawXARksZ4FY4tBG2ugql/lrl
	OpiEUZkdO9HHKOHR42fEty/p77Y0/ml5/z5VbIqwt1zZ3po1sXwT9rtBHbQ0Yd0z
	OPfICWCY2j6tJ46Bv6NfLAq1xI7tfkCqinN5m/CdB/cWEoFzjnUgH0lExTWRP6QW
	U1M02kqSfyicM6TQnFCDh+VID+oYzzysKR/LHRJ/8h9AQoXwa+/h4ymbOE6Zwdfz
	Cn+zoh4Arg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7x6ag8d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 23:07:35 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e60308f6b9so2964387a34.1
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 23:07:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779948455; cv=none;
        d=google.com; s=arc-20240605;
        b=dfgSJKbH/nOmiFBY7XMESnLgOyUURjTvXxVthCX40IoppOMg9Wl4DK9RpKNc888f6J
         oJZm2dwvFoNP5MJw4p8/fzQ1mLrehZp658ok5KQtpM5WPWzh5V0bK7scX5wjTrinumJ8
         Bsx8jxp1/EudkRjZ6kejDGVN2EJpMBfLldSx973n4mnFNmf1KWuTuCT/h4xI8nuuJRTR
         a1xwKUtcxJXDKHgOl5ls+fLFPiTOOW++QuiyT0UqdhgsXriB7pt1i621CF1ga36YQQ0a
         MwFeeIrl4SnxIYZAd1XvMjk/WQmyag4t129wH39cT8XOm+cN5ZiwD0LmyhoZSwBbMuzG
         NqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=UyukGN55miahfwjIGNs2ZpmYU5zHedrWyyN1uj6F1U8=;
        fh=mgrcUhaZwAOtwDN+9lcrbcMq0ic8HYAgL/BdDNlDCC4=;
        b=M2bMLq7Lag6gsBGnsX/KD7pNsQaKU9S/bl+JuvQMn5KuwJH4sKKE5cz/GWP1MdiH4d
         jCXmS5jyYzcug/dk1g0WrCkuDJtkg2c2Pa1LS4zU/CCK0MRtsjljvL+wneipr1ti7LMm
         pxxwRVInDjcZ4NR/Oq3b6jt+v4A1FDzGcOvg29u92k1D70+S1DHhO5jvHwrfQKiCQDJP
         Zy9gFjWD8Xdn4Zj53njBa+XztnDvTCZBdxbMdwhVmvi1MPDCw2bS7pFbHopMTEsT9cjA
         j5GGVKDzrd1WIiySrVt23P6+Rb9yy8agbEYMW4n7VbSO9Be8+hlFTxNjLSlXECJRBv4u
         tNng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779948455; x=1780553255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UyukGN55miahfwjIGNs2ZpmYU5zHedrWyyN1uj6F1U8=;
        b=jSgMUKsrXd7syJXzIGgf/gmptqhqLPV0O/Mf3c2qHL9NCGtMBEpR1/yYBUvYEV/kQT
         +zBlmU+y8jyrogWDqcMDcCh0LCq/s+CaxvxX6GpgfwImRBOvrWDiKxmlZtoCYsgMJDHh
         vlVAOvCIJvk/Hcj76E1metfv8trn8mWP6WLNJe6oGTq8HCySdGW3OTY+TwmlXv0fNXgM
         2fLj/HDqqMzZT7HMakKXKOtF5xZ6F7vxKPl9EdIyskJ7YFi0Do1kB+3Dh2rGXqdabNAq
         Hyau2jknQEiRev+m7VE5p3dayTnGChS6QcFDoONPdxJwb+uYurBiLai+qUVf0KoBmD7J
         jVeA==
X-Forwarded-Encrypted: i=1; AFNElJ+OpKJ8j0JbhCbAVvnehECUbIHnN4UWCQFr2tm6WXmUoB2NMZhIm3/S4AxGbg0DlZ08Hu0DNh8dSK78@vger.kernel.org
X-Gm-Message-State: AOJu0Yymgs6nEXi0QP6a+abXdzZP425PWPL6X8EOyhGdPwpKij27U2Ah
	ToLokSgafQf5QLpy+qSLvPMdLV6JLyqUdr80NbSp8apDJLwcApdXvV36+PZE0O88MU0GrCoWZLB
	oD+MbMqqBYuKf0HnQeZ/G5a1My2ZIBY+06MY+mCkhIxm3eWEkX+RZbpXtjwIJ2XGJOp+KR19U+2
	RS4OOoaxCDDKVAXI+9Yyes8xDKMayFrM3FO1Wt
X-Gm-Gg: Acq92OELitI0IZl9Pp2XEnBp5otwz9DsYJlO0Ab7W9HIuoD8vLGMsx7cIz1C/7sAR/i
	CwqZHSU/AepEd86RK0ufGzvaqHkVPQOL6q46weeTEmszR457O98yYm4f2BVpqRVWZHZrQ8L6/h4
	rV6Hl8DHQcdT47k6O9F4ytrEqqZs/5QR8eJM5avsIczfiRzY4suWiaxuH3UDfTYQ5dKR1P+t2mI
	AW68FOnPzDCfAXSBRZa1618LkDGYjdMsFIye+5yoCBBH/8DYzg=
X-Received: by 2002:a05:6830:3789:b0:7dc:cdea:7d4 with SMTP id 46e09a7af769-7e5fed4d4c7mr17428841a34.11.1779948454587;
        Wed, 27 May 2026 23:07:34 -0700 (PDT)
X-Received: by 2002:a05:6830:3789:b0:7dc:cdea:7d4 with SMTP id
 46e09a7af769-7e5fed4d4c7mr17428818a34.11.1779948454085; Wed, 27 May 2026
 23:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com> <20260526144401.1485788-5-zhipingz@meta.com>
 <55b57a12-6714-4c51-8ce1-f47c97cfecde@nvidia.com>
In-Reply-To: <55b57a12-6714-4c51-8ce1-f47c97cfecde@nvidia.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 27 May 2026 23:07:23 -0700
X-Gm-Features: AVHnY4K3avPQ8FNE3xy07LlbZrchvRUwd-Dc4i84TnsR6M8GdnFKvihXHQqWEMo
Message-ID: <CAH3zFs27rY5E5q1ybjYf0jjMc_t7NCs6T1dt=1P4io9MOrK5nQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: Michael Gur <michaelgur@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Ipi_zd8PhXOK3LAKS8_h1o2UlBJgDmMv
X-Authority-Analysis: v=2.4 cv=TdymcxQh c=1 sm=1 tr=0 ts=6a17dba7 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=Ikd4Dj_1AAAA:8 a=VabnemYjAAAA:8 a=rnG5qNUxfvSO4QYeIecA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: Ipi_zd8PhXOK3LAKS8_h1o2UlBJgDmMv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA1OCBTYWx0ZWRfX4M0FKmrCwH9u
 jxLmw17o+RoPsW6oQX6cK+tRJw8jMXptqkjpChEfUlPQefucANS6mNXotM/AYHi1aZVo7SA3b3D
 dUCZgnaivhRIvAG2ntSt0Y30c1jTjh0Ef/LYZiabb/iF4uw5AxQ9Rr1rOThuIuSURRhtfzLolHV
 hAu9jxLSlvJJ1h/YzKEiyf0Mv/8xNCdJl/OirFsvDuWMyn8sUixcW7j/1ulWYYKmuF8Rf0jTqu6
 gEkORRyIrOjV7TCliE9VtcQCGzerSz29BhTix80MzGFO3taDIWVaRA6iloS9CsksgE63Z9jkVl5
 /Eso/HkwvVwzYmUEWlV5ybqkrbDi2C+ikuVGPjyuFTL1/jxjN4FosIym8XUk3R0cS+PigssQV7+
 eDCEd5kF7LWEBRI7neZAuqkbApa2/JIQlloEC6b+RIlJ7DEH7S4TWsk3xTUIHFFnttmEdEksYXC
 cG4dbZ22qWAc9KQwMtw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_FROM(0.00)[bounces-21416-lists,linux-rdma=lfdr.de];
	TAGGED_RCPT(0.00)[linux-rdma];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[meta.com:+]
X-Rspamd-Queue-Id: 577135ED257
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 3:55=E2=80=AFPM Michael Gur <michaelgur@nvidia.com>=
 wrote:
>
> >
>
> On 5/26/2026 5:43 PM, Zhiping Zhang wrote:
> > Query dma-buf TPH metadata when registering a dma-buf MR for peer-to-
> > peer access and translate the returned steering tag into an mlx5 ST
> > index. Keep the DMAH path as the first priority and only fall back to
> > DMA-buf metadata when no DMAH is supplied.
> >
> > Track per-MR ownership of the allocated ST index and release it on MR
> > setup failure, destroy, and FRMR-pool reuse. Release the ST index before
> > the MR is pushed back into the FRMR pool, and free mlx5_st_idx_data when
> > its refcount reaches zero so repeated allocation/deallocation does not
> > leak memory.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >   drivers/infiniband/hw/mlx5/mlx5_ib.h          |  6 ++
> >   drivers/infiniband/hw/mlx5/mr.c               | 86 ++++++++++++++++++-
> >   .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 28 ++++--
> >   include/linux/mlx5/driver.h                   |  7 ++
> >   4 files changed, 115 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/=
hw/mlx5/mlx5_ib.h
> > index e156dc4d7529..4ab867392267 100644
> > --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > @@ -721,6 +721,12 @@ struct mlx5_ib_mr {
> >                       u8 revoked :1;
> >                       /* Indicates previous dmabuf page fault occurred =
*/
> >                       u8 dmabuf_faulted:1;
> > +                     /* Set when the MR owns dmabuf_st_index and must
> > +                      * release it via mlx5_st_dealloc_index() once the
> > +                      * firmware mkey is no longer referencing it.
> > +                      */
> mkey st value is kept after revoke, regardless of st alloc and dealloc.
> mkeys are kept in FRMR pool for future reuse even if their st index is
> currently stale.

Understood, i'll work the comment accordingly.

> > +                     u8 dmabuf_st_owned:1;
> > +                     u16 dmabuf_st_index;
> st_index can be read from the frmr pool key. No need to store again.
> >                       struct mlx5_ib_mkey null_mmkey;
> >               };
> >       };
> > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/ml=
x5/mr.c
> > index 3b6da45061a5..8059b5e4da97 100644
> > --- a/drivers/infiniband/hw/mlx5/mr.c
> > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > @@ -38,6 +38,7 @@
> >   #include <linux/delay.h>
> >   #include <linux/dma-buf.h>
> >   #include <linux/dma-resv.h>
> > +#include <linux/pci-tph.h>
> >   #include <rdma/frmr_pools.h>
> >   #include <rdma/ib_umem_odp.h>
> >   #include "dm.h"
> > @@ -46,6 +47,8 @@
> >   #include "data_direct.h"
> >   #include "dmah.h"
> >
> > +MODULE_IMPORT_NS("DMA_BUF");
> > +
> >   static int mkey_max_umr_order(struct mlx5_ib_dev *dev)
> >   {
> >       if (MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset))
> > @@ -899,6 +902,63 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_at=
tach_ops =3D {
> >       .invalidate_mappings =3D mlx5_ib_dmabuf_invalidate_cb,
> >   };
> >
> > +/*
> > + * Query TPH metadata from @dmabuf and translate the raw steering tag =
into
> > + * an mlx5 ST index. On success, returns 0 and the caller becomes the
> > + * owner of *@st_index (must be released with mlx5_st_dealloc_index()
> > + * once the firmware mkey no longer references it). On any failure
> > + * *@st_index and *@ph are left as the no-TPH defaults set by the call=
er.
> > + *
> > + * @dmabuf must already be referenced by the caller (e.g. via the umem=
's
> > + * attachment) so we don't re-resolve the user's fd here and avoid a
> > + * dup2() TOCTOU between umem creation and TPH lookup.
> > + */
> > +static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, struct dma_buf =
*dmabuf,
> > +                           u16 *st_index, u8 *ph)
> > +{
> > +     u8 req_type;
> > +     u16 steering_tag;
> > +     u8 st_width;
> > +     int ret;
> > +
> > +     if (!dmabuf->ops->get_tph)
> > +             return;
> > +
> > +     req_type =3D pcie_tph_enabled_req_type(dev->mdev->pdev);
> > +     switch (req_type) {
> > +     case PCI_TPH_REQ_TPH_ONLY:
> > +             st_width =3D 8;
> > +             break;
> > +     case PCI_TPH_REQ_EXT_TPH:
> > +             st_width =3D 16;
> > +             break;
> > +     default:
> > +             return;
> > +     }
> > +
> > +     ret =3D dmabuf->ops->get_tph(dmabuf, &steering_tag, ph, st_width);
> > +     if (ret) {
> > +             mlx5_ib_dbg(dev, "get_tph failed (%d)\n", ret);
> > +             *ph =3D MLX5_IB_NO_PH;
> > +             return;
> > +     }
> > +
> > +     ret =3D mlx5_st_alloc_index_by_tag(dev->mdev, steering_tag, st_in=
dex);
> > +     if (ret) {
> > +             *ph =3D MLX5_IB_NO_PH;
> > +             mlx5_ib_dbg(dev, "st_alloc_index_by_tag failed (%d)\n", r=
et);
> > +     }
> > +}
> > +
> > +static void mlx5_ib_mr_put_dmabuf_st(struct mlx5_ib_mr *mr)
> > +{
> > +     if (mr->umem && mr->dmabuf_st_owned) {
> > +             mlx5_st_dealloc_index(mr_to_mdev(mr)->mdev,
> > +                                   mr->dmabuf_st_index);
> > +             mr->dmabuf_st_owned =3D 0;
> > +     }
> > +}
> > +
> >   static struct ib_mr *
> >   reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
> >                  u64 offset, u64 length, u64 virt_addr,
> > @@ -941,16 +1001,26 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct devi=
ce *dma_device,
> >               ph =3D dmah->ph;
> >               if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
> >                       st_index =3D mdmah->st_index;
> > +     } else {
> > +             get_tph_mr_dmabuf(dev, umem_dmabuf->attach->dmabuf,
> > +                               &st_index, &ph);
> >       }
> >
> >       mr =3D alloc_cacheable_mr(pd, &umem_dmabuf->umem, virt_addr,
> >                               access_flags, access_mode,
> >                               st_index, ph);
> >       if (IS_ERR(mr)) {
> > +             if (!dmah && st_index !=3D MLX5_MKC_PCIE_TPH_NO_STEERING_=
TAG_INDEX)
> > +                     mlx5_st_dealloc_index(dev->mdev, st_index);
> >               ib_umem_release(&umem_dmabuf->umem);
> >               return ERR_CAST(mr);
> >       }
> >
> > +     if (!dmah && st_index !=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDE=
X) {
> > +             mr->dmabuf_st_index =3D st_index;
> > +             mr->dmabuf_st_owned =3D 1;
> > +     }
> > +
> >       mlx5_ib_dbg(dev, "mkey 0x%x\n", mr->mmkey.key);
> >
> >       atomic_add(ib_umem_num_pages(mr->umem), &dev->mdev->priv.reg_page=
s);
> > @@ -1377,9 +1447,17 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5=
_ib_mr *mr)
> >       bool is_odp =3D is_odp_mr(mr);
> >       int ret;
> >
> > -     if (mr->ibmr.frmr.pool && !mlx5_umr_revoke_mr_with_lock(mr) &&
> > -         !ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr))
> > -             return 0;
> > +     if (mr->ibmr.frmr.pool && !mlx5_umr_revoke_mr_with_lock(mr)) {
> > +             /*
> > +              * The mkey has been revoked: firmware no longer referenc=
es
> > +              * dmabuf_st_index, so release it before this mr can re-e=
nter
> > +              * the FRMR cache for reuse by another registration.
> > +              */
> > +             mlx5_ib_mr_put_dmabuf_st(mr);
> > +
> > +             if (!ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr))
> > +                     return 0;
> > +     }
>
> The Sashiko comment on previous version of this series was wrong about
> the concept of FRMR pools and its reuse of mkeys.
>
> Please move the st put operation outside the mkey cleanup flow.
>

will do.

Thanks,
Zhiping

