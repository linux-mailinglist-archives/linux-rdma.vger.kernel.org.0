Return-Path: <linux-rdma+bounces-2645-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82478D2AEA
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 04:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2431F24C82
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 02:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6812215B0E5;
	Wed, 29 May 2024 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Bu+hDgvm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4818917E8F0;
	Wed, 29 May 2024 02:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716950207; cv=none; b=YIYkjrNNIJBGU9U+te2cfhg2Q/gSDd9tEqgzdfitix+YFIMCMhj59iUFykfqONa1b4rc+3O7Pachc0Or76ej5nl2a44fxz7FTvRn1KmWMIJgZROGLt1ev0G97iFcJfXAHwwzqF2+4ie0arMtCDkavnjuIN6odIQd1CDcIESu2m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716950207; c=relaxed/simple;
	bh=/prjtynIALKef+NidgM/TwteCz1yQxr8kvZyr3UStrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OKI0391PdqOAjQqNfIYLgn/0zVGQhF29frghFzPaRtylir4+TZg9qPIzWjDPeneNmxApp64JcA4LTtKGS7bNQh7CABjIkeTNuoDTv7UeXm5D3llBcm8YNkAekjns1erhZ/Aa/ZlHrCuqmPLuwrGrJA7AkIo46t7NNDINxO/XUrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Bu+hDgvm; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716950195; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kTh5iBvwSDqWZxPNhWhI/gl1LaGJ95imBRViouswUz4=;
	b=Bu+hDgvmthSpldJVDVjLPPBnrUJYBlR4QWV042hurObHkhGzxEBXXqtvELZtiae0zs+jHZPfTF2Vln+HCYkktfa7H0rBMZ4lcKDfoc4vYwB7RFSwmlIFVXpK5jsVO8KURekciZ9QtDre6OSGiuvtbLB/0icI9u1CgObbs7UxTl0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W7R7OGN_1716950194;
Received: from 30.221.145.238(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W7R7OGN_1716950194)
          by smtp.aliyun-inc.com;
          Wed, 29 May 2024 10:36:35 +0800
Message-ID: <5bb36a9c-6f2e-4d60-a210-fd2c01da5b60@linux.alibaba.com>
Date: Wed, 29 May 2024 10:36:33 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/3] net/smc: refatoring initialization of smc
 sock
To: Tony Lu <tonylu@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 wintera@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, pabeni@redhat.com, edumazet@google.com
References: <1716863394-112399-1-git-send-email-alibuda@linux.alibaba.com>
 <1716863394-112399-2-git-send-email-alibuda@linux.alibaba.com>
 <ZlVJib8rRvwPJJJi@TONYMAC-ALIBABA.local>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <ZlVJib8rRvwPJJJi@TONYMAC-ALIBABA.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/28/24 11:03 AM, Tony Lu wrote:
> In subject, refatoring -> refactoring.

Oops... thanks for that.

>
> On Tue, May 28, 2024 at 10:29:52AM +0800, D. Wythe wrote:
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
>>   net/smc/af_smc.c | 86 +++++++++++++++++++++++++++++++-------------------------
>>   net/smc/smc.h    |  5 ++++
>>   2 files changed, 53 insertions(+), 38 deletions(-)
>>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index 9389f0c..d8c116e 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -361,25 +361,15 @@ static void smc_destruct(struct sock *sk)
>>   		return;
>>   }
>>   
>> -static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
>> -				   int protocol)
>> +void smc_sock_init(struct net *net, struct sock *sk, int protocol)
>              ^^^^                       ^^^^^^^^^^^^^^^^
>
> Using smc_sk_init to align the others' name style.

Make sense, I will do it in the next version.


