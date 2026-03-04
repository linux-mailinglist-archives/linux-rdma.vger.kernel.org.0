Return-Path: <linux-rdma+bounces-17456-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDqBJby4p2mmjQAAu9opvQ
	(envelope-from <linux-rdma+bounces-17456-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 05:44:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A031FAC01
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 05:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C2A03054BB3
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 04:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9C237F750;
	Wed,  4 Mar 2026 04:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J/vnzYmv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AEA364E9E
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 04:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772599478; cv=none; b=jppIbyt4ejZ2jyXBgiMBfpKVdcvwoui0p+050sFvp4fSUsX5vvIs9hkZP4A8gv4viDRcZTrXkmuh7p+DlCcHAlB3IaVPNYXGhnTRypLyH8BTWTXKp0LasRVuoC+lMCgWcPFFvAUKeG3W0uMoCrjpOWwjO6yw8nDNXXIGOS5dWSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772599478; c=relaxed/simple;
	bh=uj5bJQBpQZQrrfFFesPQAzbbhkdio1Yl9AvG/fW4bOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QMWetLO9L2ElCOSnK09tnKNBhV4guwfdDhwtL1McE4YkSFRft9J5k11BoyI4prwZsrwfI/W48JG7zBwepDH/rXOdRsE0X2SIar9GNMAy1t+HkbyX0+Kw+SKDOfx+/6ohn9/BDMuFs0i+Qne4HseJVj9TEWvEY0uDdZfE9oabiWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J/vnzYmv; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <28be84a9-ad21-4a29-8199-a155e63e4cd8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772599474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=buTX5eCeazsMO5Z4L123H7en2h7ci5/hn9yyiVqUlpw=;
	b=J/vnzYmvVK4L592Di+AXsJ/fPMEBxiX9nk9GpX4810Eigu85Xj7gXCQdHz6VZbLObvBg06
	qslWbKBJyxxbTjkPTcWocJiDI2Qrc4LfDNh4WAJEbNJYv4K6V8VK1iY08Ji8Cy2F+M4Rs3
	eI40Lbot6VpNsUgm3ZWZ6HynYkvkysY=
Date: Tue, 3 Mar 2026 20:44:28 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv2 1/1] RDMA/rxe: Add the support that rxe can work in net
 namespace
To: jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com, dsahern@kernel.org,
 linux-rdma@vger.kernel.org
References: <20260304041607.11685-1-yanjun.zhu@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260304041607.11685-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: C9A031FAC01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-17456-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action

