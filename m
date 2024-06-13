Return-Path: <linux-rdma+bounces-3138-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AF4907D6B
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 22:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF05F1F24EA5
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 20:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA0913B79F;
	Thu, 13 Jun 2024 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjbpaAO3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4974A13B58D;
	Thu, 13 Jun 2024 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718310321; cv=none; b=DICAD/XdaLMjS1JDpzCKYhSGK1KmCBHeqoHnsDcrA0ArTEqFyeKNVdBBIp7KSCLBG/8WNMBQ8/5UaDmbNSpTQSzykD23+0igF5Gsq+u26O9zB3jeKZMEZnZb0vEMSx5UqQgWdmEvUXaE535ND84KGZOXkTxEkNkvNSi8kpZZCyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718310321; c=relaxed/simple;
	bh=aeMLay8i4NsKgP0LOn95MHQNcoA2AKoBGvyJgOjt0Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uyXqO6TjePRiNDUftBzJIKNsAwWTwhyVzcyt5yCBZu2MvAouoi3CTJ+oPxA+ZZM9lVlduZEC8JMyisyXFVddf+Z8GXFXGxnP32oHos43s2Xyr7yzznDeN3OSvh8VbPQXWfKwi4CVQpVPqq2e6x4LJE8eANPF0AbXpiw2E9OhRtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjbpaAO3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-35f275c7286so1355609f8f.2;
        Thu, 13 Jun 2024 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718310317; x=1718915117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JaWEM6FspP0EqCmF01vFOUDfdPfoCTNfZWMLyihObFk=;
        b=JjbpaAO3HLWsam7jSt5jiUgUYPwghNq9o3H29Id4/GZAqxWezYD0VEaDmm6NKvPriN
         iRd3kwsnYW1oZ3HZMnNPXdDjmuRlG5TuXy0RgVfi0Fz+UMamX88CCuMhiVp8/9kNISVc
         2cJojisspENHtCALQNQomGrLaFSDYXG06Bt4uyRDQiR8SuG4xH41qBg6sU+7hc5iz1/N
         CWH/JEPx7YfIDHv7t/pyc1pet46vluExzJWQsppsKCl3SCtuGLJ99LGF97sxIy/+Cqho
         OJnZ/h+Co4uCiqOW+YqO/pAt9XHft4er8FUGZY8DQFJxOQzpDPd3fhO0bNCpSPHiQjrW
         L23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718310317; x=1718915117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JaWEM6FspP0EqCmF01vFOUDfdPfoCTNfZWMLyihObFk=;
        b=e3QD1DJ/NJazGAS3CBhAYF04oSNCcOYsAtuA37UOJyrwvH4Cu+oRDLURcGUzyTnAMn
         1s+wnDIWjVmQhbrIjVOfvz2ZaWastu867x3l3572CROa1Hmg09RLWFJ23ggZdeo6QyyY
         QXy4hSAfNFEns64oONiYQPwHuv3tSCwUmR9TrI5WuFkkAorqD4AdCo5l5MofwU7XGDaI
         l9ZpxDMX/UL45hZ9U9w0fCkzwH5fgddCeCiENYSumYPPY1BqmMupJZvMzBXubTBpySfY
         9fnU3Js8+0Mx4H7/zzAHHeNQXYWr1KowAiKRxfEoEXg+jzCAqTE/8W2vTnA+rBgn+vcJ
         babQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5dlw7kcfjF1Vq0VPw60zZMjrAZnGBbGnMjXJ+30NjJFw6OpN7Oj2/nNjc1/KcxBagWpekOlRG1DlsDTzmPlvmPvd0DVJrLFYqfuyKqj3yparjSPEiG78+RiD6jAZ8ZqxJTjeQDBZmdhZEY0wwEOqTk3yK+0IcsHx1oXPv98ocmw==
X-Gm-Message-State: AOJu0Yy3wpVyjmJzh83R+eS6EBATR0AoPOnaVY/boahafl+8Hw1w+iIV
	3ae1ddnc9sKBIL7Di1Tqxj1zkLJvonh6vWRm6daLc9zlcHIqHJ6kHsrykA==
X-Google-Smtp-Source: AGHT+IFndKZEGCtJv7YaMhXQ0H7se140EG516reCX+msCBPC8bQcr0uo3JJ/JvzlWzS0l5sr4Dn7wA==
X-Received: by 2002:adf:fd03:0:b0:35f:2760:aaa0 with SMTP id ffacd0b85a97d-3607a786b07mr639855f8f.65.1718310317306;
        Thu, 13 Jun 2024 13:25:17 -0700 (PDT)
