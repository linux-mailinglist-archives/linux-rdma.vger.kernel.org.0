Return-Path: <linux-rdma+bounces-2801-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1265D8D8A00
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 21:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35FD41C238A8
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 19:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B5E405D8;
	Mon,  3 Jun 2024 19:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KFXTOZit"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FB2250EC
	for <linux-rdma@vger.kernel.org>; Mon,  3 Jun 2024 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442553; cv=none; b=Byird+irTZAG8GwQvtL5wL8UBiNH0uT6lENIFH8y8T0gGe61ykCL8GDOgGhlz0DCsVbTa8DJGsdOvbUQ8krDNmMY5C4ZSrodHwvQ0TpLDmNc25/J1mq5BSG8bKQx73hNgfkxmhsUVlZWkFBF96kJQyBTBXKOjaLWMnJ7SS7MuZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442553; c=relaxed/simple;
	bh=FIQzB+I5AjMe3yLmWzQ80cTEBu2GVZyXCeU+mNTTcn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIZ7VVqfzSMXGLcCFssmK8et/EVy2UhpRyLOKX9Gwfacd9nCQ5iO8Bcz0myYeTrbBaUvU1TNeEMirhvA86TPMbzvfttCQMeNkq1kGhhbN4nlOni9ZGhGne9zdWf6aJ4s4rajTP1gSATptzF3TVyt8+WjLSvnMvsETtM8vOYA0bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KFXTOZit; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7025e7a42dcso328736b3a.1
        for <linux-rdma@vger.kernel.org>; Mon, 03 Jun 2024 12:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1717442551; x=1718047351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeKdN6TJvbAfB+biAIiYn7XvqRbSZEVUz1jqlg0SoFU=;
        b=KFXTOZitpbwxNPjEgkTlUmTepKX4bnvVznw7+TlimW8YCBpl6rxZkT+wbJVq3AO5ao
         PS4Nrf481xQdD22381cTSaUciG9Klv2sqEuAz2t4YTj56cTQhnU6W8+oNuw94NaMi2Pz
         FyPV7YNTiJgFbYAjEGX1KbRd69vSOEds1L9TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717442551; x=1718047351;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EeKdN6TJvbAfB+biAIiYn7XvqRbSZEVUz1jqlg0SoFU=;
        b=w/ZUU/enHvupiXvUyB9tLxvm8A1D2t8b13jX47Nofc3ck92l++eF/2qr70WcHJANay
         dc9SzELTshEvPB1TUtOqkk1hToiFkYiv4WraVTO14WBvppY77h3X8oNlj604g3S6/6TK
         130wjvilRFuRQbujFbwHdmymjKg/9GwiuPlA4hb63OkkMM1Ui2E5RKUlGSNPmici4Kbn
         zqf9Ig9sBG6C3Ou8FsOkYHUFgWczIkhQWJnOx5My7g63c0HBcvhUX+v2Wc25xWeESKo2
         YGi96Hl5kwTybTC0A1Vwvaj0nzcBj5HAIfTiySu8nEbDBk96qoOdL0hk/HVbvABUXpyL
         AZgA==
X-Forwarded-Encrypted: i=1; AJvYcCUFngv2tt45t6Jqm60WhG+TpleDNQSH9XSGSw1dFeNav39htpfe2o9FFKJILAr+sc+rNkiLv+p7AGaz4m5wpr8aNoV+YjQHb6kGJQ==
X-Gm-Message-State: AOJu0YyzIcEUP0U1GmHa1Q7wGFWuG9V3TTNifxNTK1zC4ggs+TaX/izQ
	sYtDjm4iIcEFURUkbuFeoFFQB61dV+YFOzb+HfAzBFAzyPQFKRm7ThH42Xyo+8U=
X-Google-Smtp-Source: AGHT+IHHNFGxFvYqxKkh1TG1RkxaeLAurdJ205wYBz91rupyQF51Dk+IL7rWVTzqr5wsB8MKTd7ZNA==
X-Received: by 2002:a05:6a00:2da4:b0:6ec:da6c:fc2d with SMTP id d2e1a72fcca58-7024789b2d0mr11395880b3a.23.1717442550584;
        Mon, 03 Jun 2024 12:22:30 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b03ffasm6044625b3a.141.2024.06.03.12.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 12:22:30 -0700 (PDT)
Date: Mon, 3 Jun 2024 12:22:27 -0700
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
Message-ID: <Zl4X82y3ecR2Mnye@LQ3V64L9R2>
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
> 
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
> 
> I think we should come up with a new mapping array under priv, that maps i
> (from real_num_tx_queues) to the matching sq_stats struct.
> This array would be maintained in the channels open/close functions,
> similarly to priv->txq2sq.
> 
> Then, we would not calculate the mapping per call, but just get the proper
> pointer from the array. This eases the handling of htb and ptp queues, which
> were missed in your txq_ix_to_chtc_ix().

