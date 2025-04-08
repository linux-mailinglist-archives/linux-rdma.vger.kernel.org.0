Return-Path: <linux-rdma+bounces-9241-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3C2A808D2
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 14:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A968C1212
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 12:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A639226B97B;
	Tue,  8 Apr 2025 12:33:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9490026B09F;
	Tue,  8 Apr 2025 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115616; cv=none; b=cSOwj1x/cIxdRYzD667ZEuSTIWbcIZxknMj3J9jFAd2KiJiTC54vVENRt52aNB4kYDAeBKq0GMy8ldPHuTMrnMOs35uqxv9Q6L4ptiSK+hvDEqqKYet70EmgxnC0OB+od27NklVQeetDqtuADT0RP8aEnJdWiishIuZE00iO7fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115616; c=relaxed/simple;
	bh=ogZwpuvtr9WOgjG3iyuGApZAAsIcadALC155eBBkxoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JAFwvWn/XewfjN1AIWFWaxjBmsHgi4j8PY8lv6Vw2XMFgdIwR4ZdQEvULEAK9592cqF6WL3zVwDttprrSw13Js1AFCCukvPYPNuY+ZcbXZz2m3eXS2mkofSoYF7u4vr7pUWuBH90U2Bw6bbvRDXogc83zYn2Tf6vwfHRi7EQJII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZX59b06Zfz27hb4;
	Tue,  8 Apr 2025 20:34:11 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id B4FCF18005F;
	Tue,  8 Apr 2025 20:33:30 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Apr 2025 20:33:30 +0800
Message-ID: <2f3952fd-cf64-43aa-ba0b-8309343834f8@huawei.com>
Date: Tue, 8 Apr 2025 20:33:30 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/4] page_pool: Convert stats to u64_stats_t.
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
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20250408105922.1135150-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/4/8 18:59, Sebastian Andrzej Siewior wrote:
> This is a follow-up on
>         https://lore.kernel.org/all/20250213093925.x_ggH1aj@linutronix.de/
> 
> to convert the page_pool statistics to u64_stats_t to avoid u64 related
> problems on 32bit architectures.
> While looking over it, the comment for recycle_stat_inc() says that it
> is safe to use in preemptible context. The 32bit update is split into
> two 32bit writes. This is "okay" if the value observed from the current
> CPU but cross CPU reads may observe inconsistencies if the lower part
> overflows and the upper part is not yet written.
> I explained this and added x86-32 assembly in
> 	https://lore.kernel.org/all/20250226102703.3F7Aa2oK@linutronix.de/
> 
> I don't know if it is ensured that only *one* update can happen because
> the stats are per-CPU and per NAPI device. But there will be now a
> warning on 32bit if this is really attempted in preemptible context.

I don't think it is ensured that only *one* update, at least not for
'ring_full' and 'released_refcnt'.

> 
> The placement of the counters is not affected by this change except on
> 32bit where an additional sync member is added. For 64bit pahole output
> changes from
> | struct page_pool_recycle_stats {
> |         u64                        cached;               /*     0     8 */
> |         u64                        cache_full;           /*     8     8 */
> |         u64                        ring;                 /*    16     8 */
> |         u64                        ring_full;            /*    24     8 */
> |         u64                        released_refcnt;      /*    32     8 */
> |
> |         /* size: 40, cachelines: 1, members: 5 */
> |         /* last cacheline: 40 bytes */
> | };
> 
> to
> | struct page_pool_recycle_stats {
> |         struct u64_stats_sync      syncp;                /*     0     0 */
> |         u64_stats_t                cached;               /*     0     8 */
> |         u64_stats_t                cache_full;           /*     8     8 */
> |         u64_stats_t                ring;                 /*    16     8 */
> |         u64_stats_t                ring_full;            /*    24     8 */
> |         u64_stats_t                released_refcnt;      /*    32     8 */
> |
> |         /* size: 40, cachelines: 1, members: 6 */
> |         /* last cacheline: 40 bytes */
> | };
> 
> On 32bit struct u64_stats_sync grows by 4 bytes (plus addiional 20 with
> lockdep).
> 
> For bench_page_pool_simple.ko loops=600000000 I ended up with, before:

Is the above test for 64 bit arches or 32 bit arches?
I guess the added overhead is only for the 32 bit arches?

