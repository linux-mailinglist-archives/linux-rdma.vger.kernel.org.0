Return-Path: <linux-rdma+bounces-2388-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC3D8C1D59
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 06:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22BD7B216A8
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 04:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3595814A0BD;
	Fri, 10 May 2024 04:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PqQ8oZCo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44709149C79;
	Fri, 10 May 2024 04:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715314352; cv=none; b=u0DbtPEYmu+bKw72I+1Qj1GpDGI69UUC7IR+a+OHwd+/M1ArjEKF7fUvf/tIP1UUS6O7mZNX8Q0zyTtLJaa1PrMYkoR5PGpaurefsEOLkeYiG1x62cvYC3PdEG3prhAnEMJ4Sgl06DZp2GsPZ8ic/YUSyBJyLIXAsQpRe0d9nr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715314352; c=relaxed/simple;
	bh=rRhYVjyMxcBJ1tMPA5ngH6lCRNTqG1T+Lm7qw1m31N4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=t04EHl9+0BhC5z/jGcNTQvlJaP9C6LFs3K1srPsC9r3yCnOMiO6/Dll0PGFCk/NeJK9GYx10HvToveXALdhHabQDKWNnKkYuyYzFRi08SoO2uxrPD1MTjdOaZaJ1bkb8XKGUFlH3DXRq71Dah/wcWR8mqYHMox2KIKQkorBolZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PqQ8oZCo; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715314341; h=From:To:Subject:Date:Message-Id;
	bh=sgex6/XgUXj5mDPJL53y6fNqWSjgKxHeGKBgEisa69s=;
	b=PqQ8oZCobV1QlcxlZYF1YBKTaf4hmFR518WYfCQZLgvWOtoJjLuz3+JFybYd1W4zflRI5m6g4g+egMnbwsyk9+ZL2KyKIPYIwql91WaxeHOwuA3uiXoB2xqqLz9yHoKf6nIfUZncKBPSzFFEgmXNyxZxy+VdP84BD6EAXfrtFjs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W68pi31_1715314339;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W68pi31_1715314339)
          by smtp.aliyun-inc.com;
          Fri, 10 May 2024 12:12:20 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	wintera@linux.ibm.com,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	tonylu@linux.alibaba.com,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [PATCH net-next 2/2] net/smc: Introduce IPPROTO_SMC
Date: Fri, 10 May 2024 12:12:13 +0800
Message-Id: <1715314333-107290-3-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1715314333-107290-1-git-send-email-alibuda@linux.alibaba.com>
References: <1715314333-107290-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

This patch allows to create smc socket via AF_INET,
similar to the following code,

/* create v4 smc sock */
v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);

/* create v6 smc sock */
v6 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);

There are several reasons why we believe it is appropriate here:

1. For smc sockets, it actually use IPv4 (AF-INET) or IPv6 (AF-INET6)
address. There is no AF_SMC address at all.

2. Create smc socket in the AF_INET(6) path, which allows us to reuse
the infrastructure of AF_INET(6) path, such as common ebpf hooks.
Otherwise, smc have to implement it again in AF_SMC path.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 include/uapi/linux/in.h |   2 +
 net/smc/af_smc.c        | 129 +++++++++++++++++++++++++++++++++++++++++++++++-
 net/smc/inet_smc.h      |  32 ++++++++++++
 3 files changed, 162 insertions(+), 1 deletion(-)
 create mode 100644 net/smc/inet_smc.h

diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index e682ab6..74c12e33 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -83,6 +83,8 @@ enum {
 #define IPPROTO_RAW		IPPROTO_RAW
   IPPROTO_MPTCP = 262,		/* Multipath TCP connection		*/
 #define IPPROTO_MPTCP		IPPROTO_MPTCP
+  IPPROTO_SMC = 263,		/* Shared Memory Communications */
+#define IPPROTO_SMC		IPPROTO_SMC
   IPPROTO_MAX
 };
 #endif
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 1f03724..b4557828 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -54,6 +54,7 @@
 #include "smc_tracepoint.h"
 #include "smc_sysctl.h"
 #include "smc_loopback.h"
