Return-Path: <linux-rdma+bounces-2482-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5D98C5B4F
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 20:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20C32839E9
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 18:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34701180A92;
	Tue, 14 May 2024 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxlXg+37"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2808653E15;
	Tue, 14 May 2024 18:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715712284; cv=none; b=GC+Qe1972L8OhCHwIcJbJLhlBJGWrCybUVD5Y4KtNnzM3Qw2zwmONS5HMHzPUGW71PzXdfrtZzR3P6gxdylrhd107yRDLcIBdC/7/F4QzZdN2Q9T60TQB6uiR2EYXw17XvQZFGgW3Jw7y45Zxnpju7HMS1/fcJ072aF4e4Vu/vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715712284; c=relaxed/simple;
	bh=UDscADR9u6LgEe/wGP7v8bRZ2rHTG/ANDnBXplEUE7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g5i71el/6gmo8irL8YyP27mI0HBUBFWc2oEas5zZ1KK/utSS9zmudbr1ievppAET7Tl47//IB+wQiSu6Phv4CtMNibgaeX5HWAGVD/CClj0SrtRW//P8fcKuYOVWhZ/Ry5ckUSdtG4OOz6ufhKit3B1iMeShAHluKrsUmAYO1YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxlXg+37; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-351b683f2d8so2329318f8f.3;
        Tue, 14 May 2024 11:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715712280; x=1716317080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/O5pu7k8PMeR8Tslv1tJJZrDPiWbqXszC+oG6XWpEA=;
        b=WxlXg+37TknwB4WAYRsgA9RwstFYQ0Zvq0QMCqdxjVMjNvTMHENClOnrs0CBSGLhnR
         rIy/a2Hp8kRw1CR3KIZaITN3LffRxQoUcdpN4PBMNTL/b68It5lbA/etAtL2YEv0JMwO
         lpk7SBaWZKA9f4m9Z5IHbFkKCHZYTYSDyAQy58s4FbhLmrg/MfzftLj//sNzGbD0vWaQ
         IfXVZR79s4pHNE3rWvD+j3wLs0VvTQ9E0d6O5rrIfVNeCS8z9ZK58fW6mBza27idMdKA
         wl49Kg8SBRz18GqJ45LJiywt7PbcAjjsifWSNH9xLYqaF+ucXE3MVCSzmDDse3x2HvNv
         XInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715712280; x=1716317080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/O5pu7k8PMeR8Tslv1tJJZrDPiWbqXszC+oG6XWpEA=;
        b=RJs0ERZ8GIQhVJPvlegfgpCoVJfPeMl0C/SBGPQExRjAD9mRI45xYSqi1Mi0tdCF0C
         yJGlUfZJeuyS5q9S5Wt5gdha/VdzFOnkiwbxScJaE8x4hVjfcB8iHoK60HLWE8jFxJnq
         5J+lFKDvUaieGHI1PhS+mxr5gwJJky5LQoOzszNXHSQspE3OF6fXttL0hQ0XKP90S9Hx
         U/gizVzbusmA5hS9JHxW5WRz9DfPYwoppsVyjmb6GW2Fw9arICUu33N1XoNG9EJG4dj0
         rd8YJxGYxipxJyB+3Qe2SnMGlWIqduHR+/QD/bxkhOurAQBZqBUHQ/GNkx3rKefs4ZKT
         r2ng==
X-Forwarded-Encrypted: i=1; AJvYcCWbMyCwESLZYBU55xPARlRpqWWU969NC8ecpq3UnS5hrulZjzSD4U1/DCGl+tk/q18XLVCLuDxYs5dVd/DP/3fJkFhEZfu6dC7LNShYqRq2LkGjS8XlRJWDyKRBECuf9jR6fcxftgLedm1YoB9wnwvGLoO0MrsmPDpeJjIyuyL9Zw==
X-Gm-Message-State: AOJu0YzgkZIYu5iBrb7JIUsTrGmJH4eqZ3a8YRzKXZQ/Y96EREekVg4z
	t3VKEz7hFUuIUwGB/P/qt1Diawt1oDGJcVmR+VqiIcXBCetMYNLW
