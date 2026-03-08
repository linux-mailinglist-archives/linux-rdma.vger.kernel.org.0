Return-Path: <linux-rdma+bounces-17716-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMnSLiBvrWme2wEAu9opvQ
	(envelope-from <linux-rdma+bounces-17716-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 13:44:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2135E230467
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 13:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43CB9305F4C3
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 12:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFAB36F417;
	Sun,  8 Mar 2026 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rC+WqX9X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8317C299A8A;
	Sun,  8 Mar 2026 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772973648; cv=none; b=c/gqtTAOHgdB7JcPpMhhoH8hd8m2f5asR5UGfc/4S9jnLIFhKR1hbzJjBC079+61WZN/yrFC0d0PpIykbJqly/cwKt1kpQCi0wn4YPzGXqhU99G9ev1QkVg1FxFkfHroWnNciJI+eqh/qjEMB2K7Nl9yXWwyM+Ovd4ws0tEA3b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772973648; c=relaxed/simple;
	bh=U7ugx5XdRBV8q3eTJ32W5d+auEFcbPDhwzRLSP2M2Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/MaMVggqworlje9Wmu5Ot6bHDaBNVIUKnibB7cq09WN00Z922Bxs3f/SH2wnStoyLuEcJsCP/zeme6RJeyKiizCovb1TRJIZGRKr2wXhgQmvX12P1JRpimQQt8tLHpn+LAuXbTVaZOoSlGA7I3a0M8ImWL+c8uy4T4exondS+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rC+WqX9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A961DC2BC9E;
	Sun,  8 Mar 2026 12:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772973648;
	bh=U7ugx5XdRBV8q3eTJ32W5d+auEFcbPDhwzRLSP2M2Xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rC+WqX9X5FXna4ZOpVYqzrc36VoodxM0gYRnimdrq1AMhzPt/F4bGQw9Fpmbo3EFt
	 Jfab7OBwv2VLlUaSzyt2SqOZp0RCZFvPbSBsnLJmMTArymBetS410OdXlVWE5kr7wZ
	 nGD3Scf35hVFfb43Rou4/8crbwiQOTD9kk4XY2sLgtehj+z6XEyUKQ7sQVS9z6uO0K
	 b/SWb+IivrpJrdmS/R6lwGtU119rH7sXbfixGvqQF6BsFAVAV2czzy5HFGo6VCP86a
	 RelN5h6hoBesl2lwEIPwVClbIxc+bkgdPAwOVJ2TdYjUl6XjrDUy07golMZqTJh45i
	 eEw6xTydYOX9w==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: netdev@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: [RFC net-next v2 5/6] netdevsim: Add module EEPROM simulation via debugfs
Date: Sun,  8 Mar 2026 13:40:11 +0100
Message-ID: <20260308124016.3134012-6-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308124016.3134012-1-bjorn@kernel.org>
References: <20260308124016.3134012-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2135E230467
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-17716-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.956];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add get/set_module_eeprom_by_page ethtool ops to netdevsim, enabling
testing of kernel features that depend on module EEPROM access (e.g.
CMIS loopback) without real hardware.

The EEPROM is backed by a 256-page x 128-byte array exposed as binary
debugfs files under ports/<N>/ethtool/module/pages/{0..255}. Offsets
0-127 map to page 0 (lower memory), 128-255 to the requested page's
upper memory, following the CMIS layout. Error injection via get_err
and set_err follows the existing netdevsim pattern.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 drivers/net/netdevsim/ethtool.c   | 79 +++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h | 11 +++++
 2 files changed, 90 insertions(+)

diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 36a201533aae..2145ccc8a9bd 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -195,6 +195,67 @@ nsim_get_fec_stats(struct net_device *dev, struct ethtool_fec_stats *fec_stats,
 	values[2].per_lane[3] = 0;
 }
 
