Return-Path: <linux-rdma+bounces-9319-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63826A83AD7
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 09:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D867E8C0C1C
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 07:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0287220AF84;
	Thu, 10 Apr 2025 07:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DauUESYF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A567320A5E9;
	Thu, 10 Apr 2025 07:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269423; cv=none; b=VKaL8oHZHROd8lJ7Mq7+f0hq5+KPv2StckrSoC5H5Zt4vDP8+61/zisA0fYBJFEY1XdSYhoh/alQda8AqDS+ml2d0wvL9CFLEGtGgIEl/lvgdONIIi7i8J3+CdceOzH3syte725qF9nYhZFcFG8xCN9qWpp9qFEDrGYYRU8bDnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269423; c=relaxed/simple;
	bh=KP0lQCnKB1yvrwQHp0rbDgIuBZ3wr1H+ZdjBTyZftWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FG5eSYzVEnCAFjRd42EHGTPJzJ+VeLq85hkNAY6sbkdwwASy63C97btL3wCXGYYzwNhb8klhg/kiTIhhvH0QqIxmM3U4YLtuG8dhyDgmNcN5FTT/O++hsmupcQIo9l1AOz57T9B1g4NF8rDoo5GuA3c70GA3gjcGlMvScKdB6dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DauUESYF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso3196355e9.1;
        Thu, 10 Apr 2025 00:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744269420; x=1744874220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IvGad0RHxg/Q+SgRTYXAJXXqUmtxy7Va3fdJYyWTlKY=;
        b=DauUESYFUE7RWLuGSXhG3AAy3cb3Dc+Gb4Uk7G/ILJMxMTEdRCsNHi8FwEbjehHl8e
         dKRlxryibnZYrb0JPew1yjiR6S3Rqi3ihqmp7AgHL1japjo5LJx0W57DGl4DCnkwBDr6
         OSULldmZnd5vBvWgY9usyXewiJPoEDOn0lU9djfs7cpF2qJP5KSagvOghiFYZceejTyp
         5TgBRfesyr3HyzgVQWPd+18h1hK2zdApPDbJqalEUmbNK90b0MQ9RIhGH3xAQzUmDKhk
         61fxtq3mbukpsL4yPTv/iTPywK9XXkmtDvwujli1g5x9XBI/StCz6iAXj/RfQHraTCO/
         wbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744269420; x=1744874220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvGad0RHxg/Q+SgRTYXAJXXqUmtxy7Va3fdJYyWTlKY=;
        b=Abdnk2+D4+qH9K2DcT4OOcXTJxKtS8IhBEjKC5IyyPfT/YRItPJ8WwzAslQPd/rVsk
         O9G9CLwgeq8AUHq1HdY+OkrcdD8yRqgPsIoLUqDK4ia8DVlqF1KdmjRgSVI8+sIQyZXf
         7evfZxWTPbS7serCGy2Sdm02OteTiH+m3AcgkgOzT+XonkbZYutcI8WJBru4F6A7N0ae
         eg1TmFIyQ8Ba76vw0OoKbPUEi0XhUhwI9jVfYnE7tvrD/3Ozn/IUdiwJ4o2qm7H9OFAV
         jKqgoUrVCC0oTW7UTQvMn/VF7tnoiwz4fV/t1RjfNCTZJHMOld/Mx6Cu5fXn2tGly9NS
         2i/g==
X-Forwarded-Encrypted: i=1; AJvYcCVOMC4T6uxZitiD80RC1ezaul1mQ+jd8kBipX4W9zL7PfidIyjHO+nd5ejF8UBDH6TfKjesZ3mb3/bM@vger.kernel.org, AJvYcCVYZfAANnLP/g7QqouB1PeqVCYQeeHzb/SMn7IjR4OZGhldtz0PVuK0b3kjnTj+Ts7bQWvZHiLx@vger.kernel.org
X-Gm-Message-State: AOJu0Yzti3dP4ufujL3OQgOOYm5jf5EuX1E1X627QrYaCsFN9y+aWbKG
	HAgC5D4fXo+1NrNgyef27oDsJTMnwZ7OchtI21ZbKYFZMCf3shfz
