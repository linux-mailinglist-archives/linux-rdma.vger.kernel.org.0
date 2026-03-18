Return-Path: <linux-rdma+bounces-18315-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PgrDzibumnaZQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18315-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 13:31:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A172BB829
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 13:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70CD931AA4C0
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 12:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686543D668E;
	Wed, 18 Mar 2026 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efR4udBb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285DE3BA25B;
	Wed, 18 Mar 2026 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773836782; cv=none; b=IX1jPfUfElA/Tfwc3cTWLfQ1DtrWM4cRJnNtnXPj7mAmg7T94GlJugkzR/Pbul4zP5KV2WOnf1Mu7SJDSkmsYUlKo0ds58ZlsAMb3Ng40jROrUMNmZNGdsb1M1CFZRGdGDkXQZuRbRIHquAMRZHWCzkOnPsLryWY5B8LxCoJerE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773836782; c=relaxed/simple;
	bh=uE10lGHHiHqiFzRyE1cjeLFAi3qrysOE5m57at1b8P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGmUAIVb3AVttZmJmJxv/cJy496m4YBO6FzvMfbhR9Hb5SLnZJ+ID35aov4e9sWqg2Bg6w4YJLVGW2SnNzrk37brddcH0fEekZUDE7xoSZa+HKQLc4mRJvf9Z/TH9wEhGu7xGJAwdH52QSdj5Z+edw0ht5PqDsmiM44Jan7uPKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efR4udBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677A5C19421;
	Wed, 18 Mar 2026 12:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773836781;
	bh=uE10lGHHiHqiFzRyE1cjeLFAi3qrysOE5m57at1b8P8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=efR4udBbB7gBcuj6x9qVJ7QvrBBtg3GKxgIaaYtlZU9y0ogfQcznQbI140r6waSrm
	 329TNHu+T46ucDCiV9jqw+JQ80euLVRR9rBQyzoqQZ8/29riwRzG0XQmdX7eCobUcb
	 8dkvYTI9rh8QDrAtAnIlQXQqraXrozuSJD1dCt72toHzVwSHHZRsPmk0FiLGwwol69
	 8CJ6HEp8l22W0xpO4ywljK0sGQEY0tlcV3uZGTip2mCJT3QRYdOr2qIuFkEmx9GZav
	 E/XkwMu4bl0bdCBu6n/fSMMoprRTXpf8eCZoMgsPuf78/LjJN8lGF0RvF7O8YQBugF
	 94tic+zSv0qzw==
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
Subject: [PATCH net-next v6 2/4] ethtool: Add RSS indirection table resize helpers
Date: Wed, 18 Mar 2026 13:25:59 +0100
Message-ID: <20260318122603.264550-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318122603.264550-1-bjorn@kernel.org>
References: <20260318122603.264550-1-bjorn@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-18315-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8A172BB829
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
index d4d3c57bc7c0..51107b7e739e 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -218,6 +218,12 @@ static inline u8 *ethtool_rxfh_context_key(struct ethtool_rxfh_context *ctx)
 
 void ethtool_rxfh_context_lost(struct net_device *dev, u32 context_id);
 void ethtool_rxfh_indir_clear(struct net_device *dev);
+bool ethtool_rxfh_indir_can_resize(struct net_device *dev, const u32 *tbl,
+				   u32 old_size, u32 new_size);
+void ethtool_rxfh_indir_resize(struct net_device *dev, u32 *tbl,
+			       u32 old_size, u32 new_size);
+int ethtool_rxfh_ctxs_can_resize(struct net_device *dev, u32 new_indir_size);
+void ethtool_rxfh_ctxs_resize(struct net_device *dev, u32 new_indir_size);
 
 struct link_mode_info {
 	int	speed;
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index ee91f1155830..bf795766f526 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -1224,6 +1224,161 @@ void ethtool_rxfh_indir_clear(struct net_device *dev)
 }
 EXPORT_SYMBOL(ethtool_rxfh_indir_clear);
 
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


