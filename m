Return-Path: <linux-rdma+bounces-2677-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 430B08D43DD
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 04:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646661C22FA7
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 02:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2EA1BF31;
	Thu, 30 May 2024 02:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cneZ+Xet"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EC18F4A;
	Thu, 30 May 2024 02:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717037479; cv=none; b=J7d0sc0S+i1eET6A3NY+eFCOJb0rjFeED9HO+vMPoJgLGCUZXwfB4fcI9b1CGstHAsO9zdDsO2+RpqIy7zy3kLRdDGkTM9zYu2nH0TyNMmzgtLo/JOrxeMm9/leOrJ/BVuD8cPHMgrgTHsPbJ6k41dW/MnzHk3rxiQbIPi3UeOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717037479; c=relaxed/simple;
	bh=lr7aYZdXmjuN5ocIYwBUc+AkSxcWfqkwln4akezJKDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktUpfJK2MsSBbvPPvR/7eqocKe2/pPgNuj9u0nmvueaIhgssO7GPgE+y6vCrncZOTlxohjgFZObd0OJ5CPQFddlHW40VJnHEz+ygLkDQucpP7JOe4Pu7+vDVcmDpcUBwG2zHYG2BkU7UWzZu1iHHvguf7vCKMpB8hCvxX+7RVgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cneZ+Xet; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717037473; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WE2w20DPjBcab3ELDcShSVkSZp/3CCT8/dpCQS3EgyA=;
	b=cneZ+Xet8AgzJHObtmZ6fkz2D5iADkI7DYzGfKUAnaK9Z6FN0Ct+FmU5KOO+FfGKxp4fYydhWBCqZNWHHjNul2UvNoe5FTuzre09He6UK8MZLZjeHQYe0RTH0bqv9HjBetJMMBxsMoQIfQxK8jy8zrhJOUehemgHeOsthOglt4c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W7VKfAj_1717037472;
Received: from 30.221.146.99(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W7VKfAj_1717037472)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 10:51:12 +0800
Message-ID: <95d94f6c-a77f-45c3-9889-77620efcdbff@linux.alibaba.com>
Date: Thu, 30 May 2024 10:51:10 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/3] net/smc: Introduce IPPROTO_SMC
To: Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com,
 jaka@linux.ibm.com, wintera@linux.ibm.com, guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1716955147-88923-1-git-send-email-alibuda@linux.alibaba.com>
 <1716955147-88923-4-git-send-email-alibuda@linux.alibaba.com>
 <ea8194ec-6583-40f1-912a-a612a6509566@linux.ibm.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <ea8194ec-6583-40f1-912a-a612a6509566@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/29/24 7:58 PM, Wenjia Zhang wrote:
