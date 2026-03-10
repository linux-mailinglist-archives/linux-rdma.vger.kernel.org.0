Return-Path: <linux-rdma+bounces-17853-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKPrGOT2r2nkdAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17853-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:48:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B28249A47
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E6E23034C45
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 10:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161F037BE9B;
	Tue, 10 Mar 2026 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EutdbW2K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B71372677;
	Tue, 10 Mar 2026 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139679; cv=none; b=Cy7iQBLHA3JPfoUwnjkkM8A9ZV0wknRd8xNEqpmia0pfSJQfc8gMv63lYT0nSZyQ2DOpighEEDaTDdYLImvP9XtkV2/Ojgu/9/aotbHRJYyPwGyBbITe/KXsL5ty0dS7HN1dNweAQFXN3hwZyqENChi6N5/FWOlb84sqSp8U+kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139679; c=relaxed/simple;
	bh=JFpaISuWEqbj8p69pQPuKhfzK52I4efiD/t20Kcul/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aPEx4ERJaT/66nMP+GtzDOIQQtvhqkKLkXye6KOVaa570s1r+4hadwFyxOyZHbaNdgRlib5VuDfcaTrSZPe7b1GK/DNgQGEzSDl9XAwrBAE5yBZ1NdSpbvmDXSqEBWfTIUp7pUp4efXTa73ZT45YmcZH5K13AfLtOZv5yLpWi4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EutdbW2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8BEC19423;
	Tue, 10 Mar 2026 10:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773139679;
	bh=JFpaISuWEqbj8p69pQPuKhfzK52I4efiD/t20Kcul/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EutdbW2KA38DzfhdRau7XFMC/YW8ntYYueO1787CPAOqJXyb9ghWB7JBsQQiqbx1x
	 qW+bHiLD6+uBxHMyfGbi88BMK8FKWpSBNs9Iu+kpLj4FOTLA6GGT8TLQco302Nbrek
	 W+qEB+raghUeV4MaNT7vdFso824JWzAutfM1u+5zHgi/2EZwmVB1Y+2zqsSWHFJBTH
	 MZHaEjcy2Ja7f4+ckwvdKEZoXHwKph/kaHtIWR7aw/hq+LPcf3uLJcLjUV+5QczPkP
	 B2baEC7AAfgM/47mGCScsZUU5IqlG93h7sLF3gHajltQ2PSNzRjHmgmS2H2FTbIlGl
	 bcXuXtmzNo+jg==
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
Subject: [PATCH net-next 01/11] ethtool: Add dump_one_dev callback for per-device sub-iteration
Date: Tue, 10 Mar 2026 11:47:31 +0100
Message-ID: <20260310104743.907818-2-bjorn@kernel.org>
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
X-Rspamd-Queue-Id: 08B28249A47
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.93 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17853-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

The per-PHY specific dump functions share a lot functionality of with
the default dumpit infrastructure, but does not share the actual code.
By introducing a new sub-iterator function, the two dumpit variants
can be folded into one set of functions.

Add a new dump_one_dev callback in ethnl_request_ops. When
ops->dump_one_dev is set, ethnl_default_start() saves the target
device's ifindex for filtered dumps, and ethnl_default_dumpit()
delegates per-device iteration to the callback instead of calling
ethnl_default_dump_one() directly. No separate start/dumpit/done
functions are needed.

For the existing per-PHY commands (PSE, PLCA, PHY, MSE), the shared
ethnl_perphy_dump_one_dev helper provides the xa_for_each_start loop
over the device's PHY topology.

This prepares the ethtool infrastructure for other commands that need
similar per-device sub-iteration.

Suggested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 net/ethtool/mse.c     |   1 +
 net/ethtool/netlink.c | 261 ++++++++++--------------------------------
 net/ethtool/netlink.h |  31 +++++
 net/ethtool/phy.c     |   1 +
 net/ethtool/plca.c    |   2 +
 net/ethtool/pse-pd.c  |   1 +
 6 files changed, 94 insertions(+), 203 deletions(-)

