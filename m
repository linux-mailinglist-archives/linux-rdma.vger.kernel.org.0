Return-Path: <linux-rdma+bounces-17012-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEx8F/YJl2nvtwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17012-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 14:02:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E3115ED2E
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 14:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8446303454C
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 13:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1003533A9CF;
	Thu, 19 Feb 2026 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5G6wcK1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C618930AAD7;
	Thu, 19 Feb 2026 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771506073; cv=none; b=b9uzz18vwuOD4mhafiN+H9pawAkUPwjsIBedJFW5X/recCrQQpLX/ppDoQVFvVrGMh/PB6XRKpqYcFUb+SOb+7PClBjuMdM4GvdCylLSVkSlH4NGo+3G7xt7wKpmCK6t7uAvavgGPJaSKDk2ZdKVGao11fW+P2ENLfDjSbdgIpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771506073; c=relaxed/simple;
	bh=N0+BoRFmiVNbRlaBtSp+cpYcmOQcv+RQ0WP1lS7akO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ndc422iNEjSpMECQ0b/wRok5qRPpkXXm42fjCz23pxaHBw/xVxDulSvwgIw/H63GPB0CHcijOZtNlGhaJVYYeuYL0HF+p0q+nGolEKKvWso1mXwfNiUbWjnupSOJEfKTAaf+D+WlOaCbBOreJyzYMJvVX4PrAURqedueq1vTRYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5G6wcK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A8BC4CEF7;
	Thu, 19 Feb 2026 13:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771506073;
	bh=N0+BoRFmiVNbRlaBtSp+cpYcmOQcv+RQ0WP1lS7akO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P5G6wcK1StOjHx2+7khnQdKuqYl6ek6RW560I3/4QH1PWHUu868JGzMbtiPJEeCuc
	 4cHUpd76KSEZeeVNVaqHsRn/OTNzDvMrCGVYXH5qgkw/HelcUXDod/pefHH+aWt5ng
	 7K8awl1X1Ey2bHZgcYQU7p8AAsxK3p29cuFOJVW/fVd3XNX3J7lNOyp2WnB5FcMDc7
	 yTVp1yyhowaLKsK8xFf2wMuDO7nwDNZXZdz9BUiPjj1MoLPLlyN/Ngh+pVzaPc3KLe
	 uKc+KCy2MCy7pou9pt9MYSYvbB0ag2jWdPF44S5XySYyfVtVJAvho8DJ2qNycmQnOd
	 7qiMbHNYAa5kg==
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
	linux-rdma@vger.kernel.org
