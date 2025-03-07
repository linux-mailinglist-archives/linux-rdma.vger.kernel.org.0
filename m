Return-Path: <linux-rdma+bounces-8468-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFC7A56745
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 12:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85DD18995F0
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 11:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DD92192EC;
	Fri,  7 Mar 2025 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kns1fqqO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FVDTnrGU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E8F21885D;
	Fri,  7 Mar 2025 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348654; cv=none; b=RxgHRtOuOhv962fFbusQ5Z8CWWyzw5TxCX5u2SYVz6TeP0kkhuK7GtNCrp5Sc3/fTb8C4MyK6oMjZRtjU3MVyssr/H51UQZ7dRUGRxYiEnQpxiLdXY2CPyOIrzfQ5lH++cvuOXnVUuZezU2wzIRG2RntXb2Xb/McAaA4CNmK8ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348654; c=relaxed/simple;
	bh=SGFIqls0s7Q+ZnLVrG3OonJaUsvj9jbcFUBkAx+fHz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqofvZXQ3abAt7fFgvv6GYnJD4WUuf8wZnOVEaFvz6+qv8FhZH01CLxOSPVDtNFzZKKSKpNliGmzdBdVvukRXcyGy4imuWmwyNsK/cBU34i5in5R5hISXrrYPCQRmdSbAoFMNUgVd74mZpmh7iV0gsQZ5Gv6tnfaF1YceDwGqvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kns1fqqO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FVDTnrGU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741348649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RYo/FLo9hs1YKyzHeLhHqmwOWRKzqs+oW8a/uV1uk1A=;
	b=kns1fqqO8GbYVQ5Ym4FyKmC+YAw0KZdLIc9+Kk43iEBjVLRO6zIGFAmIZqJvGiTW9MVk7e
	3Tr8GepLrYesU3U90nMLvb5MMSfGL9qsMDPGfx+Lhg5JIUIbXGGHSUYlKK8sOxj8r7pPMo
	uaOjL3A24tbNcaJnagRYGlhqKKF/pCX6AhQqnddC/tZDbc60iZ2MpqGA8RlPxK3mi0Y7//
	tJLRbRnYI6cSDhuq9ms2I5KrIRan7iwZETWVSkaNUP0mAtQzS+47oCHyayDzEe34qURde0
	ifZGVw0GxJx0RXWB7nK4iqwXUeYF/J2ZBJUNeACoPWGDzgPHyB6CykkI1HtXtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741348649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RYo/FLo9hs1YKyzHeLhHqmwOWRKzqs+oW8a/uV1uk1A=;
	b=FVDTnrGUyN0mpj/QQutxwIRGj3WTQO/DjVeJMysVJkCqW+Apqboc8875Meh/O2uhfdp4hK
	z4fbOvTmlPNWsHAA==
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
Subject: [PATCH net-next v2 4/5] page_pool: Convert page_pool_recycle_stats to u64_stats_t.
Date: Fri,  7 Mar 2025 12:57:21 +0100
Message-ID: <20250307115722.705311-5-bigeasy@linutronix.de>
In-Reply-To: <20250307115722.705311-1-bigeasy@linutronix.de>
References: <20250307115722.705311-1-bigeasy@linutronix.de>
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
Add U64_STATS_ZERO, a static initializer for u64_stats_t.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 Documentation/networking/page_pool.rst |  6 +--
 include/linux/u64_stats_sync.h         |  5 +++
 include/net/page_pool/types.h          | 13 ++++---
 net/core/page_pool.c                   | 52 ++++++++++++++++++--------
 net/core/page_pool_user.c              | 10 ++---
 5 files changed, 58 insertions(+), 28 deletions(-)

diff --git a/Documentation/networking/page_pool.rst b/Documentation/network=
ing/page_pool.rst
index 9d958128a57cb..5215fd51a334a 100644
--- a/Documentation/networking/page_pool.rst
+++ b/Documentation/networking/page_pool.rst
@@ -181,11 +181,11 @@ Stats
=20
 	#ifdef CONFIG_PAGE_POOL_STATS
 	/* retrieve stats */
-	struct page_pool_stats stats =3D { 0 };
+	struct page_pool_stats stats =3D { };
 	if (page_pool_get_stats(page_pool, &stats)) {
 		/* perhaps the driver reports statistics with ethool */
-		ethtool_print_allocation_stats(&stats.alloc_stats);
-		ethtool_print_recycle_stats(&stats.recycle_stats);
+		ethtool_print_allocation_stats(u64_stats_read(&stats.alloc_stats));
+		ethtool_print_recycle_stats(u64_stats_read(&stats.recycle_stats));
 	}
 	#endif