diff --git a/net/ethtool/mse.c b/net/ethtool/mse.c
index 8cb3fc5e7be4..0f2709b4f7de 100644
--- a/net/ethtool/mse.c
+++ b/net/ethtool/mse.c
@@ -325,4 +325,5 @@ const struct ethnl_request_ops ethnl_mse_request_ops = {
 	.cleanup_data = mse_cleanup_data,
 	.reply_size = mse_reply_size,
 	.fill_reply = mse_fill_reply,
+	.dump_one_dev = ethnl_perphy_dump_one_dev,
 };
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 6e5f0f4f815a..e740b11a0609 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -345,36 +345,6 @@ int ethnl_multicast(struct sk_buff *skb, struct net_device *dev)
 
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
@@ -428,12 +398,6 @@ static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
 	return (struct ethnl_dump_ctx *)cb->ctx;
 }
 
-static struct ethnl_perphy_dump_ctx *
-ethnl_perphy_dump_context(struct netlink_callback *cb)
-{
-	return (struct ethnl_perphy_dump_ctx *)cb->ctx;
-}
-
 /**
  * ethnl_default_parse() - Parse request message
  * @req_info:    pointer to structure to put data into
@@ -616,17 +580,41 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
 				struct netlink_callback *cb)
 {
 	struct ethnl_dump_ctx *ctx = ethnl_dump_context(cb);
+	const struct genl_info *info = genl_info_dump(cb);
 	struct net *net = sock_net(skb->sk);
 	netdevice_tracker dev_tracker;
 	struct net_device *dev;
 	int ret = 0;
 
+	if (ctx->ops->dump_one_dev && ctx->ifindex) {
+		dev = netdev_get_by_index(net, ctx->ifindex, &dev_tracker,
+					  GFP_KERNEL);
+		if (!dev)
+			return -ENODEV;
+
+		ctx->req_info->dev = dev;
+		ret = ctx->ops->dump_one_dev(skb, ctx, &ctx->pos_sub, info);
+
+		if (ret < 0 && ret != -EOPNOTSUPP && likely(skb->len))
+			ret = skb->len;
+
+		netdev_put(dev, &dev_tracker);
+		return ret;
+	}
+
 	rcu_read_lock();
 	for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
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
@@ -673,10 +661,13 @@ static int ethnl_default_start(struct netlink_callback *cb)
 	if (ret < 0)
 		goto free_reply_data;
 	if (req_info->dev) {
-		/* We ignore device specification in dump requests but as the
-		 * same parser as for non-dump (doit) requests is used, it
-		 * would take reference to the device if it finds one
-		 */
+		if (ops->dump_one_dev) {
+			/* Sub-iterator dumps keep track of the dev's ifindex
+			 * so the dumpit handler can grab/release the netdev
+			 * per iteration.
+			 */
+			ctx->ifindex = req_info->dev->ifindex;
+		}
 		netdev_put(req_info->dev, &req_info->dev_tracker);
 		req_info->dev = NULL;
 	}
@@ -696,169 +687,33 @@ static int ethnl_default_start(struct netlink_callback *cb)
 	return ret;
 }
 
