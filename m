Return-Path: <linux-rdma+bounces-18878-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uANaDVrPzGlFWwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18878-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 09:55:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5BD37658C
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 09:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B24D30A0A10
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 07:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C954F3A3E85;
	Wed,  1 Apr 2026 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XmZ0vjW/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7955639936F;
	Wed,  1 Apr 2026 07:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775029551; cv=none; b=QStxo3oX22odQeZUxJUqej3TKP6nKvsheTL722f3WlV5u3PPMatXiqt7qNmdzSdVFIkWPPfy6we2vHsrFwzWqO+616JAFCCjOmvgN6/jTH+vKIBbdvDOd3Q02C3Pap5jM5FEie5Lm1R00RekRW9yu1bxeuao7CZhIjctJnQlWZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775029551; c=relaxed/simple;
	bh=+tR2lkGhY7EMKxIv9XlfDa5D+Kafii4siVw1srfeq1Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0JuGKPmSa1LGWrvJIkwGnVqqDsyermBI/0eNFSBgUIOeI/VWso4r2I8pTyny0QzwTRcKp0t8PH2JRxt4PfV8nrElkIAi47/bM+0abWaTRxyv+a7VcwucG69hlnW39hBIm0FfIjbQ+qJKe16bVMiplAVsZsVfPcMPCbo+JLvSUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XmZ0vjW/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=rUPZcZvnz7m4wObN0nRKDSPdiuPMBaSG6sDNy+wfNnY=; b=XmZ0vjW/LAOkBb5O+5LmfCk5YI
	n8C7/YEH/1OL7qrT9tmUxRH1AvhkSP1DC33BAFZa/XLf4jRDI2N3NZqjWHOn+7sUESjIM1aasCgA4
	JBIzZF6GADalqzb484AmGNw/yymN7DMeWwDe63XCJwHL4+6jeB8/s2BCmtK9Y9DjhZl2LXE2exenv
	5UNcjFFLrHczGy9tgX4x9RLKNa0chk+2fuONLjXfVSiQoITjn3ij5WJNeyhuBO28yKyWy0KYFAtDd
	34i6caZsumKmuoFkoLuH0sqvSRVFs3CPszxsTh9RD6P2LkTvTFD/fIbqcapt5G6lIiaqPKWm+nVz3
	HfXKpo5Q==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7qGN-0000000HLQQ-0Bmv;
	Wed, 01 Apr 2026 07:45:19 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7qGM-00000007xeB-26NS;
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
Subject: [PATCH 3/6] net: Guard Legacy IP entry points with CONFIG_LEGACY_IP
Date: Wed,  1 Apr 2026 08:44:17 +0100
Message-ID: <20260401074509.1897527-4-dwmw2@infradead.org>
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
	TAGGED_FROM(0.00)[bounces-18878-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 1A5BD37658C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Woodhouse <dwmw@amazon.co.uk>

Wrap the IPv4-specific registrations in inet_init() with
CONFIG_LEGACY_IP guards. When LEGACY_IP is disabled, the kernel
will not:
 - Register the AF_INET socket family
 - Register the ETH_P_IP packet handler (ip_rcv)
 - Initialize ARP, ICMP, IGMP, or IPv4 routing
 - Register IPv4 protocol handlers (TCP/UDP/ICMP over IPv4)
 - Initialize IPv4 multicast routing, proc entries, or fragmentation

The shared INET infrastructure (tcp_prot, udp_prot, tcp_init, etc.)
remains initialized for use by IPv6.

Also update INDIRECT_CALL_INET to not use ip_rcv/ip_list_rcv as
direct call targets when LEGACY_IP is disabled, avoiding a link-time
reference to functions that will eventually be compiled out.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/linux/indirect_call_wrapper.h |  4 +++-
 net/ipv4/af_inet.c                    | 20 +++++++++++++-----
 net/ipv4/devinet.c                    |  2 ++
 net/ipv4/route.c                      |  1 -
 net/ipv4/tcp_ipv4.c                   | 30 ++++++++++++++-------------
 5 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/include/linux/indirect_call_wrapper.h b/include/linux/indirect_call_wrapper.h
index dc272b514a01..25a3873da462 100644
--- a/include/linux/indirect_call_wrapper.h
+++ b/include/linux/indirect_call_wrapper.h
@@ -57,9 +57,11 @@
  * builtin, this macro simplify dealing with indirect calls with only ipv4/ipv6
  * alternatives
  */
-#if IS_BUILTIN(CONFIG_IPV6)
+#if IS_BUILTIN(CONFIG_IPV6) && IS_ENABLED(CONFIG_LEGACY_IP)
 #define INDIRECT_CALL_INET(f, f2, f1, ...) \
 	INDIRECT_CALL_2(f, f2, f1, __VA_ARGS__)
+#elif IS_BUILTIN(CONFIG_IPV6)
+#define INDIRECT_CALL_INET(f, f2, f1, ...) INDIRECT_CALL_1(f, f2, __VA_ARGS__)
 #elif IS_ENABLED(CONFIG_INET)
 #define INDIRECT_CALL_INET(f, f2, f1, ...) INDIRECT_CALL_1(f, f1, __VA_ARGS__)
 #else
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index c7731e300a44..dc358faa1647 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1922,7 +1922,15 @@ static int __init inet_init(void)
 	/*
 	 *	Tell SOCKET that we are alive...
 	 */
+	/* Initialize the socket-side protocol switch tables. */
+	for (r = &inetsw[0]; r < &inetsw[SOCK_MAX]; ++r)
+		INIT_LIST_HEAD(r);
+
+#ifdef CONFIG_XFRM
+	xfrm_init();
+#endif
 
+#ifdef CONFIG_LEGACY_IP
 	(void)sock_register(&inet_family_ops);
 
 #ifdef CONFIG_SYSCTL
@@ -1957,10 +1965,6 @@ static int __init inet_init(void)
 		pr_crit("%s: Cannot add IGMP protocol\n", __func__);
 #endif
 
-	/* Register the socket-side information for inet_create. */
-	for (r = &inetsw[0]; r < &inetsw[SOCK_MAX]; ++r)
-		INIT_LIST_HEAD(r);
-
 	for (q = inetsw_array; q < &inetsw_array[INETSW_ARRAY_LEN]; ++q)
 		inet_register_protosw(q);
 
@@ -1975,6 +1979,7 @@ static int __init inet_init(void)
 	 */
 
 	ip_init();
+#endif /* CONFIG_LEGACY_IP */
 
 	/* Initialise per-cpu ipv4 mibs */
 	if (init_ipv4_mibs())
@@ -1987,7 +1992,8 @@ static int __init inet_init(void)
 	udp_init();
 
 	/* Add UDP-Lite (RFC 3828) */
-	udplite4_register();
+	if (IS_ENABLED(CONFIG_LEGACY_IP))
+		udplite4_register();
 
 	raw_init();
 
@@ -1997,6 +2003,7 @@ static int __init inet_init(void)
 	 *	Set the ICMP layer up
 	 */
 
+#ifdef CONFIG_LEGACY_IP
 	if (icmp_init() < 0)
 		panic("Failed to create the ICMP control socket.\n");
 
@@ -2007,10 +2014,12 @@ static int __init inet_init(void)
 	if (ip_mr_init())
 		pr_crit("%s: Cannot init ipv4 mroute\n", __func__);
 #endif
+#endif /* CONFIG_LEGACY_IP */
 
 	if (init_inet_pernet_ops())
 		pr_crit("%s: Cannot init ipv4 inet pernet ops\n", __func__);
 
+#ifdef CONFIG_LEGACY_IP
 	ipv4_proc_init();
 
 	ipfrag_init();
@@ -2018,6 +2027,7 @@ static int __init inet_init(void)
 	dev_add_pack(&ip_packet_type);
 
 	ip_tunnel_core_init();
+#endif /* CONFIG_LEGACY_IP */
 
 	rc = 0;
 out:
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 537bb6c315d2..9b9db10e5db2 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -348,7 +348,9 @@ static int __init inet_blackhole_dev_init(void)
 
 	return PTR_ERR_OR_ZERO(in_dev);
 }