在 2026/3/3 20:16, Zhu Yanjun 写道:
> When run "ip link add" command to add a rxe rdma link in a net
> namespace, normally this rxe rdma link can not work in a net
> name space.
> 
> The root cause is that a sock listening on udp port 4791 is created
> in init_net when the rdma_rxe module is loaded into kernel. That is,
> the sock listening on udp port 4791 is created in init_net. Other net
> namespace is difficult to use this sock.
> 
> The following commits will solve this problem.
> 
> In the first commit, move the creating sock listening on udp port 4791
> from module_init function to rdma link creating functions. That is,
> after the module rdma_rxe is loaded, the sock will not be created.
> When run "rdma link add ..." command, the sock will be created. So
> when creating a rdma link in the net namespace, the sock will be
> created in this net namespace.
> 
> In the second commit, the functions udp4_lib_lookup and udp6_lib_lookup
> will check the sock exists in the net namespace or not. If yes, rdma
> link will increase the reference count of this sock, then continue other
> jobs instead of creating a new sock to listen on udp port 4791. Since the
> network notifier is global, when the module rdma_rxe is loaded, this
> notifier will be registered.
> 
> After the rdma link is created, the command "rdma link del" is to
> delete rdma link at the same time the sock is checked. If the reference
> count of this sock is greater than the sock reference count needed by
> udp tunnel, the sock reference count is decreased by one. If equal, it
> indicates that this rdma link is the last one. As such, the udp tunnel
> is shut down and the sock is closed. The above work should be
> implemented in linkdel function. But currently no dellink function in
> rxe. So the 3rd commit addes dellink function pointer. And the 4th
> commit implements the dellink function in rxe.
> 
> To now, it is not necessary to keep a global variable to store the sock
> listening udp port 4791. This global variable can be replaced by the
> functions udp4_lib_lookup and udp6_lib_lookup totally. Because the
> function udp6_lib_lookup is in the fast path, a member variable l_sk6
> is added to store the sock. If l_sk6 is NULL, udp6_lib_lookup is called
> to lookup the sock, then the sock is stored in l_sk6, in the future,it
> can be used directly.
> 
> All the above work has been done in init_net. And it can also work in
> the net namespace. So the init_net is replaced by the individual net
> namespace. This is what the 6th commit does. Because rxe device is
> dependent on the net device and the sock listening on udp port 4791,
> every rxe device is in exclusive mode in the individual net namespace.
> Other rdma netns operations will be considerred in the future.
> 
> In the 7th commit, the register_pernet_subsys/unregister_pernet_subsys
> functions are added. When a new net namespace is created, the init
> function will initialize the sk4 and sk6 socks. Then the 2 socks will
> be released when the net namespace is destroyed. The functions
> rxe_ns_pernet_sk4/rxe_ns_pernet_set_sk4 will get and set sk4 in the net
> namespace. The functions rxe_ns_pernet_sk6/rxe_ns_pernet_set_sk6 will
> handle sk6. Then sk4 and sk6 are used in the previous commits.
> 
> As the sk4 and sk6 in pernet namespace can be accessed, it is not
> necessary to add a new l_sk6. As such, in the 8th commit, the l_sk6 is
> replaced with the sk6 in pernet namespace.
> 
> Test steps:
> 1) Suppose that 2 NICs are in 2 different net namespaces.
> 
>    # ip netns exec net0 ip link
>    3: eno2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
>       link/ether 00:1e:67:a0:22:3f brd ff:ff:ff:ff:ff:ff
>       altname enp5s0
> 
>    # ip netns exec net1 ip link
>    4: eno3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel
>       link/ether f8:e4:3b:3b:e4:10 brd ff:ff:ff:ff:ff:ff
> 
> 2) Add rdma link in the different net namespace
>      net0:
>      # ip netns exec net0 rdma link add rxe0 type rxe netdev eno2
> 
>      net1:
>      # ip netns exec net1 rdma link add rxe1 type rxe netdev eno3
> 
> 3) Run rping test.
>      net0
>      # ip netns exec net0 rping -s -a 192.168.2.1 -C 1&
>      [1] 1737
>      # ip netns exec net1 rping -c -a 192.168.2.1 -d -v -C 1
>      verbose
>      count 1
>      ...
>      ping data: rdma-ping-0: ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqr
>      ...
> 
> 4) Remove the rdma links from the net namespaces.
>      net0:
>      # ip netns exec net0 ss -lu
>      State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port    Process
>      UNCONN    0         0         0.0.0.0:4791          0.0.0.0:*
>      UNCONN    0         0         [::]:4791             [::]:*
> 
>      # ip netns exec net0 rdma link del rxe0
> 
>      # ip netns exec net0 ss -lu
>      State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port    Process
> 
>      net1:
>      # ip netns exec net0 ss -lu
>      State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port    Process
>      UNCONN    0         0         0.0.0.0:4791          0.0.0.0:*
>      UNCONN    0         0         [::]:4791             [::]:*
> 
>      # ip netns exec net1 rdma link del rxe1
> 
>      # ip netns exec net0 ss -lu
>      State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port    Process
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Hi, all

The script in the link 
https://github.com/zhuyj/linux/blob/6.19-net-namespace/net_ns_rxe.sh can 
make tests in linux distributions.

BTW, please disable firewall before making tests.

Zhu Yanjun