X-Gm-Gg: ASbGnct0HRfoZiM5/7sJuFZl0WMctvss+IDPqikmEYyVTGwh0nAyNY8NagPZyxyeFLG
	FhhHJ9s+DI4ZQzRXxR/XGWvAOP8IIDd3CE+9Hd58gfUZvvEfrHWV0lr8nXcbZc+FkoyI5HsDeOw
	L3mj/hekcZI4LAFnhngmLGYa/LRz+lM/nYq0myzBbdtX6h4m4NNu2zkbbztk51wb4cX+0ERqmij
	6jQsWIXynf/ymYnFbjAUPcC9+CR2/zdtcFB8paUknojPhwFazs2ypupz5+zQikklADksFHBXcAF
	9cKt2m2dG0oYdrRIXhsOuWblBaEP6lg/nZ/eu20+cgx3Nzk2+O7lA3Zvg3jBQ31efGvoMZgw
X-Google-Smtp-Source: AGHT+IH8qOXQFaFt79wTc8bTmNqzs0wrujYYTBSvkaFuLioy3vybgQMXnqaBsiryatg6OQLoLt+cOA==
X-Received: by 2002:a05:600c:4f4f:b0:43d:fa5d:9314 with SMTP id 5b1f17b1804b1-43f2d9a13camr13635595e9.32.1744269419539;
        Thu, 10 Apr 2025 00:16:59 -0700 (PDT)
Received: from [172.27.55.156] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2075fca5sm46372835e9.32.2025.04.10.00.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 00:16:59 -0700 (PDT)
Message-ID: <62687af5-32cd-4400-b51f-c956125aaee9@gmail.com>
Date: Thu, 10 Apr 2025 10:16:54 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/4] mlnx5: Use generic code for page_pool
 statistics.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-rdma@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Joe Damato <jdamato@fastly.com>, Leon Romanovsky <leon@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>, Yunsheng Lin <linyunsheng@huawei.com>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20250408105922.1135150-1-bigeasy@linutronix.de>
 <20250408105922.1135150-2-bigeasy@linutronix.de>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250408105922.1135150-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Fix subject module/submodule to be "net/mlx5e".

Also, for me it looks strange to see a dot at the end of the patch subject.

On 08/04/2025 13:59, Sebastian Andrzej Siewior wrote:
> The statistics gathering code for page_pool statistics has multiple
> steps:
> - gather statistics from a channel via page_pool_get_stats() to an
>    on-stack structure.
> - copy this data to dedicated rq_stats.
> - copy the data from rq_stats global mlx5e_sw_stats structure, and merge
>    per-queue statistics into one counter.
> - Finally copy the data in specific order for the ethtool query (both
>    per queue and all queues summed up).
> 
> The downside here is that the individual counter types are expected to
> be u64 and if something changes, the code breaks. Also if additional
> counter are added to struct page_pool_stats then they are not
> automatically picked up by the driver but need to be manually added in
> all four spots.
> 
> Remove the page_pool_stats related description from sw_stats_desc and
> rq_stats_desc.
> Replace the counters in mlx5e_sw_stats and mlx5e_rq_stats with struct
> page_pool_stats.
> Let mlx5e_stats_update_stats_rq_page_pool() fetch the stats for
> page_pool twice: One for the summed up data, one for the individual
> queue.
> Publish the strings via page_pool_ethtool_stats_get_strings() and
> mlx_page_pool_stats_get_strings_mq().
> Publish the counter via page_pool_ethtool_stats_get().
> 
> Suggested-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

Thanks for your patch.

Was this tested?
Were you able to run with mlx5 device?


