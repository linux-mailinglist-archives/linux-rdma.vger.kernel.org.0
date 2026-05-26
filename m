Return-Path: <linux-rdma+bounces-21268-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALUeMW0+FWqgTwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21268-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 08:32:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 939325D1302
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 08:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24508301CCFC
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 06:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47473246ED;
	Tue, 26 May 2026 06:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NxA102wt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4D52139C9
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 06:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779777128; cv=none; b=iMGxyTqQX37g2IZggtHkRla74yoGI0WKbGzjH/HtLuIBA1rF8cj2edyv9kR0tIDR1p/PP7k+gWnTgc1zea8Erl5+toufWDA0lbwErqiyN+2V4xi6TkowWfYHSe2RmyGDu9IFyxG8p/ECPieZ9dKdv5Aw71bNsebuacNwhO3tXgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779777128; c=relaxed/simple;
	bh=WFHaITeQfEFlfvrPQt23QPZClTYhHLh7FyIKFoBCv2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UNJEHTzLznEuzaKURD7pfuEB4hTHqw/VBPq/c/gdmoR1mLk8ex+kg2yoXhzIGiGl76tIruSERB9AR5lPa4SfiT1/zNdmKiE8wcZEyypVWlTChAISTCt9dhnhn9KppM9f8kuFIR75e/RK2zYe+LznyxOsZrOFP2MuEBC2Q02YPNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NxA102wt; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e21fbea2-961f-4186-830d-2ecca98d8243@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779777074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OV2dgY7vBtSoIXUGKcdhg2nd6jYn8gsEtXnzc3l4HnA=;
	b=NxA102wtzpVq2JAKyYUExLMDMVEaCSJrIpveUP6+8XT1CCgTcKA5kZHwfGEouCQUbL6buZ
	9IJomSZIEtOZiUvIboZy6gqtaNZdbqCfBcLROI0uNb0IHBKKz/I9moDHZW1JHqDq/cwCls
	CRHW3AO8+rwGtSaTpl3AJn/B6ws4nYQ=
Date: Mon, 25 May 2026 23:31:02 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] RDMA/rxe: Fix Use-After-Free problem in
 rxe_net_del
To: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
 linux-rdma@vger.kernel.org, "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
References: <20260519023541.8594-1-yanjun.zhu@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260519023541.8594-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21268-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org,vger.kernel.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 939325D1302
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

gently ping

