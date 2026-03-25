Return-Path: <linux-rdma+bounces-18606-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9TMXNrgCxGnOvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18606-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:43:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78788328492
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FF1730DF155
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 14:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742523F0A80;
	Wed, 25 Mar 2026 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWxJzbjX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C0D3EFD3C;
	Wed, 25 Mar 2026 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450240; cv=none; b=YlG1fljkpk/WYOwnSwGFeOKvIl15FqlEfv5JBaWeWFDHwZ/IhWhu9jnnL0GLM0OKu6jn28S9EBMIU5sLoCZEWuazPyaIlRJxW+8Yl5pI5WhNKAVtMW95fq0vK4cpzPOInDnXbcjbk/GsVSAT/knDm40BDgW64YS0CFQWZbdMvF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450240; c=relaxed/simple;
	bh=693q/ml4DUoAQS2m/JLanu/ptMAZIj79VT4N0lYr0ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YCwS8Pvf3RQFnhvK47ZRumvQldSKK+P9PwhRw8s1fzNoNbfHipfuX3wc51b9xifue6Tb9kR3lKE0QcaKkUn3bRmMngTIxOd67AC2pettNZiFKNTBlKO5a/7aeKQEVOFB8r0Rl7dAiTDzKqxbYscN8zJni9Qz2z46iaC6YiPWfWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWxJzbjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DFFC116C6;
	Wed, 25 Mar 2026 14:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774450239;
	bh=693q/ml4DUoAQS2m/JLanu/ptMAZIj79VT4N0lYr0ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iWxJzbjXi4z/Tr21a2UutMFGgfZRLsqDdk9UJDQ9efLUbe5eMJgUbRv1klLp2+5zN
	 ewr0tOm+638f8jfX1BOM8cyMknBRWkd3SwtZBeb+Eu1ZNPaudBdBozlSimzW+4VL9z
	 CyHA6iX6irvq5B9b52kj9HTpO9x/d0mKVa0oSkpdVsa12yUglW5XombgF9r2JKtPsS
	 W8GMQJGdwMvB1+nddN6ex/CaLeIIOOrCHVGc0gfj9o28KNLTqqI+bxh6zbC+RSAV6Z
	 STHHehKuSySmOA4Ti9eCQimDCDD3mByK6rqdU+gcUljwMd2RMsbaMOlal/cQLlWO+f
	 Fs9thbT9AkaAQ==
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
Subject: [PATCH net-next v2 01/12] ethtool: Add dump_one_dev callback for per-device sub-iteration
Date: Wed, 25 Mar 2026 15:50:08 +0100
Message-ID: <20260325145022.2607545-2-bjorn@kernel.org>
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
X-Spamd-Result: default: False [0.90 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18606-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78788328492
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the dump_one_dev callback to ethnl_request_ops, allowing commands
to provide custom per-device dump logic with sub-positioning. Extend
ethnl_dump_ctx with ifindex and pos_sub fields.

No functional change; no command uses dump_one_dev yet.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 net/ethtool/netlink.c | 66 ++++++++++++++++++-------------------------
 net/ethtool/netlink.h | 31 ++++++++++++++++++++
 2 files changed, 58 insertions(+), 39 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 5046023a30b1..8d161f0882d0 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -346,36 +346,6 @@ int ethnl_multicast(struct sk_buff *skb, struct net_device *dev)
 
 /* GET request helpers */
 
-/**
- * struct ethnl_dump_ctx - context structure for generic dumpit() callback
- * @ops:        request ops of currently processed message type
- * @req_info:   parsed request header of processed request
- * @reply_data: data needed to compose the reply
- * @pos_ifindex: saved iteration position - ifindex
- *
- * These parameters are kept in struct netlink_callback as context preserved
- * between iterations. They are initialized by ethnl_default_start() and used
- * in ethnl_default_dumpit() and ethnl_default_done().
- */
-struct ethnl_dump_ctx {
-	const struct ethnl_request_ops	*ops;
-	struct ethnl_req_info		*req_info;
-	struct ethnl_reply_data		*reply_data;
-	unsigned long			pos_ifindex;
-};
-
-/**
- * struct ethnl_perphy_dump_ctx - context for dumpit() PHY-aware callbacks
- * @ethnl_ctx: generic ethnl context
- * @ifindex: For Filtered DUMP requests, the ifindex of the targeted netdev
- * @pos_phyindex: iterator position for multi-msg DUMP
- */
-struct ethnl_perphy_dump_ctx {
-	struct ethnl_dump_ctx	ethnl_ctx;
-	unsigned int		ifindex;
-	unsigned long		pos_phyindex;
-};
-
 static const struct ethnl_request_ops *
 ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_STRSET_GET]	= &ethnl_strset_request_ops,
