Return-Path: <linux-rdma+bounces-10148-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1203AAF3F3
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 08:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29F41BA6AE3
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 06:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B49721ABAE;
	Thu,  8 May 2025 06:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dce/rYGn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DC2218EB7;
	Thu,  8 May 2025 06:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746686617; cv=none; b=CsrVi75SUinbMowDdqVgPO9CpVXmCDqYSM+XeQr4QRuOg9gYkRmigNBdrSQh3nI4wKu98YeLuKV1bw9vBTWmew8LzRqXQFm9V2yPx86Sh7C3/o0GX7coUw4HD4Nw3JlZDjsWFJeWGHmOFT2Xd/7hPwRPCMuMKGFr2stBc94jZ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746686617; c=relaxed/simple;
	bh=VOiFBwu3In9pxHxtV+dLuJyFtA9SIftcdcbbHIkMaJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEOUbCnzUETRoTDsuwgWBrDPfdSRzEN7qgF69I+ZU17wYAUlP9qfqlmbAh3TM55ahXi6FLNDXssxnClqeX5nuR7rQWdal7VnnLEpfYDsWcnCFenJ6J6hOD5ZFuGWyHa0ubC3sK42NBeOQXdK9nhUr3286sQyp/JwcKMn5PdvGDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dce/rYGn; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d9189e9a06so2573265ab.2;
        Wed, 07 May 2025 23:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746686615; x=1747291415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3NgBy2Glw3r5Krb07BW094/NhnjrtYkMGxP8CVEZBU=;
        b=Dce/rYGnDIErduGK5PtgWOCW06buUc5dqyv0C5kMe7KDtbFPhu9AxN906sjzgStgIk
         X5BEJP6CR5fgz/psKAnjPijfKJJppnd2R1M0/nzBuGI95+8QP8J83eokYEyAC/zqUR9T
         x1Kz1klxo4Kuv1pccEGKygfKd6T0tHomRUsigGSh/0rOKMHWQ0yxw7bpXa3qQZdU4M3I
         djm2zGVjszaG+cS3RqzP7Jdu6/vUW62eLwOUEmHavmyh+BLmGXPN3o6kAU/9fZvDx+Oe
         DpWkH4mSr5xybAoayKLf7rHWZaTs3GgaSMXGNjoHw8k55F1LcdwMF5LTTKa6dF9h39Ax
         LxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746686615; x=1747291415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3NgBy2Glw3r5Krb07BW094/NhnjrtYkMGxP8CVEZBU=;
        b=DH5rA1wXXi5uEdQa5O8pPgSh35Jqg3IkhO+mA/72vVDC2rPjpgnpZet1Ah2B7I78yU
         RiSz5fe9dnGoo/9n8uolhFcZDCPiAAFOv5J65aZ12908jMSovh6boUt5r7tPVWGBLhwU
         vxKt94vQ8IOUout/ECDkxMMY0Io0kNUzxLyRHC1lPazBMTJpHKQIH7JJv5nVGmb2Z7lg
         Wp2SYd1PUB5xG0E8RozIwQFzPpkvXVfr6v4XU+0d4D15qFaH88qgAkEmm0lgT8d9m/mL
         R6RZ8LdbAOrVforeDFcEVFagPIaiCWpyzj6nqyb2jZr5J/5PI31p9gtJHHnpsVL4WKGv
         3yCA==
X-Forwarded-Encrypted: i=1; AJvYcCVVsxFGM5g/9YOuEh1xo3T5xVGvhLc/7irJpspPzw9OdT05ZLeF8xoSFWPha7T7A97imx88KTC966Ub+Q==@vger.kernel.org, AJvYcCVVy4Yz5i/SmOl9lL2Q2kttUV+plwXCb2/IwDkTZOH/prdrRrhiV32KfXn60GDWEeVEjao47i8Q@vger.kernel.org, AJvYcCX/sf0uJ0JYFyIlHRbCulsPzczxI57IVlvgSbFT6fW7G4ao4QiQ9njFcu+874WnLjF37mGiKe99HlZivNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHgq9J6iXLPTRRQTShNXaCtIrF294q/h2+uO7XgL7NtMVUgeyg
	ltsmsrVutKDrpPAylEvQzdpZjiolWqz1F0azHV5h2owHk4WOTBA3d9KSKCe9g3jxXyicARXhP8l
	tCgNibjYGh52ze79yzC1GfMe9zzuOAFuKM8lANw==