Subject: [RFC net-next 2/4] ethtool: module: Add CMIS loopback GET/SET support
Date: Thu, 19 Feb 2026 14:00:43 +0100
Message-ID: <20260219130050.2390226-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219130050.2390226-1-bjorn@kernel.org>
References: <20260219130050.2390226-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.96 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17012-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[page_data.data:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 81E3115ED2E
X-Rspamd-Action: no action

Implement loopback mode control for CMIS-compliant transceiver modules
(QSFP-DD, OSFP, DSFP, etc.) by reading and writing EEPROM registers
directly via the existing get/set_module_eeprom_by_page driver ops.

Loopback capabilities are read from Page 01h Byte 142 (Table 8-40,
"Supported Diagnostic and Monitoring Capabilities", CMIS 5.2), where
the lower 4 bits advertise supported loopback types.

Loopback control is read/written via Page 13h Bytes 180-183 (Table
8-128 "Media Lane-Specific Loopback Controls", CMIS 5.2):
  - Byte 180: Media Side Output Loopback
  - Byte 181: Media Side Input Loopback
  - Byte 182: Host Side Output Loopback
  - Byte 183: Host Side Input Loopback

The SET path validates that the module is CMIS, that Page 13h is
advertised, and that requested modes are within the capabilities mask
before writing 0xFF (all-lanes enable) or 0x00 (disable) per control
byte.

No new ethtool_ops callbacks are introduced; all register access reuses
the existing EEPROM page infrastructure.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 include/linux/ethtool.h |  12 ++
 net/ethtool/module.c    | 280 ++++++++++++++++++++++++++++++++++++++--
 net/ethtool/netlink.h   |   2 +-
 3 files changed, 279 insertions(+), 15 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 798abec67a1b..b4cf0314b38c 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -683,6 +683,18 @@ struct ethtool_module_power_mode_params {
 	enum ethtool_module_power_mode mode;
 };
 
+/**
+ * struct ethtool_module_loopback_params - module loopback parameters
+ * @caps: The loopback types, %ETHTOOL_MODULE_LOOPBACK_TYPES_*,
+ *	supported by the module.
+ * @enabled: The loopback types, %ETHTOOL_MODULE_LOOPBACK_TYPES_*,
+ *	currently enabled by the module.
+ */
+struct ethtool_module_loopback_params {
+	u32 caps;
+	u32 enabled;
+};
+
 /**
  * struct ethtool_mm_state - 802.3 MAC merge layer state
  * @verify_time:
diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index 4d4e0a82579a..21d2f59985af 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -10,6 +10,7 @@
 #include "common.h"
 #include "bitset.h"
 #include "module_fw.h"
+#include "cmis.h"
 
 struct module_req_info {
 	struct ethnl_req_info base;
@@ -18,6 +19,8 @@ struct module_req_info {
 struct module_reply_data {
 	struct ethnl_reply_data	base;
 	struct ethtool_module_power_mode_params power;
+	struct ethtool_module_loopback_params loopback;
+	bool loopback_supp;
 };
 
 #define MODULE_REPDATA(__reply_base) \
@@ -47,6 +50,144 @@ static int module_get_power_mode(struct net_device *dev,
 	return ops->get_module_power_mode(dev, &data->power, extack);
 }
 
+#define CMIS_PHYS_ADMINISTRATIVE_INFO_PAGE	0
+#define CMIS_PHYS_ADMINISTRATIVE_INFO_OFFSET	0
+
+#define CMIS_PAGE13_ADVERTISEMENT_PAGE		0x01
+#define CMIS_PAGE13_ADVERTISEMENT_OFFSET	0x8E
+#define CMIS_PAGE13_SUPPORTED			BIT(5)
+
+#define CMIS_MODULE_LOOPBACK_CAPS_PAGE		0x13
+#define CMIS_MODULE_LOOPBACK_CAPS_OFFSET	0x80
+
+#define CMIS_MODULE_LOOPBACK_CTRL_PAGE		0x13
+#define CMIS_MODULE_LOOPBACK_CTRL_OFFSET	0xB4	/* 4 consecutive bytes */
+#define CMIS_MODULE_LOOPBACK_CTRL_LEN		4
+
+/* Mapping from Page 13h control bytes to ethtool_module_loopback_types flags.
+ * Byte offset 0xB4+i maps to loopback_ctrl_flags[i].
+ */
+static const u32 loopback_ctrl_flags[] = {
+	ETHTOOL_MODULE_LOOPBACK_TYPES_MEDIA_SIDE_OUTPUT,
+	ETHTOOL_MODULE_LOOPBACK_TYPES_MEDIA_SIDE_INPUT,
+	ETHTOOL_MODULE_LOOPBACK_TYPES_HOST_SIDE_OUTPUT,
+	ETHTOOL_MODULE_LOOPBACK_TYPES_HOST_SIDE_INPUT,
+};
+
+static bool module_is_cmis(u8 phys_id)
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
+	}
+	return false;
+}
+
+static bool module_has_cmis_page13(u8 supp)
+{
+	return !!(supp & CMIS_PAGE13_SUPPORTED);
+}
+
+/* Return <0 error, >0 loopback supported, =0 no support */
+static int module_get_loopback_caps(struct net_device *dev, struct netlink_ext_ack *extack,
+				    u8 *caps)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_module_eeprom page_data = {};
+	u8 phys_id, page13;
+	int err;
+
+	*caps = 0;
+
+	/* Read module physical ID to verify CMIS type */
+	ethtool_cmis_page_init(&page_data, CMIS_PHYS_ADMINISTRATIVE_INFO_PAGE,
+			       CMIS_PHYS_ADMINISTRATIVE_INFO_OFFSET, sizeof(phys_id));
+	page_data.data = &phys_id;
+
+	err = ops->get_module_eeprom_by_page(dev, &page_data, extack);
+	if (err < 0)
+		return err;
+
+	if (!module_is_cmis(phys_id))
+		return 0;
+
+	/* Read DiagnosticPagesSupported/Page13 availability */
+	ethtool_cmis_page_init(&page_data, CMIS_PAGE13_ADVERTISEMENT_PAGE,
+			       CMIS_PAGE13_ADVERTISEMENT_OFFSET, sizeof(page13));
+	page_data.data = &page13;
+
+	err = ops->get_module_eeprom_by_page(dev, &page_data, extack);
+	if (err < 0)
+		return err;
+
+	if (!module_has_cmis_page13(page13))
+		return 0;
+
+	/* Read loopback capabilities */
+	ethtool_cmis_page_init(&page_data, CMIS_MODULE_LOOPBACK_CAPS_PAGE,
+			       CMIS_MODULE_LOOPBACK_CAPS_OFFSET, sizeof(*caps));
+	page_data.data = caps;
+
+	err = ops->get_module_eeprom_by_page(dev, &page_data, extack);
+	if (err < 0)
+		return err;
+
+	/* Lower 4 bits map directly to ethtool_module_loopback_types flags */
+	*caps &= 0x0F;
+	return 1;
+}
+
+static int module_get_loopback(struct net_device *dev, struct module_reply_data *data,
+			       struct netlink_ext_ack *extack)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_module_eeprom page_data = {};
+	u8 ctrl[CMIS_MODULE_LOOPBACK_CTRL_LEN];
+	int err, i;
+	u8 caps;
+
+	if (!ops->get_module_eeprom_by_page)
+		return 0;
+
+	if (dev->ethtool->module_fw_flash_in_progress) {
+		NL_SET_ERR_MSG(extack, "Module firmware flashing is in progress");
+		return -EBUSY;
+	}
+
+	err = module_get_loopback_caps(dev, extack, &caps);
+	if (err < 0)
+		return err;
+
+	data->loopback_supp = (err == 1);
+	data->loopback.caps = caps;
+
+	if (!data->loopback.caps)
+		return 0;
+
+	/* Read loopback control from Page 13h, Bytes 180-183 */
+	ethtool_cmis_page_init(&page_data, CMIS_MODULE_LOOPBACK_CTRL_PAGE,
+			       CMIS_MODULE_LOOPBACK_CTRL_OFFSET, sizeof(ctrl));
+	page_data.data = ctrl;
+
+	err = ops->get_module_eeprom_by_page(dev, &page_data, extack);
+	if (err < 0)
+		return err;
+
+	/* Each non-zero byte means that loopback type is enabled */
+	for (i = 0; i < CMIS_MODULE_LOOPBACK_CTRL_LEN; i++) {
+		if (ctrl[i])
+			data->loopback.enabled |= loopback_ctrl_flags[i];
+	}
+
+	return 0;
+}
+
 static int module_prepare_data(const struct ethnl_req_info *req_base,
 			       struct ethnl_reply_data *reply_base,
 			       const struct genl_info *info)
