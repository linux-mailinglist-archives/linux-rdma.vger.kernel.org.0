Return-Path: <linux-rdma+bounces-17183-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IefABg8n2kiZgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17183-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 19:14:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5389319C190
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 19:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A56F30071DE
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 18:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B600C2DECA1;
	Wed, 25 Feb 2026 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KDFtmg/B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA8C2EAD15
	for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772043284; cv=none; b=PkibOKEMFWU8I0mDmPLc7Z8gTyLiM0CMoRVuNLlIzSmIsun40ES2/cjIa3ECpyS+W/IuFHu3G7M7GSCWfVXsbM8Czq91K30cMr9GIxwWGOVEpEuJ3UIRYwTwF476zew+ZinRaYVTHPoTg4s9Qh15dorzdRPfKV6HiTpuYtHjnXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772043284; c=relaxed/simple;
	bh=MrD5JWCoKgrZEtuytnuYIaEGW+mGZ6XYf2/poO7StGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mvp5edC+cfFWJ2MwYuuCEJFMYt8U5Kz247rDhnTT8BIw3p14/4TU9GjCZqJBwl1gwsrXBDje3moZ7lG+mzFjw2fceLYcHq9dxZ86IBXgmNIDUMEWovqop2bYiUMYmS6yCqlwezYfn94pefIjRYSKLbDvuc1u/hlil1OwMbQQbD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KDFtmg/B; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e87e7871-d35e-4b91-a00f-1491ac5b6dab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772043281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G8Z3EADJNI8Fpu8W09URwtWOWyeWv9QLmJHGpSN8L6M=;
	b=KDFtmg/BiQDfihd+K4FbM+jzAwfLJ5lJGZaG/jNEJxQDjw/Mw8xxXrdgddYeq8K7hmtU8K
	YSrNsDgrYwaN4xj95f3/jvhs9EjY5qH8soGE6jE1w91PAu2i1G9phA2RrXTRwIf4+xEFiD
	RNshVwknfl73q8nX4kDM012TrbL34IA=
Date: Wed, 25 Feb 2026 10:14:37 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Add network namespace support
To: David Ahern <dsahern@kernel.org>, zyjzyj2000@gmail.com, jgg@ziepe.ca,
 leon@kernel.org
Cc: linux-rdma@vger.kernel.org
References: <20260225172622.7589-1-dsahern@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260225172622.7589-1-dsahern@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17183-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 5389319C190
X-Rspamd-Action: no action

On 2/25/26 9:26 AM, David Ahern wrote:
> Allow rxe to work across network namespaces by making the sockets
> per namespace using net_generic. Defer socket initialization until
> a device is created in the namespace.

https://github.com/zhuyj/linux/tree/upstream/6.14-net-namespace

Do you make tests with the above link?

Compared with the net namespace in the above link, what is the 
difference between this commit and the above link?

Thanks a lot.
Yanjun.Zhu

