Return-Path: <linux-rdma+bounces-2776-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB1C8D809B
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 13:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E2D1F22DC5
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 11:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD93083CD3;
	Mon,  3 Jun 2024 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDnlhFbw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603BE286A6;
	Mon,  3 Jun 2024 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717413081; cv=none; b=W4trmi/ZIjErOTv/pWOq0B9SL0u6EvqXHNSZ5EQoZtgjg1Sy2lXO2Ly4uA8a6Xm6rBf40DjEzLOZRHu3i6+C3mnRuX9byMRd0XpsA7MrDNQnKDrLLFetlZN3U2nphGLqfa48gAaDRHEBuMv/vsImH4VYm3ukEPsH8xX2h2qizQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717413081; c=relaxed/simple;
	bh=4R4RZwILrUT+/p7yjK315AWpXesvrl6b0LgHaaWF9Fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UmoDq2WXgVIsrRQAmAaOB3Me2UnT4Y/7hwQlmxqxjTNyEJ6e3Usu7hXz2oNXjxKQJrm6CQKUxhpsrvZNhGPDXsJRcZBVS0UQVId8C6QBi6i98TP2NpQ8uEEx3HoOrEQRJJVUl00lc5k7mR6rZFGf5aZlgFmuATuN0UGYJ//cMIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDnlhFbw; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e724bc466fso48634421fa.3;
        Mon, 03 Jun 2024 04:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717413077; x=1718017877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=21Ip7eqo28QVMy4KB0J5/yfczskOxmLqVxJkzM1gqtk=;
        b=GDnlhFbwfbFHicLE45mqZvkVNoUa4USVydMOEPKHrpTzHwKu9RzA7FoqAtngF6haqB
         RLZT3F75H0cmVFjsDSdMuD4OqN2EmmyA8Y1Q5LL23xFIm8oYSwSs1Vq2LYL82f8ncUbj
         UgcZ2qgxq/FTZOdqI+1JWRtsBT0cwr02XapQI2lH2E68EFsqgls0TA5XI/5P2A6tlJYf
         KulckX37tpCda1xvTIcI352oz44jbpVFHNppGIskIE0lE6WeQsHVvk4zVGSo8H6xLbX7
         /VtBfqXz/oyLotR3mtLZP7u1oBg+W1f0Ydh82d4i5vv0XWPSZ6oL1pW9p0yY7eX6FEeW
         mdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717413077; x=1718017877;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21Ip7eqo28QVMy4KB0J5/yfczskOxmLqVxJkzM1gqtk=;
        b=EYnHplOflTa7lraxXU8uHua2smM483gXi+ZgB9SqRomsK0q0ii+kdHxYjfkrX42sNf
         o35pA/xrzEttP60cKFP1l0DkFqRtxjrs+Jb6jrhKr9Z+oiKrY05uuQgkl4nvAy6DFzA/
         bWOSbVNmIfx80G46vAlITHRt71hveI4AmbBWRwldOvMyTRjfK4e2kbYkF5yiJfae424o
         exYAVwVyvpW+I4npORZL7Qqb1wIHiUeXEpW0GYX9jMs/VtI00+gLAIWTadJGC3Ifen1n
         4xsoDmwV1idYghkdI5NWdPRmqH6E+tjL4oVy8+5vqqORqUCiy8vYVAnRFjslRJy+RHxu
         ESUw==
X-Forwarded-Encrypted: i=1; AJvYcCXHRgnz7DqsRXk3cx0u3YVetvesjC4kx3sWaNUZLDpruw6SNN893uwW3ecMUx0TqqO/va9b+uWgEjN/7C3gOFJwQRDFEQXW9faaYSbnZ4EyksGIcHZubSJjHDcgJCIZbstP9wVcRTS+8PokUKemOYW4Hcc78Nd9U8+2XHJO1JvdBA==
X-Gm-Message-State: AOJu0YzHtH/rFhScIxV2bJjOGv/czQd6LBdt3u+Oe0bFanVskVaXi130
	IuLXdhYC9qTUscR0eeu1zt2e4JssMd3ggoBNnMR/hXCW5C5uMkDF
X-Google-Smtp-Source: AGHT+IGmC5yZg/ntzQ187WC9OjsjzxAFntpccGCb4SzAv6g1Jin8V2c+WCE8xou5INDzMNKuawpjag==
X-Received: by 2002:a2e:a787:0:b0:2da:a73:4f29 with SMTP id 38308e7fff4ca-2ea95181312mr77744711fa.30.1717413077175;
        Mon, 03 Jun 2024 04:11:17 -0700 (PDT)
