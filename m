Return-Path: <linux-rdma+bounces-8359-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D0FA4FE56
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 13:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A7F7A676D
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 12:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E13724291B;
	Wed,  5 Mar 2025 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TpXXvArQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8S3xDu+0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5968C1624CB;
	Wed,  5 Mar 2025 12:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741176866; cv=none; b=hn3ryFnuIX/ElRufqavPriqJ/QUsPTGNkc/ZToo3MvVrEAU2v2MPd6b/G5sL4u3WoJpAhMxivGpmrJ17fdaA0DyeelPIpCuisJ+luEzA2iKm1ssaJqn7CjRgBJaoiB27l1w1hIjgJl4WnEoJwX/OobRhQPDloTKjhWwxueuTdUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741176866; c=relaxed/simple;
	bh=Vm8/vF3GHAjrFRuGuYRGpAgXCDGs1L83qf6XFXS1Zws=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DSq5JC2Q9j2Tu/EQHOjopn0DxnnzMgNI1TtiP65XJ5ZNYKMbvwq8alD8q3izzLU8dP09mHKmE5QYnwNpjBbIiEr4KwKRVIExoe3Mdq6tGziIYtoswmkHsqP4vBYx9iBK2zO944RdHDF3BzchSgL1XRCsWbbmQA5go7nGCh846Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TpXXvArQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8S3xDu+0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Mar 2025 13:14:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741176862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=/5eInyNCcAb93ovt2g/g2kWQONI+z/Aql3dPfD3A2XU=;
	b=TpXXvArQeak3eNj3Z9l4BuLbL9j13ydkZRGgVfGxe+g+pAfqR/QDV19nGliGWGQ/Q5R+HN
	eIuERA/Xb3fAs4CGo2305t3ZM5mGqGCVwwDduWDKHRJE6K9PamObCzUQ/PBU7Iws3qaNck
	cc4wqtpOqV9Q7VjrtjvWgKtqOMOEBXBlz9EVwGNeFDYYATiXFz2pqrGzZHDAjU1fj9MpfN
	RHH0lHmBBnAX0xJV1FhWR/zXsJWdwbboiUw+yCcnL2fPYqPRx5wB4YKrbVhGdhRvGvzi49
	BVWB4QjTZnIdMr66d87+fgsLAwwR3dqcAJWHtP25tVJq1IM2Fww7prlG63gYAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741176862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=/5eInyNCcAb93ovt2g/g2kWQONI+z/Aql3dPfD3A2XU=;
	b=8S3xDu+0E8v4wYNQ2Yy+Bc+U8Wn/6qNfpE/A5+O9IzLqpVjjwXbXWKg9zYCeJgQjWUm487
	2o4VxQccQten1FBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Joe Damato <jdamato@fastly.com>,
	Leon Romanovsky <leon@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH net-next] net/mlnx5: Use generic code for page_pool
 statistics.
Message-ID: <20250305121420.kFO617zQ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The statistics gathering code for page_pool statistics has multiple
steps:
- gather statistics from a channel via page_pool_get_stats() to an
  on-stack structure.
- copy this data to dedicated rq_stats.
- copy the data from rq_stats global mlx5e_sw_stats structure, and merge
  per-queue statistics into one counter.
- Finally copy the data the specific order for the ethtool query.

The downside here is that the individual counter types are expected to
be u64 and if something changes, the code breaks. Also if additional
counter are added to struct page_pool_stats then they are not
automtically picked up by the driver but need to be manually added in
all four spots.

Remove the page_pool_stats fields from rq_stats_desc and use instead
page_pool_ethtool_stats_get_count() for the number of files and
page_pool_ethtool_stats_get_strings() for the strings which are added at
the end.
Remove page_pool_stats members from all structs and add the struct to
mlx5e_sw_stats where the data is gathered directly for all channels.
At the end, use page_pool_ethtool_stats_get() to copy the data to the
output buffer.

Suggested-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

diffstat wise, this looks nice. I hope I didn't break anything.
Providing an empty struct page_pool_stats in the !CONFIG_PAGE_POOL_STATS
case should eliminate a few additional ifdefs.

 .../ethernet/mellanox/mlx5/core/en_stats.c    | 78 +++----------------
 .../ethernet/mellanox/mlx5/core/en_stats.h    | 27 +------
 2 files changed, 15 insertions(+), 90 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 611ec4b6f3709..ae4d51f11fc5d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -37,9 +37,7 @@
 #include "en/ptp.h"
 #include "en/port.h"
 