> 
> Signed-off-by: David Ahern <dsahern@kernel.org>
> ---
>   drivers/infiniband/sw/rxe/rxe_net.c | 123 ++++++++++++++++++++--------
>   1 file changed, 88 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 0bd0902b11f7..f51afc38c9df 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -18,7 +18,10 @@
>   #include "rxe_net.h"
>   #include "rxe_loc.h"
>   
> -static struct rxe_recv_sockets recv_sockets;
> +static int __rxe_netns_init(struct net *net,
> +			    struct rxe_recv_sockets *sockets);
> +
> +static unsigned int rxe_net_id;
>   
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   /*
> @@ -105,6 +108,7 @@ static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
>   					 struct in_addr *saddr,
>   					 struct in_addr *daddr)
>   {
> +	struct net *net = dev_net(ndev);
>   	struct rtable *rt;
>   	struct flowi4 fl = { { 0 } };
>   
> @@ -114,7 +118,7 @@ static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
>   	memcpy(&fl.daddr, daddr, sizeof(*daddr));
>   	fl.flowi4_proto = IPPROTO_UDP;
>   
> -	rt = ip_route_output_key(&init_net, &fl);
> +	rt = ip_route_output_key(net, &fl);
>   	if (IS_ERR(rt)) {
>   		rxe_dbg_qp(qp, "no route to %pI4\n", &daddr->s_addr);
>   		return NULL;
> @@ -129,6 +133,8 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
>   					 struct in6_addr *saddr,
>   					 struct in6_addr *daddr)
>   {
> +	struct net *net = dev_net(ndev);
> +	struct rxe_recv_sockets *recv_socket = net_generic(net, rxe_net_id);
>   	struct dst_entry *ndst;
>   	struct flowi6 fl6 = { { 0 } };
>   
> @@ -138,9 +144,8 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
>   	memcpy(&fl6.daddr, daddr, sizeof(*daddr));
>   	fl6.flowi6_proto = IPPROTO_UDP;
>   
> -	ndst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(recv_sockets.sk6->sk),
> -					       recv_sockets.sk6->sk, &fl6,
> -					       NULL);
> +	ndst = ipv6_stub->ipv6_dst_lookup_flow(net, recv_socket->sk6->sk,
> +					       &fl6, NULL);
>   	if (IS_ERR(ndst)) {
>   		rxe_dbg_qp(qp, "no route to %pI6\n", daddr);
>   		return NULL;
> @@ -606,8 +611,16 @@ const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num)
>   
>   int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
>   {
> -	int err;
> +	struct net *net = dev_net(ndev);
> +	struct rxe_recv_sockets *sockets = net_generic(net, rxe_net_id);
>   	struct rxe_dev *rxe = NULL;
> +	int err;
> +
> +	if (!sockets->sk4) {
> +		err = __rxe_netns_init(net, sockets);
> +		if (err)
> +			return err;
> +	}
>   
>   	rxe = ib_alloc_device(rxe_dev, ib_dev);
>   	if (!rxe)
> @@ -709,12 +722,13 @@ static struct notifier_block rxe_net_notifier = {
>   	.notifier_call = rxe_notify,
>   };
>   
> -static int rxe_net_ipv4_init(void)
> +static int rxe_net_ipv4_init(struct net *net,
> +			     struct rxe_recv_sockets *sockets)
>   {
> -	recv_sockets.sk4 = rxe_setup_udp_tunnel(&init_net,
> -				htons(ROCE_V2_UDP_DPORT), false);
> -	if (IS_ERR(recv_sockets.sk4)) {
> -		recv_sockets.sk4 = NULL;
> +	sockets->sk4 = rxe_setup_udp_tunnel(net, htons(ROCE_V2_UDP_DPORT),
> +					    false);
> +	if (IS_ERR(sockets->sk4)) {
> +		sockets->sk4 = NULL;
>   		pr_err("Failed to create IPv4 UDP tunnel\n");
>   		return -1;
>   	}
> @@ -722,31 +736,74 @@ static int rxe_net_ipv4_init(void)
>   	return 0;
>   }
>   
> -static int rxe_net_ipv6_init(void)
> -{
>   #if IS_ENABLED(CONFIG_IPV6)
> -
> -	recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
> -						htons(ROCE_V2_UDP_DPORT), true);
> -	if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT) {
> -		recv_sockets.sk6 = NULL;
> -		pr_warn("IPv6 is not supported, can not create a UDPv6 socket\n");
> -		return 0;
> -	}
> -
> -	if (IS_ERR(recv_sockets.sk6)) {
> -		recv_sockets.sk6 = NULL;
> +static int rxe_net_ipv6_init(struct net *net,
> +			     struct rxe_recv_sockets *sockets)
> +{
> +	sockets->sk6 = rxe_setup_udp_tunnel(net, htons(ROCE_V2_UDP_DPORT),
> +					    true);
> +	if (IS_ERR(sockets->sk6)) {
> +		sockets->sk6 = NULL;
>   		pr_err("Failed to create IPv6 UDP tunnel\n");
>   		return -1;
>   	}
> +	return 0;
> +}
> +#endif
> +
> +/* Initialize per network namespace state */
> +static int __rxe_netns_init(struct net *net,
> +			    struct rxe_recv_sockets *sockets)
> +{
> +	int err;
> +
> +	err = rxe_net_ipv4_init(net, sockets);
> +	if (err)
> +		return err;
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +	err = rxe_net_ipv6_init(net, sockets);
> +	if (err) {
> +		rxe_release_udp_tunnel(sockets->sk4);
> +		return err;
> +	}
>   #endif
> +
> +	return 0;
> +}
> +
> +static int __net_init rxe_netns_init(struct net *net)
> +{
> +	/* defer socket create in the namespace to the first
> +	 * device create.
> +	 */
>   	return 0;
>   }
>   
> +static void __net_exit rxe_netns_exit(struct net *net)
> +{
> +	struct rxe_recv_sockets *sockets;
> +
> +	sockets = net_generic(net, rxe_net_id);
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +	if (sockets->sk6)
> +		rxe_release_udp_tunnel(sockets->sk6);
> +#endif
> +	if (sockets->sk4)
> +		rxe_release_udp_tunnel(sockets->sk4);
> +}
> +
> +static struct pernet_operations rxe_net_ops __net_initdata = {
> +	.init = rxe_netns_init,
> +	.exit = rxe_netns_exit,
> +	.id   = &rxe_net_id,
> +	.size = sizeof(struct rxe_recv_sockets),
> +};
> +
>   void rxe_net_exit(void)
>   {
> -	rxe_release_udp_tunnel(recv_sockets.sk6);
> -	rxe_release_udp_tunnel(recv_sockets.sk4);
> +	unregister_pernet_device(&rxe_net_ops);
>   	unregister_netdevice_notifier(&rxe_net_notifier);
>   }
>   
> @@ -754,21 +811,17 @@ int rxe_net_init(void)
>   {
>   	int err;
>   
> -	recv_sockets.sk6 = NULL;
> -
> -	err = rxe_net_ipv4_init();
> -	if (err)
> -		return err;
> -	err = rxe_net_ipv6_init();
> -	if (err)
> -		goto err_out;
>   	err = register_netdevice_notifier(&rxe_net_notifier);
>   	if (err) {
>   		pr_err("Failed to register netdev notifier\n");
>   		goto err_out;
>   	}
> +	err = register_pernet_device(&rxe_net_ops);
> +	if (err)
> +		goto err_out;
> +
>   	return 0;
>   err_out:
> -	rxe_net_exit();
> +	unregister_netdevice_notifier(&rxe_net_notifier);
>   	return err;
>   }