>   .../ethernet/mellanox/mlx5/core/en_stats.c    | 97 ++++++++-----------
>   .../ethernet/mellanox/mlx5/core/en_stats.h    | 26 +----
>   2 files changed, 43 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> index 1c121b435016d..54303877adb1d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> @@ -194,17 +194,6 @@ static const struct counter_desc sw_stats_desc[] = {
>   	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_arfs_err) },
>   #endif
>   	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_recover) },
> -	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_fast) },
> -	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_slow) },
> -	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_slow_high_order) },
> -	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_empty) },
> -	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_refill) },
> -	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_waive) },
> -	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_cached) },
> -	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_cache_full) },
> -	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_ring) },
> -	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_ring_full) },
> -	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_released_ref) },
>   #ifdef CONFIG_MLX5_EN_TLS
>   	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_tls_decrypted_packets) },
>   	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_tls_decrypted_bytes) },
> @@ -253,7 +242,7 @@ static const struct counter_desc sw_stats_desc[] = {
>   
>   static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(sw)
>   {
> -	return NUM_SW_COUNTERS;
> +	return NUM_SW_COUNTERS + page_pool_ethtool_stats_get_count();
>   }
>   
>   static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(sw)
> @@ -262,6 +251,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(sw)
>   
>   	for (i = 0; i < NUM_SW_COUNTERS; i++)
>   		ethtool_puts(data, sw_stats_desc[i].format);
> +	*data = page_pool_ethtool_stats_get_strings(*data);
>   }
>   
>   static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(sw)
> @@ -272,6 +262,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(sw)
>   		mlx5e_ethtool_put_stat(data,
>   				       MLX5E_READ_CTR64_CPU(&priv->stats.sw,
>   							    sw_stats_desc, i));
> +	*data = page_pool_ethtool_stats_get(*data, &priv->stats.sw.page_pool_stats);
>   }
>   
>   static void mlx5e_stats_grp_sw_update_stats_xdp_red(struct mlx5e_sw_stats *s,
> @@ -373,17 +364,6 @@ static void mlx5e_stats_grp_sw_update_stats_rq_stats(struct mlx5e_sw_stats *s,
>   	s->rx_arfs_err                += rq_stats->arfs_err;
>   #endif
>   	s->rx_recover                 += rq_stats->recover;
> -	s->rx_pp_alloc_fast          += rq_stats->pp_alloc_fast;
> -	s->rx_pp_alloc_slow          += rq_stats->pp_alloc_slow;
> -	s->rx_pp_alloc_empty         += rq_stats->pp_alloc_empty;
> -	s->rx_pp_alloc_refill        += rq_stats->pp_alloc_refill;
> -	s->rx_pp_alloc_waive         += rq_stats->pp_alloc_waive;
> -	s->rx_pp_alloc_slow_high_order		+= rq_stats->pp_alloc_slow_high_order;
> -	s->rx_pp_recycle_cached			+= rq_stats->pp_recycle_cached;
> -	s->rx_pp_recycle_cache_full		+= rq_stats->pp_recycle_cache_full;
> -	s->rx_pp_recycle_ring			+= rq_stats->pp_recycle_ring;
> -	s->rx_pp_recycle_ring_full		+= rq_stats->pp_recycle_ring_full;
> -	s->rx_pp_recycle_released_ref		+= rq_stats->pp_recycle_released_ref;
>   #ifdef CONFIG_MLX5_EN_TLS
>   	s->rx_tls_decrypted_packets   += rq_stats->tls_decrypted_packets;
>   	s->rx_tls_decrypted_bytes     += rq_stats->tls_decrypted_bytes;
> @@ -490,27 +470,13 @@ static void mlx5e_stats_grp_sw_update_stats_qos(struct mlx5e_priv *priv,
>   	}
>   }
>   
> -static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_channel *c)
> +static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_sw_stats *s,
> +						  struct mlx5e_channel *c)

This per-RQ function should not get the general SW status struct and 
write to it.

Gathering stats from all RQs into the general SW stats should not be 
done here.

>   {
>   	struct mlx5e_rq_stats *rq_stats = c->rq.stats;
> -	struct page_pool *pool = c->rq.page_pool;
> -	struct page_pool_stats stats = { 0 };
>   
> -	if (!page_pool_get_stats(pool, &stats))
> -		return;
> -
> -	rq_stats->pp_alloc_fast = stats.alloc_stats.fast;
> -	rq_stats->pp_alloc_slow = stats.alloc_stats.slow;
> -	rq_stats->pp_alloc_slow_high_order = stats.alloc_stats.slow_high_order;
> -	rq_stats->pp_alloc_empty = stats.alloc_stats.empty;
> -	rq_stats->pp_alloc_waive = stats.alloc_stats.waive;
> -	rq_stats->pp_alloc_refill = stats.alloc_stats.refill;
> -
> -	rq_stats->pp_recycle_cached = stats.recycle_stats.cached;
> -	rq_stats->pp_recycle_cache_full = stats.recycle_stats.cache_full;
> -	rq_stats->pp_recycle_ring = stats.recycle_stats.ring;
> -	rq_stats->pp_recycle_ring_full = stats.recycle_stats.ring_full;
> -	rq_stats->pp_recycle_released_ref = stats.recycle_stats.released_refcnt;
> +	page_pool_get_stats(c->rq.page_pool, &s->page_pool_stats);
> +	page_pool_get_stats(c->rq.page_pool, &rq_stats->page_pool_stats);
>   }
>   
>   static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(sw)
> @@ -520,15 +486,13 @@ static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(sw)
>   
>   	memset(s, 0, sizeof(*s));
>   
> -	for (i = 0; i < priv->channels.num; i++) /* for active channels only */
> -		mlx5e_stats_update_stats_rq_page_pool(priv->channels.c[i]);
> -
>   	for (i = 0; i < priv->stats_nch; i++) {
>   		struct mlx5e_channel_stats *channel_stats =
>   			priv->channel_stats[i];
>   
>   		int j;
>   
> +		mlx5e_stats_update_stats_rq_page_pool(s, priv->channels.c[i]);

Should separate, do not mix two roles for the same function.

Moreover, this won't work, it's buggy:
You're looping up to priv->stats_nch (largest num of channels ever 
created) trying to access priv->channels.c[i] (current number of 
channels), you can get out of bound accessing non-existing channels.

