Return-Path: <linux-rdma+bounces-9227-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC48A7FDC7
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 13:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3AF11892A42
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 11:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F28269B18;
	Tue,  8 Apr 2025 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rsaNxD2m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pnHKwzl/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D918B26989B;
	Tue,  8 Apr 2025 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109972; cv=none; b=ckCiBRrTejdQKKiZUknxjsxAJqXua408vHoPgjSNwBhJItdzddyI5LR4NAUTDUqi313zgOdNCuVekP3Iae6fChapZILD5/B1QPZuTrB8AKx98eFuSUgTFfWDbRHVKvw2+QadATbCrLv3fbya4/vAMz9lOSp4gCHRNSiatM5kWpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109972; c=relaxed/simple;
	bh=AYCAW1uBraBvmZAQAR2RODAgEz33gEySb1K6jMRa+uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suuVisqQzz9Cj+0ZOeSyB76YDd99OkpD6d+ueiEuytY7Di+mczD42+CiMCESGOUfNGC5Y81jzpVfQiJb7un8vafxZRH87SyuJDihPEEAcLNTLmAv5gJs0SeIz1J3hsMPA7BrpdG9WVaqfTnWRxo8AzYQoKuifgtA1zzeNVir/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rsaNxD2m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pnHKwzl/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744109968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jxq/2m3oZMzj6bJ7jxFGK6i17DfvLYdPwSlsa3REek0=;
	b=rsaNxD2mMKU3qZZ7Lr8WNVT+1QTgkmhcy4laS/GnyrfOMrFlVPBDJVxzhQOmh3DYd6O/+j
	J5HsJ6UZXxXgM5ju2SD7JV8A45t819rCVCtn1ot8oGihsXWxwi91Ba601Vq7rR+f4cs4Da
	Gfobd5YnrE0rJjGDBuACnS0NFIQeLyqDzvyYK8FHLLDlEvPFvZuyUsuRtkAYuY2HNBcSAb
	SJrmFeXhkde9MhcgqY96TMt8/HKtc5xneupK3soxwUSMwzRGxUuSEYnLSBZhiw5PDLrZqU
	+lOPB8Mq6a9YxkHeyLOCEjH5QetrCmkXFq5V3a5Lq95vnY0cuQhxe5NCDteliQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744109968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jxq/2m3oZMzj6bJ7jxFGK6i17DfvLYdPwSlsa3REek0=;
	b=pnHKwzl/ZBue88TddQX/HRi7DpSArLBlXbMrUKePTH/6GvqNxvFgIYXzI8U4ihQeM0/n+S
	5z5CcP5ie9Ui5yBQ==
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
Subject: [PATCH net-next v3 1/4] mlnx5: Use generic code for page_pool statistics.
Date: Tue,  8 Apr 2025 12:59:18 +0200
Message-ID: <20250408105922.1135150-2-bigeasy@linutronix.de>
In-Reply-To: <20250408105922.1135150-1-bigeasy@linutronix.de>
References: <20250408105922.1135150-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The statistics gathering code for page_pool statistics has multiple
steps:
- gather statistics from a channel via page_pool_get_stats() to an
  on-stack structure.
- copy this data to dedicated rq_stats.
- copy the data from rq_stats global mlx5e_sw_stats structure, and merge
  per-queue statistics into one counter.
- Finally copy the data in specific order for the ethtool query (both
  per queue and all queues summed up).

The downside here is that the individual counter types are expected to
be u64 and if something changes, the code breaks. Also if additional
counter are added to struct page_pool_stats then they are not
automatically picked up by the driver but need to be manually added in
all four spots.

Remove the page_pool_stats related description from sw_stats_desc and
rq_stats_desc.
Replace the counters in mlx5e_sw_stats and mlx5e_rq_stats with struct
page_pool_stats.
Let mlx5e_stats_update_stats_rq_page_pool() fetch the stats for
page_pool twice: One for the summed up data, one for the individual
queue.
Publish the strings via page_pool_ethtool_stats_get_strings() and
mlx_page_pool_stats_get_strings_mq().
Publish the counter via page_pool_ethtool_stats_get().

Suggested-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 97 ++++++++-----------
 .../ethernet/mellanox/mlx5/core/en_stats.h    | 26 +----
 2 files changed, 43 insertions(+), 80 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/en_stats.c
index 1c121b435016d..54303877adb1d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -194,17 +194,6 @@ static const struct counter_desc sw_stats_desc[] =3D {
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_arfs_err) },
 #endif
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_recover) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_fast) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_slow) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_slow_high_order) =
},
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_empty) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_refill) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_waive) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_cached) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_cache_full) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_ring) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_ring_full) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_released_ref) },
 #ifdef CONFIG_MLX5_EN_TLS
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_tls_decrypted_packets) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_tls_decrypted_bytes) },
@@ -253,7 +242,7 @@ static const struct counter_desc sw_stats_desc[] =3D {
=20
 static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(sw)
 {
-	return NUM_SW_COUNTERS;
+	return NUM_SW_COUNTERS + page_pool_ethtool_stats_get_count();
 }
=20
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(sw)
@@ -262,6 +251,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(sw)
=20
 	for (i =3D 0; i < NUM_SW_COUNTERS; i++)
 		ethtool_puts(data, sw_stats_desc[i].format);
+	*data =3D page_pool_ethtool_stats_get_strings(*data);
 }
