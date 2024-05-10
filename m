Return-Path: <linux-rdma+bounces-2391-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 915DC8C1D6D
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 06:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F6A2846E0
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 04:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7E214AD24;
	Fri, 10 May 2024 04:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="D5JlEHsH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56CC149DE0
	for <linux-rdma@vger.kernel.org>; Fri, 10 May 2024 04:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715315237; cv=none; b=uv4YT1ga/oX55sDY4CbZdnmIXZO/Sy6JpB/jHtOr3FwwLrIwZrdoZ6lzgsB2CAYachFMtqgy1wUF2bVK/QtLUNDBu00dyRl4aBwms2Q1xucgBPBmpbzvydN80T3vu+XRM6ipOmt6XR4l4DLETXq0yax+iMUMvTchTj8Vl5H/zJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715315237; c=relaxed/simple;
	bh=14nSWpNeh0d7rXYDykeBcTJq2Hy8sObAceg8DfUEvNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TA+A+qgnBqAUQtozrC4Vk334Yt6lDqCnm5Mqk/SWtw4BtM/68eOqiRsGrS6tX0gJ+U123Br2tfmtHldddzFNLk4hlyT9mM4WqX5WtjFkBwSWK50Axil7uBqMlRKT4W0Bcqe7vgJ2K7/y7YQleGjsyyFybZ1WcV0xhtN3mXY6k2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=D5JlEHsH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ed41eb3382so11712475ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 09 May 2024 21:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715315235; x=1715920035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JO706E9CS5Et8zewEmeRZI9gpEtF+EgDmsWANk00whE=;
        b=D5JlEHsH8qYYy1Wi//0FTaTRc5BvOeijmbHWET5z0nV9I/uqls4/JnThzl+zXDDJef
         RBDyeCcJBkvHuww+NPi3tntLec/J2wnoG97Degzol7LiCd7D9C9sBXF0uAWbYV7K5b9F
         5L5PFdoJPHhMJSylqVo4JXVv2NeL+T6rkgP5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715315235; x=1715920035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JO706E9CS5Et8zewEmeRZI9gpEtF+EgDmsWANk00whE=;
        b=l0SWK4ECgLCx1YqUZ80xENmPb/yycjiCZC46WYX8/QGRjqkGBgUJf66SvTpux5GhaT
         A3GMjFn5Gb9fVO2XYY6N6F8qAKtKqdbb8nzcaxtUcpGw9H+ThK4qevBpeNVyo3C9al52
         5k3bRBLowtuRyfKTsuUNld/gyWSrypl1B161Z1SLwRrjBnX4N7sbLhe0A2JqDb7ExBuL
         qoCIv+K3OFqt51hyiDrWZqWvbJfd0GWntEhgezIMfLPpXekawMhk2DpZmfIMOirTWelH
         J30qcaH9J0aUb+ZcfKjZ+CKj7j7wFF1yYAHv1f+ha+SfdlBXmc0oGK6WFk3wEIAzVG5+
         jZfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfcnK7NIZJcKeocq4D96FBaCUrErCBr0i+pAG96dXxHQQpQPXJNFcwUYwBHCCfwV4VcNrm8n1d3JrYr3SQSo6MQx6Jx1m8n8AZ1g==
X-Gm-Message-State: AOJu0YyrUCvvxrn2LOG7LQGlsbYeo4Uq6u5N1z+RmiqaFxrhroYJZXaC
	MpoyBFMYDPlZ6QVl+2Bvcpr6idoBeYQzGzwgQGhyS2fEJW2mYCqg68cuL5WyXDM=
X-Google-Smtp-Source: AGHT+IGpQAmfRjfA2BEioKWQ7Pne3T/JJXafarTVBkxYhZOG8AnFDxWJ9uvzwShO4ilaXkKzhcMhJA==
X-Received: by 2002:a17:902:e883:b0:1eb:d79a:c111 with SMTP id d9443c01a7336-1ef43c095b1mr22932935ad.4.1715315235174;
        Thu, 09 May 2024 21:27:15 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad6176sm22571335ad.76.2024.05.09.21.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 21:27:14 -0700 (PDT)
