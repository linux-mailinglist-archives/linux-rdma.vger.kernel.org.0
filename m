Return-Path: <linux-rdma+bounces-9326-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A77B2A841A8
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 13:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC1C1B68123
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 11:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04BA28152C;
	Thu, 10 Apr 2025 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT+KE4ZW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05217267F7E;
	Thu, 10 Apr 2025 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744284236; cv=none; b=H3XQGp1lqidAqCzJz5scq7kaliXEoum0Ueo/Yd7Q7g6ZeDNDxO3DqArIaWSer1jiRoyW0RKERChMe6Bm5WBMnxQCCjsuDPOStoZzEN8nXxiFi+lkM0qoy9c16Kigxau4pi+nmA1IngjV/QXtuNGrnEUygbfO39Q4iO9v2uqUBKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744284236; c=relaxed/simple;
	bh=epOpMM/dBNxdF5p4fy5SLoOCG/BguvRFHnRZal15y4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMacnzmQGfHNDZyoo7c6yidkN9LZS0R/yUE2KDQm/rMySV57SGUTrcJbpXLixAibztex5EV8HDock034fm3DPbz65gi64kAfYJW8tD/LtBc/Ah+0ziPkuW5QCIYnvU6CUdXzXA5bk95cPHIauTk76ofVqeVDglvo4C3XSAyrHMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UT+KE4ZW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso4569625e9.0;
        Thu, 10 Apr 2025 04:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744284232; x=1744889032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cE8qteQvDhLPOACFzZtBhkb2OObZjn2MlvFs24dgPes=;
        b=UT+KE4ZWcQwUGAl8sB3tm4qK3Qd/vG087AAUvGAzLGuPZeVFRkZFl+cHolpMThKxte
         LmDr2R5UbAYYpN/YsdgtL/AloYL0vza4klam47C5tSJPg4Rj21XnzPCWNrSB7fXU5UJg
         fPvwVygP6YBH8mMzxtbonkYyEqJpmYJPxd3cZmNsZF6yetjN98V/XIrOI+HXOG4Wld92
         pr+aO0yhX0b4ywUpBSsBE5Wn/yxiDaIpdOp+kMLh3VkknSQ5DDkFw4p1Z9AnzpCMWjci
         Tk0cxczK7KzKNQSOrCQDrG9cz6I9EJCnoqWar4eAay75II0Ti8hh2xQmLb66L0pefew2
         S6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744284232; x=1744889032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cE8qteQvDhLPOACFzZtBhkb2OObZjn2MlvFs24dgPes=;
        b=jzjzXTLhLVKdBTfVs3EYhQoOKl3PlPgAYjbvWj5yOAjZmJQ5kiBNKziCDL7g8feZGx
         XOabmBV9Idbx3jyK/uKE9GK9r5lAHQ7i6GOrCjI5AdGj9Ir3ZqAimQLfWGuQigLxlpFa
         bolFnGH5JvSCNJ7aM7pLmOmajIxCUSC2XWTnkvwtXM6CiXHWmYxMn79hLtirFqBlu853
         1AKfv1kmg1mVfSkIIYjbaQvMIK4mDIczZZvnmzVQhKaS6MhkfF4C160ShHEu+D1wMdfl
         wl350gkPOzrUTB6kSlhPPRkp3tAfb9tdYtAaEH17qxImp+h8EaLdqVpuuMEP1T6hfaPL
         /UWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN4LmcM+1UDM1CY2ujrarBHq1GP1rVGA1h0ECBYfchRMZ0PBbjsRWXfiLA23kZF3Fc98hsV6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmZUoAgIdS5CLKv2MtdO9iZQaQq55wi7MsW1U66qr5VxaGlF/0
	MCnxII/axwqwqCG3L5ujZTJNzR36VHLRBfQ8p/IJVklnK2fKgW0i
X-Gm-Gg: ASbGncu+h+iz38pagG39tipdu20YvlkSR+pGpN85VXTdaTslm+0lZOQxuzqCsFZ8x5g
	gav6duZl2eRQKjFan0bXau07yqYkgT5U8CHHkVnkadBsjHN8mzw15ywPqi6vlVRaHoVx37qKddw
	6ADH4cJ1npxt1B6jXSDqdzG5FwHfWhAUvx71WZGXrEfEUdYOIAnGlCo5pBIsk5go+1ft11NbUkL
	1aigJ+6rx5bUZn/IyktpEjZpKhR7oXroEgTHrvH/wKhovaHf3RV6POyyrVrnKcL3swefT4M+ynG
	RyBqtZ9LXXa2LlsG+8OOvCDx54cXwOUrKoFEQD/FPBN/Von3Ol8Aqk7wt+VWPA==