> ---
> 1. Use net_generic;
> 2. Add ipv6 check;
> 3. Use a function to handle ipv4/6 socket;
> ---
>   drivers/infiniband/core/nldev.c     |   6 ++
>   drivers/infiniband/sw/rxe/Makefile  |   3 +-
>   drivers/infiniband/sw/rxe/rxe.c     |  32 +++++-
>   drivers/infiniband/sw/rxe/rxe_net.c | 132 +++++++++++++++++------
>   drivers/infiniband/sw/rxe/rxe_net.h |   9 +-
>   drivers/infiniband/sw/rxe/rxe_ns.c  | 156 ++++++++++++++++++++++++++++
>   drivers/infiniband/sw/rxe/rxe_ns.h  |  17 +++
>   include/rdma/rdma_netlink.h         |   2 +
>   8 files changed, 316 insertions(+), 41 deletions(-)
>   create mode 100644 drivers/infiniband/sw/rxe/rxe_ns.c
>   create mode 100644 drivers/infiniband/sw/rxe/rxe_ns.h
> 
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index 2220a2dfab24..48684930660a 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -1824,6 +1824,12 @@ static int nldev_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
>   		return -EINVAL;
>   	}
>   
> +	if (device->link_ops) {
> +		err = device->link_ops->dellink(device);
> +		if (err)
> +			return err;
> +	}
> +
>   	ib_unregister_device_and_put(device);
>   	return 0;
>   }
> diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
> index 93134f1d1d0c..3977f4f13258 100644
> --- a/drivers/infiniband/sw/rxe/Makefile
> +++ b/drivers/infiniband/sw/rxe/Makefile
> @@ -22,6 +22,7 @@ rdma_rxe-y := \
>   	rxe_mcast.o \
>   	rxe_task.o \
>   	rxe_net.o \
> -	rxe_hw_counters.o
> +	rxe_hw_counters.o \
> +	rxe_ns.o
>   
>   rdma_rxe-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += rxe_odp.o
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index e891199cbdef..165155f9be6d 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -8,6 +8,8 @@
>   #include <net/addrconf.h>
>   #include "rxe.h"
>   #include "rxe_loc.h"
> +#include "rxe_net.h"
> +#include "rxe_ns.h"
>   
>   MODULE_AUTHOR("Bob Pearson, Frank Zago, John Groves, Kamal Heib");
>   MODULE_DESCRIPTION("Soft RDMA transport");
> @@ -200,6 +202,8 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
>   	port->mtu_cap = ib_mtu_enum_to_int(mtu);
>   }
>   
> +static struct rdma_link_ops rxe_link_ops;
> +
>   /* called by ifc layer to create new rxe device.
>    * The caller should allocate memory for rxe by calling ib_alloc_device.
>    */
> @@ -208,6 +212,7 @@ int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name,
>   {
>   	rxe_init(rxe, ndev);
>   	rxe_set_mtu(rxe, mtu);
> +	rxe->ib_dev.link_ops = &rxe_link_ops;
>   
>   	return rxe_register_device(rxe, ibdev_name, ndev);
>   }
> @@ -231,6 +236,10 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
>   		goto err;
>   	}
>   
> +	err = rxe_net_init(ndev);
> +	if (err)
> +		return err;
> +
>   	err = rxe_net_add(ibdev_name, ndev);
>   	if (err) {
>   		rxe_err("failed to add %s\n", ndev->name);
> @@ -240,9 +249,17 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
>   	return err;
>   }
>   
> +static int rxe_dellink(struct ib_device *dev)
> +{
> +	rxe_net_del(dev);
> +
> +	return 0;
> +}
> +
>   static struct rdma_link_ops rxe_link_ops = {
>   	.type = "rxe",
>   	.newlink = rxe_newlink,
> +	.dellink = rxe_dellink,
>   };
>   
>   static int __init rxe_module_init(void)
> @@ -253,13 +270,20 @@ static int __init rxe_module_init(void)
>   	if (err)
>   		return err;
>   
> -	err = rxe_net_init();
> +	rdma_link_register(&rxe_link_ops);
> +	err = rxe_register_notifier();
>   	if (err) {
> +		pr_err("Failed to register netdev notifier\n");
>   		rxe_destroy_wq();
> -		return err;
> +		return -1;
> +	}
> +
> +	err = rxe_namespace_init();
> +	if (err) {
> +		pr_err("Failed to register net namespace notifier\n");
> +		return -1;
>   	}
>   
> -	rdma_link_register(&rxe_link_ops);
>   	pr_info("loaded\n");
>   	return 0;
>   }
> @@ -271,6 +295,8 @@ static void __exit rxe_module_exit(void)
>   	rxe_net_exit();
>   	rxe_destroy_wq();
>   
> +	rxe_namespace_exit();
> +
>   	pr_info("unloaded\n");
>   }
>   
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 0bd0902b11f7..bf50a298c9ba 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -17,8 +17,7 @@
>   #include "rxe.h"
>   #include "rxe_net.h"
>   #include "rxe_loc.h"
> -
> -static struct rxe_recv_sockets recv_sockets;
> +#include "rxe_ns.h"
>   
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   /*
> @@ -106,7 +105,7 @@ static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
>   					 struct in_addr *daddr)
>   {
>   	struct rtable *rt;
> -	struct flowi4 fl = { { 0 } };
> +	struct flowi4 fl = {};
>   
>   	memset(&fl, 0, sizeof(fl));
>   	fl.flowi4_oif = ndev->ifindex;
> @@ -114,7 +113,7 @@ static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
>   	memcpy(&fl.daddr, daddr, sizeof(*daddr));
>   	fl.flowi4_proto = IPPROTO_UDP;
>   
> -	rt = ip_route_output_key(&init_net, &fl);
> +	rt = ip_route_output_key(dev_net(ndev), &fl);
>   	if (IS_ERR(rt)) {
>   		rxe_dbg_qp(qp, "no route to %pI4\n", &daddr->s_addr);
>   		return NULL;
> @@ -130,7 +129,7 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
>   					 struct in6_addr *daddr)
>   {
>   	struct dst_entry *ndst;
> -	struct flowi6 fl6 = { { 0 } };
> +	struct flowi6 fl6 = {};
>   
>   	memset(&fl6, 0, sizeof(fl6));
>   	fl6.flowi6_oif = ndev->ifindex;
> @@ -138,8 +137,8 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
>   	memcpy(&fl6.daddr, daddr, sizeof(*daddr));
>   	fl6.flowi6_proto = IPPROTO_UDP;
>   
> -	ndst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(recv_sockets.sk6->sk),
> -					       recv_sockets.sk6->sk, &fl6,
> +	ndst = ipv6_stub->ipv6_dst_lookup_flow(dev_net(ndev),
> +					       rxe_ns_pernet_sk6(dev_net(ndev)), &fl6,
>   					       NULL);
>   	if (IS_ERR(ndst)) {
>   		rxe_dbg_qp(qp, "no route to %pI6\n", daddr);
> @@ -624,6 +623,50 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
>   	return 0;
>   }
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
> +	struct sock *sk;
> +	struct rxe_dev *rxe;
> +	struct net_device *ndev;
> +
> +	rxe = container_of(dev, struct rxe_dev, ib_dev);
> +
> +	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
> +	if (!ndev)
> +		return;
> +
> +	sk = rxe_ns_pernet_sk4(dev_net(ndev));
> +	if (!sk)
> +		goto err_out;
> +
> +	rxe_sock_put(sk, rxe_ns_pernet_set_sk4, ndev);
> +
> +	sk = rxe_ns_pernet_sk6(dev_net(ndev));
> +	if (!sk)
> +		goto err_out;
> +
> +	rxe_sock_put(sk, rxe_ns_pernet_set_sk6, ndev);
> +
> +err_out:
> +	dev_put(ndev);
> +}
> +#undef SK_REF_FOR_TUNNEL
> +
>   static void rxe_port_event(struct rxe_dev *rxe,
>   			   enum ib_event_type event)
>   {
> @@ -680,6 +723,7 @@ static int rxe_notify(struct notifier_block *not_blk,
>   	switch (event) {
>   	case NETDEV_UNREGISTER:
>   		ib_unregister_device_queued(&rxe->ib_dev);
> +		rxe_net_del(&rxe->ib_dev);
>   		break;
>   	case NETDEV_CHANGEMTU:
>   		rxe_dbg_dev(rxe, "%s changed mtu to %d\n", ndev->name, ndev->mtu);
> @@ -709,66 +753,92 @@ static struct notifier_block rxe_net_notifier = {
>   	.notifier_call = rxe_notify,
>   };
>   
> -static int rxe_net_ipv4_init(void)
> +static int rxe_net_ipv4_init(struct net_device *ndev)
>   {
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
>   		pr_err("Failed to create IPv4 UDP tunnel\n");
>   		return -1;
>   	}
> +	rxe_ns_pernet_set_sk4(dev_net(ndev), sock->sk);
>   
>   	return 0;
>   }
>   
> -static int rxe_net_ipv6_init(void)
> +static int rxe_net_ipv6_init(struct net_device *ndev)
>   {
>   #if IS_ENABLED(CONFIG_IPV6)
> +	struct sock *sk;
> +	struct socket *sock;
> +
> +	sk = rxe_ns_pernet_sk6(dev_net(ndev));
> +	if (sk) {
> +		sock_hold(sk);
> +		return 0;
> +	}
>   
> -	recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
> -						htons(ROCE_V2_UDP_DPORT), true);
> -	if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT) {
> -		recv_sockets.sk6 = NULL;
> +	sock = rxe_setup_udp_tunnel(dev_net(ndev), htons(ROCE_V2_UDP_DPORT), true);
> +	if (PTR_ERR(sock) == -EAFNOSUPPORT) {
>   		pr_warn("IPv6 is not supported, can not create a UDPv6 socket\n");
>   		return 0;
>   	}
>   
> -	if (IS_ERR(recv_sockets.sk6)) {
> -		recv_sockets.sk6 = NULL;
> +	if (IS_ERR(sock)) {
>   		pr_err("Failed to create IPv6 UDP tunnel\n");
>   		return -1;
>   	}
> +
> +	rxe_ns_pernet_set_sk6(dev_net(ndev), sock->sk);
> +
>   #endif
>   	return 0;
>   }
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
>   void rxe_net_exit(void)
>   {
> -	rxe_release_udp_tunnel(recv_sockets.sk6);
> -	rxe_release_udp_tunnel(recv_sockets.sk4);
>   	unregister_netdevice_notifier(&rxe_net_notifier);
>   }
>   
> -int rxe_net_init(void)
> +int rxe_net_init(struct net_device *ndev)
>   {
>   	int err;
>   
> -	recv_sockets.sk6 = NULL;
> -
> -	err = rxe_net_ipv4_init();
> +	err = rxe_net_ipv4_init(ndev);
>   	if (err)
>   		return err;
> -	err = rxe_net_ipv6_init();
> +
> +	err = rxe_net_ipv6_init(ndev);
>   	if (err)
>   		goto err_out;
> -	err = register_netdevice_notifier(&rxe_net_notifier);
> -	if (err) {
> -		pr_err("Failed to register netdev notifier\n");
> -		goto err_out;
> -	}
> +
>   	return 0;
> +
>   err_out:
> +	/* If ipv6 error, release ipv4 resource */
> +	udp_tunnel_sock_release(rxe_ns_pernet_sk4(dev_net(ndev))->sk_socket);
> +	rxe_ns_pernet_set_sk4(dev_net(ndev), NULL);
>   	rxe_net_exit();
>   	return err;
>   }
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
> index 45d80d00f86b..56249677d692 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.h
> +++ b/drivers/infiniband/sw/rxe/rxe_net.h
> @@ -11,14 +11,11 @@
>   #include <net/if_inet6.h>
>   #include <linux/module.h>
>   
> -struct rxe_recv_sockets {
> -	struct socket *sk4;
> -	struct socket *sk6;
> -};
> -
>   int rxe_net_add(const char *ibdev_name, struct net_device *ndev);
> +void rxe_net_del(struct ib_device *dev);
>   
> -int rxe_net_init(void);
> +int rxe_register_notifier(void);
> +int rxe_net_init(struct net_device *ndev);
>   void rxe_net_exit(void);
>   
>   #endif /* RXE_NET_H */
> diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
> new file mode 100644
> index 000000000000..1ff34167a295
> --- /dev/null
> +++ b/drivers/infiniband/sw/rxe/rxe_ns.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
> + * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
> + */
> +
> +#include <net/sock.h>
> +#include <net/netns/generic.h>
> +#include <net/net_namespace.h>
> +#include <linux/module.h>
> +#include <linux/skbuff.h>
> +#include <linux/pid_namespace.h>
> +#include <net/udp_tunnel.h>
> +
> +#include "rxe_ns.h"
> +
> +/*
> + * Per network namespace data
> + */
> +struct rxe_ns_sock {
> +	struct sock __rcu *rxe_sk4;
> +	struct sock __rcu *rxe_sk6;
> +};
> +
> +/*
> + * Index to store custom data for each network namespace.
> + */
> +static unsigned int rxe_pernet_id;
> +
> +/*
> + * Called for every existing and added network namespaces
> + */
> +static int __net_init rxe_ns_init(struct net *net)
> +{
> +	/*
> +	 * create (if not present) and access data item in network namespace
> +	 * (net) using the id (net_id)
> +	 */
> +	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> +
> +	rcu_assign_pointer(ns_sk->rxe_sk4, NULL); /* initialize sock 4 socket */
> +#if IS_ENABLED(CONFIG_IPV6)
> +	rcu_assign_pointer(ns_sk->rxe_sk6, NULL); /* initialize sock 6 socket */
> +#endif /* IPV6 */
> +	synchronize_rcu();
> +
> +	return 0;
> +}
> +
> +static void __net_exit rxe_ns_exit(struct net *net)
> +{
> +	/*
> +	 * called when the network namespace is removed
> +	 */
> +	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> +	struct sock *rxe_sk4 = NULL;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	struct sock *rxe_sk6 = NULL;
> +#endif
> +
> +	rcu_read_lock();
> +	rxe_sk4 = rcu_dereference(ns_sk->rxe_sk4);
> +#if IS_ENABLED(CONFIG_IPV6)
> +	rxe_sk6 = rcu_dereference(ns_sk->rxe_sk6);
> +#endif
> +	rcu_read_unlock();
> +
> +	/* close socket */
> +	if (rxe_sk4 && rxe_sk4->sk_socket) {
> +		udp_tunnel_sock_release(rxe_sk4->sk_socket);
> +		rcu_assign_pointer(ns_sk->rxe_sk4, NULL);
> +		synchronize_rcu();
> +	}
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +	if (rxe_sk6 && rxe_sk6->sk_socket) {
> +		udp_tunnel_sock_release(rxe_sk6->sk_socket);
> +		rcu_assign_pointer(ns_sk->rxe_sk6, NULL);
> +		synchronize_rcu();
> +	}
> +#endif
> +}
> +
> +/*
> + * callback to make the module network namespace aware
> + */
> +static struct pernet_operations rxe_net_ops __net_initdata = {
> +	.init = rxe_ns_init,
> +	.exit = rxe_ns_exit,
> +	.id = &rxe_pernet_id,
> +	.size = sizeof(struct rxe_ns_sock),
> +};
> +
> +struct sock *rxe_ns_pernet_sk4(struct net *net)
> +{
> +	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> +	struct sock *sk;
> +
> +	rcu_read_lock();
> +	sk = rcu_dereference(ns_sk->rxe_sk4);
> +	rcu_read_unlock();
> +
> +	return sk;
> +}
> +
> +void rxe_ns_pernet_set_sk4(struct net *net, struct sock *sk)
> +{
> +	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> +
> +	rcu_assign_pointer(ns_sk->rxe_sk4, sk);
> +	synchronize_rcu();
> +}
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +struct sock *rxe_ns_pernet_sk6(struct net *net)
> +{
> +	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> +	struct sock *sk;
> +
> +	rcu_read_lock();
> +	sk = rcu_dereference(ns_sk->rxe_sk6);
> +	rcu_read_unlock();
> +
> +	return sk;
> +}
> +
> +void rxe_ns_pernet_set_sk6(struct net *net, struct sock *sk)
> +{
> +	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> +
> +	rcu_assign_pointer(ns_sk->rxe_sk6, sk);
> +	synchronize_rcu();
> +}
> +
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
> +int __init rxe_namespace_init(void)
> +{
> +	return register_pernet_subsys(&rxe_net_ops);
> +}
> +
> +void __exit rxe_namespace_exit(void)
> +{
> +	unregister_pernet_subsys(&rxe_net_ops);
> +}
> diff --git a/drivers/infiniband/sw/rxe/rxe_ns.h b/drivers/infiniband/sw/rxe/rxe_ns.h
> new file mode 100644
> index 000000000000..da5bfcea1274
> --- /dev/null
> +++ b/drivers/infiniband/sw/rxe/rxe_ns.h
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
> + * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
> + */
> +
> +#ifndef RXE_NS_H
> +#define RXE_NS_H
> +
> +struct sock *rxe_ns_pernet_sk4(struct net *net);
> +struct sock *rxe_ns_pernet_sk6(struct net *net);
> +void rxe_ns_pernet_set_sk4(struct net *net, struct sock *sk);
> +void rxe_ns_pernet_set_sk6(struct net *net, struct sock *sk);
> +int __init rxe_namespace_init(void);
> +void __exit rxe_namespace_exit(void);
> +
> +#endif /* RXE_NS_H */
> diff --git a/include/rdma/rdma_netlink.h b/include/rdma/rdma_netlink.h
> index 326deaf56d5d..2fd1358ea57d 100644
> --- a/include/rdma/rdma_netlink.h
> +++ b/include/rdma/rdma_netlink.h
> @@ -5,6 +5,7 @@
>   
>   #include <linux/netlink.h>
>   #include <uapi/rdma/rdma_netlink.h>
> +#include <rdma/ib_verbs.h>
>   
>   struct ib_device;
>   
> @@ -126,6 +127,7 @@ struct rdma_link_ops {
>   	struct list_head list;
>   	const char *type;
>   	int (*newlink)(const char *ibdev_name, struct net_device *ndev);
> +	int (*dellink)(struct ib_device *dev);
>   };
>   
>   void rdma_link_register(struct rdma_link_ops *ops);