=20
diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index 457879938fc19..086bd4a51cfe9 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -94,6 +94,8 @@ static inline void u64_stats_inc(u64_stats_t *p)
 	local64_inc(&p->v);
 }
=20
+#define U64_STATS_ZERO(_member, _name)	{}
+
 static inline void u64_stats_init(struct u64_stats_sync *syncp) { }
 static inline void __u64_stats_update_begin(struct u64_stats_sync *syncp) =
{ }
 static inline void __u64_stats_update_end(struct u64_stats_sync *syncp) { }
@@ -141,6 +143,9 @@ static inline void u64_stats_inc(u64_stats_t *p)
 		seqcount_init(&__s->seq);		\
 	} while (0)
=20
+#define U64_STATS_ZERO(_member, _name)			\
+	_member.seq	=3D SEQCNT_ZERO(#_name#_member.seq)
+
 static inline void __u64_stats_update_begin(struct u64_stats_sync *syncp)
 {
 	preempt_disable_nested();
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 6d55e6cf5d0db..daf989d01436e 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -6,6 +6,7 @@
 #include <linux/dma-direction.h>
 #include <linux/ptr_ring.h>
 #include <linux/types.h>
+#include <linux/u64_stats_sync.h>
 #include <net/netmem.h>
=20
 #define PP_FLAG_DMA_MAP		BIT(0) /* Should page_pool do the DMA
@@ -114,6 +115,7 @@ struct page_pool_alloc_stats {
=20
 /**
  * struct page_pool_recycle_stats - recycling (freeing) statistics
+ * @syncp:	synchronisations point for updates.
  * @cached:	recycling placed page in the page pool cache
  * @cache_full:	page pool cache was full
  * @ring:	page placed into the ptr ring
@@ -121,11 +123,12 @@ struct page_pool_alloc_stats {
  * @released_refcnt:	page released (and not recycled) because refcnt > 1
  */
 struct page_pool_recycle_stats {
-	u64 cached;
-	u64 cache_full;
-	u64 ring;
-	u64 ring_full;
-	u64 released_refcnt;
+	struct u64_stats_sync syncp;
+	u64_stats_t cached;
+	u64_stats_t cache_full;
+	u64_stats_t ring;
+	u64_stats_t ring_full;
+	u64_stats_t released_refcnt;
 };
=20
 /**
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 2290d80443d1e..312bdc5b5a8bf 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -37,21 +37,27 @@ DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
 #define BIAS_MAX	(LONG_MAX >> 1)
=20
 #ifdef CONFIG_PAGE_POOL_STATS
-static DEFINE_PER_CPU(struct page_pool_recycle_stats, pp_system_recycle_st=
ats);
+static DEFINE_PER_CPU(struct page_pool_recycle_stats, pp_system_recycle_st=
ats) =3D {
+	U64_STATS_ZERO(.syncp, pp_system_recycle_stats),
+};
=20
 /* alloc_stat_inc is intended to be used in softirq context */
 #define alloc_stat_inc(pool, __stat)	(pool->alloc_stats.__stat++)
 /* recycle_stat_inc is safe to use when preemption is possible. */
 #define recycle_stat_inc(pool, __stat)							\
 	do {										\
-		struct page_pool_recycle_stats __percpu *s =3D pool->recycle_stats;	\
-		this_cpu_inc(s->__stat);						\
+		struct page_pool_recycle_stats *s =3D this_cpu_ptr(pool->recycle_stats);=
	\
+		u64_stats_update_begin(&s->syncp);					\
+		u64_stats_inc(&s->__stat);						\
+		u64_stats_update_end(&s->syncp);					\
 	} while (0)
=20
 #define recycle_stat_add(pool, __stat, val)						\
 	do {										\
-		struct page_pool_recycle_stats __percpu *s =3D pool->recycle_stats;	\
-		this_cpu_add(s->__stat, val);						\
+		struct page_pool_recycle_stats *s =3D this_cpu_ptr(pool->recycle_stats);=
	\
+		u64_stats_update_begin(&s->syncp);					\
+		u64_stats_add(&s->__stat, val);						\
+		u64_stats_update_end(&s->syncp);					\
 	} while (0)
=20
 static const char pp_stats[][ETH_GSTRING_LEN] =3D {
@@ -96,6 +102,7 @@ static const char pp_stats_mq[][ETH_GSTRING_LEN] =3D {
 bool page_pool_get_stats(const struct page_pool *pool,
 			 struct page_pool_stats *stats)
 {
+	unsigned int start;
 	int cpu =3D 0;
=20
 	if (!stats)
@@ -110,14 +117,24 @@ bool page_pool_get_stats(const struct page_pool *pool,
 	stats->alloc_stats.waive +=3D pool->alloc_stats.waive;
=20
 	for_each_possible_cpu(cpu) {
+		u64 cached, cache_full, ring, ring_full, released_refcnt;
 		const struct page_pool_recycle_stats *pcpu =3D
 			per_cpu_ptr(pool->recycle_stats, cpu);
=20
-		stats->recycle_stats.cached +=3D pcpu->cached;
-		stats->recycle_stats.cache_full +=3D pcpu->cache_full;
-		stats->recycle_stats.ring +=3D pcpu->ring;
-		stats->recycle_stats.ring_full +=3D pcpu->ring_full;
-		stats->recycle_stats.released_refcnt +=3D pcpu->released_refcnt;
+		do {
+			start =3D u64_stats_fetch_begin(&pcpu->syncp);
+			cached =3D u64_stats_read(&pcpu->cached);
+			cache_full =3D u64_stats_read(&pcpu->cache_full);
+			ring =3D u64_stats_read(&pcpu->ring);
+			ring_full =3D u64_stats_read(&pcpu->ring_full);
+			released_refcnt =3D u64_stats_read(&pcpu->released_refcnt);
+		} while (u64_stats_fetch_retry(&pcpu->syncp, start));
+
+		u64_stats_add(&stats->recycle_stats.cached, cached);
+		u64_stats_add(&stats->recycle_stats.cache_full, cache_full);
+		u64_stats_add(&stats->recycle_stats.ring, ring);
+		u64_stats_add(&stats->recycle_stats.ring_full, ring_full);
+		u64_stats_add(&stats->recycle_stats.released_refcnt, released_refcnt);
 	}
=20
 	return true;
@@ -162,11 +179,11 @@ u64 *page_pool_ethtool_stats_get(u64 *data, const voi=
d *stats)
 	*data++ =3D pool_stats->alloc_stats.empty;
 	*data++ =3D pool_stats->alloc_stats.refill;
 	*data++ =3D pool_stats->alloc_stats.waive;
-	*data++ =3D pool_stats->recycle_stats.cached;
-	*data++ =3D pool_stats->recycle_stats.cache_full;
-	*data++ =3D pool_stats->recycle_stats.ring;
-	*data++ =3D pool_stats->recycle_stats.ring_full;
-	*data++ =3D pool_stats->recycle_stats.released_refcnt;
+	*data++ =3D u64_stats_read(&pool_stats->recycle_stats.cached);
+	*data++ =3D u64_stats_read(&pool_stats->recycle_stats.cache_full);
+	*data++ =3D u64_stats_read(&pool_stats->recycle_stats.ring);
+	*data++ =3D u64_stats_read(&pool_stats->recycle_stats.ring_full);
+	*data++ =3D u64_stats_read(&pool_stats->recycle_stats.released_refcnt);
=20
 	return data;
 }
@@ -270,9 +287,14 @@ static int page_pool_init(struct page_pool *pool,
=20
 #ifdef CONFIG_PAGE_POOL_STATS
 	if (!(pool->slow.flags & PP_FLAG_SYSTEM_POOL)) {
+		unsigned int cpu;
+
 		pool->recycle_stats =3D alloc_percpu(struct page_pool_recycle_stats);
 		if (!pool->recycle_stats)
 			return -ENOMEM;
+
+		for_each_possible_cpu(cpu)
+			u64_stats_init(&per_cpu_ptr(pool->recycle_stats, cpu)->syncp);
 	} else {
 		/* For system page pool instance we use a singular stats object
 		 * instead of allocating a separate percpu variable for each
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 6677e0c2e2565..0d038c0c8996d 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -149,15 +149,15 @@ page_pool_nl_stats_fill(struct sk_buff *rsp, const st=
ruct page_pool *pool,
 	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_ALLOC_WAIVE,
 			 stats.alloc_stats.waive) ||
 	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHED,
-			 stats.recycle_stats.cached) ||
+			 u64_stats_read(&stats.recycle_stats.cached)) ||
 	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHE_FULL,
-			 stats.recycle_stats.cache_full) ||
+			 u64_stats_read(&stats.recycle_stats.cache_full)) ||
 	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_RING,
-			 stats.recycle_stats.ring) ||
+			 u64_stats_read(&stats.recycle_stats.ring)) ||
 	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_RING_FULL,
-			 stats.recycle_stats.ring_full) ||
+			 u64_stats_read(&stats.recycle_stats.ring_full)) ||
 	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_STATS_RECYCLE_RELEASED_REFCNT,
-			 stats.recycle_stats.released_refcnt))
+			 u64_stats_read(&stats.recycle_stats.released_refcnt)))
 		goto err_cancel_msg;
=20
 	genlmsg_end(rsp, hdr);
--=20
2.47.2