X-Google-Smtp-Source: AGHT+IEHhr2XmOoZg5aQW94nClb60aQTI0phxKGlcAyxQgPokO6OTWacxs7YBRsNz/mq1X+yMNtZKQ==
X-Received: by 2002:a05:600c:54ed:b0:43c:f680:5c2e with SMTP id 5b1f17b1804b1-43f2eb960b7mr17840745e9.13.1744284231664;
        Thu, 10 Apr 2025 04:23:51 -0700 (PDT)
Received: from [172.27.55.156] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f20a9f14csm32279365e9.1.2025.04.10.04.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 04:23:51 -0700 (PDT)
Message-ID: <412ced78-ede0-4a95-926e-e0dacd97caf5@gmail.com>
Date: Thu, 10 Apr 2025 14:23:48 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/4] mlnx5: Use generic code for page_pool
 statistics.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rdma@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Joe Damato <jdamato@fastly.com>, Leon Romanovsky <leon@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>, Yunsheng Lin <linyunsheng@huawei.com>
References: <20250408105922.1135150-1-bigeasy@linutronix.de>
 <20250408105922.1135150-2-bigeasy@linutronix.de>
 <62687af5-32cd-4400-b51f-c956125aaee9@gmail.com>
 <20250410085849.mdLSesgJ@linutronix.de>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250410085849.mdLSesgJ@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/04/2025 11:58, Sebastian Andrzej Siewior wrote:
> On 2025-04-10 10:16:54 [+0300], Tariq Toukan wrote:
>> Thanks for your patch.
>>
>> Was this tested?
>> Were you able to run with mlx5 device?
> 
> Kind of. The device does optical and I have nothing to bring up the
> link, a few gbic did not work so the guys gave up back then. On link up
> the driver sets up buffers so I saw that the stats incrementing and the
> numbers queries with ethtool made sense.
> 
>>>    .../ethernet/mellanox/mlx5/core/en_stats.c    | 97 ++++++++-----------
>>>    .../ethernet/mellanox/mlx5/core/en_stats.h    | 26 +----
>>>    2 files changed, 43 insertions(+), 80 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
>>> index 1c121b435016d..54303877adb1d 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
>>> @@ -194,17 +194,6 @@ static const struct counter_desc sw_stats_desc[] = {
>>>    	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_arfs_err) },
>>>    #endif
>>>    	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_recover) },
>>> -	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_fast) },
>>> -	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_slow) },
>>> -	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_slow_high_order) },
>>> -	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_empty) },
>>> -	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_refill) },
>>> -	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_waive) },
>>> -	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_cached) },
>>> -	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_cache_full) },
>>> -	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_ring) },
>>> -	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_ring_full) },
>>> -	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_released_ref) },
>>>    #ifdef CONFIG_MLX5_EN_TLS
>>>    	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_tls_decrypted_packets) },
>>>    	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_tls_decrypted_bytes) },
>>> @@ -253,7 +242,7 @@ static const struct counter_desc sw_stats_desc[] = {
>>>    static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(sw)
>>>    {
>>> -	return NUM_SW_COUNTERS;
>>> +	return NUM_SW_COUNTERS + page_pool_ethtool_stats_get_count();
>>>    }
>>>    static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(sw)
>>> @@ -262,6 +251,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(sw)
>>>    	for (i = 0; i < NUM_SW_COUNTERS; i++)
>>>    		ethtool_puts(data, sw_stats_desc[i].format);
>>> +	*data = page_pool_ethtool_stats_get_strings(*data);
>>>    }
>>>    static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(sw)
>>> @@ -272,6 +262,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(sw)
>>>    		mlx5e_ethtool_put_stat(data,
>>>    				       MLX5E_READ_CTR64_CPU(&priv->stats.sw,
>>>    							    sw_stats_desc, i));
>>> +	*data = page_pool_ethtool_stats_get(*data, &priv->stats.sw.page_pool_stats);
>>>    }
>>>    static void mlx5e_stats_grp_sw_update_stats_xdp_red(struct mlx5e_sw_stats *s,
>>> @@ -373,17 +364,6 @@ static void mlx5e_stats_grp_sw_update_stats_rq_stats(struct mlx5e_sw_stats *s,
>>>    	s->rx_arfs_err                += rq_stats->arfs_err;
>>>    #endif
>>>    	s->rx_recover                 += rq_stats->recover;
>>> -	s->rx_pp_alloc_fast          += rq_stats->pp_alloc_fast;
>>> -	s->rx_pp_alloc_slow          += rq_stats->pp_alloc_slow;
>>> -	s->rx_pp_alloc_empty         += rq_stats->pp_alloc_empty;
>>> -	s->rx_pp_alloc_refill        += rq_stats->pp_alloc_refill;
>>> -	s->rx_pp_alloc_waive         += rq_stats->pp_alloc_waive;
>>> -	s->rx_pp_alloc_slow_high_order		+= rq_stats->pp_alloc_slow_high_order;
>>> -	s->rx_pp_recycle_cached			+= rq_stats->pp_recycle_cached;
>>> -	s->rx_pp_recycle_cache_full		+= rq_stats->pp_recycle_cache_full;
>>> -	s->rx_pp_recycle_ring			+= rq_stats->pp_recycle_ring;
>>> -	s->rx_pp_recycle_ring_full		+= rq_stats->pp_recycle_ring_full;
>>> -	s->rx_pp_recycle_released_ref		+= rq_stats->pp_recycle_released_ref;
>>>    #ifdef CONFIG_MLX5_EN_TLS
>>>    	s->rx_tls_decrypted_packets   += rq_stats->tls_decrypted_packets;
>>>    	s->rx_tls_decrypted_bytes     += rq_stats->tls_decrypted_bytes;
>>> @@ -490,27 +470,13 @@ static void mlx5e_stats_grp_sw_update_stats_qos(struct mlx5e_priv *priv,
>>>    	}
>>>    }
>>> -static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_channel *c)
>>> +static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_sw_stats *s,
>>> +						  struct mlx5e_channel *c)
>>
>> This per-RQ function should not get the general SW status struct and write
>> to it.
>>
>> Gathering stats from all RQs into the general SW stats should not be done
>> here.
> 
> but I have to sum it for the global stats. The old code queried the
> channels again for the global stats. This queries the channels twice,
> once for per-channel and again for the global stats.
> 

