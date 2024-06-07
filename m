Return-Path: <linux-rdma+bounces-3007-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9F5900D2E
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 22:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4281F2864A
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 20:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC203154C19;
	Fri,  7 Jun 2024 20:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="llDtZoW6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C034D14A60A
	for <linux-rdma@vger.kernel.org>; Fri,  7 Jun 2024 20:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717793444; cv=none; b=RCB1GnqBkZsAUwaepULmB7wuP0afYa33gJFP45NICOklnW7NABpRSHnobuES6EkmiQvM/sttRR82rC1lD+DMDo0GNElfkeX+UtXtrHW8TCSi82P+QJ29ejMbY5I8OqZ6t+Si/cW+/rhUbxhPvzROaM7WI5qmULrSxkztpPZOPQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717793444; c=relaxed/simple;
	bh=4edDFU16SscgjTvFfEHCNUZGTUr5UkaEQsb95wg/Q7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lt5498NoK/FSsZfi7nzB7/XVRB1XrVUlSryjnPklZAuY2VdPusDCjSB83rYVIdsms2/OqFGJ1VGF00SujF4JwcdNlvpogZay0nNbna4MmvgDXLLwOIT9ceuspxwv1T07XTPV2Gs0qKdPaLGLLX9wnJ2t3y9EG75ItCXdbYVcZmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=llDtZoW6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f6c7cded01so14616675ad.0
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2024 13:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1717793441; x=1718398241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrZ3dz6aUDic7chld23PUqum1K+1mAl3YasIiZ6STBY=;
        b=llDtZoW69cFLRITGxaN7WxvZYwpaEljNzVQOA1v5OgGuKq+VYfaxy87BJsC7/c4QEZ
         vWlvE8xsIH2hjSEp0rCPrjdwDJLY5d/dPrODjHzFYZe6GFN8iB0S8y7puMIV8bf7LfNj
         NbfEfiAmk455EDg8sEtjQTwtWrbrnQ6Sl5XVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717793441; x=1718398241;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RrZ3dz6aUDic7chld23PUqum1K+1mAl3YasIiZ6STBY=;
        b=Vgf7S9B29Vo4IWgH8A/r22rAX1Ptkq2FA8Ud9MD0Utwn3rhazEPinXzA0yCJ7ydqOg
         9iMQrWueju18TC+HfYfqYuF5fHVTsxGB8p3ssQfc8KCEADd5ZrlsAAbbCuk8RE8+61ln
         GevwJ37HESJ2kJc7flAQcIN6IE4zCFS9G6OugOOfoFlEYStKZR/wkdJYq0Cq86arAEFS
         IxA8O9qJMGHIvhGlCKdOBe7Glhda1+DkUrsdtoUTMf2XymPTSC4xeuVTzfJqW6PCOZpn
         KeawKJ5BhRWoalskt+hZqDF1bizozpC9ISh5UCW9dcm1B550IvhIsBC84xPN3Ve2Ksvl
         /1KA==
X-Forwarded-Encrypted: i=1; AJvYcCUal1doVUnpQWc9cl8BHfc10F1dr3QrHwOgKM8TuvdC4lTH/uw6Zm+Qv1jUU+Ul7hcAyl6d7wx7orCr5wpAgH8kav8JgqLBgYjT/A==
X-Gm-Message-State: AOJu0YyUtaShlorSOD+oyV36ngag3OotN9iXufpvTcTeUSI99yFkPtj0
	krCyFNegsjj4f2S76445/0o+2mQueSU2F18Yvx9tNt2zqrFNg5X4pSukXM8qEak=
X-Google-Smtp-Source: AGHT+IG5M7/AsmT4aStR6H9xo8D2z1IaLt7oCthFxYQfkh+z4AGFvqdRYxJwc+BZzqD9oQtkSpZR1Q==
X-Received: by 2002:a17:902:da86:b0:1f4:8d7b:53d3 with SMTP id d9443c01a7336-1f6d0389123mr44070275ad.44.1717793440741;
        Fri, 07 Jun 2024 13:50:40 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6ee4ad6a5sm2601275ad.151.2024.06.07.13.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 13:50:40 -0700 (PDT)
Date: Fri, 7 Jun 2024 13:50:37 -0700
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
Subject: Re: [RFC net-next v4 2/2] net/mlx5e: Add per queue netdev-genl stats
Message-ID: <ZmNynahrAKOnC-Cu@LQ3V64L9R2>
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
References: <20240604004629.299699-1-jdamato@fastly.com>
 <20240604004629.299699-3-jdamato@fastly.com>
 <11b9c844-a56e-427f-aab3-3e223d41b165@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11b9c844-a56e-427f-aab3-3e223d41b165@gmail.com>

