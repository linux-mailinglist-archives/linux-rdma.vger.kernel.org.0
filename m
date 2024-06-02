Return-Path: <linux-rdma+bounces-2760-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD32A8D7791
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Jun 2024 21:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C27E281EC6
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Jun 2024 19:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5767A74047;
	Sun,  2 Jun 2024 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="CaQ7tMJe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54499219E4
	for <linux-rdma@vger.kernel.org>; Sun,  2 Jun 2024 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717356181; cv=none; b=Rvd8XrbSKLiSFF97NdZn6wQye3FnvhsuX/5gbMrq1wERalbN71v/+bt9MONGbGXAoQvRF4b7eimsIeneWjT0uhSTZX6LVSQ1VqRvtqZaDBDpDll5McTLk1cAiCrY0RGN9rYHNrXFCsH/Cq+hBRBK0X/eZZGcZvc+VYoLN9Vw598=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717356181; c=relaxed/simple;
	bh=+p/p+sBxaVahfhxddUOMzIzx9u5f7xMb0tzl6gyB0EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNTVuJmC0qLt2cfV09wRm7M/nFRKZkCf4bhxykft1t1l+iYNYgF+ubL4ecrE54Fvbm0oFGQ9RVaCnwQEs11gxYLkz7lvHZctYiTNPzL5j1vACB9ZCkOgJyKjWg7lMz5crvAbDlKPg9iln/xjZrAGJ3ieInbUXl9JwV0s+TPdQPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=CaQ7tMJe; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7025e7a42dcso596922b3a.1
        for <linux-rdma@vger.kernel.org>; Sun, 02 Jun 2024 12:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1717356177; x=1717960977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6CN0GkVm8fJ9Piv7fNFcgMAHcn/4Sw1khoJK+SgkbE=;
        b=CaQ7tMJe9oZHx9YLxK6S519cobDIYyFN0trq3psMlCpIVIcGCgO5IlrELBjXg0escb
         /5PZVejU7iO3GPa9v/EjZBo1F3MajfOevBP02XueYr+2iOwGyJgjRBWJ4YkuqCj8v0wO
         NUcRWeRFdTkaGmOoXQTrLkTT9lj/pqJOZWGf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717356177; x=1717960977;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6CN0GkVm8fJ9Piv7fNFcgMAHcn/4Sw1khoJK+SgkbE=;
        b=v4ZBFLQKga2ebvLbTIZtQYaVJxXOJ5SdKYVQLrj/f6ioGCk1lhkzKo9G25WAKLzMha
         0to+eyX822BZx0rfDTaZ/GkpLo4hBOrDXD1n9F0z6EXMKksfpjvuN7AAmyqWCkPB5x9N
         EsOqyk0tn1vriTbeuDQ+HrkBgIcmi2t/3AoTZSFzBN0E4ejBzCvAaTM62cbJUEhUbhZx
         D4yqmIv/d1wGS1bIaHjaQ5cAMtiuWD0Dq2C5An0imxZGnIDu56i6s07qUY95cj9DCRbh
         d7j3FpjEOAk2bUD/WKT+iSsUYe9HaoFQ+YD+B9z6HkKbyAoJ29ScFhYLkpY35cAwSEkc
         8Meg==
X-Forwarded-Encrypted: i=1; AJvYcCWUESwwuHMibZEUVOuKQ/C5B2gXp12Ut6aoT8gW2BpqNTG555srzLyiCrfhClR29YP8951qWgGCJmX9AunORt8E9WYLK6XlNm3rvw==
X-Gm-Message-State: AOJu0YwRebp5nq4LABaAwc2+Lt5DeyGdNLVKd9kV1qRtRcdeqRrSrdIm
	llgnQ+OVhOoyxH1rAkWBQ2D1RHvoyjtApFqY2Mzg9S75lOdQSxY0d/jo9iw7qGI=
X-Google-Smtp-Source: AGHT+IEhA4qMhYDN38lQFg3dzXtqMQx9B5qMRLpQJlpnRGXdDqWSGZtiQnKi9+5BsCRx/YOhcB39zg==
X-Received: by 2002:a05:6a20:748d:b0:1b0:18e6:ac2c with SMTP id adf61e73a8af0-1b26f23cfcdmr7598667637.40.1717356177187;
        Sun, 02 Jun 2024 12:22:57 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b05497sm4278203b3a.167.2024.06.02.12.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 12:22:56 -0700 (PDT)
Date: Sun, 2 Jun 2024 12:22:53 -0700
From: Joe Damato <jdamato@fastly.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	nalramli@fastly.com, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [RFC net-next v3 2/2] net/mlx5e: Add per queue netdev-genl stats
Message-ID: <ZlzGjXxVD-JClqIy@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Tariq Toukan <ttoukan.linux@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	nalramli@fastly.com, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
References: <20240529031628.324117-1-jdamato@fastly.com>
 <20240529031628.324117-3-jdamato@fastly.com>
 <5b3a0f6a-5a03-45d7-ab10-1f1ba25504d3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b3a0f6a-5a03-45d7-ab10-1f1ba25504d3@gmail.com>

