Return-Path: <linux-rdma+bounces-17713-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0C6pAm5urWnN2wEAu9opvQ
	(envelope-from <linux-rdma+bounces-17713-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 13:41:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9212303F6
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 13:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DB013023061
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 12:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F00C371042;
	Sun,  8 Mar 2026 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkF6dkq1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E334C33D50A;
	Sun,  8 Mar 2026 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772973634; cv=none; b=Ygk11H0gDNDtFuDU28eNOV5ALSsCxoyh3Y/Gx53zT2JaXqBW8akEEYQ3CRuh3QmyuE1RzVkUgqlJXjXrgJ2w5aAKL10JP1wS/3RPZDpsY9B40ZVLu0jy36GFmH4Xeflh70t1PSRb5dqYBIBYpKJ5peCi8FJil5LUDUb5VHhpwXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772973634; c=relaxed/simple;
	bh=QZ6V/K2U5F+/TrGWi0L8Ef0LSlOYY9J/mYNVvgnlP60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L38Ckzgpw0MggKZ5XLhotseZjc+rWb4Z1wMIgrjnXHNpbWU9w+yC0fp2F7YZSeJH1IgTNJHZOlXZNv5bShV/8NrG6CHG9fnsJCKxQS9ns1rNFwU9euBJgTgTbveXrUTIOaTRS7eEb7dVWKMOacsGuQo7ycpQ6ASS2fPdOt+noUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkF6dkq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF82C19423;
	Sun,  8 Mar 2026 12:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772973633;
	bh=QZ6V/K2U5F+/TrGWi0L8Ef0LSlOYY9J/mYNVvgnlP60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qkF6dkq1fRPeKYrmo0N4OEYuZNpSyz35fUKMx2vVrZu184/T3qzNiBCANNtpSccbB
	 9kjK4UYO5vNYtkUgluusiMZsdTZmrpp+ADkAYC0SjU2J85I1zqIAlulYGrsxGIfkwG
	 1e/FJ8NbGgzLYBc+aQZAb4Nt3+2ySezS7GL2H85BqywdoKa7QoEUetDk6SD/O2AobO
	 JlmJDz2vXunzPu2yDvcPgqrAKEmvgdJtJ7aOW0mw2nIXOUBoOHhS5IhvkBwuxjly4X
	 WIlROSxriuOAlI9CInawgvLAOWI4FtXf3auXUm66VKDfBPK8JQcqTWZapuE0V8lsp1
	 Y/gfieldkBfDQ==
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
Subject: [RFC net-next v2 2/6] ethtool: Add loopback GET/SET netlink implementation
Date: Sun,  8 Mar 2026 13:40:08 +0100
Message-ID: <20260308124016.3134012-3-bjorn@kernel.org>
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
X-Rspamd-Queue-Id: 7D9212303F6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.96 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17713-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.959];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add the kernel-side ETHTOOL_MSG_LOOPBACK_GET,
ETHTOOL_MSG_LOOPBACK_SET, and ETHTOOL_MSG_LOOPBACK_NTF handlers using
the standard ethnl_request_ops infrastructure.

GET collects loopback entries from per-component helpers via
loopback_get_entries(). SET parses the nested entry attributes,
dispatches each to loopback_set_one(), and only sends a notification
when the state is changed.

No components are wired yet.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 include/linux/ethtool.h |  28 +++++
 net/ethtool/Makefile    |   2 +-
 net/ethtool/loopback.c  | 246 ++++++++++++++++++++++++++++++++++++++++
 net/ethtool/netlink.c   |  20 ++++
 net/ethtool/netlink.h   |   3 +
 5 files changed, 298 insertions(+), 1 deletion(-)
 create mode 100644 net/ethtool/loopback.c

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 83c375840835..b1ebfe22c355 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -846,6 +846,34 @@ void ethtool_mmsv_set_mm(struct ethtool_mmsv *mmsv, struct ethtool_mm_cfg *cfg);
 void ethtool_mmsv_init(struct ethtool_mmsv *mmsv, struct net_device *dev,
 		       const struct ethtool_mmsv_ops *ops);
 
