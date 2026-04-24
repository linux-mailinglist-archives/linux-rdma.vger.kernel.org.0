Return-Path: <linux-rdma+bounces-19521-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yM3bLszJ6mmtDgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19521-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 03:39:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4FE458CEB
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 03:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1328C30055C3
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 01:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D6425783A;
	Fri, 24 Apr 2026 01:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bDzX9Adq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681F926059D
	for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2026 01:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776994686; cv=none; b=cv9NhNq38POGB1QINo2omVnCDD5DJN4X8AiAxA3pAqLNc6n3mEFL0gCWFRATHvutzzmrXqi1qWFCDBLmMQpOenvwe5z8udzyWl1QKNwoaB+WfAAqYv1y6Jop+TvRYkGCrMnP3UkTu1EeEM/UrcHrCcndfYjVMEhYMnmUtcBCUhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776994686; c=relaxed/simple;
	bh=gJRoEkg+6kyNGwOnbBHb4elhc7YZNKQoTaVq1UD18V0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uue0xkdkX+K82QNO8zJwA/6MI2n5OVdCxhFx1oIlqojTsn4d6FX1XXXj5rrTjN06R5Db4k1JV244jrIHDwfq4RN4y4W38nhovmwus/ajFxYZn5gRq5yPJsCuF78YquH/xJMB4JTnmMHZKS8aX43F9VOVkdj5QkRddyReiNO9Phc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bDzX9Adq; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f6a5b4f88so10002131b3a.2
        for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2026 18:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776994682; x=1777599482; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8795Js0qQtEO+aBhI9Gt5SPyV8ihb8AQ/H7V7MID18k=;
        b=bDzX9AdqbhdM+tYx+UaqnzJryRZJm9KtLDscNC6cmTDhJPV29PEFMcomj6TOflnN1S
         X8Yk+jbUknndumZ9B5IfMyC8NrH8Dealy81N+KMN8r6vQfZIzzzQNzeImbCpFUuF9Kci
         uhOnQzXBsIiSgKvfkAGMi44WPVzTC3xO4pYoxeNZ3GyIZvloOAQHwNH2Pvo76lNLXjSh
         utfTsQ/H3yuYSdpjWw7tYNS5bFmiWSNoLTE9y8ZygFXnYzJYLUUtmU5ANgVcPO1g7qBm
         n4KMO9dS4wAXl2vaIGT+SeWqNd2QkZ9JJ5DhvnAlX+W4YAylNVT/Lx3HHLn04qXjmtju
         XpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776994682; x=1777599482;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8795Js0qQtEO+aBhI9Gt5SPyV8ihb8AQ/H7V7MID18k=;
        b=Dg4HTXEwDCxi4PImzTgvkBYbZzr5xQPfviLEzzETEU6Jny29eWuhvL9Yhqa9vFDEYj
         uEI7qTO/f1bw+JMScbFdZnlnxWAtSxe+WHGh45sSBqJhF6YsEjXAsQenNYepj7G3dC84
         6D6Q1uhRyQclV3t2JRq3pAxbqejDPdqhj1wFlHGUmDUGjz42ZFOq7sbJTt5KA3LGKUo8
         Jtc2TyVzGERBNkPZwZuTrodwZsQkrGpbTkwIzHU19vhL5cEOYH/GAspmVynOhGXQhuL8
         mD7U9LMWqLbyonUSx8tjNaBn+2jUwDHLh+P7cYHp1STCt3R+k2Zmo+BckrUb2fDCwCgd
         k2+w==
X-Forwarded-Encrypted: i=1; AFNElJ8Mnn2Opvd7gAEM9oOgz8CZfyf5wAZG7fyvDRcidUoRl45vhTmnek+Y58RUN/aJemMle+ND9ayAqgn8@vger.kernel.org
X-Gm-Message-State: AOJu0YweAAO4YRZaoJwUYNQZ3cSpPzxozrgyUBpEkibdIvEHCm/NPeyN
	yjwVb4eAZ6ktKkyqKzxJM6yndcMfIV10w9HF0JvSF+dY5YiG6ysLqEd/xZa8WYnGO5XeTglutOy
	omcruDA==
X-Received: from pfbhx21.prod.google.com ([2002:a05:6a00:8995:b0:82f:8b22:bc77])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:17a1:b0:82c:e83d:a9b0
 with SMTP id d2e1a72fcca58-82f8c850e93mr30577591b3a.21.1776994681895; Thu, 23
 Apr 2026 18:38:01 -0700 (PDT)
Date: Fri, 24 Apr 2026 01:37:58 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260424013759.728288-1-kuniyu@google.com>
Subject: [PATCH] RDMA/rxe: Fix null-ptr-deref in kernel_sock_shutdown().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, linux-rdma@vger.kernel.org, 
	syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: DF4FE458CEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19521-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email]

syzbot reported null-ptr-deref in kernel_sock_shutdown(). [0]

The problem is rxe_net_del() can be called for the same
device concurrently.

Multiple threads might call udp_tunnel_sock_release()
for the same socket.

Let's add a per-netns mutex to synchronise rxe_net_del().

