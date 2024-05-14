Return-Path: <linux-rdma+bounces-2486-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624F58C5BA4
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 21:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841351C21D0D
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 19:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80036181316;
	Tue, 14 May 2024 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="BNLtTOEP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F5A181300
	for <linux-rdma@vger.kernel.org>; Tue, 14 May 2024 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715714230; cv=none; b=Q4qdbgWr/YnP4w6HCGOJpiStXMAH6J8wBIR0VUU6NMVAQskhJrx1lCcAGLn2AUaUFxcsg5ru7TXrlRx+nsmQlcU6JaWfuzCEdZlEArc7ILYdAQb/6Gw9ejtjiLB071JBWV4PiprZiySA3ZXeiLVC1A3H4SfZpEhuXQvZyZIfJ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715714230; c=relaxed/simple;
	bh=MozuXVveDnrHeKmyD0B1EwTHbFJkgmgL95Uc2DUuy6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIj93+qnH9tAFr+m5SrC+gCE6bMXKcie9sxa5K2QsoOBHPNyupQyPhblIV8IhqQQVGn8N0fXjm09dA+Jr4+JcBg/S7gU95TV5Azzwy3CKUtPXr4Fysrwcsm35AAzypFafBzU8k5JIq54ujM37BgXZfSED5aY1VrAaY71Ju6NNOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=BNLtTOEP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f45f1179c3so5638844b3a.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2024 12:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715714228; x=1716319028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTDVDPIJPU/zB7yOz2CW356qdobpBCSC9vzkcw4b+Vw=;
        b=BNLtTOEPkBFb3jswJej8HldOR+IXLPeMUOi5lDaloCg8y0f7iLN0p0g+DxZjtzK+g4
         dxxGBOxu3wSfHXOV0ryfrfsLZ2Of5XU1AWthnZwoGfnb5y47aDzkEppG2DQ3OQOju+By
         0smB/gVweZBwh1FYe5P2R93rdO78FMDYyEEy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715714228; x=1716319028;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pTDVDPIJPU/zB7yOz2CW356qdobpBCSC9vzkcw4b+Vw=;
        b=GLF3Shb2TX9hhQBas87e6PUwsjo8HSsMNfSVAwPAsy1WBCtYquNViuaB8/Ri6KKbP6
         5TkT5diVWyvBp9pF8Rm1JuKHd+C4GabEADQU6Mh8Xq3Ql815cFkxYh7v2F2CLkGd0l3a
         922vjIRSWXMcrlnGQPGrRJiWg1R9+zAzFai9QBpP9Cgfsok+3oTD1gpWlQ58VA9vkVV/
         di5xaUSMKBT7X+4dzr1B0aC6tvzO+/84o4Hws1exL/cbaPguOB2KD6mVAyvFxS8I0fms
         nH43mGO6Lv0HkN7ToRzRXl5UaggPNc8fMeDkBhPJ8IQXZv6eAl4Ff7MiTye3um0XDtTm
         eW7A==
X-Forwarded-Encrypted: i=1; AJvYcCVQZ1q+kBJx9WL0digIfJ8aGC7RCMAUMTxENpz+GwKKsQfbfoVweibLWKjQG/WHE/nheN8uddI8M/p/ifvx5pFkMsrPvQ6k4B6OBw==
X-Gm-Message-State: AOJu0Yze118u8ZpYM7j3QTqW1zRlx/EfVCl1jftTBLvc7qyFeq+H3uIL
	pyNcs8WB66f7XAV+xPgXUBZ3Y16JTd+2qoEYY5nb0UHK4ylaoPl/vAkkht0wU+w=
X-Google-Smtp-Source: AGHT+IEapaWz2Z4pXiUsS5wH7EhPUg0W/WCcuEu0rXf7Oj25JwfpVNz2/12huNaGr0U6rNhR1SGJoQ==
X-Received: by 2002:a05:6a00:13a0:b0:6f3:34c0:13c9 with SMTP id d2e1a72fcca58-6f4e0384909mr15368460b3a.29.1715714227653;
        Tue, 14 May 2024 12:17:07 -0700 (PDT)