Received: from [172.27.34.78] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f2241sm2580999f8f.81.2024.06.13.13.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 13:25:16 -0700 (PDT)
Message-ID: <0a38f58a-2b1e-4d78-90e1-eb8539f65306@gmail.com>
Date: Thu, 13 Jun 2024 23:25:12 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v5 2/2] net/mlx5e: Add per queue netdev-genl stats
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: nalramli@fastly.com, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20240612200900.246492-1-jdamato@fastly.com>
 <20240612200900.246492-3-jdamato@fastly.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240612200900.246492-3-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/06/2024 23:08, Joe Damato wrote:
> ./cli.py --spec netlink/specs/netdev.yaml \
>           --dump qstats-get --json '{"scope": "queue"}'
> 
> ...snip
> 
>   {'ifindex': 7,
>    'queue-id': 62,
>    'queue-type': 'rx',
>    'rx-alloc-fail': 0,
>    'rx-bytes': 105965251,
>    'rx-packets': 179790},
>   {'ifindex': 7,
>    'queue-id': 0,
>    'queue-type': 'tx',
>    'tx-bytes': 9402665,
>    'tx-packets': 17551},
> 
> ...snip
> 
> Also tested with the script tools/testing/selftests/drivers/net/stats.py
> in several scenarios to ensure stats tallying was correct:
> 
> - on boot (default queue counts)
> - adjusting queue count up or down (ethtool -L eth0 combined ...)
> 
> The tools/testing/selftests/drivers/net/stats.py brings the device up,
> so to test with the device down, I did the following:
> 
> $ ip link show eth4
> 7: eth4: <BROADCAST,MULTICAST> mtu 9000 qdisc mq state DOWN [..snip..]
>    [..snip..]
> 
> $ cat /proc/net/dev | grep eth4
> eth4: 235710489  434811 [..snip rx..] 2878744 21227  [..snip tx..]
> 
> $ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
>             --dump qstats-get --json '{"ifindex": 7}'
> [{'ifindex': 7,
>    'rx-alloc-fail': 0,
>    'rx-bytes': 235710489,
>    'rx-packets': 434811,
>    'tx-bytes': 2878744,
>    'tx-packets': 21227}]
> 
> Compare the values in /proc/net/dev match the output of cli for the same
> device, even while the device is down.
> 
> Note that while the device is down, per queue stats output nothing
> (because the device is down there are no queues):

Yeah, the query doesn't reach the device driver...

