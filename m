Return-Path: <linux-rdma+bounces-12372-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D894B0CCD2
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 23:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1526C1AA4FCF
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 21:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB9824166C;
	Mon, 21 Jul 2025 21:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="dxtVD5+Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EED172BB9
	for <linux-rdma@vger.kernel.org>; Mon, 21 Jul 2025 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753134273; cv=none; b=tgQ/bSTHCh0s+WiXBkau2H7hJ9fHAdORCiwFp6MZkV5ducCBwEvTZcEdURcBRR6oAKPRUEcZ6Yv71kcQrr2s/fW9M2Pp3NuCA7Rbc4eO+TDL06xDr0Gvfn/UIR3oEQ3gUFmItibYUPMbaOTrpZ/TXDBikwG/kUZzm4jdQO0uBo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753134273; c=relaxed/simple;
	bh=xj1YyEfkHgBd8Ct/L8B6Hf+DQ/ewdy2Kb5+tgH9/9xY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EwdYqBHqHqaoI+hAqUTn7ttoD+T9CuBOXyxXcqCQ/sGUJ9Xb+wLawX/Hm1mfn2buaBUowwwVsPEJKmVUQRoqn+qwJISK7NekFIu0SyN5F03QDHat0OVX5nyHT+fJLVxk/Z7+aUj1cb3Ri2RlzSrM6s3j7bI+o/+Jr0pnpd8BtQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=dxtVD5+Y; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-553dceb342fso4282483e87.0
        for <linux-rdma@vger.kernel.org>; Mon, 21 Jul 2025 14:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1753134269; x=1753739069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jED/IH2okMQBhZCF5xmT+94Tr+oj/M/1ra8B1IJxlvo=;
        b=dxtVD5+YCi5BqazOXIVRPMhJFPOB/k3c5QJcS1Mr244O3LWRgTPjJb+nsX2s3cTWtG
         6kHsGQRVLfZimEjRPTs0tz8dQN4a/fxEo0GV1hQ7ASjGkHJHwCeaR3XRXk1IiEPl71dq
         w3nYG/Uf0zWEiS+kEzelKfNN8xCFJq7dMnuYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753134269; x=1753739069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jED/IH2okMQBhZCF5xmT+94Tr+oj/M/1ra8B1IJxlvo=;
        b=tpfkn2Dv8tEaZG40umkPSwdHitGCBG/ooH5xPtYH8myF5AvPohvYUETALCf9QVf8qu
         P+UithKnmamX0Oz1KT5r6QO1h3+uoF4egSoMGJxhnZAQWf1JojL2GbJ0E0BARMrXo7md
         2sWeqNsGvJ39rMLZoFgLWe+pCQLmW/zl92uv/uOYRpu9Q2M9RFrxv4kHzUorLvU8JHFq
         ZeAZZjqG3LBVW0qY0QP5lJ1cRW1qXYTZv7mifjN2vy/pgCMt76VYIfJw8rDNOSYSco03
         hgfUajZUROaPujaMHDsRZm8WEdoH7MHw9Cb7J889YJq1XBAtj4KQXuS3lhx6OBVgwKce
         j42w==
X-Forwarded-Encrypted: i=1; AJvYcCUWthKHH8NzRZ6gP494btBTZwoXD76ZIeUWJkQWVkOINY+s9Xeuhrk8eB2h3Z1o8S/moHOKhvXjUPU0@vger.kernel.org
X-Gm-Message-State: AOJu0YyCQaLyR0vJIfPhs3YWI7mrIdTistBygYUxaD8CfFVl7KtHfYeF
	WrRhFKlLl+ZRptF0cU2wF2akasvvKBSjQmBQVWSVRIYV1B2bdAbi/HNTvrf85hnWrUoU6ELN+s6
	hWVZxEc5jZsg5b513xJBrOwmvITVce93czqED4Hojeg==
X-Gm-Gg: ASbGncvYCviz5RzJt5kSJ4yR7jrYO9IkDn/EL2BoI3uTNqJejujHYq2vWY1mYIPppi7
	sB2BrCBuCFXurSdfQXg5qEn+1NUnYy7PwKlDrx0wyCqorS3VjnUO2Z8a21C1A8VJqt7/JMDoHMq
	i+7Wl1GY0xgzzJqLEZtzOuR1DyG2sXloCuwoOr4t+FIsp7OlKTixFXaO9NiTwG6PizTwrcqTxrU
	rGkzfi0
X-Google-Smtp-Source: AGHT+IF1Ol7BKzqchQQ+Ra+jf/HGcte/MBFPJxD1DcjbCbR0vFmNQkZF+jTYansB4MR7YQ8V/RMQmElFZmTg59uy7VI=
X-Received: by 2002:a05:6512:2391:b0:553:ac4e:c41 with SMTP id
 2adb3069b0e04-55a296fd1ebmr5815783e87.28.1753134268954; Mon, 21 Jul 2025
 14:44:28 -0700 (PDT)
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
Date: Mon, 21 Jul 2025 14:44:17 -0700
X-Gm-Features: Ac12FXwSzjDW53mNA7ER5nj9SREiZSplWFyLA2ehkv_ZfndALm1pIGsjbEbWfXc
Message-ID: <CADg4-L9XoY_dwqicTLb62xbiy3+b3Wwf__qX97WSA9S8tuNjjQ@mail.gmail.com>
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