> 
> | time_bench: Type:for_loop Per elem: 1 cycles(tsc) 0.501 ns (step:0)
> | time_bench: Type:atomic_inc Per elem: 6 cycles(tsc) 3.303 ns (step:0)
> | time_bench: Type:lock Per elem: 28 cycles(tsc) 14.038 ns (step:0)
> | time_bench: Type:u64_stats_inc Per elem: 1 cycles(tsc) 0.565 ns (step:0)
> | time_bench: Type:this_cpu_inc Per elem: 1 cycles(tsc) 0.503 ns (step:0)
> | 
> | bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
> | time_bench: Type:no-softirq-page_pool01 Per elem: 19 cycles(tsc) 9.526 ns (step:0)
> | bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
> | time_bench: Type:no-softirq-page_pool02 Per elem: 46 cycles(tsc) 23.501 ns (step:0)
> | bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
> | time_bench: Type:no-softirq-page_pool03 Per elem: 121 cycles(tsc) 60.697 ns (step:0)
> | bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
> | bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
> | time_bench: Type:tasklet_page_pool01_fast_path Per elem: 19 cycles(tsc) 9.531 ns (step:0)
> | bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
> | time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 45 cycles(tsc) 22.594 ns (step:0)
> | bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
> | time_bench: Type:tasklet_page_pool03_slow Per elem: 123 cycles(tsc) 61.969 ns (step:0)
> 
> after:
> | time_bench: Type:for_loop Per elem: 1 cycles(tsc) 0.501 ns (step:0)
> | time_bench: Type:atomic_inc Per elem: 6 cycles(tsc) 3.324 ns (step:0)
> | time_bench: Type:lock Per elem: 28 cycles(tsc) 14.038 ns (step:0)
> | time_bench: Type:u64_stats_inc Per elem: 1 cycles(tsc) 0.565 ns (step:0)
> | time_bench: Type:this_cpu_inc Per elem: 1 cycles(tsc) 0.506 ns (step:0)
> | 
> | bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
> | time_bench: Type:no-softirq-page_pool01 Per elem: 18 cycles(tsc) 9.028 ns (step:0)
> | bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
> | time_bench: Type:no-softirq-page_pool02 Per elem: 45 cycles(tsc) 22.714 ns (step:0)
> | bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
> | time_bench: Type:no-softirq-page_pool03 Per elem: 120 cycles(tsc) 60.428 ns (step:0)
> | bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
> | bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
> | time_bench: Type:tasklet_page_pool01_fast_path Per elem: 18 cycles(tsc) 9.024 ns (step:0)
> | bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
> | time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 43 cycles(tsc) 22.028 ns (step:0)
> | bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
> | time_bench: Type:tasklet_page_pool03_slow Per elem: 121 cycles(tsc) 60.736 ns (step:0)
> 
> v2…v3: https://lore.kernel.org/all/20250307115722.705311-1-bigeasy@linutronix.de
>   - Moved the page_pool_ethtool_stats_get_strings_mq() to the mlx5
>     driver and named it mlx_page_pool_stats_get_strings_mq(). As per
>     review it will remain a Mellanox only thing.
> 
> v1…v2: https://lore.kernel.org/all/20250221115221.291006-1-bigeasy@linutronix.de
>   - Clarified the cover mail, added stat for pahole and from bench_page_pool_simple.ko
>   - Corrected page_pool_alloc_stats vs page_pool_recycle_stats type in
>     the last patch.
>   - Copy the counter values outside of the do {} while loop and add them
>     later.
>   - Redid the mlnx5 patch to make it use generic infrastructure which is
>     now extended as part of this series.
> 
> Sebastian Andrzej Siewior (4):
>   mlnx5: Use generic code for page_pool statistics.
>   page_pool: Provide an empty page_pool_stats for disabled stats.
>   page_pool: Convert page_pool_recycle_stats to u64_stats_t.
>   page_pool: Convert page_pool_alloc_stats to u64_stats_t.
> 
>  Documentation/networking/page_pool.rst        |  6 +-
>  .../ethernet/mellanox/mlx5/core/en_stats.c    | 97 ++++++++----------
>  .../ethernet/mellanox/mlx5/core/en_stats.h    | 26 +----
>  include/linux/u64_stats_sync.h                |  5 +
>  include/net/page_pool/helpers.h               |  6 ++
>  include/net/page_pool/types.h                 | 31 +++---
>  net/core/page_pool.c                          | 99 +++++++++++++------
>  net/core/page_pool_user.c                     | 22 ++---
>  8 files changed, 159 insertions(+), 133 deletions(-)
> 

