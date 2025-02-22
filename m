Return-Path: <linux-rdma+bounces-8000-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F333DA4063D
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 09:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A31216DE23
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 08:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1139B2063E3;
	Sat, 22 Feb 2025 08:13:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4411DE4E5;
	Sat, 22 Feb 2025 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740212020; cv=none; b=jEL/cRmWJoP60xqRf80uJf/PcM/EMY2GwU9KiG8y9daUPm1Jhn682O908pG6h9995jyk/oi+il3eROTrq3Un132bzk+pXg5oLWl95Umi84pYL1fQy+DYJPmrL+zIOhaLqNCjZ5z8YA0mPW576TqhbHSsyNmGiDeMcNaeUmpHQjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740212020; c=relaxed/simple;
	bh=GMoX2tBScugygoGQzRb2GiIUU3kckzmKbsI3tR/lUK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NGaBUoKPc+A+q/VqhJi33mkSGVttPi+Z6lOXPnUAv0ndwinpIxdqkTNpSK8c5CTO8/2nggVbz4zrYGxkDWqy7EXqOfQ2+qZl/gvmGFQvJ+ZU4rly4sLuQA/1Utk0LAVRCuPKkYCdOg5GEgbRJeqU5+mSSDjSZcX6S46rpwy+6+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Z0KQJ0kgRzdb8f;
	Sat, 22 Feb 2025 16:08:56 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F3A01800D9;
	Sat, 22 Feb 2025 16:13:36 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 22 Feb 2025 16:13:35 +0800
Message-ID: <307939b7-8f51-437a-b5b2-ac5342630504@huawei.com>
Date: Sat, 22 Feb 2025 16:13:35 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] page_pool: Convert page_pool_recycle_stats
 to u64_stats_t.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Leon Romanovsky <leon@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Simon Horman
	<horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Thomas Gleixner
	<tglx@linutronix.de>
References: <20250221115221.291006-1-bigeasy@linutronix.de>
 <20250221115221.291006-2-bigeasy@linutronix.de>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20250221115221.291006-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/2/21 19:52, Sebastian Andrzej Siewior wrote:
>  
>  static const char pp_stats[][ETH_GSTRING_LEN] = {
> @@ -82,6 +88,7 @@ static const char pp_stats[][ETH_GSTRING_LEN] = {
>  bool page_pool_get_stats(const struct page_pool *pool,
>  			 struct page_pool_stats *stats)
>  {
> +	unsigned int start;
>  	int cpu = 0;
>  
>  	if (!stats)
> @@ -99,11 +106,19 @@ bool page_pool_get_stats(const struct page_pool *pool,
>  		const struct page_pool_recycle_stats *pcpu =
>  			per_cpu_ptr(pool->recycle_stats, cpu);
>  
> -		stats->recycle_stats.cached += pcpu->cached;
> -		stats->recycle_stats.cache_full += pcpu->cache_full;
> -		stats->recycle_stats.ring += pcpu->ring;
> -		stats->recycle_stats.ring_full += pcpu->ring_full;
> -		stats->recycle_stats.released_refcnt += pcpu->released_refcnt;
> +		do {
> +			start = u64_stats_fetch_begin(&pcpu->syncp);
> +			u64_stats_add(&stats->recycle_stats.cached,
> +				      u64_stats_read(&pcpu->cached));
> +			u64_stats_add(&stats->recycle_stats.cache_full,
> +				      u64_stats_read(&pcpu->cache_full));
> +			u64_stats_add(&stats->recycle_stats.ring,
> +				      u64_stats_read(&pcpu->ring));
> +			u64_stats_add(&stats->recycle_stats.ring_full,
> +				      u64_stats_read(&pcpu->ring_full));
> +			u64_stats_add(&stats->recycle_stats.released_refcnt,
> +				      u64_stats_read(&pcpu->released_refcnt));

It seems the above u64_stats_add() may be called more than one time
if the below u64_stats_fetch_retry() returns true, which might mean
the stats is added more than it is needed.

It seems more correct to me that pool->alloc_stats is read into a
local varible in the while loop and then do the addition outside
the while loop?

> +		} while (u64_stats_fetch_retry(&pcpu->syncp, start));
>  	}
>  
>  	return true;

