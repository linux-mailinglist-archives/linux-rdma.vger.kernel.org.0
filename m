Return-Path: <linux-rdma+bounces-1063-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB9F85B382
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32E5BB21D47
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 07:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CF05BAFF;
	Tue, 20 Feb 2024 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KK5umUty"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8F85B67D;
	Tue, 20 Feb 2024 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412528; cv=none; b=WWYnHnDIavZQY8dcfWMbVW4dxm9UhleI+FoNQ1LqQ7P1bhNmhs1V9Vk3RP2HT8k4VeREiRJMD3UiVAgCiSM81N/lJHSF8GYSzBhG4rjejXoGAci9D0jwrQLYaXhaL0doyGTxRS2Yu5RtGTkydNVXAyXQhkOm9b3MrbZJ+A21tk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412528; c=relaxed/simple;
	bh=SQNvMalijd45gfFGASD1aB5+WZz0gV238QYfgewPJO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=POIcWdrBSrLT+tHtKCKUBsePUshsJ80VKhmk4WjALEO7NNH8A5qUY6pYKHwJMCvyRNNEG9iQvvoSuQ/FAHrKpGEPBNZmnu74mLEx9YkA0cZB45IMIFpbonnECcCLcwFBCHu0O/22+ddwJ+H7NK74NTbMrPDTTL2nsD9BGlQmUTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KK5umUty; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708412521; h=From:To:Subject:Date:Message-Id;
	bh=oxlCRX75DTvhbMxdANvNarM4aptbjgB/GONB9m6f8rA=;
	b=KK5umUty/xbbuZA+mU0OmgHgsQFXWm87ufKiqKv3An589Cae9znHUR0TLe3/x1sAzm5LchRxCLN/P+n8yJS/PO8i5KkWouMrT7Scch4GH5a3MZ/xzqtiGysCB8cUaiEilaMo9Y9Pk/LNOOMNaOL/US3GFhGI+1NWDEbcOiCoCPU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W0vuXhK_1708412520;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W0vuXhK_1708412520)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 15:02:01 +0800
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
Subject: [RFC net-next 17/20] net/smc: add dummy implementation for inet smc sock
Date: Tue, 20 Feb 2024 15:01:42 +0800
Message-Id: <1708412505-34470-18-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
References: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

This patch implements a dummy version of inet smc sock,
and register it into the inet protocols, which allows
us to create a inet smc sock.

Note that, the ops is forked from tcp ops. The vast majority of fields
are consistent with TCP, and those cannot be consistent, mainly including,

1. obj_size
2. tw_prot and rsk_prot
3. function than need to be override, explicitly set to NULL.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/Makefile   |   1 +
 net/smc/af_smc.c   |  46 +++++++-
 net/smc/smc_inet.c | 315 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_inet.h |  86 +++++++++++++++
 4 files changed, 447 insertions(+), 1 deletion(-)
 create mode 100644 net/smc/smc_inet.c
 create mode 100644 net/smc/smc_inet.h

diff --git a/net/smc/Makefile b/net/smc/Makefile
index 875efcd..4f10c3b 100644
--- a/net/smc/Makefile
+++ b/net/smc/Makefile
@@ -5,4 +5,5 @@ obj-$(CONFIG_SMC_DIAG)	+= smc_diag.o
 smc-y := af_smc.o smc_pnet.o smc_ib.o smc_clc.o smc_core.o smc_wr.o smc_llc.o
 smc-y += smc_cdc.o smc_tx.o smc_rx.o smc_close.o smc_ism.o smc_netlink.o smc_stats.o
 smc-y += smc_tracepoint.o
+smc-y += smc_inet.o
 smc-$(CONFIG_SYSCTL) += smc_sysctl.o
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 97e3951..390fe6c 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -36,6 +36,9 @@
 
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <net/protocol.h>
+#include <net/inet_common.h>
+#include <net/transp_v6.h>
 #include "smc_netns.h"
 
 #include "smc.h"
@@ -53,6 +56,7 @@
 #include "smc_stats.h"
 #include "smc_tracepoint.h"
 #include "smc_sysctl.h"
