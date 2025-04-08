Return-Path: <linux-rdma+bounces-9240-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB9CA8086B
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 14:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5865B8A63E4
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 12:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF9226F46D;
	Tue,  8 Apr 2025 12:27:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB99926B970;
	Tue,  8 Apr 2025 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115230; cv=none; b=JLL5sJX6G5QIt0dRPmMuQeYEQGOfSGq03XkaL99J8tUJ258vYXpNfJrk2IxyM2hQMRlKbIoEriMjfwUWmOvRMT6K9if1N7A4DLev/KnikZjPPCREAXwv9akq0OAz2Lqi60O/CDbuQmJZZkEPla7dN7nFGY52iWfN5K+Xi156YEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115230; c=relaxed/simple;
	bh=QeajJ/uNhcEuU7pG4ey+MDopmI8v8bQPEJVKoU7Eyow=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sYSL3mZN+cPtiOZ+Drcy1bjOxTbEc68Ha9crPdIt1YA7YoDLzR4NPjM+gZ8sh4qLni3t0D5NAVrrrdWi+584o2Cy8Mt7lDhnTvUny2ZoTQ4a5Tlz02ksSJyWJRBDNtybJMN4umYsFwG+7+vR82W8EKdhB2x1IMB6v02112uobnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZX4xS1ddJzHrMs;
	Tue,  8 Apr 2025 20:23:40 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FE31180104;
	Tue,  8 Apr 2025 20:27:03 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Apr 2025 20:27:02 +0800
Message-ID: <d012a523-816b-48af-91c0-4a11f85d592b@huawei.com>
Date: Tue, 8 Apr 2025 20:27:02 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/4] page_pool: Convert page_pool_alloc_stats
 to u64_stats_t.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	<linux-rdma@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
	<netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Joe Damato <jdamato@fastly.com>, Leon
 Romanovsky <leon@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Simon Horman <horms@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20250408105922.1135150-1-bigeasy@linutronix.de>
 <20250408105922.1135150-5-bigeasy@linutronix.de>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20250408105922.1135150-5-bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/4/8 18:59, Sebastian Andrzej Siewior wrote:
> Using u64 for statistics can lead to inconsistency on 32bit because an
> update and a read requires to access two 32bit values.
> This can be avoided by using u64_stats_t for the counters and
> u64_stats_sync for the required synchronisation on 32bit platforms. The
> synchronisation is a NOP on 64bit architectures.
> 
> Use u64_stats_t for the counters in page_pool_alloc_stats.

It seems a little overkill for page_pool_alloc_stats as there is only
one updater ensured by NAPI context, but I am not able to think of a better
way, so:
Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>

> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/net/page_pool/types.h | 14 ++++++-----
>  net/core/page_pool.c          | 47 +++++++++++++++++++++++++----------
>  net/core/page_pool_user.c     | 12 ++++-----
>  3 files changed, 48 insertions(+), 25 deletions(-)
> 
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 54c79a020b334..9406fa69232ee 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -96,6 +96,7 @@ struct page_pool_params {
>  #ifdef CONFIG_PAGE_POOL_STATS
>  /**
>   * struct page_pool_alloc_stats - allocation statistics
> + * @syncp:	synchronisations point for updates.
>   * @fast:	successful fast path allocations
>   * @slow:	slow path order-0 allocations
>   * @slow_high_order: slow path high order allocations
> @@ -105,12 +106,13 @@ struct page_pool_params {
>   *		the cache due to a NUMA mismatch
>   */
>  struct page_pool_alloc_stats {
> -	u64 fast;
> -	u64 slow;
> -	u64 slow_high_order;
> -	u64 empty;
> -	u64 refill;
> -	u64 waive;
> +	struct u64_stats_sync syncp;
> +	u64_stats_t fast;
> +	u64_stats_t slow;
> +	u64_stats_t slow_high_order;
> +	u64_stats_t empty;
> +	u64_stats_t refill;
> +	u64_stats_t waive;
>  };
>  
>  /**
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index eb2f5b995022f..46e3c56b76692 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -45,7 +45,14 @@ static DEFINE_PER_CPU(struct page_pool_recycle_stats, pp_system_recycle_stats) =
>  };
>  
>  /* alloc_stat_inc is intended to be used in softirq context */
> -#define alloc_stat_inc(pool, __stat)	(pool->alloc_stats.__stat++)
> +#define alloc_stat_inc(pool, __stat)						\
> +	do {									\
> +		struct page_pool_alloc_stats *s = &pool->alloc_stats;		\
> +		u64_stats_update_begin(&s->syncp);				\
> +		u64_stats_inc(&s->__stat);					\
> +		u64_stats_update_end(&s->syncp);				\
> +	} while (0)
> +
>  /* recycle_stat_inc is safe to use when preemption is possible. */
>  #define recycle_stat_inc(pool, __stat)							\
>  	do {										\
> @@ -91,19 +98,32 @@ static const char pp_stats[][ETH_GSTRING_LEN] = {
>  bool page_pool_get_stats(const struct page_pool *pool,
>  			 struct page_pool_stats *stats)
>  {
> +	u64 fast, slow, slow_high_order, empty, refill, waive;
> +	const struct page_pool_alloc_stats *alloc_stats;
>  	unsigned int start;
>  	int cpu = 0;
>  
>  	if (!stats)
>  		return false;
>  
> +	alloc_stats = &pool->alloc_stats;
>  	/* The caller is responsible to initialize stats. */
> -	stats->alloc_stats.fast += pool->alloc_stats.fast;
> -	stats->alloc_stats.slow += pool->alloc_stats.slow;
> -	stats->alloc_stats.slow_high_order += pool->alloc_stats.slow_high_order;
> -	stats->alloc_stats.empty += pool->alloc_stats.empty;
> -	stats->alloc_stats.refill += pool->alloc_stats.refill;
> -	stats->alloc_stats.waive += pool->alloc_stats.waive;
> +	do {
> +		start = u64_stats_fetch_begin(&alloc_stats->syncp);
> +		fast = u64_stats_read(&alloc_stats->fast);
> +		slow = u64_stats_read(&alloc_stats->slow);
> +		slow_high_order = u64_stats_read(&alloc_stats->slow_high_order);
> +		empty = u64_stats_read(&alloc_stats->empty);
> +		refill = u64_stats_read(&alloc_stats->refill);
> +		waive = u64_stats_read(&alloc_stats->waive);
> +	} while (u64_stats_fetch_retry(&alloc_stats->syncp, start));
> +
> +	u64_stats_add(&stats->alloc_stats.fast, fast);
> +	u64_stats_add(&stats->alloc_stats.slow, slow);
> +	u64_stats_add(&stats->alloc_stats.slow_high_order, slow_high_order);
> +	u64_stats_add(&stats->alloc_stats.empty, empty);
> +	u64_stats_add(&stats->alloc_stats.refill, refill);
> +	u64_stats_add(&stats->alloc_stats.waive, waive);
>  
>  	for_each_possible_cpu(cpu) {
>  		u64 cached, cache_full, ring, ring_full, released_refcnt;
> @@ -153,12 +173,12 @@ u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
>  {
>  	const struct page_pool_stats *pool_stats = stats;
>  
> -	*data++ = pool_stats->alloc_stats.fast;
> -	*data++ = pool_stats->alloc_stats.slow;
> -	*data++ = pool_stats->alloc_stats.slow_high_order;
> -	*data++ = pool_stats->alloc_stats.empty;
> -	*data++ = pool_stats->alloc_stats.refill;
> -	*data++ = pool_stats->alloc_stats.waive;
> +	*data++ = u64_stats_read(&pool_stats->alloc_stats.fast);
> +	*data++ = u64_stats_read(&pool_stats->alloc_stats.slow);
> +	*data++ = u64_stats_read(&pool_stats->alloc_stats.slow_high_order);
> +	*data++ = u64_stats_read(&pool_stats->alloc_stats.empty);
> +	*data++ = u64_stats_read(&pool_stats->alloc_stats.refill);
> +	*data++ = u64_stats_read(&pool_stats->alloc_stats.waive);
>  	*data++ = u64_stats_read(&pool_stats->recycle_stats.cached);
>  	*data++ = u64_stats_read(&pool_stats->recycle_stats.cache_full);
>  	*data++ = u64_stats_read(&pool_stats->recycle_stats.ring);
> @@ -283,6 +303,7 @@ static int page_pool_init(struct page_pool *pool,
>  		pool->recycle_stats = &pp_system_recycle_stats;
>  		pool->system = true;
>  	}
> +	u64_stats_init(&pool->alloc_stats.syncp);
>  #endif
>  
>  	if (ptr_ring_init(&pool->ring, ring_qsize, GFP_KERNEL) < 0) {
> diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
> index 86c22461b7fed..53c1ebe7cbe6b 100644
> --- a/net/core/page_pool_user.c
> +++ b/net/core/page_pool_user.c
> @@ -137,17 +137,17 @@ page_pool_nl_stats_fill(struct sk_buff *rsp, const struct page_pool *pool,
>  	nla_nest_end(rsp, nest);
>  
>  	if (nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_FAST,
> -			 stats.alloc_stats.fast) ||
> +			 u64_stats_read(&stats.alloc_stats.fast)) ||
>  	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW,
> -			 stats.alloc_stats.slow) ||
> +			 u64_stats_read(&stats.alloc_stats.slow)) ||
>  	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW_HIGH_ORDER,
> -			 stats.alloc_stats.slow_high_order) ||
> +			 u64_stats_read(&stats.alloc_stats.slow_high_order)) ||
>  	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_EMPTY,
> -			 stats.alloc_stats.empty) ||
> +			 u64_stats_read(&stats.alloc_stats.empty)) ||
>  	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_REFILL,
> -			 stats.alloc_stats.refill) ||
> +			 u64_stats_read(&stats.alloc_stats.refill)) ||
>  	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_WAIVE,
> -			 stats.alloc_stats.waive) ||
> +			 u64_stats_read(&stats.alloc_stats.waive)) ||
>  	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHED,
>  			 u64_stats_read(&stats.recycle_stats.cached)) ||
>  	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHE_FULL,

