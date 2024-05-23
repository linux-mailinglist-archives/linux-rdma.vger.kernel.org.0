Return-Path: <linux-rdma+bounces-2603-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2CF8CDD55
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2024 01:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC7F1C21121
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2024 23:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F7A128808;
	Thu, 23 May 2024 23:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="dzMcrFd9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88C812839A
	for <linux-rdma@vger.kernel.org>; Thu, 23 May 2024 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506052; cv=none; b=fPipPPp8L2SRCKAiYtiBR3gL0XhrzyLbwRS7DtvqLewICifAJlwuZ1A7AZm3yzAhFbqt8gponGeLiHI3qjq+7zt8rZAUZUGxA9Qm2RwdCfcsmoh5IJb91jSpyOogJH5efj/k7FJT3awtop9TxedjLatBG/vpWMtY6cIDcx9imhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506052; c=relaxed/simple;
	bh=bqUQkuXa5kp27cqFOixrQzjm+RinRMNHFY9xJMPCqPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuMT+xurYg0e+0kHg7zahR2jrpW0XxatmYNkCUgj6yYwN5jCiBfuetZZZIWe+Imz75WOu8OSVeqTVGrxuCfCR2drT8l84ge36Q5XJCgjugCsNzMcHN9yK/L0HndsLUV61CaYiLdTX3z8D+CS/anG+vOSWj/Y02sZ8REgz7sXwjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=dzMcrFd9; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f693fb0ad4so3286470b3a.1
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2024 16:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1716506050; x=1717110850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5v+Mh8DcM9ZZz6+1Jz08GF1tfpanRbRhlOGSA8bIUtI=;
        b=dzMcrFd9RA2Bu9ZnFiMxKNvMruVJTXtla3WP+8oOwKB9Y8+8ZFw7J3450cqAFgRlVF
         CzCbWNZrI5riy7a1aKl7tOHyjtgoG/3jDe81+Ra74w8L4DseG3NHq/IOZHblY4o+f+Lh
         hIiKlLczw8YxbvFkfyp7dQzMkn30mCLYuQOV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716506050; x=1717110850;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5v+Mh8DcM9ZZz6+1Jz08GF1tfpanRbRhlOGSA8bIUtI=;
        b=mZyY4Q8IMMzMbFkh4N0UU+GeTN8dk7yxDhLOKWxtoFDKfIb/HmZWoQO3WXYoyZoAzl
         M4noQpNSe4QvC+WGCIjRUDGgCXFQoo9IVfgaDi2fWP8jqejt2aEs9ogaYNAMjcjSO/Sj
         WESzkTUyHhTPl1EVoQQo3paHkzt7MvxJNWLi+RiBlRHcIEVzUqvroV97EQQetvOatU+g
         r6wVcxojpBtgCpT3ZK87SNaL/+aLhdfFmDq+Y9WPyr2SteGS2ENONiqN12Kmtt7ZvlnC
         44CQJ44HegHHu96FMGJq1QC64OdA9bXdqHX6fji3Z5ZNwmTTuM3fRKjAieo2booYTnui
         vsvg==
X-Forwarded-Encrypted: i=1; AJvYcCUdqhAGZv3/VbdjO6DHj9tBfF2WnbCnpQzCvJvGaDAhWWUkC+SvypMo0i8ywhuo3OiQWHf0OM8/LOrgp3ezmgl62gQ8sthA7P0qFw==
X-Gm-Message-State: AOJu0YydlbeZ6vEDIcYgeiNWtoTER+au/GzVPnhB0AdJxkqyBY8XIa+X
	otQhvyzNFoybsAugOwuPz9YG6oaTDSiqvJhiTg91IMfNA9WUqHf0miW5MhkDC7s=
