Return-Path: <linux-rdma+bounces-18877-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEfDHf7QzGlFWwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18877-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 10:02:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 786DA3766E0
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 10:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 217EF30946E5
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 07:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8039639EF3F;
	Wed,  1 Apr 2026 07:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IKoGyQZr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA86338A2BE;
	Wed,  1 Apr 2026 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775029550; cv=none; b=Z6bHQ81uw1i/gM5bR2E1SirY/sogUn3g7X/+/vMwd5SqRZBVBM5N/stBVrmE7VFNathS3ev+HPbQmFxnK2os04IJWyBCONljQ/Pc6qBxhPYhC42SSaMcz8SWkyBoCkeH3ySdfQhGoGbfJI6M1Uih5gyzonxNwb1TyLDNXV0Ohik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775029550; c=relaxed/simple;
	bh=rXA64fn6y56PibOyI9IkFgYw3RfBJKBTSkxUiNBk0fg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFTQ22hYND0eoMexycJGRNYvoIP5I6aHr9r6TUPC1BfMOflw9pE2kMTB3w719zTuUadSPqbijlNHvbyBOw2yfcw0mIwOp5DjoYFGrzDos0tjsQN8K+S8qmBSCCVTLBIYF/g9p6yXAMJ559YrH4zOHpkGS2laf6udKbxzOa67Zyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IKoGyQZr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=pISmS11V1tQprFst6l/klCiCb/4SA1I27pPJorGm5gg=; b=IKoGyQZrkoZMy+DdfIsGPzhp0f
	KsIQdc38aM7WkyiOFbPySG9hwJzfNFlal9JXYEWJnbzwgdeh/WsfWiBQfnKxXyVWjEKC3JnIn1wCS
	XLH6oP6mkrblKJheY/uUD63e5eaEz3K5D/eByo/0O+mHJB+zeTTHvB69OKxY58EqDBJCB7a8N9Nta
	6DxzwcmeiCL8m04LDqLpPO3KNROO5rmNBrfJbFnZLPDswK9grm3HKuCAtJ3rSy2DWpH52TSGMz8ss
	gUPg2JoI4zG+A3IFRw9/IshiTVLa2XNTriAS+LQGPeDZVsm65nqSkr+qsXqvaeI8j2Vy4tlcJjAbS
	hyDMrxrA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7qGM-0000000A0NP-419U;
	Wed, 01 Apr 2026 07:45:19 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7qGM-00000007xeL-2p8k;
	Wed, 01 Apr 2026 08:45:18 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Guillaume Nault <gnault@redhat.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Kees Cook <kees@kernel.org>,
	Alexei Lazar <alazar@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Paul Moore <paul@paul-moore.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	oss-drivers@corigine.com,
	bridge@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	torvalds@linux-foundation.org,
	jon.maddog.hall@gmail.com
Subject: [PATCH 5/6] net: Change CONFIG_INET to CONFIG_LEGACY_IP for IPv4-only code
Date: Wed,  1 Apr 2026 08:44:19 +0100
Message-ID: <20260401074509.1897527-6-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260401074509.1897527-1-dwmw2@infradead.org>
References: <20260401074509.1897527-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[49];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18877-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[nvidia.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,blackwall.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,sipsolutions.net,netfilter.org,strlen.de,nwl.cc,amazon.co.uk,paul-moore.com,vger.kernel.org,corigine.com,lists.linux.dev,linux-foundation.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:query timed out];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:dkim,infradead.org:mid,amazon.co.uk:email]
X-Rspamd-Queue-Id: 786DA3766E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Woodhouse <dwmw@amazon.co.uk>

Several functions guarded by CONFIG_INET are actually IPv4-specific
and should be gated by CONFIG_LEGACY_IP instead:

 - bpf_out_neigh_v4(): BPF IPv4 neighbour output helper
 - bpf_ipv4_fib_lookup(): BPF IPv4 FIB lookup
 - case AF_INET in bpf_xdp_fib_lookup/bpf_skb_fib_lookup switch
 - br_arp_send(): bridge ARP proxy (ARP is IPv4-only)

This allows the compiler to eliminate these functions when
LEGACY_IP=n.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 net/bridge/br_arp_nd_proxy.c    |  2 +-
 net/bridge/br_private.h         |  8 ++++++++
 net/core/filter.c               | 10 +++++-----
 net/core/sock.c                 |  2 +-
 net/mac80211/main.c             | 10 +++++-----
 net/netfilter/nfnetlink_queue.c |  2 +-
 6 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 1e2b51769eec..e056fa0cd1fe 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -39,7 +39,7 @@ void br_recalculate_neigh_suppress_enabled(struct net_bridge *br)
 	br_opt_toggle(br, BROPT_NEIGH_SUPPRESS_ENABLED, neigh_suppress);
 }
 
-#if IS_ENABLED(CONFIG_INET)
+#if IS_ENABLED(CONFIG_LEGACY_IP)
 static void br_arp_send(struct net_bridge *br, struct net_bridge_port *p,
 			struct net_device *dev, __be32 dest_ip, __be32 src_ip,
 			const unsigned char *dest_hw,
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 9b55d38ea9ed..28131fa0a7c5 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -2347,8 +2347,16 @@ static inline void br_switchdev_init(struct net_bridge *br)
 
 /* br_arp_nd_proxy.c */
 void br_recalculate_neigh_suppress_enabled(struct net_bridge *br);
+#if IS_ENABLED(CONFIG_LEGACY_IP)
 void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 			      u16 vid, struct net_bridge_port *p);
