Return-Path: <linux-rdma+bounces-12147-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B60BB045DC
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 18:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3BB3BDFDA
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 16:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB94262FC3;
	Mon, 14 Jul 2025 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="dh/HiEfw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583B533991
	for <linux-rdma@vger.kernel.org>; Mon, 14 Jul 2025 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511774; cv=none; b=emjFkBDEsl04Lhzr7wHxnPQyL6KWhejqJcuubV+Zq1HvgRr/YVOz1Zed3hcmKtt9Z9WiXj4baYAZvOk+MjKGuRfCK95bXCKzL9VTjm2a8Xumdv/lIGJl2s16EXq5Dc+gi6VaTkjiISp1OhQPIZ+S1dzOMgMmvtZmj2DyQL84giE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511774; c=relaxed/simple;
	bh=VpPvE0BXtGWZsme+31CUE5h2U24uVwbM5rkpTKhj+Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVAkba2HLMVnc44hE2FDQKqJjF5Jm63/e1chVcTW+ef3yvvX8Nf+5Fyp6jOOeBrrT8cfRFbW2KgFkaY3gnBnQqkezxqw5ZiEqDQz6Oc9D7bAAaI5EJ5CIbbxkc9+YM4B//oKpL9Knn+mrbYGa1quFYNaqsZJRUFAlSr+VnFWjz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=dh/HiEfw; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-555024588b1so5117398e87.1
        for <linux-rdma@vger.kernel.org>; Mon, 14 Jul 2025 09:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1752511770; x=1753116570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynAUe2Q1DW4AfqcQz3HRrwxICMyA9IFpO/YX4QIZho0=;
        b=dh/HiEfw4Qjpf5XKB/fNuWa8CgiHfKMqotZWicJO2bscPxPQ4gqwyNfOGSVsLR3yVX
         g9bbZXGJADQb+74i0PDLyWXQjW7IZXTf1IYYv9xZQaOF6U06nuoyXRi2XNhXQST97RUx
         r0h3IzLdmBxDctWbOyLofQ5j2OXZX9U4bVONY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511770; x=1753116570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynAUe2Q1DW4AfqcQz3HRrwxICMyA9IFpO/YX4QIZho0=;
        b=jPDf7NDG7RVjel3mrPc1vHDT6pTedysfk4hwzCZcpx0wupmvU/4Gg5CeFPMmMvVo/m
         wiXO2JlUmJ3hJjTHMisSnLCjXNv8olE1OBEawZz78A3piKhhrDJIQyZj+2cgQmwrrrnQ
         o9l9Ou/RZjokpFeVA8Mhy5/tfPIhp24lqqzCdihLLY7CbJUTkdFDEyT5rv0KPtEdqnHc
         IiJ05pPYHAxzp74FWwjfbny55Ut6wFOeG50TpgOE+xlE9ErxzDJwlBmc8t362UMl/dz3
         PneRs8NBdlY55m6X9+//BzEdFvfxeVwJL1u7TyCJIi1iBxE4EK1MomK4GQF7J4nT0Seu
         CkJw==
X-Forwarded-Encrypted: i=1; AJvYcCWb/i3yApqrz5UcKGDm04Nw6XnbBd3faIgr5ygR95HhUlbotasTwk11kqtWFizGiPUqV5T1pia5HS7K@vger.kernel.org
X-Gm-Message-State: AOJu0YxjTs+L9QqOd2j8H/PjKL4dtPweJXg1gfpNL9Q0otsNMsr1DGJS
	avAlTbaQhdQrzNENzx5iN3GnRPL6tVeYfkQn8YlMEwda2/cqyLfXYxrEo5ikwrro8uePQkLqD8e
	EuuQDGbyC0LcnD56U264aMuPc7ZMvHyUKoSJrmtRD7w==
X-Gm-Gg: ASbGnctPUT+alns3SZhGAmrc4EyMq4pGZTDcHxV3NHVsg/LzoPPqSgCdyKESo/9sQvk
	cZQGGvPbYo+eFoy8Y5oXS4uHL/2NcQtsbJiPPdTDIzQHCs1BYHUvHIOOiuHLsBlGuKvCW0WACJT
	RYz4Uo3HdVIPCdFiQ9gPZhDnoKrzNS/zTdrUZk3OgJj2NiULdRAFqL9JWR6lWXXtytpuv1Ah19M
	ihrAESX
X-Google-Smtp-Source: AGHT+IFPxMMQ+9OBz9e1/ccLzs7ntz+dQOqDY/7wvbPDeymC665tI+vNllo3CFUQWZrgZHEjIADsd3unBk+xa0jgCyo=
X-Received: by 2002:a05:6512:39c3:b0:553:2fec:b139 with SMTP id
 2adb3069b0e04-55a044ec444mr4567693e87.24.1752511770209; Mon, 14 Jul 2025
 09:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710182629.78456-2-cpaasch@openai.com> <ea4ce9e9-9070-4733-8c96-41394035f046@gmail.com>
