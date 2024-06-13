Return-Path: <linux-rdma+bounces-3141-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C15B907E93
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2024 00:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AADF1F21C19
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 22:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1BE14A62B;
	Thu, 13 Jun 2024 22:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="YTCTKdIP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FCF13B580
	for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2024 22:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718316414; cv=none; b=jyMoXDDV/dsQ0w09Trg7Cn8CCa2iuD2tZK0XIgEm2iZjM5H1hYlCR5LngRtzpz1T17JrFEx8cSX+TiUffRYoT8qb1bbRwYg66t8BulyK9jI3u7aCuHSh2L9HcLeoLnkOvSeMSZKeBFqBxUH0P5IbmOEGRzUQsBbYrVs3yBatSAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718316414; c=relaxed/simple;
	bh=CazWH89dZeGn1QX8nJAFgNWM/Gnj2fhcLA09Rg3lGjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuysVbCbogBiN4lzi7cLoQ4psanPXTcfjEH48bralkDsp8oKXORnrx2swWxjv6peIBFzkT1h900ERNQECSFOjOYTgDQBMkhRJ8l0LTqJMucGrj/e2bqeEtQ8Ri50oafXYHAz+/Hi1/XZIGcgBmrQObA+wHrnU/dT0m2obOVN9Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=YTCTKdIP; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-705cffc5bcfso1055513b3a.3
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2024 15:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1718316411; x=1718921211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDY1xrAK0krXRdo7yQW2Mp/9R1z+FeZBNPgWfuGRw6k=;
        b=YTCTKdIPnNH+xhrTRyqvKAFL598Y5+fLY5aPbXMV1stDpAfrRuq9El9ZqO4BZFfk9D
         91i9TfUfSUz1FA5gOzNzs8j87028zf+DBV+7bmIvyLjxZqVNzZTWMtPKvKu/cMNd3KRA
         V4BCQvk789nBSaC9ZtKw5IDctVauS/OgKKBHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718316411; x=1718921211;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tDY1xrAK0krXRdo7yQW2Mp/9R1z+FeZBNPgWfuGRw6k=;
        b=eteqVP2m4S5KXiyL78Ka//Mr8nPWr7eF4kvsSCKzT6bfiOo8NedVIudUqUUcBYeJsB
         LWIOAjfiH9wYGmhpQpbw4MHr8r14SwZhPuRnASZHcufIXZU7zuccaLuvUBs64YFj/tv8
         DEY8Oaae8wnDyvp/+RkrvQxWiMl+89J+ITJiIKJkNQK8Cn/WcoQfTOQaFtE49MuZ5iUD
         LzTHoixlgwfFTYkMTVrCUu2CgPqZe5Q/+NmAB0iB9ay0f5LpNCrxOJ89BZmS9hoSWJbm
         iquHOCezh1Zbvvh+lQ5DiERfkwS7eJRLbgun4PriFO4dWD/XVHOsx8W/9SqMF0JPQNZ7
         IsYg==
X-Forwarded-Encrypted: i=1; AJvYcCV6q9nVb/Uc0fdn+smrW+fXgllRNEd6wjlyN2xQaCtFdRHwiGEbSYLK6ksLu0LzRcQ+clZsFjzsUrYDgKZnwtTxqGO4YkLLBfVJGQ==
X-Gm-Message-State: AOJu0YzAh7aG1p+k78g7hnCwD4wrxEcd2jFz9WQa1mQNa3HLv54HHTx9
	aGY5fg2DpmmJVMIVpvgo/M9WD6qMfdEP5MWsE1HIyYBc7XDgTS1iOs3aQOzNPBc=
X-Google-Smtp-Source: AGHT+IFEOd3uHRmADgrg1vbHN7c2vYEyoMhSfR6xDBTHw/eb4YUq9yA70822yfRewXj+jnfzglH55A==
X-Received: by 2002:a05:6a20:1586:b0:1ba:ecf7:be20 with SMTP id adf61e73a8af0-1baecf7c180mr145024637.58.1718316411305;
        Thu, 13 Jun 2024 15:06:51 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4ca4997b3sm2065623a91.54.2024.06.13.15.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 15:06:50 -0700 (PDT)
