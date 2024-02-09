Return-Path: <linux-rdma+bounces-991-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF90F84FCC4
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Feb 2024 20:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14059B25582
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Feb 2024 19:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448C082892;
	Fri,  9 Feb 2024 19:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="B+O98h7b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C94253398
	for <linux-rdma@vger.kernel.org>; Fri,  9 Feb 2024 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707506650; cv=none; b=ht84Kgw3qnM5zAUgkmhXOcVlnKLvu3UfoIYeeAWFZHLo7engU6bnY1pLoH+E3i7boyvmBlfBZNoEOMMyfxM4w8JC++rLGvGidUe/1qbS8fAEp7HZPtZWUa/fc1SrXQxot5meJfeTqSj2xQeLw+qee8m+hccWP93Vp7U9YtvHofU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707506650; c=relaxed/simple;
	bh=XDWJ7zlGSbHyR3vWBwX7TVZzvb4Qt2UymPvTujseJRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZZIm+1qGBWiYrYFWZdzR0gw2MnMdkIBvBDZ9kPZ8fxryfyhmQBZBRojcC+PorjPISVN+Y1n7Iz9g50BzYyfEMDzxG3FA3amlycy6yT2EfSiSpX8i+Zh1mJiW7UZ71g27W+Bbi8tiuPX4mn4Txeg04oAoFwPcFFjAbPS7wpMdmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=B+O98h7b; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d95d67ff45so10607955ad.2
        for <linux-rdma@vger.kernel.org>; Fri, 09 Feb 2024 11:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707506648; x=1708111448; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oa3yaecqWcDS0nQPRzTvq9Xt2QupxAe2r3Evwal7rsI=;
        b=B+O98h7bDEJ4b2kasuJkniRtZO2+c4dYW3pNstqlVbYovIxtwIXkwp2zd2Dv62fkcT
         iY2a79Czd/AYOr5VCcoDE0dlQCcxSmlapkR/PP+n6D/CjxZGpYaNPnN/fB9tGCHUwjeY
         YkYwp7X4PuexYv3fK0j6H5DJhIQdr0SRjKQ+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707506648; x=1708111448;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oa3yaecqWcDS0nQPRzTvq9Xt2QupxAe2r3Evwal7rsI=;
        b=gTjBncmPo9B92HDSOcG6e/W80LCp2luC/vLv0SBobgvBs3Pu6a+XP7D/KXvEtG+NK5
         g9rLoUxFlWZLRQCFd5GQ0ziw3DPM3xdZrC0pVRlAA4InVIiJr/C+juXXqnq4Cr/SCQ8I
         NcK/z2B2YtSKUxNl2SwaZbN/akx5GXJ116f8XqBwpY4fJCusV1jmGb7KN/bg4F9HBdG9
         vKPDbIk9+fxxsdwtyV1Xs4BovEvjtvl9VgD1ezgpZ5cjywW4W3TPOIwV+bpnMhZ5Np4l
         Y9QaENpyK1LKKNR/imL9V5mR4llAuK0Qp75vbLCkJg0koRAH8Z0OIpjmvS+I6kmEG+R+
         w1sA==
X-Gm-Message-State: AOJu0YzzfrI2cQei3lqKtP2Q/yK57Jby029ttpCjKl/44YFQJo/pQzzA
	4kRLEGYMiUwd/7hfWk7gzL+yEelGwiYQDFYbhHkU9F5quwomI+Neuzx05JFxg9c=
