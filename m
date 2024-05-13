Return-Path: <linux-rdma+bounces-2443-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B298C3A6E
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 05:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC6B281385
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 03:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76590145B20;
	Mon, 13 May 2024 03:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ALzBAkQE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86591C6AF;
	Mon, 13 May 2024 03:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715570555; cv=none; b=FE0G5kW2Y0LVfJGKGRpyAx1bUZvdzmTql9Q/EuZfhGkHBxxekwz3rKTD8SNHNHZhwx24Ogp9mUeccotBbkzz7PHcd/8zrwqIqEf3k9bYKHEt+PIqwo22Mtsmflxhb0d3vFKSvBdcXaHUVc1lGAlrwkmd+spAGHTMyw7UY0EuBDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715570555; c=relaxed/simple;
	bh=158n1jQPgG/o/3jlOTda9lV/7ihfFB/4Br3Dc2PDJzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5Sv4hh2ha/WDQVT5H9kaJC/W6mE/UyiklDvsYluZeiZZC3/xMsSO9ckoEYUJpcqmd2ZpLSzs6aZCkQWzvc7OcfC4fjDMNuGoWUQ992KEhbi/038RSJ82eEnj7VqYQnwgi6kRSa5qsvrMD924rYOpgFrr4y9A5GXNRf8RCmSs/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ALzBAkQE; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715570542; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=s15C9g0InwhlKvDrzOTm7wKTSvHQm/d0u/XuRgKojDQ=;
	b=ALzBAkQE4p7nAhpFMt+vg6i6zb45g5UREusH2Evd5C37b402b/iWUi/cww3799nQkIRe3QB11b1iwV9us9uFjPgWUfvDJbsOzUfdekoJECRq0QMzzXpEJqElDw2cDtOc6jRtD6WYixbzOuZfaofMjkfw3EaU5pJxbTcMmULopCk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6H5ntU_1715570540;
Received: from 30.221.147.113(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W6H5ntU_1715570540)
          by smtp.aliyun-inc.com;
          Mon, 13 May 2024 11:22:21 +0800
Message-ID: <52825ab1-9162-422b-93f7-5981e3b6ad78@linux.alibaba.com>
Date: Mon, 13 May 2024 11:22:18 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net/smc: refatoring initialization of smc
 sock
To: Zhu Yanjun <yanjun.zhu@linux.dev>, kgraul@linux.ibm.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
 guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1715314333-107290-1-git-send-email-alibuda@linux.alibaba.com>
 <1715314333-107290-2-git-send-email-alibuda@linux.alibaba.com>
 <11f7d33c-80b1-40db-87c0-566ed24c389e@linux.dev>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <11f7d33c-80b1-40db-87c0-566ed24c389e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/11/24 8:21 PM, Zhu Yanjun wrote:
