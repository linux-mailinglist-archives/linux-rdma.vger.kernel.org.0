Return-Path: <linux-rdma+bounces-17733-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id juo2EMb9rWkE+gEAu9opvQ
	(envelope-from <linux-rdma+bounces-17733-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 23:52:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B55232912
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 23:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92E8C300D45C
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 22:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8D526ED33;
	Sun,  8 Mar 2026 22:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DT230Rdl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9169C1DFE22
	for <linux-rdma@vger.kernel.org>; Sun,  8 Mar 2026 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773010369; cv=none; b=fwod+eTEBrmGtz8mDafzVWH5Xj1HY5dM1VkVwslCgTLSwfP5VLyF1b/TbL4dikp280F2Gv82iADfgICBphMpVALRZqyUzE7VPAoQ/uSVHRHKtDkfqKzvDm8nM6LGP119F9VBQBnNOtYVKs2EOnU23BI08ksYB2EcT/xrnsx0k00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773010369; c=relaxed/simple;
	bh=P+bgkTw+a2zP1s2i0MZr18U6HdzpsVEC6MFNdvqcrA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OCXw1hiol9qfv6whckuiqjqCZ7tGmG/uC6BFqFxICab8qMzZzigEAeTIQWiIdVU3AQMWlazTTv7mg3DM6paaY/en733bVZrvtSAMvowk9fPIbIat33fMqgWroPWxW5Mle843mOuPzPzVIV3qHaYDc4fDSekz/7pmWYF3KVfnpWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DT230Rdl; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fb3060c3-0378-44f2-afeb-6ee7a24220b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773010364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WINWFAJm5CYYeZ29OBY1NfUcqnihU4QPKkSkFaso8Rk=;
	b=DT230RdlyH65K1EK4bH4vbRRE120sHbJZD8DKfFI4Xl1IXP9oURmo9B329yV4d+69lqXpu
	iaHd7bWMzTIBBWivPGhpNmAU7ByIBuygsDhvgFHOfYQB5IP9niN+UDGTN4MeHNhUNiIjPM
	gIooSb4d6ogRykyZbHqozL0+X+wtEsg=
Date: Sun, 8 Mar 2026 15:52:38 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/4] RDMA/rxe: Add net namespace support for IPv4/IPv6
 sockets
To: David Ahern <dsahern@kernel.org>, jgg@ziepe.ca, leon@kernel.org,
 zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260308074711.24114-1-yanjun.zhu@linux.dev>
 <20260308074711.24114-3-yanjun.zhu@linux.dev>
 <99e6f2c5-b039-4d47-8674-7d89a83fa849@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <99e6f2c5-b039-4d47-8674-7d89a83fa849@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 30B55232912
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17733-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.936];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


在 2026/3/8 10:44, David Ahern 写道:
> On 3/8/26 12:47 AM, Zhu Yanjun wrote:
>> +/*
>> + * Called for every existing and added network namespaces
>> + */
>> +static int __net_init rxe_ns_init(struct net *net)
>> +{
>> +	/*
>> +	 * create (if not present) and access data item in network namespace
>> +	 * (net) using the id (net_id)
>> +	 */
>> +	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
>> +
>> +	rcu_assign_pointer(ns_sk->rxe_sk4, NULL); /* initialize sock 4 socket */
>> +	rcu_assign_pointer(ns_sk->rxe_sk6, NULL); /* initialize sock 6 socket */
>> +	synchronize_rcu();
> As I stated in the last review, this is init is not needded. drop it.
>
> See the net/core/net_namespace.c:
>
> static int ops_init(const struct pernet_operations *ops, struct net *net)
> {
>          struct net_generic *ng;
>          int err = -ENOMEM;
>          void *data = NULL;
>
>          if (ops->id) {
>                  data = kzalloc(ops->size, GFP_KERNEL);
>                  if (!data)
>                          goto out;
>
>                  err = net_assign_generic(net, *ops->id, data);
>                  if (err)
>                          goto cleanup;
>          }
>
> from there the request is to add a comment about deferred socket created
> to explain why _init and _exit are assymetrical.
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
> again, init is not needed. They are set below before use.
>
> I am beginning to think you dropped my review comments from the last
> round ....
>
>> +
>> +	rcu_read_lock();
>> +	rxe_sk4 = rcu_dereference(ns_sk->rxe_sk4);
>> +	rxe_sk6 = rcu_dereference(ns_sk->rxe_sk6);
>> +	rcu_read_unlock();
>> +
>> +	/* close socket */
>> +	if (rxe_sk4 && rxe_sk4->sk_socket) {
>> +		udp_tunnel_sock_release(rxe_sk4->sk_socket);
>> +		rcu_assign_pointer(ns_sk->rxe_sk4, NULL);
>> +		synchronize_rcu();
> yea, I commented on this too.
>
> I am not wasting any more time on this version. Either address my
> comments from v1 or explain why you should not in that email.

Hi, David

All the above changes are included in "[PATCH v3 3/4] RDMA/rxe: Support 
RDMA link creation and destruction per net namespace".

Please let me know if you have any further comments on "[PATCH v3 3/4] 
RDMA/rxe: Support RDMA link creation and destruction per net namespace".

If there are no additional comments, I plan to move these changes into 
"[PATCH v3 2/4] RDMA/rxe: Add net namespace support for IPv4/IPv6 
sockets" and send out a new version of the patch series.

Thanks a lot.

Zhu Yanjun

-- 
Best Regards,
Yanjun.Zhu


