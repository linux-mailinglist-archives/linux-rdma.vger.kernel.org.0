Return-Path: <linux-rdma+bounces-12161-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A98B049A7
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 23:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515141AA067B
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 21:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627F326A095;
	Mon, 14 Jul 2025 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="B8LE32yj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363DD25BF0E
	for <linux-rdma@vger.kernel.org>; Mon, 14 Jul 2025 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752529304; cv=none; b=aXB2lMCiEs1TaJkZ/pK5OOdWmNg1lFBMKSJzWtb5jePoAOcTZStytjkjN3DDkmD9Sy4BIqRRvJf3WbDu3eP3tW71vrMqDizyfV8yj2ZCSh/iiEkBYB3/CA7+UNtOKtXeW1/t1Awt0Zc/vy4BXW/we2EoMzf0W8UL1zU8wpuI0PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752529304; c=relaxed/simple;
	bh=1E9r8BSPKC+o7jJWUnJ3pGNiYBuvdKIF2fIpKk7ZUSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjmLKUnCnit/0WuDLtK/f0akKWUVXeuqZy09DOwwWBH1MUX/JmLSuJloZzuR5mR7ndXCuiFGs78kIJUvBC5b6CSJ/OmqLB1/4eWgrdzNjMKykUrdj06515DntBNQJErKX2MjRqD15n2n5zJzr3txpmRIrve0jDfL7RLbjrT2TDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=B8LE32yj; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5561c20e2d5so5934319e87.0
        for <linux-rdma@vger.kernel.org>; Mon, 14 Jul 2025 14:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1752529300; x=1753134100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeuVl+i5eH7303xgps02+QQBcnQD8NjGe8uFIkvkYVw=;
        b=B8LE32yjf7Yo/P3ulS3dRPmSrOzA/jki13MzSQeKgqQRogaaT1Ucf8hyAFEeRjAs+4
         Pwqdu54LvPrSiXaHmpPieeLv6apUjI53M8f/R0FjONcNJSHZuaGFSL4mwn1xJzzCHaw7
         GCY0cFVqvQNZ3W4v5Rg4G5uR6UKEfNrr8f6n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752529300; x=1753134100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeuVl+i5eH7303xgps02+QQBcnQD8NjGe8uFIkvkYVw=;
        b=pNqAOA5L8h9LiLaZPrXbfjGdjVs2Uti1CfG29ac/VlUxVAeKXFeRRn5GaB9QEsXUHk
         FmmRr9Urejitl2alleN/Ek7pZB7zdxyNWeY43xMxvpqOFKmz7NFgU8TTy1rrdUyoi858
         p1S5+KAes8RPObjbVsCmCm3KMt9mWjQbIMDSLw5hIToDs72mrn/u1tBS6WX0339jvEoo
         tLUn8RHnUvvAOHHaUpPgQV0P1TaFP1xnl/rAp34q2QaL+DwDFFkLyFR8DHle7HHH/pJb
         yiQrb2MpYXTUzRBkV8DboL92SygLD3kxkSNFVTL6Y7s58Ywd5hrnDmJw/7WlCQhu8/97
         HISg==
X-Forwarded-Encrypted: i=1; AJvYcCV5vJU/YIBCg8CUkESjTajQvYr5R+1wq6Ze9F4VAVNHuOK2rKE1oIhjLFAxu9YAvNKPiIqThH+Wlrtx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5G7OtmXmyx6rAdcQas/wFq2F0TpY/b9PxNZisDnhUGre60z8/
	+Q6YQG/nd2I2yuE+J3rpPnMBd6T1bKGDW7rNaYUdAc3PHKOkpXZLpmB0JoZI0txCI+IQXffAteu
	3ZiYmTrjJ/J+dBeFqdvBiSF0izEsmxYt1sVeTQOuoXA==
X-Gm-Gg: ASbGncvmoNfTcXFijIMnsSIo1xopLlJ9RAXmltyTj3RVnG5R3DeX7mEKSMCoQtDnoze
	OIgVyFAn6GpCOBn/e4SrdxeABWSBYNLrnAlQG35A9R9QKbkZy3ztqC7PXgziRdrv598VO8WV/FE
	wH06VMrEy6XGOJMMpihzXUMSrgeyakEtOuz84xu5bO78cs3ID2Stfgj57DdBc+010y+2w+Gqp1X
	CVz/cN0eMokdveZGu4=