-/* per-PHY ->start() handler for GET requests */
-static int ethnl_perphy_start(struct netlink_callback *cb)
+/* Shared dump_one_dev for per-PHY commands (PSE, PLCA, PHY, MSE) */
+int ethnl_perphy_dump_one_dev(struct sk_buff *skb,
+			      struct ethnl_dump_ctx *ctx,
+			      unsigned long *pos_sub,
+			      const struct genl_info *info)
 {
-	struct ethnl_perphy_dump_ctx *phy_ctx = ethnl_perphy_dump_context(cb);
-	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
-	struct ethnl_dump_ctx *ctx = &phy_ctx->ethnl_ctx;
-	struct ethnl_reply_data *reply_data;
-	const struct ethnl_request_ops *ops;
-	struct ethnl_req_info *req_info;
-	struct genlmsghdr *ghdr;
-	int ret;
-
-	BUILD_BUG_ON(sizeof(*ctx) > sizeof(cb->ctx));
-
-	ghdr = nlmsg_data(cb->nlh);
-	ops = ethnl_default_requests[ghdr->cmd];
-	if (WARN_ONCE(!ops, "cmd %u has no ethnl_request_ops\n", ghdr->cmd))
-		return -EOPNOTSUPP;
-	req_info = kzalloc(ops->req_info_size, GFP_KERNEL);
-	if (!req_info)
-		return -ENOMEM;
-	reply_data = kmalloc(ops->reply_data_size, GFP_KERNEL);
-	if (!reply_data) {
-		ret = -ENOMEM;
-		goto free_req_info;
-	}
-
-	/* Unlike per-dev dump, don't ignore dev. The dump handler
-	 * will notice it and dump PHYs from given dev. We only keep track of
-	 * the dev's ifindex, .dumpit() will grab and release the netdev itself.
-	 */
-	ret = ethnl_default_parse(req_info, &info->info, ops, false);
-	if (ret < 0)
-		goto free_reply_data;
-	if (req_info->dev) {
-		phy_ctx->ifindex = req_info->dev->ifindex;
-		netdev_put(req_info->dev, &req_info->dev_tracker);
-		req_info->dev = NULL;
-	}
-
-	ctx->ops = ops;
-	ctx->req_info = req_info;
-	ctx->reply_data = reply_data;
-	ctx->pos_ifindex = 0;
-
-	return 0;
-
-free_reply_data:
-	kfree(reply_data);
-free_req_info:
-	kfree(req_info);
-
-	return ret;
-}
-
-static int ethnl_perphy_dump_one_dev(struct sk_buff *skb,
-				     struct ethnl_perphy_dump_ctx *ctx,
-				     const struct genl_info *info)
-{
-	struct ethnl_dump_ctx *ethnl_ctx = &ctx->ethnl_ctx;
-	struct net_device *dev = ethnl_ctx->req_info->dev;
+	struct net_device *dev = ctx->req_info->dev;
 	struct phy_device_node *pdn;
 	int ret;
 
 	if (!dev->link_topo)
 		return 0;
 
-	xa_for_each_start(&dev->link_topo->phys, ctx->pos_phyindex, pdn,
-			  ctx->pos_phyindex) {
-		ethnl_ctx->req_info->phy_index = ctx->pos_phyindex;
+	xa_for_each_start(&dev->link_topo->phys, *pos_sub, pdn,
+			  *pos_sub) {
+		ctx->req_info->phy_index = *pos_sub;
 
 		/* We can re-use the original dump_one as ->prepare_data in
 		 * commands use ethnl_req_get_phydev(), which gets the PHY from
 		 * the req_info->phy_index
 		 */
-		ret = ethnl_default_dump_one(skb, dev, ethnl_ctx, info);
+		ret = ethnl_default_dump_one(skb, dev, ctx, info);
 		if (ret)
 			return ret;
 	}
 
-	ctx->pos_phyindex = 0;
-
-	return 0;
-}
-
-static int ethnl_perphy_dump_all_dev(struct sk_buff *skb,
-				     struct ethnl_perphy_dump_ctx *ctx,
-				     const struct genl_info *info)
-{
-	struct ethnl_dump_ctx *ethnl_ctx = &ctx->ethnl_ctx;
-	struct net *net = sock_net(skb->sk);
-	netdevice_tracker dev_tracker;
-	struct net_device *dev;
-	int ret = 0;
-
-	rcu_read_lock();
-	for_each_netdev_dump(net, dev, ethnl_ctx->pos_ifindex) {
-		netdev_hold(dev, &dev_tracker, GFP_ATOMIC);
-		rcu_read_unlock();
-
-		/* per-PHY commands use ethnl_req_get_phydev(), which needs the
-		 * net_device in the req_info
-		 */
-		ethnl_ctx->req_info->dev = dev;
-		ret = ethnl_perphy_dump_one_dev(skb, ctx, info);
-
-		rcu_read_lock();
-		netdev_put(dev, &dev_tracker);
-		ethnl_ctx->req_info->dev = NULL;
-
-		if (ret < 0 && ret != -EOPNOTSUPP) {
-			if (likely(skb->len))
-				ret = skb->len;
-			break;
-		}
-		ret = 0;
-	}
-	rcu_read_unlock();
-
-	return ret;
-}
-
-/* per-PHY ->dumpit() handler for GET requests. */
-static int ethnl_perphy_dumpit(struct sk_buff *skb,
-			       struct netlink_callback *cb)
-{
-	struct ethnl_perphy_dump_ctx *ctx = ethnl_perphy_dump_context(cb);
-	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
-	struct ethnl_dump_ctx *ethnl_ctx = &ctx->ethnl_ctx;
-	int ret = 0;
-
-	if (ctx->ifindex) {
-		netdevice_tracker dev_tracker;
-		struct net_device *dev;
-
-		dev = netdev_get_by_index(genl_info_net(&info->info),
-					  ctx->ifindex, &dev_tracker,
-					  GFP_KERNEL);
-		if (!dev)
-			return -ENODEV;
-
-		ethnl_ctx->req_info->dev = dev;
-		ret = ethnl_perphy_dump_one_dev(skb, ctx, genl_info_dump(cb));
-
-		if (ret < 0 && ret != -EOPNOTSUPP && likely(skb->len))
-			ret = skb->len;
-
-		netdev_put(dev, &dev_tracker);
-	} else {
-		ret = ethnl_perphy_dump_all_dev(skb, ctx, genl_info_dump(cb));
-	}
-
-	return ret;
-}
-
-/* per-PHY ->done() handler for GET requests */
-static int ethnl_perphy_done(struct netlink_callback *cb)
-{
-	struct ethnl_perphy_dump_ctx *ctx = ethnl_perphy_dump_context(cb);
-	struct ethnl_dump_ctx *ethnl_ctx = &ctx->ethnl_ctx;
-
-	kfree(ethnl_ctx->reply_data);
-	kfree(ethnl_ctx->req_info);
+	*pos_sub = 0;
 
 	return 0;
 }
@@ -1420,9 +1275,9 @@ static const struct genl_ops ethtool_genl_ops[] = {
 	{
 		.cmd	= ETHTOOL_MSG_PSE_GET,
 		.doit	= ethnl_default_doit,
-		.start	= ethnl_perphy_start,
-		.dumpit	= ethnl_perphy_dumpit,
-		.done	= ethnl_perphy_done,
+		.start	= ethnl_default_start,
+		.dumpit	= ethnl_default_dumpit,
+		.done	= ethnl_default_done,
 		.policy = ethnl_pse_get_policy,
 		.maxattr = ARRAY_SIZE(ethnl_pse_get_policy) - 1,
 	},
@@ -1444,9 +1299,9 @@ static const struct genl_ops ethtool_genl_ops[] = {
 	{
 		.cmd	= ETHTOOL_MSG_PLCA_GET_CFG,
 		.doit	= ethnl_default_doit,
-		.start	= ethnl_perphy_start,
-		.dumpit	= ethnl_perphy_dumpit,
-		.done	= ethnl_perphy_done,
+		.start	= ethnl_default_start,
+		.dumpit	= ethnl_default_dumpit,
+		.done	= ethnl_default_done,
 		.policy = ethnl_plca_get_cfg_policy,
 		.maxattr = ARRAY_SIZE(ethnl_plca_get_cfg_policy) - 1,
 	},
@@ -1460,9 +1315,9 @@ static const struct genl_ops ethtool_genl_ops[] = {
 	{
 		.cmd	= ETHTOOL_MSG_PLCA_GET_STATUS,
 		.doit	= ethnl_default_doit,
-		.start	= ethnl_perphy_start,
-		.dumpit	= ethnl_perphy_dumpit,
-		.done	= ethnl_perphy_done,
+		.start	= ethnl_default_start,
+		.dumpit	= ethnl_default_dumpit,
+		.done	= ethnl_default_done,
 		.policy = ethnl_plca_get_status_policy,
 		.maxattr = ARRAY_SIZE(ethnl_plca_get_status_policy) - 1,
 	},
@@ -1492,9 +1347,9 @@ static const struct genl_ops ethtool_genl_ops[] = {
 	{
 		.cmd	= ETHTOOL_MSG_PHY_GET,
 		.doit	= ethnl_default_doit,
-		.start	= ethnl_perphy_start,
-		.dumpit	= ethnl_perphy_dumpit,
-		.done	= ethnl_perphy_done,
+		.start	= ethnl_default_start,
+		.dumpit	= ethnl_default_dumpit,
+		.done	= ethnl_default_done,
 		.policy = ethnl_phy_get_policy,
 		.maxattr = ARRAY_SIZE(ethnl_phy_get_policy) - 1,
 	},
@@ -1538,9 +1393,9 @@ static const struct genl_ops ethtool_genl_ops[] = {
 	{
 		.cmd	= ETHTOOL_MSG_MSE_GET,
 		.doit	= ethnl_default_doit,
-		.start	= ethnl_perphy_start,
-		.dumpit	= ethnl_perphy_dumpit,
-		.done	= ethnl_perphy_done,
+		.start	= ethnl_default_start,
+		.dumpit	= ethnl_default_dumpit,
+		.done	= ethnl_default_done,
 		.policy = ethnl_mse_get_policy,
 		.maxattr = ARRAY_SIZE(ethnl_mse_get_policy) - 1,
 	},
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 89010eaa67df..aa8d51903ecc 100644
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
@@ -408,6 +430,11 @@ struct ethnl_request_ops {
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
@@ -514,6 +541,10 @@ int ethnl_tsinfo_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int ethnl_tsinfo_done(struct netlink_callback *cb);
 int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info);
 int ethnl_rss_delete_doit(struct sk_buff *skb, struct genl_info *info);
+int ethnl_perphy_dump_one_dev(struct sk_buff *skb,
+			      struct ethnl_dump_ctx *ctx,
+			      unsigned long *pos_sub,
+			      const struct genl_info *info);
 
 extern const char stats_std_names[__ETHTOOL_STATS_CNT][ETH_GSTRING_LEN];
 extern const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING_LEN];
diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index 68372bef4b2f..4158c2abb235 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -162,4 +162,5 @@ const struct ethnl_request_ops ethnl_phy_request_ops = {
 	.reply_size		= phy_reply_size,
 	.fill_reply		= phy_fill_reply,
 	.cleanup_data		= phy_cleanup_data,
+	.dump_one_dev		= ethnl_perphy_dump_one_dev,
 };
diff --git a/net/ethtool/plca.c b/net/ethtool/plca.c
index e1f7820a6158..cad0ba476c29 100644
--- a/net/ethtool/plca.c
+++ b/net/ethtool/plca.c
@@ -188,6 +188,7 @@ const struct ethnl_request_ops ethnl_plca_cfg_request_ops = {
 	.prepare_data		= plca_get_cfg_prepare_data,
 	.reply_size		= plca_get_cfg_reply_size,
 	.fill_reply		= plca_get_cfg_fill_reply,
+	.dump_one_dev		= ethnl_perphy_dump_one_dev,
 
 	.set			= ethnl_set_plca,
 	.set_ntf_cmd		= ETHTOOL_MSG_PLCA_NTF,
@@ -268,4 +269,5 @@ const struct ethnl_request_ops ethnl_plca_status_request_ops = {
 	.prepare_data		= plca_get_status_prepare_data,
 	.reply_size		= plca_get_status_reply_size,
 	.fill_reply		= plca_get_status_fill_reply,
+	.dump_one_dev		= ethnl_perphy_dump_one_dev,
 };
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 24def9c9dd54..1442a59e033f 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -337,6 +337,7 @@ const struct ethnl_request_ops ethnl_pse_request_ops = {
 	.reply_size		= pse_reply_size,
 	.fill_reply		= pse_fill_reply,
 	.cleanup_data		= pse_cleanup_data,
+	.dump_one_dev		= ethnl_perphy_dump_one_dev,
 
 	.set			= ethnl_set_pse,
 	/* PSE has no notification */
-- 
2.53.0


