Return-Path: <linux-rdma+bounces-9229-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E45C5A7FDDF
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 13:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085C5188D318
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 11:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8162426A0AF;
	Tue,  8 Apr 2025 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2GJRBP0l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/h4P87tn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FF1265630;
	Tue,  8 Apr 2025 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109973; cv=none; b=A6gtodjCMxUiTFNaP/rcEV/2UU5H9sS5TJD/UKFjQqN/QMBwb84JdPGGp0Evwhz5qXgNcR9aGTpWfOhdSu4FuCqgel6UqiVXk6Cm8qrVMjGyBQ/d9RYCRdJaWat8qyloC3mYpIxyVbYyR57ckP7yONwUmStIK5l09bSEF5Qa+2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109973; c=relaxed/simple;
	bh=q3uFZspx6E7cUwvJI9Qm2IF1kvka76KvyPaYGhMPczs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/v5+rGdiQyxeJok1mdZ7pJIuij4U6A19hvnn9mnP+2M3un1YYsOk3SJxWkiGJBh3ks2iSQOzTqbaE23MH2odets7e1dIYYufPSQNWlSS8pwozerKt9/jN/IxPm25XN2XQttdP0wACVK4pNMZEOqj7TXiW3XkL65RIcKBQ+F128=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2GJRBP0l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/h4P87tn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744109969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zwczeGyVkgQbXuFx+40vAsw/0ymUWhhsLDHivOU8sH0=;
	b=2GJRBP0l5WDVcU6ScpdpxpLVRXco8qSMsJNaTppp1Hp24hpFDoXfuLO8popIh4L+FRvIek
	kwoIR8Vpkn7rHZEYfruO8uaHopBL0DcZejaBa7aR4GVMPSnsy3O/62Hk5G3G2sMwexdKB3
	OrKuPSTcI1tJ8VBjftFlrv22lvunwJZRfA2C51bI2v5nUlMuXtRmfq+oUuE3r7hgQ+Kda9
	3029DKf1peexFLZ5HqlWn+7kV1gEUX1Un8nM3uETnCFv6esNb4LJ+9xz6GV2Zb2rime6s/
	G/XhcEOcknklJjhhcz69a5iyiCpMhfNRYnUUEsjjNTqeA+e9WxFzO6MDniyvtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744109969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zwczeGyVkgQbXuFx+40vAsw/0ymUWhhsLDHivOU8sH0=;
	b=/h4P87tny2uVtQllqiPkVdC7mR7GNNkNUBOyFrJt0S6FmyDojxegdwtEti5NTeNcse3zAj
	YY3ixPJ4O/SH3nDg==
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
Subject: [PATCH net-next v3 4/4] page_pool: Convert page_pool_alloc_stats to u64_stats_t.
Date: Tue,  8 Apr 2025 12:59:21 +0200
Message-ID: <20250408105922.1135150-5-bigeasy@linutronix.de>
In-Reply-To: <20250408105922.1135150-1-bigeasy@linutronix.de>
References: <20250408105922.1135150-1-bigeasy@linutronix.de>
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

Use u64_stats_t for the counters in page_pool_alloc_stats.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/net/page_pool/types.h | 14 ++++++-----
 net/core/page_pool.c          | 47 +++++++++++++++++++++++++----------
 net/core/page_pool_user.c     | 12 ++++-----
 3 files changed, 48 insertions(+), 25 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 54c79a020b334..9406fa69232ee 100644
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
index eb2f5b995022f..46e3c56b76692 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -45,7 +45,14 @@ static DEFINE_PER_CPU(struct page_pool_recycle_stats, pp=
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
@@ -91,19 +98,32 @@ static const char pp_stats[][ETH_GSTRING_LEN] =3D {
 bool page_pool_get_stats(const struct page_pool *pool,
 			 struct page_pool_stats *stats)
 {
+	u64 fast, slow, slow_high_order, empty, refill, waive;
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
+		fast =3D u64_stats_read(&alloc_stats->fast);
+		slow =3D u64_stats_read(&alloc_stats->slow);
+		slow_high_order =3D u64_stats_read(&alloc_stats->slow_high_order);
+		empty =3D u64_stats_read(&alloc_stats->empty);
+		refill =3D u64_stats_read(&alloc_stats->refill);
+		waive =3D u64_stats_read(&alloc_stats->waive);
+	} while (u64_stats_fetch_retry(&alloc_stats->syncp, start));
+
+	u64_stats_add(&stats->alloc_stats.fast, fast);
+	u64_stats_add(&stats->alloc_stats.slow, slow);
+	u64_stats_add(&stats->alloc_stats.slow_high_order, slow_high_order);
+	u64_stats_add(&stats->alloc_stats.empty, empty);
+	u64_stats_add(&stats->alloc_stats.refill, refill);
+	u64_stats_add(&stats->alloc_stats.waive, waive);
=20
 	for_each_possible_cpu(cpu) {
 		u64 cached, cache_full, ring, ring_full, released_refcnt;
@@ -153,12 +173,12 @@ u64 *page_pool_ethtool_stats_get(u64 *data, const voi=
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
@@ -283,6 +303,7 @@ static int page_pool_init(struct page_pool *pool,
 		pool->recycle_stats =3D &pp_system_recycle_stats;
 		pool->system =3D true;
 	}
+	u64_stats_init(&pool->alloc_stats.syncp);
 #endif
=20
 	if (ptr_ring_init(&pool->ring, ring_qsize, GFP_KERNEL) < 0) {
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 86c22461b7fed..53c1ebe7cbe6b 100644
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
2.49.0


