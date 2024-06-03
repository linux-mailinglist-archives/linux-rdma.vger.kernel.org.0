Return-Path: <linux-rdma+bounces-2799-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAA28D8879
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 20:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAAF5B20AF5
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 18:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E7D137C5A;
	Mon,  3 Jun 2024 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="nt/Iv8ab"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2704E137C2A
	for <linux-rdma@vger.kernel.org>; Mon,  3 Jun 2024 18:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717438289; cv=none; b=JpGglCDUJ1DIXTeS8gF1oYZ4ZGSjlA2ftdFUxE2AxuWooFayipLG0lUKPPZwGnTotGefiFV3FFi+YpfXC0UBCOa9vQLz76N/qJG94nBElUaeZ6HCbWMNf0XQrRuAHsRxJtRT/GMq3BydPJnZi8AmtUfFG1Eg789z+41dF8liU/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717438289; c=relaxed/simple;
	bh=jY7dhI3/9yxnM9yEiaYkEdE5FHTB+pX1BMMxN2viUCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6SZD/7XLsCu5/2xhkqZ+fGFwZYxyXUHVjoTYQFd7+Uz4mcEZv6yMyViayTPDvK7niiwb8wfltGtItpp+kgGpo37f8fwFZ7CPNI2wUWQxHiBWyHhqdfOZgQ8IiMVUMRKQG91wb5GIywa5rjySg5TfiftpQ8xw5t05jvRSR4K7bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=nt/Iv8ab; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-701b0b0be38so4220129b3a.0
        for <linux-rdma@vger.kernel.org>; Mon, 03 Jun 2024 11:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1717438285; x=1718043085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBBXkcJxxPJLd6H7n8JPjoD/597hQTKlLQ3epFR5740=;
        b=nt/Iv8abmFF4tkxO7HvqzGsoLCwWze5XbuOFxwuVR3vkgs/okG7zYP5xKSYQfcFZtF
         idKTyqZS34GI48mRzWWD5tkDzUOQ0M6klS+j6gKpoAffs4JkI7+KoeYZ+Ppx3Alzb1S5
         QJBWfy/FKt3fips3q1ezi2bR+j9dmNHCtc0OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717438285; x=1718043085;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBBXkcJxxPJLd6H7n8JPjoD/597hQTKlLQ3epFR5740=;
        b=liCNpCcs2P2hCkqjInCfDZzKTqyuup9lMm51s5n1VzFt9cJ3po4koG6T4jP6mQasdV
         0hym2GHLjYL4VbrhoPnm+xavNQ3ZVuGrNL8ux7AuD51yFL9x5MG4lRR561o/hgmuAhPX
         YM6rF7uiOWzazd72o7gaR8BxjmmiuRxu+P/A8rV/x5Sr9gq2Z3vYowVsKeLunTFvbaGx
         IBkNoh3LEmc+V++jwWg4z60LzHABVqjDv2csgUemGbjcTrkn4DOlMbqi5lQJdr5E6iB1
         W9pGj+SUTDavgCqrJ9SSw4CuLGU30wwpsy8w/Nik6u5qnUyeTdS9Co1SM/xpFUT854q4
         Odtg==
X-Forwarded-Encrypted: i=1; AJvYcCVJcv6tbaOs1Y0LmkyeJfXAKItFrjpH56OFN8uB5jMtGlEBZviKTLY6K1MQOoeFpfldZVnitwMUWe2zlbjH+85g5X85iPpKmCxbbQ==
X-Gm-Message-State: AOJu0YwrsXHZkBVmSjtkbdupB/I0wCUGIvPYlZK54lHMzQr/CYoAOcVq
	GcnZgoLd5Z/E5XjPirAKgIETtS0njUn+R9v8bjQW+2/gevuB1QuTTBmbjmyrpdo=
