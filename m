Return-Path: <linux-rdma+bounces-13881-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9AABE18E4
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 07:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7B913513BC
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 05:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB65222582;
	Thu, 16 Oct 2025 05:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BTsw66vW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8994A2BAF9;
	Thu, 16 Oct 2025 05:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760593554; cv=none; b=USr8POonLk4mJo2ut+YT1I9XkAa9qMErM+k//vhpc+nyK2DdnpIZVwAVIW5og0cT6prcxTggkfmfVt8kYiN7W+f7N9F9HxM2Pf4AgWYpVSoKBSmsiDB0dOS8dZSTYq5/f4oPxfhmCuuVvON21htm8fc4aWj1NV5KiwFb9c397Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760593554; c=relaxed/simple;
	bh=FDR5UEn9AP3q719II4Sn5DGX9fP4beSpnOfOkbY+2zs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WitR/wL2qJf/WUpptXBrl9mJ6HGj0LlKR1IN6Nzf9Rr1fk+uh70hcQmRC9kwFjIRkt33M6fK/gCLcW726mKAhVugZdZMiXW+RkeL9v1Biff9oCCXZNtZhkoIBklhPeC4PK5pUzUdBIAIFD3+qDeT2uAtuAPaqZLEpyNdCsza974=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BTsw66vW; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760593546; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=xWjonkM19I8uAFT3mCqwD8qSNiEE5BRMUDt1qLjQAHI=;
	b=BTsw66vW0lf83PdLTU0YE0BM8LbLyhUqamSTK2jFvcOj3ktCK/7ycfwBglBS0dSxOqFJsi/NzuRPYf0hj7Mhz2PMPSD0Yg0IXYUjnmCJMsYr7n3CJvKblk/0CUcsqWqpGDr5E4t2BABJ9G/hueUcb2Asca8YqMbtC+XZ7qxcwa0=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WqJF0FS_1760593541 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Oct 2025 13:45:45 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: mjambigi@linux.ibm.com,
	wenjia@linux.ibm.com,
	wintera@linux.ibm.com,
	dust.li@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	sidraya@linux.ibm.com,
	jaka@linux.ibm.com
Subject: [PATCH net-next] net/smc: add full IPv6 support for SMC
Date: Thu, 16 Oct 2025 13:45:41 +0800
Message-ID: <20251016054541.692-1-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current SMC implementation is IPv4-centric. While it contains a
workaround for IPv4-mapped IPv6 addresses, it lacks a functional path
for native IPv6, preventing its use in modern dual-stack or IPv6-only
networks.

This patch introduces full, native IPv6 support by refactoring the
address handling mechanism to be IP-version agnostic, which is
achieved by:

- Introducing a generic `struct smc_ipaddr` to abstract IP addresses.
- Implementing an IPv6-specific route lookup function.
- Extend GID matching logic for both IPv4 and IPv6 addresses

