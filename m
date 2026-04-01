Return-Path: <linux-rdma+bounces-18873-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N5fM5XOzGlFWwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18873-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 09:51:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E93A376488
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 09:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8F28305F9B9
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 07:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A152638E12B;
	Wed,  1 Apr 2026 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cj5jYf8L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D31438A720;
	Wed,  1 Apr 2026 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775029546; cv=none; b=gQl1QYk0f5YvfRWeCfEYtoM1Whm6q6WLlSgXZTnjduIfOXzLIk383maW8Kl/sabtXMn8NVnQd3q/fnSHK8U9XNdZEmKh5LW/QF2ycs4vJGErCOTpMqcEnHBnDEFLkxoiM+qottVCCUKZ163u0b07dvt+0kDcoMAHUS7uMzNuYqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775029546; c=relaxed/simple;
	bh=G+MOIw6te2PEYObUvRNoONaiOWjDHRklhl8RTcJVPZI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miO9NgUiIXL7xUA4YrDvuGqmEjnhgwCUngY3kdlzJ6s6x+j3TTH8t0ydSuYinVLQZaJvgCo2gsQzJOH9uJmIHUbz4LGc2+z5q+O0zK+Mkp8LtkMSCLRx6f+GCDTpCV5X75VHNxSipxDeIC9aHcpdEJRP8m/bGEkAg7j8j03rpWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cj5jYf8L; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=h+p+VmdWrOOE3XGa5ETBNDsBTi8oEa3Q6yVdlq8p0TQ=; b=Cj5jYf8LEO52SYJSteJD++g+jR
	nxIMi2FBOq6FCP5C1gDwhsPoPpYGA9vx+jXOkaIfMVFWqsqNVOKYhZSO1U91eV6SyU6l4e1vtVVt8
	CRNdM6eFadOnbCYoBPXxXZps8ykTWb6jG/w3nid2e5/e/trzQDLXJKKisSQ+1Cb8okh+eAwxsIubl
	x4tr5WC2fydMBYBVHmjEXNZuKknil+uGbfBpbvlwZKsQ39AT06qKDQMdKHmNKRld4luM6SayP4CKf
	vrpwcDhzc3qkEVGuaanf2jMapJLhWqhn0GTgfW+USWPhYLux76UlPlWzlTigUJ4z30UuWJoath5TZ
	bp9qQlUA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7qGN-0000000HLQP-0C5r;
	Wed, 01 Apr 2026 07:45:20 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7qGM-00000007xe5-1ZeE;
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
Subject: [PATCH 1/6] net: Simplify tautological CONFIG_INET/CONFIG_IPV6 guards
Date: Wed,  1 Apr 2026 08:44:15 +0100
Message-ID: <20260401074509.1897527-2-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[nvidia.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,blackwall.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,sipsolutions.net,netfilter.org,strlen.de,nwl.cc,amazon.co.uk,paul-moore.com,vger.kernel.org,corigine.com,lists.linux.dev,linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18873-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:dkim,infradead.org:mid,amazon.co.uk:email]
X-Rspamd-Queue-Id: 7E93A376488
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Woodhouse <dwmw@amazon.co.uk>

CONFIG_IPV6 depends on CONFIG_INET, so:
 - 'IS_ENABLED(CONFIG_INET) && IS_ENABLED(CONFIG_IPV6)' simplifies
   to just 'IS_ENABLED(CONFIG_IPV6)'
 - 'IS_ENABLED(CONFIG_INET) || IS_ENABLED(CONFIG_IPV6)' simplifies
   to just 'IS_ENABLED(CONFIG_INET)'

No functional change.

Signed-off-by: David Woodhouse (Kiro) <dwmw@amazon.co.uk>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c       | 6 +++---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.h       | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c | 2 +-
 drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c   | 2 +-
 net/core/filter.c                                         | 2 +-
 net/core/secure_seq.c                                     | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
index a14f216048cd..889dc1785772 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
@@ -439,7 +439,7 @@ int mlx5e_tc_tun_update_header_ipv4(struct mlx5e_priv *priv,
 	return err;
 }
 