>
>
> On 29.05.24 05:59, D. Wythe wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> This patch allows to create smc socket via AF_INET,
>> similar to the following code,
>>
>> /* create v4 smc sock */
>> v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
>>
>> /* create v6 smc sock */
>> v6 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
>>
>> There are several reasons why we believe it is appropriate here:
>>
>> 1. For smc sockets, it actually use IPv4 (AF-INET) or IPv6 (AF-INET6)
>> address. There is no AF_SMC address at all.
>>
>> 2. Create smc socket in the AF_INET(6) path, which allows us to reuse
>> the infrastructure of AF_INET(6) path, such as common ebpf hooks.
>> Otherwise, smc have to implement it again in AF_SMC path.
>>
>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>> ---
>>   include/uapi/linux/in.h |   2 +
>>   net/smc/Makefile        |   2 +-
>>   net/smc/af_smc.c        |  36 ++++++++++++++++
>>   net/smc/inet_smc.c      | 108 
>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>   net/smc/inet_smc.h      |  34 +++++++++++++++
>>   5 files changed, 181 insertions(+), 1 deletion(-)
>>   create mode 100644 net/smc/inet_smc.c
>>   create mode 100644 net/smc/inet_smc.h
>>
>> diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
>> index e682ab6..0c6322b 100644
>> --- a/include/uapi/linux/in.h
>> +++ b/include/uapi/linux/in.h
>> @@ -83,6 +83,8 @@ enum {
>>   #define IPPROTO_RAW        IPPROTO_RAW
>>     IPPROTO_MPTCP = 262,        /* Multipath TCP connection        */
>>   #define IPPROTO_MPTCP        IPPROTO_MPTCP
>> +  IPPROTO_SMC = 263,        /* Shared Memory Communications        */
>> +#define IPPROTO_SMC        IPPROTO_SMC
>>     IPPROTO_MAX
>>   };
>>   #endif
>> diff --git a/net/smc/Makefile b/net/smc/Makefile
>> index 2c510d54..472b9ee 100644
>> --- a/net/smc/Makefile
>> +++ b/net/smc/Makefile
>> @@ -4,6 +4,6 @@ obj-$(CONFIG_SMC)    += smc.o
>>   obj-$(CONFIG_SMC_DIAG)    += smc_diag.o
>>   smc-y := af_smc.o smc_pnet.o smc_ib.o smc_clc.o smc_core.o smc_wr.o 
>> smc_llc.o
>>   smc-y += smc_cdc.o smc_tx.o smc_rx.o smc_close.o smc_ism.o 
>> smc_netlink.o smc_stats.o
>> -smc-y += smc_tracepoint.o
>> +smc-y += smc_tracepoint.o inet_smc.o
>>   smc-$(CONFIG_SYSCTL) += smc_sysctl.o
>>   smc-$(CONFIG_SMC_LO) += smc_loopback.o
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index 8e3ce76..320624c 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -54,6 +54,7 @@
>>   #include "smc_tracepoint.h"
>>   #include "smc_sysctl.h"
>>   #include "smc_loopback.h"
>> +#include "inet_smc.h"
>>     static DEFINE_MUTEX(smc_server_lgr_pending);    /* serialize link 
>> group
>>                            * creation on server
>> @@ -3594,9 +3595,31 @@ static int __init smc_init(void)
>>           goto out_lo;
>>       }
>>   +    rc = proto_register(&smc_inet_prot, 1);
>> +    if (rc) {
>> +        pr_err("%s: proto_register smc_inet_prot fails with %d\n", 
>> __func__, rc);
>> +        goto out_ulp;
>> +    }
>> +    inet_register_protosw(&smc_inet_protosw);
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +    rc = proto_register(&smc_inet6_prot, 1);
>> +    if (rc) {
>> +        pr_err("%s: proto_register smc_inet6_prot fails with %d\n", 
>> __func__, rc);
>> +        goto out_inet_prot;
>> +    }
>> +    inet6_register_protosw(&smc_inet6_protosw);
>
> Comparing to inet_register_protosw(), the inet6_register_protosw() 
> returns an integer. Thus, making error check and direct corresponding 
> housekeeping here looks IMO much cleaner.
>
Oops... I was under the impression that it had no return. In the prior 
RFC, I even commented that it had no return. Quite the oversight on my part.

>> +#endif
>> +
>>       static_branch_enable(&tcp_have_smc);
>>       return 0;
>>   +#if IS_ENABLED(CONFIG_IPV6)
>> +out_inet_prot:
>> +    inet_unregister_protosw(&smc_inet_protosw);
>> +    proto_unregister(&smc_inet_prot);
>> +#endif
>> +out_ulp:
>> +    tcp_unregister_ulp(&smc_ulp_ops);
>>   out_lo:
>>       smc_loopback_exit();
>>   out_ib:
>> @@ -3633,6 +3656,10 @@ static int __init smc_init(void)
>>   static void __exit smc_exit(void)
>>   {
>>       static_branch_disable(&tcp_have_smc);
>> +    inet_unregister_protosw(&smc_inet_protosw);
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +    inet6_unregister_protosw(&smc_inet6_protosw);
>> +#endif
>>       tcp_unregister_ulp(&smc_ulp_ops);
>>       sock_unregister(PF_SMC);
>>       smc_core_exit();
>> @@ -3644,6 +3671,10 @@ static void __exit smc_exit(void)
>>       destroy_workqueue(smc_hs_wq);
>>       proto_unregister(&smc_proto6);
>>       proto_unregister(&smc_proto);
>> +    proto_unregister(&smc_inet_prot);
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +    proto_unregister(&smc_inet6_prot);
>> +#end
>
> Since there is already inet_smc.c, I'd recommend to group these 
> register and unregister stuff respectively in functions like e.g. 
> smc_inet_init() and smc_inet_exit() in inet_smc.c
>

Agreed, I also see similar opinions from the community, and I will 
improve it in the next version.


>>       smc_pnet_exit();
>>       smc_nl_exit();
>>       smc_clc_exit();
>> @@ -3660,4 +3691,9 @@ static void __exit smc_exit(void)
>>   MODULE_LICENSE("GPL");
>>   MODULE_ALIAS_NETPROTO(PF_SMC);
>>   MODULE_ALIAS_TCP_ULP("smc");
>> +/* 263 for IPPROTO_SMC and 1 for SOCK_STREAM */
>> +MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET, 263, 1);
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET6, 263, 1);
>> +#endif
>>   MODULE_ALIAS_GENL_FAMILY(SMC_GENL_FAMILY_NAME);
>> diff --git a/net/smc/inet_smc.c b/net/smc/inet_smc.c
>> new file mode 100644
>> index 00000000..1ba73d7
>> --- /dev/null
>> +++ b/net/smc/inet_smc.c
>
> In order to keep the consistency with the structure and function names 
> in the files, I'm wondering why not to use smc_inet.h and smc_inet.c
> instead of inet_smc.h and inet_smc.c respectively

