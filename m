Return-Path: <linux-rdma+bounces-2591-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4998CCD02
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2024 09:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADAFD1F2160C
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2024 07:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA0713C9DF;
	Thu, 23 May 2024 07:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYBbpD+W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1403CF51;
	Thu, 23 May 2024 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716449284; cv=none; b=QQyooO+GHvG8xGyfo9mrbD5xHFg6jTYmhZPS7soOClK4rjw/MCWKTOd8ux4HPzF/OjFCXNysaXEORIKNsBebCKPOkujmxhpEkMUk5Xb3cg7z8vNH+XVYGuF9c5tI8q/J66Ic6Ltq+eTGqt40zf98LJNnim2fiR7lU0MBLgbVMOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716449284; c=relaxed/simple;
	bh=dbQ1zA0hMCiYq0xZ6uYNu5O6nicAdG1uIGOE/78xGg0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=aFCArMI0x9BsbukLDLvm6pXN3W0Hgf0UF9sfsQrPu0a/hzJtLydQPBu6dk/tpdFM+qQm6BB8U+aWqioXrl2rMomMcO+TvBT5cCGLL0vG/+M6oYZp+8AvjdEPDpgbhEWdTFV16LWLRHjXLzr5A0cHqQ+cxRSQM5sThSCUDeqljWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYBbpD+W; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a623cf23927so113171866b.0;
        Thu, 23 May 2024 00:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716449280; x=1717054080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztK1B8LJ6Qg/XjmvoFi7X/nQ7NpaJ1m645YbkJDt3Lg=;
        b=UYBbpD+WnayzG3AsDhRv8IlOscuR6UJOyvLKTIDCCti80CE2Ba4XNSiw4cos9Sq8LE
         YptMEq6Ln1Y7BRYkLLyKAiVfnM9XhKejuWLQH0YH2kagg5erbqxZxDbA8bhzO4eJSHel
         40G7reVNu3FlJ5kgv+2Dnw2Ttchh0H+urdwlQabBmZwme5fiMOkMUypp7wdYlxHswfrh
         /dUg4auG9ekwMiubbMF9b9nwCll6rPhk+dEOjd2kLJiq+Ovp1GU+/hGLoMaWJCk1u51z
         UI5Q5nABLqs9tXm0kO5b+cIPh1xnjEGEfR9BENVOGMKQkf6eOkDVe+g4DOBBc2fmqQR/
         D9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716449280; x=1717054080;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ztK1B8LJ6Qg/XjmvoFi7X/nQ7NpaJ1m645YbkJDt3Lg=;
        b=NkyzHmmc34zjkHVqFC2cpqq3DJj1wCfKA7a3L1NfYwhJJcF2ZmKT+cmTBubmyhGeAQ
         +aKRHmMSulWYlzlV2OqmUImoEVSNSudswLQdxODNs6EB4qkGWnmTYxssG3whoqql3d3Z
         T9k37H/basCcOF1zut1RJ3OteV+td/xmOMZMuWEqCGPJgIfVK8+mNgMljV0+1tppFDMt
         74x2WU1L1Ozy2TUU+aW5LQSXkLwL7N1tPIN+k9bMmGlpFmWrrl7sVzwlte4SgSGPu+g/
         ayG2NYxPNZDlH+rwVMWxJRNKyBMWQNfAegPbPfROSiBb1JzhcIkSPQieJ8ywRSUNQCre
         kfPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzvZFcOlBjWgbqWbZT7S6zb6RhbSqeAKy64kuq/VjULInsEvLyVmM5RrBb2b/eLJiBHaW1sFQnuQy/8CDTFtZFJC7gVUSbZ8uaR+Qzfkrp88RbCBQLq2AtLbACXvg9xIa+LCd3VeQ4CDh2QmQXi24/1OuXKbJOy9NG0P0M7sXCeQ==