-#ifdef CONFIG_PAGE_POOL_STATS
 #include <net/page_pool/helpers.h>
-#endif
 
 void mlx5e_ethtool_put_stat(u64 **data, u64 val)
 {
@@ -196,19 +194,6 @@ static const struct counter_desc sw_stats_desc[] = {
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_arfs_err) },
 #endif
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_recover) },
-#ifdef CONFIG_PAGE_POOL_STATS
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_fast) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_slow) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_slow_high_order) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_empty) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_refill) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_waive) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_cached) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_cache_full) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_ring) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_ring_full) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_released_ref) },
-#endif
 #ifdef CONFIG_MLX5_EN_TLS
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_tls_decrypted_packets) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_tls_decrypted_bytes) },
@@ -257,7 +242,7 @@ static const struct counter_desc sw_stats_desc[] = {
 
 static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(sw)
 {
-	return NUM_SW_COUNTERS;
+	return NUM_SW_COUNTERS + page_pool_ethtool_stats_get_count();
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(sw)
@@ -266,6 +251,8 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(sw)
 
 	for (i = 0; i < NUM_SW_COUNTERS; i++)
 		ethtool_puts(data, sw_stats_desc[i].format);
+
+	*data = page_pool_ethtool_stats_get_strings(*data);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(sw)
@@ -276,6 +263,9 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(sw)
 		mlx5e_ethtool_put_stat(data,
 				       MLX5E_READ_CTR64_CPU(&priv->stats.sw,
 							    sw_stats_desc, i));
+#ifdef CONFIG_PAGE_POOL_STATS
+	*data = page_pool_ethtool_stats_get(*data, &priv->stats.sw.page_pool_stats);
+#endif
 }
 
 static void mlx5e_stats_grp_sw_update_stats_xdp_red(struct mlx5e_sw_stats *s,
@@ -377,19 +367,6 @@ static void mlx5e_stats_grp_sw_update_stats_rq_stats(struct mlx5e_sw_stats *s,
 	s->rx_arfs_err                += rq_stats->arfs_err;
 #endif
 	s->rx_recover                 += rq_stats->recover;
-#ifdef CONFIG_PAGE_POOL_STATS
-	s->rx_pp_alloc_fast          += rq_stats->pp_alloc_fast;
-	s->rx_pp_alloc_slow          += rq_stats->pp_alloc_slow;
-	s->rx_pp_alloc_empty         += rq_stats->pp_alloc_empty;
-	s->rx_pp_alloc_refill        += rq_stats->pp_alloc_refill;
-	s->rx_pp_alloc_waive         += rq_stats->pp_alloc_waive;
-	s->rx_pp_alloc_slow_high_order		+= rq_stats->pp_alloc_slow_high_order;
-	s->rx_pp_recycle_cached			+= rq_stats->pp_recycle_cached;
-	s->rx_pp_recycle_cache_full		+= rq_stats->pp_recycle_cache_full;
-	s->rx_pp_recycle_ring			+= rq_stats->pp_recycle_ring;
-	s->rx_pp_recycle_ring_full		+= rq_stats->pp_recycle_ring_full;
-	s->rx_pp_recycle_released_ref		+= rq_stats->pp_recycle_released_ref;
-#endif
 #ifdef CONFIG_MLX5_EN_TLS
 	s->rx_tls_decrypted_packets   += rq_stats->tls_decrypted_packets;
 	s->rx_tls_decrypted_bytes     += rq_stats->tls_decrypted_bytes;
@@ -497,30 +474,14 @@ static void mlx5e_stats_grp_sw_update_stats_qos(struct mlx5e_priv *priv,
 }
 
 #ifdef CONFIG_PAGE_POOL_STATS
-static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_channel *c)
+static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_sw_stats *s,
+						  struct mlx5e_channel *c)
 {
-	struct mlx5e_rq_stats *rq_stats = c->rq.stats;
-	struct page_pool *pool = c->rq.page_pool;
-	struct page_pool_stats stats = { 0 };
-
-	if (!page_pool_get_stats(pool, &stats))
-		return;
-
-	rq_stats->pp_alloc_fast = stats.alloc_stats.fast;
-	rq_stats->pp_alloc_slow = stats.alloc_stats.slow;
-	rq_stats->pp_alloc_slow_high_order = stats.alloc_stats.slow_high_order;
-	rq_stats->pp_alloc_empty = stats.alloc_stats.empty;
-	rq_stats->pp_alloc_waive = stats.alloc_stats.waive;
-	rq_stats->pp_alloc_refill = stats.alloc_stats.refill;
-
-	rq_stats->pp_recycle_cached = stats.recycle_stats.cached;
-	rq_stats->pp_recycle_cache_full = stats.recycle_stats.cache_full;
-	rq_stats->pp_recycle_ring = stats.recycle_stats.ring;
-	rq_stats->pp_recycle_ring_full = stats.recycle_stats.ring_full;
-	rq_stats->pp_recycle_released_ref = stats.recycle_stats.released_refcnt;
+	page_pool_get_stats(c->rq.page_pool, &s->page_pool_stats);
 }
 #else
-static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_channel *c)
+static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_sw_stats *s,
+						  struct mlx5e_channel *c)
 {
 }
 #endif
