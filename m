Return-Path: <linux-rdma+bounces-3093-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8FF9064CB
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 09:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4FD9B21909
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 07:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAF05A4D5;
	Thu, 13 Jun 2024 07:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LXoNiHQz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFD05914A;
	Thu, 13 Jun 2024 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263186; cv=none; b=G2+EGOWlKz3cIacMUvQjKQW+sPFWxsU5zXG3JDJ+wy0+gDKQMvNUbux5oWgolpwgNOJRmNO3ZVU9z3UNS6qs5ZiWpc6ieT1CsR5dA0pkUEr9HbcmO208itUrSSmHaUCYhiRhLH0E/sQmqy76hwnp9Niqhc+amcDK0NG2XN1Dypo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263186; c=relaxed/simple;
	bh=E9jA9u9v8jccEplkYs0yb9V25UXm8D2eVFbanN5n4u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=by2UOZEOCFm7z6rEkirpw71C6/f8pZ/h6ChSCqmOtzdw55XpAg6/tEBrIo7b1XaV22Ic9a7GkuUCpRWY7CeFFigGdsO89yblyWfORMvoHZyuOE6YzhsN0pTo51+ceqK0zbtvTyDFTPUlOC+CeBLQCzFp3PfmsMPH8sLcK7EqjBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LXoNiHQz; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718263180; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=nsIku9vqfWI9U+m1B+Hdd9np5en26JVTaI/K3JR5D7o=;
	b=LXoNiHQzvHWt/LwBPuSEygFHN8L6B9yw2XlVU9ecQmI6BrF6YmE45syQWSgFgo26aVkK+LZdXys1zSem7ZMuxeRKwfUX2qHULE2CM/4ymMvcQceubHpeYvhzJSvGxctel+1CTURTqt47GDOTvSyFYwXr5Of6S1fDI2LcCF4oiPo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W8NCWyR_1718263179;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0W8NCWyR_1718263179)
          by smtp.aliyun-inc.com;
          Thu, 13 Jun 2024 15:19:39 +0800
Date: Thu, 13 Jun 2024 15:19:38 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH net-next v7 2/3] net/smc: expose smc proto operations
Message-ID: <20240613071938.GP78725@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <1717837949-88904-1-git-send-email-alibuda@linux.alibaba.com>
 <1717837949-88904-3-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1717837949-88904-3-git-send-email-alibuda@linux.alibaba.com>

On 2024-06-08 17:12:28, D. Wythe wrote:
>From: "D. Wythe" <alibuda@linux.alibaba.com>
>
>Externalize smc proto operations (smc_xxx) to allow
>access from files other than af_smc.c
>
>This is in preparation for the subsequent implementation
>of the AF_INET version of SMC.
>
>Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
>Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
>Tested-by: Wenjia Zhang <wenjia@linux.ibm.com>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

>---
> net/smc/af_smc.c | 60 ++++++++++++++++++++++++++++----------------------------
> net/smc/smc.h    | 33 +++++++++++++++++++++++++++++++
> 2 files changed, 63 insertions(+), 30 deletions(-)
>
>diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>index 77a9d58..8e3ce76 100644
>--- a/net/smc/af_smc.c
>+++ b/net/smc/af_smc.c
>@@ -170,15 +170,15 @@ static bool smc_hs_congested(const struct sock *sk)
> 	return false;
> }
> 
>-static struct smc_hashinfo smc_v4_hashinfo = {
>+struct smc_hashinfo smc_v4_hashinfo = {
> 	.lock = __RW_LOCK_UNLOCKED(smc_v4_hashinfo.lock),
> };
> 
>-static struct smc_hashinfo smc_v6_hashinfo = {
>+struct smc_hashinfo smc_v6_hashinfo = {
> 	.lock = __RW_LOCK_UNLOCKED(smc_v6_hashinfo.lock),
> };
> 
>-static int smc_hash_sk(struct sock *sk)
>+int smc_hash_sk(struct sock *sk)
> {
> 	struct smc_hashinfo *h = sk->sk_prot->h.smc_hash;
> 	struct hlist_head *head;
>@@ -193,7 +193,7 @@ static int smc_hash_sk(struct sock *sk)
> 	return 0;
> }
> 
>-static void smc_unhash_sk(struct sock *sk)
>+void smc_unhash_sk(struct sock *sk)
> {
> 	struct smc_hashinfo *h = sk->sk_prot->h.smc_hash;
> 
>@@ -207,7 +207,7 @@ static void smc_unhash_sk(struct sock *sk)
>  * work which we didn't do because of user hold the sock_lock in the
>  * BH context
>  */
>-static void smc_release_cb(struct sock *sk)
>+void smc_release_cb(struct sock *sk)
> {
> 	struct smc_sock *smc = smc_sk(sk);
> 
>@@ -307,7 +307,7 @@ static int __smc_release(struct smc_sock *smc)
> 	return rc;
> }
> 
>-static int smc_release(struct socket *sock)
>+int smc_release(struct socket *sock)
> {
> 	struct sock *sk = sock->sk;
> 	struct smc_sock *smc;
>@@ -401,8 +401,8 @@ static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
> 	return sk;
> }
> 
>-static int smc_bind(struct socket *sock, struct sockaddr *uaddr,
>-		    int addr_len)
>+int smc_bind(struct socket *sock, struct sockaddr *uaddr,
>+	     int addr_len)
> {
> 	struct sockaddr_in *addr = (struct sockaddr_in *)uaddr;
> 	struct sock *sk = sock->sk;
>@@ -1649,8 +1649,8 @@ static void smc_connect_work(struct work_struct *work)
> 	release_sock(&smc->sk);
> }
> 
>-static int smc_connect(struct socket *sock, struct sockaddr *addr,
>-		       int alen, int flags)
>+int smc_connect(struct socket *sock, struct sockaddr *addr,
>+		int alen, int flags)
> {
> 	struct sock *sk = sock->sk;
> 	struct smc_sock *smc;
>@@ -2631,7 +2631,7 @@ static void smc_clcsock_data_ready(struct sock *listen_clcsock)
> 	read_unlock_bh(&listen_clcsock->sk_callback_lock);
> }
> 
>-static int smc_listen(struct socket *sock, int backlog)
>+int smc_listen(struct socket *sock, int backlog)
> {
> 	struct sock *sk = sock->sk;
> 	struct smc_sock *smc;
>@@ -2696,8 +2696,8 @@ static int smc_listen(struct socket *sock, int backlog)
> 	return rc;
> }
> 
>-static int smc_accept(struct socket *sock, struct socket *new_sock,
>-		      struct proto_accept_arg *arg)
>+int smc_accept(struct socket *sock, struct socket *new_sock,
>+	       struct proto_accept_arg *arg)
> {
> 	struct sock *sk = sock->sk, *nsk;
> 	DECLARE_WAITQUEUE(wait, current);
>@@ -2766,8 +2766,8 @@ static int smc_accept(struct socket *sock, struct socket *new_sock,
> 	return rc;
> }
> 
>-static int smc_getname(struct socket *sock, struct sockaddr *addr,
>-		       int peer)
>+int smc_getname(struct socket *sock, struct sockaddr *addr,
>+		int peer)
> {
> 	struct smc_sock *smc;
> 
>@@ -2780,7 +2780,7 @@ static int smc_getname(struct socket *sock, struct sockaddr *addr,
> 	return smc->clcsock->ops->getname(smc->clcsock, addr, peer);
> }
> 
>-static int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
>+int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
> {
> 	struct sock *sk = sock->sk;
> 	struct smc_sock *smc;
>@@ -2818,8 +2818,8 @@ static int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
> 	return rc;
> }
> 
>-static int smc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>-		       int flags)
>+int smc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>+		int flags)
> {
> 	struct sock *sk = sock->sk;
> 	struct smc_sock *smc;
>@@ -2868,8 +2868,8 @@ static __poll_t smc_accept_poll(struct sock *parent)
> 	return mask;
> }
> 
>-static __poll_t smc_poll(struct file *file, struct socket *sock,
>-			     poll_table *wait)
>+__poll_t smc_poll(struct file *file, struct socket *sock,
>+		  poll_table *wait)
> {
> 	struct sock *sk = sock->sk;
> 	struct smc_sock *smc;
>@@ -2921,7 +2921,7 @@ static __poll_t smc_poll(struct file *file, struct socket *sock,
> 	return mask;
> }
> 
>-static int smc_shutdown(struct socket *sock, int how)
>+int smc_shutdown(struct socket *sock, int how)
> {
> 	struct sock *sk = sock->sk;
> 	bool do_shutdown = true;
>@@ -3061,8 +3061,8 @@ static int __smc_setsockopt(struct socket *sock, int level, int optname,
> 	return rc;
> }
> 
>-static int smc_setsockopt(struct socket *sock, int level, int optname,
>-			  sockptr_t optval, unsigned int optlen)
>+int smc_setsockopt(struct socket *sock, int level, int optname,
>+		   sockptr_t optval, unsigned int optlen)
> {
> 	struct sock *sk = sock->sk;
> 	struct smc_sock *smc;
>@@ -3148,8 +3148,8 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
> 	return rc;
> }
> 
>-static int smc_getsockopt(struct socket *sock, int level, int optname,
>-			  char __user *optval, int __user *optlen)
>+int smc_getsockopt(struct socket *sock, int level, int optname,
>+		   char __user *optval, int __user *optlen)
> {
> 	struct smc_sock *smc;
> 	int rc;
>@@ -3174,8 +3174,8 @@ static int smc_getsockopt(struct socket *sock, int level, int optname,
> 	return rc;
> }
> 
>-static int smc_ioctl(struct socket *sock, unsigned int cmd,
>-		     unsigned long arg)
>+int smc_ioctl(struct socket *sock, unsigned int cmd,
>+	      unsigned long arg)
> {
> 	union smc_host_cursor cons, urg;
> 	struct smc_connection *conn;
>@@ -3261,9 +3261,9 @@ static int smc_ioctl(struct socket *sock, unsigned int cmd,
>  * Note that subsequent recv() calls have to wait till all splice() processing
>  * completed.
>  */
>-static ssize_t smc_splice_read(struct socket *sock, loff_t *ppos,
>-			       struct pipe_inode_info *pipe, size_t len,
>-			       unsigned int flags)
>+ssize_t smc_splice_read(struct socket *sock, loff_t *ppos,
>+			struct pipe_inode_info *pipe, size_t len,
>+			unsigned int flags)
> {
> 	struct sock *sk = sock->sk;
> 	struct smc_sock *smc;
>diff --git a/net/smc/smc.h b/net/smc/smc.h
>index 3edec1e..34b781e 100644
>--- a/net/smc/smc.h
>+++ b/net/smc/smc.h
>@@ -34,6 +34,39 @@
> extern struct proto smc_proto;
> extern struct proto smc_proto6;
> 
>+extern struct smc_hashinfo smc_v4_hashinfo;
>+extern struct smc_hashinfo smc_v6_hashinfo;
>+
>+int smc_hash_sk(struct sock *sk);
>+void smc_unhash_sk(struct sock *sk);
>+void smc_release_cb(struct sock *sk);
>+
>+int smc_release(struct socket *sock);
>+int smc_bind(struct socket *sock, struct sockaddr *uaddr,
>+	     int addr_len);
>+int smc_connect(struct socket *sock, struct sockaddr *addr,
>+		int alen, int flags);
>+int smc_accept(struct socket *sock, struct socket *new_sock,
>+	       struct proto_accept_arg *arg);
>+int smc_getname(struct socket *sock, struct sockaddr *addr,
>+		int peer);
>+__poll_t smc_poll(struct file *file, struct socket *sock,
>+		  poll_table *wait);
>+int smc_ioctl(struct socket *sock, unsigned int cmd,
>+	      unsigned long arg);
>+int smc_listen(struct socket *sock, int backlog);
>+int smc_shutdown(struct socket *sock, int how);
>+int smc_setsockopt(struct socket *sock, int level, int optname,
>+		   sockptr_t optval, unsigned int optlen);
>+int smc_getsockopt(struct socket *sock, int level, int optname,
>+		   char __user *optval, int __user *optlen);
>+int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len);
>+int smc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>+		int flags);
>+ssize_t smc_splice_read(struct socket *sock, loff_t *ppos,
>+			struct pipe_inode_info *pipe, size_t len,
>+			unsigned int flags);
>+
> /* smc sock initialization */
> void smc_sk_init(struct net *net, struct sock *sk, int protocol);
> /* clcsock initialization */
>-- 
>1.8.3.1
>

