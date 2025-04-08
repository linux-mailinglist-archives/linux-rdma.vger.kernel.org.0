Return-Path: <linux-rdma+bounces-9225-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A6FA7FDD3
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 13:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027543A7630
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 11:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29531269AF8;
	Tue,  8 Apr 2025 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QazoIF+j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TCESX32k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92722698AE;
	Tue,  8 Apr 2025 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109971; cv=none; b=oRCPMyDjLUt/98Hp1dOmnCskiKVDawGZdD6rQ/O14fzNzz3Y2M8eLf9RuOenBGIXr//dV0EnLMHNWQ2TUbXN7J2x3Lxac0WNiKeNQuZeoUQaFJgfaeyvwBp/D8EAKwPjSSwkQ7G9ZeDHp4LwHGnOeNOw4TeNMqLT7uiBqKJBAAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109971; c=relaxed/simple;
	bh=4Ns97n4/Og/UfCCY2xsD/j38PqWaop2U54G3WqfRy9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rR5vJn8PdNfHIkKJe/BgsvcDVE5TPTXWUDfCT0Nnp5rYWIaHuI3XyRCGMxB3gCIarEbHPwHiZ89x/cCSQ2ALNc1aaJssuY+g6k+pPhi7T7by/tD4gjz3Dg0W83DqI15hMDaS/K1vB7PsJXFXgRuSaUlTq1oZCV/O++NRj1oejRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QazoIF+j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TCESX32k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744109967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MV5k1y4SxJoy4GiG8mDNdP9Rw2UQvageHkpkKA+Py+U=;
	b=QazoIF+jzQUnYVLtXUQUt22WdS9nyhhABxfIikis3kKbGjVVoMRqRbM8i4f7QM/KWH1TPU
	7yds3Dt6qEc65BIzG5ZCTc8D7/LZ1vMvMwxEKE8YjNBJhLTEjhAgWH/pwEyWSIWn7S7FZ+
	QJ44Ny4ZPHgdSRgfcz3CGNhovnWb6xcVq69PVDcjt/sxll4KLQm4k/NueOCsqX2g85JyUr
	3RKa6wU/VMMqw7P3yMfIsNUAXuJ/5Bh15v/P+ZKww0/cERL9V8Uy82+hlaL4b0wEkvb6fU
	DReVMNAtAtiHMKY2eqmn0RAQT4Zm1d0g/lyad7JcXIcmnDB9VmCo+239EPWRFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744109967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MV5k1y4SxJoy4GiG8mDNdP9Rw2UQvageHkpkKA+Py+U=;
	b=TCESX32kV8IktyRtXGRVzhrc882+x7tMAPmvdZaIRGmtD1KZwOJBvJ7I062KdvUbs/1XWN
	JeKoJ2Fi7c1b7aCA==
To: linux-rdma@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
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
Subject: [PATCH net-next v3 0/4] page_pool: Convert stats to u64_stats_t.
Date: Tue,  8 Apr 2025 12:59:17 +0200
Message-ID: <20250408105922.1135150-1-bigeasy@linutronix.de>
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
|
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
|
|         /* size: 40, cachelines: 1, members: 6 */
|         /* last cacheline: 40 bytes */
| };

On 32bit struct u64_stats_sync grows by 4 bytes (plus addiional 20 with
lockdep).

For bench_page_pool_simple.ko loops=3D600000000 I ended up with, before:

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

v2=E2=80=A6v3: https://lore.kernel.org/all/20250307115722.705311-1-bigeasy@=
linutronix.de
  - Moved the page_pool_ethtool_stats_get_strings_mq() to the mlx5
    driver and named it mlx_page_pool_stats_get_strings_mq(). As per
    review it will remain a Mellanox only thing.

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

Sebastian Andrzej Siewior (4):
  mlnx5: Use generic code for page_pool statistics.
  page_pool: Provide an empty page_pool_stats for disabled stats.
  page_pool: Convert page_pool_recycle_stats to u64_stats_t.
  page_pool: Convert page_pool_alloc_stats to u64_stats_t.

 Documentation/networking/page_pool.rst        |  6 +-
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 97 ++++++++----------
 .../ethernet/mellanox/mlx5/core/en_stats.h    | 26 +----
 include/linux/u64_stats_sync.h                |  5 +
 include/net/page_pool/helpers.h               |  6 ++
 include/net/page_pool/types.h                 | 31 +++---
 net/core/page_pool.c                          | 99 +++++++++++++------
 net/core/page_pool_user.c                     | 22 ++---
 8 files changed, 159 insertions(+), 133 deletions(-)

--=20
2.49.0