+#include "inet_smc.h"
 
 static DEFINE_MUTEX(smc_server_lgr_pending);	/* serialize link group
 						 * creation on server
@@ -3402,6 +3403,16 @@ static int smc_create(struct net *net, struct socket *sock, int protocol,
 	.create	= smc_create,
 };
 
+int smc_inet_init_sock(struct sock *sk)
+{
+	struct net *net = sock_net(sk);
+
+	/* init common smc sock */
+	smc_sock_init(net, sk, IPPROTO_SMC);
+	/* create clcsock */
+	return __smc_create_clcsk(net, sk, sk->sk_family);
+}
+
 static int smc_ulp_init(struct sock *sk)
 {
 	struct socket *tcp = sk->sk_socket;
@@ -3460,6 +3471,90 @@ static void smc_ulp_clone(const struct request_sock *req, struct sock *newsk,
 	.clone		= smc_ulp_clone,
 };
 
+struct proto smc_inet_prot = {
+	.name			= "INET_SMC",
+	.owner			= THIS_MODULE,
+	.init			= smc_inet_init_sock,
+	.hash			= smc_hash_sk,
+	.unhash			= smc_unhash_sk,
+	.release_cb		= smc_release_cb,
+	.obj_size		= sizeof(struct smc_sock),
+	.h.smc_hash	= &smc_v4_hashinfo,
+	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
+};
+
+const struct proto_ops smc_inet_stream_ops = {
+	.family		= PF_INET,
+	.owner		= THIS_MODULE,
+	.release	= smc_release,
+	.bind		= smc_bind,
+	.connect	= smc_connect,
+	.socketpair	= sock_no_socketpair,
+	.accept		= smc_accept,
+	.getname	= smc_getname,
+	.poll		= smc_poll,
+	.ioctl		= smc_ioctl,
+	.listen		= smc_listen,
+	.shutdown	= smc_shutdown,
+	.setsockopt	= smc_setsockopt,
+	.getsockopt	= smc_getsockopt,
+	.sendmsg	= smc_sendmsg,
+	.recvmsg	= smc_recvmsg,
+	.mmap		= sock_no_mmap,
+	.splice_read	= smc_splice_read,
+};
+
+struct inet_protosw smc_inet_protosw = {
+	.type       = SOCK_STREAM,
+	.protocol   = IPPROTO_SMC,
+	.prot   = &smc_inet_prot,
+	.ops    = &smc_inet_stream_ops,
+	.flags  = INET_PROTOSW_ICSK,
+};
+
+#if IS_ENABLED(CONFIG_IPV6)
+struct proto smc_inet6_prot = {
+	.name			= "INET6_SMC",
+	.owner			= THIS_MODULE,
+	.init			= smc_inet_init_sock,
+	.hash			= smc_hash_sk,
+	.unhash			= smc_unhash_sk,
+	.release_cb		= smc_release_cb,
+	.obj_size		= sizeof(struct smc_sock),
+	.h.smc_hash		= &smc_v6_hashinfo,
+	.slab_flags		= SLAB_TYPESAFE_BY_RCU,
+};
+
+const struct proto_ops smc_inet6_stream_ops = {
+	.family		= PF_INET6,
+	.owner		= THIS_MODULE,
+	.release	= smc_release,
+	.bind		= smc_bind,
+	.connect	= smc_connect,
+	.socketpair	= sock_no_socketpair,
+	.accept		= smc_accept,
+	.getname	= smc_getname,
+	.poll		= smc_poll,
+	.ioctl		= smc_ioctl,
+	.listen		= smc_listen,
+	.shutdown	= smc_shutdown,
+	.setsockopt	= smc_setsockopt,
+	.getsockopt	= smc_getsockopt,
+	.sendmsg	= smc_sendmsg,
+	.recvmsg	= smc_recvmsg,
+	.mmap		= sock_no_mmap,
+	.splice_read	= smc_splice_read,
+};
+
+struct inet_protosw smc_inet6_protosw = {
+	.type       = SOCK_STREAM,
+	.protocol   = IPPROTO_SMC,
+	.prot   = &smc_inet6_prot,
+	.ops    = &smc_inet6_stream_ops,
+	.flags  = INET_PROTOSW_ICSK,
+};
+#endif
+
 unsigned int smc_net_id;
 
 static __net_init int smc_net_init(struct net *net)
@@ -3595,9 +3690,28 @@ static int __init smc_init(void)
 		goto out_lo;
 	}
 