在 2026/5/18 19:35, Zhu Yanjun 写道:
> syzbot reported a general protection fault (KASAN: null-ptr-deref) in
> kernel_sock_shutdown() called during the software RoCE (rxe) link
> deletion path (rxe_dellink -> rxe_net_del).
> 
> The call trace is as below:
> "
> rdma_rxe: rxe_newlink: failed to add lo
> Oops: gen[  127.022080][ T5982] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000004: 0000 [#1] SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
> CPU: 1 UID: 0 PID: 5982 Comm: syz.3.20 Not tainted syzkaller #0 PREEMPT_{RT,(full)}
> ...
> Call Trace:
>   <TASK>
>   udp_tunnel_sock_release+0x6d/0x80 net/ipv4/udp_tunnel_core.c:197
>   rxe_release_udp_tunnel drivers/infiniband/sw/rxe/rxe_net.c:294 [inline]
>   rxe_sock_put drivers/infiniband/sw/rxe/rxe_net.c:639 [inline]
>   rxe_net_del+0xfb/0x290 drivers/infiniband/sw/rxe/rxe_net.c:660
>   rxe_dellink+0x15/0x20 drivers/infiniband/sw/rxe/rxe.c:254
>   nldev_dellink+0x304/0x3d0 drivers/infiniband/core/nldev.c:1849
>   rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:-1 [inline]
>   rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>   rdma_nl_rcv+0x6d7/0xa10 drivers/infiniband/core/netlink.c:259
>   netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
>   netlink_unicast+0x780/0x920 net/netlink/af_netlink.c:1345
>   netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1895
>   sock_sendmsg_nosec+0x112/0x150 net/socket.c:797
>   __sock_sendmsg net/socket.c:812 [inline]
>   ____sys_sendmsg+0x55c/0x870 net/socket.c:2716
>   ___sys_sendmsg+0x2a5/0x360 net/socket.c:2770
>   __sys_sendmsg net/socket.c:2802 [inline]
>   __do_sys_sendmsg net/socket.c:2807 [inline]
>   __se_sys_sendmsg net/socket.c:2805 [inline]
>   __x64_sys_sendmsg+0x1c3/0x2a0 net/socket.c:2805
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f89172fcdd9
> RSP: 002b:00007ffe8bf8c018 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f8917575fa0 RCX: 00007f89172fcdd9
> RDX: 0000000000000000 RSI: 00002000000002c0 RDI: 0000000000000006
> RBP: 00007f8917392d69 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f8917575fac R14: 00007f8917575fa0 R15: 00007f8917575fa0
>   </TASK>
> "
> 
> The root cause is a TOCTOU (Time-of-Check to Time-of-Use) race condition
> in rxe_net_del(). Previously, the function fetched the socket pointer
> via rxe_ns_pernet_sk4/6() outside the critical section, and then
> acquired the lock to release it via rxe_sock_put().
> 
> In a highly concurrent teardown environment, another thread could close
> and clear the pernet socket after it was fetched but before the lock
> was acquired. This causes rxe_sock_put() to operate on a dangling or
> already cleared socket pointer, leading to a NULL pointer dereference
> when kernel_sock_shutdown() attempts to access sock->sk.
> 
> Fix this by introducing a dedicated, per-netns mutex 'release_lock'
> and extending its scope. The socket pointers are now fetched, checked,
> and released entirely within the same locked critical section. This
> ensures the atomicity of the socket lookup and teardown sequence.
> 
> Since new mutex lock is introduced, remove the unnecessary rcu locks.
> 
> Reported-by: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d8f76778263ab65c2b21
> Fixes: f1327abd6abe ("RDMA/rxe: Support RDMA link creation and destruction per net namespace")
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
> V1 -> V2: Remove the unnecessary rcu locks, following Leon's advice.
> ---
>   drivers/infiniband/sw/rxe/rxe_net.c | 49 +++++++++++++++++++-----
>   drivers/infiniband/sw/rxe/rxe_ns.c  | 58 ++++++++++++++++-------------
>   drivers/infiniband/sw/rxe/rxe_ns.h  |  3 ++
>   3 files changed, 74 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 50a2cb5405e2..0bf5b0eabc7b 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -135,13 +135,21 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
>   {
>   	struct dst_entry *ndst;
>   	struct flowi6 fl6 = {};
> +	struct sock *sk;
>   
>   	fl6.flowi6_oif = ndev->ifindex;
>   	memcpy(&fl6.saddr, saddr, sizeof(*saddr));
>   	memcpy(&fl6.daddr, daddr, sizeof(*daddr));
>   	fl6.flowi6_proto = IPPROTO_UDP;
>   
> -	ndst = ip6_dst_lookup_flow(net, rxe_ns_pernet_sk6(net), &fl6, NULL);
> +	rxe_ns_lock(net);
> +	sk = rxe_ns_pernet_sk6(net);
> +	if (sk)
> +		sock_hold(sk);
> +	rxe_ns_unlock(net);
> +
> +	ndst = ip6_dst_lookup_flow(net, sk, &fl6, NULL);
> +	sock_put(sk);
>   	if (IS_ERR(ndst)) {
>   		rxe_dbg_qp(qp, "no route to %pI6\n", daddr);
>   		return NULL;
> @@ -655,6 +663,8 @@ void rxe_net_del(struct ib_device *dev)
>   
>   	net = dev_net(ndev);
>   
> +	rxe_ns_lock(net);
> +
>   	sk = rxe_ns_pernet_sk4(net);
>   	if (sk)
>   		rxe_sock_put(sk, rxe_ns_pernet_set_sk4, net);
> @@ -663,6 +673,8 @@ void rxe_net_del(struct ib_device *dev)
>   	if (sk)
>   		rxe_sock_put(sk, rxe_ns_pernet_set_sk6, net);
>   
> +	rxe_ns_unlock(net);
> +
>   	dev_put(ndev);
>   }
>   
> @@ -754,52 +766,67 @@ static struct notifier_block rxe_net_notifier = {
>   
>   static int rxe_net_ipv4_init(struct net *net)
>   {
> -	struct sock *sk;
>   	struct socket *sock;
> +	struct sock *sk;
> +	int ret = 0;
>   
> +	rxe_ns_lock(net);
>   	sk = rxe_ns_pernet_sk4(net);
>   	if (sk) {
>   		sock_hold(sk);
> -		return 0;
> +		ret = 0;
> +		goto out_unlock;
>   	}
>   
>   	sock = rxe_setup_udp_tunnel(net, htons(ROCE_V2_UDP_DPORT), false);
>   	if (IS_ERR(sock)) {
>   		pr_err("Failed to create IPv4 UDP tunnel\n");
> -		return -1;
> +		ret = -1;
> +		goto out_unlock;
>   	}
> +
>   	rxe_ns_pernet_set_sk4(net, sock->sk);
>   
> -	return 0;
> +out_unlock:
> +	rxe_ns_unlock(net);
> +	return ret;
>   }
>   
>   static int rxe_net_ipv6_init(struct net *net)
>   {
> +	int ret = 0;
>   #if IS_ENABLED(CONFIG_IPV6)
> -	struct sock *sk;
>   	struct socket *sock;
> +	struct sock *sk;
>   
> +	rxe_ns_lock(net);
>   	sk = rxe_ns_pernet_sk6(net);
>   	if (sk) {
>   		sock_hold(sk);
> -		return 0;
> +		ret = 0;
> +		goto out_unlock;
>   	}
>   
>   	sock = rxe_setup_udp_tunnel(net, htons(ROCE_V2_UDP_DPORT), true);
>   	if (PTR_ERR(sock) == -EAFNOSUPPORT) {
>   		pr_warn("IPv6 is not supported, can not create a UDPv6 socket\n");
> -		return 0;
> +		ret = 0;
> +		goto out_unlock;
>   	}
>   
>   	if (IS_ERR(sock)) {
>   		pr_err("Failed to create IPv6 UDP tunnel\n");
> -		return -1;
> +		ret = -1;
> +		goto out_unlock;
>   	}
>   
>   	rxe_ns_pernet_set_sk6(net, sock->sk);
>   
> +out_unlock:
> +	rxe_ns_unlock(net);
> +
>   #endif
> -	return 0;
> +	return ret;
>   }
>   
>   int rxe_register_notifier(void)
> @@ -840,9 +867,11 @@ int rxe_net_init(struct net_device *ndev)
>   
>   err_out:
>   	/* If ipv6 error, release ipv4 resource */
> +	rxe_ns_lock(net);
>   	sk = rxe_ns_pernet_sk4(net);
>   	if (sk)
>   		rxe_sock_put(sk, rxe_ns_pernet_set_sk4, net);
> +	rxe_ns_unlock(net);
>   
>   	return err;
>   }
> diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
> index 8b9d734229b2..744a3d16f963 100644
> --- a/drivers/infiniband/sw/rxe/rxe_ns.c
> +++ b/drivers/infiniband/sw/rxe/rxe_ns.c
> @@ -14,8 +14,9 @@
>    * Per network namespace data
>    */
>   struct rxe_ns_sock {
> -	struct sock __rcu *rxe_sk4;
> -	struct sock __rcu *rxe_sk6;
> +	struct sock	*rxe_sk4;
> +	struct sock	*rxe_sk6;
> +	struct mutex	ns_mutex_lock;
>   };
>   
>   /*
> @@ -31,10 +32,26 @@ static int rxe_ns_init(struct net *net)
>   	/* defer socket create in the namespace to the first
>   	 * device create.
>   	 */
> +	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
>   
> +	mutex_init(&ns_sk->ns_mutex_lock);
>   	return 0;
>   }
>   
> +void rxe_ns_lock(struct net *net)
> +{
> +	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> +
> +	mutex_lock(&ns_sk->ns_mutex_lock);
> +}
> +
> +void rxe_ns_unlock(struct net *net)
> +{
> +	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> +
> +	mutex_unlock(&ns_sk->ns_mutex_lock);
> +}
> +
>   static void rxe_ns_exit(struct net *net)
>   {
>   	/* called when the network namespace is removed
> @@ -42,23 +59,24 @@ static void rxe_ns_exit(struct net *net)
>   	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
>   	struct sock *sk;
>   
> -	rcu_read_lock();
> -	sk = rcu_dereference(ns_sk->rxe_sk4);
> -	rcu_read_unlock();
> +	rxe_ns_lock(net);
> +	sk = ns_sk->rxe_sk4;
>   	if (sk) {
> -		rcu_assign_pointer(ns_sk->rxe_sk4, NULL);
> +		ns_sk->rxe_sk4 = NULL;
>   		udp_tunnel_sock_release(sk->sk_socket);
>   	}
>   
>   #if IS_ENABLED(CONFIG_IPV6)
> -	rcu_read_lock();
> -	sk = rcu_dereference(ns_sk->rxe_sk6);
> -	rcu_read_unlock();
> +	sk = ns_sk->rxe_sk6;
>   	if (sk) {
> -		rcu_assign_pointer(ns_sk->rxe_sk6, NULL);
> +		ns_sk->rxe_sk6 = NULL;
>   		udp_tunnel_sock_release(sk->sk_socket);
>   	}
>   #endif
> +
> +	rxe_ns_unlock(net);
> +
> +	mutex_destroy(&ns_sk->ns_mutex_lock);
>   }
>   
>   /*
> @@ -74,42 +92,30 @@ static struct pernet_operations rxe_net_ops = {
>   struct sock *rxe_ns_pernet_sk4(struct net *net)
>   {
>   	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> -	struct sock *sk;
> -
> -	rcu_read_lock();
> -	sk = rcu_dereference(ns_sk->rxe_sk4);
> -	rcu_read_unlock();
>   
> -	return sk;
> +	return ns_sk->rxe_sk4;
>   }
>   
>   void rxe_ns_pernet_set_sk4(struct net *net, struct sock *sk)
>   {
>   	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
>   
> -	rcu_assign_pointer(ns_sk->rxe_sk4, sk);
> -	synchronize_rcu();
> +	ns_sk->rxe_sk4 = sk;
>   }
>   
>   #if IS_ENABLED(CONFIG_IPV6)
>   struct sock *rxe_ns_pernet_sk6(struct net *net)
>   {
>   	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> -	struct sock *sk;
> -
> -	rcu_read_lock();
> -	sk = rcu_dereference(ns_sk->rxe_sk6);
> -	rcu_read_unlock();
>   
> -	return sk;
> +	return ns_sk->rxe_sk6;
>   }
>   
>   void rxe_ns_pernet_set_sk6(struct net *net, struct sock *sk)
>   {
>   	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
>   
> -	rcu_assign_pointer(ns_sk->rxe_sk6, sk);
> -	synchronize_rcu();
> +	ns_sk->rxe_sk6 = sk;
>   }
>   #endif /* IPV6 */
>   
> diff --git a/drivers/infiniband/sw/rxe/rxe_ns.h b/drivers/infiniband/sw/rxe/rxe_ns.h
> index 4da2709e6b71..e6cc6b5a4806 100644
> --- a/drivers/infiniband/sw/rxe/rxe_ns.h
> +++ b/drivers/infiniband/sw/rxe/rxe_ns.h
> @@ -20,6 +20,9 @@ static inline void rxe_ns_pernet_set_sk6(struct net *net, struct sock *sk)
>   }
>   #endif /* IPv6 */
>   
> +void rxe_ns_lock(struct net *net);
> +void rxe_ns_unlock(struct net *net);
> +
>   int rxe_namespace_init(void);
>   void rxe_namespace_exit(void);
>   


