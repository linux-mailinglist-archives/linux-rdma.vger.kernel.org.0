Return-Path: <linux-rdma+bounces-20809-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENYUHpJICWq+TQQAu9opvQ
	(envelope-from <linux-rdma+bounces-20809-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 06:48:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 692E855F3F1
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 06:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 105E3300D85E
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 04:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31B281724;
	Sun, 17 May 2026 04:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DThwU6ma"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB7BC8EB
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 04:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778993294; cv=none; b=RDC/7daEXAkkH+ewyxcVOrxnICyq9yEyAHXGq2qezJ4Dzw5PoCINbvm8ryNHonlESE+gLPU6Hc1GBtj1zyyimVtExXrjbUQGuNgeCoher63G38iGNbaGuVCZcxxXQ8o9SLUtG9E1psda/qgF/xgwLrwapQd3McA8E7jQfasD2sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778993294; c=relaxed/simple;
	bh=qIYfedY4BKfu2+2gyy3pdf2i2aAKSC/JDFa+vud+Zs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LBqZdMIljueaeNp7xjZ37NmII9rT66/hyk7CmAzblC9LecIZSyVicuIv2FyMq350kGOGVOSKjYb+v4HvZnjPEMxFT8GVKEU1ove4xhh1D6p3KBxuoEmnYzdHbyZcY9AVnSKXQbt+kVW1hbd2i2Sjxor3Pqv3kOTM1rheJzekNBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DThwU6ma; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778993290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zmvx5Y+0Z9dmVGKM7o1eGsZeOqDo0m1hE2g4vH+VnJc=;
	b=DThwU6mauE40kRMHpEp/ZQfFgrZkIVrgH4CgUo5gSvrMj+6WDHtsNGuV+Ht36D4S4nKeOW
	HVlvGCYxAM/D4PaESfjqKvQedQxYlDSZ/FIkvxfTNBVqW2Y9Ug8k6bUGG/A7mLbk95h65m
	rH6aksqabYtNubpBTAhjWZ3CTTwBA8I=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>,
	syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
Subject: [PATCH 1/1] RDMA/rxe: Fix Use-After-Free problem in rxe_net_del
Date: Sun, 17 May 2026 06:47:47 +0200
Message-ID: <20260517044747.475621-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 692E855F3F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20809-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,linux.dev:email,linux.dev:mid,linux.dev:dkim,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

syzbot reported a general protection fault (KASAN: null-ptr-deref) in
kernel_sock_shutdown() called during the software RoCE (rxe) link
deletion path (rxe_dellink -> rxe_net_del).

The root cause is a TOCTOU (Time-of-Check to Time-of-Use) race condition
in rxe_net_del(). Previously, the function fetched the socket pointer
via rxe_ns_pernet_sk4/6() outside the critical section, and then
acquired the lock to release it via rxe_sock_put().

In a highly concurrent teardown environment, another thread could close
and clear the pernet socket after it was fetched but before the lock
was acquired. This causes rxe_sock_put() to operate on a dangling or
already cleared socket pointer, leading to a NULL pointer dereference
when kernel_sock_shutdown() attempts to access sock->sk.

Fix this by introducing a dedicated, per-netns mutex 'release_lock'
and extending its scope. The socket pointers are now fetched, checked,
and released entirely within the same locked critical section. This
ensures the atomicity of the socket lookup and teardown sequence.

Reported-by: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d8f76778263ab65c2b21
Fixes: f1327abd6abe ("RDMA/rxe: Support RDMA link creation and destruction per net namespace")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_net.c |  4 ++++
 drivers/infiniband/sw/rxe/rxe_ns.c  | 22 ++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_ns.h  |  3 +++
 3 files changed, 29 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 50a2cb5405e2..b689ba085da4 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -655,6 +655,8 @@ void rxe_net_del(struct ib_device *dev)
 
 	net = dev_net(ndev);
 
+	rxe_ns_lock(net);
+
 	sk = rxe_ns_pernet_sk4(net);
 	if (sk)
 		rxe_sock_put(sk, rxe_ns_pernet_set_sk4, net);
@@ -663,6 +665,8 @@ void rxe_net_del(struct ib_device *dev)
 	if (sk)
 		rxe_sock_put(sk, rxe_ns_pernet_set_sk6, net);
 
+	rxe_ns_unlock(net);
+
 	dev_put(ndev);
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
index 8b9d734229b2..799a727bc1fe 100644
--- a/drivers/infiniband/sw/rxe/rxe_ns.c
+++ b/drivers/infiniband/sw/rxe/rxe_ns.c
@@ -16,6 +16,7 @@
 struct rxe_ns_sock {
 	struct sock __rcu *rxe_sk4;
 	struct sock __rcu *rxe_sk6;
+	struct mutex	release_lock;
 };
 
 /*
@@ -31,10 +32,26 @@ static int rxe_ns_init(struct net *net)
 	/* defer socket create in the namespace to the first
 	 * device create.
 	 */
+	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
 
+	mutex_init(&ns_sk->release_lock);
 	return 0;
 }
 
+void rxe_ns_lock(struct net *net)
+{
+	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
+
+	mutex_lock(&ns_sk->release_lock);
+}
+
+void rxe_ns_unlock(struct net *net)
+{
+	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
+
+	mutex_unlock(&ns_sk->release_lock);
+}
+
 static void rxe_ns_exit(struct net *net)
 {
 	/* called when the network namespace is removed
@@ -42,6 +59,7 @@ static void rxe_ns_exit(struct net *net)
 	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
 	struct sock *sk;
 
+	rxe_ns_lock(net);
 	rcu_read_lock();
 	sk = rcu_dereference(ns_sk->rxe_sk4);
 	rcu_read_unlock();
@@ -59,6 +77,10 @@ static void rxe_ns_exit(struct net *net)
 		udp_tunnel_sock_release(sk->sk_socket);
 	}
 #endif
+
+	rxe_ns_unlock(net);
+
+	mutex_destroy(&ns_sk->release_lock);
 }
 
 /*
diff --git a/drivers/infiniband/sw/rxe/rxe_ns.h b/drivers/infiniband/sw/rxe/rxe_ns.h
index 4da2709e6b71..e6cc6b5a4806 100644
--- a/drivers/infiniband/sw/rxe/rxe_ns.h
+++ b/drivers/infiniband/sw/rxe/rxe_ns.h
@@ -20,6 +20,9 @@ static inline void rxe_ns_pernet_set_sk6(struct net *net, struct sock *sk)
 }
 #endif /* IPv6 */
 
+void rxe_ns_lock(struct net *net);
+void rxe_ns_unlock(struct net *net);
+
 int rxe_namespace_init(void);
 void rxe_namespace_exit(void);
 
-- 
2.43.0


