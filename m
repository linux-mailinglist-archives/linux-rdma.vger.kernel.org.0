Return-Path: <linux-rdma+bounces-17939-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eABgJ9ULsWl1qAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17939-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 07:29:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E59B25CD81
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 07:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 669A2318CC30
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 06:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D632336C0D6;
	Wed, 11 Mar 2026 06:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LU264/iV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261F436921E
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773210572; cv=none; b=TQ9zxoS97VPt5eRx1A/X1XDEK3I/cVcy2RXtwrltjk4MPL3o25r2XdtVCMMsSomjbtgVSWw79TApdJJKkx7nZKb3V0j+JcFaAfjCeoHLWVil0oq/pEOWFkHYfOd5nCFV/amkjOyjSFlv94G3cwMuSneL5TgTGzhyfyPvDmGAfPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773210572; c=relaxed/simple;
	bh=wb/UZ5gaW0AZcxDwXM2vg3BeqCKmeHpowJ9XgdxY7GM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIlGMqfkgiyDPO5VO/pvdZhQZDct+wd4hehhCsfUwegiCe8Wxa8wHbLDlEX3wpBekECNY0kvLt+EyIrQykVTyRwuEwvQ8FTcobS519OCLPeqFJa3NN+gl7qLvhXkdgkQ3FNIyloA0J8DuwjMg3zsQ6cWeOkh5rezsdYnfVqaO7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LU264/iV; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773210569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nRUqNBQ59GzzUGEsTBHDoGYQCBUxEHe+Ln56YW4rpfI=;
	b=LU264/iVf58uzz+Q05HCIEqwMuXqRRDU8OPeWFS934krF+8pxPqAIMS4loaWryXND02cEA
	NScksy4yjUf/YGwQJ9ooD/rfSwB6+X5I126aNKi460LtFJtqFOUjA0vYSXFFXGea5ZNEic
	B5IvihovtlGGKSE+21LiNWRjgyMWZBE=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: jgg@ziepe.ca,
	leon@kernel.org,
	zyjzyj2000@gmail.com,
	yanjun.zhu@linux.dev,
	dsahern@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v6 2/4] RDMA/rxe: Add net namespace support for IPv4/IPv6 sockets
Date: Tue, 10 Mar 2026 23:29:04 -0700
Message-ID: <20260311062906.1470-3-yanjun.zhu@linux.dev>
In-Reply-To: <20260311062906.1470-1-yanjun.zhu@linux.dev>
References: <20260311062906.1470-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 0E59B25CD81
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,gmail.com,linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17939-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add a net namespace implementation file to rxe to manage the
lifecycle of IPv4 and IPv6 sockets per network namespace.

This implementation handles the creation and destruction of the
sockets both for init_net and for dynamically created network
namespaces. The sockets are initialized when a namespace becomes
active and are properly released when the namespace is removed.

