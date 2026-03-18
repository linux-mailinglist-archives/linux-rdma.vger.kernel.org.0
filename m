Return-Path: <linux-rdma+bounces-18314-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMAUJSGbumnaZQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18314-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 13:31:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5042BB811
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 13:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40222319A148
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 12:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBEC3D6466;
	Wed, 18 Mar 2026 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0Azya60"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4623BA25B;
	Wed, 18 Mar 2026 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773836777; cv=none; b=kc3ltfLbxQgCTQqEhwomyp33dwAhSu3lE72LiAQ7n+miOlaTx7jJNl7xeSPnwbDyyHeM++RxyfKDPzxQxj3W3GCVSPEiYgwh9ICUuUXbY4PBRcl0zXKcb3K2BtuaKdg54Rgs6UEB6i6s8oBsnO0grPz7S8kFWe+tA21QnCKYR0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773836777; c=relaxed/simple;
	bh=yXlwMeBvYYc1Zb2quhC1vDJ9PdESoBqLNJ0u8zZ3Lig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQAc/Ytvxh2bX0B19Azs7BQAC+ymIuQhHmWgI1Q4VdfdL4ng256H2KGgqWCE69pUMNGameKvahzDH1eWhsznsNMGuDA8so8ammMCgwLNou4BpkAVQczEBekHSZt6hun8yu8xiOwRzxcVKBqp9GOcrCFiwb7xZSgqSlGvLmXv6GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0Azya60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51205C2BCAF;
	Wed, 18 Mar 2026 12:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773836776;
	bh=yXlwMeBvYYc1Zb2quhC1vDJ9PdESoBqLNJ0u8zZ3Lig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i0Azya60rMs34l0J2+rcTOeUE/u63g0z5K53V6oXdGF08Lr7W/aFqIiNixaIwejsc
	 BrTC8NkKX/3+Y5fgZZVnyaFxTBrsWgoZ5rryUiatHQV1AUDPblZU4vnfTaMy1OE8h8
	 I32JpdarYlgTR/B4LEaAuSjvHwZEB8XSQUuE5XXwiRaZMaGOEQasNv5hQ5547TBEFM
	 HyA2kTzPHcJQLAIh7mmPcS8y0i7rsvhEJRdUtZRHdydYBKdTQ7dAlHNLhTaHC4xJRH
	 bNEmxXBoFLPS/c04Xs581dDCb65mSF04TT7CaZPfVEhS693hDXs8YDCsyZ9tC/PJro
	 PYCYQ2LxesEtg==
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
Subject: [PATCH net-next v6 1/4] ethtool: Track user-provided RSS indirection table size
Date: Wed, 18 Mar 2026 13:25:58 +0100
Message-ID: <20260318122603.264550-2-bjorn@kernel.org>
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
X-Spamd-Result: default: False [0.93 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18314-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A5042BB811
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Track the number of indirection table entries the user originally
provided (context 0/default as well!).

Replace IFF_RXFH_CONFIGURED with rss_indir_user_size: the flag is
redundant now that user_size captures the same information.

Add ethtool_rxfh_indir_clear() for drivers that must reset the
indirection table.

Convert bnxt and mlx5 to use it.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  2 +-
 include/linux/ethtool.h                       |  7 ++++++
 include/linux/netdevice.h                     |  7 +-----
 net/ethtool/common.c                          | 20 ++++++++++++++++
 net/ethtool/ioctl.c                           |  9 +++----
 net/ethtool/rss.c                             | 24 ++++++++++++-------
 7 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c982aac714d1..04da3f708b4b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8117,7 +8117,7 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 		     bnxt_get_nr_rss_ctxs(bp, rx_rings) ||
 		     bnxt_get_max_rss_ring(bp) >= rx_rings)) {
 			netdev_warn(bp->dev, "RSS table entries reverting to default\n");
-			bp->dev->priv_flags &= ~IFF_RXFH_CONFIGURED;
+			ethtool_rxfh_indir_clear(bp->dev);
 		}
 	}
 	bp->rx_nr_rings = rx_rings;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index f7009da94f0b..1a010a115cff 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6488,7 +6488,7 @@ int mlx5e_attach_netdev(struct mlx5e_priv *priv)
 		/* Reducing the number of channels - RXFH has to be reset, and
 		 * mlx5e_num_channels_changed below will build the RQT.
 		 */
