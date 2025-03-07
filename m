Return-Path: <linux-rdma+bounces-8465-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF70A5673F
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 12:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81A0178205
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 11:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCFD21883E;
	Fri,  7 Mar 2025 11:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F6Ki8ji5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XY89h6Uj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4271221859D;
	Fri,  7 Mar 2025 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348652; cv=none; b=GJhMRxnvVOTk/e6rUD88A2iZH0yDYRKMTjMqmfCKbnqJPEgLT3D2UGX+aYewh4U4yaHCXV2Vy43k1lx3MeKV2srEwbqpZcd1bKt4rcCrkOBqhPlyDtnxnRbL38XzIGRS5DgHelXWbs66jeunAw8uPppAjyM4nP5J0Cx4E8ZhrUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348652; c=relaxed/simple;
	bh=W/Wpv0jBnU3yLXstWDnFlAxNk4PTPAPOKzn4/w5N6EA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nAS6IH1DYplVArAKRlfqv82uXr1LUpthVsFToCar6Jo63w+DfYZZP5bA0V+n2dthPtsX4Jfvtdh9VDx2O76zUnBVwXouB34KazSoOc9+n2LGQWsg7IlzyqhRt9AKODH/QHROlCC9Yz47uO/sZbd4oGMKnmgYDspLEJJE/Xs2Bx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F6Ki8ji5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XY89h6Uj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741348648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o4NxQAuqs6oBuFAFcLsKPdXIysiB9HWSf5wYtY9oykU=;
	b=F6Ki8ji5Cg7Cj5X+mkT5v2bBhMT4pWociDFqEgs07rCBVmBn3oP9jiPt6BY+4YNererklD
	+fyhDtxCnC2Kq+MrPjTLDBjnzRGg4DE0U3blTDed/sHvGPYWumvU0oSWXXS3hypaG2AKqO
	xbYDGEZgolW7Dg4iHuYCaoffbBoQlrolMzRXHi9oywHzgotxcZU5DTcpvzsZBH5303YI44
	M0qDWKksqH50yh0+hTk+tONNiGrbUy+75L++h8N+DTqlOjsGTKrxzR4ubHtb5gCAb4qsR1
	iJymH3B6YAtBKZWbfkvlOk02x2CfBKk32tMsdCM+/esedJNBnRRTD72AK39cwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741348648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o4NxQAuqs6oBuFAFcLsKPdXIysiB9HWSf5wYtY9oykU=;
	b=XY89h6Uj7aaea+5yESF2BR1vWA+BpH/4D4ulpTHAzM9GreXt3JIyF4MrmF2avKEIsSYTyD
	akccuyCNTbmqnUCA==
To: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Joe Damato <jdamato@fastly.com>,
	Leon Romanovsky <leon@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next v2 0/5] page_pool: Convert stats to u64_stats_t.
Date: Fri,  7 Mar 2025 12:57:17 +0100
Message-ID: <20250307115722.705311-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This is a follow-up on
        https://lore.kernel.org/all/20250213093925.x_ggH1aj@linutronix.de/

to convert the page_pool statistics to u64_stats_t to avoid u64 related
problems on 32bit architectures.
While looking over it, the comment for recycle_stat_inc() says that it
is safe to use in preemptible context. The 32bit update is split into
two 32bit writes. This is "okay" if the value observed from the current
CPU but cross CPU reads may observe inconsistencies if the lower part
overflows and the upper part is not yet written.
I explained this and added x86-32 assembly in
	https://lore.kernel.org/all/20250226102703.3F7Aa2oK@linutronix.de/

I don't know if it is ensured that only *one* update can happen because
the stats are per-CPU and per NAPI device. But there will be now a
warning on 32bit if this is really attempted in preemptible context.

The placement of the counters is not affected by this change except on
32bit where an additional sync member is added. For 64bit pahole output
changes from
| struct page_pool_recycle_stats {
|         u64                        cached;               /*     0     8 */
|         u64                        cache_full;           /*     8     8 */
|         u64                        ring;                 /*    16     8 */
|         u64                        ring_full;            /*    24     8 */
|         u64                        released_refcnt;      /*    32     8 */
|=20
|         /* size: 40, cachelines: 1, members: 5 */
|         /* last cacheline: 40 bytes */
| };

to
| struct page_pool_recycle_stats {
|         struct u64_stats_sync      syncp;                /*     0     0 */
|         u64_stats_t                cached;               /*     0     8 */
|         u64_stats_t                cache_full;           /*     8     8 */
|         u64_stats_t                ring;                 /*    16     8 */
|         u64_stats_t                ring_full;            /*    24     8 */
|         u64_stats_t                released_refcnt;      /*    32     8 */
|=20
|         /* size: 40, cachelines: 1, members: 6 */
|         /* last cacheline: 40 bytes */
| };