+/**
+ * struct ethtool_loopback_entry - Per-component loopback configuration
+ * @id: Optional component instance identifier, 0 means not specified
+ * @supported: Bitmask of supported directions
+ * @component: Loopback component
+ * @direction: Current loopback direction, 0 means disabled
+ * @name: Subsystem-specific name for the loopback point
+ */
+struct ethtool_loopback_entry {
+	enum ethtool_loopback_component component;
+	u32 id;
+	u32 supported;
+	u32 direction;
+	char name[ETH_GSTRING_LEN];
+};
+
+#define ETHTOOL_LOOPBACK_MAX_ENTRIES	16
+
+/**
+ * struct ethtool_loopback_cfg - Loopback configuration
+ * @entries: Array of per-component loopback configurations
+ * @n_entries: Number of valid entries in the array
+ */
+struct ethtool_loopback_cfg {
+	struct ethtool_loopback_entry entries[ETHTOOL_LOOPBACK_MAX_ENTRIES];
+	u32 n_entries;
+};
+
 /**
  * struct ethtool_rxfh_param - RXFH (RSS) parameters
  * @hfunc: Defines the current RSS hash function used by HW (or to be set to).
diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
index 629c10916670..ef534b55d724 100644
--- a/net/ethtool/Makefile
+++ b/net/ethtool/Makefile
@@ -9,4 +9,4 @@ ethtool_nl-y	:= netlink.o bitset.o strset.o linkinfo.o linkmodes.o rss.o \
 		   channels.o coalesce.o pause.o eee.o tsinfo.o cabletest.o \
 		   tunnels.o fec.o eeprom.o stats.o phc_vclocks.o mm.o \
 		   module.o cmis_fw_update.o cmis_cdb.o pse-pd.o plca.o \
-		   phy.o tsconfig.o mse.o
+		   phy.o tsconfig.o mse.o loopback.o
diff --git a/net/ethtool/loopback.c b/net/ethtool/loopback.c
new file mode 100644
index 000000000000..1c6d27857f8a
--- /dev/null
+++ b/net/ethtool/loopback.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "netlink.h"
+#include "common.h"
+
+struct loopback_req_info {
+	struct ethnl_req_info base;
+};
+
+struct loopback_reply_data {
+	struct ethnl_reply_data base;
+	struct ethtool_loopback_cfg cfg;
+};
+
+#define LOOPBACK_REPDATA(__reply_base) \
+	container_of(__reply_base, struct loopback_reply_data, base)
+
+/* GET */
+
+static const struct nla_policy
+ethnl_loopback_entry_policy[ETHTOOL_A_LOOPBACK_ENTRY_MAX + 1] = {
+	[ETHTOOL_A_LOOPBACK_ENTRY_COMPONENT] =
+		NLA_POLICY_MAX(NLA_U32, ETHTOOL_LOOPBACK_COMPONENT_MODULE),
+	[ETHTOOL_A_LOOPBACK_ENTRY_ID] =
+		NLA_POLICY_MIN(NLA_U32, 1),
+	[ETHTOOL_A_LOOPBACK_ENTRY_NAME] =
+		{ .type = NLA_NUL_STRING, .len = ETH_GSTRING_LEN - 1 },
+	[ETHTOOL_A_LOOPBACK_ENTRY_DIRECTION] =
+		NLA_POLICY_MASK(NLA_U32, ETHTOOL_LOOPBACK_DIRECTION_NEAR_END |
+				ETHTOOL_LOOPBACK_DIRECTION_FAR_END),
+};
+
+const struct nla_policy ethnl_loopback_get_policy[] = {
+	[ETHTOOL_A_LOOPBACK_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
+};
+
+static int loopback_get_entries(struct net_device *dev,
+				struct ethtool_loopback_cfg *cfg)
+{
+	return 0;
+}
+
+static int loopback_prepare_data(const struct ethnl_req_info *req_base,
+				 struct ethnl_reply_data *reply_base,
+				 const struct genl_info *info)
+{
+	struct loopback_reply_data *data = LOOPBACK_REPDATA(reply_base);
+	struct net_device *dev = reply_base->dev;
+	int ret;
+
+	ret = ethnl_ops_begin(dev);
+	if (ret < 0)
+		return ret;
+
+	ret = loopback_get_entries(dev, &data->cfg);
+
+	ethnl_ops_complete(dev);
+
+	return ret;
+}
+
+static int loopback_reply_size(const struct ethnl_req_info *req_base,
+			       const struct ethnl_reply_data *reply_base)
+{
+	const struct loopback_reply_data *data = LOOPBACK_REPDATA(reply_base);
+	int entry_size;
+
+	/* Per-entry: nest + component + id + name + supported + direction */
+	entry_size = nla_total_size(0) +		/* nest */
+		nla_total_size(sizeof(u32)) +		/* component */
+		nla_total_size(sizeof(u32)) +		/* id */
+		nla_total_size(sizeof(u32)) +		/* supported */
+		nla_total_size(sizeof(u32)) +		/* direction */
+		nla_total_size(ETH_GSTRING_LEN);	/* name */
+
+	return data->cfg.n_entries * entry_size;
+}
+
+static int loopback_fill_entry(struct sk_buff *skb,
+			       const struct ethtool_loopback_entry *entry)
+{
+	struct nlattr *nest;
+
+	nest = nla_nest_start(skb, ETHTOOL_A_LOOPBACK_ENTRY);
+	if (!nest)
+		return -EMSGSIZE;
+
+	if (nla_put_u32(skb, ETHTOOL_A_LOOPBACK_ENTRY_COMPONENT,
+			entry->component))
+		goto err_cancel;
+
+	if (entry->id &&
+	    nla_put_u32(skb, ETHTOOL_A_LOOPBACK_ENTRY_ID, entry->id))
+		goto err_cancel;
+
+	if (nla_put_u32(skb, ETHTOOL_A_LOOPBACK_ENTRY_SUPPORTED,
+			entry->supported) ||
+	    nla_put_u32(skb, ETHTOOL_A_LOOPBACK_ENTRY_DIRECTION,
+			entry->direction) ||
+	    nla_put_string(skb, ETHTOOL_A_LOOPBACK_ENTRY_NAME,
+			   entry->name))
+		goto err_cancel;
+
+	nla_nest_end(skb, nest);
+	return 0;
+
+err_cancel:
+	nla_nest_cancel(skb, nest);
+	return -EMSGSIZE;
+}
+
+static int loopback_fill_reply(struct sk_buff *skb,
+			       const struct ethnl_req_info *req_base,
+			       const struct ethnl_reply_data *reply_base)
+{
+	const struct loopback_reply_data *data = LOOPBACK_REPDATA(reply_base);
+	const struct ethtool_loopback_cfg *cfg = &data->cfg;
+	u32 i;
+
+	for (i = 0; i < cfg->n_entries; i++) {
+		int ret = loopback_fill_entry(skb, &cfg->entries[i]);
+
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* SET */
+
+const struct nla_policy ethnl_loopback_set_policy[ETHTOOL_A_LOOPBACK_ENTRY + 1] = {
+	[ETHTOOL_A_LOOPBACK_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
+	[ETHTOOL_A_LOOPBACK_ENTRY]  = NLA_POLICY_NESTED(ethnl_loopback_entry_policy),
+};
+
+static int loopback_parse_entry(struct nlattr *attr,
+				struct ethtool_loopback_entry *entry,
+				struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[ETHTOOL_A_LOOPBACK_ENTRY_MAX + 1];
+	int ret;
+
+	ret = nla_parse_nested(tb, ETHTOOL_A_LOOPBACK_ENTRY_MAX, attr,
+			       ethnl_loopback_entry_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (!tb[ETHTOOL_A_LOOPBACK_ENTRY_COMPONENT]) {
+		NL_SET_ERR_MSG_ATTR(extack, attr,
+				    "loopback component is required");
+		return -EINVAL;
+	}
+
+	entry->component = nla_get_u32(tb[ETHTOOL_A_LOOPBACK_ENTRY_COMPONENT]);
+
+	if (tb[ETHTOOL_A_LOOPBACK_ENTRY_ID])
+		entry->id = nla_get_u32(tb[ETHTOOL_A_LOOPBACK_ENTRY_ID]);
+
+	if (!tb[ETHTOOL_A_LOOPBACK_ENTRY_NAME]) {
+		NL_SET_ERR_MSG_ATTR(extack, attr,
+				    "loopback name is required");
+		return -EINVAL;
+	}
+	nla_strscpy(entry->name, tb[ETHTOOL_A_LOOPBACK_ENTRY_NAME],
+		    sizeof(entry->name));
+
+	if (!tb[ETHTOOL_A_LOOPBACK_ENTRY_DIRECTION]) {
+		NL_SET_ERR_MSG_ATTR(extack, attr,
+				    "loopback direction is required");
+		return -EINVAL;
+	}
+
+	entry->direction = nla_get_u32(tb[ETHTOOL_A_LOOPBACK_ENTRY_DIRECTION]);
+
+	return 0;
+}
+
+static int loopback_set_one(struct net_device *dev,
+			    const struct ethtool_loopback_entry *entry,
+			    struct netlink_ext_ack *extack)
+{
+	switch (entry->component) {
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ethnl_set_loopback(struct ethnl_req_info *req_info,
+			      struct genl_info *info)
+{
+	struct net_device *dev = req_info->dev;
+	struct ethtool_loopback_cfg cfg = {};
+	int rem, ret, mod = 0;
+	struct nlattr *attr;
+	u32 i;
+
+	nla_for_each_attr(attr, genlmsg_data(info->genlhdr),
+			  genlmsg_len(info->genlhdr), rem) {
+		if (nla_type(attr) != ETHTOOL_A_LOOPBACK_ENTRY)
+			continue;
+
+		if (cfg.n_entries >= ETHTOOL_LOOPBACK_MAX_ENTRIES) {
+			NL_SET_ERR_MSG(info->extack,
+				       "too many loopback entries");
+			return -EINVAL;
+		}
+
+		ret = loopback_parse_entry(attr, &cfg.entries[cfg.n_entries],
+					   info->extack);
+		if (ret < 0)
+			return ret;
+
+		cfg.n_entries++;
+	}
+
+	if (!cfg.n_entries) {
+		NL_SET_ERR_MSG(info->extack, "no loopback entries specified");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < cfg.n_entries; i++) {
+		ret = loopback_set_one(dev, &cfg.entries[i], info->extack);
+		if (ret < 0)
+			return ret;
+		if (ret > 0)
+			mod = 1;
+	}
+
+	return mod;
+}
+
+const struct ethnl_request_ops ethnl_loopback_request_ops = {
+	.request_cmd		= ETHTOOL_MSG_LOOPBACK_GET,
+	.reply_cmd		= ETHTOOL_MSG_LOOPBACK_GET_REPLY,
+	.hdr_attr		= ETHTOOL_A_LOOPBACK_HEADER,
+	.req_info_size		= sizeof(struct loopback_req_info),
+	.reply_data_size	= sizeof(struct loopback_reply_data),
+
+	.prepare_data		= loopback_prepare_data,
+	.reply_size		= loopback_reply_size,
+	.fill_reply		= loopback_fill_reply,
+
+	.set			= ethnl_set_loopback,
+	.set_ntf_cmd		= ETHTOOL_MSG_LOOPBACK_NTF,
+};
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 6e5f0f4f815a..c438828ea072 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -421,6 +421,8 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_TSCONFIG_SET]	= &ethnl_tsconfig_request_ops,
 	[ETHTOOL_MSG_PHY_GET]		= &ethnl_phy_request_ops,
 	[ETHTOOL_MSG_MSE_GET]		= &ethnl_mse_request_ops,
+	[ETHTOOL_MSG_LOOPBACK_GET]	= &ethnl_loopback_request_ops,
+	[ETHTOOL_MSG_LOOPBACK_SET]	= &ethnl_loopback_request_ops,
 };
 
 static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
@@ -962,6 +964,7 @@ ethnl_default_notify_ops[ETHTOOL_MSG_KERNEL_MAX + 1] = {
 	[ETHTOOL_MSG_MM_NTF]		= &ethnl_mm_request_ops,
 	[ETHTOOL_MSG_RSS_NTF]		= &ethnl_rss_request_ops,
 	[ETHTOOL_MSG_RSS_CREATE_NTF]	= &ethnl_rss_request_ops,
+	[ETHTOOL_MSG_LOOPBACK_NTF]	= &ethnl_loopback_request_ops,
 };
 
 /* default notification handler */
@@ -1070,6 +1073,7 @@ static const ethnl_notify_handler_t ethnl_notify_handlers[] = {
 	[ETHTOOL_MSG_MM_NTF]		= ethnl_default_notify,
 	[ETHTOOL_MSG_RSS_NTF]		= ethnl_default_notify,
 	[ETHTOOL_MSG_RSS_CREATE_NTF]	= ethnl_default_notify,
+	[ETHTOOL_MSG_LOOPBACK_NTF]	= ethnl_default_notify,
 };
 
 void ethnl_notify(struct net_device *dev, unsigned int cmd,
@@ -1544,6 +1548,22 @@ static const struct genl_ops ethtool_genl_ops[] = {
 		.policy = ethnl_mse_get_policy,
 		.maxattr = ARRAY_SIZE(ethnl_mse_get_policy) - 1,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_LOOPBACK_GET,
+		.doit	= ethnl_default_doit,
+		.start	= ethnl_default_start,
+		.dumpit	= ethnl_default_dumpit,
+		.done	= ethnl_default_done,
+		.policy = ethnl_loopback_get_policy,
+		.maxattr = ARRAY_SIZE(ethnl_loopback_get_policy) - 1,
+	},
+	{
+		.cmd	= ETHTOOL_MSG_LOOPBACK_SET,
+		.flags	= GENL_UNS_ADMIN_PERM,
+		.doit	= ethnl_default_set_doit,
+		.policy = ethnl_loopback_set_policy,
+		.maxattr = ARRAY_SIZE(ethnl_loopback_set_policy) - 1,
+	},
 };
 
 static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 89010eaa67df..5660ce494916 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -443,6 +443,7 @@ extern const struct ethnl_request_ops ethnl_mm_request_ops;
 extern const struct ethnl_request_ops ethnl_phy_request_ops;
 extern const struct ethnl_request_ops ethnl_tsconfig_request_ops;
 extern const struct ethnl_request_ops ethnl_mse_request_ops;
+extern const struct ethnl_request_ops ethnl_loopback_request_ops;
 
 extern const struct nla_policy ethnl_header_policy[ETHTOOL_A_HEADER_FLAGS + 1];
 extern const struct nla_policy ethnl_header_policy_stats[ETHTOOL_A_HEADER_FLAGS + 1];
@@ -499,6 +500,8 @@ extern const struct nla_policy ethnl_phy_get_policy[ETHTOOL_A_PHY_HEADER + 1];
 extern const struct nla_policy ethnl_tsconfig_get_policy[ETHTOOL_A_TSCONFIG_HEADER + 1];
 extern const struct nla_policy ethnl_tsconfig_set_policy[ETHTOOL_A_TSCONFIG_MAX + 1];
 extern const struct nla_policy ethnl_mse_get_policy[ETHTOOL_A_MSE_HEADER + 1];
+extern const struct nla_policy ethnl_loopback_get_policy[ETHTOOL_A_LOOPBACK_HEADER + 1];
+extern const struct nla_policy ethnl_loopback_set_policy[ETHTOOL_A_LOOPBACK_ENTRY + 1];
 
 int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
 int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
-- 
2.53.0