In-Reply-To: <ea4ce9e9-9070-4733-8c96-41394035f046@gmail.com>
From: Christoph Paasch <cpaasch@openai.com>
Date: Mon, 14 Jul 2025 09:49:18 -0700
X-Gm-Features: Ac12FXwwux-bRkCnwDGj1pA3DkkRwjR-iIbxrysWD2ygzzAIUHHFqXQvE6SczRE
Message-ID: <CADg4-L86-6Bn8trYyd-+KdQ4NMmYKa5z+zmo32StYYmBBRpcdw@mail.gmail.com>
Subject: Re: [PATCH net] net/mlx5: Correctly set gso_size when LRO is used
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Amir Vadai <amirv@mellanox.com>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2025 at 11:49=E2=80=AFPM Tariq Toukan <ttoukan.linux@gmail.=
com> wrote:
>
>
>
> On 10/07/2025 21:26, christoph.paasch@gmail.com wrote:
> > From: Christoph Paasch <cpaasch@openai.com>
> >
> > gso_size is expected by the networking stack to be the size of the
> > payload (thus, not including ethernet/IP/TCP-headers). However, cqe_bcn=
t
> > is the full sized frame (including the headers). Dividing cqe_bcnt by
> > lro_num_seg will then give incorrect results.
> >
> > For example, running a bpftrace higher up in the TCP-stack
> > (tcp_event_data_recv), we commonly have gso_size set to 1450 or 1451 ev=
en
> > though in reality the payload was only 1448 bytes.
> >
> > So, we need to discount the protocol headers from cqe_bcnt so we can
> > actually divide the payload by lro_num_seg to get the real gso_size.
> >
> > Fixes: e586b3b0baee ("net/mlx5: Ethernet Datapath files")
> > Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> > ---
> >   .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 20 +++++++++++++++---=
-
> >   1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_rx.c
> > index 84b1ab8233b8..e23bb80b0e0d 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > @@ -1154,12 +1154,14 @@ static void mlx5e_lro_update_tcp_hdr(struct mlx=
5_cqe64 *cqe, struct tcphdr *tcp)
> >       }
> >   }
> >
> > -static void mlx5e_lro_update_hdr(struct sk_buff *skb, struct mlx5_cqe6=
4 *cqe,
> > -                              u32 cqe_bcnt)
> > +static unsigned int mlx5e_lro_update_hdr(struct sk_buff *skb,
> > +                                      struct mlx5_cqe64 *cqe,
> > +                                      u32 cqe_bcnt)
> >   {
> >       struct ethhdr   *eth =3D (struct ethhdr *)(skb->data);
> >       struct tcphdr   *tcp;
> >       int network_depth =3D 0;
> > +     unsigned int hdrlen;
> >       __wsum check;
> >       __be16 proto;
> >       u16 tot_len;
> > @@ -1169,11 +1171,14 @@ static void mlx5e_lro_update_hdr(struct sk_buff=
 *skb, struct mlx5_cqe64 *cqe,
> >
> >       tot_len =3D cqe_bcnt - network_depth;
> >       ip_p =3D skb->data + network_depth;
> > +     hdrlen =3D network_depth;
> >
> >       if (proto =3D=3D htons(ETH_P_IP)) {
> >               struct iphdr *ipv4 =3D ip_p;
> >
> >               tcp =3D ip_p + sizeof(struct iphdr);
> > +             hdrlen +=3D sizeof(struct iphdr);
> > +
> >               skb_shinfo(skb)->gso_type =3D SKB_GSO_TCPV4;
> >
> >               ipv4->ttl               =3D cqe->lro.min_ttl;
> > @@ -1193,6 +1198,8 @@ static void mlx5e_lro_update_hdr(struct sk_buff *=
skb, struct mlx5_cqe64 *cqe,
> >               struct ipv6hdr *ipv6 =3D ip_p;
> >
> >               tcp =3D ip_p + sizeof(struct ipv6hdr);
> > +             hdrlen +=3D sizeof(struct ipv6hdr);
> > +
> >               skb_shinfo(skb)->gso_type =3D SKB_GSO_TCPV6;
> >
> >               ipv6->hop_limit         =3D cqe->lro.min_ttl;
> > @@ -1205,6 +1212,10 @@ static void mlx5e_lro_update_hdr(struct sk_buff =
*skb, struct mlx5_cqe64 *cqe,
> >               tcp->check =3D tcp_v6_check(payload_len, &ipv6->saddr,
> >                                         &ipv6->daddr, check);
> >       }
> > +
> > +     hdrlen +=3D tcp->doff * 4;
> > +
>
>
> Thanks for your patch!
>
> Calculations seem correct.
> Wouldn't it be simpler to just return the below?
>
> (void *)tcp + tcp->doff * 4 - skb->data

Absolutely! I can do that!


Christoph

>
> > +     return hdrlen;
> >   }
> >
> >   static void *mlx5e_shampo_get_packet_hd(struct mlx5e_rq *rq, u16 head=
er_index)
> > @@ -1561,8 +1572,9 @@ static inline void mlx5e_build_rx_skb(struct mlx5=
_cqe64 *cqe,
> >               mlx5e_macsec_offload_handle_rx_skb(netdev, skb, cqe);
> >
> >       if (lro_num_seg > 1) {
> > -             mlx5e_lro_update_hdr(skb, cqe, cqe_bcnt);
> > -             skb_shinfo(skb)->gso_size =3D DIV_ROUND_UP(cqe_bcnt, lro_=
num_seg);
> > +             unsigned int hdrlen =3D mlx5e_lro_update_hdr(skb, cqe, cq=
e_bcnt);
> > +
> > +             skb_shinfo(skb)->gso_size =3D DIV_ROUND_UP(cqe_bcnt - hdr=
len, lro_num_seg);
> >               /* Subtract one since we already counted this as one
> >                * "regular" packet in mlx5e_complete_rx_cqe()
> >                */
>
>