> 
> $ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
>             --dump qstats-get --json '{"scope": "queue", "ifindex": 7}'
> []
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/en_main.c | 132 ++++++++++++++++++
>   1 file changed, 132 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index c548e2fdc58f..d3f38b4b18eb 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -39,6 +39,7 @@
>   #include <linux/debugfs.h>
>   #include <linux/if_bridge.h>
>   #include <linux/filter.h>
> +#include <net/netdev_queues.h>
>   #include <net/page_pool/types.h>
>   #include <net/pkt_sched.h>
>   #include <net/xdp_sock_drv.h>
> @@ -5299,6 +5300,136 @@ static bool mlx5e_tunnel_any_tx_proto_supported(struct mlx5_core_dev *mdev)
>   	return (mlx5_vxlan_allowed(mdev->vxlan) || mlx5_geneve_tx_allowed(mdev));
>   }
>   
> +static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
> +				     struct netdev_queue_stats_rx *stats)
> +{
> +	struct mlx5e_priv *priv = netdev_priv(dev);
> +	struct mlx5e_channel_stats *channel_stats;
> +	struct mlx5e_rq_stats *xskrq_stats;
> +	struct mlx5e_rq_stats *rq_stats;
> +
> +	ASSERT_RTNL();
> +	if (mlx5e_is_uplink_rep(priv))
> +		return;
> +
> +	channel_stats = priv->channel_stats[i];
> +	xskrq_stats = &channel_stats->xskrq;
> +	rq_stats = &channel_stats->rq;
> +
> +	stats->packets = rq_stats->packets + xskrq_stats->packets;
> +	stats->bytes = rq_stats->bytes + xskrq_stats->bytes;
> +	stats->alloc_fail = rq_stats->buff_alloc_err +
> +			    xskrq_stats->buff_alloc_err;
> +}
> +
> +static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
> +				     struct netdev_queue_stats_tx *stats)
> +{
> +	struct mlx5e_priv *priv = netdev_priv(dev);
> +	struct mlx5e_sq_stats *sq_stats;
> +
> +	ASSERT_RTNL();
> +	/* no special case needed for ptp htb etc since txq2sq_stats is kept up
> +	 * to date for active sq_stats, otherwise get_base_stats takes care of
> +	 * inactive sqs.
> +	 */
> +	sq_stats = priv->txq2sq_stats[i];
> +	stats->packets = sq_stats->packets;
> +	stats->bytes = sq_stats->bytes;
> +}
> +
> +static void mlx5e_get_base_stats(struct net_device *dev,
> +				 struct netdev_queue_stats_rx *rx,
> +				 struct netdev_queue_stats_tx *tx)
> +{
> +	struct mlx5e_priv *priv = netdev_priv(dev);
> +	struct mlx5e_ptp *ptp_channel;
> +	int i, tc;
> +
> +	ASSERT_RTNL();
> +	if (!mlx5e_is_uplink_rep(priv)) {
> +		rx->packets = 0;
> +		rx->bytes = 0;
> +		rx->alloc_fail = 0;
> +
> +		for (i = priv->channels.params.num_channels; i < priv->stats_nch; i++) {

IIUC, per the current kernel implementation, the lower parts won't be 
completed in a loop over [0..real_num_rx_queues-1], as that loop is 
conditional, happening only if the queues are active.

I would like the kernel to drop that condition, and stop forcing the 
device driver to conditionally include this part in the base.

Otherwise, the lower parts need to be added here.

> +			struct netdev_queue_stats_rx rx_i = {0};
> +
> +			mlx5e_get_queue_stats_rx(dev, i, &rx_i);
> +
> +			rx->packets += rx_i.packets;
> +			rx->bytes += rx_i.bytes;
> +			rx->alloc_fail += rx_i.alloc_fail;
> +		}
> +
> +		/* always report PTP RX stats from base as there is no
> +		 * corresponding channel to report them under in
> +		 * mlx5e_get_queue_stats_rx.
> +		 */
> +		if (priv->rx_ptp_opened) {
> +			struct mlx5e_rq_stats *rq_stats = &priv->ptp_stats.rq;
> +
> +			rx->packets += rq_stats->packets;
> +			rx->bytes += rq_stats->bytes;
> +		}
> +	}
> +
> +	tx->packets = 0;
> +	tx->bytes = 0;
> +
> +	for (i = 0; i < priv->stats_nch; i++) { > +		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
> +
> +		/* handle two cases:
> +		 *
> +		 *  1. channels which are active. In this case,
> +		 *     report only deactivated TCs on these channels.
> +		 *
> +		 *  2. channels which were deactivated
> +		 *     (i > priv->channels.params.num_channels)
> +		 *     must have all of their TCs [0 .. priv->max_opened_tc)
> +		 *     examined because deactivated channels will not be in the
> +		 *     range of [0..real_num_tx_queues) and will not have their
> +		 *     stats reported by mlx5e_get_queue_stats_tx.
> +		 */
> +		if (i < priv->channels.params.num_channels)
> +			tc = mlx5e_get_dcb_num_tc(&priv->channels.params);
> +		else
> +			tc = 0;
> +
> +		for (; tc < priv->max_opened_tc; tc++) {
> +			struct mlx5e_sq_stats *sq_stats = &channel_stats->sq[tc];
> +
> +			tx->packets += sq_stats->packets;
> +			tx->bytes += sq_stats->bytes;
> +		}

Again, what about the lower part in case queues are not active?

> +	}
> +
> +	/* if PTP TX was opened at some point and has since either:
> +	 *    -  been shutdown and set to NULL, or
> +	 *    -  simply disabled (bit unset)
> +	 *
> +	 * report stats directly from the ptp_stats structures as these queues
> +	 * are now unavailable and there is no txq index to retrieve these
> +	 * stats via calls to mlx5e_get_queue_stats_tx.
> +	 */
> +	ptp_channel = priv->channels.ptp;
> +	if (priv->tx_ptp_opened && (!ptp_channel || !test_bit(MLX5E_PTP_STATE_TX, ptp_channel->state))) {
> +		for (tc = 0; tc < priv->max_opened_tc; tc++) {
> +			struct mlx5e_sq_stats *sq_stats = &priv->ptp_stats.sq[tc];
> +
> +			tx->packets += sq_stats->packets;
> +			tx->bytes   += sq_stats->bytes;
> +		}
> +	}
> +}
> +
> +static const struct netdev_stat_ops mlx5e_stat_ops = {
> +	.get_queue_stats_rx  = mlx5e_get_queue_stats_rx,
> +	.get_queue_stats_tx  = mlx5e_get_queue_stats_tx,
> +	.get_base_stats      = mlx5e_get_base_stats,
> +};
> +
>   static void mlx5e_build_nic_netdev(struct net_device *netdev)
>   {
>   	struct mlx5e_priv *priv = netdev_priv(netdev);
> @@ -5316,6 +5447,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
>   
>   	netdev->watchdog_timeo    = 15 * HZ;
>   
> +	netdev->stat_ops	  = &mlx5e_stat_ops;
>   	netdev->ethtool_ops	  = &mlx5e_ethtool_ops;
>   
>   	netdev->vlan_features    |= NETIF_F_SG;

