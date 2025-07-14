Return-Path: <linux-rdma+bounces-12164-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AC2B04A86
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 00:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E087F4A147B
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 22:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1474C2798ED;
	Mon, 14 Jul 2025 22:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Y6969227"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30C727990D
	for <linux-rdma@vger.kernel.org>; Mon, 14 Jul 2025 22:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531772; cv=none; b=hClXPFN8WSKVh6tiEneLXNT6Y4Yc+VpKuprc/mn696SSdUD7pkCtdSQ4kPRB/dtKRqjKOLK6JI7CmgURLHrUyUEEFRfu06ykRnjIA0AL6wTP2vK2GVayk4MkQvhBNGpQAFhnx4uDBjvmeQb6Xsq/ouLoWx9rdBqiTa+IEUUFC2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531772; c=relaxed/simple;
	bh=p9XVMQzKlkJR2uziJtB5iiGfN9ykOGLQGNAFglp2q4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPqDu0RP7+QRhuk0gRnU+39dtLwLV6r4zZBHWSrownU30XecMm0IlbwJydWi5M69LkM5wQjGIkzfOBBEiyfGbDae5TEGPZpBgSpqhYjR5uOyYueTed5eKu6FIpkylXgyNKTlGs20m63fOVm/NoPrxMetjxEhs64DfcXIzRgeJ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Y6969227; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-558fc8f0750so5717766e87.2
        for <linux-rdma@vger.kernel.org>; Mon, 14 Jul 2025 15:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1752531765; x=1753136565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDp4C+T9O5cBpXTpdiAMs9wdKZ8kVj0Lui5L/9Om+x8=;
        b=Y6969227HACxZs4v8i6Wa5fCQbQ+DRx/Pgd0qAcwbDrZNmeMX/Vx3Mc6He8nudGXZ/
         o8Uh4NJ51NUYzFyxH9InoiwczX0nz17LKHAXNEYBBUIw2CpedKZstQDXhi9pwToFlr9n
         E08/YhGWOI44UsIfLxGtdp+svRfZS6aEDiGck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752531765; x=1753136565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDp4C+T9O5cBpXTpdiAMs9wdKZ8kVj0Lui5L/9Om+x8=;
        b=Jrx5wWPjdrOO4nI/vgDvTpa29z5e4J87Kyn69hBDuE/XhBKze2iVgv58M6KR9AKM7r
         CliIIEDMSC1tce0Eo4eomd0mlPoRqYrEYoTgcSF+BKvUXXKHgN/73kXAYnYOlXu9nq7A
         dlqwn1xrYlazWW3YV4g255FRMad1k8wLd69dd+7v3aZJlv+Isbxu7uBH72SXyZAsTcnn
         vVy+dAcYRBO9mzakpXJulbEXVrYtzYMfVaRoicyNl7UBLtOiT7VBNXR6eg0bPYOjjSKi
         xyRBO+xq5QdWZqmgH6DZ4NLSDU0C/Tyzf/ahIu6kzHHGtI+mkmY1wpTMfTAZY0OJXOjZ
         vQcA==
X-Forwarded-Encrypted: i=1; AJvYcCUnPWEQzlER8oeKHBqtQRi/2xP3//Jwq0qNJ8jo5THfbd9kkmPAPE8YCeheen/HkzPvmQsBK4r1ubP8@vger.kernel.org
X-Gm-Message-State: AOJu0YzoGHCRHxdhIE2m0ubwWDrv15XCWuryabGYYENgCqDrWBQJYBHJ
	qKm7lbQwdk3FOynzKCzUiNpe5JBKzsjnuV9jqJyBDKlfRME+VKamxngFtXcM6m+QAyph8nSUmQ6
	Q0U4dp9m80cKK5TdMCMBrQvJd3SS4MMEtFUOFbGPyJg==
X-Gm-Gg: ASbGncv98T70tBSEgZmxtTKHsg8KZZ7JcPImuTK3rgsRBGk50aajUVYr65n0ZgTzV+k
	MUsertvchL8PrtVNEQM6KZ8OHcOCMbd5+6Zp17z7tAF4DYpfczT/GrncPMAOcIysBK/eriyKPq9
	sFSzHR/S8f6BcCBHi62euSo7WCAn3kTpi3FVs1/J9Iaq+t2oDhSbGvoS7mT1UNBpfWoqEw++ywX
	pumCCZS