X-Google-Smtp-Source: AGHT+IHzK7mwWxeusH6iqEimvz908w6Q7NRqB5ZL5bWAU8sBUz4ZKAyxO4TY6sm6whA+4iajMw9i3Q==
X-Received: by 2002:a05:6a21:2786:b0:1af:d4b1:889e with SMTP id adf61e73a8af0-1b26f30d7d0mr10331630637.53.1717438285299;
        Mon, 03 Jun 2024 11:11:25 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b03ffasm5976779b3a.141.2024.06.03.11.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 11:11:24 -0700 (PDT)
Date: Mon, 3 Jun 2024 11:11:21 -0700
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
Message-ID: <Zl4HSaP4z_UiYnnc@LQ3V64L9R2>
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
 <ZlzGjXxVD-JClqIy@LQ3V64L9R2>
 <eda43490-8d77-4d7d-9b24-1aafd073d760@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eda43490-8d77-4d7d-9b24-1aafd073d760@gmail.com>

On Mon, Jun 03, 2024 at 02:11:14PM +0300, Tariq Toukan wrote:
> 
> 
> On 02/06/2024 22:22, Joe Damato wrote:
> > On Sun, Jun 02, 2024 at 12:14:21PM +0300, Tariq Toukan wrote:
> > > 
> > > 
> > > On 29/05/2024 6:16, Joe Damato wrote:
> > > > Add functions to support the netdev-genl per queue stats API.
> > > > 
> > > > ./cli.py --spec netlink/specs/netdev.yaml \
> > > >            --dump qstats-get --json '{"scope": "queue"}'
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
> > > 
> > > Please test also with interface down.
> > 
> > OK. I'll test with the interface down.
> > 
> > Is there some publicly available Mellanox script I can run to test
> > all the different cases? That would make this much easier. Maybe
> > this is something to include in mlnx-tools on github?
> > 
> 
> You're testing some new functionality. We don't have something for it.
> 
> 
> > The mlnx-tools scripts that includes some python scripts for setting
> > up QoS doesn't seem to work on my system, and outputs vague error
> > messages. I have no idea if I'm missing some kernel option, if the
> > device doesn't support it, or if I need some other dependency
> > installed.
> > 
> 
> Can you share the command you use, and the output?

Sure:

jdamato@test:~/mlnx-tools/python$ python --version
Python 3.12.3

jdamato@test:~/mlnx-tools/python$ ./mlnx_qos -i vlan401
Priority trust state is not supported on your system
Buffers commands are not supported on your system
Rate limit is not supported on your system!
ETS features are not supported on your system

jdamato@test:~/mlnx-tools/python$ echo $?
1

