Return-Path: <linux-rdma+bounces-8466-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DF2A56741
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 12:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0B118992A0
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961C8218AB3;
	Fri,  7 Mar 2025 11:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dmnWh04R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JVtNB3WZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF9E218587;
	Fri,  7 Mar 2025 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348652; cv=none; b=J5J1fKHuAnHSZMSXMO/ZxDHkYjXIbdfsuTZbm0gSk1NYNGTL2N5lk5QN6D2ufqzz383YgGz84xjDeOFmcVYWkg1rqerc5GrLrWKJWzAHlxDAk7WJDfrBhw/+U1yRx5MGU7zqCZnOblbZ6J78ZURf/G1OfH+a94Z+mGBCfqdvJ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348652; c=relaxed/simple;
	bh=ZMa2qkoF4qUajjpRQm/C3r6/ukbk7udvGjF2x6psW/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmAMzaks/nhisuvADmHz6AMUgxzF6MT2CRYw3due5eA0463SvuAhs49Evkd/SC67XXaV/6Qo+rc5jWXa83dUxq8IhQvMQxjtUF94P7AmRH2wq7467+RlWag4DT8oFCFHjuUg/Ktf2leIgv5RnSF8v/i+vpXyFMJ4emYgbZNxWK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dmnWh04R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JVtNB3WZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741348648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xl1XW/KrvUaIfMMAnBqO32hrrs9CwivOeTV1oAsGsxI=;
	b=dmnWh04R39qmNckXlgjmn31FmzEkhuulkEYMOhnPraM6UvgRUUOjD+JHbkldUQXYFYUipC
	kcKU2jMEVUjmSCgAkqjmv9+cDouV0BWSNJHAAJ1k4AWr6iwf0+UkuSfg0q3nO9pdG/35ep
	E7J0yR9MEH6VQBDCFq65C9sWG/Vcvp+nDJk0UreT+JASZcQtRs2QFpbWQ2SlDOViGoz53Y
	cbSzpEaZgq2v527+7/YwqEnzRVIVPceTYTkdZrgYipd8Liz+Ydica0Ldx/qkQ9gP5eGFqR
	8xh8LTXuWSLoC0iyGrV55y+wwoR/r1E9NmYQ1AMkLaFPStWleP/wGdnKZR+LDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741348648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xl1XW/KrvUaIfMMAnBqO32hrrs9CwivOeTV1oAsGsxI=;
	b=JVtNB3WZPZ3VIKM00mz4TGLoyB2tFbrgWBvgHZld0hinuK7xUgAMRhEgfTt+9VgodTXxOu
	l8gXBlz7WHato9Cw==
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
Subject: [PATCH net-next v2 2/5] page_pool: Add per-queue statistics.
Date: Fri,  7 Mar 2025 12:57:19 +0100
Message-ID: <20250307115722.705311-3-bigeasy@linutronix.de>
In-Reply-To: <20250307115722.705311-1-bigeasy@linutronix.de>
References: <20250307115722.705311-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The mlx5 driver supports per-channel statistics. To make support generic
it is required to have a template to fill the individual channel/ queue.

Provide page_pool_ethtool_stats_get_strings_mq() to fill the strings for
multiple queue.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/net/page_pool/helpers.h |  5 +++++
 net/core/page_pool.c            | 23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helper=
s.h
index 4622db90f88f2..a815b0ff97448 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -62,6 +62,7 @@
 /* Deprecated driver-facing API, use netlink instead */
 int page_pool_ethtool_stats_get_count(void);
 u8 *page_pool_ethtool_stats_get_strings(u8 *data);
+void page_pool_ethtool_stats_get_strings_mq(u8 **data, unsigned int queue);
 u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats);
=20
 bool page_pool_get_stats(const struct page_pool *pool,
@@ -77,6 +78,10 @@ static inline u8 *page_pool_ethtool_stats_get_strings(u8=
 *data)
 	return data;
 }
=20
+static inline void page_pool_ethtool_stats_get_strings_mq(u8 **data, unsig=
ned int queue)
+{
+}
+
 static inline u64 *page_pool_ethtool_stats_get(u64 *data, const void *stat=
s)
 {
 	return data;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index f5e908c9e7ad8..2290d80443d1e 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -68,6 +68,20 @@ static const char pp_stats[][ETH_GSTRING_LEN] =3D {
 	"rx_pp_recycle_released_ref",
 };
=20
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
 /**
  * page_pool_get_stats() - fetch page pool stats
  * @pool:	pool from which page was allocated
@@ -123,6 +137,15 @@ u8 *page_pool_ethtool_stats_get_strings(u8 *data)
 }
 EXPORT_SYMBOL(page_pool_ethtool_stats_get_strings);
=20
+void page_pool_ethtool_stats_get_strings_mq(u8 **data, unsigned int queue)
+{
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(pp_stats_mq); i++)
+		ethtool_sprintf(data, pp_stats_mq[i], queue);
+}
+EXPORT_SYMBOL(page_pool_ethtool_stats_get_strings_mq);
+
 int page_pool_ethtool_stats_get_count(void)
 {
 	return ARRAY_SIZE(pp_stats);
--=20
2.47.2


