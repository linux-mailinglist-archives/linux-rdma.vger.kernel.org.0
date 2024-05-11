Return-Path: <linux-rdma+bounces-2410-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4298C2F03
	for <lists+linux-rdma@lfdr.de>; Sat, 11 May 2024 04:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3D61F23185
	for <lists+linux-rdma@lfdr.de>; Sat, 11 May 2024 02:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403A817BAB;
	Sat, 11 May 2024 02:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZLWaqRDv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4192F17571;
	Sat, 11 May 2024 02:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715394394; cv=none; b=Sh+GW2BuDvEnz1vzpriqDiH+7vKxhMrHSa71WS5iQ/kcJnJzy4gtockK3KkSv9wdkVn7QHCv1GpxGqe3XhQ319SHya2UiYR/5IeMZHkSTmfhHxm5ZtODVb1e+Q+bBT0DKrLLIt8pT6Xm13HbdOtl3HH3DQ1vt5vL8oDpn1AYa7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715394394; c=relaxed/simple;
	bh=ggxlDlG1YI922LNdSkTT04eRxxTmskXyhjlv/HpRgns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eRiHVrsAWVvjUBbfCHT+uU7b/OmjUTxPi1QzHQg7qgq9uLIWYiJ/KxVwHS+Xles1nosIX3blvLTIfm+oyv70YEnX3L3rB5C7KgczV4bS3o2m1fRKoY6ajVGRfHjAZxYIya2iLtOINkNrCAjyWLZC2bcExMrxIWVdF/K7byZ6HPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZLWaqRDv; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715394388; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=45JX5gKumjUQPmfnJ1Yt8cEHN4bW1vuhVImqRYRShoI=;
	b=ZLWaqRDvje8P9PsZYX4NH7863DCX513vQyrGSy6rtq5C+Ku3BDT6qCQscHzcARqfvQxk6DVgVFjqKwcWOcqAI5COkgC/nr3skqCunkg/+3eKg9tlDUXrtZ74nz+Pv3hQP17MN6wBRCHHkjq+or8wHk04ezqh5dbmlufjXSNQz9c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6BhZQd_1715394384;
Received: from 30.221.147.218(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W6BhZQd_1715394384)
          by smtp.aliyun-inc.com;
          Sat, 11 May 2024 10:26:27 +0800
Message-ID: <c9b24dc5-11da-43e1-9049-c04e6d000371@linux.alibaba.com>
Date: Sat, 11 May 2024 10:26:23 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net/smc: refatoring initialization of smc
 sock
To: dust.li@linux.alibaba.com, kgraul@linux.ibm.com, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, wintera@linux.ibm.com, guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1715314333-107290-1-git-send-email-alibuda@linux.alibaba.com>
 <1715314333-107290-2-git-send-email-alibuda@linux.alibaba.com>
 <20240510095027.GA78725@linux.alibaba.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20240510095027.GA78725@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/10/24 5:50 PM, Dust Li wrote:
> On 2024-05-10 12:12:12, D. Wythe wrote:
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
>> net/smc/af_smc.c | 93 +++++++++++++++++++++++++++++++-------------------------
>> 1 file changed, 52 insertions(+), 41 deletions(-)
>>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index 9389f0c..1f03724 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -361,34 +361,43 @@ static void smc_destruct(struct sock *sk)
>> 		return;
>> }
>>
>> -static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
>> -				   int protocol)
>> +static void smc_sock_init(struct net *net, struct sock *sk, int protocol)
>> {
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
>> 	sk->sk_state = SMC_INIT;
>> -	sk->sk_destruct = smc_destruct;
>> 	sk->sk_protocol = protocol;
>> +	mutex_init(&smc->clcsock_release_lock);
>> 	WRITE_ONCE(sk->sk_sndbuf, 2 * READ_ONCE(net->smc.sysctl_wmem));
>> 	WRITE_ONCE(sk->sk_rcvbuf, 2 * READ_ONCE(net->smc.sysctl_rmem));
>> -	smc = smc_sk(sk);
>> 	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
>> 	INIT_WORK(&smc->connect_work, smc_connect_work);
>> 	INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);
>> 	INIT_LIST_HEAD(&smc->accept_q);
>> 	spin_lock_init(&smc->accept_q_lock);
>> 	spin_lock_init(&smc->conn.send_lock);
>> -	sk->sk_prot->hash(sk);
>> -	mutex_init(&smc->clcsock_release_lock);
>> 	smc_init_saved_callbacks(smc);
>> +	smc->limit_smc_hs = net->smc.limit_smc_hs;
>> +	smc->use_fallback = false; /* assume rdma capability first */
>> +	smc->fallback_rsn = 0;
>> +
>> +	sk->sk_destruct = smc_destruct;
>> +	sk->sk_prot->hash(sk);
> Why change the order here ? e.g.
>
> Before:
>      sk->sk_destruct = smc_destruct;
>      mutex_init(&smc->clcsock_release_lock);
> After
>      mutex_init(&smc->clcsock_release_lock);
>      sk->sk_destruct = smc_destruct;
>
> Same for sk->sk_prot->hash(sk)

Yes, you are right, I will fix it in the next version.
>
>
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
>> 	return sk;
>> }
>> @@ -3321,6 +3330,31 @@ static ssize_t smc_splice_read(struct socket *sock, loff_t *ppos,
>> 	.splice_read	= smc_splice_read,
>> };
>>
>> +static int __smc_create_clcsk(struct net *net, struct sock *sk, int family)
> Why add '__' prefix here ?

Good question, I also realize that this is not suitable, I will delete 
it in the next version.

Thanks.

>
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
>> static int __smc_create(struct net *net, struct socket *sock, int protocol,
>> 			int kern, struct socket *clcsock)
>> {
>> @@ -3346,35 +3380,12 @@ static int __smc_create(struct net *net, struct socket *sock, int protocol,
>>
>> 	/* create internal TCP socket for CLC handshake and fallback */
>> 	smc = smc_sk(sk);
>> -	smc->use_fallback = false; /* assume rdma capability first */
>> -	smc->fallback_rsn = 0;
>> -
>> -	/* default behavior from limit_smc_hs in every net namespace */
>> -	smc->limit_smc_hs = net->smc.limit_smc_hs;
>>
>> 	rc = 0;
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
>> +		rc = __smc_create_clcsk(net, sk, family);
>> +	else
>> 		smc->clcsock = clcsock;
>> -	}
>> -
>> out:
>> 	return rc;
>> }
>> -- 
>> 1.8.3.1
>>