On Sun, Jun 02, 2024 at 12:14:21PM +0300, Tariq Toukan wrote:
> 
> 
> On 29/05/2024 6:16, Joe Damato wrote:
> > Add functions to support the netdev-genl per queue stats API.
> > 
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
> > - adding mqprio TCs
> 
> Please test also with interface down.

OK. I'll test with the interface down.

Is there some publicly available Mellanox script I can run to test
all the different cases? That would make this much easier. Maybe
this is something to include in mlnx-tools on github?

The mlnx-tools scripts that includes some python scripts for setting
up QoS doesn't seem to work on my system, and outputs vague error
messages. I have no idea if I'm missing some kernel option, if the
device doesn't support it, or if I need some other dependency
installed.

I have been testing these patches on a:

Mellanox Technologies MT28800 Family [ConnectX-5 Ex]
firmware-version: 16.29.2002 (MT_0000000013)

> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >   .../net/ethernet/mellanox/mlx5/core/en_main.c | 132 ++++++++++++++++++
> >   1 file changed, 132 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > index ce15805ad55a..515c16a88a6c 100644
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
> > @@ -5293,6 +5294,136 @@ static bool mlx5e_tunnel_any_tx_proto_supported(struct mlx5_core_dev *mdev)
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
> > +	struct mlx5e_channel_stats *channel_stats;
> > +	struct mlx5e_sq_stats *sq_stats;
> > +	int ch_ix, tc_ix;
> > +
> > +	mutex_lock(&priv->state_lock);
> > +	txq_ix_to_chtc_ix(&priv->channels.params, i, &ch_ix, &tc_ix);
> > +	mutex_unlock(&priv->state_lock);
> > +
> > +	channel_stats = priv->channel_stats[ch_ix];
> > +	sq_stats = &channel_stats->sq[tc_ix];
> > +
> > +	stats->packets = sq_stats->packets;
> > +	stats->bytes = sq_stats->bytes;
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
> > +		mutex_lock(&priv->state_lock);
> > +		if (priv->channels.num == 0)
> > +			i = 0;
> 
> This is not consistent with the above implementation of
> mlx5e_get_queue_stats_rx(), which always returns the stats even if the
> channel is down.
> This way, you'll double count the down channels.
> 
> I think you should always start from priv->channels.params.num_channels.

OK, I'll do that.

> > +		else
> > +			i = priv->channels.params.num_channels;
> > +		mutex_unlock(&priv->state_lock);
> 
> I understand that you're following the guidelines by taking the lock here, I
> just don't think this improves anything... If channels can be modified in
> between calls to mlx5e_get_base_stats / mlx5e_get_queue_stats_rx, then
> wrapping the priv->channels access with a lock can help protect each single
> deref, but not necessarily in giving a consistent "screenshot" of the stats.
> 
> The rtnl_lock should take care of that, as the driver holds it when changing
> the number of channels and updating the real_numrx/tx_queues.
> 
> This said, I would carefully say you can drop the mutex once following the
> requested changes above.

OK, that makes sense to me.

So then I assume I can drop the mutex in mlx5e_get_queue_stats_tx
above, as well, for the same reasons?

Does this mean then that you are in favor of the implementation for
tx stats provided in this RFC and that I've implemented option 1 as
you described in the previous thread correctly?

> > +
> > +		for (; i < priv->stats_nch; i++) {
> > +			struct netdev_queue_stats_rx rx_i = {0};
> > +
> > +			mlx5e_get_queue_stats_rx(dev, i, &rx_i);
> > +
> > +			rx->packets += rx_i.packets;
> > +			rx->bytes += rx_i.bytes;
> > +			rx->alloc_fail += rx_i.alloc_fail;
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
> > +	mutex_lock(&priv->state_lock);
> > +	for (i = 0; i < priv->stats_nch; i++) {
> > +		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
> > +
> > +		/* while iterating through all channels [0, stats_nch], there
> > +		 * are two cases to handle:
> > +		 *
> > +		 *  1. the channel is available, so sum only the unavailable TCs
> > +		 *     [mlx5e_get_dcb_num_tc, max_opened_tc).
> > +		 *
> > +		 *  2. the channel is unavailable, so sum all TCs [0, max_opened_tc).
> > +		 */
> 
> I wonder why not call the local var 'tc'?

OK.

> > +		if (i < priv->channels.params.num_channels) {
> > +			j = mlx5e_get_dcb_num_tc(&priv->channels.params);
> > +		} else {
> > +			j = 0;
> > +		}
> 
> Remove parenthesis, or use ternary op.

I'll remove the parenthesis; I didn't run checkpatch.pl on this RFC
(which catches this), but I should have.

> > +
> > +		for (; j < priv->max_opened_tc; j++) {
> > +			struct mlx5e_sq_stats *sq_stats = &channel_stats->sq[j];
> > +
> > +			tx->packets += sq_stats->packets;
> > +			tx->bytes += sq_stats->bytes;
> > +		}
> > +	}
> > +	mutex_unlock(&priv->state_lock);
> > +
> 
> Same comment regarding dropping the mutex.

OK.

