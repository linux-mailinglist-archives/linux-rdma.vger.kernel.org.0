Return-Path: <linux-rdma+bounces-8001-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB2CA40640
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 09:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7FE7189F5AB
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 08:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0BA2063E7;
	Sat, 22 Feb 2025 08:13:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E141DE4E5;
	Sat, 22 Feb 2025 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740212032; cv=none; b=KQYu2DYr+KJR4mxoCCcs/7Lm+jPr3i1qm+JsAFYLYTMG6H9yMpjhzVkXsVRs6raDq/Ynsb/475XWS/Cuz02zWX3MdcMjcpxLTo/LpTZSZHZyXFWGi7Bt5/WKN81NiZRSz2G/mAsrIjYEUbt94F3UnDj2N1gkYUaVPL4SFYtmmQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740212032; c=relaxed/simple;
	bh=XgfiglUr4YbV/NvdS7NrcoaEY9bISL9bv5vkOivAmTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uDytgeVHoFmVcEwXkMHTJinhHispSKX+waOdMP46tJ9KVqvXLB6UmEvqp72BEzuJcIzU0PTquEFJwZCKwWHD1x43gQgYgxbg7qglDksAEdvcJwh+csp/XU8oHVVuRedW6dOMtbqz6PfMpKPxxdo6W9BjfvCqYHFcjEgEB8D1jxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z0KRy6vX8zGycf;
	Sat, 22 Feb 2025 16:10:22 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id CA761140336;
	Sat, 22 Feb 2025 16:13:47 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 22 Feb 2025 16:13:47 +0800
Message-ID: <c7b52d18-430c-4a00-908a-9279bc77db50@huawei.com>
Date: Sat, 22 Feb 2025 16:13:47 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] page_pool: Convert page_pool_alloc_stats to
 u64_stats_t.
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
 <20250221115221.291006-3-bigeasy@linutronix.de>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20250221115221.291006-3-bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/2/21 19:52, Sebastian Andrzej Siewior wrote:

...
						\
> @@ -88,19 +95,30 @@ static const char pp_stats[][ETH_GSTRING_LEN] = {
>  bool page_pool_get_stats(const struct page_pool *pool,
>  			 struct page_pool_stats *stats)
>  {
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
> +		u64_stats_add(&stats->alloc_stats.fast,
> +			      u64_stats_read(&alloc_stats->fast));
> +		u64_stats_add(&stats->alloc_stats.slow,
> +			      u64_stats_read(&alloc_stats->slow));
> +		u64_stats_add(&stats->alloc_stats.slow_high_order,
> +			      u64_stats_read(&alloc_stats->slow_high_order));
> +		u64_stats_add(&stats->alloc_stats.empty,
> +			      u64_stats_read(&alloc_stats->empty));
> +		u64_stats_add(&stats->alloc_stats.refill,
> +			      u64_stats_read(&alloc_stats->refill));
> +		u64_stats_add(&stats->alloc_stats.waive,
> +			      u64_stats_read(&alloc_stats->waive));

similar comment as patch 1.

> +	} while (u64_stats_fetch_retry(&alloc_stats->syncp, start));
>  