Received: from LQ3V64L9R2 ([12.133.136.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a664b2sm9483343b3a.42.2024.05.14.12.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 12:17:07 -0700 (PDT)
Date: Tue, 14 May 2024 12:17:04 -0700
From: Joe Damato <jdamato@fastly.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	zyjzyj2000@gmail.com, nalramli@fastly.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next v2 1/1] net/mlx5e: Add per queue netdev-genl
 stats
Message-ID: <ZkO4sHysmB20x46a@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Tariq Toukan <ttoukan.linux@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	zyjzyj2000@gmail.com, nalramli@fastly.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
References: <20240510041705.96453-1-jdamato@fastly.com>
 <20240510041705.96453-2-jdamato@fastly.com>
 <230701b9-c52a-4b59-9969-4cd5a5d697f4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <230701b9-c52a-4b59-9969-4cd5a5d697f4@gmail.com>

On Tue, May 14, 2024 at 09:44:37PM +0300, Tariq Toukan wrote:
> 
> 
> On 10/05/2024 7:17, Joe Damato wrote:
> > Add functions to support the netdev-genl per queue stats API.
> > 
> > ./cli.py --spec netlink/specs/netdev.yaml \
> > --dump qstats-get --json '{"scope": "queue"}'
> > 
> > ...snip
> > 
> >   {'ifindex': 7,
> >    'queue-id': 62,
> >    'queue-type': 'rx',
> >    'rx-alloc-fail': 0,
> >    'rx-bytes': 105965251,
> >    'rx-packets': 179790},
> >   {'ifindex': 7,
> >    'queue-id': 0,
> >    'queue-type': 'tx',
> >    'tx-bytes': 9402665,
> >    'tx-packets': 17551},
> > 
> > ...snip
> > 
> > Also tested with the script tools/testing/selftests/drivers/net/stats.py
> > in several scenarios to ensure stats tallying was correct:
> > 
> > - on boot (default queue counts)
> > - adjusting queue count up or down (ethtool -L eth0 combined ...)
> > - adding mqprio TCs
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >   .../net/ethernet/mellanox/mlx5/core/en_main.c | 144 ++++++++++++++++++
> >   1 file changed, 144 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > index ffe8919494d5..4a675d8b31b5 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > @@ -39,6 +39,7 @@
> >   #include <linux/debugfs.h>
> >   #include <linux/if_bridge.h>
> >   #include <linux/filter.h>
> > +#include <net/netdev_queues.h>
> >   #include <net/page_pool/types.h>
> >   #include <net/pkt_sched.h>
> >   #include <net/xdp_sock_drv.h>
> > @@ -5282,6 +5283,148 @@ static bool mlx5e_tunnel_any_tx_proto_supported(struct mlx5_core_dev *mdev)
> >   	return (mlx5_vxlan_allowed(mdev->vxlan) || mlx5_geneve_tx_allowed(mdev));
> >   }
> > +static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
> > +				     struct netdev_queue_stats_rx *stats)
> > +{
> > +	struct mlx5e_priv *priv = netdev_priv(dev);
> > +
> > +	if (mlx5e_is_uplink_rep(priv))
> > +		return;
> > +
> > +	struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
> > +	struct mlx5e_rq_stats *xskrq_stats = &channel_stats->xskrq;
> > +	struct mlx5e_rq_stats *rq_stats = &channel_stats->rq;
> > +
> 
> Don't we allow variable declaration only at the beginning of a block?
> Is this style accepted in the networking subsystem?

Thanks for the careful review.

I don't know; checkpatch --strict didn't complain, but I can move
all the variable declarations up in the next revision, if you'd
like.

> > +	stats->packets = rq_stats->packets + xskrq_stats->packets;
> > +	stats->bytes = rq_stats->bytes + xskrq_stats->bytes;
> > +	stats->alloc_fail = rq_stats->buff_alloc_err +
> > +			    xskrq_stats->buff_alloc_err;
> > +}
> > +
> > +static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
> > +				     struct netdev_queue_stats_tx *stats)
> > +{
> > +	struct mlx5e_priv *priv = netdev_priv(dev);
> > +	struct net_device *netdev = priv->netdev;
> > +	struct mlx5e_txqsq *sq;
> > +	int j;
> > +
> > +	if (mlx5e_is_uplink_rep(priv))
> > +		return;
> > +
> > +	for (j = 0; j < netdev->num_tx_queues; j++) {
> > +		sq = priv->txq2sq[j];
> 
> No sq instance in case interface is down.

Ah, I see. OK.

> This should be a simple arithmetic calculation.
> Need to expose the proper functions for this calculation, and use it here
> and in the sq create flows.

OK. I was trying to avoid adding more code, but I did see where the
math is done for this elsewhere in the driver and it probably makes
sense to factor that out into its own function to be used in
multiple places.

> Here it seems that you need a very involved user, so he passes the correct
> index i of the SQ that he's interested in..
> 
> > +		if (sq->ch_ix == i) {
> 
> So you're looking for the first SQ on channel i?
> But there might be multiple SQs on channel i...
> Also, this SQ might be already included in the base stats.
> In addition, this i might be too large for a channel index (num_tx_queues
> can be 8 * num_channels)
> 
> The logic here (of mapping from i in num_tx_queues to SQ stats) needs
> careful definition.

OK, I'll go back through and try to sort this out again re-reading
the sq code a few more times.

Thanks again for the careful review, I do really appreciate your
time and effort.

> > +			stats->packets = sq->stats->packets;
> > +			stats->bytes = sq->stats->bytes;
> > +			return;
> > +		}
> > +	}
> > +}
> > +
> > +static void mlx5e_get_base_stats(struct net_device *dev,
> > +				 struct netdev_queue_stats_rx *rx,
> > +				 struct netdev_queue_stats_tx *tx)
> > +{
> > +	struct mlx5e_priv *priv = netdev_priv(dev);
> > +	int i, j;
> > +
> > +	if (!mlx5e_is_uplink_rep(priv)) {
> > +		rx->packets = 0;
> > +		rx->bytes = 0;
> > +		rx->alloc_fail = 0;
> > +
> > +		/* compute stats for deactivated RX queues
> > +		 *
> > +		 * if priv->channels.num == 0 the device is down, so compute
> > +		 * stats for every queue.
> > +		 *
> > +		 * otherwise, compute only the queues which have been deactivated.
> > +		 */
> > +		if (priv->channels.num == 0)
> > +			i = 0;
> > +		else
> > +			i = priv->channels.params.num_channels;
> > +
> > +		for (; i < priv->stats_nch; i++) {
> > +			struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
> > +			struct mlx5e_rq_stats *xskrq_stats = &channel_stats->xskrq;
> > +			struct mlx5e_rq_stats *rq_stats = &channel_stats->rq;
> > +
> > +			rx->packets += rq_stats->packets + xskrq_stats->packets;
> > +			rx->bytes += rq_stats->bytes + xskrq_stats->bytes;
> > +			rx->alloc_fail += rq_stats->buff_alloc_err +
> > +					  xskrq_stats->buff_alloc_err;
> 
> Isn't this equivalent to mlx5e_get_queue_stats_rx(i) ?

It is, yes. If you'd prefer that I call mlx5e_get_queue_stats_rx, I
can do that.

> > +		}
> > +
> > +		if (priv->rx_ptp_opened) {
> > +			struct mlx5e_rq_stats *rq_stats = &priv->ptp_stats.rq;
> > +
> > +			rx->packets += rq_stats->packets;
> > +			rx->bytes += rq_stats->bytes;
> > +		}
> > +	}
> > +
> > +	tx->packets = 0;
> > +	tx->bytes = 0;
> > +
> > +	/* three TX cases to handle:
> > +	 *
> > +	 * case 1: priv->channels.num == 0, get the stats for every TC
> > +	 *         on every queue.
> > +	 *
> > +	 * case 2: priv->channel.num > 0, so get the stats for every TC on
> > +	 *         every deactivated queue.
> > +	 *
> > +	 * case 3: the number of TCs has changed, so get the stats for the
> > +	 *         inactive TCs on active TX queues (handled in the second loop
> > +	 *         below).
> > +	 */
> > +	if (priv->channels.num == 0)
> > +		i = 0;
> > +	else
> > +		i = priv->channels.params.num_channels;
> > +
> 
> All reads/writes to priv->channels must be under the priv->state_lock.

Ah, yes. You are right and I forgot about this part, yet again and
made the same error with RX above.

I think in the next revision I'll hold the state_lock for the entire
function, right?

I presume that dropping the lock right after reading
priv->channels.params.num_channels is incorrect, because the
channels could disappear while iterating through them.

> > +	for (; i < priv->stats_nch; i++) {
> > +		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
> > +
> > +		for (j = 0; j < priv->max_opened_tc; j++) {
> > +			struct mlx5e_sq_stats *sq_stats = &channel_stats->sq[j];
> > +
> > +			tx->packets += sq_stats->packets;
> > +			tx->bytes += sq_stats->bytes;
> > +		}
> > +	}
> > +
> > +	/* Handle case 3 described above. */
> > +	for (i = 0; i < priv->channels.params.num_channels; i++) {
> > +		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
> > +		u8 dcb_num_tc = mlx5e_get_dcb_num_tc(&priv->channels.params);
> > +
> > +		for (j = dcb_num_tc; j < priv->max_opened_tc; j++) {
> > +			struct mlx5e_sq_stats *sq_stats = &channel_stats->sq[j];
> > +
> > +			tx->packets += sq_stats->packets;
> > +			tx->bytes += sq_stats->bytes;
> > +		}
> > +	}
> > +
> > +	if (priv->tx_ptp_opened) {
> > +		for (j = 0; j < priv->max_opened_tc; j++) {
> > +			struct mlx5e_sq_stats *sq_stats = &priv->ptp_stats.sq[j];
> > +
> > +			tx->packets    += sq_stats->packets;
> > +			tx->bytes      += sq_stats->bytes;
> > +		}
> > +	}
> > +}
> > +
> > +static const struct netdev_stat_ops mlx5e_stat_ops = {
> > +	.get_queue_stats_rx     = mlx5e_get_queue_stats_rx,
> > +	.get_queue_stats_tx     = mlx5e_get_queue_stats_tx,
> > +	.get_base_stats         = mlx5e_get_base_stats,
> > +};
> > +
> >   static void mlx5e_build_nic_netdev(struct net_device *netdev)
> >   {
> >   	struct mlx5e_priv *priv = netdev_priv(netdev);
> > @@ -5299,6 +5442,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
> >   	netdev->watchdog_timeo    = 15 * HZ;
> > +	netdev->stat_ops          = &mlx5e_stat_ops;
> >   	netdev->ethtool_ops	  = &mlx5e_ethtool_ops;
> >   	netdev->vlan_features    |= NETIF_F_SG;

