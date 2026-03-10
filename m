Return-Path: <linux-rdma+bounces-17862-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEi4DUn4r2mmdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17862-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:54:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1FE249C04
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07D1630D4EE4
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 10:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8CE387591;
	Tue, 10 Mar 2026 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLgchWrO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9471F3D56;
	Tue, 10 Mar 2026 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139733; cv=none; b=W8jnYokUujd6WrumZIVJm1SQ50JdUj0X1SdDLoOgCJissHEwfm7TvqzPtl4OjZnOYK8eoAz4fuNBrUc4miL0JSXmfXV7ZNTwp2fkVX1f4pAzdCtnuYUbY0Z2gastDZK2SATufrWHWbRcUsBSxmQChUrrph77kmVCLaKepKVxYhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139733; c=relaxed/simple;
	bh=L/ZpnxVlgnhKdpLTTMiA+jz9N1d0Xq77j1IS3Dua7Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZoqsogGSI9JM88xnlpAwNb86Daii9SPGkPDmOIvlkPCTOxP7nna+y3f+FYBFM1ru34VEltRi8l4usaFqujT1eojWh7Jg24bw7tDla7s7M+LkzpfpwZrPwn6l/9hcKUEMjL9BAIBULCoaFtcbAbH+yBuGy32DcKV2B1Utk26xPLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLgchWrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3D4C19423;
	Tue, 10 Mar 2026 10:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773139733;
	bh=L/ZpnxVlgnhKdpLTTMiA+jz9N1d0Xq77j1IS3Dua7Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XLgchWrO4XczooXM/1mjQKe4xzeuv4K09I2W+VhoHBO9Wv8vKacAUahAnNQofIPA5
	 VcGpmNR5ekE4E3HcW2CIKfaUaEiGBWK17Gpj5LWOnYxh6piLWRspb4ucaurER+31wY
	 58SUYbbYWrAOPYxH6vd1kiUMB1TOBpiFaDTWcgCZFkCLjmbrRPSdPMuGjzmiWfCdeI
	 5Ut+Ie/Z5Kffvq89Si7EC1sJ7onBEupNmOVxzJNOOI08LPKnrOb0vibDm3riVm2tiX
	 qozwZEjAFQqiuW1uEGi54X6+43nAv+mreZ+IPZ5Oy4McRMMCy0WoKaifFD2xLtoFDB
	 Z0+IJJgqETDXg==
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
Subject: [PATCH net-next 10/11] netdevsim: Add module EEPROM simulation via debugfs
Date: Tue, 10 Mar 2026 11:47:40 +0100
Message-ID: <20260310104743.907818-11-bjorn@kernel.org>
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
X-Rspamd-Queue-Id: DF1FE249C04
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.01 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17862-lists,linux-rdma=lfdr.de];
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
index 84bc025885f7..7ef96a747643 100644
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
 	ns->ethtool.mac_lb.supported = ETHTOOL_LOOPBACK_DIRECTION_NEAR_END |
 				       ETHTOOL_LOOPBACK_DIRECTION_FAR_END;
 
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 2e322b9410d2..f6b2063d41c9 100644
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