@@ -63,6 +204,10 @@ static int module_prepare_data(const struct ethnl_req_info *req_base,
 	if (ret < 0)
 		goto out_complete;
 
+	ret = module_get_loopback(dev, data, info->extack);
+	if (ret < 0)
+		goto out_complete;
+
 out_complete:
 	ethnl_ops_complete(dev);
 	return ret;
@@ -80,6 +225,11 @@ static int module_reply_size(const struct ethnl_req_info *req_base,
 	if (data->power.mode)
 		len += nla_total_size(sizeof(u8));	/* _MODULE_POWER_MODE */
 
+	if (data->loopback_supp) {
+		/* _MODULE_LOOPBACK_{CAPABILITIES,ENABLED} */
+		len += nla_total_size(sizeof(u32)) * 2;
+	}
+
 	return len;
 }
 
@@ -98,16 +248,32 @@ static int module_fill_reply(struct sk_buff *skb,
 	    nla_put_u8(skb, ETHTOOL_A_MODULE_POWER_MODE, data->power.mode))
 		return -EMSGSIZE;
 
+	if (data->loopback_supp &&
+	    nla_put_uint(skb, ETHTOOL_A_MODULE_LOOPBACK_CAPABILITIES,
+			 data->loopback.caps))
+		return -EMSGSIZE;
+
+	if (data->loopback_supp &&
+	    nla_put_uint(skb, ETHTOOL_A_MODULE_LOOPBACK_ENABLED,
+			 data->loopback.enabled))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
 /* MODULE_SET */
 
-const struct nla_policy ethnl_module_set_policy[ETHTOOL_A_MODULE_POWER_MODE_POLICY + 1] = {
+const struct nla_policy ethnl_module_set_policy[ETHTOOL_A_MODULE_LOOPBACK_ENABLED + 1] = {
 	[ETHTOOL_A_MODULE_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
 	[ETHTOOL_A_MODULE_POWER_MODE_POLICY] =
 		NLA_POLICY_RANGE(NLA_U8, ETHTOOL_MODULE_POWER_MODE_POLICY_HIGH,
 				 ETHTOOL_MODULE_POWER_MODE_POLICY_AUTO),
+	[ETHTOOL_A_MODULE_LOOPBACK_ENABLED] =
+		NLA_POLICY_MASK(NLA_UINT,
+				ETHTOOL_MODULE_LOOPBACK_TYPES_MEDIA_SIDE_OUTPUT |
+				ETHTOOL_MODULE_LOOPBACK_TYPES_MEDIA_SIDE_INPUT |
+				ETHTOOL_MODULE_LOOPBACK_TYPES_HOST_SIDE_OUTPUT |
+				ETHTOOL_MODULE_LOOPBACK_TYPES_HOST_SIDE_INPUT),
 };
 
 static int
@@ -117,7 +283,8 @@ ethnl_set_module_validate(struct ethnl_req_info *req_info,
 	const struct ethtool_ops *ops = req_info->dev->ethtool_ops;
 	struct nlattr **tb = info->attrs;
 
-	if (!tb[ETHTOOL_A_MODULE_POWER_MODE_POLICY])
+	if (!tb[ETHTOOL_A_MODULE_POWER_MODE_POLICY] &&
+	    !tb[ETHTOOL_A_MODULE_LOOPBACK_ENABLED])
 		return 0;
 
 	if (req_info->dev->ethtool->module_fw_flash_in_progress) {
@@ -126,38 +293,123 @@ ethnl_set_module_validate(struct ethnl_req_info *req_info,
 		return -EBUSY;
 	}
 
-	if (!ops->get_module_power_mode || !ops->set_module_power_mode) {
+	if (tb[ETHTOOL_A_MODULE_POWER_MODE_POLICY] &&
+	    (!ops->get_module_power_mode || !ops->set_module_power_mode)) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[ETHTOOL_A_MODULE_POWER_MODE_POLICY],
 				    "Setting power mode policy is not supported by this device");
 		return -EOPNOTSUPP;
 	}
 
+	if (tb[ETHTOOL_A_MODULE_LOOPBACK_ENABLED] &&
+	    (!ops->get_module_eeprom_by_page || !ops->set_module_eeprom_by_page)) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[ETHTOOL_A_MODULE_LOOPBACK_ENABLED],
+				    "Setting loopback is not supported by this device");
+		return -EOPNOTSUPP;
+	}
+
+	if (tb[ETHTOOL_A_MODULE_LOOPBACK_ENABLED] &&
+	    (req_info->dev->flags & IFF_UP)) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Netdevice is up, so setting loopback is not permitted");
+		return -EBUSY;
+	}
+
 	return 1;
 }
 
