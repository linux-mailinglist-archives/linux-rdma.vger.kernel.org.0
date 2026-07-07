Return-Path: <linux-rdma+bounces-22866-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TSCbKCWJTWo11wEAu9opvQ
	(envelope-from <linux-rdma+bounces-22866-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 01:17:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3790F7205D8
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 01:17:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=ARf+dZ7R;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22866-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22866-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAC0F301DC22
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 23:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8E731A7E4;
	Tue,  7 Jul 2026 23:17:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECA42F6560
	for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2026 23:17:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783466238; cv=none; b=njkB+9VmdcaU6CQ+qpQpXW54+2YfymD5PXRgeq8a+K5PS+SQF/DTS4ptw2faJYvR3B0aDKLkKXka7bsxnxNMiunxF8wDqqhgIxYJ2UL9SFZoNNkvbCAfEpmSJMDRlwzVnJ/tFn7HwBAE4n7lGH/pA5z1tihccKUpUOY2vrFAT0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783466238; c=relaxed/simple;
	bh=7P+vAlyy4ELfx4F8CZysB4VCRbz+2HPSL9m1wJOnGe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3/x4X6ygwvqOHjrcx4nuQyEX5OX/+6yVAgNHOpioe66Rvx4imRU6rmnXm6tQT21QQYq5rn8flISo9Ed8gr9ap9FZvEwLf25XfN9hfYREpq21SG5nxQlXXuTQ2KCp56e6Cbw8zggJdiHeA0UHPMwsf9ZKseHy4IvpewTWupTjJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ARf+dZ7R; arc=none smtp.client-ip=91.218.175.184
Message-ID: <6ced0145-30ab-4af5-9005-9da024933fff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783466223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcXgQaDYgSQhv/m7uUk/Nt4NHNihQKEedi/4hj1/AGs=;
	b=ARf+dZ7RY9Jp1iVIz62HUEuQ//3m3cGPPzdsmP8+SwTK/kKc8ATGcUPRGMU1CdKL2lfrJj
	yixenSByluqEw5KA01raAAdbmAwdT9iRlEKgjIIUyQmR2HEpo01bxWjQkV5SwLU+pPkTKu
	tRNSjEIamddovVaHfzC+pqR7ooWsJ48=
Date: Tue, 7 Jul 2026 16:16:58 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] RDMA/rxe: rework per-net tunnel socket lifetime to fix
 refcount underflow
To: Serhat Kumral <serhatkumral1@gmail.com>, Zhu Yanjun
 <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: David Ahern <dsahern@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+8c9eede336e3a843750e@syzkaller.appspotmail.com
References: <20260707160015.18208-1-serhatkumral1@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260707160015.18208-1-serhatkumral1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22866-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:serhatkumral1@gmail.com,m:zyjzyj2000@gmail.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:yanjun.zhu@linux.dev,m:dsahern@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzbot+8c9eede336e3a843750e@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org,linux.dev];
	FORGED_SENDER(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-rdma,8c9eede336e3a843750e];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,appspotmail.com:email,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3790F7205D8