X-Google-Smtp-Source: AGHT+IFbuQa3AtT5odWdip9sWEwhbeWS/Vq//92CV+s3n/EtzhCNy4hij5W4zVocbt+E2/NHsUbEqg4V+PmwDQaXors=
X-Received: by 2002:a05:6512:401a:b0:553:2633:8a64 with SMTP id
 2adb3069b0e04-55a044e4afcmr3649180e87.23.1752531764951; Mon, 14 Jul 2025
 15:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v1-0-ecaed8c2844e@openai.com>
 <20250713-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v1-2-ecaed8c2844e@openai.com>
 <98c8c7d7-4b1a-474f-86b6-884d79ea4e41@intel.com>
In-Reply-To: <98c8c7d7-4b1a-474f-86b6-884d79ea4e41@intel.com>
From: Christoph Paasch <cpaasch@openai.com>
Date: Mon, 14 Jul 2025 15:22:34 -0700
X-Gm-Features: Ac12FXx5dt2zKcEl92_SaduMLpqLmJBaJOa3H-th5Q3eGGfmbFTR5ux_MCkP9Ss
Message-ID: <CADg4-L-YRbFeDsmeREZKJpe2aZ4g+LXbxNTPe_nCJ=7v3jgTgg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net/mlx5: Avoid copying payload to the skb's
 linear part
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 7:23=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Christoph Paasch Via B4 Relay <devnull+cpaasch.openai.com@kernel.or=
g>
> Date: Sun, 13 Jul 2025 16:33:07 -0700
>
> > From: Christoph Paasch <cpaasch@openai.com>
> >
> > mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
> > bytes from the page-pool to the skb's linear part. Those 256 bytes
> > include part of the payload.
> >
> > When attempting to do GRO in skb_gro_receive, if headlen > data_offset
> > (and skb->head_frag is not set), we end up aggregating packets in the
>
> How did you end up with ->head_frag not set? IIRC mlx5 uses
> napi_build_skb(), which explicitly sets ->head_frag to true.
> It should be false only for kmalloced linear parts.

This particular code-path calls napi_alloc_skb() which ends up calling
__alloc_skb() and won't set head_frag to 1.