+static u8 *nsim_module_eeprom_ptr(struct netdevsim *ns,
+				  const struct ethtool_module_eeprom *page_data, u32 *len)
+{
+	u32 offset;
+	u8 page;
+
+	if (page_data->offset < NSIM_MODULE_EEPROM_PAGE_LEN) {
+		page = 0;
+		offset = page_data->offset;
+	} else {
+		page = page_data->page;
+		offset = page_data->offset - NSIM_MODULE_EEPROM_PAGE_LEN;
+	}
+
+	if (page >= NSIM_MODULE_EEPROM_PAGES)
+		return NULL;
+
+	*len = min_t(u32, page_data->length, NSIM_MODULE_EEPROM_PAGE_LEN - offset);
+	return ns->ethtool.module.pages[page] + offset;
+}
+
+static int nsim_get_module_eeprom_by_page(struct net_device *dev,
+					  const struct ethtool_module_eeprom *page_data,
+					  struct netlink_ext_ack *extack)
+{
+	struct netdevsim *ns = netdev_priv(dev);
+	u32 len;
+	u8 *ptr;
+
+	if (ns->ethtool.module.get_err)
+		return -ns->ethtool.module.get_err;
+
+	ptr = nsim_module_eeprom_ptr(ns, page_data, &len);
+	if (!ptr)
+		return -EINVAL;
+
+	memcpy(page_data->data, ptr, len);
+
+	return len;
+}
+
+static int nsim_set_module_eeprom_by_page(struct net_device *dev,
+					  const struct ethtool_module_eeprom *page_data,
+					  struct netlink_ext_ack *extack)
+{
+	struct netdevsim *ns = netdev_priv(dev);
+	u32 len;
+	u8 *ptr;
+
+	if (ns->ethtool.module.set_err)
+		return -ns->ethtool.module.set_err;
+
+	ptr = nsim_module_eeprom_ptr(ns, page_data, &len);
+	if (!ptr)
+		return -EINVAL;
+
+	memcpy(ptr, page_data->data, len);
+
+	return 0;
+}
+
 static int nsim_get_ts_info(struct net_device *dev,
 			    struct kernel_ethtool_ts_info *info)
 {
@@ -222,6 +283,8 @@ static const struct ethtool_ops nsim_ethtool_ops = {
 	.set_fecparam			= nsim_set_fecparam,
 	.get_fec_stats			= nsim_get_fec_stats,
 	.get_ts_info			= nsim_get_ts_info,
+	.get_module_eeprom_by_page	= nsim_get_module_eeprom_by_page,
+	.set_module_eeprom_by_page	= nsim_set_module_eeprom_by_page,
 };
 
 static void nsim_ethtool_ring_init(struct netdevsim *ns)
@@ -237,6 +300,7 @@ static void nsim_ethtool_ring_init(struct netdevsim *ns)
 void nsim_ethtool_init(struct netdevsim *ns)
 {
 	struct dentry *ethtool, *dir;
+	int i;
 
 	ns->netdev->ethtool_ops = &nsim_ethtool_ops;
 
@@ -270,4 +334,19 @@ void nsim_ethtool_init(struct netdevsim *ns)
 			   &ns->ethtool.ring.rx_mini_max_pending);
 	debugfs_create_u32("tx_max_pending", 0600, dir,
 			   &ns->ethtool.ring.tx_max_pending);
+
+	dir = debugfs_create_dir("module", ethtool);
+	debugfs_create_u32("get_err", 0600, dir, &ns->ethtool.module.get_err);
+	debugfs_create_u32("set_err", 0600, dir, &ns->ethtool.module.set_err);
+
+	dir = debugfs_create_dir("pages", dir);
+	for (i = 0; i < NSIM_MODULE_EEPROM_PAGES; i++) {
+		char name[8];
+
+		ns->ethtool.module.page_blobs[i].data = ns->ethtool.module.pages[i];
+		ns->ethtool.module.page_blobs[i].size = NSIM_MODULE_EEPROM_PAGE_LEN;
+
+		snprintf(name, sizeof(name), "%u", i);
+		debugfs_create_blob(name, 0600, dir, &ns->ethtool.module.page_blobs[i]);
+	}
 }
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index f767fc8a7505..965d0aa0940b 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -82,6 +82,16 @@ struct nsim_ethtool_pauseparam {
 	bool report_stats_tx;
 };
 
+#define NSIM_MODULE_EEPROM_PAGES	256
+#define NSIM_MODULE_EEPROM_PAGE_LEN	128
+
+struct nsim_ethtool_module {
+	u32 get_err;
+	u32 set_err;
+	u8 pages[NSIM_MODULE_EEPROM_PAGES][NSIM_MODULE_EEPROM_PAGE_LEN];
+	struct debugfs_blob_wrapper page_blobs[NSIM_MODULE_EEPROM_PAGES];
+};
+
 struct nsim_ethtool {
 	u32 get_err;
 	u32 set_err;
@@ -90,6 +100,7 @@ struct nsim_ethtool {
 	struct ethtool_coalesce coalesce;
 	struct ethtool_ringparam ring;
 	struct ethtool_fecparam fec;
+	struct nsim_ethtool_module module;
 };
 
 struct nsim_rq {
-- 
2.53.0