Date: Thu, 9 May 2024 21:27:11 -0700
From: Joe Damato <jdamato@fastly.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	saeedm@nvidia.com, gal@nvidia.com, nalramli@fastly.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next 0/1] mlx5: Add netdev-genl queue stats
Message-ID: <Zj2iHwEO4NLvCT06@LQ3V64L9R2>
References: <20240503173429.10402325@kernel.org>
 <ZjkbpLRyZ9h0U01_@LQ3V64L9R2>
 <8678e62c-f33b-469c-ac6c-68a060273754@gmail.com>
 <ZjwJmKa6orPm9NHF@LQ3V64L9R2>
 <20240508175638.7b391b7b@kernel.org>
 <ZjwtoH1K1o0F5k+N@ubuntu>
 <20240508190839.16ec4003@kernel.org>
 <ZjxtejIZmJCwLgKC@ubuntu>
 <32495a72-4d41-4b72-84e7-0d86badfd316@gmail.com>
 <Zj1qxgElgHhtxj4h@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj1qxgElgHhtxj4h@LQ3V64L9R2>

On Thu, May 09, 2024 at 05:31:06PM -0700, Joe Damato wrote:
> On Thu, May 09, 2024 at 01:16:15PM +0300, Tariq Toukan wrote:
> > 
> > 
> > On 09/05/2024 9:30, Joe Damato wrote:
> > > On Wed, May 08, 2024 at 07:08:39PM -0700, Jakub Kicinski wrote:
> > > > On Thu, 9 May 2024 01:57:52 +0000 Joe Damato wrote:
> > > > > If I'm following that right and understanding mlx5 (two things I am
> > > > > unlikely to do simultaneously), that sounds to me like:
> > > > > 
> > > > > - mlx5e_get_queue_stats_rx and mlx5e_get_queue_stats_tx check if i <
> > > > >    priv->channels.params.num_channels (instead of priv->stats_nch),
> > > > 
> > > > Yes, tho, not sure whether the "if i < ...num_channels" is even
> > > > necessary, as core already checks against real_num_rx_queues.
> > > > 
> > > > >    and when
> > > > >    summing mlx5e_sq_stats in the latter function, it's up to
> > > > >    priv->channels.params.mqprio.num_tc instead of priv->max_opened_tc.
> > > > > 
> > > > > - mlx5e_get_base_stats accumulates and outputs stats for everything from
> > > > >    priv->channels.params.num_channels to priv->stats_nch, and
> > > > 
> > > > I'm not sure num_channels gets set to 0 when device is down so possibly
> > > > from "0 if down else ...num_channels" to stats_nch.
> > > 
> > > Yea, you were right:
> > > 
> > >    if (priv->channels.num == 0)
> > >            i = 0;
> > >    else
> > >            i = priv->channels.params.num_channels;
> > >    for (; i < priv->stats_nch; i++) {
> > > 
> > > Seems to be working now when I adjust the queue count and the test is
> > > passing as I adjust the queue count up or down. Cool.
> > > 
> > 
> > I agree that get_base should include all inactive queues stats.
> > But it's not straight forward to implement.
> > 
> > A few guiding points:
> > 
> > Use mlx5e_get_dcb_num_tc(params) for current num_tc.
> > 
> > txq_ix (within the real_num_tx_queues) is calculated by c->ix + tc *
> > params->num_channels.
> > 
> > The txqsq stats struct is chosen by channel_stats[c->ix]->sq[tc].
> > 
> > It means, in the base stats you should include SQ stats for:
> > 1. all SQs of non-active channels, i.e. ch in [params.num_channels,
> > priv->stats_nch), tc in [0, priv->max_opened_tc).
> > 2. all SQs of non-active TCs in active channels [0, params.num_channels), tc
> > in [mlx5e_get_dcb_num_tc(params), priv->max_opened_tc).
> > 
> > Now I actually see that the patch has issues in mlx5e_get_queue_stats_tx.
> > You should not loop over all TCs of channel index i.
> > You must do a reverse mapping from "i" to the pair/tuple [ch_ix, tc], and
> > then access a single TXQ stats by priv->channel_stats[ch_ix].sq[tc].
> 
> It looks like txq2sq probably will help with this?
> 
> Something like:
> 
> for (j = 0; j < mlx5e_get_dcb_num_tc(); j++) {
>   sq = priv->txq2sq[j];
>   if (sq->ch_ix == i) {
>     /* this sq->stats is what I need */
>   }
> }
> 
> Is that right?

This was incorrect, but I think I got it in the v2 I just sent out. When
you have the time, please take a look at that version.

Thanks for the guidance, it was very helpful.
 
> Not sure if I'm missing something obvious here, sorry, I've been puzzling
> over the mlx5 source for a bit.
> 
> BTW: kind of related but in mlx5e_alloc_txqsq the int tc param is unused (I
> think). It might be helpful to struct mlx5e_txqsq to have a tc field and
> then in mlx5e_alloc_txqsq:
> 
>   sq->tc = tc;
> 
> Not sure if that'd be helpful in general, but I could send that as a
> separate patch.