> 在 2024/5/10 6:12, D. Wythe 写道:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> This patch aims to isolate the shared components of SMC socket
>> allocation by introducing smc_sock_init() for sock initialization
>> and __smc_create_clcsk() for the initialization of clcsock.
>>
>> This is in preparation for the subsequent implementation of the
>> AF_INET version of SMC.
>>
>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>> ---
>>   net/smc/af_smc.c | 93 
>> +++++++++++++++++++++++++++++++-------------------------
>>   1 file changed, 52 insertions(+), 41 deletions(-)
>>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index 9389f0c..1f03724 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -361,34 +361,43 @@ static void smc_destruct(struct sock *sk)
>>           return;
>>   }
>>   -static struct sock *smc_sock_alloc(struct net *net, struct socket 
>> *sock,
>> -                   int protocol)
>> +static void smc_sock_init(struct net *net, struct sock *sk, int 
>> protocol)
>>   {
>> -    struct smc_sock *smc;
>> -    struct proto *prot;
>> -    struct sock *sk;
>> -
>> -    prot = (protocol == SMCPROTO_SMC6) ? &smc_proto6 : &smc_proto;
>> -    sk = sk_alloc(net, PF_SMC, GFP_KERNEL, prot, 0);
>> -    if (!sk)
>> -        return NULL;
>> +    struct smc_sock *smc = smc_sk(sk);
>>   -    sock_init_data(sock, sk); /* sets sk_refcnt to 1 */
>>       sk->sk_state = SMC_INIT;
>> -    sk->sk_destruct = smc_destruct;
>>       sk->sk_protocol = protocol;
>> +    mutex_init(&smc->clcsock_release_lock);
>
> Please add mutex_destroy(&smc->clcsock_release_lock); when 
> smc->clcsock_release_lock is no longer used.
>
> Or else some tools will notify errors.
>
> Zhu Yanjun


It seems that the problem you mentioned is not caused by this patch, 
after all, this patch is solely for refactoring.
Adding the fix you mentioned in this refactoring patch would not be 
appropriate. Perhaps, you could submit a separate
patch to address the issue. What do you think?

D. Wythe

>
>>       WRITE_ONCE(sk->sk_sndbuf, 2 * READ_ONCE(net->smc.sysctl_wmem));
>>       WRITE_ONCE(sk->sk_rcvbuf, 2 * READ_ONCE(net->smc.sysctl_rmem));
>> -    smc = smc_sk(sk);
>>       INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
>>       INIT_WORK(&smc->connect_work, smc_connect_work);
>>       INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);
>>       INIT_LIST_HEAD(&smc->accept_q);
>>       spin_lock_init(&smc->accept_q_lock);
>>       spin_lock_init(&smc->conn.send_lock);
>> -    sk->sk_prot->hash(sk);
>> -    mutex_init(&smc->clcsock_release_lock);
>>       smc_init_saved_callbacks(smc);
>> +    smc->limit_smc_hs = net->smc.limit_smc_hs;
>> +    smc->use_fallback = false; /* assume rdma capability first */
>> +    smc->fallback_rsn = 0;
>> +
>> +    sk->sk_destruct = smc_destruct;
>> +    sk->sk_prot->hash(sk);
>> +}
>> +
>> +static struct sock *smc_sock_alloc(struct net *net, struct socket 
>> *sock,
>> +                   int protocol)
>> +{
>> +    struct proto *prot;
>> +    struct sock *sk;
>> +
>> +    prot = (protocol == SMCPROTO_SMC6) ? &smc_proto6 : &smc_proto;
>> +    sk = sk_alloc(net, PF_SMC, GFP_KERNEL, prot, 0);
>> +    if (!sk)
>> +        return NULL;
>> +
>> +    sock_init_data(sock, sk); /* sets sk_refcnt to 1 */
>> +    smc_sock_init(net, sk, protocol);
>>         return sk;
>>   }
>> @@ -3321,6 +3330,31 @@ static ssize_t smc_splice_read(struct socket 
>> *sock, loff_t *ppos,
>>       .splice_read    = smc_splice_read,
>>   };
>>   +static int __smc_create_clcsk(struct net *net, struct sock *sk, 
>> int family)
>> +{
>> +    struct smc_sock *smc = smc_sk(sk);
>> +    int rc;
>> +
>> +    rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
>> +                  &smc->clcsock);
>> +    if (rc) {
>> +        sk_common_release(sk);
>> +        return rc;
>> +    }
>> +
>> +    /* smc_clcsock_release() does not wait smc->clcsock->sk's
>> +     * destruction;  its sk_state might not be TCP_CLOSE after
>> +     * smc->sk is close()d, and TCP timers can be fired later,
>> +     * which need net ref.
>> +     */
>> +    sk = smc->clcsock->sk;
>> +    __netns_tracker_free(net, &sk->ns_tracker, false);
>> +    sk->sk_net_refcnt = 1;
>> +    get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
>> +    sock_inuse_add(net, 1);
>> +    return 0;
>> +}
>> +
>>   static int __smc_create(struct net *net, struct socket *sock, int 
>> protocol,
>>               int kern, struct socket *clcsock)
>>   {
>> @@ -3346,35 +3380,12 @@ static int __smc_create(struct net *net, 
>> struct socket *sock, int protocol,
>>         /* create internal TCP socket for CLC handshake and fallback */
>>       smc = smc_sk(sk);
>> -    smc->use_fallback = false; /* assume rdma capability first */
>> -    smc->fallback_rsn = 0;
>> -
>> -    /* default behavior from limit_smc_hs in every net namespace */
>> -    smc->limit_smc_hs = net->smc.limit_smc_hs;
>>         rc = 0;
>> -    if (!clcsock) {
>> -        rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
>> -                      &smc->clcsock);
>> -        if (rc) {
>> -            sk_common_release(sk);
>> -            goto out;
>> -        }
>> -
>> -        /* smc_clcsock_release() does not wait smc->clcsock->sk's
>> -         * destruction;  its sk_state might not be TCP_CLOSE after
>> -         * smc->sk is close()d, and TCP timers can be fired later,
>> -         * which need net ref.
>> -         */
>> -        sk = smc->clcsock->sk;
>> -        __netns_tracker_free(net, &sk->ns_tracker, false);
>> -        sk->sk_net_refcnt = 1;
>> -        get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
>> -        sock_inuse_add(net, 1);
>> -    } else {
>> +    if (!clcsock)
>> +        rc = __smc_create_clcsk(net, sk, family);
>> +    else
>>           smc->clcsock = clcsock;
>> -    }
>> -
>>   out:
>>       return rc;
>>   }


