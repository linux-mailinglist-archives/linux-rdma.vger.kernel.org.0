Return-Path: <linux-rdma+bounces-2670-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7788D3DCC
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 19:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49CE11C216F9
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 17:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD92F187336;
	Wed, 29 May 2024 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HUASCKzt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845B615B551
	for <linux-rdma@vger.kernel.org>; Wed, 29 May 2024 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717005461; cv=none; b=lqW7Y6oFzSvK/CQI+QBvmW9sYKFrLOO+NIpB1NCcHjE/JFWmkchUueLC0gTp9cpWmKpuD6dq9fxSvEvY4N0xcNUh9ThPgTsyqlRtIbRjoqkraKGLYxHnCyDWqvsieD92E/fWjPFVVfPzSY9f/hy3rRWiUyIe8unJr4wHw0geBCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717005461; c=relaxed/simple;
	bh=wfGExj2+s2QkC4H47UqIsh7D6yT4YWv8wXmvtfLeogM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZI6+RF9A5URK6/5caRAa+QrTS59TPpUcca0t+vs4oSYIaXUO4Mi9F/hmCy46SiPVQlGesljixqsxqxnZhCQVvMjyrxcLWkMd4JjqVafss2dl1qmhpJ/WjMY84qKiTKYzqrnkkmlhh9h+14WkxXVciSM3e5BTOyuligvoXIVW6KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HUASCKzt; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: alibuda@linux.alibaba.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717005457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7aKaHemxNsEOgDmsfSdOpgG+1dZRQDayr2mgZJbCbZo=;
	b=HUASCKztcvC3gu7wVtbQ1SpAWxdRzkptVxyzxyFWCNBnisELcZxPnX1jxLWcJ4lKUlCsEl
	UYBxQ9jfH4oPu+T+TARCnQDxFg5bypKBin+RDuvdiIY7fSq7qW5+o14AMtSLhg5luzBlFN
	3OqW7rsKwYg+Pm41lbG90tk/4C+oDY0=
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
Message-ID: <136a5e67-962a-4084-bc51-c0ec9eb8e885@linux.dev>
Date: Wed, 29 May 2024 19:57:28 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 2/3] net/smc: expose smc proto operations
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
 guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1716955147-88923-1-git-send-email-alibuda@linux.alibaba.com>
 <1716955147-88923-3-git-send-email-alibuda@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1716955147-88923-3-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/5/29 5:59, D. Wythe 写道:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> Externalize smc proto operations (smc_xxx) to allow
> access from files other that af_smc.c

s/other that/other than ?

Zhu Yanjun