X-Google-Smtp-Source: AGHT+IGMIN9qFnqjKi3u+xD2Vr5ibU8JBFXZDR0ghnzjHuacTLO5rBFsv7foJ3TCpATudiNRzELejA==
X-Received: by 2002:a05:6000:18af:b0:351:b4af:c84b with SMTP id ffacd0b85a97d-351b4afc92emr8693915f8f.51.1715712280237;
        Tue, 14 May 2024 11:44:40 -0700 (PDT)
Received: from [172.27.21.185] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bc83sm14319687f8f.16.2024.05.14.11.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 11:44:39 -0700 (PDT)
Message-ID: <230701b9-c52a-4b59-9969-4cd5a5d697f4@gmail.com>
Date: Tue, 14 May 2024 21:44:37 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/1] net/mlx5e: Add per queue netdev-genl
 stats
To: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: zyjzyj2000@gmail.com, nalramli@fastly.com,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20240510041705.96453-1-jdamato@fastly.com>
 <20240510041705.96453-2-jdamato@fastly.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240510041705.96453-2-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/05/2024 7:17, Joe Damato wrote:
> Add functions to support the netdev-genl per queue stats API.
> 
> ./cli.py --spec netlink/specs/netdev.yaml \
> --dump qstats-get --json '{"scope": "queue"}'
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
> - adding mqprio TCs
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/en_main.c | 144 ++++++++++++++++++
>   1 file changed, 144 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index ffe8919494d5..4a675d8b31b5 100644
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
> @@ -5282,6 +5283,148 @@ static bool mlx5e_tunnel_any_tx_proto_supported(struct mlx5_core_dev *mdev)
>   	return (mlx5_vxlan_allowed(mdev->vxlan) || mlx5_geneve_tx_allowed(mdev));
>   }
>   
> +static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
> +				     struct netdev_queue_stats_rx *stats)
> +{
> +	struct mlx5e_priv *priv = netdev_priv(dev);
> +
> +	if (mlx5e_is_uplink_rep(priv))
> +		return;
> +
> +	struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
> +	struct mlx5e_rq_stats *xskrq_stats = &channel_stats->xskrq;
> +	struct mlx5e_rq_stats *rq_stats = &channel_stats->rq;
> +

Don't we allow variable declaration only at the beginning of a block?
Is this style accepted in the networking subsystem?

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
> +	struct net_device *netdev = priv->netdev;
> +	struct mlx5e_txqsq *sq;
> +	int j;
> +
> +	if (mlx5e_is_uplink_rep(priv))
> +		return;
> +
> +	for (j = 0; j < netdev->num_tx_queues; j++) {
> +		sq = priv->txq2sq[j];

No sq instance in case interface is down.
This should be a simple arithmetic calculation.
Need to expose the proper functions for this calculation, and use it 
here and in the sq create flows.

Here it seems that you need a very involved user, so he passes the 
correct index i of the SQ that he's interested in..

> +		if (sq->ch_ix == i) {

So you're looking for the first SQ on channel i?
But there might be multiple SQs on channel i...
Also, this SQ might be already included in the base stats.
In addition, this i might be too large for a channel index 
(num_tx_queues can be 8 * num_channels)

The logic here (of mapping from i in num_tx_queues to SQ stats) needs 
careful definition.

> +			stats->packets = sq->stats->packets;
> +			stats->bytes = sq->stats->bytes;
> +			return;
> +		}
> +	}
> +}
> +
> +static void mlx5e_get_base_stats(struct net_device *dev,
> +				 struct netdev_queue_stats_rx *rx,
> +				 struct netdev_queue_stats_tx *tx)
> +{
> +	struct mlx5e_priv *priv = netdev_priv(dev);
> +	int i, j;
> +
> +	if (!mlx5e_is_uplink_rep(priv)) {
> +		rx->packets = 0;
> +		rx->bytes = 0;
> +		rx->alloc_fail = 0;
> +
> +		/* compute stats for deactivated RX queues
> +		 *
> +		 * if priv->channels.num == 0 the device is down, so compute
> +		 * stats for every queue.
> +		 *
> +		 * otherwise, compute only the queues which have been deactivated.
> +		 */
> +		if (priv->channels.num == 0)
> +			i = 0;
> +		else
> +			i = priv->channels.params.num_channels;
> +
> +		for (; i < priv->stats_nch; i++) {
> +			struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
> +			struct mlx5e_rq_stats *xskrq_stats = &channel_stats->xskrq;
> +			struct mlx5e_rq_stats *rq_stats = &channel_stats->rq;
> +
> +			rx->packets += rq_stats->packets + xskrq_stats->packets;
> +			rx->bytes += rq_stats->bytes + xskrq_stats->bytes;
> +			rx->alloc_fail += rq_stats->buff_alloc_err +
> +					  xskrq_stats->buff_alloc_err;

Isn't this equivalent to mlx5e_get_queue_stats_rx(i) ?

> +		}
> +
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
> +	/* three TX cases to handle:
> +	 *
> +	 * case 1: priv->channels.num == 0, get the stats for every TC
> +	 *         on every queue.
> +	 *
> +	 * case 2: priv->channel.num > 0, so get the stats for every TC on
> +	 *         every deactivated queue.
> +	 *
> +	 * case 3: the number of TCs has changed, so get the stats for the
> +	 *         inactive TCs on active TX queues (handled in the second loop
> +	 *         below).
> +	 */
> +	if (priv->channels.num == 0)
> +		i = 0;
> +	else
> +		i = priv->channels.params.num_channels;
> +

All reads/writes to priv->channels must be under the priv->state_lock.

> +	for (; i < priv->stats_nch; i++) {
> +		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
> +
> +		for (j = 0; j < priv->max_opened_tc; j++) {
> +			struct mlx5e_sq_stats *sq_stats = &channel_stats->sq[j];
> +
> +			tx->packets += sq_stats->packets;
> +			tx->bytes += sq_stats->bytes;
> +		}
> +	}
> +
> +	/* Handle case 3 described above. */
> +	for (i = 0; i < priv->channels.params.num_channels; i++) {
> +		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
> +		u8 dcb_num_tc = mlx5e_get_dcb_num_tc(&priv->channels.params);
> +
> +		for (j = dcb_num_tc; j < priv->max_opened_tc; j++) {
> +			struct mlx5e_sq_stats *sq_stats = &channel_stats->sq[j];
> +
> +			tx->packets += sq_stats->packets;
> +			tx->bytes += sq_stats->bytes;
> +		}
> +	}
> +
> +	if (priv->tx_ptp_opened) {
> +		for (j = 0; j < priv->max_opened_tc; j++) {
> +			struct mlx5e_sq_stats *sq_stats = &priv->ptp_stats.sq[j];
> +
> +			tx->packets    += sq_stats->packets;
> +			tx->bytes      += sq_stats->bytes;
> +		}
> +	}
> +}
> +
> +static const struct netdev_stat_ops mlx5e_stat_ops = {
> +	.get_queue_stats_rx     = mlx5e_get_queue_stats_rx,
> +	.get_queue_stats_tx     = mlx5e_get_queue_stats_tx,
> +	.get_base_stats         = mlx5e_get_base_stats,
> +};
> +
>   static void mlx5e_build_nic_netdev(struct net_device *netdev)
>   {
>   	struct mlx5e_priv *priv = netdev_priv(netdev);
> @@ -5299,6 +5442,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
>   
>   	netdev->watchdog_timeo    = 15 * HZ;
>   
> +	netdev->stat_ops          = &mlx5e_stat_ops;
>   	netdev->ethtool_ops	  = &mlx5e_ethtool_ops;
>   
>   	netdev->vlan_features    |= NETIF_F_SG;