This is mlnx-tools at SHA 641718b13f71 ("Merge pull request #87 from
ahlabenadam/no_remove_folder")

You can feel free to follow up with me about this off-list if you
like.

> > I have been testing these patches on a:
> > 
> > Mellanox Technologies MT28800 Family [ConnectX-5 Ex]
> > firmware-version: 16.29.2002 (MT_0000000013)
> > 
> > > > 
> > > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > > ---
> > > >    .../net/ethernet/mellanox/mlx5/core/en_main.c | 132 ++++++++++++++++++
> > > >    1 file changed, 132 insertions(+)
> > > > 
> > > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > > > index ce15805ad55a..515c16a88a6c 100644
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
> > > > @@ -5293,6 +5294,136 @@ static bool mlx5e_tunnel_any_tx_proto_supported(struct mlx5_core_dev *mdev)
> > > >    	return (mlx5_vxlan_allowed(mdev->vxlan) || mlx5_geneve_tx_allowed(mdev));
> > > >    }
> > > > +static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
> > > > +				     struct netdev_queue_stats_rx *stats)
> > > > +{
> > > > +	struct mlx5e_priv *priv = netdev_priv(dev);
> > > > +	struct mlx5e_channel_stats *channel_stats;
> > > > +	struct mlx5e_rq_stats *xskrq_stats;
> > > > +	struct mlx5e_rq_stats *rq_stats;
> > > > +
> > > > +	if (mlx5e_is_uplink_rep(priv))
> > > > +		return;
> > > > +
> > > > +	channel_stats = priv->channel_stats[i];
> > > > +	xskrq_stats = &channel_stats->xskrq;
> > > > +	rq_stats = &channel_stats->rq;
> > > > +
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
> > > > +	struct mlx5e_channel_stats *channel_stats;
> > > > +	struct mlx5e_sq_stats *sq_stats;
> > > > +	int ch_ix, tc_ix;
> > > > +
> > > > +	mutex_lock(&priv->state_lock);
> > > > +	txq_ix_to_chtc_ix(&priv->channels.params, i, &ch_ix, &tc_ix);
> > > > +	mutex_unlock(&priv->state_lock);
> > > > +
> > > > +	channel_stats = priv->channel_stats[ch_ix];
> > > > +	sq_stats = &channel_stats->sq[tc_ix];
> > > > +
> > > > +	stats->packets = sq_stats->packets;
> > > > +	stats->bytes = sq_stats->bytes;
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
> > > > +		mutex_lock(&priv->state_lock);
> > > > +		if (priv->channels.num == 0)
> > > > +			i = 0;
> > > 
> > > This is not consistent with the above implementation of
> > > mlx5e_get_queue_stats_rx(), which always returns the stats even if the
> > > channel is down.
> > > This way, you'll double count the down channels.
> > > 
> > > I think you should always start from priv->channels.params.num_channels.
> > 
> > OK, I'll do that.
> > 
> > > > +		else
> > > > +			i = priv->channels.params.num_channels;
> > > > +		mutex_unlock(&priv->state_lock);
> > > 
> > > I understand that you're following the guidelines by taking the lock here, I
> > > just don't think this improves anything... If channels can be modified in
> > > between calls to mlx5e_get_base_stats / mlx5e_get_queue_stats_rx, then
> > > wrapping the priv->channels access with a lock can help protect each single
> > > deref, but not necessarily in giving a consistent "screenshot" of the stats.
> > > 
> > > The rtnl_lock should take care of that, as the driver holds it when changing
> > > the number of channels and updating the real_numrx/tx_queues.
> > > 
> > > This said, I would carefully say you can drop the mutex once following the
> > > requested changes above.
> 
> I still don't really like this design, so I gave some more thought on
> this...

Thanks, again, for your careful thoughts and review on this. I do
appreciate it and this functionality will be extremely useful for me
(and I suspect many others).

> I think we should come up with a new mapping array under priv, that maps i
> (from real_num_tx_queues) to the matching sq_stats struct.
> This array would be maintained in the channels open/close functions,
> similarly to priv->txq2sq.
> 
> Then, we would not calculate the mapping per call, but just get the proper
> pointer from the array. This eases the handling of htb and ptp queues, which
> were missed in your txq_ix_to_chtc_ix().
> 
> This handles mapped SQs.

OK, the above makes sense. I'll give that a try.

> Now, regarding unmapped ones, they must be handled in the "base" function
> call.
> We'd still need to access channels->params, to:
> 1. read params.num_channels to iterate until priv->stats_nch, and
> 2. read mlx5e_get_dcb_num_tc(params) to iterate until priv->max_opened_tc.
> 
> I think we can live with this without holding the mutex, given that this
> runs under the rtnl lock.
> We can add ASSERT_RTNL() to verify the assumption.

OK. I'll try the above and propose an rfc v4.

> 
> > 
> > OK, that makes sense to me.
> > 
> > So then I assume I can drop the mutex in mlx5e_get_queue_stats_tx
> > above, as well, for the same reasons?
> > 
> > Does this mean then that you are in favor of the implementation for
> > tx stats provided in this RFC and that I've implemented option 1 as
> > you described in the previous thread correctly?
> > 
> 
> Yes, but I wasn't happy enough with the design.
> Thanks for your contribution.

Thanks for your review and patience.