+#else
+static inline void br_do_proxy_suppress_arp(struct sk_buff *skb,
+					    struct net_bridge *br,
+					    u16 vid, struct net_bridge_port *p)
+{
+}
+#endif
 void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 		       u16 vid, struct net_bridge_port *p, struct nd_msg *msg);
 struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *m);
diff --git a/net/core/filter.c b/net/core/filter.c
index ad71ceefcb5e..ef99bd9fddd6 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2310,7 +2310,7 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 }
 #endif /* CONFIG_IPV6 */
 
-#if IS_ENABLED(CONFIG_INET)
+#if IS_ENABLED(CONFIG_LEGACY_IP)
 static int bpf_out_neigh_v4(struct net *net, struct sk_buff *skb,
 			    struct net_device *dev, struct bpf_nh_params *nh)
 {
@@ -2419,7 +2419,7 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 	kfree_skb(skb);
 	return NET_XMIT_DROP;
 }
-#endif /* CONFIG_INET */
+#endif /* CONFIG_LEGACY_IP */
 
 static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *dev,
 				struct bpf_nh_params *nh)
@@ -6095,7 +6095,7 @@ static int bpf_fib_set_fwd_params(struct bpf_fib_lookup *params, u32 mtu)
 }
 #endif
 
-#if IS_ENABLED(CONFIG_INET)
+#if IS_ENABLED(CONFIG_LEGACY_IP)
 static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 			       u32 flags, bool check_mtu)
 {
@@ -6390,7 +6390,7 @@ BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 		return -EINVAL;
 
 	switch (params->family) {
-#if IS_ENABLED(CONFIG_INET)
+#if IS_ENABLED(CONFIG_LEGACY_IP)
 	case AF_INET:
 		return bpf_ipv4_fib_lookup(dev_net(ctx->rxq->dev), params,
 					   flags, true);
@@ -6431,7 +6431,7 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
 		check_mtu = true;
 
 	switch (params->family) {
-#if IS_ENABLED(CONFIG_INET)
+#if IS_ENABLED(CONFIG_LEGACY_IP)
 	case AF_INET:
 		rc = bpf_ipv4_fib_lookup(net, params, flags, check_mtu);
 		break;
diff --git a/net/core/sock.c b/net/core/sock.c
index 5976100a9d55..6b2914702a38 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -4267,7 +4267,7 @@ int sock_load_diag_module(int family, int protocol)
 				      NETLINK_SOCK_DIAG, family);
 	}
 
-#ifdef CONFIG_INET
+#ifdef CONFIG_LEGACY_IP
 	if (family == AF_INET &&
 	    protocol != IPPROTO_RAW &&
 	    protocol < MAX_INET_PROTOS &&
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 616f86b1a7e4..7c1bbbb2c5c7 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -558,7 +558,7 @@ void ieee80211_restart_hw(struct ieee80211_hw *hw)
 }
 EXPORT_SYMBOL(ieee80211_restart_hw);
 
-#ifdef CONFIG_INET
+#ifdef CONFIG_LEGACY_IP
 static int ieee80211_ifa_changed(struct notifier_block *nb,
 				 unsigned long data, void *arg)
 {
@@ -1624,7 +1624,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	wiphy_unlock(hw->wiphy);
 	rtnl_unlock();
 
-#ifdef CONFIG_INET
+#ifdef CONFIG_LEGACY_IP
 	local->ifa_notifier.notifier_call = ieee80211_ifa_changed;
 	result = register_inetaddr_notifier(&local->ifa_notifier);
 	if (result)
@@ -1642,11 +1642,11 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 
 #if IS_ENABLED(CONFIG_IPV6)
  fail_ifa6:
-#ifdef CONFIG_INET
+#ifdef CONFIG_LEGACY_IP
 	unregister_inetaddr_notifier(&local->ifa_notifier);
 #endif
 #endif
-#if defined(CONFIG_INET) || defined(CONFIG_IPV6)
+#if defined(CONFIG_LEGACY_IP) || defined(CONFIG_IPV6)
  fail_ifa:
 #endif
 	wiphy_unregister(local->hw.wiphy);
@@ -1673,7 +1673,7 @@ void ieee80211_unregister_hw(struct ieee80211_hw *hw)
 	tasklet_kill(&local->tx_pending_tasklet);
 	tasklet_kill(&local->tasklet);
 
-#ifdef CONFIG_INET
+#ifdef CONFIG_LEGACY_IP
 	unregister_inetaddr_notifier(&local->ifa_notifier);
 #endif
 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 47f7f62906e2..e453fdb2254c 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -339,7 +339,7 @@ static struct nf_hook_entries *nf_hook_entries_head(const struct net *net, u8 pf
 
 static int nf_ip_reroute(struct sk_buff *skb, const struct nf_queue_entry *entry)
 {
-#ifdef CONFIG_INET
+#ifdef CONFIG_LEGACY_IP
 	const struct ip_rt_info *rt_info = nf_queue_entry_reroute(entry);
 
 	if (entry->state.hook == NF_INET_LOCAL_OUT) {
-- 
2.51.0