Date: Thu, 13 Jun 2024 15:06:47 -0700
From: Joe Damato <jdamato@fastly.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	nalramli@fastly.com, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [net-next v5 2/2] net/mlx5e: Add per queue netdev-genl stats
Message-ID: <Zmttd81M4g_FF7A9@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Tariq Toukan <ttoukan.linux@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, nalramli@fastly.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
References: <20240612200900.246492-1-jdamato@fastly.com>
 <20240612200900.246492-3-jdamato@fastly.com>
 <0a38f58a-2b1e-4d78-90e1-eb8539f65306@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a38f58a-2b1e-4d78-90e1-eb8539f65306@gmail.com>

On Thu, Jun 13, 2024 at 11:25:12PM +0300, Tariq Toukan wrote:
> 
> 
> On 12/06/2024 23:08, Joe Damato wrote:
> > ./cli.py --spec netlink/specs/netdev.yaml \
> >           --dump qstats-get --json '{"scope": "queue"}'
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
> > 
> > The tools/testing/selftests/drivers/net/stats.py brings the device up,
> > so to test with the device down, I did the following:
> > 
> > $ ip link show eth4
> > 7: eth4: <BROADCAST,MULTICAST> mtu 9000 qdisc mq state DOWN [..snip..]
> >    [..snip..]
> > 
> > $ cat /proc/net/dev | grep eth4
> > eth4: 235710489  434811 [..snip rx..] 2878744 21227  [..snip tx..]
> > 
> > $ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
> >             --dump qstats-get --json '{"ifindex": 7}'
> > [{'ifindex': 7,
> >    'rx-alloc-fail': 0,
> >    'rx-bytes': 235710489,
> >    'rx-packets': 434811,
> >    'tx-bytes': 2878744,
> >    'tx-packets': 21227}]
> > 
> > Compare the values in /proc/net/dev match the output of cli for the same
> > device, even while the device is down.
> > 
> > Note that while the device is down, per queue stats output nothing
> > (because the device is down there are no queues):
> 
> Yeah, the query doesn't reach the device driver...

Yes. Are you suggesting that I update the commit message? I can do
so, if you think that is needed?