=20
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(sw)
@@ -272,6 +262,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(sw)
 		mlx5e_ethtool_put_stat(data,
 				       MLX5E_READ_CTR64_CPU(&priv->stats.sw,
 							    sw_stats_desc, i));
+	*data =3D page_pool_ethtool_stats_get(*data, &priv->stats.sw.page_pool_st=
ats);
 }
=20
 static void mlx5e_stats_grp_sw_update_stats_xdp_red(struct mlx5e_sw_stats =
*s,
@@ -373,17 +364,6 @@ static void mlx5e_stats_grp_sw_update_stats_rq_stats(s=
truct mlx5e_sw_stats *s,
 	s->rx_arfs_err                +=3D rq_stats->arfs_err;
 #endif
 	s->rx_recover                 +=3D rq_stats->recover;
-	s->rx_pp_alloc_fast          +=3D rq_stats->pp_alloc_fast;
-	s->rx_pp_alloc_slow          +=3D rq_stats->pp_alloc_slow;
-	s->rx_pp_alloc_empty         +=3D rq_stats->pp_alloc_empty;
-	s->rx_pp_alloc_refill        +=3D rq_stats->pp_alloc_refill;
-	s->rx_pp_alloc_waive         +=3D rq_stats->pp_alloc_waive;
-	s->rx_pp_alloc_slow_high_order		+=3D rq_stats->pp_alloc_slow_high_order;
-	s->rx_pp_recycle_cached			+=3D rq_stats->pp_recycle_cached;
-	s->rx_pp_recycle_cache_full		+=3D rq_stats->pp_recycle_cache_full;
-	s->rx_pp_recycle_ring			+=3D rq_stats->pp_recycle_ring;
-	s->rx_pp_recycle_ring_full		+=3D rq_stats->pp_recycle_ring_full;
-	s->rx_pp_recycle_released_ref		+=3D rq_stats->pp_recycle_released_ref;
 #ifdef CONFIG_MLX5_EN_TLS
 	s->rx_tls_decrypted_packets   +=3D rq_stats->tls_decrypted_packets;
 	s->rx_tls_decrypted_bytes     +=3D rq_stats->tls_decrypted_bytes;
@@ -490,27 +470,13 @@ static void mlx5e_stats_grp_sw_update_stats_qos(struc=
t mlx5e_priv *priv,
 	}
 }
=20
-static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_channel *c)
+static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_sw_stats *s,
+						  struct mlx5e_channel *c)
 {
 	struct mlx5e_rq_stats *rq_stats =3D c->rq.stats;
-	struct page_pool *pool =3D c->rq.page_pool;
-	struct page_pool_stats stats =3D { 0 };
=20
-	if (!page_pool_get_stats(pool, &stats))
-		return;
-
-	rq_stats->pp_alloc_fast =3D stats.alloc_stats.fast;
-	rq_stats->pp_alloc_slow =3D stats.alloc_stats.slow;
-	rq_stats->pp_alloc_slow_high_order =3D stats.alloc_stats.slow_high_order;
-	rq_stats->pp_alloc_empty =3D stats.alloc_stats.empty;
-	rq_stats->pp_alloc_waive =3D stats.alloc_stats.waive;
-	rq_stats->pp_alloc_refill =3D stats.alloc_stats.refill;
-
-	rq_stats->pp_recycle_cached =3D stats.recycle_stats.cached;
-	rq_stats->pp_recycle_cache_full =3D stats.recycle_stats.cache_full;
-	rq_stats->pp_recycle_ring =3D stats.recycle_stats.ring;
-	rq_stats->pp_recycle_ring_full =3D stats.recycle_stats.ring_full;
-	rq_stats->pp_recycle_released_ref =3D stats.recycle_stats.released_refcnt;
+	page_pool_get_stats(c->rq.page_pool, &s->page_pool_stats);
+	page_pool_get_stats(c->rq.page_pool, &rq_stats->page_pool_stats);
 }
=20
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(sw)
@@ -520,15 +486,13 @@ static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(sw)
=20
 	memset(s, 0, sizeof(*s));
