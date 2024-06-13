Return-Path: <linux-rdma+bounces-3094-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8228090653D
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 09:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1ED1C20AA4
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 07:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F2713C664;
	Thu, 13 Jun 2024 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="foAw8ENO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B21C13C66A;
	Thu, 13 Jun 2024 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264018; cv=none; b=Yn3UnG0pjTPvtDpv6404cGjH36e5g8nWac1OvZDb94raltnDOMDm0TO2rYK1+yj1pO8SLi8PXu03b82tRbZe+yXSlI9i/R3iOArVryjhDcUPrqU4Ugqdtl/do+KSnCjoWl8NzVQEOT6XKxN2uJcKNmDuXbe2gmxvpar0bJY3FrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264018; c=relaxed/simple;
	bh=l98vzZhSjT61/hWDKFLcZ87GIpf4cmH9jBMuviQK7FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYQXi83+K2iZGUjGcsvZHkpK/6vo6cp5Sv6roW2+QHJsoij/4OXiTlQa2X6g+QEABcTN72f+kD0f+Q+Xqier/ahmzejZ0nNV/1u8esdihZxfS1pBpfTe9jKujOizEU+wG5A6G+fD5fYzzhzr4LFGB+pasU8Ab1cO4R0Yt27oYXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=foAw8ENO; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718264010; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=SZuquP+aqfvBkHlrAqutE2+VCzMyD0Xfl27RBFGTfyE=;
	b=foAw8ENOusM5D+KT46hXxeDT7ALeLdSVyW1X3XYIMcEQVhTUyBaIxDwswuWzHTjdWN0bVvZN+YW/Hld9I9xiXeA1YgGmo5kXI5rOluD01qpgJ7rTO/b9vf1aJ8s09k2ZywOYhyi5hPZpiLCweNup5Z+M/bnIPNPrTstw+Hl28yY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W8NAjd1_1718264009;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0W8NAjd1_1718264009)
          by smtp.aliyun-inc.com;
          Thu, 13 Jun 2024 15:33:30 +0800
Date: Thu, 13 Jun 2024 15:33:29 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH net-next v7 3/3] net/smc: Introduce IPPROTO_SMC
Message-ID: <20240613073329.GQ78725@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <1717837949-88904-1-git-send-email-alibuda@linux.alibaba.com>
 <1717837949-88904-4-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1717837949-88904-4-git-send-email-alibuda@linux.alibaba.com>

