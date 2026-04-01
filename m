Return-Path: <linux-rdma+bounces-18875-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HMwMXPQzGlFWwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18875-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 09:59:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D08DE37668A
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 09:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B1043063DA5
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 07:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9434392C52;
	Wed,  1 Apr 2026 07:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QnCIxoUy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9144B389470;
	Wed,  1 Apr 2026 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775029547; cv=none; b=N8P7FIWVLlONEjgcpcbUHJjvfje34QRDPoO5hLPHEeTWd9fAOYt7OrG1twCPLQ3FqbpZvEIudK6CmTM9R6DbB8OLlHLafuKu/uvEyZU8GTsPOElXYGC0+TwqjHddzZP6S8/bPxgUM6xC6+RIJ4OOuu14B4eS0wJmoMpTaRSntXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775029547; c=relaxed/simple;
	bh=fz1vVpZ+XixTWvLK2fUSSSwxU2g035/t57UleVQMxCs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dun3n6+MRi9b6AZk2qp5D5SOrbFlO6a4XIXqtoSmuKvX2GaVKdha/ZTwlypZnOGqyftnh+6Iv9NQXNxfX0l5Qj9WQvdWDj6tuEkGMnhqzIe3FMpve7oOxkE2fe3KN2ET9kgnTtDfb3zCULWoj3JV75aIaUqGnKWF1X2RDui0FJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QnCIxoUy; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description;
	bh=7U4Yiy0/CwnvZWt3C0BtwDa2Bz5Q5jm510x17jkSpQk=; b=QnCIxoUyOmPrAkseFjcccD4s1i
	JKfLE7Jom17QlfF7S1IPYullmh2F3/ktBNXwJtxAGsOTgDCOiJWXNBKrEVRZ7iSEc36uqowLb3S7S
	BV99jdHasZRiZk8U5OleuPJgXdXYle1tJH1CZy4rg4gBT9EPLs2Ahr0cAKXcgZFRfJ05SDokSHTfN
	jXPrhzGgoWmGQJy+kbKGacztvzPAG0VZY7QODBlz2dhxkauyvny4QYD1Sn93zFjoRwz7rtxIeRSFT
	/5vAOJQYyW6nfO9WESy0lFzuia8lcNbI1r3pmzzQ440e2a0h03XVEvkS4BGy8eJMOxAk8Vd/9wfQn
	N1CDYbUQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7qGN-0000000HLQR-0Bwg;
	Wed, 01 Apr 2026 07:45:19 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7qGM-00000007xeH-2STV;
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
Subject: [PATCH 4/6] net: Make IPv4-only Kconfig options depend on LEGACY_IP
Date: Wed,  1 Apr 2026 08:44:18 +0100
Message-ID: <20260401074509.1897527-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260401074509.1897527-1-dwmw2@infradead.org>
References: <20260401074509.1897527-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18875-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,blackwall.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,sipsolutions.net,netfilter.org,strlen.de,nwl.cc,amazon.co.uk,paul-moore.com,vger.kernel.org,corigine.com,lists.linux.dev,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amazon.co.uk:email]
X-Rspamd-Queue-Id: D08DE37668A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Woodhouse <dwmw@amazon.co.uk>

Add 'depends on LEGACY_IP' to Kconfig options that are purely
IPv4-specific, so they are automatically disabled when LEGACY_IP=n.

IPv4-only options gated:
 - IP_MULTICAST, IP_ADVANCED_ROUTER, IP_FIB_TRIE_STATS,
   IP_MULTIPLE_TABLES, IP_ROUTE_MULTIPATH, IP_ROUTE_VERBOSE,
   IP_ROUTE_CLASSID — IPv4 routing features
 - IP_PNP (and children DHCP/BOOTP/RARP) — IPv4 autoconfiguration
 - NET_IPIP, NET_IPGRE_DEMUX, NET_IPGRE, NET_IPGRE_BROADCAST — IPv4
   tunnels
 - IP_MROUTE_COMMON, IP_MROUTE, IP_MROUTE_MULTIPLE_TABLES,
   IP_PIMSM_V1, IP_PIMSM_V2 — IPv4 multicast routing
 - NET_IPVTI, NET_FOU_IP_TUNNELS — IPv4 VTI and FOU tunnels
 - INET_AH, INET_ESP, INET_ESP_OFFLOAD, INET_ESPINTCP,
   INET_IPCOMP — IPv4 IPsec (IPv6 has separate INET6_* options)
 - INET_XFRM_TUNNEL, INET_TUNNEL — IPv4 tunnel infrastructure

