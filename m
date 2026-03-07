Return-Path: <linux-rdma+bounces-17646-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHo8LJZ7q2kSdgEAu9opvQ
	(envelope-from <linux-rdma+bounces-17646-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 02:12:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0C4229480
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 02:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59824311E279
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Mar 2026 01:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D338428689B;
	Sat,  7 Mar 2026 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWK4NJbb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FF7281369;
	Sat,  7 Mar 2026 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772845822; cv=none; b=Zgi7KpBPPD35NtGuXl9TVAhw4rw4/YCNaV3+aQuYDiao+dqwKy9rjpyry/BxyfznylhzgMxdYod5YQ7IykDdU9Ef+XyUaPCq2+qE8DfVK34K1PJU2ElBbeYRCPW0p8ZTj9f6ElCTETfFAEHGMCcBCWePDva2rAQSyOtRsUKI/PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772845822; c=relaxed/simple;
	bh=TBYVzZDEXir/kQk/8T2c+45re3Z02TbzQzzl7y37OwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YhjGXUpr8o69I2CgSmbr/8fls82oSW1h2AK40kmyjS2nFKuWGB21wu3PIrwzIyOMnu1x2Aynd9ra18uItrIaPS5sf24VC/tZFKy0GjyH9tqyl7T9s/tLvfwmBPQOaX+Der5Ue1Z6wpj+ra9j3J202euanIPbCbxqs9iamrMNAcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWK4NJbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8D5C4CEF7;
	Sat,  7 Mar 2026 01:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772845822;
	bh=TBYVzZDEXir/kQk/8T2c+45re3Z02TbzQzzl7y37OwU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=iWK4NJbbbsF/nscT1gDWq1IFmrHSDx7I14Lfhl3dUKA983MJjVOUh7s2pm1JssAyE
	 UoPNkKxKbevSlHEC0JVOpEvMbcVqJa9w+Wdf86A3+6wj+5uClj6STcF+rCgEoLSfid
	 LkjIu8Je0fFYu4ULf9sfsXEa/UkC7P1iyRSkegQOaKyeZH+22Xyef0kPO881lKdDml
	 IxpD5n82DA3cU1qv1/68W5TvAONVkdV28xsAsCp0vNTQ98TZx0BVbIHI+tkL9svZcD
	 wfmXC1VCxLEi+cDn6/Wd0koAmJvqds2Ev7K5KkHL0hecz26yWB4srx0r1+Nm61BHZe
	 /HkjXuEpclXhA==
Message-ID: <85fc23ad-81d2-46ad-96ef-82a7a319bc6f@kernel.org>
Date: Fri, 6 Mar 2026 18:10:21 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] RDMA/rxe: Support RDMA link creation and destruction
 per net namespace
Content-Language: en-US
To: Zhu Yanjun <yanjun.zhu@linux.dev>, jgg@ziepe.ca, leon@kernel.org,
 zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260306082452.1822-1-yanjun.zhu@linux.dev>
 <20260306082452.1822-5-yanjun.zhu@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260306082452.1822-5-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5E0C4229480
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,ziepe.ca,kernel.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17646-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.929];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/6/26 1:24 AM, Zhu Yanjun wrote:
> @@ -253,15 +270,29 @@ static int __init rxe_module_init(void)
>  	if (err)
>  		return err;
>  
> -	err = rxe_net_init();
> +	rdma_link_register(&rxe_link_ops);
> +
> +	err = rxe_register_notifier();
>  	if (err) {
> -		rxe_destroy_wq();
> -		return err;
> +		pr_err("Failed to register netdev notifier\n");

drop the error message; rxe_register_notifier already logs it.

> +		goto err_wq;

		goto err_notifier;

err_wq is misleading since the wq init did not fail and neither did the
link register.


> +	}
> +
> +	err = rxe_namespace_init();
> +	if (err) {
> +		pr_err("Failed to register net namespace notifier\n");
> +		goto err_notifier;;

		goto err_namespace_init;

note that you have 2 ';' in your goto statement.

>  	}
>  
> -	rdma_link_register(&rxe_link_ops);

why move this register up? doing here after all initializations are
complete seems more appropriate to me.