> > 
> > $ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
> >             --dump qstats-get --json '{"scope": "queue", "ifindex": 7}'
> > []
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >   .../net/ethernet/mellanox/mlx5/core/en_main.c | 132 ++++++++++++++++++
> >   1 file changed, 132 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > index c548e2fdc58f..d3f38b4b18eb 100644
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
> > @@ -5299,6 +5300,136 @@ static bool mlx5e_tunnel_any_tx_proto_supported(struct mlx5_core_dev *mdev)
> >   	return (mlx5_vxlan_allowed(mdev->vxlan) || mlx5_geneve_tx_allowed(mdev));
> >   }
> > +static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
> > +				     struct netdev_queue_stats_rx *stats)
> > +{
> > +	struct mlx5e_priv *priv = netdev_priv(dev);
> > +	struct mlx5e_channel_stats *channel_stats;
> > +	struct mlx5e_rq_stats *xskrq_stats;
> > +	struct mlx5e_rq_stats *rq_stats;
> > +
> > +	ASSERT_RTNL();
> > +	if (mlx5e_is_uplink_rep(priv))
> > +		return;
> > +
> > +	channel_stats = priv->channel_stats[i];
> > +	xskrq_stats = &channel_stats->xskrq;
> > +	rq_stats = &channel_stats->rq;
> > +
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
> > +	struct mlx5e_sq_stats *sq_stats;
> > +
> > +	ASSERT_RTNL();
> > +	/* no special case needed for ptp htb etc since txq2sq_stats is kept up
> > +	 * to date for active sq_stats, otherwise get_base_stats takes care of
> > +	 * inactive sqs.
> > +	 */
> > +	sq_stats = priv->txq2sq_stats[i];
> > +	stats->packets = sq_stats->packets;
> > +	stats->bytes = sq_stats->bytes;
> > +}
> > +
> > +static void mlx5e_get_base_stats(struct net_device *dev,
> > +				 struct netdev_queue_stats_rx *rx,
> > +				 struct netdev_queue_stats_tx *tx)
> > +{
> > +	struct mlx5e_priv *priv = netdev_priv(dev);
> > +	struct mlx5e_ptp *ptp_channel;
> > +	int i, tc;
> > +
> > +	ASSERT_RTNL();
> > +	if (!mlx5e_is_uplink_rep(priv)) {
> > +		rx->packets = 0;
> > +		rx->bytes = 0;
> > +		rx->alloc_fail = 0;
> > +
> > +		for (i = priv->channels.params.num_channels; i < priv->stats_nch; i++) {
> 
> IIUC, per the current kernel implementation, the lower parts won't be
> completed in a loop over [0..real_num_rx_queues-1], as that loop is
> conditional, happening only if the queues are active.

Sorry, but I'm probably missing something -- you said:

> as that loop is conditional, happening only if the queues are active.

I don't think so? Please continue reading for an example with code.

Let me clarify one thing, please? When you say "the lower parts"
here you mean [0...priv->channels.params.num_channels], is that
right?

If yes, I don't understand why the code in this v5 is wrong. It looks correct
to me, if my understanding of "lower parts" is right.

Here's an example:

1. Machine boots with 32 queues by default.
2. User runs ethtool -L eth0 combined 4

From mlx5/core/en_ethtool.c, mlx5e_ethtool_set_channels:

  new_params = *cur_params;
  new_params.num_channels = count;

So, priv->channels.params.num_channels = 4, [0...4) are the active
queues.

The above loop in mlx5e_get_base_stats sums [4...32), which were previously
active but have since been deactivated by a call to ethtool:

   for (i = priv->channels.params.num_channels; i < priv->stats_nch; i++)

The (snipped) code for netdev-genl, net/core/netdev-genl.c
netdev_nl_stats_by_netdev (which does NOT check IFF_UP) does this:

  /* ... */
  ops->get_base_stats(netdev, &rx_sum, &tx_sum);

  /* ... */
  for (i = 0; i < netdev->real_num_rx_queues; i++) {
    memset(&rx, 0xff, sizeof(rx));
    if (ops->get_queue_stats_rx)
            ops->get_queue_stats_rx(netdev, i, &rx);
    netdev_nl_stats_add(&rx_sum, &rx, sizeof(rx));
  } 

 /* ... */
   ... same for netdev->real_num_tx_queues

The above code gets the base stats (which in my example is [4..32)) and then
gets the stats for the active RX (and if you continue reading, TX) based on
real_num_rx_queues and real_num_tx_queues (which would be [0..4)).

This is why in the commit message, my example:

$ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
            --dump qstats-get --json '{"ifindex": 7}'

The numbers match /proc/net/dev even when the device is down because all queues
active and deactivated are summed properly.

Do you agree with me so far?

The other case is the per-queue case, which is expressed like this (note the
different "scope"):

./cli.py --spec netlink/specs/netdev.yaml \
          --dump qstats-get --json '{"scope": "queue"}'

In this case the user is querying stats on a per queue basis, not overall
across the device.

In this case:
  1. If the device is marked as !IFF_UP (down), an empty set is returned.
  2. Otherwise, as seen in netdev_nl_stats_by_queue (from net/core/netdev-genl.c):

    while (ops->get_queue_stats_rx && i < netdev->real_num_rx_queues) {
      err = netdev_nl_stats_queue(netdev, rsp, NETDEV_QUEUE_TYPE_RX, i, info); 
      /* ... */
    
    /* the same for real_num_tx_queues */	

And so the individual stats for the active queues are returned (as shown in the
commit message example).

If you disagree, can you please provide a detailed example so that I can
understand where I am going wrong?

> I would like the kernel to drop that condition, and stop forcing the device
> driver to conditionally include this part in the base.

I personally don't think the condition should be dropped, but this is a
question for the implementor, who I believe is Jakub.

CC: Jakub on Tariq's request/question above.

> Otherwise, the lower parts need to be added here.

My understanding is that get_base is only called for the summary stats for the
entire device, not the per-queue stats, so I don't think the "lower parts"
(which I take to mean [0...priv->channels.params.num_channels)) need to be added here.

The per-queue stats are only called for a specific queue number that is valid
and will be returned by the other functions, not base.

Of course, I could be wrong and would appreciate insight from Jakub
on this, if possible.

> > +			struct netdev_queue_stats_rx rx_i = {0};
> > +
> > +			mlx5e_get_queue_stats_rx(dev, i, &rx_i);
> > +
> > +			rx->packets += rx_i.packets;
> > +			rx->bytes += rx_i.bytes;
> > +			rx->alloc_fail += rx_i.alloc_fail;
> > +		}
> > +
> > +		/* always report PTP RX stats from base as there is no
> > +		 * corresponding channel to report them under in
> > +		 * mlx5e_get_queue_stats_rx.
> > +		 */
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
> > +	for (i = 0; i < priv->stats_nch; i++) { > +		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
> > +
> > +		/* handle two cases:
> > +		 *
> > +		 *  1. channels which are active. In this case,
> > +		 *     report only deactivated TCs on these channels.
> > +		 *
> > +		 *  2. channels which were deactivated
> > +		 *     (i > priv->channels.params.num_channels)
> > +		 *     must have all of their TCs [0 .. priv->max_opened_tc)
> > +		 *     examined because deactivated channels will not be in the
> > +		 *     range of [0..real_num_tx_queues) and will not have their
> > +		 *     stats reported by mlx5e_get_queue_stats_tx.
> > +		 */
> > +		if (i < priv->channels.params.num_channels)
> > +			tc = mlx5e_get_dcb_num_tc(&priv->channels.params);
> > +		else
> > +			tc = 0;
> > +
> > +		for (; tc < priv->max_opened_tc; tc++) {
> > +			struct mlx5e_sq_stats *sq_stats = &channel_stats->sq[tc];
> > +
> > +			tx->packets += sq_stats->packets;
> > +			tx->bytes += sq_stats->bytes;
> > +		}
> 
> Again, what about the lower part in case queues are not active?

I am not trying to be difficult here; I appreciate your time and energy, but I
think there is still some misunderstanding here.

Probably on my side ;)

But, if the queues are not active then any queue above
priv->channels.params.num_channels (the non active queues) will have all TCs
summed.

> > +	}
> > +
> > +	/* if PTP TX was opened at some point and has since either:
> > +	 *    -  been shutdown and set to NULL, or
> > +	 *    -  simply disabled (bit unset)
> > +	 *
> > +	 * report stats directly from the ptp_stats structures as these queues
> > +	 * are now unavailable and there is no txq index to retrieve these
> > +	 * stats via calls to mlx5e_get_queue_stats_tx.
> > +	 */
> > +	ptp_channel = priv->channels.ptp;
> > +	if (priv->tx_ptp_opened && (!ptp_channel || !test_bit(MLX5E_PTP_STATE_TX, ptp_channel->state))) {
> > +		for (tc = 0; tc < priv->max_opened_tc; tc++) {
> > +			struct mlx5e_sq_stats *sq_stats = &priv->ptp_stats.sq[tc];
> > +
> > +			tx->packets += sq_stats->packets;
> > +			tx->bytes   += sq_stats->bytes;
> > +		}
> > +	}
> > +}
> > +
> > +static const struct netdev_stat_ops mlx5e_stat_ops = {
> > +	.get_queue_stats_rx  = mlx5e_get_queue_stats_rx,
> > +	.get_queue_stats_tx  = mlx5e_get_queue_stats_tx,
> > +	.get_base_stats      = mlx5e_get_base_stats,
> > +};
> > +
> >   static void mlx5e_build_nic_netdev(struct net_device *netdev)
> >   {
> >   	struct mlx5e_priv *priv = netdev_priv(netdev);
> > @@ -5316,6 +5447,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
> >   	netdev->watchdog_timeo    = 15 * HZ;
> > +	netdev->stat_ops	  = &mlx5e_stat_ops;
> >   	netdev->ethtool_ops	  = &mlx5e_ethtool_ops;
> >   	netdev->vlan_features    |= NETIF_F_SG;

