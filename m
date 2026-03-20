Return-Path: <linux-rdma+bounces-18439-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIpaNHwNvWkO5gIAu9opvQ
	(envelope-from <linux-rdma+bounces-18439-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 10:03:56 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7127E2D7B16
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 10:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C312A31193F4
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 08:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476D43783AB;
	Fri, 20 Mar 2026 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdC1rSKM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C09349AF4;
	Fri, 20 Mar 2026 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773997122; cv=none; b=tBBfpPCjp9Mdy9erMG2ZIGv6iSULzboY6Bhtnqk9Pb0CkhmQLt6n+r3bSLs/hnqnT4/A+qGu7VET8+8fGywUDNSQ1p8cYe8c/htVNXu8rsjnFrNMa1QDJKZYXYf0eWHYHqe3/V1HA36v++LlG4JYE3bvxiXBOt1bMNpX6OubU/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773997122; c=relaxed/simple;
	bh=UCZU47xUTkuidjKDjsLx518TuD1e6dVmduvG2zfO1Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVFG00y1asG1enE4wCnw1OeWGo9gIphYMtSFqpligBFKVuA/O5IPr8uUiPl8NuV9BpiPgCUdxEzgE1XKbf4ryipffeQcVhzz56LsBbSiptsyzIYDiHmK8BHc9bo2gmhXeccmaunwVwzc7GXPUc81RBNtgtOVs9l/0kgOrOENBdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdC1rSKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB61FC2BCB0;
	Fri, 20 Mar 2026 08:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773997121;
	bh=UCZU47xUTkuidjKDjsLx518TuD1e6dVmduvG2zfO1Gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XdC1rSKMJSnxSaVxtXpvBzgM+9VPTmQTz2sHm/KaxZAO1xUAeBxkV+ZDNVZQzylkp
	 0at9Q3HxdpX/9xc7SsMPp626LMLOrxHOmOkXSNjjjfCcLCGJjwvMoGZFtkdu6ZYpe0
	 1L3iqftAvJDiIkkZutRQ2/SPUOF3nZoRaIzR4NB2EzZIEagyCSMl0kL04QlX+D5bQz
	 i6q17ISOZypGBaZEfVb9UTy7Ficc2gezM70jW9hsfhjuSXIdQEn1pqK7z1SK08vl7g
	 AER9YkAa2HDXAKoNOqNGQV9uNw90pZtzKik99BfuaA1wekNxQwunRBloxrnpS/OY2l
	 PQmRXoCDSbVIQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v7 2/4] ethtool: Add RSS indirection table resize helpers
Date: Fri, 20 Mar 2026 09:58:22 +0100
Message-ID: <20260320085826.1957255-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320085826.1957255-1-bjorn@kernel.org>
References: <20260320085826.1957255-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.96 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18439-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7127E2D7B16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The core locks ctx->indir_size when an RSS context is created. Some
NICs (e.g. bnxt) change their indirection table size based on the
channel count, because the hardware table is a shared resource. This
forces drivers to reject channel changes when RSS contexts exist.

Add driver helpers to resize indirection tables:

ethtool_rxfh_indir_can_resize() checks whether the default context
indirection table can be resized.

ethtool_rxfh_indir_resize() resizes the default context table in
place. Folding (shrink) requires the table to be periodic at the new
size; non-periodic tables are rejected. Unfolding (grow) replicates
the existing pattern. Sizes must be multiples of each other.

ethtool_rxfh_ctxs_can_resize() validates all non-default RSS contexts
can be resized.

ethtool_rxfh_ctxs_resize() applies the resize.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 include/linux/ethtool.h |   6 ++
 net/ethtool/common.c    | 155 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 161 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 34ca9261de82..1cb0740ba331 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -218,6 +218,12 @@ static inline u8 *ethtool_rxfh_context_key(struct ethtool_rxfh_context *ctx)
 
 void ethtool_rxfh_context_lost(struct net_device *dev, u32 context_id);
 void ethtool_rxfh_indir_lost(struct net_device *dev);
+bool ethtool_rxfh_indir_can_resize(struct net_device *dev, const u32 *tbl,
+				   u32 old_size, u32 new_size);
+void ethtool_rxfh_indir_resize(struct net_device *dev, u32 *tbl,
+			       u32 old_size, u32 new_size);
+int ethtool_rxfh_ctxs_can_resize(struct net_device *dev, u32 new_indir_size);
+void ethtool_rxfh_ctxs_resize(struct net_device *dev, u32 new_indir_size);
 
 struct link_mode_info {
 	int	speed;
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index d7d832fa9e00..ec9e45b5cc89 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -1232,6 +1232,161 @@ void ethtool_rxfh_indir_lost(struct net_device *dev)
 }
 EXPORT_SYMBOL(ethtool_rxfh_indir_lost);
 