This change provides the infrastructure needed for rxe to operate
correctly in environments using multiple network namespaces.

Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/Makefile |   3 +-
 drivers/infiniband/sw/rxe/rxe_ns.c | 124 +++++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_ns.h |  26 ++++++
 3 files changed, 152 insertions(+), 1 deletion(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_ns.c
 create mode 100644 drivers/infiniband/sw/rxe/rxe_ns.h

diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
index 93134f1d1d0c..3977f4f13258 100644
--- a/drivers/infiniband/sw/rxe/Makefile
+++ b/drivers/infiniband/sw/rxe/Makefile
@@ -22,6 +22,7 @@ rdma_rxe-y := \
 	rxe_mcast.o \
 	rxe_task.o \
 	rxe_net.o \
-	rxe_hw_counters.o
+	rxe_hw_counters.o \
+	rxe_ns.o
 
 rdma_rxe-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += rxe_odp.o
diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
new file mode 100644
index 000000000000..8b9d734229b2
--- /dev/null
+++ b/drivers/infiniband/sw/rxe/rxe_ns.c
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+
+#include <net/sock.h>
+#include <net/netns/generic.h>
+#include <net/net_namespace.h>
+#include <linux/module.h>
+#include <linux/skbuff.h>
+#include <linux/pid_namespace.h>
+#include <net/udp_tunnel.h>
+
+#include "rxe_ns.h"
+
+/*
+ * Per network namespace data
+ */
+struct rxe_ns_sock {
+	struct sock __rcu *rxe_sk4;
+	struct sock __rcu *rxe_sk6;
+};
+
+/*
+ * Index to store custom data for each network namespace.
+ */
+static unsigned int rxe_pernet_id;
+
+/*
+ * Called for every existing and added network namespaces
+ */
+static int rxe_ns_init(struct net *net)
+{
+	/* defer socket create in the namespace to the first
+	 * device create.
+	 */
+
+	return 0;
+}
+
+static void rxe_ns_exit(struct net *net)
+{
+	/* called when the network namespace is removed
+	 */
+	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
+	struct sock *sk;
+
+	rcu_read_lock();
+	sk = rcu_dereference(ns_sk->rxe_sk4);
+	rcu_read_unlock();
+	if (sk) {
+		rcu_assign_pointer(ns_sk->rxe_sk4, NULL);
+		udp_tunnel_sock_release(sk->sk_socket);
+	}
+
+#if IS_ENABLED(CONFIG_IPV6)
+	rcu_read_lock();
+	sk = rcu_dereference(ns_sk->rxe_sk6);
+	rcu_read_unlock();
+	if (sk) {
+		rcu_assign_pointer(ns_sk->rxe_sk6, NULL);
+		udp_tunnel_sock_release(sk->sk_socket);
+	}
+#endif
+}
+
+/*
+ * callback to make the module network namespace aware
+ */
+static struct pernet_operations rxe_net_ops = {
+	.init = rxe_ns_init,
+	.exit = rxe_ns_exit,
+	.id = &rxe_pernet_id,
+	.size = sizeof(struct rxe_ns_sock),
+};
+
+struct sock *rxe_ns_pernet_sk4(struct net *net)
+{
+	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
+	struct sock *sk;
+
+	rcu_read_lock();
+	sk = rcu_dereference(ns_sk->rxe_sk4);
+	rcu_read_unlock();
+
+	return sk;
+}
+
+void rxe_ns_pernet_set_sk4(struct net *net, struct sock *sk)
+{
+	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
+
+	rcu_assign_pointer(ns_sk->rxe_sk4, sk);
+	synchronize_rcu();
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+struct sock *rxe_ns_pernet_sk6(struct net *net)
+{
+	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
+	struct sock *sk;
+
+	rcu_read_lock();
+	sk = rcu_dereference(ns_sk->rxe_sk6);
+	rcu_read_unlock();
+
+	return sk;
+}
+
+void rxe_ns_pernet_set_sk6(struct net *net, struct sock *sk)
+{
+	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
+
+	rcu_assign_pointer(ns_sk->rxe_sk6, sk);
+	synchronize_rcu();
+}
+#endif /* IPV6 */
+
+int rxe_namespace_init(void)
+{
+	return register_pernet_subsys(&rxe_net_ops);
+}
+
+void rxe_namespace_exit(void)
+{
+	unregister_pernet_subsys(&rxe_net_ops);
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_ns.h b/drivers/infiniband/sw/rxe/rxe_ns.h
new file mode 100644
index 000000000000..4da2709e6b71
--- /dev/null
+++ b/drivers/infiniband/sw/rxe/rxe_ns.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+
+#ifndef RXE_NS_H
+#define RXE_NS_H
+
+struct sock *rxe_ns_pernet_sk4(struct net *net);
+void rxe_ns_pernet_set_sk4(struct net *net, struct sock *sk);
+
+#if IS_ENABLED(CONFIG_IPV6)
+void rxe_ns_pernet_set_sk6(struct net *net, struct sock *sk);
+struct sock *rxe_ns_pernet_sk6(struct net *net);
+#else /* IPv6 */
+static inline struct sock *rxe_ns_pernet_sk6(struct net *net)
+{
+	return NULL;
+}
+
+static inline void rxe_ns_pernet_set_sk6(struct net *net, struct sock *sk)
+{
+}
+#endif /* IPv6 */
+
+int rxe_namespace_init(void);
+void rxe_namespace_exit(void);
+
+#endif /* RXE_NS_H */
-- 
2.52.0


