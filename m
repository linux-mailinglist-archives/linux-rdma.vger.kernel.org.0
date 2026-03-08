Return-Path: <linux-rdma+bounces-17714-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GH4DtpurWme2wEAu9opvQ
	(envelope-from <linux-rdma+bounces-17714-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 13:43:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB7323042C
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 13:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A318304E82D
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 12:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4A136F439;
	Sun,  8 Mar 2026 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yr9WkOYr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ED2314B76;
	Sun,  8 Mar 2026 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772973638; cv=none; b=QxZR+KGuuyHKBh7uLnBBB3xA657ihWzidMf91Dz/mbp50tXgBoX8YMufzUGEiJsdhcpiqh3io/+F18Hezvh7Yd6CBDLobuRQ26J8hmvnJRQtx16QaKJA0b4yWkUhaA2PPKCjx/VbgrnRaTLr1KK6SqScajuRi2Us74W9Al43ulU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772973638; c=relaxed/simple;
	bh=n0zmjGWD/AHlp3pJeJha/3C6wqT5Iw+GfJKYJAZPf/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJCSx43JeQXViEDMMIz6iK+7fHHhWDb7ipwaqrrt5CDanIBTkbTq1cWsZvyD7IPLoBR5ZDvHB3aSg3G+wqppILfmEu0X/2ZDvq+Pag6Xxt6crc2BC1dpKSFSgxcdknd5efA0YJz0600gBEY3n84/SuKwJBh6FZbPILMklQvqyts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yr9WkOYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F48C116C6;
	Sun,  8 Mar 2026 12:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772973638;
	bh=n0zmjGWD/AHlp3pJeJha/3C6wqT5Iw+GfJKYJAZPf/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yr9WkOYrzEoWNCFvChWYOtbE8WjQg5ttn+4w5/SsU7EvtteVSSi9gBxUTWlE0XRHt
	 uIwbvqnJxS7UAupXiUl66igQ2GLxj9vjZnkwxEQQBk04ye6SOg59zlcNQtl4M3Trkf
	 UL3orFkNx3kwo2+pa4loPbDEt4oG5/LhBCt4b2wgXA5dj0LKLcoscBXUXI25J+rT08
	 khf/NECx/XPzEMpD89OvLUPz/tHxblhRBFCUZObL3kfDPC7ni/qXgC0YXrrVHhNusS
	 kZ1o5DmLRCGEmzzNiPCPK/QehgUfpdXagthf83bydAHOrdjSFhMLvqQR1vwRcwmPo/
	 4JAdoS66QpV+A==
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
Subject: [RFC net-next v2 3/6] ethtool: add CMIS loopback helpers for module loopback control
Date: Sun,  8 Mar 2026 13:40:09 +0100
Message-ID: <20260308124016.3134012-4-bjorn@kernel.org>
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
X-Rspamd-Queue-Id: CDB7323042C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.90 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17714-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.967];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[page.data:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add CMIS loopback functions and wire them into loopback.c for the
MODULE component:

 - ethtool_cmis_get_loopback(): reads Page 13h capabilities and
   current state, appends one entry per supported loopback point
   ("cmis-host" and/or "cmis-media").

 - ethtool_cmis_set_loopback_one(): resolves name to a pair of control
   byte indices, validates direction, and writes the Page 13h control
   bytes (0xFF = all lanes on, 0x00 = off).

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
 net/ethtool/cmis_loopback.c | 338 ++++++++++++++++++++++++++++++++++++
 net/ethtool/loopback.c      |   4 +-
 net/ethtool/netlink.h       |   5 +
 4 files changed, 347 insertions(+), 2 deletions(-)
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
index 000000000000..2114c85f507f
--- /dev/null
+++ b/net/ethtool/cmis_loopback.c
@@ -0,0 +1,338 @@
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
+#define CMIS_DIAG_SUPPORT_OFFSET	0x8E
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
+ *   Byte 180 (0xB4): Media Side Output  -> MODULE, "cmis-media", far-end
+ *   Byte 181 (0xB5): Media Side Input   -> MODULE, "cmis-media", near-end
+ *   Byte 182 (0xB6): Host Side Output   -> MODULE, "cmis-host",  far-end
+ *   Byte 183 (0xB7): Host Side Input    -> MODULE, "cmis-host",  near-end
+ */
+#define CMIS_LB_CTRL_PAGE		0x13
+#define CMIS_LB_CTRL_OFFSET		0xB4
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
+ * ethtool_cmis_get_loopback - Append CMIS module loopback entries to cfg
+ * @dev: Network device with get_module_eeprom_by_page support
+ * @cfg: Loopback configuration; MODULE entries are appended
+ *
+ * Reads CMIS module capabilities and current loopback state from Page
+ * 13h, then appends one entry for each supported loopback point.
+ * Returns 0 without adding entries if the module is not CMIS or does
+ * not advertise loopback support.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int ethtool_cmis_get_loopback(struct net_device *dev,
+			      struct ethtool_loopback_cfg *cfg)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_module_eeprom page = {};
+	struct ethtool_loopback_entry host = {
+		.component = ETHTOOL_LOOPBACK_COMPONENT_MODULE,
+		.name = CMIS_LB_NAME_HOST,
+	};
+	struct ethtool_loopback_entry media = {
+		.component = ETHTOOL_LOOPBACK_COMPONENT_MODULE,
+		.name = CMIS_LB_NAME_MEDIA,
+	};
+	int caps, ret, h = 0, m = 0;
+	u8 ctrl[CMIS_LB_CTRL_LEN];
+
+	if (dev->ethtool->module_fw_flash_in_progress)
+		return -EBUSY;
+
+	caps = cmis_loopback_caps(dev);
+	if (caps <= 0)
+		return caps;
+
+	/* Read all four control bytes in one access */
+	ethtool_cmis_page_init(&page, CMIS_LB_CTRL_PAGE,
+			       CMIS_LB_CTRL_OFFSET, sizeof(ctrl));
+	page.data = ctrl;
+	ret = ops->get_module_eeprom_by_page(dev, &page, NULL);
+	if (ret < 0)
+		return ret;
+
+	if (caps & CMIS_LB_CAP_HOST_INPUT) {
+		h = 1;
+		host.supported |= ETHTOOL_LOOPBACK_DIRECTION_NEAR_END;
+		if (ctrl[CMIS_LB_CTRL_IDX_HOST_INPUT])
+			host.direction |= ETHTOOL_LOOPBACK_DIRECTION_NEAR_END;
+	}
+	if (caps & CMIS_LB_CAP_HOST_OUTPUT) {
+		h = 1;
+		host.supported |= ETHTOOL_LOOPBACK_DIRECTION_FAR_END;
+		if (ctrl[CMIS_LB_CTRL_IDX_HOST_OUTPUT])
+			host.direction |= ETHTOOL_LOOPBACK_DIRECTION_FAR_END;
+	}
+	if (caps & CMIS_LB_CAP_MEDIA_INPUT) {
+		m = 1;
+		media.supported |= ETHTOOL_LOOPBACK_DIRECTION_NEAR_END;
+		if (ctrl[CMIS_LB_CTRL_IDX_MEDIA_INPUT])
+			media.direction |= ETHTOOL_LOOPBACK_DIRECTION_NEAR_END;
+	}
+	if (caps & CMIS_LB_CAP_MEDIA_OUTPUT) {
+		m = 1;
+		media.supported |= ETHTOOL_LOOPBACK_DIRECTION_FAR_END;
+		if (ctrl[CMIS_LB_CTRL_IDX_MEDIA_OUTPUT])
+			media.direction |= ETHTOOL_LOOPBACK_DIRECTION_FAR_END;
+	}
+
+	if (cfg->n_entries + h + m > ETHTOOL_LOOPBACK_MAX_ENTRIES)
+		return -ENOMEM;
+
+	if (h) {
+		memcpy(&cfg->entries[cfg->n_entries], &host, sizeof(host));
+		cfg->n_entries++;
+	}
+
+	if (m) {
+		memcpy(&cfg->entries[cfg->n_entries], &media, sizeof(media));
+		cfg->n_entries++;
+	}
+
+	return 0;
+}
+
+/**
+ * ethtool_cmis_set_loopback_one - Apply one MODULE loopback entry to CMIS
+ * @dev: Network device with get/set_module_eeprom_by_page support
+ * @entry: Loopback entry to apply (must be MODULE component)
+ * @extack: Netlink extended ack for error reporting
+ *
+ * Matches the entry against CMIS loopback points by name and
+ * direction, then reads, modifies, and writes the corresponding Page
+ * 13h control byte (0xFF for all-lanes enable, 0x00 for disable).
+ *
+ * When disabling (direction == 0), all loopback points matching the
+ * name are disabled regardless of their direction. When enabling,
+ * only the specific direction is activated.
+ *
+ * Return: 1 if hardware state changed, 0 if already in requested state,
+ *         negative errno on failure.
+ */
+int ethtool_cmis_set_loopback_one(struct net_device *dev,
+				  const struct ethtool_loopback_entry *entry,
+				  struct netlink_ext_ack *extack)
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
+	if (strcmp(entry->name, CMIS_LB_NAME_HOST) == 0) {
+		near_idx = CMIS_LB_CTRL_IDX_HOST_INPUT;
+		far_idx = CMIS_LB_CTRL_IDX_HOST_OUTPUT;
+		near_cap = CMIS_LB_CAP_HOST_INPUT;
+		far_cap = CMIS_LB_CAP_HOST_OUTPUT;
+	} else if (strcmp(entry->name, CMIS_LB_NAME_MEDIA) == 0) {
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
+									  &page,
+									  extack);
+			if (ret < 0)
+				return ret;
+			mod = true;
+		}
+
+		if (ctrl[enable_idx] != 0xFF) {
+			ctrl[enable_idx] = 0xFF;
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
index 1c6d27857f8a..8a6f14f4b8cb 100644
--- a/net/ethtool/loopback.c
+++ b/net/ethtool/loopback.c
@@ -37,7 +37,7 @@ const struct nla_policy ethnl_loopback_get_policy[] = {
 static int loopback_get_entries(struct net_device *dev,
 				struct ethtool_loopback_cfg *cfg)
 {
-	return 0;
+	return ethtool_cmis_get_loopback(dev, cfg);
 }
 
 static int loopback_prepare_data(const struct ethnl_req_info *req_base,
@@ -181,6 +181,8 @@ static int loopback_set_one(struct net_device *dev,
 			    struct netlink_ext_ack *extack)
 {
 	switch (entry->component) {
+	case ETHTOOL_LOOPBACK_COMPONENT_MODULE:
+		return ethtool_cmis_set_loopback_one(dev, entry, extack);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 5660ce494916..707363462c12 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -517,6 +517,11 @@ int ethnl_tsinfo_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int ethnl_tsinfo_done(struct netlink_callback *cb);
 int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info);
 int ethnl_rss_delete_doit(struct sk_buff *skb, struct genl_info *info);
+int ethtool_cmis_get_loopback(struct net_device *dev,
+			      struct ethtool_loopback_cfg *cfg);
+int ethtool_cmis_set_loopback_one(struct net_device *dev,
+				  const struct ethtool_loopback_entry *entry,
+				  struct netlink_ext_ack *extack);
 
 extern const char stats_std_names[__ETHTOOL_STATS_CNT][ETH_GSTRING_LEN];
 extern const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING_LEN];
-- 
2.53.0


