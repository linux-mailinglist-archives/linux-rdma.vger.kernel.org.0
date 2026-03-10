Return-Path: <linux-rdma+bounces-17855-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFGpLNP3r2mmdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17855-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:52:03 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFEF249B71
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0776731AC0CF
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 10:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3968937E303;
	Tue, 10 Mar 2026 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOzNxiHP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA44337998F;
	Tue, 10 Mar 2026 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139692; cv=none; b=UBfmKY5NsOyslFNsN/lz9EU/2yDDIwsrX/29SvcrtGiqaNxIiI+53e4GC6BBz5L/H6exeY6t6yBrygxrvIR0LHSY3pgtvG6W4R1U6AkpGzX+w5wO94T6uBSoGo7kKeHz2nuTVYIF+pgAL/j4PgMRAX+GaAlF/eNVvHApkRMa40A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139692; c=relaxed/simple;
	bh=4nsuZH1vTh91kwqDNhVaU7ZTf1hSkjMiygJmkEnN7cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCWinZiynBRH4hMnsuzigWd1RbAdeJcCMRs2GLpTogHoruYWXDK5gACbq1+yQTshQLnIYRAthMb7xideHPhIBa4uIBpxW3IqO3KTQL/N3mKjGrV3A1KxVd3mdTc8Y85dcjDjc5Vi5Us2Lwq5EVNMU9x4vGYVhZJDZ8IuUshiw1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOzNxiHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E96C19423;
	Tue, 10 Mar 2026 10:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773139691;
	bh=4nsuZH1vTh91kwqDNhVaU7ZTf1hSkjMiygJmkEnN7cA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mOzNxiHPjMrgPETE4krlylnzqdRiGRwIEuHVyfJb7UdDpd/ammbsLlcRjmaF+wQhK
	 wExLr3MLcT2U91xxtStrAS0aMC8M6W343weZKXPSDfElbOKCCAI1zE0oQnDaVZkRaq
	 2+mfX70dVTcX/xMOr0wIDEF9XLzUxa1wKNd/C48Av8dw2faB49Pd7IlEc/GM4WXVTL
	 KxSt0p7IpQ0LjMHJhpfdz8ng9KGZgO8F61U7K12TfhROA/d3niXH2nCobvgo4U6qZy
	 Hf1/OLBuzaLBy4KoLldwv7AFPO5gIiL4vMlOYGrDZi0acurBN/BeGqxHrj9GSuToFt
	 5mm/yvZgHSLlQ==
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
Subject: [PATCH net-next 03/11] ethtool: Add loopback GET/SET netlink implementation
Date: Tue, 10 Mar 2026 11:47:33 +0100
Message-ID: <20260310104743.907818-4-bjorn@kernel.org>
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
X-Rspamd-Queue-Id: 4AFEF249B71
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.01 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17855-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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
 include/linux/ethtool.h |  16 +++
 net/ethtool/Makefile    |   2 +-
 net/ethtool/loopback.c  | 305 ++++++++++++++++++++++++++++++++++++++++
 net/ethtool/netlink.c   |  24 +++-
 net/ethtool/netlink.h   |   6 +
 5 files changed, 350 insertions(+), 3 deletions(-)
 create mode 100644 net/ethtool/loopback.c

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 83c375840835..c9beca11fc40 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -846,6 +846,22 @@ void ethtool_mmsv_set_mm(struct ethtool_mmsv *mmsv, struct ethtool_mm_cfg *cfg);
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
index 000000000000..8907dd147404
--- /dev/null
+++ b/net/ethtool/loopback.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "netlink.h"
+#include "common.h"
+
+struct loopback_req_info {
+	struct ethnl_req_info base;
+	enum ethtool_loopback_component component;
+	u32 id;
+	char name[ETH_GSTRING_LEN];
+	bool lookup_by_name;
+	u32 index;
+};
+
+#define LOOPBACK_REQINFO(__req_base) \
+	container_of(__req_base, struct loopback_req_info, base)
+
+struct loopback_reply_data {
+	struct ethnl_reply_data base;
+	struct ethtool_loopback_entry entry;
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
+	[ETHTOOL_A_LOOPBACK_ENTRY_ID] = NLA_POLICY_MIN(NLA_U32, 1),
+	[ETHTOOL_A_LOOPBACK_ENTRY_NAME] = { .type = NLA_NUL_STRING,
+					    .len = ETH_GSTRING_LEN },
+	[ETHTOOL_A_LOOPBACK_ENTRY_DIRECTION] =
+		NLA_POLICY_MASK(NLA_U8, ETHTOOL_LOOPBACK_DIRECTION_NEAR_END |
+				ETHTOOL_LOOPBACK_DIRECTION_FAR_END),
+};
+
+const struct nla_policy
+ethnl_loopback_get_policy[ETHTOOL_A_LOOPBACK_MAX + 1] = {
+	[ETHTOOL_A_LOOPBACK_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
+	[ETHTOOL_A_LOOPBACK_ENTRY] =
+		NLA_POLICY_NESTED(ethnl_loopback_entry_policy),
+};
+
+static int loopback_parse_request(struct ethnl_req_info *req_base,
+				  struct nlattr **tb,
+				  struct netlink_ext_ack *extack)
+{
+	struct loopback_req_info *req_info = LOOPBACK_REQINFO(req_base);
+	struct nlattr *entry_tb[ETHTOOL_A_LOOPBACK_ENTRY_MAX + 1];
+	int ret;
+
+	if (!tb[ETHTOOL_A_LOOPBACK_ENTRY])
+		return 0;
+
+	ret = nla_parse_nested(entry_tb, ETHTOOL_A_LOOPBACK_ENTRY_MAX,
+			       tb[ETHTOOL_A_LOOPBACK_ENTRY],
+			       ethnl_loopback_entry_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (!entry_tb[ETHTOOL_A_LOOPBACK_ENTRY_COMPONENT] ||
+	    !entry_tb[ETHTOOL_A_LOOPBACK_ENTRY_NAME]) {
+		NL_SET_ERR_MSG(extack,
+			       "component and name required for loopback lookup");
+		return -EINVAL;
+	}
+
+	req_info->component =
+		nla_get_u32(entry_tb[ETHTOOL_A_LOOPBACK_ENTRY_COMPONENT]);
+	if (entry_tb[ETHTOOL_A_LOOPBACK_ENTRY_ID])
+		req_info->id =
+			nla_get_u32(entry_tb[ETHTOOL_A_LOOPBACK_ENTRY_ID]);
+	nla_strscpy(req_info->name, entry_tb[ETHTOOL_A_LOOPBACK_ENTRY_NAME],
+		    sizeof(req_info->name));
+	req_info->lookup_by_name = true;
+
+	return 0;
+}
+
+static int loopback_get(struct net_device *dev,
+			enum ethtool_loopback_component component, u32 id,
+			const char *name,
+			struct ethtool_loopback_entry *entry)
+{
+	switch (component) {
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int loopback_get_by_index(struct net_device *dev, u32 index,
+				 struct ethtool_loopback_entry *entry)
+{
+	return -EOPNOTSUPP;
+}
+
+static int loopback_prepare_data(const struct ethnl_req_info *req_base,
+				 struct ethnl_reply_data *reply_base,
+				 const struct genl_info *info)
+{
+	const struct loopback_req_info *req_info = LOOPBACK_REQINFO(req_base);
+	struct loopback_reply_data *data = LOOPBACK_REPDATA(reply_base);
+	struct net_device *dev = reply_base->dev;
+	int ret;
+
+	ret = ethnl_ops_begin(dev);
+	if (ret < 0)
+		return ret;
+
+	if (req_info->lookup_by_name)
+		ret = loopback_get(dev, req_info->component, req_info->id,
+				   req_info->name, &data->entry);
+	else
+		ret = loopback_get_by_index(dev, req_info->index, &data->entry);
+
+	ethnl_ops_complete(dev);
+
+	return ret;
+}
+
+static int loopback_reply_size(const struct ethnl_req_info *req_base,
+			       const struct ethnl_reply_data *reply_base)
+{
+	return nla_total_size(0) +			/* nest */
+	       nla_total_size(sizeof(u32)) +		/* component */
+	       nla_total_size(sizeof(u32)) +		/* id */
+	       nla_total_size(sizeof(u8)) +		/* supported */
+	       nla_total_size(sizeof(u8)) +		/* direction */
+	       nla_total_size(ETH_GSTRING_LEN);		/* name */
+}
+
+static int loopback_fill_reply(struct sk_buff *skb,
+			       const struct ethnl_req_info *req_base,
+			       const struct ethnl_reply_data *reply_base)
+{
+	const struct loopback_reply_data *data = LOOPBACK_REPDATA(reply_base);
+	const struct ethtool_loopback_entry *entry = &data->entry;
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
+	if (nla_put_u8(skb, ETHTOOL_A_LOOPBACK_ENTRY_SUPPORTED,
+		       entry->supported) ||
+	    nla_put_u8(skb, ETHTOOL_A_LOOPBACK_ENTRY_DIRECTION,
+		       entry->direction) ||
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
+/* SET */
+
+const struct nla_policy
+ethnl_loopback_set_policy[ETHTOOL_A_LOOPBACK_MAX + 1] = {
+	[ETHTOOL_A_LOOPBACK_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
+	[ETHTOOL_A_LOOPBACK_ENTRY] =
+		NLA_POLICY_NESTED(ethnl_loopback_entry_policy),
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
+		NL_SET_ERR_MSG_ATTR(extack, attr, "loopback name is required");
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
+	entry->direction = nla_get_u8(tb[ETHTOOL_A_LOOPBACK_ENTRY_DIRECTION]);
+
+	return 0;
+}
+
+static int __loopback_set(struct net_device *dev,
+			  const struct ethtool_loopback_entry *entry,
+			  struct netlink_ext_ack *extack)
+{
+	switch (entry->component) {
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int loopback_set(struct ethnl_req_info *req_info,
+			struct genl_info *info)
+{
+	struct net_device *dev = req_info->dev;
+	struct ethtool_loopback_entry entry;
+	int rem, ret, mod = 0;
+	struct nlattr *attr;
+	bool found = false;
+
+	nla_for_each_attr(attr, genlmsg_data(info->genlhdr),
+			  genlmsg_len(info->genlhdr), rem) {
+		if (nla_type(attr) != ETHTOOL_A_LOOPBACK_ENTRY)
+			continue;
+
+		found = true;
+		memset(&entry, 0, sizeof(entry));
+		ret = loopback_parse_entry(attr, &entry, info->extack);
+		if (ret < 0)
+			return ret;
+
+		ret = __loopback_set(dev, &entry, info->extack);
+		if (ret < 0)
+			return ret;
+		if (ret > 0)
+			mod = 1;
+	}
+
+	if (!found) {
+		NL_SET_ERR_MSG(info->extack, "no loopback entries specified");
+		return -EINVAL;
+	}
+
+	return mod;
+}
+
+static int loopback_dump_one_dev(struct sk_buff *skb,
+				 struct ethnl_dump_ctx *ctx,
+				 unsigned long *pos_sub,
+				 const struct genl_info *info)
+{
+	struct loopback_req_info *req_info =
+		container_of(ctx->req_info, struct loopback_req_info, base);
+	int ret;
+
+	for (;; (*pos_sub)++) {
+		req_info->index = *pos_sub;
+		ret = ethnl_default_dump_one(skb, ctx->req_info->dev, ctx,
+					     info);
+		if (ret == -EOPNOTSUPP)
+			break;
+		if (ret)
+			return ret;
+	}
+
+	*pos_sub = 0;
+
+	return 0;
+}
+
+const struct ethnl_request_ops ethnl_loopback_request_ops = {
+	.request_cmd		= ETHTOOL_MSG_LOOPBACK_GET,
+	.reply_cmd		= ETHTOOL_MSG_LOOPBACK_GET_REPLY,
+	.hdr_attr		= ETHTOOL_A_LOOPBACK_HEADER,
+	.req_info_size		= sizeof(struct loopback_req_info),
+	.reply_data_size	= sizeof(struct loopback_reply_data),
+
+	.parse_request		= loopback_parse_request,
+	.prepare_data		= loopback_prepare_data,
+	.reply_size		= loopback_reply_size,
+	.fill_reply		= loopback_fill_reply,
+	.dump_one_dev		= loopback_dump_one_dev,
+
+	.set			= loopback_set,
+	.set_ntf_cmd		= ETHTOOL_MSG_LOOPBACK_NTF,
+};
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index e740b11a0609..25b2fca05bd8 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -391,6 +391,8 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_TSCONFIG_SET]	= &ethnl_tsconfig_request_ops,
 	[ETHTOOL_MSG_PHY_GET]		= &ethnl_phy_request_ops,
 	[ETHTOOL_MSG_MSE_GET]		= &ethnl_mse_request_ops,
+	[ETHTOOL_MSG_LOOPBACK_GET]	= &ethnl_loopback_request_ops,
+	[ETHTOOL_MSG_LOOPBACK_SET]	= &ethnl_loopback_request_ops,
 };
 
 static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
@@ -537,8 +539,8 @@ static int ethnl_default_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
-				  const struct ethnl_dump_ctx *ctx,
+int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
+			   const struct ethnl_dump_ctx *ctx,
 				  const struct genl_info *info)
 {
 	void *ehdr;
@@ -817,6 +819,7 @@ ethnl_default_notify_ops[ETHTOOL_MSG_KERNEL_MAX + 1] = {
 	[ETHTOOL_MSG_MM_NTF]		= &ethnl_mm_request_ops,
 	[ETHTOOL_MSG_RSS_NTF]		= &ethnl_rss_request_ops,
 	[ETHTOOL_MSG_RSS_CREATE_NTF]	= &ethnl_rss_request_ops,
+	[ETHTOOL_MSG_LOOPBACK_NTF]	= &ethnl_loopback_request_ops,
 };
 
 /* default notification handler */
@@ -925,6 +928,7 @@ static const ethnl_notify_handler_t ethnl_notify_handlers[] = {
 	[ETHTOOL_MSG_MM_NTF]		= ethnl_default_notify,
 	[ETHTOOL_MSG_RSS_NTF]		= ethnl_default_notify,
 	[ETHTOOL_MSG_RSS_CREATE_NTF]	= ethnl_default_notify,
+	[ETHTOOL_MSG_LOOPBACK_NTF]	= ethnl_default_notify,
 };
 
 void ethnl_notify(struct net_device *dev, unsigned int cmd,
@@ -1399,6 +1403,22 @@ static const struct genl_ops ethtool_genl_ops[] = {
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
index aa8d51903ecc..2320760f931e 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -470,6 +470,7 @@ extern const struct ethnl_request_ops ethnl_mm_request_ops;
 extern const struct ethnl_request_ops ethnl_phy_request_ops;
 extern const struct ethnl_request_ops ethnl_tsconfig_request_ops;
 extern const struct ethnl_request_ops ethnl_mse_request_ops;
+extern const struct ethnl_request_ops ethnl_loopback_request_ops;
 
 extern const struct nla_policy ethnl_header_policy[ETHTOOL_A_HEADER_FLAGS + 1];
 extern const struct nla_policy ethnl_header_policy_stats[ETHTOOL_A_HEADER_FLAGS + 1];
@@ -526,6 +527,8 @@ extern const struct nla_policy ethnl_phy_get_policy[ETHTOOL_A_PHY_HEADER + 1];
 extern const struct nla_policy ethnl_tsconfig_get_policy[ETHTOOL_A_TSCONFIG_HEADER + 1];
 extern const struct nla_policy ethnl_tsconfig_set_policy[ETHTOOL_A_TSCONFIG_MAX + 1];
 extern const struct nla_policy ethnl_mse_get_policy[ETHTOOL_A_MSE_HEADER + 1];
+extern const struct nla_policy ethnl_loopback_get_policy[ETHTOOL_A_LOOPBACK_MAX + 1];
+extern const struct nla_policy ethnl_loopback_set_policy[ETHTOOL_A_LOOPBACK_MAX + 1];
 
 int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
 int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
@@ -541,6 +544,9 @@ int ethnl_tsinfo_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int ethnl_tsinfo_done(struct netlink_callback *cb);
 int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info);
 int ethnl_rss_delete_doit(struct sk_buff *skb, struct genl_info *info);
+int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
+			   const struct ethnl_dump_ctx *ctx,
+			   const struct genl_info *info);
 int ethnl_perphy_dump_one_dev(struct sk_buff *skb,
 			      struct ethnl_dump_ctx *ctx,
 			      unsigned long *pos_sub,
-- 
2.53.0