That's because I am trying to keep the name style to be consistent with 
af_smc.c. But I don't insist on this, using smc_inet
is also good for me.

Thanks,
D. Wythe

>
>> @@ -0,0 +1,108 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + *  Shared Memory Communications over RDMA (SMC-R) and RoCE
>> + *
>> + *  Definitions for the IPPROTO_SMC (socket related)
>> + *
>> + *  Copyright IBM Corp. 2016, 2018
>> + *  Copyright (c) 2024, Alibaba Inc.
>> + *
>> + *  Author: D. Wythe <alibuda@linux.alibaba.com>
>> + */
>> +
>> +#include "inet_smc.h"
>> +#include "smc.h"
>> +
>> +struct proto smc_inet_prot = {
>> +    .name        = "INET_SMC",
>> +    .owner        = THIS_MODULE,
>> +    .init        = smc_inet_init_sock,
>> +    .hash        = smc_hash_sk,
>> +    .unhash        = smc_unhash_sk,
>> +    .release_cb    = smc_release_cb,
>> +    .obj_size    = sizeof(struct smc_sock),
>> +    .h.smc_hash    = &smc_v4_hashinfo,
>> +    .slab_flags    = SLAB_TYPESAFE_BY_RCU,
>> +};
>> +
>> +const struct proto_ops smc_inet_stream_ops = {
>> +    .family        = PF_INET,
>> +    .owner        = THIS_MODULE,
>> +    .release    = smc_release,
>> +    .bind        = smc_bind,
>> +    .connect    = smc_connect,
>> +    .socketpair    = sock_no_socketpair,
>> +    .accept        = smc_accept,
>> +    .getname    = smc_getname,
>> +    .poll        = smc_poll,
>> +    .ioctl        = smc_ioctl,
>> +    .listen        = smc_listen,
>> +    .shutdown    = smc_shutdown,
>> +    .setsockopt    = smc_setsockopt,
>> +    .getsockopt    = smc_getsockopt,
>> +    .sendmsg    = smc_sendmsg,
>> +    .recvmsg    = smc_recvmsg,
>> +    .mmap        = sock_no_mmap,
>> +    .splice_read    = smc_splice_read,
>> +};
>> +
>> +struct inet_protosw smc_inet_protosw = {
>> +    .type        = SOCK_STREAM,
>> +    .protocol    = IPPROTO_SMC,
>> +    .prot        = &smc_inet_prot,
>> +    .ops        = &smc_inet_stream_ops,
>> +    .flags        = INET_PROTOSW_ICSK,
>> +};
>> +
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +struct proto smc_inet6_prot = {
>> +    .name        = "INET6_SMC",
>> +    .owner        = THIS_MODULE,
>> +    .init        = smc_inet_init_sock,
>> +    .hash        = smc_hash_sk,
>> +    .unhash        = smc_unhash_sk,
>> +    .release_cb    = smc_release_cb,
>> +    .obj_size    = sizeof(struct smc_sock),
>> +    .h.smc_hash    = &smc_v6_hashinfo,
>> +    .slab_flags    = SLAB_TYPESAFE_BY_RCU,
>> +};
>> +
>> +const struct proto_ops smc_inet6_stream_ops = {
>> +    .family        = PF_INET6,
>> +    .owner        = THIS_MODULE,
>> +    .release    = smc_release,
>> +    .bind        = smc_bind,
>> +    .connect    = smc_connect,
>> +    .socketpair    = sock_no_socketpair,
>> +    .accept        = smc_accept,
>> +    .getname    = smc_getname,
>> +    .poll        = smc_poll,
>> +    .ioctl        = smc_ioctl,
>> +    .listen        = smc_listen,
>> +    .shutdown    = smc_shutdown,
>> +    .setsockopt    = smc_setsockopt,
>> +    .getsockopt    = smc_getsockopt,
>> +    .sendmsg    = smc_sendmsg,
>> +    .recvmsg    = smc_recvmsg,
>> +    .mmap        = sock_no_mmap,
>> +    .splice_read    = smc_splice_read,
>> +};
>> +
>> +struct inet_protosw smc_inet6_protosw = {
>> +    .type        = SOCK_STREAM,
>> +    .protocol    = IPPROTO_SMC,
>> +    .prot        = &smc_inet6_prot,
>> +    .ops        = &smc_inet6_stream_ops,
>> +    .flags        = INET_PROTOSW_ICSK,
>> +};
>> +#endif
>> +
>> +int smc_inet_init_sock(struct sock *sk)
>> +{
>> +    struct net *net = sock_net(sk);
>> +
>> +    /* init common smc sock */
>> +    smc_sk_init(net, sk, IPPROTO_SMC);
>> +    /* create clcsock */
>> +    return smc_create_clcsk(net, sk, sk->sk_family);
>> +}
>> diff --git a/net/smc/inet_smc.h b/net/smc/inet_smc.h
>> new file mode 100644
>> index 00000000..c55345d
>> --- /dev/null
>> +++ b/net/smc/inet_smc.h
>> @@ -0,0 +1,34 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + *  Shared Memory Communications over RDMA (SMC-R) and RoCE
>> + *
>> + *  Definitions for the IPPROTO_SMC (socket related)
>> +
>> + *  Copyright IBM Corp. 2016
>> + *  Copyright (c) 2024, Alibaba Inc.
>> + *
>> + *  Author: D. Wythe <alibuda@linux.alibaba.com>
>> + */
>> +#ifndef __INET_SMC
>> +#define __INET_SMC
>> +
>> +#include <net/protocol.h>
>> +#include <net/sock.h>
>> +#include <net/tcp.h>
>> +
>> +extern struct proto smc_inet_prot;
>> +extern const struct proto_ops smc_inet_stream_ops;
>> +extern struct inet_protosw smc_inet_protosw;
>> +
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +#include <net/ipv6.h>
>> +/* MUST after net/tcp.h or warning */
>> +#include <net/transp_v6.h>
>> +extern struct proto smc_inet6_prot;
>> +extern const struct proto_ops smc_inet6_stream_ops;
>> +extern struct inet_protosw smc_inet6_protosw;
>> +#endif
>> +
>> +int smc_inet_init_sock(struct sock *sk);
>> +
>> +#endif /* __INET_SMC */