-		priv->netdev->priv_flags &= ~IFF_RXFH_CONFIGURED;
+		ethtool_rxfh_indir_clear(priv->netdev);
 		priv->channels.params.num_channels = max_nch;
 		if (priv->channels.params.mqprio.mode == TC_MQPRIO_MODE_CHANNEL) {
 			mlx5_core_warn(priv->mdev, "MLX5E: Disabling MQPRIO channel mode\n");
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 83c375840835..d4d3c57bc7c0 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -176,6 +176,8 @@ static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
  * struct ethtool_rxfh_context - a custom RSS context configuration
  * @indir_size: Number of u32 entries in indirection table
  * @key_size: Size of hash key, in bytes
+ * @indir_user_size: number of user provided entries for the
+ *	indirection table
  * @priv_size: Size of driver private data, in bytes
  * @hfunc: RSS hash function identifier.  One of the %ETH_RSS_HASH_*
  * @input_xfrm: Defines how the input data is transformed. Valid values are one
@@ -186,6 +188,7 @@ static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
 struct ethtool_rxfh_context {
 	u32 indir_size;
 	u32 key_size;
+	u32 indir_user_size;
 	u16 priv_size;
 	u8 hfunc;
 	u8 input_xfrm;
@@ -214,6 +217,7 @@ static inline u8 *ethtool_rxfh_context_key(struct ethtool_rxfh_context *ctx)
 }
 
 void ethtool_rxfh_context_lost(struct net_device *dev, u32 context_id);
+void ethtool_rxfh_indir_clear(struct net_device *dev);
 
 struct link_mode_info {
 	int	speed;
@@ -1333,12 +1337,15 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
  * @rss_ctx:		XArray of custom RSS contexts
  * @rss_lock:		Protects entries in @rss_ctx.  May be taken from
  *			within RTNL.
+ * @rss_indir_user_size: Number of user provided entries for the default
+ *			 (context 0) indirection table.
  * @wol_enabled:	Wake-on-LAN is enabled
  * @module_fw_flash_in_progress: Module firmware flashing is in progress.
  */
 struct ethtool_netdev_state {
 	struct xarray		rss_ctx;
 	struct mutex		rss_lock;
+	u32			rss_indir_user_size;
 	unsigned		wol_enabled:1;
 	unsigned		module_fw_flash_in_progress:1;
 };
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ae269a2e7f4d..dc28954d4df6 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1714,7 +1714,6 @@ struct net_device_ops {
  * @IFF_OPENVSWITCH: device is a Open vSwitch master
  * @IFF_L3MDEV_SLAVE: device is enslaved to an L3 master device
  * @IFF_TEAM: device is a team device
- * @IFF_RXFH_CONFIGURED: device has had Rx Flow indirection table configured
  * @IFF_PHONY_HEADROOM: the headroom value is controlled by an external
  *	entity (i.e. the master device for bridged veth)
  * @IFF_MACSEC: device is a MACsec device
@@ -1750,7 +1749,6 @@ enum netdev_priv_flags {
 	IFF_OPENVSWITCH			= 1<<20,
 	IFF_L3MDEV_SLAVE		= 1<<21,
 	IFF_TEAM			= 1<<22,
-	IFF_RXFH_CONFIGURED		= 1<<23,
 	IFF_PHONY_HEADROOM		= 1<<24,
 	IFF_MACSEC			= 1<<25,
 	IFF_NO_RX_HANDLER		= 1<<26,
@@ -5568,10 +5566,7 @@ static inline bool netif_is_lag_port(const struct net_device *dev)
 	return netif_is_bond_slave(dev) || netif_is_team_port(dev);
 }
 
-static inline bool netif_is_rxfh_configured(const struct net_device *dev)
-{
-	return dev->priv_flags & IFF_RXFH_CONFIGURED;
-}
+bool netif_is_rxfh_configured(const struct net_device *dev);
 
 static inline bool netif_is_failover(const struct net_device *dev)
 {
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index e252cf20c22f..ee91f1155830 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -1204,6 +1204,26 @@ void ethtool_rxfh_context_lost(struct net_device *dev, u32 context_id)
 }
 EXPORT_SYMBOL(ethtool_rxfh_context_lost);
 
+bool netif_is_rxfh_configured(const struct net_device *dev)
+{
+	return dev->ethtool->rss_indir_user_size;
+}
+EXPORT_SYMBOL(netif_is_rxfh_configured);
+
+/**
+ * ethtool_rxfh_indir_clear - Clear user indirection table config
+ * @dev: network device
+ *
+ * Mark the default RSS context indirection table as unconfigured and
+ * send an %ETHTOOL_MSG_RSS_NTF notification.
+ */
+void ethtool_rxfh_indir_clear(struct net_device *dev)
+{
+	dev->ethtool->rss_indir_user_size = 0;
+	ethtool_rss_notify(dev, ETHTOOL_MSG_RSS_NTF, 0);
+}
+EXPORT_SYMBOL(ethtool_rxfh_indir_clear);
+
 enum ethtool_link_medium ethtool_str_to_medium(const char *str)
 {
 	int i;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index ff4b4780d6af..3d31a5a041e3 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1404,9 +1404,9 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 
 	/* indicate whether rxfh was set to default */
 	if (user_size == 0)
-		dev->priv_flags &= ~IFF_RXFH_CONFIGURED;
+		dev->ethtool->rss_indir_user_size = 0;
 	else
-		dev->priv_flags |= IFF_RXFH_CONFIGURED;
+		dev->ethtool->rss_indir_user_size = rxfh_dev.indir_size;
 
 out_unlock:
 	mutex_unlock(&dev->ethtool->rss_lock);
@@ -1721,9 +1721,9 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	if (!rxfh_dev.rss_context) {
 		/* indicate whether rxfh was set to default */
 		if (rxfh.indir_size == 0)
-			dev->priv_flags &= ~IFF_RXFH_CONFIGURED;
+			dev->ethtool->rss_indir_user_size = 0;
 		else if (rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE)
-			dev->priv_flags |= IFF_RXFH_CONFIGURED;
+			dev->ethtool->rss_indir_user_size = dev_indir_size;
 	}
 	/* Update rss_ctx tracking */
 	if (rxfh_dev.rss_delete) {
@@ -1736,6 +1736,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 			ctx->indir_configured =
 				rxfh.indir_size &&
 				rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE;
+			ctx->indir_user_size = dev_indir_size;
 		}
 		if (rxfh_dev.key) {
 			memcpy(ethtool_rxfh_context_key(ctx), rxfh_dev.key,
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index da5934cceb07..e6fc6e64fb27 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -686,7 +686,7 @@ rss_set_prep_indir(struct net_device *dev, struct genl_info *info,
 
 	*mod |= memcmp(rxfh->indir, data->indir_table, data->indir_size);
 
-	return 0;
+	return user_size;
 
 err_free:
 	kfree(rxfh->indir);
@@ -833,6 +833,7 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
 	struct nlattr **tb = info->attrs;
 	struct rss_reply_data data = {};
 	const struct ethtool_ops *ops;
+	u32 indir_user_size;
 	int ret;
 
 	ops = dev->ethtool_ops;
@@ -845,8 +846,9 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
 	rxfh.rss_context = request->rss_context;
 
 	ret = rss_set_prep_indir(dev, info, &data, &rxfh, &indir_reset, &mod);
-	if (ret)
+	if (ret < 0)
 		goto exit_clean_data;
+	indir_user_size = ret;
 	indir_mod = !!tb[ETHTOOL_A_RSS_INDIR];
 
 	rxfh.hfunc = data.hfunc;
@@ -889,12 +891,15 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (ret)
 		goto exit_unlock;
 
-	if (ctx)
+	if (ctx) {
 		rss_set_ctx_update(ctx, tb, &data, &rxfh);
-	else if (indir_reset)
-		dev->priv_flags &= ~IFF_RXFH_CONFIGURED;
-	else if (indir_mod)
-		dev->priv_flags |= IFF_RXFH_CONFIGURED;
+		if (indir_user_size)
+			ctx->indir_user_size = indir_user_size;
+	} else if (indir_reset) {
+		dev->ethtool->rss_indir_user_size = 0;
+	} else if (indir_mod) {
+		dev->ethtool->rss_indir_user_size = indir_user_size;
+	}
 
 exit_unlock:
 	mutex_unlock(&dev->ethtool->rss_lock);
@@ -999,6 +1004,7 @@ int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info)
 	const struct ethtool_ops *ops;
 	struct rss_req_info req = {};
 	struct net_device *dev;
+	u32 indir_user_size;
 	struct sk_buff *rsp;
 	void *hdr;
 	u32 limit;
@@ -1035,8 +1041,9 @@ int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto exit_ops;
 
 	ret = rss_set_prep_indir(dev, info, &data, &rxfh, &indir_dflt, &mod);
-	if (ret)
+	if (ret < 0)
 		goto exit_clean_data;
+	indir_user_size = ret;
 
 	ethnl_update_u8(&rxfh.hfunc, tb[ETHTOOL_A_RSS_HFUNC], &mod);
 
@@ -1080,6 +1087,7 @@ int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	/* Store the config from rxfh to Xarray.. */
 	rss_set_ctx_update(ctx, tb, &data, &rxfh);
+	ctx->indir_user_size = indir_user_size;
 	/* .. copy from Xarray to data. */
 	__rss_prepare_ctx(dev, &data, ctx);
 
-- 
2.53.0


