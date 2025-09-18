Return-Path: <linux-rdma+bounces-13175-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 37472B4A078
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 06:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B7B34E216B
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 04:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AC027AC4D;
	Tue,  9 Sep 2025 04:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="L6SNCqxG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A4B22259B
	for <linux-rdma@vger.kernel.org>; Tue,  9 Sep 2025 04:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757390437; cv=none; b=SobSJFLaOYCFNjojK2EykU0wZl1+citQTl1V9eeiVKAagUvc6pD0VsMixjTMkO+Y/czLZADfFVPMfWmAe+T2r+5Ng4cw63Dg+7xnL/cvl1yIUFXpESSFnY5c58MeP3RQ+zUr3His8zqxeRU+LrPRMRdYXqPu0q11YaS33fphat0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757390437; c=relaxed/simple;
	bh=a1R6e/eD5AKWKndDSOC5/NWMXsZxuSjGOBmgQN214us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lstCC8rLe7vyi8GetJBCLn5or7dy165FpGHot+JpSvW3MA1gH3elFF5VxrrHT4RNwX9yjCDfXXMm/vUmKlcdT2Rte9Mrla9lIL8Rj0NhR5C2Iu+B7mAm4lmcI/j0+U79dBNBc4hCb4UHvUY4/x+PnclfOs757lEjBKbaS0sULIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=L6SNCqxG; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f76277413so5921296e87.3
        for <linux-rdma@vger.kernel.org>; Mon, 08 Sep 2025 21:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1757390433; x=1757995233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIztJIte7NdpqukioNjNPUTSRBW0pY7dvHNre0HHf6E=;
        b=L6SNCqxGEit3t8JwC4vVjHuGs80b55AStYVKNPImVGDy1jenNk9C1O0C5jqNjm5+0J
         qtV5bpZJrUDiOfu1PNzjVuET2mjVu1MgYdSRU410gAH/MQObPIMS8V38DhFkbWHk1bYP
         W1+aRStVbhYVW7BV6DA/1fRWQ5Vzg9EiaCXiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757390433; x=1757995233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIztJIte7NdpqukioNjNPUTSRBW0pY7dvHNre0HHf6E=;
        b=WCWbOXpye8ygCNIN+9/KFd1SU30JZgL/ssUV96JBP7TBTPwUXn1AJ/fNh3lgK1ffHJ
         MAyctfI2/zQI+fC9MAEoCAlZ71RiIo5+WNWWwQiTp4K1XysB8nq1CFHAM0Xsz4hl0e4h
         jHIDRF0RDJK7sXAB3maElGE4pRTkfwqE1AVFGIQsvXSe9ekPgj4mJ5a6/9m2qxTbmwV7
         gP+4xuxR/emIg9bJa2NNOr+JIqH09kvX4xoII6Kz7UZChkWgZQtcL3p/37yCzY83hCIn
         jgMvVIeF/9xGMETWdROumJri5ZgNdlyan2VdRVO9vNucIjFO62IqyUsDZnUCEdEfvWCl
         /tNw==
X-Forwarded-Encrypted: i=1; AJvYcCXvNu5bPCWxY5IU1WGdrjnxytkjQRzOlxRFA64gLXS535kP1MKIVWSALxxmsKj96W+90/FvDVdyQVJF@vger.kernel.org
X-Gm-Message-State: AOJu0YyRLRGGXqktzPU6PGPJgTl4q6GnP1fQbLr2gGpvkClXwUwqbVyw
	jA30kvpYzaCdRB04nYMVcFZAHr4FLNxA+PhR5w1SPnIt16DZltl3Twgoo/u1my2Lv/J9iWX8uz1
	lhHHQVi5VOlOuFk9Se7NYjGZTScaApmLRc8y1LT+0nw==
X-Gm-Gg: ASbGncu3+wBk2P/j6IXt4GJN/C2gNUZT+H+cM/TapgNkWb6v49wj2J3GRcgIUtTo6mV
	nsRX8o3MRD4UtF+x/ypB5zhyAjk9NoECmgRI/LgadrObK5nPsW+mJ4UHPnkfmAaBnxf7dXNIp4o
	ug0VjtH0Tn9L+8s1+QfZUFbGtaw2yKbKYTPLb3/4jC6HQd0F9Bc0B8M6TcSqYqajkyEFPlbImiN
	s/kc1pa3XPJ0rBj2IKzXpk69MEyIcX6tEaRHfWFJHTtnURgnitd
