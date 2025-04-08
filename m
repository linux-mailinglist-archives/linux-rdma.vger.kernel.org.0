Return-Path: <linux-rdma+bounces-9226-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50072A7FDD2
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 13:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2716179E12
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 11:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55680268691;
	Tue,  8 Apr 2025 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="41iV1lnX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iQvFv2LR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AE42698BE;
	Tue,  8 Apr 2025 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109972; cv=none; b=QqywWkw8Ieildc73qDf5Yv73UhnLn6bsxNnk+xDGbIoq4a8/Hez1XRHygQ7x4WUEBEv+vcYW4eFVxuxLIM98elwkak3pYGDl0hJKG1nHUwyYKDDCxh/MADtmaRI/o4R3EKavnYCQphMJrHlPbd9loGWL2D7mVi/lemcgPqYldxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109972; c=relaxed/simple;
	bh=SWUQSYKewIVbjdXoFz5Rot55BaH0U6iwLrizINd7mjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLiksgTMzqdjSDrhNmuRmi1Cmcxf6vML3QbeUF8lmhVFF45rSRVOTDp8w0FPyfBsdA+TeJui9hbr7OXkKs0QXidMK//5DzplFq3+2IiEA2iQQO291srcBHOo0nhfH7vPNvhfa7ngWPZ20MtGmqwgM9kG2uK+WwxF3LJkZcf0h20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=41iV1lnX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iQvFv2LR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744109968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEyrNykPRu3fGmepVLjNzNB5h6f6axm1TbSDs0t8f5I=;
	b=41iV1lnXbeKFmiUWdGNQ+JwiK9qrDIwktyB1Tutx0CVEYtU0etcpbIee+7MDNOvSxnknF+
	cYvczZXA4XnPkIeNClXspM4NastjzLDmofFPJe4UnIvpwhRNNde+9muT6850ksQHE6hXuf
	4LFrrV8jdvbGUETVAbzjWfC/BjzE80s5b36OwrWRn+EVdscC8RE8xg33mkKvrfngupMDlX
	bUWs9RtR93nTadryISS4Uu+bp7S+iVzoYpPyg6ITN4Q1ufvzQQ8yMj0GosxaYJCLD8BPM/
	HEnSu3GXPqMBituYC1N2f41InIFDS5ZvKLyZqrTC4ekQu82MQPF3wxTfvyeusw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744109968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEyrNykPRu3fGmepVLjNzNB5h6f6axm1TbSDs0t8f5I=;
	b=iQvFv2LRcgFtpJImyZyrbDl36yjqhYZIzDbjjapTLKuOHkS6xg5MYYrKjuwE1Qo6hKtfu2
	h90/Q+3chVIH+PAg==
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
Subject: [PATCH net-next v3 2/4] page_pool: Provide an empty page_pool_stats for disabled stats.
Date: Tue,  8 Apr 2025 12:59:19 +0200
Message-ID: <20250408105922.1135150-3-bigeasy@linutronix.de>
In-Reply-To: <20250408105922.1135150-1-bigeasy@linutronix.de>
References: <20250408105922.1135150-1-bigeasy@linutronix.de>
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

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
index 36eb57d73abc6..15557fe77af2c 100644
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
2.49.0