+#include "smc_inet.h"
 
 static DEFINE_MUTEX(smc_server_lgr_pending);	/* serialize link group
 						 * creation on server
@@ -3658,9 +3662,36 @@ static int __init smc_init(void)
 		goto out_ib;
 	}
 
+	/* init smc inet sock related proto and proto_ops */
+	rc = smc_inet_sock_init();
+	if (!rc) {
+		/* registe smc inet proto */
+		rc = proto_register(&smc_inet_prot, 1);
+		if (rc) {
+			pr_err("%s: proto_register smc_inet_prot fails with %d\n", __func__, rc);
+			goto out_ulp;
+		}
+		/* no return value */
+		inet_register_protosw(&smc_inet_protosw);
+#if IS_ENABLED(CONFIG_IPV6)
+		/* register smc inet6 proto */
+		rc = proto_register(&smc_inet6_prot, 1);
+		if (rc) {
+			pr_err("%s: proto_register smc_inet6_prot fails with %d\n", __func__, rc);
+			goto out_proto_register;
+		}
+		/* no return value */
+		inet6_register_protosw(&smc_inet6_protosw);
+#endif
+	}
+
 	static_branch_enable(&tcp_have_smc);
 	return 0;
-
+out_proto_register:
+	inet_unregister_protosw(&smc_inet_protosw);
+	proto_unregister(&smc_inet_prot);
+out_ulp:
+	tcp_unregister_ulp(&smc_ulp_ops);
 out_ib:
 	smc_ib_unregister_client();
 out_sock:
@@ -3695,6 +3726,10 @@ static int __init smc_init(void)
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
@@ -3705,6 +3740,10 @@ static void __exit smc_exit(void)
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
@@ -3720,5 +3759,10 @@ static void __exit smc_exit(void)
 MODULE_DESCRIPTION("smc socket address family");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_NETPROTO(PF_SMC);
+/* It seems that this macro has different
+ * understanding of enum type(IPPROTO_SMC or SOCK_STREAM)
+ */
+MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET, 263, 1);
+MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET6, 263, 1);
 MODULE_ALIAS_TCP_ULP("smc");
 MODULE_ALIAS_GENL_FAMILY(SMC_GENL_FAMILY_NAME);
diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
new file mode 100644
index 00000000..d35b567
--- /dev/null
+++ b/net/smc/smc_inet.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Shared Memory Communications over RDMA (SMC-R) and RoCE
+ *
+ *  AF_SMC protocol family socket handler keeping the AF_INET sock address type
+ *  applies to SOCK_STREAM sockets only
+ *  offers an alternative communication option for TCP-protocol sockets
+ *  applicable with RoCE-cards only
+ *
+ *  Initial restrictions:
+ *    - support for alternate links postponed
+ *
+ *  Copyright IBM Corp. 2016, 2018
+ *
+ */
+
+#include <net/sock.h>
+#include <net/inet_common.h>
+
+#include "smc_inet.h"
+#include "smc.h"
+
+static struct timewait_sock_ops smc_timewait_sock_ops = {
+	.twsk_obj_size		= sizeof(struct tcp_timewait_sock),
+	.twsk_unique		= tcp_twsk_unique,
+	.twsk_destructor	= tcp_twsk_destructor,
+};
+
+static struct timewait_sock_ops smc6_timewait_sock_ops = {
+	.twsk_obj_size		= sizeof(struct tcp6_timewait_sock),
+	.twsk_unique		= tcp_twsk_unique,
+	.twsk_destructor	= tcp_twsk_destructor,
+};
+
+struct proto smc_inet_prot = {
+	.name			= "SMC",
+	.owner			= THIS_MODULE,
+	.close			= tcp_close,
+	.pre_connect		= NULL,
+	.connect		= tcp_v4_connect,
+	.disconnect		= tcp_disconnect,
+	.accept			= smc_inet_csk_accept,
+	.ioctl			= tcp_ioctl,
+	.init			= smc_inet_init_sock,
+	.destroy		= tcp_v4_destroy_sock,
+	.shutdown		= tcp_shutdown,
+	.setsockopt		= tcp_setsockopt,
+	.getsockopt		= tcp_getsockopt,
+	.keepalive		= tcp_set_keepalive,
+	.recvmsg		= tcp_recvmsg,
+	.sendmsg		= tcp_sendmsg,
+	.backlog_rcv		= tcp_v4_do_rcv,
+	.release_cb		= smc_inet_sock_proto_release_cb,
+	.hash			= inet_hash,
+	.unhash			= inet_unhash,
+	.get_port		= inet_csk_get_port,
+	.enter_memory_pressure	= tcp_enter_memory_pressure,
+	.per_cpu_fw_alloc       = &tcp_memory_per_cpu_fw_alloc,
+	.leave_memory_pressure	= tcp_leave_memory_pressure,
+	.stream_memory_free	= tcp_stream_memory_free,
+	.sockets_allocated	= &tcp_sockets_allocated,
+	.orphan_count		= &tcp_orphan_count,
+	.memory_allocated	= &tcp_memory_allocated,
+	.memory_pressure	= &tcp_memory_pressure,
+	.sysctl_mem		= sysctl_tcp_mem,
+	.sysctl_wmem_offset	= offsetof(struct net, ipv4.sysctl_tcp_wmem),
+	.sysctl_rmem_offset	= offsetof(struct net, ipv4.sysctl_tcp_rmem),
+	.max_header		= MAX_TCP_HEADER,
+	.obj_size		= sizeof(struct smc_sock),
+	.slab_flags		= SLAB_TYPESAFE_BY_RCU,
+	.twsk_prot		= &smc_timewait_sock_ops,
+	/* tcp_conn_request will use tcp_request_sock_ops */
+	.rsk_prot		= NULL,
+	.h.hashinfo		= &tcp_hashinfo,
+	.no_autobind		= true,
+	.diag_destroy		= tcp_abort,
+};
+EXPORT_SYMBOL_GPL(smc_inet_prot);
+
+const struct proto_ops smc_inet_stream_ops = {
+	.family		   = PF_INET,
+	.owner		   = THIS_MODULE,
+	.release	   = smc_inet_release,
+	.bind		   = inet_bind,
+	.connect	   = smc_inet_connect,
+	.socketpair	   = sock_no_socketpair,
+	.accept		   = inet_accept,
+	.getname	   = inet_getname,
+	.poll		   = smc_inet_poll,
+	.ioctl		   = smc_inet_ioctl,
+	.gettstamp	   = sock_gettstamp,
+	.listen		   = smc_inet_listen,
+	.shutdown	   = smc_inet_shutdown,
+	.setsockopt	   = smc_inet_setsockopt,
+	.getsockopt	   = smc_inet_getsockopt,
+	.sendmsg	   = smc_inet_sendmsg,
+	.recvmsg	   = smc_inet_recvmsg,
+#ifdef CONFIG_MMU
+	.mmap		   = tcp_mmap,
+#endif
+	.splice_read	   = smc_inet_splice_read,
+	.read_sock	   = tcp_read_sock,
+	.sendmsg_locked    = tcp_sendmsg_locked,
+	.peek_len	   = tcp_peek_len,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	   = inet_compat_ioctl,
+#endif
+	.set_rcvlowat	   = tcp_set_rcvlowat,
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
+	.name			= "SMCv6",
+	.owner			= THIS_MODULE,
+	.close			= tcp_close,
+	.pre_connect		= NULL,
+	.connect		= NULL,
+	.disconnect		= tcp_disconnect,
+	.accept			= smc_inet_csk_accept,
+	.ioctl			= tcp_ioctl,
+	.init			= smc_inet_init_sock,
+	.destroy		= NULL,
+	.shutdown		= tcp_shutdown,
+	.setsockopt		= tcp_setsockopt,
+	.getsockopt		= tcp_getsockopt,
+	.keepalive		= tcp_set_keepalive,
+	.recvmsg		= tcp_recvmsg,
+	.sendmsg		= tcp_sendmsg,
+	.backlog_rcv		= NULL,
+	.release_cb		= smc_inet_sock_proto_release_cb,
+	.hash			= NULL,
+	.unhash			= inet_unhash,
+	.get_port		= inet_csk_get_port,
+	.enter_memory_pressure	= tcp_enter_memory_pressure,
+	.per_cpu_fw_alloc       = &tcp_memory_per_cpu_fw_alloc,
+	.leave_memory_pressure	= tcp_leave_memory_pressure,
+	.stream_memory_free	= tcp_stream_memory_free,
+	.sockets_allocated	= &tcp_sockets_allocated,
+	.memory_allocated	= &tcp_memory_allocated,
+	.memory_pressure	= &tcp_memory_pressure,
+	.orphan_count		= &tcp_orphan_count,
+	.sysctl_mem		= sysctl_tcp_mem,
+	.sysctl_wmem_offset	= offsetof(struct net, ipv4.sysctl_tcp_wmem),
+	.sysctl_rmem_offset	= offsetof(struct net, ipv4.sysctl_tcp_rmem),
+	.max_header		= MAX_TCP_HEADER,
+	.obj_size		= sizeof(struct smc_sock),
+	.ipv6_pinfo_offset	= offsetof(struct tcp6_sock, inet6),
+	.slab_flags		= SLAB_TYPESAFE_BY_RCU,
+	.twsk_prot		= &smc6_timewait_sock_ops,
+	/* tcp_conn_request will use tcp_request_sock_ops */
+	.rsk_prot		= NULL,
+	.h.hashinfo		= &tcp_hashinfo,
+	.no_autobind		= true,
+	.diag_destroy		= tcp_abort,
+};
+EXPORT_SYMBOL_GPL(smc_inet6_prot);
+
+const struct proto_ops smc_inet6_stream_ops = {
+	.family		   = PF_INET6,
+	.owner		   = THIS_MODULE,
+	.release	   = smc_inet_release,
+	.bind		   = inet6_bind,
+	.connect	   = smc_inet_connect,	/* ok		*/
+	.socketpair	   = sock_no_socketpair,	/* a do nothing	*/
+	.accept		   = inet_accept,		/* ok		*/
+	.getname	   = inet6_getname,
+	.poll		   = smc_inet_poll,			/* ok		*/
+	.ioctl		   = smc_inet_ioctl,		/* must change  */
+	.gettstamp	   = sock_gettstamp,
+	.listen		   = smc_inet_listen,		/* ok		*/
+	.shutdown	   = smc_inet_shutdown,		/* ok		*/
+	.setsockopt	   = smc_inet_setsockopt,	/* ok		*/
+	.getsockopt	   = smc_inet_getsockopt,	/* ok		*/
+	.sendmsg	   = smc_inet_sendmsg,		/* retpoline's sake */
+	.recvmsg	   = smc_inet_recvmsg,		/* retpoline's sake */
+#ifdef CONFIG_MMU
+	.mmap		   = tcp_mmap,
+#endif
+	.sendmsg_locked    = tcp_sendmsg_locked,
+	.splice_read	   = smc_inet_splice_read,
+	.read_sock	   = tcp_read_sock,
+	.peek_len	   = tcp_peek_len,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	   = inet6_compat_ioctl,
+#endif
+	.set_rcvlowat	   = tcp_set_rcvlowat,
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
+int smc_inet_sock_init(void)
+{
+	struct proto *tcp_v4prot;
+#if IS_ENABLED(CONFIG_IPV6)
+	struct proto *tcp_v6prot;
+#endif
+
+	tcp_v4prot = smc_inet_get_tcp_prot(PF_INET);
+	if (unlikely(!tcp_v4prot))
+		return -EINVAL;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	tcp_v6prot = smc_inet_get_tcp_prot(PF_INET6);
+	if (unlikely(!tcp_v6prot))
+		return -EINVAL;
+#endif
+
+	/* INET sock has a issues here. twsk will hold the reference of the this module,
+	 * so it may be found that the SMC module cannot be uninstalled after the test program ends,
+	 * But eventually, twsk will release the reference of the module.
+	 * This may affect some old test cases if they try to remove the module immediately after
+	 * completing their test.
+	 */
+
+	/* Complete the full prot and proto_ops to
+	 * ensure consistency with TCP. Some symbols here have not been exported,
+	 * so that we have to assign it here.
+	 */
+	smc_inet_prot.pre_connect = tcp_v4prot->pre_connect;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	smc_inet6_prot.pre_connect = tcp_v6prot->pre_connect;
+	smc_inet6_prot.connect = tcp_v6prot->connect;
+	smc_inet6_prot.destroy = tcp_v6prot->destroy;
+	smc_inet6_prot.backlog_rcv = tcp_v6prot->backlog_rcv;
+	smc_inet6_prot.hash = tcp_v6prot->hash;
+#endif
+	return 0;
+}
+
+int smc_inet_init_sock(struct sock *sk) { return  0; }
+
+void smc_inet_sock_proto_release_cb(struct sock *sk) {}
+
+int smc_inet_connect(struct socket *sock, struct sockaddr *addr,
+		     int alen, int flags)
+{
+	return -EOPNOTSUPP;
+}
+
+int smc_inet_setsockopt(struct socket *sock, int level, int optname,
+			sockptr_t optval, unsigned int optlen)
+{
+	return -EOPNOTSUPP;
+}
+
+int smc_inet_getsockopt(struct socket *sock, int level, int optname,
+			char __user *optval, int __user *optlen)
+{
+	return -EOPNOTSUPP;
+}
+
+int smc_inet_ioctl(struct socket *sock, unsigned int cmd,
+		   unsigned long arg)
+{
+	return -EOPNOTSUPP;
+}
+
+int smc_inet_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
+{
+	return -EOPNOTSUPP;
+}
+
+int smc_inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
+		     int flags)
+{
+	return -EOPNOTSUPP;
+}
+
+ssize_t smc_inet_splice_read(struct socket *sock, loff_t *ppos,
+			     struct pipe_inode_info *pipe, size_t len,
+			     unsigned int flags)
+{
+	return -EOPNOTSUPP;
+}
+
+__poll_t smc_inet_poll(struct file *file, struct socket *sock, poll_table *wait)
+{
+	return 0;
+}
+
+struct sock *smc_inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
+{
+	return NULL;
+}
+
+int smc_inet_listen(struct socket *sock, int backlog)
+{
+	return -EOPNOTSUPP;
+}
+
+int smc_inet_shutdown(struct socket *sock, int how)
+{
+	return -EOPNOTSUPP;
+}
+
+int smc_inet_release(struct socket *sock)
+{
+	return -EOPNOTSUPP;
+}
diff --git a/net/smc/smc_inet.h b/net/smc/smc_inet.h
new file mode 100644
index 00000000..68ecfa0
--- /dev/null
+++ b/net/smc/smc_inet.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Shared Memory Communications over RDMA (SMC-R) and RoCE
+ *
+ *  Definitions for the SMC module (socket related)
+ *
+ *  Copyright IBM Corp. 2016
+ *
+ */
+
+#ifndef __SMC_INET
+#define __SMC_INET
+
+#include <net/protocol.h>
+#include <net/sock.h>
+#include <net/tcp.h>
+#include <net/ipv6.h>
+/* MUST after net/tcp.h or warning */
+#include <net/transp_v6.h>
+
+extern struct proto smc_inet_prot;
+extern struct proto smc_inet6_prot;
+
+extern const struct proto_ops smc_inet_stream_ops;
+extern const struct proto_ops smc_inet6_stream_ops;
+
+extern struct inet_protosw smc_inet_protosw;
+extern struct inet_protosw smc_inet6_protosw;
+
+/* obtain TCP proto via sock family */
+static __always_inline struct proto *smc_inet_get_tcp_prot(int family)
+{
+	switch (family) {
+	case AF_INET:
+		return &tcp_prot;
+	case AF_INET6:
+		return &tcpv6_prot;
+	default:
+		pr_warn_once("smc: %s(unknown family %d)\n", __func__, family);
+		break;
+	}
+	return NULL;
+}
+
+/* This function initializes the inet related structures.
+ * If initialization is successful, it returns 0;
+ * otherwise, it returns a non-zero value.
+ */
+int smc_inet_sock_init(void);
+
+int smc_inet_init_sock(struct sock *sk);
+void smc_inet_sock_proto_release_cb(struct sock *sk);
+
+int smc_inet_connect(struct socket *sock, struct sockaddr *addr,
+		     int alen, int flags);
+
+int smc_inet_setsockopt(struct socket *sock, int level, int optname,
+			sockptr_t optval, unsigned int optlen);
+
+int smc_inet_getsockopt(struct socket *sock, int level, int optname,
+			char __user *optval, int __user *optlen);
+
+int smc_inet_ioctl(struct socket *sock, unsigned int cmd,
+		   unsigned long arg);
+
+int smc_inet_sendmsg(struct socket *sock, struct msghdr *msg, size_t len);
+
+int smc_inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
+		     int flags);
+
+ssize_t smc_inet_sendpage(struct socket *sock, struct page *page,
+			  int offset, size_t size, int flags);
+
+ssize_t smc_inet_splice_read(struct socket *sock, loff_t *ppos,
+			     struct pipe_inode_info *pipe, size_t len,
+			     unsigned int flags);
+
+__poll_t smc_inet_poll(struct file *file, struct socket *sock, poll_table *wait);
+
+struct sock *smc_inet_csk_accept(struct sock *sk, int flags, int *err, bool kern);
+int smc_inet_listen(struct socket *sock, int backlog);
+
+int smc_inet_shutdown(struct socket *sock, int how);
+int smc_inet_release(struct socket *sock);
+
+#endif // __SMC_INET
-- 
1.8.3.1


