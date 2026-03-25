Return-Path: <linux-rdma+bounces-18616-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFxHBov5w2kxvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18616-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:04:43 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E0B32774B
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59CE2300F5B4
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 15:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B6A41C2F0;
	Wed, 25 Mar 2026 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcof19Id"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45423E274C;
	Wed, 25 Mar 2026 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450305; cv=none; b=FAj4l0In7rfk/mOxipJjUtsk8CWnef4v/Lv02dqqebAonnNIN7fe2nQhgLq+ME5cGY3Qs5CCmg7WL6i+2uO7QOQgG4bjN3lwy7IjbFqsbmVBY9hCHspeaIsRz/gm5D2JO/igWcZvSOmWDUlAKcxkyjEzNfVOw5/NRysxg/WA044=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450305; c=relaxed/simple;
	bh=8AXpAN699RP7gwJQ3Z5T+xRlw6cLSkUIePQ/vZEoTEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWXCEbSg3+rBrinhKNWnxjBqFxmMYHnKKgztURomcvWcxF9NkT1uegZ4lAFTBK+nNj7/gNiCBWPvx6oGssqKTEuS/Vlxj8FLdZZPEQIIbDq1SHNcVPAlnZCepj4q2BqMMY8n9mofPle8f1rca6hLoMSZ8VcrF9ysjj1t87IH6tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcof19Id; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02094C4DDF4;
	Wed, 25 Mar 2026 14:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774450305;
	bh=8AXpAN699RP7gwJQ3Z5T+xRlw6cLSkUIePQ/vZEoTEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tcof19IdZhNk3LrpwvSqZGw6S2w0lYwRpd15VsTUFgphy8JhkX5e+sDg8izFJKZfZ
	 0WKQwmhyrwz5x7d9qQQXF3IAwGBVPcGRy6qS0RUOkmTPcuG/p0xwp5Fb6J/oNRob6b
	 kP0ZaFHTEjk1ktfrnFp4J/xmWSbye55f0580NtEegxhJUgNAIO+LMDUevQkXv20ydh
	 BtY02iCpZ9PrENeev+5EIjHkblIdMf8sYPOd31Jd0WfxYQyzw2z8i87XnMTXBXfp/W
	 iBn/c3tAttHZMhxexBdCkdwG070I5CIIS+iV8eZVK9unmT+vOPE7zd21hZEaxsaQm6
	 RMcULCtqlJJJA==
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
Subject: [PATCH net-next v2 11/12] netdevsim: Add module EEPROM simulation via debugfs
Date: Wed, 25 Mar 2026 15:50:18 +0100
Message-ID: <20260325145022.2607545-12-bjorn@kernel.org>
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
X-Spamd-Result: default: False [0.96 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18616-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,kernel.org,bootlin.com,marvell.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,marvell.com,bootlin.com,broadcom.com,pengutronix.de,gmail.com,armlinux.org.uk,google.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6E0B32774B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/net/netdevsim/ethtool.c   | 83 +++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h | 11 ++++
 2 files changed, 94 insertions(+)

diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 39c681284700..1ef48802fcbd 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -247,6 +247,68 @@ static int nsim_set_loopback(struct net_device *dev,
 	return 1;
 }
 
+static u8 *nsim_module_eeprom_ptr(struct netdevsim *ns,
+				  const struct ethtool_module_eeprom *page_data,
+				  u32 *len)
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
+	*len = min_t(u32, page_data->length,
+		     NSIM_MODULE_EEPROM_PAGE_LEN - offset);
+	return ns->ethtool.module.pages[page] + offset;
+}
+
+static int
+nsim_get_module_eeprom_by_page(struct net_device *dev,
+			       const struct ethtool_module_eeprom *page_data,
+			       struct netlink_ext_ack *extack)
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
+static int
+nsim_set_module_eeprom_by_page(struct net_device *dev,
+			       const struct ethtool_module_eeprom *page_data,
+			       struct netlink_ext_ack *extack)
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
@@ -274,6 +336,8 @@ static const struct ethtool_ops nsim_ethtool_ops = {
 	.set_fecparam			= nsim_set_fecparam,
 	.get_fec_stats			= nsim_get_fec_stats,
 	.get_ts_info			= nsim_get_ts_info,
+	.get_module_eeprom_by_page	= nsim_get_module_eeprom_by_page,
+	.set_module_eeprom_by_page	= nsim_set_module_eeprom_by_page,
 	.get_loopback			= nsim_get_loopback,
 	.get_loopback_by_index		= nsim_get_loopback_by_index,
 	.set_loopback			= nsim_set_loopback,
@@ -292,6 +356,7 @@ static void nsim_ethtool_ring_init(struct netdevsim *ns)
 void nsim_ethtool_init(struct netdevsim *ns)
 {
 	struct dentry *ethtool, *dir;
+	int i;
 
 	ns->netdev->ethtool_ops = &nsim_ethtool_ops;
 
@@ -326,6 +391,24 @@ void nsim_ethtool_init(struct netdevsim *ns)
 	debugfs_create_u32("tx_max_pending", 0600, dir,
 			   &ns->ethtool.ring.tx_max_pending);
 
+	dir = debugfs_create_dir("module", ethtool);
+	debugfs_create_u32("get_err", 0600, dir, &ns->ethtool.module.get_err);
+	debugfs_create_u32("set_err", 0600, dir, &ns->ethtool.module.set_err);
+
+	dir = debugfs_create_dir("pages", dir);
+	for (i = 0; i < NSIM_MODULE_EEPROM_PAGES; i++) {
+		char name[8];
+
+		ns->ethtool.module.page_blobs[i].data =
+			ns->ethtool.module.pages[i];
+		ns->ethtool.module.page_blobs[i].size =
+			NSIM_MODULE_EEPROM_PAGE_LEN;
+
+		snprintf(name, sizeof(name), "%u", i);
+		debugfs_create_blob(name, 0600, dir,
+				    &ns->ethtool.module.page_blobs[i]);
+	}
+
 	ns->ethtool.mac_lb.supported = ETHTOOL_LOOPBACK_DIRECTION_LOCAL |
 				       ETHTOOL_LOOPBACK_DIRECTION_REMOTE;
 
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 7a3382562287..816e8ddd2551 100644
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
@@ -94,6 +104,7 @@ struct nsim_ethtool {
 		u32 supported;
 		u32 direction;
 	} mac_lb;
+	struct nsim_ethtool_module module;
 };
 
 struct nsim_rq {
-- 
2.53.0