> > frag_list.
> >
> > This is of course not good when we are CPU-limited. Also causes a worse
> > skb->len/truesize ratio,...
> >
> > So, let's avoid copying parts of the payload to the linear part. The
> > goal here is to err on the side of caution and prefer to copy too littl=
e
> > instead of copying too much (because once it has been copied over, we
> > trigger the above described behavior in skb_gro_receive).
> >
> > So, we can do a rough estimate of the header-space by looking at
> > cqe_l3/l4_hdr_type and kind of do a lower-bound estimate. This is now
> > done in mlx5e_cqe_get_min_hdr_len(). We always assume that TCP timestam=
ps
> > are present, as that's the most common use-case.
> >
> > That header-len is then used in mlx5e_skb_from_cqe_mpwrq_nonlinear for
> > the headlen (which defines what is being copied over). We still
> > allocate MLX5E_RX_MAX_HEAD for the skb so that if the networking stack
> > needs to call pskb_may_pull() later on, we don't need to reallocate
> > memory.
> >
> > This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC an=
d
> > LRO enabled):
> >
> > BEFORE:
> > =3D=3D=3D=3D=3D=3D=3D
> > (netserver pinned to core receiving interrupts)
> > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> >  87380  16384 262144    60.01    32547.82
> >
> > (netserver pinned to adjacent core receiving interrupts)
> > $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> >  87380  16384 262144    60.00    52531.67
> >
> > AFTER:
> > =3D=3D=3D=3D=3D=3D
> > (netserver pinned to core receiving interrupts)
> > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> >  87380  16384 262144    60.00    52896.06
> >
> > (netserver pinned to adjacent core receiving interrupts)
> >  $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> >  87380  16384 262144    60.00    85094.90
> >
> > Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 33 +++++++++++++++++=
+++++++-
> >  1 file changed, 32 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_rx.c
> > index 2bb32082bfccdc85d26987f792eb8c1047e44dd0..2de669707623882058e3e77=
f82d74893e5d6fefe 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > @@ -1986,13 +1986,40 @@ mlx5e_shampo_fill_skb_data(struct sk_buff *skb,=
 struct mlx5e_rq *rq,
> >       } while (data_bcnt);
> >  }
> >
> > +static u16
> > +mlx5e_cqe_get_min_hdr_len(const struct mlx5_cqe64 *cqe)
> > +{
> > +     u16 min_hdr_len =3D sizeof(struct ethhdr);
> > +     u8 l3_type =3D get_cqe_l3_hdr_type(cqe);
> > +     u8 l4_type =3D get_cqe_l4_hdr_type(cqe);
> > +
> > +     if (cqe_has_vlan(cqe))
> > +             min_hdr_len +=3D VLAN_HLEN;
>
> Can't Q-in-Q be here?

Yes, see my reply below.

>
> > +
> > +     if (l3_type =3D=3D CQE_L3_HDR_TYPE_IPV4)
> > +             min_hdr_len +=3D sizeof(struct iphdr);
> > +     else if (l3_type =3D=3D CQE_L3_HDR_TYPE_IPV6)
> > +             min_hdr_len +=3D sizeof(struct ipv6hdr);
>
> You don't account extensions and stuff here.

Yes - see my reply below.

>
> > +
> > +     if (l4_type =3D=3D CQE_L4_HDR_TYPE_UDP)
> > +             min_hdr_len +=3D sizeof(struct udphdr);
> > +     else if (l4_type & (CQE_L4_HDR_TYPE_TCP_NO_ACK |
> > +                         CQE_L4_HDR_TYPE_TCP_ACK_NO_DATA |
> > +                         CQE_L4_HDR_TYPE_TCP_ACK_AND_DATA))
> > +             /* Previous condition works because we know that
> > +              * l4_type !=3D 0x2 (CQE_L4_HDR_TYPE_UDP)
> > +              */
> > +             min_hdr_len +=3D sizeof(struct tcphdr) + TCPOLEN_TSTAMP_A=
LIGNED;
> > +
> > +     return min_hdr_len;
> > +}
> > +
> >  static struct sk_buff *
> >  mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_m=
pw_info *wi,
> >                                  struct mlx5_cqe64 *cqe, u16 cqe_bcnt, =
u32 head_offset,
> >                                  u32 page_idx)
> >  {
> >       struct mlx5e_frag_page *frag_page =3D &wi->alloc_units.frag_pages=
[page_idx];
> > -     u16 headlen =3D min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
> >       struct mlx5e_frag_page *head_page =3D frag_page;
> >       struct mlx5e_xdp_buff *mxbuf =3D &rq->mxbuf;
> >       u32 frag_offset    =3D head_offset;
> > @@ -2004,10 +2031,14 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e=
_rq *rq, struct mlx5e_mpw_info *w
> >       u32 linear_frame_sz;
> >       u16 linear_data_len;
> >       u16 linear_hr;
> > +     u16 headlen;
> >       void *va;
> >
> >       prog =3D rcu_dereference(rq->xdp_prog);
> >
> > +     headlen =3D min3(mlx5e_cqe_get_min_hdr_len(cqe), cqe_bcnt,
> > +                    (u16)MLX5E_RX_MAX_HEAD);
>
> For your usecase, have you tried setting headlen to just ETH_HLEN here?
> Fast GRO should still work for this case, then VLAN/IP/L4 layers will
> do a couple memcpy()s to pull their headers, but even on 32-bit MIPS
> this was faster than let's say eth_get_headlen() (which involves Flow
> Dissector) or open-coded header length assumptions as above.
>
> (the above was correct for 2020 when I last time played with router
>  drivers, but I hope nothing's been broken since then)

Yes, as you correctly point out, it is all about avoiding to copy any
payload to have fast GRO.

I can give it a shot of just copying eth_hlen. And see what perf I
get. You are probably right that it won't matter much. I just thought
that as I have the bits in the cqe that give me some hints on what
headers are present, I can just be slightly more efficient.

Thanks,
Christoph

>
> > +
> >       if (prog) {
> >               /* area for bpf_xdp_[store|load]_bytes */
> >               net_prefetchw(netmem_address(frag_page->netmem) + frag_of=
fset);
>
> Thanks,
> Olek

