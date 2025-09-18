Return-Path: <linux-rdma+bounces-13210-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E67DB500D7
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 17:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762691C63152
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 15:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6BE350824;
	Tue,  9 Sep 2025 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="H72Yl/zC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD29933A027
	for <linux-rdma@vger.kernel.org>; Tue,  9 Sep 2025 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431128; cv=none; b=rgNx0FyVJ+Ut+KqHfaAN4NoJqRF3ZTsD08lk+hb/J85Y3NrwfL+ybvdKRASzgCuGIdMz/8sSdiwaqFyhWIpyzvDKeRVRf5VYPVA6aJBJsV7eZom9fOedUofwqPBkccpRxIALUFQnXdx555ahH7xLroBxu5GqMLUIsJLnlRDFchU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431128; c=relaxed/simple;
	bh=bR4dIdoRPS6mGjl21kqHScfk2rx+W6ycIilX7b/RNGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOamLdy7b6LrRYuL84cHSUlTG+A7G2/GU+a0oFyU6+XZFyErm3JJAPlRW0/DlEkHeN/V3xPzk+u9TrPSzLt73j5/jOFNHp6D5p1teF/xsSTWgLkh9ChTu8aF7S1aFp6zs1F6gpqpaEeqgu/NWhWLAOWqo2gG6e0irE34m9OgWHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=H72Yl/zC; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f72452a8eso6853539e87.3
        for <linux-rdma@vger.kernel.org>; Tue, 09 Sep 2025 08:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1757431125; x=1758035925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTmYm/3NJWN6FaiyVzu4eHMNvDOcOAN+2cDrv4pkNQA=;
        b=H72Yl/zCPpwPcCfemS1mUrNgI0UeCyWOkK4wrIWkbMhHWwljS8S/OqmNQUPcaZlT5u
         M6P4gm0xXOf/jiZEMeh9SGtb4bHL1ltWMMBuO7Mnx+DExPnndQZFq69DevBDPr8y17V/
         ams4FDRTAllxE331o80XHD25cJfCFPxUFeoJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757431125; x=1758035925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTmYm/3NJWN6FaiyVzu4eHMNvDOcOAN+2cDrv4pkNQA=;
        b=W3AwPiwMcifnQiDEjPitVGrHVLPqC+NIufCi69lUBoo7WPd83joE4G0Zbg2d1nvxNx
         Sv/U+nQj30BhHcSXQGqgTB3K/Xbca6T+oNJqMOj9NGzLQP+O/iQDYZ57dJ4yj6Y3kvr9
         xlMBwOrBuoi/T8Z3PybmdnIJRzSXdH15y6/Lv7IhmRyewKVDqmlXLctAiI1cceuP8fEb
         bVeM1P4ZwCi3WcR1r14jRNLyre9wnN8iTpQoKXWpTIgdq/XoFxDHOfIAKA8lSN3+Bu/Y
         uI2k1fimEgW7PzPnG2naIC/lCNjTmeZ11KP9yYCmyczruQISi7qEDVZN+5GkjQbJLpgP
         MeKw==
X-Forwarded-Encrypted: i=1; AJvYcCXnAOwowUCbb5gQWWn9Q+wXYdk7NusDLhm4qO9xVBklKpV8XmEcqtYuCQom9ug1PQVIuf0pwrlJZLkH@vger.kernel.org
X-Gm-Message-State: AOJu0YxQhzdyyVptLNWg2QYZI8TCE+tU5cWD7MxjnjLTfqYZioV6kRBH
	FfnJqm4CR3QZ01yJD70IjN7FWQAlNCFrlHhgByOBkx+AZ2SLI+FJVjz1CCQw8YKhL4h+/5GcZYC
	Tz06j2TQJuU1qXKDlPdZXwOqavF7c1BDaLfxp78hdDQ==
X-Gm-Gg: ASbGncuRxvDHPTeU0pS0+M1h0H1DkfIBQjj9FNOepuAN+xx9k9v80BOsAtJhd/88OUD
	NmPv3aiNQL0z/pACgtdZfnvELp1mBuwIXd8MAE38btFKZZ5v9tey/S4KwvwqcR9MYjjxeByD8W9
	iRsfjhlOmF16avOzB0lvcb+enWURTkxIsj4fGw80yEl8lfNML2wzHAKcpaRjHlP93aVoDcq2QDG
	9jypef65A75da2qfFDYtM/HNDD0vEZYBYdaos6DX3neAq+73NOjnw==
X-Google-Smtp-Source: AGHT+IFn4BOWF97PNcC3qO85DqmGcYDSyB3hTK4fzzbrhufLdnD7HWaPgAbvIg7kgSs2qLUEWNuedl/bAzFC23sgoI4=
X-Received: by 2002:a05:6512:1385:b0:55f:7193:1e8c with SMTP id
 2adb3069b0e04-562636d5c11mr4275328e87.31.1757431124882; Tue, 09 Sep 2025
 08:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v5-0-ea492f7b11ac@openai.com>
 <20250904-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v5-2-ea492f7b11ac@openai.com>
 <CAMB2axO4ySD2Lo9xzkkYdUqL2tHPcO02-h2HZiWT993wsU3NtA@mail.gmail.com> <CADg4-L92GbxSXaqg1KuoGxt2c_yC=gbmKywVPvcAjHY_7v2H1g@mail.gmail.com>