X-Google-Smtp-Source: AGHT+IGhpSFrW3EsmDvV7gbNf4c5jA0OTuQNdVk0jNnic9AE29ORS82XyAU8uFAtgK48adalj3zPcw==
X-Received: by 2002:a05:6a21:6da3:b0:1af:d0bc:d149 with SMTP id adf61e73a8af0-1b212cc4f79mr1130220637.6.1716506049867;
        Thu, 23 May 2024 16:14:09 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd4d51a2sm131842b3a.189.2024.05.23.16.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 16:14:09 -0700 (PDT)
Date: Thu, 23 May 2024 16:14:06 -0700
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
Message-ID: <Zk_NvjDmik2ofw8c@LQ3V64L9R2>
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
 <ZkRiBQXlWPPTNKFf@LQ3V64L9R2>
 <68225941-f3c3-4335-8f3d-edee43f59033@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68225941-f3c3-4335-8f3d-edee43f59033@gmail.com>

On Thu, May 23, 2024 at 10:27:54AM +0300, Tariq Toukan wrote:
> 
> 
> On 15/05/2024 10:19, Joe Damato wrote:
> > On Tue, May 14, 2024 at 09:44:37PM +0300, Tariq Toukan wrote:
> > > 
> > > 
> > > On 10/05/2024 7:17, Joe Damato wrote:
> > > > Add functions to support the netdev-genl per queue stats API.
> > > > 
> > > > ./cli.py --spec netlink/specs/netdev.yaml \
> > > > --dump qstats-get --json '{"scope": "queue"}'
> > > > 
> > > > ...snip
> > > > 
> > > >    {'ifindex': 7,
> > > >     'queue-id': 62,
> > > >     'queue-type': 'rx',
> > > >     'rx-alloc-fail': 0,
> > > >     'rx-bytes': 105965251,
> > > >     'rx-packets': 179790},
> > > >    {'ifindex': 7,
> > > >     'queue-id': 0,
> > > >     'queue-type': 'tx',
> > > >     'tx-bytes': 9402665,
> > > >     'tx-packets': 17551},
> > > > 
> > > > ...snip
> > > > 
> > > > Also tested with the script tools/testing/selftests/drivers/net/stats.py
> > > > in several scenarios to ensure stats tallying was correct:
> > > > 
> > > > - on boot (default queue counts)
> > > > - adjusting queue count up or down (ethtool -L eth0 combined ...)
> > > > - adding mqprio TCs
> > > > 
> > > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > > ---
> > > >    .../net/ethernet/mellanox/mlx5/core/en_main.c | 144 ++++++++++++++++++
> > > >    1 file changed, 144 insertions(+)
> > > > 
> > > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > > > index ffe8919494d5..4a675d8b31b5 100644
> > > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > > > @@ -39,6 +39,7 @@
> > > >    #include <linux/debugfs.h>
> > > >    #include <linux/if_bridge.h>
> > > >    #include <linux/filter.h>
> > > > +#include <net/netdev_queues.h>
> > > >    #include <net/page_pool/types.h>
> > > >    #include <net/pkt_sched.h>
> > > >    #include <net/xdp_sock_drv.h>
> > > > @@ -5282,6 +5283,148 @@ static bool mlx5e_tunnel_any_tx_proto_supported(struct mlx5_core_dev *mdev)
> > > >    	return (mlx5_vxlan_allowed(mdev->vxlan) || mlx5_geneve_tx_allowed(mdev));
> > > >    }
> > > > +static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
> > > > +				     struct netdev_queue_stats_rx *stats)
> > > > +{
> > > > +	struct mlx5e_priv *priv = netdev_priv(dev);
> > > > +
> > > > +	if (mlx5e_is_uplink_rep(priv))
> > > > +		return;
> > > > +
> > > > +	struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
> > > > +	struct mlx5e_rq_stats *xskrq_stats = &channel_stats->xskrq;
> > > > +	struct mlx5e_rq_stats *rq_stats = &channel_stats->rq;
> > > > +
> > > 
> > > Don't we allow variable declaration only at the beginning of a block?
> > > Is this style accepted in the networking subsystem?
> > > 
> > > > +	stats->packets = rq_stats->packets + xskrq_stats->packets;
> > > > +	stats->bytes = rq_stats->bytes + xskrq_stats->bytes;
> > > > +	stats->alloc_fail = rq_stats->buff_alloc_err +
> > > > +			    xskrq_stats->buff_alloc_err;
> > > > +}
> > > > +
> > > > +static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
> > > > +				     struct netdev_queue_stats_tx *stats)
> > > > +{
> > > > +	struct mlx5e_priv *priv = netdev_priv(dev);
> > > > +	struct net_device *netdev = priv->netdev;
> > > > +	struct mlx5e_txqsq *sq;
> > > > +	int j;
> > > > +
> > > > +	if (mlx5e_is_uplink_rep(priv))
> > > > +		return;
> > > > +
> > > > +	for (j = 0; j < netdev->num_tx_queues; j++) {
> > > > +		sq = priv->txq2sq[j];
> > > 
> > > No sq instance in case interface is down.
> > 
> > This seems easily fixable by checking:
> > 
> >    priv->channels.num > 0
> > 
> 
> yes, or test_bit(MLX5E_STATE_OPENED, &priv->state).
> 
> > > This should be a simple arithmetic calculation.
> > 
> > I'm not sure why I can't use txq2sq? Please see below for my
> > explanation about why I think txq2sq might be all I need.
> > 
> > > Need to expose the proper functions for this calculation, and use it here
> > > and in the sq create flows.
> > 
> > I re-read the code several times and my apologies, but I am probably
> > still missing something.
> > 
> > I don't think a calculation function is necessary (see below), but
> > if one is really needed, I'd probably add something like:
> > 
> >    static inline int tc_to_txq_ix(struct mlx5e_channel *c,
> >                                   struct mlx5e_params *params,
> >                                   int tc)
> >    {
> >           return c->ix + tc * params->num_channels;
> 
> We need the opposite direction.
> 
> The goal is to calculate the proper pair of (ch_ix, tc) in order to access
> the correct sq_stats struct in the stats array:
> priv->channel_stats[ch_ix]->sq[tc];
> 
> Given i in [0, real_num_tx_queues), we should extract the pair as follows:
> 
> ch_ix = i % params->num_channels;
> tc = i / params->num_channels;

Thanks -- yea I should have been more clear that I know we need the
opposite direction and what the formula is, but thank you for
confirming that.

> >    }
> > 
> > And call it from mlx5e_open_sqs.
> > 
> > But, I don't understand why any calculation is needed in
> > mlx5e_get_queue_stats_tx. Please see below for explanation.
> > 
> > > 
> > > Here it seems that you need a very involved user, so he passes the correct
> > > index i of the SQ that he's interested in..
> > > 
> > > > +		if (sq->ch_ix == i) {
> > > 
> > > So you're looking for the first SQ on channel i?
> > > But there might be multiple SQs on channel i...
> > > Also, this SQ might be already included in the base stats.
> > > In addition, this i might be too large for a channel index (num_tx_queues
> > > can be 8 * num_channels)
> > > 
> > > The logic here (of mapping from i in num_tx_queues to SQ stats) needs
> > > careful definition.
> > 
> > I read your comments a few times and read the mlx5 source and I am
> > probably still missing something obvious here; my apologies.
> > 
> > In net/core/netdev-genl.c, calls to the driver's get_queue_stats_tx
> > appear to pass [0, netdev->real_num_tx_queues) as i.
> > 
> > I think this means i is a txq_ix in mlx5, because mlx5 sets
> > netdev->real_num_tx_queues in mlx5e_update_tx_netdev_queues, as:
> > 
> >    nch * ntc + qos_queues
> > 
> > which when expanded is
> > 
> >    priv->channels.params.num_channels * mlx5e_get_dcb_num_tc + qos_queues
> > 
> > So, net/core/netdev-genl.c will be using 0 up to that expression as
> > i when calling mlx5e_get_queue_stats_tx.
> > 
> 
> Right.
> 
> > In mlx5:
> >    - mlx5e_activate_priv_channels calls mlx5e_build_txq_maps which
> >      generates priv->txq2sq[txq_ix] = sq for every mlx5e_get_dcb_num_tc
> >      of every priv->channels.num.
> > This seems to happen every time mlx5e_activate_priv_channels is
> > called, which I think means that priv->txq2sq is always up to date
> > and will give the right sq for a given txq_ix (assuming the device
> > isn't down).
> > 
> 
> Right.
> 
> > Putting all of this together, I think that mlx5e_get_queue_stats_tx
> > might need to be something like:
> > 
> >    mutex_lock(&priv->state_lock);
> >    if (priv->channels.num > 0) {
> >            sq = priv->txq2sq[i];
> >            stats->packets = sq->stats->packets;
> >            stats->bytes = sq->stats->bytes;
> >    }
> >    mutex_unlock(&priv->state_lock);
> > 
> 
> Right.
> But you can also access the sq_stats directly without going through the sq.
> This is important as the channels might be down.

Right, OK, thanks that makes sense to me.
 
> 
> > Is this still incorrect somehow?
> > 
> > If so, could you explain a bit more about why a calculation is
> > needed? It seems like txq2sq would provide the mapping from txq_ix's
> > (which is what mlx5e_get_queue_stats_tx gets as 'i') and an sq,
> > which seems like all I would need?
> > 
> > Sorry if I am still not following here.
> > 
> 
> I see two possible solutions:
> 
> 1.
> a. in the base, sum all stats for entries that are no longer available in
> the current configuration (independently to if the netdev is up or down),
> like sqs for ch_ix >= params->num_channels.
> b. in mlx5e_get_queue_stats_tx, access the sq_stats without going through
> the sq (as it might not exist), this will be done for all i in 0 ti
> real_num_tx_queues.
> 
> 2.
> a. in the base, sum all stats for all non existing sqs. if interface is
> down, then no sqs exist, so you sum the whole array.
> b. in mlx5e_get_queue_stats_tx, go through the txq2sq and the sq, if it
> exists, if interface is down just return empty stats.
> 
> I don't have strong preference, although #1 looks slightly better to me.

I think if I am understanding what you wrote correctly the
implementation I did for v2 for the base combined with the txq2sq
mapping I proposed above is equal to solution #2 you describe. I
think.

That said...  I can understand why you might prefer solution #1 so I
will start over and try implementing that one for the v3.

Thanks for the guidance.

> > > > +			stats->packets = sq->stats->packets;
> > > > +			stats->bytes = sq->stats->bytes;
> > > > +			return;
> > > > +		}
> > > > +	}
> > > > +}
> > > > +
> > > > +static void mlx5e_get_base_stats(struct net_device *dev,
> > > > +				 struct netdev_queue_stats_rx *rx,
> > > > +				 struct netdev_queue_stats_tx *tx)
> > > > +{
> > > > +	struct mlx5e_priv *priv = netdev_priv(dev);
> > > > +	int i, j;
> > > > +
> > > > +	if (!mlx5e_is_uplink_rep(priv)) {
> > > > +		rx->packets = 0;
> > > > +		rx->bytes = 0;
> > > > +		rx->alloc_fail = 0;
> > > > +
> > > > +		/* compute stats for deactivated RX queues
> > > > +		 *
> > > > +		 * if priv->channels.num == 0 the device is down, so compute
> > > > +		 * stats for every queue.
> > > > +		 *
> > > > +		 * otherwise, compute only the queues which have been deactivated.
> > > > +		 */
> > > > +		if (priv->channels.num == 0)
> > > > +			i = 0;
> > > > +		else
> > > > +			i = priv->channels.params.num_channels;
> > > > +
> > > > +		for (; i < priv->stats_nch; i++) {
> > > > +			struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
> > > > +			struct mlx5e_rq_stats *xskrq_stats = &channel_stats->xskrq;
> > > > +			struct mlx5e_rq_stats *rq_stats = &channel_stats->rq;
> > > > +
> > > > +			rx->packets += rq_stats->packets + xskrq_stats->packets;
> > > > +			rx->bytes += rq_stats->bytes + xskrq_stats->bytes;
> > > > +			rx->alloc_fail += rq_stats->buff_alloc_err +
> > > > +					  xskrq_stats->buff_alloc_err;
> > > 
> > > Isn't this equivalent to mlx5e_get_queue_stats_rx(i) ?
> > > 
> > > > +		}
> > > > +
> > > > +		if (priv->rx_ptp_opened) {
> > > > +			struct mlx5e_rq_stats *rq_stats = &priv->ptp_stats.rq;
> > > > +
> > > > +			rx->packets += rq_stats->packets;
> > > > +			rx->bytes += rq_stats->bytes;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	tx->packets = 0;
> > > > +	tx->bytes = 0;
> > > > +
> > > > +	/* three TX cases to handle:
> > > > +	 *
> > > > +	 * case 1: priv->channels.num == 0, get the stats for every TC
> > > > +	 *         on every queue.
> > > > +	 *
> > > > +	 * case 2: priv->channel.num > 0, so get the stats for every TC on
> > > > +	 *         every deactivated queue.
> > > > +	 *
> > > > +	 * case 3: the number of TCs has changed, so get the stats for the
> > > > +	 *         inactive TCs on active TX queues (handled in the second loop
> > > > +	 *         below).
> > > > +	 */
> > > > +	if (priv->channels.num == 0)
> > > > +		i = 0;
> > > > +	else
> > > > +		i = priv->channels.params.num_channels;
> > > > +
> > > 
> > > All reads/writes to priv->channels must be under the priv->state_lock.
> > > 
> > > > +	for (; i < priv->stats_nch; i++) {
> > > > +		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
> > > > +
> > > > +		for (j = 0; j < priv->max_opened_tc; j++) {
> > > > +			struct mlx5e_sq_stats *sq_stats = &channel_stats->sq[j];
> > > > +
> > > > +			tx->packets += sq_stats->packets;
> > > > +			tx->bytes += sq_stats->bytes;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	/* Handle case 3 described above. */
> > > > +	for (i = 0; i < priv->channels.params.num_channels; i++) {
> > > > +		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
> > > > +		u8 dcb_num_tc = mlx5e_get_dcb_num_tc(&priv->channels.params);
> > > > +
> > > > +		for (j = dcb_num_tc; j < priv->max_opened_tc; j++) {
> > > > +			struct mlx5e_sq_stats *sq_stats = &channel_stats->sq[j];
> > > > +
> > > > +			tx->packets += sq_stats->packets;
> > > > +			tx->bytes += sq_stats->bytes;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	if (priv->tx_ptp_opened) {
> > > > +		for (j = 0; j < priv->max_opened_tc; j++) {
> > > > +			struct mlx5e_sq_stats *sq_stats = &priv->ptp_stats.sq[j];
> > > > +
> > > > +			tx->packets    += sq_stats->packets;
> > > > +			tx->bytes      += sq_stats->bytes;
> > > > +		}
> > > > +	}
> > > > +}
> > > > +
> > > > +static const struct netdev_stat_ops mlx5e_stat_ops = {
> > > > +	.get_queue_stats_rx     = mlx5e_get_queue_stats_rx,
> > > > +	.get_queue_stats_tx     = mlx5e_get_queue_stats_tx,
> > > > +	.get_base_stats         = mlx5e_get_base_stats,
> > > > +};
> > > > +
> > > >    static void mlx5e_build_nic_netdev(struct net_device *netdev)
> > > >    {
> > > >    	struct mlx5e_priv *priv = netdev_priv(netdev);
> > > > @@ -5299,6 +5442,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
> > > >    	netdev->watchdog_timeo    = 15 * HZ;
> > > > +	netdev->stat_ops          = &mlx5e_stat_ops;
> > > >    	netdev->ethtool_ops	  = &mlx5e_ethtool_ops;
> > > >    	netdev->vlan_features    |= NETIF_F_SG;

