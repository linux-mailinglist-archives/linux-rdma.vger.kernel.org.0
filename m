Return-Path: <linux-rdma+bounces-7951-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22CEA3F361
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 12:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B1616EA96
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 11:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A966D209F4F;
	Fri, 21 Feb 2025 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YWmWoz9s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fu9I59Q3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A18E209689;
	Fri, 21 Feb 2025 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138747; cv=none; b=acyjcCYb0RQbLIlnOFyfPW182z0c+JIkgtsooFpX+UGdaKXJHoriTPaTd7Ys354SMX1MW/2Touqk40TKHIu8DHlNzvKxHnUAY54p+nuVU/KNVmsLCRaM5V0zlrg0GStprU6DbYipt6+b+VRiM58y1stmqAj/GWZogYjWIm/mLd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138747; c=relaxed/simple;
	bh=G0uOksgba5mq341N+bmoOPfw9IfLvA66dMORHlHUX/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqm1mLKjo62iRX9+G5X+hRHoGg9uxrIVJ/z/BBTUOo9DOCAa4Jp4M+WCk2V3jqaAv6VWko5U3iYlD4VY5UTRsZp37E0TlL98rBGCIdsSnqp6rnFXEANp0xXb91fqCp0AZYyJ0g7ljVyvrQG5VH5ZXIPFf++JaRkYczpK/haWmws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YWmWoz9s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fu9I59Q3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740138744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VSgM5Id043YlplzTovi+8LMCEBi0aLDg6OqYa1PA7g0=;
	b=YWmWoz9sBV0Cklcm8U5it2O3Ak+LXDewbWXI9uVoVYNWthbqPxiNP27tbyXJILwtdHu63p
	NpF/SEMslGfRca972Y4xjPywgM/+B9lDBdK9XNJOqYZm/xMlaTjjOzfjvugj6QR2opyeRQ
	wMBDV4f6iOK5zn9BNYL7ZlWDn0/zDboR8iNhPZJJa0QbqSG3CWiH7P9rR8hwCFkBulmdqU
	gyRb2XebrSaIc0pMmGOzy/rV8RrTODwEJgjeAO8gW7yGQI9dzyMbE8QFTSi1JjNdd/ycU9
	+VUqdQ16rFm5RUBV+GP1goI7HADEzpQGnGnbbunO7Motddy0Ixcp9pokDgOv4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740138744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VSgM5Id043YlplzTovi+8LMCEBi0aLDg6OqYa1PA7g0=;
	b=fu9I59Q3E8ae2SGI6zl44NsEW8D0Jqm9ycR68G/iLkeXSKmzw9SeI26CHq2+Hh2TKQjgFY
	9Qcr1Giarj+licDg==
To: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next 2/2] page_pool: Convert page_pool_alloc_stats to u64_stats_t.
Date: Fri, 21 Feb 2025 12:52:21 +0100
Message-ID: <20250221115221.291006-3-bigeasy@linutronix.de>
In-Reply-To: <20250221115221.291006-1-bigeasy@linutronix.de>
References: <20250221115221.291006-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Using u64 for statistics can lead to inconsistency on 32bit because an
update and a read requires to access two 32bit values.
This can be avoided by using u64_stats_t for the counters and
u64_stats_sync for the required synchronisation on 32bit platforms. The
synchronisation is a NOP on 64bit architectures.

Use u64_stats_t for the counters in page_pool_recycle_stats.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 12 ++---
 include/net/page_pool/types.h                 | 14 +++---
 net/core/page_pool.c                          | 45 +++++++++++++------
 net/core/page_pool_user.c                     | 12 ++---
 4 files changed, 52 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/en_stats.c
index baff961970f25..afb5c135b68c1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -506,12 +506,12 @@ static void mlx5e_stats_update_stats_rq_page_pool(str=
uct mlx5e_channel *c)
 	if (!page_pool_get_stats(pool, &stats))
 		return;