X-Google-Smtp-Source: AGHT+IF4FeA7HurHQBJC0oFq9nKZb2BT+O2o3AVfy1rqi4cavl5uoJLUhqgKLLA6gwpAtz8R6guYMiPJcVXqvylwdds=
X-Received: by 2002:a05:6512:3d17:b0:553:accf:d75 with SMTP id
 2adb3069b0e04-55a0463bb73mr4554564e87.26.1752529300113; Mon, 14 Jul 2025
 14:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v1-0-ecaed8c2844e@openai.com>
 <20250713-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v1-2-ecaed8c2844e@openai.com>
 <befdca60-f9e5-486d-8df4-eafe4f338d79@gmail.com>
In-Reply-To: <befdca60-f9e5-486d-8df4-eafe4f338d79@gmail.com>
From: Christoph Paasch <cpaasch@openai.com>
Date: Mon, 14 Jul 2025 14:41:29 -0700
X-Gm-Features: Ac12FXw5v8dEpLfXk2OMQaf5wm0GPF7LtWFT6ZpEHza9LscbCJnC2qxuIkRjHmU
Message-ID: <CADg4-L9X4J27A2C+Lj+_VKMs2rzxiK5ZzQfh86TwZPrBtEnS8g@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net/mlx5: Avoid copying payload to the skb's
 linear part
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 12:29=E2=80=AFAM Tariq Toukan <ttoukan.linux@gmail.=
com> wrote:
>
>
>
> On 14/07/2025 2:33, Christoph Paasch via B4 Relay wrote:
> > From: Christoph Paasch <cpaasch@openai.com>
> >
> > mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
> > bytes from the page-pool to the skb's linear part. Those 256 bytes
> > include part of the payload.
> >
> > When attempting to do GRO in skb_gro_receive, if headlen > data_offset
> > (and skb->head_frag is not set), we end up aggregating packets in the
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
> >   87380  16384 262144    60.01    32547.82
> >
> > (netserver pinned to adjacent core receiving interrupts)
> > $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> >   87380  16384 262144    60.00    52531.67
> >
> > AFTER:
> > =3D=3D=3D=3D=3D=3D
> > (netserver pinned to core receiving interrupts)
> > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> >   87380  16384 262144    60.00    52896.06
> >
> > (netserver pinned to adjacent core receiving interrupts)
> >   $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> >   87380  16384 262144    60.00    85094.90
> >
>
> Nice improvement.
>
> Did you test impact on other archs?

I will see if I can get my hands on x86.

> Did you test impact on non-LRO flows?
> Specifically:
> a. Large MTU, tcp stream.
> b. Large MTU, small UDP packets.

You are right, I will extend the test-matrix and report results.

What tool do you recommend for generating the UDP-load ?

> > Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> > ---
> >   drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 33 ++++++++++++++++=
++++++++-
> >   1 file changed, 32 insertions(+), 1 deletion(-)
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
> >   }
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
> > +
> > +     if (l3_type =3D=3D CQE_L3_HDR_TYPE_IPV4)
> > +             min_hdr_len +=3D sizeof(struct iphdr);
> > +     else if (l3_type =3D=3D CQE_L3_HDR_TYPE_IPV6)
> > +             min_hdr_len +=3D sizeof(struct ipv6hdr);
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
> >   static struct sk_buff *
> >   mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_=
mpw_info *wi,
> >                                  struct mlx5_cqe64 *cqe, u16 cqe_bcnt, =
u32 head_offset,
> >                                  u32 page_idx)
>
> BTW, this function handles IPoIB as well, not only Eth.\

I see - is there something in the cqe that I can key off of to know
whether this is ethernet or not ?

Alternatively, I simply not add sizeof(struct ethhdr) to the headlen.
The primary goal is to not copy any payload. If I copy less, it's
still ok (got to benchmark this though).


Thanks,
Christoph

>
> >   {
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
> > +
> >       if (prog) {
> >               /* area for bpf_xdp_[store|load]_bytes */
> >               net_prefetchw(netmem_address(frag_page->netmem) + frag_of=
fset);
> >
>

