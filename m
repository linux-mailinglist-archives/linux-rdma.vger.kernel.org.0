Return-Path: <linux-rdma+bounces-2674-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F858D3F2F
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 21:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE01CB235B6
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 19:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56651C68A0;
	Wed, 29 May 2024 19:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bE+r2ZsR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCD41C68A1;
	Wed, 29 May 2024 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717012526; cv=none; b=pbQIHxi0xF1hZiVF4WoGcfBwIj/OahBizYdMTNwR3VziydbdO7RolD693eWN4G5lxtzj3j79AK5npMGKL9Yi8hX1twnV4Ur2t8JGiRMS+Y98aCr1bnk0DlbheTMGwSCr5CiL2ZnmohEWz9k8pxrEL6XCIWoX1GucoECUqkLVv58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717012526; c=relaxed/simple;
	bh=ApC/B6tLetj4akMNnqYPmA7zf9tPiCWA8EXRP1O5oCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUuOkRqJE/AxuhTzOGSSNGYWxHDqwcyaP/SCEjbc43yjrI16kYY+GiRA0NGhqKUWolGSN9FpNvKRw1sX+UJr18lalk0vpvJq5Mgb8Uasn6MAkFjRMZCfCBbASn518qfcSHS2jswKRYKJ7kTx5y3og0WPO8C9qzmGIoACvMjdhbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bE+r2ZsR; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: alibuda@linux.alibaba.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717012520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WI2CAVHnGbnZf1U3RKyhNsTNXnXKfjaONqyiBv6AEhw=;
	b=bE+r2ZsRiUv6D0QUyMLjJtGssNLGe+EPzMAKmWrQ1BGlLHljan/XiR3MMNRB6RE4Rgp0qa
	AIlCZY5KMuhln2jd+MZW7nJdN21TPaCVsM2vuCnVWWarJFixiLSw/biB+6EMUEAjvwa4WF
	iYc8/0pbcV6RzuOwdDSrOzpcZ1Arwgk=
X-Envelope-To: kgraul@linux.ibm.com
X-Envelope-To: wenjia@linux.ibm.com
X-Envelope-To: jaka@linux.ibm.com
X-Envelope-To: wintera@linux.ibm.com
X-Envelope-To: guwen@linux.alibaba.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: davem@davemloft.net
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: linux-s390@vger.kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: tonylu@linux.alibaba.com
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: edumazet@google.com
Message-ID: <f7ad8072-a173-4d75-bbdd-775f31f6826f@linux.dev>
Date: Wed, 29 May 2024 21:55:15 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 3/3] net/smc: Introduce IPPROTO_SMC
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
 guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1716955147-88923-1-git-send-email-alibuda@linux.alibaba.com>
 <1716955147-88923-4-git-send-email-alibuda@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1716955147-88923-4-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/5/29 5:59, D. Wythe 写道:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> This patch allows to create smc socket via AF_INET,