X-Gm-Message-State: AOJu0Yx1UFHI4Ry15f/2pJE3SdCiVDjZ85GRZSOaKHNGvJrRfcOc+3ny
	eHUs13qtbSY0HaEV2c21thbp9Dq6LiFhmXtxChst44XollW1tq/k
X-Google-Smtp-Source: AGHT+IEaLiBCRuYYgeVlPJ5W3rDX1Lckw/fQ21dksdMpOlIYZIyfTKGBXeI4xCT+g+32linp1GNZEg==
X-Received: by 2002:a17:907:130f:b0:a59:a3ad:c3f6 with SMTP id a640c23a62f3a-a623e8cb2bbmr106331366b.3.1716449280130;
        Thu, 23 May 2024 00:28:00 -0700 (PDT)
Received: from [172.27.49.176] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5cfbd73547sm952888366b.171.2024.05.23.00.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 00:27:59 -0700 (PDT)
Message-ID: <68225941-f3c3-4335-8f3d-edee43f59033@gmail.com>
Date: Thu, 23 May 2024 10:27:54 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tariq Toukan <ttoukan.linux@gmail.com>
Subject: Re: [PATCH net-next v2 1/1] net/mlx5e: Add per queue netdev-genl
 stats
To: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, zyjzyj2000@gmail.com, nalramli@fastly.com,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20240510041705.96453-1-jdamato@fastly.com>
 <20240510041705.96453-2-jdamato@fastly.com>
 <230701b9-c52a-4b59-9969-4cd5a5d697f4@gmail.com>
 <ZkRiBQXlWPPTNKFf@LQ3V64L9R2>