X-Google-Smtp-Source: AGHT+IGtQx4CGX2QbOtOVxGuLDCpXQnpz2q0tz/oZMYlySYpi7BY05WVNIjTDJSPhxKHQBwEHlTuPHlRoGHoV98hKec=
X-Received: by 2002:a05:6512:3d08:b0:560:956e:43a5 with SMTP id
 2adb3069b0e04-5625f817d1bmr3345206e87.9.1757390433342; Mon, 08 Sep 2025
 21:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v5-0-ea492f7b11ac@openai.com>
 <20250904-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v5-2-ea492f7b11ac@openai.com>
 <CAMB2axO4ySD2Lo9xzkkYdUqL2tHPcO02-h2HZiWT993wsU3NtA@mail.gmail.com>
In-Reply-To: <CAMB2axO4ySD2Lo9xzkkYdUqL2tHPcO02-h2HZiWT993wsU3NtA@mail.gmail.com>
From: Christoph Paasch <cpaasch@openai.com>
Date: Mon, 8 Sep 2025 21:00:22 -0700
X-Gm-Features: AS18NWA2xP8aOi_uzpaJaO-H50O6SLEh5xWnRqrw4G1Ukcbhxnaro2KuLYyNLYM
Message-ID: <CADg4-L92GbxSXaqg1KuoGxt2c_yC=gbmKywVPvcAjHY_7v2H1g@mail.gmail.com>
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

On Thu, Sep 4, 2025 at 4:30=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> On Thu, Sep 4, 2025 at 3:57=E2=80=AFPM Christoph Paasch via B4 Relay
> <devnull+cpaasch.openai.com@kernel.org> wrote:
> >
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
> > So, let's avoid copying parts of the payload to the linear part. We use
> > eth_get_headlen() to parse the headers and compute the length of the
> > protocol headers, which will be used to copy the relevant bits ot the
> > skb's linear part.
> >
> > We still allocate MLX5E_RX_MAX_HEAD for the skb so that if the networki=
ng
> > stack needs to call pskb_may_pull() later on, we don't need to realloca=
te
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
> > Additional tests across a larger range of parameters w/ and w/o LRO, w/
> > and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), differen=
t
> > TCP read/write-sizes as well as UDP benchmarks, all have shown equal or
> > better performance with this patch.
> >
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
> > Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_rx.c
> > index 8bedbda522808cbabc8e62ae91a8c25d66725ebb..0ac31c7fb64cd60720d390d=
e45a5b6b453ed0a3f 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > @@ -2047,6 +2047,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_r=
q *rq, struct mlx5e_mpw_info *w
> >                 dma_sync_single_for_cpu(rq->pdev, addr + head_offset, h=
eadlen,
> >                                         rq->buff.map_dir);
> >
> > +               headlen =3D eth_get_headlen(rq->netdev, head_addr, head=
len);
> > +
> >                 frag_offset +=3D headlen;
> >                 byte_cnt -=3D headlen;
> >                 linear_hr =3D skb_headroom(skb);
> > @@ -2123,6 +2125,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_r=
q *rq, struct mlx5e_mpw_info *w
> >                                 pagep->frags++;
> >                         while (++pagep < frag_page);
> >                 }
> > +
> > +               headlen =3D eth_get_headlen(rq->netdev, mxbuf->xdp.data=
, headlen);
> > +
>
> The size of mxbuf->xdp.data is most likely not headlen here.
>
> The driver currently generates a xdp_buff with empty linear data, pass
> it to the xdp program and assumes the layout If the xdp program does
> not change the layout of the xdp_buff through bpf_xdp_adjust_head() or
> bpf_xdp_adjust_tail(). The assumption is not correct and I am working
> on a fix. But, if we keep that assumption for now, mxbuf->xdp.data
> will not contain any headers or payload. The thing that you try to do
> probably should be:
>
>         skb_frag_t *frag =3D &sinfo->frags[0];
>
>         headlen =3D eth_get_headlen(rq->netdev, skb_frag_address(frag),
> skb_frag_size(frag));

Ok, I think I understand what you mean! Thanks for taking the time to expla=
in!

I will do some tests on my side to make sure I get it right.

As your change goes to net and mine to netnext, I can wait until yours
is in the tree so that there aren't any conflicts that need to be
taken care of.


Christoph

>
>
>
> >                 __pskb_pull_tail(skb, headlen);
> >         } else {
> >                 if (xdp_buff_has_frags(&mxbuf->xdp)) {
> >
> > --
> > 2.50.1
> >
> >