Received: from [10.158.37.53] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b8a4c88sm115121525e9.31.2024.06.03.04.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 04:11:16 -0700 (PDT)
Message-ID: <eda43490-8d77-4d7d-9b24-1aafd073d760@gmail.com>
Date: Mon, 3 Jun 2024 14:11:14 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v3 2/2] net/mlx5e: Add per queue netdev-genl stats
To: Joe Damato <jdamato@fastly.com>, Tariq Toukan <ttoukan.linux@gmail.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, nalramli@fastly.com,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20240529031628.324117-1-jdamato@fastly.com>
 <20240529031628.324117-3-jdamato@fastly.com>
 <5b3a0f6a-5a03-45d7-ab10-1f1ba25504d3@gmail.com>
 <ZlzGjXxVD-JClqIy@LQ3V64L9R2>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <ZlzGjXxVD-JClqIy@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/06/2024 22:22, Joe Damato wrote:
> On Sun, Jun 02, 2024 at 12:14:21PM +0300, Tariq Toukan wrote:
>>
>>
>> On 29/05/2024 6:16, Joe Damato wrote:
>>> Add functions to support the netdev-genl per queue stats API.
>>>
>>> ./cli.py --spec netlink/specs/netdev.yaml \
>>>            --dump qstats-get --json '{"scope": "queue"}'
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
>>
>> Please test also with interface down.
> 
> OK. I'll test with the interface down.
> 
> Is there some publicly available Mellanox script I can run to test
> all the different cases? That would make this much easier. Maybe
> this is something to include in mlnx-tools on github?
> 

You're testing some new functionality. We don't have something for it.


> The mlnx-tools scripts that includes some python scripts for setting
> up QoS doesn't seem to work on my system, and outputs vague error
> messages. I have no idea if I'm missing some kernel option, if the
> device doesn't support it, or if I need some other dependency
> installed.
> 

Can you share the command you use, and the output?