This changes the function role.
Keep the separation.

>>>    {
>>>    	struct mlx5e_rq_stats *rq_stats = c->rq.stats;
>>> -	struct page_pool *pool = c->rq.page_pool;
>>> -	struct page_pool_stats stats = { 0 };
>>> -	if (!page_pool_get_stats(pool, &stats))
>>> -		return;
>>> -
>>> -	rq_stats->pp_alloc_fast = stats.alloc_stats.fast;
>>> -	rq_stats->pp_alloc_slow = stats.alloc_stats.slow;
>>> -	rq_stats->pp_alloc_slow_high_order = stats.alloc_stats.slow_high_order;
>>> -	rq_stats->pp_alloc_empty = stats.alloc_stats.empty;
>>> -	rq_stats->pp_alloc_waive = stats.alloc_stats.waive;
>>> -	rq_stats->pp_alloc_refill = stats.alloc_stats.refill;
>>> -
>>> -	rq_stats->pp_recycle_cached = stats.recycle_stats.cached;
>>> -	rq_stats->pp_recycle_cache_full = stats.recycle_stats.cache_full;
>>> -	rq_stats->pp_recycle_ring = stats.recycle_stats.ring;
>>> -	rq_stats->pp_recycle_ring_full = stats.recycle_stats.ring_full;
>>> -	rq_stats->pp_recycle_released_ref = stats.recycle_stats.released_refcnt;
>>> +	page_pool_get_stats(c->rq.page_pool, &s->page_pool_stats);
>>> +	page_pool_get_stats(c->rq.page_pool, &rq_stats->page_pool_stats);

Also, what do you acheive here when reading the per-RQ pp stats into 
&s->page_pool_stats? isn't this immediately overwritten by the next 
iteration? They do not accumulate.

>>>    }
>>>    static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(sw)
>>> @@ -520,15 +486,13 @@ static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(sw)
>>>    	memset(s, 0, sizeof(*s));
>>> -	for (i = 0; i < priv->channels.num; i++) /* for active channels only */
>>> -		mlx5e_stats_update_stats_rq_page_pool(priv->channels.c[i]);
>>> -
>>>    	for (i = 0; i < priv->stats_nch; i++) {
>>>    		struct mlx5e_channel_stats *channel_stats =
>>>    			priv->channel_stats[i];
>>>    		int j;
>>> +		mlx5e_stats_update_stats_rq_page_pool(s, priv->channels.c[i]);
>>

You'd probably need to read the per-RQ stats into a local tmp struct, 
and iteratively accumulate then values.

>> Should separate, do not mix two roles for the same function.
>>
>> Moreover, this won't work, it's buggy:
>> You're looping up to priv->stats_nch (largest num of channels ever created)
>> trying to access priv->channels.c[i] (current number of channels), you can
>> get out of bound accessing non-existing channels.
>>
>> There's a design issue to be solved here:
>> Previously, the page_pool stats existed in RQ stats, also for RQs that no
>> longer exist. We must preserve this behavior here, even if it means
>> assigning zeros for the page_pool stats for non-existing RQs.
>>
>> Worth mentioning: Due to the nature of the infrastructure, today the
>> page_pool stats are not-persistent, while all our other stats are. They are
>> reset to zeros upon channels down/up events. This is not optimal but that's
>> how it is today, and is not expected to be changed here in your series.
> 
> so just channels.num then.
> 

For page_pool stats of existing RQs, yes.

BUT:
Previously, page_pool stats entries appeared (with zeroed values) also 
for non-existing RQs, now you're gonna drop them? Better not introduce 
any behavior change.

>>>    		mlx5e_stats_grp_sw_update_stats_rq_stats(s, &channel_stats->rq);
>>>    		mlx5e_stats_grp_sw_update_stats_xdpsq(s, &channel_stats->rq_xdpsq);
>>>    		mlx5e_stats_grp_sw_update_stats_ch_stats(s, &channel_stats->ch);
>>> @@ -2119,17 +2083,6 @@ static const struct counter_desc rq_stats_desc[] = {
>>>    	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, arfs_err) },
>>>    #endif
>>>    	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, recover) },
>>> -	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_fast) },
>>> -	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_slow) },
>>> -	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_slow_high_order) },
>>> -	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_empty) },
>>> -	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_refill) },
>>> -	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_waive) },
>>> -	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_cached) },
>>> -	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_cache_full) },
>>> -	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_ring) },
>>> -	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_ring_full) },
>>> -	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_released_ref) },
>>>    #ifdef CONFIG_MLX5_EN_TLS
>>>    	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, tls_decrypted_packets) },
>>>    	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, tls_decrypted_bytes) },
>>> @@ -2477,7 +2430,32 @@ static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(channels)
>>>    	       (NUM_RQ_XDPSQ_STATS * max_nch) +
>>>    	       (NUM_XDPSQ_STATS * max_nch) +
>>>    	       (NUM_XSKRQ_STATS * max_nch * priv->xsk.ever_used) +
>>> -	       (NUM_XSKSQ_STATS * max_nch * priv->xsk.ever_used);
>>> +	       (NUM_XSKSQ_STATS * max_nch * priv->xsk.ever_used) +
>>> +	       page_pool_ethtool_stats_get_count() * max_nch;
>>
>> Take this closer to the NUM_RQ_STATS * max_nch part.
>>
>>> +}
>>> +
>>> +static const char pp_stats_mq[][ETH_GSTRING_LEN] = {
>>> +	"rx%d_pp_alloc_fast",
>>> +	"rx%d_pp_alloc_slow",
>>> +	"rx%d_pp_alloc_slow_ho",
>>> +	"rx%d_pp_alloc_empty",
>>> +	"rx%d_pp_alloc_refill",
>>> +	"rx%d_pp_alloc_waive",
>>> +	"rx%d_pp_recycle_cached",
>>> +	"rx%d_pp_recycle_cache_full",
>>> +	"rx%d_pp_recycle_ring",
>>> +	"rx%d_pp_recycle_ring_full",
>>> +	"rx%d_pp_recycle_released_ref",
>>
>> Why static? Isn't the whole point that we want automatic alignment for
>> changes in net/core/page_pool.c :: struct pp_stats ?
>> I suggest writing the code so that mlx5e pp_stats_mq strings are generated
>> and adjusted automatically from the generic struct pp_stats.
> 
> I've been told that it does not make sense to make generic because it is
> already possible to query per-queue stats and the mlx driver does its
> own approach here.
> 

I know. I didn't ask for this.
My comments is, let mlx5 driver generate its own set of strings (maybe 
in runtime) as a derivative of the generic struct pp_stats.
So that it automatically adopts to any change in struct pp_stats.

>>> +};
>>> +
>>> +static void mlx_page_pool_stats_get_strings_mq(u8 **data, unsigned int queue)
>>
>> Use mlx5e prefix.
>> Can use pp to shorten page_pool in function/struct names.
>>
>>> +{
>>> +	int i;
>>> +
>>> +	WARN_ON_ONCE(ARRAY_SIZE(pp_stats_mq) != page_pool_ethtool_stats_get_count());
>>
>> Not good. We don't want to get a WARNING in case someone aded new pp stats
>> without adding to mlx5e.
>>
>> Shoud write the code so that this is not possible.
> 
> I can't use BUILD_BUG_ON() with page_pool_ethtool_stats_get_count() and
> the array isn't exported.
> 

Got it.
Maybe we can add a non-ethtool getter function for the pp_stats strings?

>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(pp_stats_mq); i++)
>>> +		ethtool_sprintf(data, pp_stats_mq[i], queue);
>>>    }
>>>    static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(channels)
>>> @@ -2493,6 +2471,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(channels)
>>>    	for (i = 0; i < max_nch; i++) {
>>>    		for (j = 0; j < NUM_RQ_STATS; j++)
>>>    			ethtool_sprintf(data, rq_stats_desc[j].format, i);
>>> +		mlx_page_pool_stats_get_strings_mq(data, i);
>>>    		for (j = 0; j < NUM_XSKRQ_STATS * is_xsk; j++)
>>>    			ethtool_sprintf(data, xskrq_stats_desc[j].format, i);
>>>    		for (j = 0; j < NUM_RQ_XDPSQ_STATS; j++)
>>> @@ -2527,11 +2506,13 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(channels)
>>>    					      ch_stats_desc, j));
>>>    	for (i = 0; i < max_nch; i++) {
>>> +		struct mlx5e_rq_stats *rq_stats = &priv->channel_stats[i]->rq;
>>> +
>>>    		for (j = 0; j < NUM_RQ_STATS; j++)
>>>    			mlx5e_ethtool_put_stat(
>>> -				data, MLX5E_READ_CTR64_CPU(
>>> -					      &priv->channel_stats[i]->rq,
>>> +				data, MLX5E_READ_CTR64_CPU(rq_stats,
>>>    					      rq_stats_desc, j));
>>> +		*data = page_pool_ethtool_stats_get(*data, &rq_stats->page_pool_stats);
>>>    		for (j = 0; j < NUM_XSKRQ_STATS * is_xsk; j++)
>>>    			mlx5e_ethtool_put_stat(
>>>    				data, MLX5E_READ_CTR64_CPU(
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
>>> index 8de6fcbd3a033..30c5c2a92508b 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
>>> @@ -33,6 +33,8 @@
>>>    #ifndef __MLX5_EN_STATS_H__
>>>    #define __MLX5_EN_STATS_H__
>>> +#include <net/page_pool/types.h>
>>> +
>>>    #define MLX5E_READ_CTR64_CPU(ptr, dsc, i) \
>>>    	(*(u64 *)((char *)ptr + dsc[i].offset))
>>>    #define MLX5E_READ_CTR64_BE(ptr, dsc, i) \
>>> @@ -215,17 +217,7 @@ struct mlx5e_sw_stats {
>>>    	u64 ch_aff_change;
>>>    	u64 ch_force_irq;
>>>    	u64 ch_eq_rearm;
>>> -	u64 rx_pp_alloc_fast;
>>> -	u64 rx_pp_alloc_slow;
>>> -	u64 rx_pp_alloc_slow_high_order;
>>> -	u64 rx_pp_alloc_empty;
>>> -	u64 rx_pp_alloc_refill;
>>> -	u64 rx_pp_alloc_waive;
>>> -	u64 rx_pp_recycle_cached;
>>> -	u64 rx_pp_recycle_cache_full;
>>> -	u64 rx_pp_recycle_ring;
>>> -	u64 rx_pp_recycle_ring_full;
>>> -	u64 rx_pp_recycle_released_ref;
>>> +	struct page_pool_stats page_pool_stats;
>>
>> Maybe call it rx_pp_stats ?
> 
> okay
> 
>>>    #ifdef CONFIG_MLX5_EN_TLS
>>>    	u64 tx_tls_encrypted_packets;
>>>    	u64 tx_tls_encrypted_bytes;
>>> @@ -383,17 +375,7 @@ struct mlx5e_rq_stats {
>>>    	u64 arfs_err;
>>>    #endif
>>>    	u64 recover;
>>> -	u64 pp_alloc_fast;
>>> -	u64 pp_alloc_slow;
>>> -	u64 pp_alloc_slow_high_order;
>>> -	u64 pp_alloc_empty;
>>> -	u64 pp_alloc_refill;
>>> -	u64 pp_alloc_waive;
>>> -	u64 pp_recycle_cached;
>>> -	u64 pp_recycle_cache_full;
>>> -	u64 pp_recycle_ring;
>>> -	u64 pp_recycle_ring_full;
>>> -	u64 pp_recycle_released_ref;
>>> +	struct page_pool_stats page_pool_stats;
>>
>> Maybe call it pp_stats ?
> 
> okay.
> 
>>>    #ifdef CONFIG_MLX5_EN_TLS
>>>    	u64 tls_decrypted_packets;
>>>    	u64 tls_decrypted_bytes;
> 
> Sebastian


