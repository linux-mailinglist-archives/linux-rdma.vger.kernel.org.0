Return-Path: <linux-rdma+bounces-17856-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBwOKxz4r2mmdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17856-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:53:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5590A249BD0
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E39A731D1D5F
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 10:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F325B37C0F3;
	Tue, 10 Mar 2026 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G//q3ZAq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0F83314D2;
	Tue, 10 Mar 2026 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139697; cv=none; b=CuRbKHINa0/nPR6c1k3j22nIA6WXrHQ5F+ACh9bG04Uxg104q0TQ2uzG7bUaxrHq5F/copEamYARhPRjdwOgTKKo5S/yjzWdk8Q6xW46qNlDQG3LnSOQE49yjMGXoYDYkEDhLCTeBij7mpo03VFPdtGHiYLA+vzWkCb3wm2qBZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139697; c=relaxed/simple;
	bh=xMZ42D5aNtwhnLwzvCzxcszWZhmxnCde5ccwKeK/940=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EeqfYeZi0SK0rt/SMjMr2SP9xvi88Dr9shSF8+QIRFevgmV5tLUxpk3u34Wm65kQ6O6TxCUI1aoQLpfua9qhzxKvoNhfghv5WisFZaTt2dUwvDDrRyzvEYkTP+XgHAYv/y1nVt0nKqGJs+a9FdAxoeyeNTrTQNI0x+IAVx9HLfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G//q3ZAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9605C2BC86;
	Tue, 10 Mar 2026 10:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773139697;
	bh=xMZ42D5aNtwhnLwzvCzxcszWZhmxnCde5ccwKeK/940=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G//q3ZAqdqO3pjHL2qPlfMxAVdS+wI6Fsp0qFtfjTK/2+3gFduHdM2CholyaemEjf
	 eZh8cBc7h9fGxMfPdqlnpAoJPUa1Sly8WZlc7BixCIV4S/H7KncXcYYJhQZZv8q9co
	 PnM4z7f76nk9GA0cGr6l5k+kbaVbFL7K5qTK6TrJUDXEg2xJY8GGZ1yHWM1fB+6dE6
	 HDXgW6Id5VRhlwdKtoChqH0AwZAHGFf0Iii+2DjjA/tlrXuYEyDeNe4Bg1OgV33jlb
	 7aglOUyOdpB2howrADDqLxO6kFRJOVO3jFnM6kgt2hMH4ucMYcdaP9e/YmPIvndYkP
	 gwjPiQe474FTg==
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
Subject: [PATCH net-next 04/11] ethtool: Add CMIS loopback helpers for module loopback control
Date: Tue, 10 Mar 2026 11:47:34 +0100
Message-ID: <20260310104743.907818-5-bjorn@kernel.org>
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
X-Rspamd-Queue-Id: 5590A249BD0
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-17856-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,kernel.org,bootlin.com,marvell.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,marvell.com,bootlin.com,broadcom.com,pengutronix.de,gmail.com,armlinux.org.uk,google.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[page.data:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add CMIS loopback functions and wire them into loopback.c for the
MODULE component:

 - ethtool_cmis_get_loopback(): reads Page 13h capabilities and
   current state, appends one entry per supported loopback point
   ("cmis-host" and/or "cmis-media").

 - ethtool_cmis_get_loopback_by_index(): used to enumerate what the
   module supports.

 - ethtool_cmis_set_loopback(): resolves name to a pair of control
   byte indices, validates direction, and writes the Page 13h control
   bytes (0xff = all lanes on, 0x00 = off).

Directions are mutually exclusive: switching from near-end to far-end
first disables the active direction in a separate EEPROM write, then
enables the new one. Requesting multiple direction flags is rejected.

CMIS register mapping (Page 13h, Bytes 180-183):

 - MODULE, "cmis-host",  near-end  ->  Host Side Input    (Byte 183)
 - MODULE, "cmis-host",  far-end   ->  Host Side Output   (Byte 182)
 - MODULE, "cmis-media", near-end  ->  Media Side Input   (Byte 181)
 - MODULE, "cmis-media", far-end   ->  Media Side Output  (Byte 180)

The helpers work entirely over get/set_module_eeprom_by_page, so any
driver with EEPROM page access gets module loopback without new
ethtool_ops or driver changes. SET is rejected when firmware flashing
is in progress or the interface is UP.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 net/ethtool/Makefile        |   2 +-
 net/ethtool/cmis_loopback.c | 407 ++++++++++++++++++++++++++++++++++++
 net/ethtool/loopback.c      |   6 +-
 net/ethtool/netlink.h       |   8 +
 4 files changed, 421 insertions(+), 2 deletions(-)
 create mode 100644 net/ethtool/cmis_loopback.c

diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
index ef534b55d724..2f821c7875e1 100644
--- a/net/ethtool/Makefile
+++ b/net/ethtool/Makefile
@@ -9,4 +9,4 @@ ethtool_nl-y	:= netlink.o bitset.o strset.o linkinfo.o linkmodes.o rss.o \
 		   channels.o coalesce.o pause.o eee.o tsinfo.o cabletest.o \
 		   tunnels.o fec.o eeprom.o stats.o phc_vclocks.o mm.o \
 		   module.o cmis_fw_update.o cmis_cdb.o pse-pd.o plca.o \
-		   phy.o tsconfig.o mse.o loopback.o
+		   phy.o tsconfig.o mse.o loopback.o cmis_loopback.o
diff --git a/net/ethtool/cmis_loopback.c b/net/ethtool/cmis_loopback.c
new file mode 100644
index 000000000000..0d419c369d64
--- /dev/null
+++ b/net/ethtool/cmis_loopback.c
@@ -0,0 +1,407 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/* CMIS loopback helpers for drivers implementing ethtool
+ * get/set_loopback.
+ *
+ * Maps the generic ethtool loopback model to CMIS Page 13h registers
+ * (CMIS 5.3, Table 8-128).
+ *
+ * Capabilities are read from Page 13h Byte 128, with Page 13h
+ * availability checked via Page 01h Byte 142 bit 5.
+ */
+
+#include <linux/ethtool.h>
+#include <linux/sfp.h>
+
+#include "common.h"
+#include "module_fw.h"
+#include "cmis.h"
+
+/* CMIS Page 00h, Byte 0: Physical module identifier */
+#define CMIS_PHYS_ID_PAGE		0x00
+#define CMIS_PHYS_ID_OFFSET		0x00
+
+/* CMIS Page 01h, Byte 142: Diagnostic Pages Support */
+#define CMIS_DIAG_SUPPORT_PAGE		0x01
+#define CMIS_DIAG_SUPPORT_OFFSET	0x8e
+#define CMIS_DIAG_PAGE13_BIT		BIT(5)
+
+/* CMIS Page 13h, Byte 128: Loopback Capability Advertisement */
+#define CMIS_LB_CAPS_PAGE		0x13
+#define CMIS_LB_CAPS_OFFSET		0x80
+#define CMIS_LB_CAP_MEDIA_OUTPUT	BIT(0)
+#define CMIS_LB_CAP_MEDIA_INPUT		BIT(1)
+#define CMIS_LB_CAP_HOST_OUTPUT		BIT(2)
+#define CMIS_LB_CAP_HOST_INPUT		BIT(3)
+
+/* CMIS Page 13h, Bytes 180-183: Per-Lane Loopback Control
+ *   Byte 180 (0xb4): Media Side Output  -> MODULE, "cmis-media", far-end
+ *   Byte 181 (0xb5): Media Side Input   -> MODULE, "cmis-media", near-end
+ *   Byte 182 (0xb6): Host Side Output   -> MODULE, "cmis-host",  far-end
+ *   Byte 183 (0xb7): Host Side Input    -> MODULE, "cmis-host",  near-end
+ */
+#define CMIS_LB_CTRL_PAGE		0x13
+#define CMIS_LB_CTRL_OFFSET		0xb4
+#define CMIS_LB_CTRL_LEN		4
+#define CMIS_LB_CTRL_IDX_MEDIA_OUTPUT	0
+#define CMIS_LB_CTRL_IDX_MEDIA_INPUT	1
+#define CMIS_LB_CTRL_IDX_HOST_OUTPUT	2
+#define CMIS_LB_CTRL_IDX_HOST_INPUT	3
+
+#define CMIS_LB_NAME_HOST		"cmis-host"
+#define CMIS_LB_NAME_MEDIA		"cmis-media"
+
+static bool cmis_is_module(u8 phys_id)
+{
+	switch (phys_id) {
+	case SFF8024_ID_QSFP_DD:
+	case SFF8024_ID_OSFP:
+	case SFF8024_ID_DSFP:
+	case SFF8024_ID_QSFP_PLUS_CMIS:
+	case SFF8024_ID_SFP_DD_CMIS:
+	case SFF8024_ID_SFP_PLUS_CMIS:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/**
+ * cmis_loopback_caps - Read CMIS loopback capability mask
+ * @dev: Network device
+ *
+ * Return: >0 capability bitmask, 0 if not a CMIS module or no Page
+ *         13h, negative errno on failure.
+ */
+static int cmis_loopback_caps(struct net_device *dev)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_module_eeprom page = {};
+	int ret;
+	u8 val;
+
+	if (!ops->get_module_eeprom_by_page)
+		return 0;
+
+	/* Read physical identifier */
+	ethtool_cmis_page_init(&page, CMIS_PHYS_ID_PAGE,
+			       CMIS_PHYS_ID_OFFSET, sizeof(val));
+	page.data = &val;
+	ret = ops->get_module_eeprom_by_page(dev, &page, NULL);
+	if (ret < 0)
+		return ret;
+	if (!cmis_is_module(val))
+		return 0;
+
+	/* Check Page 13h availability */
+	ethtool_cmis_page_init(&page, CMIS_DIAG_SUPPORT_PAGE,
+			       CMIS_DIAG_SUPPORT_OFFSET, sizeof(val));
+	page.data = &val;
+	ret = ops->get_module_eeprom_by_page(dev, &page, NULL);
+	if (ret < 0)
+		return ret;
+	if (!(val & CMIS_DIAG_PAGE13_BIT))
+		return 0;
+
+	/* Read capability byte */
+	ethtool_cmis_page_init(&page, CMIS_LB_CAPS_PAGE,
+			       CMIS_LB_CAPS_OFFSET, sizeof(val));
+	page.data = &val;
+	ret = ops->get_module_eeprom_by_page(dev, &page, NULL);
+	if (ret < 0)
+		return ret;
+
+	return val & (CMIS_LB_CAP_MEDIA_OUTPUT | CMIS_LB_CAP_MEDIA_INPUT |
+		      CMIS_LB_CAP_HOST_OUTPUT | CMIS_LB_CAP_HOST_INPUT);
+}
+
+/**
+ * cmis_loopback_read - Read CMIS loopback capabilities and build entries
+ * @dev: Network device with get_module_eeprom_by_page support
+ * @host: Output host loopback entry (populated if host caps exist)
+ * @media: Output media loopback entry (populated if media caps exist)
+ * @has_host: Set to true if host loopback is supported
+ * @has_media: Set to true if media loopback is supported
+ *
+ * Common helper that reads CMIS caps and control bytes, then populates
+ * the host and media entries with current state.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if no CMIS loopback support,
+ *         negative errno on failure.
+ */
+static int cmis_loopback_read(struct net_device *dev,
+			      struct ethtool_loopback_entry *host,
+			      struct ethtool_loopback_entry *media,
+			      bool *has_host, bool *has_media)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_module_eeprom page = {};
+	u8 ctrl[CMIS_LB_CTRL_LEN];
+	int caps, ret;
+
+	*has_host = false;
+	*has_media = false;
+
+	if (dev->ethtool->module_fw_flash_in_progress)
+		return -EBUSY;
+
+	caps = cmis_loopback_caps(dev);
+	if (caps <= 0)
+		return caps ? caps : -EOPNOTSUPP;
+
+	ethtool_cmis_page_init(&page, CMIS_LB_CTRL_PAGE,
+			       CMIS_LB_CTRL_OFFSET, sizeof(ctrl));
+	page.data = ctrl;
+	ret = ops->get_module_eeprom_by_page(dev, &page, NULL);
+	if (ret < 0)
+		return ret;
+
+	memset(host, 0, sizeof(*host));
+	host->component = ETHTOOL_LOOPBACK_COMPONENT_MODULE;
+	strscpy(host->name, CMIS_LB_NAME_HOST, sizeof(host->name));
+
+	memset(media, 0, sizeof(*media));
+	media->component = ETHTOOL_LOOPBACK_COMPONENT_MODULE;
+	strscpy(media->name, CMIS_LB_NAME_MEDIA, sizeof(media->name));
+
+	if (caps & CMIS_LB_CAP_HOST_INPUT) {
+		*has_host = true;
+		host->supported |= ETHTOOL_LOOPBACK_DIRECTION_NEAR_END;
+		if (ctrl[CMIS_LB_CTRL_IDX_HOST_INPUT])
+			host->direction |= ETHTOOL_LOOPBACK_DIRECTION_NEAR_END;
+	}
+	if (caps & CMIS_LB_CAP_HOST_OUTPUT) {
+		*has_host = true;
+		host->supported |= ETHTOOL_LOOPBACK_DIRECTION_FAR_END;
+		if (ctrl[CMIS_LB_CTRL_IDX_HOST_OUTPUT])
+			host->direction |= ETHTOOL_LOOPBACK_DIRECTION_FAR_END;
+	}
+	if (caps & CMIS_LB_CAP_MEDIA_INPUT) {
+		*has_media = true;
+		media->supported |= ETHTOOL_LOOPBACK_DIRECTION_NEAR_END;
+		if (ctrl[CMIS_LB_CTRL_IDX_MEDIA_INPUT])
+			media->direction |= ETHTOOL_LOOPBACK_DIRECTION_NEAR_END;
+	}
+	if (caps & CMIS_LB_CAP_MEDIA_OUTPUT) {
+		*has_media = true;
+		media->supported |= ETHTOOL_LOOPBACK_DIRECTION_FAR_END;
+		if (ctrl[CMIS_LB_CTRL_IDX_MEDIA_OUTPUT])
+			media->direction |= ETHTOOL_LOOPBACK_DIRECTION_FAR_END;
+	}
+
+	return 0;
+}
+
+/**
+ * ethtool_cmis_get_loopback_by_index - Enumerate CMIS loopback entry by index
+ * @dev: Network device with get_module_eeprom_by_page support
+ * @index: Zero-based index of the loopback entry to retrieve
+ * @entry: Output loopback entry
+ *
+ * Used by the dump infrastructure to iterate one entry at a time.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the index is out of range or
+ *         no CMIS loopback support, negative errno on failure.
+ */
+int ethtool_cmis_get_loopback_by_index(struct net_device *dev, u32 index,
+				       struct ethtool_loopback_entry *entry)
+{
+	struct ethtool_loopback_entry host, media;
+	bool has_host, has_media;
+	u32 cur = 0;
+	int ret;
+
+	ret = cmis_loopback_read(dev, &host, &media, &has_host, &has_media);
+	if (ret)
+		return ret;
+
+	if (has_host) {
+		if (cur == index) {
+			memcpy(entry, &host, sizeof(*entry));
+			return 0;
+		}
+		cur++;
+	}
+
+	if (has_media) {
+		if (cur == index) {
+			memcpy(entry, &media, sizeof(*entry));
+			return 0;
+		}
+	}
+
+	return -EOPNOTSUPP;
+}
+
+/**
+ * ethtool_cmis_get_loopback - Look up CMIS loopback entry by name
+ * @dev: Network device with get_module_eeprom_by_page support
+ * @name: Loopback point name ("cmis-host" or "cmis-media")
+ * @entry: Output loopback entry
+ *
+ * Used by doit requests to look up a specific loopback point.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if name doesn't match or no CMIS
+ *         support, negative errno on failure.
+ */
+int ethtool_cmis_get_loopback(struct net_device *dev,
+			      const char *name,
+			      struct ethtool_loopback_entry *entry)
+{
+	struct ethtool_loopback_entry host, media;
+	bool has_host, has_media;
+	int ret;
+
+	ret = cmis_loopback_read(dev, &host, &media, &has_host, &has_media);
+	if (ret)
+		return ret;
+
+	if (has_host && !strcmp(name, CMIS_LB_NAME_HOST)) {
+		memcpy(entry, &host, sizeof(*entry));
+		return 0;
+	}
+
+	if (has_media && !strcmp(name, CMIS_LB_NAME_MEDIA)) {
+		memcpy(entry, &media, sizeof(*entry));
+		return 0;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+/**
+ * ethtool_cmis_set_loopback - Apply one MODULE loopback entry to CMIS
+ * @dev: Network device with get/set_module_eeprom_by_page support
+ * @entry: Loopback entry to apply (must be MODULE component)
+ * @extack: Netlink extended ack for error reporting
+ *
+ * Matches the entry against CMIS loopback points by name and
+ * direction, then reads, modifies, and writes the corresponding Page
+ * 13h control byte (0xff for all-lanes enable, 0x00 for disable).
+ *
+ * When disabling (direction == 0), all loopback points matching the
+ * name are disabled regardless of their direction. When enabling,
+ * only the specific direction is activated.
+ *
+ * Return: 1 if hardware state changed, 0 if already in requested state,
+ *         negative errno on failure.
+ */
+int ethtool_cmis_set_loopback(struct net_device *dev,
+			      const struct ethtool_loopback_entry *entry,
+			      struct netlink_ext_ack *extack)
+{
+	struct ethtool_module_eeprom page = {};
+	u8 ctrl[CMIS_LB_CTRL_LEN];
+	int near_idx, far_idx;
+	u8 near_cap, far_cap;
+	bool mod = false;
+	int caps, ret;
+
+	if (!dev->ethtool_ops->set_module_eeprom_by_page) {
+		NL_SET_ERR_MSG(extack,
+			       "Module EEPROM write access not supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (dev->ethtool->module_fw_flash_in_progress) {
+		NL_SET_ERR_MSG(extack,
+			       "Module firmware flashing is in progress");
+		return -EBUSY;
+	}
+
+	if (dev->flags & IFF_UP) {
+		NL_SET_ERR_MSG(extack,
+			       "Netdevice is up, module loopback change not permitted");
+		return -EBUSY;
+	}
+
+	if (entry->direction && !is_power_of_2(entry->direction)) {
+		NL_SET_ERR_MSG(extack,
+			       "Only one loopback direction may be enabled at a time");
+		return -EINVAL;
+	}
+
+	if (!strcmp(entry->name, CMIS_LB_NAME_HOST)) {
+		near_idx = CMIS_LB_CTRL_IDX_HOST_INPUT;
+		far_idx = CMIS_LB_CTRL_IDX_HOST_OUTPUT;
+		near_cap = CMIS_LB_CAP_HOST_INPUT;
+		far_cap = CMIS_LB_CAP_HOST_OUTPUT;
+	} else if (!strcmp(entry->name, CMIS_LB_NAME_MEDIA)) {
+		near_idx = CMIS_LB_CTRL_IDX_MEDIA_INPUT;
+		far_idx = CMIS_LB_CTRL_IDX_MEDIA_OUTPUT;
+		near_cap = CMIS_LB_CAP_MEDIA_INPUT;
+		far_cap = CMIS_LB_CAP_MEDIA_OUTPUT;
+	} else {
+		NL_SET_ERR_MSG(extack, "Unknown CMIS loopback name");
+		return -EINVAL;
+	}
+
+	caps = cmis_loopback_caps(dev);
+	if (caps < 0)
+		return caps;
+	if (!caps) {
+		NL_SET_ERR_MSG(extack, "Module does not support CMIS loopback");
+		return -EOPNOTSUPP;
+	}
+
+	/* Read current control bytes */
+	ethtool_cmis_page_init(&page, CMIS_LB_CTRL_PAGE,
+			       CMIS_LB_CTRL_OFFSET, sizeof(ctrl));
+	page.data = ctrl;
+	ret = dev->ethtool_ops->get_module_eeprom_by_page(dev, &page, NULL);
+	if (ret < 0)
+		return ret;
+
+	if (!entry->direction) {
+		/* Disable both directions */
+		if (ctrl[near_idx]) {
+			ctrl[near_idx] = 0x00;
+			mod = true;
+		}
+		if (ctrl[far_idx]) {
+			ctrl[far_idx] = 0x00;
+			mod = true;
+		}
+	} else {
+		int enable_idx, disable_idx;
+		u8 enable_cap;
+
+		if (entry->direction & ETHTOOL_LOOPBACK_DIRECTION_NEAR_END) {
+			enable_idx = near_idx;
+			enable_cap = near_cap;
+			disable_idx = far_idx;
+		} else {
+			enable_idx = far_idx;
+			enable_cap = far_cap;
+			disable_idx = near_idx;
+		}
+
+		if (!(caps & enable_cap)) {
+			NL_SET_ERR_MSG(extack,
+				       "Loopback mode not supported by module");
+			return -EOPNOTSUPP;
+		}
+
+		/* Disable opposite direction first (mutual exclusivity) */
+		if (ctrl[disable_idx]) {
+			ctrl[disable_idx] = 0x00;
+			ret = dev->ethtool_ops->set_module_eeprom_by_page(dev,
+				&page, extack);
+			if (ret < 0)
+				return ret;
+			mod = true;
+		}
+
+		if (ctrl[enable_idx] != 0xff) {
+			ctrl[enable_idx] = 0xff;
+			mod = true;
+		}
+	}
+
+	if (!mod)
+		return 0;
+
+	ret = dev->ethtool_ops->set_module_eeprom_by_page(dev, &page, extack);
+
+	return ret < 0 ? ret : 1;
+}
diff --git a/net/ethtool/loopback.c b/net/ethtool/loopback.c
index 8907dd147404..ed184f45322e 100644
--- a/net/ethtool/loopback.c
+++ b/net/ethtool/loopback.c
@@ -86,6 +86,8 @@ static int loopback_get(struct net_device *dev,
 			struct ethtool_loopback_entry *entry)
 {
 	switch (component) {
+	case ETHTOOL_LOOPBACK_COMPONENT_MODULE:
+		return ethtool_cmis_get_loopback(dev, name, entry);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -94,7 +96,7 @@ static int loopback_get(struct net_device *dev,
 static int loopback_get_by_index(struct net_device *dev, u32 index,
 				 struct ethtool_loopback_entry *entry)
 {
-	return -EOPNOTSUPP;
+	return ethtool_cmis_get_loopback_by_index(dev, index, entry);
 }
 
 static int loopback_prepare_data(const struct ethnl_req_info *req_base,
@@ -223,6 +225,8 @@ static int __loopback_set(struct net_device *dev,
 			  struct netlink_ext_ack *extack)
 {
 	switch (entry->component) {
+	case ETHTOOL_LOOPBACK_COMPONENT_MODULE:
+		return ethtool_cmis_set_loopback(dev, entry, extack);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 2320760f931e..5aec1b73da7a 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -551,6 +551,14 @@ int ethnl_perphy_dump_one_dev(struct sk_buff *skb,
 			      struct ethnl_dump_ctx *ctx,
 			      unsigned long *pos_sub,
 			      const struct genl_info *info);
+int ethtool_cmis_get_loopback_by_index(struct net_device *dev, u32 index,
+				       struct ethtool_loopback_entry *entry);
+int ethtool_cmis_get_loopback(struct net_device *dev,
+			      const char *name,
+			      struct ethtool_loopback_entry *entry);
+int ethtool_cmis_set_loopback(struct net_device *dev,
+			      const struct ethtool_loopback_entry *entry,
+			      struct netlink_ext_ack *extack);
 
 extern const char stats_std_names[__ETHTOOL_STATS_CNT][ETH_GSTRING_LEN];
 extern const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING_LEN];
-- 
2.53.0