On 2024-06-08 17:12:29, D. Wythe wrote:
>From: "D. Wythe" <alibuda@linux.alibaba.com>
>
>This patch allows to create smc socket via AF_INET,
>similar to the following code,
>
>/* create v4 smc sock */
>v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
>
>/* create v6 smc sock */
>v6 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
>
>There are several reasons why we believe it is appropriate here:
>
>1. For smc sockets, it actually use IPv4 (AF-INET) or IPv6 (AF-INET6)
>address. There is no AF_SMC address at all.
>
>2. Create smc socket in the AF_INET(6) path, which allows us to reuse
>the infrastructure of AF_INET(6) path, such as common ebpf hooks.
>Otherwise, smc have to implement it again in AF_SMC path.
>
>Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
>Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
>Tested-by: Wenjia Zhang <wenjia@linux.ibm.com>
>---
> include/uapi/linux/in.h |   2 +
> net/smc/Makefile        |   2 +-
> net/smc/af_smc.c        |  16 ++++-
> net/smc/smc_inet.c      | 169 ++++++++++++++++++++++++++++++++++++++++++++++++
> net/smc/smc_inet.h      |  22 +++++++
> 5 files changed, 208 insertions(+), 3 deletions(-)
> create mode 100644 net/smc/smc_inet.c
> create mode 100644 net/smc/smc_inet.h
>
>diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
>index e682ab6..d358add 100644
>--- a/include/uapi/linux/in.h
>+++ b/include/uapi/linux/in.h
>@@ -81,6 +81,8 @@ enum {
> #define IPPROTO_ETHERNET	IPPROTO_ETHERNET
>   IPPROTO_RAW = 255,		/* Raw IP packets			*/
> #define IPPROTO_RAW		IPPROTO_RAW
>+  IPPROTO_SMC = 256,		/* Shared Memory Communications		*/
>+#define IPPROTO_SMC		IPPROTO_SMC
>   IPPROTO_MPTCP = 262,		/* Multipath TCP connection		*/
> #define IPPROTO_MPTCP		IPPROTO_MPTCP
>   IPPROTO_MAX
>diff --git a/net/smc/Makefile b/net/smc/Makefile
>index 2c510d54..60f1c87 100644
>--- a/net/smc/Makefile
>+++ b/net/smc/Makefile
>@@ -4,6 +4,6 @@ obj-$(CONFIG_SMC)	+= smc.o
> obj-$(CONFIG_SMC_DIAG)	+= smc_diag.o
> smc-y := af_smc.o smc_pnet.o smc_ib.o smc_clc.o smc_core.o smc_wr.o smc_llc.o
> smc-y += smc_cdc.o smc_tx.o smc_rx.o smc_close.o smc_ism.o smc_netlink.o smc_stats.o
>-smc-y += smc_tracepoint.o
>+smc-y += smc_tracepoint.o smc_inet.o
> smc-$(CONFIG_SYSCTL) += smc_sysctl.o
> smc-$(CONFIG_SMC_LO) += smc_loopback.o
>diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>index 8e3ce76..435f38b 100644
>--- a/net/smc/af_smc.c
>+++ b/net/smc/af_smc.c
>@@ -54,6 +54,7 @@
> #include "smc_tracepoint.h"
> #include "smc_sysctl.h"
> #include "smc_loopback.h"
>+#include "smc_inet.h"
> 
> static DEFINE_MUTEX(smc_server_lgr_pending);	/* serialize link group
> 						 * creation on server
>@@ -3593,10 +3594,15 @@ static int __init smc_init(void)
> 		pr_err("%s: tcp_ulp_register fails with %d\n", __func__, rc);
> 		goto out_lo;
> 	}
>-
>+	rc = smc_inet_init();
>+	if (rc) {
>+		pr_err("%s: smc_inet_init fails with %d\n", __func__, rc);
>+		goto out_ulp;
>+	}
> 	static_branch_enable(&tcp_have_smc);
> 	return 0;
>-
>+out_ulp:
>+	tcp_unregister_ulp(&smc_ulp_ops);
> out_lo:
> 	smc_loopback_exit();
> out_ib:
>@@ -3633,6 +3639,7 @@ static int __init smc_init(void)
> static void __exit smc_exit(void)
> {
> 	static_branch_disable(&tcp_have_smc);
>+	smc_inet_exit();
> 	tcp_unregister_ulp(&smc_ulp_ops);
> 	sock_unregister(PF_SMC);
> 	smc_core_exit();
>@@ -3660,4 +3667,9 @@ static void __exit smc_exit(void)
> MODULE_LICENSE("GPL");
> MODULE_ALIAS_NETPROTO(PF_SMC);
> MODULE_ALIAS_TCP_ULP("smc");
>+/* 256 for IPPROTO_SMC and 1 for SOCK_STREAM */
>+MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET, 256, 1);
>+#if IS_ENABLED(CONFIG_IPV6)
>+MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET6, 256, 1);
>+#endif /* CONFIG_IPV6 */
> MODULE_ALIAS_GENL_FAMILY(SMC_GENL_FAMILY_NAME);
>diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
>new file mode 100644
>index 00000000..bca57ae
>--- /dev/null
>+++ b/net/smc/smc_inet.c
>@@ -0,0 +1,169 @@
>+// SPDX-License-Identifier: GPL-2.0-only
>+/*
>+ *  Shared Memory Communications over RDMA (SMC-R) and RoCE
>+ *
>+ *  Definitions for the IPPROTO_SMC (socket related)
>+ *
>+ *  Copyright IBM Corp. 2016, 2018
>+ *  Copyright (c) 2024, Alibaba Inc.
>+ *
>+ *  Author: D. Wythe <alibuda@linux.alibaba.com>
>+ */
>+
>+#include <net/protocol.h>
>+#include <net/sock.h>
>+
>+#include "smc_inet.h"
>+#include "smc.h"
>+
>+static struct proto smc_inet_prot;
>+static const struct proto_ops smc_inet_stream_ops;
>+static struct inet_protosw smc_inet_protosw;
>+
>+#if IS_ENABLED(CONFIG_IPV6)
>+static struct proto smc_inet6_prot;
>+static const struct proto_ops smc_inet6_stream_ops;
>+static struct inet_protosw smc_inet6_protosw;
>+#endif /* CONFIG_IPV6 */

