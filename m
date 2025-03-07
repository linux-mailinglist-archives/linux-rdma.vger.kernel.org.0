Return-Path: <linux-rdma+bounces-8464-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC95A5673E
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 12:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F9497A312E
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 11:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11702185B1;
	Fri,  7 Mar 2025 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="waGdBjMN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N/zfUSI9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DD221859F;
	Fri,  7 Mar 2025 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348651; cv=none; b=YWAAWvn2GKDo/IXocRL1qEkLkQvIDJ+FhQvgivEHHmLncVfMvSB12pZEwzsDjcuXeHkTmJvzxJFDRewcR+zJUL0xqUAw8jFP1bLMmL0Wh824OSNKwK4CYeVSv2NpaaUPJQASUT7JKI/OkUZcOR/EtqDtAEHzkB3fPx0L2efkkPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348651; c=relaxed/simple;
	bh=W6VQ+V1nmHstDdIlqfgtyjfcPs3sY566gSTVH5r0RV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLVmH7V8mpCDQZJM/dSAycd5p7mZta98tR9wLXEhjS0ca/WynWWCdYU6h9n4ytUl/y1he8Kc3MwYVKSIiFUP4gIMtY0A4LguANYf3pGhCU/K71cLsd9/ryJ0sdEXnJSWUlOjqBLK80efJJ1trJS0DpkS/tEXXeKOtx6ZCOUOisU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=waGdBjMN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N/zfUSI9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741348648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NOG038PWXRpibdztyql3sjzUMzeQfzjYIj73kOiBeMY=;
	b=waGdBjMN3L0P7GIYmRWc/w0ckswrLeqSCbCh5UAqWqQgmg1dU6NMQPu1rhDjH174kS6yZY
	MeK/kQMdg6sT9MjB3oRrU2PaoZU08tEXZdZAcWbA9kg6FLkvSpLsOSyP3rpbx9Ncs5XTcx
	OIC+1ngOros5sbngC3Iah9AaVSnf3JNHI4HZ+wbVhObSn1vwXON9m8wS6Tc7eCti4dtTEo
	QiH83R5vwg4AlCbcNvnHpFrLO3MWpXedZ4RwRAnXKlSKZNHfqbqxQ8mpqCPJUxdQE3iDSY
	8gZvWGSBCiuQKyNXawYFNfFdKW7ZgyFOEZG+33IjZw3fsaM9nRKghrY+S9hKAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741348648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NOG038PWXRpibdztyql3sjzUMzeQfzjYIj73kOiBeMY=;
	b=N/zfUSI9sT6hiVTKZKg/gpOvl6mCFm6wxR8DWzaQgONOFEMqMPUavBHQJ3CgSK2m0qY9oT
	FQ8+ZnMucrdjQoCw==
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
Subject: [PATCH net-next v2 1/5] page_pool: Provide an empty page_pool_stats for disabled stats.
Date: Fri,  7 Mar 2025 12:57:18 +0100
Message-ID: <20250307115722.705311-2-bigeasy@linutronix.de>
In-Reply-To: <20250307115722.705311-1-bigeasy@linutronix.de>
References: <20250307115722.705311-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

An empty struct page_pool_stats allows to always add it to structs and
pass it to functions like page_pool_ethtool_stats_get() without the need
for an ifdef.

Provide an empty struct page_pool_stats and page_pool_get_stats() for
!CONFIG_PAGE_POOL_STATS builds.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/net/page_pool/helpers.h | 6 ++++++
 include/net/page_pool/types.h   | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helper=
s.h
index 582a3d00cbe23..4622db90f88f2 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -81,6 +81,12 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data=
, const void *stats)
 {
 	return data;
 }
+
+static inline bool page_pool_get_stats(const struct page_pool *pool,
+				       struct page_pool_stats *stats)
+{
+	return false;
+}
 #endif
=20
 /**
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 7f405672b089d..6d55e6cf5d0db 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -140,6 +140,10 @@ struct page_pool_stats {
 	struct page_pool_alloc_stats alloc_stats;
 	struct page_pool_recycle_stats recycle_stats;
 };
+
+#else /* !CONFIG_PAGE_POOL_STATS */
+
+struct page_pool_stats { };
 #endif
=20
 /* The whole frag API block must stay within one cacheline. On 32-bit syst=
ems,
--=20
2.47.2