On 32bit struct u64_stats_sync grows by 4 bytes (plus addiional 20 with
lockdep).

For bench_page_pool_simple.ko loops=3D600000000 I neded up with, before:

| time_bench: Type:for_loop Per elem: 1 cycles(tsc) 0.501 ns (step:0)
| time_bench: Type:atomic_inc Per elem: 6 cycles(tsc) 3.303 ns (step:0)
| time_bench: Type:lock Per elem: 28 cycles(tsc) 14.038 ns (step:0)
| time_bench: Type:u64_stats_inc Per elem: 1 cycles(tsc) 0.565 ns (step:0)
| time_bench: Type:this_cpu_inc Per elem: 1 cycles(tsc) 0.503 ns (step:0)
|=20
| bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use pa=
ge_pool fast-path
| time_bench: Type:no-softirq-page_pool01 Per elem: 19 cycles(tsc) 9.526 ns=
 (step:0)
| bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use pag=
e_pool fast-path
| time_bench: Type:no-softirq-page_pool02 Per elem: 46 cycles(tsc) 23.501 n=
s (step:0)
| bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_po=
ol fast-path
| time_bench: Type:no-softirq-page_pool03 Per elem: 121 cycles(tsc) 60.697 =
ns (step:0)
| bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
| bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_so=
ftirq fast-path
| time_bench: Type:tasklet_page_pool01_fast_path Per elem: 19 cycles(tsc) 9=
.531 ns (step:0)
| bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_sof=
tirq fast-path
| time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 45 cycles(tsc) 22=
.594 ns (step:0)
| bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq=
 fast-path
| time_bench: Type:tasklet_page_pool03_slow Per elem: 123 cycles(tsc) 61.96=
9 ns (step:0)

after:
| time_bench: Type:for_loop Per elem: 1 cycles(tsc) 0.501 ns (step:0)
| time_bench: Type:atomic_inc Per elem: 6 cycles(tsc) 3.324 ns (step:0)
| time_bench: Type:lock Per elem: 28 cycles(tsc) 14.038 ns (step:0)
| time_bench: Type:u64_stats_inc Per elem: 1 cycles(tsc) 0.565 ns (step:0)
| time_bench: Type:this_cpu_inc Per elem: 1 cycles(tsc) 0.506 ns (step:0)
|=20
| bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use pa=
ge_pool fast-path
| time_bench: Type:no-softirq-page_pool01 Per elem: 18 cycles(tsc) 9.028 ns=
 (step:0)
| bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use pag=
e_pool fast-path
| time_bench: Type:no-softirq-page_pool02 Per elem: 45 cycles(tsc) 22.714 n=
s (step:0)
| bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_po=
ol fast-path
| time_bench: Type:no-softirq-page_pool03 Per elem: 120 cycles(tsc) 60.428 =
ns (step:0)
| bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
| bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_so=
ftirq fast-path
| time_bench: Type:tasklet_page_pool01_fast_path Per elem: 18 cycles(tsc) 9=
.024 ns (step:0)
| bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_sof=
tirq fast-path
| time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 43 cycles(tsc) 22=
.028 ns (step:0)
| bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq=
 fast-path
| time_bench: Type:tasklet_page_pool03_slow Per elem: 121 cycles(tsc) 60.73=
6 ns (step:0)

v1=E2=80=A6v2: https://lore.kernel.org/all/20250221115221.291006-1-bigeasy@=
linutronix.de
  - Clarified the cover mail, added stat for pahole and from bench_page_poo=
l_simple.ko
  - Corrected page_pool_alloc_stats vs page_pool_recycle_stats type in
    the last patch.
  - Copy the counter values outside of the do {} while loop and add them
    later.
  - Redid the mlnx5 patch to make it use generic infrastructure which is
    now extended as part of this series.

Sebastian Andrzej Siewior (5):
  page_pool: Provide an empty page_pool_stats for disabled stats.
  page_pool: Add per-queue statistics.
  mlx5: Use generic code for page_pool statistics.
  page_pool: Convert page_pool_recycle_stats to u64_stats_t.
  page_pool: Convert page_pool_alloc_stats to u64_stats_t.

 Documentation/networking/page_pool.rst        |   6 +-
 .../ethernet/mellanox/mlx5/core/en_stats.c    |  87 +++----------
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  30 +----
 include/linux/u64_stats_sync.h                |   5 +
 include/net/page_pool/helpers.h               |  11 ++
 include/net/page_pool/types.h                 |  31 +++--
 net/core/page_pool.c                          | 122 ++++++++++++++----
 net/core/page_pool_user.c                     |  22 ++--
 8 files changed, 163 insertions(+), 151 deletions(-)

--=20
2.47.2


