Return-Path: <linux-rdma+bounces-920-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164A684ABBC
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 02:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C127E286476
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 01:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59AD1109;
	Tue,  6 Feb 2024 01:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="lu1JG80d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1642D10F4
	for <linux-rdma@vger.kernel.org>; Tue,  6 Feb 2024 01:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707183717; cv=none; b=OZezGzzbgk6avw+h10retkz9ne5V593MTuhfnzQBC2aBUWO4bVm7BBLlHDJAcwjdNadt3nxBtCynkmJtA4WJiVRitf2reHQps/sU+nA2d/JJcaJRdaiAUdH7nojYPeOwDiznQ/GBt98E0ET4W/MAjGLpTBzHB3oeBwIOgHEDth0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707183717; c=relaxed/simple;
	bh=OCIrzq0JosuQrPNudbNJdN5vWHnpQoFoo/C/g8l6Zx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfBFEUEDTB8JKZyLmQSsf3X/32UIWCVlIJ3nvMbssk9GArip71lQfXfLEsoZmQzzB+EITfmAey9dfGSs7JaTQUKikIhA+1W3qqJRcLuIh3nPaooZuKb+XzDtiAYvrBTwVVl8POc4/bAv6wLGXYnTvGdd4UdRI5XfHoTwrM+oeN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=lu1JG80d; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e05456a010so460736b3a.0
        for <linux-rdma@vger.kernel.org>; Mon, 05 Feb 2024 17:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707183715; x=1707788515; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0L5oOCeA98BmPGoU8xkYWque8uPmBFxlIFmVb42drKc=;
        b=lu1JG80dNPXfhIgLZtHMgnne5BW8QeMa5wK7CF/brSDGuwK7P8uWRFkwIeMDu0/F/e
         q3nk5B6CJKgbwHPOJ8UIlt+aP/K8sA9hUYe7ue6t+Lty8Oyj6wcaYqMtFDNEnSp9pCye
         A13wyGZb8O/WqVMVqisik9/OAHx51AVTUhCEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707183715; x=1707788515;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0L5oOCeA98BmPGoU8xkYWque8uPmBFxlIFmVb42drKc=;
        b=Zgpnn2ESkT+S8XhFBMp4alKBZhsUlh/eqiZoBFwogq7fFxqUt99fWCAXKPe/NR8nE2
         FJnNUj9FXqkHjs0lbzARiB2OnoG9tcowXfmLq+KQrBmM8/kr8KBWD1rf9+d4ps1jK0mS
         I8gXHgW7DxQz0ebajbOQ0XSyRis71szZC9IiWsaL3cIYTlYwUpDRm1+w46lq+/CIROX1
         0XY8bcLNF+5g5Ag4nzMB2LkW8k0g4mTHlwlL4qUsod3lmCrniLcQObUcl3joH4v9xNcR
         8JZk2tRFs0XdVLRFc09TpMHXdjk7KUG2Wm+Kxl65SIVplBYxK4B48XwIOXoqdl5CJGwN
         oFag==
X-Gm-Message-State: AOJu0YzGYVL7YG1NcFrLHWVLkMMwdZdkodGlTYTbJ3VUpVupx5MVuYO6
	ddD6dkBBYJ9Yvm4sLlhNibCBj2lkPH/j9i6jvA/lJxLJX12moNgn7HAdU1FcgkA=
X-Google-Smtp-Source: AGHT+IH4ISpBbM7JPgWBeEUGLt7HxRqYm6s//y7E9Ct8TzAMtIQCISnlxxuChD8TGt+RsVtzcEAskw==
X-Received: by 2002:a05:6a00:80f3:b0:6d9:b5ba:7802 with SMTP id ei51-20020a056a0080f300b006d9b5ba7802mr1260779pfb.26.1707183715186;
        Mon, 05 Feb 2024 17:41:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVmxx5IWUwQU1Vf63nWszqSgs1m/ZFmJtT1LvQ+KtkD2NlcIlKsujB6bDxBuYzfFFsPsF+S4TO/dHhxmcHOULi5VfYmcRbCN1OiAiefAzGyRjOYZWUdJKlOckInBf6edotDq5gofnxDKxwBd/xfdS9rmZTyxD+xf3tWDmobFq1+uxKHWDOgx12W9C3VLhRZqj0T3mfhi7QqUmx3ZGk/bmX7ppRsDIj5V23RgfC3kyGs1Ji9anadtAU2/azRBi2uH/QD99/RSapWnKn8583MENBb6o/a683ZFUmNmSL0SHA19Mj7FWSeeoA=
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id y3-20020a62f243000000b006dde1781800sm563256pfl.94.2024.02.05.17.41.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 17:41:54 -0800 (PST)
Date: Mon, 5 Feb 2024 17:41:52 -0800
From: Joe Damato <jdamato@fastly.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next] eth: mlx5: link NAPI instances to queues and
 IRQs