-static int
-ethnl_set_module(struct ethnl_req_info *req_info, struct genl_info *info)
+static int module_set_loopback(struct net_device *dev, struct genl_info *info)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_module_eeprom page_data = {};
+	u8 ctrl[CMIS_MODULE_LOOPBACK_CTRL_LEN], caps;
+	bool changed = false;
+	int err, i;
+	u32 req;
+
+	req = nla_get_uint(info->attrs[ETHTOOL_A_MODULE_LOOPBACK_ENABLED]);
+
+	err = module_get_loopback_caps(dev, info->extack, &caps);
+	if (err < 0)
+		return err;
+
+	if (err == 0 || req & ~(u32)caps) {
+		NL_SET_ERR_MSG(info->extack, "Requested loopback mode(s) not supported by module");
+		return -EOPNOTSUPP;
+	}
+
+	/* Read current enabled state from Page 13h */
+	ethtool_cmis_page_init(&page_data, CMIS_MODULE_LOOPBACK_CTRL_PAGE,
+			       CMIS_MODULE_LOOPBACK_CTRL_OFFSET, sizeof(ctrl));
+	page_data.data = ctrl;
+
+	err = ops->get_module_eeprom_by_page(dev, &page_data, info->extack);
+	if (err < 0)
+		return err;
+
+	/* Update control bytes: 0xFF for all-lanes enable, 0x00 for disable */
+	for (i = 0; i < CMIS_MODULE_LOOPBACK_CTRL_LEN; i++) {
+		u8 new_val = (req & loopback_ctrl_flags[i]) ? 0xFF : 0x00;
+
+		if (ctrl[i] != new_val) {
+			ctrl[i] = new_val;
+			changed = true;
+		}
+	}
+
+	if (!changed)
+		return 0;
+
+	/* Write updated control bytes */
+	ethtool_cmis_page_init(&page_data, CMIS_MODULE_LOOPBACK_CTRL_PAGE,
+			       CMIS_MODULE_LOOPBACK_CTRL_OFFSET, sizeof(ctrl));
+	page_data.data = ctrl;
+
+	err = ops->set_module_eeprom_by_page(dev, &page_data, info->extack);
+	if (err < 0)
+		return err;
+
+	return 1;
+}
+
+static int ethnl_set_module(struct ethnl_req_info *req_info, struct genl_info *info)
 {
 	struct ethtool_module_power_mode_params power = {};
 	struct ethtool_module_power_mode_params power_new;
 	const struct ethtool_ops *ops;
 	struct net_device *dev = req_info->dev;
 	struct nlattr **tb = info->attrs;
-	int ret;
+	int ret = 0;
 
 	ops = dev->ethtool_ops;
 
-	power_new.policy = nla_get_u8(tb[ETHTOOL_A_MODULE_POWER_MODE_POLICY]);
-	ret = ops->get_module_power_mode(dev, &power, info->extack);
-	if (ret < 0)
-		return ret;
+	if (tb[ETHTOOL_A_MODULE_POWER_MODE_POLICY]) {
+		power_new.policy = nla_get_u8(tb[ETHTOOL_A_MODULE_POWER_MODE_POLICY]);
+		ret = ops->get_module_power_mode(dev, &power, info->extack);
+		if (ret < 0)
+			return ret;
 
-	if (power_new.policy == power.policy)
-		return 0;
+		if (power_new.policy != power.policy) {
+			ret = ops->set_module_power_mode(dev, &power_new,
+							 info->extack);
+			if (ret < 0)
+				return ret;
+			ret = 1;
+		}
+	}
 
-	ret = ops->set_module_power_mode(dev, &power_new, info->extack);
-	return ret < 0 ? ret : 1;
+	if (tb[ETHTOOL_A_MODULE_LOOPBACK_ENABLED]) {
+		int lret;
+
+		lret = module_set_loopback(dev, info);
+		if (lret < 0)
+			return lret;
+		if (lret > 0)
+			ret = lret;
+	}
+
+	return ret;
 }
 
 const struct ethnl_request_ops ethnl_module_request_ops = {
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 89010eaa67df..2284a333aa74 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -482,7 +482,7 @@ extern const struct nla_policy ethnl_module_eeprom_get_policy[ETHTOOL_A_MODULE_E
 extern const struct nla_policy ethnl_stats_get_policy[ETHTOOL_A_STATS_SRC + 1];
 extern const struct nla_policy ethnl_phc_vclocks_get_policy[ETHTOOL_A_PHC_VCLOCKS_HEADER + 1];
 extern const struct nla_policy ethnl_module_get_policy[ETHTOOL_A_MODULE_HEADER + 1];
-extern const struct nla_policy ethnl_module_set_policy[ETHTOOL_A_MODULE_POWER_MODE_POLICY + 1];
+extern const struct nla_policy ethnl_module_set_policy[ETHTOOL_A_MODULE_LOOPBACK_ENABLED + 1];
 extern const struct nla_policy ethnl_pse_get_policy[ETHTOOL_A_PSE_HEADER + 1];
 extern const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1];
 extern const struct nla_policy ethnl_rss_get_policy[ETHTOOL_A_RSS_START_CONTEXT + 1];
-- 
2.53.0