There's a design issue to be solved here:
Previously, the page_pool stats existed in RQ stats, also for RQs that 
no longer exist. We must preserve this behavior here, even if it means 
assigning zeros for the page_pool stats for non-existing RQs.

Worth mentioning: Due to the nature of the infrastructure, today the 
page_pool stats are not-persistent, while all our other stats are. They 
are reset to zeros upon channels down/up events. This is not optimal but 
that's how it is today, and is not expected to be changed here in your 
series.

>   		mlx5e_stats_grp_sw_update_stats_rq_stats(s, &channel_stats->rq);
>   		mlx5e_stats_grp_sw_update_stats_xdpsq(s, &channel_stats->rq_xdpsq);
>   		mlx5e_stats_grp_sw_update_stats_ch_stats(s, &channel_stats->ch);
> @@ -2119,17 +2083,6 @@ static const struct counter_desc rq_stats_desc[] = {
>   	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, arfs_err) },
>   #endif
>   	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, recover) },
> -	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_fast) },
> -	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_slow) },
> -	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_slow_high_order) },
> -	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_empty) },
> -	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_refill) },
> -	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_waive) },
> -	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_cached) },
> -	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_cache_full) },
> -	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_ring) },
> -	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_ring_full) },
> -	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_released_ref) },
>   #ifdef CONFIG_MLX5_EN_TLS
>   	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, tls_decrypted_packets) },
>   	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, tls_decrypted_bytes) },
> @@ -2477,7 +2430,32 @@ static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(channels)
>   	       (NUM_RQ_XDPSQ_STATS * max_nch) +
>   	       (NUM_XDPSQ_STATS * max_nch) +
>   	       (NUM_XSKRQ_STATS * max_nch * priv->xsk.ever_used) +
> -	       (NUM_XSKSQ_STATS * max_nch * priv->xsk.ever_used);
> +	       (NUM_XSKSQ_STATS * max_nch * priv->xsk.ever_used) +
> +	       page_pool_ethtool_stats_get_count() * max_nch;

Take this closer to the NUM_RQ_STATS * max_nch part.

> +}
> +
> +static const char pp_stats_mq[][ETH_GSTRING_LEN] = {
> +	"rx%d_pp_alloc_fast",
> +	"rx%d_pp_alloc_slow",
> +	"rx%d_pp_alloc_slow_ho",
> +	"rx%d_pp_alloc_empty",
> +	"rx%d_pp_alloc_refill",
> +	"rx%d_pp_alloc_waive",
> +	"rx%d_pp_recycle_cached",
> +	"rx%d_pp_recycle_cache_full",
> +	"rx%d_pp_recycle_ring",
> +	"rx%d_pp_recycle_ring_full",
> +	"rx%d_pp_recycle_released_ref",

Why static? Isn't the whole point that we want automatic alignment for 
changes in net/core/page_pool.c :: struct pp_stats ?
I suggest writing the code so that mlx5e pp_stats_mq strings are 
generated and adjusted automatically from the generic struct pp_stats.

> +};
> +
> +static void mlx_page_pool_stats_get_strings_mq(u8 **data, unsigned int queue)

Use mlx5e prefix.
Can use pp to shorten page_pool in function/struct names.