[0]:
Oops: general protection fault, probably for non-canonical address 0xdffffc000000000d: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
CPU: 3 UID: 0 PID: 12652 Comm: syz.7.1709 Tainted: G             L      syzkaller #0 PREEMPT(full)
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:kernel_sock_shutdown+0x47/0x70 net/socket.c:3785
Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 33 48 b8 00 00 00 00 00 fc ff df 4c 8b 63 20 49 8d 7c 24 68 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 1a 49 8b 44 24 68 89 ee 48 89 df 5b 5d 41 5c e9 46
RSP: 0018:ffffc9000566f180 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888058587240 RCX: 0000000000000000
RDX: 000000000000000d RSI: ffffffff895ced12 RDI: 0000000000000068
RBP: 0000000000000002 R08: 0000000000000001 R09: ffffed1006d98945
R10: ffff888036cc4a2b R11: 0000003683c25c00 R12: 0000000000000000
R13: ffff88805c998000 R14: 0000000000000002 R15: 0000000000000018
FS:  00007f1306d976c0(0000) GS:ffff8880d65db000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1306d97d58 CR3: 00000000404f1000 CR4: 0000000000352ef0
DR0: ffffffffffffffff DR1: 00000000000001f8 DR2: 0000000000000002
DR3: ffffffffefffff15 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udp_tunnel_sock_release+0x68/0x80 net/ipv4/udp_tunnel_core.c:202
 rxe_release_udp_tunnel drivers/infiniband/sw/rxe/rxe_net.c:294 [inline]
 rxe_sock_put+0xae/0x130 drivers/infiniband/sw/rxe/rxe_net.c:639
 rxe_net_del+0x83/0x120 drivers/infiniband/sw/rxe/rxe_net.c:660
 rxe_dellink+0x15/0x20 drivers/infiniband/sw/rxe/rxe.c:254
 nldev_dellink+0x289/0x3c0 drivers/infiniband/core/nldev.c:1849
 rdma_nl_rcv_msg+0x392/0x6f0 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb.constprop.0.isra.0+0x2cb/0x410 drivers/infiniband/core/netlink.c:239
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x9e1/0xb70 net/socket.c:2698
 ___sys_sendmsg+0x190/0x1e0 net/socket.c:2752
 __sys_sendmsg+0x170/0x220 net/socket.c:2784
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1305f9c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1306d97028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f1306216090 RCX: 00007f1305f9c819
RDX: 0000000000000000 RSI: 00002000000002c0 RDI: 0000000000000003
RBP: 00007f1306032c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1306216128 R14: 00007f1306216090 R15: 00007ffd8ecad288
 </TASK>
Modules linked in:

Fixes: f1327abd6abe ("RDMA/rxe: Support RDMA link creation and destruction per net namespace")
Reported-by: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69ea344f.a00a0220.17a17.0040.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c |  2 ++
 drivers/infiniband/sw/rxe/rxe_ns.c  | 18 ++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_ns.h  |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 50a2cb5405e2..1b3615c9262a 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -655,6 +655,7 @@ void rxe_net_del(struct ib_device *dev)
 
 	net = dev_net(ndev);
 
+	rxe_ns_pernet_sk_lock(net);
 	sk = rxe_ns_pernet_sk4(net);
 	if (sk)
 		rxe_sock_put(sk, rxe_ns_pernet_set_sk4, net);
@@ -662,6 +663,7 @@ void rxe_net_del(struct ib_device *dev)
 	sk = rxe_ns_pernet_sk6(net);
 	if (sk)
 		rxe_sock_put(sk, rxe_ns_pernet_set_sk6, net);
+	rxe_ns_pernet_sk_unlock(net);
 
 	dev_put(ndev);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
index 8b9d734229b2..375c7d79d9d3 100644
--- a/drivers/infiniband/sw/rxe/rxe_ns.c
+++ b/drivers/infiniband/sw/rxe/rxe_ns.c
@@ -16,6 +16,7 @@
 struct rxe_ns_sock {
 	struct sock __rcu *rxe_sk4;
 	struct sock __rcu *rxe_sk6;
+	struct mutex rxe_sk_lock;
 };
 
 /*
@@ -28,9 +29,12 @@ static unsigned int rxe_pernet_id;
  */
 static int rxe_ns_init(struct net *net)
 {
+	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
+
 	/* defer socket create in the namespace to the first
 	 * device create.
 	 */
+	mutex_init(&ns_sk->rxe_sk_lock);
 
 	return 0;
 }
@@ -71,6 +75,20 @@ static struct pernet_operations rxe_net_ops = {
 	.size = sizeof(struct rxe_ns_sock),
 };
 
+void rxe_ns_pernet_sk_lock(struct net *net)
+{
+	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
+
+	mutex_lock(&ns_sk->rxe_sk_lock);
+}
+
+void rxe_ns_pernet_sk_unlock(struct net *net)
+{
+	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
+
+	mutex_unlock(&ns_sk->rxe_sk_lock);
+}
+
 struct sock *rxe_ns_pernet_sk4(struct net *net)
 {
 	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
diff --git a/drivers/infiniband/sw/rxe/rxe_ns.h b/drivers/infiniband/sw/rxe/rxe_ns.h
index 4da2709e6b71..c5262843bb63 100644
--- a/drivers/infiniband/sw/rxe/rxe_ns.h
+++ b/drivers/infiniband/sw/rxe/rxe_ns.h
@@ -3,6 +3,8 @@
 #ifndef RXE_NS_H
 #define RXE_NS_H
 
+void rxe_ns_pernet_sk_lock(struct net *net);
+void rxe_ns_pernet_sk_unlock(struct net *net);
 struct sock *rxe_ns_pernet_sk4(struct net *net);
 void rxe_ns_pernet_set_sk4(struct net *net, struct sock *sk);
 
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog


