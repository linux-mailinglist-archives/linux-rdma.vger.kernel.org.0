Return-Path: <linux-rdma+bounces-19550-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLuNHogx7Wk2ggAAu9opvQ
	(envelope-from <linux-rdma+bounces-19550-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 23:26:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81191467D69
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 23:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A2F693002503
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 21:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C943830F540;
	Sat, 25 Apr 2026 21:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bfx9Lx0n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3724213B293
	for <linux-rdma@vger.kernel.org>; Sat, 25 Apr 2026 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777152386; cv=none; b=qXynWoF9ACD3VT5jzGILNqbfqbhLh2M85f/GS2NaC2IVpBm3suyE0vu250OQGG1on8DIIKVkFQ3kC7szogGtuOZmdKRjIZV3GuceuO6QijmjVOudsbckHZ7wL0qc/lsFROKosP61sTNcjgngRGnYwcNti0sJrZ5rUT38brEQ0YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777152386; c=relaxed/simple;
	bh=rDo7TCcKOMAk2ZEAYFvhLSyqxC9eL79oVveq31OTLY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pCxbzIjV5Rq/L6EnSEBk+mbqJv3dLMRGnoxbYbHaH/nXm2CDd5sfTcW3dzvKMfFT9WRZWvIkCLco115ZrFm6m2pTtBSo2jd9YNZ6tJTnDa974XKoRun+0KERaA4mYrlUap9cdhI5c3hE+ncVgl2iAYn+94FyWt1N7dsPOuqHnRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bfx9Lx0n; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8153a0c3-0360-4a35-9c8f-c05ea3d9a2f8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777152383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tj2QtjldEqtx56dJAhX9z+HqhX/zF9msZEU/uMcPI/w=;
	b=bfx9Lx0nAfb6NwrjAyKlOUtTrjs2+Kfcl6cKcMjsnt0NCRf6LQ8SGzXDCxga1hjkH30u96
	x3H8EH74sTedRKrZWlimlyeBm+dMOWluPNEoqNCHOy1iAOV0i38rLnh5Nzolit54c4VL0t
	7o/+3EnsBrNLYqFvskmTin+6kRSkQXA=
Date: Sat, 25 Apr 2026 14:26:11 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] RDMA/rxe: Fix up RCU usage for
 rxe_ns_pernet_sk6().
To: Kuniyuki Iwashima <kuniyu@google.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 linux-rdma@vger.kernel.org
References: <20260425060436.2316620-1-kuniyu@google.com>
 <20260425060436.2316620-3-kuniyu@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260425060436.2316620-3-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 81191467D69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19550-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,gmail.com,ziepe.ca,kernel.org,linux.dev];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

在 2026/4/24 23:04, Kuniyuki Iwashima 写道:
> rxe_ns_pernet_sk6() is fundamentally broken.
> 
> rcu_read_lock() only silences rcu_dereference() splat.
> 
> The returned socket is no longer protected, and it may be
> freed during ip6_dst_lookup_flow().
> 
> Let's call rxe_ns_pernet_sk6() and ip6_dst_lookup_flow()
> under RCU.
> 
> Fixes: f1327abd6abe ("RDMA/rxe: Support RDMA link creation and destruction per net namespace")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks a lot. Please David Ahern, Leon and Jason comment.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
>   drivers/infiniband/sw/rxe/rxe_net.c | 11 ++++++++---
>   drivers/infiniband/sw/rxe/rxe_ns.c  |  7 +------
>   2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 9080d4c893a1..8fca5c24c8b1 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -133,16 +133,21 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
>   					 struct in6_addr *saddr,
>   					 struct in6_addr *daddr)
>   {
> -	struct dst_entry *ndst;
> +	struct dst_entry *ndst = NULL;
>   	struct flowi6 fl6 = {};
> +	struct sock *sk;
>   
>   	fl6.flowi6_oif = ndev->ifindex;
>   	memcpy(&fl6.saddr, saddr, sizeof(*saddr));
>   	memcpy(&fl6.daddr, daddr, sizeof(*daddr));
>   	fl6.flowi6_proto = IPPROTO_UDP;
>   
> -	ndst = ip6_dst_lookup_flow(net, rxe_ns_pernet_sk6(net), &fl6, NULL);
> -	if (IS_ERR(ndst)) {
> +	rcu_read_lock();
> +	sk = rxe_ns_pernet_sk6(net);
> +	if (sk)
> +		ndst = ip6_dst_lookup_flow(net, sk, &fl6, NULL);
> +	rcu_read_unlock();
> +	if (IS_ERR_OR_NULL(ndst)) {
>   		rxe_dbg_qp(qp, "no route to %pI6\n", daddr);
>   		return NULL;
>   	}
> diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
> index 06eb2e2387a1..ef408ffc0558 100644
> --- a/drivers/infiniband/sw/rxe/rxe_ns.c
> +++ b/drivers/infiniband/sw/rxe/rxe_ns.c
> @@ -91,13 +91,8 @@ static struct pernet_operations rxe_net_ops = {
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
> +	return rcu_dereference(ns_sk->rxe_sk6);
>   }
>   #endif /* IPV6 */
>   