> similar to the following code,
> 
> /* create v4 smc sock */
> v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
> 
> /* create v6 smc sock */
> v6 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
> 
> There are several reasons why we believe it is appropriate here:
> 
> 1. For smc sockets, it actually use IPv4 (AF-INET) or IPv6 (AF-INET6)
> address. There is no AF_SMC address at all.
> 
> 2. Create smc socket in the AF_INET(6) path, which allows us to reuse
> the infrastructure of AF_INET(6) path, such as common ebpf hooks.
> Otherwise, smc have to implement it again in AF_SMC path.
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>   include/uapi/linux/in.h |   2 +
>   net/smc/Makefile        |   2 +-
>   net/smc/af_smc.c        |  36 ++++++++++++++++
>   net/smc/inet_smc.c      | 108 ++++++++++++++++++++++++++++++++++++++++++++++++
>   net/smc/inet_smc.h      |  34 +++++++++++++++
>   5 files changed, 181 insertions(+), 1 deletion(-)
>   create mode 100644 net/smc/inet_smc.c
>   create mode 100644 net/smc/inet_smc.h
> 
> diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
> index e682ab6..0c6322b 100644
> --- a/include/uapi/linux/in.h
> +++ b/include/uapi/linux/in.h
> @@ -83,6 +83,8 @@ enum {
>   #define IPPROTO_RAW		IPPROTO_RAW
>     IPPROTO_MPTCP = 262,		/* Multipath TCP connection		*/
>   #define IPPROTO_MPTCP		IPPROTO_MPTCP
> +  IPPROTO_SMC = 263,		/* Shared Memory Communications		*/
> +#define IPPROTO_SMC		IPPROTO_SMC
>     IPPROTO_MAX
>   };
>   #endif
> diff --git a/net/smc/Makefile b/net/smc/Makefile
> index 2c510d54..472b9ee 100644
> --- a/net/smc/Makefile
> +++ b/net/smc/Makefile
> @@ -4,6 +4,6 @@ obj-$(CONFIG_SMC)	+= smc.o
>   obj-$(CONFIG_SMC_DIAG)	+= smc_diag.o
>   smc-y := af_smc.o smc_pnet.o smc_ib.o smc_clc.o smc_core.o smc_wr.o smc_llc.o
>   smc-y += smc_cdc.o smc_tx.o smc_rx.o smc_close.o smc_ism.o smc_netlink.o smc_stats.o
> -smc-y += smc_tracepoint.o
> +smc-y += smc_tracepoint.o inet_smc.o
>   smc-$(CONFIG_SYSCTL) += smc_sysctl.o
>   smc-$(CONFIG_SMC_LO) += smc_loopback.o
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 8e3ce76..320624c 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -54,6 +54,7 @@
>   #include "smc_tracepoint.h"
>   #include "smc_sysctl.h"
>   #include "smc_loopback.h"
> +#include "inet_smc.h"
>   
>   static DEFINE_MUTEX(smc_server_lgr_pending);	/* serialize link group
>   						 * creation on server
> @@ -3594,9 +3595,31 @@ static int __init smc_init(void)
>   		goto out_lo;
>   	}
>   
> +	rc = proto_register(&smc_inet_prot, 1);
> +	if (rc) {
> +		pr_err("%s: proto_register smc_inet_prot fails with %d\n", __func__, rc);
> +		goto out_ulp;
> +	}
> +	inet_register_protosw(&smc_inet_protosw);
> +#if IS_ENABLED(CONFIG_IPV6)
> +	rc = proto_register(&smc_inet6_prot, 1);
> +	if (rc) {
> +		pr_err("%s: proto_register smc_inet6_prot fails with %d\n", __func__, rc);
> +		goto out_inet_prot;
> +	}
> +	inet6_register_protosw(&smc_inet6_protosw);
> +#endif
> +
>   	static_branch_enable(&tcp_have_smc);
>   	return 0;
>   
> +#if IS_ENABLED(CONFIG_IPV6)
> +out_inet_prot:
> +	inet_unregister_protosw(&smc_inet_protosw);
> +	proto_unregister(&smc_inet_prot);
> +#endif
> +out_ulp:
> +	tcp_unregister_ulp(&smc_ulp_ops);
>   out_lo:
>   	smc_loopback_exit();
>   out_ib:
> @@ -3633,6 +3656,10 @@ static int __init smc_init(void)
>   static void __exit smc_exit(void)
>   {
>   	static_branch_disable(&tcp_have_smc);
> +	inet_unregister_protosw(&smc_inet_protosw);
> +#if IS_ENABLED(CONFIG_IPV6)
> +	inet6_unregister_protosw(&smc_inet6_protosw);
> +#endif
>   	tcp_unregister_ulp(&smc_ulp_ops);
>   	sock_unregister(PF_SMC);
>   	smc_core_exit();
> @@ -3644,6 +3671,10 @@ static void __exit smc_exit(void)
>   	destroy_workqueue(smc_hs_wq);
>   	proto_unregister(&smc_proto6);
>   	proto_unregister(&smc_proto);
> +	proto_unregister(&smc_inet_prot);
> +#if IS_ENABLED(CONFIG_IPV6)
> +	proto_unregister(&smc_inet6_prot);
> +#endif
>   	smc_pnet_exit();
>   	smc_nl_exit();
>   	smc_clc_exit();
> @@ -3660,4 +3691,9 @@ static void __exit smc_exit(void)
>   MODULE_LICENSE("GPL");
>   MODULE_ALIAS_NETPROTO(PF_SMC);
>   MODULE_ALIAS_TCP_ULP("smc");
> +/* 263 for IPPROTO_SMC and 1 for SOCK_STREAM */
> +MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET, 263, 1);
> +#if IS_ENABLED(CONFIG_IPV6)
> +MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET6, 263, 1);
> +#endif
>   MODULE_ALIAS_GENL_FAMILY(SMC_GENL_FAMILY_NAME);
> diff --git a/net/smc/inet_smc.c b/net/smc/inet_smc.c
> new file mode 100644
> index 00000000..1ba73d7
> --- /dev/null
> +++ b/net/smc/inet_smc.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  Shared Memory Communications over RDMA (SMC-R) and RoCE
> + *
> + *  Definitions for the IPPROTO_SMC (socket related)
> + *
> + *  Copyright IBM Corp. 2016, 2018
> + *  Copyright (c) 2024, Alibaba Inc.
> + *
> + *  Author: D. Wythe <alibuda@linux.alibaba.com>
> + */
> +
> +#include "inet_smc.h"
> +#include "smc.h"
> +
> +struct proto smc_inet_prot = {
> +	.name		= "INET_SMC",
> +	.owner		= THIS_MODULE,
> +	.init		= smc_inet_init_sock,
> +	.hash		= smc_hash_sk,
> +	.unhash		= smc_unhash_sk,
> +	.release_cb	= smc_release_cb,
> +	.obj_size	= sizeof(struct smc_sock),
> +	.h.smc_hash	= &smc_v4_hashinfo,
> +	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
> +};
> +
> +const struct proto_ops smc_inet_stream_ops = {
> +	.family		= PF_INET,
> +	.owner		= THIS_MODULE,
> +	.release	= smc_release,
> +	.bind		= smc_bind,
> +	.connect	= smc_connect,
> +	.socketpair	= sock_no_socketpair,
> +	.accept		= smc_accept,
> +	.getname	= smc_getname,
> +	.poll		= smc_poll,
> +	.ioctl		= smc_ioctl,
> +	.listen		= smc_listen,
> +	.shutdown	= smc_shutdown,
> +	.setsockopt	= smc_setsockopt,
> +	.getsockopt	= smc_getsockopt,
> +	.sendmsg	= smc_sendmsg,
> +	.recvmsg	= smc_recvmsg,
> +	.mmap		= sock_no_mmap,
> +	.splice_read	= smc_splice_read,
> +};
> +
> +struct inet_protosw smc_inet_protosw = {
> +	.type		= SOCK_STREAM,
> +	.protocol	= IPPROTO_SMC,
> +	.prot		= &smc_inet_prot,
> +	.ops		= &smc_inet_stream_ops,
> +	.flags		= INET_PROTOSW_ICSK,
> +};
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +struct proto smc_inet6_prot = {
> +	.name		= "INET6_SMC",
> +	.owner		= THIS_MODULE,
> +	.init		= smc_inet_init_sock,
> +	.hash		= smc_hash_sk,
> +	.unhash		= smc_unhash_sk,
> +	.release_cb	= smc_release_cb,
> +	.obj_size	= sizeof(struct smc_sock),
> +	.h.smc_hash	= &smc_v6_hashinfo,
> +	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
> +};
> +
> +const struct proto_ops smc_inet6_stream_ops = {
> +	.family		= PF_INET6,
> +	.owner		= THIS_MODULE,
> +	.release	= smc_release,
> +	.bind		= smc_bind,
> +	.connect	= smc_connect,
> +	.socketpair	= sock_no_socketpair,
> +	.accept		= smc_accept,
> +	.getname	= smc_getname,
> +	.poll		= smc_poll,
> +	.ioctl		= smc_ioctl,
> +	.listen		= smc_listen,
> +	.shutdown	= smc_shutdown,
> +	.setsockopt	= smc_setsockopt,
> +	.getsockopt	= smc_getsockopt,
> +	.sendmsg	= smc_sendmsg,
> +	.recvmsg	= smc_recvmsg,
> +	.mmap		= sock_no_mmap,
> +	.splice_read	= smc_splice_read,
> +};
> +
> +struct inet_protosw smc_inet6_protosw = {
> +	.type		= SOCK_STREAM,
> +	.protocol	= IPPROTO_SMC,
> +	.prot		= &smc_inet6_prot,
> +	.ops		= &smc_inet6_stream_ops,
> +	.flags		= INET_PROTOSW_ICSK,
> +};
> +#endif
> +
> +int smc_inet_init_sock(struct sock *sk)
> +{
> +	struct net *net = sock_net(sk);
> +
> +	/* init common smc sock */
> +	smc_sk_init(net, sk, IPPROTO_SMC);
> +	/* create clcsock */
> +	return smc_create_clcsk(net, sk, sk->sk_family);
> +}
> diff --git a/net/smc/inet_smc.h b/net/smc/inet_smc.h
> new file mode 100644
> index 00000000..c55345d
> --- /dev/null
> +++ b/net/smc/inet_smc.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  Shared Memory Communications over RDMA (SMC-R) and RoCE
> + *
> + *  Definitions for the IPPROTO_SMC (socket related)
> +
> + *  Copyright IBM Corp. 2016
> + *  Copyright (c) 2024, Alibaba Inc.
> + *
> + *  Author: D. Wythe <alibuda@linux.alibaba.com>
> + */
> +#ifndef __INET_SMC
> +#define __INET_SMC
> +
> +#include <net/protocol.h>
> +#include <net/sock.h>
> +#include <net/tcp.h>
> +
> +extern struct proto smc_inet_prot;
> +extern const struct proto_ops smc_inet_stream_ops;
> +extern struct inet_protosw smc_inet_protosw;
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +#include <net/ipv6.h>
> +/* MUST after net/tcp.h or warning */
> +#include <net/transp_v6.h>
> +extern struct proto smc_inet6_prot;
> +extern const struct proto_ops smc_inet6_stream_ops;
> +extern struct inet_protosw smc_inet6_protosw;
> +#endif

If we append /* CONFIG_IPV6 */ to #endif to indicate that it is the end 
of CONFIG_IPV6, it is a good habit. When browsing the source code, it is 
easy for us to know that it is the end of CONFIG_IPV6.
Just my 2 cent suggestions. It is a trivial problem. You can ignore it.
But if you fix it, it can make the source code more readable.

Zhu Yanjun

> +
> +int smc_inet_init_sock(struct sock *sk);
> +
> +#endif /* __INET_SMC */