> +{
> +	int i;
> +
> +	WARN_ON_ONCE(ARRAY_SIZE(pp_stats_mq) != page_pool_ethtool_stats_get_count());

Not good. We don't want to get a WARNING in case someone aded new pp 
stats without adding to mlx5e.

Shoud write the code so that this is not possible.

> +
> +	for (i = 0; i < ARRAY_SIZE(pp_stats_mq); i++)
> +		ethtool_sprintf(data, pp_stats_mq[i], queue);
>   }
>   
>   static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(channels)
> @@ -2493,6 +2471,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(channels)
>   	for (i = 0; i < max_nch; i++) {
>   		for (j = 0; j < NUM_RQ_STATS; j++)
>   			ethtool_sprintf(data, rq_stats_desc[j].format, i);
> +		mlx_page_pool_stats_get_strings_mq(data, i);
>   		for (j = 0; j < NUM_XSKRQ_STATS * is_xsk; j++)
>   			ethtool_sprintf(data, xskrq_stats_desc[j].format, i);
>   		for (j = 0; j < NUM_RQ_XDPSQ_STATS; j++)
> @@ -2527,11 +2506,13 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(channels)
>   					      ch_stats_desc, j));
>   
>   	for (i = 0; i < max_nch; i++) {
> +		struct mlx5e_rq_stats *rq_stats = &priv->channel_stats[i]->rq;
> +
>   		for (j = 0; j < NUM_RQ_STATS; j++)
>   			mlx5e_ethtool_put_stat(
> -				data, MLX5E_READ_CTR64_CPU(
> -					      &priv->channel_stats[i]->rq,
> +				data, MLX5E_READ_CTR64_CPU(rq_stats,
>   					      rq_stats_desc, j));
> +		*data = page_pool_ethtool_stats_get(*data, &rq_stats->page_pool_stats);
>   		for (j = 0; j < NUM_XSKRQ_STATS * is_xsk; j++)
>   			mlx5e_ethtool_put_stat(
>   				data, MLX5E_READ_CTR64_CPU(
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
> index 8de6fcbd3a033..30c5c2a92508b 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
> @@ -33,6 +33,8 @@
>   #ifndef __MLX5_EN_STATS_H__
>   #define __MLX5_EN_STATS_H__
>   
> +#include <net/page_pool/types.h>
> +
>   #define MLX5E_READ_CTR64_CPU(ptr, dsc, i) \
>   	(*(u64 *)((char *)ptr + dsc[i].offset))
>   #define MLX5E_READ_CTR64_BE(ptr, dsc, i) \
> @@ -215,17 +217,7 @@ struct mlx5e_sw_stats {
>   	u64 ch_aff_change;
>   	u64 ch_force_irq;
>   	u64 ch_eq_rearm;
> -	u64 rx_pp_alloc_fast;
> -	u64 rx_pp_alloc_slow;
> -	u64 rx_pp_alloc_slow_high_order;
> -	u64 rx_pp_alloc_empty;
> -	u64 rx_pp_alloc_refill;
> -	u64 rx_pp_alloc_waive;
> -	u64 rx_pp_recycle_cached;
> -	u64 rx_pp_recycle_cache_full;
> -	u64 rx_pp_recycle_ring;
> -	u64 rx_pp_recycle_ring_full;
> -	u64 rx_pp_recycle_released_ref;
> +	struct page_pool_stats page_pool_stats;

Maybe call it rx_pp_stats ?

>   #ifdef CONFIG_MLX5_EN_TLS
>   	u64 tx_tls_encrypted_packets;
>   	u64 tx_tls_encrypted_bytes;
> @@ -383,17 +375,7 @@ struct mlx5e_rq_stats {
>   	u64 arfs_err;
>   #endif
>   	u64 recover;
> -	u64 pp_alloc_fast;
> -	u64 pp_alloc_slow;
> -	u64 pp_alloc_slow_high_order;
> -	u64 pp_alloc_empty;
> -	u64 pp_alloc_refill;
> -	u64 pp_alloc_waive;
> -	u64 pp_recycle_cached;
> -	u64 pp_recycle_cache_full;
> -	u64 pp_recycle_ring;
> -	u64 pp_recycle_ring_full;
> -	u64 pp_recycle_released_ref;
> +	struct page_pool_stats page_pool_stats;

Maybe call it pp_stats ?

>   #ifdef CONFIG_MLX5_EN_TLS
>   	u64 tls_decrypted_packets;
>   	u64 tls_decrypted_bytes;