>>   {
>> -	struct smc_sock *smc;
>> -	struct proto *prot;
>> -	struct sock *sk;
>> -
>> -	prot = (protocol == SMCPROTO_SMC6) ? &smc_proto6 : &smc_proto;
>> -	sk = sk_alloc(net, PF_SMC, GFP_KERNEL, prot, 0);
>> -	if (!sk)
>> -		return NULL;
>> +	struct smc_sock *smc = smc_sk(sk);
>>   
>> -	sock_init_data(sock, sk); /* sets sk_refcnt to 1 */
>>   	sk->sk_state = SMC_INIT;
>>   	sk->sk_destruct = smc_destruct;
>>   	sk->sk_protocol = protocol;
>>   	WRITE_ONCE(sk->sk_sndbuf, 2 * READ_ONCE(net->smc.sysctl_wmem));
>>   	WRITE_ONCE(sk->sk_rcvbuf, 2 * READ_ONCE(net->smc.sysctl_rmem));
>> -	smc = smc_sk(sk);
>>   	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
>>   	INIT_WORK(&smc->connect_work, smc_connect_work);
>>   	INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);
>> @@ -389,6 +379,24 @@ static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
>>   	sk->sk_prot->hash(sk);
>>   	mutex_init(&smc->clcsock_release_lock);
>>   	smc_init_saved_callbacks(smc);
>> +	smc->limit_smc_hs = net->smc.limit_smc_hs;
>> +	smc->use_fallback = false; /* assume rdma capability first */
>> +	smc->fallback_rsn = 0;
>> +}
>> +
>> +static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
>> +				   int protocol)
>> +{
>> +	struct proto *prot;
>> +	struct sock *sk;
>> +
>> +	prot = (protocol == SMCPROTO_SMC6) ? &smc_proto6 : &smc_proto;
>> +	sk = sk_alloc(net, PF_SMC, GFP_KERNEL, prot, 0);
>> +	if (!sk)
>> +		return NULL;
>> +
>> +	sock_init_data(sock, sk); /* sets sk_refcnt to 1 */
>> +	smc_sock_init(net, sk, protocol);
>>   
>>   	return sk;
>>   }
>> @@ -3321,6 +3329,31 @@ static ssize_t smc_splice_read(struct socket *sock, loff_t *ppos,
>>   	.splice_read	= smc_splice_read,
>>   };
>>   
>> +int smc_create_clcsk(struct net *net, struct sock *sk, int family)
>> +{
>> +	struct smc_sock *smc = smc_sk(sk);
>> +	int rc;
>> +
>> +	rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
>> +			      &smc->clcsock);
>> +	if (rc) {
>> +		sk_common_release(sk);
>> +		return rc;
>> +	}
>> +
>> +	/* smc_clcsock_release() does not wait smc->clcsock->sk's
>> +	 * destruction;  its sk_state might not be TCP_CLOSE after
>> +	 * smc->sk is close()d, and TCP timers can be fired later,
>> +	 * which need net ref.
>> +	 */
>> +	sk = smc->clcsock->sk;
>> +	__netns_tracker_free(net, &sk->ns_tracker, false);
>> +	sk->sk_net_refcnt = 1;
>> +	get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
>> +	sock_inuse_add(net, 1);
>> +	return 0;
>> +}
>> +
>>   static int __smc_create(struct net *net, struct socket *sock, int protocol,
>>   			int kern, struct socket *clcsock)
>>   {
>> @@ -3346,35 +3379,12 @@ static int __smc_create(struct net *net, struct socket *sock, int protocol,
>>   
>>   	/* create internal TCP socket for CLC handshake and fallback */
>>   	smc = smc_sk(sk);
>> -	smc->use_fallback = false; /* assume rdma capability first */
>> -	smc->fallback_rsn = 0;
>> -
>> -	/* default behavior from limit_smc_hs in every net namespace */
>> -	smc->limit_smc_hs = net->smc.limit_smc_hs;
>>   
>>   	rc = 0;
>> -	if (!clcsock) {
>> -		rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
>> -				      &smc->clcsock);
>> -		if (rc) {
>> -			sk_common_release(sk);
>> -			goto out;
>> -		}
>> -
>> -		/* smc_clcsock_release() does not wait smc->clcsock->sk's
>> -		 * destruction;  its sk_state might not be TCP_CLOSE after
>> -		 * smc->sk is close()d, and TCP timers can be fired later,
>> -		 * which need net ref.
>> -		 */
>> -		sk = smc->clcsock->sk;
>> -		__netns_tracker_free(net, &sk->ns_tracker, false);
>> -		sk->sk_net_refcnt = 1;
>> -		get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
>> -		sock_inuse_add(net, 1);
>> -	} else {
>> +	if (!clcsock)
>> +		rc = smc_create_clcsk(net, sk, family);
>> +	else
>>   		smc->clcsock = clcsock;
>> -	}
> Using if (clcsock) is more intuitive.

Sounds reasonable. I'll take it.


Thanks,
D. Wythe


>> -
>>   out:
>>   	return rc;
>>   }
>> diff --git a/net/smc/smc.h b/net/smc/smc.h
>> index 18c8b78..a0accb5 100644
>> --- a/net/smc/smc.h
>> +++ b/net/smc/smc.h
>> @@ -34,6 +34,11 @@
>>   extern struct proto smc_proto;
>>   extern struct proto smc_proto6;
>>   
>> +/* smc sock initialization */
>> +void smc_sock_init(struct net *net, struct sock *sk, int protocol);
>> +/* clcsock initialization */
>> +int smc_create_clcsk(struct net *net, struct sock *sk, int family);
>> +
>>   #ifdef ATOMIC64_INIT
>>   #define KERNEL_HAS_ATOMIC64
>>   #endif
>> -- 
>> 1.8.3.1