>  	pr_info("loaded\n");
>  	return 0;
> +
> +err_notifier:
> +	rxe_net_exit(); /* unregister notifier */
> +err_wq:
> +	rdma_link_unregister(&rxe_link_ops);
> +	rxe_destroy_wq();
> +	return err;
>  }
>  
>  static void __exit rxe_module_exit(void)
> @@ -271,6 +302,8 @@ static void __exit rxe_module_exit(void)
>  	rxe_net_exit();
>  	rxe_destroy_wq();
>  
> +	rxe_namespace_exit();
> +
>  	pr_info("unloaded\n");
>  }
>  
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 0bd0902b11f7..ba5bc171a58e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -17,8 +17,7 @@
>  #include "rxe.h"
>  #include "rxe_net.h"
>  #include "rxe_loc.h"
> -
> -static struct rxe_recv_sockets recv_sockets;
> +#include "rxe_ns.h"
>  
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  /*
> @@ -114,7 +113,7 @@ static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
>  	memcpy(&fl.daddr, daddr, sizeof(*daddr));
>  	fl.flowi4_proto = IPPROTO_UDP;
>  
> -	rt = ip_route_output_key(&init_net, &fl);
> +	rt = ip_route_output_key(dev_net(ndev), &fl);

past struct net *net into both of the find_route functions. That is what
both of them care about, and then you can have rxe_find_route set the
namespace once.


>  	if (IS_ERR(rt)) {
>  		rxe_dbg_qp(qp, "no route to %pI4\n", &daddr->s_addr);
>  		return NULL;
> @@ -138,8 +137,8 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
>  	memcpy(&fl6.daddr, daddr, sizeof(*daddr));
>  	fl6.flowi6_proto = IPPROTO_UDP;
>  
> -	ndst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(recv_sockets.sk6->sk),
> -					       recv_sockets.sk6->sk, &fl6,
> +	ndst = ipv6_stub->ipv6_dst_lookup_flow(dev_net(ndev),
> +					       rxe_ns_pernet_sk6(dev_net(ndev)), &fl6,

and doing my comment above means you have 1 net reference and not 2
dev_net(ndev) changes here.

>  					       NULL);
>  	if (IS_ERR(ndst)) {
>  		rxe_dbg_qp(qp, "no route to %pI6\n", daddr);
> @@ -624,6 +623,43 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
>  	return 0;
>  }
>  
> +#define SK_REF_FOR_TUNNEL	2
> +
> +static void rxe_sock_put(struct sock *sk,
> +					void (*set_sk)(struct net *, struct sock *),
> +					struct net_device *ndev)
> +{
> +	if (refcount_read(&sk->sk_refcnt) > SK_REF_FOR_TUNNEL) {
> +		__sock_put(sk);
> +	} else {
> +		rxe_release_udp_tunnel(sk->sk_socket);
> +		sk = NULL;
> +		set_sk(dev_net(ndev), sk);
> +	}
> +}
> +
> +void rxe_net_del(struct ib_device *dev)
> +{
> +	struct rxe_dev *rxe = container_of(dev, struct rxe_dev, ib_dev);
> +	struct net_device *ndev;
> +	struct sock *sk;
	struct net *net;

> +
> +	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
> +	if (!ndev)
> +		return;

	net = dev_net(ndev);

then use just net in the calls below. This code is not operating under
RTNL, only the rdma nldev semaphore meaning the netdev can change
namespaces on you in between calls.

> +
> +	sk = rxe_ns_pernet_sk4(dev_net(ndev));
> +	if (sk)
> +		rxe_sock_put(sk, rxe_ns_pernet_set_sk4, ndev);
> +
> +	sk = rxe_ns_pernet_sk6(dev_net(ndev));
> +	if (sk)
> +		rxe_sock_put(sk, rxe_ns_pernet_set_sk6, ndev);
> +
> +	dev_put(ndev);
> +}
> +#undef SK_REF_FOR_TUNNEL
> +
>  static void rxe_port_event(struct rxe_dev *rxe,
>  			   enum ib_event_type event)
>  {
> @@ -680,6 +716,7 @@ static int rxe_notify(struct notifier_block *not_blk,
>  	switch (event) {
>  	case NETDEV_UNREGISTER:
>  		ib_unregister_device_queued(&rxe->ib_dev);
> +		rxe_net_del(&rxe->ib_dev);

make sure you have a test case for this -- the netdevice changing
namespaces on the rxe device.

>  		break;
>  	case NETDEV_CHANGEMTU:
>  		rxe_dbg_dev(rxe, "%s changed mtu to %d\n", ndev->name, ndev->mtu);
> @@ -709,66 +746,91 @@ static struct notifier_block rxe_net_notifier = {
>  	.notifier_call = rxe_notify,
>  };
>  
> -static int rxe_net_ipv4_init(void)
> +static int rxe_net_ipv4_init(struct net_device *ndev)

pass in struct net *net

>  {
> -	recv_sockets.sk4 = rxe_setup_udp_tunnel(&init_net,
> -				htons(ROCE_V2_UDP_DPORT), false);
> -	if (IS_ERR(recv_sockets.sk4)) {
> -		recv_sockets.sk4 = NULL;
> +	struct sock *sk;
> +	struct socket *sock;
> +
> +	sk = rxe_ns_pernet_sk4(dev_net(ndev));
> +	if (sk) {
> +		sock_hold(sk);
> +		return 0;
> +	}
> +
> +	sock = rxe_setup_udp_tunnel(dev_net(ndev), htons(ROCE_V2_UDP_DPORT), false);
> +	if (IS_ERR(sock)) {
>  		pr_err("Failed to create IPv4 UDP tunnel\n");
>  		return -1;
>  	}
> +	rxe_ns_pernet_set_sk4(dev_net(ndev), sock->sk);
>  
>  	return 0;
>  }
>  
> -static int rxe_net_ipv6_init(void)
> +static int rxe_net_ipv6_init(struct net_device *ndev)

same here, input argument should be struct net *net
>  {
>  #if IS_ENABLED(CONFIG_IPV6)
> +	struct sock *sk;
> +	struct socket *sock;
>  
> -	recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
> -						htons(ROCE_V2_UDP_DPORT), true);
> -	if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT) {
> -		recv_sockets.sk6 = NULL;
> +	sk = rxe_ns_pernet_sk6(dev_net(ndev));
> +	if (sk) {
> +		sock_hold(sk);
> +		return 0;
> +	}
> +
> +	sock = rxe_setup_udp_tunnel(dev_net(ndev), htons(ROCE_V2_UDP_DPORT), true);
> +	if (PTR_ERR(sock) == -EAFNOSUPPORT) {
>  		pr_warn("IPv6 is not supported, can not create a UDPv6 socket\n");
>  		return 0;
>  	}
>  
> -	if (IS_ERR(recv_sockets.sk6)) {
> -		recv_sockets.sk6 = NULL;
> +	if (IS_ERR(sock)) {
>  		pr_err("Failed to create IPv6 UDP tunnel\n");
>  		return -1;
>  	}
> +
> +	rxe_ns_pernet_set_sk6(dev_net(ndev), sock->sk);
> +
>  #endif
>  	return 0;
>  }
>  
> +int rxe_register_notifier(void)
> +{
> +	int err;
> +
> +	err = register_netdevice_notifier(&rxe_net_notifier);
> +	if (err) {
> +		pr_err("Failed to register netdev notifier\n");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
>  void rxe_net_exit(void)
>  {
> -	rxe_release_udp_tunnel(recv_sockets.sk6);
> -	rxe_release_udp_tunnel(recv_sockets.sk4);
>  	unregister_netdevice_notifier(&rxe_net_notifier);
>  }
>  
> -int rxe_net_init(void)
> +int rxe_net_init(struct net_device *ndev)
>  {
>  	int err;

	struct net *net = dev_net(ndev);

>  
> -	recv_sockets.sk6 = NULL;
> -
> -	err = rxe_net_ipv4_init();
> +	err = rxe_net_ipv4_init(ndev);
>  	if (err)
>  		return err;
> -	err = rxe_net_ipv6_init();
> +
> +	err = rxe_net_ipv6_init(ndev);
>  	if (err)
>  		goto err_out;
> -	err = register_netdevice_notifier(&rxe_net_notifier);
> -	if (err) {
> -		pr_err("Failed to register netdev notifier\n");
> -		goto err_out;
> -	}
> +
>  	return 0;
> +
>  err_out:
> -	rxe_net_exit();
> +	/* If ipv6 error, release ipv4 resource */
> +	udp_tunnel_sock_release(rxe_ns_pernet_sk4(dev_net(ndev))->sk_socket);
> +	rxe_ns_pernet_set_sk4(dev_net(ndev), NULL);
>  	return err;
>  }
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
> index 45d80d00f86b..56249677d692 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.h
> +++ b/drivers/infiniband/sw/rxe/rxe_net.h
> @@ -11,14 +11,11 @@
>  #include <net/if_inet6.h>
>  #include <linux/module.h>
>  
> -struct rxe_recv_sockets {
> -	struct socket *sk4;
> -	struct socket *sk6;
> -};
> -
>  int rxe_net_add(const char *ibdev_name, struct net_device *ndev);
> +void rxe_net_del(struct ib_device *dev);
>  
> -int rxe_net_init(void);
> +int rxe_register_notifier(void);
> +int rxe_net_init(struct net_device *ndev);
>  void rxe_net_exit(void);
>  
>  #endif /* RXE_NET_H */
> diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
> index 29d08899dcda..1ff34167a295 100644
> --- a/drivers/infiniband/sw/rxe/rxe_ns.c
> +++ b/drivers/infiniband/sw/rxe/rxe_ns.c

