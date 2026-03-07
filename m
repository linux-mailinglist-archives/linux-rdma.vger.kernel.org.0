Return-Path: <linux-rdma+bounces-17678-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FJ8FD7bq2luhQEAu9opvQ
	(envelope-from <linux-rdma+bounces-17678-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 09:01:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B611622AB28
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 09:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5A4B302D129
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Mar 2026 08:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C688636BCE6;
	Sat,  7 Mar 2026 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V8VpVYha"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6CC33A9FF
	for <linux-rdma@vger.kernel.org>; Sat,  7 Mar 2026 08:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772870458; cv=none; b=eVNc9jGxoPId4QBt+cMrJ9biQ1IxBoytiok6UbZzCKs6sFLkoLpWwiuV3ldeSRlb2cw9Q6RGuMjv6FUhNANNjfXIGcBWkmyXBC6yfo8sEYnI1xywNW0XijcsLoeB3o43UE160CjrqJUxqbE0YyTelg7dgg5H3V4MsnP0e+Cd0vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772870458; c=relaxed/simple;
	bh=amTi6mhncQFgZhdX+ghT4i9cJ+tUuHa1bTB59MtKUmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ThzKR55iNj2A4Pch2ow7DLmCME5xHJWPPxk5Hj/cV4pi6Cna629yU9dryyi0xG+jMJTGC/HhbGHC7WjPd4p837/d8Fr36oxPH4MNHEGdFzFIyA/SvVR6XxESfnP8c4x11fP9eqqIECg/xh8Zqmkg7pbxCSq/pK2CBIsjfdFB6Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V8VpVYha; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b90e3a90-7a88-449b-915a-83a662656c90@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772870453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XinBd3kl2KEQLcCa959/LqwGyRy8pHn8Guj+4yi4ETE=;
	b=V8VpVYhaFO1c9IVYU3Q6WN0RNnXVGyanTE2F2bhkjgYlQxzILKuHdOBO9/g4xX6Ourzo4J
	DuwTEdQxkN2edT9N+FJm9WjyXFZ0/uPlHm8PNWVncwyrYYzhxpTVgjA/0r9xaIlh9PXkKO
	TgSzNgmhc85grXBh1CnH65OhghKEkv4=
Date: Sat, 7 Mar 2026 00:00:49 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] RDMA/rxe: Add net namespace support for IPv4/IPv6
 sockets
To: David Ahern <dsahern@kernel.org>, jgg@ziepe.ca, leon@kernel.org,
 zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "yanjun.zhu@linux.dev"
 <yanjun.zhu@linux.dev>
References: <20260306082452.1822-1-yanjun.zhu@linux.dev>
 <20260306082452.1822-4-yanjun.zhu@linux.dev>
 <03ece7a0-7fe7-45bd-9baf-d88d689bc578@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <03ece7a0-7fe7-45bd-9baf-d88d689bc578@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: B611622AB28
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
	TAGGED_FROM(0.00)[bounces-17678-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,gmail.com,vger.kernel.org,linux.dev];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.918];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action


在 2026/3/6 17:10, David Ahern 写道:
> On 3/6/26 1:24 AM, Zhu Yanjun wrote:
>> diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
>> new file mode 100644
>> index 000000000000..29d08899dcda
>> --- /dev/null
>> +++ b/drivers/infiniband/sw/rxe/rxe_ns.c
>> @@ -0,0 +1,134 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>> +/*
>> + * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>> + * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>> + */
>> +
>> +#include <net/sock.h>
>> +#include <net/netns/generic.h>
>> +#include <net/net_namespace.h>
>> +#include <linux/module.h>
>> +#include <linux/skbuff.h>
>> +#include <linux/pid_namespace.h>
>> +#include <net/udp_tunnel.h>
>> +
>> +#include "rxe_ns.h"
>> +
>> +/*
>> + * Per network namespace data
>> + */
>> +struct rxe_ns_sock {
>> +	struct sock __rcu *rxe_sk4;
>> +	struct sock __rcu *rxe_sk6;
>> +};
>> +
>> +/*
>> + * Index to store custom data for each network namespace.
>> + */
>> +static unsigned int rxe_pernet_id;
>> +
>> +/*
>> + * Called for every existing and added network namespaces
>> + */
>> +static int __net_init rxe_ns_init(struct net *net)
>> +{
>> +	/*
>> +	 * create (if not present) and access data item in network namespace
>> +	 * (net) using the id (net_id)
>> +	 */
> this comment is not needed; does not really convey anything useful. I
> would like this function to have the comment from my patch:
>
> 	/* defer socket create in the namespace to the first
> 	 * device create.
> 	 */
>
> this makes it clear why init and exit are not symmetrical.
>
>> +	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
>> +
>> +	rcu_assign_pointer(ns_sk->rxe_sk4, NULL); /* initialize sock 4 socket */
>> +	rcu_assign_pointer(ns_sk->rxe_sk6, NULL); /* initialize sock 6 socket */
>> +	synchronize_rcu();
> I believe the core network namespace code ensures the memory is
> initialized, so this is not needed.
>
>> +
>> +	return 0;
>> +}
>> +
>> +static void __net_exit rxe_ns_exit(struct net *net)
>> +{
>> +	/*
>> +	 * called when the network namespace is removed
>> +	 */
>> +	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
>> +	struct sock *rxe_sk4 = NULL;
>> +	struct sock *rxe_sk6 = NULL;
> initialization is not needed since both are set before use.
>
>> +
>> +	rcu_read_lock();
>> +	rxe_sk4 = rcu_dereference(ns_sk->rxe_sk4);
>> +	rxe_sk6 = rcu_dereference(ns_sk->rxe_sk6);
>> +	rcu_read_unlock();
>> +
>> +	/* close socket */
>> +	if (rxe_sk4 && rxe_sk4->sk_socket) {
> how can rxe_sk4 be non-NULL and yet sk_socket become NULL?
>
>> +		udp_tunnel_sock_release(rxe_sk4->sk_socket);
>> +		rcu_assign_pointer(ns_sk->rxe_sk4, NULL);
> if you flip the order
>
> 		rcu_assign_pointer(ns_sk->rxe_sk4, NULL);
> 		/* udp_tunnel_sock_release calls synchronize_rcu */
> 		udp_tunnel_sock_release(rxe_sk4->sk_socket);
>
>
> you should be able to drop the synchronize_rcu here:
>
>> +		synchronize_rcu();
>> +	}
>> +
>> +	if (rxe_sk6 && rxe_sk6->sk_socket) {
> same here.

All the mentioned problems are fix in the latest commit.

Zhu Yanjun

>
>> +		udp_tunnel_sock_release(rxe_sk6->sk_socket);
>> +		rcu_assign_pointer(ns_sk->rxe_sk6, NULL);
>> +		synchronize_rcu();> +	}
>> +}
>> +

-- 
Best Regards,
Yanjun.Zhu