On Thu, Jun 06, 2024 at 11:11:57PM +0300, Tariq Toukan wrote:
> 
> 
> On 04/06/2024 3:46, Joe Damato wrote:
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
> This part is not true anymore.
> 
> > 
> > $ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
> >             --dump qstats-get --json '{"scope": "queue", "ifindex": 7}'
> > []
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >   .../net/ethernet/mellanox/mlx5/core/en_main.c | 138 ++++++++++++++++++
> >   1 file changed, 138 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > index d03fd1c98eb6..76d64bbcf250 100644
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
> > @@ -5279,6 +5280,142 @@ static bool mlx5e_tunnel_any_tx_proto_supported(struct mlx5_core_dev *mdev)
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
> > +	/* ptp was ever opened, is currently open, and channel index matches i
> > +	 * then export stats
> > +	 */
> > +	if (priv->rx_ptp_opened && priv->channels.ptp) {
> > +		if (test_bit(MLX5E_PTP_STATE_RX, priv->channels.ptp->state) &&
> > +		    priv->channels.ptp->rq.ix == i) {
> 
> PTP RQ index is naively assigned to zero:
> rq->ix           = MLX5E_PTP_CHANNEL_IX;
> 
> but this isn't to be used as the stats index.
> Today, the PTP-RQ has no matcing rxq in the kernel level.
> i.e. turning PTP-RQ on won't add a kernel-level RXQ to the
> real_num_rx_queues.
> Maybe we better do.
> If not, and the current state is kept, the best we can do is let the PTP-RQ
> naively contribute its queue-stat to channel 0.
> 
> > +			rq_stats = &priv->ptp_stats.rq;
> > +			stats->packets = rq_stats->packets;
> > +			stats->bytes = rq_stats->bytes;
> > +			stats->alloc_fail = rq_stats->buff_alloc_err;
> > +			return;
> > +		}
> > +	}
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
> > +	int i, tc;
> > +
> > +	ASSERT_RTNL();
> > +	if (!mlx5e_is_uplink_rep(priv)) {
> > +		rx->packets = 0;
> > +		rx->bytes = 0;
> > +		rx->alloc_fail = 0;
> > +
> > +		for (i = priv->channels.params.num_channels; i < priv->stats_nch; i++) {
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
> > +			/* if PTP was opened, but is not currently open, then
> > +			 * report the stats here. otherwise,
> > +			 * mlx5e_get_queue_stats_rx will get it
> > +			 */
> 
> We shouldn't care if the RQ is currently open. The stats are always there.
> This applies to all RQs and SQs.
> 
> > +			if (priv->channels.ptp &&
> > +			    !test_bit(MLX5E_PTP_STATE_RX, priv->channels.ptp->state)) {
> > +				struct mlx5e_rq_stats *rq_stats = &priv->ptp_stats.rq;
> > +
> > +				rx->packets += rq_stats->packets;
> > +				rx->bytes += rq_stats->bytes;
> > +			}
> > +		}
> > +	}
> > +
> > +	tx->packets = 0;
> > +	tx->bytes = 0;
> > +
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
> Even if the channel is not available, mlx5e_get_queue_stats_tx() accesses
> and returns its stats.

Thanks for your review; I do sincerely appreciate it.

I'm sorry, but either I'm misunderstanding something or I simply
disagree with you.

Imagine a simple case with 64 queues at boot, no QoS/HTB, no PTP.

At boot, [0..63] are the txq_ixs that will be passed in as i to
mlx5e_get_queue_stats_tx.

The user then reduces the queues to 4 via ethtool.

Now [0..3] are the txq_ixs that will be passed in as i to
mlx5e_get_queue_stats_tx.

In both cases: [0..real_num_tx_queues) are valid "i" that
mlx5e_get_queue_stats_tx will have stats for.

Now, consider the code for mlx5e_get_dcb_num_tc (from
drivers/net/ethernet/mellanox/mlx5/core/en.h):

  return params->mqprio.mode == TC_MQPRIO_MODE_DCB ?
         params->mqprio.num_tc : 1;

In our simple case calling mlx5e_get_dcb_num_tc returns 1.
In mlx5e_priv_init, the code sets priv->max_opened_tc = 1.

If we simply do a loop like this:

[0...stats->n_ch)
  [ mlx5e_get_dcb_num_tc ... max_opened_tc )
     [...collect_tx_stats...]

We won't collect any stats for channels 4..63 in our example above
because the inner loop because [1..1) which does nothing.

To confirm this, I tested the above loop anyway and the test script
showed that stats were missing:

  NETIF=eth4 tools/testing/selftests/drivers/net/stats.py

  # Exception| Exception: Qstats are lower, fetched later
  not ok 3 stats.pkt_byte_sum

I think the original code for TX stats in base for deactivated
queues may be correct.

Another way to explain the problem: any queue from [4..63] will be
gone, so we need to accumulate the stats from all TCs from 0 to
max_opened_tc (which in our example is 1).

Can you let me know if you agree? I would like to submit a real v5
which will include:
  - output PTP RX in base always if it was ever opened
  - output PTP TX in base only if it was ever opened and ptp is NULL
    or the bit is unset
  - leave the existing TX queue code in base from this RFC v4 (other
    than the changes to PTP TX)

Because in my tests using:

  NETIF=eth4 tools/testing/selftests/drivers/net/stats.py

shows that stats match:

KTAP version 1
1..4
ok 1 stats.check_pause
ok 2 stats.check_fec
ok 3 stats.pkt_byte_sum
ok 4 stats.qstat_by_ifindex
# Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0

> 
> > +		if (i < priv->channels.params.num_channels)
> > +			tc = mlx5e_get_dcb_num_tc(&priv->channels.params);
> > +		else
> > +			tc = 0;

My original code above and below maybe is not clear, but it is
saying:

  - for queues which have been deactivated, sum up all their TCs
    (since their txq_ix is no longer in the range of
    [0..real_num_tx_queues).

  - for queues which have NOT been deactivated, sum up all the
    inactive TCs.

Based on my tests, I believe this to be correct.

> > +		for (; tc < priv->max_opened_tc; tc++) {
> > +			struct mlx5e_sq_stats *sq_stats = &channel_stats->sq[tc];
> > +
> > +			tx->packets += sq_stats->packets;
> > +			tx->bytes += sq_stats->bytes;
> > +		}
> > +	}
> > +