=20
-	rq_stats->pp_alloc_fast =3D stats.alloc_stats.fast;
-	rq_stats->pp_alloc_slow =3D stats.alloc_stats.slow;
-	rq_stats->pp_alloc_slow_high_order =3D stats.alloc_stats.slow_high_order;
-	rq_stats->pp_alloc_empty =3D stats.alloc_stats.empty;
-	rq_stats->pp_alloc_waive =3D stats.alloc_stats.waive;
-	rq_stats->pp_alloc_refill =3D stats.alloc_stats.refill;
+	rq_stats->pp_alloc_fast =3D u64_stats_read(&stats.alloc_stats.fast);
+	rq_stats->pp_alloc_slow =3D u64_stats_read(&stats.alloc_stats.slow);
+	rq_stats->pp_alloc_slow_high_order =3D u64_stats_read(&stats.alloc_stats.=
slow_high_order);
+	rq_stats->pp_alloc_empty =3D u64_stats_read(&stats.alloc_stats.empty);
+	rq_stats->pp_alloc_waive =3D u64_stats_read(&stats.alloc_stats.waive);
+	rq_stats->pp_alloc_refill =3D u64_stats_read(&stats.alloc_stats.refill);
=20
 	rq_stats->pp_recycle_cached =3D u64_stats_read(&stats.recycle_stats.cache=
d);
 	rq_stats->pp_recycle_cache_full =3D u64_stats_read(&stats.recycle_stats.c=
ache_full);
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index c5ad80a542b7d..f45d55e6e8643 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -96,6 +96,7 @@ struct page_pool_params {
 #ifdef CONFIG_PAGE_POOL_STATS
 /**
  * struct page_pool_alloc_stats - allocation statistics
+ * @syncp:	synchronisations point for updates.
  * @fast:	successful fast path allocations
  * @slow:	slow path order-0 allocations
  * @slow_high_order: slow path high order allocations
@@ -105,12 +106,13 @@ struct page_pool_params {
  *		the cache due to a NUMA mismatch
  */
 struct page_pool_alloc_stats {
-	u64 fast;
-	u64 slow;
-	u64 slow_high_order;
-	u64 empty;
-	u64 refill;
-	u64 waive;
+	struct u64_stats_sync syncp;
+	u64_stats_t fast;
+	u64_stats_t slow;
+	u64_stats_t slow_high_order;
+	u64_stats_t empty;
+	u64_stats_t refill;
+	u64_stats_t waive;
 };
=20
 /**
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 36fa14a1e8441..d69a03609613b 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -42,7 +42,14 @@ static DEFINE_PER_CPU(struct page_pool_recycle_stats, pp=
_system_recycle_stats) =3D
 };
=20
 /* alloc_stat_inc is intended to be used in softirq context */
-#define alloc_stat_inc(pool, __stat)	(pool->alloc_stats.__stat++)
+#define alloc_stat_inc(pool, __stat)						\
+	do {									\
+		struct page_pool_alloc_stats *s =3D &pool->alloc_stats;		\
+		u64_stats_update_begin(&s->syncp);				\
+		u64_stats_inc(&s->__stat);					\
+		u64_stats_update_end(&s->syncp);				\
+	} while (0)
+
 /* recycle_stat_inc is safe to use when preemption is possible. */
 #define recycle_stat_inc(pool, __stat)							\
 	do {										\
@@ -88,19 +95,30 @@ static const char pp_stats[][ETH_GSTRING_LEN] =3D {
 bool page_pool_get_stats(const struct page_pool *pool,
 			 struct page_pool_stats *stats)
 {
+	const struct page_pool_alloc_stats *alloc_stats;
 	unsigned int start;
 	int cpu =3D 0;
=20
 	if (!stats)
 		return false;
=20
+	alloc_stats =3D &pool->alloc_stats;
 	/* The caller is responsible to initialize stats. */
-	stats->alloc_stats.fast +=3D pool->alloc_stats.fast;
-	stats->alloc_stats.slow +=3D pool->alloc_stats.slow;
-	stats->alloc_stats.slow_high_order +=3D pool->alloc_stats.slow_high_order;
-	stats->alloc_stats.empty +=3D pool->alloc_stats.empty;
-	stats->alloc_stats.refill +=3D pool->alloc_stats.refill;
-	stats->alloc_stats.waive +=3D pool->alloc_stats.waive;
+	do {
+		start =3D u64_stats_fetch_begin(&alloc_stats->syncp);
+		u64_stats_add(&stats->alloc_stats.fast,
+			      u64_stats_read(&alloc_stats->fast));
+		u64_stats_add(&stats->alloc_stats.slow,
+			      u64_stats_read(&alloc_stats->slow));
+		u64_stats_add(&stats->alloc_stats.slow_high_order,
+			      u64_stats_read(&alloc_stats->slow_high_order));
+		u64_stats_add(&stats->alloc_stats.empty,
+			      u64_stats_read(&alloc_stats->empty));
+		u64_stats_add(&stats->alloc_stats.refill,
+			      u64_stats_read(&alloc_stats->refill));
+		u64_stats_add(&stats->alloc_stats.waive,
+			      u64_stats_read(&alloc_stats->waive));
+	} while (u64_stats_fetch_retry(&alloc_stats->syncp, start));
=20
 	for_each_possible_cpu(cpu) {
 		const struct page_pool_recycle_stats *pcpu =3D
@@ -148,12 +166,12 @@ u64 *page_pool_ethtool_stats_get(u64 *data, const voi=
d *stats)
 {
 	const struct page_pool_stats *pool_stats =3D stats;
=20
-	*data++ =3D pool_stats->alloc_stats.fast;
-	*data++ =3D pool_stats->alloc_stats.slow;
-	*data++ =3D pool_stats->alloc_stats.slow_high_order;
-	*data++ =3D pool_stats->alloc_stats.empty;
-	*data++ =3D pool_stats->alloc_stats.refill;
-	*data++ =3D pool_stats->alloc_stats.waive;
+	*data++ =3D u64_stats_read(&pool_stats->alloc_stats.fast);
+	*data++ =3D u64_stats_read(&pool_stats->alloc_stats.slow);
+	*data++ =3D u64_stats_read(&pool_stats->alloc_stats.slow_high_order);
+	*data++ =3D u64_stats_read(&pool_stats->alloc_stats.empty);
+	*data++ =3D u64_stats_read(&pool_stats->alloc_stats.refill);
+	*data++ =3D u64_stats_read(&pool_stats->alloc_stats.waive);
 	*data++ =3D u64_stats_read(&pool_stats->recycle_stats.cached);
 	*data++ =3D u64_stats_read(&pool_stats->recycle_stats.cache_full);
 	*data++ =3D u64_stats_read(&pool_stats->recycle_stats.ring);
@@ -278,6 +296,7 @@ static int page_pool_init(struct page_pool *pool,
 		pool->recycle_stats =3D &pp_system_recycle_stats;
 		pool->system =3D true;
 	}
+	u64_stats_init(&pool->alloc_stats.syncp);
 #endif
=20
 	if (ptr_ring_init(&pool->ring, ring_qsize, GFP_KERNEL) < 0) {
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 0d038c0c8996d..c368cb141147f 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -137,17 +137,17 @@ page_pool_nl_stats_fill(struct sk_buff *rsp, const st=
ruct page_pool *pool,
 	nla_nest_end(rsp, nest);
=20
 	if (nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_FAST,
-			 stats.alloc_stats.fast) ||
+			 u64_stats_read(&stats.alloc_stats.fast)) ||
 	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW,
-			 stats.alloc_stats.slow) ||
+			 u64_stats_read(&stats.alloc_stats.slow)) ||
 	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW_HIGH_ORDER,
-			 stats.alloc_stats.slow_high_order) ||
+			 u64_stats_read(&stats.alloc_stats.slow_high_order)) ||
 	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_EMPTY,
-			 stats.alloc_stats.empty) ||
+			 u64_stats_read(&stats.alloc_stats.empty)) ||
 	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_REFILL,
-			 stats.alloc_stats.refill) ||
+			 u64_stats_read(&stats.alloc_stats.refill)) ||
 	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_WAIVE,
-			 stats.alloc_stats.waive) ||
+			 u64_stats_read(&stats.alloc_stats.waive)) ||
 	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHED,
 			 u64_stats_read(&stats.recycle_stats.cached)) ||
 	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHE_FULL,
--=20
2.47.2