@@ -532,15 +493,13 @@ static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(sw)
 
 	memset(s, 0, sizeof(*s));
 
-	for (i = 0; i < priv->channels.num; i++) /* for active channels only */
-		mlx5e_stats_update_stats_rq_page_pool(priv->channels.c[i]);
-
 	for (i = 0; i < priv->stats_nch; i++) {
 		struct mlx5e_channel_stats *channel_stats =
 			priv->channel_stats[i];
 
 		int j;
 
+		mlx5e_stats_update_stats_rq_page_pool(s, priv->channels.c[i]);
 		mlx5e_stats_grp_sw_update_stats_rq_stats(s, &channel_stats->rq);
 		mlx5e_stats_grp_sw_update_stats_xdpsq(s, &channel_stats->rq_xdpsq);
 		mlx5e_stats_grp_sw_update_stats_ch_stats(s, &channel_stats->ch);
@@ -2086,19 +2045,6 @@ static const struct counter_desc rq_stats_desc[] = {
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, arfs_err) },
 #endif
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, recover) },
-#ifdef CONFIG_PAGE_POOL_STATS
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_fast) },
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_slow) },
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_slow_high_order) },
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_empty) },
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_refill) },
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_waive) },
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_cached) },
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_cache_full) },
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_ring) },
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_ring_full) },
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_released_ref) },
-#endif
 #ifdef CONFIG_MLX5_EN_TLS
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, tls_decrypted_packets) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, tls_decrypted_bytes) },
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 5961c569cfe01..f6a186e293c4c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -33,6 +33,8 @@
 #ifndef __MLX5_EN_STATS_H__
 #define __MLX5_EN_STATS_H__
 
+#include <net/page_pool/types.h>
+
 #define MLX5E_READ_CTR64_CPU(ptr, dsc, i) \
 	(*(u64 *)((char *)ptr + dsc[i].offset))
 #define MLX5E_READ_CTR64_BE(ptr, dsc, i) \
@@ -216,17 +218,7 @@ struct mlx5e_sw_stats {
 	u64 ch_force_irq;
 	u64 ch_eq_rearm;
 #ifdef CONFIG_PAGE_POOL_STATS
-	u64 rx_pp_alloc_fast;
-	u64 rx_pp_alloc_slow;
-	u64 rx_pp_alloc_slow_high_order;
-	u64 rx_pp_alloc_empty;
-	u64 rx_pp_alloc_refill;
-	u64 rx_pp_alloc_waive;
-	u64 rx_pp_recycle_cached;
-	u64 rx_pp_recycle_cache_full;
-	u64 rx_pp_recycle_ring;
-	u64 rx_pp_recycle_ring_full;
-	u64 rx_pp_recycle_released_ref;
+	struct page_pool_stats page_pool_stats;
 #endif
 #ifdef CONFIG_MLX5_EN_TLS
 	u64 tx_tls_encrypted_packets;
@@ -381,19 +373,6 @@ struct mlx5e_rq_stats {
 	u64 arfs_err;
 #endif
 	u64 recover;
-#ifdef CONFIG_PAGE_POOL_STATS
-	u64 pp_alloc_fast;
-	u64 pp_alloc_slow;
-	u64 pp_alloc_slow_high_order;
-	u64 pp_alloc_empty;
-	u64 pp_alloc_refill;
-	u64 pp_alloc_waive;
-	u64 pp_recycle_cached;
-	u64 pp_recycle_cache_full;
-	u64 pp_recycle_ring;
-	u64 pp_recycle_ring_full;
-	u64 pp_recycle_released_ref;
-#endif
 #ifdef CONFIG_MLX5_EN_TLS
 	u64 tls_decrypted_packets;
 	u64 tls_decrypted_bytes;
-- 
2.47.2