-#if IS_ENABLED(CONFIG_INET) && IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 static int mlx5e_route_lookup_ipv6_get(struct mlx5e_priv *priv,
 				       struct net_device *dev,
 				       struct mlx5e_tc_tun_route_attr *attr)
@@ -727,7 +727,7 @@ int mlx5e_tc_tun_route_lookup(struct mlx5e_priv *priv,
 		attr.fl.fl4.daddr = esw_attr->rx_tun_attr->src_ip.v4;
 		err = mlx5e_route_lookup_ipv4_get(priv, filter_dev, &attr);
 	}
-#if IS_ENABLED(CONFIG_INET) && IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 	else if (flow_attr->tun_ip_version == 6) {
 		/* Addresses are swapped for decap */
 		attr.fl.fl6.saddr = esw_attr->rx_tun_attr->dst_ip.v6;
@@ -762,7 +762,7 @@ int mlx5e_tc_tun_route_lookup(struct mlx5e_priv *priv,
 out:
 	if (flow_attr->tun_ip_version == 4)
 		mlx5e_route_lookup_ipv4_put(&attr);
-#if IS_ENABLED(CONFIG_INET) && IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 	else if (flow_attr->tun_ip_version == 6)
 		mlx5e_route_lookup_ipv6_put(&attr);
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.h b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.h
index 6873c1201803..f3c0e2d0f388 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.h
@@ -73,7 +73,7 @@ int mlx5e_tc_tun_update_header_ipv4(struct mlx5e_priv *priv,
 				    struct net_device *mirred_dev,
 				    struct mlx5e_encap_entry *e);
 
-#if IS_ENABLED(CONFIG_INET) && IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 int mlx5e_tc_tun_create_header_ipv6(struct mlx5e_priv *priv,
 				    struct net_device *mirred_dev,
 				    struct mlx5e_encap_entry *e);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
index bfd401bee9e8..b2973e8a7df8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
@@ -104,7 +104,7 @@ int mlx5e_tc_set_attr_rx_tun(struct mlx5e_tc_flow *flow,
 		if (!tun_attr->dst_ip.v4 || !tun_attr->src_ip.v4)
 			return 0;
 	}
-#if IS_ENABLED(CONFIG_INET) && IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 	else if (ip_version == 6) {
 		int ipv6_size = MLX5_FLD_SZ_BYTES(ipv6_layout, ipv6);
 
diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
index 0cef0e2b85d0..5eb47e1a8d5e 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
@@ -814,7 +814,7 @@ void nfp_tunnel_request_route_v6(struct nfp_app *app, struct sk_buff *skb)
 	flow.daddr = payload->ipv6_addr;
 	flow.flowi6_proto = IPPROTO_UDP;
 
-#if IS_ENABLED(CONFIG_INET) && IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 	dst = ipv6_stub->ipv6_dst_lookup_flow(dev_net(netdev), NULL, &flow,
 					      NULL);
 	if (IS_ERR(dst))
diff --git a/net/core/filter.c b/net/core/filter.c
index 78b548158fb0..ad71ceefcb5e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6083,7 +6083,7 @@ static const struct bpf_func_proto bpf_skb_get_xfrm_state_proto = {
 };
 #endif
 
-#if IS_ENABLED(CONFIG_INET) || IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_INET)
 static int bpf_fib_set_fwd_params(struct bpf_fib_lookup *params, u32 mtu)
 {
 	params->h_vlan_TCI = 0;
diff --git a/net/core/secure_seq.c b/net/core/secure_seq.c
index 6a6f2cda5aae..4de049635db0 100644
--- a/net/core/secure_seq.c
+++ b/net/core/secure_seq.c
@@ -15,7 +15,7 @@
 #include <linux/siphash.h>
 #include <net/secure_seq.h>
 
-#if IS_ENABLED(CONFIG_IPV6) || IS_ENABLED(CONFIG_INET)
+#if IS_ENABLED(CONFIG_INET)
 #include <linux/in6.h>
 #include <net/tcp.h>
 
-- 
2.51.0