All of the changes to this file belong in the previous patch.

> @@ -39,7 +39,9 @@ static int __net_init rxe_ns_init(struct net *net)
>  	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
>  
>  	rcu_assign_pointer(ns_sk->rxe_sk4, NULL); /* initialize sock 4 socket */
> +#if IS_ENABLED(CONFIG_IPV6)
>  	rcu_assign_pointer(ns_sk->rxe_sk6, NULL); /* initialize sock 6 socket */
> +#endif /* IPV6 */
>  	synchronize_rcu();
>  
>  	return 0;
> @@ -52,11 +54,15 @@ static void __net_exit rxe_ns_exit(struct net *net)
>  	 */
>  	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
>  	struct sock *rxe_sk4 = NULL;
> +#if IS_ENABLED(CONFIG_IPV6)
>  	struct sock *rxe_sk6 = NULL;
> +#endif
>  
>  	rcu_read_lock();
>  	rxe_sk4 = rcu_dereference(ns_sk->rxe_sk4);
> +#if IS_ENABLED(CONFIG_IPV6)
>  	rxe_sk6 = rcu_dereference(ns_sk->rxe_sk6);
> +#endif
>  	rcu_read_unlock();
>  
>  	/* close socket */
> @@ -66,11 +72,13 @@ static void __net_exit rxe_ns_exit(struct net *net)
>  		synchronize_rcu();
>  	}
>  
> +#if IS_ENABLED(CONFIG_IPV6)
>  	if (rxe_sk6 && rxe_sk6->sk_socket) {
>  		udp_tunnel_sock_release(rxe_sk6->sk_socket);
>  		rcu_assign_pointer(ns_sk->rxe_sk6, NULL);
>  		synchronize_rcu();
>  	}
> +#endif
>  }
>  
>  /*
> @@ -103,6 +111,7 @@ void rxe_ns_pernet_set_sk4(struct net *net, struct sock *sk)
>  	synchronize_rcu();
>  }
>  
> +#if IS_ENABLED(CONFIG_IPV6)
>  struct sock *rxe_ns_pernet_sk6(struct net *net)
>  {
>  	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> @@ -123,6 +132,19 @@ void rxe_ns_pernet_set_sk6(struct net *net, struct sock *sk)
>  	synchronize_rcu();
>  }
>  
> +#else /* IPV6 */
> +
> +struct sock *rxe_ns_pernet_sk6(struct net *net)
> +{
> +	return NULL;
> +}
> +
> +void rxe_ns_pernet_set_sk6(struct net *net, struct sock *sk)
> +{
> +}
> +
> +#endif /* IPV6 */
> +
>  int __init rxe_namespace_init(void)
>  {
>  	return register_pernet_subsys(&rxe_net_ops);