Options intentionally left ungated (shared with IPv6):
 - SYN_COOKIES, NET_IP_TUNNEL, NET_UDP_TUNNEL, NET_FOU
 - INET_TABLE_PERTURB_ORDER, INET_DIAG and children
 - TCP_CONG_*, DEFAULT_TCP_CONG, TCP_SIGPOOL, TCP_AO, TCP_MD5SIG

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 net/ipv4/Kconfig | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index aef2c5349e62..03b5ba75c3cf 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -15,6 +15,7 @@ config LEGACY_IP
 
 config IP_MULTICAST
 	bool "IP: multicasting"
+	depends on LEGACY_IP
 	help
 	  This is code for addressing several networked computers at once,
 	  enlarging your kernel by about 2 KB. You need multicasting if you
@@ -25,6 +26,7 @@ config IP_MULTICAST
 
 config IP_ADVANCED_ROUTER
 	bool "IP: advanced router"
+	depends on LEGACY_IP
 	help
 	  If you intend to run your Linux box mostly as a router, i.e. as a
 	  computer that forwards and redistributes network packets, say Y; you
@@ -66,6 +68,7 @@ config IP_ADVANCED_ROUTER
 
 config IP_FIB_TRIE_STATS
 	bool "FIB TRIE statistics"
+	depends on LEGACY_IP
 	depends on IP_ADVANCED_ROUTER
 	help
 	  Keep track of statistics on structure of FIB TRIE table.
@@ -73,6 +76,7 @@ config IP_FIB_TRIE_STATS
 
 config IP_MULTIPLE_TABLES
 	bool "IP: policy routing"
+	depends on LEGACY_IP
 	depends on IP_ADVANCED_ROUTER
 	select FIB_RULES
 	help
@@ -90,6 +94,7 @@ config IP_MULTIPLE_TABLES
 
 config IP_ROUTE_MULTIPATH
 	bool "IP: equal cost multipath"
+	depends on LEGACY_IP
 	depends on IP_ADVANCED_ROUTER
 	help
 	  Normally, the routing tables specify a single action to be taken in
@@ -102,6 +107,7 @@ config IP_ROUTE_MULTIPATH
 
 config IP_ROUTE_VERBOSE
 	bool "IP: verbose route monitoring"
+	depends on LEGACY_IP
 	depends on IP_ADVANCED_ROUTER
 	help
 	  If you say Y here, which is recommended, then the kernel will print
@@ -113,9 +119,11 @@ config IP_ROUTE_VERBOSE
 
 config IP_ROUTE_CLASSID
 	bool
+	depends on LEGACY_IP
 
 config IP_PNP
 	bool "IP: kernel level autoconfiguration"
+	depends on LEGACY_IP
 	help
 	  This enables automatic configuration of IP addresses of devices and
 	  of the routing table during kernel boot, based on either information
@@ -172,6 +180,7 @@ config IP_PNP_RARP
 
 config NET_IPIP
 	tristate "IP: tunneling"
+	depends on LEGACY_IP
 	select INET_TUNNEL
 	select NET_IP_TUNNEL
 	help
@@ -190,6 +199,7 @@ config NET_IPIP
 
 config NET_IPGRE_DEMUX
 	tristate "IP: GRE demultiplexer"
+	depends on LEGACY_IP
 	help
 	  This is helper module to demultiplex GRE packets on GRE version field criteria.
 	  Required by ip_gre and pptp modules.
@@ -202,6 +212,7 @@ config NET_IP_TUNNEL
 
 config NET_IPGRE
 	tristate "IP: GRE tunnels over IP"
+	depends on LEGACY_IP
 	depends on (IPV6 || IPV6=n) && NET_IPGRE_DEMUX
 	select NET_IP_TUNNEL
 	help
