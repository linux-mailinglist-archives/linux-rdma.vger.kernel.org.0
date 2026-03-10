Return-Path: <linux-rdma+bounces-17858-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDzqBaT3r2mmdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17858-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:51:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EDD249B2B
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90E5C30AA06D
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 10:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA08737F8BD;
	Tue, 10 Mar 2026 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi6yjRxl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D3C3806D2;
	Tue, 10 Mar 2026 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139709; cv=none; b=sWoQ2OLKTgHWyixp1wCQhu7si+A4efiuYR/a/20L5aLlgpxhBqLIZ9z+o1LPK2S2HZ6cRU2ppMISKWIzHAEOh7ucWcaCw8CionZS1dSukLQpREVy/V4HWKg+Ztxm4V5bk+acdaWVQq0kz3jRz2buaU8FDnihIEpeeU+6QOHLsrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139709; c=relaxed/simple;
	bh=tZUWY8Nw1MN0n4NXR1N69crYXRhZXdao1EJvTD7KZiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVJCjTWxZDMze2ooyoQYMZM/eEuaM2NvvUA3iKISF7T0qnTWruyoL6a21ZWg6/MOhBiHatabJfpg+SgcFMkcywNbT0iCUk5ZoUP6y8x5eUu/fvny/dJ9kHcE6hFAJtWbQdIMPN/q6a8WwVYVlDR4AP15jrUqDdbRccmzKGLfIZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi6yjRxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB383C19423;
	Tue, 10 Mar 2026 10:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773139709;
	bh=tZUWY8Nw1MN0n4NXR1N69crYXRhZXdao1EJvTD7KZiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pi6yjRxlJtTYiSQo71zUlZ8gpz35vIuBVZiz1hMKG4YnW6A5qI5No/2ydIGbk9Qjn
	 Fx9eEXLR6GUxU7sRDaysQPaNpZP74vAJGX8JL0K32TVV02yFzJ1+ExRlH6h/oeAdFo
	 V0/FZhlkyKOF7+hvQiMUUd8sXQcv8wxoMEuDvBgbfVnvwyon6BpHLFfC8IJG6TmcR3
	 IDRP6U/+nAJjAWF+Y4qzpm3yirRbbUp3NAEKlfzEfxjh9WWdT3iRy2+q9hr4lUQv57
	 RpeWh3OEgAyKTDiqFVUpCLRHvDl2Lwll2n/LxqXWRCXbfP2m5vjEM0OZR6vE95v2Kb
	 guiJb4IRTxjWw==
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
Subject: [PATCH net-next 06/11] ethtool: Add MAC loopback support via ethtool_ops
Date: Tue, 10 Mar 2026 11:47:36 +0100
Message-ID: <20260310104743.907818-7-bjorn@kernel.org>
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
X-Rspamd-Queue-Id: C8EDD249B2B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.01 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17858-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Extend struct ethtool_ops with three loopback callbacks that drivers
can implement for MAC-level loopback control:

 - get_loopback(dev, name, id, entry): exact lookup by name and
   instance id, used by doit (single-entry GET) requests.

 - get_loopback_by_index(dev, index, entry): flat enumeration by
   index, used by dumpit (multi-entry GET) requests to iterate all
   loopback points on a device.

 - set_loopback(dev, entry, extack): apply a loopback configuration
   change. Returns 1 if hardware state changed, 0 if no-op.

Wire the MAC component into loopback.c's dispatch functions. For dump
enumeration, MAC entries are tried first via the driver's
get_loopback_by_index() op, then MODULE/CMIS entries follow at the
next index offset.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 include/linux/ethtool.h |  7 ++++++
 net/ethtool/loopback.c  | 56 ++++++++++++++++++++++++++++++++---------
 2 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index c9beca11fc40..8893e732f930 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1321,6 +1321,13 @@ struct ethtool_ops {
 	int	(*set_mm)(struct net_device *dev, struct ethtool_mm_cfg *cfg,
 			  struct netlink_ext_ack *extack);
 	void	(*get_mm_stats)(struct net_device *dev, struct ethtool_mm_stats *stats);
+	int	(*get_loopback)(struct net_device *dev, const char *name,
+				u32 id, struct ethtool_loopback_entry *entry);
+	int	(*get_loopback_by_index)(struct net_device *dev, u32 index,
+					 struct ethtool_loopback_entry *entry);
+	int	(*set_loopback)(struct net_device *dev,
+				const struct ethtool_loopback_entry *entry,
+				struct netlink_ext_ack *extack);
 };
 
 int ethtool_check_ops(const struct ethtool_ops *ops);
