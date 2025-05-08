Return-Path: <linux-rdma+bounces-10171-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46384AB0053
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 18:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168CA9E3E3E
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 16:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A5A281526;
	Thu,  8 May 2025 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nbx+ofP6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC092280A5E;
	Thu,  8 May 2025 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721328; cv=none; b=OKL9cHv9sg1bpsgXp3Ms24bYcTbBEogfu7GIw0Ncio+QvMa9qaO7HPghbNLiGfD3kwCKdX5PZ4xh2EnNx3XEGuw2M4J7T6PT+X00rEo5kCrw6rfyG/YDTwLPCEjIumcLwulFR4deR5IRXk4LMsn3KWiZJPv9oZdL+ejfhDNp7mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721328; c=relaxed/simple;
	bh=PQxdxrBAS+BBqq54qHh1QboGFz5O4D3o1Yv6WeUM98o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKChRLbaiWKzsZNjFkzPGAFTcC9jNIWaTa3CQ6PIgdR+136L5Gy2PUUCev7A3VZkn0KgQzZXHsxQkZgwWRQ5p6ThYfNHyAaHebZ7M09UGIMeCiKyx+dFqDHgdQWFJI4lqe8NnpWxOxuNPbSfMg0DWBQ8Bbc4Ryn+C3US48MSxX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nbx+ofP6; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7398d65476eso1092427b3a.1;
        Thu, 08 May 2025 09:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746721325; x=1747326125; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a2Gx3yX5c/pf7u9kHRJ3SRF2a7k4C6XArHo/Wa84CEQ=;
        b=Nbx+ofP6gbHF0y0rcE/pCTU4acmPrCw0s4Nc7HspmXDStvBpaTq+ouCU2mV72ZSOAd
         wdokcCdg6B2gDOdv7fv8UZh6R2LwHm9T1ryZ3NrT7a0Lhqoky7Ro0PlK2OJbDpP4juF4
         uowTDH4ROfQ8AQDASHcYR4fERtNW2Utk4NyLhsCncFj5ZfkNNbtTirNHsBIQO/LUhnM2
         xP8sh6DQvrD+LczLj6pFkd8a2Bb0AVUbmHmIrgL2BE6Cz7z6ySKBE4tnEA7tTkdgUhgG
         FfX/kve4RnSJ7NqLUkrG2qBA35jsnsCUKW8zOTaaRg7Vp104+5nTdAMpXf2ZpiFuioCA
         uXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746721325; x=1747326125;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2Gx3yX5c/pf7u9kHRJ3SRF2a7k4C6XArHo/Wa84CEQ=;
        b=BACcwT54DgvB9gjsVYShdTazIR56663tyY0aKAB3tZzbBOQ80dmlJqMVfaXXnVO6D1
         bqKCgbjKdckeEWHc4zex0d/cs9b1JSRqH87vFetZHwlx4TZU/1C0Y/h/uWvmudXryPq+
         hEJZ71lq/zs+vBCcN7xAucY5GyhGsfeTgmDOLtw/VSFz0hq8jg2nSJeZt4HlQkwh+N8a
         mW0aPm3DOJ7KdDSikCr73Gw9UYUeMaxdJBnbVr51c5P+IQsdIoBI9nVAeyJRX87lhAUZ
         6YKJH9VTJ9N2nKkNa8SDN8178s52W9KBPNAPxlK3WfqRUac6CoJH48WsA+hBhFvQN+tT
         EyQA==
X-Forwarded-Encrypted: i=1; AJvYcCVGiPVavNqzC+hBhCDP6QW0qafB4LPDDdCdDD3IQrz/VuLPwW5s3PwC+aZCIEyG8FRbfoRS3ZLIn7alZtY=@vger.kernel.org, AJvYcCX1TxnKPUkczPFcgKsUqUmXI9bY/L49yMBwxUODGX9wKs4LL0QBd2bhnPlHk9BVFmmvdfYqvBzg@vger.kernel.org, AJvYcCXgqtiq+ggPH8G/p6E9JBGUSprHJ/Y7afoRYx37KRqBK66WBFsmOoNE+WqFVPv51av3m6mZuBKeuKggLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7TQTbOJ/ym9xB+Cc5ngBJh/uiKuqJ6Zn7M3HRgd5nKAGNM2cN
	TWQQMy5ydH0RDFfWQ+FPnr0BlOvU6wNw2A76/BQhBiSHpqXxlQY=