Hello!

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
>
> Did you test impact on non-LRO flows?
> Specifically:
> a. Large MTU, tcp stream.
> b. Large MTU, small UDP packets.

took a minute, but I have extended my benchmarks to a much larger test matr=
ix:

With / Without LRO
With / Without IPv6 encap
MTU: 1500, 4096, 9000
IRQs on same core as the app / IRQs on adjacent core as the app
TCP with write/read-size 64KB and 512KB
UDP with 64B and 1400B

A full matrix across all of the above for a total of 96 tests.

No measurable significant regressions (10% threshold).

Numerous improvements (above 10% threshold) in the TCP workloads:

  TCP 512-Kbyte, core 8, MTU 1500, LRO on, tunnel off     49810.51  ->
   61924.39  ( +24.3% =E2=86=91)
  TCP 512-Kbyte, core 8, MTU 1500, LRO on, tunnel on      24897.29  ->
   42404.18  ( +70.3% =E2=86=91)
  TCP 512-Kbyte, core 8, MTU 4096, LRO off, tunnel on     35218.00  ->
   41608.82  ( +18.1% =E2=86=91)
  TCP 512-Kbyte, core 8, MTU 4096, LRO on, tunnel on      25056.58  ->
   42231.90  ( +68.5% =E2=86=91)
  TCP 512-Kbyte, core 8, MTU 9000, LRO off, tunnel off    38688.81  ->
   50152.49  ( +29.6% =E2=86=91)
  TCP 512-Kbyte, core 8, MTU 9000, LRO off, tunnel on     23067.36  ->
   42593.14  ( +84.6% =E2=86=91)
  TCP 512-Kbyte, core 8, MTU 9000, LRO on, tunnel on      24671.25  ->
   41276.60  ( +67.3% =E2=86=91)
  TCP 512-Kbyte, core 9, MTU 1500, LRO on, tunnel on      25078.41  ->
   42473.55  ( +69.4% =E2=86=91)
  TCP 512-Kbyte, core 9, MTU 4096, LRO off, tunnel off    36962.68  ->
   40727.38  ( +10.2% =E2=86=91)
  TCP 512-Kbyte, core 9, MTU 4096, LRO on, tunnel on      24890.12  ->
   42248.13  ( +69.7% =E2=86=91)
  TCP 512-Kbyte, core 9, MTU 9000, LRO off, tunnel off    45620.36  ->
   58454.83  ( +28.1% =E2=86=91)
  TCP 512-Kbyte, core 9, MTU 9000, LRO off, tunnel on     23006.81  ->
   42985.67  ( +86.8% =E2=86=91)
  TCP 512-Kbyte, core 9, MTU 9000, LRO on, tunnel on      24539.75  ->
   42295.60  ( +72.4% =E2=86=91)
  TCP 64-Kbyte, core 8, MTU 1500, LRO on, tunnel off      38187.87  ->
   45568.38  ( +19.3% =E2=86=91)
  TCP 64-Kbyte, core 8, MTU 1500, LRO on, tunnel on       22683.89  ->
   43351.23  ( +91.1% =E2=86=91)
  TCP 64-Kbyte, core 8, MTU 4096, LRO on, tunnel on       23653.41  ->
   43988.30  ( +86.0% =E2=86=91)
  TCP 64-Kbyte, core 8, MTU 9000, LRO off, tunnel off     37677.10  ->
   48778.02  ( +29.5% =E2=86=91)
  TCP 64-Kbyte, core 8, MTU 9000, LRO off, tunnel on      23960.71  ->
   41828.04  ( +74.6% =E2=86=91)
  TCP 64-Kbyte, core 8, MTU 9000, LRO on, tunnel off      57001.62  ->
   68577.28  ( +20.3% =E2=86=91)
  TCP 64-Kbyte, core 8, MTU 9000, LRO on, tunnel on       24068.93  ->
   43836.63  ( +82.1% =E2=86=91)
  TCP 64-Kbyte, core 9, MTU 1500, LRO on, tunnel off      60887.66  ->
   68647.38  ( +12.7% =E2=86=91)
  TCP 64-Kbyte, core 9, MTU 1500, LRO on, tunnel on       22463.53  ->
   34560.19  ( +53.9% =E2=86=91)
  TCP 64-Kbyte, core 9, MTU 4096, LRO on, tunnel on       23253.21  ->
   43358.30  ( +86.5% =E2=86=91)
  TCP 64-Kbyte, core 9, MTU 9000, LRO off, tunnel off     40471.13  ->
   55189.89  ( +36.4% =E2=86=91)
  TCP 64-Kbyte, core 9, MTU 9000, LRO off, tunnel on      23880.19  ->
   42457.94  ( +77.8% =E2=86=91)
  TCP 64-Kbyte, core 9, MTU 9000, LRO on, tunnel on       22040.72  ->
   30249.36  ( +37.2% =E2=86=91)

(and I learned that even when LRO is off,
mlx5e_skb_from_cqe_mpwrq_nonlinear() is being used when MTU is large,
which is why we see improvements above even when LRO is off)

(I will include the additional benchmark data in a resubmission)

The primary remaining question is how to handle the IB-case. If
get_cqe_l3_hdr_type() will be 0x0 in case of IB, I can key off of
that.

Thoughts ?


Thanks,
Christoph



>
>
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
> BTW, this function handles IPoIB as well, not only Eth.
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

