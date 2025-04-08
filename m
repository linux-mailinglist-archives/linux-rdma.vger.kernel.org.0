Return-Path: <linux-rdma+bounces-9236-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF05A80645
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 14:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33678A0293
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 12:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46A426B2D2;
	Tue,  8 Apr 2025 12:13:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F8026B2BB;
	Tue,  8 Apr 2025 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114396; cv=none; b=C5pPlUe0xzesnmAzNl1tjsSfn3LN98Q2D8RrfAw53ZY/++OQ4c+lXZ44UykluqI8A9HqQKnpJoTFMrJwC9+bPX0w8+6q97nNPRvYaOLXL5f1PhtjMC7By3R8MQ/tropIhyL7OjZuRDelyzCGyNHr15R4AG2xoseIvBthBCpHmjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114396; c=relaxed/simple;
	bh=2vK4F+Zgn8cH4gPbYQ7KzR/ulB07FXLrpVp5gNGXj4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rTUn7yA8nJ/kJvttJu1hjn/3kah8XeVQeuHNg0iCMLD8f9zv6qoehkKe9QYrfBAji3MyJfQNQbnqi1iDbC+Hpkgk+WKcdazQgEvGKyWK5Ep3jeib7ZNIEDlghpuLDo0AWQ+VbJPt1FlAEVK9JmP5vOxPlLQTc4Mn4q6T0Kj5O/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZX4dR3N5JzHrMs;
	Tue,  8 Apr 2025 20:09:47 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D3D81400DC;
	Tue,  8 Apr 2025 20:13:10 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Apr 2025 20:13:10 +0800
Message-ID: <988c920b-56b8-43f6-a42c-54e3ea6dc261@huawei.com>
Date: Tue, 8 Apr 2025 20:13:09 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/4] page_pool: Convert
 page_pool_recycle_stats to u64_stats_t.
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
 <20250408105922.1135150-4-bigeasy@linutronix.de>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20250408105922.1135150-4-bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/4/8 18:59, Sebastian Andrzej Siewior wrote:
> Using u64 for statistics can lead to inconsistency on 32bit because an
> update and a read requires to access two 32bit values.
> This can be avoided by using u64_stats_t for the counters and
> u64_stats_sync for the required synchronisation on 32bit platforms. The
> synchronisation is a NOP on 64bit architectures.
> 
> Use u64_stats_t for the counters in page_pool_recycle_stats.
> Add U64_STATS_ZERO, a static initializer for u64_stats_t.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  Documentation/networking/page_pool.rst |  6 +--
>  include/linux/u64_stats_sync.h         |  5 +++
>  include/net/page_pool/types.h          | 13 ++++---
>  net/core/page_pool.c                   | 52 ++++++++++++++++++--------
>  net/core/page_pool_user.c              | 10 ++---
>  5 files changed, 58 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/networking/page_pool.rst b/Documentation/networking/page_pool.rst
> index 9d958128a57cb..5215fd51a334a 100644
> --- a/Documentation/networking/page_pool.rst
> +++ b/Documentation/networking/page_pool.rst
> @@ -181,11 +181,11 @@ Stats
>  
>  	#ifdef CONFIG_PAGE_POOL_STATS
>  	/* retrieve stats */
> -	struct page_pool_stats stats = { 0 };
> +	struct page_pool_stats stats = { };
>  	if (page_pool_get_stats(page_pool, &stats)) {
>  		/* perhaps the driver reports statistics with ethool */
> -		ethtool_print_allocation_stats(&stats.alloc_stats);
> -		ethtool_print_recycle_stats(&stats.recycle_stats);
> +		ethtool_print_allocation_stats(u64_stats_read(&stats.alloc_stats));
> +		ethtool_print_recycle_stats(u64_stats_read(&stats.recycle_stats));

The above seems like an unnecessary change? as stats.alloc_stats and
stats.recycle_stats are not really 'u64_stats_t' type.

Otherwise, LGTM.
Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>