X-Google-Smtp-Source: AGHT+IETt+laqxIWkGhnn4IEgN+m2eiILtgAK4qzJMSC+2t9kM3vEuKv8536iYjqTDQWwx6U1Sl+DA==
X-Received: by 2002:a17:902:f7c5:b0:1d9:7782:316f with SMTP id h5-20020a170902f7c500b001d97782316fmr147752plw.39.1707506647689;
        Fri, 09 Feb 2024 11:24:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjuW/OVHa/n5JJWQov17ahY/P9qQoxJ4ONVBEmIOg42rg+awmO1B+ew5n75XpNz0BslTm7PBARSFvWqsC+MLFJ3h5Ac0od2+/+5szXbvM0ow8FcWUeWIxa1AtkrHidSyrunYyJoQ66j7Lh9BroOrgEi8YcCUhd1yxmGL9BtxatIcB1Ht4vr2XL0+hqzw33mAP3yAVTyZc36Xk6pzr7OrfVB0ZCCxXGRqEbzGielbIgUFuRfZCJyCb7C7c3joL+a+t+bpToY/wlGvYuT5LGXtMYmVPuWWtxPrvRjvOmZ9x71+St5FLofPTxiMoS4Rri/2uGp+Daf7obh7ZJ3IsTHXG1TrgjufbrCEq/ISYS0QrCptV02HQb+oUAb+J+VrxK2SinGNBwAdS4C+TQw7c2ylOn5lzC+ToeMoR58O1UmuamVljbwn4TcnjxOVw=
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f2c900b001d921bcc621sm1827205plc.243.2024.02.09.11.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2024 11:24:07 -0800 (PST)
Date: Fri, 9 Feb 2024 11:24:04 -0800
From: Joe Damato <jdamato@fastly.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, tariqt@nvidia.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v3] net/mlx5e: link NAPI instances to queues and
 IRQs
Message-ID: <20240209192404.GA1430@fastly.com>
References: <20240208030702.27296-1-jdamato@fastly.com>
 <8c083e6d-5fcd-4557-88dd-0f95acdbc747@gmail.com>
 <871q9mz1a0.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q9mz1a0.fsf@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Thu, Feb 08, 2024 at 08:43:57PM -0800, Rahul Rameshbabu wrote:
> On Thu, 08 Feb, 2024 21:13:25 +0200 Tariq Toukan <ttoukan.linux@gmail.com> wrote:
> > On 08/02/2024 5:07, Joe Damato wrote:
> >> Make mlx5 compatible with the newly added netlink queue GET APIs.
> >> Signed-off-by: Joe Damato <jdamato@fastly.com>
> >> ---
> 
> Just came back from testing this code. Let me make one cosmetic point
> here. I noticed this patch has a line that is past 90 characters. Would
> be nice to get it wrapped in the next version. We use 90 instead of 80
> characters for the line wrap in the mlx5 driver because of firmware
> command interface related code would lead to very hard to read lines if
> wrapped at 80.
> 
>   https://patchwork.kernel.org/project/netdevbpf/patch/20240208030702.27296-1-jdamato@fastly.com/

OK, I had wrapped them in the next version I was going to send to 80, but
I'll adjust that to 90.

> >> v2 -> v3:
> >>    - Fix commit message subject
> >>    - call netif_queue_set_napi in mlx5e_ptp_activate_channel and
> >>      mlx5e_ptp_deactivate_channel to enable/disable NETDEV_QUEUE_TYPE_RX for
> >>      the PTP channel.
> >>    - Modify mlx5e_activate_txqsq and mlx5e_deactivate_txqsq to set
> >>      NETDEV_QUEUE_TYPE_TX which should take care of all TX queues including
> >>      QoS/HTB and PTP.
> >>    - Rearrange mlx5e_activate_channel and mlx5e_deactivate_channel for
> >>      better ordering when setting and unsetting NETDEV_QUEUE_TYPE_RX NAPI
> >>      structs
> >> v1 -> v2:
> >>    - Move netlink NULL code to mlx5e_deactivate_channel
> >>    - Move netif_napi_set_irq to mlx5e_open_channel and avoid storing the
> >>      irq, after netif_napi_add which itself sets the IRQ to -1
> >>   drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c  | 3 +++
> >>   drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 7 +++++++
> >>   2 files changed, 10 insertions(+)
> >> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
> >> b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
> >> index 078f56a3cbb2..fbbc287d924d 100644
> >> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
> >> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
> >> @@ -927,6 +927,8 @@ void mlx5e_ptp_activate_channel(struct mlx5e_ptp *c)
> >>   	int tc;
> >>     	napi_enable(&c->napi);
> >> +	netif_queue_set_napi(c->netdev, c->rq.ix, NETDEV_QUEUE_TYPE_RX,
> >> +			     &c->napi);
> 
> This should only be set if MLX5E_PTP_STATE_RX is set. Otherwise, the rq
> is not initialized. The following callgraph should help illustrate this.
> 
>    mlx5e_ptp_open
>     |_ mlx5e_ptp_open_queues
>        |_ mlx5e_ptp_open_rq
>           |_ mlx5e_open_rq