+#ifdef CONFIG_LEGACY_IP
 late_initcall(inet_blackhole_dev_init);
+#endif
 
 int inet_addr_onlink(struct in_device *in_dev, __be32 a, __be32 b)
 {
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 463236e0dc2d..125614f552c7 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3773,7 +3773,6 @@ int __init ip_rt_init(void)
 	if (ip_rt_proc_init())
 		pr_err("Unable to create route proc files\n");
 #ifdef CONFIG_XFRM
-	xfrm_init();
 	xfrm4_init();
 #endif
 	rtnl_register_many(ip_rt_rtnl_msg_handlers);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c7b2463c2e25..7660bd45aac7 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3717,25 +3717,27 @@ static void __init bpf_iter_register(void)
 
 void __init tcp_v4_init(void)
 {
-	int cpu, res;
+	if (IS_ENABLED(CONFIG_LEGACY_IP)) {
+		int cpu, res;
 
-	for_each_possible_cpu(cpu) {
-		struct sock *sk;
+		for_each_possible_cpu(cpu) {
+			struct sock *sk;
 
-		res = inet_ctl_sock_create(&sk, PF_INET, SOCK_RAW,
-					   IPPROTO_TCP, &init_net);
-		if (res)
-			panic("Failed to create the TCP control socket.\n");
-		sock_set_flag(sk, SOCK_USE_WRITE_QUEUE);
+			res = inet_ctl_sock_create(&sk, PF_INET, SOCK_RAW,
+						   IPPROTO_TCP, &init_net);
+			if (res)
+				panic("Failed to create the TCP control socket.\n");
+			sock_set_flag(sk, SOCK_USE_WRITE_QUEUE);
 
-		/* Please enforce IP_DF and IPID==0 for RST and
-		 * ACK sent in SYN-RECV and TIME-WAIT state.
-		 */
-		inet_sk(sk)->pmtudisc = IP_PMTUDISC_DO;
+			/* Please enforce IP_DF and IPID==0 for RST and
+			 * ACK sent in SYN-RECV and TIME-WAIT state.
+			 */
+			inet_sk(sk)->pmtudisc = IP_PMTUDISC_DO;
 
-		sk->sk_clockid = CLOCK_MONOTONIC;
+			sk->sk_clockid = CLOCK_MONOTONIC;
 
-		per_cpu(ipv4_tcp_sk.sock, cpu) = sk;
+			per_cpu(ipv4_tcp_sk.sock, cpu) = sk;
+		}
 	}
 	if (register_pernet_subsys(&tcp_sk_ops))
 		panic("Failed to create the TCP control socket.\n");
-- 
2.51.0