@@ -217,6 +228,7 @@ config NET_IPGRE
 
 config NET_IPGRE_BROADCAST
 	bool "IP: broadcast GRE over IP"
+	depends on LEGACY_IP
 	depends on IP_MULTICAST && NET_IPGRE
 	help
 	  One application of GRE/IP is to construct a broadcast WAN (Wide Area
@@ -226,10 +238,12 @@ config NET_IPGRE_BROADCAST
 
 config IP_MROUTE_COMMON
 	bool
+	depends on LEGACY_IP
 	depends on IP_MROUTE || IPV6_MROUTE
 
 config IP_MROUTE
 	bool "IP: multicast routing"
+	depends on LEGACY_IP
 	depends on IP_MULTICAST
 	select IP_MROUTE_COMMON
 	help
@@ -242,6 +256,7 @@ config IP_MROUTE
 
 config IP_MROUTE_MULTIPLE_TABLES
 	bool "IP: multicast policy routing"
+	depends on LEGACY_IP
 	depends on IP_MROUTE && IP_ADVANCED_ROUTER
 	select FIB_RULES
 	help
@@ -256,6 +271,7 @@ config IP_MROUTE_MULTIPLE_TABLES
 
 config IP_PIMSM_V1
 	bool "IP: PIM-SM version 1 support"
+	depends on LEGACY_IP
 	depends on IP_MROUTE
 	help
 	  Kernel side support for Sparse Mode PIM (Protocol Independent
@@ -269,6 +285,7 @@ config IP_PIMSM_V1
 
 config IP_PIMSM_V2
 	bool "IP: PIM-SM version 2 support"
+	depends on LEGACY_IP
 	depends on IP_MROUTE
 	help
 	  Kernel side support for Sparse Mode PIM version 2. In order to use
@@ -314,6 +331,7 @@ config SYN_COOKIES
 
 config NET_IPVTI
 	tristate "Virtual (secure) IP: tunneling"
+	depends on LEGACY_IP
 	depends on IPV6 || IPV6=n
 	select INET_TUNNEL
 	select NET_IP_TUNNEL
@@ -341,6 +359,7 @@ config NET_FOU
 
 config NET_FOU_IP_TUNNELS
 	bool "IP: FOU encapsulation of IP tunnels"
+	depends on LEGACY_IP
 	depends on NET_IPIP || NET_IPGRE || IPV6_SIT
 	select NET_FOU
 	help
@@ -350,6 +369,7 @@ config NET_FOU_IP_TUNNELS
 
 config INET_AH
 	tristate "IP: AH transformation"
+	depends on LEGACY_IP
 	select XFRM_AH
 	help
 	  Support for IPsec AH (Authentication Header).
@@ -365,6 +385,7 @@ config INET_AH
 
 config INET_ESP
 	tristate "IP: ESP transformation"
+	depends on LEGACY_IP
 	select XFRM_ESP
 	help
 	  Support for IPsec ESP (Encapsulating Security Payload).
@@ -380,6 +401,7 @@ config INET_ESP
 
 config INET_ESP_OFFLOAD
 	tristate "IP: ESP transformation offload"
+	depends on LEGACY_IP
 	depends on INET_ESP
 	select XFRM_OFFLOAD
 	default n
@@ -393,6 +415,7 @@ config INET_ESP_OFFLOAD
 
 config INET_ESPINTCP
 	bool "IP: ESP in TCP encapsulation (RFC 8229)"
+	depends on LEGACY_IP
 	depends on XFRM && INET_ESP
 	select STREAM_PARSER
 	select NET_SOCK_MSG
@@ -405,6 +428,7 @@ config INET_ESPINTCP
 
 config INET_IPCOMP
 	tristate "IP: IPComp transformation"
+	depends on LEGACY_IP
 	select INET_XFRM_TUNNEL
 	select XFRM_IPCOMP
 	help
@@ -425,11 +449,13 @@ config INET_TABLE_PERTURB_ORDER
 
 config INET_XFRM_TUNNEL
 	tristate
+	depends on LEGACY_IP
 	select INET_TUNNEL
 	default n
 
 config INET_TUNNEL
 	tristate
+	depends on LEGACY_IP
 	default n
 
 config INET_DIAG
-- 
2.51.0