X-Gm-Gg: ASbGnctlVxenXtiHSEqZSnRhBadgDjqnnZU57XNGrn2hjL0hPdP7WIMmy5Gz7AVocWp
	nRgRhGiq7/OOQbtr74Q0OalQlJbyffUGMCp7V91k+8rwwP5GrOosQb9Mav7nw4iBJfEcv6xtPxu
	1TNRrh8JdaxEVxf7TnqDHML8cwqFlRbaxd
X-Google-Smtp-Source: AGHT+IEUuuCJ4IEeumjHXmadYFmxNgvNysRXBlx8sEF9mqJfXXh934Acn2y6yQrb+Qusm3/D3QGaz37rqBlh8khcSqg=
X-Received: by 2002:a92:cdaf:0:b0:3d8:975:b825 with SMTP id
 e9e14a558f8ab-3da738d5b28mr73536975ab.5.1746686614824; Wed, 07 May 2025
 23:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506215508.3611977-1-stfomichev@gmail.com> <1a1ab6eb-9bfc-4298-ba1e-a6f4229ce091@gmail.com>
In-Reply-To: <1a1ab6eb-9bfc-4298-ba1e-a6f4229ce091@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 8 May 2025 14:42:57 +0800
X-Gm-Features: ATxdqUF6D1Lkc9OO63CcRdtKX4DlNE6Fe3aSZhrYyhQ98Suxq5Uk5wJd1b6V_pA
Message-ID: <CAL+tcoDu0NdZQ+QmqL9mF8VNj+4cPLgmy1maAucAc7JkKOjm6A@mail.gmail.com>
Subject: Re: [PATCH net-next] net/mlx5: support software TX timestamp
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, 
	tariqt@nvidia.com, andrew+netdev@lunn.ch, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, leon@kernel.org, 
	Carolina Jubran <cjubran@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tariq,

On Thu, May 8, 2025 at 2:30=E2=80=AFPM Tariq Toukan <ttoukan.linux@gmail.co=
m> wrote:
>
>
>
> On 07/05/2025 0:55, Stanislav Fomichev wrote:
> > Having a software timestamp (along with existing hardware one) is
> > useful to trace how the packets flow through the stack.
> > mlx5e_tx_skb_update_hwts_flags is called from tx paths
> > to setup HW timestamp; extend it to add software one as well.
> >
> > Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> > ---
> >   drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 1 +
> >   drivers/net/ethernet/mellanox/mlx5/core/en_tx.c      | 1 +
> >   2 files changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/dri=
vers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> > index fdf9e9bb99ac..e399d7a3d6cb 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> > @@ -1689,6 +1689,7 @@ int mlx5e_ethtool_get_ts_info(struct mlx5e_priv *=
priv,
> >               return 0;
> >
> >       info->so_timestamping =3D SOF_TIMESTAMPING_TX_HARDWARE |
> > +                             SOF_TIMESTAMPING_TX_SOFTWARE |
> >                               SOF_TIMESTAMPING_RX_HARDWARE |
> >                               SOF_TIMESTAMPING_RAW_HARDWARE;
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_tx.c
> > index 4fd853d19e31..f6dd26ad29e5 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> > @@ -341,6 +341,7 @@ static void mlx5e_tx_skb_update_hwts_flags(struct s=
k_buff *skb)
> >   {
> >       if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
> >               skb_shinfo(skb)->tx_flags |=3D SKBTX_IN_PROGRESS;
> > +     skb_tx_timestamp(skb);
>
> Doesn't this interfere with skb_tstamp_tx call in the completion flow
> (mlx5e_consume_skb)?

skb_tstamp_tx() only takes care of hardware timestamp in this case.

>
> What happens if both flags (SKBTX_SW_TSTAMP / SKBTX_HW_TSTAMP) are set
> Is it possible?

If only these two are set, only hardware timestamp will be passed to
the userspace because of the SOF_TIMESTAMPING_OPT_TX_SWHW limit in
__skb_tstamp_tx().

If users expect to see both timestamps, then
SOF_TIMESTAMPING_OPT_TX_SWHW has to be set.

Thanks,
Jason

>
> >   }
> >
> >   static void mlx5e_tx_check_stop(struct mlx5e_txqsq *sq)
>
>