+static bool ethtool_rxfh_is_periodic(const u32 *tbl, u32 old_size, u32 new_size)
+{
+	u32 i;
+
+	for (i = new_size; i < old_size; i++)
+		if (tbl[i] != tbl[i % new_size])
+			return false;
+	return true;
+}
+
+static bool ethtool_rxfh_can_resize(const u32 *tbl, u32 old_size, u32 new_size,
+				    u32 user_size)
+{
+	if (new_size == old_size)
+		return true;
+
+	if (!user_size)
+		return true;
+
+	if (new_size < old_size) {
+		if (new_size < user_size)
+			return false;
+		if (old_size % new_size)
+			return false;
+		if (!ethtool_rxfh_is_periodic(tbl, old_size, new_size))
+			return false;
+		return true;
+	}
+
+	if (new_size % old_size)
+		return false;
+	return true;
+}
+
+/* Resize without validation; caller must have called can_resize first */
+static void ethtool_rxfh_resize(u32 *tbl, u32 old_size, u32 new_size)
+{
+	u32 i;
+
+	/* Grow: replicate existing pattern; shrink is a no-op on the data */
+	for (i = old_size; i < new_size; i++)
+		tbl[i] = tbl[i % old_size];
+}
+
+/**
+ * ethtool_rxfh_indir_can_resize - Check if context 0 indir table can resize
+ * @dev: network device
+ * @tbl: indirection table
+ * @old_size: current number of entries in the table
+ * @new_size: desired number of entries
+ *
+ * Validate that @tbl can be resized from @old_size to @new_size without
+ * data loss. Uses the user_size floor from context 0. When user_size is
+ * zero the table is not user-configured and resize always succeeds.
+ * Read-only; does not modify the table.
+ *
+ * Return: true if resize is possible, false otherwise.
+ */
+bool ethtool_rxfh_indir_can_resize(struct net_device *dev, const u32 *tbl,
+				   u32 old_size, u32 new_size)
+{
+	return ethtool_rxfh_can_resize(tbl, old_size, new_size,
+				       dev->ethtool->rss_indir_user_size);
+}
+EXPORT_SYMBOL(ethtool_rxfh_indir_can_resize);
+
+/**
+ * ethtool_rxfh_indir_resize - Fold or unfold context 0 indirection table
+ * @dev: network device
+ * @tbl: indirection table (must have room for max(old_size, new_size) entries)
+ * @old_size: current number of entries in the table
+ * @new_size: desired number of entries
+ *
+ * Resize the default RSS context indirection table in place. Caller
+ * must have validated with ethtool_rxfh_indir_can_resize() first.
+ */
+void ethtool_rxfh_indir_resize(struct net_device *dev, u32 *tbl,
+			       u32 old_size, u32 new_size)
+{
+	if (!dev->ethtool->rss_indir_user_size)
+		return;
+
+	ethtool_rxfh_resize(tbl, old_size, new_size);
+}
+EXPORT_SYMBOL(ethtool_rxfh_indir_resize);
+
+/**
+ * ethtool_rxfh_ctxs_can_resize - Validate resize for all RSS contexts
+ * @dev: network device
+ * @new_indir_size: new indirection table size
+ *
+ * Validate that the indirection tables of all non-default RSS contexts
+ * can be resized to @new_indir_size. Read-only; does not modify any
+ * context. Intended to be paired with ethtool_rxfh_ctxs_resize().
+ *
+ * Return: 0 if all contexts can be resized, negative errno on failure.
+ */
+int ethtool_rxfh_ctxs_can_resize(struct net_device *dev, u32 new_indir_size)
+{
+	struct ethtool_rxfh_context *ctx;
+	unsigned long context;
+	int ret = 0;
+
+	if (!dev->ethtool_ops->rxfh_indir_space ||
+	    new_indir_size > dev->ethtool_ops->rxfh_indir_space)
+		return -EINVAL;
+
+	mutex_lock(&dev->ethtool->rss_lock);
+	xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
+		u32 *indir = ethtool_rxfh_context_indir(ctx);
+
+		if (!ethtool_rxfh_can_resize(indir, ctx->indir_size,
+					     new_indir_size,
+					     ctx->indir_user_size)) {
+			ret = -EINVAL;
+			goto unlock;
+		}
+	}
+unlock:
+	mutex_unlock(&dev->ethtool->rss_lock);
+	return ret;
+}
+EXPORT_SYMBOL(ethtool_rxfh_ctxs_can_resize);
+
+/**
+ * ethtool_rxfh_ctxs_resize - Resize all RSS context indirection tables
+ * @dev: network device
+ * @new_indir_size: new indirection table size
+ *
+ * Resize the indirection table of every non-default RSS context to
+ * @new_indir_size. Caller must have validated with
+ * ethtool_rxfh_ctxs_can_resize() first. An %ETHTOOL_MSG_RSS_NTF is
+ * sent for each resized context.
+ *
+ * Notifications are sent outside the RSS lock to avoid holding the
+ * mutex during notification delivery.
+ */
+void ethtool_rxfh_ctxs_resize(struct net_device *dev, u32 new_indir_size)
+{
+	struct ethtool_rxfh_context *ctx;
+	unsigned long context;
+
+	mutex_lock(&dev->ethtool->rss_lock);
+	xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
+		ethtool_rxfh_resize(ethtool_rxfh_context_indir(ctx),
+				    ctx->indir_size, new_indir_size);
+		ctx->indir_size = new_indir_size;
+	}
+	mutex_unlock(&dev->ethtool->rss_lock);
+
+	xa_for_each(&dev->ethtool->rss_ctx, context, ctx)
+		ethtool_rss_notify(dev, ETHTOOL_MSG_RSS_NTF, context);
+}
+EXPORT_SYMBOL(ethtool_rxfh_ctxs_resize);
+
 enum ethtool_link_medium ethtool_str_to_medium(const char *str)
 {
 	int i;
-- 
2.53.0