I had made the change that Tariq had suggested in the previous message of
using sq->netdev and sq->cq.napi, but I can also tie that into
MLX5E_PTP_STATE_RX.

I'll add this change as well, test locally again and resend shortly.

> >>     	if (test_bit(MLX5E_PTP_STATE_TX, c->state)) {
> >>   		for (tc = 0; tc < c->num_tc; tc++)
> >> @@ -951,6 +953,7 @@ void mlx5e_ptp_deactivate_channel(struct mlx5e_ptp *c)
> >>   			mlx5e_deactivate_txqsq(&c->ptpsq[tc].txqsq);
> >>   	}
> >>   +	netif_queue_set_napi(c->netdev, c->rq.ix, NETDEV_QUEUE_TYPE_RX, NULL);
> 
> I believe it would be best to tie this to whether MLX5E_PTP_STATE_RX is
> set or not.
> 
> >>   	napi_disable(&c->napi);
> >>   }
> >>   diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >> b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >> index c8e8f512803e..2f1792854dd5 100644
> >> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> >> @@ -1806,6 +1806,7 @@ void mlx5e_activate_txqsq(struct mlx5e_txqsq *sq)
> >>   	set_bit(MLX5E_SQ_STATE_ENABLED, &sq->state);
> >>   	netdev_tx_reset_queue(sq->txq);
> >>   	netif_tx_start_queue(sq->txq);
> >> +	netif_queue_set_napi(sq->channel->netdev, sq->txq_ix, NETDEV_QUEUE_TYPE_TX, &sq->channel->napi);
> >
> > Might be called with channel==NULL.
> > For example for PTP.
> >
> > Prefer sq->netdev and sq->cq.napi.
> >
> >>   }
> >>     void mlx5e_tx_disable_queue(struct netdev_queue *txq)
> >> @@ -1819,6 +1820,7 @@ void mlx5e_deactivate_txqsq(struct mlx5e_txqsq *sq)
> >>   {
> >>   	struct mlx5_wq_cyc *wq = &sq->wq;
> >>   +	netif_queue_set_napi(sq->channel->netdev, sq->txq_ix,
> >> NETDEV_QUEUE_TYPE_TX, NULL);
> >
> > Same here.
> >
> >>   	clear_bit(MLX5E_SQ_STATE_ENABLED, &sq->state);
> >>   	synchronize_net(); /* Sync with NAPI to prevent netif_tx_wake_queue. */
> >>   @@ -2560,6 +2562,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv,
> >> int ix,
> >>   	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
> >>     	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
> >> +	netif_napi_set_irq(&c->napi, irq);
> >>     	err = mlx5e_open_queues(c, params, cparam);
> >>   	if (unlikely(err))
> >> @@ -2602,12 +2605,16 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
> >>   		mlx5e_activate_xsk(c);
> >>   	else
> >>   		mlx5e_activate_rq(&c->rq);
> >> +
> >> +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, &c->napi);
> >>   }
> >>     static void mlx5e_deactivate_channel(struct mlx5e_channel *c)
> >>   {
> >>   	int tc;
> >>   +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, NULL);
> >> +
> >>   	if (test_bit(MLX5E_CHANNEL_STATE_XSK, c->state))
> >>   		mlx5e_deactivate_xsk(c);
> >>   	else
> 
> --
> Thanks,
> 
> Rahul Rameshbabu

