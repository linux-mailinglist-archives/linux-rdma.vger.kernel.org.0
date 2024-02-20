Return-Path: <linux-rdma+bounces-1053-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8E485B366
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4D07B21832
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 07:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1415A795;
	Tue, 20 Feb 2024 07:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lWawfqTm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F21B5A10A;
	Tue, 20 Feb 2024 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412519; cv=none; b=JzXhr7GmBHy+Vkk4o9iL+xYJhVOan+y8F2Bz5XZuPCxBAe7MxQH/3aSjPD5aPnkcCD31CxUJavE6/nhUfMazOdDFbR2oCsOcDNFYHDH2TzWvp43fv5kkzbCFa2kNGB9KHXnvy1mqTfrCA89PvISbaUsVjFATsgLnWDoQuIiB/OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412519; c=relaxed/simple;
	bh=e/OJdyE4TpLB+D1pOPdH/Ffoqt1dUbUlmwdpuLPoDh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WKFSw9zRFaXO56xf7M7ofFGyio3a2Lx/kPDoIXyeztJZusaVpp60ShTTxaNKt0gVa9+T2YMnQ/42JERLmZbi68AQl0ARTJmS1+/xkz78uZVfBetUvykj+oiM3EmNRKDQ/dusvY9sEiEY45lYvn1qM4rgRcy5gKzfWpJB8zgkSZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lWawfqTm; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708412510; h=From:To:Subject:Date:Message-Id;
	bh=nCulGWy5dVx4V7R5dThNutsqPdZq+WXBiutltng6hfY=;
	b=lWawfqTmxPanPZjYy3+pVzPlNrdl7vZ23P/zdk5jZkWxE1IBm6CIgCH9ovS8FFKQQG4r2ngoJRUgWvRW4//I3t2Hywt1ER6lUt/B3NZhD9Vbn13gyjS5eZEar7Sig9L4MFGNMugpfDTvEjLTTcpZkTIjUx2+mO9pc2Jzz7fhG2g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W0vuXd4_1708412509;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W0vuXd4_1708412509)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 15:01:50 +0800
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
Subject: [RFC net-next 01/20] net: export partial symbols in inet/inet6 proto_ops
Date: Tue, 20 Feb 2024 15:01:26 +0800
Message-Id: <1708412505-34470-2-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
References: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

The following symbols have been exported here

1. inet_compat_ioctl
2. inet6_sendmsg
3. inet6_recvmsg

Exporting these symbols mainly provides the ability for other modules
to directly access these symbols. Currently, all symbols except those
above symbols are exported. So, there mighe be no obvious risk in
exporting these symbols.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 include/net/inet_common.h | 3 +++
 net/ipv4/af_inet.c        | 3 ++-
 net/ipv6/af_inet6.c       | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index f50a644..1c2fcca 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -57,6 +57,9 @@ int __inet_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
 int inet_getname(struct socket *sock, struct sockaddr *uaddr,
 		 int peer);
 int inet_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
+#ifdef CONFIG_COMPAT
+int inet_compat_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
+#endif
 int inet_ctl_sock_create(struct sock **sk, unsigned short family,
 			 unsigned short type, unsigned char protocol,
 			 struct net *net);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index ad27800..049d135 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1031,7 +1031,7 @@ static int inet_compat_routing_ioctl(struct sock *sk, unsigned int cmd,
 	return ip_rt_ioctl(sock_net(sk), cmd, &rt);
 }
 
-static int inet_compat_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
+int inet_compat_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = compat_ptr(arg);
 	struct sock *sk = sock->sk;
@@ -1046,6 +1046,7 @@ static int inet_compat_ioctl(struct socket *sock, unsigned int cmd, unsigned lon
 		return sk->sk_prot->compat_ioctl(sk, cmd, arg);
 	}
 }
+EXPORT_SYMBOL_GPL(inet_compat_ioctl);
 #endif /* CONFIG_COMPAT */
 
 const struct proto_ops inet_stream_ops = {
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 959bfd9..5a81f8b 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -660,6 +660,7 @@ int inet6_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	return INDIRECT_CALL_2(prot->sendmsg, tcp_sendmsg, udpv6_sendmsg,
 			       sk, msg, size);
 }
+EXPORT_SYMBOL_GPL(inet6_sendmsg);
 
 INDIRECT_CALLABLE_DECLARE(int udpv6_recvmsg(struct sock *, struct msghdr *,
 					    size_t, int, int *));
@@ -682,6 +683,7 @@ int inet6_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		msg->msg_namelen = addr_len;
 	return err;
 }
+EXPORT_SYMBOL_GPL(inet6_recvmsg);
 
 const struct proto_ops inet6_stream_ops = {
 	.family		   = PF_INET6,
-- 
1.8.3.1


