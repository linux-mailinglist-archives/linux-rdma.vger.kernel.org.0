Return-Path: <linux-rdma+bounces-17859-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL12Isn3r2nUdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17859-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:51:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F5A249B50
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6485830B62F6
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 10:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99BC382F09;
	Tue, 10 Mar 2026 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IS7gVAJi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950803803CE;
	Tue, 10 Mar 2026 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139715; cv=none; b=Z+bX+EfaemcumUAMe6dmsIfCSkim5fRv1AZw+56aFLfyjPGhGR2UnpN7XeLOMpcc457uITs3HVP1TYgQfGuBVSmn0itFP+YxDdqzgJ/XPmpRbhAbuAANoqlGWmlvFxe82A/7g6Y9P8zqQe/JsykxtdlmLLqkYg/Yxzu0jn7lDkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139715; c=relaxed/simple;
	bh=Oy21scQSlKA5g3E3cwQ9SFAIKbw2IE+Ea/f3mxcVhwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uFvfWibFnO4R4FOBvRm3nSMTO3zHqR2UWaHmfXglo2ysWsGzjt3XToPH8xVIEOyofX9NOugGk1DnNGRsU1Wm6iv4ZBex92MJl2o8dUOoCwp4q3NL5huO56NInjW86s9H58KFkSATvbEaR9cT2e5/Mt7IF7RjNPVVtSIqrINVK0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS7gVAJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3A2C19423;
	Tue, 10 Mar 2026 10:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773139715;
	bh=Oy21scQSlKA5g3E3cwQ9SFAIKbw2IE+Ea/f3mxcVhwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IS7gVAJi1S2ss9vfAIC60dOBGHi2QvM2N1QF1hZmSFoXbajLRHBxBauCOz+CR57U7
	 QlGzC6aCRWdfcS9QIZeW6XWVQvTzFiUEYz4uHO4UBAlxIwYpp2SNyqNU6jnAX2LaPh
	 w+Eng9huCVc6dzvpkzP47127ovTVNHewYBENyEbioiDTfp4x4O07Z9JYd2/9oxmZ5f
	 2GSKd0XZWm7Lby6pLRk0UW2e+hgKDqXbGQ3IC24edmuusEhNtrRVBD36aDADiC5S5M
	 r08sNmdLO60OXYM/rCl3eNFh5rkNYtjDCTEBQ95uXppVWokvNm7cGmUNYldVyThbQI
	 0DZpWKUlfg4NA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Naveen Mamindlapalli <naveenm@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Danielle Ratson <danieller@nvidia.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Leon Romanovsky <leon@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next 07/11] netdevsim: Add MAC loopback simulation
Date: Tue, 10 Mar 2026 11:47:37 +0100
Message-ID: <20260310104743.907818-8-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310104743.907818-1-bjorn@kernel.org>
References: <20260310104743.907818-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 08F5A249B50
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.11 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.77)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17859-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,kernel.org,bootlin.com,marvell.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,marvell.com,bootlin.com,broadcom.com,pengutronix.de,gmail.com,armlinux.org.uk,google.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Implement the three ethtool loopback ops for MAC-level loopback
simulation:

 - get_loopback(): exact lookup by name ("mac")
 - get_loopback_by()_index: enumerate (single entry at index 0)
 - set_loopback(): update direction, return 1 if changed

The MAC loopback entry announces support for both near-end and far-end
support by default. State is stored in nsim_ethtool.mac_lb and exposed
via debugfs under ethtool/mac_lb/{supported,direction} for test
inspection and control.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 drivers/net/netdevsim/ethtool.c   | 64 +++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h |  4 ++
 2 files changed, 68 insertions(+)

diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 36a201533aae..84bc025885f7 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -195,6 +195,58 @@ nsim_get_fec_stats(struct net_device *dev, struct ethtool_fec_stats *fec_stats,
 	values[2].per_lane[3] = 0;
 }
 
+static void nsim_fill_mac_lb_entry(struct netdevsim *ns,
+				   struct ethtool_loopback_entry *entry)
+{
+	memset(entry, 0, sizeof(*entry));
+	entry->component = ETHTOOL_LOOPBACK_COMPONENT_MAC;
+	strscpy(entry->name, "mac", sizeof(entry->name));
+	entry->supported = ns->ethtool.mac_lb.supported;
+	entry->direction = ns->ethtool.mac_lb.direction;
+}
+
+static int nsim_get_loopback(struct net_device *dev, const char *name,
+			     u32 id, struct ethtool_loopback_entry *entry)
+{
+	struct netdevsim *ns = netdev_priv(dev);
+
+	if (strcmp(name, "mac"))
+		return -EOPNOTSUPP;
+
+	nsim_fill_mac_lb_entry(ns, entry);
+	return 0;
+}
+
+static int nsim_get_loopback_by_index(struct net_device *dev, u32 index,
+				      struct ethtool_loopback_entry *entry)
+{
+	struct netdevsim *ns = netdev_priv(dev);
+
+	if (index > 0)
+		return -EOPNOTSUPP;
+
+	nsim_fill_mac_lb_entry(ns, entry);
+	return 0;
+}
+
+static int nsim_set_loopback(struct net_device *dev,
+			     const struct ethtool_loopback_entry *entry,
+			     struct netlink_ext_ack *extack)
+{
+	struct netdevsim *ns = netdev_priv(dev);
+
+	if (strcmp(entry->name, "mac")) {
+		NL_SET_ERR_MSG(extack, "Unknown MAC loopback name");
+		return -EOPNOTSUPP;
+	}
+
+	if (ns->ethtool.mac_lb.direction == entry->direction)
+		return 0;
+
+	ns->ethtool.mac_lb.direction = entry->direction;
+	return 1;
+}
+
 static int nsim_get_ts_info(struct net_device *dev,
 			    struct kernel_ethtool_ts_info *info)
 {
@@ -222,6 +274,9 @@ static const struct ethtool_ops nsim_ethtool_ops = {
 	.set_fecparam			= nsim_set_fecparam,
 	.get_fec_stats			= nsim_get_fec_stats,
 	.get_ts_info			= nsim_get_ts_info,
+	.get_loopback			= nsim_get_loopback,
+	.get_loopback_by_index		= nsim_get_loopback_by_index,
+	.set_loopback			= nsim_set_loopback,
 };
 
 static void nsim_ethtool_ring_init(struct netdevsim *ns)
@@ -270,4 +325,13 @@ void nsim_ethtool_init(struct netdevsim *ns)
 			   &ns->ethtool.ring.rx_mini_max_pending);
 	debugfs_create_u32("tx_max_pending", 0600, dir,
 			   &ns->ethtool.ring.tx_max_pending);
+
+	ns->ethtool.mac_lb.supported = ETHTOOL_LOOPBACK_DIRECTION_NEAR_END |
+				       ETHTOOL_LOOPBACK_DIRECTION_FAR_END;
+
+	dir = debugfs_create_dir("mac_lb", ethtool);
+	debugfs_create_u32("supported", 0600, dir,
+			   &ns->ethtool.mac_lb.supported);
+	debugfs_create_u32("direction", 0600, dir,
+			   &ns->ethtool.mac_lb.direction);
 }
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index f767fc8a7505..2e322b9410d2 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -90,6 +90,10 @@ struct nsim_ethtool {
 	struct ethtool_coalesce coalesce;
 	struct ethtool_ringparam ring;
 	struct ethtool_fecparam fec;
+	struct {
+		u32 supported;
+		u32 direction;
+	} mac_lb;
 };
 
 struct nsim_rq {
-- 
2.53.0