diff --git a/net/ethtool/loopback.c b/net/ethtool/loopback.c
index ed184f45322e..9c5834be743f 100644
--- a/net/ethtool/loopback.c
+++ b/net/ethtool/loopback.c
@@ -86,6 +86,10 @@ static int loopback_get(struct net_device *dev,
 			struct ethtool_loopback_entry *entry)
 {
 	switch (component) {
+	case ETHTOOL_LOOPBACK_COMPONENT_MAC:
+		if (!dev->ethtool_ops->get_loopback)
+			return -EOPNOTSUPP;
+		return dev->ethtool_ops->get_loopback(dev, name, id, entry);
 	case ETHTOOL_LOOPBACK_COMPONENT_MODULE:
 		return ethtool_cmis_get_loopback(dev, name, entry);
 	default:
@@ -93,10 +97,22 @@ static int loopback_get(struct net_device *dev,
 	}
 }
 
-static int loopback_get_by_index(struct net_device *dev, u32 index,
+static int loopback_get_by_index(struct net_device *dev,
+				 enum ethtool_loopback_component component,
+				 u32 index,
 				 struct ethtool_loopback_entry *entry)
 {
-	return ethtool_cmis_get_loopback_by_index(dev, index, entry);
+	switch (component) {
+	case ETHTOOL_LOOPBACK_COMPONENT_MAC:
+		if (!dev->ethtool_ops->get_loopback_by_index)
+			return -EOPNOTSUPP;
+		return dev->ethtool_ops->get_loopback_by_index(dev, index,
+							       entry);
+	case ETHTOOL_LOOPBACK_COMPONENT_MODULE:
+		return ethtool_cmis_get_loopback_by_index(dev, index, entry);
+	default:
+		return -EOPNOTSUPP;
+	}
 }
 
 static int loopback_prepare_data(const struct ethnl_req_info *req_base,
@@ -116,7 +132,8 @@ static int loopback_prepare_data(const struct ethnl_req_info *req_base,
 		ret = loopback_get(dev, req_info->component, req_info->id,
 				   req_info->name, &data->entry);
 	else
-		ret = loopback_get_by_index(dev, req_info->index, &data->entry);
+		ret = loopback_get_by_index(dev, req_info->component,
+					    req_info->index, &data->entry);
 
 	ethnl_ops_complete(dev);
 
@@ -225,6 +242,10 @@ static int __loopback_set(struct net_device *dev,
 			  struct netlink_ext_ack *extack)
 {
 	switch (entry->component) {
+	case ETHTOOL_LOOPBACK_COMPONENT_MAC:
+		if (!dev->ethtool_ops->set_loopback)
+			return -EOPNOTSUPP;
+		return dev->ethtool_ops->set_loopback(dev, entry, extack);
 	case ETHTOOL_LOOPBACK_COMPONENT_MODULE:
 		return ethtool_cmis_set_loopback(dev, entry, extack);
 	default:
@@ -274,20 +295,31 @@ static int loopback_dump_one_dev(struct sk_buff *skb,
 {
 	struct loopback_req_info *req_info =
 		container_of(ctx->req_info, struct loopback_req_info, base);
+	/* pos_sub encodes: upper 16 bits = component phase, lower 16 = index
+	 * within that component. dump_one_dev is called repeatedly with
+	 * increasing pos_sub until all components are exhausted.
+	 */
+	enum ethtool_loopback_component phase = *pos_sub >> 16;
+	u32 idx = *pos_sub & 0xffff;
 	int ret;
 
-	for (;; (*pos_sub)++) {
-		req_info->index = *pos_sub;
-		ret = ethnl_default_dump_one(skb, ctx->req_info->dev, ctx,
-					     info);
-		if (ret == -EOPNOTSUPP)
-			break;
-		if (ret)
-			return ret;
+	for (; phase <= ETHTOOL_LOOPBACK_COMPONENT_MODULE; phase++) {
+		for (;; idx++) {
+			req_info->component = phase;
+			req_info->index = idx;
+			ret = ethnl_default_dump_one(skb, ctx->req_info->dev,
+						     ctx, info);
+			if (ret == -EOPNOTSUPP)
+				break;
+			if (ret) {
+				*pos_sub = ((unsigned long)phase << 16) | idx;
+				return ret;
+			}
+		}
+		idx = 0;
 	}
 
 	*pos_sub = 0;
-
 	return 0;
 }
 
-- 
2.53.0