Message-ID: <20240206014151.GA11233@fastly.com>
References: <20240206010311.149103-1-jdamato@fastly.com>
 <878r3ymlnk.fsf@nvidia.com>
 <20240206013246.GA11217@fastly.com>
 <874jemml1j.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jemml1j.fsf@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Mon, Feb 05, 2024 at 05:33:39PM -0800, Rahul Rameshbabu wrote:
> 
> On Mon, 05 Feb, 2024 17:32:47 -0800 Joe Damato <jdamato@fastly.com> wrote:
> > On Mon, Feb 05, 2024 at 05:09:09PM -0800, Rahul Rameshbabu wrote:
> >> On Tue, 06 Feb, 2024 01:03:11 +0000 Joe Damato <jdamato@fastly.com> wrote:
> >> > Make mlx5 compatible with the newly added netlink queue GET APIs.
> >> >
> >> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> >> > ---
> >> >  drivers/net/ethernet/mellanox/mlx5/core/en.h      | 1 +
> >> >  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 8 ++++++++
> >> >  2 files changed, 9 insertions(+)
> >> >
> >> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> >> > index 55c6ace0acd5..3f86ee1831a8 100644
> >> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> >> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> >> > @@ -768,6 +768,7 @@ struct mlx5e_channel {
> >> >  	u16                        qos_sqs_size;
> >> >  	u8                         num_tc;
> >> >  	u8                         lag_port;
> >> > +	unsigned int		   irq;
> >> >  
> >> >  	/* XDP_REDIRECT */
> >> >  	struct mlx5e_xdpsq         xdpsq;
> >> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >> > index c8e8f512803e..e1bfff1fb328 100644
> >> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >> > @@ -2473,6 +2473,9 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
> >> >  	mlx5e_close_tx_cqs(c);
> >> >  	mlx5e_close_cq(&c->icosq.cq);
> >> >  	mlx5e_close_cq(&c->async_icosq.cq);
> >> > +
> >> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, NULL);
> >> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, NULL);
> >> 
> >> This should be set to NULL *before* actually closing the rqs, sqs, and
> >> related cqs right? I would expect these two lines to be the first ones
> >> called in mlx5e_close_queues. Btw, I think this should be done in
> >> mlx5e_deactivate_channel where the NAPI is disabled.
> >> 
> >> >  }
> >> >  
> >> >  static u8 mlx5e_enumerate_lag_port(struct mlx5_core_dev *mdev, int ix)
> >> > @@ -2558,6 +2561,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
> >> >  	c->stats    = &priv->channel_stats[ix]->ch;
> >> >  	c->aff_mask = irq_get_effective_affinity_mask(irq);
> >> >  	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
> >> > +	c->irq		= irq;
> >> >  
> >> >  	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
> >> >  
> >> > @@ -2602,6 +2606,10 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
> >> >  		mlx5e_activate_xsk(c);
> >> >  	else
> >> >  		mlx5e_activate_rq(&c->rq);
> >> > +
> >> > +	netif_napi_set_irq(&c->napi, c->irq);
> 
> One small comment that I missed in my previous iteration. I think the
> above should be moved to mlx5e_open_channel right after netif_napi_add.
> This avoids needing to save the irq in struct mlx5e_channel.

I couldn't move it to mlx5e_open_channel because of how safe_switch_params
and the mechanics around that seem to work (at least as far as I could
tell).

mlx5 seems to create a new set of channels before closing the previous
channel. So, moving this logic to open_channels and close_channels means
you end up with a flow like this:

  - Create new channels (NAPI netlink API is used to set NAPIs)
  - Old channels are closed (NAPI netlink API sets NULL and overwrites the
    previous NAPI netlink calls)

Now, the associations are all NULL.

I think moving the calls to active / deactivate fixes that problem, but
requires that irq is stored, if I am understanding the driver correctly.

> >> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, &c->napi);
> >> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, &c->napi);
> >> 
> >> It's weird that netlink queue API is being configured in
> >> mlx5e_activate_channel and deconfigured in mlx5e_close_queues. This
> >> leads to a problem where the napi will be falsely referred to even when
> >> we deactivate the channels in mlx5e_switch_priv_channels and may not
> >> necessarily get to closing the channels due to an error.
> >> 
> >> Typically, we use the following clean up patterns.
> >> 
> >> mlx5e_activate_channel -> mlx5e_deactivate_channel
> >> mlx5e_open_queues -> mlx5e_close_queues
> >
> > OK, I'll move it to mlx5e_deactivate_channel before the NAPI is disabled.
> > That makes sense to me.
> 
> Appreciated. Thank you for the patch btw.

Sure, thanks for the review.