On 7/7/26 9:00 AM, Serhat Kumral wrote:
> syzkaller reported a refcount_t underflow / use-after-free in
> sk_common_release() when tearing down an rxe device via
> RDMA_NLDEV_CMD_DELLINK. The shared per-namespace UDP tunnel sockets
> were released based on comparing sk->sk_refcnt against a magic
> constant (SK_REF_FOR_TUNNEL), but the network stack takes transient
> references on sk_refcnt of its own, so this check could pass on more
> than one path concurrently (dellink, NETDEV_UNREGISTER notifier,
> pernet exit), releasing the socket twice.
>
> Stop overloading sk_refcnt for driver-level user counting. Track the
> number of rxe devices using each tunnel socket with an explicit
> per-socket counter in the pernet struct, serialised by a mutex:
>
>   - creation happens under the lock via a factory callback, closing
>     the create/create race,
>   - release happens in exactly one place, when the counter drops to
>     zero: clear the RCU pointer, wait a grace period, then call
>     udp_tunnel_sock_release(),
>   - rxe_net_del() is idempotent per device: RDMA_NLDEV_CMD_DELLINK
>     and the NETDEV_UNREGISTER notifier can run concurrently for the
>     same device, and only the first invocation drops the references.
>     The put uses the net pointer recorded at device creation time
>     instead of ib_device_get_netdev(), which can already return NULL
>     at this point (the queued unregister clears the association), so
>     the invocation that owns the put can never fail to perform it,
>   - a failed rxe_newlink() now drops the references it took, so the
>     counter cannot be left inflated,
>   - rxe_ns_exit() performs the same coordinated teardown for
>     namespace removal.
>
> IPv4 and IPv6 sockets get separate counters since the IPv6 socket may
> legitimately not exist (-EAFNOSUPPORT).
>
> Fixes: f1327abd6abe ("RDMA/rxe: Support RDMA link creation and destruction per net namespace")
> Reported-by: syzbot+8c9eede336e3a843750e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8c9eede336e3a843750e
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Serhat Kumral <serhatkumral1@gmail.com>
> ---
> v3:
>   - Fix the ordering problem Zhu Yanjun pointed out in v2: rxe_net_del()
>     consumed the once-only RXE_NET_SK_PUT bit before looking up the
>     netdev, so if ib_device_get_netdev() returned NULL (the queued
>     unregister already cleared the association), the pernet socket
>     references were never dropped. [Zhu Yanjun]
>   - Instead of only reordering the bit test against the netdev lookup,
>     record the struct net pointer in struct rxe_dev at creation time
>     and use it for the put, so the put cannot fail at all once the bit
>     is taken. I went this way because a reordered lookup still has a
>     (much smaller) window where both racing paths see a NULL netdev.
>     If you think this is over-engineered and would prefer the minimal
>     reordering fix, I am happy to respin it that way.
>
> v2:
>   - Make rxe_net_del() idempotent per device with test_and_set_bit()
>     in struct rxe_dev, so a concurrent RDMA_NLDEV_CMD_DELLINK and
>     NETDEV_UNREGISTER notifier cannot drop the pernet socket
>     references twice for the same device. Suggested as an alternative
>     to rtnl_lock()/a global mutex. [Zhu Yanjun]
>   - Add Assisted-by tag per Documentation/process/coding-assistants.rst.
>
>   drivers/infiniband/sw/rxe/rxe.c       |   1 +
>   drivers/infiniband/sw/rxe/rxe_net.c   | 117 ++++++++++-------------
>   drivers/infiniband/sw/rxe/rxe_net.h   |   1 +
>   drivers/infiniband/sw/rxe/rxe_ns.c    | 132 +++++++++++++++++++-------
>   drivers/infiniband/sw/rxe/rxe_ns.h    |  24 ++++-
>   drivers/infiniband/sw/rxe/rxe_verbs.h |   8 ++
>   6 files changed, 177 insertions(+), 106 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index af39209d0fcf..bcc72b96ee00 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -243,6 +243,7 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
>   	err = rxe_net_add(ibdev_name, ndev);
>   	if (err) {
>   		rxe_err("failed to add %s\n", ndev->name);
> +		rxe_net_uninit(ndev);
>   		goto err;
>   	}
>   err:
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 3741b2c4b0bb..02c0d2be36ad 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -19,10 +19,6 @@
>   #include "rxe_loc.h"
>   #include "rxe_ns.h"
>   
> -#ifndef SK_REF_FOR_TUNNEL
> -#define SK_REF_FOR_TUNNEL	2
> -#endif
> -
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   /*
>    * lockdep can detect false positive circular dependencies
> @@ -81,9 +77,9 @@ static inline void rxe_reclassify_recv_socket(struct socket *sock)
>   	 * from being called and 'rmmod rdma_rxe'
>   	 * is refused because of the references.
>   	 *
> -	 * For the global sockets in recv_sockets,
> -	 * we are sure that rxe_net_exit() will call
> -	 * rxe_release_udp_tunnel -> udp_tunnel_sock_release.
> +	 * For the shared per-namespace sockets, we are sure
> +	 * that the pernet layer (rxe_ns_pernet_put_skX or
> +	 * rxe_ns_exit) will call udp_tunnel_sock_release.
>   	 *
>   	 * So we don't need the additional reference to
>   	 * our own (THIS_MODULE).
> @@ -288,12 +284,6 @@ static struct socket *rxe_setup_udp_tunnel(struct net *net, __be16 port,
>   	return sock;
>   }
>   
> -static void rxe_release_udp_tunnel(struct sock *sk)
> -{
> -	if (sk)
> -		udp_tunnel_sock_release(sk);
> -}
> -
>   static void prepare_udp_hdr(struct sk_buff *skb, __be16 src_port,
>   			    __be16 dst_port)
>   {
> @@ -620,6 +610,8 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
>   	if (!rxe)
>   		return -ENOMEM;
>   
> +	rxe->net = dev_net(ndev);
> +
>   	ib_mark_name_assigned_by_user(&rxe->ib_dev);
>   
>   	err = rxe_add(rxe, ndev->mtu, ibdev_name, ndev);
> @@ -631,40 +623,30 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
>   	return 0;
>   }
>   
> -static void rxe_sock_put(struct sock *sk,
> -					void (*set_sk)(struct net *, struct sock *),
> -					struct net *net)
> +void rxe_net_uninit(struct net_device *ndev)
>   {
> -	if (refcount_read(&sk->sk_refcnt) > SK_REF_FOR_TUNNEL) {
> -		__sock_put(sk);
> -	} else {
> -		rxe_release_udp_tunnel(sk);
> -		sk = NULL;
> -		set_sk(net, sk);
> -	}
> +	struct net *net = dev_net(ndev);
> +
> +	rxe_ns_pernet_put_sk4(net);
> +	rxe_ns_pernet_put_sk6(net);
>   }
>   
>   void rxe_net_del(struct ib_device *dev)
>   {
> -	struct net_device *ndev;
> -	struct sock *sk;
> -	struct net *net;
> +	struct rxe_dev *rxe = container_of(dev, struct rxe_dev, ib_dev);
>   
> -	ndev = ib_device_get_netdev(dev, 1);
> -	if (!ndev)
> +	/*
> +	 * Both RDMA_NLDEV_CMD_DELLINK and the NETDEV_UNREGISTER notifier
> +	 * can get here concurrently for the same device. Only the first
> +	 * one drops the pernet socket references. Use the net recorded
> +	 * at rxe_net_add() time: the ib_device to netdev association may
> +	 * already be gone here, so the put must not depend on it.
> +	 */
> +	if (test_and_set_bit(RXE_NET_SK_PUT, &rxe->net_flags))
>   		return;
>   
> -	net = dev_net(ndev);
> -
> -	sk = rxe_ns_pernet_sk4(net);
> -	if (sk)
> -		rxe_sock_put(sk, rxe_ns_pernet_set_sk4, net);
> -
> -	sk = rxe_ns_pernet_sk6(net);
> -	if (sk)
> -		rxe_sock_put(sk, rxe_ns_pernet_set_sk6, net);
> -
> -	dev_put(ndev);
> +	rxe_ns_pernet_put_sk4(rxe->net);
> +	rxe_ns_pernet_put_sk6(rxe->net);
>   }
>   
>   static void rxe_port_event(struct rxe_dev *rxe,
> @@ -753,52 +735,58 @@ static struct notifier_block rxe_net_notifier = {
>   	.notifier_call = rxe_notify,
>   };
>   
> -static int rxe_net_ipv4_init(struct net *net)
> +static struct sock *rxe_create_sk4(struct net *net)
>   {
> -	struct sock *sk;
>   	struct socket *sock;
>   
> -	sk = rxe_ns_pernet_sk4(net);
> -	if (sk) {
> -		sock_hold(sk);
> -		return 0;
> -	}
> -
>   	sock = rxe_setup_udp_tunnel(net, htons(ROCE_V2_UDP_DPORT), false);
>   	if (IS_ERR(sock)) {
>   		pr_err("Failed to create IPv4 UDP tunnel\n");
> -		return -1;
> +		return ERR_CAST(sock);
>   	}
> -	rxe_ns_pernet_set_sk4(net, sock->sk);
>   
> -	return 0;
> +	return sock->sk;
>   }
>   
> -static int rxe_net_ipv6_init(struct net *net)
> +static int rxe_net_ipv4_init(struct net *net)
>   {
> -#if IS_ENABLED(CONFIG_IPV6)
>   	struct sock *sk;
> -	struct socket *sock;
>   
> -	sk = rxe_ns_pernet_sk6(net);
> -	if (sk) {
> -		sock_hold(sk);
> -		return 0;
> -	}
> +	sk = rxe_ns_pernet_hold_sk4(net, rxe_create_sk4);
> +	if (IS_ERR(sk))
> +		return PTR_ERR(sk);
> +
> +	return 0;
> +}
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +static struct sock *rxe_create_sk6(struct net *net)
> +{
> +	struct socket *sock;
>   
>   	sock = rxe_setup_udp_tunnel(net, htons(ROCE_V2_UDP_DPORT), true);
>   	if (PTR_ERR(sock) == -EAFNOSUPPORT) {
>   		pr_warn("IPv6 is not supported, can not create a UDPv6 socket\n");
> -		return 0;
> +		return NULL;
>   	}
>   
>   	if (IS_ERR(sock)) {
>   		pr_err("Failed to create IPv6 UDP tunnel\n");
> -		return -1;
> +		return ERR_CAST(sock);
>   	}
>   
> -	rxe_ns_pernet_set_sk6(net, sock->sk);
> +	return sock->sk;
> +}
> +#endif
> +
> +static int rxe_net_ipv6_init(struct net *net)
> +{
> +#if IS_ENABLED(CONFIG_IPV6)
> +	struct sock *sk;
>   
> +	sk = rxe_ns_pernet_hold_sk6(net, rxe_create_sk6);
> +	if (IS_ERR(sk))
> +		return PTR_ERR(sk);
>   #endif
>   	return 0;
>   }
> @@ -824,7 +812,6 @@ void rxe_net_exit(void)
>   int rxe_net_init(struct net_device *ndev)
>   {
>   	struct net *net;
> -	struct sock *sk;
>   	int err;
>   
>   	net = dev_net(ndev);
> @@ -840,10 +827,8 @@ int rxe_net_init(struct net_device *ndev)
>   	return 0;
>   
>   err_out:
> -	/* If ipv6 error, release ipv4 resource */
> -	sk = rxe_ns_pernet_sk4(net);
> -	if (sk)
> -		rxe_sock_put(sk, rxe_ns_pernet_set_sk4, net);
> +	/* If ipv6 error, drop the ipv4 reference taken above. */
> +	rxe_ns_pernet_put_sk4(net);
>   
>   	return err;
>   }
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
> index 56249677d692..06e08a4d5897 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.h
> +++ b/drivers/infiniband/sw/rxe/rxe_net.h
> @@ -13,6 +13,7 @@
>   
>   int rxe_net_add(const char *ibdev_name, struct net_device *ndev);
>   void rxe_net_del(struct ib_device *dev);
> +void rxe_net_uninit(struct net_device *ndev);
>   
>   int rxe_register_notifier(void);
>   int rxe_net_init(struct net_device *ndev);
> diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
> index 64621c89f8bf..d12099a73aa2 100644
> --- a/drivers/infiniband/sw/rxe/rxe_ns.c
> +++ b/drivers/infiniband/sw/rxe/rxe_ns.c
> @@ -4,6 +4,8 @@
>   #include <net/netns/generic.h>
>   #include <net/net_namespace.h>
>   #include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/err.h>
>   #include <linux/skbuff.h>
>   #include <linux/pid_namespace.h>
>   #include <net/udp_tunnel.h>
> @@ -11,11 +13,21 @@
>   #include "rxe_ns.h"
>   
>   /*
> - * Per network namespace data
> + * Per network namespace data.
> + *
> + * The IPv4/IPv6 UDP tunnel sockets are shared by every rxe device created in
> + * a given namespace. Their lifetime is owned here and tracked by an explicit
> + * user count (nr_skX) rather than by overloading sk->sk_refcnt: the network
> + * stack takes transient references on sk_refcnt of its own, so it can never be
> + * used to decide when the last rxe device is gone. All fields are serialised
> + * by @lock.
>    */
>   struct rxe_ns_sock {
> +	struct mutex lock; /* protects rxe_sk4/6 and nr_sk4/6 */
>   	struct sock __rcu *rxe_sk4;
>   	struct sock __rcu *rxe_sk6;
> +	int nr_sk4;
> +	int nr_sk6;
>   };
>   
>   /*
> @@ -28,37 +40,39 @@ static unsigned int rxe_pernet_id;
>    */
>   static int rxe_ns_init(struct net *net)
>   {
> -	/* defer socket create in the namespace to the first
> -	 * device create.
> -	 */
> +	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> +
> +	/* Socket creation is deferred to the first device create. */
> +	mutex_init(&ns_sk->lock);
>   
>   	return 0;
>   }
>   
>   static void rxe_ns_exit(struct net *net)
>   {
> -	/* called when the network namespace is removed
> -	 */
> +	/* called when the network namespace is removed */
>   	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> -	struct sock *sk;
> -
> -	rcu_read_lock();
> -	sk = rcu_dereference(ns_sk->rxe_sk4);
> -	rcu_read_unlock();
> -	if (sk) {
> -		rcu_assign_pointer(ns_sk->rxe_sk4, NULL);
> -		udp_tunnel_sock_release(sk);
> -	}
> -
> -#if IS_ENABLED(CONFIG_IPV6)
> -	rcu_read_lock();
> -	sk = rcu_dereference(ns_sk->rxe_sk6);
> -	rcu_read_unlock();
> -	if (sk) {
> -		rcu_assign_pointer(ns_sk->rxe_sk6, NULL);
> -		udp_tunnel_sock_release(sk);
> -	}
> -#endif
> +	struct sock *sk4, *sk6;
> +
> +	mutex_lock(&ns_sk->lock);
> +	sk4 = rcu_dereference_protected(ns_sk->rxe_sk4,
> +					lockdep_is_held(&ns_sk->lock));
> +	sk6 = rcu_dereference_protected(ns_sk->rxe_sk6,
> +					lockdep_is_held(&ns_sk->lock));
> +	rcu_assign_pointer(ns_sk->rxe_sk4, NULL);
> +	rcu_assign_pointer(ns_sk->rxe_sk6, NULL);
> +	ns_sk->nr_sk4 = 0;
> +	ns_sk->nr_sk6 = 0;
> +	mutex_unlock(&ns_sk->lock);
> +
> +	if (sk4 || sk6)
> +		synchronize_rcu();
> +	if (sk4)
> +		udp_tunnel_sock_release(sk4);
> +	if (sk6)
> +		udp_tunnel_sock_release(sk6);
> +
> +	mutex_destroy(&ns_sk->lock);

When a network namespace containing an RDMA link is destroyed, 
rxe_ns_exit() is invoked.

At the end of this function, mutex_destroy(&ns_sk->lock) is called to 
destroy the ns_sk->lock mutex.

However, after the network namespace teardown, the associated netdevice 
is still unregistered, which

triggers the NETDEV_UNREGISTER notifier. In rxe_notify(), this event 
eventually calls rxe_net_del() to

remove the RDMA link.

rxe_net_del() acquires ns_sk->lock again, even though the mutex has 
already been destroyed by rxe_ns_exit().

This results in a use-after-free (or use-after-destroy) of the mutex.


Zhu Yanjun


>   }
>   
>   /*
> @@ -71,24 +85,64 @@ static struct pernet_operations rxe_net_ops = {
>   	.size = sizeof(struct rxe_ns_sock),
>   };
>   
> -struct sock *rxe_ns_pernet_sk4(struct net *net)
> +static struct sock *rxe_ns_hold(struct rxe_ns_sock *ns_sk,
> +				struct sock __rcu **skp, int *nrp,
> +				struct net *net, rxe_sk_create_t create)
>   {
> -	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
>   	struct sock *sk;
>   
> -	rcu_read_lock();
> -	sk = rcu_dereference(ns_sk->rxe_sk4);
> -	rcu_read_unlock();
> +	mutex_lock(&ns_sk->lock);
> +	sk = rcu_dereference_protected(*skp, lockdep_is_held(&ns_sk->lock));
> +	if (sk) {
> +		(*nrp)++;
> +		mutex_unlock(&ns_sk->lock);
> +		return sk;
> +	}
> +
> +	sk = create(net);
> +	if (IS_ERR_OR_NULL(sk)) {
> +		mutex_unlock(&ns_sk->lock);
> +		return sk;
> +	}
> +
> +	rcu_assign_pointer(*skp, sk);
> +	*nrp = 1;
> +	mutex_unlock(&ns_sk->lock);
>   
>   	return sk;
>   }
>   
> -void rxe_ns_pernet_set_sk4(struct net *net, struct sock *sk)
> +static void rxe_ns_put(struct rxe_ns_sock *ns_sk,
> +		       struct sock __rcu **skp, int *nrp)
> +{
> +	struct sock *sk = NULL;
> +
> +	mutex_lock(&ns_sk->lock);
> +	if (*nrp > 0 && --(*nrp) == 0) {
> +		sk = rcu_dereference_protected(*skp,
> +					       lockdep_is_held(&ns_sk->lock));
> +		rcu_assign_pointer(*skp, NULL);
> +	}
> +	mutex_unlock(&ns_sk->lock);
> +
> +	if (sk) {
> +		synchronize_rcu();
> +		udp_tunnel_sock_release(sk);
> +	}
> +}
> +
> +struct sock *rxe_ns_pernet_hold_sk4(struct net *net, rxe_sk_create_t create)
> +{
> +	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> +
> +	return rxe_ns_hold(ns_sk, &ns_sk->rxe_sk4, &ns_sk->nr_sk4, net, create);
> +}
> +
> +void rxe_ns_pernet_put_sk4(struct net *net)
>   {
>   	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
>   
> -	rcu_assign_pointer(ns_sk->rxe_sk4, sk);
> -	synchronize_rcu();
> +	rxe_ns_put(ns_sk, &ns_sk->rxe_sk4, &ns_sk->nr_sk4);
>   }
>   
>   #if IS_ENABLED(CONFIG_IPV6)
> @@ -104,12 +158,18 @@ struct sock *rxe_ns_pernet_sk6(struct net *net)
>   	return sk;
>   }
>   
> -void rxe_ns_pernet_set_sk6(struct net *net, struct sock *sk)
> +struct sock *rxe_ns_pernet_hold_sk6(struct net *net, rxe_sk_create_t create)
> +{
> +	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> +
> +	return rxe_ns_hold(ns_sk, &ns_sk->rxe_sk6, &ns_sk->nr_sk6, net, create);
> +}
> +
> +void rxe_ns_pernet_put_sk6(struct net *net)
>   {
>   	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
>   
> -	rcu_assign_pointer(ns_sk->rxe_sk6, sk);
> -	synchronize_rcu();
> +	rxe_ns_put(ns_sk, &ns_sk->rxe_sk6, &ns_sk->nr_sk6);
>   }
>   #endif /* IPV6 */
>   
> diff --git a/drivers/infiniband/sw/rxe/rxe_ns.h b/drivers/infiniband/sw/rxe/rxe_ns.h
> index 4da2709e6b71..fe96b8abb8dc 100644
> --- a/drivers/infiniband/sw/rxe/rxe_ns.h
> +++ b/drivers/infiniband/sw/rxe/rxe_ns.h
> @@ -3,19 +3,35 @@
>   #ifndef RXE_NS_H
>   #define RXE_NS_H
>   
> -struct sock *rxe_ns_pernet_sk4(struct net *net);
> -void rxe_ns_pernet_set_sk4(struct net *net, struct sock *sk);
> +/*
> + * Factory used to create a shared per-namespace tunnel socket while the
> + * pernet lock is held. It must return:
> + *   - a valid sk on success,
> + *   - NULL if the address family is unsupported (not treated as an error),
> + *   - an ERR_PTR() on failure.
> + */
> +typedef struct sock *(*rxe_sk_create_t)(struct net *net);
> +
> +struct sock *rxe_ns_pernet_hold_sk4(struct net *net, rxe_sk_create_t create);
> +void rxe_ns_pernet_put_sk4(struct net *net);
>   
>   #if IS_ENABLED(CONFIG_IPV6)
> -void rxe_ns_pernet_set_sk6(struct net *net, struct sock *sk);
>   struct sock *rxe_ns_pernet_sk6(struct net *net);
> +struct sock *rxe_ns_pernet_hold_sk6(struct net *net, rxe_sk_create_t create);
> +void rxe_ns_pernet_put_sk6(struct net *net);
>   #else /* IPv6 */
>   static inline struct sock *rxe_ns_pernet_sk6(struct net *net)
>   {
>   	return NULL;
>   }
>   
> -static inline void rxe_ns_pernet_set_sk6(struct net *net, struct sock *sk)
> +static inline struct sock *rxe_ns_pernet_hold_sk6(struct net *net,
> +						  rxe_sk_create_t create)
> +{
> +	return NULL;
> +}
> +
> +static inline void rxe_ns_pernet_put_sk6(struct net *net)
>   {
>   }
>   #endif /* IPv6 */
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index 0f5ffd94643f..ffb2e2a71737 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -415,12 +415,20 @@ struct rxe_port {
>   	u32			qp_gsi_index;
>   };
>   
> +enum rxe_net_flags {
> +	/* rxe_net_del() must drop the pernet socket refs exactly once */
> +	RXE_NET_SK_PUT,
> +};
> +
>   struct rxe_dev {
>   	struct ib_device	ib_dev;
>   	struct ib_device_attr	attr;
>   	int			max_ucontext;
>   	int			max_inline_data;
>   	struct mutex		usdev_lock;
> +	unsigned long		net_flags;
> +	/* netns whose pernet socket references this device holds */
> +	struct net		*net;
>   
>   	char			raw_gid[ETH_ALEN];
>   