> I have been testing these patches on a:
> 
> Mellanox Technologies MT28800 Family [ConnectX-5 Ex]
> firmware-version: 16.29.2002 (MT_0000000013)
> 
>>>
>>> Signed-off-by: Joe Damato <jdamato@fastly.com>
>>> ---
>>>    .../net/ethernet/mellanox/mlx5/core/en_main.c | 132 ++++++++++++++++++
>>>    1 file changed, 132 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>>> index ce15805ad55a..515c16a88a6c 100644
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
>>> @@ -5293,6 +5294,136 @@ static bool mlx5e_tunnel_any_tx_proto_supported(struct mlx5_core_dev *mdev)
>>>    	return (mlx5_vxlan_allowed(mdev->vxlan) || mlx5_geneve_tx_allowed(mdev));
>>>    }
>>> +static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
>>> +				     struct netdev_queue_stats_rx *stats)
>>> +{
>>> +	struct mlx5e_priv *priv = netdev_priv(dev);
>>> +	struct mlx5e_channel_stats *channel_stats;
>>> +	struct mlx5e_rq_stats *xskrq_stats;
>>> +	struct mlx5e_rq_stats *rq_stats;
>>> +
>>> +	if (mlx5e_is_uplink_rep(priv))
>>> +		return;
>>> +
>>> +	channel_stats = priv->channel_stats[i];
>>> +	xskrq_stats = &channel_stats->xskrq;
>>> +	rq_stats = &channel_stats->rq;
>>> +
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
>>> +	struct mlx5e_channel_stats *channel_stats;
>>> +	struct mlx5e_sq_stats *sq_stats;
>>> +	int ch_ix, tc_ix;
>>> +
>>> +	mutex_lock(&priv->state_lock);
>>> +	txq_ix_to_chtc_ix(&priv->channels.params, i, &ch_ix, &tc_ix);
>>> +	mutex_unlock(&priv->state_lock);
>>> +
>>> +	channel_stats = priv->channel_stats[ch_ix];
>>> +	sq_stats = &channel_stats->sq[tc_ix];
>>> +
>>> +	stats->packets = sq_stats->packets;
>>> +	stats->bytes = sq_stats->bytes;
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
>>> +		mutex_lock(&priv->state_lock);
>>> +		if (priv->channels.num == 0)
>>> +			i = 0;
>>
>> This is not consistent with the above implementation of
>> mlx5e_get_queue_stats_rx(), which always returns the stats even if the
>> channel is down.
>> This way, you'll double count the down channels.
>>
>> I think you should always start from priv->channels.params.num_channels.
> 
> OK, I'll do that.
> 
>>> +		else
>>> +			i = priv->channels.params.num_channels;
>>> +		mutex_unlock(&priv->state_lock);
>>
>> I understand that you're following the guidelines by taking the lock here, I
>> just don't think this improves anything... If channels can be modified in
>> between calls to mlx5e_get_base_stats / mlx5e_get_queue_stats_rx, then
>> wrapping the priv->channels access with a lock can help protect each single
>> deref, but not necessarily in giving a consistent "screenshot" of the stats.
>>
>> The rtnl_lock should take care of that, as the driver holds it when changing
>> the number of channels and updating the real_numrx/tx_queues.
>>
>> This said, I would carefully say you can drop the mutex once following the
>> requested changes above.

I still don't really like this design, so I gave some more thought on 
this...

I think we should come up with a new mapping array under priv, that maps 
i (from real_num_tx_queues) to the matching sq_stats struct.
This array would be maintained in the channels open/close functions, 
similarly to priv->txq2sq.

Then, we would not calculate the mapping per call, but just get the 
proper pointer from the array. This eases the handling of htb and ptp 
queues, which were missed in your txq_ix_to_chtc_ix().

This handles mapped SQs.

Now, regarding unmapped ones, they must be handled in the "base" 
function call.
We'd still need to access channels->params, to:
1. read params.num_channels to iterate until priv->stats_nch, and
2. read mlx5e_get_dcb_num_tc(params) to iterate until priv->max_opened_tc.

I think we can live with this without holding the mutex, given that this 
runs under the rtnl lock.
We can add ASSERT_RTNL() to verify the assumption.


> 
> OK, that makes sense to me.
> 
> So then I assume I can drop the mutex in mlx5e_get_queue_stats_tx
> above, as well, for the same reasons?
> 
> Does this mean then that you are in favor of the implementation for
> tx stats provided in this RFC and that I've implemented option 1 as
> you described in the previous thread correctly?
> 

Yes, but I wasn't happy enough with the design.
Thanks for your contribution.

>>> +
>>> +		for (; i < priv->stats_nch; i++) {
>>> +			struct netdev_queue_stats_rx rx_i = {0};
>>> +
>>> +			mlx5e_get_queue_stats_rx(dev, i, &rx_i);
>>> +
>>> +			rx->packets += rx_i.packets;
>>> +			rx->bytes += rx_i.bytes;
>>> +			rx->alloc_fail += rx_i.alloc_fail;
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
>>> +	mutex_lock(&priv->state_lock);
>>> +	for (i = 0; i < priv->stats_nch; i++) {
>>> +		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
>>> +
>>> +		/* while iterating through all channels [0, stats_nch], there
>>> +		 * are two cases to handle:
>>> +		 *
>>> +		 *  1. the channel is available, so sum only the unavailable TCs
>>> +		 *     [mlx5e_get_dcb_num_tc, max_opened_tc).
>>> +		 *
>>> +		 *  2. the channel is unavailable, so sum all TCs [0, max_opened_tc).
>>> +		 */
>>
>> I wonder why not call the local var 'tc'?
> 
> OK.
> 
>>> +		if (i < priv->channels.params.num_channels) {
>>> +			j = mlx5e_get_dcb_num_tc(&priv->channels.params);
>>> +		} else {
>>> +			j = 0;
>>> +		}
>>
>> Remove parenthesis, or use ternary op.
> 
> I'll remove the parenthesis; I didn't run checkpatch.pl on this RFC
> (which catches this), but I should have.
> 
>>> +
>>> +		for (; j < priv->max_opened_tc; j++) {
>>> +			struct mlx5e_sq_stats *sq_stats = &channel_stats->sq[j];
>>> +
>>> +			tx->packets += sq_stats->packets;
>>> +			tx->bytes += sq_stats->bytes;
>>> +		}
>>> +	}
>>> +	mutex_unlock(&priv->state_lock);
>>> +
>>
>> Same comment regarding dropping the mutex.
> 
> OK.