Those declarations do not seem to be needed.

with this address
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>


>+
>+static int smc_inet_init_sock(struct sock *sk);
>+
>+static struct proto smc_inet_prot = {
>+	.name		= "INET_SMC",
>+	.owner		= THIS_MODULE,
>+	.init		= smc_inet_init_sock,
>+	.hash		= smc_hash_sk,
>+	.unhash		= smc_unhash_sk,
>+	.release_cb	= smc_release_cb,
>+	.obj_size	= sizeof(struct smc_sock),
>+	.h.smc_hash	= &smc_v4_hashinfo,
>+	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
>+};
>+
>+static const struct proto_ops smc_inet_stream_ops = {
>+	.family		= PF_INET,
>+	.owner		= THIS_MODULE,
>+	.release	= smc_release,
>+	.bind		= smc_bind,
>+	.connect	= smc_connect,
>+	.socketpair	= sock_no_socketpair,
>+	.accept		= smc_accept,
>+	.getname	= smc_getname,
>+	.poll		= smc_poll,
>+	.ioctl		= smc_ioctl,
>+	.listen		= smc_listen,
>+	.shutdown	= smc_shutdown,
>+	.setsockopt	= smc_setsockopt,
>+	.getsockopt	= smc_getsockopt,
>+	.sendmsg	= smc_sendmsg,
>+	.recvmsg	= smc_recvmsg,
>+	.mmap		= sock_no_mmap,
>+	.splice_read	= smc_splice_read,
>+};
>+
>+static struct inet_protosw smc_inet_protosw = {
>+	.type		= SOCK_STREAM,
>+	.protocol	= IPPROTO_SMC,
>+	.prot		= &smc_inet_prot,
>+	.ops		= &smc_inet_stream_ops,
>+	.flags		= INET_PROTOSW_ICSK,
>+};
>+
>+#if IS_ENABLED(CONFIG_IPV6)
>+static struct proto smc_inet6_prot = {
>+	.name		= "INET6_SMC",
>+	.owner		= THIS_MODULE,
>+	.init		= smc_inet_init_sock,
>+	.hash		= smc_hash_sk,
>+	.unhash		= smc_unhash_sk,
>+	.release_cb	= smc_release_cb,
>+	.obj_size	= sizeof(struct smc_sock),
>+	.h.smc_hash	= &smc_v6_hashinfo,
>+	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
>+};
>+
>+static const struct proto_ops smc_inet6_stream_ops = {
>+	.family		= PF_INET6,
>+	.owner		= THIS_MODULE,
>+	.release	= smc_release,
>+	.bind		= smc_bind,
>+	.connect	= smc_connect,
>+	.socketpair	= sock_no_socketpair,
>+	.accept		= smc_accept,
>+	.getname	= smc_getname,
>+	.poll		= smc_poll,
>+	.ioctl		= smc_ioctl,
>+	.listen		= smc_listen,
>+	.shutdown	= smc_shutdown,
>+	.setsockopt	= smc_setsockopt,
>+	.getsockopt	= smc_getsockopt,
>+	.sendmsg	= smc_sendmsg,
>+	.recvmsg	= smc_recvmsg,
>+	.mmap		= sock_no_mmap,
>+	.splice_read	= smc_splice_read,
>+};
>+
>+static struct inet_protosw smc_inet6_protosw = {
>+	.type		= SOCK_STREAM,
>+	.protocol	= IPPROTO_SMC,
>+	.prot		= &smc_inet6_prot,
>+	.ops		= &smc_inet6_stream_ops,
>+	.flags		= INET_PROTOSW_ICSK,
>+};
>+#endif /* CONFIG_IPV6 */
>+
>+static int smc_inet_init_sock(struct sock *sk)
>+{
>+	struct net *net = sock_net(sk);
>+
>+	/* init common smc sock */
>+	smc_sk_init(net, sk, IPPROTO_SMC);
>+	/* create clcsock */
>+	return smc_create_clcsk(net, sk, sk->sk_family);
>+}
>+
>+int __init smc_inet_init(void)
>+{
>+	int rc;
>+
>+	rc = proto_register(&smc_inet_prot, 1);
>+	if (rc) {
>+		pr_err("%s: proto_register smc_inet_prot fails with %d\n",
>+		       __func__, rc);
>+		return rc;
>+	}
>+	/* no return value */
>+	inet_register_protosw(&smc_inet_protosw);
>+
>+#if IS_ENABLED(CONFIG_IPV6)
>+	rc = proto_register(&smc_inet6_prot, 1);
>+	if (rc) {
>+		pr_err("%s: proto_register smc_inet6_prot fails with %d\n",
>+		       __func__, rc);
>+		goto out_inet6_prot;
>+	}
>+	rc = inet6_register_protosw(&smc_inet6_protosw);
>+	if (rc) {
>+		pr_err("%s: inet6_register_protosw smc_inet6_protosw fails with %d\n",
>+		       __func__, rc);
>+		goto out_inet6_protosw;
>+	}
>+	return rc;
>+out_inet6_protosw:
>+	proto_unregister(&smc_inet6_prot);
>+out_inet6_prot:
>+	inet_unregister_protosw(&smc_inet_protosw);
>+	proto_unregister(&smc_inet_prot);
>+#endif /* CONFIG_IPV6 */
>+	return rc;
>+}
>+
>+void smc_inet_exit(void)
>+{
>+#if IS_ENABLED(CONFIG_IPV6)
>+	inet6_unregister_protosw(&smc_inet6_protosw);
>+	proto_unregister(&smc_inet6_prot);
>+#endif /* CONFIG_IPV6 */
>+	inet_unregister_protosw(&smc_inet_protosw);
>+	proto_unregister(&smc_inet_prot);
>+}
>diff --git a/net/smc/smc_inet.h b/net/smc/smc_inet.h
>new file mode 100644
>index 00000000..a489c8a
>--- /dev/null
>+++ b/net/smc/smc_inet.h
>@@ -0,0 +1,22 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+/*
>+ *  Shared Memory Communications over RDMA (SMC-R) and RoCE
>+ *
>+ *  Definitions for the IPPROTO_SMC (socket related)
>+
>+ *  Copyright IBM Corp. 2016
>+ *  Copyright (c) 2024, Alibaba Inc.
>+ *
>+ *  Author: D. Wythe <alibuda@linux.alibaba.com>
>+ */
>+#ifndef __INET_SMC
>+#define __INET_SMC
>+
>+/* Initialize protocol registration on IPPROTO_SMC,
>+ * @return 0 on success
>+ */
>+int smc_inet_init(void);
>+
>+void smc_inet_exit(void);
>+
>+#endif /* __INET_SMC */
>-- 
>1.8.3.1
>