Maybe I am just getting way off track here, but I noticed this in
drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c in
set_pflag_tx_port_ts:

  if (!err)
    priv->tx_ptp_opened = true;

but what if enable is false, meaning the user is disabling ptp via
ethtool?

In that case, shouldn't this be:

  if (!err)
    priv->tx_ptp_opened = enabled;

Because it seems like the user could pass 0 to disable ptp, and with
the current code then trigger mlx5e_close_channels which would call
mlx5e_ptp_close, but priv->tx_ptp_opened might still be true even
though ptp has been closed. Just a guess as I really don't know much
about this code at all, but it seems that the MLX5E_PFLAG_TX_PORT_TS
will be set in set_pflag_tx_port_ts based on enable, which then
affects how mlx5e_open_channels behaves.

Likewise in mlx5e_ptp_close_queues, maybe
rx_ptp_opened and tx_ptp_opened should be set to false there?

It seems like the user could get the driver into an inconsistent
state by enabling then disabling ptp, but maybe I'm just reading
this all wrong.

Is that a bug? If so, I can submit:

1. ethtool tx_ptp_opened = false
2. rx_ptp_opened = tx_ptp_opened = false in mlx5e_ptp_close_queues

to net as a Fixes ?

I am asking about this from the perspective of stats, because in the
qos stuff, the txq2sq_stats mapping is created or removed (set to
NULL) in mlx5e_activate_qos_sq and mlx5e_deactivate_qos_sq /
mlx5e_qos_deactivate_queues, respectively.

This means that priv->txq2sq_stats could be a valid sq_stats or
invalid for deactivated TCs and qos. It seems like ptp should work
the same way, but I have no idea.

If ptp did work the same way, then in base the code would check if
ptp was disabled and obtain the stats from it, if there are any from
it being previously enabled.

That seems like more consistent behavior, but sorry if
I'm totally off on all of this.

> This handles mapped SQs.
> 
> Now, regarding unmapped ones, they must be handled in the "base" function
> call.
> We'd still need to access channels->params, to:
> 1. read params.num_channels to iterate until priv->stats_nch, and
> 2. read mlx5e_get_dcb_num_tc(params) to iterate until priv->max_opened_tc.
> 
> I think we can live with this without holding the mutex, given that this
> runs under the rtnl lock.
> We can add ASSERT_RTNL() to verify the assumption.
> 
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
> 
> > > > +
> > > > +		for (; i < priv->stats_nch; i++) {
> > > > +			struct netdev_queue_stats_rx rx_i = {0};
> > > > +
> > > > +			mlx5e_get_queue_stats_rx(dev, i, &rx_i);
> > > > +
> > > > +			rx->packets += rx_i.packets;
> > > > +			rx->bytes += rx_i.bytes;
> > > > +			rx->alloc_fail += rx_i.alloc_fail;
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
> > > > +	mutex_lock(&priv->state_lock);
> > > > +	for (i = 0; i < priv->stats_nch; i++) {
> > > > +		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
> > > > +
> > > > +		/* while iterating through all channels [0, stats_nch], there
> > > > +		 * are two cases to handle:
> > > > +		 *
> > > > +		 *  1. the channel is available, so sum only the unavailable TCs
> > > > +		 *     [mlx5e_get_dcb_num_tc, max_opened_tc).
> > > > +		 *
> > > > +		 *  2. the channel is unavailable, so sum all TCs [0, max_opened_tc).
> > > > +		 */
> > > 
> > > I wonder why not call the local var 'tc'?
> > 
> > OK.
> > 
> > > > +		if (i < priv->channels.params.num_channels) {
> > > > +			j = mlx5e_get_dcb_num_tc(&priv->channels.params);
> > > > +		} else {
> > > > +			j = 0;
> > > > +		}
> > > 
> > > Remove parenthesis, or use ternary op.
> > 
> > I'll remove the parenthesis; I didn't run checkpatch.pl on this RFC
> > (which catches this), but I should have.
> > 
> > > > +
> > > > +		for (; j < priv->max_opened_tc; j++) {
> > > > +			struct mlx5e_sq_stats *sq_stats = &channel_stats->sq[j];
> > > > +
> > > > +			tx->packets += sq_stats->packets;
> > > > +			tx->bytes += sq_stats->bytes;
> > > > +		}
> > > > +	}
> > > > +	mutex_unlock(&priv->state_lock);
> > > > +
> > > 
> > > Same comment regarding dropping the mutex.
> > 
> > OK.
> 