In-Reply-To: <CADg4-L92GbxSXaqg1KuoGxt2c_yC=gbmKywVPvcAjHY_7v2H1g@mail.gmail.com>
From: Christoph Paasch <cpaasch@openai.com>
Date: Tue, 9 Sep 2025 08:18:32 -0700
X-Gm-Features: AS18NWC8bTZ9zbKs1e6hJdbXPQ9cmJYIK9GtF_caFhUdPXvo43ULFYnM1yFVzB4
Message-ID: <CADg4-L8dLtzPL-x8o1HAHrbQ2fQ0MxB3Gm68HVj9Jp3-YunwrA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
To: Amery Hung <ameryhung@gmail.com>
Cc: Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 9:00=E2=80=AFPM Christoph Paasch <cpaasch@openai.com=
> wrote:
>
> On Thu, Sep 4, 2025 at 4:30=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
> >
> > On Thu, Sep 4, 2025 at 3:57=E2=80=AFPM Christoph Paasch via B4 Relay
> > <devnull+cpaasch.openai.com@kernel.org> wrote:
> > >
> > > From: Christoph Paasch <cpaasch@openai.com>
> > >
> > > mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
> > > bytes from the page-pool to the skb's linear part. Those 256 bytes
> > > include part of the payload.
> > >
> > > When attempting to do GRO in skb_gro_receive, if headlen > data_offse=
t
> > > (and skb->head_frag is not set), we end up aggregating packets in the
> > > frag_list.
> > >
> > > This is of course not good when we are CPU-limited. Also causes a wor=
se
> > > skb->len/truesize ratio,...
> > >
> > > So, let's avoid copying parts of the payload to the linear part. We u=
se
> > > eth_get_headlen() to parse the headers and compute the length of the
> > > protocol headers, which will be used to copy the relevant bits ot the
> > > skb's linear part.
> > >
> > > We still allocate MLX5E_RX_MAX_HEAD for the skb so that if the networ=
king
> > > stack needs to call pskb_may_pull() later on, we don't need to reallo=
cate
> > > memory.
> > >
> > > This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC =
and
> > > LRO enabled):
> > >
> > > BEFORE:
> > > =3D=3D=3D=3D=3D=3D=3D
> > > (netserver pinned to core receiving interrupts)
> > > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> > >  87380  16384 262144    60.01    32547.82
> > >
> > > (netserver pinned to adjacent core receiving interrupts)
> > > $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> > >  87380  16384 262144    60.00    52531.67
> > >
> > > AFTER:
> > > =3D=3D=3D=3D=3D=3D
> > > (netserver pinned to core receiving interrupts)
> > > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> > >  87380  16384 262144    60.00    52896.06
> > >
> > > (netserver pinned to adjacent core receiving interrupts)
> > >  $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> > >  87380  16384 262144    60.00    85094.90
> > >
> > > Additional tests across a larger range of parameters w/ and w/o LRO, =
w/
> > > and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), differ=
ent
> > > TCP read/write-sizes as well as UDP benchmarks, all have shown equal =
or
> > > better performance with this patch.
> > >
> > > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > > Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
> > > Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> > > ---
> > >  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/driver=
s/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > index 8bedbda522808cbabc8e62ae91a8c25d66725ebb..0ac31c7fb64cd60720d39=
0de45a5b6b453ed0a3f 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > @@ -2047,6 +2047,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e=
_rq *rq, struct mlx5e_mpw_info *w
> > >                 dma_sync_single_for_cpu(rq->pdev, addr + head_offset,=
 headlen,
> > >                                         rq->buff.map_dir);
> > >
> > > +               headlen =3D eth_get_headlen(rq->netdev, head_addr, he=
adlen);
> > > +
> > >                 frag_offset +=3D headlen;
> > >                 byte_cnt -=3D headlen;
> > >                 linear_hr =3D skb_headroom(skb);
> > > @@ -2123,6 +2125,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e=
_rq *rq, struct mlx5e_mpw_info *w
> > >                                 pagep->frags++;
> > >                         while (++pagep < frag_page);
> > >                 }
> > > +
> > > +               headlen =3D eth_get_headlen(rq->netdev, mxbuf->xdp.da=
ta, headlen);
> > > +
> >
> > The size of mxbuf->xdp.data is most likely not headlen here.
> >
> > The driver currently generates a xdp_buff with empty linear data, pass
> > it to the xdp program and assumes the layout If the xdp program does
> > not change the layout of the xdp_buff through bpf_xdp_adjust_head() or
> > bpf_xdp_adjust_tail(). The assumption is not correct and I am working
> > on a fix. But, if we keep that assumption for now, mxbuf->xdp.data
> > will not contain any headers or payload. The thing that you try to do
> > probably should be:
> >
> >         skb_frag_t *frag =3D &sinfo->frags[0];
> >
> >         headlen =3D eth_get_headlen(rq->netdev, skb_frag_address(frag),
> > skb_frag_size(frag));

So, when I look at the headlen I get, it is correct (even with my old
code using mxbuf->xdp.data).

To make sure I test the right thing, which scenario would
mxbuf->xdp.data not contain any headers or payload ? What do I need to
do to reproduce that ?

Thanks,
Christoph

>
> Ok, I think I understand what you mean! Thanks for taking the time to exp=
lain!
>
> I will do some tests on my side to make sure I get it right.
>
> As your change goes to net and mine to netnext, I can wait until yours
> is in the tree so that there aren't any conflicts that need to be
> taken care of.
>
>
> Christoph
>
> >
> >
> >
> > >                 __pskb_pull_tail(skb, headlen);
> > >         } else {
> > >                 if (xdp_buff_has_frags(&mxbuf->xdp)) {
> > >
> > > --
> > > 2.50.1
> > >
> > >