@@ -618,6 +588,7 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
 				struct netlink_callback *cb)
 {
 	struct ethnl_dump_ctx *ctx = ethnl_dump_context(cb);
+	const struct genl_info *info = genl_info_dump(cb);
 	struct net *net = sock_net(skb->sk);
 	netdevice_tracker dev_tracker;
 	struct net_device *dev;
@@ -625,10 +596,20 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
 
 	rcu_read_lock();
 	for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
+		if (ctx->ifindex && ctx->ifindex != ctx->pos_ifindex)
+			break;
+
 		netdev_hold(dev, &dev_tracker, GFP_ATOMIC);
 		rcu_read_unlock();
 
-		ret = ethnl_default_dump_one(skb, dev, ctx, genl_info_dump(cb));
+		if (ctx->ops->dump_one_dev) {
+			ctx->req_info->dev = dev;
+			ret = ctx->ops->dump_one_dev(skb, ctx, &ctx->pos_sub,
+						     info);
+			ctx->req_info->dev = NULL;
+		} else {
+			ret = ethnl_default_dump_one(skb, dev, ctx, info);
+		}
 
 		rcu_read_lock();
 		netdev_put(dev, &dev_tracker);
@@ -674,19 +655,26 @@ static int ethnl_default_start(struct netlink_callback *cb)
 	ret = ethnl_default_parse(req_info, &info->info, ops, false);
 	if (ret < 0)
 		goto free_reply_data;
-	if (req_info->dev) {
-		/* We ignore device specification in dump requests but as the
-		 * same parser as for non-dump (doit) requests is used, it
-		 * would take reference to the device if it finds one
-		 */
-		netdev_put(req_info->dev, &req_info->dev_tracker);
-		req_info->dev = NULL;
-	}
 
 	ctx->ops = ops;
 	ctx->req_info = req_info;
 	ctx->reply_data = reply_data;
 	ctx->pos_ifindex = 0;
+	ctx->ifindex = 0;
+	ctx->pos_sub = 0;
+
+	if (req_info->dev) {
+		if (ops->dump_one_dev) {
+			/* Sub-iterator dumps keep track of the dev's ifindex
+			 * so the dumpit handler can grab/release the netdev
+			 * per iteration.
+			 */
+			ctx->ifindex = req_info->dev->ifindex;
+			ctx->pos_ifindex = ctx->ifindex;
+		}
+		netdev_put(req_info->dev, &req_info->dev_tracker);
+		req_info->dev = NULL;
+	}
 
 	return 0;
 
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index aaf6f2468768..e01adc5db02f 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -10,6 +10,28 @@
 
 struct ethnl_req_info;
 
+/**
+ * struct ethnl_dump_ctx - context structure for generic dumpit() callback
+ * @ops:        request ops of currently processed message type
+ * @req_info:   parsed request header of processed request
+ * @reply_data: data needed to compose the reply
+ * @pos_ifindex: saved iteration position - ifindex
+ * @ifindex:    for filtered dump requests, the ifindex of the targeted netdev
+ * @pos_sub:    iterator position for per-device iteration
+ *
+ * These parameters are kept in struct netlink_callback as context preserved
+ * between iterations. They are initialized by ethnl_default_start() and used
+ * in ethnl_default_dumpit() and ethnl_default_done().
+ */
+struct ethnl_dump_ctx {
+	const struct ethnl_request_ops	*ops;
+	struct ethnl_req_info		*req_info;
+	struct ethnl_reply_data		*reply_data;
+	unsigned long			pos_ifindex;
+	unsigned int			ifindex;
+	unsigned long			pos_sub;
+};
+
 u32 ethnl_bcast_seq_next(void);
 int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
 			       const struct nlattr *nest, struct net *net,
@@ -365,6 +387,10 @@ int ethnl_sock_priv_set(struct sk_buff *skb, struct net_device *dev, u32 portid,
  *	used e.g. to free any additional data structures outside the main
  *	structure which were allocated by ->prepare_data(). When processing
  *	dump requests, ->cleanup() is called for each message.
+ * @dump_one_dev:
+ *	Optional callback for dumping data for a single device. When set,
+ *	overrides the default dump behavior for GET requests, allowing
+ *	per-device iteration with sub-positioning via @pos_sub.
  * @set_validate:
  *	Check if set operation is supported for a given device, and perform
  *	extra input checks. Expected return values:
@@ -409,6 +435,11 @@ struct ethnl_request_ops {
 			  const struct ethnl_reply_data *reply_data);
 	void (*cleanup_data)(struct ethnl_reply_data *reply_data);
 
+	int (*dump_one_dev)(struct sk_buff *skb,
+			    struct ethnl_dump_ctx *ctx,
+			    unsigned long *pos_sub,
+			    const struct genl_info *info);
+
 	int (*set_validate)(struct ethnl_req_info *req_info,
 			    struct genl_info *info);
 	int (*set)(struct ethnl_req_info *req_info,
-- 
2.53.0