Content-Language: en-US
In-Reply-To: <ZkRiBQXlWPPTNKFf@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/05/2024 10:19, Joe Damato wrote:
> On Tue, May 14, 2024 at 09:44:37PM +0300, Tariq Toukan wrote:
>>
>>
>> On 10/05/2024 7:17, Joe Damato wrote:
>>> Add functions to support the netdev-genl per queue stats API.
>>>
>>> ./cli.py --spec netlink/specs/netdev.yaml \
>>> --dump qstats-get --json '{"scope": "queue"}'
>>>
>>> ...snip
>>>
>>>    {'ifindex': 7,
>>>     'queue-id': 62,
>>>     'queue-type': 'rx',
>>>     'rx-alloc-fail': 0,
>>>     'rx-bytes': 105965251,
>>>     'rx-packets': 179790},
>>>    {'ifindex': 7,
>>>     'queue-id': 0,
>>>     'queue-type': 'tx',
>>>     'tx-bytes': 9402665,
>>>     'tx-packets': 17551},
>>>
>>> ...snip
>>>
>>> Also tested with the script tools/testing/selftests/drivers/net/stats.py
>>> in several scenarios to ensure stats tallying was correct:
>>>
>>> - on boot (default queue counts)
>>> - adjusting queue count up or down (ethtool -L eth0 combined ...)
>>> - adding mqprio TCs
>>>
>>> Signed-off-by: Joe Damato <jdamato@fastly.com>
>>> ---
>>>    .../net/ethernet/mellanox/mlx5/core/en_main.c | 144 ++++++++++++++++++
>>>    1 file changed, 144 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>>> index ffe8919494d5..4a675d8b31b5 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>>> @@ -39,6 +39,7 @@
>>>    #include <linux/debugfs.h>
>>>    #include <linux/if_bridge.h>
>>>    #include <linux/filter.h>
>>> +#include <net/netdev_queues.h>
>>>    #include <net/page_pool/types.h>
>>>    #include <net/pkt_sched.h>
>>>    #include <net/xdp_sock_drv.h>
>>> @@ -5282,6 +5283,148 @@ static bool mlx5e_tunnel_any_tx_proto_supported(struct mlx5_core_dev *mdev)
>>>    	return (mlx5_vxlan_allowed(mdev->vxlan) || mlx5_geneve_tx_allowed(mdev));
>>>    }
>>> +static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
>>> +				     struct netdev_queue_stats_rx *stats)
>>> +{
>>> +	struct mlx5e_priv *priv = netdev_priv(dev);
>>> +
>>> +	if (mlx5e_is_uplink_rep(priv))
>>> +		return;
>>> +
>>> +	struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
>>> +	struct mlx5e_rq_stats *xskrq_stats = &channel_stats->xskrq;
>>> +	struct mlx5e_rq_stats *rq_stats = &channel_stats->rq;
>>> +
>>
>> Don't we allow variable declaration only at the beginning of a block?
>> Is this style accepted in the networking subsystem?
>>
>>> +	stats->packets = rq_stats->packets + xskrq_stats->packets;
>>> +	stats->bytes = rq_stats->bytes + xskrq_stats->bytes;
>>> +	stats->alloc_fail = rq_stats->buff_alloc_err +
>>> +			    xskrq_stats->buff_alloc_err;
>>> +}
>>> +
>>> +static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
>>> +				     struct netdev_queue_stats_tx *stats)
>>> +{
>>> +	struct mlx5e_priv *priv = netdev_priv(dev);
>>> +	struct net_device *netdev = priv->netdev;
>>> +	struct mlx5e_txqsq *sq;
>>> +	int j;
>>> +
>>> +	if (mlx5e_is_uplink_rep(priv))
>>> +		return;
>>> +
>>> +	for (j = 0; j < netdev->num_tx_queues; j++) {
>>> +		sq = priv->txq2sq[j];
>>
>> No sq instance in case interface is down.
> 
> This seems easily fixable by checking:
> 
>    priv->channels.num > 0
> 

yes, or test_bit(MLX5E_STATE_OPENED, &priv->state).

>> This should be a simple arithmetic calculation.
> 
> I'm not sure why I can't use txq2sq? Please see below for my
> explanation about why I think txq2sq might be all I need.
> 
>> Need to expose the proper functions for this calculation, and use it here
>> and in the sq create flows.
> 
> I re-read the code several times and my apologies, but I am probably
> still missing something.
> 
> I don't think a calculation function is necessary (see below), but
> if one is really needed, I'd probably add something like:
> 
>    static inline int tc_to_txq_ix(struct mlx5e_channel *c,
>                                   struct mlx5e_params *params,
>                                   int tc)
>    {
>           return c->ix + tc * params->num_channels;

We need the opposite direction.

The goal is to calculate the proper pair of (ch_ix, tc) in order to 
access the correct sq_stats struct in the stats array:
priv->channel_stats[ch_ix]->sq[tc];

Given i in [0, real_num_tx_queues), we should extract the pair as follows:

ch_ix = i % params->num_channels;
tc = i / params->num_channels;

>    }
> 
> And call it from mlx5e_open_sqs.
> 
> But, I don't understand why any calculation is needed in
> mlx5e_get_queue_stats_tx. Please see below for explanation.
> 
>>
>> Here it seems that you need a very involved user, so he passes the correct
>> index i of the SQ that he's interested in..
>>
>>> +		if (sq->ch_ix == i) {
>>
>> So you're looking for the first SQ on channel i?
>> But there might be multiple SQs on channel i...
>> Also, this SQ might be already included in the base stats.
>> In addition, this i might be too large for a channel index (num_tx_queues
>> can be 8 * num_channels)
>>
>> The logic here (of mapping from i in num_tx_queues to SQ stats) needs
>> careful definition.
> 
> I read your comments a few times and read the mlx5 source and I am
> probably still missing something obvious here; my apologies.
> 
> In net/core/netdev-genl.c, calls to the driver's get_queue_stats_tx
> appear to pass [0, netdev->real_num_tx_queues) as i.
> 
> I think this means i is a txq_ix in mlx5, because mlx5 sets
> netdev->real_num_tx_queues in mlx5e_update_tx_netdev_queues, as:
> 
>    nch * ntc + qos_queues
> 
> which when expanded is
> 
>    priv->channels.params.num_channels * mlx5e_get_dcb_num_tc + qos_queues
> 
> So, net/core/netdev-genl.c will be using 0 up to that expression as
> i when calling mlx5e_get_queue_stats_tx.
> 

Right.

> In mlx5:
>    - mlx5e_activate_priv_channels calls mlx5e_build_txq_maps which
>      generates priv->txq2sq[txq_ix] = sq for every mlx5e_get_dcb_num_tc
>      of every priv->channels.num.
>   
> This seems to happen every time mlx5e_activate_priv_channels is
> called, which I think means that priv->txq2sq is always up to date
> and will give the right sq for a given txq_ix (assuming the device
> isn't down).
> 

Right.

> Putting all of this together, I think that mlx5e_get_queue_stats_tx
> might need to be something like:
> 
>    mutex_lock(&priv->state_lock);
>    if (priv->channels.num > 0) {
>            sq = priv->txq2sq[i];
>            stats->packets = sq->stats->packets;
>            stats->bytes = sq->stats->bytes;
>    }
>    mutex_unlock(&priv->state_lock);
> 

Right.
But you can also access the sq_stats directly without going through the 
sq. This is important as the channels might be down.


> Is this still incorrect somehow?
> 
> If so, could you explain a bit more about why a calculation is
> needed? It seems like txq2sq would provide the mapping from txq_ix's
> (which is what mlx5e_get_queue_stats_tx gets as 'i') and an sq,
> which seems like all I would need?
> 
> Sorry if I am still not following here.
> 

I see two possible solutions:

1.
a. in the base, sum all stats for entries that are no longer available 
in the current configuration (independently to if the netdev is up or 
down), like sqs for ch_ix >= params->num_channels.
b. in mlx5e_get_queue_stats_tx, access the sq_stats without going 
through the sq (as it might not exist), this will be done for all i in 0 
ti real_num_tx_queues.

2.
a. in the base, sum all stats for all non existing sqs. if interface is 
down, then no sqs exist, so you sum the whole array.
b. in mlx5e_get_queue_stats_tx, go through the txq2sq and the sq, if it 
exists, if interface is down just return empty stats.

I don't have strong preference, although #1 looks slightly better to me.


>>> +			stats->packets = sq->stats->packets;
>>> +			stats->bytes = sq->stats->bytes;
>>> +			return;
>>> +		}
>>> +	}
>>> +}
>>> +
>>> +static void mlx5e_get_base_stats(struct net_device *dev,
>>> +				 struct netdev_queue_stats_rx *rx,
>>> +				 struct netdev_queue_stats_tx *tx)
>>> +{
>>> +	struct mlx5e_priv *priv = netdev_priv(dev);
>>> +	int i, j;
>>> +
>>> +	if (!mlx5e_is_uplink_rep(priv)) {
>>> +		rx->packets = 0;
>>> +		rx->bytes = 0;
>>> +		rx->alloc_fail = 0;
>>> +
>>> +		/* compute stats for deactivated RX queues
>>> +		 *
>>> +		 * if priv->channels.num == 0 the device is down, so compute
>>> +		 * stats for every queue.
>>> +		 *
>>> +		 * otherwise, compute only the queues which have been deactivated.
>>> +		 */
>>> +		if (priv->channels.num == 0)
>>> +			i = 0;
>>> +		else
>>> +			i = priv->channels.params.num_channels;
>>> +
>>> +		for (; i < priv->stats_nch; i++) {
>>> +			struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
>>> +			struct mlx5e_rq_stats *xskrq_stats = &channel_stats->xskrq;
>>> +			struct mlx5e_rq_stats *rq_stats = &channel_stats->rq;
>>> +
>>> +			rx->packets += rq_stats->packets + xskrq_stats->packets;
>>> +			rx->bytes += rq_stats->bytes + xskrq_stats->bytes;
>>> +			rx->alloc_fail += rq_stats->buff_alloc_err +
>>> +					  xskrq_stats->buff_alloc_err;
>>
>> Isn't this equivalent to mlx5e_get_queue_stats_rx(i) ?
>>
>>> +		}
>>> +
>>> +		if (priv->rx_ptp_opened) {
>>> +			struct mlx5e_rq_stats *rq_stats = &priv->ptp_stats.rq;
>>> +
>>> +			rx->packets += rq_stats->packets;
>>> +			rx->bytes += rq_stats->bytes;
>>> +		}
>>> +	}
>>> +
>>> +	tx->packets = 0;
>>> +	tx->bytes = 0;
>>> +
>>> +	/* three TX cases to handle:
>>> +	 *
>>> +	 * case 1: priv->channels.num == 0, get the stats for every TC
>>> +	 *         on every queue.
>>> +	 *
>>> +	 * case 2: priv->channel.num > 0, so get the stats for every TC on
>>> +	 *         every deactivated queue.
>>> +	 *
>>> +	 * case 3: the number of TCs has changed, so get the stats for the
>>> +	 *         inactive TCs on active TX queues (handled in the second loop
>>> +	 *         below).
>>> +	 */
>>> +	if (priv->channels.num == 0)
>>> +		i = 0;
>>> +	else
>>> +		i = priv->channels.params.num_channels;
>>> +
>>
>> All reads/writes to priv->channels must be under the priv->state_lock.
>>
>>> +	for (; i < priv->stats_nch; i++) {
>>> +		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
>>> +
>>> +		for (j = 0; j < priv->max_opened_tc; j++) {
>>> +			struct mlx5e_sq_stats *sq_stats = &channel_stats->sq[j];
>>> +
>>> +			tx->packets += sq_stats->packets;
>>> +			tx->bytes += sq_stats->bytes;
>>> +		}
>>> +	}
>>> +
>>> +	/* Handle case 3 described above. */
>>> +	for (i = 0; i < priv->channels.params.num_channels; i++) {
>>> +		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
>>> +		u8 dcb_num_tc = mlx5e_get_dcb_num_tc(&priv->channels.params);
>>> +
>>> +		for (j = dcb_num_tc; j < priv->max_opened_tc; j++) {
>>> +			struct mlx5e_sq_stats *sq_stats = &channel_stats->sq[j];
>>> +
>>> +			tx->packets += sq_stats->packets;
>>> +			tx->bytes += sq_stats->bytes;
>>> +		}
>>> +	}
>>> +
>>> +	if (priv->tx_ptp_opened) {
>>> +		for (j = 0; j < priv->max_opened_tc; j++) {
>>> +			struct mlx5e_sq_stats *sq_stats = &priv->ptp_stats.sq[j];
>>> +
>>> +			tx->packets    += sq_stats->packets;
>>> +			tx->bytes      += sq_stats->bytes;
>>> +		}
>>> +	}
>>> +}
>>> +
>>> +static const struct netdev_stat_ops mlx5e_stat_ops = {
>>> +	.get_queue_stats_rx     = mlx5e_get_queue_stats_rx,
>>> +	.get_queue_stats_tx     = mlx5e_get_queue_stats_tx,
>>> +	.get_base_stats         = mlx5e_get_base_stats,
>>> +};
>>> +
>>>    static void mlx5e_build_nic_netdev(struct net_device *netdev)
>>>    {
>>>    	struct mlx5e_priv *priv = netdev_priv(netdev);
>>> @@ -5299,6 +5442,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
>>>    	netdev->watchdog_timeo    = 15 * HZ;
>>> +	netdev->stat_ops          = &mlx5e_stat_ops;
>>>    	netdev->ethtool_ops	  = &mlx5e_ethtool_ops;
>>>    	netdev->vlan_features    |= NETIF_F_SG;