X-Gm-Gg: ASbGnctqYPDnD/8BzwcUL9AwG3r2UvunGd0iNta8jp04FZh1V+tsH1ptUaCw2pbBVse
	/YzmqYVMXrg9YXereuWTcOEo33KT60gy9KngOrWKQTHzTse5pyCgqgV9+z4/lhR68ZMC5E2gDhc
	KZoO6zPx8ps/ZvZ0KAggml7jvYdZ+Q7zyBzagqGRxLvESNP2oXe9HIACVNRCBh7zyKOmhes1PkM
	hqeonROgbKS+BlPkpAk2ccamN+0M3s500hygB5I2tHcLkJlVANEneXELhhka1Lx2uRU/i2knXYg
	xMZsfdpG018rHfm/naL9CiAnlYhocND7LGvpWJKXY8QmmJnuQMZvPT/KiAn63wXjzmdlVmcI4g5
	CMQ==
X-Google-Smtp-Source: AGHT+IEwiOpDE9ISawmRTVyFChZiQ1HpPzeohQiapfqaohheesT+OSOTvCWMlz0rdgC/+nhL6U39PQ==
X-Received: by 2002:a05:6a00:2c86:b0:73d:f9d2:9c64 with SMTP id d2e1a72fcca58-740a947b507mr6254846b3a.10.1746721324988;
        Thu, 08 May 2025 09:22:04 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74237a8f4f2sm181409b3a.174.2025.05.08.09.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 09:22:04 -0700 (PDT)
Date: Thu, 8 May 2025 09:22:03 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, saeedm@nvidia.com, tariqt@nvidia.com,
	andrew+netdev@lunn.ch, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, leon@kernel.org,
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next] net/mlx5: support software TX timestamp
Message-ID: <aBzaK8I0hA31ba_4@mini-arch>
References: <20250506215508.3611977-1-stfomichev@gmail.com>
 <1a1ab6eb-9bfc-4298-ba1e-a6f4229ce091@gmail.com>
 <CAL+tcoDu0NdZQ+QmqL9mF8VNj+4cPLgmy1maAucAc7JkKOjm6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDu0NdZQ+QmqL9mF8VNj+4cPLgmy1maAucAc7JkKOjm6A@mail.gmail.com>

On 05/08, Jason Xing wrote:
> Hi Tariq,
> 
> On Thu, May 8, 2025 at 2:30 PM Tariq Toukan <ttoukan.linux@gmail.com> wrote:
> >
> >
> >
> > On 07/05/2025 0:55, Stanislav Fomichev wrote:
> > > Having a software timestamp (along with existing hardware one) is
> > > useful to trace how the packets flow through the stack.
> > > mlx5e_tx_skb_update_hwts_flags is called from tx paths
> > > to setup HW timestamp; extend it to add software one as well.
> > >
> > > Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> > > ---
> > >   drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 1 +
> > >   drivers/net/ethernet/mellanox/mlx5/core/en_tx.c      | 1 +
> > >   2 files changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> > > index fdf9e9bb99ac..e399d7a3d6cb 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> > > @@ -1689,6 +1689,7 @@ int mlx5e_ethtool_get_ts_info(struct mlx5e_priv *priv,
> > >               return 0;
> > >
> > >       info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
> > > +                             SOF_TIMESTAMPING_TX_SOFTWARE |
> > >                               SOF_TIMESTAMPING_RX_HARDWARE |
> > >                               SOF_TIMESTAMPING_RAW_HARDWARE;
> > >
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> > > index 4fd853d19e31..f6dd26ad29e5 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> > > @@ -341,6 +341,7 @@ static void mlx5e_tx_skb_update_hwts_flags(struct sk_buff *skb)
> > >   {
> > >       if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
> > >               skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
> > > +     skb_tx_timestamp(skb);
> >
> > Doesn't this interfere with skb_tstamp_tx call in the completion flow
> > (mlx5e_consume_skb)?
> 
> skb_tstamp_tx() only takes care of hardware timestamp in this case.
> 
> >
> > What happens if both flags (SKBTX_SW_TSTAMP / SKBTX_HW_TSTAMP) are set
> > Is it possible?
> 
> If only these two are set, only hardware timestamp will be passed to
> the userspace because of the SOF_TIMESTAMPING_OPT_TX_SWHW limit in
> __skb_tstamp_tx().
> 
> If users expect to see both timestamps, then
> SOF_TIMESTAMPING_OPT_TX_SWHW has to be set.

Right, skb_tx_timestamp does nothing and bails out if it detects
SKBTX_IN_PROGRESS. And skb_tstamp_tx in mlx5e_consume_skb handles
only (and will trigger only for) HW tstamp case.

