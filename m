Return-Path: <linux-rdma+bounces-18613-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIFiAnf8w2lXvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18613-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:17:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FE0327B52
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E28C31FFE90
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 14:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B17405ABE;
	Wed, 25 Mar 2026 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkLFdI8i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0803C402BB3;
	Wed, 25 Mar 2026 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450286; cv=none; b=p3mESJIIvPct3m8c6V7XBr+VLjmaQrMYmK9VHnAk9xwNYpJ5aUVwzRG0Fh4kUAqSzLiLe0hWtJk+s2E58RD0k2H86tzlEFAxh+0nXajfO5Q31ROgW7bOz9HxCgbcUXGQB10vEZFbvqqEdzQ2jv5kCxJ1MxKf0ycItODxkGf8kDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450286; c=relaxed/simple;
	bh=bjn6wusfWcWWW4K71z9b+CKW2x20GnqN25OdeIshUE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZ7UcA+CfwbS1FSqWbV+YlkeRWgS1otnJRcBUqB/p1sgzhXekTuIMQC//al/pDdXFZbtqYdI9SakaDjg4Z5lJTTAzgIH0sutcB5AxTWxtH2VFgOzSi7o8N8AYKL9RRkG9JwhT28QYBCFdh/ef4WiGrLLq+QmwE3cyK7hbq+nr9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkLFdI8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25176C2BCF4;
	Wed, 25 Mar 2026 14:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774450285;
	bh=bjn6wusfWcWWW4K71z9b+CKW2x20GnqN25OdeIshUE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VkLFdI8iybzwpgpvrG0il5h52Y0sbTmnZiI0sKZ5J0cHuiasIB6aQw5X7TVPMuS3O
	 IyDMzcF9HQXZUllQnv8Zt8m3ihQYJ5gOzkKHZ+ApiM6ooFlqHiNUycl/rWKnLcIPWi
	 a1GpriTibiMwk+xGFJbNrYKGhJY80Z4qsCN4EnBun9V7l13kTfZnpaxIVflNJvgjx/
	 Fa0IY6GuHrohNgKrR6SjMKHgIShzo26AfpHdR8BjzKfNjbLCo7xLDp5AqGoriYSteq
	 28sL8UuAaJ3/Tgi+QFuxb0/sFOe8uur74ZPcnZGtRpIf7NNWY7GrpJH/lYNvB3Alx5
	 t9m8p4Agb3ePA==
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
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v2 08/12] netdevsim: Add MAC loopback simulation
Date: Wed, 25 Mar 2026 15:50:15 +0100
Message-ID: <20260325145022.2607545-9-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325145022.2607545-1-bjorn@kernel.org>
References: <20260325145022.2607545-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.05 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18613-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,kernel.org,bootlin.com,marvell.com,redhat.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,marvell.com,bootlin.com,broadcom.com,pengutronix.de,gmail.com,armlinux.org.uk,google.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4FE0327B52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement the three ethtool loopback ops for MAC-level loopback
simulation:

 - get_loopback(): exact lookup by name ("mac")
 - get_loopback_by()_index: enumerate (single entry at index 0)
 - set_loopback(): update direction, return 1 if changed

The MAC loopback entry announces support for both local and remote
support by default. State is stored in nsim_ethtool.mac_lb and exposed
via debugfs under ethtool/mac_lb/{supported,direction} for test
inspection and control.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 drivers/net/netdevsim/ethtool.c   | 64 +++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h |  4 ++
 2 files changed, 68 insertions(+)

diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 36a201533aae..39c681284700 100644
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
+	ns->ethtool.mac_lb.supported = ETHTOOL_LOOPBACK_DIRECTION_LOCAL |
+				       ETHTOOL_LOOPBACK_DIRECTION_REMOTE;
+
+	dir = debugfs_create_dir("mac_lb", ethtool);
+	debugfs_create_u32("supported", 0600, dir,
+			   &ns->ethtool.mac_lb.supported);
+	debugfs_create_u32("direction", 0600, dir,
+			   &ns->ethtool.mac_lb.direction);
 }
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index c904e14f6b3f..7a3382562287 100644
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


