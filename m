Return-Path: <linux-rdma+bounces-2491-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC078C6198
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2024 09:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4E81C21814
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2024 07:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F5344391;
	Wed, 15 May 2024 07:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="F7cveteS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D154EAE1
	for <linux-rdma@vger.kernel.org>; Wed, 15 May 2024 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757580; cv=none; b=CWGsH5GXgRhexkFCrsyMss44YSNMEG1V+/mxQTk7XWY2Nj+pu7JLVJlJjHpS8aNASfeaiwo9WlzFHGol0vhQau3vL3VYHgmamuU5W6ycgC/UCNPJKS3S2OgAoDnF7JHSBcNGiam3xcDQ/4bpJgvN5j8ZUyZeW4fyw8jBU0cmOPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757580; c=relaxed/simple;
	bh=mS08T4zIxogbYBvEKUHiOAoYLAIbH6I61MwGI+XhY1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoHoN72NTczdfVENpofC8ML81V8MFC1FWfdrtS8lvkL7mnUx6JWqq7CxPQIuPdqWCn+MXyhJnA90dc8cA1rqmKVQMiF7T9CV0qTB6NeM4TL/wd4io3czchqF9dIMyfU7IakWT/tXjeGyPoBb2yvyoU9EKmj800u2gAhWStsHWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=F7cveteS; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f0e4212d5aso4059763a34.3
        for <linux-rdma@vger.kernel.org>; Wed, 15 May 2024 00:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715757576; x=1716362376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vInc6tO6gm1EBIF0gkzHCYRIhFoOvwprPtnR3toXSdo=;
        b=F7cveteSjC8s+OVdJoS1d+mrxpZuzNI9m11PWbt/z407Fa9sJl6adckzZqXkdfysko
         GMpLRo/WLEwx2QTYfcg+z2Q8S/ik6Wa+ukun89XysrhnSckGrh1rYWwIevQvu+4YmZH+
         IzzZx7L+OJSFh1gFPPnjO5/BWcjjnUEZk+oyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757576; x=1716362376;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vInc6tO6gm1EBIF0gkzHCYRIhFoOvwprPtnR3toXSdo=;
        b=bVb6xFNWFnJvcIuUhtq91dt9RVk6vEEJAiEsdSMuw0+AXJFJ1cCuJb579W3i4MFJj7
         9z5yH0+YrB3Hj1Am5z3EeeWr90Vvjp+qsBSTek/NXjUoRBuUe2iz5jjPYKQL1qOAzwzy
         tPYVJDaqHllQa1ftKtsGZXD8eFOQFPoH669NENGz5Rc2Gkwb2BYv1g2x0okWIV2YoVHd
         GP9qLDTgUcg9blDKCawauQfbsIVr8XoViZ2fto4Y0dQjPGdnExzqIXgtlvOBh+vKTpz5
         fDAT2+om6UnSfLiRZKSIv836g4287/143jDDQWJwL9Fquggey9D8zLHGlXjC1m6MTNQR
         zmmA==
X-Forwarded-Encrypted: i=1; AJvYcCU3uH1LWZbJTo6jUAA+r1qC6HiEFRdT+4s7BLNIvOjjTh12lSESLeBE47bQBDuSHmNzMLjPHrweRqO1tStm7H6McqiBmmpI3o9NmQ==
X-Gm-Message-State: AOJu0Yxc1bT79RkI4T1u1b64lRRFM64BSWwG2lKJtD5o/2medJ4td+gN
	Eik9NuJFyFD9BBWBMjktPipOn/F9Ij/Or6pj+jHeF3RqWLKtx9VeQo9IxF/iFBQ=
X-Google-Smtp-Source: AGHT+IENhxUk/prABJNgrjbL/Tor7bHDeJJbi/khOuNFwiXA6wD33OONdfmfxUwnTdRFPmq3p9lh2w==
X-Received: by 2002:a05:6830:1515:b0:6f0:e78d:7019 with SMTP id 46e09a7af769-6f0e9112427mr18418109a34.16.1715757576061;
        Wed, 15 May 2024 00:19:36 -0700 (PDT)
Received: from LQ3V64L9R2 ([2601:3c7:4200:9500:c97:2507:4743:1383])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b2b155b94csm1390433eaf.27.2024.05.15.00.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:19:35 -0700 (PDT)
Date: Wed, 15 May 2024 02:19:33 -0500
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
Message-ID: <ZkRiBQXlWPPTNKFf@LQ3V64L9R2>
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
> 
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

This seems easily fixable by checking:

  priv->channels.num > 0

> This should be a simple arithmetic calculation.

I'm not sure why I can't use txq2sq? Please see below for my
explanation about why I think txq2sq might be all I need.

> Need to expose the proper functions for this calculation, and use it here
> and in the sq create flows.

I re-read the code several times and my apologies, but I am probably
still missing something.

I don't think a calculation function is necessary (see below), but
if one is really needed, I'd probably add something like:

  static inline int tc_to_txq_ix(struct mlx5e_channel *c,
                                 struct mlx5e_params *params,
                                 int tc)
  {
         return c->ix + tc * params->num_channels;
  }

And call it from mlx5e_open_sqs.

But, I don't understand why any calculation is needed in
mlx5e_get_queue_stats_tx. Please see below for explanation.

> 
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

I read your comments a few times and read the mlx5 source and I am
probably still missing something obvious here; my apologies.

In net/core/netdev-genl.c, calls to the driver's get_queue_stats_tx
appear to pass [0, netdev->real_num_tx_queues) as i.

I think this means i is a txq_ix in mlx5, because mlx5 sets
netdev->real_num_tx_queues in mlx5e_update_tx_netdev_queues, as:

  nch * ntc + qos_queues

which when expanded is

  priv->channels.params.num_channels * mlx5e_get_dcb_num_tc + qos_queues

So, net/core/netdev-genl.c will be using 0 up to that expression as
i when calling mlx5e_get_queue_stats_tx.

In mlx5: 
  - mlx5e_activate_priv_channels calls mlx5e_build_txq_maps which
    generates priv->txq2sq[txq_ix] = sq for every mlx5e_get_dcb_num_tc
    of every priv->channels.num.
 
This seems to happen every time mlx5e_activate_priv_channels is
called, which I think means that priv->txq2sq is always up to date
and will give the right sq for a given txq_ix (assuming the device
isn't down).

Putting all of this together, I think that mlx5e_get_queue_stats_tx
might need to be something like:

  mutex_lock(&priv->state_lock);
  if (priv->channels.num > 0) {
          sq = priv->txq2sq[i];
          stats->packets = sq->stats->packets;
          stats->bytes = sq->stats->bytes;
  }
  mutex_unlock(&priv->state_lock);

Is this still incorrect somehow?

If so, could you explain a bit more about why a calculation is
needed? It seems like txq2sq would provide the mapping from txq_ix's
(which is what mlx5e_get_queue_stats_tx gets as 'i') and an sq,
which seems like all I would need?

Sorry if I am still not following here.

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
> 
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
> 
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

