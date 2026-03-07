Return-Path: <linux-rdma+bounces-17647-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFBlHZx7q2kSdgEAu9opvQ
	(envelope-from <linux-rdma+bounces-17647-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 02:13:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BD7229493
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 02:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E64F3125D63
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Mar 2026 01:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053A028640C;
	Sat,  7 Mar 2026 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDvs1Z8Z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9A91EB5E1;
	Sat,  7 Mar 2026 01:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772845836; cv=none; b=tsCfzd0HduhhUQZi8UV+ZGf5eJBv3uMqEYEHQtQ41TwDazUuP61mRaDwQ0/mY9rHrJpGU9/BR+ai0dee2+yz8oyoedFXW74FDc+JV7suh02jlNCoSIJ7gMQgI04Exx8YqJNvcxZfIpfwsEnE728BxL9mdUugw7Uc7wCwqTGj8Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772845836; c=relaxed/simple;
	bh=3iaei9bVBAtKvEd4+inanOjqfkrS1bm+nh8LqYogL+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=np3Rv0H9fvUlm9GCYOOw7w4jPBwB9GjaGBw62PvEjW1IR2zxn/gPmnii22q1nlDzUxF4+X2NjR81JXYvf4tLD3wkSV6ZDwWEG2JqNIYZYfSogVwChQhk0iRvkzk0JMSVgHQQc95KQ2e2eGZpeiPBuy7k5bPfVoNzdou10gjRyGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDvs1Z8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2150BC4CEF7;
	Sat,  7 Mar 2026 01:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772845836;
	bh=3iaei9bVBAtKvEd4+inanOjqfkrS1bm+nh8LqYogL+o=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=tDvs1Z8ZhLjWis0X6VIYT0r+ifRaYuyTaBhLkG1mJo696Aps2mEPYY5cTnuXCQzzi
	 8OHPHAlx1xpQkmvXDPu0V831mBmcbizi6ywY4Np6Tp29QuFY22cJBgFynKpqY4uIj+
	 VID9O21YBSdu46eGXdu3DwCKMViHLao/6SH6Vsi7A1TAkYW078iIzdPfXZbmk61hkS
	 Y9+JHvAyb7HGjpotOiP8v3kR2lXojSJBQ2ZdhUvlYHPbnluZLoM5FF9vJOpiDabyjX
	 fXsslZQvaz/svoby1KMzbEYV7ExZhs1qH8Ht05tSc4U0+YDqFH2eA90/CvnT8pwG6U
	 fadXX4eUPQ70Q==
Message-ID: <03ece7a0-7fe7-45bd-9baf-d88d689bc578@kernel.org>
Date: Fri, 6 Mar 2026 18:10:35 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] RDMA/rxe: Add net namespace support for IPv4/IPv6
 sockets
Content-Language: en-US
To: Zhu Yanjun <yanjun.zhu@linux.dev>, jgg@ziepe.ca, leon@kernel.org,
 zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260306082452.1822-1-yanjun.zhu@linux.dev>
 <20260306082452.1822-4-yanjun.zhu@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260306082452.1822-4-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E4BD7229493
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,ziepe.ca,kernel.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17647-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.931];
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
> diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
> new file mode 100644
> index 000000000000..29d08899dcda
> --- /dev/null
> +++ b/drivers/infiniband/sw/rxe/rxe_ns.c
> @@ -0,0 +1,134 @@
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

this comment is not needed; does not really convey anything useful. I
would like this function to have the comment from my patch:

	/* defer socket create in the namespace to the first
	 * device create.
	 */

this makes it clear why init and exit are not symmetrical.

> +	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> +
> +	rcu_assign_pointer(ns_sk->rxe_sk4, NULL); /* initialize sock 4 socket */
> +	rcu_assign_pointer(ns_sk->rxe_sk6, NULL); /* initialize sock 6 socket */
> +	synchronize_rcu();

I believe the core network namespace code ensures the memory is
initialized, so this is not needed.

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
> +	struct sock *rxe_sk6 = NULL;

initialization is not needed since both are set before use.

> +
> +	rcu_read_lock();
> +	rxe_sk4 = rcu_dereference(ns_sk->rxe_sk4);
> +	rxe_sk6 = rcu_dereference(ns_sk->rxe_sk6);
> +	rcu_read_unlock();
> +
> +	/* close socket */
> +	if (rxe_sk4 && rxe_sk4->sk_socket) {

how can rxe_sk4 be non-NULL and yet sk_socket become NULL?

> +		udp_tunnel_sock_release(rxe_sk4->sk_socket);
> +		rcu_assign_pointer(ns_sk->rxe_sk4, NULL);

if you flip the order

		rcu_assign_pointer(ns_sk->rxe_sk4, NULL);
		/* udp_tunnel_sock_release calls synchronize_rcu */
		udp_tunnel_sock_release(rxe_sk4->sk_socket);


you should be able to drop the synchronize_rcu here:

> +		synchronize_rcu();

> +	}
> +
> +	if (rxe_sk6 && rxe_sk6->sk_socket) {

same here.

> +		udp_tunnel_sock_release(rxe_sk6->sk_socket);
> +		rcu_assign_pointer(ns_sk->rxe_sk6, NULL);
> +		synchronize_rcu();> +	}
> +}
> +