With these changes, SMC can now discover RDMA devices and establish
connections over both native IPv4 and IPv6 networks.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c   |  35 +++++++----
 net/smc/smc_core.h |  40 ++++++++++++-
 net/smc/smc_ib.c   | 143 ++++++++++++++++++++++++++++++++++++++-------
 net/smc/smc_ib.h   |   9 +++
 net/smc/smc_llc.c  |   6 +-
 5 files changed, 193 insertions(+), 40 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 77b99e8ef35a..cbff0b29ad5b 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1132,12 +1132,9 @@ static int smc_find_proposal_devices(struct smc_sock *smc,
 
 	/* check if there is an rdma v2 device available */
 	ini->check_smcrv2 = true;
-	ini->smcrv2.saddr = smc->clcsock->sk->sk_rcv_saddr;
+
+	smc_ipaddr_from(&ini->smcrv2.saddr, smc->clcsock->sk, sk_rcv_saddr, sk_v6_rcv_saddr);
 	if (!(ini->smcr_version & SMC_V2) ||
-#if IS_ENABLED(CONFIG_IPV6)
-	    (smc->clcsock->sk->sk_family == AF_INET6 &&
-	     !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
-#endif
 	    !smc_clc_ueid_count() ||
 	    smc_find_rdma_device(smc, ini))
 		ini->smcr_version &= ~SMC_V2;
@@ -1230,11 +1227,23 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
 		memcpy(ini->smcrv2.nexthop_mac, &aclc->r0.lcl.mac, ETH_ALEN);
 		ini->smcrv2.uses_gateway = false;
 	} else {
-		if (smc_ib_find_route(net, smc->clcsock->sk->sk_rcv_saddr,
-				      smc_ib_gid_to_ipv4(aclc->r0.lcl.gid),
-				      ini->smcrv2.nexthop_mac,
-				      &ini->smcrv2.uses_gateway))
-			return SMC_CLC_DECL_NOROUTE;
+		struct smc_ipaddr peer_gid;
+
+		smc_ipaddr_from_gid(&peer_gid, aclc->r0.lcl.gid);
+		if (peer_gid.family == AF_INET) {
+			/* v4-mapped v6 address should also be treated as v4 address. */
+			if (smc_ib_find_route(net, smc->clcsock->sk->sk_rcv_saddr,
+					      peer_gid.addr,
+					      ini->smcrv2.nexthop_mac,
+					      &ini->smcrv2.uses_gateway))
+				return SMC_CLC_DECL_NOROUTE;
+		} else {
+			if (smc_ib_find_route_v6(net, &smc->clcsock->sk->sk_v6_rcv_saddr,
+						 &peer_gid.addr_v6,
+						 ini->smcrv2.nexthop_mac,
+						 &ini->smcrv2.uses_gateway))
+				return SMC_CLC_DECL_NOROUTE;
+		}
 		if (!ini->smcrv2.uses_gateway) {
 			/* mismatch: peer claims indirect, but its direct */
 			return SMC_CLC_DECL_NOINDIRECT;
@@ -2307,8 +2316,10 @@ static void smc_find_rdma_v2_device_serv(struct smc_sock *new_smc,
 	memcpy(ini->peer_mac, pclc->lcl.mac, ETH_ALEN);
 	ini->check_smcrv2 = true;
 	ini->smcrv2.clc_sk = new_smc->clcsock->sk;
-	ini->smcrv2.saddr = new_smc->clcsock->sk->sk_rcv_saddr;
-	ini->smcrv2.daddr = smc_ib_gid_to_ipv4(smc_v2_ext->roce);
+
+	smc_ipaddr_from(&ini->smcrv2.saddr, new_smc->clcsock->sk, sk_rcv_saddr, sk_v6_rcv_saddr);
+	smc_ipaddr_from_gid(&ini->smcrv2.daddr, smc_v2_ext->roce);
+
 	rc = smc_find_rdma_device(new_smc, ini);
 	if (rc) {
 		smc_find_ism_store_rc(rc, ini);
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index a5a78cbff341..5cf1624e1660 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -279,6 +279,14 @@ struct smc_llc_flow {
 	struct smc_llc_qentry *qentry;
 };
 
+struct smc_ipaddr {
+	sa_family_t family;
+	union {
+		__be32          addr;
+		struct in6_addr addr_v6;
+	};
+};
+
 struct smc_link_group {
 	struct list_head	list;
 	struct rb_root		conns_all;	/* connection tree */
@@ -359,7 +367,7 @@ struct smc_link_group {
 						/* rsn code for termination */
 			u8			nexthop_mac[ETH_ALEN];
 			u8			uses_gateway;
-			__be32			saddr;
+			struct smc_ipaddr saddr;
 						/* net namespace */
 			struct net		*net;
 			u8			max_conns;
@@ -389,9 +397,9 @@ struct smc_gidlist {
 
 struct smc_init_info_smcrv2 {
 	/* Input fields */
-	__be32			saddr;
+	struct smc_ipaddr saddr;
 	struct sock		*clc_sk;
-	__be32			daddr;
+	struct smc_ipaddr daddr;
 
 	/* Output fields when saddr is set */
 	struct smc_ib_device	*ib_dev_v2;
@@ -618,4 +626,30 @@ static inline struct smc_link_group *smc_get_lgr(struct smc_link *link)
 {
 	return link->lgr;
 }
+
+#define smc_ipaddr_from(_ipaddr, _sk, _v4_member, _v6_member)	\
+	do {							\
+		struct smc_ipaddr *__ipaddr = (_ipaddr);	\
+		struct sock *__sk = (_sk);			\
+		int __family = __sk->sk_family;			\
+		__ipaddr->family = __family;			\
+		if (__family == AF_INET)			\
+			__ipaddr->addr = __sk->_v4_member;	\
+		else						\
+			__ipaddr->addr_v6 = __sk->_v6_member;	\
+	} while (0)
+
+static inline void smc_ipaddr_from_gid(struct smc_ipaddr *ipaddr, u8 gid[SMC_GID_SIZE])
+{
+	__be32 gid_v4 = smc_ib_gid_to_ipv4(gid);
+
+	if (gid_v4 != cpu_to_be32(INADDR_NONE)) {
+		ipaddr->family = AF_INET;
+		ipaddr->addr = gid_v4;
+	} else {
+		ipaddr->family = AF_INET6;
+		ipaddr->addr_v6 = *smc_ib_gid_to_ipv6(gid);
+	}
+}
+
 #endif
diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 0052f02756eb..5e13a323ad76 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -22,6 +22,7 @@
 #include <linux/inetdevice.h>
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_cache.h>
+#include <net/ip6_route.h>
 
 #include "smc_pnet.h"
 #include "smc_ib.h"
@@ -225,48 +226,146 @@ int smc_ib_find_route(struct net *net, __be32 saddr, __be32 daddr,
 	return -ENOENT;
 }
 
-static int smc_ib_determine_gid_rcu(const struct net_device *ndev,
+int smc_ib_find_route_v6(struct net *net, struct in6_addr *saddr,
+			 struct in6_addr *daddr, u8 nexthop_mac[],
+			 u8 *uses_gateway)
+{
+	struct dst_entry *dst;
+	struct rt6_info *rt;
+	struct neighbour *neigh;
+	struct in6_addr *nexthop_addr;
+	int rc = -ENOENT;
+
+	struct flowi6 fl6 = {
+		.daddr = *daddr,
+		.saddr = *saddr,
+	};
+
+	if (ipv6_addr_any(daddr))
+		return -EINVAL;
+
+	dst = ip6_route_output(net, NULL, &fl6);
+	if (!dst || dst->error) {
+		rc = dst ? dst->error : -EINVAL;
+		goto out;
+	}
+	rt = (struct rt6_info *)dst;
+
+	if (ipv6_addr_type(&rt->rt6i_gateway) != IPV6_ADDR_ANY) {
+		*uses_gateway = 1;
+		nexthop_addr = &rt->rt6i_gateway;
+	} else {
+		*uses_gateway = 0;
+		nexthop_addr = daddr;
+	}
+
+	neigh = dst_neigh_lookup(dst, nexthop_addr);
+	if (!neigh)
+		goto out;
+
+	read_lock_bh(&neigh->lock);
+	if (neigh->nud_state & NUD_VALID) {
+		memcpy(nexthop_mac, neigh->ha, ETH_ALEN);
+		rc = 0;
+	}
+	read_unlock_bh(&neigh->lock);
+
+	neigh_release(neigh);
+out:
+	dst_release(dst);
+	return rc;
+}
+
+static bool smc_ib_match_gid_rocev2(const struct net_device *ndev,
 				    const struct ib_gid_attr *attr,
-				    u8 gid[], u8 *sgid_index,
 				    struct smc_init_info_smcrv2 *smcrv2)
 {
-	if (!smcrv2 && attr->gid_type == IB_GID_TYPE_ROCE) {
-		if (gid)
-			memcpy(gid, &attr->gid, SMC_GID_SIZE);
-		if (sgid_index)
-			*sgid_index = attr->index;
-		return 0;
-	}
-	if (smcrv2 && attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP &&
-	    smc_ib_gid_to_ipv4((u8 *)&attr->gid) != cpu_to_be32(INADDR_NONE)) {
+	struct net *net = dev_net(ndev);
+	bool subnet_match = false;
+
+	if (smc_ib_gid_to_ipv4((u8 *)&attr->gid) != cpu_to_be32(INADDR_NONE)) {
 		struct in_device *in_dev = __in_dev_get_rcu(ndev);
-		struct net *net = dev_net(ndev);
 		const struct in_ifaddr *ifa;
-		bool subnet_match = false;
 
 		if (!in_dev)
-			goto out;
+			return false;
+
+		if (smcrv2->saddr.family != AF_INET)
+			return false;
+
 		in_dev_for_each_ifa_rcu(ifa, in_dev) {
-			if (!inet_ifa_match(smcrv2->saddr, ifa))
+			if (!inet_ifa_match(smcrv2->saddr.addr, ifa))
 				continue;
 			subnet_match = true;
 			break;
 		}
+
 		if (!subnet_match)
-			goto out;
-		if (smcrv2->daddr && smc_ib_find_route(net, smcrv2->saddr,
-						       smcrv2->daddr,
-						       smcrv2->nexthop_mac,
-						       &smcrv2->uses_gateway))
-			goto out;
+			return false;
+
+		if (smcrv2->daddr.addr &&
+		    smc_ib_find_route(net, smcrv2->saddr.addr,
+				      smcrv2->daddr.addr,
+				      smcrv2->nexthop_mac,
+				      &smcrv2->uses_gateway))
+			return false;
+
+	} else if (!(ipv6_addr_type(smc_ib_gid_to_ipv6((u8 *)&attr->gid)) & IPV6_ADDR_LINKLOCAL)) {
+		struct inet6_dev *in6_dev = __in6_dev_get(ndev);
+		const struct inet6_ifaddr *if6;
+
+		if (!in6_dev)
+			return false;
+
+		if (smcrv2->saddr.family != AF_INET6)
+			return false;
+
+		list_for_each_entry_rcu(if6, &in6_dev->addr_list, if_list) {
+			if (ipv6_addr_type(&if6->addr) & IPV6_ADDR_LINKLOCAL)
+				continue;
+			if (!ipv6_prefix_equal(&if6->addr, &smcrv2->saddr.addr_v6, if6->prefix_len))
+				continue;
+			subnet_match = true;
+			break;
+		}
+
+		if (!subnet_match)
+			return false;
+
+		if ((ipv6_addr_type(&smcrv2->daddr.addr_v6) != IPV6_ADDR_ANY) &&
+		    smc_ib_find_route_v6(net, &smcrv2->saddr.addr_v6,
+					 &smcrv2->daddr.addr_v6,
+					 smcrv2->nexthop_mac,
+					 &smcrv2->uses_gateway))
+			return false;
 
+	} else {
+		return false;
+	}
+
+	return true;
+}
+
+static int smc_ib_determine_gid_rcu(const struct net_device *ndev,
+				    const struct ib_gid_attr *attr,
+				    u8 gid[], u8 *sgid_index,
+				    struct smc_init_info_smcrv2 *smcrv2)
+{
+	bool gid_match = false;
+
+	if (!smcrv2 && attr->gid_type == IB_GID_TYPE_ROCE)
+		gid_match = true;
+	else if (smcrv2 && attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP)
+		gid_match = smc_ib_match_gid_rocev2(ndev, attr, smcrv2);
+
+	if (gid_match) {
 		if (gid)
 			memcpy(gid, &attr->gid, SMC_GID_SIZE);
 		if (sgid_index)
 			*sgid_index = attr->index;
 		return 0;
 	}
-out:
+
 	return -ENODEV;
 }
 
diff --git a/net/smc/smc_ib.h b/net/smc/smc_ib.h
index ef8ac2b7546d..7cbeb7350478 100644
--- a/net/smc/smc_ib.h
+++ b/net/smc/smc_ib.h
@@ -69,6 +69,12 @@ static inline __be32 smc_ib_gid_to_ipv4(u8 gid[SMC_GID_SIZE])
 	return cpu_to_be32(INADDR_NONE);
 }
 
+static inline struct in6_addr *smc_ib_gid_to_ipv6(u8 gid[SMC_GID_SIZE])
+{
+	struct in6_addr *addr6 = (struct in6_addr *)gid;
+	return addr6;
+}
+
 static inline struct net *smc_ib_net(struct smc_ib_device *smcibdev)
 {
 	if (smcibdev && smcibdev->ibdev)
@@ -114,6 +120,9 @@ int smc_ib_determine_gid(struct smc_ib_device *smcibdev, u8 ibport,
 			 struct smc_init_info_smcrv2 *smcrv2);
 int smc_ib_find_route(struct net *net, __be32 saddr, __be32 daddr,
 		      u8 nexthop_mac[], u8 *uses_gateway);
+int smc_ib_find_route_v6(struct net *net, struct in6_addr *saddr,
+			 struct in6_addr *daddr, u8 nexthop_mac[],
+			 u8 *uses_gateway);
 bool smc_ib_is_valid_local_systemid(void);
 int smcr_nl_get_device(struct sk_buff *skb, struct netlink_callback *cb);
 #endif
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index f865c58c3aa7..f2a02611ab25 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -1055,8 +1055,9 @@ int smc_llc_cli_add_link(struct smc_link *link, struct smc_llc_qentry *qentry)
 	if (lgr->smc_version == SMC_V2) {
 		ini->check_smcrv2 = true;
 		ini->smcrv2.saddr = lgr->saddr;
-		ini->smcrv2.daddr = smc_ib_gid_to_ipv4(llc->sender_gid);
+		smc_ipaddr_from_gid(&ini->smcrv2.daddr, llc->sender_gid);
 	}
+
 	smc_pnet_find_alt_roce(lgr, ini, link->smcibdev);
 	if (!memcmp(llc->sender_gid, link->peer_gid, SMC_GID_SIZE) &&
 	    (lgr->smc_version == SMC_V2 ||
@@ -1438,8 +1439,7 @@ int smc_llc_srv_add_link(struct smc_link *link,
 		if (send_req_add_link_resp) {
 			struct smc_llc_msg_req_add_link_v2 *req_add =
 				&req_qentry->msg.req_add_link;
-
-			ini->smcrv2.daddr = smc_ib_gid_to_ipv4(req_add->gid[0]);
+			smc_ipaddr_from_gid(&ini->smcrv2.daddr, req_add->gid[0]);
 		}
 	}
 	smc_pnet_find_alt_roce(lgr, ini, link->smcibdev);
-- 
2.45.0