=20
-	for (i =3D 0; i < priv->channels.num; i++) /* for active channels only */
-		mlx5e_stats_update_stats_rq_page_pool(priv->channels.c[i]);
-
 	for (i =3D 0; i < priv->stats_nch; i++) {
 		struct mlx5e_channel_stats *channel_stats =3D
 			priv->channel_stats[i];
=20
 		int j;
=20
+		mlx5e_stats_update_stats_rq_page_pool(s, priv->channels.c[i]);
 		mlx5e_stats_grp_sw_update_stats_rq_stats(s, &channel_stats->rq);
 		mlx5e_stats_grp_sw_update_stats_xdpsq(s, &channel_stats->rq_xdpsq);
 		mlx5e_stats_grp_sw_update_stats_ch_stats(s, &channel_stats->ch);
@@ -2119,17 +2083,6 @@ static const struct counter_desc rq_stats_desc[] =3D=
 {
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, arfs_err) },
 #endif
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, recover) },
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_fast) },
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_slow) },
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_slow_high_order) =
},
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_empty) },
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_refill) },
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_waive) },
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_cached) },
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_cache_full) },
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_ring) },
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_ring_full) },
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_released_ref) },
 #ifdef CONFIG_MLX5_EN_TLS
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, tls_decrypted_packets) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, tls_decrypted_bytes) },
@@ -2477,7 +2430,32 @@ static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(channels)
 	       (NUM_RQ_XDPSQ_STATS * max_nch) +
 	       (NUM_XDPSQ_STATS * max_nch) +
 	       (NUM_XSKRQ_STATS * max_nch * priv->xsk.ever_used) +
-	       (NUM_XSKSQ_STATS * max_nch * priv->xsk.ever_used);
+	       (NUM_XSKSQ_STATS * max_nch * priv->xsk.ever_used) +
+	       page_pool_ethtool_stats_get_count() * max_nch;
+}
+
+static const char pp_stats_mq[][ETH_GSTRING_LEN] =3D {
+	"rx%d_pp_alloc_fast",
+	"rx%d_pp_alloc_slow",
+	"rx%d_pp_alloc_slow_ho",
+	"rx%d_pp_alloc_empty",
+	"rx%d_pp_alloc_refill",
+	"rx%d_pp_alloc_waive",
+	"rx%d_pp_recycle_cached",
+	"rx%d_pp_recycle_cache_full",
+	"rx%d_pp_recycle_ring",
+	"rx%d_pp_recycle_ring_full",
+	"rx%d_pp_recycle_released_ref",
+};
+
+static void mlx_page_pool_stats_get_strings_mq(u8 **data, unsigned int que=
ue)
+{
+	int i;
+
+	WARN_ON_ONCE(ARRAY_SIZE(pp_stats_mq) !=3D page_pool_ethtool_stats_get_cou=
nt());
+
+	for (i =3D 0; i < ARRAY_SIZE(pp_stats_mq); i++)
+		ethtool_sprintf(data, pp_stats_mq[i], queue);
 }
=20
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(channels)
@@ -2493,6 +2471,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(channels)
 	for (i =3D 0; i < max_nch; i++) {
 		for (j =3D 0; j < NUM_RQ_STATS; j++)
 			ethtool_sprintf(data, rq_stats_desc[j].format, i);
+		mlx_page_pool_stats_get_strings_mq(data, i);
 		for (j =3D 0; j < NUM_XSKRQ_STATS * is_xsk; j++)
 			ethtool_sprintf(data, xskrq_stats_desc[j].format, i);
 		for (j =3D 0; j < NUM_RQ_XDPSQ_STATS; j++)
@@ -2527,11 +2506,13 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(channe=
ls)
 					      ch_stats_desc, j));
=20
 	for (i =3D 0; i < max_nch; i++) {
+		struct mlx5e_rq_stats *rq_stats =3D &priv->channel_stats[i]->rq;
+
 		for (j =3D 0; j < NUM_RQ_STATS; j++)
 			mlx5e_ethtool_put_stat(
-				data, MLX5E_READ_CTR64_CPU(
-					      &priv->channel_stats[i]->rq,
+				data, MLX5E_READ_CTR64_CPU(rq_stats,
 					      rq_stats_desc, j));
+		*data =3D page_pool_ethtool_stats_get(*data, &rq_stats->page_pool_stats);
 		for (j =3D 0; j < NUM_XSKRQ_STATS * is_xsk; j++)
 			mlx5e_ethtool_put_stat(
 				data, MLX5E_READ_CTR64_CPU(
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/n=
et/ethernet/mellanox/mlx5/core/en_stats.h
index 8de6fcbd3a033..30c5c2a92508b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -33,6 +33,8 @@
 #ifndef __MLX5_EN_STATS_H__
 #define __MLX5_EN_STATS_H__
=20
+#include <net/page_pool/types.h>
+
 #define MLX5E_READ_CTR64_CPU(ptr, dsc, i) \
 	(*(u64 *)((char *)ptr + dsc[i].offset))
 #define MLX5E_READ_CTR64_BE(ptr, dsc, i) \
@@ -215,17 +217,7 @@ struct mlx5e_sw_stats {
 	u64 ch_aff_change;
 	u64 ch_force_irq;
 	u64 ch_eq_rearm;
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
 #ifdef CONFIG_MLX5_EN_TLS
 	u64 tx_tls_encrypted_packets;
 	u64 tx_tls_encrypted_bytes;
@@ -383,17 +375,7 @@ struct mlx5e_rq_stats {
 	u64 arfs_err;
 #endif
 	u64 recover;
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
+	struct page_pool_stats page_pool_stats;
 #ifdef CONFIG_MLX5_EN_TLS
 	u64 tls_decrypted_packets;
 	u64 tls_decrypted_bytes;
--=20
2.49.0