+	rc = proto_register(&smc_inet_prot, 1);
+	if (rc) {
+		pr_err("%s: proto_register smc_inet_prot fails with %d\n", __func__, rc);
+		goto out_ulp;
+	}
+	inet_register_protosw(&smc_inet_protosw);
+#if IS_ENABLED(CONFIG_IPV6)
+	rc = proto_register(&smc_inet6_prot, 1);
+	if (rc) {
+		pr_err("%s: proto_register smc_inet6_prot fails with %d\n", __func__, rc);
+		goto out_inet_prot;
+	}
+	inet6_register_protosw(&smc_inet6_protosw);
+#endif
+
 	static_branch_enable(&tcp_have_smc);
 	return 0;
-
+out_inet_prot:
+	inet_unregister_protosw(&smc_inet_protosw);
+	proto_unregister(&smc_inet_prot);
+out_ulp:
+	tcp_unregister_ulp(&smc_ulp_ops);
 out_lo:
 	smc_loopback_exit();
 out_ib:
@@ -3634,6 +3748,10 @@ static int __init smc_init(void)
 static void __exit smc_exit(void)
 {
 	static_branch_disable(&tcp_have_smc);
+	inet_unregister_protosw(&smc_inet_protosw);
+#if IS_ENABLED(CONFIG_IPV6)
+	inet6_unregister_protosw(&smc_inet6_protosw);
+#endif
 	tcp_unregister_ulp(&smc_ulp_ops);
 	sock_unregister(PF_SMC);
 	smc_core_exit();
@@ -3645,6 +3763,10 @@ static void __exit smc_exit(void)
 	destroy_workqueue(smc_hs_wq);
 	proto_unregister(&smc_proto6);
 	proto_unregister(&smc_proto);
+	proto_unregister(&smc_inet_prot);
+#if IS_ENABLED(CONFIG_IPV6)
+	proto_unregister(&smc_inet6_prot);
+#endif
 	smc_pnet_exit();
 	smc_nl_exit();
 	smc_clc_exit();
@@ -3661,4 +3783,9 @@ static void __exit smc_exit(void)
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_NETPROTO(PF_SMC);
 MODULE_ALIAS_TCP_ULP("smc");
+/* 263 for IPPROTO_SMC and 1 for SOCK_STREAM */
+MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET, 263, 1);
+#if IS_ENABLED(CONFIG_IPV6)
+MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET6, 263, 1);
+#endif
 MODULE_ALIAS_GENL_FAMILY(SMC_GENL_FAMILY_NAME);
diff --git a/net/smc/inet_smc.h b/net/smc/inet_smc.h
new file mode 100644
index 00000000..fcdcb61
--- /dev/null
+++ b/net/smc/inet_smc.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Shared Memory Communications over RDMA (SMC-R) and RoCE
+ *
+ *  Definitions for the SMC module (socket related)
+
+ *  Copyright IBM Corp. 2016
+ *
+ */
+#ifndef __INET_SMC
+#define __INET_SMC
+
+#include <net/protocol.h>
+#include <net/sock.h>
+#include <net/tcp.h>
+
+extern struct proto smc_inet_prot;
+extern const struct proto_ops smc_inet_stream_ops;
+extern struct inet_protosw smc_inet_protosw;
+
+#if IS_ENABLED(CONFIG_IPV6)
+#include <net/ipv6.h>
+/* MUST after net/tcp.h or warning */
+#include <net/transp_v6.h>
+extern struct proto smc_inet6_prot;
+extern const struct proto_ops smc_inet6_stream_ops;
+extern struct inet_protosw smc_inet6_protosw;
+#endif
+
+int smc_inet_init_sock(struct sock *sk);
+
+#endif // __INET_SMC
-- 
1.8.3.1