> 
> This is in preparation for the subsequent implementation
> of the AF_INET version of SMC.
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>   net/smc/af_smc.c | 60 ++++++++++++++++++++++++++++----------------------------
>   net/smc/smc.h    | 33 +++++++++++++++++++++++++++++++
>   2 files changed, 63 insertions(+), 30 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 77a9d58..8e3ce76 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -170,15 +170,15 @@ static bool smc_hs_congested(const struct sock *sk)
>   	return false;
>   }
>   
> -static struct smc_hashinfo smc_v4_hashinfo = {
> +struct smc_hashinfo smc_v4_hashinfo = {
>   	.lock = __RW_LOCK_UNLOCKED(smc_v4_hashinfo.lock),
>   };
>   
> -static struct smc_hashinfo smc_v6_hashinfo = {
> +struct smc_hashinfo smc_v6_hashinfo = {
>   	.lock = __RW_LOCK_UNLOCKED(smc_v6_hashinfo.lock),
>   };
>   
> -static int smc_hash_sk(struct sock *sk)
> +int smc_hash_sk(struct sock *sk)
>   {
>   	struct smc_hashinfo *h = sk->sk_prot->h.smc_hash;
>   	struct hlist_head *head;
> @@ -193,7 +193,7 @@ static int smc_hash_sk(struct sock *sk)
>   	return 0;
>   }
>   
> -static void smc_unhash_sk(struct sock *sk)
> +void smc_unhash_sk(struct sock *sk)
>   {
>   	struct smc_hashinfo *h = sk->sk_prot->h.smc_hash;
>   
> @@ -207,7 +207,7 @@ static void smc_unhash_sk(struct sock *sk)
>    * work which we didn't do because of user hold the sock_lock in the
>    * BH context
>    */
> -static void smc_release_cb(struct sock *sk)
> +void smc_release_cb(struct sock *sk)
>   {
>   	struct smc_sock *smc = smc_sk(sk);
>   
> @@ -307,7 +307,7 @@ static int __smc_release(struct smc_sock *smc)
>   	return rc;
>   }
>   
> -static int smc_release(struct socket *sock)
> +int smc_release(struct socket *sock)
>   {
>   	struct sock *sk = sock->sk;
>   	struct smc_sock *smc;
> @@ -401,8 +401,8 @@ static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
>   	return sk;
>   }
>   
> -static int smc_bind(struct socket *sock, struct sockaddr *uaddr,
> -		    int addr_len)
> +int smc_bind(struct socket *sock, struct sockaddr *uaddr,
> +	     int addr_len)
>   {
>   	struct sockaddr_in *addr = (struct sockaddr_in *)uaddr;
>   	struct sock *sk = sock->sk;
> @@ -1649,8 +1649,8 @@ static void smc_connect_work(struct work_struct *work)
>   	release_sock(&smc->sk);
>   }
>   
> -static int smc_connect(struct socket *sock, struct sockaddr *addr,
> -		       int alen, int flags)
> +int smc_connect(struct socket *sock, struct sockaddr *addr,
> +		int alen, int flags)
>   {
>   	struct sock *sk = sock->sk;
>   	struct smc_sock *smc;
> @@ -2631,7 +2631,7 @@ static void smc_clcsock_data_ready(struct sock *listen_clcsock)
>   	read_unlock_bh(&listen_clcsock->sk_callback_lock);
>   }
>   
> -static int smc_listen(struct socket *sock, int backlog)
> +int smc_listen(struct socket *sock, int backlog)
>   {
>   	struct sock *sk = sock->sk;
>   	struct smc_sock *smc;
> @@ -2696,8 +2696,8 @@ static int smc_listen(struct socket *sock, int backlog)
>   	return rc;
>   }
>   
> -static int smc_accept(struct socket *sock, struct socket *new_sock,
> -		      struct proto_accept_arg *arg)
> +int smc_accept(struct socket *sock, struct socket *new_sock,
> +	       struct proto_accept_arg *arg)
>   {
>   	struct sock *sk = sock->sk, *nsk;
>   	DECLARE_WAITQUEUE(wait, current);
> @@ -2766,8 +2766,8 @@ static int smc_accept(struct socket *sock, struct socket *new_sock,
>   	return rc;
>   }
>   
> -static int smc_getname(struct socket *sock, struct sockaddr *addr,
> -		       int peer)
> +int smc_getname(struct socket *sock, struct sockaddr *addr,
> +		int peer)
>   {
>   	struct smc_sock *smc;
>   
> @@ -2780,7 +2780,7 @@ static int smc_getname(struct socket *sock, struct sockaddr *addr,
>   	return smc->clcsock->ops->getname(smc->clcsock, addr, peer);
>   }
>   
> -static int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
> +int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
>   {
>   	struct sock *sk = sock->sk;
>   	struct smc_sock *smc;
> @@ -2818,8 +2818,8 @@ static int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
>   	return rc;
>   }
>   
> -static int smc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> -		       int flags)
> +int smc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> +		int flags)
>   {
>   	struct sock *sk = sock->sk;
>   	struct smc_sock *smc;
> @@ -2868,8 +2868,8 @@ static __poll_t smc_accept_poll(struct sock *parent)
>   	return mask;
>   }
>   
> -static __poll_t smc_poll(struct file *file, struct socket *sock,
> -			     poll_table *wait)
> +__poll_t smc_poll(struct file *file, struct socket *sock,
> +		  poll_table *wait)
>   {
>   	struct sock *sk = sock->sk;
>   	struct smc_sock *smc;
> @@ -2921,7 +2921,7 @@ static __poll_t smc_poll(struct file *file, struct socket *sock,
>   	return mask;
>   }
>   
> -static int smc_shutdown(struct socket *sock, int how)
> +int smc_shutdown(struct socket *sock, int how)
>   {
>   	struct sock *sk = sock->sk;
>   	bool do_shutdown = true;
> @@ -3061,8 +3061,8 @@ static int __smc_setsockopt(struct socket *sock, int level, int optname,
>   	return rc;
>   }
>   
> -static int smc_setsockopt(struct socket *sock, int level, int optname,
> -			  sockptr_t optval, unsigned int optlen)
> +int smc_setsockopt(struct socket *sock, int level, int optname,
> +		   sockptr_t optval, unsigned int optlen)
>   {
>   	struct sock *sk = sock->sk;
>   	struct smc_sock *smc;
> @@ -3148,8 +3148,8 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
>   	return rc;
>   }
>   
> -static int smc_getsockopt(struct socket *sock, int level, int optname,
> -			  char __user *optval, int __user *optlen)
> +int smc_getsockopt(struct socket *sock, int level, int optname,
> +		   char __user *optval, int __user *optlen)
>   {
>   	struct smc_sock *smc;
>   	int rc;
> @@ -3174,8 +3174,8 @@ static int smc_getsockopt(struct socket *sock, int level, int optname,
>   	return rc;
>   }
>   
> -static int smc_ioctl(struct socket *sock, unsigned int cmd,
> -		     unsigned long arg)
> +int smc_ioctl(struct socket *sock, unsigned int cmd,
> +	      unsigned long arg)
>   {
>   	union smc_host_cursor cons, urg;
>   	struct smc_connection *conn;
> @@ -3261,9 +3261,9 @@ static int smc_ioctl(struct socket *sock, unsigned int cmd,
>    * Note that subsequent recv() calls have to wait till all splice() processing
>    * completed.
>    */
> -static ssize_t smc_splice_read(struct socket *sock, loff_t *ppos,
> -			       struct pipe_inode_info *pipe, size_t len,
> -			       unsigned int flags)
> +ssize_t smc_splice_read(struct socket *sock, loff_t *ppos,
> +			struct pipe_inode_info *pipe, size_t len,
> +			unsigned int flags)
>   {
>   	struct sock *sk = sock->sk;
>   	struct smc_sock *smc;
> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index 3edec1e..34b781e 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -34,6 +34,39 @@
>   extern struct proto smc_proto;
>   extern struct proto smc_proto6;
>   
> +extern struct smc_hashinfo smc_v4_hashinfo;
> +extern struct smc_hashinfo smc_v6_hashinfo;
> +
> +int smc_hash_sk(struct sock *sk);
> +void smc_unhash_sk(struct sock *sk);
> +void smc_release_cb(struct sock *sk);
> +
> +int smc_release(struct socket *sock);
> +int smc_bind(struct socket *sock, struct sockaddr *uaddr,
> +	     int addr_len);
> +int smc_connect(struct socket *sock, struct sockaddr *addr,
> +		int alen, int flags);
> +int smc_accept(struct socket *sock, struct socket *new_sock,
> +	       struct proto_accept_arg *arg);
> +int smc_getname(struct socket *sock, struct sockaddr *addr,
> +		int peer);
> +__poll_t smc_poll(struct file *file, struct socket *sock,
> +		  poll_table *wait);
> +int smc_ioctl(struct socket *sock, unsigned int cmd,
> +	      unsigned long arg);
> +int smc_listen(struct socket *sock, int backlog);
> +int smc_shutdown(struct socket *sock, int how);
> +int smc_setsockopt(struct socket *sock, int level, int optname,
> +		   sockptr_t optval, unsigned int optlen);
> +int smc_getsockopt(struct socket *sock, int level, int optname,
> +		   char __user *optval, int __user *optlen);
> +int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len);
> +int smc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> +		int flags);
> +ssize_t smc_splice_read(struct socket *sock, loff_t *ppos,
> +			struct pipe_inode_info *pipe, size_t len,
> +			unsigned int flags);
> +
>   /* smc sock initialization */
>   void smc_sk_init(struct net *net, struct sock *sk, int protocol);
>   /* clcsock initialization */


